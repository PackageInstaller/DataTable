__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_ActorAttrType = readonly({
  ActorAttrType_121209_AttributeDesc = {
    Text = "Le niveau de connaissance interdit est identique au niveau du Gardien et détermine l'effet des 3 profondeurs de recherche suivantes. Si le niveau moyen des Éveilleurs dans l'escouade est supérieur ou égal au niveau du Gardien, le niveau de connaissance interdit sera la moyenne entre le niveau moyen des Éveilleurs de l'escouade et le niveau du Gardien. \nProfondeur de la recherche sur les organismes vivants : <Blue:{s1}> \n· Détermine l'intensité de l'effet de conversion de chaque 100 points de constitution en points de vie de l'équipe. \nProfondeur de l'étude des objets : <Blue:{s2}> \n· Détermine l'intensité des effets liés à la force, aux dégâts des tentacules, aux boucliers, à la régénération de PV et à la réduction de force causés par les reliques, oraisons et décrets clés. \nProfondeur de l'étude de la Connaissance Spirituelle : <Blue:{s3}> \n· Détermine l'intensité des effets fixes de poison, de contre-attaque, de dommages et de saignement causés par les reliques, oraisons et décrets clés. \n"
  },
  ActorAttrType_121209_Text = {
    Text = "Niveau de connaissance interdit"
  },
  ActorAttrType_18103_Text = {
    Text = "Bouclier du personnage"
  },
  ActorAttrType_18104_Text = {
    Text = "Correction du pourcentage de dommages de la carte de frappe"
  },
  ActorAttrType_18105_AttributeUpText = {
    Text = "Dégâts critiques +{s1}"
  },
  ActorAttrType_18105_Text = {
    Text = "Dégâts Critiques"
  },
  ActorAttrType_18106_Text = {
    Text = "Bouclier amélioré"
  },
  ActorAttrType_18107_AttributeUpText = {
    Text = "Attaque+{s1}"
  },
  ActorAttrType_18107_Text = {Text = "Attaque"},
  ActorAttrType_18108_Text = {
    Text = "Constitution"
  },
  ActorAttrType_18109_Text = {
    Text = "Ajustement du pourcentage de dommages de la carte"
  },
  ActorAttrType_18110_Text = {
    Text = "Ajuste de Pourcentage Fragile"
  },
  ActorAttrType_18111_Text = {
    Text = "Ajustement du pourcentage de bouclier reçu"
  },
  ActorAttrType_18112_AttributeUpText = {
    Text = "Défense + {s1}"
  },
  ActorAttrType_18112_Text = {
    Text = "Défense améliorée"
  },
  ActorAttrType_18113_AttributeDesc = {
    Text = "Efficacité de charge de folie du corps éveillé"
  },
  ActorAttrType_18113_Text = {
    Text = "Fureur initiale"
  },
  ActorAttrType_18114_AttributeDesc = {
    Text = "Plus la constitution est élevée, plus la vie maximale du réveilleur est élevée.\nPlus le niveau d'enquêteur du gardien est élevé, plus l'impact de la constitution sur la vie maximale du réveilleur est fort"
  },
  ActorAttrType_18114_AttributeUpText = {
    Text = "Constitution+{s1}"
  },
  ActorAttrType_18114_Text = {
    Text = "Constitution"
  },
  ActorAttrType_18115_AttributeDesc = {
    Text = "Après que le réveilleur ait libéré la genèse d'arrivée, le pouvoir de folie retourné"
  },
  ActorAttrType_18115_AttributeUpText = {
    Text = "Réduction de la consommation de folie +{s1}"
  },
  ActorAttrType_18115_Text = {
    Text = "Réduction de la consommation de Fureur"
  },
  ActorAttrType_18116_AttributeDesc = {
    Text = "Plus la constitution est élevée, plus la vie maximale du réveilleur est élevée.\nPlus le niveau d'enquêteur du gardien est élevé, plus l'impact de la constitution sur la vie maximale du réveilleur est fort"
  },
  ActorAttrType_18116_AttributeUpText = {
    Text = "Constitution+{s1}"
  },
  ActorAttrType_18116_Text = {
    Text = "Augmentation de la Constitution"
  },
  ActorAttrType_18117_Text = {
    Text = "Dégâts des tentacules"
  },
  ActorAttrType_18118_Text = {
    Text = "Emplacements Ultra"
  },
  ActorAttrType_18119_Text = {
    Text = "Correction du pourcentage de dégâts reçus"
  },
  ActorAttrType_18120_AttributeDesc = {
    Text = "La Limite de fureur maximale et la Consommation de Fureur d'Exaltation du Corps éveillé sont toutes deux égales à son Aliemus de base."
  },
  ActorAttrType_18120_AttributeUpText = {
    Text = "Limite de folie +{s1}"
  },
  ActorAttrType_18120_Text = {
    Text = "Aliemus de base"
  },
  ActorAttrType_18121_AttributeDesc = {
    Text = "Niveau de la compétence 2"
  },
  ActorAttrType_18121_AttributeUpText = {
    Text = "Niveau de compétence 2 +{s1}"
  },
  ActorAttrType_18121_Text = {
    Text = "Niveau de la compétence 2"
  },
  ActorAttrType_18122_AttributeDesc = {
    Text = "Niveau de défense"
  },
  ActorAttrType_18122_AttributeUpText = {
    Text = "Niveau de défense+{s1}"
  },
  ActorAttrType_18122_Text = {
    Text = "Niveau de défense"
  },
  ActorAttrType_18123_Text = {
    Text = "Ajustement de la valeur fixe du nombre de dégâts"
  },
  ActorAttrType_18124_Text = {
    Text = "Causa une modification de valeur fixe du bouclier"
  },
  ActorAttrType_18125_Text = {
    Text = "Correction de la valeur fixe du bouclier"
  },
  ActorAttrType_18126_AttributeDesc = {
    Text = "La maîtrise du Royaume de l'équipe est égale à la somme de la maîtrise du Royaume de tous les Réveillés dans l'équipe. La maîtrise du Royaume peut améliorer les effets du Legs du Royaume de l'équipe. Si l'équipe actuelle est \"Mer Tranquille Pure/Caro Pur/Ultra Pur\", l'effet de maîtrise du Royaume est doublé.\n· Pour les équipes du Royaume <Blue:Chaos>, pour chaque point de maîtrise du Royaume, après avoir libéré la Posse, tous les Réveillés gagnent un point supplémentaire de <Blue:0.05> d'Aliemus.\n· Pour les équipes du Royaume <Blue:Aequor>, pour chaque point de maîtrise du Royaume, il y a une chance de <Blue:0.25%> de gagner un empilement supplémentaire de Tentacle Gathering lors de l'activation d'Exalt (les chances supérieures à 100% peuvent accorder plusieurs empilements). En passant à \"Mer Tranquille\", les quantités de Bouclier acquises augmentent de <Blue:0.01%> de PV max, et les dégâts de tentacule causés par des dégâts actifs dans \"Vagues Déchaînées\" augmentent de <Blue:0.02%> de Dégâts de Tentacule.\n· Pour les équipes du Royaume <Blue:Caro>, pour chaque point de maîtrise du Royaume, le premier Dévorer déclenché à chaque tour accorde un Bouclier supplémentaire égal à <Blue:0.01%> de PV max et une Force Temporaire de <Blue:0.005%> (augmente en fonction des PV perdus, jusqu'à un maximum de 100%).\n· Pour les équipes du Royaume <Blue:Ultra>, pour chaque point de maîtrise du Royaume, au début du tour, il y a une chance de <Blue:0.125%> de gagner 1 \"Perspicacité\" (les chances supérieures à 100% peuvent accorder plusieurs copies)."
  },
  ActorAttrType_18126_AttributeUpText = {
    Text = "Maîtrise des domaines +{s1}"
  },
  ActorAttrType_18126_Text = {
    Text = "Maîtrise de Royaume"
  },
  ActorAttrType_18127_Text = {Text = "PV"},
  ActorAttrType_18128_AttributeUpText = {
    Text = "Attaque+{s1}"
  },
  ActorAttrType_18128_Text = {
    Text = "Attaque augmentée"
  },
  ActorAttrType_18129_AttributeDesc = {
    Text = "Plus le bonus de dégâts de base est élevé, plus les dégâts infligés par l'éveillé sont importants"
  },
  ActorAttrType_18129_AttributeUpText = {
    Text = "Dégâts de base +{s1}"
  },
  ActorAttrType_18129_Text = {
    Text = "Dommage de base"
  },
  ActorAttrType_18130_Text = {Text = "Niveau"},
  ActorAttrType_18131_AttributeDesc = {
    Text = "À la fin du tour, la folie auto-récupérée des éveillés (en mode sujet, après chaque action des éveillés)"
  },
  ActorAttrType_18131_AttributeUpText = {
    Text = "Régénération automatique de folie +{s1}"
  },
  ActorAttrType_18131_Text = {
    Text = "Réponse Automatique de Fureur"
  },
  ActorAttrType_18132_Text = {
    Text = "Niveau d'Éveil"
  },
  ActorAttrType_18133_Text = {
    Text = "Ajustement du pourcentage de fureur reçue"
  },
  ActorAttrType_18134_Text = {
    Text = "Limite de fusion d'embryons"
  },
  ActorAttrType_18135_Text = {
    Text = "Personnage avec Fureur Actuelle"
  },
  ActorAttrType_18136_Text = {
    Text = "Ajustement de la valeur fixe des dégâts reçus"
  },
  ActorAttrType_18137_AttributeDesc = {
    Text = "Lors de l'application de boucliers et d'effets de guérison, l'éveillé augmente les valeurs de bouclier et de guérison"
  },
  ActorAttrType_18137_AttributeUpText = {
    Text = "Bouclier et soins fort + {s1}"
  },
  ActorAttrType_18137_Text = {
    Text = "Bouclier et Soin Puissant"
  },
  ActorAttrType_18138_Text = {
    Text = "Soins augmentés"
  },
  ActorAttrType_18139_AttributeDesc = {
    Text = "Lorsque vous jouez une Carte d'instruction ou Éveiller la Gnosis, obtenez {s1} Fragment de clé par point d'Arithmetica consommé. À mesure que cet attribut augmente, le gain supplémentaire de Fragment de clé diminue progressivement."
  },
  ActorAttrType_18139_AttributeUpText = {
    Text = "Recharge de clé en argent +{s1}"
  },
  ActorAttrType_18139_Text = {
    Text = "Niveau de charge de la clé d'argent"
  },
  ActorAttrType_18140_Text = {
    Text = "Nombre de résistances à la mort"
  },
  ActorAttrType_18141_AttributeDesc = {
    Text = "Niveau de coup"
  },
  ActorAttrType_18141_AttributeUpText = {
    Text = "Niveau de coup +{s1}"
  },
  ActorAttrType_18141_Text = {
    Text = "Niveau de coup"
  },
  ActorAttrType_18142_AttributeDesc = {
    Text = "Augmente en pourcentage les « dégâts de base » infligés par tous les éveillés, le nombre de couches de « poison à valeur fixe » appliqué et de « contre-attaque à valeur fixe », ainsi que les dégâts initiaux des tentacules dans le Domaine des abysses."
  },
  ActorAttrType_18142_AttributeUpText = {
    Text = "Dégâts fort+{s1}"
  },
  ActorAttrType_18142_Text = {
    Text = "Amplification de Dégâts"
  },
  ActorAttrType_18143_Text = {
    Text = "Ajustement du pourcentage de dommages de la Fureur éruptive"
  },
  ActorAttrType_18144_AttributeDesc = {
    Text = "Lorsque l'éveil inflige des dégâts actifs, la probabilité de résister aux critiques"
  },
  ActorAttrType_18144_AttributeUpText = {
    Text = "Résistance aux coups critiques +{s1}"
  },
  ActorAttrType_18144_Text = {
    Text = "Résistance Critique"
  },
  ActorAttrType_18145_AttributeDesc = {
    Text = "Origine niveau d'arrivée"
  },
  ActorAttrType_18145_AttributeUpText = {
    Text = "Origine niveau d'arrivée +{s1}"
  },
  ActorAttrType_18145_Text = {
    Text = "Origine niveau d'arrivée"
  },
  ActorAttrType_18146_Text = {
    Text = "Correction de la valeur fixe de soin"
  },
  ActorAttrType_18147_AttributeUpText = {
    Text = "Taux d'impression chanceuse + {s1}"
  },
  ActorAttrType_18147_Text = {
    Text = "Taux de Gravure Chanceux"
  },
  ActorAttrType_18148_Text = {
    Text = "Cause une correction de la valeur de soin fixe"
  },
  ActorAttrType_18149_Text = {
    Text = "Augmentation de la Constitution"
  },
  ActorAttrType_18150_Text = {
    Text = "Ajustement du Pourcentage de Faiblesse"
  },
  ActorAttrType_18151_AttributeDesc = {
    Text = "La résistance à la mort de l'équipe est égale à la somme des résistances à la mort des Éveilleurs de l'équipe. \n Lorsqu'une blessure fatale est subie au combat, il y a une probabilité de garder 1 point de vie, après déclenchement, obtenez 2 points d'arithmétique supplémentaires et piochez 2 cartes, la résistance à la mort actuelle et à venir est réduite de moitié, et cela dure jusqu'à la fin de l'enquête."
  },
  ActorAttrType_18151_AttributeUpText = {
    Text = "Résistance à la mort +{s1}"
  },
  ActorAttrType_18151_Text = {
    Text = "Résistance à la mort"
  },
  ActorAttrType_18152_Text = {
    Text = "Cause un ajustement du pourcentage de Fureur"
  },
  ActorAttrType_18154_Text = {
    Text = "Limite des tentacules"
  },
  ActorAttrType_18155_AttributeDesc = {
    Text = ": Pourcentage d'augmentation des marques noires tombées après la victoire au combat"
  },
  ActorAttrType_18155_AttributeUpText = {
    Text = "Chute de signes +{s1}"
  },
  ActorAttrType_18155_Text = {
    Text = "Sceaux Obtenus"
  },
  ActorAttrType_18156_Text = {
    Text = "Recevoir l'ajustement de valeur fixe de la fureur"
  },
  ActorAttrType_18157_Text = {
    Text = "Intentions Cachées"
  },
  ActorAttrType_18158_Text = {
    Text = "Ajustement de la valeur fixe des dégâts"
  },
  ActorAttrType_18159_AttributeUpText = {
    Text = "Taux critique +{s1}"
  },
  ActorAttrType_18159_Text = {
    Text = "Taux Critique"
  },
  ActorAttrType_18160_AttributeDesc = {
    Text = "Niveau de la Compétence 1"
  },
  ActorAttrType_18160_AttributeUpText = {
    Text = "Niveau de compétence 1 +{s1}"
  },
  ActorAttrType_18160_Text = {
    Text = "Niveau de la Compétence 1"
  },
  ActorAttrType_18161_Text = {Text = "Niveau"},
  ActorAttrType_18162_Text = {
    Text = "Dégâts augmentés"
  },
  ActorAttrType_18163_Text = {
    Text = "Nombre de Tentacules"
  },
  ActorAttrType_18164_Text = {
    Text = "Modificateur du Pourcentage de Soins Reçus"
  },
  ActorAttrType_18165_Text = {
    Text = "Arithmetica Max"
  },
  ActorAttrType_18166_Text = {
    Text = "Ajustement du pourcentage de Faiblesse"
  },
  ActorAttrType_18167_AttributeUpText = {
    Text = "Défense + {s1}"
  },
  ActorAttrType_18167_Text = {Text = "Défense"},
  ActorAttrType_18168_AttributeDesc = {
    Text = "Niveau d'Éveil de la Gnosis"
  },
  ActorAttrType_18168_AttributeUpText = {
    Text = "Niveau de réveil de gnose +{s1}"
  },
  ActorAttrType_18168_Text = {
    Text = "Niveau d'Éveil de la Gnosis"
  },
  ActorAttrType_21322_Text = {
    Text = "Régénération de Fragment de clé"
  },
  ActorAttrType_22207_AttributeDesc = {
    Text = "Chaque fois que la colère est déchaînée, obtenez {s1} points de colère. Avec l'augmentation de cette caractéristique, l'effet supplémentaire décroît progressivement"
  },
  ActorAttrType_22207_AttributeUpText = {
    Text = "Niveau de recharge de folie +{s1}"
  },
  ActorAttrType_22207_Text = {
    Text = "Niveau de recharge de fureur"
  },
  ActorAttrType_22214_Text = {
    Text = "Recharge de rage"
  }
})
return Text_ActorAttrType
