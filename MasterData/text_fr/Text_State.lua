__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_State = readonly({
  State_100291_Desc = {
    Text = "La folie infligée par tous les éveillés augmente de 50 %."
  },
  State_100291_Name = {Text = "confession"},
  State_100292_Name = {
    Text = "Début du tour"
  },
  State_100293_Desc = {
    Text = "La folie infligée par tous les éveillés est réduite de 50 %. À la fin du tour, gagnez 1 niveau de « <DarkEgo:ombre de soi> » : au début du tour, tous les éveillés gagnent 3 points de folie."
  },
  State_100293_Name = {
    Text = "Ombre de la personnalité"
  },
  State_100295_Name = {
    Text = "Écoute des dégâts"
  },
  State_100296_Desc = {
    Text = "Pour chaque niveau, après le début du tour, tous les éveillés gagnent <Energy:3> points de folie."
  },
  State_100296_Name = {
    Text = "Obscurité de soi"
  },
  State_100297_Desc = {
    Text = "À la fin du tour, obtenez un bouclier équivalent à 20 % de la vie maximale."
  },
  State_100297_Name = {
    Text = "Barrière mentale"
  },
  State_100298_Desc = {
    Text = "Au début du tour, perdez 10% de votre vie actuelle et obtenez [DescArg1] points de force."
  },
  State_100298_Name = {
    Text = "Effondrement de la barrière"
  },
  State_100299_Desc = {
    Text = "Compte d'Exaltation"
  },
  State_100299_Name = {
    Text = "Compte d'Exaltation"
  },
  State_100302_Name = {
    Text = "Écoute de l'Exalter"
  },
  State_100307_Desc = {
    Text = "Équipe unique : après que l'équipement libère l'exaltation, il obtient 1 niveau de « co-création ». La prochaine exaltation des autres éveillés dans ce tour peut consommer « co-création », augmentant le taux de coup critique de cette exaltation de <WeaponEffect_Num:[StateArg1]%> et permettant à l'éveillé qui consomme « co-création » de gagner des points de folie équivalents à <WeaponEffect_Num:[StateArg1]%> de la régénération de folie de l'équipement."
  },
  State_100307_WeaponDesc = {
    Text = "Après que l'équipement ait libéré l'exaltation, il obtient 1 niveau de « co-création ». La prochaine exaltation des autres éveillés dans ce tour peut consommer « co-création », augmentant le taux de coup critique de cette exaltation de <WeaponEffect_Num:[StateArg1]%> et permettant à l'éveillé qui consomme « co-création » de gagner <WeaponEffect_Num:[DescArg1]> points de folie."
  },
  State_100326_Desc = {
    Text = "Pour chaque niveau, après le début du tour, tous les éveillés gagnent <Energy:3> points de folie."
  },
  State_100326_Name = {
    Text = "<DarkEgo:Face sombre de soi>"
  },
  State_100327_Desc = {
    Text = "À la fin du tour, obtenez un bouclier équivalent à 20 % de votre vie maximale."
  },
  State_100327_Name = {
    Text = "<MindWall:Barrière mentale>"
  },
  State_100328_Desc = {
    Text = "La folie infligée par tous les éveillés augmente de 50 %."
  },
  State_100328_Name = {
    Text = "<TrueConfess:confession>"
  },
  State_100329_Desc = {
    Text = "La folie infligée par tous les éveillés est réduite de 50 %. À la fin du tour, gagnez 1 niveau de « <DarkEgo:ombre de soi> » : au début du tour, tous les éveillés obtiennent 3 points de folie."
  },
  State_100329_Name = {
    Text = "<ShadowSelf:ombre de la personnalité>"
  },
  State_100330_Desc = {
    Text = "Au début du tour, perdez 10 % de votre vie actuelle et obtenez [DescArg1] points de <PowerIconKeywords:force>."
  },
  State_100330_Name = {
    Text = "<BarrierCrash:Effondrement de la barrière>"
  },
  State_100395_Name = {
    Text = "Sang de Grâce créé+"
  },
  State_100396_Name = {
    Text = "Sang de Grâce créé"
  },
  State_100527_Desc = {
    Text = "Lorsque Pickman déclenche l'effet « découverte », ajoutez en plus l'option « Éruption d'inspiration ! » : dépensez 1 couche de « folie », choisissez tous les effets et obtenez 1 couche de « créativité »."
  },
  State_100527_Name = {Text = "Rêverie"},
  State_100541_Desc = {
    Text = "Si vous avez actuellement 10 niveaux de « créativité », après que Pickman libère l'exaltation de la folie en dépensant toutes les « créations », il obtient 1 niveau de folie et tous les éveillés gagnent 15 points de folie. La limite de créativité est de 10 niveaux, pouvant être transférée au prochain combat."
  },
  State_100541_Name = {
    Text = "<Chuangyi:Créativité>"
  },
  State_100542_Desc = {
    Text = "Lorsque Pickman déclenche l'effet « découverte », ajoutez en plus l'option « Éruption d'inspiration ! » : dépensez 1 couche de « folie », choisissez tous les effets de « découverte » et obtenez 1 couche de « créativité »."
  },
  State_100542_Name = {
    Text = "<Kuangxiang:Rêverie>"
  },
  State_100544_Name = {Text = "Slime Doux"},
  State_100544_WeaponDesc = {
    Text = "Les boucliers et la régénération de vie infligés par le porteur augmentent de 6%. Si la maîtrise du domaine du porteur dépasse 50, les boucliers et la régénération de vie augmentent de 6% supplémentaires"
  },
  State_100545_Name = {Text = "Slime Doux"},
  State_100545_WeaponDesc = {
    Text = "Les boucliers et la régénération de vie infligés par le porteur augmentent de 6%. Si la maîtrise du domaine du porteur dépasse 50, les boucliers et la régénération de vie augmentent de 6% supplémentaires"
  },
  State_100558_Desc = {
    Text = "Au prochain tour, le taux de coup critique de l'exaltation des autres éveillés augmente de [StateArg1] %, et après utilisation, gagnez [DescArg1] points de folie."
  },
  State_100558_Name = {
    Text = "Co-création"
  },
  State_100559_Desc = {
    Text = "Comprend les « créations du chapitre des étoiles » suivantes : enfant maléfique, fête du printemps, verrouillage lourd, agate enroulée, sang du don, scie en acier rouillé, rêve doré, galets ensanglantés."
  },
  State_100559_Name = {
    Text = "<Chuanggouzaowu:Création de conception>"
  },
  State_100562_Desc = {
    Text = "Ce tour, le coût en arithmetica des [Layer] prochaines cartes de commande jouées est réduit de 2."
  },
  State_100562_Name = {
    Text = "Réalité, c'est aussi une illusion"
  },
  State_100564_Desc = {
    Text = "Inclut les « oraisons » suivantes : arithmetica, main habile, aliemus, catalyse, force brute, mur d'acier, épuisement, inspiration."
  },
  State_100564_Name = {
    Text = "<Chuanggoukeyin:Oraison de création>"
  },
  State_100566_WeaponDesc = {
    Text = "Changez le coût en arithmetica de la carte avant de la jouer"
  },
  State_100617_Desc = {
    Text = "À la fin du tour, gagnez 1 limite des tentacules."
  },
  State_100617_Name = {
    Text = "Obsession étouffée"
  },
  State_100619_Desc = {
    Text = "Lorsque la force est réduite, seules 50 % des couches de force sont diminuées"
  },
  State_100619_Name = {
    Text = "Résistance à l'épuisement"
  },
  State_100621_Desc = {
    Text = "Chaque couche réduit les dégâts de base infligés par le joueur de 25 %, et peut ensuite guider la direction de la navigation."
  },
  State_100621_Name = {
    Text = "Lumière vacillante"
  },
  State_100623_Desc = {
    Text = "Chaque couche réduit les dégâts de base infligés par le joueur de 50 %. Après avoir infligé des dégâts actifs ou de tentacule, réduisez [DescArg1] poison sur soi-même."
  },
  State_100623_Name = {
    Text = "Lumière Égarée"
  },
  State_100639_Desc = {
    Text = "Les dégâts de tentacule infligés sont temporairement réduits de 50 %."
  },
  State_100639_Name = {
    Text = "La Cité Perdue d'Autrefois"
  },
  State_100644_Desc = {
    Text = "Réduction permanente de la force de la cible, gagnez une force équivalente."
  },
  State_100644_Name = {
    Text = "<TouquKeywords: Vol permanent>"
  },
  State_100647_Desc = {
    Text = "Immunité à tous les dégâts."
  },
  State_100647_Name = {
    Text = "Immunité à tous les dégâts."
  },
  State_100694_Desc = {
    Text = "Chaque couche réduit les dégâts de base infligés par le joueur de 30 %. Après avoir infligé des dégâts actifs ou des dégâts de tentacule, réduisez le poison sur soi-même."
  },
  State_100694_Name = {
    Text = "Lumière Égarée"
  },
  State_116342_Desc = {
    Text = "Jouer une carte <ErosionColorInkKeywords:Distorsion de Perception> permet au « Le Peintre » d'obtenir 1 charge de <DecayDye:Teinture du monde fantôme>."
  },
  State_116342_Name = {
    Text = "Palette des visions"
  },
  State_116406_Name = {Text = "Avancé"},
  State_116407_Name = {Text = "État vide"},
  State_116858_Desc = {
    Text = "Cet état utilise une zone de vulnérabilité multipliée, prétendant être une zone de multiplication indépendante."
  },
  State_116858_Name = {
    Text = "Si vous avez un certain état, les dégâts reçus sont doublés"
  },
  State_116859_Desc = {
    Text = "Au début du prochain tour, obtenez une Faille."
  },
  State_116859_Name = {
    Text = "Faille de latence"
  },
  State_116958_Desc = {
    Text = "Après avoir joué la carte, subissez des dégâts correspondant au nombre de couches."
  },
  State_116958_Name = {
    Text = "<PVPCardLockColour:Verrouillage de carte>"
  },
  State_117154_Desc = {
    Text = "Cet effet ne peut être déclenché qu'une seule fois sur tous les Éveilleurs de l'équipe et ne peut pas être réactivé."
  },
  State_117154_Name = {
    Text = "<TeamUnique: Équipe Unique>"
  },
  State_117212_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Avant une « Compétence » et en fin de tour, applique <Damage:[Damage:StateArg1]> stack(s) de <PVPCorrosionKeywords:Marque du Péché> à l'ennemi avec <HPAndShieldMax:la vie et le bouclier les plus élevés>."
  },
  State_117212_Name = {Text = "Pollux"},
  State_117213_Desc = {
    Text = "<PVPWeaponKeywords:roue du destin> : « Compétence » et à la fin du tour, inflige à l'ennemi avec le plus de Fureur [StateArg1] <PVPfengsuoKeywords:Confinement>."
  },
  State_117213_Name = {
    Text = "Pollux SR (Texte temporaire)"
  },
  State_117346_Desc = {
    Text = "Les dégâts infligés par Pollux infligent un saignement supplémentaire de [Layer] %."
  },
  State_117346_Name = {
    Text = "Marque de péché"
  },
  State_117355_Desc = {
    Text = "La prochaine carte d'instruction jouée par Pollux est active 2 fois."
  },
  State_117355_Name = {
    Text = "Nouvelle Alliance divine"
  },
  State_117357_Desc = {
    Text = "Équipe Unique : Après que « Trace de fusion » et « Ruines Cendrées » aient été rafraîchies, le porteur obtient <WeaponEffect_Num:[StateArg1]> points de Fureur."
  },
  State_117357_WeaponDesc = {
    Text = "Après avoir rafraîchi « Trace de fusion » et « Ruines Cendrées », le porteur obtient <WeaponEffect_Num:[StateArg1]> points de fureur."
  },
  State_117358_Desc = {
    Text = "Chaque niveau permet à Pollux d'infliger 1% de Saignement supplémentaire."
  },
  State_117358_Name = {
    Text = "<ZuiyinKeywords:Marque de péché>"
  },
  State_117744_Desc = {
    Text = "<MaxHPKeywords:PV Max> –[Layer]. Lors du déclenchement, subit [Layer] dégâts passifs, permanent. Lors de la dissipation, les PV Max perdus ne sont pas récupérés."
  },
  State_117744_Name = {
    Text = "Marque de péché"
  },
  State_117745_Desc = {
    Text = "Chaque charge réduit les <MaxHPKeywords:PV Max> de la cible. Lorsque la Marque de péché est déclenchée, la cible subit des dégâts passifs égaux au nombre de charges. Lors de la dissipation, les PV Max perdus ne sont pas récupérés."
  },
  State_117745_Name = {
    Text = "<PVPCorrosionKeywords:Marque de péché>"
  },
  State_117755_Desc = {
    Text = "Avant la fin du tour, vous ne pouvez effectuer aucune action"
  },
  State_117755_Name = {
    Text = "Inconscient"
  },
  State_117756_Desc = {
    Text = "Avant la fin du tour, vous ne pouvez effectuer aucune action"
  },
  State_117756_Name = {
    Text = "Inconscient"
  },
  State_117776_Desc = {
    Text = "Ce tour, les dégâts finaux et le bouclier de [Layer] cartes d'instruction augmentent de [StateArg1] %."
  },
  State_117776_Name = {
    Text = "Flamme divine"
  },
  State_117777_Desc = {
    Text = "Équipe Unique : Les dégâts de base et les dégâts critiques infligés par les cartes du porteur augmentent de <WeaponEffect_Num:[StateArg1]%. Au début du tour et après que le porteur ait libéré l'exaltation, il obtient 1 couche de feu intérieur. Lorsque le porteur joue une carte d'instruction ce tour-ci, il consomme 1 couche de « feu intérieur », augmentant ses dégâts finaux et son bouclier de <WeaponEffect_Num:[StateArg2]%. Pendant un tour ultra, cela se transforme en « flamme divine » et l'effet est doublé."
  },
  State_117777_WeaponDesc = {
    Text = "Le dommage de base et les dégâts critiques causés par la carte du porteur augmentent de <WeaponEffect_Num:[StateArg1]%>. Au début du tour et après que le porteur a déclenché l'exaltation, il obtient 1 couche de feu intérieur. Lorsque le porteur joue une carte d'instruction ce tour-ci, il consomme 1 couche de « feu intérieur », augmentant ainsi ses dégâts finaux et son bouclier de <WeaponEffect_Num:[StateArg2]%>. Pendant le tour ultra, cela se transforme en « flamme divine » et l'effet est doublé."
  },
  State_117778_Desc = {
    Text = "Ce tour, les dégâts finaux et le bouclier de [Layer] cartes d'instruction augmentent de [StateArg1] %."
  },
  State_117778_Name = {
    Text = "Feu intérieur"
  },
  State_117779_Desc = {
    Text = "Équipe Unique : Au tour Ultra, le porteur obtient 3 niveaux de « Feu intérieur ». Lorsque le porteur joue une carte d'instruction ce tour-ci, il consomme 1 niveau, augmentant ainsi ses Dégâts Finaux et son Bouclier de <WeaponEffect_Num:[StateArg1] %>."
  },
  State_117779_WeaponDesc = {
    Text = "Le Porteur de Tour Ultra obtient 3 niveaux de « Feu intérieur ». Lorsque le porteur joue une carte d'instruction ce tour-ci, il consomme 1 niveau, augmentant ainsi ses Dégâts Finaux et son Bouclier de <WeaponEffect_Num:[StateArg1]%>."
  },
  State_117851_Desc = {
    Text = "Pollux bénéficie de 50 % d'effet « Rédemption de la douleur » supplémentaire pour chaque Carte d'instruction, pendant [Layer] tours."
  },
  State_117851_Name = {
    Text = "Lumière qui illumine la nuit blanche"
  },
  State_117853_Desc = {
    Text = "Pollux, les [Layer] prochaines cartes d'instruction jouées ce tour infligent des dégâts augmentés de [DescArg1] et améliorent le bouclier de [DescArg2], obtenez 10 points de fureur."
  },
  State_117853_Name = {
    Text = "Rédemption de la douleur"
  },
  State_117869_Desc = {
    Text = "Chaque fois que l'exaltation est libérée, augmente de 1 couche « Appel », chaque couche « Appel » accorde [DescArg1] points de force, avec un maximum de 5 couches."
  },
  State_117869_Name = {
    Text = "Prêtresse des marins"
  },
  State_117870_Desc = {
    Text = "Après la mort, le tueur restaure 20% des pv perdus."
  },
  State_117870_Name = {
    Text = "sashimi délicieux"
  },
  State_117875_Desc = {
    Text = "S'il y a des places vacantes dans la rangée arrière, après l'action, perds 1 couche et invoque 1 \"Sushi Délicieux\" \"Fry\""
  },
  State_117875_Name = {
    Text = "Contrat : essaim"
  },
  State_117876_Desc = {
    Text = "Les effets de <WeaknessIconKeywords:faiblesse>, <FragileIconKeywords:fragile>, et <HeavyInjuryKeywords:blighten> augmentent à 50%."
  },
  State_117876_Name = {
    Text = "Faiblesse&Fragile&Aggravation des Blessures"
  },
  State_117880_Desc = {
    Text = "Dans ce combat, le « saut de banc de poissons » sera déclenché une fois de plus."
  },
  State_117880_Name = {
    Text = "Déclenchement supplémentaire du banc de poissons sautant"
  },
  State_117883_Desc = {
    Text = "À 5 couches, scelle immédiatement tous les éveilleurs et change l'intention en : « Gloire de Lémuria ! + »."
  },
  State_117883_Name = {Text = "Appel"},
  State_117885_Desc = {
    Text = "Lorsqu'un effet de réduction de force est appliqué, il inflige également un effet de réduction de force équivalent à l'instigateur."
  },
  State_117885_Name = {
    Text = "Œil pour œil"
  },
  State_117889_Desc = {
    Text = "En entrant, vos hp maximum augmentent de 10% et accordent aux autres alliés un déclenchement supplémentaire de [DescArg1] <PowerIconKeywords:strength> pour le <FishLeapWords:Power of Cohort> dans cette bataille."
  },
  State_117889_Name = {
    Text = "Pouvoir de l'essaim"
  },
  State_118112_Desc = {
    Text = "Les dégâts uniques subis sont limités à [DescArg1] points, supprimés si la vie est inférieure à 50 %."
  },
  State_118112_Name = {
    Text = "Seuil de Douleur I"
  },
  State_118113_Desc = {
    Text = "Après avoir subi des dégâts directs et perdu des points de vie, obtenez un bouclier équivalent à 15 % de la vie perdue et une <AlertIconKeywords:précaution temporaire> de 5 % de la vie perdue."
  },
  State_118113_Name = {
    Text = "Caractéristiques de corps souple I"
  },
  State_118114_Desc = {
    Text = "Après avoir subi des dégâts directs et perdu des points de vie, obtenez un bouclier équivalent à 35 % de la vie perdue et une <AlertIconKeywords:précaution temporaire> de 10 % de la vie perdue."
  },
  State_118114_Name = {
    Text = "Caractéristiques de corps souple III"
  },
  State_118115_Desc = {
    Text = "S'il y a des places vacantes dans la rangée avant, après l'action, perds 1 couche et invoque 1 \"Division des Profondeurs\""
  },
  State_118115_Name = {
    Text = "Contrat de coopération : Excrescence abyssale"
  },
  State_118116_Desc = {
    Text = "Les dégâts uniques subis sont limités à [DescArg1] points, supprimés lorsque la vie est inférieure à 50 %."
  },
  State_118116_Name = {
    Text = "Seuil de Douleur II"
  },
  State_118117_Desc = {
    Text = "Les dégâts uniques subis sont limités à [DescArg1] points, supprimés lorsque la vie est inférieure à 50 %."
  },
  State_118117_Name = {
    Text = "Seuil de Douleur III"
  },
  State_118118_Desc = {
    Text = "Obtenez 1 Tentacule avec des <TentacleInjurieIconKeywords:Dégâts des tentacules> égaux à [TentaclePower:DescArg1] et une Limite des tentacules de 5. À la fin du tour, obtenez 1 Tentacule. Les effets de réduction de Force subis sont réduits de 50 %."
  },
  State_118118_Name = {
    Text = "Assemblage de tentacules"
  },
  State_118119_Desc = {
    Text = "Après avoir subi des dégâts directs et perdu des points de vie, obtenez un bouclier équivalent à 25 % de la vie perdue et une <AlertIconKeywords:précaution temporaire> de 5 % de la vie perdue."
  },
  State_118119_Name = {
    Text = "Caractéristiques de corps souple II"
  },
  State_118319_Desc = {
    Text = "Les dégâts uniques subis sont limités à [DescArg1] points, supprimés si la vie est inférieure à 50 %."
  },
  State_118319_Name = {
    Text = "Limite de dégâts du Bouclier des abysses"
  },
  State_118320_Name = {
    Text = "Compteur de contre-mesure temporaire à l'épuisement"
  },
  State_118321_Name = {
    Text = "Compteur de contre-mesure à l'épuisement"
  },
  State_118322_Name = {
    Text = "Marque de préparation d'invocation"
  },
  State_118323_Desc = {
    Text = "Déclenché par le banc de poissons sautant"
  },
  State_118323_Name = {
    Text = "Marque d'apparition du banc de poissons sautant"
  },
  State_118324_Desc = {
    Text = "Chaque fois que des dégâts sont infligés, une tentacule temporaire est générée."
  },
  State_118324_Name = {
    Text = "Grâce divine"
  },
  State_118325_Desc = {
    Text = "Lorsque des dommages non bloqués sont infligés, mélangez [DescArg1] cartes « étranglement » au sommet de la pile de pioche"
  },
  State_118325_Name = {
    Text = "Homme serpent du nouveau monde tremble"
  },
  State_118656_Desc = {
    Text = "Lorsque vous jouez une carte, subissez [StateArg1] points de dégâts et retirez 1 couche. Lorsque les couches sont à 0, éclosez une «Créature des Mers» plus faible. Si l'état de parasitisme persiste à la fin du tour, éclosez une «Créature des Mers» dont la vie augmente avec les couches"
  },
  State_118656_Name = {
    Text = "Parasité plusieurs fois"
  },
  State_118657_Desc = {
    Text = "Lorsque vous jouez une carte, subissez [StateArg1] points de dégâts et retirez 1 couche. Lorsque les couches sont à 0, éclosez une «Créature des Mers» plus faible. Si l'état de parasitisme persiste à la fin du tour, éclosez une «Créature des Mers» dont la vie augmente avec les couches"
  },
  State_118657_Name = {
    Text = "Être parasité à nouveau"
  },
  State_118659_Desc = {
    Text = "Lorsque vous jouez une carte, subissez [StateArg1] points de dégâts et retirez 1 couche. Lorsque les couches sont à 0, éclosez une «Créature des Mers» plus faible. Si l'état de parasitisme persiste à la fin du tour, éclosez une «Créature des Mers» dont la vie augmente avec les couches"
  },
  State_118659_Name = {Text = "Parasité"},
  State_118663_Name = {
    Text = "Surveillance de l'intention de l'homme serpent du nouveau monde"
  },
  State_118669_Name = {
    Text = "Initialisation homme serpent du nouveau monde"
  },
  State_118670_Desc = {
    Text = "Détection de la contre-mesure à l'épuisement"
  },
  State_118670_Name = {
    Text = "Détection de contre-mesure à l'épuisement"
  },
  State_118671_Desc = {
    Text = "Détection des comportements d'épuisement des joueurs"
  },
  State_118671_Name = {
    Text = "Écoute de la contre-mesure à l'épuisement"
  },
  State_118672_Name = {
    Text = "Surveillance de l'intention de l'homme serpent du nouveau monde en refroidissement"
  },
  State_118741_Name = {
    Text = "Supprimer les tentacules temporaires"
  },
  State_118743_Name = {
    Text = "Préparation de l'invocation, la position préalable nécessite une marque d'invocation"
  },
  State_118759_Name = {
    Text = "Nombre de tentacules permanents du monstre"
  },
  State_118760_Name = {
    Text = "Limite permanente des tentacules de monstre"
  },
  State_118762_Name = {
    Text = "Avertissement de décadence initial"
  },
  State_118763_Name = {
    Text = "Avertissement initial de neurotoxine-Saigner"
  },
  State_118764_Name = {
    Text = "Avertissement de premier souffle de malédiction"
  },
  State_118766_Name = {
    Text = "Surveillance de l'intention du BOSS de poulpe à anneaux bleus"
  },
  State_118769_Name = {
    Text = "Avertissement de la lanterne à Cœur d'argent"
  },
  State_118771_Name = {
    Text = "Avertissement d'essai initial"
  },
  State_118772_Name = {
    Text = "Avertissement de déchirure des serpents pour la première fois"
  },
  State_118935_Name = {
    Text = "Surveillance de l'intention du monstre Murphy"
  },
  State_118938_Desc = {
    Text = "La Demoiselle des Profondeurs s'est Éveillée, augmentant considérablement le montant de Bouclier créé !"
  },
  State_118938_Name = {Text = "Créature"},
  State_118943_Desc = {
    Text = "Les dégâts reçus pendant son propre tour sont doublés. Lors de la perte de vie, perdre un nombre égal de couches. Lorsque le nombre de couches est 0, réduire définitivement le nombre de tentacules de 1 et réinitialiser les couches, avec un minimum de 1 tentacule."
  },
  State_118943_Name = {
    Text = "Sacrifice de la Deipara"
  },
  State_118973_Name = {
    Text = "Gestion de la rébellion contenue"
  },
  State_119051_Desc = {
    Text = "Déclenchement à la fin du tour, subit des dégâts passifs équivalents aux couches et retire la moitié des couches, ne peut pas être dissipé."
  },
  State_119051_Name = {
    Text = "<PVPSacrificeKeyWords:Sacrifice>"
  },
  State_119052_Desc = {
    Text = "Après avoir subi des Dégâts Directs, gagnez un Sacrifice de [Layer] % de dommages."
  },
  State_119052_Name = {
    Text = "Rituel de descente"
  },
  State_119053_Desc = {
    Text = "À la fin du tour, déclenchement, subit [Layer] dégâts passifs et retire la moitié des charges, ne peut pas être dissipé."
  },
  State_119053_Name = {Text = "Sacrifice"},
  State_119058_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : À la fin du tour, applique [StateArg1] <PVPSacrificeKeyWords:Sacrifice> à l'ennemi ayant le moins de Sacrifice, répété [StateArg2] fois. Tous les alliés ne sont plus affectés par les effets de réduction de la <PVPCapKeywords:Limite d'Arithmetica>."
  },
  State_119058_Name = {
    Text = "Repos dans les ténèbres"
  },
  State_119059_Desc = {
    Text = "<PVPWeaponKeywords:roue du destin> : Après « Exaltation », tous les ennemis subissent un sacrifice de [StateArg1]% des dommages après avoir reçu des Dégâts Directs ce tour-ci."
  },
  State_119059_Name = {
    Text = "Toxine à anneau bleu"
  },
  State_119060_Desc = {
    Text = "<PVPWeaponKeywords:roue du destin> : Les dégâts de « attaque » augmentent de [StateArg1] %, après qu'un allié ait joué « attaque », piochez [StateArg3] cartes, pouvant être déclenché au maximum [StateArg2] fois par tour (déjà déclenché [DescArg1] fois)."
  },
  State_119060_Name = {
    Text = "Massacre jusqu'à la fin du monde"
  },
  State_119061_Desc = {
    Text = "<PVPWeaponKeywords:roue du destin> : Les dégâts de toutes les « attaques » alliées augmentent de [StateArg1] %."
  },
  State_119061_Name = {
    Text = "Lumière de l'intellect"
  },
  State_119063_Desc = {
    Text = "À 5 couches, l'intention change pour devenir : « Gloire de Lémuria ! »."
  },
  State_119063_Name = {Text = "Appel"},
  State_119075_Desc = {
    Text = "Cet éveilleur n'est pas encore éveillé... Il s'éveillera lorsqu'il sera sur le point d'être abattu, restaurera sa vie et commencera à se battre sous sa véritable forme"
  },
  State_119075_Name = {
    Text = "Non Réveillé"
  },
  State_119076_Desc = {
    Text = "S'il y a des emplacements libres en première ligne, perdez 1 couche après l'action et invoquez aléatoirement 1 « Éveilleur de Lémuria »."
  },
  State_119076_Name = {
    Text = "Contrat : Lémurie"
  },
  State_119077_Desc = {
    Text = "«Appel» atteint 5 couches, scelle immédiatement tous les éveilleurs."
  },
  State_119077_Name = {
    Text = "Miriame Éveil!"
  },
  State_119077_WeaponDesc = {
    Text = "Au début du prochain tour, obtenez un bouclier équivalent à la vie perdue au tour précédent"
  },
  State_119080_Desc = {
    Text = "Lorsque vous libérez «Mémoire du Chaos» ou «L'aube non oubliée», la clé sélectionnée prend effet 1 fois supplémentaire."
  },
  State_119080_Name = {
    Text = "Venu de l'oubli"
  },
  State_119082_Desc = {
    Text = "Chaque fois qu'un Éveilleur libère une Exaltation, son Aliemus de base +10."
  },
  State_119082_Name = {
    Text = "Fureur épuisée"
  },
  State_119083_Desc = {
    Text = "Lorsque la carte d'instruction est retirée de l'espace hyperspatial, le coût d'Arithmetica est réduit de -1."
  },
  State_119083_Name = {
    Text = "Chemin de l'autre monde"
  },
  State_119084_Desc = {
    Text = "Chaque fois que vous libérez un Décret Clé, le Fragment de clé requis +100."
  },
  State_119084_Name = {
    Text = "Clé d'argent oscillante"
  },
  State_119085_Desc = {
    Text = "Après avoir utilisé la Forge Écarlate, transformez 1 Embryon en Fils de la sainteté, avec un temps de recharge de 3 tours."
  },
  State_119085_Name = {
    Text = "Élevage Écarlate"
  },
  State_119086_Desc = {
    Text = "Temps de recharge de la puissance de reproduction, restant [Layer] tours."
  },
  State_119086_Name = {
    Text = "Force de reproduction - Temps de recharge"
  },
  State_119104_Desc = {
    Text = "Au début du round, gagnez [DescArg1] couches de \"Life Contract.\""
  },
  State_119104_Name = {
    Text = "Rituel de la Mer"
  },
  State_119105_Desc = {
    Text = "Après la mort, perdez tous les \"contrats de vie\". Restaurez 1% des pv max pour chaque couche et augmentez les dégâts de tentacule de 1%."
  },
  State_119105_Name = {Text = "Pacte"},
  State_119106_Name = {
    Text = "Surveillance de l'intention du monstre Délire Murphy"
  },
  State_119107_Name = {
    Text = "Gestion de l'Ordre du Royaume Divin"
  },
  State_119108_Desc = {
    Text = "Lorsque vous perdez des hp, pour chaque 1 couche, gagnez 1 % des hp perdus en <SacrificeKeyWord:sacrifice>."
  },
  State_119108_Name = {
    Text = "Rituel de descente"
  },
  State_119109_Desc = {
    Text = "Lorsque vous subissez des dommages provenant de sources autres que le <SacrificeKeyWord:Sacrifice>, perdez un nombre équivalent d'« Ordre du Royaume Divin » et obtenez un <SacrificeKeyWord:Sacrifice> égal à 50 % des dommages. À 0 charges, gagnez 1 couche de « Contrat du Destin » et réinitialisez les charges."
  },
  State_119109_Name = {
    Text = "Ordre du Royaume Divin"
  },
  State_119132_Desc = {
    Text = "Le dégâts de « attaque » de ce tour augmentent de [Layer] %."
  },
  State_119132_Name = {
    Text = "Attaque & renforcement"
  },
  State_119134_Name = {
    Text = "Avertissement de premier Pionnier de l'illusion"
  },
  State_119359_Name = {
    Text = "Nombre de rituels de clé d'argent"
  },
  State_119362_Name = {
    Text = "Effectuer le rituel"
  },
  State_119363_Name = {
    Text = "Posséder une carte"
  },
  State_119364_Name = {
    Text = "Compteur de rituel de fureur"
  },
  State_119365_Desc = {
    Text = "Tous les éveillés voient leurs effets de régénération de vie et de bouclier augmenter de 40 %."
  },
  State_119365_Name = {
    Text = "Calme et serein"
  },
  State_119366_Desc = {
    Text = "Défaussez pour le faire revenir en main"
  },
  State_119366_Name = {
    Text = "Défaussez pour le faire revenir en main"
  },
  State_119367_Name = {
    Text = "Compteur du Rite de Vie"
  },
  State_119368_Desc = {
    Text = "Au début de chaque tour, obtenez 500 points de s-énergie."
  },
  State_119368_Name = {
    Text = "Clair comme de l'eau de roche"
  },
  State_119369_Desc = {
    Text = "La fureur infligée par tous les éveillés augmente de 50 %."
  },
  State_119369_Name = {
    Text = "Ordre de poids"
  },
  State_119370_Name = {Text = "Relique"},
  State_119373_Name = {
    Text = "L'ennemi impose un sacrifice"
  },
  State_119567_Name = {
    Text = "Cérémonie terminée"
  },
  State_119568_Desc = {
    Text = "Augmentation des dégâts d'attaque subis de [Layer] points."
  },
  State_119568_Name = {
    Text = "Attaque renforcée"
  },
  State_119583_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : avant «Attaque», avant «Compétence», avant la fureur temporaire <StrongEffectKeywords:Amplification> +[StateArg1], chaque effet ne peut être déclenché qu'une fois par tour."
  },
  State_119583_Name = {
    Text = "Nous nous retrouverons enfin"
  },
  State_119588_Name = {
    Text = "cd de Chair"
  },
  State_119589_Name = {Text = "Ultra cd"},
  State_119590_Desc = {
    Text = "Équipe Unique : Après avoir changé de Posture de tentacule, utilisé la Forge Écarlate, ou déclenché «Annihilation», piochez la Carte d'instruction du Porteur ×1 ; chaque effet a un temps de recharge de 3 tours. Après l'Exploration, tous les Éveilleurs de l'équipe gagnent +<WeaponEffect_Num:[StateArg1]%> de Taux de synchronisation."
  },
  State_119590_WeaponDesc = {
    Text = "Changez activement de posture de tentacule (temps de recharge restant [DescArg1] tours), utilisez la Forge Écarlate (temps de recharge restant [DescArg2] tours), après avoir libéré « Annihilation » (temps de recharge restant [DescArg3] tours), piochez 1 carte d'instruction du porteur, chaque effet ayant un temps de recharge de 3 tours. Après l'exploration, le taux de synchronisation obtenu par tous les Éveilleurs est augmenté de <WeaponEffect_Num:[StateArg1]%>."
  },
  State_119591_Name = {
    Text = "CD des profondeurs marines"
  },
  State_119741_Desc = {
    Text = "Tous les éveilleurs bénéficient d'une réduction de 50 % de l'effet de force."
  },
  State_119741_Name = {
    Text = "Malédiction : déclin"
  },
  State_119742_Desc = {
    Text = "Au début de chaque tour, répondez à 15 % de la vie perdue."
  },
  State_119742_Name = {
    Text = "Bénédiction de l'icône : Rêve éternel"
  },
  State_119743_Desc = {
    Text = "La régénération de PV de tous les éveillés est réduite de 50 %."
  },
  State_119743_Name = {
    Text = "Malédiction : mort"
  },
  State_119744_Desc = {
    Text = "«Malédiction de l'icône : Haine de destruction» devient inactif pendant 1 tour."
  },
  State_119744_Name = {
    Text = "Immunité de la malédiction de l'icône : Haine de destruction"
  },
  State_119746_Name = {
    Text = "Nombre de pertes de verrou dimensionnel"
  },
  State_119747_Desc = {
    Text = "Aucun dommage, dure 1 tour."
  },
  State_119747_Name = {
    Text = "Clé d'Argent, montre le chemin"
  },
  State_119748_Desc = {
    Text = "«Malédiction de la statue : Lamentation de la déchéance» devient inactive 1 tour."
  },
  State_119748_Name = {
    Text = "Immunité malédiction de la statue : Lamentation de la déchéance"
  },
  State_119749_Desc = {
    Text = "Au début du tour du Gardien, appliquez 1 couche de <SlowIconKeywords:stagnation> aux cartes en main équivalentes à la quantité de «<Abyssallock:Rêve enchaîné>»."
  },
  State_119749_Name = {
    Text = "Rêve enchaîné"
  },
  State_119750_Name = {
    Text = "Surveillance de l'intention du rideau du ciel"
  },
  State_119751_Name = {
    Text = "Libérer le marqueur de reproduction du rideau"
  },
  State_119752_Desc = {
    Text = "Au début de chaque tour, obtenez 5 % de PV Max en <PowerIconKeywords:Force>, le taux de coup critique temporaire +25 %."
  },
  State_119752_Name = {
    Text = "Bénédiction de l'icône : Rêve de puissance"
  },
  State_119753_Name = {
    Text = "Compteur de la marée des abysses obscurs"
  },
  State_119754_Desc = {
    Text = "La folie infligée par tous les éveillés est réduite de 50 %. À la fin du tour, gagnez 1 niveau de « <DarkEgo:ombre de soi> » : au début du tour, tous les éveillés gagnent 3 points de folie."
  },
  State_119754_Name = {
    Text = "Malédiction : folie"
  },
  State_119755_Name = {
    Text = "Compteur de morts"
  },
  State_119756_Desc = {
    Text = "«Malédiction de l'icône : Soupir de folie» devient inactif 1 tour."
  },
  State_119756_Name = {
    Text = "Immunité à la malédiction de l'icône : Soupir de folie"
  },
  State_119757_Desc = {
    Text = "Au début du tour du Gardien, appliquez 1 charge de <SlowIconKeywords:Stagnation> aux cartes en main équivalentes au nombre de charges de <Abyssallock:Rêve enchaîné>. Chaque fois que « Rideau du paradis » est brisé par des Dégâts Directs, réduisez d'1 charge et scellez complètement l'Éveilleur attaquant pendant 1 tour."
  },
  State_119757_Name = {
    Text = "Rêve enchaîné"
  },
  State_119758_Desc = {
    Text = "Au début de chaque tour, tous les éveillés gagnent 10 points de folie."
  },
  State_119758_Name = {
    Text = "Bénédiction de l'icône : Rêve de la connaissance"
  },
  State_119760_Name = {
    Text = "Écoute de la mort"
  },
  State_119789_Desc = {
    Text = "Au début du tour, récupérez [Layer] points de vie."
  },
  State_119789_Name = {
    Text = "Fleurir de boue"
  },
  State_119837_Desc = {
    Text = "La prochaine carte d'instruction jouée par Ramona ce tour-ci prendra effet 2 fois."
  },
  State_119837_Name = {
    Text = "Se tenir à nouveau la main"
  },
  State_119847_Desc = {
    Text = "Changez le coût en arithmetica de la carte avant de la jouer."
  },
  State_119847_Name = {
    Text = "Changez le coût en arithmetica de la carte avant de la jouer"
  },
  State_119928_Desc = {
    Text = "Après avoir joué, effectue un effet supplémentaire [StateArg1] fois, <DepleteIconKeywords:Consommation>. <RippleKeywords:Réplica> : piochez 2 cartes."
  },
  State_119928_Name = {
    Text = "<Rune_20:Écho des profondeurs>"
  },
  State_119958_Desc = {
    Text = "Après la mort, invoquez un « banc de poissons » aléatoire, réduisez sa « migration des bancs de poissons » de 1 couche."
  },
  State_119958_Name = {
    Text = "Migration des bancs de poissons"
  },
  State_119959_Desc = {
    Text = "Après la mort, invoquez un essaim fœtal aléatoire, réduisez son effet de vie éternelle de 1 couche."
  },
  State_119959_Name = {
    Text = "Vie éternelle"
  },
  State_119960_Desc = {
    Text = "Dégâts Directs et Dégâts des tentacules infligés –35%. Cet état est dissipé lorsque vos PV actuels dépassent 50%."
  },
  State_119960_Name = {
    Text = "<PurpleKeyWord:pourriture>"
  },
  State_120215_Desc = {
    Text = "Au début du tour du Gardien, appliquez 1 charge de <SlowIconKeywords:Stagnation> aux cartes en main équivalentes au nombre de charges de <Abyssallock:Rêve enchaîné>. Chaque fois que « Rideau du paradis » est brisé par des Dégâts Directs, réduisez d'1 charge et scellez complètement l'Éveilleur attaquant pendant 1 tour."
  },
  State_120215_Name = {
    Text = "Verrou dimensionnel"
  },
  State_120216_Desc = {
    Text = "Au début du tour du Gardien, appliquez 1 couche de <SlowIconKeywords:stagnation> aux cartes en main équivalentes au nombre de couches de «<Abyssallock:Verrou dimensionnel>»."
  },
  State_120216_Name = {
    Text = "Verrou dimensionnel"
  },
  State_120218_Name = {
    Text = "Fin du tour, choisissez le soutien de Murphy"
  },
  State_120222_Name = {
    Text = "Sélectionner une malédiction inversée au début du tour"
  },
  State_120292_Name = {
    Text = "Douleur Non Acceptée"
  },
  State_120293_Desc = {
    Text = "À la fin du tour, récupère [Layer] points de vie"
  },
  State_120293_Name = {
    Text = "Douleur Non Acceptée"
  },
  State_120312_Desc = {
    Text = "Après la mort, invoquez un « Roi des poissons » au hasard, réduisez son « Migration des bancs de poissons » de 1 couche."
  },
  State_120312_Name = {
    Text = "Migration des bancs de poissons"
  },
  State_120320_Desc = {
    Text = "Chaque couche augmente de 20 % le « Rituel de descente » appliqué par la « Princesse Illusoire » lors de la prochaine utilisation, pouvant être empilée jusqu'à 5 couches. Une fois 5 couches atteintes, le nombre de dommages infligés par la prochaine attaque de la « Princesse Illusoire » est doublé."
  },
  State_120320_Name = {Text = "Pacte"},
  State_120321_Desc = {
    Text = "Chaque charge inflige des charges de «Sacrifice» égales à 1% des Dégâts Directs ou Dégâts des tentacules reçus. Maximum 75 charges. Retiré en fin de tour."
  },
  State_120321_Name = {
    Text = "<DwmofeiKeywords:Rituel de descente>"
  },
  State_120322_Desc = {
    Text = "Équipe Unique : Limite Max de la Main +2, ne peut pas être cumulée avec d'autres limites de main fournies par la Roue du Destin. La régénération de Fragment de clé du porteur, les Dégâts Finaux infligés par l'Exaltation, et le Bouclier amélioré augmentent de <WeaponEffect_Num:[StateArg1]%. Lorsque le porteur change en posture « Océan Calme », il gagne <WeaponEffect_Num:[StateArg2]> points de Fureur, avec un temps de recharge de 3 tours. Lors du changement en posture « Vagues Déchaînées », <WeaponEffect_Num:[StateArg3]> couches de <DwmofeiKeywords:Rituel de descente> sont appliquées à tous les ennemis, avec un temps de recharge de 3 tours."
  },
  State_120322_WeaponDesc = {
    Text = "Limite Max de la Main +2, ne peut pas être cumulé avec la limite de main fournie par d'autres Roues du Destin. Le Porteur gagne une Régénération de Fragment de clé, les Dégâts Finaux causés par Exaltation et l'amélioration du Bouclier de <WeaponEffect_Num:[StateArg1] %>. Lors du passage à la posture « Océan Calme », le Porteur gagne <WeaponEffect_Num:[StateArg2]> points de Fureur, avec un temps de recharge de 3 tours. Lors du passage à la posture « Vagues Déchaînées », applique <WeaponEffect_Num:[StateArg3]> couches de <DwmofeiKeywords:Rituel de descente> à tous les ennemis, avec un temps de recharge de 3 tours."
  },
  State_120324_Desc = {
    Text = "Chaque charge inflige des charges de «Sacrifice» égales à [Layer]% des Dégâts Directs ou Dégâts des tentacules subis. Maximum 75 charges. Retirées en fin de tour."
  },
  State_120324_Name = {
    Text = "Rituel de descente"
  },
  State_120351_Desc = {
    Text = "Après [Layer] tours, vous pouvez à nouveau changer «Royaume Divin · Océan Calme»."
  },
  State_120351_Name = {
    Text = "Royaume Divin · Océan Calme en refroidissement"
  },
  State_120354_Desc = {
    Text = "Après [Layer] tours, vous pourrez à nouveau changer «Royaume Divin·Vagues Déchaînées»."
  },
  State_120354_Name = {
    Text = "Royaume Divin·Vagues Déchaînées en refroidissement"
  },
  State_120357_Name = {Text = "Tentacule"},
  State_120362_Desc = {
    Text = "En recevant des dégâts autres que ceux de <SacrificeKeyWord:sacrifice>, gagnez 50 % des dégâts en <SacrificeKeyWord:sacrifice>"
  },
  State_120362_Name = {
    Text = "Gestion des sacrifices de monstres généraux"
  },
  State_120363_Desc = {
    Text = "Après la fin du tour, subit [Layer] points de dégâts et réduit de 50% les couches de <SacrificeKeyWord:sacrifice>."
  },
  State_120363_Name = {
    Text = "<BlueKeyWord:Sacrifice>"
  },
  State_120364_Desc = {
    Text = "Invocation du « Garde du Marcheur des Mers » après votre mort."
  },
  State_120364_Name = {
    Text = "La foi perdure"
  },
  State_120401_Desc = {
    Text = "La consommation d'arithmetica de cette carte est réduite de -[StateArg5], après avoir joué, piochez [StateArg4] cartes."
  },
  State_120401_Name = {
    Text = "<OrangeQuality:Badge de Missag>"
  },
  State_120450_Name = {
    Text = "Enregistrement des PV du poulpe à anneaux bleus"
  },
  State_120462_Desc = {
    Text = "Reste dans le deck après la bataille, mais sera définitivement retirée après avoir été jouée ou consommée."
  },
  State_120462_Name = {
    Text = "<DestructionKeywords:Détruire>"
  },
  State_120900_Name = {
    Text = "Préparez l'invocation « Éveilleur de Lémuria » compte"
  },
  State_120907_Desc = {
    Text = "Lorsqu'une attaque de tentacule est bloquée, appliquez [DescArg1] couches de <IntoxicationIconKeywords:poison>."
  },
  State_120907_Name = {
    Text = "courant sombre"
  },
  State_120908_Desc = {
    Text = "Lorsqu'une attaque de tentacule est bloquée, infligez un <IntoxicationIconKeywords:poison> équivalent au nombre de charges."
  },
  State_120908_Name = {
    Text = "courant sombre"
  },
  State_120910_Desc = {
    Text = "La consommation d'arithmetica de cette carte est +[StateArg5]. Après avoir joué, piochez [StateArg4] cartes."
  },
  State_120910_Name = {
    Text = "<OrangeQuality:Badge de Missag>"
  },
  State_120924_Desc = {
    Text = "Au début du prochain tour, obtenez forteresse."
  },
  State_120924_Name = {
    Text = "Renforcement retardé"
  },
  State_120929_Desc = {
    Text = "La carte conserve son utilisation, mais lorsqu'elle est jouée, elle éliminera la pollution et invoquera 1 « Excrescence abyssale ». S'il n'y a pas d'espace pour invoquer, elle gagnera 1 couche de « Prépare l'invocation : Excrescence abyssale »."
  },
  State_120929_Name = {
    Text = "<SeastriderCurse:La Malédiction du Marcheur des Mers>"
  },
  State_120930_Desc = {
    Text = "S'il y a des emplacements libres, perdez 1 couche après l'action et invoquez 1 « Excrescence abyssale »."
  },
  State_120930_Name = {
    Text = "Contrat de coopération : Excrescence abyssale"
  },
  State_120934_Desc = {
    Text = "Chaque fois que vous subissez des Dégâts Critiques, obtenez 3 % de <Baojidikang:Résistance Critique Temporaire>. Au début de chaque tour, appliquez « <SeastriderCurse:malédiction du Marcheur des mers> » à 2 cartes."
  },
  State_120934_Name = {
    Text = "Cérémonie des profondeurs marines"
  },
  State_120941_Desc = {
    Text = "Augmente les compétences de l'ennemi. Perd une couche à chaque fois qu'il subit des dégâts"
  },
  State_120941_Name = {
    Text = "Serment de sang"
  },
  State_121006_Desc = {
    Text = "Équipe Unique : La régénération de Fragment de clé du porteur, les Dégâts Finaux causés par l'exaltation et le Bouclier amélioré augmentent de <WeaponEffect_Num:[StateArg1]%>."
  },
  State_121006_WeaponDesc = {
    Text = "La régénération de Fragment de clé du porteur, les dégâts finaux causés par l'exaltation de la folie et le bouclier amélioré augmentent de <WeaponEffect_Num:[StateArg1] %>."
  },
  State_121014_Name = {
    Text = "Protection du Saint Fœtus"
  },
  State_121015_Desc = {
    Text = "Au début du tour, le bouclier ne sera pas supprimé. Lorsque vous avez un bouclier, vous disposez de 50 couches de <ReinforcePVEKeywords:Forteresse>, et <ReinforcePVEKeywords:Forteresse> est retiré lorsque le bouclier est brisé."
  },
  State_121015_Name = {
    Text = "Protection du Saint Fœtus"
  },
  State_121151_Desc = {
    Text = "La carte obtient Garder, mais après avoir joué, elle supprimera la pollution et invoquera 1 « Excrescence abyssale ». S'il n'y a pas d'emplacement pour invoquer, elle gagnera 1 couche de « Préparer l'invocation : Excrescence abyssale »."
  },
  State_121151_Name = {
    Text = "<SeastriderCurse:La Malédiction du Marcheur des Mers>"
  },
  State_121210_Name = {
    Text = "Accorde à tous les ennemis un effet négatif <PVPWonderfulEffectKeywords:effet merveilleux>, actif 2 fois"
  },
  State_121211_Name = {
    Text = "Piochez 2 cartes, obtenez 2 points d'arthmetica"
  },
  State_121212_Name = {
    Text = "Accorde à tous les alliés un effet positif <PVPWonderfulEffectKeywords:merveilleux effet>, actif 2 fois"
  },
  State_121213_Desc = {
    Text = "Immunité à tous les dégâts."
  },
  State_121213_Name = {
    Text = "Immunité à tous les dégâts."
  },
  State_121231_Desc = {
    Text = "Chaque couche augmente la prochaine application \"Princesse Abyssale\" du \"Rituel de Sacrifice\" de 20%, s'accumulant jusqu'à 5 couches, et lorsqu'elles sont empilées à 5 couches, le prochain compte de dégâts de \"Princesse Abyssale\" est doublé."
  },
  State_121231_Name = {
    Text = "<MingqiKeywords:Contrat du Destin>"
  },
  State_121365_Desc = {
    Text = "Subir [Layer] % de dégâts de tentacules supplémentaires."
  },
  State_121377_Name = {
    Text = "<RetainIconKeywords:Garder> : Au début de chaque tour, gagnez 500 points de s-énergie"
  },
  State_121378_Name = {
    Text = "<RetainIconKeywords:Garder>: Tous les éveillés voient leurs effets de régénération de vie et de bouclier augmenter de 40 %"
  },
  State_121380_Name = {
    Text = "<RetainIconKeywords:Garder> : La folie infligée par tous les éveillés augmente de 50 %"
  },
  State_121719_Name = {
    Text = "<RippleKeywords:Réplica> : Piochez 1 carte, obtenez [DescArg1] points de force temporaire."
  },
  State_121734_Desc = {
    Text = "Chaque fois qu'une carte de commandement est jouée, défaussez une carte du réveilleur ayant la consommation d'arithmétique la plus faible."
  },
  State_121734_Name = {
    Text = "Flux de Folie"
  },
  State_121735_Desc = {
    Text = "Toutes les cartes de commandement voient leur consommation d'arithmétique augmenter de 1. Tous les 3 tours, ajoutez 1 carte « Pétrification progressive » à la main à la fin du tour."
  },
  State_121735_Name = {
    Text = "Torrent de Lamentations"
  },
  State_121736_Desc = {
    Text = "À la fin du tour, récupère 10 % des PV perdus, dissipe les états négatifs du personnage et les états positifs du joueur."
  },
  State_121736_Name = {
    Text = "Flux de l'Arrivée"
  },
  State_121737_Desc = {
    Text = "Au début du combat, obtenez 15 couches de « barrière temporaire ». À la fin du tour, obtenez 15 couches de « barrière temporaire » et appliquez « dissolution temporaire » sur 10 cartes aléatoires."
  },
  State_121737_Name = {
    Text = "Courant Glacé"
  },
  State_121738_Desc = {
    Text = "L'effet <PowerIconKeywords:force> appliqué par les éveillés est réduit de 75 %. À chaque fois que vous perdez des points de vie, vous obtenez <Block:[Block:DescArg1]> points de bouclier et 1 couche de renforcement temporaire."
  },
  State_121738_Name = {
    Text = "Flux de la Croyance Maléfique"
  },
  State_121739_Desc = {
    Text = "La limite de folie de tous les réveilleurs augmente de 50 %. À la fin de chaque tour, tous les réveilleurs perdent 10 points de folie et récupèrent 3 % de leur vie maximum."
  },
  State_121739_Name = {
    Text = "Flux de Terreur"
  },
  State_121740_Desc = {
    Text = "Au début du combat et à la fin de chaque tour, obtient 2 couches temporaires de <ResentChainsKeywords:Chaîne de Rancœur>."
  },
  State_121740_Name = {
    Text = "Courant Étrange"
  },
  State_121797_Desc = {
    Text = "Réduit tous les Dommages infligés, les soins et les effets de Bouclier de 10%, maximum 2 couches, ne peut pas être dissipé. Tous les effets d'Ivresse sur la cible sont retirés à la mort du dernier applicateur d'Ivresse."
  },
  State_121797_Name = {
    Text = "<PVPLostSoulKeyWords:Enchanté>"
  },
  State_121798_Desc = {
    Text = "Les Dommages infligés, les soins et les effets de Bouclier sont réduits de [DescArg1]%, impossible à dissiper. Maximum 2 charges.\nRetiré après avoir éliminé <StatusApplier:>."
  },
  State_121798_Name = {Text = "Spellbound"},
  State_121799_Name = {
    Text = "Carte de soutien de Lémurie, chapitre quatre"
  },
  State_121850_Desc = {
    Text = "Dommages des tentacules réduits de 80 %"
  },
  State_121850_Name = {
    Text = "Goliath: Soutien"
  },
  State_121863_Name = {
    Text = "<RippleKeywords:Réplica> : Piochez 2 cartes"
  },
  State_121878_Name = {
    Text = "Première sélection du scénario de malédiction inversée"
  },
  State_122428_Desc = {
    Text = "Cet éveilleur n'est pas encore éveillé... Il s'éveillera lorsqu'il sera sur le point d'être abattu, restaurera sa vie et commencera à se battre sous sa véritable forme"
  },
  State_122428_Name = {
    Text = "Non Réveillé"
  },
  State_122431_Desc = {
    Text = "Lorsque Mouchette inflige des Dommages non bloqués, gagnez 2 charges de <Monster_Fervor:Ferveur Temporaire>."
  },
  State_122431_Name = {
    Text = "Héritage du brouillard"
  },
  State_122441_Desc = {
    Text = "<PVPWeaponKeywords:roue du destin> : En s'équipant, obtenez 3 couches de <PVPReciprocalKeywords:Moment du compte à rebours>."
  },
  State_122441_Name = {
    Text = "Moment du compte à rebours"
  },
  State_122442_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin>: Équipez pour gagner un <Block:[Block:StateArg1]> Bouclier et <Energy:[Energy:StateArg1]> Aliemus. À la fin du tour, cette Roue du Destin se déséquipe automatiquement, augmentant l'Aliemus et le Bouclier gagnés lors de la prochaine équipe de « Boîte de l'Enfance » de [StateArg2]."
  },
  State_122442_Name = {
    Text = "Enfance dans la boîte"
  },
  State_122443_Desc = {
    Text = "Au début du tour, le nombre de piles - 1. Une fois les piles épuisées, dissipez les debuffs de vous-même et gagnez 100 Aliemus, puis récupérez 3 piles de Compte à rebours. Changer la Roue du Destin supprimera l'état de Compte à rebours."
  },
  State_122443_Name = {
    Text = "<PVPFlowerKeywords:Moment du compte à rebours>"
  },
  State_122596_Desc = {
    Text = "Impossible à jouer la carte, incapable de libérer l'exaltation."
  },
  State_122596_Name = {
    Text = "<Seal1:Scellé>"
  },
  State_122636_Desc = {
    Text = "Les dégâts, la guérison et le bouclier du premier «skill» joué chaque tour augmentent de [StateArg1]% ."
  },
  State_122636_Name = {
    Text = "Broche de Rubis"
  },
  State_122650_Desc = {
    Text = "Relique <OrangeQuality:Gants magiques> a ajouté cette carte."
  },
  State_122650_Name = {
    Text = "Carte étrange"
  },
  State_122654_Name = {
    Text = "Chaque fois qu'un tour commence et qu'une action se termine, il essaiera de réinitialiser la pile de cartes du joueur si elle est vide, sinon elle ne sera pas réinitialisée."
  },
  State_122706_Name = {
    Text = "<CardKeyWord:Souhait de retrouvailles>"
  },
  State_122707_Desc = {
    Text = "Traiter ceci comme la dernière «Compétence» jouée ce tour. Coût d'Arithmetica -1."
  },
  State_122707_Name = {
    Text = "<CardKeyWord:Souhait de retrouvailles>"
  },
  State_123109_Desc = {
    Text = "Équipe Unique : Lors du premier achat d'une « Oraison » dans « Trace de fusion », ou lors du premier achat d'articles à prix réduit dans les « Ruines Cendrées », il y a <WeaponEffect_Num:[StateArg1]%> de chance que le coût en Marque noire devienne 0. Cet effet peut se produire un maximum de 1 fois par exploration."
  },
  State_123109_WeaponDesc = {
    Text = "Lors du premier achat d'une « Oraison » dans la « Trace de fusion », ou lors du premier achat d'articles en promotion dans les « Ruines Cendrées », il y a <WeaponEffect_Num:[StateArg1]%> de chances que le sigil noir requis devienne 0. Cet effet peut se produire un maximum de 1 fois par exploration."
  },
  State_123177_Desc = {
    Text = "Effacez au début du tour. Après avoir atteint 10 couches, agissez immédiatement après avoir joué la prochaine carte, en retirant « Ferveur temporaire » et en ajoutant l'intention « Explosion humaine »."
  },
  State_123177_Name = {Text = "Ferveur"},
  State_123178_Desc = {
    Text = "<Guaiwusiwangdikang:Résistance à la mort> est multiplié par 5. Pour chaque carte jouée par l'ennemi, gagnez 1 couche de <Monster_Fervor:Ferveur Temporaire>."
  },
  State_123178_Name = {
    Text = "mauvaise humeur au réveil"
  },
  State_123243_Desc = {
    Text = "Éliminer un ennemi supprime toutes les charges de cet état. Gagne le même nombre de charges en Aliemus pour chaque charge supprimée. Limite de 2 charges."
  },
  State_123243_Name = {Text = "vortex"},
  State_123246_Desc = {
    Text = "Lors de l'Élimination d'un ennemi, retirez toutes les charges et gagnez un montant égal de Fureur. Maximum de 2 charges."
  },
  State_123246_Name = {
    Text = "<PVPWaterPowerKeyWords:Vortex>"
  },
  State_123294_Desc = {
    Text = "Ce tour, [DescArg1] cartes ont été tirées par \"Frappe\"."
  },
  State_123294_Name = {Text = "Slaughter"},
  State_123507_Desc = {
    Text = "Équipe Unique : Au début de l'exploration, ajoutez 1 \"Moment de Compte à Rebours : 5\" au deck : Après avoir joué, piochez 1 carte et mélangez le prochain \"Moment de Compte à Rebours\" dans la pile de défausse. \"<DestructionKeywords:Détruire>\". \"Moment de Compte à Rebours : 0\" : Piochez 3 cartes, gagnez 3 Arithmétique, et avez une chance de <WeaponEffect_Num:[StateArg1]%> de mélanger \"Moment de Compte à Rebours : 5\" dans la pile de défausse. Conservez. \"<DestructionKeywords:Détruire>\"."
  },
  State_123507_WeaponDesc = {
    Text = "Au début de l'exploration, ajoutez 1 \"Compte à rebours : 5\" au deck : Après avoir joué, piochez 1 carte et mélangez le prochain \"Compte à rebours\" dans la pile de défausse. \"<DestructionKeywords:Détruire>\". \"Compte à rebours : 0\" : Piochez 3 cartes, gagnez 3 Arithmetica, et avez une chance de <WeaponEffect_Num:[StateArg1]%> de mélanger \"Compte à rebours : 5\" dans la pile de défausse. Conserver. \"<DestructionKeywords:Détruire>\"."
  },
  State_123520_Desc = {
    Text = "Équipe unique : Après la première libération de Posse chaque tour, il y a <WeaponEffect_Num:[StateArg1]>% de chances de piocher 1 \"Frappe\" du porteur."
  },
  State_123520_WeaponDesc = {
    Text = "Après la première libération de Posse chaque tour, il y a une chance de <WeaponEffect_Num:[StateArg1]>% de piocher 1 \"Frappe\" du porteur."
  },
  State_123521_Desc = {
    Text = "Équipe unique : Les dégâts de base de l'Exalt et de la Poursuite du porteur +<WeaponEffect_Num:[StateArg1]%>. Après avoir joué \"Frappe\" de tout Éveilleur ce tour-ci, les dégâts de \"Frappe\" du porteur augmentent temporairement de <WeaponEffect_Num:[StateArg2]%> de l'ATK du porteur. Cet effet peut se déclencher jusqu'à 8 fois par tour."
  },
  State_123521_WeaponDesc = {
    Text = "Les dégâts de base de l'Exalt et de la Poursuite du porteur +<WeaponEffect_Num:[StateArg1] %>. Après avoir joué \"Frappe\" de tout Éveilleur ce tour-ci, les dégâts de \"Frappe\" du porteur augmentent temporairement de <WeaponEffect_Num:[DescArg2]>. Cet effet peut se déclencher jusqu'à 8 fois par tour."
  },
  State_123810_Desc = {
    Text = "Remplacer l'intention actuelle de l'ennemi par « Incapable d'agir »."
  },
  State_123810_Name = {
    Text = "<HunmiKeywords:Évanoui>"
  },
  State_123812_Desc = {
    Text = "À la fin du tour, la consommation d'énergie est réduite."
  },
  State_123812_Name = {
    Text = "<PrepareKeywords:Prépare>"
  },
  State_123994_Desc = {
    Text = "Impossible d'effectuer des actions."
  },
  State_123994_Name = {
    Text = "Sommeil raffiné"
  },
  State_124010_Desc = {
    Text = "Au début du prochain tour, obtenez [Layer] arithmetica."
  },
  State_124010_Name = {
    Text = "Arithmetica de retard"
  },
  State_124024_Desc = {
    Text = "Ce tour, [Layer] cartes \"Frappe\" ont été jouées, déclenchant \"Rencontre dramatique\" [DescArg1] fois."
  },
  State_124024_Name = {
    Text = "Rencontre dramatique"
  },
  State_124034_Desc = {
    Text = "Les dégâts de \"frappe\" de tous les Éveilleurs sont augmentés de [StateArg1] pendant [Layer] tours."
  },
  State_124034_Name = {
    Text = "Tornade Éclatante☆"
  },
  State_124037_Desc = {
    Text = "Nombre de dégâts de Mouchette +1, les dégâts de « frapper » de tous les Éveilleurs augmentent de [StateArg1], pendant [Layer] tours."
  },
  State_124037_Name = {
    Text = "Tornade Éclatante☆"
  },
  State_124107_Desc = {
    Text = "À la mort du « Germe des Étoiles », devenez immunisé contre tous les dégâts et réveillez-vous, doublant ainsi votre vie maximale et gagnant une vie maximale équivalente aux PV restants. Après le réveil, dissipez tous les états négatifs."
  },
  State_124107_Name = {
    Text = "Non Réveillé"
  },
  State_124108_Name = {
    Text = "Compteur des voix d'au-delà"
  },
  State_124109_Desc = {
    Text = "Vous obtenez un bonus supplémentaire de 5 % de <PowerIconKeywords:force> grâce à <RetaliateIconKeywords:Contre>. Après avoir perdu [DescArg1] PV en un seul tour, échangez de place avec le \"Chanteur\""
  },
  State_124109_Name = {
    Text = "Cradle Secondaire"
  },
  State_124111_Desc = {
    Text = "L'effet de récupération de vie de la résistance à la mort est augmenté à 25 %. Pour chaque carte de commande jouée par l'ennemi, <TouquKeywords:Voler> temporairement [DescArg1] <PowerIconKeywords:FOR>."
  },
  State_124111_Name = {
    Text = "Éclat Stellaire Sans Limites"
  },
  State_124112_Desc = {
    Text = "À la mort du « Chanteur », devenez immunisé contre tous les dégâts et réveillez-vous, doublant la vie maximale et gagnant une vie maximale équivalente à la vie restante."
  },
  State_124112_Name = {
    Text = "Non Réveillé"
  },
  State_124113_Desc = {
    Text = "L'adversaire ne défaussera pas sa main à la fin de son tour. À la fin du tour, appliquez 2 charges de <FragileIconKeywords:fragilité>, <WeaknessIconKeywords:faiblesse>, <HeavyInjuryKeywords:blessure grave>, et <VulnerabilityIconKeywords:vulnérable> dans cet ordre."
  },
  State_124113_Name = {
    Text = "Voix hors du monde"
  },
  State_124115_Desc = {
    Text = "Les effets de <FragileIconKeywords:Fragile>, <HeavyInjuryKeywords:Corruption> et <WeaknessIconKeywords:Symptôme : Affaiblir> sont augmentés à 50%. Après avoir joué [DescArg1] carte(s) de <SlowIconKeywords:Stase> supplémentaire(s), échange de position avec «Germe Stellaire»."
  },
  State_124115_Name = {
    Text = "Voyageur planétaire"
  },
  State_124121_Name = {
    Text = "Nombre de voyageurs planétaires"
  },
  State_124122_Name = {
    Text = "Joueur Voyageur Planétaire Écouteur"
  },
  State_124190_Desc = {
    Text = "Vous gagnez un bonus supplémentaire de 5 % de <PowerIconKeywords:Force> de <RetaliateIconKeywords:Contre>."
  },
  State_124190_Name = {
    Text = "Cradle Secondaire"
  },
  State_124193_Name = {
    Text = "La récupération de santé de la résistance à la mort est augmentée à 25%."
  },
  State_124198_Desc = {
    Text = "Les effets de <FragileIconKeywords:Fragile>, <HeavyInjuryKeywords:Corruption> et <WeaknessIconKeywords:Symptôme : Affaiblir> infligés sont augmentés à 50%."
  },
  State_124198_Name = {
    Text = "Voyageur planétaire"
  },
  State_124277_Desc = {
    Text = "Visualisation des valeurs intermédiaires du processus d'exécution."
  },
  State_124277_Name = {
    Text = "Valeur d'impression 2"
  },
  State_124278_Desc = {
    Text = "Visualisation des valeurs intermédiaires du processus d'exécution."
  },
  State_124278_Name = {
    Text = "Imprimer la valeur 4"
  },
  State_124279_Desc = {
    Text = "Visualisation des valeurs intermédiaires du processus d'exécution."
  },
  State_124279_Name = {
    Text = "Imprimer la valeur 5"
  },
  State_124280_Desc = {
    Text = "Visualisation des valeurs intermédiaires du processus d'exécution."
  },
  State_124280_Name = {
    Text = "Valeur d'impression 1"
  },
  State_124282_Desc = {
    Text = "Visualisation des valeurs intermédiaires du processus d'exécution."
  },
  State_124282_Name = {
    Text = "Imprimer la valeur 7"
  },
  State_124283_Desc = {
    Text = "Visualisation des valeurs intermédiaires du processus d'exécution."
  },
  State_124283_Name = {
    Text = "Imprimer la valeur 8"
  },
  State_124284_Desc = {
    Text = "Visualisation des valeurs intermédiaires du processus d'exécution."
  },
  State_124284_Name = {
    Text = "Imprimer la valeur 9"
  },
  State_124285_Desc = {
    Text = "Visualisation des valeurs intermédiaires du processus d'exécution."
  },
  State_124285_Name = {
    Text = "Imprimer la valeur 10"
  },
  State_124286_Desc = {
    Text = "Visualisation des valeurs intermédiaires du processus d'exécution."
  },
  State_124286_Name = {
    Text = "Imprimer la valeur 6"
  },
  State_124287_Desc = {
    Text = "Visualisation des valeurs intermédiaires du processus d'exécution."
  },
  State_124287_Name = {
    Text = "Imprimer la valeur 3"
  },
  State_124736_Desc = {
    Text = "Vérifiez si le paramètre 3 de l'interface BEAttachPostAction filtre correctement ou déclenche le déclencheur correspondant."
  },
  State_124736_Name = {
    Text = "Test d'auditeur 1"
  },
  State_124747_Desc = {
    Text = "Vérifiez si le paramètre 3 de l'interface BEAttachPostAction filtre correctement ou déclenche le déclencheur correspondant."
  },
  State_124747_Name = {
    Text = "Test d'auditeur 2"
  },
  State_124748_Desc = {
    Text = "Lorsque l'ennemi joue des cartes <BurningKeywords:Brûlure>, accordez-vous 1 pile de <MonsterExFlameKeywords:Combustion>, mais réduisez temporairement [DescArg1] <PowerIconKeywords:FOR>."
  },
  State_124748_Name = {
    Text = "Flamme inextinguible"
  },
  State_124752_Desc = {
    Text = "Vérifiez si le paramètre 3 de l'interface BEAttachPostAction filtre correctement ou déclenche le déclencheur correspondant."
  },
  State_124752_Name = {
    Text = "Test d'auditeur 3"
  },
  State_124753_Desc = {
    Text = "Vérifiez si le paramètre 3 de l'interface BEAttachPostAction filtre correctement ou déclenche le déclencheur correspondant."
  },
  State_124753_Name = {
    Text = "Test d'auditeur 4"
  },
  State_124754_Desc = {
    Text = "Vérifiez si le paramètre 3 de l'interface BEAttachPostAction filtre correctement ou déclenche le déclencheur correspondant."
  },
  State_124754_Name = {
    Text = "Test d'auditeur 5"
  },
  State_124765_Desc = {
    Text = "Taux critique augmenté de [Layer] %"
  },
  State_124765_Name = {
    Text = "Taux Critique"
  },
  State_124766_Desc = {
    Text = "Dans ce combat, le taux critique augmente de [Layer] %"
  },
  State_124766_Name = {
    Text = "Taux Critique"
  },
  State_124766_WeaponDesc = {
    Text = "Dans ce combat, le taux critique augmente de [Layer] %"
  },
  State_124767_Desc = {
    Text = "Dégâts critiques augmentés de [Layer] %"
  },
  State_124767_Name = {
    Text = "Dégâts Critiques"
  },
  State_124811_Desc = {
    Text = "Vérifiez si le paramètre 3 de l'interface BEAttachPostAction filtre correctement ou déclenche le déclencheur correspondant."
  },
  State_124811_Name = {
    Text = "Test d'auditeur 8"
  },
  State_124812_Desc = {
    Text = "Vérifiez si le paramètre 3 de l'interface BEAttachPostAction filtre correctement ou déclenche le déclencheur correspondant."
  },
  State_124812_Name = {
    Text = "Test d'auditeur 7"
  },
  State_124813_Desc = {
    Text = "Vérifiez si le paramètre 3 de l'interface BEAttachPostAction filtre correctement ou déclenche le déclencheur correspondant."
  },
  State_124813_Name = {
    Text = "Test d'auditeur 6"
  },
  State_124826_Desc = {
    Text = "Vérifiez si le paramètre 3 de l'interface BEAttachPostAction filtre correctement ou déclenche le déclencheur correspondant."
  },
  State_124826_Name = {
    Text = "Test d'auditeur 9"
  },
  State_124843_Desc = {
    Text = "Vérifiez l'écouteur de BSTAfterAttachPostAction et de BSTAfterDoActiveDamage.AttachPostAction"
  },
  State_124843_Name = {
    Text = "Test d'auditeur 9"
  },
  State_124886_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Après que le porteur joue une carte de compétence, piochez [StateArg1] cartes, en priorisant les cartes des autres Éveilleurs. L'effet ne peut s'activer qu'une fois par tour."
  },
  State_124886_Name = {
    Text = "Roue du destin"
  },
  State_124887_Desc = {
    Text = "Le nombre de dommages de «Filage» de cet Éveilleur augmente de [Layer]."
  },
  State_124887_Name = {Text = "Textile"},
  State_124888_Desc = {
    Text = "Se transforme en une «Compétence» ennemie aléatoire avec un coût -1 après avoir été jouée."
  },
  State_124888_Name = {
    Text = "<CardKeyWord:Prophétie>"
  },
  State_124890_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin>: Après « Exaltation », faites en sorte que la prochaine « compétence » jouée [StateArg1] s'active 2 fois."
  },
  State_124890_Name = {
    Text = "Tissage Perpétuel"
  },
  State_124892_Name = {
    Text = "<CardKeyWord:Prophétie>"
  },
  State_124916_Desc = {
    Text = "À la fin du tour, retire toutes les charges et inflige [DescArg1] dégâts passifs. Ne peut pas être dissipé."
  },
  State_124916_Name = {
    Text = "Mort du Destin"
  },
  State_124917_Desc = {
    Text = "À la fin du tour, retire toutes les charges et inflige des dégâts passifs. Ne peut pas être dissipé."
  },
  State_124917_Name = {
    Text = "<PVPDestinedDeathKeyWords:Mort du Destin>"
  },
  State_124992_Desc = {
    Text = "Les [DescArg1] prochaines cartes «Compétence» prennent effet 1 fois supplémentaire."
  },
  State_124992_Name = {
    Text = "Transcender"
  },
  State_124993_Desc = {
    Text = "Les Dégâts Directs fatals infligés et subis sont appliqués sous forme d'un montant égal de <PVPDestinedDeathKeyWords:Présage du Destin>. Ne peut pas être dissipé."
  },
  State_124993_Name = {
    Text = "Moïra, telle que je la décrète"
  },
  State_124997_Desc = {
    Text = "Les Dégâts Directs mortels infligés ou reçus sont remplacés par l'application d'un montant équivalent de <PVPDestinedDeathKeyWords:Présage du Destin>. Impossible à dissiper."
  },
  State_124997_Name = {
    Text = "<PVPEternalDimensionKeyWords:Moïra, telle que je la décrète>"
  },
  State_125002_Name = {
    Text = "État@Écoute de la valeur du bouclier après la phase de défausse des joueurs généraux"
  },
  State_125003_Name = {
    Text = "Valeur de bouclier"
  },
  State_125004_Name = {
    Text = "État@Appliquer le nombre de boucliers aux joueurs"
  },
  State_125472_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Après une « Explosion de Folie », applique [StateArg1] stack(s) de <PVPLostSoulKeyWords:Ivresse> à l'ennemi avec <HPAndShieldMax:la vie et le bouclier les plus élevés>."
  },
  State_125472_Name = {
    Text = "Attrait de magnolia"
  },
  State_125486_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Après que les autres alliés déclenchent « Exaltation », réduisez le Coût d'Arithmetica de toutes les « Compétences » du Porteur dans la Main de [StateArg1]."
  },
  State_125486_Name = {
    Text = "Vains Regrets"
  },
  State_125925_Desc = {
    Text = "Cet éveilleur n'est pas encore éveillé... Il s'éveillera lorsqu'il sera sur le point d'être abattu, restaurera sa vie et commencera à se battre sous sa véritable forme"
  },
  State_125925_Name = {
    Text = "Non Réveillé"
  },
  State_125926_Name = {
    Text = "État@Monstre Tawil Intention de changement Écouteur de joueur"
  },
  State_125927_Desc = {
    Text = "Après avoir joué [DescArg1] cartes de commandement, changez l'intention en « Six Ailes »."
  },
  State_125927_Name = {
    Text = "Ailes naissantes"
  },
  State_125928_Desc = {
    Text = "Après avoir joué une carte de commandement, scellez l'Exalt de l'éveillé correspondant et toutes les cartes de commandement pendant 2 tours."
  },
  State_125928_Name = {
    Text = "Ailes traversant le temps"
  },
  State_125929_Desc = {
    Text = "Après avoir subi [DescArg1] de dégâts en un seul tour, gagnez 70 couches de <ReinforceColour:Forteresse> temporaire et 1 couche de <ResentChainsKeywords:Chaînes de ressentiment>."
  },
  State_125929_Name = {
    Text = "Existence inexistante"
  },
  State_125933_Desc = {
    Text = "Après avoir joué [DescArg1] cartes de commandement, changez l'intention en « Quatre ailes »."
  },
  State_125933_Name = {
    Text = "Ailes déployées pour la première fois"
  },
  State_125934_Desc = {
    Text = "Lorsque vous consommez de l'arithmetica, le fragment de clé obtenu est réduit de 50 %. Après que la tour a infligé des dommages non bloqués, ajoutez 1 carte « <DerivativeCardKeywords_131:Vrai·Paradoxe de la Roue de la Réincarnation> » à votre main."
  },
  State_125934_Name = {
    Text = "Traverser la porte de la clé d'argent"
  },
  State_125935_Name = {Text = "Silence"},
  State_125935_WeaponDesc = {
    Text = "Lorsque vous le piochez, vous êtes affaibli pendant 1 tour. Après usage, affaiblissez tous les ennemis pendant 1 tour. Ne peut pas être vendu"
  },
  State_125937_Desc = {
    Text = "Après avoir joué une carte de commandement, scellez l'Exalt de l'éveillé correspondant et toutes les cartes de commandement pendant 2 tours."
  },
  State_125937_Name = {
    Text = "Ailes traversant le temps"
  },
  State_125964_Desc = {
    Text = "Lors de la consommation d›Arithmetica, les Fragments de clé gagnés –50%. Après que Tawil inflige des Dommages non bloqués, placer 1 «<DerivativeCardKeywords_131:Vrai·Paradoxe de la Roue de la Réincarnation>» en main."
  },
  State_125964_Name = {
    Text = "Traverser la porte de la clé d'argent"
  },
  State_126010_Desc = {
    Text = "Équipe unique : Le poison fixe et les effets de poison déclenchés par le porteur augmentent de <WeaponEffect_Num:[StateArg1]%>, et le <EmbryoFusionIconKeywords:Fusion d'embryon> automatiquement restauré dans le Royaume de Caro est augmenté de <WeaponEffect_Num:[StateArg2]%.> La première fois que le porteur déclenche « Résonance » chaque tour, les autres Éveilleurs gagnent <WeaponEffect_Num:[StateArg3]> Aliemus."
  },
  State_126010_WeaponDesc = {
    Text = "Le porteur augmente le poison fixe et déclenche l'effet de poison de <WeaponEffect_Num:[StateArg1]%>, la récupération automatique de <EmbryoFusionIconKeywords:Fusion d'embryon> dans le royaume de Chair augmente de <WeaponEffect_Num:[StateArg2]%>. Lors de la première activation de « Résonance » chaque tour, les autres éveillés obtiennent <WeaponEffect_Num:[StateArg3]> points de fureur."
  },
  State_126463_Name = {
    Text = "État@Monstre Liz Écouteur de dégâts de feu de piégeage de papillon"
  },
  State_126464_Desc = {
    Text = "Maximum de 10 couches, chaque couche augmente les dégâts infligés par Liz de [DescArg1] points."
  },
  State_126464_Name = {
    Text = "<GreenWord:Étincelle Verdoyante>"
  },
  State_126465_Name = {
    Text = "Surveillance de l'intention du monstre Liz"
  },
  State_126466_Desc = {
    Text = "Votre adversaire ne défaussera pas de cartes à la fin de son tour. Lors du passage à l'intention Flammes Vertes, si vous avez au moins 6 couches de <MonsterLizVerdantSpark:Braise Émeraude>, consommez 6 couches pour améliorer l'intention en « Flammes Mortelles » infligeant <Damage:[Damage:DescArg1]> dégâts [AttackTimes:DescArg2] fois ; si vous avez au moins 3 couches, consommez 3 couches pour améliorer l'intention en « Flammes Corrompues » infligeant <Damage:[Damage:DescArg3]> dégâts [AttackTimes:DescArg4] fois."
  },
  State_126466_Name = {
    Text = "Flamme verte immortelle"
  },
  State_126467_Desc = {
    Text = "Cet Éveilleur n'est toujours pas Réveillé... Il se Réveillera lorsqu'il sera sur le point d'être vaincu, restaurera des PV et se battra avec toute sa puissance, accordant la capacité d'éliminer les états négatifs pour « Danse vers la Destruction »"
  },
  State_126467_Name = {
    Text = "Non Réveillé"
  },
  State_126468_Name = {
    Text = "État@Monstre Liz Reflet Émeraude Gestion"
  },
  State_126469_Desc = {
    Text = "Pour chaque [DescArg1] PV perdus, gagnez [DescArg2] pile(s) de <MonsterLizVerdantSpark:Éclat d'Émeraude>."
  },
  State_126469_Name = {
    Text = "Image Émeraude"
  },
  State_126470_Name = {
    Text = "État@monstreLizAvertissement compteur"
  },
  State_126479_Desc = {
    Text = "Maximum de 10 charges, augmente les dégâts infligés par Liz."
  },
  State_126479_Name = {
    Text = "<GreenWord:Étincelle Verdoyante>"
  },
  State_126540_Desc = {
    Text = "Lorsque Xu déclenche \"Résonance\" [Layer] fois, l'effet de \"Résonance\" est doublé."
  },
  State_126540_Name = {
    Text = "Vœu de la Brume Liée"
  },
  State_126568_Desc = {
    Text = "Chaque fois qu'un Éveilleur inflige des dégâts actifs, commandez 1 tentacule pour attaquer la cible, infligeant [Layer]% de dégâts de tentacule."
  },
  State_126568_Name = {
    Text = "Vagues enragées"
  },
  State_126569_Desc = {
    Text = "Chaque fois qu'un Éveilleur inflige des Dégâts Directs, il ordonne 1 Attaque de Tentacule contre la cible, infligeant 50％ de Dégâts des tentacules."
  },
  State_126569_Name = {
    Text = "Vagues enragées"
  },
  State_126643_Desc = {
    Text = "Cet état MaxLayer=1. Source Éveilleur : [DescArg1]"
  },
  State_126643_Name = {
    Text = "Limite de niveau 1"
  },
  State_126644_Desc = {
    Text = "Après avoir obtenu, effacez et réajoutez l'état de démonstration des [Layer] couches. \n Le nombre maximal de couches pour l'état de démonstration est de 1 couche."
  },
  State_126644_Name = {
    Text = "Dépasser le nombre maximum de charges"
  },
  State_126645_Desc = {
    Text = "Les dégâts de base de Ramona augmentent de [DescArg1] %"
  },
  State_126645_Name = {
    Text = "Sublimation sublime"
  },
  State_126651_Desc = {
    Text = "L'écoute après la poursuite de lâcher a été satisfaite [Layer] fois."
  },
  State_126651_Name = {Text = "Compteur"},
  State_126652_Desc = {
    Text = "Après avoir obtenu, obligez les ennemis de la première ligne à effectuer une action postérieure, jouant leur intention actuelle."
  },
  State_126652_Name = {
    Text = "Faire poursuivre le monstre"
  },
  State_126653_Desc = {
    Text = "Après avoir obtenu, faites en sorte que l'éveilleur en position 1 ajoute une action supplémentaire et joue sa carte d'attaque."
  },
  State_126653_Name = {
    Text = "Poursuite de l'éveilleur"
  },
  State_126654_Desc = {
    Text = "Lorsque l'écouteur de nomination est déclenché, imprimez le compteur une fois."
  },
  State_126654_Name = {
    Text = "Écouteur nommé"
  },
  State_126655_Desc = {
    Text = "Après avoir obtenu, demandez au Gardien d'ajouter une action postérieure, jouez la compétence @compétence du protagoniste@Voix dans l'esprit."
  },
  State_126655_Name = {
    Text = "Donner l'ordre au Gardien de poursuivre"
  },
  State_126677_Desc = {
    Text = "Ce tour, le prochain [Layer] « Lame de défi » a un effet de 2 fois."
  },
  State_126677_Name = {
    Text = "Léviathan primitif"
  },
  State_126678_WeaponDesc = {
    Text = "Tous les dégâts du saut de baleine +1"
  },
  State_126714_Desc = {
    Text = "La prochaine [Layer] « Défense » d'Aigis prend effet 3 fois."
  },
  State_126714_Name = {
    Text = "Larme cristallisée"
  },
  State_126714_WeaponDesc = {
    Text = "Tous les dégâts du saut de baleine +1"
  },
  State_126715_WeaponDesc = {
    Text = "Tous les dégâts du saut de baleine +1"
  },
  State_126776_Desc = {
    Text = "Pour chaque couche, le poison fixe subi augmente de 5 %, les dégâts infligés diminuent de [DescArg1] %, jusqu'à [DescArg2] couches."
  },
  State_126776_Name = {
    Text = "<WitherKeywords:Envoûté>"
  },
  State_126783_Name = {
    Text = "Temporairement abandonné"
  },
  State_126784_Desc = {
    Text = "Augmente le poison fixe reçu de [DescArg1] %, réduit les dégâts infligés de [DescArg2] %, jusqu'à [DescArg3] couches."
  },
  State_126784_Name = {Text = "Spellbound"},
  State_126785_Desc = {
    Text = "Si d'autres éveilleurs ont accumulé X cartes de commandement jouées, déclenchez les effets suivants après avoir joué. Réinitialisez votre compte de résonance après avoir joué vos propres cartes de commandement ou à la fin de votre tour."
  },
  State_126785_Name = {
    Text = "<ResonanceKeywords:Résonance X>"
  },
  State_126789_Desc = {
    Text = "Inflige 2 couches de <WitherKeywords:Envoûtement> à tous les ennemis."
  },
  State_126789_Name = {
    Text = "<WitherKeywords1:Fiancer>"
  },
  State_126790_Desc = {
    Text = "Retirez tous les <WitherKeywords:Ivresse> de l'ennemi, chaque couche retirée inflige [DescArg1] % des PV Max de la cible en Dégâts Fixes et déclenche un Poison de 40 %."
  },
  State_126790_Name = {
    Text = "<WitherKeywords2:Envoûter>"
  },
  State_126803_Desc = {
    Text = "Les prochaines cartes de commandement [DescArg1] jouées seront envoyées 3 tours dans le futur."
  },
  State_126803_Name = {
    Text = "Roue du destin"
  },
  State_126893_Name = {
    Text = "État@DestinUltraIdentifiantPur"
  },
  State_126895_Desc = {
    Text = "Les Dégâts Finaux, le gain fixe de <PowerIconKeywords:Force> & <TentacleInjurieIconKeywords:Dégâts des tentacules>, le <IntoxicationIconKeywords:Poison> & la <RetaliateIconKeywords:Contre-attaque> fixes de cette carte +[DescArg1]% chacun ; le Bouclier Fixe Final, la Régénération de PV Fixe et la <ExhaustionIconKeywords:Force réduite> de cette carte +[DescArg2]% chacun. Les cartes avec «phare de singularité» ne peuvent pas déclencher la «Navette dimensionnelle»."
  },
  State_126895_Name = {
    Text = "<SingularityKeywords:phare de singularité [DescArg2]>"
  },
  State_126896_Name = {
    Text = "État@Lumière de Transcendance Carte réduit les charges d'Harmonie d'Arithmetica"
  },
  State_126900_Name = {
    Text = "État@DestinInitialisation de la classe ultra 2"
  },
  State_126901_Name = {
    Text = "État@DestinUltraClasseInitialisation1"
  },
  State_126903_Name = {
    Text = "État@Espace Hyperspatial Quasar Marque"
  },
  State_126927_Desc = {
    Text = "Équipe unique : Les effets de poison fixe et de poison du porteur sont augmentés de <WeaponEffect_Num:[StateArg1]%.> Le porteur gagne <WeaponEffect_Num:[StateArg2]> d'Aliemus la première fois qu'il déclenche \"Résonance\" chaque tour."
  },
  State_126927_WeaponDesc = {
    Text = "Les déclencheurs de poison fixe et d'effet de poison du porteur augmentent de <WeaponEffect_Num:[StateArg1]%.> Le porteur gagne <WeaponEffect_Num:[StateArg2]> Aliemus la première fois qu'il déclenche \"Résonance\" à chaque tour."
  },
  State_126990_Name = {
    Text = "<IntoxicationColour:Empoisonnement>"
  },
  State_127108_Desc = {
    Text = "Inflige 5 couches de <WitherKeywords:Envoûté> à tous les ennemis."
  },
  State_127108_Name = {
    Text = "<WitherKeywords3:Fiancer>"
  },
  State_127109_Desc = {
    Text = "Retirez tous les <WitherKeywords:Ivresse> des ennemis, chaque retrait d'une couche accumule 20 % de la Constitution de la Forge Écarlate, inflige [DescArg1] % des PV Max de la cible en Dégâts Fixes et déclenche un Poison de 40 %."
  },
  State_127109_Name = {
    Text = "<WitherKeywords4:Envoûter>"
  },
  State_127176_Desc = {
    Text = "Pour chaque couche, le poison fixe subi augmente de 5 %, les dégâts infligés diminuent de [DescArg1] %, jusqu'à [DescArg2] couches."
  },
  State_127176_Name = {
    Text = "<WitherKeywords0:Envoûté>"
  },
  State_127264_Desc = {
    Text = "Lors de la jouabilité de cette carte, le « Percepteur » gagne 1 pile de <MonsterTimeBeacon:Boucle>. Si cette carte est défaussée, le « Percepteur » perd 1 pile de <MonsterTimeBeacon:Boucle>."
  },
  State_127264_Name = {
    Text = "<MonsterSightUnbound:Vision Délivrée>"
  },
  State_127266_Desc = {
    Text = "Cet éveilleur n'est pas encore éveillé... Il s'éveillera lorsqu'il sera sur le point d'être abattu, restaurera sa vie et commencera à se battre sous sa véritable forme"
  },
  State_127266_Name = {
    Text = "Non Réveillé"
  },
  State_127267_Desc = {
    Text = "À la fin du tour, gagnez 1 pile de <MonsterTimeBeacon:Boucle>."
  },
  State_127267_Name = {
    Text = "Inversion de l'entropie"
  },
  State_127271_Desc = {
    Text = "Après avoir libéré Posse, gagnez 1 couche de <MonsterTimeBeacon:Loop>."
  },
  State_127271_Name = {
    Text = "Prisonnier de Mobiüs"
  },
  State_127272_Desc = {
    Text = "Maximum de 3 couches. Lorsque le « Percepteur » libère une Intention avec 3 couches de <MonsterTimeBeacon:Loop>, déclenchez l'effet <MonsterTimeBeacon:Loop>, effacez le <MonsterTimeBeacon:Loop> et retirez les états négatifs."
  },
  State_127272_Name = {
    Text = "<WhiteWord:Boucle>"
  },
  State_127275_Desc = {
    Text = "Pour chaque couche, le poison fixe subi augmente de 5 %, les dégâts infligés diminuent de [DescArg1] %, jusqu'à [DescArg2] couches."
  },
  State_127275_Name = {
    Text = "<WitherKeywords:Envoûté>"
  },
  State_127276_Desc = {
    Text = "Lors de la jouabilité de cette carte, le « Percepteur » gagne 1 pile de <MonsterTimeBeacon:Boucle>. Si cette carte est défaussée, le « Percepteur » perd 1 pile de <MonsterTimeBeacon:Boucle>."
  },
  State_127276_Name = {
    Text = "<MonsterSightUnbound:Vision Délivrée>"
  },
  State_127312_Desc = {
    Text = "Lorsque la montée psychique de l'éveillé atteint +12, l'« Axiome Absolu » est activé, conférant des effets uniques."
  },
  State_127312_Name = {
    Text = "<UltraPotencyKeywords:Règle finale>"
  },
  State_127705_Desc = {
    Text = "La carte a été falsifiée ! Subissez [Layer] dégâts lorsqu'elle est jouée. Réduit les charges de <CardKeyWord:Sabotage> de moitié."
  },
  State_127705_Name = {
    Text = "<CardKeyWord:Sabotage>"
  },
  State_127705_WeaponDesc = {
    Text = "Après avoir joué la carte, subissez [StateArg1] points de dégâts"
  },
  State_127708_Desc = {
    Text = "Après que l'ennemi joue une carte non-Carte d'instruction, tous les alliés gagnent [DescArg1] <plural value=\"[DescArg1]\" singular=\"charge\" plural=\"charges\"> de <PowerIconKeywords:Force>. Devient inactif après que les Cendres anciennes sont brisées."
  },
  State_127708_Name = {
    Text = "Fils du Chaos"
  },
  State_127709_Name = {
    Text = "État du joueur de Fil Noir"
  },
  State_127710_Name = {
    Text = "Déclencheur de Fil Noir"
  },
  State_128026_Name = {
    Text = "État du joueur de Fil Blanc"
  },
  State_128027_Desc = {
    Text = "Après que l'ennemi joue une carte d'instruction, tous les alliés obtiennent [DescArg1] couches de <ReinforcePVEKeywords:Forteresse> temporaire. Les Cendres anciennes deviennent inefficaces après avoir été brisées."
  },
  State_128027_Name = {
    Text = "Fils de la Loi"
  },
  State_128028_Desc = {
    Text = "La carte a été altérée ! Une fois jouée, subit des <FixedDamage:DGT Purs> puis réduit les charges de <BrokenCard:Sabotage> de moitié."
  },
  State_128028_Name = {
    Text = "<CardKeyWord:Destruction secrète>"
  },
  State_128028_WeaponDesc = {
    Text = "Après avoir joué la carte, subissez [StateArg1] points de dégâts"
  },
  State_128029_Name = {
    Text = "Déclencheur de Fil Blanc"
  },
  State_128067_Name = {
    Text = "État@Femme de ménage araignée froide Cendre Écouteur"
  },
  State_128069_Name = {
    Text = "État@Détection de coup de servante de l'araignée froide entrelacée"
  },
  State_128071_Name = {
    Text = "État@Femme de chambre araignée froide Position avant nécessite une marque d'invocation"
  },
  State_128073_Desc = {
    Text = "Après chaque action, obtenez [DescArg1] couches de <ParcloseIconKeywords:barrière> et [DescArg2] couches de <Chapter5_Monster_Fervor1:Ferveur>."
  },
  State_128073_Name = {
    Text = "Berceau de la Mère tisseuse"
  },
  State_128082_Desc = {
    Text = "Après avoir joué, Hameln gagne 3 points de aliemus"
  },
  State_128082_Name = {
    Text = "<XushiBKeywords:Musique accumulée>"
  },
  State_128086_Desc = {
    Text = "Après que l'ennemi joue une Carte d'instruction, gagnez [DescArg1] <plural value=\"[DescArg1]\" singular=\"charge\" plural=\"charges\"> de <Chapter5_Monster_Fervor1:Ferveur>, et échangez de place avec l'allié de la rangée arrière après que «Cendres anciennes» est épuisé."
  },
  State_128086_Name = {
    Text = "Roue du Destin"
  },
  State_128087_Name = {
    Text = "État@Femme de chambre araignée froide Marque de déclenchement de la roue blanche"
  },
  State_128089_Name = {
    Text = "Déclencheur du Cycle Blanc"
  },
  State_128216_Name = {
    Text = "État du joueur du Cycle Blanc"
  },
  State_128245_Desc = {
    Text = "Effacez au début du tour. Après avoir atteint 10 charges, agissez immédiatement la prochaine fois qu'une carte est jouée, en retirant la <Chapter5_Monster_Fervor2:Ferveur> et en changeant l'intention pour infliger <FragileIconKeywords:Fragile> et attacher aléatoirement un <BrokenCard:Sabotage> «Fil de l'Effondrement»."
  },
  State_128245_Name = {Text = "Ferveur"},
  State_128246_Name = {
    Text = "État du joueur du Cycle Noir"
  },
  State_128247_Desc = {
    Text = "Résurrection après la mort avec Immunité aux dégâts et 100% de PV. Changez l'intention en «Ferveur du Destin» : après chaque action, gagnez [DescArg1] <PowerIconKeywords:Force> et [DescArg2] <Chapter5_Monster_Fervor2:Ferveur>."
  },
  State_128247_Name = {Text = "Émergence"},
  State_128248_Desc = {
    Text = "Efface au début du tour. Après avoir atteint 10 charges, agissez immédiatement la prochaine fois qu'une carte est jouée, en retirant la <Chapter5_Monster_Fervor1:Ferveur> et en changeant l'intention en « Filet de Contrainte », qui inflige <WeaknessIconKeywords:Affaiblir> et scelle aléatoirement des Cartes d'instruction."
  },
  State_128248_Name = {Text = "Ferveur"},
  State_128250_Name = {
    Text = "Déclenchement du Cycle Noir"
  },
  State_128251_Desc = {
    Text = "Après que l'ennemi joue une carte non-Carte d'instruction, gagnez [DescArg1] <plural value=\"[DescArg1]\" singular=\"charge\" plural=\"charges\"> de <Chapter5_Monster_Fervor1:Ferveur>, et échangez de place avec l'allié de la rangée arrière après épuisement des «Cendres anciennes»."
  },
  State_128251_Name = {
    Text = "Roue de l'Abîme"
  },
  State_128253_Desc = {
    Text = "À la mort, ressuscitez avec immunité aux Dommages et 100 % de PV. Changez d'intention en « Ferveur du Destin » : après chaque action, gagnez [DescArg1] <plural value=\"[DescArg1]\" singular=\"charge\" plural=\"charges\"> de <ParcloseIconKeywords:Barrière> et [DescArg2] <plural value=\"[DescArg2]\" singular=\"charge\" plural=\"charges\"> de <Chapter5_Monster_Fervor1:Ferveur>."
  },
  State_128253_Name = {Text = "Émergence"},
  State_128257_Desc = {
    Text = "Après chaque action, gagnez [DescArg1] points de <PowerIconKeywords:force> et [DescArg2] couches de <Chapter5_Monster_Fervor2:Ferveur>."
  },
  State_128257_Name = {
    Text = "Murmure de la Mère tisseuse"
  },
  State_128643_Name = {
    Text = "État@Joueur Ce tour Nombre de symptômes joués"
  },
  State_128644_Desc = {
    Text = "Effacez au début du tour. Après avoir atteint 10 couches, agissez immédiatement après avoir joué la prochaine carte, en retirant <Chapter5_Monster_Fervor3:Ferveur> et en changeant aléatoirement l'intention."
  },
  State_128644_Name = {Text = "Ferveur"},
  State_128645_Desc = {
    Text = "L'intention sera choisie au hasard parmi quatre types, mais ne se répétera pas. Changez d'intention immédiatement après avoir libéré l'exaltation. Gagnez 1 couche de <Chapter5_Monster_Fervor3:Ferveur> après avoir joué une carte d'instruction."
  },
  State_128645_Name = {
    Text = "Harmonisation des mille visages"
  },
  State_128646_Name = {
    Text = "État@Destin erroné désqualification Attaque lourde détection de carte jouée"
  },
  State_128648_Desc = {
    Text = "Jusqu'au début du tour suivant, chaque fois que vous jouez une carte d'instruction, obtenez [DescArg1] points temporaires de <PowerIconKeywords:force>."
  },
  State_128648_Name = {
    Text = "Cocon de Rage"
  },
  State_128692_Desc = {
    Text = "Après avoir subi des Dégâts Directs ou des Dégâts des tentacules, retirez une quantité équivalente de «Cendres anciennes» et perdez 300 % de la quantité retirée en PV ; retirez la moitié lors de la réception d'autres dommages. Le nombre de charges de «Cendres anciennes» se réinitialise à chaque tour."
  },
  State_128692_Name = {
    Text = "<AshesPastKeyWord:Cendres anciennes>"
  },
  State_128695_Name = {
    Text = "État@Marque d'intention du destin dérangé"
  },
  State_129297_Desc = {
    Text = "Au début des [Layer] prochains combats, réglez la vie de tous les ennemis à 1."
  },
  State_129297_Name = {
    Text = "Assistance de petit « N »"
  },
  State_129569_Name = {
    Text = "État@Marque de déclenchement du théâtre de plaisir du destin dérangé"
  },
  State_129570_Name = {
    Text = "État@Murmure du destin dérangé"
  },
  State_129571_Name = {
    Text = "État@Destin dérangé Nullité Éternelle Marqueur de Déclenchement"
  },
  State_129612_Desc = {
    Text = "L'intention sera choisie au hasard parmi quatre intentions, mais ne se répétera pas. Changez immédiatement d'intention après avoir libéré l'Exaltation. Obtenez 1 couche de <Chapter5_Monster_Fervor3:Ferveur> après avoir joué une Carte d'instruction."
  },
  State_129612_Name = {
    Text = "Synchronisation des mille visages"
  },
  State_129625_Desc = {
    Text = "L'intention sera choisie au hasard parmi quatre types, mais ne se répétera pas. Changez immédiatement d'intention après avoir libéré un Exalt. Gagnez 1 pile de <Chapter5_Monster_Fervor3:Fervor> après avoir joué une carte de commandement. Gagnez 1 pile de \"Fusion de distorsion\" chaque fois que l'intention est changée."
  },
  State_129625_Name = {
    Text = "Harmonisation des mille visages"
  },
  State_129643_Desc = {
    Text = "Gagnez 1 charge chaque fois que l'intention est changée. Lorsque vous avez 10 charges de «Destin effiloché», l'intention devient l'immuable «Émergence frénétique», qui inflige des Dommages massifs et applique des affaiblissements."
  },
  State_129643_Name = {
    Text = "Destin tordu"
  },
  State_129644_Name = {
    Text = "Intentions de verrouillage fusion distordue"
  },
  State_129650_Desc = {
    Text = "Équipe Unique : Si le Porteur est l'Éveilleur «Ramona : Vétuste», le Taux de synchronisation gagné par les autres Éveilleurs à la fin du niveau +<WeaponEffect_Num:[StateArg1]%>, mais le Porteur ne gagne aucun Taux de synchronisation."
  },
  State_129650_WeaponDesc = {
    Text = "Si le Porteur est le Corps éveillé «Ramona : Vétuste», lorsqu'un niveau est terminé, les autres Corps éveillés gagnent +<WeaponEffect_Num:[StateArg1]%> de Taux de synchronisation, mais le Porteur ne gagne aucun Taux de synchronisation."
  },
  State_129761_Desc = {
    Text = "Modifier la valeur de retour de l'interface de croissance des joueurs en jeu, chaque couche augmente de 1 %."
  },
  State_129761_Name = {
    Text = "Correction de l'intensité de croissance en jeu"
  },
  State_129845_Desc = {
    Text = "Cet éveilleur n'est pas encore éveillé... Il s'éveillera lorsqu'il sera sur le point d'être abattu, restaurera sa vie et commencera à se battre sous sa véritable forme"
  },
  State_129845_Name = {
    Text = "Non Réveillé"
  },
  State_129846_Name = {
    Text = "Compteur d›oscillation spatiale"
  },
  State_129848_Desc = {
    Text = "Chaque fois que [DescArg1] cartes quittent la Fissure dimensionnelle, leur conférer [DescArg2] couches <BrokenCard:sabotage>."
  },
  State_129848_Name = {
    Text = "Théâtre de Marionnettes"
  },
  State_129849_Desc = {
    Text = "Générez une copie de la première carte d'instruction jouée par l'ennemi chaque tour et placez-la dans la fissure dimensionnelle. Lorsque la carte entre dans la fissure dimensionnelle, accordez-lui <DepleteIconKeywords:Consommation>. La première fois que le décret clé est libéré chaque tour, retirez la carte la plus à gauche et placez-la en haut de la pioche."
  },
  State_129849_Name = {
    Text = "Tissage du Destin"
  },
  State_129850_Desc = {
    Text = "Dans chaque Fissure dimensionnelle avec une Carte d'instruction, la Limite Max de la Main du joueur est réduite de 1. Si celle-ci est déjà pleine, lors de la prochaine action de jouer une Carte, la « Tela Perpetua » agit immédiatement, et après l'action, elle vide la Fissure dimensionnelle, ajustant l'intention à « Élégie Transcendant le Destin »."
  },
  State_129850_Name = {
    Text = "oscillation spatiale"
  },
  State_129854_Desc = {
    Text = "Pour chaque carte d'instruction dans la fissure dimensionnelle, la limite max de la main du joueur est réduite de 1. Si elle est déjà pleine, lors de la prochaine action de jouer une carte, la « Tela Perpetua » agit immédiatement, puis vide la fissure dimensionnelle et ajuste l'intention à « Moïra, telle que je la décrète »."
  },
  State_129854_Name = {
    Text = "oscillation spatiale"
  },
  State_129864_Desc = {
    Text = "Chaque fois qu'une carte est jouée, retirez 1 couche de « somnolence ». Au début du tour, restaurez 12 couches de « somnolence »."
  },
  State_129864_Name = {Text = "Fureur"},
  State_129865_Desc = {
    Text = "Cet éveilleur n'est pas encore éveillé... Il s'éveillera lorsqu'il sera sur le point d'être abattu, restaurera sa vie et commencera à se battre sous sa véritable forme"
  },
  State_129865_Name = {
    Text = "Non Réveillé"
  },
  State_129872_Desc = {
    Text = "Variable temporaire."
  },
  State_129872_Name = {Text = "Compteur1"},
  State_129873_Desc = {
    Text = "Obtenez l'état du compteur de couches [Layer] _Compteur1_."
  },
  State_129873_Name = {
    Text = "Test de encapsulation 1"
  },
  State_129874_Desc = {
    Text = "Variable temporaire."
  },
  State_129874_Name = {
    Text = "Amplificateur 1"
  },
  State_130358_Desc = {
    Text = "La prochaine carte de commandement jouée prendra effet 2 fois supplémentaires."
  },
  State_130358_Name = {
    Text = "Marionnette à fils"
  },
  State_130387_Desc = {
    Text = "Après que « Marionnette » ait été jouée, la première carte d'instruction jouée chaque tour a un effet supplémentaire de 2 fois. En cas de Combat de Chef, tous les Éveilleurs obtiennent 50 points de Fureur et 1000 points de Fragment de clé."
  },
  State_130387_Name = {
    Text = "Les funérailles du destin"
  },
  State_130388_Name = {
    Text = "<RetainIconKeywords:Garder> : Gagnez [DescArg1] points de s-énergie"
  },
  State_130389_Desc = {
    Text = "Après avoir joué, conférez à tous les éveillés [DescArg1] points de fureur"
  },
  State_130389_Name = {
    Text = "Après avoir joué, conférez à tous les éveillés [DescArg1] points de fureur"
  },
  State_130390_Desc = {
    Text = "Limite d’Arithmetica et Limite Max de la Main augmentées de 1."
  },
  State_130390_Name = {
    Text = "Profil redondant"
  },
  State_130391_Desc = {
    Text = "Chaque fois qu'une carte de « symptômes » est jouée, le coût d'Arithmetica de « Marionnette » est réduit de 1."
  },
  State_130391_Name = {
    Text = "Écho impure"
  },
  State_130490_Desc = {
    Text = "Cette carte augmente les dégâts, boucliers, soins, force, drainer, dégâts des tentacules, poison fixe et contre-attaque fixe, multipliés indépendamment par 1+[Layer] %."
  },
  State_130490_Name = {
    Text = "phare de singularité α"
  },
  State_130498_Desc = {
    Text = "La prochaine carte de commandement jouée prendra effet 2 fois supplémentaires."
  },
  State_130498_Name = {
    Text = "Les funérailles du destin"
  },
  State_130500_Desc = {
    Text = "Dans le combat de chef, la résistance à la mort augmente de 100 %. Après avoir déclenché la « résistance à la mort », au tour suivant, « Marionnette » ne forcera plus à jouer une carte d'instruction, mais permettra de choisir une carte d'instruction dans votre main."
  },
  State_130500_Name = {
    Text = "Regard du martyr"
  },
  State_130501_Desc = {
    Text = "La consommation d'arithmetica de la prochaine carte d'instruction est réduite à 0."
  },
  State_130501_WeaponDesc = {
    Text = "Changez le coût en arithmetica de la carte avant de la jouer"
  },
  State_130512_Desc = {
    Text = "La prochaine carte de commandement jouée sera effective 2 fois et le coût d'arithmetica sera réduit de 2 points."
  },
  State_130512_Name = {
    Text = "Marionnette à fils"
  },
  State_130517_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Lors de l'équipement et au début du tour, déclenche aléatoirement l'un des Effets suivants : obtient <Energy:[Energy:StateArg1]> Aliemus et s'applique <PVPSlowKeywords:Stagnation> ; obtient <Energy:[Energy:StateArg3]> Aliemus ; obtient <Energy:[Energy:StateArg4]> et [StateArg5] Carte(s) <PVPDerivativeCardKeywords_17:«Perspicacité»>."
  },
  State_130517_Name = {
    Text = "Sagesse du pari risqué"
  },
  State_131046_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : «Exaltation» vous donne <Block:[Block:StateArg1]> bouclier et <DelayKeywords:Latence> : <Energy:[Energy:StateArg2]> de Fureur."
  },
  State_131046_Name = {
    Text = "Jardin d'Éden lointain"
  },
  State_131047_Desc = {
    Text = "Ce tour, les prochaines [Layer] utilisations de Posse auront un effet double."
  },
  State_131047_Name = {
    Text = "Double Clé"
  },
  State_131048_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : La première fois qu'une « Compétence » est jouée par tour, inflige <Damage:[Damage:StateArg1]> dégâts à l'ennemi avec <HPAndShieldMin:la vie et le bouclier les plus faibles>."
  },
  State_131048_Name = {
    Text = "Fou emprisonné"
  },
  State_131055_Desc = {
    Text = "Piochez -1 carte chaque tour. La régénération de bouclier et de santé de tous les éveilleurs est augmentée de 20 %."
  },
  State_131055_Name = {
    Text = "Coiffer les cheveux"
  },
  State_131056_Desc = {
    Text = "Après avoir perdu des PV, convertissez une quantité équivalente de Fureur de latence en Bouclier."
  },
  State_131056_Name = {
    Text = "Bouclier de vortex"
  },
  State_131058_Desc = {
    Text = "Tous les éveilleurs obtiennent une augmentation de 10 points de fureur de base. Après avoir libéré une exaltation, vous obtenez 1 arithmetica, chaque éveilleur ne peut être déclenché qu'une fois par tour."
  },
  State_131058_Name = {
    Text = "Frotter la joue"
  },
  State_131059_Name = {
    Text = "Marque de mise à niveau de la compétence ultime de Mosk"
  },
  State_131061_Desc = {
    Text = "Limite d'énergie de clé en argent et consommation de jeton de clé Énergie en clé en argent +350. Le premier jeton de clé prend effet 2 fois à chaque tour."
  },
  State_131061_Name = {
    Text = "Donner des friandises"
  },
  State_131064_Desc = {
    Text = "Gagnez 1 pouvoir après avoir libéré l'exaltation, et chaque éveillé peut seulement le déclencher une fois par tour."
  },
  State_131064_Name = {
    Text = "Frotter la joue"
  },
  State_131069_Desc = {
    Text = "Génération de bouclier et régénération de PV de tous les Éveilleurs +20 %."
  },
  State_131069_Name = {
    Text = "Coiffer les cheveux"
  },
  State_131073_Desc = {
    Text = "Équipe Unique : Au début du combat, gagne une quantité de fureur équivalente à <WeaponEffect_Num:[StateArg1]%> de fureur de base. Les dégâts finaux de l'exaltation du porteur sont augmentés de <WeaponEffect_Num:[StateArg2]%> de la fureur de base. En passant à la posture « Vagues Déchaînées », obtient une maîtrise temporaire du domaine équivalente à <WeaponEffect_Num:[StateArg3]%> de la maîtrise de royaume actuelle, avec un temps de recharge de 3 tours."
  },
  State_131073_WeaponDesc = {
    Text = "Au début du combat, gagnez [DescArg1] points de fureur. Les dégâts finaux de l'exaltation du porteur augmentent de [DescArg2] %. En passant à la posture « Vagues Déchaînées », gagnez [DescArg3] points de maîtrise temporaire du domaine, avec un temps de recharge de 3 tours (temps restant actuel [DescArg4] tours)."
  },
  State_131078_Desc = {
    Text = "La première activation de Posse chaque tour a un effet de 2 fois."
  },
  State_131078_Name = {
    Text = "Donner des friandises"
  },
  State_131118_Desc = {
    Text = "Chaque fois que vous subissez des Dommages ou perdez des PV, le montant ne peut pas dépasser 5% des PV Max."
  },
  State_131118_Name = {
    Text = "Cocon du destin"
  },
  State_131123_Desc = {
    Text = "Effacez au début du tour. Après avoir atteint 10 couches, agissez immédiatement après avoir joué la prochaine carte et changez vers l'intention suivante, en retirant <Chapter5_Monster_Fervor4:Ferveur>."
  },
  State_131123_Name = {Text = "Ferveur"},
  State_131127_Desc = {
    Text = "Une posture liée au Destin. Pour chaque Carte d'instruction jouée par l'ennemi, l'Obscure Arachne gagne 1 niveau de « Ferveur »."
  },
  State_131127_Name = {
    Text = "Serment du liant du destin"
  },
  State_131134_Desc = {
    Text = "Après la mort, Nefraea gagne [DescArg1] <plural value=\"[DescArg1]\" singular=\"charge\" plural=\"charges\"> de Ferveur Temporaire, mais perd 3% de ses PV Max."
  },
  State_131134_Name = {Text = "Agitation"},
  State_131186_Desc = {
    Text = "Prend effet 1 fois supplémentaire après avoir été jouée, mais subit [DescArg1] Dommages."
  },
  State_131186_Name = {
    Text = "<ExclamationPointColour:Destin brisé>"
  },
  State_131188_Desc = {
    Text = "La « Compétence » jouée entre dans la « Fissure dimensionnelle » et attache « Fragment de Destin » à toutes les Compétences du même nom, effacé en quittant la Fissure dimensionnelle. Lorsque la Fissure dimensionnelle est pleine, « Toile de Trahison » Nefraea la vide après son action et transforme la prochaine intention en une puissante Exaltation."
  },
  State_131188_Name = {
    Text = "Fissure dimensionnelle"
  },
  State_131191_Name = {
    Text = "Trouble cognitif"
  },
  State_131242_Desc = {
    Text = "Cette carte augmente les dégâts, boucliers, soins, force, drainer, dégâts des tentacules, poison fixe et contre-attaque fixe, multipliés indépendamment par 1+[Layer] %."
  },
  State_131242_Name = {
    Text = "phare de singularité β"
  },
  State_131258_Desc = {
    Text = "Tournez les fils du rouet, perturbez le destin erroné. Après avoir libéré un Décret Clé ou joué une carte « Fragment de rétroaction du destin », retirez 1 couche. Une fois toutes les couches retirées, Arachne déclenche une attaque de poursuite « Fils en place », infligeant des dégâts élevés. Après 3 libérations, le « Cocon de Liaison de Destin » ennemi sera entièrement brisé !"
  },
  State_131258_Name = {
    Text = "Perturbation du destin"
  },
  State_131261_Name = {
    Text = "Théâtre d›Arachne"
  },
  State_131351_Desc = {
    Text = "Les autres éveillés consomment 1 niveau après avoir libéré l'exaltation, Mosk libère « vortex ! tir ! » pour effectuer une poursuite."
  },
  State_131351_Name = {
    Text = "Chargement de vortex"
  },
  State_131439_Desc = {
    Text = "La prochaine carte d'instruction jouée sera effective 2 fois de plus et son coût d'arithmetica sera réduit à 0."
  },
  State_131439_Name = {
    Text = "Marionnette à fils"
  },
  State_131637_Desc = {
    Text = "À la mort, invoque un «Groupe d'Araignées abyssales» ou un «Groupe d'Araignées froides» aléatoire, réduisant son «Effet de groupe» de 1 stack."
  },
  State_131637_Name = {
    Text = "Effet de groupe"
  },
  State_131638_Desc = {
    Text = "À la mort, invoque une « Matriarche fracturée » ou une « Matriarche spectrale » aléatoire, réduisant son « Effet de groupe » de 1 charge."
  },
  State_131638_Name = {
    Text = "Effet de groupe"
  },
  State_131645_Desc = {
    Text = "Équipe Unique : Lorsque vous changez en posture « Vagues Déchaînées », obtenez une Maîtrise temporaire du domaine équivalente à <WeaponEffect_Num:[StateArg1]%> de votre Maîtrise de Royaume, temps de recharge de 3 tours."
  },
  State_131645_WeaponDesc = {
    Text = "En changeant pour la posture « Vagues Déchaînées », obtenez [DescArg2] points de Maîtrise temporaire du domaine, temps de recharge de 3 tours (restant [DescArg1] tours)."
  },
  State_131657_Desc = {
    Text = "Les autres éveillés consomment 1 niveau après avoir libéré l'exaltation, Mosk libère « vortex ! tir ! » pour effectuer une poursuite."
  },
  State_131657_Name = {
    Text = "<WhirlpoolKeywords:vortex Charge>"
  },
  State_131660_Desc = {
    Text = "Chaque couche augmente de 1 la demande de fureur pour libérer l'exaltation."
  },
  State_131660_Name = {
    Text = "Ajustement de la valeur fixe de consommation de Fureur"
  },
  State_131675_Desc = {
    Text = "Cette carte a [StateArg1]% de probabilité de prendre effet 1 fois supplémentaire lors de son prochain jeu."
  },
  State_131675_Name = {
    Text = "<CardKeyWord:Pari risqué>"
  },
  State_131684_Desc = {
    Text = "Les [Layer] prochaines fois que « Vortex ! Flux ! Balle ! » s'active 2 fois."
  },
  State_131684_Name = {
    Text = "Mosk ! Méga Bombe"
  },
  State_131749_Desc = {
    Text = "Équipe Unique : Après le début de l'exploration, mélangez 1 carte « sagesse du pari risqué » dans la pioche. « Sagesse du pari risqué » : Consommez 1 arithmetica. Mélangez aléatoirement toutes les cartes d'instruction dans votre main dans la pioche, les cartes d'instruction mélangées ont <WeaponEffect_Num:[StateArg1]%> de probabilité de prendre effet 1 fois supplémentaire lors de leur prochaine utilisation, et pour chaque carte d'instruction mélangée, tous les éveilleurs gagnent 2 points de fureur. <RetainIconKeywords:Garder>. <DepleteIconKeywords:Consommation>. <GuyouKeywords:Inné>."
  },
  State_131749_WeaponDesc = {
    Text = "Après le début de l'exploration, mélangez 1 carte « sagesse du pari risqué » dans la pioche. « sagesse du pari risqué » : Consommation de 1 arithmetica. Mélangez toutes les cartes d'instruction en votre possession dans la pioche de manière aléatoire. Les cartes d'instruction mélangées ont une probabilité de <WeaponEffect_Num:[StateArg1]%> de prendre effet 1 fois supplémentaire lors de leur prochaine utilisation, et chaque carte d'instruction mélangée permet à tous les éveilleurs d'obtenir 2 points de fureur. <RetainIconKeywords:Garder>. <DepleteIconKeywords:Consommation>. <GuyouKeywords:Inné>."
  },
  State_131769_Name = {
    Text = "État@ReproductionInitialisation de la classe chair 1"
  },
  State_131779_Desc = {
    Text = "Après avoir utilisé [Layer] fois, elle ira dans la pile de défausse et réinitialisera le nombre d'utilisations, mais l'« oraison » ne sera effective qu'à la première utilisation."
  },
  State_131779_Name = {
    Text = "Peut être utilisé [Layer] fois"
  },
  State_131789_Desc = {
    Text = "Moyens alternatifs. Ajoutez une carte avec l'identifiant tid [Layer] à votre main."
  },
  State_131789_Name = {
    Text = "Ajouter une carte spécifiée"
  },
  State_131807_Name = {
    Text = "État@ReproductionChairSangSymbole de Pureté"
  },
  State_131824_Name = {
    Text = "État@Monstre Tawil Intention de changement Écouteur de joueur"
  },
  State_131846_Desc = {
    Text = "À la mort, invoque un «Groupe d'Araignées abyssales» ou un «Groupe d'Araignées froides» aléatoire, réduisant son «Effet de groupe» de 1 stack."
  },
  State_131846_Name = {
    Text = "Effet de groupe"
  },
  State_131908_Desc = {
    Text = "Partage les PV, le Bouclier du personnage et la Fureur de la cible, mais ne génère pas de statistiques de combat."
  },
  State_131908_Name = {
    Text = "Festin pourri de tremplin"
  },
  State_131909_Desc = {
    Text = "Avoir cet état permet d'utiliser l'Exaltation."
  },
  State_131909_Name = {
    Text = "Sceau permanent"
  },
  State_132366_Desc = {
    Text = "Effectue une poursuite après qu'un autre Éveillé utilise une carte de frappe"
  },
  State_132366_Name = {Text = "Poursuite"},
  State_132465_Desc = {
    Text = "Les dégâts, bouclier, soins, force, épuisement, dégâts de tentacule, poison fixe et contre-attaque fixe infligés par cet Éveillé sont augmentés, multiplicateur indépendant de 1+[Layer]%."
  },
  State_132465_Name = {
    Text = "Dévorement renforcé α"
  },
  State_132469_Desc = {
    Text = "Les dégâts, bouclier, soins, force, épuisement, dégâts de tentacule, poison fixe et contre-attaque fixe infligés par cet Éveillé sont augmentés, multiplicateur indépendant de 1+[Layer]%."
  },
  State_132469_Name = {
    Text = "Dévorement renforcé β"
  },
  State_132539_Desc = {
    Text = "Création de test d'ensemble"
  },
  State_132539_Name = {
    Text = "Création de test d'ensemble"
  },
  State_132539_WeaponDesc = {Text = "Test"},
  State_132560_WeaponDesc = {
    Text = "Chaque [Damage:StateArg2] fois que le feu émeraude inflige des dégâts, gagnez une carte consommable [Feu Vert]"
  },
  State_132564_WeaponDesc = {
    Text = "Chaque [Damage:StateArg2] fois que le feu émeraude inflige des dégâts, gagnez une carte consommable [Feu Vert]"
  },
  State_132565_WeaponDesc = {
    Text = "Chaque [Damage:StateArg2] fois que le feu émeraude inflige des dégâts, gagnez une carte consommable [Feu Vert]"
  },
  State_132598_Desc = {
    Text = "Lorsque des Dégâts des tentacules sont infligés ce tour, inflige en plus un Poison égal à [Layer]% des Dommages infligés."
  },
  State_132598_Name = {
    Text = "Obsession étouffée"
  },
  State_132609_Desc = {
    Text = "Le sculpteur augmente les dégâts de tentacule [StateArg1] lorsqu'il applique un bouclier"
  },
  State_132609_Name = {
    Text = "Royaume de l'Oubli"
  },
  State_132609_WeaponDesc = {
    Text = "Le sculpteur augmente les dégâts de tentacule [StateArg1] lorsqu'il applique un bouclier"
  },
  State_132669_Desc = {
    Text = "Les dégâts, bouclier, soins, force, épuisement, dégâts de tentacule, poison fixe et contre-attaque fixe infligés par les cartes de cet Éveillé sont augmentés, multiplicateur indépendant de 1+[Layer]%."
  },
  State_132669_Name = {
    Text = "Hyperdimension fatidique α"
  },
  State_132840_Name = {
    Text = "Le bonus d›effet de personnalité de la Carte d›instruction de «24» est doublé. Après que «24» déclenche une Exaltation, l›effet de personnalité doublé expire ce tour"
  },
  State_132891_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Lors de l'équipement, obtient [StateArg1] <StrongEffectKeywords:Amplification> , après l'Exaltation d'un autre allié, lui confère <PVPOneMeetingKeywords:Ichigo Ichie>."
  },
  State_132891_Name = {
    Text = "Rêveries sous les cerisiers"
  },
  State_132892_Desc = {
    Text = "·À l'obtention, retire l'état «Ichigo Ichie» des autres alliés, et obtient l'effet d'Amplification équivalent au nombre d'alliés équipés de «Mystère sous les cerisiers», jusqu'à 3 couches.\n·Les personnages équipés de «Mystère sous les cerisiers» ne peuvent pas obtenir «Ichigo Ichie»."
  },
  State_132892_Name = {
    Text = "Ichigo Ichie"
  },
  State_133294_Name = {
    Text = "Invitation à la résidence royale"
  },
  State_133353_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Une fois équipé, les descriptions d'« Attaque », « Compétence » et « Exaltation » du Porteur deviennent non identifiables, mais chaque instance de Dommages, Bouclier du personnage et Régénération de PV est aléatoirement augmentée de [StateArg1]%～[StateArg2]%."
  },
  State_133353_Name = {
    Text = "Conte de Fées Terni"
  },
  State_133354_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Se conserve après la mort de cette Roue du Destin. Lorsque le Porteur meurt et à la fin des [Layer] tour(s) suivant(s) en état de mort, les autres alliés obtiennent <Heal:[Heal:StateArg1]> <PVPFeatheredSeedsKeyWords:Gynécée> et des PV."
  },
  State_133354_Name = {
    Text = "Morphogenèse Parfumée"
  },
  State_133369_Desc = {
    Text = "Les [DescArg1] prochaines Cartes d›instruction non–Tawil jouées prennent effet deux fois."
  },
  State_133369_Name = {
    Text = "Traverser la porte de la clé d'argent"
  },
  State_133372_Desc = {
    Text = "Si vous êtes actuellement dans un Tour Ultra, activez l'effet « Téléportation Singulière ». « Annihilation Singulière » garantit également le prochain déclenchement de « Téléportation Singulière » ce tour."
  },
  State_133372_Name = {
    Text = "<SingularityKeywords:Téléportation Singulière>"
  },
  State_133391_Desc = {
    Text = "Si les PV de la cible sont égaux ou inférieurs au nombre de charges, retire tous les Verdict Final et la tue instantanément."
  },
  State_133391_Name = {
    Text = "<CutKeywords:Verdict Final>"
  },
  State_133395_Desc = {
    Text = "Les [Layer] prochaine(s) Carte(s) d'instruction jouée(s) déclencheront « Navette Dimensionnelle »."
  },
  State_133395_Name = {
    Text = "Navette Dimensionnelle"
  },
  State_133717_Desc = {
    Text = "Le propriétaire actuel est [Layer], et toutes ses cartes actuelles et futures gagneront l›attribut correspondant (Actuel : Sceau de carte)."
  },
  State_133717_Name = {
    Text = "Propagation d'attributs de carte"
  },
  State_133774_Desc = {
    Text = "Chaque charge augmente les Dégâts Finaux de cette carte, le gain fixe de <PowerIconKeywords:Force> & <TentacleInjurieIconKeywords:Dégâts des tentacules>, le <IntoxicationIconKeywords:Poison> & la <RetaliateIconKeywords:Contre-attaque> fixes de 2%, ainsi que son Bouclier Fixe Final, la Régénération de PV Fixe et la <ExhaustionIconKeywords:Force réduite> de 1%. Cette carte ne peut pas déclencher la <SingularityKeywords3:Navette dimensionnelle>."
  },
  State_133774_Name = {
    Text = "<SingularityKeywords1:phare de singularité>"
  },
  State_133775_Desc = {
    Text = "Chaque charge augmente les Dégâts Finaux de cette carte, le gain fixe de <PowerIconKeywords:Force> & <TentacleInjurieIconKeywords:Dégâts des tentacules>, le <IntoxicationIconKeywords:Poison> & la <RetaliateIconKeywords:Contre-attaque> fixes de 2%, ainsi que son Bouclier Fixe Final, la Régénération de PV Fixe et la <ExhaustionIconKeywords:Force réduite> de 1%"
  },
  State_133775_Name = {
    Text = "<SingularityKeywords2:Prisme de Singularité>"
  },
  State_133961_Desc = {
    Text = "Équipe Unique : Au début de l'exploration, mélangez 1 «Message printanier» dans le deck : Coût d'Arithmetica 1, gagnez <WeaponEffect_Num:[StateArg1]> Fragment de clé, se transforme définitivement en «Fleurs de Cerisier» après avoir été jouée : Coût d'Arithmetica 1, gagnez <WeaponEffect_Num:[StateArg2]> Fragment de clé, après l'avoir jouée se transforme définitivement en «Hanafubuki» : Coût d'Arithmetica 1, gagnez <WeaponEffect_Num:[StateArg3]> Fragment de clé, se transforme définitivement en «Ichigo Ichie» après avoir été jouée : Coût d'Arithmetica 1, choisissez 1 parmi 3 Décrets Clés déverrouillés aléatoires à déclencher immédiatement 2 fois, se transforme définitivement en «Message printanier» après avoir été jouée. Toutes ces cartes ont «Garder»."
  },
  State_133961_WeaponDesc = {
    Text = "Après le début de l'exploration, mélangez 1 « Message printanier » dans le deck : Coût d'Arithmetica 1, gagnez <WeaponEffect_Num:[StateArg1]> Fragment de clé, se transforme définitivement en « Fleurs de Cerisier » après avoir été joué : Coût d'Arithmetica 1, gagnez <WeaponEffect_Num:[StateArg2]> Fragment de clé, après l'avoir joué se transforme définitivement en « Hanafubuki » : Coût d'Arithmetica 1, gagnez <WeaponEffect_Num:[StateArg3]> Fragment de clé, se transforme définitivement en « Ichigo Ichie » après avoir été joué : Coût d'Arithmetica 1, choisissez 1 parmi 3 Décret Clé déverrouillés aléatoires à déclencher immédiatement 2 fois, se transforme définitivement en « Message printanier » après avoir été joué. Toutes ces Cartes ont « Garder »."
  },
  State_133994_Desc = {
    Text = "Les Dégâts Finaux, le gain fixe de <PowerIconKeywords:Force> & <TentacleInjurieIconKeywords:Dégâts des tentacules>, le <IntoxicationIconKeywords:Poison> & la <RetaliateIconKeywords:Contre-attaque> fixes de tous les Éveilleurs +[DescArg1]% chacun ; le Bouclier Fixe Final, la Régénération de PV Fixe et la <ExhaustionIconKeywords:Force réduite> de cette carte +[DescArg2]% chacun"
  },
  State_133994_Name = {
    Text = "Prisme de Singularité"
  },
  State_133998_Desc = {
    Text = "Les Dommages, Boucliers et changements de Force causés par cette Carte sont augmentés de [DescArg2]%, les effets finaux des Dégâts des tentacules, de la récupération de PV, du Poison fixe et de la Contre-attaque fixe sont augmentés de [DescArg1]%. Retiré à la fin du tour ou après avoir été joué."
  },
  State_133998_Name = {
    Text = "<TempPowerKeywords1:Renforcement Temporaire [DescArg1]>"
  },
  State_133999_Desc = {
    Text = "Chaque charge augmente les Dégâts Finaux de cette carte, le gain fixe de <PowerIconKeywords:Force> & <TentacleInjurieIconKeywords:Dégâts des tentacules>, le <IntoxicationIconKeywords:Poison> & la <RetaliateIconKeywords:Contre-attaque> fixes de 2%, ainsi que son Bouclier Fixe Final, la Régénération de PV Fixe et la <ExhaustionIconKeywords:Force réduite> de 1%. Se dissipe lorsqu'elle est jouée ou en fin de tour."
  },
  State_133999_Name = {
    Text = "<TempPowerKeywords:Renforcement Temporaire>"
  },
  State_134100_Desc = {
    Text = "Lors de ce combat, en cas de dégâts létaux, ressuscite, récupère [Layer] PV et octroie à tous les Éveillés [StateArg1] points de furie et [DescArg1] points de dégâts de tentacule temporaires. Ne peut être dissipé."
  },
  State_134100_Name = {
    Text = "Oiseau du Paradis Immortel"
  },
  State_134191_Desc = {
    Text = "Unique dans l'équipe : Après le début de l'exploration, mélange 1 carte « Pause Déjeuner Privée » dans la pioche. « Pause Déjeuner Privée » : Consomme 1 point de calcul. Dégâts critiques temporaires +<WeaponEffect_Num:[StateArg1]%>. <RetainIconKeywords:Conservation>. <DepleteIconKeywords:Consommation>."
  },
  State_134191_WeaponDesc = {
    Text = "Après le début de l'exploration, mélange 1 carte « Pause Déjeuner Privée » dans la pioche. « Pause Déjeuner Privée » : Consomme 1 point de calcul. Dégâts critiques temporaires +<WeaponEffect_Num:[StateArg1]%>. <RetainIconKeywords:Conservation>. <DepleteIconKeywords:Consommation>."
  },
  State_134195_Desc = {
    Text = "Les couches de poison fixe, contre-attaque fixe et jugement du destin fixe infligées par cette carte sont augmentées, multiplicateur indépendant de 1+[Layer]%."
  },
  State_134195_Name = {
    Text = "Force Triphase α1"
  },
  State_134196_Desc = {
    Text = "Les couches de poison fixe, contre-attaque fixe et jugement du destin fixe infligées par les cartes de commandement de cet Éveillé sont augmentées, multiplicateur indépendant de 1+[StateArg1]%."
  },
  State_134196_Name = {
    Text = "Force Triphase β3"
  },
  State_134197_Desc = {
    Text = "Les couches de poison fixe, contre-attaque fixe et jugement du destin fixe infligées par cette carte sont augmentées, multiplicateur indépendant de 1+[StateArg1]%."
  },
  State_134197_Name = {
    Text = "Force Triphase β1"
  },
  State_134198_Desc = {
    Text = "Les couches de poison fixe, contre-attaque fixe et jugement du destin fixe infligées par les cartes de commandement de cet Éveillé sont augmentées, multiplicateur indépendant de 1+[Layer]%."
  },
  State_134198_Name = {
    Text = "Force Triphase α3"
  },
  State_134199_Desc = {
    Text = "Les couches de poison fixe, contre-attaque fixe et jugement du destin fixe infligées par l'explosion de furie de cet Éveillé sont augmentées, multiplicateur indépendant de 1+[StateArg1]%."
  },
  State_134199_Name = {
    Text = "Force Triphase β2"
  },
  State_134200_Desc = {
    Text = "Les couches de poison fixe, contre-attaque fixe et jugement du destin fixe infligées par l'explosion de furie de cet Éveillé sont augmentées, multiplicateur indépendant de 1+[Layer]%."
  },
  State_134200_Name = {
    Text = "Force Triphase α2"
  },
  State_134227_Desc = {
    Text = "Les fils tissés par la Tisseande de Destin. Maximum [DescArg1] charges, persistent entre les combats, et peuvent être consommés par l'Exaltation pour libérer une Chasse : « Fils Infinis »."
  },
  State_134227_Name = {
    Text = "<SilkKeywords:Tisserande>"
  },
  State_134231_Desc = {
    Text = "Équipe Unique : Bouclier du personnage généré par le Porteur +<WeaponEffect_Num:[StateArg1]%>, et lorsque le Porteur utilise « Chasser », Amplification Temporaire +<WeaponEffect_Num:[StateArg2]%>, jusqu'à 5 fois par tour. Chaque fois que « Navette Dimensionnelle » est déclenchée, le Porteur obtient <WeaponEffect_Num:[StateArg3]> Aliemus."
  },
  State_134231_WeaponDesc = {
    Text = "Bouclier du personnage généré par le Porteur +<WeaponEffect_Num:[StateArg1]%>, et lorsque le Porteur utilise « Chasser », Amplification Temporaire +<WeaponEffect_Num:[StateArg2]%>, jusqu'à 5 fois par tour. Chaque fois que « Navette Dimensionnelle » est déclenchée, le Porteur obtient <WeaponEffect_Num:[StateArg3]> Aliemus."
  },
  State_134237_Desc = {
    Text = "La Tisserande du Destin tire ses Fils. Maximum [DescArg1] charges, persistent entre les combats, et peuvent être consommées par Exaltation pour déclencher la Chasse : «<DerivativeCardKeywords_144:Pelote Éternelle>»."
  },
  State_134237_Name = {Text = "Tisserande"},
  State_134240_Desc = {
    Text = "Les [Layer] prochaines fois que le « Rouet Éternel » génère des « Fils Conducteurs », placez-les dans la Pioche et la Pile de Défausse."
  },
  State_134240_Name = {
    Text = "Destinée Entoilée"
  },
  State_134261_Desc = {
    Text = "Les [Layer] prochaines instances de dégâts infligés sont doublées."
  },
  State_134261_Name = {
    Text = "Pause déjeuner secrète"
  },
  State_134262_Desc = {
    Text = "<PVPWeaponKeywords:Roue du destin> : Après une « Explosion de Folie », les prochains dégâts infligés sont doublés."
  },
  State_134262_Name = {
    Text = "Pause déjeuner secrète"
  },
  State_134285_Desc = {
    Text = "Si les PV de la cible sont égaux ou inférieurs au nombre de charges, retire tous les Verdict Final et la tue instantanément."
  },
  State_134285_Name = {
    Text = "Jugement du Destin"
  },
  State_134313_Desc = {
    Text = "Équipe Unique : Bouclier du personnage généré par le Porteur +<WeaponEffect_Num:[StateArg1]%>, et lorsque le Porteur utilise « Chasser », Amplification Temporaire +<WeaponEffect_Num:[StateArg2]%>, jusqu'à 5 fois par tour."
  },
  State_134313_WeaponDesc = {
    Text = "Bouclier du personnage généré par le Porteur +<WeaponEffect_Num:[StateArg1]%>, et lorsque le Porteur utilise « Chasser », Amplification Temporaire +<WeaponEffect_Num:[StateArg2]%>, jusqu'à 5 fois par tour."
  },
  State_134384_Desc = {
    Text = "Les [Layer] prochaine(s) Carte(s) d'instruction jouée(s) déclencheront « Navette Dimensionnelle »."
  },
  State_134384_Name = {
    Text = "Navette Dimensionnelle"
  },
  State_134389_Desc = {
    Text = "Les Dégâts Finaux, le gain fixe de <PowerIconKeywords:Force> & <TentacleInjurieIconKeywords:Dégâts des tentacules>, le <IntoxicationIconKeywords:Poison> & la <RetaliateIconKeywords:Contre-attaque> fixes de cette carte +[DescArg1]% chacun ; le Bouclier Fixe Final, la Régénération de PV Fixe et la <ExhaustionIconKeywords:Force réduite> de cette carte +[DescArg2]% chacun. Les cartes avec «phare de singularité» ne peuvent pas déclencher la «Navette dimensionnelle»."
  },
  State_134389_Name = {
    Text = "<SingularityKeywords:phare de singularité [DescArg2]>"
  },
  State_134391_Desc = {
    Text = "Chaque tour, après que la première Carte d'instruction est jouée, cet Effet se déclenche : la Copie de Base Temporaire de la Carte d'instruction jouée est placée dans l'Espace Hyperspatial. Cet Effet ne peut pas être déclenché pendant les Tours Ultra."
  },
  State_134391_Name = {
    Text = "<SingularityKeywords3:Navette Dimensionnelle>"
  },
  State_135232_Name = {
    Text = "<SingularityKeywords:Téléportation Singulière> : Pour le reste de ce tour, chaque fois qu'un autre Corps éveillé joue une Carte d'instruction, consomme 1 <SilkKeywords:Tisserande> pour déclencher la Chasse : <DerivativeCardKeywords_137:« Fils Infinis »>"
  },
  State_135233_Name = {
    Text = "<SingularityKeywords:Téléportation Singulière> : Pour le reste de ce tour, chaque fois qu'un autre Corps éveillé joue une Carte d'instruction, consomme 1 <SilkKeywords:Tisserande> pour déclencher la Chasse : <DerivativeCardKeywords_137:« Fils Infinis »>"
  },
  State_135919_Name = {
    Text = "<SingularityKeywords:Téléportation Singulière> : Pour le reste de ce tour, chaque fois qu'un autre Corps éveillé joue une Carte d'instruction, consomme 1 <SilkKeywords:Tisserande> pour déclencher la Chasse : <DerivativeCardKeywords_137:« Fils Infinis »>"
  },
  State_135920_Name = {
    Text = "<SingularityKeywords:Téléportation Singulière> : Pour le reste de ce tour, chaque fois qu'un autre Corps éveillé joue une Carte d'instruction, consomme 1 <SilkKeywords:Tisserande> pour déclencher la Chasse : <DerivativeCardKeywords_137:« Fils Infinis »>"
  },
  State_135921_Desc = {
    Text = "Les dégâts de l'éveil augmentent de 25 %"
  },
  State_135921_Name = {
    Text = "<CardKeyWord:Réprimande, pour venger l'offense>"
  },
  State_138824_Desc = {
    Text = "Une vie radieuse chante la liberté et entonne un chant de victoire, pouvant être consommée par l'Exaltation de Saya pour renforcer son Effet. Cet État peut s'accumuler jusqu'à 4 couches et sera conservé après la fin du combat."
  },
  State_138824_Name = {
    Text = "<KaiHuajishu1:Gynécée>"
  },
  State_139039_Desc = {
    Text = "La prochaine Exaltation de ce Corps éveillé ce tour augmente de [Layer]% l'Effet final des Dommages, du Bouclier fixe, de la récupération fixe de PV, de la Force fixe, de la Force réduite, des Dégâts des tentacules augmentés, du Poison fixe et de la Contre-attaque fixe."
  },
  State_139039_Name = {
    Text = "<BreedingKeywords2:Fiesta de propagation>"
  },
  State_139687_Desc = {
    Text = "Une vie radieuse chante la liberté et entonne un chant de victoire, pouvant être consommée par l'Exaltation de Saya pour renforcer son Effet. Cet État peut s'accumuler jusqu'à 4 couches et sera conservé après la fin du combat."
  },
  State_139687_Name = {
    Text = "<KaiHuajishu:Gynécée>"
  },
  State_139688_Desc = {
    Text = "Équipe Unique : Limite d'Arithmetica +1, les effets du même type ne peuvent pas se cumuler.\nPour chaque tranche de 10 Base Aliemus que possède le Porteur, il inflige +<WeaponEffect_Num:[StateArg1]%> de charges de <Corrosion:Corrosion> et provoque +<WeaponEffect_Num:[Float:StateArg2]％> de Fusion d'Embryon."
  },
  State_139688_WeaponDesc = {
    Text = "Limite d'Arithmetica +1, les effets du même type ne peuvent pas se cumuler.\nPour chaque tranche de 10 Base Aliemus que possède le Porteur, il inflige +<WeaponEffect_Num:[StateArg1]%> de charges fixes de <Corrosion:Corrosion> et provoque +<WeaponEffect_Num:[Float:StateArg2]%> de Fusion d'Embryon."
  },
  State_139689_Desc = {
    Text = "Équipe Unique : Après avoir utilisé «Forge Écarlate», le Porteur gagne une Fureur égale à <WeaponEffect_Num:[StateArg1]%> de la Base Aliemus. Temps de recharge de 3 tours."
  },
  State_139689_WeaponDesc = {
    Text = "Après avoir utilisé « Forge Écarlate », le Porteur gagne <WeaponEffect_Num:[StateArg1]%> de l'Aliemus de base en tant qu'Aliemus, avec un temps de recharge de 3 tours."
  },
  State_139977_Desc = {
    Text = "Ce tour, si vous jouez « Attaque », « Attaque » inflige +[DescArg1]% de Dommages Perçants ; sinon, gagnez +[Layer] Barrière en fin de tour."
  },
  State_139977_Name = {
    Text = "Bête stellaire"
  },
  State_140063_Desc = {
    Text = "Ceci est une « reconnaissance de dette » créée en empruntant de l›Arithmetica au prochain tour. [Layer] Arithmetica sera déduit au début du prochain tour. Ne peut pas être dissipé."
  },
  State_140063_Name = {
    Text = "Dans le rouge"
  },
  State_140068_Desc = {
    Text = "La/Les [DescArg1] prochaine(s) Carte(s) « Compétence » coûte(nt) – [StateArg1] Arithmetica."
  },
  State_140068_Name = {Text = "Épiphanie"},
  State_140135_Desc = {
    Text = "Pour chaque couche possédée, la prochaine Exaltation de ce Corps éveillé ce tour augmente de 1% l'Effet final des Dommages, du Bouclier fixe, de la récupération fixe de PV, de la Force fixe, de la Force réduite, des Dégâts des tentacules augmentés, du Poison fixe et de la Contre-attaque fixe."
  },
  State_140135_Name = {
    Text = "<BreedingKeywords2:Fiesta de propagation>"
  },
  State_140186_WeaponDesc = {
    Text = "Tous les dégâts du saut de baleine +1"
  },
  State_140454_Desc = {
    Text = "Unique en équipe : Pour chaque 1% d'Encre Noire perdue par le porteur, sa Roue du Destin ou son Pacte Secret, récupère <WeaponEffect_Num:[StateArg1]%> des PV max après le combat. Cet effet de récupération diminue de 30% à la fin de chaque tour, calculé indépendamment pour chaque instance. Après avoir utilisé « Perception » dans les « Ruines de Cendres », le rafraîchissement de cette session des « Ruines de Cendres » ne consomme pas d'Encre Noire."
  },
  State_140454_WeaponDesc = {
    Text = "Pour chaque 1% de Sceaux Obtenus que possèdent le Porteur, ses Roues du Destin et Concordances, récupérez <WeaponEffect_Num:[DescArg2]%> de PV Max ([DescArg1]) à la fin du combat. Cet effet diminue de 30% à la fin de chaque tour, et est calculé individuellement pour chaque combat.\nAprès avoir choisi « Induction » aux « Ruines Cendrées », les rafraîchissements seront gratuits dans ces « Ruines Cendrées »."
  },
  State_140456_WeaponDesc = {
    Text = "Après avoir joué, retire définitivement"
  },
  State_140458_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Lors de l'équipement et après qu'un Éveillé déclenche une « Éruption de Furie », obtient <Block:[Block:StateArg1]> bouclier."
  },
  State_140458_Name = {
    Text = "Ex Stellaris"
  },
  State_140489_Desc = {
    Text = "Obtient une quantité équivalente de PV max. Le nombre de cumuls ne peut pas dépasser les PV max initiaux de l'Éveillé."
  },
  State_140489_Name = {Text = "Gynécée"},
  State_140490_Desc = {
    Text = "Obtient une quantité équivalente de PV max. Le nombre de cumuls ne peut pas dépasser les PV max initiaux de cet Éveillé [DescArg1]."
  },
  State_140490_Name = {Text = "Gynécée"},
  State_140495_Desc = {
    Text = "L'Arithmetica consommée par la prochaine «compétence» - [Layer] ."
  },
  State_140495_Name = {Text = "Réécrire"},
  State_140517_Desc = {
    Text = "La puissance de calcul consommée par la prochaine « Compétence » – [DescArg1] ."
  },
  State_140517_Name = {Text = "Réécrire"},
  State_140547_Desc = {
    Text = "Cet effet peut augmenter la Fusion Embryonnaire de 100 au maximum, et n'est pas affecté par les bonus d'augmentation de Fusion Embryonnaire."
  },
  State_140547_Name = {
    Text = "Fusion d'Embryon Double"
  },
  State_140645_Desc = {
    Text = "Effet d'attente"
  },
  State_140645_Name = {
    Text = "Effet d'attente"
  },
  State_140647_Name = {
    Text = "Écoute de Dissonance Cognitive jouée"
  },
  State_140648_Name = {
    Text = "Compteur de Dissonance Cognitive du joueur"
  },
  State_140650_Desc = {
    Text = "Les 3 premières fois par tour où vous jouez une Carte d'instruction avec « Distorsion de Perception », Saya obtient [Layer] Aliemus."
  },
  State_140650_Name = {
    Text = "Altération Cognitive"
  },
  State_140651_Desc = {
    Text = "Effet d'attente"
  },
  State_140651_Name = {
    Text = "Effet d'attente"
  },
  State_140653_Desc = {
    Text = "Le Coût d'Arithmetica de cette Carte a 10% de chances de -2, 25% de chances de -1, 30% de chances de rester inchangé, 25% de chances de +1, 10% de chances de +2. Retire cet État après avoir joué ou défaussé la Carte."
  },
  State_140653_Name = {
    Text = "<ExclamationPointColour:Peindre>"
  },
  State_140654_Desc = {
    Text = "Effet d'attente"
  },
  State_140654_Name = {
    Text = "Effet d'attente"
  },
  State_140655_Desc = {
    Text = "Cette Carte est recouverte par la Fusion et son texte ne peut être consulté. Le Coût d'Arithmetica a 10% de chances de -2, 25% de chances de -1, 30% de chances de rester inchangé, 25% de chances de +1, 10% de chances de +2. Retire cet État après avoir joué ou défaussé la Carte."
  },
  State_140655_Name = {
    Text = "<ErosionColorInkKeywords:Fusion Encre colorée>"
  },
  State_140656_Desc = {
    Text = "Le Coût d'Arithmetica de cette Carte a 10% de chances de -2, 25% de chances de -1, 30% de chances de rester inchangé, 25% de chances de +1, 10% de chances de +2. Retire cet État après avoir joué ou défaussé la Carte."
  },
  State_140656_Name = {
    Text = "<ColorInkKeywords:Peindre>"
  },
  State_140657_Desc = {
    Text = "Cette Carte est recouverte par la Fusion et son texte ne peut être consulté. Le Coût d'Arithmetica a 10% de chances de -2, 25% de chances de -1, 30% de chances de rester inchangé, 25% de chances de +1, 10% de chances de +2. Retire cet État après avoir joué ou défaussé la Carte."
  },
  State_140657_Name = {
    Text = "<ExclamationPointColour:Fusion Encre colorée>"
  },
  State_140658_Name = {
    Text = "Joueur possède Écoute de Dissonance Cognitive"
  },
  State_140659_Desc = {
    Text = "Effet d'attente"
  },
  State_140659_Name = {
    Text = "Effet d'attente"
  },
  State_140662_Desc = {
    Text = "Au début de chaque tour, « Distorsion de Perception » est appliquée aléatoirement à 2 Cartes d'instruction qui n'ont pas « Distorsion de Perception »."
  },
  State_140662_Name = {
    Text = "Traitement de Reconstruction de la Vie"
  },
  State_140672_Desc = {
    Text = "Ce Corps éveillé sombre dans le chaos, réduisant les Dommages infligés, la Régénération de PV et le Bouclier du personnage d'un pourcentage aléatoire de 15%～35%, et ne peut pas être dissipé."
  },
  State_140672_Name = {
    Text = "<PVPCognitiveDissonanceKeyWords:Distorsion de Perception>"
  },
  State_140673_Desc = {
    Text = "Ce Corps éveillé sombre dans le chaos, réduisant les Dommages infligés, la Régénération de PV et le Bouclier du personnage d'un pourcentage aléatoire de 15%～35%, et ne peut pas être dissipé."
  },
  State_140673_Name = {
    Text = "Distorsion de Perception"
  },
  State_140683_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : En équipant, obtient [StateArg1] <MaxHPKeywords:PV Max>, à la fin du tour, régénère <Heal:[Heal:DescArg1]> PV, la Régénération de PV augmente à mesure que les PV du Porteur diminuent, jusqu'à un maximum de [StateArg3]%."
  },
  State_140683_Name = {
    Text = "Lily au Pays des Merveilles"
  },
  State_140724_Name = {
    Text = "Alimentation"
  },
  State_140726_Desc = {
    Text = "L'Effet final des Dommages, de la Force, des Dégâts des tentacules, du Poison fixe, de la Contre-attaque fixe, du Bouclier du personnage, de la Régénération de PV et de la Force réduite infligés par cette Carte est réduit de [DescArg1]%."
  },
  State_140726_Name = {
    Text = "<AdaptKeywords1:Adaptation [DescArg1]>"
  },
  State_140727_Desc = {
    Text = "Lorsque la Faim atteint 5 couches, à la fin du tour, consomme toute la Faim, change l'intention en Attaque puissante et gagne [DescArg1] point(s) de Force."
  },
  State_140727_Name = {Text = "Faim"},
  State_140728_Desc = {
    Text = "Au début de chaque tour, gagne 1 couche de Faim. Lorsque des Dommages non bloqués sont infligés, gagne un Bouclier égal à 2% des PV Max ([DescArg1]). Le nombre maximum de couches d'Adaptation est porté à 75."
  },
  State_140728_Name = {
    Text = "Garde-manger"
  },
  State_140730_Desc = {
    Text = "Après avoir joué une Carte d'instruction, applique 10 couches d'<AdaptKeywords:Adaptation> aux cartes de l'Éveilleur associé à tous les emplacements, et retire 5 couches d'<AdaptKeywords:Adaptation> aux cartes des autres Éveilleurs. Chaque couche d'<AdaptKeywords:Adaptation> réduit de 1% l'effet final des Dommages, de la Force, des Dégâts des tentacules, du Poison fixe, de la Contre-attaque fixe, du Bouclier, de la récupération de PV et de la réduction de Force infligés par la carte, jusqu'à un maximum de [DescArg1] couches."
  },
  State_140730_Name = {Text = "Mimétisme"},
  State_140838_Desc = {
    Text = "Les Dommages infligés ce tour sont réduits de [Layer]%."
  },
  State_140838_Name = {
    Text = "Mur de Cauchemar Obscurcissant"
  },
  State_140839_Desc = {
    Text = "Ce tour, les Dégâts Finaux de tous les Corps éveillés augmentent de [Layer]%."
  },
  State_140839_Name = {
    Text = "Chasse en Meute"
  },
  State_140856_Desc = {
    Text = "Le Corps éveillé ne peut pas agir. Retire 1 charge d'Interférence de conscience à la fin du tour. Après la suppression de toutes les charges, la prochaine Exaltation libérée par ce Corps éveillé est considérée comme une Sur-Exaltation. Si une Sur-Exaltation a déjà été libérée, 100% de l'Aliemus de base est restitué."
  },
  State_140856_Name = {
    Text = "<Yishiganshe:Interférence de Conscience>"
  },
  State_140860_Desc = {
    Text = "Le Corps éveillé ne peut pas agir. Retire 1 charge d'Interférence de conscience à la fin du tour. Après la suppression de toutes les charges, la prochaine Exaltation libérée par ce Corps éveillé est considérée comme une Sur-Exaltation. Si une Sur-Exaltation a déjà été libérée, 100% de l'Aliemus de base est restitué."
  },
  State_140860_Name = {
    Text = "<Yishiganshe:Interférence de Conscience>"
  },
  State_140861_Desc = {
    Text = "La prochaine Exaltation libérée est considérée comme une Sur-Exaltation. Si une Sur-Exaltation a déjà été libérée, 100% de l'Aliemus de base est restitué."
  },
  State_140861_Name = {
    Text = "Lily au Pays des Merveilles"
  },
  State_140873_Desc = {
    Text = "Chaque couche réduit de 1% l'Effet final des Dommages, de la Force, des Dégâts des tentacules, du Poison fixe, de la Contre-attaque fixe, du Bouclier, de la récupération de PV et de la Force réduite infligés par cette Carte, jusqu'à [DescArg1] couches maximum."
  },
  State_140873_Name = {
    Text = "<AdaptKeywords:Adaptation>"
  },
  State_140877_Name = {
    Text = "Effet supplémentaire [DescArg1] fois"
  },
  State_141468_Desc = {
    Text = "Lorsque la Faim atteint 5 couches, à la fin du tour, consomme toute la Faim, change l'intention en Attaque puissante et gagne de la Force."
  },
  State_141468_Name = {
    Text = "<HungerKeywords:Faim>"
  },
  State_141504_Desc = {
    Text = "Accumule jusqu'à 3 dépouilles. Une fois la limite atteinte, le prochain «Festin des êtres vivants» pourra les consommer et en renforcer les effets. Les dépouilles seront transmises à la prochaine bataille."
  },
  State_141504_Name = {Text = "Débris"},
  State_141950_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Lors de l'équipement et à la fin du tour, <PVPDiscoveryKeyWords:Découverte> de [StateArg1] «Compétence(s)» dotée(s) de <PVPVoidKeywords:Vide>, placée(s) dans la Main."
  },
  State_141950_Name = {
    Text = "Descente Ascendante"
  },
  State_141988_Desc = {
    Text = "Les Dommages, Boucliers, soins infligés par cette carte, ainsi que la Force, le Drainer, les Dégâts des tentacules, le Poison, la Contre-attaque, le Verdict final, le Poison fixe, la Contre-attaque fixe, le Verdict final fixe appliqués, voient leur Effet augmenté de [Layer]%."
  },
  State_141988_Name = {
    Text = "Iridescence de cette carte"
  },
  State_141989_Desc = {
    Text = "Crée des Cartes aléatoires."
  },
  State_141989_Name = {
    Text = "<CardKeyWord:Découverte>"
  },
  State_141991_Desc = {
    Text = "Les Dommages, Boucliers, soins infligés par l'Exaltation de cet Éveilleur, ainsi que la Force, le Drainer, les Dégâts des tentacules, le Poison, la Contre-attaque, le Verdict final, le Poison fixe, la Contre-attaque fixe, le Verdict final fixe appliqués, voient leur Effet augmenté de [Layer]%."
  },
  State_141991_Name = {
    Text = "Iridescence de l'Exaltation"
  },
  State_141992_Desc = {
    Text = "Les Dommages, Boucliers, soins infligés par les cartes de cet Éveilleur, ainsi que la Force, le Drainer, les Dégâts des tentacules, le Poison, la Contre-attaque, le Verdict final, le Poison fixe, la Contre-attaque fixe, le Verdict final fixe appliqués, voient leur Effet augmenté de [Layer]%."
  },
  State_141992_Name = {
    Text = "Iridescence de cette carte"
  },
  State_141993_Desc = {
    Text = "Les Dommages, Boucliers, soins infligés par les Cartes d'instruction de cet Éveilleur, ainsi que la Force, le Drainer, les Dégâts des tentacules, le Poison, la Contre-attaque, le Verdict final, le Poison fixe, la Contre-attaque fixe, le Verdict final fixe appliqués, voient leur Effet augmenté de [Layer]%."
  },
  State_141993_Name = {
    Text = "Iridescence des Cartes d'instruction"
  },
  State_141994_Desc = {
    Text = "Après avoir joué une Carte, après avoir déclenché une Exaltation : Dommages infligés, Bouclier obtenu, soins reçus, Force appliquée, Drainer, Dégâts des tentacules, Poison, Contre-attaque, Verdict final, Poison fixe, Contre-attaque fixe, Verdict final fixe."
  },
  State_141994_Name = {
    Text = "Commande de déclenchement chatoyant"
  },
  State_142018_Desc = {
    Text = "Au début du tour, obtenez 1 couche de <Guaiwucanhai:débris>"
  },
  State_142018_Name = {
    Text = "Invitation à la résidence royale"
  },
  State_142057_Desc = {
    Text = "Après avoir utilisé un Décret Clé, change sa propre intention. Au début du combat, le Niveau de charge de la clé d'argent de tous les Corps éveillés augmente de 25%."
  },
  State_142057_Name = {
    Text = "Épiphanie de Causalité"
  },
  State_142058_Desc = {
    Text = "Le Dommage de base, le Poison et la Contre-attaque infligés sont réduits de [DescArg1]%"
  },
  State_142058_Name = {
    Text = "Aile Souillée"
  },
  State_142060_Desc = {
    Text = "Chaque fois que l'ennemi utilise une Carte d'instruction, gagne 1 couche de Ferveur temporaire. Lorsque la Ferveur temporaire atteint 10 couches, après avoir joué la prochaine Carte d'instruction, agit immédiatement et retire toute la Ferveur temporaire."
  },
  State_142060_Name = {
    Text = "Écho des abysses"
  },
  State_142062_Desc = {
    Text = "L'effet initial de 0246 est aléatoire à chaque fois"
  },
  State_142062_Name = {
    Text = "Intention aléatoire"
  },
  State_142063_Desc = {
    Text = "Durant son propre tour, les Dommages subis sont réduits de [DescArg1]%."
  },
  State_142063_Name = {
    Text = "Aile Sacrée"
  },
  State_142065_Desc = {
    Text = "Supprimé au début du tour. Lorsqu'elle atteint 10 couches, après avoir joué la prochaine Carte d'instruction, agit immédiatement et retire toute la Ferveur temporaire."
  },
  State_142065_Name = {Text = "Ferveur"},
  State_142066_Desc = {
    Text = "Les effets de <WeaknessIconKeywords:faiblesse>, <FragileIconKeywords:fragile>, et <HeavyInjuryKeywords:blighten> augmentent à 50%."
  },
  State_142066_Name = {
    Text = "Clairvoyance essentielle"
  },
  State_142067_Desc = {
    Text = "Les dommages de Force, Contre-attaque et Tentacule infligés sont réduits de [DescArg1]%"
  },
  State_142067_Name = {
    Text = "Aile Maudite"
  },
  State_142072_Desc = {
    Text = "À chaque fois que vous subissez des dommages ou perdez des PV, cela ne peut pas dépasser 5 % de la santé maximale."
  },
  State_142072_Name = {
    Text = "Seuil de tolérance à la douleur"
  },
  State_142091_Desc = {
    Text = "Compteur du Doublement des six ailes"
  },
  State_142091_Name = {
    Text = "Compteur du Doublement des six ailes"
  },
  State_142092_Desc = {
    Text = "Le Niveau de charge de la clé d'argent de tous les Corps éveillés augmente de 25%."
  },
  State_142092_Name = {
    Text = "Épiphanie de Causalité"
  },
  State_142093_Desc = {
    Text = "Progression de la consommation du Doublement des six ailes : [DescArg1], valeur de dégâts requise actuelle : [DescArg2]."
  },
  State_142093_Name = {
    Text = "Doublement des six ailes"
  },
  State_142095_Desc = {
    Text = "Marqueur du Doublement des six ailes"
  },
  State_142095_Name = {
    Text = "Marqueur du Doublement des six ailes"
  },
  State_142166_Desc = {
    Text = "Voir la logique de grève générale pour des effets spécifiques. __ \"Pour usage de développement uniquement\""
  },
  State_142213_Name = {
    Text = "Réduire la puissance de calcul maximale"
  },
  State_142215_Desc = {
    Text = "Si la cible est toujours morte au début du prochain tour, elle est ressuscitée et obtient un Bouclier de [StateArg1], impossible à dissiper."
  },
  State_142215_Name = {
    Text = "Obsession Éternelle"
  },
  State_142228_Desc = {
    Text = "Cette Carte a été créée par la Roue du Destin «Descente Ascendante»."
  },
  State_142228_Name = {
    Text = "Descente Ascendante"
  },
  State_142229_Desc = {
    Text = "Équipe Unique : au début de l'exploration, ajoute 1 carte «Lily au Pays des Merveilles» au deck. «Lily au Pays des Merveilles» : consomme 2 points d'Arithmetica, fait obtenir au Porteur <WeaponEffect_Num:[StateArg1]> points d'Aliemus et 3 charges de <Yishiganshe:«Interférence de conscience»>. <RetainIconKeywords:Garder>. <DepleteIconKeywords:Consommer>."
  },
  State_142229_Name = {
    Text = "Lily au Pays des Merveilles"
  },
  State_142229_WeaponDesc = {
    Text = "Au début de l'exploration, ajoute 1 carte «Lily au Pays des Merveilles» au deck. «Lily au Pays des Merveilles» : consomme 2 points d'Arithmetica, fait obtenir au Porteur <WeaponEffect_Num:[StateArg1]> points d'Aliemus et <Yishiganshe:«Interférence de conscience»>. <RetainIconKeywords:Garder>. <DepleteIconKeywords:Consommer>."
  },
  State_142452_Desc = {
    Text = "Les effets de Force réduite subis sont diminués de 50%."
  },
  State_142452_Name = {
    Text = "Existence immortelle"
  },
  State_142663_Desc = {
    Text = "Au début du prochain tour, obtenir <DelayKeywords:Latence> : [Layer] Aliemus."
  },
  State_142663_Name = {
    Text = "Latence de Fureur de latence"
  },
  State_142688_Desc = {
    Text = "La Roue du Destin équipée par la cible est désactivée, impossible à dissiper."
  },
  State_142688_Name = {
    Text = "Super Entrelacé"
  },
  State_142692_Desc = {
    Text = "Une nouvelle petite idée est en train d'émerger."
  },
  State_142692_Name = {
    Text = "Éclair de génie"
  },
  State_142715_Desc = {
    Text = "Les dommages de cette «compétence» augmentent de [DescArg1]%, et chaque point d'Arithmetica consommé par cette compétence augmente les dommages de [StateArg1]%."
  },
  State_142715_Name = {Text = "Mort ambre"},
  State_142887_Desc = {
    Text = "Si la cible subit à nouveau une «Paralysie» ce tour, toutes ses «Attaque» deviennent des «Illusion», impossible à dissiper, jusqu'à la fin du tour."
  },
  State_142887_Name = {
    Text = "Un peu paralysé"
  },
  State_142954_Desc = {
    Text = "La Limite d'Arithmetica est de 0 au minimum. Au début de chaque tour, si elle est inférieure à 10, elle augmente de 1. Une fois atteint 10, tout gain supplémentaire de Limite d'Arithmetica se convertit en pioche d'un nombre équivalent de Cartes."
  },
  State_142954_Name = {
    Text = "Limite d’Arithmetica"
  },
  State_143002_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Non configurée"
  },
  State_143002_Name = {
    Text = "Sathogua SR (Texte temporaire)"
  },
  State_143004_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Non configurée"
  },
  State_143004_Name = {
    Text = "Arme exclusive de Sartogoa (texte temporaire)"
  },
  State_143005_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Non configurée"
  },
  State_143005_Name = {
    Text = "Lantigus SR (Texte temporaire)"
  },
  State_143006_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Non configurée"
  },
  State_143006_Name = {
    Text = "Arme exclusive du Pharaon noir (texte temporaire)"
  },
  State_143007_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Lorsqu'équipé et au début du tour, applique [StateArg1] <plural value=\"[StateArg1]\" singular=\"charge\" plural=\"charges\"> de <PVPCompassKeywords:Boussole vers le Faux Nord> à un ennemi aléatoire."
  },
  State_143007_Name = {
    Text = "La Boussole errante"
  },
  State_143008_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Non configurée"
  },
  State_143008_Name = {
    Text = "Arme exclusive de l'Oiseau Chactac (texte temporaire)"
  },
  State_143009_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Non configurée"
  },
  State_143009_Name = {
    Text = "Arme exclusive d'Aphogmon (texte temporaire)"
  },
  State_143010_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Limite de Main +[StateArg1], lorsque le Porteur ou un allié meurt, ses Cartes ne se transforment plus en <PVPDerivativeCardKeywords_2:«Songe»>, mais se transforment en <PVPDerivativeCardKeywords_30:«Arrachage-Décharné»>."
  },
  State_143010_Name = {
    Text = "Cage vivante"
  },
  State_143011_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Non configurée"
  },
  State_143011_Name = {
    Text = "vautour SR (Texte temporaire)"
  },
  State_143012_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Non configurée"
  },
  State_143012_Name = {
    Text = "Shatakoise SR (Texte temporaire)"
  },
  State_143013_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Non configurée"
  },
  State_143013_Name = {
    Text = "Origine Ogier SR (Texte temporaire)"
  },
  State_143014_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Avant l'«Exaltation», perd 25% des PV actuels ; après l'«Exaltation», inflige [StateArg1] Dommages à tous les ennemis et Drain une quantité équivalente de PV."
  },
  State_143014_Name = {
    Text = "Tromperie mielleuse"
  },
  State_143016_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Non configurée"
  },
  State_143016_Name = {
    Text = "Pharaon noir SR (Texte temporaire)"
  },
  State_143017_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Non configurée"
  },
  State_143017_Name = {
    Text = "Arme exclusive de Lantigos (texte temporaire)"
  },
  State_143018_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Non configurée"
  },
  State_143018_Name = {
    Text = "Turu la Source SR (Texte temporaire)"
  },
  State_143019_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Après «Exaltation», inflige [StateArg1] couche(s) de <PVPBless:Bénédiction> à tous les ennemis."
  },
  State_143019_Name = {
    Text = "La Douce Vérité"
  },
  State_143020_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Non configurée"
  },
  State_143020_Name = {
    Text = "Arme exclusive Origine Ogier (texte temporaire)"
  },
  State_143022_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Non configurée"
  },
  State_143022_Name = {
    Text = "Arme exclusive du Vautour (texte temporaire)"
  },
  State_143023_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Non configurée"
  },
  State_143023_Name = {
    Text = "Yafogmon SR (Texte temporaire)"
  },
  State_143326_Desc = {
    Text = "La Régénération de Fragment de clé augmente de [DescArg1]."
  },
  State_143326_Name = {
    Text = "Épiphanie de Causalité"
  },
  State_143331_Desc = {
    Text = "Avant la fin du prochain tour, absorbe la moitié des Dommages pour <StatusApplier:>. Cet État est Équipe Unique, et est retiré si l'un ou l'autre des deux liés meurt. Ne peut pas être dissipé."
  },
  State_143331_Name = {
    Text = "Prise en charge des Dommages"
  },
  State_143333_Desc = {
    Text = "Avant le début du prochain tour, <StatusApplier:> absorbe la moitié des Dommages à sa place. Cet État est Équipe Unique, et est retiré si l'un ou l'autre des deux liés meurt. Ne peut pas être dissipé."
  },
  State_143333_Name = {
    Text = "Dommages Transférés"
  },
  State_143336_Desc = {
    Text = "Lorsque vous jouez un «Thrall-Décharné», consomme 1 couche pour lui faire Prendre effet 1 fois supplémentaire, jusqu'à un maximum de 9 couches. Non supprimé à la fin du combat."
  },
  State_143336_Name = {
    Text = "<BattueKeywords:Chasse en cercle>"
  },
  State_143340_Desc = {
    Text = "Lorsque vous jouez un «Thrall-Décharné», consomme 1 couche pour lui faire Prendre effet 1 fois supplémentaire, jusqu'à un maximum de 9 couches. Non supprimé à la fin du combat."
  },
  State_143340_Name = {
    Text = "<BattueKeywords:Chasse en cercle>"
  },
  State_143386_Desc = {
    Text = "Absorbe la moitié des Dommages pour <StatusApplier:>. Ne peut pas être dissipé."
  },
  State_143386_Name = {
    Text = "Prise en charge des Dommages"
  },
  State_143387_Desc = {
    Text = "<StatusApplier:> absorbe la moitié des Dommages à sa place. Ne peut pas être dissipé."
  },
  State_143387_Name = {
    Text = "Dommages Transférés"
  },
  State_143406_Name = {
    Text = "Cette Carte prend effet [DescArg1] fois supplémentaire(s)"
  },
  State_143408_Desc = {
    Text = "Lorsqu'attaqué par un ennemi, se convertit en Aliemus de l'attaquant."
  },
  State_143408_Name = {
    Text = "La Boussole errante"
  },
  State_143409_Desc = {
    Text = "Lorsqu'attaqué par un ennemi, se convertit en Aliemus de l'attaquant."
  },
  State_143409_Name = {
    Text = "<CardKeyWord:La Boussole errante>"
  },
  State_143419_Desc = {
    Text = "Cette carte provient de <PVPDerivativeCardKeywords_31:«Le trésor d'Auréa»>."
  },
  State_143419_Name = {
    Text = "Le trésor d'Auréa"
  },
  State_143426_Desc = {
    Text = "Après le début du tour, déduit [Layer] Arithmetica. Ne peut pas être dissipé."
  },
  State_143426_Name = {
    Text = "Déduction d'Arithmetica en Latence"
  },
  State_143441_Desc = {
    Text = "Corps éveillé sélectionné lors du tour [StateArg1]."
  },
  State_143441_Name = {
    Text = "Marqueur de test 1"
  },
  State_143442_Desc = {
    Text = "Corps éveillé sélectionné lors du tour [StateArg1]."
  },
  State_143442_Name = {
    Text = "Marqueur de test 2"
  },
  State_143444_Desc = {
    Text = "Corps éveillé sélectionné lors du tour [StateArg1]."
  },
  State_143444_Name = {
    Text = "Marqueur de test 4"
  },
  State_143445_Desc = {
    Text = "Corps éveillé sélectionné lors du tour [StateArg1]."
  },
  State_143445_Name = {
    Text = "Marqueur de test 3"
  },
  State_143499_Name = {
    Text = "Immunité aux Dégâts Directs__«仅开发用»"
  },
  State_143500_Name = {
    Text = "Immunité aux dommages purs__«仅开发用»"
  },
  State_143541_Desc = {
    Text = "Réduit les Dommages infligés par tous les ennemis ce tour de [DescArg1]%, et gagne [DescArg2] points de Force."
  },
  State_143541_Name = {Text = "Garde"},
  State_143542_Desc = {
    Text = "Dégâts Finaux Temporaires +[DescArg1]%, et inflige une Corrosion égale à [DescArg2]% des PV Max à tous les ennemis."
  },
  State_143542_Name = {Text = "Chasse"},
  State_143548_Desc = {
    Text = "Applique un Bouclier et ajoute un État, monstre, branche 1."
  },
  State_143548_Name = {
    Text = "Conversion Bouclier Monstre 1"
  },
  State_143549_Desc = {
    Text = "Applique un Bouclier et ajoute un État, Corps éveillé, branche 2."
  },
  State_143549_Name = {
    Text = "Conversion Bouclier Personnage 2"
  },
  State_143550_Desc = {
    Text = "Applique un Bouclier et ajoute un État, Corps éveillé, branche 1."
  },
  State_143550_Name = {
    Text = "Conversion Bouclier Personnage 1"
  },
  State_143551_Desc = {
    Text = "Inflige un Bouclier et ajoute un État, monstre, branche 2."
  },
  State_143551_Name = {
    Text = "Conversion Bouclier Monstre 2"
  },
  State_143552_Desc = {
    Text = "Applique un Bouclier et ajoute un État, joueur, branche 1."
  },
  State_143552_Name = {
    Text = "Conversion Bouclier Joueur 1"
  },
  State_143553_Desc = {
    Text = "Applique un Bouclier et ajoute un État, joueur, branche 2."
  },
  State_143553_Name = {
    Text = "Conversion Bouclier Joueur 2"
  },
  State_143573_Desc = {
    Text = "Le Thrall-Décharné est une carte de buff de Pontos comprenant 3 types : «Pillage-Décharné», «Harcèlement-Décharné» et «Assault-Décharné». Lorsqu'un «Thrall-Décharné» permanent est généré et que le nombre de «Thrall-Décharné» permanents dépasse 6, un «Thrall-Décharné» permanent aléatoire est amélioré en «Jumelage de Décharnés» dont le Coût d'Arithmetica est +1 mais qui Prend effet 1 fois supplémentaire. Le «Jumelage de Décharnés» compte comme 2 «Thrall-Décharnés» dans le deck. Si tous les «Thrall-Décharnés» ont déjà été améliorés, place dans la main 1 «Inspiration avancée» avec <DestructionKeywords:Détruire>."
  },
  State_143573_Name = {
    Text = "Thrall-Décharné"
  },
  State_143578_Desc = {
    Text = "Durant ce tour, chaque fois que vous recevez des Dégâts Directs, placez [Layer] carte(s) <PVPDerivativeCardKeywords_30:«Thrall-Gaunt»> dans votre Main."
  },
  State_143578_Name = {
    Text = "Rite du Seigneur"
  },
  State_143595_Desc = {
    Text = "Cette Carte a reçu <PrepareKeywords:Prépare> [StateArg1]."
  },
  State_143595_Name = {
    Text = "Pas de danse du cygne noir"
  },
  State_143597_Desc = {
    Text = "Équipe Unique : l'effet de Force réduite infligé par le Porteur est augmenté de <WeaponEffect_Num:[StateArg1]%>. Lors du passage en posture «Vagues Déchaînées», les Dommages critiques temporaires augmentent d'une valeur égale à <WeaponEffect_Num:[StateArg1]%> des Dégâts Critiques de base du Porteur, avec un temps de recharge de 3 tours."
  },
  State_143597_WeaponDesc = {
    Text = "L'effet de Force réduite infligé par le Porteur est augmenté de <WeaponEffect_Num:[StateArg1]%>. Après le passage en posture «Vagues Déchaînées», les Dommages critiques temporaires augmentent de <WeaponEffect_Num:[DescArg1]%>, avec un temps de recharge de 3 tours."
  },
  State_143598_Desc = {
    Text = "Équipe Unique : l'effet de Force réduite infligé par le Porteur est augmenté de <WeaponEffect_Num:[StateArg1]%>. Chaque Élimination d'un ennemi augmente de 2 points la Fureur récupérée de manière fixe à la fin du tour d'exploration en cours du Porteur, cumulable jusqu'à <WeaponEffect_Num:[StateArg2]> fois. Après le passage en posture «Vagues Déchaînées», les Dommages critiques temporaires augmentent d'une valeur égale à <WeaponEffect_Num:[StateArg1]%> des Dégâts Critiques de base du Porteur, avec un temps de recharge de 3 tours."
  },
  State_143598_WeaponDesc = {
    Text = "L'effet de Force réduite infligé par le Porteur est augmenté de <WeaponEffect_Num:[StateArg1]%>. Chaque Élimination d'un ennemi augmente de 2 points la Fureur récupérée de manière fixe à la fin du tour d'exploration en cours du Porteur, cumulable jusqu'à <WeaponEffect_Num:[StateArg2]> fois. Après le passage en posture «Vagues Déchaînées», les Dommages critiques temporaires augmentent de <WeaponEffect_Num:[DescArg1]%>, avec un temps de recharge de 3 tours."
  },
  State_143683_Desc = {
    Text = "La Poursuite de cet Éveilleur est scellée et ne peut pas être utilisée, le sceau se lève après [Layer] tour(s)."
  },
  State_143683_Name = {
    Text = "<Seal1:Poursuite Scellée>"
  },
  State_144381_Desc = {
    Text = "Impossible d'agir, Restant [DescArg1] tour(s)."
  },
  State_144381_Name = {
    Text = "<Yishiganshe:Interférence de Conscience>"
  },
  State_144441_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Lorsqu'un allié meurt, gagne <Energy:[Energy:StateArg1]> Fureur. Lorsqu'un allié est ressuscité, il gagne <Energy:[Energy:StateArg2]> Fureur. L'effet d'acquisition de Fureur ne s'applique que si la Fureur de la cible n'est pas pleine, reste actif [Layer] fois, puis cette Roue du Destin est détruite une fois les charges épuisées."
  },
  State_144441_Name = {
    Text = "Synchronisation des Âmes"
  },
  State_144494_Desc = {
    Text = "Il existe 7 types d'effets, notamment : piocher 8 cartes, gagner 6 Arithmetica, gagner un Fragment de clé, tous les Éveilleurs gagnent de la Fureur Fixe, gagner de la FOR, réduire temporairement la FOR de tous les ennemis, augmenter temporairement l'Amplification de Dégâts."
  },
  State_144494_Name = {
    Text = "<Blessing:Bénédiction>"
  },
  State_144508_Desc = {
    Text = "«Prix» se présente en 3 types :\n\nOccasion Manquée : Retarde l'effet du «Don» associé de 2 tours.\nParoles Dorées : Réduit l'effet du «Don» associé de 50%.\nMalveillance Voilée : Inflige 1 effet négatif aléatoire à votre équipe :\n<Italic:2 tours de Symptôme : Affaiblir ; 2 tours de Fragile, 2 tours de Corruption ; charges de Poison égales à 1% des PV Max ; 2 charges de Vide ; 1 charge de Stase sur 2 cartes aléatoires en main ; ou génère 2 Cartes de symptômes Temporaires (qui ne persistent pas entre les combats) et les place au sommet de la Pioche.>"
  },
  State_144508_Name = {
    Text = "<BlessingNegativeEffect:Prix>"
  },
  State_144519_Desc = {
    Text = "Variable de test, se rafraîchit après le début du tour ou après avoir joué une Carte. Possède actuellement [Layer] esprits du Royaume."
  },
  State_144519_Name = {
    Text = "Esprit du nouveau Royaume du Chaos"
  },
  State_145228_Name = {
    Text = "<WormGrowth:Repas>"
  },
  State_145229_Desc = {
    Text = "Vous faites partie de la Bénédiction~ ! Peut être consommé par l'Exaltation de Caraboo pour un bonus, jusqu'à 5 charges. Persiste entre les combats."
  },
  State_145229_Name = {
    Text = "<SacrificialMark:Sacrifice>"
  },
  State_145436_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Les Dommages d'«Attaque» augmentent de [DescArg1]%, chaque «Attaque» augmente les Dommages de [StateArg2]% supplémentaires, jusqu'à un maximum de [StateArg3]%."
  },
  State_145436_Name = {
    Text = "Os de la Faim Immortelle"
  },
  State_145437_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : À l'équipement, obtient [StateArg2] charges de <EnergyStorageKeywords:Charge>, les Dommages d'«Attaque» augmentent de [StateArg1]% et sont convertis en <PVPPunctureDamagewords:Dégâts Perçants>."
  },
  State_145437_Name = {
    Text = "Ruine Céleste"
  },
  State_145456_Desc = {
    Text = "Lors de la sélection d'une cible, ignore la Provocation, la furtivité et le Verrouillage. Si plusieurs cibles remplissent les mêmes conditions, priorité au Corps éveillé en tête de liste."
  },
  State_145456_Name = {
    Text = "PV et Bouclier minimum"
  },
  State_145457_Desc = {
    Text = "Lors de la sélection d'une cible, ignore la Provocation, la furtivité et le Verrouillage. Si plusieurs cibles remplissent les mêmes conditions, priorité au Corps éveillé en tête de liste."
  },
  State_145457_Name = {
    Text = "PV et Bouclier maximum"
  },
  State_145495_Desc = {
    Text = "Cette Carte est jouée en double tir."
  },
  State_145495_Name = {
    Text = "<CardKeyWord:Double tir>"
  },
  State_145554_Desc = {
    Text = "Équipe Unique : Après le début de l'exploration, ajoute 1 carte <Falltospace1[StateArg3]:«Séjour Mortel»> au deck. «Séjour Mortel» : Consomme 0 Arithmetica. Inflige à tous les ennemis une <Corrosion:Corrosion> fixe équivalente à <WeaponEffect_Num:[StateArg1]%> de l'Attaque du Porteur et à <WeaponEffect_Num:[Float:StateArg4]%> de ses PV Max, attache <ErosionColorInkKeywords:Distorsion de Perception> aux Cartes d'instruction des autres Corps éveillés présents et Mélange 1 carte <Falltospace2[StateArg3]:«Descente Ascendante»> dans la Pioche. <RetainIconKeywords:Garder>. <DepleteIconKeywords:Consommer>."
  },
  State_145554_Name = {
    Text = "Descente Ascendante"
  },
  State_145554_WeaponDesc = {
    Text = "Après le début de l'exploration, ajoute 1 carte <Falltospace1[StateArg3]:«Séjour Mortel»> au deck. «Séjour Mortel» : Consomme 0 Arithmetica. Inflige à tous les ennemis une <Corrosion:Corrosion> fixe équivalente à <WeaponEffect_Num:[StateArg1]%> de l'Attaque du Porteur et à <WeaponEffect_Num:[Float:StateArg4]%> de ses PV Max, attache <ErosionColorInkKeywords:Distorsion de Perception> aux Cartes d'instruction des autres Corps éveillés présents et Mélange 1 carte <Falltospace2[StateArg3]:«Descente Ascendante»> dans la Pioche. <RetainIconKeywords:Garder>. <DepleteIconKeywords:Consommer>"
  },
  State_145572_Desc = {
    Text = "Au début de chaque tour, tous les autres Corps éveillés infligent <Damage:[Damage:Layer]> Dégâts Perçants."
  },
  State_145572_Name = {
    Text = "Tempête Dévoreuse de Cetus"
  },
  State_145590_Desc = {
    Text = "Lorsqu'une Carte identique de même appartenance est placée en main, l'Effet de Fusion se déclenche et cette Carte est consommée."
  },
  State_145590_Name = {
    Text = "<CardKeyWord:Fusion>"
  },
  State_145592_Desc = {
    Text = "Verrouille un ennemi et en fait la cible d'attaque prioritaire. Lors de la sélection d'une cible unique, seule la cible verrouillée peut être choisie. Ignore la Provocation et la dissimulation."
  },
  State_145592_Name = {
    Text = "<CardKeyWord:Verrouillage>"
  },
  State_145619_Name = {Text = "Corruption"},
  State_145620_Name = {Text = "Vide"},
  State_145621_Desc = {
    Text = "L'effet «Bénédiction» est réduit de 50%."
  },
  State_145621_Name = {
    Text = "<Bleesing_Exaggerate:Exagération>"
  },
  State_145622_Name = {Text = "Stagnation"},
  State_145623_Desc = {
    Text = "Inflige 1 effet négatif aléatoire à votre équipe :\n<Italic:2 tours de Symptôme : Affaiblir ; 2 tours de Fragile, 2 tours de Corruption ; charges de Poison égales à 1% des PV Max ; 2 charges de Vide ; 1 charge de Stase sur 2 cartes aléatoires en main ; ou génère 2 Cartes de symptômes Temporaires (qui ne persistent pas entre les combats) et les place au sommet de la Pioche.>"
  },
  State_145623_Name = {
    Text = "<Bleesing_Negative:Malveillance Voilée>"
  },
  State_145624_Name = {Text = "Faiblesse"},
  State_145625_Name = {
    Text = "2 «Cartes de symptômes» temporaires identiques"
  },
  State_145626_Name = {Text = "Fragile"},
  State_145627_Name = {Text = "Poison"},
  State_145628_Desc = {
    Text = "Obtient l'effet «Bénédiction» après 2 tours."
  },
  State_145628_Name = {
    Text = "<Bleesing_Delay:Occasion Manquée>"
  },
  State_145631_Desc = {
    Text = "Les Dommages d'«Attaque» augmentent de [StateArg1]% et sont convertis en <PVPPunctureDamagewords:Dégâts Perçants>."
  },
  State_145631_Name = {
    Text = "Ruine Céleste"
  },
  State_145632_Desc = {
    Text = "Cette carte provient de la Roue du Destin «Moment Propice»."
  },
  State_145632_Name = {
    Text = "Moment Propice"
  },
  State_145638_Desc = {
    Text = "Le Coût d'Arithmetica de cette Carte augmente de [Layer]."
  },
  State_145638_Name = {
    Text = "Salutation cruelle"
  },
  State_145642_Desc = {
    Text = "Tous les Éveilleurs obtiennent [StateArg1] points de Fureur après 2 tours, [Layer] fois."
  },
  State_145642_Name = {
    Text = "Fureur de latence"
  },
  State_145644_Desc = {
    Text = "Obtient <Posse:[StateArg1]> points de Fragment de clé après 2 tours, [Layer] fois."
  },
  State_145644_Name = {
    Text = "Fragment de clé en Latence"
  },
  State_145645_Desc = {
    Text = "Réduit temporairement la <ExhaustionIconKeywords:Force> de tous les ennemis de [StateArg1] points après 2 tours, [Layer] fois"
  },
  State_145645_Name = {
    Text = "Épuisement différé"
  },
  State_145646_Desc = {
    Text = "Obtient [StateArg1] points d'Arithmetica après 2 tours, [Layer] fois."
  },
  State_145646_Name = {
    Text = "Arithmetica de retard"
  },
  State_145647_Desc = {
    Text = "Obtient [StateArg1] points de <PowerIconKeywords:Force> après 2 tours, [Layer] fois."
  },
  State_145647_Name = {
    Text = "Force en Latence"
  },
  State_145648_Desc = {
    Text = "Pioche [StateArg1] carte(s) après 2 tours, [Layer] fois."
  },
  State_145648_Name = {
    Text = "Tirage retardé"
  },
  State_145649_Desc = {
    Text = "Amplification de Dégâts temporaire de [StateArg1]% après 2 tours, [Layer] fois."
  },
  State_145649_Name = {
    Text = "Latence Amplification de Dégâts Temporaire"
  },
  State_145652_Desc = {
    Text = "La consommation d'arithmetica de cette carte diminue de [Layer]."
  },
  State_145652_Name = {
    Text = "Liberté Insupportable"
  },
  State_145654_Desc = {
    Text = "Test. Après avoir été jouée, ou après avoir quitté la Main, Détruire."
  },
  State_145654_Name = {
    Text = "Test. Éphémère"
  },
  State_145660_Desc = {
    Text = "Allié\n1.<AllyPosAwaker1Name:> [DescArg1]\n2.<AllyPosAwaker2Name:> [DescArg2]\n3.<AllyPosAwaker3Name:> [DescArg3]\n4.<AllyPosAwaker4Name:> [DescArg4]\nEnnemi\n1.<EnemyPosAwaker1Name:> [DescArg5]\n2.<EnemyPosAwaker2Name:> [DescArg6]\n3.<EnemyPosAwaker3Name:> [DescArg7]\n4.<EnemyPosAwaker4Name:> [DescArg8]"
  },
  State_145660_Name = {
    Text = "Variation des PV après Réinitialisation"
  },
  State_145693_Desc = {
    Text = "Après la fin du tour, la consommation d'arsenal est de -[Layer], cet effet sera également déclenché après avoir été abandonné"
  },
  State_145693_Name = {
    Text = "<PrepareKeypvewordscolour:préparer[Layer]>"
  },
  State_145693_WeaponDesc = {
    Text = "Les cartes ne vont pas dans la pile de défausse pendant la phase de défausse, elles restent en main"
  },
  State_145694_Name = {
    Text = "Empathie avec le Marais Noir"
  },
  State_145698_Desc = {
    Text = "Attaque prioritaire sur la cible en <StatusApplier:> Verrouillage, lors de la sélection d'une cible unique, seules les cibles verrouillées peuvent être choisies, ignorant la Provocation et la dissimulation."
  },
  State_145698_Name = {
    Text = "Verrouillage"
  },
  State_145699_Desc = {
    Text = "·Attaque en priorité le <StatusApplier:> verrouillé. Lors de la sélection d'une cible unique, seule la cible verrouillée peut être choisie. Ignore la Provocation et la dissimulation.\n·Après sa propre mort, <StatusApplier:> obtient «<PVPDerivativeCardKeywords_32:Au combat !>»."
  },
  State_145699_Name = {
    Text = "Verrouillage"
  },
  State_145709_Desc = {
    Text = "Chaque charge augmente les PV Max de 10% de la Constitution de Caraboo (maximum 50 charges). Au maximum de charges, les charges excédentaires soignent plutôt 3× cette valeur de PV. Jusqu'à 10 charges de «Satiété» peuvent être obtenues par combat hors Boss. La «Satiété» persiste entre les combats."
  },
  State_145709_Name = {
    Text = "<WormGrowth:Repas>"
  },
  State_145710_Desc = {
    Text = "Vous faites partie de la Bénédiction~ ! Peut être consommé par l'Exaltation de Caraboo pour un bonus, jusqu'à 5 charges. Persiste entre les combats."
  },
  State_145710_Name = {
    Text = "<SacrificialMark:Sacrifice>"
  },
  State_145901_Desc = {
    Text = [=[
Notre camp
1.<AllyPosAwaker1Name:> [DescArg1]
2.<AllyPosAwaker2Name:> [DescArg2]
3.<AllyPosAwaker3Name:> [DescArg3]
4.<AllyPosAwaker4Name:> [DescArg4]]=]
  },
  State_145901_Name = {
    Text = "Variation des PV après Réinitialisation"
  },
  State_146041_Desc = {
    Text = "Ce Corps éveillé se sent détaché du tumulte du monde.\n·Impossible d'effectuer toute Action avant la fin du tour, réduit les Dommages de 99%, si la cible n'a pas de Résistance, elle en obtient une.\n·Impossible d'effectuer toute Action avant la fin du tour, réduit les Dommages de 99%, si la cible n'a pas de Résistance, elle en obtient une.\n·À la fin de l'Effet, inflige <Damage:[Layer]> Dommages passifs à tous les alliés.\n·Si la cible possède déjà une Résistance lors de l'application, la Duperie prend fin immédiatement et les Dommages infligés à la cible sont doublés."
  },
  State_146041_Name = {Text = "Embrouille"},
  State_146043_Desc = {
    Text = "Au début du prochain tour, déduit [Layer] Aliemus."
  },
  State_146043_Name = {
    Text = "Déduction d'Aliemus différée"
  },
  State_146058_Desc = {
    Text = "Variable de test, se rafraîchit après le début du tour ou après avoir joué une Carte. Devrait actuellement avoir [Layer]% d'efficacité d'ATQ."
  },
  State_146058_Name = {
    Text = "Efficacité d'ATQ du Décret Clé"
  },
  State_146059_Desc = {
    Text = "Variable de test, se rafraîchit après le début du tour ou après avoir joué une Carte. Devrait actuellement avoir [Layer]% d'efficacité de Défense."
  },
  State_146059_Name = {
    Text = "Efficacité de Défense du Décret Clé"
  },
  State_146079_Desc = {
    Text = "Cette Carte revient en Main après avoir quitté la Main."
  },
  State_146079_Name = {
    Text = "<Recycle:Retour en Main>"
  },
  State_146085_Desc = {
    Text = "Modifier l'Arithmetica de la Carte jouée ce tour"
  },
  State_146085_Name = {
    Text = "Modifier l'Arithmetica de la Carte jouée ce tour"
  },
  State_146085_WeaponDesc = {
    Text = "Changez le coût en arithmetica de la carte avant de la jouer"
  },
  State_146086_Desc = {
    Text = "Modifier l'Arithmetica de la Carte jouée ce tour"
  },
  State_146086_Name = {
    Text = "Modifier l'Arithmetica de la Carte jouée ce tour"
  },
  State_146086_WeaponDesc = {
    Text = "Changez le coût en arithmetica de la carte avant de la jouer"
  },
  State_146117_Desc = {
    Text = "Peut être consommé par «<DerivativeCardKeywords_157:Os de l'Épée>» pour obtenir un bonus. Cet état peut s'accumuler jusqu'à 15 couches."
  },
  State_146117_Name = {
    Text = "<Shimieluotanhuodong2:Volonté de combattre>"
  },
  State_146129_Desc = {
    Text = "Dégâts Finaux de tous les Corps éveillés +[Layer]%."
  },
  State_146129_Name = {
    Text = "Intention Meurtrière du Ciel-Baleine"
  },
  State_146147_Desc = {
    Text = "Peut être consommé par «<DerivativeCardKeywords_157:Os de l'Épée>» pour obtenir un bonus. Cet état peut s'accumuler jusqu'à 15 couches."
  },
  State_146147_Name = {
    Text = "<Shimieluotanhuodong1:Volonté de combattre>"
  },
  State_146154_Desc = {
    Text = "Fait se sentir bien ce Corps éveillé ; sa «Compétence» sera transformée en «Bénédiction ?», et après la transformation, un nombre équivalent de charges est consommé."
  },
  State_146154_Name = {
    Text = "<PVPBlessColour:Bénédiction>"
  },
  State_146155_Desc = {
    Text = "Ce Corps éveillé se sent bien.\n·Les [Layer] prochaines «Compétences» seront transformées en «Bénédiction ?», la transformation consomme un nombre équivalent de charges."
  },
  State_146155_Name = {
    Text = "Bénédiction"
  },
  State_146155_WeaponDesc = {Text = "Non"},
  State_146202_Desc = {
    Text = "Donne à ce Corps éveillé la sensation de s'être détaché du tumulte du monde.\nImpossible d'effectuer toute Action avant la fin du tour, réduit les Dommages de 99%. Si la cible ne possède pas de Résistance, elle en obtient une.\n·À la fin de l'Effet, inflige des Dommages passifs équivalents au nombre de charges à tous les alliés.\n·Si la cible possède déjà une Résistance au moment de l'application, la Duperie prend fin immédiatement et les Dommages infligés à la cible sont doublés."
  },
  State_146202_Name = {
    Text = "<CardKeyWord:Baratin>"
  },
  State_146352_Desc = {
    Text = "À chaque fois que vous subissez 1 Dommages, accumulez [StateArg1] couche(s) de <Shimieluotanhuodong1:Volonté de combattre>"
  },
  State_146352_Name = {Text = "Aguerri"},
  State_146363_Desc = {
    Text = "Au début du prochain tour, retire [Layer] PV. Lorsque des PV sont perdus, réduit d'autant les charges de cet État."
  },
  State_146363_Name = {
    Text = "Ce Qui N'est Point Mensonge"
  },
  State_146383_Desc = {
    Text = "Après l'ajout d'un état, après avoir joué une Carte, rafraîchit et affiche le Niveau de charge de la clé d'argent de chaque Corps éveillé."
  },
  State_146383_Name = {
    Text = "Entrée d'Efficacité"
  },
  State_146384_Desc = {
    Text = "Valeur P1 [StateArg1], Valeur P2 [StateArg2], Valeur P3 [StateArg3], Valeur P4 [StateArg4]."
  },
  State_146384_Name = {
    Text = "Valeur d'Efficacité"
  },
  State_146385_Desc = {
    Text = "Après l'ajout d'un état, après avoir joué une Carte, rafraîchit et affiche le Niveau de charge de la clé d'argent de chaque Corps éveillé."
  },
  State_146385_Name = {
    Text = "Entrée de Niveau"
  },
  State_146386_Desc = {
    Text = "Valeur P1 [StateArg1], Valeur P2 [StateArg2], Valeur P3 [StateArg3], Valeur P4 [StateArg4]."
  },
  State_146386_Name = {
    Text = "Valeur de Niveau"
  },
  State_146446_Desc = {
    Text = "Défense du Corps éveillé, P1 : [StateArg1], P2 : [StateArg2], P3 : [StateArg3], P4 : [StateArg4]."
  },
  State_146446_Name = {
    Text = "Liste des attributs de Défense"
  },
  State_146448_Desc = {
    Text = "ATQ du Corps éveillé, P1 : Force [StateArg1] Intensité [StateArg2], P2 : Force [StateArg3] Intensité [StateArg4], P3 : Force [StateArg5] Intensité [StateArg6], P4 : Force [StateArg7] Intensité [StateArg8]."
  },
  State_146448_Name = {
    Text = "Liste des attributs d'ATQ"
  },
  State_146452_Desc = {
    Text = "Équipe Unique : Les Dégâts Critiques de l'«Attaque» du Porteur augmentent de <WeaponEffect_Num:[StateArg1]%>. À la fin du tour, les Dégâts Critiques de la prochaine Exaltation du Porteur augmentent d'un pourcentage égal à <WeaponEffect_Num:[StateArg2]%> de sa Base Aliemus, cumulable jusqu'à 5 fois."
  },
  State_146452_WeaponDesc = {
    Text = "Les Dégâts Critiques d'«Attaque» du Porteur augmentent de <WeaponEffect_Num:[StateArg1]%>. À la fin du tour, les Dégâts Critiques de la prochaine Exaltation du Porteur augmentent de <WeaponEffect_Num:[DescArg1]%>, jusqu'à 5 fois maximum (actuellement [DescArg2]%)."
  },
  State_146456_Desc = {
    Text = "Équipe Unique : Les Dégâts Critiques de l'«Attaque» du Porteur augmentent de <WeaponEffect_Num:[StateArg1]%>."
  },
  State_146456_WeaponDesc = {
    Text = "Les Dégâts Critiques d'«Attaque» du Porteur augmentent de <WeaponEffect_Num:[StateArg1]%>."
  },
  State_146534_Desc = {
    Text = "Après le début du Niveau, ajoute les conteneurs de chaque mécanisme du Chaos Primordial au Gardien."
  },
  State_146534_Name = {
    Text = "Initialisation du Chaos Primordial"
  },
  State_146535_Desc = {
    Text = "Conteneur d'attributs."
  },
  State_146535_Name = {
    Text = "Identifiant du Chaos Primordial"
  },
  State_146536_Desc = {
    Text = "Conteneur de mécanisme."
  },
  State_146536_Name = {
    Text = "Mécanisme du Chaos Primordial"
  },
  State_146644_Desc = {
    Text = "Éveiller obtient Prépare 1, et lors de la première utilisation de chaque tour, libère automatiquement le Décret Clé porté."
  },
  State_146644_Name = {
    Text = "Écho Primordial"
  },
  State_146645_Desc = {
    Text = "Le nouveau Royaume du Chaos libère automatiquement le Décret Clé porté lors du premier Éveiller joué par tour. Actuellement disponible."
  },
  State_146645_Name = {
    Text = "Identifiant Disponible"
  },
  State_146646_Desc = {
    Text = "La limite maximale de base de Fragment de clé est modifiée à 2000. La règle d'obtention de Fragment de clé est remplacée par : la première fois que le Corps éveillé joue une Carte d'instruction par tour, il obtient un Fragment de clé égal à 3 fois la Régénération de Fragment de clé + 100."
  },
  State_146646_Name = {
    Text = "Nouvelle règle de Fragment de clé du Chaos"
  },
  State_146651_Desc = {
    Text = "Augmente l'attribut d'ATQ de ce Corps éveillé de [Layer]%."
  },
  State_146651_Name = {
    Text = "Chaos · Attaque"
  },
  State_146652_Desc = {
    Text = "Une seule fois après le début du combat, modifie l'efficacité de Régénération de Fragment de clé de chaque Corps éveillé pour la remplacer par la moyenne des Niveaux de charge de la clé d'argent."
  },
  State_146652_Name = {
    Text = "Équilibre Primordial"
  },
  State_146653_Desc = {
    Text = "Augmente l'attribut de Défense de ce Corps éveillé de [Layer]%."
  },
  State_146653_Name = {
    Text = "Chaos · Défense"
  },
  State_146663_Desc = {
    Text = "Les [Layer] prochaines «Attaque» de Lotan : Cétarque prennent effet 1 fois supplémentaire."
  },
  State_146663_Name = {
    Text = "Tempête Dévoreuse de Cetus"
  },
  State_147058_Name = {
    Text = "Anneau de la salle 36"
  },
  State_147079_Desc = {
    Text = "Cette carte ne peut pas être défaussée ou transformée."
  },
  State_147079_Name = {
    Text = "<RetainIconKeywordsColour:Garder forcé>"
  },
  State_147545_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Non configurée"
  },
  State_147545_Name = {
    Text = "Tinct : Vespera SR (Texte Temporaire)"
  },
  State_147546_Name = {Text = "Obsolète"},
  State_147546_WeaponDesc = {
    Text = "Voix hors du monde"
  },
  State_147584_Desc = {
    Text = "L'effet de <DerivativeCardKeywords_152:«Don des Fées»> de la prochaine <Blessing:Grâce> jouée est augmenté de 50%"
  },
  State_147737_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : À l'équipement, gagne [StateArg1] <MaxHPKeywords:PV Max>. Au début du tour, inflige <Damage:[Damage:StateArg2]> dégâts de <PVPBleedingKeywords:Saignement> à tous les ennemis,"
  },
  State_147737_Name = {
    Text = "Des ténèbres aux ténèbres"
  },
  State_147764_Name = {
    Text = "État@Compteur de mauvais choix de l'activité Caraboo"
  },
  State_147765_Desc = {
    Text = "Au début du prochain tour, perdez 2 points d'Arithmetica et piochez 2 cartes de moins."
  },
  State_147765_Name = {
    Text = "Pistoles de Marie"
  },
  State_147768_Desc = {
    Text = "Au début du prochain tour, obtenez [DescArg1] Inspiration(s) avancée(s)."
  },
  State_147768_Name = {
    Text = "Pièces d'or de Pistoles de Marie"
  },
  State_147769_Desc = {
    Text = "Durant ce combat, «Repas» a actuellement [Layer] charge(s) accumulée(s)."
  },
  State_147769_Name = {
    Text = "Limite de Charges"
  },
  State_147772_Name = {
    Text = "État@Activité Caraboo ajoute limite temporaire de Fragment de clé"
  },
  State_147773_Name = {
    Text = "État@Activité Caraboo ajoute limite temporaire de Fragment de clé"
  },
  State_147774_Name = {
    Text = "État@Activité Caraboo ajoute limite temporaire de Fragment de clé_Chaos ordinaire"
  },
  State_147797_Desc = {
    Text = "Peut gagner ou perdre de la Fureur, de la <PowerIconKeywords:Force>, des PV, des Fragments de clé et de l'Arithmetica ainsi que piocher des cartes."
  },
  State_147797_Name = {
    Text = "Pistoles de Marie"
  },
  State_147800_Desc = {
    Text = "Au début du prochain tour, perdez 2 points d'Arithmetica et piochez 2 cartes de moins."
  },
  State_147800_Name = {
    Text = "Pistoles de Marie"
  },
  State_147869_Name = {
    Text = "Piochez [Layer] cartes"
  },
  State_147870_Name = {
    Text = "Inflige [Layer] tours de faiblesse à tous les ennemis"
  },
  State_147871_Name = {
    Text = "Obtenir [Energy:DescArg1] points de folie"
  },
  State_147872_Name = {
    Text = "Infligez [Layer] tours de vulnérabilité aux ennemis"
  },
  State_147873_Name = {
    Text = "Obtenez [Layer] arithmetica"
  },
  State_147874_Name = {
    Text = "Obtenir [Block:DescArg1] bouclier"
  },
  State_147962_Desc = {
    Text = "Lorsque le joueur joue «<DerivativeCardKeywords_158:Expiation>», cela ne dissipe que 50% des charges de <MonsterSinMarkKeywords:Marque de péché>, et pour chaque Carte d'instruction jouée, «Fils Saint · Nuit Blanche» gagne 1 charge de <MonsterSinMarkKeywords:Marque de péché>."
  },
  State_147962_Name = {
    Text = "Chemin de purification"
  },
  State_147967_Desc = {
    Text = "Les dégâts infligés par « Divus : La Nuit Blanche » appliquent [DescArg1]% de <BleedingIconKeywords:Saignement>."
  },
  State_147967_Name = {
    Text = "Marque de péché"
  },
  State_147968_Desc = {
    Text = "Limite de 3 couches. Lorsque l'intention bascule vers Attaque, le Boost de DGT de « Divus : La Nuit Blanche » augmente de 25% et consomme 1 couche."
  },
  State_147968_Name = {
    Text = "Rédemption de la douleur"
  },
  State_147969_Desc = {
    Text = "Lorsque « Divus : La Nuit Blanche » est en intention « Cœur Sacré », chaque Carte d'instruction jouée accumule 2 couches de <MonsterPolluxFever:Ferveur>."
  },
  State_147969_Name = {
    Text = "Nouvelle Alliance divine"
  },
  State_147971_Desc = {
    Text = "Cet Éveilleur n'a pas encore été Réveillé... Lorsqu'il est sur le point d'être vaincu, ses PV sont restaurés et il gagne 1 charge de <InvincibleUntilRoused:Blindage Impénétrable>. Après le Réveil, le <InvincibleUntilRoused:Blindage Impénétrable> est retiré et il commence le combat sous sa véritable forme."
  },
  State_147971_Name = {
    Text = "Non Réveillé"
  },
  State_147972_Desc = {
    Text = "Chaque couche fait en sorte que les dégâts infligés par « Divus : La Nuit Blanche » appliquent 1% de <BleedingIconKeywords:Saignement>."
  },
  State_147972_Name = {
    Text = "<MonsterSinMarkKeywords:Marque de péché>"
  },
  State_147974_Desc = {
    Text = "Supprimé au début du tour. Une fois 10 couches atteintes, agit immédiatement après la prochaine carte jouée, retire la Ferveur et bascule l'intention vers « Cœur Sacré »."
  },
  State_147974_Name = {Text = "Ferveur"},
  State_147975_Desc = {
    Text = "Au début du combat, placez une carte « <DerivativeCardKeywords_158:Expiation> » dans votre Main. À la fin du tour, obtenez 5 couches de <MonsterSinMarkKeywords:Marque de péché>."
  },
  State_147975_Name = {
    Text = "Messager du Porteur de Lampe"
  },
  State_147993_Desc = {
    Text = "Limite de 3 couches. Lorsque l'intention bascule vers Attaque, le Boost de DGT de « Divus : La Nuit Blanche » augmente de 25% et consomme 1 couche."
  },
  State_147993_Name = {
    Text = "Rédemption de la douleur"
  },
  State_148020_Desc = {
    Text = "Immunité à tous les dégâts et ne peut pas perdre de PV, retiré après l'Éveil."
  },
  State_148020_Name = {
    Text = "Solidification du Noyau d'Argent"
  },
  State_148021_Name = {
    Text = "État@Identifiant de suppression d'immunité avant résurrection et éveil commun aux monstres"
  },
  State_148073_Name = {
    Text = "Pioche 1 carte"
  },
  State_148074_Desc = {
    Text = "Les cartes ne vont pas dans la pile de défausse pendant la phase de défausse, elles restent en main"
  },
  State_148074_Name = {
    Text = "<RetainIconKeywords:Conservation>"
  },
  State_148074_WeaponDesc = {
    Text = "Les cartes ne vont pas dans la pile de défausse pendant la phase de défausse, elles restent en main"
  },
  State_148076_Name = {
    Text = "Écoute de jeu de cartes du Chemin de purification"
  },
  State_148116_Desc = {
    Text = "Après 1 tour, piocher [StateArg1] carte(s) [Layer] fois."
  },
  State_148116_Name = {
    Text = "Tirage retardé 1"
  },
  State_148381_Desc = {
    Text = "Jusqu'à la fin du tour, les dégâts infligés appliquent 100% de <BleedingIconKeywords:Saignement>."
  },
  State_148381_Name = {
    Text = "Rancœur enchaînée"
  },
  State_148383_Desc = {
    Text = "Maximum 3 charges. Si 3 charges de «Tueur infini» sont détenues, la prochaine fois que l'Intention passe à «Chaîne de sang», l'Intention passe à «Boule de sang» et «Tueur infini» est effacé à la place."
  },
  State_148383_Name = {
    Text = "«Ressentiment»"
  },
  State_148385_Desc = {
    Text = "Chaque fois que l'ennemi joue une Carte d'instruction, obtenez 2 couches de <MonsterB05EXFever:Ferveur Temporaire>."
  },
  State_148385_Name = {
    Text = "forme irrégulière"
  },
  State_148386_Desc = {
    Text = "Impossible d'obtenir un Bouclier jusqu'à la fin du tour."
  },
  State_148386_Name = {
    Text = "Chaînes de restriction"
  },
  State_148387_Desc = {
    Text = "Cet Éveilleur n'a pas encore été Réveillé... Lorsqu'il est sur le point d'être vaincu, ses PV sont restaurés et il gagne 1 charge de <InvincibleUntilRoused:Blindage Impénétrable>. Après le Réveil, le <InvincibleUntilRoused:Blindage Impénétrable> est retiré et il commence le combat sous sa véritable forme."
  },
  State_148387_Name = {
    Text = "Non Réveillé"
  },
  State_148391_Desc = {
    Text = "Jusqu'à la fin du tour, les dégâts infligés appliquent 100% de <BleedingIconKeywords:Saignement>."
  },
  State_148391_Name = {
    Text = "Chaînes de restriction"
  },
  State_148392_Desc = {
    Text = "Supprimé au début du tour. Une fois 10 couches atteintes, agit immédiatement après la prochaine carte jouée, retire la Ferveur et bascule l'intention vers « Chaîne de sang »."
  },
  State_148392_Name = {Text = "Ferveur"},
  State_148394_Desc = {
    Text = "Au début du tour, gagne 1 charge de <ResentChainsKeywords:Chaîne de Rancœur>. Lors du changement d'intention vers «Boule de sang», immunité à tous les dégâts et aux effets de perte de PV jusqu'à la fin du tour ennemi."
  },
  State_148394_Name = {
    Text = "Déclaration du Récupérateur d'âmes"
  },
  State_148395_Desc = {
    Text = "Immunité à tous les dégâts (y compris les Dégâts Perçants) et impossible de perdre des PV. Supprimé à la fin du tour ennemi."
  },
  State_148395_Name = {
    Text = "Déclaration du Récupérateur d'âmes – Boule de sang"
  },
  State_148421_Desc = {
    Text = "Après 1 tour, réduit temporairement la <ExhaustionIconKeywords:Force> de tous les ennemis de [StateArg1] points [Layer] fois"
  },
  State_148421_Name = {
    Text = "Latence Drainer 1"
  },
  State_148422_Desc = {
    Text = "Après 1 tour, Amplification de Dégâts temporaire de [StateArg1]% [Layer] fois."
  },
  State_148422_Name = {
    Text = "Amplification de Dégâts Temporaire Retardée 1"
  },
  State_148423_Desc = {
    Text = "Obtient <Posse:[StateArg1]> points de Fragment de clé après 1 tour, [Layer] fois."
  },
  State_148423_Name = {
    Text = "Latence Fragment de clé 1"
  },
  State_148426_Desc = {
    Text = "Obtient [StateArg1] points d'Arithmetica après 1 tour, [Layer] fois."
  },
  State_148426_Name = {
    Text = "Latence Arithmetica 1"
  },
  State_148427_Desc = {
    Text = "Après 1 tour, tous les Éveilleurs gagnent [StateArg1] points de Fureur [Layer] fois."
  },
  State_148427_Name = {
    Text = "Fureur de latence 1"
  },
  State_148428_Desc = {
    Text = "Obtient [StateArg1] points de <PowerIconKeywords:Force> après 1 tour, [Layer] fois."
  },
  State_148428_Name = {
    Text = "Latence Force 1"
  },
  State_148511_Desc = {
    Text = "Équipe Unique : Après le début de l'exploration, ajoute 1 carte <Backupbody[StateArg3]:«Synchronisation des Âmes»> au deck. «Synchronisation des Âmes» : Coût d'Arithmetica 0, après avoir joué cette carte, gagne 1 point d'Arithmetica. <RetainIconKeywords:Garder> : Accumule dans cette carte une quantité fixe de récupération de PV égale à <WeaponEffect_Num:[StateArg1]%> de la Constitution du Porteur et <WeaponEffect_Num:[StateArg2]> points fixes de Fureur. Si cette carte n'est pas détruite, permet d'être immunisé une fois à la mort et libère toute la récupération de PV et la Fureur accumulées, puis <DestructionKeywords:Détruire> cette carte."
  },
  State_148511_Name = {
    Text = "Synchronisation des Âmes"
  },
  State_148511_WeaponDesc = {
    Text = "Après le début de l'exploration, ajoute 1 carte <Backupbody[StateArg3]:«Synchronisation des Âmes»> au deck. «Synchronisation des Âmes» : Coût d'Arithmetica 0, après avoir joué cette carte, gagne 1 point d'Arithmetica. <RetainIconKeywords:Garder> : Accumule dans cette carte une quantité fixe de récupération de PV égale à <WeaponEffect_Num:[StateArg1]%> de la Constitution du Porteur et <WeaponEffect_Num:[StateArg2]> points fixes de Fureur. Si cette carte n'est pas détruite, permet d'être immunisé une fois à la mort et libère toute la récupération de PV et la Fureur accumulées, puis <DestructionKeywords:Détruire> cette carte."
  },
  State_148513_Desc = {
    Text = "L'adversaire ne défaussera pas sa main à la fin de son tour. À la fin du tour, appliquez 2 charges de <FragileIconKeywords:fragilité>, <WeaknessIconKeywords:faiblesse>, <HeavyInjuryKeywords:blessure grave>, et <VulnerabilityIconKeywords:vulnérable> dans cet ordre."
  },
  State_148513_Name = {
    Text = "Voix hors du monde"
  },
  State_148520_Desc = {
    Text = "Impossible d'obtenir un Bouclier jusqu'à la fin du tour."
  },
  State_148520_Name = {
    Text = "Rancœur enchaînée"
  },
  State_148522_Desc = {
    Text = "Équipe Unique : Le Bouclier et la puissance de l'«Exaltation» du Porteur augmentent de <WeaponEffect_Num:[StateArg1]%>."
  },
  State_148524_Desc = {
    Text = "Équipe Unique : Le Bouclier et la puissance de l'«Exaltation» du Porteur augmentent de <WeaponEffect_Num:[StateArg1]%>. Le Bonus de Bouclier de la «Défense» du Porteur augmente de <WeaponEffect_Num:[StateArg2]%>. Après que le Porteur joue «Défense», gagne une puissance égale à <WeaponEffect_Num:[StateArg3]%> de l'Attaque du Porteur."
  },
  State_148540_Desc = {
    Text = "Latence[Layer] : Le Coût d'Arithmetica des [StateArg1] Cartes d'instruction à l'Arithmetica la plus élevée de <AwakerName:[DescArg1]> est réduit de [StateArg2]."
  },
  State_148540_Name = {
    Text = "Miroir de Prescience – Latence[Layer]"
  },
  State_148541_Name = {
    Text = "Retirer l'effet «Stase» de la carte en main de l'Éveilleur sélectionné"
  },
  State_148544_Desc = {
    Text = "Latence[Layer] : La prochaine Exaltation de <AwakerName:[DescArg1]> lui fait gagner [StateArg1] points de Fragment de clé pour chaque point de Fureur consommé."
  },
  State_148544_Name = {
    Text = "Clé de Goétie - Latence[Layer]"
  },
  State_148547_Desc = {
    Text = "La prochaine Exaltation de <AwakerName:[DescArg1]> est considérée comme une Sur-Exaltation ; si elle l'est déjà, restitue 100% du Base Aliemus."
  },
  State_148547_Name = {
    Text = "Couronne d'Éternité"
  },
  State_148548_Desc = {
    Text = "Garder : Tous les Éveilleurs gagnent 5 Fureur."
  },
  State_148548_Name = {
    Text = "Absorbé dans la Réflexion"
  },
  State_148549_Name = {
    Text = "Déclenche tous les effets «Prépare» en main"
  },
  State_148553_Desc = {
    Text = "Latence[Layer] : Les [Layer] prochaines Cartes d'instruction jouées par <AwakerName:[DescArg1]> obtiennent un Bouclier égal à [StateArg2]% des PV perdus."
  },
  State_148553_Name = {
    Text = "Fruit de la Tentation – Latence[Layer]"
  },
  State_148554_Desc = {
    Text = "Les dégâts infligés par les Cartes d'instruction de <AwakerName:[DescArg1]> appliquent [Layer]% de Saignement."
  },
  State_148554_Name = {
    Text = "Œil de Ruine"
  },
  State_148556_Desc = {
    Text = "Tant qu'en main, tous les Éveilleurs infligent 10% de Saignement supplémentaire lors de Dégâts Directs."
  },
  State_148556_Name = {
    Text = "Un Cauchemar Annoncé"
  },
  State_148557_Desc = {
    Text = "Les [Layer] prochaines Cartes d'instruction jouées par <AwakerName:[DescArg1]> obtiennent un Bouclier égal à [StateArg1]% des PV perdus."
  },
  State_148557_Name = {
    Text = "Fruit de la Tentation"
  },
  State_148559_Desc = {
    Text = "La prochaine Exaltation de <AwakerName:[DescArg1]> lui fait gagner [Layer] points de Fragment de clé pour chaque point de Fureur consommé."
  },
  State_148559_Name = {
    Text = "Clé de Goétie"
  },
  State_148561_Desc = {
    Text = "Lorsque cette Carte est jouée, déclenche aléatoirement l'un des trois effets négatifs suivants : Effet réduit de 50% / Latence de 2 tours avant activation / Obtient aléatoirement 1 effet négatif."
  },
  State_148561_Name = {
    Text = "<ExclamationPointColour:Souhait Tordu>"
  },
  State_148562_Name = {
    Text = "L'Éveilleur sélectionné obtient 10 points de Fureur"
  },
  State_148563_Desc = {
    Text = "Latence[Layer] : Le Bouclier et la récupération de PV obtenus lors de la prochaine Exaltation de <AwakerName:[DescArg1]> sont augmentés de [StateArg1]%."
  },
  State_148563_Name = {
    Text = "Plume de Justice – Latence[Layer]"
  },
  State_148566_Desc = {
    Text = "Les dégâts de la prochaine Exaltation de <AwakerName:[DescArg1]> appliquent [Layer]% de Verdict final."
  },
  State_148566_Name = {
    Text = "Fil du Destin"
  },
  State_148569_Desc = {
    Text = "Le Bouclier et la récupération de PV obtenus lors de la prochaine Exaltation de <AwakerName:[DescArg1]> sont augmentés de [Layer]%."
  },
  State_148569_Name = {
    Text = "Plume de Justice"
  },
  State_148571_Desc = {
    Text = "Latence[Layer] : Les dégâts infligés par les Cartes d'instruction de <AwakerName:[DescArg1]> appliquent [StateArg1]% de Saignement."
  },
  State_148571_Name = {
    Text = "Œil de Ruine - Latence[Layer]"
  },
  State_148574_Desc = {
    Text = "Latence[Layer] : Les dégâts de la prochaine Exaltation de <AwakerName:[DescArg1]> appliquent [StateArg1]% de Verdict final."
  },
  State_148574_Name = {
    Text = "Fil du Destin - Latence[Layer]"
  },
  State_148575_Name = {
    Text = "L'Éveilleur sélectionné obtient 20 points de Fureur"
  },
  State_149089_Name = {
    Text = "État@Identifiant Fureur dévorée du Chien-Lanterne"
  },
  State_149092_Desc = {
    Text = "A dévoré <Energy:[Energy:DescArg2]> points de Fureur de «<AwakerName:[DescArg1]>». Restitués à la mort."
  },
  State_149092_Name = {Text = "Dévorer"},
  State_149094_Desc = {
    Text = "Équipe Unique : Le Bouclier de base généré par l'Exaltation du Porteur +<WeaponEffect_Num:[StateArg1]%>. Après que le Porteur joue une Carte d'instruction infligeant le Symptôme : Affaiblir, le Bouclier de base généré par la prochaine Carte d'instruction d'équipement +<WeaknessIconKeywords:[StateArg1]%>. Ne peut pas se cumuler. Lors de l'utilisation de « Forge Écarlate », piochez la carte de compétence du Porteur avec le Coût d'Arithmetica le plus élevé, Fusion d'Embryon +<WeaponEffect_Num:[StateArg1]%>, temps de recharge de 3 tours.<EmbryoFusionIconKeywords:><WeaponEffect_Num:>"
  },
  State_149094_WeaponDesc = {
    Text = "Le Bouclier de base d'Exaltation du Porteur +<WeaponEffect_Num:[StateArg1]%>. Après que le Porteur joue une Carte d'instruction qui inflige <WeaknessIconKeywords:Symptôme : Affaiblir>, le Bouclier de base de sa Carte d'instruction +<WeaponEffect_Num:[StateArg1]%>. Lors de l'utilisation de « Forge Écarlate », piochez la Carte de compétence du Porteur avec le Coût d'Arithmetica le plus élevé, <EmbryoFusionIconKeywords:Fusion d'Embryon> +<WeaponEffect_Num: [StateArg1]>, temps de recharge de 3 tours."
  },
  State_149122_Desc = {
    Text = "À la mort, invoque immédiatement 1 «Chien-Lanterne» aléatoire dont l'«Effet de groupe» est réduit de 1 charge."
  },
  State_149122_Name = {
    Text = "Effet de groupe"
  },
  State_149123_Desc = {
    Text = "Les dégâts reçus de l'Exaltation sont réduits de 50%."
  },
  State_149123_Name = {
    Text = "Mod Lanterne Ombrelle"
  },
  State_149124_Desc = {
    Text = "Les dégâts reçus des Cartes d'instruction sont réduits de 50%."
  },
  State_149124_Name = {
    Text = "Mod Lanterne Glaciale"
  },
  State_149125_Desc = {
    Text = "A gelé la Carte d'instruction de «<AwakerName:[DescArg1]>». À la mort, annule le gel de cet Éveilleur."
  },
  State_149125_Name = {Text = "Dévorer"},
  State_149126_Desc = {
    Text = "À la mort, invoque immédiatement 1 «Chien-Lanterne» aléatoire dont l'«Effet de groupe» est réduit de 1 charge."
  },
  State_149126_Name = {
    Text = "Effet de groupe"
  },
  State_149128_Name = {
    Text = "État@Identifiant Carte gelée du Chien-Lanterne des neiges"
  },
  State_149140_Desc = {
    Text = "Augmente les compétences de l'ennemi. Perd une couche à chaque fois qu'il subit des dégâts"
  },
  State_149140_Name = {
    Text = "Serment de sang"
  },
  State_149143_Desc = {
    Text = "Après la phase de Pioche, pour chaque [DescArg1] Carte d'instruction de <SlowIconKeywords:Stagnation> dans la main ennemie, gagne [DescArg2] charges de <BloodOath_New:Serment de sang>. Après avoir infligé des dégâts non bloqués, applique [DescArg4] charges de <SlowIconKeywords:Stagnation> à [DescArg3] Cartes d'instruction non affectées par <SlowIconKeywords:Stagnation> dans la Main ou la Pioche, choisies aléatoirement."
  },
  State_149143_Name = {Text = "Vœu Gelé"},
  State_149162_Desc = {
    Text = "Lors d'une attaque infligeant des dégâts non bloqués, retire la Résistance à la mort."
  },
  State_149162_Name = {
    Text = "Magie Noire d'Extrême-Orient"
  },
  State_149163_Desc = {
    Text = "Réduit les PV Max d'un montant égal au nombre de charges. Divisé par deux à la fin du combat."
  },
  State_149163_Name = {
    Text = "<BoneHitKeywords:Scathe>"
  },
  State_149164_Desc = {
    Text = "Applique Scathe lors de l'infliction de dégâts."
  },
  State_149164_Name = {
    Text = "Froid Perçant"
  },
  State_149167_Desc = {
    Text = "PV Max réduits de [Layer], réduits de moitié à la fin du combat."
  },
  State_149167_Name = {
    Text = "<BoneHitKeywords:Scathe>"
  },
  State_149169_Desc = {
    Text = "Chaque charge augmente les PV Max de 10% de la Constitution de Caraboo (maximum 50 charges). Au maximum de charges, les charges excédentaires soignent plutôt 3× cette valeur de PV. Jusqu'à 10 charges de «Satiété» peuvent être obtenues par combat hors Boss. La «Satiété» persiste entre les combats."
  },
  State_149169_Name = {
    Text = "<WormGrowth:Repas>"
  },
  State_149172_Desc = {
    Text = "Équipe Unique : Après que le Porteur joue une Carte d'instruction qui inflige <WeaknessIconKeywords:Symptôme : Affaiblir>, le Bouclier de base généré par la prochaine Carte d'instruction d'équipement +<WeaponEffect_Num:[StateArg1]%>. Ne peut pas se cumuler."
  },
  State_149172_WeaponDesc = {
    Text = "Après que le Porteur joue une Carte d'instruction qui inflige <WeaknessIconKeywords:Symptôme : Affaiblir>, le Bouclier de base de sa prochaine Carte d'instruction +<WeaponEffect_Num:[StateArg1]%>."
  },
  State_149187_Desc = {
    Text = "Test | Écoute après réception de Dégâts Fixes, après une Élimination causée par des Dégâts Fixes, et affiche la valeur de déclenchement ainsi que les associés."
  },
  State_149187_Name = {
    Text = "Test Dégâts Fixes"
  },
  State_149188_Desc = {
    Text = "Test｜Après qu'un Dégât Fixe cause une Élimination, déclenche la valeur 1, dégâts réels de l'Élimination : [Layer]"
  },
  State_149188_Name = {
    Text = "Test Valeur Déclenchement 2 Élimination par Dégâts Fixes"
  },
  State_149189_Desc = {
    Text = "Test | Après une Élimination causée par des Dégâts Fixes, Associé 2, source de l'Élimination : [Layer]"
  },
  State_149189_Name = {
    Text = "Test Associé 2 Élimination par Dégâts Fixes"
  },
  State_149190_Desc = {
    Text = "Test｜Après qu'un Dégât Fixe cause une Élimination, déclenche la valeur 1, dégâts de débordement de l'Élimination : [Layer]"
  },
  State_149190_Name = {
    Text = "Test déclenchement valeur 3 par Dégâts Fixes et Élimination"
  },
  State_149191_Desc = {
    Text = "Test | Après réception de Dégâts Fixes, Valeur de déclenchement 1, dégâts totaux : [Layer]"
  },
  State_149191_Name = {
    Text = "Test Valeur Déclenchement 1 Dégâts Fixes"
  },
  State_149192_Desc = {
    Text = "Test | Après une Élimination causée par des Dégâts Fixes, Associé 1, cible éliminée : [Layer]"
  },
  State_149192_Name = {
    Text = "Test Associé 1 Élimination par Dégâts Fixes"
  },
  State_149193_Desc = {
    Text = "Test | Après réception de Dégâts Fixes, Associé 2, cible touchée : [Layer]"
  },
  State_149193_Name = {
    Text = "Test Associé 2 Dégâts Fixes"
  },
  State_149194_Desc = {
    Text = "Test | Après réception de Dégâts Fixes, Valeur de déclenchement 1, dégâts totaux : [Layer]"
  },
  State_149194_Name = {
    Text = "Test Valeur Déclenchement 2 Dégâts Fixes"
  },
  State_149195_Desc = {
    Text = "Test | Après une Élimination causée par des Dégâts Fixes, Valeur de déclenchement 1, dégâts totaux de l'Élimination : [Layer]"
  },
  State_149195_Name = {
    Text = "Test Valeur Déclenchement 1 Élimination par Dégâts Fixes"
  },
  State_149196_Desc = {
    Text = "Test | Après réception de Dégâts Fixes, Associé 1, source des dégâts : [Layer]"
  },
  State_149196_Name = {
    Text = "Test Associé 1 Dégâts Fixes"
  },
  State_149227_Desc = {
    Text = "Le Bouclier ne disparaît pas en fin de tour. Lorsqu'un Bouclier est actif, le Bonus DGT d'Exaltation reçu augmente de 50% et les dégâts des Cartes d'instruction reçus diminuent de 50%."
  },
  State_149227_Name = {
    Text = "Manteau Glacial"
  },
  State_149228_Desc = {
    Text = "Applique Saignement lors de l'infliction de dégâts."
  },
  State_149228_Name = {
    Text = "Percée Sanglante"
  },
  State_149229_Desc = {
    Text = "À l'entrée en jeu, perd 25% des PV Max, convertis en «Bouclier de Givre» égal à [DescArg1]% de la valeur perdue."
  },
  State_149229_Name = {
    Text = "Conversion en Bouclier de Givre"
  },
  State_149230_Desc = {
    Text = "Les dégâts des Cartes d'instruction reçus augmentent de 50%, le Bonus DGT d'Exaltation reçu diminue de 50%."
  },
  State_149230_Name = {
    Text = "État@Augmentation/Réduction des dégâts du Manteau Ombral"
  },
  State_149232_Desc = {
    Text = "Le Bouclier ne disparaît pas en fin de tour. Lorsqu'un Bouclier est actif, les dégâts des Cartes d'instruction reçus augmentent de 50% et le Bonus DGT d'Exaltation reçu diminue de 50%."
  },
  State_149232_Name = {
    Text = "Manteau Ombral"
  },
  State_149233_Desc = {
    Text = "Le Bonus DGT d'Exaltation reçu augmente de 50%, les dégâts des Cartes d'instruction reçus diminuent de 50%."
  },
  State_149233_Name = {
    Text = "État@Augmentation/Réduction des dégâts du Manteau Glacial"
  },
  State_149234_Desc = {
    Text = "À l'entrée en jeu, perd 25% des PV Max, convertis en «Garde Maudite» égale à [DescArg1]% de la valeur perdue."
  },
  State_149234_Name = {
    Text = "Conversion en Garde Maudite"
  },
  State_149235_Desc = {
    Text = "Lors d'une attaque infligeant des dégâts non bloqués, retire la Résistance à la mort."
  },
  State_149235_Name = {
    Text = "Sorcellerie de Lanterne"
  },
  State_149250_Desc = {
    Text = "Dégâts de Carte d'instruction subis +50%"
  },
  State_149250_Name = {
    Text = "Dégâts de Carte d'instruction subis +50%"
  },
  State_149251_Desc = {
    Text = "Dégâts de Carte d'instruction subis -50%"
  },
  State_149251_Name = {
    Text = "Dégâts de Carte d'instruction subis -50%"
  },
  State_149252_Desc = {
    Text = "Dégâts d'Exaltation reçus -50%"
  },
  State_149252_Name = {
    Text = "Dégâts d'Exaltation reçus -50%"
  },
  State_149253_Desc = {
    Text = "Dégâts d'Exaltation reçus +50%"
  },
  State_149253_Name = {
    Text = "Dégâts d'Exaltation reçus +50%"
  },
  State_149265_Desc = {
    Text = "Après la mort, invoque immédiatement un «Wendigo» aléatoire et réduit son «Effet de groupe» de 1 couche."
  },
  State_149265_Name = {
    Text = "Effet de groupe"
  },
  State_149268_Desc = {
    Text = "Lorsque tous les Boucliers sont perdus, obtient 75 couches de Forteresse Temporaire et retire 1 couche de «Linceul de Blizzard», remplace l'intention par une attaque puissante qui inflige <BoneHitKeywords:Scathe>."
  },
  State_149268_Name = {
    Text = "Linceul de Blizzard"
  },
  State_149269_Desc = {
    Text = "Lorsque tous les Boucliers sont perdus, obtient 75 couches de Forteresse Temporaire et retire 1 couche de «Linceul d'Ombre», remplace l'intention par une attaque puissante qui dérobe la Fureur."
  },
  State_149269_Name = {
    Text = "Linceul d'Ombre"
  },
  State_149270_Desc = {
    Text = "Après la mort, invoque immédiatement un «Wendigo» aléatoire et réduit son «Effet de groupe» de 1 couche."
  },
  State_149270_Name = {
    Text = "Effet de groupe"
  },
  State_149308_Name = {
    Text = "État@Enregistrement des charges de Stagnation du Prieur-Lanterne"
  },
  State_149391_Desc = {
    Text = "Cet Éveilleur n'a pas encore été Réveillé... Lorsqu'il est sur le point d'être vaincu, ses PV sont restaurés et il gagne 1 charge de <InvincibleUntilRoused:Blindage Impénétrable>. Après le Réveil, le <InvincibleUntilRoused:Blindage Impénétrable> est retiré et il commence le combat sous sa véritable forme."
  },
  State_149391_Name = {
    Text = "Non Réveillé"
  },
  State_149398_Desc = {
    Text = "Lorsque l'intention de «Blanche-Neige la Fée» passe à «Sortilège Neigeux», consomme 1 couche et transforme l'intention en «Bénédiction Miraculeuse»."
  },
  State_149398_Name = {Text = "Repas"},
  State_149399_Desc = {
    Text = "Après que «Blanche-Neige la Fée» utilise «Conte de Fées Parfait», ses [DescArg1] prochaines intentions sont toutes «Sortilège Neigeux». Chaque tour, Mélanger [DescArg2] «<Blessing:Bénédiction>» aléatoires possédant [DescArg3] couches de <SlowIconKeywords:Stagnation> dans la pioche."
  },
  State_149399_Name = {
    Text = "Fruit de Miel Tentateur"
  },
  State_149418_Desc = {
    Text = "ne peut pas faire de Critique, n'est pas considéré comme des Dommage de base et n'est pas affecté par les bonus tels que les Dégâts Finaux."
  },
  State_149418_Name = {
    Text = "<RealDamage:dégâts fixes>"
  },
  State_149419_Name = {
    Text = "<Rune_6:Mur de fer>"
  },
  State_149420_Name = {
    Text = "<Rune_3:Habileté>"
  },
  State_149421_Name = {
    Text = "<Rune_15:Explosion>"
  },
  State_149422_Name = {
    Text = "<Rune_4:Calcul>"
  },
  State_149423_Name = {
    Text = "<Rune_11:Domination>"
  },
  State_149424_Name = {
    Text = "<Rune_12:Sanguinaire>"
  },
  State_149425_Name = {
    Text = "<Rune_1:vulnérable>"
  },
  State_149426_Name = {
    Text = "<Rune_14:Force brute>"
  },
  State_149427_Name = {
    Text = "<Rune_2:Faiblesse>"
  },
  State_149428_Name = {
    Text = "<Rune_9:pique>"
  },
  State_149429_Name = {
    Text = "<Rune_10:Toxine>"
  },
  State_149430_Name = {
    Text = "<Rune_18:Épuisement>"
  },
  State_149576_Desc = {
    Text = "Lorsque l'intention de «Blanche-Neige la Fée» passe à «Sortilège Neigeux», consomme 1 couche et transforme l'intention en «Bénédiction Miraculeuse»."
  },
  State_149576_Name = {Text = "Repas"},
  State_149618_Desc = {
    Text = "Après 2 tours, déclenche les effets suivants :\nGagne [DescArg1] points d'Arithmetica. \nGagne [DescArg2] points de Force. \nGagne [DescArg3] points de Fragment de clé. \nGagne [DescArg5] points de Fureur. \nPiocher [DescArg6] carte(s).\nGagne [DescArg7] points d'Amplification de Dégâts temporaire.\nRéduit temporairement la Force de tous les ennemis de [DescArg4] points."
  },
  State_149618_Name = {
    Text = "Occasion Manquée 2"
  },
  State_149619_Desc = {
    Text = "Après 1 tour, déclenche les effets suivants :\nGagne [DescArg1] points d'Arithmetica. \nGagne [DescArg2] points de Force. \nGagne [DescArg3] points de Fragment de clé. \nGagne [DescArg5] points de Fureur. \nPiocher [DescArg6] carte(s).\nGagne [DescArg7] points d'Amplification de Dégâts temporaire.\nRéduit temporairement la Force de tous les ennemis de [DescArg4] points."
  },
  State_149619_Name = {
    Text = "Occasion Manquée 1"
  },
  State_149628_Desc = {
    Text = "Si l'ennemi possède au moins 1000 points de Fragment de clé avant la fin du tour, Dévorer 1000 Fragment de clé."
  },
  State_149628_Name = {
    Text = "Sacrifice de Fragment de clé"
  },
  State_149629_Desc = {
    Text = "Si l'Éveilleur ayant la Fureur la plus élevée possède au moins 100 points de Fureur avant la fin du tour, Dévorer 50 points de sa Fureur."
  },
  State_149629_Name = {
    Text = "Sacrifice de Fureur"
  },
  State_149630_Desc = {
    Text = "Si l'ennemi possède au moins 1000 points de Fragment de clé avant la fin du tour, Dévorer 1000 Fragment de clé."
  },
  State_149630_Name = {
    Text = "Sacrifice de Fragment de clé"
  },
  State_149631_Desc = {
    Text = "Si l'ennemi possède au moins 3 points d'Arithmetica avant la fin du tour, Dévore 3 points d'Arithmetica."
  },
  State_149631_Name = {
    Text = "Sacrifice d'Arithmetica"
  },
  State_149632_Desc = {
    Text = "Si l'ennemi possède au moins 3 points d'Arithmetica avant la fin du tour, Dévore 3 points d'Arithmetica."
  },
  State_149632_Name = {
    Text = "Sacrifice d'Arithmetica"
  },
  State_149633_Desc = {
    Text = "Si l'ennemi possède au moins 4 Cartes d'instruction dans sa Main avant la phase de défausse, Dévorer 2 Cartes d'instruction aléatoires."
  },
  State_149633_Name = {
    Text = "Sacrifice de Cartes"
  },
  State_149634_Desc = {
    Text = "Si l'ennemi possède au moins 4 Cartes d'instruction dans sa Main avant la phase de défausse, Dévorer 2 Cartes d'instruction aléatoires."
  },
  State_149634_Name = {
    Text = "Sacrifice de Cartes"
  },
  State_149635_Desc = {
    Text = "Si l'Éveilleur ayant la Fureur la plus élevée possède au moins 100 points de Fureur avant la fin du tour, Dévorer 50 points de sa Fureur."
  },
  State_149635_Name = {
    Text = "Sacrifice de Fureur"
  },
  State_149652_Desc = {
    Text = "Impossible d'effectuer un Critique, non considéré comme des dégâts infligés par l'Éveilleur correspondant."
  },
  State_149652_Name = {
    Text = "<FixedDamage:DGT Purs>"
  },
  State_149660_Desc = {
    Text = "Les dégâts, le Bouclier et les variations de Force infligés par cette Carte sont augmentés de [DescArg2]%, l'Effet final des Dégâts des tentacules, de la récupération de PV, du Poison fixe et de la Contre-attaque fixe est augmenté de [DescArg1]%, retiré après avoir été joué."
  },
  State_149660_Name = {
    Text = "Renforcement [DescArg1]"
  },
  State_149664_Desc = {
    Text = "Chaque couche augmente de 2% les dégâts infligés par cette Carte, le Boost de DGT de Force fixe et de tentacules, le Poison fixe, et l'Effet final de la Contre-attaque fixe ; augmente de 1% l'Effet final du Bouclier fixe, de la récupération de PV fixe et de la Force réduite, retiré après avoir été joué."
  },
  State_149664_Name = {
    Text = "Renforcement"
  },
  State_149719_Name = {
    Text = "Immunité DGT Purs PVP__«Développement uniquement»"
  },
  State_149736_Desc = {
    Text = "Les [Layer] prochaines Cartes d'instruction de <AwakerName:[DescArg1]> voient leur Bouclier de base augmenté de [StateArg1]%."
  },
  State_149736_Name = {
    Text = "Tromperie mielleuse"
  },
  State_149744_Desc = {
    Text = "La prochaine Bénédiction jouée ne déclenchera pas d'effet négatif"
  },
  State_149744_Name = {
    Text = "Immunité aux Débuffs"
  },
  State_149772_Desc = {
    Text = "Chaque fois que des Dégâts Directs sont subis, tous les Éveilleurs perdent 3 Fureur. Se déclenche au maximum 5 fois par tour. Retire l'État «Garde Maudite» une fois le Bouclier brisé."
  },
  State_149772_Name = {
    Text = "Garde Maudite"
  },
  State_149773_Desc = {
    Text = "Chaque fois que des Dégâts Directs sont subis, applique 1 charge de «Stase» Temporaire à 1 Carte aléatoire en main. Se déclenche au maximum 5 fois par tour. Retire le «Bouclier de Givre» une fois le Bouclier brisé."
  },
  State_149773_Name = {
    Text = "Bouclier de givre"
  },
  State_149782_Desc = {
    Text = "Épuisement : Après avoir pioché des cartes au prochain tour, mélange 1 «Fruit Protéiforme» dans la Pioche."
  },
  State_149782_Name = {
    Text = "Fruit Protéiforme"
  },
  State_149787_Desc = {
    Text = "Pour chaque charge, les Dégâts Finaux des Cartes d'instruction de Serment Brisé·Ogier augmentent de [DescArg2]%, le nombre de cartes piochées au début du tour diminue de 1, les Dégâts Critiques augmentent de [DescArg3]%, limite de [DescArg1] charges, non effacé à la fin du combat."
  },
  State_149787_Name = {
    Text = "<KuangNu:courant sombre>"
  },
  State_149788_Desc = {
    Text = "En jouant la «Compétence» de Brise-Serment·Ogier, consomme 1 charge pour Piocher 1 carte «Défense», qui gagne Garder avant la prochaine utilisation. Maximum [DescArg1] charges. Non effacé à la fin du combat."
  },
  State_149788_Name = {
    Text = "<ShuZui:Culpabilité>"
  },
  State_149789_Desc = {
    Text = "Pour chaque charge, les Dégâts Finaux des Cartes d'instruction de Serment Brisé·Ogier augmentent de 33%, le nombre de cartes piochées au début du tour diminue de 1, limite de [DescArg1] charges, non effacé à la fin du combat."
  },
  State_149789_Name = {
    Text = "<KuangNu:courant sombre>"
  },
  State_149790_Desc = {
    Text = "Pour chaque charge, les Dégâts Finaux des Cartes d'instruction de Serment Brisé·Ogier augmentent de [DescArg2]%, le nombre de cartes piochées au début du tour diminue de 1, limite de [DescArg1] charges, non effacé à la fin du combat."
  },
  State_149790_Name = {
    Text = "<KuangNu:courant sombre>"
  },
  State_149791_Desc = {
    Text = "En jouant la «Compétence» de Brise-Serment·Ogier, consomme 1 charge pour Piocher 1 carte «Défense», qui gagne Garder avant la prochaine utilisation. Maximum [DescArg1] charges. Non effacé à la fin du combat."
  },
  State_149791_Name = {
    Text = "<ShuZui:Culpabilité>"
  },
  State_149814_Desc = {
    Text = "Amplification de Dégâts Temp. +[Layer]."
  },
  State_149814_Name = {
    Text = "Amplification de Dégâts Temporaire"
  },
  State_149819_Desc = {
    Text = "Immunité à tous les dégâts"
  },
  State_149819_Name = {Text = "Immunité"},
  State_149892_Desc = {
    Text = "Les [Layer] prochaines Cartes d'instruction de <AwakerName:[DescArg1]> voient leur Bouclier de base augmenté de [StateArg1]%."
  },
  State_149892_Name = {
    Text = "vérité douce et agréable"
  },
  State_149913_Name = {
    Text = "État@Effet Trésor Ver Macrophage_Tinct Endommagé"
  },
  State_149914_Name = {
    Text = "État@Effet Trésor Ver Macrophage_William Blessé"
  },
  State_149915_Name = {
    Text = "État@Effet Trésor Ver Macrophage_William"
  },
  State_149916_Name = {
    Text = "État@Effet Trésor Ver Macrophage_Castor Blessé"
  },
  State_149917_Name = {
    Text = "État@Effet Trésor Ver Macrophage_Chaîne de sang Helot Endommagé"
  },
  State_149918_Name = {
    Text = "État@Test Début de Tour Ver Macrophage"
  },
  State_149919_Name = {
    Text = "État@Effet Trésor Ver Macrophage_Tinct"
  },
  State_149920_Name = {
    Text = "État@Effet Trésor Ver Macrophage_Arachne"
  },
  State_149921_Name = {
    Text = "État@Effet Trésor Ver Macrophage_Arachne Endommagé"
  },
  State_149922_Name = {
    Text = "État@Effet Trésor Ver Macrophage_Castor"
  },
  State_149923_Name = {
    Text = "État@Effet Trésor Ver Macrophage_Chaîne de sang Helot"
  },
  State_149930_Desc = {
    Text = "Pour chaque charge, les Dégâts Finaux des Cartes d'instruction de Brise-Serment·Ogier sont augmentés de 50%. Au début du tour, nombre de Pioches –1. Maximum [DescArg1] charges. Non effacé à la fin du combat."
  },
  State_149930_Name = {
    Text = "<KuangNu2:courant sombre>"
  },
  State_149931_Desc = {
    Text = "Il existe 7 types d'effets, notamment : gagner de la STR, accumuler de la Répondre de Forge Écarlate, tous les Éveilleurs gagnent de la Fureur, bonus de Fusion d'Embryon, piocher des cartes, gagner des Fragments de clé, et bonus d'Amplification de Dégâts Temporaire."
  },
  State_149931_Name = {
    Text = "<Blessing:Bénédiction>"
  },
  State_149933_Name = {
    Text = "État@Bulle d'Offrande Caraboo Monstre"
  },
  State_149934_Name = {
    Text = "État@Bulle d'Offrande Caraboo Monstre"
  },
  State_149939_Desc = {
    Text = "Impossible d'obtenir un Bouclier jusqu'à la fin du tour."
  },
  State_149939_Name = {
    Text = "Chaînes de restriction"
  },
  State_19507_Desc = {
    Text = "Avant le début du prochain tour, les dégâts de l'attaque active et le nombre de couches de saignement augmentent de 25%, ce qui est annulé lorsqu'il est appliqué avec un renforcement."
  },
  State_19507_Name = {
    Text = "<PVPVulnerabilityIconColour:vulnérable>"
  },
  State_19508_Desc = {
    Text = "À la fin du tour, défausse cette carte"
  },
  State_19508_Name = {
    Text = "<PVPVoidKeyColour:Vide>"
  },
  State_19509_Desc = {
    Text = "Changer temporairement la carte Arithmetica. __ \"Pour usage de développement seulement\""
  },
  State_19509_Name = {
    Text = "Changement permanent de la puissance de calcul des cartes"
  },
  State_19511_Desc = {
    Text = "Après la mort, remplacez les cartes en main par des illusions"
  },
  State_19511_Name = {
    Text = "La mort déclenche le remplacement des cartes en main par des Songes"
  },
  State_19513_Name = {
    Text = "Appliquer deathmatch __ \"Pour le développement uniquement\""
  },
  State_19516_Name = {
    Text = "Changer temporairement la carte Arithmetica __ \"Pour usage de développement seulement\""
  },
  State_19517_Desc = {
    Text = "Chaque fois que vous perdez 2% de PV, gagnez 1 point de fureur"
  },
  State_19517_Name = {
    Text = "Subir des dégâts accorde à la Folie __ \"Pour usage de développement seulement\""
  },
  State_19519_Desc = {
    Text = "Après avoir utilisé « Frappe », consommez toutes les couches ; chaque couche augmente les dégâts causés par cette « Frappe » de 50 %, empilable jusqu'à 5 couches. (Actuellement augmenté de [DescArg1] %)"
  },
  State_19519_Name = {Text = "Charge"},
  State_19521_Desc = {
    Text = "Chaque couche augmente de 1 point tous les dégâts infligés dans ce combat, ne peut pas être dissipée."
  },
  State_19521_Name = {
    Text = "<PowerColourKeywords:Puissance>"
  },
  State_19522_Name = {
    Text = "Changer temporairement la carte Arithmetica __ \"Pour usage de développement seulement\""
  },
  State_19523_Name = {
    Text = "Changement permanent de la puissance de calcul des cartes"
  },
  State_19524_Desc = {
    Text = "Avant le prochain tour, chaque attaque subie inflige [Layer] dégâts passifs à l'attaquant"
  },
  State_19524_Name = {
    Text = "Contre-attaque"
  },
  State_19525_Desc = {
    Text = "Retirer le bouclier du Réveilleur avant le début du tour__ \"Pour usage de développement uniquement\""
  },
  State_19525_Name = {
    Text = "Retirer le bouclier du personnage avant le début du tour__ \"Pour usage de développement uniquement\""
  },
  State_19527_Desc = {
    Text = "Chaque charge augmente le coût d'Arithmetica des «compétences» de +1 ce tour, jusqu'à 3 charges maximum. Après avoir joué une compétence, si le nombre de charges est supérieur à 1, les charges diminuent de 1."
  },
  State_19527_Name = {
    Text = "<SlowColour:Ralentissement>"
  },
  State_19528_Desc = {
    Text = "Posséder des cartes avec des effets puissants"
  },
  State_19528_Name = {
    Text = "<SilverKeyColour:Clé d'argent>"
  },
  State_19529_Desc = {
    Text = "Chaque fois que vous jouez une autre carte, réduisez le Coût d'Arithmetica de cette carte de 1 pour le prochain jeu ; après avoir joué cette carte, retournez-la dans votre main et augmentez son Coût d'Arithmetica de 1, puis défaussez-la en fin de tour."
  },
  State_19529_Name = {
    Text = "<CardKeyWord:Illusion>"
  },
  State_19530_Desc = {
    Text = ": Les adversaires priorisent l'attaque de cette unité. Lorsque les ennemis utilisent des capacités à cible unique, ils ne peuvent sélectionner que l'Éveilleur provoquant.\nLors de l'obtention de la provocation, retirez votre propre invisibilité et la provocation des autres alliés, tout en dissipant l'invisibilité ennemie."
  },
  State_19530_Name = {
    Text = "<TauntColour:Provocation>"
  },
  State_19532_Desc = {
    Text = "Les dégâts infligés avant la fin de ce tour sont réduits de [DescArg1] %, annulés en appliquant le renfort"
  },
  State_19532_Name = {Text = "Faiblesse"},
  State_19533_Desc = {
    Text = "Les dégâts infligés avant la fin de ce tour sont réduits de 50 %, annulés en appliquant le renfort"
  },
  State_19533_Name = {
    Text = "<WeaknessColour:Faiblesse>"
  },
  State_19534_Desc = {
    Text = "Avant le début du prochain tour, les dégâts de l'attaque active et le nombre de couches de saignement augmentent de [DescArg1]%, ce qui est annulé lorsqu'il est appliqué avec un renforcement."
  },
  State_19534_Name = {
    Text = "Vulnérable"
  },
  State_19535_Desc = {
    Text = ": Les adversaires priorisent l'attaque de cette unité. Lorsque les ennemis utilisent des capacités à cible unique, ils ne peuvent sélectionner que l'Éveilleur provoquant.\nLors de l'obtention de la provocation, retirez votre propre invisibilité et la provocation des autres alliés, tout en dissipant l'invisibilité ennemie."
  },
  State_19535_Name = {
    Text = "Provocation"
  },
  State_19536_Desc = {
    Text = "Gagnez 10 Folie à la fin du tour __ \"Usage développement uniquement\""
  },
  State_19536_Name = {
    Text = "Gagnez un déclencheur de Folie à la fin du tour __ \"Usage développement uniquement\""
  },
  State_19537_Desc = {
    Text = "Dégâts augmentés de [DescArg1]% jusqu'à la fin du tour, annule la faiblesse"
  },
  State_19537_Name = {
    Text = "Renforcement"
  },
  State_19538_Desc = {
    Text = "·Au début des tours 8 et 9, gagne 1 couche\n·Chaque couche de Duel à mort réduit les boucliers et la guérison de 50% et diminue les couches de barrière empilables de 1\n·Le Duel à mort ne peut pas être dissipé et affecte aussi les Éveillés morts"
  },
  State_19538_Name = {
    Text = "Arenes mortelles"
  },
  State_19540_Name = {
    Text = "Limite d’Arithmetica"
  },
  State_19541_Desc = {
    Text = "Avant la fin du tour, vous ne pouvez effectuer aucune action"
  },
  State_19541_Name = {
    Text = "Inconscient"
  },
  State_19544_Desc = {
    Text = "Après avoir utilisé « Frappe », consommez toutes les couches ; chaque couche consommée augmente les dégâts causés par cette « Frappe » de 50 %, empilable jusqu'à 5 couches."
  },
  State_19544_Name = {
    Text = "<EnergyStorageColour:charge>"
  },
  State_19545_Name = {
    Text = "Cette carte est considérée comme « Attaque »"
  },
  State_19546_Desc = {
    Text = "Changez le coût en arithmetica de la carte avant de la jouer."
  },
  State_19546_Name = {
    Text = "Changez le coût en arithmetica de la carte avant de la jouer"
  },
  State_19547_Desc = {
    Text = "À la fin du tour, inflige [Layer] dégâts passifs, permanent"
  },
  State_19547_Name = {Text = "Poison"},
  State_19549_Desc = {
    Text = "Les dégâts des attaques actives subies avant le début du prochain tour diminuent de 50 %, compensés avec la vulnérabilité lorsqu'ils sont appliqués"
  },
  State_19549_Name = {
    Text = "<ReinforceColour:renforcé>"
  },
  State_19552_Desc = {
    Text = "Vous avez actuellement [Layer] points de bouclier, le bouclier ne dépassera pas la vie maximale, et dure 1 tour"
  },
  State_19552_Name = {Text = "Bouclier"},
  State_19553_Desc = {
    Text = "Gagnez un contre-attaque après la phase de tirage __ \"Pour développement uniquement\""
  },
  State_19553_Name = {
    Text = "Déclencheur différé __ \"Pour usage de développement uniquement\""
  },
  State_19554_Name = {Text = "État vide"},
  State_19555_Desc = {
    Text = "·Le coût d'Arithmetica des «compétences» augmente de +[Layer] ce tour, jusqu'à 3 charges maximum.\n·Après avoir joué une «compétence», si le nombre de charges est supérieur à 1, les charges diminuent de 1."
  },
  State_19555_Name = {Text = "Stagnation"},
  State_19556_Desc = {
    Text = "À la fin du tour, le coût en arithmetica de cette carte est réduit de -[Layer]."
  },
  State_19556_Name = {
    Text = "<PrepareKeywords:Préparation [Layer]>"
  },
  State_19557_Desc = {
    Text = "Les dégâts des attaques actives subies avant le début du prochain tour diminuent de [DescArg1] %, compensés avec la vulnérabilité lorsqu'ils sont appliqués"
  },
  State_19557_Name = {Text = "Forteresse"},
  State_19558_Name = {
    Text = "Bibliothèque de cartes de Résurrection ajouter le déclencheur de carte__ \"Pour usage de développement uniquement\""
  },
  State_19560_Desc = {
    Text = "Avant la fin du tour, il n'est pas possible d'utiliser l'exaltation"
  },
  State_19560_Name = {Text = "Scellé"},
  State_19561_Name = {
    Text = "Peut être utilisé 3 fois."
  },
  State_19990_Desc = {
    Text = "Au début du prochain tour, obtenez [Layer] folie"
  },
  State_19990_Name = {
    Text = "Fureur de latence"
  },
  State_19992_Desc = {
    Text = "Lorsqu'une cible est Inconsciente, elle ne peut effectuer aucune action jusqu'à la fin du tour. Subir des Dommages d'évanouissement confère une Résistance. Si la Résistance est active, les Dommages d'évanouissement suivants sont doublés mais l'effet d'évanouissement est annulé."
  },
  State_19992_Name = {
    Text = "<ComaColour:évanouissement>"
  },
  State_19995_Desc = {
    Text = "À la fin du tour, inflige des dégâts passifs égaux aux charges, permanent"
  },
  State_19995_Name = {
    Text = "<IntoxicationColour:Empoisonnement>"
  },
  State_19996_Desc = {
    Text = "Dégâts augmentés de 25% jusqu'à la fin du tour, annule la faiblesse"
  },
  State_19996_Name = {
    Text = "<StrengthenColour:Renforcer>"
  },
  State_19998_Desc = {
    Text = "Avant le prochain tour, chaque attaque subie inflige un nombre égal de charges de dégâts passifs à l'attaquant"
  },
  State_19998_Name = {
    Text = "<RetaliateColour:comptoir>"
  },
  State_20012_Desc = {
    Text = "Chaque point d'arithmétique restant vous permet de piocher 1 carte au début du prochain tour ; chaque carte restante en main vous permet d'obtenir 1 point d'arithmétique au début du prochain tour"
  },
  State_20012_Name = {
    Text = "Fragment des Anciens Métamorphosés"
  },
  State_20012_WeaponDesc = {
    Text = "Chaque point d'arithmétique restant vous permet de piocher 1 carte au début du prochain tour ; chaque carte restante en main vous permet d'obtenir 1 point d'arithmétique au début du prochain tour"
  },
  State_20013_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Maîtrise des Royaumes> +100. Reprenez la 1ère carte jouée chaque tour. Au début du tour dimensionnel, limite de cartes +5 et dupliquez votre main"
  },
  State_20013_Name = {
    Text = "État@pendule chronique miroir"
  },
  State_20014_Name = {
    Text = "Pendule temporel«Perdu»"
  },
  State_20016_Name = {
    Text = "Gants magiques de la création"
  },
  State_20017_Desc = {
    Text = "Le prochain effet de saut se déclenche à coup sûr"
  },
  State_20017_Name = {
    Text = "Saut Quantique"
  },
  State_20021_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Maîtrise des Royaumes> +100. Reprenez la 1ère carte jouée chaque tour. Au début du tour dimensionnel, limite de cartes +5 et dupliquez votre main"
  },
  State_20021_Name = {
    Text = "État@pendule chronique miroir"
  },
  State_20023_Desc = {
    Text = "Après le début du combat, deux cartes de folie chargées sont insérées dans la pioche"
  },
  State_20023_Name = {
    Text = "Hybride du Chaos"
  },
  State_20023_WeaponDesc = {
    Text = "Après le début du combat, deux cartes de folie chargées sont insérées dans la pioche"
  },
  State_20024_Desc = {
    Text = "Chaque fois que vous libérez l'exaltation, obtenez une <Contamination toxique> capable d'appliquer [Arg1] points de poison. À la fin du tour, si vous avez 3 <Contamination toxique> en main, vous pouvez les combiner pour créer une <Toxicité active> déclenchant le poison."
  },
  State_20024_Name = {
    Text = "État@Création altérée: Langue étrangère"
  },
  State_20026_Desc = {
    Text = "Les cartes ne vont pas dans la pile de défausse pendant la phase de défausse, elles restent en main et déclenchent les effets suivants."
  },
  State_20026_Name = {
    Text = "<RetainIconKeywords:Conservation>"
  },
  State_20026_WeaponDesc = {
    Text = "Après avoir joué, la carte ne sera pas mise dans la défausse et ne pourra pas être utilisée à nouveau dans ce combat"
  },
  State_20028_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Maîtrise de Royaume> +100. Chaque carte jouée augmente Fusion d'Embryon de 10, 20 si PV < 25%, max 10 fois/tour."
  },
  State_20028_Name = {
    Text = "État@pendule chronique érosion"
  },
  State_20029_Desc = {
    Text = "Chaque fois que vous libérez l'exaltation, obtenez une contamination toxique capable d'appliquer [Arg1] points de poison. À la fin du tour, pour chaque 3 contaminations toxiques en main, vous pouvez synthétiser une toxicité active déclenchant le poison."
  },
  State_20029_Name = {
    Text = "État@Création altérée: Langue étrangère"
  },
  State_20035_Name = {
    Text = "État@pendule chronique insomnie"
  },
  State_20038_Name = {
    Text = "Corps symbiotique du chaos"
  },
  State_20038_WeaponDesc = {
    Text = "Quand l'équipe est composée de Chaos et d'autres classes, au début du tour, tous les éveillés gagnent 20 folie"
  },
  State_20039_Desc = {
    Text = "Si la carte est toujours dans la main au moment de la phase de défausse, elle sera épuisée et n'apparaîtra plus dans cette bataille"
  },
  State_20039_Name = {
    Text = "<NothingnessIconKeywords: Illusion>"
  },
  State_20039_WeaponDesc = {
    Text = "Après avoir joué, la carte ne sera pas mise dans la défausse et ne pourra pas être utilisée à nouveau dans ce combat"
  },
  State_20040_Name = {
    Text = "État@pendule chronique compteur d'insomnie"
  },
  State_20041_Desc = {
    Text = "Au début du tour, pour chaque ennemi, gagne 1 arithmetica, tire 1 carte. Lorsque tu tues un ennemi par des dégâts actifs, inflige des dégâts de saignement équivalents à deux fois les dégâts excédentaires à d'autres ennemis"
  },
  State_20041_Name = {
    Text = "Chanson des masses altérées"
  },
  State_20042_Desc = {
    Text = "Les dégâts infligés aux ennemis en état négatif augmentent de 25%, et le tueur gagne 20 folie"
  },
  State_20044_Desc = {
    Text = "Effet de Symptôme : Affaiblir augmenté de 10 %. Ajoute 1 charge de Symptôme : Affaiblir à tous les ennemis tous les 3 tours."
  },
  State_20045_Desc = {
    Text = "Au début du prochain tour, choisissez 3 cartes de votre deck et ajoutez-les à votre main"
  },
  State_20045_Name = {
    Text = "Pendule temporel vole"
  },
  State_20306_Name = {
    Text = "Gants magiques de la création"
  },
  State_20419_Desc = {
    Text = "Chaque fois qu'un dommage est infligé, appliquez [Arg1] couches de poison à la cible. Si le nombre d'activations dans ce combat atteint 25, déclenchez immédiatement le poison sur tous les ennemis"
  },
  State_20425_Desc = {
    Text = "Au début du tour, gagnez [Layer] points de <PowerIconKeywords:force> temporaire et de bouclier"
  },
  State_20425_Name = {
    Text = "Soif de sang insatiable"
  },
  State_20600_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Chaque tour, les [StateArg2] premières « compétences » consomment [StateArg1] Arithmetica de moins."
  },
  State_20600_Name = {Text = "Épiphanie"},
  State_20601_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin>: \"Frappe\" dégâts augmentés de [StateArg1]%. Lorsqu'il est attaqué, gagne [StateArg2] couches de <EnergyStorageKeywords:Charge>."
  },
  State_20601_Name = {
    Text = "Gourmandise"
  },
  State_20602_Desc = {
    Text = "<PVPWeaponKeywords:roue du destin> : « frappe » peut choisir sa cible et inflige [StateArg1] couches de <PVPSlowKeywords:lenteur>. L'effet est doublé lorsqu'il est déclenché pour la première fois sur une cible durant le tour."
  },
  State_20602_Name = {
    Text = "Main de l'Oubli"
  },
  State_20603_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : « Exaltation » vous fait gagner <Energy:[Energy:StateArg1]> Aliemus."
  },
  State_20603_Name = {
    Text = "Rétroaction du corps déformé"
  },
  State_20604_Desc = {
    Text = "<PVPWeaponKeywords:Roulette du destin> : \"Coup\" rend <Heal:[Heal:StateArg1]> de vie"
  },
  State_20604_Name = {Text = "Succion"},
  State_20605_Desc = {
    Text = "<PVPWeaponKeywords:wheel of destiny>: Lorsqu'équipé, <ComaKeywords:fainted> lui-même. Avant \"élever\", dissipez tous les états négatifs des alliés."
  },
  State_20605_Name = {
    Text = "Béquille de Lord"
  },
  State_20606_Desc = {
    Text = "<PVPWeaponKeywords:Roulette du destin> : \"Coup\" donne <Energy:[Energy:StateArg1]> de folie"
  },
  State_20606_Name = {Text = "Frénésie"},
  State_20607_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : « Frappe » attaque l'ennemi avec <HPAndShieldMax:la vie et le bouclier les plus élevés>, et inflige en plus [StateArg1]% des dégâts en <PVPBleedingKeywords:Saignement>."
  },
  State_20607_Name = {
    Text = "Incision Profonde"
  },
  State_20608_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Gagnez <Energy:[Energy:StateArg1]> de Fureur en utilisant une « compétence » et à la fin du tour."
  },
  State_20608_Name = {Text = "Murmure"},
  State_20609_Desc = {
    Text = "<PVPWeaponKeywords:Roulette de la Destinée> : La folie gagnée par la perte de vie est doublée"
  },
  State_20609_Name = {
    Text = "Rêve Marin"
  },
  State_20610_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Les Dégâts augmentés de «Attaque» de [DescArg1]%, après «Exaltation», augmente sa propre <PVPPowerIconKeywords:Force> de + [StateArg2] et augmente en plus les Dommages de «Attaque» de [StateArg3]%, jusqu'à un maximum de 100%."
  },
  State_20610_Name = {
    Text = "Bête Stellaire"
  },
  State_20611_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: \"Skill\", et à la fin du tour, restaure <Heal:[Heal:StateArg1]> vie à l'allié avec le plus de vie perdue."
  },
  State_20611_Name = {Text = "Espoir"},
  State_20612_Desc = {
    Text = "<PVPWeaponKeywords:Roulette de Destin> : À la fin du tour, l'allié avec le moins de Folie obtient <Energy:[Energy:StateArg1]> Folie et l'allié avec le plus de PV perdus récupère <Heal:[Heal:StateArg2]> PV"
  },
  State_20612_Name = {
    Text = "Élevé dans la Douceur"
  },
  State_20613_Desc = {
    Text = "<PVPWeaponKeywords:Roulette de Destin> : À la fin du tour, les autres alliés obtiennent <Block:[Block:StateArg1]> Bouclier"
  },
  State_20613_Name = {
    Text = "Terres de l'Inexistence"
  },
  State_20614_Desc = {
    Text = "<PVPWeaponKeywords:roue du destin>：À la fin du tour, gagnez [StateArg1] <PVPRetaliateIconKeywords:comptoir> temporaire"
  },
  State_20614_Name = {
    Text = "Fusion du Cœur"
  },
  State_20615_Desc = {
    Text = "<PVPWeaponKeywords:roue du destin> : « frappe » inflige également [StateArg1] de dégâts, <PVPMethysisKeywords:empoisonnement>."
  },
  State_20615_Name = {
    Text = "Malédiction liante"
  },
  State_20616_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: Obtenez <Energy:[Energy:StateArg1]> Aliemus à la fin du tour."
  },
  State_20616_Name = {
    Text = "Printemps à Acushnet"
  },
  State_20617_Desc = {
    Text = "<PVPWeaponKeywords:Roulette de la Destinée> : À la fin du tour, gagne <Block:[Block:StateArg1]> bouclier"
  },
  State_20617_Name = {Text = "Exil"},
  State_20618_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin>: Avant « Exaltation », faites défausser aux deux parties toutes leurs cartes en main et piochez le même nombre de cartes défaussées +1."
  },
  State_20618_Name = {
    Text = "Joyeux Spectacle de Magie"
  },
  State_20619_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : À l'équipement, gagnez <Energy:[Energy:StateArg1]> Aliemus. Lorsque le Corps éveillé allié libère l'« Exaltation », vous gagnez <DelayKeywords:Latence> : <Energy:[Energy:StateArg2]> Aliemus."
  },
  State_20619_Name = {
    Text = "Hymne au Dieu-Roi"
  },
  State_20620_Desc = {
    Text = "<PVPWeaponKeywords:roue du destin> : Limite de cartes + [StateArg2]. À la fin du tour, obtenez [StateArg1] copie(s) aléatoire(s) de « compétence » dans votre main."
  },
  State_20620_Name = {
    Text = "Moment de rassemblement"
  },
  State_20621_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Avant « Exaltation », <StrengthenKeywords:Renforcement> et <ReinforceKeywords:Forteresse> soi-même."
  },
  State_20621_Name = {
    Text = "Au Travers de la Douleur"
  },
  State_20622_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : À la fin du tour, gagnez <Energy:[Energy:StateArg1]> Aliemus. Consommez toute l'Arithmetica restante, gagnez [StateArg3] Aliemus supplémentaire pour chaque 1 Arithmetica consommée."
  },
  State_20622_Name = {
    Text = "Naissance Cachée"
  },
  State_20623_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Après « Exaltation », piochez [StateArg1] <plural value=\"[StateArg1]\" singular=\"carte\" plural=\"cartes\">."
  },
  State_20623_Name = {Text = "Apparition"},
  State_20624_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Après « Exaltation », piochez [StateArg1] cartes, placez [StateArg2] copies dans votre main."
  },
  State_20624_Name = {
    Text = "Moment Propice"
  },
  State_20625_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : « Exaltation » <DelayKeywords:Latence> : rend <Heal:[Heal:StateArg1]> PV à tous les alliés."
  },
  State_20625_Name = {
    Text = "Fable du Glouton"
  },
  State_20626_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin>:\"Frappe\" dégâts augmentés de [StateArg1]%, et s'accorde <ReinforceKeywords:Fortifier>."
  },
  State_20626_Name = {
    Text = "Volonté Inébranlable"
  },
  State_20627_Desc = {
    Text = "<PVPWeaponKeywords:Roulette de Destin> : À la fin du tour, tous les alliés récupèrent <Heal:[Heal:StateArg1]> PV"
  },
  State_20627_Name = {
    Text = "Bénédiction"
  },
  State_20628_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Après « Exaltation », les autres alliés gagnent <Energy:[Energy:StateArg1]> Aliemus. Si cela accorde à un allié plus d'Aliemus que nécessaire pour activer son Exaltation, le Porteur gagne la moitié de l'excédent."
  },
  State_20628_Name = {
    Text = "Devoir accompli"
  },
  State_20629_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin>: Les dégâts, soins et effets de bouclier causés par « Exaltation » sont augmentés de [StateArg1] %."
  },
  State_20629_Name = {
    Text = "Au nom de la Rose"
  },
  State_20630_Desc = {
    Text = "<PVPWeaponKeywords:Roulette de la Destinée> : À la fin du tour, gagne <Block:[Block:StateArg1]> bouclier et <Energy:[Energy:StateArg2]> folie"
  },
  State_20630_Name = {
    Text = "Souvenirs d'une Nuit d'Hiver"
  },
  State_20631_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : « Attaque » rend la cible <PVPVulnerabilityIconKeywords:Vulnérable>. Gagnez [StateArg1] <EnergyStorageKeywords:Charge> en s'équipant et à la fin de votre tour."
  },
  State_20631_Name = {
    Text = "Point critique"
  },
  State_20632_Desc = {
    Text = "<PVPWeaponKeywords:Cycle de Destinée> : Limite de cartes +[StateArg1]"
  },
  State_20632_Name = {
    Text = "Spirale Mnésique"
  },
  State_20633_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Lorsque le Porteur est attaqué activement pour la première fois chaque tour, inflige [StateArg1] Dommages à l'attaquant, <PVPEntanglementKeywords:Entrelacé>."
  },
  State_20633_Name = {
    Text = "Rejetons Pâles"
  },
  State_20634_Desc = {
    Text = "<PVPWeaponKeywords:roue du destin> : Les dégâts, soins et boucliers infligés par « Coup », « Compétence » et « Exalter » sont augmentés de [DescArg1] %, <PVPGrowthKeywords:croissance> [StateArg2] %."
  },
  State_20634_Name = {
    Text = "Crépuscule"
  },
  State_20635_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: Accorde <StrengthenKeywords:Renforcer> à tous les alliés avant \"Exalter\"."
  },
  State_20635_Name = {
    Text = "La puissance dévouée"
  },
  State_20636_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : À la fin du tour, gagnez un <PVPDerivativeCardKeywords_2:« Songe »>. Pour chaque deux <PVPDerivativeCardKeywords_2:« Songe »> en main, fusionnez-les en un <PVPDerivativeCardKeywords_12:« Petit vœu »>."
  },
  State_20636_Name = {Text = "Maturité"},
  State_20637_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: À la fin du tour, mélangez [StateArg1] copies de <PVPDerivativeCardKeywords_11:\"Échange Inégal\"> dans la pile de pioche."
  },
  State_20637_Name = {
    Text = "Information Mère de Vie"
  },
  State_20639_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : En fin de tour, le porteur inflige [StateArg1] dégâts à l'ennemi avec <HPAndShieldMax:la vie et le bouclier les plus élevés>, <PVPMethysisKeywords:Empoisonnement>."
  },
  State_20639_Name = {
    Text = "Cadeau Empoisonné"
  },
  State_20640_Desc = {
    Text = "<PVPWeaponKeywords:roue du destin> : En s'équipant et au début du tour, infligez des <Damage:[Damage:StateArg1]> <PVPBleedingKeywords:saignement> à tous les ennemis, pour chaque carte en main de la cible, le <PVPBleedingKeywords:saignement> augmente de +[StateArg2]"
  },
  State_20640_Name = {
    Text = "Festin Sanglant"
  },
  State_20641_Desc = {
    Text = "<PVPWeaponKeywords:Cycle de Destinée> : À la mort, donne [StateArg1] couches de <PVPProtectiveKeywords:barrière> aux autres alliés"
  },
  State_20641_Name = {
    Text = "Analyse de la Mort"
  },
  State_20642_Desc = {
    Text = "<PVPHoldingKeywords:En main>: Après avoir joué une carte, cette carte devient un autre \"Roulette du Destin\" aléatoire et réduit son coût arithmétique de -1."
  },
  State_20642_Name = {Text = "Âme née"},
  State_20643_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Après « Exaltation », gagne [StateArg1] Arithmetica. <DelayKeywords:Latence> : déduit [StateArg2] Arithmetica."
  },
  State_20643_Name = {
    Text = "Syndrome d'amnésie"
  },
  State_20644_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : En s'équipant, infligez [StateArg2] Dommages à soi-même, <PVPEntanglementKeywords:Entrelacé>. Pour chaque allié tombé, <StrongEffectKeywords:Amplification> +[StateArg1]."
  },
  State_20644_Name = {
    Text = "Une Collection des plus Précieuses"
  },
  State_20645_Name = {
    Text = "Sac de l'Aventurier"
  },
  State_20646_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : les Dommages d'« Attaque » augmentent de [StateArg1] %, « Exaltation » rend <Heal:[Heal:StateArg2]> PV."
  },
  State_20646_Name = {
    Text = "Berceuse Dévorante"
  },
  State_20647_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : « Exaltation » place [StateArg1] <PVPDerivativeCardKeywords_11:« Échange Inégal »> dans votre Main."
  },
  State_20647_Name = {
    Text = "Au Milieu de l'Averse"
  },
  State_20648_Desc = {
    Text = "<PVPWeaponKeywords:Roulette de Destin> : Au début du tour, obtient un <PVPWonderfulEffectKeywords:Effet Merveilleux> positif, chaque fois que l'ennemi utilise une \"Clé\" pour la première fois par tour, ajoute [StateArg1] cartes \"Scène Éblouissante\" à sa main"
  },
  State_20648_Name = {
    Text = "Festin Silencieux"
  },
  State_20649_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin>: Après « Exaltation », renvoyez la dernière « compétence » jouée lors du tour précédent dans votre main ; son coût en arithmétique -1. Si ce type d'effet est déclenché plusieurs fois, il remonte plus loin."
  },
  State_20649_Name = {
    Text = "Remonter le Temps"
  },
  State_20650_Desc = {
    Text = "<PVPWeaponKeywords:wheel of destiny>: Lorsqu'équipé, <ComaKeywords:fainted> lui-même. Avant \"élever\", dissipez tous les états positifs des ennemis."
  },
  State_20650_Name = {Text = "Delirium"},
  State_20651_Desc = {
    Text = "<PVPWeaponKeywords:Roulette de la Destinée> : À la fin du tour, pioche [StateArg1] cartes"
  },
  State_20651_Name = {
    Text = "Gourmandise"
  },
  State_20652_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin>:\"Exalter\" inflige [StateArg1] dégâts à tous les ennemis, <DisarmKeywords:Paralysie>."
  },
  State_20652_Name = {Text = "Châtiment"},
  State_20653_Desc = {
    Text = "<PVPWeaponKeywords:Roulette du destin> : \"Coup\" peut cibler et retirer <Energy:[Energy:StateArg1]> de folie à la cible"
  },
  State_20653_Name = {
    Text = "Aléas du Désir"
  },
  State_20654_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : au début du tour, <PVPSeriousInjuryKeywords:Corruption> soi-même et gagne <Damage:[Damage:StateArg1]> couche(s) de <PVPCorrosionKeywords:Marque de péché>. À la fin du tour, <ReinforceKeywords:Forteresse> soi-même."
  },
  State_20654_Name = {
    Text = "Ordre de la Reine"
  },
  State_20655_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin>: \"Frappe\" dégâts augmentés de [StateArg1]%, \"Frappe\" peut cibler n'importe quel ennemi."
  },
  State_20655_Name = {Text = "Faveur"},
  State_20656_Desc = {
    Text = "<PVPWeaponKeywords:roue du destin> : Les dégâts, soins et effets de bouclier causés par « Compétence » sont augmentés de [StateArg1] %, obtenez 1 couche si vous ne possédez pas de <PVPProtectiveKeywords:barrière> après avoir utilisé « Compétence »."
  },
  State_20656_Name = {
    Text = "Dernier Vers"
  },
  State_20657_Desc = {
    Text = "<PVPWeaponKeywords:roue du destin> : À chaque fois que l’adversaire joue la [StateArg1]e \"compétence\" par tour, ajoutez une copie avec un coût en calcul de - [StateArg2] à votre main"
  },
  State_20657_Name = {
    Text = "Clairvoyance"
  },
  State_20658_Desc = {
    Text = "<PVPWeaponKeywords:roue du destin> : « frappe » gagne [StateArg1] arithmética par chaque cible attaquée"
  },
  State_20658_Name = {
    Text = "Ballade du Prisonnier"
  },
  State_20659_Desc = {
    Text = "<PVPWeaponKeywords:Cycle de Destinée> : À la mort, <PVPResurrectionKeywords:ressuscite> au début du prochain tour avec <Heal:[Heal:StateArg1]> de vie et <Block:[Block:StateArg2]> de bouclier, détruit ce \"Cycle de Destinée\""
  },
  State_20659_Name = {Text = "Vitalité"},
  State_20660_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin>: Après \"exalter\", tous les alliés gagnent un bouclier <Block:[Block:StateArg1]>."
  },
  State_20660_Name = {
    Text = "Barrière du cœur"
  },
  State_20661_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Après « Exaltation », infligez <Damage:[Damage:StateArg1]> Dommages de <PVPBleedingKeywords:Saigner> à tous les ennemis."
  },
  State_20661_Name = {
    Text = "Chemin Perdu"
  },
  State_20662_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : En fin de tour, chaque point de <PVPCapKeywords:capacité de calcul maximale> inflige [StateArg1] <PVPBleedingKeywords:Saignement> à l'ennemi avec <HPAndShieldMin:la vie et le bouclier les plus faibles>, pour un total de <Damage:[Damage:DescArg1]> dégâts de <PVPBleedingKeywords:Saignement>."
  },
  State_20662_Name = {
    Text = "Se fondre dans la nuit"
  },
  State_20663_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Avant « Exaltation », dissipe les états négatifs et gagne [StateArg1] charges de <EnergyStorageKeywords:Charge>."
  },
  State_20663_Name = {
    Text = "Chaînes Brisées"
  },
  State_20664_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin>:\"Compétence\" s'accorde <ReinforceKeywords:Fortifier>."
  },
  State_20664_Name = {
    Text = "Serment du Chevalier"
  },
  State_20665_Desc = {
    Text = "<PVPWeaponKeywords:Roulette de la Destinée>:Si aucun état négatif à dissiper, récupère <Heal:[Heal:StateArg1]> PV en dissipant. Fin de tour, <DelayKeywords:Retard>: dissipe les états négatifs"
  },
  State_20665_Name = {
    Text = "Guidé par la Grand-Voile"
  },
  State_20666_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Après une « Explosion de Folie », l'allié avec <HPAndShieldMin:la vie et le bouclier les plus faibles> obtient [StateArg1] stack(s) de <PVPProtectiveKeywords:Barrière>."
  },
  State_20666_Name = {
    Text = "À mon cher ami"
  },
  State_20667_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Les Dommages de la première « compétence » du Porteur jouée chaque tour augmentent de [StateArg1] %."
  },
  State_20667_Name = {
    Text = "Lame du Colosse"
  },
  State_20668_Desc = {
    Text = "<PVPWeaponKeywords:roue du destin> : Lorsqu'un allié éveillé meurt, infligez <Damage:[Damage:StateArg1]> <PVPBleedingKeywords:saignement> dégâts à tous les ennemis. Infligez en plus <Damage:[Damage:StateArg2]> <PVPBleedingKeywords:saignement> dégâts supplémentaires si le porteur meurt."
  },
  State_20668_Name = {
    Text = "Décès de Mme Coral"
  },
  State_20669_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Lorsqu'équipé et au début de votre tour, s'il n'y a pas de <PVPProtectiveKeywords:barrière>, gagnez [StateArg1] couches de <PVPProtectiveKeywords:barrière> ; sinon, réduisez le coût en arithmétique de 1 « compétence » en main ayant le coût en arithmétique le plus élevé de 1."
  },
  State_20669_Name = {
    Text = "Tables de la Loi"
  },
  State_20670_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: \"Frappe\" inflige <PVPSeriousInjuryKeywords:Blessure Sérieuse>, augmentant les dégâts de [StateArg1]%, mais provoquant au lanceur de perdre la moitié des dégâts infligés en tant que vie."
  },
  State_20670_Name = {
    Text = "Triste Nageoire"
  },
  State_20671_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : « Exaltation » restaure <Heal:[Heal:StateArg1]> PV à soi-même."
  },
  State_20671_Name = {
    Text = "Par-delà la Mort"
  },
  State_20672_Desc = {
    Text = "<PVPWeaponKeywords:roue du destin> : À la fin du tour, réduit de [StateArg1] le coût en calcul de la carte en main ayant le coût en calcul le plus élevé.<PrepareKeywords:Prêt>."
  },
  State_20672_Name = {
    Text = "Concentrer l'esprit"
  },
  State_20673_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : « Exaltation » vous donne <Block:[Block:StateArg1]> Bouclier du personnage, et les autres alliés gagnent <Energy:[Energy:StateArg2]> Aliemus."
  },
  State_20673_Name = {
    Text = "Calcul Impossible"
  },
  State_20696_Name = {
    Text = "État@PeurDuGéant"
  },
  State_20723_Desc = {
    Text = "Les dégâts de la carte de frappe augmentent de [Layer]. __ \"Pour le développement uniquement\""
  },
  State_20723_Name = {
    Text = "Augmentation de dégâts fixe pour la carte de frappe __ \"Pour développement uniquement\""
  },
  State_20724_Desc = {
    Text = "Les dégâts de la carte de frappe sont réduits de [Layer]. __ \"Pour le développement uniquement\""
  },
  State_20724_Name = {
    Text = "Réduction de dégâts fixe pour la carte de frappe __ \"Pour développement uniquement\""
  },
  State_20749_Desc = {
    Text = "Compte de suivi générique. __ \"Pour développement uniquement\""
  },
  State_20758_Desc = {
    Text = "Au début du prochain tour, piochez [Layer] cartes"
  },
  State_20758_Name = {
    Text = "Tirage différé"
  },
  State_20766_Desc = {
    Text = "Voir la logique de grève générale pour des effets spécifiques. __ \"Pour usage de développement uniquement\""
  },
  State_20802_Desc = {
    Text = "Cette carte ne peut pas être jouée"
  },
  State_20802_Name = {
    Text = "Ne peut pas être joué __ \"Pour développement uniquement\""
  },
  State_20803_Desc = {
    Text = "Cette carte réduit son coût d'Arithmetica de -1. Après avoir joué d'autres cartes, celle-ci se transforme en une autre carte de Roue du Destin aléatoire."
  },
  State_20803_Name = {
    Text = "<CardKeyWord: Naissance d'une âme>"
  },
  State_20805_Desc = {
    Text = "Les cartes ne vont pas dans la pile de défausse pendant la phase de défausse, elles restent en main"
  },
  State_20805_Name = {
    Text = "<RetainIconKeywords:Conservation>"
  },
  State_20806_Desc = {
    Text = "Après avoir joué, elle ne sera pas mise dans la défausse, mais retirée de la pioche"
  },
  State_20806_Name = {
    Text = "<DepleteIconKeywords:Consommation>"
  },
  State_20820_Desc = {
    Text = "Au début du prochain tour, ressuscitez et obtenez [Layer] points de vie et [Layer] bouclier"
  },
  State_20820_Name = {
    Text = "Résurrection différée"
  },
  State_20851_Name = {
    Text = "Octroi de Carte"
  },
  State_20981_Desc = {
    Text = "\"Le Scarlet\" s'est réveillé, augmentant significativement les dégâts infligés."
  },
  State_20981_Name = {
    Text = "You You Ha Xi Éveil!"
  },
  State_20981_WeaponDesc = {
    Text = "Au début du prochain tour, obtenez un bouclier équivalent à la vie perdue au tour précédent"
  },
  State_20982_Desc = {
    Text = "Cet éveilleur n'est pas encore éveillé... Il s'éveillera lorsqu'il sera sur le point d'être abattu, restaurera sa vie et commencera à se battre sous sa véritable forme"
  },
  State_20982_Name = {
    Text = "Non Réveillé"
  },
  State_20988_Desc = {
    Text = "Folie initiale +80. Gagnez 20 points de folie par tour"
  },
  State_20988_Name = {
    Text = "Davincity·Première Rencontre"
  },
  State_20989_Desc = {
    Text = "Fureur initiale +80. Gagne 2 points d'arithmétique par tour et 20 points de fureur"
  },
  State_20989_Name = {
    Text = "Turul · Première Rencontre"
  },
  State_21306_Desc = {
    Text = "Réinitialisation des combos chaque tour"
  },
  State_21306_Name = {
    Text = "Réinitialisation de la chaîne de coups"
  },
  State_21307_Desc = {
    Text = "Chaque couche ajoute une attaque, perd une couche en cas de dégâts, minimum 1 couche, perd toutes les couches à la fin du tour"
  },
  State_21307_Name = {Text = "Combo"},
  State_21342_Desc = {
    Text = "Au début du prochain tour, obtenez [Couche] de soins"
  },
  State_21342_Name = {
    Text = "Soins différés"
  },
  State_21345_Desc = {
    Text = "Avant le début de la Cérémonie de descente divine, après la mort, vous ressusciterez, dissiperez les états négatifs, serez immunisé aux dégâts et récupérerez 30 % de PV. Après le début de la Cérémonie de descente divine, après la mort, vous ressusciterez complètement, dissiperez les états négatifs et l'Obsession rituelle, et appellerez deux membres de votre clan."
  },
  State_21345_Name = {
    Text = "Rituel obsessionnel"
  },
  State_21358_Desc = {
    Text = "Le joueur n'a pas de limite de cartes en Main."
  },
  State_21381_Name = {
    Text = "Compteur d'utilisation des sceaux"
  },
  State_21385_Desc = {
    Text = "Chaque fois que vous perdez 1 point de vie, réduisez 1 couche. Lorsque le nombre de couches atteint 0, convertissez l'intention en une exultation de grande puissance qui lèvera l'effet de pétrification"
  },
  State_21385_Name = {
    Text = "Fureur du sang"
  },
  State_21450_Desc = {
    Text = "Au début du prochain tour, dissipez vos propres états négatifs."
  },
  State_21450_Name = {
    Text = "Purification différée"
  },
  State_21488_Desc = {
    Text = "Voir la logique de grève générale pour des effets spécifiques. __ \"Pour usage de développement uniquement\""
  },
  State_21492_Desc = {
    Text = "Les dégâts augmentent de 50% en cas de coup critique"
  },
  State_21492_Name = {
    Text = "<CardKeyWord:Critique>"
  },
  State_21546_Desc = {
    Text = "Au début du prochain tour, obtenez [Layer] bouclier"
  },
  State_21546_Name = {
    Text = "Bouclier de latence"
  },
  State_21547_Desc = {
    Text = "Au début du tour, conservez la moitié du bouclier"
  },
  State_21547_Name = {
    Text = "Résilience"
  },
  State_21548_Desc = {
    Text = "Au début du prochain tour, obtenez un renforcement"
  },
  State_21548_Name = {
    Text = "Renforcement retardé"
  },
  State_21580_Desc = {
    Text = "Le Chasseur de Crânes suit tes traces, chaque carte tirée lui donne [StateArg1] de force temporaire"
  },
  State_21580_Name = {Text = "Pister"},
  State_21587_Name = {
    Text = "Nouvel éveillé aléatoire trouvé ce tour"
  },
  State_21590_Name = {
    Text = "Essayer de trouver de nouveaux éveils"
  },
  State_21601_Name = {
    Text = "Nouveau corps éveillé trouvé"
  },
  State_21616_Desc = {
    Text = "Après avoir utilisé exalter, sceller tous les réveilleurs pendant un tour"
  },
  State_21616_Name = {
    Text = "Les restes du voyageur"
  },
  State_21671_Name = {
    Text = "Inflige des dégâts de zone __ \"Pour le Développement Seulement\""
  },
  State_21688_Name = {
    Text = "Peut être utilisé 1 fois."
  },
  State_21689_Name = {
    Text = "Peut être utilisé 2 fois."
  },
  State_21720_Desc = {
    Text = "Applique le même effet à l'éveillé derrière la cible. Si aucune entité éveillée ne se trouve derrière la cible, l'effet s'applique uniquement à la cible."
  },
  State_21720_Name = {
    Text = "<CardKeyWord:Perforation>"
  },
  State_21726_Desc = {
    Text = "<PVPWeaponKeywords:roue du destin>：Après que l'équipier ait utilisé son premier \"compétence\" chaque tour, mélange une copie d'un coût de calcul - [StateArg1] dans la pile de pioche"
  },
  State_21726_Name = {Text = "Pirouette"},
  State_21744_Name = {
    Text = "Essayer de trouver de nouveaux éveils"
  },
  State_21745_Name = {
    Text = "Nouveau corps éveillé trouvé"
  },
  State_21746_Name = {
    Text = "Nouvel éveillé aléatoire trouvé ce tour"
  },
  State_21747_Desc = {
    Text = "Il y a [Layer] Éveillés en cours de chasse. Chaque carte utilisée par un Éveillé chassé ajoute 1 marque de chasse au « Chasseur enragé »"
  },
  State_21747_Name = {
    Text = "Cérémonie de chasse"
  },
  State_21751_Desc = {
    Text = "Pioche la moitié des cartes des marques de chasse ([DescArg1]), +1 marque de chasse pour le «Chasseur enragé»"
  },
  State_21751_Name = {
    Text = "<CardKeyWord:Chassé>"
  },
  State_21754_Desc = {
    Text = "Lors de la mort, annulez tous les STR Temporaires de \"Chasseur de Crâne Déchaîné\" et divisez par deux les couches de son \"Marque de Chasse\"."
  },
  State_21754_Name = {
    Text = "Bref répit"
  },
  State_21765_Desc = {
    Text = "·Vous pouvez équiper une Roue du Destin à un Éveilleur allié, lui permettant d'utiliser l'effet de la Roue du Destin. \n ·Lorsqu'une Roue du Destin est équipée à un Éveilleur, l'ancienne Roue du Destin est détruite et la nouvelle est conservée. \n ·La Roue du Destin équipée sera détruite lorsque l'Éveilleur meurt. \n ·Si vous équipez une Roue du Destin à un Éveilleur mort, cette Roue du Destin sera détruite, et vous obtiendrez une Illusion ainsi que le coût en arithmética sera restitué."
  },
  State_21765_Name = {
    Text = "<PVPWeaponKeywords:Roulette du destin>"
  },
  State_21785_Name = {
    Text = "Cris de bataille"
  },
  State_21787_Name = {
    Text = "Ajouter des cris de bataille"
  },
  State_21826_Name = {
    Text = "Discours d'ouverture du chef des enfants"
  },
  State_21829_Name = {
    Text = "Râle Agonique"
  },
  State_21838_Name = {
    Text = "Introduction initiale"
  },
  State_21843_Name = {
    Text = "Ajouter un état au début"
  },
  State_21895_Name = {
    Text = "Appel d'ouverture"
  },
  State_21905_Desc = {
    Text = "\"L'Attaque\" gagne 2 Arithmetica et défausse 1 carte aléatoire ; \"La Défense\" tire 2 cartes et perd 1 Arithmetica."
  },
  State_21928_Name = {
    Text = "Avertissement"
  },
  State_22054_Name = {
    Text = "Appel d'ouverture"
  },
  State_22055_Desc = {
    Text = "Cet éveilleur n'est pas encore éveillé... Il s'éveillera lorsqu'il sera sur le point d'être abattu, restaurera sa vie et commencera à se battre sous sa véritable forme"
  },
  State_22055_Name = {
    Text = "Non Réveillé"
  },
  State_22067_Desc = {
    Text = "Après la fin du tour, une tentacule attaque [Layer] fois"
  },
  State_22067_Name = {
    Text = "Assemblage de tentacules"
  },
  State_22074_Desc = {
    Text = "Survivre au septième tour change l'intention en regard fixe, au huitième tour ou plus, change l'intention en profanation"
  },
  State_22134_Desc = {
    Text = "Inflige des Dommages au Bouclier du personnage, aux PV et à la Barrière de la cible simultanément."
  },
  State_22134_Name = {
    Text = "<CardKeyWord:Dégâts de perforation>"
  },
  State_22157_Desc = {
    Text = "Quand la vie est inférieure à 50% ([StateArg1]), elle se divise en \"Courants\" et \"Marées\" avec une vie égale"
  },
  State_22157_Name = {Text = "Fissure"},
  State_22204_Desc = {
    Text = "Au début du tour, obtient [Layer]% de taux critique temporaire et de dégâts critiques temporaires"
  },
  State_22204_Name = {
    Text = "Son doux s'intensifie"
  },
  State_22204_WeaponDesc = {
    Text = "Avant de perdre de la vie jusqu'au début du prochain tour, votre taux critique pour le prochain tour augmente de [StateArg1]%"
  },
  State_22210_Desc = {
    Text = "Consommation d'arethmetica + 100, et ne peut pas attaquer, ne peut pas obtenir de folie"
  },
  State_22210_Name = {Text = "Super Lent"},
  State_22238_Name = {
    Text = "Joueurs en duel mortel"
  },
  State_22239_Name = {
    Text = "Appliquer deathmatch joueur __ \"Pour le développement uniquement\""
  },
  State_22249_Desc = {
    Text = "Au début du prochain tour, piochez [Layer] cartes en moins"
  },
  State_22249_Name = {
    Text = "Échange Inégal"
  },
  State_22300_Desc = {
    Text = "Cette « Attaque » ne peut pas être jouée"
  },
  State_22300_Name = {
    Text = "La carte de frappe est désactivée et ne peut pas être jouée __ \"Pour développement uniquement\""
  },
  State_22303_Desc = {
    Text = "Chaque fois que vous subissez des dégâts, ajoutez une couche « ralentissement » aléatoire à une carte de votre main ; après avoir brisé le bouclier, supprimez l'état « bouclier de givre »"
  },
  State_22303_Name = {
    Text = "Bouclier de givre"
  },
  State_22324_Desc = {
    Text = "Pour chaque niveau, augmente d'une attaque ce tour"
  },
  State_22324_Name = {
    Text = "Écho de la vague de colère"
  },
  State_22325_Desc = {
    Text = "Après chaque attaque reçue, gagne [StateArg1] points de force temporaire"
  },
  State_22325_Name = {
    Text = "Sang de géant"
  },
  State_22326_Desc = {
    Text = "Tu es verrouillé ! Après que le marin de proche ait lancé, il obtient 1 niveau de folie temporaire, supprimant la marque rugissante de cette carte de commandement"
  },
  State_22326_Name = {
    Text = "<CardKeyWord: Marque rugissante>"
  },
  State_22328_Desc = {
    Text = "Chaque fois qu'une carte de commandement avec la « marque rugissante » est utilisée, les attaques de ce tour augmentent de 1"
  },
  State_22328_Name = {
    Text = "Écho de la vague de colère"
  },
  State_22334_Desc = {
    Text = "Chaque fois que vous jouez 1 carte « frappe », placez [StateArg1] cartes « blessures » au sommet de la pile de pioche"
  },
  State_22334_Name = {Text = "Trauma"},
  State_22404_Desc = {
    Text = "Les boucliers générés dans ce combat augmentent de [Layer] points"
  },
  State_22404_Name = {Text = "Alerte"},
  State_22405_Desc = {
    Text = "Les boucliers générés dans ce combat augmentent"
  },
  State_22405_Name = {
    Text = "<PVPAlertKeywords:alerte>"
  },
  State_22702_Desc = {
    Text = "La première carte \"Carte\" jouée chaque tour déclenche un effet supplémentaire"
  },
  State_22702_Name = {
    Text = "<CardKeyWord:Assaut>"
  },
  State_22706_Name = {
    Text = "Marque d'assaut"
  },
  State_22707_Desc = {
    Text = "Après chaque tour de jeu de cartes, appliquez un état Embuscade au joueur"
  },
  State_22707_Name = {
    Text = "Déclencheur d'embuscade"
  },
  State_22721_Name = {
    Text = "Pendule temporel«Perdu»"
  },
  State_23405_Desc = {
    Text = "Cet éveilleur n'est pas encore éveillé... Il s'éveillera lorsqu'il sera sur le point d'être abattu, obtiendra une force équivalente au nombre de niveaux de contre-attaque qu'il possède, restaurera sa vie et commencera à se battre sous sa véritable forme"
  },
  State_23405_Name = {
    Text = "Non Réveillé"
  },
  State_23406_Desc = {
    Text = "\"Le Demeurant de l'Abysse\" gagne [StateArg1] couches de Comptoir à la fin de chaque tour."
  },
  State_23406_Name = {
    Text = "Éveil de Kékes !"
  },
  State_23512_Name = {
    Text = "Accorder l'Illusion aux Mille Visages"
  },
  State_23514_Name = {
    Text = "Accorder l'Illusion aux Mille Visages"
  },
  State_23515_Name = {
    Text = "Accorder l'Illusion aux Mille Visages"
  },
  State_23516_Name = {
    Text = "Accorder l'Illusion aux Mille Visages"
  },
  State_23517_Name = {
    Text = "Donner un BUFF au joueur"
  },
  State_23518_Desc = {
    Text = "Appliquer 2 tours de vulnérabilité / Augmente 1 attaque / Appliquer une réduction de force."
  },
  State_23518_Name = {
    Text = "<CardKeyWord: Intention choisie>"
  },
  State_23519_Name = {
    Text = "Intention 2b"
  },
  State_23520_Name = {
    Text = "Intention 2c"
  },
  State_23521_Name = {
    Text = "Lors de la défausse, consommez, déduisez [StateArg1] Aliemus de tous les Corps éveillés, et mélangez 5 cartes « Symptôme » dans la Pioche"
  },
  State_23522_Name = {
    Text = "Défaussez pour consommer, retirez [StateArg1] Aliemus de tous les Corps éveillés"
  },
  State_23524_Name = {
    Text = "Intention 3a"
  },
  State_23525_Desc = {
    Text = "Cet éveilleur n'est pas encore éveillé... Il s'éveillera lorsqu'il sera sur le point d'être abattu, restaurera sa vie et commencera à se battre sous sa véritable forme"
  },
  State_23525_Name = {
    Text = "Non Réveillé"
  },
  State_23526_Name = {
    Text = "Intention 2a"
  },
  State_23527_Name = {
    Text = "Intention 3c"
  },
  State_23528_Name = {
    Text = "Intention 3b"
  },
  State_23529_Desc = {
    Text = "Augmente la force / Inflige des dégâts supplémentaires / Gagne un bouclier"
  },
  State_23529_Name = {
    Text = "<CardKeyWord: Intention choisie>"
  },
  State_23530_Desc = {
    Text = "Utilisez « mille mirages » nécessite deux choix d'intention. Si vous les défaussez, tous les réveilleurs perdent 20 de folie et 5 cartes « symptômes » sont ajoutées à la pile de pioche du joueur"
  },
  State_23530_Name = {
    Text = "Éveil de Davincity !"
  },
  State_23531_Name = {
    Text = "Accorder l'Illusion aux Mille Visages"
  },
  State_23532_Name = {
    Text = "Accorder l'Illusion aux Mille Visages"
  },
  State_23533_Desc = {
    Text = "Laver carte de symptôme / Appliquer saignement / Réduire folie"
  },
  State_23533_Name = {
    Text = "<CardKeyWord: Intention choisie>"
  },
  State_23534_Name = {
    Text = "Intention 1a"
  },
  State_23535_Name = {
    Text = "Intention 1c"
  },
  State_23536_Name = {
    Text = "Intention 1b"
  },
  State_23612_Desc = {
    Text = "Chaque fois que vous perdez 1 point de vie, réduisez 1 couche. Lorsque le nombre de couches atteint 0, convertissez l'intention en une exultation de grande puissance qui lèvera l'effet de pétrification"
  },
  State_23612_Name = {
    Text = "Fureur du sang·Fin"
  },
  State_23687_Name = {
    Text = "Pendule temporel «marées»"
  },
  State_23726_Desc = {
    Text = "Avant le prochain tour, empêche la mort de l'entité éveillée une fois, maximum 1 couche"
  },
  State_23726_Name = {
    Text = "Résistance à la mort"
  },
  State_23732_Desc = {
    Text = "Jusqu'au début du prochain tour, gagnez [Layer] <plural value=\"[Layer]\" singular=\"charge\" plural=\"charges\"> de <PainWord:Patience> pour chaque instance de Dégâts Directs reçus."
  },
  State_23732_Name = {
    Text = "Zone Interdite des Marais Noirs"
  },
  State_23736_Name = {
    Text = "Nombre de cartes tirées ce tour"
  },
  State_23737_Name = {
    Text = "Enregistrement du nombre de tirages"
  },
  State_23741_Name = {
    Text = "Appliquer le registre de tirage"
  },
  State_23744_Desc = {
    Text = "S'il n'y a pas de \"Mort\" sur le terrain, invoque un \"Mort\" au début du tour, chaque invocation augmente la vie"
  },
  State_23744_Name = {
    Text = "Rappel des morts"
  },
  State_23747_Name = {
    Text = "Renforcer la vie"
  },
  State_23748_Name = {
    Text = "Compteur d'invocation"
  },
  State_23769_Desc = {
    Text = "Cet éveilleur n'est pas encore éveillé... Il s'éveillera lorsqu'il sera sur le point d'être abattu, restaurera sa vie et commencera à se battre sous sa véritable forme"
  },
  State_23769_Name = {
    Text = "Non Réveillé"
  },
  State_23771_Desc = {
    Text = "\"Le Magicien\" s'est éveillé. Méfiez-vous des leurres créés par son \"Fantasme\". Pour chaque carte jouée par l'adversaire après l'éveil, Casiah gagne 1 couche de \"Fantasme\"."
  },
  State_23771_Name = {
    Text = "Cassia Éveil!"
  },
  State_23771_WeaponDesc = {
    Text = "Au début du prochain tour, obtenez un bouclier équivalent à la vie perdue au tour précédent"
  },
  State_23782_Desc = {
    Text = "Gagnez 10 couches de fantasme, videz le nombre de couches de « fantasme » et invoquez 1 clone devant vous, avec un maximum de 2 clones. Le clone invoqué portera 3 couches de <ParcloseIconKeywords: barrière>"
  },
  State_23782_Name = {Text = "Fantasme"},
  State_23786_Name = {
    Text = "État @réveilleur Casiah objets à distance"
  },
  State_23787_Name = {
    Text = "État @réveilleur Casiah @objets à distance @piger réduit"
  },
  State_23788_Desc = {
    Text = "Au début du tour 3, ajoutez 1 carte \"Échos du Passé—Défaussez toutes les cartes, réinitialisez la Vie et le Bouclier actuels à l'état de la fin du tour précédent. Conservez, Épuisez.\" à votre main."
  },
  State_23791_Name = {
    Text = "Message d'ouverture"
  },
  State_23823_Name = {Text = "Bombe 1"},
  State_23825_Name = {
    Text = "État @réveilleur Casiah @pouf"
  },
  State_23827_Desc = {
    Text = "Après avoir joué, perdez [DescArg1] points de santé maximum, le grand magicien obtient 1 couche de « se pavaner » pendant ce tour"
  },
  State_23827_Name = {
    Text = "<CardCheerKeywords:Applaudissements>"
  },
  State_23828_Desc = {
    Text = "Le grand magicien savoure maintenant sa performance, chaque niveau de \"fierté\" réduit l'effet de son sort et diminue sa puissance [DescArg1], jusqu'à un maximum de 5 niveaux"
  },
  State_23828_Name = {Text = "triomphal"},
  State_23871_Desc = {
    Text = "Augmenter les hp max n'augmente pas simultanément les hp actuels ; diminuer les hp max supprimera les hp actuels excédentaires, avec un maximum de hp de 1, sans réinitialisation après la mort."
  },
  State_23871_Name = {
    Text = "<MaxHPColour: Santé max>"
  },
  State_23934_Name = {
    Text = "État@Télékinésie: Surveillance des cartes en main"
  },
  State_23935_Name = {
    Text = "État @réveilleur Casiah effet d'objets à distance"
  },
  State_2393_Desc = {
    Text = "Cet éveilleur n'est pas encore éveillé... Il s'éveillera lorsqu'il sera sur le point d'être abattu, restaurera sa vie et commencera à se battre sous sa véritable forme"
  },
  State_2393_Name = {
    Text = "Non Réveillé"
  },
  State_2394_Name = {
    Text = "Pouvoir écarlate d'illuminer"
  },
  State_2395_Name = {
    Text = "Fête lointaine de l'accessoire"
  },
  State_2395_WeaponDesc = {
    Text = "\"La Défense\" augmente le bouclier de 30 %. Si le personnage équipé a plus de 15 % de chute de sigil noir, \"La Défense\" accorde un bouclier supplémentaire de 30 %."
  },
  State_2396_Desc = {
    Text = "Dégâts critiques augmentés de 20%. Les dégâts infligés aux ennemis avec bouclier sont toujours critiques"
  },
  State_2398_Desc = {
    Text = "En recevant des dégâts, gagnez un bouclier de [Layer], qui augmente à chaque coup et se régénère à la fin du tour"
  },
  State_2398_Name = {
    Text = "Barrière dimensionnelle"
  },
  State_2398_WeaponDesc = {
    Text = "Les dégâts actifs reçus augmentent de [Layer]. Chaque coup élargit la plaie corrodée, régénération au début du tour"
  },
  State_2399_Desc = {
    Text = "Après le rétablissement de vie, tous les réveilleurs gagnent 3 points d'aliemus. Après chaque 5e rétablissement de vie, les dégâts d'aliemus dans ce combat augmentent de [Arg1]"
  },
  State_2400_Desc = {
    Text = "Limite de tentacule augmentée de 1. Lorsque la vie est inférieure à 50%, les dégâts de tentacule augmentent de [StateArg1] points"
  },
  State_2400_Name = {
    Text = "Offrande passée de la création"
  },
  State_2400_WeaponDesc = {
    Text = "Limite de tentacule augmentée de 1. Lorsque la vie est inférieure à 50%, les dégâts de tentacule augmentent de [StateArg1] points"
  },
  State_2401_Desc = {
    Text = "Au début du tour, ajouter la carte du dessus de la pile de défausse à la main"
  },
  State_2402_Desc = {
    Text = "Au début du tour, pour chaque carte dans l'espace dimensionnel, gagnez [Arg1] points de force temporaire ce tour-ci"
  },
  State_2403_Desc = {
    Text = "Les boucliers infligés dans ce combat augmentent de [Layer] points"
  },
  State_2403_Name = {Text = "Alerte"},
  State_2403_WeaponDesc = {
    Text = "Les boucliers infligés dans ce combat augmentent de [Layer] points"
  },
  State_2404_Desc = {
    Text = "Lors de la collecte, supprimer 1 carte de symptôme. Augmenter le taux d'oraison de chance de 50%"
  },
  State_2405_Desc = {
    Text = "Changer temporairement la puissance de calcul de la carte"
  },
  State_2405_Name = {
    Text = "Changer temporairement la puissance de calcul de la carte"
  },
  State_2405_WeaponDesc = {
    Text = "Changer temporairement la puissance de calcul de la carte"
  },
  State_2406_Desc = {
    Text = "Lorsque tu épuises tes 1 dernier point de puissance arithmétique, tu obtiens 2 points de puissance. Peut être déclenché 2 fois par tour au maximum"
  },
  State_2407_Name = {
    Text = "Valeur observée"
  },
  State_2408_Name = {
    Text = "Sifflet de matelot"
  },
  State_2409_Desc = {
    Text = "Ce tour, chaque carte [Attaque] jouée réduit la consommation d'Arithmetica de 1."
  },
  State_2409_Name = {
    Text = "Lame Rebelle"
  },
  State_2409_WeaponDesc = {
    Text = "Ce tour, chaque carte [Attaque] jouée réduit la consommation d'Arithmetica de 1."
  },
  State_2410_Desc = {
    Text = "Incapable d'agir pendant 1 tour. Les ennemis pétrifiés ne peuvent pas être à nouveau soumis à l'effet de pétrification"
  },
  State_2410_Name = {
    Text = "<PetrifactionIconKeywords: Pétrification>"
  },
  State_2410_WeaponDesc = {
    Text = "Étourdissant le monstre pour un tour"
  },
  State_2411_Desc = {
    Text = "À la fin du tour, appliquez [Layer] niveaux de saignement à notre équipe"
  },
  State_2411_Name = {
    Text = "Lampe de sang"
  },
  State_2411_WeaponDesc = {
    Text = "À la fin du tour, appliquez [Layer] niveaux de saignement à notre équipe"
  },
  State_2412_Desc = {
    Text = "Dégâts doublés au prochain tour"
  },
  State_2412_Name = {
    Text = "Survivre dans l'adversité"
  },
  State_2412_WeaponDesc = {
    Text = "Dégâts doublés au prochain tour"
  },
  State_2413_Desc = {
    Text = "La folie obtenue par les coups et la défense réduite de [Layer] %"
  },
  State_2413_Name = {Text = "Vide"},
  State_2413_WeaponDesc = {
    Text = "La folie obtenue par les coups et la défense [StateArg1] %"
  },
  State_2415_Desc = {
    Text = "Si tu as subi des dégâts au tour précédent, gagne 1 tour d'immunité au début du tour"
  },
  State_2415_Name = {Text = "Adaptation"},
  State_2415_WeaponDesc = {
    Text = "Si tu as subi des dégâts au tour précédent, gagne 1 tour d'immunité au début du tour"
  },
  State_2416_Desc = {
    Text = "Les monstres qu'il invoque ont des PV et des dégâts doublés"
  },
  State_2416_Name = {
    Text = "\"Monde de sculptures de cire\""
  },
  State_2416_WeaponDesc = {
    Text = "Les monstres qu'il invoque ont des PV et des dégâts doublés"
  },
  State_24174_Desc = {
    Text = "Cette entité éveillée ne peut plus voir sa vie descendre en dessous de 1 à cause des dégâts"
  },
  State_24174_Name = {
    Text = "Immunité à la mort"
  },
  State_2418_Desc = {
    Text = "[exalter] accorde 30 points de folie à soi-même"
  },
  State_2418_Name = {
    Text = "Voile du Dieu de la Métamorphose"
  },
  State_2418_WeaponDesc = {
    Text = "[exalter] accorde 30 points de folie à soi-même"
  },
  State_2419_Name = {
    Text = "Miroir blanc des créations"
  },
  State_2420_Desc = {
    Text = "Ce tour, chaque carte [Défense] jouée réduit la consommation d'Arithmetica de 1."
  },
  State_2420_Name = {
    Text = "Cœur acéré"
  },
  State_2420_WeaponDesc = {
    Text = "Ce tour, chaque carte [Défense] jouée réduit la consommation d'Arithmetica de 1."
  },
  State_24210_Desc = {
    Text = "Ce tour-ci, les tentacules du Roi-Dieu attaquent tous les ennemis"
  },
  State_24210_Name = {
    Text = "Pays divin : Membre de poignet - Clé"
  },
  State_24211_Desc = {
    Text = "·À la fin du tour, inflige [DescArg4] fois [DescArg2] dégâts aux ennemis de la première ligne, si un ennemi est tué, augmente les dégâts de [DescArg3], max 5 fois (actuellement [DescArg6] fois).\n·Chaque fois que l'Éveilleur utilise l'Exaltation, effectue une attaque supplémentaire pendant ce tour.\n·Après que le Gardien utilise un Décret Clé, les attaques de ce tour ciblent tous les ennemis, et si c'est un Combat de Chef, les dégâts infligés par «Pays divin : Membre de poignet» augmentent de [DescArg5]."
  },
  State_24211_Name = {
    Text = "Pays divin : Membre de poignet"
  },
  State_24213_Name = {
    Text = "Si cette carte se trouve dans la main, gagnez 150 points de s-énergie à la fin du tour"
  },
  State_24214_Desc = {
    Text = "·À la fin du tour, inflige [DescArg2] dégâts aux ennemis de la première ligne"
  },
  State_24214_Name = {
    Text = "Pays divin : Membre de poignet"
  },
  State_24215_Desc = {
    Text = "·À la fin du tour, inflige [DescArg2] dégâts aux ennemis de la première ligne, si un ennemi est tué, augmente les dégâts de [DescArg3], max 5 fois (actuellement [DescArg4] fois)"
  },
  State_24215_Name = {
    Text = "Pays divin : Membre de poignet"
  },
  State_24217_Name = {
    Text = "Éliminer les états de <VulnerabilityIconKeywords:vulnérable>, <WeaknessIconKeywords:faiblesse>, et <FragileIconKeywords:fragile>"
  },
  State_24220_Name = {
    Text = "Obtenir [DescArg1] points de bouclier"
  },
  State_24222_Desc = {
    Text = "·À la fin du tour, infligez [DescArg4] fois [DescArg2] points de dégâts aux ennemis de la première ligne, si un ennemi est tué, augmentez les dégâts de [DescArg3], max 5 fois (actuellement [DescArg5] fois).\n·Chaque fois qu'un Éveilleur utilise une Exaltation, effectuez une attaque supplémentaire durant ce tour.\n·Chaque fois que le Gardien utilise un Décret Clé, les attaques de ce tour ciblent tous les ennemis."
  },
  State_24222_Name = {
    Text = "Pays divin : Membre de poignet"
  },
  State_24223_Desc = {
    Text = "·À la fin du tour, inflige [DescArg2] dégâts aux ennemis de la première ligne, si un ennemi est tué, augmente les dégâts de [DescArg3], max 5 fois (actuellement [DescArg4] fois).\n·Chaque fois que le Gardien utilise une Clé, les attaques de ce tour ciblent tous les ennemis"
  },
  State_24223_Name = {
    Text = "Pays divin : Membre de poignet"
  },
  State_24224_Desc = {
    Text = "·À la fin du tour, inflige [DescArg4] fois [DescArg2] points de dommages aux ennemis de la première ligne, si un ennemi est éliminé, augmente les dommages de [DescArg3], maximum 5 fois (actuellement [DescArg5] fois).\n·Chaque fois qu'un éveilleur utilise l'exaltation, déclenche une attaque supplémentaire dans ce tour."
  },
  State_24224_Name = {
    Text = "Pays divin : Membre de poignet"
  },
  State_24226_Desc = {
    Text = "·À la fin du tour, inflige [DescArg4] fois [DescArg2] dégâts aux ennemis de la première ligne, si un ennemi est tué, augmente les dégâts de [DescArg3], max 5 fois (actuellement [DescArg6] fois).\n·Chaque fois que le réveilleur utilise l'exalter, effectue une attaque supplémentaire ce tour.\n·Lors du combat contre le chef, chaque fois que le Gardien utilise un décret clé, les dégâts de « Pays divin : Membre de poignet » augmentent de [DescArg5]."
  },
  State_24226_Name = {
    Text = "Pays divin : Membre de poignet"
  },
  State_24227_Desc = {
    Text = "·À la fin du tour, inflige [DescArg2] points de dégâts aux ennemis de la première ligne, si un ennemi est tué, augmente les dégâts de [DescArg3], max 5 fois (actuellement [DescArg5] fois).\n·Après que le Gardien utilise un Décret Clé, les attaques de ce tour ciblent tous les ennemis, et en combat de chef, les dégâts causés par « Pays divin : Membre de poignet » augmentent également de [DescArg4]."
  },
  State_24227_Name = {
    Text = "Pays divin : Membre de poignet"
  },
  State_2422_Desc = {
    Text = "Après avoir joué, gagnez [StateArg1] points de bouclier"
  },
  State_2422_Name = {
    Text = "<Rune_6:Mur de fer>"
  },
  State_24245_Desc = {
    Text = "À la fin du tour, ressusciter tous les « descendance de l'hydre ». Chaque fois qu'une descendance meurt, réduire d'1 couche; si le nombre de couches atteint 0, l'« hydre » changera de forme pour engager la bataille finale"
  },
  State_24245_Name = {
    Text = "Maître des milliers de serpents"
  },
  State_24247_Desc = {
    Text = "Les dégâts reçus sont réduits de 90 %. Si au début du tour il n'y a pas de couches de « contrôle des mille serpents », suppression de cet état"
  },
  State_24247_Name = {
    Text = "Barrière en forme de serpent"
  },
  State_2425_Desc = {
    Text = "Après avoir joué, sera épuisée. Si c'est une carte de commande, ses dégâts et protections seront doublés"
  },
  State_2425_Name = {
    Text = "<CardKeyWord:Dissolution>"
  },
  State_2426_Desc = {
    Text = "La première carte que tu joues chaque tour a un effet supplémentaire, mais tu ne peux jouer que 4 cartes par tour"
  },
  State_2427_Name = {
    Text = "État@CléD'ArgentDesRêves:CompteurCœurDeSang"
  },
  State_2428_Desc = {
    Text = "Le nombre de <ParcloseIconKeywords:barrières> de la Fleur du Mal augmente de [Layer] couches"
  },
  State_2428_Name = {
    Text = "Barrière de rancœur"
  },
  State_2428_WeaponDesc = {
    Text = "Le nombre de barrières de la Fleur du Mal augmente de [Layer] couches"
  },
  State_24292_Name = {
    Text = "Déplacement du rang arrière vers l'avant"
  },
  State_24293_Name = {
    Text = "Reculer vers l'avant"
  },
  State_2429_Desc = {
    Text = "Tous les dégâts infligés sont réduits de [Layer] %"
  },
  State_2429_Name = {
    Text = "Réduction Temporaire de Dommages"
  },
  State_2429_WeaponDesc = {
    Text = "Tous les dégâts infligés sont réduits de [Layer] %"
  },
  State_2430_Desc = {
    Text = "Au début du combat, tous les alliés gagnent 3 couches de [Wax Armor]. À la fin du tour, cela inflige [Arg1] couches de Saignement à notre équipe."
  },
  State_2430_Name = {
    Text = "« Monsieur Cire »"
  },
  State_2430_WeaponDesc = {
    Text = "Au début du combat, tous les alliés gagnent 3 couches de [Wax Armor]. À la fin du tour, cela inflige [Arg1] couches de Saignement à notre équipe."
  },
  State_2431_Desc = {
    Text = "Équipe unique : Le bouclier et la régénération de vie infligés par le porteur augmentent de <WeaponEffect_Num:[StateArg1]%> de sa Constitution. Les contre-attaques infligées par le porteur augmentent de <WeaponEffect_Num:[StateArg3]%. En jouant « Défense », le porteur obtient également une contre-attaque équivalente à <WeaponEffect_Num:[StateArg4]%> de sa Défense. Après le début du combat, gagne une Force équivalente à <WeaponEffect_Num:[StateArg2]%> de sa Constitution. Si le royaume actuel est « Aequor », des Dégâts des tentacules équivalents sont également obtenus."
  },
  State_2431_WeaponDesc = {
    Text = "Le bouclier et les soins de l'équipé augmentent de <WeaponEffect_Num:[DescArg1]> points, la contre-attaque de l'équipé augmente de <WeaponEffect_Num:[StateArg3] %>, et en jouant « Défense », gagne également <WeaponEffect_Num:[Counterattack:DescArg3]> niveaux de <RetaliateIconKeywords:contre-attaque>. Au début du combat, obtenez <WeaponEffect_Num:[Power:DescArg2]> points de <PowerIconKeywords:force>. Si le royaume actuel est « Aequor », obtenez également des dégâts de tentacule équivalents."
  },
  State_2432_Desc = {
    Text = "Dégâts Directs et Dégâts des tentacules reçus +50%, retire 1 charge en fin de tour."
  },
  State_2432_Name = {
    Text = "<VulnerabilityIconKeywords: Vulnérable>"
  },
  State_2432_WeaponDesc = {
    Text = "Augmentation de tous les dégâts subis de 50 %"
  },
  State_2433_Desc = {
    Text = "À la fin de chaque tour, gagnez [Layer] points de force"
  },
  State_2433_Name = {Text = "colère"},
  State_2434_Name = {
    Text = "Anneau de la salle 36"
  },
  State_2434_WeaponDesc = {
    Text = "Lorsque vous tirez la carte du porteur, son coût d'arithmetica variera entre 0 et 3"
  },
  State_2435_Desc = {
    Text = "Événement19_2"
  },
  State_2435_Name = {
    Text = "Événement19_2"
  },
  State_2435_WeaponDesc = {
    Text = "Événement19_2"
  },
  State_2436_Desc = {
    Text = "La puissance et le bouclier obtenus sont réduits de 50%, pendant [Layer] tours"
  },
  State_2436_Name = {
    Text = "Malédiction temporaire"
  },
  State_2436_WeaponDesc = {
    Text = "Avant la fin du tour, immunisé contre les effets positifs"
  },
  State_2438_Desc = {
    Text = "État@Création: Compteur de la machine à différence argentée"
  },
  State_2438_Name = {
    Text = "État@Création: Compteur de la machine à différence argentée"
  },
  State_2438_WeaponDesc = {
    Text = "État@Création: Compteur de la machine à différence argentée"
  },
  State_2440_Name = {
    Text = "Pioche 1 carte"
  },
  State_2441_Name = {
    Text = "Gagnez 1 point d'arthmetica"
  },
  State_2442_Name = {
    Text = "Applique 1 couche <VulnerabilityIconKeywords:vulnérable> à tous les ennemis"
  },
  State_2443_Name = {
    Text = "Inflige 1 couche de <WeaknessIconKeywords:Faiblesse> à tous les ennemis"
  },
  State_2444_Name = {
    Text = "Obtenez <Energy:[DescArg1]> points de folie"
  },
  State_2445_Name = {
    Text = "Les autres éveillés gagnent <Energy:[DescArg1]> points de folie"
  },
  State_2446_Name = {
    Text = "Ajoutez 1 <DerivativeCardKeywords_4:\"Inspiration\"> à votre pile de pioche."
  },
  State_2447_Desc = {
    Text = "Équipe Unique : Le taux critique et les dégâts critiques des cartes d'instruction du porteur, ainsi que le bouclier, la régénération de PV, la fureur et la force qu'elles infligent, augmentent de <WeaponEffect_Num:[StateArg1] %>. Si le royaume actuel est « Ultra », après avoir lâché « Annihilation », obtenez <WeaponEffect_Num:[StateArg2]> points de fragment de clé. Après être entré dans le Tour Ultra, le prochain décret clé libéré ce tour-ci sera effectué 2 fois."
  },
  State_2447_WeaponDesc = {
    Text = "Le taux critique et les dégâts critiques des cartes d'instruction du porteur, ainsi que les boucliers, la guérison de vie, la fureur et la force causés par les cartes d'instruction augmentent de <WeaponEffect_Num:[StateArg1] %>. Si le royaume actuel est « Ultra », après avoir libéré « Annihilation », obtenez <WeaponEffect_Num:[StateArg2]> points de fragment de clé. Après être entré dans le tour ultra, le prochain décret clé sera libéré 2 fois ce tour-ci."
  },
  State_2448_Desc = {
    Text = "Les cartes ne vont pas dans la pile de défausse pendant la phase de défausse, elles restent en main"
  },
  State_2448_Name = {
    Text = "<CardKeyWord:Conserver>"
  },
  State_2449_Desc = {
    Text = "Après avoir subi des dégâts réels, gagnez un bouclier de [Layer]"
  },
  State_2449_Name = {Text = "tampon"},
  State_2449_WeaponDesc = {
    Text = "Après avoir subi des dégâts réels, gagnez un bouclier de [Layer]"
  },
  State_2450_Desc = {
    Text = "\"Frappe\" garantit un coup critique. Les dégâts critiques sont augmentés de 50%."
  },
  State_2451_Desc = {
    Text = "À la fin du tour, les autres alliés gagnent [Layer] points de force"
  },
  State_2451_Name = {
    Text = "« Feu de l'Aube »"
  },
  State_2452_Desc = {
    Text = "Après avoir joué, gagnez [StateArg1] points de force"
  },
  State_2452_Name = {
    Text = "<Rune_14_High:Force brute avancée>"
  },
  State_2453_Name = {
    Text = "Rituel photosynthétique de l'accessoire"
  },
  State_2453_WeaponDesc = {
    Text = "Après le début du combat, toutes les cartes du porteur obtiennent la conservation"
  },
  State_2454_Desc = {
    Text = "Après avoir joué, elle ne sera pas mise dans la défausse, mais retirée de la pioche"
  },
  State_2454_Name = {
    Text = "<DepleteIconKeywords:Consommation>"
  },
  State_2454_WeaponDesc = {
    Text = "Après avoir joué, la carte ne sera pas mise dans la défausse et ne pourra pas être utilisée à nouveau dans ce combat"
  },
  State_24556_Name = {
    Text = "État@HoudiniLeGrandMagicien@AjoutApplaudissementsSpectateurChanceux"
  },
  State_2455_Name = {
    Text = "État@danseur de flamme bleue illuminer 7"
  },
  State_24560_Desc = {
    Text = "À chaque fois que vous utilisez une clé, la fréquence critique temporaire et les dégâts critiques temporaires de ramona circulaire augmentent de 25 %"
  },
  State_24560_Name = {
    Text = "Voyageur de Klein"
  },
  State_24562_Desc = {
    Text = "Après la fin du tour, obtenir 1 couche de négentropie"
  },
  State_24562_Name = {
    Text = "Marcheur de Penrose"
  },
  State_24564_Desc = {
    Text = "À chaque fois que vous avez 3 couches de négentropie, jouer la carte de commandement de ramona circulaire dépense toute la négentropie et déclenche un effet supplémentaire de boucle, la négentropie pouvant s'accumuler jusqu'à 3 couches"
  },
  State_24564_Name = {
    Text = "Négentropie"
  },
  State_2456_Name = {
    Text = "État@danseur de flamme bleue illuminer 15"
  },
  State_2457_Name = {
    Text = "Pioche 1 carte"
  },
  State_24584_Name = {
    Text = "État@clone de N@changement d'état murmure1"
  },
  State_2458_Name = {
    Text = "État@artefact effet étreinte écarlate compteur"
  },
  State_24593_Desc = {
    Text = "Lorsque le nombre de couches est 0, modifiez l'intention en « appel noir », à la fin du tour, il sera réduit de 1 couche, pouvant aller jusqu'à 4 couches"
  },
  State_24593_Name = {Text = "Chaos"},
  State_24595_Desc = {
    Text = "Après la mort, réduit immédiatement de 1 couche de \"Chaos\" de \"N\""
  },
  State_24595_Name = {Text = "Diffusion"},
  State_24596_Desc = {
    Text = "Invoque un clone de \"N\" pour chaque niveau de \"Ténèbres\""
  },
  State_24596_Name = {Text = "ténèbres"},
  State_2460_Desc = {
    Text = "Équipe unique : Les dégâts de base infligés par l'équipementeur, ainsi que <IntoxicationIconKeywords:poison> et <RetaliateIconKeywords:contre-attaque> augmentent de <WeaponEffect_Num:[StateArg1]%>, et le taux critique et les dégâts critiques augmentent de <WeaponEffect_Num:[StateArg2]%"
  },
  State_2460_WeaponDesc = {
    Text = "L'attaquant augmente les dégâts de base causés de <WeaponEffect_Num:[StateArg1]%>, le <IntoxicationIconKeywords:poison> et le <RetaliateIconKeywords:comptoir> augmentent de <WeaponEffect_Num:[StateArg2]%>"
  },
  State_2461_Desc = {
    Text = "Lors de cette bataille, lorsque vous subissez des dégâts fatals, revivez, restaurez [Layer] points de vie et faites obtenir à tous les réveilleurs [StateArg1] points de folie. Cet effet est indissipable."
  },
  State_2461_Name = {
    Text = "Oiseau du Paradis Immortel"
  },
  State_2463_Desc = {
    Text = "Au début de la bataille, fusion d'embryon +20%. Pour chaque Réveilleur avec un aliemus complet, la fusion d'embryon augmente de 20% supplémentaires"
  },
  State_24640_Desc = {
    Text = "Après le début du combat, Fusion d'Embryon +[Blood:DescArg1], chaque fois que la Résistance à la mort est déclenchée, Fusion d'Embryon +[Blood:DescArg1]. Chaque fois que Sorel inflige des Dommages, les Dommages infligés par elle-même durant ce tour augmentent d'un montant égal à 4% de l'Attaque."
  },
  State_24640_Name = {Text = "Perle"},
  State_2464_Desc = {
    Text = "Puissance de calcul de carte augmentée"
  },
  State_2464_Name = {
    Text = "Augmentation permanente du pouvoir de calcul de la carte"
  },
  State_2464_WeaponDesc = {
    Text = "Puissance de calcul de carte augmentée"
  },
  State_24654_Desc = {
    Text = "Après que Daffodil ait tué un ennemi de quelque manière que ce soit, le taux de coup critique de l'équipe augmente définitivement de 5 % pour ce niveau, s'empilant jusqu'à 5 fois. (Actuellement empilé [DescArg1] fois)"
  },
  State_24654_Name = {
    Text = "Brouillard avide"
  },
  State_2466_Desc = {
    Text = "Jusqu'au début du prochain tour, pour chaque instance de dégâts reçus, la Tentacule contre-attaque l'attaquant une fois. Dommage temporaire des tentacules +[Layer]."
  },
  State_2466_Name = {
    Text = "[Discarded] Sang de l'hérésie"
  },
  State_24678_Name = {
    Text = "État@clone de N@changement d'état murmure2"
  },
  State_24679_Name = {
    Text = "État@clone de N3@changement d'état murmure6"
  },
  State_2467_Desc = {
    Text = "État @analyse offensive prologue"
  },
  State_2467_Name = {
    Text = "État @analyse offensive prologue"
  },
  State_2467_WeaponDesc = {
    Text = "État @analyse offensive prologue"
  },
  State_24680_Name = {
    Text = "État@clone de N2@changement d'état murmure1"
  },
  State_24681_Name = {
    Text = "État@clone de N@changement d'état murmure6"
  },
  State_24682_Name = {
    Text = "État@clone de N3@changement d'état murmure3"
  },
  State_24683_Name = {
    Text = "État@clone de N2@changement d'état murmure2"
  },
  State_24684_Name = {
    Text = "État@clone de N@changement d'état murmure4"
  },
  State_24685_Name = {
    Text = "État@clone de N@changement d'état murmure5"
  },
  State_24686_Name = {
    Text = "État@clone de N3@changement d'état murmure5"
  },
  State_24687_Name = {
    Text = "État@clone de N3@changement d'état murmure2"
  },
  State_24688_Name = {
    Text = "État@clone de N2@changement d'état murmure6"
  },
  State_24689_Name = {
    Text = "État@clone de N3@changement d'état murmure4"
  },
  State_24690_Name = {
    Text = "État@clone de N3@changement d'état murmure1"
  },
  State_24691_Name = {
    Text = "État@clone de N2@changement d'état murmure4"
  },
  State_24692_Name = {
    Text = "État@clone de N2@changement d'état murmure3"
  },
  State_24693_Name = {
    Text = "État@clone de N@changement d'état murmure3"
  },
  State_24694_Name = {
    Text = "État@clone de N2@changement d'état murmure5"
  },
  State_2470_Desc = {
    Text = "Lors de la collecte, perdre de manière permanente [Arg1] points de vigilance, les dégâts d'attaque infligés profitent d'un bonus de pouvoir multiplié par 1"
  },
  State_24719_Desc = {
    Text = "\"@2\"est apparu dans sa forme libérée, avec une Vie triplée."
  },
  State_24719_Name = {
    Text = "Résurrection du destin"
  },
  State_24719_WeaponDesc = {
    Text = "Au début du prochain tour, obtenez un bouclier équivalent à la vie perdue au tour précédent"
  },
  State_2471_Desc = {
    Text = "Au début du tour, notre équipe perd 1 alerte"
  },
  State_2471_Name = {Text = "Corrosion"},
  State_2471_WeaponDesc = {
    Text = "Au début du tour, notre équipe perd 1 alerte"
  },
  State_24720_Desc = {
    Text = "La puissance de l'entité inconnue reste enfouie sous la piscine noire, sur le point d'être vaincue, elle va ressusciter complètement et commencer à combattre sous la forme d'une libération"
  },
  State_24720_Name = {
    Text = "hibernation"
  },
  State_2472_Desc = {
    Text = "Infligez des dégâts simultanément au bouclier et aux points de vie, et ne peut être immunisé"
  },
  State_2472_Name = {
    Text = "<PunctureDamagewords:dégâts perforants>"
  },
  State_2472_WeaponDesc = {
    Text = "Les dommages par perforation ignorent les boucliers et les réductions de dégâts, infligeant des dégâts directs"
  },
  State_24730_Desc = {
    Text = "Augmentation temporaire de l'espace dimensionnel, limite de 10. Lors de la prochaine entrée dans le tour dimensionnel, les cartes de l'espace dimensionnel temporaire seront ajoutées à la main, et l'espace dimensionnel temporaire sera supprimé"
  },
  State_24730_Name = {
    Text = "<CardKeyWord:Espace dimensionnel temporaire>"
  },
  State_24737_Desc = {
    Text = "Au début du tour, infligez des saignements à l'adversaire, chaque niveau de destin inflige [StateArg1] points de saignement"
  },
  State_24737_Name = {Text = "Destin"},
  State_24738_Desc = {
    Text = "Chaque niveau de Destinée inflige [StateArg1] points de saignement, chaque carte jouée réduit un niveau de Destinée"
  },
  State_24738_Name = {Text = "Destin"},
  State_24739_Name = {Text = "Destin"},
  State_2473_Desc = {
    Text = "[Défense] perd 1 tentacule, régénère [StateArg1] PV. [Frappe] perd [StateArg2] PV, génère 1 tentacule"
  },
  State_2473_Name = {
    Text = "Chair de l'immortel de la création"
  },
  State_2473_WeaponDesc = {
    Text = "[Défense] perd 1 tentacule, régénère [StateArg1] PV. [Frappe] perd [StateArg2] PV, génère 1 tentacule"
  },
  State_2474_Desc = {
    Text = "Augmente l'attaque de [Layer]%"
  },
  State_2474_Name = {
    Text = "Augmentation en pourcentage de l'attaque générale"
  },
  State_2474_WeaponDesc = {
    Text = "Augmente l'attaque de [Layer]%"
  },
  State_2475_Desc = {
    Text = "Équipe unique : Les dégâts actifs infligés par le porteur sont augmentés de <WeaponEffect_Num:[StateArg3]%.> Après avoir joué ou défaussé 1 carte de commandement du porteur, infligez <WeaponEffect_Num:[StateArg1]%> de l'ATK du porteur en tant que <IntoxicationIconKeywords:Poison> à un ennemi aléatoire. Après la fin du tour ultra, il y a une chance de <WeaponEffect_Num:[StateArg2]%> de déclencher 100% de poison pour tous les ennemis."
  },
  State_2475_WeaponDesc = {
    Text = "Les Dégâts Directs du porteur +<WeaponEffect_Num:[DescArg2]> points. Après avoir joué ou défaussé 1 Carte d'instruction du porteur, infligez <WeaponEffect_Num:[DescArg1]> charges de <IntoxicationIconKeywords:Poison> à un ennemi aléatoire. À la fin du Tour Ultra, il y a <WeaponEffect_Num:[StateArg2]>% de chances de déclencher [DescArg3]% de Poison sur tous les ennemis."
  },
  State_2476_Name = {
    Text = "État@genèse connaissance illuminer 1"
  },
  State_2478_Desc = {
    Text = "Le bouclier appliqué par le nautile est doublé"
  },
  State_2478_Name = {
    Text = "Maître réparateur"
  },
  State_2478_WeaponDesc = {
    Text = "Le bouclier appliqué par le nautile est doublé"
  },
  State_2479_Desc = {
    Text = "Chaque fois que le Feu Vert inflige des dégâts, le nombre de couches augmente de 1"
  },
  State_2479_Name = {
    Text = "Comptage de l'image d'émeraude"
  },
  State_2479_WeaponDesc = {
    Text = "Chaque fois que le Feu Vert inflige des dégâts, le nombre de couches augmente de 1"
  },
  State_2480_Desc = {
    Text = "Récupérer de la vie donne [StateArg1] de contre-attaque. Pour chaque carte jouée par l’abyssal, récupère 1 point de vie"
  },
  State_2480_Name = {
    Text = "Corps en mutation"
  },
  State_2481_Desc = {
    Text = "État@PrologueRéinitialisationDeck0_2_3_1"
  },
  State_2481_Name = {
    Text = "État@PrologueRéinitialisationDeck0_2_3_1"
  },
  State_2481_WeaponDesc = {
    Text = "État@PrologueRéinitialisationDeck0_2_3_1"
  },
  State_2482_Desc = {
    Text = "Vie < 50 %, convoque un \"Triangle de corrosion\" avec la même vie"
  },
  State_2482_Name = {Text = "Invocation"},
  State_2482_WeaponDesc = {
    Text = "Vie < 50 %, convoque un \"Triangle de corrosion\" avec la même vie"
  },
  State_2486_Desc = {
    Text = "Au début du tour, pour chaque ennemi, gagne 1 arithmetica. Lorsque tu tues un ennemi par des dégâts actifs, inflige des dégâts de saignement égaux aux dégâts excédentaires à d'autres ennem"
  },
  State_24879_Desc = {
    Text = "Mille ans passent, dix mille ans passent, ils attendent dans les ruines éternelles. Après la mort, réduisez immédiatement 1 niveau de \"Chaos\" de \"N\", et donnez à \"N\" [DescArg1] points de bouclier et [DescArg2] points de force"
  },
  State_24879_Name = {
    Text = "Clone Illusoire"
  },
  State_2488_Desc = {
    Text = "Lorsque vous jouez une carte de buff, une carte de symptôme ou une carte d'état, l'éveillé avec le moins d'Aliemus gagne 10 Aliemus."
  },
  State_2489_Desc = {
    Text = "Augmente le taux critique de 10 %. Après le premier coup critique de chaque tour, le taux critique augmente de 20 %, et après avoir infligé le 3ème coup critique de chaque tour, les dégâts critiques augmentent de 50 %"
  },
  State_2490_Desc = {
    Text = "Chaque couche ajoute une attaque, perd une couche en cas de dégâts, perd toutes les couches à la fin du tour"
  },
  State_2490_Name = {Text = "Prière"},
  State_2491_Desc = {
    Text = "Lors de la récupération de PV, gagne un bouclier équivalent"
  },
  State_2491_Name = {
    Text = "Durcissement temporaire"
  },
  State_2492_Desc = {
    Text = "Immunisé aux premiers dégâts actifs chaque tour"
  },
  State_2492_Name = {
    Text = "Déterminé"
  },
  State_2492_WeaponDesc = {
    Text = "Immunisé aux premiers dégâts actifs chaque tour"
  },
  State_2493_Desc = {
    Text = "Réduisez les dégâts actifs de [Layer] points"
  },
  State_2493_Name = {
    Text = "Force réduite"
  },
  State_2494_Desc = {
    Text = "État@PrologueFolie0_1_4_1"
  },
  State_2494_Name = {
    Text = "État@PrologueFolie0_1_4_1"
  },
  State_2494_WeaponDesc = {
    Text = "État@PrologueFolie0_1_4_1"
  },
  State_2495_Desc = {
    Text = "État@PrologueFolie0_1_4_2"
  },
  State_2495_Name = {
    Text = "État@PrologueFolie0_1_4_2"
  },
  State_2495_WeaponDesc = {
    Text = "État@PrologueFolie0_1_4_2"
  },
  State_24968_Desc = {
    Text = "Après le début du combat, Fusion d'Embryon +[Blood:DescArg2], chaque fois que la Résistance à la mort est déclenchée, Fusion d'Embryon +[Blood:DescArg2]. Chaque fois que Sorel inflige des Dommages, les Dommages infligés par elle-même durant ce tour augmentent de [DescArg1] points."
  },
  State_24968_Name = {Text = "Perle"},
  State_2496_Desc = {
    Text = "Au début du tour, régénérez [Arg1] de vie. Si la vie est inférieure à 50%, régénérez [Arg2]"
  },
  State_2496_Name = {Text = "Sang Béni"},
  State_24976_Desc = {
    Text = "\"La Demoiselle Croissant\" s'est réveillée. Prenez garde aux dommages causés par ses plats spéciaux !"
  },
  State_24976_Name = {
    Text = "Galen Éveil!"
  },
  State_24976_WeaponDesc = {
    Text = "Au début du prochain tour, obtenez un bouclier équivalent à la vie perdue au tour précédent"
  },
  State_24977_Desc = {
    Text = "Cet éveilleur n'est pas encore éveillé... Il s'éveillera lorsqu'il sera sur le point d'être abattu, restaurera sa vie et commencera à se battre sous sa véritable forme"
  },
  State_24977_Name = {
    Text = "Non Réveillé"
  },
  State_2497_Desc = {
    Text = "Lily imitera la première carte d'instruction jouée par le joueur chaque tour. Si c'est une carte d'attaque, le nombre d'attaques de Lily augmente de 1. Si c'est une carte de défense, Lily obtient un bouclier de 10 % de ses PV. Pour les autres cartes d'instruction, Lily ne sait pas ce qui se passe et lâche d'abord une pustule ici."
  },
  State_2497_Name = {
    Text = "Lili Éveil!"
  },
  State_2497_WeaponDesc = {
    Text = "Au début du prochain tour, obtenez un bouclier équivalent à la vie perdue au tour précédent"
  },
  State_2498_Name = {
    Text = "Lapin maudit de l'accessoire"
  },
  State_2498_WeaponDesc = {
    Text = "Les boucliers et la régénération de vie infligés par le porteur augmentent de 6%. Si la maîtrise du domaine du porteur dépasse 50, les boucliers et la régénération de vie augmentent de 6% supplémentaires"
  },
  State_2499_Name = {
    Text = "Malédiction de stagnation"
  },
  State_2500_Desc = {
    Text = "Chaque fois que vous infligez des dégâts réels, ajoutez poison"
  },
  State_2500_Name = {Text = "Toxine"},
  State_2501_Desc = {
    Text = "Équipe Unique : La limite de vie de l'équipe augmente de 10%. Les soins et le bouclier infligés par l'équipé augmentent de <WeaponEffect_Num:[StateArg3]%. Après avoir joué l'« Attaque » de l'équipé, restaurez <WeaponEffect_Num:[StateArg1]%> de la vie perdue. Après avoir joué la « Défense » de l'équipé, obtenez un bouclier égal à <WeaponEffect_Num:[StateArg2]%> de la vie actuelle. Cet effet peut se déclencher jusqu'à 1 fois par tour pour chaque action."
  },
  State_2501_Name = {Text = "Âme née"},
  State_2501_WeaponDesc = {
    Text = "La limite de vie de l'équipe augmente de 10%. Les soins et le bouclier infligés par le porteur augmentent de <WeaponEffect_Num:[StateArg3]%. Après avoir joué l'« Attaque » du porteur, récupérez [StateArg1]% (<WeaponEffect_Num:[Heal:DescArg1]>) de vie perdue. Après avoir joué la « Défense » du porteur, obtenez un bouclier de [StateArg1]% (<WeaponEffect_Num:[Block:DescArg2]>) de la vie actuelle. Cet effet peut se déclencher au maximum 1 fois par tour."
  },
  State_2502_Desc = {
    Text = "Tous les Dégâts Directs et Dégâts des tentacules infligés -50%."
  },
  State_2502_Name = {
    Text = "Affaiblissement de l'extinction"
  },
  State_2502_WeaponDesc = {
    Text = "Réduisez tous les dégâts infligés de 50 %"
  },
  State_2503_Desc = {
    Text = "Équipe Unique : Les dégâts de base infligés par les cartes du porteur augmentent de <WeaponEffect_Num:[StateArg1]%>. Au début du tour, il y a <WeaponEffect_Num:[StateArg2]%> de chances de générer une carte aléatoire du porteur dans la main, avec une consommation supplémentaire. Si le royaume actuel est «Chair», l'utilisation de «Embryon» sur le porteur augmente le taux critique des dégâts causés par la prochaine carte d'attaque du porteur de <WeaponEffect_Num:+[StateArg3]%> ce tour."
  },
  State_2503_WeaponDesc = {
    Text = "Les dégâts de base infligés par les cartes du porteur augmentent de <WeaponEffect_Num:[StateArg1]%. Au début du tour, il y a <WeaponEffect_Num:[StateArg2]%> de chance de générer une carte aléatoire du porteur dans la main, avec une consommation supplémentaire. Si le royaume actuel est «Chair», lorsque le porteur utilise «Embryon», cela augmente le taux critique de la prochaine carte d'attaque infligée par le porteur ce tour de <WeaponEffect_Num:+[StateArg3]%>."
  },
  State_2504_Desc = {
    Text = "\"L'Attaque\" gagne 2 Arithmetica et défausse 1 carte aléatoire ; \"La Défense\" tire 2 cartes et perd 1 Arithmetica."
  },
  State_25056_Desc = {
    Text = "Chaque fois que vous consommez de l'arithmetica, donniez à Karen [Layer] points de pouvoir temporaire"
  },
  State_25056_Name = {
    Text = "Bien mangé et bien bu"
  },
  State_25057_Desc = {
    Text = "Chaque fois que vous consommez de l'arithmetica, donnez à Karen [StateArg1] points de pouvoir temporaire, 1 couche sera retirée à la fin du tour"
  },
  State_25057_Name = {
    Text = "Bien mangé et bien bu"
  },
  State_2505_Name = {
    Text = "Louange d'avril de l'accessoire"
  },
  State_2505_WeaponDesc = {
    Text = "Après le début du combat, si la classe du porteur est ultra, l'attaque augmente de 25 %"
  },
  State_2507_Desc = {
    Text = "Lors de la collecte, augmenter la santé max de 100%, au début du tour, perdre [Arg1] points de vie"
  },
  State_2509_Name = {
    Text = "État@Maîtrise du domaine générique"
  },
  State_2511_Desc = {
    Text = "État@PrologueEnseignementÉnergieClé"
  },
  State_2511_Name = {
    Text = "État@PrologueEnseignementÉnergieClé"
  },
  State_2511_WeaponDesc = {
    Text = "État@PrologueRéinitialisationDeck0_1_2_2"
  },
  State_2512_Desc = {
    Text = "En jouant une carte ayant un coût en arithmetica de 3 ou plus, tirez 1 carte et gagnez 1 en arithmetica"
  },
  State_2514_Desc = {
    Text = "Les boucliers infligés dans ce combat sont réduits de [Layer] points"
  },
  State_2514_Name = {
    Text = "Vigilance réduite"
  },
  State_2514_WeaponDesc = {
    Text = "Les boucliers infligés dans ce combat sont réduits de [Layer] points"
  },
  State_2515_Desc = {
    Text = "[Frappe] inflige [StateArg1] couches de poison à tous les ennemis"
  },
  State_2515_Name = {
    Text = "Neurotoxine des créations"
  },
  State_25163_Desc = {
    Text = "Il est aussi insaisissable que la brume"
  },
  State_25163_Name = {
    Text = "Ombre du passé"
  },
  State_25165_Desc = {
    Text = "Effet supplémentaire exclusif aux cartes de commandement de Ramona circulaire, déclenché lorsque vous avez 3 couches de négentropie. La boucle est transmise au combat suivant."
  },
  State_25165_Name = {
    Text = "<TimeBeacon:Boucle>"
  },
  State_25166_Desc = {
    Text = "À chaque fois que vous avez 3 couches de négentropie, jouer la carte de commandement de ramona circulaire dépense toute la négentropie et déclenche un effet supplémentaire de boucle, la négentropie pouvant s'accumuler jusqu'à 3 couches"
  },
  State_25166_Name = {
    Text = "<TimeBeacon2:négentropie>"
  },
  State_2516_Desc = {
    Text = "Impossible de jouer"
  },
  State_2516_Name = {
    Text = "Impossible à jouer"
  },
  State_2516_WeaponDesc = {
    Text = "Les cartes ne peuvent pas être jouées"
  },
  State_25179_Name = {
    Text = "Jugement de folie"
  },
  State_2517_Desc = {
    Text = "Après que notre équipe ait libéré l'exaltation, elle perdra son pouvoir lors de ce tour. Une fois par tour"
  },
  State_2517_Name = {
    Text = "Crainte de la folie"
  },
  State_25181_Name = {
    Text = "Effet de préservation de réincarnation"
  },
  State_2518_Desc = {
    Text = "État@PrologueRéinitialisationDeck0_1_1_3"
  },
  State_2518_Name = {
    Text = "État@PrologueRéinitialisationDeck0_1_1_3"
  },
  State_2518_WeaponDesc = {
    Text = "État@PrologueRéinitialisationDeck0_1_1_3"
  },
  State_25194_Desc = {
    Text = "Après la mort, ajoute [DescArg1] points de bouclier et [DescArg2] points de force permanente à \"N\""
  },
  State_2519_Desc = {
    Text = "État@PrologueRéinitialisationDeck0_1_1_3"
  },
  State_2519_Name = {
    Text = "État@PrologueRéinitialisationDeck0_1_1_3"
  },
  State_2519_WeaponDesc = {
    Text = "État@PrologueRéinitialisationDeck0_1_1_3"
  },
  State_25204_Name = {
    Text = "État @N doppelgänger 2 @détermination d'intention"
  },
  State_25205_Name = {
    Text = "État @N doppelgänger 3 @détermination d'intention"
  },
  State_25206_Name = {
    Text = "État@N@ajout de clone de N"
  },
  State_25207_Name = {
    Text = "État @N doppelgänger @détermination d'intention"
  },
  State_2520_Desc = {
    Text = "État@PrologueRéinitialisationDeck0_1_1_2"
  },
  State_2520_Name = {
    Text = "État@PrologueRéinitialisationDeck0_1_1_2"
  },
  State_2520_WeaponDesc = {
    Text = "État@PrologueRéinitialisationDeck0_1_1_2"
  },
  State_2522_Desc = {
    Text = "Hilote s'est déjà éveillée, sa puissance d'attaque et son désir seront augmentés"
  },
  State_2522_Name = {
    Text = "Éveil de Shiro"
  },
  State_2523_Desc = {
    Text = "Au début du tour impair, obtenez [Arg1] points de force pour ce tour. Au début du tour pair, obtenez [Arg2] points d'alerte pour ce tour."
  },
  State_2524_Desc = {
    Text = "Au début de la bataille, obtenez 1 pouvoir"
  },
  State_2524_Name = {
    Text = "Renommée éclatante"
  },
  State_2525_Desc = {
    Text = "1 attaque, +[Layer] force"
  },
  State_2525_Name = {
    Text = "Dissipation"
  },
  State_2527_Name = {
    Text = "Bonus de Force Écarlate"
  },
  State_2528_Desc = {
    Text = "En jouant une carte ayant un coût en arithmetica réel de 3, tirez 1 carte et gagnez 2 en arithmetica"
  },
  State_2529_Desc = {
    Text = "Ce tour, dégâts critiques augmentés de [Layer] %"
  },
  State_2529_Name = {
    Text = "Dommages critiques temporaires"
  },
  State_2529_WeaponDesc = {
    Text = "Ce tour, dégâts critiques augmentés de [Layer] %"
  },
  State_2531_Desc = {
    Text = "Chaque [Damage:StateArg2] fois que le feu émeraude inflige des dégâts, gagnez une carte consommable [Feu Vert]"
  },
  State_2531_Name = {
    Text = "Image Émeraude"
  },
  State_2531_WeaponDesc = {
    Text = "Chaque [Damage:StateArg2] fois que le feu émeraude inflige des dégâts, gagnez une carte consommable [Feu Vert]"
  },
  State_2532_Name = {
    Text = "Frisson écarlate de l'accessoire"
  },
  State_2534_Desc = {
    Text = "État@PrologueRéinitialisationDeck0_1_3_3"
  },
  State_2534_Name = {
    Text = "État@PrologueRéinitialisationDeck0_1_3_3"
  },
  State_2534_WeaponDesc = {
    Text = "État@PrologueRéinitialisationDeck0_1_3_3"
  },
  State_2535_Desc = {
    Text = "État@PrologueRéinitialisationDeck0_1_3_2"
  },
  State_2535_Name = {
    Text = "État@PrologueRéinitialisationDeck0_1_3_2"
  },
  State_2535_WeaponDesc = {
    Text = "État@PrologueRéinitialisationDeck0_1_3_2"
  },
  State_2536_Name = {
    Text = "État@augmentation des dégâts critiques des cartes de frappe temporaires"
  },
  State_2537_Desc = {
    Text = "Lorsque la lame illusoire applique un bouclier, elle obtient [StateArg2] points d'alerte temporaire"
  },
  State_2537_Name = {
    Text = "Perspicacité du champ de bataille"
  },
  State_2537_WeaponDesc = {
    Text = "Lorsque la lame illusoire applique un bouclier, elle obtient [StateArg2] points d'alerte temporaire"
  },
  State_2538_Desc = {
    Text = "Après avoir joué, obtenez [StateArg1] <RetaliateIconKeywords:Contre-attaque>, puis infligez des dégâts réels à tous les ennemis égaux à [StateArg2]% de votre <RetaliateIconKeywords:Contre-attaque>"
  },
  State_2538_Name = {
    Text = "<Rune_9_High:haut pique>"
  },
  State_25391_Desc = {
    Text = "Un membre éveillé est déjà sélectionné comme « Spectateur chanceux », toutes ses cartes ont l'effet « Applaudissements »"
  },
  State_25391_Name = {
    Text = "Spectateur chanceux"
  },
  State_25392_Desc = {
    Text = "Après avoir joué, perdez 2% de votre santé maximum, le grand magicien obtient 1 couche de « se pavaner » pendant ce tour"
  },
  State_25392_Name = {
    Text = "<CardCheerKeywords:Applaudissements>"
  },
  State_25401_Desc = {
    Text = "Cette carte augmente la limite de main de +1 lorsqu'elle est dans la main"
  },
  State_25401_Name = {
    Text = "Ignorer la limite de cartes en main"
  },
  State_25403_Desc = {
    Text = "Dégâts de tentacule réduits de 50%, chaque fois qu'un dégât de tentacule est causé, obtenir [Layer] points de bouclier"
  },
  State_25403_Name = {
    Text = "Océan Calme"
  },
  State_25405_Desc = {
    Text = "Cette carte reste toujours dans la main"
  },
  State_25405_Name = {
    Text = "Conserver définitivement"
  },
  State_25406_Desc = {
    Text = "Ce tour, impossible de changer de forme de tentacule"
  },
  State_25406_Name = {
    Text = "Folie des profondeurs·Limitée"
  },
  State_25407_Desc = {
    Text = "Dégâts de tentacule augmentés de 25% ; à la fin du tour, le nombre de tentacules -1"
  },
  State_25407_Name = {
    Text = "Folie des profondeurs"
  },
  State_25415_Desc = {
    Text = "Après avoir libéré le Sceau, gagnez [Layer] points d'énergie de clé"
  },
  State_25415_Name = {
    Text = ": Énergie temporaire du chaos débordante"
  },
  State_25417_Name = {Text = "Bombe 3"},
  State_25418_Name = {Text = "Bombe 2"},
  State_2542_Name = {
    Text = "Compteur de l'appendice sans nom des créations"
  },
  State_2543_Name = {
    Text = "État @niveau 2_14 bataille 8 bulle 1"
  },
  State_2544_Desc = {
    Text = "État@PrologueMonstrePassif"
  },
  State_2544_Name = {
    Text = "État@PrologueMonstrePassif"
  },
  State_2544_WeaponDesc = {
    Text = "État@PrologueMonstrePassif"
  },
  State_2545_Desc = {
    Text = "Au début de la bataille, fusion d'embryon +20%. Pour chaque Réveilleur avec un aliemus complet, la fusion d'embryon augmente de 20% supplémentaires"
  },
  State_2547_Desc = {
    Text = "Au début du tour, ajouter 1 \"trident\" ayant obtenu [Arg1] de pouvoir durant ce tour à la main. Après avoir exalter, augmenter le pouvoir de toutes les \"trident\" dans la main de [Arg2]"
  },
  State_2548_Desc = {
    Text = "Immunité à une mort, restaure 50 vie après activation et rend cette création invalide"
  },
  State_2548_Name = {
    Text = "Poupée de substitution des créations"
  },
  State_2548_WeaponDesc = {
    Text = "Immunité à une mort, restaure 50 vie après activation et rend cette création invalide"
  },
  State_2549_Desc = {
    Text = "Réduisez les dégâts infligés par les attaques et les tentacules"
  },
  State_2549_Name = {
    Text = "<ExhaustionIconKeywords: force réduite>"
  },
  State_2549_WeaponDesc = {
    Text = "Chaque niveau d'épuisement réduit les dégâts et dégâts de tentacule de 1 point"
  },
  State_2550_Desc = {
    Text = "Rend le joueur vulnérable 1 tour à la pioche. Rend tous les ennemis vulnérables 1 tour après utilisation. Non vendable"
  },
  State_2550_Name = {
    Text = "État: Effondrement de malédiction"
  },
  State_2550_WeaponDesc = {
    Text = "Rend le joueur vulnérable 1 tour à la pioche. Rend tous les ennemis vulnérables 1 tour après utilisation. Non vendable"
  },
  State_2552_Desc = {
    Text = "Les cartes ne vont pas dans la pile de défausse pendant la phase de défausse, elles restent en main"
  },
  State_2552_Name = {
    Text = "<RetainIconKeywords:Conservation>"
  },
  State_2552_WeaponDesc = {
    Text = "Les cartes ne vont pas dans la pile de défausse pendant la phase de défausse, elles restent en main"
  },
  State_2553_Desc = {
    Text = "Au début du tour, gagner 1 arithmetica"
  },
  State_2553_Name = {
    Text = "Créature d'arithmetica"
  },
  State_2553_WeaponDesc = {
    Text = "Au début du tour, gagner 1 arithmetica"
  },
  State_2554_Name = {
    Text = "Courrier matinal de Putney"
  },
  State_2556_Desc = {
    Text = "Après une baisse de santé, gagne un bouclier équivalent à [Layer]% de la valeur réduite"
  },
  State_2556_Name = {
    Text = "Bouclier de sang"
  },
  State_2556_WeaponDesc = {
    Text = "Après une baisse de santé, gagne un bouclier équivalent à [Layer]% de la valeur réduite"
  },
  State_2557_Desc = {
    Text = "Au début du prochain tour, gagnez [Layer] boucliers"
  },
  State_2557_Name = {
    Text = "Bouclier de douleur et plaisir"
  },
  State_2558_Desc = {
    Text = "Lorsque la vie est inférieure à 50% ([StateArg1]), elle se divisera en 2 \"corps dissous de type interférence\" ayant une vie équivalente"
  },
  State_2558_Name = {Text = "Fissure"},
  State_2558_WeaponDesc = {
    Text = "Lorsque la vie est inférieure à 50% ([StateArg1]), elle se divisera en 2 \"corps dissous de type II\" ayant une vie équivalente"
  },
  State_2559_Desc = {
    Text = "Après chaque attaque reçue, perd [Layer] points de force temporaire"
  },
  State_2559_Name = {
    Text = "Le Prix de l'Impulsion"
  },
  State_2560_Desc = {
    Text = "Au début du prochain tour, obtenez un bouclier de [Layer]"
  },
  State_2560_Name = {
    Text = "Création fermée"
  },
  State_2560_WeaponDesc = {
    Text = "Au début du prochain tour, obtenez un bouclier de [Layer]"
  },
  State_2561_Desc = {
    Text = "Talent mélancolique"
  },
  State_2561_Name = {
    Text = "Talent mélancolique"
  },
  State_2561_WeaponDesc = {
    Text = "Talent mélancolique"
  },
  State_2562_Name = {
    Text = "État@Chapitre 3_Résonance 1_Marque"
  },
  State_2563_Desc = {
    Text = "À la 10e carte jouée, augmentez les dégâts de tentacule de 2 et faites attaquer tous les tentacules une fois"
  },
  State_2563_Name = {
    Text = "Créature trident"
  },
  State_2563_WeaponDesc = {
    Text = "À la 10e carte jouée, augmentez les dégâts de tentacule de 2 et faites attaquer tous les tentacules une fois"
  },
  State_2564_Desc = {
    Text = "Tous les boucliers obtenus sont réduits de [DescArg1]%"
  },
  State_2564_Name = {
    Text = "<FragileColour:Fragile>"
  },
  State_2564_WeaponDesc = {
    Text = "Tous les boucliers obtenus sont réduits de 33%"
  },
  State_2565_Name = {
    Text = "Étreinte écarlate de l'accessoire"
  },
  State_2565_WeaponDesc = {
    Text = "Lorsque l'équipementeur cause des dégâts, il obtient 20 points de s-énergie, si des dégâts critiques sont infligés, il obtient plutôt 50 points de s-énergie, déclenche maximum 3 fois par tour"
  },
  State_2566_Desc = {
    Text = "Après avoir reçu 3 attaques en un tour, gagne 1 stack de Folie Temporaire."
  },
  State_2566_Name = {
    Text = "« Douleur douce »"
  },
  State_2567_Desc = {
    Text = "A subi [Layer] Dommages ; après avoir atteint 3 fois, «Douce Malveillance» gagne 1 stack de folie pour ce tour."
  },
  State_2567_Name = {
    Text = "Nombre de « Douleur Douce »"
  },
  State_2567_WeaponDesc = {
    Text = "A subi [Layer] fois des dégâts, après 3 fois, \"Démon Doux\" obtient 1 niveau de folie pour ce tour"
  },
  State_2569_Desc = {
    Text = "L'effet de bonus de recommandation de domaine est augmenté de 50 %, et votre maîtrise des domaines est augmentée de 100 au début du niveau"
  },
  State_2569_Name = {
    Text = "État@CléD'ArgentDesRêves:SéparationAdaptative"
  },
  State_2570_Desc = {
    Text = "Après avoir joué, pioche [StateArg1] cartes"
  },
  State_2570_Name = {
    Text = "<Rune_3:Habileté>"
  },
  State_2571_Desc = {
    Text = "Pour chaque réveilleur professionnel de type [chaos] dans l'équipe, la santé max (incomplète), la défense et l'attaque de toute l'équipe augmentent de 50%"
  },
  State_2571_Name = {
    Text = "Bonus de chaos"
  },
  State_2571_WeaponDesc = {
    Text = "Pour chaque réveilleur professionnel de type [chaos] dans l'équipe, la santé max (incomplète), la défense et l'attaque de toute l'équipe augmentent de 50%"
  },
  State_2572_Desc = {
    Text = "Après avoir joué, <EmbryoFusionIconKeywords:Fusion d'Embryon> +[StateArg1]."
  },
  State_2572_Name = {
    Text = "<Rune_12:Sanguinaire>"
  },
  State_2573_Desc = {
    Text = "Gagnez 5 couches de [Fuse]. Diminue de 1 lors de la joue d'une carte. Lorsque cela atteint 0, autodétruisez-vous, infligeant des dégâts d'Attaque * 2,5."
  },
  State_2573_Name = {
    Text = "Grenade explosive"
  },
  State_2573_WeaponDesc = {
    Text = "Gagnez 5 couches de [Fuse]. Diminue de 1 lors de la joue d'une carte. Lorsque cela atteint 0, autodétruisez-vous, infligeant des dégâts d'Attaque * 2,5."
  },
  State_2574_Desc = {
    Text = "Dégâts critiques +50 %. Si aucune attaque n'a été effectuée lors d'un tour, un coup critique est garanti au tour suivant."
  },
  State_2574_Name = {
    Text = "État@CléD'ArgentDesRêves:DanseCirculaire"
  },
  State_2575_Desc = {
    Text = "Équipe Unique : Au début du combat, pour chaque relique, le taux critique des cartes d'instruction du porteur augmente de [StateArg1]%. Après que le porteur ait libéré l'exaltation, il lance un dé à 4 faces, et le porteur obtient <WeaponEffect_Num:[StateArg2]> fois le nombre de points du dé en fureur et en dommages critiques temporaires. Si le résultat est de 4 ou plus, les autres Éveilleurs reçoivent également la moitié."
  },
  State_2575_WeaponDesc = {
    Text = "Au début du combat, pour chaque relique possédée, le taux critique des cartes de commande du porteur augmente de [StateArg1] %. Après que le porteur ait libéré l'exaltation, il lance un dé à 4 faces et obtient <WeaponEffect_Num:[StateArg2]> fois le résultat du dé en fureur et en dommages critiques temporaires; si le résultat est de 4 ou plus, les autres éveilleurs reçoivent également la moitié."
  },
  State_2576_Desc = {
    Text = "Chaque fois qu'une carte entre dans l'espace ultra, sa consommation en arithmetica est réduite de -1"
  },
  State_2579_Desc = {
    Text = "Augmente le nombre d'instances de Dégâts Directs infligés de [Layer] ce tour."
  },
  State_2579_Name = {
    Text = "Folie Temporaire"
  },
  State_2580_Desc = {
    Text = "Chaque fois qu'une carte de la sorcière chasseresse entre ou sort de l'espace ultra, gagnez 1 point d'arithmetica"
  },
  State_2580_Name = {
    Text = "Projection dimensionnelle"
  },
  State_2581_Desc = {
    Text = "La recharge de clé en argent de tous les réveilleurs augmente de 30. Après avoir libéré une clé, mélangez 3 cartes <DerivativeCardKeywords_4:« inspiration »> dans votre bibliothèque"
  },
  State_2581_Name = {
    Text = "État@pendule chronique discernement"
  },
  State_2582_Desc = {
    Text = "Augmentation des dégâts, bouclier et guérison de l'équipementeur de [StateArg1]%. (temporaire)"
  },
  State_2582_Name = {
    Text = "État@Folie du canon laser prototype"
  },
  State_2583_Desc = {
    Text = "Chaque fois que vous subissez des dégâts actifs, augmentez d'un niveau le compteur de votre équipe"
  },
  State_2583_Name = {
    Text = "État @venger géante dégât de décapitation compte"
  },
  State_2583_WeaponDesc = {
    Text = "Chaque fois que vous subissez des dégâts actifs, augmentez d'un niveau le compteur de votre équipe"
  },
  State_2584_Desc = {
    Text = "Chaque fois que le deck est réinitialisé, obtenir [Arg1] force"
  },
  State_2586_Desc = {
    Text = "Tous les boucliers obtenus sont réduits de 25%, une couche est retirée à la fin du tour"
  },
  State_2586_Name = {
    Text = "<FragileIconKeywords: Fragile>"
  },
  State_2586_WeaponDesc = {
    Text = "Tous les boucliers obtenus sont réduits de 25%"
  },
  State_2587_Desc = {
    Text = "Les blessures doublent les dégâts. Chaque fois que des dégâts réels sont infligés, on obtient [Layer] points de bouclier"
  },
  State_2587_Name = {
    Text = "« Dent de l'Avaleur Céleste »"
  },
  State_2587_WeaponDesc = {
    Text = "Les blessures doublent les dégâts. Chaque fois que des dégâts réels sont infligés, on obtient [Layer] points de bouclier"
  },
  State_2588_Desc = {
    Text = "Subissez [Layer] <FixedDamage:DGT Purs> et retirez cet état à la fin du tour. Lors de la restauration de PV, retirez un nombre de charges de Saignement égal au double des PV restaurés."
  },
  State_2588_Name = {
    Text = "Permanent <BleedingColour: Saignement>"
  },
  State_2588_WeaponDesc = {
    Text = "Après la fin du tour, subir [Layer] points de dégâts et retirer cet état; chaque guérison peut réduire de moitié le nombre de couches"
  },
  State_2589_Name = {
    Text = "Jumeaux tordus noirs de l'accessoire"
  },
  State_2589_WeaponDesc = {
    Text = "Après le début du tour impair, ajoutez une carte « frappe » au joueur avec illusion et épuiser"
  },
  State_2590_Desc = {
    Text = "Obtenez 10 sigils noirs en vous déplaçant"
  },
  State_2590_Name = {
    Text = "Sac sans fond de Création"
  },
  State_2590_WeaponDesc = {
    Text = "Obtenez 10 sigils noirs en vous déplaçant"
  },
  State_2592_Desc = {
    Text = "Pour chaque point de vie perdu, retirez une couche. À zéro couche, gagnez un bouclier de [DescArg1]"
  },
  State_2592_Name = {
    Text = "Barrière dimensionnelle"
  },
  State_2593_Name = {
    Text = "État@Chant du sang et du sable écarlate"
  },
  State_2594_Desc = {
    Text = "Obtenez un bouclier après avoir infligé des dégâts réels"
  },
  State_2594_Name = {
    Text = "« Dent de l'Avaleur Céleste »"
  },
  State_2594_WeaponDesc = {
    Text = "Obtenez un bouclier après avoir infligé des dégâts réels"
  },
  State_2595_Desc = {
    Text = "Chaque fois qu'un dommage est infligé, obtenez [StateArg2] points de force temporaire"
  },
  State_2595_Name = {
    Text = "Éveil de l'épée de la reine des sages"
  },
  State_2597_Desc = {
    Text = "Au début du tour, gagnez [Layer] points de bouclier"
  },
  State_2597_Name = {
    Text = "Bouclier de latence"
  },
  State_2597_WeaponDesc = {
    Text = "Au début du tour, gagnez [Layer] points de bouclier"
  },
  State_2600_Desc = {
    Text = "Chaque fois que vous perdez des PV, l'éveillé avec le moins de folie gagne 10 folie. Chaque 5 pertes de PV, gagnez 1 barrière"
  },
  State_2600_Name = {
    Text = "Pendule Temporel « Analyse »"
  },
  State_2601_Desc = {
    Text = "Les tours paires, les dégâts subis sont réduits de 50 %, les dégâts infligés augmentent de 33 %"
  },
  State_2601_Name = {Text = "Capricieux"},
  State_2601_WeaponDesc = {
    Text = "Les tours paires, les dégâts subis sont réduits de 50 %, les dégâts infligés augmentent de 33 %"
  },
  State_2602_Desc = {
    Text = "Tu es ciblé ! Après activation, le Fanatique Éternel gagne [StateArg1] points de force temporaire, retire la marque de plongée de cette commande"
  },
  State_2602_Name = {
    Text = "<CardKeyWord:Marque de la plongée>"
  },
  State_2602_WeaponDesc = {
    Text = "Après avoir joué la carte, l'élite du plongeur obtient [StateArg1] points de force temporaire"
  },
  State_2603_Desc = {
    Text = "Si \"Embryon\" est dans ta main, épuise tous les \"Embryons\". Chaque \"Embryon\" déclenche l'effet suivant une fois."
  },
  State_2603_Name = {
    Text = "<UnlimitedDevouredIconKeywords:Dévoration infinie>"
  },
  State_2604_Desc = {
    Text = "Le taux critique augmente de [Layer] % pendant ce tour"
  },
  State_2604_Name = {
    Text = "Taux de coup critique temporaire"
  },
  State_2604_WeaponDesc = {
    Text = "Le taux critique augmente de [Layer] % pendant ce tour"
  },
  State_2605_Desc = {
    Text = "Quand la vie est inférieure à 95% ([StateArg1]), elle se divise en 2 \"Œuvres expérimentales\" avec une vie égale"
  },
  State_2605_Name = {Text = "Fissure"},
  State_2605_WeaponDesc = {
    Text = "Lorsque la vie est inférieure à 30 % ([StateArg1]), elle se divisera en 3 sculptures de cire de type II avec une vie équivalente"
  },
  State_2606_Desc = {
    Text = "Quand la vie est inférieure à 90% ([StateArg1]), elle se divise en 2 \"Œuvres expérimentales\" avec une vie égale"
  },
  State_2606_Name = {Text = "Fissure"},
  State_2606_WeaponDesc = {
    Text = "Lorsque la vie est inférieure à 30 % ([StateArg1]), elle se divisera en 3 sculptures de cire de type II avec une vie équivalente"
  },
  State_2607_Desc = {
    Text = "À la fin du combat, récupérez 5 points de vie"
  },
  State_2607_Name = {
    Text = "Servante à croissant lunaire, éclaire 3"
  },
  State_2607_WeaponDesc = {
    Text = "À la fin du combat, récupérez 5 points de vie"
  },
  State_2609_Desc = {
    Text = "Quand la vie est inférieure à 30% ([StateArg1]), elle se divise en 2 \"Œuvres expérimentales\" avec une vie égale"
  },
  State_2609_Name = {Text = "Fissure"},
  State_2609_WeaponDesc = {
    Text = "Lorsque la vie est inférieure à 30 % ([StateArg1]), elle se divisera en 3 sculptures de cire de type II avec une vie équivalente"
  },
  State_2610_Desc = {
    Text = "Quand la vie est inférieure à 70% ([StateArg1]), elle se divise en 2 \"Œuvres expérimentales\" avec une vie égale"
  },
  State_2610_Name = {Text = "Fissure"},
  State_2610_WeaponDesc = {
    Text = "Lorsque la vie est inférieure à 30 % ([StateArg1]), elle se divisera en 3 sculptures de cire de type II avec une vie équivalente"
  },
  State_2611_Desc = {
    Text = "Quand la vie est inférieure à 50% ([StateArg1]), elle se divise en 2 \"Œuvres expérimentales\" avec une vie égale"
  },
  State_2611_Name = {Text = "Fissure"},
  State_2611_WeaponDesc = {
    Text = "Lorsque la vie est inférieure à 30 % ([StateArg1]), elle se divisera en 3 sculptures de cire de type II avec une vie équivalente"
  },
  State_2612_Desc = {
    Text = "Imitation de l'Ancien"
  },
  State_2612_Name = {
    Text = "Imitation de l'Ancien"
  },
  State_2612_WeaponDesc = {
    Text = "Imitation de l'Ancien"
  },
  State_2614_Desc = {
    Text = "Équipe unique : Après avoir joué une carte de commandement de l'équipement, il y a <WeaponEffect_Num:[StateArg1]%> de chances de la remettre dans la main depuis la pile de défausse. Cet effet ne peut se produire qu'une fois par tour"
  },
  State_2614_WeaponDesc = {
    Text = "Après avoir joué la carte de commandement de l'équipier, il y a une probabilité de <WeaponEffect_Num:[StateArg1]%> de la réintégrer dans votre main depuis la pile de défausse. Cet effet ne fonctionne qu'une seule fois par tour"
  },
  State_2617_Desc = {
    Text = "Au début du prochain tour, piocher [DescArg1] Carte(s) supplémentaire(s)."
  },
  State_2617_Name = {
    Text = "Symptôme : Excitation"
  },
  State_2619_Desc = {
    Text = "Les dégâts actifs infligés dans ce combat sont réduits de [Layer] points"
  },
  State_2619_Name = {
    Text = "Force réduite"
  },
  State_2619_WeaponDesc = {
    Text = "Les dégâts infligés dans ce combat sont réduits de [Layer] points"
  },
  State_2620_Desc = {
    Text = "Scalpel rouillé de la création"
  },
  State_2620_Name = {
    Text = "Lame de Saule Rouillée"
  },
  State_2623_Desc = {
    Text = "Au début du tour, gagner 1 arithmetica"
  },
  State_2624_Desc = {
    Text = "Après avoir joué, fait perdre à tous les ennemis [StateArg1] points de force temporaire"
  },
  State_2624_Name = {
    Text = "<Rune_18:Épuisement>"
  },
  State_2625_Desc = {
    Text = "Ton effet de saut se déclenche deux fois. En entrant dans le tour hyperdimensionnel, tous les ennemis gagnent 5 points de force temporaire"
  },
  State_2625_Name = {
    Text = "Lampe de cauchemar des créations"
  },
  State_2626_Desc = {
    Text = "Limite de tentacules -1. À la fin du tour, tous les tentacules attaquent une fois de plus"
  },
  State_2627_Name = {
    Text = "Obtenez [StateArg1] points d'énergie de clé"
  },
  State_2627_WeaponDesc = {
    Text = "Au nœud \"Statue inachevée\", les cartes choisies obtiennent l'énergie clé"
  },
  State_2628_Desc = {
    Text = "La carte copiée au « sujet de la sculpture inachevée » obtient un effet d'oraison"
  },
  State_2628_Name = {
    Text = "État@Chapitre 2_Résonance 3"
  },
  State_2628_WeaponDesc = {
    Text = "La carte copiée au nœud « sujet de la sculpture inachevée » obtient un effet d'oraison"
  },
  State_2629_Desc = {
    Text = "À la \"Statue inachevée\", la gamme de cartes copiables augmente"
  },
  State_2629_Name = {
    Text = "État@Chapitre 2_Résonance 2"
  },
  State_2629_WeaponDesc = {
    Text = "Au nœud \"Statue inachevée\", les cartes copiées et leurs originales obtiennent l'effet \"Inné\""
  },
  State_2630_Desc = {
    Text = "À la \"Statue inachevée\", les cartes copiées et leurs originales obtiennent l'effet \"Conserver\""
  },
  State_2630_Name = {
    Text = "État@Chapitre 2_Résonance 4"
  },
  State_2630_WeaponDesc = {
    Text = "Au nœud \"Statue de cire inachevée\", les cartes copiées et leurs originales obtiennent l'effet \"Garder\""
  },
  State_2631_Desc = {
    Text = "À la \"Statue inachevée\", copiez une carte supplémentaire"
  },
  State_2631_Name = {
    Text = "État@Chapitre 2_Résonance 6"
  },
  State_2631_WeaponDesc = {
    Text = "Au nœud \"Statue inachevée\", copiez une carte supplémentaire"
  },
  State_2633_Desc = {
    Text = "Chaque fois que des Dégâts Directs sont reçus, ajoutez 1 [Flamme verte] avec Épuisement dans la main pendant [Layer] <plural value=\"[Layer]\" singular=\"tour\" plural=\"tours\">."
  },
  State_2633_Name = {
    Text = "Feu d'attraction des papillons"
  },
  State_2633_WeaponDesc = {
    Text = "Avant le prochain tour, chaque attaque subie ajoute une carte de consommation [Flamme verte] à votre main"
  },
  State_2634_Desc = {
    Text = "Lorsque vous jouez une carte, subissez [StateArg1] points de dégâts et retirez 1 couche. Lorsque les couches sont à 0, éclosez une «Créature des Mers» plus faible. Si l'état de parasitisme persiste à la fin du tour, éclosez une «Créature des Mers» dont la vie augmente avec les couches"
  },
  State_2634_Name = {Text = "Parasité"},
  State_2635_Desc = {
    Text = "État@marque d'analyse offensive du prologue"
  },
  State_2635_Name = {
    Text = "État@marque d'analyse offensive du prologue"
  },
  State_2635_WeaponDesc = {
    Text = "État@marque d'analyse offensive du prologue"
  },
  State_2636_Name = {
    Text = "État@Chapitre 4_Résonance@Tour suivant: Pioche 1"
  },
  State_2637_Desc = {
    Text = "Au début du tour, gagner [StateArg1] arithmetica"
  },
  State_2637_Name = {
    Text = "Injecteur actif des créations"
  },
  State_2637_WeaponDesc = {
    Text = "Au début du tour, gagner [StateArg1] arithmetica"
  },
  State_2639_Desc = {
    Text = ": Lorsqu'une blessure fatale est subie au combat, il y a une probabilité de conserver 1 point de vie. Une fois déclenchée, la probabilité est réduite de moitié dans cette enquête, et la résistance à la mort obtenue est réduite de moitié"
  },
  State_2639_Name = {
    Text = "<DeathResistanceIconKeywords:Résistance à la mort>"
  },
  State_2640_Name = {
    Text = "Effet répété général 1 fois"
  },
  State_2645_Desc = {
    Text = "État@PrologueMonstrePassif1"
  },
  State_2645_Name = {
    Text = "État@PrologueMonstrePassif1"
  },
  State_2645_WeaponDesc = {
    Text = "État@PrologueMonstrePassif1"
  },
  State_2646_Desc = {
    Text = "État@PrologueMonstrePassif2"
  },
  State_2646_Name = {
    Text = "État@PrologueMonstrePassif2"
  },
  State_2646_WeaponDesc = {
    Text = "État@PrologueMonstrePassif2"
  },
  State_2647_Desc = {
    Text = "État@PrologueMonstrePassif3"
  },
  State_2647_Name = {
    Text = "État@PrologueMonstrePassif3"
  },
  State_2647_WeaponDesc = {
    Text = "État@PrologueMonstrePassif3"
  },
  State_2648_Desc = {
    Text = "État@PrologueMonstrePassif4"
  },
  State_2648_Name = {
    Text = "État@PrologueMonstrePassif4"
  },
  State_2648_WeaponDesc = {
    Text = "État@PrologueMonstrePassif4"
  },
  State_2649_Desc = {
    Text = "État@PrologueMonstrePassif5"
  },
  State_2649_Name = {
    Text = "État@PrologueMonstrePassif5"
  },
  State_2649_WeaponDesc = {
    Text = "État@PrologueMonstrePassif5"
  },
  State_2650_Desc = {
    Text = "État@PrologueMonstrePassif6"
  },
  State_2650_Name = {
    Text = "État@PrologueMonstrePassif6"
  },
  State_2650_WeaponDesc = {
    Text = "État@PrologueMonstrePassif6"
  },
  State_2651_Desc = {
    Text = "État@PrologueMonstrePassif7"
  },
  State_2651_Name = {
    Text = "État@PrologueMonstrePassif7"
  },
  State_2651_WeaponDesc = {
    Text = "État@PrologueMonstrePassif7"
  },
  State_2652_Desc = {
    Text = "État@PrologueMonstrePassif8"
  },
  State_2652_Name = {
    Text = "État@PrologueMonstrePassif8"
  },
  State_2652_WeaponDesc = {
    Text = "État@PrologueMonstrePassif8"
  },
  State_2653_Desc = {
    Text = "État@PrologueMonstrePassif9"
  },
  State_2653_Name = {
    Text = "État@PrologueMonstrePassif9"
  },
  State_2653_WeaponDesc = {
    Text = "État@PrologueMonstrePassif9"
  },
  State_2655_Desc = {
    Text = "Restaurez une quantité égale de vie en infligeant des dégâts non bloqués, retirez après avoir infligé des dégâts"
  },
  State_2655_Name = {Text = "Vampirisme"},
  State_2656_Desc = {
    Text = "Fuyez dès le début du prochain tour！！！！"
  },
  State_2656_Name = {Text = "Fuir"},
  State_2660_Desc = {
    Text = "Au début du combat, obtenez du pouvoir, mais les dégâts reçus augmentent de 5 à chaque fois"
  },
  State_2660_Name = {
    Text = "Dos à l'eau"
  },
  State_2661_Desc = {
    Text = "Au début du combat, tous les ennemis perdent [Arg1] points de pouvoir"
  },
  State_2662_Name = {
    Text = "État@Chapitre 3_Test"
  },
  State_2663_Desc = {
    Text = "Lorsque vous le piochez, vous êtes affaibli pendant 1 tour. Après usage, affaiblissez tous les ennemis pendant 1 tour. Ne peut pas être vendu"
  },
  State_2663_Name = {
    Text = "État: Affaiblissement de malédiction"
  },
  State_2663_WeaponDesc = {
    Text = "Lorsque vous le piochez, vous êtes affaibli pendant 1 tour. Après usage, affaiblissez tous les ennemis pendant 1 tour. Ne peut pas être vendu"
  },
  State_2666_Name = {
    Text = "Taux critique du poignard de réincarnation"
  },
  State_2667_Desc = {
    Text = "Dégâts des cartes de coup augmentés de [Layer] %"
  },
  State_2667_Name = {
    Text = "Dégâts des cartes de coup augmentés"
  },
  State_2667_WeaponDesc = {
    Text = "Dégâts des cartes de coup augmentés de [Layer] %"
  },
  State_2668_Desc = {
    Text = "Augmente l'attaque de [Layer]%"
  },
  State_2668_Name = {
    Text = "Augmentation permanente en pourcentage de l'attaque générale"
  },
  State_2668_WeaponDesc = {
    Text = "Augmente l'attaque de [Layer]%"
  },
  State_2669_Desc = {
    Text = "Dans ce combat, les dégâts critiques augmentent de [Layer] %"
  },
  State_2669_Name = {
    Text = "Dégâts Critiques"
  },
  State_2670_Desc = {
    Text = "Lorsque tu infliges une faiblesse, tu obtiens [Arg1] points de bouclier ; en infligeant une vulnérabilité, tu obtiens [Arg2] points de pouvoir. Si ces deux effets sont déclenchés en un tour, tu obtiens en plus [Arg1] points de bouclier et [Arg2] points de pouvoir"
  },
  State_2670_Name = {
    Text = "Cadre lourd"
  },
  State_2671_Desc = {
    Text = "Cet éveilleur n'est pas encore éveillé... Il s'éveillera lorsqu'il sera sur le point d'être abattu, restaurera sa vie et commencera à se battre sous sa véritable forme"
  },
  State_2671_Name = {
    Text = "Non Réveillé"
  },
  State_2672_Desc = {
    Text = "Au début de chaque tour, appliquez des couches de \"Contrainte\" à votre équipe"
  },
  State_2672_Name = {Text = "Contrainte"},
  State_2672_WeaponDesc = {
    Text = "Au début de chaque tour, appliquez des couches de \"Contrainte\" à votre équipe"
  },
  State_2674_Desc = {
    Text = "Le taux critique augmente de [Layer] % pendant ce tour"
  },
  State_2674_Name = {
    Text = "Taux de coup critique temporaire"
  },
  State_2676_Name = {
    Text = "Frisson écarlate de l'accessoire"
  },
  State_2676_WeaponDesc = {
    Text = "Après avoir libéré la clé, le porteur obtient 15 % de taux critique temporaire. Si le porteur a des dégâts critiques supérieurs à 80 %, il obtient 15 % supplémentaires de taux critique temporaire"
  },
  State_2677_Desc = {
    Text = "Les 3 premiers dégâts actifs/tentacules reçus chaque tour sont réduits de 75 %"
  },
  State_2677_Name = {
    Text = "« Corps Indestructible »"
  },
  State_2677_WeaponDesc = {
    Text = "Les 3 premiers dégâts actifs/tentacules reçus chaque tour sont réduits de 75 %"
  },
  State_2679_Name = {
    Text = "État@Chapitre 3_Résonance 7_Marque"
  },
  State_2680_Desc = {
    Text = "Taux critique augmenté de 20 %. Si la vie est inférieure à 25 % en début de tour, un coup critique est garanti ce tour"
  },
  State_2681_Desc = {
    Text = "Cet éveilleur n'est pas encore éveillé... Il s'éveillera lorsqu'il sera sur le point d'être abattu, restaurera sa vie et commencera à se battre sous sa véritable forme"
  },
  State_2681_Name = {
    Text = "Non Réveillé"
  },
  State_2682_Desc = {
    Text = "Les effets de bouclier et de soins augmentent de 50 %"
  },
  State_2682_Name = {
    Text = "Gardien du jardin altéré"
  },
  State_2682_WeaponDesc = {
    Text = "Les effets de bouclier et de soins augmentent de 50 %"
  },
  State_2683_Desc = {
    Text = "Pioche des cartes selon le nombre d'états"
  },
  State_2683_Name = {Text = "Piocher"},
  State_2684_Desc = {
    Text = "Équipe unique : La « frappe » du porteur a <WeaponEffect_Num:[StateArg1]%> de chances d'obtenir 1 arithmética et de déclencher 10 % de <IntoxicationIconKeywords:Poison> pour tous les ennemis. Si le royaume actuel est « aequor », cet effet fait qu'un tentacule attaque une fois lorsqu'il est déclenché. Cet effet ne peut se déclencher qu'une fois par tour."
  },
  State_2684_WeaponDesc = {
    Text = "La « Frappe » du porteur a une chance de <WeaponEffect_Num:[StateArg1]%> d'obtenir 1 arithmétique et de déclencher [DescArg1]% de <IntoxicationIconKeywords:Poison> pour tous les ennemis. Si le royaume actuel est « Aequor », cet effet fait qu'un tentacule attaque une fois lorsqu'il est déclenché. Cet effet peut se déclencher un maximum de 1 fois par tour."
  },
  State_2685_Desc = {
    Text = "Immunisez-vous contre les états de faiblesse, fragilité et vulnérabilité, retirez 1 couche à la fin du tour"
  },
  State_2685_Name = {
    Text = "<BlessingIconKeywords: Bénédiction>"
  },
  State_2685_WeaponDesc = {
    Text = "Ce tour, immunité aux effets négatifs"
  },
  State_2686_Desc = {
    Text = "Cartes temporaires données pendant le combat"
  },
  State_2686_Name = {
    Text = "<CardKeyWord:Carte d'état>"
  },
  State_2687_Desc = {
    Text = "Le taux critique augmente de 100 % pendant ce tour"
  },
  State_2687_Name = {
    Text = "Temporairement garanti pour exploser"
  },
  State_2687_WeaponDesc = {
    Text = "Le taux critique augmente de 100 % pendant ce tour"
  },
  State_2688_Desc = {
    Text = "Après avoir joué la 3ème carte de chaque tour, mettez 1 carte « inspiration » dans la pile de défausse. Après avoir joué la 6ème carte, prenez 1 carte « inspiration » de la pile de défausse dans votre main"
  },
  State_2689_Desc = {
    Text = "Au début du tour, piochez 2 cartes. Capacité de la fente dimensionnelle +2"
  },
  State_2689_Name = {
    Text = "Chapeau du prestidigitateur de la création"
  },
  State_2689_WeaponDesc = {
    Text = "Au début du tour, piochez 2 cartes. Capacité de la fente dimensionnelle +2"
  },
  State_2690_Desc = {
    Text = "Lorsque le Chevalier de la Vertu joue une carte, il gagne [StateArg1] points de force"
  },
  State_2690_Name = {
    Text = "Chevalier ardent"
  },
  State_2691_Desc = {
    Text = "Équipe Unique : Après que le porteur ait libéré l'Exaltation, il obtient <WeaponEffect_Num:[StateArg1]> points de Fureur et <WeaponEffect_Num:[StateArg2]> points de Fragment de clé, se répétant une fois pour chaque 4 cartes en main. Si le royaume actuel est « Ultra », les cartes du porteur entrent dans l'Espace Hyperspatial et obtiennent une Force Temporaire équivalente à <WeaponEffect_Num:[StateArg3]%> de l'Attaque du porteur, pouvant se déclencher jusqu'à 2 fois par tour."
  },
  State_2691_WeaponDesc = {
    Text = "Après que le porteur ait libéré l'exaltation, il obtient <WeaponEffect_Num:[StateArg1]> points de fureur et <WeaponEffect_Num:[StateArg2]> points de fragment de clé, ce qui se répète une fois pour chaque 4 cartes en main. Si le royaume actuel est « Ultra », après que les cartes du porteur entrent dans l'espace hyperspatial, il obtient <WeaponEffect_Num:[Power:DescArg1]> points de force temporaire, pouvant se déclencher un maximum de 2 fois par tour."
  },
  State_2693_Desc = {
    Text = "État@PrologueFolie0_1_2Effet"
  },
  State_2693_Name = {
    Text = "État@PrologueFolie0_1_2Effet"
  },
  State_2693_WeaponDesc = {
    Text = "État@PrologueFolie0_1_2Effet"
  },
  State_2694_Desc = {
    Text = "Chaque consommation de 1 sigil noir accorde 1 point de colère à tous les réveilleurs"
  },
  State_2694_Name = {
    Text = "État de la fleur inversée de la création"
  },
  State_2694_WeaponDesc = {
    Text = "Chaque consommation de 1 sigil noir accorde 1 point de colère à tous les réveilleurs"
  },
  State_2695_Desc = {
    Text = "Chaque fois qu'une carte d'éveillé entre dans l'espace dimensionnel, l'éveillé correspondant gagne 15 folie"
  },
  State_2696_Desc = {
    Text = "État@PrologueFolie0_1_2Actif"
  },
  State_2696_Name = {
    Text = "État@PrologueFolie0_1_2Actif"
  },
  State_2696_WeaponDesc = {
    Text = "État@PrologueFolie0_1_2Actif"
  },
  State_2698_Name = {
    Text = "Gagnez +1 de puissance de calcul au début du prochain tour"
  },
  State_2699_Name = {
    Text = "Au début du prochain tour, +2 de puissance de calcul"
  },
  State_2701_Desc = {
    Text = "Lorsque la dame des profondeurs reçoit un bouclier, augmente les dégâts temporaires de tentacule de [StateArg1]"
  },
  State_2701_Name = {Text = "Créature"},
  State_2701_WeaponDesc = {
    Text = "Lorsque la dame des profondeurs reçoit un bouclier, augmente les dégâts temporaires de tentacule de [StateArg1]"
  },
  State_2702_Desc = {
    Text = "Lors de la collecte, obtenir 100% de résistance à la mort. Après avoir déclenché la résistance à la mort, à chaque début de tour, récupérer [Arg1] points de vie"
  },
  State_2702_Name = {
    Text = "Souffle de vie"
  },
  State_2703_Desc = {
    Text = "La première copie temporaire de la carte d'entité éveillée jouée chaque tour entre dans la faille dimensionnelle, elles peuvent vous protéger en cas de danger !"
  },
  State_2703_Name = {
    Text = "Fissure dimensionnelle"
  },
  State_2705_Name = {
    Text = "Déclaration de vengeance"
  },
  State_2706_Desc = {
    Text = "Détection de pétrification progressive"
  },
  State_2706_Name = {
    Text = "Détection de pétrification progressive"
  },
  State_2706_WeaponDesc = {
    Text = "Détection de pétrification progressive"
  },
  State_2707_Desc = {
    Text = "Ce tour, attaque de tentacule touche tous les ennemis"
  },
  State_2707_Name = {
    Text = "Attaque Totale des Tentacules"
  },
  State_2707_WeaponDesc = {
    Text = "Ce tour, attaque de tentacule touche tous les ennemis"
  },
  State_2708_Desc = {
    Text = "Limite de tentacule augmentée de 1. Lorsque la vie est inférieure à 50%, les dégâts de tentacule augmentent de [StateArg1] points"
  },
  State_2708_Name = {
    Text = "Offrande passée altérée"
  },
  State_2708_WeaponDesc = {
    Text = "Limite de tentacule augmentée de 1. Lorsque la vie est inférieure à 50%, les dégâts de tentacule augmentent de [StateArg1] points"
  },
  State_2709_Desc = {
    Text = "Compteur du scalpel rouillé de la création"
  },
  State_2710_Desc = {Text = "Marque"},
  State_2710_Name = {Text = "Marque"},
  State_2710_WeaponDesc = {Text = "Marque"},
  State_2711_Desc = {
    Text = "Changer temporairement la puissance de calcul de la carte"
  },
  State_2711_Name = {
    Text = "Changer temporairement la puissance de calcul de la carte"
  },
  State_2711_WeaponDesc = {
    Text = "Changer temporairement la puissance de calcul de la carte"
  },
  State_2712_Desc = {
    Text = "Augmente les boucliers générés"
  },
  State_2712_Name = {
    Text = "<AlertIconKeywords: alerte>"
  },
  State_2712_WeaponDesc = {
    Text = "Les boucliers obtenus sont augmentés"
  },
  State_2713_Desc = {
    Text = "La Grande Lame de Vengeance gagne de la force à chaque tour"
  },
  State_2713_Name = {
    Text = "Éveil de la Lame de Vengeance"
  },
  State_2713_WeaponDesc = {
    Text = "Au début du prochain tour, obtenez un bouclier équivalent à la vie perdue au tour précédent"
  },
  State_2715_Desc = {
    Text = "Les boucliers augmentent de [Layer] points dans ce niveau"
  },
  State_2715_Name = {
    Text = "Garde permanente"
  },
  State_2715_WeaponDesc = {
    Text = "Les boucliers augmentent de [Layer] points dans ce niveau"
  },
  State_2718_Desc = {
    Text = "Unique à l'équipe : à la fin du tour, l'équipement gagne <WeaponEffect_Num:[StateArg1]> points de folie, et une s-énergie équivalente à la recharge de clé en argent de l'équipement"
  },
  State_2718_WeaponDesc = {
    Text = "À la fin du tour, le porteur obtient <WeaponEffect_Num:[StateArg1]> points de folie, obtenant l'énergie clé en argent équivalente à la recharge du porteur"
  },
  State_2720_Desc = {
    Text = "Réduisez de 10 la folie de l'éveillé avec le plus de folie après avoir infligé des dégâts réels"
  },
  State_2720_Name = {Text = "Vide"},
  State_2720_WeaponDesc = {
    Text = "Réduisez de 10 la folie de l'éveillé avec le plus de folie après avoir infligé des dégâts réels"
  },
  State_2721_Name = {
    Text = "État @niveau 2_9 bataille 5 bulle 1"
  },
  State_2722_Desc = {
    Text = "Après avoir joué, mélangez [StateArg1] \"Inspiration\" dans la pile de pioche. \"Inspiration\" : Gagnez 1 Arithmetica, piochez 1 carte, retenez, épuiser."
  },
  State_2722_Name = {
    Text = "<Rune_17_High:Inspiration avancée>"
  },
  State_2723_Desc = {
    Text = "Après avoir joué, affaiblissez tous les ennemis pour [StateArg1] tours"
  },
  State_2723_Name = {
    Text = "<Rune_1_High:vulnérabilité avancée>"
  },
  State_2724_Desc = {Text = "+1 attaque"},
  State_2724_Name = {
    Text = "Contre-attaque du noyau de rêve"
  },
  State_2726_Desc = {
    Text = "Après avoir joué, infligez [StateArg1] couches de poison à tous les ennemis, provoquant [StateArg2]% de poison chez tous les ennemis"
  },
  State_2726_Name = {
    Text = "<Rune_10_High:Toxine avancée>"
  },
  State_2727_Desc = {
    Text = "À l'agonie, restaure 1 vie et retire cet état"
  },
  State_2727_Name = {Text = "Racine"},
  State_2727_WeaponDesc = {
    Text = "À l'agonie, restaure 1 vie et retire cet état"
  },
  State_2728_Desc = {
    Text = "Au début du tour, gagnez 1 couche de <ParcloseIconKeywords:barrière> par allié"
  },
  State_2728_Name = {
    Text = "Lien de barrière"
  },
  State_2728_WeaponDesc = {
    Text = "Au début du tour, pour chaque autre allié, gagner un bouclier de [Layer] pourcentage de la santé max"
  },
  State_2729_Desc = {
    Text = "Déclencher et piocher une carte correspondante à l'éveillé"
  },
  State_2729_Name = {
    Text = "Déflecteur spatial métamorphosé, pioche"
  },
  State_2729_WeaponDesc = {
    Text = "Déclencher et piocher une carte correspondante à l'éveillé"
  },
  State_2730_Desc = {
    Text = "À sa mort, Hydra perd 1 niveau de l'état \"Maître des Serpents\""
  },
  State_2730_Name = {Text = "Familier"},
  State_2732_Desc = {
    Text = "État@PrologueFolieInitialisation0_2_3"
  },
  State_2732_Name = {
    Text = "État@PrologueFolieInitialisation0_2_3"
  },
  State_2732_WeaponDesc = {
    Text = "État@PrologueFolieInitialisation0_2_3"
  },
  State_2734_Name = {
    Text = "Pioche +1 carte au début du prochain tour"
  },
  State_2735_Desc = {
    Text = "Si cette carte déclenche une « Navette dimensionnelle » après avoir été jouée ou se trouve actuellement dans un Tour Ultra, déclencher l'effet suivant."
  },
  State_2735_Name = {
    Text = "<TransitionIconKeywords: Saut>"
  },
  State_2735_WeaponDesc = {
    Text = "Si vous êtes actuellement dans un tour ultra, l'effet de saut peut être déclenché"
  },
  State_2737_Desc = {
    Text = "Quand le deck de notre équipe est réinitialisé, gagnez [Layer] de force"
  },
  State_2737_Name = {
    Text = "Toujours figé"
  },
  State_2738_Name = {
    Text = "Effet de Faiblesse Augmenté"
  },
  State_2740_Desc = {
    Text = "La carte copiée au « sujet de la sculpture inachevée » et sa consommation de pouvoir de base -1, tout en obtenant une carte de symptôme"
  },
  State_2740_Name = {
    Text = "État@Chapitre 2_Résonance 5_2"
  },
  State_2740_WeaponDesc = {
    Text = "La carte copiée au nœud « sujet de la sculpture inachevée » et sa consommation de pouvoir de base -1"
  },
  State_2741_Desc = {
    Text = "La carte copiée au « sujet de la sculpture inachevée » et sa consommation de pouvoir de base -1, tout en obtenant une carte de symptôme"
  },
  State_2741_Name = {
    Text = "État@Chapitre 2_Résonance 5_1"
  },
  State_2741_WeaponDesc = {
    Text = "La carte copiée au nœud « sujet de la sculpture inachevée » et sa consommation de pouvoir de base -1"
  },
  State_2742_Desc = {
    Text = "À chaque fois que le perméable inflige 1 dégât, il reçoit [StateArg2] force temporaire, chaque fois qu'il obtient 1 bouclier, il reçoit [StateArg3] alerte temporaire"
  },
  State_2742_Name = {
    Text = "Paramètres d'ajustement"
  },
  State_2744_Desc = {
    Text = "Chaque fois qu'une carte d'éveillé entre dans l'espace dimensionnel, elle gagne 15 folie"
  },
  State_2744_Name = {
    Text = "Dispositif de saut de la création"
  },
  State_2744_WeaponDesc = {
    Text = "Chaque fois qu'une carte d'éveillé entre dans l'espace dimensionnel, elle gagne 15 folie"
  },
  State_2746_Desc = {
    Text = "+1 attaque, -[Layer] force"
  },
  State_2746_Name = {Text = "Énervé"},
  State_2747_Desc = {
    Text = "Après avoir joué, les autres éveillés gagnent [StateArg1] folie"
  },
  State_2747_Name = {
    Text = "<Rune_16:Catalyse>"
  },
  State_2748_Desc = {
    Text = "État@RituelDeLaLanterne"
  },
  State_2748_Name = {
    Text = "État@RituelDeLaLanterne"
  },
  State_2748_WeaponDesc = {
    Text = "État@RituelDeLaLanterne"
  },
  State_2749_Desc = {
    Text = "Ce tour, après avoir infligé des dégâts de tentacule, applique [Layer] couches d'empoisonnement à la cible"
  },
  State_2749_Name = {
    Text = "Courant obscur"
  },
  State_2750_Desc = {
    Text = "Plonge avec moi dans la mer"
  },
  State_2750_Name = {
    Text = "Néfia Éveil"
  },
  State_2752_Desc = {
    Text = "Lorsque le nénuphar inflige des dégâts, il gagne [StateArg2] de folie"
  },
  State_2752_Name = {
    Text = "Mer des Souffrances Éternelles"
  },
  State_2752_WeaponDesc = {
    Text = "Lorsque le nénuphar inflige des dégâts, il gagne [StateArg2] de folie"
  },
  State_2753_Desc = {
    Text = "Au début du tour, si la vie est supérieure à [Arg1], perdre [Arg1] points de vie, et gagner [Arg2] points de pouvoir et [Arg3] points d'alerte durant ce tour"
  },
  State_2754_Name = {
    Text = "État @taux critique de frappe temporaire augmenté"
  },
  State_2757_Desc = {
    Text = "Au début du prochain tour, obtenir [DescArg1] points d'Arithmetica supplémentaires."
  },
  State_2757_Name = {
    Text = "Symptôme : Méfiance"
  },
  State_2758_Desc = {
    Text = "Tous tes effets de régénération de vie augmentent de [Arg1] points, l'excès de vie se transforme en bouclier équivalent"
  },
  State_2758_Name = {
    Text = "Spécimen de papillon"
  },
  State_2760_Desc = {
    Text = "Chaque fois qu'un éveillé effectue une dévoration, les autres éveillés gagnent 10 folie"
  },
  State_2762_Desc = {
    Text = "Après avoir joué, effectue un effet supplémentaire [StateArg1] fois, obtenez [StateArg2] points du sigil noir, épuiser, innée"
  },
  State_2762_Name = {
    Text = "<Rune_7_High:Écho avancé>"
  },
  State_2762_WeaponDesc = {
    Text = "Après avoir joué, s'active [StateArg1] fois supplémentaires, consommée"
  },
  State_2763_Desc = {
    Text = ": À chaque fois que le Maître du sommeil utilise 1 arithmetica, augmente les dégâts de tentacule de [StateArg1]"
  },
  State_2763_Name = {
    Text = "Dignité immortelle"
  },
  State_2763_WeaponDesc = {
    Text = ": À chaque fois que le Maître du sommeil utilise 1 arithmetica, augmente les dégâts de tentacule de [StateArg1]"
  },
  State_2764_Desc = {
    Text = "Ajoutez [StateArg1] couches de saignement en infligeant des dégâts non bloqués"
  },
  State_2764_Name = {
    Text = "Saignement malveillant"
  },
  State_2765_Name = {
    Text = "État @George @soigner à la mort"
  },
  State_2767_Name = {
    Text = "État@efficacité de recharge du sigil noir et de la clé en argent"
  },
  State_2769_Desc = {
    Text = "Cet éveilleur n'est pas encore éveillé... Il s'éveillera lorsqu'il sera sur le point d'être abattu, restaurera sa vie et commencera à se battre sous sa véritable forme"
  },
  State_2769_Name = {
    Text = "Non Réveillé"
  },
  State_2771_Desc = {
    Text = ": Force du monstre"
  },
  State_2771_Name = {
    Text = ": Force du monstre"
  },
  State_2772_Name = {
    Text = "État @niveau 2_5 bataille 3 bulle 1"
  },
  State_2773_Desc = {
    Text = "Au début de la bataille, placez 1 carte « instant précieux - changez toutes vos cartes Réveilleurs en « frappe », jusqu'à la fin du tour. Conservez, dépensez. »"
  },
  State_2775_Desc = {
    Text = "Retourner le nombre de cartes piochées"
  },
  State_2775_Name = {
    Text = "Réinitialisation du comptage des tirages"
  },
  State_2776_Name = {
    Text = "Œil de pierre, renforcement de la malédiction"
  },
  State_2777_Name = {
    Text = "État@Chapitre 3_Vide"
  },
  State_2778_Desc = {
    Text = "Au début de la bataille, gagnez [Arg1] points de bouclier. Après avoir joué 7 fois « défense » dans ce combat, gagnez immédiatement [Arg2] points de bouclier"
  },
  State_2778_Name = {
    Text = "Courrier matinal de Putney"
  },
  State_2779_Desc = {
    Text = "Lorsque la vie est inférieure à 50% ([StateArg1]), elle se divisera en 3 \"corps dissous de type interférence\" ayant une vie équivalente"
  },
  State_2779_Name = {Text = "Fissure"},
  State_2779_WeaponDesc = {
    Text = "Lorsque la vie est inférieure à 50% ([StateArg1]), elle se divisera en 2 \"corps dissous de type II\" ayant une vie équivalente"
  },
  State_2780_Desc = {
    Text = "Après avoir joué, obtenez [StateArg1] points d'arithmétique"
  },
  State_2780_Name = {
    Text = "<Rune_4:Calcul>"
  },
  State_2781_Desc = {
    Text = "Après [Layer] cartes jouées, ajoutez une couche de <ParcloseIconKeywords:Barrière> si aucune barrière"
  },
  State_2781_Name = {
    Text = "Barrière de recharge"
  },
  State_2781_WeaponDesc = {
    Text = "Chaque fois que notre équipe joue [Layer] cartes, le monstre gagne une couche de barrière"
  },
  State_2784_Desc = {
    Text = "Même en dehors du tour dimensionnel, un effet de saut peut être déclenché une fois par tour. Capacité dimensionnelle augmentée de 2"
  },
  State_2785_Desc = {
    Text = "Équipe unique : Après que le porteur ait joué une carte, il obtient 1 point de fureur. Au début du combat, gagnez une Force équivalente à <WeaponEffect_Num:[StateArg1]%> de l'Attaque du porteur. Si le royaume actuel est « Aequor », obtenez en plus <WeaponEffect_Num:[StateArg2]%> de Dégâts des tentacules. Au début de chaque tour suivant, gagnez une Force équivalente à <WeaponEffect_Num:[StateArg3]%> de l'Attaque du porteur. Si le royaume actuel est « Aequor », obtenez en plus <WeaponEffect_Num:[StateArg4]%> de Dégâts des tentacules."
  },
  State_2785_WeaponDesc = {
    Text = "Après avoir joué une carte, le porteur obtient 1 point de fureur. Au début du combat, obtenez <WeaponEffect_Num:[Power:DescArg1]> points de <PowerIconKeywords:Force>. Si le royaume actuel est « Aequor », obtenez en plus <WeaponEffect_Num:[DescArg2]> points de <CardKeyWord:Dégâts des tentacules>. Ensuite, au début de chaque tour, obtenez <WeaponEffect_Num:[Power:DescArg3]> points de <PowerIconKeywords:Force>. Si le royaume actuel est « Aequor », obtenez en plus <WeaponEffect_Num:[DescArg4]> points de <CardKeyWord:Dégâts des tentacules>."
  },
  State_2786_Name = {
    Text = "Compteur des galets ensanglantés des créations"
  },
  State_2787_Desc = {
    Text = "Restaurez la vie, mélangez 1 [Illusion Termination] dans la pile de défausse. Permanent, détruisez."
  },
  State_2787_Name = {
    Text = "<CardKeyWord:Recherche de la vérité>"
  },
  State_2787_WeaponDesc = {
    Text = "Restaurez la vie, mélangez 1 [Illusion Termination] dans la pile de défausse. Permanent, détruisez."
  },
  State_2788_Desc = {
    Text = "Au début du tour, piochez [StateArg1] cartes"
  },
  State_2788_Name = {
    Text = "Lampe à souhaits du prophète des créations 1"
  },
  State_2788_WeaponDesc = {
    Text = "Au début du tour, piochez [StateArg1] cartes"
  },
  State_2789_Desc = {
    Text = "La carte a été altérée par Jenkin ! Subissez [Layer] <FixedDamage:DGT Purs> lorsqu'elle est jouée."
  },
  State_2789_Name = {
    Text = "<CardKeyWord:Subir [Layer] dégâts après utilisation>"
  },
  State_2789_WeaponDesc = {
    Text = "Après avoir joué la carte, subissez [StateArg1] points de dégâts"
  },
  State_2790_Desc = {
    Text = "À la fin du tour, peut conserver [StateArg1] cartes en main"
  },
  State_2790_Name = {
    Text = "Lampe à souhaits du prophète des créations 2"
  },
  State_2790_WeaponDesc = {
    Text = "À la fin du tour, peut conserver [StateArg1] cartes en main"
  },
  State_2792_Desc = {
    Text = "Au début de la bataille, tous les alliés gagnent 3 couches de [Armure de Cire]. Au début du tour, mélangez une [Convulsion] dans la pile de tirage de notre équipe."
  },
  State_2792_Name = {
    Text = "«Dame de Cire»"
  },
  State_2792_WeaponDesc = {
    Text = "Au début de la bataille, tous les alliés gagnent 3 couches de [Armure de Cire]. Au début du tour, mélangez une [Convulsion] dans la pile de tirage de notre équipe."
  },
  State_2793_Desc = {
    Text = "État@Œil de pierre: Agonie"
  },
  State_2793_Name = {
    Text = "État@Œil de pierre: Agonie"
  },
  State_2793_WeaponDesc = {
    Text = "État@Œil de pierre: Agonie"
  },
  State_2796_Desc = {
    Text = "Chaque fois que vous perdez des PV, ajoutez [Arg1] poison à tous les ennemis. Augmente le poison de [Arg2] chaque tour"
  },
  State_2797_Desc = {
    Text = "Au début du tour, ajouter 1 \"parapluie\" ayant obtenu [Arg1] d'alerte durant ce tour à la main, après avoir joué 6 cartes, augmenter la garde de toutes les \"parapluie\" dans votre main de [Arg2]"
  },
  State_2798_Desc = {
    Text = "Le grand prêtre bienveillant applique un bouclier, réduisant le coût en arithmetica de 1 pour 1 carte manuelle aléatoire jusqu'à son lancement"
  },
  State_2798_Name = {
    Text = "La miséricorde du père"
  },
  State_2798_WeaponDesc = {
    Text = "Le grand prêtre bienveillant applique un bouclier, réduisant le coût en arithmetica de 1 pour 1 carte manuelle aléatoire jusqu'à son lancement"
  },
  State_2799_Desc = {
    Text = "Lorsque la Méduse Lunaire inflige des Dégâts Directs, déclenche [StateArg1] Attaque(s) de tentacules sur la cible."
  },
  State_2799_Name = {
    Text = "Auto-reproduction"
  },
  State_2799_WeaponDesc = {
    Text = "Quand la mer inflige des dégâts, elle fait attaquer [StateArg1] tentacules la cible"
  },
  State_2800_Desc = {
    Text = "Augmentation des dégâts, bouclier et guérison de l'équipementeur de [StateArg1]%. (temporaire)"
  },
  State_2800_Name = {
    Text = "État@Dégâts critiques du couteau prototype"
  },
  State_2801_Desc = {
    Text = "Les dégâts réels augmentent les couches de corrosion profonde"
  },
  State_2801_Name = {
    Text = "Les dégâts reçus augmentent les couches de corrosion profonde"
  },
  State_2801_WeaponDesc = {
    Text = "Les dégâts réels augmentent les couches de corrosion profonde"
  },
  State_2802_Desc = {
    Text = "Augmenter la force temporaire au début du tour"
  },
  State_2802_Name = {
    Text = "Augmenter la force temporaire"
  },
  State_2804_Desc = {
    Text = "Augmentation des dégâts, bouclier et guérison de l'équipementeur de [StateArg1]%. (temporaire)"
  },
  State_2804_Name = {
    Text = "État@Dégâts critiques du canon laser prototype"
  },
  State_2805_Desc = {
    Text = "À la fin du tour, les autres alliés gagnent de la force"
  },
  State_2805_Name = {
    Text = "« Feu de l'Aube »"
  },
  State_2807_Desc = {
    Text = "Au début du tour, ajouter 1 \"parapluie\" ayant obtenu [Arg1] d'alerte durant ce tour à la main, après avoir joué 6 cartes, augmenter la garde de toutes les \"parapluie\" dans votre main de [Arg2]"
  },
  State_2808_Desc = {
    Text = "À la fin du tour, génère 1 fusion d'embryon, si un embryon est en main, récupère 15 PV"
  },
  State_2808_Name = {
    Text = "Pince Hémostatique Anomalique"
  },
  State_2808_WeaponDesc = {
    Text = "À la fin du tour, génère 1 fusion d'embryon, si un embryon est en main, récupère 15 PV"
  },
  State_2809_Desc = {
    Text = "Après ramassage, perdez définitivement [Arg1] force. Chaque fois que vous infligez des dégâts, récupérez [Arg2] points de vie, jusqu'à 6 fois par tour"
  },
  State_2809_Name = {
    Text = "Baiser de la Lamproie"
  },
  State_2810_Desc = {
    Text = "À la fin du tour, récupérer [Layer] % de la vie maximale"
  },
  State_2810_Name = {
    Text = "Régénération"
  },
  State_2810_WeaponDesc = {
    Text = "À la fin du tour du monstre, récupère [Layer]% de PV max"
  },
  State_2811_Desc = {
    Text = "Lorsque vous piochez une carte de symptôme, obtenez [Arg1] points de pouvoir. Pour chaque oraison maudite ou relique maudite que vous possédez, le taux critique et les dégâts critiques augmentent de 10 %"
  },
  State_2812_Desc = {
    Text = "Cet éveilleur n'est pas encore éveillé... Il s'éveillera lorsqu'il sera sur le point d'être abattu, restaurera sa vie et commencera à se battre sous sa véritable forme"
  },
  State_2812_Name = {
    Text = "Non Réveillé"
  },
  State_2813_Desc = {
    Text = "Au début du tour, perdre de la puissance de calcul"
  },
  State_2813_Name = {
    Text = "Mauvais calcul !"
  },
  State_2814_Desc = {
    Text = "Les estampilles obtenues lors de la victoire du combat deviennent de puissantes et dangereuses estampilles maudites"
  },
  State_2817_Desc = {
    Text = "Chaque couche réduit les dégâts reçus de [StateArg1], réduit d'une couche après chaque coup critique"
  },
  State_2817_Name = {
    Text = "Armure en cire"
  },
  State_2817_WeaponDesc = {
    Text = "Immunité aux états anormaux, retirée après un coup critique"
  },
  State_2818_Desc = {
    Text = "Diviser en Corrosion Triangle A et Corrosion Triangle B"
  },
  State_2818_Name = {Text = "Fissure"},
  State_2818_WeaponDesc = {
    Text = "Diviser en Corrosion Triangle A et Corrosion Triangle B"
  },
  State_2820_Desc = {
    Text = "Après avoir joué, obtenez [StateArg1] points temporaires de pouvoir, cette carte d'impression pourra également bénéficier de l'augmentation de pouvoir"
  },
  State_2820_Name = {
    Text = "<Rune_15:Explosion>"
  },
  State_2821_Name = {
    Text = "Immunité temporaire à la vulnérabilité"
  },
  State_2823_Desc = {
    Text = "Équipe Unique : au début du combat, applique 2 couches de <VulnerabilityIconKeywords:Vulnérable> aux ennemis en première ligne. Au début du tour, les ennemis en état Vulnérable perdent une <PowerIconKeywords:Force> temporaire équivalente à <WeaponEffect_Num:[StateArg1]%> de l'ATQ du Porteur. Si le Royaume actuel est «Caro», après que le Porteur déclenche «Exaltation», Fusion d'Embryon +<WeaponEffect_Num:[Blood:StateArg2]>."
  },
  State_2823_WeaponDesc = {
    Text = "Au début du combat, applique 2 couches de <VulnerabilityIconKeywords:Vulnérable> aux ennemis en première ligne. Au début du tour, les ennemis en état Vulnérable perdent <WeaponEffect_Num:[Power:DescArg1]> points de <PowerIconKeywords:Force> temporaire. Si le Royaume actuel est «Caro», après que le Porteur déclenche «Exaltation», Fusion d'Embryon +<WeaponEffect_Num:[Blood:StateArg2]>."
  },
  State_2825_Desc = {
    Text = "Limite de slot de carte monstre Hyperdimension"
  },
  State_2825_Name = {
    Text = "Limite de slot de carte monstre Hyperdimension"
  },
  State_2825_WeaponDesc = {
    Text = "Limite de slot de carte monstre Hyperdimension"
  },
  State_2826_Desc = {
    Text = "Lorsque vous jouez 2 cartes ayant une consommation de puissance inférieure à celle de la carte précédente, le réveilleur avec la folie la plus basse reçoit 50 points de folie"
  },
  State_2826_Name = {
    Text = "Relique d'Arcana de la création"
  },
  State_2827_Desc = {
    Text = "Nombre de coups et augmentation des dégâts"
  },
  State_2827_Name = {
    Text = "<CardKeyWord:Amélioration>"
  },
  State_2829_Desc = {
    Text = "Gagnez [Layer] points de force après avoir infligé des dégâts réels"
  },
  State_2829_Name = {
    Text = "« Personnalité chaotique »"
  },
  State_2830_Desc = {
    Text = "Pour chaque réveilleur professionnel de type [deep sea] dans l'équipe, la santé max (incomplète), la défense et l'attaque de toute l'équipe augmentent de 50%"
  },
  State_2830_Name = {
    Text = "Bonus des profondeurs"
  },
  State_2830_WeaponDesc = {
    Text = "Pour chaque réveilleur professionnel de type [deep sea] dans l'équipe, la santé max (incomplète), la défense et l'attaque de toute l'équipe augmentent de 50%"
  },
  State_2832_Desc = {
    Text = "Augmentation des dégâts, bouclier et guérison de l'équipementeur de [StateArg1]%. (temporaire)"
  },
  State_2832_Name = {
    Text = "État@Résistance à la mort du canon laser prototype"
  },
  State_2833_Desc = {
    Text = "Au début du tour, tire 1 carte. Chaque fois que tu tires 1 carte, modifie aléatoirement sa consommation de puissance de calcul (0-4)"
  },
  State_2835_Desc = {
    Text = "À chaque dévoration, vole [Arg1] points de force temporaire à tous les ennemis"
  },
  State_2836_Name = {
    Text = "État@Conformité de malédiction"
  },
  State_2837_Name = {
    Text = "État@Conformité de malédiction"
  },
  State_2838_Name = {
    Text = "État@Conformité de malédiction"
  },
  State_2840_Desc = {
    Text = "Subissez [Layer] <FixedDamage:DGT Purs> et retirez [DescArg1]% des charges à la fin du tour. Lors de la restauration de PV, retirez deux fois le nombre de charges de Saignement correspondant aux PV restaurés."
  },
  State_2840_Name = {
    Text = "<BleedingColour: Saignement>"
  },
  State_2840_WeaponDesc = {
    Text = "Après la fin du tour, subir [Layer] points de dégâts et retirer cet état; chaque guérison peut réduire de moitié le nombre de couches"
  },
  State_2842_Desc = {
    Text = "Après avoir joué, obtenez [StateArg1] <RetaliateIconKeywords:Contre-attaque>, puis infligez des dégâts réels à tous les ennemis égaux à [StateArg2]% de votre <RetaliateIconKeywords:Contre-attaque>"
  },
  State_2842_Name = {
    Text = "<Rune_9:pique>"
  },
  State_2843_Desc = {
    Text = "Chaque fois que notre équipe joue une carte, elle gagne [StateArg1] couches de bouclier. Dure 1 tour"
  },
  State_2843_Name = {
    Text = "Plumes volantes"
  },
  State_2843_WeaponDesc = {
    Text = "Chaque fois que notre équipe joue une carte, elle gagne [StateArg1] couches de bouclier. Dure 1 tour"
  },
  State_2844_Desc = {
    Text = "Lors de la première perte de vie dans chaque combat, obtenez 1 couche de barrière immunisant contre un dégât"
  },
  State_2845_Name = {
    Text = "Murmure de la terre sacrée de l'accessoire"
  },
  State_2845_WeaponDesc = {
    Text = "Au début du niveau, la résistance à la mort augmente de 25%. Après avoir déclenché la résistance à la mort, le porteur gagne 50 points de folie"
  },
  State_2846_Desc = {
    Text = "Immunité à une mort, restaure [Arg1] vie après activation et rend cette création invalide"
  },
  State_2846_Name = {
    Text = "Poupée doublure"
  },
  State_2847_Desc = {
    Text = "Chaque carte jouée par le Réveillé chassé ajoute 1 marque de chasse et tire un nombre de cartes égal à la moitié des marques"
  },
  State_2847_Name = {
    Text = "Cérémonie de chasse"
  },
  State_2849_Desc = {
    Text = "Chaque fois que vous perdez des PV, gagnez [Arg1] force, max 10 fois. À 10 couches, récupérez 25% des PV perdus"
  },
  State_2849_Name = {
    Text = "Honneur suprême"
  },
  State_2853_Desc = {
    Text = "Compteur du fauteuil de repos éternel de la création"
  },
  State_2854_Desc = {
    Text = "Après la mort, ne fournit pas de folie à l'entité éveillée"
  },
  State_2854_Name = {Text = "égoïste"},
  State_2854_WeaponDesc = {
    Text = "Après la mort, ne fournit pas de folie à l'entité éveillée"
  },
  State_2855_Desc = {
    Text = "Les dégâts des cartes de frappe augmentent de [StateArg1] %, pendant [Layer] tours."
  },
  State_2855_Name = {
    Text = "Survivre dans l'adversité·Attaque"
  },
  State_2855_WeaponDesc = {
    Text = "Ce tour, dégâts des cartes de frappe augmentés de [Layer] %"
  },
  State_2856_Desc = {
    Text = "Équipe Unique : le bouclier causé par l'équipement augmente de <WeaponEffect_Num:[StateArg1]%>, et lorsqu'un bouclier est infligé, tous les alliés reçoivent <WeaponEffect_Num:[StateArg3]%> de taux critique temporaire et <WeaponEffect_Num:[StateArg4]%> de l'énergie clé en argent régénérée par le porteur, cet effet ne peut se produire que 2 fois par tour. Si le royaume actuel est « Aequor », chaque fois qu'un tentacule attaque, le porteur obtient 1 point de fureur, avec un maximum de <WeaponEffect_Num:[StateArg2]> points par tour."
  },
  State_2856_WeaponDesc = {
    Text = "Le bouclier causé par l'équipement augmente de <WeaponEffect_Num:[StateArg1] %>, et lorsque le bouclier est infligé, tous les alliés obtiennent <WeaponEffect_Num:[StateArg3] %> de taux de coup critique temporaire et <WeaponEffect_Num:[StateArg4]%> de fragment de clé en argent de l'équipement, cet effet ne peut se produire qu'un maximum de 2 fois par tour. Si l'état actuel est « aequor », chaque fois qu'un tentacule attaque, le porteur obtient 1 point de fureur, avec un maximum de <WeaponEffect_Num:[StateArg2]> points par tour."
  },
  State_2857_Desc = {
    Text = "Au début de chaque tour, tous les réveilleurs gagnent 10 points de folie. La santé max est réduite de 50%"
  },
  State_2858_Name = {
    Text = "En jouant, gagnez deux couches de barrière supplémentaires"
  },
  State_2859_Desc = {
    Text = "Après le début du combat, cette carte est fixée dans la main"
  },
  State_2859_Name = {
    Text = "<CardKeyWord:Inhérent>"
  },
  State_2860_Desc = {
    Text = "Lorsque vous le piochez, réduisez votre santé max de 10 %. Après usage, faites en sorte que tous les réveilleurs augmentent leurs dégâts critiques de 100 % ce tour-ci. Ne peut pas être vendu"
  },
  State_2860_Name = {
    Text = "État: Corrosion de malédiction"
  },
  State_2860_WeaponDesc = {
    Text = "Lorsque vous le piochez, réduisez votre santé max de 10 %. Après usage, faites en sorte que tous les réveilleurs augmentent leurs dégâts critiques de 100 % ce tour-ci. Ne peut pas être vendu"
  },
  State_2861_Name = {
    Text = "(Restant : [Layer])"
  },
  State_2862_Desc = {
    Text = "À la fin du tour, subir à nouveau des dégâts de poison"
  },
  State_2862_Name = {
    Text = "Faiblesse constitutionnelle"
  },
  State_2863_Desc = {
    Text = "Niveau d'évolution"
  },
  State_2863_Name = {
    Text = "Niveau d'évolution"
  },
  State_2863_WeaponDesc = {
    Text = "Niveau d'évolution"
  },
  State_2864_Desc = {
    Text = "\"24\" s'est Réveillée. Utilise le dernier \"Sauvez-moi\" pour trouver ta chance !"
  },
  State_2864_Name = {
    Text = "« 24 » Éveil !"
  },
  State_2864_WeaponDesc = {
    Text = "Au début du prochain tour, obtenez un bouclier équivalent à la vie perdue au tour précédent"
  },
  State_2866_Desc = {
    Text = "Équipe Unique : Main Limite +2. À la fin du tour, gagnez des Fragments de clé égaux à <WeaponEffect_Num:[StateArg1]%> de Régénération de Fragment de clé du Porteur. Après que chaque Décret Clé est Lâché, tous les Corps éveillés gagnent <WeaponEffect_Num:[StateArg2]> Aliemus. Si le Royaume actuel est «Chair», déclenchez également la Fusion d'Embryon <WeaponEffect_Num:+[Blood:StateArg3]>."
  },
  State_2866_WeaponDesc = {
    Text = "Limite Max de la Main +2. À la fin du tour, gagnez <WeaponEffect_Num:[DescArg1]> points de Fragment de clé. Après chaque Décret Clé libéré, tous les Corps éveillés gagnent <WeaponEffect_Num:[StateArg2]> points d'Aliemus. Si le Royaume actuel est «Caro», la Fusion d'Embryon augmente également de <WeaponEffect_Num:+[Blood:StateArg3]>."
  },
  State_2868_Desc = {
    Text = "À la fin du tour, chaque carte non jouée dans la main donne 2 points de folie à tous les éveillés"
  },
  State_2871_Desc = {
    Text = "Vie < 50 %([StateArg1]), convoque un \"Triangle de corrosion\" avec la même vie"
  },
  State_2871_Name = {Text = "Invocation"},
  State_2871_WeaponDesc = {
    Text = "Vie < 50 %([StateArg1]), convoque un \"Triangle de corrosion\" avec la même vie"
  },
  State_2874_Desc = {
    Text = "L'éveillé est observé par le Chasseur de Crânes, utiliser ses cartes permet de piocher 2 cartes supplémentaires"
  },
  State_2875_Desc = {
    Text = "Après avoir joué, <EmbryoFusionIconKeywords:Fusion d'Embryon> +[StateArg1]."
  },
  State_2875_Name = {
    Text = "<Rune_12_High:Sanguinaire avancé>"
  },
  State_2875_WeaponDesc = {
    Text = "Après avoir joué, Fusion d'Embryon+ [Blood:StateArg1]."
  },
  State_2876_Desc = {
    Text = "Après le combat, obtenez 50 sigils noirs supplémentaires et 1 carte de symptômes"
  },
  State_2877_Desc = {
    Text = "Chaque fois que la Dame Rouge inflige des dégâts, elle gagne [StateArg2] points de force temporaire"
  },
  State_2877_Name = {
    Text = "Privilège de bienvenue"
  },
  State_2878_Desc = {
    Text = "Nombre de coups +1, mais les dégâts sont réduits de 25%"
  },
  State_2878_Name = {Text = "Frénésie"},
  State_2878_WeaponDesc = {
    Text = "Nombre de coups +1, mais les dégâts sont réduits de 25%"
  },
  State_2879_Name = {Text = "Slime Doux"},
  State_2879_WeaponDesc = {
    Text = "Après avoir utilisé « Annihilation », si vous êtes en posture d'« Océan Calme » ce tour-ci, le porteur bénéficie d'une augmentation de 30 % des effets de bouclier et de soins ce tour-ci."
  },
  State_2880_Name = {
    Text = "État@apôtre de la mer illuminer 7"
  },
  State_2881_Desc = {
    Text = "À chaque fois qu'une carte « Saint » est convertie en « Illusion », les dégâts de base infligés par miryam augmentent de 15 % pendant ce combat"
  },
  State_2881_Name = {
    Text = "Illusion éclatée"
  },
  State_2883_Desc = {
    Text = "Équipe Unique : Après que le Porteur inflige des Dégâts Directs, il y a <WeaponEffect_Num:[StateArg1]%> de chances de Piocher 1 de ses Cartes d'instruction et de réduire son Coût d'Arithmetica de 1. Cet effet ne s'active qu'une fois par tour."
  },
  State_2883_WeaponDesc = {
    Text = "Après que le Porteur inflige des Dégâts Directs, il y a <WeaponEffect_Num:[StateArg1]%> de chances de Piocher 1 de ses Cartes d'instruction et de réduire son Coût d'Arithmetica de 1. Cet effet ne s'active qu'une fois par tour."
  },
  State_2884_Name = {
    Text = "Les dégâts infligés sont des <PunctureDamagewords:dommages perforants>. Réduisez de 1 la consommation de pouvoir de la carte ayant le plus de pouvoir en main"
  },
  State_2885_Name = {
    Text = "État@Pioche+2DébutTour"
  },
  State_2887_Desc = {
    Text = "Unique dans l'équipe : Après que l'équipier libère l'exalter, les dégâts critiques de ce tour augmentent de <WeaponEffect_Num:[StateArg1]%, et toutes les cartes de l'équipier en main ont une probabilité de <WeaponEffect_Num:[StateArg2]%> de réduire la consommation d'arithmetica de 1 ce tour"
  },
  State_2887_WeaponDesc = {
    Text = "Après que l'attaquant libère l'exalte, ses dégâts critiques pour ce tour augmentent de <WeaponEffect_Num:[StateArg1]%>, toutes les cartes de l'attaquant en main ont une probabilité de <WeaponEffect_Num:[StateArg2]%> de réduire la consommation d'arithmetica de 1 point pour ce tour"
  },
  State_2888_Desc = {
    Text = "S'il y a un \"Embryon\" dans ta main, détruis 1 pour déclencher les effets suivants."
  },
  State_2888_Name = {
    Text = "<DevouredIconKeywords:Dévoré>"
  },
  State_2888_WeaponDesc = {
    Text = "Consomme l'embryon dans la main pour déclencher un puissant effet de dévoration"
  },
  State_2889_Name = {
    Text = "Choisissez un éveillé pour gagner <Energy:[DescArg1]> points de folie"
  },
  State_2890_Desc = {
    Text = "Au début de la bataille, infligez une couche de faiblesse à notre équipe"
  },
  State_2890_Name = {
    Text = "Pénétration d'armure"
  },
  State_2890_WeaponDesc = {
    Text = "Au début de la bataille, infligez une couche de faiblesse à notre équipe"
  },
  State_2891_Name = {
    Text = "Augmentation de Répondre d'Ouverture de Fureur"
  },
  State_2892_Desc = {
    Text = "À la fin du tour, récupère [Layer] points de vie."
  },
  State_2892_Name = {
    Text = "Régénération de Vie Retardée"
  },
  State_2892_WeaponDesc = {
    Text = "Jusqu'à la fin du tour, chaque fois que vous tuez, récupérez [Layer] points de vie"
  },
  State_2897_Desc = {
    Text = "Libérer la genèse des départs réduit la puissance temporaire des ennemis"
  },
  State_2897_Name = {
    Text = "Crainte de la folie"
  },
  State_2899_Desc = {
    Text = "Si l'adversaire a 4 cartes ou plus en main, gagne [StateArg1] points de bouclier en subissant des dégâts"
  },
  State_2899_Name = {Text = "Serpent"},
  State_2900_Desc = {
    Text = "Les dégâts infligés dans ce combat augmentent de [Layer] points"
  },
  State_2900_Name = {Text = "Force"},
  State_2900_WeaponDesc = {
    Text = "Les dégâts infligés dans ce combat augmentent de [Layer] points"
  },
  State_2901_Desc = {
    Text = "[exalter] accorde 20 points de folie à soi-même"
  },
  State_2901_Name = {
    Text = "Voile du dieu sans nom des créations"
  },
  State_2901_WeaponDesc = {
    Text = "[exalter] accorde 20 points de folie à soi-même"
  },
  State_2902_Desc = {
    Text = "Le cerveau dans un bocal double la vie récupérée"
  },
  State_2902_Name = {
    Text = "Séparation de l'âme et du corps"
  },
  State_2902_WeaponDesc = {
    Text = "Le cerveau dans un bocal double la vie récupérée"
  },
  State_2903_Desc = {
    Text = "Augmentation des dégâts, bouclier et guérison de l'équipementeur de [StateArg1]%. (temporaire)"
  },
  State_2903_Name = {
    Text = "État@Critique du couteau prototype"
  },
  State_2904_Desc = {
    Text = "Chaque fois que vous subissez des dégâts réels, obtenez 10 boucliers"
  },
  State_2904_Name = {Text = "tampon"},
  State_2904_WeaponDesc = {
    Text = "Chaque fois que vous subissez des dégâts réels, obtenez 10 boucliers"
  },
  State_2905_Desc = {
    Text = "Équipe unique : Le bouclier causé par l'« Exaltation » du porteur augmente de <WeaponEffect_Num:[StateArg2] %>. Après que le porteur ait libéré l'« Exaltation », il obtient un <PowerIconKeywords:Force> temporaire équivalent à <WeaponEffect_Num:[StateArg1]%> charges de la défense du porteur. Si notre équipe est dans un état de <FragileIconKeywords:Fragile>, l'effet est doublé."
  },
  State_2905_WeaponDesc = {
    Text = "Le bouclier causé par l'exaltation du porteur augmente de <WeaponEffect_Num:[StateArg2] %>. Après que le porteur a libéré l'exaltation, il obtient [Power:DescArg1] points de <PowerIconKeywords:force> temporaires. Si notre équipe est dans un état de <FragileIconKeywords:Fragile>, l'effet est doublé."
  },
  State_2906_Desc = {
    Text = "Réduisez temporairement la force de l'équipe de [Layer] points après avoir infligé des dégâts réels"
  },
  State_2906_Name = {
    Text = "Paralysie électrique"
  },
  State_2909_Desc = {
    Text = "Possède [Layer] points de délires. Si les délires atteignent 5 ou plus, l'intention devient « festin des morts tordus », et cette quantité de délires diminue ensuite"
  },
  State_2909_Name = {
    Text = "État@monstre 24 festin des morts tordus comptage"
  },
  State_2909_WeaponDesc = {
    Text = "Possède [Layer] points de délires. Si les délires atteignent 5 ou plus, l'intention devient « festin des morts tordus », et cette quantité de délires diminue ensuite"
  },
  State_2910_Desc = {
    Text = "Unique à l'équipe : Au début de l'exploration, ajoutez une carte « Perspicacité » et une carte « Attaque » de l'équipé au deck. Les dégâts de base de « Attaque » de l'équipé augmentent de <WeaponEffect_Num:[StateArg1]%. Après avoir joué, il y a <WeaponEffect_Num:[StateArg2]% de chances de piocher 1 carte. Cet effet peut se déclencher jusqu'à 1 fois par tour. Si le royaume actuel est « Ultra » et pendant le tour Ultra, « Attaque » met 1 carte « Perspicacité » dans la main, cet effet peut se déclencher au maximum 1 fois par tour."
  },
  State_2910_WeaponDesc = {
    Text = "Au début de l'exploration, ajoutez une carte « Perspicacité » et une carte « Attaque » de l'équipé au deck. Les dégâts de base de « Attaque » de l'équipé augmentent de <WeaponEffect_Num:[StateArg1]%>, et après avoir joué, il y a <WeaponEffect_Num:[StateArg2]%> de chance de piocher 1 carte. Cet effet peut se déclencher jusqu'à 1 fois par tour. Si le royaume actuel est « Ultra » et que c'est un Tour Ultra, « Attaque » place 1 carte « Perspicacité » dans la main, cet effet peut se déclencher jusqu'à 1 fois par tour."
  },
  State_2911_Desc = {
    Text = "État@Compteur du monde imaginaire pur"
  },
  State_2911_Name = {
    Text = "État@Compteur du monde imaginaire pur modifié"
  },
  State_2911_WeaponDesc = {
    Text = "État@Compteur du monde imaginaire pur"
  },
  State_2912_Desc = {
    Text = "Tu es verrouillé ! Après que le marin ait lancé, il obtient [StateArg1] points de puissance temporaire, supprimant la marque de plongée de cette instruction"
  },
  State_2912_Name = {
    Text = "<CardKeyWord:Marque de la plongée>"
  },
  State_2912_WeaponDesc = {
    Text = "Après avoir joué la carte, le garde du plongeur obtient [StateArg1] points de force temporaire"
  },
  State_2913_Desc = {
    Text = "Au début de la bataille, vous devenez fragile pendant 3 tours"
  },
  State_2913_Name = {
    Text = "Griffe étrange des créations 2"
  },
  State_2913_WeaponDesc = {
    Text = "Au début de la bataille, vous devenez fragile pendant 3 tours"
  },
  State_2914_Desc = {
    Text = "Lorsque la vie est inférieure à 50%, l'intention change pour invoquer un [Triangle de Dissolution] avec une vie égale."
  },
  State_2914_Name = {Text = "Fission"},
  State_2914_WeaponDesc = {
    Text = "Lorsque la vie est inférieure à 50%, l'intention change pour invoquer un [Triangle de Dissolution] avec une vie égale."
  },
  State_2915_Desc = {
    Text = "Augmentez le nombre d'instances de dégât de \"Chaîne de Ressentiment\" de +[Layer]."
  },
  State_2915_Name = {Text = "Haine"},
  State_2915_WeaponDesc = {
    Text = "Augmentez le nombre d'instances de dégât de \"Chaîne de Ressentiment\" de +[Layer]."
  },
  State_2917_Desc = {
    Text = "À la fin du tour, pour chaque carte restante dans la main, obtenir 1 point d'arsenal au début du prochain tour"
  },
  State_2917_Name = {
    Text = "État@CléD'ArgentDesRêves:Calcul"
  },
  State_2918_Desc = {
    Text = "Les dégâts reçus sont réduits de 99 %. Après avoir reçu des dégâts actifs, suppression d'une couche, régénération à 3 couches au début du tour"
  },
  State_2918_Name = {
    Text = "« Corps Indestructible »"
  },
  State_2918_WeaponDesc = {
    Text = "Les dégâts reçus sont réduits de 99 %. Après avoir reçu des dégâts actifs, suppression d'une couche, régénération à 3 couches au début du tour"
  },
  State_2919_Desc = {
    Text = "État@Avance de l'image d'émeraude"
  },
  State_2919_Name = {
    Text = "État@Avance de l'image d'émeraude"
  },
  State_2919_WeaponDesc = {
    Text = "État@Avance de l'image d'émeraude"
  },
  State_2922_Desc = {
    Text = "Chaque fois que 1 point d'arithmétique est consommé, le réveilleur correspondant obtient 2 points de colère"
  },
  State_2923_Desc = {
    Text = "À la fin du tour, la force augmente de [Layer]"
  },
  State_2923_Name = {
    Text = "Cérémonie de descente divine"
  },
  State_2923_WeaponDesc = {
    Text = "À la fin de chaque tour, gagnez [Layer] points de force"
  },
  State_2925_Desc = {
    Text = "Chaque fois que le Feu Vert inflige des dégâts, le nombre de couches augmente de 1"
  },
  State_2925_Name = {
    Text = "Comptage de l'image d'émeraude"
  },
  State_2925_WeaponDesc = {
    Text = "Chaque fois que le Feu Vert inflige des dégâts, le nombre de couches augmente de 1"
  },
  State_2927_Name = {
    Text = "État@Changement de délire de malédiction"
  },
  State_2929_Desc = {
    Text = "Équipe Unique : Chaque fois que le Porteur inflige des Dommages, il a <WeaponEffect_Num:[StateArg3]%> de chance de gagner 2% de Dommages Critiques Temporaires. Après que le Porteur libère une Exaltation, il inflige 3 fois des Dégâts Directs équivalant à <WeaponEffect_Num:[StateArg1]%> de son ATQ à des ennemis aléatoires. Si le Royaume actuel est «Caro», chaque Embryon Dévoré par le Porteur augmente la Fusion d'Embryon de +<WeaponEffect_Num:[Blood:StateArg2]>."
  },
  State_2929_WeaponDesc = {
    Text = "Chaque fois que le Porteur inflige des Dommages, il a <WeaponEffect_Num:[StateArg3]%> de chance de gagner 2% de Dommages critiques temporaires. Après que le Porteur libère une Exaltation, il inflige 3 fois [DescArg1] points de Dégâts Directs à des ennemis aléatoires. Si le Royaume actuel est «Caro», chaque Embryon Dévoré par le Porteur augmente la Fusion d'Embryon de +<WeaponEffect_Num:[Blood:StateArg2]>."
  },
  State_2930_Name = {
    Text = "État@George@gain de force à la mort"
  },
  State_2931_Desc = {
    Text = "À chaque dévoration, vole 4 points de force temporaire à tous les ennemis"
  },
  State_2931_Name = {
    Text = "Soie d'agate altérée"
  },
  State_2933_Name = {
    Text = "Jumeaux tordus blancs de l'accessoire"
  },
  State_2933_WeaponDesc = {
    Text = "Après le début des tours pairs, ajoutez la \"défense\" d'un porteur d'illusion et d'épuisement à votre main"
  },
  State_2934_Desc = {
    Text = "Tous les Dégâts Directs et Dégâts des tentacules subis +[DescArg1]%."
  },
  State_2934_Name = {
    Text = "<VulnerabilityColour: Vulnérable>"
  },
  State_2934_WeaponDesc = {
    Text = "Augmentation de tous les dégâts subis de 50 %"
  },
  State_2937_Desc = {
    Text = "Après chaque 3ème obtention d'un bouclier, obtenez simultanément un contre-attaque équivalente"
  },
  State_2938_Desc = {
    Text = "Au début du tour, piochez 1 carte, à la fin du tour, vous pouvez conserver 1 carte en main"
  },
  State_2939_Name = {
    Text = "Immunité à la fragilité"
  },
  State_2940_Desc = {
    Text = ": Effet de régénération augmenté"
  },
  State_2940_Name = {
    Text = "Subir l'accentuation du sang aberrant"
  },
  State_2941_Desc = {
    Text = "Après avoir joué, infligez [StateArg1] couches de poison à tous les ennemis, provoquant [StateArg2]% de poison chez tous les ennemis"
  },
  State_2941_Name = {
    Text = "<Rune_10:Toxine>"
  },
  State_2942_Desc = {
    Text = "À la fin du tour, restaure [Layer]% de vie aux alliés et retire les dégâts continus"
  },
  State_2942_Name = {
    Text = "Soin de combat"
  },
  State_2946_Desc = {
    Text = "Un enchaînement fou procure un bouclier extrêmement élevé"
  },
  State_2946_Name = {
    Text = "« Forteresse immobile »"
  },
  State_2946_WeaponDesc = {
    Text = "Un enchaînement fou procure un bouclier extrêmement élevé"
  },
  State_2947_Name = {
    Text = "Dissolution 2"
  },
  State_2948_Desc = {
    Text = "Changez le coût en arithmetica de la carte avant de la jouer"
  },
  State_2948_Name = {
    Text = "Changez le coût en arithmetica de la carte avant de la jouer"
  },
  State_2948_WeaponDesc = {
    Text = "Changez le coût en arithmetica de la carte avant de la jouer"
  },
  State_2949_Name = {
    Text = "Abandonner l'empreinte du combat de la roue du destin"
  },
  State_2951_Desc = {
    Text = "Fauteuil de repos éternel de la création"
  },
  State_2951_Name = {
    Text = "Gants assourdis"
  },
  State_2952_Desc = {
    Text = "Après la fin du tour, récupère [Layer] points de vie. Pour chaque 5 points de vie perdus, retire 1 couche"
  },
  State_2952_Name = {
    Text = "Régénération"
  },
  State_2954_Name = {
    Text = "État@2-8monstre24@aidez-moi"
  },
  State_2955_Desc = {
    Text = "Tous les ennemis perdent de la vie. Permanent, détruit"
  },
  State_2955_Name = {
    Text = "<CardKeyWord:la fin du néant>"
  },
  State_2955_WeaponDesc = {
    Text = "Tous les ennemis perdent de la vie. Permanent, détruit"
  },
  State_2956_Desc = {
    Text = "Chaque fois que 1 point de dégâts est subi, tous les réveilleurs obtiennent [StateArg1] points de folie"
  },
  State_2956_Name = {
    Text = "Faisceau d'illusion"
  },
  State_2956_WeaponDesc = {
    Text = "Chaque fois que 1 point de dégâts est subi, tous les réveilleurs obtiennent [StateArg1] points de folie"
  },
  State_2957_Desc = {
    Text = "Après la mort, invoquez un [Triangle de Dissolution] avec 1/3 de votre valeur de vie en place"
  },
  State_2957_Name = {Text = "Fusion"},
  State_2957_WeaponDesc = {
    Text = "Après la mort, invoquez un [Triangle de Dissolution] avec 1/3 de votre valeur de vie en place"
  },
  State_2960_Desc = {
    Text = "Après les tours pairs, lorsque votre calcul est à 0, obtenez 2 calculs"
  },
  State_2960_Name = {
    Text = "Puzzle ancien altéré"
  },
  State_2960_WeaponDesc = {
    Text = "Après les tours pairs, lorsque votre calcul est à 0, obtenez 2 calculs"
  },
  State_2961_Desc = {
    Text = "Équipe unique : Les <IntoxicationIconKeywords:Poison> infligés par le porteur augmentent de <WeaponEffect_Num:[StateArg1] %>, avant que le porteur ne libère l'exaltation, appliquez un poison équivalent à <WeaponEffect_Num:[StateArg2]%> de l'Attaque du porteur à tous les ennemis. Après avoir utilisé le Décret Clé, le porteur gagne <WeaponEffect_Num:[StateArg3]> points de Fureur."
  },
  State_2961_WeaponDesc = {
    Text = "Les dégâts de <IntoxicationIconKeywords:poison> infligés par le porteur augmentent de <WeaponEffect_Num:[StateArg1] %>. Avant que le porteur ne libère l'exaltation, appliquez <WeaponEffect_Num:[Poison:DescArg1]> couches d'empoisonnement à tous les ennemis. Après avoir utilisé le Décret Clé, le porteur gagne <WeaponEffect_Num:[StateArg3]> points de folie."
  },
  State_2962_Desc = {
    Text = "Après avoir joué, affaiblissez tous les ennemis pour [StateArg1] tours"
  },
  State_2962_Name = {
    Text = "<Rune_2:Faiblesse>"
  },
  State_2965_Name = {
    Text = "État @doppelgänger croissant illuminer 7"
  },
  State_2967_Desc = {
    Text = "Lors de l'utilisation de Cartes de symptômes, l'état de Pandia alterne entre « Agitation » et « Dissipation ». Agitation : instances de Dégâts Directs +1, FOR réduite. Dissipation : instances de Dégâts Directs -1, FOR augmentée."
  },
  State_2967_Name = {
    Text = "Pandia s'éveille !"
  },
  State_2967_WeaponDesc = {
    Text = "Au début du prochain tour, obtenez un bouclier équivalent à la vie perdue au tour précédent"
  },
  State_2968_Name = {
    Text = "État @niveau 2_14 bataille 8 bulle 4"
  },
  State_2969_Name = {
    Text = "État @niveau 2_14 bataille 8 bulle 5"
  },
  State_2970_Desc = {
    Text = "Descendants primordiaux"
  },
  State_2970_Name = {
    Text = "Descendants primordiaux"
  },
  State_2970_WeaponDesc = {
    Text = "Descendants primordiaux"
  },
  State_2971_Desc = {
    Text = "État@PrologueDemiVie"
  },
  State_2971_Name = {
    Text = "État@PrologueDemiVie"
  },
  State_2971_WeaponDesc = {
    Text = "État@PrologueDemiVie"
  },
  State_2972_Name = {
    Text = "État @niveau 2_14 bataille 8 bulle 2"
  },
  State_2973_Name = {
    Text = "État @niveau 2_14 bataille 8 bulle 3"
  },
  State_2975_Desc = {
    Text = "Les 5 premières effets de saut par combat prennent effet une fois de plus"
  },
  State_2976_Desc = {
    Text = "À la fin du tour, si votre bouclier est à 0 ou un multiple de 10, gagnez [Arg1] points de bouclier. Si votre vie est un multiple de 10, gagnez [Arg2] points de force"
  },
  State_2976_Name = {
    Text = "Signal de détresse"
  },
  State_2977_Desc = {
    Text = "Tour impair, si vous avez 0 cartes en main, piochez 2 cartes"
  },
  State_2977_Name = {
    Text = "Puzzle ancien altéré"
  },
  State_2977_WeaponDesc = {
    Text = "Tour impair, si vous avez 0 cartes en main, piochez 2 cartes"
  },
  State_2978_Desc = {
    Text = "Après avoir subi 1 point de dégâts, réduisez 1 couche. Lorsque le nombre de couches atteint 0, passez en mode défense"
  },
  State_2978_Name = {
    Text = "Compteur de cartes"
  },
  State_2978_WeaponDesc = {
    Text = "Après avoir subi 1 point de dégâts, réduisez 1 couche. Lorsque le nombre de couches atteint 0, passez en mode défense"
  },
  State_2979_Desc = {
    Text = "Équipe Unique : Le poison et le bouclier infligés par le porteur augmentent de <WeaponEffect_Num:[StateArg3]%>. Le taux critique et les dégâts critiques de l'« Attaque » du porteur augmentent de <WeaponEffect_Num:[StateArg1]%, et il reçoit un bouclier équivalent à <WeaponEffect_Num:[StateArg2]%> de ses PV max. L'effet du bouclier ne peut se produire qu'une fois par tour."
  },
  State_2979_Name = {
    Text = "Au Travers de la Douleur"
  },
  State_2979_WeaponDesc = {
    Text = "Le poison et le bouclier infligés par le porteur augmentent de <WeaponEffect_Num:[StateArg3]%. Le taux critique et les dégâts critiques de l'« Attaque » du porteur augmentent de <WeaponEffect_Num:[StateArg1]%, et il obtient un bouclier équivalent à [StateArg2]% de la vie maximale ([DescArg1]), l'effet du bouclier ne peut se produire qu'une fois par tour."
  },
  State_2983_Desc = {
    Text = "Si la carte est toujours dans la main au moment de la phase de défausse, elle sera épuisée et n'apparaîtra plus dans cette bataille"
  },
  State_2983_Name = {
    Text = "<NothingnessIconKeywords: Illusion>"
  },
  State_2983_WeaponDesc = {
    Text = "Si la carte est toujours dans la main durant la phase de défausse, elle ne sera pas placée dans la pile de défausse, mais ne pourra pas être utilisée à nouveau dans cette bataille"
  },
  State_2985_Desc = {
    Text = "Jusqu'à la fin du tour, chaque fois que vous infligez des dégâts, récupérez [Layer] points de vie à la fin du tour"
  },
  State_2985_Name = {
    Text = "Œuf de Perle"
  },
  State_2985_WeaponDesc = {
    Text = "Jusqu'à la fin du tour, chaque fois que vous infligez des dégâts, récupérez [Layer] points de vie"
  },
  State_2987_Desc = {
    Text = "Événement19_1"
  },
  State_2987_Name = {
    Text = "Événement19_1"
  },
  State_2987_WeaponDesc = {
    Text = "Événement19_1"
  },
  State_2988_Desc = {
    Text = "Lors de l'absorption de l'embryon, il retourne de la pile de défausse à la main, la capacité arithmétique devient 0"
  },
  State_2988_Name = {
    Text = "Nécessité"
  },
  State_2988_WeaponDesc = {
    Text = "Lors de l'absorption de l'embryon, il retourne de la pile de défausse à la main, la capacité arithmétique devient 0"
  },
  State_2989_Desc = {
    Text = "Après avoir joué une carte d'éveil, insère une copie temporaire de cette carte avec un coût réduit de 1 dans le deck"
  },
  State_2990_Desc = {
    Text = "Après avoir joué, fait perdre à tous les ennemis [StateArg1] points de force temporaire"
  },
  State_2990_Name = {
    Text = "<Rune_18_High:Épuisement avancé>"
  },
  State_2992_Desc = {
    Text = "Après avoir pioché \"Vide\", réduit de 50% la folie gagnée par tous les éveillés ce tour"
  },
  State_2992_Name = {Text = "Vide"},
  State_2992_WeaponDesc = {
    Text = "Après avoir pioché \"Vide\", réduit de 50% la folie gagnée par tous les éveillés ce tour"
  },
  State_2993_Name = {
    Text = "Compteur de la mue de serpent étrange des créations"
  },
  State_2994_Desc = {
    Text = "Lorsque les tentacules débordent, les dégâts de tentacule augmentent de [StateArg1]"
  },
  State_2994_Name = {
    Text = "Force de protection"
  },
  State_2994_WeaponDesc = {
    Text = "Lorsque les tentacules débordent, les dégâts de tentacule augmentent de [StateArg1]"
  },
  State_2996_Desc = {
    Text = "Après avoir joué, fait attaquer 1 tentacule [StateArg1] fois"
  },
  State_2996_Name = {
    Text = "<Rune_11:Domination>"
  },
  State_2997_Desc = {
    Text = "Après avoir infligé des dégâts pour la troisième fois par tour, obtenez [Arg1] points de bouclier. Après avoir infligé des dégâts pour la sixième fois par tour, obtenez [Arg2] points de pouvoir"
  },
  State_2997_Name = {
    Text = "Passage sûr"
  },
  State_3001_Desc = {
    Text = "En étant attaqué, augmentez la folie de 2 points"
  },
  State_3002_Desc = {
    Text = "Augmentation des dégâts, bouclier et guérison de l'équipementeur de [StateArg1]%. (temporaire)"
  },
  State_3002_Name = {
    Text = "État@Chance du canon laser prototype"
  },
  State_3003_Desc = {
    Text = "Après avoir joué, elle ne sera pas mise dans la défausse, mais retirée de la pioche"
  },
  State_3003_Name = {
    Text = "<DepleteIconKeywords:Consommation>"
  },
  State_3003_WeaponDesc = {
    Text = "Après avoir joué, la carte ne sera pas mise dans la défausse et ne pourra pas être utilisée à nouveau dans ce combat"
  },
  State_3004_Desc = {
    Text = "[Layer] Immunisé contre l'empoisonnement pendant le tour"
  },
  State_3004_Name = {
    Text = "Immunité au poison"
  },
  State_3008_Desc = {
    Text = "Au début de chaque tour, ajoutez 1 couche de ralentissement aux cartes restantes en main. Pour les cartes dont le coût en arithmétique dépasse 5, transformez-les en pierre"
  },
  State_3008_Name = {
    Text = "Aegis Éveil!"
  },
  State_3008_WeaponDesc = {
    Text = "Au début du prochain tour, obtenez un bouclier équivalent à la vie perdue au tour précédent"
  },
  State_3011_Desc = {
    Text = "Équipe unique : Le taux critique et les dégâts critiques de l'exaltation du porteur augmentent de <WeaponEffect_Num:[StateArg2] %>. Après que le porteur ait libéré l'exaltation, il obtient un <PowerIconKeywords:Force> équivalent à <WeaponEffect_Num:[StateArg1]%> de sa constitution. Si cette exaltation déclenche l'effet <CardKeyWord:Dévorer>, il obtient un point supplémentaire de <PowerIconKeywords:Force>."
  },
  State_3011_WeaponDesc = {
    Text = "Le taux critique et les dégâts critiques de l'exaltation du porteur augmentent de <WeaponEffect_Num:[StateArg2] %>. Après que le porteur ait libéré l'exaltation, il obtient <WeaponEffect_Num:[Power:DescArg1]> points de force. Si cette exaltation déclenche l'effet <CardKeyWord:Dévorer>, il obtient un point supplémentaire de <PowerIconKeywords:Force>."
  },
  State_3012_Desc = {
    Text = "État vide inutile"
  },
  State_3012_Name = {
    Text = "État vide inutile"
  },
  State_3012_WeaponDesc = {
    Text = "État vide inutile"
  },
  State_3013_Desc = {
    Text = "Les patients en soif de sang augmentent la fusion d'embryons, obtenant [StateArg1] points de pouvoir"
  },
  State_3013_Name = {
    Text = "Soif de sang"
  },
  State_3014_Desc = {
    Text = "Si l'adversaire a 4 cartes ou plus en main, gagne [StateArg1] points de bouclier en subissant des dégâts"
  },
  State_3014_Name = {Text = "Serpent"},
  State_3015_Desc = {
    Text = "État@Armure de cire: Équipe"
  },
  State_3015_Name = {
    Text = "État@Armure de cire: Équipe"
  },
  State_3015_WeaponDesc = {
    Text = "État@Armure de cire: Équipe"
  },
  State_3016_Desc = {
    Text = "Les points de vie des monstres invoqués sont doublés"
  },
  State_3016_Name = {
    Text = "« Regret éternel »"
  },
  State_3016_WeaponDesc = {
    Text = "Les points de vie des monstres invoqués sont doublés"
  },
  State_3017_Name = {
    Text = "État@Délire de malédiction"
  },
  State_3018_Desc = {
    Text = "\"Chien Dimensionnel\" enlève 1 couche pour chaque vie perdue ; lorsque les couches atteignent 0, gagnez un bouclier [StateArg1] et regagnez des barrières dimensionnelles [StateArg2]."
  },
  State_3018_Name = {
    Text = "Barrière dimensionnelle"
  },
  State_3019_Desc = {
    Text = "Chaque consommation de 10 sigils noirs restaure 1% de vie"
  },
  State_3019_Name = {
    Text = "État de la racine inversée de la création"
  },
  State_3019_WeaponDesc = {
    Text = "Chaque consommation de 10 sigils noirs restaure 1% de vie"
  },
  State_3020_Desc = {
    Text = "Si tu as subi des dégâts au tour précédent, gagne 1 tour d'immunité au début du tour"
  },
  State_3020_Name = {Text = "Adaptation"},
  State_3020_WeaponDesc = {
    Text = "Si tu as subi des dégâts au tour précédent, gagne 1 tour d'immunité au début du tour"
  },
  State_3021_Desc = {
    Text = "Au début du tour, gagner 1 arithmetica"
  },
  State_3021_Name = {
    Text = "État@calcul max -2"
  },
  State_3023_Desc = {
    Text = "Chaque fois que des Dégâts Directs sont subis durant ce tour, inflige [Layer] <FixedDamage:DGT Purs> à la source des dégâts."
  },
  State_3023_Name = {
    Text = "Contre-attaque temporaire"
  },
  State_3023_WeaponDesc = {
    Text = "Chaque fois que des Dégâts Directs sont subis, inflige [Layer] <FixedDamage:DGT Purs> à l'attaquant."
  },
  State_3024_Desc = {
    Text = "Augmentation des dégâts, bouclier et guérison de l'équipementeur de [StateArg1]%. (temporaire)"
  },
  State_3024_Name = {
    Text = "État@Résistance à la mort du couteau prototype"
  },
  State_3025_Desc = {
    Text = "Chaque fois que vous jouez 1 carte, augmentez votre fréquence critique dans ce tour de 10 %"
  },
  State_3026_Desc = {
    Text = "Après le début du combat, [StateArg1] cartes temporaires sont mélangées dans la pile de cartes, les cartes originales et les cartes miroir obtiennent conserver"
  },
  State_3026_Name = {
    Text = "<Rune_8_High:Mirage avancé>"
  },
  State_3026_WeaponDesc = {
    Text = "Après le début du combat, [StateArg1] cartes temporaires sont mélangées dans la pile de cartes"
  },
  State_3027_Desc = {
    Text = "Après le combat, obtenez 50 sigils noirs supplémentaires et 1 carte de symptômes"
  },
  State_3028_Name = {
    Text = "État @arithmetica +2 après le début du tour"
  },
  State_3029_Desc = {
    Text = "Après avoir subi 1 point de dégâts, réduisez 1 couche. Lorsque le nombre de couches atteint 0, passez en mode défense"
  },
  State_3029_Name = {
    Text = "Compteur de cartes"
  },
  State_3029_WeaponDesc = {
    Text = "Après avoir subi 1 point de dégâts, réduisez 1 couche. Lorsque le nombre de couches atteint 0, passez en mode défense"
  },
  State_3033_Desc = {
    Text = "Chaque fois que vous jouez 10 cartes, obtenez 1 couche de barrière qui bloque tous les dégâts. Si vous avez déjà une barrière, restaurez plutôt [Arg1] points de vie"
  },
  State_3034_Desc = {
    Text = "Équipe unique : Pour chaque carte jouée de l'équipement, obtenir <WeaponEffect_Num:[StateArg1]> de s-énergie. Cet effet ne peut se produire que 3 fois par tour"
  },
  State_3034_WeaponDesc = {
    Text = "Chaque fois que vous jouez 1 carte d'équipement, obtenez <WeaponEffect_Num:[StateArg1]> s-énergie. Cet effet ne peut être actif qu'un maximum de 3 fois par tour"
  },
  State_3035_Desc = {
    Text = "Après avoir joué, fait attaquer 1 tentacule [StateArg1] fois"
  },
  State_3035_Name = {
    Text = "<Rune_11_High:Domination avancée>"
  },
  State_3035_WeaponDesc = {
    Text = "Après avoir joué, fait attaquer 1 tentacule tous les ennemis [StateArg1] fois"
  },
  State_30364_Desc = {
    Text = "Cette carte augmente la limite de main de +1 lorsqu'elle est dans la main"
  },
  State_30364_Name = {
    Text = "Ignorer la limite de cartes en main"
  },
  State_30369_Desc = {
    Text = "Ce tour, limite de cartes en main +[Layer]"
  },
  State_30369_Name = {
    Text = "Limite Max de la Main"
  },
  State_3036_Desc = {
    Text = "Effets de fragilité et de faiblesse augmentés de 33 % à 50 %"
  },
  State_3036_Name = {
    Text = "\"Ondes de Silence\""
  },
  State_3036_WeaponDesc = {
    Text = "Effets de fragilité et de faiblesse augmentés de 33 % à 50 %"
  },
  State_3038_Desc = {
    Text = "Unique à l'équipe : Après avoir utilisé une clé, l'équipé gagne <WeaponEffect_Num:[StateArg1]> de folie"
  },
  State_3038_WeaponDesc = {
    Text = "Après avoir libéré le Sceau, l'équipé gagne <WeaponEffect_Num:[StateArg1]> folie"
  },
  State_3040_Desc = {
    Text = "Au début de chaque tour, appliquez [Layer] couches de \"Contrainte\" à votre équipe"
  },
  State_3040_Name = {Text = "Contrainte"},
  State_3040_WeaponDesc = {
    Text = "Au début de chaque tour, appliquez [Layer] couches de \"Contrainte\" à votre équipe"
  },
  State_3041_Desc = {
    Text = "Conservé en permanence dans le deck"
  },
  State_3041_Name = {
    Text = "<CardKeyWord:Carte de symptôme>"
  },
  State_3042_Desc = {
    Text = "Chaque fois que vous infligez des dégâts, obtenez [Arg1] force temporaire pour ce tour, jusqu'à 3 fois. L'effet est doublé lorsque les couches sont pleines"
  },
  State_3043_Desc = {
    Text = "Les tours paires, les dégâts subis sont réduits de 50 %, les dégâts infligés augmentent de 33 %"
  },
  State_3043_Name = {Text = "Capricieux"},
  State_3043_WeaponDesc = {
    Text = "Les tours paires, les dégâts subis sont réduits de 50 %, les dégâts infligés augmentent de 33 %"
  },
  State_3045_Desc = {
    Text = "Après avoir libéré l'exaltation de la folie, le réveilleur correspondant obtient 20 de folie"
  },
  State_3045_Name = {
    Text = "Voile du Dieu Sans Nom"
  },
  State_3046_Desc = {
    Text = "Équipe Unique : Chaque fois qu'un ennemi meurt, obtenez [StateArg1] marques noires. Après qu'un porteur élimine un ennemi, les dégâts critiques du porteur pour ce niveau augmentent de manière permanente de <WeaponEffect_Num:[StateArg2]%>, avec un maximum de 5 empilements. Chaque fois que le porteur déclenche l'effet de saut quantique, les dégâts finaux infligés par le porteur ce tour augmentent de <WeaponEffect_Num:[StateArg3]%>, avec un maximum de 3 empilements."
  },
  State_3046_WeaponDesc = {
    Text = "Chaque fois qu'un ennemi meurt, obtenez [StateArg1] marques noires. Lorsque le porteur élimine un ennemi, les dégâts critiques du porteur augmentent de manière permanente de <WeaponEffect_Num:[StateArg2]%> dans ce niveau, avec un maximum de 5 empilements. Chaque fois que le porteur déclenche un effet de saut quantique, les dégâts finaux infligés par le porteur ce tour-ci augmentent de <WeaponEffect_Num:[StateArg3]%>, avec un maximum de 3 empilements."
  },
  State_3047_Desc = {
    Text = "Au début du tour, gagnez [Arg1] de bouclier, chaque tour augmente ce bouclier de [Arg2]"
  },
  State_3047_Name = {
    Text = "Main du Gardien"
  },
  State_3048_Desc = {
    Text = "La volonté de combat de Lotan ne connaît pas de repos. À la fin de chaque tour, Lotan dissipe 3 couches de faiblesse et de vulnérabilité"
  },
  State_3048_Name = {
    Text = "Rothan s'éveille"
  },
  State_3049_Desc = {
    Text = "Augmente le nombre de dégâts de la prochaine attaque de George de 1"
  },
  State_3049_Name = {Text = "Rancœur"},
  State_3049_WeaponDesc = {
    Text = "Augmente le nombre de dégâts de la prochaine attaque de George de 1"
  },
  State_3050_Desc = {
    Text = "Au début de la bataille, mélangez une [Convulsion] dans votre pile de pioche."
  },
  State_3050_Name = {Text = "Peur"},
  State_3050_WeaponDesc = {
    Text = "Au début de la bataille, mélangez une [Convulsion] dans votre pile de pioche."
  },
  State_3051_Desc = {
    Text = "Lorsqu'une blessure non bloquée est infligée, placez une carte « cri » dans la pile de pioche"
  },
  State_3051_Name = {
    Text = "Désir ardent des gouttes de cire"
  },
  State_3051_WeaponDesc = {
    Text = "Lors de la causation de dégâts réels, mélanger une carte «crié» dans la pile de tirage"
  },
  State_3054_Name = {
    Text = "État@Choc de malédiction"
  },
  State_3055_Desc = {
    Text = "Au début de la bataille, infligez une couche de faiblesse à notre équipe"
  },
  State_3055_Name = {
    Text = "Pénétration"
  },
  State_3055_WeaponDesc = {
    Text = "Au début de la bataille, infligez une couche de faiblesse à notre équipe"
  },
  State_3056_Desc = {
    Text = "À la fin du tour, retirer 1 couche de faiblesse et vulnérabilité"
  },
  State_3056_Name = {
    Text = "Intimidation"
  },
  State_3058_Desc = {
    Text = "Pour chaque tentacule, gagne [Arg1] points de bouclier à la fin du tour"
  },
  State_3058_Name = {
    Text = "Appendice sans nom"
  },
  State_3060_Desc = {
    Text = "Au début du prochain tour, obtenez [Layer] points de bouclier"
  },
  State_3060_Name = {
    Text = "Reconstruction mentale"
  },
  State_3060_WeaponDesc = {
    Text = "Au début du prochain tour, piochez [Layer] cartes"
  },
  State_3063_Desc = {
    Text = "Chaque fois que vous infligez des dégâts réels, ajoutez [Layer] poison"
  },
  State_3063_Name = {Text = "Toxine"},
  State_3064_Desc = {
    Text = "Recevez des dégâts égaux au nombre de couches avant de jouer une carte. Se dissipe à la fin du tour"
  },
  State_3064_Name = {Text = "Contrainte"},
  State_3064_WeaponDesc = {
    Text = "Recevez des dégâts égaux au nombre de couches avant de jouer une carte. Se dissipe à la fin du tour"
  },
  State_3065_Name = {
    Text = "État@Création: Offrande passée 2"
  },
  State_3068_Desc = {
    Text = "En fin de tour, subissez [Layer] <FixedDamage:DGT Purs>."
  },
  State_3068_Name = {
    Text = "<IntoxicationColour:Empoisonnement>"
  },
  State_3068_WeaponDesc = {
    Text = "En fin de tour, subissez [Layer] <FixedDamage:DGT Purs>."
  },
  State_3069_Name = {
    Text = "Descente mécanique de l'accessoire"
  },
  State_3069_WeaponDesc = {
    Text = "Au premier tour de chaque combat, obtenez 1 point d'arythmétique supplémentaire"
  },
  State_3070_Desc = {
    Text = "Unique à l'équipe : Les « frappes » de l'équipé font perdre à l'ennemi cible une <PowerIconKeywords:force> temporaire égale à <WeaponEffect_Num:[StateArg1]%> de l'attaque de l'équipé. Cet effet peut se déclencher jusqu'à 3 fois par tour"
  },
  State_3070_WeaponDesc = {
    Text = "L'attaque de l'équipé réduit temporairement la <WeaponEffect_Num:[Power:DescArg1]> de <PowerIconKeywords:force> de l'ennemi ciblé. Effet max 3 fois par tour"
  },
  State_3071_Desc = {
    Text = "Unique à l'équipe : Après avoir joué \"Défense\" de l'équipé, gagne une <PowerIconKeywords:Force> temporaire égale à <WeaponEffect_Num:[StateArg1]%> de l'attaque de l'équipé"
  },
  State_3071_WeaponDesc = {
    Text = "En jouant la \"Défense\" de l'équipement, gagnez <WeaponEffect_Num:[Power:DescArg1]> points de <PowerIconKeywords:force> temporaire"
  },
  State_3072_Desc = {
    Text = "Unique à l'équipe : Après avoir tué un ennemi, l'équipé gagne <WeaponEffect_Num:[StateArg1]> folie et 1% de dégâts critiques, valable pour toute l'exploration"
  },
  State_3072_WeaponDesc = {
    Text = "Après avoir tué un ennemi, l'équipé gagne <WeaponEffect_Num:[StateArg1]> de folie et 1% de dégâts critiques pour toute l'exploration"
  },
  State_3073_Desc = {
    Text = "Équipe unique : après que l'équipement libère l'exaltation, le taux critique de tous les alliés augmente de <WeaponEffect_Num:[StateArg1]%> ce tour"
  },
  State_3073_WeaponDesc = {
    Text = "Après que l'attaquant libère l'exalte, tous les alliés ont leur taux critique augmenté de <WeaponEffect_Num:[StateArg1]%> pour ce tour"
  },
  State_3074_Desc = {
    Text = "Équipe unique : Après avoir joué une carte de symptôme, l'équipement obtient <WeaponEffect_Num:[StateArg1]> points de folie. Cet effet peut se produire jusqu'à 2 fois par tour. Après avoir joué 1 carte de commandement, l'équipement obtient 1 point de folie"
  },
  State_3074_WeaponDesc = {
    Text = "Après avoir joué une carte de symptôme, l'équipement reçoit <WeaponEffect_Num:[StateArg1]> points de aliemus. Cet effet peut se déclencher au maximum 2 fois en un tour. Après que l'équipement ait joué une carte de commandement, gagnez 1 point de aliemus"
  },
  State_3075_Desc = {
    Text = "L'unique de l'équipe : après que l'équipement a libéré l'exalter, il reçoit un bouclier équivalent à <WeaponEffect_Num:[StateArg1]%> de la défense de l'équipement"
  },
  State_3075_Name = {
    Text = "Barrière du cœur"
  },
  State_3075_WeaponDesc = {
    Text = "Après que l'équipementier ait libéré l'exalter, il obtient <WeaponEffect_Num:[Block:DescArg1]> points de bouclier"
  },
  State_3076_Desc = {
    Text = "Équipe Unique : Après avoir infligé des Dégâts Directs, le Taux Critique du Porteur + <WeaponEffect_Num:[StateArg1]%>. Après un coup critique, le Taux Critique obtenu grâce à cet effet est réinitialisé."
  },
  State_3076_WeaponDesc = {
    Text = "Après avoir infligé des Dégâts Directs, le Taux Critique du Porteur + <WeaponEffect_Num:[StateArg1]%>. Après un coup critique, le Taux Critique obtenu grâce à cet effet est réinitialisé."
  },
  State_3078_Desc = {
    Text = "Ce tour, dégâts infligés sont toujours critiques"
  },
  State_3078_Name = {
    Text = "Temporairement garanti pour exploser"
  },
  State_3078_WeaponDesc = {
    Text = "Le taux critique augmente de 100 % pendant ce tour"
  },
  State_3082_Desc = {
    Text = "Après avoir libéré l'exaltation, placez une carte aléatoire correspondante au réveilleur dans votre main, cette carte obtient l'épuisement et l'illusion"
  },
  State_3082_Name = {
    Text = "mallette du médecin"
  },
  State_3084_Desc = {
    Text = "Après avoir joué, copie [StateArg1] cartes dans l'<DimensionalSpaceIconKeywords:espace dimensionnel> temporaire"
  },
  State_3084_Name = {
    Text = "<Rune_13_High:Distorsion avancée>"
  },
  State_3084_WeaponDesc = {
    Text = "Après avoir joué, consomme, mais ajoute [StateArg1] copies temporaires dans l'espace dimensionnel"
  },
  State_3087_Desc = {
    Text = "Dégâts des cartes de coup augmentés de [Layer] %"
  },
  State_3087_Name = {
    Text = "Dégâts des cartes de coup temporairement augmentés"
  },
  State_3087_WeaponDesc = {
    Text = "Dégâts des cartes de coup augmentés de [Layer] %"
  },
  State_3088_Desc = {
    Text = "Les dégâts directs reçus augmentent de [Layer]. Chaque fois que des dégâts sont reçus, la blessure de fusion s'élargit, régénération au début du tour."
  },
  State_3088_Name = {
    Text = "Profonde Érosion"
  },
  State_3088_WeaponDesc = {
    Text = "Les dégâts actifs reçus augmentent de [Layer]. Chaque coup élargit la plaie corrodée, régénération au début du tour"
  },
  State_3092_Name = {
    Text = "Si c'est un combat de chefs, tous les réveilleurs gagnent 30 aliemus et lèvent l'état scellé"
  },
  State_3093_Name = {
    Text = "État@CompteurImitationMagicien"
  },
  State_3094_Desc = {
    Text = "Rend le joueur vulnérable 1 tour à la pioche. Rend tous les ennemis vulnérables 1 tour après utilisation. Non vendable"
  },
  State_3094_Name = {
    Text = "État: Effondrement de malédiction"
  },
  State_3094_WeaponDesc = {
    Text = "Rend le joueur vulnérable 1 tour à la pioche. Rend tous les ennemis vulnérables 1 tour après utilisation. Non vendable"
  },
  State_3095_Desc = {
    Text = "Les dégâts augmentent de [Layer] points dans ce niveau"
  },
  State_3095_Name = {
    Text = "Force Permanente"
  },
  State_3095_WeaponDesc = {
    Text = "Les dégâts augmentent de [Layer] points dans ce niveau"
  },
  State_3096_Desc = {
    Text = "Il reste encore un long chemin à parcourir pour convaincre Lotan"
  },
  State_3096_Name = {
    Text = "Rothan s'éveille"
  },
  State_3098_Desc = {
    Text = "Après la collecte, choisir une carte, rendant son coût en arithmétique permanent à 1"
  },
  State_3099_Desc = {
    Text = "Après avoir libéré l'exaltation, gagnez [Arg1] pouvoir dans ce tour"
  },
  State_3100_Desc = {
    Text = "Au début de chaque tour, la résistance à la mort augmente de 10 %. Lorsque la résistance à la mort dépasse 100 %, gagnez 30 points de maîtrise des royaumes"
  },
  State_3104_Desc = {
    Text = "Ce tour, chaque fois que vous subissez des dégâts actifs, \"Démon Doux\" inflige un coup supplémentaire"
  },
  State_3104_Name = {
    Text = "Partage de la douleur"
  },
  State_3104_WeaponDesc = {
    Text = "Ce tour, chaque fois que vous subissez des dégâts actifs, \"Démon Doux\" inflige un coup supplémentaire"
  },
  State_3106_Desc = {
    Text = "Quand la vie est inférieure à 50% ([StateArg1]), elle se divise en 2 \"Œuvres expérimentales\" avec une vie égale"
  },
  State_3106_Name = {Text = "Fissure"},
  State_3106_WeaponDesc = {
    Text = "Lorsque la vie est inférieure à 50% ([StateArg1]), elle se divisera en 3 \"sculptures de cire de type II\" ayant une vie équivalente"
  },
  State_3108_Name = {
    Text = "Poème circulaire de l'accessoire"
  },
  State_3108_WeaponDesc = {
    Text = "Après le début des tours pairs, obtenez 1 point de calcul"
  },
  State_3109_Name = {
    Text = "État@chapitre 4 résonance@réduction de calcul -1"
  },
  State_3109_WeaponDesc = {
    Text = "“Le don innocent” réduit le coût de capacité de 1"
  },
  State_3110_Name = {
    Text = "État@chapitre 4 résonance@réduction de calcul -1"
  },
  State_3110_WeaponDesc = {
    Text = "“Le don innocent” réduit le coût de capacité de 1"
  },
  State_3111_Desc = {
    Text = "Au début du prochain tour, convertissez le bouclier restant en 2x vie"
  },
  State_3111_Name = {
    Text = "Fleur immortelle"
  },
  State_3112_Desc = {
    Text = "Équipe Unique : Le poison infligé par le porteur est augmenté de <WeaponEffect_Num:[StateArg3]%>. Après que le porteur a libéré l'Exaltation, il récupère une vie équivalente à <WeaponEffect_Num:[StateArg1]%> de sa Constitution, et pour chaque point d'Arithmetica restant, il récupère en plus <WeaponEffect_Num:[StateArg2]%> de sa Constitution en vie."
  },
  State_3112_Name = {
    Text = "Festin Silencieux"
  },
  State_3112_WeaponDesc = {
    Text = "Le poison causé par le porteur augmente de <WeaponEffect_Num:[StateArg3] %>. Après que le porteur ait libéré l'exaltation, il récupère <WeaponEffect_Num:[Heal:DescArg1]> points de PV, et pour chaque point d'arithmetica restant, il récupère en plus <WeaponEffect_Num:[Heal:DescArg2]> points de PV."
  },
  State_3113_Desc = {
    Text = "État@PrologueFolie0_1_4"
  },
  State_3113_Name = {
    Text = "État@PrologueFolie0_1_4"
  },
  State_3113_WeaponDesc = {
    Text = "État@PrologueFolie0_1_4"
  },
  State_3114_Desc = {
    Text = "État@PrologueFolie0_1_2"
  },
  State_3114_Name = {
    Text = "État@PrologueFolie0_1_2"
  },
  State_3114_WeaponDesc = {
    Text = "État@PrologueFolie0_1_2"
  },
  State_3115_Desc = {
    Text = "État@PrologueFolie0_1_2"
  },
  State_3115_Name = {
    Text = "État@PrologueFolie0_1_2"
  },
  State_3115_WeaponDesc = {
    Text = "État@PrologueFolie0_1_2"
  },
  State_3116_Name = {
    Text = "État@PrologueFolie0_1_1"
  },
  State_3117_Desc = {
    Text = "Équipe Unique : Les dégâts de base de l'équipement « Attaque » et « Exaltation » augmentent de <WeaponEffect_Num:[StateArg1]%>. Après avoir joué « Attaque », le porteur obtient 5% de taux critique temporaire, maximum 3 fois par tour, atteignant 15% de dommages critiques temporaires après 3 fois."
  },
  State_3117_WeaponDesc = {
    Text = "Les dégâts de base de l'équipement « coup » et « exalter » augmentent <WeaponEffect_Num:[StateArg1]%>. Après avoir joué « coup », le porteur obtient 5% de taux critique temporaire, maximum 3 fois par tour, atteignant 15% de dégâts critiques temporaires après 3 fois"
  },
  State_3118_Desc = {
    Text = "Au début du tour, restaurez [Layer]% des points de vie perdus."
  },
  State_3118_Name = {
    Text = "Protection de la Voile du Pilote"
  },
  State_3120_Desc = {
    Text = "[défense] obtient [Arg1] niveaux de comptoir"
  },
  State_3121_Desc = {
    Text = "Si l'intention de l'ennemi n'est pas d'attaquer, infligez des dégâts actifs ou de tentacule, et ajoutez un saignement égal à la moitié des niveaux de dégâts infligés"
  },
  State_3123_Desc = {
    Text = "Équipe Unique : La <RetaliateIconKeywords:Contre-attaque> du Porteur augmente de <WeaponEffect_Num:[StateArg3]%>. Chaque fois qu'il subit une attaque, il reçoit une <PowerIconKeywords:Force> Temporaire équivalente à <WeaponEffect_Num:[StateArg1]%> de l'Attaque du Porteur. Après que le Porteur a utilisé l'Exaltation, il gagne une <RetaliateIconKeywords:Contre-attaque> équivalente à <WeaponEffect_Num:[StateArg2]%> de l'Attaque du Porteur."
  },
  State_3123_WeaponDesc = {
    Text = "Le contre-attaque causé par le porteur augmente de <WeaponEffect_Num:[StateArg3] %>. Pour chaque attaque subie, il obtient <WeaponEffect_Num:[Power:DescArg1]> points de <PowerIconKeywords:force> temporaire. Après que le porteur ait utilisé l'exaltation, il obtient <WeaponEffect_Num:[Counterattack:DescArg2]> points de contre-attaque."
  },
  State_3124_Desc = {
    Text = "Le sigil noir acquis par le détective chanceux est doublé"
  },
  State_3124_Name = {
    Text = "Chance exceptionnelle"
  },
  State_3124_WeaponDesc = {
    Text = "Le sigil noir acquis par le détective chanceux est doublé"
  },
  State_3127_Name = {
    Text = "État @niveau 2_10 bataille 3 bulle 1"
  },
  State_3128_Desc = {
    Text = "Les effets de bouclier et de régénération de vie infligés par tous les éveillés augmentent de [StateArg1]%"
  },
  State_3128_Name = {Text = "berceau"},
  State_3129_Desc = {
    Text = "Avant le début du prochain tour, chaque instance de Dégâts Directs subis déclenche [Layer] contre-attaques supplémentaires et contre-attaques de Tentacule, infligeant 50% de dégâts."
  },
  State_3129_Name = {
    Text = "Garde de l'Écaille Inverse"
  },
  State_3130_Desc = {
    Text = "Ce tour, dégâts infligés augmentés de [Layer]"
  },
  State_3130_Name = {
    Text = "Force Temporaire"
  },
  State_3130_WeaponDesc = {
    Text = "Ce tour, dégâts infligés augmentés de [Layer]"
  },
  State_3135_Desc = {
    Text = "Pour chaque couche possédée, le nombre d'attaques actives augmente de 1."
  },
  State_3135_Name = {
    Text = "<MadnessIconKeywords:folie>"
  },
  State_3136_Name = {Text = "Fureur"},
  State_3137_Desc = {
    Text = "Au début de la bataille, obtenez 1 tentacule, les dégâts de tentacule augmentent de manière permanente [Arg1]"
  },
  State_3138_Name = {
    Text = "Paradoxe de l'accessoire"
  },
  State_3138_WeaponDesc = {
    Text = "Après que l'équipement a utilisé l'exaltation, l'équipe reçoit <RetaliateIconKeywords:comptoir> égal à 100 % de la défense de l'équipement. Et augmente le<RetaliateIconKeywords:comptoir> actuel de 10 %"
  },
  State_3139_Desc = {
    Text = "Après être entrée dans un tour d'ultra, annulez votre état de faiblesse et de fragilité, et affaiblissez et rendez vulnérables tous les ennemis pendant 2 tours"
  },
  State_3140_Desc = {
    Text = "Au début du combat, placez « fantasme » dans l'espace ultra, jusqu'à ce que votre espace ultra atteigne 4 cartes"
  },
  State_3143_Desc = {
    Text = "L'équipe perd [Layer] points de force temporaire après avoir infligé des dégâts réels"
  },
  State_3143_Name = {Text = "Paralysie"},
  State_3144_Name = {
    Text = "Les couches de \"poison\" et de \"saignement\" de notre équipe sont réduites de moitié"
  },
  State_3145_Desc = {
    Text = "Pendant [Layer] tours, les cartes ne peuvent pas être utilisées"
  },
  State_3145_Name = {
    Text = "Impossible à jouer la carte"
  },
  State_3146_Desc = {
    Text = "Quand l'Apôtre de la mer joue 1 carte, il génère [StateArg1] tentacules temporaires, ignorant la limite de tentacules"
  },
  State_3146_Name = {
    Text = "Pouvoir délégué"
  },
  State_3146_WeaponDesc = {
    Text = "Quand l'Apôtre de la mer joue 1 carte, il génère [StateArg1] tentacules temporaires, ignorant la limite de tentacules"
  },
  State_3149_Desc = {
    Text = "Au début du prochain tour, tous les Dégâts Directs et Dégâts des tentacules subis +50%."
  },
  State_3149_Name = {
    Text = "Délai de vulnérabilité"
  },
  State_3149_WeaponDesc = {
    Text = "Augmentation de tous les dégâts subis de 50 %"
  },
  State_3150_Desc = {
    Text = "Après avoir reçu 3 attaques en un tour, gagne 1 stack de Folie Temporaire."
  },
  State_3150_Name = {
    Text = "« Douleur douce »"
  },
  State_3151_Desc = {
    Text = "Après ramassage, gagnez définitivement [Arg1] points de force"
  },
  State_3152_Name = {
    Text = "État@Accessoire: Réévolution"
  },
  State_3152_WeaponDesc = {
    Text = "À la fin du tour, l'équipé gagne 3 points de folie. Si la recharge de folie de l'équipé est supérieure à 10, il gagne 2 points de folie supplémentaires"
  },
  State_3153_Name = {
    Text = "État@Restauration de délire de malédiction"
  },
  State_3154_Name = {
    Text = "Taux Critique"
  },
  State_3155_Desc = {
    Text = "Récupère 10 % de la vie perdue chaque tour"
  },
  State_3155_Name = {Text = "Médecine"},
  State_3155_WeaponDesc = {
    Text = "Récupère 10 % de la vie perdue chaque tour"
  },
  State_3156_Desc = {
    Text = "Les premiers dégâts reçus chaque tour sont multipliés par 5"
  },
  State_3156_Name = {Text = "Paniqué"},
  State_3160_Desc = {
    Text = "Au début du tour, ajouter 1 \"parapluie\" ayant obtenu [Arg1] d'alerte durant ce tour à la main, après avoir joué 6 cartes, augmenter la garde de toutes les \"parapluie\" dans votre main de [Arg2]"
  },
  State_3161_Desc = {
    Text = "Le nombre de cartes piochées par l'adversaire est réduit [Layer], mais toutes les cartes sont conservées"
  },
  State_3161_WeaponDesc = {
    Text = "Le nombre de cartes piochées par notre équipe est réduit de [Layer], toutes les cartes sont conservées"
  },
  State_3163_Desc = {
    Text = "Après déclenchement de la résistance à la mort, restaure [Layer] points de vie"
  },
  State_3163_Name = {
    Text = "Berceau des étoiles"
  },
  State_3163_WeaponDesc = {
    Text = "Après déclenchement de la résistance à la mort, restaure [Layer] points de vie"
  },
  State_3164_Name = {
    Text = "Chaîne de ressentiment comptage"
  },
  State_3165_Name = {
    Text = "Réveilleur des errants 3"
  },
  State_3166_Name = {
    Text = "Ce combat a été déclenché"
  },
  State_3168_Desc = {
    Text = "Au début du tour, ajoutez un compteur d'attaques à tous les monstres"
  },
  State_3168_Name = {
    Text = "État @venger géante dégât de décapitation"
  },
  State_3168_WeaponDesc = {
    Text = "Au début du tour, ajoutez un compteur d'attaques à tous les monstres"
  },
  State_3170_Desc = {
    Text = "Inflige le prix de l'impulsion"
  },
  State_3170_Name = {
    Text = "Inflige le prix de l'impulsion"
  },
  State_3170_WeaponDesc = {
    Text = "Inflige le prix de l'impulsion"
  },
  State_3171_Name = {
    Text = "État @niveau 2_1 bataille 3 bulle 1"
  },
  State_3172_Desc = {
    Text = "Chaque fois que vous infligez des dégâts, obtenez [StateArg1] points de force temporaire, jusqu'à [StateArg2] fois. L'effet est doublé lorsque les couches sont pleines"
  },
  State_3172_Name = {
    Text = "Galets ensanglantés des créations"
  },
  State_3174_Desc = {
    Text = "Limite de vie réduite de 30%"
  },
  State_3174_Name = {
    Text = "Sextant des créations 2"
  },
  State_3174_WeaponDesc = {
    Text = "Limite de vie réduite de 30%"
  },
  State_3175_Desc = {
    Text = "Au début de chaque tour, tous les éveillés gagnent 10 points de folie"
  },
  State_3175_Name = {
    Text = "Sextant des créations 1"
  },
  State_3175_WeaponDesc = {
    Text = "Au début de chaque tour, tous les éveillés gagnent 10 points de folie"
  },
  State_3176_Desc = {
    Text = "Réinitialisation du deck du prologue 0_1_1_1"
  },
  State_3176_Name = {
    Text = "Réinitialisation du deck du prologue 0_1_1_1_2"
  },
  State_3176_WeaponDesc = {
    Text = "Réinitialisation du deck du prologue 0_1_1_1"
  },
  State_3177_Desc = {
    Text = "Lorsque \"Alerte\" atteint 3 couches, reculez et invoquez une \"Sculpture de cire leurre\". Les couches se réinitialisent au début du tour."
  },
  State_3177_Name = {Text = "Vigilance"},
  State_3177_WeaponDesc = {
    Text = "Lorsque \"Alerte\" atteint 3 couches, reculez et invoquez une \"Sculpture de cire leurre\". Les couches se réinitialisent au début du tour."
  },
  State_3178_Desc = {
    Text = "Augmente la consommation de charge de la carte"
  },
  State_3178_Name = {
    Text = "<SlowIconKeywords:Ralentissement>"
  },
  State_3178_WeaponDesc = {
    Text = "Chaque niveau de ralentissement augmente la consommation en arithmetica des cartes de 1 point"
  },
  State_3179_Desc = {
    Text = "Au début de la bataille, gagnez 20 boucliers. Au début de chaque tour, s'il y a un bouclier, les boucliers et les soins de ce tour augmentent de 50%"
  },
  State_3179_Name = {
    Text = "Gardien du jardin altéré"
  },
  State_3179_WeaponDesc = {
    Text = "Au début de la bataille, gagnez 20 boucliers. Au début de chaque tour, s'il y a un bouclier, les boucliers et les soins de ce tour augmentent de 50%"
  },
  State_3180_Desc = {
    Text = "Taux critique augmenté de 25 %. Après une guérison de vie, il y a une chance de provoquer une guérison supplémentaire pour 1 fois, la probabilité égale au taux critique de le guérisseur"
  },
  State_3180_Name = {
    Text = "État @clé en argent de rêve : soin critique"
  },
  State_3181_Name = {
    Text = "Taux Critique"
  },
  State_3183_Desc = {
    Text = "Ce tour, dégâts critiques augmentés de [Layer] %"
  },
  State_3183_Name = {
    Text = "Dommages critiques temporaires"
  },
  State_3185_Desc = {
    Text = "Stress supplémentaire en se déplaçant"
  },
  State_3185_Name = {
    Text = "Sac sans fond des créations 2"
  },
  State_3185_WeaponDesc = {
    Text = "Stress supplémentaire en se déplaçant"
  },
  State_3189_Name = {
    Text = ": Force retardée du monstre"
  },
  State_3190_Name = {
    Text = "Clé de la création"
  },
  State_3193_Desc = {
    Text = "Au début du prochain tour, obtenez un bouclier de [Layer]"
  },
  State_3193_Name = {Text = "Art Perdu"},
  State_3193_WeaponDesc = {
    Text = "Au début du prochain tour, obtenez un bouclier de [Layer]"
  },
  State_3196_Desc = {
    Text = "Après avoir joué, obtenez [StateArg1] points d'arithmétique"
  },
  State_3196_Name = {
    Text = "<Rune_4_High:Calcul avancé>"
  },
  State_3196_WeaponDesc = {
    Text = "Après avoir joué, obtenez [StateArg1] points d'arithmétique"
  },
  State_3197_Desc = {
    Text = "\"Frappe\" restaure [Arg1] Vie et réduit de moitié vos piles de Saignement et de Poison."
  },
  State_3197_Name = {
    Text = "Clamp hémostatique"
  },
  State_3200_Desc = {
    Text = "Équipe unique : Les dégâts de base et le bouclier infligés par le porteur augmentent de <WeaponEffect_Num:[StateArg1]%>. Au début de l'exploration, ajoutez une carte «Attaque» et une carte «Défense» de l'équipé au deck. Après avoir joué «Défense», le taux critique et les dégâts critiques de la prochaine carte «Attaque» du porteur augmentent de 15%. Après avoir joué «Attaque», le bouclier de la prochaine carte «Défense» du porteur augmente de 15%, cumulable jusqu'à 3 fois."
  },
  State_3200_WeaponDesc = {
    Text = "Les dégâts de base et le bouclier causés par l'équipé augmentent de <WeaponEffect_Num:[StateArg1]%>. Au début de l'exploration, ajoutez une carte « Attaque » et « Défense » de l'équipé au deck. Après avoir joué « Défense », augmentez le taux critique et les dégâts critiques de la prochaine « Attaque » de l'équipé de 15%. Après avoir joué « Attaque », augmentez le bouclier de la prochaine « Défense » de l'équipé de 15%, pouvant se cumuler jusqu'à 3 fois."
  },
  State_3201_Name = {
    Text = "Chaîne de ressentiment"
  },
  State_3203_Desc = {
    Text = "Équipe Unique : le Bouclier infligé par le Porteur est amélioré de <WeaponEffect_Num:[StateArg3]%>. La «Défense» du Porteur inflige un <IntoxicationIconKeywords:Poison> équivalent à <WeaponEffect_Num:[StateArg1]%> de la Défense du Porteur à l'ennemi avec les PV les plus élevés. Si le Royaume actuel est «Caro», lors de l'application du <IntoxicationIconKeywords:Poison>, <EmbryoFusionIconKeywords:Fusion d'Embryon> + <WeaponEffect_Num:[Blood:StateArg2]>, cet effet peut se déclencher au maximum 3 fois par tour."
  },
  State_3203_WeaponDesc = {
    Text = "Le Bouclier infligé par le Porteur est amélioré de <WeaponEffect_Num:[StateArg3]%>. La «Défense» du Porteur inflige <WeaponEffect_Num:[Poison:DescArg1]> couches de <IntoxicationIconKeywords:Poison> à l'ennemi avec les PV les plus élevés. Si le Royaume actuel est «Caro», lors de l'application du <IntoxicationIconKeywords:Poison>, <EmbryoFusionIconKeywords:Fusion d'Embryon> +<WeaponEffect_Num:[Blood:StateArg2]>, cet effet peut se déclencher au maximum 3 fois par tour."
  },
  State_3204_Desc = {
    Text = "Lors de la causation de dégâts réels, mélanger [StateArg1] cartes «blessures» dans la pile de tirage"
  },
  State_3204_Name = {
    Text = "Lacération"
  },
  State_3204_WeaponDesc = {
    Text = "Lorsque vous le piochez, vous êtes affaibli pendant 1 tour. Après usage, affaiblissez tous les ennemis pendant 1 tour. Ne peut pas être vendu"
  },
  State_3206_Desc = {
    Text = "Chaque fois que vous jouez 1 carte, augmentez votre fréquence critique dans ce tour de [StateArg1] %, avec un maximum de [StateArg2] accumulations. Lorsque le maximum est atteint, l'effet est doublé"
  },
  State_3206_Name = {
    Text = "Miroir rituel de Memphis des créations"
  },
  State_3206_WeaponDesc = {
    Text = "Chaque fois que vous jouez 1 carte, augmentez votre fréquence critique dans ce tour de [StateArg1] %, avec un maximum de [StateArg2] accumulations. Lorsque le maximum est atteint, l'effet est doublé"
  },
  State_3207_Desc = {
    Text = "Pour chaque point de vie perdu, retirez une couche. À zéro couche, gagnez un bouclier de [DescArg1]"
  },
  State_3207_Name = {
    Text = "Barrière dimensionnelle"
  },
  State_3208_Desc = {
    Text = "Pétrifié, incapable d'agir, retiré à la fin du tour"
  },
  State_3208_Name = {
    Text = "<PetrifactionColour:Pétrifier>"
  },
  State_3209_Name = {
    Text = "Extraction de vitalité de l'accessoire"
  },
  State_3209_WeaponDesc = {
    Text = "Après le début du combat, si la classe du porteur est chair, l'attaque augmente de 25 %"
  },
  State_3210_Name = {
    Text = "État @venger géante illuminateur 1"
  },
  State_3211_Desc = {
    Text = "Limite de cartes +2, ne défaussez plus vos cartes à la fin du tour. Chaque fois que vous perdez de la vie, défaussez 2 cartes au hasard"
  },
  State_3212_Desc = {
    Text = "Dégâts Directs et Dégâts des tentacules infligés -25%, retire 1 charge en fin de tour."
  },
  State_3212_Name = {
    Text = "<WeaknessIconKeywords:Faiblesse>"
  },
  State_3212_WeaponDesc = {
    Text = "Réduisez tous les dégâts infligés de 25 %"
  },
  State_3213_Desc = {
    Text = "Les effets de bouclier et de soins augmentent de [Layer] %"
  },
  State_3213_Name = {
    Text = "Bouclier temporaire et soin fort"
  },
  State_3213_WeaponDesc = {
    Text = "Les effets de bouclier et de soins augmentent de [Layer] %"
  },
  State_3215_Name = {
    Text = "Pendule temporel« Caché »"
  },
  State_3216_Desc = {
    Text = "Après le combat, obtenez 100 sigils noirs supplémentaires, mais recevez une carte de symptôme"
  },
  State_3216_Name = {
    Text = "Anneau de chance des créations"
  },
  State_3216_WeaponDesc = {
    Text = "Après le combat, obtenez 100 sigils noirs supplémentaires, mais recevez une carte de symptôme"
  },
  State_3220_Desc = {
    Text = "Après avoir libéré l'exaltation, tirez 1 carte. Si vos points de vie sont inférieurs à 25%, tirez 1 carte supplémentaire"
  },
  State_3223_Desc = {
    Text = "Effet de faiblesse augmenté de 10 %. Ajoute 1 couche de faiblesse à tous les ennemis tous les 3 tours"
  },
  State_3224_Name = {
    Text = "Créature d'enregistrement des arcanes d'arithmetica"
  },
  State_3225_Name = {
    Text = "Coup de cou"
  },
  State_3226_Desc = {
    Text = "Après avoir joué, la carte ne sera pas mise dans la défausse et ne pourra pas être utilisée à nouveau dans ce combat"
  },
  State_3226_Name = {
    Text = "Consommation"
  },
  State_3226_WeaponDesc = {
    Text = "Après avoir joué, la carte ne sera pas mise dans la défausse et ne pourra pas être utilisée à nouveau dans ce combat"
  },
  State_3227_Desc = {
    Text = "Tous les prix des créations réduits de 50 %"
  },
  State_3227_Name = {
    Text = "Médaille du commerce de la création"
  },
  State_3227_WeaponDesc = {
    Text = "Tous les prix des créations réduits de 50 %"
  },
  State_3228_Desc = {
    Text = "Au début du tour, le réveil avec le moins de folie gagne 25 de folie"
  },
  State_3228_Name = {
    Text = "Folie d'Arcana de la création"
  },
  State_3228_WeaponDesc = {
    Text = "Au début du tour, le réveil avec le moins de folie gagne 25 de folie"
  },
  State_3229_Desc = {
    Text = "Réinitialisation du deck du prologue 0_1_1_1"
  },
  State_3229_Name = {
    Text = "Réinitialisation du deck du prologue 0_1_1_1"
  },
  State_3229_WeaponDesc = {
    Text = "Réinitialisation du deck du prologue 0_1_1_1"
  },
  State_3230_Name = {
    Text = "État@retard général calcul"
  },
  State_3232_Desc = {
    Text = "État@MonstreDéclencheurSlotDimensionnel"
  },
  State_3232_Name = {
    Text = "État@MonstreDéclencheurSlotDimensionnel"
  },
  State_3232_WeaponDesc = {
    Text = "État@MonstreDéclencheurSlotDimensionnel"
  },
  State_3234_Desc = {
    Text = "Au début de la bataille, obtenez 3 pouvoirs, mais les dégâts reçus augmentent de 5 à chaque fois"
  },
  State_3234_Name = {
    Text = "Dos à l'eau"
  },
  State_3235_Desc = {
    Text = "Au début du combat, obtenez [Layer] points de pouvoir, mais les dégâts reçus augmentent de 5 à chaque fois"
  },
  State_3235_Name = {
    Text = "Dos à l'eau"
  },
  State_3236_Desc = {
    Text = "Après avoir joué, les autres éveillés gagnent [StateArg1] folie"
  },
  State_3236_Name = {
    Text = "<Rune_16_High:Catalyse avancée>"
  },
  State_3237_Desc = {
    Text = "Tous les 3 tours, obtient 3 tentacules, ignorent la limite de tentacules, retirés à la fin du tour"
  },
  State_3238_Desc = {
    Text = "Au début de la bataille, donnez aux monstres un état d'augmentation de tous les dégâts subis"
  },
  State_3238_Name = {
    Text = "Au début de la bataille, donnez aux monstres un état d'augmentation de tous les dégâts subis"
  },
  State_3238_WeaponDesc = {
    Text = "Au début de la bataille, donnez aux monstres un état d'augmentation de tous les dégâts subis"
  },
  State_3239_Desc = {
    Text = "Augmente l'attaque de [Layer] points"
  },
  State_3239_Name = {
    Text = "Augmentation de l'attaque générale"
  },
  State_3239_WeaponDesc = {
    Text = "Augmente l'attaque de [Layer] points"
  },
  State_3242_Name = {
    Text = "Ajoutez 2 cartes <DerivativeCardKeywords_4:\"Inspiration\"> à la pile de pioche."
  },
  State_3243_Desc = {
    Text = "Puissance de calcul de carte augmentée"
  },
  State_3243_Name = {
    Text = "Puissance de calcul de carte augmentée"
  },
  State_3243_WeaponDesc = {
    Text = "Puissance de calcul de carte augmentée"
  },
  State_3244_Desc = {
    Text = "Les points de vie des monstres invoqués sont doublés"
  },
  State_3244_Name = {
    Text = "« Regret éternel »"
  },
  State_3244_WeaponDesc = {
    Text = "Les points de vie des monstres invoqués sont doublés"
  },
  State_3245_Desc = {
    Text = "Au début du combat, le taux critique de notre équipe diminue de 30 %, le dégâts critiques augmentent de 30 %"
  },
  State_3245_Name = {Text = "Inhibition"},
  State_3245_WeaponDesc = {
    Text = "Au début du combat, le taux critique de notre équipe diminue de 30 %, le dégâts critiques augmentent de 30 %"
  },
  State_3246_Desc = {
    Text = "Au début de la bataille, la vie des ennemis normaux augmente de 30 %, et après une victoire, fournissez 25 au sigil noir supplémentaires"
  },
  State_3246_Name = {
    Text = "Drapeau de bataille brisé des créations"
  },
  State_3246_WeaponDesc = {
    Text = "Au début de la bataille, la vie des ennemis normaux augmente de 30 %, et après une victoire, fournissez 25 au sigil noir supplémentaires"
  },
  State_3247_Desc = {
    Text = "[Exalt] Réduisez le coût d'Arithmetica de toutes les cartes de 1."
  },
  State_3247_Name = {
    Text = "Lumière de la civilisation métamorphosée"
  },
  State_3247_WeaponDesc = {
    Text = "[Exalt] Réduisez le coût d'Arithmetica de toutes les cartes de 1."
  },
  State_3249_Desc = {
    Text = "Les autres alliés gagnent 1 stack de Folie, qui est retiré à la mort de cette unité."
  },
  State_3249_Name = {Text = "Agitation"},
  State_3249_WeaponDesc = {
    Text = "Les autres alliés gagnent 1 niveau de folie, se dissipe à votre mort"
  },
  State_3250_Desc = {
    Text = "Reste dans le deck après la bataille, mais sera définitivement retirée après avoir été jouée ou consommée."
  },
  State_3250_Name = {
    Text = "<DestructionKeywords:Détruire>"
  },
  State_3250_WeaponDesc = {
    Text = "Après avoir joué, retire définitivement"
  },
  State_3251_Desc = {
    Text = "Lorsque vous subissez des Dégâts Directs ou des Dégâts des tentacules, immunisé aux dégâts et perdez 1 stack. Supprimé au début du tour."
  },
  State_3251_Name = {
    Text = "<ParcloseColour: Barrière Temporaire>"
  },
  State_3252_Desc = {
    Text = "Lorsque la fleur de boue applique un bouclier, le maximum de vie augmente de [StateArg2]"
  },
  State_3252_Name = {
    Text = "Accumulation de mucus"
  },
  State_3252_WeaponDesc = {
    Text = "Lorsque la fleur de boue applique un bouclier, le maximum de vie augmente de [StateArg2]"
  },
  State_3253_Desc = {
    Text = "Obtenez [StateArg1] points d'alerte temporaire"
  },
  State_3253_Name = {
    Text = "<CardKeyWord:Équipement Mécanique - Bouclier>"
  },
  State_3253_WeaponDesc = {
    Text = "Obtenez [StateArg1] points d'alerte temporaire"
  },
  State_3255_Name = {
    Text = "Contre-attaque"
  },
  State_3256_Name = {
    Text = "État@Excitation de malédiction"
  },
  State_3259_Desc = {
    Text = "Augmente le nombre d'instances de Dégâts Directs infligés de [Layer]."
  },
  State_3259_Name = {
    Text = "<MadnessColour:Folie>"
  },
  State_3260_Desc = {
    Text = "Lorsque l'espace hyperdimensionnel atteint sa limite, gagnez un tour supplémentaire, ne piochez pas de cartes, mais ajoutez les cartes de l'espace hyperdimensionnel à votre main"
  },
  State_3260_Name = {
    Text = "<DimensionalSpaceIconKeywords:Espace dimensionnel>"
  },
  State_3260_WeaponDesc = {
    Text = "Lorsque l'espace hyperdimensionnel atteint sa limite, gagnez un tour hyperdimensionnel supplémentaire, ajoutez toutes les cartes de l'espace hyperdimensionnel à votre main"
  },
  State_3261_Desc = {
    Text = "Les monstres qu'il invoque infligent des dégâts doublés"
  },
  State_3261_Name = {
    Text = "\"Légion de Sculptures de Cire\""
  },
  State_3261_WeaponDesc = {
    Text = "Les monstres qu'il invoque infligent des dégâts doublés"
  },
  State_3262_Desc = {
    Text = "État@Revêtement de cire: Équipe"
  },
  State_3262_Name = {
    Text = "État@Revêtement de cire: Équipe"
  },
  State_3262_WeaponDesc = {
    Text = "État@Revêtement de cire: Équipe"
  },
  State_3263_Name = {
    Text = "État@Nautilus: Riposte"
  },
  State_3264_Name = {Text = "Garanti"},
  State_3265_Name = {
    Text = "Descarte et supprimez-le"
  },
  State_3266_Desc = {
    Text = "Saut renforcé de la ville des rêves morts"
  },
  State_3266_Name = {
    Text = "État@ville des rêves morts renforcer saut"
  },
  State_3267_Desc = {
    Text = "Au début de la bataille, gagnez 5 couches de [Armure de cire]."
  },
  State_3267_Name = {
    Text = "« Monsieur Cire »"
  },
  State_3267_WeaponDesc = {
    Text = "Au début de la bataille, gagnez 5 couches de [Armure de cire]."
  },
  State_3268_Desc = {
    Text = "Au début du tour, tire 1 carte. Chaque fois que tu tires 1 carte, modifie aléatoirement sa consommation de puissance de calcul (0-4)"
  },
  State_3268_Name = {
    Text = "Kaleidoscope de créations"
  },
  State_3268_WeaponDesc = {
    Text = "Au début du tour, tire 1 carte. Chaque fois que tu tires 1 carte, modifie aléatoirement sa consommation de puissance de calcul (0-4)"
  },
  State_3269_Desc = {
    Text = "Après avoir obtenu un deuxième bouclier par tour, acquérez [Arg1] couches de contre-attaque. Après avoir obtenu un quatrième bouclier par tour, infligez 1 dégât de contre-attaque à tous les ennemis"
  },
  State_3269_Name = {
    Text = "Vérité libérée"
  },
  State_3270_Name = {
    Text = "État@Chapitre 2_Résonance_Copie"
  },
  State_3271_Desc = {
    Text = "[Frappe] inflige [Arg1] couches de poison à tous les ennemis"
  },
  State_3272_Desc = {
    Text = "Restaurez 3 fois les dégâts réels en vie en infligeant des dégâts non bloqués, retirez après avoir infligé des dégâts"
  },
  State_3272_Name = {Text = "Vampirisme"},
  State_3273_Desc = {
    Text = "Équipe Unique : Après avoir joué une carte de l'équipé, obtenez un bouclier équivalent à <WeaponEffect_Num:[StateArg1]%> de la défense de l'équipé. Chaque tentacule augmente le bouclier de <WeaponEffect_Num:[StateArg2]%> de la défense de l'équipé. Cet effet ne peut se produire qu'une fois par tour."
  },
  State_3273_Name = {
    Text = "Décès de Mme Coral"
  },
  State_3273_WeaponDesc = {
    Text = "En jouant une carte de l'équipement, gagnez <WeaponEffect_Num:[Block:DescArg1]> bouclier, chaque tentacule augmente le bouclier de <WeaponEffect_Num:[DescArg2]>. Effet activé une fois par tour"
  },
  State_3274_Desc = {
    Text = "Chaque fois que vous subissez des dégâts actifs, augmentez d'un niveau le compteur de votre équipe"
  },
  State_3274_Name = {
    Text = "État @venger géante dégât de décapitation compte de notre équipe"
  },
  State_3274_WeaponDesc = {
    Text = "Chaque fois que vous subissez des dégâts actifs, augmentez d'un niveau le compteur de votre équipe"
  },
  State_3277_Desc = {
    Text = "Après avoir joué, l'éveillé gagne [StateArg1] folie"
  },
  State_3277_Name = {
    Text = "<Rune_5:Furie>"
  },
  State_3280_Name = {
    Text = "Épée du Destin"
  },
  State_3281_Desc = {
    Text = "Augmente les dégâts actifs"
  },
  State_3281_Name = {
    Text = "<PowerIconKeywords: Puissance>"
  },
  State_3281_WeaponDesc = {
    Text = "Augmentez les dégâts infligés"
  },
  State_3282_Desc = {
    Text = "Nombre de coups et augmentation des dégâts"
  },
  State_3282_Name = {
    Text = "<CardKeyWord:Amélioration>"
  },
  State_3282_WeaponDesc = {
    Text = "Augmente les dégâts une fois"
  },
  State_3283_Desc = {
    Text = "Au début de chaque tour, récupérez [StateArg1] points de vie. Si la vie est inférieure à 50 %, récupérez [StateArg2] points de vie"
  },
  State_3283_Name = {
    Text = "Baume de création"
  },
  State_3283_WeaponDesc = {
    Text = "Au début de chaque tour, récupérez [StateArg1] points de vie. Si la vie est inférieure à 50 %, récupérez [StateArg2] points de vie"
  },
  State_3287_Desc = {
    Text = "Au début du combat, mélangez 2 cartes « inspiration » dans votre bibliothèque. Chaque passage par un combat permettra à cette relique de monter en niveau, jusqu'à 3 fois"
  },
  State_3288_Desc = {Text = "État@Vide"},
  State_3288_Name = {Text = "État@Vide"},
  State_3288_WeaponDesc = {Text = "État@Vide"},
  State_3289_Desc = {
    Text = "Chaque fois que 1 point de dégâts est subi, le niveau diminue de 1. Lorsque le niveau atteint 0, l'intention est remplacée par la Fleur d'Immortalité et un groupe de compétences axé sur la défense est utilisé"
  },
  State_3289_Name = {
    Text = "Fleur immortelle"
  },
  State_3289_WeaponDesc = {
    Text = "Après avoir subi 1 point de dégâts, réduisez 1 couche. Lorsque le nombre de couches atteint 0, passez en mode défense"
  },
  State_3290_Desc = {
    Text = "La créature autrefois connue sous le nom de \"Miryam\" est tombée dans une paranoïa extrême et le désespoir. Brisez ses dernières illusions pour mettre fin à des milliers d'années de folie."
  },
  State_3290_Name = {Text = "Obsession"},
  State_3291_Desc = {
    Text = "L'équipe perd 3 points de force temporaire après avoir infligé des dégâts réels"
  },
  State_3291_Name = {Text = "Paralysie"},
  State_3292_Desc = {
    Text = "Lors de la libération de l'exaltation, lorsqu'un ennemi est sur le point d'infliger des dégâts, appliquez-lui [Arg1] couches d'empoisonnement"
  },
  State_3293_Desc = {
    Text = "Les dégâts diminuent de [Layer] points dans ce niveau"
  },
  State_3293_Name = {
    Text = "Force réduite"
  },
  State_3293_WeaponDesc = {
    Text = "Les dégâts et les dégâts de tentacule causés dans ce niveau diminuent de [Layer] points"
  },
  State_3294_Name = {
    Text = "État@Paranoïa de malédiction"
  },
  State_3296_Desc = {
    Text = "Défaussez ou jouez pour l'exiler"
  },
  State_3296_Name = {
    Text = "Défaussez ou jouez pour l'exiler"
  },
  State_3296_WeaponDesc = {
    Text = "Lorsque vous le piochez, vous êtes affaibli pendant 1 tour. Après usage, affaiblissez tous les ennemis pendant 1 tour. Ne peut pas être vendu"
  },
  State_3297_Desc = {
    Text = "État@Reine des épines: Éveil_Forme"
  },
  State_3297_Name = {
    Text = "État@Reine des épines: Éveil_Forme"
  },
  State_3297_WeaponDesc = {
    Text = "État@Reine des épines: Éveil_Forme"
  },
  State_3298_Desc = {
    Text = "Ce tour, le prochain effet de saut est garanti"
  },
  State_3298_Name = {
    Text = "Saut sera toujours déclenché"
  },
  State_3298_WeaponDesc = {
    Text = "Ce tour, effet de saut sans condition"
  },
  State_3301_Name = {
    Text = "Comptage du vin des étoiles"
  },
  State_3302_Desc = {
    Text = "Inflige congélation éternelle"
  },
  State_3302_Name = {
    Text = "Inflige congélation éternelle"
  },
  State_3302_WeaponDesc = {
    Text = "Inflige congélation éternelle"
  },
  State_3304_Desc = {
    Text = "Le réveilleur correspondant qui joue la dernière carte de commandement de chaque tour obtient 15 points de folie à la fin du tour, et si vous possédez en même temps la « Statue Maternelle », faites également gagner 5 points de folie aux autres réveilleurs"
  },
  State_3305_Desc = {
    Text = "Après avoir joué, mélangez [StateArg1] \"Inspiration\" dans la pile de pioche. \"Inspiration\" : Gagnez 1 Arithmetica, piochez 1 carte, retenez, épuiser."
  },
  State_3305_Name = {
    Text = "<Rune_17:Inspiration>"
  },
  State_3307_Name = {
    Text = "(Restant : [Layer])"
  },
  State_3308_Desc = {
    Text = "Au début du tour, si le nombre de cartes restantes à la fin du dernier tour est supérieur à 2, gagner 2 arithmetica"
  },
  State_3309_Desc = {
    Text = "Augmentation des dégâts, bouclier et guérison de l'équipementeur de [StateArg1]%. (temporaire)"
  },
  State_3309_Name = {
    Text = "État@Résistance à la mort de l'épée longue prototype"
  },
  State_3310_Desc = {
    Text = "Lorsque le Migrant applique un bouclier, il gagne [Energy:StateArg2] points de folie"
  },
  State_3310_Name = {
    Text = "Auto-blocage"
  },
  State_3310_WeaponDesc = {
    Text = "Lorsque le Migrant applique un bouclier, il gagne [Energy:StateArg2] points de folie"
  },
  State_3312_Desc = {
    Text = "Chaque fois que vous récupérez de la vie, vous gagnez [Arg1] points de comptoir, si votre vie est supérieure à 75 %, vous gagnez en plus [Arg2] points de comptoir"
  },
  State_3313_Desc = {
    Text = "Au début du tour, gagnez [Arg1] points de force pour ce tour, perdez [Arg2] points de force pour chaque carte jouée"
  },
  State_3314_Desc = {
    Text = "Cet éveilleur n'est pas encore éveillé... Il s'éveillera lorsqu'il sera sur le point d'être abattu, restaurera sa vie et commencera à se battre sous sa véritable forme"
  },
  State_3314_Name = {
    Text = "Non Réveillé"
  },
  State_3315_Desc = {
    Text = "Après avoir joué la première carte chaque tour, transformez 2 cartes aléatoires de votre main en leur version originale, elles reviennent à la fin du tour"
  },
  State_3315_Name = {
    Text = "Carillon envoûtant des créations"
  },
  State_3316_Desc = {
    Text = "À la fin du tour, le bouclier est conservé"
  },
  State_3316_Name = {
    Text = "Défense protectrice"
  },
  State_3316_WeaponDesc = {
    Text = "À la fin du tour, le bouclier est conservé"
  },
  State_3317_Desc = {
    Text = "À la fin du tour, perd tous les boucliers"
  },
  State_3317_Name = {
    Text = "Menottes : Père biologique"
  },
  State_3318_Name = {
    Text = "État@assoiffé de sang embrasser dévorer marque"
  },
  State_3323_Desc = {
    Text = "Augmentation des dégâts, bouclier et guérison de l'équipementeur de [StateArg1]%. (temporaire)"
  },
  State_3323_Name = {
    Text = "État@Folie de l'épée longue prototype"
  },
  State_3324_Desc = {
    Text = "Ce tour, dégâts critiques augmentés de [Layer] %"
  },
  State_3324_Name = {
    Text = "Dommages critiques temporaires"
  },
  State_3324_WeaponDesc = {
    Text = "Ce tour, dégâts critiques augmentés de [Layer] %"
  },
  State_3325_Desc = {
    Text = "Chaque fois que la bibliothèque est réinitialisée, ajoutez 2 cartes « Trident » qui ont obtenu [Arg1] points de pouvoir dans ce tour et 1 carte « Parapluie » qui a obtenu [Arg2] points d'alerte dans ce tour à votre main"
  },
  State_3326_Desc = {
    Text = "Immunisé aux premiers dégâts actifs chaque tour"
  },
  State_3326_Name = {
    Text = "Déterminé"
  },
  State_3326_WeaponDesc = {
    Text = "Immunisé aux premiers dégâts actifs chaque tour"
  },
  State_3327_Desc = {
    Text = ": PV avant la mort du monstre"
  },
  State_3327_Name = {
    Text = "HP du monstre avant la mort"
  },
  State_3327_WeaponDesc = {
    Text = ": PV avant la mort du monstre"
  },
  State_3328_Desc = {
    Text = "Lors de cette bataille, lorsque vous subissez des dégâts fatals, revivez une fois et restaurez [Layer] points de vie. Cet effet est indissipable."
  },
  State_3328_Name = {
    Text = "Oiseau du Paradis Immortel"
  },
  State_3329_Desc = {
    Text = "Après avoir joué 5 cartes, obtenez une copie de la carte la plus à gauche dans votre main, mais avec illusion et épuiser supplémentaires"
  },
  State_3330_Desc = {
    Text = "Augmenter la consommation d'arithmetica de la carte de [Layer] points. Après avoir joué la carte, cet effet négatif sera supprimé"
  },
  State_3330_Name = {
    Text = "<SlowColour:Ralentissement [Layer]>"
  },
  State_3330_WeaponDesc = {
    Text = "Augmenter la consommation d'arithmetica de la carte de [Layer] points"
  },
  State_3332_Desc = {
    Text = "Lors de la réception de Dégâts Directs ou de Dégâts des tentacules, immunité aux dégâts et perd 1 charge."
  },
  State_3332_Name = {
    Text = "<ParcloseColour: Barrière>"
  },
  State_3335_Desc = {
    Text = "Au début de la bataille, appliquez une couche de vulnérabilité à tous les ennemis. La « malédiction stagnante » augmente de 25% les effets de vulnérabilité subis par les ennemis"
  },
  State_3335_Name = {
    Text = "Œil de pierre, illumination 6"
  },
  State_3336_Name = {
    Text = "État @George @soigner à la mort"
  },
  State_3337_Name = {
    Text = "Rite sacrificiel rouge"
  },
  State_3339_Desc = {
    Text = "Augmente l'attaque de [Layer] points"
  },
  State_3339_Name = {
    Text = "Augmentation temporaire de l'attaque"
  },
  State_3339_WeaponDesc = {
    Text = "Augmente l'attaque de [Layer] points"
  },
  State_3340_Desc = {
    Text = "Après avoir libéré l'exaltation, les dégâts de l'exaltation dans cette bataille augmentent de [Arg1], maximum empilable 5 fois. Lorsque la pile est complète, le réveilleur de cette exaltation gagne 100 points de folie"
  },
  State_3341_Desc = {
    Text = "État@PrologueRéinitialisationDeck0_1_2_1"
  },
  State_3341_Name = {
    Text = "État@PrologueRéinitialisationDeck0_1_2_1"
  },
  State_3341_WeaponDesc = {
    Text = "État@PrologueRéinitialisationDeck0_1_2_1"
  },
  State_3342_Desc = {
    Text = "État@PrologueRéinitialisationDeck0_1_2_2"
  },
  State_3342_Name = {
    Text = "État@PrologueRéinitialisationDeck0_1_2_2"
  },
  State_3342_WeaponDesc = {
    Text = "État@PrologueRéinitialisationDeck0_1_2_2"
  },
  State_3343_Desc = {
    Text = "État@PrologueRéinitialisationDeck0_1_2_3"
  },
  State_3343_Name = {
    Text = "État@PrologueRéinitialisationDeck0_1_2_3"
  },
  State_3343_WeaponDesc = {
    Text = "État@PrologueRéinitialisationDeck0_1_2_3"
  },
  State_3344_Desc = {
    Text = "État@PrologueRéinitialisationDeck0_1_2_4"
  },
  State_3344_Name = {
    Text = "État@PrologueRéinitialisationDeck0_1_2_4"
  },
  State_3344_WeaponDesc = {
    Text = "État@PrologueRéinitialisationDeck0_1_2_4"
  },
  State_3345_Desc = {
    Text = "État@PrologueRéinitialisationDeck0_1_2_5"
  },
  State_3345_Name = {
    Text = "État@PrologueRéinitialisationDeck0_1_2_5"
  },
  State_3345_WeaponDesc = {
    Text = "État@PrologueRéinitialisationDeck0_1_2_5"
  },
  State_3346_Desc = {
    Text = "État@PrologueRéinitialisationDeck0_1_2_5"
  },
  State_3346_Name = {
    Text = "État@PrologueRéinitialisationDeck0_1_2_5"
  },
  State_3346_WeaponDesc = {
    Text = "État@PrologueRéinitialisationDeck0_1_2_6"
  },
  State_3347_Desc = {
    Text = "État@PrologueRéinitialisationDeck0_1_2_5"
  },
  State_3347_Name = {
    Text = "État@PrologueRéinitialisationDeck0_1_2_5"
  },
  State_3347_WeaponDesc = {
    Text = "État@PrologueRéinitialisationDeck0_1_2_7"
  },
  State_3348_Desc = {
    Text = "Après avoir joué, pioche [StateArg1] cartes"
  },
  State_3348_Name = {
    Text = "<Rune_3_High:Habileté avancée>"
  },
  State_3348_WeaponDesc = {
    Text = "Après avoir joué, pioche [StateArg1] cartes"
  },
  State_3350_Desc = {
    Text = "Après avoir libéré l'exaltation de la folie, perdez 10% de votre vie actuelle et volez [Arg1] points de puissance à tous les ennemis ce tour"
  },
  State_3351_Name = {
    Text = "État@AjoutéAuDeck"
  },
  State_3352_Name = {
    Text = "Astrolabe du grimoire des créations 1"
  },
  State_3354_Name = {
    Text = "Astrolabe du grimoire des créations 2"
  },
  State_3356_Name = {
    Text = "Tour terminé : Empoisonnement par Étranglement"
  },
  State_3357_Desc = {
    Text = "Après le début du prochain tour, les dégâts des tentacules +[Couche]"
  },
  State_3357_Name = {
    Text = "Dégâts de tentacule retardés"
  },
  State_3358_Desc = {
    Text = "Au début du prochain tour, obtenez [Layer] points de bouclier"
  },
  State_3358_Name = {
    Text = "Art perdu - Bouclier"
  },
  State_3359_Desc = {
    Text = "La 3e carte que tu joues a un effet double"
  },
  State_3359_Name = {
    Text = "Vin des étoiles des créations"
  },
  State_3359_WeaponDesc = {
    Text = "La 3e carte que tu joues a un effet double"
  },
  State_3360_Desc = {
    Text = "État@PrologueRéinitialisationDeck0_1_4_1"
  },
  State_3360_Name = {
    Text = "État@PrologueRéinitialisationDeck0_1_4_1"
  },
  State_3360_WeaponDesc = {
    Text = "État@PrologueRéinitialisationDeck0_1_4_1"
  },
  State_3362_Desc = {
    Text = "État@PrologueRéinitialisationDeck0_1_4_1"
  },
  State_3362_Name = {
    Text = "État@PrologueRéinitialisationDeck0_1_4_1"
  },
  State_3362_WeaponDesc = {
    Text = "État@PrologueRéinitialisationDeck0_1_4_1"
  },
  State_3364_Desc = {
    Text = "Lors de la collecte, choisir une carte et lui attribuer deux effets de renforcement de choix de trois (note : similaire à mille mirages)"
  },
  State_3365_Desc = {
    Text = "État@PrologueRéinitialisationDeck0_1_4_1"
  },
  State_3365_Name = {
    Text = "État@PrologueRéinitialisationDeck0_1_4_1"
  },
  State_3365_WeaponDesc = {
    Text = "État@PrologueRéinitialisationDeck0_1_4_1"
  },
  State_3366_Desc = {
    Text = "État@PrologueRéinitialisationDeck0_1_4_1"
  },
  State_3366_Name = {
    Text = "État@PrologueRéinitialisationDeck0_1_4_1"
  },
  State_3366_WeaponDesc = {
    Text = "État@PrologueRéinitialisationDeck0_1_4_1"
  },
  State_3368_Desc = {
    Text = "Si la consommation de la capacité avant la phase de défausse est supérieure à 5, elle se transforme en pierre"
  },
  State_3368_Name = {Text = "Pétrifier"},
  State_3368_WeaponDesc = {
    Text = "Transformez les cartes en main en pierres avant la phase de défausse"
  },
  State_3369_Desc = {
    Text = "Tous vos effets de dévoration deviennent une dévoration infinie"
  },
  State_3369_Name = {
    Text = "Dévoration Infinie"
  },
  State_3369_WeaponDesc = {
    Text = "Tous vos effets de dévoration deviennent une dévoration infinie"
  },
  State_3370_Desc = {
    Text = "Les boucliers diminuent de [Layer] points dans ce niveau"
  },
  State_3370_Name = {
    Text = "Réduction Permanente de Vigilance"
  },
  State_3370_WeaponDesc = {
    Text = "Les boucliers diminuent de [Layer] points dans ce niveau"
  },
  State_3372_Desc = {
    Text = "Cet éveilleur n'est pas encore éveillé... Il s'éveillera lorsqu'il sera sur le point d'être abattu, restaurera sa vie et commencera à se battre sous sa véritable forme"
  },
  State_3372_Name = {
    Text = "Non Réveillé"
  },
  State_3373_Desc = {
    Text = "Lors de la causation de dégâts réels, mélanger [StateArg1] cartes «blessures» dans la pile de tirage"
  },
  State_3373_Name = {
    Text = "Étranglement"
  },
  State_3373_WeaponDesc = {
    Text = "Lorsque vous le piochez, vous êtes affaibli pendant 1 tour. Après usage, affaiblissez tous les ennemis pendant 1 tour. Ne peut pas être vendu"
  },
  State_3374_Desc = {
    Text = "Après la fin du tour, gagne des couches de force équivalentes"
  },
  State_3374_Name = {Text = "colère"},
  State_3376_Desc = {
    Text = "Dans ce combat, les dégâts causés par l'exaltation augmentent de [Layer] points"
  },
  State_3376_Name = {
    Text = "Dégâts de Fureur éruptive augmentés"
  },
  State_3378_Desc = {
    Text = "Après avoir libéré l'exaltation de la folie, la prochaine carte jouée a un effet de 2 fois"
  },
  State_3378_Name = {
    Text = "État@CléD'ArgentDesRêves:Explosion"
  },
  State_3379_Desc = {
    Text = "Vie < 50 %, le Briseur de chaînes devient enragé"
  },
  State_3379_Name = {
    Text = "Moment de la vengeance"
  },
  State_3379_WeaponDesc = {
    Text = "Vie < 50 %, le Briseur de chaînes devient enragé"
  },
  State_3380_Desc = {
    Text = "Au début de la bataille, mélangez une [Confusion] dans votre pile de pioche."
  },
  State_3380_Name = {Text = "Hypnotiser"},
  State_3380_WeaponDesc = {
    Text = "Au début de la bataille, mélangez une [Confusion] dans votre pile de pioche."
  },
  State_3381_Name = {
    Text = "Initialisation de la classe hyperdimensionnelle"
  },
  State_3382_Desc = {
    Text = "Gagnez une quête. Complétez la quête pour recevoir des récompenses. [Event Placeholder]"
  },
  State_3383_Name = {
    Text = "Initialisation de la classe hyperdimensionnelle"
  },
  State_3385_Desc = {
    Text = "Les dégâts actifs et de tentacule subis sont réduits de 33 %"
  },
  State_3385_Name = {
    Text = "Bouclier Miroir"
  },
  State_3385_WeaponDesc = {
    Text = "Les dégâts actifs et de tentacule subis sont réduits de 33 %"
  },
  State_3386_Desc = {
    Text = "Augmentation des dégâts, bouclier et guérison de l'équipementeur de [StateArg1]%. (temporaire)"
  },
  State_3386_Name = {
    Text = "État@Critique de l'épée longue prototype"
  },
  State_3387_Name = {
    Text = "État @niveau 2_3 bataille 3 bulle 1"
  },
  State_3388_Desc = {
    Text = "Après avoir joué, gagnez [StateArg1] points de force"
  },
  State_3388_Name = {
    Text = "<Rune_14:Force brute>"
  },
  State_3389_Desc = {
    Text = "Cet éveilleur n'est pas encore éveillé... Il s'éveillera lorsqu'il sera sur le point d'être abattu, restaurera sa vie et commencera à se battre sous sa véritable forme"
  },
  State_3389_Name = {
    Text = "Non Réveillé"
  },
  State_3390_Desc = {
    Text = "Au début du combat, affaiblissez et rendez vulnérables tous les ennemis pendant 1 tour"
  },
  State_3392_Desc = {
    Text = "Gagnez [Arg1] Force lorsque ramassé. Chaque fois qu'un \"Embryon\" est fusionné, gagnez [Arg2] Force ce tour-ci."
  },
  State_3393_Desc = {
    Text = "Au début du tour, fusion d'embryon +30%. Tous vos effets de dévoration deviennent des dévotions infinies"
  },
  State_3394_Name = {
    Text = "Ajoutez 1 <DerivativeCardKeywords_4:\"Inspiration\"> à la pile de pioche"
  },
  State_3395_Desc = {
    Text = "Équipe Unique : Les dégâts de base de l'« Attaque » du porteur augmentent de 25%, et le bouclier de base de la « Défense » augmente de 25%. Lorsque vous jouez l'« Attaque » du porteur, obtenez une <PowerIconKeywords:Force> temporaire équivalente à <WeaponEffect_Num:[StateArg1]%> de l'Attaque du porteur, et lorsque vous jouez la « Défense » du porteur, obtenez une <AlertIconKeywords:Alerte> temporaire équivalente à <WeaponEffect_Num:[StateArg2]%> de la Défense du porteur. Si le royaume actuel est « Ultra », obtenez une <PowerIconKeywords:Force> temporaire et une <AlertIconKeywords:Alerte> temporaire lors de l'entrée dans le tour Ultra."
  },
  State_3395_WeaponDesc = {
    Text = "Les dégâts de base de l'équipement « Attaque » augmentent de 25 %, et le bouclier de base de « Défense » augmente de 25 %. Lorsque vous jouez « Attaque » de l'équipement, obtenez <WeaponEffect_Num:[Power:DescArg1]> points de <PowerIconKeywords:force> temporaire, et lorsque vous jouez « Défense » de l'équipement, obtenez <WeaponEffect_Num:[DescArg2]> points de <AlertIconKeywords:Alerte> temporaire. Si le royaume actuel est « Ultra », à l'entrée du tour Ultra, obtenez un point temporaire de <PowerIconKeywords:force> et un point temporaire de <AlertIconKeywords:Alerte>."
  },
  State_3397_Desc = {
    Text = "Lors de la dixième carte jouée, augmentez les dégâts de tentacule de [Arg1], permettant à toutes les attaques de tentacule de frapper 1 fois"
  },
  State_3400_Desc = {
    Text = "Limite de vie des ennemis d'élite et des chefs réduite de 20 %."
  },
  State_3401_Desc = {
    Text = "Après avoir joué, effectue un effet supplémentaire [StateArg1] fois, obtenez [StateArg2] points du sigil noir, épuiser, innée"
  },
  State_3401_Name = {
    Text = "<Rune_7:Écho>"
  },
  State_3402_Desc = {
    Text = "\"Le Pic en Fer\" de Lusen augmente les dégâts de frappe lourde de [Layer]%."
  },
  State_3402_Name = {
    Text = "Dégâts augmentés pour attaque lourde"
  },
  State_3402_WeaponDesc = {
    Text = "La pioche en fer de Lucen augmente les dégâts de frappe [Layer] %"
  },
  State_3403_Desc = {
    Text = "Cet éveilleur n'est pas encore éveillé... Il s'éveillera lorsqu'il sera sur le point d'être abattu, restaurera sa vie et commencera à se battre sous sa véritable forme"
  },
  State_3403_Name = {
    Text = "Non Réveillé"
  },
  State_3405_Name = {
    Text = "Tous les ennemis voient leur <PowerIconKeywords:force> temporairement réduite de [Power:StateArg1] points, et les boucliers et <PowerIconKeywords:force> obtenus en 1 tour sont réduits de 50 %"
  },
  State_3406_Name = {
    Text = "Obtenez [StateArg1] points de <PowerIconKeywords:force>"
  },
  State_3407_Name = {
    Text = "Choisissez une carte de la pile de tirage à ajouter à votre main et réduisez sa consommation de puissance de -1"
  },
  State_3408_Name = {
    Text = "Gagnez <Posse:[DescArg1]> points de s-énergie. Dans ce combat, les dégâts de base de « décapitation » et de « mille mirages » augmentent de 10 %"
  },
  State_3409_Name = {
    Text = "Choisissez un éveillé pour gagner <Energy:[DescArg1]> points de folie"
  },
  State_3410_Name = {
    Text = "Cette carte augmente le taux critique et les dégâts critiques de 50%, inflige des dégâts perçants"
  },
  State_3411_Name = {
    Text = "Immunité <FragileIconKeywords:fragile>、<WeaknessIconKeywords:faiblesse>、<VulnerabilityIconKeywords:vulnérable> 1 tour. Gagne <Block:[Block:StateArg1]> points de bouclier"
  },
  State_3412_Desc = {
    Text = "Immunité aux états négatifs, réduit de 1 couche à la fin du tour ou après un coup critique"
  },
  State_3412_Name = {
    Text = "Couche en cire"
  },
  State_3412_WeaponDesc = {
    Text = "Chaque couche réduit les dégâts reçus de 10%, réduit d'une couche après chaque coup critique"
  },
  State_3415_Desc = {
    Text = "Lors de la collecte, choisir 1 des 3 oraisons corrompues. Les oraisons corrompues sont plus puissantes que les oraisons normales, mais coûtent une carte lorsqu'elles sont jouées"
  },
  State_3415_Name = {
    Text = "Impression de jade des créations"
  },
  State_3415_WeaponDesc = {
    Text = "Lors de la collecte, choisir 1 des 3 oraisons corrompues. Les oraisons corrompues sont plus puissantes que les oraisons normales, mais coûtent une carte lorsqu'elles sont jouées"
  },
  State_3416_Desc = {
    Text = "Équipe Unique : au début du combat, obtient une Contre-attaque équivalente à <WeaponEffect_Num:[StateArg1]%> de la Défense du Porteur. Après avoir déclenché <DeathResistanceIconKeywords: Résistance à la mort>, obtient jusqu'à 2 couches de «berceau» au total : le Bouclier et la récupération de PV infligés par tous les alliés augmentent de <WeaponEffect_Num:[StateArg2]%>, retire 1 couche à la fin du tour. Si le Royaume actuel est «Caro», après avoir déclenché <DeathResistanceIconKeywords: Résistance à la mort>, Fusion d'Embryon <WeaponEffect_Num:+[Blood:StateArg3]>."
  },
  State_3416_WeaponDesc = {
    Text = "Au début du combat, obtient <WeaponEffect_Num:[Counterattack:DescArg1]> couches de Contre-attaque. Après avoir déclenché <DeathResistanceIconKeywords: Résistance à la mort>, obtient jusqu'à 2 couches de «berceau» au total : le Bouclier et la récupération de PV infligés par tous les alliés augmentent de <WeaponEffect_Num:[StateArg2]%>, retire 1 couche à la fin du tour. Si le Royaume actuel est «Caro», après avoir déclenché <DeathResistanceIconKeywords: Résistance à la mort>, Fusion d'Embryon <WeaponEffect_Num:+[Blood:StateArg3]>."
  },
  State_3418_Desc = {
    Text = "Après la fin du tour, perd la force temporaire"
  },
  State_3418_Name = {
    Text = "Épuisement différé"
  },
  State_3419_Desc = {
    Text = "Lors de la collecte, afficher 3 cartes avec des oraisons avancées ou maudites, choisir une pour lui conférer l'oraison correspondante"
  },
  State_3420_Desc = {
    Text = "Chaque action inflige des saignements, la guérison peut réduire de moitié le nombre de couches de saignement"
  },
  State_3420_Name = {Text = "Sang"},
  State_3420_WeaponDesc = {
    Text = "Chaque action inflige des saignements, la guérison peut réduire de moitié le nombre de couches de saignement"
  },
  State_3421_Desc = {
    Text = "Au début du tour, ajouter 1 \"trident\" ayant obtenu [Arg1] de pouvoir durant ce tour à la main. Après avoir exalter, augmenter le pouvoir de toutes les \"trident\" dans la main de [Arg2]"
  },
  State_3422_Name = {
    Text = "État@Accessoire: Apocalypse immaculée"
  },
  State_3422_WeaponDesc = {
    Text = "Après avoir libéré la clé, récupérez [DescArg1] vie. Si le niveau de recharge de la clé en argent du porteur est supérieur à 20, récupérez [DescArg1] vie supplémentaire. Les effets similaires ne peuvent pas se cumuler"
  },
  State_3423_Desc = {
    Text = "Avec une maîtrise de 100 du royaume, les dégâts causés sont augmentés par les dégâts temporaires de tentacule"
  },
  State_3423_Name = {
    Text = "Pendule Temporel « Cauchemar »"
  },
  State_3424_Desc = {
    Text = "Au début du tour, si plus de 3 cartes ont été jouées au tour précédent, piochez 2 cartes"
  },
  State_3425_Desc = {
    Text = "Lorsque la vie est inférieure à 50%([StateArg1]), l'intention se transforme en « impasse survivante » : enlève la fragilité, la faiblesse et l'état de poison, inflige 99 niveaux de fragilité et de faiblesse à notre équipe"
  },
  State_3425_Name = {
    Text = "Moment de la vengeance"
  },
  State_3425_WeaponDesc = {
    Text = "Lorsque la vie est inférieure à 50%([StateArg1]), l'intention se transforme en « impasse survivante » : enlève la fragilité, la faiblesse et l'état de poison, inflige 99 niveaux de fragilité et de faiblesse à notre équipe"
  },
  State_3429_Desc = {
    Text = "Chaque action ajoute des saignements, la guérison peut supprimer l'effet de saignement"
  },
  State_3429_Name = {
    Text = "Blessure grave"
  },
  State_3429_WeaponDesc = {
    Text = "Chaque action ajoute des saignements, la guérison peut supprimer l'effet de saignement"
  },
  State_3430_Desc = {
    Text = "Après avoir libéré l'exaltation, gagnez [Arg1] points de contre-attaque. Si cela déclenche pour la 6ème fois dans cette bataille, doublez votre contre-attaque"
  },
  State_3431_Name = {
    Text = "Immunité au poison"
  },
  State_3432_Desc = {
    Text = "Défaussez pour le consommer"
  },
  State_3432_Name = {
    Text = "Coût de défausse"
  },
  State_3432_WeaponDesc = {
    Text = "Lorsque vous le piochez, vous êtes affaibli pendant 1 tour. Après usage, affaiblissez tous les ennemis pendant 1 tour. Ne peut pas être vendu"
  },
  State_3434_Name = {
    Text = "État@correction générale vulnérabilité"
  },
  State_3436_Desc = {
    Text = "Il y a [Layer] Éveillés en cours de chasse"
  },
  State_3436_Name = {Text = "Chassé"},
  State_3437_Desc = {
    Text = "État@monstre planète initiale du saut de l'ombre de la baleine bête du chaos"
  },
  State_3437_Name = {
    Text = "État@monstre planète initiale du saut de l'ombre de la baleine bête du chaos"
  },
  State_3437_WeaponDesc = {
    Text = "État@monstre planète initiale du saut de l'ombre de la baleine bête du chaos"
  },
  State_3438_Desc = {
    Text = "Obtenir [StateArg1] points de force temporaire"
  },
  State_3438_Name = {
    Text = "<CardKeyWord:Arme mécanique - Épée>"
  },
  State_3439_Desc = {
    Text = "À la fin du tour, Tulu gagne 5 de folie"
  },
  State_3439_Name = {
    Text = "Les étoiles retrouvent leur place"
  },
  State_3440_Name = {
    Text = "Guide doré"
  },
  State_3441_Desc = {
    Text = "Au tour impair, lorsque vos cartes sont à 0, piochez 2 cartes ; au tour pair, lorsque votre arithmétique est à 0, obtenez 2 points d'arithmétique"
  },
  State_3441_Name = {
    Text = "Puzzle ancien altéré"
  },
  State_3441_WeaponDesc = {
    Text = "Au tour impair, lorsque vos cartes sont à 0, piochez 2 cartes ; au tour pair, lorsque votre arithmétique est à 0, obtenez 2 points d'arithmétique"
  },
  State_3442_Desc = {
    Text = "Après ramassage, perdez définitivement [Arg1] force. Chaque fois que vous infligez des dégâts, récupérez [Arg2] points de vie, jusqu'à 6 fois par tour"
  },
  State_3442_Name = {
    Text = "Baiser de la Lamproie"
  },
  State_3444_Desc = {
    Text = "Piochez 1 carte au début du tour"
  },
  State_3445_Desc = {
    Text = "Augmente la défense de [Layer]%"
  },
  State_3445_Name = {
    Text = "Augmentation en pourcentage de la défense générale"
  },
  State_3445_WeaponDesc = {
    Text = "Augmente la défense de [Layer]%"
  },
  State_3446_Desc = {
    Text = "Gagnez 5 couches de [Fuse]. Diminue de 1 lors de la joue d'une carte. Lorsque cela atteint 0, autodétruisez-vous, infligeant des dégâts d'Attaque * 2,5."
  },
  State_3446_Name = {
    Text = "Grenade explosive"
  },
  State_3446_WeaponDesc = {
    Text = "Gagnez 5 couches de [Fuse]. Diminue de 1 lors de la joue d'une carte. Lorsque cela atteint 0, autodétruisez-vous, infligeant des dégâts d'Attaque * 2,5."
  },
  State_3447_Desc = {
    Text = "Gagnez 5 couches de [Fuse]. Diminue de 1 lors de la joue d'une carte. Lorsque cela atteint 0, autodétruisez-vous, infligeant des dégâts d'Attaque * 2,5."
  },
  State_3447_Name = {
    Text = "Grenade explosive"
  },
  State_3447_WeaponDesc = {
    Text = "Gagnez 5 couches de [Fuse]. Diminue de 1 lors de la joue d'une carte. Lorsque cela atteint 0, autodétruisez-vous, infligeant des dégâts d'Attaque * 2,5."
  },
  State_3448_Desc = {
    Text = "Après chaque tour, activez tous les tentacules"
  },
  State_3448_Name = {
    Text = "Activation automatique des tentacules"
  },
  State_3448_WeaponDesc = {
    Text = "Après chaque tour, activez tous les tentacules"
  },
  State_3449_Desc = {
    Text = "État@PrologueFolie0_1_1Actif"
  },
  State_3449_Name = {
    Text = "État@PrologueFolie0_1_1Actif"
  },
  State_3449_WeaponDesc = {
    Text = "État@PrologueFolie0_1_1Actif"
  },
  State_3450_Desc = {
    Text = "Lors de la réception de Dégâts Directs ou de Dégâts des tentacules, immunité aux dégâts et retire 1 charge."
  },
  State_3450_Name = {
    Text = "<ParcloseIconKeywords: Barrière>"
  },
  State_3450_WeaponDesc = {
    Text = "Dégâts reçus -99%. Après avoir reçu des dégâts, perd 1 charge."
  },
  State_3451_Desc = {
    Text = "À la mort, tous les éveillés gagnent 10 folie"
  },
  State_3451_Name = {
    Text = "Écailles d'argent moribondes"
  },
  State_3451_WeaponDesc = {
    Text = "À la mort, tous les éveillés gagnent 10 folie"
  },
  State_3452_Desc = {
    Text = "À chaque carte jouée, subit [StateArg1] dégâts et retire 1 couche. Si encore présent à la fin du tour, fait éclore une \"Créature Marine\", augmentant de 10% par couche de vie"
  },
  State_3452_Name = {
    Text = "Invasion abyssale"
  },
  State_3453_Name = {
    Text = "État@LameVengeresseMultiplicateurForce"
  },
  State_3455_Desc = {
    Text = "État@PrologueFolieInitialisation0_2_3Effet"
  },
  State_3455_Name = {
    Text = "État@PrologueFolieInitialisation0_2_3Effet"
  },
  State_3455_WeaponDesc = {
    Text = "État@PrologueFolieInitialisation0_2_3Effet"
  },
  State_3456_Desc = {
    Text = "[défense] obtient [StateArg1] niveaux de comptoir"
  },
  State_3456_Name = {
    Text = "Gilet d'ortie des créations"
  },
  State_3457_Name = {
    Text = "Immunité à la vulnérabilité"
  },
  State_3458_Desc = {
    Text = "Après avoir joué [attaque] et [défense], le réveilleur correspondant reçoit 35 aliemus. Cependant, leur coût en arithmetica augmente de 1"
  },
  State_3459_Desc = {
    Text = "Dans ce combat, les dégâts causés par l'exaltation augmentent de [Layer] points"
  },
  State_3459_Name = {
    Text = "Dégâts de Fureur éruptive augmentés"
  },
  State_3461_Desc = {
    Text = "Chaque 5ème dégâts que tu infliges sera un coup critique"
  },
  State_3462_Name = {
    Text = "État@LameVengeresseMultiplicateurForce3"
  },
  State_3463_Name = {
    Text = "État@LameVengeresseMultiplicateurForce2"
  },
  State_3464_Desc = {
    Text = "Limite de tentacule augmentée de 1. Lorsque la vie est inférieure à 50%, les dégâts de tentacule augmentent de [Arg1]"
  },
  State_3465_Desc = {
    Text = "Cette carte pourra être emportée en combat, valide dans le niveau"
  },
  State_3465_Name = {
    Text = "<CardKeyWord:Perpétuel>"
  },
  State_3465_WeaponDesc = {
    Text = "Cette carte peut être emportée en combat, valide dans le niveau"
  },
  State_3466_Desc = {
    Text = "Lors de la collecte, choisir un réveilleur pour l'éveiller, le coût en arithmétique de sa carte d'éveil diminue de manière permanente de 1"
  },
  State_34671_Desc = {
    Text = "Après avoir joué, revient en main"
  },
  State_34671_Name = {
    Text = "<CardKeyWord:Retour>"
  },
  State_34685_Name = {
    Text = "Joueur de Bombe 2"
  },
  State_34689_Desc = {
    Text = "Pour chaque point de vie perdu, gagnez 1 couche de <PainWord:patience>, avec un plafond égal à 100 % de la santé maximale. La patience est transférée au combat suivant."
  },
  State_34689_Name = {
    Text = "<CardKeyWord: Endurer>"
  },
  State_3468_Desc = {
    Text = "État@RancuneDesDéchets"
  },
  State_3468_Name = {
    Text = "État@RancuneDesDéchets"
  },
  State_3468_WeaponDesc = {
    Text = "État@RancuneDesDéchets"
  },
  State_34691_Desc = {
    Text = "Perdez 1 point de vie, gagnez 1 couche de <PainWord:Patience>. Limité à [DescArg1] couches. La Patience est transmise à la prochaine bataille."
  },
  State_34691_Name = {
    Text = "<CardKeyWord: Endurer>"
  },
  State_34696_Desc = {
    Text = "Cette carte reste toujours dans la main et augmente la limite de main de +1"
  },
  State_34696_Name = {
    Text = "Conserver définitivement et ignorer la limite de cartes en main"
  },
  State_3469_Desc = {
    Text = "Tous les Dégâts Directs et Dégâts des tentacules infligés -[DescArg1]%."
  },
  State_3469_Name = {
    Text = "<WeaknessColour:Faiblesse>"
  },
  State_3469_WeaponDesc = {
    Text = "Tous les dégâts infligés sont réduits de [DescArg1] %"
  },
  State_3470_Desc = {
    Text = "Inflige pétrification progressive"
  },
  State_3470_Name = {
    Text = "Inflige pétrification progressive"
  },
  State_3470_WeaponDesc = {
    Text = "Inflige pétrification progressive"
  },
  State_3471_Desc = {
    Text = "La [StateArg1]e carte que tu joues a un effet double"
  },
  State_3471_Name = {
    Text = "Comptage du vin des étoiles"
  },
  State_3471_WeaponDesc = {
    Text = "La [StateArg1]e carte que tu joues a un effet double"
  },
  State_3473_Desc = {
    Text = "Lorsque la vie est inférieure à 50%, le « pasteur de la lanterne » demandera que « Dieu descende », absorbant tous ses fidèles avant de devenir enragé"
  },
  State_3473_Name = {
    Text = "Marque de la mèche"
  },
  State_3473_WeaponDesc = {
    Text = "Lorsque la vie est inférieure à 50%, le « pasteur de la lanterne » demandera que « Dieu descende », absorbant tous ses fidèles avant de devenir enragé"
  },
  State_3475_Desc = {
    Text = "[frapper] et [défense] coût de calcul +1"
  },
  State_3475_Name = {
    Text = "Stèle maudite de la création"
  },
  State_3475_WeaponDesc = {
    Text = "[frapper] et [défense] coût de calcul +1"
  },
  State_3476_Desc = {
    Text = "Chaque fois que vous perdez des PV, fusion d'embryon +10%. Si PV < 50%, effet doublé"
  },
  State_3477_Desc = {
    Text = "Récupère [Layer] PV lorsqu'il est attaqué ; s'évanouit et retire cet état si les Dommages dépassent 15% des PV Max"
  },
  State_3477_Name = {Text = "Chaos noir"},
  State_3478_Name = {
    Text = "État@Accessoire: Pacte standard"
  },
  State_3479_Desc = {
    Text = "Chaque consommation de 1 sigil noir accorde 1 point de colère à tous les réveilleurs"
  },
  State_3479_Name = {
    Text = "Fleur Inverse de la Création"
  },
  State_3479_WeaponDesc = {
    Text = "Chaque consommation de 1 sigil noir accorde 1 point de colère à tous les réveilleurs"
  },
  State_3480_Desc = {
    Text = "Jusqu'à la fin du tour, les PV ne peuvent pas tomber à 0"
  },
  State_3480_Name = {
    Text = "L'Œuf de Perle ne meurt pas"
  },
  State_3480_WeaponDesc = {
    Text = "Jusqu'à la fin du tour, les PV ne peuvent pas tomber à 0"
  },
  State_3481_Desc = {
    Text = "Au début du niveau, doublez votre taux de résistance à la mort et votre taux de sigil de chance"
  },
  State_3481_Name = {
    Text = "État@CléD'ArgentDesRêves:DoubleChance"
  },
  State_3482_Desc = {
    Text = "L'effet de vulnérabilité infligé augmente de 25 %. Ajoutez 1 couche de vulnérabilité à tous les ennemis tous les 3 tours"
  },
  State_3483_Desc = {
    Text = "Chaque action ajoute des saignements, la guérison peut supprimer l'effet de saignement"
  },
  State_3483_Name = {
    Text = "Blessure grave"
  },
  State_3483_WeaponDesc = {
    Text = "Chaque action ajoute des saignements, la guérison peut supprimer l'effet de saignement"
  },
  State_3484_Desc = {
    Text = "Gagnez de la force après avoir infligé des dégâts réels"
  },
  State_3484_Name = {
    Text = "« Personnalité chaotique »"
  },
  State_3485_Desc = {
    Text = "État@RituelDeLaLanterneActif"
  },
  State_3485_Name = {
    Text = "État@RituelDeLaLanterneActif"
  },
  State_3485_WeaponDesc = {
    Text = "État@RituelDeLaLanterneActif"
  },
  State_3486_Name = {
    Text = "Épée du Destin"
  },
  State_3488_Desc = {
    Text = "Lorsque vous jouez une carte, subissez [StateArg1] points de dégâts et retirez 1 couche. Lorsque les couches sont à 0, éclosez une «Créature des Mers» plus faible. Si l'état de parasitisme persiste à la fin du tour, éclosez une «Créature des Mers» dont la vie augmente avec les couches"
  },
  State_3488_Name = {
    Text = "Parasité plusieurs fois"
  },
  State_3489_Name = {
    Text = "À la fin du tour, si en main ou dans <DimensionalSpaceIconKeywords:espace dimensionnel>, évolue en \"Flamme verte de la corruption\""
  },
  State_3489_WeaponDesc = {
    Text = "À la fin du tour, si dans la main ou dans l'espace ultra, obtiendra un renfort"
  },
  State_3490_Desc = {
    Text = "Lorsque vous jouez une carte, subissez [StateArg1] points de dégâts et retirez 1 couche. Lorsque les couches sont à 0, éclosez une «Créature des Mers» plus faible. Si l'état de parasitisme persiste à la fin du tour, éclosez une «Créature des Mers» dont la vie augmente avec les couches"
  },
  State_3490_Name = {
    Text = "Être parasité à nouveau"
  },
  State_3492_Desc = {
    Text = "Chaque tour pair réduit la force de notre équipe de [Layer]"
  },
  State_3492_Name = {
    Text = "Désamorcer"
  },
  State_3495_Desc = {
    Text = "Chaque action ajoute [Layer] saignement"
  },
  State_3495_Name = {
    Text = "Blessure grave"
  },
  State_3495_WeaponDesc = {
    Text = "Chaque action ajoute [Layer] de saignement, la guérison peut supprimer l'effet de saignement"
  },
  State_34964_Desc = {
    Text = "Après le début du tour, obtenez 10 % de <PainWord:endurance> basé sur votre santé maximale."
  },
  State_34964_Name = {
    Text = "Ne jamais oublier"
  },
  State_3496_Name = {
    Text = "À la fin du tour, si en main ou dans <DimensionalSpaceIconKeywords:espace dimensionnel>, évolue en \"Flamme verte de la mort\""
  },
  State_3496_WeaponDesc = {
    Text = "À la fin du tour, si dans la main ou dans l'espace ultra, obtiendra un renfort"
  },
  State_3497_Desc = {
    Text = "Lorsque l'équipe est composée d'éveillés de différentes classes, la vie de l'équipe et l'attaque et la défense de tous les éveillés augmentent de 200%"
  },
  State_3497_Name = {
    Text = "Bonus mixte"
  },
  State_3497_WeaponDesc = {
    Text = "Lorsque l'équipe est composée d'éveillés de différentes classes, la vie de l'équipe et l'attaque et la défense de tous les éveillés augmentent de 200%"
  },
  State_3499_Desc = {
    Text = "Équipe unique : La folie générée par l'équipement est augmentée de <WeaponEffect_Num:[StateArg1]%>. Après que l'équipement ait libéré l'exaltation de la folie, il obtient <WeaponEffect_Num:[StateArg2]> points d'énergie clé en argent."
  },
  State_3499_WeaponDesc = {
    Text = "La folie générée par l'équipement est augmentée de <WeaponEffect_Num:[StateArg1] %>. Après que l'équipement ait libéré l'exaltation de la folie, il obtient <WeaponEffect_Num:[StateArg2]> points de s-énergie."
  },
  State_3502_Desc = {
    Text = "Augmentation des dégâts, bouclier et guérison de l'équipementeur de [StateArg1]%. (temporaire)"
  },
  State_3502_Name = {
    Text = "État@Folie du couteau prototype"
  },
  State_3504_Desc = {
    Text = "Au début de chaque tour, piochez [StateArg1] cartes"
  },
  State_3504_Name = {
    Text = "Boussole directionnelle des créations"
  },
  State_3504_WeaponDesc = {
    Text = "Au début de chaque tour, piochez [StateArg1] cartes"
  },
  State_3507_Name = {
    Text = "Forme organique de l'accessoire"
  },
  State_3507_WeaponDesc = {
    Text = "Après avoir utilisé l'exaltation, les boucliers et les soins de l'équipement doublent pour ce tour"
  },
  State_3508_Name = {
    Text = "Chrysalide de la jeune fille de l'accessoire"
  },
  State_3508_WeaponDesc = {
    Text = "Après le début du combat, si la classe du porteur est chaos, l'attaque augmente de 25 %"
  },
  State_3510_Desc = {
    Text = "Le bouclier de l'éveil augmente de [Layer] points"
  },
  State_3510_Name = {
    Text = "<AlertColour: alerte>"
  },
  State_3511_Desc = {
    Text = "Augmentation des dégâts, bouclier et guérison de l'équipementeur de [StateArg1]%. (temporaire)"
  },
  State_3511_Name = {
    Text = "État@Chance de l'épée longue prototype"
  },
  State_35120_Desc = {
    Text = "Pour chaque instance de Dégâts Directs reçus, appliquez [StateArg1] <plural value=\"[Poison:StateArg1]\" singular=\"charge\" plural=\"charges\"> de Poison à l'attaquant, pendant [Layer] <plural value=\"[Layer]\" singular=\"tour\" plural=\"tours\">."
  },
  State_35120_Name = {
    Text = "Fleur immortelle sur la boue"
  },
  State_3512_Name = {
    Text = "Fragilité de l'immunité temporaire"
  },
  State_3514_Desc = {
    Text = "En fin de tour, reçoit des <FixedDamage:DGT Purs> égaux au nombre de charges et retire ce statut."
  },
  State_3514_Name = {
    Text = "<BleedingIconKeywords: Saignement>"
  },
  State_3514_WeaponDesc = {
    Text = "Subir des dégâts au début du tour"
  },
  State_35158_Name = {
    Text = "Pendule temporel« Trance »"
  },
  State_3515_Desc = {
    Text = "Cet éveilleur n'est pas encore éveillé... Il s'éveillera lorsqu'il sera sur le point d'être abattu, restaurera sa vie et commencera à se battre sous sa véritable forme"
  },
  State_3515_Name = {
    Text = "Non Réveillé"
  },
  State_35161_Name = {
    Text = "Pendule temporel« Épargne »"
  },
  State_3516_Name = {
    Text = "État@Dépression de malédiction"
  },
  State_3518_Desc = {
    Text = "Chaque fois que le magicien joue une carte, il gagne [StateArg2] force temporaire"
  },
  State_3518_Name = {
    Text = "Préambule du spectacle"
  },
  State_3519_Desc = {
    Text = "Même en dehors du tour dimensionnel, un effet de saut peut être déclenché une fois par tour"
  },
  State_3519_Name = {
    Text = "Détourneur d'espace"
  },
  State_3519_WeaponDesc = {
    Text = "Même en dehors du tour dimensionnel, un effet de saut peut être déclenché une fois par tour"
  },
  State_3520_Desc = {
    Text = "Au début du combat, choisissez un éveilleur et donnez-lui 50 aliemus"
  },
  State_35228_Name = {
    Text = "Pendule temporel« Épargne »"
  },
  State_3522_Name = {
    Text = "Comptage de créature trident"
  },
  State_35238_Desc = {
    Text = "Équipe unique : le bouclier et le poison infligés par l'équipé augmentent de <WeaponEffect_Num:[StateArg1]%>. Lorsque la résistance à la mort est déclenchée, tous les Réveilleurs reçoivent un taux critique temporaire et des dégâts critiques égaux à <WeaponEffect_Num:[StateArg2]%>."
  },
  State_35238_WeaponDesc = {
    Text = "L'attaquant augmente le bouclier et le poison de <WeaponEffect_Num:[StateArg1]%>. Chaque fois qu'une résistance à la mort est déclenchée, tous les réveilleurs reçoivent un taux critique temporaire et des dégâts critiques de <WeaponEffect_Num:[StateArg2] %>"
  },
  State_3523_Desc = {
    Text = "Après avoir joué, affaiblissez tous les ennemis pour [StateArg1] tours"
  },
  State_3523_Name = {
    Text = "<Rune_2_High:Faiblesse avancée>"
  },
  State_3524_Desc = {
    Text = "Augmentation des dégâts subis de [Layer] points"
  },
  State_3524_Name = {
    Text = "Blessure de fusion"
  },
  State_3524_WeaponDesc = {
    Text = "Augmentation des dégâts subis de [Layer] points"
  },
  State_3525_Desc = {
    Text = "Chaque fois que mon équipe joue une carte, applique 2 piles de [Bind]."
  },
  State_3525_Name = {
    Text = "« Région Est - Offre Spéciale »"
  },
  State_3525_WeaponDesc = {
    Text = "Chaque fois que mon équipe joue une carte, applique 2 piles de [Bind]."
  },
  State_35264_Desc = {
    Text = "Ce tour, \"Le Magicien\" gagne 1 couche de Fantasme pour chaque carte jouée."
  },
  State_35264_Name = {
    Text = "Enregistrement de Déplacement d'Ombre"
  },
  State_35277_Name = {
    Text = "La défense magique de Kasiah"
  },
  State_3527_Desc = {
    Text = "Le réveilleur correspondant qui joue la première carte de commandement de chaque tour obtient 15 points de folie à la fin du tour; si en même temps vous avez « esprit dévoué », faites également gagner 5 points de folie aux autres réveilleurs"
  },
  State_3528_Desc = {
    Text = "Augmentation des dégâts, bouclier et guérison de l'équipementeur de [StateArg1]%. (temporaire)"
  },
  State_3528_Name = {
    Text = "État@Domaine du canon laser prototype"
  },
  State_3529_Desc = {
    Text = "Immunité à tous les dégâts, retirée au début du tour"
  },
  State_3529_Name = {
    Text = "Immunité aux dégâts"
  },
  State_3530_Desc = {
    Text = "État @détective chanceux tout miser identification 8"
  },
  State_3530_Name = {
    Text = "État @détective chanceux tout miser identification 8"
  },
  State_3530_WeaponDesc = {
    Text = "État @détective chanceux tout miser identification 8"
  },
  State_3531_Desc = {
    Text = "Équipe Unique : Au début du combat, le porteur obtient <WeaponEffect_Num:[StateArg1]> de fureur. Chaque fois qu'un autre éveilleur libère l'exaltation, le porteur obtient <WeaponEffect_Num:[StateArg2]> de fureur. Si le royaume actuel est « Aequor », après que le porteur ait libéré l'exaltation, il reçoit des dégâts des tentacules équivalents à <WeaponEffect_Num:[StateArg3]%> de son Attaque."
  },
  State_3531_WeaponDesc = {
    Text = "Au début du combat, le porteur obtient <WeaponEffect_Num:[StateArg1]> de fureur. Chaque fois qu'un autre éveilleur libère l'exaltation, le porteur obtient <WeaponEffect_Num:[StateArg2]> de fureur. Si le royaume actuel est « Aequor », après que le porteur ait libéré l'exaltation, les dégâts des tentacules augmentent de <WeaponEffect_Num:+[DescArg1]>."
  },
  State_3532_Desc = {
    Text = "Au début du tour, gagner [StateArg1] arithmetica"
  },
  State_3532_Name = {
    Text = "Bougie noire de la création 1"
  },
  State_3533_Desc = {
    Text = "Apparaît toujours dans la main de départ"
  },
  State_3533_Name = {
    Text = "<GuyouKeywords:Inhérent>"
  },
  State_3533_WeaponDesc = {
    Text = "Après le début du combat, cette carte est fixée dans la main"
  },
  State_3535_Desc = {
    Text = "Augmenter la consommation d'arithmetica de la carte de [Layer] points. Cet effet négatif sera supprimé à la fin du tour ou après avoir joué la carte."
  },
  State_3535_Name = {
    Text = "<SlowColour:Lent temporaire>"
  },
  State_3535_WeaponDesc = {
    Text = "Augmenter la consommation d'arithmetica de la carte de [Layer] points"
  },
  State_3536_Name = {
    Text = "Utilisable 3 fois en combat de boss"
  },
  State_3537_Desc = {
    Text = "Obtenez un sceau lors de l'obtention de \"l'offrande naïve\""
  },
  State_3537_Name = {
    Text = "État@Chapitre 1_Résonance 4"
  },
  State_3537_WeaponDesc = {
    Text = "Obtenez un sceau lors de l'obtention de \"l'offrande naïve\""
  },
  State_3538_Desc = {
    Text = "Utiliser \"Retour naïf\" pour augmenter la récupération de folie"
  },
  State_3538_Name = {
    Text = "État@Chapitre 1_Résonance 1"
  },
  State_3538_WeaponDesc = {
    Text = "Utiliser \"Retour naïf\" pour augmenter la récupération de folie"
  },
  State_3539_Desc = {
    Text = "“Le don innocent” réduit le coût de capacité de 1"
  },
  State_3539_Name = {
    Text = "État@Chapitre 1_Résonance 3"
  },
  State_3539_WeaponDesc = {
    Text = "“Le don innocent” réduit le coût de capacité de 1"
  },
  State_3540_Desc = {
    Text = "“Cadeau innocent” peut cibler une cible"
  },
  State_3540_Name = {
    Text = "État@Chapitre 1_Résonance 2"
  },
  State_3540_WeaponDesc = {
    Text = "“Cadeau innocent” peut cibler une cible"
  },
  State_3541_Desc = {
    Text = "Koum est tombé dans votre piège"
  },
  State_3541_Name = {Text = "Piégé"},
  State_3542_Desc = {
    Text = "Au début de la bataille, pour chaque sceau dans la pioche, gagnez [Arg1] points de pouvoir, et pour chaque création, retrouvez [Arg2] points de vie"
  },
  State_3542_Name = {
    Text = "☆Médaille de la chambre de commerce☆"
  },
  State_3545_Name = {
    Text = "Résistance de l'Éclat Stellaire Sans Limites"
  },
  State_3545_WeaponDesc = {
    Text = "Pour chaque carte jouée, gagnez [StateArg1]% de résistance à la mort. En gagnant une résistance à la mort, récupérez [StateArg2] points de vie"
  },
  State_3546_Desc = {
    Text = "Chaque fois que mon équipe joue une carte, applique [Layer] piles de [Bind]."
  },
  State_3546_Name = {
    Text = "« Région Est - Offre Spéciale »"
  },
  State_3546_WeaponDesc = {
    Text = "Chaque fois que mon équipe joue une carte, applique [Layer] piles de [Bind]."
  },
  State_3547_Desc = {
    Text = "Chaque fois que mon équipe joue une carte, applique [Layer] piles de [Bind]."
  },
  State_3547_Name = {
    Text = "« Région Est - Offre Spéciale »"
  },
  State_3547_WeaponDesc = {
    Text = "Chaque fois que mon équipe joue une carte, applique [Layer] piles de [Bind]."
  },
  State_3548_Desc = {
    Text = "Lorsque vous le piochez, vous êtes affaibli pendant 1 tour. Après usage, affaiblissez tous les ennemis pendant 1 tour. Ne peut pas être vendu"
  },
  State_3548_Name = {
    Text = "État: Affaiblissement de malédiction"
  },
  State_3548_WeaponDesc = {
    Text = "Lorsque vous le piochez, vous êtes affaibli pendant 1 tour. Après usage, affaiblissez tous les ennemis pendant 1 tour. Ne peut pas être vendu"
  },
  State_3549_Name = {
    Text = "État artefact Steppenwolf"
  },
  State_3549_WeaponDesc = {
    Text = "L'attaquant augmente les dégâts de base de 10%. Si les dégâts puissants de l'attaquant dépassent 20%, les dégâts de base augmentent encore de 10%"
  },
  State_35503_Name = {
    Text = "Pendule temporel« Propagation »"
  },
  State_3551_Desc = {
    Text = "Au début du tour, si le nombre de cartes restantes à la fin du dernier tour est supérieur à [StateArg1], gagner [StateArg2] points d'arithmetica"
  },
  State_3551_Name = {
    Text = "Différentiel argenté de la création"
  },
  State_3551_WeaponDesc = {
    Text = "Au début du tour, si le nombre de cartes restantes à la fin du dernier tour est supérieur à [StateArg1], gagner [StateArg2] points d'arithmetica"
  },
  State_35539_Desc = {
    Text = "Les dégâts reçus sont doublés, pendant [Layer] tours"
  },
  State_35539_Name = {
    Text = "Les restes du voyageur"
  },
  State_3553_Desc = {
    Text = "Taux critique augmenté de 25 %. Après une guérison de vie, il y a une chance de provoquer une guérison supplémentaire pour 1 fois, la probabilité égale au taux critique de le guérisseur"
  },
  State_3553_Name = {
    Text = "État @clé en argent de rêve : soin critique"
  },
  State_3554_Desc = {
    Text = "Les effets de bouclier et de soins augmentent de [Layer] %"
  },
  State_3554_Name = {
    Text = "Bouclier et Soin Puissant"
  },
  State_3554_WeaponDesc = {
    Text = "Les effets de bouclier et de soins augmentent de [Layer] %"
  },
  State_3555_Desc = {
    Text = "Lors de la collecte, obtenir 100% de résistance à la mort. Après avoir déclenché la résistance à la mort, à chaque début de tour, récupérer [Arg1] points de vie"
  },
  State_3555_Name = {
    Text = "Souffle de vie"
  },
  State_3556_Desc = {
    Text = "Lors de la collecte de cette création, choisissez une carte et ajoutez une copie de celle-ci au deck"
  },
  State_3558_Desc = {
    Text = "Au début du tour, si le sigil noir est supérieur à 10, dépenser 10 sigils noirs, les dégâts infligés durant ce tour doublent"
  },
  State_3559_Desc = {
    Text = "Infligez 1 couche de vulnérabilité en infligeant des dégâts non bloqués"
  },
  State_3559_Name = {Text = "Griffes"},
  State_3559_WeaponDesc = {
    Text = "Lors de la causation de dégâts réels, mélanger [StateArg1] cartes «blessures» dans la pile de tirage"
  },
  State_3561_Name = {
    Text = "État@CléD'ArgentDesRêves:CompteurTranchementFou"
  },
  State_3562_Desc = {
    Text = "Après la mort, la force des autres alliés augmente de [Layer]"
  },
  State_3562_Name = {
    Text = "Mort-vivant"
  },
  State_35635_Name = {
    Text = "État @réveilleur Casiah objets à distance autorisés à activer"
  },
  State_35636_Name = {
    Text = "État @réveilleur Casiah ajouter des objets à distance"
  },
  State_3563_Desc = {
    Text = "Lorsqu'une blessure non bloquée est infligée, placez [StateArg1] carte(s) « blessure » dans la pile de pioche"
  },
  State_3563_Name = {Text = "Lame"},
  State_3563_WeaponDesc = {
    Text = "Lors de la causation de dégâts réels, mélanger [StateArg1] cartes «blessures» dans la pile de tirage"
  },
  State_35645_Desc = {
    Text = "Ce tour, nombre de cartes piochées réduit de [Layer]"
  },
  State_35645_Name = {
    Text = "Tirage réduit"
  },
  State_35646_Desc = {
    Text = "Ce tour, nombre de cartes piochées réduit de [Layer]"
  },
  State_35646_Name = {
    Text = "Tirage réduit"
  },
  State_3564_Desc = {
    Text = "Après avoir joué, obtenez [StateArg1] points temporaires de pouvoir, cette carte d'impression pourra également bénéficier de l'augmentation de pouvoir"
  },
  State_3564_Name = {
    Text = "<Rune_15_High:Explosion avancée>"
  },
  State_3565_Desc = {
    Text = "Le sculpteur augmente les dégâts de tentacule [StateArg1] lorsqu'il applique un bouclier"
  },
  State_3565_Name = {
    Text = "Royaume de l'Oubli"
  },
  State_3565_WeaponDesc = {
    Text = "Le sculpteur augmente les dégâts de tentacule [StateArg1] lorsqu'il applique un bouclier"
  },
  State_3566_Desc = {
    Text = "Au début du tour, gagner 3 pouvoirs temporaires, [exalter] double ce pouvoir temporaire, empilable jusqu'à 2 fois"
  },
  State_3566_Name = {
    Text = "Mue de serpent étrange des créations"
  },
  State_3567_Desc = {
    Text = "Augmentation des dégâts, bouclier et guérison de l'équipementeur de [StateArg1]%. (temporaire)"
  },
  State_3567_Name = {
    Text = "État@Critique du canon laser prototype"
  },
  State_35684_Desc = {
    Text = "Après que notre équipe ait libéré l'exaltation, elle perdra son pouvoir lors de ce tour. Une fois par tour"
  },
  State_35684_Name = {
    Text = "Crainte de la folie"
  },
  State_35685_Desc = {
    Text = "Libérer la genèse des départs réduit la puissance temporaire des ennemis"
  },
  State_35685_Name = {
    Text = "Crainte de la folie"
  },
  State_3568_Desc = {
    Text = "Lorsque Ramona inflige des dégâts, elle obtient [StateArg1] points de calcul"
  },
  State_3568_Name = {
    Text = "Première philosophie"
  },
  State_3568_WeaponDesc = {
    Text = "Lorsque Ramona inflige des dégâts, elle obtient [StateArg1] points de calcul"
  },
  State_3570_Name = {
    Text = "Pioche +2 cartes au début du prochain tour"
  },
  State_3571_Name = {
    Text = "Immunité temporaire à la faiblesse"
  },
  State_3572_Desc = {
    Text = "Les monstres qu'il invoque infligent des dégâts doublés"
  },
  State_3572_Name = {Text = "Commandant"},
  State_3572_WeaponDesc = {
    Text = "Les monstres qu'il invoque infligent des dégâts doublés"
  },
  State_3573_Desc = {
    Text = "Les premiers dégâts reçus chaque tour sont multipliés par 5"
  },
  State_3573_Name = {Text = "Fierté"},
  State_3573_WeaponDesc = {
    Text = "Les premiers dégâts reçus chaque tour sont doublés"
  },
  State_3574_Desc = {
    Text = "Après avoir joué deux cartes du même éveillé, cet éveillé gagne 10 points de folie"
  },
  State_35768_Name = {
    Text = "Gagnez 300 points de s'énergie"
  },
  State_35769_Name = {
    Text = "Gagnez 1 point d'arthmetica"
  },
  State_35770_Name = {
    Text = "Dissipe <IntoxicationIconKeywords:empoisonnement>, scellé, <SlowIconKeywords:lenteur>"
  },
  State_35771_Name = {
    Text = "Obtenez des boucliers égaux à [DescArg1]% (<Block:[DescArg2]>) de votre santé max"
  },
  State_35772_Name = {
    Text = "Utilisable [StateArg1] fois de plus en combat de boss"
  },
  State_35774_Desc = {
    Text = "Avant de mourir, invoquez une fois l'aide de céleste, restaurer toute vie, aliemus, s-énergie"
  },
  State_35774_Name = {
    Text = "Voile de l'Utopie"
  },
  State_3577_Name = {
    Text = "Augmentation de la récupération automatique de fureur"
  },
  State_35809_Desc = {
    Text = "Les dégâts infligés sont réduits de [StateArg1] %, pendant [Layer] tours."
  },
  State_35809_Name = {
    Text = "Héritier Illusoire"
  },
  State_35809_WeaponDesc = {
    Text = "État@Dame des profondeurs: Thé et gâteau"
  },
  State_3580_Desc = {
    Text = "[Layer] Les dommages infligés par les tentacules pendant le tour sont des dégâts de perforation"
  },
  State_3580_Name = {
    Text = "Tentacules perforantes"
  },
  State_35811_Desc = {
    Text = "Lorsque vous subissez des Dégâts Directs ou des Dégâts des tentacules, gagnez la moitié des dégâts sous forme de <SacrificeKeyWord:Sacrifice> pendant [Layer] <plural value=\"[Layer]\" singular=\"tour\" plural=\"tours\">."
  },
  State_35811_Name = {
    Text = "Héritier Illusoire"
  },
  State_35819_Desc = {
    Text = "À la fin du tour, Murphy obtient 5 points de folie. Après libération de la clé de commande, retire 2% de la santé maximale de <SacrificeKeyWord:sacrifice>"
  },
  State_35819_Name = {
    Text = "Thé noir et gâteau"
  },
  State_3581_Desc = {
    Text = "État@Compteur de la danse de pouvoir de la Dame Rouge"
  },
  State_3581_Name = {
    Text = "État@Compteur de la danse de pouvoir de la Dame Rouge"
  },
  State_3582_Desc = {
    Text = "Même en dehors du tour dimensionnel, un effet de saut peut être déclenché une fois par tour. Pioche une carte correspondante à l'éveillé"
  },
  State_3582_Name = {
    Text = "Déflecteur spatial métamorphosé"
  },
  State_3582_WeaponDesc = {
    Text = "Même en dehors du tour dimensionnel, un effet de saut peut être déclenché une fois par tour. Pioche une carte correspondante à l'éveillé"
  },
  State_3584_Desc = {
    Text = "Augmentation des dégâts, bouclier et guérison de l'équipementeur de [StateArg1]%. (temporaire)"
  },
  State_3584_Name = {
    Text = "État@Domaine du couteau prototype"
  },
  State_35858_Desc = {
    Text = "À la fin du tour, Murphy gagne 5 de folie. Après avoir utilisé une clé, inflige des dégâts de tentacule équivalents à 3% de l'attaque de Murphy"
  },
  State_35858_Name = {
    Text = "Thé noir et gâteau"
  },
  State_3585_Desc = {
    Text = "Lorsque la vie est inférieure à 50%([StateArg1]), le « pasteur de la lanterne » demandera que « Dieu descende », absorbant tous ses fidèles avant de devenir enragé"
  },
  State_3585_Name = {
    Text = "Marque de la mèche"
  },
  State_3585_WeaponDesc = {
    Text = "Lorsque la vie est inférieure à 50%([StateArg1]), le « pasteur de la lanterne » demandera que « Dieu descende », absorbant tous ses fidèles avant de devenir enragé"
  },
  State_3588_Name = {
    Text = "Créature des reliques d'arithmetica"
  },
  State_3589_Desc = {
    Text = "Lors de la réception de Dégâts Directs ou de Dégâts des tentacules, immunité aux dégâts et perd 1 charge."
  },
  State_3589_Name = {
    Text = "<ParcloseColour: Barrière>"
  },
  State_3591_Desc = {
    Text = "Équipe Unique : La <RetaliateIconKeywords:Contre-attaque> du Porteur +<WeaponEffect_Num:[StateArg1]%>. «Défense» accorde une Contre-attaque Temporaire égale à la Défense du Porteur ×<WeaponEffect_Num:[StateArg2]%>. Dans les Combats de Chef, cela devient 3 fois la Contre-attaque Temporaire. Après le déclenchement de la Résistance à la mort, déclenchez [StateArg3]% de <RetaliateIconKeywords:Contre-attaque> contre tous les ennemis."
  },
  State_3591_Name = {
    Text = "Se fondre dans la nuit"
  },
  State_3591_WeaponDesc = {
    Text = "La <RetaliateIconKeywords:Contre-attaque> du Porteur +<WeaponEffect_Num:[StateArg1]%>. Après avoir joué la carte «Défense» du Porteur, gagnez <WeaponEffect_Num:[Counterattack:DescArg1]> charges de Contre-attaque Temporaire. Dans les Combats de Chef, cela devient 3 fois la Contre-attaque Temporaire. Après le déclenchement de la Résistance à la mort, déclenchez [StateArg3]% de <RetaliateIconKeywords:Contre-attaque> contre tous les ennemis."
  },
  State_3592_Desc = {
    Text = "Augmente les dégâts des tentacules"
  },
  State_3592_Name = {
    Text = "<TentacleInjurieIconKeywords:dégâts de tentacule>"
  },
  State_3592_WeaponDesc = {
    Text = "Augmente les dégâts infligés par les tentacules"
  },
  State_3593_Desc = {
    Text = "Unique à l'équipe : Les <IntoxicationIconKeywords:Poison> infligés par l'équipé augmentent de <WeaponEffect_Num:[StateArg1]%>. \"Frappe\" inflige un poison égal à <WeaponEffect_Num:[StateArg2]%> de l'attaque de l'équipé à l'ennemi ciblé. Cet effet peut se produire jusqu'à 3 fois par tour"
  },
  State_3593_WeaponDesc = {
    Text = "Les dégâts de <IntoxicationIconKeywords:poison> infligés par l'équipé augmentent de <WeaponEffect_Num:[StateArg1]%>. \"Attaque\" inflige <WeaponEffect_Num:[Poison:DescArg1]> couches de <IntoxicationIconKeywords:poison> à l'ennemi ciblé. Cet effet peut se produire jusqu'à 3 fois par tour"
  },
  State_3596_Name = {
    Text = "Cœur d'argent résiduel"
  },
  State_35970_Desc = {
    Text = "Après la mort, appliquez 1 tour de <VulnerabilityIconKeywords:vulnérable> aux joueurs"
  },
  State_35970_Name = {
    Text = "Décès prématuré"
  },
  State_35971_Desc = {
    Text = "À l'entrée, obtenez un bouclier équivalent à 50 % de vie maximale"
  },
  State_35971_Name = {
    Text = "Coquille d'œuf"
  },
  State_3597_Name = {
    Text = "Cœur d'argent résiduel"
  },
  State_3598_Name = {
    Text = "Cœur d'argent résiduel"
  },
  State_3599_Desc = {
    Text = "En jouant une carte ayant un coût en arithmetica réel de 4 ou plus, le coût en arithmetica des autres cartes en main est réduit de 1"
  },
  State_36006_Desc = {
    Text = "Après la mort, génère un \"Enfant du Rêve\" à l'endroit"
  },
  State_36006_Name = {Text = "Tank"},
  State_3600_Name = {
    Text = "Cœur d'argent résiduel"
  },
  State_36013_Desc = {
    Text = "Cet état est également considéré comme un <SacrificeKeyWord:sacrifice>, au début du prochain tour, gagnez [Layer] couches de l'état <SacrificeKeyWord:sacrifice>"
  },
  State_36013_Name = {
    Text = "<BlueKeyWord:Sacrifice différé>"
  },
  State_36014_Desc = {
    Text = "À la fin du tour, subit [Layer] de dégâts et réduit de 50% les couches de <SacrificeKeyWord:sacrifice>"
  },
  State_36014_Name = {
    Text = "<BlueKeyWord:Sacrifice>"
  },
  State_3601_Name = {
    Text = "État@CléD'ArgentDesRêves:CompteurDanseCirculaire"
  },
  State_36022_Desc = {
    Text = "En recevant des dégâts autres que ceux de <SacrificeKeyWord:sacrifice>, gagnez 50 % des dégâts en <SacrificeKeyWord:sacrifice>"
  },
  State_36022_Name = {Text = "Visite"},
  State_36023_Desc = {
    Text = "Après la mort, s'il y a d'autres alliés, génère un \"Enfant de l'Eau\""
  },
  State_36023_Name = {Text = "Tank"},
  State_36024_Desc = {
    Text = "Après la mort, s'il y a d'autres alliés, génère un \"Enfant du Rêve\""
  },
  State_36024_Name = {Text = "Tank"},
  State_3603_Name = {
    Text = "Utilisable 2 fois en combat de boss, retourne en main après la première utilisation"
  },
  State_3604_Desc = {
    Text = "Lorsque l'équipe est composée d'éveillés de différentes classes, la vie de l'équipe et l'attaque et la défense de tous les éveillés augmentent de 200%"
  },
  State_3604_Name = {
    Text = "État@Bonus mixte"
  },
  State_3604_WeaponDesc = {
    Text = "Lorsque l'équipe est composée d'éveillés de différentes classes, la vie de l'équipe et l'attaque et la défense de tous les éveillés augmentent de 200%"
  },
  State_3607_Desc = {
    Text = "Après avoir joué, le réveilleur obtiendra une augmentation spéciale de compétences pour ce combat. Jouer Réveil plusieurs fois ne s'additionnera pas"
  },
  State_3607_Name = {
    Text = "<ExaltIconKeywords:réveil>"
  },
  State_3607_WeaponDesc = {
    Text = "Lorsqu'un réveil de gnose est activé, le réveilleur obtient une augmentation spéciale de capacité pour cette bataille. Les réveils de gnose répétés ne s'accumulent pas en effet"
  },
  State_3608_Name = {
    Text = "Tous les alliés gagnent [StateArg1] points de folie"
  },
  State_36092_Desc = {
    Text = "Après la mort, s'il y a d'autres alliés, génère un \"Enfant de l'Eau\" à l'endroit"
  },
  State_36092_Name = {Text = "Tank"},
  State_36093_Desc = {
    Text = "Pour chaque point de vie perdu, réduisez une couche. À zéro couche, après le tour des monstres, invoquez un \"Enfant de l'eau\" et regagnez [DescArg1] couches d'\"Hôte de l'eau\", jusqu'à 4 \"Enfants de l'eau\""
  },
  State_36093_Name = {
    Text = "Hôte de l'eau"
  },
  State_36094_Desc = {
    Text = "Pour chaque point de vie perdu, réduisez une couche. À zéro couche, invoquez un \"Enfant de la perception\" et regagnez [DescArg1] couches d'\"Hôte de corail\", jusqu'à 4 \"Enfants de la perception\""
  },
  State_36094_Name = {
    Text = "Hôte de la Conscience Spirituelle"
  },
  State_3609_Name = {
    Text = "Dans une bataille de chef, une carte peut être utilisée 2 fois et après la première utilisation, revient à la main, la carte piochée ce tour coûte moins 1 en calcul"
  },
  State_36111_Desc = {
    Text = "Lors de la mort, ajoutez 1 \"Prolifération de Coral\" à la main du joueur."
  },
  State_36111_Name = {
    Text = "Corail parasite"
  },
  State_3611_Desc = {
    Text = "État@PrologueMonstrePassif12"
  },
  State_3611_Name = {
    Text = "État@PrologueMonstrePassif12"
  },
  State_3611_WeaponDesc = {
    Text = "État@PrologueMonstrePassif12"
  },
  State_36124_Desc = {
    Text = "Après la fin du tour, subit [Layer] de dégâts et réduit de 50% les couches de « Sacrifice »"
  },
  State_36124_Name = {
    Text = "<BlueKeyWord:Sacrifice>"
  },
  State_3612_Desc = {
    Text = "État@PrologueMonstrePassif13"
  },
  State_3612_Name = {
    Text = "État@PrologueMonstrePassif13"
  },
  State_3612_WeaponDesc = {
    Text = "État@PrologueMonstrePassif13"
  },
  State_36136_Name = {
    Text = "Tant qu'elle est en main, subit [StateArg1] <FixedDamage:DGT Purs> pour chaque autre carte jouée."
  },
  State_3613_Desc = {
    Text = "État@PrologueMonstrePassif10"
  },
  State_3613_Name = {
    Text = "État@PrologueMonstrePassif10"
  },
  State_3613_WeaponDesc = {
    Text = "État@PrologueMonstrePassif10"
  },
  State_3614_Desc = {
    Text = "État@PrologueMonstrePassif11"
  },
  State_3614_Name = {
    Text = "État@PrologueMonstrePassif11"
  },
  State_3614_WeaponDesc = {
    Text = "État@PrologueMonstrePassif11"
  },
  State_36152_Desc = {
    Text = "À la fin du tour, subit des dégâts équivalents aux couches, puis retire 50 % des couches de <SacrificeKeyWord:sacrifice>. Le <SacrificeKeyWord:sacrifice> est transféré au combat suivant."
  },
  State_36152_Name = {
    Text = "<SacrificeKeyWord:Sacrifice>"
  },
  State_3615_Desc = {
    Text = "État@PrologueMonstrePassif16"
  },
  State_3615_Name = {
    Text = "État@PrologueMonstrePassif16"
  },
  State_3615_WeaponDesc = {
    Text = "État@PrologueMonstrePassif16"
  },
  State_3616_Desc = {
    Text = "État@PrologueMonstrePassif14"
  },
  State_3616_Name = {
    Text = "État@PrologueMonstrePassif14"
  },
  State_3616_WeaponDesc = {
    Text = "État@PrologueMonstrePassif14"
  },
  State_36173_Name = {
    Text = "Utilisable [DescArg1] fois en combat de boss"
  },
  State_36174_Name = {
    Text = "(Il reste [Layer] fois)"
  },
  State_3617_Desc = {
    Text = "État@PrologueMonstrePassif15"
  },
  State_3617_Name = {
    Text = "État@PrologueMonstrePassif15"
  },
  State_3617_WeaponDesc = {
    Text = "État@PrologueMonstrePassif15"
  },
  State_36182_Name = {
    Text = "Obtenez des boucliers égaux à [DescArg1]% (<Block:[DescArg2]>) de votre santé max et récupérez la même quantité de vie. Les boucliers augmentent avec la santé perdue"
  },
  State_3618_Desc = {
    Text = "En recevant des dégâts réels, gagnez un bouclier"
  },
  State_3618_Name = {Text = "tampon"},
  State_3618_WeaponDesc = {
    Text = "En recevant des dégâts réels, gagnez un bouclier"
  },
  State_36196_Desc = {
    Text = "Les dégâts de \"frappe\" de Lotan augmentent de 30 %"
  },
  State_36196_Name = {
    Text = "Vent de l'épée indomptable"
  },
  State_3619_Desc = {
    Text = "État@danseur de flamme bleue frappe défense"
  },
  State_3619_Name = {
    Text = "État@danseur de flamme bleue frappe défense"
  },
  State_3619_WeaponDesc = {
    Text = "État@danseur de flamme bleue frappe défense"
  },
  State_3620_Desc = {
    Text = "Chaque fois que vous gagnez une carte de symptôme, augmentez votre santé maximale de [Arg1] points"
  },
  State_3621_Desc = {
    Text = "Pour chaque carte jouée par le Croyant Primordial, piochez [StateArg1] cartes, infligez 5% de poison à tous les ennemis"
  },
  State_3621_Name = {
    Text = "Obsession étouffée"
  },
  State_3621_WeaponDesc = {
    Text = "Pour chaque carte jouée par le Croyant Primordial, piochez [StateArg1] cartes"
  },
  State_3622_Desc = {
    Text = "Améliore les effets de compétence de \"Chasseur de Crâne Enragé\" et \"Le Décédé\", gagnant [StateArg1] STR Temporaire au début de chaque tour, et augmentant de [StateArg1] points pour chaque couche de \"Marque de Chasse\"."
  },
  State_3622_Name = {
    Text = "Marque de chasse"
  },
  State_36242_Desc = {
    Text = "Après le début du combat, obtenir [StateArg1] points de bouclier. Après avoir perdu la vie, le « Saint enfant » mettra fin à son sommeil profond et commencera à pleurer"
  },
  State_36242_Name = {
    Text = "Sommeil Profond"
  },
  State_3624_Desc = {
    Text = "État@connaisseur analyse offensive réduction du pouvoir"
  },
  State_3624_Name = {
    Text = "État@connaisseur analyse offensive réduction du pouvoir"
  },
  State_3625_Desc = {
    Text = "Avec un bouclier, les dégâts augmentent de [Arg1]. Si le bouclier est supérieur à la vie actuelle, les dégâts augmentent de [Arg2]"
  },
  State_36263_Desc = {
    Text = "Préparez-vous à libérer la \"Graine de la Naissance\" sans subir de dégâts"
  },
  State_36263_Name = {Text = "Immunité"},
  State_3628_Name = {
    Text = "État@DéfenseBriséeAprèsJeu"
  },
  State_3629_Name = {
    Text = "Pioche 2 cartes"
  },
  State_3630_Name = {
    Text = "Applique 2 couches <VulnerabilityIconKeywords:vulnérable> à tous les ennemis"
  },
  State_36315_Desc = {
    Text = "À la fin du tour, gagne [Layer] points de force"
  },
  State_36315_Name = {Text = "Bénie"},
  State_3631_Name = {
    Text = "Gagnez 2 points d'arthmetica"
  },
  State_3632_Name = {
    Text = "Obtenez <Energy:[DescArg1]> points de folie"
  },
  State_36332_Desc = {
    Text = "Au début de chaque tour, choisissez de gagner 1 niveau de pouvoir de la Mère ou de consommer ce pouvoir pour obtenir l'aide de Murphy une fois"
  },
  State_36332_Name = {
    Text = "Pouvoir de la Mère Divine"
  },
  State_36334_Desc = {
    Text = "À la fin de chaque tour, gagnez 1 tentacule"
  },
  State_36334_Name = {
    Text = "Appel des Visages Cachés"
  },
  State_3633_Name = {
    Text = "Inflige 2 couches de <WeaknessIconKeywords:Faiblesse> à tous les ennemis"
  },
  State_36346_Desc = {
    Text = "Quand la vie tombe à 0, elle devient 1 point, ne subit plus de dégâts et prépare à libérer \"Graine de naissance\""
  },
  State_36346_Name = {
    Text = "Graine de Naissance"
  },
  State_3634_Name = {
    Text = "Ajoutez 2 cartes <DerivativeCardKeywords_4:\"Inspiration\"> à votre pile de pioche."
  },
  State_3635_Name = {
    Text = "Les autres éveillés gagnent <Energy:[DescArg1]> points de folie"
  },
  State_36360_Desc = {
    Text = "Au début du tour, [DescArg1]% de chance de gagner 1 couche de tentacules, au-delà de 100%, plusieurs couches possibles"
  },
  State_36360_Name = {
    Text = "Ligne de retour à la mer"
  },
  State_36361_Desc = {
    Text = "À l'entrée, tous les alliés gagnent [Layer] de puissance"
  },
  State_36361_Name = {
    Text = "Déscent de l'Anomalie"
  },
  State_3636_Desc = {
    Text = "État@Création envoûtée: Carillon actif"
  },
  State_3636_Name = {
    Text = "État@Création envoûtée: Carillon actif"
  },
  State_3637_Desc = {
    Text = "Si la vie est inférieure à 25% sans mourir, restaure [Arg1] de vie. Après 3 fois, désactivé"
  },
  State_3637_Name = {
    Text = "☆Nourriture d'urgence☆"
  },
  State_3638_Desc = {
    Text = "Lors de la réception de Dégâts Directs ou de Dégâts des tentacules, immunité aux dégâts et perd 1 charge."
  },
  State_3638_Name = {
    Text = "<ParcloseColour: Barrière>"
  },
  State_3638_WeaponDesc = {
    Text = "Dégâts reçus -99%. À chaque fois que des dégâts sont reçus, perd 1 charge."
  },
  State_3639_Desc = {
    Text = "Lorsque Ramona inflige des dégâts, elle obtient [StateArg1] points de calcul"
  },
  State_3639_Name = {
    Text = "Troisième philosophie"
  },
  State_3639_WeaponDesc = {
    Text = "Lorsque Ramona inflige des dégâts, elle obtient [StateArg1] points de calcul"
  },
  State_3641_Desc = {
    Text = "Choisissez une carte au « sujet de la sculpture inachevée » et réduisez la puissance de 1"
  },
  State_3641_Name = {
    Text = "État@Chapitre 2_Résonance_Effet de base"
  },
  State_3641_WeaponDesc = {
    Text = "Au nœud \"Statue inachevée\", le niveau des cartes copiées augmente de 1"
  },
  State_3642_Desc = {
    Text = "Chaque fois que vous perdez de la vie, vous gagnez [Arg1] niveaux de comptoir. Si c'est la 3ème activation dans un seul tour, infligez 1 dégât de comptoir à tous les ennemis"
  },
  State_3642_Name = {
    Text = "Chrono du défunt"
  },
  State_3646_Desc = {
    Text = "HP ne peut pas descendre en dessous de 1. En cas de dommages fatals, l'intention change en Impasse Survivante. [Impasse Survivante] : Restituer 100 % des HP Max, doubler la Force, et Améliorer les compétences suivantes."
  },
  State_3646_Name = {
    Text = "Survivre dans l'adversité"
  },
  State_3647_Name = {
    Text = "Compteur de l'enregistrement d'Arcana de la création"
  },
  State_3648_Desc = {
    Text = "Unique à l'équipe : Les effets de soins de l'équipé augmentent de <WeaponEffect_Num:[StateArg2]%>. Au début du tour, gagne une <PowerIconKeywords:force> et un bouclier temporaires égaux à <WeaponEffect_Num:[StateArg1]%> de la vie perdue au tour précédent"
  },
  State_3648_WeaponDesc = {
    Text = "L'effet de régénération de vie de l'équipé augmente de <WeaponEffect_Num:[StateArg2]>. Au début du tour, gagne un <PowerIconKeywords:Force> et un bouclier temporaires égaux à <WeaponEffect_Num:[StateArg1]%> de la vie perdue au tour précédent"
  },
  State_3649_Desc = {
    Text = "Pour chaque réveilleur professionnel de type [ultra] dans l'équipe, la santé max (incomplète), la défense et l'attaque de toute l'équipe augmentent de 50%"
  },
  State_3649_Name = {
    Text = "Bonus Hyperdimensionnel"
  },
  State_3649_WeaponDesc = {
    Text = "Pour chaque réveilleur professionnel de type [ultra] dans l'équipe, la santé max (incomplète), la défense et l'attaque de toute l'équipe augmentent de 50%"
  },
  State_3651_Desc = {
    Text = "Changez le coût en arithmetica de la carte avant de la jouer"
  },
  State_3651_Name = {
    Text = "Changez le coût en arithmetica de la carte avant de la jouer"
  },
  State_3651_WeaponDesc = {
    Text = "Changez le coût en arithmetica de la carte avant de la jouer"
  },
  State_3652_Desc = {
    Text = "Au début du tour, si plus de [StateArg1] cartes ont été jouées au tour précédent, piochez [StateArg2] cartes"
  },
  State_3652_Name = {
    Text = "Gants magiques de la création"
  },
  State_3652_WeaponDesc = {
    Text = "Au début du tour, si plus de [StateArg1] cartes ont été jouées au tour précédent, piochez [StateArg2] cartes"
  },
  State_3653_Name = {
    Text = "Drapeau de bataille brisé des créations 2"
  },
  State_3654_Desc = {
    Text = "Au début du tour, obtient [Layer]% de taux critique temporaire"
  },
  State_3654_Name = {
    Text = "Son doux s'intensifie"
  },
  State_3654_WeaponDesc = {
    Text = "Avant de perdre de la vie jusqu'au début du prochain tour, votre taux critique pour le prochain tour augmente de [StateArg1]%"
  },
  State_3656_Desc = {
    Text = "Cet éveilleur n'est pas encore éveillé... Il s'éveillera lorsqu'il sera sur le point d'être abattu, restaurera sa vie et commencera à se battre sous sa véritable forme"
  },
  State_3656_Name = {
    Text = "Non Réveillé"
  },
  State_3658_Desc = {
    Text = "En jouant la dernière carte en main, piochez 2 cartes. Maximum 2 fois par tour"
  },
  State_3659_Name = {
    Text = "État@carte de frappe taux critique augmentation des dégâts critiques"
  },
  State_36613_Name = {
    Text = "État@Accessoire: Compteur de la descente mécanique"
  },
  State_3661_Desc = {
    Text = "Les dégâts réels augmentent les couches de corrosion profonde"
  },
  State_3661_Name = {
    Text = "Les dégâts reçus augmentent les couches de corrosion profonde"
  },
  State_3661_WeaponDesc = {
    Text = "Les dégâts réels augmentent les couches de corrosion profonde"
  },
  State_3662_Desc = {
    Text = "Dans ce combat, les dégâts critiques augmentent de [Layer] %"
  },
  State_3662_Name = {
    Text = "Dégâts Critiques"
  },
  State_3662_WeaponDesc = {
    Text = "Dans ce combat, les dégâts critiques augmentent de [Layer] %"
  },
  State_36631_Desc = {
    Text = "Chaque fois que la colère est déchaînée, augmente de 1 couche de « Gestation », chaque couche de gestation accorde [StateArg1] points de pouvoir, avec un maximum de 5 couches"
  },
  State_36631_Name = {
    Text = "Fausse porteuse"
  },
  State_36635_Desc = {
    Text = "Chaque fois que la colère est déchaînée, augmente de 1 couche de « Gestation », chaque couche de gestation accorde [StateArg1] points de pouvoir, avec un maximum de 5 couches"
  },
  State_36635_Name = {
    Text = "La Descente Finale de Lémuria"
  },
  State_36636_Desc = {
    Text = "Lorsque vous atteignez 5 couches, libérez \"La Gloire de Lémurie !\", causant des dégâts massifs et invoquant les proches."
  },
  State_36636_Name = {Text = "Naissance"},
  State_36637_Desc = {
    Text = "Lorsque vous atteignez 5 couches, libérez \"Pour Lémurie !\", causant des dégâts massifs et invoquant les proches."
  },
  State_36637_Name = {Text = "Naissance"},
  State_3663_Desc = {
    Text = "Après avoir joué une carte chaque tour, ajoutez une carte \"Frappe\" de l'entité éveillée correspondante à votre main"
  },
  State_3664_Desc = {
    Text = "Après avoir joué, gagnez 5 points de folie"
  },
  State_3664_Name = {Text = "Hommage"},
  State_3664_WeaponDesc = {
    Text = "Après avoir joué, gagnez 5 points de folie"
  },
  State_3665_Desc = {
    Text = "Lorsque la Fusion d'Embryon atteint sa limite, placez un « Embryon » dans votre main."
  },
  State_3665_Name = {
    Text = "<EmbryoFusionIconKeywords:fusion d'embryon>"
  },
  State_3666_Desc = {
    Text = "Taux critique augmenté de [Layer] %"
  },
  State_3666_Name = {
    Text = "Taux Critique"
  },
  State_3666_WeaponDesc = {
    Text = "Taux critique augmenté de [Layer] %"
  },
  State_36670_Name = {
    Text = "État@Accessoire: Compteur de réévolution"
  },
  State_36670_WeaponDesc = {
    Text = "À la fin du tour, l'équipé gagne 3 points de folie. Si la recharge de folie de l'équipé est supérieure à 10, il gagne 2 points de folie supplémentaires"
  },
  State_3667_Desc = {
    Text = "Équipe unique : Les <RetaliateIconKeywords: Contre-attaque> infligés par le porteur augmentent de <WeaponEffect_Num:[StateArg4]%>. Après avoir joué une carte, le porteur reçoit une <RetaliateIconKeywords: Contre-attaque> équivalente à <WeaponEffect_Num:[StateArg1]%> de sa défense, jusqu'à 2 fois par tour. Si elle entre dans l'Espace Hyperspatial, le porteur obtient également <WeaponEffect_Num:[StateArg2]> points de Fureur. Après avoir libéré l'Exaltation, tous les ennemis perdent une Force Temporaire équivalente à <WeaponEffect_Num:[StateArg3]%> de la défense du porteur."
  },
  State_3667_WeaponDesc = {
    Text = "Le <RetaliateIconKeywords:Contre-attaque> causé par le porteur augmente de <WeaponEffect_Num:[StateArg4] %>. Après avoir joué une carte, le porteur obtient <WeaponEffect_Num:[Counterattack:DescArg1]> points de <RetaliateIconKeywords:Contre-attaque>, pouvant se déclencher jusqu'à 2 fois par tour. Si elle entre dans l'Espace Hyperspatial, le porteur obtient également <WeaponEffect_Num:[StateArg2]> points de Fureur. Après avoir libéré l'exaltation, tous les ennemis voient temporairement leur <PowerIconKeywords:Force> réduite de <WeaponEffect_Num:[Power:DescArg2]> points."
  },
  State_3668_Desc = {
    Text = "État@MarqueurGardienJardinAltéré"
  },
  State_3668_Name = {
    Text = "État@MarqueurGardienJardinAltéré"
  },
  State_3668_WeaponDesc = {
    Text = "État@MarqueurGardienJardinAltéré"
  },
  State_3669_Desc = {
    Text = "Immunité aux états Symptôme : Affaiblir, Fragile et Vulnérable pendant [Layer] <plural value=\"[Layer]\" singular=\"tour\" plural=\"tours\">."
  },
  State_3669_Name = {
    Text = "<BlessingColour: Bénédiction>"
  },
  State_3669_WeaponDesc = {
    Text = "[Layer] Immunisé contre les états négatifs pendant le tour"
  },
  State_36710_Name = {
    Text = "Danse de la Lune Convexe"
  },
  State_3673_Desc = {
    Text = "Après ramassage, choisissez 2 cartes à supprimer et gagnez [StateArg1] force"
  },
  State_3673_Name = {
    Text = "Cendres brûlantes de l'étoile noire de la création"
  },
  State_3674_Desc = {
    Text = "À la fin du tour, réduisez de 10 la folie de tous les éveillés"
  },
  State_3674_Name = {
    Text = "Anéantissement"
  },
  State_3674_WeaponDesc = {
    Text = "À la fin du tour, réduisez de 10 la folie de tous les éveillés"
  },
  State_3675_Name = {
    Text = "Tire le nombre de cartes défaussées + 1 carte"
  },
  State_3676_Desc = {
    Text = "Réduction des dégâts subis pendant le tour de l'adversaire de [Layer] %"
  },
  State_3676_Name = {Text = "Vigilance"},
  State_3676_WeaponDesc = {
    Text = "Les monstres gagnent [Layer] % de réduction de dégâts pendant le tour de notre équipe"
  },
  State_3677_Desc = {
    Text = "Augmente la défense de [Layer]%"
  },
  State_3677_Name = {
    Text = "Défense temporaire augmentée en pourcentage"
  },
  State_3677_WeaponDesc = {
    Text = "Augmente la défense de [Layer]%"
  },
  State_36781_Desc = {
    Text = "Lorsque la force est réduite, seules 50 % des couches de force sont diminuées"
  },
  State_36781_Name = {
    Text = "Volonté assoiffée de chair"
  },
  State_3678_Name = {
    Text = "État@création d'événement1"
  },
  State_36797_Desc = {
    Text = "Ce tour, dégâts de tentacule réduits de [Layer]"
  },
  State_36797_Name = {
    Text = "Dommages des tentacules réduits"
  },
  State_3679_Name = {
    Text = "État@création d'événement2"
  },
  State_3680_Desc = {
    Text = "Chaque fois qu'un dommage est infligé, appliquez [Arg1] couches de poison à la cible. Si le nombre d'activations dans ce combat atteint 25, déclenchez immédiatement le poison sur tous les ennemis"
  },
  State_3681_Desc = {
    Text = "Lorsqu'il inflige des dégâts non bloqués, applique [DescArg1] charges de <BrokenCard:Sabotage> sur 2 «Cartes d'instruction» aléatoires."
  },
  State_3681_Name = {
    Text = "Jenkins Éveil!"
  },
  State_3681_WeaponDesc = {
    Text = "Au début du prochain tour, obtenez un bouclier équivalent à la vie perdue au tour précédent"
  },
  State_3682_Desc = {
    Text = "Pour chaque 10% de vie perdue, tous les réveilleurs gagnent 10 de folie, et la mort augmente les dégâts de tentacule"
  },
  State_3682_Name = {
    Text = "Cœur d'argent profondément enfoui"
  },
  State_3682_WeaponDesc = {
    Text = "Pour chaque 10% de vie perdue, tous les réveilleurs gagnent 10 de folie, et la mort augmente les dégâts de tentacule"
  },
  State_3683_Desc = {
    Text = "Équipe unique : Les soins causés par les cartes d'instruction du porteur augmentent de <WeaponEffect_Num:[StateArg2] %>. Avant que le porteur ne libère « Exaltation », les autres éveilleurs reçoivent <WeaponEffect_Num:[StateArg1]> points de Fureur. Si notre équipe est dans un état de <VulnerabilityIconKeywords: Vulnérable>, l'effet est doublé."
  },
  State_3683_WeaponDesc = {
    Text = "Les soins causés par les cartes d'instruction du porteur augmentent de <WeaponEffect_Num:[StateArg2] %>. Avant que le porteur ne libère l'exaltation, les autres éveilleurs reçoivent <WeaponEffect_Num:[StateArg1]> points de fureur. Si notre équipe est dans un état de <VulnerabilityIconKeywords: Vulnérable>, l'effet est doublé."
  },
  State_3684_Desc = {
    Text = "Chaque fois que 1 point de dégâts est subi, le niveau diminue de 1. Lorsque le niveau atteint 0, l'intention est remplacée par la Fleur d'Immortalité et un groupe de compétences axé sur la défense est utilisé"
  },
  State_3684_Name = {
    Text = "Fleur immortelle"
  },
  State_3684_WeaponDesc = {
    Text = "Après avoir subi 1 point de dégâts, réduisez 1 couche. Lorsque le nombre de couches atteint 0, passez en mode défense"
  },
  State_3685_Desc = {
    Text = "Lorsque vous le piochez, perdez 1 point d’arithmetica et piochez 1 carte"
  },
  State_3685_Name = {Text = "Confusion"},
  State_3685_WeaponDesc = {
    Text = "Lorsque vous le piochez, perdez 1 point d’arithmetica et piochez 1 carte"
  },
  State_3686_Desc = {
    Text = "Lorsque vous le piochez, perdez 1 point d’arithmetica et piochez 1 carte"
  },
  State_3686_Name = {
    Text = ": Sceau dimensionnel"
  },
  State_3686_WeaponDesc = {
    Text = "Lorsque vous le piochez, perdez 1 point d’arithmetica et piochez 1 carte"
  },
  State_36884_Desc = {
    Text = "Dans ce combat, le dernier vœu ne peut plus obtenir de bouclier en activant la résistance à la mort"
  },
  State_36884_Name = {
    Text = "Dernier Serment"
  },
  State_3688_Desc = {
    Text = "Lorsque vous jouez 2 cartes ayant une consommation de puissance supérieure à celle de la carte précédente, gagnez 2 points de puissance"
  },
  State_3688_Name = {
    Text = "Enregistrement d'Arcana de la création"
  },
  State_3688_WeaponDesc = {
    Text = "Lorsque vous jouez 2 cartes ayant une consommation de puissance supérieure à celle de la carte précédente, gagnez 2 points de puissance"
  },
  State_3689_Desc = {
    Text = "Au début du tour, la maîtrise du domaine augmente de 30. Si vous n'êtes pas en état négatif, la maîtrise du domaine augmente de 100"
  },
  State_3692_Desc = {
    Text = ": Possède des cartes mystiques de mille formes. Choisissez celle dont vous avez le plus besoin !"
  },
  State_3692_Name = {
    Text = "<CardKeyWord: Mille mirages>"
  },
  State_3692_WeaponDesc = {
    Text = ": Possède des cartes mystiques de mille formes. Choisissez celle dont vous avez le plus besoin !"
  },
  State_3693_Desc = {
    Text = "Taux critique augmenté de 25 %. Après une guérison de vie, il y a une chance de provoquer une guérison supplémentaire pour 1 fois, la probabilité égale au taux critique de le guérisseur"
  },
  State_3693_Name = {
    Text = "État @clé en argent de rêve : soin critique"
  },
  State_3696_Desc = {
    Text = "Chaque fois qu'un dommage est infligé, obtenez [Arg1] points d'alerte dans ce tour. Au début du tour, pour chaque 3 points de bouclier restants, obtenez 1 point de pouvoir dans ce tour"
  },
  State_3696_Name = {
    Text = "Pendule temporel« Caché »"
  },
  State_3697_Desc = {
    Text = "Au début du tour, tire 1 carte. Après avoir joué deux fois des cartes avec la même consommation de puissance que la carte précédente, tire une carte supplémentaire"
  },
  State_3698_Desc = {
    Text = "Après avoir joué, copie [StateArg1] cartes dans l'<DimensionalSpaceIconKeywords:espace dimensionnel> temporaire"
  },
  State_3698_Name = {
    Text = "<Rune_13:Distorsion>"
  },
  State_3699_Name = {
    Text = "Cœur d'argent résiduel"
  },
  State_3700_Desc = {
    Text = "Augmente l'attaque de [Layer]%"
  },
  State_3700_Name = {
    Text = "Augmentation temporaire du pourcentage d'attaque"
  },
  State_3700_WeaponDesc = {
    Text = "Augmente l'attaque de [Layer]%"
  },
  State_3702_Desc = {
    Text = "État@modification générale santé max"
  },
  State_3702_Name = {
    Text = "État@modification générale santé max"
  },
  State_3702_WeaponDesc = {
    Text = "État@modification générale santé max"
  },
  State_3703_Name = {
    Text = "État@Chapitre 4_Résonance@Tour suivant: Pioche 2"
  },
  State_3704_Desc = {
    Text = "Maîtrise des domaines augmentée de 30. Choisissez une création et remplacez-la par une création aléatoire"
  },
  State_3705_Name = {
    Text = "Réveil de la mer 3"
  },
  State_3707_Desc = {
    Text = "Après le début du combat, [StateArg1] cartes temporaires sont mélangées dans la pile de cartes, les cartes originales et les cartes miroir obtiennent conserver"
  },
  State_3707_Name = {
    Text = "<Rune_8:Mirage>"
  },
  State_3708_Desc = {
    Text = "À la fin des tours pairs, chaque carte restante vous permet d'obtenir 1 point de calcul au début de votre prochain tour"
  },
  State_3708_Name = {
    Text = "Chapitre du sage des créations 2"
  },
  State_3708_WeaponDesc = {
    Text = "À la fin des tours pairs, chaque carte restante vous permet d'obtenir 1 point de calcul au début de votre prochain tour"
  },
  State_3709_Desc = {
    Text = "À la fin du tour impair, chaque point d'arithmétique restante vous permet de piocher 1 carte au début du prochain tour"
  },
  State_3709_Name = {
    Text = "Chapitre du sage des créations 1"
  },
  State_3709_WeaponDesc = {
    Text = "À la fin du tour impair, chaque point d'arithmétique restante vous permet de piocher 1 carte au début du prochain tour"
  },
  State_3711_Desc = {
    Text = "Chaque action cause [Layer] saignement"
  },
  State_3711_Name = {Text = "Sang"},
  State_3711_WeaponDesc = {
    Text = "Chaque action inflige [Layer] de saignement, la guérison peut réduire de moitié le nombre de couches de saignement"
  },
  State_3712_Desc = {
    Text = "Après avoir joué une carte, consommez-la, la carte de commandement inflige 3 fois les dégâts et la protection, pendant 1 tour"
  },
  State_3712_Name = {Text = "Dissoudre"},
  State_3714_Desc = {
    Text = "Après avoir joué, gagnez [StateArg1] points de bouclier"
  },
  State_3714_Name = {
    Text = "<Rune_6:Mur de fer>"
  },
  State_3716_Desc = {
    Text = "Dans ce combat, le taux critique augmente de [Layer] %"
  },
  State_3716_Name = {
    Text = "Taux Critique"
  },
  State_3719_Desc = {
    Text = "Pour chaque instance de Dégâts Directs reçus, la Tentacule contre-attaque la source des dégâts une fois, pendant [Layer] <plural value=\"[Layer]\" singular=\"tour\" plural=\"tours\">."
  },
  State_3719_Name = {
    Text = "Sang hérétique"
  },
  State_3720_Desc = {
    Text = "Augmente la défense de [Layer]"
  },
  State_3720_Name = {
    Text = "Augmentation de la défense générale"
  },
  State_3720_WeaponDesc = {
    Text = "Augmente la défense de [Layer]"
  },
  State_3721_Desc = {
    Text = "Après avoir joué, elle ne sera pas mise dans la défausse, mais retirée de la pioche"
  },
  State_3721_Name = {
    Text = "Consommation"
  },
  State_3721_WeaponDesc = {
    Text = "Après avoir joué, la carte ne sera pas mise dans la défausse et ne pourra pas être utilisée à nouveau dans ce combat"
  },
  State_3722_Desc = {
    Text = "Chaque fois que des dégâts sont causés, augmente temporairement les dégâts de tentacule [StateArg1], empilable jusqu'à 5 fois. Lorsqu'il est au maximum, générez un tentacule"
  },
  State_3722_Name = {
    Text = "Sceptre du prêtre des créations"
  },
  State_3722_WeaponDesc = {
    Text = "Chaque fois que des dégâts sont causés, augmente temporairement les dégâts de tentacule [StateArg1], empilable jusqu'à 5 fois. Lorsqu'il est au maximum, générez un tentacule"
  },
  State_3723_Name = {
    Text = "Miroir noir de la création"
  },
  State_3724_Desc = {
    Text = "Lors de la collecte, perdre toutes les autres reliques et obtenir aléatoirement 2 reliques en or"
  },
  State_3726_Name = {
    Text = "Banquet de cadavres déformés"
  },
  State_3728_Desc = {
    Text = "Au début du combat, obtenez une [attaque]"
  },
  State_3728_Name = {
    Text = "Saut de baleine pour l'illumination 1"
  },
  State_3728_WeaponDesc = {
    Text = "Au début du combat, obtenez une [attaque]"
  },
  State_3730_Desc = {
    Text = "État@monstre illusion tragédie couleur miel des démons doux"
  },
  State_3730_Name = {
    Text = "État@monstre illusion tragédie couleur miel des démons doux"
  },
  State_3730_WeaponDesc = {
    Text = "État@monstre illusion tragédie couleur miel des démons doux"
  },
  State_3731_Desc = {
    Text = "Chaque fois que notre équipe fait des achats au magasin, lors du prochain combat, piocher 1 carte supplémentaire chaque tour et gagner 1 point d'arithmetica"
  },
  State_3732_Desc = {
    Text = "Tous les 3 tours, obtient 3 tentacules temporaires, ignorent la limite de tentacules"
  },
  State_3732_Name = {
    Text = "Appendice sans nom des créations"
  },
  State_3732_WeaponDesc = {
    Text = "Tous les 3 tours, obtient 3 tentacules temporaires, ignorent la limite de tentacules"
  },
  State_3733_Desc = {
    Text = "À la fin du tour impair, l'arithmétique restante se transforme en pioche supplémentaire pour le tour suivant ; à la fin du tour pair, les cartes restantes se transforment en arithmétique supplémentaire pour le tour suivant"
  },
  State_3735_Name = {
    Text = "Les couches de \"poison\" de notre équipe sont réduites de moitié"
  },
  State_3738_Desc = {
    Text = "À la fin du tour, fusion d'embryon +15%, si un embryon est en main, récupère [Arg1] PV"
  },
  State_3738_Name = {
    Text = "Registre de la Peste"
  },
  State_3739_Name = {
    Text = "Effet de la forme organique de l'accessoire"
  },
  State_3739_WeaponDesc = {
    Text = "Après avoir utilisé l'exaltation, les boucliers et les soins de l'équipement doublent pour ce tour"
  },
  State_3740_Name = {
    Text = "État@Compteur de critiques du démon sucré"
  },
  State_3741_Desc = {
    Text = "Au début du tour 3, ajoutez 1 carte \"Échos du Passé—Défaussez toutes les cartes, réinitialisez la Vie et le Bouclier actuels à l'état de la fin du tour précédent. Conservez, Épuisez.\" à votre main."
  },
  State_3742_Desc = {
    Text = "Après avoir joué, affaiblissez tous les ennemis pour [StateArg1] tours"
  },
  State_3742_Name = {
    Text = "<Rune_1:vulnérable>"
  },
  State_3743_Desc = {
    Text = "La 6e carte que tu joues a un effet double"
  },
  State_3743_Name = {
    Text = "Vin des étoiles des créations"
  },
  State_3744_Name = {
    Text = "Compteur du miroir rituel de Memphis des créations"
  },
  State_3747_Name = {
    Text = "Choisissez une carte de la pile de tirage à ajouter à votre main"
  },
  State_3748_Name = {
    Text = "Le taux critique des dégâts infligés augmente de [DescArg1] % et les dégâts critiques augmentent de [DescArg2] %"
  },
  State_3750_Name = {
    Text = "Taux critique temporaire +[DescArg1]%. Dans ce combat, les dégâts de base de \"décapitation\" et \"mille mirages\" augmentent de 5%"
  },
  State_3751_Name = {
    Text = "Obtenez [StateArg1] points de <PowerIconKeywords:force>"
  },
  State_3752_Name = {
    Text = "Gagnez <Posse:[DescArg1]> points de s-énergie. Gagnez <Block:[Block:StateArg1]> points de bouclier"
  },
  State_3753_Desc = {
    Text = "Les cartes ne vont pas dans la pile de défausse pendant la phase de défausse, elles restent en main"
  },
  State_3753_Name = {
    Text = "<RetainIconKeywords:Conservation>"
  },
  State_3753_WeaponDesc = {
    Text = "Les cartes ne vont pas dans la pile de défausse pendant la phase de défausse, elles restent en main"
  },
  State_3754_Desc = {
    Text = "Lors de la causation de dégâts actifs, augmenter les dégâts de tentacule de [Arg1] dans ce tour, jusqu'à 3 fois. Lorsqu'elle est pleine, générer 1 tentacule, et enlever après la fin du tour"
  },
  State_3755_Desc = {
    Text = "Équipe Unique : le bouclier causé par le porteur est augmenté de <WeaponEffect_Num:[StateArg1]%>, et la récupération de vie est augmentée de <WeaponEffect_Num:[StateArg1] %>. À la fin des tours impairs, le taux critique du porteur augmente de <WeaponEffect_Num:[StateArg2]%>, et il obtient <WeaponEffect_Num:[StateArg3]> points de fureur ; à la fin des tours pairs, les dégâts critiques du porteur augmentent de <WeaponEffect_Num:[StateArg2]%>, et il obtient <WeaponEffect_Num:[StateArg4]> fragments de clé. Si le royaume actuel est « Chair », la limite d'accumulation de la forge écarlate est augmentée de <WeaponEffect_Num:[StateArg5]%>."
  },
  State_3755_WeaponDesc = {
    Text = "Le bouclier causé par l'équipé est augmenté de <WeaponEffect_Num:[StateArg1]%>, et la régénération de vie est augmentée de <WeaponEffect_Num:[StateArg1] %>. À la fin des tours impairs, le taux critique de l'équipement augmente de +<WeaponEffect_Num:[StateArg2]%>, et il obtient <WeaponEffect_Num:[StateArg3]> points de fureur ; à la fin des tours pairs, les dégâts critiques de l'équipement augmentent de +<WeaponEffect_Num:[StateArg2]%>, et il obtient <WeaponEffect_Num:[StateArg4]> points d'énergie clé en argent. Si le royaume actuel est « Chair », cela augmente la limite d'accumulation de la Forge Écarlate de <WeaponEffect_Num:[StateArg5]%>."
  },
  State_3757_Desc = {
    Text = "Chaque fois que notre équipe joue une carte, elle gagne [StateArg1] couches de bouclier. Dure 1 tour"
  },
  State_3757_Name = {
    Text = "Plumes volantes"
  },
  State_3757_WeaponDesc = {
    Text = "Chaque fois que notre équipe joue une carte, elle gagne [StateArg1] couches de bouclier. Dure 1 tour"
  },
  State_3759_Name = {
    Text = "Armement mécanique 1"
  },
  State_3760_Desc = {
    Text = "Si vous avez au moins [StateArg1] le sigil noir, [exalter] perd [StateArg1] le sigil noir, vulnérable et affaibli tous les ennemis pendant 1 tour"
  },
  State_3760_Name = {
    Text = "Oiseau du rituel de malheur des créations"
  },
  State_3760_WeaponDesc = {
    Text = "Si vous avez au moins [StateArg1] le sigil noir, [exalter] perd [StateArg1] le sigil noir, vulnérable et affaibli tous les ennemis pendant 1 tour"
  },
  State_3761_Desc = {
    Text = "À chaque pioche d'une carte Chancelante, gagnez [Layer] points de force"
  },
  State_3761_Name = {
    Text = "Cérémonie de la lanterne"
  },
  State_3761_WeaponDesc = {
    Text = "À chaque pioche d'une carte Chancelante, gagnez [Layer] points de force"
  },
  State_3763_Desc = {
    Text = "À chaque fois que l'Intrus inflige des dégâts, les dégâts critiques augmentent de [StateArg3]% pour ce tour"
  },
  State_3763_Name = {
    Text = "Passage plié"
  },
  State_3763_WeaponDesc = {
    Text = "À chaque fois que l'Intrus inflige des dégâts, les dégâts critiques augmentent de [StateArg3]% pour ce tour"
  },
  State_3764_Name = {
    Text = "Armement mécanique 2"
  },
  State_3766_Name = {
    Text = ": Ajouter un multiplicateur de force cramoisie"
  },
  State_3767_Desc = {
    Text = "Au début du tour, inflige [Arg1] points de dégâts à un ennemi aléatoire. Après avoir joué 7 fois « frapper » dans ce combat, les dégâts deviennent [Arg2]"
  },
  State_3767_Name = {
    Text = "Puzzle antique"
  },
  State_3768_Desc = {
    Text = "Les dégâts actifs reçus sont toujours critiques, suppression à la fin du tour"
  },
  State_3768_Name = {Text = "Faille"},
  State_3768_WeaponDesc = {
    Text = "Les dégâts actifs reçus sont toujours critiques, suppression à la fin du tour"
  },
  State_3770_Name = {
    Text = "Compteur de la relique d'Arcana de la création"
  },
  State_3771_Desc = {
    Text = "Au début de la bataille, obtenez 3 points de calcul"
  },
  State_3772_Desc = {
    Text = "Chaque fois que la Lame de vengeance inflige des dégâts, cela augmente la puissance temporaire équivalente aux dégâts de tentacule actuels"
  },
  State_3772_Name = {
    Text = "Vengeance préparée"
  },
  State_3773_Desc = {
    Text = "En fin de tour, reçoit des <FixedDamage:DGT Purs> égaux au nombre de charges."
  },
  State_3773_Name = {
    Text = "<IntoxicationIconKeywords:Poison>"
  },
  State_3773_WeaponDesc = {
    Text = "Subir des dégâts au début du tour"
  },
  State_3774_Desc = {
    Text = "Chaque fois que vous libérez l'exaltation, obtenez une <Contamination toxique> pouvant infliger [Arg1] points de poison. À la fin du tour, si vous avez 3 <Contamination toxique> en main, vous pouvez les combiner pour créer une <Toxicité active> qui déclenche le poison."
  },
  State_3776_Desc = {
    Text = "Chaque fois que vous subissez des dégâts actifs, accumulez une couche de « vigilance ». Lorsque la vigilance atteint 3 couches, reculez"
  },
  State_3776_Name = {
    Text = "Poupée timide"
  },
  State_3776_WeaponDesc = {
    Text = "Chaque fois que vous subissez des dégâts actifs, accumulez une couche de « vigilance ». Lorsque la vigilance atteint 3 couches, reculez"
  },
  State_3777_Desc = {
    Text = "Après avoir joué, l'éveillé gagne [StateArg1] folie"
  },
  State_3777_Name = {
    Text = "<Rune_5_High:Furie avancée>"
  },
  State_3777_WeaponDesc = {
    Text = "Après avoir joué, l'éveillé gagne [StateArg1] folie"
  },
  State_3778_Desc = {
    Text = "Les dégâts infligés aux ennemis en état négatif augmentent de 25%, et le tueur gagne 20 folie"
  },
  State_3779_Desc = {
    Text = "Limite de tentacules -2. À la fin du tour, tous les tentacules attaquent une fois de plus"
  },
  State_3779_Name = {
    Text = "Bras sacré de la douleur des créations"
  },
  State_3779_WeaponDesc = {
    Text = "Limite de tentacules -2. À la fin du tour, tous les tentacules attaquent une fois de plus"
  },
  State_3781_Desc = {
    Text = "Au début du tour, appliquez la \"Malédiction de Stase\" aux 2 cartes du dessus du deck"
  },
  State_3781_Name = {
    Text = "« Œil maudit des abysses »"
  },
  State_3781_WeaponDesc = {
    Text = "Au début du tour, appliquez la \"Malédiction de Stase\" aux 2 cartes du dessus du deck"
  },
  State_3782_Desc = {
    Text = "Unique à l'équipe : Au début de l'exploration, ajoute une carte \"Défense\" de l'équipé au deck. Le bouclier de \"Défense\" de l'équipé augmente de <WeaponEffect_Num:[StateArg1]%>"
  },
  State_3782_WeaponDesc = {
    Text = "Au début de l'exploration, ajoutez une carte \"Défense\" de l'équipé au deck, le bouclier de \"Défense\" de l'équipé augmente de <WeaponEffect_Num:[StateArg1]%>"
  },
  State_3783_Desc = {
    Text = "L'unique de l'équipe : Les dégâts de base de l'éclat de folie du porteur sont augmentés de <WeaponEffect_Num:[StateArg1]%>, et le bouclier et la récupération de vie sont augmentés de <WeaponEffect_Num:[StateArg2]%>"
  },
  State_3783_WeaponDesc = {
    Text = "Les dégâts de base de l'exaltation de l'équipement augmentent de <WeaponEffect_Num:[StateArg1] %>, les gains de bouclier et de vie augmentent de <WeaponEffect_Num:[StateArg2] %>"
  },
  State_3784_Desc = {
    Text = "L'unique de l'équipe : Les dégâts de base des cartes de commandement de l'équipement augmentent de <WeaponEffect_Num:[StateArg1]%>, le bouclier et la vie récupérée augmentent de <WeaponEffect_Num:[StateArg2]%>"
  },
  State_3784_WeaponDesc = {
    Text = "Les dégâts de base de la carte de commande de l'équipement augmentent de <WeaponEffect_Num:[StateArg1]%>, et les boucliers et les soins augmentent de <WeaponEffect_Num:[StateArg2]%"
  },
  State_3786_Desc = {
    Text = "Tu es ciblé ! Après activation, tous les monstres gagnent [StateArg1] points de force temporaire, retire la marque de plongée de cette commande"
  },
  State_3786_Name = {
    Text = "<CardKeyWord:Marque de la plongée>"
  },
  State_3786_WeaponDesc = {
    Text = "Après avoir joué la carte, le plongeur obtient [StateArg1] points de force temporaire"
  },
  State_3787_Desc = {
    Text = "L'unique de l'équipe : après que l'équipement a libéré l'exalter, tous les alliés reçoivent <WeaponEffect_Num:[StateArg1]> de folie"
  },
  State_3787_WeaponDesc = {
    Text = "Après que l'attaquant libère l'exalte, tous les alliés reçoivent <WeaponEffect_Num:[StateArg1]> folie"
  },
  State_3788_Desc = {
    Text = "Équipe Unique : Au début de l'exploration, ajoutez une carte «Attaque» de l'équipé au deck, les dégâts de base de «Attaque» de l'équipé augmentent de <WeaponEffect_Num:[StateArg1]%>."
  },
  State_3788_WeaponDesc = {
    Text = "Au début de l'exploration, ajoutez une carte \"Frappe\" de l'équipé au deck, les dégâts de base de \"Frappe\" de l'équipé augmentent de <WeaponEffect_Num:[StateArg1]%>"
  },
  State_3790_Desc = {
    Text = "État@comptage de matière indéterminée"
  },
  State_3790_Name = {
    Text = "État@comptage de matière indéterminée"
  },
  State_3790_WeaponDesc = {
    Text = "État@comptage de matière indéterminée"
  },
  State_3791_Desc = {
    Text = "Chaque fois que vous infligez des dégâts, gagnez [Arg1] points de bouclier, pouvant être accumulés un maximum de 5 fois par tour. Lorsque le maximum est atteint, ajoutez une carte « inspiration » à votre main"
  },
  State_3792_Desc = {
    Text = "Ne subit plus l'effet de pétrification"
  },
  State_3792_Name = {
    Text = "Résistance à la pétrification"
  },
  State_3792_WeaponDesc = {
    Text = "Ne subit plus de pétrification, subit trois fois plus de dégâts"
  },
  State_3793_Desc = {
    Text = "Les dégâts critiques augmentent de [Layer] % dans ce niveau"
  },
  State_3793_Name = {
    Text = "Dommages critiques permanents"
  },
  State_3793_WeaponDesc = {
    Text = "Les dégâts critiques augmentent de [Layer] % dans ce niveau"
  },
  State_3794_Desc = {
    Text = "Augmentation des dégâts, bouclier et guérison de l'équipementeur de [StateArg1]%. (temporaire)"
  },
  State_3794_Name = {
    Text = "État@Dégâts critiques de l'épée longue prototype"
  },
  State_3796_Desc = {
    Text = "Pour chaque 20% de vie perdue, tous les réveilleurs gagnent 10 de folie, et la mort augmente les dégâts de tentacule"
  },
  State_3796_Name = {
    Text = "Particules d'argent précipitées"
  },
  State_3796_WeaponDesc = {
    Text = "Pour chaque 20% de vie perdue, tous les réveilleurs gagnent 10 de folie, et la mort augmente les dégâts de tentacule"
  },
  State_3797_Desc = {
    Text = "Chaque fois que vous subissez des dégâts, obtenez [StateArg1] points de pouvoir temporaire qui sont retirés au début du tour"
  },
  State_3797_Name = {
    Text = "La colère de la horde de rats !"
  },
  State_37980_Desc = {
    Text = "Dans ce combat, la maîtrise du royaume augmente de [Layer]"
  },
  State_37980_Name = {
    Text = "Maîtrise de Royaume"
  },
  State_3798_Desc = {
    Text = "Restaurez la vie après avoir infligé des dégâts réels"
  },
  State_3798_Name = {
    Text = "Lame vampire"
  },
  State_3798_WeaponDesc = {
    Text = "Restaurez la vie après avoir infligé des dégâts réels"
  },
  State_3799_Desc = {
    Text = "Pour chaque réveilleur professionnel de type [caro] dans l'équipe, la santé max (incomplète), la défense et l'attaque de toute l'équipe augmentent de 50%"
  },
  State_3799_Name = {
    Text = "Bonus de chair et de sang"
  },
  State_3799_WeaponDesc = {
    Text = "Pour chaque réveilleur professionnel de type [caro] dans l'équipe, la santé max (incomplète), la défense et l'attaque de toute l'équipe augmentent de 50%"
  },
  State_3800_Desc = {
    Text = "Inflige des dégâts à tous les ennemis. <CardKeyWord:Force> a un effet multiplié sur ces dégâts"
  },
  State_3800_Name = {
    Text = "<CardKeyWord: Force de la grande épée>"
  },
  State_3801_Desc = {
    Text = "Ajoutez [StateArg1] couches de saignement en infligeant des dégâts non bloqués"
  },
  State_3801_Name = {Text = "Saigner"},
  State_3802_Desc = {
    Text = ": Lorsqu'elle est en main, chaque commande utilisée devient une copie avec une capacité de 0"
  },
  State_3802_Name = {
    Text = "<CardKeyWord:Enfant sacré>"
  },
  State_3802_WeaponDesc = {
    Text = ": Lorsqu'elle est en main, chaque carte utilisée devient une copie avec une capacité de 0"
  },
  State_3803_Desc = {
    Text = "Au début de la bataille, les cartes de pouvoir ayant un coût d'1 point dans ce combat voient leurs dégâts, bouclier et soins augmentés de [Arg1] points"
  },
  State_3804_Desc = {
    Text = "Compteur de trident altéré"
  },
  State_3804_Name = {
    Text = "Compteur de trident altéré"
  },
  State_3804_WeaponDesc = {
    Text = "Compteur de trident altéré"
  },
  State_3807_Name = {
    Text = "Rêve médicinal de l'accessoire"
  },
  State_3807_WeaponDesc = {
    Text = "Après le début du combat, une suite de cartes du porteur est mélangée dans la pile de pige"
  },
  State_3808_Desc = {
    Text = "État@Changement de vie actuelle générique"
  },
  State_3808_Name = {
    Text = "État@Changement de vie actuelle générique"
  },
  State_3808_WeaponDesc = {
    Text = "État@Changement de vie actuelle générique"
  },
  State_3810_Desc = {
    Text = "Après la mort, la force des autres alliés augmente"
  },
  State_3810_Name = {
    Text = "Mort-vivant"
  },
  State_3811_Desc = {
    Text = "État@PrologueRéinitialisationDeck0_1_4_1"
  },
  State_3811_Name = {
    Text = "État@PrologueRéinitialisationDeck0_1_4_1"
  },
  State_3811_WeaponDesc = {
    Text = "État@PrologueRéinitialisationDeck0_1_4_1"
  },
  State_3813_Name = {
    Text = "Immunité à la faiblesse"
  },
  State_3815_Desc = {
    Text = "À la fin du tour, tous les réveilleurs perdent [Layer] points d'aleimus."
  },
  State_3815_Name = {
    Text = "<EnergyColour:Vide>"
  },
  State_3815_WeaponDesc = {
    Text = "Réduire la folie de [Layer] %"
  },
  State_3817_Desc = {
    Text = "Au début du tour, infligez [DescArg1] points d'épuisement à l'adversaire"
  },
  State_3817_Name = {Text = "Évasion"},
  State_3817_WeaponDesc = {
    Text = "Au début du tour, votre équipe gagne [DescArg1*Layer*0.01] niveaux d'épuisement"
  },
  State_3818_Name = {
    Text = "État@connaisseur illuminer 1"
  },
  State_3819_Name = {
    Text = "Briseur de chaînes, illumination 1"
  },
  State_3819_WeaponDesc = {
    Text = "Imitation de l'Ancien"
  },
  State_3821_Desc = {
    Text = "Au début du tour, gagnez un bouclier égal à la moitié des PV perdus au tour précédent"
  },
  State_3821_Name = {
    Text = "Douleur et Plaisir"
  },
  State_3821_WeaponDesc = {
    Text = "Au début du prochain tour, obtenez un bouclier équivalent à la vie perdue au tour précédent"
  },
  State_3824_Desc = {
    Text = "Équipe Unique : Les dégâts de base de l'exaltation du porteur augmentent de [StateArg1] %. Au début de l'exploration, le porteur entre dans l'état de personnalité de l'érudit. Après avoir libéré l'exaltation, le porteur alterne entre la personnalité de l'érudit et celle du clown. \nPersonnalité de l'érudit : À la fin du tour, le porteur obtient <WeaponEffect_Num:[StateArg2]> points de folie. \nPersonnalité du clown : À la fin du tour, le taux critique et les dégâts critiques du porteur augmentent de <WeaponEffect_Num:+[StateArg3] %>."
  },
  State_3824_WeaponDesc = {
    Text = "Les dégâts de base de l'exaltation du porteur augmentent de [StateArg1] %. Au début de l'exploration, le porteur entre dans l'état de personnalité de l'érudit. Après avoir libéré l'exaltation, le porteur alterne entre la personnalité de l'érudit et celle du clown. \nPersonnalité de l'érudit : à la fin du tour, le porteur gagne <WeaponEffect_Num:[StateArg2]> points de folie. \nPersonnalité du clown : à la fin du tour, le taux critique et les dégâts critiques du porteur augmentent de <WeaponEffect_Num:+[StateArg3] %>."
  },
  State_3825_Desc = {
    Text = "Lors de la réception de Dégâts Directs, inflige des <FixedDamage:DGT Purs> à la source des dégâts égaux au nombre de charges."
  },
  State_3825_Name = {
    Text = "<RetaliateIconKeywords:comptoir>"
  },
  State_3825_WeaponDesc = {
    Text = "À chaque fois que des Dégâts Directs sont reçus, inflige des <FixedDamage:DGT Purs> à l'attaquant."
  },
  State_3826_Name = {
    Text = "État@CléD'ArgentDesRêves:CompteurExplosion"
  },
  State_3827_Desc = {
    Text = "L'unique de l'équipe : La récupération de vie du porteur est augmentée de <WeaponEffect_Num:[StateArg1]%>. Après avoir libéré l'éclat de folie, au début du tour suivant, il récupère <WeaponEffect_Num:[StateArg2]%> de vie perdue"
  },
  State_3827_WeaponDesc = {
    Text = "La régénération de vie de l'équipement augmente de <WeaponEffect_Num:[StateArg1] %>. Après avoir libéré l'exaltation, au début du tour suivant, régénérez <WeaponEffect_Num:[DescArg1] %> de vie perdue"
  },
  State_3830_Name = {
    Text = "Prend effet 1 fois supplémentaire"
  },
  State_3831_Name = {
    Text = "Racine Inverse de la Création"
  },
  State_3834_Desc = {
    Text = "L'empoisonnement causé par l'araignée du labyrinthe est doublé"
  },
  State_3834_Name = {
    Text = "Voyage égaré"
  },
  State_3835_Desc = {
    Text = "Ce tour, dégâts critiques augmentés de [Layer] %"
  },
  State_3835_Name = {
    Text = "Dommages critiques temporaires"
  },
  State_3835_WeaponDesc = {
    Text = "Ce tour, dégâts critiques augmentés de [Layer] %"
  },
  State_3836_Desc = {Text = "Test 123"},
  State_3836_Name = {Text = "Test 123"},
  State_3837_Desc = {
    Text = "Équipe Unique : La Fureur générée par le Porteur +<WeaponEffect_Num:[StateArg1]%>, et le <IntoxicationIconKeywords:Poison> infligé par le Porteur +<WeaponEffect_Num:[StateArg2]%>.\nAprès que le Porteur inflige des Dégâts Directs, tous les Éveilleurs gagnent des Dommages critiques temporaires égaux à <WeaponEffect_Num:[StateArg3]%> des Dégâts Critiques de base du Porteur.\nSi le Royaume inclut Aequor, la Limite des tentacules +1 et un Tentacule apparaît au début du combat."
  },
  State_3837_WeaponDesc = {
    Text = "La Fureur générée par le Porteur +<WeaponEffect_Num:[StateArg1]%>, et le <IntoxicationIconKeywords:Poison> infligé par le Porteur +<WeaponEffect_Num:[StateArg2]%>.\nAprès que le Porteur inflige des Dégâts Directs, les Dommages critiques temporaires de tous les Éveilleurs +<WeaponEffect_Num:[DescArg1]%>.\nSi le Royaume inclut Aequor, la Limite des tentacules +1 et un Tentacule apparaît au début du combat."
  },
  State_3839_Desc = {
    Text = "Au début de la bataille, pour chaque carte de symptôme dans la pioche, gagnez [Arg1] points de pouvoir. Toutes vos cartes de symptôme obtiennent l'illusion"
  },
  State_3840_Desc = {
    Text = "Lorsque la vie diminue, on gagne [StateArg1] d'alerte"
  },
  State_3840_Name = {Text = "Vigilance"},
  State_3842_Desc = {
    Text = "Tous les Dégâts Directs et Dégâts des tentacules infligés -[DescArg1]%."
  },
  State_3842_Name = {Text = "Faiblesse"},
  State_3842_WeaponDesc = {
    Text = "Tous les dégâts infligés sont réduits de [DescArg1] %"
  },
  State_3843_Desc = {
    Text = "Chaque action ajoute [Layer] saignement"
  },
  State_3843_Name = {
    Text = "Blessure grave"
  },
  State_3843_WeaponDesc = {
    Text = "Chaque action ajoute [Layer] de saignement, la guérison peut supprimer l'effet de saignement"
  },
  State_3844_Desc = {
    Text = "Tous les dégâts du saut de baleine +1"
  },
  State_3844_Name = {
    Text = "Désir de combattre insatiable"
  },
  State_3844_WeaponDesc = {
    Text = "Tous les dégâts du saut de baleine +1"
  },
  State_3845_Desc = {
    Text = "Puissance de calcul des cartes réduite"
  },
  State_3845_Name = {
    Text = "Puissance de calcul des cartes réduite"
  },
  State_3845_WeaponDesc = {
    Text = "Puissance de calcul des cartes réduite"
  },
  State_3846_Name = {
    Text = "Impression de jade des créations"
  },
  State_3848_Desc = {
    Text = "Dans ce combat, l'exaltation d'un réveil aléatoire est scellée et ne peut pas être utilisée"
  },
  State_3848_Name = {Text = "Scellé"},
  State_3850_Desc = {
    Text = "Cette fois que vous jouez la [StateArg1]e carte, augmentez les dégâts de tentacule de [StateArg2], permettant à toutes les attaques de tentacule de frapper 1 fois"
  },
  State_3850_Name = {
    Text = "Forket d'aliénation"
  },
  State_3850_WeaponDesc = {
    Text = "Cette fois que vous jouez la [StateArg1]e carte, augmentez les dégâts de tentacule de [StateArg2], permettant à toutes les attaques de tentacule de frapper 1 fois"
  },
  State_3851_Name = {
    Text = "Chat de théâtre de l'accessoire"
  },
  State_3851_WeaponDesc = {
    Text = "Tous les dégâts infligés augmentent, la valeur d'augmentation est égale à 10 % de la vie maximale du porteur"
  },
  State_3852_Desc = {
    Text = "Augmentez le nombre de coups de morsure [Layer]"
  },
  State_3852_Name = {
    Text = "Morsure croissante"
  },
  State_3852_WeaponDesc = {
    Text = "Augmentez le nombre de coups de morsure [Layer]"
  },
  State_3853_Desc = {
    Text = "Au début du tour, se transformer aléatoirement en une copie d'une carte de commandement dans la pile de défausse, avec un coût d'arithmetica fixe de 3, et redevenir la forme originale à la fin du tour"
  },
  State_3853_Name = {
    Text = "<CardKeyWord:Délire>"
  },
  State_3853_WeaponDesc = {
    Text = "Les cartes ne vont pas dans la pile de défausse pendant la phase de défausse, elles restent en main"
  },
  State_3854_Desc = {
    Text = "Pioche 2 cartes, cela attire l'attention du Chasseur de Crânes"
  },
  State_3854_Name = {
    Text = "<CardKeyWord:Chassé>"
  },
  State_3855_Name = {Text = "Force"},
  State_3856_Desc = {
    Text = "État@PrologueRéinitialisationDeck0_1_3_1"
  },
  State_3856_Name = {
    Text = "État@PrologueRéinitialisationDeck0_1_3_1"
  },
  State_3856_WeaponDesc = {
    Text = "État@PrologueRéinitialisationDeck0_1_3_1"
  },
  State_3859_Desc = {
    Text = "Le souffle de fertilité double la folie"
  },
  State_3859_Name = {
    Text = "Rencontrer sa mère"
  },
  State_3859_WeaponDesc = {
    Text = "Le souffle de fertilité double la folie"
  },
  State_3860_Desc = {
    Text = "Augmentation des dégâts, bouclier et guérison de l'équipementeur de [StateArg1]%. (temporaire)"
  },
  State_3860_Name = {
    Text = "État@Chance du couteau prototype"
  },
  State_3862_Name = {
    Text = "État @niveau 2_15 bataille 4 bulle 1"
  },
  State_3863_Desc = {
    Text = "Après avoir libéré 3 exaltations, la consommation des cartes de toute votre main en arithmétique est réduite de 1"
  },
  State_3866_Desc = {
    Text = "Pendant ce tour, limite de cartes en main +[Layer]"
  },
  State_3866_Name = {
    Text = "Limite de cartes en main augmentée"
  },
  State_3867_Name = {
    Text = "Compteur de classe hyperdimensionnelle"
  },
  State_3868_Desc = {
    Text = "Ce tour, bouclier augmenté de [Layer]"
  },
  State_3868_Name = {
    Text = "Précaution temporaire"
  },
  State_3868_WeaponDesc = {
    Text = "Ce tour, bouclier augmenté de [Layer]"
  },
  State_3872_Desc = {
    Text = "Les dégâts reçus annulent la force temporaire"
  },
  State_3872_Name = {Text = "Faille"},
  State_38730_Desc = {
    Text = "Au début du tour, [DescArg1]% de chance de gagner 1 couche de tentacules, au-delà de 100%, plusieurs couches possibles"
  },
  State_38730_Name = {
    Text = "Ligne de retour à la mer"
  },
  State_38735_Desc = {
    Text = "Dégâts Directs infligés –[StateArg1]%, le nombre d'attaques est doublé, et dure [Layer] <plural value=\"[Layer]\" singular=\"tour\" plural=\"tours\">."
  },
  State_38735_Name = {Text = "Delire"},
  State_38738_Desc = {
    Text = "Limite de 10 niveaux, transférable à la prochaine bataille"
  },
  State_38738_Name = {
    Text = "Appât Onirique"
  },
  State_3873_Desc = {
    Text = "Dans ce combat, la maîtrise du royaume augmente de [Layer] points"
  },
  State_3873_Name = {
    Text = "Maîtrise de Royaume"
  },
  State_3874_Name = {
    Text = "État@Restauration des cartes du carillon"
  },
  State_3876_Desc = {
    Text = "Chaque tour pair réduit la force de notre équipe"
  },
  State_3876_Name = {
    Text = "« Trou du Rêve de Mort »"
  },
  State_3878_Desc = {
    Text = "Pour chaque 2 points de vie perdus, gagne [Layer] points de bouclier au début du prochain tour"
  },
  State_3878_Name = {
    Text = "Douleur et Plaisir"
  },
  State_3878_WeaponDesc = {
    Text = "Au début du prochain tour, obtenez un bouclier équivalent à la vie perdue au tour précédent"
  },
  State_3879_Desc = {
    Text = "Lors de la collecte, augmenter la santé max de [Arg1] points. Si la santé au moment de la collecte est inférieure à 25%, l'augmentation de la santé max devient [Arg2] points"
  },
  State_3881_Desc = {
    Text = "État@MonstreGeorgeMangeStatue"
  },
  State_3881_Name = {
    Text = "État@MonstreGeorgeMangeStatue"
  },
  State_3881_WeaponDesc = {
    Text = "État@MonstreGeorgeMangeStatue"
  },
  State_3882_Desc = {
    Text = "Cet éveilleur n'est pas encore éveillé... Il s'éveillera lorsqu'il sera sur le point d'être abattu, restaurera sa vie et commencera à se battre sous sa véritable forme"
  },
  State_3882_Name = {
    Text = "Non Réveillé"
  },
  State_3883_Desc = {
    Text = "Le taux critique augmente de [Layer]% dans ce niveau"
  },
  State_3883_Name = {
    Text = "Taux de coup critique permanent"
  },
  State_3883_WeaponDesc = {
    Text = "Le taux critique augmente de [Layer]% dans ce niveau"
  },
  State_3884_Desc = {
    Text = "Générez 1 degré de fusion d'embryon supplémentaire par tour. Tous vos effets de dévoration deviennent une dévoration illimitée"
  },
  State_3884_Name = {
    Text = "Cordon ombilical rampant des créations"
  },
  State_3884_WeaponDesc = {
    Text = "Générez 1 degré de fusion d'embryon supplémentaire par tour. Tous vos effets de dévoration deviennent une dévoration illimitée"
  },
  State_3888_Desc = {
    Text = "Incapable de libérer l'exaltation, enlève 1 couche à la fin du tour"
  },
  State_3888_Name = {
    Text = "<CardKeyWord:Scellement>"
  },
  State_3888_WeaponDesc = {
    Text = "Les explosions de folie de tous les réveilleurs ne peuvent pas être utilisées"
  },
  State_3890_Name = {
    Text = "Pioche + [DescArg1] carte(s) de la défausse"
  },
  State_3893_Desc = {
    Text = "Obtenez [Arg1] points de bouclier en infligeant des dégâts. En soignant, gagnez [Arg2] points de force temporaire"
  },
  State_3893_Name = {
    Text = "Notre maison"
  },
  State_3894_Desc = {
    Text = "Transformez les cartes en main en pierres avant la phase de défausse"
  },
  State_3894_Name = {Text = "Pétrifier"},
  State_3894_WeaponDesc = {
    Text = "Transformez les cartes en main en pierres avant la phase de défausse"
  },
  State_3895_Desc = {
    Text = "Le taux critique augmente de [Layer] % pendant ce tour"
  },
  State_3895_Name = {
    Text = "Taux de coup critique temporaire"
  },
  State_3895_WeaponDesc = {
    Text = "Le taux critique augmente de [Layer] % pendant ce tour"
  },
  State_3898_Desc = {
    Text = "Au début du prochain tour, obtenez [Layer] points de bouclier"
  },
  State_3898_Name = {
    Text = "Bouclier de douleur et plaisir"
  },
  State_3900_Name = {
    Text = "Les cartes sont scellées, ne peuvent pas être jouées, et sont déverrouillées lorsqu'elles sont défaussées"
  },
  State_3901_Name = {
    Text = "Compteur du sceptre du prêtre des créations"
  },
  State_3902_Desc = {
    Text = "Ce tour, dégâts actifs réduits de [Layer]"
  },
  State_3902_Name = {
    Text = "Force réduite"
  },
  State_3902_WeaponDesc = {
    Text = "Ce tour, dégâts infligés réduits de [Layer]"
  },
  State_3904_Desc = {
    Text = "Pour chaque point de vie perdu, retirez une couche. À zéro couche, gagnez un bouclier de [StateArg1] et regagnez [StateArg2] couches de barrière de sang"
  },
  State_3904_Name = {
    Text = "Éveil - Barrière de Sang"
  },
  State_3905_Desc = {
    Text = "Chaque fois que des Dégâts Directs sont subis, inflige [Layer] <FixedDamage:DGT Purs> à la source des dégâts."
  },
  State_3905_Name = {
    Text = "Contre-attaque"
  },
  State_3905_WeaponDesc = {
    Text = "Chaque fois que des Dégâts Directs sont subis, inflige [Layer] <FixedDamage:DGT Purs> à l'attaquant."
  },
  State_3906_Name = {
    Text = "Cœur d'argent résiduel"
  },
  State_3907_Name = {
    Text = "Cœur d'argent résiduel"
  },
  State_3908_Desc = {
    Text = "Quand le cerveau dans un bocal applique une récupération, tirez [Arg2] cartes"
  },
  State_3908_Name = {
    Text = "Dichotomie du Réel et de l'Illusoire"
  },
  State_3908_WeaponDesc = {
    Text = "Quand le cerveau dans un bocal applique une récupération, tirez [Arg2] cartes"
  },
  State_3909_Name = {
    Text = "Cœur d'argent résiduel"
  },
  State_3910_Name = {
    Text = "Cœur d'argent résiduel"
  },
  State_3911_Name = {
    Text = "Cœur d'argent résiduel"
  },
  State_3912_Name = {
    Text = "Cœur d'argent résiduel"
  },
  State_3913_Desc = {
    Text = "Équipe unique : La génération de boucliers du porteur +<WeaponEffect_Num:[StateArg1]%>. Au début du tour, conservez <WeaponEffect_Num:[StateArg2]%> du bouclier restant, jusqu'à <WeaponEffect_Num:[StateArg3]%> de la vie maximale."
  },
  State_3913_WeaponDesc = {
    Text = "La génération de boucliers du porteur +<WeaponEffect_Num:[StateArg1]%>. Au début du tour, conservez <WeaponEffect_Num:[StateArg2]%> du bouclier restant, jusqu'à <WeaponEffect_Num:[StateArg3]%> des PV max."
  },
  State_3914_Desc = {
    Text = "Après avoir libéré la deuxième exultation par tour, tous les réveilleurs obtiennent 10 points de folie. Après avoir libéré la troisième exultation par tour, la recharge de folie de tous les réveilleurs est réinitialisée, et ils obtiennent 10 points de folie"
  },
  State_3915_Name = {
    Text = "Cœur d'argent résiduel"
  },
  State_3916_Name = {
    Text = "Cœur d'argent résiduel"
  },
  State_3917_Desc = {
    Text = "Force temporaire au prochain tour"
  },
  State_3917_Name = {Text = "Charge"},
  State_3918_Desc = {
    Text = "Au début de chaque tour, gagnez un état de doublement des dégâts reçus"
  },
  State_3918_Name = {Text = "Fierté"},
  State_3918_WeaponDesc = {
    Text = "Au début de chaque tour, gagnez un état de doublement des dégâts reçus"
  },
  State_3921_Desc = {
    Text = "Les cartes ne seront pas placées dans la pile de défausse pendant la phase de défausse de ce tour, mais resteront dans la main"
  },
  State_3921_Name = {
    Text = "<RetainIconKeywords:Conservation>"
  },
  State_3921_WeaponDesc = {
    Text = "Les cartes ne vont pas dans la pile de défausse pendant la phase de défausse, elles restent en main"
  },
  State_3923_Desc = {
    Text = "Puissance de calcul des cartes réduite"
  },
  State_3923_Name = {
    Text = "Réduction Permanente de la Puissance de Calcul des Cartes"
  },
  State_3923_WeaponDesc = {
    Text = "Puissance de calcul des cartes réduite"
  },
  State_3925_Name = {
    Text = "État@chapitre 4 résonance@début du tour de notre équipe calcul 2"
  },
  State_3926_Desc = {
    Text = "\"Le 'Festin des Morts Tordus' augmente les dégâts de [Layer].\""
  },
  State_3926_Name = {Text = "Distorsion"},
  State_3926_WeaponDesc = {
    Text = "Augmente les dégâts de \"Furie\""
  },
  State_3927_Desc = {
    Text = "Après avoir pioché \"Vide\", réduit de [Layer]% la folie gagnée par tous les éveillés ce tour"
  },
  State_3927_Name = {Text = "Vide"},
  State_3927_WeaponDesc = {
    Text = "Après avoir pioché \"Vide\", réduit de [Layer]% la folie gagnée par tous les éveillés ce tour"
  },
  State_3928_Desc = {
    Text = "Lorsque le doux démon inflige des dégâts, il reçoit une réaction [StateArg2]"
  },
  State_3928_Name = {
    Text = "Donner et recevoir"
  },
  State_3929_Desc = {
    Text = "La puissance et le bouclier obtenus sont réduits de 50%, une couche est retirée à la fin du tour"
  },
  State_3929_Name = {
    Text = "<CardKeyWord:Malédiction>"
  },
  State_3929_WeaponDesc = {
    Text = "Ce tour, immunité aux effets positifs"
  },
  State_3930_Name = {
    Text = "État@chapitre 4 résonance@début du tour de notre équipe calcul 1"
  },
  State_3931_Name = {
    Text = "État@Chant du sang et du sable écarlate"
  },
  State_3932_Desc = {
    Text = "Confère la rétention à la carte, chaque couche de malédiction de stagnation augmente le coût de la carte de 1, retire la malédiction après utilisation"
  },
  State_3932_Name = {
    Text = "Malédiction de stase ([Layer])"
  },
  State_3932_WeaponDesc = {
    Text = "Confère la rétention à la carte, chaque couche de malédiction de stagnation augmente le coût de la carte de 1, retire la malédiction après utilisation"
  },
  State_3933_Desc = {
    Text = "Augmente la défense de [Layer]"
  },
  State_3933_Name = {
    Text = "Défense temporaire augmentée"
  },
  State_3933_WeaponDesc = {
    Text = "Augmente la défense de [Layer]"
  },
  State_3934_Desc = {
    Text = "Tous les boucliers obtenus sont réduits de 50%"
  },
  State_3934_Name = {
    Text = "Fragilité de l'extinction"
  },
  State_3934_WeaponDesc = {
    Text = "Tous les boucliers obtenus sont réduits de 50%"
  },
  State_3935_Desc = {
    Text = "Chaque fois que notre équipe utilise une carte, elle gagne une couche de «Observation», et se paralyse à dix couches"
  },
  State_3935_Name = {
    Text = "Observation"
  },
  State_3936_Desc = {
    Text = "Augmentation des dégâts, bouclier et guérison de l'équipementeur de [StateArg1]%. (temporaire)"
  },
  State_3936_Name = {
    Text = "État@Domaine de l'épée longue prototype"
  },
  State_3937_Desc = {
    Text = "Lorsqu'elle applique une contre-attaque, la reine des épines obtient un bouclier égal à la moitié des dégâts infligés"
  },
  State_3937_Name = {
    Text = "Mur des morts-vivants"
  },
  State_3938_Name = {
    Text = "Générer une statue en cire"
  },
  State_3941_Desc = {
    Text = "Quand tu dévoreras l'embryon, il retournera de la pile de défausse à la main"
  },
  State_3941_Name = {
    Text = "Tourbillon pâle"
  },
  State_3941_WeaponDesc = {
    Text = "Quand tu dévoreras l'embryon, il retournera de la pile de défausse à la main"
  },
  State_3942_Name = {
    Text = "Ligne de retour d'ornement"
  },
  State_3942_WeaponDesc = {
    Text = "Après le début du combat, si la classe du porteur est profonde, l'attaque augmente de 25 %"
  },
  State_3943_Desc = {
    Text = "Cet éveilleur n'est pas encore éveillé... Il s'éveillera lorsqu'il sera sur le point d'être abattu, restaurera sa vie et commencera à se battre sous sa véritable forme"
  },
  State_3943_Name = {
    Text = "Non Réveillé"
  },
  State_3944_Desc = {
    Text = "Après la fin du tour, tous les réveilleurs obtiennent 5 folie. Pour chaque point d'arsenal restant, tous les réveilleurs reçoivent en plus 3 folie"
  },
  State_3945_Desc = {
    Text = "Tous les prix des créations réduits de 50 %"
  },
  State_39547_Desc = {
    Text = "Après le combat, obtenez 5 sigils noirs supplémentaires, cet effet est influencé par l'augmentation des chutes de sigils noirs. Après que Wanda joue une carte, gagnez 1 couche de rêve-guide, cet effet peut être déclenché jusqu'à 2 fois par tour. Il reste encore [DescArg1] fois"
  },
  State_39547_Name = {
    Text = "Fourrure et Vénus"
  },
  State_40483_Name = {
    Text = "Épée brisée et coulée"
  },
  State_40484_Desc = {
    Text = "Lorsque l'effet de saut est activé par une compétence de Wanda, si 5 niveaux sont présents, consommez les 5 niveaux et obtenez un effet supplémentaire. La limite maximale de <DreamGuide:rêve-guide> est de 10 niveaux et sera transférée au combat suivant."
  },
  State_40484_Name = {
    Text = "<PurpleKeyWord:Guide de Rêve>"
  },
  State_41337_Desc = {
    Text = "À la fin du tour, récupère [Layer] points de vie"
  },
  State_41337_Name = {
    Text = "Victoire de la rose-Rétablissement"
  },
  State_41340_Desc = {
    Text = "Équipe unique : le bouclier et le comptoir causés par l'équipement augmentent de <WeaponEffect_Num:[StateArg1]%>. Chaque fois que l'équipement subit une attaque, il y a <WeaponEffect_Num:[StateArg2]%> de chances que tous les réveilleurs reçoivent 1 point d'aliemus"
  },
  State_41340_WeaponDesc = {
    Text = "Équipe unique : le bouclier et le comptoir causés par l'équipement augmentent de <WeaponEffect_Num:[StateArg1]%>. Chaque fois que l'équipement subit une attaque, il y a <WeaponEffect_Num:[StateArg2]%> de chances que tous les réveilleurs reçoivent 1 point d'aliemus."
  },
  State_41342_Name = {
    Text = "Modifier l'effet __ \"Pour usage de développement uniquement\""
  },
  State_41344_Name = {
    Text = "Effet de transformation"
  },
  State_41360_Desc = {
    Text = "Consomme 5 niveaux <DreamGuide: Rêve guide>, Wanda reçoit <Energy:[StateArg1]> points de folie, et acquiert un <RetaliateIconKeywords: contre-attaque> temporaire équivalent à [StateArg2]% de <RetaliateIconKeywords: contre-attaque> permanent"
  },
  State_41360_Name = {
    Text = "Contre-attaque en sommeil profond"
  },
  State_41361_Desc = {
    Text = "Épuisez 10 charges d'<DreamGuide:Appât Onirique>, faisant entrer tous les ennemis dans l'état «Murmure» pendant 1 tour : Dégâts Directs infligés –[StateArg3]%, mais le nombre d'attaques est doublé."
  },
  State_41361_Name = {
    Text = "Échos de murmures"
  },
  State_43818_Desc = {
    Text = "Cet éveilleur n'est pas encore éveillé... Il s'éveillera lorsqu'il sera sur le point d'être abattu, restaurera sa vie et commencera à se battre sous sa véritable forme"
  },
  State_43818_Name = {
    Text = "Non Réveillé"
  },
  State_44398_Desc = {
    Text = "Après avoir joué une carte chaque tour, ajoutez une carte \"Défense\" de l'entité éveillée correspondante à votre main"
  },
  State_44484_Name = {
    Text = "Peut être utilisé 3 fois dans les combats de Chef"
  },
  State_44485_Name = {
    Text = "(Restant : [Layer])"
  },
  State_44491_Name = {
    Text = "Désactiver Effet __ \"Pour usage de développement uniquement\""
  },
  State_44562_Name = {
    Text = "Désactiver les effets"
  },
  State_44575_Desc = {
    Text = "Bouclier restant ce tour conservé pour le prochain tour"
  },
  State_44575_Name = {
    Text = "Bouclier conservé"
  },
  State_44653_Desc = {
    Text = "Au début de chaque tour, tous les réveilleurs gagnent 20 points de folie. La santé max est réduite de 50%"
  },
  State_44665_Desc = {
    Text = "Le taux critique de « frappe » de ce tour augmente de [Layer] %"
  },
  State_44665_Name = {
    Text = "Taux critique d'attaque"
  },
  State_44667_Desc = {
    Text = "\"Frappe\" gagne [DescArg1] Arithmetica. Si la posture actuelle est \"Surge\", aucun Arithmetica n'est gagné, mais 1 Tentacule est ordonné d'attaquer [DescArg2] fois."
  },
  State_44667_Name = {
    Text = "La tyrannie du géant"
  },
  State_44671_Desc = {
    Text = "Au début de chaque tour, tous les réveilleurs gagnent 25 points de folie. Lors de la collecte, la santé max devient 3 fois"
  },
  State_44672_Name = {
    Text = "Béni par la conscience des essaims"
  },
  State_44711_Desc = {
    Text = "Limite de création +5, nombre de rafraîchissements dans [Trace de fusion] +1. Après la fin de la bataille, obtenez 125 marques noires, lors de la prise, vous pouvez choisir jusqu'à 6 cartes de symptômes à supprimer."
  },
  State_44713_Desc = {
    Text = "Après le combat, obtenez 100 sigils noirs supplémentaires et 2 cartes de symptômes"
  },
  State_44730_Desc = {
    Text = "Au début du tour, accumuler <Heal:[Heal:StateArg1]> points de régénération de la fournaise cramoisie"
  },
  State_44730_Name = {
    Text = "Accorder le salut"
  },
  State_44731_Desc = {
    Text = "En consommant les souffrances. Épuisez tous les restes de Répondre de la Forge Écarlate, chaque point consommé augmente les Dommages infligés de 3 (9 lors d'un Combat de Chef). Chaque 1 % de PV Max de Forge Écarlate consommé augmente les Dégâts Finaux de [DescArg1] %."
  },
  State_44731_Name = {Text = "Exorcisme"},
  State_44732_Desc = {
    Text = "Au nom du sang. Après avoir causé des dégâts, perdez 10% de vos points de vie, accumulez un montant de récupération de la fournaise cramoisie équivalent à la vie perdue"
  },
  State_44732_Name = {
    Text = "Dévouement"
  },
  State_44739_Desc = {
    Text = "Après ramassage, perdez définitivement [Arg1] force. Chaque fois que vous infligez des dégâts, récupérez [Arg2] points de vie, jusqu'à 6 fois par tour"
  },
  State_44739_Name = {
    Text = "Culpabilité·Baiser de la lamproie"
  },
  State_44740_Name = {
    Text = "Béni par le baiser de la lamproie"
  },
  State_44741_Desc = {
    Text = "Après ramassage, perdez définitivement [Arg1] force. Chaque fois que vous infligez des dégâts, récupérez [Arg2] points de vie, jusqu'à 6 fois par tour"
  },
  State_44741_Name = {
    Text = "Culpabilité·Baiser de la lamproie"
  },
  State_44742_Desc = {
    Text = "Après ramassage, perdez définitivement [Arg1] force. Chaque fois que vous infligez des dégâts, récupérez [Arg2] points de vie, jusqu'à 6 fois par tour"
  },
  State_44742_Name = {
    Text = "Béni par le baiser de la lamproie"
  },
  State_44743_WeaponDesc = {
    Text = "Au début de la bataille, vous devenez fragile pendant 3 tours"
  },
  State_44744_WeaponDesc = {
    Text = "Au début de la bataille, vous devenez fragile pendant 3 tours"
  },
  State_44750_Desc = {
    Text = "Au début du tour, gagner [StateArg1] arithmetica"
  },
  State_44750_Name = {
    Text = "Bougie noire de la création 1"
  },
  State_44751_Desc = {
    Text = "Au début du tour, gagner [StateArg1] arithmetica"
  },
  State_44751_Name = {
    Text = "Bougie noire de la création 1"
  },
  State_44752_Desc = {
    Text = "Chaque fois que « Sophia » perd 1 point de vie, elle descend d'un niveau. Une fois le niveau à 0, l'intention est remplacée par « œil pour œil » et elle obtient un bouclier de [StateArg2]. La première activation restaurera tous les niveaux"
  },
  State_44752_Name = {
    Text = "Impulsion enfouie"
  },
  State_44762_Desc = {
    Text = "Lorsque vous jouez « défense », ajoutez 1 carte de blessure à la pile de pioche."
  },
  State_44762_Name = {Text = "Déchirer"},
  State_44763_Desc = {
    Text = "Les dégâts critiques de tous les éveillés sont réduits de moitié"
  },
  State_44763_Name = {
    Text = "<PurpleKeyWord:Cécité>"
  },
  State_44764_Desc = {
    Text = "Lorsque vous jouez « attaque », ajoutez 1 carte de blessure à la pile de défausse"
  },
  State_44764_Name = {Text = "Trauma"},
  State_44807_Desc = {
    Text = "Lorsque le premier est sur le point d'être vaincu, restaurez la vie et changez l'intention en \"jugement dans le miroir\", se renforçant. Lorsque le deuxième est sur le point d'être vaincu, restaurez la vie et changez l'intention en \"morsure de folie\", infligeant des dégâts exceptionnels"
  },
  State_44807_Name = {
    Text = "Carnage Enterré"
  },
  State_44819_Desc = {
    Text = "S'il n'y a pas de <ParcloseIconKeywords:barrière>, obtenez 1 niveau de <ParcloseIconKeywords:barrière> temporaire, sinon gagnez 10% de taux critique et de dégâts critiques"
  },
  State_44819_Name = {
    Text = "<CardKeyWord:Protection du Père céleste>"
  },
  State_44828_Desc = {
    Text = "Équipe Unique : En fin de tour, le Porteur gagne [StateArg1] Fureur. Lorsqu'il subit des Dégâts Directs ou des Dégâts des tentacules, il gagne un Bouclier égal à <WeaponEffect_Num:[StateArg2]%> des dégâts au début du prochain tour. Si le Royaume actuel est Caro, il gagne plutôt une Forge Écarlate égale à <WeaponEffect_Num:[StateArg2]%> des dégâts."
  },
  State_44828_WeaponDesc = {
    Text = "En fin de tour, le Porteur gagne <WeaponEffect_Num:[StateArg1]> Fureur. Lorsqu'il subit des Dégâts Directs ou des Dégâts des tentacules, il gagne un Bouclier égal à <WeaponEffect_Num:[Float:StateArg2]%> des dégâts au début du prochain tour. Si le Royaume actuel est Caro, il gagne plutôt une Forge Écarlate égale à <WeaponEffect_Num:[Float:StateArg2]%> des dégâts."
  },
  State_44889_Name = {
    Text = "État@BOSS chien à visage humain@miroir de la fin1"
  },
  State_44890_Name = {
    Text = "État@BOSS chien à visage humain@miroir de la fin2"
  },
  State_44891_Name = {
    Text = "État@BOSS chien à visage humain@miroir de la fin3"
  },
  State_44903_Desc = {
    Text = "Lorsque vous subissez des Dégâts Directs ou des Dégâts des tentacules, [StateArg1]% des dégâts seront convertis en quantité de récupération pour la Forge Écarlate, durant [Layer] <plural value=\"[Layer]\" singular=\"tour\" plural=\"tours\">."
  },
  State_44903_Name = {
    Text = "Bénédiction du Créateur"
  },
  State_44909_Name = {
    Text = "Consommable"
  },
  State_45018_Desc = {
    Text = "Avant la fin du tour, vous ne pouvez pas utiliser \"Attaque\""
  },
  State_45018_Name = {Text = "Paralysie"},
  State_45025_Desc = {
    Text = "Voir la logique de grève générale pour des effets spécifiques. __ \"Pour usage de développement uniquement\""
  },
  State_45029_Desc = {
    Text = "Voir la logique de grève générale pour des effets spécifiques. __ \"Pour usage de développement uniquement\""
  },
  State_45032_Desc = {
    Text = "À la fin du prochain tour, subissez [Layer] dégâts"
  },
  State_45032_Name = {Text = "Saignement"},
  State_45039_Desc = {
    Text = "Jusqu'au début du prochain tour, chaque fois que des Dégâts Directs ou des Dégâts des tentacules sont reçus, gagne un Bouclier du personnage égal à [Layer]% des dégâts au début du prochain tour."
  },
  State_45039_Name = {
    Text = "Miracle descendu"
  },
  State_45040_Desc = {
    Text = "Jusqu'au début du prochain tour, chaque fois que des Dégâts Directs ou des Dégâts des tentacules sont reçus, accumule [Layer]% des dégâts en soins pour la Forge Écarlate."
  },
  State_45040_Name = {
    Text = "Miracle descendu"
  },
  State_45049_Desc = {
    Text = "Annule les DGT de la prochaine attaque active (jusqu'à 3 charges). Chaque charge de Match à Mort réduit les charges max de Barrière de 1, mais ne supprime pas les Barrières déjà obtenues."
  },
  State_45049_Name = {Text = "Barrière"},
  State_45050_Desc = {
    Text = "Annule les DGT de la prochaine attaque active (jusqu'à 3 charges). Chaque charge de Match à Mort réduit les charges max de Barrière de 1, mais ne supprime pas les Barrières déjà obtenues."
  },
  State_45050_Name = {
    Text = "<ReinforceColour:Barrière>"
  },
  State_45064_Name = {
    Text = "Compteur de Festin Silencieux__«Dev Only»"
  },
  State_45069_Desc = {
    Text = "Voir la logique de grève générale pour des effets spécifiques. __ \"Pour usage de développement uniquement\""
  },
  State_45072_Name = {
    Text = "Compteur de sanctification"
  },
  State_45073_Desc = {
    Text = "Puissance de calcul des cartes réduite"
  },
  State_45076_Desc = {
    Text = "Dissiper le bouclier de la cible et retarder les soins, avant la fin du tour, les effets de soins et de bouclier sont réduits de 50%"
  },
  State_45076_Name = {Text = "Corruption"},
  State_45137_Desc = {
    Text = "Après avoir utilisé exalter, sceller tous les réveilleurs pendant un tour et obtenir un tour vulnérable"
  },
  State_45137_Name = {
    Text = "Péché originel : Cadavre de la voie"
  },
  State_45139_Desc = {
    Text = "Après avoir utilisé exalter, dissiper aléatoirement un état négatif"
  },
  State_45139_Name = {
    Text = "Bénédiction·Cadavre de la Voie"
  },
  State_45148_Desc = {
    Text = "Les dégâts critiques de tous les éveillés sont réduits de moitié"
  },
  State_45148_Name = {
    Text = "<PurpleKeyWord:Cécité>"
  },
  State_45166_Desc = {
    Text = "La roue du destin équipée avant la fin du tour devient invalide."
  },
  State_45166_Name = {Text = "Entrelacé"},
  State_45206_Desc = {
    Text = "Par la foi, venez en aide au monde. Épuisez tous les restes de récupération de la fournaise cramoisie, obtenez un bouclier de 150% du montant épuisé, ce bouclier n'est pas affecté par les bonus et malus de bouclier, mais ignore la limite de bouclier"
  },
  State_45206_Name = {
    Text = "Rédemption"
  },
  State_45248_Name = {Text = "Compteur"},
  State_45328_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Après « Exaltation », vous fait gagner <TauntKeywords:Provocation> et <Block:[Block:StateArg1]> Bouclier du personnage."
  },
  State_45328_Name = {
    Text = "Magie de l'Argentique"
  },
  State_45329_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : « Frappe » peut choisir sa cible, « frappe » avant de repousser tous les états positifs dissipables de la cible vers l'entité éveillée située derrière elle."
  },
  State_45329_Name = {
    Text = "L'Appel du Fond Marin"
  },
  State_45331_Desc = {
    Text = "<PVPWeaponKeywords:Roues du Destin>: Lors de l'équipement et après un \"Coup\", les \"Compétences\" non dérivées du porteur en main se transformeront successivement en leurs autres \"Compétences\" [ShowIfState:, <CardKeyWord:<SkillName3:>>→<CardKeyWord:<SkillName2:>>→<CardKeyWord:<SkillName1:>>→<CardKeyWord:<SkillName3:>>]."
  },
  State_45331_Name = {
    Text = "Fleurs et Poèmes du Passé"
  },
  State_45332_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Chaque fois que le porteur subit des DGT Actifs, les autres alliés gagnent <Energy:[Energy:StateArg1]> Aliemus."
  },
  State_45332_Name = {
    Text = "Le regard d'Isarau"
  },
  State_45333_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Limite Max de la Main +[StateArg1], après « Exaltation », gagnez <Energy:[Energy:StateArg2]> Aliemus."
  },
  State_45333_Name = {
    Text = "Baiser Ardent d'Adieu"
  },
  State_45334_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: \"Skill\" change le prochain \"Attack\" dans ce tour pour toucher des cibles aléatoires et attaque en plus [StateArg1] cibles aléatoires."
  },
  State_45334_Name = {
    Text = "L'homme dans le miroir"
  },
  State_45345_Desc = {
    Text = "Pour enregistrer le nombre d'utilisations de la compétence de reproduction de phase 1"
  },
  State_45345_Name = {
    Text = "Marque de fertilité 1"
  },
  State_45346_Desc = {
    Text = "Pour enregistrer le nombre d'utilisations de la compétence de reproduction de phase 2"
  },
  State_45346_Name = {
    Text = "Marque de fertilité 2"
  },
  State_45354_Desc = {
    Text = "Cette carte ne peut pas être jouée"
  },
  State_45354_Name = {
    Text = "Ne peut pas être joué __ \"Pour développement uniquement\""
  },
  State_45356_Desc = {
    Text = "À la fin du tour, se transforme en la dernière carte « compétence » jouée, réduisant son coût en arithmétique de 2. Après l'avoir jouée, « Entité de Brume Grise » est mélangée dans le deck."
  },
  State_45356_Name = {
    Text = "<CardKeyWord:Véritable forme de la brume grise>"
  },
  State_45364_Desc = {
    Text = "Au début du prochain tour, cette entité éveillée obtient [Layer] cartes \"Frappe\""
  },
  State_45364_Name = {
    Text = "Recevoir un coup différé"
  },
  State_45385_Desc = {
    Text = "Tous les dégâts infligés dans ce combat sont réduits de [Layer] points, ne peuvent pas être dissipés, incluant [DescArg1] couches de pouvoir temporaire réduites, qui seront supprimées à la fin du tour"
  },
  State_45385_Name = {
    Text = "Force réduite"
  },
  State_45387_Desc = {
    Text = "Tous les dégâts infligés augmentent de +[Layer] dans ce combat et ne peuvent pas être dissipés. [DescArg1] couches de FORCE temporaire seront supprimées à la fin du tour."
  },
  State_45387_Name = {Text = "Force"},
  State_45397_Desc = {
    Text = "Au début du tour, convertissez 1 couche de barrière en force."
  },
  State_45397_Name = {
    Text = "Victoire de la rose"
  },
  State_45403_Desc = {
    Text = "Au début du prochain tour, obtenez [Layer] charges"
  },
  State_45403_Name = {
    Text = "Charge retardée"
  },
  State_45407_Desc = {
    Text = "La folie obtenue et la folie différée sont réduites de 50 %, et toute la folie différée est immédiatement retirée."
  },
  State_45407_Name = {Text = "Vide"},
  State_45656_Desc = {
    Text = "Troisième résurrection de l'arbre-mère, activation de la compétence de reproduction 2"
  },
  State_45658_Desc = {
    Text = "Première résurrection de l'arbre-mère, activation de la compétence de reproduction"
  },
  State_45661_Desc = {
    Text = "Quand la vie tombe à 0, elle devient 1 point, ne subit plus de dégâts et prépare à libérer \"Fusion multiple\""
  },
  State_45661_Name = {
    Text = "Fusion multiple"
  },
  State_45715_Desc = {
    Text = "Obtenez une force temporaire équivalente à [StateArg1]% de dégâts de tentacule"
  },
  State_45715_Name = {Text = "usurpation"},
  State_45716_Desc = {
    Text = "Obtenez une force temporaire équivalente à [StateArg1]% de dégâts de tentacule. Goliath obtient 25% de taux critique temporaire"
  },
  State_45716_Name = {Text = "usurpation"},
  State_45717_Desc = {
    Text = "Augmentez les dégâts de base de \"Might de la Grande Épée\" et \"Dégâts de Décapitation\" de 25% dans cette bataille. Goliath gagne <Energy:[Energy:StateArg2]> points d'Aliemus."
  },
  State_45717_Name = {
    Text = "hibernation"
  },
  State_45718_Desc = {
    Text = "Augmentez les dégâts de base de \"Puissance de la Grande Épée\" et de \"Dégâts de Décapitation\" de 25 % dans cette bataille."
  },
  State_45718_Name = {
    Text = "hibernation"
  },
  State_46057_Name = {
    Text = "Arithmetica"
  },
  State_46079_Desc = {
    Text = "Ce tour, chaque fois que la cible subit des dégâts actifs, soigne l'allié avec le plus de PV perdus de [Layer] PV"
  },
  State_46079_Name = {
    Text = "Saint-Sang guide"
  },
  State_46119_Desc = {
    Text = "La prochaine fois que je serai attaqué, j'infligerai l'enchevêtrement à l'attaquant"
  },
  State_46119_Name = {
    Text = "piège du labyrinthe"
  },
  State_46124_Desc = {
    Text = "Avant la fin du tour, vous ne pouvez effectuer aucune action"
  },
  State_46124_Name = {Text = "Pétrifier"},
  State_46138_Desc = {
    Text = "Devenir la dernière carte \"compétence\" jouée par l'adversaire, et réduire son coût de 1"
  },
  State_46138_Name = {
    Text = "<CardKeyWord:Imitation stellaire>"
  },
  State_46139_Desc = {
    Text = "Chaque fois qu'il est attaqué activement, gagne [Layer] couches de charge et inflige [Layer] couches de stagnation à l'attaquant."
  },
  State_46139_Name = {
    Text = "Gravité anormale"
  },
  State_46155_Desc = {
    Text = "Après sa propre \"Compétence\", gagnez [StateArg1] couches de charge et réduisez le nombre de couches de 1. À la fin du tour, consommez toutes les couches, restaurant [StateArg2] points de vie pour chaque couche."
  },
  State_46155_Name = {
    Text = "Sang aberrant"
  },
  State_46243_Name = {
    Text = "Compteur de Clairvoyance__«Dev Only»"
  },
  State_46255_Desc = {
    Text = "Voir la logique de grève générale pour des effets spécifiques. __ \"Pour usage de développement uniquement\""
  },
  State_46256_Desc = {
    Text = "Voir la logique de grève générale pour des effets spécifiques. __ \"Pour usage de développement uniquement\""
  },
  State_46322_Desc = {
    Text = "Au début du tour, gagnez 30 Fusion d'Embryon."
  },
  State_46322_Name = {
    Text = "You You Ha Xi Démo"
  },
  State_46323_Desc = {
    Text = "Au début du tour hyperdimensionnel, gagnez 100 points de folie, au début du tour gagnez 7 points de force"
  },
  State_46323_Name = {
    Text = "Test de Liz"
  },
  State_46324_Desc = {
    Text = "Gagnez 1 carte \"Inspiration\" chaque tour"
  },
  State_46324_Name = {
    Text = "Test de Jenkins"
  },
  State_46329_Desc = {
    Text = "Après le début du combat, gagnez 600 s-énergie, Lotan gagne 50 points de aliemus, après que Lotan libère l'exalter, gagnez 44 points de aliemus supplémentaires"
  },
  State_46329_Name = {
    Text = "Avantages d'essai"
  },
  State_46330_Desc = {
    Text = "Au début du tour, gagnez 30 Fusion d'Embryon, 10 Aliemus, [DescArg1] FOR, et ajoutez 3 « Attaque » à la Pioche."
  },
  State_46330_Name = {
    Text = "Essai de Shiro"
  },
  State_46333_Name = {
    Text = "Essai de Reya"
  },
  State_46334_Desc = {
    Text = "Après le début du 4e tour, gagnez 100 points de folie"
  },
  State_46334_Name = {Text = "Falos Demo"},
  State_46336_Desc = {
    Text = "Au début du tour, gagnez 30 Fusion d'Embryon et 10 Aliemus."
  },
  State_46336_Name = {
    Text = "Agrippa Demo"
  },
  State_46337_Desc = {
    Text = "Au début du tour, gagnez 10 points de folie"
  },
  State_46337_Name = {
    Text = "Kékes Démo"
  },
  State_46338_Desc = {
    Text = "Au début du tour, gagnez 30 Fusion d'Embryon et 10 Aliemus."
  },
  State_46338_Name = {
    Text = "Féinter Démo"
  },
  State_46427_Desc = {
    Text = "Voir la logique de grève générale pour des effets spécifiques. __ \"Pour usage de développement uniquement\""
  },
  State_46428_Desc = {
    Text = "Voir la logique de grève générale pour des effets spécifiques. __ \"Pour usage de développement uniquement\""
  },
  State_46429_Desc = {
    Text = "Voir la logique de grève générale pour des effets spécifiques. __ \"Pour usage de développement uniquement\""
  },
  State_46441_Desc = {
    Text = "Immunité à tous les dégâts, retirée au début du tour"
  },
  State_46441_Name = {
    Text = "Immunité aux dégâts"
  },
  State_46442_Name = {
    Text = "Les cartes sont interdites de modifier les types de cibles d'attaque __ \"Pour usage de développement uniquement\""
  },
  State_46500_Desc = {
    Text = "Voir la logique de grève générale pour des effets spécifiques. __ \"Pour usage de développement uniquement\""
  },
  State_46505_Desc = {
    Text = "Durant ce tour, chaque fois que vous subissez des Dégâts Directs, obtenez [Layer] Aliemus."
  },
  State_46505_Name = {
    Text = "Conversion de la douleur"
  },
  State_46508_Desc = {
    Text = "Lorsqu'il est Inconscient, une cible ne peut pas agir jusqu'à la fin du tour. Subir des Dommages d'évanouissement confère une Résistance. Si la Résistance est active, les Dommages d'évanouissement suivants sont doublés mais l'effet d'évanouissement est annulé."
  },
  State_46508_Name = {
    Text = "Résistance"
  },
  State_46511_Desc = {
    Text = "Les dommages de «Superposition des mille visages» de cet Éveilleur augmentent de [Layer]."
  },
  State_46511_Name = {
    Text = "Superposition des mille visages"
  },
  State_46512_Desc = {
    Text = "Avant la fin du tour, cet éveilleur subit des dégâts de [Layer] après avoir joué une carte."
  },
  State_46512_Name = {
    Text = "Verrouillage de Carte"
  },
  State_46513_Desc = {
    Text = "Amplifie le prochain poème, lui octroie un effet supplémentaire, ne peut pas être dissipé."
  },
  State_46513_Name = {
    Text = "Encre de deuil"
  },
  State_46536_Desc = {
    Text = "Si le paramètre d'état 1 est égal à 0, piochez des cartes, sinon affichez simplement le texte"
  },
  State_46536_Name = {Text = "Piocher"},
  State_46538_Desc = {
    Text = "Au début de l'exploration, gagnez [StateArg1] points de folie"
  },
  State_46538_Name = {
    Text = "Présage de Folie"
  },
  State_47072_Desc = {
    Text = "Ce tour, le taux critique de la carte de frappe +[Layer] %"
  },
  State_47072_Name = {
    Text = "Coup critique"
  },
  State_47089_Name = {
    Text = "Effet de test__« Développement uniquement »"
  },
  State_47096_Desc = {
    Text = "Pour chaque carte \"Inspiration\" jouée, Daphné gagne [StateArg1] points de folie et [StateArg2] points de force, max 5 fois par tour. (reste [DescArg1] fois)"
  },
  State_47096_Name = {
    Text = "Précipité d'essence"
  },
  State_47189_Name = {
    Text = "Basculer vers la Personnalité maniaque. Caro·Dépressif : <EmbryoFusionIconKeywords:Fusion d'Embryon> +[Blood:StateArg5], accumule [StateArg6] points de récupération de Forge Écarlate"
  },
  State_47192_Name = {
    Text = "Personnalité dépressive : fait également obtenir aux autres Corps éveillés [DescArg1] fois la Fureur. Personnalité maniaque : obtient [DescArg2] fois la Fureur supplémentaire"
  },
  State_47199_Name = {
    Text = "Passer à la Personnalité dépressive. Chair·Maniaque : Les Dommages bénéficient d'un bonus de [DescArg1]x <PowerIconKeywords:force> et infligent <BleedingIconKeywords:Saignement> de 200 % des Dommages infligés sur la cible. Obtient [StateArg7] <PowerIconKeywords:force>"
  },
  State_47204_Name = {
    Text = "Changer pour une personnalité maniaque. Chaos·dépression : Obtient <Posse:[StateArg1]> points de s-énergie, le prochain posse s'applique 2 fois"
  },
  State_47206_Name = {
    Text = "Changer pour une personnalité maniaque. Fond marin·dépression : <WeaknessIconKeywords:faiblesse> et <VulnerabilityIconKeywords:vulnérable> sur la cible pendant 2 tours, génère 1 tentacule, <TentacleInjurieIconKeywords:dégâts de tentacule> + [TentaclePower:StateArg3]"
  },
  State_47209_Name = {
    Text = "Passer à la Personnalité dépressive. Ultra : Symptôme : Folie : Obtenir 15 % des dégâts infligés sous forme de <RetaliateIconKeywords:Contre-attaque>, puis infliger un montant équivalent de <FixedDamage:DGT Purs> aux autres ennemis. Pour chaque carte «Clairvoyance» jouée ce tour, augmenter ces dégâts de [StateArg9] pour le reste du tour, jusqu'à [StateArg10]"
  },
  State_47211_Name = {
    Text = "Personnalité dépressive : réduit le Coût d'Arithmetica de [DescArg1] Carte(s) ayant le coût d'Arithmetica le plus élevé dans la Main de 1 point, et obtient <RetainIconKeywords:Garder> Temporaire. Personnalité maniaque : inflige [DescArg2] fois des Dommages supplémentaires"
  },
  State_47212_Name = {
    Text = ": Permet à \"24\" de basculer entre les personnalités dépressive et maniaque, déclenchant des effets supplémentaires selon le domaine et la personnalité actuels"
  },
  State_47216_Name = {
    Text = "Changer pour une personnalité dépressive. Aequor·manie : Ce dégât bénéficie d'un bonus de [StateArg4]% <TentacleInjurieIconKeywords:dégâts de tentacule> et inflige 30% de dégâts d'<IntoxicationIconKeywords:poison> à tous les ennemis"
  },
  State_47217_Name = {
    Text = "Passer à la personnalité dépressive. Chaos·Maniaque : Inflige 3 fois des dégâts, augmentant tous les dégâts de \"24\" de [StateArg2] points"
  },
  State_47218_Name = {
    Text = "Passez à la Persona Maniac. Ultra·Dépression : Ajoutez 2 \"Inspiration\" à votre main, réduisez temporairement les points de [Power:StateArg8] de la cible de <PowerIconKeywords:Power>"
  },
  State_47222_Name = {
    Text = "Personnalité dépressive : réduit le Coût d'Arithmetica de [DescArg1] Carte(s) ayant le coût d'Arithmetica le plus élevé dans la Main de 1 point, et obtient <RetainIconKeywords:Garder> Temporaire. <AwakerCard_24Lost:Personnalité maniaque : inflige [DescArg2] fois des Dommages supplémentaires>"
  },
  State_47224_Name = {
    Text = "Personnalité dépressive : fait également obtenir aux autres Corps éveillés [DescArg1] fois la Fureur. <AwakerCard_24Lost:Personnalité maniaque : obtient [DescArg2] fois la Fureur supplémentaire>"
  },
  State_47228_Name = {
    Text = "<AwakerCard_24Lost:Personnalité dépressive : fait également obtenir aux autres Corps éveillés [DescArg1] fois la Fureur.>Personnalité maniaque : obtient [DescArg2] fois la Fureur supplémentaire"
  },
  State_47229_Name = {
    Text = "<AwakerCard_24Lost:Personnalité dépressive : réduit le Coût d'Arithmetica de [DescArg1] Carte(s) ayant le coût d'Arithmetica le plus élevé dans la Main de 1 point, et obtient <RetainIconKeywords:Garder> Temporaire. >Personnalité maniaque : inflige [DescArg2] fois des Dommages supplémentaires"
  },
  State_47451_Name = {
    Text = "Effet de la Roue du Destin désactivé par le Décret Clé de Ryker"
  },
  State_47485_Name = {
    Text = "Personnalité dépressive : réduit le Coût d'Arithmetica de [DescArg1] Carte(s) ayant le coût d'Arithmetica le plus élevé dans la Main de 2 points, et obtient <RetainIconKeywords:Garder> Temporaire. Personnalité maniaque : inflige [DescArg2] fois des Dommages supplémentaires"
  },
  State_47486_Name = {
    Text = "Personnalité dépressive : réduit le Coût d'Arithmetica de [DescArg1] Carte(s) ayant le coût d'Arithmetica le plus élevé dans la Main de 2 points, et obtient <RetainIconKeywords:Garder> Temporaire. <AwakerCard_24Lost:Personnalité maniaque : inflige [DescArg2] fois des Dommages supplémentaires>"
  },
  State_47488_Name = {
    Text = "Personnalité dépressive : obtient <Energy: [DescArg1]> points de Fureur supplémentaires. Personnalité maniaque : obtient [DescArg2] Bouclier(s) supplémentaire(s)"
  },
  State_47489_Name = {
    Text = "<AwakerCard_24Lost:Personnalité dépressive : réduit le Coût d'Arithmetica de [DescArg1] Carte(s) ayant le coût d'Arithmetica le plus élevé dans la Main de 2 points, et obtient <RetainIconKeywords:Garder> Temporaire. >Personnalité maniaque : inflige [DescArg2] fois des Dommages supplémentaires"
  },
  State_47492_Name = {
    Text = "Personnalité dépressive : obtient <Energy: [DescArg1]> points de Fureur supplémentaires. <AwakerCard_24Lost:Personnalité maniaque : inflige [DescArg2] fois des Dommages supplémentaires>"
  },
  State_47493_Name = {
    Text = "Personnalité dépressive : obtient <Energy: [DescArg1]> points de Fureur supplémentaires. Personnalité maniaque : inflige [DescArg2] fois des Dommages supplémentaires"
  },
  State_47494_Name = {
    Text = "Personnalité dépressive : fait également obtenir aux autres Corps éveillés [DescArg1] fois la Fureur, applique <WeaknessIconKeywords:Faiblesse> à tous les ennemis pendant [DescArg3] tours. Personnalité maniaque : obtient [DescArg2] fois la Fureur supplémentaire, applique <VulnerabilityIconKeywords:Vulnérable> à tous les ennemis pendant [DescArg3] tours"
  },
  State_47495_Name = {
    Text = "Personnalité dépressive : fait également obtenir aux autres Corps éveillés [DescArg1] fois la Fureur, applique <WeaknessIconKeywords:Faiblesse> à tous les ennemis pendant [DescArg3] tours. <AwakerCard_24Lost:Personnalité maniaque : obtient [DescArg2] fois la Fureur supplémentaire, applique Vulnérable à tous les ennemis pendant [DescArg3] tours>"
  },
  State_47496_Name = {
    Text = "<AwakerCard_24Lost:Personnalité dépressive : fait également obtenir aux autres Corps éveillés [DescArg1] fois la Fureur, applique Faiblesse à tous les ennemis pendant [DescArg3] tours.>Personnalité maniaque : obtient [DescArg2] fois la Fureur supplémentaire, applique <VulnerabilityIconKeywords:Vulnérable> à tous les ennemis pendant [DescArg3] tours"
  },
  State_47498_Name = {
    Text = "<AwakerCard_24Lost:Personnalité dépressive : obtient [DescArg1] points de Fureur supplémentaires.>Personnalité maniaque : inflige [DescArg2] fois des Dommages supplémentaires"
  },
  State_47499_Name = {
    Text = "<AwakerCard_24Lost:Personnalité dépressive : obtenir [DescArg1] points d'Aliemus supplémentaires.>Personnalité maniaque : obtenir [DescArg2] Bouclier(s) supplémentaire(s)"
  },
  State_47500_Name = {
    Text = "Personnalité dépressive : obtient <Energy: [DescArg1] > points de Fureur supplémentaires. <AwakerCard_24Lost:Personnalité maniaque : obtient [DescArg2] Bouclier(s) supplémentaire(s)>"
  },
  State_47517_Desc = {
    Text = "<PVPWeaponKeywords:wheel of destiny>: À la fin du tour, défaussez [StateArg1] cartes d'autres éveilleurs. Si la défausse est réussie, piochez [StateArg2] cartes."
  },
  State_47517_Name = {
    Text = "Détermination du Cabillaud Argenté"
  },
  State_47518_Name = {
    Text = "Compteur de Volonté de la Morue Argentée__«Dev Only»"
  },
  State_47528_Desc = {
    Text = "Ce tour, « Attaque » inflige +[DescArg1]% de Dommages. <PVPPenetrateKeywords:Perçant>."
  },
  State_47528_Name = {
    Text = "Résidus de la Bête Céleste"
  },
  State_47530_Desc = {
    Text = "Considéré comme le \"Compétence\" joué en dernier ce tour."
  },
  State_47530_Name = {
    Text = "<CardKeyWord:Simulation>"
  },
  State_47557_Desc = {
    Text = "Équipe Unique : Le Porteur adopte le Persona Morue Argentée après le début de l'exploration. Il alternera entre les Personas Morue Argentée et Chat après avoir utilisé l'Exaltation.\nMorue Argentée : Gagnez <WeaponEffect_Num:[StateArg1]> Fragments de clé après avoir infligé des Dégâts Directs. Chat : Gagnez une augmentation de Dommages critiques temporaires de <WeaponEffect_Num:+[StateArg2]%> après avoir infligé des Dégâts Directs. Ces effets partagent un maximum de 5 déclenchements par tour."
  },
  State_47557_WeaponDesc = {
    Text = "Le Porteur adopte le Persona Morue Argentée après le début de l'exploration. Il alternera entre les Personas Morue Argentée et Chat après avoir utilisé l'Exaltation.\nMorue Argentée : Gagnez <WeaponEffect_Num:[StateArg1]> Fragments de clé après avoir infligé des Dégâts Directs. Chat : Gagnez une augmentation de Dommages critiques temporaires de <WeaponEffect_Num:+[StateArg2]%> après avoir infligé des Dégâts Directs. Ces effets partagent un maximum de 5 déclenchements par tour."
  },
  State_47822_Desc = {
    Text = "Si la cible subit à nouveau une «Paralysie» au prochain tour, toutes ses «Attaque» deviennent des «Illusion», impossible à dissiper, jusqu'à la fin du prochain tour."
  },
  State_47822_Name = {
    Text = "Un peu paralysé"
  },
  State_47825_Desc = {
    Text = "Au début du tour, l'effet de compétence correspondant est déclenché."
  },
  State_47825_Name = {
    Text = "<CardKeyWord:Retard>"
  },
  State_47826_Desc = {
    Text = "·Les Dommages sont doublés si la cible est sous «Paralysie», sinon son «Attaque» ne peut pas être utilisée ce tour.\n·Après 2 tours consécutifs sous «Paralysie», toutes ses «Attaque» deviennent des «Illusion»."
  },
  State_47826_Name = {
    Text = "<WeaknessColour:Paralysie>"
  },
  State_47827_Desc = {
    Text = "Chaque couche réduit de 1 point tous les dégâts infligés dans ce combat, ne peut pas être dissipée."
  },
  State_47827_Name = {
    Text = "<WeaknessColour: Réduction du pouvoir>"
  },
  State_47828_Desc = {
    Text = "Lorsque cet état est infligé à un ennemi, inflige le même montant de Dommages. Si la cible est déjà « Entrelacé », les Dommages infligés sont doublés. « Entrelacé » désactive la Roue du Destin équipée de la cible jusqu'à la fin du tour."
  },
  State_47828_Name = {
    Text = "<WeaknessColour:Enroulement>"
  },
  State_47830_Desc = {
    Text = "Dissiper le bouclier de la cible et retarder les soins, avant la fin du tour, les effets de soins et de bouclier sont réduits de 50%"
  },
  State_47830_Name = {
    Text = "<PVPVulnerabilityIconColour:Blessure grave>"
  },
  State_47831_Desc = {
    Text = "Lorsqu'une cible est Inconsciente, elle ne peut effectuer aucune action jusqu'à la fin du tour. Subir des Dommages d'évanouissement confère une Résistance. Si la Résistance est active, les Dommages d'évanouissement suivants sont doublés mais l'effet d'évanouissement est annulé."
  },
  State_47831_Name = {
    Text = "<ComaColour:Pétrification>"
  },
  State_47832_Desc = {
    Text = "Inclut souris infectée, souris électrique, souris démente"
  },
  State_47832_Name = {
    Text = "<CardKeyWord:Carte de rat>"
  },
  State_47833_Desc = {
    Text = "Comprend un mouchoir en forme de colombe, une boîte à magie inversée, un microphone de télépathie"
  },
  State_47833_Name = {
    Text = "<CardKeyWord:Magie stupéfiante>"
  },
  State_47841_Desc = {
    Text = "Dans ce combat, l'utilisation de la clé [Layer] fois sera efficace 2 fois"
  },
  State_47841_Name = {
    Text = "Double Clé"
  },
  State_47842_Desc = {
    Text = "La folie obtenue et la folie différée sont réduites de 50 %, et toute la folie différée est immédiatement retirée."
  },
  State_47842_Name = {
    Text = "<PVPEmptinessColour:Vide>"
  },
  State_47843_Desc = {
    Text = "Fait que le réveil se libère de la mort et place son ensemble de cartes dans la pile de pioche"
  },
  State_47843_Name = {
    Text = "<PVPResurrectionColour:Renaissance>"
  },
  State_47844_Desc = {
    Text = "Effet aléatoire déroutant"
  },
  State_47844_Name = {
    Text = "<PVPWonderfulEffectKeywords:Effet Merveilleux>"
  },
  State_47845_Desc = {
    Text = "Les cartes produisent un effet lorsqu'elles sont en main"
  },
  State_47845_Name = {
    Text = "<CardKeyWord:Possession>"
  },
  State_47873_Desc = {
    Text = "À la fin du prochain tour, infligez des dégâts équivalents aux couches"
  },
  State_47873_Name = {
    Text = "<PVPVulnerabilityIconColour:Saignement>"
  },
  State_47887_Name = {
    Text = "Différents effets sont obtenus selon le domaine de l'équipe actuelle"
  },
  State_47888_Name = {
    Text = "Caro : chaque point d'Arithmetica dépensé par «24» octroie <EmbryoFusionIconKeywords:Fusion d'Embryon> +[Blood:DescArg1] et [StateArg3] points de <PowerIconKeywords:Force>, l'Exaltation de «24» bénéficie d'un bonus de Force supplémentaire de 300%"
  },
  State_47889_Name = {
    Text = "Aequor : Les dégâts «24» bénéficient d'un bonus de [StateArg2]% <TentacleInjurieIconKeywords:dégâts de tentacule> et infligent un <IntoxicationIconKeywords:poison> équivalent à 10% des dégâts infligés. L'exaltation de «24» peut déclencher [StateArg6]% de <IntoxicationIconKeywords:poison> sur les ennemis."
  },
  State_47892_Name = {
    Text = "Chaos : Taux Critique et Dégâts Critiques de «24» +[StateArg4]%. Chaque utilisation d'un Décret Clé augmente les Dégâts Finaux d'Exaltation de «24» de [StateArg1]%"
  },
  State_47894_Name = {
    Text = "Les dégâts causés par « 24 » de l'ultra bénéficient d'un bonus de dégâts de [StateArg5]% <RetaliateIconKeywords: contre-attaque>, à la fin du tour, 1 « inspiration » est mélangée dans la pile de défausse et la main est augmentée de +2"
  },
  State_48009_Desc = {
    Text = "La première carte jouée chaque tour a un effet supplémentaire [StateArg1] fois"
  },
  State_48009_Name = {
    Text = "<Rune_19:Ensemble>"
  },
  State_48010_Desc = {
    Text = "Marquage d'Ensemble"
  },
  State_48010_Name = {
    Text = "Marquage d'Ensemble"
  },
  State_48011_Desc = {
    Text = "La première carte jouée chaque tour a un effet supplémentaire [StateArg1] fois"
  },
  State_48011_Name = {
    Text = "<Rune_19_High:Ensemble avancé>"
  },
  State_48011_WeaponDesc = {
    Text = "Après avoir joué, s'active [StateArg1] fois supplémentaires, consommée"
  },
  State_48012_Desc = {
    Text = "Faire en sorte que les cartes marquées soient effectives 2 fois lors de leur première utilisation dans chaque tour"
  },
  State_48012_Name = {
    Text = "<CardKeyWord: Oraison : Ensemble>"
  },
  State_48013_Desc = {
    Text = "Faites en sorte que les cartes marquées soient effectives 3 fois lors de leur première action chaque tour"
  },
  State_48013_Name = {
    Text = "<CardKeyWord: Oraison : Ensemble avancé>"
  },
  State_48019_Name = {
    Text = "<CardKeyWord:Simulation>"
  },
  State_48020_Name = {
    Text = "<CardKeyWord: Naissance d'une âme>"
  },
  State_48021_Name = {
    Text = "<CardKeyWord:Véritable forme de la brume grise>"
  },
  State_48078_Name = {
    Text = "<CardKeyWord:Imitation stellaire>"
  },
  State_48099_Desc = {
    Text = "À la fin du tour, « 24 » obtient [DescArg1] points de folie, chaque fois que « 24 » libère l'exaltation, les points de folie obtenus par cet effet augmentent de 1"
  },
  State_48099_Name = {
    Text = "Recherche comportementale de Pavlov"
  },
  State_48099_WeaponDesc = {
    Text = "À la fin du tour, l'équipé gagne 3 points de folie. Si la recharge de folie de l'équipé est supérieure à 10, il gagne 2 points de folie supplémentaires"
  },
  State_48100_Name = {
    Text = "État@24comptage de comportement de Pavlov"
  },
  State_48100_WeaponDesc = {
    Text = "À la fin du tour, l'équipé gagne 3 points de folie. Si la recharge de folie de l'équipé est supérieure à 10, il gagne 2 points de folie supplémentaires"
  },
  State_48107_Desc = {
    Text = "La première « Compétence » jouée par le Porteur chaque tour inflige +[StateArg1]% de Dommages."
  },
  State_48107_Name = {
    Text = "Lame du Colosse"
  },
  State_48108_Desc = {
    Text = "Après la première utilisation d'un « compétence » par l'équipement chaque tour, une copie de puissance consommée - [StateArg1] sera mélangée dans la pile de pioche"
  },
  State_48108_Name = {Text = "Pirouette"},
  State_48110_Desc = {
    Text = "\"Compétence\" provoque la prochaine \"Frappe\" de ce tour pour cibler un ennemi aléatoire et attaquer [StateArg1] encore plus d'ennemis aléatoires."
  },
  State_48110_Name = {
    Text = "L'homme dans le miroir"
  },
  State_48140_Desc = {
    Text = "Au début de l'exploration, «24» entre dans l'état de Personnalité dépressive. \n<School_1:Chaos·Dépressive> : Obtient <Posse:[StateArg1]> Fragment de clé, le prochain Décret Clé s'applique 2 fois. \n<School_1:Chaos·Maniaque> : Inflige 3 dommages, augmentant tous les dommages infligés par «24» de [StateArg2]. \n<School_2:Aequor·Dépressive> : Inflige <WeaknessIconKeywords:Symptôme : Affaiblir> et <VulnerabilityIconKeywords:Vulnérable> à la cible pendant 2 tours, génère 1 Tentacule avec <TentacleInjurieIconKeywords:Dégâts des tentacules> +[StateArg3]. \n<School_2:Aequor·Maniaque> : Ce dégât bénéficie d'un bonus de [StateArg4]% <TentacleInjurieIconKeywords:Dégâts des tentacules> et inflige <IntoxicationIconKeywords:Poison> à tous les ennemis pour 30% des dégâts. \n<School_3:Caro·Dépressive> : <EmbryoFusionIconKeywords:Fusion d'Embryon> +[Blood:StateArg5], accumulant [StateArg6] points de récupération de Forge Écarlate. \n<School_3:Caro·Maniaque> : Les dégâts bénéficient d'un bonus de 6× <PowerIconKeywords:STR> et infligent <BleedingIconKeywords:Saignement> de 200% des dégâts sur la cible, gagnant [StateArg7] <PowerIconKeywords:STR>. \n<School_4:Ultra·Dépressive> : Ajoute 2 cartes «Clairvoyance» à la main, réduit temporairement la <PowerIconKeywords:STR> de la cible de [StateArg8]. \n<School_4:Ultra·Maniaque> : Obtient une <RetaliateIconKeywords:Contre-attaque> égale à 15% des dégâts infligés, puis inflige le même montant de <RealDamage:Dégâts Fixes> aux autres ennemis. Pour chaque carte «Clairvoyance» jouée ce tour-ci, augmente ce dégât de [StateArg9], jusqu'à un maximum de [StateArg10]."
  },
  State_48140_Name = {
    Text = "Domaine et Effet de Personnalité"
  },
  State_48141_Desc = {
    Text = "<School_1:Chaos> : Taux critique et dégâts critiques de «24» +[StateArg4]%. Chaque utilisation du Décret Clé augmente les Dégâts Finaux d'exaltation de «24» de [StateArg1]%.\n<School_2:Aequor> : Les dégâts infligés par «24» bénéficient d'un bonus de [StateArg2]% <TentacleInjurieIconKeywords:Dégâts des tentacules> et infligent un <IntoxicationIconKeywords:Poison> de 10%. L'exaltation de «24» peut déclencher un <IntoxicationIconKeywords:Poison> de 50% sur les ennemis.\n<School_3:Chair> : Pour chaque point d'Arithmetica consommé par «24», <EmbryoFusionIconKeywords:Fusion d'Embryon> +[Blood:5], «24» obtient [StateArg3] points de <PowerIconKeywords:Force>. Son Exaltation bénéficie d'un bonus de Force supplémentaire de 300%.\n<School_4:Ultra> : Les dégâts causés par «24» bénéficient d'un bonus de dégâts de [StateArg5]% <RetaliateIconKeywords:Contre-attaque>, à la fin du tour, 1 «Clairvoyance» est mélangée dans la pile de défausse et la main est augmentée de +2."
  },
  State_48141_Name = {
    Text = "Effet de domaine"
  },
  State_48149_Name = {
    Text = "Ne pas activer les effets spéciaux des cartes __ \"À l'usage des développeurs uniquement\""
  },
  State_48176_Desc = {
    Text = "Dans cette démonstration, obtenez 1 point d'arithmetica par tour, et « 24 » consomme 1 point d'arithmetica pour obtenir 30 points d'énergie clé en argent"
  },
  State_48176_Name = {
    Text = "«24» Test"
  },
  State_48198_Desc = {
    Text = "Pendant cette démo, gagnez 1 carte \"Inspiration\" par tour"
  },
  State_48198_Name = {
    Text = "«24» Test"
  },
  State_48199_Desc = {
    Text = "Dans cette démonstration, obtenez 1 point d'arithmetica par tour"
  },
  State_48199_Name = {
    Text = "«24» Test"
  },
  State_48589_Desc = {
    Text = "Cet éveilleur n'est pas encore éveillé... Il s'éveillera lorsqu'il sera sur le point d'être abattu, restaurera sa vie, doublera et commencera à se battre sous sa véritable forme"
  },
  State_48589_Name = {
    Text = "Non Réveillé"
  },
  State_48607_Name = {
    Text = "Coût Arithmetica de la carte générique réduit __ \"Pour développement uniquement\""
  },
  State_48822_Desc = {
    Text = "Au début du tour du royaume de chair et de sang, le fusionnement d'embryons gagné augmente de 50%"
  },
  State_48822_Name = {
    Text = "Vie éternelle"
  },
  State_48923_Desc = {
    Text = "L'ombre \"24\" a déjà émergé, utilise le dernier \"sauvez-moi\" pour trouver une opportunité !"
  },
  State_48923_Name = {
    Text = "Ombre «24» Éveil !"
  },
  State_48923_WeaponDesc = {
    Text = "Au début du prochain tour, obtenez un bouclier équivalent à la vie perdue au tour précédent"
  },
  State_49063_Desc = {
    Text = "Les dégâts de \"frappe\" de Lotan augmentent de 30 %"
  },
  State_49063_Name = {
    Text = "Volonté de combattre élevée"
  },
  State_49109_Desc = {
    Text = "Les cartes obtiennent <RetainIconKeywords:conserver>, si elles sont en main à la fin du tour, obtenez 1 copie originale de cette carte de commandement avec <DepleteIconKeywords:consommation>."
  },
  State_49109_Name = {
    Text = "<Rune_20_High:Incubation>"
  },
  State_49109_WeaponDesc = {
    Text = "Après avoir joué, s'active [StateArg1] fois supplémentaires, consommée"
  },
  State_49148_Desc = {
    Text = "Après la mort, ajoutez « Mutation 1 » à une carte dont le coût d'arithmetica n'est pas 0. Mutation : état de carte, conservé après la fin du combat. Chaque couche réduit le coût d'arithmetica de 1, mais après avoir été jouée, chaque couche ajoute une carte de mutation aléatoire à votre main (ignorer la limite de cartes en main), retirez toutes les mutations."
  },
  State_49148_Name = {
    Text = "Fœtus Déformé"
  },
  State_49149_Desc = {
    Text = "Chaque couche réduit de 1 la consommation d’arythmétique de la carte. Après avoir été jouée, pour chaque couche de déformation, ajoutez une carte de déformation aléatoire à votre main et retirez cet état. Cet état sera conservé après la fin du combat"
  },
  State_49149_Name = {
    Text = "<ExclamationPointColour:Distorsion [Layer]>"
  },
  State_49149_WeaponDesc = {
    Text = "Après avoir joué, retire définitivement"
  },
  State_49207_Name = {
    Text = "Obtenir 100 Énergie de clé"
  },
  State_49225_Desc = {
    Text = "Après la fin du tour, une tentacule attaque [Layer] fois"
  },
  State_49225_Name = {
    Text = "<CardKeyWord:Tentacules>"
  },
  State_49226_Desc = {
    Text = "À la fin du tour, chaque carte en main déclenche un effet de <IntoxicationIconKeywords:poison> de 3 % sur tous les ennemis et vous obtenez 3 points de folie."
  },
  State_49226_Name = {
    Text = "Lumière vacillante"
  },
  State_49260_Desc = {
    Text = "À la fin du tour, récupère 7,5% de la vie maximale"
  },
  State_49260_Name = {
    Text = "Douleur Non Acceptée"
  },
  State_49270_Desc = {
    Text = "Dégâts des cartes de coup augmentés de [Layer] %"
  },
  State_49270_Name = {
    Text = "Dégâts des cartes de coup augmentés"
  },
  State_49270_WeaponDesc = {
    Text = "Dégâts des cartes de coup augmentés de [Layer] %"
  },
  State_49278_Desc = {
    Text = "À la fin du tour, récupère 5% des PV perdus. Si PV < 50% ([StateArg1]), gagne aussi [StateArg2] points de force"
  },
  State_49278_Name = {
    Text = "Autel Écarlate"
  },
  State_49430_Desc = {
    Text = "Les dégâts reçus sont réduits, chaque couche réduit de 1 %. Suppression de cet état après la mort d'un autre allié"
  },
  State_49430_Name = {
    Text = "<AberrationColour: cacher>"
  },
  State_49500_Desc = {
    Text = "Chaque couche ajoute une attaque, perd une couche en cas de dégâts, perd toutes les couches à la fin du tour"
  },
  State_49500_Name = {Text = "Prière"},
  State_49524_Desc = {
    Text = "À la fin du tour, récupérer la vie équivalente à 5% de la vie perdue. Chaque fois qu'un joueur pioche une carte état ou symptôme, tous les « nubie » reçoivent [StateArg1] points de puissance temporaire"
  },
  State_49524_Name = {
    Text = "Évangile Sanguin"
  },
  State_49526_Desc = {
    Text = "Après la mort, restaurez immédiatement [StateArg2] points de vie et immunisez-vous contre les dégâts pendant 1 tour, ajustez l'intention à « semence de désordre »"
  },
  State_49526_Name = {Text = "Séparer"},
  State_49542_Desc = {
    Text = "Équipe Unique : Après le début du combat, gagnez une Force équivalente à <WeaponEffect_Num:[StateArg1]%> de l'Attaque du porteur. Si le royaume actuel est « Aequor », augmentez également les Dégâts des tentacules du porteur de <WeaponEffect_Num:[StateArg2]%> de son Attaque."
  },
  State_49542_WeaponDesc = {
    Text = "Après le début de la bataille, obtenez <WeaponEffect_Num:[Power:DescArg1]> points de <PowerIconKeywords:force>. Si le royaume actuel est « Fond marin », obtenez en plus <WeaponEffect_Num:[DescArg2]> points de dégâts de tentacule."
  },
  State_49546_Desc = {
    Text = "Toujours accompagné de 2 gardes d'élite. Ils meurent à sa mort"
  },
  State_49546_Name = {Text = "Formation"},
  State_49547_Desc = {
    Text = "Après la mort, le capitaine de la garde d'Aylan reçoit [StateArg1] points de pouvoir et un bouclier de 50% de la santé max"
  },
  State_49547_Name = {Text = "Loyauté"},
  State_49558_Desc = {
    Text = "La force augmente de [StateArg1] points chaque tour"
  },
  State_49558_Name = {
    Text = "Prière du sable"
  },
  State_49582_Desc = {
    Text = "Dans ce combat, le bouclier restant chaque tour ne sera pas retiré et sera conservé"
  },
  State_49582_Name = {
    Text = "Bouclier conserver définitivement"
  },
  State_49583_Desc = {
    Text = "À la fin du tour, obtient [StateArg1] points de bouclier, bénéficiaire du bonus d'alerte"
  },
  State_49583_Name = {
    Text = "Bouclier d'Aran"
  },
  State_49595_Desc = {
    Text = "Cet éveilleur n'est pas encore éveillé... Il s'éveillera lorsqu'il sera sur le point d'être abattu, restaurera sa vie et commencera à se battre sous sa véritable forme"
  },
  State_49595_Name = {
    Text = "Non Réveillé"
  },
  State_49596_Desc = {
    Text = "\"Lame de Rêve\" s'est éveillée. Elle gagnera plus de Boucliers et de Force."
  },
  State_49596_Name = {
    Text = "Elva Éveil!"
  },
  State_49596_WeaponDesc = {
    Text = "Au début du prochain tour, obtenez un bouclier équivalent à la vie perdue au tour précédent"
  },
  State_49597_Name = {
    Text = "Ce tour a déjà été étourdi __ \"Pour un usage de développement uniquement\""
  },
  State_49600_Desc = {
    Text = "Affaiblir tous les ennemis 2 tours"
  },
  State_49600_Name = {
    Text = "Sang de terreur"
  },
  State_49601_Desc = {
    Text = "Vulnérable à tous les ennemis pendant 2 tours"
  },
  State_49601_Name = {
    Text = "Sang putréfié"
  },
  State_49602_Desc = {
    Text = "Vulnérable à tous les ennemis pendant 1 tour"
  },
  State_49602_Name = {
    Text = "Sang putréfié"
  },
  State_49603_Desc = {
    Text = "Fusion d'Embryon +[Blood:DescArg1]."
  },
  State_49603_Name = {
    Text = "Sang de reproduction"
  },
  State_49604_Desc = {
    Text = "Fusion d'Embryon +[Blood:DescArg1]."
  },
  State_49604_Name = {
    Text = "Sang de reproduction"
  },
  State_49605_Desc = {
    Text = "Affaiblir tous les ennemis 1 tour"
  },
  State_49605_Name = {
    Text = "Sang de terreur"
  },
  State_49623_Desc = {
    Text = "La régénération de vie reçue est réduite de [DescArg1]%. Retire 1 couche à la fin du tour"
  },
  State_49623_Name = {
    Text = "<BaseDamageColour:Grave blessure>"
  },
  State_49623_WeaponDesc = {
    Text = "Tous les dégâts infligés sont réduits de [DescArg1] %"
  },
  State_49627_Desc = {
    Text = "Commencez avec 2 couches de <ParcloseIconKeywords:barrière>. À la mort, tous les \"Nubia\" gagnent [StateArg1] points de force"
  },
  State_49627_Name = {
    Text = "Sang bouillonnant"
  },
  State_49628_Desc = {
    Text = "Lors de la mort, tous les \"Nubie\" gagnent [StateArg1] Force."
  },
  State_49628_Name = {
    Text = "Lien de sang"
  },
  State_49638_Desc = {
    Text = "Identifier si c'est un monstre de la série Chèvre noire"
  },
  State_49833_Desc = {
    Text = "À la fin du tour, appliquer le statut « cécité » pendant 1 tour à tous les ennemis. Si le bouclier est brisé, alors le statut « cécité » est annulé"
  },
  State_49833_Name = {
    Text = "Mur de sable et de poussière"
  },
  State_49844_Desc = {
    Text = "Équipe Unique : À la fin du tour, gagnez <WeaponEffect_Num:[StateArg1]> points de Fragment de clé. Après avoir déclenché la Résistance à la mort, obtenez <WeaponEffect_Num:[StateArg2]> points de Fragment de clé. Après utilisation du Corps de Gnosis d'urgence, la Limite d’Arithmetica augmente de 3 et le nombre de cartes piochées par tour augmente de 3."
  },
  State_49844_WeaponDesc = {
    Text = "À la fin du tour, obtenez <WeaponEffect_Num:[StateArg1]> points de fragment de clé. Après avoir déclenché la résistance à la mort, obtenez <WeaponEffect_Num:[StateArg2]> points de fragment de clé. Après avoir utilisé le Corps de Gnosis d'urgence, la limite d'Arithmetica augmente de 3 et le nombre de cartes piochées par tour augmente de 3."
  },
  State_49877_Desc = {
    Text = "Diminue la consommation de charge de la carte. Après avoir joué, pour chaque couche de distorsion, ajoute une carte de distorsion aléatoire à la main et retire cet état. Cet état sera conservé après la fin du combat"
  },
  State_49877_Name = {
    Text = "<AberrationKeywords:Aberration>"
  },
  State_49877_WeaponDesc = {
    Text = "Chaque niveau de ralentissement augmente la consommation en arithmetica des cartes de 1 point"
  },
  State_49954_Desc = {
    Text = "Les dégâts critiques de tous les éveillés sont réduits de moitié"
  },
  State_49954_Name = {
    Text = "<BlindingKeywords: cécité>"
  },
  State_49954_WeaponDesc = {
    Text = "Chaque niveau de ralentissement augmente la consommation en arithmetica des cartes de 1 point"
  },
  State_49957_Desc = {
    Text = "Lors de la réception de Dégâts Directs, scelle les Cartes d'Exaltation et d'instruction de l'Éveilleur attaquant pendant 1 tour, retire 1 charge de <ResentChainsKeywords:Chaîne de Rancœur>. Disparaît en fin de tour."
  },
  State_49957_Name = {
    Text = "<ResentChainsKeywords:Chaînes de rancune>"
  },
  State_49957_WeaponDesc = {
    Text = "Chaque niveau de ralentissement augmente la consommation en arithmetica des cartes de 1 point"
  },
  State_49958_Desc = {
    Text = "Lorsqu'il subit des Dégâts Directs ou des Dégâts des tentacules, scelle l'Exaltation et les Cartes d'instruction de l'Éveilleur attaquant pendant 1 tour, et retire 1 charge de <ResentChainsKeywords:Chaîne de Rancœur>."
  },
  State_49958_Name = {
    Text = "<ResentChainsKeywords1:Chaîne de Rancœur>"
  },
  State_49959_Desc = {
    Text = "Au début de chaque tour, gagnez 1 couche de <ResentChainsKeywords:Chaînes de Rancune>"
  },
  State_49959_Name = {
    Text = "Verrou multidimensionnel"
  },
  State_50010_Desc = {
    Text = "La régénération de vie reçue est réduite de 25 %. Suppression d'une couche à la fin du tour"
  },
  State_50010_Name = {
    Text = "<HeavyInjuryKeywords:Grave blessure>"
  },
  State_50021_Desc = {
    Text = "Équipe Unique : Après que le Porteur libère une Exaltation, il gagne une <PowerIconKeywords:Force> équivalant à <WeaponEffect_Num:[StateArg1]%> de son ATQ. Si le Royaume actuel est «Caro», après avoir libéré une Exaltation, la Fusion d'Embryon augmente de <WeaponEffect_Num:+[Blood:StateArg2]>."
  },
  State_50021_WeaponDesc = {
    Text = "Après que le Porteur libère une Exaltation, il gagne <WeaponEffect_Num:[Power:DescArg1]> points de <PowerIconKeywords:Force>. Si le Royaume actuel est «Caro», après avoir libéré une Exaltation, la Fusion d'Embryon augmente de <WeaponEffect_Num:+[Blood:StateArg2]>."
  },
  State_50302_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Résiste à une mort et détruit cette « Roue du Destin », obtient [StateArg1] charges de <PVPProtectiveKeywords:Barrière>. Si le Porteur est le seul allié survivant lorsque l'effet se déclenche, obtient [StateArg2] « Décret Clé » aléatoires au début du prochain tour."
  },
  State_50302_Name = {
    Text = "De la Nuit à l'Aube"
  },
  State_50323_Desc = {
    Text = "Avant le prochain tour, gagnez [Layer] ordres de clé aléatoires"
  },
  State_50323_Name = {
    Text = "Clé différée"
  },
  State_50333_Desc = {
    Text = "À la fin du tour, tous les éveilleurs perdent aliemus."
  },
  State_50333_Name = {
    Text = "<EmptinessKeywords:Vide>"
  },
  State_50333_WeaponDesc = {
    Text = "Chaque niveau de ralentissement augmente la consommation en arithmetica des cartes de 1 point"
  },
  State_50352_Name = {
    Text = "Téïs Demo"
  },
  State_50353_Name = {
    Text = "Téïs Demo"
  },
  State_50358_Desc = {
    Text = "Les dégâts reçus sont réduits, chaque couche réduit de 1 %. Suppression de cet état après la mort d'un autre allié"
  },
  State_50358_Name = {
    Text = "<ConcealmentKeywords:cacher>"
  },
  State_50375_Desc = {
    Text = "Ces effets comprennent : gagner 10 points de aliemus pour soi-même, 5 points de aliemus pour d'autres alliés, appliquer 1 couche de vulnérabilité à tous les ennemis, appliquer 1 couche de faiblesse à tous les ennemis, tirer 1 carte et gagner 200 points de s-énergie"
  },
  State_50375_Name = {
    Text = "<MysterybuffKeywords:Effet positif mystérieux>"
  },
  State_50389_Desc = {
    Text = "Au début du tour, mettre 1 \"dé de chance de Ryker\" dans la main"
  },
  State_50389_Name = {
    Text = "Soutien de Lek"
  },
  State_50390_Desc = {
    Text = "Au début du tour, gagnez [StateArg1] points de force"
  },
  State_50390_Name = {
    Text = "Connaissance du champ de bataille"
  },
  State_50491_Name = {
    Text = "Pendule temporel « Équilibre »"
  },
  State_50735_Desc = {
    Text = "Lorsque le premier est sur le point d'être vaincu, restaurez la vie et changez l'intention en \"déchirer la peine\", infligeant des dégâts exceptionnels"
  },
  State_50735_Name = {
    Text = "Résilience inutile"
  },
  State_50854_Desc = {
    Text = "Au début du combat, obtenez [StateArg1] points <RetaliateIconKeywords:répoindre>. À la fin du tour, obtenez [StateArg2] points de bouclier, augmentant chaque tour de [StateArg3]"
  },
  State_50854_Name = {
    Text = "Écorce robuste"
  },
  State_50861_Desc = {
    Text = "Préparez-vous à libérer la \"Mère des Mille Descendants\" sans subir de dégâts"
  },
  State_50861_Name = {Text = "Dérivé"},
  State_50862_Desc = {
    Text = "Préparez-vous à libérer la \"Reproduction\" sans subir de dégâts"
  },
  State_50862_Name = {Text = "Incubation"},
  State_50863_Desc = {
    Text = "Préparez-vous à libérer la \"Sève Sauvage\" sans subir de dégâts"
  },
  State_50863_Name = {Text = "Immunité"},
  State_50864_Desc = {
    Text = "Préparez-vous à libérer la \"Sève d'Arbre\" sans subir de dégâts"
  },
  State_50864_Name = {Text = "Immunité"},
  State_50891_Desc = {
    Text = "Préparez-vous à libérer la \"Fusion Multiple\" sans subir de dégâts"
  },
  State_50891_Name = {Text = "Dévorer"},
  State_51016_Desc = {
    Text = "Les effets de poison reçus deviennent 1000 %"
  },
  State_51016_Name = {
    Text = "Bois flétri"
  },
  State_51017_Desc = {
    Text = "Les effets de poison reçus deviennent 500 %"
  },
  State_51017_Name = {
    Text = "Bois flétri"
  },
  State_51607_Desc = {
    Text = "Immunité à tous les dégâts, retirée au début du tour"
  },
  State_51607_Name = {
    Text = "Immunité aux dégâts"
  },
  State_51695_Desc = {
    Text = "Cet éveilleur n'est pas encore éveillé... Il s'éveillera lorsqu'il sera sur le point d'être abattu, restaurera sa vie et commencera à se battre sous sa véritable forme"
  },
  State_51695_Name = {
    Text = "Non Réveillé"
  },
  State_51696_Desc = {
    Text = "\"L'Apôtre de la Mer\" s'est éveillé, avec une résistance plus forte à l'Exalter."
  },
  State_51696_Name = {
    Text = "Miriame Éveil!"
  },
  State_51696_WeaponDesc = {
    Text = "Au début du prochain tour, obtenez un bouclier équivalent à la vie perdue au tour précédent"
  },
  State_51739_Desc = {
    Text = "À la fin du tour, obtenez aléatoirement 1 « Fantasme du Royaume divin » qui ne peut pas être dissipé."
  },
  State_51739_Name = {
    Text = "Fin de la Foi"
  },
  State_51740_Desc = {
    Text = "Au début de la bataille, placez 1 carte « obsession » dans votre main"
  },
  State_51740_Name = {
    Text = "Dévouement Indestructible"
  },
  State_51741_Desc = {
    Text = "Au début du tour, obtenez [Layer] points de bouclier. Ce bouclier ne peut pas être dissipé."
  },
  State_51741_Name = {
    Text = "Reste fidèle à toi-même"
  },
  State_51742_Desc = {
    Text = "Au début du tour, obtenez [Layer] points de dégâts de tentacule et de force. Cet effet ne peut pas être dissipé."
  },
  State_51742_Name = {
    Text = "Consacrer la Révélation"
  },
  State_51743_Desc = {
    Text = "Dans ce tour, à chaque attaque d'un tentacule, obtenez les effets suivants en fonction de la posture du tentacule : Marée Montante : tous les Éveilleurs gagnent <Energy:[Energy:StateArg1]> points de fureur ; Océan Calme : inflige [StateArg2] points de <IntoxicationIconKeywords:poison> à tous les ennemis ; Vagues Déchaînées : <TentacleInjurieIconKeywords:dégâts de tentacule> temporaires +[StateArg3]."
  },
  State_51743_Name = {
    Text = "Bénédiction de la Mère Déesse"
  },
  State_51745_Desc = {
    Text = "Quand l'Apôtre de la mer joue 1 carte, il génère [StateArg1] tentacules temporaires, ignorant la limite de tentacules"
  },
  State_51745_Name = {
    Text = "Pouvoir délégué"
  },
  State_51745_WeaponDesc = {
    Text = "Quand l'Apôtre de la mer joue 1 carte, il génère [StateArg1] tentacules temporaires, ignorant la limite de tentacules"
  },
  State_51811_Name = {
    Text = "Effet de soin de la Voile de guidage"
  },
  State_51813_Desc = {
    Text = "Après la fin du tour, la consommation d'arsenal est de -[Layer], cet effet sera également déclenché après avoir été abandonné"
  },
  State_51813_Name = {
    Text = "<PrepareKeypvewordscolour:préparer[Layer]>"
  },
  State_51820_Desc = {
    Text = "\"Gestation\" acquiert un effet supplémentaire : à 5 empilements, invoquez instantanément 1 \"Enfant de l'Eau\", jusqu'à un maximum de 2 \"Enfants de l'Eau\"."
  },
  State_51820_Name = {
    Text = "Miriame Éveil"
  },
  State_51822_Desc = {
    Text = "Chaque fois que la colère est déchaînée, augmente de 1 couche de « Gestation », chaque couche de gestation accorde [StateArg1] points de pouvoir, avec un maximum de 5 couches"
  },
  State_51822_Name = {
    Text = "La Descente Finale de Lémuria"
  },
  State_52068_Desc = {
    Text = "Transformez jusqu'à 3 cartes \"Rituel\" en \"Obsession\", obtenez des effets supplémentaires selon le nombre transformé"
  },
  State_52068_Name = {
    Text = "<CardKeyWord:Rituel>"
  },
  State_52087_Desc = {
    Text = "\"L'Oiseau de Béatitude Immortelle\" ne peut appliquer à nouveau l'état de renaissance après [Layer] tours"
  },
  State_52087_Name = {
    Text = "Temps de recharge de la résurrection"
  },
  State_52116_Desc = {
    Text = "Avant la fin du tour, cet éveilleur subit des dégâts de [Layer] après avoir utilisé exalt."
  },
  State_52116_Name = {
    Text = "Confinement"
  },
  State_52369_Desc = {
    Text = "Après avoir joué [DescArg1] cartes de symptôme, recevez la carte de soutien de Tulu « Royauté » : infligez d'énormes dégâts et plongez la cible dans l'évanouissement pendant 1 tour"
  },
  State_52369_Name = {
    Text = "Le Pays des dieux reviendra certainement"
  },
  State_53115_Desc = {
    Text = "Les effets du « rituel » de la prochaine activation de Myriam pendant ce tour augmentent de 50 %"
  },
  State_53115_Name = {
    Text = "Prie l'Abîme"
  },
  State_53144_Desc = {
    Text = "Au début de chaque tour, gagnez <Block:[Block:StateArg1]> points de bouclier"
  },
  State_53144_Name = {
    Text = "<CardKeyWord:Maintien de soi>"
  },
  State_53145_Desc = {
    Text = "Au début de chaque tour, <PowerIconKeywords:pouvoir> et <TentacleInjurieIconKeywords:dégâts de tentacule> +[StateArg2]"
  },
  State_53145_Name = {
    Text = "<CardKeyWord:Dévouement à l'apocalypse>"
  },
  State_53673_Desc = {
    Text = "Le nombre maximum de divisions glandulaires est de 10"
  },
  State_53673_Name = {
    Text = "Limite de division glandulaire"
  },
  State_53674_Desc = {
    Text = "Limite de cartes à main +2. Au début du tour, Miryam reçoit 20 points de aliemus"
  },
  State_53674_Name = {
    Text = "Miriame Playtest"
  },
  State_53755_Desc = {
    Text = "Tous les réveilleurs appliquent <PowerIconKeywords:pouvoir>, <RetaliateIconKeywords:comptoir>, <IntoxicationIconKeywords:poison> augmentant de [DescArg1]%. « Écrits flamboyants » augmentant le <PowerIconKeywords:pouvoir>"
  },
  State_53755_Name = {
    Text = "Poème mystérieux·peur"
  },
  State_53756_Desc = {
    Text = "La folie causée par tous les réveilleurs augmente de [DescArg1]%, la capacité d'arithmetica et de carte de commandement peuvent être conservées jusqu'au prochain tour à la fin du tour. La folie causée par « Écrits flamboyants » augmente"
  },
  State_53756_Name = {
    Text = "Poème fantomal·joie"
  },
  State_53758_Desc = {
    Text = "Les dégâts finaux causés par tous les réveilleurs augmentent de [DescArg1]%, augmentant le taux critique et les dégâts critiques de « Écrits flamboyants »"
  },
  State_53758_Name = {
    Text = "Poème de rêverie: Colère"
  },
  State_53759_Desc = {
    Text = "Tous les Réveillés augmentent l'effet de bouclier et de régénération de vie, et la diminution de <PowerIconKeywords:force> de [DescArg1]%. La régénération de \"Fleurs de l'éphémère\" augmente"
  },
  State_53759_Name = {
    Text = "Poème de deuil · Deuil"
  },
  State_53772_Name = {
    Text = "Paradoxe de l'accessoire"
  },
  State_53772_WeaponDesc = {
    Text = "Après que l'équipement a utilisé l'exaltation, l'équipe reçoit <RetaliateIconKeywords:comptoir> égal à 100 % de la défense de l'équipement. Et augmente le<RetaliateIconKeywords:comptoir> actuel de 10 %"
  },
  State_53870_Name = {
    Text = "Anneau de la salle 36"
  },
  State_53870_WeaponDesc = {
    Text = "Lorsque vous tirez la carte du porteur, son coût d'arithmetica variera entre 0 et 3"
  },
  State_53981_Name = {
    Text = "Correction du sigil noir pour rêve d'ornementée"
  },
  State_53981_WeaponDesc = {
    Text = "Après le début du combat, une suite de cartes du porteur est mélangée dans la pile de pige"
  },
  State_54002_Name = {
    Text = "État@Accessoire: Marque de sélection du rêve médicinal"
  },
  State_54002_WeaponDesc = {
    Text = "Après que l'équipement a utilisé l'exaltation, l'équipe reçoit <RetaliateIconKeywords:comptoir> égal à 100 % de la défense de l'équipement. Et augmente le<RetaliateIconKeywords:comptoir> actuel de 10 %"
  },
  State_54011_Name = {
    Text = "État@Accessoire: Copie du rêve médicinal 1 disponible"
  },
  State_54011_WeaponDesc = {
    Text = "Après que l'équipement a utilisé l'exaltation, l'équipe reçoit <RetaliateIconKeywords:comptoir> égal à 100 % de la défense de l'équipement. Et augmente le<RetaliateIconKeywords:comptoir> actuel de 10 %"
  },
  State_54012_Name = {
    Text = "État@Accessoire: Copie du rêve médicinal 2 disponible"
  },
  State_54012_WeaponDesc = {
    Text = "Après que l'équipement a utilisé l'exaltation, l'équipe reçoit <RetaliateIconKeywords:comptoir> égal à 100 % de la défense de l'équipement. Et augmente le<RetaliateIconKeywords:comptoir> actuel de 10 %"
  },
  State_54013_Desc = {
    Text = "Ce tour, maîtrise des domaines augmentée de [Layer]"
  },
  State_54013_Name = {
    Text = "Maîtrise temporaire du domaine"
  },
  State_54014_Desc = {
    Text = "Maîtrise des domaines augmentée de [Layer]"
  },
  State_54014_Name = {
    Text = "Maîtrise de Royaume"
  },
  State_54043_WeaponDesc = {
    Text = "Après avoir utilisé l'exaltation, les boucliers et les soins de l'équipement doublent pour ce tour"
  },
  State_54044_Desc = {
    Text = "Inflige le double de Dommages et gagne en plus 600% de Fragment de clé égal à la Régénération de Fragment de clé de Ramona : Vétuste, mais <DepleteIconKeywords:Épuise> après avoir été jouée."
  },
  State_54044_Name = {
    Text = "Avenir célébré"
  },
  State_54045_Desc = {
    Text = "Gagnez 3 points d'arthmetica"
  },
  State_54045_Name = {
    Text = "Jardin du cycle"
  },
  State_54046_Desc = {
    Text = "Au début du tour, récupérez [StateArg1] points de vie, pendant [Layer] tours"
  },
  State_54046_Name = {
    Text = "Raison, Vérité et Réalité"
  },
  State_54071_Desc = {
    Text = "Le nombre de Dégâts Directs d'Ogier +1, durant [Layer] <plural value=\"[Layer]\" singular=\"tour\" plural=\"tours\">."
  },
  State_54071_Name = {
    Text = "Sept Arts, Huit Vertus"
  },
  State_54121_Desc = {
    Text = "Dans cette Bataille, les Dégâts de base infligés par la 'Bête du chaos' sont augmentés de [Layer]%."
  },
  State_54121_Name = {
    Text = "Bête du Chaos"
  },
  State_54138_Desc = {
    Text = "La carte de commandement envoyée par Sorel a effet 2 fois"
  },
  State_54138_Name = {
    Text = "Danse de la soif du pouvoir"
  },
  State_54384_Desc = {
    Text = "Augmente les <IntoxicationIconKeywords:poison> causés par Nymphaea de 50%, pendant [Layer] tours"
  },
  State_54384_Name = {
    Text = "Cérémonie funéraire de soi-même"
  },
  State_54416_Desc = {
    Text = "Débloquer la Surcharge de fureur explosive permet d'accumuler deux fois la jauge d'Aliemus. Lorsque la jauge est complètement remplie une deuxième fois, la compétence est améliorée en Surcharge de fureur explosive, ajoutant de puissants effets supplémentaires. Lâcher une Exaltation normale consommera en plus 50 % de l'Aliemus excédentaire."
  },
  State_54416_Name = {
    Text = "<OverLimitUtlSkillKeywords:surexaltation>"
  },
  State_54416_WeaponDesc = {
    Text = "Consomme l'embryon dans la main pour déclencher un puissant effet de dévoration"
  },
  State_54561_Desc = {
    Text = "Unique à l'équipe : Augmente les dégâts de l'équipé de <WeaponEffect_Num:[StateArg1]%> de son attaque. Si le domaine actuel est \"Chair\", chaque effet de dévoration augmente les dégâts de l'équipé de 3% de son attaque"
  },
  State_54561_WeaponDesc = {
    Text = "Les dégâts infligés par l'équipier augmentent de [DescArg1]. Si le domaine actuel est « Chair », chaque fois que l'effet Dévorer est déclenché, les dégâts infligés par l'équipier augmentent en outre de [DescArg2]."
  },
  State_54568_Name = {
    Text = "jusqu'à la fin de la planète"
  },
  State_54597_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Après la mort d'un Corps éveillé ennemi, obtenez [StateArg1] <StrongEffectKeywords:Amplification>, et placez dans votre main leur « compétence » ayant le Coût d'Arithmetica le plus élevé avec <PVPVoidKeywords:Vide>."
  },
  State_54597_Name = {
    Text = "Un Million de Regards Aimants"
  },
  State_54704_Desc = {
    Text = "\"La prochaine carte de commandement de '24' prend effet 3 fois.\""
  },
  State_54704_Name = {
    Text = "Banquet de cadavres déformés"
  },
  State_54798_Desc = {
    Text = "Les effets de bouclier, de guérison et de réduction de force de tous les éveilleurs sont augmentés de [StateArg1]%, et les effets de guérison des chapitres resplendissants sont augmentés."
  },
  State_54798_Name = {Text = "« Ai »"},
  State_54799_Desc = {
    Text = "Les effets de contre-attaque, de poison et d'acquisition de force de tous les éveilleurs sont augmentés de [StateArg1]%. La force des chapitres resplendissants est augmentée."
  },
  State_54799_Name = {Text = "Peur"},
  State_54800_Desc = {
    Text = "Les dégâts finaux causés par tous les réveilleurs augmentent de [StateArg1]%, et le taux critique et les dégâts critiques du chapitre brillant augmentent"
  },
  State_54800_Name = {
    Text = "« Colère »"
  },
  State_55108_Desc = {
    Text = "Au début du tour, améliorez « Flamme verte » ou « Flamme verte corrompue » en « Flamme verte mortelle » pour [Layer] tours"
  },
  State_55108_Name = {
    Text = "Mort imminente"
  },
  State_55108_WeaponDesc = {
    Text = "Au début du tour, si dans la main ou l'ultra, un renforcement sera obtenu"
  },
  State_55113_Desc = {
    Text = "Après avoir joué la première carte de poème à chaque tour, Horla gagne 10 points d'aliemus"
  },
  State_55113_Name = {
    Text = "Rencontre à nouveau de Fleur et Poème"
  },
  State_55465_Name = {
    Text = "Consomme [Layer] couches de métaphore \"Colère\", inflige [DescArg1] dégâts supplémentaires"
  },
  State_55466_Name = {
    Text = "Consomme [Layer] couches de métaphore \"Tristesse\", restaure <Heal:[Heal:DescArg1]> points de vie"
  },
  State_55467_Name = {
    Text = "Consomme [Layer] couches de métaphore \"Peur\", obtient [Power:DescArg1] points de <PowerIconKeywords:force> supplémentaires"
  },
  State_55469_Name = {
    Text = "Consomme [Layer] couches de métaphore \"Joie\", obtient <Energy:[Energy:DescArg1]> points de folie supplémentaires"
  },
  State_55470_Name = {
    Text = "Coup de cou"
  },
  State_55485_Desc = {
    Text = "Les [Layer] prochaines cartes jouées par Casiah gagnent une Force égale à 10% de son Attaque."
  },
  State_55485_Name = {
    Text = "S'amuser à en perdre haleine"
  },
  State_55486_Name = {
    Text = "L'explosion de limite dans la ville des rêves morts exonère la consommation de rêve"
  },
  State_55487_Desc = {
    Text = "Le « frappe » d'Erica inflige 2 dégâts supplémentaires, la « défense » obtient 2 boucliers supplémentaires, durant [Layer] tours"
  },
  State_55487_Name = {
    Text = "Calcul multiple"
  },
  State_55489_Name = {
    Text = "Transposition temporelle"
  },
  State_55806_Name = {
    Text = "<PoetryKeywords:Offrande divine> : Accorde à tous les ennemis un <PVPWonderfulEffectKeywords:Effet Étrange> négatif ou accorde à tous les alliés un <PVPWonderfulEffectKeywords:Effet Étrange> positif ou pioche 1 carte et obtient 1 Arithmetica. La dernière Offrande divine prend effet 2 fois"
  },
  State_55807_Name = {
    Text = "Piochez 1 carte, obtenez 1 arithmetica"
  },
  State_55808_Name = {
    Text = "<PoetryKeywords:offering>: Accordez à tous les alliés un <PVPWonderfulEffectKeywords:effet merveilleux> positif ou piochez 1 carte et gagnez 1 arithmétique. La dernière offrande prend effet 2 fois"
  },
  State_55809_Name = {
    Text = "Donner à tous les ennemis un <PVPWonderfulEffectKeywords:effet merveilleux> négatif"
  },
  State_55811_Desc = {
    Text = ": Choisissez une option parmi celles listées"
  },
  State_55811_Name = {
    Text = "<ComaColour:Choix>"
  },
  State_55813_Name = {
    Text = "<PoetryKeywords:offering>: Accordez à tous les ennemis un <PVPWonderfulEffectKeywords:effet merveilleux> négatif ou piochez 1 carte et gagnez 1 arithmétique. La dernière offrande prend effet 2 fois"
  },
  State_55814_Name = {
    Text = "<PoetryKeywords:offering>: Accordez à tous les ennemis un <PVPWonderfulEffectKeywords:effet merveilleux> négatif ou accordez à tous les alliés un <PVPWonderfulEffectKeywords:effet merveilleux> positif. La dernière offrande prend effet 2 fois"
  },
  State_55816_Name = {
    Text = "Donner à tous les alliés un <PVPWonderfulEffectKeywords:effet merveilleux> positif"
  },
  State_55824_Desc = {
    Text = ": Choisissez une option parmi celles listées, puis retirez-la. Si des options restent, placez cette carte dans la main de l'adversaire"
  },
  State_55824_Name = {
    Text = "<ComaColour:offrande>"
  },
  State_55836_Desc = {
    Text = "À la fin du tour, la consommation d'arsenal des cartes de commande de l'horla dans la main est -1"
  },
  State_55836_Name = {
    Text = "Encre Poétique"
  },
  State_55839_Desc = {
    Text = "Lors de la collecte, perdre toutes les autres reliques et obtenir aléatoirement 2 reliques en or"
  },
  State_55866_Desc = {
    Text = "Unique dans l'équipe : Pioche 1 carte de commande de l'équipier au début du combat, avec une probabilité de <WeaponEffect_Num:[StateArg1]%> de réduire la consommation d'arithmetica de 1. Chaque fois qu'une résistance à la mort se déclenche, cet effet se déclenche à nouveau une fois"
  },
  State_55866_WeaponDesc = {
    Text = "Piochez 1 carte de commandement de l'équipier au début du combat, avec une probabilité de <WeaponEffect_Num:[StateArg1]%> de réduire sa consommation d'arithmétique de 1. Chaque fois qu'une résistance à la mort se déclenche, cet effet se déclenche à nouveau une fois."
  },
  State_55992_Desc = {
    Text = "Lorsque l'arethmetica est insuffisante, des épuisements et des marques seront appliqués sur les cartes"
  },
  State_55992_Name = {Text = "Cendre"},
  State_55993_Name = {
    Text = "Marque de braise"
  },
  State_56018_Desc = {
    Text = "Dans ce combat, la santé maximale augmente de [Layer] %"
  },
  State_56018_Name = {
    Text = "La faveur de la muse - Destin"
  },
  State_56020_Desc = {
    Text = "Dans ce combat, les dégâts augmentent de [Layer] %"
  },
  State_56020_Name = {
    Text = "La faveur de la muse - Force"
  },
  State_56030_Desc = {
    Text = "Les boucliers et soins causés par le réveilleur pendant ce tour augmentent de [Layer] %"
  },
  State_56030_Name = {Text = "Neige"},
  State_56031_Desc = {
    Text = "Ce tour, chaque fois que des dégâts sont infligés, le taux critique temporaire +[Layer] %"
  },
  State_56031_Name = {Text = "Papillon"},
  State_56034_Desc = {
    Text = "Chaque type de « métaphore » peut atteindre un maximum de 3 niveaux. Différentes « métaphores » amplifient les différents effets des poèmes : \n<D06CardKeyWordnu:Poème Frénétique> : consomme toutes les métaphores « Colère », chaque niveau de métaphore inflige 2 fois plus de dégâts. \n<D06CardKeyWordai:Poème de deuil> : consomme toutes les métaphores « Ai », chaque niveau de métaphore régénère des PV supplémentaires. \n<D06CardKeyWordxi:Poème d'illusion> : consomme toutes les métaphores « Joie », chaque niveau de métaphore génère 10 points de folie supplémentaires. \n<D06CardKeyWordju:Poème étrange> : consomme toutes les métaphores « Peur », chaque niveau de métaphore obtient <PowerIconKeywords:Force> supplémentaires."
  },
  State_56034_Name = {Text = "Métaphore"},
  State_56208_Desc = {
    Text = "Chant de la Pluie : Récupère <Heal:[DescArg1]> PV.\nChant du vent : Gagne [DescArg2] <PowerIconKeywords:Force>.\nHymne aux Fleurs : Accorde <Energy:10> Aliemus à tous les Corps éveillés.\nChant Lunaire : Taux Critique +30% ce tour."
  },
  State_56208_Name = {
    Text = "Page de poème"
  },
  State_56330_Desc = {
    Text = "Obtenez [DescArg1] points de bouclier. Si vous avez libéré 3 fois aliemus dans ce tour, cette carte prend effet une fois supplémentaire"
  },
  State_56330_Name = {
    Text = "Imagerie avancée"
  },
  State_56331_Desc = {
    Text = "Choisissez une carte de commandement parmi la pile de tirage et la pile de défausse et placez-la dans votre main, réduisant son coût en arithmétique de -2"
  },
  State_56331_Name = {
    Text = "Imagerie avancée"
  },
  State_56332_Desc = {
    Text = "Obtenez [DescArg1] points temporaires de <PowerIconKeywords:pouvoir>. Après activation, chaque blessure en ce tour ajoute +3% taux critique temporaire"
  },
  State_56332_Name = {
    Text = "Imagerie avancée"
  },
  State_56333_Desc = {
    Text = "Récupérez 10% de la vie perdue. Si la vie actuelle est inférieure à 25%, cette carte s'applique une fois de plus"
  },
  State_56333_Name = {
    Text = "Imagerie avancée"
  },
  State_56334_Desc = {
    Text = "Le prochain ordre de clé s'active 2 fois"
  },
  State_56334_Name = {
    Text = "Imagerie avancée"
  },
  State_56335_Desc = {
    Text = "Inflige des <FixedDamage:DGT Purs> égaux à 150% des PV Max, bénéficiant d'un bonus de <PowerIconKeywords:STR> ×10."
  },
  State_56335_Name = {
    Text = "Imagerie avancée"
  },
  State_56336_Desc = {
    Text = "Pioche 5 cartes"
  },
  State_56336_Name = {
    Text = "Imagerie avancée"
  },
  State_56337_Desc = {
    Text = "Obtenez [DescArg1] points temporaires de <AlertIconKeywords:alerte>. Après activation, les boucliers et la guérison de ce tour augmentent de [DescArg2]%"
  },
  State_56337_Name = {
    Text = "Imagerie avancée"
  },
  State_56338_Desc = {
    Text = "Gagnez 3 points d'arthmetica"
  },
  State_56338_Name = {
    Text = "Imagerie avancée"
  },
  State_56339_Desc = {
    Text = "Dissipe un état négatif aléatoire. Cette carte prend effet 3 fois supplémentaires, consommation"
  },
  State_56339_Name = {
    Text = "Imagerie avancée"
  },
  State_56340_Desc = {
    Text = "Applique 3 tours <VulnerabilityIconKeywords:vulnérable> à tous les ennemis. Chaque fois qu'un ennemi meurt, ajoute cette carte de la pile à ta main"
  },
  State_56340_Name = {
    Text = "Imagerie avancée"
  },
  State_56341_Desc = {
    Text = "Maîtrise des domaines +25, Maîtrise des domaines temporaire +125"
  },
  State_56341_Name = {
    Text = "Imagerie avancée"
  },
  State_56342_Desc = {
    Text = "Tous les éveillés gagnent 15 points de folie"
  },
  State_56342_Name = {
    Text = "Imagerie avancée"
  },
  State_56343_Desc = {
    Text = "Applique 3 tours <WeaknessIconKeywords:faiblesse> à tous les ennemis, mets une copie de cette carte dans la pile de défausse, avec <DepleteIconKeywords:épuiser>, <NothingnessIconKeywords:illusion>"
  },
  State_56343_Name = {
    Text = "Imagerie avancée"
  },
  State_56372_Desc = {
    Text = "À la mort, supprime le dernier état négatif acquis par le joueur"
  },
  State_56372_Name = {
    Text = "Fleur et Poème"
  },
  State_56400_Desc = {
    Text = "Après un « Coup », les « Compétences » de votre main se transformeront successivement en d'autres « Compétences » [ShowIfState:, <CardKeyWord:<SkillName3:>>→<CardKeyWord:<SkillName2:>>→<CardKeyWord:<SkillName1:>>→<CardKeyWord:<SkillName3:>>]."
  },
  State_56400_Name = {
    Text = "Fleurs et Poèmes du Passé"
  },
  State_56402_Desc = {
    Text = "Possède des métaphores<D06CardKeyWordnu:« Colère »> [DescArg2] niveaux : lorsque le « Poème Frénétique » déclenche un saut quantique, il infligera des dommages supplémentaires. \n Possède des métaphores<D06CardKeyWordai:« Ai »> [DescArg3] niveaux : lorsque le « Poème de deuil » déclenche un saut quantique, il régénérera des PV supplémentaires. \n Possède des métaphores<D06CardKeyWordxi:« Joie »> [DescArg1] niveaux : lorsque le « Poème d'illusion » déclenche un saut quantique, il fera gagner de la fureur aux éveilleurs. \n Possède des métaphores<D06CardKeyWordju:« Peur »> [DescArg4] niveaux : lorsque le « Poème étrange » déclenche un saut quantique, il gagnera de la force supplémentaire."
  },
  State_56402_Name = {Text = "Métaphore"},
  State_57166_Desc = {
    Text = "Les dégâts de l'éveil augmentent de 25 %"
  },
  State_57170_Desc = {
    Text = "Limite de cartes à main +2, à la fin du tour choisissez 1 carte de votre main pour qu'elle soit conservée et réduisez son coût en arithmetica de -1, pendant 3 tours"
  },
  State_57170_Name = {
    Text = "Lumière Égarée"
  },
  State_57316_Desc = {
    Text = "Au début de chaque tour, transforme 1 carte «Embryon» en «Fils de la sainteté» ; s'il n'y a pas d'«Embryon», <EmbryoFusionIconKeywords:Fusion d'Embryon> +[Blood:DescArg1], sans être affecté par les effets d'augmentation de la Fusion d'Embryon. Maintenu [Layer] tours."
  },
  State_57316_Name = {
    Text = "Héritage des reliques sacrées perpétuelles"
  },
  State_57317_Desc = {
    Text = "Lorsque cette roue du destin est dans le deck, vous pourrez voir les changements imminents des compétences en main."
  },
  State_57317_Name = {
    Text = "<PVPFlowerKeywords:Fleurs et poèmes du Passé>"
  },
  State_57324_Desc = {
    Text = "Si ce Réveilleur déclenche \"Fleurs et Poèmes du Passé\", cette carte se transforme en <CardKeyWord:<SkillName1:>>."
  },
  State_57324_Name = {
    Text = "Fleurs et Poèmes du Passé"
  },
  State_57325_Desc = {
    Text = "Si ce Réveilleur déclenche \"Fleurs et Poèmes du Passé\", cette carte se transforme en <CardKeyWord:<SkillName2:>>."
  },
  State_57325_Name = {
    Text = "Fleurs et Poèmes du Passé"
  },
  State_57326_Desc = {
    Text = "Si ce Réveilleur déclenche \"Fleurs et Poèmes du Passé\", cette carte se transforme en <CardKeyWord:<SkillName3:>>."
  },
  State_57326_Name = {
    Text = "Fleurs et Poèmes du Passé"
  },
  State_57335_Name = {
    Text = "Les dégâts de cette carte bénéficient d'un bonus de force de [DescArg1] fois"
  },
  State_57356_Name = {
    Text = "État@habitants des abîmes comptoir calcul"
  },
  State_57368_Name = {
    Text = "État@habitants des abîmes comptoir pont"
  },
  State_57413_Name = {
    Text = "Chaque point de bouclier augmente les dégâts de cette carte de [DescArg1] points"
  },
  State_57417_Desc = {
    Text = "Chaque fois que la résistance à la mort est déclenchée, infligez des dégâts fixes de 100 % en contre-attaque ; dans ce combat, à chaque fois que la résistance à la mort est déclenchée, les dégâts fixes augmentent de 25 %"
  },
  State_57417_Name = {
    Text = "Berceau de l'amour"
  },
  State_57566_Name = {
    Text = "Survivre dans l'adversité"
  },
  State_57587_Desc = {
    Text = "Lorsque vous jouez \"Division des Glandes\", piochez 1 carte, avec [Layer] utilisations restantes."
  },
  State_57587_Name = {
    Text = "méduses réunies!"
  },
  State_57665_Name = {
    Text = "Protection de la mère divine"
  },
  State_57728_Desc = {
    Text = "Le nombre de dégâts d'uvhash augmente de 1"
  },
  State_57728_Name = {
    Text = "Don de la Blood Surge"
  },
  State_57751_Desc = {
    Text = "Équipe unique : le bouclier causé par l'équipé augmente de <WeaponEffect_Num:[StateArg1]%. Après avoir libéré le décret clé, tous les Éveilleurs obtiennent <WeaponEffect_Num:[StateArg2]%> de taux critique temporaire et de dégâts critiques, mais un sacrifice équivalent à 3% de la vie maximale est ajouté. Si le royaume actuel est « Aequor », après avoir libéré le décret clé, les dégâts des tentacules augmentent également de <WeaponEffect_Num:[StateArg3]%> de l'Attaque du porteur."
  },
  State_57751_WeaponDesc = {
    Text = "Le bouclier causé par le porteur augmente de <WeaponEffect_Num:[StateArg1] %>. Après avoir libéré le décret clé, tous les Éveilleurs obtiennent <WeaponEffect_Num:[StateArg2] %> de taux critique temporaire et de dégâts critiques, mais reçoivent [DescArg1] points de sacrifice. Si le royaume actuel est « Aequor », libérer le décret clé augmentera également les dégâts des tentacules de [DescArg2] points."
  },
  State_57753_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin>: Obtenez [StateArg1] couches de <PVPSleepKeywords:Sieste de Qualité> lorsque équipé."
  },
  State_57753_Name = {
    Text = "Sommeil sous le Glacier"
  },
  State_57766_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin>: Après le premier « Exalt » à chaque tour, gagnez <StrongEffectKeywords:Amplification> temporaire +[StateArg1]."
  },
  State_57766_Name = {
    Text = "Bâton du berger"
  },
  State_57767_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : À la fin du tour, retirez <Energy:[Energy:StateArg1]> folie pour la convertir en <PVPDerivativeCardKeywords_12:« Petit Vœu »>. Si la conversion échoue, obtenez <Energy:[Energy:StateArg2]> folie."
  },
  State_57767_Name = {
    Text = "Présentation qui ne s'arrête jamais"
  },
  State_57768_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Les dégâts de « Compétence » augmentent de [StateArg1] %. Après « Exaltation », restaurez [StateArg2] % des PV perdus."
  },
  State_57768_Name = {
    Text = "Jusqu'à la fusion de la montagne neigeuse"
  },
  State_57769_Desc = {
    Text = "<PVPWeaponKeywords:roue du destin> : Après que l'équipier ait joué une carte de compétence, piochez 1 carte de compétence de l'équipier, effet limité à 1 fois par tour."
  },
  State_57769_Name = {
    Text = "Porte de la Vérité"
  },
  State_57770_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : L'Effet de Dommages, de soins et de Bouclier infligés par les «compétences» augmente de [StateArg1]~[StateArg2]% (actuellement [Layer] %), <PhantomKeywords:Illusion>."
  },
  State_57770_Name = {
    Text = "Roulette du Destin"
  },
  State_57814_Name = {
    Text = "Lorsque ce marqueur est présent, cela indique que la Roue du Destin est en cours de changement. Certaines logiques nécessiteront la reconnaissance de ce marqueur."
  },
  State_57817_Desc = {
    Text = "Ne peut pas agir. À la fin du tour, les piles - 1. Une fois les piles épuisées, <StrongEffectKeywords:Amplification> +5. Ne peut pas être dissipé. Changer la Roue du Destin supprimera l'état Nap de qualité."
  },
  State_57817_Name = {
    Text = "Sommeil raffiné"
  },
  State_57854_Desc = {
    Text = "Au début du tour, obtenez [StateArg1] points de bouclier et [StateArg2] points de dégâts de tentacule, générez 2 tentacules temporaires, pendant [Layer] tours."
  },
  State_57854_Name = {
    Text = "Vœu de liberté"
  },
  State_57854_WeaponDesc = {
    Text = "État@Dame des profondeurs: Thé et gâteau"
  },
  State_57864_Name = {
    Text = "Bonus de puissance rafraîchissant __ \"Pour usage de développement uniquement\""
  },
  State_57942_Desc = {
    Text = "Fusion actuelle [Layer]%. À 100%, l'ennemi passe de force à la phase suivante avec des compétences plus puissantes"
  },
  State_57942_Name = {Text = "Fusion"},
  State_57952_Desc = {
    Text = "Lorsque la force est réduite, seules 50 % des couches de force sont diminuées"
  },
  State_57952_Name = {
    Text = "Plongée en eaux profondes"
  },
  State_57953_Desc = {
    Text = "À la fin du tour, générer 1 tentacule. Retirer cet état après le réveil"
  },
  State_57953_Name = {Text = "Sommeil"},
  State_57955_Desc = {
    Text = "Les dégâts infligés par Helot augmentent de [StateArg1] %, pendant [Layer] tours."
  },
  State_57955_Name = {
    Text = "Survivre dans l'adversité·Dommages"
  },
  State_57968_Desc = {
    Text = "Sous l'influence de juliette, à la fin de chaque tour, le taux de fusion des jumeaux augmente de 10 %, et une carte « déformation » est mélangée dans la pile de cartes"
  },
  State_57968_Name = {
    Text = "« Chant d'Yuliette »"
  },
  State_57970_Name = {
    Text = "Protection de la mère divine"
  },
  State_57976_Desc = {
    Text = "«Fils des Ténèbres» effectue une Fusion forcée, infligeant des dégâts fixes égaux à 3 fois ses PV actuels à «Début de l'oubli»."
  },
  State_57976_Name = {Text = "Sacrifice"},
  State_58051_Desc = {
    Text = "Dégâts critiques +[Layer] %"
  },
  State_58051_Name = {
    Text = "Dégâts Critiques"
  },
  State_58052_Desc = {
    Text = "Chaque point de sigil noir consommé en exploration augmente les dégâts de base de \"tout miser\" de 0,5 %. (Déjà augmenté de [DescArg1]%)"
  },
  State_58052_Name = {
    Text = "Sans risque de perte"
  },
  State_58061_Name = {
    Text = "Intégrité face à la tentation"
  },
  State_58063_Desc = {
    Text = "Les dégâts de l'éveillé augmentent de 25 %, pendant [Layer] tours."
  },
  State_58063_Name = {
    Text = "Un regard qui dépasse les âges"
  },
  State_58144_Desc = {
    Text = "Le taux critique augmente de [Layer]% dans ce niveau"
  },
  State_58144_Name = {
    Text = "Taux de coup critique permanent"
  },
  State_58144_WeaponDesc = {
    Text = "Le taux critique augmente de [Layer]% dans ce niveau"
  },
  State_58259_Desc = {
    Text = "Équipe unique : Le taux critique du porteur augmente de <WeaponEffect_Num:[StateArg1]%>. Après avoir éliminé un ennemi, le porteur obtient <WeaponEffect_Num:[StateArg2]> marques noires, pouvant se déclencher jusqu'à 3 fois pendant l'exploration. Après avoir déclenché 3 fois, le taux critique du porteur augmente de manière permanente de <WeaponEffect_Num:[StateArg3]%> pour cette exploration."
  },
  State_58259_WeaponDesc = {
    Text = "Le taux de critique du porteur augmente de <WeaponEffect_Num:[StateArg1]%>. Après que le porteur tue un ennemi, gagnez <WeaponEffect_Num:[DescArg2]> points de Sceau Noir, déclenchant au maximum 3 fois durant l'exploration ([DescArg1]/3). Après avoir déclenché 3 fois, le taux de critique du porteur augmentera définitivement de <WeaponEffect_Num:[StateArg3]%> durant cette exploration."
  },
  State_58297_Desc = {
    Text = "Ryker obtient [DescArg3] marques noires lorsqu'il élimine un ennemi, avec un maximum de 5 fois par exploration. ([DescArg1]/5)\n Après avoir gagné 50/125/250 marques noires en combat, la limite de création augmente de 1, à la fin du combat, choisissez un « L'héritage du Chaos » à ajouter à la liste des reliques. (Marques noires obtenues : [DescArg2])"
  },
  State_58297_Name = {
    Text = "Le gagnant prend tout"
  },
  State_58447_Desc = {
    Text = "Comprend les trois reliques suivantes : \n « Manteau Chanceux du Vent » : le taux critique de tous les éveilleurs augmente de 10 %. Tous les résultats aléatoires de Ryker et des dés n'atteindront pas leur valeur minimale. \n <TentacleInjurieIconKeywords:Amélioration> : le taux critique augmente à 15 %, augmentant la valeur maximale des résultats aléatoires de 1. \n « Dé de remède » : chaque fois que vous libérez un Décret Clé, ajoutez 1 carte « <C05_yansheng1:Dé de remède> » à votre main. \n <TentacleInjurieIconKeywords:Amélioration> : change pour ajouter 1 carte « <C05_yansheng2:Dé de remède brillant> » à votre main. \n « Bouton Gueule Grande » : au début du tour et lors du déclenchement de l'effet aléatoire de Ryker ou des dés, obtenez 50 points de Fragment de clé et 2 % de dégâts critiques, maximum 30 % de dégâts critiques. \n <TentacleInjurieIconKeywords:Amélioration> : change pour obtenir 100 points de Fragment de clé et 4 % de dégâts critiques, maximum 50 % de dégâts critiques."
  },
  State_58447_Name = {
    Text = "<CardKeyWord:Héritage du chaos>"
  },
  State_58490_Desc = {
    Text = "Lorsque toute la somnolence est éliminée, tous les réveilleurs et cartes seront scellés, et l'intention de « maître du sommeil » sera ajustée à « pouvoir royal »"
  },
  State_58490_Name = {Text = "Somnolence"},
  State_58491_Desc = {
    Text = "Chaque fois qu'une carte est jouée, retirez 1 couche de « somnolence ». Au début du tour, restaurez 12 couches de « somnolence »."
  },
  State_58491_Name = {Text = "Fureur"},
  State_58492_Desc = {
    Text = "Cet éveilleur n'est pas encore éveillé... Il s'éveillera lorsqu'il sera sur le point d'être abattu, restaurera sa vie et commencera à se battre sous sa véritable forme"
  },
  State_58492_Name = {
    Text = "Non Réveillé"
  },
  State_58493_Desc = {
    Text = "Chaque fois qu'une carte est jouée, retirez 1 couche de « somnolence ». Au début du tour, restaurez 12 couches de « somnolence »."
  },
  State_58493_Name = {Text = "Fureur"},
  State_58947_Desc = {
    Text = "Le taux critique augmente de [Layer]% dans ce niveau"
  },
  State_59078_Name = {
    Text = ", peut être utilisé 1 fois"
  },
  State_59079_Name = {
    Text = ", peut être utilisé 2 fois"
  },
  State_59080_Name = {
    Text = ", peut être utilisé 3 fois"
  },
  State_59117_Desc = {
    Text = "Dégâts critiques +[Layer] %"
  },
  State_59117_Name = {
    Text = "Dégâts Critiques"
  },
  State_59160_Desc = {
    Text = "Augmente de 10 % tous les effets de Dommages infligés, Répondre et Bouclier, ne peut pas être dissipé."
  },
  State_59160_Name = {
    Text = "<CardKeyWord: Fort>"
  },
  State_59161_Desc = {
    Text = "Augmente les Dommages infligés, les effets de Répondre et de Bouclier de [DescArg1] %. Ne peut pas être dissipé."
  },
  State_59161_Name = {
    Text = "Amplification"
  },
  State_59169_Desc = {
    Text = "Le Coût d'Arithmetica de base de cette carte ne peut pas dépasser la Limite d'Arithmetica."
  },
  State_59169_Name = {
    Text = "Équilibre__ \"Utilisation développement uniquement\""
  },
  State_59173_Name = {
    Text = "Lorsque ce marqueur est présent, cela signifie qu'une attaque multiple est en cours et qu'une nouvelle attaque multiple ne sera pas déclenchée."
  },
  State_59208_Desc = {
    Text = "Réduit de 10 % tous les effets de Dommages infligés, Répondre et Bouclier, ne peut pas être dissipé."
  },
  State_59208_Name = {
    Text = "<WeaknessColour: Réduction forte>"
  },
  State_59209_Desc = {
    Text = "Réduit les Dommages infligés, les effets de Répondre et de Bouclier de [DescArg1] %. Ne peut pas être dissipé."
  },
  State_59209_Name = {
    Text = "Amplification▼"
  },
  State_59423_Desc = {
    Text = "Ryker obtient 5 marques noires lorsqu'il élimine un ennemi, chaque 1% de marques noires obtenues augmente la quantité obtenue de 1%, avec un maximum de 5 fois par exploration. \n Après avoir gagné 50/125/250 marques noires en combat, la limite de création augmente de 1, à la fin du combat, choisissez un « L'héritage du Chaos » à ajouter à la liste des reliques."
  },
  State_59423_Name = {
    Text = "Le gagnant prend tout"
  },
  State_59424_Desc = {
    Text = "Chaque point de sigil noir consommé en exploration augmente les dégâts de base de \"tout miser\" de 0,5 %"
  },
  State_59424_Name = {
    Text = "Sans risque de perte"
  },
  State_59439_Desc = {
    Text = "Cet état utilise une zone de vulnérabilité multipliée, prétendant être une zone de multiplication indépendante."
  },
  State_59439_Name = {
    Text = "Si vous avez un certain état, les dégâts reçus sont doublés"
  },
  State_59519_Name = {
    Text = "Choisissez une carte de la pile de tirage ou de la pile de défausse pour l'ajouter à votre main, réduisez sa consommation de puissance à 0"
  },
  State_59520_Desc = {
    Text = "Après avoir joué, piochez 2 cartes et réduisez leur coût en Arithmetica par le coût réel en Arithmetica de la carte d'Oraison, n'ayant d'effet qu'une seule fois par bataille."
  },
  State_59520_Name = {
    Text = "<WhiteQuality:Logique de la connaissance>"
  },
  State_59521_Name = {
    Text = "Perdre 10% de la vie actuelle ([DescArg1])"
  },
  State_59522_Desc = {
    Text = "Jouez-le puis défaussez toutes les autres cartes sauf cet éveilleur, en gagnant 5 cartes aléatoires non-éveilleuses ; cela ne prend effet qu'une seule fois par bataille."
  },
  State_59522_Name = {
    Text = "<WhiteQuality:Logique du plaisir>"
  },
  State_59525_Name = {
    Text = "Les réveilleurs correspondant aux cartes de commandement obtiennent 50 points d’aliemus"
  },
  State_59526_Desc = {
    Text = "En jouant, gagnez 3 <RetainIconKeywords:Retain> supplémentaires et <DepleteIconKeywords:Exhaust> copie de base, efficace une seule fois par bataille."
  },
  State_59526_Name = {
    Text = "<WhiteQuality:Logique de la reproduction>"
  },
  State_59534_Name = {
    Text = "Lorsque ce marqueur est présent, cela signifie que cette carte interdit de déclencher le fantasme."
  },
  State_59560_Name = {
    Text = "Choisissez une carte ayant reçu les trois oraisons de qualité pour l'ajouter à votre main"
  },
  State_59671_Desc = {
    Text = "Ce tour, dégâts finaux de tous les éveillés augmentés de 15 %"
  },
  State_59671_Name = {
    Text = "Montre à Hypercorde"
  },
  State_59673_Name = {
    Text = "Petite boîte à musique"
  },
  State_59678_Desc = {
    Text = "Lors de la collecte, perdre toutes les autres reliques et obtenir aléatoirement 2 reliques en or"
  },
  State_59878_Desc = {
    Text = "À la fin du tour, réduisez de 1 charge supplémentaire le « Chaos » et gagnez [StateArg1] <PowerIconKeywords:FOR>. Les clones de « N » invoqués par la suite ont leurs PV augmentés de 200%, et leur mort ne réduit plus les charges de « Chaos » ni n'octroie de <PowerIconKeywords:FOR>."
  },
  State_59878_Name = {
    Text = "Chaos arrive"
  },
  State_59991_Name = {
    Text = ", Cette carte peut consommer jusqu'à 5 niveaux <EnergyStorageKeywords:charge>"
  },
  State_59993_Name = {
    Text = "Récupérez 10% de la vie perdue ([DescArg1])"
  },
  State_60000_Desc = {
    Text = "Gagne 1 charge de <MadnessIconKeywords:Fou> Temporaire lorsqu'il subit des Dégâts Directs."
  },
  State_60000_Name = {
    Text = "Colère accumulée"
  },
  State_60028_Desc = {
    Text = "Au début du tour du joueur, choisis aléatoirement une carte en main dont le coût de calcul change à 3 pendant ce tour. Après la mort, cet effet cesse et réduit le coût de calcul de toutes les cartes du tueur de 1 pour ce tour"
  },
  State_60028_Name = {
    Text = "Délire de la cage"
  },
  State_60044_Name = {
    Text = "Consommé après [Layer] utilisations"
  },
  State_60083_Desc = {
    Text = "Dégâts subis ce tour -[Layer]%."
  },
  State_60083_Name = {
    Text = "<ReinforceColour:renforcé>"
  },
  State_60083_WeaponDesc = {
    Text = "Tous les dégâts infligés sont réduits de [DescArg1] %"
  },
  State_60085_Desc = {
    Text = "Au début du combat et au début du tour, gagnez des renforcements temporaires. Plus la vie du joueur est élevée, plus vous gagnez de couches, avec un maximum de 50 couches"
  },
  State_60085_Name = {
    Text = "Pupation ultime"
  },
  State_60085_WeaponDesc = {
    Text = "Tous les dégâts infligés sont réduits de [DescArg1] %"
  },
  State_60086_Desc = {
    Text = "Au début du combat et au début du tour, gagnez des renforcements temporaires. Plus la vie du joueur est élevée, plus vous gagnez de couches, avec un maximum de 25 couches"
  },
  State_60086_Name = {Text = "Pupation"},
  State_60086_WeaponDesc = {
    Text = "Tous les dégâts infligés sont réduits de [DescArg1] %"
  },
  State_60087_Desc = {
    Text = "Effet de blessure réduit de [Layer] % la régénération de vie"
  },
  State_60087_Name = {
    Text = "<Rune_14_High:Blessure accrue>"
  },
  State_60087_WeaponDesc = {
    Text = "Tous les dégâts infligés sont réduits de [DescArg1] %"
  },
  State_60088_Desc = {
    Text = "Chaque charge réduit les dégâts reçus de 1%."
  },
  State_60088_Name = {
    Text = "<ReinforcePVEKeywords:renforcé>"
  },
  State_60088_WeaponDesc = {
    Text = "Tous les boucliers obtenus sont réduits de 25%"
  },
  State_60089_Desc = {
    Text = "Dégâts subis -[Layer]%."
  },
  State_60089_Name = {
    Text = "<ReinforceColour:renforcé>"
  },
  State_60089_WeaponDesc = {
    Text = "Tous les dégâts infligés sont réduits de [DescArg1] %"
  },
  State_60106_Desc = {
    Text = "Au début du tour, modifiez aléatoirement le coût d'Arithmetica d'une carte en main à 3, et restaurez-le à la fin du tour."
  },
  State_60106_Name = {
    Text = "Délire de la cage"
  },
  State_60112_Desc = {
    Text = "Chaque fois qu'une carte de commande est jouée pendant ce tour, tous les réveilleurs gagnent 1 point de folie"
  },
  State_60112_Name = {Text = "Concerto"},
  State_60115_Desc = {
    Text = "Ce tour, après avoir libéré l'exaltation, réduisez le degré de fusion des jumeaux de 3 %"
  },
  State_60115_Name = {Text = "Requiem"},
  State_60118_Desc = {
    Text = "Ce tour, les dégâts, le poison et le comptoir augmentent de [Layer] %"
  },
  State_60118_Name = {Text = "Rhapsodie"},
  State_60128_Desc = {
    Text = "Changez le coût en arithmetica de la carte avant de la jouer"
  },
  State_60128_WeaponDesc = {
    Text = "Changez le coût en arithmetica de la carte avant de la jouer"
  },
  State_60129_Desc = {
    Text = "Tu joues ta prochaine [Layer] carte de commandement non dérivée, le coût en arithmetica diminue de 2"
  },
  State_60129_Name = {
    Text = "Note descendante"
  },
  State_60130_Desc = {
    Text = "Tu joues ta prochaine [Layer] carte de commandement non dérivée, le coût en arithmetica augmente de 2 et prend effet 2 fois"
  },
  State_60130_Name = {
    Text = "Son montant"
  },
  State_60148_Desc = {
    Text = "À la fin du tour, obtenir différents effets selon l'état : partage : obtenir 1 couche temporaire <MadnessIconKeywords:folie>. rassemblement : obtenir 50 couches temporaires <ReinforcePVEKeywords:renforcé>"
  },
  State_60148_Name = {
    Text = "Paramètres d'ajustement"
  },
  State_60150_Desc = {
    Text = "Chaque fois que le joueur utilise une clé, passe immédiatement entre les formes ouverte et fermée. En forme ouverte, gagnez [StateArg1] force temporaire. En forme fermée, gagnez [StateArg2] bouclier"
  },
  State_60150_Name = {
    Text = "Sensibilité fonctionnelle"
  },
  State_60151_Desc = {
    Text = "Cet éveilleur n'est pas encore éveillé... Il s'éveillera lorsqu'il sera sur le point d'être abattu, restaurera sa vie et commencera à se battre sous sa véritable forme"
  },
  State_60151_Name = {
    Text = "Non Réveillé"
  },
  State_60154_Desc = {
    Text = "Actuellement, étant en mode - Retrait. Les armements mécaniques gagneront un bouclier et alerte, et l'intention sera principalement axée sur la défense"
  },
  State_60154_Name = {
    Text = "Arme Mécanique - Ramasser"
  },
  State_60155_Desc = {
    Text = "Actuellement, étant en mode - Diffus. Les armements mécaniques gagneront en puissance, et l'intention sera principalement axée sur l'attaque"
  },
  State_60155_Name = {
    Text = "Arme Mécanique - Placer"
  },
  State_60167_Desc = {
    Text = "Changez le coût en arithmetica de la carte avant de la jouer"
  },
  State_60167_WeaponDesc = {
    Text = "Changez le coût en arithmetica de la carte avant de la jouer"
  },
  State_60184_Desc = {
    Text = "Chaque fois qu'une carte est jouée, « les jumeaux contradictoires » changent d'intention"
  },
  State_60184_Name = {
    Text = "Contradiction"
  },
  State_60187_Desc = {
    Text = "Les états de faiblesse, vulnérabilité et blessure infligés aux joueurs sont de 50%"
  },
  State_60187_Name = {
    Text = "La fin est le commencement"
  },
  State_60201_Name = {
    Text = ": Force retardée du monstre"
  },
  State_60263_Desc = {
    Text = "Effet de fragilité réduit de [Layer] % et accorde un bouclier"
  },
  State_60263_Name = {
    Text = "<Rune_14_High:Vulnérabilité accrue>"
  },
  State_60264_Desc = {
    Text = "Les effets de saignement infligés ne se dissipent qu'à 50% à la fin du tour"
  },
  State_60264_Name = {
    Text = "<Rune_14_High:Hémolyse>"
  },
  State_60265_Desc = {
    Text = "L'effet de saignement ne se dissipe qu'à 50% à la fin du tour"
  },
  State_60265_Name = {
    Text = "<BleedingColour: Hémolyse>"
  },
  State_60279_Name = {
    Text = "Cette carte sera consommée à la fin du tour"
  },
  State_60284_Desc = {
    Text = "Au début du combat et au début du tour, gagnez des renforcements temporaires. Plus la vie du joueur est basse, plus vous gagnez de couches, avec un maximum de 50 couches"
  },
  State_60284_Name = {
    Text = "Formation de l'épée indestructible"
  },
  State_60284_WeaponDesc = {
    Text = "Tous les dégâts infligés sont réduits de [DescArg1] %"
  },
  State_60297_Desc = {
    Text = "\"@2\"Apparaît dans une forme libérée, la vie devient 3 fois l'original. À chaque tour, il questionne le Gardien, ajoutant une carte \"Réponse Tawil\" à la main."
  },
  State_60297_Name = {
    Text = "Vérité ou mensonge"
  },
  State_60297_WeaponDesc = {
    Text = "Au début du prochain tour, obtenez un bouclier équivalent à la vie perdue au tour précédent"
  },
  State_60298_Desc = {
    Text = "La puissance de l'entité inconnue reste enfouie sous la piscine noire, sur le point d'être vaincue, elle va ressusciter complètement et commencer à combattre sous la forme d'une libération"
  },
  State_60298_Name = {
    Text = "hibernation"
  },
  State_60312_Desc = {
    Text = "Chaque fois que vous subissez des dégâts équivalents à 10% de vos points de vie, obtenez [Layer] couches de « renforcé » temporaires"
  },
  State_60312_Name = {
    Text = "Bouclier de brouillard corrodant"
  },
  State_60315_Desc = {
    Text = "Ce tour, après avoir libéré l'exaltation, récupérez 5 % de vie perdue ([DescArg1])"
  },
  State_60315_Name = {Text = "Requiem"},
  State_60336_Name = {
    Text = "Après avoir joué, gagnez 1 point d'arithmétique et piochez 1 carte, mais cette carte sera épuisée"
  },
  State_60339_Name = {
    Text = "Jouer cette carte accorde 1 Arithmetica et pioche 1 Carte, mais cette Carte sera Épuisée"
  },
  State_60367_Desc = {
    Text = "Au début du tour du joueur, choisis aléatoirement une carte en main dont le coût de calcul change à 3 pendant ce tour. Après la mort, cet effet cesse et réduit le coût de calcul de toutes les cartes du tueur de 1 pour ce tour"
  },
  State_60367_Name = {
    Text = "Délire de la cage"
  },
  State_60386_Desc = {
    Text = "L'effet inclut : saignement causant 150 % de dégâts, poison causant 75 % de dégâts, appliquer 1 couche de faiblesse, appliquer 1 couche de vulnérabilité, réduire temporairement [DescArg1] points de pouvoir"
  },
  State_60386_Name = {
    Text = "<MysterydebuffKeywords:Effet négatif mystérieux>"
  },
  State_60404_Desc = {
    Text = "Chaque fois que vous subissez 1 point de dégâts, obtenez 2 couches de renforcement temporaire"
  },
  State_60404_Name = {
    Text = "Métamorphose finale"
  },
  State_60408_Desc = {
    Text = "Quand la vie tombe à 33% (reste [DescArg1] points), plus de dégâts ce tour et déclenche \"Morsure Fantôme\""
  },
  State_60408_Name = {
    Text = "Morsure du masque fantôme"
  },
  State_60409_Desc = {
    Text = "Quand la vie tombe à 66% (reste [DescArg1] points), plus de dégâts ce tour et déclenche \"Métamorphose Finale\""
  },
  State_60409_Name = {
    Text = "Miroir du Crépuscule"
  },
  State_60429_Name = {
    Text = "État @réveilleur Hameln @musique primordiale"
  },
  State_60430_Desc = {
    Text = "Jouer une carte avec un coût d'arithmétique correspondant à l'intention consommera celle-ci, et fera perdre à tous les ennemis [DescArg1] points de pouvoir temporaires"
  },
  State_60430_Name = {
    Text = "Note de la loi rythmique"
  },
  State_60431_Name = {
    Text = "État @réveilleur Hameln @son ascendant"
  },
  State_60432_Name = {
    Text = "État @réveilleur Hameln @prélude de l'âme"
  },
  State_60433_Name = {
    Text = "État @réveilleur Hameln @son descendant"
  },
  State_60434_Name = {
    Text = "État @réveilleur Hameln @mélodie de souvenirs"
  },
  State_60435_Name = {
    Text = "État @réveilleur Hameln @compte du prélude de l'âme"
  },
  State_60436_Desc = {
    Text = "Lorsqu'une blessure non bloquée est infligée, placez [StateArg1] carte(s) « blessure » dans la pile de pioche"
  },
  State_60436_Name = {
    Text = "Prélude de l'âme"
  },
  State_60438_Name = {
    Text = "État @réveilleur Hameln @écoute son ascendant"
  },
  State_60439_Name = {
    Text = "État @réveilleur Hameln @écoute son descendant"
  },
  State_60440_Name = {
    Text = "État @réveilleur Hameln @écoute prélude de l'âme"
  },
  State_60441_Name = {
    Text = "État @réveilleur Hameln @écoute mélodie de souvenirs"
  },
  State_60442_Name = {
    Text = "État @réveilleur Hameln @écoute musique primordiale"
  },
  State_60486_Desc = {
    Text = "Au début du combat, tous les réveilleurs voient leur aliemus réduit de moitié"
  },
  State_60486_Name = {
    Text = "Absorption de la déesse mère"
  },
  State_60487_Desc = {
    Text = "Cet éveilleur n'est pas encore éveillé... Il s'éveillera lorsqu'il sera sur le point d'être abattu, augmentera sa vie maximale de 200%, restaurera sa vie et commencera à se battre sous sa véritable forme"
  },
  State_60487_Name = {
    Text = "Non Réveillé"
  },
  State_60490_Desc = {
    Text = "Après la mort, toutes les entités éveillées gagnent 30 points de folie"
  },
  State_60490_Name = {
    Text = "Désir de vivre"
  },
  State_60491_Desc = {
    Text = "La folie infligée par tous les éveillés est réduite de 50 %. À la fin du tour, gagnez 1 niveau de « <DarkEgo:ombre de soi> » : au début du tour, tous les éveillés gagnent 3 points de folie."
  },
  State_60491_Name = {
    Text = "Cérémonie de l'Arbre Mère"
  },
  State_60493_Desc = {
    Text = "Après avoir cumulativement perdu [Layer] points de vie, invoque un réveilleur mimétique. Si le nombre de réveilleurs mimétiques sur le terrain atteint 2, les points de vie maximum de tous les réveilleurs mimétiques augmentent de 50%"
  },
  State_60493_Name = {
    Text = "Mère nourricière"
  },
  State_60500_Desc = {
    Text = "Si un réveilleur mimétique est présent, obtient 50 couches de « cacher »"
  },
  State_60500_Name = {
    Text = "Caché dans la forêt"
  },
  State_60511_Desc = {
    Text = "Apparaît toujours dans la main de départ"
  },
  State_60511_Name = {
    Text = "<GuyouKeywords:Inhérent>"
  },
  State_60511_WeaponDesc = {
    Text = "Après avoir joué, la carte ne sera pas mise dans la défausse et ne pourra pas être utilisée à nouveau dans ce combat"
  },
  State_60522_Desc = {
    Text = "Effets de fragilité et de blessure augmentés à 50 %"
  },
  State_60522_Name = {
    Text = "Destruction"
  },
  State_60523_Desc = {
    Text = "Chaque couche ajoute une attaque, perd une couche en cas de dégâts, perd toutes les couches à la fin du tour"
  },
  State_60523_Name = {Text = "Prière"},
  State_60524_Desc = {
    Text = "Au début du combat et au début du tour, gagnez [Layer] couches de renforcé, avec un maximum de 50 couches"
  },
  State_60524_Name = {
    Text = "Sanctification"
  },
  State_60524_WeaponDesc = {
    Text = "Tous les dégâts infligés sont réduits de [DescArg1] %"
  },
  State_60527_Desc = {
    Text = "Après avoir joué, est consommée, mais réduit la force temporaire des ennemis"
  },
  State_60527_Name = {
    Text = "<CardKeyWord:Paradis mélodique>"
  },
  State_60543_Desc = {
    Text = "À la fin du tour, gagne 10 couches de \"Serment de sang\", chaque couche est retirée après avoir subi des dégâts"
  },
  State_60543_Name = {
    Text = "Feu de la mèche"
  },
  State_60554_Name = {
    Text = "<HuihuanbKeywords:Écho musical>"
  },
  State_60558_Name = {
    Text = "<HuihuanbKeywords:Écho musical>"
  },
  State_60562_Desc = {
    Text = "Après avoir joué, prenez effet deux fois, changeant en \"Mélodie du Momentum\""
  },
  State_60562_Name = {
    Text = "<HuihuanaKeywords:Écho musical>"
  },
  State_60564_Desc = {
    Text = "Lorsque le premier est sur le point d'être vaincu, restaurez la vie et changez l'intention en « Évolution finale », obtenez de la force et de la forteresse. Lorsque le deuxième est sur le point d'être vaincu, restaurez la vie et changez l'intention en « Morsure du masque fantôme », infligeant des dégâts exceptionnels."
  },
  State_60564_Name = {
    Text = "Démon de l'ombre"
  },
  State_60567_Desc = {
    Text = "Après avoir joué, Hameln gagne 3 points de aliemus"
  },
  State_60567_Name = {
    Text = "<XushiAKeywords:Musique accumulée>"
  },
  State_60568_Name = {
    Text = "<XushiAKeywords:Musique accumulée>"
  },
  State_60569_Name = {
    Text = "<XushiBKeywords:Musique accumulée>"
  },
  State_60570_Desc = {
    Text = "Après avoir joué, Hameln gagne 3 points de aliemus"
  },
  State_60570_Name = {
    Text = "<XushiBKeywords:Musique accumulée>"
  },
  State_60571_Name = {
    Text = "<HuihuanaKeywords:Écho musical>"
  },
  State_60576_Desc = {
    Text = "Au début du tour du joueur, choisis aléatoirement une carte en main dont le coût de calcul change à 3 pendant ce tour. Après la mort, cet effet cesse et réduit le coût de calcul de toutes les cartes du tueur de 1 pour ce tour"
  },
  State_60576_Name = {
    Text = "Délire de la cage"
  },
  State_60578_Desc = {
    Text = "Lorsqu'il subit des dégâts mortels, il récupère 50 % de ses points de vie, devient immunisé contre les dégâts pendant 1 tour, et l'intention se transforme en « briser le cocon »"
  },
  State_60578_Name = {Text = "Éclosion"},
  State_60592_Desc = {
    Text = "Au début de l'exploration, ajoutez 1 « Clarté de la Clé d'Argent » avec <DestructionKeywords:Détruire> au deck.\nChaque fois qu'un Décret Clé est déclenché, les Dégâts Critiques du Porteur +<WeaponEffect_Num:[StateArg1]%>.\nChaque fois que le Porteur inflige des Dégâts Directs, son Taux Critique +<WeaponEffect_Num:[StateArg3]%> ce tour et vous gagnez des Fragments de clé égaux à <WeaponEffect_Num:[StateArg2]%> de sa Régénération de Fragment de clé, jusqu'à 5 fois par tour."
  },
  State_60592_WeaponDesc = {
    Text = "Au début de l'exploration, ajoutez 1 « Clarté de la Clé d'Argent » avec <DestructionKeywords:Détruire> au deck.\nChaque fois qu'un Décret Clé est déclenché, les Dégâts Critiques du Porteur +<WeaponEffect_Num:[StateArg1]%>.\nChaque fois que le Porteur inflige des Dégâts Directs, son Taux Critique Temporaire +<WeaponEffect_Num:[StateArg3]%> et vous gagnez <WeaponEffect_Num:[DescArg1]> Fragments de clé, jusqu'à 5 fois par tour."
  },
  State_60594_Desc = {
    Text = "Équipe Unique : À la fin du tour, le porteur obtient 5 points de fureur. Après que le porteur ait libéré l'exaltation, le taux critique, les dégâts critiques, le bouclier et la régénération de PV de la prochaine carte d'instruction jouée ce tour-ci par le porteur augmentent de <WeaponEffect_Num:[StateArg1] %>."
  },
  State_60594_WeaponDesc = {
    Text = "Après la fin du tour, le porteur obtient 5 points de folie. Après que le porteur ait lancé une exaltation, le taux critique, les dégâts critiques, le bouclier et la guérison de la prochaine carte de commande jouée ce tour-ci par le porteur augmente de <WeaponEffect_Num:[StateArg1] %>"
  },
  State_60898_Desc = {
    Text = "Lorsqu'il subit des Dégâts Directs ou des Dégâts des tentacules, scelle l'Exaltation et les Cartes d'instruction de l'Éveilleur attaquant pendant 1 tour, et retire 1 charge de <ResentChainsKeywords:Chaîne de Rancœur>."
  },
  State_60898_Name = {
    Text = "<ResentChainsKeywords1:Chaîne de Rancœur>"
  },
  State_60925_Desc = {
    Text = "À la fin du tour, récupérer 5% de la vie perdue. Chaque fois qu'un joueur pioche une carte symptôme ou état, tous les alliés reçoivent [Layer] points de pouvoir"
  },
  State_60925_Name = {
    Text = "Lanterne de sang"
  },
  State_60926_Desc = {
    Text = "À la fin du tour, si PV < 50%, gagne [Layer] points de force et [StateArg1] couches de barrière"
  },
  State_60926_Name = {
    Text = "Autel de la Lanterne Sacrée"
  },
  State_60953_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: \"Exaltation de Folie\" inflige [StateArg1] couches de <PVPSlowKeywords:Ralenti> à tous les cibles ennemies avant de lancer."
  },
  State_60953_Name = {
    Text = "Requiem Éternel"
  },
  State_60962_Desc = {
    Text = "Dans ce combat, la santé maximale augmente de [Layer] %"
  },
  State_60962_Name = {
    Text = "Augmentation de la vie"
  },
  State_60964_Desc = {
    Text = "Dans ce combat, les dégâts augmentent de [Layer] %"
  },
  State_60964_Name = {
    Text = "Dégâts augmentés"
  },
  State_61038_Name = {
    Text = "Hamelin Démo"
  },
  State_61050_Desc = {
    Text = "Après avoir déclenché l'effet « Melodie » ou joué « Symphonie de l'Harmonie », Hamelin obtient 1 % de Taux Critique et de Dégâts Critiques (actuellement reçu : [DescArg1] %). Tous les 10 déclenchements, le nombre d'instances de Dommages de « Prélude de l'âme » et de « Note de musique de l'Origine » +1 dans ce combat, jusqu'à 3 fois."
  },
  State_61050_Name = {
    Text = "Rêverie sous la lune"
  },
  State_61051_Desc = {
    Text = "Après avoir déclenché l'effet « Melodie » ou joué « Symphonie de l'Harmonie », Hamelin obtient 1 % de Taux Critique et de Dégâts Critiques. Tous les 10 déclenchements, le nombre d'instances de Dommages de « Prélude de l'âme » et de « Note de musique de l'Origine » +1 dans ce combat, jusqu'à 3 fois."
  },
  State_61051_Name = {
    Text = "Rêverie sous la lune"
  },
  State_61056_Desc = {
    Text = "Au premier tour, gagnez 100 points de force temporaire"
  },
  State_61056_Name = {Text = "Fureur"},
  State_61084_Desc = {
    Text = "Pour les [Layer] prochaines cartes jouées lors de ce tour : si le coût en arithmetica est supérieur ou égal à 3, gagnez 2 points d'arithmetica, sinon piochez 2 cartes."
  },
  State_61084_Name = {
    Text = "Quatrième mouvement"
  },
  State_61085_Desc = {
    Text = "Consommation d'arethmetica - 2, prend effet deux fois après utilisation, modifie en « son de puissance accumulée »"
  },
  State_61085_Name = {
    Text = "<HuihuanbKeywords:Écho musical>"
  },
  State_61089_Desc = {
    Text = "La prochaine carte de commandement jouée sera effective 2 fois"
  },
  State_61089_Name = {
    Text = "Baton de chef d'orchestre"
  },
  State_61145_Name = {
    Text = "<BleedingColour: Saignement>"
  },
  State_61174_Desc = {
    Text = "Impossible d'obtenir un bouclier"
  },
  State_61174_Name = {
    Text = "Renvoi des scories"
  },
  State_61180_Desc = {
    Text = "Les dégâts de base d'Helot-catena augmentent de [DescArg1] % pendant ce combat."
  },
  State_61180_Name = {
    Text = "Lame de vengeance"
  },
  State_61185_Desc = {
    Text = "Augmente les compétences de l'ennemi. Perd une couche à chaque fois qu'il subit des dégâts"
  },
  State_61185_Name = {
    Text = "Serment de sang"
  },
  State_62213_Desc = {
    Text = "Modifie l'effet Symptôme : Affaiblir pour réduire les Dégâts Directs et Dégâts des tentacules infligés de [Layer]%."
  },
  State_62213_Name = {
    Text = "<Rune_14_High:Faiblesse accrue>"
  },
  State_62309_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Équipé, obtient [StateArg1] <StrongEffectKeywords:Amplification>. Chaque fois que le Porteur perd des PV et que ses PV sont inférieurs à [StateArg2] %, obtient <ReinforceKeywords:Forteresse> et <StrengthenKeywords:Renforcement>."
  },
  State_62309_Name = {
    Text = "Noyade dans le Pourpre"
  },
  State_62317_Desc = {
    Text = "Immunité à tous les dégâts, retirée au début du tour"
  },
  State_62317_Name = {
    Text = "Immunité complète aux dégâts"
  },
  State_62336_Desc = {
    Text = "À chaque fois que vous jouez 3 cartes (il en reste [Layer] cartes), piochez 1 carte et figez au hasard 1 carte de commandement dans votre main"
  },
  State_62336_Name = {
    Text = "Le froid de l'hiver"
  },
  State_62337_Desc = {
    Text = "Chaque fois que vous jouez 3 cartes (il reste [Layer] cartes), piochez 1 carte et bloquez aléatoirement 1 carte de commandement dans votre main"
  },
  State_62337_Name = {
    Text = "Le froid de l'hiver"
  },
  State_62338_Desc = {
    Text = "Cette carte ne peut pas être jouée, ne sera pas défaussée à la fin du tour et fera gagner 5 points d'aliemus à l'éveillé concerné. Après que l'éveillé concerné ait utilisé l'aliemus, la congélation sera levée"
  },
  State_62338_Name = {
    Text = "<CardKeyWord:Gel>"
  },
  State_65332_Desc = {
    Text = "Après la mort, toutes les entités éveillées gagnent 30 points de folie"
  },
  State_65332_Name = {Text = "Fusion"},
  State_65342_Desc = {
    Text = "Après avoir été vaincu, vous renaîtrez, avec 100% de santé maximale supplémentaire et libérerez « froid polaire »"
  },
  State_65342_Name = {Text = "Silence"},
  State_65346_Desc = {
    Text = "Après la mort, figez 2 cartes de commandement dans la pile de main"
  },
  State_65346_Name = {
    Text = "Gelée blanche"
  },
  State_65358_Desc = {
    Text = "Équipe unique : Les dégâts de base infligés par le porteur augmentent de <WeaponEffect_Num:[StateArg1] %>. Avant que le porteur ne libère l'exaltation, la limite temporaire de la main augmente de +1, et pioche 1 carte d'instruction du porteur. Si le royaume actuel est « Chair », lorsque le porteur déclenche Dévorer, les dégâts critiques temporaires augmentent de <WeaponEffect_Num:[StateArg1] %>, cet effet ne peut se produire qu'une fois par tour."
  },
  State_65358_WeaponDesc = {
    Text = "Les dégâts de base infligés par l'équipement augmentent de <WeaponEffect_Num:[StateArg1]%>. Avant que le porteur n'ait libéré l'exaltation, la limite temporaire de la main augmente de +1, et piochez 1 carte d'instruction de l'équipement. Si le domaine actuel est « Chair », lorsque le porteur déclenche Dévorer, les dégâts critiques temporaires augmentent de <WeaponEffect_Num:[StateArg1] %>, pouvant se produire au maximum 1 fois par tour."
  },
  State_65360_Desc = {
    Text = "Équipe unique : Les dégâts de base infligés par le porteur augmentent de <WeaponEffect_Num:[StateArg1]%>. Au début du combat, le porteur reçoit 25 couches de «Neige», après avoir joué une carte, le porteur obtient 2 points de fureur et retire 1 couche. Après que «Neige» soit complètement retirée, le porteur obtient un taux critique de <WeaponEffect_Num:[StateArg2]%>."
  },
  State_65360_WeaponDesc = {
    Text = "Les dégâts de base infligés par le porteur augmentent de <WeaponEffect_Num:[StateArg1] %>. Au début du combat, le porteur obtient 25 couches de « Neige ». Après avoir joué une carte, le porteur gagne 2 points de Fureur et enlève 1 couche. Après que « Neige » ait été complètement enlevée, le porteur obtient <WeaponEffect_Num:[StateArg2]%> de Taux Critique (actuellement [DescArg1] couches de neige restantes)."
  },
  State_65362_Desc = {
    Text = "Après avoir accumulé [StateArg1] fois de dommages actifs (avec encore [Layer]), gèle aléatoirement 1 carte de commande dans votre main"
  },
  State_65362_Name = {Text = "Gel Retour"},
  State_65463_Name = {
    Text = "Gagnez 5 points du sigil noir"
  },
  State_65490_Desc = {
    Text = "À la fin du tour, gagne [StateArg1] couches de bouclier de givre et [StateArg2] points de force."
  },
  State_65490_Name = {
    Text = "Zéro absolu"
  },
  State_65497_Name = {
    Text = "Chaîne de sang · Essai de Shiro"
  },
  State_65553_Desc = {
    Text = "À la fin du tour, gagnez de la force en fonction du nombre de cartes restantes dans votre main, chaque carte donne [Layer] points"
  },
  State_65553_Name = {
    Text = "Lame de glace"
  },
  State_65557_Desc = {
    Text = "Après avoir subi des dommages fatals, restaurez toute la vie, changez d'intention en « Vrai · Regard dans l'espace profond », obtenez 80 couches de renforcement temporaire et retirez les états négatifs de vous-même ainsi que les états positifs du joueur. À la fin du tour, retirez 20 couches de renforcement."
  },
  State_65557_Name = {
    Text = "Chaos éternel"
  },
  State_65558_Desc = {
    Text = "Après avoir subi des dommages critiques, changez d'intention en « Regard dans l'espace profond » et obtenez 80 couches de renforcement temporaire, restaurez toute la vie, cela peut être déclenché [DescArg1] fois. Une fois le nombre de déclenchements épuisé, après avoir subi des dommages critiques, vous conserverez 1 point de vie et l'intention sera changée en « Œil des Mondes Innombrables ». À la fin du tour, retirez 20 couches de renforcement."
  },
  State_65558_Name = {
    Text = "Poussière d'étoiles"
  },
  State_65559_Desc = {
    Text = "Après la mort de tous, Tohuwabohu réapparaîtra."
  },
  State_65559_Name = {
    Text = "Éclats anciens"
  },
  State_65564_Name = {
    Text = "\n<D05EX_Relic: Le doute des membres de l'équipe d'expédition envers Hilote s'intensifie, vous devez faire un choix avant que les ennemis n'approchent et apaiser l'équipe agitée>"
  },
  State_65565_Name = {
    Text = [[

<D05EX_Relic:Ignorer les doutes des membres et continuer>]]
  },
  State_65566_Name = {
    Text = "\n<D05EX_Relic:Expliquer la situation aux membres de l'expédition>"
  },
  State_65567_Name = {
    Text = "\n<D05EX_Relic: Contraindre Hilote pour protéger davantage les membres de l'équipe>"
  },
  State_65568_Name = {
    Text = "\n<D05EX_Relic: Contraindre Hilote et utiliser le pouvoir du réveilleur pour protéger tous les membres de l'équipe>"
  },
  State_65585_Desc = {
    Text = "Cette carte retourne dans la main après avoir été jouée. L'Orison est désactivé jusqu'à la fin du tour."
  },
  State_65585_Name = {
    Text = "<CardKeyWord:Résonance>"
  },
  State_66305_Desc = {
    Text = "À la fin du tour, obtient 1 couche temporaire de <ResentChainsKeywords:Chaîne de Rancœur>."
  },
  State_66305_Name = {
    Text = "Verrou de l'Antiquité à nos Jours"
  },
  State_66306_Desc = {
    Text = "Lorsqu'il subit des Dégâts Directs ou des Dégâts des tentacules, scelle l'Exaltation et les Cartes d'instruction de l'Éveilleur attaquant pendant 1 tour, et retire 1 charge de <ResentChainsKeywords:Chaîne de Rancœur>."
  },
  State_66306_Name = {
    Text = "<ResentChainsKeywords1:Chaîne de Rancœur>"
  },
  State_66308_Desc = {
    Text = "Après avoir subi des dommages critiques, verrouillez la vie à 1."
  },
  State_66308_Name = {
    Text = "Chaos éternel"
  },
  State_66311_Desc = {
    Text = "Avec les souvenirs des réveilleurs s'échappant des bords de ton esprit, ils prennent racine et s'épanouissent dans ton cerveau. Peu importe combien de fois tu les tranches, peu importe combien de fois la dissolution les renverse, ils ne t'ont jamais quitté"
  },
  State_66311_Name = {
    Text = "Souvenirs Brisés"
  },
  State_66313_Desc = {
    Text = "Chaque fois qu'une carte de commandement est jouée, défaussez une carte du réveilleur ayant la consommation d'arithmétique la plus faible."
  },
  State_66313_Name = {
    Text = "Intimidation de la Volonté Suprême"
  },
  State_66314_Desc = {
    Text = "Immunité à tous les dégâts."
  },
  State_66314_Name = {
    Text = "Immunité complète aux dégâts"
  },
  State_66317_Desc = {
    Text = "Avec les souvenirs des éveilleurs s'échappant des bords de ton esprit, ils prennent racine et s'épanouissent dans ton cerveau. Peu importe combien de fois tu les tranches, peu importe combien de fois la fusion les renverse, ils ne t'ont jamais quitté. Au début de chaque tour, restaure 1 point de limite d'Arithmetica et 2 points de limite max de la main."
  },
  State_66317_Name = {
    Text = "Fragment de mémoire"
  },
  State_66325_Desc = {
    Text = "Avec les souvenirs des éveilleurs s'échappant des bords de ton esprit, ils prennent racine et s'épanouissent dans ton cerveau. Peu importe combien de fois tu les tranches, peu importe combien de fois la fusion les renverse, ils ne t'ont jamais quitté. Au début de chaque tour, restaure 1 point de limite d’Arithmetica et 2 points de limite Max de la Main."
  },
  State_66325_Name = {
    Text = "Fragment de mémoire"
  },
  State_66358_Desc = {
    Text = "Lors de la première activation de la résistance à la mort en exploration, ajoutez une carte \" <DerivativeCardKeywords_39:Écho du Passé> \" à votre main"
  },
  State_66358_Name = {
    Text = "Existence inexistante"
  },
  State_66359_Desc = {
    Text = "Génère aléatoirement plusieurs options parmi lesquelles choisir."
  },
  State_66359_Name = {
    Text = "<FaxianKeywords:découverte>"
  },
  State_66360_Desc = {
    Text = "Dans ce combat, le taux critique augmente de [Layer] %"
  },
  State_66360_Name = {
    Text = "Taux Critique"
  },
  State_66362_Desc = {
    Text = "Dans ce combat, les dégâts critiques augmentent de [Layer] %"
  },
  State_66362_Name = {
    Text = "Dégâts Critiques"
  },
  State_66409_Name = {
    Text = "Le Jugement du Substitut"
  },
  State_66410_Desc = {
    Text = "La prochaine carte de commandement de Tawil jouée [DescArg1] sera effective 2 fois."
  },
  State_66410_Name = {
    Text = "Tout converge vers l'unité"
  },
  State_66414_Desc = {
    Text = ": Lorsqu'elle est en main, si la carte du dessus de la pile de pioche est une carte de commande, elle devient sa copie"
  },
  State_66414_Name = {
    Text = "Maîtriser les principes de tout"
  },
  State_66454_Desc = {
    Text = "Les coûts d'arithmetica des cartes de compétence réduisent le niveau de « cacher », pouvant s'empiler jusqu'à 5 niveaux, et supprimera 1 niveau après avoir subi des dégâts ou joué une compétence"
  },
  State_66454_Name = {Text = "Cacher"},
  State_66456_Desc = {
    Text = "Les coûts d'arithmetica des cartes de compétence réduisent le niveau de « cacher », pouvant s'empiler jusqu'à 5 niveaux, et supprimera 1 niveau après avoir subi des dégâts ou joué une compétence"
  },
  State_66456_Name = {
    Text = "<YinniColour:Cacher>"
  },
  State_66465_Desc = {
    Text = "Après avoir utilisé l’exalter, subis des dégâts équivalents au niveau correspondant"
  },
  State_66465_Name = {
    Text = "<PVPfengsuoColour:Explosion>"
  },
  State_66522_Desc = {
    Text = "Chaque 8ème carte jouée se déclenche 2 fois"
  },
  State_66522_Name = {
    Text = "Vin des Étoiles"
  },
  State_66553_Desc = {
    Text = "Après avoir joué « attaque » et « défense », le réveilleur correspondant reçoit 35 aliemus. Cependant, leur coût en arithmetica augmente de 1"
  },
  State_66553_Name = {
    Text = "Visage brisé"
  },
  State_66554_Desc = {
    Text = "Lorsque ramassé, placez 1 <DerivativeCardKeywords_1:\"Écho Éthéré\"> dans votre main."
  },
  State_66554_Name = {
    Text = "Équipement de communication"
  },
  State_66555_Desc = {
    Text = "Capacité maximale augmentée de 1"
  },
  State_66555_Name = {
    Text = "Seringue active"
  },
  State_66556_Desc = {
    Text = "Après avoir joué deux cartes du même éveillé, cet éveillé gagne 8 points de folie"
  },
  State_66556_Name = {
    Text = "Chronomètre Précis"
  },
  State_66557_Desc = {
    Text = "À chaque fois que vous perdez des points de vie, vous gagnez [DescArg1] point(s) <PowerIconKeywords:pouvoir>, avec un maximum de 10 accumulations par combat. Quand le maximum est atteint, restaurez 25 % des points de vie perdus"
  },
  State_66557_Name = {
    Text = "Honneur suprême"
  },
  State_66558_Desc = {
    Text = "Tous les 3 tours, applique 1 couche de <WeaknessIconKeywords:Faiblesse> à tous les ennemis. Les ennemis <WeaknessIconKeywords:Affaiblis> donnent [DescArg1] points de <PowerIconKeywords:Force> temporaire après avoir reçu des dégâts, jusqu'à 3 fois par tour"
  },
  State_66558_Name = {Text = "Môme"},
  State_66559_Desc = {
    Text = "En jouant une carte ayant un coût en arithmetica de 3 ou plus, tirez 1 carte et gagnez 1 en arithmetica"
  },
  State_66559_Name = {
    Text = "La beauté perdue"
  },
  State_66560_Desc = {
    Text = "\"Attaque\" gagne 2 Arithmetica et défausse 1 carte aléatoire ; \"Défense\" pioche 2 cartes et perd 1 Arithmetica. Peut être déclenché jusqu'à 3 fois par tour."
  },
  State_66560_Name = {
    Text = "Disque de joie"
  },
  State_66561_Desc = {
    Text = "Tous les 3 tours, ajoute 1 niveau de <VulnerabilityIconKeywords:Vulnérabilité> à tous les ennemis. Infliger des dégâts à un ennemi <VulnerabilityIconKeywords:Vulnérable> lui fait perdre [DescArg1] points de <PowerIconKeywords:Force> temporaire, jusqu'à 3 fois par tour."
  },
  State_66561_Name = {
    Text = "Le Sacrifice du Printemps"
  },
  State_66562_Desc = {
    Text = "Chaque 4 tours, doublez les dégâts subis par tous les ennemis ce tour-ci, mais après avoir libéré une exultation, scellez tous les réveilleurs pendant 1 tour"
  },
  State_66562_Name = {
    Text = "Les restes du voyageur"
  },
  State_66563_Desc = {
    Text = "Au début du tour, si plus de 3 cartes ont été jouées au tour précédent, piochez 2 cartes"
  },
  State_66563_Name = {
    Text = "Porte-monnaie tout neuf"
  },
  State_66564_Desc = {
    Text = "En ramassant, gagnez 3 points d'arithmetica"
  },
  State_66564_Name = {
    Text = "Miroir de poche"
  },
  State_66565_Desc = {
    Text = "En ramassant, infligez 1 tour de <WeaknessIconKeywords:faiblesse> et <VulnerabilityIconKeywords:vulnérable> à tous les ennemis"
  },
  State_66565_Name = {
    Text = "Combinaison de Contrainte à Changement de Couleur"
  },
  State_66566_Desc = {
    Text = "Au début de chaque tour, <DeathResistanceIconKeywords:résistance à la mort> augmente de 10 % (dans ce niveau, chaque fois que la résistance à la mort est déclenchée, la résistance à la mort obtenue est réduite de moitié). Lorsque <DeathResistanceIconKeywords:résistance à la mort> dépasse 100 %, <ProficientInRealmsIconKeywords:maîtrise des royaumes> augmente de 100."
  },
  State_66566_Name = {
    Text = "Perle de sirène"
  },
  State_66703_Desc = {
    Text = "Équipe unique : La capacité de charge de la Clé Argent augmente de 100%. Taille de main maximale +2, ne peut pas s'accumuler avec d'autres limites de cartes de la Roue du Destin. La régénération de clé du porteur augmente de <WeaponEffect_Num:[StateArg1]%>. Après avoir joué une carte, le taux de critique, les dmg de critique, le bouclier, aliemus et les effets de gain STR de la carte commande du porteur augmentent de <WeaponEffect_Num:[StateArg2]%>, empilable jusqu'à 5 couches."
  },
  State_66703_WeaponDesc = {
    Text = "La limite d'accumulation de s-énergie augmente de 100 %. Limite Max de la Main +2, ne peut pas être cumulée avec d'autres limites de main fournies par la Roue du Destin. La Régénération de Fragment de clé du porteur augmente de <WeaponEffect_Num:[DescArg2]>. Après avoir joué une carte, le taux critique et les dégâts critiques des cartes d'instruction du porteur, ainsi que les boucliers, la fureur et la force générés, augmentent de <WeaponEffect_Num:[StateArg2]%>, jusqu'à un maximum de 5 accumulations (actuellement [DescArg1] couches)."
  },
  State_66722_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Lorsqu'équipé et au début du tour, s'il n'y a pas de <PVPProtectiveKeywords:barrière>, obtenez [StateArg1] couches de <PVPProtectiveKeywords:barrière> ; sinon, obtenez <StrengthenKeywords:renforcement>."
  },
  State_66722_Name = {
    Text = "Roue Invisible"
  },
  State_66872_Desc = {
    Text = "Les dégâts, boucliers et soins prodigués par Tawil sont augmentés de [StateArg1] % temporairement pendant [Layer] tours."
  },
  State_66872_Name = {
    Text = "Brillance Infinie de Milliards"
  },
  State_66884_Desc = {
    Text = "À la fin du tour, la consommation d'arithmetica est réduite, et l'effet se déclenche également lorsqu'il est abandonné"
  },
  State_66884_Name = {
    Text = "<PrepareKeypvewords:préparer1>"
  },
  State_66888_Desc = {
    Text = "Équipe Unique : Après avoir libéré le Décret Clé, gagnez une <PowerIconKeywords:Force> équivalente à <WeaponEffect_Num:[StateArg1]%> de l'Attaque de l'équipé et un Bouclier équivalent à <WeaponEffect_Num:[StateArg2]%> de la Défense. Après avoir utilisé le Corps de Gnosis d'urgence, à la fin du tour, tous les Éveilleurs reçoivent <WeaponEffect_Num:[StateArg3]> points de Fureur."
  },
  State_66888_Name = {
    Text = "Désir Argenté"
  },
  State_66888_WeaponDesc = {
    Text = "Après avoir libéré le Décret Clé, obtenez <WeaponEffect_Num:[Power:DescArg1]> points de <PowerIconKeywords:Force> et <WeaponEffect_Num:[Block:DescArg2]> points de bouclier. Après avoir utilisé le Corps de Gnosis d'urgence, à la fin du tour, tous les Éveilleurs obtiennent <WeaponEffect_Num:[StateArg3]> points de fureur."
  },
  State_66893_Desc = {
    Text = "Équipe unique : après le début du combat, obtenez une s-énergie équivalente à <WeaponEffect_Num:[StateArg1]%> de la recharge de clé en argent de l'équipement. Après avoir libéré une clé pour la première fois dans un combat, répétez cet effet une fois."
  },
  State_66893_WeaponDesc = {
    Text = "Après le début du combat, gagnez <WeaponEffect_Num:[DescArg1]> points de s-énergie. Chaque fois que vous libérez clé en argent pour la première fois dans un combat, répétez cet effet"
  },
  State_66896_WeaponDesc = {
    Text = "Changez le coût en arithmetica de la carte avant de la jouer"
  },
  State_66900_Desc = {
    Text = "Cette carte augmente les dégâts, la guérison et le bouclier de [StateArg1]%"
  },
  State_66900_Name = {
    Text = "Désir Argenté"
  },
  State_66901_Desc = {
    Text = "Les Dommages infligés, les effets de Répondre et de Bouclier sont augmentés de [DescArg1] % pendant 1 tour"
  },
  State_66901_Name = {
    Text = "Fort temporaire"
  },
  State_66902_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Après la mort d'un Corps éveillé allié, obtenez <Block:[Block:StateArg1]> Bouclier du personnage, piochez sa carte « compétence » au coût le plus bas."
  },
  State_66902_Name = {
    Text = "Désir Argenté"
  },
  State_66971_Desc = {
    Text = "Lorsque la vie tombe à 0, elle devient 1 point et ne subit plus de dégâts"
  },
  State_66971_Name = {
    Text = "Monde coupé"
  },
  State_67234_Desc = {
    Text = "À la fin du tour, invoquer un « Cerveau dans un bocal clone » qui dure [Layer] <plural value=\"[Layer]\" singular=\"tour\" plural=\"tours\">."
  },
  State_67234_Name = {
    Text = "Séparation"
  },
  State_67235_Desc = {
    Text = "À la mort, restaurez toute vie, limite de vie +100%, libérez « peste de l'âme »"
  },
  State_67235_Name = {
    Text = "Non Réveillé"
  },
  State_67237_Desc = {
    Text = "Atteignant le niveau 10, l'intention change pour devenir « fin de l'illusion » : réduire à 1 la vie maximale de l'adversaire"
  },
  State_67237_Name = {Text = "Fin"},
  State_67238_Desc = {
    Text = "À la fin du tour, gagne 1 niveau \"fin\". Après avoir subi des dégâts mortels, retire cet état et deviens immunisé aux dégâts pour 1 tour, récupère 15% de vie et obtient 10 niveaux \"fin\""
  },
  State_67238_Name = {
    Text = "Peste des âmes"
  },
  State_67240_Desc = {
    Text = "\"Le Sage\" gagne 25 couches de <ReinforcePVEKeywords:Renforcé> temporaire et [Power:StateArg1] points de <PowerIconKeywords:Pouvoir> temporaire, supprimant cet état."
  },
  State_67240_Name = {
    Text = "<TuiyanColour: Déduction>"
  },
  State_67241_Desc = {
    Text = "À la mort, restaurez toute vie, limite de vie +100%, libérez « ferveur des chevaliers »"
  },
  State_67241_Name = {
    Text = "Non Réveillé"
  },
  State_67242_Desc = {
    Text = "À la mort, restaurez toute vie, limite de vie +100%, libérez « esprit et chair @1 point »"
  },
  State_67242_Name = {
    Text = "Non Réveillé"
  },
  State_67243_Desc = {
    Text = "À la fin du tour, invoquez un clone « cerveau dans un bocal ». Lorsque le clone « cerveau dans un bocal » déclenche « séparation de l'essence », il vole en plus 5% de votre force."
  },
  State_67243_Name = {
    Text = "âme et chair@1 point"
  },
  State_67245_Desc = {
    Text = "À la fin du tour, obtient [StateArg1] points de <PowerIconKeywords:pouvoir>"
  },
  State_67245_Name = {
    Text = "Chevalier ardent"
  },
  State_67246_Desc = {
    Text = "À chaque fois que le bouclier est brisé pour la première fois par tour, perdez 25% de vos PV Max, obtenez [Power:DescArg1] points de <PowerIconKeywords:Force Temporaire> et [Layer] couches de renforcement temporaire. Au début du tour suivant, regagnez <Block:[Block:DescArg2]> couches de bouclier, et obtenez 1 bouclier supplémentaire chaque fois que « Credo du Chevalier » est déclenché."
  },
  State_67246_Name = {
    Text = "Credo du Chevalier"
  },
  State_67247_Desc = {
    Text = "À la fin de chaque tour, vous obtiendrez des ennemis, avec un maximum de 2 ennemis simultanément. Lorsque les ennemis meurent, « Cerveau Corrompu » perd 5% de sa santé max"
  },
  State_67247_Name = {
    Text = "Porte des Abysses"
  },
  State_67252_Desc = {
    Text = "Lorsqu'il subit des dégâts mortels, il se déplace à l'arrière et conserve 1 point de vie, ne pouvant plus subir de dégâts, <PowerIconKeywords:pouvoir> augmente de [DescArg1]. L'auto-explosion ne déclenche pas cet effet"
  },
  State_67252_Name = {
    Text = "Séparation d'essence"
  },
  State_67253_Desc = {
    Text = "Après avoir joué [Layer] cartes, générez 1 « cerveau dans un bocal » devant vous, au maximum 3 parties peuvent exister en même temps"
  },
  State_67253_Name = {
    Text = "Cerveau dans une Cuve"
  },
  State_67255_Desc = {
    Text = "À la mort, restaurez toute vie, limite de vie +100%, libérez « première philosophie »"
  },
  State_67255_Name = {
    Text = "Non Réveillé"
  },
  State_67256_Desc = {
    Text = "Après la phase de pioche, trois cartes de commandement sont affichées au hasard à partir de la main, choisissez-en une pour recevoir l'oraison « Écho », défaussez les autres cartes"
  },
  State_67256_Name = {
    Text = "Première philosophie"
  },
  State_67257_Desc = {
    Text = "Après la première activation de clé à chaque tour, tous les réveilleurs reçoivent 10 points de folie, mais l'activation de clé coûte 10% de plus indéfiniment"
  },
  State_67257_Name = {
    Text = "Lien qui se rompt progressivement"
  },
  State_67258_Desc = {
    Text = "Au début de la bataille, obtenez <Block:[Block:DescArg1]> couches de bouclier. À la fin du tour, le bouclier ne disparaît pas"
  },
  State_67258_Name = {
    Text = "Résolution du Chevalier"
  },
  State_67347_Desc = {
    Text = ": Lorsqu'elle est en main, si la carte du dessus de la pile de pioche est une carte de commande, elle devient sa copie ayant un coût d'énergie réduit de -1"
  },
  State_67347_Name = {
    Text = "Maîtriser les principes de tout"
  },
  State_67353_Desc = {
    Text = "Après la mort, « cerveau en décomposition » perd 5% de la santé max"
  },
  State_67353_Name = {Text = "Fusion"},
  State_67358_Desc = {
    Text = "Chaque fois qu'un joueur dépense 1 point d'arithmetica, il gagne immédiatement <Block:[Block:StateArg1]> points de bouclier et 3 couches de renforcement temporaire"
  },
  State_67358_Name = {
    Text = "Barrière aléatoire"
  },
  State_67414_Desc = {
    Text = "Des yeux qu'on ne peut pas affronter. Une présence qu'on ne peut pas contredire. Même tous les fragments peuvent rester des fragments. Maintenant, fais face à la fin inévitable de la destruction"
  },
  State_67414_Name = {
    Text = "Affronte des milliers d'Origines"
  },
  State_67418_Desc = {
    Text = "Jouez-le puis défaussez toutes les autres cartes sauf cet éveilleur, en gagnant 5 cartes aléatoires non-éveilleuses ; cela ne prend effet qu'une seule fois par bataille."
  },
  State_67418_Name = {
    Text = "<WhiteQuality:haute théorie du plaisir>"
  },
  State_67419_Desc = {
    Text = "Après avoir joué, obtenez 3 copies de base avec <RetainIconKeywords:retain> et <DepleteIconKeywords:exhaust> et réduisez leur coût en Arithmetica de 1, n'ayant d'effet qu'une seule fois par bataille."
  },
  State_67419_Name = {
    Text = "<WhiteQuality:haute théorie de la reproduction>"
  },
  State_67420_Desc = {
    Text = "Après avoir joué, piochez 4 cartes et réduisez leur coût en Arithmetica par le coût réel en Arithmetica de la carte d'Oraison, n'ayant d'effet qu'une seule fois par bataille."
  },
  State_67420_Name = {
    Text = "<WhiteQuality:Adv. Lex Nous>"
  },
  State_67598_Desc = {
    Text = "Après avoir libéré l'exaltation, placez une carte aléatoire correspondante au réveilleur dans votre main, cette carte obtient <DepleteIconKeywords:épuiser> et <NothingnessIconKeywords:illusion>. À la fin de la bataille, récupérez [DescArg1] points de vie"
  },
  State_67598_Name = {
    Text = "mallette du médecin"
  },
  State_67599_Desc = {
    Text = "Après avoir joué une Carte d'instruction qui n'est ni « Attaque » ni « Défense », le Corps éveillé correspondant obtient 15 points de Fureur, déclenchable jusqu'à 5 fois par tour. Lors de la première activation de chaque tour, la carte jouée est également renvoyée en main."
  },
  State_67599_Name = {
    Text = "Pendule temporel·Projectile"
  },
  State_67600_Desc = {
    Text = "Augmente la puissance arithmetica de 4. Chaque fois que la pile de cartes est réinitialisée, ajoutez 4<DerivativeCardKeywords_4:« inspiration »> à la pile de tirage"
  },
  State_67600_Name = {
    Text = "Béni·Bougie Noire"
  },
  State_67602_Name = {Text = "Obsolète"},
  State_67603_Desc = {
    Text = "Les dégâts infligés aux ennemis en état négatif augmentent de 20%, et le tueur gagne 20 folie"
  },
  State_67603_Name = {
    Text = "Béquille de prêtre"
  },
  State_67604_Desc = {
    Text = "Chaque fois qu'une carte d'instruction appartenant à un éveillé différent de la précédente est jouée, cet éveillé gagne 3 points de fureur et accumule 1 couche de « Vitalité ». Lorsque 10 couches sont accumulées, toutes les « Vitalités » sont réinitialisées, et une carte d'instruction aléatoire avec une consommation d'Arithmetica réduite de 1 est placée dans la main de chaque éveillé, avec la condition de « Consommation », déclenchable au maximum 1 fois par tour."
  },
  State_67604_Name = {
    Text = "Pendule temporel·Évolution"
  },
  State_67605_Desc = {
    Text = "Lorsque vous possédez un bouclier, cette relique fournit [DescArg1] points temporaires de <PowerIconKeywords: force>. Lorsque votre bouclier dépasse votre vie actuelle, elle fournit également [DescArg2] points temporaires de <PowerIconKeywords: force>"
  },
  State_67605_Name = {
    Text = "Plume de pigeon"
  },
  State_67606_Desc = {
    Text = "Au début du tour, pour chaque ennemi, gagne 1 arithmetica. Lorsque tu tues un ennemi par des dégâts actifs, inflige des dégâts de saignement égaux aux dégâts excédentaires à d'autres ennemis.<BleedingIconKeywords:saignement>"
  },
  State_67606_Name = {
    Text = "Chant de la populace"
  },
  State_67607_Desc = {
    Text = "Après avoir libéré 5 exaltations, faites en sorte que le réveilleur qui libère l'exalter obtienne 100 de folie"
  },
  State_67607_Name = {
    Text = "Petit berceau"
  },
  State_67608_Name = {Text = "Obsolète"},
  State_67609_Desc = {
    Text = "Après avoir libéré l'exalter, perdez 8% de votre vie actuelle, volez à tous les ennemis [DescArg1] points de <PowerIconKeywords: pouvoir> temporaire, si un seul ennemi, volez en plus [DescArg2] points de <PowerIconKeywords: pouvoir> temporaire"
  },
  State_67609_Name = {
    Text = "Oiseau du Rituel de Malchance"
  },
  State_67611_Desc = {
    Text = "Doublez les dégâts subis par tous les ennemis tous les 2 tours, et à chaque exaltation dans ce tour, dispersez aléatoirement 1 état négatif"
  },
  State_67611_Name = {
    Text = "Bénédiction·Cadavre de la Voie"
  },
  State_67612_Desc = {
    Text = "Tous les « coups » augmentent les dégâts critiques de 20%. Lors de la collecte, ajoutez 1 carte <DerivativeCardKeywords_40: « instant décisif »> à votre main"
  },
  State_67612_Name = {
    Text = "Moment de beauté β"
  },
  State_67614_Desc = {
    Text = "Au début de chaque tour, tous les réveilleurs gagnent 25 points de folie. Lors de la collecte, la santé max devient 1,5 fois"
  },
  State_67614_Name = {
    Text = "Béni par l'apparence des cauchemars β"
  },
  State_67615_Desc = {
    Text = "La sixième carte de commandement jouée revient de la pile de défausse à votre main"
  },
  State_67615_Name = {
    Text = "Dans la lumière du crépuscule"
  },
  State_67616_Name = {Text = "Obsolète"},
  State_67618_Desc = {
    Text = "Au début de chaque tour, tous les réveilleurs gagnent 25 points de folie. Lors de la collecte, la santé max devient 1,5 fois"
  },
  State_67619_Desc = {
    Text = "Limite de cartes à main augmentée de 5. En ramassant, complétez votre main à la limite. Au début du tour, tirez 1 carte supplémentaire, et à la fin du tour, défaussez toutes les cartes de symptôme et d'état dans votre main, conservez les autres"
  },
  State_67619_Name = {
    Text = "Béni par l'empreinte de la conscience β"
  },
  State_67620_Desc = {
    Text = "Après avoir joué la 3e carte à chaque tour, placez 1 <DerivativeCardKeywords_4:\"Inspiration\"> dans la pile de défausse. Après avoir joué la 6e carte à chaque tour, placez 1 <DerivativeCardKeywords_4:\"Inspiration\"> de la pile de défausse dans votre main."
  },
  State_67620_Name = {
    Text = "Lumière de la civilisation"
  },
  State_67621_Desc = {
    Text = "Après avoir libéré l'exaltation, gagnez [DescArg1] points temporaires de pouvoir et volez [DescArg1] points temporaires de <PowerIconKeywords:pouvoir> à tous les ennemis, si un seul ennemi, volez [DescArg2] points supplémentaires de pouvoir temporaire"
  },
  State_67621_Name = {
    Text = "Béni par l'oiseau du rituel de malheur"
  },
  State_67622_Desc = {
    Text = "Lorsque tu épuises tes 1 dernier point de puissance arithmétique, tu obtiens 2 points de puissance. Peut être déclenché 2 fois par tour au maximum"
  },
  State_67622_Name = {
    Text = "Differenciateur Argent-Blanc"
  },
  State_67623_Desc = {
    Text = "Après la collecte, gagner de manière permanente [DescArg1] <PowerIconKeywords:puissance>. Chaque fois que des dégâts sont infligés, récupérer [DescArg2] points de vie, jusqu'à 6 fois par tour"
  },
  State_67623_Name = {
    Text = "Béni par le baiser de la lamproie"
  },
  State_67624_Name = {Text = "Obsolète"},
  State_67625_Desc = {
    Text = "Lors de la première utilisation d'une carte de commandement entrant dans la pile de défausse par tour, la consommation d'arithmétique de cette carte temporaire est réduite de 1 et est mélangée dans la pile de pioche"
  },
  State_67625_Name = {
    Text = "Phonographe muet"
  },
  State_67626_Desc = {
    Text = "Capacité maximale augmentée de 1. Lorsque vous jouez consécutivement 2 cartes avec une consommation de calcul plus élevée que la précédente, obtenez 1 capacité"
  },
  State_67626_Name = {
    Text = "Record d'Alcana"
  },
  State_67628_Name = {Text = "Obsolète"},
  State_67630_Name = {Text = "Obsolète"},
  State_67631_Desc = {
    Text = "Augmente la puissance arithmetica de 2. Chaque fois que la pile de cartes est réinitialisée, ajoutez 1<DerivativeCardKeywords_9:« trébucher »> à la pile de tirage"
  },
  State_67631_Name = {
    Text = "Bougie Noire"
  },
  State_67632_Name = {Text = "Obsolète"},
  State_67634_Desc = {
    Text = "À la fin du tour, chaque carte non jouée dans la main donne 2 points de folie à tous les éveillés"
  },
  State_67634_Name = {
    Text = "Balance Déséquilibrée"
  },
  State_67635_Desc = {
    Text = "Quand ramassé, tous les Réveilleurs gagnent 50 points d'Aliemus, et mélangez 2 <DerivativeCardKeywords_1:\"Écho Éthéré\"> dans la pile de pioche."
  },
  State_67635_Name = {
    Text = "Équipement de communication +β"
  },
  State_67636_Desc = {
    Text = "Dégâts critiques augmentés de 15%. Les dégâts infligés aux ennemis avec bouclier sont toujours critiques"
  },
  State_67636_Name = {
    Text = "Principes esthétiques"
  },
  State_67637_Desc = {
    Text = "Au début du tour, tire 2 cartes, et obtient 2 points de puissance de calcul. Chaque fois que tu tires une carte de commande ou réveille de gnose, modifie aléatoirement sa consommation de puissance de calcul (0-4)"
  },
  State_67637_Name = {
    Text = "Chapeau de magicien"
  },
  State_67638_Desc = {
    Text = "Les dégâts infligés aux ennemis en état négatif augmentent de 50 %, et le tueur gagne 100 folie après avoir tué un ennemi"
  },
  State_67638_Name = {
    Text = "Béquille de prêtre+"
  },
  State_67639_Desc = {
    Text = "Taux critique augmenté de 50 %, les dégâts critiques augmentés de 100 %"
  },
  State_67639_Name = {
    Text = "Béni par la griffe étrange"
  },
  State_67640_Desc = {
    Text = "Taux critique et dégâts critiques augmentent de 100 %. Pour chaque point de dégâts infligé/dégâts de tentacule, ce tour : tous les dégâts critiques des réveilleurs diminuent de 10 %, au maximum de 50 %. Le poison infligé et le contre-offensif augmentent de 10 %, au maximum de 50 %"
  },
  State_67640_Name = {
    Text = "Pendule temporel·Shift Surge"
  },
  State_67641_Desc = {
    Text = "Après avoir libéré l'exaltation, gagnez [DescArg1] points temporaires de <PowerIconKeywords:pouvoir>"
  },
  State_67641_Name = {
    Text = "Verrouillage lourd"
  },
  State_67643_Desc = {
    Text = "Lors de la causation de dégâts actifs, obtenir [DescArg1] points de bouclier. Lors de la récupération de vie, obtenir [DescArg2] points temporaires <PowerIconKeywords:pouvoir>"
  },
  State_67643_Name = {
    Text = "Notre maison"
  },
  State_67645_Desc = {
    Text = "Augmente le taux critique de 10 %. Après le premier coup critique de chaque tour, le taux critique augmente de 20 %, et après avoir infligé le 3ème coup critique de chaque tour, les dégâts critiques augmentent de 50 %"
  },
  State_67645_Name = {
    Text = "Vœux de fête"
  },
  State_67646_Desc = {
    Text = "À la fin du tour impair, si vous avez de l'arithmétique restante, piochez 2 cartes supplémentaires au prochain tour ; à la fin du tour pair, si vous avez des cartes restantes, obtenez 2 points d'arithmétique supplémentaires au prochain tour"
  },
  State_67646_Name = {
    Text = "Roue du Soleil et de la Lune"
  },
  State_67647_Desc = {
    Text = "Chaque 5ème carte de commandement jouée prendra effet 2 fois, puis retournera dans ta main"
  },
  State_67647_Name = {
    Text = "Vin des Étoiles+"
  },
  State_67649_Desc = {
    Text = "Masquer l'intention des monstres. Gagnez 1 point d'arithmetica par tour et piochez 1 carte"
  },
  State_67649_Name = {
    Text = "Gambit Clochette"
  },
  State_67650_Desc = {
    Text = "\"Attaque\" et \"Défense\" gagnent 50 Keyflare supplémentaires. Chaque fois que vous jouez une carte avec un coût d'Arithmetica de 2 ou plus, piochez une carte avec un coût d'Arithmetica de 1 et réduisez son coût à 0, jusqu'à 3 fois par tour."
  },
  State_67650_Name = {
    Text = "Pendule temporel·Jumeaux"
  },
  State_67651_Desc = {
    Text = "Lors de la collecte, la maîtrise du royaume de l'équipe devient 150% de la valeur d'origine. Après avoir joué la 5ème carte d'ordre de chaque tour, tous les réveilleurs gagnent 20 points de folie"
  },
  State_67651_Name = {
    Text = "Pendule temporel·Impur"
  },
  State_67653_Desc = {
    Text = "Après avoir utilisé l'exultation deux fois par tour, tous les réveilleurs obtiennent 8 points de folie, après trois fois d'utilisation, tous les réveilleurs obtiennent à nouveau 8 points de folie"
  },
  State_67653_Name = {
    Text = "Sang des Oubliés"
  },
  State_67654_Name = {
    Text = "Effet supplémentaire [DescArg1] fois"
  },
  State_67656_Desc = {
    Text = "Taux critique augmenté de 50 %, <FragileIconKeywords:fragile> pour 3 tours"
  },
  State_67656_Name = {
    Text = "Griffe étrange"
  },
  State_67657_Desc = {
    Text = "Au début du tour, tire 1 carte. Après avoir joué deux fois des cartes avec la même consommation de puissance que la carte précédente, tire une carte supplémentaire, maximum 3 fois par tour"
  },
  State_67657_Name = {
    Text = "Rituel de Gnosis Omnisciente"
  },
  State_67658_Desc = {
    Text = "En jouant une carte ayant un coût en arithmetica réel de 3, tirez 1 carte et gagnez 2 en arithmetica ; en jouant une carte ayant un coût en arithmetica réel de 4 ou plus, le coût en arithmetica des autres cartes en main est réduit de 1"
  },
  State_67658_Name = {
    Text = "Pendule temporel·Œil"
  },
  State_67659_Desc = {
    Text = "Au début du tour, pour chaque ennemi, gagner 2 arithmetica. En tuant un ennemi par des dégâts actifs, infliger des dégâts d'excès doubles aux autres ennemis <BleedingIconKeywords: saignement>"
  },
  State_67659_Name = {
    Text = "Chant de la populace+"
  },
  State_67660_Desc = {
    Text = "Après chaque 3ème utilisation de « coup », infligez [DescArg1] points de dégâts à tous les ennemis et accordez 15 points de colère au réveilleur correspondant"
  },
  State_67660_Name = {
    Text = "Lame de Saule Rouillée"
  },
  State_67661_Desc = {
    Text = "Chaque fois que vous consommez de l'arithmetica, piochez 1 carte, maximum 5 fois par tour. Chaque fois que le paquet est réinitialisé, obtenez 2 points d'arithmetica"
  },
  State_67661_Name = {
    Text = "Pendule temporel·Insomnie"
  },
  State_67662_Desc = {
    Text = "Chaque fois que vous jouez une carte non-éveillée, l'éveillé avec le moins de folie gagne 10 folie"
  },
  State_67662_Name = {
    Text = "Carnet de Timbres Exotiques"
  },
  State_67665_Desc = {
    Text = "Arithmetica Max augmenté de 2. Après avoir joué « Attaque » ou « Défense », le réveilleur correspondant obtient 5 points de fureur. Après avoir libéré l'Exaltation, obtenez 1 « Attaque » ayant un coût en Vide attaché au réveilleur correspondant, après avoir libéré le Décret Clé, obtenez aléatoirement 1 « Défense » ayant un coût en Vide attaché."
  },
  State_67665_Name = {
    Text = "Pendule temporel·Aile"
  },
  State_67666_Desc = {
    Text = "Chaque fois que des dégâts sont causés, obtenez [DescArg1] points de <PowerIconKeywords:pouvoir> temporairement, empilable jusqu'à 3 fois. Lorsque le potentiel est au maximum, l'effet est doublé"
  },
  State_67666_Name = {
    Text = "Agate Enroulée"
  },
  State_67667_Desc = {
    Text = "Après la fin du tour, tous les réveilleurs obtiennent 5 folie. Pour chaque point d'arsenal restant, tous les réveilleurs reçoivent en plus 3 folie"
  },
  State_67667_Name = {
    Text = "Batterie prototype"
  },
  State_67668_Desc = {
    Text = "Augmente les dégâts critiques de 15 %. Augmente le taux critique de \"Frappe\" de 40 %"
  },
  State_67668_Name = {
    Text = "Bec de corbeau blanc"
  },
  State_67669_Name = {Text = "Obsolète"},
  State_67670_Desc = {
    Text = "Après avoir libéré l'exaltation, tirez 1 carte. Si vos points de vie sont inférieurs à 25%, tirez 1 carte supplémentaire"
  },
  State_67670_Name = {
    Text = "Cercle de Lecture pour la Connaissance"
  },
  State_67671_Desc = {
    Text = "Chaque fois qu'un dommage actif est infligé, restaurez [DescArg1] vie et infligez [DescArg2] couches <BleedingIconKeywords:saignement> à la cible blessée"
  },
  State_67671_Name = {
    Text = "Béni par la conscience des essaims"
  },
  State_67672_Desc = {
    Text = "L'effet de <WeaknessIconKeywords:faiblesse> infligé est augmenté de 8 %, et l'effet de <VulnerabilityIconKeywords:vulnérabilité> est augmenté de 25 %. En appliquant <WeaknessIconKeywords:faiblesse> ou <VulnerabilityIconKeywords:vulnérabilité>, vous volez temporairement [DescArg1] points de <PowerIconKeywords:force> à la cible."
  },
  State_67672_Name = {
    Text = "Photo délavée+"
  },
  State_67673_Desc = {
    Text = "Piochez 1 carte au début du tour"
  },
  State_67673_Name = {
    Text = "Boussole directionnelle"
  },
  State_67674_Desc = {
    Text = "Chaque fois que vous jouez une carte d'instruction, obtenez [DescArg2]% de <DeathResistanceIconKeywords:résistance à la mort> (dans ce niveau, chaque fois que la résistance à la mort est déclenchée, la résistance obtenue est réduite de moitié). Si votre <DeathResistanceIconKeywords:résistance à la mort> est supérieure ou égale à 100%, vous obtenez à la place [DescArg1] points de <PowerIconKeywords:force> temporaire."
  },
  State_67674_Name = {
    Text = "Peau de serpent mutant"
  },
  State_67675_Desc = {
    Text = "À la fin du tour, s'il y a des arsenaux restants, piocher 2 cartes supplémentaires au prochain tour ; s'il y a des cartes restantes, obtenir 2 points d'arsenal supplémentaires au prochain tour"
  },
  State_67675_Name = {
    Text = "Roue du Soleil et de la Lune+"
  },
  State_67677_Desc = {
    Text = "Lorsque tu infliges <WeaknessIconKeywords:faiblesse>, tu obtiens [DescArg1] points de bouclier ; en infligeant <VulnerabilityIconKeywords:vulnérable>, tu obtiens [DescArg2] points de <PowerIconKeywords:force> temporaire. Si ces deux effets sont déclenchés en un tour, tu obtiens en plus [DescArg1] points de bouclier et [DescArg2] points de <PowerIconKeywords:force> temporaire."
  },
  State_67677_Name = {
    Text = "Cadre lourd"
  },
  State_67703_Desc = {
    Text = "Au début du tour, si le nombre de cartes restantes à la fin du dernier tour est supérieur à 3, gagner 2 arithmetica"
  },
  State_67703_Name = {
    Text = "Badge de Missag"
  },
  State_67704_Desc = {
    Text = "Après avoir libéré l'exaltation de la folie, le réveilleur correspondant obtient 10 de folie et [DescArg1] points de bouclier"
  },
  State_67704_Name = {
    Text = "Voile du Dieu Sans Nom"
  },
  State_67796_Name = {
    Text = "<TongxiaoKeywords: compréhension de tous les principes> : Après utilisation, restauration, obtenez <Energy:[StateArg1]> points de folie"
  },
  State_67841_WeaponDesc = {
    Text = "Changez le coût en arithmetica de la carte avant de la jouer"
  },
  State_67844_Desc = {
    Text = "Après avoir subi des dégâts fatals, restaurez toute la vie et cela peut être déclenché @1 fois, actuellement déclenché [DescArg1] fois"
  },
  State_67844_Name = {
    Text = "Chaos éternel"
  },
  State_67866_Name = {
    Text = "<BleedingColour: Saignement>"
  },
  State_68298_Desc = {
    Text = "Après avoir subi des dommages critiques, changez d'intention en « Regard de l'Abîme » et obtenez 80 couches de renforcement temporaire, restaurez toute la vie et cela peut être déclenché [DescArg1] fois. À la fin du tour, retirez 20 couches de renforcement."
  },
  State_68298_Name = {
    Text = "Poussière d'étoiles"
  },
  State_68554_Desc = {
    Text = "Après avoir subi des dommages critiques, restaurez toute la vie et supprimez cet état lorsque tous les autres ennemis sont morts. Cet effet peut être déclenché @1 fois, actuellement déclenché [DescArg1] fois."
  },
  State_68554_Name = {
    Text = "Éclats de Chaos Éternel"
  },
  State_68621_Desc = {
    Text = "Au début du combat et à la fin de chaque tour, obtient 2 couches temporaires de <ResentChainsKeywords:Chaîne de Rancœur>."
  },
  State_68621_Name = {
    Text = "Courant Étrange"
  },
  State_68622_Desc = {
    Text = "L'effet <PowerIconKeywords:force> appliqué par les éveillés est réduit de 75 %. À chaque fois que vous perdez des points de vie, vous obtenez <Block:[Block:DescArg1]> points de bouclier et 1 couche de renforcement temporaire."
  },
  State_68622_Name = {
    Text = "Flux de la Croyance Maléfique"
  },
  State_68623_Desc = {
    Text = "Chaque fois qu'une carte de commandement est jouée, défaussez une carte du réveilleur ayant la consommation d'arithmétique la plus faible."
  },
  State_68623_Name = {
    Text = "Flux de Folie"
  },
  State_68624_Desc = {
    Text = "À la fin du tour, récupère 10 % des PV perdus, dissipe les états négatifs du personnage et les états positifs du joueur."
  },
  State_68624_Name = {
    Text = "Flux de l'Arrivée"
  },
  State_68626_Desc = {
    Text = "L'Aliemus de base de tous les Corps éveillés augmente de 50 %. À la fin de chaque tour, tous les Corps éveillés perdent 10 points de Fureur et récupèrent 3 % de leurs PV Max."
  },
  State_68626_Name = {
    Text = "Flux de Terreur"
  },
  State_68627_Desc = {
    Text = "Au début du combat, obtenez 15 couches de « barrière temporaire ». À la fin du tour, obtenez 15 couches de « barrière temporaire » et appliquez « dissolution temporaire » sur 10 cartes aléatoires."
  },
  State_68627_Name = {
    Text = "Courant Glacé"
  },
  State_68632_Desc = {
    Text = "Toutes les cartes de commandement voient leur consommation d'arithmétique augmenter de 1. Tous les 3 tours, ajoutez 1 carte « Pétrification progressive » à la main à la fin du tour."
  },
  State_68632_Name = {
    Text = "Torrent de Lamentations"
  },
  State_68635_Name = {
    Text = "Cœur d'argent pur· Peur"
  },
  State_68637_Desc = {
    Text = "Lors de la perte de PV, réduisez le nombre de charges correspondant. À 0 charges, le joueur obtient 2 couches de Bouclier Temporaire, gagne [DescArg1] couches de Bouclier et [DescArg2] couches de Forteresse temporaire, et récupère [DescArg3] couches de Barrière dimensionnelle."
  },
  State_68637_Name = {
    Text = "Barrière dimensionnelle"
  },
  State_68638_Name = {
    Text = "Cœur d'argent pur· Hérésie"
  },
  State_68646_Desc = {
    Text = "Les dégâts de base et la valeur du bouclier sont augmentés de 200 %, mais la carte est épuisée après avoir été jouée."
  },
  State_68646_Name = {
    Text = "<RedQuality1:Dissolution Temporaire>"
  },
  State_68647_Name = {
    Text = "« Noyau de ton pur · Folie »"
  },
  State_68680_Desc = {
    Text = "Supprimer les éclats anciens"
  },
  State_68680_Name = {
    Text = "Supprimer les éclats anciens"
  },
  State_68704_Desc = {
    Text = "Il reste [DescArg1] tours avant l'arrivée véritable de Tohuwabohu..."
  },
  State_68704_Name = {Text = "Descendre"},
  State_68829_Desc = {
    Text = "Lorsque vous subissez des Dégâts Directs ou des Dégâts des tentacules, immunisé aux dégâts et perdez 1 stack. Supprimé au début du tour."
  },
  State_68829_Name = {
    Text = "<ParcloseColour: Barrière Temporaire>"
  },
  State_68829_WeaponDesc = {
    Text = "Dégâts reçus -99%. À chaque fois que des dégâts sont reçus, perd 1 charge."
  },
  State_70026_Desc = {
    Text = "Cette carte possède « Garder », après avoir été jouée, le taux de coup critique temporaire de tous les éveilleurs augmente de [StateArg1] % et « Domination Immortelle » est retirée. Si le royaume actuel est Aequor, obtenez 1 point d'arithmetica après le retrait de « Domination Immortelle »."
  },
  State_70026_Name = {
    Text = "<OrangeQuality:Domination immortelle>"
  },
  State_70031_Desc = {
    Text = "Équipe Unique : Au début du combat, conférez à toutes les cartes d'instruction du porteur dans la pioche ayant un coût d'arithmetica supérieur ou égal à 3 l'effet « Domination Immortelle » : cette carte a « Garder », après l'avoir jouée, le taux de coup critique temporaire de tous les éveilleurs augmente de <WeaponEffect_Num:[StateArg1]%> et retire « Domination Immortelle ». Si le royaume actuel est Aequor, gagnez 1 point d'arithmetica après le retrait de « Domination Immortelle »."
  },
  State_70031_WeaponDesc = {
    Text = "Au début de la bataille, conférez à toutes les cartes d'instruction du porteur dans la pioche ayant un coût d'arithmetica supérieur ou égal à 3 l'effet « Domination Immortelle » : cette carte possède « Garder », après avoir été jouée, le taux de coup critique temporaire de tous les éveilleurs augmente de <WeaponEffect_Num:[StateArg1]%> et retire « Domination Immortelle ». Si le royaume actuel est Aequor, vous gagnez 1 point d'arithmetica après le retrait de « Domination Immortelle »."
  },
  State_70182_Desc = {
    Text = "Tous les boucliers obtenus sont réduits de [DescArg1]%"
  },
  State_70182_Name = {
    Text = "<FragileColour:Fragile>"
  },
  State_70182_WeaponDesc = {
    Text = "Tous les boucliers obtenus sont réduits de 33%"
  },
  State_70277_Desc = {
    Text = "Lorsque vous subissez des Dégâts Directs ou des Dégâts des tentacules, [StateArg1]% des dégâts seront convertis en quantité de récupération pour la Forge Écarlate, durant [Layer] <plural value=\"[Layer]\" singular=\"tour\" plural=\"tours\">."
  },
  State_70277_Name = {
    Text = "Rite de Création"
  },
  State_70287_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : À la fin du tour, les Dommages, soins et effets de Bouclier du personnage des cartes « compétence » du Porteur dans votre main augmentent de [StateArg1] %."
  },
  State_70287_Name = {
    Text = "Trône de pierre bleue"
  },
  State_70288_Desc = {
    Text = "Les dégâts, soins et boucliers causés par cette carte augmentent de [DescArg1] %."
  },
  State_70288_Name = {
    Text = "Trône de pierre bleue"
  },
  State_70313_Desc = {
    Text = "Durant le combat de chef, au début du tour ainsi qu'après que « Fusion : Doll » ait libéré son exaltation, obtenez 1 niveau de « <Zhongmowuqiling:Fin> ». « Fin » peut accumuler jusqu'à un maximum de 10 niveaux, et en atteignant 10 niveaux, placez 1 carte « Fin du Néant » dans votre main."
  },
  State_70313_Name = {
    Text = "Chemin de l'Annihilation"
  },
  State_70318_Desc = {
    Text = "Inflige [StateArg1] <plural value=\"[StateArg1]\" singular=\"tour\" plural=\"tours\"> de <VulnerabilityIconKeywords:Vulnérable> à tous les ennemis, obtient 1 tour d'état «Excitation» : Amplification de Dégâts de l'équipe +[StateArg2]%."
  },
  State_70318_Name = {Text = "Excitation"},
  State_70322_Desc = {
    Text = "Lorsque vous possédez 10 niveaux de « fin », ajoutez 1 carte « Fin du néant » dans votre main."
  },
  State_70322_Name = {Text = "Fin"},
  State_70330_Desc = {
    Text = "Gagne 1 tour d'état « Excitation » : l'Amplification de Dégâts de l'équipe est augmentée de [Arg2]%."
  },
  State_70330_Name = {Text = "Excitation"},
  State_70346_Desc = {
    Text = "Inflige [StateArg1] tours de <WeaknessIconKeywords:faiblesse> à tous les ennemis et réduit leur <PowerIconKeywords:force> de [Exhaustion:StateArg3] points pendant ce tour."
  },
  State_70346_Name = {
    Text = "malédiction"
  },
  State_70347_Desc = {
    Text = "Fait que tous les ennemis subissent une réduction de [Exhaustion:StateArg3] points de <PowerIconKeywords:force> pendant ce tour."
  },
  State_70347_Name = {
    Text = "malédiction"
  },
  State_70374_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Les [StateArg1] premières fois par tour où le Porteur reçoit une Attaque, inflige <PVPEmptinessKeywords:Vide> à l'attaquant."
  },
  State_70374_Name = {
    Text = "Marionnette du Néant"
  },
  State_70379_Desc = {
    Text = "Inflige <PVPEmptinessKeywords:Vide> à l'attaquant. Retire cet État après avoir reçu une Attaque."
  },
  State_70379_Name = {
    Text = "Contre-attaque du Vide"
  },
  State_70443_Desc = {
    Text = "Lorsque vous possédez 10 niveaux de « fin », ajoutez 1 carte « Fin du néant » dans votre main."
  },
  State_70443_Name = {Text = "Fin"},
  State_70539_Name = {
    Text = "Peste des âmes"
  },
  State_70589_Desc = {
    Text = "Lorsque vous jouez 2 cartes consécutives ayant une consommation d'arithmétique inférieure à celle de la carte précédente, appliquez 40/80 couches de poison à tous les ennemis. Peut se déclencher jusqu'à 5 fois par tour."
  },
  State_70590_Desc = {
    Text = "La première fois que vous utilisez directement l'embryon chaque tour, les dégâts actifs infligent des saignements équivalents à 15/30 % des dégâts infligés ce tour-ci."
  },
  State_70593_Desc = {
    Text = "Après avoir joué une carte de commandement non dérivée, mélangez 1 à 2 copies temporaires de cette carte dont la consommation d'arithmétique est réduite de 2 dans la pile de pioche. Temps de recharge : 3 tours."
  },
  State_70594_Desc = {
    Text = "À la fin du tour, si vous êtes en posture de vagues montantes, obtenez 32/64 points de dégâts de tentacule, temps de refroidissement de 3 tours."
  },
  State_70595_Desc = {
    Text = "Au début de la bataille, appliquez 1280 couches de poison à tous les ennemis. L'effet est doublé lors des combats de boss."
  },
  State_70598_Desc = {
    Text = "Chaque fois qu'une carte entre dans l'espace dimensionnel, si cette carte appartient à un propriétaire différent des autres cartes de cet espace, ajoutez 1 ou 2 cartes « Inspiration » à votre main."
  },
  State_70600_Desc = {
    Text = "À la fin du tour, récupère 32 points de vie."
  },
  State_70600_Name = {Text = "Sang Béni"},
  State_70602_Desc = {
    Text = "Utiliser l'Éveil de la clé d'argent et piocher 4 cartes."
  },
  State_70603_Desc = {
    Text = "Utiliser l'Éveil de la clé d'argent puis tous les réveilleurs obtiennent 10 points de folie."
  },
  State_70605_Desc = {
    Text = "Utiliser l'Éveil de la clé d'argent et obtenir 32 points de force."
  },
  State_70607_Desc = {
    Text = "Lorsque vous jouez 2 cartes consécutives avec une consommation de puissance supérieure à celle de la carte précédente, obtenez 24/48 points de riposte, maximum 5 fois par tour."
  },
  State_70609_Desc = {
    Text = "Utiliser l'Éveil de la clé d'argent et obtenir 96 points de bouclier."
  },
  State_70609_Name = {
    Text = "Spécimen de papillon"
  },
  State_70611_Desc = {
    Text = "Utiliser l'Éveil de la clé d'argent permet d'augmenter les dégâts de base de tous les éveillés de 25 %/50 %."
  },
  State_70614_Name = {
    Text = "Laser Mandibule+"
  },
  State_70617_Desc = {
    Text = "Les dégâts infligés lors des cinq premiers coups de chaque tour sont augmentés de 15 %/30 %."
  },
  State_70618_Desc = {
    Text = "Piochez 1 carte au début du tour"
  },
  State_70619_Desc = {
    Text = "« Frappe » inflige 10 %/20 % des dégâts sous forme de poison, jusqu'à 320/640 points par tour."
  },
  State_70620_Desc = {
    Text = "Lorsque vous subissez une attaque ennemie, infligez-lui des Dégâts Fixes égaux à 25 %/50 % des PV Max de votre équipe, ces dégâts bénéficient d'un bonus de Contre-attaque de 100 %/200 %, avec un maximum de 1 déclenchement par ennemi et par tour."
  },
  State_70620_Name = {
    Text = "Couteau sacrificiel perdu"
  },
  State_70621_Desc = {
    Text = "Utiliser l'Éveil de la clé d'argent puis obtenir 192 points de bouclier."
  },
  State_70621_Name = {
    Text = "Échantillon de papillon+"
  },
  State_70623_Desc = {
    Text = "Au début de chaque tour, tous les éveillés gagnent 10 points de folie"
  },
  State_70624_Desc = {
    Text = "Utiliser l'Éveil de la clé d'argent puis tous les réveilleurs obtiennent 20 points de folie."
  },
  State_70628_Desc = {
    Text = "Piochez 2 cartes au début du tour."
  },
  State_70629_Desc = {
    Text = "Lors de la première dévoration de chaque tour, les autres éveillés gagnent 10/20 points de folie."
  },
  State_70635_Desc = {
    Text = "Utiliser l'Éveil de la clé d'argent pour obtenir 416 points de riposte."
  },
  State_70636_Desc = {
    Text = "Perdez de la vie et obtenez un montant de fournaise cramoisie équivalent à 10 % / 20 % de la vie perdue."
  },
  State_70637_Desc = {
    Text = "Au début de la bataille, la limite de tentacules augmente de 1/2 et vous obtenez 1/2 tentacule."
  },
  State_70641_Desc = {
    Text = "Obtenez 160/320 boucliers, 3 tours de temps de recharge."
  },
  State_70641_Name = {
    Text = "Montre à Hypercorde"
  },
  State_70643_Desc = {
    Text = "Au début du tour, gagner 1 arithmetica"
  },
  State_70644_Desc = {
    Text = "Après avoir libéré l'exaltation, gagnez 16/32 points temporaires de pouvoir."
  },
  State_70645_Desc = {
    Text = "Au début du tour, gagner 2 arithmetica."
  },
  State_70646_Name = {
    Text = "Couteau sacrificiel perdu+"
  },
  State_70647_Desc = {
    Text = "Tous les éveillés voient leurs dégâts de base augmenter de 30 %."
  },
  State_70648_Desc = {
    Text = "Au début de la bataille, appliquez 640 couches de poison à tous les ennemis. L'effet est doublé lors des combats de boss."
  },
  State_70656_Desc = {
    Text = "« Frappe » inflige une fois supplémentaire la moitié des dégâts équivalents à 60 % de l'attaque de l'éveillé, avec un maximum de 3 déclenchements par tour."
  },
  State_70657_Desc = {
    Text = "Au début du combat, obtenez 32 points de puissance."
  },
  State_70660_Desc = {
    Text = "Au début de la bataille, obtenez 64 points de pouvoir."
  },
  State_70661_Desc = {
    Text = "À la fin du tour, récupère 64 points de vie."
  },
  State_70661_Name = {
    Text = "Sang de Grâce+"
  },
  State_70662_Desc = {
    Text = "Utiliser l'Éveil de la clé d'argent puis obtenir 2 points d'arithmetica."
  },
  State_70664_Desc = {
    Text = "Utiliser l'Éveil de la clé d'argent et obtenir 16 points de force."
  },
  State_70666_Desc = {
    Text = "Après le début de la bataille, obtenez 100/200 points de maîtrise des domaines. Tous les réveilleurs voient leurs empoisonnements de base ainsi que les empoisonnements infligés par les créations augmenter de 10 %/20 %."
  },
  State_70667_Desc = {
    Text = "Utiliser l'Éveil de la clé d'argent et obtenir 4 points d'arithmetica."
  },
  State_70670_Desc = {
    Text = "Au début de la bataille, obtenez 320 points de riposte, l'effet est doublé en combat de boss."
  },
  State_70671_Desc = {
    Text = "Après être entré dans un tour ultra, la première carte de commandement non dérivée jouée prendra effet supplémentaire 1 ou 2 fois."
  },
  State_70678_Desc = {
    Text = "Au début de la bataille, obtenez 640 points de contre-attaque, l'effet est doublé en combat de boss."
  },
  State_70681_Desc = {
    Text = "Tous les éveillés voient leurs dégâts de base augmenter de 60 %."
  },
  State_70682_Desc = {
    Text = "Lorsque le nombre de cartes en main est inférieur ou égal à 2, piochez 1 ou 2 cartes, maximum 2 fois par tour."
  },
  State_70683_Desc = {
    Text = "Annihilez pour que l'éveillé avec le moins de folie gagne 50/100 points de folie, avec un temps de recharge de 3 tours."
  },
  State_70684_Desc = {
    Text = "Au début du tour, si la vie est inférieure à 25 %, obtenez 72/144 points de force temporaire."
  },
  State_70685_Desc = {
    Text = "Utiliser l'Éveil de la clé d'argent puis infliger 416 niveaux de poison à tous les ennemis."
  },
  State_70686_Desc = {
    Text = "Après avoir déclenché l'Exaltation, tous les ennemis subissent des <FixedDamage:DGT Purs> égaux à 15%/30% de vos PV Max et se voient infliger 10%/20% de Poison."
  },
  State_70687_Name = {
    Text = "Montre à Hypercorde+"
  },
  State_70689_Desc = {
    Text = "Utiliser l'Éveil de la clé d'argent puis infliger 832 niveaux de poison à tous les ennemis."
  },
  State_70690_Desc = {
    Text = "Après le début de la bataille, obtenez 100/200 points de maîtrise des domaines. Tous les réveilleurs voient leurs contre-attaques de base ainsi que les contre-attaques infligées par les créations augmenter de 10 %/20 %."
  },
  State_70691_Desc = {
    Text = "Chaque fois que des dégâts sont infligés, obtenez 4/8 points de force temporaire, jusqu'à 15 fois par tour."
  },
  State_70693_Desc = {
    Text = "La quantité automatiquement obtenue de fusion d'embryon est augmentée de 100 % / 200 %."
  },
  State_70694_Desc = {
    Text = "Utiliser l'Éveil de la clé d'argent, puis piocher 2 cartes."
  },
  State_70695_Desc = {
    Text = "Au début de chaque tour, tous les éveillés gagnent 5 points de folie."
  },
  State_70696_Desc = {
    Text = "Utiliser l'Éveil de la clé d'argent et obtenir 208 points de riposte."
  },
  State_70698_Desc = {
    Text = "La défense obtient 200/400 de riposte temporaire, déclenchable jusqu'à 3 fois par tour."
  },
  State_70804_Name = {
    Text = "Délai de vie ou de mort"
  },
  State_70805_Desc = {
    Text = "Au début de la bataille, appliquez 1/2 couche de faiblesse à tous les ennemis, l'effet est doublé sur les boss. Tous les éveillés voient leurs dégâts de base augmenter de 15 %/30 %."
  },
  State_70806_Name = {
    Text = "Main de la Garde+"
  },
  State_70808_Desc = {
    Text = "Utilisez la posture « Mer Calme » pour infliger 64/128 d'épuisement à tous les ennemis. Temps de recharge : 3 tours."
  },
  State_70809_Desc = {
    Text = "Au début du tour, si la vie est inférieure à 25 %, obtenez 100/200 points de bouclier."
  },
  State_70809_Name = {
    Text = "Main du Gardien"
  },
  State_70810_Desc = {
    Text = "Utilisez la posture Tsunami pour activer immédiatement toutes les attaques de tentacules contre l'ennemi 1 à 2 fois, temps de refroidissement de 3 tours."
  },
  State_70812_Desc = {
    Text = "Après le début de la bataille, appliquez 1/2 couche de vulnérabilité à tous les ennemis, l'effet est doublé contre les boss. Tous les éveillés voient leurs dégâts de base augmenter de 15 %/30 %."
  },
  State_70832_Desc = {
    Text = "Équipe unique : Au début du combat, l'équipement reçoit une quantité de folie équivalente à <WeaponEffect_Num:[StateArg1]%> de sa régénération de folie. Après avoir libéré l'exaltation pour la première fois dans le combat, cet effet se répète une fois."
  },
  State_70832_WeaponDesc = {
    Text = "Au début de la bataille, le porteur gagne Exalt égal à <WeaponEffect_Num:[StateArg1]%> de la recharge d'Aliemus du porteur (<WeaponEffect_Num:[DescArg1]>). Après que le porteur libère Exalt pour la première fois dans chaque bataille, cet effet se répète une fois."
  },
  State_70835_Desc = {
    Text = "Équipe Unique : La Fureur, le Poison et la récupération de PV causés par le Porteur augmentent de <WeaponEffect_Num:[StateArg1] %>. Après que le Porteur ait libéré l'Exaltation, il obtient une quantité de Fureur équivalente à la Consommation de Fureur de cette fois <WeaponEffect_Num:[StateArg2] %>."
  },
  State_70835_WeaponDesc = {
    Text = "La fureur, le poison et la régénération de vie causés par le porteur augmentent de <WeaponEffect_Num:[StateArg1] %>. Après que le porteur ait libéré l'exaltation, il obtient une quantité de fureur équivalente à <WeaponEffect_Num:[StateArg2] %> de sa consommation de fureur."
  },
  State_70989_Desc = {
    Text = "Après avoir libéré 4 exaltations en un tour, obtenez 3/6 points d'arithmétique, avec un temps de recharge de 3 tours."
  },
  State_71001_Desc = {
    Text = "Après avoir joué 4 cartes de commandement appartenant à différents réveilleurs au cours d'un même tour, tous les réveilleurs gagnent 20/40 points de folie. Temps de recharge : 3 tours."
  },
  State_71153_Desc = {
    Text = "Au début du tour, Caecus gagne 15 points de folie. Lorsque Caecus obtient un bouclier, récupère 50 % de la valeur du bouclier en PV."
  },
  State_71154_Desc = {
    Text = "Au début du tour, Aigis obtient 15 points de folie. Lorsqu'Aigis inflige des dégâts à un ennemi vulnérable, elle lui vole également 10 points de pouvoir temporaire, effet maximum 5 fois par tour."
  },
  State_71155_Desc = {
    Text = "Au début du tour, Leigh gagne 15 points de fureur. Chaque fois qu'elle perd des PV, elle obtient 8 points de force, pouvant se cumuler jusqu'à 10 fois par combat. Après 10 cumuls, le coût d'Arithmetica de « Douleur et Plaisir » devient 1, et le nombre de fois de dégâts augmente de 1."
  },
  State_71156_Desc = {
    Text = "Au début du tour, Agrippa gagne 15 points de folie. « La charité impatiente » réduit également la consommation d'arithmetica d'Agrippa de 1 ce tour-ci, avec un maximum de 1 activation par tour."
  },
  State_71157_Desc = {
    Text = "Au début du tour, Shan obtient 15 points de folie. Au début de la bataille, appliquez les effets « réservé » et « préparé 1 » à toutes les cartes de commandement de Shan et faites-lui obtenir 24 points de bouclier."
  },
  State_71157_Name = {
    Text = "Image de Dimension · Sanga"
  },
  State_71158_Desc = {
    Text = "Au début du tour, la poupée gagne 15 points d'aliemus. Après le début de la bataille, le coût en arithmétique de « Échange équivalent » de la poupée devient 0. Après avoir joué, tirez 2 cartes supplémentaires au tour suivant."
  },
  State_71159_Desc = {
    Text = "Au début du tour, Faros obtient 15 points d'aliemus. Chaque fois qu'un dégât de tentacule est infligé, le poison causé par Faros dans ce combat augmente de 1 %, jusqu'à un maximum de 100 %."
  },
  State_71160_Desc = {
    Text = "Au début du tour, « 24 » obtient 15 points de fureur. Au début du tour, si « 24 » est en « personnalité dépressive », il obtient 25 points de fureur supplémentaires, et si « 24 » est en « personnalité maniaque », il augmente le taux critique temporaire et les dégâts critiques temporaires de 35%."
  },
  State_71161_Desc = {
    Text = "Au début du tour, Évanouissement obtient 15 points d'aliemus. Chaque déclenchement de la résistance à la mort augmente de 20 % le bouclier, la contre-attaque et la régénération de vie infligés par Évanouissement lors de cette exploration, avec un maximum de 5 effets."
  },
  State_71162_Desc = {
    Text = "Au début du tour, Goliath gagne 15 points d'aliemus. Si Goliath inflige 3 dégâts en un seul tour, les dégâts qu'il inflige bénéficient d'un bonus de puissance supplémentaire de 1 fois pendant ce combat, avec un temps de recharge de 3 tours."
  },
  State_71163_Desc = {
    Text = "Au début du tour, Helot-catena obtient 15 points d'aliemus. Les dégâts actifs d'Helot-catena appliquent 20 % de saignement. Lorsqu'un ennemi est tué, inflige des dégâts de saignement égaux aux dégâts excédentaires à d'autres ennemis."
  },
  State_71164_Desc = {
    Text = "Au début du tour, Aurita gagne 15 points d'aliemus. « Division glandulaire » inflige 1 frappe de dégâts supplémentaire et place 1 « Division glandulaire » dans votre main après avoir joué la « Défense » d'Aurita."
  },
  State_71166_Desc = {
    Text = "Au début du tour, Lily obtient 15 points de folie. La limite d'endurance de Lily augmente de 100 %. Lorsqu'elle utilise « La fleur immortelle sur la boue » ou « Le coup de compensation », récupère 8 % de la vie par niveau d'endurance."
  },
  State_71167_Desc = {
    Text = "Au début du tour, Lotan gagne 15 points d'aliemus. Après la première utilisation de « Défense » de Lotan chaque tour, placez 2 « Lames indomptables » avec les coûts supplémentaires et le néant dans votre main."
  },
  State_71168_Desc = {
    Text = "Au début du tour, Pandia obtient 15 points de folie. Au début du tour, gagnez 64 points de contre-attaque. Pour chaque 4 points de contre-attaque non temporaires, les dégâts des cartes de commandement « Pandia » augmentent de 1."
  },
  State_71169_Desc = {
    Text = "Au début du tour, Hilote gagne 15 points d'aliemus. Chaque fois qu'une carte est défaussée, Hilote reçoit 5 points d'aliemus supplémentaires."
  },
  State_71170_Desc = {
    Text = "Au début du tour, Tawil obtient 15 points de folie. Si 6 cartes de commandement de Tawil sont jouées au cours d'un même tour, placez 1 carte « Clé d'Aube Argentée » dans la main. Temps de recharge : 3 tours."
  },
  State_71171_Desc = {
    Text = "Au début du tour, Miryam reçoit 15 points de folie et pioche une carte « Sacre »."
  },
  State_71172_Desc = {
    Text = "Au début du tour, Fonder·Dore obtient 15 points de folie. Après que Fonder·Dore ait libéré l'exaltation de la folie, pour chaque 20 points de folie dépensés, les autres réveilleurs obtiennent 1 point de folie."
  },
  State_71173_Desc = {
    Text = "Au début du tour, Salvador gagne 15 points de fureur. Chaque fois qu'il accumule de la Forge Écarlate, il obtient également 5 % de force de l'accumulation. Les « Attaque » et « Souffrance à dissiper » de Salvador bénéficient d'un bonus de force supplémentaire de 1 fois."
  },
  State_71175_Desc = {
    Text = "Au début du tour, Nautila gagne 15 points d'aliemus. Après avoir libéré l'exaltation d'aliemus de Nautila, obtenez une contre-attaque équivalente à 50 % du bouclier actuel. Peut être déclenché une fois par tour maximum."
  },
  State_71177_Desc = {
    Text = "Au début du tour, Liz gagne 15 points de folie. Les cartes défaussées par « Danse vers la destruction » prennent effet une fois supplémentaire. Temps de recharge : 3 tours."
  },
  State_71178_Desc = {
    Text = "Au début du tour, Ramona obtient 15 points de folie. Chaque fois qu'une carte de commandement de Ramona est jouée en 3e position, cette carte a un effet supplémentaire."
  },
  State_71179_Desc = {
    Text = "Au début du tour, Uvhash gagne 15 points d'aliemus. La consommation d'aliemus d'Uvhash est réduite de 10 points, et chaque exaltation libérée réduit en plus 5 points, pouvant libérer 2 exaltations par tour."
  },
  State_71180_Desc = {
    Text = "Au début du tour, Alva obtient 15 points d'aliemus. Si Alva a joué 2 « Défenses » au tour précédent, placez 1 « Lame des esprits » avec épuisement dans votre main ; si elle a joué 2 « Frappes », placez 1 « Position de combat » avec épuisement dans votre main."
  },
  State_71181_Desc = {
    Text = "Au début du tour, Sorel gagne 15 points de Fureur. Chaque fois que Sorel inflige des Dommages, la Fusion d'Embryon augmente de 10, jusqu'à un maximum de 10 fois par tour. Après 10 activations, les Dégâts Critiques de Sorel augmentent de 20 % pendant ce combat."
  },
  State_71182_Desc = {
    Text = "Au début du tour, Hameln gagne 15 points d'aliemus. La consommation en arithmétique de « Prélude de l'âme » est réduite de 1 et le nombre de dégâts de base est augmenté de 1."
  },
  State_71183_Desc = {
    Text = "Au début du tour, Thais obtient 15 points de folie. Lorsque Thais joue 2 cartes de commandement pendant un même tour, elle obtient 1 carte « Fils de la sainteté » et 72 points de puissance temporaire. Temps de recharge : 3 tours."
  },
  State_71187_Desc = {
    Text = "Au début du tour, le céleste obtient 15 points d'aliemus. Avant la fin du tour, pour chaque carte de commandement de Celeste présente dans la main, un tentacule attaque l'ennemi et restaure 8 points de vie."
  },
  State_71188_Desc = {
    Text = "Au début du tour, Murphy obtient 15 points de folie. L'« attaque » et la « défense » de Murphy peuvent convertir 25 % du <SacrificeKeyWord:sacrifice> en dégâts de tentacule temporaires, mais cet effet ne peut se déclencher qu'une seule fois par tour."
  },
  State_71189_Desc = {
    Text = "Au début du tour, Nymphaea obtient 15 points de fureur. Après avoir joué l'« Attaque » de Nymphaea, augmentez de 20 % le poison infligé par Nymphaea dans ce combat. Après avoir joué la « Défense » de Nymphaea, déclenchez un poison de 50 % sur tous les ennemis. Chaque effet ne peut se déclencher qu'une seule fois par tour."
  },
  State_71190_Desc = {
    Text = "Au début du tour, Ogier gagne 15 points d'aliemus. Après avoir joué pour la première fois « Lance perforante » ou « Frappe » d'Ogier durant le tour, les boucliers et le pouvoir d'Ogier augmentent de 50 % durant ce tour."
  },
  State_71191_Desc = {
    Text = "Au début du tour, Ryker gagne 15 aliemus. Le résultat du premier lancer de dé de chaque tour est toujours 6."
  },
  State_71192_Desc = {
    Text = "Au début du tour, Ramona circulaire obtient 15 points de folie. Lorsque « Boucle » est déclenchée pour la première fois chaque tour, obtenez 500 points de s-énergie et 1 couche de « négentropie »."
  },
  State_71193_Desc = {
    Text = "Au début du tour, Tulu gagne 15 points d'aliemus. La consommation d'aliemus de Tulu est réduite de 10 points, et 2 tentacules temporaires sont générés immédiatement après avoir libéré une exaltation."
  },
  State_71194_Desc = {
    Text = "Au début du tour, Karen gagne 15 points d'aliemus. Jouer « Veille silencieuse » rembourse le double de sa consommation en arithmétique, avec un temps de recharge de 3 tours."
  },
  State_71271_Desc = {
    Text = "Au début du tour, Horla obtient 15 points de folie. Au début de la bataille, obtenez 1 couche de métaphore pour chaque émotion. L'effet des « métaphores » est augmenté de 50 %."
  },
  State_71272_Desc = {
    Text = "Au début du tour, Jenkins reçoit 15 points de folie et les dégâts finaux augmentent de 5 %. Les dégâts de base ainsi que les dégâts infligés par « Marron, attaque ! » voient leur croissance augmenter de 200 %."
  },
  State_71273_Desc = {
    Text = "Au début du tour, Daffodil gagne 15 points de folie et 1 carte « Inspiration ». Chaque fois que « Marée hétérogène » est jouée, le pouvoir qu'elle confère augmente de manière permanente de 25 % lors de cette exploration, jusqu'à un maximum de 300 %."
  },
  State_71274_Desc = {
    Text = "Au début du tour, Teinture obtient 15 points de folie. Lorsque la carte de commandement de Teinture déclenche un saut, elle est renvoyée dans la main. Cet effet est limité à 3 fois par tour."
  },
  State_71275_Desc = {
    Text = "Au début du tour, Wanda obtient 15 points de folie et gagne 1 niveau de « rêve-guide ». Si le tour actuel est un tour hyperdimensionnel, placez en plus 1 carte temporaire « Chaîne épineuse » et « Garde égarée » dans la main."
  },
  State_71276_Desc = {
    Text = "Au début du tour, Eryca obtient 15 points de folie. Lorsque Eryca joue 3 cartes de commandement en un seul tour, elle obtient 1 carte « Inspiration » et augmente de 1 fois le bonus de puissance et de vigilance de « Explosion électromagnétique » pour cette bataille."
  },
  State_71277_Desc = {
    Text = "Au début du tour, Casiah reçoit 15 points de folie. Pour chaque carte piochée, Casiah gagne 1 point de folie. Lorsque Casiah libère l'exaltation, tous les ennemis perdent 32 points de <PowerIconKeywords:puissance>."
  },
  State_71278_Desc = {
    Text = "Au début du tour, Wenkel obtient 15 points de folie. Chaque fois qu'un autre réveilleur libère une exaltation de la folie, Wenkel reçoit 5 points de folie supplémentaires et la consommation en arithmétique de « Reconstruction mentale » en main est réduite de 1."
  },
  State_71279_Desc = {
    Text = "L'Amplification de Dégâts de l'équipe augmente de [StateArg1]%, durant [Layer] <plural value=\"[Layer]\" singular=\"tour\" plural=\"tours\">."
  },
  State_71279_Name = {Text = "Excitation"},
  State_71503_Name = {
    Text = "« Forme terminale » : piochez 3 cartes supplémentaires, obtenez 3 points d'arithmétique, appliquez un effet d'<IntoxicationIconKeywords:empoisonnement> de [DescArg1] % à tous les ennemis, la limite de folie de « Doll en fusion » augmente de 50 points, avec un maximum de 3 augmentations."
  },
  State_71581_Name = {
    Text = "Aptitude Forge de l'Âme"
  },
  State_71589_Name = {
    Text = "Déclenchez l'attaque d'1 tentacule contre l'ennemi et récupérez 8."
  },
  State_71605_Name = {
    Text = "Obtenez [StateArg1] points de bouclier"
  },
  State_71650_Desc = {
    Text = "Après la mort, revivez et invoquez un nombre variable de clones, mais après la résurrection, vous ne bénéficiez d'aucun renforcement ni d'immunité. Cet effet peut être activé [Layer] fois."
  },
  State_71650_Name = {
    Text = "Bête des Myriades de Dimensions"
  },
  State_71651_Desc = {
    Text = "Chaque fois que vous perdez des points de vie, vous perdez [StateArg1] points de force temporaire. L'effet peut encore se déclencher [Layer] fois, le compteur est réinitialisé chaque tour."
  },
  State_71651_Name = {
    Text = "Chapeau de gentleman"
  },
  State_71707_Desc = {
    Text = "Pour chaque instance de Dégâts Directs reçus, récupérez [StateArg1] PV, pendant [Layer] <plural value=\"[Layer]\" singular=\"tour\" plural=\"tours\">."
  },
  State_71707_Name = {
    Text = "Kékes·Support"
  },
  State_71708_Desc = {
    Text = "À la fin du tour, pour chaque carte présente dans la main, tous les éveillés gagnent [DescArg1] points de folie."
  },
  State_71708_Name = {
    Text = "Cassia·Soutien"
  },
  State_71709_Desc = {
    Text = "À la fin du tour, obtenez 35 points de folie, durée de [Layer] tours."
  },
  State_71709_Name = {
    Text = "Vinkel·Soutien"
  },
  State_71711_Desc = {
    Text = "Les dégâts de l'éveillé augmentent de 25 %, pendant [Layer] tours."
  },
  State_71711_Name = {
    Text = "Jenkin·Soutien"
  },
  State_71712_Desc = {
    Text = "Lorsque vous infligez des Dégâts Directs, déclenche 1 Attaque de tentacules une fois, pendant [Layer] <plural value=\"[Layer]\" singular=\"tour\" plural=\"tours\">."
  },
  State_71712_Name = {
    Text = "Auréa·Support"
  },
  State_71712_WeaponDesc = {
    Text = "Quand la mer inflige des dégâts, elle fait attaquer [StateArg1] tentacules la cible"
  },
  State_71713_Desc = {
    Text = "À chaque fois que vous effectuez une « absorption », piochez 2 cartes « frappe » et réduisez leur coût en arithmétique de 1, pendant [Layer] tours."
  },
  State_71713_Name = {
    Text = "Shiro·Soutien"
  },
  State_71740_Desc = {
    Text = "Au début du prochain tour, obtenez [Layer] points de bouclier"
  },
  State_71740_Name = {
    Text = "Réya Soutien Bouclier"
  },
  State_71741_Desc = {
    Text = "Au début du prochain tour, obtenez un bouclier équivalent à la vie perdue au tour en cours, pendant [Layer] tours."
  },
  State_71741_Name = {
    Text = "Réya·Soutien"
  },
  State_71741_WeaponDesc = {
    Text = "Au début du prochain tour, obtenez un bouclier équivalent à la vie perdue au tour précédent"
  },
  State_71742_Desc = {
    Text = "Dégâts des cartes de frappe augmentés de [Layer] %."
  },
  State_71742_Name = {
    Text = "Shiro·Soutien"
  },
  State_71742_WeaponDesc = {
    Text = "Ce tour, dégâts des cartes de frappe augmentés de [Layer] %"
  },
  State_71837_Desc = {
    Text = "Au début du prochain tour, subissez de la vulnérabilité."
  },
  State_71837_Name = {
    Text = "Délai de vulnérabilité"
  },
  State_71839_Desc = {
    Text = "Lorsque vous utilisez « Réveil », obtenez [Layer] points d'arithmétique. Si le royaume actuel est « Fond marin », générez en plus [Layer] tentacules temporaires."
  },
  State_71839_Name = {
    Text = "Étoiles protectrices"
  },
  State_71856_Desc = {
    Text = "Chaque fois que vous perdez des points de vie, vous perdez [StateArg1] points de force temporaire. L'effet peut encore se déclencher [Layer] fois, le compteur est réinitialisé chaque tour."
  },
  State_71856_Name = {
    Text = "Chapeau de gentleman"
  },
  State_72016_Name = {
    Text = "Maîtrise de la Chair"
  },
  State_72018_WeaponDesc = {
    Text = "Chaque fois que 1 point de dégâts est subi, tous les réveilleurs gagnent 1 point de folie"
  },
  State_72033_Name = {Text = "Tentacule"},
  State_72036_Name = {
    Text = ": Initialisation de la classe chaotique"
  },
  State_72079_Name = {
    Text = "Vagues Déchaînées"
  },
  State_72102_Desc = {
    Text = "Une expérience de jeu classique de « Veille de l'oubli »."
  },
  State_72102_Name = {Text = "Oubli"},
  State_72137_Name = {
    Text = "Puissance de calcul maximale"
  },
  State_72206_Name = {
    Text = "Progression de la recherche « [DescArg1]/15 »"
  },
  State_72208_Name = {
    Text = "Progression de la recherche « [DescArg1]/2 »"
  },
  State_72212_Name = {
    Text = "Progression de la recherche « [DescArg1]/10 »"
  },
  State_72213_Name = {
    Text = "Progression de la recherche « [DescArg1]/30 »"
  },
  State_72220_Name = {
    Text = "Progression de la recherche « [DescArg1]/5 »"
  },
  State_73518_Desc = {
    Text = "Les dégâts infligés augmentent de 100 %. Si vous perdez des points de vie, cet état est annulé, mais vous obtenez un bouclier égal à 50 % de votre santé maximale."
  },
  State_73518_Name = {
    Text = "« Assassin »"
  },
  State_73520_Desc = {
    Text = "À la mort, conservez 1 point de vie et devenez immunisé contre tous les dégâts, convertissez l'intention en « déconnexion »."
  },
  State_73520_Name = {
    Text = "« Connecteur »"
  },
  State_73533_Desc = {
    Text = "À la fin du tour du joueur, vous ne défaussez plus les cartes de votre main. Au début du combat, la limite de cartes en main du joueur devient 8."
  },
  State_73533_Name = {
    Text = "Sens de la ruche"
  },
  State_73535_Desc = {
    Text = "Durant votre tour, les dégâts subis sont réduits de 75 %. Lorsque la <PowerIconKeywords:force> est réduite, seules 50 % des couches de force sont diminuées."
  },
  State_73535_Name = {
    Text = "Auto-protection"
  },
  State_73566_Desc = {
    Text = "Chaque fois que vous jouez une carte non-ordre, obtenez [Power:StateArg1] points de <PowerIconKeywords:force> et <Block:[Block:StateArg2]> points de bouclier."
  },
  State_73566_Name = {
    Text = "Communiquant"
  },
  State_73567_Desc = {
    Text = "Chaque fois que vous jouez une carte non-ordre, obtenez [Power:StateArg1] points de <PowerIconKeywords:force> et <Block:[Block:StateArg2]> points de bouclier."
  },
  State_73567_Name = {
    Text = "Communiquant"
  },
  State_73570_Desc = {
    Text = "Chaque fois que vous jouez une carte non-ordre, obtenez [Power:StateArg1] points de <PowerIconKeywords:force> et <Block:[Block:StateArg2]> points de bouclier."
  },
  State_73570_Name = {
    Text = "Communiquant"
  },
  State_73573_Desc = {
    Text = "Chaque fois que vous jouez une carte non-ordre, obtenez [Power:StateArg1] points de <PowerIconKeywords:force> et <Block:[Block:StateArg2]> points de bouclier."
  },
  State_73573_Name = {
    Text = "Communiquant"
  },
  State_73649_Desc = {
    Text = "Dégâts d'équipe augmentés de [Layer] %."
  },
  State_73649_Name = {
    Text = "Marionnette du Néant"
  },
  State_73655_Name = {
    Text = "Marque de forme organique"
  },
  State_73664_Name = {
    Text = "Effet de la forme organique de l'accessoire"
  },
  State_73664_WeaponDesc = {
    Text = "Après avoir utilisé l'exaltation, les boucliers et les soins de l'équipement doublent pour ce tour"
  },
  State_74012_Desc = {
    Text = "Inflige à tous les ennemis des <RealDamage:dégâts fixes> équivalents à [StateArg1] % de leur PV Max (minimum : [DescArg1]). Après utilisation, la compétence spécifique de « Fusion · Dor » devient « Fin »."
  },
  State_74012_Name = {
    Text = "Fin du Néant"
  },
  State_74013_Desc = {
    Text = "Inflige à tous les ennemis des <RealDamage:dégâts fixes> équivalents à [StateArg1] % de leur PV Max, ce dégât ne peut pas être inférieur à 500 % de vos PV Max. Après utilisation, la compétence spécifique de « Fusion · Dor » devient « Fin »."
  },
  State_74013_Name = {
    Text = "Fin du Néant"
  },
  State_74014_Desc = {
    Text = "Inflige à tous les ennemis des <RealDamage:dégâts fixes> équivalents à [StateArg1] % de leur PV Max (ce dégât ne peut pas être inférieur à 500 % de vos PV Max), restaure 30 % des points de vie perdus. Après utilisation, la compétence spécifique de « Fusion · Dor » devient « Fin »."
  },
  State_74014_Name = {
    Text = "Fin du Néant"
  },
  State_74015_Desc = {
    Text = "Inflige à tous les ennemis des <RealDamage:dégâts fixes> équivalents à [StateArg1] % de leur PV Max (minimum : [DescArg1]), restaure <Heal:[Heal:DescArg2]> points de vie. Après utilisation, la compétence spécifique de « Fusion · Dor » devient « Fin »."
  },
  State_74015_Name = {
    Text = "Fin du Néant"
  },
  State_74019_Desc = {
    Text = "Tous les éveillés voient leurs dégâts de base, poison et comptoir augmenter de [Layer] %."
  },
  State_74019_Name = {
    Text = "Infection de folie"
  },
  State_74142_Desc = {
    Text = "Au début de l'exploration, augmenter la Constitution, l'Attaque et la Défense de [StateArg1] %"
  },
  State_74142_Name = {
    Text = "Aptitude Forge de l'Âme"
  },
  State_74219_Name = {
    Text = "Après avoir joué, le renvoie en main"
  },
  State_74273_Desc = {
    Text = "Lorsque Helot-catena inflige des dégâts actifs, ajoute [StateArg1]% de saignement, pendant [Layer] tours."
  },
  State_74273_Name = {
    Text = "Chaînes de restriction"
  },
  State_74771_Desc = {
    Text = "Valeur de folie nécessaire pour libérer une exaltation."
  },
  State_74771_Name = {
    Text = "Limite de fureur"
  },
  State_74788_Desc = {
    Text = "\n·Paradoxe : Au début de l'exploration, 75 % de la Résistance à la mort se transforme en bonus de PV Max, jusqu'à 300 % de Résistance à la mort, augmentant au maximum de 10 % les PV Max. Chaque fois que la Résistance à la mort est déclenchée, placez 1 carte « Lueur de la clé d'argent » dans votre main. \n·Cicatrice abyssale : Lors d'un Combat de Chef, chaque fois que la régénération de vie de votre équipe atteint 100 % des PV Max, cela réduit l'effet de régénération de vie suivant de 25 %, mais augmente la Résistance à la mort totale actuelle de 25 %, avec un maximum de 3 déclenchements. \n·Lentille prismatique : Au début du tour, si le Compteur dépasse 750 % des PV Max, réduisez de moitié le nombre de charges de la partie excédentaire, et le Compteur Permanent peut se cumuler jusqu'à 2250 % des PV Max ; si un ennemi est empoisonné au-delà de 1000 % des PV Max, réduisez de moitié le nombre de charges de la partie excédentaire, et le Poison peut se cumuler jusqu'à 3000 % des PV Max. Les Corps éveillés voient le bonus de dégâts obtenu par Contre-attaque réduit de 70 %, mais tous les Poisons et Contre-attaques infligés augmentent de 10 %. Au début du tour de l'ennemi, pour chaque Gnosis activé, obtenez 25 % de la Contre-attaque Permanente actuelle en tant que Contre-attaque Temporaire, et déclenchez 25 % de Poison sur tous les ennemis. \n·Destin lumineux : Le nombre de tours pendant lesquels les Monstres normaux lancent « Regard » devient 6 tours. Tous les combats ont une limite de 15 tours, mais au début du 15e tour, placez 1 carte « Limite de la Conique Lumineuse » dans votre main : obtenez l'énergie de Fragment de clé jusqu'à la limite, et tous les Corps éveillés obtiennent la Fureur jusqu'à leur Limite de fureur."
  },
  State_74788_Name = {
    Text = "« Abandonné temporairement »"
  },
  State_74791_Desc = {
    Text = "\nHarmonie d'Arithmetica : Pour chaque Carte d'instruction jouée après la 10e lors d'un tour, gagnez 1 «Harmonie d'Arithmetica». Chaque charge augmente le coût d'une carte de 1 Arithmetica, qui est ensuite convertie en 100% de la Régénération de Fragment de clé de l'Éveilleur (cumulable). Les charges se réinitialisent en entrant dans l'Espace Hyperspatial.\nPuissance de calcul maximale : Lors du jeu d'une carte, supprimez son effet de réduction du Coût d'Arithmetica pour ce tour. Lorsque l'Arithmetica actuelle dépasse 12, chaque point excédentaire est converti en 300% de la Régénération de Fragment de clé moyenne de l'équipe.\nHarmonie furieuse : L'effet d'augmentation du % de Fureur est réduit de moitié. Chaque Exaltation augmente la Base Aliemus de 10. Gagnez 200% de la Régénération de Fragment de clé moyenne de l'équipe en fin de tour pour chaque Éveilleur qui n'a pas effectué d'Exaltation."
  },
  State_74791_Name = {
    Text = "Harmonisation de l'énergie clé"
  },
  State_74809_Name = {
    Text = "« Forme terminale » : piochez 3 cartes supplémentaires, obtenez 3 points d'arithmétique, appliquez un effet d'<IntoxicationIconKeywords:empoisonnement> de [DescArg1] % à tous les ennemis, la limite de folie de « Doll en fusion » augmente de 50 points, avec un maximum de 3 augmentations."
  },
  State_74826_Name = {
    Text = "Inflige aléatoirement [DescArg1] <FixedDamage:DGT Purs> [DescArg2] <plural value=\"[DescArg2]\" singular=\"fois\" plural=\"fois\"> (bénéficie d'un bonus de <PowerIconKeywords:STR> ×1)"
  },
  State_74827_Name = {
    Text = "Ce tour, les coups critiques et les dégâts critiques de tous les éveillés augmentent de [DescArg1] %"
  },
  State_74828_Name = {
    Text = "Inflige [DescArg1] points de poison à tous les ennemis"
  },
  State_74829_Name = {
    Text = "Inflige des <FixedDamage:DGT Purs> à tous les ennemis égaux à [DescArg1]% de leurs PV manquants"
  },
  State_74830_Name = {
    Text = "Obtenir [DescArg1] points de puissance"
  },
  State_74831_Name = {
    Text = "Tous les éveillés gagnent [DescArg1] points de folie"
  },
  State_74847_Desc = {
    Text = "Équipe unique : Les dégâts de base de la première carte de commandement utilisée par l'équipement chaque tour augmentent de <WeaponEffect_Num:[StateArg1]%>. Si elle entre dans l'espace dimensionnel, l'équipement obtient <WeaponEffect_Num:[StateArg2]> points de folie."
  },
  State_74847_WeaponDesc = {
    Text = "Les dégâts de base de la première carte de commandement utilisée par l'équipement chaque tour augmentent de <WeaponEffect_Num:[StateArg1]%>. Si celle-ci entre dans l'espace dimensionnel, l'équipement obtient <WeaponEffect_Num:[StateArg2]> points de folie."
  },
  State_74879_Name = {
    Text = "Gagnez [DescArg1] points d'arithmétique"
  },
  State_74881_Name = {
    Text = "Choisissez un éveillé pour gagner [DescArg1] points de folie"
  },
  State_74882_Name = {
    Text = "Obtenir [DescArg1] points de Maîtrise de Royaume"
  },
  State_74883_Name = {
    Text = "La prochaine carte de commandement jouée [DescArg1] donnera [DescArg2] points d'énergie supplémentaires"
  },
  State_74884_Name = {
    Text = "Ce tour, le poison, le contre et le saignement augmentent de [DescArg1] %"
  },
  State_74885_Name = {
    Text = "Tous les éveillés gagnent [DescArg1] points de folie"
  },
  State_74887_Name = {
    Text = "Obtenir [DescArg1] points de bouclier"
  },
  State_74888_Name = {
    Text = "Obtenir [DescArg1] points de résistance à la mort"
  },
  State_74889_Name = {
    Text = "Obtenir [DescArg1] niveaux de réplique"
  },
  State_74890_Name = {
    Text = "vole [DescArg1] points de force temporaire à tous les ennemis"
  },
  State_74891_Name = {
    Text = "Inflige aléatoirement [DescArg1] <FixedDamage:DGT Purs> [DescArg2] <plural value=\"[DescArg2]\" singular=\"fois\" plural=\"fois\"> (bénéficie d'un bonus de <PowerIconKeywords:STR> ×1)"
  },
  State_74910_Desc = {
    Text = "Équipe Unique : Si le Porteur est l'Éveilleur «Ramona», le Taux de synchronisation gagné à la fin du niveau +<WeaponEffect_Num:[StateArg1]%>."
  },
  State_74910_WeaponDesc = {
    Text = "Si l'équipier est le réveilleur « Ramona », le taux d'affinité obtenu à la fin du niveau est augmenté de <WeaponEffect_Num:[StateArg1]%>."
  },
  State_74932_Desc = {
    Text = "Lorsque vous jouez une carte « Frappe », « Défense » ou « Compétence », l'effet correspondant dans « Transaction taboue » est amélioré."
  },
  State_74932_Name = {
    Text = "Commerce Interdit"
  },
  State_74947_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Au début du tour, applique [StateArg1] stack(s) de Blocage d'Action à l'ennemi avec <HPAndShieldMin:la vie et le bouclier les plus faibles>. Après qu'un ennemi est éliminé par le porteur, cet effet se déclenche immédiatement une fois."
  },
  State_74947_Name = {
    Text = "Chapeau de sorcière à large bord"
  },
  State_74948_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin>: Après \"Exalter\", fait perdre à l'ennemi avec le plus d'exaltation [StateArg1] points d'exaltation et gagne <PVPEmptinessKeywords:Vide>."
  },
  State_74948_Name = {
    Text = "Pendule d'Hypnose"
  },
  State_76236_Desc = {
    Text = "\nÉveil des Fragments de clé : Lorsque les Fragments de clé sont au maximum, vous pouvez choisir en plus « Éveil des Fragments de clé » pour placer la carte d'Éveil de l'Éveilleur désigné dans la main et lui accorder « Garder » pour cette bataille. « Éveil des Fragments de clé » ne peut se déclencher qu'une fois par tour et possède un temps de recharge indépendant du « Décret Clé ».\nSurcharge de Fragments de clé : Lors de l'utilisation de « Éveil des Fragments de clé », pour chaque Éveilleur éveillé, 1000 Fragments de clé sont déduits, ce qui peut faire passer les Fragments de clé en négatif.\nArchivage de griffure : Pour chaque Décret Clé que possède le Gardien, la Profondeur de l'étude des objets et la Profondeur de l'étude de la Connaissance Spirituelle augmentent de 1%, jusqu'à 50%. Tous les effets des Roues du Destin R sont modifiés pour augmenter de 100% la chance que la Relique Image Dimensionnelle du Porteur apparaisse."
  },
  State_76236_Name = {
    Text = "Éclat d'argent"
  },
  State_76277_Desc = {
    Text = "Équipe Unique : Au début du Combat de Chef, consommez jusqu'à 50 Marque noire, chaque consommation de 1 Marque noire vous donne <WeaponEffect_Num:[StateArg1]%> <DeathResistanceIconKeywords:Résistance à la mort>. Dans le Chapitre des Étoiles, l'effet devient « augmenter de 100 % la probabilité d'apparition de la relique d'image dimensionnelle de l'équipement »."
  },
  State_76277_WeaponDesc = {
    Text = "Après le début du Combat de Chef, consommez jusqu'à 50 marques noires, chaque consommation de 1 marque noire vous donne <WeaponEffect_Num:[StateArg1]%> <DeathResistanceIconKeywords:résistance à la mort>. Dans le Chapitre des Étoiles, l'effet devient « augmenter de 100 % la probabilité d'apparition de la relique d'image dimensionnelle de l'équipement »."
  },
  State_76278_Desc = {
    Text = "Équipe Unique : Chaque fois que vous traversez une nouvelle case, récupérez <WeaponEffect_Num:[StateArg1]%> de la vie perdue. Après avoir utilisé le Corps de Gnosis d'urgence, le taux critique et les dégâts critiques de tous les Éveilleurs augmentent de 100 %. Dans le chapitre des Étoiles, l'effet devient « augmenter de 100 % la probabilité d'apparition de la relique d'image dimensionnelle de l'équipement »."
  },
  State_76278_WeaponDesc = {
    Text = "Chaque fois qu'un nouveau carré est traversé, récupérez [StateArg1]% des points de vie perdus ([DescArg1]). Après avoir utilisé le Corps de Gnosis d'urgence, le taux critique et les dégâts critiques de tous les éveillés augmentent de 100 %. Dans le chapitre des Étoiles, l'effet devient « augmenter de 100 % la probabilité d'apparition de la relique d'image dimensionnelle de l'équipement »."
  },
  State_76279_Desc = {
    Text = "Équipe Unique : Le coût pour éveiller un Éveilleur dans la Trace de fusion diminue de <WeaponEffect_Num:[StateArg1]> marques noires. Le Porteur obtient un Gnosis inné. Dans le Chapitre des Étoiles, l'effet devient « augmenter de 100 % la probabilité d'apparition de la relique d'image dimensionnelle de l'équipement »."
  },
  State_76279_WeaponDesc = {
    Text = "Le coût pour éveiller les éveilleurs dans la trace de fusion diminue de <WeaponEffect_Num:[StateArg1]> marques noires. Le porteur obtient une gnose innée. Dans le chapitre des Étoiles, l'effet devient « augmenter de 100 % la probabilité d'apparition de la relique d'image dimensionnelle de l'équipement »."
  },
  State_76280_Desc = {
    Text = "Équipe unique : la quantité de régénération au zone de repos augmente de <WeaponEffect_Num:[StateArg1]%>, après avoir choisi de régénérer des PV, ajoutez 2 cartes « perspicacité » à votre bibliothèque. Dans le chapitre des Étoiles, l'effet devient « augmenter de 100 % la probabilité d'apparition de la relique d'image dimensionnelle de l'équipement »."
  },
  State_76280_WeaponDesc = {
    Text = "La régénération au zone de repos augmente de <WeaponEffect_Num:[StateArg1]%>, choisissez de régénérer des PV, puis ajoutez 2 cartes « Perspicacité » dans votre bibliothèque. Dans le chapitre des Étoiles, l'effet devient « augmenter de 100 % la probabilité d'apparition de la relique d'image dimensionnelle de l'équipement »."
  },
  State_76281_Desc = {
    Text = "Équipe unique : à la fin du combat, l'éveillé avec le moins de folie reçoit <WeaponEffect_Num:[StateArg1]> points de folie. Dans l'histoire des Étoiles, l'effet devient « augmenter de 100 % la probabilité d'apparition de la relique d'image dimensionnelle de l'équipement »."
  },
  State_76281_WeaponDesc = {
    Text = "À la fin du combat, l'éveillé avec le moins de folie obtient <WeaponEffect_Num:[Energy:StateArg1]> points de folie. Dans le chapitre des Étoiles, l'effet devient « augmenter de 100 % la probabilité d'apparition de la relique d'image dimensionnelle de l'équipement »."
  },
  State_76282_Desc = {
    Text = "Équipe Unique : Nombre de fois de rafraîchissement de Trace de fusion +1, le coût de rafraîchissement diminue de <WeaponEffect_Num:[StateArg1]> points de Marque noire. Dans le chapitre des Étoiles, l'effet devient « Augmenter de 100 % la probabilité d'apparition de la relique d'image dimensionnelle de l'équipement »."
  },
  State_76282_WeaponDesc = {
    Text = "Nombre de rafraîchissements de la d-marque +1, le coût de rafraîchissement diminue de <WeaponEffect_Num:[StateArg1]> sigils noirs. Dans l'histoire des Étoiles, l'effet devient « Augmenter de 100 % la probabilité d'apparition de la relique d'image dimensionnelle de l'équipement »."
  },
  State_76283_Desc = {
    Text = "Équipe Unique : la barre de création de trace de fusion devient 3, dont une est une créature maudite. Après l'achat d'une créature maudite, obtenez <WeaponEffect_Num:[StateArg1]> points de marque noire. Dans le chapitre des Étoiles, l'effet devient « augmenter de 100 % la probabilité d'apparition de l'image dimensionnelle de la relique »."
  },
  State_76283_WeaponDesc = {
    Text = "La barre de création de trace de fusion devient 3, dont une est une créature maudite. Après avoir acheté une créature maudite, obtenez <WeaponEffect_Num:[StateArg1]> points de marque noire. Dans le chapitre des Étoiles, l'effet devient « augmenter de 100 % la probabilité d'apparition de la relique d'image dimensionnelle de l'équipement »."
  },
  State_76284_Desc = {
    Text = "Équipe unique : au début du niveau, tous les Éveilleurs reçoivent <WeaponEffect_Num:[StateArg1]> points de Fureur. Après le début du Combat de Chef, piochez 2 cartes. Dans le chapitre des Étoiles, l'effet devient « augmenter de 100 % la probabilité d'apparition de la relique d'image dimensionnelle de l'équipement »."
  },
  State_76284_WeaponDesc = {
    Text = "Au début du niveau, tous les éveillés obtiennent <WeaponEffect_Num:[Energy:StateArg1]> points de fureur. Après le début du combat de chef, piochez 2 cartes. Dans le chapitre des Étoiles, l'effet devient « augmenter de 100 % la probabilité d'apparition de la relique d'image dimensionnelle de l'équipement »."
  },
  State_76285_Desc = {
    Text = "Équipe Unique : au début du niveau, obtenez <WeaponEffect_Num:[StateArg1]> points de Fragment de clé. Après le début du Combat de Chef, obtenez 2 points d'Arithmetica. Dans le chapitre des Étoiles, l'effet devient « augmenter de 100 % la probabilité d'apparition de l'Image Dimensionnelle de la relique »."
  },
  State_76285_WeaponDesc = {
    Text = "Au début du niveau, obtenez <WeaponEffect_Num:[StateArg1]> points de s-énergie. Après le début du Combat de Chef, obtenez 2 points d'Arithmetica. Dans le chapitre des Étoiles, l'effet devient « augmenter de 100 % la probabilité d'apparition de la relique d'image dimensionnelle de l'équipement »."
  },
  State_76286_Desc = {
    Text = "Équipe Unique : La zone de repos offre une option supplémentaire : supprimer jusqu'à 3 cartes de symptôme, obtenez <WeaponEffect_Num:[StateArg1]> points de marque noire. Dans le chapitre des Étoiles, l'effet devient « augmenter de 100 % la probabilité d'apparition de la relique d'image dimensionnelle de l'équipement »."
  },
  State_76286_WeaponDesc = {
    Text = "La zone de repos offre une option supplémentaire : éliminer jusqu'à 3 cartes de symptôme, obtenez <WeaponEffect_Num:[StateArg1]> points de marque noire. Dans le chapitre des Étoiles, l'effet devient « augmenter de 100 % la probabilité d'apparition de la relique d'image dimensionnelle de l'équipement »."
  },
  State_76287_Desc = {
    Text = "Équipe Unique : Le nombre d'oraisons sélectionnables après la fin d'un combat normal devient 4, les oraisons des cartes du porteur ont <WeaponEffect_Num:[StateArg1]%> de chances d'être améliorées en oraisons avancées. Dans le chapitre des Étoiles, l'effet devient « augmenter de 100 % la probabilité d'apparition de la relique d'image dimensionnelle de l'équipement »."
  },
  State_76287_WeaponDesc = {
    Text = "Le nombre de bénédictions sélectionnables après la fin d'un combat normal devient 4, avec une probabilité de <WeaponEffect_Num:[StateArg1]%> que les bénédictions des cartes du porteur soient améliorées en gravures avancées. Dans le chapitre des Étoiles, l'effet devient « augmenter de 100 % la probabilité d'apparition de la relique d'image dimensionnelle de l'équipement »."
  },
  State_76288_Desc = {
    Text = "Équipe unique : à la fin du combat, gagnez <WeaponEffect_Num:[StateArg1]> points de s-énergie. Dans le chapitre des Étoiles, l'effet devient « augmenter de 100 % la probabilité d'apparition de l'image dimensionnelle de l'équipement »."
  },
  State_76288_WeaponDesc = {
    Text = "À la fin du combat, gagnez <WeaponEffect_Num:[StateArg1]> points de s-énergie. Dans le chapitre des Étoiles, l'effet devient : « la probabilité d'apparition de la relique d'image dimensionnelle de l'équipement augmente de 100 % »."
  },
  State_76289_Desc = {
    Text = "Unique à l'équipe : augmentez le champ de vision de +1 pendant l'exploration, obtenez <WeaponEffect_Num:[StateArg1]> points de marque noire après avoir ouvert complètement la carte. Au début du combat de chef, appliquez <WeaknessIconKeywords:faiblesse> et <VulnerabilityIconKeywords:vulnérable> à tous les ennemis pendant 1 tour. Dans l'histoire des Étoiles, l'effet devient « augmenter de 100 % la probabilité d'apparition de la relique d'image dimensionnelle de l'équipement »."
  },
  State_76289_WeaponDesc = {
    Text = "Champ de vision +1 en exploration, obtenez <WeaponEffect_Num:[StateArg1]> points de marque noire une fois que la carte est entièrement révélée. Au début du combat de chef, appliquez <WeaknessIconKeywords:faiblesse> et <VulnerabilityIconKeywords:vulnérable> à tous les ennemis pour 1 tour. Dans le chapitre des Étoiles, l'effet devient « augmenter de 100 % la probabilité d'apparition de la relique d'image dimensionnelle de l'équipement »."
  },
  State_76290_Desc = {
    Text = "Équipe unique : à la fin d'un combat normal, vous pouvez choisir de lâcher l'oraison, augmentant la limite de vie de <WeaponEffect_Num:[StateArg1]%. Cet effet peut se produire au maximum 2 fois. Dans le chapitre des Étoiles, l'effet devient « augmenter de 100 % la probabilité d'apparition de la relique d'image dimensionnelle de l'équipement »."
  },
  State_76290_WeaponDesc = {
    Text = "À la fin d'un combat normal, vous pouvez choisir de lâcher une oraison, augmentant la limite de vie de <WeaponEffect_Num:[DescArg1]>. Cet effet peut être activé jusqu'à 2 fois. Dans le chapitre des Étoiles, l'effet devient « augmenter de 100 % la probabilité d'apparition de la relique d'image dimensionnelle de l'équipement »."
  },
  State_76291_Desc = {
    Text = "Unique à l'équipe : au début du niveau, obtenez <WeaponEffect_Num:[StateArg1]> points de sigil noir. Limite de créatures +2. Dans l'histoire des Étoiles, l'effet devient « augmenter de 100 % la probabilité d'apparition de la création d'image dimensionnelle de l'équipement »."
  },
  State_76291_WeaponDesc = {
    Text = "Au début du niveau, obtenez <WeaponEffect_Num:[StateArg1]> points de sigil noir. Limite de créatures +2. Dans l'histoire des Étoiles, l'effet devient « augmenter de 100 % la probabilité d'apparition de la relique d'image dimensionnelle de l'équipement »."
  },
  State_76292_Desc = {
    Text = "Équipe Unique : à la Trace de fusion, il est permis de vendre des cartes de symptômes. Après avoir vendu une carte de symptômes, obtenez <WeaponEffect_Num:[StateArg1]> points de Marque noire. Dans le Chapitre des Étoiles, l'effet devient « augmenter de 100 % la probabilité d'apparition de la relique d'image dimensionnelle du porteur »."
  },
  State_76292_WeaponDesc = {
    Text = "Au lieu de vendre des cartes de symptômes à la Trace de fusion, la vente de cartes de symptômes vous rapporte <WeaponEffect_Num:[StateArg1]> points de marque noire. Dans le Chapitre des Étoiles, l'effet devient « augmenter de 100 % la probabilité d'apparition de la relique d'image dimensionnelle de l'équipement »."
  },
  State_76321_Name = {
    Text = "Lentille prismatique"
  },
  State_76323_Name = {
    Text = "Harmonie furieuse"
  },
  State_76324_Name = {
    Text = "Harmonie d'Arithmetica"
  },
  State_76325_Desc = {
    Text = "Après avoir joué [DescArg1] cartes de commandement, entrez dans l'état « Harmonisation de l'arithmétique »."
  },
  State_76325_Name = {
    Text = "Harmonie d'Arithmetica"
  },
  State_76326_Name = {Text = "Paradoxe"},
  State_76328_Name = {
    Text = "Destin lumineux"
  },
  State_76337_Name = {
    Text = "Cicatrice abyssale"
  },
  State_76338_Desc = {
    Text = "Les soins reçus par le joueur sont réduits de [Layer] %."
  },
  State_76338_Name = {
    Text = "Cicatrice abyssale"
  },
  State_76430_Name = {
    Text = "Image de Dimension·Lily"
  },
  State_76433_Name = {
    Text = "Harmonie d'Arithmetica"
  },
  State_76434_Desc = {
    Text = "Chaque fois que vous jouez une carte de commande, si de l'arithmetica supplémentaire a été dépensée à cause de l'harmonisation de l'arithmetica, obtenez en plus 100 % de s-énergie correspondant à la recharge de clé en argent du réveilleur, cumulable."
  },
  State_76434_Name = {
    Text = "Harmonie d'Arithmetica"
  },
  State_76435_Name = {
    Text = "Lentille prismatique"
  },
  State_76528_Name = {
    Text = "Cette carte est considérée comme « Attaque »."
  },
  State_76529_Desc = {
    Text = "Lors de la collecte, choisir une carte de réveilleur, réduire son coût en arithmétique de 1, après la jouer, piocher 1 carte, et la traiter comme « frappe »"
  },
  State_76533_Desc = {
    Text = "<PVPWeaponKeywords:roue du destin> : En s'équipant et à la fin du tour, appliquez [StateArg2] couches de <PVPAcheKeywords:douleur cachée> sur [StateArg1] carte(s) aléatoire(s) en main de l'adversaire."
  },
  State_76533_Name = {
    Text = "Douleur Enfouie"
  },
  State_76553_Desc = {
    Text = "La consommation d'arithmetica de cette carte est réduite de [StateArg1]."
  },
  State_76553_Name = {
    Text = "Un Million de Regards Aimants"
  },
  State_77686_Name = {
    Text = "Forme Semi-Mécanique"
  },
  State_77688_Desc = {
    Text = "Au début du cinquième tour ou lorsqu'il est sur le point de mourir, il devient immunisé contre la mort et ajuste son intention à « ascension mécanique »."
  },
  State_77688_Name = {
    Text = "Chair fragile"
  },
  State_77690_Desc = {
    Text = "Après avoir basculé en « Forme Semi-Mécanique », pour chaque couche de Fin, obtenez 10 % supplémentaires de PV Max. En « Forme Semi-Mécanique », « Fusion · Dor » libérera des compétences plus menaçantes à mesure que le nombre de couches de Fin augmente."
  },
  State_77690_Name = {Text = "Fin"},
  State_77692_Desc = {
    Text = "À la fin du tour, invoque 2 monstres de dissolution, avec un maximum de 2 simultanément. Lorsque les monstres de dissolution invoqués meurent, « Fonder·Dore » perd 5 % de sa vie maximale."
  },
  State_77692_Name = {
    Text = "Porte des Abysses"
  },
  State_77693_Desc = {
    Text = "Après la mort, « Fondu·Poupée » perd 5 % de la santé maximale."
  },
  State_77693_Name = {Text = "Fusion"},
  State_78102_Desc = {
    Text = "Les dégâts infligés sont réduits de 15 %, les dégâts subis augmentent de 30 %, et ce jusqu'à la fin du combat."
  },
  State_78102_Name = {
    Text = "Surcharge paralysante"
  },
  State_78694_Desc = {
    Text = "Au début de la bataille, obtenez [Arg1] points de force. Au début de chaque tour, pour chaque [Arg2] points de force permanente, obtenez [Arg3] points de force temporaire, jusqu'à un maximum de [Arg4] points de force temporaire, et à la fin du tour, perdez la moitié du bouclier obtenue grâce à cette relique."
  },
  State_78696_Desc = {
    Text = "Utiliser l'Éveil de la clé d'argent puis sélectionner [Arg1] « compétences » correspondant au réveilleur, les consommer et mélanger [Arg2] copies supplémentaires dans la pile de pioche."
  },
  State_78697_Desc = {
    Text = "Au début du tour, subissez [Arg2] couches de poison et gagnez [Arg1] points de force pour chaque emplacement vide dans l'espace dimensionnel."
  },
  State_78698_Desc = {
    Text = "Limite d'arithmetica -[Arg1]. Gagnez 1 point d'arithmetica en jouant une carte dont le coût en arithmetica est supérieur ou égal à [Arg2], maximum [Arg3] fois par tour."
  },
  State_78699_Desc = {
    Text = "Piochez [Arg1] cartes supplémentaires après avoir pioché, puis défaussez [Arg2] cartes de votre main."
  },
  State_78700_Desc = {
    Text = "Tous les éveillés voient leurs dégâts de base augmenter de [Arg1] %, et de [Arg2] % supplémentaires à chaque réinitialisation du deck, mais 1 carte « titubation » est placée dans la main. L'augmentation maximale est de [Arg3] %."
  },
  State_78701_Desc = {
    Text = "Au début du tour, si vous avez plus de [Arg1] tentacules permanents, perdez [Arg2] tentacules et obtenez [Arg3] tentacules temporaires, sinon obtenez [Arg4] tentacules temporaires."
  },
  State_78702_Desc = {
    Text = "Utiliser l'Éveil de la clé d'argent, dépenser [Arg1] points de s-énergie supplémentaires, faire en sorte que les cartes de réveil obtenues aient un coût en arithmetica réduit à 0, après avoir été jouées, le réveilleur correspondant reçoit [Arg2] points de folie supplémentaires."
  },
  State_78703_Desc = {
    Text = "Au début du combat, infligez [Arg1] couches de poison à tous les ennemis. Avant le début du tour, retirez [Arg2] % du poison de l'ennemi et appliquez-lui [Arg3] % de saignement par rapport à la quantité retirée."
  },
  State_78710_Desc = {
    Text = "Chaque fois qu'une carte de commandement est jouée, les dégâts finaux infligés par le réveilleur concerné pendant ce tour augmentent de [Arg1] %, mais il perd [Arg2] points de folie, déclenchable jusqu'à [Arg3] fois par tour."
  },
  State_78712_Desc = {
    Text = "Au début du tour, le niveau de Fusion d'Embryon augmente de [Arg1]. Votre Embryon sera défaussé à la fin du tour."
  },
  State_78713_Desc = {
    Text = "Au début du tour, obtenez [Arg1] points de <RetaliateIconKeywords:comptoir>. Après avoir libéré [Arg2] fois l'exaltation en un tour, retirez [Arg3]% de comptoir permanent et recevez [Arg4]% du montant retiré en comptoir temporaire, temps de recharge de [Arg5] tours."
  },
  State_78781_Desc = {
    Text = "Réduction temporaire de la force de la cible, obtention d'une force temporaire équivalente."
  },
  State_78781_Name = {
    Text = "<TouquKeywords: voler>"
  },
  State_79405_Desc = {
    Text = "Après avoir joué, « souvenir clair » augmente de 1. Lorsqu'il atteint 10, verrouillez-le pendant 1 tour et obtenez 3 cartes « inspiration ». Au début du tour suivant, il est réinitialisé à 5."
  },
  State_79405_Name = {
    Text = "Le passé réel"
  },
  State_79406_Desc = {
    Text = "Après avoir joué, « souvenir clair » diminue de 1. Lorsqu'il atteint 0, verrouillez-le pendant 1 tour et faites gagner 30 points de folie à tous les éveillés. Au début du tour suivant, il est réinitialisé à 5."
  },
  State_79406_Name = {
    Text = "Rêve Faux et Luxueux"
  },
  State_80052_Desc = {Text = "Test"},
  State_80052_Name = {Text = "Test 123"},
  State_80052_WeaponDesc = {Text = "Test"},
  State_80161_Desc = {
    Text = "Équipe Unique : Les dégâts de base de l'exaltation de la folie du porteur augmentent de <WeaponEffect_Num:[StateArg1]%>, la régénération de Fragment de clé augmente de <WeaponEffect_Num:[StateArg2]%>. Après être entré dans un Tour Ultra, tous les Éveilleurs reçoivent <WeaponEffect_Num:[StateArg4]> points de fureur. Après avoir libéré «Annihilation», le porteur obtient <WeaponEffect_Num:[StateArg3]> points de fureur."
  },
  State_80161_WeaponDesc = {
    Text = "Les dégâts de base causés par l'exaltation du porteur augmentent de <WeaponEffect_Num:[StateArg1]%>, et la régénération de fragment de clé augmente de <WeaponEffect_Num:[DescArg1]>. Après être entré dans le tour ultra, tous les éveilleurs reçoivent <WeaponEffect_Num:[StateArg4]> points de fureur. Après avoir lâché « annihilation », le porteur obtient <WeaponEffect_Num:[StateArg3]> points de fureur."
  },
  State_80174_Desc = {
    Text = "Unique à l'équipe : La recharge de la clé en argent du porteur augmente de <WeaponEffect_Num:[StateArg1]%>. Après le début du premier combat, applique 1 niveau de faiblesse et de vulnérabilité à tous les ennemis."
  },
  State_80174_WeaponDesc = {
    Text = "La recharge de la clé en argent du porteur augmente de <WeaponEffect_Num:[DescArg1]>. Après le début du premier combat, appliquez 1 couche de <WeaknessIconKeywords:faiblesse> et de <VulnerabilityIconKeywords:vulnérabilité> à tous les ennemis."
  },
  State_80207_Desc = {
    Text = "Si cette carte déclenche une « Navette dimensionnelle » après avoir été jouée, déclencher l'effet suivant. Coût d'Arithmetica –1 lorsqu'elle est retirée de l'Espace Hyperspatial."
  },
  State_80207_Name = {
    Text = "<WormholeKeywords:Télékinésie>"
  },
  State_80328_Desc = {
    Text = "Elle est éternellement liée à la volonté collective, émotions, conscience et tout le reste. Empilable jusqu'à 15 fois. « La perception partagée » peut être convertie par l'« Exultation de Clémentine » en un effet négatif."
  },
  State_80328_Name = {Text = "Empathie"},
  State_80331_Desc = {
    Text = "Sous l'érosion de la Ruche, vos faiblesses sont pleinement exposées. Les Dégâts Directs et Dégâts des tentacules subis ce tour sont augmentés de [DescArg1]%."
  },
  State_80331_Name = {
    Text = "<D13Colour:Traumatisme mental>"
  },
  State_80332_Desc = {
    Text = "Elle est éternellement liée à la volonté collective, émotions, conscience et tout le reste, empilable jusqu'à 10 fois. « La perception partagée » peut être convertie par l'« Exultation de Clémentine » en un effet négatif."
  },
  State_80332_Name = {Text = "Empathie"},
  State_80335_Desc = {
    Text = "Sous l'érosion de la Ruche, vos faiblesses sont pleinement exposées. Les Dégâts Directs et Dégâts des tentacules subis ce tour sont augmentés de [DescArg1]%."
  },
  State_80335_Name = {
    Text = "<D13Colour:Traumatisme mental>"
  },
  State_80336_Desc = {
    Text = "Sous l'érosion de la Ruche, vos peurs sont mises à nu. Les Dégâts Directs et Dégâts des tentacules infligés ce tour sont réduits de [DescArg1]%."
  },
  State_80336_Name = {
    Text = "<D13Colour:Fixation phobique>"
  },
  State_80338_Desc = {
    Text = "Sous l'érosion de la Ruche, vos peurs sont mises à nu. Les Dégâts Directs et Dégâts des tentacules infligés ce tour sont réduits de [DescArg1]%."
  },
  State_80338_Name = {
    Text = "<D13Colour:Fixation phobique>"
  },
  State_80575_Desc = {
    Text = "Après avoir subi des dégâts directs ou des dégâts de tentacule, retirez une quantité équivalente de « Cendres anciennes » et perdez 300 % de la quantité retirée en PV. En subissant d'autres dégâts, retirez la moitié. Le nombre de couches de « Cendres anciennes » se réinitialise à chaque tour."
  },
  State_80575_Name = {
    Text = "Cendres anciennes"
  },
  State_80644_Name = {
    Text = "État@Lumière de Transcendance"
  },
  State_80773_Desc = {
    Text = "L'effet STR ▼ subi est réduit de 50%. Durant son propre tour, les dégâts subis autres que les Dégâts Directs et Dégâts des tentacules sont augmentés de 100%."
  },
  State_80773_Name = {
    Text = "Anticorps extradimensionnel"
  },
  State_80774_Desc = {
    Text = "Après avoir subi des dégâts directs ou des dégâts des tentacules, retirez une quantité équivalente de « Cendres anciennes » et perdez 300 % de cette quantité en PV. Lors de la réception d'autres dégâts, retirez la moitié. Les charges de « Cendres anciennes » se réinitialisent chaque tour. Après que toutes les « Cendres anciennes » aient été retirées, obtenez 50 couches de « Forteresse »."
  },
  State_80774_Name = {
    Text = "Cendres anciennes"
  },
  State_80777_Desc = {
    Text = "Au début de la bataille, réduisez de 10 % le taux de critique de tous les éveillés. Après la mort, les autres alliés obtiennent [DescArg1] points de pouvoir et [DescArg2] couches de « braises du passé »."
  },
  State_80777_Name = {
    Text = "Empathie du Nid : Héritage"
  },
  State_80778_Desc = {
    Text = "Après la mort, les autres alliés gagnent 1 stack de «Folie Temporaire»."
  },
  State_80778_Name = {
    Text = "Hive Empathie: Fusion"
  },
  State_80782_Desc = {
    Text = "Dans cette bataille, le taux critique de tous les éveillés est réduit de [Layer] %."
  },
  State_80782_Name = {
    Text = "Taux de coup critique réduit"
  },
  State_80783_Desc = {
    Text = "À la fin du tour, gagnez 1 accumulation de « Folie »."
  },
  State_80783_Name = {
    Text = "Lien de parenté"
  },
  State_80784_Desc = {
    Text = "Lorsque la vie descend en dessous de 50 %, invoque un « Premier Mutant » derrière toi. Cet effet ne peut être déclenché qu'une seule fois par combat."
  },
  State_80784_Name = {
    Text = "Empathie du Nid : Fission"
  },
  State_80785_Desc = {
    Text = "La Force réduite n'a que 50% d'effet sur cet ennemi. Chaque fois que vous déclenchez une Exaltation, gagnez 1 stack de «Folie Temporaire»."
  },
  State_80785_Name = {
    Text = "Empathie du Nid : Dimension Étrange"
  },
  State_80788_Desc = {
    Text = "La Force réduite n'a que 25% d'effet sur cet ennemi. Chaque fois que vous déclenchez une Exaltation, gagnez 1 stack de «Folie Temporaire»."
  },
  State_80788_Name = {
    Text = "Empathie du Nid : Dimension Étrange"
  },
  State_80789_Desc = {
    Text = "Dégâts Directs et Dégâts des tentacules subis +100%, pendant 1 tour."
  },
  State_80789_Name = {
    Text = "hibernation"
  },
  State_80790_Desc = {
    Text = "Après la transformation, chaque couche de pouvoir éthéré cosmique se perfectionnera..."
  },
  State_80790_Name = {
    Text = "Énergie cosmique"
  },
  State_80792_Desc = {
    Text = "Chaque fois que vous déclenchez une Exaltation, gagnez 1 stack de «Folie Temporaire»."
  },
  State_80792_Name = {
    Text = "Empathie du Nid : Dimension Étrange"
  },
  State_80794_Desc = {
    Text = "Les cartes ne peuvent pas être jouées et restent en main à la fin du tour."
  },
  State_80794_Name = {
    Text = "<Boundkeywords:Atterrir>"
  },
  State_80807_Desc = {
    Text = "Au début du cinquième tour ou lorsqu'il est sur le point de mourir, retire tous les autres ennemis et change l'intention en « Métamorphose »."
  },
  State_80807_Name = {
    Text = "Moment de Métamorphose"
  },
  State_80809_Desc = {
    Text = "À la fin du tour, les cartes marquées du néant en main seront défaussées."
  },
  State_80809_Name = {
    Text = "<PVPVoidKeyColour:Vide>"
  },
  State_80810_Desc = {
    Text = "Après avoir subi des dégâts directs ou des dégâts de tentacule, retirez une quantité équivalente de « Cendres anciennes » et perdez 300 % de la quantité retirée en PV, en subissant d'autres dégâts, retirez la moitié. Le nombre de charges de « Cendres anciennes » se réinitialise chaque tour."
  },
  State_80810_Name = {
    Text = "Cendres anciennes"
  },
  State_80827_Desc = {
    Text = "Chaque fois que 15 cartes sont jouées au total, remplace l'intention actuelle par « Frappe traumatisante » (il reste [Layer] cartes)."
  },
  State_80827_Name = {
    Text = "Châtiment de la colère"
  },
  State_81022_WeaponDesc = {
    Text = "Chaque fois que 1 point de dégâts est subi, tous les réveilleurs gagnent 1 point de folie"
  },
  State_81027_Desc = {
    Text = "Le propriétaire de cette carte est « Insectoïde », le Coût d'Arithmetica est réduit de 1, épuisée après avoir été jouée."
  },
  State_81027_Name = {
    Text = "Rite de Vie"
  },
  State_81054_Desc = {
    Text = "Sous l'érosion de la Ruche, vos peurs sont mises à nu. Pour chaque charge, les Dégâts Directs et Dégâts des tentacules infligés ce tour -3%, jusqu'à 15 charges maximum."
  },
  State_81054_Name = {
    Text = "<D13AFKeyWordQ1:Fixation phobique>"
  },
  State_81055_Desc = {
    Text = "Sous l'érosion de la Ruche, vos peurs sont mises à nu. Pour chaque charge, les Dégâts Directs et Dégâts des tentacules reçus ce tour +3%, jusqu'à 10 charges maximum."
  },
  State_81055_Name = {
    Text = "<D13AFKeyWord2:Trauma mental>"
  },
  State_81056_Desc = {
    Text = "Sous l'érosion de la Ruche, vos peurs sont mises à nu. Pour chaque charge, les Dégâts Directs et Dégâts des tentacules reçus ce tour +3%, jusqu'à 15 charges maximum."
  },
  State_81056_Name = {
    Text = "<D13AFKeyWordQ2:Trauma mental>"
  },
  State_81057_Desc = {
    Text = "Sous l'érosion de la Ruche, vos peurs sont mises à nu. Pour chaque charge, les Dégâts Directs et Dégâts des tentacules infligés ce tour -3%, jusqu'à 10 charges maximum."
  },
  State_81057_Name = {
    Text = "<D13AFKeyWord1:Fixation phobique>"
  },
  State_81058_Desc = {
    Text = "Ses émotions, sa conscience et son être tout entier sont éternellement liés à la volonté du groupe. « La perception partagée » peut être convertie par l'« Exultation de Clémentine » en un effet négatif, empilable jusqu'à 15 fois."
  },
  State_81058_Name = {
    Text = "<AnalysisKeywords3:Résonance>"
  },
  State_81059_Desc = {
    Text = "Ses émotions, sa conscience et tout le reste sont éternellement liés à la volonté du groupe. « La perception partagée » peut être convertie par l'« Exultation de Clémentine » en un effet négatif, empilable jusqu'à 10 fois."
  },
  State_81059_Name = {
    Text = "<AnalysisKeywords0:Résonance>"
  },
  State_81073_Desc = {
    Text = "Après avoir subi des dommages fatals, restaurez immédiatement toute la vie et obtenez un renforcement temporaire de 80 %, invoquez un « Premier Mutant » derrière vous et cet effet peut être déclenché 2 fois."
  },
  State_81073_Name = {
    Text = "Empathie du Nid : Fission"
  },
  State_81278_Desc = {
    Text = "Après la première activation de clé à chaque tour, tous les réveilleurs reçoivent 10 points de folie, mais l'activation de clé coûte 10% de plus indéfiniment"
  },
  State_81278_Name = {
    Text = "Inhibition de Clé d'Argent"
  },
  State_81312_Desc = {
    Text = "Après avoir subi des dommages critiques, restaurez toute la vie et obtenez 50 couches de renforcement temporaire. Cela peut être déclenché jusqu'à [Layer] fois."
  },
  State_81312_Name = {
    Text = "Réincarnation Cosmique"
  },
  State_81331_Desc = {
    Text = "Au début du tour, choisissez 1 éveillé et scellez toutes ses cartes et son exaltation pendant 3 tours."
  },
  State_81331_Name = {
    Text = "Incarcération Mentale"
  },
  State_81340_Desc = {
    Text = "Cette carte est scellée et ne peut pas être jouée. Le sceau est levé après [Layer] tours."
  },
  State_81340_Name = {
    Text = "<Seal1:Sceau de carte>"
  },
  State_81341_Desc = {
    Text = "Ce réveilleur a son exaltation scellée et ne peut pas l'utiliser. Le sceau sera levé après [Layer] tours."
  },
  State_81341_Name = {
    Text = "<Seal1:Sceau de Fureur>"
  },
  State_81354_Desc = {
    Text = "Après avoir été joué, subit [DescArg1] points de dégâts. Si non joué à la fin du tour, sera consommé."
  },
  State_81354_Name = {
    Text = "<BurningKeywords:Brûler>"
  },
  State_81356_Desc = {
    Text = "Enflamme la carte, subit [DescArg1] points de dégâts après avoir joué, et la consomme si elle est encore en main à la fin du tour."
  },
  State_81356_Name = {
    Text = "<BurningKeywords:Brûler>"
  },
  State_81356_WeaponDesc = {
    Text = "Chaque niveau de ralentissement augmente la consommation en arithmetica des cartes de 1 point"
  },
  State_83587_Desc = {
    Text = "Peut améliorer l'effet lors de la sélection de \"Prendre le Large\", limite 10 couches."
  },
  State_83587_Name = {
    Text = "« Hisser les voiles »"
  },
  State_83589_Desc = {
    Text = "Améliore l'effet sélectionné via « S'arrêter momentanément sur la rive », avec une limite maximale de 10 niveaux."
  },
  State_83589_Name = {
    Text = "Jeter l'ancre"
  },
  State_83593_Desc = {
    Text = "Ce tour, les dégâts finaux causés par tous les éveillés augmentent"
  },
  State_83593_Name = {
    Text = "Dégâts Finaux"
  },
  State_83596_Desc = {
    Text = "Limite de cartes en main +1. Au début du tour, si la pioche ne contient pas « Le Dilemme du Navigateur », placez-la dans votre main. Chaque fois que le chef perd 10% de ses PV Max, gagnez 1 couche « Hisser les voiles » ; chaque fois que vous perdez 10% de vos PV Max, gagnez 1 couche « Ancher »."
  },
  State_83596_Name = {
    Text = "Guidage d'Érasme - «Lever la voile»"
  },
  State_83607_Desc = {
    Text = "Jeton de perte de 10 % de la vie accumulée du boss"
  },
  State_83607_Name = {
    Text = "État@Jeton de perte de 10 % de la vie du boss accumulée"
  },
  State_83609_Desc = {
    Text = "Jeton représentant une perte cumulative de 10 % de la vie du joueur"
  },
  State_83609_Name = {
    Text = "État@Jeton de perte cumulative de 10 % de la vie du joueur"
  },
  State_83614_Desc = {
    Text = "10 % des points de vie du joueur"
  },
  State_83614_Name = {
    Text = "État@10 % de la santé du joueur"
  },
  State_83615_Desc = {
    Text = "Perdre [Layer] points de vie, puis gagner 1 niveau de « Partir »."
  },
  State_83615_Name = {
    Text = "Progrès de « Lever les voiles »"
  },
  State_83616_Desc = {
    Text = "Perdre [Layer] points de vie, puis obtenir 1 couche d'« ancrage »."
  },
  State_83616_Name = {
    Text = "Progrès de « Jetée d'ancre »"
  },
  State_83617_Desc = {
    Text = "10 % de la santé du boss"
  },
  State_83617_Name = {
    Text = "État@10 % de la santé maximale du boss"
  },
  State_83618_Desc = {
    Text = "Pendant les tests, la vie actuelle est de [Layer] points."
  },
  State_83618_Name = {
    Text = "Compteur de vie ennemie actuel"
  },
  State_83619_Desc = {
    Text = "Lors des tests, la santé maximale est de [Layer] points."
  },
  State_83619_Name = {
    Text = "Compteur de santé maximale ennemie"
  },
  State_83620_Desc = {
    Text = "La valeur actuelle du paramètre 4, multipliée par 100, est de [Layer] points."
  },
  State_83620_Name = {
    Text = "Paramètre d'impression"
  },
  State_83621_Desc = {
    Text = "10 % de la valeur intermédiaire du compteur de perte de santé du boss"
  },
  State_83621_Name = {
    Text = "État@10 % de la valeur intermédiaire du compteur de perte de vie du boss"
  },
  State_83622_Desc = {
    Text = "10 % de la valeur médiane du compteur de perte de vie du joueur"
  },
  State_83622_Name = {
    Text = "État@10 % de la valeur médiane du compteur de perte de vie du joueur"
  },
  State_83627_Desc = {
    Text = "Perdre [DescArg1] points de vie, puis gagner 1 niveau de « Partir »"
  },
  State_83627_Name = {
    Text = "Progrès de « Lever les voiles »"
  },
  State_83805_Name = {Text = "Réplica"},
  State_83807_Name = {
    Text = "Sombré dans la mer lointaine"
  },
  State_83808_Desc = {
    Text = "Cette carte déclenche l'effet « ondes résiduelles » lorsqu'elle est défaussée."
  },
  State_83808_Name = {
    Text = "<RippleKeywords:Onde>"
  },
  State_83811_Desc = {
    Text = "Subissez [Layer] % de dégâts de tentacule supplémentaires."
  },
  State_83812_Desc = {
    Text = "Subissez [Layer] % de dégâts de tentacule supplémentaires."
  },
  State_83814_Desc = {
    Text = "10 % de la santé du boss"
  },
  State_83814_Name = {
    Text = "10 % des points de vie du boss"
  },
  State_84140_Desc = {
    Text = "Ce combat a consommé [Layer] « Division glandulaire » via « Océan tumultueux »."
  },
  State_84140_Name = {
    Text = "Océan bruyant"
  },
  State_84184_Name = {
    Text = "Cette compétence bénéficie d'un bonus de puissance supplémentaire de [Layer] %"
  },
  State_84255_Desc = {
    Text = "Équipe unique : Au début du combat, obtenez un bouclier équivalent à <WeaponEffect_Num:[StateArg1]%> de la défense de l'équipé. Après avoir déclenché la résistance à la mort, l'effet se réactive au début du prochain tour."
  },
  State_84255_Name = {
    Text = "Guide en Haute Mer"
  },
  State_84255_WeaponDesc = {
    Text = "Au début du combat, obtenez <WeaponEffect_Num:[Block:DescArg1]> points de bouclier. Après avoir déclenché la résistance à la mort, le effet se déclenche à nouveau au début du prochain tour."
  },
  State_84257_Desc = {
    Text = "Équipe unique : Le bouclier causé par l'exaltation de la fureur du porteur est augmenté de <WeaponEffect_Num:[StateArg1]%>, après avoir libéré l'exaltation, tous les éveilleurs reçoivent une augmentation temporaire des dégâts critiques de <WeaponEffect_Num:[StateArg2]%>, augmentant de 1% par tentacule supplémentaire. Après chaque activation de la résistance à la mort lors de l'exploration, au début du tour suivant, récupérez <WeaponEffect_Num:[StateArg3]%> de PV Max."
  },
  State_84257_WeaponDesc = {
    Text = "Le bouclier causé par l'exaltation du porteur augmente de <WeaponEffect_Num:[StateArg1]%>, après avoir libéré l'exaltation, tous les Éveilleurs reçoivent une augmentation temporaire des dégâts critiques de <WeaponEffect_Num:[StateArg2]%>, et chaque tentacule supplémentaire augmente de 1%. Après la première résistance à la mort déclenchée lors de chaque exploration, au début du tour suivant, régénérez <WeaponEffect_Num:[StateArg3]%> de votre vie maximale."
  },
  State_84272_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : À la fin du tour, soigne l'allié ayant perdu le plus de PV de <Heal:[Heal:StateArg1]> PV."
  },
  State_84272_Name = {
    Text = "Guide en Haute Mer"
  },
  State_84273_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : À l'équipement et au début du tour, si vous ne possédez pas de <PVPProtectiveKeywords:barrière>, obtenez [StateArg1] couches de <PVPProtectiveKeywords:barrière>, sinon gagnez <Energy:[Energy:StateArg2]> folie."
  },
  State_84273_Name = {
    Text = "Navigateur Flamboyant"
  },
  State_84364_Desc = {
    Text = "Dégâts critiques +[Layer] %"
  },
  State_84364_Name = {
    Text = "Dégâts Critiques"
  },
  State_84368_Desc = {
    Text = "Il reste [Layer] tours de refroidissement."
  },
  State_84368_Name = {
    Text = "Sombré dans la mer lointaine"
  },
  State_84375_Desc = {
    Text = "Au début du tour, obtenez [Layer] points de bouclier."
  },
  State_84375_Name = {
    Text = "Guide en Haute Mer"
  },
  State_84376_Desc = {
    Text = "Au début du tour, obtenez [Layer] points de soin."
  },
  State_84376_Name = {
    Text = "Navigateur Flamboyant"
  },
  State_84399_Desc = {
    Text = "À la fin de chaque tour, les dégâts subis augmentent de 5 % et vous obtenez 2 couches de barrière."
  },
  State_84399_Name = {
    Text = "Sombré dans la mer lointaine"
  },
  State_84400_Desc = {
    Text = "Au début du prochain tour, convertissez chaque couche de barrière en 1 couche <ReinforcePVEKeywords:renforcé>."
  },
  State_84400_Name = {
    Text = "« Navigation »"
  },
  State_84402_Desc = {
    Text = "Augmente les dégâts subis de [Layer] %."
  },
  State_84402_Name = {
    Text = "Force de découvert"
  },
  State_89340_Desc = {
    Text = "Subissez [Layer] % de dégâts de tentacule supplémentaires."
  },
  State_89340_Name = {
    Text = "Tentacule Faiblesse"
  },
  State_89422_Desc = {
    Text = "La folie générée par tous les réveilleurs augmente de 100 %. Deux exultations peuvent être libérées par tour."
  },
  State_89422_Name = {
    Text = "« Cœur Inébranlable »"
  },
  State_89447_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Limite Max de la Main +[StateArg2]. Gagnez [StateArg1] Arithmetica après « Exaltation »."
  },
  State_89447_Name = {
    Text = "Liberté Insupportable"
  },
  State_89448_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : À la fin du tour, l'allié ayant le moins de PV et de bouclier gagnera [StateArg1] <PVPDerivativeCardKeywords_16:\"Plume d'Onyx\">."
  },
  State_89448_Name = {
    Text = "Plume Solitaire"
  },
  State_89554_Name = {
    Text = "Destin lumineux"
  },
  State_89555_Desc = {
    Text = "Équipe Unique : Après que le Porteur déclenche l'Exaltation, Dommage de base de l'Exaltation +<WeaponEffect_Num:[StateArg1]%>, Bouclier du personnage et Régénération de PV +<WeaponEffect_Num:[StateArg2]%>, s'accumulant jusqu'à 5 fois. Lors de l'exploration, le Taux de synchronisation gagné par le Porteur +<WeaponEffect_Num:[StateArg3]%>."
  },
  State_89555_WeaponDesc = {
    Text = "Après que le porteur ait libéré l'exaltation, les dégâts de base de l'exaltation augmentent de <WeaponEffect_Num:[StateArg1] %>, le bouclier et la récupération de vie augmentent de <WeaponEffect_Num:[StateArg2] %>, pouvant se cumuler jusqu'à 5 fois. Après avoir terminé l'exploration, le taux de synchronisation du porteur augmente de <WeaponEffect_Num:[StateArg3] %>."
  },
  State_89557_Name = {
    Text = "Lentille prismatique"
  },
  State_89559_Desc = {
    Text = "\n·Paradoxe existentiel : Au début de l'exploration, 75 % de la résistance à la mort est convertie en bonus de points de vie maximum, jusqu'à 300 % de résistance à la mort convertie, augmentant les PV maximum de 10 % au plus. Chaque déclenchement de la résistance à la mort place en plus 1 carte « Lueur de Clé d'Argent » dans la main.\n·Cicatrice sans fond : Durant un combat de boss, chaque fois que les soins reçus par notre équipe atteignent 100 % du plafond de vie, l'efficacité des soins ultérieurs reçus diminue de 25 %, mais le total actuel de résistance à la mort augmente de 25 %, jusqu'à 3 déclenchements maximum.\n·Prisme chromatique : Au début du tour, si le contre-attaque dépasse 2000 % du plafond de vie, les couches excédentaires sont réduites de moitié, et le contre-attaque permanent peut s'accumuler jusqu'à 6000 % du plafond de vie au maximum ; si l'empoisonnement ennemi dépasse 3000 % du plafond de vie, les couches excédentaires sont réduites de moitié, et l'empoisonnement peut s'accumuler jusqu'à 9000 % du plafond de vie au maximum. Le bonus de dégâts obtenu par les Éveillés via le contre-attaque est réduit de 70 %, mais tous les empoisonnements et contre-attaques infligés augmentent de 10 %. Pour chaque Éveillé éveillé : après la fin du tour, on obtient un contre-attaque temporaire égal à 25 % du contre-attaque permanent actuel ; à la fin du tour ennemi, tous les ennemis subissent un déclenchement supplémentaire de 25 % d'empoisonnement.\n·Cône de lumière du destin : Le nombre de tours pendant lesquels les monstres ordinaires utilisent « Regard Fixe » devient 6 tours. Au début du tour 15, 1 carte « Limite du Cône de Lumière » est placée dans la main : remplit l'énergie de Clé d'Argent et la jauge de folie de tous les Éveillés à leur valeur maximale."
  },
  State_89559_Name = {
    Text = "Distorsion spatio-temporelle"
  },
  State_89567_Desc = {
    Text = "La consommation d'arithmetica de cette carte est réduite de [StateArg1]."
  },
  State_89567_Name = {
    Text = "Renaissance dans la Terre Anéantie"
  },
  State_89568_Desc = {
    Text = "<PVPWeaponKeywords:roue du destin> : Après la mort de l'équipier, mélange toutes les « compétence » dont le coût en calcul est réduit de -[StateArg1] dans la pile de pioche, et transfère leur propriété à l'allié restant avec le plus de PV."
  },
  State_89568_Name = {
    Text = "Renaissance dans la Terre Anéantie"
  },
  State_89571_Name = {
    Text = "« Théâtre en flammes »"
  },
  State_89572_Desc = {
    Text = "Au début du tour, appliquez <BurningKeywords:Brûlure> à [DescArg1] cartes aléatoires du deck adverse et obtenez [DescArg2] points de <PowerIconKeywords:force> temporaire. Tous les 2 tours, le nombre de cartes brûlées augmente de 1 et la force temporaire obtenue augmente de [DescArg3] points."
  },
  State_89572_Name = {
    Text = "« Théâtre en flammes »"
  },
  State_89626_Desc = {
    Text = "Utilisez l'Éveil de la clé d'argent puis ajoutez 1 « Lueur de la clé d'argent » à votre main. Une fois que tous les réveilleurs sont éveillés, au début de chaque tour, trouvez aléatoirement 1 soutien d'un réveilleur."
  },
  State_89631_Desc = {
    Text = "Supplémentaire : [Layer] sauts"
  },
  State_89634_Desc = {
    Text = "Réveil de gnose 4"
  },
  State_89634_Name = {
    Text = "Réveil de gnose 4"
  },
  State_89637_Desc = {
    Text = "La première carte d'instruction jouée chaque tour prend effet 1 fois supplémentaire. Lors de l'annihilation, un tentacule est généré. Après avoir changé le tentacule en posture « Vagues Déchaînées », les 2 prochaines cartes d'instruction de ce tour activeront obligatoirement l'effet de saut quantique et entreront dans l'Espace Hyperspatial, avec un temps de recharge de 3 tours."
  },
  State_89640_Desc = {
    Text = "La maîtrise des royaumes augmente de 200 points. Lors de la consommation de la fournaise cramoisie, les dégâts des tentacules sont augmentés de 15 % de la quantité consommée. À chaque attaque de tentacule, accumulez [Arg3] points de la fournaise cramoisie."
  },
  State_89642_Desc = {
    Text = "Limite Max de la Main +2, après avoir libéré l'Exaltation, les Dégâts Finaux augmentent temporairement de 10%. Lorsque les cartes entrent dans l'Espace Hyperspatial, 1 « Embryon » dans la main se transforme en « Fils de la sainteté ». Chaque fois qu'un « Embryon » est généré, le Coût d'Arithmetica d'une carte aléatoire dans l'Espace Hyperspatial est réduit de 1."
  },
  State_89669_Desc = {
    Text = "Éveil de la clé d'argent 4"
  },
  State_89669_Name = {
    Text = "Éveil de la clé d'argent 4"
  },
  State_89759_Desc = {
    Text = "Après avoir libéré la clé, Ramona obtient 50 % de taux critique temporaire."
  },
  State_89759_Name = {
    Text = "Lien Précieux"
  },
  State_90023_Name = {
    Text = "État utilisé pour la configuration de la table des constantes, actuellement abandonné."
  },
  State_90059_Desc = {
    Text = "Ce tour, lorsque vous subissez des Dommages actifs ou des Dégâts des tentacules, retirez une quantité égale de Corrosion et perdez [DescArg1]% de PV correspondant à la quantité retirée. Lorsque vous subissez d'autres Dommages, retirez une Corrosion équivalente à 50% des Dommages subis."
  },
  State_90059_Name = {Text = "Corrosion"},
  State_90094_Name = {
    Text = "Plume Noire"
  },
  State_90218_Desc = {
    Text = "Équipe Unique : Limite Max de la Main +2, les effets similaires ne peuvent pas s'accumuler. Le bouclier et les Dommages de base infligés par le porteur augmentent de <WeaponEffect_Num:[StateArg1]%, après être entré dans un Tour Ultra, il obtient <WeaponEffect_Num:[StateArg2]> points de Fureur. Après avoir libéré « Annihilation », tous les Éveilleurs reçoivent des Dégâts Critiques temporaires de +<WeaponEffect_Num:[StateArg3]%, avec un temps de recharge de 3 tours."
  },
  State_90218_WeaponDesc = {
    Text = "Limite Max de la Main +2, les effets similaires ne peuvent pas se cumuler. Le bouclier et les dégâts de base causés par le porteur augmentent de <WeaponEffect_Num:[StateArg1]%>, après être entré dans un Tour Ultra, il obtient <WeaponEffect_Num:[StateArg2]> points de folie. Après avoir libéré « Annihilation », tous les Éveilleurs reçoivent des Dommages critiques temporaires +<WeaponEffect_Num:[StateArg3] %>, avec un temps de recharge de 3 tours."
  },
  State_90221_Desc = {
    Text = "Équipe unique : le bouclier causé par l'équipé est augmenté de <WeaponEffect_Num:[StateArg1]%>, à la fin du tour, obtenez un bouclier égal à <WeaponEffect_Num:[StateArg2]%> de la défense de l'équipé, augmentant de 2% de la défense chaque tour."
  },
  State_90221_Name = {
    Text = "Plume Solitaire"
  },
  State_90221_WeaponDesc = {
    Text = "Le bouclier causé par l'équipé est augmenté de <WeaponEffect_Num:[StateArg1]%>, et à la fin du tour, gagnez <WeaponEffect_Num:[Block:DescArg1]> points de bouclier."
  },
  State_90294_Desc = {
    Text = "Ce tour, lorsque vous subissez des Dommages actifs ou des Dégâts des tentacules, retirez une quantité égale de Corrosion et perdez [DescArg1]% de PV correspondant à la quantité retirée. Lorsque vous subissez d'autres Dommages, retirez une Corrosion équivalente à 50% des Dommages subis."
  },
  State_90294_Name = {
    Text = "<Corrosion:Corrosion>"
  },
  State_90591_Name = {
    Text = "Placez [Layer] cartes « Inspiration » dans votre main"
  },
  State_90594_Name = {
    Text = "et [Layer] points d'alerte temporaire"
  },
  State_90599_Name = {
    Text = "Confère à tous les éveillés [Layer] points de folie"
  },
  State_90600_Name = {
    Text = "Gagnez [Layer] points de s-énergie"
  },
  State_90601_Name = {
    Text = "(Il reste [DescArg1] fois <harmonyKeyWord:« harmonisation »>)"
  },
  State_90603_Name = {
    Text = "Obtenir [Layer] points de force temporaire"
  },
  State_90604_Name = {
    Text = "Restaurez [Layer] PV, augmente avec les PV perdus"
  },
  State_90696_Desc = {
    Text = "Découvrez 1 « épice » avant de jouer, placez-la dans le mélange et déclenchez son effet. En combat de boss, le nombre de mélanges augmente de 1."
  },
  State_90696_Name = {
    Text = "<harmonyKeyWord:assaisonnement>"
  },
  State_91106_Desc = {
    Text = "Chaque niveau de ferveur ajoute 10 % de dégâts équivalents en <BleedingIconKeywords:saignement> aux dégâts actifs et aux dégâts de tentacule que vous infligez."
  },
  State_91106_Name = {Text = "Ferveur"},
  State_91165_Name = {Text = "Oeuf Pâle"},
  State_91235_Desc = {
    Text = "En perdant des PV, réduit un nombre égal de charges. Lorsque Blessure atteint 0, tous les Éveilleurs gagnent 10 Fureur et les charges de Blessure sont réinitialisées."
  },
  State_91235_Name = {Text = "Blessure"},
  State_91236_Name = {
    Text = "Activité de Rome applique le compteur de santé maximale ennemie"
  },
  State_91329_Desc = {
    Text = "La consommation d'arithmetica de cette carte est réduite de [StateArg1]."
  },
  State_91329_Name = {
    Text = "Délices Macabres"
  },
  State_91521_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : À la fin du tour, mélangez [StateArg1] <PVPDerivativeCardKeywords_17:\"Inspiration\"> dans votre main."
  },
  State_91521_Name = {
    Text = "Formation spéciale"
  },
  State_91522_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : En s'équipant et à la fin du tour, le Porteur inflige <Damage:[Damage:StateArg1]> Dommages à l'ennemi de dernière ligne."
  },
  State_91522_Name = {
    Text = "Premier jour de l'année scolaire"
  },
  State_91676_Desc = {
    Text = "Voir la logique de grève générale pour des effets spécifiques. __ \"Pour usage de développement uniquement\""
  },
  State_91706_Desc = {
    Text = "Au début du prochain tour, obtenez une quantité d'arithmetica équivalente aux couches."
  },
  State_91706_Name = {
    Text = "<CardKeyWord:Conserver l'arithmétique>"
  },
  State_91717_Desc = {
    Text = "Accumule jusqu'à 3 dépouilles. Une fois la limite atteinte, le prochain «Festin des êtres vivants» pourra les consommer et en renforcer les effets. Les dépouilles seront transmises à la prochaine bataille."
  },
  State_91717_Name = {Text = "Débris"},
  State_91759_Desc = {
    Text = "Plume noire peut renforcer les capacités de « Saint Fils · Plume noire »."
  },
  State_91759_Name = {
    Text = "Plume Noire"
  },
  State_91761_Desc = {
    Text = "« Fils de la Plume Noire » : 50 % du bouclier non brisé est conservé pour le prochain tour. Gagne 1 niveau de <Guaiwuheiyu:Plume Noire> à la fin du tour."
  },
  State_91761_Name = {
    Text = "Anseing de Vol"
  },
  State_91797_Desc = {
    Text = "Après que cette carte a été jouée et défaussée, appliquez une quantité égale de couches de bouclier aux ennemis de la première ligne."
  },
  State_91797_Name = {
    Text = "<PVPredKeyword:Douleur cachée>"
  },
  State_91799_Desc = {
    Text = "Cette carte, une fois jouée, applique un bouclier de [Layer] à l'ennemi de première ligne."
  },
  State_91799_Name = {
    Text = "<PVPredKeyword:Angoisse voilée [Layer]>"
  },
  State_91809_Desc = {
    Text = "La consommation d'arithmetica de cette carte diminue de [Layer]."
  },
  State_91809_Name = {
    Text = "Concentrer l'esprit"
  },
  State_91819_Desc = {
    Text = "Obtient l'amélioration correspondante en fonction du tour de combat actuel."
  },
  State_91819_Name = {
    Text = "<CardKeyWord: Croissance>"
  },
  State_91827_Desc = {
    Text = "« Frappe » peut choisir sa cible et repousse tous les états positifs de la cible vers l'entité éveillée derrière elle avant d'infliger les dégâts."
  },
  State_91827_Name = {
    Text = "<CardKeyWord:Appel du Fond Marin>"
  },
  State_94410_Name = {
    Text = "Chaque fois qu'un tour commence et qu'une action se termine, il essaiera de réinitialiser la pile de cartes du joueur si elle est vide, sinon elle ne sera pas réinitialisée."
  },
  State_94411_Name = {
    Text = "Chaque fois qu'un tour commence et qu'une action se termine, il essaiera de réinitialiser la pile de cartes du joueur si elle est vide, sinon elle ne sera pas réinitialisée."
  },
  State_94426_Name = {
    Text = "Bouclier passif"
  },
  State_94540_Desc = {
    Text = "Si aucune autre entité éveillée ne se trouve derrière la cible, dissipe l'état positif de cette dernière."
  },
  State_94540_Name = {
    Text = "<CardKeyWord:Repousser les états positifs>"
  },
  State_94600_Desc = {
    Text = "Après avoir subi des dégâts fatals, retire 1 couche et restaure 5 % de la santé maximale. Chaque déclenchement augmente la récupération de 1 % pendant ce tour."
  },
  State_94600_Name = {
    Text = "Résistance à la mort"
  },
  State_94603_Name = {
    Text = "Marque de goule"
  },
  State_94608_Name = {
    Text = "Nombre de déclenchements de la résistance à la mort"
  },
  State_94623_Desc = {
    Text = "Chaque niveau de ferveur ajoute 10 % de dégâts équivalents en <BleedingIconKeywords:saignement> aux dégâts actifs et aux dégâts de tentacule que vous infligez."
  },
  State_94623_Name = {
    Text = "<Kuangre:Ferveur>"
  },
  State_94657_Desc = {
    Text = "Lorsque l'ennemi est tué ou que son effet de résurrection est déclenché, l'effet correspondant est activé."
  },
  State_94657_Name = {
    Text = "<KillKeywords:Détruire>"
  },
  State_94692_Desc = {
    Text = "Après avoir subi des dégâts fatals, retire 1 couche et restaure 5 % de la santé maximale. Chaque déclenchement augmente la récupération de 1 % pendant ce tour."
  },
  State_94692_Name = {
    Text = "<Guaiwusiwangdikang: Résistance à la mort>"
  },
  State_94693_Desc = {
    Text = "Au début du tour, s'il y a un autre allié, perdez [DescArg1] points de vie et ajoutez 1 couche de <Guaiwusiwangdikang:Résistance à la mort> et [DescArg2] points de <PowerIconKeywords:force> à l'allié avec le plus de PV."
  },
  State_94693_Name = {
    Text = "Festin de cadavres"
  },
  State_94708_Desc = {
    Text = "Au début du tour, s'il y a d'autres alliés, perdez [DescArg1] points de vie et ajoutez 1 couche de <Guaiwusiwangdikang: Résistance à la mort> et [DescArg2] points de <Duren: Lame empoisonnée> à l'allié avec le plus de PV."
  },
  State_94708_Name = {
    Text = "Festin des fonds marins"
  },
  State_94730_Desc = {
    Text = "Inflige des dégâts actifs qui ne sont pas bloqués, applique [Layer] points de <IntoxicationIconKeywords:poison>."
  },
  State_94730_Name = {
    Text = "Lame empoisonnée"
  },
  State_94993_Desc = {
    Text = "Réinitialiser le nombre de fois de « Vague de colère » chaque tour."
  },
  State_94993_Name = {
    Text = "Réinitialisation du nombre de Vagues de colère"
  },
  State_94994_Desc = {
    Text = "Chaque couche ajoute une attaque, perd une couche en cas de dégâts critiques, minimum 1 couche, perd toutes les couches à la fin du tour."
  },
  State_94994_Name = {
    Text = "Vague de colère céleste Nombre de fois"
  },
  State_94995_Desc = {
    Text = "Chaque fois que vous subissez des Dégâts Critiques, obtenez 3 % de <Baojidikang:Résistance Critique Temporaire>. Chaque fois que vous infligez des Dommages, ajoutez « Marque de Plongée Profonde » à une carte aléatoire."
  },
  State_94995_Name = {
    Text = "Cérémonie des profondeurs marines"
  },
  State_94996_Desc = {
    Text = "En étant attaqué, obtenez des points de force temporaire équivalents aux charges."
  },
  State_94996_Name = {Text = "Fureur"},
  State_94997_Desc = {
    Text = "Chaque fois que vous subissez des Dégâts Critiques, obtenez 5 % de <Baojidikang:Résistance Critique Temporaire>. Chaque fois que vous infligez des Dommages, ajoutez « Marque de Plongée Profonde » à une carte aléatoire."
  },
  State_94997_Name = {
    Text = "Cérémonie des profondeurs marines"
  },
  State_94998_Desc = {
    Text = "Lorsque <Guaiwusiwangdikang: Résistance à la mort> est déclenchée, appliquez <SlowIconKeywords:ralentir> à une carte aléatoire dans la pile de pioche ou dans la main."
  },
  State_94998_Name = {
    Text = "Incarnation du Désespoir"
  },
  State_94999_Desc = {
    Text = "Réinitialiser le nombre de Vague dévorant le ciel chaque tour."
  },
  State_94999_Name = {
    Text = "Vague dévorant le ciel - Réinitialiser le nombre de fois"
  },
  State_95000_Desc = {
    Text = "Immunité aux états négatifs."
  },
  State_95000_Name = {
    Text = "Immunité aux états négatifs"
  },
  State_95001_Desc = {
    Text = "Chaque couche ajoute une attaque, perd une couche en cas de dégâts critiques, minimum 1 couche, perd toutes les couches à la fin du tour."
  },
  State_95001_Name = {
    Text = "Nombre de vagues dévorant le ciel"
  },
  State_95002_Desc = {
    Text = "Ce tour, probabilité de subir un coup critique réduite de [Layer] %."
  },
  State_95002_Name = {
    Text = "Résistance temporaire aux coups critiques"
  },
  State_95002_WeaponDesc = {
    Text = "Ce tour, probabilité de subir un coup critique réduite de [Layer] %."
  },
  State_95035_Desc = {
    Text = "Lors de la gestion des dégâts actifs non bloqués, appliquez 1 point de <IntoxicationIconKeywords: poison> pour chaque couche."
  },
  State_95035_Name = {
    Text = "<Duren: Lame empoisonnée>"
  },
  State_95038_Desc = {
    Text = "En étant attaqué, gagnez des points de force temporaire équivalents aux charges."
  },
  State_95038_Name = {
    Text = "<Kuangbao: Rage>"
  },
  State_95040_Desc = {
    Text = "Enregistrer la vie perdue"
  },
  State_95040_Name = {
    Text = "Enregistrer la vie perdue"
  },
  State_95932_Name = {
    Text = "Suce-goule attendre"
  },
  State_95937_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Après « Exaltation », piochez [StateArg1] <plural value=\"[StateArg1]\" singular=\"carte\" plural=\"cartes\">, priorisez vos propres cartes « compétence », et réduisez leur Coût d'Arithmetica de [StateArg2]."
  },
  State_95937_Name = {
    Text = "Délices Macabres"
  },
  State_95938_Desc = {
    Text = "Chaque fois qu'une carte est retirée, le niveau de rassasiement augmente de 1, avec une limite maximale de 10 niveaux"
  },
  State_95938_Name = {Text = "Saciation"},
  State_95943_Desc = {
    Text = "Les dégâts infligés sont temporairement réduits de 30 %."
  },
  State_95943_Name = {
    Text = "Interférence positive"
  },
  State_95944_Desc = {
    Text = "Équipe Unique : Les dégâts de base infligés par le porteur augmentent de <WeaponEffect_Num:[StateArg1]%>, et pour chaque élimination, le taux critique du porteur augmente de 2% pendant cette exploration et les dégâts de base de l'exaltation augmentent de <WeaponEffect_Num:[StateArg2]%, cumulable jusqu'à 10 fois. Si le royaume actuel est «Chair», utiliser directement un «Embryon» sur le porteur octroie <WeaponEffect_Num:[StateArg4]> points de folie supplémentaires, avec un temps de recharge de 3 tours."
  },
  State_95944_WeaponDesc = {
    Text = "Les dégâts de base infligés par l'équipé augmentent de <WeaponEffect_Num:[StateArg1]%>, chaque élimination augmente le taux critique de l'équipé de 2% pour cette exploration et les dégâts de base de l'exaltation augmentent de <WeaponEffect_Num:[StateArg2]%, cumulable jusqu'à 10 fois. Si le royaume actuel est «Chair», l'utilisation directe d'un «embryon» sur l'équipé octroie <WeaponEffect_Num:[StateArg4]> points de fureur, avec un temps de recharge de 3 tours."
  },
  State_95948_Name = {Text = "Suce-goule"},
  State_95949_Desc = {
    Text = "Après utilisation, Dursain perd la moitié des <Guaiwucanhai:débris>."
  },
  State_95949_Name = {
    Text = "Réserves d'embuscade"
  },
  State_95953_Desc = {
    Text = "L'effet de récupération de vie de la Résistance à la mort est multiplié par 5."
  },
  State_95953_Name = {
    Text = "Véil des Rêves Obscurs"
  },
  State_95954_Name = {
    Text = "Suce-goule : Réveil"
  },
  State_95960_Desc = {
    Text = "Le nombre de débris augmente l'efficacité de « Récupération des débris »."
  },
  State_95960_Name = {Text = "Débris"},
  State_95962_Name = {
    Text = "Total de kills __ \"À utiliser uniquement pour le développement\""
  },
  State_95964_Desc = {
    Text = "Équipe Unique : Les dégâts de base infligés par le porteur augmentent de <WeaponEffect_Num:[StateArg1]%. Si le royaume actuel est « Chair », lorsque le porteur élimine un ennemi, il accumule dans la Forge Écarlate <WeaponEffect_Num:[StateArg2]%> de son attaque."
  },
  State_95964_WeaponDesc = {
    Text = "Les dégâts de base infligés par l'équipement augmentent de <WeaponEffect_Num:[StateArg1]%>. Si le domaine actuel est « Chair », lorsque l'équipement tue un ennemi, accumulez <WeaponEffect_Num:[DescArg1]> points de la fournaise cramoisie."
  },
  State_95966_Desc = {
    Text = "Au début du prochain tour, piochez [Layer] cartes de l'éveillé correspondant."
  },
  State_95966_Name = {
    Text = "Salutation cruelle"
  },
  State_95967_Desc = {
    Text = "Le nombre de débris augmente l'efficacité de « Récupération des débris »."
  },
  State_95967_Name = {
    Text = "<Guaiwucanhai:Squelette>"
  },
  State_95968_Desc = {
    Text = "<PVPWeaponKeywords:roue du destin> : En s'équipant, obtenez [StateArg1] <StrongEffectKeywords:puissant>. Les dégâts excédentaires lors de la destruction d'un ennemi sont transmis aux ennemis situés derrière."
  },
  State_95968_Name = {
    Text = "Dernier Baiser"
  },
  State_96167_Desc = {
    Text = "Indissipable, après l'élimination d'un Éveilleur, les autres alliés obtiennent [StateArg1] <StrongEffectKeywords:Amplification>."
  },
  State_96167_Name = {
    Text = "Cendre Brûlante de l'Étoile Noire"
  },
  State_96183_Desc = {
    Text = "À la fin du tour, si aucun autre allié n'est présent sur le champ de bataille, changez l'intention en auto-explosion"
  },
  State_96183_Name = {
    Text = "Auto-destruction de goule"
  },
  State_96193_Name = {
    Text = "Étiquette avant le repas"
  },
  State_96330_Desc = {
    Text = "Pour chaque 1 % de vie perdue par l'unité, les dégâts de base, le bouclier et la folie générés par les cartes de commandement de Durelsein augmentent de 1 %."
  },
  State_96330_Name = {
    Text = "Chuchotements Fantômes"
  },
  State_96352_Name = {
    Text = "Compteur des goules originelles"
  },
  State_96354_Name = {
    Text = "Vie maximale initiale"
  },
  State_96355_Desc = {
    Text = "La probabilité de subir un coup critique est réduite de [Layer]%."
  },
  State_96355_Name = {
    Text = "Résistance Critique"
  },
  State_96355_WeaponDesc = {
    Text = "Dans ce combat, la probabilité de subir un coup critique diminue de [Layer]%."
  },
  State_96356_Desc = {
    Text = "Pour chaque [DescArg1] point(s) de vie perdu(s), gagnez [DescArg2] couche(s) <ReinforcePVEKeywords:renforcé>, jusqu'à un maximum de [DescArg3] couches. Lorsque « <Guaiwusiwangdikang:Résistance à la mort> » est déclenché, le maximum de vie propre augmente de [DescArg4] %."
  },
  State_96356_Name = {
    Text = "Protection d'Ilaine"
  },
  State_96357_Desc = {
    Text = "Après la fin du tour, gagne des couches de force équivalentes"
  },
  State_96357_Name = {
    Text = "<Fennu: Colère>"
  },
  State_96358_Desc = {
    Text = "La probabilité de subir un coup critique est réduite de [Layer] %."
  },
  State_96358_Name = {
    Text = "<Baojidikang:Résistance aux coups critiques>"
  },
  State_96412_Name = {
    Text = "Surveillance gourmande"
  },
  State_96416_Desc = {
    Text = "La probabilité de subir un coup critique est réduite de [Layer]%."
  },
  State_96416_Name = {
    Text = "Résistance Critique"
  },
  State_96603_Name = {
    Text = "Si aucune carte n'est jouée ce tour, déclenchez une fois l'effet « Harmonisation » au début du prochain tour"
  },
  State_96610_Name = {
    Text = "Première résistance à la mort"
  },
  State_96613_Name = {
    Text = "Surveillance de la vague déferlante"
  },
  State_96650_Desc = {
    Text = "Chaque couche augmente le taux critique de tous les Réveilleurs de [DescArg1]%."
  },
  State_96650_Name = {
    Text = "<ExclamationPointColour:Flamme Sombre Profonde>"
  },
  State_96719_Desc = {
    Text = "Quand une carte <BurningKeywords:Brûlant> est jouée ce tour-ci, épuisez 1 couche de <Heat:Flamme Sombre> pour la rendre efficace 2 fois, et effacez <Heat:Flamme Sombre> à la fin du tour."
  },
  State_96719_Name = {
    Text = "Flamme infinie"
  },
  State_96731_Desc = {
    Text = "Quand une carte <BurningKeywords:Brûlant> est jouée ce tour-ci, épuisez 1 couche de <Heat:Flamme Sombre> pour la rendre efficace 2 fois, et effacez <Heat:Flamme Sombre> à la fin du tour."
  },
  State_96731_Name = {
    Text = "<Overload:Inflammation Infinie>"
  },
  State_96732_Desc = {
    Text = "Chaque couche augmente le taux critique de tous les Réveilleurs de [DescArg1]%."
  },
  State_96732_Name = {
    Text = "<Heat:Flamme Sombre Profonde>"
  },
  State_96740_Desc = {
    Text = "Les dégâts des attaques actives et le nombre de couches de saignement augmentent de 50%, et les dégâts sont retirés au début de chaque ronde."
  },
  State_96740_Name = {
    Text = "<CardKeyWord:Faille>"
  },
  State_96741_Desc = {
    Text = "Si l'Arithmetica restante est supérieure à [StateArg1] après avoir joué, consomme en plus [StateArg1] Arithmetica pour déclencher des effets ultérieurs. __ \"Pour le Développement Seulement\""
  },
  State_96741_Name = {
    Text = "<CardKeyWord:Surcharge arithmétique>"
  },
  State_96742_Name = {
    Text = "Marque de déclenchement de surcharge arithmétique"
  },
  State_96743_Desc = {
    Text = "Après avoir joué, si l'arithmétique restante est supérieure à celle nécessaire pour la surcharge, consommez de l'arithmétique supplémentaire pour déclencher l'effet suivant."
  },
  State_96743_Name = {
    Text = "<CardKeyWord:Surcharge arithmétique>"
  },
  State_96744_Desc = {
    Text = "Les dégâts des attaques actives et le nombre de couches de saignement augmentent de 50%, et les dégâts sont retirés au début de chaque ronde."
  },
  State_96744_Name = {Text = "Faille"},
  State_96774_Desc = {
    Text = "Chaque fois que vous subissez des dégâts critiques, obtenez 3 % de résistance aux critiques temporaires."
  },
  State_96774_Name = {
    Text = "Esprit vengeur des fonds marins"
  },
  State_96780_Desc = {
    Text = "La carte conserve son utilité, mais lorsqu'elle est jouée ou défaussée, elle va enlever la pollution et invoquer 1 \"Aequor Spawn\", jusqu'à 2. S'il n'y a pas de place pour invoquer, elle accordera immédiatement au marionnettiste de putréfaction [DescArg1] force et [DescArg2] hp."
  },
  State_96780_Name = {
    Text = "<Kuangluan:Marin enragé>"
  },
  State_96783_Desc = {
    Text = "Chaque tour, ajoutez « <Kuangluan:Frénésie du Marcheur des mers> » à 2 cartes."
  },
  State_96783_Name = {
    Text = "Rituel du Marcheur des mers"
  },
  State_96784_Desc = {
    Text = "Permet de réduire les attaques de la Marionnette de la marée pourrie, jusqu'à un maximum de 5 couches."
  },
  State_96784_Name = {Text = "Chaos"},
  State_96808_Desc = {
    Text = "Pour chaque [DescArg1] point(s) de vie perdu(s), gagnez 15 couches de « <ReinforcePVEKeywords:forteresse> », jusqu'à un maximum de 75 couches. Après avoir été brisé, videz et gagnez 1 couche de « <Chaos:chaos> ». Si « Recomposition d'Os et de Sang » n'a jamais été libéré, après avoir subi des dégâts mortels, changez l'intention en « Recomposition d'Os et de Sang » et immunisez-vous contre tous les dégâts."
  },
  State_96808_Name = {
    Text = "«Marionnette chimérique»"
  },
  State_96809_Name = {
    Text = "Compteur de la Marionnette chimérique"
  },
  State_96810_Desc = {
    Text = "Les dégâts infligés sont réduits de 25 %."
  },
  State_96810_Name = {
    Text = "Véil des Rêves Obscurs"
  },
  State_96813_Name = {
    Text = "Réorganiser la notation"
  },
  State_97114_Desc = {
    Text = "<PVPWeaponKeywords:roue du destin> : « frappe » gagne [StateArg1] Arithmétique, dégâts de « compétence » +[StateArg2] %."
  },
  State_97114_Name = {
    Text = "Soleil Imminent"
  },
  State_97118_Name = {
    Text = "Coup de la Marionnette chimérique"
  },
  State_97119_Desc = {
    Text = "La carte conserve son utilité, mais lorsqu'elle est jouée ou défaussée, elle va enlever la pollution et invoquer 1 \"Aequor Spawn\", jusqu'à 2. S'il n'y a pas de place pour invoquer, elle accordera immédiatement au marionnettiste de putréfaction [DescArg1] force et [DescArg2] hp."
  },
  State_97119_Name = {
    Text = "<Kuangluan:Marin enragé>"
  },
  State_97120_Desc = {
    Text = "Protégé par un cercle magique, tous les dégâts infligés par les ennemis sont réduits de 25 %."
  },
  State_97120_Name = {
    Text = "Véil des Rêves Obscurs"
  },
  State_97131_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Pour chaque 1 Arithmetica consommée par une «compétence», les Dommages augmentent de [StateArg1]%. Après une Élimination, les Dommages de «Exaltation» augmentent de [StateArg2]%, bonus actuel : [DescArg1]%."
  },
  State_97131_Name = {Text = "Mort ambre"},
  State_97134_Desc = {
    Text = "Les dégâts finaux infligés augmentent de 50 %."
  },
  State_97134_Name = {
    Text = "Chant de Séléné"
  },
  State_97135_Desc = {
    Text = "Les dégâts finaux infligés augmentent de 25 %."
  },
  State_97135_Name = {
    Text = "Murmures de Séléné"
  },
  State_97136_Desc = {
    Text = "Les dégâts finaux infligés sont augmentés de 100 %."
  },
  State_97136_Name = {
    Text = "Chant de Séléné"
  },
  State_97137_Desc = {
    Text = "Défaussez pour le faire revenir en main."
  },
  State_97137_Name = {
    Text = "Défaussez pour le faire revenir en main"
  },
  State_97137_WeaponDesc = {
    Text = "Lorsque vous le piochez, vous êtes affaibli pendant 1 tour. Après usage, affaiblissez tous les ennemis pendant 1 tour. Ne peut pas être vendu"
  },
  State_97219_Desc = {
    Text = "Les <plural value=\"[Layer]\" singular=\"prochaine carte que\" plural=\"prochaines cartes que\"> Wanda joue prennent effet 1 fois supplémentaire."
  },
  State_97219_Name = {
    Text = "Reine des Épines"
  },
  State_97251_Desc = {
    Text = ": Ne peut pas être priorisé ou sélectionné comme cible unique. Les adversaires ne peuvent pas choisir le Réveiller en Furtivité lors de la sélection de cibles uniques.\nLorsqu'il obtient la Furtivité, il enlève son propre Taunt et la Furtivité des autres alliés. S'il n'y a pas d'autres alliés ou si un ennemi obtient un Taunt, enlève la Furtivité."
  },
  State_97251_Name = {
    Text = "Infiltration"
  },
  State_97252_Desc = {
    Text = ": Ne peut pas être priorisé ou sélectionné comme cible unique. Les adversaires ne peuvent pas choisir le Réveiller en Furtivité lors de la sélection de cibles uniques.\nLorsqu'il obtient la Furtivité, il enlève son propre Taunt et la Furtivité des autres alliés. S'il n'y a pas d'autres alliés ou si un ennemi obtient un Taunt, enlève la Furtivité."
  },
  State_97252_Name = {
    Text = "<PVPSneakKeywords:Infiltration>"
  },
  State_97339_Name = {
    Text = "Couve Missaga de la victoire"
  },
  State_97742_Desc = {
    Text = "Chaque fois que des Dégâts Directs sont subis, inflige [Layer] <FixedDamage:DGT Purs> à la source des dégâts."
  },
  State_97742_Name = {
    Text = "Contre-attaque"
  },
  State_97743_Desc = {
    Text = "Augmentez les dégâts actifs de [Layer] points"
  },
  State_97743_Name = {
    Text = "<PowerColourKeywords:Puissance>"
  },
  State_97744_Desc = {
    Text = "Dégâts subis -[Layer]%."
  },
  State_97744_Name = {
    Text = "<ReinforceColour:renforcé>"
  },
  State_97744_WeaponDesc = {
    Text = "Tous les dégâts infligés sont réduits de [DescArg1] %"
  },
  State_97938_Desc = {
    Text = "Dégâts finaux augmentés de [DescArg1] %."
  },
  State_97938_Name = {
    Text = "Couve Missaga de la victoire"
  },
  State_97939_Desc = {
    Text = "Les dégâts finaux infligés augmentent de 50 %."
  },
  State_97939_Name = {
    Text = "Couve d'or de Missaga"
  },
  State_97941_Desc = {
    Text = "Dégâts de base augmentés de 100 %."
  },
  State_97941_Name = {
    Text = "Couve Missaga de la victoire"
  },
  State_97942_Desc = {
    Text = "Lors de la libération de l'exaltation de la folie, obtenez 35 points de folie."
  },
  State_97942_Name = {
    Text = "Couve Missaga de la victoire"
  },
  State_97943_Name = {
    Text = "Compteur de conservation de la puissance arithmétique"
  },
  State_98055_Desc = {
    Text = "À la fin du tour, générer 1 tentacule. Retirer cet état après le réveil"
  },
  State_98055_Name = {Text = "Sommeil"},
  State_98060_Desc = {
    Text = "Cet éveilleur n'est pas encore éveillé... Il s'éveillera lorsqu'il sera sur le point d'être abattu, restaurera sa vie et commencera à se battre sous sa véritable forme"
  },
  State_98060_Name = {
    Text = "Non Réveillé"
  },
  State_98068_Desc = {
    Text = "Lorsque vous avez 10 couches de « Flammes explosives », obtenez 2 points d'arithmétique et transformez toutes les « Flares gigas » en « Flares téra »."
  },
  State_98068_Name = {
    Text = "<BaoyanKeywords:Flamme explosive>"
  },
  State_98139_Desc = {
    Text = "Au début du tour de l'adversaire, appliquez aléatoirement <BurningKeywords:Brûler> à 1 carte en main."
  },
  State_98139_Name = {
    Text = "État@Monstre Katigora - Identifiant d'éveil"
  },
  State_98140_Desc = {
    Text = "Après avoir accumulé 10 couches de <MonsterExFlameKeywords:Flamme explosive>, changez l'intention en « Brillant Éblouissant » de très gros dommages !"
  },
  State_98140_Name = {
    Text = "<BurningColor:Flamme explosive>"
  },
  State_98147_Desc = {
    Text = "Lorsque l'ennemi joue des cartes <BurningKeywords:Brûlure>, accordez-vous 1 pile de <MonsterExFlameKeywords:Combustion>, mais réduisez temporairement [DescArg1] <PowerIconKeywords:FOR>."
  },
  State_98147_Name = {
    Text = "État @monstre Katigora @écoute combustion"
  },
  State_98148_Desc = {
    Text = "Cette personne Éveilleur n'est pas encore éveillé... Il s'éveillera lorsqu'il sera sur le point d'être abattu, abandonnera toutes les cartes restantes et accordera<BurningKeywords:Brûler>, régénérera PV et commencera à se battre sous sa véritable forme."
  },
  State_98148_Name = {
    Text = "Non Réveillé"
  },
  State_98302_Desc = {
    Text = "Équipe unique : Les dégâts de base infligés par l'équipé augmentent de <WeaponEffect_Num:[StateArg1]%>, et la puissance générée augmente de <WeaponEffect_Num:[StateArg2]%>. Après avoir joué une carte de commandement de l'équipé, obtenez une puissance temporaire égale à <WeaponEffect_Num:[StateArg3]%> de l'attaque de l'équipé. Cet effet peut se déclencher jusqu'à 5 fois par tour."
  },
  State_98302_WeaponDesc = {
    Text = "Les dégâts de base infligés par l'équipement augmentent de <WeaponEffect_Num:[StateArg1]%>, et la puissance générée augmente de <WeaponEffect_Num:[StateArg2]%>. Après avoir joué une carte de commande de l'équipement, obtenez <WeaponEffect_Num:[Power:DescArg1]> points de <PowerIconKeywords:force> temporaire, déclenchable jusqu'à 5 fois par tour (déclenché [DescArg2]/5 fois actuellement)."
  },
  State_98323_Desc = {
    Text = "La carte reviendra dans la main après avoir été défaussée"
  },
  State_98323_Name = {
    Text = "Défaussez pour le faire revenir en main"
  },
  State_98341_Desc = {
    Text = "Peut être mélangé avec d'autres couleurs primaires pour former une nouvelle couleur."
  },
  State_98341_Name = {
    Text = "<Yellow:Primaires - Jaune>"
  },
  State_98344_Desc = {
    Text = "Peut être mélangé avec d'autres couleurs primaires pour former une nouvelle couleur."
  },
  State_98344_Name = {
    Text = "<Red:Couleur primaire - Rouge>"
  },
  State_98345_Desc = {
    Text = "Peut être mélangé avec d'autres couleurs primaires pour former une nouvelle couleur."
  },
  State_98345_Name = {
    Text = "<Blue:Bleu originel>"
  },
  State_98366_Desc = {
    Text = "Au début du tour, si l'énergie en clé d'argent est supérieure à [Arg1], consommez [Arg1] points d'énergie en clé d'argent pour placer 1 carte <DerivativeCardKeywords_115:« Inspiration supérieure »> dans votre main."
  },
  State_98435_Desc = {
    Text = "Provenant du mélange de rouge et de bleu, obtenez <Block:[DescArg1]> points de bouclier en infligeant 1 dégât actif."
  },
  State_98435_Name = {
    Text = "<PurpleKeyWord:Imagerie·Violet>"
  },
  State_98436_Desc = {
    Text = "Dérivé d'un mélange de rouge et de jaune, après avoir libéré l'exaltation de la folie, le réveilleur correspondant obtient <Energy:15> points de folie."
  },
  State_98436_Name = {
    Text = "<ExclamationPointColour:Vision·Orange>"
  },
  State_98437_Desc = {
    Text = "Les dégâts finaux infligés augmentent de 10 %."
  },
  State_98437_Name = {
    Text = "<Red:Couleur primaire - Rouge>"
  },
  State_98438_Desc = {
    Text = "Issu d'un mélange de jaune et de bleu, lorsque vous jouez « défense », récupérez <Heal:[DescArg1]> points de vie."
  },
  State_98438_Name = {
    Text = "<GreenWord:Phénomène·Vert>"
  },
  State_98439_Desc = {
    Text = "Issu d'un mélange de jaune et de bleu, lorsque vous jouez « défense », récupérez <Heal:[DescArg1]> points de vie."
  },
  State_98439_Name = {
    Text = "<GreenWord:Phénomène vert>"
  },
  State_98440_Desc = {
    Text = "Créé par un mélange de rouge et de bleu, obtenez <Block:[DescArg1]> points de bouclier en infligeant 1 dégât actif."
  },
  State_98440_Name = {
    Text = "<PurpleKeyWord:Illusion·Violet>"
  },
  State_98441_Desc = {
    Text = "Dérivé d'un mélange de rouge et de jaune, après avoir libéré l'exaltation de la folie, le réveilleur correspondant obtient <Energy:15> points de folie."
  },
  State_98441_Name = {
    Text = "<ExclamationPointColour:Vision·Orange>"
  },
  State_98444_Desc = {
    Text = "Équipe unique : Les dégâts de base infligés par l'équipementeur augmentent de <WeaponEffect_Num:[StateArg1]%>. Après avoir joué 5 cartes de commandement de l'équipement, l'équipementeur obtient <WeaponEffect_Num:[StateArg2]%> de taux critique. Cet effet ne peut se déclencher qu'une seule fois par tour."
  },
  State_98444_WeaponDesc = {
    Text = "Les dégâts de base causés par l'équipementeur augmentent de <WeaponEffect_Num:[StateArg1]%>. Après avoir joué 5 cartes de commande de l'équipement, l'équipementeur obtient <WeaponEffect_Num:[StateArg2]%> de taux critique. Cet effet ne peut être déclenché qu'une seule fois par tour (vous avez déjà joué [DescArg1]/5 cartes pour l'instant)."
  },
  State_98466_Name = {
    Text = "<HuoyanKeywords1:Flamme vive1>"
  },
  State_98468_Name = {
    Text = "<HuoyanKeywords3:Flamme vive 3>"
  },
  State_98470_Name = {
    Text = "<HuoyanKeywords2:Flamme vive 2>"
  },
  State_98474_Desc = {
    Text = "Couleurs primaires qui, mélangées, permettent de créer d'autres couleurs ; elles sont composées du rouge, du jaune et du bleu."
  },
  State_98474_Name = {Text = "Bleu"},
  State_98484_Name = {
    Text = "Mer des Souffrances Éternelles"
  },
  State_98485_Desc = {
    Text = "Les Dégâts Finaux et la Force accordés par cette carte +[DescArg1] % ; Bouclier du personnage et Aliemus +[DescArg2] %. Obtenez « Garder ». Après avoir joué cette carte, consommez toutes les charges de « Flamme vivante » et transmettez 1 charge de « Flamme vivante » à une autre Carte d'instruction de Kadigula en main."
  },
  State_98485_Name = {
    Text = "<HuoyanKeywords2:Flamme vive 2>"
  },
  State_98486_Desc = {
    Text = "Les Dégâts Finaux et la Force accordés par cette carte +[DescArg1] % ; Bouclier du personnage et Aliemus +[DescArg2] %. Obtenez « Garder ». Après avoir joué cette carte, consommez toutes les charges de « Flamme vivante » et transmettez 1 charge de « Flamme vivante » à une autre Carte d'instruction de Kadigula en main."
  },
  State_98486_Name = {
    Text = "<HuoyanKeywords3:Flamme vive III>"
  },
  State_98487_Desc = {
    Text = "Les Dégâts Finaux et la Force accordés par cette carte +[DescArg1] % ; Bouclier du personnage et Aliemus +[DescArg2] %. Obtenez « Garder ». Après avoir joué cette carte, consommez toutes les charges de « Flamme vivante » et transmettez 1 charge de « Flamme vivante » à une autre Carte d'instruction de Kadigula en main."
  },
  State_98487_Name = {
    Text = "<HuoyanKeywords1:Flamme vive>"
  },
  State_98488_Desc = {
    Text = "Chaque niveau de « Flamme vivante » augmente de 30 % les dégâts finaux, les boucliers, la folie et la force générés par les cartes, cumulable jusqu'à un maximum de 3 niveaux. Les cartes possédant une « Flamme vivante » reçoivent l'état « Retenu ». Lorsqu'elles sont jouées, elles consomment toutes les « Flammes vivantes » et transmettent 1 niveau de « Flamme vivante » à une autre carte de commandement de Kedigora présente en main."
  },
  State_98488_Name = {
    Text = "<HuoyanKeywords:Flamme vive>"
  },
  State_98492_Desc = {
    Text = "Au début de l'exploration, augmenter la Constitution, l'Attaque et la Défense de [StateArg1] %"
  },
  State_98492_Name = {
    Text = "Aptitude Forge de l'Âme"
  },
  State_98495_Desc = {
    Text = "Au début de l'exploration, la constitution, l'attaque et la défense augmentent de [StateArg1] %"
  },
  State_98495_Name = {
    Text = "Aptitude Forge de l'Âme"
  },
  State_98507_Desc = {
    Text = "Au début de l'exploration, augmenter la Constitution, l'Attaque et la Défense de [StateArg1] %"
  },
  State_98507_Name = {
    Text = "Aptitude Forge de l'Âme"
  },
  State_98511_Name = {
    Text = "Obtenir une carte dérivée"
  },
  State_98551_Desc = {
    Text = "Au début de la bataille, la maîtrise du domaine augmente de [Arg1]. Au début des tours impairs, piochez 1 carte ; au début des tours pairs, obtenez 1 point d'arithmétique."
  },
  State_98553_Desc = {
    Text = "Chaque fois qu'un « embryon » est généré, obtenez [Arg1] points de fournaise cramoisie, avec un maximum de 3 déclenchements par tour."
  },
  State_98555_Desc = {
    Text = "Au début du combat, obtenez [Arg1]% d'efficacité accrue. Après la première application de poison du tour, piochez [Arg2] cartes."
  },
  State_98556_Desc = {
    Text = "Tous les éveillés voient leurs effets de régénération de vie et de bouclier augmenter de [Arg1] %."
  },
  State_98557_Desc = {
    Text = "Chaque fois qu'un « embryon » est généré, obtenez [Arg1] points de fournaise cramoisie, avec un maximum de 3 déclenchements par tour."
  },
  State_98559_Desc = {
    Text = "Chaque fois que vous piochez ou défaussez une carte, obtenez [Arg1] force temporaire, jusqu'à un maximum de [Arg2] forces temporaires."
  },
  State_98560_Desc = {
    Text = "Tous les réveilleurs voient leurs dégâts de base augmenter de [Arg1] %. Avant de libérer l'exaltation, le réveilleur qui utilise l'exaltation voit temporairement ses dégâts de base augmenter de [Arg2] %."
  },
  State_98561_Desc = {
    Text = "Au début du tour, si la vie est inférieure à 50 %, l'amplification temporaire des dégâts augmente de [Arg1] %. Si la vie est inférieure à 25 %, piochez [Arg2] cartes supplémentaires et obtenez [Arg2] points d'arithmétique."
  },
  State_98562_Desc = {
    Text = "Après avoir infligé des dégâts actifs ou des dégâts de tentacule, augmenter de [Arg1] % les dégâts de tentacule subis par la cible pendant ce tour, déclenchable jusqu'à 20 fois par tour."
  },
  State_98563_Desc = {
    Text = "Au début de la bataille, obtenez [Arg1] points de force. Chaque fois que vous jouez une carte « consommable », obtenez [Arg2] points de force temporaire, jusqu'à [Arg3] fois."
  },
  State_98564_Desc = {
    Text = "« Exaltation de la folie » Obtenez [Arg1] points de s-énergie, déclenchable jusqu'à 3 fois par tour."
  },
  State_98565_Desc = {
    Text = "Chaque fois qu'une carte entre dans l'espace dimensionnel, piochez [Arg1] cartes de commandement appartenant à son propriétaire depuis la pile de pioche. Si la pioche est impossible, obtenez une quantité équivalente d'arithmetica à la place. Cet effet ne peut se produire qu'au maximum 2 fois par tour."
  },
  State_98567_Desc = {
    Text = "Avant la fin du tour, chaque éveillé propriétaire d'une carte de commande dans la main gagne [Arg1] point de folie."
  },
  State_98568_Desc = {
    Text = "Au début du combat, obtenez une amplification des dégâts de +[Arg1] %. Après avoir infligé des dégâts actifs, appliquez [Arg2] poison à tous les ennemis, avec un maximum de 5 déclenchements supplémentaires par tour."
  },
  State_98569_Desc = {
    Text = "La première fois que vous utilisez une « clé » à chaque tour, appliquez [Arg1] couches de poison à tous les ennemis et obtenez [Arg2] couches de contre-attaque."
  },
  State_98571_Desc = {
    Text = "Utiliser l'Éveil de la clé d'argent puis récupérer [Arg1] points de vie, obtenir [Arg2] points de s-énergie."
  },
  State_98571_Name = {
    Text = "parasol de voyage"
  },
  State_98572_Desc = {
    Text = "Après la deuxième utilisation de « clé » à chaque tour, obtenez [Arg1] points de s-énergie, tous les réveilleurs reçoivent [Arg2] points de folie."
  },
  State_98575_Desc = {
    Text = "Au début du combat, obtenez une amplification des dégâts de +[Arg1] %. Après avoir infligé des dégâts actifs, appliquez [Arg2] poison à tous les ennemis, avec un maximum de 5 déclenchements supplémentaires par tour."
  },
  State_98576_Desc = {
    Text = "Au début de la bataille, infligez [Arg1] couches de faiblesse et de vulnérabilité à tous les ennemis. Cet effet est également déclenché après « l'anéantissement », mais avec un temps de recharge de 3 tours."
  },
  State_98577_Desc = {
    Text = "Tous les réveilleurs voient leurs dégâts de base augmenter de [Arg1] %. Avant de libérer l'exaltation, le réveilleur qui l'active voit temporairement ses dégâts de base augmenter de [Arg2] %."
  },
  State_98579_Desc = {
    Text = "Au début du tour, si la vie est inférieure à 50 %, l'amplification temporaire des dégâts augmente de [Arg1] %. Si la vie est inférieure à 25 %, piochez [Arg2] cartes supplémentaires et obtenez [Arg2] points d'arithmetica."
  },
  State_98581_Desc = {
    Text = "Tous les réveilleurs obtiennent [Arg1] points de s-énergie lorsqu'ils utilisent une « carte de commandement » pour la première fois chaque tour."
  },
  State_98582_Desc = {
    Text = "Après avoir relâché \"exalt\" 5 fois, les prochaines [Arg1] cartes de commande non-dérivatives prennent effet 1 fois supplémentaire."
  },
  State_98583_Desc = {
    Text = "Tous les réveilleurs obtiennent [Arg1] points de s-énergie lorsqu'ils utilisent une « carte de commande » pour la première fois chaque tour."
  },
  State_98586_Desc = {
    Text = "Au début du tour, tous les éveillés dont la folie est insuffisante pour utiliser l'exaltation gagnent [Arg1] points de folie."
  },
  State_98587_Desc = {
    Text = "Chaque fois que vous piochez ou défaussez une carte, obtenez [Arg1] force temporaire, maximum [Arg2] forces temporaires."
  },
  State_98588_Desc = {
    Text = "Avant la fin du tour, chaque éveillé possédant une carte de commande dans sa main gagne [Arg1] point de folie."
  },
  State_98589_Desc = {
    Text = "Au début de la bataille, fait perdre [Arg1] points de force temporaire à tous les ennemis. Utiliser « Fournaise cramoisie » déclenche également cet effet, mais avec un temps de recharge de 3 tours."
  },
  State_98590_Desc = {
    Text = "Au début du combat, obtenez [Arg1]% d'efficacité accrue. Après la première application de poison pendant le tour, piochez [Arg2] cartes."
  },
  State_98591_Desc = {
    Text = "La première fois que vous utilisez une « clé » à chaque tour, appliquez [Arg1] couches de poison à tous les ennemis et obtenez [Arg2] couches de contre-attaque."
  },
  State_98596_Desc = {
    Text = "La première fois que vous utilisez une « clé » à chaque tour, vous récupérez [Arg1]% de l'énergie en s-argent dépensée."
  },
  State_98597_Desc = {
    Text = "Utilisez l'Éveil de la clé d'argent puis récupérez [Arg1] vie, obtenez [Arg2] points de s-énergie."
  },
  State_98597_Name = {
    Text = "parasol de voyage+"
  },
  State_98598_Desc = {
    Text = "Au début de la bataille, obtenez [Arg1] point de force. Pour chaque carte « consommable » jouée, obtenez [Arg2] points de force temporaire, jusqu'à [Arg3] fois."
  },
  State_98600_Desc = {
    Text = "Au début du combat, fait perdre à tous les ennemis [Arg1] points de force temporaire. Utiliser la « fournaise cramoisie » déclenche également cet effet, mais avec un temps de recharge de 3 tours."
  },
  State_98602_Desc = {
    Text = "Au début de la bataille, obtenez [Arg1] % d'amplification des dégâts. Lors du premier contre-coup de chaque tour, gagnez 1/2 arithmétique."
  },
  State_98603_Desc = {
    Text = "Au début du combat, gagne Amplification de Dégâts +[Arg1]%. Après avoir subi des Dégâts Actifs ou des Dégâts des tentacules, gagne [Arg2] Contre-attaque, jusqu'à 3 fois par tour."
  },
  State_98604_Desc = {
    Text = "Au début du combat, gagne Amplification de Dégâts +[Arg1]%. Après avoir subi des Dégâts Actifs ou des Dégâts des tentacules, gagne [Arg2] Contre-attaque, jusqu'à 3 fois par tour."
  },
  State_98606_Desc = {
    Text = "Chaque fois qu'une carte entre dans l'espace dimensionnel, piochez [Arg1] carte(s) de commandement appartenant à son propriétaire depuis la pile de pioche. Si vous ne pouvez pas les piocher, obtenez une quantité équivalente d'arithmetica à la place. Cet effet ne peut se produire qu'au maximum 2 fois par tour."
  },
  State_98607_Desc = {
    Text = "La première fois que vous utilisez une « clé » à chaque tour, activez tous les tentacules pour attaquer [Arg1] fois les ennemis, infligeant 50 % de dégâts."
  },
  State_98608_Desc = {
    Text = "Au début de la bataille, obtenez [Arg1] % de puissance de dégâts. Chaque fois que vous jouez une carte de commandement d'un réveilleur différent, obtenez en plus 15/30 % de puissance temporaire de dégâts."
  },
  State_98610_Desc = {
    Text = "Utilisez l'Éveil de la clé d'argent pour que les 2/4 cartes de votre main ayant le coût en arithmetica le plus élevé obtiennent Retenue et Prêt avant d'être jouées. Obtenez 100/200 points de s-énergie."
  },
  State_98611_Desc = {
    Text = "Au début de la bataille, la maîtrise du domaine augmente de [Arg1]. Au début des tours impairs, piochez 1 carte ; au début des tours pairs, obtenez 1 point d'arithmétique."
  },
  State_98612_Desc = {
    Text = "La première fois que vous utilisez une « clé » à chaque tour, la puissance temporaire des dégâts augmente de [Arg1] %, l'effet étant d'autant plus fort que la vie est basse."
  },
  State_98613_Desc = {
    Text = "Au début de la bataille, obtenez [Arg1]% d'amplification des dégâts. Chaque fois que vous jouez une carte de commandement d'un réveilleur différent, obtenez en plus 15/30 % d'amplification des dégâts temporaires."
  },
  State_98614_Desc = {
    Text = "Après avoir relâché \"exalt\" 5 fois, les prochaines [Arg1] cartes de commande non-dérivatives prennent effet 1 fois supplémentaire."
  },
  State_98615_Desc = {
    Text = "La première fois que vous utilisez une « clé » à chaque tour, récupérez [Arg1]% de l'énergie en clé en argent dépensée."
  },
  State_98616_Desc = {
    Text = "Tous les éveillés voient leurs effets de régénération de vie et de bouclier augmenter de [Arg1] %."
  },
  State_98617_Desc = {
    Text = "Après avoir infligé des dégâts actifs ou des dégâts de tentacule, augmenter les dégâts de tentacule subis par la cible pendant ce tour de [Arg1] %, déclenchable jusqu'à 20 fois par tour."
  },
  State_98619_Desc = {
    Text = "À la fin du tour, si votre énergie de clé en argent est pleine, consommez [Arg1] points d'énergie de clé en argent pour ajouter une carte « Lueur de la clé d'argent » à votre main."
  },
  State_98621_Desc = {
    Text = "À la fin du tour, si l'énergie en clé d'argent est pleine, consommez [Arg1] points d'énergie en clé d'argent pour ajouter une carte « Clé d'Aube Argentée » à votre main."
  },
  State_98623_Desc = {
    Text = "Au début du tour, tous les éveillés n'ayant pas assez de folie pour déclencher l'exaltation de la folie reçoivent [Arg1] points de folie."
  },
  State_98624_Desc = {
    Text = "Au début du combat et après avoir déclenché la résistance à la mort, obtenez [Arg1] points de s-énergie."
  },
  State_98625_Desc = {
    Text = "Au début du combat, infligez [Arg1] couches de faiblesse et de vulnérabilité à tous les ennemis. Cet effet est également déclenché après « l'anéantissement », mais avec un temps de recharge de 3 tours."
  },
  State_98626_Desc = {
    Text = "La première fois que vous utilisez une « clé » à chaque tour, la puissance temporaire des dégâts augmente de [Arg1] %, l'effet est d'autant plus fort que la vie est basse."
  },
  State_98627_Desc = {
    Text = "« Exaltation de la folie » Obtenez [Arg1] points de s-énergie, déclenche maximum 3 fois par tour."
  },
  State_98628_Desc = {
    Text = "La première fois que vous utilisez une « clé » à chaque tour, activez tous les tentacules pour attaquer [Arg1] fois les ennemis, infligeant 50 % de dégâts."
  },
  State_98629_Desc = {
    Text = "Après la deuxième utilisation de « clé » à chaque tour, obtenez [Arg1] points de s-énergie et tous les réveilleurs reçoivent [Arg2] points de folie."
  },
  State_98630_Desc = {
    Text = "Au début du combat et après avoir déclenché la résistance à la mort, obtenez [Arg1] points de s-énergie."
  },
  State_98632_Desc = {
    Text = "Au début de la bataille, obtenez [Arg1] % d'amplification des dégâts. Lors du premier contre-attaque du tour, gagnez 1/2 point d'arithmétique."
  },
  State_98686_Desc = {
    Text = "La prochaine [Layer] carte de commandement non dérivée prendra effet une fois supplémentaire."
  },
  State_98686_Name = {
    Text = "Carte de commandement non dérivée - Tir double"
  },
  State_98739_Desc = {
    Text = "Lorsque l'intention est convertie en « tourbillon pâle », augmente le nombre d'attaques d'une quantité équivalente au nombre de couches d'état, puis vide l'état à la fin du tour. Dès que le nombre de couches atteint 3, convertit immédiatement l'intention en « tourbillon pâle »."
  },
  State_98739_Name = {
    Text = "Baiser de la Femme-araignée"
  },
  State_98742_Desc = {
    Text = "Le poison appliqué est augmenté de 100 %, et à la fin de chaque tour, gagnez <Block:[Block:DescArg1]> points de bouclier."
  },
  State_98742_Name = {
    Text = "Voyage égaré"
  },
  State_98743_Desc = {
    Text = "Après avoir subi [DescArg1] points de dégâts pendant le tour, obtenez 75 couches de renforcement temporaire, transformez l'intention en « aumône impatiente », annulez l'effet de pétrification et obtenez 1 couche de « baiser de l'araignée »."
  },
  State_98743_Name = {
    Text = "Transgresseur"
  },
  State_98752_Desc = {
    Text = "Enflamme la carte, subit 5% des points de vie max après l'avoir jouée, la consomme si elle est encore en main à la fin du tour."
  },
  State_98752_Name = {
    Text = "<BurningKeywords2:Brûler>"
  },
  State_98752_WeaponDesc = {
    Text = "Chaque niveau de ralentissement augmente la consommation en arithmetica des cartes de 1 point"
  },
  State_98887_Name = {
    Text = "âme artificielle"
  },
  State_98889_Desc = {
    Text = "Lors de la première utilisation d'une carte de commande dérivée ou d'une carte de gain avec <DepleteIconKeywords:épuiser> chaque tour, mettez-la dans la pile de défausse."
  },
  State_98889_Name = {
    Text = "âme artificielle"
  },
  State_98912_Desc = {
    Text = "Chaque couche réduit les dégâts finaux infligés par tous les éveillés de 20 %."
  },
  State_98912_Name = {
    Text = "<LostWay:Perdu>"
  },
  State_98913_Desc = {
    Text = "Chaque couche réduit de 20 % les dégâts finaux infligés par tous les éveillés."
  },
  State_98913_Name = {Text = "perdu"},
  State_99007_Desc = {
    Text = "Après avoir joué, elle ne sera pas mise dans la défausse, mais retirée de la pioche"
  },
  State_99007_Name = {
    Text = "<DepleteIconKeywords:Consommation>"
  },
  State_99007_WeaponDesc = {
    Text = "Après avoir joué, la carte ne sera pas mise dans la défausse et ne pourra pas être utilisée à nouveau dans ce combat"
  },
  State_99053_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Après que les autres alliés « Exalter » piochez [StateArg1] cartes."
  },
  State_99053_Name = {
    Text = "Pinceau de désir"
  },
  State_99055_Desc = {
    Text = "<PVPWeaponKeywords:Roue du Destin> : Après « Exaltation », placez au hasard [StateArg1] « Compétences » du Porteur dans la Main et réduisez leur Coût d'Arithmetica à 0."
  },
  State_99055_Name = {
    Text = "paradoxe du réalisme"
  },
  State_99056_Desc = {
    Text = "Équipe unique : après avoir libéré la clé, le taux critique du porteur augmente temporairement de <WeaponEffect_Num:[StateArg1]%>."
  },
  State_99056_WeaponDesc = {
    Text = "Après avoir libéré la clé, le taux critique de l'équipement est temporairement augmenté de <WeaponEffect_Num:[StateArg1]%>."
  },
  State_99134_Desc = {
    Text = "Les teintures utilisées par le « peintre » pour peindre renforcent les effets des compétences. Après avoir joué une carte « <ColorInkKeywords:encre colorée> » ou « <ErosionColorInkKeywords:encre de dissolution> », elle obtient 1 couche, avec un maximum de 10 couches."
  },
  State_99134_Name = {
    Text = "Teinture du monde illusoire"
  },
  State_99237_Name = {
    Text = "État de l'accessoire de vol"
  },
  State_99237_WeaponDesc = {
    Text = "L'attaquant augmente les dégâts de base de 10%. Si les dégâts puissants de l'attaquant dépassent 20%, les dégâts de base augmentent encore de 10%"
  },
  State_99238_Name = {
    Text = "État de l'accessoire d'humus"
  },
  State_99238_WeaponDesc = {
    Text = "L'attaquant augmente les dégâts de base de 10%. Si les dégâts puissants de l'attaquant dépassent 20%, les dégâts de base augmentent encore de 10%"
  },
  State_99239_Name = {
    Text = "État de l'accessoire Styx"
  },
  State_99239_WeaponDesc = {
    Text = "L'attaquant augmente les dégâts de base de 10%. Si les dégâts puissants de l'attaquant dépassent 20%, les dégâts de base augmentent encore de 10%"
  },
  State_99258_Desc = {
    Text = "Unique à l'équipe : après avoir libéré la deuxième clé à chaque tour, il y a une probabilité de <WeaponEffect_Num:[StateArg1]%> de piocher 1 carte de commande de l'équipementeur. Après avoir joué la troisième carte de commande de l'équipementeur à chaque tour, obtenez <WeaponEffect_Num:[StateArg2]> points de s-énergie."
  },
  State_99258_WeaponDesc = {
    Text = "Après avoir libéré la deuxième clé à chaque tour, il y a une probabilité de <WeaponEffect_Num:[StateArg1]%> de piocher 1 carte de commande de l'équipementeur. Après avoir joué la troisième carte de commande de l'équipementeur à chaque tour, obtenez <WeaponEffect_Num:[StateArg2]> points de s-énergie."
  },
  State_99294_Desc = {
    Text = "La folie causée par tous les réveilleurs augmente de [DescArg1]%. La capacité d'arithmétique et les cartes de commandement à la fin du tour peuvent être conservées jusqu'au prochain tour. La folie du « Écrits flamboyants » augmente."
  },
  State_99294_Name = {Text = "« Joie »"},
  State_99295_Desc = {
    Text = "L'Aliemus généré par tous les Réveilleurs augmente de [StateArg1]%, et les Cartes Arithmetica et de Commandement peuvent être reportées au tour suivant. L'Aliemus du Splendid Chapter augmente également."
  },
  State_99295_Name = {Text = "« Joie »"},
  State_99336_Desc = {
    Text = "La « peinture » utilisée par le « dessinateur » pour peindre, qui peut renforcer l'effet des compétences. Après avoir joué une carte « <ColorInkKeywords:encre colorée> » ou « <ErosionColorInkKeywords:encre de dissolution> », elle obtient 1 couche, avec un maximum de 10 couches."
  },
  State_99336_Name = {
    Text = "<DecayDye:Teinture du monde illusoire>"
  },
  State_99533_Name = {
    Text = "Chrysalide de la jeune fille de l'accessoire"
  },
  State_99533_WeaponDesc = {
    Text = "Après le début du combat, si la classe du porteur est chaos, l'attaque augmente de 25 %"
  },
  State_99534_Name = {Text = "Slime Doux"},
  State_99534_WeaponDesc = {
    Text = "Les boucliers et la régénération de vie infligés par le porteur augmentent de 6%. Si la maîtrise du domaine du porteur dépasse 50, les boucliers et la régénération de vie augmentent de 6% supplémentaires"
  },
  State_99640_Desc = {
    Text = "Si vous avez actuellement 10 niveaux de créativité, après que Pickman libère l'exaltation de la folie en dépensant toutes les créations, tous les éveillés obtiennent 15 points de folie et gagnent 1 niveau de « folie ». La limite de créativité est de 10 niveaux, pouvant être transférée au prochain combat."
  },
  State_99640_Name = {
    Text = "Créativité"
  },
  State_99723_Desc = {
    Text = "Équipe unique : la folie et la force infligées par l'équipement augmentent de <WeaponEffect_Num:[StateArg1] %>. Après avoir libéré l'exaltation de la folie, les dégâts finaux de l'exaltation de folie des autres éveillés, le bouclier et la récupération de vie de ce tour augmentent de <WeaponEffect_Num:[StateArg2] %>. Si cette exaltation de folie déclenche « dévorer », l'équipement reçoit <WeaponEffect_Num:[StateArg3]> points de folie."
  },
  State_99723_WeaponDesc = {
    Text = "La folie et la force causées par l'équipement augmentent de <WeaponEffect_Num:[StateArg1]%>. Après avoir libéré l'exaltation, les dégâts finaux de la prochaine exaltation des autres éveillés dans ce tour, ainsi que le bouclier et la régénération de vie, augmentent de <WeaponEffect_Num:[StateArg2]%>. Si cette exaltation déclenche « dévorer », le porteur obtient <WeaponEffect_Num:[StateArg3]> points de folie."
  }
})
return Text_State
