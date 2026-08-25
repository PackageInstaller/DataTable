__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_GuideConfig = readonly({
  GuideConfig_10_Content_1 = {
    Text = "Un peu plus loin, se dresse un <RedQuality:énorme créature à six ailes argentées>, émettant une lumière éblouissante"
  },
  GuideConfig_11_Content_1 = {
    Text = "Nous pouvons affronter Lui... ou nettoyer les monstres qui errent ici et chercher un point de jonction. C'est le moment de prendre ta décision, gardien"
  },
  GuideConfig_12_Content_1 = {
    Text = "Maintenez la carte de commandement, faites-la glisser vers le haut pour émettre un ordre"
  },
  GuideConfig_13_Content_1 = {
    Text = "L'ennemi va attaquer causant des dégâts fatals. Émettez des ordres de défense, gardien !"
  },
  GuideConfig_14_Content_1 = {
    Text = "Libérer l'épée de la reine à plusieurs reprises rend l'attaque plus féroce. Voulez-vous essayer de finir l'adversaire avec ce coup ?"
  },
  GuideConfig_15_Content_1 = {
    Text = "L'exécution d'une instruction d'attaque permet d'obtenir de la fureur, et lorsque la fureur est pleine, il est possible de libérer une puissante exaltation."
  },
  GuideConfig_1_Content_1 = {
    Text = "Gardien, vous pouvez maintenant explorer"
  },
  GuideConfig_2_Content_1 = {
    Text = "C'est la jonction de mythag, la résonance avec la clé en argent peut restaurer la vie, c'est exactement ce dont nous avons besoin"
  },
  GuideConfig_34_Content_1 = {
    Text = "Actuellement en phase d'enseignement de combat, plusieurs cartes de commandement peuvent être jouées. Après la formation, vous pourrez agir librement"
  },
  GuideConfig_35_Content_1 = {
    Text = "Actuellement en phase d'enseignement de combat, plusieurs cartes de commandement peuvent être jouées. Après la formation, vous pourrez agir librement"
  },
  GuideConfig_36_Content_1 = {
    Text = "Actuellement en phase d'enseignement de combat, plusieurs cartes de commandement peuvent être jouées. Après la formation, vous pourrez agir librement"
  },
  GuideConfig_37_Content_1 = {
    Text = "Actuellement en phase d'enseignement de combat, plusieurs cartes de commandement peuvent être jouées. Après la formation, vous pourrez agir librement"
  },
  GuideConfig_38_Content_1 = {
    Text = "Actuellement en phase d'enseignement de combat, plusieurs explosions de folie peuvent être utilisées. Après la formation, vous pourrez agir librement"
  },
  GuideConfig_39_Content_1 = {
    Text = "Actuellement en phase d'enseignement de combat, plusieurs explosions de folie peuvent être utilisées. Après la formation, vous pourrez agir librement"
  },
  GuideConfig_3_Content_1 = {
    Text = "Vaincs rapidement <RedQuality:la Baleine enragée>, je ne veux plus voir de telles tragédies"
  },
  GuideConfig_40_Content_1 = {
    Text = "Actuellement en phase d'enseignement de combat, plusieurs explosions de folie peuvent être utilisées. Après la formation, vous pourrez agir librement"
  },
  GuideConfig_41_Content_1 = {
    Text = "Actuellement en phase d'enseignement de combat, plusieurs explosions de folie peuvent être utilisées. Après la formation, vous pourrez agir librement"
  },
  GuideConfig_42_Content_1 = {
    Text = "Actuellement en phase d'enseignement de combat, plusieurs clés peuvent être utilisées. Après la formation, vous pourrez agir librement"
  },
  GuideConfig_47_Content_1 = {
    Text = "Le Royaume du Chaos possède une forte Résonance avec la Clé d'argent, octroyant 250 Fragments de clé à chaque tour pour vous aider à Lâcher votre Décret Clé plus rapidement. S'il n'y a aucun Corps éveillé d'autres Royaumes dans votre équipe, vous recevrez également une Création en argent en entrant dans le Niveau. Utilisez la Relique pour vous aider à vaincre vos ennemis."
  },
  GuideConfig_47_TipsTitle_1 = {
    Text = "Domaine du Chaos"
  },
  GuideConfig_49_Content_1 = {
    Text = "Le Royaume Aequor génère 1 Tentacule au début du combat. Le Tentacule attaque l'ennemi de la première ligne à la fin de chaque tour. Les Corps éveillé des abysses peuvent fournir diverses améliorations au Tentacule. Vous pouvez vérifier les Dégâts des tentacules actuels via la valeur affichée sous l'icône du Tentacule."
  },
  GuideConfig_49_TipsTitle_1 = {
    Text = "Royaume d'Aequor"
  },
  GuideConfig_4_Content_1 = {
    Text = "Les signes peuvent être sacrifiés au domaine d<Yellow:d-marque>, pour obtenir divers<Yellow:reliques>, très utiles au combat"
  },
  GuideConfig_55_Content_1 = {
    Text = "Le Royaume de la Chair accumule de la Fusion d'Embryon et de la Forge Écarlate à chaque tour — plus vos PV sont bas, plus l'accumulation est rapide. Lorsque le Niveau de Fusion atteint son maximum, un Embryon est généré et placé dans votre Main. Les Embryons peuvent être utilisés directement pour octroyer la Fureur du Corps Éveillé correspondant et un Taux de coup critique temporaire ; ou ils peuvent être Dévorés par un Corps Éveillé de Chair et de Sang via l'Exaltation pour déclencher des Effets supplémentaires."
  },
  GuideConfig_55_TipsTitle_1 = {
    Text = "Royaume de Chair et de Sang"
  },
  GuideConfig_57_Content_1 = {
    Text = "Utilisez la « Forge Écarlate » pour la Régénération de PV afin de résister aux attaques !"
  },
  GuideConfig_58_Content_1 = {
    Text = "Lorsqu'un Corps Éveillé de Chair et de Sang déclenche l'Exaltation, il peut Dévorer les Embryons dans votre Main pour Renforcer l'Effet d'Exaltation. Lâchez l'Œil des Temps Anciens et déclenchez Dévorer !"
  },
  GuideConfig_5_Content_1 = {
    Text = "Un <Yellow:d-marque> a été découvert, plongez dans le sigil noir accumulé"
  },
  GuideConfig_60_Content_1 = {
    Text = "Dans le Royaume ultradimensionnel, une copie Temporaire de la première Carte d'instruction jouée à chaque tour entre dans l'Espace Hyperspatial. Lorsque l'Espace Hyperspatial atteint sa limite, vous pouvez entrer dans un nouveau tour. Lors de ce nouveau tour, vous ne Piocherez pas de Cartes ; à la place, les Cartes de l'Espace Hyperspatial sont placées dans votre Main."
  },
  GuideConfig_60_TipsTitle_1 = {
    Text = "Ultra royaume"
  },
  GuideConfig_6_Content_1 = {
    Text = "Voilà <Yellow:relique>, un objet issu du domaine, vous pourrez bientôt percevoir sa puissance. Malheureusement, la relique disparaît une fois sortie du domaine"
  },
  GuideConfig_7_Content_1 = {
    Text = "Il semble qu'il y ait un <Yellow:événement> soudain devant nous, allons voir. Peut-être que nous pourrons obtenir un renforcement inattendu... bien que parfois cela vienne avec un prix"
  },
  GuideConfig_8_Content_1 = {
    Text = "Il semble qu'il y ait encore des ennemis devant"
  },
  GuideConfig_9_Content_1 = {
    Text = "C'est un passage à sens unique, il mène à la salle souterraine, allons-y, accomplissons notre mission"
  }
})
return Text_GuideConfig
