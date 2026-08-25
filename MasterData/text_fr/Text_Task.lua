__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Task = readonly({
  Task_100331_Desc = {
    Text = "Obtenez 1 victoire cette saiso"
  },
  Task_100331_Name = {Text = "1 Victoire"},
  Task_100332_Desc = {
    Text = "Obtenez 10 victoires cette saiso"
  },
  Task_100332_Name = {
    Text = "10 Victoires"
  },
  Task_100333_Desc = {
    Text = "Obtenez un total de 6 victoires cette saiso"
  },
  Task_100333_Name = {
    Text = "6 victoires"
  },
  Task_100334_Desc = {
    Text = "Obtenez un total de 3 victoires cette saiso"
  },
  Task_100334_Name = {
    Text = "3 Victoires"
  },
  Task_100523_Desc = {
    Text = "Terminer Le vagabond « Peinture de l'aberration »"
  },
  Task_100523_Name = {
    Text = "Rêverie du monde réel"
  },
  Task_100576_Desc = {
    Text = "Chaque fois que vous vivez 1 tour de combat, la note d'enquête diminue de 20 points."
  },
  Task_100576_Name = {
    Text = "Sablier temporel<size=20><color=#747474>Chaque expérience d'un tour de combat réduit le score d'enquête de 20 points</color></size>"
  },
  Task_10143_Desc = {
    Text = "Terminé en 72 tours au total"
  },
  Task_10143_Name = {
    Text = "Terminé en 72 tours au total"
  },
  Task_10144_Desc = {
    Text = "Vaincre en 79 tours"
  },
  Task_10144_Name = {
    Text = "Vaincre en 79 tours"
  },
  Task_10145_Desc = {
    Text = "Complète le niveau en 40 étapes."
  },
  Task_10145_Name = {
    Text = "Planification stratégique"
  },
  Task_10146_Desc = {
    Text = "Avoir pas plus de 1 Symptôme lors de l'achèvement"
  },
  Task_10146_Name = {Text = "Refreshing"},
  Task_10147_Desc = {
    Text = "Avoir pas plus de 1 Symptôme lors de l'achèvement"
  },
  Task_10147_Name = {Text = "Refreshing"},
  Task_10148_Desc = {
    Text = "Vaincre en 31 tours"
  },
  Task_10148_Name = {
    Text = "Vaincre en 31 tours"
  },
  Task_10149_Desc = {
    Text = "Complétez dans les 40 tours"
  },
  Task_10149_Name = {
    Text = "Complétez dans les 40 tours"
  },
  Task_10150_Desc = {
    Text = "Vaincre en 47 tours"
  },
  Task_10150_Name = {
    Text = "Vaincre en 47 tours"
  },
  Task_10151_Desc = {
    Text = "Vaincre en un total de 58 tours"
  },
  Task_10151_Name = {
    Text = "Vaincre en un total de 58 tours"
  },
  Task_10152_Desc = {
    Text = "Vaincre en 65 tours"
  },
  Task_10152_Name = {
    Text = "Vaincre en 65 tours"
  },
  Task_10153_Desc = {
    Text = "Éliminer les Monstres de Dissolution"
  },
  Task_10153_Name = {Text = "Objectif"},
  Task_10154_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10154_Name = {
    Text = "Passer Parfait"
  },
  Task_10155_Desc = {
    Text = "Clair le niveau en 18 coups."
  },
  Task_10155_Name = {
    Text = "Planification stratégique"
  },
  Task_10156_Desc = {
    Text = "Avoir pas plus de 3 Symptômes lors de l'achèvement"
  },
  Task_10156_Name = {Text = "Refreshing"},
  Task_10157_Desc = {
    Text = "Avoir au moins 100 Sigils Noirs lors de l'achèvement."
  },
  Task_10157_Name = {
    Text = "Sauvegarder pour plus tard"
  },
  Task_10158_Desc = {
    Text = "Complétez la scène avec au moins 2 Réveilleurs de Chaos"
  },
  Task_10158_Name = {
    Text = "Ascension dans le chaos"
  },
  Task_10159_Desc = {
    Text = "Gagner la Bataille Finale en moins de 8 tours"
  },
  Task_10159_Name = {
    Text = "Résolution rapide"
  },
  Task_10160_Desc = {
    Text = "Avoir au moins 2 Reliques lors de l'achèvement"
  },
  Task_10160_Name = {
    Text = "Pouvoir des reliques"
  },
  Task_10161_Desc = {
    Text = "Complétez la scène avec au moins 2 Réveilleurs de Chaos"
  },
  Task_10161_Name = {
    Text = "Ascension dans le chaos"
  },
  Task_10162_Desc = {
    Text = "Réveillez tous les Réveilleurs à l'achèvement"
  },
  Task_10162_Name = {
    Text = "Dernière arrivée"
  },
  Task_10163_Desc = {
    Text = "Avoir au moins 4 Reliques lors de l'achèvement"
  },
  Task_10163_Name = {
    Text = "Pouvoir des reliques"
  },
  Task_10164_Desc = {
    Text = "Niveau terminé"
  },
  Task_10164_Name = {
    Text = "Complète le Niveau"
  },
  Task_10165_Desc = {
    Text = "Atteindre le Niveau d'Affinité 5 avec 8 Réveilleurs"
  },
  Task_10165_Name = {
    Text = "Partenaire parfait IV"
  },
  Task_10166_Desc = {
    Text = "Atteindre le Niveau d'Affinité 3 avec 12 Réveilleurs"
  },
  Task_10166_Name = {
    Text = "Partenaire parfait V"
  },
  Task_10167_Desc = {
    Text = "Complétez dans les 45 mouvements"
  },
  Task_10167_Name = {
    Text = "Planification stratégique"
  },
  Task_10168_Desc = {
    Text = "Vaincre en 17 tours"
  },
  Task_10168_Name = {
    Text = "Vaincre en 17 tours"
  },
  Task_10169_Desc = {
    Text = "A 20 Réveillés"
  },
  Task_10169_Name = {
    Text = "Combattre côte à côte II"
  },
  Task_10170_Desc = {
    Text = "A 30 Réveillés"
  },
  Task_10170_Name = {
    Text = "Combattre côte à côte III"
  },
  Task_10171_Desc = {
    Text = "Effectuez la cérémonie de Réveil 300 fois"
  },
  Task_10171_Name = {
    Text = "Génie Gardien IV"
  },
  Task_10172_Desc = {
    Text = "A 10 Réveillés"
  },
  Task_10172_Name = {
    Text = "Combattre ensemble"
  },
  Task_10173_Desc = {
    Text = "Atteindre le Niveau d'Affinité 5 avec 4 Réveilleurs"
  },
  Task_10173_Name = {
    Text = "Partenaires parfaits II"
  },
  Task_10174_Desc = {
    Text = "Récupérer le portefeuille"
  },
  Task_10174_Name = {Text = "Objectif"},
  Task_10175_Desc = {
    Text = "A 40 Réveillés"
  },
  Task_10175_Name = {
    Text = "Combat Coopératif IV"
  },
  Task_10176_Desc = {
    Text = "Atteindre le Niveau d'Affinité 3 avec 4 Corps Réveillés"
  },
  Task_10176_Name = {
    Text = "Partenaires parfaits"
  },
  Task_10177_Desc = {
    Text = "Compléter 400 courses des Ruines de Ponape"
  },
  Task_10177_Name = {
    Text = "Bénédiction de Ponape IV"
  },
  Task_10178_Desc = {
    Text = "Compléter 600 courses des Ruines de Bonapé"
  },
  Task_10178_Name = {
    Text = "Bénédiction de Ponape V"
  },
  Task_10179_Desc = {
    Text = "Compléter 50 Foyers de Vers"
  },
  Task_10179_Name = {
    Text = "Éleveur de Vers"
  },
  Task_10180_Desc = {
    Text = "Complétez 100 courses de la Tanière du Ver"
  },
  Task_10180_Name = {
    Text = "Tamer de vers II"
  },
  Task_10181_Desc = {
    Text = "Terminez 200 courses du Dén de Ver"
  },
  Task_10181_Name = {
    Text = "Tamer de vers III"
  },
  Task_10182_Desc = {
    Text = "Compléter 400 courses du Foyer des Vers"
  },
  Task_10182_Name = {
    Text = "Gardien de Vers IV"
  },
  Task_10183_Desc = {
    Text = "Compléter 600 courses du Foyer des Vers"
  },
  Task_10183_Name = {
    Text = "Éleveur de Vers V"
  },
  Task_10184_Desc = {
    Text = "Terminez l'Existence Transcendante une fois"
  },
  Task_10184_Name = {
    Text = "Sur la naissance cachée"
  },
  Task_10185_Desc = {
    Text = "Terminez 10 Existences Transcendantes"
  },
  Task_10185_Name = {
    Text = "La Naissance du Secret II"
  },
  Task_10186_Desc = {
    Text = "Complétez 25 courses d'Existence Transcendante"
  },
  Task_10186_Name = {
    Text = "La Naissance du Secret III"
  },
  Task_10187_Desc = {
    Text = "Complete Investigation Event Chapter 3 \"Watch Out for Dogs\""
  },
  Task_10187_Name = {
    Text = "Nouvelle pousse d'étoile"
  },
  Task_10188_Desc = {
    Text = "Complète le défi en jusqu'à 6 batailles."
  },
  Task_10188_Name = {
    Text = "Frappe précise"
  },
  Task_10189_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_10189_Name = {
    Text = "La sécurité avant tout"
  },
  Task_10190_Desc = {
    Text = "Avoir pas plus de 1 Symptôme lors de l'achèvement"
  },
  Task_10190_Name = {Text = "Refreshing"},
  Task_10191_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10191_Name = {
    Text = "Passer Parfait"
  },
  Task_10192_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10192_Name = {
    Text = "Passer Parfait"
  },
  Task_10193_Desc = {
    Text = "Trouvez Jenkin"
  },
  Task_10193_Name = {Text = "Objectif"},
  Task_10194_Desc = {
    Text = "Clôture d'Élixir de tempérage - Difficulté I"
  },
  Task_10194_Name = {Text = "Quête 3"},
  Task_10195_Desc = {
    Text = "Complétez 2 tâches de mission"
  },
  Task_10195_Name = {Text = "Quête 2"},
  Task_10196_Desc = {
    Text = "Réveil 40 fois au total"
  },
  Task_10196_Name = {Text = "Tâche 1"},
  Task_10197_Desc = {
    Text = "Améliorer la résonance du Chapitre 1 5 fois"
  },
  Task_10197_Name = {Text = "Quête 5"},
  Task_10198_Desc = {
    Text = "4 Réveilleurs atteignent le Niveau 10"
  },
  Task_10198_Name = {Text = "Mission 4"},
  Task_10199_Desc = {
    Text = "Complétez la scène avec au moins 2 Réveilleurs de Chaos"
  },
  Task_10199_Name = {
    Text = "Ascension dans le chaos"
  },
  Task_10200_Desc = {
    Text = "Avoir pas plus de 1 Symptôme lors de l'achèvement"
  },
  Task_10200_Name = {Text = "Refreshing"},
  Task_10201_Desc = {
    Text = "Échapper de la salle des pouvoirs"
  },
  Task_10201_Name = {Text = "Objectif"},
  Task_10202_Desc = {
    Text = "Avoir au moins 8 Cartes d'Oraison lors de l'achèvement"
  },
  Task_10202_Name = {
    Text = "Pouvoir d'oraison"
  },
  Task_10203_Desc = {
    Text = "Complétez la scène avec au moins 2 Réveilleurs de Chaos"
  },
  Task_10203_Name = {
    Text = "Ascension dans le chaos"
  },
  Task_10204_Desc = {
    Text = "Procédez au site d'investigation"
  },
  Task_10204_Name = {Text = "Objectif"},
  Task_10205_Desc = {
    Text = "Gagner la Bataille Finale en moins de 8 tours"
  },
  Task_10205_Name = {
    Text = "Résolution rapide"
  },
  Task_10206_Desc = {
    Text = "Complétez la scène avec au moins 2 Réveilleurs de Chaos"
  },
  Task_10206_Name = {
    Text = "Ascension dans le chaos"
  },
  Task_10207_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_10207_Name = {
    Text = "La sécurité avant tout"
  },
  Task_10208_Desc = {
    Text = "Complète le niveau en 35 étapes"
  },
  Task_10208_Name = {
    Text = "Planification stratégique"
  },
  Task_10209_Desc = {
    Text = "Avoir au moins 4 Reliques lors de l'achèvement"
  },
  Task_10209_Name = {
    Text = "Pouvoir des reliques"
  },
  Task_10210_Desc = {
    Text = "Épuisez 180 Menophin"
  },
  Task_10210_Name = {
    Text = "Consomme de l'énergie"
  },
  Task_10211_Desc = {
    Text = "Fais disparaître les enfants bloquant le chemin"
  },
  Task_10211_Name = {Text = "Objectif"},
  Task_10212_Desc = {
    Text = "Complète toutes les tâches dans la phase pour réclamer des récompenses"
  },
  Task_10212_Name = {Text = "Phase un"},
  Task_10213_Desc = {
    Text = "Tracer la Jonquille à travers les dimensions"
  },
  Task_10213_Name = {Text = "Objectif"},
  Task_10215_Desc = {
    Text = "Gagnez la bataille finale en 6 tours"
  },
  Task_10215_Name = {
    Text = "Gagnez la bataille finale en 6 tours"
  },
  Task_10216_Desc = {
    Text = "Niveau terminé"
  },
  Task_10216_Name = {
    Text = "Complète le Niveau"
  },
  Task_10217_Desc = {
    Text = "Gagner la bataille finale en moins de 15 tours avec un Stress inférieur à 500."
  },
  Task_10217_Name = {
    Text = "Gagner la bataille finale en moins de 15 tours avec stress inférieur à 500."
  },
  Task_10218_Desc = {
    Text = "A 4 Réveillés Caro de niveau 20"
  },
  Task_10218_Name = {
    Text = "Maître de Caro II"
  },
  Task_10219_Desc = {
    Text = ": Suivre Murphy"
  },
  Task_10219_Name = {Text = "Objectif"},
  Task_10220_Desc = {
    Text = "Niveau terminé"
  },
  Task_10220_Name = {
    Text = "Complète le Niveau"
  },
  Task_10221_Desc = {
    Text = "Niveau terminé"
  },
  Task_10221_Name = {
    Text = "Complète le Niveau"
  },
  Task_10222_Desc = {
    Text = "Jouez un total de 50 cartes"
  },
  Task_10223_Desc = {
    Text = "Chercher des indices pour le Chasseur de Crânes"
  },
  Task_10223_Name = {Text = "Objectif"},
  Task_10224_Desc = {
    Text = "Niveau terminé"
  },
  Task_10224_Name = {
    Text = "Complète le Niveau"
  },
  Task_10226_Desc = {
    Text = "Niveau terminé"
  },
  Task_10226_Name = {
    Text = "Complète le Niveau"
  },
  Task_10228_Desc = {
    Text = "Regardant le Capitaine"
  },
  Task_10228_Name = {Text = "Objectif"},
  Task_10229_Desc = {
    Text = "Niveau terminé"
  },
  Task_10229_Name = {
    Text = "Complète le Niveau"
  },
  Task_10230_Desc = {
    Text = "Chasser le \"Chien des enfers\""
  },
  Task_10230_Name = {Text = "Objectif"},
  Task_10231_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_10231_Name = {
    Text = "Résolution rapide"
  },
  Task_10232_Desc = {
    Text = "Niveau terminé"
  },
  Task_10232_Name = {
    Text = "Complète le Niveau"
  },
  Task_10233_Desc = {
    Text = "Niveau terminé"
  },
  Task_10233_Name = {
    Text = "Complète le Niveau"
  },
  Task_10234_Desc = {
    Text = "Niveau terminé"
  },
  Task_10234_Name = {
    Text = "Complète le Niveau"
  },
  Task_10235_Desc = {
    Text = "Investiguer 60 images après-abysse"
  },
  Task_10235_Name = {
    Text = "Ruines d'Aequor III"
  },
  Task_10236_Desc = {
    Text = "Investiguer 30 images après-abysse"
  },
  Task_10236_Name = {
    Text = "Ruines d'Aequor II"
  },
  Task_10237_Desc = {
    Text = "Investiguer 120 images après-sombres"
  },
  Task_10237_Name = {
    Text = "Ruines du Chaos IV"
  },
  Task_10238_Desc = {
    Text = "Investiguer l'image après-sombre 60 fois"
  },
  Task_10238_Name = {
    Text = "Ruines du Chaos III"
  },
  Task_10239_Desc = {
    Text = "Investiguer 15 images après-abysse"
  },
  Task_10239_Name = {
    Text = "Ruines d'aquor"
  },
  Task_10240_Desc = {
    Text = "Investiguer 240 images après-sombres"
  },
  Task_10240_Name = {
    Text = "Ruines de Chaos V"
  },
  Task_10241_Desc = {
    Text = "Complétez 600 Extractions d'Élixir"
  },
  Task_10241_Name = {
    Text = "Maître Modulateur V"
  },
  Task_10242_Desc = {
    Text = "Complétez 400 Affinements de Potion"
  },
  Task_10242_Name = {
    Text = "Maître Modulateur IV"
  },
  Task_10243_Desc = {
    Text = "Investiguer 30 images après-sombres"
  },
  Task_10243_Name = {
    Text = "Ruines du Chaos II"
  },
  Task_10244_Desc = {
    Text = "Investiguer 15 images après-sombres"
  },
  Task_10244_Name = {
    Text = "Ruines du chaos"
  },
  Task_10245_Desc = {
    Text = "Protéger Jenkin"
  },
  Task_10245_Name = {Text = "Objectif"},
  Task_10246_Desc = {
    Text = "Fou Arrêt des Mutations"
  },
  Task_10246_Name = {Text = "Objectif"},
  Task_10247_Desc = {
    Text = "Complète toutes les tâches dans la phase pour réclamer des récompenses"
  },
  Task_10247_Name = {
    Text = "Étape Trois"
  },
  Task_10248_Desc = {
    Text = "Trouvez un outil pour ouvrir la trappe"
  },
  Task_10248_Name = {Text = "Objectif"},
  Task_10249_Desc = {
    Text = "Échapper au danger"
  },
  Task_10249_Name = {Text = "Objectif"},
  Task_10250_Desc = {
    Text = "Complète au moins 2 nœuds d'événement différents d'ici la fin du niveau."
  },
  Task_10250_Name = {
    Text = "Déclenchement de nœud"
  },
  Task_10251_Desc = {
    Text = "Complète le niveau sans utiliser le camp pour restaurer les PV."
  },
  Task_10251_Name = {
    Text = "Sentiers spéciaux"
  },
  Task_10252_Desc = {
    Text = "Conservez au moins 50% de PV après avoir terminé la Bataille Finale."
  },
  Task_10252_Name = {
    Text = "Points de vie de la bataille finale"
  },
  Task_10253_Desc = {
    Text = "Terminez le jeu avec au moins 2 Cartes de Symptôme"
  },
  Task_10253_Name = {
    Text = "Construction de deck"
  },
  Task_10254_Desc = {
    Text = "Complétez avec un maximum de 2 Cartes de symptôme"
  },
  Task_10254_Name = {
    Text = "Construction de deck"
  },
  Task_10255_Desc = {
    Text = "Vaincre avec au moins 30 étapes"
  },
  Task_10255_Name = {
    Text = "Planification de trajet"
  },
  Task_10256_Desc = {
    Text = "Complétez dans <25 étapes>"
  },
  Task_10256_Name = {
    Text = "Planification de trajet"
  },
  Task_10258_Desc = {
    Text = "Niveau terminé"
  },
  Task_10258_Name = {
    Text = "Complète le Niveau"
  },
  Task_10259_Desc = {
    Text = "Nombre de fois qu'un état a été supprimé par commande (par exemple, effet de Faiblesse réussi dissipé deux fois)"
  },
  Task_10259_Name = {
    Text = "Effet de bataille"
  },
  Task_10260_Desc = {
    Text = "Nombre de fois qu'un état a été ajouté (par exemple, ajout réussi d'un effet de Faiblesse une fois)"
  },
  Task_10260_Name = {
    Text = "Effet de bataille"
  },
  Task_10265_Desc = {
    Text = "Vaincre le Chasseur de Crânes"
  },
  Task_10265_Name = {Text = "Objectif"},
  Task_10266_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_10266_Name = {
    Text = "La sécurité avant tout"
  },
  Task_10267_Desc = {
    Text = "Complétez la scène en jusqu'à 3 batailles."
  },
  Task_10267_Name = {
    Text = "Frappe précise"
  },
  Task_10268_Desc = {
    Text = "Avoir au moins 50 sigils noirs à l'issue"
  },
  Task_10268_Name = {
    Text = "Sauvegarder pour plus tard"
  },
  Task_10269_Desc = {
    Text = "Avoir pas plus de 1 Symptôme lors de l'achèvement"
  },
  Task_10269_Name = {Text = "Refreshing"},
  Task_10270_Desc = {
    Text = "Avoir au moins 8 Cartes d'Oraison lors de l'achèvement"
  },
  Task_10270_Name = {
    Text = "Pouvoir d'oraison"
  },
  Task_10271_Desc = {
    Text = "Complète le niveau en 28 mouvements"
  },
  Task_10271_Name = {
    Text = "Planification stratégique"
  },
  Task_10272_Desc = {
    Text = "Clair le jeu avec un total de 4 ou moins d'Exalts dans toutes les Batailles."
  },
  Task_10272_Name = {
    Text = "Calme et élégant"
  },
  Task_10273_Desc = {
    Text = "Réveillez tous les Réveilleurs à l'achèvement"
  },
  Task_10273_Name = {
    Text = "Dernière arrivée"
  },
  Task_10274_Desc = {
    Text = "Avoir au moins 4 Reliques lors de l'achèvement"
  },
  Task_10274_Name = {
    Text = "Pouvoir des reliques"
  },
  Task_10275_Desc = {
    Text = "Vaincre en 73 tours"
  },
  Task_10275_Name = {
    Text = "Vaincre en 73 tours"
  },
  Task_10276_Desc = {
    Text = "Entrez dans la Cabine du Navire"
  },
  Task_10276_Name = {Text = "Objectif"},
  Task_10277_CompleteCondDesc = {
    Text = "Niveau d'assignement total>={s1}"
  },
  Task_10277_Desc = {
    Text = "Être assis dans la bibliothèque ne vous rapportera pas plus d'Éveilleurs.\nSortez, bougez vos jambes et cherchez cette chance unique dans la nature."
  },
  Task_10277_Name = {
    Text = "Mission : trace de mithril"
  },
  Task_10278_Desc = {
    Text = "Avoir pas plus de 1 Symptôme lors de l'achèvement"
  },
  Task_10278_Name = {Text = "Refreshing"},
  Task_10279_Desc = {
    Text = "Complétez dans les 45 mouvements"
  },
  Task_10279_Name = {
    Text = "Planification stratégique"
  },
  Task_10280_Desc = {
    Text = "Complète le niveau en 30 étapes"
  },
  Task_10280_Name = {
    Text = "Planification stratégique"
  },
  Task_10281_Desc = {
    Text = "Édifier un Réveiller de Royaume Ultra à Niveau 2"
  },
  Task_10281_Name = {
    Text = "Maîtrise Ultra II"
  },
  Task_10282_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_10282_Name = {
    Text = "La sécurité avant tout"
  },
  Task_10283_Desc = {
    Text = "Complète toutes les tâches dans la phase pour réclamer des récompenses"
  },
  Task_10283_Name = {
    Text = "Étape Cinq"
  },
  Task_10284_Desc = {
    Text = "Gagner la bataille finale en moins de 17 tours"
  },
  Task_10284_Name = {
    Text = "Gagner la bataille finale en moins de 17 tours"
  },
  Task_10285_Desc = {
    Text = "Consommez 10000000 rose dorée"
  },
  Task_10285_Name = {
    Text = "Dépensier V"
  },
  Task_10287_Desc = {
    Text = "Consommez 5000000 rose dorée"
  },
  Task_10287_Name = {
    Text = "Dépensier IV"
  },
  Task_10288_Desc = {
    Text = "Gagner la bataille finale en moins de 15 tours"
  },
  Task_10288_Name = {
    Text = "Gagner la bataille finale en moins de 15 tours"
  },
  Task_10289_Desc = {
    Text = "Complétez la scène en jusqu'à 5 batailles."
  },
  Task_10289_Name = {
    Text = "Frappe précise"
  },
  Task_10290_Desc = {
    Text = "Chercher le son dans le coin"
  },
  Task_10290_Name = {Text = "Objectif"},
  Task_10292_Desc = {
    Text = "Connexion cumulative pendant 90 jours"
  },
  Task_10292_Name = {
    Text = "Persévérance"
  },
  Task_10293_Desc = {
    Text = "Connecté pendant un total de 60 jours"
  },
  Task_10293_Name = {
    Text = "De l'au-delà"
  },
  Task_10294_Desc = {
    Text = "Complétez la scène avec au moins 2 Réveilleurs de Chaos"
  },
  Task_10294_Name = {
    Text = "Ascension dans le chaos"
  },
  Task_10295_Desc = {
    Text = "Échapper de l'entrelacement de la mystérieuse femme"
  },
  Task_10295_Name = {Text = "Objectif"},
  Task_10297_Desc = {
    Text = "Complétez la scène avec au moins 2 Réveilleurs de Chaos"
  },
  Task_10297_Name = {
    Text = "Ascension dans le chaos"
  },
  Task_10298_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_10298_Name = {
    Text = "Résolution rapide"
  },
  Task_10301_Desc = {
    Text = "Éliminez le Chien des enfers"
  },
  Task_10301_Name = {Text = "Objectif"},
  Task_10302_CompleteCondDesc = {
    Text = "Niveau d'assignement total>={s1}"
  },
  Task_10302_Desc = {
    Text = "Le Chaos est la loi de la nature ; l'ordre est une illusion humaine."
  },
  Task_10302_Name = {
    Text = "Recherche : hymne pâle"
  },
  Task_10302_UnlockCondDesc = {
    Text = "Le Gardien débloqué au niveau 25"
  },
  Task_10303_Desc = {
    Text = "Le Gardien atteint le niveau 35"
  },
  Task_10303_Name = {
    Text = "Épreuve du Gardien IV"
  },
  Task_10305_Desc = {
    Text = "Atteindre le Niveau d'Affinité 3 avec 8 Êtres Réveillés"
  },
  Task_10305_Name = {
    Text = "Partenaires parfaits III"
  },
  Task_10307_Desc = {
    Text = "Éliminez Fissure du Domaine du Chaos I"
  },
  Task_10307_Name = {Text = "Quête 5"},
  Task_10308_Desc = {
    Text = "Complète un essai d'Image Résiduelle une fois"
  },
  Task_10308_Name = {Text = "Mission 4"},
  Task_10309_Desc = {
    Text = "Recherche de ticket d'or de clôture - Difficulté I"
  },
  Task_10309_Name = {Text = "Quête 3"},
  Task_10310_Desc = {
    Text = "Élever 4 Réveilleurs au niveau 20"
  },
  Task_10310_Name = {Text = "Quête 2"},
  Task_10311_Desc = {
    Text = "Compléter \"Plongée Fantasmatique\" une fois"
  },
  Task_10311_Name = {Text = "Tâche 1"},
  Task_10313_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_10313_Name = {
    Text = "La sécurité avant tout"
  },
  Task_10314_Desc = {
    Text = "Complète le niveau en 30 étapes"
  },
  Task_10314_Name = {
    Text = "Planification stratégique"
  },
  Task_10315_Desc = {
    Text = "Réveillez tous les Réveilleurs à l'achèvement"
  },
  Task_10315_Name = {
    Text = "Dernière arrivée"
  },
  Task_10316_Desc = {
    Text = "Complétez la scène avec au moins 2 Réveilleurs de Chaos"
  },
  Task_10316_Name = {
    Text = "Ascension dans le chaos"
  },
  Task_10317_Desc = {
    Text = "Avoir pas plus de 3 Symptômes lors de l'achèvement"
  },
  Task_10317_Name = {Text = "Refreshing"},
  Task_10318_Desc = {
    Text = "Avoir au moins 3 Reliques lors de l'achèvement"
  },
  Task_10318_Name = {
    Text = "Pouvoir des reliques"
  },
  Task_10319_Desc = {
    Text = "Gagner la Bataille Finale en moins de 8 tours"
  },
  Task_10319_Name = {
    Text = "Résolution rapide"
  },
  Task_10320_CompleteCondDesc = {
    Text = "Niveau d'assignement total>={s1}"
  },
  Task_10320_Desc = {
    Text = "Tout ce qui brille n'est pas or, mais c'est certainement précieux. \nLa légende dit que Mythag a été fondée par un groupe d'alchimistes reclus dont les ambitions allaient bien au-delà de la simple transmutation."
  },
  Task_10320_Name = {
    Text = "Recherche : codex de formules"
  },
  Task_10321_Desc = {
    Text = "Complète le niveau en 33 étapes"
  },
  Task_10321_Name = {
    Text = "Planification stratégique"
  },
  Task_10322_Desc = {
    Text = "Avoir au moins 5 Reliques lors de l'achèvement"
  },
  Task_10322_Name = {
    Text = "Pouvoir des reliques"
  },
  Task_10323_CompleteCondDesc = {
    Text = "Niveau d'assignement total>={s1}"
  },
  Task_10323_Desc = {
    Text = "En termes stricts, les Réveilleurs sont également une forme de Technologie des Pépites Argentées.\nVous devez faire de votre mieux pour vous assurer qu'ils ne prennent pas de retard."
  },
  Task_10323_Name = {
    Text = "Recherche : script d'infusion"
  },
  Task_10324_Desc = {
    Text = "Vaincre le monstre déformé dans le Bureau du Doyen"
  },
  Task_10324_Name = {Text = "Objectif"},
  Task_10325_Desc = {
    Text = "Avoir au moins 2 Reliques lors de l'achèvement"
  },
  Task_10325_Name = {
    Text = "Pouvoir des reliques"
  },
  Task_10326_Desc = {
    Text = "Avoir au moins 5 Cartes d'Oraison lors de l'achèvement"
  },
  Task_10326_Name = {
    Text = "Pouvoir d'oraison"
  },
  Task_10327_Desc = {
    Text = "Avoir pas plus de 2 Symptômes lors de l'achèvement"
  },
  Task_10327_Name = {Text = "Refreshing"},
  Task_10328_Desc = {
    Text = "Niveau terminé"
  },
  Task_10328_Name = {
    Text = "Complète le Niveau"
  },
  Task_10329_Desc = {
    Text = "Niveau terminé"
  },
  Task_10329_Name = {
    Text = "Complète le Niveau"
  },
  Task_10330_Desc = {
    Text = "Complète le niveau en 30 étapes"
  },
  Task_10330_Name = {
    Text = "Planification stratégique"
  },
  Task_10331_Desc = {
    Text = "Niveau terminé"
  },
  Task_10331_Name = {
    Text = "Complète le Niveau"
  },
  Task_10332_Desc = {
    Text = "Gagner la bataille finale en moins de 12 tours"
  },
  Task_10332_Name = {
    Text = "Gagner la bataille finale en moins de 12 tours"
  },
  Task_10333_Desc = {
    Text = "Niveau terminé"
  },
  Task_10333_Name = {
    Text = "Complète le Niveau"
  },
  Task_10334_Desc = {
    Text = "Améliorez les Compétences de l'Éveilleur 3 fois"
  },
  Task_10334_Name = {
    Text = "Passionné d'Arène (Inactif)"
  },
  Task_10335_Desc = {
    Text = "Compléter le Royaume des Ténèbres VIII (Inachevé)"
  },
  Task_10336_Desc = {
    Text = "Découvrir les secrets de l'asile"
  },
  Task_10336_Name = {Text = "Objectif"},
  Task_10337_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10337_Name = {
    Text = "Passer Parfait"
  },
  Task_10338_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10338_Name = {
    Text = "Passer Parfait"
  },
  Task_10339_Desc = {
    Text = "Gagnez la bataille finale en 7 tours"
  },
  Task_10339_Name = {
    Text = "Gagnez la bataille finale en 7 tours"
  },
  Task_10340_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10340_Name = {
    Text = "Passer Parfait"
  },
  Task_10341_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10341_Name = {
    Text = "Passer Parfait"
  },
  Task_10342_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10342_Name = {
    Text = "Passer Parfait"
  },
  Task_10343_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10343_Name = {
    Text = "Passer Parfait"
  },
  Task_10344_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10344_Name = {
    Text = "Passer Parfait"
  },
  Task_10345_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10345_Name = {
    Text = "Passer Parfait"
  },
  Task_10346_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10346_Name = {
    Text = "Passer Parfait"
  },
  Task_10347_Desc = {
    Text = "Édifier un Réveiller de Royaume Ultra à Niveau 3"
  },
  Task_10347_Name = {
    Text = "Maîtrise Ultra III"
  },
  Task_10348_Desc = {
    Text = "Édifier un Réveilleur du Royaume Caro au Niveau 3"
  },
  Task_10348_Name = {
    Text = "Caro Maîtrise III"
  },
  Task_10349_Desc = {
    Text = "Édifier un Réveiller de Royaume des Profondeurs à Niveau 3"
  },
  Task_10349_Name = {
    Text = "Aequor Maîtrise III"
  },
  Task_10350_Desc = {
    Text = "Édifier 1 Réveilleur du Royaume du Chaos au Niveau 3"
  },
  Task_10350_Name = {
    Text = "Maîtrise du Chaos III"
  },
  Task_10351_Desc = {
    Text = "Niveau terminé"
  },
  Task_10351_Name = {
    Text = "Complète le Niveau"
  },
  Task_10352_Desc = {
    Text = "Posséder 4 Éveilleurs Caro de niveau 40"
  },
  Task_10352_Name = {
    Text = "Maître de Caro IV"
  },
  Task_10353_Desc = {
    Text = "Niveau terminé"
  },
  Task_10353_Name = {
    Text = "Complète le Niveau"
  },
  Task_10354_Desc = {
    Text = "Niveau terminé"
  },
  Task_10354_Name = {
    Text = "Complète le Niveau"
  },
  Task_10355_Desc = {
    Text = "Niveau terminé"
  },
  Task_10355_Name = {
    Text = "Complète le Niveau"
  },
  Task_10356_Desc = {
    Text = "Rattraper Aigis"
  },
  Task_10356_Name = {Text = "Objectif"},
  Task_10357_Desc = {
    Text = "Niveau terminé"
  },
  Task_10357_Name = {
    Text = "Complète le Niveau"
  },
  Task_10358_Desc = {
    Text = "Gagnez la bataille finale en 3 tours"
  },
  Task_10358_Name = {
    Text = "Gagnez la bataille finale en 3 tours"
  },
  Task_10359_Desc = {
    Text = "Niveau terminé"
  },
  Task_10359_Name = {
    Text = "Complète le Niveau"
  },
  Task_10360_Desc = {
    Text = "Niveau terminé"
  },
  Task_10360_Name = {
    Text = "Complète le Niveau"
  },
  Task_10361_Desc = {
    Text = "Niveau terminé"
  },
  Task_10361_Name = {
    Text = "Complète le Niveau"
  },
  Task_10362_Desc = {
    Text = "Niveau terminé"
  },
  Task_10362_Name = {
    Text = "Complète le Niveau"
  },
  Task_10363_Desc = {
    Text = "Niveau terminé"
  },
  Task_10363_Name = {
    Text = "Complète le Niveau"
  },
  Task_10364_Desc = {
    Text = "Niveau terminé"
  },
  Task_10364_Name = {
    Text = "Complète le Niveau"
  },
  Task_10365_Desc = {
    Text = "Niveau terminé"
  },
  Task_10365_Name = {
    Text = "Complète le Niveau"
  },
  Task_10366_Desc = {
    Text = "Niveau terminé"
  },
  Task_10366_Name = {
    Text = "Complète le Niveau"
  },
  Task_10367_Desc = {
    Text = "Niveau terminé"
  },
  Task_10367_Name = {
    Text = "Complète le Niveau"
  },
  Task_10368_Desc = {
    Text = "Niveau terminé"
  },
  Task_10368_Name = {
    Text = "Complète le Niveau"
  },
  Task_10369_Desc = {
    Text = "Niveau terminé"
  },
  Task_10369_Name = {
    Text = "Complète le Niveau"
  },
  Task_10370_Desc = {
    Text = "Trouvez 10 points d'extraction dans le Chapitre 2 de l'intrigue principale \"@1@2\""
  },
  Task_10370_Desc2 = {
    Text = "Trouvez 10 points d'extraction dans le Chapitre 2 de l'intrigue principale \"Au Nom de la Sculpture en Cire\""
  },
  Task_10370_Name = {Text = "@2@3"},
  Task_10370_Name2 = {
    Text = "Ombres Chuchotantes II"
  },
  Task_10371_Desc = {
    Text = "Trouvez 9 points d'extraction dans le Chapitre 3 de l'intrigue principale \"@1@2\""
  },
  Task_10371_Desc2 = {
    Text = "Trouvez 9 points d'extraction dans l'histoire principale Chapitre 3 \"Faites Attention aux Chiens\""
  },
  Task_10371_Name = {Text = "@2@3"},
  Task_10371_Name2 = {
    Text = "Murmures du caché III"
  },
  Task_10372_Desc = {
    Text = "Complétez 336 tâches de mission"
  },
  Task_10372_Name = {
    Text = "Opération spéciale V"
  },
  Task_10373_Desc = {
    Text = "Trouvez 8 points d'extraction dans l'histoire principale Chapitre 1 \"Secret de l'Est\""
  },
  Task_10373_Name = {
    Text = "Murmure caché"
  },
  Task_10374_Desc = {
    Text = "Complétez 84 tâches de mission"
  },
  Task_10374_Name = {
    Text = "Opération Spéciale III"
  },
  Task_10375_Desc = {
    Text = "Complétez 168 Missions"
  },
  Task_10375_Name = {
    Text = "Opération spéciale IV"
  },
  Task_10376_Desc = {
    Text = "Complétez 12 Missions"
  },
  Task_10376_Name = {
    Text = "Opération spéciale"
  },
  Task_10377_Desc = {
    Text = "Complétez 36 Missions"
  },
  Task_10377_Name = {
    Text = "Opération spéciale II"
  },
  Task_10378_Desc = {
    Text = "Niveau terminé"
  },
  Task_10378_Name = {
    Text = "Complète le Niveau"
  },
  Task_10379_Desc = {
    Text = "Niveau terminé"
  },
  Task_10379_Name = {
    Text = "Complète le Niveau"
  },
  Task_10380_Desc = {
    Text = "Niveau terminé"
  },
  Task_10380_Name = {
    Text = "Complète le Niveau"
  },
  Task_10381_Desc = {
    Text = "Trouvez 12 points d'extraction dans le Chapitre 4 de l'intrigue principale \"@1@2\""
  },
  Task_10381_Desc2 = {
    Text = "Trouvez 12 points d'extraction dans le Chapitre 4 \"Dans le silence\" de l'histoire principale."
  },
  Task_10381_Name = {Text = "@2@3"},
  Task_10381_Name2 = {
    Text = "Murmures du caché IV"
  },
  Task_10382_Desc = {
    Text = "Posséder quatre Réveilleurs Profondeur de niveau 60"
  },
  Task_10382_Name = {
    Text = "Seigneur des Profondeurs VI"
  },
  Task_10384_Desc = {
    Text = "Accumulatez au moins 1 000 Boucliers en un seul tour lors de la Bataille Finale."
  },
  Task_10384_Name = {
    Text = "Défense excessive"
  },
  Task_10385_Desc = {
    Text = "Passez par le passage de la conscience et suivez Francis"
  },
  Task_10385_Name = {Text = "Objectif"},
  Task_10387_Desc = {
    Text = "Éliminez les Mutants de Dissolution"
  },
  Task_10387_Name = {Text = "Objectif"},
  Task_10388_Desc = {
    Text = "Mener Sarah au sous-sol"
  },
  Task_10388_Name = {Text = "Objectif"},
  Task_10390_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_10390_Name = {
    Text = "Résolution rapide"
  },
  Task_10391_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_10391_Name = {
    Text = "Résolution rapide"
  },
  Task_10392_Desc = {
    Text = "S'échapper de l'espace dimensionnel et du regard de \"Lui\""
  },
  Task_10392_Name = {Text = "Objectif"},
  Task_10394_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_10394_Name = {
    Text = "Résolution rapide"
  },
  Task_10395_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_10395_Name = {
    Text = "Résolution rapide"
  },
  Task_10396_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_10396_Name = {
    Text = "Résolution rapide"
  },
  Task_10397_Desc = {
    Text = "Réveillez la Lily étourdie"
  },
  Task_10397_Name = {Text = "Objectif"},
  Task_10404_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_10404_Name = {
    Text = "Résolution rapide"
  },
  Task_10405_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_10405_Name = {
    Text = "Résolution rapide"
  },
  Task_10406_Desc = {
    Text = "Complétez la scène avec au moins 2 Réveilleurs de Chaos"
  },
  Task_10406_Name = {
    Text = "Ascension dans le chaos"
  },
  Task_10407_Desc = {
    Text = "À travers le Métro Sombre"
  },
  Task_10407_Name = {Text = "Objectif"},
  Task_10409_Desc = {
    Text = "Échapper de l'asile"
  },
  Task_10409_Name = {Text = "Objectif"},
  Task_10413_Desc = {
    Text = "Avoir au moins 4 Reliques lors de l'achèvement"
  },
  Task_10413_Name = {
    Text = "Pouvoir des reliques"
  },
  Task_10419_Desc = {
    Text = "Rattraper Pandia"
  },
  Task_10419_Name = {Text = "Objectif"},
  Task_10420_Desc = {
    Text = "Compléter l'événement d'investigation \"En Silence\" à la difficulté Difficile"
  },
  Task_10420_Name = {
    Text = "Maman, je n'ai pas mal·Difficile"
  },
  Task_10421_Desc = {
    Text = "Gagner la Bataille Finale en moins de 15 tours"
  },
  Task_10421_Name = {
    Text = "Résolution rapide"
  },
  Task_10422_Desc = {
    Text = "Gagner la Bataille Finale en moins de 8 tours"
  },
  Task_10422_Name = {
    Text = "Résolution rapide"
  },
  Task_10423_Desc = {
    Text = "Gagner la Bataille Finale en moins de 8 tours"
  },
  Task_10423_Name = {
    Text = "Résolution rapide"
  },
  Task_10424_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_10424_Name = {
    Text = "Résolution rapide"
  },
  Task_10425_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_10425_Name = {
    Text = "Résolution rapide"
  },
  Task_10426_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_10426_Name = {
    Text = "Résolution rapide"
  },
  Task_10427_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_10427_Name = {
    Text = "Résolution rapide"
  },
  Task_10428_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_10428_Name = {
    Text = "Résolution rapide"
  },
  Task_10429_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_10429_Name = {
    Text = "Résolution rapide"
  },
  Task_10430_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_10430_Name = {
    Text = "Résolution rapide"
  },
  Task_10431_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_10431_Name = {
    Text = "Résolution rapide"
  },
  Task_10432_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_10432_Name = {
    Text = "Résolution rapide"
  },
  Task_10433_Desc = {
    Text = "Complète le défi en jusqu'à 6 batailles."
  },
  Task_10433_Name = {
    Text = "Frappe précise"
  },
  Task_10434_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_10434_Name = {
    Text = "La sécurité avant tout"
  },
  Task_10435_Desc = {
    Text = "Avoir pas plus de 1 Symptôme lors de l'achèvement"
  },
  Task_10435_Name = {Text = "Refreshing"},
  Task_10436_Desc = {
    Text = "Arrête le chercheur"
  },
  Task_10436_Name = {Text = "Objectif"},
  Task_10437_Desc = {
    Text = "Entrez le sous-sol"
  },
  Task_10437_Name = {Text = "Objectif"},
  Task_10438_Desc = {
    Text = "Complétez dans les 24 tours"
  },
  Task_10438_Name = {
    Text = "Complétez dans les 24 tours"
  },
  Task_10439_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_10439_Name = {
    Text = "Résolution rapide"
  },
  Task_10440_Desc = {
    Text = "Complétez la scène avec au moins 2 Réveilleurs de Chaos"
  },
  Task_10440_Name = {
    Text = "Ascension dans le chaos"
  },
  Task_10441_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_10441_Name = {
    Text = "Résolution rapide"
  },
  Task_10442_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_10442_Name = {
    Text = "Résolution rapide"
  },
  Task_10443_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_10443_Name = {
    Text = "Résolution rapide"
  },
  Task_10444_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_10444_Name = {
    Text = "Résolution rapide"
  },
  Task_10445_Desc = {
    Text = "Consommation cumulée de 1000 le sigil noir"
  },
  Task_10445_Name = {
    Text = "Invocation Noire III"
  },
  Task_10446_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_10446_Name = {
    Text = "Résolution rapide"
  },
  Task_10447_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_10447_Name = {
    Text = "Résolution rapide"
  },
  Task_10448_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_10448_Name = {
    Text = "Résolution rapide"
  },
  Task_10449_Desc = {
    Text = "Niveau terminé"
  },
  Task_10449_Name = {
    Text = "Complète le Niveau"
  },
  Task_10450_Desc = {
    Text = "Niveau terminé"
  },
  Task_10450_Name = {
    Text = "Complète le Niveau"
  },
  Task_10451_Desc = {
    Text = "Compléter 600 Codex Tabou"
  },
  Task_10451_Name = {
    Text = "Graveur de Pacte V"
  },
  Task_10452_Desc = {
    Text = "Compléter 400 Codex Tabou"
  },
  Task_10452_Name = {
    Text = "Graveur de Pacte IV"
  },
  Task_10453_Desc = {
    Text = "Terminez 200 Codex Tabous"
  },
  Task_10453_Name = {
    Text = "Graveur de Pacte III"
  },
  Task_10454_Desc = {
    Text = "Activez l'effet du set de 6 pièces du Pacte"
  },
  Task_10454_Name = {Text = "Mission 4"},
  Task_10455_Desc = {
    Text = "Compléter 50 Codex Tabou"
  },
  Task_10455_Name = {
    Text = "Graveur de covenant"
  },
  Task_10456_Desc = {
    Text = "Compléter 50 Existences Transcendantes"
  },
  Task_10456_Name = {
    Text = "Sur la Naissance du Secret IV"
  },
  Task_10457_Desc = {
    Text = "Trouvez Lotan"
  },
  Task_10457_Name = {Text = "Objectif"},
  Task_10458_Desc = {
    Text = "Niveau terminé"
  },
  Task_10458_Name = {
    Text = "Complète le Niveau"
  },
  Task_10459_Desc = {
    Text = "Niveau terminé"
  },
  Task_10459_Name = {
    Text = "Complète le Niveau"
  },
  Task_10460_Desc = {
    Text = "Niveau terminé"
  },
  Task_10460_Name = {
    Text = "Complète le Niveau"
  },
  Task_10461_Desc = {
    Text = "Niveau terminé"
  },
  Task_10461_Name = {
    Text = "Complète le Niveau"
  },
  Task_10462_Desc = {
    Text = "Niveau terminé"
  },
  Task_10462_Name = {
    Text = "Complète le Niveau"
  },
  Task_10463_Desc = {
    Text = "Niveau terminé"
  },
  Task_10463_Name = {
    Text = "Complète le Niveau"
  },
  Task_10464_Desc = {
    Text = "Niveau terminé"
  },
  Task_10464_Name = {
    Text = "Complète le Niveau"
  },
  Task_10465_Desc = {
    Text = "Niveau terminé"
  },
  Task_10465_Name = {
    Text = "Complète le Niveau"
  },
  Task_10466_Desc = {
    Text = "Niveau terminé"
  },
  Task_10466_Name = {
    Text = "Complète le Niveau"
  },
  Task_10467_Desc = {
    Text = "Niveau terminé"
  },
  Task_10467_Name = {
    Text = "Complète le Niveau"
  },
  Task_10468_Desc = {
    Text = "Niveau terminé"
  },
  Task_10468_Name = {
    Text = "Complète le Niveau"
  },
  Task_10469_Desc = {
    Text = "Niveau terminé"
  },
  Task_10469_Name = {
    Text = "Complète le Niveau"
  },
  Task_10470_Desc = {
    Text = "Niveau terminé"
  },
  Task_10470_Name = {
    Text = "Complète le Niveau"
  },
  Task_10471_Desc = {
    Text = "Niveau terminé"
  },
  Task_10471_Name = {
    Text = "Complète le Niveau"
  },
  Task_10472_Desc = {
    Text = "Compléter le chapitre principal d'investigation 2 : \"Au Nom des Sculptures en Cire\""
  },
  Task_10473_CompleteCondDesc = {
    Text = "Niveau d'assignement total>={s1}"
  },
  Task_10473_Desc = {
    Text = "Ils se tordent dans une peur non remarquée.\nIgnorants, sans lumière, sans nom."
  },
  Task_10473_Name = {
    Text = "Recherche : rime écarlate"
  },
  Task_10473_UnlockCondDesc = {
    Text = "Le Gardien débloqué au niveau 25"
  },
  Task_10474_Desc = {
    Text = "Niveau terminé"
  },
  Task_10474_Name = {
    Text = "Complète le Niveau"
  },
  Task_10475_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_10475_Name = {
    Text = "Résolution rapide"
  },
  Task_10476_Desc = {
    Text = "Terminez 400 Recherches de Billets en Or"
  },
  Task_10476_Name = {
    Text = "Prospecteur IV"
  },
  Task_10477_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_10477_Name = {
    Text = "La sécurité avant tout"
  },
  Task_10478_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_10478_Name = {
    Text = "Résolution rapide"
  },
  Task_10479_Desc = {
    Text = "Gagner la bataille finale en moins de 10 tours."
  },
  Task_10479_Name = {
    Text = "Gagner la bataille finale en moins de 10 tours."
  },
  Task_10480_Desc = {
    Text = "Niveau terminé"
  },
  Task_10480_Name = {
    Text = "Complète le Niveau"
  },
  Task_10481_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_10481_Name = {
    Text = "Résolution rapide"
  },
  Task_10482_Desc = {
    Text = "Complétez l'enquête principale Chapitre 4 \"Dans le Silence\""
  },
  Task_10483_Desc = {
    Text = "Niveau terminé"
  },
  Task_10483_Name = {
    Text = "Complète le Niveau"
  },
  Task_10484_Desc = {
    Text = "Niveau terminé"
  },
  Task_10484_Name = {
    Text = "Complète le Niveau"
  },
  Task_10485_Desc = {
    Text = "Niveau terminé"
  },
  Task_10485_Name = {
    Text = "Complète le Niveau"
  },
  Task_10486_Desc = {
    Text = "Niveau terminé"
  },
  Task_10486_Name = {
    Text = "Complète le Niveau"
  },
  Task_10487_Desc = {
    Text = "Niveau terminé"
  },
  Task_10487_Name = {
    Text = "Complète le Niveau"
  },
  Task_10488_Desc = {
    Text = "Niveau terminé"
  },
  Task_10488_Name = {
    Text = "Complète le Niveau"
  },
  Task_10489_Desc = {
    Text = "Niveau terminé"
  },
  Task_10489_Name = {
    Text = "Complète le Niveau"
  },
  Task_10490_Desc = {
    Text = "Niveau terminé"
  },
  Task_10490_Name = {
    Text = "Complète le Niveau"
  },
  Task_10492_Desc = {
    Text = "Niveau terminé"
  },
  Task_10492_Name = {
    Text = "Complète le Niveau"
  },
  Task_10493_Desc = {
    Text = "Niveau terminé"
  },
  Task_10493_Name = {
    Text = "Complète le Niveau"
  },
  Task_10494_Desc = {
    Text = "Niveau terminé"
  },
  Task_10494_Name = {
    Text = "Complète le Niveau"
  },
  Task_10495_Desc = {
    Text = "Niveau terminé"
  },
  Task_10495_Name = {
    Text = "Complète le Niveau"
  },
  Task_10496_Desc = {
    Text = "Niveau terminé"
  },
  Task_10496_Name = {
    Text = "Complète le Niveau"
  },
  Task_10497_Desc = {
    Text = "Terminez 30 Plongées Fantasmagoriques"
  },
  Task_10497_Name = {
    Text = "Plongeur Profond III"
  },
  Task_10498_Desc = {
    Text = "Compléter 60 Plongées Fantasmiques"
  },
  Task_10498_Name = {
    Text = "Plongeur Abyssal IV"
  },
  Task_10499_Desc = {
    Text = "Terminez 1 Plongée Fantasmagorique"
  },
  Task_10499_Name = {
    Text = "Plongeur profond"
  },
  Task_10500_Desc = {
    Text = "Terminez 15 Plongées Fantasmagoriques"
  },
  Task_10500_Name = {
    Text = "Plongeur Profond II"
  },
  Task_10501_Desc = {
    Text = "Inflige 800 dégâts"
  },
  Task_10501_Name = {
    Text = "Dégâts forts III"
  },
  Task_10502_Desc = {
    Text = "Infligez 1000 Dégâts"
  },
  Task_10502_Name = {
    Text = "Dégâts forts IV"
  },
  Task_10503_Desc = {
    Text = "Inflige 200 dégâts"
  },
  Task_10503_Name = {
    Text = "Dégâts forts"
  },
  Task_10504_Desc = {
    Text = "Inflige 400 dégâts"
  },
  Task_10504_Name = {
    Text = "Dégâts forts II"
  },
  Task_10505_Desc = {
    Text = "Inflige 5000 Dégâts"
  },
  Task_10505_Name = {
    Text = "Dégâts fatals V"
  },
  Task_10506_Desc = {
    Text = "Infliger 500 piles de Poison à l'ennemi"
  },
  Task_10506_Name = {
    Text = "Toxicologist"
  },
  Task_10507_Desc = {
    Text = "Arrêter Aigis"
  },
  Task_10507_Name = {Text = "Objectif"},
  Task_10510_Desc = {
    Text = "Infligez 1000 ou plus de dégâts en un seul tour durant des batailles élites spécifiques (X)."
  },
  Task_10510_Name = {
    Text = "Carnaval Frissonnement"
  },
  Task_10511_Desc = {
    Text = "Utilisez Exalt 5 fois en un seul tour dans un type de bataille spécifique X"
  },
  Task_10511_Name = {
    Text = "Folie en chaîne"
  },
  Task_10512_Desc = {
    Text = "Utilisez la fonction de récupération de camp ≤1 fois pendant la partie."
  },
  Task_10512_Name = {Text = "Planque"},
  Task_10513_Desc = {
    Text = "Lorsque vous complétez un niveau, le taux d'exploration de la carte du camp doit être supérieur ou égal à 80 %."
  },
  Task_10513_Name = {
    Text = "Ouvre les yeux"
  },
  Task_10514_Desc = {
    Text = "Le nombre de Cartes de Type X est inférieur ou égal à 3 lors du passage du niveau."
  },
  Task_10514_Name = {
    Text = "Frontière de l'immunité"
  },
  Task_10515_Desc = {
    Text = "Lorsque le nombre de cartes de type X est supérieur ou égal à 3 lors du nettoyage"
  },
  Task_10515_Name = {
    Text = "État critique"
  },
  Task_10516_Desc = {
    Text = "Avoir ≥3 Reliques de Type X Précis (X Or)"
  },
  Task_10516_Name = {
    Text = "Chercheur d'or"
  },
  Task_10517_Desc = {
    Text = "Avoir ≥2 Types d'Oraison à l'achèvement (Inspiration et Inspiration avancée sont considérées comme identiques)"
  },
  Task_10517_Name = {
    Text = "Collecteur d'Orison"
  },
  Task_10518_Desc = {
    Text = "Réveillez au moins 2 Réveilleurs à l'achèvement"
  },
  Task_10518_Name = {
    Text = "Réveille-toi"
  },
  Task_10519_Desc = {
    Text = "Complétez la scène avec au moins 2 Réveilleurs de Chaos"
  },
  Task_10519_Name = {
    Text = "Ascension dans le chaos"
  },
  Task_10520_Desc = {
    Text = "Repoussez les croyants de la Lumière du Temple qui attaquent"
  },
  Task_10520_Name = {Text = "Objectif"},
  Task_10521_Desc = {
    Text = "Gagner du temps pour dessiner le cercle magique"
  },
  Task_10521_Name = {Text = "Objectif"},
  Task_10523_Desc = {
    Text = "Améliorez n'importe quel skill de Réveilleur au niveau 3"
  },
  Task_10523_Name = {Text = "Quête 2"},
  Task_10524_Desc = {
    Text = "Compléter l'Événement d'Investigation Principale · Difficile 1-8"
  },
  Task_10524_Name = {Text = "Quête 3"},
  Task_10525_Desc = {
    Text = "Élever 4 Réveilleurs au niveau 40"
  },
  Task_10525_Name = {Text = "Tâche 1"},
  Task_10526_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_10526_Name = {
    Text = "Résolution rapide"
  },
  Task_10527_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_10527_Name = {
    Text = "Résolution rapide"
  },
  Task_10528_Desc = {
    Text = "Complétez 100 Affinements d'Élixir"
  },
  Task_10528_Name = {
    Text = "Genius Pharmacien II"
  },
  Task_10529_Desc = {
    Text = "Éliminez Fissure du Domaine du Chaos VI"
  },
  Task_10529_Name = {Text = "Quête 5"},
  Task_10530_Desc = {
    Text = "Bataille finale avec Hilote"
  },
  Task_10530_Name = {Text = "Objectif"},
  Task_10531_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_10531_Name = {
    Text = "Résolution rapide"
  },
  Task_10532_Desc = {
    Text = "Terminez 200 Recherches de Billets en Or"
  },
  Task_10532_Name = {
    Text = "Mineur d'or III"
  },
  Task_10533_Desc = {
    Text = "Aider la poupée à repousser les croyants de la Lumière du Temple"
  },
  Task_10533_Name = {Text = "Objectif"},
  Task_10534_Desc = {
    Text = "Compléter 50 Recherches de Billet d'Or"
  },
  Task_10534_Name = {
    Text = "Chercheur d'or"
  },
  Task_10535_Desc = {
    Text = "Complétez 100 Investigations de Bon de D'or"
  },
  Task_10535_Name = {
    Text = "Prospecteur d'or II"
  },
  Task_10536_Desc = {
    Text = "Niveau terminé"
  },
  Task_10536_Name = {
    Text = "Complète le Niveau"
  },
  Task_10537_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_10537_Name = {
    Text = "Résolution rapide"
  },
  Task_10538_CompleteCondDesc = {
    Text = "Niveau d'assignement total>={s1}"
  },
  Task_10538_Desc = {
    Text = "Parfois, l'envie de détruire est l'envie de créer.\nPrenez votre pinceau ; l'art ne nécessite pas de préparation."
  },
  Task_10538_Name = {
    Text = "Mission : dadaïsme"
  },
  Task_10538_UnlockCondDesc = {
    Text = "Débloqué après avoir complété l'Événement d'Investigation 1-13"
  },
  Task_10539_Desc = {
    Text = "Complète toutes les tâches dans la phase pour réclamer des récompenses"
  },
  Task_10539_Name = {Text = "Phase deux"},
  Task_10540_Desc = {
    Text = "Compléter la Mission Principale d'Investigation Chapitre 1 « Secret de l'Est » en Difficile"
  },
  Task_10544_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10544_Name = {
    Text = "Passer Parfait"
  },
  Task_10545_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10545_Name = {
    Text = "Passer Parfait"
  },
  Task_10546_Desc = {
    Text = "Connexion cumulative pendant 2 jours"
  },
  Task_10546_Name = {
    Text = "Bonjour, gardien"
  },
  Task_10547_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10547_Name = {
    Text = "Passer Parfait"
  },
  Task_10548_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10548_Name = {
    Text = "Passer Parfait"
  },
  Task_10549_Desc = {
    Text = "Éliminez Fissure du Domaine du Chaos I"
  },
  Task_10550_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10550_Name = {
    Text = "Passer Parfait"
  },
  Task_10552_Desc = {
    Text = "Avoir au moins 2 Reliques lors de l'achèvement"
  },
  Task_10552_Name = {
    Text = "Pouvoir des reliques"
  },
  Task_10553_Desc = {
    Text = "Avoir au moins 5 Cartes d'Oraison lors de l'achèvement"
  },
  Task_10553_Name = {
    Text = "Pouvoir d'oraison"
  },
  Task_10554_Desc = {
    Text = "Avoir pas plus de 2 Symptômes lors de l'achèvement"
  },
  Task_10554_Name = {Text = "Refreshing"},
  Task_10555_Desc = {
    Text = "Complète toutes les tâches dans ce chapitre pour réclamer des récompenses."
  },
  Task_10555_Name = {
    Text = "Maîtrise de Royaume III"
  },
  Task_10556_Desc = {
    Text = "Complète le niveau en 33 étapes"
  },
  Task_10556_Name = {
    Text = "Planification stratégique"
  },
  Task_10557_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10557_Name = {
    Text = "Passer Parfait"
  },
  Task_10558_Desc = {
    Text = "Complétez la scène en jusqu'à 5 batailles."
  },
  Task_10558_Name = {
    Text = "Frappe précise"
  },
  Task_10565_CompleteCondDesc = {
    Text = "Niveau d'assignement total>={s1}"
  },
  Task_10565_Desc = {
    Text = "Ses instincts, sa raison, et son cœur sont scellés dans un petit flacon en verre.\nLe monde n'est plus son souci."
  },
  Task_10565_Name = {
    Text = "Mission : dissociation"
  },
  Task_10565_UnlockCondDesc = {
    Text = "Débloqué après avoir complété l'Événement d'Investigation 1-13"
  },
  Task_10571_Desc = {
    Text = "Effectuez la cérémonie de Réveil 150 fois"
  },
  Task_10571_Name = {
    Text = "Gardien de Génie III"
  },
  Task_10572_Desc = {
    Text = "Effectuez la cérémonie de Réveil 100 fois"
  },
  Task_10572_Name = {
    Text = "Gardien de Génie II"
  },
  Task_10575_Desc = {
    Text = "Édifier un Réveilleur du Royaume Caro au Niveau 5"
  },
  Task_10575_Name = {
    Text = "Caro Maîtrise V"
  },
  Task_10576_Desc = {
    Text = "Édifier un Réveiller de Royaume des Profondeurs à Niveau 5"
  },
  Task_10576_Name = {
    Text = "Aequor Maîtrise V"
  },
  Task_10577_Desc = {
    Text = "Effectuez la cérémonie de Réveil 50 fois"
  },
  Task_10577_Name = {
    Text = "Génie gardien des secrets"
  },
  Task_10578_Desc = {
    Text = "Édifier un Réveiller de Royaume Ultra à Niveau 5"
  },
  Task_10578_Name = {
    Text = "Maîtrise Ultra V"
  },
  Task_10579_Desc = {
    Text = "A 12 Pactes de niveau 9"
  },
  Task_10579_Name = {
    Text = "Collecteur de Pacte II"
  },
  Task_10580_Desc = {
    Text = "Posséder 6 Pactes de niveau 6"
  },
  Task_10580_Name = {
    Text = "Collecteur de contrats"
  },
  Task_10581_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_10581_Name = {
    Text = "Résolution rapide"
  },
  Task_10582_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_10582_Name = {
    Text = "Résolution rapide"
  },
  Task_10583_Desc = {
    Text = "Suivre les vestiges de la trace de Francis"
  },
  Task_10583_Name = {Text = "Objectif"},
  Task_10584_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_10584_Name = {
    Text = "Résolution rapide"
  },
  Task_10585_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_10585_Name = {
    Text = "Résolution rapide"
  },
  Task_10586_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_10586_Name = {
    Text = "Résolution rapide"
  },
  Task_10587_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_10587_Name = {
    Text = "Résolution rapide"
  },
  Task_10588_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_10588_Name = {
    Text = "Résolution rapide"
  },
  Task_10589_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_10589_Name = {
    Text = "Résolution rapide"
  },
  Task_10590_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_10590_Name = {
    Text = "Résolution rapide"
  },
  Task_10591_Desc = {
    Text = "Avoir pas plus de 3 Symptômes lors de l'achèvement"
  },
  Task_10591_Name = {Text = "Refreshing"},
  Task_10592_Desc = {
    Text = "Rentrer dans l'Asile de Lai"
  },
  Task_10592_Name = {Text = "Objectif"},
  Task_10593_Desc = {
    Text = "Gagner la bataille finale en moins de 15 tours"
  },
  Task_10593_Name = {
    Text = "Gagner la bataille finale en moins de 15 tours"
  },
  Task_10595_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10595_Name = {
    Text = "Passer Parfait"
  },
  Task_10596_Desc = {
    Text = "Échapper du champ de neige"
  },
  Task_10596_Name = {Text = "Objectif"},
  Task_10597_Desc = {
    Text = "Exécutez 3 missions"
  },
  Task_10597_Name = {
    Text = "Effectuer une mission"
  },
  Task_10598_Desc = {
    Text = "Vaincre en 38 tours"
  },
  Task_10598_Name = {
    Text = "Vaincre en 38 tours"
  },
  Task_10599_Desc = {
    Text = "Consommez 2500000 rose dorée"
  },
  Task_10599_Name = {
    Text = "Dépensier III"
  },
  Task_10600_Desc = {
    Text = "Connectez-vous au jeu"
  },
  Task_10600_Name = {
    Text = "Connectez-vous au jeu"
  },
  Task_10601_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10601_Name = {
    Text = "Passer Parfait"
  },
  Task_10602_Desc = {
    Text = "Niveau terminé"
  },
  Task_10602_Name = {
    Text = "Complète le Niveau"
  },
  Task_10603_Desc = {
    Text = "Réveillez tous les Réveilleurs à l'achèvement"
  },
  Task_10603_Name = {
    Text = "Dernière arrivée"
  },
  Task_10604_Desc = {
    Text = "Avoir au moins 4 Reliques lors de l'achèvement"
  },
  Task_10604_Name = {
    Text = "Pouvoir des reliques"
  },
  Task_10605_Desc = {
    Text = "Niveau terminé"
  },
  Task_10605_Name = {
    Text = "Complète le Niveau"
  },
  Task_10606_Desc = {
    Text = "Avoir pas plus de 1 Symptôme lors de l'achèvement"
  },
  Task_10606_Name = {Text = "Refreshing"},
  Task_10607_Desc = {
    Text = "Avoir au moins 8 Cartes d'Oraison lors de l'achèvement"
  },
  Task_10607_Name = {
    Text = "Pouvoir d'oraison"
  },
  Task_10608_Desc = {
    Text = "Le Gardien atteint le niveau 25"
  },
  Task_10608_Name = {
    Text = "Épreuve du Gardien III"
  },
  Task_10609_Desc = {
    Text = "Clair le jeu avec un total de 4 ou moins d'Exalts dans toutes les Batailles."
  },
  Task_10609_Name = {
    Text = "Calme et élégant"
  },
  Task_10610_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10610_Name = {
    Text = "Passer Parfait"
  },
  Task_10611_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_10611_Name = {
    Text = "La sécurité avant tout"
  },
  Task_10612_Desc = {
    Text = "Complétez la scène en jusqu'à 3 batailles."
  },
  Task_10612_Name = {
    Text = "Frappe précise"
  },
  Task_10613_Desc = {
    Text = "Avoir au moins 50 sigils noirs à l'issue"
  },
  Task_10613_Name = {
    Text = "Sauvegarder pour plus tard"
  },
  Task_10614_Desc = {
    Text = "Atteindre le Niveau d'Affinité 3 avec 16 Réveilleurs"
  },
  Task_10614_Name = {
    Text = "Partenaire Parfait VII"
  },
  Task_10616_Desc = {
    Text = "Posséder quatre Réveilleurs Profondeur de niveau 40"
  },
  Task_10616_Name = {
    Text = "Seigneur des Profondeurs IV"
  },
  Task_10618_Desc = {
    Text = "Vaincre en 48 tours"
  },
  Task_10618_Name = {
    Text = "Vaincre en 48 tours"
  },
  Task_10619_Desc = {
    Text = "Vaincre en 53 tours"
  },
  Task_10619_Name = {
    Text = "Vaincre en 53 tours"
  },
  Task_10620_Desc = {
    Text = "Investiguer 30 images après-dimensionnelles"
  },
  Task_10620_Name = {
    Text = "Ruines Ultra II"
  },
  Task_10621_Desc = {
    Text = "Investiguer 60 images après-dimensionnelles"
  },
  Task_10621_Name = {
    Text = "Ruines Ultra III"
  },
  Task_10622_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10622_Name = {
    Text = "Passer Parfait"
  },
  Task_10623_Desc = {
    Text = "Investiguer 15 images après-dimensionnelles"
  },
  Task_10623_Name = {
    Text = "Ruines de l'hyperdimension"
  },
  Task_10624_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10624_Name = {
    Text = "Passer Parfait"
  },
  Task_10625_Desc = {
    Text = "Investiguer 120 instances d'images après-structure"
  },
  Task_10625_Name = {
    Text = "Ruines de Caro IV"
  },
  Task_10626_Desc = {
    Text = "Investiguer 15 instances d'images après-organiques"
  },
  Task_10626_Name = {
    Text = "Ruines de caro"
  },
  Task_10627_Desc = {
    Text = "Investiguer 30 instances d'images après-structure"
  },
  Task_10627_Name = {
    Text = "Ruines de Caro II"
  },
  Task_10628_Desc = {
    Text = "Complète le défi en jusqu'à 6 batailles."
  },
  Task_10628_Name = {
    Text = "Frappe précise"
  },
  Task_10629_Desc = {
    Text = "Investiguer 240 images après-abysse"
  },
  Task_10629_Name = {
    Text = "Ruines Aequor V"
  },
  Task_10630_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10630_Name = {
    Text = "Passer Parfait"
  },
  Task_10631_Desc = {
    Text = "Dans la Bataille Spécifique X (Normale), tue 3 monstres ou plus en un seul tour."
  },
  Task_10631_Name = {
    Text = "Temps de chasse"
  },
  Task_10632_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10632_Name = {
    Text = "Passer Parfait"
  },
  Task_10633_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10633_Name = {
    Text = "Passer Parfait"
  },
  Task_10634_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10634_Name = {
    Text = "Passer Parfait"
  },
  Task_10635_Desc = {
    Text = "Avoir au moins 5 Reliques lors de l'achèvement"
  },
  Task_10635_Name = {
    Text = "Pouvoir des reliques"
  },
  Task_10636_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10636_Name = {
    Text = "Passer Parfait"
  },
  Task_10637_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10637_Name = {
    Text = "Passer Parfait"
  },
  Task_10638_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10638_Name = {
    Text = "Passer Parfait"
  },
  Task_10639_Desc = {
    Text = "Complète toutes les tâches dans la phase pour réclamer des récompenses"
  },
  Task_10639_Name = {
    Text = "Phase quatre"
  },
  Task_10640_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10640_Name = {
    Text = "Passer Parfait"
  },
  Task_10641_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10641_Name = {
    Text = "Passer Parfait"
  },
  Task_10642_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10642_Name = {
    Text = "Passer Parfait"
  },
  Task_10643_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10643_Name = {
    Text = "Passer Parfait"
  },
  Task_10644_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10644_Name = {
    Text = "Passer Parfait"
  },
  Task_10645_Desc = {
    Text = "Édifier un Réveiller de Royaume Ultra à Niveau 1"
  },
  Task_10645_Name = {
    Text = "Maîtrise Ultra I"
  },
  Task_10646_Desc = {
    Text = "Niveau terminé"
  },
  Task_10646_Name = {
    Text = "Complète le Niveau"
  },
  Task_10647_Desc = {
    Text = "Édifier 1 Réveilleur du Royaume du Chaos au Niveau 1"
  },
  Task_10647_Name = {
    Text = "Maîtrise du Chaos I"
  },
  Task_10648_Desc = {
    Text = "Édifier un Réveilleur du Royaume Caro au Niveau 1"
  },
  Task_10648_Name = {
    Text = "Caro Maîtrise I"
  },
  Task_10649_Desc = {
    Text = "Édifier un Réveilleur du Royaume des Profondeurs au Niveau 1"
  },
  Task_10649_Name = {
    Text = "Aequor Maîtrise I"
  },
  Task_10650_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_10650_Name = {
    Text = "La sécurité avant tout"
  },
  Task_10651_Desc = {
    Text = "Niveau terminé"
  },
  Task_10651_Name = {
    Text = "Complète le Niveau"
  },
  Task_10652_Desc = {
    Text = "Compléter l'événement d'investigation \"@1@2\""
  },
  Task_10652_Desc2 = {
    Text = "Complete Investigation Event \"In the Name of Wax Sculpture\""
  },
  Task_10652_Name = {Text = "@2@3"},
  Task_10652_Name2 = {
    Text = "Énigmes dans la cire"
  },
  Task_10653_Desc = {
    Text = "Résonner 3 fois dans l'événement d'investigation « Secret de l'Est »"
  },
  Task_10653_Name = {
    Text = "Écho de gratitude"
  },
  Task_10654_Desc = {
    Text = "Connexion cumulative pendant 30 jours"
  },
  Task_10654_Name = {
    Text = "L'activiste"
  },
  Task_10656_Desc = {
    Text = "Compléter le Royaume des Ténèbres VII (Inachevé)"
  },
  Task_10656_Name = {
    Text = "Le sculpteur"
  },
  Task_10658_Desc = {
    Text = "Chaque match : 30 points"
  },
  Task_10658_Name = {
    Text = "Victoire en bataille <size=20><color=#747474>30 points par match</color></size>"
  },
  Task_10660_Desc = {Text = "Craquement"},
  Task_10660_Name = {Text = "Craquement"},
  Task_10661_Desc = {
    Text = "Niveau terminé"
  },
  Task_10661_Name = {
    Text = "Complète le Niveau"
  },
  Task_10663_Desc = {
    Text = "Connexion Cumulative de 7 Jours"
  },
  Task_10663_Name = {Text = "Lève-tôt"},
  Task_10664_Desc = {
    Text = "Complète le niveau en moins de 50 mouvements"
  },
  Task_10664_Name = {
    Text = "Planification stratégique"
  },
  Task_10665_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_10665_Name = {
    Text = "La sécurité avant tout"
  },
  Task_10666_Desc = {
    Text = "Complétez la scène en jusqu'à 7 batailles."
  },
  Task_10666_Name = {
    Text = "Frappe précise"
  },
  Task_10667_Desc = {
    Text = "Améliorez 4 Éveilleurs au Niveau 60"
  },
  Task_10667_Name = {Text = "Tâche 1"},
  Task_10668_Desc = {
    Text = "Complétez 20 Opérations Offensives/Exercices Défensifs/Missions Coopératives"
  },
  Task_10668_Name = {
    Text = "Livre de Matériaux de Compétence (Inactif)"
  },
  Task_10669_Desc = {
    Text = "Complétez l'étape principale de l'enquête 10 fois"
  },
  Task_10669_Name = {
    Text = "Livre de quêtes principales (inactif)"
  },
  Task_10670_Desc = {
    Text = "Éliminez Fissure des Marais Caro I"
  },
  Task_10671_Desc = {
    Text = "Échangez 3 fois en utilisant des Roses dorées dans la boutique"
  },
  Task_10671_Name = {Text = "Achat d'or"},
  Task_10672_Desc = {
    Text = "Comme tes anciens élèves 10 fois"
  },
  Task_10672_Name = {Text = "Like d'ami"},
  Task_10673_Desc = {
    Text = "Compléter l'Existence Transcendante une fois"
  },
  Task_10673_Name = {
    Text = "Boss Hebdomadaire"
  },
  Task_10674_Desc = {
    Text = "Participer à Traphase 3 fois"
  },
  Task_10674_Name = {
    Text = "Bataille PVP"
  },
  Task_10675_Desc = {
    Text = "Complétez les Épreuves Hebdomadaires"
  },
  Task_10675_Name = {
    Text = "Épreuve hebdomadaire"
  },
  Task_10676_Desc = {
    Text = "Utilisez le soutien 3 fois"
  },
  Task_10676_Name = {
    Text = "Soutien ami"
  },
  Task_10677_Desc = {
    Text = "Les points accumulés cette semaine pour Phantasmal Dive ont atteint 1800."
  },
  Task_10677_Name = {
    Text = "Plongée fantomale"
  },
  Task_10678_Desc = {
    Text = "Gagnez 3 points pour chaque Sigil Noir restant à l'achèvement, jusqu'à un maximum de 600 points."
  },
  Task_10678_Name = {
    Text = "Le Signe Noir <size=20><color=#747474>Chaque Signe Noir restant rapporte 3 points à la fin de la course, jusqu'à un maximum de 600 points</color></size>"
  },
  Task_10679_Desc = {
    Text = "Gagner la Bataille Finale en moins de 15 tours"
  },
  Task_10679_Name = {
    Text = "Résolution rapide"
  },
  Task_10680_CompleteCondDesc = {
    Text = "Niveau d'assignement total>={s1}"
  },
  Task_10680_Desc = {
    Text = "Dimensions, espace, quantique... Peut-être que tu ne pourras jamais comprendre les significations profondes derrière ces mots. \nTout comme tu ne peux comprendre la plupart des choses se passant dans ce monde."
  },
  Task_10680_Name = {
    Text = "Recherche : chant violet"
  },
  Task_10680_UnlockCondDesc = {
    Text = "Le Gardien débloqué au niveau 25"
  },
  Task_10681_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 80%"
  },
  Task_10681_Name = {
    Text = "La sécurité avant tout"
  },
  Task_10682_Desc = {
    Text = "Gagnez la bataille finale en 25 tours"
  },
  Task_10682_Name = {
    Text = "Gagnez la bataille finale en 25 tours"
  },
  Task_10683_Desc = {
    Text = "Édifier 1 Réveilleur du Royaume du Chaos au Niveau 2"
  },
  Task_10683_Name = {
    Text = "Maîtrise du chaos II"
  },
  Task_10684_Desc = {
    Text = "Résonnez 8 fois dans l'événement d'investigation \"@1@2\""
  },
  Task_10684_Desc2 = {
    Text = "Résonner 8 fois dans l'événement d'enquête \"Watch out for Dogs\"."
  },
  Task_10684_Name = {Text = "@2@3"},
  Task_10684_Name2 = {
    Text = "Écho de Résilience III"
  },
  Task_10685_Desc = {
    Text = "Complétez la scène avec au moins 2 Réveilleurs de Chaos"
  },
  Task_10685_Name = {
    Text = "Ascension dans le chaos"
  },
  Task_10686_Desc = {
    Text = "Avoir au moins 3 Reliques lors de l'achèvement"
  },
  Task_10686_Name = {
    Text = "Pouvoir des reliques"
  },
  Task_10687_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_10687_Name = {
    Text = "La sécurité avant tout"
  },
  Task_10688_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_10688_Name = {
    Text = "La sécurité avant tout"
  },
  Task_10689_Desc = {
    Text = "Complète le niveau en 30 étapes"
  },
  Task_10689_Name = {
    Text = "Planification stratégique"
  },
  Task_10690_Desc = {
    Text = "Réveillez tous les Réveilleurs à l'achèvement"
  },
  Task_10690_Name = {
    Text = "Dernière arrivée"
  },
  Task_10691_Desc = {
    Text = "Complétez la scène avec au moins 2 Réveilleurs de Chaos"
  },
  Task_10691_Name = {
    Text = "Ascension dans le chaos"
  },
  Task_10692_Desc = {
    Text = "Complétez la scène avec au moins 2 Réveilleurs de Chaos"
  },
  Task_10692_Name = {
    Text = "Ascension dans le chaos"
  },
  Task_10693_Desc = {
    Text = "Éliminez la source de l'anomalie"
  },
  Task_10693_Name = {Text = "Objectif"},
  Task_10694_Desc = {
    Text = "Repoussez les croyants de la Lumière du Temple qui attaquent"
  },
  Task_10694_Name = {Text = "Objectif"},
  Task_10695_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10695_Name = {
    Text = "Passer Parfait"
  },
  Task_10696_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10696_Name = {
    Text = "Passer Parfait"
  },
  Task_10698_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10698_Name = {
    Text = "Passer Parfait"
  },
  Task_10706_Desc = {
    Text = "Renforcer le Pacte une fois (Incomplet)"
  },
  Task_10706_Name = {
    Text = "Accessoire Renforcement (Désactivé)"
  },
  Task_10707_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_10707_Name = {
    Text = "Résolution rapide"
  },
  Task_10708_Desc = {
    Text = "Complète le niveau en 35 étapes"
  },
  Task_10708_Name = {
    Text = "Planification stratégique"
  },
  Task_10710_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_10710_Name = {
    Text = "Résolution rapide"
  },
  Task_10713_Desc = {
    Text = "Édifier un Réveilleur du Royaume du Chaos au Niveau 5"
  },
  Task_10713_Name = {
    Text = "Maîtrise du Chaos V"
  },
  Task_10714_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_10714_Name = {
    Text = "Résolution rapide"
  },
  Task_10715_Desc = {
    Text = "Casser le siège"
  },
  Task_10715_Name = {Text = "Objectif"},
  Task_10716_Desc = {
    Text = "Le Gardien atteint le niveau 5"
  },
  Task_10716_Name = {
    Text = "Épreuve du Gardien I"
  },
  Task_10717_Desc = {
    Text = "Accumulatez au moins 1 500 Boucliers en un seul tour lors de la Bataille Finale."
  },
  Task_10717_Name = {
    Text = "Défense excessive"
  },
  Task_10720_Desc = {
    Text = "Clair Fissure Chaos VII"
  },
  Task_10720_Name = {Text = "Quête 5"},
  Task_10721_Desc = {
    Text = "Renforcez 6 Pactes à niveau 12"
  },
  Task_10721_Name = {Text = "Mission 4"},
  Task_10722_Desc = {
    Text = "Avoir au moins 8 Cartes d'Oraison lors de l'achèvement"
  },
  Task_10722_Name = {
    Text = "Pouvoir d'oraison"
  },
  Task_10723_Desc = {
    Text = "Clair le jeu avec un total de 4 ou moins d'Exalts dans toutes les Batailles."
  },
  Task_10723_Name = {
    Text = "Calme et élégant"
  },
  Task_10724_Desc = {
    Text = "Améliorez n'importe quel skill de Réveilleur au niveau 4"
  },
  Task_10724_Name = {Text = "Tâche 1"},
  Task_10725_Desc = {
    Text = "Accumulatez au moins 2 000 Boucliers en un seul tour lors de la Bataille Finale."
  },
  Task_10725_Name = {
    Text = "Défense excessive"
  },
  Task_10727_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10727_Name = {
    Text = "Passer Parfait"
  },
  Task_10728_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10728_Name = {
    Text = "Passer Parfait"
  },
  Task_10729_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10729_Name = {
    Text = "Passer Parfait"
  },
  Task_10733_CompleteCondDesc = {
    Text = "Niveau d'assignement total>={s1}"
  },
  Task_10733_Desc = {
    Text = "C'est la langue dans laquelle Dieu écrit l'univers.\nQuand tu l'écoutes, tu écoutes l'infini."
  },
  Task_10733_Name = {
    Text = "Mission : époque décolorée"
  },
  Task_10733_UnlockCondDesc = {
    Text = "Débloqué après avoir complété l'Événement d'Investigation 1-13"
  },
  Task_10734_Desc = {
    Text = "Compléter 600 Recherches de Bon d'Or"
  },
  Task_10734_Name = {
    Text = "Chercheur d'or V"
  },
  Task_10735_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_10735_Name = {
    Text = "Résolution rapide"
  },
  Task_10736_CompleteCondDesc = {
    Text = "Niveau d'assignement total>={s1}"
  },
  Task_10736_Desc = {
    Text = "En termes stricts, les Réveilleurs sont également une forme de Technologie des Pépites Argentées.\nVous devez faire de votre mieux pour vous assurer qu'ils ne prennent pas de retard."
  },
  Task_10736_Name = {
    Text = "Recherche : script d'infusion"
  },
  Task_10737_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10737_Name = {
    Text = "Passer Parfait"
  },
  Task_10738_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_10738_Name = {
    Text = "Résolution rapide"
  },
  Task_10739_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10739_Name = {
    Text = "Passer Parfait"
  },
  Task_10740_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10740_Name = {
    Text = "Passer Parfait"
  },
  Task_10741_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_10741_Name = {
    Text = "La sécurité avant tout"
  },
  Task_10742_Desc = {
    Text = "Avoir au moins 2 Reliques lors de l'achèvement"
  },
  Task_10742_Name = {
    Text = "Pouvoir des reliques"
  },
  Task_10743_Desc = {
    Text = "Complétez la scène avec au moins 2 Réveilleurs de Chaos"
  },
  Task_10743_Name = {
    Text = "Ascension dans le chaos"
  },
  Task_10744_Desc = {
    Text = "Complétez la scène en jusqu'à 5 batailles."
  },
  Task_10744_Name = {
    Text = "Frappe précise"
  },
  Task_10745_Desc = {
    Text = "Avoir pas plus de 3 Symptômes lors de l'achèvement"
  },
  Task_10745_Name = {Text = "Refreshing"},
  Task_10746_Desc = {
    Text = "Avoir au moins 100 Sigils Noirs lors de l'achèvement."
  },
  Task_10746_Name = {
    Text = "Sauvegarder pour plus tard"
  },
  Task_10747_Desc = {
    Text = "Complétez la scène avec au moins 2 Réveilleurs de Chaos"
  },
  Task_10747_Name = {
    Text = "Ascension dans le chaos"
  },
  Task_10748_Desc = {
    Text = "Réveillez tous les Réveilleurs à l'achèvement"
  },
  Task_10748_Name = {
    Text = "Dernière arrivée"
  },
  Task_10749_Desc = {
    Text = "Avoir au moins 4 Reliques lors de l'achèvement"
  },
  Task_10749_Name = {
    Text = "Pouvoir des reliques"
  },
  Task_10750_Desc = {
    Text = "Niveau terminé"
  },
  Task_10750_Name = {
    Text = "Complète le Niveau"
  },
  Task_10751_Desc = {
    Text = "Terminé en 88 tours"
  },
  Task_10751_Name = {
    Text = "Terminé en 88 tours"
  },
  Task_10752_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_10752_Name = {
    Text = "Résolution rapide"
  },
  Task_10753_Desc = {
    Text = "Résonner 3 fois dans l'enquête sur l'événement «@1@2»"
  },
  Task_10753_Desc2 = {
    Text = "Résonner 3 fois dans l'événement d'enquête \"In the Name of Wax Sculpture\""
  },
  Task_10753_Name = {Text = "@2@3"},
  Task_10753_Name2 = {
    Text = "Écho de convulsion"
  },
  Task_10754_Desc = {
    Text = "Résonner 6 fois dans l'enquête sur l'événement «@1@2»"
  },
  Task_10754_Desc2 = {
    Text = "Résonner 6 fois dans l'événement d'enquête \"In the Name of Wax Sculpture\""
  },
  Task_10754_Name = {Text = "@2@3"},
  Task_10754_Name2 = {
    Text = "Écho des Convulsions II"
  },
  Task_10755_Desc = {
    Text = "Résonnez 8 fois dans l'événement d'investigation \"@1@2\""
  },
  Task_10755_Desc2 = {
    Text = "Résonner 8 fois dans l'événement d'enquête \"In the Name of Wax Sculpture\""
  },
  Task_10755_Name = {Text = "@2@3"},
  Task_10755_Name2 = {
    Text = "Échos Convulsifs III"
  },
  Task_10756_Desc = {
    Text = "Résonner 3 fois dans l'enquête sur l'événement «@1@2»"
  },
  Task_10756_Desc2 = {
    Text = "Résonner 3 fois dans l'événement d'enquête \"Watch out for Dogs\""
  },
  Task_10756_Name = {Text = "@2@3"},
  Task_10756_Name2 = {
    Text = "Écho de retenue"
  },
  Task_10757_Desc = {
    Text = "Résonner 6 fois dans l'enquête sur l'événement «@1@2»"
  },
  Task_10757_Desc2 = {
    Text = "Résonner 6 fois dans l'événement d'enquête \"Watch out for Dogs\""
  },
  Task_10757_Name = {Text = "@2@3"},
  Task_10757_Name2 = {
    Text = "Écho de Persévérance II"
  },
  Task_10758_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_10758_Name = {
    Text = "Résolution rapide"
  },
  Task_10759_Desc = {
    Text = "Résonner 10 fois dans l'enquête sur l'événement «@1@2»"
  },
  Task_10759_Desc2 = {
    Text = "Résonnez 10 fois dans l'événement d'enquête \"Attention aux Chiens\""
  },
  Task_10759_Name = {Text = "@2@3"},
  Task_10759_Name2 = {
    Text = "Écho de la Résilience IV"
  },
  Task_10760_Desc = {
    Text = "Résonner 3 fois dans l'enquête sur l'événement «@1@2»"
  },
  Task_10760_Desc2 = {
    Text = "Résonnez 3 fois dans l'événement d'investigation \"Dans le Silence\""
  },
  Task_10760_Name = {Text = "@2@3"},
  Task_10760_Name2 = {
    Text = "Écho de l'angoisse"
  },
  Task_10761_Desc = {
    Text = "Résonner 6 fois dans l'enquête sur l'événement «@1@2»"
  },
  Task_10761_Desc2 = {
    Text = "Résonnez 6 fois dans l'événement d'investigation \"Dans le Silence\""
  },
  Task_10761_Name = {Text = "@2@3"},
  Task_10761_Name2 = {
    Text = "Écho de l'Agonie II"
  },
  Task_10762_Desc = {
    Text = "Résonnez 8 fois dans l'événement d'investigation \"@1@2\""
  },
  Task_10762_Desc2 = {
    Text = "Résonnez 8 fois dans l'événement d'investigation \"Dans le Silence\""
  },
  Task_10762_Name = {Text = "@2@3"},
  Task_10762_Name2 = {
    Text = "Écho d'Agonie III"
  },
  Task_10763_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_10763_Name = {
    Text = "Résolution rapide"
  },
  Task_10764_Desc = {
    Text = "Compléter \"Aequor\" une fois"
  },
  Task_10764_Name = {
    Text = "Escalade de Tour - Aequor"
  },
  Task_10765_Desc = {
    Text = "Gagner la Bataille Finale en moins de 15 tours"
  },
  Task_10765_Name = {
    Text = "Résolution rapide"
  },
  Task_10766_Desc = {
    Text = "Niveau terminé"
  },
  Task_10766_Name = {
    Text = "Complète le Niveau"
  },
  Task_10767_Desc = {
    Text = "Niveau terminé"
  },
  Task_10767_Name = {
    Text = "Complète le Niveau"
  },
  Task_10768_Desc = {
    Text = "Posséder quatre Réveilleurs Ultra de niveau 10"
  },
  Task_10768_Name = {
    Text = "Seigneur de l'ultra"
  },
  Task_10769_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_10769_Name = {
    Text = "La sécurité avant tout"
  },
  Task_10770_Desc = {
    Text = "Complète toutes les tâches dans ce chapitre pour réclamer des récompenses."
  },
  Task_10770_Name = {
    Text = "Maîtrise de Royaume V"
  },
  Task_10771_Desc = {
    Text = "Terminez le Royaume du Chaos une fois"
  },
  Task_10771_Name = {
    Text = "Escalade de Tour - Chaos"
  },
  Task_10772_Desc = {
    Text = "Complète le Voyage dans la Dimension Ultra une fois"
  },
  Task_10772_Name = {
    Text = "Escalade de Tour - Ultra"
  },
  Task_10773_Desc = {
    Text = "Terminez le Marais de Caro une fois"
  },
  Task_10773_Name = {
    Text = "Escalade de Tour - Caro"
  },
  Task_10774_Desc = {
    Text = "Clair la Zone d'effet régional une fois (les points d'entraînement atteignent 30)"
  },
  Task_10774_Name = {
    Text = "Zone d'effet D"
  },
  Task_10775_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10775_Name = {
    Text = "Passer Parfait"
  },
  Task_10776_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10776_Name = {
    Text = "Passer Parfait"
  },
  Task_10777_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10777_Name = {
    Text = "Passer Parfait"
  },
  Task_10778_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10778_Name = {
    Text = "Passer Parfait"
  },
  Task_10779_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10779_Name = {
    Text = "Passer Parfait"
  },
  Task_10780_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10780_Name = {
    Text = "Passer Parfait"
  },
  Task_10781_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10781_Name = {
    Text = "Passer Parfait"
  },
  Task_10782_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10782_Name = {
    Text = "Passer Parfait"
  },
  Task_10783_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10783_Name = {
    Text = "Passer Parfait"
  },
  Task_10784_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10784_Name = {
    Text = "Passer Parfait"
  },
  Task_10785_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10785_Name = {
    Text = "Passer Parfait"
  },
  Task_10786_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10786_Name = {
    Text = "Passer Parfait"
  },
  Task_10787_CompleteCondDesc = {
    Text = "Niveau d'assignement total>={s1}"
  },
  Task_10787_Desc = {
    Text = "Tout ce qui brille n'est pas or, mais c'est certainement précieux. \nLa légende dit que Mythag a été fondée par un groupe d'alchimistes reclus dont les ambitions allaient bien au-delà de la simple transmutation."
  },
  Task_10787_Name = {
    Text = "Recherche : codex de formules"
  },
  Task_10789_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10789_Name = {
    Text = "Passer Parfait"
  },
  Task_10790_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10790_Name = {
    Text = "Passer Parfait"
  },
  Task_10791_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10791_Name = {
    Text = "Passer Parfait"
  },
  Task_10792_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10792_Name = {
    Text = "Passer Parfait"
  },
  Task_10793_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10793_Name = {
    Text = "Passer Parfait"
  },
  Task_10794_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10794_Name = {
    Text = "Passer Parfait"
  },
  Task_10795_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10795_Name = {
    Text = "Passer Parfait"
  },
  Task_10796_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10796_Name = {
    Text = "Passer Parfait"
  },
  Task_10797_Desc = {
    Text = "Complétez la scène avec au moins 2 Réveilleurs de Chaos"
  },
  Task_10797_Name = {
    Text = "Ascension dans le chaos"
  },
  Task_10798_Desc = {
    Text = ": Inflige 2000 couches de poison à l'ennemi"
  },
  Task_10798_Name = {
    Text = "Expert en Toxicologie III"
  },
  Task_10799_Desc = {
    Text = "Appliquez 1000 stacks de Poison à l'ennemi"
  },
  Task_10799_Name = {
    Text = "Expert en Toxicologie II"
  },
  Task_10800_Desc = {
    Text = "Comptoir 4 ennemis et sécuriser la victoire"
  },
  Task_10800_Name = {
    Text = "Légitime défense"
  },
  Task_10801_Desc = {
    Text = ": Inflige 5000 couches de poison à l'ennemi"
  },
  Task_10801_Name = {
    Text = "Toxicologue IV"
  },
  Task_10802_Desc = {
    Text = "Lorsque vous nettoyez le donjon, ayez 30 cartes dans le deck."
  },
  Task_10802_Name = {
    Text = "Collectionneur de cartes"
  },
  Task_10803_Desc = {
    Text = "Vaincre 6 ennemis avec des dégâts critiques et assurer la victoire."
  },
  Task_10803_Name = {
    Text = "Violence soudaine"
  },
  Task_10804_Desc = {
    Text = "Défausse 30 cartes pendant une bataille et remporte la victoire."
  },
  Task_10804_Name = {
    Text = "Arrogance totale"
  },
  Task_10805_Desc = {
    Text = "Avoir 8 Cartes de Symptômes dans votre deck lors du nettoyage d'un donjon."
  },
  Task_10805_Name = {
    Text = "Maudit par le destin"
  },
  Task_10806_Desc = {
    Text = "Consommez 10 Arithmetica en un tour et atteignez la victoire."
  },
  Task_10806_Name = {
    Text = "Stratégie parfaite"
  },
  Task_10807_Desc = {
    Text = "Avoir 7 Reliques Lorsque Vous Nettoyez N'importe Quel Donjo"
  },
  Task_10807_Name = {
    Text = "Collecteur de reliques"
  },
  Task_10808_Desc = {
    Text = "Améliorez n'importe quel skill de Réveilleur au niveau 5"
  },
  Task_10808_Name = {Text = "Quête 2"},
  Task_10809_Desc = {
    Text = "Édifier un Réveilleur du Royaume du Chaos au Niveau 4"
  },
  Task_10809_Name = {
    Text = "Maîtrise du Chaos IV"
  },
  Task_10810_Desc = {
    Text = "Complétez 10 Transcriptions de Pacte"
  },
  Task_10810_Name = {Text = "Mission 4"},
  Task_10811_Desc = {
    Text = "Clair Fissure Chaos VIII"
  },
  Task_10811_Name = {Text = "Quête 5"},
  Task_10812_Desc = {
    Text = "Édifier un Réveiller de Royaume Ultra à Niveau 4"
  },
  Task_10812_Name = {
    Text = "Maîtrise Ultra IV"
  },
  Task_10814_Desc = {
    Text = "Niveau terminé"
  },
  Task_10814_Name = {
    Text = "Complète le Niveau"
  },
  Task_10815_Desc = {
    Text = "Avoir jusqu'à 6 Cartes d'Oraison lors de l'achèvement"
  },
  Task_10815_Name = {
    Text = "Orison supprimer"
  },
  Task_10817_Desc = {
    Text = "Complétez 50 Affinements de Potion"
  },
  Task_10817_Name = {
    Text = "Pharmacologue de génie"
  },
  Task_10818_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10818_Name = {
    Text = "Passer Parfait"
  },
  Task_10819_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10819_Name = {
    Text = "Passer Parfait"
  },
  Task_10820_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10820_Name = {
    Text = "Passer Parfait"
  },
  Task_10821_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10821_Name = {
    Text = "Passer Parfait"
  },
  Task_10822_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10822_Name = {
    Text = "Passer Parfait"
  },
  Task_10823_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10823_Name = {
    Text = "Passer Parfait"
  },
  Task_10824_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10824_Name = {
    Text = "Passer Parfait"
  },
  Task_10825_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_10825_Name = {
    Text = "Résolution rapide"
  },
  Task_10826_Desc = {
    Text = "Niveau terminé"
  },
  Task_10826_Name = {
    Text = "Complète le Niveau"
  },
  Task_10827_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10827_Name = {
    Text = "Passer Parfait"
  },
  Task_10828_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_10828_Name = {
    Text = "Résolution rapide"
  },
  Task_10830_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10830_Name = {
    Text = "Passer Parfait"
  },
  Task_10831_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10831_Name = {
    Text = "Passer Parfait"
  },
  Task_10832_Desc = {
    Text = "Niveau terminé"
  },
  Task_10832_Name = {
    Text = "Complète le Niveau"
  },
  Task_10833_Desc = {
    Text = "Niveau terminé"
  },
  Task_10833_Name = {
    Text = "Complète le Niveau"
  },
  Task_10834_Desc = {
    Text = "Avoir au moins 10 Cartes d'Oraison lors de l'achèvement."
  },
  Task_10834_Name = {
    Text = "Pouvoir d'oraison"
  },
  Task_10835_Desc = {
    Text = "Niveau terminé"
  },
  Task_10835_Name = {
    Text = "Complète le Niveau"
  },
  Task_10836_Desc = {
    Text = "Gagner la bataille finale en moins de 20 tours"
  },
  Task_10836_Name = {
    Text = "Gagner la bataille finale en moins de 20 tours"
  },
  Task_10839_Desc = {
    Text = "Complète le niveau en moins de 50 mouvements"
  },
  Task_10839_Name = {
    Text = "Planification stratégique"
  },
  Task_10840_Desc = {
    Text = "Vaincre en un total de 43 tours"
  },
  Task_10840_Name = {
    Text = "Vaincre en un total de 43 tours"
  },
  Task_10842_Desc = {
    Text = "Compléter l'Événement d'Investigation « Méfiez-vous des Chiens » en Difficile"
  },
  Task_10842_Name = {
    Text = "Le sculpteur"
  },
  Task_10844_Desc = {
    Text = "Édifier un Réveiller de Royaume des Profondeurs à Niveau 2"
  },
  Task_10844_Name = {
    Text = "Aequor Maîtrise II"
  },
  Task_10845_Desc = {
    Text = "Niveau terminé"
  },
  Task_10845_Name = {
    Text = "Complète le Niveau"
  },
  Task_10848_Desc = {
    Text = "Complète le niveau en 24 étapes"
  },
  Task_10848_Name = {
    Text = "Planification stratégique"
  },
  Task_10852_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10852_Name = {
    Text = "Passer Parfait"
  },
  Task_10853_Desc = {
    Text = "Niveau terminé"
  },
  Task_10853_Name = {
    Text = "Complète le Niveau"
  },
  Task_10854_Desc = {
    Text = "Niveau terminé"
  },
  Task_10854_Name = {
    Text = "Complète le Niveau"
  },
  Task_10855_Desc = {
    Text = "Niveau terminé"
  },
  Task_10855_Name = {
    Text = "Complète le Niveau"
  },
  Task_10857_Desc = {
    Text = "Niveau terminé"
  },
  Task_10857_Name = {
    Text = "Complète le Niveau"
  },
  Task_10858_Desc = {
    Text = "Niveau terminé"
  },
  Task_10858_Name = {
    Text = "Complète le Niveau"
  },
  Task_10859_Desc = {
    Text = "Niveau terminé"
  },
  Task_10859_Name = {
    Text = "Complète le Niveau"
  },
  Task_10860_Desc = {
    Text = "Niveau terminé"
  },
  Task_10860_Name = {
    Text = "Complète le Niveau"
  },
  Task_10861_Desc = {
    Text = "Niveau terminé"
  },
  Task_10861_Name = {
    Text = "Complète le Niveau"
  },
  Task_10862_Desc = {
    Text = "Niveau terminé"
  },
  Task_10862_Name = {
    Text = "Complète le Niveau"
  },
  Task_10863_Desc = {
    Text = "Niveau terminé"
  },
  Task_10863_Name = {
    Text = "Complète le Niveau"
  },
  Task_10864_Desc = {
    Text = "Niveau terminé"
  },
  Task_10864_Name = {
    Text = "Complète le Niveau"
  },
  Task_10865_Desc = {
    Text = "100 Cérémonies d'Éveil complétées"
  },
  Task_10865_Name = {
    Text = "<Tirer des cartes>"
  },
  Task_10866_Desc = {
    Text = "Niveau terminé"
  },
  Task_10866_Name = {
    Text = "Complète le Niveau"
  },
  Task_10867_Desc = {
    Text = "Niveau terminé"
  },
  Task_10867_Name = {
    Text = "Complète le Niveau"
  },
  Task_10868_Desc = {
    Text = "Niveau terminé"
  },
  Task_10868_Name = {
    Text = "Complète le Niveau"
  },
  Task_10869_Desc = {
    Text = "Clair le jeu avec un total de 4 ou moins d'Exalts dans toutes les Batailles."
  },
  Task_10869_Name = {
    Text = "Calme et élégant"
  },
  Task_10870_Desc = {
    Text = "Améliorez les Compétences de l'Éveilleur 100 fois"
  },
  Task_10870_Name = {
    Text = "Maîtrise de la compétence IV"
  },
  Task_10871_Desc = {
    Text = "Améliorez les Compétences de l'Éveilleur 200 fois"
  },
  Task_10871_Name = {
    Text = "Raffinement d'Art V"
  },
  Task_10872_Desc = {
    Text = "Posséder quatre Réveilleurs Ultra de niveau 60"
  },
  Task_10872_Name = {
    Text = "Seigneur Ultra VI"
  },
  Task_10873_Desc = {
    Text = "Améliorez les Compétences de l'Éveilleur 10 fois"
  },
  Task_10873_Name = {
    Text = "Perfectionnement des compétences"
  },
  Task_10874_Desc = {
    Text = "Améliorez les Compétences de l'Éveilleur 20 fois"
  },
  Task_10874_Name = {
    Text = "Maîtrise de la compétence II"
  },
  Task_10875_Desc = {
    Text = "Améliorez les Compétences de l'Éveilleur 50 fois"
  },
  Task_10875_Name = {
    Text = "Maîtrise de la compétence III"
  },
  Task_10876_Desc = {
    Text = "Posséder quatre Réveilleurs Ultra de niveau 20"
  },
  Task_10876_Name = {
    Text = "Maître Ultime II"
  },
  Task_10877_Desc = {
    Text = "Posséder quatre Réveilleurs Ultra de niveau 30"
  },
  Task_10877_Name = {
    Text = "Dimension Ultra III"
  },
  Task_10878_Desc = {
    Text = "Posséder quatre Réveilleurs Ultra de niveau 40"
  },
  Task_10878_Name = {
    Text = "Seigneur de Dimension Ultra IV"
  },
  Task_10879_Desc = {
    Text = "Posséder quatre Réveilleurs Ultra de niveau 50"
  },
  Task_10879_Name = {
    Text = "Seigneur de Dimension Ultra V"
  },
  Task_10880_Desc = {
    Text = "Compléter l'Événement d'Investigation Principale · Difficile 2-11"
  },
  Task_10880_Name = {Text = "Quête 3"},
  Task_10881_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_10881_Name = {
    Text = "La sécurité avant tout"
  },
  Task_10882_Desc = {
    Text = "Complète le niveau en 35 étapes"
  },
  Task_10882_Name = {
    Text = "Planification stratégique"
  },
  Task_10883_Desc = {
    Text = "Complète toutes les tâches dans ce chapitre pour réclamer des récompenses."
  },
  Task_10883_Name = {
    Text = "Maîtrise de Royaume II"
  },
  Task_10884_Desc = {
    Text = "Avoir au moins 8 Cartes d'Oraison lors de l'achèvement"
  },
  Task_10884_Name = {
    Text = "Pouvoir d'oraison"
  },
  Task_10885_Desc = {
    Text = "Complétez la scène avec au moins 2 Réveilleurs de Chaos"
  },
  Task_10885_Name = {
    Text = "Ascension dans le chaos"
  },
  Task_10886_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_10886_Name = {
    Text = "La sécurité avant tout"
  },
  Task_10887_Desc = {
    Text = "Gagnez la première bataille, défaites ces enfants et récupérez vos affaires."
  },
  Task_10887_Name = {
    Text = "Première bataille gagnée"
  },
  Task_10888_Desc = {
    Text = "Complète le niveau en 40 étapes."
  },
  Task_10888_Name = {
    Text = "Planification stratégique"
  },
  Task_10889_Desc = {
    Text = "Avoir jusqu'à 6 Cartes d'Oraison lors de l'achèvement"
  },
  Task_10889_Name = {
    Text = "Orison supprimer"
  },
  Task_10890_Desc = {
    Text = "Avoir au moins 10 Cartes d'Oraison lors de l'achèvement."
  },
  Task_10890_Name = {
    Text = "Pouvoir d'oraison"
  },
  Task_10892_Desc = {
    Text = "Complète le niveau en 28 mouvements"
  },
  Task_10892_Name = {
    Text = "Planification stratégique"
  },
  Task_10893_Desc = {
    Text = "Niveau terminé"
  },
  Task_10893_Name = {
    Text = "Complète le Niveau"
  },
  Task_10894_Desc = {
    Text = "Niveau terminé"
  },
  Task_10894_Name = {
    Text = "Complète le Niveau"
  },
  Task_10895_Desc = {
    Text = "Niveau terminé"
  },
  Task_10895_Name = {
    Text = "Complète le Niveau"
  },
  Task_10896_Desc = {
    Text = "Niveau terminé"
  },
  Task_10896_Name = {
    Text = "Complète le Niveau"
  },
  Task_10897_Desc = {
    Text = "Niveau terminé"
  },
  Task_10897_Name = {
    Text = "Complète le Niveau"
  },
  Task_10898_Desc = {
    Text = "Niveau terminé"
  },
  Task_10898_Name = {
    Text = "Complète le Niveau"
  },
  Task_10899_Desc = {
    Text = "Niveau terminé"
  },
  Task_10899_Name = {
    Text = "Complète le Niveau"
  },
  Task_10900_Desc = {
    Text = "Pour chaque 1% de Résistance à la Mort restant à la fin du niveau, tu gagnes 1 point, jusqu'à un maximum de 600 points."
  },
  Task_10900_Name = {
    Text = "Sans effort <size=20><color=#747474>Gagnez 1 point pour chaque 1% de Résistance restant à la fin, jusqu'à un maximum de 600 points</color></size>"
  },
  Task_10901_Desc = {
    Text = "Niveau terminé"
  },
  Task_10901_Name = {
    Text = "Complète le Niveau"
  },
  Task_10902_Desc = {
    Text = "Niveau terminé"
  },
  Task_10902_Name = {
    Text = "Complète le Niveau"
  },
  Task_10904_Desc = {
    Text = "Gagner la Bataille Finale en moins de 8 tours"
  },
  Task_10904_Name = {
    Text = "Résolution rapide"
  },
  Task_10905_Desc = {
    Text = "Bataille avec la Sculpture en Cire Souterraine"
  },
  Task_10905_Name = {Text = "Objectif"},
  Task_10906_Desc = {
    Text = "Avoir pas plus de 3 Symptômes lors de l'achèvement"
  },
  Task_10906_Name = {Text = "Refreshing"},
  Task_10907_Desc = {
    Text = "Complétez la scène en jusqu'à 7 batailles."
  },
  Task_10907_Name = {
    Text = "Frappe précise"
  },
  Task_10908_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10908_Name = {
    Text = "Passer Parfait"
  },
  Task_10909_Desc = {
    Text = "Le Gardien atteint le niveau 15"
  },
  Task_10909_Name = {
    Text = "Épreuve du Gardien II"
  },
  Task_10910_Desc = {
    Text = "Résonner 8 fois dans l'événement d'investigation « Secret de l'Est »"
  },
  Task_10910_Name = {
    Text = "Écho de la Gratitude III"
  },
  Task_10911_Desc = {
    Text = "Résonner 6 fois dans l'événement d'enquête \"East Mist\""
  },
  Task_10911_Name = {
    Text = "Écho de la Gratitude II"
  },
  Task_10912_Desc = {
    Text = "Édifier un Réveilleur du Royaume Caro au Niveau 2"
  },
  Task_10912_Name = {
    Text = "Caro Maîtrise II"
  },
  Task_10913_Desc = {
    Text = "Craquement, craquement... !!"
  },
  Task_10913_Name = {Text = "Craquement"},
  Task_10914_Desc = {
    Text = "Procéder au Bureau du Bibliothécaire"
  },
  Task_10914_Name = {Text = "Objectif"},
  Task_10915_Desc = {
    Text = "Atteindre le Niveau d'Affinité 5 avec 12 Réveilleurs"
  },
  Task_10915_Name = {
    Text = "Partenaire parfait VI"
  },
  Task_10916_Desc = {
    Text = "Complete Investigation Event \"East Secret\""
  },
  Task_10916_Name = {
    Text = "Feuille d'or"
  },
  Task_10917_Desc = {
    Text = "Atteindre le Niveau d'Affinité 5 avec 16 Réveilleurs"
  },
  Task_10917_Name = {
    Text = "Partenaire Parfait VIII"
  },
  Task_10918_Desc = {
    Text = "Compléter l'événement d'investigation \"@1@2\""
  },
  Task_10918_Desc2 = {
    Text = "Complete Investigation Event \"Watch Out for Dogs\""
  },
  Task_10918_Name = {Text = "@2@3"},
  Task_10918_Name2 = {
    Text = "L'œil au-delà des dimensions"
  },
  Task_10919_Desc = {
    Text = "Niveau terminé"
  },
  Task_10919_Name = {
    Text = "Complète le Niveau"
  },
  Task_10920_Desc = {
    Text = "Niveau terminé"
  },
  Task_10920_Name = {
    Text = "Complète le Niveau"
  },
  Task_10921_Desc = {
    Text = "Niveau terminé"
  },
  Task_10921_Name = {
    Text = "Complète le Niveau"
  },
  Task_10922_Desc = {
    Text = "Terminez 200 courses des Ruines Bonape"
  },
  Task_10922_Name = {
    Text = "Bénédiction de Ponape III"
  },
  Task_10923_Desc = {
    Text = "Complétez 100 courses des Ruines de Ponape"
  },
  Task_10923_Name = {
    Text = "Bénédiction de Bonape II"
  },
  Task_10924_Desc = {
    Text = "Terminez 400 Groupes de Chaos"
  },
  Task_10924_Name = {
    Text = "Théoricien des Groupes IV"
  },
  Task_10925_Desc = {
    Text = "Terminez 200 Groupes de Chaos"
  },
  Task_10925_Name = {
    Text = "Enthousiaste des Groupes III"
  },
  Task_10926_Desc = {
    Text = "Compléter 50 courses des Ruines de Ponape"
  },
  Task_10926_Name = {
    Text = "La bénédiction de Pohnpei"
  },
  Task_10927_Desc = {
    Text = "Compléter 600 Clusters de Chaos"
  },
  Task_10927_Name = {
    Text = "Théoricien des Groupes V"
  },
  Task_10928_Desc = {
    Text = "Investiguer 240 images après-dimensionnelles"
  },
  Task_10928_Name = {
    Text = "Ruines Ultra V"
  },
  Task_10929_Desc = {
    Text = "Investiguer 120 images après-dimensionnelles"
  },
  Task_10929_Name = {
    Text = "Ruines Ultra IV"
  },
  Task_10931_Desc = {
    Text = "Compléter 50 Clusters de Chaos"
  },
  Task_10931_Name = {
    Text = "Théoricien des essaims"
  },
  Task_10932_Desc = {
    Text = "Consommation cumulée de 2500 le sigil noir"
  },
  Task_10932_Name = {
    Text = "Invocation Noire IV"
  },
  Task_10933_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10933_Name = {
    Text = "Passer Parfait"
  },
  Task_10934_CompleteCondDesc = {
    Text = "Niveau d'assignement total>={s1}"
  },
  Task_10934_Desc = {
    Text = "Toute vie revient finalement à la mer.\nComme l'écoulement incessant du temps, cela marque le début de la fin."
  },
  Task_10934_Name = {
    Text = "Recherche : lamentation azur"
  },
  Task_10934_UnlockCondDesc = {
    Text = "Le Gardien débloqué au niveau 25"
  },
  Task_10935_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10935_Name = {
    Text = "Passer Parfait"
  },
  Task_10936_Desc = {
    Text = "Chaque tour : 60 points"
  },
  Task_10936_Name = {
    Text = "Vaincre les Élite <size=20><color=#747474>60 points par match</color></size>"
  },
  Task_10938_Desc = {
    Text = "A 18 Pactes de niveau 12"
  },
  Task_10938_Name = {
    Text = "Collecteur de Pacte III"
  },
  Task_10941_Desc = {
    Text = "Si aucun Réveilleur n'a plus d'une carte à la fin, gagnez 100 points."
  },
  Task_10941_Name = {
    Text = "Ignoré <size=20><color=#747474>Complet avec pas plus d'1 Carte par Éveillé</color></size>"
  },
  Task_10944_Desc = {
    Text = "Posséder quatre Réveilleurs Aequor de niveau 20"
  },
  Task_10944_Name = {
    Text = "Seigneur des Profondeurs II"
  },
  Task_10946_Desc = {
    Text = "Améliorez 4 Éveilleurs au Niveau 50"
  },
  Task_10946_Name = {Text = "Quête 2"},
  Task_10947_Desc = {
    Text = "Niveau terminé"
  },
  Task_10947_Name = {
    Text = "Objectif 1 : Copie en attente d'emballage"
  },
  Task_10948_Desc = {
    Text = "Enquête sur l'asile"
  },
  Task_10948_Name = {Text = "Objectif"},
  Task_10949_Desc = {
    Text = "Avoir pas plus de 1 Symptôme lors de l'achèvement"
  },
  Task_10949_Name = {Text = "Refreshing"},
  Task_10951_Desc = {
    Text = "Gagnez 1 point pour chaque 1 % de vie restante à la fin du niveau, jusqu'à un maximum de 100 points."
  },
  Task_10951_Name = {
    Text = "Vie restante <size=20><color=#747474>1 point par 1% de vie restante à la fin, jusqu'à 100 points</color></size>"
  },
  Task_10953_Desc = {
    Text = "Compléter le chapitre principal d'investigation 2 \"Au Nom des Sculptures en Cire\" à la difficulté Difficile"
  },
  Task_10954_Desc = {
    Text = "\"Calme\" les enfants en colère"
  },
  Task_10954_Name = {Text = "Objectif"},
  Task_10955_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_10955_Name = {
    Text = "Résolution rapide"
  },
  Task_10956_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_10956_Name = {
    Text = "Résolution rapide"
  },
  Task_10957_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_10957_Name = {
    Text = "Résolution rapide"
  },
  Task_10958_Desc = {
    Text = "Niveau terminé"
  },
  Task_10958_Name = {
    Text = "Complète le Niveau"
  },
  Task_10959_Desc = {
    Text = "Compléter le Royaume des Ténèbres III (Inachevé)"
  },
  Task_10962_Desc = {
    Text = "Niveau terminé"
  },
  Task_10962_Name = {
    Text = "Complète le Niveau"
  },
  Task_10963_Desc = {
    Text = "Complète le niveau en 35 étapes"
  },
  Task_10963_Name = {
    Text = "Planification stratégique"
  },
  Task_10964_Desc = {
    Text = "Niveau terminé"
  },
  Task_10964_Name = {
    Text = "Indice cible : max 8 caractères"
  },
  Task_10965_Desc = {
    Text = "Gagner la Bataille Finale en moins de 15 tours"
  },
  Task_10965_Name = {
    Text = "Résolution rapide"
  },
  Task_10966_Desc = {
    Text = "Complète le niveau en 40 étapes."
  },
  Task_10966_Name = {
    Text = "Planification stratégique"
  },
  Task_10969_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 80%"
  },
  Task_10969_Name = {
    Text = "La sécurité avant tout"
  },
  Task_10970_Desc = {
    Text = "Édifier un Réveiller de Royaume des Profondeurs à Niveau 4"
  },
  Task_10970_Name = {
    Text = "Aequor Maîtrise IV"
  },
  Task_10971_Desc = {
    Text = "Gagner la Bataille Finale en moins de 8 tours"
  },
  Task_10971_Name = {
    Text = "Résolution rapide"
  },
  Task_10972_Desc = {
    Text = "Édifier un Réveilleur du Royaume Caro au Niveau 4"
  },
  Task_10972_Name = {
    Text = "Caro Maîtrise IV"
  },
  Task_10973_Desc = {
    Text = "Complétez la scène en jusqu'à 7 batailles."
  },
  Task_10973_Name = {
    Text = "Frappe précise"
  },
  Task_10974_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10974_Name = {
    Text = "Passer Parfait"
  },
  Task_10975_CompleteCondDesc = {
    Text = "Niveau d'assignement total>={s1}"
  },
  Task_10975_Desc = {
    Text = "\"Cela réécrira votre cœur.\" \n\"C'est vrai ? Alors il doit être criblé de trous.\""
  },
  Task_10975_Name = {
    Text = "Mission : thérapie de l'imagerie"
  },
  Task_10975_UnlockCondDesc = {
    Text = "Débloqué après avoir complété l'Événement d'Investigation 1-13"
  },
  Task_10976_Desc = {
    Text = "Compléter l'Événement d'Investigation Principale · Difficile 4-12"
  },
  Task_10976_Name = {Text = "Quête 3"},
  Task_10977_Desc = {
    Text = "Vaincre en 26 tours"
  },
  Task_10977_Name = {
    Text = "Vaincre en 26 tours"
  },
  Task_10981_Desc = {
    Text = "Gagnez la bataille finale en 5 tours"
  },
  Task_10981_Name = {
    Text = "Gagnez la bataille finale en 5 tours"
  },
  Task_10982_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10982_Name = {
    Text = "Passer Parfait"
  },
  Task_10983_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10983_Name = {
    Text = "Passer Parfait"
  },
  Task_10984_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10984_Name = {
    Text = "Passer Parfait"
  },
  Task_10985_Desc = {
    Text = "Investiguer 60 instances d'images après-structure"
  },
  Task_10985_Name = {
    Text = "Ruines de Caro III"
  },
  Task_10986_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10986_Name = {
    Text = "Passer Parfait"
  },
  Task_10987_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_10987_Name = {
    Text = "Passer Parfait"
  },
  Task_10988_Desc = {
    Text = "Niveau terminé"
  },
  Task_10988_Name = {
    Text = "Complète le Niveau"
  },
  Task_10989_Desc = {
    Text = "Niveau terminé"
  },
  Task_10989_Name = {
    Text = "Complète le Niveau"
  },
  Task_10991_Desc = {
    Text = "Niveau terminé"
  },
  Task_10991_Name = {
    Text = "Complète le Niveau"
  },
  Task_10992_Desc = {
    Text = "Niveau terminé"
  },
  Task_10992_Name = {
    Text = "Complète le Niveau"
  },
  Task_10993_Desc = {
    Text = "Méfiez-vous de ce qui se cache dans l'ombre"
  },
  Task_10993_Name = {Text = "Objectif"},
  Task_10994_Desc = {
    Text = "Niveau terminé"
  },
  Task_10994_Name = {
    Text = "Complète le Niveau"
  },
  Task_10995_Desc = {
    Text = "Niveau terminé"
  },
  Task_10995_Name = {
    Text = "Complète le Niveau"
  },
  Task_10997_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_10997_Name = {
    Text = "La sécurité avant tout"
  },
  Task_10998_Desc = {
    Text = "Complétez la scène en jusqu'à 7 batailles."
  },
  Task_10998_Name = {
    Text = "Frappe précise"
  },
  Task_10999_Desc = {
    Text = "Gagner la Bataille Finale en moins de 7 tours"
  },
  Task_10999_Name = {
    Text = "Résolution rapide"
  },
  Task_11003_Desc = {
    Text = "Avoir pas plus de 1 Symptôme lors de l'achèvement"
  },
  Task_11003_Name = {Text = "Refreshing"},
  Task_11004_Desc = {
    Text = "Aidez Lotan à traquer les ennemis"
  },
  Task_11004_Name = {Text = "Objectif"},
  Task_11005_Desc = {
    Text = "Investiguer 120 images après-abysse"
  },
  Task_11005_Name = {
    Text = "Ruines Aequor IV"
  },
  Task_11006_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_11006_Name = {
    Text = "Passer Parfait"
  },
  Task_11007_Desc = {
    Text = "Compléter l'événement d'investigation \"@1@2\""
  },
  Task_11007_Desc2 = {
    Text = "Complétez l'événement d'enquête \"Dans le Silence\""
  },
  Task_11007_Name = {Text = "@2@3"},
  Task_11007_Name2 = {
    Text = "Maman, je ne ressens aucune douleur"
  },
  Task_11008_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_11008_Name = {
    Text = "Passer Parfait"
  },
  Task_11009_Desc = {
    Text = "Niveau terminé"
  },
  Task_11009_Name = {
    Text = "Complète le Niveau"
  },
  Task_11010_Desc = {
    Text = "Consommation cumulée de 5000 le sigil noir"
  },
  Task_11010_Name = {
    Text = "Invocation Noire V"
  },
  Task_11011_Desc = {
    Text = "Lorsque le pourcentage de HP restant est ≥ 80 au moment de la purification"
  },
  Task_11011_Name = {
    Text = "Un jeu d'enfant"
  },
  Task_11012_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_11012_Name = {
    Text = "Résolution rapide"
  },
  Task_11013_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_11013_Name = {
    Text = "Passer Parfait"
  },
  Task_11014_Desc = {
    Text = "Renforcez le Pacte 3 fois"
  },
  Task_11014_Name = {
    Text = "Test temporel 2 (inactif)"
  },
  Task_11015_Desc = {
    Text = "Améliorez le Réveilleur 3 fois"
  },
  Task_11015_Name = {
    Text = "Test temporel 1 (inactif)"
  },
  Task_11016_Desc = {
    Text = "Dans la Bataille X (Élite) spécifique, gagner ≥ 20 accumulations du statut Poison (Y)."
  },
  Task_11016_Name = {
    Text = "Dose addictive"
  },
  Task_11017_Desc = {
    Text = "Accumulatez au moins 1 500 Boucliers en un seul tour lors de la Bataille Finale."
  },
  Task_11017_Name = {
    Text = "Défense excessive"
  },
  Task_11018_Desc = {
    Text = "Accumulatez la consommation de 500 Sigils Noirs"
  },
  Task_11018_Name = {
    Text = "Invocation Noire II"
  },
  Task_11019_Desc = {
    Text = "Posséder quatre Réveilleurs Profondeur de niveau 30"
  },
  Task_11019_Name = {
    Text = "Seigneur des Profondeurs III"
  },
  Task_11020_Desc = {
    Text = "Niveau terminé"
  },
  Task_11020_Name = {
    Text = "Complète le Niveau"
  },
  Task_11021_Desc = {
    Text = "Posséder quatre Réveilleurs Profondeur de niveau 50"
  },
  Task_11021_Name = {
    Text = "Seigneur des Profondeurs V"
  },
  Task_11022_Desc = {
    Text = "Niveau terminé"
  },
  Task_11022_Name = {
    Text = "Complète le Niveau"
  },
  Task_11023_Desc = {
    Text = "Posséder 4 Éveilleurs Caro de niveau 50"
  },
  Task_11023_Name = {
    Text = "Maître de Caro V"
  },
  Task_11024_Desc = {
    Text = "Accumulatez la consommation de 250 Sigils Noirs"
  },
  Task_11024_Name = {Text = "Appel noir"},
  Task_11025_Desc = {
    Text = "Posséder quatre Réveilleurs Aequor de niveau 10"
  },
  Task_11025_Name = {
    Text = "Seigneur de l'aequor"
  },
  Task_11026_Desc = {
    Text = "Posséder 4 Éveilleurs Caro de niveau 60"
  },
  Task_11026_Name = {
    Text = "Maître de Caro VI"
  },
  Task_11027_Desc = {
    Text = "Dans la Bataille X spécifique, jouer 20 cartes ou plus en un tour"
  },
  Task_11027_Name = {
    Text = "Maître des cartes"
  },
  Task_11029_Desc = {
    Text = "Résonner 10 fois dans l'enquête sur l'événement «@1@2»"
  },
  Task_11029_Desc2 = {
    Text = "Résonner 10 fois dans l'événement d'investigation \"Dans le Silence\""
  },
  Task_11029_Name = {Text = "@2@3"},
  Task_11029_Name2 = {
    Text = "Échos de la Douleur IV"
  },
  Task_11030_Desc = {
    Text = "Avoir au moins 8 Cartes d'Oraison lors de l'achèvement"
  },
  Task_11030_Name = {
    Text = "Pouvoir d'oraison"
  },
  Task_11031_Desc = {
    Text = "Niveau terminé"
  },
  Task_11031_Name = {
    Text = "Complète le Niveau"
  },
  Task_11032_Desc = {
    Text = "Dans la Bataille X spécifique, piocher 5 cartes ou plus en un tour"
  },
  Task_11032_Name = {
    Text = "Sérendipité"
  },
  Task_11033_Desc = {
    Text = "Compléter l'Événement d'Investigation « Au Nom de la Sculpture en Cire » en Difficile"
  },
  Task_11033_Name = {
    Text = "Mystère en Cire·Difficile"
  },
  Task_11034_Desc = {
    Text = "Repoussez la Jonquille"
  },
  Task_11034_Name = {Text = "Objectif"},
  Task_11035_Desc = {
    Text = "Dans la Bataille X spécifique, accumuler une valeur de bouclier de ≥ 200 (Bataille Élite X)"
  },
  Task_11035_Name = {
    Text = "Unbreakable"
  },
  Task_11036_Desc = {
    Text = "Complète l'Événement d'Investigation \"Secret de l'Est\" en difficulté Difficile"
  },
  Task_11036_Name = {
    Text = "Brouillard Est · Difficile"
  },
  Task_11038_Desc = {
    Text = "Déclenchez la résistance à la mort pas plus d'une fois à l'achèvement."
  },
  Task_11038_Name = {
    Text = "Pas de temps pour mourir"
  },
  Task_11041_Desc = {
    Text = "Gagner la Bataille Finale en moins de 8 tours"
  },
  Task_11041_Name = {
    Text = "Résolution rapide"
  },
  Task_11042_Desc = {
    Text = "Trouvez Céleste"
  },
  Task_11042_Name = {Text = "Objectif"},
  Task_11043_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_11043_Name = {
    Text = "Passer Parfait"
  },
  Task_11044_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_11044_Name = {
    Text = "Passer Parfait"
  },
  Task_11045_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_11045_Name = {
    Text = "Passer Parfait"
  },
  Task_11046_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_11046_Name = {
    Text = "Passer Parfait"
  },
  Task_11047_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_11047_Name = {
    Text = "Passer Parfait"
  },
  Task_11048_Desc = {
    Text = "Terminez 100 Codex Tabous"
  },
  Task_11048_Name = {
    Text = "Graveur de Pacte II"
  },
  Task_11050_Desc = {
    Text = "Niveau terminé"
  },
  Task_11050_Name = {
    Text = "Complète le Niveau"
  },
  Task_11052_Desc = {
    Text = "Investiguer 240 instances d'images après-structure"
  },
  Task_11052_Name = {
    Text = "Ruines de Caro V"
  },
  Task_11053_Desc = {
    Text = "Gagner la bataille finale en moins de 18 tours"
  },
  Task_11053_Name = {
    Text = "Gagner la bataille finale en moins de 18 tours"
  },
  Task_11054_Desc = {
    Text = "Visiter la Cabane de Harriet"
  },
  Task_11054_Name = {Text = "Objectif"},
  Task_11057_Desc = {
    Text = "Complète le niveau en 40 étapes."
  },
  Task_11057_Name = {
    Text = "Planification stratégique"
  },
  Task_11058_Desc = {
    Text = "Avoir pas plus de 1 Symptôme lors de l'achèvement"
  },
  Task_11058_Name = {Text = "Refreshing"},
  Task_11059_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_11059_Name = {
    Text = "Résolution rapide"
  },
  Task_11060_Desc = {
    Text = "Terminez 100 Groupes de Chaos"
  },
  Task_11060_Name = {
    Text = "Théoricien des Groupes II"
  },
  Task_11061_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_11061_Name = {
    Text = "Résolution rapide"
  },
  Task_11062_Desc = {
    Text = "Rattraper Murphy"
  },
  Task_11062_Name = {Text = "Objectif"},
  Task_11063_Desc = {
    Text = "Trouvez la source du son"
  },
  Task_11063_Name = {Text = "Objectif"},
  Task_11064_Desc = {Text = "Merci."},
  Task_11064_Name = {Text = "Merci,"},
  Task_11065_Desc = {
    Text = "Repoussez Harriet"
  },
  Task_11065_Name = {Text = "Objectif"},
  Task_11066_Desc = {
    Text = "N'oublie pas de moi, d'accord ?"
  },
  Task_11066_Name = {
    Text = "N'oublie pas de moi, d'accord ?"
  },
  Task_11067_Desc = {
    Text = "Merci à tous..."
  },
  Task_11067_Name = {
    Text = "Merci à tous..."
  },
  Task_11068_Desc = {
    Text = "Gagner la Bataille Finale en moins de 15 tours"
  },
  Task_11068_Name = {
    Text = "Résolution rapide"
  },
  Task_11069_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_11069_Name = {
    Text = "Passer Parfait"
  },
  Task_11070_Desc = {
    Text = "Vaincre en 16 tours au total"
  },
  Task_11070_Name = {
    Text = "Vaincre en 16 tours au total"
  },
  Task_11071_Desc = {
    Text = "Vaincre en 21 tours au total"
  },
  Task_11071_Name = {
    Text = "Vaincre en 21 tours au total"
  },
  Task_11072_Desc = {
    Text = "Vaincre en un total de 11 tours"
  },
  Task_11072_Name = {
    Text = "Vaincre en un total de 11 tours"
  },
  Task_11073_Desc = {
    Text = "Niveau terminé"
  },
  Task_11073_Name = {
    Text = "Complète le Niveau"
  },
  Task_11074_Desc = {
    Text = "Niveau terminé"
  },
  Task_11074_Name = {
    Text = "Complète le Niveau"
  },
  Task_11075_Desc = {
    Text = "Niveau terminé"
  },
  Task_11075_Name = {
    Text = "Complète le Niveau"
  },
  Task_11076_Desc = {
    Text = "Vaincre en 31 tours"
  },
  Task_11076_Name = {
    Text = "Vaincre en 31 tours"
  },
  Task_11077_Desc = {
    Text = "Posséder quatre Réveilleurs Chaos de niveau 50"
  },
  Task_11077_Name = {
    Text = "Seigneur du Chaos V"
  },
  Task_11078_Desc = {
    Text = "Posséder quatre Réveilleurs Chaos de niveau 40"
  },
  Task_11078_Name = {
    Text = "Seigneur du Chaos IV"
  },
  Task_11079_Desc = {
    Text = "A 4 Réveillés Caro de niveau 10"
  },
  Task_11079_Name = {
    Text = "Seigneur de caro"
  },
  Task_11080_Desc = {
    Text = "Posséder quatre Réveilleurs Chaos de niveau 60"
  },
  Task_11080_Name = {
    Text = "Seigneur du Chaos VI"
  },
  Task_11081_Desc = {
    Text = "Posséder quatre Réveilleurs Chaos de niveau 10"
  },
  Task_11081_Name = {
    Text = "Maître du chaos"
  },
  Task_11082_Desc = {
    Text = "Posséder quatre Réveilleurs Chaos de niveau 30"
  },
  Task_11082_Name = {
    Text = "Seigneur du Chaos III"
  },
  Task_11083_Desc = {
    Text = "Posséder quatre Réveilleurs Chaos de niveau 20"
  },
  Task_11083_Name = {
    Text = "Seigneur du Chaos II"
  },
  Task_11084_Desc = {
    Text = "Déclenchez Résistance à la Mort 4 fois dans une bataille et remportez cette ronde."
  },
  Task_11084_Name = {
    Text = "Combat à mort"
  },
  Task_11085_Desc = {
    Text = "Attaque l'ennemi 15 fois avec Strike Tentacule en un tour et remporte cette bataille."
  },
  Task_11085_Name = {
    Text = "Maître de Lémurie"
  },
  Task_11086_Desc = {
    Text = "Déclenchez 5 sauts lors d'un tour ultra et obtenez la victoire."
  },
  Task_11086_Name = {
    Text = "Sauter dimensionnel"
  },
  Task_11087_Desc = {
    Text = "Dévorer 5 embryons et obtenir la victoire en un seul round."
  },
  Task_11087_Name = {Text = "Ravenous"},
  Task_11088_Desc = {
    Text = "Gagner en jouant 15 cartes en un seul tour"
  },
  Task_11088_Name = {Text = "Mon tour !"},
  Task_11089_Desc = {
    Text = "Jouez 6 cartes de symptôme en un tour et gagnez"
  },
  Task_11089_Name = {
    Text = "Patient en phase critique"
  },
  Task_11090_Desc = {
    Text = "Jouez 10 cartes de frappe en un tour et réussissez."
  },
  Task_11090_Name = {
    Text = "Coup infini"
  },
  Task_11091_Desc = {
    Text = "Gagner la bataille avec un total de 8 cartes ou moins en main, dans la pile de défausse et dans la pile de pioche combinée."
  },
  Task_11091_Name = {
    Text = "Poches vides"
  },
  Task_11092_Desc = {
    Text = "Poursuite \"24\""
  },
  Task_11092_Name = {Text = "Objectif"},
  Task_11094_Desc = {
    Text = "Compléter l'Événement d'Investigation « Méfiez-vous des Chiens » en Difficile"
  },
  Task_11094_Name = {
    Text = "Œil au-delà des dimensions · Difficile"
  },
  Task_11095_Desc = {
    Text = "Consommez 500000 rose dorée"
  },
  Task_11095_Name = {
    Text = "Spendthrift"
  },
  Task_11096_Desc = {
    Text = "Consommez 1000000 rose dorée"
  },
  Task_11096_Name = {
    Text = "Dépensier II"
  },
  Task_11097_Desc = {
    Text = "Victoire dans le combat de boss, rapportant 1200 points."
  },
  Task_11097_Name = {
    Text = "Vaincre le Boss <size=20><color=#747474>Gagner la bataille de boss pour gagner 1200 points</color></size>"
  },
  Task_11098_Desc = {
    Text = "Gagnez la bataille finale en 9 tours"
  },
  Task_11098_Name = {
    Text = "Gagnez la bataille finale en 9 tours"
  },
  Task_11099_Desc = {
    Text = "Retour au Maître"
  },
  Task_11099_Name = {Text = "Objectif"},
  Task_11100_Desc = {
    Text = "Enquête sur la source du son"
  },
  Task_11100_Name = {Text = "Objectif"},
  Task_11101_Desc = {
    Text = "Gagner la Bataille Finale en moins de 8 tours"
  },
  Task_11101_Name = {
    Text = "Résolution rapide"
  },
  Task_11102_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_11102_Name = {
    Text = "Passer Parfait"
  },
  Task_11103_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_11103_Name = {
    Text = "Passer Parfait"
  },
  Task_11104_Desc = {
    Text = "Gagner la Bataille Finale en moins de 15 tours"
  },
  Task_11104_Name = {
    Text = "Résolution rapide"
  },
  Task_11105_Desc = {
    Text = "Niveau terminé"
  },
  Task_11105_Name = {
    Text = "Complète le Niveau"
  },
  Task_11106_Desc = {
    Text = "Posséder 4 Éveilleurs Caro de niveau 30"
  },
  Task_11106_Name = {
    Text = "Maître de Caro III"
  },
  Task_11107_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_11107_Name = {
    Text = "Passer Parfait"
  },
  Task_11108_Desc = {
    Text = "Trouvez la sculpture en cire \"Printemps\""
  },
  Task_11108_Name = {Text = "Objectif"},
  Task_11109_Desc = {
    Text = "Traversez le Pont"
  },
  Task_11109_Name = {Text = "Objectif"},
  Task_11111_Desc = {
    Text = "Niveau terminé"
  },
  Task_11111_Name = {
    Text = "Complète le Niveau"
  },
  Task_11112_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_11112_Name = {
    Text = "Résolution rapide"
  },
  Task_11113_Desc = {
    Text = "Rattraper le Chasseur de Crânes"
  },
  Task_11113_Name = {Text = "Objectif"},
  Task_11114_Desc = {
    Text = "Gagnez la bataille finale en 8 tours"
  },
  Task_11114_Name = {
    Text = "Gagnez la bataille finale en 8 tours"
  },
  Task_11115_Desc = {
    Text = "Vaincre en un total de 58 tours"
  },
  Task_11115_Name = {
    Text = "Vaincre en un total de 58 tours"
  },
  Task_11116_Desc = {
    Text = "Complétez une Quête Quotidienne"
  },
  Task_11116_Name = {
    Text = "Défi quotidien"
  },
  Task_11117_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_11117_Name = {
    Text = "Passer Parfait"
  },
  Task_11118_Desc = {
    Text = "Niveau terminé"
  },
  Task_11118_Name = {
    Text = "Complète le Niveau"
  },
  Task_11119_Desc = {
    Text = "Éliminer le Corps Dissolu"
  },
  Task_11119_Name = {Text = "Objectif"},
  Task_11120_Desc = {
    Text = "Niveau terminé"
  },
  Task_11120_Name = {
    Text = "Complète le Niveau"
  },
  Task_11121_Desc = {
    Text = "Montez dans le canot de sauvetage"
  },
  Task_11121_Name = {Text = "Objectif"},
  Task_11122_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_11122_Name = {
    Text = "Résolution rapide"
  },
  Task_11123_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_11123_Name = {
    Text = "Résolution rapide"
  },
  Task_11124_Desc = {
    Text = "Niveau terminé"
  },
  Task_11124_Name = {
    Text = "Complète le Niveau"
  },
  Task_11125_Desc = {
    Text = "Complète toutes les tâches dans ce chapitre pour réclamer des récompenses."
  },
  Task_11125_Name = {
    Text = "Maîtrise de Royaume IV"
  },
  Task_11126_Desc = {
    Text = "Complétez 200 Affinements d'Élixir"
  },
  Task_11126_Name = {
    Text = "Maître Modulateur III"
  },
  Task_11128_Desc = {
    Text = "N'utilise pas la Gnose d'urgence pour nettoyer"
  },
  Task_11128_Name = {
    Text = "Clear en Une Vie  <size=20><color=#747474>Passer sans utiliser la Gnose d'Urgence</color></size>"
  },
  Task_11129_Desc = {
    Text = "Retour au comptoir et trouvez Pandia."
  },
  Task_11129_Name = {Text = "Objectif"},
  Task_11130_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_11130_Name = {
    Text = "Passer Parfait"
  },
  Task_11135_Desc = {
    Text = "Échapper à Miryam"
  },
  Task_11135_Name = {Text = "Objectif"},
  Task_11136_Desc = {
    Text = "Compétences d'Awa`keneur améliorées cumulativement 6 fois"
  },
  Task_11136_Name = {Text = "Mission 4"},
  Task_11137_Desc = {
    Text = "Terminez 1 Existence Transcendante"
  },
  Task_11137_Name = {Text = "Quête 5"},
  Task_11138_Desc = {
    Text = "Effectuez une synthèse de matériel une fois dans l'Alchimie."
  },
  Task_11138_Name = {Text = "Tâche 1"},
  Task_11139_Desc = {
    Text = "Améliorez 4 Éveilleurs au Niveau 30"
  },
  Task_11139_Name = {Text = "Quête 2"},
  Task_11140_Desc = {
    Text = "Clair Fissure Chaos IV"
  },
  Task_11140_Name = {Text = "Quête 3"},
  Task_11141_Desc = {
    Text = "Vaincre en 39 tours"
  },
  Task_11141_Name = {
    Text = "Vaincre en 39 tours"
  },
  Task_11142_Desc = {
    Text = "Vaincre en 33 tours"
  },
  Task_11142_Name = {
    Text = "Vaincre en 33 tours"
  },
  Task_11143_Desc = {
    Text = "Vaincre en 54 tours au total"
  },
  Task_11143_Name = {
    Text = "Vaincre en 54 tours au total"
  },
  Task_11144_Desc = {
    Text = "Vaincre en 48 tours"
  },
  Task_11144_Name = {
    Text = "Vaincre en 48 tours"
  },
  Task_11145_Desc = {
    Text = "Vaincre en 14 tours au total"
  },
  Task_11145_Name = {
    Text = "Vaincre en 14 tours au total"
  },
  Task_11146_Desc = {
    Text = "Complète le niveau en moins de 50 mouvements"
  },
  Task_11146_Name = {
    Text = "Planification stratégique"
  },
  Task_11147_Desc = {
    Text = "Vaincre en 26 tours"
  },
  Task_11147_Name = {
    Text = "Vaincre en 26 tours"
  },
  Task_11148_Desc = {
    Text = "Terminez en 20 tours"
  },
  Task_11148_Name = {
    Text = "Terminez en 20 tours"
  },
  Task_11149_Desc = {
    Text = "Niveau terminé"
  },
  Task_11149_Name = {
    Text = "Complète le Niveau"
  },
  Task_11150_Desc = {
    Text = "Vaincre en 66 tours"
  },
  Task_11150_Name = {
    Text = "Vaincre en 66 tours"
  },
  Task_11151_Desc = {
    Text = "Complétez dans les 60 tours"
  },
  Task_11151_Name = {
    Text = "Complétez dans les 60 tours"
  },
  Task_11152_Desc = {
    Text = "Complète toutes les tâches dans la phase pour réclamer des récompenses"
  },
  Task_11152_Name = {Text = "Étape Six"},
  Task_11153_Desc = {
    Text = "Complète toutes les tâches dans ce chapitre pour réclamer des récompenses."
  },
  Task_11153_Name = {
    Text = "Maîtrise de Royaume I"
  },
  Task_11154_Desc = {
    Text = "Niveau terminé"
  },
  Task_11154_Name = {
    Text = "Complète le Niveau"
  },
  Task_11155_Desc = {
    Text = "Avoir pas plus de 3 Symptômes lors de l'achèvement"
  },
  Task_11155_Name = {Text = "Refreshing"},
  Task_11156_Desc = {
    Text = "Compléter le Chapitre 1 de l'enquête principale \"Secret de l'Est\""
  },
  Task_11157_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_11157_Name = {
    Text = "Passer Parfait"
  },
  Task_116471_Desc = {
    Text = "Utiliser un Éveilleur du royaume des profondeurs pour remporter 2 victoires dans « Sang de douleur mêlé »"
  },
  Task_116472_Desc = {
    Text = "Terminer « L'élévation du vent » à n'importe quelle difficulté"
  },
  Task_116473_Desc = {
    Text = "Sang de douleur mêlé·Terminer"
  },
  Task_116474_Desc = {
    Text = "Terminer « Ailes des jumeaux » en difficulté Folie"
  },
  Task_116475_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Conte d'aventure»"
  },
  Task_116476_Desc = {
    Text = "Terminez le paysage de rêve « Au-delà de l'horizon · bas »"
  },
  Task_116477_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter une victoire dans « Sang de douleur mêlé »"
  },
  Task_116478_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Poison d'oubli»"
  },
  Task_116479_Desc = {
    Text = "Terminer «Époque naïve» en toute difficulté"
  },
  Task_116480_Desc = {
    Text = "Utiliser un Éveilleur du royaume du chaos pour remporter 2 victoires dans « Sang de douleur mêlé »"
  },
  Task_116481_Desc = {
    Text = "Terminez tous les succès de « Sang de douleur mêlé · Terminer »"
  },
  Task_116482_Desc = {
    Text = "Terminer « Époque naïve » à la difficulté Folie"
  },
  Task_116483_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Éveil du silence»"
  },
  Task_116484_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Ancien livre de comptes»"
  },
  Task_116485_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Ancien livre de comptes»"
  },
  Task_116486_Desc = {
    Text = "Sang de douleur mêlé · Folie"
  },
  Task_116487_Desc = {
    Text = "Utiliser un Éveilleur du royaume des profondeurs pour remporter une victoire dans « Sang de douleur mêlé »"
  },
  Task_116488_Desc = {
    Text = "Sang de douleur mêlé·Royaume"
  },
  Task_116489_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Ailes des jumeaux »"
  },
  Task_116490_Desc = {
    Text = "Terminer «Poison d'oubli» en toute difficulté"
  },
  Task_116491_Desc = {
    Text = "Terminer « Conte d'aventure » en difficulté Folie"
  },
  Task_116492_Desc = {
    Text = "Terminer « Ancien livre de comptes » à la difficulté Folie"
  },
  Task_116493_Desc = {
    Text = "Terminer « L'élévation du vent » à n'importe quelle difficulté"
  },
  Task_116494_Desc = {
    Text = "Terminer « Éveil du silence » en difficulté Folie"
  },
  Task_116495_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Conte d'aventure»"
  },
  Task_116496_Desc = {
    Text = "Terminer «Époque naïve» en toute difficulté"
  },
  Task_116497_Desc = {
    Text = "Terminer « Poison d'oubli » à la difficulté Folie"
  },
  Task_116498_Desc = {
    Text = "Utiliser un Éveilleur du royaume de la caro pour remporter 2 fois dans « Sang de douleur mêlé »"
  },
  Task_116499_Desc = {
    Text = "Terminer « L'élévation du vent » en difficulté Folie"
  },
  Task_116500_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter une victoire dans « Sang de douleur mêlé »"
  },
  Task_116501_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Ailes des jumeaux »"
  },
  Task_116502_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Éveil du silence»"
  },
  Task_116503_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter 2 victoires dans « Sang de douleur mêlé »"
  },
  Task_116504_Desc = {
    Text = "Utiliser un Éveilleur du royaume du chaos pour remporter 1 victoire dans « Sang de douleur mêlé »"
  },
  Task_116767_Desc = {
    Text = "Terminer 1 fois le niveau d'essai de Pollux"
  },
  Task_116768_Desc = {
    Text = "Connexion cumulative pendant 1 jour"
  },
  Task_116769_Desc = {
    Text = "Terminer 1 fois l'Existence Transcendante"
  },
  Task_116770_Desc = {
    Text = "Terminer 1 fois l'Existence Transcendante"
  },
  Task_116771_Desc = {
    Text = "Complétez 20 Missions"
  },
  Task_116772_Desc = {
    Text = "Terminer 2 épreuves hebdomadaires"
  },
  Task_116773_Desc = {
    Text = "Terminer 20 missions d'expédition"
  },
  Task_116774_Desc = {
    Text = "Complétez 20 Missions"
  },
  Task_116775_Desc = {
    Text = "Connexion cumulative pendant 1 jour"
  },
  Task_116776_Desc = {
    Text = "Terminer 20 missions d'expédition"
  },
  Task_116777_Desc = {
    Text = "Compléter 3 quêtes quotidiennes"
  },
  Task_116778_Desc = {
    Text = "Compléter 3 quêtes quotidiennes"
  },
  Task_116779_Desc = {
    Text = "Réveiller 30 fois"
  },
  Task_116780_Desc = {
    Text = "Terminer 2 épreuves hebdomadaires"
  },
  Task_116781_Desc = {
    Text = "Réveiller 30 fois"
  },
  Task_116782_Desc = {
    Text = "Terminer 1 fois le niveau d'essai de Pollux"
  },
  Task_116793_Desc = {
    Text = "Obtenez un total de 3 victoires cette saiso"
  },
  Task_116793_Name = {
    Text = "3 Victoires"
  },
  Task_116794_Desc = {
    Text = "Obtenez 1 victoire cette saiso"
  },
  Task_116794_Name = {Text = "1 Victoire"},
  Task_116795_Desc = {
    Text = "Obtenez un total de 6 victoires cette saiso"
  },
  Task_116795_Name = {
    Text = "6 victoires"
  },
  Task_116796_Desc = {
    Text = "Obtenez 10 victoires cette saiso"
  },
  Task_116796_Name = {
    Text = "10 Victoires"
  },
  Task_116809_Desc = {
    Text = "Terminez le Monde des Rêves Étranges « Adieu, le Pays des Merveilles »"
  },
  Task_116809_Name = {
    Text = "Écho du rêve"
  },
  Task_116810_Desc = {
    Text = "Terminer le Monde des Rêves Étranges « Adieu, le Pays des Merveilles » en difficulté difficile"
  },
  Task_116810_Name = {
    Text = "Réverbération de rêves · Difficile"
  },
  Task_116820_Name = {
    Text = "Vaincre le BOSS 3 N fois"
  },
  Task_116821_Name = {
    Text = "Vaincre le BOSS 6 N fois"
  },
  Task_116822_Name = {
    Text = "Vaincre Tous les Boss"
  },
  Task_116823_Name = {
    Text = "Vaincre BOSS 5 fois"
  },
  Task_116824_Name = {
    Text = "Vaincre le BOSS 1 N fois"
  },
  Task_116825_Name = {
    Text = "Vaincre le BOSS 4 N fois"
  },
  Task_116826_Name = {
    Text = "Vaincre le BOSS 7 N fois"
  },
  Task_116827_Name = {
    Text = "Vaincre le BOSS 2 N fois"
  },
  Task_116884_Desc = {
    Text = "Connexion Cumulative : 11 Jours"
  },
  Task_116885_Desc = {
    Text = "Connexion Cumulative : 13 Jours"
  },
  Task_116886_Desc = {
    Text = "Connectez-vous pendant un total de 7 jours"
  },
  Task_116887_Desc = {
    Text = "Connecté pendant un total de 9 jours"
  },
  Task_116888_Desc = {
    Text = "Connectez-vous pendant un total de 10 jours"
  },
  Task_116890_Desc = {
    Text = "Connectez-vous pendant un total de 8 jours"
  },
  Task_116891_Desc = {
    Text = "Connecté pendant un total de 16 jours"
  },
  Task_116892_Desc = {
    Text = "Connectez-vous pendant un total de 15 jours"
  },
  Task_116894_Desc = {
    Text = "Connectez-vous pendant un total de 4 jours"
  },
  Task_116895_Desc = {
    Text = "Connecte-toi pendant 5 jours cumulés"
  },
  Task_116896_Desc = {
    Text = "Connecte-toi pendant 3 jours cumulés"
  },
  Task_116897_Desc = {
    Text = "Connexion cumulative pendant 6 jours"
  },
  Task_116899_Desc = {
    Text = "Connexion cumulative pendant 1 jour"
  },
  Task_116900_Desc = {
    Text = "Connexion cumulative de 14 jours"
  },
  Task_116901_Desc = {
    Text = "Connectez-vous pendant un total de 2 jours"
  },
  Task_116903_Desc = {
    Text = "Connexion Cumulative : 12 Jours"
  },
  Task_117156_Desc = {
    Text = "Utilisez le Réveilleur dans le Royaume des Profondeurs pour gagner une fois dans \"Ville dans le Lac\""
  },
  Task_117157_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter une victoire dans « Cité du lac »"
  },
  Task_117158_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter une victoire dans « Cité du lac »"
  },
  Task_117159_Desc = {
    Text = "Utilisez le Réveiller du Royaume Chaos pour gagner une fois dans \"Ville dans le Lac\"."
  },
  Task_117304_Desc = {
    Text = "Obtenez 1 victoire cette saiso"
  },
  Task_117304_Name = {Text = "1 Victoire"},
  Task_117305_Desc = {
    Text = "Obtenez un total de 6 victoires cette saiso"
  },
  Task_117305_Name = {
    Text = "6 victoires"
  },
  Task_117306_Desc = {
    Text = "Obtenez un total de 3 victoires cette saiso"
  },
  Task_117306_Name = {
    Text = "3 Victoires"
  },
  Task_117307_Desc = {
    Text = "Obtenez 10 victoires cette saiso"
  },
  Task_117307_Name = {
    Text = "10 Victoires"
  },
  Task_117487_Desc = {
    Text = "Terminer le Monde des Rêves Étranges « Au revoir, Pays Imaginaire » en difficulté Difficile"
  },
  Task_117487_Name = {
    Text = "Jamais abandonner · Difficile"
  },
  Task_117488_Desc = {
    Text = "Terminez le Monde des Rêves Étranges « Au revoir, le Pays Imaginaire »"
  },
  Task_117488_Name = {
    Text = "Jamais abandonner"
  },
  Task_117489_Desc = {
    Text = "Terminez «Au-delà de l'horizon · bas» dans le paysage de rêve"
  },
  Task_117489_Name = {
    Text = "Au-dessus du ciel azur"
  },
  Task_118481_Desc = {
    Text = "Emmène Murphy"
  },
  Task_118481_Name = {Text = "Objectif"},
  Task_118482_Desc = {
    Text = "Intervenir dans la cérémonie pour sauver Murphy"
  },
  Task_118482_Name = {Text = "Objectif"},
  Task_118483_Desc = {
    Text = "Retour au paradis"
  },
  Task_118483_Name = {Text = "Objectif"},
  Task_118484_Desc = {
    Text = "Lever le voile du rêve"
  },
  Task_118484_Name = {Text = "Objectif"},
  Task_118485_Desc = {
    Text = "Observer la cérémonie de pilotage"
  },
  Task_118485_Name = {Text = "Objectif"},
  Task_118486_Desc = {
    Text = "Affronter les poissons volants"
  },
  Task_118486_Name = {Text = "Objectif"},
  Task_118487_Desc = {
    Text = "Repousser le Marcheur des mers en poursuite"
  },
  Task_118487_Name = {Text = "Objectif"},
  Task_118488_Desc = {
    Text = "Arrivée au bout du chemin"
  },
  Task_118488_Name = {Text = "Objectif"},
  Task_118489_Desc = {
    Text = "Éliminer « soi-même »"
  },
  Task_118489_Name = {Text = "Objectif"},
  Task_118490_Desc = {
    Text = "Sauver Murphy dans le chaos"
  },
  Task_118490_Name = {Text = "Objectif"},
  Task_118787_Desc = {
    Text = "Chant de l'Enfant Divin"
  },
  Task_118791_Desc = {
    Text = "Chaîne de ténèbres"
  },
  Task_118796_Desc = {
    Text = "Restes du désert de sable"
  },
  Task_118799_Desc = {
    Text = "Bateau des Mers Sombres"
  },
  Task_118809_Desc = {
    Text = "Mur des sables désolés"
  },
  Task_118821_Desc = {
    Text = "Le secret des cires"
  },
  Task_118826_Desc = {
    Text = "Résidu trouble"
  },
  Task_118835_Desc = {
    Text = "Résidu des Abysses"
  },
  Task_118837_Desc = {
    Text = "Musée Hanté"
  },
  Task_118842_Desc = {
    Text = "Recherche de coupons d'or"
  },
  Task_118845_Desc = {
    Text = "Mer de Tempête"
  },
  Task_118852_Desc = {
    Text = "Résidu organique"
  },
  Task_118856_Desc = {
    Text = "Ville Étrange"
  },
  Task_118860_Desc = {
    Text = "Larmes de poupée"
  },
  Task_118871_Desc = {
    Text = "Gorge de Schwarzschild"
  },
  Task_118873_Desc = {
    Text = "Repaire des vers"
  },
  Task_118877_Desc = {
    Text = "Préparation et affinage"
  },
  Task_118879_Desc = {
    Text = "Essaim chaotique"
  },
  Task_118881_Desc = {
    Text = "Fissure primordiale"
  },
  Task_118892_Desc = {
    Text = "Poigne pieuse"
  },
  Task_118907_Desc = {
    Text = "Ruines de Ponape"
  },
  Task_118913_Desc = {
    Text = "Ombre hors des limites"
  },
  Task_118915_Desc = {
    Text = "Marée du Bassin Noir"
  },
  Task_118917_Desc = {
    Text = "Résidu dimensionnel"
  },
  Task_118918_Desc = {
    Text = "Montagnes du Désordre"
  },
  Task_118922_Desc = {
    Text = "Cité de la Brume Étrange"
  },
  Task_118979_Desc = {
    Text = "Adversaire·Sélection de roue"
  },
  Task_118980_Desc = {
    Text = "Obtenir 20 victoires sans utiliser «<color=#ae6abb>Luminis</color>» éveilleur"
  },
  Task_118981_Desc = {
    Text = "Dans la bataille, cliquez sur les avatars pour envoyer l'expression « bonjour » ou « Salut » à 3 adversaires."
  },
  Task_118982_Desc = {
    Text = "A atteint 500 points en mode de pré-groupe"
  },
  Task_118983_Desc = {
    Text = "Obtenez 20 victoires sans utiliser l'«<color=#76bf9d>Bénédiction</color>» éveillé"
  },
  Task_118984_Desc = {
    Text = "Dans le mode de sélection de roue, atteindre 1000 points"
  },
  Task_118985_Desc = {
    Text = "A atteint 2500 points en mode de sélection de roue"
  },
  Task_118986_Desc = {
    Text = "Terminer tous les succès de « Éveil de phase »"
  },
  Task_118987_Desc = {
    Text = "Obtenir 20 victoires sans utiliser l'Éveilleur «<color=#6a97c2>Gardien</color>»"
  },
  Task_118988_Desc = {
    Text = "Éveil de phase"
  },
  Task_118989_Desc = {
    Text = "Participez à un combat d'Échecs de Phase en portant 16 expressions dans « Expressions de combat »"
  },
  Task_118990_Desc = {
    Text = "Copier la composition de l'adversaire après la fin du combat en traphase"
  },
  Task_118991_Desc = {
    Text = "Participer à 1 fois « mode de sélection de roue »"
  },
  Task_118992_Desc = {
    Text = "Dans le mode de pré-groupe, 2000 points ont été atteints"
  },
  Task_118993_Desc = {
    Text = "A atteint 2000 points en mode de sélection de roue"
  },
  Task_118994_Desc = {
    Text = "A atteint 500 points en mode de sélection de roue"
  },
  Task_118995_Desc = {
    Text = "Après la fin du combat en traphase, affrontez à nouveau l'adversaire « Encore une partie »."
  },
  Task_118996_Desc = {
    Text = "Dans le mode de pré-groupe, 1000 points ont été atteints"
  },
  Task_118997_Desc = {
    Text = "Obtenir 20 victoires sans utiliser l'Éveilleur «<color=#c26669>conflit</color>»"
  },
  Task_118998_Desc = {
    Text = "J'aime les commentaires des cartes dans «Collection»"
  },
  Task_118999_Desc = {
    Text = "Dans « Collection », essayez l'éveillé dans « Essai de l'éveillé » et battez 1 « chat noir familier »."
  },
  Task_119000_Desc = {
    Text = "A atteint 3000 points en mode de pré-groupe"
  },
  Task_119001_Desc = {
    Text = "Participer 1 fois au «Mode de pré-groupe»"
  },
  Task_119002_Desc = {
    Text = "Dans le mode de pré-groupe, 1 500 points ont été atteints"
  },
  Task_119003_Desc = {
    Text = "A atteint 3000 points dans le mode de sélection de roue"
  },
  Task_119004_Desc = {
    Text = "A atteint 1500 points en mode de sélection de roue"
  },
  Task_119005_Desc = {
    Text = "Adversaire·Pré-groupe"
  },
  Task_119006_Desc = {
    Text = "Regarder l'enregistrement des Échecs de Phase dans le « Dossier du Gardien » sous « Historique des combats »"
  },
  Task_119007_Desc = {
    Text = "Participer 1 fois au « Combat de mot de passe »"
  },
  Task_119008_Desc = {
    Text = "A atteint 2500 points en mode de pré-groupe"
  },
  Task_119009_Desc = {
    Text = "Obtenir 20 victoires sans utiliser l'Éveilleur «<color=#c3aa64>Étoile Maléfique</color>»"
  },
  Task_119010_Desc = {
    Text = "Clairvoyance omnisciente"
  },
  Task_119193_Desc = {
    Text = "Extraction cumulée de 68000 élixir"
  },
  Task_119201_Desc = {
    Text = "Extraction cumulée de 54000 argent primordiale"
  },
  Task_119212_Desc = {
    Text = "Extraction cumulée de 42000 élixirs"
  },
  Task_119216_Desc = {
    Text = "Extraction cumulée de 48000 argent primordiale"
  },
  Task_119217_Desc = {
    Text = "Extraction cumulée de 36000 élixir"
  },
  Task_119695_Desc = {
    Text = "Connexion cumulative pendant 1 jour"
  },
  Task_119696_Desc = {
    Text = "Terminer le chapitre 4 de l'Oubli « Dans le silence »"
  },
  Task_119697_Desc = {
    Text = "Terminer le Chapitre 4 des Étoiles « Paradis »"
  },
  Task_119698_Desc = {
    Text = "Utilisation cumulative de 200 Décrets Clé"
  },
  Task_119699_Desc = {
    Text = "Terminer le chapitre 7 de l'Oubli « Désir de rivière »"
  },
  Task_120441_Desc = {
    Text = "Terminer «Mission d'enquête» Chapitre 7"
  },
  Task_120500_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_120501_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_120502_Desc = {
    Text = "Résonner 2 fois dans l'enquête sur l'événement « @1@2 »"
  },
  Task_120502_Desc2 = {
    Text = "Résonner 2 fois dans l'enquête sur l'événement « Paradis »"
  },
  Task_120502_Name = {Text = "@2@3"},
  Task_120502_Name2 = {
    Text = "Écho illusoire"
  },
  Task_120503_Desc = {
    Text = "Compléter l'événement d'investigation \"@1@2\""
  },
  Task_120503_Desc2 = {
    Text = "Terminer l'événement d'enquête «Paradis»"
  },
  Task_120503_Name = {Text = "@2@3"},
  Task_120503_Name2 = {
    Text = "Effondrement du paradis"
  },
  Task_120504_Desc = {
    Text = "Terminer le Chapitre 4 de la série « Étoiles » 4-6"
  },
  Task_120505_Desc = {
    Text = "Terminer l'événement d'enquête « Paradis » en difficulté difficile"
  },
  Task_120505_Name = {
    Text = "Effondrement du paradis · Difficile"
  },
  Task_120506_Desc = {
    Text = "Résonner 6 fois dans l'enquête sur l'événement «@1@2»"
  },
  Task_120506_Desc2 = {
    Text = "Résonner 6 fois dans l'enquête sur l'événement « Paradis »"
  },
  Task_120506_Name = {Text = "@2@3"},
  Task_120506_Name2 = {
    Text = "Écho illusoire III"
  },
  Task_120507_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_120508_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_120509_Desc = {
    Text = "Terminer « Paradis » - Chapitre 4 des Étoiles · Difficile"
  },
  Task_120510_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_120511_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_120512_Desc = {
    Text = "Terminer le Chapitre 4 de la série « Étoiles » 4-6"
  },
  Task_120514_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_120515_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_120516_Desc = {
    Text = "Terminer le Chapitre 4 des Étoiles 4-5 à difficulté Difficile"
  },
  Task_120517_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_120518_Desc = {
    Text = "Terminer le Chapitre des Étoiles 4-5 à difficulté Difficile"
  },
  Task_120519_Desc = {
    Text = "Terminer le Chapitre 4 des Étoiles « Paradis »"
  },
  Task_120520_Desc = {
    Text = "Résonnez 7 fois dans l'événement d'investigation \"@1@2\""
  },
  Task_120520_Desc2 = {
    Text = "Dans l'enquête de l'événement « Paradis », résonance 7 fois"
  },
  Task_120520_Name = {Text = "@2@3"},
  Task_120520_Name2 = {
    Text = "Écho illusoire IV"
  },
  Task_120521_Desc = {
    Text = "Terminer « Paradis » - Chapitre 4 des Étoiles · Difficile"
  },
  Task_120522_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_120523_Desc = {
    Text = "Résonner 4 fois dans l'enquête sur l'événement « @1@2 »"
  },
  Task_120523_Desc2 = {
    Text = "Résonner 4 fois dans l'enquête sur l'événement « Paradis »"
  },
  Task_120523_Name = {Text = "@2@3"},
  Task_120523_Name2 = {
    Text = "Écho illusoire II"
  },
  Task_120524_Desc = {
    Text = "Terminer le Chapitre 4 des Étoiles « Paradis »"
  },
  Task_120535_Desc = {
    Text = "Terminer le chapitre 4 de l'Oubli « Dans le silence »"
  },
  Task_120536_Desc = {
    Text = "Terminer le chapitre 7 de l'Oubli « Désir de rivière »"
  },
  Task_120537_Desc = {
    Text = "Connexion cumulative pendant 1 jour"
  },
  Task_120538_Desc = {
    Text = "Terminer le Chapitre 4 des Étoiles « Paradis »"
  },
  Task_120549_Desc = {
    Text = "Lutter jusqu'aux 100 derniers matchs dans les échecs de phase sans se rendre"
  },
  Task_120850_Desc = {
    Text = "Utiliser seulement un Éveilleur du royaume de la caro pour terminer une fois « Plongée dans l'illusion »"
  },
  Task_120851_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos et un réveilleur du Domaine hyperdimensionnel pour terminer une fois la « Plongée dans l'illusion »"
  },
  Task_120852_Desc = {
    Text = "Seulement utiliser un Éveilleur du royaume du chaos pour terminer une fois « Plongée dans l'illusion »"
  },
  Task_120855_Desc = {
    Text = "«Plongée dans l'illusion» les points maximaux atteignent 1000"
  },
  Task_120856_Desc = {
    Text = "Utiliser un Éveilleur du royaume du chaos et un Éveilleur du royaume de la caro pour terminer 1 fois «Plongée dans l'illusion»"
  },
  Task_120857_Desc = {
    Text = "Utilisez uniquement des Corps éveillés du Chaos pour terminer 5 plongées dans l'illusion de difficulté VI ou supérieure."
  },
  Task_120862_Desc = {
    Text = "Seulement utiliser le Corps Éveillé de Chair et de Sang pour compléter 5 plongées dans l'illusion de difficulté VI et plus."
  },
  Task_120863_Desc = {
    Text = "Utiliser le Chaos et le Corps éveillé des abysses pour compléter 5 plongées dans l'illusion de difficulté VI ou supérieure."
  },
  Task_120864_Desc = {
    Text = "Utilisez le Chaos et le Corps Éveillé Hyperdimensionnel pour compléter 5 plongées dans l'illusion de difficulté VI ou supérieure."
  },
  Task_120865_Desc = {
    Text = "Utiliser le Royaume Aequor et le Réveilleur du Domaine hyperdimensionnel pour terminer 1 fois « Plongée dans l'illusion »"
  },
  Task_120867_Desc = {
    Text = "Utiliser le Corps Éveillé de Chair et de Sang pour compléter 5 plongées dans l'illusion de difficulté VI et supérieure."
  },
  Task_120868_Desc = {
    Text = "Sous le cauchemar"
  },
  Task_120869_Desc = {
    Text = "Seulement utiliser des Corps Éveillés Hyperdimensionnels pour terminer 5 plongées dans l'illusion de difficulté VI ou plus."
  },
  Task_120870_Desc = {
    Text = "Utilisez le Chaos et le Corps Éveillé de Chair et de Sang pour compléter 5 plongées dans l'illusion de difficulté VI ou supérieure."
  },
  Task_120871_Desc = {
    Text = "«Plongée dans l'illusion» le score maximum atteint 7000"
  },
  Task_120872_Desc = {
    Text = "Seulement utiliser un Éveilleur du royaume des profondeurs pour terminer 1 fois «Plongée dans l'illusion»"
  },
  Task_120873_Desc = {
    Text = "Utiliser seulement le Corps éveillé des abysses pour compléter 5 plongées dans l'illusion de difficulté VI ou supérieure."
  },
  Task_120876_Desc = {
    Text = "Croisière maritime"
  },
  Task_120878_Desc = {
    Text = "«Plongée dans l'illusion» le score maximum atteint 6000"
  },
  Task_120879_Desc = {
    Text = "Utilisez des Éveilleurs Aequor et Hyperdimensionnels pour terminer 5 plongées dans l'illusion de difficulté VI ou supérieure."
  },
  Task_120880_Desc = {
    Text = "Regarder une fois le replay dans le « classement » de la « Plongée dans l'illusion »"
  },
  Task_120882_Desc = {
    Text = "Terminer une fois « Plongée dans l'illusion » en utilisant seulement un réveilleur du Domaine hyperdimensionnel"
  },
  Task_120883_Desc = {
    Text = "Utiliser le royaume du chaos et l'Éveilleur du royaume des profondeurs pour terminer 1 fois «Plongée dans l'illusion»"
  },
  Task_120884_Desc = {
    Text = "Utilisez la Chair et le Corps Éveillé Hyperdimensionnel pour terminer 5 plongées dans l'illusion de difficulté VI ou supérieure."
  },
  Task_120885_Desc = {
    Text = "Entrée dans la mer des rêves"
  },
  Task_120889_Desc = {
    Text = "«Plongée dans l'illusion» le score maximum atteint 5000"
  },
  Task_120890_Desc = {
    Text = "Compléter \"Plongée Fantasmatique\" une fois"
  },
  Task_120891_Desc = {
    Text = "Copier 1 fois la composition dans le « classement » de la « plongée dans l'illusion »"
  },
  Task_120892_Desc = {
    Text = "«Plongée dans l'illusion» le score maximum atteint 2000"
  },
  Task_120894_Desc = {
    Text = "«Plongée dans l'illusion» le score maximum atteint 4000"
  },
  Task_120895_Desc = {
    Text = "«Plongée dans l'illusion» le score maximum atteint 3000"
  },
  Task_120966_Desc = {
    Text = "Obtenez un total de 3 victoires cette saiso"
  },
  Task_120966_Name = {
    Text = "3 Victoires"
  },
  Task_120967_Desc = {
    Text = "Obtenez un total de 6 victoires cette saiso"
  },
  Task_120967_Name = {
    Text = "6 victoires"
  },
  Task_120968_Desc = {
    Text = "Obtenez 10 victoires cette saiso"
  },
  Task_120968_Name = {
    Text = "10 Victoires"
  },
  Task_120969_Desc = {
    Text = "Obtenez 1 victoire cette saiso"
  },
  Task_120969_Name = {Text = "1 Victoire"},
  Task_120994_Desc = {
    Text = "Éliminer tous les clones de « Reprendre le combat originel - Ouverture désaccordée »"
  },
  Task_120994_Name = {
    Text = "Vaincre BOSS1"
  },
  Task_120995_Desc = {
    Text = "Éliminez tous les clones de « Reprendre le combat originel · Harmonie inversée »"
  },
  Task_120995_Name = {
    Text = "Vaincre BOSS4"
  },
  Task_120996_Name = {
    Text = "Événement du Boss Mondial terminé"
  },
  Task_120997_Desc = {
    Text = "Éliminer tous les clones de « Reprendre le combat originel · Sommeil Éternel »"
  },
  Task_120997_Name = {
    Text = "Vaincre le Boss 7"
  },
  Task_120998_Desc = {
    Text = "Éliminer tous les clones de « Reprendre le combat originel · Rythme de mort »"
  },
  Task_120998_Name = {
    Text = "Vaincre Boss 3"
  },
  Task_120999_Desc = {
    Text = "Éliminer tous les clones de « Reprendre le combat originel - Son de l'hérésie »"
  },
  Task_120999_Name = {
    Text = "Vaincre BOSS 5"
  },
  Task_121000_Desc = {
    Text = "Éliminer tous les clones de « Reprendre le combat originel·Folie dernier chapitre »"
  },
  Task_121000_Name = {
    Text = "Vaincre le Boss 6"
  },
  Task_121001_Desc = {
    Text = "Éliminer tous les clones de « Reprendre le combat originel · Prélude désordonné »"
  },
  Task_121001_Name = {
    Text = "Vaincre BOSS2"
  },
  Task_121033_Desc = {
    Text = "Éveil cumulé 30 fois"
  },
  Task_121035_Desc = {
    Text = "Complétez 20 Missions"
  },
  Task_121040_Desc = {
    Text = "Terminer 20 missions d'expédition"
  },
  Task_121041_Desc = {
    Text = "Complétez 20 Missions"
  },
  Task_121042_Desc = {
    Text = "Compléter 3 quêtes quotidiennes"
  },
  Task_121044_Desc = {
    Text = "Terminer 1 fois l'Existence Transcendante"
  },
  Task_121045_Desc = {
    Text = "Connexion cumulative pendant 1 jour"
  },
  Task_121046_Desc = {
    Text = "Terminer 1 fois le niveau d'essai de Mouchette"
  },
  Task_121047_Desc = {
    Text = "Éveil cumulé 30 fois"
  },
  Task_121050_Desc = {
    Text = "Compléter 3 quêtes quotidiennes"
  },
  Task_121051_Desc = {
    Text = "Terminer 2 épreuves hebdomadaires"
  },
  Task_121053_Desc = {
    Text = "Terminer 2 épreuves hebdomadaires"
  },
  Task_121054_Desc = {
    Text = "Terminer 20 missions d'expédition"
  },
  Task_121058_Desc = {
    Text = "Terminer 1 fois l'Existence Transcendante"
  },
  Task_121061_Desc = {
    Text = "Connexion cumulative pendant 1 jour"
  },
  Task_121062_Desc = {
    Text = "Terminer 1 fois le niveau Mouchette"
  },
  Task_121206_Desc = {
    Text = "Extraction cumulée de 76000 argent primordiale"
  },
  Task_121207_Desc = {
    Text = "Extraction cumulée de 84000 élixirs"
  },
  Task_121208_Desc = {
    Text = "Extraction cumulée de 92000 argent primordiale"
  },
  Task_121233_Desc = {
    Text = "Obtenez une évaluation par étoiles de trois dans «Poigne pieuse IV»"
  },
  Task_121234_Desc = {
    Text = "Obtenir une évaluation par étoiles de trois dans «Secret de la statue de cire II»"
  },
  Task_121235_Desc = {
    Text = "Obtenir une note de trois étoiles dans «Résidu organiqueⅢ»"
  },
  Task_121236_Desc = {
    Text = "Obtenir une évaluation de trois étoiles dans «Larmes de poupée V»"
  },
  Task_121237_Desc = {
    Text = "Obtenir une évaluation de trois étoiles dans «Secret de la statue de cire III»"
  },
  Task_121238_Desc = {
    Text = "Obtenir une évaluation de trois étoiles dans «Recherche de coupons dorés I»"
  },
  Task_121239_Desc = {
    Text = "Obtenez une évaluation par étoiles à trois dans «Ombre hors des limites IV»"
  },
  Task_121240_Desc = {
    Text = "Obtenir une note de trois étoiles dans l'« Essaim chaotique IV »"
  },
  Task_121241_Desc = {
    Text = "Obtenez une évaluation de trois étoiles dans «Chant de l'Enfant Divin II»"
  },
  Task_121242_Desc = {
    Text = "Obtenez une évaluation de trois étoiles dans « Navire de la mer sombre III »"
  },
  Task_121243_Desc = {
    Text = "Obtenez une évaluation de trois étoiles dans «Chaîne noire III»"
  },
  Task_121244_Desc = {
    Text = "Obtenez une évaluation de trois étoiles dans «Résidu des Abysses V»"
  },
  Task_121245_Desc = {
    Text = "Obtenez une évaluation par étoiles de trois dans «Résidu dimensionnel I»"
  },
  Task_121246_Desc = {
    Text = "Obtenir une évaluation par étoiles dans « Montagnes du Chaos II »"
  },
  Task_121247_Desc = {
    Text = "Obtenez une évaluation de trois étoiles dans «Cité de la Brume Étrange II»"
  },
  Task_121248_Desc = {
    Text = "Obtenir une évaluation de trois étoiles dans «Ruines de Ponape II»"
  },
  Task_121249_Desc = {
    Text = "Obtenir une note de trois étoiles dans «Résidu organique II»"
  },
  Task_121250_Desc = {
    Text = "Obtenir une note de trois étoiles dans « Montagnes du Désordre I »"
  },
  Task_121251_Desc = {
    Text = "Obtenez une évaluation par étoiles de trois dans «Image résiduelle dimensionnelle II»"
  },
  Task_121252_Desc = {
    Text = "Obtenir une note de trois étoiles dans «Résidu trouble IV»"
  },
  Task_121253_Desc = {
    Text = "Obtenez une évaluation de trois étoiles dans «Musée de cire maniaque II»"
  },
  Task_121254_Desc = {
    Text = "Obtenez une note de trois étoiles dans «Poigne de dévotion I»"
  },
  Task_121255_Desc = {
    Text = "Obtenez une note de trois étoiles dans l'« Essaim du chaos I »"
  },
  Task_121256_Desc = {
    Text = "Obtenez une évaluation de trois étoiles dans «Le secret des cires IV»"
  },
  Task_121257_Desc = {
    Text = "Obtenir une évaluation de trois étoiles dans «Repaire des vers I»"
  },
  Task_121258_Desc = {
    Text = "Obtenez une évaluation de trois étoiles dans «Mur des sables désolés I»"
  },
  Task_121259_Desc = {
    Text = "Obtenir une évaluation de trois étoiles dans «Larmes de poupée II»"
  },
  Task_121260_Desc = {
    Text = "Obtenir une évaluation trois étoiles dans «Poigne pieuse III»"
  },
  Task_121261_Desc = {
    Text = "Obtenir une évaluation par étoiles de trois dans «Ombre hors des limites III»"
  },
  Task_121262_Desc = {
    Text = "Obtenez une évaluation de trois étoiles dans «Restes du désert de sable III»"
  },
  Task_121263_Desc = {
    Text = "Obtenir une note de trois étoiles dans l'« Essaim du chaos II »"
  },
  Task_121264_Desc = {
    Text = "Obtenir une évaluation de trois étoiles dans «Ville du Chaos I»"
  },
  Task_121265_Desc = {
    Text = "Obtenir une évaluation par étoiles dans «Résidu des Abysses I»"
  },
  Task_121266_Desc = {
    Text = "Obtenir une évaluation de trois étoiles dans «Vestiges de la mer de sable I»"
  },
  Task_121267_Desc = {
    Text = "Obtenez une évaluation de trois étoiles dans «Musée de cire maniaque III»"
  },
  Task_121268_Desc = {
    Text = "Obtenir une évaluation par étoiles de trois dans «Résidu des Abysses IV»"
  },
  Task_121269_Desc = {
    Text = "Obtenir une évaluation de trois étoiles dans «Gorge de Schwarzschild IV»"
  },
  Task_121270_Desc = {
    Text = "Obtenir une évaluation par étoiles de trois étoiles dans «Résidu dimensionnel III»"
  },
  Task_121271_Desc = {
    Text = "Obtenir une évaluation de trois étoiles dans «Recherche de coupons d'or IV»"
  },
  Task_121272_Desc = {
    Text = "Obtenir une évaluation par étoiles de trois dans «Résidu des Abysses III»"
  },
  Task_121273_Desc = {
    Text = "Obtenir une note de trois étoiles dans «Raffinement de potion I»"
  },
  Task_121274_Desc = {
    Text = "Obtenez une évaluation de trois étoiles dans «Le secret des cires V»"
  },
  Task_121275_Desc = {
    Text = "Obtenir une évaluation de trois étoiles dans «Vestiges de la mer de sable II»"
  },
  Task_121276_Desc = {
    Text = "Obtenez une évaluation de trois étoiles dans le « Musée de cire maniaque I »"
  },
  Task_121277_Desc = {
    Text = "Obtenir une évaluation par étoiles de trois dans « Montagnes du Chaos III »"
  },
  Task_121278_Desc = {
    Text = "Obtenir une note de trois étoiles dans «Raffinement de potion IV»"
  },
  Task_121279_Desc = {
    Text = "Obtenez une évaluation par étoiles de trois dans «Larmes de poupée III»"
  },
  Task_121280_Desc = {
    Text = "Obtenir une note de trois étoiles dans «Résidu organique V»"
  },
  Task_121281_Desc = {
    Text = "Obtenir une évaluation par étoiles de trois dans «Navire de la mer sombre I»"
  },
  Task_121282_Desc = {
    Text = "Obtenez une évaluation par étoiles de trois dans «Marée du Bassin Noir II»"
  },
  Task_121283_Desc = {
    Text = "Obtenir une note de trois étoiles dans «Résidu trouble III»"
  },
  Task_121284_Desc = {
    Text = "Obtenez une évaluation par étoiles de trois étoiles dans «Poigne de dévotion II»"
  },
  Task_121285_Desc = {
    Text = "Obtenir une évaluation de trois étoiles dans «Mer extérieure de la tempête I»"
  },
  Task_121286_Desc = {
    Text = "Obtenir une note de trois étoiles dans «Secret de la statue de cire I»"
  },
  Task_121287_Desc = {
    Text = "Obtenir une évaluation par étoiles de trois étoiles dans «Ruines de Ponape III»"
  },
  Task_121288_Desc = {
    Text = "Obtenir une évaluation de trois étoiles dans « Chant de l'Enfant Divin III »"
  },
  Task_121289_Desc = {
    Text = "Obtenez une note de trois étoiles dans «Résidu organique IV»"
  },
  Task_121290_Desc = {
    Text = "Obtenir une note de trois étoiles dans «Résidu organique I»"
  },
  Task_121291_Desc = {
    Text = "Obtenez une évaluation par étoiles dans «Ombre hors des limites II»"
  },
  Task_121292_Desc = {
    Text = "Obtenez une évaluation de trois étoiles dans «Chant de l'Enfant Divin I»"
  },
  Task_121293_Desc = {
    Text = "Obtenez une évaluation de trois étoiles dans «Gorge de Schwarzschild III»"
  },
  Task_121294_Desc = {
    Text = "Obtenez une évaluation par étoiles de trois dans «Ombre hors domaine I»"
  },
  Task_121295_Desc = {
    Text = "Obtenir une évaluation de trois étoiles dans «Recherche de coupons dorés II»"
  },
  Task_121296_Desc = {
    Text = "Obtenir une note de trois étoiles dans «Raffinement de potion V»"
  },
  Task_121297_Desc = {
    Text = "Obtenez une évaluation de trois étoiles dans «Ville du Chaos II»"
  },
  Task_121298_Desc = {
    Text = "Obtenez une note de trois étoiles dans «Préparation et affinage II»"
  },
  Task_121299_Desc = {
    Text = "Obtenir une évaluation de trois étoiles dans «Gorge de Schwarzschild II»"
  },
  Task_121300_Desc = {
    Text = "Obtenir une évaluation de trois étoiles dans «Recherche de coupons d'or V»"
  },
  Task_121301_Desc = {
    Text = "Obtenir une évaluation de trois étoiles dans « Cité de la Brume Étrange III »"
  },
  Task_121302_Desc = {
    Text = "Obtenir une note de trois étoiles dans «Raffinement de potion III»"
  },
  Task_121303_Desc = {
    Text = "Obtenir une évaluation de trois étoiles dans «Ruines de Ponape IV»"
  },
  Task_121304_Desc = {
    Text = "Obtenir une note de trois étoiles dans l'« Essaim chaotique III »"
  },
  Task_121305_Desc = {
    Text = "Obtenir une note de trois étoiles dans «Cité de la Brume Étrange I»"
  },
  Task_121306_Desc = {
    Text = "Obtenir une évaluation par étoiles de trois dans «Repaire des Vers III»"
  },
  Task_121307_Desc = {
    Text = "Obtenir une évaluation par étoiles dans «Résidu des Abysses II»"
  },
  Task_121308_Desc = {
    Text = "Obtenir une évaluation par étoiles de trois dans «Repaire des Vers IV»"
  },
  Task_121309_Desc = {
    Text = "Obtenir une évaluation de trois étoiles dans «Ruines de Ponape I»"
  },
  Task_121310_Desc = {
    Text = "Obtenir une note de trois étoiles dans «Résidu trouble II»"
  },
  Task_121311_Desc = {
    Text = "Obtenez une évaluation par étoiles de trois dans «Image résiduelle dimensionnelle V»"
  },
  Task_121312_Desc = {
    Text = "Obtenir une évaluation de trois étoiles dans «Repaire des vers II»"
  },
  Task_121313_Desc = {
    Text = "Obtenir une évaluation de trois étoiles dans «Chaîne noire II»"
  },
  Task_121314_Desc = {
    Text = "Obtenir une évaluation par étoiles de trois dans «Image résiduelle dimensionnelle IV»"
  },
  Task_121315_Desc = {
    Text = "Obtenir une note de trois étoiles dans «Résidu trouble V»"
  },
  Task_121316_Desc = {
    Text = "Obtenez une évaluation de trois étoiles dans «Chaîne noire IV»"
  },
  Task_121317_Desc = {
    Text = "Obtenir une évaluation à trois étoiles dans «Chaîne noire I»"
  },
  Task_121318_Desc = {
    Text = "Obtenir une évaluation de trois étoiles dans « Ville du Chaos III »"
  },
  Task_121319_Desc = {
    Text = "Obtenez une évaluation par étoiles de trois dans «Larmes de poupée I»"
  },
  Task_121320_Desc = {
    Text = "Obtenir une évaluation de trois étoiles dans «Navire de la mer sombre II»"
  },
  Task_121321_Desc = {
    Text = "Obtenez une évaluation de trois étoiles dans «Recherche de coupons dorés III»"
  },
  Task_121322_Desc = {
    Text = "Obtenir une évaluation de trois étoiles dans «Chaîne noire V»"
  },
  Task_121323_Desc = {
    Text = "Obtenez une évaluation de trois étoiles dans «Larmes de poupée IV»"
  },
  Task_121324_Desc = {
    Text = "Obtenez une évaluation de trois étoiles dans «Marée du Bassin Noir I»"
  },
  Task_121325_Desc = {
    Text = "Obtenez une note de trois étoiles dans «Résidu trouble I»"
  },
  Task_121326_Desc = {
    Text = "Obtenir une évaluation par étoiles de trois dans «Gorge de Schwarzschild I»"
  },
  Task_121327_Desc = {
    Text = "Obtenez une note de trois étoiles dans « Fissure primordiale I »"
  },
  Task_121331_Desc = {
    Text = "Terminez toutes les quêtes de « Premier pas dans l'océan des rêves »"
  },
  Task_121332_Desc = {
    Text = "Utiliser un Éveilleur du royaume Aequor et un Éveilleur du royaume de la caro pour terminer une fois « Plongée dans l'illusion »"
  },
  Task_121333_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro et un réveilleur du Domaine hyperdimensionnel pour terminer une fois « Plongée dans l'illusion »"
  },
  Task_121834_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_121834_Name = {
    Text = "Passer Parfait"
  },
  Task_121835_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_121835_Name = {
    Text = "Passer Parfait"
  },
  Task_121836_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_121836_Name = {
    Text = "Passer Parfait"
  },
  Task_121837_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_121837_Name = {
    Text = "Passer Parfait"
  },
  Task_121838_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_121838_Name = {
    Text = "Passer Parfait"
  },
  Task_121839_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_121839_Name = {
    Text = "Passer Parfait"
  },
  Task_121840_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_121840_Name = {
    Text = "Passer Parfait"
  },
  Task_121841_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_121841_Name = {
    Text = "Passer Parfait"
  },
  Task_121842_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_121842_Name = {
    Text = "Passer Parfait"
  },
  Task_121843_Desc = {
    Text = "Subir toutes les malédictions des saints et vaincre la « projection du Paradis » en 15 tours."
  },
  Task_121843_Name = {
    Text = "Effondrement du paradis·Cacher"
  },
  Task_121844_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_121844_Name = {
    Text = "Passer Parfait"
  },
  Task_121897_Desc = {
    Text = "Pour chaque tour restant, obtenez 20 points supplémentaires. (Tours restants actuels : {s1})"
  },
  Task_121897_Name = {
    Text = "Sablier temporel<size=20><color=#747474>Nombre de tours initial de 50, obtenez 20 points supplémentaires pour chaque tour restant.</color></size>"
  },
  Task_122110_Desc = {
    Text = "Jouez pour la première fois chaque jour et gagnez 500 points."
  },
  Task_122110_Name = {
    Text = "Pionnier des rêves<size=20><color=#747474>obtenez 500 points lors de votre première session quotidienne</color></size>"
  },
  Task_122197_Desc = {
    Text = "Utilisez n'importe quel éveillé du chaos pour remporter une victoire dans « Le soi perdu »"
  },
  Task_122198_Desc = {
    Text = "Terminez « Commandez les Membres » à la difficulté folie"
  },
  Task_122199_Desc = {
    Text = "Éliminer « Cœur brisé » en difficulté Folie"
  },
  Task_122200_Desc = {
    Text = "Éliminer \"Appendicectomie\" en toute difficulté"
  },
  Task_122201_Desc = {
    Text = "Effacer \"Contrôle de la parole\" à n'importe quelle difficulté"
  },
  Task_122202_Desc = {
    Text = "Effacer \"Réfléchir par instinct\" à n'importe quelle difficulté"
  },
  Task_122203_Desc = {
    Text = "Effacer \"Libération du Vrai Soi\" à la difficulté folie"
  },
  Task_122204_Desc = {
    Text = "Terminer « Les Yeux Bandés » en difficulté Folie"
  },
  Task_122205_Desc = {
    Text = "Éliminez « Brisez le cœur » à n'importe quelle difficulté"
  },
  Task_122206_Desc = {
    Text = "Effacer \"Contrôle de la parole\" à n'importe quelle difficulté"
  },
  Task_122207_Desc = {
    Text = "Terminer « Appendicectomie » à la difficulté folie"
  },
  Task_122208_Desc = {
    Text = "Effacer \"Réfléchir par instinct\" à n'importe quelle difficulté"
  },
  Task_122209_Desc = {
    Text = "Utilisez le Réveilleur du Domaine ultra pour remporter une victoire dans « Soi perdu »"
  },
  Task_122210_Desc = {
    Text = "Terminer \"Dominion des Membres\" à n'importe quelle difficulté"
  },
  Task_122211_Desc = {
    Text = "Effacer \"Libérer le vrai soi\" à n'importe quelle difficulté"
  },
  Task_122212_Desc = {
    Text = "Lien multidimensionnel clair \"Le baptême d'argent et de sang\""
  },
  Task_122213_Desc = {
    Text = "Terminer tous les succès de « Perte de soi : Terminer »"
  },
  Task_122214_Desc = {
    Text = "Éliminer « Voile les yeux » à n'importe quelle difficulté"
  },
  Task_122215_Desc = {
    Text = "Perte de soi : Royaume"
  },
  Task_122216_Desc = {
    Text = "Terminer « Réfléchir par instinct » à la difficulté folie"
  },
  Task_122217_Desc = {
    Text = "Terminer \"Dominion des Membres\" à n'importe quelle difficulté"
  },
  Task_122218_Desc = {
    Text = "Effacer \"Libérer le vrai soi\" à n'importe quelle difficulté"
  },
  Task_122219_Desc = {
    Text = "Perdu de soi : Éclairci"
  },
  Task_122220_Desc = {
    Text = "Utilisez n'importe quel Réveilleur Caro pour remporter deux victoires dans « Le soi perdu »"
  },
  Task_122221_Desc = {
    Text = "Perte de soi : folie"
  },
  Task_122222_Desc = {
    Text = "Éliminer « Voile les yeux » à n'importe quelle difficulté"
  },
  Task_122223_Desc = {
    Text = "Effacer \"Contrôle de la parole\" à la difficulté folie"
  },
  Task_122224_Desc = {
    Text = "Éliminer \"Appendicectomie\" en toute difficulté"
  },
  Task_122225_Desc = {
    Text = "Utilisez n'importe quel éveillé Aequor pour remporter une victoire dans « Le soi perdu »"
  },
  Task_122226_Desc = {
    Text = "Utilisez n'importe quel Réveilleur du royaume Aequor pour remporter deux victoires dans « Le soi perdu »"
  },
  Task_122227_Desc = {
    Text = "Utilisez n'importe quel éveillé Caro pour remporter une victoire dans « Le soi perdu »"
  },
  Task_122228_Desc = {
    Text = "Éliminez « Brisez le cœur » à n'importe quelle difficulté"
  },
  Task_122229_Desc = {
    Text = "Utilisez le Réveilleur du Domaine hyperdimensionnel pour remporter 2 victoires dans « Soi perdu »"
  },
  Task_122230_Desc = {
    Text = "Utilisez n'importe quel éveillé du chaos pour remporter deux victoires dans « Le soi perdu »"
  },
  Task_122411_Desc = {
    Text = "+250/500/750/1000 points pour 1/2/3/4 Éveilleurs renforcés déployés. (Actuellement : {s1})"
  },
  Task_122411_Name = {
    Text = "Appel des Abysses<size=20><color=#747474>Obtenez 250/500/750/1000 points lorsque vous utilisez 1/2/3/4 Éveilleurs renforcés cette semaine en combat.</color></size>"
  },
  Task_122584_Name = {
    Text = "Vaincre Tous les Boss"
  },
  Task_122704_Desc = {
    Text = "Le taux de synchronisation de Mouchette atteint le niveau 10"
  },
  Task_122808_Desc = {
    Text = "Obtenez Mouchette à illuminer 6"
  },
  Task_122808_Name = {
    Text = "Obtenez Mouchette en illuminant 6"
  },
  Task_122808_UnlockCondDesc = {
    Text = "Activité @réveilleur Mouchette paquet lumineux 2 activité"
  },
  Task_122809_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_122812_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_122816_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_122819_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_122824_Desc = {
    Text = "Obtenez Mouchette à illuminer 2"
  },
  Task_122824_Name = {
    Text = "Obtenez Mouchette à dégagement 2"
  },
  Task_122824_UnlockCondDesc = {
    Text = "Activité @réveilleur Mouchette paquet lumineux 2 activité"
  },
  Task_122828_Desc = {
    Text = "Terminer la Mission d'enquête - Oubli - Chapitre 3 en mode Difficile"
  },
  Task_122829_Desc = {
    Text = "Terminer «Mission d'enquête - Oubli - Chapitre 1» en mode difficile"
  },
  Task_122830_Desc = {
    Text = "Compléter la mission d'enquête - Oubli - Chapitre 6 en mode difficile"
  },
  Task_122831_Desc = {
    Text = "Compléter « Mission d'enquête - Oubli - Chapitre 7 » en mode Difficile"
  },
  Task_122832_Desc = {
    Text = "Terminer la « Mission d'enquête - Oubli - Chapitre 4 » en mode difficile"
  },
  Task_122833_Desc = {
    Text = "Terminer la mission d'enquête - Oubli - Chapitre 2 en mode difficile"
  },
  Task_122834_Desc = {
    Text = "Terminer la difficulté Difficile du chapitre 5 de la Mission d'enquête - Oubli"
  },
  Task_123135_Desc = {
    Text = "Utilisez l'Éveilleur du royaume du chaos pour gagner 2 fois dans la « Boutique de la Sorcière »"
  },
  Task_123136_Desc = {
    Text = "Utiliser un Éveilleur du royaume des profondeurs pour remporter 2 victoires dans « Boutique de la Sorcière »"
  },
  Task_123137_Desc = {
    Text = "Utiliser un Éveilleur du royaume de la caro pour remporter une victoire dans « Boutique de la Sorcière »"
  },
  Task_123138_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter une victoire dans « Boutique de la Sorcière »"
  },
  Task_123139_Desc = {
    Text = "Utiliser un Éveilleur du royaume du chaos pour remporter 1 victoire dans « Boutique de la Sorcière »"
  },
  Task_123140_Desc = {
    Text = "Utiliser un Éveilleur du royaume de la caro pour remporter 2 victoires dans « Boutique de la Sorcière »"
  },
  Task_123141_Desc = {
    Text = "Boutique de la Sorcière·Royaume"
  },
  Task_123142_Desc = {
    Text = "Utiliser un Éveilleur du royaume des profondeurs pour remporter une victoire dans « Boutique de la Sorcière »"
  },
  Task_123143_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter 2 victoires dans « Boutique de la Sorcière »"
  },
  Task_123288_Desc = {
    Text = "Utiliser le Réveilleur du Domaine hyperdimensionnel pour gagner 2 fois dans «Regard de la mer profonde»"
  },
  Task_123289_Desc = {
    Text = "Utilisez l'Éveilleur du royaume des profondeurs pour gagner 2 fois dans le «Regard de la mer profonde»"
  },
  Task_123290_Desc = {
    Text = "Utiliser l'Éveilleur du royaume de la chair pour gagner 2 fois dans le «Regard de la mer profonde»"
  },
  Task_123291_Desc = {
    Text = "Utiliser l'Éveilleur du royaume du chaos pour gagner 2 fois dans le «Regard de la mer profonde»"
  },
  Task_123324_Desc = {
    Text = "Complétez 20 Missions"
  },
  Task_123325_Desc = {
    Text = "Complétez 20 Missions"
  },
  Task_123326_Desc = {
    Text = "Terminer 20 missions d'expédition"
  },
  Task_123327_Desc = {
    Text = "Terminer 1 fois l'Existence Transcendante"
  },
  Task_123328_Desc = {
    Text = "Connexion cumulative pendant 1 jour"
  },
  Task_123329_Desc = {
    Text = "Terminer 20 missions d'expédition"
  },
  Task_123330_Desc = {
    Text = "Terminer 1 fois le niveau de démonstration Thais"
  },
  Task_123331_Desc = {
    Text = "Compléter 3 quêtes quotidiennes"
  },
  Task_123332_Desc = {
    Text = "Réveiller accumulé 30 fois"
  },
  Task_123333_Desc = {
    Text = "Connexion cumulative pendant 1 jour"
  },
  Task_123334_Desc = {
    Text = "Terminer 1 fois le niveau de jeu Thais"
  },
  Task_123335_Desc = {
    Text = "Terminer 2 épreuves hebdomadaires"
  },
  Task_123336_Desc = {
    Text = "Terminer 2 épreuves hebdomadaires"
  },
  Task_123337_Desc = {
    Text = "Compléter 3 quêtes quotidiennes"
  },
  Task_123338_Desc = {
    Text = "Terminer 1 fois l'Existence Transcendante"
  },
  Task_123339_Desc = {
    Text = "Éveil cumulé 30 fois"
  },
  Task_123488_Desc = {
    Text = "Obtenez un total de 3 victoires cette saiso"
  },
  Task_123488_Name = {
    Text = "3 Victoires"
  },
  Task_123489_Desc = {
    Text = "Obtenez un total de 6 victoires cette saiso"
  },
  Task_123489_Name = {
    Text = "6 victoires"
  },
  Task_123490_Desc = {
    Text = "Obtenez 10 victoires cette saiso"
  },
  Task_123490_Name = {
    Text = "10 Victoires"
  },
  Task_123491_Desc = {
    Text = "Obtenez 1 victoire cette saiso"
  },
  Task_123491_Name = {Text = "1 Victoire"},
  Task_123726_Name = {
    Text = "Recommencer la quête secondaire de Mouchette en difficulté normale 6"
  },
  Task_123878_Desc = {
    Text = "Remporter 2 victoires dans «Ambition de la Bête» avec un Éveilleur du royaume du chaos"
  },
  Task_123883_Desc = {
    Text = "Remporter 2 victoires dans «Ambition de la Bête» avec un Réveilleur du Domaine hyperdimensionnel"
  },
  Task_123885_Desc = {
    Text = "Remporter 2 victoires dans «Ambition de la Bête» avec un Éveilleur du royaume des profondeurs"
  },
  Task_123887_Desc = {
    Text = "Remporter 2 victoires dans «Ambition de la Bête» avec un Éveilleur du royaume de la caro"
  },
  Task_124214_Desc = {
    Text = "Obtenez un total de 3 victoires cette saiso"
  },
  Task_124214_Name = {
    Text = "3 Victoires"
  },
  Task_124215_Desc = {
    Text = "Obtenez 10 victoires cette saiso"
  },
  Task_124215_Name = {
    Text = "10 Victoires"
  },
  Task_124216_Desc = {
    Text = "Obtenez 1 victoire cette saiso"
  },
  Task_124216_Name = {Text = "1 Victoire"},
  Task_124217_Desc = {
    Text = "Obtenez un total de 6 victoires cette saiso"
  },
  Task_124217_Name = {
    Text = "6 victoires"
  },
  Task_124797_Desc = {
    Text = "Compléter la connexion multidimensionnelle «Tour inverse»"
  },
  Task_124797_Name = {
    Text = "Inversion cosmique"
  },
  Task_124798_Desc = {
    Text = "Terminer le lien multivers \"Baptême d'argent et de sang\" en difficulté difficile"
  },
  Task_124798_Name = {
    Text = "L'avenir viendra : dur"
  },
  Task_124799_Desc = {
    Text = "Connexion multidimensionnelle complète \"Le Baptême d'argent et de sang\""
  },
  Task_124799_Name = {
    Text = "L'avenir viendra"
  },
  Task_124835_Desc = {
    Text = "Terminer \"Enquête - Héritage estompé - Chapitre 1\""
  },
  Task_125386_Desc = {
    Text = "Éliminez « Ascension du Cadavre » à n'importe quelle difficulté"
  },
  Task_125387_Desc = {
    Text = "Éliminez « Ombre derrière » à n'importe quelle difficulté"
  },
  Task_125388_Desc = {
    Text = "Éliminer « Aspiration » à n'importe quelle difficulté"
  },
  Task_125389_Desc = {
    Text = "Terminer « Suivre l'odeur » à la difficulté folie"
  },
  Task_125390_Desc = {
    Text = "Effacer \"Ordre de la Grâce Gonflante\" à n'importe quelle difficulté"
  },
  Task_125391_Desc = {
    Text = "Utilisez n'importe quel Réveilleur Caro pour remporter une victoire dans « Matriarche d'obsidienne »"
  },
  Task_125392_Desc = {
    Text = "Compléter la plongée dans l'inconscient «Conversations nocturnes sous l'éventail»"
  },
  Task_125392_Name = {
    Text = "Dodo, petit enfant"
  },
  Task_125393_Desc = {
    Text = "Éliminer \"Suivre l'odeur\" à n'importe quelle difficulté"
  },
  Task_125394_Desc = {
    Text = "Terminer « Mort injuste » à la difficulté folie"
  },
  Task_125395_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_125396_Desc = {
    Text = "Utilisez n'importe quel Réveilleur du chaos pour remporter deux victoires dans « Matriarche d'Obsidienne »"
  },
  Task_125397_Desc = {
    Text = "Terminer « Liés par la Haine » à la difficulté folie"
  },
  Task_125398_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_125399_Desc = {
    Text = "Éliminer \"Mort Injuste\" à n'importe quelle difficulté"
  },
  Task_125400_Desc = {
    Text = "Utilisez n'importe quel Éveillé du chaos pour remporter une victoire dans « Matriarche d'Obsidienne »"
  },
  Task_125401_Desc = {
    Text = "Matriarche Obsidienne : Éclairci"
  },
  Task_125402_Desc = {
    Text = "Éliminer « Aspiration » à n'importe quelle difficulté"
  },
  Task_125403_Desc = {
    Text = "Éliminez « Ombre derrière » à n'importe quelle difficulté"
  },
  Task_125404_Desc = {
    Text = "Effacer « Euphorie » à la difficulté folie"
  },
  Task_125406_Desc = {
    Text = "Utilisez n'importe quel éveillé Aequor pour remporter une victoire dans « Matriarche d'Obsidienne »"
  },
  Task_125407_Desc = {
    Text = "Effacer \"Euphorie\" à n'importe quelle difficulté"
  },
  Task_125409_Desc = {
    Text = "Effacer \"Euphorie\" à n'importe quelle difficulté"
  },
  Task_125410_Desc = {
    Text = "Utilisez n'importe quel Réveilleur Caro pour remporter deux victoires dans « Matriarche d'Obsidienne »"
  },
  Task_125411_Desc = {
    Text = "Utilisez n'importe quel Réveilleur Aequor pour remporter deux victoires dans « Matriarche d'Obsidienne »"
  },
  Task_125412_Desc = {
    Text = "Éliminer « Aspiration » à la difficulté folie"
  },
  Task_125413_Desc = {
    Text = "Effacer \"Psyche Deepdive : Murmures derrière le ventilateur\""
  },
  Task_125414_Desc = {
    Text = "Éliminer « Piège de soie » à n'importe quelle difficulté"
  },
  Task_125415_Desc = {
    Text = "L'affinité de Xu atteint le niveau 10"
  },
  Task_125416_Desc = {
    Text = "Utilisez n'importe quel Réveilleur ultra pour remporter 2 victoires dans « Matriarche d'Obsidienne »"
  },
  Task_125417_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_125418_Desc = {
    Text = "Éclaircissement 2 lors de l'obtention de Xu"
  },
  Task_125418_Name = {
    Text = "Éclaircissement 2 lors de l'obtention de Xu"
  },
  Task_125418_UnlockCondDesc = {
    Text = "Activité@Éveilleur Xu Dégagement paquet d'activité 2"
  },
  Task_125419_Desc = {
    Text = "Terminez « Lié par la rancœur » à n'importe quelle difficulté"
  },
  Task_125420_Desc = {
    Text = "Matriarche d'Obsidienne : Royaume"
  },
  Task_125421_Desc = {
    Text = "Effacer \"Ombre derrière\" à la difficulté folie"
  },
  Task_125422_Desc = {
    Text = "Terminez « Lié par la rancœur » à n'importe quelle difficulté"
  },
  Task_125423_Desc = {
    Text = "Utilisez n'importe quel Réveilleur ultra pour remporter une victoire dans « Matriarche d'Obsidienne »"
  },
  Task_125424_Desc = {
    Text = "Éliminer \"Suivre l'odeur\" à n'importe quelle difficulté"
  },
  Task_125425_Desc = {
    Text = "Effacer \"Ordre de la Grâce Gonflée\" à la difficulté folie"
  },
  Task_125426_Desc = {
    Text = "Éclaircissez 6 lors de l'obtention de Xu"
  },
  Task_125426_Name = {
    Text = "Éclaircissez 6 lors de l'obtention de Xu"
  },
  Task_125426_UnlockCondDesc = {
    Text = "Activité@Éveilleur Xu Dégagement paquet d'activité 2"
  },
  Task_125427_Desc = {
    Text = "Éliminer « Piège de soie » à n'importe quelle difficulté"
  },
  Task_125428_Desc = {
    Text = "Terminer tous les succès de « Matriarche d'obsidienne : Terminer »"
  },
  Task_125429_Desc = {
    Text = "Éliminez « Ascension du Cadavre » à n'importe quelle difficulté"
  },
  Task_125430_Desc = {
    Text = "Terminer « Piège de soie » à la difficulté folie"
  },
  Task_125431_Desc = {
    Text = "Effacer \"Ordre de la Grâce Gonflante\" à n'importe quelle difficulté"
  },
  Task_125432_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_125433_Desc = {
    Text = "Éliminer \"Mort Injuste\" à n'importe quelle difficulté"
  },
  Task_125434_Desc = {
    Text = "Matriarche d'Obsidienne : folie"
  },
  Task_125435_Desc = {
    Text = "Terminer « Ascension des Cadavres » à la difficulté folie"
  },
  Task_125500_Desc = {
    Text = "Obtenez un total de 6 victoires cette saiso"
  },
  Task_125500_Name = {
    Text = "6 victoires"
  },
  Task_125501_Desc = {
    Text = "Obtenez 10 victoires cette saiso"
  },
  Task_125501_Name = {
    Text = "10 Victoires"
  },
  Task_125502_Desc = {
    Text = "Obtenez 1 victoire cette saiso"
  },
  Task_125502_Name = {Text = "1 Victoire"},
  Task_125503_Desc = {
    Text = "Obtenez un total de 3 victoires cette saiso"
  },
  Task_125503_Name = {
    Text = "3 Victoires"
  },
  Task_125686_Desc = {
    Text = "Échapper à la poursuite"
  },
  Task_125686_Name = {Text = "Objectif"},
  Task_125687_Desc = {
    Text = "Survivre à une embuscade"
  },
  Task_125687_Name = {Text = "Objectif"},
  Task_125688_Desc = {
    Text = "Récupérer le corps de Liz"
  },
  Task_125688_Name = {Text = "Objectif"},
  Task_125689_Desc = {
    Text = "Échapper au piège d'Arachne"
  },
  Task_125689_Name = {Text = "Objectif"},
  Task_125690_Desc = {
    Text = "Lever le sceau des trois plasmides"
  },
  Task_125690_Name = {Text = "Objectif"},
  Task_125691_Desc = {
    Text = "Affronter les ennemis dans la taverne"
  },
  Task_125691_Name = {Text = "Objectif"},
  Task_125692_Desc = {
    Text = "Éliminer les mutants"
  },
  Task_125692_Name = {Text = "Objectif"},
  Task_125693_Desc = {
    Text = "Sauvez «la bonté»"
  },
  Task_125693_Name = {Text = "Objectif"},
  Task_125694_Desc = {
    Text = "Protégez Sorel"
  },
  Task_125694_Name = {Text = "Objectif"},
  Task_125695_Desc = {
    Text = "Vengeance pour «Souvenir»"
  },
  Task_125695_Name = {Text = "Objectif"},
  Task_125845_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_125845_Name = {
    Text = "Passer Parfait"
  },
  Task_125846_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_125846_Name = {
    Text = "Passer Parfait"
  },
  Task_125847_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_125847_Name = {
    Text = "Passer Parfait"
  },
  Task_125848_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_125848_Name = {
    Text = "Passer Parfait"
  },
  Task_125849_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_125849_Name = {
    Text = "Passer Parfait"
  },
  Task_125850_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_125850_Name = {
    Text = "Passer Parfait"
  },
  Task_125851_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_125851_Name = {
    Text = "Passer Parfait"
  },
  Task_125852_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_125852_Name = {
    Text = "Passer Parfait"
  },
  Task_125853_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_125853_Name = {
    Text = "Passer Parfait"
  },
  Task_125854_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_125854_Name = {
    Text = "Passer Parfait"
  },
  Task_126276_Desc = {
    Text = "Terminer «Veuillez ne pas spoiler» en difficulté Folie"
  },
  Task_126277_Desc = {
    Text = "Scène de la marionnette·Folie"
  },
  Task_126279_Desc = {
    Text = "Avec des Corps éveillé des abysses, gagner une fois dans «Scène de la marionnette»"
  },
  Task_126280_Desc = {
    Text = "Scène de la marionnette·Terminer"
  },
  Task_126281_Desc = {
    Text = "Terminer «Brûler» à n'importe quelle difficulté"
  },
  Task_126282_Desc = {
    Text = "Terminer «Veuillez ne pas spoiler» à n'importe quelle difficulté"
  },
  Task_126285_Desc = {
    Text = "Terminer «Entrée» à n'importe quelle difficulté"
  },
  Task_126286_Desc = {
    Text = "Terminer «Inversion, inversion» à n'importe quelle difficulté"
  },
  Task_126288_Desc = {
    Text = "Terminer «L'arme sur le mur» à n'importe quelle difficulté"
  },
  Task_126290_Desc = {
    Text = "Terminer «Brûler» en difficulté Folie"
  },
  Task_126292_Desc = {
    Text = "Terminer «L'arme sur le mur» en difficulté Folie"
  },
  Task_126293_Desc = {
    Text = "Terminer «Brûler» à n'importe quelle difficulté"
  },
  Task_126294_Desc = {
    Text = "Compléter tous les succès de «Scène de la marionnette·Terminer»"
  },
  Task_126295_Desc = {
    Text = "Avec des Corps Éveillé Hyperdimensionnel, gagner une fois dans «Scène de la marionnette»"
  },
  Task_126296_Desc = {
    Text = "Terminer «Inversion, inversion» en difficulté Folie"
  },
  Task_126297_Desc = {
    Text = "Terminer «Entrée» en difficulté Folie"
  },
  Task_126298_Desc = {
    Text = "Scène de la marionnette : Royaume"
  },
  Task_126299_Desc = {
    Text = "Avec des Corps éveillé des abysses, gagner deux fois dans «Scène de la marionnette»"
  },
  Task_126302_Desc = {
    Text = "Avec des Corps éveillé du Chaos, gagner deux fois dans «Scène de la marionnette»"
  },
  Task_126303_Desc = {
    Text = "Terminer «Entrée» à n'importe quelle difficulté"
  },
  Task_126304_Desc = {
    Text = "Avec des Corps Éveillé de Chair et de Sang, gagner deux fois dans «Scène de la marionnette»"
  },
  Task_126305_Desc = {
    Text = "Terminer «Veuillez ne pas spoiler» à n'importe quelle difficulté"
  },
  Task_126307_Desc = {
    Text = "Terminer «L'arme sur le mur» à n'importe quelle difficulté"
  },
  Task_126309_Desc = {
    Text = "Avec des Corps Éveillé de Chair et de Sang, gagner une fois dans «Scène de la marionnette»"
  },
  Task_126311_Desc = {
    Text = "Avec des Corps Éveillé Hyperdimensionnel, gagner deux fois dans «Scène de la marionnette»"
  },
  Task_126312_Desc = {
    Text = "Avec des Corps éveillé du Chaos, gagner une fois dans «Scène de la marionnette»"
  },
  Task_126313_Desc = {
    Text = "Terminer «Inversion, inversion» à n'importe quelle difficulté"
  },
  Task_126385_Desc = {
    Text = "Terminer Chapitre des Étoiles 5 « Théâtre du Destin » Difficile"
  },
  Task_126386_Desc = {
    Text = "Terminer Chapitre des Étoiles 5 « Théâtre du Destin » Difficile"
  },
  Task_126387_Desc = {
    Text = "Terminer Chapitre des Étoiles Chapitre 5–7"
  },
  Task_126388_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_126390_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_126391_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_126392_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_126393_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_126394_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_126395_Desc = {
    Text = "Terminer Chapitre des Étoiles 5 « Théâtre du Destin »"
  },
  Task_126396_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_126397_Desc = {
    Text = "Terminer Chapitre des Étoiles Chapitre 5–6 : Difficile"
  },
  Task_126398_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_126399_Desc = {
    Text = "Terminer Chapitre des Étoiles Chapitre 5–6 : Difficile"
  },
  Task_126400_Desc = {
    Text = "Terminer Chapitre des Étoiles Chapitre 5–7"
  },
  Task_126401_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_126402_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_126403_Desc = {
    Text = "Terminer Chapitre des Étoiles 5 « Théâtre du Destin »"
  },
  Task_126493_Desc = {
    Text = "Monologues de Panlong VII"
  },
  Task_126494_Desc = {
    Text = "«Monologues de Panlong : Exclusivité à durée limitée»"
  },
  Task_126495_Desc = {
    Text = "Monologues de Panlong V"
  },
  Task_126496_Desc = {
    Text = "Monologues de Panlong I"
  },
  Task_126497_Desc = {
    Text = "Monologues de Panlong VI"
  },
  Task_126498_Desc = {
    Text = "Monologues de Panlong III"
  },
  Task_126499_Desc = {
    Text = "Monologues de Panlong IV"
  },
  Task_126500_Desc = {
    Text = "Panlong Soliloques : Gratuit"
  },
  Task_126501_Desc = {
    Text = "Monologues de Panlong II"
  },
  Task_127071_Desc = {
    Text = "Obtenez 10 victoires cette saiso"
  },
  Task_127071_Name = {
    Text = "10 Victoires"
  },
  Task_127072_Desc = {
    Text = "Obtenez un total de 3 victoires cette saiso"
  },
  Task_127072_Name = {
    Text = "3 Victoires"
  },
  Task_127073_Desc = {
    Text = "Obtenez un total de 6 victoires cette saiso"
  },
  Task_127073_Name = {
    Text = "6 victoires"
  },
  Task_127074_Desc = {
    Text = "Obtenez 1 victoire cette saiso"
  },
  Task_127074_Name = {Text = "1 Victoire"},
  Task_127094_Desc = {
    Text = "Aurita Éclaircissement atteint Surge Psyche 12"
  },
  Task_127095_Desc = {
    Text = "L'illumination de Genesis Ramona atteint Surge de psyché 12"
  },
  Task_127096_Desc = {
    Text = "Ramona Éclaircissement atteint Psyche Surge 12"
  },
  Task_127097_Desc = {
    Text = "L'illumination d'Aigis atteint la montée de Psyché 12"
  },
  Task_127098_Desc = {
    Text = "L'illumination de Lotan atteint la montée de la psyché 12"
  },
  Task_127099_Desc = {
    Text = "Erica Éclaircissement atteint Psyche Surge 12"
  },
  Task_127100_Desc = {
    Text = "Poupée Éclaircissement atteint Psyche Surge 12"
  },
  Task_127101_Desc = {
    Text = "Ogier Éclaircissement atteint Psyche Surge 12"
  },
  Task_129511_Desc = {
    Text = "Terminer en utilisant une équipe composée de 3 Éveilleurs de Chair et 1 Corps Éveillé Hyperdimensionnel à la difficulté Difficile ou Folie"
  },
  Task_129512_Desc = {
    Text = "Utilisez une équipe composée de 3 Éveilleurs du Chaos et 1 Corps Éveillé Hyperdimensionnel pour terminer en difficulté Difficile ou Folie"
  },
  Task_129513_Desc = {
    Text = "Trace de voie de colonne · Difficile"
  },
  Task_129513_Name = {
    Text = "Trace de voie de colonne · Difficile"
  },
  Task_129514_Desc = {
    Text = "Terminer la troisième étape à la difficulté folie"
  },
  Task_129515_Desc = {
    Text = "Terminer avec une équipe composée d'1 Chair et de 3 Corps Éveillés Hyperdimensionnels en difficulté Difficile ou Folie"
  },
  Task_129516_Desc = {
    Text = "Phase 3 : Vaincre « Fusion · Dor » à n'importe quelle difficulté"
  },
  Task_129517_Desc = {
    Text = "Phase 3 : Vaincre « Voile du paradis » à n'importe quelle difficulté"
  },
  Task_129518_Desc = {
    Text = "Terminez toutes les quêtes de « Trace de voie de colonne: Difficile »"
  },
  Task_129519_Desc = {
    Text = "Terminez n'importe quelle difficulté en utilisant une équipe composée de 4 Corps Éveillés Hyperdimensionnels"
  },
  Task_129520_Desc = {
    Text = "Terminer la deuxième phase de Difficulté normale"
  },
  Task_129521_Desc = {
    Text = "Phase 2 : Vaincre « Hydre » à n'importe quelle difficulté"
  },
  Task_129522_Desc = {
    Text = "Utilisez une équipe composée de 4 Corps Éveillés de Chair et de Sang pour terminer à n'importe quelle difficulté"
  },
  Task_129523_Desc = {
    Text = "Terminez un niveau de n'importe quelle difficulté avec une équipe composée de 2 Chaires et 2 Corps Éveillés Hyperdimensionnels"
  },
  Task_129524_Desc = {
    Text = "Utilisez une équipe composée de 3 Éveilleurs Aequor et 1 Corps Éveillé de Chair pour terminer à la difficulté Difficile ou Folie"
  },
  Task_129525_Desc = {
    Text = "Terminer la première phase de Difficulté normale"
  },
  Task_129526_Desc = {
    Text = "Terminez avec une équipe composée de 2 Éveilleurs de Chaos et de 2 Corps Éveillés de Chair et de Sang à n'importe quel niveau de difficulté"
  },
  Task_129527_Desc = {
    Text = "Utilisez une équipe composée de 3 Éveilleurs du Chaos et 1 Corps Éveillé de Chair pour terminer en difficulté Difficile ou Folie"
  },
  Task_129528_Desc = {
    Text = "Terminer toutes les missions de « Instantanés en chemin · Plaisir »"
  },
  Task_129529_Desc = {
    Text = "Terminer la troisième étape de Difficulté normale"
  },
  Task_129530_Desc = {
    Text = "Terminez en mode Difficile ou Folie avec une équipe composée de 3 Éveilleurs du Chaos et 1 Corps éveillé des abysses"
  },
  Task_129531_Desc = {
    Text = "Phase 1 : Vaincre «▼Ah▼▼ya» à n'importe quelle difficulté"
  },
  Task_129532_Desc = {
    Text = "Complétez la deuxième phase de difficulté Difficile"
  },
  Task_129533_Desc = {
    Text = "Terminer la première étape de la difficulté Folie"
  },
  Task_129534_Desc = {
    Text = "Instantanés en chemin·Souvenirs du passé"
  },
  Task_129534_Name = {
    Text = "Instantanés en chemin·Souvenirs du passé"
  },
  Task_129535_Desc = {
    Text = "Phase 3 : Vaincre « Marionnette de la Marée Putride » à n'importe quelle difficulté"
  },
  Task_129536_Desc = {
    Text = "Instantanés en chemin·Couloir de plaisir"
  },
  Task_129536_Name = {
    Text = "Instantanés en chemin · Plaisir"
  },
  Task_129537_Desc = {
    Text = "Phase 3 : Vaincre « Ultra @2 Chrysalis » à n'importe quelle difficulté"
  },
  Task_129538_Desc = {
    Text = "Utilisez une équipe composée de 2 Éveilleurs de type Aequor et de 2 Corps Éveillés de Chair et de Sang pour terminer à n'importe quel niveau de difficulté"
  },
  Task_129539_Desc = {
    Text = "Phase 2 : Vaincre « Arbre Mère de Fertilité » à n'importe quelle difficulté"
  },
  Task_129540_Desc = {
    Text = "Phase 1 : Vaincre « Joe le pleurnichard ▼ » à n'importe quelle difficulté"
  },
  Task_129541_Desc = {
    Text = "Terminez avec une équipe composée de 2 Chaos et 2 Corps éveillés des abysses à n'importe quelle difficulté"
  },
  Task_129542_Desc = {
    Text = "Terminer la troisième étape de difficulté difficile"
  },
  Task_129543_Desc = {
    Text = "Phase 1 : Vaincre « Rép▲▲ » à n'importe quelle difficulté"
  },
  Task_129544_Desc = {
    Text = "Terminer en difficulté Difficile ou Folie avec une équipe composée de 3 Aequor et 1 Corps Éveillé Hyperdimensionnel"
  },
  Task_129545_Desc = {
    Text = "Terminer la deuxième phase en difficulté Folie"
  },
  Task_129546_Desc = {
    Text = "Phase 1 : Vaincre « Chien Traverseur de Dimensions » à n'importe quelle difficulté"
  },
  Task_129547_Desc = {
    Text = "Phase 2 : Vaincre « Conflit des Jumeaux » à n'importe quelle difficulté"
  },
  Task_129548_Desc = {
    Text = "Utilisez une équipe composée de 1 Aequor et de 3 Corps Éveillés de Chair et de Sang pour terminer à la difficulté Difficile ou Folie"
  },
  Task_129549_Desc = {
    Text = "Terminez avec une équipe composée de 2 Éveilleurs de Chaos et de 2 Corps Éveillés Hyperdimensionnels à n'importe quelle difficulté"
  },
  Task_129550_Desc = {
    Text = "Terminez la première phase de difficulté élevée"
  },
  Task_129551_Desc = {
    Text = "Terminer toutes les missions de « Trace de voie de colonne · Ordinaire »"
  },
  Task_129552_Desc = {
    Text = "Utilisez une équipe composée de 2 Éveilleurs Aequor et de 2 Éveilleurs Hyperdimensionnels pour terminer n'importe quelle difficulté"
  },
  Task_129553_Desc = {
    Text = "Trace de voie de colonne · Ordinaire"
  },
  Task_129553_Name = {
    Text = "Trace de voie de colonne · Ordinaire"
  },
  Task_129554_Desc = {
    Text = "Terminez en mode Difficile ou Folie avec une équipe composée de 1 Chaos et de 3 Corps Éveillés de Chair et de Sang"
  },
  Task_129555_Desc = {
    Text = "Terminez avec une équipe composée d'1 Chaos et de 3 Corps Éveillés Hyperdimensionnels en difficulté Difficile ou Folie"
  },
  Task_129556_Desc = {
    Text = "Terminez n'importe quelle difficulté en utilisant une équipe composée de 4 Corps éveillés des abysses"
  },
  Task_129557_Desc = {
    Text = "Terminez en mode Difficile ou Folie avec une équipe composée de 1 Chaos et 3 Corps éveillés des abysses"
  },
  Task_129558_Desc = {
    Text = "Utilisez une équipe composée de 1 Aequor et de 3 Corps Éveillés Hyperdimensionnels pour terminer à la difficulté Difficile ou Folie"
  },
  Task_129559_Desc = {
    Text = "Utilisez une équipe composée de 4 Corps éveillés du Chaos pour terminer n'importe quel niveau de difficulté"
  },
  Task_129560_Desc = {
    Text = "Terminer toutes les tâches dans « Instantanés en cours de route : Souvenirs du passé »"
  },
  Task_129561_Desc = {
    Text = "Phase 2 : Vaincre « Enfant Saint » à n'importe quelle difficulté"
  },
  Task_129895_Desc = {
    Text = "Compléter l'enregistrement de la task force «Train en direction du Festival de la Prière»"
  },
  Task_129895_Name = {
    Text = "Dans le bruit des pétards, une année s'achève"
  },
  Task_130180_Desc = {
    Text = "Terminer la Connexion multidimensionnelle «Graine d'Amour Oubliée»"
  },
  Task_130181_Desc = {
    Text = "Terminer «Bonnet de nuit» en difficulté Folie"
  },
  Task_130182_Desc = {
    Text = "Terminer «Table à manger» en toute difficulté"
  },
  Task_130183_Desc = {
    Text = "Avec des Corps éveillés des abysses, gagner deux fois dans « Naissance Inversée »"
  },
  Task_130184_Desc = {
    Text = "Avec des Corps Éveillés de Chair et de Sang, gagner une fois dans « Naissance Inversée »"
  },
  Task_130185_Desc = {
    Text = "Terminer «À l'école» en toute difficulté"
  },
  Task_130186_Desc = {
    Text = "Terminer «L'Hôpital» à n'importe quelle difficulté"
  },
  Task_130187_Desc = {
    Text = "Terminer «Bonnet de nuit» en toute difficulté"
  },
  Task_130188_Desc = {
    Text = "Terminer « L'Hôpital » en difficulté Folie"
  },
  Task_130189_Desc = {
    Text = "Avec des Corps éveillés du Chaos, gagner une fois dans « Naissance Inversée »"
  },
  Task_130190_Desc = {
    Text = "Avec des Corps Éveillés de Chair et de Sang, gagner deux fois dans « Naissance Inversée »"
  },
  Task_130191_Desc = {
    Text = "Terminer «Le Puits» en difficulté Folie"
  },
  Task_130192_Desc = {
    Text = "Avec des Corps Éveillés Hyperdimensionnels, gagner deux fois dans « Naissance Inversée »"
  },
  Task_130193_Desc = {
    Text = "Terminer «À l'école» en difficulté Folie"
  },
  Task_130194_Desc = {
    Text = "Terminer «Table à manger» en toute difficulté"
  },
  Task_130195_Desc = {
    Text = "Terminer «Notre Foyer» à n'importe quelle difficulté"
  },
  Task_130196_Desc = {
    Text = "Terminer «Bonnet de nuit» en toute difficulté"
  },
  Task_130197_Desc = {
    Text = "Terminer «Neurotraumatisme» en toute difficulté"
  },
  Task_130198_Desc = {
    Text = "Avec des Corps éveillés des abysses, gagner une fois dans « Naissance Inversée »"
  },
  Task_130199_Desc = {
    Text = "Terminer «Neurotraumatisme» en toute difficulté"
  },
  Task_130200_Desc = {
    Text = "Terminer «Le Puits» en toute difficulté"
  },
  Task_130201_Desc = {
    Text = "Terminer «Notre Foyer» à n'importe quelle difficulté"
  },
  Task_130202_Desc = {
    Text = "Terminer «À l'école» en toute difficulté"
  },
  Task_130203_Desc = {
    Text = "Terminer «L'Hôpital» à n'importe quelle difficulté"
  },
  Task_130204_Desc = {
    Text = "Terminer «Le Puits» en toute difficulté"
  },
  Task_130205_Desc = {
    Text = "Naissance Inversée·Folie"
  },
  Task_130206_Desc = {
    Text = "Terminer « Notre Foyer » en difficulté Folie"
  },
  Task_130207_Desc = {
    Text = "Terminer «Neurotraumatisme» en difficulté Folie"
  },
  Task_130208_Desc = {
    Text = "Naissance Inversée : Royaume"
  },
  Task_130209_Desc = {
    Text = "Compléter tous les succès de « Naissance Inversée·Terminer »"
  },
  Task_130210_Desc = {
    Text = "Naissance Inversée·Terminer"
  },
  Task_130211_Desc = {
    Text = "Avec des Corps Éveillés Hyperdimensionnels, gagner une fois dans « Naissance Inversée »"
  },
  Task_130212_Desc = {
    Text = "Terminer «Table à manger» en difficulté Folie"
  },
  Task_130213_Desc = {
    Text = "Avec des Corps éveillés du Chaos, gagner deux fois dans « Naissance Inversée »"
  },
  Task_130412_Desc = {
    Text = "Obtenez la genèse Ogier à illuminer 2"
  },
  Task_130412_Name = {
    Text = "Obtenez la genèse Ogier à illuminer 2"
  },
  Task_130412_UnlockCondDesc = {
    Text = "Activité @réveilleur Origine Ogier paquet lumineux 2 activité"
  },
  Task_130413_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_130414_Desc = {
    Text = "Obtenez shaye à illuminer 2"
  },
  Task_130414_Name = {
    Text = "Obtenez shaye à illuminer 2"
  },
  Task_130414_UnlockCondDesc = {
    Text = "Activité @réveilleur Shaye paquet lumineux 2 activité"
  },
  Task_130416_Desc = {
    Text = "Obtenez shaye à illuminer 6"
  },
  Task_130416_Name = {
    Text = "Obtenez shaye à illuminer 6"
  },
  Task_130416_UnlockCondDesc = {
    Text = "Activité @réveilleur Shaye paquet lumineux 2 activité"
  },
  Task_130417_Desc = {
    Text = "Obtenez Satorguya à illuminer 2"
  },
  Task_130417_Name = {
    Text = "Obtenez Satorguya à illuminer 2"
  },
  Task_130417_UnlockCondDesc = {
    Text = "Activité @réveilleur Satorguya paquet lumineux 2 activité"
  },
  Task_130418_Desc = {
    Text = "Obtenez Satorgoya à illuminer 6"
  },
  Task_130418_Name = {
    Text = "Obtenez Satorgoya à illuminer 6"
  },
  Task_130418_UnlockCondDesc = {
    Text = "Activité @réveilleur Satorguya paquet lumineux 2 activité"
  },
  Task_130420_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_130421_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_130424_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_130425_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_130427_Desc = {
    Text = "Obtenez l'Origine Ogier lors de l'illumination 6"
  },
  Task_130427_Name = {
    Text = "Obtenez l'Origine Ogier lors de l'illumination 6"
  },
  Task_130427_UnlockCondDesc = {
    Text = "Activité @réveilleur Origine Ogier paquet lumineux 2 activité"
  },
  Task_130429_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_130440_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_130441_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_130442_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_130446_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_130447_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_130448_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_130459_Desc = {
    Text = "Le taux de synchronisation d'Ogier Origine atteint le niveau 10"
  },
  Task_130460_Desc = {
    Text = "Le taux de synchronisation de Satogua atteint le niveau 10"
  },
  Task_130461_Desc = {
    Text = "Le taux de synchronisation de Saya atteint le niveau 10"
  },
  Task_130555_Desc = {
    Text = "Obtenez un total de 3 victoires cette saiso"
  },
  Task_130555_Name = {
    Text = "3 Victoires"
  },
  Task_130556_Desc = {
    Text = "Obtenez 10 victoires cette saiso"
  },
  Task_130556_Name = {
    Text = "10 Victoires"
  },
  Task_130557_Desc = {
    Text = "Obtenez 1 victoire cette saiso"
  },
  Task_130557_Name = {Text = "1 Victoire"},
  Task_130558_Desc = {
    Text = "Obtenez un total de 6 victoires cette saiso"
  },
  Task_130558_Name = {
    Text = "6 victoires"
  },
  Task_130950_Desc = {
    Text = "Terminer difficulté Folie de « Grand·Tourbillon »"
  },
  Task_130951_Desc = {
    Text = "Terminer « Jours Ordinaires » à la difficulté Folie"
  },
  Task_130952_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Orage tonitruant»"
  },
  Task_130953_Desc = {
    Text = "Terminer « Découverte des Compagnons » en difficulté Folie"
  },
  Task_130954_Desc = {
    Text = "Mosk et mer · Royaume"
  },
  Task_130956_Desc = {
    Text = "Terminez tous les succès de « Mosk et la mer · Terminer »"
  },
  Task_130957_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Grand·Tourbillon »"
  },
  Task_130958_Desc = {
    Text = "Obtenez Mosk à illuminer 6"
  },
  Task_130958_Name = {
    Text = "Obtenez Mosk à illuminer 6"
  },
  Task_130958_UnlockCondDesc = {
    Text = "Activité @réveilleur Mosk paquet lumineux 2 activité"
  },
  Task_130959_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Grand·Tourbillon »"
  },
  Task_130960_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_130961_Desc = {
    Text = "Mosk et la mer · Terminer"
  },
  Task_130962_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Retour au chemin »"
  },
  Task_130963_Desc = {
    Text = "Terminer la plongée dans l'inconscient « Addiction »"
  },
  Task_130964_Desc = {
    Text = "Utiliser un Éveilleur du royaume du chaos pour remporter 2 victoires dans «Mosk et mer»"
  },
  Task_130965_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Jours ordinaires»"
  },
  Task_130966_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Moment de Sortie en Mer»"
  },
  Task_130967_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Retour au chemin »"
  },
  Task_130968_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Découverte des Compagnons»"
  },
  Task_130970_Desc = {
    Text = "Obtenez Mosk à illuminer 2"
  },
  Task_130970_Name = {
    Text = "Obtenez Mosk à illuminer 2"
  },
  Task_130970_UnlockCondDesc = {
    Text = "Activité @réveilleur Mosk paquet lumineux 2 activité"
  },
  Task_130971_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter une victoire dans « Mosk et mer »"
  },
  Task_130972_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Orage tonitruant»"
  },
  Task_130973_Desc = {
    Text = "Terminer « Trésor dérivant » à la difficulté Folie"
  },
  Task_130974_Desc = {
    Text = "Terminer « Moment de Sortie en Mer » à la difficulté Folie"
  },
  Task_130975_Desc = {
    Text = "Le taux de synchronisation de Mosk atteint le niveau 10"
  },
  Task_130976_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_130977_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Découverte des Compagnons»"
  },
  Task_130978_Desc = {
    Text = "Utiliser un Éveilleur du royaume des profondeurs pour remporter une victoire dans « Mosk et Mer »"
  },
  Task_130979_Desc = {
    Text = "Terminer difficulté Folie de «Tonnerre grondant»"
  },
  Task_130980_Desc = {
    Text = "Utiliser un Éveilleur du royaume du chaos pour remporter 1 victoire dans « Mosk et la mer »"
  },
  Task_130981_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_130982_Desc = {
    Text = "Terminer « Chemin de retour » en difficulté Folie"
  },
  Task_130983_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter 2 victoires dans « Mosk et la mer »"
  },
  Task_130984_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_130985_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Moment de Sortie en Mer»"
  },
  Task_130986_Desc = {
    Text = "Utiliser un Éveilleur du royaume des profondeurs pour remporter 2 victoires dans « Mosk et mer »"
  },
  Task_130987_Desc = {
    Text = "Utiliser un Éveilleur du royaume de la caro pour remporter 2 victoires dans « Mosk et la mer »"
  },
  Task_130988_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Trésor dérivant»"
  },
  Task_130989_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter une victoire dans « Mosk et la mer »"
  },
  Task_130990_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Jours ordinaires»"
  },
  Task_130991_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Trésor dérivant»"
  },
  Task_130992_Desc = {
    Text = "Mosk et mer · Folie"
  },
  Task_131106_Desc = {
    Text = "Empêcher Nefraea"
  },
  Task_131106_Name = {Text = "Objectif"},
  Task_131172_Desc = {
    Text = "Destin conjugué · Exclusivité temporaire"
  },
  Task_131371_Desc = {
    Text = "D-effet régional Spécial Training atteint 100"
  },
  Task_131372_Desc = {
    Text = "Réveiller 30 fois"
  },
  Task_131373_Desc = {
    Text = "Réveiller 30 fois"
  },
  Task_131374_Desc = {
    Text = "Compléter 3 quêtes quotidiennes"
  },
  Task_131375_Desc = {
    Text = "Terminer toutes les épreuves hebdomadaires de 1 semaine"
  },
  Task_131376_Desc = {
    Text = "Connexion cumulative pendant 1 jour"
  },
  Task_131377_Desc = {
    Text = "Complétez 20 Missions"
  },
  Task_131378_Desc = {
    Text = "Terminer toutes les épreuves hebdomadaires de 1 semaine"
  },
  Task_131379_Desc = {
    Text = "D-effet régional Spécial Training atteint 100"
  },
  Task_131380_Desc = {
    Text = "Complétez 20 Missions"
  },
  Task_131381_Desc = {
    Text = "Terminer 1 fois l'Existence Transcendante"
  },
  Task_131382_Desc = {
    Text = "Compléter 3 quêtes quotidiennes"
  },
  Task_131383_Desc = {
    Text = "Terminer 1 fois l'Existence Transcendante"
  },
  Task_131384_Desc = {
    Text = "Connexion cumulative pendant 1 jour"
  },
  Task_131385_Desc = {
    Text = "Terminer 1 fois le niveau d'essai de Ryker"
  },
  Task_131386_Desc = {
    Text = "Terminer 1 fois le niveau d'essai de Ryker"
  },
  Task_131450_Desc = {
    Text = "Vaincre 60 éveillés dans les Échecs de Phase"
  },
  Task_131451_Desc = {
    Text = "Vaincre 36 éveillés dans les Échecs de Phase"
  },
  Task_131452_Desc = {
    Text = "Dans le mode de pré-groupe, obtenir 10 victoires"
  },
  Task_131453_Desc = {
    Text = "Jouez 740 cartes en Échecs de Phase"
  },
  Task_131454_Desc = {
    Text = "Libérez l’exaltation 108 fois dans les Échecs de Phase"
  },
  Task_131455_Desc = {
    Text = "Libérer l'exaltation 192 fois dans les Échecs de Phase"
  },
  Task_131456_Desc = {
    Text = "Libérez l'exaltation 60 fois dans les Échecs de Phase"
  },
  Task_131457_Desc = {
    Text = "Vaincre 111 éveillés dans les échecs de phase"
  },
  Task_131458_Desc = {
    Text = "Jouez 300 fois dans les Échecs de Phase"
  },
  Task_131459_Desc = {
    Text = "Jouez 480 cartes dans les Échecs de Phase"
  },
  Task_131460_Desc = {
    Text = "Jouez 320 fois en traphase"
  },
  Task_131461_Desc = {
    Text = "Vaincre 6 éveilleurs dans les Échecs de Phase"
  },
  Task_131462_Desc = {
    Text = "Vaincre 129 éveilleurs dans les échecs de phase"
  },
  Task_131463_Desc = {
    Text = "Libérer l'exaltation 102 fois dans les échecs de phase"
  },
  Task_131464_Desc = {
    Text = "Jouez 100 fois dans les échecs de phase"
  },
  Task_131465_Desc = {
    Text = "Libérer une exaltation 66 fois dans les échecs de phase"
  },
  Task_131466_Desc = {
    Text = "Vaincre 12 éveillés dans les Échecs de Phase"
  },
  Task_131467_Desc = {
    Text = "Obtenez un total de 45 victoires en échecs de phase"
  },
  Task_131468_Desc = {
    Text = "Lâcher l’exaltation 54 fois dans les Échecs de Phase"
  },
  Task_131469_Desc = {
    Text = "Libérez l’exaltation 240 fois dans les Échecs de Phase"
  },
  Task_131470_Desc = {
    Text = "Vaincre 99 éveilleurs dans les échecs de phase"
  },
  Task_131471_Desc = {
    Text = "Vaincre 87 Éveilleurs dans les Échecs de Phase"
  },
  Task_131472_Desc = {
    Text = "Dans le mode de sélection de roue, encore une partie et vaincre l'adversaire 1 fois"
  },
  Task_131473_Desc = {
    Text = "Vaincre 30 éveillés dans les Échecs de Phase"
  },
  Task_131474_Desc = {
    Text = "Dans le mode de pré-groupe, victoire consécutive 2 fois 1 fois"
  },
  Task_131475_Desc = {
    Text = "Dans le mode de sélection de roue, remporter 2 victoires"
  },
  Task_131476_Desc = {
    Text = "Libérer une exaltation 156 fois dans les Échecs de Phase"
  },
  Task_131477_Desc = {
    Text = "Dans le mode de sélection de roue, remporter 6 victoires"
  },
  Task_131478_Desc = {
    Text = "Jouez 160 cartes dans les Échecs de Phase"
  },
  Task_131479_Desc = {
    Text = "Vaincre 135 éveilleurs dans les Échecs de Phase"
  },
  Task_131480_Desc = {
    Text = "Jouez 880 cartes dans les Échecs de Phase"
  },
  Task_131481_Desc = {
    Text = "Lâcher l'exaltation 132 fois dans les Échecs de Phase"
  },
  Task_131482_Desc = {
    Text = "Libérer une exaltation 204 fois dans les Échecs de Phase"
  },
  Task_131483_Desc = {
    Text = "Dans le mode de pré-groupe, obtenez 4 victoires"
  },
  Task_131484_Desc = {
    Text = "Libérer l'exaltation de la fureur 144 fois dans les échecs de phase"
  },
  Task_131485_Desc = {
    Text = "Jouez 240 cartes en traphase"
  },
  Task_131486_Desc = {
    Text = "Jouez 940 cartes dans les Échecs de Phase"
  },
  Task_131487_Desc = {
    Text = "Libérer Exaltation 210 fois dans Échecs de Phase"
  },
  Task_131488_Desc = {
    Text = "Libérer l'exaltation de la folie 174 fois dans les Échecs de Phase"
  },
  Task_131489_Desc = {
    Text = "Vaincre 54 éveilleurs dans les Échecs de Phase"
  },
  Task_131490_Desc = {
    Text = "Vaincre 21 éveillés dans les Échecs de Phase"
  },
  Task_131491_Desc = {
    Text = "Jouez 180 cartes dans les échecs de phase"
  },
  Task_131492_Desc = {
    Text = "Épreuve d'Honneur"
  },
  Task_131493_Desc = {
    Text = "Jouez 400 fois dans les Échecs de Phase"
  },
  Task_131494_Desc = {
    Text = "Vaincre 57 éveillés dans les Échecs de Phase"
  },
  Task_131495_Desc = {
    Text = "Dans le mode de sélection de roue, remporter 8 victoires"
  },
  Task_131496_Desc = {
    Text = "Vaincre 81 éveillés dans les Échecs de Phase"
  },
  Task_131497_Desc = {
    Text = "Vaincre 93 éveilleurs dans les échecs de phase"
  },
  Task_131498_Desc = {
    Text = "Vaincre 120 Éveilleurs dans les Échecs de Phase"
  },
  Task_131499_Desc = {
    Text = "Libérer l'exaltation de la fureur 30 fois dans les Échecs de Phase"
  },
  Task_131500_Desc = {
    Text = "Jouez 220 cartes en traphase"
  },
  Task_131501_Desc = {
    Text = "Libérez l'exaltation 264 fois dans les Échecs de Phase"
  },
  Task_131502_Desc = {
    Text = "Vaincre 102 éveilleurs dans les échecs de phase"
  },
  Task_131503_Desc = {
    Text = "Jouez 140 fois dans les Échecs de Phase"
  },
  Task_131504_Desc = {
    Text = "Lâcher l'exaltation 96 fois dans les Échecs de Phase"
  },
  Task_131505_Desc = {
    Text = "Dans le mode de pré-groupe, encore une partie et battre l'adversaire 1 fois"
  },
  Task_131506_Desc = {
    Text = "Libérer une exaltation 78 fois dans les Échecs de Phase"
  },
  Task_131507_Desc = {
    Text = "Jouez 1000 fois dans les Échecs de Phase"
  },
  Task_131508_Desc = {
    Text = "Libérer l'exaltation 90 fois dans les Échecs de Phase"
  },
  Task_131509_Desc = {
    Text = "Vaincre 132 Éveilleurs dans les Échecs de Phase"
  },
  Task_131510_Desc = {
    Text = "Vaincre 126 éveillés dans les échecs de phase"
  },
  Task_131511_Desc = {
    Text = "Vaincre 9 éveillés dans les Échecs de Phase"
  },
  Task_131512_Desc = {
    Text = "Libérez l'exaltation de la fureur 168 fois dans les Échecs de Phase"
  },
  Task_131513_Desc = {
    Text = "Libérez l'exaltation 162 fois dans les Échecs de Phase"
  },
  Task_131514_Desc = {
    Text = "Libérer une exaltation 222 fois dans les Échecs de Phase"
  },
  Task_131515_Desc = {
    Text = "Épreuve de seuil"
  },
  Task_131516_Desc = {
    Text = "Jouez 380 fois en Échecs de Phase"
  },
  Task_131517_Desc = {
    Text = "Jouez 660 fois en traphase"
  },
  Task_131518_Desc = {
    Text = "Libérer l'exaltation 114 fois dans les Échecs de Phase"
  },
  Task_131519_Desc = {
    Text = "Libérez l'exaltation 120 fois dans les Échecs de Phase"
  },
  Task_131520_Desc = {
    Text = "Vaincre 144 éveillés dans les échecs de phase"
  },
  Task_131521_Desc = {
    Text = "Vaincre 24 éveillés en Échecs de Phase"
  },
  Task_131522_Desc = {
    Text = "Vaincre 42 éveillés dans les Échecs de Phase"
  },
  Task_131523_Desc = {
    Text = "Jouez 460 cartes en traphase"
  },
  Task_131524_Desc = {
    Text = "Libérer l'exaltation 180 fois dans les échecs de phase"
  },
  Task_131525_Desc = {
    Text = "Jouez 520 cartes dans les Échecs de Phase"
  },
  Task_131526_Desc = {
    Text = "Jouez 840 fois dans les Échecs de Phase"
  },
  Task_131527_Desc = {
    Text = "Vaincre 69 éveilleurs dans les Échecs de Phase"
  },
  Task_131528_Desc = {
    Text = "Jouez 720 cartes dans les Échecs de Phase"
  },
  Task_131529_Desc = {
    Text = "Vaincre 33 éveillés dans les Échecs de Phase"
  },
  Task_131530_Desc = {
    Text = "Vaincre 39 éveillés dans les Échecs de Phase"
  },
  Task_131531_Desc = {
    Text = "Jouez 860 fois dans les Échecs de Phase"
  },
  Task_131532_Desc = {
    Text = "Jouez 560 cartes dans les Échecs de Phase"
  },
  Task_131533_Desc = {
    Text = "Jouez 600 cartes dans les Échecs de Phase"
  },
  Task_131534_Desc = {
    Text = "Dans les Échecs de Phase, cliquez sur les avatars pour envoyer n'importe quelle expression à 3 adversaires"
  },
  Task_131535_Desc = {
    Text = "Vaincre 66 éveilleurs dans les Échecs de Phase"
  },
  Task_131536_Desc = {
    Text = "Jouez 200 fois dans les Échecs de Phase"
  },
  Task_131537_Desc = {
    Text = "Dans le mode de sélection de roue, remporter 1 victoire"
  },
  Task_131538_Desc = {
    Text = "Lâchez l'exaltation de la fureur 234 fois dans les Échecs de Phase"
  },
  Task_131539_Desc = {
    Text = "Jouez 820 cartes en Échecs de Phase"
  },
  Task_131540_Desc = {
    Text = "Libérer l'exaltation 18 fois dans les Échecs de Phase"
  },
  Task_131541_Desc = {
    Text = "Vaincre 63 éveillés dans les Échecs de Phase"
  },
  Task_131542_Desc = {
    Text = "Libérez l'exaltation 258 fois dans les échecs de phase"
  },
  Task_131543_Desc = {
    Text = "Aimez l'adversaire 1 fois après la fin du combat en traphase"
  },
  Task_131544_Desc = {
    Text = "Obtenez un total de 25 victoires en échecs de phase"
  },
  Task_131545_Desc = {
    Text = "Vaincre 27 éveilleurs dans les Échecs de Phase"
  },
  Task_131546_Desc = {
    Text = "Vaincre 18 éveilleurs dans les Échecs de Phase"
  },
  Task_131547_Desc = {
    Text = "Vaincre 150 Éveilleurs dans les échecs de phase"
  },
  Task_131548_Desc = {
    Text = "Libérer l'exaltation 48 fois dans les échecs de phase"
  },
  Task_131549_Desc = {
    Text = "Jouez 20 cartes dans les Échecs de Phase"
  },
  Task_131550_Desc = {
    Text = "Libérez l'exaltation 36 fois dans les Échecs de Phase"
  },
  Task_131551_Desc = {
    Text = "Vaincre 15 éveilleurs dans les Échecs de Phase"
  },
  Task_131552_Desc = {
    Text = "Vaincre 84 éveilleurs dans les Échecs de Phase"
  },
  Task_131553_Desc = {
    Text = "Jouez 280 cartes en traphase"
  },
  Task_131554_Desc = {
    Text = "Libérez l'exaltation 72 fois dans les Échecs de Phase"
  },
  Task_131555_Desc = {
    Text = "Vaincre 108 éveilleurs dans les échecs de phase"
  },
  Task_131556_Desc = {
    Text = "Lâcher l’exaltation 246 fois dans les Échecs de Phase"
  },
  Task_131557_Desc = {
    Text = "Jouez 700 cartes en Échecs de Phase"
  },
  Task_131558_Desc = {
    Text = "Obtenez un total de 35 victoires en échecs de phase"
  },
  Task_131559_Desc = {
    Text = "Obtenez 50 victoires cumulées en échecs de phase"
  },
  Task_131560_Desc = {
    Text = "Vaincre 3 éveilleurs dans les Échecs de Phase"
  },
  Task_131561_Desc = {
    Text = "Vainquez 75 Éveilleurs dans les Échecs de Phase"
  },
  Task_131562_Desc = {
    Text = "Vaincre 51 éveillés dans les Échecs de Phase"
  },
  Task_131563_Desc = {
    Text = "Jouez 120 cartes dans les échecs de phase"
  },
  Task_131564_Desc = {
    Text = "Vaincre 78 éveilleurs dans les Échecs de Phase"
  },
  Task_131565_Desc = {
    Text = "Vaincre 138 Éveilleurs dans les Échecs de Phase"
  },
  Task_131566_Desc = {
    Text = "Vaincre 90 éveilleurs dans les échecs de phase"
  },
  Task_131567_Desc = {
    Text = "Épreuve des secrets"
  },
  Task_131568_Desc = {
    Text = "Dans le mode de pré-groupe, 6 victoires ont été obtenues"
  },
  Task_131569_Desc = {
    Text = "Dans le mode de pré-groupe, obtenir 8 victoires"
  },
  Task_131570_Desc = {
    Text = "Vaincre 117 éveilleurs dans les échecs de phase"
  },
  Task_131571_Desc = {
    Text = "Obtenez 40 victoires cumulées dans les échecs de phase"
  },
  Task_131572_Desc = {
    Text = "Libérez l'exaltation 126 fois dans les Échecs de Phase"
  },
  Task_131573_Desc = {
    Text = "Jouez 760 fois dans les Échecs de Phase"
  },
  Task_131574_Desc = {
    Text = "Libérer l’exaltation 270 fois dans les Échecs de Phase"
  },
  Task_131575_Desc = {
    Text = "Dans le mode de pré-groupe, obtenir 1 victoire"
  },
  Task_131576_Desc = {
    Text = "Libérer l'exaltation 84 fois dans les Échecs de Phase"
  },
  Task_131577_Desc = {
    Text = "Lâchez l'exaltation 294 fois dans les Échecs de Phase"
  },
  Task_131578_Desc = {
    Text = "Obtenez un total de 30 victoires en Échecs de Phase"
  },
  Task_131579_Desc = {
    Text = "Jouez 960 cartes en Échecs de Phase"
  },
  Task_131580_Desc = {
    Text = "Jouez 260 cartes dans les Échecs de Phase"
  },
  Task_131581_Desc = {
    Text = "Lâcher l'exaltation 42 fois dans les Échecs de Phase"
  },
  Task_131582_Desc = {
    Text = "Vaincre 96 éveillés dans les échecs de phase"
  },
  Task_131583_Desc = {
    Text = "Libérez l’exaltation 228 fois dans les Échecs de Phase"
  },
  Task_131584_Desc = {
    Text = "Jouez 40 cartes en échecs de phase"
  },
  Task_131585_Desc = {
    Text = "Jouez 800 fois dans les Échecs de Phase"
  },
  Task_131586_Desc = {
    Text = "Jouez 580 fois dans les Échecs de Phase"
  },
  Task_131587_Desc = {
    Text = "Libérez l'exaltation 150 fois dans les échecs de phase"
  },
  Task_131588_Desc = {
    Text = "Vaincre 114 éveilleurs dans les échecs de phase"
  },
  Task_131589_Desc = {
    Text = "Jouez 780 cartes dans les Échecs de Phase"
  },
  Task_131590_Desc = {
    Text = "Libérer l'exaltation 24 fois dans les Échecs de Phase"
  },
  Task_131591_Desc = {
    Text = "Libérez l'exaltation 216 fois dans les Échecs de Phase"
  },
  Task_131592_Desc = {
    Text = "Lâcher l’exaltation 276 fois dans les Échecs de Phase"
  },
  Task_131593_Desc = {
    Text = "Jouez 500 fois dans les Échecs de Phase"
  },
  Task_131594_Desc = {
    Text = "Vaincre 147 éveillés dans les échecs de phase"
  },
  Task_131595_Desc = {
    Text = "Dans le mode de pré-groupe, 2 victoires ont été obtenues"
  },
  Task_131596_Desc = {
    Text = "Vaincre 72 éveillés dans les Échecs de Phase"
  },
  Task_131597_Desc = {
    Text = "Jouez 640 cartes en échecs de phase"
  },
  Task_131598_Desc = {
    Text = "Vaincre 105 éveillés dans les échecs de phase"
  },
  Task_131599_Desc = {
    Text = "Libérez l'exaltation 300 fois dans les Échecs de Phase"
  },
  Task_131600_Desc = {
    Text = "Vaincre 48 éveillés dans les Échecs de Phase"
  },
  Task_131601_Desc = {
    Text = "Jouez 920 fois dans les Échecs de Phase"
  },
  Task_131602_Desc = {
    Text = "Jouez 60 cartes dans les Échecs de Phase"
  },
  Task_131603_Desc = {
    Text = "Jouez 360 cartes en Échecs de Phase"
  },
  Task_131604_Desc = {
    Text = "Libérez l'exaltation 282 fois dans les Échecs de Phase"
  },
  Task_131605_Desc = {
    Text = "Jouez 440 fois dans les Échecs de Phase"
  },
  Task_131606_Desc = {
    Text = "Vaincre 123 éveilleurs dans les échecs de phase"
  },
  Task_131607_Desc = {
    Text = "Libérer l'exaltation 198 fois dans les Échecs de Phase"
  },
  Task_131608_Desc = {
    Text = "Jouez 680 cartes dans les Échecs de Phase"
  },
  Task_131609_Desc = {
    Text = "Vaincre 45 éveilleurs dans les Échecs de Phase"
  },
  Task_131610_Desc = {
    Text = "Dans le mode de sélection de roue, remporter 2 victoires consécutives"
  },
  Task_131611_Desc = {
    Text = "Libérer l'exaltation 186 fois dans les échecs de phase"
  },
  Task_131612_Desc = {
    Text = "Libérer l'exaltation 6 fois dans les Échecs de Phase"
  },
  Task_131613_Desc = {
    Text = "Jouez 620 cartes dans les Échecs de Phase"
  },
  Task_131614_Desc = {
    Text = "Dans le mode de sélection de roue, remporter 2 victoires consécutives 1 fois"
  },
  Task_131615_Desc = {
    Text = "Jouez 900 fois dans les Échecs de Phase"
  },
  Task_131616_Desc = {
    Text = "Libérez l’exaltation 252 fois dans les Échecs de Phase"
  },
  Task_131617_Desc = {
    Text = "Jouez 980 cartes dans les Échecs de Phase"
  },
  Task_131618_Desc = {
    Text = "Vaincre 141 éveilleurs dans les Échecs de Phase"
  },
  Task_131619_Desc = {
    Text = "Libérez l'exaltation 288 fois dans les Échecs de Phase"
  },
  Task_131620_Desc = {
    Text = "Jouez 420 fois dans les Échecs de Phase"
  },
  Task_131621_Desc = {
    Text = "Dans le mode de sélection de roue, obtenir 10 victoires"
  },
  Task_131622_Desc = {
    Text = "Jouez 340 cartes en traphase"
  },
  Task_131623_Desc = {
    Text = "Dans le mode de sélection de roue, remporter 4 victoires"
  },
  Task_131624_Desc = {
    Text = "Jouez 80 cartes dans les échecs de phase"
  },
  Task_131625_Desc = {
    Text = "Dans le mode de pré-groupe, 2 victoires consécutives"
  },
  Task_131626_Desc = {
    Text = "Jouez 540 fois dans les Échecs de Phase"
  },
  Task_131627_Desc = {
    Text = "Libérez une exaltation 138 fois dans les Échecs de Phase"
  },
  Task_131628_Desc = {
    Text = "Libérer l'exaltation 12 fois dans les Échecs de Phase"
  },
  Task_131768_Desc = {
    Text = "Compléter la Plongée dans l'inconscient «Addiction»"
  },
  Task_131768_Name = {Text = "Cui !"},
  Task_131801_Name = {
    Text = "Fin de l'activité de reproduction du tour inverse"
  },
  Task_131891_Desc = {
    Text = "Mémoire éternelle : Exclusivité limitée"
  },
  Task_131892_Desc = {
    Text = "Mémoire éternelle V"
  },
  Task_131893_Desc = {
    Text = "Mémoire éternelle VII"
  },
  Task_131894_Desc = {
    Text = "Mémoire éternelle II"
  },
  Task_131895_Desc = {
    Text = "Mémoire éternelle I"
  },
  Task_131896_Desc = {
    Text = "Mémoire éternelle : Gratuit"
  },
  Task_131897_Desc = {
    Text = "Mémoire éternelle III"
  },
  Task_131898_Desc = {
    Text = "Mémoire éternelle IV"
  },
  Task_131899_Desc = {
    Text = "Mémoire éternelle VI"
  },
  Task_132335_Desc = {
    Text = "Terminer Plongée dans l'inconscient «Jour du couronnement»"
  },
  Task_132454_Desc = {
    Text = "Obtenez 10 victoires cette saiso"
  },
  Task_132454_Name = {
    Text = "10 Victoires"
  },
  Task_132455_Desc = {
    Text = "Obtenez un total de 3 victoires cette saiso"
  },
  Task_132455_Name = {
    Text = "3 Victoires"
  },
  Task_132456_Desc = {
    Text = "Obtenez un total de 6 victoires cette saiso"
  },
  Task_132456_Name = {
    Text = "6 victoires"
  },
  Task_132457_Desc = {
    Text = "Obtenez 1 victoire cette saiso"
  },
  Task_132457_Name = {Text = "1 Victoire"},
  Task_132689_Desc = {
    Text = "Connexion sur un appareil PC"
  },
  Task_132690_Desc = {
    Text = "Extraire de l'Élixir de Cœur d'argent une fois via Mobile"
  },
  Task_132691_Desc = {
    Text = "Extraire de l'Élixir de Cœur d'argent une fois via PC"
  },
  Task_132692_Desc = {
    Text = "Connexion sur un appareil mobile"
  },
  Task_132874_Desc = {
    Text = "Vaincre un Chef de Phase 3"
  },
  Task_132875_Desc = {
    Text = "Gagner 5 fois"
  },
  Task_132876_Desc = {
    Text = "Gagner 5 fois"
  },
  Task_132877_Desc = {
    Text = "Terminer la Plongée-P 3 fois"
  },
  Task_132909_Desc = {
    Text = "Terminer 1 fois le niveau Arachne"
  },
  Task_132910_Desc = {
    Text = "Terminer 15 Envois"
  },
  Task_132911_Desc = {
    Text = "Terminer n'importe quelle quête de saison"
  },
  Task_132912_Desc = {
    Text = "Jouer un total de 300 cartes"
  },
  Task_132913_Desc = {
    Text = "Terminer n'importe quelle quête de saison"
  },
  Task_132914_Desc = {
    Text = "Réveiller 30 fois"
  },
  Task_132915_Desc = {
    Text = "D-effet régional Spécial Training atteint 100"
  },
  Task_132916_Desc = {
    Text = "Terminer 1 fois le niveau Arachne"
  },
  Task_132917_Desc = {
    Text = "Terminer 15 Envois"
  },
  Task_132918_Desc = {
    Text = "Connexion totale de 1 jour"
  },
  Task_132919_Desc = {
    Text = "D-effet régional Spécial Training atteint 100"
  },
  Task_132920_Desc = {
    Text = "L'activité Hebdomadaire atteint 1 000"
  },
  Task_132921_Desc = {
    Text = "L'activité Hebdomadaire atteint 1 000"
  },
  Task_132922_Desc = {
    Text = "Jouer un total de 300 cartes"
  },
  Task_132923_Desc = {
    Text = "Connexion totale de 1 jour"
  },
  Task_132924_Desc = {
    Text = "Réveiller 30 fois"
  },
  Task_132928_Desc = {
    Text = "Terminez toutes les tâches ci-dessus"
  },
  Task_132929_Desc = {
    Text = "Consommer Ménophine 1800 points"
  },
  Task_132930_Desc = {
    Text = "Compléter toutes les quêtes hebdomadaires en 1 semaine"
  },
  Task_132931_Desc = {
    Text = "Connexion cumulée 1 jour"
  },
  Task_132932_Desc = {
    Text = "Complétez 20 Missions"
  },
  Task_132933_Desc = {
    Text = "Les Points d'entraînement de la Zone Interdite de Catastrophe de Fusion atteignent 100"
  },
  Task_133297_Desc = {
    Text = "Terminer le Monde des Rêves Étranges «Conquête de la cuisine»"
  },
  Task_133297_Name = {
    Text = "Réjouissez-vous ! Enragez ! Pleurez !"
  },
  Task_133302_Desc = {
    Text = "Les ions actifs raffinés atteignent 1 000"
  },
  Task_133303_Desc = {
    Text = "Utilisez le soutien 3 fois"
  },
  Task_133304_Desc = {
    Text = "Les ions actifs raffinés atteignent 1 000"
  },
  Task_133305_Desc = {
    Text = "Jouer un total de 300 cartes"
  },
  Task_133306_Desc = {
    Text = "D-effet régional Spécial Training atteint 100"
  },
  Task_133307_Desc = {
    Text = "D-effet régional Spécial Training atteint 100"
  },
  Task_133308_Desc = {
    Text = "Jouer un total de 300 cartes"
  },
  Task_133309_Desc = {
    Text = "Réveiller 30 fois"
  },
  Task_133310_Desc = {
    Text = "Connexion totale de 1 jour"
  },
  Task_133311_Desc = {
    Text = "Terminer n'importe quelle mission saisonnière"
  },
  Task_133312_Desc = {
    Text = "Réveiller 30 fois"
  },
  Task_133313_Desc = {
    Text = "Terminer 15 Envois"
  },
  Task_133314_Desc = {
    Text = "Terminer n'importe quelle mission saisonnière"
  },
  Task_133315_Desc = {
    Text = "Utilisez le soutien 3 fois"
  },
  Task_133316_Desc = {
    Text = "Connexion totale de 1 jour"
  },
  Task_133317_Desc = {
    Text = "Terminer 15 Envois"
  },
  Task_133940_Desc = {
    Text = "Apprécier un ancien élève une fois"
  },
  Task_133940_Name = {Text = "Like d'ami"},
  Task_133941_Desc = {
    Text = "Épuisez 180 Menophin"
  },
  Task_133941_Name = {
    Text = "Consomme de l'énergie"
  },
  Task_133943_Desc = {
    Text = "Jouer 50 cartes"
  },
  Task_133943_Name = {
    Text = "Entraînement quotidien"
  },
  Task_133944_Desc = {
    Text = "Exécutez 3 missions"
  },
  Task_133944_Name = {
    Text = "Effectuer une mission"
  },
  Task_133945_Desc = {
    Text = "Terminer 50 Transcriptions du pacte secret"
  },
  Task_133945_Name = {
    Text = "Transcription du pacte secret"
  },
  Task_133946_Desc = {
    Text = "Compléter l'Existence Transcendante une fois"
  },
  Task_133946_Name = {
    Text = "Boss Hebdomadaire"
  },
  Task_133947_Desc = {
    Text = "Effectuer 20 cérémonies d'Éveil"
  },
  Task_133947_Name = {
    Text = "<Tirer des cartes>"
  },
  Task_133948_Desc = {
    Text = "Consommer 1 500 Ménophine"
  },
  Task_133948_Name = {
    Text = "Consomme de l'énergie"
  },
  Task_133949_Desc = {
    Text = "Consommer 1 000 000 Billets Rose Dorée"
  },
  Task_133949_Name = {
    Text = "Spendthrift"
  },
  Task_134074_Desc = {
    Text = "Compléter l'événement d'investigation \"@1@2\""
  },
  Task_134074_Desc2 = {
    Text = "Compléter l'événement d'enquête «Théâtre du Destin»"
  },
  Task_134074_Name = {Text = "@2@3"},
  Task_134074_Name2 = {
    Text = "Le protagoniste du destin"
  },
  Task_134075_Desc = {
    Text = "Compléter l'événement d'enquête «Théâtre du Destin» en difficulté difficile"
  },
  Task_134075_Name = {
    Text = "Le protagoniste du destin · Difficile"
  },
  Task_134095_Desc = {
    Text = "Résonner 3 fois dans l'enquête sur l'événement «@1@2»"
  },
  Task_134095_Desc2 = {
    Text = "Résonance 3 fois dans l'événement d'enquête «Théâtre du Destin»"
  },
  Task_134095_Name = {Text = "@2@3"},
  Task_134095_Name2 = {
    Text = "Écho de soumission"
  },
  Task_134096_Desc = {
    Text = "Résonner 10 fois dans l'enquête sur l'événement «@1@2»"
  },
  Task_134096_Desc2 = {
    Text = "Résonance 10 fois dans l'événement d'enquête «Théâtre du Destin»"
  },
  Task_134096_Name = {Text = "@2@3"},
  Task_134096_Name2 = {
    Text = "Écho de soumission IV"
  },
  Task_134097_Desc = {
    Text = "Résonner 9 fois dans l'enquête sur l'événement «@1@2»"
  },
  Task_134097_Desc2 = {
    Text = "Résonance 9 fois dans l'événement d'enquête «Théâtre du Destin»"
  },
  Task_134097_Name = {Text = "@2@3"},
  Task_134097_Name2 = {
    Text = "Écho de soumission III"
  },
  Task_134098_Desc = {
    Text = "Résonner 6 fois dans l'enquête sur l'événement «@1@2»"
  },
  Task_134098_Desc2 = {
    Text = "Résonance 6 fois dans l'événement d'enquête «Théâtre du Destin»"
  },
  Task_134098_Name = {Text = "@2@3"},
  Task_134098_Name2 = {
    Text = "Écho de soumission II"
  },
  Task_134099_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_134099_Name = {
    Text = "Passer Parfait"
  },
  Task_134121_Desc = {
    Text = "Caraboo atteint Personnalité approfondie 12"
  },
  Task_134122_Desc = {
    Text = "Caecus atteint Personnalité approfondie 12"
  },
  Task_134123_Desc = {
    Text = "Faros atteint Personnalité approfondie 12"
  },
  Task_134124_Desc = {
    Text = "Mouchette atteint Personnalité approfondie 12"
  },
  Task_134125_Desc = {
    Text = "Saya atteint Personnalité approfondie 12"
  },
  Task_134126_Desc = {
    Text = "Sartogoa atteint Personnalité approfondie 12"
  },
  Task_134127_Desc = {
    Text = "Thais atteint Personnalité approfondie 12"
  },
  Task_134128_Desc = {
    Text = "Le Maître Endormi d'Origine atteint Personnalité approfondie 12"
  },
  Task_134129_Desc = {
    Text = "Helot atteint Personnalité approfondie 12"
  },
  Task_134130_Desc = {
    Text = "Tawil atteint Personnalité approfondie 12"
  },
  Task_134131_Desc = {
    Text = "Pollux atteint Personnalité approfondie 12"
  },
  Task_134132_Desc = {
    Text = "24 atteint Personnalité approfondie 12"
  },
  Task_134134_Desc = {
    Text = "Uvhash atteint Personnalité approfondie 12"
  },
  Task_134135_Desc = {
    Text = "Murphy : Égarée atteint Personnalité approfondie 12"
  },
  Task_134136_Desc = {
    Text = "Doll : Dissoute atteint Personnalité approfondie 12"
  },
  Task_134137_Desc = {
    Text = "Pickman atteint Personnalité approfondie 12"
  },
  Task_134138_Desc = {
    Text = "Pandia atteint Personnalité approfondie 12"
  },
  Task_134140_Desc = {
    Text = "Horla atteint Personnalité approfondie 12"
  },
  Task_134141_Desc = {
    Text = "Xu atteint Personnalité approfondie 12"
  },
  Task_134142_Desc = {
    Text = "Tinct atteint Personnalité approfondie 12"
  },
  Task_134143_Desc = {
    Text = "Kadigula atteint Personnalité approfondie 12"
  },
  Task_134144_Desc = {
    Text = "Leigh atteint Personnalité approfondie 12"
  },
  Task_134145_Desc = {
    Text = "Murphy atteint Personnalité approfondie 12"
  },
  Task_134146_Desc = {
    Text = "Doresain atteint Personnalité approfondie 12"
  },
  Task_134148_Desc = {
    Text = "Corposant atteint Personnalité approfondie 12"
  },
  Task_134149_Desc = {
    Text = "Lily atteint Personnalité approfondie 12"
  },
  Task_134150_Desc = {
    Text = "Helot : Enchaînée atteint Personnalité approfondie 12"
  },
  Task_134151_Desc = {
    Text = "Winkle atteint Personnalité approfondie 12"
  },
  Task_134152_Desc = {
    Text = "Hamelin atteint Personnalité approfondie 12"
  },
  Task_134153_Desc = {
    Text = "Ryker atteint Personnalité approfondie 12"
  },
  Task_134154_Desc = {
    Text = "Sanga atteint Personnalité approfondie 12"
  },
  Task_134155_Desc = {
    Text = "Casiah atteint Personnalité approfondie 12"
  },
  Task_134156_Desc = {
    Text = "Castor atteint Personnalité approfondie 12"
  },
  Task_134157_Desc = {
    Text = "Mosk atteint Personnalité approfondie 12"
  },
  Task_134158_Desc = {
    Text = "Faint atteint Personnalité approfondie 12"
  },
  Task_134159_Desc = {
    Text = "Nautila atteint Personnalité approfondie 12"
  },
  Task_134160_Desc = {
    Text = "Agrippa atteint Personnalité approfondie 12"
  },
  Task_134161_Desc = {
    Text = "Jenkin atteint Personnalité approfondie 12"
  },
  Task_134162_Desc = {
    Text = "Salvador atteint Personnalité approfondie 12"
  },
  Task_134163_Desc = {
    Text = "Arachne atteint la personnalité approfondie 12"
  },
  Task_134164_Desc = {
    Text = "Daffodil atteint Personnalité approfondie 12"
  },
  Task_134165_Desc = {
    Text = "Celeste atteint Personnalité approfondie 12"
  },
  Task_134166_Desc = {
    Text = "Sorel atteint Personnalité approfondie 12"
  },
  Task_134167_Desc = {
    Text = "Goliath atteint Personnalité approfondie 12"
  },
  Task_134168_Desc = {
    Text = "Tulu atteint Personnalité approfondie 12"
  },
  Task_134169_Desc = {
    Text = "Clementine atteint Personnalité approfondie 12"
  },
  Task_134170_Desc = {
    Text = "Karen atteint Personnalité approfondie 12"
  },
  Task_134171_Desc = {
    Text = "Nymphaea atteint Personnalité approfondie 12"
  },
  Task_134172_Desc = {
    Text = "Wanda atteint Personnalité approfondie 12"
  },
  Task_134173_Desc = {
    Text = "Liz atteint Personnalité approfondie 12"
  },
  Task_134174_Desc = {
    Text = "Alva atteint Personnalité approfondie 12"
  },
  Task_134175_Desc = {
    Text = "Miryam atteint Personnalité approfondie 12"
  },
  Task_134394_Desc = {
    Text = "Connexion cumulative pendant 6 jours"
  },
  Task_134395_Desc = {
    Text = "Connectez-vous pendant un total de 10 jours"
  },
  Task_134396_Desc = {
    Text = "Connecté pendant un total de 16 jours"
  },
  Task_134397_Desc = {
    Text = "Connectez-vous pendant un total de 7 jours"
  },
  Task_134398_Desc = {
    Text = "Connectez-vous pendant un total de 15 jours"
  },
  Task_134399_Desc = {
    Text = "Connecté pendant un total de 9 jours"
  },
  Task_134400_Desc = {
    Text = "Connectez-vous pendant un total de 4 jours"
  },
  Task_134401_Desc = {
    Text = "Connexion cumulative de 14 jours"
  },
  Task_134402_Desc = {
    Text = "Connecte-toi pendant 5 jours cumulés"
  },
  Task_134403_Desc = {
    Text = "Connexion Cumulative : 11 Jours"
  },
  Task_134404_Desc = {
    Text = "Connexion Cumulative : 13 Jours"
  },
  Task_134405_Desc = {
    Text = "Connexion cumulative pendant 1 jour"
  },
  Task_134406_Desc = {
    Text = "Connectez-vous pendant un total de 2 jours"
  },
  Task_134407_Desc = {
    Text = "Connecte-toi pendant 3 jours cumulés"
  },
  Task_134408_Desc = {
    Text = "Connectez-vous pendant un total de 8 jours"
  },
  Task_134409_Desc = {
    Text = "Connexion Cumulative : 12 Jours"
  },
  Task_135038_Desc = {
    Text = "Connectez-vous au jeu"
  },
  Task_135038_Name = {
    Text = "Connectez-vous au jeu"
  },
  Task_137649_Desc = {
    Text = "Jouer 150 cartes cette saison"
  },
  Task_137650_Desc = {
    Text = "Jouer 150 cartes cette saison"
  },
  Task_138583_Desc = {
    Text = "Réveiller 30 fois"
  },
  Task_138584_Desc = {
    Text = "Terminer n'importe quelle mission saisonnière"
  },
  Task_138585_Desc = {
    Text = "Jouer un total de 300 cartes"
  },
  Task_138586_Desc = {
    Text = "Utilisez le soutien 3 fois"
  },
  Task_138587_Desc = {
    Text = "D-effet régional Spécial Training atteint 100"
  },
  Task_138588_Desc = {
    Text = "Connexion totale de 1 jour"
  },
  Task_138589_Desc = {
    Text = "Réveiller 30 fois"
  },
  Task_138590_Desc = {
    Text = "Terminer 15 Envois"
  },
  Task_138591_Desc = {
    Text = "Jouer un total de 300 cartes"
  },
  Task_138592_Desc = {
    Text = "Utilisez le soutien 3 fois"
  },
  Task_138593_Desc = {
    Text = "Les ions actifs raffinés atteignent 1 000"
  },
  Task_138594_Desc = {
    Text = "Les ions actifs raffinés atteignent 1 000"
  },
  Task_138595_Desc = {
    Text = "Connexion totale de 1 jour"
  },
  Task_138596_Desc = {
    Text = "Terminer n'importe quelle mission saisonnière"
  },
  Task_138597_Desc = {
    Text = "Terminer 15 Envois"
  },
  Task_138598_Desc = {
    Text = "D-effet régional Spécial Training atteint 100"
  },
  Task_138762_Desc = {
    Text = "Après avoir subi « l'Élégie dominant le destin », vaincre Néphréa « la Toile de la trahison »."
  },
  Task_138762_Name = {
    Text = "Protagoniste du destin · Caché"
  },
  Task_139118_Desc = {
    Text = "Terminer « Connexion multidimensionnelle – Graine d'Amour Oubliée »"
  },
  Task_139119_Desc = {
    Text = "Terminez toutes les tâches ci-dessus"
  },
  Task_139121_Desc = {
    Text = "Réveiller 1000 fois"
  },
  Task_139123_Desc = {
    Text = "Réveiller 250 fois"
  },
  Task_139124_Desc = {
    Text = "Se connecter pendant 1 jour"
  },
  Task_139125_Desc = {
    Text = "Terminer « Opération d'investigation – Oubli – Chapitre 4 » Mode Normal"
  },
  Task_139126_Desc = {
    Text = "Réveiller 500 fois"
  },
  Task_139127_Desc = {
    Text = "Réveiller 100 fois"
  },
  Task_139600_Desc = {
    Text = "Capturer 1000000 fois au total"
  },
  Task_139614_Desc = {
    Text = "Capturer 500000 fois au total"
  },
  Task_139618_Desc = {
    Text = "Capturer 50 fois au total"
  },
  Task_139619_Desc = {
    Text = "Capturer 1000000 fois au total"
  },
  Task_139626_Desc = {
    Text = "Capturer 300000 fois au total"
  },
  Task_139629_Desc = {
    Text = "Capturer 700000 fois au total"
  },
  Task_139646_Desc = {
    Text = "Journal de capture du campus"
  },
  Task_139649_Desc = {
    Text = "Capturer 100000 fois au total"
  },
  Task_139651_Desc = {
    Text = "Journal de capture personnel"
  },
  Task_139652_Desc = {
    Text = "Capturer 100 fois au total"
  },
  Task_140087_Desc = {
    Text = "Terminer « Le plus gros chat » 1 fois"
  },
  Task_140088_Desc = {
    Text = "Terminer « Ruée vers l'or noir » 1 fois"
  },
  Task_140089_Desc = {
    Text = "Terminer « Résistance à l'arrestation » 10 fois"
  },
  Task_140090_Desc = {
    Text = "Terminer « Ramenez-les tous ! » 5 fois"
  },
  Task_140091_Desc = {
    Text = "Terminer « Revenir avec un chargement complet » 5 fois"
  },
  Task_140092_Desc = {
    Text = "Terminer « Résistance à l'arrestation » 1 fois"
  },
  Task_140093_Desc = {
    Text = "Terminer « Le plus gros chat » 10 fois"
  },
  Task_140094_Desc = {
    Text = "Terminer « Premier seau d'argent » 5 fois"
  },
  Task_140095_Desc = {
    Text = "Terminer « Ruée vers l'or noir » 5 fois"
  },
  Task_140096_Desc = {
    Text = "Terminer « Premier seau d'argent » 1 fois"
  },
  Task_140097_Desc = {
    Text = "Terminer « Revenir avec un chargement complet » 10 fois"
  },
  Task_140098_Desc = {
    Text = "Terminer « Résistance à l'arrestation » 5 fois"
  },
  Task_140099_Desc = {
    Text = "Terminer « Le plus gros chat » 5 fois"
  },
  Task_140100_Desc = {
    Text = "Terminer « Revenir avec un chargement complet » 1 fois"
  },
  Task_140101_Desc = {
    Text = "Terminer « Ramenez-les tous ! » 10 fois"
  },
  Task_140102_Desc = {
    Text = "Terminer « fais-le encore » 1 fois"
  },
  Task_140103_Desc = {
    Text = "Terminer « fais-le encore » 10 fois"
  },
  Task_140104_Desc = {
    Text = "Terminer « Premier seau d'argent » 10 fois"
  },
  Task_140105_Desc = {
    Text = "Terminer « Ramenez-les tous ! » 1 fois"
  },
  Task_140106_Desc = {
    Text = "Terminer « Ruée vers l'or noir » 10 fois"
  },
  Task_140107_Desc = {
    Text = "Terminer « fais-le encore » 5 fois"
  },
  Task_140114_Desc = {
    Text = "Terminer « Connexion multidimensionnelle – Graine d'Amour Oubliée »"
  },
  Task_140115_Desc = {
    Text = "Terminez toutes les tâches ci-dessus"
  },
  Task_140116_Desc = {
    Text = "Se connecter pendant 1 jour"
  },
  Task_140117_Desc = {
    Text = "Terminer « Opération d'investigation – Oubli – Chapitre 4 » Mode Normal"
  },
  Task_140189_Desc = {
    Text = "Extraction cumulée de 5000 liquide primordial"
  },
  Task_140190_Desc = {
    Text = "Extraction cumulée de 20 000 argent primordial"
  },
  Task_140191_Desc = {
    Text = ": Accumuler 10000 Argent Prime"
  },
  Task_140192_Desc = {
    Text = ": Accumuler 30000 Argent Prime"
  },
  Task_140306_Desc = {
    Text = "Terminer la Connexion multidimensionnelle «Graine d'Amour Oubliée» en difficulté Difficile"
  },
  Task_140306_Name = {
    Text = "Le refuge du vagabond · Difficile"
  },
  Task_140307_Desc = {
    Text = "Terminer la Connexion multidimensionnelle «Graine d'Amour Oubliée»"
  },
  Task_140307_Name = {
    Text = "Le refuge du vagabond"
  },
  Task_140463_Desc = {
    Text = "Jouer un total de 200 cartes"
  },
  Task_140464_Desc = {
    Text = "Complétez 20 Missions"
  },
  Task_140465_Desc = {
    Text = "Connexion cumulée 1 jour"
  },
  Task_140466_Desc = {
    Text = "Les ions actifs raffinés atteignent 1 000"
  },
  Task_140467_Desc = {
    Text = "Terminez toutes les tâches ci-dessus"
  },
  Task_140468_Desc = {
    Text = "Terminer n'importe quelle mission saisonnière"
  },
  Task_141311_Desc = {
    Text = "Terminer la Plongée dans l'inconscient «Ebwynnos Evermore»"
  },
  Task_141312_Desc = {
    Text = "Atteindre le niveau 10 de Taux de synchronisation avec Pontos"
  },
  Task_141313_Desc = {
    Text = "Remporter 1 victoire dans «La Chasse de la Haute Maison» avec un Réveilleur du Domaine hyperdimensionnel"
  },
  Task_141314_Desc = {
    Text = "Terminer «Forêt Sombre» en difficulté Folie"
  },
  Task_141315_Desc = {
    Text = "Terminer «Hydromel et Myrrhe» en n'importe quelle difficulté"
  },
  Task_141316_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_141317_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_141318_Desc = {
    Text = "Terminer «Soliloque» en n'importe quelle difficulté"
  },
  Task_141319_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_141320_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_141321_Desc = {
    Text = "Remporter 2 victoires dans «La Chasse de la Haute Maison» avec un Éveilleur du royaume de la caro"
  },
  Task_141322_Desc = {
    Text = "Remporter 2 victoires dans «La Chasse de la Haute Maison» avec un Éveilleur du royaume du chaos"
  },
  Task_141323_Desc = {
    Text = "Remporter 1 victoire dans «La Chasse de la Haute Maison» avec un Éveilleur du royaume des profondeurs"
  },
  Task_141324_Desc = {
    Text = "La Chasse de la Haute Maison·Royaume"
  },
  Task_141325_Desc = {
    Text = "Terminer «Le Sifflet» en difficulté Folie"
  },
  Task_141326_Desc = {
    Text = "Terminer «Jeu du Prédateur» en n'importe quelle difficulté"
  },
  Task_141327_Desc = {
    Text = "Terminer «Hydromel et Myrrhe» en n'importe quelle difficulté"
  },
  Task_141328_Desc = {
    Text = "Terminer «Forêt Sombre» en n'importe quelle difficulté"
  },
  Task_141329_Desc = {
    Text = "La Chasse de la Haute Maison·Folie"
  },
  Task_141330_Desc = {
    Text = "Terminer «Dualisme» en difficulté Folie"
  },
  Task_141331_Desc = {
    Text = "Terminer «Forêt Sombre» en n'importe quelle difficulté"
  },
  Task_141332_Desc = {
    Text = "Terminer «Hydromel et Myrrhe» en difficulté Folie"
  },
  Task_141333_Desc = {
    Text = "Terminer «Soliloque» en difficulté Folie"
  },
  Task_141335_Desc = {
    Text = "Terminer «Côtes et Cartilage» en n'importe quelle difficulté"
  },
  Task_141336_Desc = {
    Text = "Terminer «Dualisme» en n'importe quelle difficulté"
  },
  Task_141337_Desc = {
    Text = "Compléter tous les Succès : «La Chasse de la Haute Maison·Terminer»"
  },
  Task_141338_Desc = {
    Text = "Dégagement 6 à l'obtention de Pontos"
  },
  Task_141338_Name = {
    Text = "Dégagement 6 à l'obtention de Pontos"
  },
  Task_141338_UnlockCondDesc = {
    Text = "Événement@Événement pack de Dégagement 2 de l'Éveilleur Pontos"
  },
  Task_141339_Desc = {
    Text = "Terminer «Côtes et Cartilage» en n'importe quelle difficulté"
  },
  Task_141340_Desc = {
    Text = "Terminer «Dualisme» en n'importe quelle difficulté"
  },
  Task_141341_Desc = {
    Text = "La Chasse de la Haute Maison·Terminer"
  },
  Task_141342_Desc = {
    Text = "Remporter 2 victoires dans «La Chasse de la Haute Maison» avec un Éveilleur du royaume des profondeurs"
  },
  Task_141343_Desc = {
    Text = "Terminer «Le Sifflet» en n'importe quelle difficulté"
  },
  Task_141344_Desc = {
    Text = "Terminer «Soliloque» en n'importe quelle difficulté"
  },
  Task_141345_Desc = {
    Text = "Remporter 2 victoires dans «La Chasse de la Haute Maison» avec un Réveilleur du Domaine hyperdimensionnel"
  },
  Task_141346_Desc = {
    Text = "Remporter 1 victoire dans «La Chasse de la Haute Maison» avec un Éveilleur du royaume du chaos"
  },
  Task_141347_Desc = {
    Text = "Terminer «Jeu du Prédateur» en difficulté Folie"
  },
  Task_141348_Desc = {
    Text = "Terminer «Le Sifflet» en n'importe quelle difficulté"
  },
  Task_141349_Desc = {
    Text = "Remporter 1 victoire dans «La Chasse de la Haute Maison» avec un Éveilleur du royaume de la caro"
  },
  Task_141350_Desc = {
    Text = "Atteindre la Personnalité approfondie 12 avec Pontos"
  },
  Task_141351_Desc = {
    Text = "Dégagement 2 à l'obtention de Pontos"
  },
  Task_141351_Name = {
    Text = "Dégagement 2 à l'obtention de Pontos"
  },
  Task_141351_UnlockCondDesc = {
    Text = "Événement@Événement pack de Dégagement 2 de l'Éveilleur Pontos"
  },
  Task_141352_Desc = {
    Text = "Terminer «Jeu du Prédateur» en n'importe quelle difficulté"
  },
  Task_141353_Desc = {
    Text = "Terminer «Côtes et Cartilage» en difficulté Folie"
  },
  Task_141511_Desc = {
    Text = "Jouer un total de 300 cartes"
  },
  Task_141512_Desc = {
    Text = "Terminer n'importe quelle mission saisonnière"
  },
  Task_141513_Desc = {
    Text = "Utilisez le soutien 3 fois"
  },
  Task_141514_Desc = {
    Text = "Terminer 15 Envois"
  },
  Task_141515_Desc = {
    Text = "Connexion totale de 1 jour"
  },
  Task_141516_Desc = {
    Text = "Connexion totale de 1 jour"
  },
  Task_141517_Desc = {
    Text = "Réveiller 30 fois"
  },
  Task_141518_Desc = {
    Text = "Terminer n'importe quelle mission saisonnière"
  },
  Task_141519_Desc = {
    Text = "Utilisez le soutien 3 fois"
  },
  Task_141520_Desc = {
    Text = "Les ions actifs raffinés atteignent 1 000"
  },
  Task_141521_Desc = {
    Text = "D-effet régional Spécial Training atteint 100"
  },
  Task_141522_Desc = {
    Text = "Jouer un total de 300 cartes"
  },
  Task_141523_Desc = {
    Text = "D-effet régional Spécial Training atteint 100"
  },
  Task_141524_Desc = {
    Text = "Réveiller 30 fois"
  },
  Task_141525_Desc = {
    Text = "Les ions actifs raffinés atteignent 1 000"
  },
  Task_141526_Desc = {
    Text = "Terminer 15 Envois"
  },
  Task_141799_Desc = {
    Text = "Avec des Éveilleurs du royaume des profondeurs, gagner deux fois dans «Trésors d'Umapati»"
  },
  Task_141800_Desc = {
    Text = "Avec des Corps Éveillés Hyperdimensionnels, gagnez deux fois dans «Trésors d'Umapati»"
  },
  Task_141801_Desc = {
    Text = "Terminer «Fil» en n'importe quelle difficulté"
  },
  Task_141802_Desc = {
    Text = "Avec des Éveilleurs du royaume de la caro, gagner deux fois dans «Trésors d'Umapati»"
  },
  Task_141803_Desc = {
    Text = "Compléter tous les succès de «Trésors d'Umapati : Terminer»"
  },
  Task_141804_Desc = {
    Text = "Avec des Éveilleurs du royaume du chaos, gagner une fois dans «Trésors d'Umapati»"
  },
  Task_141805_Desc = {
    Text = "Terminer «Pomme» en n'importe quelle difficulté"
  },
  Task_141806_Desc = {
    Text = "Effacez toute difficulté de \"Miroir\""
  },
  Task_141807_Desc = {
    Text = "Terminer «Clé» en n'importe quelle difficulté"
  },
  Task_141808_Desc = {
    Text = "Complétez \"Miroir\" en difficulté Folie"
  },
  Task_141809_Desc = {
    Text = "Terminer «Couronne» en difficulté Folie"
  },
  Task_141810_Desc = {
    Text = "Terminer «Plume» en n'importe quelle difficulté"
  },
  Task_141811_Desc = {
    Text = "Terminer «Œil» en n'importe quelle difficulté"
  },
  Task_141812_Desc = {
    Text = "Terminer «Fil» en difficulté Folie"
  },
  Task_141813_Desc = {
    Text = "Terminer «Pomme» en difficulté Folie"
  },
  Task_141814_Desc = {
    Text = "Terminer «Couronne» en n'importe quelle difficulté"
  },
  Task_141815_Desc = {
    Text = "Avec des Éveilleurs du royaume de la caro, gagner une fois dans «Trésors d'Umapati»"
  },
  Task_141816_Desc = {
    Text = "Effacez toute difficulté de \"Miroir\""
  },
  Task_141817_Desc = {
    Text = "Terminer «Plume» en difficulté Folie"
  },
  Task_141818_Desc = {
    Text = "Terminer «Plume» en n'importe quelle difficulté"
  },
  Task_141819_Desc = {
    Text = "Trésors d'Umapati : Folie"
  },
  Task_141820_Desc = {
    Text = "Trésors d'Umapati : Royaume"
  },
  Task_141821_Desc = {
    Text = "Terminer «Œil» en n'importe quelle difficulté"
  },
  Task_141822_Desc = {
    Text = "Terminer «Fil» en n'importe quelle difficulté"
  },
  Task_141823_Desc = {
    Text = "Terminer «Clé» en n'importe quelle difficulté"
  },
  Task_141824_Desc = {
    Text = "Trésors d'Umapati ·Terminer"
  },
  Task_141825_Desc = {
    Text = "Terminer «Pomme» en n'importe quelle difficulté"
  },
  Task_141826_Desc = {
    Text = "Avec des Réveilleurs du Domaine hyperdimensionnel, gagner une fois dans «Trésors d'Umapati»"
  },
  Task_141827_Desc = {
    Text = "Avec des Éveilleurs du royaume des profondeurs, gagner une fois dans «Trésors d'Umapati»"
  },
  Task_141828_Desc = {
    Text = "Terminer «Œil» en difficulté Folie"
  },
  Task_141829_Desc = {
    Text = "Avec des Éveilleurs du royaume du chaos, gagner deux fois dans «Trésors d'Umapati»"
  },
  Task_141830_Desc = {
    Text = "Terminer «Clé» en difficulté Folie"
  },
  Task_141831_Desc = {
    Text = "Terminer «Couronne» en n'importe quelle difficulté"
  },
  Task_141899_Desc = {
    Text = "Associez un numéro de téléphone ou une adresse e-mail dans «Centre utilisateur - Compléter le profil»"
  },
  Task_143320_Desc = {
    Text = "Terminer la Plongée dans l'inconscient «Ebwynnos Evermore» en difficulté Difficile"
  },
  Task_143320_Name = {
    Text = "Une fraîche nuit d'été · Difficile"
  },
  Task_143321_Desc = {
    Text = "Terminer la Plongée dans l'inconscient «Ebwynnos Evermore»"
  },
  Task_143321_Name = {
    Text = "Une fraîche nuit d'été"
  },
  Task_143588_Desc = {
    Text = "Rester dans ses bras..."
  },
  Task_143588_Name = {
    Text = "Rester dans ses bras..."
  },
  Task_143589_Desc = {Text = "Rester..."},
  Task_143589_Name = {Text = "Rester..."},
  Task_143590_Desc = {
    Text = "Rester à Ebwynnos"
  },
  Task_143590_Name = {
    Text = "Rester à Ebwynnos"
  },
  Task_144311_Desc = {
    Text = "Gagnez 250/500/750/1000 pts lorsque 1/2/3/4 Éveilleurs améliorés hebdomadaires sont déployés. (Actuellement : {s1})"
  },
  Task_144311_Name = {
    Text = "Appel des abysses<size=20><color=#747474>Lorsque vous partez au combat avec 1/2/3/4 Éveilleurs renforcés, obtenez 250 / 500 / 750 / 1000 points </color></size>"
  },
  Task_144312_Desc = {
    Text = "Terminer la plongée dans l'inconscient «Texte temporaire»"
  },
  Task_144313_Desc = {
    Text = "Naissance Inversée·Terminer"
  },
  Task_144314_Desc = {
    Text = "Terminer «Neurotraumatisme» en difficulté Folie"
  },
  Task_144315_Desc = {
    Text = "Avec des Corps éveillés des abysses, gagner une fois dans « Naissance Inversée »"
  },
  Task_144316_Desc = {
    Text = "Terminer «Bonnet de nuit» en difficulté Folie"
  },
  Task_144317_Desc = {
    Text = "Terminer «Bonnet de nuit» en toute difficulté"
  },
  Task_144318_Desc = {
    Text = "Naissance Inversée : Royaume"
  },
  Task_144319_Desc = {
    Text = "Terminer «L'Hôpital» à n'importe quelle difficulté"
  },
  Task_144320_Desc = {
    Text = "Avec des Corps éveillés des abysses, gagner deux fois dans « Naissance Inversée »"
  },
  Task_144321_Desc = {
    Text = "Terminer «Table à manger» en toute difficulté"
  },
  Task_144322_Desc = {
    Text = "Terminer «Table à manger» en difficulté Folie"
  },
  Task_144323_Desc = {
    Text = "Terminer «Notre Foyer» à n'importe quelle difficulté"
  },
  Task_144324_Desc = {
    Text = "Avec des Corps Éveillés Hyperdimensionnels, gagner une fois dans « Naissance Inversée »"
  },
  Task_144325_Desc = {
    Text = "Terminer «Le Puits» en toute difficulté"
  },
  Task_144326_Desc = {
    Text = "Terminer «Notre Foyer» à n'importe quelle difficulté"
  },
  Task_144327_Desc = {
    Text = "Avec des Corps éveillés du Chaos, gagner deux fois dans « Naissance Inversée »"
  },
  Task_144328_Desc = {
    Text = "Terminer «L'Hôpital» à n'importe quelle difficulté"
  },
  Task_144329_Desc = {
    Text = "Terminer «Le Puits» en toute difficulté"
  },
  Task_144330_Desc = {
    Text = "Terminer «À l'école» en toute difficulté"
  },
  Task_144331_Desc = {
    Text = "Terminer «Neurotraumatisme» en toute difficulté"
  },
  Task_144332_Desc = {
    Text = "Compléter tous les succès de « Naissance Inversée·Terminer »"
  },
  Task_144333_Desc = {
    Text = "Terminer «Table à manger» en toute difficulté"
  },
  Task_144334_Desc = {
    Text = "Terminer «À l'école» en difficulté Folie"
  },
  Task_144335_Desc = {
    Text = "Terminer « Notre Foyer » en difficulté Folie"
  },
  Task_144336_Desc = {
    Text = "Avec des Corps Éveillés de Chair et de Sang, gagner une fois dans « Naissance Inversée »"
  },
  Task_144337_Desc = {
    Text = "Terminer «Neurotraumatisme» en toute difficulté"
  },
  Task_144338_Desc = {
    Text = "Terminer «À l'école» en toute difficulté"
  },
  Task_144339_Desc = {
    Text = "Terminer «Bonnet de nuit» en toute difficulté"
  },
  Task_144340_Desc = {
    Text = "Avec des Corps Éveillés de Chair et de Sang, gagner deux fois dans « Naissance Inversée »"
  },
  Task_144341_Desc = {
    Text = "Avec des Corps éveillés du Chaos, gagner une fois dans « Naissance Inversée »"
  },
  Task_144342_Desc = {
    Text = "Avec des Corps Éveillés Hyperdimensionnels, gagner deux fois dans « Naissance Inversée »"
  },
  Task_144343_Desc = {
    Text = "Naissance Inversée·Folie"
  },
  Task_144344_Desc = {
    Text = "Terminer «Le Puits» en difficulté Folie"
  },
  Task_144345_Desc = {
    Text = "Terminer « L'Hôpital » en difficulté Folie"
  },
  Task_144360_Desc = {
    Text = "Jouer un total de 300 cartes"
  },
  Task_144361_Desc = {
    Text = "Terminer n'importe quelle mission saisonnière"
  },
  Task_144362_Desc = {
    Text = "D-effet régional Spécial Training atteint 100"
  },
  Task_144363_Desc = {
    Text = "Terminer 15 Envois"
  },
  Task_144364_Desc = {
    Text = "Les ions actifs raffinés atteignent 1 000"
  },
  Task_144365_Desc = {
    Text = "Réveiller 30 fois"
  },
  Task_144366_Desc = {
    Text = "D-effet régional Spécial Training atteint 100"
  },
  Task_144367_Desc = {
    Text = "Connexion totale de 1 jour"
  },
  Task_144368_Desc = {
    Text = "Terminer n'importe quelle mission saisonnière"
  },
  Task_144369_Desc = {
    Text = "Terminer 15 Envois"
  },
  Task_144370_Desc = {
    Text = "Jouer un total de 300 cartes"
  },
  Task_144371_Desc = {
    Text = "Les ions actifs raffinés atteignent 1 000"
  },
  Task_144372_Desc = {
    Text = "Réveiller 30 fois"
  },
  Task_144373_Desc = {
    Text = "Utilisez le soutien 3 fois"
  },
  Task_144374_Desc = {
    Text = "Utilisez le soutien 3 fois"
  },
  Task_144375_Desc = {
    Text = "Connexion totale de 1 jour"
  },
  Task_145388_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_145389_Desc = {
    Text = "Avec des Corps éveillés des abysses, gagner deux fois dans « Cupidité et Soif de Sang »"
  },
  Task_145390_Desc = {
    Text = "Terminer « L'Offrande » en n'importe quelle difficulté"
  },
  Task_145392_Desc = {
    Text = "Cupidité et Soif de Sang : Terminer"
  },
  Task_145393_Desc = {
    Text = "Terminer « Salle du Massacre » en difficulté Folie"
  },
  Task_145394_Desc = {
    Text = "Terminer « Couronne du Désir » en n'importe quelle difficulté"
  },
  Task_145395_Desc = {
    Text = "Terminer la Plongée dans l'inconscient « Until the Whale Sky Falls »"
  },
  Task_145396_Desc = {
    Text = "Dégagement 6 lors de l'obtention de Lotan : Cétarque"
  },
  Task_145396_Name = {
    Text = "Dégagement 6 lors de l'obtention de Lotan : Cétarque"
  },
  Task_145396_UnlockCondDesc = {
    Text = "Événement @ Éveilleur Lotan : Cétarque Pack de Dégagement 2 Événement"
  },
  Task_145397_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_145398_Desc = {
    Text = "Le Taux de synchronisation de Lotan : Cétarque atteint le Niveau 10"
  },
  Task_145399_Desc = {
    Text = "Cupidité et Soif de Sang : Royaume"
  },
  Task_145400_Desc = {
    Text = "Terminer « Bête en Cage » en n'importe quelle difficulté"
  },
  Task_145401_Desc = {
    Text = "Terminer « Salle du Massacre » en n'importe quelle difficulté"
  },
  Task_145402_Desc = {
    Text = "Terminer « Bête en Cage » en n'importe quelle difficulté"
  },
  Task_145403_Desc = {
    Text = "Terminer « Bête en Cage » en difficulté Folie"
  },
  Task_145404_Desc = {
    Text = "Avec des Corps Éveillés Hyperdimensionnels, gagner une fois dans « Cupidité et Soif de Sang »"
  },
  Task_145405_Desc = {
    Text = "Avec des Corps éveillés du Chaos, gagner deux fois dans « Cupidité et Soif de Sang »"
  },
  Task_145406_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_145408_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_145409_Desc = {
    Text = "Terminer « Couronne du Désir » en n'importe quelle difficulté"
  },
  Task_145410_Desc = {
    Text = "Compléter tous les succès de « Cupidité et Soif de Sang ·Terminer»"
  },
  Task_145411_Desc = {
    Text = "Avec des Corps Éveillés de Chair et de Sang, gagner une fois dans « Cupidité et Soif de Sang »"
  },
  Task_145412_Desc = {
    Text = "Avec des Corps Éveillés de Chair et de Sang, gagner deux fois dans « Cupidité et Soif de Sang »"
  },
  Task_145413_Desc = {
    Text = "Terminer « L'Offrande » en n'importe quelle difficulté"
  },
  Task_145414_Desc = {
    Text = "Dégagement 2 lors de l'obtention de Lotan : Cétarque"
  },
  Task_145414_Name = {
    Text = "Dégagement 2 lors de l'obtention de Lotan : Cétarque"
  },
  Task_145414_UnlockCondDesc = {
    Text = "Événement @ Éveilleur Lotan : Cétarque Pack de Dégagement 2 Événement"
  },
  Task_145415_Desc = {
    Text = "Avec des Corps éveillés du Chaos, gagner une fois dans « Cupidité et Soif de Sang »"
  },
  Task_145416_Desc = {
    Text = "Avec des Corps Éveillés Hyperdimensionnels, gagner deux fois dans « Cupidité et Soif de Sang »"
  },
  Task_145417_Desc = {
    Text = "Terminer « L'Offrande » en difficulté Folie"
  },
  Task_145418_Desc = {
    Text = "Cupidité et Soif de Sang : Folie"
  },
  Task_145419_Desc = {
    Text = "Terminer « Le Miroir Vide » en difficulté Folie"
  },
  Task_145420_Desc = {
    Text = "Terminer « Le Miroir Vide » en n'importe quelle difficulté"
  },
  Task_145421_Desc = {
    Text = "Terminer « Couronne du Désir » en difficulté Folie"
  },
  Task_145423_Desc = {
    Text = "Avec des Corps éveillés des abysses, gagner une fois dans « Cupidité et Soif de Sang »"
  },
  Task_145424_Desc = {
    Text = "Terminer « Le Miroir Vide » en n'importe quelle difficulté"
  },
  Task_145425_Desc = {
    Text = "Lotan : Cétarque atteint la Personnalité approfondie 12"
  },
  Task_145426_Desc = {
    Text = "Terminer « Salle du Massacre » en n'importe quelle difficulté"
  },
  Task_145479_Desc = {
    Text = "Terminer la Plongée dans l'inconscient « Jusqu'à la Chute du Cétus »"
  },
  Task_145479_Name = {
    Text = "Je Suis la Tempête"
  },
  Task_145576_Desc = {
    Text = "Texte temporaire · Exclusif à durée limitée"
  },
  Task_145578_Desc = {
    Text = "Art des Vœux Infinis : Exclusivité Limitée"
  },
  Task_146542_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_146543_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_146544_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_146545_Desc = {
    Text = "Terminer le Chapitre des Étoiles Chapitre 6-8"
  },
  Task_146546_Desc = {
    Text = "Terminer le Chapitre des Étoiles Chapitre 6 «Quand la Montagne Festoie» : Difficile"
  },
  Task_146547_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_146548_Desc = {
    Text = "Terminer le Chapitre des Étoiles Chapitre 6 «Quand la Montagne Festoie» : Difficile"
  },
  Task_146549_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_146550_Desc = {
    Text = "Terminer le Chapitre des Étoiles Chapitre 6-8"
  },
  Task_146552_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_146553_Desc = {
    Text = "Terminer le Chapitre des Étoiles Chapitre 6 «Quand la Montagne Festoie»"
  },
  Task_146554_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_146555_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_146556_Desc = {
    Text = "Terminer le Chapitre des Étoiles Chapitre 6 6-5 en difficulté Difficile"
  },
  Task_146557_Desc = {
    Text = "Terminer le Chapitre des Étoiles Chapitre 6 6-5 en difficulté Difficile"
  },
  Task_146558_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_146559_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_146560_Desc = {
    Text = "Terminer le Chapitre des Étoiles Chapitre 6 «Quand la Montagne Festoie»"
  },
  Task_146801_Desc = {
    Text = "Utilisation de l'éveilleur du royaume des profondeurs gagné 1 fois dans \"Texte temporaire\""
  },
  Task_146802_Desc = {
    Text = "Complétez \"Texte Temporaire\" à n'importe quelle difficulté"
  },
  Task_146803_Desc = {
    Text = "Compléter le \"Texte Temporaire\" en difficulté Folie"
  },
  Task_146804_Desc = {
    Text = "Complétez \"Texte Temporaire\" à n'importe quelle difficulté"
  },
  Task_146805_Desc = {
    Text = "Utilisation de l'éveilleur du royaume Caro gagné 2 fois dans \"Texte temporaire\""
  },
  Task_146806_Desc = {
    Text = "Complétez \"Texte Temporaire\" à n'importe quelle difficulté"
  },
  Task_146807_Desc = {
    Text = "Complétez \"Texte Temporaire\" à n'importe quelle difficulté"
  },
  Task_146808_Desc = {
    Text = "Terminer la Plongée dans l'inconscient «五日谈»"
  },
  Task_146809_Desc = {
    Text = "Complétez \"Texte Temporaire\" à n'importe quelle difficulté"
  },
  Task_146810_Desc = {
    Text = "Utilisation de l'éveilleur du royaume des profondeurs gagné 2 fois dans \"Texte temporaire\""
  },
  Task_146811_Desc = {
    Text = "Complétez \"Texte Temporaire\" à n'importe quelle difficulté"
  },
  Task_146812_Desc = {
    Text = "Complétez \"Texte Temporaire\" à n'importe quelle difficulté"
  },
  Task_146813_Desc = {
    Text = "Complétez \"Texte Temporaire\" à n'importe quelle difficulté"
  },
  Task_146814_Desc = {
    Text = "Complétez \"Texte Temporaire\" à n'importe quelle difficulté"
  },
  Task_146815_Desc = {
    Text = "Utilisation de l'éveilleur du royaume Chaos gagné 1 fois dans \"Texte temporaire\""
  },
  Task_146816_Desc = {
    Text = "Utilisation de l'éveilleur du royaume Ultra gagné 1 fois dans \"Texte temporaire\""
  },
  Task_146817_Desc = {
    Text = "Texte temporaire · Achèvement"
  },
  Task_146818_Desc = {
    Text = "Complétez \"Texte Temporaire\" à n'importe quelle difficulté"
  },
  Task_146819_Desc = {
    Text = "Complétez \"Texte Temporaire\" à n'importe quelle difficulté"
  },
  Task_146820_Desc = {
    Text = "Complétez \"Texte Temporaire\" à n'importe quelle difficulté"
  },
  Task_146821_Desc = {
    Text = "Compléter le \"Texte Temporaire\" en difficulté Folie"
  },
  Task_146822_Desc = {
    Text = "Compléter le \"Texte Temporaire\" en difficulté Folie"
  },
  Task_146823_Desc = {
    Text = "Texte temporaire · Royaume"
  },
  Task_146824_Desc = {
    Text = "Compléter le \"Texte Temporaire\" en difficulté Folie"
  },
  Task_146825_Desc = {
    Text = "Compléter le \"Texte Temporaire\" en difficulté Folie"
  },
  Task_146826_Desc = {
    Text = "Complétez \"Texte Temporaire\" à n'importe quelle difficulté"
  },
  Task_146827_Desc = {
    Text = "Complétez \"Texte Temporaire\" à n'importe quelle difficulté"
  },
  Task_146828_Desc = {
    Text = "Compléter le \"Texte Temporaire\" en difficulté Folie"
  },
  Task_146829_Desc = {
    Text = "Utilisation de l'éveilleur du royaume Chaos gagné 2 fois dans \"Texte temporaire\""
  },
  Task_146830_Desc = {
    Text = "Compléter le \"Texte Temporaire\" en difficulté Folie"
  },
  Task_146831_Desc = {
    Text = "Utilisation de l'éveilleur du royaume Ultra gagné 2 fois dans \"Texte temporaire\""
  },
  Task_146832_Desc = {
    Text = "Complétez \"Texte Temporaire\" à n'importe quelle difficulté"
  },
  Task_146833_Desc = {
    Text = "Utilisation de l'éveilleur du royaume Caro gagné 1 fois dans \"Texte temporaire\""
  },
  Task_146834_Desc = {
    Text = "Complétez \"Texte Temporaire\" à n'importe quelle difficulté"
  },
  Task_146835_Desc = {
    Text = "Texte temporaire · Folie"
  },
  Task_146836_Desc = {
    Text = "Compléter toutes les réalisations de \"Texte Temporaire · Effacer\""
  },
  Task_146837_Desc = {
    Text = "Compléter le \"Texte Temporaire\" en difficulté Folie"
  },
  Task_146838_Desc = {
    Text = "Compléter le \"Texte Temporaire\" en difficulté Folie"
  },
  Task_146839_Desc = {
    Text = "Complétez \"Texte Temporaire\" à n'importe quelle difficulté"
  },
  Task_146840_Desc = {
    Text = "Complétez \"Texte Temporaire\" à n'importe quelle difficulté"
  },
  Task_147442_Desc = {
    Text = "Utilisation de l'éveilleur du royaume Caro gagné 2 fois dans \"Texte temporaire\""
  },
  Task_147443_Desc = {
    Text = "Le Taux de synchronisation de Tinct : Vespera atteint le Niveau 10"
  },
  Task_147444_Desc = {
    Text = "Utilisation de l'éveilleur du royaume des profondeurs gagné 1 fois dans \"Texte temporaire\""
  },
  Task_147450_Desc = {
    Text = "Terminer la plongée dans l'inconscient «Texte temporaire»"
  },
  Task_147451_Desc = {
    Text = "Utilisation de l'éveilleur du royaume Ultra gagné 1 fois dans \"Texte temporaire\""
  },
  Task_147452_Desc = {
    Text = "Utilisation de l'éveilleur du royaume Chaos gagné 1 fois dans \"Texte temporaire\""
  },
  Task_147453_Desc = {
    Text = "Utilisation de l'éveilleur du royaume des profondeurs gagné 2 fois dans \"Texte temporaire\""
  },
  Task_147454_Desc = {
    Text = "Utilisation de l'éveilleur du royaume Caro gagné 1 fois dans \"Texte temporaire\""
  },
  Task_147456_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_147458_Desc = {
    Text = "Dégagement 2 lors de l'obtention de Tinct : Vespera"
  },
  Task_147458_Name = {
    Text = "Dégagement 2 lors de l'obtention de Tinct : Vespera"
  },
  Task_147458_UnlockCondDesc = {
    Text = "Activité@Pack de Dégagement 2 pour l'Éveilleur Tinct : Vespera"
  },
  Task_147461_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_147464_Desc = {
    Text = "Terminez l'errance «Texte Temporaire»"
  },
  Task_147464_Name = {
    Text = "Texte temporaire"
  },
  Task_147465_Desc = {
    Text = "Dégagement 6 lors de l'obtention de Tinct : Vespera"
  },
  Task_147465_Name = {
    Text = "Dégagement 6 lors de l'obtention de Tinct : Vespera"
  },
  Task_147465_UnlockCondDesc = {
    Text = "Activité@Pack de Dégagement 2 pour l'Éveilleur Tinct : Vespera"
  },
  Task_147471_Desc = {
    Text = "Tinct : Vespera atteint l'approfondissement de personnalité 12"
  },
  Task_147472_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_147474_Desc = {
    Text = "Utilisation de l'éveilleur du royaume Chaos gagné 2 fois dans \"Texte temporaire\""
  },
  Task_147475_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_147476_Desc = {
    Text = "Compléter toutes les réalisations de \"Texte Temporaire · Effacer\""
  },
  Task_147478_Desc = {
    Text = "Terminer la Plongée dans l'inconscient «Texte Temporaire» en difficulté Difficile"
  },
  Task_147478_Name = {
    Text = "Texte temporaire · Difficile"
  },
  Task_147483_Desc = {
    Text = "Utilisation de l'éveilleur du royaume Ultra gagné 2 fois dans \"Texte temporaire\""
  },
  Task_147552_Desc = {
    Text = "Complétez \"Texte Temporaire\" à n'importe quelle difficulté"
  },
  Task_147553_Desc = {
    Text = "Complétez \"Texte Temporaire\" à n'importe quelle difficulté"
  },
  Task_147554_Desc = {
    Text = "Complétez \"Texte Temporaire\" à n'importe quelle difficulté"
  },
  Task_147555_Desc = {
    Text = "Complétez \"Texte Temporaire\" à n'importe quelle difficulté"
  },
  Task_147556_Desc = {
    Text = "Compléter le \"Texte Temporaire\" en difficulté Folie"
  },
  Task_147557_Desc = {
    Text = "Complétez \"Texte Temporaire\" à n'importe quelle difficulté"
  },
  Task_147558_Desc = {
    Text = "Complétez \"Texte Temporaire\" à n'importe quelle difficulté"
  },
  Task_147559_Desc = {
    Text = "Complétez \"Texte Temporaire\" à n'importe quelle difficulté"
  },
  Task_147560_Desc = {
    Text = "Compléter le \"Texte Temporaire\" en difficulté Folie"
  },
  Task_147561_Desc = {
    Text = "Complétez \"Texte Temporaire\" à n'importe quelle difficulté"
  },
  Task_147562_Desc = {
    Text = "Compléter le \"Texte Temporaire\" en difficulté Folie"
  },
  Task_147563_Desc = {
    Text = "Texte temporaire · Folie"
  },
  Task_147564_Desc = {
    Text = "Complétez \"Texte Temporaire\" à n'importe quelle difficulté"
  },
  Task_147565_Desc = {
    Text = "Complétez \"Texte Temporaire\" à n'importe quelle difficulté"
  },
  Task_147566_Desc = {
    Text = "Complétez \"Texte Temporaire\" à n'importe quelle difficulté"
  },
  Task_147567_Desc = {
    Text = "Compléter le \"Texte Temporaire\" en difficulté Folie"
  },
  Task_147568_Desc = {
    Text = "Compléter le \"Texte Temporaire\" en difficulté Folie"
  },
  Task_147569_Desc = {
    Text = "Texte temporaire · Royaume"
  },
  Task_147570_Desc = {
    Text = "Complétez \"Texte Temporaire\" à n'importe quelle difficulté"
  },
  Task_147571_Desc = {
    Text = "Complétez \"Texte Temporaire\" à n'importe quelle difficulté"
  },
  Task_147572_Desc = {
    Text = "Compléter le \"Texte Temporaire\" en difficulté Folie"
  },
  Task_147573_Desc = {
    Text = "Compléter le \"Texte Temporaire\" en difficulté Folie"
  },
  Task_147574_Desc = {
    Text = "Texte temporaire · Achèvement"
  },
  Task_147575_Desc = {
    Text = "Complétez \"Texte Temporaire\" à n'importe quelle difficulté"
  },
  Task_147676_Desc = {
    Text = "Le joueur atteint le Niveau 2"
  },
  Task_147676_Name = {
    Text = "(En attente d'emballage)"
  },
  Task_147677_Desc = {
    Text = "Posséder 1 Éveilleur de Niveau 10"
  },
  Task_147677_Name = {
    Text = "(En attente d'emballage)"
  },
  Task_147678_Desc = {
    Text = "Terminer l'Événement d'enquête «Jour d'inscription»"
  },
  Task_147678_Name = {
    Text = "(En attente d'emballage)"
  },
  Task_147679_Desc = {
    Text = "Posséder 5 Éveilleurs"
  },
  Task_147679_Name = {
    Text = "(En attente d'emballage)"
  },
  Task_147894_Desc = {
    Text = "Texte temporaire"
  },
  Task_147894_Name = {Text = "Objectif"},
  Task_147895_Desc = {
    Text = "Terminez le Scénario Principal «Quand la Montagne Festoie» en Mode Difficile"
  },
  Task_147895_Name = {
    Text = "Repos à 8 840 Mètres : Difficile"
  },
  Task_147896_Desc = {
    Text = "Texte temporaire"
  },
  Task_147896_Name = {Text = "Objectif"},
  Task_147897_Desc = {
    Text = "Texte temporaire"
  },
  Task_147897_Name = {Text = "Objectif"},
  Task_147898_Desc = {
    Text = "Texte temporaire"
  },
  Task_147898_Name = {Text = "Objectif"},
  Task_147899_Desc = {
    Text = "Texte temporaire"
  },
  Task_147899_Name = {Text = "Objectif"},
  Task_147900_Desc = {
    Text = "Texte temporaire"
  },
  Task_147900_Name = {Text = "Objectif"},
  Task_147901_Desc = {
    Text = "Texte temporaire"
  },
  Task_147901_Name = {Text = "Objectif"},
  Task_147902_Desc = {
    Text = "Résonner 9 fois dans l'enquête sur l'événement «@1@2»"
  },
  Task_147902_Desc2 = {
    Text = "Résonnez 9 fois dans le Scénario Principal «Quand la Montagne Festoie»"
  },
  Task_147902_Name = {Text = "@2@3"},
  Task_147902_Name2 = {
    Text = "Rite Septuple des Ingénus IV"
  },
  Task_147903_Desc = {
    Text = "Texte temporaire"
  },
  Task_147903_Name = {Text = "Objectif"},
  Task_147904_Desc = {
    Text = "Texte temporaire"
  },
  Task_147904_Name = {Text = "Objectif"},
  Task_147905_Desc = {
    Text = "Résonner 3 fois dans l'enquête sur l'événement «@1@2»"
  },
  Task_147905_Desc2 = {
    Text = "Résonnez 3 fois dans le Scénario Principal «Quand la Montagne Festoie»"
  },
  Task_147905_Name = {Text = "@2@3"},
  Task_147905_Name2 = {
    Text = "Rite Septuple des Ingénus"
  },
  Task_147906_Desc = {
    Text = "Résonnez 7 fois dans l'événement d'investigation \"@1@2\""
  },
  Task_147906_Desc2 = {
    Text = "Résonner 9 fois dans le Scénario principal « Quand la Montagne Festoie »"
  },
  Task_147906_Name = {Text = "@2@3"},
  Task_147906_Name2 = {
    Text = "Rite Septuple des Ingénus III"
  },
  Task_147907_Desc = {
    Text = "Résonner 5 fois dans l'Événement d'enquête « @1@2 »"
  },
  Task_147907_Desc2 = {
    Text = "Résonner 6 fois dans le Scénario principal « Quand la Montagne Festoie »"
  },
  Task_147907_Name = {Text = "@2@3"},
  Task_147907_Name2 = {
    Text = "Rite Septuple des Ingénus II"
  },
  Task_147908_Desc = {
    Text = "Compléter l'événement d'investigation \"@1@2\""
  },
  Task_147908_Desc2 = {
    Text = "Terminez le Scénario Principal «Quand la Montagne Festoie»"
  },
  Task_147908_Name = {Text = "@2@3"},
  Task_147908_Name2 = {
    Text = "Repos à 8 840 Mètres"
  },
  Task_147909_Desc = {
    Text = "Texte temporaire"
  },
  Task_147909_Name = {Text = "Objectif"},
  Task_147910_Desc = {
    Text = "Texte temporaire"
  },
  Task_147910_Name = {Text = "Objectif"},
  Task_148121_Desc = {
    Text = "Terminer 15 Envois"
  },
  Task_148122_Desc = {
    Text = "D-effet régional Spécial Training atteint 100"
  },
  Task_148123_Desc = {
    Text = "Connexion totale de 1 jour"
  },
  Task_148124_Desc = {
    Text = "Réveiller 30 fois"
  },
  Task_148125_Desc = {
    Text = "Connexion totale de 1 jour"
  },
  Task_148126_Desc = {
    Text = "Terminer n'importe quelle mission saisonnière"
  },
  Task_148127_Desc = {
    Text = "Terminer n'importe quelle mission saisonnière"
  },
  Task_148128_Desc = {
    Text = "D-effet régional Spécial Training atteint 100"
  },
  Task_148129_Desc = {
    Text = "Réveiller 30 fois"
  },
  Task_148130_Desc = {
    Text = "Terminer 15 Envois"
  },
  Task_148131_Desc = {
    Text = "Utilisez le soutien 3 fois"
  },
  Task_148132_Desc = {
    Text = "Les ions actifs raffinés atteignent 1 000"
  },
  Task_148133_Desc = {
    Text = "Utilisez le soutien 3 fois"
  },
  Task_148134_Desc = {
    Text = "Jouer un total de 300 cartes"
  },
  Task_148135_Desc = {
    Text = "Les ions actifs raffinés atteignent 1 000"
  },
  Task_148136_Desc = {
    Text = "Jouer un total de 300 cartes"
  },
  Task_148489_Desc = {
    Text = "Terminer la Plongée dans l'inconscient «五日谈»"
  },
  Task_148489_Name = {
    Text = "Le triomphe de l'exilé"
  },
  Task_148490_Desc = {
    Text = "Terminer la Plongée dans l'inconscient «五日谈» en difficulté Difficile"
  },
  Task_148490_Name = {
    Text = "Le triomphe de l'exilé · Difficile"
  },
  Task_149335_Desc = {
    Text = "Tuer le dragon"
  },
  Task_149335_Name = {Text = "Objectif"},
  Task_149989_Desc = {
    Text = "Terminer Chapitre des Étoiles 6-1"
  },
  Task_149990_Desc = {
    Text = "Atteindre le niveau d'approfondissement de personnalité 12 avec l'Origine Ogier"
  },
  Task_19734_Desc = {
    Text = "Complète Fissure du Voyage Ultra VI"
  },
  Task_19735_Desc = {
    Text = "Clair Marais Caro · Fissure VIII"
  },
  Task_19736_Desc = {
    Text = "Clair Voyage Ultra · Fissure IV"
  },
  Task_19737_Desc = {
    Text = "Clair Marais Caro · Fissure II"
  },
  Task_19738_Desc = {
    Text = "Clair Voyage Ultra · Fissure II"
  },
  Task_19739_Desc = {
    Text = "Achever Fissure Caro VI"
  },
  Task_19740_Desc = {
    Text = "Placez des pièges et exécutez \"Chasse\""
  },
  Task_19740_Name = {Text = "Objectif"},
  Task_19741_Desc = {
    Text = "Clair Voyage Ultra : Fissure VIII"
  },
  Task_19742_Desc = {
    Text = "Complétez Aequor : Fissure II"
  },
  Task_19743_Desc = {
    Text = "Clair Domaine Chaos·Fissure II"
  },
  Task_19744_Desc = {
    Text = "Complétez Aequor : Fissure VI"
  },
  Task_19745_Desc = {
    Text = "Clair Domaine Chaos·Fissure IV"
  },
  Task_19746_Desc = {
    Text = "Complétez Aequor : Fissure IV"
  },
  Task_19747_Desc = {
    Text = "Clair Domaine Chaos · Fissure VI"
  },
  Task_19748_Desc = {
    Text = "Clair Domaine Chaos · Fissure VIII"
  },
  Task_19749_Desc = {
    Text = "Complétez Aequor : Fissure VIII"
  },
  Task_19750_Desc = {
    Text = "Placez des pièges et exécutez \"Chasse\""
  },
  Task_19750_Name = {Text = "Objectif"},
  Task_19751_Desc = {
    Text = "Aidez Lotan à traquer les ennemis"
  },
  Task_19751_Name = {Text = "Objectif"},
  Task_19752_Desc = {
    Text = "Achever Fissure Caro IV"
  },
  Task_20972_Desc = {
    Text = "Terminez la Fissure I de l'Ultra Voyage"
  },
  Task_20973_Desc = {
    Text = "Complétez Aequor : Fissure I"
  },
  Task_20990_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_20990_Name = {
    Text = "Résolution rapide"
  },
  Task_20991_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_20991_Name = {
    Text = "Passer Parfait"
  },
  Task_20992_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_20992_Name = {
    Text = "Passer Parfait"
  },
  Task_20993_Desc = {
    Text = "Dans la bataille finale, active Exalter au moins 4 fois en un tour."
  },
  Task_20993_Name = {
    Text = "Magie mortelle"
  },
  Task_20994_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_20994_Name = {
    Text = "Passer Parfait"
  },
  Task_20995_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_20995_Name = {
    Text = "Passer Parfait"
  },
  Task_20996_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_20996_Name = {
    Text = "Élégant et précis"
  },
  Task_20997_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_20997_Name = {
    Text = "Résolution rapide"
  },
  Task_20998_Desc = {
    Text = "Piger au moins 5 cartes supplémentaires en un tour pendant la Bataille Finale"
  },
  Task_20998_Name = {Text = "Draw!"},
  Task_20999_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_20999_Name = {
    Text = "Passer Parfait"
  },
  Task_21000_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21000_Name = {
    Text = "Résolution rapide"
  },
  Task_21001_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21001_Name = {
    Text = "Passer Parfait"
  },
  Task_21002_Desc = {
    Text = "Réveillez tous les Réveilleurs à l'achèvement"
  },
  Task_21002_Name = {
    Text = "Étreinte infinie"
  },
  Task_21003_Desc = {
    Text = "Gagnez au moins 4 types différents d'Oraisons"
  },
  Task_21003_Name = {
    Text = "Marque de l'Âme"
  },
  Task_21004_Desc = {
    Text = "Infliger au moins 240 points de dégâts en un seul tour pendant une bataille d'élite."
  },
  Task_21004_Name = {
    Text = "Attaque totale"
  },
  Task_21005_Desc = {
    Text = "Pas de récupération de Vie depuis la Jonction à la fin"
  },
  Task_21005_Name = {
    Text = "Les non-illuminés"
  },
  Task_21006_Desc = {
    Text = "Avoir pas plus de 3 Cartes de Symptômes lors de l'achèvement"
  },
  Task_21006_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_21007_Desc = {
    Text = "Transportez au moins 1 Relique maudite à l'achèvement."
  },
  Task_21007_Name = {
    Text = "Planque secrète"
  },
  Task_21008_Desc = {
    Text = "Avoir pas plus de 1 Carte de Symptôme lors de l'achèvement"
  },
  Task_21008_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_21009_Desc = {
    Text = "Jouer au moins 4 Cartes en un tour lors de la Bataille Finale"
  },
  Task_21009_Name = {Text = "Mon tour !"},
  Task_21010_Desc = {
    Text = "La progression de l'exploration atteint 100 %"
  },
  Task_21010_Name = {
    Text = "Surplomber le royaume de brouillard"
  },
  Task_21011_Desc = {
    Text = "Transportez au moins 5 Reliques à l'achèvement"
  },
  Task_21011_Name = {
    Text = "Planque secrète"
  },
  Task_21012_Desc = {
    Text = "Transportez au moins 5 Reliques à l'achèvement"
  },
  Task_21012_Name = {
    Text = "Planque secrète"
  },
  Task_21013_Desc = {
    Text = "Transportez au moins 5 Reliques à l'achèvement"
  },
  Task_21013_Name = {
    Text = "Planque secrète"
  },
  Task_21014_Desc = {
    Text = "Lors d'un tour de la bataille finale, empilez un bouclier équivalent à au moins 50% de la santé maximale."
  },
  Task_21014_Name = {Text = "Ironclad"},
  Task_21015_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21015_Name = {
    Text = "Passer Parfait"
  },
  Task_21016_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_21016_Name = {
    Text = "Élégant et précis"
  },
  Task_21017_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21017_Name = {
    Text = "Passer Parfait"
  },
  Task_21018_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_21018_Name = {
    Text = "Élégant et précis"
  },
  Task_21019_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_21019_Name = {
    Text = "Élégant et précis"
  },
  Task_21020_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21020_Name = {
    Text = "Passer Parfait"
  },
  Task_21021_Desc = {
    Text = "Gagner la Bataille Finale en moins de 15 tours"
  },
  Task_21021_Name = {
    Text = "Résolution rapide"
  },
  Task_21022_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21022_Name = {
    Text = "Passer Parfait"
  },
  Task_21023_Desc = {
    Text = "Avoir pas plus de 2 Cartes de Symptômes lors de l'achèvement"
  },
  Task_21023_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_21024_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21024_Name = {
    Text = "Passer Parfait"
  },
  Task_21025_Desc = {
    Text = "Dans la bataille finale, active Exalter au moins 4 fois en un tour."
  },
  Task_21025_Name = {
    Text = "Magie mortelle"
  },
  Task_21026_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21026_Name = {
    Text = "Passer Parfait"
  },
  Task_21027_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21027_Name = {
    Text = "Résolution rapide"
  },
  Task_21028_Desc = {
    Text = "Gagner la Bataille Finale en moins de 15 tours"
  },
  Task_21028_Name = {
    Text = "Résolution rapide"
  },
  Task_21029_Desc = {
    Text = "Jouer au moins 6 Cartes en un tour lors de la Bataille Finale"
  },
  Task_21029_Name = {Text = "Mon tour !"},
  Task_21030_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21030_Name = {
    Text = "Passer Parfait"
  },
  Task_21032_Desc = {
    Text = "Causer au moins 40000 points de dégâts en un tour dans la bataille finale"
  },
  Task_21032_Name = {
    Text = "Attaque totale"
  },
  Task_21033_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21033_Name = {
    Text = "Passer Parfait"
  },
  Task_21034_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21034_Name = {
    Text = "Passer Parfait"
  },
  Task_21035_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_21035_Name = {
    Text = "Résolution rapide"
  },
  Task_21036_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21036_Name = {
    Text = "Passer Parfait"
  },
  Task_21037_Desc = {
    Text = "Avoir pas plus de 1 Carte de Symptôme lors de l'achèvement"
  },
  Task_21037_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_21038_Desc = {
    Text = "Jouer au moins 4 Cartes en un tour lors de la Bataille Finale"
  },
  Task_21038_Name = {Text = "Mon tour !"},
  Task_21039_Desc = {
    Text = "La progression de l'exploration atteint 100 %"
  },
  Task_21039_Name = {
    Text = "Surplomber le royaume de brouillard"
  },
  Task_21040_Desc = {
    Text = "Transportez au moins 5 Reliques à l'achèvement"
  },
  Task_21040_Name = {
    Text = "Planque secrète"
  },
  Task_21041_Desc = {
    Text = "Transportez au moins 5 Reliques à l'achèvement"
  },
  Task_21041_Name = {
    Text = "Planque secrète"
  },
  Task_21042_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_21042_Name = {
    Text = "Élégant et précis"
  },
  Task_21043_Desc = {
    Text = "Lors d'un tour de la bataille finale, empilez un bouclier équivalent à au moins 50% de la santé maximale."
  },
  Task_21043_Name = {Text = "Ironclad"},
  Task_21044_Desc = {
    Text = "Gagnez au moins 4 types différents d'Oraisons"
  },
  Task_21044_Name = {
    Text = "Marque de l'Âme"
  },
  Task_21045_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_21045_Name = {
    Text = "Élégant et précis"
  },
  Task_21046_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21046_Name = {
    Text = "Résolution rapide"
  },
  Task_21047_Desc = {
    Text = "Dans la bataille finale, active Exalter au moins 4 fois en un tour."
  },
  Task_21047_Name = {
    Text = "Magie mortelle"
  },
  Task_21048_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21048_Name = {
    Text = "Passer Parfait"
  },
  Task_21049_Desc = {
    Text = "Avoir pas plus de 1 Carte de Symptôme lors de l'achèvement"
  },
  Task_21049_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_21050_Desc = {
    Text = "Réveillez tous les Réveilleurs à l'achèvement"
  },
  Task_21050_Name = {
    Text = "Étreinte infinie"
  },
  Task_21051_Desc = {
    Text = "Transportez au moins 2 Reliques à l'achèvement"
  },
  Task_21051_Name = {
    Text = "Planque secrète"
  },
  Task_21052_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21052_Name = {
    Text = "Passer Parfait"
  },
  Task_21053_Desc = {
    Text = "Gagnez au moins 4 types différents d'Oraisons"
  },
  Task_21053_Name = {
    Text = "Marque de l'Âme"
  },
  Task_21054_Desc = {
    Text = "Gagnez au moins 4 types différents d'Oraisons"
  },
  Task_21054_Name = {
    Text = "Marque de l'Âme"
  },
  Task_21055_Desc = {
    Text = "Infliger au moins 980 points de dégâts en un seul tour pendant une bataille d'élite."
  },
  Task_21055_Name = {
    Text = "Attaque totale"
  },
  Task_21056_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_21056_Name = {
    Text = "Élégant et précis"
  },
  Task_21057_Desc = {
    Text = "Avoir pas plus de 3 Cartes de Symptômes lors de l'achèvement"
  },
  Task_21057_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_21058_Desc = {
    Text = "Transportez au moins 1 Relique maudite à l'achèvement."
  },
  Task_21058_Name = {
    Text = "Planque secrète"
  },
  Task_21059_Desc = {
    Text = "La progression de l'exploration atteint 100 %"
  },
  Task_21059_Name = {
    Text = "Surplomber le royaume de brouillard"
  },
  Task_21060_Desc = {
    Text = "Utilisez Exalt au moins 3 fois en un seul tour lors d'une bataille d'élite."
  },
  Task_21060_Name = {
    Text = "Magie mortelle"
  },
  Task_21061_Desc = {
    Text = "Piger au moins 5 cartes supplémentaires en un tour pendant la Bataille Finale"
  },
  Task_21061_Name = {Text = "Draw!"},
  Task_21062_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_21062_Name = {
    Text = "Résolution rapide"
  },
  Task_21063_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21063_Name = {
    Text = "Passer Parfait"
  },
  Task_21064_Desc = {
    Text = "Transportez au moins 2 Reliques à l'achèvement"
  },
  Task_21064_Name = {
    Text = "Planque secrète"
  },
  Task_21065_Desc = {
    Text = "Avoir pas plus de 2 Cartes de Symptômes lors de l'achèvement"
  },
  Task_21065_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_21066_Desc = {
    Text = "Gagnez au moins 3 types d'Oraison"
  },
  Task_21066_Name = {
    Text = "Marque de l'Âme"
  },
  Task_21067_Desc = {
    Text = "Réveillez au moins 2 Réveilleurs à l'achèvement"
  },
  Task_21067_Name = {
    Text = "Étreinte infinie"
  },
  Task_21068_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_21068_Name = {
    Text = "Élégant et précis"
  },
  Task_21069_Desc = {
    Text = "Transportez au moins 1 Relique maudite à l'achèvement."
  },
  Task_21069_Name = {
    Text = "Planque secrète"
  },
  Task_21070_Desc = {
    Text = "Jouer au moins 4 Cartes en un tour lors de la Bataille Finale"
  },
  Task_21070_Name = {Text = "Mon tour !"},
  Task_21071_Desc = {
    Text = "Dans la bataille finale, active Exalter au moins 3 fois en un tour."
  },
  Task_21071_Name = {
    Text = "Magie mortelle"
  },
  Task_21072_Desc = {
    Text = "Avoir pas plus de 3 Cartes de Symptômes lors de l'achèvement"
  },
  Task_21072_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_21073_Desc = {
    Text = "Avoir pas plus de 1 Carte de Symptôme lors de l'achèvement"
  },
  Task_21073_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_21074_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21074_Name = {
    Text = "Passer Parfait"
  },
  Task_21075_Desc = {
    Text = "Posséder 4 types différents d'Oraison"
  },
  Task_21075_Name = {
    Text = "Marque de l'Âme"
  },
  Task_21076_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21076_Name = {
    Text = "Résolution rapide"
  },
  Task_21077_Desc = {
    Text = "Jouer au moins 5 Cartes en un tour lors de la Bataille Finale."
  },
  Task_21077_Name = {Text = "Mon tour !"},
  Task_21078_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21078_Name = {
    Text = "Passer Parfait"
  },
  Task_21079_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21079_Name = {
    Text = "Passer Parfait"
  },
  Task_21080_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21080_Name = {
    Text = "Passer Parfait"
  },
  Task_21081_Desc = {
    Text = "Inflige 350 Dégâts en un tour lors de la Bataille Finale."
  },
  Task_21081_Name = {
    Text = "Attaque totale"
  },
  Task_21082_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21082_Name = {
    Text = "Résolution rapide"
  },
  Task_21083_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21083_Name = {
    Text = "Résolution rapide"
  },
  Task_21084_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21084_Name = {
    Text = "Passer Parfait"
  },
  Task_21085_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21085_Name = {
    Text = "Passer Parfait"
  },
  Task_21086_Desc = {
    Text = "Avoir pas plus de 2 Cartes de Symptômes lors de l'achèvement"
  },
  Task_21086_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_21087_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21087_Name = {
    Text = "Résolution rapide"
  },
  Task_21088_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21088_Name = {
    Text = "Résolution rapide"
  },
  Task_21089_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21089_Name = {
    Text = "Passer Parfait"
  },
  Task_21090_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21090_Name = {
    Text = "Résolution rapide"
  },
  Task_21091_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21091_Name = {
    Text = "Résolution rapide"
  },
  Task_21092_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21092_Name = {
    Text = "Résolution rapide"
  },
  Task_21093_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21093_Name = {
    Text = "Résolution rapide"
  },
  Task_21094_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21094_Name = {
    Text = "Résolution rapide"
  },
  Task_21095_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_21095_Name = {
    Text = "Résolution rapide"
  },
  Task_21096_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_21096_Name = {
    Text = "Résolution rapide"
  },
  Task_21097_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_21097_Name = {
    Text = "Résolution rapide"
  },
  Task_21098_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_21098_Name = {
    Text = "Résolution rapide"
  },
  Task_21099_Desc = {
    Text = "Transportez au moins 1 Relique maudite à l'achèvement."
  },
  Task_21099_Name = {
    Text = "Planque secrète"
  },
  Task_21100_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_21100_Name = {
    Text = "Élégant et précis"
  },
  Task_21101_Desc = {
    Text = "Vaincre au moins 2 monstres en un round de n'importe quelle bataille"
  },
  Task_21101_Name = {
    Text = "Racine et tige"
  },
  Task_21102_Desc = {
    Text = "Transportez au moins 8 Reliques à l'achèvement."
  },
  Task_21102_Name = {
    Text = "Planque secrète"
  },
  Task_21103_Desc = {
    Text = "Avoir pas plus de 1 Carte de Symptôme lors de l'achèvement"
  },
  Task_21103_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_21104_Desc = {
    Text = "Jouer au moins 5 Cartes en un tour lors de la Bataille Finale."
  },
  Task_21104_Name = {Text = "Mon tour !"},
  Task_21105_Desc = {
    Text = "Infliger au moins 300 points de dégâts en un seul tour pendant la Bataille Finale"
  },
  Task_21105_Name = {
    Text = "Attaque totale"
  },
  Task_21106_Desc = {
    Text = "Piger au moins 3 cartes supplémentaires en un tour pendant la Bataille Finale"
  },
  Task_21106_Name = {Text = "Draw!"},
  Task_21107_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21107_Name = {
    Text = "Passer Parfait"
  },
  Task_21108_Desc = {
    Text = "Causer au moins 96000 points de dégâts en un tour dans la bataille finale"
  },
  Task_21108_Name = {
    Text = "Attaque totale"
  },
  Task_21110_Desc = {
    Text = "Avoir pas plus de 2 Cartes de Symptômes lors de l'achèvement"
  },
  Task_21110_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_21111_Desc = {
    Text = "Avoir pas plus de 1 Carte de Symptôme lors de l'achèvement"
  },
  Task_21111_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_21112_Desc = {
    Text = "Vaincre au moins 2 monstres en un round de n'importe quelle bataille"
  },
  Task_21112_Name = {
    Text = "Racine et tige"
  },
  Task_21113_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21113_Name = {
    Text = "Passer Parfait"
  },
  Task_21114_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21114_Name = {
    Text = "Résolution rapide"
  },
  Task_21115_Desc = {
    Text = "Avoir pas plus de 2 Cartes de Symptômes lors de l'achèvement"
  },
  Task_21115_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_21116_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 80%"
  },
  Task_21116_Name = {
    Text = "Élégant et précis"
  },
  Task_21117_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21117_Name = {
    Text = "Passer Parfait"
  },
  Task_21118_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_21118_Name = {
    Text = "Résolution rapide"
  },
  Task_21119_Desc = {
    Text = "Avoir pas plus de 1 Carte de Symptôme lors de l'achèvement"
  },
  Task_21119_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_21120_Desc = {
    Text = "Vaincre au moins 2 monstres en un round de n'importe quelle bataille"
  },
  Task_21120_Name = {
    Text = "Racine et tige"
  },
  Task_21121_Desc = {
    Text = "Avoir pas plus de 2 Cartes de Symptômes lors de l'achèvement"
  },
  Task_21121_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_21122_Desc = {
    Text = "Infliger au moins 1600 points de dégâts en un seul tour pendant une bataille d'élite."
  },
  Task_21122_Name = {
    Text = "Attaque totale"
  },
  Task_21123_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21123_Name = {
    Text = "Résolution rapide"
  },
  Task_21124_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21124_Name = {
    Text = "Passer Parfait"
  },
  Task_21125_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21125_Name = {
    Text = "Passer Parfait"
  },
  Task_21126_Desc = {
    Text = "Utilisez Exalt au moins 3 fois en un seul tour lors d'une bataille d'élite."
  },
  Task_21126_Name = {
    Text = "Magie mortelle"
  },
  Task_21127_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_21127_Name = {
    Text = "Résolution rapide"
  },
  Task_21128_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21128_Name = {
    Text = "Passer Parfait"
  },
  Task_21129_Desc = {
    Text = "Avoir pas plus de 1 Carte de Symptôme lors de l'achèvement"
  },
  Task_21129_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_21130_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21130_Name = {
    Text = "Passer Parfait"
  },
  Task_21131_Desc = {
    Text = "Réveillez tous les Réveilleurs à l'achèvement"
  },
  Task_21131_Name = {
    Text = "Étreinte infinie"
  },
  Task_21132_Desc = {
    Text = "Infliger au moins 6000 points de dégâts en un seul tour pendant la Bataille Finale"
  },
  Task_21132_Name = {
    Text = "Attaque totale"
  },
  Task_21133_Desc = {
    Text = "Piger au moins 5 cartes supplémentaires en un tour pendant la Bataille Finale"
  },
  Task_21133_Name = {Text = "Draw!"},
  Task_21134_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21134_Name = {
    Text = "Passer Parfait"
  },
  Task_21135_Desc = {
    Text = "Piger au moins 4 cartes supplémentaires en un tour pendant la Bataille Finale"
  },
  Task_21135_Name = {Text = "Draw!"},
  Task_21136_Desc = {
    Text = "Gagner la Bataille Finale en moins de 15 tours"
  },
  Task_21136_Name = {
    Text = "Résolution rapide"
  },
  Task_21137_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_21137_Name = {
    Text = "Résolution rapide"
  },
  Task_21138_Desc = {
    Text = "Infliger au moins 1800 points de dégâts en un seul tour pendant une bataille d'élite."
  },
  Task_21138_Name = {
    Text = "Attaque totale"
  },
  Task_21139_Desc = {
    Text = "Transportez au moins 1 Relique maudite à l'achèvement."
  },
  Task_21139_Name = {
    Text = "Planque secrète"
  },
  Task_21140_Desc = {
    Text = "Jouer au moins 5 Cartes en un tour lors de la Bataille Finale."
  },
  Task_21140_Name = {Text = "Mon tour !"},
  Task_21141_Desc = {
    Text = "Lors d'un tour de la bataille finale, empilez un bouclier équivalent à au moins 65% de la santé maximale."
  },
  Task_21141_Name = {Text = "Ironclad"},
  Task_21142_Desc = {
    Text = "Avoir pas plus de 2 Cartes de Symptômes lors de l'achèvement"
  },
  Task_21142_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_21143_Desc = {
    Text = "Gagnez au moins 4 types différents d'Oraisons"
  },
  Task_21143_Name = {
    Text = "Marque de l'Âme"
  },
  Task_21144_Desc = {
    Text = "Transportez au moins 2 Reliques à l'achèvement"
  },
  Task_21144_Name = {
    Text = "Planque secrète"
  },
  Task_21145_Desc = {
    Text = "Utilisez Jonction pour la Récupération de Vie pas plus d'une fois."
  },
  Task_21145_Name = {
    Text = "Les non-illuminés"
  },
  Task_21146_Desc = {
    Text = "Transportez au moins 1 Relique maudite à l'achèvement."
  },
  Task_21146_Name = {
    Text = "Planque secrète"
  },
  Task_21147_Desc = {
    Text = "Avoir pas plus de 2 Cartes de Symptômes lors de l'achèvement"
  },
  Task_21147_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_21148_Desc = {
    Text = "Infliger au moins 500 points de dégâts en un seul tour pendant une bataille d'élite."
  },
  Task_21148_Name = {
    Text = "Attaque totale"
  },
  Task_21149_Desc = {
    Text = "Vaincre au moins 2 monstres en un round de n'importe quelle bataille"
  },
  Task_21149_Name = {
    Text = "Racine et tige"
  },
  Task_21150_Desc = {
    Text = "Réveillez au moins 3 Réveilleurs"
  },
  Task_21150_Name = {
    Text = "Étreinte infinie"
  },
  Task_21151_Desc = {
    Text = "Gagnez au moins 4 types différents d'Oraisons"
  },
  Task_21151_Name = {
    Text = "Marque de l'Âme"
  },
  Task_21152_Desc = {
    Text = "La progression de l'exploration atteint 100 %"
  },
  Task_21152_Name = {
    Text = "Surplomber le royaume de brouillard"
  },
  Task_21153_Desc = {
    Text = "Dans la bataille finale, active Exalter au moins 4 fois en un tour."
  },
  Task_21153_Name = {
    Text = "Magie mortelle"
  },
  Task_21154_Desc = {
    Text = "Avoir pas plus de 2 Cartes de Symptômes lors de l'achèvement"
  },
  Task_21154_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_21155_Desc = {
    Text = "Lors d'un tour de la bataille finale, empilez un bouclier équivalent à au moins 60% de la santé maximale."
  },
  Task_21155_Name = {Text = "Ironclad"},
  Task_21156_Desc = {
    Text = "Transportez au moins 8 Reliques à l'achèvement."
  },
  Task_21156_Name = {
    Text = "Planque secrète"
  },
  Task_21157_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_21157_Name = {
    Text = "Élégant et précis"
  },
  Task_21158_Desc = {
    Text = "Piger au moins 4 cartes supplémentaires en un tour pendant la Bataille Finale"
  },
  Task_21158_Name = {Text = "Draw!"},
  Task_21159_Desc = {
    Text = "Causer au moins 5200 points de dégâts en un tour dans la bataille finale"
  },
  Task_21159_Name = {
    Text = "Attaque totale"
  },
  Task_21160_Desc = {
    Text = "Piger au moins 3 cartes supplémentaires en un tour pendant la Bataille Finale"
  },
  Task_21160_Name = {Text = "Draw!"},
  Task_21161_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21161_Name = {
    Text = "Passer Parfait"
  },
  Task_21162_Desc = {
    Text = "Lors d'un tour de la bataille finale, empilez un bouclier équivalent à au moins 65% de la santé maximale."
  },
  Task_21162_Name = {Text = "Ironclad"},
  Task_21163_Desc = {
    Text = "Avoir pas plus de 2 Cartes de Symptômes lors de l'achèvement"
  },
  Task_21163_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_21164_Desc = {
    Text = "Transportez au moins 1 Relique maudite à l'achèvement."
  },
  Task_21164_Name = {
    Text = "Planque secrète"
  },
  Task_21165_Desc = {
    Text = "Jouer au moins 4 Cartes en un tour lors de la Bataille Finale"
  },
  Task_21165_Name = {Text = "Mon tour !"},
  Task_21166_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21166_Name = {
    Text = "Passer Parfait"
  },
  Task_21167_Desc = {
    Text = "Posséder 4 types différents d'Oraison"
  },
  Task_21167_Name = {
    Text = "Marque de l'Âme"
  },
  Task_21168_Desc = {
    Text = "Infligez 120 Dégâts en un tour lors de la bataille finale"
  },
  Task_21168_Name = {
    Text = "Attaque totale"
  },
  Task_21169_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_21169_Name = {
    Text = "Élégant et précis"
  },
  Task_21170_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_21170_Name = {
    Text = "Élégant et précis"
  },
  Task_21171_Desc = {
    Text = "Vaincre au moins 2 monstres en un round de n'importe quelle bataille"
  },
  Task_21171_Name = {
    Text = "Racine et tige"
  },
  Task_21172_Desc = {
    Text = "Piger au moins 3 cartes supplémentaires en un tour pendant la Bataille Finale"
  },
  Task_21172_Name = {Text = "Draw!"},
  Task_21173_Desc = {
    Text = "Réveillez au moins 3 Réveilleurs"
  },
  Task_21173_Name = {
    Text = "Étreinte infinie"
  },
  Task_21174_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_21174_Name = {
    Text = "Élégant et précis"
  },
  Task_21176_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21176_Name = {
    Text = "Résolution rapide"
  },
  Task_21177_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21177_Name = {
    Text = "Résolution rapide"
  },
  Task_21178_Desc = {
    Text = "Avoir pas plus de 2 Cartes de Symptômes lors de l'achèvement"
  },
  Task_21178_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_21179_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21179_Name = {
    Text = "Passer Parfait"
  },
  Task_21180_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21180_Name = {
    Text = "Passer Parfait"
  },
  Task_21181_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21181_Name = {
    Text = "Passer Parfait"
  },
  Task_21182_Desc = {
    Text = "Avoir pas plus de 1 Carte de Symptôme lors de l'achèvement"
  },
  Task_21182_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_21183_Desc = {
    Text = "Avoir pas plus de 2 Cartes de Symptômes lors de l'achèvement"
  },
  Task_21183_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_21184_Desc = {
    Text = "La progression de l'exploration atteint 100 %"
  },
  Task_21184_Name = {
    Text = "Surplomber le royaume de brouillard"
  },
  Task_21185_Desc = {
    Text = "Infliger au moins 1000 points de dégâts en un seul tour pendant la Bataille Finale"
  },
  Task_21185_Name = {
    Text = "Attaque totale"
  },
  Task_21186_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21186_Name = {
    Text = "Résolution rapide"
  },
  Task_21187_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_21187_Name = {
    Text = "Résolution rapide"
  },
  Task_21188_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_21188_Name = {
    Text = "Résolution rapide"
  },
  Task_21189_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21189_Name = {
    Text = "Résolution rapide"
  },
  Task_21190_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21190_Name = {
    Text = "Résolution rapide"
  },
  Task_21191_Desc = {
    Text = "Avoir pas plus de 1 Carte de Symptôme lors de l'achèvement"
  },
  Task_21191_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_21192_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_21192_Name = {
    Text = "Résolution rapide"
  },
  Task_21193_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_21193_Name = {
    Text = "Résolution rapide"
  },
  Task_21194_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_21194_Name = {
    Text = "Résolution rapide"
  },
  Task_21195_Desc = {
    Text = "Causer au moins 7300 points de dégâts en un tour dans la bataille finale"
  },
  Task_21195_Name = {
    Text = "Attaque totale"
  },
  Task_21196_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_21196_Name = {
    Text = "Résolution rapide"
  },
  Task_21197_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_21197_Name = {
    Text = "Élégant et précis"
  },
  Task_21198_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21198_Name = {
    Text = "Résolution rapide"
  },
  Task_21199_Desc = {
    Text = "Jouer au moins 4 Cartes en un tour lors de la Bataille Finale"
  },
  Task_21199_Name = {Text = "Mon tour !"},
  Task_21200_Desc = {
    Text = "Avoir pas plus de 3 Cartes de Symptômes lors de l'achèvement"
  },
  Task_21200_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_21201_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21201_Name = {
    Text = "Passer Parfait"
  },
  Task_21202_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21202_Name = {
    Text = "Passer Parfait"
  },
  Task_21203_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21203_Name = {
    Text = "Passer Parfait"
  },
  Task_21204_Desc = {
    Text = "Transportez au moins 2 Reliques à l'achèvement"
  },
  Task_21204_Name = {
    Text = "Planque secrète"
  },
  Task_21205_Desc = {
    Text = "Avoir pas plus de 2 Cartes de Symptômes lors de l'achèvement"
  },
  Task_21205_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_21206_Desc = {
    Text = "Gagnez au moins 3 types d'Oraison"
  },
  Task_21206_Name = {
    Text = "Marque de l'Âme"
  },
  Task_21207_Desc = {
    Text = "Réveillez au moins 2 Réveilleurs à l'achèvement"
  },
  Task_21207_Name = {
    Text = "Étreinte infinie"
  },
  Task_21208_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_21208_Name = {
    Text = "Élégant et précis"
  },
  Task_21209_Desc = {
    Text = "Transportez au moins 1 Relique maudite à l'achèvement."
  },
  Task_21209_Name = {
    Text = "Planque secrète"
  },
  Task_21210_Desc = {
    Text = "Jouer au moins 4 Cartes en un tour lors de la Bataille Finale"
  },
  Task_21210_Name = {Text = "Mon tour !"},
  Task_21211_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21211_Name = {
    Text = "Passer Parfait"
  },
  Task_21212_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21212_Name = {
    Text = "Résolution rapide"
  },
  Task_21213_Desc = {
    Text = "Infliger au moins 2500 points de dégâts en un seul tour pendant la Bataille Finale"
  },
  Task_21213_Name = {
    Text = "Attaque totale"
  },
  Task_21214_Desc = {
    Text = "Piger au moins 5 cartes supplémentaires en un tour pendant la Bataille Finale"
  },
  Task_21214_Name = {Text = "Draw!"},
  Task_21215_Desc = {
    Text = "Jouer au moins 6 Cartes en un tour lors de la Bataille Finale"
  },
  Task_21215_Name = {Text = "Mon tour !"},
  Task_21216_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_21216_Name = {
    Text = "Élégant et précis"
  },
  Task_21217_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_21217_Name = {
    Text = "Élégant et précis"
  },
  Task_21218_Desc = {
    Text = "Réveillez tous les Réveilleurs à l'achèvement"
  },
  Task_21218_Name = {
    Text = "Étreinte infinie"
  },
  Task_21219_Desc = {
    Text = "Piger au moins 3 cartes supplémentaires en un tour pendant la Bataille Finale"
  },
  Task_21219_Name = {Text = "Draw!"},
  Task_21220_Desc = {
    Text = "Réveillez au moins 3 Réveilleurs"
  },
  Task_21220_Name = {
    Text = "Étreinte infinie"
  },
  Task_21221_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_21221_Name = {
    Text = "Élégant et précis"
  },
  Task_21222_Desc = {
    Text = "Transportez au moins 1 Relique maudite à l'achèvement."
  },
  Task_21222_Name = {
    Text = "Planque secrète"
  },
  Task_21223_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21223_Name = {
    Text = "Passer Parfait"
  },
  Task_21224_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21224_Name = {
    Text = "Passer Parfait"
  },
  Task_21225_Desc = {
    Text = "Vaincre au moins 2 monstres en un round de n'importe quelle bataille"
  },
  Task_21225_Name = {
    Text = "Racine et tige"
  },
  Task_21226_Desc = {
    Text = "Transportez au moins 2 Reliques à l'achèvement"
  },
  Task_21226_Name = {
    Text = "Planque secrète"
  },
  Task_21227_Desc = {
    Text = "Gagnez au moins 4 types différents d'Oraisons"
  },
  Task_21227_Name = {
    Text = "Marque de l'Âme"
  },
  Task_21228_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21228_Name = {
    Text = "Passer Parfait"
  },
  Task_21229_Desc = {
    Text = "Pas de récupération de Vie depuis la Jonction à la fin"
  },
  Task_21229_Name = {
    Text = "Les non-illuminés"
  },
  Task_21230_Desc = {
    Text = "La progression de l'exploration atteint 100 %"
  },
  Task_21230_Name = {
    Text = "Surplomber le royaume de brouillard"
  },
  Task_21231_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21231_Name = {
    Text = "Résolution rapide"
  },
  Task_21232_Desc = {
    Text = "Utilisez Jonction pour la Récupération de Vie pas plus d'une fois."
  },
  Task_21232_Name = {
    Text = "Les non-illuminés"
  },
  Task_21233_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21233_Name = {
    Text = "Passer Parfait"
  },
  Task_21234_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21234_Name = {
    Text = "Passer Parfait"
  },
  Task_21235_Desc = {
    Text = "Piger au moins 4 cartes supplémentaires en un tour pendant la Bataille Finale"
  },
  Task_21235_Name = {Text = "Draw!"},
  Task_21236_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21236_Name = {
    Text = "Résolution rapide"
  },
  Task_21237_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21237_Name = {
    Text = "Résolution rapide"
  },
  Task_21238_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21238_Name = {
    Text = "Passer Parfait"
  },
  Task_21239_Desc = {
    Text = "Dans la bataille finale, active Exalter au moins 3 fois en un tour."
  },
  Task_21239_Name = {
    Text = "Magie mortelle"
  },
  Task_21240_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21240_Name = {
    Text = "Passer Parfait"
  },
  Task_21241_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21241_Name = {
    Text = "Passer Parfait"
  },
  Task_21242_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 80%"
  },
  Task_21242_Name = {
    Text = "Élégant et précis"
  },
  Task_21243_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21243_Name = {
    Text = "Résolution rapide"
  },
  Task_21244_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21244_Name = {
    Text = "Résolution rapide"
  },
  Task_21245_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21245_Name = {
    Text = "Résolution rapide"
  },
  Task_21246_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21246_Name = {
    Text = "Résolution rapide"
  },
  Task_21247_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21247_Name = {
    Text = "Résolution rapide"
  },
  Task_21248_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21248_Name = {
    Text = "Résolution rapide"
  },
  Task_21249_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21249_Name = {
    Text = "Résolution rapide"
  },
  Task_21250_Desc = {
    Text = "Gagner la Bataille Finale en moins de 15 tours"
  },
  Task_21250_Name = {
    Text = "Résolution rapide"
  },
  Task_21251_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21251_Name = {
    Text = "Résolution rapide"
  },
  Task_21252_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21252_Name = {
    Text = "Résolution rapide"
  },
  Task_21253_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21253_Name = {
    Text = "Résolution rapide"
  },
  Task_21254_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_21254_Name = {
    Text = "Élégant et précis"
  },
  Task_21255_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21255_Name = {
    Text = "Résolution rapide"
  },
  Task_21256_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21256_Name = {
    Text = "Résolution rapide"
  },
  Task_21257_Desc = {
    Text = "Infliger au moins 6000 points de dégâts en un seul tour pendant une bataille d'élite."
  },
  Task_21257_Name = {
    Text = "Attaque totale"
  },
  Task_21258_Desc = {
    Text = "Transportez au moins 1 Relique maudite à l'achèvement."
  },
  Task_21258_Name = {
    Text = "Planque secrète"
  },
  Task_21259_Desc = {
    Text = "Jouer au moins 5 Cartes en un tour lors de la Bataille Finale."
  },
  Task_21259_Name = {Text = "Mon tour !"},
  Task_21260_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21260_Name = {
    Text = "Passer Parfait"
  },
  Task_21261_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21261_Name = {
    Text = "Passer Parfait"
  },
  Task_21262_Desc = {
    Text = "Gagnez au moins 4 types différents d'Oraisons"
  },
  Task_21262_Name = {
    Text = "Marque de l'Âme"
  },
  Task_21263_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21263_Name = {
    Text = "Passer Parfait"
  },
  Task_21264_Desc = {
    Text = "Transportez au moins 2 Reliques à l'achèvement"
  },
  Task_21264_Name = {
    Text = "Planque secrète"
  },
  Task_21265_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21265_Name = {
    Text = "Résolution rapide"
  },
  Task_21266_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21266_Name = {
    Text = "Passer Parfait"
  },
  Task_21267_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21267_Name = {
    Text = "Passer Parfait"
  },
  Task_21268_Desc = {
    Text = "Réveillez au moins 3 Réveilleurs"
  },
  Task_21268_Name = {
    Text = "Étreinte infinie"
  },
  Task_21269_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21269_Name = {
    Text = "Passer Parfait"
  },
  Task_21270_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21270_Name = {
    Text = "Résolution rapide"
  },
  Task_21271_Desc = {
    Text = "Transportez au moins 5 Reliques à l'achèvement"
  },
  Task_21271_Name = {
    Text = "Planque secrète"
  },
  Task_21272_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21272_Name = {
    Text = "Résolution rapide"
  },
  Task_21273_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_21273_Name = {
    Text = "Résolution rapide"
  },
  Task_21274_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21274_Name = {
    Text = "Passer Parfait"
  },
  Task_21275_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_21275_Name = {
    Text = "Résolution rapide"
  },
  Task_21276_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21276_Name = {
    Text = "Passer Parfait"
  },
  Task_21277_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21277_Name = {
    Text = "Résolution rapide"
  },
  Task_21278_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21278_Name = {
    Text = "Passer Parfait"
  },
  Task_21279_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21279_Name = {
    Text = "Passer Parfait"
  },
  Task_21280_Desc = {
    Text = "Réveillez tous les Réveilleurs à l'achèvement"
  },
  Task_21280_Name = {
    Text = "Étreinte infinie"
  },
  Task_21281_Desc = {
    Text = "Avoir pas plus de 2 Cartes de Symptômes lors de l'achèvement"
  },
  Task_21281_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_21282_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21282_Name = {
    Text = "Passer Parfait"
  },
  Task_21283_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21283_Name = {
    Text = "Passer Parfait"
  },
  Task_21284_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21284_Name = {
    Text = "Passer Parfait"
  },
  Task_21285_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21285_Name = {
    Text = "Passer Parfait"
  },
  Task_21286_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21286_Name = {
    Text = "Passer Parfait"
  },
  Task_21287_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21287_Name = {
    Text = "Passer Parfait"
  },
  Task_21288_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21288_Name = {
    Text = "Passer Parfait"
  },
  Task_21289_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21289_Name = {
    Text = "Passer Parfait"
  },
  Task_21290_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21290_Name = {
    Text = "Passer Parfait"
  },
  Task_21291_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21291_Name = {
    Text = "Passer Parfait"
  },
  Task_21292_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21292_Name = {
    Text = "Passer Parfait"
  },
  Task_21293_Desc = {
    Text = "Gagner la Bataille Finale en moins de 15 tours"
  },
  Task_21293_Name = {
    Text = "Résolution rapide"
  },
  Task_21294_Desc = {
    Text = "Lors d'un tour de la bataille finale, empilez un bouclier équivalent à au moins 60% de la santé maximale."
  },
  Task_21294_Name = {Text = "Ironclad"},
  Task_21295_Desc = {
    Text = "Réveillez tous les Réveilleurs à l'achèvement"
  },
  Task_21295_Name = {
    Text = "Étreinte infinie"
  },
  Task_21296_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_21296_Name = {
    Text = "Élégant et précis"
  },
  Task_21297_Desc = {
    Text = "Piger au moins 4 cartes supplémentaires en un tour pendant la Bataille Finale"
  },
  Task_21297_Name = {Text = "Draw!"},
  Task_21298_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_21298_Name = {
    Text = "Résolution rapide"
  },
  Task_21299_Desc = {
    Text = "Gagner la Bataille Finale en moins de 15 tours"
  },
  Task_21299_Name = {
    Text = "Résolution rapide"
  },
  Task_21300_Desc = {
    Text = "Craquement, craquement... !!"
  },
  Task_21300_Name = {Text = "Craquement"},
  Task_21301_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_21301_Name = {
    Text = "Passer Parfait"
  },
  Task_21401_Desc = {
    Text = "Jouer 50 Cartes"
  },
  Task_21401_Name = {
    Text = "Entraînement quotidien"
  },
  Task_21794_Desc = {
    Text = "Connecte-toi pendant 3 jours cumulés"
  },
  Task_21795_Desc = {
    Text = "Connectez-vous pendant un total de 7 jours"
  },
  Task_21821_Desc = {
    Text = "Score de départ : 40 points. Après 3 tours, déduisez 5 points par tour."
  },
  Task_21821_Name = {
    Text = "Rondes Élite  <size=20><color=#747474>Commencez avec 40 points, perdez 5 points par round après le 3ème round</color></size>"
  },
  Task_21822_Desc = {
    Text = "Score de départ : 40 points. Pour chaque étape au-delà de 40 étapes, 2 points seront déduits."
  },
  Task_21822_Name = {
    Text = "Total des Étapes <size=20><color=#747474>Commencez avec 40 points, chaque étape au-delà de 40 déduit 2 points</color></size>"
  },
  Task_21823_Desc = {
    Text = "Commencer avec 600 points, perdre 60 points par tour après 12 tours."
  },
  Task_21823_Name = {
    Text = "Tours de la bataille finale <size=20><color=#747474>Commence à 600 points, déduisant 60 points par tour après 12 tours</color></size>"
  },
  Task_21824_Desc = {
    Text = "Score initial de 30 par match, déduisant 3 points par tour après 2 tours."
  },
  Task_21824_Name = {
    Text = "Tours de bataille <size=20><color=#747474>Commence avec 30 points par match, perd 3 points par tour après 2 tours</color></size>"
  },
  Task_21907_Desc = {
    Text = "Réveillez 50 fois au total"
  },
  Task_21908_Desc = {
    Text = "Accumulatez 300 Réveils"
  },
  Task_21914_Desc = {
    Text = "Atteindre le Niveau d'Investigation 40"
  },
  Task_21915_Desc = {
    Text = "Complétez \"Opération d'Investigation\" Chapitre 1"
  },
  Task_21916_Desc = {
    Text = "Atteignez le niveau d'investigation 30"
  },
  Task_21917_Desc = {
    Text = "Le niveau d'enquête atteint le niveau 20"
  },
  Task_21918_Desc = {
    Text = "Atteignez le niveau d'investigation 50"
  },
  Task_22347_Desc = {
    Text = "Vaincre Uvhash"
  },
  Task_22347_Name = {Text = "Objectif"},
  Task_22348_Desc = {
    Text = "Augustus le Régulateur d'Impulsio"
  },
  Task_22348_Name = {Text = "Objectif"},
  Task_22349_Desc = {
    Text = "Protéger la Princesse"
  },
  Task_22349_Name = {Text = "Objectif"},
  Task_22350_Desc = {
    Text = "Arrêter August"
  },
  Task_22350_Name = {Text = "Objectif"},
  Task_22351_Desc = {
    Text = "Trouvez Agrippa"
  },
  Task_22351_Name = {Text = "Objectif"},
  Task_22352_Desc = {
    Text = "Esquive la tempête de sable"
  },
  Task_22352_Name = {Text = "Objectif"},
  Task_22353_Desc = {
    Text = "Protéger Erica"
  },
  Task_22353_Name = {Text = "Objectif"},
  Task_22354_Desc = {
    Text = "Trouvez Erica"
  },
  Task_22354_Name = {Text = "Objectif"},
  Task_22355_Desc = {
    Text = ": Suivre Uvhash"
  },
  Task_22355_Name = {Text = "Objectif"},
  Task_22356_Desc = {
    Text = "Repoussez les esclaves enragés"
  },
  Task_22356_Name = {Text = "Objectif"},
  Task_22358_Desc = {
    Text = "Accorde un bouclier égal à 50% de la santé maximale"
  },
  Task_22358_Name = {
    Text = "Protection de la Vie II"
  },
  Task_22359_Desc = {
    Text = "Accorde un bouclier égal à 30% de la santé maximale"
  },
  Task_22359_Name = {
    Text = "Gardien de Vie I"
  },
  Task_22380_Desc = {
    Text = "Trouvez 10 points d'extraction dans le Chapitre 5 de l'intrigue principale \"@1@2\""
  },
  Task_22380_Desc2 = {
    Text = "Trouvez 10 points d'extraction dans l'histoire principale Chapitre 5 \"Œil de Tempête\""
  },
  Task_22380_Name = {Text = "@2@3"},
  Task_22380_Name2 = {
    Text = "Chuchotements dans les Ombres V"
  },
  Task_22381_Desc = {
    Text = "Compléter 600 Gorges de Schwarzschild"
  },
  Task_22381_Name = {
    Text = "Horizon déformé V"
  },
  Task_22382_Desc = {
    Text = "Terminez 100 Gorges de Schwarzschild"
  },
  Task_22382_Name = {
    Text = "Vision déformée II"
  },
  Task_22383_Desc = {
    Text = "Compléter 50 courses de la Gorge de Schwarzschild"
  },
  Task_22383_Name = {
    Text = "Vision déformée"
  },
  Task_22384_Desc = {
    Text = "Terminez 400 courses de Gorges de Schwarzschild"
  },
  Task_22384_Name = {
    Text = "Vision déformée IV"
  },
  Task_22385_Desc = {
    Text = "Terminez 200 Gorges de Schwarzschild"
  },
  Task_22385_Name = {
    Text = "Vision déformée III"
  },
  Task_22387_Desc = {
    Text = "Compléter l'événement d'investigation \"@1@2\""
  },
  Task_22387_Desc2 = {
    Text = "Complete Investigation Event \"Storm Eye\""
  },
  Task_22387_Name = {Text = "@2@3"},
  Task_22387_Name2 = {
    Text = "Le triangle perdu"
  },
  Task_22388_Desc = {
    Text = "Résonner 3 fois dans l'enquête sur l'événement «@1@2»"
  },
  Task_22388_Desc2 = {
    Text = "Dans l'événement d'enquête \"Œil de Tempête\", résonnez 3 fois"
  },
  Task_22388_Name = {Text = "@2@3"},
  Task_22388_Name2 = {
    Text = "Écho de désespoir"
  },
  Task_22389_Desc = {
    Text = "Compléter l'Événement d'Investigation « Œil de Tempête » en Difficile"
  },
  Task_22389_Name = {
    Text = "Triangle Perdu·Difficile"
  },
  Task_22390_Desc = {
    Text = "Résonnez 7 fois dans l'événement d'investigation \"@1@2\""
  },
  Task_22390_Desc2 = {
    Text = "Dans l'événement d'enquête \"Œil de Tempête\", résonnez 7 fois"
  },
  Task_22390_Name = {Text = "@2@3"},
  Task_22390_Name2 = {
    Text = "Écho de Désespoir III"
  },
  Task_22391_Desc = {
    Text = "Résonner 6 fois dans l'enquête sur l'événement «@1@2»"
  },
  Task_22391_Desc2 = {
    Text = "Dans l'événement d'enquête \"Œil de Tempête\", résonnez 6 fois"
  },
  Task_22391_Name = {Text = "@2@3"},
  Task_22391_Name2 = {
    Text = "Écho de Désespoir II"
  },
  Task_22392_Desc = {
    Text = "Résonner 10 fois dans l'enquête sur l'événement «@1@2»"
  },
  Task_22392_Desc2 = {
    Text = "Résonner 10 fois dans l'événement d'investigation \"Œil de Tempête\""
  },
  Task_22392_Name = {Text = "@2@3"},
  Task_22392_Name2 = {
    Text = "Échos du Désespoir IV"
  },
  Task_23613_Desc = {
    Text = "Trouvez Jonquille"
  },
  Task_23613_Name = {Text = "Objectif"},
  Task_23614_Desc = {
    Text = "Allez au Grand Magasin"
  },
  Task_23614_Name = {Text = "Objectif"},
  Task_23615_Desc = {
    Text = "Tir Achèvement"
  },
  Task_23615_Name = {Text = "Objectif"},
  Task_23616_Desc = {
    Text = "Retour à la zone d'événement"
  },
  Task_23616_Name = {Text = "Objectif"},
  Task_23617_Desc = {
    Text = "Commencer le Tir"
  },
  Task_23617_Name = {Text = "Objectif"},
  Task_23618_Desc = {
    Text = "Collecte de matériaux"
  },
  Task_23618_Name = {Text = "Objectif"},
  Task_23619_Desc = {
    Text = "Repoussez les ennemis"
  },
  Task_23619_Name = {Text = "Objectif"},
  Task_23620_Desc = {
    Text = "Visiter le Sanatorium"
  },
  Task_23620_Name = {Text = "Objectif"},
  Task_23646_Desc = {
    Text = "Accumulatez 1 000 Réveils"
  },
  Task_23708_Desc = {
    Text = "Piger 5 cartes supplémentaires en un tour pendant la Bataille Finale et gagnez 100 points."
  },
  Task_23708_Name = {
    Text = "Piger à nouveau, piger à nouveau <size=20><color=#747474>Piger 5 cartes supplémentaires par tour pendant la Bataille Finale</color></size>"
  },
  Task_23709_Desc = {
    Text = "Obtenir 5 Reliques Dorées et gagner 100 points."
  },
  Task_23709_Name = {
    Text = "Or Brillant <size=20><color=#747474>Obtenez 5 Reliques en Or</color></size>"
  },
  Task_23710_Desc = {
    Text = "Obtenir 2 Reliques Maudites et gagner 100 points."
  },
  Task_23710_Name = {
    Text = "Trésor secret <size=20><color=#747474>Obtenez 2 Reliques Maudites</color></size>"
  },
  Task_23711_Desc = {
    Text = "Jouer 7 Cartes en un tour lors de la Bataille Finale pour gagner 100 points."
  },
  Task_23711_Name = {
    Text = "Mon tour <size=20><color=#747474>Jouez 7 cartes en une seule manche de la Bataille Finale</color></size>"
  },
  Task_23712_Desc = {
    Text = "Réveillez 4 Réveilleurs et gagnez 100 points."
  },
  Task_23712_Name = {
    Text = "Moment de Réveil <size=20><color=#747474>Réveiller 4 Êtres Éveillés</color></size>"
  },
  Task_23713_Desc = {
    Text = "Gagnez 3 Arithmetica supplémentaires en un tour durant la Bataille Finale et gagnez 100 points."
  },
  Task_23713_Name = {
    Text = "Génie Stratégique <size=20><color=#747474>Gagnez 3 Arithmetica en un tour de la bataille finale</color></size>"
  },
  Task_23714_Desc = {
    Text = "Dans la bataille finale, utilise Exalter au moins 3 fois en un tour pour obtenir 100 points."
  },
  Task_23714_Name = {
    Text = "Magie Fatale <size=20><color=#747474>Utilisez Exalt au moins 3 fois en un seul tour pendant la bataille finale</color></size>"
  },
  Task_23715_Desc = {
    Text = "Gagnez 11 oraisons et gagnez 100 points."
  },
  Task_23715_Name = {
    Text = "Pouvoir d'Oraison<size=20><color=#747474>Obtenez 11 Oraisons</color></size>"
  },
  Task_23716_Desc = {
    Text = "Lors d'un tour de la bataille finale, infligez des dégâts équivalents à 50% de la santé maximale du boss et gagnez 100 points."
  },
  Task_23716_Name = {
    Text = "Arrivée de la Saleté <size=20><color=#747474>Infligez plus de 50% de la santé maximale du boss en dégâts en un tour lors du combat final</color></size>"
  },
  Task_23717_Desc = {
    Text = "Obtenir 9 Oraisons différentes et gagner 100 points."
  },
  Task_23717_Name = {
    Text = "Collection d'Oraisons <size=20><color=#747474>Obtenez 9 Oraisons différentes</color></size>"
  },
  Task_23718_Desc = {
    Text = "Lors d'un tour de la bataille finale, gagnez un bouclier équivalent à 80% de la santé maximale et gagnez 100 points."
  },
  Task_23718_Name = {
    Text = "Corps d'acier <size=20><color=#747474>Gagnez un bouclier égal à 80% de la santé max en un tour lors de la bataille finale</color></size>"
  },
  Task_23719_Desc = {
    Text = "Avoir pas moins de 4 Cartes de Symptômes et obtenir 100 points lors de l'achèvement."
  },
  Task_23719_Name = {
    Text = "Maladie terminale <size=20><color=#747474>Avoir au moins 4 cartes Symptôme à la fin</color></size>"
  },
  Task_23720_Desc = {
    Text = "Dans la bataille finale, utilise Exalter à chaque tour pour gagner 100 points."
  },
  Task_23720_Name = {
    Text = "Horror Show <size=20><color=#747474>Bataille finale : utilise exalt à chaque tour</color></size>"
  },
  Task_23721_Desc = {
    Text = "Obtenir 7 Reliques et gagner 100 points."
  },
  Task_23721_Name = {
    Text = "Charge Complète <size=20><color=#747474>Obtenu 7 Relics</color></size>"
  },
  Task_23722_Desc = {
    Text = "Vaincre 4 ennemis en un round de n'importe quel combat et gagner 100 points."
  },
  Task_23722_Name = {
    Text = "Impardonnable <size=20><color=#747474>Vaincre 4 ennemis en un seul tour de bataille</color></size>"
  },
  Task_23789_Desc = {
    Text = "Connectez-vous pendant un total de 30 jours"
  },
  Task_23868_Desc = {
    Text = "Gagner 5 matchs de Traphase"
  },
  Task_23868_Name = {
    Text = "Récompense hebdomadaire"
  },
  Task_23869_Desc = {
    Text = "Atteindre le rang Senior I dans Traphase"
  },
  Task_23873_Desc = {
    Text = "Lors d'un tour de la bataille finale, infligez des dégâts équivalents à 30% de la santé maximale du boss et gagnez 100 points."
  },
  Task_23873_Name = {
    Text = "Arrivée de la Saleté <size=20><color=#747474>Infligez plus de 30% de la santé maximale du boss en dégâts en un tour lors du combat final</color></size>"
  },
  Task_23874_Desc = {
    Text = "Obtenir 5 Reliques Dorées ou Maudites, et gagner 100 points."
  },
  Task_23874_Name = {
    Text = "Bien et Mal <size=20><color=#747474>Obtenez 5 Reliques d'Or ou Maudites, gagnez 100 points</color></size>"
  },
  Task_23875_Desc = {
    Text = "Obtenir 8 Oraisons différentes et gagner 100 points."
  },
  Task_23875_Name = {
    Text = "Collection d'Oraisons <size=20><color=#747474>Collectez 8 Oraisons différentes</color></size>"
  },
  Task_23876_Desc = {
    Text = "Gagnez 10 Oraisons et obtenez 100 points."
  },
  Task_23876_Name = {
    Text = "Pouvoir d'Oraison<size=20><color=#747474>Obtenez 10 Oraisons</color></size>"
  },
  Task_23877_Desc = {
    Text = "Dans la bataille finale, utilise Exalter au moins 4 fois en un tour pour obtenir 100 points"
  },
  Task_23877_Name = {
    Text = "Magie Fatale <size=20><color=#747474>Utilisez Exalt au moins 4 fois en un seul tour pendant la bataille finale</color></size>"
  },
  Task_23878_Desc = {
    Text = "Vaincre 3 ennemis en un round de n'importe quel combat pour gagner 100 points."
  },
  Task_23878_Name = {
    Text = "Impardonnable <size=20><color=#747474>Éliminer 3 ennemis en un tour de n'importe quelle bataille</color></size>"
  },
  Task_23879_Desc = {
    Text = "Obtenir 8 Reliques et gagner 100 points."
  },
  Task_23879_Name = {
    Text = "Charge Complète <size=20><color=#747474>Obtenu 8 Relics</color></size>"
  },
  Task_23885_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_23886_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_23887_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_23888_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_23889_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_23890_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_23891_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_23892_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_23893_Desc = {
    Text = "Complétez \"Descendant Pâle\" en Mode Normal pendant le Vagabond."
  },
  Task_23893_Name = {
    Text = "Récompense de fin de niveau"
  },
  Task_23894_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_23895_Desc = {
    Text = "Compléter le Dossier de Tâche « Ombre dans la Ville Pluvieuse » Mode Normal"
  },
  Task_23895_Name = {
    Text = "Récompense de fin de niveau"
  },
  Task_23896_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_24139_Desc = {
    Text = "Transportez au moins 5 Reliques à l'achèvement"
  },
  Task_24139_Name = {
    Text = "Planque secrète"
  },
  Task_24140_Desc = {
    Text = "Jouer au moins 6 Cartes en un tour lors de la Bataille Finale"
  },
  Task_24140_Name = {Text = "Mon tour !"},
  Task_24141_Desc = {
    Text = "Transportez au moins 5 Reliques à l'achèvement"
  },
  Task_24141_Name = {
    Text = "Planque secrète"
  },
  Task_24142_Desc = {
    Text = "Jouer au moins 6 Cartes en un tour lors de la Bataille Finale"
  },
  Task_24142_Name = {Text = "Mon tour !"},
  Task_24177_Desc = {
    Text = "Échapper de la salle des pouvoirs"
  },
  Task_24177_Name = {Text = "Objectif"},
  Task_24403_Desc = {
    Text = "Poursuivez la voiture suspecte"
  },
  Task_24403_Name = {Text = "Objectif"},
  Task_24404_Desc = {
    Text = "Évitez le regard de \"N\""
  },
  Task_24404_Name = {Text = "Objectif"},
  Task_24405_Desc = {
    Text = "Recherche de l'invitation \"Nom de Rose\""
  },
  Task_24405_Name = {Text = "Objectif"},
  Task_24406_Desc = {
    Text = "Entrez le Domaine Artificiel, retour au jour de l'incident."
  },
  Task_24406_Name = {Text = "Objectif"},
  Task_24407_Desc = {
    Text = "Capturer l'Homme Suspect"
  },
  Task_24407_Name = {Text = "Objectif"},
  Task_24408_Desc = {
    Text = "Rattraper la domestiquer Karen"
  },
  Task_24408_Name = {Text = "Objectif"},
  Task_24409_Desc = {
    Text = "Défendez-vous contre les attaques de l'ombre noire mystérieuse"
  },
  Task_24409_Name = {Text = "Objectif"},
  Task_24410_Desc = {
    Text = "Défendez-vous contre l'attaque des Ombres Masquées"
  },
  Task_24410_Name = {Text = "Objectif"},
  Task_24411_Desc = {
    Text = "Capturer M. Lambert"
  },
  Task_24411_Name = {Text = "Objectif"},
  Task_24412_Desc = {
    Text = "Repoussez les monstres de Dissolution"
  },
  Task_24412_Name = {Text = "Objectif"},
  Task_24457_Desc = {
    Text = "Dans la bataille finale, utilise Exalter au moins 3/4 fois en un tour pour obtenir 50/100 points."
  },
  Task_24457_Name = {
    Text = "Magie Fatale<size=20><color=#747474>Utilisez Exalt au moins 3 fois en un tour de la bataille finale</color></size>"
  },
  Task_24458_Desc = {
    Text = "Obtenir 7/9/11 Oraisons, et gagner 30/60/100 points."
  },
  Task_24458_Name = {
    Text = "Pouvoir d'Oraison<size=20><color=#747474>Obtenez 7 Oraisons</color></size>"
  },
  Task_24459_Desc = {
    Text = "Obtenir 4/5/6 Reliques Dorées et gagner 30/60/100 points."
  },
  Task_24459_Name = {
    Text = "Or Brillant<size=20><color=#747474>Obtenez 5 Reliques en Or</color></size>"
  },
  Task_24460_Desc = {
    Text = "Obtenir 4/5/6 Reliques Dorées et gagner 30/60/100 points."
  },
  Task_24460_Name = {
    Text = "Or Brillant<size=20><color=#747474>Obtenez 4 Reliques en Or</color></size>"
  },
  Task_24461_Desc = {
    Text = "Obtenir 4/5/6 Reliques Dorées ou Maudites et gagner 30/60/100 points."
  },
  Task_24461_Name = {
    Text = "Bien et Mal<size=20><color=#747474>Obtenez 6 Reliques d'Or ou Maudites</color></size>"
  },
  Task_24462_Desc = {
    Text = "Obtenir 4/5/6 Reliques Dorées ou Maudites et gagner 30/60/100 points."
  },
  Task_24462_Name = {
    Text = "Bien et Mal<size=20><color=#747474>Obtenez 4 Reliques d'Or ou Maudites</color></size>"
  },
  Task_24463_Desc = {
    Text = "Obtenir 4/5/6 Reliques Dorées ou Maudites et gagner 30/60/100 points."
  },
  Task_24463_Name = {
    Text = "Bien et Mal<size=20><color=#747474>Obtenez 5 Reliques d'Or ou Maudites</color></size>"
  },
  Task_24464_Desc = {
    Text = "Obtenir 7/9/11 Oraisons, et gagner 30/60/100 points."
  },
  Task_24464_Name = {
    Text = "Pouvoir d'Oraison<size=20><color=#747474>Acquérez 9 Oraisons</color></size>"
  },
  Task_24465_Desc = {
    Text = "Réveillez 3/4 Réveilleurs, gagnez 50/100 points."
  },
  Task_24465_Name = {
    Text = "Réveillez Moment<size=20><color=#747474>Réveillez 3 Réveilleurs</color></size>"
  },
  Task_24466_Desc = {
    Text = "Jouer 5/7/9 Cartes en un tour lors de la Bataille Finale, et gagner 30/60/100 Points."
  },
  Task_24466_Name = {
    Text = "Mon tour <size=20><color=#747474>Jouez 9 cartes en une seule manche de la Bataille Finale</color></size>"
  },
  Task_24467_Desc = {
    Text = "Réveillez 3/4 Réveilleurs, gagnez 50/100 points."
  },
  Task_24467_Name = {
    Text = "Réveillez Moment<size=20><color=#747474>Réveillez 4 Réveilleurs</color></size>"
  },
  Task_24468_Desc = {
    Text = "Dans la bataille finale, utilise Exalter au moins 3/4 fois en un tour pour obtenir 50/100 points."
  },
  Task_24468_Name = {
    Text = "Magie Fatale<size=20><color=#747474>Utilisez Exalt au moins 4 fois en un tour de la bataille finale</color></size>"
  },
  Task_24469_Desc = {
    Text = "Gagnez 2/3/4 Arithmetica supplémentaires en un tour durant la bataille finale et gagnez 30/60/100 points."
  },
  Task_24469_Name = {
    Text = "Génie Stratégique <size=20><color=#747474>Gagnez 2 Arithmetica en un tour de la bataille finale</color></size>"
  },
  Task_24470_Desc = {
    Text = "Gagnez 2/3/4 Arithmetica supplémentaires en un tour durant la bataille finale et gagnez 30/60/100 points."
  },
  Task_24470_Name = {
    Text = "Génie Stratégique <size=20><color=#747474>Gagnez 3 Arithmetica supplémentaires en un tour de la bataille finale</color></size>"
  },
  Task_24471_Desc = {
    Text = "Avoir au moins 3/4 Cartes de Symptômes et obtenir 50/100."
  },
  Task_24471_Name = {
    Text = "Maladie terminale <size=20><color=#747474>Avoir au moins 3 cartes Symptôme à la fin</color></size>"
  },
  Task_24472_Desc = {
    Text = "Avoir au moins 3/4 Cartes de Symptômes et obtenir 50/100."
  },
  Task_24472_Name = {
    Text = "Maladie terminale <size=20><color=#747474>Avoir au moins 4 cartes Symptôme à l'achèvement</color></size>"
  },
  Task_24473_Desc = {
    Text = "Gagnez 2/3/4 Arithmetica supplémentaires en un tour durant la bataille finale et gagnez 30/60/100 points."
  },
  Task_24473_Name = {
    Text = "Cerveau<size=20><color=#747474>Gagne 4 Arithmetica par tour dans la Bataille Finale</color></size>"
  },
  Task_24474_Desc = {
    Text = "Avoir pas plus de 2/1 cartes pour tout Réveilleur, obtenir 50/100."
  },
  Task_24474_Name = {
    Text = "Ignoré <size=20><color=#747474>Complet avec pas plus de 2 cartes pour tous les Éveillés</color></size>"
  },
  Task_24475_Desc = {
    Text = "Dans la bataille finale, utilise Exalter pendant 3/4/5 tours consécutifs pour gagner 30/60/100 points."
  },
  Task_24475_Name = {
    Text = "Horror Show <size=20><color=#747474>Bataille finale : utilise exalt pendant 5 tours consécutifs</color></size>"
  },
  Task_24476_Desc = {
    Text = "Avoir pas plus de 2/1 cartes pour tout Réveilleur, obtenir 50/100."
  },
  Task_24476_Name = {
    Text = "Ignoré <size=20><color=#747474>Complet avec pas plus d'1 carte pour tous les Éveillés</color></size>"
  },
  Task_24477_Desc = {
    Text = "Dans la bataille finale, utilise Exalter pendant 3/4/5 tours consécutifs pour gagner 30/60/100 points."
  },
  Task_24477_Name = {
    Text = "Horror Show <size=20><color=#747474>Bataille finale : utilise exalt pendant 4 tours consécutifs</color></size>"
  },
  Task_24478_Desc = {
    Text = "Obtenir 6/7/8 Reliques et gagner 30/60/100 points."
  },
  Task_24478_Name = {
    Text = "Charge Complète <size=20><color=#747474>Obtenu 7 Relics</color></size>"
  },
  Task_24479_Desc = {
    Text = "Obtenir 6/7/8 Reliques et gagner 30/60/100 points."
  },
  Task_24479_Name = {
    Text = "Charge Complète <size=20><color=#747474>Obtenu 6 Relics</color></size>"
  },
  Task_24480_Desc = {
    Text = "Lors d'un tour de la bataille finale, gagnez un bouclier équivalent à 25%/50%/75% de la santé maximale et gagnez 30/60/100 points."
  },
  Task_24480_Name = {
    Text = "Corps d'acier<size=20><color=#747474>Gagnez un bouclier égal à 25% de la santé max en un tour lors de la bataille finale</color></size>"
  },
  Task_24481_Desc = {
    Text = "Lors d'un tour de la bataille finale, infligez des dégâts équivalents à 20%/30%/40% de la santé maximale du boss et gagnez 30/60/100 points."
  },
  Task_24481_Name = {
    Text = "Arrivée de la Saleté <size=20><color=#747474>Infligez plus de 30% de la santé maximale du boss en dégâts en un tour lors du combat final</color></size>"
  },
  Task_24482_Desc = {
    Text = "Obtenir 6/7/8 Reliques et gagner 30/60/100 points."
  },
  Task_24482_Name = {
    Text = "Charge Complète <size=20><color=#747474>Obtenu 8 Relics</color></size>"
  },
  Task_24483_Desc = {
    Text = "Obtenir 5/7/9 Oraisons différentes et gagner 30/60/100 points."
  },
  Task_24483_Name = {
    Text = "Collection d'Oraisons<size=20><color=#747474>Obtenez 9 Oraisons différentes</color></size>"
  },
  Task_24484_Desc = {
    Text = "Obtenir 5/7/9 Oraisons différentes et gagner 30/60/100 points."
  },
  Task_24484_Name = {
    Text = "Collection d'Oraisons<size=20><color=#747474>Obtenez 5 Oraisons différentes</color></size>"
  },
  Task_24485_Desc = {
    Text = "Obtenir 5/7/9 Oraisons différentes et gagner 30/60/100 points."
  },
  Task_24485_Name = {
    Text = "Collection d'Oraisons<size=20><color=#747474>Collectez 7 Oraisons différentes</color></size>"
  },
  Task_24486_Desc = {
    Text = "Obtenir 4/5/6 Reliques Dorées et gagner 30/60/100 points."
  },
  Task_24486_Name = {
    Text = "Or Brillant<size=20><color=#747474>Obtenez 6 Reliques en Or</color></size>"
  },
  Task_24487_Desc = {
    Text = "Dans la bataille finale, utilise Exalter pendant 3/4/5 tours consécutifs pour gagner 30/60/100 points."
  },
  Task_24487_Name = {
    Text = "Horror Show <size=20><color=#747474>Bataille finale : utilise exalt pendant 3 tours consécutifs</color></size>"
  },
  Task_24488_Desc = {
    Text = "Obtenir 2/3 Reliques Maudites et gagner 50/100 points."
  },
  Task_24488_Name = {
    Text = "Planque Secrète<size=20><color=#747474>Obtenez 3 Reliques Maudites</color></size>"
  },
  Task_24489_Desc = {
    Text = "Obtenir 2/3 Reliques Maudites et gagner 50/100 points."
  },
  Task_24489_Name = {
    Text = "Trésor secret<size=20><color=#747474>Obtenez 2 Reliques Maudites</color></size>"
  },
  Task_24490_Desc = {
    Text = "Lors d'un tour de la bataille finale, gagnez un bouclier équivalent à 25%/50%/75% de la santé maximale et gagnez 30/60/100 points."
  },
  Task_24490_Name = {
    Text = "Corps d'acier<size=20><color=#747474>Gagnez un bouclier égal à 50% de la santé max en un tour lors de la bataille finale</color></size>"
  },
  Task_24491_Desc = {
    Text = "Jouer 5/7/9 Cartes en un tour lors de la Bataille Finale, et gagner 30/60/100 Points."
  },
  Task_24491_Name = {
    Text = "Mon tour <size=20><color=#747474>Jouez 7 cartes en une seule manche durant la Bataille Finale</color></size>"
  },
  Task_24492_Desc = {
    Text = "Obtenir 7/9/11 Oraisons, et gagner 30/60/100 points."
  },
  Task_24492_Name = {
    Text = "Pouvoir d'Oraison<size=20><color=#747474>Obtenez 11 Oraisons</color></size>"
  },
  Task_24493_Desc = {
    Text = "Jouer 5/7/9 Cartes en un tour lors de la Bataille Finale, et gagner 30/60/100 Points."
  },
  Task_24493_Name = {
    Text = "Mon tour <size=20><color=#747474>Joue 5 cartes en un round de la Bataille Finale</color></size>"
  },
  Task_24494_Desc = {
    Text = "Lors d'un tour de la bataille finale, infligez des dégâts équivalents à 20%/30%/40% de la santé maximale du boss et gagnez 30/60/100 points."
  },
  Task_24494_Name = {
    Text = "Arrivée de la Saleté <size=20><color=#747474>Infligez plus de 40% de la santé maximale du boss en dégâts en un tour lors du combat final</color></size>"
  },
  Task_24495_Desc = {
    Text = "Lors d'un tour de la bataille finale, gagnez un bouclier équivalent à 25%/50%/75% de la santé maximale et gagnez 30/60/100 points."
  },
  Task_24495_Name = {
    Text = "Corps d'acier<size=20><color=#747474>Gagnez un bouclier égal à 75% de la santé max en un tour lors de la bataille finale</color></size>"
  },
  Task_24496_Desc = {
    Text = "Lors d'un tour de la bataille finale, infligez des dégâts équivalents à 20%/30%/40% de la santé maximale du boss et gagnez 30/60/100 points."
  },
  Task_24496_Name = {
    Text = "Arrivée de la Saleté <size=20><color=#747474>Infligez plus de 20% de la santé maximale du boss en dégâts en un tour lors du combat final</color></size>"
  },
  Task_24497_Desc = {
    Text = "Vaincre 3/4 ennemis en un round de n'importe quel combat pour gagner 50/100 points."
  },
  Task_24497_Name = {
    Text = "Impardonnable <size=20><color=#747474>Éliminer 4 ennemis en un seul tour de bataille</color></size>"
  },
  Task_24498_Desc = {
    Text = "Piger 4/5/6 cartes supplémentaires en un tour pendant la Bataille Finale et gagnez 30/60/100 points."
  },
  Task_24498_Name = {
    Text = "Piger Encore, Piger Encore <size=20><color=#747474>Piger 5 cartes supplémentaires en un tour pendant la bataille finale</color></size>"
  },
  Task_24499_Desc = {
    Text = "Piger 4/5/6 cartes supplémentaires en un tour pendant la Bataille Finale et gagnez 30/60/100 points."
  },
  Task_24499_Name = {
    Text = "Piger à nouveau, piger à nouveau <size=20><color=#747474>Piger 4 cartes supplémentaires par tour pendant la Bataille Finale</color></size>"
  },
  Task_24500_Desc = {
    Text = "Vaincre 3/4 ennemis en un round de n'importe quel combat pour gagner 50/100 points."
  },
  Task_24500_Name = {
    Text = "Impardonnable <size=20><color=#747474>Vaincre 3 ennemis en un seul tour de bataille</color></size>"
  },
  Task_24501_Desc = {
    Text = "Piger 4/5/6 cartes supplémentaires en un tour pendant la Bataille Finale et gagnez 30/60/100 points."
  },
  Task_24501_Name = {
    Text = "Piger à nouveau, piger à nouveau <size=20><color=#747474>Piger 6 cartes supplémentaires pendant le tour final de bataille</color></size>"
  },
  Task_24534_Desc = {
    Text = "Rattraper Ramona"
  },
  Task_24534_Name = {Text = "Objectif"},
  Task_25013_Desc = {
    Text = "Complétez l'enregistrement spécial \"Ode à la Rose\" en mode normal"
  },
  Task_25013_Name = {
    Text = "Récompense de fin de niveau"
  },
  Task_25014_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_25015_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_25016_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_25017_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_25018_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_25019_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_25020_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_25021_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_25022_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_25023_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_25024_Desc = {
    Text = "Compléter \"Un Pas de Loin\" en mode normal dans l'errance"
  },
  Task_25024_Name = {
    Text = "Récompense de fin de niveau"
  },
  Task_25164_Desc = {
    Text = ": Suivre Ramona"
  },
  Task_25164_Name = {Text = "Objectif"},
  Task_25167_Desc = {
    Text = "Entrez le Manoir Mystérieux"
  },
  Task_25167_Name = {Text = "Objectif"},
  Task_25168_Desc = {
    Text = "Retour à la boîte de Lady Sorel"
  },
  Task_25168_Name = {Text = "Objectif"},
  Task_34729_Desc = {
    Text = "Mystère du script·Ultra"
  },
  Task_34731_Desc = {
    Text = "Mystère du script·Chaos"
  },
  Task_34734_Desc = {
    Text = "Enregistrement de la task force"
  },
  Task_34737_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_34740_Desc = {
    Text = "Mystère du script·Aequor"
  },
  Task_34741_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_34742_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_34743_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_34744_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_34745_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_34746_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_34748_Desc = {
    Text = "Mystère du script·Caro"
  },
  Task_34750_Desc = {
    Text = "Déverrouille après avoir complété toutes les tâches dans le \"Dossier des Opérations Spéciales\""
  },
  Task_34942_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour utiliser le sceau 25 fois cumulativement dans «Mystère du script»"
  },
  Task_34943_Desc = {
    Text = "Accumulatez 50 cartes \"Embryon\" dans \"Script Mystery\"."
  },
  Task_34944_Desc = {
    Text = "Accumulatez 10 rondes Ultra dans \"Script Mystery\""
  },
  Task_34945_Desc = {
    Text = "Accumulez 250 attaques de tentacule dans \"Script Mystery\""
  },
  Task_34946_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter une victoire dans «Mystère du script»"
  },
  Task_34947_Desc = {
    Text = "Utiliser un réveilleur du domaine hyperdimensionnel pour remporter une victoire dans «Mystère du script»"
  },
  Task_34948_Desc = {
    Text = "Accumulez 100 attaques de tentacule dans \"Script Mystery\""
  },
  Task_34949_Desc = {
    Text = "Accumulatez 5 rondes Ultra dans \"Script Mystery\""
  },
  Task_34950_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter une victoire dans «Mystère du script»"
  },
  Task_34951_Desc = {
    Text = "Accumulez 15 cartes \"Embryon\" dans \"Script Mystery\""
  },
  Task_34952_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour utiliser le sceau 10 fois cumulativement dans «Mystère du script»"
  },
  Task_34953_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter une victoire dans «Mystère du script»"
  },
  Task_35262_Desc = {
    Text = "Déverrouille après avoir complété toutes les tâches du royaume \"Mystère de Script\""
  },
  Task_35263_Desc = {
    Text = "Chapitre final"
  },
  Task_35808_Desc = {
    Text = "Consommation cumulée de 500 millions de rose dorée"
  },
  Task_35808_Name = {
    Text = "Spendthrift"
  },
  Task_36141_Desc = {
    Text = "Résonner 6 fois dans l'enquête sur l'événement «@1@2»"
  },
  Task_36141_Desc2 = {
    Text = "Résonner 6 fois dans l'événement d'investigation « Étoiles Tordues »"
  },
  Task_36141_Name = {Text = "@2@3"},
  Task_36141_Name2 = {
    Text = "Écho de Désir II"
  },
  Task_36142_Desc = {
    Text = "Compléter l'événement d'investigation \"@1@2\""
  },
  Task_36142_Desc2 = {
    Text = "Compléter l'Événement d'Investigation \"Étoiles Tordues\""
  },
  Task_36142_Name = {Text = "@2@3"},
  Task_36142_Name2 = {
    Text = "Nier l'appel"
  },
  Task_36143_Desc = {
    Text = "Résonner 3 fois dans l'enquête sur l'événement «@1@2»"
  },
  Task_36143_Desc2 = {
    Text = "Résonner 3 fois dans l'événement d'investigation « Étoiles Tordues »"
  },
  Task_36143_Name = {Text = "@2@3"},
  Task_36143_Name2 = {
    Text = "Écho du désir"
  },
  Task_36144_Desc = {
    Text = "Complète l'Événement d'Investigation \"Étoiles Tordues\" en difficulté Difficile"
  },
  Task_36144_Name = {
    Text = "Refuser l'appel·Difficile"
  },
  Task_36145_Desc = {
    Text = "Résonnez 8 fois dans l'événement d'investigation \"@1@2\""
  },
  Task_36145_Desc2 = {
    Text = "Résonner 8 fois dans l'événement d'investigation « Étoiles Tordues »"
  },
  Task_36145_Name = {Text = "@2@3"},
  Task_36145_Name2 = {
    Text = "Écho de Désir III"
  },
  Task_36155_Desc = {
    Text = "Protéger le capitaine pendant qu'il conduit"
  },
  Task_36155_Name = {Text = "Objectif"},
  Task_36156_Desc = {
    Text = "Entrez la Salle des Puissances"
  },
  Task_36156_Name = {Text = "Objectif"},
  Task_36157_Desc = {
    Text = "Trouvez des compagnons"
  },
  Task_36157_Name = {Text = "Objectif"},
  Task_36158_Desc = {
    Text = "Résister à l'assaut du Marin"
  },
  Task_36158_Name = {Text = "Objectif"},
  Task_36159_Desc = {
    Text = "Approchez-vous de l'«Enfant Saint»"
  },
  Task_36159_Name = {Text = "Objectif"},
  Task_36160_Desc = {
    Text = "Résister à l'attaque"
  },
  Task_36160_Name = {Text = "Objectif"},
  Task_36161_Desc = {
    Text = "Retour dans le cockpit"
  },
  Task_36161_Name = {Text = "Objectif"},
  Task_36162_Desc = {
    Text = "Repoussez les ennemis"
  },
  Task_36162_Name = {Text = "Objectif"},
  Task_36163_Desc = {
    Text = "Tête vers le cockpit"
  },
  Task_36163_Name = {Text = "Objectif"},
  Task_36164_Desc = {
    Text = "Procédez à la Salle des Puissances"
  },
  Task_36164_Name = {Text = "Objectif"},
  Task_36169_Desc = {
    Text = "Allez à la place"
  },
  Task_36169_Name = {Text = "Objectif"},
  Task_36316_Desc = {
    Text = "Avoir pas plus de 2 Cartes de Symptômes lors de l'achèvement"
  },
  Task_36316_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_36317_Desc = {
    Text = "Avoir pas plus de 2 Cartes de Symptômes lors de l'achèvement"
  },
  Task_36317_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_36359_Desc = {
    Text = "Trouvez 10 points d'extraction dans le Chapitre 6 de l'intrigue principale \"@1@2\""
  },
  Task_36359_Desc2 = {
    Text = "Trouvez 10 points d'extraction dans le Chapitre 6 de l'intrigue principale, \"Étoiles Tordues\"."
  },
  Task_36359_Name = {Text = "@2@3"},
  Task_36359_Name2 = {
    Text = "Murmures du caché VI"
  },
  Task_36622_Desc = {
    Text = "Le Villageois Contrôlant la Mutation"
  },
  Task_36622_Name = {Text = "Objectif"},
  Task_36623_Desc = {
    Text = "Tête vers la Chambre de Wanda"
  },
  Task_36623_Name = {Text = "Objectif"},
  Task_36624_Desc = {
    Text = "Repoussez les monstres D-Slime"
  },
  Task_36624_Name = {Text = "Objectif"},
  Task_36842_Desc = {
    Text = "Complétez \"Tout comme d'habitude\" en mode normal dans Le Vagabondage"
  },
  Task_36842_Name = {
    Text = "Récompense de fin de niveau"
  },
  Task_36864_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_36872_Desc = {
    Text = "Chaque utilisation de la Gnose d'Urgence réduit le score d'Investigation de 30 %."
  },
  Task_36872_Name = {
    Text = "Surcharge Mentale  <size=20><color=#747474>Chaque utilisation de Gnose d'Urgence réduit le score d'Investigation de 30%.</color></size>"
  },
  Task_38749_Desc = {
    Text = "Épuisez 180 Menophin"
  },
  Task_38750_Desc = {
    Text = "Utilisez le soutien 3 fois"
  },
  Task_38751_Desc = {
    Text = "Comme tes anciens élèves 10 fois"
  },
  Task_38752_Desc = {
    Text = "Complétez les Épreuves Hebdomadaires"
  },
  Task_38753_Desc = {
    Text = "Exécutez 3 missions"
  },
  Task_38754_Desc = {
    Text = "Complétez toutes les missions d'entraînement"
  },
  Task_38755_Desc = {
    Text = "Obtenez 1 Victoire dans le Plongeon Phantasmal"
  },
  Task_38814_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 1 victoire dans « Cité du lac »"
  },
  Task_38815_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 5 victoires dans « Cité du lac »"
  },
  Task_38816_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 3 victoires dans « Cité du lac »"
  },
  Task_38817_Desc = {
    Text = "Ville dans le Lac · Caro"
  },
  Task_38818_Desc = {
    Text = "Effacez toute Reminiscence dans \"Révélation\""
  },
  Task_38819_Desc = {
    Text = "Clear \"A Segment of Memory\" dans n'importe quelle mémoire"
  },
  Task_38820_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter 5 victoires dans « Cité du lac »"
  },
  Task_38821_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter 3 victoires dans « Cité du lac »"
  },
  Task_38822_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter une victoire dans « Cité du lac »"
  },
  Task_38823_Desc = {
    Text = "Ville dans le Lac · Aequor"
  },
  Task_38824_Desc = {
    Text = "Achever \"Petite Canna\" dans n'importe quelle réminiscence"
  },
  Task_38825_Desc = {
    Text = "Compléter tout Souvenir de \"Le Puits\""
  },
  Task_38826_Desc = {
    Text = "Plongée dans l'inconscient"
  },
  Task_38827_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter 3 victoires dans « Cité du lac »"
  },
  Task_38828_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter 5 victoires dans « Cité du lac »"
  },
  Task_38829_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter une victoire dans « Cité du lac »"
  },
  Task_38830_Desc = {
    Text = "Clair toute réminiscence dans \"Mirage\""
  },
  Task_38831_Desc = {
    Text = "Ville dans le Lac · Chaos"
  },
  Task_38832_Desc = {
    Text = "Complétez \"Réalité\" dans n'importe quel Souvenir"
  },
  Task_38833_Desc = {
    Text = "Cité dans le Lac · Souvenir"
  },
  Task_38834_Desc = {
    Text = "Complétez \"Cité d'Or\" dans n'importe quel Souvenir"
  },
  Task_38835_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter une victoire dans « Cité du lac »"
  },
  Task_38836_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter 5 victoires dans « Cité du lac »"
  },
  Task_38837_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter 3 victoires dans « Cité du lac »"
  },
  Task_38838_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_38839_Desc = {
    Text = "Cité dans le Lac · Ultra"
  },
  Task_38840_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_39279_Desc = {
    Text = "Chaque utilisation d'un esprit d'urgence réduit la note d'enquête de 20 %"
  },
  Task_39279_Name = {
    Text = "Sauvetage Mirage<size=20><color=#747474>Chaque utilisation de la Gnose d'Urgence réduit le score d'Investigation de 20 %.</color></size>"
  },
  Task_40465_Desc = {
    Text = "Déclenchez Résistance à la Mort 1/2/3 fois ou plus pour gagner 100/300/500 points."
  },
  Task_40465_Name = {
    Text = "À la frontière de la Vie et de la Mort<size=20><color=#747474>Déclenche 1 Résistance à la Mort</color></size>"
  },
  Task_40466_Desc = {
    Text = "Déclenchez Résistance à la Mort 1/2/3 fois ou plus pour gagner 100/300/500 points."
  },
  Task_40466_Name = {
    Text = "L'Edge de la Vie et de la Mort<size=20><color=#747474>Déclenche Résistance 3+ fois</color></size>"
  },
  Task_40467_Desc = {
    Text = "Déclenchez Résistance à la Mort 1/2/3 fois ou plus pour gagner 100/300/500 points."
  },
  Task_40467_Name = {
    Text = "L'Edge de la Vie et de la Mort<size=20><color=#747474>Déclenche Résistance à la Mort 2 fois</color></size>"
  },
  Task_40468_Desc = {
    Text = "Obtenir 5/6/7/8 créations, obtenir 250/500/750/1000 points."
  },
  Task_40468_Name = {
    Text = "Collection de réalités <size=20><color=#747474>Possède 5 créations</color></size>"
  },
  Task_40469_Desc = {
    Text = "Obtenir 5/6/7/8 créations, obtenir 250/500/750/1000 points."
  },
  Task_40469_Name = {
    Text = "Collection de réalité<size=20><color=#747474>Possédez 7 Reliques</color></size>"
  },
  Task_40470_Desc = {
    Text = "Posséder 5/6/7/8 créations, obtenir 250/500/750/1000 points."
  },
  Task_40470_Name = {
    Text = "Collection de réalité<size=20><color=#747474>Possédez 6 Reliques</color></size>"
  },
  Task_40471_Desc = {
    Text = [[
Remporter la victoire dans la Bataille Finale en 11/10/9/8 tours au maximum, obtenir 250/500/750/1000
/1000 points.]]
  },
  Task_40471_Name = {
    Text = "Poursuite de Rêves Rapide<size=20><color=#747474>Vaincre le boss en 8 tours</color></size>"
  },
  Task_40472_Desc = {
    Text = [[
Remporter la victoire dans la Bataille Finale en 11/10/9/8 tours maximum, obtenir 250/500/750/1000
/1000 points.]]
  },
  Task_40472_Name = {
    Text = "Poursuite de Rêves Rapide<size=20><color=#747474>Vaincre le boss en 8 tours</color></size>"
  },
  Task_40473_Desc = {
    Text = [[
Remporter la victoire dans la Bataille Finale en 11/10/9/8 tours maximum, obtenir 250/500/750/1000
/1000 points.]]
  },
  Task_40473_Name = {
    Text = "Chasse de Rêves Rapide<size=20><color=#747474>Vaincre le boss en 9 tours</color></size>"
  },
  Task_40474_Desc = {
    Text = [[
Remporter la victoire dans la Bataille Finale en 11/10/9/8 tours, obtenir 250/500/750/1000
/1000 points.]]
  },
  Task_40474_Name = {
    Text = "Frappe de Rêves Rapide<size=20><color=#747474>Vaincre le boss en 10 tours</color></size>"
  },
  Task_40475_Desc = {
    Text = [[
Remporter la victoire dans la Bataille Finale en 11/10/9/8 tours, obtenir 250/500/750/1000
/1000 points.]]
  },
  Task_40475_Name = {
    Text = "Sprint Silencieux<size=20><color=#747474>Vainquez le boss en 11 rounds</color></size>"
  },
  Task_40476_Desc = {
    Text = "Gagner la bataille finale et gagner 1000 points."
  },
  Task_40476_Name = {
    Text = "Victoire dans le Monument du Rêve Final<size=20><color=#747474>Victoire dans le Combat de Boss</color></size>"
  },
  Task_41334_Desc = {
    Text = "Repoussez le boss{s1}"
  },
  Task_41334_Name = {Text = "Objectif"},
  Task_41367_Desc = {
    Text = "Complétez le Chapitre 3 de l' \"Opération d'Investigation\""
  },
  Task_41368_Desc = {
    Text = "Complétez le Chapitre 5 de l' \"Opération d'Investigation\""
  },
  Task_41369_Desc = {
    Text = "Complétez le Chapitre 4 de l' \"Opération d'Investigation\""
  },
  Task_41370_Desc = {
    Text = "Complétez le Chapitre 2 de l' \"Opération d'Investigation\""
  },
  Task_41371_Desc = {
    Text = "Première fois atteignant 325 points d'entraînement"
  },
  Task_41372_Desc = {
    Text = "La Valeur d'Entraînement Spéciale atteint 350 pour la première fois"
  },
  Task_41373_Desc = {
    Text = "La Valeur d'Entraînement Spéciale atteint 225 pour la première fois"
  },
  Task_41374_Desc = {
    Text = "Première fois atteignant 300 points d'entraînement"
  },
  Task_41375_Desc = {
    Text = "Points d'Entraînement atteignent 100 pour la première fois"
  },
  Task_41376_Desc = {
    Text = "Première fois atteignant 150 points d'entraînement"
  },
  Task_41377_Desc = {
    Text = "Première fois atteignant 50 Points d’Entraînement"
  },
  Task_41380_Desc = {
    Text = "Complète toutes les tâches de Souvenir ci-dessus"
  },
  Task_43476_Desc = {
    Text = "Le Gardien atteint le niveau 55"
  },
  Task_43476_Name = {
    Text = "Épreuve du Gardien IV"
  },
  Task_43477_Desc = {
    Text = "Le Gardien atteint le niveau 45"
  },
  Task_43477_Name = {
    Text = "Épreuve du Gardien III"
  },
  Task_43514_Desc = {
    Text = "Repoussez Glen et son groupe"
  },
  Task_43514_Name = {Text = "Objectif"},
  Task_43561_Desc = {
    Text = "Complete Investigation Main Mission Chapter 6 \"Twisted Stars\""
  },
  Task_43562_Desc = {
    Text = "Compléter l'Investigation de la Ligne Principale Chapitre 5 \"Œil de Tempête\""
  },
  Task_43563_Desc = {
    Text = "Complete Investigation Mainline Chapter 3 \"Watch Out for Dogs\""
  },
  Task_43564_Desc = {
    Text = "Compléter la Mission Principale d'Investigation Chapitre 6 « Étoiles Tordues » en Difficile"
  },
  Task_43565_Desc = {
    Text = "Compléter le chapitre principal d'investigation 4 \"En Silence\" à la difficulté Difficile"
  },
  Task_43566_Desc = {
    Text = "Compléter l'Investigation Principale Chapitre 3 « Méfiez-vous des Chiens » en Difficile"
  },
  Task_43567_Desc = {
    Text = "Compléter l'Investigation Principale Chapitre 5 « Œil de Tempête » en difficulté Difficile"
  },
  Task_43568_Desc = {
    Text = "Complétez l'enquête principale Chapitre 4 \"Dans le Silence\""
  },
  Task_43822_Desc = {
    Text = "Posséder un Éveilleur de niveau 80"
  },
  Task_43822_Name = {
    Text = "«Pouvoir transcendant»I"
  },
  Task_43824_Desc = {
    Text = "Dégâts atteignent 250000"
  },
  Task_43824_Name = {
    Text = "La Douleur Insupportable de la Vie IV"
  },
  Task_43825_Desc = {
    Text = "Dégâts atteignent 500000"
  },
  Task_43825_Name = {
    Text = "La Douleur Insupportable de la Vie V"
  },
  Task_43826_Desc = {
    Text = "Dégâts atteignent 50000"
  },
  Task_43826_Name = {
    Text = "La Douleur Insupportable de la Vie II"
  },
  Task_43827_Desc = {
    Text = "Dégâts atteignent 100000"
  },
  Task_43827_Name = {
    Text = "La Douleur Insupportable de la Vie III"
  },
  Task_43828_Desc = {
    Text = "Avoir 3 Réveilleurs au Niveau 80"
  },
  Task_43828_Name = {
    Text = "\"Pouvoir Au-delà\" III"
  },
  Task_43829_Desc = {
    Text = "Avoir 2 Réveilleurs au Niveau 80"
  },
  Task_43829_Name = {
    Text = "\"Pouvoir au-delà\" II"
  },
  Task_43831_Desc = {
    Text = ": Inflige 10000 couches de poison à l'ennemi"
  },
  Task_43831_Name = {
    Text = "Poison de la réalité I"
  },
  Task_43832_Desc = {
    Text = "Terminer \"Souhait du Chevalier\" dans Le Vagabond"
  },
  Task_43832_Name = {
    Text = "Mille et Une Nuits"
  },
  Task_43833_Desc = {
    Text = "Complète \"Banquet en Flammes\" dans Les Errants"
  },
  Task_43833_Name = {
    Text = "Rien de nouveau sous la lune"
  },
  Task_43834_Desc = {
    Text = "Complétez l'enregistrement spécial \"Ode à la Rose\" en difficulté Difficile"
  },
  Task_43834_Name = {
    Text = "Les roses rouges ne se tairont pas · Difficile"
  },
  Task_43835_Desc = {
    Text = "Complétez l'enregistrement spécial \"Magie des Histoires\" en difficulté Difficile"
  },
  Task_43835_Name = {
    Text = "Enfance simple · Difficile"
  },
  Task_43836_Desc = {
    Text = "Complétez l'enregistrement spécial \"Magie des Histoires\""
  },
  Task_43836_Name = {
    Text = "Une enfance ordinaire"
  },
  Task_43837_Desc = {
    Text = "Complétez l'enregistrement spécial \"Ombre de la Ville de Pluie\" en difficulté Difficile"
  },
  Task_43837_Name = {
    Text = "Sorcière de l'Époque · Difficile"
  },
  Task_43838_Desc = {
    Text = "Complétez l'enregistrement spécial \"Ombre de la Ville de Pluie\""
  },
  Task_43838_Name = {
    Text = "Sorcière d'une époque"
  },
  Task_43839_Desc = {
    Text = "Complétez l'enregistrement spécial \"Ode à la Rose\""
  },
  Task_43839_Name = {
    Text = "Les roses rouges ne restent jamais silencieuses"
  },
  Task_43840_Desc = {
    Text = "Bataille 2000 fois dans Traphase"
  },
  Task_43840_Name = {
    Text = "Chevauchement de phase V"
  },
  Task_43843_Desc = {
    Text = "Démonter une Roue de Destinée SSR"
  },
  Task_43843_Name = {
    Text = "Biens matériels"
  },
  Task_43844_Desc = {
    Text = "Roue du Destin empilée 700 fois"
  },
  Task_43844_Name = {
    Text = "Futur de l'Enchevêtrement Quantique I"
  },
  Task_43845_Desc = {
    Text = "Améliorez les Compétences de l'Éveilleur 1 000 fois"
  },
  Task_43845_Name = {
    Text = "«Maîtrise des armes»VIII"
  },
  Task_43846_Desc = {
    Text = "Améliorer les compétences de réveilleur 1100 fois"
  },
  Task_43846_Name = {
    Text = "«Maîtrise des armes»IX"
  },
  Task_43847_Desc = {
    Text = "Améliorez les Compétences de l'Éveilleur 1 200 fois"
  },
  Task_43847_Name = {
    Text = "«Maîtrise des armes»X"
  },
  Task_43849_Desc = {
    Text = "Démonter 100 Roues de Destinée"
  },
  Task_43849_Name = {
    Text = "Curiosité précieuse"
  },
  Task_43850_Desc = {
    Text = "Démonter 200 Roues de Destinée"
  },
  Task_43850_Name = {
    Text = "Joie de la désarticulation"
  },
  Task_43851_Desc = {
    Text = "Démonter 300 Roues de Destinée"
  },
  Task_43851_Name = {
    Text = "L'univers en un mot"
  },
  Task_43863_Desc = {
    Text = "Bataille 1000 fois en Traphase"
  },
  Task_43863_Name = {
    Text = "Chevauchement de phase IV"
  },
  Task_43864_Desc = {
    Text = "Bataille 500 fois dans Traphase"
  },
  Task_43864_Name = {
    Text = "Chevauchement de phase III"
  },
  Task_43866_Desc = {
    Text = "Terminez 100 Plongées Fantasmagoriques"
  },
  Task_43866_Name = {
    Text = "Aventure superficielle"
  },
  Task_43867_Desc = {
    Text = "Bataille 250 fois dans Traphase"
  },
  Task_43867_Name = {
    Text = "Chevauchement de phase II"
  },
  Task_43868_Desc = {
    Text = "Bataille 100 fois dans Traphase"
  },
  Task_43868_Name = {
    Text = "Chevauchement de phase I"
  },
  Task_43869_Desc = {
    Text = "Atteindre le Niveau d'Affinité 10 avec 40 Réveillés"
  },
  Task_43869_Name = {
    Text = "Mes précieuses ailes"
  },
  Task_43873_Desc = {
    Text = "Roue du Destin empilée 600 fois"
  },
  Task_43873_Name = {
    Text = "Destin Entrelacé VI"
  },
  Task_43874_Desc = {
    Text = "Roue du Destin empilée 500 fois"
  },
  Task_43874_Name = {
    Text = "Destin entrelacé V"
  },
  Task_43875_Desc = {
    Text = "Roue du Destin empilée 400 fois"
  },
  Task_43875_Name = {
    Text = "Destins entrelacés IV"
  },
  Task_43876_Desc = {
    Text = "Roue du Destin empilée 300 fois"
  },
  Task_43876_Name = {
    Text = "Destin Entrelacé III"
  },
  Task_43877_Desc = {
    Text = "Roue du Destin empilée 200 fois"
  },
  Task_43877_Name = {
    Text = "Destin entrelacé II"
  },
  Task_43878_Desc = {
    Text = "Roue du Destin empilée 100 fois"
  },
  Task_43878_Name = {
    Text = "Destin entrelacé I"
  },
  Task_43880_Desc = {
    Text = "Activation de Réveil : Illuminer 600 fois"
  },
  Task_43880_Name = {
    Text = "Appel d'au-delà"
  },
  Task_43881_Desc = {
    Text = "Activation de Réveil : Illuminer 500 fois"
  },
  Task_43881_Name = {
    Text = "Fusion de l'Esprit et de la Chair IV"
  },
  Task_43882_Desc = {
    Text = "Activation de Réveil : Illuminer 400 fois"
  },
  Task_43882_Name = {
    Text = "Fusion de l'Esprit et de la Chair III"
  },
  Task_43883_Desc = {
    Text = "Complétez \"Sculpture d'une chanson\" en difficulté Difficile dans Le Vagabondage"
  },
  Task_43883_Name = {
    Text = "Le Secret d'Aleph·Difficile"
  },
  Task_43884_Desc = {
    Text = "Complétez \"Sang et Sable\" en difficulté Difficile dans Le Vagabond"
  },
  Task_43884_Name = {
    Text = "Conte de la Bête·Difficile"
  },
  Task_43885_Desc = {
    Text = "Complétez \"Un pas de distance\" dans Le Vagabondage"
  },
  Task_43885_Name = {
    Text = "Le messager du circuit"
  },
  Task_43886_Desc = {
    Text = "Complétez \"Tout comme d'habitude\" dans le vagabondage"
  },
  Task_43886_Name = {
    Text = "La ville invisible"
  },
  Task_43887_Desc = {
    Text = "Complétez \"Souhait du chevalier\" en difficulté Difficile dans Le Vagabondage"
  },
  Task_43887_Name = {
    Text = "Les Mille et Une Nuits · Difficile"
  },
  Task_43888_Desc = {
    Text = "Complète \"Banquet en Flammes\" à la difficulté Difficile dans Les Errants"
  },
  Task_43888_Name = {
    Text = "Rien de nouveau sous la Lune · Difficile"
  },
  Task_43889_Desc = {
    Text = "Compléter \"Sculpter une Chanson\" dans l'errance"
  },
  Task_43889_Name = {
    Text = "Secret d'aleph"
  },
  Task_43890_Desc = {
    Text = "Complète \"Sang et Sable\" dans Les Errants"
  },
  Task_43890_Name = {
    Text = "Ainsi parla la bête"
  },
  Task_43891_Desc = {
    Text = "Terminez \"Noyau Tordu\" dans le vagabondage"
  },
  Task_43891_Name = {
    Text = "<Do mechanical dolls dream?>"
  },
  Task_43892_Desc = {
    Text = "Complétez \"Progéniture pâle\" dans Le Vagabondage"
  },
  Task_43892_Name = {Text = "Mon Demian"},
  Task_43893_Desc = {
    Text = ": Inflige 25000 couches de poison à l'ennemi"
  },
  Task_43893_Name = {
    Text = "Poison de la réalité II"
  },
  Task_43896_Desc = {
    Text = "Complétez \"Un pas de distance\" en difficulté Difficile dans Le Vagabondage"
  },
  Task_43896_Name = {
    Text = "Messager de Circuit · Difficile"
  },
  Task_43897_Desc = {
    Text = "Effectuer 10 000 cérémonies de réveil"
  },
  Task_43897_Name = {
    Text = "Chanteur de Gnose"
  },
  Task_43898_Desc = {
    Text = "Complétez \"Noyau Tordu\" en difficulté Difficile dans Le Vagabond"
  },
  Task_43898_Name = {
    Text = "Les androïdes rêvent·Difficile"
  },
  Task_43899_Desc = {
    Text = "Consommation cumulée de 100000 le sigil noir"
  },
  Task_43899_Name = {
    Text = "Bienvenue à \"Lumière\" IV"
  },
  Task_43900_Desc = {
    Text = "Consommation cumulée de 50000 le sigil noir"
  },
  Task_43900_Name = {
    Text = "Bienvenue à \"Lumière\" III"
  },
  Task_43901_Desc = {
    Text = "Consommation cumulée de 25000 le sigil noir"
  },
  Task_43901_Name = {
    Text = "Bienvenue«Lumière»II"
  },
  Task_43902_Desc = {
    Text = "Consommation cumulée de 10000 le sigil noir"
  },
  Task_43902_Name = {
    Text = "Bienvenue \"Lumière\" I"
  },
  Task_43903_Desc = {
    Text = "Posséder 100 Pactes de niveau 12"
  },
  Task_43903_Name = {
    Text = "Gardien Tabou III"
  },
  Task_43904_Desc = {
    Text = "Posséder 150 Pactes de niveau 12"
  },
  Task_43904_Name = {
    Text = "Gardien Tabou IV"
  },
  Task_43905_Desc = {
    Text = "Posséder 25 Pactes de niveau 12"
  },
  Task_43905_Name = {
    Text = "Gardien Tabou I"
  },
  Task_43906_Desc = {
    Text = "Posséder 50 Pactes de niveau 12"
  },
  Task_43906_Name = {
    Text = "Gardien Tabou II"
  },
  Task_43907_Desc = {
    Text = "Effectuer 2 500 cérémonies de réveil"
  },
  Task_43907_Name = {
    Text = "Chanteur d'âme II"
  },
  Task_43908_Desc = {
    Text = "Effectuer 5 000 cérémonies de réveil"
  },
  Task_43908_Name = {
    Text = "Chanteur d'âme III"
  },
  Task_43909_Desc = {
    Text = "Effectuez la cérémonie de Réveil 500 fois"
  },
  Task_43909_Name = {
    Text = "Genius Keeper V"
  },
  Task_43910_Desc = {
    Text = "Effectuer 1 000 cérémonies de réveil"
  },
  Task_43910_Name = {
    Text = "Chant de l'âme I"
  },
  Task_43911_Desc = {
    Text = "Complétez \"Descendant Pâle\" en difficulté Difficile dans Le Vagabond"
  },
  Task_43911_Name = {
    Text = "Mon Demian - Difficile"
  },
  Task_43916_Desc = {
    Text = "Change ton avatar plus de 3 fois en une journée"
  },
  Task_43916_Name = {
    Text = "Masqué masqué"
  },
  Task_43917_Desc = {
    Text = "Parlez à l'Awakeur 100 fois dans le dortoir"
  },
  Task_43917_Name = {
    Text = "C'est tout pour aujourd'hui"
  },
  Task_43918_Desc = {
    Text = "Terminez 250 Transcriptions de Pacte"
  },
  Task_43918_Name = {
    Text = "Quelque chose ne va pas"
  },
  Task_43919_Desc = {
    Text = "Complétez 100 Transcriptions de Pacte"
  },
  Task_43919_Name = {
    Text = "Inspiration sans fin"
  },
  Task_43921_Desc = {
    Text = "Compléter 500 Transcriptions de Pacte"
  },
  Task_43921_Name = {
    Text = "Nouvelle révision"
  },
  Task_43923_Desc = {
    Text = "Inflige 10000 dégâts"
  },
  Task_43923_Name = {
    Text = "La Douleur Insupportable de la Vie I"
  },
  Task_43928_Desc = {
    Text = "Atteindre le Niveau d'Affinité 10 avec 30 Réveillés"
  },
  Task_43928_Name = {
    Text = "Anatomie de l'amour"
  },
  Task_43930_Desc = {
    Text = "Atteindre le Niveau d'Affinité 10 avec 16 Réveillés"
  },
  Task_43930_Name = {
    Text = "Dialogue entre cœur et âme"
  },
  Task_43932_Desc = {
    Text = "Atteindre le Niveau d'Affinité 10 avec 20 Corps Réveillés"
  },
  Task_43932_Name = {
    Text = "Lecteur des Âmes"
  },
  Task_43934_Desc = {
    Text = "Déverrouiller la Forme Génèse de Ramona"
  },
  Task_43934_Name = {
    Text = "À côté de la jeune fille"
  },
  Task_43936_Desc = {
    Text = "Atteindre le Niveau d'Affinité 10 avec 12 Réveillés"
  },
  Task_43936_Name = {
    Text = "Éveiller l'âme"
  },
  Task_43937_Desc = {
    Text = "Connexion Cumulative : 300 Jours"
  },
  Task_43937_Name = {
    Text = "Une volonté inébranlable"
  },
  Task_43938_Desc = {
    Text = "Connexion Cumulative pendant 365 Jours"
  },
  Task_43938_Name = {
    Text = "Une nuit étoilée"
  },
  Task_43943_Desc = {
    Text = "Connexion cumulative pendant 120 jours"
  },
  Task_43943_Name = {
    Text = "Une matinée ordinaire"
  },
  Task_43944_Desc = {
    Text = "Connexion cumulative pendant 150 jours"
  },
  Task_43944_Name = {
    Text = "Un café ordinaire"
  },
  Task_43945_Desc = {
    Text = "Connecté pendant un total de 180 jours"
  },
  Task_43945_Name = {
    Text = ": Une conversation simple"
  },
  Task_43946_Desc = {
    Text = "Connexion Cumulative pendant 240 Jours"
  },
  Task_43946_Name = {
    Text = "Un cœur ardent"
  },
  Task_43948_Desc = {
    Text = "Gagnez 30 différentes Roues du Destin"
  },
  Task_43948_Name = {
    Text = "Maître de l'incertitude"
  },
  Task_43949_Desc = {
    Text = "Gagnez 20 différentes Roues du Destin"
  },
  Task_43949_Name = {
    Text = "Apprenti du Destin II"
  },
  Task_43950_Desc = {
    Text = "Gagnez 10 Roues du Destin différentes"
  },
  Task_43950_Name = {
    Text = "Acolyte du Destin I"
  },
  Task_43953_Desc = {
    Text = "Gagnez 40 Roues de Destin différentes"
  },
  Task_43953_Name = {
    Text = "Tisseur de destins"
  },
  Task_43957_Desc = {
    Text = "Utilisez le soutien une fois"
  },
  Task_43957_Name = {
    Text = "Ami dans le besoin"
  },
  Task_43958_Desc = {
    Text = "Modifier message de profil"
  },
  Task_43958_Name = {
    Text = "Bonjour, le monde !"
  },
  Task_43959_Desc = {
    Text = "Recevoir 1000 likes"
  },
  Task_43959_Name = {
    Text = "Quand l'éloge frappe"
  },
  Task_43961_Desc = {
    Text = "Comme 100 fois"
  },
  Task_43961_Name = {
    Text = "Un petit pas vers l'extérieur"
  },
  Task_43962_Desc = {
    Text = "Comme 50 fois"
  },
  Task_43962_Name = {
    Text = "Tentative modeste"
  },
  Task_43964_Desc = {
    Text = "Suivez 100 Anciens élèves remarquables"
  },
  Task_43964_Name = {
    Text = "Lorsque les étoiles s'alignent"
  },
  Task_43965_Desc = {
    Text = "Suivez 1 ancien élève"
  },
  Task_43965_Name = {
    Text = "Quel est ton nom ?"
  },
  Task_43966_Desc = {
    Text = "Total de 500 jours de connexion"
  },
  Task_43966_Name = {
    Text = "Le soleil se lève sur Kadath"
  },
  Task_43967_Desc = {
    Text = "Activez le Réveil Illuminer 60 fois"
  },
  Task_43967_Name = {
    Text = "Réunion des âmes et des cœurs V"
  },
  Task_43968_Desc = {
    Text = "Activez le Réveil Illuminer 100 fois"
  },
  Task_43968_Name = {
    Text = "Attente dans l'ombre"
  },
  Task_43969_Desc = {
    Text = "Activez le Réveil 30 fois avec Illuminer"
  },
  Task_43969_Name = {
    Text = "Réunion de l'Esprit et du Cœur III"
  },
  Task_43970_Desc = {
    Text = "Activation d'Éveilleur : Illuminer 45 fois"
  },
  Task_43970_Name = {
    Text = "La Rencontre de l'Esprit et du Cœur IV"
  },
  Task_43972_Desc = {
    Text = "Activez le Réveil 15 fois avec Illuminer"
  },
  Task_43972_Name = {
    Text = "Rencontre de l'Esprit et du Cœur II"
  },
  Task_43973_Desc = {
    Text = "Avoir 4 Réveilleurs au Niveau 80"
  },
  Task_43973_Name = {
    Text = "\"Pouvoir au-delà\" IV"
  },
  Task_43975_Desc = {
    Text = "Activation de Réveil : Illuminer 200 fois"
  },
  Task_43975_Name = {
    Text = "Fusion de l'Esprit et de la Chair I"
  },
  Task_43976_Desc = {
    Text = "Activation d'Éveilleur : Illuminer 300 fois"
  },
  Task_43976_Name = {
    Text = "Fusion de l'Esprit et de la Chair II"
  },
  Task_44231_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter une victoire dans « Chemin du Santuaire »"
  },
  Task_44232_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter 3 victoires dans « Chemin du Santuaire »"
  },
  Task_44233_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter 2 victoires dans « Chemin du Santuaire »"
  },
  Task_44234_Desc = {
    Text = "Vaincre \"Concours\" à n'importe quelle difficulté"
  },
  Task_44235_Desc = {
    Text = "Vaincre \"Paranoïa\" à n'importe quelle difficulté"
  },
  Task_44236_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter une victoire dans « Chemin du Santuaire »"
  },
  Task_44237_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 3 victoires dans « Chemin du Santuaire »"
  },
  Task_44238_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 2 victoires dans « Chemin du sanctuaire »"
  },
  Task_44239_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 1 victoire dans « Chemin du Santuaire »"
  },
  Task_44240_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter 3 victoires dans « Chemin du Santuaire »"
  },
  Task_44241_Desc = {
    Text = "Acheter 150 fois lors de la «Vente Magique de Big John»"
  },
  Task_44242_Desc = {
    Text = "Acheter 200 fois lors de la «Vente Magique de Big John»"
  },
  Task_44243_Desc = {
    Text = "Acheter 100 fois lors de la «Vente Magique de Big John»"
  },
  Task_44244_Desc = {
    Text = "Acheter 200 fois dans «La Boutique de Mme Gray»"
  },
  Task_44245_Desc = {
    Text = "Achetez 150 fois dans \"La Boutique de Mme Gray\""
  },
  Task_44246_Desc = {
    Text = "Effectuer 100 achats dans \"La boutique de Mme Gray\""
  },
  Task_44247_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter 3 victoires dans « Chemin du Santuaire »"
  },
  Task_44248_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter 2 victoires dans « Chemin du Santuaire »"
  },
  Task_44249_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter une victoire dans « Chemin du Santuaire »"
  },
  Task_44250_Desc = {
    Text = "Effacez toute difficulté dans \"Repentance\""
  },
  Task_44251_Desc = {
    Text = "Salle de vente de l'église"
  },
  Task_44252_Desc = {
    Text = "\"Achetez 100 fois dans 'Vente de Forgeron'\""
  },
  Task_44253_Desc = {
    Text = "\"Achetez 200 fois dans 'Vente de Forgeron'\""
  },
  Task_44254_Desc = {
    Text = "\"Achetez 150 fois dans 'Vente de Forgeron'\""
  },
  Task_44255_Desc = {
    Text = "Chemin de l'Église · Aequor"
  },
  Task_44256_Desc = {
    Text = "Chemin de l'Église · Ultra"
  },
  Task_44257_Desc = {
    Text = "Chemin de l'Église · Chaos"
  },
  Task_44258_Desc = {
    Text = "Compléter n'importe quelle difficulté de \"Exaction\""
  },
  Task_44259_Desc = {
    Text = "Débloqué après avoir terminé tous les niveaux de \"Chemin de l'Église\" à n'importe quelle difficulté"
  },
  Task_44260_Desc = {
    Text = "Clear \"Accusation\" en n'importe quelle difficulté"
  },
  Task_44261_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter 2 fois dans « Chemin du Santuaire »"
  },
  Task_44262_Desc = {
    Text = "Chemin de l'Église · Caro"
  },
  Task_44263_Desc = {
    Text = "Chemin de l'Église · Croissance"
  },
  Task_44264_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_44567_Desc = {
    Text = "Arrêter Sofia"
  },
  Task_44567_Name = {Text = "Objectif"},
  Task_45665_Desc = {
    Text = "Complétez \"Le Vagabond : Déchu des Géants\" en mode normal"
  },
  Task_45665_Name = {
    Text = "Récompense de fin de niveau"
  },
  Task_45666_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_46575_Desc = {
    Text = "Utiliser un réveilleur du domaine hyperdimensionnel pour terminer « Mémoire Inconsciente » en n'importe quelle difficulté"
  },
  Task_46576_Desc = {
    Text = "Effacez toute difficulté de \"Miroir\""
  },
  Task_46577_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour terminer « Cerveau reptilien » en toute difficulté"
  },
  Task_46578_Desc = {
    Text = "Code de mémoire : Caro"
  },
  Task_46579_Desc = {
    Text = "Terminez \"Reptilian Brain\" en toute difficulté"
  },
  Task_46580_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour terminer « Mémoire Inconsciente » en n'importe quelle difficulté"
  },
  Task_46581_Desc = {
    Text = "Code de mémoire : Aequor"
  },
  Task_46582_Desc = {
    Text = "Terminez \"Unconscious Memory\" en toute difficulté"
  },
  Task_46583_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour terminer « Courbe de l'Oubli » en toute difficulté"
  },
  Task_46584_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour terminer « Miroir » en toute difficulté"
  },
  Task_46585_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour terminer « Amygdale » en toute difficulté"
  },
  Task_46586_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour terminer « Cerveau Reptilien » en toute difficulté"
  },
  Task_46587_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour terminer « Mémoire Inconsciente » en n'importe quelle difficulté"
  },
  Task_46588_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour terminer « Miroir » en toute difficulté"
  },
  Task_46589_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour terminer « Courbe de l'Oubli » en toute difficulté"
  },
  Task_46590_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour terminer « Mémoire Inconsciente » en toute difficulté"
  },
  Task_46591_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour terminer « Cerveau reptilien » en toute difficulté"
  },
  Task_46592_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour terminer « Amygdale » en toute difficulté"
  },
  Task_46593_Desc = {
    Text = "Déverrouille après avoir complété tous les niveaux de \"Encodage de Mémoire\" sur n'importe quelle difficulté."
  },
  Task_46594_Desc = {
    Text = "Effacez toute difficulté de \"Courbe de l'oubli\""
  },
  Task_46595_Desc = {
    Text = "Codage de mémoire·Chaos"
  },
  Task_46596_Desc = {
    Text = "Effacez toute difficulté de \"Amygdale\""
  },
  Task_46597_Desc = {
    Text = "Utiliser un réveilleur du domaine hyperdimensionnel pour terminer « Courbe de l'Oubli » en toute difficulté"
  },
  Task_46598_Desc = {
    Text = "Utiliser un réveilleur du domaine hyperdimensionnel pour terminer « Miroir » en toute difficulté"
  },
  Task_46599_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour terminer « Courbe de l'Oubli » en toute difficulté"
  },
  Task_46600_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour terminer « Miroir » en toute difficulté"
  },
  Task_46601_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour terminer « Amygdale » en toute difficulté"
  },
  Task_46602_Desc = {
    Text = "Codage de mémoire·Émergence"
  },
  Task_46603_Desc = {
    Text = "Utiliser un réveilleur du domaine hyperdimensionnel pour terminer « Amygdale » en n'importe quelle difficulté"
  },
  Task_46604_Desc = {
    Text = "Utiliser un réveilleur du domaine hyperdimensionnel pour terminer « Cerveau Reptilien » en toute difficulté"
  },
  Task_46605_Desc = {
    Text = "Code de mémoire : Ultra"
  },
  Task_46624_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_46798_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_46798_Name = {Text = "200 Points"},
  Task_46799_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_46799_Name = {Text = "450 points"},
  Task_46806_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_46806_Name = {Text = "50 points"},
  Task_46807_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_46807_Name = {Text = "100 points"},
  Task_46808_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_46808_Name = {Text = "150 points"},
  Task_46809_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_46809_Name = {
    Text = "1500 points"
  },
  Task_46810_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_46810_Name = {Text = "250 Points"},
  Task_46811_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_46811_Name = {Text = "300 points"},
  Task_46812_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_46812_Name = {Text = "350 Points"},
  Task_46821_Desc = {
    Text = "Obtenez un total de 6 victoires cette saiso"
  },
  Task_46821_Name = {
    Text = "6 victoires"
  },
  Task_46822_Desc = {
    Text = "Obtenez un total de 3 victoires cette saiso"
  },
  Task_46822_Name = {
    Text = "3 Victoires"
  },
  Task_46823_Desc = {
    Text = "Obtenez 1 victoire cette saiso"
  },
  Task_46823_Name = {Text = "1 Victoire"},
  Task_46826_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_46826_Name = {
    Text = "1450 Points"
  },
  Task_46827_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_46827_Name = {
    Text = "1400 points"
  },
  Task_46828_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_46828_Name = {
    Text = "1350 Points"
  },
  Task_46829_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_46829_Name = {
    Text = "1300 points"
  },
  Task_46830_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_46830_Name = {
    Text = "1250 Points"
  },
  Task_46831_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_46831_Name = {
    Text = "1200 points"
  },
  Task_46832_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_46832_Name = {
    Text = "1150 points"
  },
  Task_46833_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_46833_Name = {
    Text = "1100 points"
  },
  Task_46834_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_46834_Name = {
    Text = "1050 Points"
  },
  Task_46835_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_46835_Name = {
    Text = "1000 points"
  },
  Task_46836_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_46836_Name = {Text = "600 points"},
  Task_46837_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_46837_Name = {Text = "650 points"},
  Task_46838_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_46838_Name = {Text = "500 points"},
  Task_46839_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_46839_Name = {Text = "550 points"},
  Task_46840_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_46840_Name = {Text = "800 points"},
  Task_46841_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_46841_Name = {Text = "850 points"},
  Task_46842_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_46842_Name = {Text = "700 Points"},
  Task_46843_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_46843_Name = {Text = "750 points"},
  Task_46844_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_46844_Name = {Text = "900 Points"},
  Task_46845_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_46845_Name = {Text = "950 Points"},
  Task_46846_Desc = {
    Text = "Obtenez 10 victoires cette saiso"
  },
  Task_46846_Name = {
    Text = "10 Victoires"
  },
  Task_46847_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_46847_Name = {Text = "400 Points"},
  Task_46850_Desc = {
    Text = "Obtenez 10 victoires cette saiso"
  },
  Task_46850_Name = {
    Text = "10 Victoires"
  },
  Task_46852_Desc = {
    Text = "Obtenez un total de 3 victoires cette saiso"
  },
  Task_46852_Name = {
    Text = "3 Victoires"
  },
  Task_46853_Desc = {
    Text = "Obtenez un total de 6 victoires cette saiso"
  },
  Task_46853_Name = {
    Text = "6 victoires"
  },
  Task_46854_Desc = {
    Text = "Obtenez 1 victoire cette saiso"
  },
  Task_46854_Name = {Text = "1 Victoire"},
  Task_47794_Desc = {
    Text = "Compléter toutes les Fissures de Royaume VII dans le Royaume des Ténèbres"
  },
  Task_47795_Desc = {
    Text = "Compléter toutes les Fissures de Royaume I dans le Royaume sans Lumière"
  },
  Task_47796_Desc = {
    Text = "Compléter toutes les Fissures de Royaume III dans le Royaume sans Lumière"
  },
  Task_47797_Desc = {
    Text = "Compléter toutes les Fissures de Royaume V dans le Royaume sans Lumière"
  },
  Task_47799_Desc = {
    Text = "Compléter toutes les Fissures de Royaume IV dans le Royaume sans Lumière"
  },
  Task_47800_Desc = {
    Text = "Compléter toutes les Fissures de Royaume VI dans le Royaume sans Lumière"
  },
  Task_47801_Desc = {
    Text = "Compléter toutes les Fissures de Royaume VIII dans le Royaume des Ténèbres"
  },
  Task_47802_Desc = {
    Text = "Compléter toutes les Fissures de Royaume II dans le Royaume sans Lumière"
  },
  Task_48166_Desc = {
    Text = "Repoussez Rogers et d'autres"
  },
  Task_48166_Name = {Text = "Objectif"},
  Task_48167_Desc = {
    Text = "Vaincre Ombre \"24\""
  },
  Task_48167_Name = {Text = "Objectif"},
  Task_48733_CompleteCondDesc = {
    Text = "Niveau d'assignement total>={s1}"
  },
  Task_48733_Desc = {
    Text = "Des ruines de l'église effondrée et des reliques brisées, le musée revendique ses trésors, et vous revendiquez les vôtres.\nChacun prend ce dont il a besoin."
  },
  Task_48733_Name = {
    Text = "Mission : panthéisme"
  },
  Task_48733_UnlockCondDesc = {
    Text = "Le Gardien débloqué au niveau 40."
  },
  Task_48734_CompleteCondDesc = {
    Text = "Niveau d'assignement total>={s1}"
  },
  Task_48734_Desc = {
    Text = "Oublie tes perceptions, oublie ton but.\nQuelle est la vérité ? Ils te le diront."
  },
  Task_48734_Name = {
    Text = "Mission : a priori"
  },
  Task_48734_UnlockCondDesc = {
    Text = "Le Gardien débloqué au niveau 30"
  },
  Task_48735_CompleteCondDesc = {
    Text = "Niveau d'assignement total>={s1}"
  },
  Task_48735_Desc = {
    Text = "La géographie est un mensonge raconté par ceux au pouvoir.\nMéfiez-vous de ces lignes de contour."
  },
  Task_48735_Name = {
    Text = "Mission : plans de reconnaissance"
  },
  Task_48735_UnlockCondDesc = {
    Text = "Le Gardien débloqué au niveau 20"
  },
  Task_48736_CompleteCondDesc = {
    Text = "Niveau d'assignement total>={s1}"
  },
  Task_48736_Desc = {
    Text = "Recevoir deux promesses peu fiables et un rêve inoubliable."
  },
  Task_48736_Name = {
    Text = "Mission : royaume fantôme"
  },
  Task_48736_UnlockCondDesc = {
    Text = "Le Gardien débloqué au niveau 50"
  },
  Task_48775_Desc = {
    Text = "L'affinité de Lily a atteint le niveau 10."
  },
  Task_48776_Desc = {
    Text = "L'Affinité d'Aurita a atteint le Niveau 10"
  },
  Task_48777_Desc = {
    Text = "Affinité Évanouie atteint le niveau 10"
  },
  Task_48778_Desc = {
    Text = "L'Affinité de Wanda a atteint le niveau 10."
  },
  Task_48779_Desc = {
    Text = "L'Affinité de Jenkin a atteint le Niveau 10."
  },
  Task_48780_Desc = {
    Text = "Ogier Niveau d'affinité 10"
  },
  Task_48781_Desc = {
    Text = "L’Affinité de Liz atteint le Niveau 10"
  },
  Task_48782_Desc = {
    Text = "L'affinité Jonquille a atteint le niveau 10."
  },
  Task_48783_Desc = {
    Text = "L'affinité de Doll atteint le niveau 10"
  },
  Task_48784_Desc = {
    Text = "L'affinité de Céleste atteint le niveau 10"
  },
  Task_48785_Desc = {
    Text = "Aigis a atteint le niveau d'Affinité 10."
  },
  Task_48786_Desc = {
    Text = "L'Affinité de Murphy a atteint le niveau 10."
  },
  Task_48787_Desc = {
    Text = "L'Affinité de Sanga a atteint le Niveau 10."
  },
  Task_48788_Desc = {
    Text = "L'Affinité d'Uvhash a atteint le niveau 10."
  },
  Task_48789_Desc = {
    Text = "L'Affinité Nautila a atteint le Niveau 10"
  },
  Task_48790_Desc = {
    Text = "\"24\" L'Affinité atteint le Niveau 10"
  },
  Task_48791_Desc = {
    Text = "L'Affinité d'Agrippa a atteint le Niveau 10."
  },
  Task_48792_Desc = {
    Text = "Niveau d'affinité Faros 10"
  },
  Task_48793_Desc = {
    Text = "L'Affinité de Winkle atteint le Niveau 10"
  },
  Task_48794_Desc = {
    Text = "L'Affinité de Salvador a atteint le Niveau 10."
  },
  Task_48795_Desc = {
    Text = "L'Affinité Hilote a atteint le Niveau 10."
  },
  Task_48796_Desc = {
    Text = "L'Affinité d'Erica a atteint le Niveau 10."
  },
  Task_48797_Desc = {
    Text = "L'Affinité de Ramona a atteint le Niveau 10."
  },
  Task_48798_Desc = {
    Text = "L'Affinité de Sorel a atteint le Niveau 10."
  },
  Task_48799_Desc = {
    Text = "L'Affinité de Thais atteint le Niveau 10"
  },
  Task_48800_Desc = {
    Text = "L'Affinité de Goliath a atteint le Niveau 10."
  },
  Task_48801_Desc = {
    Text = "L'Affinité de Leigh a atteint le niveau 10."
  },
  Task_48802_Desc = {
    Text = "L'affinité d'Alva a atteint le niveau 10."
  },
  Task_48803_Desc = {
    Text = "Niveau d'affinité Caecus 10"
  },
  Task_48804_Desc = {
    Text = "L'Affinité de Tulu atteint le niveau 10"
  },
  Task_48805_Desc = {
    Text = "L'Affinité de Casiah atteint le Niveau 10"
  },
  Task_48806_Desc = {
    Text = "L'Affinité de Karen a atteint le Niveau 10."
  },
  Task_48807_Desc = {
    Text = "Le niveau d'Affinité de Pandia a atteint 10."
  },
  Task_48808_Desc = {
    Text = "L'affinité de Teinture atteint le niveau 10"
  },
  Task_48809_Desc = {
    Text = "L'Affinité Nymphaea a atteint le Niveau 10."
  },
  Task_48810_Desc = {
    Text = "L'affinité de Lotan a atteint le niveau 10"
  },
  Task_48829_Desc = {
    Text = "Connexion Cumulative : 11 Jours"
  },
  Task_48830_Desc = {
    Text = "Connexion cumulative de 14 jours"
  },
  Task_48831_Desc = {
    Text = "Connexion cumulative pendant 1 jour"
  },
  Task_48832_Desc = {
    Text = "Connecté pendant un total de 16 jours"
  },
  Task_48833_Desc = {
    Text = "Connexion Cumulative : 12 Jours"
  },
  Task_48834_Desc = {
    Text = "Connexion Cumulative : 13 Jours"
  },
  Task_48835_Desc = {
    Text = "Connectez-vous pendant un total de 10 jours"
  },
  Task_48836_Desc = {
    Text = "Connecte-toi pendant 5 jours cumulés"
  },
  Task_48837_Desc = {
    Text = "Connexion cumulative pendant 6 jours"
  },
  Task_48838_Desc = {
    Text = "Connectez-vous pendant un total de 7 jours"
  },
  Task_48839_Desc = {
    Text = "Connectez-vous pendant un total de 2 jours"
  },
  Task_48840_Desc = {
    Text = "Connecte-toi pendant 3 jours cumulés"
  },
  Task_48841_Desc = {
    Text = "Connectez-vous pendant un total de 8 jours"
  },
  Task_48842_Desc = {
    Text = "Connecté pendant un total de 9 jours"
  },
  Task_48843_Desc = {
    Text = "Connectez-vous pendant un total de 15 jours"
  },
  Task_48844_Desc = {
    Text = "Connectez-vous pendant un total de 4 jours"
  },
  Task_49241_Desc = {
    Text = "Obtenez 1 victoire cette saiso"
  },
  Task_49241_Name = {Text = "1 Victoire"},
  Task_49242_Desc = {
    Text = "Obtenez un total de 3 victoires cette saiso"
  },
  Task_49242_Name = {
    Text = "3 Victoires"
  },
  Task_49243_Desc = {
    Text = "Obtenez un total de 6 victoires cette saiso"
  },
  Task_49243_Name = {
    Text = "6 victoires"
  },
  Task_49244_Desc = {
    Text = "Obtenez 10 victoires cette saiso"
  },
  Task_49244_Name = {
    Text = "10 Victoires"
  },
  Task_49245_Desc = {
    Text = "Obtenez 10 victoires cette saiso"
  },
  Task_49245_Name = {
    Text = "10 Victoires"
  },
  Task_49246_Desc = {
    Text = "Obtenez 1 victoire cette saiso"
  },
  Task_49246_Name = {Text = "1 Victoire"},
  Task_49247_Desc = {
    Text = "Obtenez un total de 6 victoires cette saiso"
  },
  Task_49247_Name = {
    Text = "6 victoires"
  },
  Task_49248_Desc = {
    Text = "Obtenez un total de 3 victoires cette saiso"
  },
  Task_49248_Name = {
    Text = "3 Victoires"
  },
  Task_49262_Desc = {
    Text = "Gagnez la bataille finale en 30 tours"
  },
  Task_49262_Name = {
    Text = "Gagnez la bataille finale en 30 tours"
  },
  Task_49380_Desc = {
    Text = "Vaincre \"Fleur de Régénération\" à n'importe quelle difficulté"
  },
  Task_49381_Desc = {
    Text = "Désir Chaotique·Réapparition"
  },
  Task_49382_Desc = {
    Text = "Compléter toutes les tâches de \"Désir Chaotique : Clear\""
  },
  Task_49383_Desc = {
    Text = "Désir Chaotique·Épuré"
  },
  Task_49384_Desc = {
    Text = "Vaincre \"Embryons Multiples\" à n'importe quelle difficulté"
  },
  Task_49385_Desc = {
    Text = "Complétez \"Fruit Déchu\" à n'importe quelle difficulté"
  },
  Task_49386_Desc = {
    Text = "Reproduisez 30 fois dans \"Désir Chaotique\""
  },
  Task_49387_Desc = {
    Text = "Compléter n'importe quelle difficulté de \"Glande de Nectar\""
  },
  Task_49388_Desc = {
    Text = "Reproduisez 10 fois dans \"Désir Chaotique\""
  },
  Task_49389_Desc = {
    Text = "Terminez \"Young Root\" en toute difficulté"
  },
  Task_49390_Desc = {
    Text = "Clear \"Germer\" à n'importe quelle difficulté"
  },
  Task_49391_Desc = {
    Text = "Reproduisez 20 fois dans \"Désir Chaotique\""
  },
  Task_49392_Desc = {
    Text = "Reproduisez 50 fois dans \"Désir Chaotique\""
  },
  Task_49393_Desc = {
    Text = "Recréez 40 fois dans \"Désir Chaotique\""
  },
  Task_49394_Desc = {
    Text = "Complétez \"Fleur\" à n'importe quelle difficulté"
  },
  Task_49395_Desc = {
    Text = "Complétez \"Perle Embryon\" à n'importe quelle difficulté"
  },
  Task_49396_Desc = {
    Text = "Effacez toute difficulté de \"Pollinisation\""
  },
  Task_49397_Desc = {
    Text = "Terminez \"Year Ring\" en toute difficulté"
  },
  Task_49769_Desc = {
    Text = "Lors d'un tour de la bataille finale, empilez un bouclier équivalent à au moins 50% de la santé maximale."
  },
  Task_49769_Name = {Text = "Ironclad"},
  Task_49770_Desc = {
    Text = "Infliger au moins 3000 points de dégâts en un seul tour pendant une bataille d'élite."
  },
  Task_49770_Name = {
    Text = "Attaque totale"
  },
  Task_49771_Desc = {
    Text = "Vaincre au moins 2 monstres en un round de n'importe quelle bataille"
  },
  Task_49771_Name = {
    Text = "Racine et tige"
  },
  Task_49772_Desc = {
    Text = "Transportez au moins 1 Relique maudite à l'achèvement."
  },
  Task_49772_Name = {
    Text = "Planque secrète"
  },
  Task_49773_Desc = {
    Text = "Gagnez au moins 4 types différents d'Oraisons"
  },
  Task_49773_Name = {
    Text = "Marque de l'Âme"
  },
  Task_49774_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_49774_Name = {
    Text = "Élégant et précis"
  },
  Task_49775_Desc = {
    Text = "Jouer au moins 7 Cartes en un tour lors de la Bataille Finale"
  },
  Task_49775_Name = {Text = "Mon tour !"},
  Task_49776_Desc = {
    Text = "Réveillez tous les Réveilleurs à l'achèvement"
  },
  Task_49776_Name = {
    Text = "Étreinte infinie"
  },
  Task_49777_Desc = {
    Text = "Avoir pas plus de 2 Cartes de Symptômes lors de l'achèvement"
  },
  Task_49777_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_49778_Desc = {
    Text = "Vaincre au moins 2 monstres en un round de n'importe quelle bataille"
  },
  Task_49778_Name = {
    Text = "Racine et tige"
  },
  Task_49779_Desc = {
    Text = "Transportez au moins 1 Relique maudite à l'achèvement."
  },
  Task_49779_Name = {
    Text = "Planque secrète"
  },
  Task_49780_Desc = {
    Text = "Gagnez au moins 4 types différents d'Oraisons"
  },
  Task_49780_Name = {
    Text = "Marque de l'Âme"
  },
  Task_49781_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_49781_Name = {
    Text = "Élégant et précis"
  },
  Task_49782_Desc = {
    Text = "Jouer au moins 7 Cartes en un tour lors de la Bataille Finale"
  },
  Task_49782_Name = {Text = "Mon tour !"},
  Task_49783_Desc = {
    Text = "Réveillez tous les Réveilleurs à l'achèvement"
  },
  Task_49783_Name = {
    Text = "Étreinte infinie"
  },
  Task_49784_Desc = {
    Text = "Avoir pas plus de 2 Cartes de Symptômes lors de l'achèvement"
  },
  Task_49784_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_49785_Desc = {
    Text = "Lors d'un tour de la bataille finale, empilez un bouclier équivalent à au moins 50% de la santé maximale."
  },
  Task_49785_Name = {Text = "Ironclad"},
  Task_49786_Desc = {
    Text = "Infliger au moins 4500 points de dégâts en un seul tour pendant une bataille d'élite."
  },
  Task_49786_Name = {
    Text = "Attaque totale"
  },
  Task_49787_Desc = {
    Text = "Infliger au moins 7300 points de dégâts en un tour dans un combat d'élite"
  },
  Task_49787_Name = {
    Text = "Attaque totale"
  },
  Task_49788_Desc = {
    Text = "Gagnez au moins 6 types différents d'Oraisons"
  },
  Task_49788_Name = {
    Text = "Marque de l'Âme"
  },
  Task_49789_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_49789_Name = {
    Text = "Élégant et précis"
  },
  Task_49790_Desc = {
    Text = "Transportez au moins 7 Reliques à l'achèvement"
  },
  Task_49790_Name = {
    Text = "Planque secrète"
  },
  Task_49791_Desc = {
    Text = "Pas de récupération de Vie depuis la Jonction à la fin"
  },
  Task_49791_Name = {
    Text = "Les non-illuminés"
  },
  Task_49792_Desc = {
    Text = "Infliger au moins 9000 points de dégâts en un tour dans un combat d'élite"
  },
  Task_49792_Name = {
    Text = "Attaque totale"
  },
  Task_49793_Desc = {
    Text = "Gagnez au moins 6 types différents d'Oraisons"
  },
  Task_49793_Name = {
    Text = "Marque de l'Âme"
  },
  Task_49794_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_49794_Name = {
    Text = "Élégant et précis"
  },
  Task_49795_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_49795_Name = {
    Text = "Résolution rapide"
  },
  Task_49796_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_49796_Name = {
    Text = "Résolution rapide"
  },
  Task_49797_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_49797_Name = {
    Text = "Résolution rapide"
  },
  Task_49798_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_49798_Name = {
    Text = "Résolution rapide"
  },
  Task_49799_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_49799_Name = {
    Text = "Résolution rapide"
  },
  Task_49800_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_49800_Name = {
    Text = "Résolution rapide"
  },
  Task_49801_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_49801_Name = {
    Text = "Résolution rapide"
  },
  Task_49802_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_49802_Name = {
    Text = "Résolution rapide"
  },
  Task_49803_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_49803_Name = {
    Text = "Résolution rapide"
  },
  Task_49804_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_49804_Name = {
    Text = "Passer Parfait"
  },
  Task_49805_Desc = {
    Text = "Transportez au moins 7 Reliques à l'achèvement"
  },
  Task_49805_Name = {
    Text = "Planque secrète"
  },
  Task_49806_Desc = {
    Text = "Pas de récupération de Vie depuis la Jonction à la fin"
  },
  Task_49806_Name = {
    Text = "Les non-illuminés"
  },
  Task_49807_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_49807_Name = {
    Text = "Passer Parfait"
  },
  Task_49808_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_49808_Name = {
    Text = "Passer Parfait"
  },
  Task_49809_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_49809_Name = {
    Text = "Passer Parfait"
  },
  Task_49810_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_49810_Name = {
    Text = "Passer Parfait"
  },
  Task_49811_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_49811_Name = {
    Text = "Passer Parfait"
  },
  Task_49812_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_49812_Name = {
    Text = "Passer Parfait"
  },
  Task_49813_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_49813_Name = {
    Text = "Passer Parfait"
  },
  Task_49814_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_49814_Name = {
    Text = "Passer Parfait"
  },
  Task_49815_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_49815_Name = {
    Text = "Passer Parfait"
  },
  Task_49816_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_49816_Name = {
    Text = "Passer Parfait"
  },
  Task_49817_Desc = {
    Text = "Avoir pas plus de 2 Cartes de Symptômes lors de l'achèvement"
  },
  Task_49817_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_49818_Desc = {
    Text = "Tuez au moins 4 monstres en un seul tour lors de la Bataille Finale."
  },
  Task_49818_Name = {
    Text = "Racine et tige"
  },
  Task_49819_Desc = {
    Text = "Avoir pas plus de 2 Cartes de Symptômes lors de l'achèvement"
  },
  Task_49819_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_49820_Desc = {
    Text = "Tuez au moins 4 monstres en un seul tour lors de la Bataille Finale."
  },
  Task_49820_Name = {
    Text = "Racine et tige"
  },
  Task_49821_Desc = {
    Text = "Gagner la Bataille Finale en moins de 18 tours"
  },
  Task_49821_Name = {
    Text = "Résolution rapide"
  },
  Task_49822_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_49822_Name = {
    Text = "Résolution rapide"
  },
  Task_49823_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_49823_Name = {
    Text = "Résolution rapide"
  },
  Task_49824_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_49824_Name = {
    Text = "Passer Parfait"
  },
  Task_49852_Desc = {
    Text = "Nubia : Éliminez le Camp de Menace"
  },
  Task_49852_Name = {Text = "Objectif"},
  Task_49853_Desc = {
    Text = "Traversée du Mur de Tempête"
  },
  Task_49853_Name = {Text = "Objectif"},
  Task_49854_Desc = {
    Text = "Enlève un soldat Aran pour trouver l'emplacement du squelette."
  },
  Task_49854_Name = {Text = "Objectif"},
  Task_49855_Desc = {
    Text = "Trouvez la source d'eau"
  },
  Task_49855_Name = {Text = "Objectif"},
  Task_49856_Desc = {
    Text = "Vaincre Casiah et récupérer le squelette."
  },
  Task_49856_Name = {Text = "Objectif"},
  Task_49857_Desc = {
    Text = "Combattre aux côtés de Thais"
  },
  Task_49857_Name = {Text = "Objectif"},
  Task_49858_Desc = {
    Text = "Échapper à la prise de Casiah"
  },
  Task_49858_Name = {Text = "Objectif"},
  Task_49859_Desc = {
    Text = "Arrête le Rituel de Résurrection de l'Arbre Mère"
  },
  Task_49859_Name = {Text = "Objectif"},
  Task_49860_Desc = {
    Text = "Plonger dans la mer de conscience de l'Arbre Mère"
  },
  Task_49860_Name = {Text = "Objectif"},
  Task_49861_Desc = {
    Text = "Aidez les Aram à chasser les Nubiens"
  },
  Task_49861_Name = {Text = "Objectif"},
  Task_49862_Desc = {
    Text = "Rechercher le squelette de l'Arbre Mère"
  },
  Task_49862_Name = {Text = "Objectif"},
  Task_49863_Desc = {
    Text = "Vaincre l'Arbre Mère"
  },
  Task_49863_Name = {Text = "Objectif"},
  Task_49879_Desc = {
    Text = "<Ramona: Timeworn Affinity Level 10 has been reached: Ramona : Niveau 10 d'Affinité Antique atteint"
  },
  Task_50033_Desc = {
    Text = "Résonner 6 fois dans l'enquête sur l'événement «@1@2»"
  },
  Task_50033_Desc2 = {
    Text = "Résonnez 6 fois dans l'événement d'investigation \"Rivière de Désir\""
  },
  Task_50033_Name = {Text = "@2@3"},
  Task_50033_Name2 = {
    Text = "Écho d'Obsession II"
  },
  Task_50034_Desc = {
    Text = "Résonner 9 fois dans l'enquête sur l'événement «@1@2»"
  },
  Task_50034_Desc2 = {
    Text = "Résonner 9 fois dans l'événement d'enquête \"River of Desire\""
  },
  Task_50034_Name = {Text = "@2@3"},
  Task_50034_Name2 = {
    Text = "Écho d'Obsession III"
  },
  Task_50035_Desc = {
    Text = "Trouvez 12 points d'extraction dans le Chapitre 7 de l'intrigue principale \"@1@2\""
  },
  Task_50035_Desc2 = {
    Text = "Trouvez 12 points d'extraction dans le Chapitre 7 \"Rivière du désir\" de l'histoire principale."
  },
  Task_50035_Name = {Text = "@2@3"},
  Task_50035_Name2 = {
    Text = "Chuchotement de la discrétion VII"
  },
  Task_50036_Desc = {
    Text = "Résonner 3 fois dans l'enquête sur l'événement «@1@2»"
  },
  Task_50036_Desc2 = {
    Text = "Résonnez 3 fois dans l'événement d'investigation \"Rivière de Désir\""
  },
  Task_50036_Name = {Text = "@2@3"},
  Task_50036_Name2 = {
    Text = "Écho de l'illusion"
  },
  Task_50037_Desc = {
    Text = "Compléter l'événement d'investigation \"@1@2\""
  },
  Task_50037_Desc2 = {
    Text = "Compléter l'Événement d'Investigation « Rivière de Désir »"
  },
  Task_50037_Name = {Text = "@2@3"},
  Task_50037_Name2 = {
    Text = "Quand l'arbre sacré brûle"
  },
  Task_50038_Desc = {
    Text = "Compléter l'événement d'investigation \"Rivière du Désir\" à la difficulté Difficile"
  },
  Task_50038_Name = {
    Text = "Lorsque l'Arbre Sacré brûle · Difficile"
  },
  Task_50039_Desc = {
    Text = "Résonner 11 fois dans l'événement d'investigation \"@1@2\""
  },
  Task_50039_Desc2 = {
    Text = "Résonner 11 fois dans l'événement d'investigation \"Rivière de Désir\""
  },
  Task_50039_Name = {Text = "@2@3"},
  Task_50039_Name2 = {
    Text = "Écho d'Obsession IV"
  },
  Task_51106_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter 2 fois dans «Mystère du script»"
  },
  Task_51107_Desc = {
    Text = "Terminer toutes les missions de «Mystère du script · Terminé»"
  },
  Task_51108_Desc = {
    Text = "Terminez \"Plot Twist\" en toute difficulté"
  },
  Task_51109_Desc = {
    Text = "Enregistrement de la task force"
  },
  Task_51109_Name = {
    Text = "(abandonné)"
  },
  Task_51110_Desc = {
    Text = "Utilisez un réveilleur du Domaine des abysses pour remporter une victoire dans «Mystère du script»"
  },
  Task_51111_Desc = {
    Text = "Mystère du script·Royaume"
  },
  Task_51112_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter une victoire dans «Mystère du script»"
  },
  Task_51113_Desc = {
    Text = "Utiliser un réveilleur du domaine hyperdimensionnel pour remporter 2 victoires dans «Mystère du script»"
  },
  Task_51114_Desc = {
    Text = "Vaincre \"Catharsis\" à n'importe quelle difficulté"
  },
  Task_51115_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 2 fois dans «Mystère du script»"
  },
  Task_51116_Desc = {
    Text = "Vaincre \"Comédie Masquée\" à n'importe quelle difficulté"
  },
  Task_51117_Desc = {
    Text = "Clear \"Trinité\" à n'importe quelle difficulté"
  },
  Task_51118_Desc = {
    Text = "Utiliser un réveilleur du domaine hyperdimensionnel pour remporter une victoire dans «Mystère du script»"
  },
  Task_51119_Desc = {
    Text = "Clear \"Arc Theory\" en n'importe quelle difficulté"
  },
  Task_51120_Desc = {
    Text = "Vaincre \"Pyramide du Dramaturge\" à n'importe quelle difficulté"
  },
  Task_51121_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter une victoire dans « Mystère du script »"
  },
  Task_51122_Desc = {
    Text = "Terminez \"the Fourth Wall of Drama\" en toute difficulté"
  },
  Task_51123_Desc = {
    Text = "Compléter \"Effet d'Étrangeté\" en n'importe quelle difficulté"
  },
  Task_51124_Desc = {
    Text = "Mystère du Script·Achèvement"
  },
  Task_51125_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter 2 victoires dans « Mystère du script »"
  },
  Task_51126_Desc = {
    Text = "Compléter \"Moment Calme\" en n'importe quelle difficulté"
  },
  Task_51140_Desc = {
    Text = "Terminer le dossier spécial « La Magie des Histoires »"
  },
  Task_51141_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_51141_Name = {
    Text = "(abandonné)"
  },
  Task_51142_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_51142_Name = {
    Text = "(abandonné)"
  },
  Task_51143_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_51143_Name = {
    Text = "<Abandonné>"
  },
  Task_51144_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_51144_Name = {
    Text = "<Abandonné>"
  },
  Task_51145_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_51145_Name = {
    Text = "(abandonné)"
  },
  Task_51146_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_51146_Name = {
    Text = "(abandonné)"
  },
  Task_52280_Desc = {
    Text = "\"Autel d'Erin\" Offre 100 Sacrifices pour des Récompenses"
  },
  Task_52281_Desc = {
    Text = "\"Autel d'Erin\" Offre 200 Sacrifices pour des Récompenses"
  },
  Task_52282_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 2 fois dans « Sacrifice abyssal »"
  },
  Task_52283_Desc = {
    Text = "Sacrifice de l'Abysse : Complet"
  },
  Task_52284_Desc = {
    Text = "Terminez \"Témoin\" à n'importe quelle difficulté"
  },
  Task_52285_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter une victoire dans « Sacrifice abyssal »"
  },
  Task_52286_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter 2 victoires dans « Sacrifice abyssal »"
  },
  Task_52287_Desc = {
    Text = "Compléter n'importe quelle difficulté de \"Conviction\""
  },
  Task_52288_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 1 victoire dans «Sacrifice abyssal»"
  },
  Task_52289_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter 1 victoire dans «Sacrifice abyssal»"
  },
  Task_52290_Desc = {
    Text = "Sacrifice de l'Abysse·Royaume"
  },
  Task_52291_Desc = {
    Text = "Complétez \"Désacralisation\" dans le Paysage de rêve"
  },
  Task_52292_Desc = {
    Text = "\"Autel de Sang\" offre 100 récompenses pour des sacrifices"
  },
  Task_52293_Desc = {
    Text = "\"Autel de Sang\" Sacrifiez des offrandes pour recevoir 200 récompenses"
  },
  Task_52294_Desc = {
    Text = "\"Autel de l’Âme\"Offrir 200 Sacrifices pour des Récompenses"
  },
  Task_52295_Desc = {
    Text = "\"Autel de l’Âme\"Offrir 100 Sacrifices pour des Récompenses"
  },
  Task_52296_Desc = {
    Text = "Complétez \"Doute\" à n'importe quelle difficulté"
  },
  Task_52297_Desc = {
    Text = "Clear \"Secouer\" à n'importe quelle difficulté"
  },
  Task_52298_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter 2 victoires dans « Sacrifice abyssal »"
  },
  Task_52299_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter une victoire dans « Sacrifice abyssal »"
  },
  Task_52300_Desc = {
    Text = "Vaincre \"Arrivée\" en toute difficulté"
  },
  Task_52301_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter 2 victoires dans « Sacrifice abyssal »"
  },
  Task_52302_Desc = {
    Text = "Réponse de l'Abyss"
  },
  Task_52303_Desc = {
    Text = "Débloqué après avoir terminé toutes les tâches de \"Sacrifice de l'Abysse · Éclaircissement\" et \"Réponse de l'Abysse\""
  },
  Task_53694_Desc = {
    Text = "Les ions actifs raffinés atteignent 1 000"
  },
  Task_53695_Desc = {
    Text = "Complétez 20 Missions"
  },
  Task_53696_Desc = {
    Text = "Jour 1 de l'Inscription Scolaire"
  },
  Task_53697_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 3 victoires"
  },
  Task_53698_Desc = {
    Text = "Comme 10 autres personnes dans l'Association des Anciens élèves"
  },
  Task_53699_Desc = {
    Text = "Jour 6 de l'inscription au retour à l'école"
  },
  Task_53700_Desc = {
    Text = "Jour 5 de l'inscription au retour à l'école"
  },
  Task_53701_Desc = {Text = "Jour 4"},
  Task_53702_Desc = {Text = "Jour 2"},
  Task_53703_Desc = {Text = "Jour 3"},
  Task_53704_Desc = {Text = "Jour 1"},
  Task_53705_Desc = {
    Text = "Utiliser un réveilleur du domaine hyperdimensionnel pour remporter 3 victoires"
  },
  Task_53706_Desc = {
    Text = "Jour 4 de l'Inscription de Retour à l'École"
  },
  Task_53707_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter 3 victoires"
  },
  Task_53708_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter 3 victoires"
  },
  Task_53709_Desc = {
    Text = "Jour 2 de l'Inscription Scolaire"
  },
  Task_53710_Desc = {
    Text = "Compléter toute culture d'Éveillé"
  },
  Task_53711_Desc = {
    Text = "Accumulatez 50 000 Billets de Rose Dorée"
  },
  Task_53712_Desc = {
    Text = "Consommer 1 500 Ménophine"
  },
  Task_53713_Desc = {
    Text = "Obtenir 500 ions actifs raffinés"
  },
  Task_53714_Desc = {
    Text = "Accumulatez 500 000 Billets de Rose Dorée"
  },
  Task_53715_Desc = {
    Text = "Effectuez un total de 20 cérémonies de Réveil dans n'importe quelle activité Réveiller"
  },
  Task_53716_Desc = {
    Text = "Compléter le Royaume des Ténèbres ou la Transcendance une fois."
  },
  Task_53717_Desc = {
    Text = "Aider un Réveilleur ancien 10 fois"
  },
  Task_53718_Desc = {
    Text = "Jour 3 de l'Inscription de Retour à l'École"
  },
  Task_53719_Desc = {
    Text = "Utilisez un Réveilleur alumni pour le soutien"
  },
  Task_53720_Desc = {
    Text = "Échangez 3 fois en utilisant des Coupons d'Or dans la Boutique"
  },
  Task_53721_Desc = {
    Text = "Consommer 180 Ménophine"
  },
  Task_53722_Desc = {
    Text = "Exécutez 3 missions"
  },
  Task_53723_Desc = {
    Text = "Jour 7 de l'inscription au retour à l'école"
  },
  Task_53724_Desc = {
    Text = "Obtenir 1 000 ions actifs minimalistes"
  },
  Task_53725_Desc = {
    Text = "Compléter 1 Niveau d'Éveilleurs de Réveil"
  },
  Task_53726_Desc = {
    Text = "Effectuer 1 Réveil"
  },
  Task_53982_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 1 victoire dans « Souvenirs de la rose »"
  },
  Task_53983_Desc = {
    Text = "Vaincre \"Jeu de Marionnettes\" à n'importe quelle difficulté"
  },
  Task_53984_Desc = {
    Text = "Complétez \"Regard\" à n'importe quelle difficulté"
  },
  Task_53985_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter 2 victoires dans « Souvenirs de la rose »"
  },
  Task_53986_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter une victoire dans « Souvenirs de la rose »"
  },
  Task_53987_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 2 victoires dans « Souvenirs de la rose »"
  },
  Task_53988_Desc = {
    Text = "Souvenirs de rose·Royaume"
  },
  Task_53989_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter une victoire dans « Souvenirs de la rose »"
  },
  Task_53990_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter 2 victoires dans « Souvenirs de la rose »"
  },
  Task_53991_Desc = {
    Text = "Débloqué après avoir terminé toutes les tâches de \"Souvenirs de Roses · Réalisation\""
  },
  Task_53992_Desc = {
    Text = "Éliminez \"Scénario Inachevé\" à n'importe quelle difficulté"
  },
  Task_53993_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter une victoire dans « Souvenirs de la rose »"
  },
  Task_53994_Desc = {
    Text = "Compléter \"Coin de Rose\" en n'importe quelle difficulté"
  },
  Task_53995_Desc = {
    Text = "Souvenirs de Rose·Achèvement"
  },
  Task_53996_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter 2 victoires dans « Souvenirs de la rose »"
  },
  Task_53997_Desc = {
    Text = "Terminez \"Tonton Pattes Longues\" à n'importe quelle difficulté"
  },
  Task_53998_Desc = {
    Text = "Complétez \"Cadeau\" à n'importe quelle difficulté"
  },
  Task_53999_Desc = {
    Text = "Complétez \"Finale\" à n'importe quelle difficulté"
  },
  Task_54000_Desc = {
    Text = "Complétez \"Poisson Sous la Bouilloire\" à n'importe quelle difficulté"
  },
  Task_54001_Desc = {
    Text = "Complétez \"Visage\" à n'importe quelle difficulté"
  },
  Task_54542_Desc = {
    Text = "Obtenez 1 victoire cette saiso"
  },
  Task_54542_Name = {Text = "1 Victoire"},
  Task_54543_Desc = {
    Text = "Obtenez un total de 6 victoires cette saiso"
  },
  Task_54543_Name = {
    Text = "6 victoires"
  },
  Task_54544_Desc = {
    Text = "Obtenez un total de 3 victoires cette saiso"
  },
  Task_54544_Name = {
    Text = "3 Victoires"
  },
  Task_54545_Desc = {
    Text = "Obtenez 10 victoires cette saiso"
  },
  Task_54545_Name = {
    Text = "10 Victoires"
  },
  Task_54546_Desc = {
    Text = "Obtenez 1 victoire cette saiso"
  },
  Task_54546_Name = {Text = "1 Victoire"},
  Task_54547_Desc = {
    Text = "Obtenez 10 victoires cette saiso"
  },
  Task_54547_Name = {
    Text = "10 Victoires"
  },
  Task_54548_Desc = {
    Text = "Obtenez 10 victoires cette saiso"
  },
  Task_54548_Name = {
    Text = "10 Victoires"
  },
  Task_54549_Desc = {
    Text = "Obtenez un total de 6 victoires cette saiso"
  },
  Task_54549_Name = {
    Text = "6 victoires"
  },
  Task_54550_Desc = {
    Text = "Obtenez 1 victoire cette saiso"
  },
  Task_54550_Name = {Text = "1 Victoire"},
  Task_54551_Desc = {
    Text = "Obtenez un total de 3 victoires cette saiso"
  },
  Task_54551_Name = {
    Text = "3 Victoires"
  },
  Task_54552_Desc = {
    Text = "Obtenez un total de 6 victoires cette saiso"
  },
  Task_54552_Name = {
    Text = "6 victoires"
  },
  Task_54553_Desc = {
    Text = "Obtenez un total de 3 victoires cette saiso"
  },
  Task_54553_Name = {
    Text = "3 Victoires"
  },
  Task_54554_Desc = {
    Text = "Obtenez un total de 6 victoires cette saiso"
  },
  Task_54554_Name = {
    Text = "6 victoires"
  },
  Task_54555_Desc = {
    Text = "Obtenez 1 victoire cette saiso"
  },
  Task_54555_Name = {Text = "1 Victoire"},
  Task_54556_Desc = {
    Text = "Obtenez 10 victoires cette saiso"
  },
  Task_54556_Name = {
    Text = "10 Victoires"
  },
  Task_54557_Desc = {
    Text = "Obtenez un total de 3 victoires cette saiso"
  },
  Task_54557_Name = {
    Text = "3 Victoires"
  },
  Task_54585_Desc = {
    Text = ": Accumuler 1000 Argent Prime"
  },
  Task_54586_Desc = {
    Text = ": Accumuler 3000 Argent Prime"
  },
  Task_54587_Desc = {
    Text = ": Accumuler 6000 Argent Prime"
  },
  Task_54588_Desc = {
    Text = ": Accumuler 10000 Argent Prime"
  },
  Task_54589_Desc = {
    Text = ": Accumuler 30000 Argent Prime"
  },
  Task_54590_Desc = {
    Text = ": Accumuler 60000 Argent Prime"
  },
  Task_54591_Desc = {
    Text = ": Accumuler 100000 Argent Prime"
  },
  Task_55092_Desc = {
    Text = "Complète toutes les tâches dans ce chapitre pour réclamer des récompenses."
  },
  Task_55092_Name = {
    Text = "Royaume Maîtrise VII"
  },
  Task_55093_Desc = {
    Text = "Complète toutes les tâches dans ce chapitre pour réclamer des récompenses."
  },
  Task_55093_Name = {
    Text = "Maîtrise de Royaume VI"
  },
  Task_55094_Desc = {
    Text = "Élever 3 personnages Caro au Niveau 60"
  },
  Task_55094_Name = {
    Text = "Royaume Maîtrise VII"
  },
  Task_55095_Desc = {
    Text = "Élever trois personnages Aequor au niveau 60."
  },
  Task_55095_Name = {
    Text = "Royaume Maîtrise VII"
  },
  Task_55096_Desc = {
    Text = "Élever 3 personnages Chaos au niveau 60"
  },
  Task_55096_Name = {
    Text = "Royaume Maîtrise VII"
  },
  Task_55097_Desc = {
    Text = "Complète toutes les tâches dans ce chapitre pour réclamer des récompenses."
  },
  Task_55097_Name = {
    Text = "Royaume Maîtrise VIII"
  },
  Task_55098_Desc = {
    Text = "Élever 3 personnages Ultra au niveau 60"
  },
  Task_55098_Name = {
    Text = "Royaume Maîtrise VII"
  },
  Task_55099_Desc = {
    Text = "Élever 1 personnage Ultra au Niveau 60"
  },
  Task_55099_Name = {
    Text = "Maîtrise de Royaume VI"
  },
  Task_55100_Desc = {
    Text = "Élever un personnage Chaos au Niveau 60"
  },
  Task_55100_Name = {
    Text = "Maîtrise de Royaume VI"
  },
  Task_55101_Desc = {
    Text = "Élever un personnage Aequor au Niveau 60"
  },
  Task_55101_Name = {
    Text = "Maîtrise de Royaume VI"
  },
  Task_55102_Desc = {
    Text = "Élever un personnage Caro au Niveau 60."
  },
  Task_55102_Name = {
    Text = "Maîtrise de Royaume VI"
  },
  Task_55103_Desc = {
    Text = "Élever 6 personnages Ultra au niveau 60"
  },
  Task_55103_Name = {
    Text = "Royaume Maîtrise VIII"
  },
  Task_55104_Desc = {
    Text = "Élever six personnages Aequor au Niveau 60."
  },
  Task_55104_Name = {
    Text = "Royaume Maîtrise VIII"
  },
  Task_55105_Desc = {
    Text = "Élever six personnages Caro au niveau 60."
  },
  Task_55105_Name = {
    Text = "Royaume Maîtrise VIII"
  },
  Task_55106_Desc = {
    Text = "Élever six personnages Chaos au niveau 60"
  },
  Task_55106_Name = {
    Text = "Royaume Maîtrise VIII"
  },
  Task_55177_Desc = {
    Text = "Terminer toutes les tâches dans « Jardin d'antan : Terminer »"
  },
  Task_55178_Desc = {
    Text = "Souvenirs du jardin · Royaume"
  },
  Task_55179_Desc = {
    Text = "La maison de fleurs de Colette"
  },
  Task_55180_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 2 fois dans « Souvenirs du jardin »"
  },
  Task_55181_Desc = {
    Text = "Terminez \"Tiny Kingdom\" en toute difficulté"
  },
  Task_55182_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 1 victoire dans « Souvenirs du jardin »"
  },
  Task_55183_Desc = {
    Text = "Mémoires de Jardin·Achèvement"
  },
  Task_55184_Desc = {
    Text = "Compléter \"Le Poème de la Floraison\" en n'importe quelle difficulté"
  },
  Task_55185_Desc = {
    Text = "Dans le \"Jardin des Roses\", échangez des poèmes pour recevoir 100 réponses"
  },
  Task_55186_Desc = {
    Text = "Dans le \"Jardin des Roses\", échangez des poèmes pour recevoir 200 réponses"
  },
  Task_55187_Desc = {
    Text = "Clear \"Ashes\" en n'importe quelle difficulté"
  },
  Task_55188_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter 2 victoires dans « Souvenirs du jardin »"
  },
  Task_55189_Desc = {
    Text = "Dans le jardin de fleurs de \"Platycodon\", échangez de la poésie pour recevoir 200 réponses"
  },
  Task_55190_Desc = {
    Text = "Dans le jardin de fleurs de \"Platycodon\", échangez des poèmes pour recevoir 100 réponses"
  },
  Task_55191_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter une victoire dans « Souvenirs du jardin »"
  },
  Task_55192_Desc = {
    Text = "Complétez l'enregistrement de l'opération spéciale \"Demeure de la rose\"."
  },
  Task_55193_Desc = {
    Text = "Terminez \"Holding Hands\" en toute difficulté"
  },
  Task_55194_Desc = {
    Text = "Compléter \"La Première Rose\" en n'importe quelle difficulté"
  },
  Task_55195_Desc = {
    Text = "Vous pouvez obtenir 200 récompenses en échangeant de la poésie dans le \"Jardin Iris\"."
  },
  Task_55196_Desc = {
    Text = "Utiliser un réveilleur du domaine hyperdimensionnel pour remporter une victoire dans « Souvenirs du jardin »"
  },
  Task_55197_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter 2 victoires dans « Souvenirs du jardin »"
  },
  Task_55198_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter 2 fois dans « Souvenirs du jardin »"
  },
  Task_55199_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter une victoire dans « Souvenirs du jardin »"
  },
  Task_55200_Desc = {
    Text = "Obtenez 100 retours en échangeant de la poésie dans le \"Jardin Iris\"."
  },
  Task_55426_Desc = {
    Text = "Vaincre Colette"
  },
  Task_55426_Name = {Text = "Objectif"},
  Task_55852_Desc = {
    Text = "Élevez 1 Réveilleur au Niveau 70"
  },
  Task_55852_Name = {Text = "Quête 2"},
  Task_55853_Desc = {
    Text = "Compléter l'Opération·Mode Normal Chapitre 7"
  },
  Task_55853_Name = {Text = "Quête 3"},
  Task_55854_Desc = {
    Text = "Élevez 4 Réveilleurs au Niveau 62"
  },
  Task_55854_Name = {Text = "Tâche 1"},
  Task_55855_Desc = {
    Text = "Tout Réveilleur atteignant le niveau d'Illumination 4 : Approfondissement de la personnalité"
  },
  Task_55855_Name = {Text = "Mission 4"},
  Task_55856_Desc = {
    Text = "Niveau de Formation D-Effet Régional atteint 150"
  },
  Task_55856_Name = {Text = "Quête 5"},
  Task_55857_Desc = {
    Text = "Complète toutes les tâches dans la phase pour réclamer des récompenses"
  },
  Task_55857_Name = {
    Text = "Étape Huit"
  },
  Task_55858_Desc = {
    Text = "Complète toutes les tâches dans la phase pour réclamer des récompenses"
  },
  Task_55858_Name = {
    Text = "Étape Sept"
  },
  Task_55859_Desc = {
    Text = "Élevez 1 Réveilleur au Niveau 62"
  },
  Task_55859_Name = {Text = "Quête 2"},
  Task_55860_Desc = {
    Text = "Compléter l'Opération·Mode Normal Chapitre 6"
  },
  Task_55860_Name = {Text = "Quête 3"},
  Task_55861_Desc = {
    Text = "Élevez n'importe quelle compétence de Réveilleur au Niveau 6"
  },
  Task_55861_Name = {Text = "Tâche 1"},
  Task_55862_Desc = {
    Text = "Activez n'importe quel Cadeau de Réveil une fois"
  },
  Task_55862_Name = {Text = "Mission 4"},
  Task_55863_Desc = {
    Text = "Valeur de Formation D-Effet Régional atteinte 50"
  },
  Task_55863_Name = {Text = "Quête 5"},
  Task_56002_Desc = {
    Text = "Complétez \"Déchu des géants\" en difficulté Difficile dans Le Vagabondage"
  },
  Task_56002_Name = {
    Text = "Valeur inégalée·Difficile"
  },
  Task_56003_Desc = {
    Text = "Complétez \"Tout comme d'habitude\" en difficulté Difficile dans Le Vagabondage"
  },
  Task_56003_Name = {
    Text = "Villes invisibles·Difficile"
  },
  Task_56004_Desc = {
    Text = "Complétez \"Déchu des géants\" dans Le Vagabondage"
  },
  Task_56004_Name = {
    Text = "Férocité sans pareille"
  },
  Task_56005_Desc = {
    Text = "Complétez l'enregistrement spécial \"Fission Tranquille\" en difficulté Difficile"
  },
  Task_56005_Name = {
    Text = "Retour à la Source de la Rivière · Difficile"
  },
  Task_56006_Desc = {
    Text = "Complétez l'enregistrement spécial \"Couleur du Sang\" en difficulté Difficile"
  },
  Task_56006_Name = {
    Text = "Bienveillance Éternelle · Difficile"
  },
  Task_56007_Desc = {
    Text = "Compléter le dossier spécial \"Fission Tranquille\""
  },
  Task_56007_Name = {
    Text = "Retour à la source de la rivière"
  },
  Task_56008_Desc = {
    Text = "Complétez l'enregistrement spécial \"Couleur de Sang\""
  },
  Task_56008_Name = {
    Text = "Miséricorde éternelle"
  },
  Task_56009_Desc = {
    Text = "Complétez la \"Désacralisation\" dans le paysage des rêves"
  },
  Task_56009_Name = {
    Text = "Fanatisme tordu"
  },
  Task_56103_Desc = {
    Text = ": Inflige 50000 couches de poison à l'ennemi"
  },
  Task_56103_Name = {
    Text = "Poison de la réalité III"
  },
  Task_56104_Desc = {
    Text = ": Inflige 100000 couches de poison à l'ennemi"
  },
  Task_56104_Name = {
    Text = "Poison de la réalité IV"
  },
  Task_56106_Desc = {
    Text = "Avoir 6 Réveilleurs au Niveau 80"
  },
  Task_56106_Name = {
    Text = "«Pouvoir transcendant»V"
  },
  Task_56107_Desc = {
    Text = "Complétez le Paysage de rêve \"Au-delà de l'Horizon : Supérieur\""
  },
  Task_56107_Name = {Text = "Chute"},
  Task_56108_Desc = {
    Text = "Terminez 200 Plongées Fantasmagoriques"
  },
  Task_56108_Name = {
    Text = "Voyage du cœur des rêves"
  },
  Task_56109_Desc = {
    Text = "Terminez 300 Plongées Fantasmagoriques"
  },
  Task_56109_Name = {
    Text = "Marcheur de Rêves"
  },
  Task_56110_Desc = {
    Text = "Compléter 500 Plongées Fantasmiques"
  },
  Task_56110_Name = {
    Text = "Tisseur de Rêves"
  },
  Task_56111_Desc = {
    Text = "Avoir 8 Réveilleurs au Niveau 80"
  },
  Task_56111_Name = {
    Text = "«Pouvoir transcendant»VI"
  },
  Task_56112_Desc = {
    Text = "Posséder 10 Éveilleurs de niveau 80"
  },
  Task_56112_Name = {
    Text = "«Pouvoir transcendant»VII"
  },
  Task_56113_Desc = {
    Text = "Atteindre le Niveau d'Affinité 10 avec 8 Réveillés"
  },
  Task_56113_Name = {
    Text = "Plus d'étrangers"
  },
  Task_56115_Desc = {
    Text = "Synthétiser des matériaux 11111 fois"
  },
  Task_56115_Name = {
    Text = "Le chaudron de course de Mythag"
  },
  Task_56116_Desc = {
    Text = "Posséder 200 Pactes de niveau 12"
  },
  Task_56116_Name = {
    Text = "Gardien Tabou IV"
  },
  Task_56117_Desc = {
    Text = "Atteindre le Niveau d'Affinité 10 avec 4 Corps Réveillés"
  },
  Task_56117_Name = {
    Text = "Duo parfait IX"
  },
  Task_56118_Desc = {
    Text = "Améliorez les Compétences de l'Éveilleur 400 fois"
  },
  Task_56118_Name = {
    Text = "\"Maîtrise de toutes les armes\" II"
  },
  Task_56120_Desc = {
    Text = "Avoir 30 Réveilleurs au Niveau 80"
  },
  Task_56120_Name = {
    Text = "Déclaration de Guerre Contre l'Illusion III"
  },
  Task_56121_Desc = {
    Text = "Avoir 25 Réveilleurs au Niveau 80"
  },
  Task_56121_Name = {
    Text = "Déclaration de Guerre Contre l'Illusion II"
  },
  Task_56122_Desc = {
    Text = "Posséder 20 Éveilleurs de niveau 80"
  },
  Task_56122_Name = {
    Text = "Déclaration de Guerre Contre l'Illusion I"
  },
  Task_56123_Desc = {
    Text = "Posséder 15 Éveilleurs de niveau 80"
  },
  Task_56123_Name = {
    Text = "«Pouvoir transcendant»VIII"
  },
  Task_56126_Desc = {
    Text = "Posséder 40 Éveilleurs de niveau 80"
  },
  Task_56126_Name = {
    Text = "Déclaration de Guerre Contre l'Illusion V"
  },
  Task_56127_Desc = {
    Text = "Posséder 35 Éveilleurs de niveau 80"
  },
  Task_56127_Name = {
    Text = "Déclaration de Guerre Contre l'Illusion IV"
  },
  Task_56128_Desc = {
    Text = "Consommation cumulée de 250000 le sigil noir"
  },
  Task_56128_Name = {
    Text = "Bienvenue \"Lumière\" V"
  },
  Task_56129_Desc = {
    Text = "Consommation cumulée de 1000000 le sigil noir"
  },
  Task_56129_Name = {
    Text = "Bienvenue \"Lumière\" VII"
  },
  Task_56130_Desc = {
    Text = "Consommation cumulée de 500000 le sigil noir"
  },
  Task_56130_Name = {
    Text = "Bienvenue \"Lumière\" VI"
  },
  Task_56131_Desc = {
    Text = "Améliorez les Compétences de l'Éveilleur 800 fois"
  },
  Task_56131_Name = {
    Text = "\"Maître de toutes les armes\"VI"
  },
  Task_56132_Desc = {
    Text = "Améliorez les Compétences de l'Éveilleur 700 fois"
  },
  Task_56132_Name = {
    Text = "\"Maître de toutes les armes\"V"
  },
  Task_56133_Desc = {
    Text = "Améliorez les Compétences de l'Éveilleur 600 fois"
  },
  Task_56133_Name = {
    Text = "\"Maîtrise de toutes les armes\" IV"
  },
  Task_56134_Desc = {
    Text = "Améliorez les Compétences de l'Éveilleur 500 fois"
  },
  Task_56134_Name = {
    Text = "\"Maîtrise de toutes les armes\" III"
  },
  Task_56135_Desc = {
    Text = "Terminez la transcription du pacte 5000 fois"
  },
  Task_56135_Name = {
    Text = "Noir coloré"
  },
  Task_56136_Desc = {
    Text = "Terminez la transcription du pacte 2500 fois"
  },
  Task_56136_Name = {
    Text = "Cœur capricieux"
  },
  Task_56137_Desc = {
    Text = "Terminez la transcription du pacte 1000 fois"
  },
  Task_56137_Name = {
    Text = "Retour au brouillon"
  },
  Task_56138_Desc = {
    Text = "Améliorez les Compétences de l'Éveilleur 900 fois"
  },
  Task_56138_Name = {
    Text = "«Maîtrise des armes»VII"
  },
  Task_56140_Desc = {
    Text = "Terminez la transcription du pacte 10000 fois"
  },
  Task_56140_Name = {
    Text = "Client démon"
  },
  Task_56156_Desc = {
    Text = "Roue du Destin empilée 800 fois"
  },
  Task_56156_Name = {
    Text = "L'avenir de l'Entrelacement Quantique II"
  },
  Task_56157_Desc = {
    Text = "Roue du Destin empilée 900 fois"
  },
  Task_56157_Name = {
    Text = "Futur de l'Enchevêtrement Quantique III"
  },
  Task_56161_Desc = {
    Text = "L'Affinité de Horla atteint le Niveau 10"
  },
  Task_56162_Desc = {
    Text = "L'Affinité de Miryam atteint le niveau 10"
  },
  Task_56177_Desc = {
    Text = "Gagnez 80 Roues de Destin différentes"
  },
  Task_56177_Name = {
    Text = "Tisseur de destins"
  },
  Task_56178_Desc = {
    Text = "Gagnez 70 Roues de Destin différentes"
  },
  Task_56178_Name = {
    Text = "Maître de l'incertitude"
  },
  Task_56179_Desc = {
    Text = "Améliorez les Compétences de l'Éveilleur 300 fois"
  },
  Task_56179_Name = {
    Text = "\"Maîtrise de toutes les armes\" I"
  },
  Task_56180_Desc = {
    Text = "Roue du Destin empilée 1100 fois"
  },
  Task_56180_Name = {
    Text = "L'avenir de l'Entrelacement Quantique V"
  },
  Task_56181_Desc = {
    Text = "Roue du Destin empilée 1200 fois"
  },
  Task_56181_Name = {
    Text = "Futur de l'Enchevêtrement Quantique VI"
  },
  Task_56182_Desc = {
    Text = "1000 J'aime"
  },
  Task_56182_Name = {
    Text = "Bandit social"
  },
  Task_56184_Desc = {Text = "250 J'aime"},
  Task_56184_Name = {
    Text = "Un grand pas en avant"
  },
  Task_56185_Desc = {Text = "500 J'aime"},
  Task_56185_Name = {
    Text = "Un grand pas vers le monde"
  },
  Task_56186_Desc = {
    Text = "Démonter 2000 Roues de Destinée"
  },
  Task_56186_Name = {
    Text = "Maître du destin"
  },
  Task_56187_Desc = {
    Text = "Démonter 1000 Roues de Destinée"
  },
  Task_56187_Name = {
    Text = "Saisir le destin à la gorge"
  },
  Task_56188_Desc = {
    Text = "Gagnez 60 Roues de Destin différentes"
  },
  Task_56188_Name = {
    Text = "Apprenti du Destin II"
  },
  Task_56189_Desc = {
    Text = "Gagnez 50 Roues de Destin différentes"
  },
  Task_56189_Name = {
    Text = "Acolyte du Destin I"
  },
  Task_56191_Desc = {
    Text = "Roue du Destin empilée 1000 fois"
  },
  Task_56191_Name = {
    Text = "L'avenir de l'Entrelacement Quantique IV"
  },
  Task_56192_Desc = {
    Text = "Démonter 500 Roues de Destinée"
  },
  Task_56192_Name = {
    Text = "Défier le destin"
  },
  Task_56349_Desc = {
    Text = "Vaincre le boss \"Aigis\"."
  },
  Task_56349_Name = {Text = "Objectif"},
  Task_56350_Desc = {
    Text = "Vaincre le boss \"Jonquille\"."
  },
  Task_56350_Name = {Text = "Objectif"},
  Task_56351_Desc = {
    Text = "Vaincre le boss \"Leigh\"."
  },
  Task_56351_Name = {Text = "Objectif"},
  Task_56352_Desc = {
    Text = "Vaincre le boss \"Horla.\""
  },
  Task_56352_Name = {Text = "Objectif"},
  Task_56353_Desc = {
    Text = "Vaincre le boss \"24\"."
  },
  Task_56353_Name = {Text = "Objectif"},
  Task_56412_Desc = {
    Text = "Complétez \"Son Arrivée\" à n'importe quelle difficulté"
  },
  Task_56413_Desc = {
    Text = "Complétez \"Exécuteur\" à n'importe quelle difficulté"
  },
  Task_56414_Desc = {
    Text = "Ventre Sombre · Nettoyé"
  },
  Task_56415_Desc = {
    Text = "Compléter \"Voile\" en n'importe quelle difficulté"
  },
  Task_56416_Desc = {
    Text = "Ventre Sombre · Royaume"
  },
  Task_56417_Desc = {
    Text = "Complétez \"Dormance\" à n'importe quelle difficulté"
  },
  Task_56420_Desc = {
    Text = "Terminez \"Slaughter Lamb\" en toute difficulté"
  },
  Task_56421_Desc = {
    Text = "Terminez \"Time-Space Chasm\" en toute difficulté"
  },
  Task_56422_Desc = {
    Text = "Terminez \"Étoile Jaune\" à n'importe quelle difficulté"
  },
  Task_57121_Desc = {
    Text = "Terminez \"Slaughter Lamb\" en difficulté Folie"
  },
  Task_57122_Desc = {
    Text = "Complétez \"Exécuteur\" en difficulté Folie"
  },
  Task_57123_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter 2 victoires dans « Utérus obscur »"
  },
  Task_57124_Desc = {
    Text = "Utiliser un réveilleur du domaine hyperdimensionnel pour remporter 2 fois dans « Utérus obscur »"
  },
  Task_57125_Desc = {
    Text = "Complétez \"Son arrivée\" en difficulté Folie"
  },
  Task_57126_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter une victoire dans « Utérus obscur »"
  },
  Task_57127_Desc = {
    Text = "Effacez le \"Gouffre Espace-Temps\" en difficulté Folie"
  },
  Task_57128_Desc = {
    Text = "Complétez \"Étoile jaune\" à la difficulté Folie"
  },
  Task_57129_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 1 victoire dans « Utérus obscur »"
  },
  Task_57130_Desc = {
    Text = "Complétez \"Hibernation\" en difficulté Folie"
  },
  Task_57131_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 2 victoires dans « Utérus obscur »"
  },
  Task_57132_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter une victoire dans « Utérus obscur »"
  },
  Task_57133_Desc = {
    Text = "Complétez toutes les missions dans \"Utérus Sombre · Clair\" et \"Utérus Sombre · Royaume\""
  },
  Task_57134_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter 2 victoires dans « Utérus obscur »"
  },
  Task_57135_Desc = {
    Text = "Complétez \"Voile\" en difficulté Folie"
  },
  Task_57136_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter une victoire dans « Utérus obscur »"
  },
  Task_57137_Desc = {
    Text = "Ventre Sombre · Folie"
  },
  Task_57369_Desc = {
    Text = "Complète \"Transporteur de Branches\" à n'importe quelle difficulté"
  },
  Task_57370_Desc = {
    Text = "Contes au clair de lune·Folie"
  },
  Task_57371_Desc = {
    Text = "Complétez \"Mystère de la chambre secrète\" à n'importe quelle difficulté"
  },
  Task_57372_Desc = {
    Text = "Contes au clair de lune·Achèvement"
  },
  Task_57373_Desc = {
    Text = "Complète \"Amasser des Branches\" à la difficulté Folie"
  },
  Task_57374_Desc = {
    Text = "Complétez \"Cadavre sans tête\" à n'importe quelle difficulté"
  },
  Task_57375_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 2 victoires dans « Légendes sous la lune »"
  },
  Task_57376_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter 2 victoires dans « Légendes sous la lune »"
  },
  Task_57377_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter une victoire dans « Légendes sous la lune »"
  },
  Task_57378_Desc = {
    Text = "Terminez \"Unexpected Visitor\" en difficulté Folie"
  },
  Task_57379_Desc = {
    Text = "Effacez le \"Cadavre Sans Tête\" en difficulté Folie"
  },
  Task_57380_Desc = {
    Text = "Débloqué après avoir terminé toutes les tâches de \"Contes au Clair de Lune · Réalisation\""
  },
  Task_57381_Desc = {
    Text = "Terminez \"Room Escape Dilemma\" en difficulté Folie"
  },
  Task_57382_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter une victoire dans « Légendes sous la lune »"
  },
  Task_57383_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter 2 victoires dans « Légendes sous la lune »"
  },
  Task_57384_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter une victoire dans « Légendes sous la lune »"
  },
  Task_57385_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter 2 victoires dans « Légendes sous la lune »"
  },
  Task_57386_Desc = {
    Text = "Complétez \"Paysans chanceux\" à n'importe quelle difficulté"
  },
  Task_57387_Desc = {
    Text = "Terminez \"Testimony from Absence\" en difficulté Folie"
  },
  Task_57388_Desc = {
    Text = "Complétez \"Ami des détectives\" à n'importe quelle difficulté"
  },
  Task_57389_Desc = {
    Text = "Complétez \"Visiteur inattendu\" à n'importe quelle difficulté"
  },
  Task_57390_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 1 victoire dans « Légendes sous la lune »"
  },
  Task_57391_Desc = {
    Text = "Contes au clair de lune·Royaume"
  },
  Task_57392_Desc = {
    Text = "Terminez \"Detective's Friend\" en difficulté Folie"
  },
  Task_57393_Desc = {
    Text = "Complète \"Alibi Absent\" à n'importe quelle difficulté"
  },
  Task_57394_Desc = {
    Text = "Terminez \"Lucky Commoner\" en difficulté Folie"
  },
  Task_57404_Desc = {
    Text = "Complétez \"Épilogue\" à n'importe quelle difficulté"
  },
  Task_57405_Desc = {
    Text = "Complétez \"Truc du renversement\" à n'importe quelle difficulté"
  },
  Task_57406_Desc = {
    Text = "Terminez \"Epilogue\" en difficulté Folie"
  },
  Task_57407_Desc = {
    Text = "Complétez \"Truc du renversement\" en difficulté Folie"
  },
  Task_57409_Desc = {
    Text = "Compléter le Dossier Spécial « Joyeuse Chasse ! »"
  },
  Task_57570_Desc = {
    Text = "Complétez \"Truc du renversement\" à n'importe quelle difficulté"
  },
  Task_57571_Desc = {
    Text = "Complétez \"Ami des détectives\" à n'importe quelle difficulté"
  },
  Task_57572_Desc = {
    Text = "Complétez \"Cadavre sans tête\" à n'importe quelle difficulté"
  },
  Task_57573_Desc = {
    Text = "Terminez \"Slaughter Lamb\" en toute difficulté"
  },
  Task_57574_Desc = {
    Text = "Complète \"Alibi Absent\" à n'importe quelle difficulté"
  },
  Task_57575_Desc = {
    Text = "Terminez \"Étoile Jaune\" à n'importe quelle difficulté"
  },
  Task_57576_Desc = {
    Text = "Complétez \"Son Arrivée\" à n'importe quelle difficulté"
  },
  Task_57577_Desc = {
    Text = "Complétez \"Exécuteur\" à n'importe quelle difficulté"
  },
  Task_57578_Desc = {
    Text = "Complétez \"Épilogue\" à n'importe quelle difficulté"
  },
  Task_57579_Desc = {
    Text = "Compléter \"Voile\" en n'importe quelle difficulté"
  },
  Task_57580_Desc = {
    Text = "Complétez \"Visiteur inattendu\" à n'importe quelle difficulté"
  },
  Task_57581_Desc = {
    Text = "Complétez \"Dormance\" à n'importe quelle difficulté"
  },
  Task_57582_Desc = {
    Text = "Terminez \"Time-Space Chasm\" en toute difficulté"
  },
  Task_57583_Desc = {
    Text = "Complète \"Transporteur de Branches\" à n'importe quelle difficulté"
  },
  Task_57584_Desc = {
    Text = "Complétez \"Paysans chanceux\" à n'importe quelle difficulté"
  },
  Task_57585_Desc = {
    Text = "Complétez \"Mystère de la chambre secrète\" à n'importe quelle difficulté"
  },
  Task_58104_Desc = {
    Text = "Effacez toute difficulté dans \"Repentance\""
  },
  Task_58107_Desc = {
    Text = "Clear \"Accusation\" en n'importe quelle difficulté"
  },
  Task_58109_Desc = {
    Text = "Vaincre \"Paranoïa\" en difficulté Folie"
  },
  Task_58110_Desc = {
    Text = "Vaincre \"Concours\" à n'importe quelle difficulté"
  },
  Task_58111_Desc = {
    Text = "Vaincre \"Concours\" à n'importe quelle difficulté"
  },
  Task_58112_Desc = {
    Text = "Effacez toute difficulté dans \"Repentance\""
  },
  Task_58113_Desc = {
    Text = "Vaincre \"Paranoïa\" à n'importe quelle difficulté"
  },
  Task_58114_Desc = {
    Text = "Terminez \"Confession\" en difficulté Folie"
  },
  Task_58115_Desc = {
    Text = "Compléter n'importe quelle difficulté de \"Exaction\""
  },
  Task_58118_Desc = {
    Text = "Clear \"Accusation\" en difficulté folie"
  },
  Task_58119_Desc = {
    Text = "Complétez \"Revendication\" en difficulté Folie"
  },
  Task_58120_Desc = {
    Text = "Débloqué après avoir terminé tous les niveaux de \"Chemin de l'Église\" à n'importe quelle difficulté"
  },
  Task_58122_Desc = {
    Text = "Clear \"Accusation\" en n'importe quelle difficulté"
  },
  Task_58123_Desc = {
    Text = "Salle de vente de l'église"
  },
  Task_58124_Desc = {
    Text = "Vaincre \"Paranoïa\" à n'importe quelle difficulté"
  },
  Task_58126_Desc = {
    Text = "Compléter n'importe quelle difficulté de \"Exaction\""
  },
  Task_58128_Desc = {
    Text = "Chemin de l'Église · Folie"
  },
  Task_58130_Desc = {
    Text = "Chemin de l'Église · Croissance"
  },
  Task_58131_Desc = {
    Text = "Vaincre \"Concours\" en difficulté Folie"
  },
  Task_58132_Desc = {
    Text = "Acheter 100 fois lors de la «Vente Magique de Big John»"
  },
  Task_58133_Desc = {
    Text = "Acheter 200 fois lors de la «Vente Magique de Big John»"
  },
  Task_58134_Desc = {
    Text = "Effectuer 100 achats dans \"La boutique de Mme Gray\""
  },
  Task_58135_Desc = {
    Text = "Acheter 200 fois dans «La Boutique de Mme Gray»"
  },
  Task_58136_Desc = {
    Text = "\"Achetez 200 fois dans 'Vente de Forgeron'\""
  },
  Task_58137_Desc = {
    Text = "\"Achetez 100 fois dans 'Vente de Forgeron'\""
  },
  Task_58138_Desc = {
    Text = "Compléter l'événement d'investigation \"{s1}\""
  },
  Task_58500_Desc = {
    Text = "Son Rugissant·Complet"
  },
  Task_58501_Desc = {
    Text = "Complétez \"Orchestration\" en difficulté Folie"
  },
  Task_58502_Desc = {
    Text = "Terminez \"Prelude\" en toute difficulté"
  },
  Task_58503_Desc = {
    Text = "Vaincre \"Petit Valse\" à n'importe quelle difficulté"
  },
  Task_58504_Desc = {
    Text = "Vaincre \"Écho\" à n'importe quelle difficulté"
  },
  Task_58505_Desc = {
    Text = "Complétez \"Finale\" à n'importe quelle difficulté"
  },
  Task_58506_Desc = {
    Text = "Terminez \"Largo\" en toute difficulté"
  },
  Task_58507_Desc = {
    Text = "Effacez le \"Cantique\" en difficulté Folie"
  },
  Task_58508_Desc = {
    Text = "Terminez \"Minuet\" en difficulté Folie"
  },
  Task_58509_Desc = {
    Text = "Vaincre \"Écho\" à n'importe quelle difficulté"
  },
  Task_58510_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 1 victoire dans « Son de grondement »"
  },
  Task_58511_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 2 fois dans « Son de grondement »"
  },
  Task_58512_Desc = {
    Text = "Complétez \"Le Guide des Rêves Perdu\" à n'importe quelle difficulté"
  },
  Task_58513_Desc = {
    Text = "Son Rugissant·Royaume"
  },
  Task_58514_Desc = {
    Text = "Vaincre \"Écho\" en difficulté Folie"
  },
  Task_58515_Desc = {
    Text = "Vaincre \"Petit Valse\" à n'importe quelle difficulté"
  },
  Task_58516_Desc = {
    Text = "Son Rugissant·Folie"
  },
  Task_58517_Desc = {
    Text = "Clear \"Allegretto\" en n'importe quelle difficulté"
  },
  Task_58518_Desc = {
    Text = "Terminez \"Prelude\" en difficulté Folie"
  },
  Task_58519_Desc = {
    Text = "Compléter \"Orchestration\" en n'importe quelle difficulté"
  },
  Task_58520_Desc = {
    Text = "Terminer \"Largo\" en difficulté Folie"
  },
  Task_58521_Desc = {
    Text = "Terminez \"Largo\" en toute difficulté"
  },
  Task_58522_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter 2 victoires dans « Son de grondement »"
  },
  Task_58523_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter une victoire dans « Son de grondement »"
  },
  Task_58524_Desc = {
    Text = "Terminez \"Curtain Fall\" en toute difficulté"
  },
  Task_58525_Desc = {
    Text = "Complétez \"Finale\" en difficulté Folie"
  },
  Task_58526_Desc = {
    Text = "Complétez \"Rêve Malavisé\" en difficulté Folie"
  },
  Task_58527_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter 2 victoires dans « Son de grondement »"
  },
  Task_58528_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter une victoire dans « Son de grondement »"
  },
  Task_58529_Desc = {
    Text = "Clear \"Allegretto\" en n'importe quelle difficulté"
  },
  Task_58530_Desc = {
    Text = "Compléter toutes les tâches dans \"Son Rugissant·Clair\""
  },
  Task_58531_Desc = {
    Text = "Terminez \"Prelude\" en toute difficulté"
  },
  Task_58532_Desc = {
    Text = "Terminez \"Curtain Fall\" en toute difficulté"
  },
  Task_58533_Desc = {
    Text = "Compléter \"Orchestration\" en n'importe quelle difficulté"
  },
  Task_58534_Desc = {
    Text = "Complétez \"Le Guide des Rêves Perdu\" à n'importe quelle difficulté"
  },
  Task_58535_Desc = {
    Text = "Complétez \"Finale\" à n'importe quelle difficulté"
  },
  Task_58536_Desc = {
    Text = "Terminez \"Curtain Fall\" en difficulté Folie"
  },
  Task_58537_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter une victoire dans « Son de grondement »"
  },
  Task_58538_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter 2 victoires dans « Son de grondement »"
  },
  Task_58989_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_58989_Name = {
    Text = "Résolution rapide"
  },
  Task_58990_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_58990_Name = {
    Text = "Résolution rapide"
  },
  Task_58991_Desc = {
    Text = "Piger au moins 5 cartes supplémentaires en un tour pendant la Bataille Finale"
  },
  Task_58991_Name = {Text = "Draw!"},
  Task_58992_Desc = {
    Text = "Avoir pas plus de 2 Cartes de Symptômes lors de l'achèvement"
  },
  Task_58992_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_58993_Desc = {
    Text = "Gagnez au moins 4 types différents d'Oraisons"
  },
  Task_58993_Name = {
    Text = "Marque de l'Âme"
  },
  Task_58994_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_58994_Name = {
    Text = "Résolution rapide"
  },
  Task_58995_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_58995_Name = {
    Text = "Résolution rapide"
  },
  Task_58996_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_58996_Name = {
    Text = "Résolution rapide"
  },
  Task_58997_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_58997_Name = {
    Text = "Résolution rapide"
  },
  Task_58998_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_58998_Name = {
    Text = "Résolution rapide"
  },
  Task_58999_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_58999_Name = {
    Text = "Résolution rapide"
  },
  Task_59000_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_59000_Name = {
    Text = "Résolution rapide"
  },
  Task_59001_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_59001_Name = {
    Text = "Passer Parfait"
  },
  Task_59002_Desc = {
    Text = "Avoir pas plus de 3 Cartes de Symptômes lors de l'achèvement"
  },
  Task_59002_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_59003_Desc = {
    Text = "Avoir pas plus de 2 Cartes de Symptômes lors de l'achèvement"
  },
  Task_59003_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_59004_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_59004_Name = {
    Text = "Passer Parfait"
  },
  Task_59005_Desc = {
    Text = "Transportez au moins 8 Reliques à l'achèvement."
  },
  Task_59005_Name = {
    Text = "Planque secrète"
  },
  Task_59006_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_59006_Name = {
    Text = "Passer Parfait"
  },
  Task_59007_Desc = {
    Text = "Transportez au moins 1 Relique maudite à l'achèvement."
  },
  Task_59007_Name = {
    Text = "Planque secrète"
  },
  Task_59008_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_59008_Name = {
    Text = "Passer Parfait"
  },
  Task_59009_Desc = {
    Text = "Jouer au moins 6 Cartes en un tour lors de la Bataille Finale"
  },
  Task_59009_Name = {Text = "Mon tour !"},
  Task_59010_Desc = {
    Text = "Lors d'un tour de la bataille finale, empilez un bouclier équivalent à au moins 65% de la santé maximale."
  },
  Task_59010_Name = {Text = "Ironclad"},
  Task_59011_Desc = {
    Text = "Jouer au moins 6 Cartes en un tour lors de la Bataille Finale"
  },
  Task_59011_Name = {Text = "Mon tour !"},
  Task_59012_Desc = {
    Text = "Lors d'un tour de la bataille finale, empilez un bouclier équivalent à au moins 65% de la santé maximale."
  },
  Task_59012_Name = {Text = "Ironclad"},
  Task_59013_Desc = {
    Text = "Piger au moins 5 cartes supplémentaires en un tour pendant la Bataille Finale"
  },
  Task_59013_Name = {Text = "Draw!"},
  Task_59014_Desc = {
    Text = "Causer au moins 20000 points de dégâts en un tour pendant la Bataille Finale"
  },
  Task_59014_Name = {
    Text = "Attaque totale"
  },
  Task_59015_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_59015_Name = {
    Text = "Élégant et précis"
  },
  Task_59016_Desc = {
    Text = "Gagnez au moins 4 types différents d'Oraisons"
  },
  Task_59016_Name = {
    Text = "Marque de l'Âme"
  },
  Task_59017_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_59017_Name = {
    Text = "Élégant et précis"
  },
  Task_59018_Desc = {
    Text = "Transportez au moins 1 Relique maudite à l'achèvement."
  },
  Task_59018_Name = {
    Text = "Planque secrète"
  },
  Task_59019_Desc = {
    Text = "Réveillez tous les Réveilleurs à l'achèvement"
  },
  Task_59019_Name = {
    Text = "Étreinte infinie"
  },
  Task_59020_Desc = {
    Text = "Transportez au moins 2 Reliques à l'achèvement"
  },
  Task_59020_Name = {
    Text = "Planque secrète"
  },
  Task_59021_Desc = {
    Text = "Transportez au moins 1 Relique maudite à l'achèvement."
  },
  Task_59021_Name = {
    Text = "Planque secrète"
  },
  Task_59022_Desc = {
    Text = "Avoir pas plus de 2 Cartes de Symptômes lors de l'achèvement"
  },
  Task_59022_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_59023_Desc = {
    Text = "Piger au moins 4 cartes supplémentaires en un tour pendant la Bataille Finale"
  },
  Task_59023_Name = {Text = "Draw!"},
  Task_59024_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_59024_Name = {
    Text = "Passer Parfait"
  },
  Task_59025_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_59025_Name = {
    Text = "Passer Parfait"
  },
  Task_59026_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_59026_Name = {
    Text = "Passer Parfait"
  },
  Task_59027_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_59027_Name = {
    Text = "Passer Parfait"
  },
  Task_59028_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_59028_Name = {
    Text = "Passer Parfait"
  },
  Task_59029_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_59029_Name = {
    Text = "Passer Parfait"
  },
  Task_59030_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_59030_Name = {
    Text = "Passer Parfait"
  },
  Task_59031_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_59031_Name = {
    Text = "Passer Parfait"
  },
  Task_59032_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_59032_Name = {
    Text = "Passer Parfait"
  },
  Task_59033_Desc = {
    Text = "Réveillez tous les Réveilleurs à l'achèvement"
  },
  Task_59033_Name = {
    Text = "Étreinte infinie"
  },
  Task_59034_Desc = {
    Text = "Transportez au moins 2 Reliques à l'achèvement"
  },
  Task_59034_Name = {
    Text = "Planque secrète"
  },
  Task_59035_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_59035_Name = {
    Text = "Résolution rapide"
  },
  Task_59036_Desc = {
    Text = "Transportez au moins 1 Relique maudite à l'achèvement."
  },
  Task_59036_Name = {
    Text = "Planque secrète"
  },
  Task_59037_Desc = {
    Text = "Gagner la Bataille Finale en moins de 18 tours"
  },
  Task_59037_Name = {
    Text = "Résolution rapide"
  },
  Task_59038_Desc = {
    Text = "Gagner la Bataille Finale en moins de 12 tours"
  },
  Task_59038_Name = {
    Text = "Résolution rapide"
  },
  Task_59039_Desc = {
    Text = "Lors d'un tour de la bataille finale, empilez un bouclier équivalent à au moins 60% de la santé maximale."
  },
  Task_59039_Name = {Text = "Ironclad"},
  Task_59040_Desc = {
    Text = "Jouer au moins 5 Cartes en un tour lors de la Bataille Finale."
  },
  Task_59040_Name = {Text = "Mon tour !"},
  Task_59041_Desc = {
    Text = "Lors d'un tour de la bataille finale, empilez un bouclier équivalent à au moins 60% de la santé maximale."
  },
  Task_59041_Name = {Text = "Ironclad"},
  Task_59042_Desc = {
    Text = "Avoir pas plus de 3 Cartes de Symptômes lors de l'achèvement"
  },
  Task_59042_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_59043_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_59043_Name = {
    Text = "Élégant et précis"
  },
  Task_59044_Desc = {
    Text = "Gagner la Bataille Finale en moins de 18 tours"
  },
  Task_59044_Name = {
    Text = "Résolution rapide"
  },
  Task_59045_Desc = {
    Text = "Piger au moins 4 cartes supplémentaires en un tour pendant la Bataille Finale"
  },
  Task_59045_Name = {Text = "Draw!"},
  Task_59046_Desc = {
    Text = "Transportez au moins 8 Reliques à l'achèvement."
  },
  Task_59046_Name = {
    Text = "Planque secrète"
  },
  Task_59047_Desc = {
    Text = "Jouer au moins 5 Cartes en un tour lors de la Bataille Finale."
  },
  Task_59047_Name = {Text = "Mon tour !"},
  Task_59048_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_59048_Name = {
    Text = "Élégant et précis"
  },
  Task_59438_Desc = {
    Text = "L'Affinité de Ryker a atteint le Niveau 10."
  },
  Task_60163_Desc = {
    Text = "Complète le Niveau"
  },
  Task_60163_Name = {
    Text = "Complète le Niveau"
  },
  Task_60163_UnlockCondDesc = {
    Text = "Déverrouille après avoir complété la Étape 8-9"
  },
  Task_60164_Desc = {
    Text = "Complète le Niveau"
  },
  Task_60164_Name = {
    Text = "Complète le Niveau"
  },
  Task_60164_UnlockCondDesc = {
    Text = "Déverrouille après avoir complété la Étape 8-11"
  },
  Task_60165_Desc = {
    Text = "Complète le Niveau"
  },
  Task_60165_Name = {
    Text = "Complète le Niveau"
  },
  Task_60165_UnlockCondDesc = {
    Text = "Déverrouille après avoir complété la Étape 8-10"
  },
  Task_60443_Desc = {
    Text = "Complétez l'enquête principale Chapitre 4 \"Dans le Silence\""
  },
  Task_60444_Desc = {
    Text = "Première fois atteignant 150 points d'entraînement"
  },
  Task_60445_Desc = {
    Text = "Première fois atteignant 325 points d'entraînement"
  },
  Task_60446_Desc = {
    Text = "Première fois atteignant 50 Points d’Entraînement"
  },
  Task_60447_Desc = {
    Text = "Points d'Entraînement atteignent 100 pour la première fois"
  },
  Task_60448_Desc = {
    Text = "Compléter le chapitre principal d'investigation 4 \"En Silence\" à la difficulté Difficile"
  },
  Task_60449_Desc = {
    Text = "Première fois atteignant 300 points d'entraînement"
  },
  Task_60450_Desc = {
    Text = "Compléter le chapitre principal d'investigation 2 : \"Au Nom des Sculptures en Cire\""
  },
  Task_60451_Desc = {
    Text = "Compléter l'Investigation Principale Chapitre 5 « Œil de Tempête » en difficulté Difficile"
  },
  Task_60452_Desc = {
    Text = "La Valeur d'Entraînement Spéciale atteint 225 pour la première fois"
  },
  Task_60453_Desc = {
    Text = "Compléter le Chapitre 1 de l'enquête principale \"Secret de l'Est\""
  },
  Task_60454_Desc = {
    Text = "Compléter la Mission Principale d'Investigation Chapitre 6 « Étoiles Tordues » en Difficile"
  },
  Task_60455_Desc = {
    Text = "Compléter le chapitre principal d'investigation 2 \"Au Nom des Sculptures en Cire\" à la difficulté Difficile"
  },
  Task_60456_Desc = {
    Text = "Compléter l'Investigation de la Ligne Principale Chapitre 5 \"Œil de Tempête\""
  },
  Task_60457_Desc = {
    Text = "Compléter l'Investigation Principale Chapitre 3 « Méfiez-vous des Chiens » en Difficile"
  },
  Task_60458_Desc = {
    Text = "Compléter la Mission Principale d'Investigation Chapitre 1 « Secret de l'Est » en Difficile"
  },
  Task_60459_Desc = {
    Text = "Complete Investigation Mainline Chapter 3 \"Watch Out for Dogs\""
  },
  Task_60460_Desc = {
    Text = "Complete Investigation Main Mission Chapter 6 \"Twisted Stars\""
  },
  Task_60461_Desc = {
    Text = "La Valeur d'Entraînement Spéciale atteint 350 pour la première fois"
  },
  Task_60601_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60602_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60603_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60604_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60606_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60607_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60608_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60609_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60610_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60611_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60612_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60613_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60614_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60615_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60616_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60617_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60618_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60619_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60620_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60622_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60623_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60624_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60625_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60626_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60627_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60628_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60629_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60630_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60631_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60633_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60634_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60635_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60636_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60637_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60638_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60639_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60640_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60641_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60642_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60643_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60644_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60645_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60646_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60647_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60648_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60649_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60650_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60651_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60653_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60654_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60655_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60656_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60657_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60658_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60659_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60660_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60661_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60663_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60664_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60665_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60666_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60667_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60668_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60669_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60670_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60671_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60672_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60673_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60674_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60675_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60676_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60677_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60678_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60680_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60681_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60682_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60683_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60684_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60685_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60686_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60687_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60688_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60689_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60690_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60691_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60692_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60694_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60696_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60697_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60699_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60742_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60743_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60747_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60748_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60749_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60750_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60751_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60752_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60754_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60755_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60757_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60758_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60759_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60760_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60761_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60763_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60765_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60766_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60768_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60769_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60770_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60772_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60773_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60774_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60777_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60778_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60779_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60780_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60781_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60782_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60783_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60784_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60785_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60787_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60788_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60789_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60790_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60793_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60795_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60796_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60797_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60798_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60799_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60800_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60801_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60803_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60804_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60805_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_60829_Desc = {
    Text = "L'Affinité de Hameln atteint le niveau 10"
  },
  Task_61103_Desc = {
    Text = "Gagnez une Poupée de Genèse"
  },
  Task_61103_Name = {
    Text = "Gagnez une Poupée de Genèse"
  },
  Task_61104_Desc = {
    Text = "Gagnez un Hilote de Genèse"
  },
  Task_61104_Name = {
    Text = "Gagnez un Hilote de Genèse"
  },
  Task_61105_Desc = {
    Text = "Obtenir Lily"
  },
  Task_61105_Name = {
    Text = "Obtenir Lily"
  },
  Task_61106_Desc = {
    Text = "Obtenir Horla"
  },
  Task_61106_Name = {
    Text = "Obtenir Horla"
  },
  Task_61107_Desc = {
    Text = "Obtenir Miryam"
  },
  Task_61107_Name = {
    Text = "Obtenir Miryam"
  },
  Task_61108_Desc = {
    Text = "Obtenir Ryker"
  },
  Task_61108_Name = {
    Text = "Obtenir Ryker"
  },
  Task_61109_Desc = {
    Text = "Obtenir Sorel"
  },
  Task_61109_Name = {
    Text = "Obtenir Sorel"
  },
  Task_61110_Desc = {
    Text = "Obtenir Salvador"
  },
  Task_61110_Name = {
    Text = "Obtenir Salvador"
  },
  Task_61111_Desc = {
    Text = "Obtenir Wanda"
  },
  Task_61111_Name = {
    Text = "Obtenir Wanda"
  },
  Task_61112_Desc = {
    Text = "Obtenir Tulu"
  },
  Task_61112_Name = {
    Text = "Obtenir Tulu"
  },
  Task_61113_Desc = {Text = "Gagne \"24\""},
  Task_61113_Name = {Text = "Gagne \"24\""},
  Task_61114_Desc = {
    Text = "Obtenir Tawil"
  },
  Task_61114_Name = {
    Text = "Obtenir Tawil"
  },
  Task_61115_Desc = {
    Text = "Obtenir Thais"
  },
  Task_61115_Name = {
    Text = "Obtenir Thais"
  },
  Task_61116_Desc = {
    Text = "Obtenir Hameln"
  },
  Task_61116_Name = {
    Text = "Obtenir Hameln"
  },
  Task_61117_Desc = {
    Text = "Obtenir Jonquille"
  },
  Task_61117_Name = {
    Text = "Obtenir Jonquille"
  },
  Task_61118_Desc = {
    Text = "Obtenir Murphy"
  },
  Task_61118_Name = {
    Text = "Obtenir Murphy"
  },
  Task_61157_Desc = {
    Text = "Compléter le Chapitre 8 de l'Investigation « Symphonie Finale » en difficulté Difficile"
  },
  Task_61158_Desc = {
    Text = "Complete Investigation Chapter 7 \"River of Desire\""
  },
  Task_61159_Desc = {
    Text = "Compléter le Chapitre 7 de l'Investigation « Rivière de Désir » en difficulté Difficile"
  },
  Task_61160_Desc = {
    Text = "Compléter le Chapitre 8 de l'Investigation « Symphonie Finale » en difficulté Difficile"
  },
  Task_61161_Desc = {
    Text = "Complete Investigation Chapter 8 \"Final Symphony\""
  },
  Task_61162_Desc = {
    Text = "Compléter le Chapitre 7 de l'Investigation « Rivière de Désir » en difficulté Difficile"
  },
  Task_61163_Desc = {
    Text = "Complete Investigation Chapter 7 \"River of Desire\""
  },
  Task_61164_Desc = {
    Text = "Complete Investigation Chapter 8 \"Final Symphony\""
  },
  Task_61186_Desc = {
    Text = "Vaincre \"Un Segment de Mémoire\" à n'importe quelle difficulté"
  },
  Task_61187_Desc = {
    Text = "Complétez \"Cité d'Or\" à n'importe quelle difficulté"
  },
  Task_61188_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 1 victoire dans « Cité du lac »"
  },
  Task_61189_Desc = {
    Text = "Terminer toutes les missions de « Ville du lac·Terminer »"
  },
  Task_61190_Desc = {
    Text = "Clear \"Révélation\" à n'importe quelle difficulté"
  },
  Task_61191_Desc = {
    Text = "Complétez \"Réalité\" en difficulté Folie"
  },
  Task_61192_Desc = {
    Text = "Complète \"Ville d'Or\" à la difficulté Folie"
  },
  Task_61193_Desc = {
    Text = "Terminez \"Mirage\" en toute difficulté"
  },
  Task_61194_Desc = {
    Text = "Cité dans le Lac : Complet"
  },
  Task_61195_Desc = {
    Text = "Compléter \"Réalité\" en n'importe quelle difficulté"
  },
  Task_61196_Desc = {
    Text = "Terminez \"Small Canna\" en toute difficulté"
  },
  Task_61197_Desc = {
    Text = "Terminez \"Mirage\" en toute difficulté"
  },
  Task_61198_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter une victoire dans « Cité du lac »"
  },
  Task_61199_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter une victoire dans « Cité du lac »"
  },
  Task_61200_Desc = {
    Text = "Terminer \"Mirage\" en difficulté Folie"
  },
  Task_61201_Desc = {
    Text = "Cité dans le Lac·Royaume"
  },
  Task_61202_Desc = {
    Text = "Complétez \"Cité d'Or\" à n'importe quelle difficulté"
  },
  Task_61203_Desc = {
    Text = "Clear \"Révélation\" à n'importe quelle difficulté"
  },
  Task_61204_Desc = {
    Text = "Clear \"Puits\" à n'importe quelle difficulté"
  },
  Task_61205_Desc = {
    Text = "Vaincre \"Un Segment de Mémoire\" à n'importe quelle difficulté"
  },
  Task_61206_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter une victoire dans « Cité du lac »"
  },
  Task_61207_Desc = {
    Text = "Terminez \"Small Canna\" en difficulté Folie"
  },
  Task_61208_Desc = {
    Text = "Terminez \"Revelation\" en difficulté Folie"
  },
  Task_61209_Desc = {
    Text = "Clear \"Puits\" à n'importe quelle difficulté"
  },
  Task_61210_Desc = {
    Text = "Terminez \"Small Canna\" en toute difficulté"
  },
  Task_61211_Desc = {
    Text = "Ville dans le Lac · Folie"
  },
  Task_61212_Desc = {
    Text = "Compléter \"Réalité\" en n'importe quelle difficulté"
  },
  Task_61213_Desc = {
    Text = "Clear \"A Segment of Memory\" en difficulté folie"
  },
  Task_61214_Desc = {
    Text = "Terminez \"Well\" en difficulté Folie"
  },
  Task_61215_Desc = {
    Text = "Terminer \"Festin Brûlant\" dans Le Vagabond"
  },
  Task_61375_Desc = {
    Text = "Connexion Cumulative : 12 Jours"
  },
  Task_61376_Desc = {
    Text = "Connecte-toi pendant 3 jours cumulés"
  },
  Task_61377_Desc = {
    Text = "Connecté pendant un total de 9 jours"
  },
  Task_61378_Desc = {
    Text = "Connexion Cumulative : 11 Jours"
  },
  Task_61379_Desc = {
    Text = "Connectez-vous pendant un total de 10 jours"
  },
  Task_61380_Desc = {
    Text = "Connexion cumulative pendant 1 jour"
  },
  Task_61381_Desc = {
    Text = "Connectez-vous pendant un total de 4 jours"
  },
  Task_61382_Desc = {
    Text = "Connectez-vous pendant un total de 15 jours"
  },
  Task_61383_Desc = {
    Text = "Connexion cumulative de 14 jours"
  },
  Task_61384_Desc = {
    Text = "Connecte-toi pendant 5 jours cumulés"
  },
  Task_61385_Desc = {
    Text = "Connectez-vous pendant un total de 8 jours"
  },
  Task_61386_Desc = {
    Text = "Connectez-vous pendant un total de 2 jours"
  },
  Task_61387_Desc = {
    Text = "Connexion Cumulative : 13 Jours"
  },
  Task_61388_Desc = {
    Text = "Connexion cumulative pendant 6 jours"
  },
  Task_61389_Desc = {
    Text = "Connecté pendant un total de 16 jours"
  },
  Task_61390_Desc = {
    Text = "Connectez-vous pendant un total de 7 jours"
  },
  Task_61394_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61395_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61396_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61397_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61398_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61399_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61400_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61401_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61402_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61403_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61404_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61405_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61407_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61408_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61409_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61410_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61411_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61412_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61413_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61414_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61415_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61416_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61417_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61418_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61419_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61420_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61421_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61422_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61425_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61426_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61427_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61428_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61430_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61431_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61432_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61433_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61434_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61435_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61436_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61438_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61439_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61440_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61441_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61442_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61443_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61444_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61445_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61446_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61447_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61448_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61449_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61450_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61451_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61452_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61453_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61455_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61456_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61457_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61458_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61459_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61460_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61461_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61462_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61463_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61464_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61465_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61466_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61468_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61469_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61470_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61471_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61472_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61473_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61474_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61475_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61476_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61477_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61478_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61479_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61481_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61519_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61520_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61521_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61522_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61523_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61524_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61525_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61526_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61527_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61528_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61616_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61617_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61620_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61621_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61622_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61623_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61626_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61627_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61628_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61629_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61631_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61633_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61634_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61636_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61637_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61639_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61640_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61642_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61643_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61644_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61645_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61648_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61649_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61650_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61652_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61653_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61654_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61655_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61657_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61659_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61660_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61661_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61662_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61665_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61666_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61668_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61669_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61671_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61672_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61673_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61675_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61676_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61678_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61679_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61681_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61682_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61684_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61685_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61687_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61688_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61690_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61691_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61693_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61694_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61696_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61697_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61699_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61700_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61701_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61702_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61704_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61705_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61706_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61707_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61709_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61710_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61712_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61713_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61716_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61717_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61719_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61720_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61722_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61723_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61725_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61726_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61727_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61729_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61731_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61733_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61734_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61735_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61736_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61739_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61740_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61743_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61744_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61748_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61749_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61750_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61751_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61753_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61754_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61756_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61757_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61758_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61759_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61762_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61763_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61765_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61766_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61767_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61769_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61770_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61771_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61772_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61774_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61777_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61778_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61781_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61782_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61783_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61784_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61785_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61788_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61789_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61791_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61792_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61794_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61795_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61796_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61797_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61798_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61801_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61802_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61804_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61805_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61807_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61808_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61810_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61811_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61814_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61815_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61816_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61817_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61819_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61820_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61821_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61824_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_61825_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_62002_Desc = {
    Text = "Complétez \"Vue de montagne\" en difficulté Folie"
  },
  Task_62003_Desc = {
    Text = "Vaincre \"Défrichage\" en toute difficulté"
  },
  Task_62004_Desc = {
    Text = "Ambition bestiale·Royaume"
  },
  Task_62005_Desc = {
    Text = "Vaincre \"Nuit Froide\" à n'importe quelle difficulté"
  },
  Task_62006_Desc = {
    Text = "Échangez des boutons de fleur pour 200 récompenses dans \"Ambition de Dévorer\""
  },
  Task_62007_Desc = {
    Text = "Échangez des boutons de fleur pour 100 récompenses dans \"Ambition de Dévorer\""
  },
  Task_62008_Desc = {
    Text = "Vaincre \"Nuit Froide\" en difficulté Folie"
  },
  Task_62009_Desc = {
    Text = "Vaincre \"Nuit Froide\" à n'importe quelle difficulté"
  },
  Task_62010_Desc = {
    Text = "Compléter \"Vue de la Montagne\" en n'importe quelle difficulté"
  },
  Task_62011_Desc = {
    Text = "Clear \"Beast Fight\" en n'importe quelle difficulté"
  },
  Task_62012_Desc = {
    Text = "Compléter \"Vue de la Montagne\" en n'importe quelle difficulté"
  },
  Task_62013_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter une victoire dans « Ambition de la bête »"
  },
  Task_62014_Desc = {
    Text = "Gueule de la montagne"
  },
  Task_62015_Desc = {
    Text = "Complète \"Casser le Sol\" à la difficulté Folie"
  },
  Task_62016_Desc = {
    Text = "Ambition Bestiale·Folie"
  },
  Task_62017_Desc = {
    Text = "Terminez \"Return\" en difficulté Folie"
  },
  Task_62018_Desc = {
    Text = "Ambition bestiale : Complet"
  },
  Task_62019_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter une victoire dans « Ambition de la bête »"
  },
  Task_62020_Desc = {
    Text = "Vous pouvez obtenir 100 récompenses en échangeant des bourgeons dans \"Espoir de Résurrection\""
  },
  Task_62021_Desc = {
    Text = "Échangez des boutons de fleur pour 200 récompenses dans \"Esprit de Vengeance\""
  },
  Task_62022_Desc = {
    Text = "Échangez des boutons de fleur pour 100 récompenses dans \"Esprit de Vengeance\""
  },
  Task_62023_Desc = {
    Text = "Terminez toutes les quêtes de « Ambition de la bête · Évaluation »"
  },
  Task_62024_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 1 victoire dans « Ambition de la bête »"
  },
  Task_62025_Desc = {
    Text = "Vous pouvez obtenir 200 récompenses en échangeant des bourgeons dans \"Espoir de Résurrection\"."
  },
  Task_62026_Desc = {
    Text = "Terminez \"Return\" en toute difficulté"
  },
  Task_62027_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter une victoire dans « Ambition de la bête »"
  },
  Task_62028_Desc = {
    Text = "Clear \"Beast Fight\" en n'importe quelle difficulté"
  },
  Task_62029_Desc = {
    Text = "Effacez le \"Combat de la Bête\" en difficulté Folie"
  },
  Task_62030_Desc = {
    Text = "Terminez \"Return\" en toute difficulté"
  },
  Task_62031_Desc = {
    Text = "Vaincre \"Défrichage\" en toute difficulté"
  },
  Task_62092_Desc = {
    Text = "Complétez l'enregistrement de l'opération spéciale \"Retour d'Elworth\"."
  },
  Task_62207_Desc = {
    Text = "Hilote : Affinité Catena a atteint le Niveau 10."
  },
  Task_62209_Desc = {
    Text = "Échapper de la Montagne Neigeuse"
  },
  Task_62209_Name = {Text = "Objectif"},
  Task_62231_Desc = {
    Text = "Éclairer 6 lors de l'obtention de Ryker"
  },
  Task_62231_Name = {
    Text = "Éclairer 6 lors de l'obtention de Ryker"
  },
  Task_62231_UnlockCondDesc = {
    Text = "Event @ Réveillants Ryker Illumination Pack 2 Événement"
  },
  Task_62232_Desc = {
    Text = "Éclairer 2 lors de l'obtention de Jenki"
  },
  Task_62232_Name = {
    Text = "Éclairer 2 lors de l'obtention de Jenki"
  },
  Task_62232_UnlockCondDesc = {
    Text = "Événement @ Réveilleur Jenkin Pack Illuminer 1 Événement"
  },
  Task_62233_Desc = {
    Text = "Éclairer 6 lors de l'obtention de Jenki"
  },
  Task_62233_Name = {
    Text = "Éclairer 6 lors de l'obtention de Jenki"
  },
  Task_62233_UnlockCondDesc = {
    Text = "Événement @ Réveilleur Jenkin Pack Illumination 2 Événement"
  },
  Task_62234_Desc = {
    Text = "Illuminez 2 en obtenant Hameln"
  },
  Task_62234_Name = {
    Text = "Illuminez 2 en obtenant Hameln"
  },
  Task_62234_UnlockCondDesc = {
    Text = "Événement @ Réveilleur Hameln Pack Illumination 1 Événement"
  },
  Task_62235_Desc = {
    Text = "Éclairer 2 lors de l'obtention de Wanda"
  },
  Task_62235_Name = {
    Text = "Éclairer 2 lors de l'obtention de Wanda"
  },
  Task_62235_UnlockCondDesc = {
    Text = "Event @ Réveillants Wanda Illumination Pack 1 Événement"
  },
  Task_62236_Desc = {
    Text = "Éclairer 6 lors de l'obtention de Nymphaea"
  },
  Task_62236_Name = {
    Text = "Éclairer 6 lors de l'obtention de Nymphaea"
  },
  Task_62236_UnlockCondDesc = {
    Text = "Event @ Réveillants Nymphaea Illumination Pack 2 Événement"
  },
  Task_62237_Desc = {
    Text = "Éclairer 2 lors de l'obtention d'Horla"
  },
  Task_62237_Name = {
    Text = "Éclairer 2 lors de l'obtention d'Horla"
  },
  Task_62237_UnlockCondDesc = {
    Text = "Événement @ Réveilleur Horla Pack Illuminer 1 Événement"
  },
  Task_62238_Desc = {
    Text = "Illuminer 6 en obtenant Wanda"
  },
  Task_62238_Name = {
    Text = "Illuminer 6 en obtenant Wanda"
  },
  Task_62238_UnlockCondDesc = {
    Text = "Event @ Réveillants Wanda Illumination Pack 2 Événement"
  },
  Task_62239_Desc = {
    Text = "Illuminez 2 en obtenant Casiah"
  },
  Task_62239_Name = {
    Text = "Illuminez 2 en obtenant Casiah"
  },
  Task_62239_UnlockCondDesc = {
    Text = "Événement @ Réveilleur Casiah Pack Cadeau Illuminer 1 Événement"
  },
  Task_62240_Desc = {
    Text = "Illuminez 2 en obtenant Faros"
  },
  Task_62240_Name = {
    Text = "Illuminez 2 en obtenant Faros"
  },
  Task_62240_UnlockCondDesc = {
    Text = "Événement @ Réveilleur Faros Pack Illumination 1 Événement"
  },
  Task_62241_Desc = {
    Text = "Éclairer 6 lors de l'obtention de Hamel"
  },
  Task_62241_Name = {
    Text = "Éclairer 6 lors de l'obtention de Hamel"
  },
  Task_62241_UnlockCondDesc = {
    Text = "Événement @ Réveilleur Hameln Pack Illumination 2 Événement"
  },
  Task_62242_Desc = {
    Text = "Enlighten 6 en acquérant Tinct"
  },
  Task_62242_Name = {
    Text = "Enlighten 6 en acquérant Tinct"
  },
  Task_62242_UnlockCondDesc = {
    Text = "Event @ Réveillants Tinct Illuminer Pack 2 Événement"
  },
  Task_62243_Desc = {
    Text = "Éclairer 6 lors de l'obtention de Goliath"
  },
  Task_62243_Name = {
    Text = "Éclairer 6 lors de l'obtention de Goliath"
  },
  Task_62243_UnlockCondDesc = {
    Text = "Événement @ Réveilleur Goliath Pack Illuminer 2 Événement"
  },
  Task_62244_Desc = {
    Text = "Éclairer 2 lors de l'obtention de Teinture"
  },
  Task_62244_Name = {
    Text = "Éclairer 2 lors de l'obtention de Teinture"
  },
  Task_62244_UnlockCondDesc = {
    Text = "Event @ Réveillants Tinct Illuminer Pack 1 Événement"
  },
  Task_62245_Desc = {
    Text = "Éclairer 6 lors de l'obtention de Leigh"
  },
  Task_62245_Name = {
    Text = "Éclairer 6 lors de l'obtention de Leigh"
  },
  Task_62245_UnlockCondDesc = {
    Text = "Événement @ Réveilleur Leigh Pack Illumination 2 Événement"
  },
  Task_62246_Desc = {
    Text = "Illuminer 6 en obtenant Tulu"
  },
  Task_62246_Name = {
    Text = "Illuminer 6 en obtenant Tulu"
  },
  Task_62246_UnlockCondDesc = {
    Text = "Event @ Réveillants Tulu Illuminer Pack 2 Événement"
  },
  Task_62247_Desc = {
    Text = "Éclairer 2 lors de l'obtention d'Uvhash"
  },
  Task_62247_Name = {
    Text = "Éclairer 2 lors de l'obtention d'Uvhash"
  },
  Task_62247_UnlockCondDesc = {
    Text = "Event @ Réveillants Uvhash Illumination Pack 1 Événement"
  },
  Task_62248_Desc = {
    Text = "Éclairer 2 lors de l'obtention de Tulu"
  },
  Task_62248_Name = {
    Text = "Éclairer 2 lors de l'obtention de Tulu"
  },
  Task_62248_UnlockCondDesc = {
    Text = "Event @ Réveillants Tulu Illumination Pack 1 Événement"
  },
  Task_62249_Desc = {
    Text = "Éclairer 6 lors de l'obtention de Lily"
  },
  Task_62249_Name = {
    Text = "Éclairer 6 lors de l'obtention de Lily"
  },
  Task_62249_UnlockCondDesc = {
    Text = "Événement @ Réveilleur Lily Pack Illumination 2 Événement"
  },
  Task_62250_Desc = {
    Text = "Illuminez 2 en obtenant Évanouissement"
  },
  Task_62250_Name = {
    Text = "Illuminez 2 en obtenant Évanouissement"
  },
  Task_62250_UnlockCondDesc = {
    Text = "Événement @ Réveilleur Évanouissement Pack Illumination 1 Événement"
  },
  Task_62251_Desc = {
    Text = "Éclairer 6 lors de l'obtention de Jonquille"
  },
  Task_62251_Name = {
    Text = "Éclairer 6 lors de l'obtention de Jonquille"
  },
  Task_62251_UnlockCondDesc = {
    Text = "Événement @ Réveilleur Jonquille Pack Illumination 2 Événement"
  },
  Task_62252_Desc = {
    Text = "Éclairer 6 lors de l'obtention d'Agrippa"
  },
  Task_62252_Name = {
    Text = "Éclairer 6 lors de l'obtention d'Agrippa"
  },
  Task_62252_UnlockCondDesc = {
    Text = "Événement @ Réveilleur Agrippa Pack Illuminer 2 Événement"
  },
  Task_62253_Desc = {
    Text = "Éclairer 2 lors de l'obtention de Pandia"
  },
  Task_62253_Name = {
    Text = "Éclairer 2 lors de l'obtention de Pandia"
  },
  Task_62253_UnlockCondDesc = {
    Text = "Event @ Réveillants Pandia Illumination Pack 1 Événement"
  },
  Task_62254_Desc = {
    Text = "Illuminez 2 en obtenant Jonquille"
  },
  Task_62254_Name = {
    Text = "Illuminez 2 en obtenant Jonquille"
  },
  Task_62254_UnlockCondDesc = {
    Text = "Événement @ Réveilleur Jonquille Pack Cadeau Illumination 1 Événement"
  },
  Task_62255_Desc = {
    Text = "Éclairer 2 lors de l'obtention de Sorel"
  },
  Task_62255_Name = {
    Text = "Éclairer 2 lors de l'obtention de Sorel"
  },
  Task_62255_UnlockCondDesc = {
    Text = "Event @ Réveillants Sorel Illuminer Pack 1 Événement"
  },
  Task_62256_Desc = {
    Text = "Éclairer 6 lors de l'obtention de Pandia"
  },
  Task_62256_Name = {
    Text = "Éclairer 6 lors de l'obtention de Pandia"
  },
  Task_62256_UnlockCondDesc = {
    Text = "Event @ Réveillants Pandia Illumination Pack 2 Événement"
  },
  Task_62257_Desc = {
    Text = "Enlighten 6 en acquérant \"24\""
  },
  Task_62257_Name = {
    Text = "Enlighten 6 en acquérant \"24\""
  },
  Task_62257_UnlockCondDesc = {
    Text = "Événement @ Réveilleur \"24\" Pack Cadeau Illuminer 2 Événement"
  },
  Task_62258_Desc = {
    Text = "Éclairer 2 lors de l'obtention de Liz"
  },
  Task_62258_Name = {
    Text = "Éclairer 2 lors de l'obtention de Liz"
  },
  Task_62258_UnlockCondDesc = {
    Text = "Event @ Réveillants Liz Illuminer Pack 1 Événement"
  },
  Task_62259_Desc = {
    Text = "Illuminer 2 en obtenant \"24\""
  },
  Task_62259_Name = {
    Text = "Illuminer 2 en obtenant \"24\""
  },
  Task_62259_UnlockCondDesc = {
    Text = "Événement @ Réveilleur \"24\" Pack Cadeau Illuminer 1 Événement"
  },
  Task_62260_Desc = {
    Text = "Éclairer 6 lors de l'obtention de Liz"
  },
  Task_62260_Name = {
    Text = "Éclairer 6 lors de l'obtention de Liz"
  },
  Task_62260_UnlockCondDesc = {
    Text = "Event @ Réveillants Liz Illuminer Pack 2 Événement"
  },
  Task_62261_Desc = {
    Text = "Éclairer 2 lors de l'obtention d'Hilote"
  },
  Task_62261_Name = {
    Text = "Éclairer 2 lors de l'obtention d'Hilote"
  },
  Task_62261_UnlockCondDesc = {
    Text = "Événement @ Réveilleur Hilote Pack Illumination 1 Événement"
  },
  Task_62262_Desc = {
    Text = "Éclairer 2 lors de l'obtention de Salvador"
  },
  Task_62262_Name = {
    Text = "Éclairer 2 lors de l'obtention de Salvador"
  },
  Task_62262_UnlockCondDesc = {
    Text = "Event @ Réveillants Salvador Illuminer Pack 1 Événement"
  },
  Task_62263_Desc = {
    Text = "Éclairer 6 lors de l'obtention d'Hilote"
  },
  Task_62263_Name = {
    Text = "Éclairer 6 lors de l'obtention d'Hilote"
  },
  Task_62263_UnlockCondDesc = {
    Text = "Événement @ Réveilleur Hilote Pack Illumination 2 Événement"
  },
  Task_62264_Desc = {
    Text = "Éclairer 6 lors de l'obtention de Salvador"
  },
  Task_62264_Name = {
    Text = "Éclairer 6 lors de l'obtention de Salvador"
  },
  Task_62264_UnlockCondDesc = {
    Text = "Event @ Réveillants Salvador Illuminer Pack 2 Événement"
  },
  Task_62265_Desc = {
    Text = "Éclairer 2 lors de l'obtention de Nymphaea"
  },
  Task_62265_Name = {
    Text = "Éclairer 2 lors de l'obtention de Nymphaea"
  },
  Task_62265_UnlockCondDesc = {
    Text = "Event @ Réveillants Nymphaea Illumination Pack 1 Événement"
  },
  Task_62266_Desc = {
    Text = "Éclairer 2 lors de l'obtention de Murphy"
  },
  Task_62266_Name = {
    Text = "Éclairer 2 lors de l'obtention de Murphy"
  },
  Task_62266_UnlockCondDesc = {
    Text = "Event @ Réveillants Murphy Illuminer Pack 1 Événement"
  },
  Task_62267_Desc = {
    Text = "Éclairer 2 lors de l'obtention de Ryker"
  },
  Task_62267_Name = {
    Text = "Éclairer 2 lors de l'obtention de Ryker"
  },
  Task_62267_UnlockCondDesc = {
    Text = "Event @ Réveillants Ryker Illumination Pack 1 Événement"
  },
  Task_62268_Desc = {
    Text = "Illuminer 6 en obtenant Tawil"
  },
  Task_62268_Name = {
    Text = "Illuminer 6 en obtenant Tawil"
  },
  Task_62268_UnlockCondDesc = {
    Text = "Event @ Réveillants Tawil Illuminer Pack 2 Événement"
  },
  Task_62269_Desc = {
    Text = "Éclairer 6 lors de l'obtention de Faros"
  },
  Task_62269_Name = {
    Text = "Éclairer 6 lors de l'obtention de Faros"
  },
  Task_62269_UnlockCondDesc = {
    Text = "Événement @ Réveilleur Faros Pack Illumination 2 Événement"
  },
  Task_62270_Desc = {
    Text = "Éclairer 2 lors de l'obtention de Tawil"
  },
  Task_62270_Name = {
    Text = "Éclairer 2 lors de l'obtention de Tawil"
  },
  Task_62270_UnlockCondDesc = {
    Text = "Event @ Réveillants Tawil Illumination Pack 1 Événement"
  },
  Task_62271_Desc = {
    Text = "Éclairer 6 lors de l'obtention d'Évanouissement"
  },
  Task_62271_Name = {
    Text = "Éclairer 6 lors de l'obtention d'Évanouissement"
  },
  Task_62271_UnlockCondDesc = {
    Text = "Événement @ Réveilleur Évanouissement Pack Illumination 2 Événement"
  },
  Task_62272_Desc = {
    Text = "Éclairer 6 lors de l'obtention de Sorel"
  },
  Task_62272_Name = {
    Text = "Éclairer 6 lors de l'obtention de Sorel"
  },
  Task_62272_UnlockCondDesc = {
    Text = "Event @ Réveillants Sorel Illuminer Pack 2 Événement"
  },
  Task_62273_Desc = {
    Text = "Éclairer 2 lors de l'obtention de Sanga"
  },
  Task_62273_Name = {
    Text = "Éclairer 2 lors de l'obtention de Sanga"
  },
  Task_62273_UnlockCondDesc = {
    Text = "Event @ Réveillants Sanga Illumination Pack 1 Événement"
  },
  Task_62274_Desc = {
    Text = "Illuminez 2 en acquérant Goliath"
  },
  Task_62274_Name = {
    Text = "Illuminez 2 en acquérant Goliath"
  },
  Task_62274_UnlockCondDesc = {
    Text = "Événement @ Réveilleur Goliath Pack Illuminer 1 Événement"
  },
  Task_62275_Desc = {
    Text = "Éclairer 2 lors de l'obtention de Miryam"
  },
  Task_62275_Name = {
    Text = "Éclairer 2 lors de l'obtention de Miryam"
  },
  Task_62275_UnlockCondDesc = {
    Text = "Event @ Réveillants Miryam Illuminer Pack 1 Événement"
  },
  Task_62276_Desc = {
    Text = "Illuminer 6 en obtenant Bigorneau"
  },
  Task_62276_Name = {
    Text = "Illuminer 6 en obtenant Bigorneau"
  },
  Task_62276_UnlockCondDesc = {
    Text = "Event @ Réveillants Bigorneau Illuminer Pack 2 Événement"
  },
  Task_62277_Desc = {
    Text = "Illuminez 2 en obtenant Caecus"
  },
  Task_62277_Name = {
    Text = "Illuminez 2 en obtenant Caecus"
  },
  Task_62277_UnlockCondDesc = {
    Text = "Événement @ Réveilleur Caecus Pack Cadeau Illuminer 1 Événement"
  },
  Task_62278_Desc = {
    Text = "Éclairer 6 lors de l'obtention de Miryam"
  },
  Task_62278_Name = {
    Text = "Éclairer 6 lors de l'obtention de Miryam"
  },
  Task_62278_UnlockCondDesc = {
    Text = "Event @ Réveillants Miryam Illuminer Pack 2 Événement"
  },
  Task_62279_Desc = {
    Text = "Éclairer 2 lors de l'obtention de Bigorneau"
  },
  Task_62279_Name = {
    Text = "Éclairer 2 lors de l'obtention de Bigorneau"
  },
  Task_62279_UnlockCondDesc = {
    Text = "Event @ Réveillants Bigorneau Illuminer Pack 1 Événement"
  },
  Task_62280_Desc = {
    Text = "Éclairer 6 lors de l'obtention de Caecus"
  },
  Task_62280_Name = {
    Text = "Éclairer 6 lors de l'obtention de Caecus"
  },
  Task_62280_UnlockCondDesc = {
    Text = "Événement @ Réveilleur Caecus Pack Cadeau Illuminer 2 Événement"
  },
  Task_62281_Desc = {
    Text = "Éclairer 2 lors de l'obtention de Nautila"
  },
  Task_62281_Name = {
    Text = "Éclairer 2 lors de l'obtention de Nautila"
  },
  Task_62281_UnlockCondDesc = {
    Text = "Event @ Réveillants Nautila Illumination Pack 1 Événement"
  },
  Task_62282_Desc = {
    Text = "Éclairer 2 lors de l'obtention de Leigh"
  },
  Task_62282_Name = {
    Text = "Éclairer 2 lors de l'obtention de Leigh"
  },
  Task_62282_UnlockCondDesc = {
    Text = "Événement @ Réveilleur Leigh Pack Illuminer 1 Événement"
  },
  Task_62283_Desc = {
    Text = "Illuminez 2 en obtenant Céleste"
  },
  Task_62283_Name = {
    Text = "Illuminez 2 en obtenant Céleste"
  },
  Task_62283_UnlockCondDesc = {
    Text = "Événement @ Réveilleur Celeste Pack Illuminer 1 Événement"
  },
  Task_62284_Desc = {
    Text = "Éclairer 2 lors de l'obtention de Kare"
  },
  Task_62284_Name = {
    Text = "Éclairer 2 lors de l'obtention de Kare"
  },
  Task_62284_UnlockCondDesc = {
    Text = "Événement @ Réveilleur Karen Pack Illuminer 1 Événement"
  },
  Task_62285_Desc = {
    Text = "Éclairer 6 lors de l'obtention de Sanga"
  },
  Task_62285_Name = {
    Text = "Éclairer 6 lors de l'obtention de Sanga"
  },
  Task_62285_UnlockCondDesc = {
    Text = "Event @ Réveillants Sanga Illumination Pack 2 Événement"
  },
  Task_62286_Desc = {
    Text = "Éclairer 6 lors de l'obtention de Céleste"
  },
  Task_62286_Name = {
    Text = "Éclairer 6 lors de l'obtention de Céleste"
  },
  Task_62286_UnlockCondDesc = {
    Text = "Événement @ Réveilleur Celeste Pack Illumination 2 Événement"
  },
  Task_62287_Desc = {
    Text = "Éclairer 6 lors de l'obtention de Kare"
  },
  Task_62287_Name = {
    Text = "Éclairer 6 lors de l'obtention de Kare"
  },
  Task_62287_UnlockCondDesc = {
    Text = "Événement @ Réveilleur Karen Pack Illumination 2 Événement"
  },
  Task_62288_Desc = {
    Text = "Éclairer 6 lors de l'obtention de Nautila"
  },
  Task_62288_Name = {
    Text = "Éclairer 6 lors de l'obtention de Nautila"
  },
  Task_62288_UnlockCondDesc = {
    Text = "Event @ Réveillants Nautila Illumination Pack 2 Événement"
  },
  Task_62289_Desc = {
    Text = "Éclairer 6 lors de l'obtention de Murphy"
  },
  Task_62289_Name = {
    Text = "Éclairer 6 lors de l'obtention de Murphy"
  },
  Task_62289_UnlockCondDesc = {
    Text = "Event @ Réveillants Murphy Illumination Pack 2 Événement"
  },
  Task_62290_Desc = {
    Text = "Éclairer 6 lors de l'obtention d'Horla"
  },
  Task_62290_Name = {
    Text = "Éclairer 6 lors de l'obtention d'Horla"
  },
  Task_62290_UnlockCondDesc = {
    Text = "Événement @ Réveilleur Horla Pack Illuminer 2 Événement"
  },
  Task_62291_Desc = {
    Text = "Éclairer 2 lors de l'obtention de Thais"
  },
  Task_62291_Name = {
    Text = "Éclairer 2 lors de l'obtention de Thais"
  },
  Task_62291_UnlockCondDesc = {
    Text = "Event @ Réveillants Thais Illumination Pack 1 Événement"
  },
  Task_62292_Desc = {
    Text = "Éclairer 6 lors de l'obtention d'Alva"
  },
  Task_62292_Name = {
    Text = "Éclairer 6 lors de l'obtention d'Alva"
  },
  Task_62292_UnlockCondDesc = {
    Text = "Événement @ Réveilleur Alva Pack Illumination 2 Événement"
  },
  Task_62293_Desc = {
    Text = "Illuminez 2 en obtenant Agrippa"
  },
  Task_62293_Name = {
    Text = "Illuminez 2 en obtenant Agrippa"
  },
  Task_62293_UnlockCondDesc = {
    Text = "Événement @ Réveilleur Agrippa Pack Illuminer 1 Événement"
  },
  Task_62294_Desc = {
    Text = "Éclairer 2 lors de l'obtention de Lily"
  },
  Task_62294_Name = {
    Text = "Éclairer 2 lors de l'obtention de Lily"
  },
  Task_62294_UnlockCondDesc = {
    Text = "Événement @ Réveilleur Lily Pack Illuminer 1 Événement"
  },
  Task_62295_Desc = {
    Text = "Illuminer 6 en obtenant Thais"
  },
  Task_62295_Name = {
    Text = "Illuminer 6 en obtenant Thais"
  },
  Task_62295_UnlockCondDesc = {
    Text = "Event @ Réveillants Thais Illumination Pack 2 Événement"
  },
  Task_62296_Desc = {
    Text = "Illuminez 2 en obtenant Alva"
  },
  Task_62296_Name = {
    Text = "Illuminez 2 en obtenant Alva"
  },
  Task_62296_UnlockCondDesc = {
    Text = "Événement @ Réveilleur Alva Pack Illumination 1 Événement"
  },
  Task_62297_Desc = {
    Text = "Illuminer 6 en obtenant Uvhash"
  },
  Task_62297_Name = {
    Text = "Illuminer 6 en obtenant Uvhash"
  },
  Task_62297_UnlockCondDesc = {
    Text = "Event @ Réveillants Uvhash Illumination Pack 2 Événement"
  },
  Task_62298_Desc = {
    Text = "Lorsque vous obtenez Génèse-Hilote, Illuminez 2"
  },
  Task_62298_Name = {
    Text = "Lorsque vous obtenez Génèse-Hilote, Illuminez 2"
  },
  Task_62298_UnlockCondDesc = {
    Text = "Événement @ Réveilleur Genèse Hilote Pack Illuminer 1 Événement"
  },
  Task_62299_Desc = {
    Text = "Lorsque vous obtenez Génèse-Hilote, Illuminez 6"
  },
  Task_62299_Name = {
    Text = "Lorsque vous obtenez Génèse-Hilote, Illuminez 6"
  },
  Task_62299_UnlockCondDesc = {
    Text = "Événement @ Réveilleur Genèse Hilote Pack Illuminer 2 Événement"
  },
  Task_62300_Desc = {
    Text = "Éclairer 6 lors de l'obtention de Casiah"
  },
  Task_62300_Name = {
    Text = "Éclairer 6 lors de l'obtention de Casiah"
  },
  Task_62300_UnlockCondDesc = {
    Text = "Événement @ Réveilleur Casiah Pack Illumination 2 Événement"
  },
  Task_62320_Desc = {
    Text = "Complétez l'enregistrement spécial \"Retourneur d'Elworth\" en difficulté Difficile"
  },
  Task_62320_Name = {
    Text = "Vie, Briser à travers la Montagne·Difficile"
  },
  Task_62321_Desc = {
    Text = "Compléter l'Événement d'Investigation « Symphonie Finale » en difficulté Difficile"
  },
  Task_62321_Name = {
    Text = "Bataille au nom du souvenir - Difficile"
  },
  Task_62322_Desc = {
    Text = "Compléter l'événement d'investigation \"@1@2\""
  },
  Task_62322_Desc2 = {
    Text = "Complete Investigation Event \"Final Symphony\""
  },
  Task_62322_Name = {Text = "@2@3"},
  Task_62322_Name2 = {
    Text = "Bataille pour le souvenir"
  },
  Task_62323_Desc = {
    Text = "Résonner 3 fois dans l'enquête sur l'événement «@1@2»"
  },
  Task_62323_Desc2 = {
    Text = "Résonner 3 fois dans l'événement d'investigation « Symphonie Finale »"
  },
  Task_62323_Name = {Text = "@2@3"},
  Task_62323_Name2 = {
    Text = "Écho de résilience"
  },
  Task_62324_Desc = {
    Text = "Complétez l'enregistrement spécial \"Chasse Heureuse !\""
  },
  Task_62324_Name = {
    Text = "Soutien cruel du destin"
  },
  Task_62325_Desc = {
    Text = "Résonner 9 fois dans l'enquête sur l'événement «@1@2»"
  },
  Task_62325_Desc2 = {
    Text = "Résonner 9 fois dans l'événement d'investigation « Symphonie Finale »"
  },
  Task_62325_Name = {Text = "@2@3"},
  Task_62325_Name2 = {
    Text = "Résonance de ténacité III"
  },
  Task_62326_Desc = {
    Text = "Trouvez 10 Points d'Extraction dans le Chapitre 8 de la Quête Principale \"@1@2\""
  },
  Task_62326_Desc2 = {
    Text = "Trouvez 10 points d'extraction dans l'histoire principale Chapitre 8 \"Symphonie Finale\""
  },
  Task_62326_Name = {Text = "@2@3"},
  Task_62326_Name2 = {
    Text = "Ombres Chuchotantes VIII"
  },
  Task_62327_Desc = {
    Text = "Complétez l'enregistrement spécial \"Rétourneur d'Elworth\""
  },
  Task_62327_Name = {
    Text = "La vie perce à travers la montagne"
  },
  Task_62328_Desc = {
    Text = "Complétez l'enregistrement spécial \"Chasse Heureuse!\" en difficulté Difficile"
  },
  Task_62328_Name = {
    Text = "Raillerie du Destin·Difficile"
  },
  Task_62329_Desc = {
    Text = "Complétez l'enregistrement spécial \"Habitat de la Rose\""
  },
  Task_62329_Name = {
    Text = "Parfum de fleurs et de poésie"
  },
  Task_62330_Desc = {
    Text = "Résonner 6 fois dans l'enquête sur l'événement «@1@2»"
  },
  Task_62330_Desc2 = {
    Text = "Résonner 6 fois dans l'événement d'investigation « Symphonie Finale »"
  },
  Task_62330_Name = {Text = "@2@3"},
  Task_62330_Name2 = {
    Text = "Résonance de ténacité II"
  },
  Task_62331_Desc = {
    Text = "Résonner 13 fois dans l'événement d'investigation \"@1@2\""
  },
  Task_62331_Desc2 = {
    Text = "Résonnez 13 fois dans l'événement d'investigation \"Symphonie Finale\""
  },
  Task_62331_Name = {Text = "@2@3"},
  Task_62331_Name2 = {
    Text = "Résonance de ténacité IV"
  },
  Task_62332_Desc = {
    Text = "Complétez l'enregistrement spécial \"Habitat de la Rose\" en difficulté Difficile"
  },
  Task_62332_Name = {
    Text = "Parfum de Fleurs et de Poésie · Difficile"
  },
  Task_62346_Desc = {
    Text = "Vaincre \"La Théorie de l'Oubli Complet\" sans compter sur l'assistance de Ramona."
  },
  Task_62346_Name = {
    Text = "Majesté solitaire"
  },
  Task_62371_Desc = {
    Text = "Avec l'assistance de Ramona, vaincre «Oublié des origines»"
  },
  Task_62371_Name = {
    Text = "Tiens ma main, Gardien"
  },
  Task_65510_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_65511_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_65512_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_65513_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_65514_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_65515_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_65516_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_65517_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_65518_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_65519_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_65722_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter 1 victoire dans « Codage de mémoire »"
  },
  Task_65723_Desc = {
    Text = "Effacez toute difficulté de \"Miroir\""
  },
  Task_65724_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter une victoire dans « Codage de mémoire »"
  },
  Task_65725_Desc = {
    Text = "Codage de Mémoire·Complet"
  },
  Task_65726_Desc = {
    Text = "Code de mémoire : Royaume"
  },
  Task_65727_Desc = {
    Text = "Effacez l'\"Amygdale\" en difficulté Folie"
  },
  Task_65728_Desc = {
    Text = "Complétez \"Courbe de l'oubli\" en difficulté Folie"
  },
  Task_65729_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 1 victoire dans « Codage de mémoire »"
  },
  Task_65730_Desc = {
    Text = "Effacez toute difficulté de \"Amygdale\""
  },
  Task_65731_Desc = {
    Text = "Effacez toute difficulté de \"Amygdale\""
  },
  Task_65732_Desc = {
    Text = "Effacez toute difficulté de \"Miroir\""
  },
  Task_65733_Desc = {
    Text = "Effacez toute difficulté de \"Courbe de l'oubli\""
  },
  Task_65734_Desc = {
    Text = "Terminez \"Reptilian Brain\" en toute difficulté"
  },
  Task_65735_Desc = {
    Text = "Débloqué après avoir terminé toutes les tâches de \"Encodage de Mémoire · Réalisation\""
  },
  Task_65736_Desc = {
    Text = "Effacez toute difficulté de \"Courbe de l'oubli\""
  },
  Task_65737_Desc = {
    Text = "Terminez \"Unconscious Memory\" en toute difficulté"
  },
  Task_65738_Desc = {
    Text = "Complétez \"Miroir\" en difficulté Folie"
  },
  Task_65739_Desc = {
    Text = "Code de mémoire : Folie"
  },
  Task_65740_Desc = {
    Text = "Terminez \"Unconscious Memory\" en toute difficulté"
  },
  Task_65741_Desc = {
    Text = "Complétez l'enregistrement de l'opération spéciale \"Fission pacifique\"."
  },
  Task_65742_Desc = {
    Text = "Terminez \"Unconscious Memory\" en difficulté Folie"
  },
  Task_65743_Desc = {
    Text = "Terminez \"Reptilian Brain\" en toute difficulté"
  },
  Task_65744_Desc = {
    Text = "Terminez \"Reptilian Brain\" en difficulté Folie"
  },
  Task_65745_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter une victoire dans « Codage de mémoire »"
  },
  Task_66015_Desc = {
    Text = "L'Affinité de Tawil atteint le Niveau 10"
  },
  Task_66213_Desc = {
    Text = "Naissance du Royaume des Dieux · Folie"
  },
  Task_66214_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter une victoire dans « Naissance du Royaume divin »"
  },
  Task_66215_Desc = {
    Text = "Terminez \"Témoin\" à n'importe quelle difficulté"
  },
  Task_66216_Desc = {
    Text = "Clear \"Secouer\" difficulté Folie"
  },
  Task_66217_Desc = {
    Text = "Vaincre \"Arrivée\" en toute difficulté"
  },
  Task_66218_Desc = {
    Text = "Complétez \"Foi\" en difficulté Folie"
  },
  Task_66219_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter une victoire dans « Naissance du Royaume divin »"
  },
  Task_66220_Desc = {
    Text = "Compléter n'importe quelle difficulté de \"Conviction\""
  },
  Task_66221_Desc = {
    Text = "Terminez \"Témoin\" à n'importe quelle difficulté"
  },
  Task_66224_Desc = {
    Text = "Complétez \"Doute\" à n'importe quelle difficulté"
  },
  Task_66227_Desc = {
    Text = "Complétez \"Désacralisation\" dans le Paysage de rêve"
  },
  Task_66228_Desc = {
    Text = "Terminer toutes les missions de «Naissance du royaume divin · Passage»"
  },
  Task_66229_Desc = {
    Text = "Complétez \"Témoin\" en difficulté Folie"
  },
  Task_66230_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter une victoire dans « Naissance du Royaume divin »"
  },
  Task_66231_Desc = {
    Text = "Complétez \"Arrivée\" en difficulté Folie"
  },
  Task_66232_Desc = {
    Text = "La Naissance du Royaume de Dieu · Royaume"
  },
  Task_66233_Desc = {
    Text = "Clear \"Secouer\" à n'importe quelle difficulté"
  },
  Task_66235_Desc = {
    Text = "Complétez \"Questionnement\" en difficulté Folie"
  },
  Task_66236_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter une victoire dans « Naissance du Royaume divin »"
  },
  Task_66237_Desc = {
    Text = "Vaincre \"Arrivée\" en toute difficulté"
  },
  Task_66238_Desc = {
    Text = "Clear \"Secouer\" à n'importe quelle difficulté"
  },
  Task_66240_Desc = {
    Text = "Naissance du Royaume de Dieu · Clair"
  },
  Task_66241_Desc = {
    Text = "Compléter n'importe quelle difficulté de \"Conviction\""
  },
  Task_66242_Desc = {
    Text = "Complétez \"Doute\" à n'importe quelle difficulté"
  },
  Task_66243_Desc = {
    Text = "Réponse de l'Abyss"
  },
  Task_66335_Desc = {
    Text = "Échapper à la Poursuite du Comité"
  },
  Task_66335_Name = {Text = "Objectif"},
  Task_66336_Desc = {
    Text = "Arrête le Cynocephalus de faire un rapport"
  },
  Task_66336_Name = {Text = "Objectif"},
  Task_66337_Desc = {
    Text = "Casser le blocus du Comité"
  },
  Task_66337_Name = {Text = "Objectif"},
  Task_66338_Desc = {
    Text = "Vaincre Thais"
  },
  Task_66338_Name = {Text = "Objectif"},
  Task_66339_Desc = {Text = "Vaincre N"},
  Task_66339_Name = {Text = "Objectif"},
  Task_66340_Desc = {
    Text = "Arrête l'invasion du Comité"
  },
  Task_66340_Name = {Text = "Objectif"},
  Task_66341_Desc = {
    Text = "Détruire les Statues des Deux Divinités"
  },
  Task_66341_Name = {Text = "Objectif"},
  Task_66342_Desc = {
    Text = "Résister à Hameln"
  },
  Task_66342_Name = {Text = "Objectif"},
  Task_66343_Desc = {
    Text = "Trouvez Tawil"
  },
  Task_66343_Name = {Text = "Objectif"},
  Task_66344_Desc = {
    Text = "Arrêter Juliette"
  },
  Task_66344_Name = {Text = "Objectif"},
  Task_66422_Name = {
    Text = "Vaincre le BOSS 1 N fois"
  },
  Task_66423_Name = {
    Text = "Vaincre le BOSS 2 N fois"
  },
  Task_66424_Name = {
    Text = "Vaincre le BOSS 3 N fois"
  },
  Task_66425_Name = {
    Text = "Vaincre le BOSS 4 N fois"
  },
  Task_66426_Name = {
    Text = "Vaincre BOSS 5 fois"
  },
  Task_66428_Name = {
    Text = "Vaincre Tous les Boss"
  },
  Task_66580_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_66580_Name = {
    Text = "Passer Parfait"
  },
  Task_66581_Desc = {
    Text = "Transportez au moins 8 Reliques à l'achèvement."
  },
  Task_66581_Name = {
    Text = "Planque secrète"
  },
  Task_66582_Desc = {
    Text = "Remporter la victoire dans la Bataille Finale en 25 tours au maximum"
  },
  Task_66582_Name = {
    Text = "Résolution rapide"
  },
  Task_66583_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_66583_Name = {
    Text = "Élégant et précis"
  },
  Task_66584_Desc = {
    Text = "Transportez au moins 8 Reliques à l'achèvement."
  },
  Task_66584_Name = {
    Text = "Planque secrète"
  },
  Task_66585_Desc = {
    Text = "Causer au moins 200000 points de dégâts en un tour dans la bataille finale"
  },
  Task_66585_Name = {
    Text = "Attaque totale"
  },
  Task_66724_Desc = {
    Text = "Vaincre \"Départ\" en difficulté Folie"
  },
  Task_66725_Desc = {
    Text = "Complétez \"La porte des mondes\" en difficulté Folie"
  },
  Task_66726_Desc = {
    Text = "Complétez \"La porte de la connaissance et de l'action\" en difficulté Folie"
  },
  Task_66727_Desc = {
    Text = "Compléter \"La Porte de l'Extrémité\" en n'importe quelle difficulté"
  },
  Task_66728_Desc = {
    Text = "Clair le \"Portail de la Vérité\" en difficulté Folie"
  },
  Task_66729_Desc = {
    Text = "Clear the \"Porte de l'Unification\" à n'importe quelle difficulté"
  },
  Task_66730_Desc = {
    Text = "Vaincre \"Départ\" à n'importe quelle difficulté"
  },
  Task_66731_Desc = {
    Text = "Terminez \"The Gate of Truth or Falsehood\" en toute difficulté"
  },
  Task_66732_Desc = {
    Text = "Complétez \"Derrière la porte\" en difficulté Folie"
  },
  Task_66733_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter une victoire dans « Test final »"
  },
  Task_66734_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter 2 victoires dans « Test final »"
  },
  Task_66735_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter 2 victoires dans « Test final »"
  },
  Task_66736_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter une victoire dans « Test final »"
  },
  Task_66737_Desc = {
    Text = "Terminez \"The Gate of Truth or Falsehood\" en toute difficulté"
  },
  Task_66738_Desc = {
    Text = "Compléter \"La Porte de la Connaissance et de l'Action\" en n'importe quelle difficulté"
  },
  Task_66739_Desc = {
    Text = "Dernier test·Folie"
  },
  Task_66740_Desc = {
    Text = "Compléter \"La Porte de la Connaissance et de l'Action\" en n'importe quelle difficulté"
  },
  Task_66741_Desc = {
    Text = "Compléter \"La Porte des Mondes\" en n'importe quelle difficulté"
  },
  Task_66742_Desc = {
    Text = "Compléter \"La Porte de l'Extrémité\" en n'importe quelle difficulté"
  },
  Task_66743_Desc = {
    Text = "Complétez \"Porte\" à n'importe quelle difficulté"
  },
  Task_66744_Desc = {
    Text = "Test Final : Achèvement"
  },
  Task_66745_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter 2 fois dans « Test final »"
  },
  Task_66746_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter une victoire dans « Test final »"
  },
  Task_66747_Desc = {
    Text = "Effacez le \"Port de la Rationalité\" en difficulté Folie"
  },
  Task_66748_Desc = {
    Text = "Effacez le \"Port de l'Unification\" en difficulté Folie"
  },
  Task_66749_Desc = {
    Text = "Vaincre \"Départ\" à n'importe quelle difficulté"
  },
  Task_66750_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 2 victoires dans « Test final »"
  },
  Task_66751_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 1 victoire dans « Test final »"
  },
  Task_66752_Desc = {
    Text = "Complétez \"Porte\" à n'importe quelle difficulté"
  },
  Task_66753_Desc = {
    Text = "Clear the \"Porte de la Nature\" à n'importe quelle difficulté"
  },
  Task_66754_Desc = {
    Text = "Effacez le \"Port de la Nature\" en difficulté Folie"
  },
  Task_66755_Desc = {
    Text = "Complétez \"La porte de l'extrême\" en difficulté Folie"
  },
  Task_66756_Desc = {
    Text = "Dernier test·Royaume"
  },
  Task_66757_Desc = {
    Text = "Déverrouille après avoir complété toutes les tâches dans \"Test Final · Nettoyage\""
  },
  Task_66758_Desc = {
    Text = "Clear the \"Porte de la Rationalité\" à n'importe quelle difficulté"
  },
  Task_66759_Desc = {
    Text = "Clear the \"Porte de la Nature\" à n'importe quelle difficulté"
  },
  Task_66760_Desc = {
    Text = "Compléter \"La Porte des Mondes\" en n'importe quelle difficulté"
  },
  Task_66761_Desc = {
    Text = "Clear the \"Porte de la Rationalité\" à n'importe quelle difficulté"
  },
  Task_66762_Desc = {
    Text = "Clear the \"Porte de l'Unification\" à n'importe quelle difficulté"
  },
  Task_67066_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_67067_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_67068_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_67069_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_67070_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_67071_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_67072_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_67073_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_67075_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_67076_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_67113_Desc = {
    Text = "Localisez 2 points d'extraction dans le final de l'histoire principale \"@1@2\""
  },
  Task_67113_Desc2 = {
    Text = "Trouver 2 points d'extraction dans le chapitre final de l'histoire principale « Lorsque le long rêve prend fin »"
  },
  Task_67113_Name = {Text = "@2@3"},
  Task_67113_Name2 = {
    Text = "Chuchotements Cachés IX"
  },
  Task_67114_Desc = {
    Text = "Compléter l'Événement d'Investigation « Quand le Long Rêve se Termine » en Difficile"
  },
  Task_67114_Name = {
    Text = "Regarder Jusqu'à la Mort·Difficile"
  },
  Task_67115_Desc = {
    Text = "Compléter l'événement d'investigation \"@1@2\""
  },
  Task_67115_Desc2 = {
    Text = "Complete Investigation Event \"When the Long Dream Ends\""
  },
  Task_67115_Name = {Text = "@2@3"},
  Task_67115_Name2 = {
    Text = "Regarde jusqu'à la mort"
  },
  Task_67116_Desc = {
    Text = "Résonner 3 fois dans l'enquête sur l'événement «@1@2»"
  },
  Task_67116_Desc2 = {
    Text = "Résonnez 3 fois dans l'événement d'investigation \"Fin du Long Rêve\""
  },
  Task_67116_Name = {Text = "@2@3"},
  Task_67116_Name2 = {
    Text = "Écho de l'extrémité"
  },
  Task_67125_Name = {
    Text = "Vaincre le BOSS 6 N fois"
  },
  Task_67126_Name = {
    Text = "Vaincre le BOSS 7 N fois"
  },
  Task_67408_Desc = {
    Text = "Bloque Tohuwabohu, ferme la Porte"
  },
  Task_67408_Name = {Text = "Objectif"},
  Task_67409_Desc = {
    Text = "Trouvez la taupe au sein de Mythag"
  },
  Task_67409_Name = {Text = "Objectif"},
  Task_67410_Desc = {
    Text = "Bloquer Tohuwabohu"
  },
  Task_67410_Name = {Text = "Objectif"},
  Task_67411_Desc = {
    Text = "Adieu aux Éveillés"
  },
  Task_67411_Name = {Text = "Objectif"},
  Task_67827_Desc = {
    Text = "Soumettre... soumettre à la vérité éternelle du Chaos..."
  },
  Task_67827_Name = {
    Text = "Soumettre... soumettre à la vérité éternelle du Chaos..."
  },
  Task_67828_Desc = {
    Text = "Sa folie, au-delà de la résistance."
  },
  Task_67828_Name = {
    Text = "Sa folie, au-delà de la résistance."
  },
  Task_67829_Desc = {
    Text = "Sa majesté, à ne pas regarder directement."
  },
  Task_67829_Name = {
    Text = "Sa majesté, à ne pas regarder directement."
  },
  Task_67919_Desc = {
    Text = "Déverrouiller après avoir détruit tous les clones de « Sona-Nyl · Regard de folie »"
  },
  Task_67919_Name = {
    Text = "Vaincre le Boss 6"
  },
  Task_67920_Desc = {
    Text = "Tous les clones de « Musée de la cire·La vue de la peur » détruits débloqué"
  },
  Task_67920_Name = {
    Text = "Vaincre BOSS2"
  },
  Task_67921_Desc = {
    Text = "Détruire tous les clones de « Hôpital · Regard énigmatique » pour déverrouiller"
  },
  Task_67921_Name = {
    Text = "Vaincre BOSS4"
  },
  Task_67922_Desc = {
    Text = "Déverrouillé en éliminant tous les clones de « Briellepeur, la vision du mal »"
  },
  Task_67922_Name = {
    Text = "Vaincre BOSS 5"
  },
  Task_67923_Desc = {
    Text = "Déverrouiller en détruisant tous les clones de « Hôpital des pauvres · Regard triste »"
  },
  Task_67923_Name = {
    Text = "Vaincre BOSS1"
  },
  Task_67924_Desc = {
    Text = "Déverrouillé en éliminant tous les clones de « Lemwashy - Vision de la Naissance »"
  },
  Task_67924_Name = {
    Text = "Vaincre le Boss 7"
  },
  Task_67925_Desc = {
    Text = "Déverrouillé en éliminant tous les clones de « Lai, regard perçant »"
  },
  Task_67925_Name = {
    Text = "Vaincre Boss 3"
  },
  Task_67926_Name = {
    Text = "5 clones de « Vision primitive » sont tués"
  },
  Task_67927_Name = {
    Text = "Les 2 clones de « Vision primitive » sont tués"
  },
  Task_67928_Name = {
    Text = "4 clones de « Vision primitive » sont tués"
  },
  Task_67929_Name = {
    Text = "6 clones de « Vision primitive » sont tués"
  },
  Task_67930_Name = {
    Text = "Tous les avatars de la Vision Primordiale ont été vaincus"
  },
  Task_67931_Name = {
    Text = "7 clones de « Vision primitive » sont tués"
  },
  Task_67932_Name = {
    Text = "Tous les clones des 3 « Visions primitives » sont tués"
  },
  Task_68342_Desc = {
    Text = "Au-delà des étoiles III"
  },
  Task_68343_Desc = {
    Text = "Au-delà des étoiles V"
  },
  Task_68344_Desc = {
    Text = "Au-delà des étoiles VII"
  },
  Task_68345_Desc = {
    Text = "Au-delà des étoiles II"
  },
  Task_68346_Desc = {
    Text = "Au-delà des étoiles IV"
  },
  Task_68347_Desc = {
    Text = "Au-delà des étoiles Ⅰ"
  },
  Task_68348_Desc = {
    Text = "Au-delà des étoiles VI"
  },
  Task_68365_Desc = {
    Text = "Au-delà des étoiles · Gratuit"
  },
  Task_68377_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_68378_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_68379_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_68380_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_68382_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_68383_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_68384_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_68385_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_68386_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_68387_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_68388_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_68389_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_68390_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_68391_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_68392_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_68393_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_68394_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_68395_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_68396_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_68397_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_68418_Name = {
    Text = "Événement du Boss Mondial terminé"
  },
  Task_68492_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter une victoire dans «Fond marin · Regard»"
  },
  Task_68493_Desc = {
    Text = "Terminer « Œil divin » à la difficulté Folie"
  },
  Task_68494_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter une victoire dans « Fond marin · Regard »"
  },
  Task_68495_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Belle Fantaisie »"
  },
  Task_68496_Desc = {
    Text = "Terminer « Belle Fantaisie » en difficulté Folie"
  },
  Task_68497_Desc = {
    Text = "Terminer n'importe quelle difficulté de \"Effondrement de l'humanité\""
  },
  Task_68498_Desc = {
    Text = "Terminer « Effondrement Humain » en difficulté Folie"
  },
  Task_68499_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter une victoire dans « Fond marin · Regard »"
  },
  Task_68500_Desc = {
    Text = "Terminer « Œil divin » en toute difficulté"
  },
  Task_68501_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Effondrement de l'humanité »"
  },
  Task_68502_Desc = {
    Text = "Terminer n'importe quelle difficulté de \"Nostalgie\""
  },
  Task_68503_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 1 victoire dans « Fond marin · Regard »"
  },
  Task_68504_Desc = {
    Text = "Regard des Profondeurs · Folie"
  },
  Task_68505_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Belle Fantaisie »"
  },
  Task_68506_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Royaume de la Déchéance »"
  },
  Task_68507_Desc = {
    Text = "Fond marin - Regard · Terminer"
  },
  Task_68508_Desc = {
    Text = "Terminer n'importe quelle difficulté de \"Nostalgie\""
  },
  Task_68509_Desc = {
    Text = "Terminer difficulté Folie de « Nostalgie »"
  },
  Task_68510_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Royaume de la Déchéance »"
  },
  Task_68511_Desc = {
    Text = "Terminer « Royaume de la Déliquescence » à la difficulté Folie"
  },
  Task_68512_Desc = {
    Text = "Fond marin · Domaine"
  },
  Task_68513_Desc = {
    Text = "Terminer toutes les missions de « Regard de la mer profonde·Terminer »"
  },
  Task_68514_Desc = {
    Text = "Terminer « Œil divin » en toute difficulté"
  },
  Task_68860_Desc = {
    Text = "Obtenez 1 victoire cette saiso"
  },
  Task_68860_Name = {Text = "1 Victoire"},
  Task_68861_Desc = {
    Text = "Obtenez un total de 6 victoires cette saiso"
  },
  Task_68861_Name = {
    Text = "6 victoires"
  },
  Task_68862_Desc = {
    Text = "Obtenez un total de 3 victoires cette saiso"
  },
  Task_68862_Name = {
    Text = "3 Victoires"
  },
  Task_68863_Desc = {
    Text = "Obtenez 10 victoires cette saiso"
  },
  Task_68863_Name = {
    Text = "10 Victoires"
  },
  Task_68864_Desc = {
    Text = "Obtenez un total de 3 victoires cette saiso"
  },
  Task_68864_Name = {
    Text = "3 Victoires"
  },
  Task_68865_Desc = {
    Text = "Obtenez un total de 6 victoires cette saiso"
  },
  Task_68865_Name = {
    Text = "6 victoires"
  },
  Task_68866_Desc = {
    Text = "Obtenez 1 victoire cette saiso"
  },
  Task_68866_Name = {Text = "1 Victoire"},
  Task_68867_Desc = {
    Text = "Obtenez 10 victoires cette saiso"
  },
  Task_68867_Name = {
    Text = "10 Victoires"
  },
  Task_69819_Desc = {
    Text = "Vaincre lors de la bataille finale en 35 tours"
  },
  Task_69819_Name = {
    Text = "Vaincre lors de la bataille finale en 35 tours"
  },
  Task_70112_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter une victoire dans « Désir chaotique »"
  },
  Task_70113_Desc = {
    Text = "Terminer « Cernes » en difficulté Folie"
  },
  Task_70114_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter 2 victoires dans « Désir chaotique »"
  },
  Task_70115_Desc = {
    Text = "Terminez \"Young Root\" en toute difficulté"
  },
  Task_70116_Desc = {
    Text = "Effacez toute difficulté de \"Pollinisation\""
  },
  Task_70117_Desc = {
    Text = "Terminer difficulté Folie de \"Jeune Racine\""
  },
  Task_70118_Desc = {
    Text = "Clear \"Germer\" à n'importe quelle difficulté"
  },
  Task_70119_Desc = {
    Text = "Utiliser un réveilleur du domaine hyperdimensionnel pour remporter une victoire dans « Désir chaotique »"
  },
  Task_70120_Desc = {
    Text = "Utiliser un réveilleur du domaine hyperdimensionnel pour remporter 2 victoires dans « Désir chaotique »"
  },
  Task_70121_Desc = {
    Text = "Désir chaotique · Folie"
  },
  Task_70122_Desc = {
    Text = "Terminer « Fruit Tombé » à la difficulté folie"
  },
  Task_70123_Desc = {
    Text = "Désir chaotique · Domaine"
  },
  Task_70124_Desc = {
    Text = "Terminer « Pollinisation » en difficulté Folie"
  },
  Task_70125_Desc = {
    Text = "Terminer \"Sépale\" en difficulté Folie"
  },
  Task_70126_Desc = {
    Text = "Vaincre \"Fleur de Régénération\" à n'importe quelle difficulté"
  },
  Task_70127_Desc = {
    Text = "Terminer la difficulté Folie de « Fleur Régénérante »"
  },
  Task_70128_Desc = {
    Text = "Terminer « Germination » en difficulté Folie"
  },
  Task_70129_Desc = {
    Text = "Compléter n'importe quelle difficulté de \"Glande de Nectar\""
  },
  Task_70130_Desc = {
    Text = "Terminez \"Year Ring\" en toute difficulté"
  },
  Task_70131_Desc = {
    Text = "Complétez \"Perle Embryon\" à n'importe quelle difficulté"
  },
  Task_70132_Desc = {
    Text = "Complétez \"Fruit Déchu\" à n'importe quelle difficulté"
  },
  Task_70133_Desc = {
    Text = "Terminer « Ovule » en difficulté Folie"
  },
  Task_70134_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 2 fois dans « Désir chaotique »"
  },
  Task_70135_Desc = {
    Text = "Complétez \"Fleur\" à n'importe quelle difficulté"
  },
  Task_70136_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 1 victoire dans « Désir chaotique »"
  },
  Task_70137_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter 2 victoires dans « Désir chaotique »"
  },
  Task_70138_Desc = {
    Text = "Terminer « Reproduction Multiple » en difficulté Folie"
  },
  Task_70139_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter une victoire dans « Désir chaotique »"
  },
  Task_70140_Desc = {
    Text = "Vaincre \"Embryons Multiples\" à n'importe quelle difficulté"
  },
  Task_70141_Desc = {
    Text = "Terminer \"Nectar\" en difficulté Folie"
  },
  Task_70307_Desc = {
    Text = "Vaincre lors de la bataille finale en 40 tours"
  },
  Task_70307_Name = {
    Text = "Vaincre lors de la bataille finale en 40 tours"
  },
  Task_70446_Name = {
    Text = "Rejouer le niveau 8-8"
  },
  Task_70447_Name = {
    Text = "Rejouer le niveau 8-4"
  },
  Task_70448_Name = {
    Text = "Rejouer le niveau secondaire normal 12 de Lake"
  },
  Task_70449_Name = {
    Text = "Rejouer le chapitre secondaire normal 3 d'Erika"
  },
  Task_70450_Name = {
    Text = "Rejouer le niveau 3-14"
  },
  Task_70451_Name = {
    Text = "Rejouer le niveau secondaire de Shana - Niveau 4"
  },
  Task_70452_Name = {
    Text = "Rejouer le niveau secondaire normal 9 d'Horla"
  },
  Task_70453_Name = {
    Text = "Rejouer le niveau secondaire normal 4 d'Ogier"
  },
  Task_70454_Name = {
    Text = "Rejouer le niveau 2-16"
  },
  Task_70455_Name = {
    Text = "Rejouer le niveau 2-15"
  },
  Task_70456_Name = {
    Text = "Rejouer le chapitre secondaire normal 3 d'Oreta"
  },
  Task_70457_Name = {
    Text = "Rejouer le niveau secondaire normal 10 de « 24 »"
  },
  Task_70458_Name = {
    Text = "Rejouer le niveau secondaire normal 10 de Daphné"
  },
  Task_70459_Name = {
    Text = "Rejouer le niveau secondaire normal 5 d'Agrippa"
  },
  Task_70460_Name = {
    Text = "Rejouer le niveau 6-8"
  },
  Task_70461_Name = {
    Text = "Rejouer le niveau 8-14"
  },
  Task_70462_Name = {
    Text = "Rejouer le chapitre secondaire normal 13 de Sorel"
  },
  Task_70463_Name = {
    Text = "Rejouer le chapitre secondaire normal 15 de Miryam"
  },
  Task_70464_Name = {
    Text = "Rejouer le niveau 8-7"
  },
  Task_70465_Name = {
    Text = "Rejouer le niveau 7-2"
  },
  Task_70466_Name = {
    Text = "Rejouer le niveau 7-3"
  },
  Task_70467_Name = {
    Text = "Rejouer le niveau 7-1"
  },
  Task_70468_Name = {
    Text = "Rejouer le chapitre secondaire normal 7 de Lili"
  },
  Task_70469_Name = {
    Text = "Rejouer le niveau secondaire normal 4 de Ramona"
  },
  Task_70470_Name = {
    Text = "Rejouer le niveau 1-8"
  },
  Task_70471_Name = {
    Text = "Rejouer le niveau secondaire normal 9 de la genèse hilote"
  },
  Task_70472_Name = {
    Text = "Rejouer le niveau 4-16"
  },
  Task_70473_Name = {
    Text = "Rejouer le niveau 1-14"
  },
  Task_70474_Name = {
    Text = "Rejouer le niveau 4-13"
  },
  Task_70475_Name = {
    Text = "Rejouer le niveau 1-15"
  },
  Task_70476_Name = {
    Text = "Rejouer le niveau 9-13"
  },
  Task_70477_Name = {
    Text = "Rejouer le niveau 3-2"
  },
  Task_70478_Name = {
    Text = "Rejouer le niveau 3-3"
  },
  Task_70479_Name = {
    Text = "Rejouer le niveau secondaire normal 4 de Youhouha"
  },
  Task_70480_Name = {
    Text = "Rejouer le niveau 6-15"
  },
  Task_70481_Name = {
    Text = "Rejouer le chapitre secondaire normal 3 de Goliath"
  },
  Task_70482_Name = {
    Text = "Rejouer le niveau 5-12"
  },
  Task_70483_Name = {
    Text = "Rejouer le niveau 6-10"
  },
  Task_70484_Name = {
    Text = "Rejouer le chapitre secondaire normal 9 de Salvador"
  },
  Task_70485_Name = {
    Text = "Rejouer le niveau secondaire normal 4 de Vanda"
  },
  Task_70941_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_70941_Name = {
    Text = "Résolution rapide"
  },
  Task_70942_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_70942_Name = {
    Text = "Élégant et précis"
  },
  Task_70943_Desc = {
    Text = "Piger au moins 5 cartes supplémentaires en un tour pendant la Bataille Finale"
  },
  Task_70943_Name = {Text = "Draw!"},
  Task_70944_Desc = {
    Text = "Avoir pas plus de 2 Cartes de Symptômes lors de l'achèvement"
  },
  Task_70944_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_70945_Desc = {
    Text = "Obtenez au moins 1 type de sceau"
  },
  Task_70945_Name = {
    Text = "Marque de l'Âme"
  },
  Task_70946_Desc = {
    Text = "Vaincre avec une Vie pas en dessous de 50%"
  },
  Task_70946_Name = {
    Text = "Élégant et précis"
  },
  Task_70947_Desc = {
    Text = "Terminer avec au moins une création dorée"
  },
  Task_70947_Name = {
    Text = "Planque secrète"
  },
  Task_70948_Desc = {
    Text = "Avoir pas plus de 2 Cartes de Symptômes lors de l'achèvement"
  },
  Task_70948_Name = {
    Text = "Économiseur d'énergie"
  },
  Task_70949_Desc = {
    Text = "Transportez au moins 2 Reliques à l'achèvement"
  },
  Task_70949_Name = {
    Text = "Planque secrète"
  },
  Task_70950_Desc = {
    Text = "Terminer avec au moins une création dorée"
  },
  Task_70950_Name = {
    Text = "Planque secrète"
  },
  Task_70951_Desc = {
    Text = "Jouer au moins 5 Cartes en un tour lors de la Bataille Finale."
  },
  Task_70951_Name = {Text = "Mon tour !"},
  Task_70952_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_70952_Name = {
    Text = "Résolution rapide"
  },
  Task_70953_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_70953_Name = {
    Text = "Résolution rapide"
  },
  Task_70954_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_70954_Name = {
    Text = "Résolution rapide"
  },
  Task_70955_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_70955_Name = {
    Text = "Résolution rapide"
  },
  Task_70956_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_70956_Name = {
    Text = "Résolution rapide"
  },
  Task_70957_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_70957_Name = {
    Text = "Résolution rapide"
  },
  Task_70958_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_70958_Name = {
    Text = "Résolution rapide"
  },
  Task_70959_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_70959_Name = {
    Text = "Résolution rapide"
  },
  Task_70960_Desc = {
    Text = "Gagner la Bataille Finale en moins de 10 tours"
  },
  Task_70960_Name = {
    Text = "Résolution rapide"
  },
  Task_71343_Desc = {
    Text = "Terminer difficulté Folie de «Catastrophe»"
  },
  Task_71344_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 1 fois dans « Porte de l'illusion »"
  },
  Task_71345_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 2 fois dans « Porte de l'illusion »"
  },
  Task_71346_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Extinction éclatante»"
  },
  Task_71347_Desc = {
    Text = "Terminer n'importe quelle difficulté de \"Catastrophe Frénétique\""
  },
  Task_71348_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Prophétie du Chaos»"
  },
  Task_71349_Desc = {
    Text = "Porte de l'illusion · Domaine"
  },
  Task_71350_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Maison des Poupées »"
  },
  Task_71351_Desc = {
    Text = "Terminer « Étoile » à la difficulté Folie"
  },
  Task_71352_Desc = {
    Text = "Terminer n'importe quelle difficulté de \"Catastrophe Frénétique\""
  },
  Task_71353_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Extinction Éclatante»"
  },
  Task_71354_Desc = {
    Text = "Terminer n'importe quelle difficulté de \"Fête dansante\""
  },
  Task_71355_Desc = {
    Text = "Porte du néant · Folie"
  },
  Task_71356_Desc = {
    Text = "Terminer n'importe quelle difficulté de \"Jeu de Marionnettes\""
  },
  Task_71357_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Poison de la Réalité »"
  },
  Task_71358_Desc = {
    Text = "Terminer « Fil de Marionnette » à la difficulté Folie"
  },
  Task_71359_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter 2 victoires dans « Porte de l'illusion »"
  },
  Task_71360_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Prédiction du Chaos»"
  },
  Task_71361_Desc = {
    Text = "Terminer « Invitation » à la difficulté Folie"
  },
  Task_71362_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter 2 victoires dans « Porte de l'illusion »"
  },
  Task_71363_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter une victoire dans « Porte de l'illusion »"
  },
  Task_71364_Desc = {
    Text = "Porte du néant · Terminé"
  },
  Task_71365_Desc = {
    Text = "Terminez tous les succès de « Porte du néant · Terminé »"
  },
  Task_71366_Desc = {
    Text = "Terminer « Éteinte éclatante » à la difficulté Folie"
  },
  Task_71367_Desc = {
    Text = "Terminer difficulté Folie de « Véritable poison »"
  },
  Task_71368_Desc = {
    Text = "Terminer n'importe quelle difficulté de \"Jeu de Marionnettes\""
  },
  Task_71369_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter une victoire dans « Porte de l'illusion »"
  },
  Task_71370_Desc = {
    Text = "Terminer difficulté Folie de « Maison des Poupées »"
  },
  Task_71373_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Étoile»"
  },
  Task_71374_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter 2 victoires dans « Porte du néant »"
  },
  Task_71375_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter une victoire dans « Porte de l'illusion »"
  },
  Task_71376_Desc = {
    Text = "Terminer n'importe quelle difficulté de \"Fête dansante\""
  },
  Task_71377_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Maison des Poupées »"
  },
  Task_71378_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Étoiles»"
  },
  Task_71379_Desc = {
    Text = "Terminer n'importe quelle difficulté d'« invitation »"
  },
  Task_71380_Desc = {
    Text = "Terminer « Prédiction du Chaos » à la difficulté Folie"
  },
  Task_71381_Desc = {
    Text = "Terminer «Balançoire» en difficulté Folie"
  },
  Task_71382_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Poison de la Réalité »"
  },
  Task_71385_Desc = {
    Text = "Terminer n'importe quelle difficulté d'« invitation »"
  },
  Task_71757_Desc = {
    Text = "Terminer « Comédie Masquée » en difficulté Folie"
  },
  Task_71758_Desc = {
    Text = "Terminez \"Plot Twist\" en toute difficulté"
  },
  Task_71759_Desc = {
    Text = "Terminer « Moment de Silence » en difficulté Folie"
  },
  Task_71760_Desc = {
    Text = "Compléter \"Moment Calme\" en n'importe quelle difficulté"
  },
  Task_71761_Desc = {
    Text = "Terminer « Catharsis » en difficulté Folie"
  },
  Task_71762_Desc = {
    Text = "Clear \"Arc Theory\" en n'importe quelle difficulté"
  },
  Task_71763_Desc = {
    Text = "Terminer « Roue de l'Intrigue » à la difficulté Folie"
  },
  Task_71764_Desc = {
    Text = "Terminer \"Effet d'Étrangeté\" en difficulté Folie"
  },
  Task_71765_Desc = {
    Text = "Terminer « Les Trois Unités » à la difficulté Folie"
  },
  Task_71766_Desc = {
    Text = "Clear \"Trinité\" à n'importe quelle difficulté"
  },
  Task_71767_Desc = {
    Text = "Vaincre \"Catharsis\" à n'importe quelle difficulté"
  },
  Task_71768_Desc = {
    Text = "Vaincre \"Comédie Masquée\" à n'importe quelle difficulté"
  },
  Task_71769_Desc = {
    Text = "Terminer « Quatrième Mur du Théâtre » en difficulté Folie"
  },
  Task_71770_Desc = {
    Text = "Terminez \"the Fourth Wall of Drama\" en toute difficulté"
  },
  Task_71771_Desc = {
    Text = "Compléter \"Effet d'Étrangeté\" en n'importe quelle difficulté"
  },
  Task_71772_Desc = {
    Text = "Terminer « Théorie de l'Arc » en difficulté Folie"
  },
  Task_71773_Desc = {
    Text = "Terminer «Pyramide du Scénario» en difficulté Folie"
  },
  Task_71774_Desc = {
    Text = "Vaincre \"Pyramide du Dramaturge\" à n'importe quelle difficulté"
  },
  Task_71775_Desc = {
    Text = "Mystère du script : Folie"
  },
  Task_71795_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_71795_Name = {
    Text = "2800 points"
  },
  Task_71796_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_71796_Name = {
    Text = "2700 points"
  },
  Task_71797_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_71797_Name = {
    Text = "2900 points"
  },
  Task_71798_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_71798_Name = {
    Text = "2600 points"
  },
  Task_71799_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_71799_Name = {
    Text = "2300 points"
  },
  Task_71800_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_71800_Name = {
    Text = "2400 points"
  },
  Task_71801_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_71801_Name = {
    Text = "2500 points"
  },
  Task_71802_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_71802_Name = {
    Text = "1900 points"
  },
  Task_71803_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_71803_Name = {
    Text = "2000 points"
  },
  Task_71804_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_71804_Name = {
    Text = "2100 points"
  },
  Task_71805_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_71805_Name = {
    Text = "2200 points"
  },
  Task_71806_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_71806_Name = {
    Text = "3000 points"
  },
  Task_71807_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_71807_Name = {
    Text = "1600 points"
  },
  Task_71808_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_71808_Name = {
    Text = "1700 points"
  },
  Task_71809_Desc = {
    Text = "Points de Match Maximaux Atteints"
  },
  Task_71809_Name = {
    Text = "1800 points"
  },
  Task_71819_Desc = {
    Text = "Complétez \"Finale\" à n'importe quelle difficulté"
  },
  Task_71820_Desc = {
    Text = "Complétez \"Visage\" à n'importe quelle difficulté"
  },
  Task_71821_Desc = {
    Text = "Terminez \"Tonton Pattes Longues\" à n'importe quelle difficulté"
  },
  Task_71822_Desc = {
    Text = "Complétez \"Regard\" à n'importe quelle difficulté"
  },
  Task_71823_Desc = {
    Text = "Vaincre \"Jeu de Marionnettes\" à n'importe quelle difficulté"
  },
  Task_71824_Desc = {
    Text = "Éliminez \"Scénario Inachevé\" à n'importe quelle difficulté"
  },
  Task_71825_Desc = {
    Text = "Compléter \"Coin de Rose\" en n'importe quelle difficulté"
  },
  Task_71826_Desc = {
    Text = "Complétez \"Poisson Sous la Bouilloire\" à n'importe quelle difficulté"
  },
  Task_71827_Desc = {
    Text = "Complétez \"Cadeau\" à n'importe quelle difficulté"
  },
  Task_71867_Desc = {
    Text = "Posséder 5/6/7/8 créations, obtenir 250/500/750/1000 points."
  },
  Task_71867_Name = {
    Text = "Collection de réalité<size=20><color=#747474>Possédez 8 Reliques</color></size>"
  },
  Task_71868_Desc = {
    Text = "Chaque utilisation de la mémoire musculaire réduit la note d'enquête de 20 %."
  },
  Task_71868_Name = {
    Text = "Somnambule<size=20><color=#747474>Chaque utilisation de la mémoire musculaire réduit le score d'enquête de 20 %</color></size>"
  },
  Task_71934_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_71935_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_71936_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_71937_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_71939_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_71940_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_71941_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_71942_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_71943_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_71944_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_71945_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_71946_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_71947_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_71948_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_71949_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_71950_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_71952_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_71953_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_71954_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_71955_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_71977_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_71978_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_71980_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_71981_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_72038_Name = {
    Text = "Rejouer le niveau secondaire normal 4 de Tulu"
  },
  Task_72039_Desc = {
    Text = "Terminer « Regard » à la difficulté Folie"
  },
  Task_72040_Desc = {
    Text = "Terminer « Poisson dans le chaudron » à la difficulté Folie"
  },
  Task_72041_Desc = {
    Text = "Terminer « Jeu de Marionnettes » à la difficulté Folie"
  },
  Task_72042_Desc = {
    Text = "Terminer « Cadeau » à la difficulté Folie"
  },
  Task_72043_Desc = {
    Text = "Terminer le dossier spécial « Souvenirs de la rose »"
  },
  Task_72044_Desc = {
    Text = "Terminer \"Oncle Longues Jambes\" en difficulté Folie"
  },
  Task_72045_Desc = {
    Text = "Terminer la difficulté Folie de « Scénario Inachevé »"
  },
  Task_72046_Desc = {
    Text = "Terminer \"Coin de Rose\" en difficulté Folie"
  },
  Task_72047_Desc = {
    Text = "Terminer « Visage » à la difficulté Folie"
  },
  Task_72048_Desc = {
    Text = "Complétez \"Finale\" en difficulté Folie"
  },
  Task_72049_Desc = {
    Text = "Souvenirs de la rose · Folie"
  },
  Task_72245_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72245_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Souhaitez-vous vous rendre dans « Inversion du tour » ?"
  },
  Task_72386_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72386_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Souhaitez-vous vous y rendre ?"
  },
  Task_72387_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72387_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Souhaitez-vous vous y rendre ?"
  },
  Task_72389_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72389_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Souhaitez-vous vous y rendre ?"
  },
  Task_72390_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72390_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Souhaitez-vous vous y rendre ?"
  },
  Task_72391_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72391_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Souhaitez-vous vous y rendre ?"
  },
  Task_72392_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72392_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Voulez-vous vous y rendre ?"
  },
  Task_72393_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72393_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Souhaitez-vous vous y rendre ?"
  },
  Task_72394_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72394_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Souhaitez-vous vous y rendre ?"
  },
  Task_72395_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72395_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Voulez-vous vous rendre dans « Inversion du tour » ?"
  },
  Task_72396_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72396_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Souhaitez-vous vous y rendre ?"
  },
  Task_72416_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72416_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Souhaitez-vous vous rendre dans « Inversion du tour » ?"
  },
  Task_72420_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72420_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Souhaitez-vous vous y rendre maintenant ?"
  },
  Task_72540_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72540_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Voulez-vous vous rendre dans « Inversion du tour » ?"
  },
  Task_72541_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72541_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Souhaitez-vous vous y rendre ?"
  },
  Task_72542_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72542_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Souhaitez-vous vous y rendre ?"
  },
  Task_72545_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72545_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Souhaitez-vous vous y rendre ?"
  },
  Task_72546_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72546_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Souhaitez-vous vous y rendre ?"
  },
  Task_72547_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72547_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Souhaitez-vous vous y rendre ?"
  },
  Task_72548_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72548_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Voulez-vous vous rendre dans « Inversion du tour » ?"
  },
  Task_72549_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72549_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Souhaitez-vous vous y rendre ?"
  },
  Task_72632_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72632_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Voulez-vous vous y rendre ?"
  },
  Task_72652_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72652_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'invité d'un autre monde ». Souhaitez-vous vous y rendre maintenant ?"
  },
  Task_72677_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72677_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'invité d'un autre monde ». Souhaitez-vous vous y rendre ?"
  },
  Task_72678_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72678_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'invité d'un autre monde ». Souhaitez-vous vous y rendre maintenant ?"
  },
  Task_72679_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72679_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'invité d'un autre monde ». Souhaitez-vous vous y rendre ?"
  },
  Task_72681_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72681_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'invité d'un autre monde ». Souhaitez-vous vous y rendre maintenant ?"
  },
  Task_72682_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72682_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'invité d'un autre monde ». Voulez-vous vous rendre dans « Inversion du tour » ?"
  },
  Task_72683_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72683_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'invité d'un autre monde ». Souhaitez-vous vous y rendre maintenant ?"
  },
  Task_72684_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72684_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'invité d'un autre monde ». Souhaitez-vous vous y rendre maintenant ?"
  },
  Task_72685_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72685_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'invité d'un autre monde ». Souhaitez-vous vous y rendre ?"
  },
  Task_72700_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72700_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Souhaitez-vous vous y rendre ?"
  },
  Task_72701_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72701_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Souhaitez-vous vous y rendre ?"
  },
  Task_72703_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72703_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Souhaitez-vous vous rendre dans « Inversion du tour » ?"
  },
  Task_72704_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72704_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Souhaitez-vous vous y rendre ?"
  },
  Task_72705_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72705_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Souhaitez-vous vous y rendre ?"
  },
  Task_72706_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72706_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Voulez-vous vous y rendre ?"
  },
  Task_72707_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72707_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Souhaitez-vous vous y rendre maintenant ?"
  },
  Task_72709_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72709_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Voulez-vous vous rendre dans « Inversion du tour » ?"
  },
  Task_72773_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72773_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Souhaitez-vous vous rendre dans « Inversion du tour » ?"
  },
  Task_72790_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72790_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Souhaitez-vous vous y rendre ?"
  },
  Task_72798_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72798_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des dix mille phénomènes ». Voulez-vous vous rendre dans « Inversion du tour » ?"
  },
  Task_72799_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72799_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Souhaitez-vous vous y rendre ?"
  },
  Task_72800_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72800_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Voulez-vous vous y rendre ?"
  },
  Task_72801_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72801_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Voulez-vous vous y rendre ?"
  },
  Task_72802_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72802_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Souhaitez-vous vous y rendre ?"
  },
  Task_72803_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72803_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Voulez-vous vous rendre dans « Inversion du tour » ?"
  },
  Task_72805_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72805_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Souhaitez-vous vous y rendre maintenant ?"
  },
  Task_72806_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72806_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Souhaitez-vous vous y rendre maintenant ?"
  },
  Task_72807_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_72807_UnlockCondDesc = {
    Text = "Débloqué après avoir terminé « Inversion du tour : L'instant de l'inversion des Dix Mille Phénomènes ». Souhaitez-vous vous y rendre ?"
  },
  Task_72957_Desc = {
    Text = "Utiliser « Surmonter la douleur » pour obtenir 3 victoires"
  },
  Task_72958_Desc = {
    Text = "Utilisez « Retour de l'aberration » pour obtenir 1 victoire"
  },
  Task_72959_Desc = {
    Text = "Utiliser « Fusion du noyau » pour remporter 3 victoires"
  },
  Task_72961_Desc = {
    Text = "Utiliser « La magie de 35 mm » pour remporter 1 victoire"
  },
  Task_72963_Desc = {
    Text = "Utiliser « Les décrets de la reine » pour remporter 3 victoires"
  },
  Task_72965_Desc = {
    Text = "Utilisez « Million de regards aimants » pour obtenir 1 victoire"
  },
  Task_72968_Desc = {
    Text = "Utiliser « Émergence » pour remporter 1 victoire"
  },
  Task_72973_Desc = {
    Text = "Utiliser « Lily » pour remporter 1 victoire"
  },
  Task_72975_Desc = {
    Text = "Utiliser « Sang et sable rugissants » pour remporter 3 victoires"
  },
  Task_72976_Desc = {
    Text = "Utilisez « Collection extrêmement précieuse » pour obtenir 3 victoires"
  },
  Task_72977_Desc = {
    Text = "Utiliser « Roue cachée du monde » pour obtenir 3 victoires"
  },
  Task_72978_Desc = {
    Text = "Utiliser « L'information, c'est la vie » pour remporter 3 victoires"
  },
  Task_72980_Desc = {
    Text = "Utiliser « Liz » pour remporter 1 victoire"
  },
  Task_72982_Desc = {
    Text = "Utiliser « Au-delà de la mort » pour remporter 3 victoires"
  },
  Task_72983_Desc = {
    Text = "Utiliser « Regard en arrière au bord du lac » pour remporter une victoire"
  },
  Task_72986_Desc = {
    Text = "Utiliser « Lame du géant » pour remporter 1 victoire"
  },
  Task_72989_Desc = {
    Text = "Utiliser « Ogier » pour obtenir 3 victoires"
  },
  Task_72990_Desc = {
    Text = "Utiliser « Berceuse de dévoration » pour remporter 1 victoire"
  },
  Task_72992_Desc = {
    Text = "Utiliser « Point critique » pour remporter 1 victoire"
  },
  Task_72993_Desc = {
    Text = "Utiliser « À mon ami » pour remporter 1 victoire"
  },
  Task_72994_Desc = {
    Text = "Utiliser « Éternité éphémère » pour remporter 1 victoire"
  },
  Task_72995_Desc = {
    Text = "Utiliser « Mort de Mme Coral » pour remporter 1 victoire"
  },
  Task_72997_Desc = {
    Text = "Utiliser « Oreta » pour obtenir 3 victoires"
  },
  Task_72999_Desc = {
    Text = "Utiliser « Victoire des roses » pour remporter 3 victoires"
  },
  Task_73001_Desc = {
    Text = "Utiliser « Favori de la commande » pour obtenir une victoire"
  },
  Task_73003_Desc = {
    Text = "Utiliser « Le regard d'Isaraou » pour remporter 3 victoires"
  },
  Task_73004_Desc = {
    Text = "Utiliser « Bâton de noble » pour remporter 1 victoire"
  },
  Task_73006_Desc = {
    Text = "Utiliser « Heure de chance » pour remporter 3 victoires"
  },
  Task_73007_Desc = {
    Text = "Utiliser « Agrippa » pour obtenir 3 victoires"
  },
  Task_73009_Desc = {
    Text = "Utiliser « Quand la montagne de neige fondra » pour remporter 1 victoire"
  },
  Task_73011_Desc = {
    Text = "Utiliser « Barrière du cœur » pour remporter 1 victoire"
  },
  Task_73012_Desc = {
    Text = "Utiliser « Miryam » pour obtenir 3 victoires"
  },
  Task_73014_Desc = {
    Text = "Utiliser « Hameln » pour remporter une victoire"
  },
  Task_73015_Desc = {
    Text = "Utiliser « Rêve de la mer » pour remporter 3 victoires"
  },
  Task_73016_Desc = {
    Text = "Utiliser « Délire » pour remporter 1 victoire"
  },
  Task_73018_Desc = {
    Text = "Utiliser « Spectacle de magie heureuse » pour remporter 1 victoire"
  },
  Task_73019_Desc = {
    Text = "Utilisez « Maturation » pour obtenir 1 victoire"
  },
  Task_73021_Desc = {
    Text = "Utiliser « L'innocence en argent pur » pour remporter 1 victoire"
  },
  Task_73022_Desc = {
    Text = "Obtenir 1 victoire en utilisant « Poupée »"
  },
  Task_73025_Desc = {
    Text = "Utilisez « Murmure » pour obtenir 1 victoire"
  },
  Task_73026_Desc = {
    Text = "Utilisez « Activité » pour obtenir une victoire"
  },
  Task_73028_Desc = {
    Text = "Utiliser « Jonquille » pour remporter 1 victoire"
  },
  Task_73030_Desc = {
    Text = "Utiliser « Bigorneau » pour remporter 3 victoires"
  },
  Task_73033_Desc = {
    Text = "Utilisez « Plongée dans le rouge » pour obtenir 1 victoire"
  },
  Task_73037_Desc = {
    Text = "Utiliser « Briser la chaîne » pour remporter 3 victoires"
  },
  Task_73039_Desc = {
    Text = "Utilisez « Mémoires d'une nuit d'hiver » pour obtenir 1 victoire"
  },
  Task_73041_Desc = {
    Text = "Utilisez « Naissance secrète » pour obtenir une victoire"
  },
  Task_73044_Desc = {
    Text = "Utiliser « Ryker » pour obtenir 3 victoires"
  },
  Task_73045_Desc = {
    Text = "Obtenir 1 victoire en utilisant « Fondu·Poupée »"
  },
  Task_73047_Desc = {
    Text = "Utiliser « Évanouissement » pour obtenir 1 victoire"
  },
  Task_73048_Desc = {
    Text = "Utiliser « Thais » pour remporter 3 victoires"
  },
  Task_73050_Desc = {
    Text = "Utiliser « Aigis » pour obtenir 3 victoires"
  },
  Task_73051_Desc = {
    Text = "Utiliser « Aurita » pour remporter 1 victoire"
  },
  Task_73052_Desc = {
    Text = "Utiliser « Sanga » pour obtenir 1 victoire"
  },
  Task_73053_Desc = {
    Text = "Utiliser « Murphy » pour remporter une victoire"
  },
  Task_73054_Desc = {
    Text = "Utiliser « Tawil » pour remporter 3 victoires"
  },
  Task_73055_Desc = {
    Text = "Obtenir 3 victoires en utilisant « Poupée »"
  },
  Task_73056_Desc = {
    Text = "Utiliser « Salvador » pour remporter 1 victoire"
  },
  Task_73057_Desc = {
    Text = "Utiliser « La seule semence » pour remporter 3 victoires"
  },
  Task_73059_Desc = {
    Text = "Utiliser « Détermination du cabillaud argenté » pour remporter 3 victoires"
  },
  Task_73061_Desc = {
    Text = "Utiliser « Couper et blesser » pour remporter 3 victoires"
  },
  Task_73063_Desc = {
    Text = "Remporter 1 victoire en utilisant « Nourriture de la compassion »"
  },
  Task_73064_Desc = {
    Text = "Utiliser « Châtiment » pour obtenir 3 victoires"
  },
  Task_73066_Desc = {
    Text = "Utiliser « Roulette du destin » pour remporter 3 victoires"
  },
  Task_73067_Desc = {
    Text = "Utiliser « Pandia » pour remporter une victoire"
  },
  Task_73068_Desc = {
    Text = "Utiliser « Elle en entier » pour remporter 1 victoire"
  },
  Task_73070_Desc = {
    Text = "Utiliser « La domination du géant » pour obtenir 3 victoires"
  },
  Task_73073_Desc = {
    Text = "Utiliser « Ramona » pour remporter 3 victoires"
  },
  Task_73074_Desc = {
    Text = "Utiliser « Fin du vers » pour remporter 1 victoire"
  },
  Task_73075_Desc = {
    Text = "Utiliser « Descendant pâle » pour remporter 3 victoires"
  },
  Task_73077_Desc = {
    Text = "Utilisez « Wanda » pour remporter une victoire"
  },
  Task_73081_Desc = {
    Text = "Utiliser « Pouvoir des pieux » pour remporter 1 victoire"
  },
  Task_73082_Desc = {
    Text = "Utiliser « Spirale de mémoire » pour remporter 1 victoire"
  },
  Task_73083_Desc = {
    Text = "Utiliser « Retour dans le temps » pour remporter 3 victoires"
  },
  Task_73085_Desc = {
    Text = "Utiliser « Horla » pour remporter une victoire"
  },
  Task_73086_Desc = {
    Text = "Utiliser « Moment de réunion » pour remporter 1 victoire"
  },
  Task_73087_Desc = {
    Text = "Utiliser « Banquet silencieux » pour obtenir 3 victoires"
  },
  Task_73088_Desc = {
    Text = "Utiliser « Sous la pluie battante » pour remporter 1 victoire"
  },
  Task_73089_Desc = {
    Text = "Utiliser « Lotan » pour remporter une victoire"
  },
  Task_73090_Desc = {
    Text = "Utiliser « Festin sanglant » pour remporter 1 victoire"
  },
  Task_73095_Desc = {
    Text = "Utiliser « Karen » pour remporter une victoire"
  },
  Task_73097_Desc = {
    Text = "Utiliser « Mer du désir » pour remporter 1 victoire"
  },
  Task_73098_Desc = {
    Text = "Utiliser « Casiah » pour remporter une victoire"
  },
  Task_73099_Desc = {
    Text = "Utiliser « Rêve d'été » pour remporter 1 victoire"
  },
  Task_73100_Desc = {
    Text = "Utiliser « Sorel » pour obtenir 3 victoires"
  },
  Task_73102_Desc = {
    Text = "Utiliser « Chant du Roi divin » pour obtenir 1 victoire"
  },
  Task_73105_Desc = {
    Text = "Utiliser « Échange inégal » pour remporter 3 victoires"
  },
  Task_73107_Desc = {
    Text = "Utiliser « Cœur de chevalier » pour remporter 1 victoire"
  },
  Task_73109_Desc = {
    Text = "Utiliser « Malédiction amère » pour remporter 3 victoires"
  },
  Task_73110_Desc = {
    Text = "Utiliser « Salvador » pour remporter 3 victoires"
  },
  Task_73111_Desc = {
    Text = "Utiliser « Bête Céleste » pour remporter 3 victoires"
  },
  Task_73117_Desc = {
    Text = "Utiliser « Étreinte corrosive » pour remporter 1 victoire"
  },
  Task_73118_Desc = {
    Text = "Utiliser « Le trésor d'Aurita » pour remporter 1 victoire"
  },
  Task_73120_Desc = {
    Text = "Utiliser « Fable de la gourmandise » pour remporter 1 victoire"
  },
  Task_73122_Desc = {
    Text = "Utiliser « Circuit - Ramona » pour obtenir 3 victoires"
  },
  Task_73123_Desc = {
    Text = "Utiliser « Dernier serment » pour remporter 1 victoire"
  },
  Task_73124_Desc = {
    Text = "Utiliser « Exil » pour obtenir 3 victoires"
  },
  Task_73126_Desc = {
    Text = "Utiliser « Faveur » pour obtenir 1 victoire"
  },
  Task_73128_Desc = {
    Text = "Utiliser « Avarice » pour remporter 3 victoires"
  },
  Task_73129_Desc = {
    Text = "Utilisez « Caecus » pour remporter une victoire"
  },
  Task_73130_Desc = {
    Text = "Utiliser « La Porte de la Vérité » pour remporter 3 victoires"
  },
  Task_73131_Desc = {
    Text = "Utilisez « Au nom de la rose » pour remporter une victoire"
  },
  Task_73134_Desc = {
    Text = "Utiliser « Erica » pour remporter 3 victoires"
  },
  Task_73136_Desc = {
    Text = "Utiliser « Décortiquer la mort » pour remporter 3 victoires"
  },
  Task_73138_Desc = {
    Text = "Utiliser « Tinct » pour obtenir 3 victoires"
  },
  Task_73139_Desc = {
    Text = "Utiliser « Éternité éphémère » pour remporter 3 victoires"
  },
  Task_73140_Desc = {
    Text = "Utiliser « Devoir » pour remporter 3 victoires"
  },
  Task_73141_Desc = {
    Text = "Utilisez « Mingwu » pour obtenir 1 victoire"
  },
  Task_73144_Desc = {
    Text = "Utiliser « Lame du géant » pour obtenir 3 victoires"
  },
  Task_73147_Desc = {
    Text = "Utiliser « Concert sans fin » pour obtenir 3 victoires"
  },
  Task_73148_Desc = {
    Text = "Utiliser « Sommeil sous le glacier » pour remporter 3 victoires"
  },
  Task_73150_Desc = {
    Text = "Utiliser « Lily » pour remporter 3 victoires"
  },
  Task_73151_Desc = {
    Text = "Utiliser « Victoire des roses » pour remporter 1 victoire"
  },
  Task_73152_Desc = {
    Text = "Utiliser « Véritable forme de la brume grise » pour remporter 3 victoires"
  },
  Task_73153_Desc = {
    Text = "Obtenir 1 victoire en utilisant « Tulu »"
  },
  Task_73154_Desc = {
    Text = "Remporter 1 victoire en utilisant « Espoir »"
  },
  Task_73156_Desc = {
    Text = "Utiliser « Leigh » pour obtenir 3 victoires"
  },
  Task_73157_Desc = {
    Text = "Utiliser « Chéri » pour obtenir 3 victoires"
  },
  Task_73161_Desc = {
    Text = "Utiliser « Nymphaea » pour remporter 3 victoires"
  },
  Task_73162_Desc = {
    Text = "Utiliser « Frénésie » pour obtenir 3 victoires"
  },
  Task_73165_Desc = {
    Text = "Utilisez « Lieu inexistant » pour remporter une victoire"
  },
  Task_73166_Desc = {
    Text = "Utiliser « Faros » pour obtenir 3 victoires"
  },
  Task_73167_Desc = {
    Text = "Remporter une victoire en utilisant « Hilote »"
  },
  Task_73170_Desc = {
    Text = "Obtenir 3 victoires en utilisant « Tulu »"
  },
  Task_73172_Desc = {
    Text = "Utiliser « Suce » pour obtenir 3 victoires"
  },
  Task_73173_Desc = {
    Text = "Utiliser « Voile de gouvernail » pour obtenir 1 victoire"
  },
  Task_73174_Desc = {
    Text = "Utiliser « Moment de réunion » pour remporter 3 victoires"
  },
  Task_73176_Desc = {
    Text = "Remporter 1 victoire en utilisant « Céleste »"
  },
  Task_73177_Desc = {
    Text = "Utiliser « Shan » pour remporter 3 victoires"
  },
  Task_73178_Desc = {
    Text = "Utilisez « Perspicacité » pour obtenir une victoire"
  },
  Task_73180_Desc = {
    Text = "Utiliser « Requiem éternel » pour remporter 3 victoires"
  },
  Task_73181_Desc = {
    Text = "Utiliser « Facteur incalculable » pour remporter 3 victoires"
  },
  Task_73182_Desc = {
    Text = "Utiliser « Agrippa » pour remporter une victoire"
  },
  Task_73183_Desc = {
    Text = "Utiliser « La chanson enchaînée » pour remporter 3 victoires"
  },
  Task_73185_Desc = {
    Text = "Utiliser « Nuit polaire et lever du jour » pour remporter 3 victoires"
  },
  Task_73186_Desc = {
    Text = "Utiliser « Concentration mentale » pour remporter 1 victoire"
  },
  Task_73189_Desc = {
    Text = "Utiliser « Poupée tombée dans l'illusion » pour remporter 3 victoires"
  },
  Task_73192_Desc = {
    Text = "Utiliser « Caché dans la nuit » pour remporter 1 victoire"
  },
  Task_73193_Desc = {
    Text = "Utilisez « Syndrome de souvenirs » pour obtenir 1 victoire"
  },
  Task_73197_Desc = {
    Text = "Utiliser « Main de l'oubli » pour remporter 3 victoires"
  },
  Task_73200_Desc = {
    Text = "Utiliser « Sac d'aventure » pour remporter 1 victoire"
  },
  Task_73204_Desc = {
    Text = "Remporter 3 victoires en utilisant « Helot-catena »"
  },
  Task_73206_Desc = {
    Text = "Utiliser « Berceuse de dévoration » pour remporter 3 victoires"
  },
  Task_73208_Desc = {
    Text = "Obtenir 3 victoires en utilisant « Fondu·Poupée »"
  },
  Task_73209_Desc = {
    Text = "Utiliser « Mort de Mme Coral » pour remporter 3 victoires"
  },
  Task_73210_Desc = {
    Text = "Utiliser « Ogier » pour obtenir 1 victoire"
  },
  Task_73212_Desc = {
    Text = "Utiliser « Nourriture de la compassion » pour obtenir 3 victoires"
  },
  Task_73213_Desc = {
    Text = "Utiliser « Point critique » pour remporter 3 victoires"
  },
  Task_73214_Desc = {
    Text = "Utiliser « À mon ami » pour remporter 3 victoires"
  },
  Task_73216_Desc = {
    Text = "Utiliser « Plongée dans le rouge » pour remporter 3 victoires"
  },
  Task_73217_Desc = {
    Text = "Utilisez « Couper et blesser » pour obtenir 1 victoire"
  },
  Task_73218_Desc = {
    Text = "Utilisez « Véritable forme de la brume grise » pour remporter une victoire"
  },
  Task_73219_Desc = {
    Text = "Utiliser « Voix dans la tête » pour remporter 3 victoires"
  },
  Task_73220_Desc = {
    Text = "Utiliser « Bâton de noble » pour remporter 3 victoires"
  },
  Task_73222_Desc = {
    Text = "Utiliser « Main de l'oubli » pour remporter 1 victoire"
  },
  Task_73223_Desc = {
    Text = "Utiliser « Jenkin » pour obtenir 3 victoires"
  },
  Task_73224_Desc = {
    Text = "Utilisez « Miryam » pour remporter une victoire"
  },
  Task_73225_Desc = {
    Text = "Utiliser « Heure de chance » pour remporter 1 victoire"
  },
  Task_73227_Desc = {
    Text = "Utilisez « Route perdue » pour remporter une victoire"
  },
  Task_73228_Desc = {
    Text = "Utiliser « Alva » pour remporter 1 victoire"
  },
  Task_73229_Desc = {
    Text = "Utilisez « Tablette divine » pour obtenir 1 victoire"
  },
  Task_73232_Desc = {
    Text = "Utiliser « Émergence » pour remporter 3 victoires"
  },
  Task_73233_Desc = {
    Text = "Utiliser « Uvhash » pour remporter 3 victoires"
  },
  Task_73235_Desc = {
    Text = "Utiliser « La magie de 35 mm » pour remporter 3 victoires"
  },
  Task_73236_Desc = {
    Text = "Utiliser « Cadeau de décadence » pour remporter 1 victoire"
  },
  Task_73237_Desc = {
    Text = "Utiliser « Avarice » pour remporter 1 victoire"
  },
  Task_73241_Desc = {
    Text = "Utiliser « Lieu inexistant » pour obtenir 3 victoires"
  },
  Task_73243_Desc = {
    Text = "Utiliser « Liz » pour obtenir 3 victoires"
  },
  Task_73246_Desc = {
    Text = "Utilisez « Roue cachée du monde » pour remporter une victoire"
  },
  Task_73249_Desc = {
    Text = "Utiliser « Voix dans la tête » pour remporter 1 victoire"
  },
  Task_73250_Desc = {
    Text = "Utilisez « 24 » pour obtenir 1 victoire"
  },
  Task_73253_Desc = {
    Text = "Utiliser « Inébranlable » pour remporter 3 victoires"
  },
  Task_73254_Desc = {
    Text = "Utiliser « Retour de l'aberration » pour obtenir 3 victoires"
  },
  Task_73257_Desc = {
    Text = "Utilisez « Thais » pour remporter une victoire"
  },
  Task_73259_Desc = {
    Text = "Utiliser « Fynt » pour obtenir 3 victoires"
  },
  Task_73260_Desc = {
    Text = "Utilisez « Tawil » pour remporter une victoire"
  },
  Task_73262_Desc = {
    Text = "Utiliser « Aigis » pour remporter une victoire"
  },
  Task_73266_Desc = {
    Text = "Utiliser « Détermination du cabillaud argenté » pour remporter 1 victoire"
  },
  Task_73267_Desc = {
    Text = "Utiliser « Lotan » pour remporter 3 victoires"
  },
  Task_73268_Desc = {
    Text = "Utiliser « La seule semence » pour remporter 1 victoire"
  },
  Task_73269_Desc = {
    Text = "Utiliser « Châtiment » pour remporter 1 victoire"
  },
  Task_73270_Desc = {
    Text = "Utiliser « Nageoire douloureuse » pour remporter 1 victoire"
  },
  Task_73271_Desc = {
    Text = "Utiliser « Rêve d'été » pour remporter 3 victoires"
  },
  Task_73278_Desc = {
    Text = "Utilisez « La domination du géant » pour remporter une victoire"
  },
  Task_73279_Desc = {
    Text = "Utiliser « Erica » pour remporter une victoire"
  },
  Task_73280_Desc = {
    Text = "Utiliser « Exil » pour obtenir 1 victoire"
  },
  Task_73281_Desc = {
    Text = "Utiliser « Rêve de la mer » pour obtenir 1 victoire"
  },
  Task_73282_Desc = {
    Text = "Remporter 3 victoires en utilisant « Quand la montagne de neige fondra »"
  },
  Task_73284_Desc = {
    Text = "Utiliser « Roulette du destin » pour remporter 1 victoire"
  },
  Task_73285_Desc = {
    Text = "Utiliser « La Porte de la Vérité » pour remporter une victoire"
  },
  Task_73286_Desc = {
    Text = "Utiliser « Ramona » pour remporter une victoire"
  },
  Task_73287_Desc = {
    Text = "Utiliser « Pandia » pour obtenir 3 victoires"
  },
  Task_73288_Desc = {
    Text = "Utiliser « Nom de la Rose » pour remporter 3 victoires"
  },
  Task_73289_Desc = {
    Text = "Utiliser « Elle en entier » pour remporter 3 victoires"
  },
  Task_73290_Desc = {
    Text = "Utiliser « Wanda » pour obtenir 3 victoires"
  },
  Task_73292_Desc = {
    Text = "Utiliser « Fin du vers » pour remporter 3 victoires"
  },
  Task_73293_Desc = {
    Text = "Utiliser « Descendant pâle » pour remporter une victoire"
  },
  Task_73294_Desc = {
    Text = "Utilisez « Teinture » pour remporter une victoire"
  },
  Task_73296_Desc = {
    Text = "Utiliser « Fusion du noyau » pour remporter 1 victoire"
  },
  Task_73297_Desc = {
    Text = "Utiliser « Arrivée Miraculeuse » pour remporter 1 victoire"
  },
  Task_73298_Desc = {
    Text = "Utiliser « Sang et Sable Rugissants » pour remporter 1 victoire"
  },
  Task_73299_Desc = {
    Text = "Utiliser « Jenkins » pour remporter 1 victoire"
  },
  Task_73302_Desc = {
    Text = "Utiliser « Murmure » pour obtenir 3 victoires"
  },
  Task_73303_Desc = {
    Text = "Utiliser « Les décrets de la reine » pour remporter 1 victoire"
  },
  Task_73305_Desc = {
    Text = "Utilisez « Maturation » pour obtenir 3 victoires"
  },
  Task_73306_Desc = {
    Text = "Utilisez « Au-delà de la douleur » pour remporter une victoire"
  },
  Task_73309_Desc = {
    Text = "Utiliser « Banquet silencieux » pour remporter 1 victoire"
  },
  Task_73311_Desc = {
    Text = "Utiliser « Route perdue » pour obtenir 3 victoires"
  },
  Task_73312_Desc = {
    Text = "Utiliser « Golias » pour remporter 3 victoires"
  },
  Task_73313_Desc = {
    Text = "Utiliser « Fable de la gourmandise » pour remporter 3 victoires"
  },
  Task_73314_Desc = {
    Text = "Utiliser « Bigorneau » pour remporter 1 victoire"
  },
  Task_73315_Desc = {
    Text = "Utiliser « Million de regards aimants » pour remporter 3 victoires"
  },
  Task_73316_Desc = {
    Text = "Obtenir 3 victoires en utilisant « Daffodil »"
  },
  Task_73317_Desc = {
    Text = "Utiliser « L'information, c'est la vie » pour remporter 1 victoire"
  },
  Task_73318_Desc = {
    Text = "Utilisez « Ryker » pour obtenir 1 victoire"
  },
  Task_73321_Desc = {
    Text = "Utiliser « Horla » pour remporter 3 victoires"
  },
  Task_73322_Desc = {
    Text = "Utilisez « Collection extrêmement précieuse » pour remporter une victoire"
  },
  Task_73323_Desc = {
    Text = "Utiliser « Nautila » pour remporter 3 victoires"
  },
  Task_73324_Desc = {
    Text = "Utiliser « Regard en arrière au bord du lac » pour obtenir 3 victoires"
  },
  Task_73325_Desc = {
    Text = "Utilisez « Au-delà de la mort » pour remporter une victoire"
  },
  Task_73326_Desc = {
    Text = "Utiliser « Mémoires d'une nuit d'hiver » pour remporter 3 victoires"
  },
  Task_73327_Desc = {
    Text = "Utiliser « Sac d'aventure » pour remporter 3 victoires"
  },
  Task_73328_Desc = {
    Text = "Utiliser « Goliath » pour remporter une victoire"
  },
  Task_73330_Desc = {
    Text = "Utiliser « Malédiction amère » pour remporter 1 victoire"
  },
  Task_73333_Desc = {
    Text = "Utiliser « Facteur incalculable » pour remporter 1 victoire"
  },
  Task_73334_Desc = {
    Text = "Utiliser « Bête Céleste » pour remporter 1 victoire"
  },
  Task_73335_Desc = {
    Text = "Utiliser « Arrivée Miraculeuse » pour obtenir 3 victoires"
  },
  Task_73338_Desc = {
    Text = "Utiliser « Poupée tombée dans l'illusion » pour remporter une victoire"
  },
  Task_73341_Desc = {
    Text = "Utiliser « Murphy » pour remporter 3 victoires"
  },
  Task_73343_Desc = {
    Text = "Utiliser « Nuit polaire et lever du jour » pour remporter 1 victoire"
  },
  Task_73345_Desc = {
    Text = "Utiliser « Le regard d'Isaraou » pour remporter 1 victoire"
  },
  Task_73346_Desc = {
    Text = "Utiliser « Concentration mentale » pour remporter 3 victoires"
  },
  Task_73349_Desc = {
    Text = "Utiliser « Étreinte corrosive » pour remporter 3 victoires"
  },
  Task_73352_Desc = {
    Text = "Utiliser « Caché dans la nuit » pour remporter 3 victoires"
  },
  Task_73353_Desc = {
    Text = "Utiliser « Faveur » et remporter 3 victoires"
  },
  Task_73354_Desc = {
    Text = "Utiliser « Nautila » pour remporter une victoire"
  },
  Task_73355_Desc = {
    Text = "Utiliser « Circuit - Ramona » pour remporter une victoire"
  },
  Task_73356_Desc = {
    Text = "Utiliser « Le trésor d'Aurita » pour remporter 3 victoires"
  },
  Task_73357_Desc = {
    Text = "Utiliser « Dernier serment » pour remporter 3 victoires"
  },
  Task_73359_Desc = {
    Text = "Utiliser « Caecus » pour obtenir 3 victoires"
  },
  Task_73360_Desc = {
    Text = "Utiliser « Analyse de la mort » pour remporter 1 victoire"
  },
  Task_73362_Desc = {
    Text = "Utiliser « Spectacle de magie heureuse » pour remporter 3 victoires"
  },
  Task_73363_Desc = {
    Text = "Utiliser « Nymphaea » pour remporter une victoire"
  },
  Task_73366_Desc = {
    Text = "Utiliser « Retour dans le temps » pour obtenir 1 victoire"
  },
  Task_73369_Desc = {
    Text = "Utiliser « Délire » pour remporter 3 victoires"
  },
  Task_73370_Desc = {
    Text = "Utiliser « Hameln » pour obtenir 3 victoires"
  },
  Task_73372_Desc = {
    Text = "Utiliser « L'innocence en argent pur » pour remporter 3 victoires"
  },
  Task_73374_Desc = {
    Text = "Utiliser « Karen » pour obtenir 3 victoires"
  },
  Task_73377_Desc = {
    Text = "Utiliser « Échange inégal » pour remporter 1 victoire"
  },
  Task_73379_Desc = {
    Text = "Utiliser « Sorel » pour obtenir 1 victoire"
  },
  Task_73380_Desc = {
    Text = "Utiliser « Cassia » pour remporter 3 victoires"
  },
  Task_73382_Desc = {
    Text = "Utiliser « Briser la chaîne » pour remporter 1 victoire"
  },
  Task_73387_Desc = {
    Text = "Utiliser « Naissance secrète » pour obtenir 3 victoires"
  },
  Task_73388_Desc = {
    Text = "Utiliser « Barrière du cœur » pour remporter 3 victoires"
  },
  Task_73390_Desc = {
    Text = "Utiliser « Nageoire douloureuse » pour remporter 3 victoires"
  },
  Task_73392_Desc = {
    Text = "Utiliser « Uvhash » pour remporter 1 victoire"
  },
  Task_73394_Desc = {
    Text = "Utiliser « Pouvoir des pieux » pour remporter 3 victoires"
  },
  Task_73395_Desc = {
    Text = "Remporter une victoire en utilisant « Helot-catena »"
  },
  Task_73396_Desc = {
    Text = "Utiliser « Tablette divine » pour remporter 3 victoires"
  },
  Task_73400_Desc = {
    Text = "Utiliser « Requiem éternel » pour remporter 1 victoire"
  },
  Task_73404_Desc = {
    Text = "Utiliser « Homme dans le miroir » pour remporter 1 victoire"
  },
  Task_73405_Desc = {
    Text = "Utiliser « Sous la pluie battante » pour remporter 3 victoires"
  },
  Task_73407_Desc = {
    Text = "Utiliser « Cadeau de décadence » pour remporter 3 victoires"
  },
  Task_73409_Desc = {
    Text = "Utiliser « Céleste » pour obtenir 3 victoires"
  },
  Task_73410_Desc = {
    Text = "Utiliser « Perspicacité » pour remporter 3 victoires"
  },
  Task_73413_Desc = {
    Text = "Utiliser « La chanson enchaînée » pour remporter 1 victoire"
  },
  Task_73417_Desc = {
    Text = "Utiliser « Syndrome de souvenirs » pour remporter 3 victoires"
  },
  Task_73418_Desc = {
    Text = "Utiliser « Homme dans le miroir » pour remporter 3 victoires"
  },
  Task_73422_Desc = {
    Text = "Utiliser « 24 » pour remporter 3 victoires"
  },
  Task_73425_Desc = {
    Text = "Utiliser « Inébranlable » pour remporter 1 victoire"
  },
  Task_73426_Desc = {
    Text = "Utiliser « Alva » pour obtenir 3 victoires"
  },
  Task_73427_Desc = {
    Text = "Utiliser « Frénésie » pour obtenir 1 victoire"
  },
  Task_73430_Desc = {
    Text = "Utiliser « Activité » pour obtenir 3 victoires"
  },
  Task_73431_Desc = {
    Text = "Remporter 1 victoire en utilisant « Concert sans fin »"
  },
  Task_73432_Desc = {
    Text = "Utiliser « Devoirs » pour remporter une victoire"
  },
  Task_73433_Desc = {
    Text = "Utiliser « Mingwu » pour obtenir 3 victoires"
  },
  Task_73435_Desc = {
    Text = "Utiliser « Spirale de mémoire » pour remporter 3 victoires"
  },
  Task_73437_Desc = {
    Text = "Remporter 3 victoires en utilisant « Espoir »"
  },
  Task_73440_Desc = {
    Text = "Utiliser « Sommeil sous le glacier » pour remporter 1 victoire"
  },
  Task_73442_Desc = {
    Text = "Utiliser « Festin sanglant » pour remporter 3 victoires"
  },
  Task_73444_Desc = {
    Text = "Utiliser « Mer du désir » pour remporter 3 victoires"
  },
  Task_73445_Desc = {
    Text = "Utiliser « Leigh » pour remporter une victoire"
  },
  Task_73451_Desc = {
    Text = "Remporter 3 victoires en utilisant « Hilote »"
  },
  Task_73453_Desc = {
    Text = "Utiliser « Voile de gouvernail » pour remporter 3 victoires"
  },
  Task_73456_Desc = {
    Text = "Utiliser « Faros » pour remporter 1 victoire"
  },
  Task_73457_Desc = {
    Text = "Utiliser « Cœur de chevalier » pour remporter 3 victoires"
  },
  Task_73459_Desc = {
    Text = "Utiliser « Chant du roi divin » pour remporter 3 victoires"
  },
  Task_73462_Desc = {
    Text = "Utilisez « Suce » pour obtenir 1 victoire"
  },
  Task_73584_Desc = {
    Text = "Obtenez 10 victoires cette saiso"
  },
  Task_73584_Name = {
    Text = "10 Victoires"
  },
  Task_73585_Desc = {
    Text = "Obtenez 1 victoire cette saiso"
  },
  Task_73585_Name = {Text = "1 Victoire"},
  Task_73586_Desc = {
    Text = "Obtenez un total de 6 victoires cette saiso"
  },
  Task_73586_Name = {
    Text = "6 victoires"
  },
  Task_73587_Desc = {
    Text = "Obtenez un total de 3 victoires cette saiso"
  },
  Task_73587_Name = {
    Text = "3 Victoires"
  },
  Task_73588_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_73588_UnlockCondDesc = {
    Text = "Débloqué après avoir complété \"Tournant de Retour : Le Moment d'Inverser l'Omnivers,\" souhaites-tu passer à \"Tournant de Retour\" ?"
  },
  Task_73589_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_73589_UnlockCondDesc = {
    Text = "Débloqué après avoir complété \"Tournant de Retour : Le Moment d'Inverser l'Omnivers,\" souhaites-tu passer à \"Tournant de Retour\" ?"
  },
  Task_73590_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_73590_UnlockCondDesc = {
    Text = "Débloqué après avoir complété \"Tournant de Retour : Le Moment d'Inverser l'Omnivers,\" souhaites-tu passer à \"Tournant de Retour\" ?"
  },
  Task_73591_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_73591_UnlockCondDesc = {
    Text = "Débloqué après avoir complété \"Tournant de Retour : Le Moment d'Inverser l'Omnivers,\" souhaites-tu passer à \"Tournant de Retour\" ?"
  },
  Task_73592_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_73592_UnlockCondDesc = {
    Text = "Débloqué après avoir complété \"Tournant de Retour : Le Moment d'Inverser l'Omnivers,\" souhaites-tu passer à \"Tournant de Retour\" ?"
  },
  Task_73593_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_73593_UnlockCondDesc = {
    Text = "Débloqué après avoir complété \"Tournant de Retour : Le Moment d'Inverser l'Omnivers,\" souhaites-tu passer à \"Tournant de Retour\" ?"
  },
  Task_73594_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_73594_UnlockCondDesc = {
    Text = "Débloqué après avoir complété \"Tournant de Retour : Le Moment d'Inverser l'Omnivers,\" souhaites-tu passer à \"Tournant de Retour\" ?"
  },
  Task_73595_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_73595_UnlockCondDesc = {
    Text = "Débloqué après avoir complété \"Tournant de Retour : Le Moment d'Inverser l'Omnivers,\" souhaites-tu passer à \"Tournant de Retour\" ?"
  },
  Task_73596_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_73596_UnlockCondDesc = {
    Text = "Débloqué après avoir complété \"Tournant de Retour : Le Moment d'Inverser l'Omnivers,\" souhaites-tu passer à \"Tournant de Retour\" ?"
  },
  Task_73597_Desc = {
    Text = "Châtaigne magique atteinte"
  },
  Task_73597_UnlockCondDesc = {
    Text = "Débloqué après avoir complété \"Tournant de Retour : Le Moment d'Inverser l'Omnivers,\" souhaites-tu passer à \"Tournant de Retour\" ?"
  },
  Task_73672_Desc = {
    Text = "Obtenez la genèse poupée à illuminer 2"
  },
  Task_73672_Name = {
    Text = "Obtenez la genèse poupée en illuminant 2"
  },
  Task_73672_UnlockCondDesc = {
    Text = "Activité @réveilleur Genèse Dore paquet lumineux 1 activité"
  },
  Task_73673_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_73674_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_73676_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_73677_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_73679_Desc = {
    Text = "Obtenez la genèse Dore à illuminer 6"
  },
  Task_73679_Name = {
    Text = "Obtenez la genèse Dore à illuminer 6"
  },
  Task_73679_UnlockCondDesc = {
    Text = "Activité @réveilleur genèse Dore paquet lumineux 2 activité"
  },
  Task_73686_Desc = {
    Text = "Fusion - Poupée atteignant le niveau 10 d'affinité"
  },
  Task_73880_Desc = {
    Text = "Suivez Fondu·poupée pour confirmer la « réponse »"
  },
  Task_73880_Name = {Text = "Objectif"},
  Task_73881_Desc = {
    Text = "Maîtriser Sarah en état d'altération"
  },
  Task_73881_Name = {Text = "Objectif"},
  Task_73882_Desc = {
    Text = "Battre B-68, la poupée fondu"
  },
  Task_73882_Name = {Text = "Objectif"},
  Task_73883_Desc = {
    Text = "Exploration du monde dimensionnel devant vous"
  },
  Task_73883_Name = {Text = "Objectif"},
  Task_73884_Desc = {
    Text = "Calmer Jenkins"
  },
  Task_73884_Name = {Text = "Objectif"},
  Task_73885_Desc = {
    Text = "Entrave : Fondu·Poupée"
  },
  Task_73885_Name = {Text = "Objectif"},
  Task_73886_Desc = {
    Text = "Garde du clocher"
  },
  Task_73886_Name = {Text = "Objectif"},
  Task_73887_Desc = {
    Text = "Nettoyer les mutants dans le couloir de l'orphelinat"
  },
  Task_73887_Name = {Text = "Objectif"},
  Task_73888_Desc = {
    Text = "Sauver Salvador des mains de Juliette"
  },
  Task_73888_Name = {Text = "Objectif"},
  Task_73889_Desc = {
    Text = "Ouvrir la voie vers le Sanctuaire des bénédictions éternelles"
  },
  Task_73889_Name = {Text = "Objectif"},
  Task_74202_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_74203_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_74204_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_74205_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_74206_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_74207_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_74208_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_74210_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_74211_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_74212_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_74222_Desc = {
    Text = "Terminez le vagabond « Jour du couronnement »"
  },
  Task_74222_Name = {
    Text = "Puissance royale éternelle"
  },
  Task_74223_Desc = {
    Text = "Compléter l'événement d'enquête « Retour à la ville brumeuse » en difficulté difficile"
  },
  Task_74223_Name = {
    Text = "Ne te perds pas dans la nuit grise · Difficile"
  },
  Task_74224_Desc = {
    Text = "Résonner 10 fois dans l'enquête sur l'événement «@1@2»"
  },
  Task_74224_Desc2 = {
    Text = "Résonner 10 fois dans l'enquête sur l'événement « Retour à la ville brumeuse »"
  },
  Task_74224_Name = {Text = "@2@3"},
  Task_74224_Name2 = {
    Text = "Écho du vide IV"
  },
  Task_74225_Desc = {
    Text = "Compléter l'événement d'investigation \"@1@2\""
  },
  Task_74225_Desc2 = {
    Text = "Complétez l'événement d'investigation \"Retour à la Ville Brumeuse\""
  },
  Task_74225_Name = {Text = "@2@3"},
  Task_74225_Name2 = {
    Text = "Ne te perds pas dans la nuit grise"
  },
  Task_74226_Desc = {
    Text = "Résonner 3 fois dans l'enquête sur l'événement «@1@2»"
  },
  Task_74226_Desc2 = {
    Text = "Résonner 3 fois dans l'enquête sur l'événement « Retour à la ville brumeuse »"
  },
  Task_74226_Name = {Text = "@2@3"},
  Task_74226_Name2 = {
    Text = "Écho du vide"
  },
  Task_74227_Desc = {
    Text = "Résonner 6 fois dans l'enquête sur l'événement «@1@2»"
  },
  Task_74227_Desc2 = {
    Text = "Résonner 6 fois dans l'enquête de l'événement « Retour à la ville brumeuse »"
  },
  Task_74227_Name = {Text = "@2@3"},
  Task_74227_Name2 = {
    Text = "Écho du vide II"
  },
  Task_74228_Desc = {
    Text = "Résonnez 8 fois dans l'événement d'investigation \"@1@2\""
  },
  Task_74228_Desc2 = {
    Text = "Résonner 8 fois dans l'enquête de l'événement « Retour à la ville brumeuse »"
  },
  Task_74228_Name = {Text = "@2@3"},
  Task_74228_Name2 = {
    Text = "Écho du néant III"
  },
  Task_74235_Desc = {
    Text = "Trouver Liz"
  },
  Task_74235_Name = {Text = "Objectif"},
  Task_74295_Desc = {
    Text = "Terminez Le vagabond « La passion retournée en poussière »"
  },
  Task_74295_Name = {
    Text = "Danse tourbillonnante de la flamme bleue"
  },
  Task_74296_Desc = {
    Text = "Terminez le vagabond « La passion retournée en poussière » en mode difficile"
  },
  Task_74296_Name = {
    Text = "Danse tourbillonnante de la flamme bleue · Difficile"
  },
  Task_74332_Name = {
    Text = "Fin de l'activité d'inversion du tour"
  },
  Task_74333_Desc = {
    Text = "Prologue de l'inversion du tour - Chapitre 2"
  },
  Task_74333_UnlockCondDesc = {
    Text = "Débloqué après avoir reçu « Tour impair : score atteint 1200 »"
  },
  Task_74334_Desc = {
    Text = "Prologue de l'inversion du tour terminé"
  },
  Task_74335_Desc = {
    Text = "Prologue de l'Inversion du tour - Chapitre 3"
  },
  Task_74335_UnlockCondDesc = {
    Text = "Débloqué après avoir reçu « Tour impair : score atteint 2400 »"
  },
  Task_74342_Desc = {
    Text = "Jouer 25 cartes avec un personnage de type Gardien"
  },
  Task_74343_Desc = {
    Text = "Jouez 25 cartes avec un personnage de type Maléfique"
  },
  Task_74344_Desc = {
    Text = "Jouer 25 cartes avec un personnage de type Bénédiction"
  },
  Task_74345_Desc = {
    Text = "Jouer 25 cartes avec un personnage de type Esprit"
  },
  Task_74346_Desc = {
    Text = "Jouez 25 cartes avec un personnage de type Combattant"
  },
  Task_74375_Desc = {
    Text = "Jouez 1750 cartes avec un personnage de type Combattant"
  },
  Task_74376_Desc = {
    Text = "Jouer 400 cartes avec un personnage de type Bénédiction"
  },
  Task_74377_Desc = {
    Text = "Jouer 1225 cartes avec un personnage de type Esprit"
  },
  Task_74378_Desc = {
    Text = "Jouer 1125 cartes avec un personnage de type Maléfice"
  },
  Task_74379_Desc = {
    Text = "Jouer 775 cartes avec un personnage de type Maléfique"
  },
  Task_74380_Desc = {
    Text = "Jouer 1775 cartes avec un personnage de type Bénédiction"
  },
  Task_74381_Desc = {
    Text = "Jouez 775 cartes avec un personnage de type Combattant"
  },
  Task_74382_Desc = {
    Text = "Jouer 700 cartes avec un personnage de type Esprit"
  },
  Task_74383_Desc = {
    Text = "Jouer 1875 cartes avec un personnage de type Gardien"
  },
  Task_74384_Desc = {
    Text = "Jouer 825 cartes avec un personnage de type Bénédiction"
  },
  Task_74385_Desc = {
    Text = "Jouez 1800 cartes avec un personnage de type Combattant"
  },
  Task_74386_Desc = {
    Text = "Jouez 1200 cartes avec un personnage de type Combattant"
  },
  Task_74387_Desc = {
    Text = "Jouer 775 cartes avec un personnage de type Bénédiction"
  },
  Task_74388_Desc = {
    Text = "Jouer 525 cartes avec un personnage de type Esprit"
  },
  Task_74389_Desc = {
    Text = "Jouer 1600 cartes avec un personnage de type Esprit"
  },
  Task_74390_Desc = {
    Text = "Jouer 675 cartes avec un personnage de type Bénédiction"
  },
  Task_74391_Desc = {
    Text = "Jouez 1975 cartes avec un personnage de type Combattant"
  },
  Task_74392_Desc = {
    Text = "Jouer 1525 cartes avec un personnage Gardien"
  },
  Task_74393_Desc = {
    Text = "Jouer 1325 cartes avec un personnage de type Maléfique"
  },
  Task_74394_Desc = {
    Text = "Jouer 1550 cartes avec un personnage de type Maléfice"
  },
  Task_74395_Desc = {
    Text = "Jouer 1125 cartes avec un personnage de type Bénédiction"
  },
  Task_74396_Desc = {
    Text = "Jouer 125 cartes avec un personnage de type Maléfice"
  },
  Task_74397_Desc = {
    Text = "Jouer 1600 cartes avec un personnage de type Maléfice"
  },
  Task_74398_Desc = {
    Text = "Jouer 650 cartes avec un personnage de type Bénédiction"
  },
  Task_74399_Desc = {
    Text = "Jouer 325 cartes avec un personnage de type Maléfice"
  },
  Task_74400_Desc = {
    Text = "Jouer 1325 cartes avec un personnage de type Bénédiction"
  },
  Task_74401_Desc = {
    Text = "Jouer 150 cartes avec un personnage de type Bénédiction"
  },
  Task_74402_Desc = {
    Text = "Jouer 50 cartes avec un personnage de type Maléfice"
  },
  Task_74403_Desc = {
    Text = "Jouer 2000 cartes avec un personnage de type Bénédiction"
  },
  Task_74404_Desc = {
    Text = "Jouez 850 cartes avec un personnage de type Combattant"
  },
  Task_74405_Desc = {
    Text = "Jouer 1150 cartes avec un personnage de type Bénédiction"
  },
  Task_74406_Desc = {
    Text = "Jouer 150 cartes avec un personnage de type Maléfice"
  },
  Task_74407_Desc = {
    Text = "Jouer 550 cartes avec un personnage de type Gardien"
  },
  Task_74408_Desc = {
    Text = "Jouer 800 cartes avec un personnage de type Maléfice"
  },
  Task_74409_Desc = {
    Text = "Jouez 100 cartes avec un personnage de type Combattant"
  },
  Task_74410_Desc = {
    Text = "Jouer 1600 cartes avec un personnage de type Gardien"
  },
  Task_74411_Desc = {
    Text = "Jouer 1300 cartes avec un personnage de type Esprit"
  },
  Task_74412_Desc = {
    Text = "Jouer 1850 cartes avec un personnage de type Bénédiction"
  },
  Task_74413_Desc = {
    Text = "Jouer 1525 cartes avec un personnage de type Esprit"
  },
  Task_74414_Desc = {
    Text = "Jouer 1425 cartes avec un personnage de type Gardien"
  },
  Task_74415_Desc = {
    Text = "Jouer 1275 cartes avec un personnage de type Gardien"
  },
  Task_74416_Desc = {
    Text = "Jouer 925 cartes avec un personnage de type Esprit"
  },
  Task_74417_Desc = {
    Text = "Jouer 800 cartes avec un personnage de type Gardien"
  },
  Task_74418_Desc = {
    Text = "Jouer 1625 cartes avec un personnage de type Esprit"
  },
  Task_74419_Desc = {
    Text = "Jouer 1775 cartes avec un personnage de type Esprit"
  },
  Task_74420_Desc = {
    Text = "Jouer 1100 cartes avec un personnage de type Bénédiction"
  },
  Task_74421_Desc = {
    Text = "Jouer 100 cartes avec un personnage de type Maléfique"
  },
  Task_74422_Desc = {
    Text = "Jouer 1750 cartes avec un personnage de type Esprit"
  },
  Task_74423_Desc = {
    Text = "Jouer 1125 cartes avec un personnage de type Esprit"
  },
  Task_74424_Desc = {
    Text = "Jouer 750 cartes avec un personnage de type Esprit"
  },
  Task_74425_Desc = {
    Text = "Jouer 1725 cartes avec un personnage de type Maléfique"
  },
  Task_74426_Desc = {
    Text = "Jouez 1150 cartes avec un personnage de type Combattant"
  },
  Task_74427_Desc = {
    Text = "Jouer 175 cartes avec un personnage de type Esprit"
  },
  Task_74428_Desc = {
    Text = "Jouer 1625 cartes avec un personnage de type Maléfique"
  },
  Task_74429_Desc = {
    Text = "Jouer 425 cartes avec un personnage de type Bénédiction"
  },
  Task_74430_Desc = {
    Text = "Jouer 1700 cartes avec un personnage de type Esprit"
  },
  Task_74431_Desc = {
    Text = "Jouez 1325 cartes avec un personnage de type Combattant"
  },
  Task_74432_Desc = {
    Text = "Jouer 1225 cartes avec un personnage de type Bénédiction"
  },
  Task_74433_Desc = {
    Text = "Jouer 225 cartes avec un personnage de type Maléfique"
  },
  Task_74434_Desc = {
    Text = "Jouez 1875 cartes avec un personnage de type Combattant"
  },
  Task_74435_Desc = {
    Text = "Jouer 725 cartes avec un personnage de type Esprit"
  },
  Task_74436_Desc = {
    Text = "Jouer 325 cartes avec un personnage de type Esprit"
  },
  Task_74437_Desc = {
    Text = "Jouer 1350 cartes avec un personnage de type Esprit"
  },
  Task_74438_Desc = {
    Text = "Jouer 1725 cartes avec un personnage de type Gardien"
  },
  Task_74439_Desc = {
    Text = "Jouez 1375 cartes avec un personnage de type Combattant"
  },
  Task_74440_Desc = {
    Text = "Jouer 925 cartes avec un personnage de type Gardien"
  },
  Task_74441_Desc = {
    Text = "Jouer 1950 cartes avec un personnage de type Maléfice"
  },
  Task_74442_Desc = {
    Text = "Jouez 450 cartes avec un personnage de type Combattant"
  },
  Task_74443_Desc = {
    Text = "Jouer 175 cartes avec un personnage de type Gardien"
  },
  Task_74444_Desc = {
    Text = "Jouer 1100 cartes avec un personnage de type Gardien"
  },
  Task_74445_Desc = {
    Text = "Jouer 450 cartes avec un personnage de type Gardien"
  },
  Task_74446_Desc = {
    Text = "Jouez 1225 cartes avec un personnage de type Combattant"
  },
  Task_74447_Desc = {
    Text = "Jouer 1475 cartes avec un personnage de type Esprit"
  },
  Task_74448_Desc = {
    Text = "Jouer 1250 cartes avec un personnage Gardien"
  },
  Task_74449_Desc = {
    Text = "Jouer 100 cartes avec un personnage de type Esprit"
  },
  Task_74450_Desc = {
    Text = "Jouez 975 cartes avec un personnage de type Combattant"
  },
  Task_74451_Desc = {
    Text = "Jouer 800 cartes avec un personnage de type Bénédiction"
  },
  Task_74452_Desc = {
    Text = "Jouer 1875 cartes avec un personnage de type Maléfice"
  },
  Task_74453_Desc = {
    Text = "Jouez 900 cartes avec un personnage de type Combattant"
  },
  Task_74454_Desc = {
    Text = "Jouer 1950 cartes avec un personnage Gardien"
  },
  Task_74455_Desc = {
    Text = "Jouer 1000 cartes avec un personnage de type Gardien"
  },
  Task_74456_Desc = {
    Text = "Jouez 1925 cartes avec un personnage de type Combattant"
  },
  Task_74457_Desc = {
    Text = "Jouer 1825 cartes avec un personnage de type Esprit"
  },
  Task_74458_Desc = {
    Text = "Jouez 1725 cartes avec un personnage de type Combattant"
  },
  Task_74459_Desc = {
    Text = "Jouer 1500 cartes avec un personnage de type Maléfice"
  },
  Task_74460_Desc = {
    Text = "Jouer 1375 cartes avec un personnage de type Maléfique"
  },
  Task_74461_Desc = {
    Text = "Jouer 350 cartes avec un personnage de type Gardien"
  },
  Task_74462_Desc = {
    Text = "Jouer 1975 cartes avec un personnage de type Maléfice"
  },
  Task_74463_Desc = {
    Text = "Jouer 625 cartes avec un personnage de type Gardien"
  },
  Task_74464_Desc = {
    Text = "Jouer 500 cartes avec un personnage de type Gardien"
  },
  Task_74465_Desc = {
    Text = "Jouer 1200 cartes avec un personnage de type Esprit"
  },
  Task_74466_Desc = {
    Text = "Jouer 775 cartes avec un personnage de type Esprit"
  },
  Task_74467_Desc = {
    Text = "Jouer 975 cartes avec un personnage de type Esprit"
  },
  Task_74468_Desc = {
    Text = "Jouer 1550 cartes avec un personnage de type Esprit"
  },
  Task_74469_Desc = {
    Text = "Jouer 2000 cartes avec un personnage de type Esprit"
  },
  Task_74470_Desc = {
    Text = "Jouer 1050 cartes avec un personnage de type Maléfice"
  },
  Task_74471_Desc = {
    Text = "Jouer 1700 cartes avec un personnage de type Gardien"
  },
  Task_74472_Desc = {
    Text = "Jouez 1500 cartes avec un personnage de type Combattant"
  },
  Task_74473_Desc = {
    Text = "Jouer 75 cartes avec un personnage de type Bénédiction"
  },
  Task_74474_Desc = {
    Text = "Jouer 550 cartes avec un personnage de type Bénédiction"
  },
  Task_74475_Desc = {
    Text = "Jouer 150 cartes avec un personnage de type Esprit"
  },
  Task_74476_Desc = {
    Text = "Jouez 1575 cartes avec un personnage de type Combattant"
  },
  Task_74477_Desc = {
    Text = "Jouer 425 cartes avec un personnage de type Esprit"
  },
  Task_74478_Desc = {
    Text = "Jouer 950 cartes avec un personnage de type Gardien"
  },
  Task_74479_Desc = {
    Text = "Jouer 700 cartes avec un personnage de type Gardien"
  },
  Task_74480_Desc = {
    Text = "Jouez 1175 cartes avec un personnage de type Combattant"
  },
  Task_74481_Desc = {
    Text = "Jouez 700 cartes avec un personnage de type Combattant"
  },
  Task_74482_Desc = {
    Text = "Jouer 1275 cartes avec un personnage de type Bénédiction"
  },
  Task_74483_Desc = {
    Text = "Jouer 625 cartes avec un personnage de type Esprit"
  },
  Task_74484_Desc = {
    Text = "Jouez 275 cartes avec un personnage de type Maléfique"
  },
  Task_74485_Desc = {
    Text = "Jouer 1575 cartes avec un personnage Gardien"
  },
  Task_74486_Desc = {
    Text = "Jouer 1400 cartes avec un personnage de type Gardien"
  },
  Task_74487_Desc = {
    Text = "Jouez 1675 cartes avec un personnage de type Combattant"
  },
  Task_74488_Desc = {
    Text = "Jouer 1075 cartes avec un personnage de type Esprit"
  },
  Task_74489_Desc = {
    Text = "Jouer 325 cartes avec un personnage de type Gardien"
  },
  Task_74490_Desc = {
    Text = "Jouer 1025 cartes avec un personnage de type Bénédiction"
  },
  Task_74491_Desc = {
    Text = "Jouer 1025 cartes avec un personnage de type Esprit"
  },
  Task_74492_Desc = {
    Text = "Jouer 1050 cartes avec un personnage de type Esprit"
  },
  Task_74493_Desc = {
    Text = "Jouer 600 cartes avec un personnage de type Gardien"
  },
  Task_74494_Desc = {
    Text = "Jouer 1900 cartes avec un personnage de type Esprit"
  },
  Task_74495_Desc = {
    Text = "Jouer 125 cartes avec un personnage de type Gardien"
  },
  Task_74496_Desc = {
    Text = "Jouer 200 cartes avec un personnage de type Esprit"
  },
  Task_74497_Desc = {
    Text = "Jouer 1575 cartes avec un personnage de type Bénédiction"
  },
  Task_74498_Desc = {
    Text = "Jouer 575 cartes avec un personnage de type Maléfique"
  },
  Task_74499_Desc = {
    Text = "Jouez 800 cartes avec un personnage de type Combattant"
  },
  Task_74500_Desc = {
    Text = "Jouer 1275 cartes avec un personnage de type Esprit"
  },
  Task_74501_Desc = {
    Text = "Jouer 1625 cartes avec un personnage de type Gardien"
  },
  Task_74502_Desc = {
    Text = "Jouer 1900 cartes avec un personnage de type Bénédiction"
  },
  Task_74503_Desc = {
    Text = "Jouez 1100 cartes avec un personnage de type Combattant"
  },
  Task_74504_Desc = {
    Text = "Jouez 150 cartes avec un personnage de type Combattant"
  },
  Task_74505_Desc = {
    Text = "Jouer 50 cartes avec un personnage de type Bénédiction"
  },
  Task_74506_Desc = {
    Text = "Jouez 1025 cartes avec un personnage de type Combattant"
  },
  Task_74507_Desc = {
    Text = "Jouez 1900 cartes avec un personnage de type Combattant"
  },
  Task_74508_Desc = {
    Text = "Jouez 675 cartes avec un personnage de type Combattant"
  },
  Task_74509_Desc = {
    Text = "Jouer 1925 cartes avec un personnage de type Gardien"
  },
  Task_74510_Desc = {
    Text = "Jouer 1850 cartes avec un personnage de type Esprit"
  },
  Task_74511_Desc = {
    Text = "Jouer 1250 cartes avec un personnage de type Maléfice"
  },
  Task_74512_Desc = {
    Text = "Jouez 1950 cartes avec un personnage de type Combattant"
  },
  Task_74513_Desc = {
    Text = "Jouez 550 cartes avec un personnage de type Combattant"
  },
  Task_74514_Desc = {
    Text = "Jouez 250 cartes avec un personnage de type Combattant"
  },
  Task_74515_Desc = {
    Text = "Jouer 1525 cartes avec un personnage de type Maléfique"
  },
  Task_74516_Desc = {
    Text = "Jouer 75 cartes avec un personnage de type Gardien"
  },
  Task_74517_Desc = {
    Text = "Jouer 1150 cartes avec un personnage de type Esprit"
  },
  Task_74518_Desc = {
    Text = "Jouer 825 cartes avec un personnage de type Maléfice"
  },
  Task_74519_Desc = {
    Text = "Jouer 50 cartes avec un personnage de type Gardien"
  },
  Task_74520_Desc = {
    Text = "Jouer 1200 cartes avec un personnage de type Maléfice"
  },
  Task_74521_Desc = {
    Text = "Jouez 1600 cartes avec un personnage de type Combattant"
  },
  Task_74522_Desc = {
    Text = "Jouez 1125 cartes avec un personnage du type Combattant"
  },
  Task_74523_Desc = {
    Text = "Jouer 1425 cartes avec un personnage de type Maléfique"
  },
  Task_74524_Desc = {
    Text = "Jouez 225 cartes avec un personnage de type Combattant"
  },
  Task_74525_Desc = {
    Text = "Jouer 375 cartes avec un personnage de type Esprit"
  },
  Task_74526_Desc = {
    Text = "Jouer 1475 cartes avec un personnage de type Gardien"
  },
  Task_74527_Desc = {
    Text = "Jouer 100 cartes avec un personnage de type Gardien"
  },
  Task_74528_Desc = {
    Text = "Jouez 375 cartes avec un personnage de type Combattant"
  },
  Task_74529_Desc = {
    Text = "Jouer 1850 cartes avec un personnage Gardien"
  },
  Task_74530_Desc = {
    Text = "Jouez 350 cartes avec un personnage de type Combattant"
  },
  Task_74531_Desc = {
    Text = "Jouer 1675 cartes avec un personnage de type Bénédiction"
  },
  Task_74532_Desc = {
    Text = "Jouer 675 cartes avec un personnage de type Maléfique"
  },
  Task_74533_Desc = {
    Text = "Jouer 1650 cartes avec un personnage de type Esprit"
  },
  Task_74534_Desc = {
    Text = "Jouer 75 cartes avec un personnage de type Esprit"
  },
  Task_74535_Desc = {
    Text = "Jouez 50 cartes avec un personnage de type Combattant"
  },
  Task_74536_Desc = {
    Text = "Jouez 875 cartes avec un personnage de type Combattant"
  },
  Task_74537_Desc = {
    Text = "Jouer 1650 cartes avec un personnage de type Gardien"
  },
  Task_74538_Desc = {
    Text = "Jouer 250 cartes avec un personnage de type Bénédiction"
  },
  Task_74539_Desc = {
    Text = "Jouer 100 cartes avec un personnage de type Bénédiction"
  },
  Task_74540_Desc = {
    Text = "Jouer 1075 cartes avec un personnage de type Bénédiction"
  },
  Task_74541_Desc = {
    Text = "Jouer 1750 cartes avec un personnage de type Maléfice"
  },
  Task_74542_Desc = {
    Text = "Jouez 750 cartes avec un personnage de type Combattant"
  },
  Task_74543_Desc = {
    Text = "Jouer 550 cartes avec un personnage de type Esprit"
  },
  Task_74544_Desc = {
    Text = "Jouez 1450 cartes avec un personnage de type Combattant"
  },
  Task_74545_Desc = {
    Text = "Jouez 725 cartes avec un personnage de type Combattant"
  },
  Task_74546_Desc = {
    Text = "Jouer 600 cartes avec un personnage de type Esprit"
  },
  Task_74547_Desc = {
    Text = "Jouer 700 cartes avec un personnage de type Bénédiction"
  },
  Task_74548_Desc = {
    Text = "Jouer 1550 cartes avec un personnage Gardien"
  },
  Task_74549_Desc = {
    Text = "Jouer 850 cartes avec un personnage de type Bénédiction"
  },
  Task_74550_Desc = {
    Text = "Jouer 1450 cartes avec un personnage de type Maléfice"
  },
  Task_74551_Desc = {
    Text = "Jouez 1625 cartes avec un personnage de type Combattant"
  },
  Task_74552_Desc = {
    Text = "Jouez 200 cartes avec un personnage de type Combattant"
  },
  Task_74553_Desc = {
    Text = "Jouer 1525 cartes avec un personnage de type Bénédiction"
  },
  Task_74554_Desc = {
    Text = "Jouer 525 cartes avec un personnage de type Maléfice"
  },
  Task_74555_Desc = {
    Text = "Jouer 325 cartes avec un personnage de type Bénédiction"
  },
  Task_74556_Desc = {
    Text = "Jouez 1525 cartes avec un personnage de type Combattant"
  },
  Task_74557_Desc = {
    Text = "Jouer 375 cartes avec un personnage de type Maléfice"
  },
  Task_74558_Desc = {
    Text = "Jouer 1375 cartes avec un personnage de type Bénédiction"
  },
  Task_74559_Desc = {
    Text = "Jouer 300 cartes avec un personnage de type Bénédiction"
  },
  Task_74560_Desc = {
    Text = "Jouer 225 cartes avec un personnage de type Bénédiction"
  },
  Task_74561_Desc = {
    Text = "Jouez 1850 cartes avec un personnage de type Combattant"
  },
  Task_74562_Desc = {
    Text = "Jouer 475 cartes avec un personnage de type Gardien"
  },
  Task_74563_Desc = {
    Text = "Jouer 600 cartes avec un personnage de type Bénédiction"
  },
  Task_74564_Desc = {
    Text = "Jouer 1375 cartes avec un personnage de type Gardien"
  },
  Task_74565_Desc = {
    Text = "Jouer 1450 cartes avec un personnage de type Gardien"
  },
  Task_74566_Desc = {
    Text = "Jouer 300 cartes avec un personnage de type Gardien"
  },
  Task_74567_Desc = {
    Text = "Jouer 950 cartes avec un personnage de type Esprit"
  },
  Task_74568_Desc = {
    Text = "Jouer 1200 cartes avec un personnage de type Gardien"
  },
  Task_74569_Desc = {
    Text = "Jouer 1025 cartes avec un personnage de type Maléfique"
  },
  Task_74570_Desc = {
    Text = "Jouer 950 cartes avec un personnage de type Bénédiction"
  },
  Task_74571_Desc = {
    Text = "Jouez 1350 cartes avec un personnage de type Combattant"
  },
  Task_74572_Desc = {
    Text = "Jouer 525 cartes avec un personnage de type Gardien"
  },
  Task_74573_Desc = {
    Text = "Jouez 125 cartes avec un personnage de type Combattant"
  },
  Task_74574_Desc = {
    Text = "Jouer 475 cartes avec un personnage de type Bénédiction"
  },
  Task_74575_Desc = {
    Text = "Jouer 350 cartes avec un personnage de type Esprit"
  },
  Task_74576_Desc = {
    Text = "Jouer 1175 cartes avec un personnage de type Esprit"
  },
  Task_74577_Desc = {
    Text = "Jouer 1250 cartes avec un personnage de type Esprit"
  },
  Task_74578_Desc = {
    Text = "Jouer 775 cartes avec un personnage de type Gardien"
  },
  Task_74579_Desc = {
    Text = "Jouer 400 cartes avec un personnage de type Gardien"
  },
  Task_74580_Desc = {
    Text = "Jouez 825 cartes avec un personnage de type Combattant"
  },
  Task_74581_Desc = {
    Text = "Jouer 650 cartes avec un personnage de type Esprit"
  },
  Task_74582_Desc = {
    Text = "Jouer 1575 cartes avec un personnage de type Maléfice"
  },
  Task_74583_Desc = {
    Text = "Jouer 350 cartes avec un personnage de type Bénédiction"
  },
  Task_74584_Desc = {
    Text = "Jouez 1400 cartes avec un personnage de type Combattant"
  },
  Task_74585_Desc = {
    Text = "Jouer 275 cartes avec un personnage de type Gardien"
  },
  Task_74586_Desc = {
    Text = "Jouer 1500 cartes avec un personnage de type Bénédiction"
  },
  Task_74587_Desc = {
    Text = "Jouer 500 cartes avec un personnage de type Maléfique"
  },
  Task_74588_Desc = {
    Text = "Jouez 1075 cartes avec un personnage de type Combattant"
  },
  Task_74589_Desc = {
    Text = "Jouer 625 cartes avec un personnage de type Bénédiction"
  },
  Task_74590_Desc = {
    Text = "Jouez 575 cartes avec un personnage de type Combattant"
  },
  Task_74591_Desc = {
    Text = "Jouer 850 cartes avec un personnage de type Maléfice"
  },
  Task_74592_Desc = {
    Text = "Jouer 650 cartes avec un personnage de type Gardien"
  },
  Task_74593_Desc = {
    Text = "Jouer 575 cartes avec un personnage de type Bénédiction"
  },
  Task_74594_Desc = {
    Text = "Jouer 375 cartes avec un personnage de type Bénédiction"
  },
  Task_74595_Desc = {
    Text = "Jouer 225 cartes avec un personnage de type Gardien"
  },
  Task_74596_Desc = {
    Text = "Jouer 1875 cartes avec un personnage de type Esprit"
  },
  Task_74597_Desc = {
    Text = "Jouer 1075 cartes avec un personnage de type Gardien"
  },
  Task_74598_Desc = {
    Text = "Jouez 1825 cartes avec un personnage de type Combattant"
  },
  Task_74599_Desc = {
    Text = "Jouer 1700 cartes avec un personnage de type Maléfice"
  },
  Task_74600_Desc = {
    Text = "Jouer 150 cartes avec un personnage de type Gardien"
  },
  Task_74601_Desc = {
    Text = "Jouer 1750 cartes avec un personnage de type Gardien"
  },
  Task_74602_Desc = {
    Text = "Jouer 1975 cartes avec un personnage Gardien"
  },
  Task_74603_Desc = {
    Text = "Jouer 750 cartes avec un personnage de type Maléfique"
  },
  Task_74604_Desc = {
    Text = "Jouer 1750 cartes avec un personnage de type Bénédiction"
  },
  Task_74605_Desc = {
    Text = "Jouer 1150 cartes avec un personnage de type Maléfice"
  },
  Task_74606_Desc = {
    Text = "Jouer 1475 cartes avec un personnage de type Maléfice"
  },
  Task_74607_Desc = {
    Text = "Jouer 875 cartes avec un personnage de type Gardien"
  },
  Task_74608_Desc = {
    Text = "Jouer 725 cartes avec un personnage de type Maléfique"
  },
  Task_74609_Desc = {
    Text = "Jouer 1725 cartes avec un personnage de type Bénédiction"
  },
  Task_74610_Desc = {
    Text = "Jouer 1800 cartes avec un personnage de type Maléfice"
  },
  Task_74611_Desc = {
    Text = "Jouer 1050 cartes avec un personnage de type Bénédiction"
  },
  Task_74612_Desc = {
    Text = "Jouer 1925 cartes avec un personnage de type Bénédiction"
  },
  Task_74613_Desc = {
    Text = "Jouer 925 cartes avec un personnage de type Maléfice"
  },
  Task_74614_Desc = {
    Text = "Jouer 250 cartes avec un personnage de type Esprit"
  },
  Task_74615_Desc = {
    Text = "Jouer 900 cartes avec un personnage de type Esprit"
  },
  Task_74616_Desc = {
    Text = "Jouer 350 cartes avec un personnage de type Maléfice"
  },
  Task_74617_Desc = {
    Text = "Jouer 1350 cartes avec un personnage de type Bénédiction"
  },
  Task_74618_Desc = {
    Text = "Jouer 125 cartes avec un personnage de type Bénédiction"
  },
  Task_74619_Desc = {
    Text = "Jouer 1775 cartes avec un personnage de type Maléfice"
  },
  Task_74620_Desc = {
    Text = "Jouer 1925 cartes avec un personnage de type Maléfique"
  },
  Task_74621_Desc = {
    Text = "Jouer 1900 cartes avec un personnage de type Maléfice"
  },
  Task_74622_Desc = {
    Text = "Jouer 875 cartes avec un personnage de type Esprit"
  },
  Task_74623_Desc = {
    Text = "Jouer 250 cartes avec un personnage de type Gardien"
  },
  Task_74624_Desc = {
    Text = "Jouer 900 cartes avec un personnage de type Gardien"
  },
  Task_74625_Desc = {
    Text = "Jouer 675 cartes avec un personnage de type Gardien"
  },
  Task_74626_Desc = {
    Text = "Jouer 1350 cartes avec un personnage de type Gardien"
  },
  Task_74627_Desc = {
    Text = "Jouer 1450 cartes avec un personnage de type Esprit"
  },
  Task_74628_Desc = {
    Text = "Jouer 875 cartes avec un personnage de type Bénédiction"
  },
  Task_74629_Desc = {
    Text = "Jouez 1550 cartes avec un personnage du type Combattant"
  },
  Task_74630_Desc = {
    Text = "Jouer 1000 cartes avec un personnage de type Esprit"
  },
  Task_74631_Desc = {
    Text = "Jouer 2000 cartes avec un personnage de type Maléfice"
  },
  Task_74632_Desc = {
    Text = "Jouer 675 cartes avec un personnage de type Esprit"
  },
  Task_74633_Desc = {
    Text = "Jouer 1025 cartes avec un personnage de type Gardien"
  },
  Task_74634_Desc = {
    Text = "Jouer 1300 cartes avec un personnage de type Maléfique"
  },
  Task_74635_Desc = {
    Text = "Jouer 1800 cartes avec un personnage de type Esprit"
  },
  Task_74636_Desc = {
    Text = "Jouer 1825 cartes avec un personnage Gardien"
  },
  Task_74637_Desc = {
    Text = "Jouez 1700 cartes avec un personnage de type Combattant"
  },
  Task_74638_Desc = {
    Text = "Jouez 1000 cartes avec un personnage de type Combattant"
  },
  Task_74639_Desc = {
    Text = "Jouer 275 cartes avec un personnage de type Bénédiction"
  },
  Task_74640_Desc = {
    Text = "Jouer 1100 cartes avec un personnage de type Esprit"
  },
  Task_74641_Desc = {
    Text = "Jouer 1800 cartes avec un personnage de type Bénédiction"
  },
  Task_74642_Desc = {
    Text = "Jouez 1475 cartes avec un personnage de type Combattant"
  },
  Task_74643_Desc = {
    Text = "Jouer 1225 cartes avec un personnage de type Maléfice"
  },
  Task_74644_Desc = {
    Text = "Jouer 975 cartes avec un personnage de type Bénédiction"
  },
  Task_74645_Desc = {
    Text = "Jouez 400 cartes avec un personnage de type Combattant"
  },
  Task_74646_Desc = {
    Text = "Jouer 800 cartes avec un personnage de type Esprit"
  },
  Task_74647_Desc = {
    Text = "Jouer 1925 cartes avec un personnage de type Esprit"
  },
  Task_74648_Desc = {
    Text = "Jouer 1375 cartes avec un personnage de type Esprit"
  },
  Task_74649_Desc = {
    Text = "Jouer 400 cartes avec un personnage de type Esprit"
  },
  Task_74650_Desc = {
    Text = "Jouer 1000 cartes avec un personnage de type Bénédiction"
  },
  Task_74651_Desc = {
    Text = "Jouer 700 cartes avec un personnage de type Maléfique"
  },
  Task_74652_Desc = {
    Text = "Jouer 1700 cartes avec un personnage de type Bénédiction"
  },
  Task_74653_Desc = {
    Text = "Jouer 1075 cartes avec un personnage de type Maléfique"
  },
  Task_74654_Desc = {
    Text = "Jouez 1050 cartes avec un personnage de type Combattant"
  },
  Task_74655_Desc = {
    Text = "Jouez 175 cartes avec un personnage de type Combattant"
  },
  Task_74656_Desc = {
    Text = "Jouer 300 cartes avec un personnage de type Esprit"
  },
  Task_74657_Desc = {
    Text = "Jouer 1000 cartes avec un personnage de type Maléfice"
  },
  Task_74658_Desc = {
    Text = "Jouer 825 cartes avec un personnage de type Esprit"
  },
  Task_74659_Desc = {
    Text = "Jouez 600 cartes avec un personnage de type Combattant"
  },
  Task_74660_Desc = {
    Text = "Jouer 725 cartes avec un personnage de type Gardien"
  },
  Task_74661_Desc = {
    Text = "Jouer 750 cartes avec un personnage de type Gardien"
  },
  Task_74662_Desc = {
    Text = "Jouer 1675 cartes avec un personnage de type Maléfice"
  },
  Task_74663_Desc = {
    Text = "Jouer 1500 cartes avec un personnage de type Esprit"
  },
  Task_74664_Desc = {
    Text = "Jouer 375 cartes avec un personnage de type Gardien"
  },
  Task_74665_Desc = {
    Text = "Jouer 1150 cartes avec un personnage de type Gardien"
  },
  Task_74666_Desc = {
    Text = "Jouer 275 cartes avec un personnage de type Esprit"
  },
  Task_74667_Desc = {
    Text = "Jouer 900 cartes avec un personnage de type Bénédiction"
  },
  Task_74668_Desc = {
    Text = "Jouer 475 cartes avec un personnage de type Esprit"
  },
  Task_74669_Desc = {
    Text = "Jouer 75 cartes avec un personnage de type Maléfice"
  },
  Task_74670_Desc = {
    Text = "Jouer 175 cartes avec un personnage de type Bénédiction"
  },
  Task_74671_Desc = {
    Text = "Jouer 1775 cartes avec un personnage Gardien"
  },
  Task_74672_Desc = {
    Text = "Jouer 575 cartes avec un personnage de type Esprit"
  },
  Task_74673_Desc = {
    Text = "Jouez 500 cartes avec un personnage de type Combattant"
  },
  Task_74674_Desc = {
    Text = "Jouer 1725 cartes avec un personnage de type Esprit"
  },
  Task_74675_Desc = {
    Text = "Jouez 950 cartes avec un personnage de type Combattant"
  },
  Task_74676_Desc = {
    Text = "Jouer 1950 cartes avec un personnage de type Esprit"
  },
  Task_74677_Desc = {
    Text = "Jouer 1500 cartes avec un personnage de type Gardien"
  },
  Task_74678_Desc = {
    Text = "Jouer 1975 cartes avec un personnage de type Bénédiction"
  },
  Task_74679_Desc = {
    Text = "Jouer 975 cartes avec un personnage de type Maléfice"
  },
  Task_74680_Desc = {
    Text = "Jouer 1325 cartes avec un personnage de type Esprit"
  },
  Task_74681_Desc = {
    Text = "Jouez 1775 cartes avec un personnage de type Combattant"
  },
  Task_74682_Desc = {
    Text = "Jouer 125 cartes avec un personnage de type Esprit"
  },
  Task_74683_Desc = {
    Text = "Jouer 1550 cartes avec un personnage de type Bénédiction"
  },
  Task_74684_Desc = {
    Text = "Jouez 2000 cartes avec un personnage de type Combattant"
  },
  Task_74685_Desc = {
    Text = "Jouer 1275 cartes avec un personnage de type Maléfique"
  },
  Task_74686_Desc = {
    Text = "Jouer 525 cartes avec un personnage de type Bénédiction"
  },
  Task_74687_Desc = {
    Text = "Jouer 550 cartes avec un personnage de type Maléfice"
  },
  Task_74688_Desc = {
    Text = "Jouez 650 cartes avec un personnage de type Combattant"
  },
  Task_74689_Desc = {
    Text = "Jouer 875 cartes avec un personnage de type Maléfice"
  },
  Task_74690_Desc = {
    Text = "Jouer 1875 cartes avec un personnage de type Bénédiction"
  },
  Task_74691_Desc = {
    Text = "Jouer 1300 cartes avec un personnage de type Gardien"
  },
  Task_74692_Desc = {
    Text = "Jouer 1100 cartes avec un personnage de type Maléfice"
  },
  Task_74693_Desc = {
    Text = "Jouer 2000 cartes avec un personnage Gardien"
  },
  Task_74694_Desc = {
    Text = "Jouer 1850 cartes avec un personnage de type Maléfice"
  },
  Task_74695_Desc = {
    Text = "Jouez 75 cartes avec un personnage de type Combattant"
  },
  Task_74696_Desc = {
    Text = "Jouez 625 cartes avec un personnage de type Combattant"
  },
  Task_74697_Desc = {
    Text = "Jouez 1425 cartes avec un personnage de type Combattant"
  },
  Task_74698_Desc = {
    Text = "Jouer 1800 cartes avec un personnage Gardien"
  },
  Task_74699_Desc = {
    Text = "Jouer 225 cartes avec un personnage de type Esprit"
  },
  Task_74700_Desc = {
    Text = "Jouer 725 cartes avec un personnage de type Bénédiction"
  },
  Task_74701_Desc = {
    Text = "Jouer 1175 cartes avec un personnage Gardien"
  },
  Task_74702_Desc = {
    Text = "Jouer 450 cartes avec un personnage de type Esprit"
  },
  Task_74703_Desc = {
    Text = "Jouer 575 cartes avec un personnage de type Gardien"
  },
  Task_74704_Desc = {
    Text = "Jouer 1625 cartes avec un personnage de type Bénédiction"
  },
  Task_74705_Desc = {
    Text = "Jouez 625 cartes avec un personnage de type Maléfique"
  },
  Task_74706_Desc = {
    Text = "Jouer 1350 cartes avec un personnage de type Maléfice"
  },
  Task_74707_Desc = {
    Text = "Jouer 1650 cartes avec un personnage de type Bénédiction"
  },
  Task_74708_Desc = {
    Text = "Jouer 650 cartes avec un personnage de type Maléfice"
  },
  Task_74709_Desc = {
    Text = "Jouer 200 cartes avec un personnage de type Gardien"
  },
  Task_74710_Desc = {
    Text = "Jouer 1125 cartes avec un personnage Gardien"
  },
  Task_74711_Desc = {
    Text = "Jouer 50 cartes avec un personnage de type Esprit"
  },
  Task_74712_Desc = {
    Text = "Jouer 450 cartes avec un personnage de type Mauvais Omen"
  },
  Task_74713_Desc = {
    Text = "Jouer 1250 cartes avec un personnage de type Bénédiction"
  },
  Task_74714_Desc = {
    Text = "Jouer 250 cartes avec un personnage de type Mauvais"
  },
  Task_74715_Desc = {
    Text = "Jouer 1450 cartes avec un personnage de type Bénédiction"
  },
  Task_74716_Desc = {
    Text = "Jouer 1675 cartes avec un personnage de type Esprit"
  },
  Task_74717_Desc = {
    Text = "Jouer 900 cartes avec un personnage de type Maléfique"
  },
  Task_74718_Desc = {
    Text = "Jouer 500 cartes avec un personnage de type Esprit"
  },
  Task_74719_Desc = {
    Text = "Jouer 1325 cartes avec un personnage Gardien"
  },
  Task_74720_Desc = {
    Text = "Jouer 425 cartes avec un personnage de type Maléfice"
  },
  Task_74721_Desc = {
    Text = "Jouer 1425 cartes avec un personnage de type Bénédiction"
  },
  Task_74722_Desc = {
    Text = "Jouez 1300 cartes avec un personnage de type Combattant"
  },
  Task_74723_Desc = {
    Text = "Utiliser un personnage de type Bénédiction pour jouer 925 cartes"
  },
  Task_74724_Desc = {
    Text = "Jouer 1825 cartes avec un personnage de type Bénédiction"
  },
  Task_74725_Desc = {
    Text = "Utiliser un personnage de type Bénédiction pour jouer 1175 cartes"
  },
  Task_74726_Desc = {
    Text = "Jouer 175 cartes avec un personnage de type Maléfice"
  },
  Task_74727_Desc = {
    Text = "Jouer 750 cartes avec un personnage de type Bénédiction"
  },
  Task_74728_Desc = {
    Text = "Jouer 850 cartes avec un personnage de type Gardien"
  },
  Task_74729_Desc = {
    Text = "Jouez 1650 cartes avec un personnage de type Combattant"
  },
  Task_74730_Desc = {
    Text = "Jouez 1275 cartes avec un personnage de type Combattant"
  },
  Task_74731_Desc = {
    Text = "Jouer 1175 cartes avec un personnage de type Maléfice"
  },
  Task_74732_Desc = {
    Text = "Jouer 1975 cartes avec un personnage de type Esprit"
  },
  Task_74733_Desc = {
    Text = "Jouez 275 cartes avec un personnage de type Combattant"
  },
  Task_74734_Desc = {
    Text = "Jouer 1425 cartes avec un personnage de type Esprit"
  },
  Task_74735_Desc = {
    Text = "Jouer 1900 cartes avec un personnage Gardien"
  },
  Task_74736_Desc = {
    Text = "Jouer 1600 cartes avec un personnage de type Bénédiction"
  },
  Task_74737_Desc = {
    Text = "Jouer 600 cartes avec un personnage de type Maléfique"
  },
  Task_74738_Desc = {
    Text = "Jouer 1050 cartes avec un personnage de type Gardien"
  },
  Task_74739_Desc = {
    Text = "Jouer 1400 cartes avec un personnage de type Maléfice"
  },
  Task_74740_Desc = {
    Text = "Jouez 200 cartes avec un personnage de type Bénédiction"
  },
  Task_74741_Desc = {
    Text = "Jouer 500 cartes avec un personnage de type Bénédiction"
  },
  Task_74742_Desc = {
    Text = "Jouer 1225 cartes avec un personnage Gardien"
  },
  Task_74743_Desc = {
    Text = "Jouez 525 cartes avec un personnage de type Combattant"
  },
  Task_74744_Desc = {
    Text = "Jouer 400 cartes avec un personnage de type Maléfice"
  },
  Task_74745_Desc = {
    Text = "Jouer 1400 cartes avec un personnage de type Bénédiction"
  },
  Task_74746_Desc = {
    Text = "Jouer 425 cartes avec un personnage de type Gardien"
  },
  Task_74747_Desc = {
    Text = "Jouez 475 cartes avec un personnage de type Combattant"
  },
  Task_74748_Desc = {
    Text = "Jouer 475 cartes avec un personnage de type Maléfice"
  },
  Task_74749_Desc = {
    Text = "Jouer 1475 cartes avec un personnage de type Bénédiction"
  },
  Task_74750_Desc = {
    Text = "Jouez 300 cartes avec un personnage de type Combattant"
  },
  Task_74751_Desc = {
    Text = "Jouer 1575 cartes avec un personnage de type Esprit"
  },
  Task_74752_Desc = {
    Text = "Jouer 1675 cartes avec un personnage Gardien"
  },
  Task_74753_Desc = {
    Text = "Jouer 975 cartes avec un personnage de type Gardien"
  },
  Task_74754_Desc = {
    Text = "Jouez 1250 cartes avec un personnage de type Combattant"
  },
  Task_74755_Desc = {
    Text = "Jouer 850 cartes avec un personnage de type Esprit"
  },
  Task_74756_Desc = {
    Text = "Jouer 1200 cartes avec un personnage de type Bénédiction"
  },
  Task_74757_Desc = {
    Text = "Jouer 1650 cartes avec un personnage de type Maléfique"
  },
  Task_74758_Desc = {
    Text = "Jouer 200 cartes avec un personnage de type Malédiction"
  },
  Task_74759_Desc = {
    Text = "Jouer 1950 cartes avec un personnage de type Bénédiction"
  },
  Task_74760_Desc = {
    Text = "Jouer 950 cartes avec un personnage de type Maléfique"
  },
  Task_74761_Desc = {
    Text = "Jouer 450 cartes avec un personnage de type Bénédiction"
  },
  Task_74762_Desc = {
    Text = "Jouer 1400 cartes avec un personnage de type Esprit"
  },
  Task_74763_Desc = {
    Text = "Jouez 325 cartes avec un personnage de type Combattant"
  },
  Task_74764_Desc = {
    Text = "Jouez 925 cartes avec un personnage de type Combattant"
  },
  Task_74765_Desc = {
    Text = "Jouer 1825 cartes avec un personnage de type Maléfice"
  },
  Task_74766_Desc = {
    Text = "Jouer 300 cartes avec un personnage de type Maléfice"
  },
  Task_74767_Desc = {
    Text = "Jouer 1300 cartes avec un personnage de type Bénédiction"
  },
  Task_74768_Desc = {
    Text = "Jouez 425 cartes avec un personnage de type Combattant"
  },
  Task_74769_Desc = {
    Text = "Jouer 825 cartes avec un personnage de type Gardien"
  },
  Task_75738_Desc = {
    Text = "Complétez \"Cadavre sans tête\" à n'importe quelle difficulté"
  },
  Task_75739_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Reviens à la mer de cendres »"
  },
  Task_75740_Desc = {
    Text = "Terminer n'importe quelle difficulté de \"démons des marais\""
  },
  Task_75741_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Chasse nocturne sous la pluie»"
  },
  Task_75742_Desc = {
    Text = "Complétez « Lui et elle » à n'importe quelle difficulté"
  },
  Task_76237_Desc = {
    Text = "Terminer le chapitre 1 du Chapitre des Étoiles 1-5 en difficulté difficile"
  },
  Task_76238_Desc = {
    Text = "Terminer le chapitre final « Au crépuscule des rêves »"
  },
  Task_76239_Desc = {
    Text = "Terminer le chapitre 1 du Chapitre des Étoiles - Niveau 1-6"
  },
  Task_76240_Desc = {
    Text = "Terminer le chapitre final 9-3 en difficulté difficile"
  },
  Task_76241_Desc = {
    Text = "Terminer le chapitre final « Lorsque le long rêve prend fin » en difficulté difficile"
  },
  Task_76242_Desc = {
    Text = "Terminer le chapitre final « Au crépuscule des rêves »"
  },
  Task_76243_Desc = {
    Text = "Terminer le chapitre 1 du Chapitre des Étoiles « Retour dans la ville brumeuse » en difficulté difficile"
  },
  Task_76244_Desc = {
    Text = "Terminer le chapitre 1 du Chapitre des Étoiles « Retour dans la ville brumeuse » en difficulté difficile"
  },
  Task_76245_Desc = {
    Text = "Terminer le chapitre final 9-4"
  },
  Task_76246_Desc = {
    Text = "Terminer le chapitre 1 du Chapitre des Étoiles 1-6"
  },
  Task_76247_Desc = {
    Text = "Passer le chapitre 1 du Chapitre des Étoiles « Retour dans la ville brumeuse »"
  },
  Task_76248_Desc = {
    Text = "Terminer le chapitre 1 du Chapitre des Étoiles 1-5 en difficulté difficile"
  },
  Task_76249_Desc = {
    Text = "Terminer le chapitre final « Lorsque le long rêve prend fin » en difficulté difficile"
  },
  Task_76250_Desc = {
    Text = "Terminer le chapitre final 9-3 en difficulté difficile"
  },
  Task_76251_Desc = {
    Text = "Terminer le chapitre final 9-4"
  },
  Task_76252_Desc = {
    Text = "Passer le Chapitre des Étoiles, Partie 1 : « Retour dans la ville brumeuse »"
  },
  Task_76339_Desc = {
    Text = "Terminer n'importe quelle difficulté de \"Reviens à la mer de cendres\""
  },
  Task_76340_Desc = {
    Text = "Boutique de sorcière · Folie"
  },
  Task_76341_Desc = {
    Text = "Terminer « Chasse nocturne sous la pluie » à la difficulté Folie"
  },
  Task_76342_Desc = {
    Text = "Terminer « Démons des Marais » en difficulté Folie"
  },
  Task_76343_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Lui et elle »"
  },
  Task_76344_Desc = {
    Text = "Trésors cachés de la sorcière"
  },
  Task_76345_Desc = {
    Text = "Échangez et obtenez 300 objets dans « Trésor magnifique »"
  },
  Task_76346_Desc = {
    Text = "Échangez pour obtenir 150 objets dans « Trésor magnifique »"
  },
  Task_76347_Desc = {
    Text = "Effacez le \"Cadavre Sans Tête\" en difficulté Folie"
  },
  Task_76348_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Chasse nocturne sous la pluie»"
  },
  Task_76349_Desc = {
    Text = "Terminer « Elle et l'autre » à la difficulté Folie"
  },
  Task_76350_Desc = {
    Text = "Terminer « Retour à la mer grise » à la difficulté Folie"
  },
  Task_76351_Desc = {
    Text = "Obtenez 150 objets en échange dans « Trésors précieux »"
  },
  Task_76352_Desc = {
    Text = "Terminer le dossier spécial « Ombre de la Ville Pluvieuse »"
  },
  Task_76353_Desc = {
    Text = "Terminer toutes les missions de « La boutique de la sorcière · Terminé »"
  },
  Task_76354_Desc = {
    Text = "Obtenez 300 objets en les échangeant dans « Trésors précieux »"
  },
  Task_76355_Desc = {
    Text = "Terminer n'importe quelle difficulté de \"démons des marais\""
  },
  Task_76356_Desc = {
    Text = "Échangez pour obtenir 300 objets dans « Produits apaisants »"
  },
  Task_76357_Desc = {
    Text = "Obtenez 150 objets en les échangeant dans « Produit apaisant »"
  },
  Task_76358_Desc = {
    Text = "Boutique de la sorcière·Terminer"
  },
  Task_76359_Desc = {
    Text = "Complétez \"Cadavre sans tête\" à n'importe quelle difficulté"
  },
  Task_77674_Desc = {
    Text = "Obtenez 10 victoires cette saiso"
  },
  Task_77674_Name = {
    Text = "10 Victoires"
  },
  Task_77675_Desc = {
    Text = "Obtenez 1 victoire cette saiso"
  },
  Task_77675_Name = {Text = "1 Victoire"},
  Task_77676_Desc = {
    Text = "Obtenez un total de 3 victoires cette saiso"
  },
  Task_77676_Name = {
    Text = "3 Victoires"
  },
  Task_77677_Desc = {
    Text = "Obtenez un total de 6 victoires cette saiso"
  },
  Task_77677_Name = {
    Text = "6 victoires"
  },
  Task_78106_Desc = {
    Text = "Utilisez « Circuit - Ramona » pour remporter 6 victoires"
  },
  Task_78107_Desc = {
    Text = "Utiliser « le Regard d'Isarau » pour obtenir 6 victoires"
  },
  Task_78108_Desc = {
    Text = "Utilisez « Inébranlable » pour obtenir 6 victoires"
  },
  Task_78109_Desc = {
    Text = "Utiliser « Erica » pour remporter 10 victoires"
  },
  Task_78112_Desc = {
    Text = "Utilisez « Lily » pour remporter 6 victoires"
  },
  Task_78113_Desc = {
    Text = "Utiliser « Rêve d'une nuit d'été » pour remporter 6 victoires"
  },
  Task_78114_Desc = {
    Text = "Utilisez « Toute elle-même » pour obtenir 6 victoires"
  },
  Task_78115_Desc = {
    Text = "Utiliser « Helot-catena » pour remporter 10 victoires"
  },
  Task_78116_Desc = {
    Text = "Utilisez « Ryker » pour remporter 10 victoires"
  },
  Task_78117_Desc = {
    Text = "Utiliser « Ramona » pour remporter 10 victoires"
  },
  Task_78118_Desc = {
    Text = "Obtenez l'éclaircissement 6 lors de l'obtention de Nymphaea"
  },
  Task_78119_Desc = {
    Text = "Utiliser « Nom de la Rose » pour obtenir 6 victoires"
  },
  Task_78120_Desc = {
    Text = "Utiliser « Agrippa » pour remporter 6 victoires"
  },
  Task_78122_Desc = {
    Text = "Utilisez « Miryam » pour obtenir 6 victoires"
  },
  Task_78123_Desc = {
    Text = "Utiliser « Liz » pour obtenir 6 victoires"
  },
  Task_78124_Desc = {
    Text = "Utiliser « Exil » pour obtenir 6 victoires"
  },
  Task_78125_Desc = {
    Text = "Utiliser « Chéri » pour obtenir 6 victoires"
  },
  Task_78126_Desc = {
    Text = "Utiliser « Homme dans le miroir » pour obtenir 6 victoires"
  },
  Task_78127_Desc = {
    Text = "Utilisez « Briser la chaîne » pour obtenir 6 victoires"
  },
  Task_78128_Desc = {
    Text = "Utiliser « Route perdue » pour obtenir 6 victoires"
  },
  Task_78129_Desc = {
    Text = "Utilisez « Tinkt » pour remporter 6 victoires"
  },
  Task_78130_Desc = {
    Text = "Utiliser « Moment de réunion » pour obtenir 6 victoires"
  },
  Task_78131_Desc = {
    Text = "Utiliser « Pandia » pour obtenir 6 victoires"
  },
  Task_78132_Desc = {
    Text = "Utiliser « Salvador » pour obtenir 10 victoires"
  },
  Task_78133_Desc = {
    Text = "Utilisez « Rêve de la mer » pour remporter 6 victoires"
  },
  Task_78134_Desc = {
    Text = "Utiliser « La Porte de la Vérité » pour remporter 6 victoires"
  },
  Task_78135_Desc = {
    Text = "Utiliser « Folie furieuse » pour obtenir 6 victoires"
  },
  Task_78137_Desc = {
    Text = "Utilisez « Nageoire douloureuse » pour remporter 6 victoires"
  },
  Task_78138_Desc = {
    Text = "Obtenir 10 victoires en utilisant « Hilote »"
  },
  Task_78139_Desc = {Text = "Éveilleur"},
  Task_78140_Desc = {
    Text = "Utilisez « 24 » pour obtenir 6 victoires"
  },
  Task_78141_Desc = {
    Text = "Utilisez « Casiah » pour obtenir 6 victoires"
  },
  Task_78142_Desc = {
    Text = "Utilisez « Tawil » pour obtenir 6 victoires"
  },
  Task_78143_Desc = {
    Text = "Utilisez « Goliath » pour obtenir 6 victoires"
  },
  Task_78144_Desc = {
    Text = "Utiliser « 24 » pour obtenir 10 victoires"
  },
  Task_78145_Desc = {
    Text = "Utiliser « Tablette divine » pour obtenir 6 victoires"
  },
  Task_78146_Desc = {
    Text = "Utilisez « Requiem éternel » pour remporter 6 victoires"
  },
  Task_78147_Desc = {
    Text = "Utiliser « Châtiment » pour obtenir 6 victoires"
  },
  Task_78148_Desc = {
    Text = "Utiliser « Miracle » pour obtenir 6 victoires"
  },
  Task_78149_Desc = {
    Text = "Utiliser « La fin du poème » pour obtenir 6 victoires"
  },
  Task_78150_Desc = {
    Text = "Utiliser « Poupée tombée dans l'illusion » pour remporter 6 victoires"
  },
  Task_78151_Desc = {
    Text = "Utiliser « Banquet silencieux » pour remporter 6 victoires"
  },
  Task_78152_Desc = {
    Text = "Utiliser « Pouvoir des pieux » pour remporter 6 victoires"
  },
  Task_78153_Desc = {
    Text = "Obtenir 10 victoires en utilisant « Tulu »"
  },
  Task_78154_Desc = {
    Text = "Utiliser « Détermination du cabillaud argenté » pour remporter 6 victoires"
  },
  Task_78155_Desc = {
    Text = "Utiliser « Avarice » pour obtenir 6 victoires"
  },
  Task_78159_Desc = {
    Text = "Utiliser « Mingwu » pour obtenir 6 victoires"
  },
  Task_78160_Desc = {
    Text = "Utilisez « Véritable forme de la brume grise » pour obtenir 6 victoires"
  },
  Task_78161_Desc = {
    Text = "Utilisez « Festin sanglant » pour remporter 6 victoires"
  },
  Task_78162_Desc = {
    Text = "Utiliser « Bigorneau » pour obtenir 6 victoires"
  },
  Task_78163_Desc = {
    Text = "Utilisez « Million de regards aimants » pour obtenir 6 victoires"
  },
  Task_78164_Desc = {
    Text = "Utiliser « Murmure » pour obtenir 6 victoires"
  },
  Task_78166_Desc = {
    Text = "Obtenir 6 victoires en utilisant « Doll »"
  },
  Task_78168_Desc = {
    Text = "Utiliser « Agrippa » pour obtenir 10 victoires"
  },
  Task_78169_Desc = {
    Text = "Remporter 10 victoires en utilisant « Lotan »"
  },
  Task_78170_Desc = {
    Text = "Utiliser « Goliath » pour obtenir 10 victoires"
  },
  Task_78171_Desc = {
    Text = "Utilisez « Plongée dans le rouge » pour remporter 6 victoires"
  },
  Task_78172_Desc = {
    Text = "Utiliser « Pandia » pour obtenir 10 victoires"
  },
  Task_78173_Desc = {
    Text = "Utiliser « Fable de la gourmandise » pour obtenir 6 victoires"
  },
  Task_78174_Desc = {
    Text = "Utilisez « Roulette du destin » pour remporter 6 victoires"
  },
  Task_78175_Desc = {
    Text = "Utiliser « Couper et blesser » pour remporter 6 victoires"
  },
  Task_78176_Desc = {
    Text = "Utiliser « Chant du roi divin » pour obtenir 6 victoires"
  },
  Task_78177_Desc = {
    Text = "Obtenir 10 victoires en utilisant « Fondu·Poupée »"
  },
  Task_78178_Desc = {
    Text = "Utilisez « Leigh » pour obtenir 6 victoires"
  },
  Task_78179_Desc = {
    Text = "Roue du Destin"
  },
  Task_78180_Desc = {
    Text = "Remporter 6 victoires en utilisant « Hilote »"
  },
  Task_78181_Desc = {
    Text = "Utiliser « Mémoires d'une nuit d'hiver » pour obtenir 6 victoires"
  },
  Task_78182_Desc = {
    Text = "Utiliser « La domination du géant » pour obtenir 6 victoires"
  },
  Task_78183_Desc = {
    Text = "Obtenez 10 victoires en utilisant « Daffodil »"
  },
  Task_78184_Desc = {
    Text = "Utiliser « Voile de gouvernail » pour remporter 6 victoires"
  },
  Task_78185_Desc = {
    Text = "Utilisez « Ryker » pour obtenir 6 victoires"
  },
  Task_78186_Desc = {
    Text = "Obtenez « Évanouissement » en remportant 6 victoires"
  },
  Task_78187_Desc = {
    Text = "Utiliser « Main de l'oubli » pour remporter 6 victoires"
  },
  Task_78188_Desc = {
    Text = "Utilisez « Thais » pour obtenir 6 victoires"
  },
  Task_78189_Desc = {
    Text = "Utiliser « Nymphaea » pour obtenir 10 victoires"
  },
  Task_78190_Desc = {
    Text = "Utilisez « Wanda » pour remporter 6 victoires"
  },
  Task_78192_Desc = {
    Text = "Utiliser « Nautila » pour remporter 6 victoires"
  },
  Task_78193_Desc = {
    Text = "Utilisez « Aigis » pour remporter 6 victoires"
  },
  Task_78194_Desc = {
    Text = "Utilisez « Facteur incalculable » pour obtenir 6 victoires"
  },
  Task_78196_Desc = {
    Text = "Utiliser « Décret de la Reine » pour obtenir 6 victoires"
  },
  Task_78197_Desc = {
    Text = "Utiliser « Oreta » pour remporter 6 victoires"
  },
  Task_78198_Desc = {
    Text = "Utiliser « Circuit - Ramona » pour remporter 10 victoires"
  },
  Task_78199_Desc = {
    Text = "Utiliser « Embusqué dans l'ombre » pour remporter 6 victoires"
  },
  Task_78200_Desc = {
    Text = "Remporter 6 victoires en utilisant « Helot-catena »"
  },
  Task_78201_Desc = {
    Text = "Utiliser « Au-delà de la douleur » pour remporter 6 victoires"
  },
  Task_78202_Desc = {
    Text = "Utiliser « Lame du géant » pour obtenir 6 victoires"
  },
  Task_78203_Desc = {
    Text = "Utiliser « Alva » pour obtenir 10 victoires"
  },
  Task_78204_Desc = {
    Text = "Utilisez « Point critique » pour remporter 6 victoires"
  },
  Task_78205_Desc = {
    Text = "Utiliser « La Mort de Coral » pour obtenir 6 victoires"
  },
  Task_78206_Desc = {
    Text = "Utilisez « La seule semence » pour obtenir 6 victoires"
  },
  Task_78208_Desc = {
    Text = "Utiliser « Berceuse de dévoration » pour obtenir 6 victoires"
  },
  Task_78209_Desc = {
    Text = "Utiliser « À mon ami » pour remporter 6 victoires"
  },
  Task_78210_Desc = {
    Text = "Utiliser « Concentration mentale » pour obtenir 6 victoires"
  },
  Task_78212_Desc = {
    Text = "Utilisez « Syndrome de souvenirs » pour remporter 6 victoires"
  },
  Task_78213_Desc = {
    Text = "Obtenez Daffodil pour remporter 6 victoires"
  },
  Task_78214_Desc = {
    Text = "Utilisez « Quand la montagne de neige fondra » pour obtenir 6 victoires"
  },
  Task_78216_Desc = {
    Text = "Utilisez « Espoir » pour obtenir 6 victoires"
  },
  Task_78217_Desc = {
    Text = "Utiliser « Nuit polaire et lever du jour » pour obtenir 6 victoires"
  },
  Task_78218_Desc = {
    Text = "Utiliser « Murphy » pour remporter 10 victoires"
  },
  Task_78219_Desc = {
    Text = "Utiliser « Échange inégal » pour obtenir 6 victoires"
  },
  Task_78220_Desc = {
    Text = "Utiliser « Le trésor d'Aurita » pour remporter 6 victoires"
  },
  Task_78221_Desc = {
    Text = "Utiliser « Aigis » pour obtenir 10 victoires"
  },
  Task_78223_Desc = {
    Text = "Utiliser « Bâton de noble » pour remporter 6 victoires"
  },
  Task_78224_Desc = {
    Text = "Utiliser « Mer du désir » pour obtenir 6 victoires"
  },
  Task_78225_Desc = {
    Text = "Utiliser « Uvhash » pour remporter 6 victoires"
  },
  Task_78226_Desc = {
    Text = "Utiliser « Miryam » pour remporter 10 victoires"
  },
  Task_78227_Desc = {
    Text = "Utilisez « Ramona » pour obtenir 6 victoires"
  },
  Task_78228_Desc = {
    Text = "Utilisez « Cœur de chevalier » pour obtenir 6 victoires"
  },
  Task_78229_Desc = {
    Text = "Obtenir 6 victoires en utilisant « Fondu·Poupée »"
  },
  Task_78230_Desc = {
    Text = "Utiliser « Collection extrêmement précieuse » pour remporter 6 victoires"
  },
  Task_78231_Desc = {
    Text = "Utilisez « Sac d'aventure » pour obtenir 6 victoires"
  },
  Task_78232_Desc = {
    Text = "Utiliser « Faveur » pour obtenir 6 victoires"
  },
  Task_78233_Desc = {
    Text = "Utilisez « Alva » pour remporter 6 victoires"
  },
  Task_78234_Desc = {
    Text = "Utilisez « Dernier serment » pour remporter 6 victoires"
  },
  Task_78235_Desc = {
    Text = "Utilisez « Horla » pour obtenir 6 victoires"
  },
  Task_78236_Desc = {
    Text = "Utiliser « Sous la pluie battante » pour obtenir 6 victoires"
  },
  Task_78237_Desc = {
    Text = "Obtenir 10 victoires avec « Poupée »"
  },
  Task_78238_Desc = {
    Text = "Utilisez « Au-delà de la mort » pour remporter 6 victoires"
  },
  Task_78239_Desc = {
    Text = "Utiliser « Bête Céleste » pour obtenir 6 victoires"
  },
  Task_78240_Desc = {
    Text = "Utiliser « Sang et sable rugissants » pour obtenir 6 victoires"
  },
  Task_78241_Desc = {
    Text = "Utiliser « Regard en arrière au bord du lac » pour obtenir 6 victoires"
  },
  Task_78242_Desc = {
    Text = "Utiliser « Jenkins » pour obtenir 10 victoires"
  },
  Task_78243_Desc = {
    Text = "Décret Clé"
  },
  Task_78244_Desc = {
    Text = "Utilisez « Descendant pâle » pour remporter 6 victoires"
  },
  Task_78245_Desc = {
    Text = "Utilisez « Caecus » pour remporter 6 victoires"
  },
  Task_78246_Desc = {
    Text = "Utilisez « Hamelin » pour remporter 6 victoires"
  },
  Task_78247_Desc = {
    Text = "Utiliser « Horla » pour remporter 10 victoires"
  },
  Task_78248_Desc = {
    Text = "Utilisez « Fusion du noyau » pour remporter 6 victoires"
  },
  Task_78249_Desc = {
    Text = "Utiliser « Délire » pour obtenir 6 victoires"
  },
  Task_78250_Desc = {
    Text = "Utilisez « Naissance secrète » pour obtenir 6 victoires"
  },
  Task_78251_Desc = {
    Text = "Utiliser « Aurita » pour obtenir 10 victoires"
  },
  Task_78252_Desc = {
    Text = "Utiliser « Murphy » pour obtenir 6 victoires"
  },
  Task_78253_Desc = {
    Text = "Utilisez « L'innocence en argent pur » pour remporter 6 victoires"
  },
  Task_78254_Desc = {
    Text = "Obtenir 6 victoires avec « Tulu »"
  },
  Task_78255_Desc = {
    Text = "Utilisez « Shan » pour obtenir 6 victoires"
  },
  Task_78256_Desc = {
    Text = "Utilisez « Jenkin » pour obtenir 6 victoires"
  },
  Task_78257_Desc = {
    Text = "Utiliser « Bigorneau » pour obtenir 10 victoires"
  },
  Task_78258_Desc = {
    Text = "Utilisez « Wanda » pour obtenir 10 victoires"
  },
  Task_78261_Desc = {
    Text = "Utilisez « Retour dans le temps » pour remporter 6 victoires"
  },
  Task_78262_Desc = {
    Text = "Utiliser « Victoire des roses » pour obtenir 6 victoires"
  },
  Task_78263_Desc = {
    Text = "Utiliser « Ogier » pour obtenir 10 victoires"
  },
  Task_78264_Desc = {
    Text = "Utiliser « Falos » pour obtenir 6 victoires"
  },
  Task_78265_Desc = {
    Text = "Remporter 10 victoires en utilisant « Évanouissement »"
  },
  Task_78266_Desc = {
    Text = "Remporter 10 victoires en utilisant « Hameln »"
  },
  Task_78267_Desc = {
    Text = "Utiliser « Allaitement compatissant » pour obtenir 6 victoires"
  },
  Task_78269_Desc = {
    Text = "Utiliser « Analyse de la mort » pour obtenir 6 victoires"
  },
  Task_78270_Desc = {
    Text = "Utilisez « Maturation » pour obtenir 6 victoires"
  },
  Task_78272_Desc = {
    Text = "Utiliser « L'information, c'est la vie » pour remporter 6 victoires"
  },
  Task_78273_Desc = {
    Text = "Utilisez « Étreinte corrosive » pour remporter 6 victoires"
  },
  Task_78274_Desc = {
    Text = "Utilisez « Sanga » pour obtenir 10 victoires"
  },
  Task_78275_Desc = {
    Text = "Utilisez « Sommeil sous le glacier » pour remporter 6 victoires"
  },
  Task_78276_Desc = {
    Text = "Utiliser « Erica » pour obtenir 6 victoires"
  },
  Task_78277_Desc = {
    Text = "Utiliser « Roue cachée du monde » pour remporter 6 victoires"
  },
  Task_78278_Desc = {
    Text = "Utiliser « La magie de 35 mm » pour obtenir 6 victoires"
  },
  Task_78279_Desc = {
    Text = "Utiliser « Voix dans la tête » pour obtenir 6 victoires"
  },
  Task_78280_Desc = {
    Text = "Utilisez « Heure de chance » pour remporter 6 victoires"
  },
  Task_78281_Desc = {
    Text = "Utiliser « Karen » pour remporter 10 victoires"
  },
  Task_78282_Desc = {
    Text = "Utiliser « Tawil » pour obtenir 10 victoires"
  },
  Task_78283_Desc = {
    Text = "Utiliser « Uvhash » pour obtenir 10 victoires"
  },
  Task_78284_Desc = {
    Text = "Utiliser « Liz » pour remporter 10 victoires"
  },
  Task_78286_Desc = {
    Text = "Utilisez « Barrière du cœur » pour remporter 6 victoires"
  },
  Task_78287_Desc = {
    Text = "Utiliser « Casiah » pour obtenir 10 victoires"
  },
  Task_78288_Desc = {
    Text = "Utilisez « Retour de l'aberration » pour obtenir 6 victoires"
  },
  Task_78289_Desc = {
    Text = "Utiliser « Concert sans fin » pour obtenir 6 victoires"
  },
  Task_78290_Desc = {
    Text = "Utiliser « Malédiction amère » pour remporter 6 victoires"
  },
  Task_78291_Desc = {
    Text = "Utiliser « Céleste » pour remporter 10 victoires"
  },
  Task_78292_Desc = {
    Text = "Utilisez « Lieu inexistant » pour remporter 6 victoires"
  },
  Task_78294_Desc = {
    Text = "Utiliser « Teinture » pour obtenir 10 victoires"
  },
  Task_78295_Desc = {
    Text = "Utiliser « Falos » pour remporter 10 victoires"
  },
  Task_78296_Desc = {
    Text = "Utiliser « Lily » pour remporter 10 victoires"
  },
  Task_78297_Desc = {
    Text = "Utilisez « Éternité éphémère » pour remporter 6 victoires"
  },
  Task_78298_Desc = {
    Text = "Utilisez « Activité » pour obtenir 6 victoires"
  },
  Task_78299_Desc = {
    Text = "Utiliser « Nautila » pour remporter 10 victoires"
  },
  Task_78301_Desc = {
    Text = "Utiliser « Salvador » pour obtenir 6 victoires"
  },
  Task_78303_Desc = {
    Text = "Utilisez « Suce » pour obtenir 6 victoires"
  },
  Task_78304_Desc = {
    Text = "Utiliser « Caecus » pour obtenir 10 victoires"
  },
  Task_78305_Desc = {
    Text = "Utiliser « Ogier » pour remporter 6 victoires"
  },
  Task_78306_Desc = {
    Text = "Utilisez « Devoir » pour obtenir 6 victoires"
  },
  Task_78307_Desc = {
    Text = "Utiliser « Sorel » pour obtenir 10 victoires"
  },
  Task_78308_Desc = {
    Text = "Utilisez « Spectacle de magie heureuse » pour remporter 6 victoires"
  },
  Task_78309_Desc = {
    Text = "Utiliser « Perspicacité » pour obtenir 6 victoires"
  },
  Task_78310_Desc = {
    Text = "Utiliser « Céleste » pour obtenir 6 victoires"
  },
  Task_78313_Desc = {
    Text = "Utilisez « Émergence » pour obtenir 6 victoires"
  },
  Task_78314_Desc = {
    Text = "Utiliser « Leigh » pour remporter 10 victoires"
  },
  Task_78315_Desc = {
    Text = "Utiliser « La chanson enchaînée » pour remporter 6 victoires"
  },
  Task_78316_Desc = {
    Text = "Utilisez « Sorel » pour obtenir 6 victoires"
  },
  Task_78317_Desc = {
    Text = "Utilisez « Karen » pour remporter 6 victoires"
  },
  Task_78318_Desc = {
    Text = "jouer une carte"
  },
  Task_78319_Desc = {
    Text = "Utiliser « Lotan » pour obtenir 6 victoires"
  },
  Task_78320_Desc = {
    Text = "Utilisez « Cadeau pourri » pour obtenir 6 victoires"
  },
  Task_78321_Desc = {
    Text = "Utiliser « Thais » pour remporter 10 victoires"
  },
  Task_78322_Desc = {
    Text = "Utiliser « Spirale de mémoire » pour obtenir 6 victoires"
  },
  Task_78326_Desc = {
    Text = "Ketigora atteint le niveau 10 d'affinité"
  },
  Task_78327_Desc = {
    Text = "Le taux d'affinité d'Affogamon atteint le niveau 10"
  },
  Task_78328_Desc = {
    Text = "Le taux d'affinité de Pollux atteint le niveau 10"
  },
  Task_78329_Desc = {
    Text = "Le taux d'affinité du vautour atteint le niveau 10"
  },
  Task_78332_Desc = {
    Text = "Le taux d'affinité de Lantigos atteint le niveau 10"
  },
  Task_78333_Desc = {
    Text = "Le taux d'affinité de Karab atteint le niveau 10"
  },
  Task_78334_Desc = {
    Text = "Kepsante atteint le niveau 10 d'affinité"
  },
  Task_78336_Desc = {
    Text = "L'affinité d'Arachné atteint le niveau 10"
  },
  Task_78338_Desc = {
    Text = "Le taux d'affinité du Pharaon noir atteint le niveau 10"
  },
  Task_78339_Desc = {
    Text = "Le taux d'affinité de l'oiseau Shantak atteint le niveau 10"
  },
  Task_78340_Desc = {
    Text = "Pickman atteint le niveau 10 d'affinité"
  },
  Task_78341_Desc = {
    Text = "Clémentine atteint le niveau 10 d'affinité"
  },
  Task_78342_Desc = {
    Text = "Castor atteint le niveau 10 d'affinité"
  },
  Task_78366_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78367_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78368_Desc = {
    Text = "Obtenez l'illumination 6 lors de l'obtention de Shatanak"
  },
  Task_78368_Name = {
    Text = "Obtenez l'oiseau Shatanak en illuminant 6"
  },
  Task_78368_UnlockCondDesc = {
    Text = "Événement @ Pack d'illumination de Chatak le réveilleur 2 événement"
  },
  Task_78369_Desc = {
    Text = "Obtenez Katigora avec une illumination de 6"
  },
  Task_78369_Name = {
    Text = "Obtenez Katigora avec une illumination de 6"
  },
  Task_78369_UnlockCondDesc = {
    Text = "Activité @réveilleur Katigura paquet d'illumination 2 activité"
  },
  Task_78370_Desc = {
    Text = "Obtenez Chatak en illuminant 2"
  },
  Task_78370_Name = {
    Text = "Obtenez Chatak en illuminant 2"
  },
  Task_78370_UnlockCondDesc = {
    Text = "Activité @réveilleur Chatak paquet lumineux 2 activité"
  },
  Task_78371_Desc = {
    Text = "Obtenez Katigora avec une illumination de 2"
  },
  Task_78371_Name = {
    Text = "Obtenez Katigora avec une illumination de 2"
  },
  Task_78371_UnlockCondDesc = {
    Text = "Activité @réveilleur Catigura paquet lumineux 2 activité"
  },
  Task_78372_Desc = {
    Text = "Obtenez Pollux à illuminer 2"
  },
  Task_78372_Name = {
    Text = "Obtenez Pollux à l'illumination 2"
  },
  Task_78372_UnlockCondDesc = {
    Text = "Événement @ Pack d'illumination de Pollux le réveilleur 2 événement"
  },
  Task_78373_Desc = {
    Text = "Obtenez Pollux en illuminant 6"
  },
  Task_78373_Name = {
    Text = "Obtenez Pollux en illuminant 6"
  },
  Task_78373_UnlockCondDesc = {
    Text = "Activité @réveilleur Pollux paquet lumineux 2 activité"
  },
  Task_78375_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78379_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78380_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78382_Desc = {
    Text = "Obtenez Arachne en illuminant 6"
  },
  Task_78382_Name = {
    Text = "Obtenez Arachne en illuminant 6"
  },
  Task_78382_UnlockCondDesc = {
    Text = "Événement @ Pack d'illumination d'Arachné le réveilleur 2 événement"
  },
  Task_78383_Desc = {
    Text = "Obtenez Arachne en illuminant 2"
  },
  Task_78383_Name = {
    Text = "Obtenez Arachné en illuminant 2"
  },
  Task_78383_UnlockCondDesc = {
    Text = "Événement @ Pack d'illumination d'Arachne le réveilleur 2 Événement"
  },
  Task_78384_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78385_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78390_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78391_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78394_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78395_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78396_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78397_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78400_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78401_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78402_Desc = {
    Text = "Obtenez Pickman en illuminant 6"
  },
  Task_78402_Name = {
    Text = "Obtenez Pickman en illuminant 6"
  },
  Task_78402_UnlockCondDesc = {
    Text = "Activité @réveilleur Pickman paquet lumineux 2 activité"
  },
  Task_78403_Desc = {
    Text = "Obtenez Pickman avec une illumination de 2"
  },
  Task_78403_Name = {
    Text = "Obtenez Pickman en illuminant 2"
  },
  Task_78403_UnlockCondDesc = {
    Text = "Activité @réveilleur Pickman paquet lumineux 2 activité"
  },
  Task_78404_Desc = {
    Text = "Obtenez Castor avec une illumination 2"
  },
  Task_78404_UnlockCondDesc = {
    Text = "Activité @réveilleur Castor paquet lumineux 2 activité"
  },
  Task_78405_Desc = {
    Text = "Obtenez Castor avec une illumination de 6"
  },
  Task_78405_Name = {
    Text = "Obtenez Castor avec une illumination de 6"
  },
  Task_78405_UnlockCondDesc = {
    Text = "Activité @réveilleur Castor paquet lumineux 2 activité"
  },
  Task_78409_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78415_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78416_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78418_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78419_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78421_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78423_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78424_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78426_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78429_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78430_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78431_Desc = {
    Text = "Obtenez Carabes avec une illumination de 2"
  },
  Task_78431_Name = {
    Text = "Obtenez Carabes avec une illumination de 2"
  },
  Task_78431_UnlockCondDesc = {
    Text = "Événement @ Pack d'illumination de Carabes le réveilleur 2 événement"
  },
  Task_78432_Desc = {
    Text = "Obtenez Carabes avec une illumination de 6"
  },
  Task_78432_Name = {
    Text = "Obtenez Carabes avec une illumination de 6"
  },
  Task_78432_UnlockCondDesc = {
    Text = "Événement @ Pack d'illumination de Carabes le réveilleur 2 événement"
  },
  Task_78435_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78436_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78437_Desc = {
    Text = "Obtenez Aforgomon en illuminant 2"
  },
  Task_78437_Name = {
    Text = "Obtenez Aforgomon à illuminer 2"
  },
  Task_78437_UnlockCondDesc = {
    Text = "Événement @ Pack d'illumination d'Avfogemon, le réveilleur 2 événement"
  },
  Task_78438_Desc = {
    Text = "Obtenez Clémentine avec une illumination de 2"
  },
  Task_78438_Name = {
    Text = "Obtenez Clémentine avec une illumination de 2"
  },
  Task_78438_UnlockCondDesc = {
    Text = "Activité @réveilleur Clémentine paquet d'illumination 2 activité"
  },
  Task_78440_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78441_Desc = {
    Text = "Obtenez Clémentine avec une illumination de 6"
  },
  Task_78441_Name = {
    Text = "Obtenez Clémentine avec une illumination de 6"
  },
  Task_78441_UnlockCondDesc = {
    Text = "Activité @réveilleur Clémentine paquet lumineux 2 activité"
  },
  Task_78446_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78447_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78449_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78450_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78451_Desc = {
    Text = "Obtenez le Pharaon noir avec une illumination de 2"
  },
  Task_78451_Name = {
    Text = "Obtenez le Pharaon noir avec une illumination de 2"
  },
  Task_78451_UnlockCondDesc = {
    Text = "Activité @réveilleur Pharaon noir paquet lumineux 2 activité"
  },
  Task_78453_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78458_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78459_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78460_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78466_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78468_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78470_Desc = {
    Text = "Obtenez le Pharaon noir avec une illumination de 6"
  },
  Task_78470_Name = {
    Text = "Obtenez le Pharaon noir avec une illumination de 6"
  },
  Task_78470_UnlockCondDesc = {
    Text = "Activité @réveilleur Pharaon noir paquet lumineux 2 activité"
  },
  Task_78476_Desc = {
    Text = "Obtenez Lantigos à illuminer 6"
  },
  Task_78476_Name = {
    Text = "Obtenez Lantigos en illuminant 6"
  },
  Task_78476_UnlockCondDesc = {
    Text = "Activité @réveilleur Lantigos paquet lumineux 2 activité"
  },
  Task_78477_Desc = {
    Text = "Obtenez Lantigos à illuminer 2"
  },
  Task_78477_Name = {
    Text = "Obtenez Lantigos à illuminer 2"
  },
  Task_78477_UnlockCondDesc = {
    Text = "Activité @réveilleur Lantigos paquet lumineux 2 activité"
  },
  Task_78481_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78483_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78484_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78485_Desc = {
    Text = "Obtenez vautour à illuminer 2"
  },
  Task_78485_Name = {
    Text = "Obtenez vautour à illuminer 2"
  },
  Task_78485_UnlockCondDesc = {
    Text = "Activité @réveilleur Vautour paquet lumineux 2 activité"
  },
  Task_78486_Desc = {
    Text = "Obtenez Vautour en illuminant 6"
  },
  Task_78486_Name = {
    Text = "Obtenez Vautour en illuminant 6"
  },
  Task_78486_UnlockCondDesc = {
    Text = "Activité @réveilleur Vautour paquet lumineux 2 activité"
  },
  Task_78487_Desc = {
    Text = "Obtenez Aforgomon en illuminant 6"
  },
  Task_78487_Name = {
    Text = "Obtenez Aforgomon en illuminant 6"
  },
  Task_78487_UnlockCondDesc = {
    Text = "Événement @ Pack d'illumination d'Avfogemon le réveilleur 2 événement"
  },
  Task_78488_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78489_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78492_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78493_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78495_Desc = {
    Text = "Obtenez Kepsante avec une illumination de 6"
  },
  Task_78495_Name = {
    Text = "Obtenez l'illumination 6 en obtenant Kepsante"
  },
  Task_78495_UnlockCondDesc = {
    Text = "Activité @réveilleur Kepsante paquet d'illumination 2 activité"
  },
  Task_78496_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78497_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78499_Desc = {
    Text = "Obtenez Kepsante en illuminant 2"
  },
  Task_78499_Name = {
    Text = "Obtenez Kepsante en illuminant 2"
  },
  Task_78499_UnlockCondDesc = {
    Text = "Événement @ Pack d'illumination de Kepersant le réveilleur 2 événement"
  },
  Task_78573_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78574_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78576_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78577_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78599_Desc = {
    Text = "Vaincre lors de la bataille finale en 13 tours"
  },
  Task_78599_Name = {
    Text = "Vaincre lors de la bataille finale en 13 tours"
  },
  Task_78600_Desc = {
    Text = "Vaincre lors de la bataille finale en 14 tours"
  },
  Task_78600_Name = {
    Text = "Vaincre lors de la bataille finale en 14 tours"
  },
  Task_78718_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter 2 fois dans « Codage de mémoire »"
  },
  Task_78719_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 2 fois dans « Codage de souvenirs »"
  },
  Task_78720_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter 2 fois dans « Codage de mémoire »"
  },
  Task_78721_Desc = {
    Text = "Utiliser un réveilleur du domaine hyperdimensionnel pour remporter 2 victoires dans « Codage de mémoire »"
  },
  Task_78723_Desc = {
    Text = "Courant sombre et chants d'insectes II"
  },
  Task_78724_Desc = {
    Text = "Courant sombre et chants d'insectes I"
  },
  Task_78725_Desc = {
    Text = "Courant sombre et chants d'insectes VII"
  },
  Task_78726_Desc = {
    Text = "Courant sombre et chants d'insectesⅤ"
  },
  Task_78727_Desc = {
    Text = "Murmure des vers des marées sombres · Gratuit"
  },
  Task_78728_Desc = {
    Text = "Courant sombre et chants d'insectes VI"
  },
  Task_78729_Desc = {
    Text = "Courant sombre et chants d'insectes III"
  },
  Task_78730_Desc = {
    Text = "Courant sombre et chants d'insectes IV"
  },
  Task_78740_Desc = {
    Text = "Obtenez Genèse Maître du Sommeil à illuminer 6"
  },
  Task_78740_Name = {
    Text = "Obtenez Maître du sommeil originel à illuminer 6"
  },
  Task_78740_UnlockCondDesc = {
    Text = "Activité @réveilleur Genèse du Seigneur endormi - Pack d'illumination 2 - Activité"
  },
  Task_78741_Desc = {
    Text = "Genèse : le Maître du sommeil atteint le niveau 10 d'affinité"
  },
  Task_78742_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78743_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78745_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78746_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78748_Desc = {
    Text = "Obtenez la genèse Maître du sommeil à illuminer 2"
  },
  Task_78748_Name = {
    Text = "Obtenez la genèse Maître du sommeil originel à illuminer 2"
  },
  Task_78748_UnlockCondDesc = {
    Text = "Activité @réveilleur génétique Seigneur endormi paquet lumineux 2 activité"
  },
  Task_78763_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78764_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78766_Desc = {
    Text = "Obtenez la genèse Fond marin Dame des mers à illuminer 2"
  },
  Task_78766_Name = {
    Text = "Obtenez la Genèse Fond marin Dame des mers en illuminant 2"
  },
  Task_78766_UnlockCondDesc = {
    Text = "Activité @réveilleur genèse Fond marin Cendrillon paquet lumineux 2 activité"
  },
  Task_78767_Desc = {
    Text = "Obtenez la Genèse Dame des profondeurs en illuminant 6"
  },
  Task_78767_Name = {
    Text = "Obtenez la Genèse Dame des profondeurs en illuminant 6"
  },
  Task_78767_UnlockCondDesc = {
    Text = "Activité @réveilleur genèse Fond marin Céleste paquet lumineux 2 activité"
  },
  Task_78768_Desc = {
    Text = "La Dame Originelle des Profondeurs atteint le niveau 10 d'affinité"
  },
  Task_78769_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_78770_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_79259_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_79259_Name = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_79283_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_79283_Name = {
    Text = "Passer Parfait"
  },
  Task_79284_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_79284_Name = {
    Text = "Passer Parfait"
  },
  Task_79285_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_79285_Name = {
    Text = "Passer Parfait"
  },
  Task_79286_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_79286_Name = {
    Text = "Passer Parfait"
  },
  Task_79287_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_79287_Name = {
    Text = "Passer Parfait"
  },
  Task_79288_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_79288_Name = {
    Text = "Passer Parfait"
  },
  Task_79289_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_79289_Name = {
    Text = "Passer Parfait"
  },
  Task_79290_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_79290_Name = {
    Text = "Passer Parfait"
  },
  Task_79291_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_79291_Name = {
    Text = "Passer Parfait"
  },
  Task_79292_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_79292_Name = {
    Text = "Passer Parfait"
  },
  Task_79304_Desc = {
    Text = "Utiliser « Première rencontre blanche » pour remporter 1 victoire"
  },
  Task_79305_Desc = {
    Text = "Utilisez « Couchant Solaire » pour obtenir 1 victoire"
  },
  Task_79306_Desc = {
    Text = "Utiliser « Peste du néant » pour remporter 1 victoire"
  },
  Task_79307_Desc = {
    Text = "Utiliser « Tourne, tourne » pour remporter 6 victoires"
  },
  Task_79308_Desc = {
    Text = "Utiliser « La sagesse des rats » pour remporter 1 victoire"
  },
  Task_79309_Desc = {
    Text = "Utiliser « Première rencontre blanche » pour remporter 3 victoires"
  },
  Task_79310_Desc = {
    Text = "Utilisez « Adieu brûlant » pour remporter 6 victoires"
  },
  Task_79311_Desc = {
    Text = "Utiliser « Couchant Solaire » pour remporter 3 victoires"
  },
  Task_79312_Desc = {
    Text = "Utiliser « Bâton de berger » pour remporter 3 victoires"
  },
  Task_79313_Desc = {
    Text = "Utiliser « Funérailles éternelles » pour remporter 1 victoire"
  },
  Task_79314_Desc = {
    Text = "Utiliser « La sagesse des rats » pour remporter 3 victoires"
  },
  Task_79315_Desc = {
    Text = "Utiliser « Révélation des montagnes » pour obtenir 3 victoires"
  },
  Task_79316_Desc = {
    Text = "Utiliser « Petit Vœu » pour remporter 3 victoires"
  },
  Task_79317_Desc = {
    Text = "Utilisez « Naissance d'une âme » pour obtenir 1 victoire"
  },
  Task_79318_Desc = {
    Text = "Utiliser « Appel des profondeurs » pour remporter 6 victoires"
  },
  Task_79319_Desc = {
    Text = "Utilisez « Festin pourri » pour remporter 6 victoires"
  },
  Task_79320_Desc = {
    Text = "Utiliser « Bénédiction des étoiles » pour remporter 3 victoires"
  },
  Task_79321_Desc = {
    Text = "Utiliser « Festin pourri » pour obtenir 3 victoires"
  },
  Task_79322_Desc = {
    Text = "Utiliser « La réponse de la porte » pour obtenir 1 victoire"
  },
  Task_79323_Desc = {
    Text = "Utiliser « Bâton de berger » pour obtenir 6 victoires"
  },
  Task_79324_Desc = {
    Text = "Utiliser « Appel des mers » pour obtenir 1 victoire"
  },
  Task_79325_Desc = {
    Text = "Utiliser « Appel des mers » pour remporter 3 victoires"
  },
  Task_79326_Desc = {
    Text = "Utiliser « Peste du néant » pour remporter 3 victoires"
  },
  Task_79327_Desc = {
    Text = "Utilisez « Ode du printemps » pour remporter 6 victoires"
  },
  Task_79328_Desc = {
    Text = "Utiliser « Un coup de feu » pour obtenir 1 victoire"
  },
  Task_79329_Desc = {
    Text = "Utiliser « Rituel de l'immortalité » pour remporter 3 victoires"
  },
  Task_79330_Desc = {
    Text = "Utiliser « Porte de la taverne » pour remporter 1 victoire"
  },
  Task_79331_Desc = {
    Text = "Utiliser « Obsession éternelle » pour remporter 3 victoires"
  },
  Task_79332_Desc = {
    Text = "Utiliser « Petit Vœu » pour remporter 1 victoire"
  },
  Task_79333_Desc = {
    Text = "Utiliser « La réponse de la porte » pour remporter 6 victoires"
  },
  Task_79334_Desc = {
    Text = "Utilisez « Trône de pierre bleue » pour remporter 6 victoires"
  },
  Task_79335_Desc = {
    Text = "Utiliser « Protection céleste » pour remporter 1 victoire"
  },
  Task_79336_Desc = {
    Text = "Utiliser « Révélation des montagnes » pour obtenir 6 victoires"
  },
  Task_79337_Desc = {
    Text = "Obtenez 6 victoires en utilisant « Couchant Solaire »"
  },
  Task_79338_Desc = {
    Text = "Utilisez « Printemps d'Akut » pour remporter 6 victoires"
  },
  Task_79339_Desc = {
    Text = "Utiliser « La sagesse des rats » pour obtenir 6 victoires"
  },
  Task_79340_Desc = {
    Text = "Utilisez « Gourmandise » pour remporter 6 victoires"
  },
  Task_79341_Desc = {
    Text = "Utilisez « Rituel de l'immortalité » pour obtenir 6 victoires"
  },
  Task_79342_Desc = {
    Text = "Utilisez « Rituel de la mer » pour remporter 6 victoires"
  },
  Task_79343_Desc = {
    Text = "Utiliser « Injection de protection » pour remporter 1 victoire"
  },
  Task_79344_Desc = {
    Text = "Utiliser « Injection de protection » pour remporter 3 victoires"
  },
  Task_79345_Desc = {
    Text = "Utiliser « Porte de la taverne » pour remporter 3 victoires"
  },
  Task_79346_Desc = {
    Text = "Utiliser « Fleurs et poèmes d'antan » pour remporter 3 victoires"
  },
  Task_79347_Desc = {
    Text = "Utiliser « Fouetté » pour remporter 1 victoire"
  },
  Task_79348_Desc = {
    Text = "Utiliser « Chapeau magique à large bord » pour obtenir 6 victoires"
  },
  Task_79349_Desc = {
    Text = "Utiliser « Franchir la porte du retour » pour remporter 3 victoires"
  },
  Task_79350_Desc = {
    Text = "Utiliser « Le Quatrième Mouvement » pour remporter 6 victoires"
  },
  Task_79351_Desc = {
    Text = "Utiliser « Trône de pierre bleue » pour remporter 1 victoire"
  },
  Task_79352_Desc = {
    Text = "Utiliser « Quatrième mouvement » pour remporter 1 victoire"
  },
  Task_79353_Desc = {
    Text = "Utilisez « Porte de la taverne » pour remporter 6 victoires"
  },
  Task_79354_Desc = {
    Text = "Utiliser « Peste du néant » pour remporter 6 victoires"
  },
  Task_79355_Desc = {
    Text = "Utiliser « Un coup de feu » pour obtenir 6 victoires"
  },
  Task_79356_Desc = {
    Text = "Utiliser « Chapeau à large bord de sorcière » pour remporter 1 victoire"
  },
  Task_79357_Desc = {
    Text = "Utiliser « Rotation, Rotation » pour remporter 3 victoires"
  },
  Task_79358_Desc = {
    Text = "Utiliser « Festin pourri » pour remporter 1 victoire"
  },
  Task_79359_Desc = {
    Text = "Utiliser « Trône de pierre bleue » pour obtenir 3 victoires"
  },
  Task_79360_Desc = {
    Text = "Utiliser « Adieu brûlant » pour obtenir 3 victoires"
  },
  Task_79361_Desc = {
    Text = "Utiliser « Naissance d'une âme » pour remporter 3 victoires"
  },
  Task_79362_Desc = {
    Text = "Utiliser « Obsession éternelle » pour remporter 1 victoire"
  },
  Task_79363_Desc = {
    Text = "Utiliser « Franchir la porte du retour » pour remporter 1 victoire"
  },
  Task_79364_Desc = {
    Text = "Utiliser « Adieu brûlant » pour remporter 1 victoire"
  },
  Task_79365_Desc = {
    Text = "Utiliser « Fleurs et poèmes d'antan » pour obtenir 6 victoires"
  },
  Task_79366_Desc = {
    Text = "Utiliser « Béatitude stellaire » pour remporter 6 victoires"
  },
  Task_79367_Desc = {
    Text = "Remporter 1 victoire en utilisant « Poème de printemps »"
  },
  Task_79368_Desc = {
    Text = "Utiliser « La détermination des montagnes » pour remporter 1 victoire"
  },
  Task_79369_Desc = {
    Text = "Remporter 3 victoires en utilisant « Printemps d'Akut »"
  },
  Task_79370_Desc = {
    Text = "Utilisez « Injection de protection » pour remporter 6 victoires"
  },
  Task_79371_Desc = {
    Text = "Utiliser « Chapeau à large bord de la sorcière » pour remporter 3 victoires"
  },
  Task_79372_Desc = {
    Text = "Utiliser « Rituel de la mer » pour remporter 3 victoires"
  },
  Task_79373_Desc = {
    Text = "Utiliser « Franchir la porte du retour » pour obtenir 6 victoires"
  },
  Task_79374_Desc = {
    Text = "Utilisez « Première rencontre blanche » pour obtenir 6 victoires"
  },
  Task_79375_Desc = {
    Text = "Utiliser « Petit Vœu » pour remporter 6 victoires"
  },
  Task_79376_Desc = {
    Text = "Utiliser « Gourmandise » pour remporter 3 victoires"
  },
  Task_79377_Desc = {
    Text = "Utiliser « Rituel de la mer » pour remporter 1 victoire"
  },
  Task_79378_Desc = {
    Text = "Utiliser « Quatrième mouvement » pour remporter 3 victoires"
  },
  Task_79379_Desc = {
    Text = "Utiliser « Gourmandise » pour obtenir 1 victoire"
  },
  Task_79380_Desc = {
    Text = "Utiliser « La réponse de la porte » pour remporter 3 victoires"
  },
  Task_79381_Desc = {
    Text = "Utiliser « Fleurs et poèmes d'antan » pour remporter 1 victoire"
  },
  Task_79382_Desc = {
    Text = "Utiliser « Bâton de berger » pour remporter 1 victoire"
  },
  Task_79383_Desc = {
    Text = "Utiliser « Un coup de feu » pour obtenir 3 victoires"
  },
  Task_79384_Desc = {
    Text = "Utilisez « Naissance d'une âme » pour obtenir 6 victoires"
  },
  Task_79385_Desc = {
    Text = "Utiliser « Printemps d'Akut » pour remporter 1 victoire"
  },
  Task_79386_Desc = {
    Text = "Utilisez « Obsession éternelle » pour obtenir 6 victoires"
  },
  Task_79387_Desc = {
    Text = "Utiliser « Poème de printemps » pour remporter 3 victoires"
  },
  Task_79483_Desc = {
    Text = "Guérison de la Peur : Royaume"
  },
  Task_79484_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter 2 fois dans « Peur guérissante »"
  },
  Task_79485_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter une victoire dans « Peur »"
  },
  Task_79486_Desc = {
    Text = "Terminer n'importe quelle difficulté de \"Clinique de la Mémoire\""
  },
  Task_79487_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter 2 victoires dans « Peur »"
  },
  Task_79488_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter une victoire dans « Peur »"
  },
  Task_79489_Desc = {
    Text = "Terminer difficulté Folie de « Nouvelle Vie »"
  },
  Task_79490_Desc = {
    Text = "Guérison de la Peur : Achèvement"
  },
  Task_79491_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Papillon de feu »"
  },
  Task_79492_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter une victoire dans « Peur »"
  },
  Task_79493_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter 2 fois dans « Peur Guérie »"
  },
  Task_79494_Desc = {
    Text = "Terminer n'importe quelle difficulté de \"Nouvelle Vie\""
  },
  Task_79495_Desc = {
    Text = "Terminer « Monde en flammes » en difficulté Folie"
  },
  Task_79496_Desc = {
    Text = "Terminer « Heure de l'Invasion de Rêve » à la difficulté Folie"
  },
  Task_79497_Desc = {
    Text = "Terminer n'importe quelle difficulté de \"Clinique de la Mémoire\""
  },
  Task_79498_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Papillon de feu»"
  },
  Task_79499_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Monde enflammé »"
  },
  Task_79500_Desc = {
    Text = "Guérison de la Peur : Folie"
  },
  Task_79501_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Monde enflammé»"
  },
  Task_79502_Desc = {
    Text = "Terminer n'importe quelle difficulté de «L'Heure de l'Invasion de Rêve»"
  },
  Task_79503_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 1 victoire dans « Peur »"
  },
  Task_79504_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 2 fois dans « Peur guérie »"
  },
  Task_79505_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Nouvelle Vie »"
  },
  Task_79506_Desc = {
    Text = "Terminer « Papillon de feu » en difficulté Folie"
  },
  Task_79507_Desc = {
    Text = "Compléter toutes les tâches dans \"Soins de la Peur : Achèvement\""
  },
  Task_79508_Desc = {
    Text = "Terminer n'importe quelle difficulté de « L'Heure de l'Invasion des Rêves »"
  },
  Task_79509_Desc = {
    Text = "Terminer « Mémoire Médicale » en difficulté Folie"
  },
  Task_79747_Desc = {
    Text = "Obtenez Clémentine"
  },
  Task_79747_Name = {
    Text = "Obtenez Clémentine"
  },
  Task_80218_Desc = {
    Text = "Vaincre les «Villageois» qui bloquent le chemin"
  },
  Task_80218_Name = {Text = "Objectif"},
  Task_80219_Desc = {
    Text = "Arrêter le « Rituel de la Vie »"
  },
  Task_80219_Name = {Text = "Objectif"},
  Task_80220_Desc = {
    Text = "Projection de l'univers @2"
  },
  Task_80220_Name = {Text = "Objectif"},
  Task_80221_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_80221_Name = {
    Text = "Passer Parfait"
  },
  Task_80222_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_80222_Name = {
    Text = "Passer Parfait"
  },
  Task_80223_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_80223_Name = {
    Text = "Passer Parfait"
  },
  Task_80224_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_80224_Name = {
    Text = "Passer Parfait"
  },
  Task_80225_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_80225_Name = {
    Text = "Passer Parfait"
  },
  Task_80226_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_80226_Name = {
    Text = "Passer Parfait"
  },
  Task_80227_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_80227_Name = {
    Text = "Passer Parfait"
  },
  Task_80228_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_80228_Name = {
    Text = "Passer Parfait"
  },
  Task_80229_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_80229_Name = {
    Text = "Passer Parfait"
  },
  Task_80230_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_80230_Name = {
    Text = "Passer Parfait"
  },
  Task_80231_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_80231_Name = {
    Text = "Passer Parfait"
  },
  Task_80232_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_80232_Name = {
    Text = "Passer Parfait"
  },
  Task_80233_Desc = {
    Text = "Confirmer « Ramona »"
  },
  Task_80233_Name = {Text = "Objectif"},
  Task_80234_Desc = {
    Text = "Éviter d'être capturé par la patrouille"
  },
  Task_80234_Name = {Text = "Objectif"},
  Task_80235_Desc = {
    Text = "Secouez-vous des « Clémentines »"
  },
  Task_80235_Name = {Text = "Objectif"},
  Task_80236_Desc = {
    Text = "Rendez-vous dans le cabinet médical de Clémentine"
  },
  Task_80236_Name = {Text = "Objectif"},
  Task_80237_Desc = {
    Text = "Rentrer à la maison"
  },
  Task_80237_Name = {Text = "Objectif"},
  Task_80238_Desc = {
    Text = "Arrêter la « confinement » d'Herbert"
  },
  Task_80238_Name = {Text = "Objectif"},
  Task_80239_Desc = {
    Text = "Échapper à la poursuite du docteur"
  },
  Task_80239_Name = {Text = "Objectif"},
  Task_80240_Desc = {
    Text = "Plongée dans la mémoire d'Albino"
  },
  Task_80240_Name = {Text = "Objectif"},
  Task_80241_Desc = {
    Text = "Maîtriser les patients enragés"
  },
  Task_80241_Name = {Text = "Objectif"},
  Task_80286_Desc = {
    Text = "Terminer le chapitre 2 du Chapitre des Étoiles - niveau 2-9"
  },
  Task_80287_Desc = {
    Text = "Terminer le chapitre 2 du Chapitre des Étoiles 2-6 en difficulté difficile"
  },
  Task_80288_Desc = {
    Text = "Compléter l'événement d'investigation \"@1@2\""
  },
  Task_80288_Desc2 = {
    Text = "Terminer l'événement d'enquête «Métamorphose»"
  },
  Task_80288_Name = {Text = "@2@3"},
  Task_80288_Name2 = {
    Text = "Écoute le bourdonnement de l'univers"
  },
  Task_80289_Desc = {
    Text = "Compléter l'événement d'enquête « Métamorphose » en difficulté difficile"
  },
  Task_80289_Name = {
    Text = "Écouter le bourdonnement cosmique · Difficile"
  },
  Task_80290_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_80291_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_80292_Desc = {
    Text = "Terminer le chapitre 2 du Chapitre des Étoiles « Métamorphose »"
  },
  Task_80293_Desc = {
    Text = "Terminer le chapitre 2 du Chapitre des Étoiles « Métamorphose » en difficulté difficile"
  },
  Task_80294_Desc = {
    Text = "Terminer le chapitre 2-6 du Chapitre des Étoiles en difficulté difficile"
  },
  Task_80295_Desc = {
    Text = "Résonner 9 fois dans l'enquête sur l'événement «@1@2»"
  },
  Task_80295_Desc2 = {
    Text = "Résonner 9 fois dans l'enquête sur l'événement « Métamorphose »"
  },
  Task_80295_Name = {Text = "@2@3"},
  Task_80295_Name2 = {
    Text = "Écho évolutif III"
  },
  Task_80296_Desc = {
    Text = "Résonner 6 fois dans l'enquête sur l'événement «@1@2»"
  },
  Task_80296_Desc2 = {
    Text = "Résonner 6 fois dans l'enquête sur l'événement « Métamorphose »"
  },
  Task_80296_Name = {Text = "@2@3"},
  Task_80296_Name2 = {
    Text = "Écho d'évolution II"
  },
  Task_80297_Desc = {
    Text = "Résonner 3 fois dans l'enquête sur l'événement «@1@2»"
  },
  Task_80297_Desc2 = {
    Text = "Résonner 3 fois dans l'enquête sur l'événement « Métamorphose »"
  },
  Task_80297_Name = {Text = "@2@3"},
  Task_80297_Name2 = {
    Text = "Résonance évolutionnaire"
  },
  Task_80298_Desc = {
    Text = "Terminer le chapitre 2 du Chapitre des Étoiles - niveau 2-9"
  },
  Task_80299_Desc = {
    Text = "Résonner 11 fois dans l'événement d'investigation \"@1@2\""
  },
  Task_80299_Desc2 = {
    Text = "Résonner 11 fois dans l'enquête sur l'événement « Métamorphose »"
  },
  Task_80299_Name = {Text = "@2@3"},
  Task_80299_Name2 = {
    Text = "Écho d'évolution IV"
  },
  Task_80300_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_80301_Desc = {
    Text = "Terminer le chapitre 2 du Chapitre des Étoiles « Métamorphose »"
  },
  Task_80302_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_80303_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_80304_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_80305_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_80306_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_80307_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_80309_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_80310_Desc = {
    Text = "Terminer le chapitre 2 du Chapitre des Étoiles « Métamorphose » en difficulté difficile"
  },
  Task_80419_Name = {
    Text = "Rejouer le niveau Étoile Chapitre 2-18"
  },
  Task_80433_Desc = {
    Text = "Obtenez 10 victoires cette saiso"
  },
  Task_80433_Name = {
    Text = "10 Victoires"
  },
  Task_80434_Desc = {
    Text = "Obtenez un total de 6 victoires cette saiso"
  },
  Task_80434_Name = {
    Text = "6 victoires"
  },
  Task_80435_Desc = {
    Text = "Obtenez un total de 3 victoires cette saiso"
  },
  Task_80435_Name = {
    Text = "3 Victoires"
  },
  Task_80436_Desc = {
    Text = "Obtenez 1 victoire cette saiso"
  },
  Task_80436_Name = {Text = "1 Victoire"},
  Task_80993_Desc = {
    Text = "Outils de nettoyage obtenus"
  },
  Task_80994_Desc = {
    Text = "Terminer 3 missions au choix"
  },
  Task_80994_Name = {
    Text = "Nettoyage d'aujourd'hui terminé !"
  },
  Task_80995_Desc = {
    Text = "Récompense de l'activité"
  },
  Task_80996_Desc = {
    Text = "Outils de nettoyage obtenus"
  },
  Task_80997_Desc = {
    Text = "Consommez 100 000 roses dorées"
  },
  Task_80997_Name = {
    Text = "Tri du sac à dos"
  },
  Task_80998_Desc = {
    Text = "Outils de nettoyage acquis"
  },
  Task_80999_Desc = {
    Text = "Outils de nettoyage acquis"
  },
  Task_81000_Desc = {
    Text = "Connexion cumulative pendant 6 jours"
  },
  Task_81001_Desc = {
    Text = "Terminer n'importe quelle opération d'enquête 1 fois"
  },
  Task_81001_Name = {
    Text = "Nettoyer les souvenirs"
  },
  Task_81002_Desc = {
    Text = "Connecte-toi pendant 3 jours cumulés"
  },
  Task_81003_Desc = {
    Text = "Outils de nettoyage obtenus"
  },
  Task_81004_Desc = {
    Text = "Outils de nettoyage acquis"
  },
  Task_81005_Desc = {
    Text = "Outils de nettoyage atteints"
  },
  Task_81006_Desc = {
    Text = "Mission d'activité"
  },
  Task_81007_Desc = {
    Text = "Complétez une fois le traphase"
  },
  Task_81007_Name = {
    Text = "Désinfection dimensionnelle"
  },
  Task_81008_Desc = {
    Text = "Connecte-toi pendant 5 jours cumulés"
  },
  Task_81009_Desc = {
    Text = "Connectez-vous pendant un total de 7 jours"
  },
  Task_81010_Desc = {
    Text = "Outils de nettoyage acquis"
  },
  Task_81011_Desc = {
    Text = "Connexion cumulative pendant 1 jour"
  },
  Task_81012_Desc = {
    Text = "Connectez-vous pendant un total de 4 jours"
  },
  Task_81013_Desc = {
    Text = "Connectez-vous pendant un total de 2 jours"
  },
  Task_81014_Desc = {
    Text = "Outils de nettoyage obtenus"
  },
  Task_81015_Desc = {
    Text = "Outils de nettoyage acquis"
  },
  Task_81016_Desc = {
    Text = "Consommez 180 menophin dans les Ruines de l'érosion"
  },
  Task_81016_Name = {
    Text = "Nettoyage de la corrosion"
  },
  Task_81017_Desc = {
    Text = "7 jours de connexion"
  },
  Task_81018_Desc = {
    Text = "Terminer une fois la plongée fantomale"
  },
  Task_81018_Name = {
    Text = "Ventilation du Rêve"
  },
  Task_81083_Desc = {
    Text = "Dérive abyssale · Folie"
  },
  Task_81084_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Chant funèbre final »"
  },
  Task_81085_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter 2 victoires dans «Mystère des abysses»"
  },
  Task_81086_Desc = {
    Text = "Terminer n'importe quelle difficulté de \"Boussole usée\""
  },
  Task_81087_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter une victoire dans «Mystère des abysses»"
  },
  Task_81088_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Chant funèbre final »"
  },
  Task_81089_Desc = {
    Text = "Terminer « Manuel du navigateur » à la difficulté Folie"
  },
  Task_81090_Desc = {
    Text = "Terminer « Lumière guide » à la difficulté Folie"
  },
  Task_81091_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter 2 victoires dans «Mystère des abysses»"
  },
  Task_81092_Desc = {
    Text = "Terminer « Sextant ancien » à la difficulté Folie"
  },
  Task_81093_Desc = {
    Text = "Parcourir Le vagabond « Dernière balise »"
  },
  Task_81094_Desc = {
    Text = "Terminer difficulté Folie de « Boussole usée »"
  },
  Task_81095_Desc = {
    Text = "Terminer « Lumière de pilotage » à n'importe quelle difficulté"
  },
  Task_81096_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Boussole usée »"
  },
  Task_81097_Desc = {
    Text = "Terminez tous les succès de « Mystère des abysses · Terminé »"
  },
  Task_81098_Desc = {
    Text = "Terminer « Lumière guide » à n'importe quelle difficulté"
  },
  Task_81099_Desc = {
    Text = "Terminer « Trajectoire des étoiles » à la difficulté Folie"
  },
  Task_81100_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Trajectoire des étoiles»"
  },
  Task_81101_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Langage des drapeaux de signalisation»"
  },
  Task_81102_Desc = {
    Text = "Terminer « Langage des drapeaux de signalisation » à n'importe quelle difficulté"
  },
  Task_81103_Desc = {
    Text = "Terminer n'importe quelle difficulté de \"Sextant ancien\""
  },
  Task_81104_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Carte marine ancienne»"
  },
  Task_81105_Desc = {
    Text = "Terminer « Langage des drapeaux de signalisation » à la difficulté Folie"
  },
  Task_81106_Desc = {
    Text = "Terminer « Manuel du navigateur » à n'importe quelle difficulté"
  },
  Task_81107_Desc = {
    Text = "Complétez « Manuel du navigateur » à n'importe quelle difficulté"
  },
  Task_81108_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Disque céleste tacheté »"
  },
  Task_81109_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter une victoire dans «Mystère des abysses»"
  },
  Task_81110_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter une victoire dans «Mystère des abysses»"
  },
  Task_81111_Desc = {
    Text = "Terminer difficulté Folie de « Élément Final »"
  },
  Task_81112_Desc = {
    Text = "Mystère des abysses · Terminé"
  },
  Task_81113_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Trajectoire des étoiles »"
  },
  Task_81114_Desc = {
    Text = "Terminer n'importe quelle difficulté de \"Carte marine ancienne\""
  },
  Task_81115_Desc = {
    Text = "Terminer « Carte marine ancienne » à la difficulté Folie"
  },
  Task_81116_Desc = {
    Text = "Terminer « Disque céleste tacheté » à la difficulté Folie"
  },
  Task_81117_Desc = {
    Text = "Terminer n'importe quelle difficulté de \"Sextant ancien\""
  },
  Task_81118_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Disque céleste tacheté »"
  },
  Task_81119_Desc = {
    Text = "Mystère des abysses·Domaine"
  },
  Task_81120_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 2 victoires dans «Mystère des abysses»"
  },
  Task_81121_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter 2 fois dans «Mystère des abysses»"
  },
  Task_81122_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 1 victoire dans «Mystère des abysses»"
  },
  Task_81481_Desc = {
    Text = "Vaincre «Projection dimensionnelle@2 de l'univers» sans l'aide de Circuit - Ramona."
  },
  Task_81481_Name = {
    Text = "Écouter le bourdonnement de l'univers · Cacher"
  },
  Task_81772_Name = {
    Text = "Vaincre le BOSS 1 N fois"
  },
  Task_81773_Name = {
    Text = "Vaincre le BOSS 7 N fois"
  },
  Task_81774_Name = {
    Text = "Vaincre Tous les Boss"
  },
  Task_81775_Name = {
    Text = "Vaincre le BOSS 3 N fois"
  },
  Task_81776_Name = {
    Text = "Vaincre le BOSS 2 N fois"
  },
  Task_81777_Name = {
    Text = "Vaincre le BOSS 6 N fois"
  },
  Task_81778_Name = {
    Text = "Vaincre le BOSS 4 N fois"
  },
  Task_81779_Name = {
    Text = "Vaincre BOSS 5 fois"
  },
  Task_84111_Name = {
    Text = "Rejouer le niveau secondaire normal 4 de Kepsante"
  },
  Task_84143_Desc = {
    Text = "Connexion cumulative pendant 2 jours"
  },
  Task_84144_Desc = {
    Text = "Connexion totale de 3 jours"
  },
  Task_84145_Desc = {
    Text = "Connexion cumulative pendant 2 jours"
  },
  Task_84146_Desc = {
    Text = "Connexion totale de 5 jours"
  },
  Task_84147_Desc = {
    Text = "Connexion totale de 8 jours"
  },
  Task_84148_Desc = {
    Text = "Connexion cumulative pendant 2 jours"
  },
  Task_84149_Desc = {
    Text = "Connexion totale de 5 jours"
  },
  Task_84150_Desc = {
    Text = "Connexion totale de 10 jours"
  },
  Task_84151_Desc = {
    Text = "Connexion totale de 5 jours"
  },
  Task_84152_Desc = {
    Text = "Connexion totale de 10 jours"
  },
  Task_84153_Desc = {
    Text = "Connexion totale de 4 jours"
  },
  Task_84154_Desc = {
    Text = "Connexion totale de 9 jours"
  },
  Task_84155_Desc = {
    Text = "Connexion totale de 3 jours"
  },
  Task_84156_Desc = {
    Text = "Connexion totale de 6 jours"
  },
  Task_84157_Desc = {
    Text = "Connexion cumulative pendant 2 jours"
  },
  Task_84158_Desc = {
    Text = "Connexion totale de 4 jours"
  },
  Task_84159_Desc = {
    Text = "Connexion totale de 3 jours"
  },
  Task_84160_Desc = {
    Text = "Connexion totale de 1 jour"
  },
  Task_84161_Desc = {
    Text = "Connexion Cumulative de 7 Jours"
  },
  Task_84162_Desc = {
    Text = "Connexion totale de 5 jours"
  },
  Task_84163_Desc = {
    Text = "Connexion totale de 1 jour"
  },
  Task_84164_Desc = {
    Text = "Connexion totale de 1 jour"
  },
  Task_84165_Desc = {
    Text = "Connexion totale de 8 jours"
  },
  Task_84166_Desc = {
    Text = "Connexion Cumulative de 7 Jours"
  },
  Task_84167_Desc = {
    Text = "Connexion totale de 4 jours"
  },
  Task_84168_Desc = {
    Text = "Connexion totale de 6 jours"
  },
  Task_84169_Desc = {
    Text = "Connexion totale de 4 jours"
  },
  Task_84170_Desc = {
    Text = "Connexion totale de 9 jours"
  },
  Task_84171_Desc = {
    Text = "Connexion totale de 1 jour"
  },
  Task_84172_Desc = {
    Text = "Connexion totale de 3 jours"
  },
  Task_84323_Desc = {
    Text = "Obtenez un total de 3 victoires cette saiso"
  },
  Task_84323_Name = {
    Text = "3 Victoires"
  },
  Task_84324_Desc = {
    Text = "Obtenez un total de 6 victoires cette saiso"
  },
  Task_84324_Name = {
    Text = "6 victoires"
  },
  Task_84325_Desc = {
    Text = "Obtenez 1 victoire cette saiso"
  },
  Task_84325_Name = {Text = "1 Victoire"},
  Task_84326_Desc = {
    Text = "Obtenez 10 victoires cette saiso"
  },
  Task_84326_Name = {
    Text = "10 Victoires"
  },
  Task_84349_Desc = {
    Text = "Compléter l'errance de conscience \"La dernière navigation\""
  },
  Task_84349_Name = {
    Text = "Voix des étoiles et de l'abîme"
  },
  Task_88945_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Briser la cage »"
  },
  Task_88946_Desc = {
    Text = "Terminer le niveau Paysage de rêve « Au-delà de l'horizon · I »"
  },
  Task_88947_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 2 fois dans « Ciel bleu - Bond »"
  },
  Task_88948_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Voyage solitaire»"
  },
  Task_88949_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter une victoire dans «Ciel bleu·Bond»"
  },
  Task_88950_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter une victoire dans « Ciel bleu·Bond »"
  },
  Task_88951_Desc = {
    Text = "Terminer «Porteur de la Chandelle» en toute difficulté"
  },
  Task_88952_Desc = {
    Text = "Terminer « Briser la cage » en difficulté Folie"
  },
  Task_88953_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Briser la cage »"
  },
  Task_88954_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter une victoire dans « Ciel bleu · Bond »"
  },
  Task_88955_Desc = {
    Text = "Terminer « Liberté et Mort » en difficulté Folie"
  },
  Task_88956_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Voyage solitaire »"
  },
  Task_88957_Desc = {
    Text = "Envole-toi dans le ciel bleu · Folie"
  },
  Task_88958_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Liberté et Mort »"
  },
  Task_88959_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Liberté et Mort »"
  },
  Task_88960_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Sable Infini»"
  },
  Task_88961_Desc = {
    Text = "Terminer tous les succès de « Envole-toi vers le ciel azur · Terminer »"
  },
  Task_88962_Desc = {
    Text = "Terminer «Messager de la bougie» en toute difficulté"
  },
  Task_88963_Desc = {
    Text = "Terminer difficulté Folie de «Sable Infini»"
  },
  Task_88964_Desc = {
    Text = "Terminer « Fou » en difficulté Folie"
  },
  Task_88965_Desc = {
    Text = "Terminer « Rêve d'Hier » à la difficulté Folie"
  },
  Task_88966_Desc = {
    Text = "Terminer « Voyage Solitaire » en difficulté Folie"
  },
  Task_88967_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter 2 fois dans « Bond dans le ciel bleu »"
  },
  Task_88968_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Rêve d'hier »"
  },
  Task_88969_Desc = {
    Text = "Envole-toi dans le ciel bleu · Domaine"
  },
  Task_88970_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter 2 victoires dans « Ciel bleu·Bond »"
  },
  Task_88971_Desc = {
    Text = "Envole-toi vers le ciel azur · Terminer"
  },
  Task_88972_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Sable Infini»"
  },
  Task_88973_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter une victoire dans « Ciel bleu·Bond »"
  },
  Task_88974_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Le Fou »"
  },
  Task_88975_Desc = {
    Text = "Terminer « Messager de la Bougie » à la difficulté Folie"
  },
  Task_88976_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter 2 victoires dans « Ciel bleu·Bond »"
  },
  Task_88977_Desc = {
    Text = "Terminer \"Rêve d'hier\" en toute difficulté"
  },
  Task_88978_Desc = {
    Text = "Terminer n'importe quelle difficulté de «L'Ignorant»"
  },
  Task_89577_Desc = {
    Text = "Connexion Cumulative : 12 Jours"
  },
  Task_89578_Desc = {
    Text = "Connectez-vous pendant un total de 15 jours"
  },
  Task_89579_Desc = {
    Text = "Connectez-vous pendant un total de 2 jours"
  },
  Task_89580_Desc = {
    Text = "Connectez-vous pendant un total de 10 jours"
  },
  Task_89581_Desc = {
    Text = "Connexion Cumulative : 11 Jours"
  },
  Task_89582_Desc = {
    Text = "Connecte-toi pendant 3 jours cumulés"
  },
  Task_89583_Desc = {
    Text = "Connexion cumulative pendant 6 jours"
  },
  Task_89584_Desc = {
    Text = "Connecté pendant un total de 16 jours"
  },
  Task_89585_Desc = {
    Text = "Connectez-vous pendant un total de 4 jours"
  },
  Task_89586_Desc = {
    Text = "Connexion cumulative pendant 1 jour"
  },
  Task_89587_Desc = {
    Text = "Connectez-vous pendant un total de 7 jours"
  },
  Task_89588_Desc = {
    Text = "Connexion cumulative de 14 jours"
  },
  Task_89589_Desc = {
    Text = "Connectez-vous pendant un total de 8 jours"
  },
  Task_89590_Desc = {
    Text = "Connecte-toi pendant 5 jours cumulés"
  },
  Task_89591_Desc = {
    Text = "Connexion Cumulative : 13 Jours"
  },
  Task_89592_Desc = {
    Text = "Connecté pendant un total de 9 jours"
  },
  Task_89844_Desc = {
    Text = "Premier éveil du pacte de la trajectoire fatale ({s1}/1)"
  },
  Task_89844_Name = {
    Text = "Terminer la mission pour recevoir un bon de façonnage d'Illusion"
  },
  Task_89845_Desc = {
    Text = "7 jours de connexion ({s1}/7)"
  },
  Task_89845_Name = {
    Text = "Terminer la mission pour recevoir un bon de façonnage d'Illusion"
  },
  Task_89846_Desc = {
    Text = "Repousser le banc de marées altérées ({s1}/30)"
  },
  Task_89846_Name = {
    Text = "Terminer la mission pour recevoir un bon de façonnage « Illusion »"
  },
  Task_90036_Desc = {
    Text = "Obtenez un total de 6 victoires cette saiso"
  },
  Task_90036_Name = {
    Text = "6 victoires"
  },
  Task_90037_Desc = {
    Text = "Obtenez un total de 3 victoires cette saiso"
  },
  Task_90037_Name = {
    Text = "3 Victoires"
  },
  Task_90038_Desc = {
    Text = "Obtenez 10 victoires cette saiso"
  },
  Task_90038_Name = {
    Text = "10 Victoires"
  },
  Task_90039_Desc = {
    Text = "Obtenez 1 victoire cette saiso"
  },
  Task_90039_Name = {Text = "1 Victoire"},
  Task_90495_Desc = {
    Text = "Terminer Enseignement pratique · Pensées du Chaos"
  },
  Task_90495_Name = {
    Text = "Idéation du Chaos"
  },
  Task_90866_Desc = {
    Text = "Texte temporaire I"
  },
  Task_90867_Desc = {
    Text = "Art des Vœux Infinis I"
  },
  Task_90868_Desc = {
    Text = "Texte Temporaire · Gratuit"
  },
  Task_90869_Desc = {
    Text = "Élégie du crâne VII"
  },
  Task_90870_Desc = {
    Text = "Texte Temporaire IV"
  },
  Task_90871_Desc = {
    Text = "Destin conjugué III"
  },
  Task_90872_Desc = {
    Text = "Élégie du crâne I"
  },
  Task_90873_Desc = {
    Text = "Art des Vœux Infinis V"
  },
  Task_90874_Desc = {
    Text = "Texte temporaire VI"
  },
  Task_90875_Desc = {
    Text = "Texte Temporaire I"
  },
  Task_90876_Desc = {
    Text = "Texte temporaire · Gratuit"
  },
  Task_90877_Desc = {
    Text = "Élégie du crâne - Gratuit"
  },
  Task_90878_Desc = {
    Text = "Élégie du crâne VI"
  },
  Task_90879_Desc = {
    Text = "Art des Vœux Infinis IV"
  },
  Task_90880_Desc = {
    Text = "Art des Vœux Infinis : Gratuit"
  },
  Task_90881_Desc = {
    Text = "Élégie du crâne III"
  },
  Task_90882_Desc = {
    Text = "Destin conjugué II"
  },
  Task_90883_Desc = {
    Text = "Texte Temporaire V"
  },
  Task_90884_Desc = {
    Text = "Élégie du crâne V"
  },
  Task_90885_Desc = {
    Text = "Texte Temporaire VI"
  },
  Task_90886_Desc = {
    Text = "Texte Temporaire VII"
  },
  Task_90887_Desc = {
    Text = "Destin conjugué VI"
  },
  Task_90888_Desc = {
    Text = "Destin conjugué IV"
  },
  Task_90889_Desc = {
    Text = "Élégie du crâne IV"
  },
  Task_90890_Desc = {
    Text = "Destin conjugué V"
  },
  Task_90891_Desc = {
    Text = "Destin Conjugué I"
  },
  Task_90892_Desc = {
    Text = "Art des Vœux Infinis III"
  },
  Task_90893_Desc = {
    Text = "Texte temporaire II"
  },
  Task_90894_Desc = {
    Text = "Texte Temporaire III"
  },
  Task_90895_Desc = {
    Text = "Destin Conjugué VII"
  },
  Task_90896_Desc = {
    Text = "Élégie du crâne II"
  },
  Task_90897_Desc = {
    Text = "Texte temporaire VII"
  },
  Task_90898_Desc = {
    Text = "Texte temporaire V"
  },
  Task_90899_Desc = {
    Text = "Texte temporaire IV"
  },
  Task_90900_Desc = {
    Text = "Art des Vœux Infinis VI"
  },
  Task_90901_Desc = {
    Text = "Destin conjugué·Gratuit"
  },
  Task_90902_Desc = {
    Text = "Art des Vœux Infinis II"
  },
  Task_90903_Desc = {
    Text = "Texte temporaire III"
  },
  Task_90904_Desc = {
    Text = "Art des Vœux Infinis VII"
  },
  Task_90905_Desc = {
    Text = "Texte Temporaire II"
  },
  Task_91028_Desc = {
    Text = "Terminer « Couronne du Héros » à la difficulté Folie"
  },
  Task_91029_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter une victoire dans « Chasse divine »"
  },
  Task_91030_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter une victoire dans « Chasse divine »"
  },
  Task_91031_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter une victoire dans « Chasse divine »"
  },
  Task_91032_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter 2 victoires dans « Chasse divine »"
  },
  Task_91033_Desc = {
    Text = "Chasse sacrée · Terminer un niveau"
  },
  Task_91034_Desc = {
    Text = "Terminer n'importe quelle difficulté de \"Chasseur Féroce\""
  },
  Task_91035_Desc = {
    Text = "Chasse sacrée · Folie"
  },
  Task_91036_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Corne d'expédition»"
  },
  Task_91037_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Sagesse de collaboration »"
  },
  Task_91038_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter 2 victoires dans « Chasse divine »"
  },
  Task_91039_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter 2 victoires dans « Chasse divine »"
  },
  Task_91040_Desc = {
    Text = "Terminer le paysage de rêve « Notes de la cuisine en chantier »"
  },
  Task_91041_Desc = {
    Text = "Terminer «Couronne du Héros» en toute difficulté"
  },
  Task_91042_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Couronne du Héros »"
  },
  Task_91043_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter une victoire dans « Chasse divine »"
  },
  Task_91044_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Retour triomphal»"
  },
  Task_91045_Desc = {
    Text = "Terminer n'importe quelle difficulté de \"Chasseur féroce\""
  },
  Task_91046_Desc = {
    Text = "Terminer « Sagesse collaborative » en difficulté Folie"
  },
  Task_91047_Desc = {
    Text = "Terminer « Corne d'expédition » à n'importe quelle difficulté"
  },
  Task_91048_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Sagesse de collaboration »"
  },
  Task_91049_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Retour triomphal»"
  },
  Task_91050_Desc = {
    Text = "Terminer tous les succès de « Chasse sacrée · Évaluation »"
  },
  Task_91051_Desc = {
    Text = "Terminer « Corne d'expédition » en difficulté Folie"
  },
  Task_91052_Desc = {
    Text = "Terminer « Triomphe Glorieux » en difficulté Folie"
  },
  Task_91053_Desc = {
    Text = "Chasse sacrée · Royaume"
  },
  Task_91054_Desc = {
    Text = "Terminer « Chasseur Féroce » en difficulté Folie"
  },
  Task_91055_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 2 victoires dans « Chasse divine »"
  },
  Task_91129_Desc = {
    Text = "Niveau atteint : niveau 20"
  },
  Task_91131_Desc = {
    Text = "Niveau 5 atteint"
  },
  Task_91149_Desc = {
    Text = "Niveau atteint : niveau 15"
  },
  Task_91154_Desc = {
    Text = "Niveau atteint : 10"
  },
  Task_91332_Desc = {
    Text = "Vaincre Dulcain"
  },
  Task_91332_Name = {Text = "Objectif"},
  Task_91333_Desc = {
    Text = "Repousser les envahisseurs"
  },
  Task_91333_Name = {Text = "Objectif"},
  Task_91334_Desc = {
    Text = "Vaincre la « Marionnette de la marée corrompue », protéger la Citadelle des Ossements"
  },
  Task_91334_Name = {Text = "Objectif"},
  Task_91335_Desc = {
    Text = "Vaincre le Marin"
  },
  Task_91335_Name = {Text = "Objectif"},
  Task_91336_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_91336_Name = {
    Text = "Passer Parfait"
  },
  Task_91337_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_91337_Name = {
    Text = "Passer Parfait"
  },
  Task_91338_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_91338_Name = {
    Text = "Passer Parfait"
  },
  Task_91339_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_91339_Name = {
    Text = "Passer Parfait"
  },
  Task_91340_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_91340_Name = {
    Text = "Passer Parfait"
  },
  Task_91341_Desc = {
    Text = "Détruire les «tableaux» de Pickman"
  },
  Task_91341_Name = {Text = "Objectif"},
  Task_91342_Desc = {
    Text = "Éliminer les ennemis et pénétrer dans la cité royale des goules"
  },
  Task_91342_Name = {Text = "Objectif"},
  Task_91343_Desc = {
    Text = "Échapper à la poursuite de la goule"
  },
  Task_91343_Name = {Text = "Objectif"},
  Task_91344_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_91344_Name = {
    Text = "Passer Parfait"
  },
  Task_91345_Desc = {
    Text = "Éliminer le corps corrodé"
  },
  Task_91345_Name = {Text = "Objectif"},
  Task_91346_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_91346_Name = {
    Text = "Passer Parfait"
  },
  Task_91347_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_91347_Name = {
    Text = "Passer Parfait"
  },
  Task_91348_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_91348_Name = {
    Text = "Passer Parfait"
  },
  Task_91349_Desc = {
    Text = "Repousser Goliath et détruire le Cercle magique"
  },
  Task_91349_Name = {Text = "Objectif"},
  Task_91350_Desc = {
    Text = "Complétez sans déclencher la Gnose d'Urgence"
  },
  Task_91350_Name = {
    Text = "Passer Parfait"
  },
  Task_91351_Desc = {
    Text = "Vaincre le majordome Fran"
  },
  Task_91351_Name = {Text = "Objectif"},
  Task_91357_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_91358_Desc = {
    Text = "Terminer le chapitre 3 du Chapitre des Étoiles - niveau 3-5"
  },
  Task_91359_Desc = {
    Text = "Compléter l'événement d'investigation \"@1@2\""
  },
  Task_91359_Desc2 = {
    Text = "Complétez l'événement d'investigation \"Festin\""
  },
  Task_91359_Name = {Text = "@2@3"},
  Task_91359_Name2 = {
    Text = "Repas partagé entre os et âme"
  },
  Task_91360_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_91361_Desc = {
    Text = "Terminer le chapitre 3 du Chapitre des Étoiles (3-5) en difficulté difficile"
  },
  Task_91362_Desc = {
    Text = "Terminer le chapitre 3 du Chapitre des Étoiles « Banquet » en difficulté difficile"
  },
  Task_91363_Desc = {
    Text = "Terminer l'événement d'enquête « Banquet » en difficulté difficile"
  },
  Task_91363_Name = {
    Text = "Repas partagé entre os et âme · Difficile"
  },
  Task_91364_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_91365_Desc = {
    Text = "Terminer le chapitre 3 du «Chapitre des Étoiles» «Friandise»"
  },
  Task_91366_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_91367_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_91368_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_91370_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_91371_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_91372_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_91373_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_91379_Desc = {
    Text = "Terminer le chapitre 2-5 du Chapitre des Étoiles, chapitre 3, en difficulté difficile"
  },
  Task_91380_Desc = {
    Text = "Terminer le chapitre 3 du Chapitre des Étoiles - niveau 2-5"
  },
  Task_91381_Desc = {
    Text = "Terminer le chapitre 3 du Chapitre des Étoiles « Banquet » en difficulté difficile"
  },
  Task_91382_Desc = {
    Text = "Terminer le chapitre 3 du «Chapitre des Étoiles» «Friandise»"
  },
  Task_91436_Desc = {
    Text = "Obtenez 1 victoire cette saiso"
  },
  Task_91436_Name = {Text = "1 Victoire"},
  Task_91437_Desc = {
    Text = "Obtenez un total de 3 victoires cette saiso"
  },
  Task_91437_Name = {
    Text = "3 Victoires"
  },
  Task_91438_Desc = {
    Text = "Obtenez un total de 6 victoires cette saiso"
  },
  Task_91438_Name = {
    Text = "6 victoires"
  },
  Task_91439_Desc = {
    Text = "Obtenez 10 victoires cette saiso"
  },
  Task_91439_Name = {
    Text = "10 Victoires"
  },
  Task_91720_Desc = {
    Text = "7 jours de connexion ({s1}/7)"
  },
  Task_91720_Name = {
    Text = "Terminer la mission pour recevoir un bon de façonnage d'Illusion"
  },
  Task_91721_Desc = {
    Text = "Terminer toutes les difficultés Folie ({s1}/5)"
  },
  Task_91721_Name = {
    Text = "Terminer la mission pour recevoir un bon de façonnage d'Illusion"
  },
  Task_91786_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter 2 victoires dans « Naissance du Royaume divin »"
  },
  Task_91787_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 2 victoires dans « Naissance du Royaume divin »"
  },
  Task_91788_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter 2 victoires dans « Naissance du Royaume divin »"
  },
  Task_91789_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter 2 victoires dans « Naissance du Royaume divin »"
  },
  Task_94489_Desc = {
    Text = "Élever six personnages du chaos au niveau 80"
  },
  Task_94489_Name = {
    Text = "Maîtrise des domaines X"
  },
  Task_94490_Desc = {
    Text = "Élever six personnages des profondeurs au niveau 70"
  },
  Task_94490_Name = {
    Text = "Maîtrise des domaines IX"
  },
  Task_94491_Desc = {
    Text = "Élever six personnages transdimensionnels au niveau 70"
  },
  Task_94491_Name = {
    Text = "Maîtrise des domaines IX"
  },
  Task_94492_Desc = {
    Text = "Élever six personnages de la chair au niveau 80"
  },
  Task_94492_Name = {
    Text = "Maîtrise des domaines X"
  },
  Task_94493_Desc = {
    Text = "Élever six personnages des profondeurs au niveau 80"
  },
  Task_94493_Name = {
    Text = "Maîtrise des domaines X"
  },
  Task_94494_Desc = {
    Text = "Élever six personnages de la chair au niveau 70"
  },
  Task_94494_Name = {
    Text = "Maîtrise des domaines IX"
  },
  Task_94495_Desc = {
    Text = "Élever six personnages du chaos au niveau 70"
  },
  Task_94495_Name = {
    Text = "Maîtrise des domaines IX"
  },
  Task_94496_Desc = {
    Text = "Élever six personnages transdimensionnels au niveau 80"
  },
  Task_94496_Name = {
    Text = "Maîtrise des domaines X"
  },
  Task_94497_Desc = {
    Text = "Complète toutes les tâches dans ce chapitre pour réclamer des récompenses."
  },
  Task_94497_Name = {
    Text = "Maîtrise des domaines X"
  },
  Task_94498_Desc = {
    Text = "Complète toutes les tâches dans ce chapitre pour réclamer des récompenses."
  },
  Task_94498_Name = {
    Text = "Maîtrise des domaines IX"
  },
  Task_94613_Desc = {
    Text = "Terminer Enseignement pratique · Labyrinthe Ultra"
  },
  Task_94613_Name = {
    Text = "Le Royaume ultradimensionnel"
  },
  Task_94614_Desc = {
    Text = "Terminer Enseignement pratique · Colonie de Chair"
  },
  Task_94614_Name = {
    Text = "Propagation de la Chair"
  },
  Task_94615_Desc = {
    Text = "Terminer Enseignement pratique · Toucher de l'Aequor"
  },
  Task_94615_Name = {
    Text = "Toucher de l'Aequor"
  },
  Task_94699_Desc = {
    Text = "Élégie du crâne · Édition limitée exclusive"
  },
  Task_94861_Desc = {
    Text = "Consommez 1 800 points de menophin"
  },
  Task_94863_Desc = {
    Text = "Réveillé cumulativement 100 fois"
  },
  Task_94865_Desc = {
    Text = "Utilisez le soutien 3 fois"
  },
  Task_94867_Desc = {
    Text = "Valeur d'entraînement spécial de fusion atteinte à 100"
  },
  Task_94871_Desc = {
    Text = "Terminer 1 fois le niveau d'essai de Kattygura"
  },
  Task_94874_Desc = {
    Text = "Terminer 2 épreuves hebdomadaires consécutives"
  },
  Task_94876_Desc = {
    Text = "Consommez 1 800 points de menophin"
  },
  Task_94877_Desc = {
    Text = "Complétez 20 Missions"
  },
  Task_94882_Desc = {
    Text = "Connexion cumulative pendant 1 jour"
  },
  Task_94885_Desc = {
    Text = "Terminer 2 épreuves hebdomadaires"
  },
  Task_94886_Desc = {
    Text = "Terminer 1 fois le niveau d'essai de Katigora"
  },
  Task_94888_Desc = {
    Text = "Utilisez le soutien 3 fois"
  },
  Task_94891_Desc = {
    Text = "Connexion cumulative pendant 1 jour"
  },
  Task_94895_Desc = {
    Text = "Valeur d'entraînement spécial de fusion atteinte à 100"
  },
  Task_94898_Desc = {
    Text = "Réveillé cumulativement 100 fois"
  },
  Task_94901_Desc = {
    Text = "Complétez 20 Missions"
  },
  Task_95192_Desc = {
    Text = "Terminer « Soleil de la Surface » à la difficulté Folie"
  },
  Task_95193_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter 2 fois dans « Extermination »"
  },
  Task_95194_Desc = {
    Text = "Terminer n'importe quelle difficulté de \"Monde silencieux\""
  },
  Task_95195_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 1 victoire dans « Extermination »"
  },
  Task_95196_Desc = {
    Text = "Réussir l'épreuve de conscience « Le jour éternel »"
  },
  Task_95197_Desc = {
    Text = "Terminer n'importe quelle difficulté d'«Objectif de contrat»"
  },
  Task_95198_Desc = {
    Text = "Terminer « Monde silencieux » en difficulté Folie"
  },
  Task_95199_Desc = {
    Text = "Terminer n'importe quelle difficulté d'«Objectif de contrat»"
  },
  Task_95200_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Soleil de la Surface»"
  },
  Task_95201_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Arrêt de feu ardent »"
  },
  Task_95202_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter une victoire dans « Extermination »"
  },
  Task_95203_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Serment éternel»"
  },
  Task_95204_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Jugement Ardent»"
  },
  Task_95205_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter une victoire dans « Extermination »"
  },
  Task_95206_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 2 victoires dans « Extermination »"
  },
  Task_95207_Desc = {
    Text = "Terminer « Lueur du monde renversé » à n'importe quelle difficulté"
  },
  Task_95208_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Soleil de la Surface»"
  },
  Task_95209_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter une victoire dans « Extermination »"
  },
  Task_95210_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter 2 victoires dans « Extermination »"
  },
  Task_95211_Desc = {
    Text = "Terminer « Jugement ardent » à la difficulté Folie"
  },
  Task_95212_Desc = {
    Text = "Chasse des cendres éteintes · Folie"
  },
  Task_95213_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter 2 fois dans « Extermination »"
  },
  Task_95214_Desc = {
    Text = "Terminer difficulté Folie de «Contrat : Objectif»"
  },
  Task_95215_Desc = {
    Text = "Terminer n'importe quelle difficulté de \"Monde silencieux\""
  },
  Task_95216_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Lueur du monde renversé »"
  },
  Task_95217_Desc = {
    Text = "Chasse des cendres éteintes · Royaume"
  },
  Task_95218_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Chant du pèlerin »"
  },
  Task_95219_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Serment éternel»"
  },
  Task_95220_Desc = {
    Text = "Terminer difficulté Folie de « Serment ancien »"
  },
  Task_95221_Desc = {
    Text = "Terminer « Lueur du monde renversé » à la difficulté Folie"
  },
  Task_95222_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Chant du pèlerin »"
  },
  Task_95223_Desc = {
    Text = "Terminer tous les succès de « Chasse des cendres éteintes · Passer »"
  },
  Task_95224_Desc = {
    Text = "Terminer difficulté Folie de « Chant du Purgatoire »"
  },
  Task_95225_Desc = {
    Text = "Chasse des cendres éteintes · Terminer"
  },
  Task_95470_Desc = {Text = "Vaincre N"},
  Task_95470_Name = {Text = "Objectif"},
  Task_95520_Desc = {
    Text = "Extraction cumulée de 16000 argent primordiale"
  },
  Task_95521_Desc = {
    Text = "Extraction cumulée de 25000 liquide primordial"
  },
  Task_95522_Desc = {
    Text = "Extraction cumulée de 13 000 liquide primordial"
  },
  Task_95523_Desc = {
    Text = "Extraction cumulée de 8000 argent primordiale"
  },
  Task_95524_Desc = {
    Text = "Extraction cumulée de 2000 argent primordiale"
  },
  Task_95525_Desc = {
    Text = "Extraction cumulée de 20 000 argent primordial"
  },
  Task_95526_Desc = {
    Text = "Extraction cumulée de 4000 liquide primordial"
  },
  Task_95527_Desc = {
    Text = "Extraction cumulée de 5000 liquide primordial"
  },
  Task_95532_Desc = {
    Text = "Souvenirs du jardin · Folie"
  },
  Task_95533_Desc = {
    Text = "Terminer « Cendres » en difficulté Folie"
  },
  Task_95534_Desc = {
    Text = "Terminer « Petit Royaume » en difficulté Folie"
  },
  Task_95535_Desc = {
    Text = "Terminer « Première Rose » en difficulté Folie"
  },
  Task_95536_Desc = {
    Text = "Terminer « Main dans la main » en difficulté Folie"
  },
  Task_95537_Desc = {
    Text = "Terminer la difficulté Folie de « Poème Épanoui »"
  },
  Task_95543_Desc = {
    Text = "Compléter \"La Première Rose\" en n'importe quelle difficulté"
  },
  Task_95544_Desc = {
    Text = "Terminez \"Holding Hands\" en toute difficulté"
  },
  Task_95545_Desc = {
    Text = "Compléter \"Le Poème de la Floraison\" en n'importe quelle difficulté"
  },
  Task_95546_Desc = {
    Text = "Clear \"Ashes\" en n'importe quelle difficulté"
  },
  Task_95547_Desc = {
    Text = "Terminez \"Tiny Kingdom\" en toute difficulté"
  },
  Task_95830_Desc = {
    Text = "Friandise de l'âme · Domaine"
  },
  Task_95831_Desc = {
    Text = "Terminer difficulté Folie de «Flamme de l'Âme Perdue»"
  },
  Task_95832_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Parfum d'humus»"
  },
  Task_95833_Desc = {
    Text = "Terminer « Parfum d'humus » en difficulté Folie"
  },
  Task_95834_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Ouverture du cercueil funéraire »"
  },
  Task_95835_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter 2 fois dans «Festin des esprits»"
  },
  Task_95836_Desc = {
    Text = "Obtenez Durel en illuminant 2"
  },
  Task_95836_Name = {
    Text = "Obtenez Durellye à l'illumination 2"
  },
  Task_95836_UnlockCondDesc = {
    Text = "Événement @ Pack d'illumination de Dulersein le réveilleur 2 événement"
  },
  Task_95837_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_95838_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_95839_Desc = {
    Text = "Terminer n'importe quelle difficulté de \"Ouverture du cercueil funéraire\""
  },
  Task_95840_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 1 victoire dans «Festin des esprits»"
  },
  Task_95841_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter une victoire dans « Festin des esprits »"
  },
  Task_95842_Desc = {
    Text = "Terminer « Séparation de la chair et du sang » en difficulté Folie"
  },
  Task_95843_Desc = {
    Text = "Terminer « Banquet du Sanctuaire » en difficulté Folie"
  },
  Task_95844_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Flamme des morts brûlant l'âme»"
  },
  Task_95845_Desc = {
    Text = "Terminer n'importe quelle difficulté de \"Flamme des morts brûlant l'âme\""
  },
  Task_95846_Desc = {
    Text = "Dursain atteint le niveau 10 d'affinité"
  },
  Task_95847_Desc = {
    Text = "Friandise de l'esprit·passage"
  },
  Task_95848_Desc = {
    Text = "Terminer toutes les missions de « Friandise de l'esprit · Passage »"
  },
  Task_95849_Desc = {
    Text = "Terminer « Ouverture du cercueil funéraire » en difficulté Folie"
  },
  Task_95850_Desc = {
    Text = "Obtenez Durellye avec une illumination de 6"
  },
  Task_95850_Name = {
    Text = "Obtenez Durellye avec une illumination de 6"
  },
  Task_95850_UnlockCondDesc = {
    Text = "Événement @ Pack d'illumination de Dulersein le réveilleur 2 événement"
  },
  Task_95853_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Séparation de la chair et du sang »"
  },
  Task_95854_Desc = {
    Text = "Friandise de l'âme · Folie"
  },
  Task_95855_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Banquet du Sanctuaire Spirituel»"
  },
  Task_95856_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter une victoire dans «Festin des esprits»"
  },
  Task_95857_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Parfum d'humus»"
  },
  Task_95858_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter une victoire dans « Festin des esprits »"
  },
  Task_95860_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter 2 victoires dans « Festin des esprits »"
  },
  Task_95861_Desc = {
    Text = "Terminer n'importe quelle difficulté de \"Séparation de la chair et du sang\""
  },
  Task_95862_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter 2 fois dans «Festin des esprits»"
  },
  Task_95863_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Banquet du Sanctuaire»"
  },
  Task_95864_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 2 fois dans «Festin des esprits»"
  },
  Task_95865_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_95866_UnlockCondDesc = {
    Text = "Veuillez réclamer le précédent pack-cadeau."
  },
  Task_96333_Desc = {
    Text = "Obtenez 10 victoires cette saiso"
  },
  Task_96333_Name = {
    Text = "10 Victoires"
  },
  Task_96334_Desc = {
    Text = "Obtenez un total de 3 victoires cette saiso"
  },
  Task_96334_Name = {
    Text = "3 Victoires"
  },
  Task_96335_Desc = {
    Text = "Obtenez un total de 6 victoires cette saiso"
  },
  Task_96335_Name = {
    Text = "6 victoires"
  },
  Task_96336_Desc = {
    Text = "Obtenez 1 victoire cette saiso"
  },
  Task_96336_Name = {Text = "1 Victoire"},
  Task_96618_Desc = {
    Text = "Échangez 3 fois en utilisant des Coupons d'Or dans la Boutique"
  },
  Task_96619_Desc = {
    Text = "Complétez 20 Missions"
  },
  Task_96620_Desc = {
    Text = "Terminer 2 épreuves hebdomadaires"
  },
  Task_96621_Desc = {
    Text = "Éliminer 1 fois l'Épreuve du Chaos « 24 »"
  },
  Task_96622_Desc = {
    Text = "Terminez toutes les tâches d'essai hebdomadaire pendant 2 semaines"
  },
  Task_96623_Desc = {
    Text = "Terminer 1 fois l'Existence Transcendante"
  },
  Task_96624_Desc = {
    Text = "Connectez-vous pendant un total de 15 jours"
  },
  Task_96625_Desc = {
    Text = "Complétez 20 Missions"
  },
  Task_96626_Desc = {
    Text = "Terminer 2 épreuves hebdomadaires"
  },
  Task_96627_Desc = {
    Text = "Terminer 1 fois l'Existence Transcendante"
  },
  Task_96628_Desc = {
    Text = "Consommez 1 800 points de menophin"
  },
  Task_96629_Desc = {
    Text = "Connexion cumulative pendant 1 jour"
  },
  Task_96630_Desc = {
    Text = "Connexion cumulative pendant 1 jour"
  },
  Task_96631_Desc = {
    Text = "Échangez 3 fois en utilisant des Coupons d'Or dans la Boutique"
  },
  Task_96632_Desc = {
    Text = "Consommez 1 800 points de menophin"
  },
  Task_96633_Desc = {
    Text = "Éliminer 1 fois l'Épreuve du Chaos « 24 »"
  },
  Task_96840_Desc = {
    Text = "Parchemin d'un autre monde·passage"
  },
  Task_96841_Desc = {
    Text = "Terminer n'importe quelle difficulté de « La Mutation de l'Enfer »"
  },
  Task_96842_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Danse Frénétique du Taureau Doré»"
  },
  Task_96843_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Souffrance des fils»"
  },
  Task_96844_Desc = {
    Text = "Terminer « Fête figée » en difficulté Folie"
  },
  Task_96845_Desc = {
    Text = "Terminer « Danse Folle du Taureau d'Or » en difficulté Folie"
  },
  Task_96846_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter 2 victoires dans « Rouleau du monde parallèle »"
  },
  Task_96847_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Infection d'Inspiration»"
  },
  Task_96848_Desc = {
    Text = "Terminer difficulté Folie de «Propagation Sanglante»"
  },
  Task_96849_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Propagation Sanguine»"
  },
  Task_96850_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Danse des Taureaux d'Or»"
  },
  Task_96851_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Propagation Sanglante»"
  },
  Task_96852_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 2 victoires dans « Rouleau de l'autre monde »"
  },
  Task_96853_Desc = {
    Text = "Terminez tous les succès de « Rouleau du monde parallèle · Terminé »"
  },
  Task_96854_Desc = {
    Text = "Terminer n'importe quelle difficulté de «L'Âme des Lignes en Déroute»"
  },
  Task_96855_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Fête figée»"
  },
  Task_96856_Desc = {
    Text = "Parchemin d'un autre monde·royaume"
  },
  Task_96857_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter 2 victoires dans « Rouleau de l'Autre Monde »"
  },
  Task_96858_Desc = {
    Text = "Terminer « Déferlante de l'Âme de Fil » à la difficulté Folie"
  },
  Task_96859_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter une victoire dans « Rouleau d'images d'autres mondes »"
  },
  Task_96860_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Changement en Enfer »"
  },
  Task_96861_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 1 victoire dans « Rouleau de l'autre monde »"
  },
  Task_96862_Desc = {
    Text = "Passer l'esprit vagabond «Peinture de l'aberration»"
  },
  Task_96863_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Empilement de cauchemars»"
  },
  Task_96864_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter une victoire dans « Rouleau d'images d'autres mondes »"
  },
  Task_96865_Desc = {
    Text = "Terminer « Inspiration Invasive » à la difficulté Folie"
  },
  Task_96866_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Empilement de cauchemars»"
  },
  Task_96867_Desc = {
    Text = "Parchemin d'un autre monde · Folie"
  },
  Task_96868_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Arrêt sur Image Festif»"
  },
  Task_96869_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Invasion d'Inspiration»"
  },
  Task_96870_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter 2 victoires dans « Rouleau de dimensions alternatives »"
  },
  Task_96871_Desc = {
    Text = "Terminer difficulté Folie de « Changement en Enfer »"
  },
  Task_96872_Desc = {
    Text = "Terminer « Empilement de cauchemars » à la difficulté folie"
  },
  Task_96873_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter une victoire dans « Rouleau de l'autre monde »"
  },
  Task_97192_Desc = {
    Text = "Connexion cumulative pendant 1 jour"
  },
  Task_97193_Desc = {
    Text = "Complétez 20 Missions"
  },
  Task_97194_Desc = {
    Text = "Connexion cumulative pendant 1 jour"
  },
  Task_97195_Desc = {
    Text = "Terminer 1 fois le niveau d'essai de Dulcain"
  },
  Task_97196_Desc = {
    Text = "Terminer 2 épreuves hebdomadaires"
  },
  Task_97197_Desc = {
    Text = "Valeur d'entraînement spécial de fusion atteinte à 100"
  },
  Task_97198_Desc = {
    Text = "Consommez 1 800 points de menophin"
  },
  Task_97199_Desc = {
    Text = "Terminer 1 fois l'Existence Transcendante"
  },
  Task_97200_Desc = {
    Text = "Terminer 1 fois l'Existence Transcendante"
  },
  Task_97201_Desc = {
    Text = "Consommez 1 800 points de menophin"
  },
  Task_97202_Desc = {
    Text = "Compléter 3 quêtes quotidiennes"
  },
  Task_97203_Desc = {
    Text = "Terminer 1 fois le niveau d'essai de Dulcain"
  },
  Task_97243_Desc = {
    Text = "Complétez 20 Missions"
  },
  Task_97244_Desc = {
    Text = "Terminer 2 épreuves hebdomadaires"
  },
  Task_97245_Desc = {
    Text = "Valeur d'entraînement spécial de fusion atteinte à 100"
  },
  Task_97246_Desc = {
    Text = "Compléter 3 quêtes quotidiennes"
  },
  Task_97309_Desc = {
    Text = "Résonner 6 fois dans l'enquête sur l'événement «@1@2»"
  },
  Task_97309_Desc2 = {
    Text = "Dans l'enquête de l'événement « Banquet » résonner 6 fois"
  },
  Task_97309_Name = {Text = "@2@3"},
  Task_97309_Name2 = {
    Text = "Écho de gourmandise III"
  },
  Task_97310_Desc = {
    Text = "Résonner 9 fois dans l'enquête sur l'événement «@1@2»"
  },
  Task_97310_Desc2 = {
    Text = "Résonner 9 fois dans l'enquête sur l'événement « Banquet »"
  },
  Task_97310_Name = {Text = "@2@3"},
  Task_97310_Name2 = {
    Text = "Écho de gourmandise IV"
  },
  Task_97311_Desc = {
    Text = "Résonner 2 fois dans l'enquête sur l'événement « @1@2 »"
  },
  Task_97311_Desc2 = {
    Text = "Résonner 2 fois dans l'enquête sur l'événement « Friandise »"
  },
  Task_97311_Name = {Text = "@2@3"},
  Task_97311_Name2 = {
    Text = "Écho de la Gourmandise"
  },
  Task_97312_Desc = {
    Text = "Résonner 4 fois dans l'enquête sur l'événement « @1@2 »"
  },
  Task_97312_Desc2 = {
    Text = "Résonner 4 fois dans l'enquête sur l'événement « Banquet »"
  },
  Task_97312_Name = {Text = "@2@3"},
  Task_97312_Name2 = {
    Text = "Écho de Gourmandise II"
  },
  Task_97322_Desc = {
    Text = "Lorsque vous protégez parfaitement le Rideau du Songe marin, vainquez la « Marionnette de la marée pourrie »."
  },
  Task_97322_Name = {
    Text = "Une promesse, une veille · Cacher"
  },
  Task_97673_Desc = {
    Text = "Terminer difficulté Folie de « Texte temporaire »"
  },
  Task_97674_Desc = {
    Text = "Terminer difficulté Folie de « Texte temporaire »"
  },
  Task_97675_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Texte temporaire »"
  },
  Task_97676_Desc = {
    Text = "Texte temporaire · Passage"
  },
  Task_97677_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Texte temporaire »"
  },
  Task_97678_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 1 fois dans « Texte temporaire »"
  },
  Task_97679_Desc = {
    Text = "Terminer tous les succès de « Texte temporaire · Passage »"
  },
  Task_97680_Desc = {
    Text = "Terminer « Texte temporaire » à la difficulté Folie"
  },
  Task_97681_Desc = {
    Text = "Terminer « Texte temporaire » en difficulté Folie"
  },
  Task_97682_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Texte temporaire »"
  },
  Task_97683_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Texte temporaire »"
  },
  Task_97684_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Texte temporaire »"
  },
  Task_97685_Desc = {
    Text = "Terminer « Texte temporaire » en difficulté Folie"
  },
  Task_97686_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter une victoire dans « Texte temporaire »"
  },
  Task_97687_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter une victoire dans « Texte temporaire »"
  },
  Task_97688_Desc = {
    Text = "Terminer difficulté Folie de « Texte temporaire »"
  },
  Task_97689_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Texte temporaire »"
  },
  Task_97690_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter 2 fois dans « Texte temporaire »"
  },
  Task_97691_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Texte temporaire »"
  },
  Task_97692_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter une victoire dans « Texte temporaire »"
  },
  Task_97693_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Texte temporaire »"
  },
  Task_97694_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 2 victoires dans « Texte temporaire »"
  },
  Task_97695_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Texte temporaire »"
  },
  Task_97696_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter 2 fois dans « Texte temporaire »"
  },
  Task_97697_Desc = {
    Text = "Terminer difficulté Folie de « Texte temporaire »"
  },
  Task_97698_Desc = {
    Text = "Texte temporaire · Folie"
  },
  Task_97699_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Texte temporaire »"
  },
  Task_97700_Desc = {
    Text = "Texte temporaire · Domaine"
  },
  Task_97701_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter 2 victoires dans « Texte temporaire »"
  },
  Task_97702_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Texte temporaire »"
  },
  Task_97703_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Texte temporaire »"
  },
  Task_97704_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Texte temporaire »"
  },
  Task_97705_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Texte temporaire »"
  },
  Task_97855_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter une victoire dans « Nouvelles sous la lumière du soleil »"
  },
  Task_97856_Desc = {
    Text = "Connexion cumulative pendant 6 jours"
  },
  Task_97857_Desc = {
    Text = "Connectez-vous pendant un total de 4 jours"
  },
  Task_97858_Desc = {
    Text = "Terminer « Jardin Poétique » en difficulté Folie"
  },
  Task_97859_Desc = {
    Text = "Terminer le paysage de rêve « Adieu, Neverland »"
  },
  Task_97860_Desc = {
    Text = "Connecte-toi pendant 3 jours cumulés"
  },
  Task_97861_Desc = {
    Text = "Terminer tous les succès de « Nouvelles sous le soleil · Évaluation »"
  },
  Task_97862_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 2 victoires dans « Nouvelles sous la lumière du soleil »"
  },
  Task_97863_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter une victoire dans « Nouvelles sous le soleil »"
  },
  Task_97864_Desc = {
    Text = "Terminer difficulté Folie de « Retour aux sources »"
  },
  Task_97865_Desc = {
    Text = "Nouveautés au soleil · Terminé"
  },
  Task_97866_Desc = {
    Text = "Nouveautés au soleil · Domaine"
  },
  Task_97867_Desc = {
    Text = "Terminer « Conte Parfait » en difficulté Folie"
  },
  Task_97868_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Jardin Poétique»"
  },
  Task_97869_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter une victoire dans « Nouveautés sous le soleil »"
  },
  Task_97870_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Rêve Mécanique »"
  },
  Task_97871_Desc = {
    Text = "Terminer « Confrontation au Soleil Noir » à la difficulté Folie"
  },
  Task_97872_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Affronter le Soleil Noir»"
  },
  Task_97873_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Conte de fées parfait»"
  },
  Task_97874_Desc = {
    Text = "Utiliser un réveilleur du royaume de la caro pour remporter 2 victoires dans « Nouvelles sous la lumière du soleil »"
  },
  Task_97875_Desc = {
    Text = "Connecte-toi pendant 5 jours cumulés"
  },
  Task_97876_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Retour aux Lieux»"
  },
  Task_97877_Desc = {
    Text = "Connectez-vous pendant un total de 7 jours"
  },
  Task_97878_Desc = {
    Text = "Terminer « Rêve Mécanique » à la difficulté Folie"
  },
  Task_97879_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Affronter le Soleil Noir»"
  },
  Task_97880_Desc = {
    Text = "Connectez-vous pendant un total de 2 jours"
  },
  Task_97881_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Conte de Fées Parfait»"
  },
  Task_97882_Desc = {
    Text = "Terminer n'importe quelle difficulté de « Rêve Mécanique »"
  },
  Task_97883_Desc = {
    Text = "Utiliser un réveilleur du royaume du chaos pour remporter 1 victoire dans « Nouvelles sous la lumière du soleil »"
  },
  Task_97884_Desc = {
    Text = "Connexion cumulative pendant 1 jour"
  },
  Task_97885_Desc = {
    Text = "Nouveautés sous le soleil · Folie"
  },
  Task_97886_Desc = {
    Text = "7 jours de connexion"
  },
  Task_97887_Desc = {
    Text = "Utiliser un réveilleur du Domaine hyperdimensionnel pour remporter 2 victoires dans « Nouveautés sous le soleil »"
  },
  Task_97888_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Retour sur les lieux familiers»"
  },
  Task_97889_Desc = {
    Text = "Utiliser un réveilleur du Domaine des abysses pour remporter 2 victoires dans « Nouvelles sous le soleil »"
  },
  Task_97890_Desc = {
    Text = "Terminer n'importe quelle difficulté de «Jardin Poétique»"
  },
  Task_97952_Desc = {
    Text = "Éveil cumulé 100 fois"
  },
  Task_97953_Desc = {
    Text = "Terminer 20 missions d'expédition"
  },
  Task_97954_Desc = {
    Text = "Éveil cumulé 100 fois"
  },
  Task_97955_Desc = {
    Text = "Connexion cumulative pendant 1 jour"
  },
  Task_97956_Desc = {
    Text = "Terminer 1 fois l'Existence Transcendante"
  },
  Task_97957_Desc = {
    Text = "Compléter 3 quêtes quotidiennes"
  },
  Task_97958_Desc = {
    Text = "Terminer 20 missions d'expédition"
  },
  Task_97959_Desc = {
    Text = "Complétez 20 Missions"
  },
  Task_97960_Desc = {
    Text = "Compléter 3 quêtes quotidiennes"
  },
  Task_97961_Desc = {
    Text = "Consommation cumulée de 500 000 roses dorées"
  },
  Task_97962_Desc = {
    Text = "Complétez 20 Missions"
  },
  Task_97963_Desc = {
    Text = "Terminer 2 épreuves hebdomadaires"
  },
  Task_97964_Desc = {
    Text = "Terminer 2 épreuves hebdomadaires"
  },
  Task_97965_Desc = {
    Text = "Consommation cumulée de 500 000 roses dorées"
  },
  Task_97966_Desc = {
    Text = "Terminer 1 fois l'Existence Transcendante"
  },
  Task_97967_Desc = {
    Text = "Connexion cumulative pendant 1 jour"
  },
  Task_98151_Desc = {
    Text = "Texte temporaire · Exclusivité temporaire"
  },
  Task_98347_Desc = {
    Text = "Obtenez 10 victoires cette saiso"
  },
  Task_98347_Name = {
    Text = "10 Victoires"
  },
  Task_98348_Desc = {
    Text = "Obtenez un total de 3 victoires cette saiso"
  },
  Task_98348_Name = {
    Text = "3 Victoires"
  },
  Task_98349_Desc = {
    Text = "Obtenez un total de 6 victoires cette saiso"
  },
  Task_98349_Name = {
    Text = "6 victoires"
  },
  Task_98350_Desc = {
    Text = "Obtenez 1 victoire cette saiso"
  },
  Task_98350_Name = {Text = "1 Victoire"},
  Task_98505_Desc = {
    Text = "Terminez le vagabond « Jour Éternel »"
  },
  Task_98505_Name = {
    Text = "Jour de la jouissance brisée"
  },
  Task_98700_Desc = {
    Text = "Connectez-vous pendant un total de 15 jours"
  },
  Task_98701_Desc = {
    Text = "Terminez toutes les tâches d'essai hebdomadaire pendant 2 semaines"
  }
})
return Text_Task
