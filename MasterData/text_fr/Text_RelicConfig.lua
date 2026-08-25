__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_RelicConfig = readonly({
  RelicConfig_100300_BattleDesc = {
    Text = "Après le début du combat, obtenez 3 couches de « <MindWall:barrière mentale> » et 1 couche de « <TrueConfess:confession> ». Après avoir déclenché 3 fois « <MindWall:barrière mentale> », obtenez 1 couche de « <BarrierCrash:écroulement de barrière> ». Après avoir libéré l'exaltation, changez « <TrueConfess:confession> » en « <ShadowSelf:ombre de la personnalité> »."
  },
  RelicConfig_100300_Desc = {
    Text = "Après le début de la bataille, obtenez 3 couches de « <MindWall:barrière mentale> » et 1 couche de « <TrueConfess:confession> ». Après avoir déclenché 3 fois « <MindWall:barrière mentale> », obtenez 1 couche de « <BarrierCrash:effondrement de barrière> ». Après avoir libéré l'explosion de folie, changez « <TrueConfess:confession> » en « <ShadowSelf:ombre de personnalité> »."
  },
  RelicConfig_100300_Name = {
    Text = "Analyse de l'esprit"
  },
  RelicConfig_100300_StoryDesc = {
    Text = "Regarde attentivement ton cœur, ne fais pas le mauvais choix."
  },
  RelicConfig_100399_BattleDesc = {
    Text = "Après avoir déclenché l'effet <DevouredIconKeywords:dévoration>, les autres éveillés gagnent [Arg1] points de folie, et ne peuvent être actifs qu'une fois par tour."
  },
  RelicConfig_100399_Desc = {
    Text = "Après avoir déclenché l'effet <DevouredIconKeywords:dévoration>, les autres éveillés gagnent [Arg1] points de folie, et ne peuvent être effectifs qu'une seule fois par tour."
  },
  RelicConfig_100399_Name = {
    Text = "<OrangeQuality:Pays des Rêves Dorés peint+>"
  },
  RelicConfig_100399_StoryDesc = {
    Text = "Le jour de la métamorphose sera ta fin"
  },
  RelicConfig_100400_BattleDesc = {
    Text = "À la fin du tour, récupère [Heal:Arg1] PV."
  },
  RelicConfig_100400_Desc = {
    Text = "À la fin du tour, récupère [Heal:Arg1] PV."
  },
  RelicConfig_100400_Name = {
    Text = "<OrangeQuality:Sang de Grâce peint+>"
  },
  RelicConfig_100400_StoryDesc = {
    Text = "Il est doux et raffiné, avec un parfum de rose"
  },
  RelicConfig_100401_BattleDesc = {
    Text = "Perdez de la vie et obtenez un montant de fournaise cramoisie équivalent à [Arg1]% de la vie perdue."
  },
  RelicConfig_100401_Desc = {
    Text = "Perdez de la vie et obtenez un montant de fournaise écarlate équivalent à [Arg1]% de la vie perdue."
  },
  RelicConfig_100401_Name = {
    Text = "<OrangeQuality:Scie en acier rouillé peinte+>"
  },
  RelicConfig_100401_StoryDesc = {
    Text = "Le médecin de la dissection ne voit jamais de belles femmes, seulement un sac de os, des nerfs enflammés par la maladie, des muscles et des tissus"
  },
  RelicConfig_100402_BattleDesc = {
    Text = "En ramassant, appliquez [Arg1] couches de <VulnerabilityIconKeywords:vulnérable> à tous les ennemis. Tous les éveillés voient leurs dégâts de base augmenter de [Arg2] %."
  },
  RelicConfig_100402_Desc = {
    Text = "En ramassant, appliquez [Arg1] couches de <VulnerabilityIconKeywords:vulnérable> à tous les ennemis. Tous les éveillés voient leurs dégâts de base augmenter de [Arg2] %."
  },
  RelicConfig_100402_Name = {
    Text = "<WhiteQuality:Le Sacrifice du Printemps peint>"
  },
  RelicConfig_100402_StoryDesc = {
    Text = "Dans les rires de la nuit, la silhouette du canoë glisse librement sur le lac"
  },
  RelicConfig_100404_BattleDesc = {
    Text = "Après avoir libéré «Exaltation», gagnez [Arg1] points temporaires de <PowerIconKeywords:Force>."
  },
  RelicConfig_100404_Desc = {
    Text = "Après avoir libéré «Exaltation», gagnez [Arg1] points temporaires de <PowerIconKeywords:Force>."
  },
  RelicConfig_100404_Name = {
    Text = "<WhiteQuality:Verrouillage lourd peint>"
  },
  RelicConfig_100404_StoryDesc = {
    Text = "Un verrou épais et solide, difficile à ouvrir sans clé.\nBien sûr, cela ne pose aucun problème pour un certain voleur"
  },
  RelicConfig_100405_BattleDesc = {
    Text = "En ramassant, appliquez [Arg1] couches de <WeaknessIconKeywords:faiblesse> à tous les ennemis. Tous les éveillés voient leurs dégâts de base augmenter de [Arg2] %."
  },
  RelicConfig_100405_Desc = {
    Text = "En ramassant, appliquez [Arg1] couches de <WeaknessIconKeywords:faiblesse> à tous les ennemis. Tous les éveillés voient leurs dégâts de base augmenter de [Arg2] %."
  },
  RelicConfig_100405_Name = {
    Text = "<WhiteQuality:Môme peint>"
  },
  RelicConfig_100405_StoryDesc = {
    Text = "Né de la pure méchanceté, même si ce n'était pas son souhait"
  },
  RelicConfig_100406_BattleDesc = {
    Text = "Après avoir déclenché l'effet <DevouredIconKeywords:dévoration>, les autres éveillés gagnent [Arg1] points de folie, et ne peuvent être effectifs qu'une seule fois par tour."
  },
  RelicConfig_100406_Desc = {
    Text = "Après avoir déclenché l'effet <DevouredIconKeywords:dévoration>, les autres éveillés gagnent [Arg1] points de folie, et ne peuvent être actifs qu'une fois par tour."
  },
  RelicConfig_100406_Name = {
    Text = "<WhiteQuality:Pays des Rêves Dorés peint>"
  },
  RelicConfig_100406_StoryDesc = {
    Text = "Le jour de la métamorphose sera ta fin"
  },
  RelicConfig_100407_BattleDesc = {
    Text = "Chaque fois que vous infligez des dégâts, obtenez [Arg1] points de <PowerIconKeywords:force> temporaire, jusqu'à 15 fois par tour."
  },
  RelicConfig_100407_Desc = {
    Text = "Chaque fois que vous infligez des dégâts, obtenez [Arg1] points de force temporaire, jusqu'à 15 fois par tour."
  },
  RelicConfig_100407_Name = {
    Text = "<WhiteQuality:Agate Enroulée peinte>"
  },
  RelicConfig_100407_StoryDesc = {
    Text = "Ce ne sont probablement que des motifs d'agate ordinaires. Peut-être"
  },
  RelicConfig_100408_BattleDesc = {
    Text = "Après avoir libéré «Exaltation», gagnez [Arg1] points temporaires de <PowerIconKeywords:Force>."
  },
  RelicConfig_100408_Desc = {
    Text = "Après avoir libéré «Exaltation», gagnez [Arg1] points temporaires de <PowerIconKeywords:Force>."
  },
  RelicConfig_100408_Name = {
    Text = "<OrangeQuality:Verrouillage lourd peint+>"
  },
  RelicConfig_100408_StoryDesc = {
    Text = "Un verrou épais et solide, difficile à ouvrir sans clé.\nBien sûr, cela ne pose aucun problème pour un certain voleur"
  },
  RelicConfig_100409_BattleDesc = {
    Text = "En ramassant, appliquez [Arg1] couches de <WeaknessIconKeywords:faiblesse> à tous les ennemis. Tous les éveillés voient leurs dégâts de base augmenter de [Arg2] %."
  },
  RelicConfig_100409_Desc = {
    Text = "En ramassant, appliquez [Arg1] couches de <WeaknessIconKeywords:faiblesse> à tous les ennemis. Tous les éveillés voient leurs dégâts de base augmenter de [Arg2] %."
  },
  RelicConfig_100409_Name = {
    Text = "<OrangeQuality:Môme peint+>"
  },
  RelicConfig_100409_StoryDesc = {
    Text = "Né de la pure méchanceté, même si ce n'était pas son souhait"
  },
  RelicConfig_100410_BattleDesc = {
    Text = "Chaque fois que vous infligez des dégâts, obtenez [Arg1] points de <PowerIconKeywords:force> temporaire, jusqu'à 15 fois par tour."
  },
  RelicConfig_100410_Desc = {
    Text = "Chaque fois que vous infligez des dégâts, obtenez [Arg1] points de <PowerIconKeywords:force> temporaire, jusqu'à 15 fois par tour."
  },
  RelicConfig_100410_Name = {
    Text = "<OrangeQuality:Agate Enroulée peinte+>"
  },
  RelicConfig_100410_StoryDesc = {
    Text = "Ce ne sont probablement que des motifs d'agate ordinaires. Peut-être"
  },
  RelicConfig_100411_BattleDesc = {
    Text = "En ramassant, appliquez [Arg1] couches de <VulnerabilityIconKeywords:vulnérable> à tous les ennemis. Tous les éveillés voient leurs dégâts de base augmenter de [Arg2] %."
  },
  RelicConfig_100411_Desc = {
    Text = "En ramassant, appliquez [Arg1] couches de <VulnerabilityIconKeywords:vulnérable> à tous les ennemis. Tous les éveillés voient leurs dégâts de base augmenter de [Arg2] %."
  },
  RelicConfig_100411_Name = {
    Text = "<OrangeQuality:Le Sacrifice du Printemps peint+>"
  },
  RelicConfig_100411_StoryDesc = {
    Text = "Dans les rires de la nuit, la silhouette du canoë glisse librement sur le lac"
  },
  RelicConfig_100412_BattleDesc = {
    Text = "À la fin du tour, récupère [Heal:Arg1] PV."
  },
  RelicConfig_100412_Desc = {
    Text = "À la fin du tour, récupère [Heal:Arg1] PV."
  },
  RelicConfig_100412_Name = {
    Text = "<WhiteQuality:Sang de Grâce peint>"
  },
  RelicConfig_100412_StoryDesc = {
    Text = "Il est doux et raffiné, avec un parfum de rose"
  },
  RelicConfig_100413_BattleDesc = {
    Text = "Perdez de la vie et obtenez un montant de fournaise cramoisie équivalent à [Arg1]% de la vie perdue."
  },
  RelicConfig_100413_Desc = {
    Text = "Perdez de la vie et obtenez un montant de fournaise écarlate équivalent à [Arg1]% de la vie perdue."
  },
  RelicConfig_100413_Name = {
    Text = "<WhiteQuality:Scie en acier rouillé peinte>"
  },
  RelicConfig_100413_StoryDesc = {
    Text = "Le médecin de la dissection ne voit jamais de belles femmes, seulement un sac de os, des nerfs enflammés par la maladie, des muscles et des tissus"
  },
  RelicConfig_100539_BattleDesc = {
    Text = "Après avoir utilisé «embryon» pour la première fois dans chaque tour, les dégâts directs infligeront des <BleedingIconKeywords:saignement> équivalents à [Arg1]% des dégâts infligés ce tour."
  },
  RelicConfig_100539_Desc = {
    Text = "Après l'utilisation directe de «embryon» pour la première fois dans chaque tour, les dégâts directs infligés dans ce tour infligeront des <BleedingIconKeywords:saignement> équivalents à [Arg1]% des dégâts."
  },
  RelicConfig_100539_Name = {
    Text = "<WhiteQuality:Pavé ensanglanté peint>"
  },
  RelicConfig_100539_StoryDesc = {
    Text = "Un, deux, trois, quatre, cinq"
  },
  RelicConfig_100540_BattleDesc = {
    Text = "Après avoir utilisé «Embryon» directement pour la première fois à chaque tour, les dégâts directs infligés dans ce tour appliqueront un <BleedingIconKeywords:saignement> équivalent à [Arg1]% des dégâts."
  },
  RelicConfig_100540_Desc = {
    Text = "Après avoir utilisé «embryon» pour la première fois dans chaque tour, les dégâts directs infligés ce tour-ci causeront une quantité de <BleedingIconKeywords:saignement> équivalente à [Arg1]% des dégâts."
  },
  RelicConfig_100540_Name = {
    Text = "<OrangeQuality:Pavé ensanglanté peint+>"
  },
  RelicConfig_100540_StoryDesc = {
    Text = "Un, deux, trois, quatre, cinq"
  },
  RelicConfig_116382_BattleDesc = {
    Text = "Un trousseau de clés rouillées. Peut ouvrir des serrures"
  },
  RelicConfig_116382_Desc = {
    Text = "Un trousseau de clés rouillées. Peut ouvrir des serrures"
  },
  RelicConfig_116382_Name = {
    Text = "Clé rouillée"
  },
  RelicConfig_116383_BattleDesc = {
    Text = "Un trousseau de clés rouillées. Peut ouvrir des serrures"
  },
  RelicConfig_116383_Desc = {
    Text = "Un trousseau de clés rouillées. Peut ouvrir des serrures"
  },
  RelicConfig_116383_Name = {
    Text = "Clé rouillée"
  },
  RelicConfig_116384_BattleDesc = {
    Text = "Un trousseau de clés rouillées. Peut ouvrir des serrures"
  },
  RelicConfig_116384_Desc = {
    Text = "Un trousseau de clés rouillées. Peut ouvrir des serrures"
  },
  RelicConfig_116384_Name = {
    Text = "Clé rouillée"
  },
  RelicConfig_119371_BattleDesc = {
    Text = "Limite de cartes à main +1. \n Au début du tour, si tous les rituels ne sont pas complétés, gagnez un <SacrificeKeyWord:Sacrifice> équivalent à 10 % de votre PV Max. Ajoutez 1 carte « <DerivativeCardKeywords_119:Offrande aux divinités> » à votre main, avec un maximum de 1 carte."
  },
  RelicConfig_119371_Desc = {
    Text = "Limite de cartes à main +1. \n Au début du tour, si tous les rituels ne sont pas complétés, obtenez un <SacrificeKeyWord:Sacrifice> de 10% de votre PV Max. Placez 1 carte « <DerivativeCardKeywords_119:Offrande aux divinités> » dans votre main, en conservant au maximum 1 carte."
  },
  RelicConfig_119371_Name = {
    Text = "Encensoir en laiton"
  },
  RelicConfig_119371_StoryDesc = {
    Text = "«J'ai fabriqué ce brûleur d'encens en imitant l'artisanat de Lémuria, qu'il vous aide à dormir paisiblement chaque nuit. Miryam. »"
  },
  RelicConfig_120372_BattleDesc = {
    Text = "Limite Max de la Main+[Arg1]. Au début du tour, placez [Arg2] cartes «<PVPDerivativeCardKeywords_11:Échange Inégal>» dans votre main."
  },
  RelicConfig_120372_Desc = {
    Text = "Limite Max de la Main+[Arg1]. Au début du tour, placez [Arg2] cartes «<PVPDerivativeCardKeywords_11:Échange Inégal>» dans votre main."
  },
  RelicConfig_120372_Name = {
    Text = "<OrangeQuality:Caleidoscope>"
  },
  RelicConfig_120373_BattleDesc = {
    Text = "Jouez les [Arg1] premières « <PVPWeaponKeywords:Roue du Destin> » avec un coût d'Arithmetica de -5/-3/-1/+1, piochez 1 carte."
  },
  RelicConfig_120373_Desc = {
    Text = "Jouez les [Arg1] premières « <PVPWeaponKeywords:Roue du Destin> » avec un coût d'Arithmetica de -5/-3/-1/+1, piochez 1 carte."
  },
  RelicConfig_120373_Name = {
    Text = "<OrangeQuality:Badge de Missag>"
  },
  RelicConfig_121214_BattleDesc = {
    Text = "Immunité aux dégâts"
  },
  RelicConfig_121214_Desc = {
    Text = "Immunité aux dégâts"
  },
  RelicConfig_121214_Name = {
    Text = "Création de test invincible"
  },
  RelicConfig_121689_BattleDesc = {
    Text = "Les dégâts finaux infligés augmentent de 250 %, chaque fois que des dégâts sont infligés, cela réduit de 50 %, et augmente le bouclier infligé de 10 %, pouvant être déclenché jusqu'à 5 fois, réinitialisé à chaque début de tour."
  },
  RelicConfig_121689_Desc = {
    Text = "Dégâts finaux augmentés de 250 %, chaque fois que des dégâts sont infligés, réduisez de 50 %, et augmentez le bouclier causé de 10 %, déclenchable jusqu'à 5 fois, réinitialisé à chaque début de tour."
  },
  RelicConfig_121689_Name = {
    Text = "<OrangeQuality:«Le retour en argent pur· Naissance»>"
  },
  RelicConfig_121690_BattleDesc = {
    Text = "Au début du combat, choisissez 3 cartes pour leur donner l'effet «<RippleKeywords:Réplica> : piochez 1 carte, gagnez [Arg3] points de <PowerIconKeywords:force> temporaire». Au début du tour, piochez 2 cartes avec <RippleKeywords:Réplica>, tous les effets <RippleKeywords:Réplica> déclenchent une fois de plus; après avoir déclenché 10 fois <RippleKeywords:Réplica>, placez 1 carte <DerivativeCardKeywords_1:Écho des Ombres> dans votre main."
  },
  RelicConfig_121690_Desc = {
    Text = "Au début du combat, choisissez 3 cartes pour leur donner «<RippleKeywords:Réplica>: tirez 1 carte, gagnez [Arg3] points de <PowerIconKeywords:force> temporaire». Au début du tour, tirez 2 cartes avec <RippleKeywords:Réplica>, tous les effets <RippleKeywords:Réplica> se déclenchent une fois de plus. Après avoir déclenché 10 fois <RippleKeywords:Réplica>, placez 1 carte <DerivativeCardKeywords_1:Écho des Ombres> dans votre main."
  },
  RelicConfig_121690_Name = {
    Text = "<OrangeQuality:«Le retour en argent pur· Fou»>"
  },
  RelicConfig_121691_BattleDesc = {
    Text = "Tous les éveilleurs voient les Dégâts Finaux de leur Exaltation augmenter de 100 %. Chaque fois qu'un éveilleur utilise l'Exaltation, obtenez des Fragments de clé équivalents à 500 % de l'Aliemus de base de cet éveilleur, et l'Aliemus de base de tous les éveilleurs est réduit de 20, avec un maximum de 5 réductions."
  },
  RelicConfig_121691_Desc = {
    Text = "Tous les éveilleurs voient les Dégâts Finaux de leur Exaltation augmenter de 100 %. Chaque fois qu'un éveilleur utilise l'Exaltation, obtenez des Fragments de clé équivalents à 500 % de l'Aliemus de base de cet éveilleur, et l'Aliemus de base de tous les éveilleurs est réduit de 20, avec un maximum de 5 réductions."
  },
  RelicConfig_121691_Name = {
    Text = "<OrangeQuality:«Le retour en argent pur· Peur»>"
  },
  RelicConfig_121692_BattleDesc = {
    Text = "Tous les éveillés voient leurs <RetaliateIconKeywords:contre-attaque>, <IntoxicationIconKeywords:poison>, bouclier et régénération de vie augmenter de 50%. À la fin du tour, obtenez un <RetaliateIconKeywords:contre-attaque> temporaire équivalent à 500% de votre bouclier actuel."
  },
  RelicConfig_121692_Desc = {
    Text = "Tous les éveillés voient leurs <RetaliateIconKeywords:contre-attaque>, <IntoxicationIconKeywords:poison>, bouclier et régénération de vie augmenter de 50%. À la fin du tour, obtenez un <RetaliateIconKeywords:contre-attaque> temporaire de 500% du bouclier actuel."
  },
  RelicConfig_121692_Name = {
    Text = "<OrangeQuality:«Le retour en argent pur·Hérésie»>"
  },
  RelicConfig_121693_BattleDesc = {
    Text = "Limite Max de la Main +5. Au début du tour, piochez 2 cartes et gagnez 2 points d'Arithmetica. Chaque fois que le paquet est réinitialisé, obtenez [Arg3] points de <PowerIconKeywords:Force> et [Arg4] points temporaires <AlertIconKeywords:Alerte>, générez 1 carte de chaque carte d'instruction non dérivée pour chaque Éveilleur avec le maximum de fureur et placez-les dans la pioche, réduisant leur coût d'Arithmetica de 1 point."
  },
  RelicConfig_121693_Desc = {
    Text = "Limite Max de la Main +5. Au début du tour, piochez 2 cartes et obtenez 2 points d'Arithmetica. Chaque fois que le paquet est réinitialisé, gagnez [Arg3] points <PowerIconKeywords:Force> et [Arg4] points temporaires <AlertIconKeywords:Alerte>, générez 1 carte de chaque Carte d'instruction non dérivée pour chaque Éveilleur de la folie maximale et placez-les dans la pioche, réduisant leur coût d'Arithmetica de 1."
  },
  RelicConfig_121693_Name = {
    Text = "<OrangeQuality:«Le retour en argent pur·Scathe»>"
  },
  RelicConfig_121694_BattleDesc = {
    Text = "Tous les éveilleurs gagnent 25 points de fureur lors de la première carte d'instruction de chaque tour et mettent une carte <DerivativeCardKeywords_4:perspicacité> dans leur main. Après avoir libéré 4 fois l'Exaltation, l'état <Seal:scellé> de tous les éveilleurs est annulé, et tous les éveilleurs reçoivent 50 points de fureur."
  },
  RelicConfig_121694_Desc = {
    Text = "Tous les éveilleurs gagnent 25 points de fureur lors de la première carte d'instruction de chaque tour et mettent une carte <DerivativeCardKeywords_4:«perspicacité»> dans leur main. Après avoir libéré 4 fois l'Exaltation, annulez l'état <Seal:scellé> de tous les éveilleurs et faites-leur gagner 50 points de fureur."
  },
  RelicConfig_121694_Name = {
    Text = "<OrangeQuality:«Le retour en argent pur·Deceit»>"
  },
  RelicConfig_121695_BattleDesc = {
    Text = "Au début du combat, obtenez [Arg4] points de <PowerIconKeywords:Force>, la capacité de stockage de l'énergie clé en argent augmente de 100%. L'énergie clé en argent obtenue par point de coût d'arithmetica augmente de 100%, après avoir utilisé l'Éveil des Fragments de clé ou libéré un Décret Clé, obtenez 20% de <PowerIconKeywords:Force> temporaire équivalente à la <PowerIconKeywords:Force> actuelle et faites en sorte que tous les éveilleurs obtiennent 20 points de fureur."
  },
  RelicConfig_121695_Desc = {
    Text = "Au début du combat, gagnez [Arg4] points de <PowerIconKeywords:Force>, la limite de stockage d'énergie de clé en argent augmente de 100%. L'énergie de clé en argent obtenue par point de coût d'arithmetica est augmentée de 100%. Après avoir utilisé l'Éveil des Fragments de clé ou libéré un Décret Clé, obtenez 20% temporaires de <PowerIconKeywords:Force> équivalents à la <PowerIconKeywords:Force> actuelle et faites en sorte que tous les éveilleurs obtiennent 20 points de fureur."
  },
  RelicConfig_121695_Name = {
    Text = "<OrangeQuality:«Le retour en argent pur· Lamento»>"
  },
  RelicConfig_122625_BattleDesc = {
    Text = "Au début de la bataille, placez [Arg1] \"<PVPDerivativeCardKeywords_25:Thé Rouge de Sylvia>\" dans votre main."
  },
  RelicConfig_122625_Desc = {
    Text = "Au début de la bataille, placez [Arg1] \"<PVPDerivativeCardKeywords_25:Thé Rouge de Sylvia>\" dans votre main."
  },
  RelicConfig_122625_Name = {
    Text = "<OrangeQuality:thé noir de Ceylan>"
  },
  RelicConfig_122626_BattleDesc = {
    Text = "Ajoutez [Arg1] carte(s) « <PVPDerivativeCardKeywords_14:Réalité imitée> » dans la pile de pioche à chaque tour, le propriétaire étant un Éveilleur aléatoire."
  },
  RelicConfig_122626_Desc = {
    Text = "Dans chaque tour, insérez [Arg1] cartes «<PVPDerivativeCardKeywords_14:Réalité imitée>» dans la pioche, le propriétaire étant un Éveilleur aléatoire."
  },
  RelicConfig_122626_Name = {
    Text = "<OrangeQuality:Gants magiques>"
  },
  RelicConfig_122627_BattleDesc = {
    Text = "Les dégâts, la guérison et le bouclier du premier «skill» joué chaque tour augmentent de [Arg1] %."
  },
  RelicConfig_122627_Desc = {
    Text = "Les premiers dégâts, soins et boucliers infligés par le « compétence » jouée chaque tour augmentent de [Arg1] %."
  },
  RelicConfig_122627_Name = {
    Text = "<OrangeQuality:Broche de Rubis>"
  },
  RelicConfig_122628_BattleDesc = {
    Text = "À la fin du tour, gagnez en plus <Energy:[Arg1]> points de fureur."
  },
  RelicConfig_122628_Desc = {
    Text = "À la fin du tour, gagnez en plus <Energy:[Arg1]> points de fureur."
  },
  RelicConfig_122628_Name = {
    Text = "<OrangeQuality:Manifestation du Cauchemar>"
  },
  RelicConfig_122629_BattleDesc = {
    Text = "Il y aura le double de cartes Éveilleur dans la Pioche. Après avoir joué une carte, si le nombre de cartes dans la Main est inférieur à [Arg1] pour la première fois ce tour, piochez [Arg2] cartes."
  },
  RelicConfig_122629_Desc = {
    Text = "Il y aura le double de cartes d'Éveilleur dans la Pioche. Après avoir joué une carte, si le nombre de cartes en main est inférieur à [Arg1] pour la première fois ce tour-ci, piochez [Arg2] cartes."
  },
  RelicConfig_122629_Name = {
    Text = "<OrangeQuality:Disque de joie>"
  },
  RelicConfig_122630_BattleDesc = {
    Text = "Limite Max de la Main+[Arg1]. À chaque tour, insérez [Arg2] «<PVPDerivativeCardKeywords_13:Funérailles immortelles>» dans la pioche."
  },
  RelicConfig_122630_Desc = {
    Text = "Limite Max de la Main+[Arg1]. À chaque tour, insérez [Arg2] cartes «<PVPDerivativeCardKeywords_13:Funérailles immortelles>» dans la pioche."
  },
  RelicConfig_122630_Name = {
    Text = "<OrangeQuality:Couteau sacrificiel perdu>"
  },
  RelicConfig_122768_BattleDesc = {
    Text = "Au début du tour, piochez [Arg1] cartes « Frappe » avec un coût en arithmétique de -1. Après avoir libéré Exalt, générez [Arg2] cartes « Frappe » du Réveilleur correspondant avec <DepleteIconKeywords:épuiser>, <PrepareKeypvewords:Préparer 1>, et <RetainIconKeywords:Conserver>. \n Pour chaque [Arg3] « Frappe » jouée dans un délai de 1 tour, gagnez [Arg4] points temporaires <PowerIconKeywords:Force> ; après avoir joué [Arg5] cartes « Frappe », piochez [Arg6] cartes et gagnez [Arg7] arithmétique ; après avoir joué [Arg8] cartes « Frappe », tous les éveilleurs gagnent [Arg9] aliemus."
  },
  RelicConfig_122768_Desc = {
    Text = "Au début du tour, piochez [Arg1] cartes « Frappe » avec un coût en arithmétique de -1. Après avoir libéré Exalt, générez [Arg2] cartes « Frappe » du Réveilleur correspondant avec <DepleteIconKeywords:épuiser>, <PrepareKeypvewords:Préparer 1>, et <RetainIconKeywords:Conserver>. \n Pour chaque [Arg3] « Frappe » jouée dans un délai de 1 tour, gagnez [Arg4] points temporaires <PowerIconKeywords:Force> ; après avoir joué [Arg5] cartes « Frappe », piochez [Arg6] cartes et gagnez [Arg7] arithmétique ; après avoir joué [Arg8] cartes « Frappe », tous les éveilleurs gagnent [Arg9] aliemus."
  },
  RelicConfig_122768_Name = {
    Text = "Écho de l'autre monde"
  },
  RelicConfig_122768_StoryDesc = {
    Text = "Échos se mêlant dans la brume d'un autre monde, conduisant à la distorsion, à la folie et à une réalité indéniable."
  },
  RelicConfig_123724_BattleDesc = {
    Text = "Au début du tour, Mouchette gagne [Arg1] points de Fureur et génère 1 « Attaque » temporaire avec un coût d'Arithmetica de 0. Chaque fois que « Rencontre dramatique » se déclenche, les effets augmentant les dommages de base et les dommages d'attaque causés par « Tornade Éclatante☆ » dans ce combat augmentent de [Arg2] %."
  },
  RelicConfig_123724_Desc = {
    Text = "Au début du tour, Mouchette gagne [Arg1] points de Fureur et génère 1 « Attaque » temporaire avec un coût d'Arithmetica de 0. Chaque fois que « Rencontre dramatique » se déclenche, les effets augmentant les dommages de base et les dommages d'attaque causés par « Tornade Éclatante☆ » dans ce combat augmentent de [Arg2] %."
  },
  RelicConfig_123724_Name = {
    Text = "<OrangeQuality:Image dimensionnelle : Moxia>"
  },
  RelicConfig_125488_BattleDesc = {
    Text = "Tous les éveillés gagnent [Arg1] points de fureur lors de la première carte d'instruction jouée chaque tour. Après avoir joué 4 cartes d'instruction appartenant à différents éveillés dans un même tour, appliquez [Arg2]% de nos PV Max d'<IntoxicationIconKeywords:poison> à tous les ennemis."
  },
  RelicConfig_125488_Desc = {
    Text = "Tous les Éveilleurs gagnent [Arg1] points de Fureur lors de la première Carte d'instruction jouée par tour. Après avoir joué 4 Cartes d'instruction appartenant à différents Éveilleurs en un tour, appliquez [Arg2]% des PV Max de notre équipe en tant que<IntoxicationIconKeywords:Poison>."
  },
  RelicConfig_125488_Name = {
    Text = "L'orgueil des concubines"
  },
  RelicConfig_125489_BattleDesc = {
    Text = "Au début du tour, Xu gagne [Arg1] aliemus et applique 1 couche de <WitherKeywords:Envoûté> à tous les ennemis. La première carte de commandement que Xu joue chaque tour déclenchera toujours l'effet \"Résonance\"."
  },
  RelicConfig_125489_Desc = {
    Text = "Au début du tour, Xu gagne [Arg1] aliemus et applique 1 couche de <WitherKeywords:Envoûté> à tous les ennemis. La première carte de commandement que Xu joue chaque tour déclenchera toujours l'effet \"Résonance\"."
  },
  RelicConfig_125489_Name = {
    Text = "<OrangeQuality:Image dimensionnelle : Xu>"
  },
  RelicConfig_126673_BattleDesc = {
    Text = "Taille maximale de main +3. Enregistrez les 3 premières cartes de commandement non dérivées jouées à chaque tour, et au début du tour 3 tours plus tard, réduisez leur coût en arithmétique de 1 et ajoutez des copies avec <DepleteIconKeywords:Épuisé> à votre main."
  },
  RelicConfig_126673_Desc = {
    Text = "Taille maximale de main +3. Enregistrez les 3 premières cartes de commandement non dérivées jouées à chaque tour, et au début du tour 3 tours plus tard, réduisez leur coût en arithmétique de 1 et ajoutez des copies avec <DepleteIconKeywords:Épuisé> à votre main."
  },
  RelicConfig_126673_Name = {
    Text = "Roue du destin"
  },
  RelicConfig_126673_StoryDesc = {
    Text = "La roue tourne à jamais."
  },
  RelicConfig_129304_BattleDesc = {
    Text = "<OrangeQuality:Harmonie dorée> : « Harmonie d'Arithmetica » n'augmente désormais le Coût d'Arithmetica que de 1. Chaque 1 % d'Amplification de Dégâts augmente la Profondeur de l'étude de la Connaissance Spirituelle de 1 %.\n<OrangeQuality:Cadeau Dimensionnel> : Au début de l'exploration, obtenez aléatoirement 1 Relique d'Image Dimensionnelle. Limite de Main +2.\n<OrangeQuality:Rituel Béni> : Les récompenses des Chefs de Phase 1 et Phase 2 sont remplacées par un choix parmi 3 Reliques Bénies.\n<RedQuality:Fatigue de Transit> : Tous les effets de régénération de PV sont réduits de 50 % pendant le combat. Lorsque « Enterrement » est sélectionné aux « Os fanés », l'effet est remplacé par une restauration de 25 % des PV Max.\n<RedQuality:Signes d'étourdissement> : Au début du combat, la Fureur actuelle et le Fragment de clé de tous les éveilleurs sont réduits de 50 %.\n<RedQuality:Couloir de la Nuit Éternelle> : Au début de l'exploration, l'Aliemus de base et le plafond de Fragment de clé de tous les éveilleurs augmentent de 50 %."
  },
  RelicConfig_129304_Desc = {
    Text = "<OrangeQuality:Harmonie dorée> : « Harmonie d'Arithmetica » n'augmente désormais le Coût d'Arithmetica que de 1. Chaque 1 % d'Amplification de Dégâts augmente la Profondeur de l'étude de la Connaissance Spirituelle de 1 %.\n<OrangeQuality:Cadeau Dimensionnel> : Au début de l'exploration, obtenez aléatoirement 1 Relique d'Image Dimensionnelle. Limite de Main +2.\n<OrangeQuality:Rituel Béni> : Les récompenses des Chefs de Phase 1 et Phase 2 sont remplacées par un choix parmi 3 Reliques Bénies.\n<RedQuality:Fatigue de Transit> : Tous les effets de régénération de PV sont réduits de 50 % pendant le combat. Lorsque « Enterrement » est sélectionné aux « Os fanés », l'effet est remplacé par une restauration de 25 % des PV Max.\n<RedQuality:Signes d'étourdissement> : Au début du combat, la Fureur actuelle et le Fragment de clé de tous les éveilleurs sont réduits de 50 %.\n<RedQuality:Couloir de la Nuit Éternelle> : Au début de l'exploration, l'Aliemus de base et le plafond de Fragment de clé de tous les éveilleurs augmentent de 50 %."
  },
  RelicConfig_129304_Name = {
    Text = "<OrangeQuality:Petite caméra de chaos « N »>"
  },
  RelicConfig_129304_StoryDesc = {
    Text = "C'est fichu ! L'appareil photo est complètement cassé ! Hein ? Comment ça fonctionne encore ? Attends ! Quelles sont toutes ces restrictions ?!"
  },
  RelicConfig_129305_BattleDesc = {
    Text = "<OrangeQuality:Harmonie dorée> : « Harmonie d'Arithmetica » n'augmente désormais le Coût d'Arithmetica que de 1. Chaque 1 % d'Amplification de Dégâts augmente la Profondeur de l'étude de la Connaissance Spirituelle de 1 %.\n<RedQuality:Fatigue de Transit> : Tous les effets de guérison en combat sont réduits de 50 %. Lorsque « Enterrement » est sélectionné aux « Os fanés », l'effet est remplacé par une restauration de 25 % des PV Max."
  },
  RelicConfig_129305_Desc = {
    Text = "<OrangeQuality:Harmonie dorée> : « Harmonie d'Arithmetica » n'augmente désormais le Coût d'Arithmetica que de 1. Chaque 1 % d'Amplification de Dégâts augmente la Profondeur de l'étude de la Connaissance Spirituelle de 1 %.\n<RedQuality:Fatigue de Transit> : Tous les effets de guérison en combat sont réduits de 50 %. Lorsque « Enterrement » est sélectionné aux « Os fanés », l'effet est remplacé par une restauration de 25 % des PV Max."
  },
  RelicConfig_129305_Name = {
    Text = "<OrangeQuality:Petite « N » caméra complète>"
  },
  RelicConfig_129305_StoryDesc = {
    Text = "Ne regarde plus, c'est l'appareil photo ! Tout neuf, honnête pour tous."
  },
  RelicConfig_129306_BattleDesc = {
    Text = "<OrangeQuality:Harmonie dorée> : « Harmonie d'Arithmetica » n'augmente désormais le Coût d'Arithmetica que de 1. Chaque 1 % d'Amplification de Dégâts augmente la Profondeur de l'étude de la Connaissance Spirituelle de 1 %.\n<OrangeQuality:Cadeau Dimensionnel> : Au début de l'exploration, obtenez aléatoirement 1 Relique d'Image Dimensionnelle. Limite de Main +1.\n<RedQuality:Fatigue de Transit> : Tous les effets de régénération de PV sont réduits de 50 % pendant le combat. Lorsque « Enterrement » est sélectionné aux « Os fanés », l'effet est remplacé par une restauration de 25 % des PV Max.\n<RedQuality:Signes d'étourdissement> : Au début du combat, la Fureur actuelle et le Fragment de clé de tous les éveilleurs sont réduits de 50 %."
  },
  RelicConfig_129306_Desc = {
    Text = "<OrangeQuality:Harmonie dorée> : « Harmonie d'Arithmetica » n'augmente désormais le Coût d'Arithmetica que de 1. Chaque 1 % d'Amplification de Dégâts augmente la Profondeur de l'étude de la Connaissance Spirituelle de 1 %.\n<OrangeQuality:Cadeau Dimensionnel> : Au début de l'exploration, obtenez aléatoirement 1 Relique d'Image Dimensionnelle. Limite de Main +1.\n<RedQuality:Fatigue de Transit> : Tous les effets de régénération de PV sont réduits de 50 % pendant le combat. Lorsque « Enterrement » est sélectionné aux « Os fanés », l'effet est remplacé par une restauration de 25 % des PV Max.\n<RedQuality:Signes d'étourdissement> : Au début du combat, la Fureur actuelle et le Fragment de clé de tous les éveilleurs sont réduits de 50 %."
  },
  RelicConfig_129306_Name = {
    Text = "<OrangeQuality:Petite « N » vieille caméra>"
  },
  RelicConfig_129306_StoryDesc = {
    Text = "C'est fini ! L'appareil photo est cassé ! Laissez-moi jeter un œil pour le réparer... Il s'allume ! Mais pourquoi ai-je l'impression que quelque chose ne va pas..."
  },
  RelicConfig_131079_BattleDesc = {
    Text = "Au début du tour, Mosk obtient [Arg1] points de fureur. La première fois que « Charge ! » ou « Charge » est joué durant chaque tour, son effet se déclenche 2 fois."
  },
  RelicConfig_131079_Desc = {
    Text = "Au début du tour, Mosk obtient [Arg1] points de fureur. La première fois que « Charge ! » ou « Charge » est joué durant chaque tour, son effet se déclenche 2 fois."
  },
  RelicConfig_131079_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Mosk>"
  },
  RelicConfig_131080_BattleDesc = {
    Text = "Au début des 3 premiers tours, déclenchez 1 fois « Dilemme de l'otarie » à chaque tour. Au début du 5ème tour, retirez tous les effets négatifs de « Dilemme de l'otarie » et obtenez « <DerivativeCardKeywords_135:Impact de la deuxième génération !> »."
  },
  RelicConfig_131080_Desc = {
    Text = "Au début des 3 premiers tours, déclenchez 1 fois « Dilemme de l'otarie » à chaque tour. Au début du 5ème tour, retirez tous les effets négatifs de « Dilemme de l'otarie » et obtenez « <DerivativeCardKeywords_135:Impact de la deuxième génération !> »."
  },
  RelicConfig_131080_Name = {
    Text = "Petit charbon, deuxième génération"
  },
  RelicConfig_131080_StoryDesc = {
    Text = "Madame Mosk a dit fermement que c'était une relique. \n «Méchant, mords-le !»"
  },
  RelicConfig_131178_BattleDesc = {
    Text = "Au début du combat, Mélanger une « <DerivativeCardKeywords_134:Vérité Défendue> » dans le deck. Piocher +[Arg1] à chaque tour. Après avoir joué une Carte d'instruction, accorder aléatoirement <ErosionColorInkKeywords:Distorsion de Perception> à [Arg2] Cartes d'instruction dans la main de l'adversaire."
  },
  RelicConfig_131178_Desc = {
    Text = "Au début du combat, Mélanger une « <DerivativeCardKeywords_134:Vérité Défendue> » dans le deck. Piocher +[Arg1] à chaque tour. Après avoir joué une Carte d'instruction, accorder aléatoirement <ErosionColorInkKeywords:Distorsion de Perception> à [Arg2] Cartes d'instruction dans la main de l'adversaire."
  },
  RelicConfig_131178_Name = {
    Text = "Journal de l'Infini"
  },
  RelicConfig_131178_StoryDesc = {
    Text = "Le contenu enregistré contient soixante-dix nombres premiers de Mason."
  },
  RelicConfig_132540_BattleDesc = {
    Text = "Immunité aux dégâts"
  },
  RelicConfig_132540_Name = {
    Text = "Création de test d'ensemble"
  },
  RelicConfig_13740_BattleDesc = {
    Text = "Augmente le taux critique de 15 %. Si la vie est inférieure à 25 % au début du tour ([Arg1]), le taux critique de ce tour augmente de 30 %"
  },
  RelicConfig_13740_Desc = {
    Text = "Augmente le taux critique de 15 %. Si la vie est inférieure à 25 % au début du tour, le taux critique de ce tour augmente de 30 %"
  },
  RelicConfig_13740_Name = {
    Text = "<OrangeQuality:Astrolabe ésotérique>"
  },
  RelicConfig_13740_StoryDesc = {
    Text = "Les mystères de l'univers"
  },
  RelicConfig_13741_BattleDesc = {
    Text = "Dégâts critiques augmentés de 15%. Les dégâts infligés aux ennemis avec bouclier sont toujours critiques"
  },
  RelicConfig_13741_Desc = {
    Text = "Dégâts critiques augmentés de 15%. Les dégâts infligés aux ennemis avec bouclier sont toujours critiques"
  },
  RelicConfig_13741_Name = {
    Text = "<WhiteQuality:Principe esthétique>"
  },
  RelicConfig_13741_StoryDesc = {
    Text = "Sculpteur de cire : assistant du docteur, client des pompes funèbres, bienfaiteur des vers de tombe"
  },
  RelicConfig_13742_BattleDesc = {
    Text = "Dégâts critiques +50%. Chaque troisième attaque inflige un coup critique garanti"
  },
  RelicConfig_13742_Desc = {
    Text = "Dégâts critiques +50%. Chaque troisième attaque inflige un coup critique garanti"
  },
  RelicConfig_13742_Name = {
    Text = "<OrangeQuality:Pendule Chrono \"Méditation\">"
  },
  RelicConfig_13743_BattleDesc = {
    Text = "Au début du tour, le réveilleur avec le moins d'aliemus gagne 15 aliemus. Lors de la pose de 2 cartes consommatrices d'arithmetica plus faibles que la précédente, le réveilleur avec le moins d'aliemus gagne 15 aliemus"
  },
  RelicConfig_13743_Desc = {
    Text = "Au début du tour, le réveilleur avec le moins d'aliemus gagne 15 aliemus. Lors de la pose de 2 cartes consommatrices d'arithmetica plus faibles que la précédente, le réveilleur avec le moins d'aliemus gagne 15 aliemus"
  },
  RelicConfig_13743_Name = {
    Text = "<OrangeQuality:Relique d'Arcana>"
  },
  RelicConfig_13743_StoryDesc = {
    Text = "Fin du destin"
  },
  RelicConfig_13744_BattleDesc = {
    Text = "Au début du tour, l'éveillé avec la folie la plus basse gagne 15 de folie"
  },
  RelicConfig_13744_Desc = {
    Text = "Au début du tour, l'éveillé avec la folie la plus basse gagne 15 de folie"
  },
  RelicConfig_13744_Name = {
    Text = "<WhiteQuality:Boutons de manchette>"
  },
  RelicConfig_13744_StoryDesc = {
    Text = "Boutons de manchette en argent avec motif de laurier.\nIls sont finement travaillés et brillants, symbolisant l'amitié de deux enfants"
  },
  RelicConfig_13745_BattleDesc = {
    Text = "L'effet de bonus recommandé par le royaume est augmenté à 50 %, et au début du niveau, votre taux de marque de chance est doublé"
  },
  RelicConfig_13745_Desc = {
    Text = "L'effet de bonus recommandé par le royaume est augmenté à 50 %, et au début du niveau, votre taux de marque de chance est doublé"
  },
  RelicConfig_13745_Name = {
    Text = "<OrangeQuality:Chrono Pendulum\"Deep Sleep\">"
  },
  RelicConfig_13747_BattleDesc = {
    Text = "Immunité à 1 mort, restaure immédiatement 10% de vie après activation, devient invalide après 3 activations"
  },
  RelicConfig_13747_Desc = {
    Text = "Immunité à 1 mort, restaure immédiatement 10% de vie après activation, devient invalide après 3 activations"
  },
  RelicConfig_13747_Name = {
    Text = "<WhiteQuality:☆Nourriture d'urgence☆>"
  },
  RelicConfig_13747_StoryDesc = {
    Text = "En cas de nécessité absolue, évite de manger ça"
  },
  RelicConfig_13748_BattleDesc = {
    Text = "Au début de la bataille, les cartes ayant un coût d'1 point dans ce combat voient leurs dommages augmentés de [Arg1] points et leurs boucliers augmentés de [Arg2] points"
  },
  RelicConfig_13748_Desc = {
    Text = "Au début de la bataille, les cartes ayant un coût d'1 point dans ce combat voient leurs dommages augmentés de [Arg1] points et leurs boucliers augmentés de [Arg2] points"
  },
  RelicConfig_13748_Name = {
    Text = "<OrangeQuality:Marie innocente>"
  },
  RelicConfig_13748_StoryDesc = {
    Text = "La logique est comme un cocktail, en abuser en annule les bienfaits"
  },
  RelicConfig_13749_BattleDesc = {
    Text = "Chaque 4 tours, doublez les Dommages actifs et les Dégâts des tentacules subis par tous les ennemis ce tour-ci. Cependant, après avoir libéré une Exaltation ce tour-ci, scellez tous les Corps éveillés pendant 1 tour."
  },
  RelicConfig_13749_Desc = {
    Text = "Chaque 4 tours, doublez les Dommages actifs et les Dégâts des tentacules subis par tous les ennemis ce tour-ci. Cependant, après avoir libéré une Exaltation ce tour-ci, scellez tous les Corps éveillés pendant 1 tour."
  },
  RelicConfig_13749_Name = {
    Text = "<RedQuality:Cadavre du chemin>"
  },
  RelicConfig_13749_StoryDesc = {
    Text = "Une partie sacrée.\nMême séparée du tronc, ses traces sont partout"
  },
  RelicConfig_13750_BattleDesc = {
    Text = "À la fin du tour, s'il n'y a pas de bouclier, gagne 1 niveau d'immunité à des dégâts de <ParcloseIconKeywords:barrière>. N'est efficace qu'une fois par bataille"
  },
  RelicConfig_13750_Desc = {
    Text = "À la fin du tour, s'il n'y a pas de bouclier, gagne 1 niveau d'immunité à des dégâts de <ParcloseIconKeywords:barrière>. N'est efficace qu'une fois par bataille"
  },
  RelicConfig_13750_Name = {
    Text = "<WhiteQuality:☆Antidouleurs☆>"
  },
  RelicConfig_13750_StoryDesc = {
    Text = "L'effet n'est pas si permanent"
  },
  RelicConfig_13751_BattleDesc = {
    Text = "Taux critique augmenté de 25 %, les dégâts infligés lors du premier coup de chaque tour sont doublés"
  },
  RelicConfig_13751_Desc = {
    Text = "Taux critique augmenté de 25 %, les dégâts infligés lors du premier coup de chaque tour sont doublés"
  },
  RelicConfig_13751_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Approfondissement\">"
  },
  RelicConfig_13752_BattleDesc = {
    Text = "Au début du tour, régénérez [Arg1] de vie. Si la vie est inférieure à 50%, régénérez [Arg2]"
  },
  RelicConfig_13752_Desc = {
    Text = "Au début du tour, régénérez [Arg1] de vie. Si la vie est inférieure à 50%, régénérez [Arg2]"
  },
  RelicConfig_13752_Name = {
    Text = "<WhiteQuality:Sang béni>"
  },
  RelicConfig_13752_StoryDesc = {
    Text = "Il est doux et raffiné, avec un parfum de rose"
  },
  RelicConfig_13753_BattleDesc = {
    Text = "C'est un objet de quête sans effet"
  },
  RelicConfig_13753_Desc = {
    Text = "C'est un objet de quête sans effet"
  },
  RelicConfig_13753_Name = {
    Text = "Test de création de mission"
  },
  RelicConfig_13753_StoryDesc = {
    Text = "Nécessite une création avec contenu supplémentaire"
  },
  RelicConfig_13754_BattleDesc = {
    Text = "Chaque 5ème dégâts que tu infliges sera un coup critique"
  },
  RelicConfig_13754_Desc = {
    Text = "Chaque 5ème dégâts que tu infliges sera un coup critique"
  },
  RelicConfig_13754_Name = {
    Text = "<WhiteQuality:Correcteur de vision>"
  },
  RelicConfig_13754_StoryDesc = {
    Text = "Quelqu'un a trouvé la vérité à travers elle"
  },
  RelicConfig_13755_BattleDesc = {
    Text = "Au début du tour, pour chaque carte dans <DimensionalSpaceIconKeywords:espace dimensionnel>, gagnez [Arg1] points de <PowerIconKeywords:force> temporaire. Si c'est un tour dimensionnel, gagnez [Arg2] points de <PowerIconKeywords:force> temporaire"
  },
  RelicConfig_13755_Desc = {
    Text = "Au début du tour, pour chaque carte dans <DimensionalSpaceIconKeywords:espace dimensionnel>, gagnez [Arg1] points de <PowerIconKeywords:force> temporaire. Si c'est un tour dimensionnel, gagnez [Arg2] points de <PowerIconKeywords:force> temporaire"
  },
  RelicConfig_13755_Name = {
    Text = "<WhiteQuality:Prisme>"
  },
  RelicConfig_13755_StoryDesc = {
    Text = "\"La lumière est composée de sept couleurs.\""
  },
  RelicConfig_13756_BattleDesc = {
    Text = "Lors de la collecte, perdre toutes les autres reliques et obtenir aléatoirement 2 reliques en or"
  },
  RelicConfig_13756_Desc = {
    Text = "Lors de la collecte, perdre toutes les autres reliques et obtenir aléatoirement 2 reliques en or"
  },
  RelicConfig_13756_Name = {
    Text = "<RedQuality:☆Observation inversée☆>"
  },
  RelicConfig_13756_StoryDesc = {
    Text = "Dans l'ère étrange, les fleurs sont les premiers spectateurs des humains.\nNe bouge pas, elles préfèrent les expositions calmes"
  },
  RelicConfig_13757_BattleDesc = {
    Text = "Chaque 8ème carte de commandement que tu joues prendra effet 2 fois"
  },
  RelicConfig_13757_Desc = {
    Text = "Chaque 8ème carte de commandement que tu joues prendra effet 2 fois"
  },
  RelicConfig_13757_Name = {
    Text = "<OrangeQuality:Vin des étoiles>"
  },
  RelicConfig_13757_StoryDesc = {
    Text = "Errant parmi les étoiles"
  },
  RelicConfig_13758_BattleDesc = {
    Text = "Augmente la santé max de [Arg1] points après la collecte, la folie obtenue lors d'une attaque augmente de 2 points"
  },
  RelicConfig_13758_Desc = {
    Text = "Augmente la santé max de [Arg1] points après la collecte, la folie obtenue lors d'une attaque augmente de 2 points"
  },
  RelicConfig_13758_Name = {
    Text = "<WhiteQuality:Encre douce>"
  },
  RelicConfig_13758_StoryDesc = {
    Text = ": Quelqu'un dit que c'est du sang de démon, mais, hé, essayons d'abord !"
  },
  RelicConfig_13759_BattleDesc = {
    Text = "Lors de la libération de l'exaltation, lorsqu'un ennemi est sur le point d'infliger des dégâts, appliquez-lui [Arg1] couches de <IntoxicationIconKeywords:poison>"
  },
  RelicConfig_13759_Desc = {
    Text = "Lors de la libération de l'exaltation, lorsqu'un ennemi est sur le point d'infliger des dégâts, appliquez-lui [Arg1] couches de <IntoxicationIconKeywords:poison>"
  },
  RelicConfig_13759_Name = {
    Text = "<WhiteQuality:☆Mâchoire laser☆>"
  },
  RelicConfig_13759_StoryDesc = {
    Text = "Les ossements exposés dans la salle privée d'un collectionneur.\nLe collectionneur, fasciné par cette belle lueur, les admirait jour et nuit, finissant par mourir et devenir l'un d'eux"
  },
  RelicConfig_13760_BattleDesc = {
    Text = "Capacité maximale augmentée de 1. Lorsque vous jouez consécutivement 2 cartes avec une consommation de calcul plus élevée que la précédente, obtenez 1 capacité"
  },
  RelicConfig_13760_Desc = {
    Text = "Capacité maximale augmentée de 1. Lorsque vous jouez consécutivement 2 cartes avec une consommation de calcul plus élevée que la précédente, obtenez 1 capacité"
  },
  RelicConfig_13760_Name = {
    Text = "<OrangeQuality:Archives d'Arcana>"
  },
  RelicConfig_13760_StoryDesc = {
    Text = "Tendance du destin"
  },
  RelicConfig_13761_BattleDesc = {
    Text = "Au début du tour, si le nombre de cartes restantes à la fin du dernier tour est supérieur à 3, gagner 2 arithmetica"
  },
  RelicConfig_13761_Desc = {
    Text = "Au début du tour, si le nombre de cartes restantes à la fin du dernier tour est supérieur à 3, gagner 2 arithmetica"
  },
  RelicConfig_13761_Name = {
    Text = "<WhiteQuality:emblème de mythag>"
  },
  RelicConfig_13761_StoryDesc = {
    Text = "L'insigne distribué aux enquêteurs par l'université de Mythag. Il symbolise non seulement l'identité du porteur, mais sert également d'outil de communication à distance"
  },
  RelicConfig_13762_BattleDesc = {
    Text = "Lorsque vous jouez « défense », gagnez [Arg1] points de <RetaliateIconKeywords:comptoir>"
  },
  RelicConfig_13762_Desc = {
    Text = "Lorsque vous jouez « défense », gagnez [Arg1] points de <RetaliateIconKeywords:comptoir>"
  },
  RelicConfig_13762_Name = {
    Text = "Gilet d'ortie métamorphosé"
  },
  RelicConfig_13762_StoryDesc = {
    Text = "Impossible d'identifier le liquide contaminé"
  },
  RelicConfig_13763_BattleDesc = {
    Text = "Au début du combat, obtenez [Arg1] points de bouclier. Au début du tour, si vous avez un bouclier, ce tour-ci, le bouclier et le soin sont augmentés de 50 %"
  },
  RelicConfig_13763_Desc = {
    Text = "Au début du combat, obtenez [Arg1] points de bouclier. Au début du tour, si vous avez un bouclier, ce tour-ci, le bouclier et le soin sont augmentés de 50 %"
  },
  RelicConfig_13763_Name = {
    Text = "Gardien du jardin altéré"
  },
  RelicConfig_13764_BattleDesc = {
    Text = "Après ramassage, gagnez définitivement [Arg1] points de <PowerIconKeywords:force>"
  },
  RelicConfig_13764_Desc = {
    Text = "Après ramassage, gagnez définitivement [Arg1] points de <PowerIconKeywords:force>"
  },
  RelicConfig_13764_Name = {
    Text = "<WhiteQuality:Broche en rubis>"
  },
  RelicConfig_13764_StoryDesc = {
    Text = "Un rouge discret suinte"
  },
  RelicConfig_13766_BattleDesc = {
    Text = "Lors de la collecte, choisir une carte et lui attribuer deux effets de renforcement de choix de trois (note : similaire à mille mirages)"
  },
  RelicConfig_13766_Desc = {
    Text = "Lors de la collecte, choisir une carte et lui attribuer deux effets de renforcement de choix de trois (note : similaire à mille mirages)"
  },
  RelicConfig_13766_Name = {
    Text = "<OrangeQuality:☆Machine à écrire de maître☆>"
  },
  RelicConfig_13766_StoryDesc = {
    Text = ": On dit que les chefs-d'œuvre sont en fait écrits par des machines à écrire"
  },
  RelicConfig_13767_BattleDesc = {
    Text = "Lors de la collecte, obtenir 1 des 3 choix d'oraison avancée aléatoire, lui attribuer à la carte correspondante"
  },
  RelicConfig_13767_Desc = {
    Text = "Lors de la collecte, obtenir 1 des 3 choix d'oraison avancée aléatoire, lui attribuer à la carte correspondante"
  },
  RelicConfig_13767_Name = {
    Text = "<WhiteQuality:Papyrus de Reind>"
  },
  RelicConfig_13767_StoryDesc = {
    Text = "Maintenant, écoutez la question : 10 moines partagent 6 pains, combien chacun obtient-il ?"
  },
  RelicConfig_13768_BattleDesc = {
    Text = "Arithmetica Max augmenté de 2. Après avoir joué « Attaque » ou « Défense », le réveilleur correspondant obtient 5 points de fureur. Après avoir libéré l'Exaltation, obtenez 1 « Attaque » avec une consommation de Vide du réveilleur correspondant, après avoir libéré le Décret Clé, obtenez au hasard 1 « Défense » avec une consommation de Vide."
  },
  RelicConfig_13768_Desc = {
    Text = "Arithmetica Max augmenté de 2. Après avoir joué « Attaque » ou « Défense », le réveilleur correspondant obtient 5 points de fureur. Après avoir libéré l'Exaltation, obtenez 1 « Attaque » avec une consommation de Vide associée au réveilleur correspondant, après avoir libéré le Décret Clé, obtenez aléatoirement 1 « Défense » avec une consommation de Vide associée."
  },
  RelicConfig_13768_Name = {
    Text = "<OrangeQuality:Chrono Pendulum\"Wings\">"
  },
  RelicConfig_13769_BattleDesc = {
    Text = "Au début du tour, <EmbryoFusionIconKeywords:Fusion d'Embryon>+30. Tous vos effets de <DevouredIconKeywords:Dévorer> deviennent <UnlimitedDevouredIconKeywords:Dévoration Infinie>."
  },
  RelicConfig_13769_Desc = {
    Text = "Au début du tour, <EmbryoFusionIconKeywords:Fusion d'Embryon>+30. Tous vos effets de <DevouredIconKeywords:Dévorer> deviennent <UnlimitedDevouredIconKeywords:Dévoration Infinie>."
  },
  RelicConfig_13769_Name = {
    Text = "<RedQuality:Cordon ombilical rampant>"
  },
  RelicConfig_13769_StoryDesc = {
    Text = "Enroulement autour du cou"
  },
  RelicConfig_13770_BattleDesc = {
    Text = "Au début du tour, gagnez [Arg1] de bouclier, chaque tour augmente ce bouclier de [Arg2]"
  },
  RelicConfig_13770_Desc = {
    Text = "Au début du tour, gagnez [Arg1] de bouclier, chaque tour augmente ce bouclier de [Arg2]"
  },
  RelicConfig_13770_Name = {
    Text = "<WhiteQuality:Main protectrice>"
  },
  RelicConfig_13770_StoryDesc = {
    Text = "Main bénissante, poing ferme"
  },
  RelicConfig_13771_BattleDesc = {
    Text = "La recharge de clé en argent de tous les réveilleurs augmente de 30. Après avoir libéré une clé, mélangez 3 cartes <DerivativeCardKeywords_4:« inspiration »> dans votre bibliothèque"
  },
  RelicConfig_13771_Desc = {
    Text = "La recharge de clé en argent de tous les réveilleurs augmente de 30. Après avoir libéré une clé, mélangez 3 cartes <DerivativeCardKeywords_4:« inspiration »> dans votre bibliothèque"
  },
  RelicConfig_13771_Name = {
    Text = "<OrangeQuality:Pendule Chrono \"Léger sommeil\">"
  },
  RelicConfig_13772_BattleDesc = {
    Text = "Après le combat, obtenez 75 sigils noirs supplémentaires et 1 carte de symptômes"
  },
  RelicConfig_13772_Desc = {
    Text = "Après le combat, obtenez 75 sigils noirs supplémentaires et 1 carte de symptômes"
  },
  RelicConfig_13772_Name = {
    Text = "<RedQuality:Impression de jade>"
  },
  RelicConfig_13772_StoryDesc = {
    Text = "Cette empreinte est immortelle depuis des millénaires"
  },
  RelicConfig_13773_BattleDesc = {
    Text = "Chaque fois qu'un dommage actif est infligé, appliquez [Arg1] couches <BleedingIconKeywords:saignement> sur vous-même et [Arg2] couches <BleedingIconKeywords:saignement> à la cible blessée. Chaque fois qu'un ennemi est tué, dissipez l'état <BleedingIconKeywords:saignement> sur vous-même"
  },
  RelicConfig_13773_Desc = {
    Text = "Chaque fois qu'un dommage actif est infligé, appliquez [Arg1] couches <BleedingIconKeywords:saignement> sur vous-même et [Arg2] couches <BleedingIconKeywords:saignement> à la cible blessée. Chaque fois qu'un ennemi est tué, dissipez l'état <BleedingIconKeywords:saignement> sur vous-même"
  },
  RelicConfig_13773_Name = {
    Text = "<RedQuality:Conscience de l'essaim>"
  },
  RelicConfig_13773_StoryDesc = {
    Text = "Enroulement, symbiose, agrégation ; peur, inconnu, contrôle"
  },
  RelicConfig_13774_BattleDesc = {
    Text = "En jouant une carte ayant un coût en arithmetica réel de 3, tirez 1 carte et gagnez 2 en arithmetica ; en jouant une carte ayant un coût en arithmetica réel de 4 ou plus, le coût en arithmetica des autres cartes en main est réduit de 1"
  },
  RelicConfig_13774_Desc = {
    Text = "En jouant une carte ayant un coût en arithmetica réel de 3, tirez 1 carte et gagnez 2 en arithmetica ; en jouant une carte ayant un coût en arithmetica réel de 4 ou plus, le coût en arithmetica des autres cartes en main est réduit de 1"
  },
  RelicConfig_13774_Name = {
    Text = "<OrangeQuality:Chrono Pendulum\"Eye\">"
  },
  RelicConfig_13775_BattleDesc = {
    Text = "Lors de la collecte, choisir une carte d'ordre pour lui ajouter « intrinsèque », « conserver » et « piocher 1 carte après avoir joué »"
  },
  RelicConfig_13775_Desc = {
    Text = "Lors de la collecte, choisir une carte d'ordre pour lui ajouter « intrinsèque », « conserver » et « piocher 1 carte après avoir joué »"
  },
  RelicConfig_13775_Name = {
    Text = "<WhiteQuality:Dossier>"
  },
  RelicConfig_13775_StoryDesc = {
    Text = "Chut, c'est un marché secret entre toi et moi"
  },
  RelicConfig_13776_BattleDesc = {
    Text = "Après le début du combat, gagnez 1 tentacule"
  },
  RelicConfig_13776_Desc = {
    Text = "Après le début du combat, gagnez 1 tentacule"
  },
  RelicConfig_13776_Name = {
    Text = "<WhiteQuality:Petit escargot jaune>"
  },
  RelicConfig_13776_StoryDesc = {
    Text = "Ce petit escargot jaune est de noble origine, avec une provenance parfaite et irréprochable"
  },
  RelicConfig_13777_BattleDesc = {
    Text = "À la fin du tour impair, si vous avez de l'arithmétique restante, piochez 2 cartes supplémentaires au prochain tour ; à la fin du tour pair, si vous avez des cartes restantes, obtenez 2 points d'arithmétique supplémentaires au prochain tour"
  },
  RelicConfig_13777_Desc = {
    Text = "À la fin du tour impair, si vous avez de l'arithmétique restante, piochez 2 cartes supplémentaires au prochain tour ; à la fin du tour pair, si vous avez des cartes restantes, obtenez 2 points d'arithmétique supplémentaires au prochain tour"
  },
  RelicConfig_13777_Name = {
    Text = "<OrangeQuality:Roue du Soleil et de la Lune>"
  },
  RelicConfig_13777_StoryDesc = {
    Text = "Devine, noir ou blanc ?"
  },
  RelicConfig_13778_BattleDesc = {
    Text = "Limite de tentacule augmentée de 1. Lorsque la vie est inférieure à 50%, <TentacleInjurieIconKeywords:dégâts de tentacule> augmente de [Arg1]"
  },
  RelicConfig_13778_Desc = {
    Text = "Limite de tentacule augmentée de 1. Lorsque la vie est inférieure à 50%, <TentacleInjurieIconKeywords:dégâts de tentacule> augmente de [Arg1]"
  },
  RelicConfig_13778_Name = {
    Text = "<OrangeQuality:Chant des profondeurs>"
  },
  RelicConfig_13778_StoryDesc = {
    Text = "On dit que des animaux non comestibles comme le nudibronche absorbent environ 80% des nutriments de l'océan"
  },
  RelicConfig_13779_BattleDesc = {
    Text = "Au début du tour, piochez 1 carte, à la fin du tour, vous pouvez conserver 1 carte en main"
  },
  RelicConfig_13779_Desc = {
    Text = "Au début du tour, piochez 1 carte, à la fin du tour, vous pouvez conserver 1 carte en main"
  },
  RelicConfig_13779_Name = {
    Text = "<OrangeQuality:Lanterne à souhaits du prophète>"
  },
  RelicConfig_13779_StoryDesc = {
    Text = "Répondre à ton souhait"
  },
  RelicConfig_13780_BattleDesc = {
    Text = "Chaque fois que vous libérez l'exaltation, obtenez 1 carte <DerivativeCardKeywords_7:« contamination toxique »>. Si vous avez 3 cartes <DerivativeCardKeywords_7:« contamination toxique »> dans votre main, combinez-les pour créer une carte déclenchant <IntoxicationIconKeywords:poison> <DerivativeCardKeywords_8:« toxicité active »>."
  },
  RelicConfig_13780_Desc = {
    Text = "Chaque fois que vous libérez l'exaltation, obtenez 1 carte <DerivativeCardKeywords_7:« Contamination toxique »>. Si vous avez 3 cartes <DerivativeCardKeywords_7:« Contamination toxique »> dans votre main, combinez-les pour créer une carte déclenchant <IntoxicationIconKeywords:poison> <DerivativeCardKeywords_8:« Toxicité active »>."
  },
  RelicConfig_13780_Name = {
    Text = "<OrangeQuality:Langue étrangère>"
  },
  RelicConfig_13780_StoryDesc = {
    Text = "Il n'est pas un démon, mais il transmet des murmures d'un autre monde"
  },
  RelicConfig_13781_BattleDesc = {
    Text = "Chaque fois que 1 sigil noir est consommé, tous les réveilleurs obtiennent 1 point de colère"
  },
  RelicConfig_13781_Desc = {
    Text = "Chaque fois que 1 sigil noir est consommé, tous les réveilleurs obtiennent 1 point de colère"
  },
  RelicConfig_13781_Name = {
    Text = "Fleur inversée"
  },
  RelicConfig_13782_BattleDesc = {
    Text = "Immunité aux dégâts"
  },
  RelicConfig_13782_Desc = {
    Text = "Immunité aux dégâts"
  },
  RelicConfig_13782_Name = {
    Text = "Création de test"
  },
  RelicConfig_13783_BattleDesc = {
    Text = "Après avoir joué la 3e carte à chaque tour, placez 1 <DerivativeCardKeywords_4:\"Inspiration\"> dans la pile de défausse. Après avoir joué la 6e carte à chaque tour, placez 1 <DerivativeCardKeywords_4:\"Inspiration\"> de la pile de défausse dans votre main."
  },
  RelicConfig_13783_Desc = {
    Text = "Après avoir joué la 3e carte à chaque tour, placez 1 <DerivativeCardKeywords_4:\"Inspiration\"> dans la pile de défausse. Après avoir joué la 6e carte à chaque tour, placez 1 <DerivativeCardKeywords_4:\"Inspiration\"> de la pile de défausse dans votre main."
  },
  RelicConfig_13783_Name = {
    Text = "<WhiteQuality:Lumière de la civilisation>"
  },
  RelicConfig_13783_StoryDesc = {
    Text = ": Une étoile filante déchire la nuit"
  },
  RelicConfig_13784_BattleDesc = {
    Text = "Au début du tour, pour chaque ennemi, gagne 1 arithmetica. Lorsque tu tues un ennemi par des dégâts actifs, inflige des dégâts de saignement égaux aux dégâts excédentaires à d'autres ennemis.<BleedingIconKeywords:saignement>"
  },
  RelicConfig_13784_Desc = {
    Text = "Au début du tour, pour chaque ennemi, gagne 1 arithmetica. Lorsque tu tues un ennemi par des dégâts actifs, inflige des dégâts de saignement égaux aux dégâts excédentaires à d'autres ennemis.<BleedingIconKeywords:saignement>"
  },
  RelicConfig_13784_Name = {
    Text = "<OrangeQuality:Chant des foules>"
  },
  RelicConfig_13784_StoryDesc = {
    Text = "Né pour torturer tes oreilles"
  },
  RelicConfig_13785_BattleDesc = {
    Text = "À la fin du tour, <EmbryoFusionIconKeywords:Fusion d'Embryon> +15. Si une <DerivativeCardKeywords_2:« Embryon »> est en main, récupère [Arg1] PV."
  },
  RelicConfig_13785_Desc = {
    Text = "À la fin du tour, <EmbryoFusionIconKeywords:Fusion d'Embryon> +15. Si une <DerivativeCardKeywords_2:« Embryon »> est en main, récupère [Arg1] PV."
  },
  RelicConfig_13785_Name = {
    Text = "<WhiteQuality:Diagnostic de peste>"
  },
  RelicConfig_13785_StoryDesc = {
    Text = "Peste—une manifestation aléatoire de l'agitation inconsciente de la nature"
  },
  RelicConfig_13786_BattleDesc = {
    Text = "Après avoir libéré l'exaltation, gagnez [Arg1] points temporaires de <PowerIconKeywords:pouvoir>"
  },
  RelicConfig_13786_Desc = {
    Text = "Après avoir libéré l'exaltation, gagnez [Arg1] points temporaires de <PowerIconKeywords:pouvoir>"
  },
  RelicConfig_13786_Name = {
    Text = "<WhiteQuality:Verrou lourd>"
  },
  RelicConfig_13786_StoryDesc = {
    Text = "Un verrou épais et solide, difficile à ouvrir sans clé.\nBien sûr, cela ne pose aucun problème pour un certain voleur"
  },
  RelicConfig_13787_BattleDesc = {
    Text = "Au début du tour, inflige [Arg1] <FixedDamage:DGT Purs> à un ennemi aléatoire. Après avoir joué « Attaque » 7 fois dans ce combat, les DGT infligés passent à [Arg2]. Après avoir joué « Attaque » 21 fois, inflige instantanément [Arg3] <FixedDamage:DGT Purs> à tous les ennemis."
  },
  RelicConfig_13787_Desc = {
    Text = "Au début du tour, inflige [Arg1] <FixedDamage:DGT Purs> à un ennemi aléatoire. Après avoir joué « Attaque » 7 fois dans ce combat, les DGT infligés passent à [Arg2]. Après avoir joué « Attaque » 21 fois, inflige instantanément [Arg3] <FixedDamage:DGT Purs> à tous les ennemis."
  },
  RelicConfig_13787_Name = {
    Text = "<OrangeQuality:Vieux puzzle>"
  },
  RelicConfig_13787_StoryDesc = {
    Text = "L'œuvre d'art autrefois encadrée manquait un morceau depuis le jour de son exposition"
  },
  RelicConfig_13788_BattleDesc = {
    Text = "Limite de tentacules -2. À la fin du tour, tous les tentacules attaquent une fois de plus"
  },
  RelicConfig_13788_Desc = {
    Text = "Limite de tentacules -2. À la fin du tour, tous les tentacules attaquent une fois de plus"
  },
  RelicConfig_13788_Name = {
    Text = "<RedQuality:Bras sacré de douleur>"
  },
  RelicConfig_13788_StoryDesc = {
    Text = "Savoure la souffrance"
  },
  RelicConfig_13789_BattleDesc = {
    Text = "Chaque fois que le deck est réinitialisé, obtenir [Arg1] <PowerIconKeywords:force>"
  },
  RelicConfig_13789_Desc = {
    Text = "Chaque fois que le deck est réinitialisé, obtenir [Arg1] <PowerIconKeywords:force>"
  },
  RelicConfig_13789_Name = {
    Text = "<WhiteQuality:Pipe pleureuse>"
  },
  RelicConfig_13789_StoryDesc = {
    Text = "Est-ce le fruit de la haine ou le résultat de la vengeance ?"
  },
  RelicConfig_13790_BattleDesc = {
    Text = "Chaque déplacement sur la carte vous rapporte 10 sigils noirs, mais la pression mentale du déplacement augmentera de 10 points"
  },
  RelicConfig_13790_Desc = {
    Text = "Chaque déplacement sur la carte vous rapporte 10 sigils noirs, mais la pression mentale du déplacement augmentera de 10 points"
  },
  RelicConfig_13790_Name = {
    Text = "Sac sans fond"
  },
  RelicConfig_13791_BattleDesc = {
    Text = "En ramassant cette relique, choisissez une carte de commandement et ajoutez une copie de celle-ci dans la pile de cartes"
  },
  RelicConfig_13791_Desc = {
    Text = "En ramassant cette relique, choisissez une carte de commandement et ajoutez une copie de celle-ci dans la pile de cartes"
  },
  RelicConfig_13791_Name = {
    Text = "<WhiteQuality:Feu éphémère>"
  },
  RelicConfig_13791_StoryDesc = {
    Text = "Lumière vacillante, espoir faible"
  },
  RelicConfig_13792_BattleDesc = {
    Text = "Chaque fois que vous perdez des PV, <EmbryoFusionIconKeywords:Fusion d'Embryon>+10. Si PV < 50%, effet doublé."
  },
  RelicConfig_13792_Desc = {
    Text = "Chaque fois que vous perdez des PV, <EmbryoFusionIconKeywords:Fusion d'Embryon>+10. Si PV < 50%, effet doublé."
  },
  RelicConfig_13792_Name = {
    Text = "<WhiteQuality:Scie rouillée>"
  },
  RelicConfig_13792_StoryDesc = {
    Text = "Le médecin de la dissection ne voit jamais de belles femmes, seulement un sac de os, des nerfs enflammés par la maladie, des muscles et des tissus"
  },
  RelicConfig_13793_BattleDesc = {
    Text = "Lors de la collecte, les sceaux de l'équipe tombent à 150 % de leur valeur d'origine. Après avoir régénéré des PV, tous les Éveilleurs gagnent 3 points de Fureur ; après avoir perdu des PV, obtenez [Arg1] points de <PowerIconKeywords:force> et de dégâts des tentacules, jusqu'à un maximum de 5 fois par tour."
  },
  RelicConfig_13793_Desc = {
    Text = "Lors du ramassage, les sceaux obtenus par l'équipe deviennent 150% de la valeur originale. Après la régénération de PV, tous les éveilleurs gagnent 3 points de fureur ; après avoir perdu des PV, obtenez [Arg1] points de <PowerIconKeywords:force> et des dégâts des tentacules, jusqu'à 5 fois par tour au total."
  },
  RelicConfig_13793_Name = {
    Text = "<OrangeQuality:Pendule Chrono \"Lune\">"
  },
  RelicConfig_13794_BattleDesc = {
    Text = "Après la fin du tour, tous les réveilleurs obtiennent 5 folie. Pour chaque point d'arsenal restant, tous les réveilleurs reçoivent en plus 3 folie"
  },
  RelicConfig_13794_Desc = {
    Text = "Après la fin du tour, tous les réveilleurs obtiennent 5 folie. Pour chaque point d'arsenal restant, tous les réveilleurs reçoivent en plus 3 folie"
  },
  RelicConfig_13794_Name = {
    Text = "<OrangeQuality:Batterie prototype>"
  },
  RelicConfig_13794_StoryDesc = {
    Text = "Espoir portable"
  },
  RelicConfig_13795_BattleDesc = {
    Text = "Capacité maximale augmentée de 1"
  },
  RelicConfig_13795_Desc = {
    Text = "Capacité maximale augmentée de 1"
  },
  RelicConfig_13795_Name = {
    Text = "<WhiteQuality:Injecteur actif>"
  },
  RelicConfig_13795_StoryDesc = {
    Text = "Les convulsions sont aussi une forme d'activité"
  },
  RelicConfig_13796_BattleDesc = {
    Text = "À la fin du combat, lorsque les points de vie restent en dessous de 50 %, évoluez en une relique d'argent"
  },
  RelicConfig_13796_Desc = {
    Text = "À la fin du combat, lorsque les PV restent en dessous de 50 %, évoluez en une Création en argent"
  },
  RelicConfig_13796_Name = {
    Text = "Vieux carnet 2"
  },
  RelicConfig_13796_StoryDesc = {
    Text = "Un vieux carnet de notes, rempli de pages insérées, contient au moins une carte d'Elworth, des enregistrements d'expérimentation et du papier griffonné de marques de dissolution.\nLes premiers mots des notes sont soigneusement écrits, mais deviennent progressivement brouillons et désordonnés"
  },
  RelicConfig_13797_BattleDesc = {
    Text = "Après avoir joué 3 cartes d'attaque, évoluez en un relèque en or"
  },
  RelicConfig_13797_Desc = {
    Text = "Après avoir joué 3 cartes d'Attaque, évoluez en une Création en or."
  },
  RelicConfig_13797_Name = {
    Text = "Vieux carnet 1"
  },
  RelicConfig_13797_StoryDesc = {
    Text = "Un vieux carnet de notes, rempli de pages insérées, contient au moins une carte d'Elworth, des enregistrements d'expérimentation et du papier griffonné de marques de dissolution.\nLes premiers mots des notes sont soigneusement écrits, mais deviennent progressivement brouillons et désordonnés"
  },
  RelicConfig_13798_BattleDesc = {
    Text = "Au début de la bataille, tous vos cartes de symptôme obtiennent <NothingnessIconKeywords:illusion>, et pour chaque carte de symptôme dans la pioche, gagnez [Arg1] <PowerIconKeywords:pouvoir>"
  },
  RelicConfig_13798_Desc = {
    Text = "Au début de la bataille, tous vos cartes de symptôme obtiennent <NothingnessIconKeywords:illusion>, et pour chaque carte de symptôme dans la pioche, gagnez [Arg1] <PowerIconKeywords:pouvoir>"
  },
  RelicConfig_13798_Name = {
    Text = "<WhiteQuality:Élixir de Harford>"
  },
  RelicConfig_13798_StoryDesc = {
    Text = ": Médicament de composition inconnue.\nOn dit que le célèbre violoniste Éric l'apprécie beaucoup"
  },
  RelicConfig_13799_BattleDesc = {
    Text = "Au début du premier tour de bataille, ajoutez <DerivativeCardKeywords_1:\"Écho des Ombres\"> à votre main ; au deuxième tour, ajoutez <DerivativeCardKeywords_39:\"Résonance de la Clé Argentée\"> ; au troisième tour, ajoutez <DerivativeCardKeywords_41:\"Écho du Passé\">."
  },
  RelicConfig_13799_Desc = {
    Text = "Au début du premier tour de bataille, ajoutez <DerivativeCardKeywords_1:\"Écho des Ombres\"> à votre main ; au deuxième tour, ajoutez <DerivativeCardKeywords_39:\"Résonance de la Clé Argentée\"> ; au troisième tour, ajoutez <DerivativeCardKeywords_41:\"Écho du Passé\">."
  },
  RelicConfig_13799_Name = {
    Text = "<OrangeQuality:Chrono Pendulum\"Stars\">"
  },
  RelicConfig_13800_BattleDesc = {
    Text = "Au début du tour, ajouter 1 <DerivativeCardKeywords_6: \"parapluie\"> à la main, après avoir joué 6 cartes, augmenter la garde de toutes les <DerivativeCardKeywords_6: \"parapluie\"><AlertIconKeywords: alerte> dans votre main de [Arg2]"
  },
  RelicConfig_13800_Desc = {
    Text = "Au début du tour, ajouter 1 <DerivativeCardKeywords_6: \"parapluie\"> à la main, après avoir joué 6 cartes, augmenter la garde de toutes les <DerivativeCardKeywords_6: \"parapluie\"><AlertIconKeywords: alerte> dans votre main de [Arg2]"
  },
  RelicConfig_13800_Name = {
    Text = "<WhiteQuality:Parapluie de voyage>"
  },
  RelicConfig_13800_StoryDesc = {
    Text = "Fleurir dans les ténèbres"
  },
  RelicConfig_13801_BattleDesc = {
    Text = "Dans une bataille régulière, la vie de tous les ennemis est augmentée de 30 %, et lors d'une victoire, vous recevez 25 sigils noirs en plus"
  },
  RelicConfig_13801_Desc = {
    Text = "Dans une bataille régulière, la vie de tous les ennemis est augmentée de 30 %, et lors d'une victoire, vous recevez 25 sigils noirs en plus"
  },
  RelicConfig_13801_Name = {
    Text = "Drapeau de bataille brisé"
  },
  RelicConfig_13802_BattleDesc = {
    Text = "Lors de la collecte, augmenter la santé max de [Arg1] points. Si la santé au moment de la collecte est inférieure à 25%, l'augmentation de la santé max devient [Arg2] points"
  },
  RelicConfig_13802_Desc = {
    Text = "Lors de la collecte, augmenter la santé max de [Arg1] points. Si la santé au moment de la collecte est inférieure à 25%, l'augmentation de la santé max devient [Arg2] points"
  },
  RelicConfig_13802_Name = {
    Text = "<WhiteQuality:Thé rouge de Ceylan>"
  },
  RelicConfig_13802_StoryDesc = {
    Text = "Une alimentation saine commence par nous"
  },
  RelicConfig_13803_BattleDesc = {
    Text = "Tous les 3 tours, obtient 3 tentacules temporaires"
  },
  RelicConfig_13803_Desc = {
    Text = "Tous les 3 tours, obtient 3 tentacules temporaires"
  },
  RelicConfig_13803_Name = {
    Text = "<WhiteQuality:Casque de plongée>"
  },
  RelicConfig_13803_StoryDesc = {
    Text = "Les rêves sont des étoiles et des océans !"
  },
  RelicConfig_13804_BattleDesc = {
    Text = "À la fin du tour, gagne [Arg1] points de bouclier. Si le bouclier est 0 ou multiple de 3, gagne [Arg2] points de <PowerIconKeywords:force>"
  },
  RelicConfig_13804_Desc = {
    Text = "À la fin du tour, gagne [Arg1] points de bouclier. Si le bouclier est 0 ou multiple de 3, gagne [Arg2] points de <PowerIconKeywords:force>"
  },
  RelicConfig_13804_Name = {
    Text = "<OrangeQuality:Signal de détresse>"
  },
  RelicConfig_13804_StoryDesc = {
    Text = "Il n'a pas attendu les secours"
  },
  RelicConfig_13806_BattleDesc = {
    Text = "Lorsque vous piochez une carte de symptôme, obtenez [Arg1] points de <PowerIconKeywords:pouvoir> temporaire. Pour chaque relique maudite que vous possédez, le taux critique et les dégâts critiques augmentent de 10 %"
  },
  RelicConfig_13806_Desc = {
    Text = "Lorsque vous piochez une carte de symptôme, obtenez [Arg1] points de <PowerIconKeywords:pouvoir> temporaire. Pour chaque relique maudite que vous possédez, le taux critique et les dégâts critiques augmentent de 10 %"
  },
  RelicConfig_13806_Name = {
    Text = "<OrangeQuality:Communication abyssale>"
  },
  RelicConfig_13806_StoryDesc = {
    Text = "Dans les périphéries désolées, un téléphone sonne dans la cabine solitaire. \n\"Ténèbres... sifflement... infini... sifflement... ténèbres...\""
  },
  RelicConfig_13807_BattleDesc = {
    Text = "Au début de la bataille, <EmbryoFusionIconKeywords:Fusion d'Embryon>+50. Pour chaque Corps éveillé ayant au moins 50 points d'Aliemus, un effet supplémentaire se produit."
  },
  RelicConfig_13807_Desc = {
    Text = "Au début de la bataille, <EmbryoFusionIconKeywords:Fusion d'Embryon>+50. Pour chaque Corps éveillé ayant au moins 50 points d'Aliemus, un effet supplémentaire se produit."
  },
  RelicConfig_13807_Name = {
    Text = "<WhiteQuality:Chéri>"
  },
  RelicConfig_13807_StoryDesc = {
    Text = "Le menuisier a fabriqué une marionnette vivante pour sa femme, qui remplacera leur fils et dormira dans son ventre"
  },
  RelicConfig_13808_BattleDesc = {
    Text = "Après avoir libéré l'exaltation, placez une carte aléatoire correspondante au réveilleur dans votre main, cette carte obtient <DepleteIconKeywords:épuiser> et <NothingnessIconKeywords:illusion>. À la fin de la bataille, récupérez [Arg1] points de vie"
  },
  RelicConfig_13808_Desc = {
    Text = "Après avoir libéré l'exaltation, placez une carte aléatoire correspondante au réveilleur dans votre main, cette carte obtient <DepleteIconKeywords:épuiser> et <NothingnessIconKeywords:illusion>. À la fin de la bataille, récupérez [Arg1] points de vie"
  },
  RelicConfig_13808_Name = {
    Text = "<WhiteQuality:trousse de médecin>"
  },
  RelicConfig_13808_StoryDesc = {
    Text = "La mallette symbolisant la profession médicale est très lourde.\n\nCelui qui l'ouvre n'est pas forcément un vrai médecin.\n"
  },
  RelicConfig_13809_BattleDesc = {
    Text = "Tous les prix des créations réduits de 20"
  },
  RelicConfig_13809_Desc = {
    Text = "Tous les prix des créations réduits de 20"
  },
  RelicConfig_13809_Name = {
    Text = "<WhiteQuality:Langue acérée>"
  },
  RelicConfig_13809_StoryDesc = {
    Text = "Les bavards ne sont pas seulement des marchands, mais aussi des croyants dévots"
  },
  RelicConfig_13811_BattleDesc = {
    Text = "Toutes les 3 fois qu'« Attaque » est jouée, inflige [Arg1] <FixedDamage:DGT Purs> à tous les ennemis. L'Éveilleur correspondant gagne 15 Fureur."
  },
  RelicConfig_13811_Desc = {
    Text = "Toutes les 3 fois qu'« Attaque » est jouée, inflige [Arg1] <FixedDamage:DGT Purs> à tous les ennemis. L'Éveilleur correspondant gagne 15 Fureur."
  },
  RelicConfig_13811_Name = {
    Text = "<WhiteQuality:Scalpel rouillé>"
  },
  RelicConfig_13811_StoryDesc = {
    Text = "Pas adapté pour couper des tissus vivants"
  },
  RelicConfig_13812_BattleDesc = {
    Text = "Lors de la collecte, augmenter la santé max de 100%, au début du tour, perdre [Arg1] points de vie"
  },
  RelicConfig_13812_Desc = {
    Text = "Lors de la collecte, augmenter la santé max de 100%, au début du tour, perdre [Arg1] points de vie"
  },
  RelicConfig_13812_Name = {
    Text = "<RedQuality:☆Chair de l'immortel☆>"
  },
  RelicConfig_13812_StoryDesc = {
    Text = "\"La vie marine perd souvent des membres pour survivre.\""
  },
  RelicConfig_13813_BattleDesc = {
    Text = "Après le début du combat, la vie actuelle des ennemis d'élite et du chef diminue de 20 %"
  },
  RelicConfig_13813_Desc = {
    Text = "Après le début du combat, la vie actuelle des ennemis d'élite et du chef diminue de 20 %"
  },
  RelicConfig_13813_Name = {
    Text = "<WhiteQuality:☆Ancienne ancre de navire☆>"
  },
  RelicConfig_13813_StoryDesc = {
    Text = "Rentre chez toi, vieux marin"
  },
  RelicConfig_13814_BattleDesc = {
    Text = "À la fin du tour, chaque carte non jouée dans la main donne 2 points de folie à tous les éveillés"
  },
  RelicConfig_13814_Desc = {
    Text = "À la fin du tour, chaque carte non jouée dans la main donne 2 points de folie à tous les éveillés"
  },
  RelicConfig_13814_Name = {
    Text = "<WhiteQuality:Balance déséquilibrée>"
  },
  RelicConfig_13814_StoryDesc = {
    Text = "Ne symbolise plus la justice"
  },
  RelicConfig_13815_BattleDesc = {
    Text = "Après la collecte, choisir une carte, rendant son coût en arithmétique permanent à 1"
  },
  RelicConfig_13815_Desc = {
    Text = "Après la collecte, choisir une carte, rendant son coût en arithmétique permanent à 1"
  },
  RelicConfig_13815_Name = {
    Text = "<WhiteQuality:☆Œil artificiel raffiné☆>"
  },
  RelicConfig_13815_StoryDesc = {
    Text = "Un œil qui n'est plus pur"
  },
  RelicConfig_13816_BattleDesc = {
    Text = "Au début du combat, tous les ennemis gagnent [Arg1] points <RetaliateIconKeywords: comptoir>. Chaque fois que des dégâts sont infligés, le réveilleur avec le moins de aliemus gagne 6 points de aliemus"
  },
  RelicConfig_13816_Desc = {
    Text = "Au début du combat, tous les ennemis gagnent [Arg1] points <RetaliateIconKeywords: comptoir>. Chaque fois que des dégâts sont infligés, le réveilleur avec le moins de aliemus gagne 6 points de aliemus"
  },
  RelicConfig_13816_Name = {
    Text = "<RedQuality:☆Cloche de lamentation☆>"
  },
  RelicConfig_13816_StoryDesc = {
    Text = [[
Ding ling, ding ling, l'enfant pleure ;
Ding ling, ding ling, l'enfant crie.
Ding ling, ding ling, l'enfant hurle ;
Ding ling, ding ling, il a faim, tu le sais]]
  },
  RelicConfig_13817_BattleDesc = {
    Text = "Après avoir joué 6 cartes de commandement, <TentacleInjurieIconKeywords:dégâts de tentacule> +[Arg1]"
  },
  RelicConfig_13817_Desc = {
    Text = "Après avoir joué 6 cartes de commandement, <TentacleInjurieIconKeywords:dégâts de tentacule> +[Arg1]"
  },
  RelicConfig_13817_Name = {
    Text = "<WhiteQuality:Céphalopode>"
  },
  RelicConfig_13817_StoryDesc = {
    Text = "Tant que notre cerveau reste un mystère, il n'y a rien d'étonnant à ce qu'il soit rempli de tentacules"
  },
  RelicConfig_13818_BattleDesc = {
    Text = "Taux critique augmenté de 50 %, mais <FragileIconKeywords:fragile> pour 3 tours au début du combat"
  },
  RelicConfig_13818_Desc = {
    Text = "Taux critique augmenté de 50 %, mais <FragileIconKeywords:fragile> pour 3 tours au début du combat"
  },
  RelicConfig_13818_Name = {
    Text = "<RedQuality:Griffe étrange>"
  },
  RelicConfig_13818_StoryDesc = {
    Text = "Espèce indéfinissable"
  },
  RelicConfig_13819_BattleDesc = {
    Text = "En jouant une carte ayant un coût en arithmetica de 3 ou plus, tirez 1 carte et gagnez 1 en arithmetica"
  },
  RelicConfig_13819_Desc = {
    Text = "En jouant une carte ayant un coût en arithmetica de 3 ou plus, tirez 1 carte et gagnez 1 en arithmetica"
  },
  RelicConfig_13819_Name = {
    Text = "<OrangeQuality:☆Beauté perdue☆>"
  },
  RelicConfig_13819_StoryDesc = {
    Text = "Personne ne se souvient de sa beauté"
  },
  RelicConfig_13820_BattleDesc = {
    Text = "Chaque fois que vous gagnez une carte de symptôme, augmentez votre santé maximale de [Arg1] points"
  },
  RelicConfig_13820_Desc = {
    Text = "Chaque fois que vous gagnez une carte de symptôme, augmentez votre santé maximale de [Arg1] points"
  },
  RelicConfig_13820_Name = {
    Text = "<WhiteQuality:☆Préparation d'encens☆>"
  },
  RelicConfig_13820_StoryDesc = {
    Text = "\"Un arôme doux et séduisant.\""
  },
  RelicConfig_13821_BattleDesc = {
    Text = "Après avoir libéré l'exaltation, tirez 1 carte. Si vos points de vie sont inférieurs à 25%, tirez 1 carte supplémentaire"
  },
  RelicConfig_13821_Desc = {
    Text = "Après avoir libéré l'exaltation, tirez 1 carte. Si vos points de vie sont inférieurs à 25%, tirez 1 carte supplémentaire"
  },
  RelicConfig_13821_Name = {
    Text = "<OrangeQuality:Roue de lecture>"
  },
  RelicConfig_13821_StoryDesc = {
    Text = "Veuillez lire en toute sécurité"
  },
  RelicConfig_13822_BattleDesc = {
    Text = "Chaque fois que vous infligez des dégâts actifs par tour, augmentez de [Arg1] points le <TentacleInjurieIconKeywords:dégâts de tentacule> temporaire, jusqu'à 3 fois. Lorsque le maximum est atteint, générez 1 tentacule temporaire sans limite de tentacule"
  },
  RelicConfig_13822_Desc = {
    Text = "Chaque fois que vous infligez des dégâts actifs par tour, augmentez de [Arg1] points le <TentacleInjurieIconKeywords:dégâts de tentacule> temporaire, jusqu'à 3 fois. Lorsque le maximum est atteint, générez 1 tentacule temporaire sans limite de tentacule"
  },
  RelicConfig_13822_Name = {
    Text = "<OrangeQuality:Joie de la spirale>"
  },
  RelicConfig_13822_StoryDesc = {
    Text = "Seigneur du Sommeil, attends ton rêve"
  },
  RelicConfig_13823_BattleDesc = {
    Text = "Chaque [Arg1]ème carte de commandement que tu joues prendra effet 2 fois, puis retournera dans ta main"
  },
  RelicConfig_13823_Desc = {
    Text = "Chaque [Arg1]ème carte de commandement que tu joues prendra effet 2 fois, puis retournera dans ta main"
  },
  RelicConfig_13823_Name = {
    Text = "<OrangeQuality:Vin des étoiles+>"
  },
  RelicConfig_13823_StoryDesc = {
    Text = "Errant parmi les étoiles"
  },
  RelicConfig_13824_BattleDesc = {
    Text = "Au début de chaque tour, <DeathResistanceIconKeywords:résistance à la mort> augmente de 10 % (dans ce niveau, chaque fois que la résistance à la mort est déclenchée, la résistance à la mort obtenue est réduite de moitié). Lorsque <DeathResistanceIconKeywords:résistance à la mort> dépasse 100 %, <ProficientInRealmsIconKeywords:maîtrise des royaumes> augmente de 100."
  },
  RelicConfig_13824_Desc = {
    Text = "Au début de chaque tour, <DeathResistanceIconKeywords:résistance à la mort> augmente de 10 % (dans ce niveau, chaque fois que la résistance à la mort est déclenchée, la résistance à la mort obtenue est réduite de moitié). Lorsque <DeathResistanceIconKeywords:résistance à la mort> dépasse 100 %, <ProficientInRealmsIconKeywords:maîtrise des royaumes> augmente de 100."
  },
  RelicConfig_13824_Name = {
    Text = "<WhiteQuality:Larmes de sirène>"
  },
  RelicConfig_13824_StoryDesc = {
    Text = "Ne le mets pas dans l'eau"
  },
  RelicConfig_13825_BattleDesc = {
    Text = "Chaque consommation de 10 sigils noirs restaure [Arg1] points de vie"
  },
  RelicConfig_13825_Desc = {
    Text = "Chaque consommation de 10 sigils noirs restaure 1% de vie"
  },
  RelicConfig_13825_Name = {
    Text = "Racine inversée"
  },
  RelicConfig_13826_BattleDesc = {
    Text = "Lorsque vous jouez une carte de buff, une carte de symptôme ou une carte d'état, l'éveillé avec le moins d'Aliemus gagne 10 Aliemus."
  },
  RelicConfig_13826_Desc = {
    Text = "Lorsque vous jouez une carte de buff, une carte de symptôme ou une carte d'état, l'éveillé avec le moins d'Aliemus gagne 10 Aliemus."
  },
  RelicConfig_13826_Name = {
    Text = "<WhiteQuality:Album de timbres>"
  },
  RelicConfig_13826_StoryDesc = {
    Text = "Pensées quantifiées"
  },
  RelicConfig_13827_BattleDesc = {
    Text = "Après la collecte, obtenir 75 sigils noirs. Choisir une relique et la transformer en une relique maudite aléatoire"
  },
  RelicConfig_13827_Desc = {
    Text = "Après la collecte, obtenir 75 sigils noirs. Choisir une relique et la transformer en une relique maudite aléatoire"
  },
  RelicConfig_13827_Name = {
    Text = "<RedQuality:Stèle maudite>"
  },
  RelicConfig_13827_StoryDesc = {
    Text = "En caressant, on entend l'appel des profondeurs"
  },
  RelicConfig_13828_BattleDesc = {
    Text = "Lors de la première utilisation d'une carte de commandement entrant dans la pile de défausse par tour, la consommation d'arithmétique de cette carte temporaire est réduite de 1 et est mélangée dans la pile de pioche"
  },
  RelicConfig_13828_Desc = {
    Text = "Lors de la première utilisation d'une carte de commandement entrant dans la pile de défausse par tour, la consommation d'arithmétique de cette carte temporaire est réduite de 1 et est mélangée dans la pile de pioche"
  },
  RelicConfig_13828_Name = {
    Text = "<WhiteQuality:Phonographe muet>"
  },
  RelicConfig_13828_StoryDesc = {
    Text = "Sa voix est emportée par le vent"
  },
  RelicConfig_13829_BattleDesc = {
    Text = "Un trousseau de clés rouillées. Peut ouvrir des serrures"
  },
  RelicConfig_13829_Desc = {
    Text = "Un trousseau de clés rouillées. Peut ouvrir des serrures"
  },
  RelicConfig_13829_Name = {
    Text = "Clé rouillée"
  },
  RelicConfig_13830_BattleDesc = {
    Text = "Lors du rétablissement de vie, vous obtiendrez également [Arg1] points de bouclier. Après le début du 3ème tour, obtenez [Arg2] points <AlertIconKeywords:alerte>"
  },
  RelicConfig_13830_Desc = {
    Text = "Lors du rétablissement de vie, vous obtiendrez également [Arg1] points de bouclier. Après le début du 3ème tour, obtenez [Arg2] points <AlertIconKeywords:alerte>"
  },
  RelicConfig_13830_Name = {
    Text = "<WhiteQuality:Spécimen de papillon>"
  },
  RelicConfig_13830_StoryDesc = {
    Text = "Jusqu'à présent, il est profondément aimé par quelqu'un"
  },
  RelicConfig_13831_BattleDesc = {
    Text = "Chaque fois qu'une carte de commandement entre dans <DimensionalSpaceIconKeywords:espace ultra>, le réveilleur correspondant obtient 15 aliemus"
  },
  RelicConfig_13831_Desc = {
    Text = "Chaque fois qu'une carte de commandement entre dans <DimensionalSpaceIconKeywords:espace ultra>, le réveilleur correspondant obtient 15 aliemus"
  },
  RelicConfig_13831_Name = {
    Text = "<WhiteQuality:Ver du temps>"
  },
  RelicConfig_13831_StoryDesc = {
    Text = "Une montre de poche présente à la fois dans une horlogerie et un musée d'insectes.\nAprès l'année de l'Holocène, elle a été intégrée à la collection universitaire"
  },
  RelicConfig_13832_BattleDesc = {
    Text = "Après être entrée dans un tour Ultra, annulez votre état de <WeaknessIconKeywords:faiblesse> et de <FragileIconKeywords:fragile>, et appliquez <WeaknessIconKeywords:faiblesse> et <VulnerabilityIconKeywords:vulnérable> à tous les ennemis pendant 3 tours. Les dégâts finaux de tous les éveilleurs augmentent de 15 % ce tour-ci."
  },
  RelicConfig_13832_Desc = {
    Text = "Après être entrée dans un tour Ultra, annulez votre état de <WeaknessIconKeywords:Faiblesse> et de <FragileIconKeywords:Fragile>, et <WeaknessIconKeywords:Faiblesse> et <VulnerabilityIconKeywords:Vulnérable> tous les ennemis pendant 3 tours. Les dégâts finaux de tous les Éveilleurs augmentent de 15 % ce tour-ci."
  },
  RelicConfig_13832_Name = {
    Text = "<WhiteQuality:Chronomètre hypercorde>"
  },
  RelicConfig_13832_StoryDesc = {
    Text = "\"Oh non, la montre de poche s'est arrêtée.\""
  },
  RelicConfig_13833_BattleDesc = {
    Text = "Chaque fois qu'un dommage est infligé, appliquez [Arg1] couches <IntoxicationIconKeywords:poison> à la cible. Si le nombre d'activations dans ce combat atteint 25, déclenchez immédiatement <IntoxicationIconKeywords:poison> sur tous les ennemis"
  },
  RelicConfig_13833_Desc = {
    Text = "Chaque fois qu'un dommage est infligé, appliquez [Arg1] couches <IntoxicationIconKeywords:poison> à la cible. Si le nombre d'activations dans ce combat atteint 25, déclenchez immédiatement <IntoxicationIconKeywords:poison> sur tous les ennemis"
  },
  RelicConfig_13833_Name = {
    Text = "<OrangeQuality:☆Machine à coudre poussiéreuse☆>"
  },
  RelicConfig_13833_StoryDesc = {
    Text = "Une mère aimante, réparant les blessures du cœur"
  },
  RelicConfig_13834_BattleDesc = {
    Text = "Après chaque 5ème obtention d'un bouclier, obtenez simultanément <RetaliateIconKeywords:contre-attaque>, où la valeur de contre-attaque est égale à [Arg1]% des boucliers obtenus"
  },
  RelicConfig_13834_Desc = {
    Text = "Après chaque 5ème obtention d'un bouclier, obtenez simultanément <RetaliateIconKeywords:contre-attaque>, où la valeur de contre-attaque est égale à [Arg1]% des boucliers obtenus"
  },
  RelicConfig_13834_Name = {
    Text = "<OrangeQuality:Chapitre des sages>"
  },
  RelicConfig_13834_StoryDesc = {
    Text = "\"À quel point les humains sont fous, croyant aveuglément simplement parce que c'est ancien.\""
  },
  RelicConfig_13835_BattleDesc = {
    Text = "Piochez 1 carte au début du tour"
  },
  RelicConfig_13835_Desc = {
    Text = "Piochez 1 carte au début du tour"
  },
  RelicConfig_13835_Name = {
    Text = "<WhiteQuality:Boussole>"
  },
  RelicConfig_13835_StoryDesc = {
    Text = "Ce qui est indiqué n'est pas une direction, mais un champ magnétique"
  },
  RelicConfig_13836_BattleDesc = {
    Text = "Au début du combat, placez aléatoirement <DerivativeCardKeywords_3:« convulsion »> et <DerivativeCardKeywords_4:« perspicacité »> dans <DimensionalSpaceIconKeywords:Espace Hyperspatial> jusqu'à atteindre la limite. Après être entré dans un tour ultra, gagnez [Arg1] points de <PowerIconKeywords:force>."
  },
  RelicConfig_13836_Desc = {
    Text = "Au début du combat, placez aléatoirement <DerivativeCardKeywords_3:« convulsion »> et <DerivativeCardKeywords_4:« perspicacité »> dans <DimensionalSpaceIconKeywords:Espace Hyperspatial> jusqu'à atteindre la limite. Après être entré dans un tour ultra, gagnez [Arg1] points de <PowerIconKeywords:force>."
  },
  RelicConfig_13836_Name = {
    Text = "<RedQuality:Artefact d'Alfonso>"
  },
  RelicConfig_13836_StoryDesc = {
    Text = "Contrairement au destin capricieux, les étoiles suivent leurs propres lois"
  },
  RelicConfig_13837_BattleDesc = {
    Text = "Lors de la collecte, obtenir 100% de <DeathResistanceIconKeywords:résistance à la mort> (pour chaque fois que la résistance à la mort est déclenchée dans ce niveau, la résistance à la mort obtenue est réduite de moitié). Après avoir déclenché <DeathResistanceIconKeywords:résistance à la mort>, à chaque début de tour dans ce combat, récupérer [Arg1] points de PV."
  },
  RelicConfig_13837_Desc = {
    Text = "Lors de la collecte, obtenir 100% de <DeathResistanceIconKeywords:résistance à la mort> (pour chaque résistance à la mort déclenchée dans ce niveau, la résistance à la mort obtenue est réduite de moitié). Après avoir déclenché <DeathResistanceIconKeywords:résistance à la mort>, à chaque début de tour dans ce combat, récupérer [Arg1] points de PV."
  },
  RelicConfig_13837_Name = {
    Text = "<WhiteQuality:Respiration artificielle>"
  },
  RelicConfig_13837_StoryDesc = {
    Text = "Un must pour les explorateurs. Si vous en devenez trop dépendant, il fera partie de vous"
  },
  RelicConfig_13838_BattleDesc = {
    Text = "C'est un objet de quête sans effet 2"
  },
  RelicConfig_13838_Desc = {
    Text = "C'est un objet de quête sans effet 2"
  },
  RelicConfig_13838_Name = {
    Text = "Test de création de mission 2"
  },
  RelicConfig_13838_StoryDesc = {
    Text = "Nécessite une création avec contenu supplémentaire"
  },
  RelicConfig_13839_BattleDesc = {
    Text = "En jouant la dernière carte en main, piochez 2 cartes. Maximum 2 fois par tour"
  },
  RelicConfig_13839_Desc = {
    Text = "En jouant la dernière carte en main, piochez 2 cartes. Maximum 2 fois par tour"
  },
  RelicConfig_13839_Name = {
    Text = "<WhiteQuality:☆Gants magiques☆>"
  },
  RelicConfig_13839_StoryDesc = {
    Text = "\"N’aie pas peur, ce n'est qu'une illusion.\""
  },
  RelicConfig_13840_BattleDesc = {
    Text = "Tous les 3 tours, ajoute 1 niveau de <WeaknessIconKeywords:Faiblesse> à tous les ennemis. Infliger des dégâts à un ennemi <WeaknessIconKeywords:Faible> donne [Arg1] points de <PowerIconKeywords:Force> temporaire, jusqu'à 3 fois par tour"
  },
  RelicConfig_13840_Desc = {
    Text = "Tous les 3 tours, ajoute 1 niveau de <WeaknessIconKeywords:Symptôme : Affaiblir> à tous les ennemis. Infliger des Dommages à un ennemi avec <WeaknessIconKeywords:Symptôme : Affaiblir> donne [Arg1] points Temporaire de <PowerIconKeywords:FOR>, jusqu'à 3 fois par tour."
  },
  RelicConfig_13840_Name = {
    Text = "<WhiteQuality:Enfant terrible>"
  },
  RelicConfig_13840_StoryDesc = {
    Text = "Né de la pure méchanceté, même si ce n'était pas son souhait"
  },
  RelicConfig_13841_BattleDesc = {
    Text = "Tous les « coups » augmentent les dégâts critiques de 20%. Au début du combat, ajoutez 1 carte <DerivativeCardKeywords_40: « instant décisif »> à votre main"
  },
  RelicConfig_13841_Desc = {
    Text = "Tous les « coups » augmentent les dégâts critiques de 20%. Au début du combat, ajoutez 1 carte <DerivativeCardKeywords_40: « instant décisif »> à votre main"
  },
  RelicConfig_13841_Name = {
    Text = "<WhiteQuality:Instant de beauté>"
  },
  RelicConfig_13841_StoryDesc = {
    Text = "Préservez la beauté éphémère pour toujours"
  },
  RelicConfig_13842_BattleDesc = {
    Text = "Immunisez-vous contre des dégâts fatals non déclenchés par la résistance à la mort, restaurez [Arg1] points de vie et rendez cette relique inopérante pour toujours"
  },
  RelicConfig_13842_Desc = {
    Text = "Immunisez-vous contre des dégâts fatals non déclenchés par la résistance à la mort, restaurez [Arg1] points de vie et rendez cette relique inopérante pour toujours"
  },
  RelicConfig_13842_Name = {
    Text = "<OrangeQuality:Poupée de substitution>"
  },
  RelicConfig_13842_StoryDesc = {
    Text = "Hihi, hihi. Tu me dois quelque chose, non ?"
  },
  RelicConfig_13844_BattleDesc = {
    Text = "Lorsque tu infliges <WeaknessIconKeywords:faiblesse>, tu obtiens [Arg1] points de bouclier ; en infligeant <VulnerabilityIconKeywords:vulnérable>, tu obtiens [Arg2] points de <PowerIconKeywords:force> temporaire. Si ces deux effets sont déclenchés en un tour, tu obtiens en plus [Arg1] points de bouclier et [Arg2] points de <PowerIconKeywords:force> temporaire."
  },
  RelicConfig_13844_Desc = {
    Text = "Lorsque tu infliges <WeaknessIconKeywords:faiblesse>, tu obtiens [Arg1] points de bouclier ; en infligeant <VulnerabilityIconKeywords:vulnérable>, tu obtiens [Arg2] points de <PowerIconKeywords:force> temporaire. Si ces deux effets sont déclenchés en un tour, tu obtiens en plus [Arg1] points de bouclier et [Arg2] points de <PowerIconKeywords:force> temporaire."
  },
  RelicConfig_13844_Name = {
    Text = "<OrangeQuality:Cadre lourd>"
  },
  RelicConfig_13844_StoryDesc = {
    Text = "La dernière œuvre d'un artiste fou, où l'on dit qu'on peut voir son visage terrifié"
  },
  RelicConfig_13845_BattleDesc = {
    Text = "Lorsque tu épuises tes 1 dernier point de puissance arithmétique, tu obtiens 2 points de puissance. Peut être déclenché 2 fois par tour au maximum"
  },
  RelicConfig_13845_Desc = {
    Text = "Lorsque tu épuises tes 1 dernier point de puissance arithmétique, tu obtiens 2 points de puissance. Peut être déclenché 2 fois par tour au maximum"
  },
  RelicConfig_13845_Name = {
    Text = "<OrangeQuality:☆Machine différentielle argentée☆>"
  },
  RelicConfig_13845_StoryDesc = {
    Text = "\"Cela a changé l'histoire.\""
  },
  RelicConfig_13846_BattleDesc = {
    Text = "À chaque fois que vous perdez des points de vie, vous gagnez [Arg1] point(s) <PowerIconKeywords:pouvoir>, avec un maximum de 10 accumulations par combat. Quand le maximum est atteint, restaurez 25 % des points de vie perdus"
  },
  RelicConfig_13846_Desc = {
    Text = "À chaque fois que vous perdez des points de vie, vous gagnez [Arg1] point(s) <PowerIconKeywords:pouvoir>, avec un maximum de 10 accumulations par combat. Quand le maximum est atteint, restaurez 25 % des points de vie perdus"
  },
  RelicConfig_13846_Name = {
    Text = "<OrangeQuality:Suprême honneur>"
  },
  RelicConfig_13846_StoryDesc = {
    Text = "Un chat noir à poil court, élégant et mystérieux, est considéré comme une incarnation divine dans un lointain pays désertique. Mais le nom de cette divinité est aujourd'hui oublié.\nAdoré, vénéré, oublié, peut-être est-ce le destin des dieux"
  },
  RelicConfig_13847_BattleDesc = {
    Text = "Les dégâts infligés aux ennemis en état négatif augmentent de 20%, et le tueur gagne 20 folie"
  },
  RelicConfig_13847_Desc = {
    Text = "Les dégâts infligés aux ennemis en état négatif augmentent de 20%, et le tueur gagne 20 folie"
  },
  RelicConfig_13847_Name = {
    Text = "<OrangeQuality:Bâton du prêtre>"
  },
  RelicConfig_13847_StoryDesc = {
    Text = "Dévotion non autorisée"
  },
  RelicConfig_13848_BattleDesc = {
    Text = "Lors de la collecte, la maîtrise du royaume de l'équipe devient 150% de la valeur d'origine. Après avoir joué la 5ème carte d'ordre de chaque tour, tous les réveilleurs gagnent 20 points de folie"
  },
  RelicConfig_13848_Desc = {
    Text = "Lors de la collecte, la maîtrise du royaume de l'équipe devient 150% de la valeur d'origine. Après avoir joué la 5ème carte d'ordre de chaque tour, tous les réveilleurs gagnent 20 points de folie"
  },
  RelicConfig_13848_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Impur\">"
  },
  RelicConfig_13849_BattleDesc = {
    Text = "Après avoir infligé des dégâts pour la 3ème fois par tour, gagnez [Arg1] points de bouclier. Après avoir infligé des dégâts pour la 6ème fois par tour, gagnez [Arg2] points de <PowerIconKeywords:pouvoir>"
  },
  RelicConfig_13849_Desc = {
    Text = "Après avoir infligé des dégâts pour la 3ème fois par tour, gagnez [Arg1] points de bouclier. Après avoir infligé des dégâts pour la 6ème fois par tour, gagnez [Arg2] points de <PowerIconKeywords:pouvoir>"
  },
  RelicConfig_13849_Name = {
    Text = "<WhiteQuality:Sortie de secours>"
  },
  RelicConfig_13849_StoryDesc = {
    Text = "On dirait qu'il n'a pas pu s'échapper non plus"
  },
  RelicConfig_13851_BattleDesc = {
    Text = "À chaque <DevouredIconKeywords:dévoration>, vole [Arg1] points de <PowerIconKeywords:force> temporaire à tous les ennemis"
  },
  RelicConfig_13851_Desc = {
    Text = "À chaque <DevouredIconKeywords:dévoration>, vole [Arg1] points de <PowerIconKeywords:force> temporaire à tous les ennemis"
  },
  RelicConfig_13851_Name = {
    Text = "<OrangeQuality:Main leste>"
  },
  RelicConfig_13851_StoryDesc = {
    Text = "L'arme parfaite pour dévaliser et tuer"
  },
  RelicConfig_13852_BattleDesc = {
    Text = "Lors de la collecte, choisir un réveilleur pour l'éveiller, le coût en arithmétique de sa carte d'éveil diminue de manière permanente de 1"
  },
  RelicConfig_13852_Desc = {
    Text = "Lors de la collecte, choisir un réveilleur pour l'éveiller, le coût en arithmétique de sa carte d'éveil diminue de manière permanente de 1"
  },
  RelicConfig_13852_Name = {
    Text = "<WhiteQuality:Temps de Pâques>"
  },
  RelicConfig_13852_StoryDesc = {
    Text = "Profitez-en, mais ne le mangez pas"
  },
  RelicConfig_13853_BattleDesc = {
    Text = "Chaque fois que vous infligez des Dommages, gagnez [Arg1] points Temporaire de <RetaliateIconKeywords:Contre-attaque>, pouvant être déclenché un maximum de 5 fois par tour. Lors du cinquième déclenchement, ajoutez une <DerivativeCardKeywords_4:« Clairvoyance »> à la Pioche."
  },
  RelicConfig_13853_Desc = {
    Text = "Chaque fois que vous infligez des Dommages, gagnez [Arg1] points Temporaire de <RetaliateIconKeywords:Contre-attaque>, pouvant être déclenché un maximum de 5 fois par tour. Lors du cinquième déclenchement, ajoutez une <DerivativeCardKeywords_4:« Clairvoyance »> à la Pioche."
  },
  RelicConfig_13853_Name = {
    Text = "<WhiteQuality:Couteau sacrificiel perdu>"
  },
  RelicConfig_13853_StoryDesc = {
    Text = "Dague à lame courbée, souvent utilisée dans les rituels"
  },
  RelicConfig_13854_BattleDesc = {
    Text = "Au début du tour, tire 2 cartes, et obtient 2 points de puissance de calcul. Chaque fois que tu tires une carte de commande ou réveille de gnose, modifie aléatoirement sa consommation de puissance de calcul (0-4)"
  },
  RelicConfig_13854_Desc = {
    Text = "Au début du tour, tire 2 cartes, et obtient 2 points de puissance de calcul. Chaque fois que tu tires une carte de commande ou réveille de gnose, modifie aléatoirement sa consommation de puissance de calcul (0-4)"
  },
  RelicConfig_13854_Name = {
    Text = "<RedQuality:chapeau magique>"
  },
  RelicConfig_13854_StoryDesc = {
    Text = "Bienvenue au cirque féerique de Mademoiselle Casiah ! Faites attention, ne touchez pas aux accessoires de magie sans raison. Si vous vous faites mordre par accident, ce serait vraiment désastreux. \n Après tout, la dernière fois qu'il a goûté au sang, les conséquences étaient vraiment horribles. \n\n Le haut-de-forme a cligné des yeux, comme s'il allait éclore à tout moment."
  },
  RelicConfig_13855_BattleDesc = {
    Text = "Au début du tour et chaque fois que des PV sont récupérés, gagnez [Arg1] <RetaliateIconKeywords:Contre-attaque>. Peut se produire jusqu'à 3 fois par tour. Lorsque la limite est atteinte, déclenchez une <RetaliateIconKeywords:Contre-attaque> à 100% contre tous les ennemis."
  },
  RelicConfig_13855_Desc = {
    Text = "Au début du tour et chaque fois que des PV sont récupérés, gagnez [Arg1] <RetaliateIconKeywords:Contre-attaque>. Peut se produire jusqu'à 3 fois par tour. Lorsque la limite est atteinte, déclenchez une <RetaliateIconKeywords:Contre-attaque> à 100% contre tous les ennemis."
  },
  RelicConfig_13855_Name = {
    Text = "<OrangeQuality:Petite boîte à musique>"
  },
  RelicConfig_13855_StoryDesc = {
    Text = "Il y a de nombreuses collections dans le manoir de Dexter. Avant d'être cassée, la Petite boîte à musique était le jouet préféré de Mademoiselle Dexter. \n Le temps passe, et lorsque Mademoiselle Dexter la retrouve à nouveau, ses rouages sont lâches, la musique est déformée, mais elle continue de tourner."
  },
  RelicConfig_13856_BattleDesc = {
    Text = "Augmente les dégâts critiques de 15 %. Augmente le taux critique de \"Frappe\" de 40 %"
  },
  RelicConfig_13856_Desc = {
    Text = "Augmente les dégâts critiques de 15 %. Augmente le taux critique de \"Frappe\" de 40 %"
  },
  RelicConfig_13856_Name = {
    Text = "<WhiteQuality:Bec de corbeau blanc>"
  },
  RelicConfig_13856_StoryDesc = {
    Text = "Rien n'est secret devant lui"
  },
  RelicConfig_13857_BattleDesc = {
    Text = "Après avoir libéré l'exaltation, obtenez [Arg1] points de <RetaliateIconKeywords:comptoir>. Si cela déclenche pour la 6ème fois dans cette bataille, doublez votre <RetaliateIconKeywords:comptoir>"
  },
  RelicConfig_13857_Desc = {
    Text = "Après avoir libéré l'exaltation, obtenez [Arg1] points de <RetaliateIconKeywords:comptoir>. Si cela déclenche pour la 6ème fois dans cette bataille, doublez votre <RetaliateIconKeywords:comptoir>"
  },
  RelicConfig_13857_Name = {
    Text = "<OrangeQuality:☆Sextant☆>"
  },
  RelicConfig_13857_StoryDesc = {
    Text = "Ce que tu guides, ce ne sont que des chemins erronés"
  },
  RelicConfig_13858_BattleDesc = {
    Text = "Pigez 1 carte supplémentaire par tour, obtenez 1 point d'arithmétique"
  },
  RelicConfig_13858_Desc = {
    Text = "Pigez 1 carte supplémentaire par tour, obtenez 1 point d'arithmétique"
  },
  RelicConfig_13858_Name = {
    Text = "<OrangeQuality:☆Beaux souvenirs☆>"
  },
  RelicConfig_13858_StoryDesc = {
    Text = ": Quelqu'un est resté pour toujours cet été-là"
  },
  RelicConfig_13859_BattleDesc = {
    Text = "Au début du tour, tirez 1 carte. Au début de la bataille, mélangez 1 <DerivativeCardKeywords_4:\"Inspiration\"> dans votre deck. Chaque bataille augmentera le nombre de cartes <DerivativeCardKeywords_4:\"Inspiration\"> mélangées dans votre deck de 1, jusqu'à un maximum de 3 fois."
  },
  RelicConfig_13859_Desc = {
    Text = "Au début du tour, tirez 1 carte. Au début de la bataille, mélangez 1 <DerivativeCardKeywords_4:\"Inspiration\"> dans votre deck. Chaque bataille augmentera le nombre de cartes <DerivativeCardKeywords_4:\"Inspiration\"> mélangées dans votre deck de 1, jusqu'à un maximum de 3 fois."
  },
  RelicConfig_13859_Name = {
    Text = "<OrangeQuality:Miroir de Prasno>"
  },
  RelicConfig_13859_StoryDesc = {
    Text = "Jeux de lumière et d'ombre"
  },
  RelicConfig_13860_BattleDesc = {
    Text = "Après avoir joué deux cartes du même éveillé, cet éveillé gagne 8 points de folie"
  },
  RelicConfig_13860_Desc = {
    Text = "Après avoir joué deux cartes du même éveillé, cet éveillé gagne 8 points de folie"
  },
  RelicConfig_13860_Name = {
    Text = "<WhiteQuality:Chronomètre>"
  },
  RelicConfig_13860_StoryDesc = {
    Text = "L'une des inventions les plus maléfiques de l'humanité"
  },
  RelicConfig_13861_BattleDesc = {
    Text = "Lors de la collecte, choisir une carte de réveilleur et réduire son coût en arithmétique de 1, et la traiter comme « frappe »"
  },
  RelicConfig_13861_Desc = {
    Text = "Lors de la collecte, choisir une carte de réveilleur et réduire son coût en arithmétique de 1, et la traiter comme « frappe »"
  },
  RelicConfig_13861_Name = {
    Text = "<OrangeQuality:Erreur fortuite>"
  },
  RelicConfig_13861_StoryDesc = {
    Text = "Riez à gorge déployée !"
  },
  RelicConfig_13862_BattleDesc = {
    Text = "Après ramassage, perdez définitivement [Arg1] <PowerIconKeywords:force>. Chaque fois que vous infligez des dégâts, récupérez [Arg2] points de vie, jusqu'à 6 fois par tour"
  },
  RelicConfig_13862_Desc = {
    Text = "Après ramassage, perdez définitivement [Arg1] <PowerIconKeywords:force>. Chaque fois que vous infligez des dégâts, récupérez [Arg2] points de vie, jusqu'à 6 fois par tour"
  },
  RelicConfig_13862_Name = {
    Text = "<RedQuality:Baiser de la lamproie>"
  },
  RelicConfig_13862_StoryDesc = {
    Text = "Tu veux un baiser profond ? Un qui te tue"
  },
  RelicConfig_13863_BattleDesc = {
    Text = "Au premier tour de chaque combat, obtenez 3 points d'arithmétique"
  },
  RelicConfig_13863_Desc = {
    Text = "Au premier tour de chaque combat, obtenez 3 points d'arithmétique"
  },
  RelicConfig_13863_Name = {
    Text = "<WhiteQuality:miroir de montre de poche>"
  },
  RelicConfig_13863_StoryDesc = {
    Text = "Les souvenirs sont figés dans le temps passé, enfouis au fond du noir"
  },
  RelicConfig_13864_BattleDesc = {
    Text = "Après avoir joué la première carte de commandement chaque tour, mettez une carte « attaque » du réveilleur correspondant dans votre main et donnez-lui <NothingnessIconKeywords:illusion> et <DepleteIconKeywords:épuiser>"
  },
  RelicConfig_13864_Desc = {
    Text = "Après avoir joué la première carte de commandement chaque tour, mettez une carte « attaque » du réveilleur correspondant dans votre main et donnez-lui <NothingnessIconKeywords:illusion> et <DepleteIconKeywords:épuiser>"
  },
  RelicConfig_13864_Name = {
    Text = "<WhiteQuality:Essieu moderne>"
  },
  RelicConfig_13864_StoryDesc = {
    Text = ": De la campagne à la ville, de la catastrophe à la renaissance"
  },
  RelicConfig_13865_BattleDesc = {
    Text = "Après avoir joué la première carte de commandement chaque tour, mettez une carte « défense » du réveilleur correspondant dans votre main et ajoutez <NothingnessIconKeywords:illusion> et <DepleteIconKeywords:épuiser>"
  },
  RelicConfig_13865_Desc = {
    Text = "Après avoir joué la première carte de commandement chaque tour, mettez une carte « défense » du réveilleur correspondant dans votre main et ajoutez <NothingnessIconKeywords:illusion> et <DepleteIconKeywords:épuiser>"
  },
  RelicConfig_13865_Name = {
    Text = "<WhiteQuality:Prélude silencieux>"
  },
  RelicConfig_13865_StoryDesc = {
    Text = "Le violon du célèbre violoniste Eric Eckstein.\nAujourd'hui, il ne peut plus être joué"
  },
  RelicConfig_13866_BattleDesc = {
    Text = "Tous les 3 tours, ajoute 1 niveau de <VulnerabilityIconKeywords:Vulnérabilité> à tous les ennemis. Infliger des dégâts à un ennemi <VulnerabilityIconKeywords:Vulnérable> lui fait perdre [Arg1] points de <PowerIconKeywords:Force> temporaire, jusqu'à 3 fois par tour"
  },
  RelicConfig_13866_Desc = {
    Text = "Tous les 3 tours, ajoute 1 niveau de <VulnerabilityIconKeywords:Vulnérabilité> à tous les ennemis. Infliger des dégâts à un ennemi <VulnerabilityIconKeywords:Vulnérable> lui fait perdre [Arg1] points de <PowerIconKeywords:Force> temporaire, jusqu'à 3 fois par tour"
  },
  RelicConfig_13866_Name = {
    Text = "<WhiteQuality:Sacrifice du printemps>"
  },
  RelicConfig_13866_StoryDesc = {
    Text = "Dans les rires de la nuit, la silhouette du canoë glisse librement sur le lac"
  },
  RelicConfig_13867_BattleDesc = {
    Text = "Limite de cartes à main augmentée de 3, mais le nombre de cartes tirées par tour est réduit de 1. À la fin du tour, défaussez toutes les cartes de symptôme et d'état dans votre main, conservez les autres"
  },
  RelicConfig_13867_Desc = {
    Text = "Limite de cartes à main augmentée de 3, mais le nombre de cartes tirées par tour est réduit de 1. À la fin du tour, défaussez toutes les cartes de symptôme et d'état dans votre main, conservez les autres"
  },
  RelicConfig_13867_Name = {
    Text = "<RedQuality:Gravure de conscience>"
  },
  RelicConfig_13867_StoryDesc = {
    Text = "Une ancienne tribu croyait fermement que graver des symboles spéciaux sur le crâne des morts pouvait retenir leur âme pour une compagnie éternelle"
  },
  RelicConfig_13868_BattleDesc = {
    Text = "Après avoir libéré 4 exaltations, la consommation des cartes de toute votre main en arithmétique est réduite de 1"
  },
  RelicConfig_13868_Desc = {
    Text = "Après avoir libéré 4 exaltations, la consommation des cartes de toute votre main en arithmétique est réduite de 1"
  },
  RelicConfig_13868_Name = {
    Text = "<WhiteQuality:☆Plan d'évasion☆>"
  },
  RelicConfig_13868_StoryDesc = {
    Text = "\"Après l'embarquement, veuillez d'abord localiser la sortie de secours la plus proche de votre cabine.\""
  },
  RelicConfig_13869_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:Maîtrise des Royaumes> +100. Chaque dégât actif augmente les dégâts de tentacule de [Arg1], chaque dégât de tentacule donne [Arg2] bouclier, max 6 fois/tour"
  },
  RelicConfig_13869_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Maîtrise des Royaumes> +100. Chaque dégât actif augmente les dégâts de tentacule de [Arg1], chaque dégât de tentacule donne [Arg2] bouclier, max 6 fois/tour"
  },
  RelicConfig_13869_Name = {
    Text = "<OrangeQuality:Pendule Chrono \"Cauchemar\">"
  },
  RelicConfig_13870_BattleDesc = {
    Text = "Chaque fois que 1 point d'arithmétique est consommé, le réveilleur correspondant obtient 2 points de colère"
  },
  RelicConfig_13870_Desc = {
    Text = "Chaque fois que 1 point d'arithmétique est consommé, le réveilleur correspondant obtient 2 points de colère"
  },
  RelicConfig_13870_Name = {
    Text = "<WhiteQuality:Ruban à boucle argentée>"
  },
  RelicConfig_13870_StoryDesc = {
    Text = "Le ruban trouvé sur les lieux du crime a été déchiré en deux par une force externe.\nUn morceau est tombé du ciel, atterrissant dans la paume de la fille"
  },
  RelicConfig_13871_BattleDesc = {
    Text = "Au début de chaque tour, tous les réveilleurs gagnent 10 points de folie. La santé max est réduite de 30%"
  },
  RelicConfig_13871_Desc = {
    Text = "Au début de chaque tour, tous les réveilleurs gagnent 10 points de folie. La santé max est réduite de 30%"
  },
  RelicConfig_13871_Name = {
    Text = "<RedQuality:Apparence de cauchemar>"
  },
  RelicConfig_13871_StoryDesc = {
    Text = "Attention, le sommeil indulgent peut tout engloutir sans prévenir"
  },
  RelicConfig_13873_BattleDesc = {
    Text = "Après avoir joué « <ExaltIconKeywords:réveil> », retirez tous les boucliers des ennemis"
  },
  RelicConfig_13873_Desc = {
    Text = "Après avoir joué « <ExaltIconKeywords:réveil> », retirez tous les boucliers des ennemis"
  },
  RelicConfig_13873_Name = {
    Text = "Miroir noir"
  },
  RelicConfig_13874_BattleDesc = {
    Text = "Au début du tour impair, si le nombre de cartes restantes est de 0, piochez 2 cartes ; au début du tour pair, si le nombre d'arithmétique restante est de 0, obtenez 2 points d'arithmétique"
  },
  RelicConfig_13874_Desc = {
    Text = "Au début du tour impair, si le nombre de cartes restantes est de 0, piochez 2 cartes ; au début du tour pair, si le nombre d'arithmétique restante est de 0, obtenez 2 points d'arithmétique"
  },
  RelicConfig_13874_Name = {
    Text = "Guide d'or altéré"
  },
  RelicConfig_13875_BattleDesc = {
    Text = "Après avoir joué « attaque » et « défense », le réveilleur correspondant reçoit 35 aliemus. Cependant, leur coût en arithmetica augmente de 1"
  },
  RelicConfig_13875_Desc = {
    Text = "Après avoir joué « attaque » et « défense », le réveilleur correspondant reçoit 35 aliemus. Cependant, leur coût en arithmetica augmente de 1"
  },
  RelicConfig_13875_Name = {
    Text = "<RedQuality:Visage mutilé>"
  },
  RelicConfig_13875_StoryDesc = {
    Text = "Visage de qui, figé dans la terreur, dans le temps"
  },
  RelicConfig_13877_BattleDesc = {
    Text = "Après avoir obtenu le 2e Bouclier du personnage à chaque tour, gagnez [Arg1] <plural value=\"[Arg1]\" singular=\"charge\" plural=\"charges\"> de <RetaliateIconKeywords:Contre-attaque>. Après avoir obtenu le 4e Bouclier du personnage à chaque tour, déclenchez une <RetaliateIconKeywords:Contre-attaque> à 100% contre tous les ennemis."
  },
  RelicConfig_13877_Desc = {
    Text = "Après avoir obtenu le 2e Bouclier du personnage à chaque tour, gagnez [Arg1] <plural value=\"[Arg1]\" singular=\"charge\" plural=\"charges\"> de <RetaliateIconKeywords:Contre-attaque>. Après avoir obtenu le 4e Bouclier du personnage à chaque tour, déclenchez une <RetaliateIconKeywords:Contre-attaque> à 100% contre tous les ennemis."
  },
  RelicConfig_13877_Name = {
    Text = "<WhiteQuality:Franc-parler>"
  },
  RelicConfig_13877_StoryDesc = {
    Text = "Il a transmis d'innombrables secrets, actifs ou passifs"
  },
  RelicConfig_13878_BattleDesc = {
    Text = "La sixième carte de commandement jouée revient de la pile de défausse à votre main"
  },
  RelicConfig_13878_Desc = {
    Text = "La sixième carte de commandement jouée revient de la pile de défausse à votre main"
  },
  RelicConfig_13878_Name = {
    Text = "<OrangeQuality:Dans la lumière du crépuscule>"
  },
  RelicConfig_13878_StoryDesc = {
    Text = "Prenons une photo ensemble ! Ressentez la vraie douleur"
  },
  RelicConfig_13879_BattleDesc = {
    Text = "Après avoir libéré 5 exaltations, faites en sorte que le réveilleur qui libère l'exalter obtienne 100 de folie"
  },
  RelicConfig_13879_Desc = {
    Text = "Après avoir libéré 5 exaltations, faites en sorte que le réveilleur qui libère l'exalter obtienne 100 de folie"
  },
  RelicConfig_13879_Name = {
    Text = "<OrangeQuality:Petit berceau>"
  },
  RelicConfig_13879_StoryDesc = {
    Text = "Portant espoir, bénédictions et amour"
  },
  RelicConfig_13880_BattleDesc = {
    Text = "Obtenez [Arg1] points de bouclier en infligeant des dégâts actifs. En soignant, gagnez [Arg2] points de <PowerIconKeywords:force> temporaire"
  },
  RelicConfig_13880_Desc = {
    Text = "Obtenez [Arg1] points de bouclier en infligeant des dégâts actifs. En soignant, gagnez [Arg2] points de <PowerIconKeywords:force> temporaire"
  },
  RelicConfig_13880_Name = {
    Text = "<OrangeQuality:Notre maison>"
  },
  RelicConfig_13880_StoryDesc = {
    Text = "Ils étaient ensemble avant, et ils seront toujours ensemble. Ils sont une famille aimante"
  },
  RelicConfig_13881_BattleDesc = {
    Text = "Au début du tour impair, obtenez [Arg1] points temporaires <PowerIconKeywords:pouvoir>. Au début du tour pair, obtenez [Arg2] points temporaires <AlertIconKeywords:alerte>"
  },
  RelicConfig_13881_Desc = {
    Text = "Au début du tour impair, obtenez [Arg1] points temporaires <PowerIconKeywords:pouvoir>. Au début du tour pair, obtenez [Arg2] points temporaires <AlertIconKeywords:alerte>"
  },
  RelicConfig_13881_Name = {
    Text = "<WhiteQuality:Poupée jumelle>"
  },
  RelicConfig_13881_StoryDesc = {
    Text = "Les jumeaux sont un cadeau de l'ancien temps, une parabole pour l'avenir"
  },
  RelicConfig_13882_BattleDesc = {
    Text = "Le réveilleur correspondant qui joue la première carte de commandement de chaque tour obtient 20 points de folie à la fin du tour; si vous avez en même temps la relique « esprit dévoué », faites également gagner 5 points de folie aux autres réveilleurs"
  },
  RelicConfig_13882_Desc = {
    Text = "Le réveilleur correspondant qui joue la première carte de commandement de chaque tour obtient 20 points de folie à la fin du tour; si vous avez en même temps la relique « esprit dévoué », faites également gagner 5 points de folie aux autres réveilleurs"
  },
  RelicConfig_13882_Name = {
    Text = "<WhiteQuality:Statue de la mère>"
  },
  RelicConfig_13882_StoryDesc = {
    Text = "\"Je te donnerai tout, tout ce que tu veux, s'il te plaît, laisse-le partir.\""
  },
  RelicConfig_13883_BattleDesc = {
    Text = "Chaque fois qu'un éveillé effectue une <DevouredIconKeywords: dévoration>, les autres éveillés gagnent 10 folie"
  },
  RelicConfig_13883_Desc = {
    Text = "Chaque fois qu'un éveillé effectue une <DevouredIconKeywords: dévoration>, les autres éveillés gagnent 10 folie"
  },
  RelicConfig_13883_Name = {
    Text = "<OrangeQuality:Douce rêverie>"
  },
  RelicConfig_13883_StoryDesc = {
    Text = "Le jour de la métamorphose sera ta fin"
  },
  RelicConfig_13884_BattleDesc = {
    Text = "\"Frappe\" applique [Arg1] piles de <IntoxicationIconKeywords:Poison> à tous les ennemis."
  },
  RelicConfig_13884_Desc = {
    Text = "\"Frappe\" applique [Arg1] piles de <IntoxicationIconKeywords:Poison> à tous les ennemis."
  },
  RelicConfig_13884_Name = {
    Text = "<WhiteQuality:Neurotoxine>"
  },
  RelicConfig_13884_StoryDesc = {
    Text = "Extraction, raffinement"
  },
  RelicConfig_13885_BattleDesc = {
    Text = "Au début de la bataille, mettez 1 <DerivativeCardKeywords_1:\"Écho des Ombres\"> dans votre main. S'il s'agit d'une bataille de boss, gagnez un 1 supplémentaire <DerivativeCardKeywords_1:\"Écho des Ombres\">."
  },
  RelicConfig_13885_Desc = {
    Text = "Au début de la bataille, mettez 1 <DerivativeCardKeywords_1:\"Écho des Ombres\"> dans votre main. S'il s'agit d'une bataille de boss, gagnez un 1 supplémentaire <DerivativeCardKeywords_1:\"Écho des Ombres\">."
  },
  RelicConfig_13885_Name = {
    Text = "<WhiteQuality:Équipement de communication>"
  },
  RelicConfig_13885_StoryDesc = {
    Text = "Attendre ou craindre le moment où il sonnera"
  },
  RelicConfig_13886_BattleDesc = {
    Text = "Chaque fois que vous réinitialisez le deck, ajoutez 2 <DerivativeCardKeywords_6:\"Trident\"> et 1 <DerivativeCardKeywords_5:\"Parasol\"> à votre main."
  },
  RelicConfig_13886_Desc = {
    Text = "Chaque fois que vous réinitialisez le deck, ajoutez 2 <DerivativeCardKeywords_6:\"Trident\"> et 1 <DerivativeCardKeywords_5:\"Parasol\"> à votre main."
  },
  RelicConfig_13886_Name = {
    Text = "<WhiteQuality:☆Petit sac de dame☆>"
  },
  RelicConfig_13886_StoryDesc = {
    Text = "Il devrait contenir de la finesse, pas la mort"
  },
  RelicConfig_13887_BattleDesc = {
    Text = "Au début du tour, ajouter 1 <DerivativeCardKeywords_5: \"trident\"> à la main. Après avoir exalter, augmenter le pouvoir de toutes les <DerivativeCardKeywords_5: \"trident\"><PowerIconKeywords: pouvoir> dans votre main de [Arg2]"
  },
  RelicConfig_13887_Desc = {
    Text = "Au début du tour, ajouter 1 <DerivativeCardKeywords_5: \"trident\"> à la main. Après avoir exalter, augmenter le pouvoir de toutes les <DerivativeCardKeywords_5: \"trident\"><PowerIconKeywords: pouvoir> dans votre main de [Arg2]"
  },
  RelicConfig_13887_Name = {
    Text = "<WhiteQuality:trident>"
  },
  RelicConfig_13887_StoryDesc = {
    Text = "Peu importe comment on regarde, c'est très ordinaire"
  },
  RelicConfig_13888_BattleDesc = {
    Text = "Au début de la bataille, gagnez [Arg1] points de bouclier. Après avoir joué 7 fois « défense » dans ce combat, gagnez immédiatement [Arg2] points de bouclier. Après avoir joué 21 fois « défense » dans ce combat, gagnez 1 couche de barrière temporaire"
  },
  RelicConfig_13888_Desc = {
    Text = "Au début de la bataille, gagnez [Arg1] points de bouclier. Après avoir joué 7 fois « défense » dans ce combat, gagnez immédiatement [Arg2] points de bouclier. Après avoir joué 21 fois « défense » dans ce combat, gagnez 1 couche de barrière temporaire"
  },
  RelicConfig_13888_Name = {
    Text = "<WhiteQuality:Putney Morning Post>"
  },
  RelicConfig_13888_StoryDesc = {
    Text = "Votre compagnon de toilette le plus attentionné"
  },
  RelicConfig_13889_BattleDesc = {
    Text = "Après être entrée dans un tour d'ultra, obtenez 3 points d'arithmetica"
  },
  RelicConfig_13889_Desc = {
    Text = "Après être entrée dans un tour d'ultra, obtenez 3 points d'arithmetica"
  },
  RelicConfig_13889_Name = {
    Text = "<WhiteQuality:sablier lumineux>"
  },
  RelicConfig_13889_StoryDesc = {
    Text = "Un temps mesurable"
  },
  RelicConfig_13890_BattleDesc = {
    Text = "Au début de la bataille, appliquez pour 1 tour <WeaknessIconKeywords:faiblesse> et <VulnerabilityIconKeywords:vulnérable> à tous les ennemis, et s'il s'agit d'un combat de boss, appliquez 2 tours supplémentaires de <WeaknessIconKeywords:faiblesse> et <VulnerabilityIconKeywords:vulnérable>"
  },
  RelicConfig_13890_Desc = {
    Text = "Au début de la bataille, appliquez pour 1 tour <WeaknessIconKeywords:faiblesse> et <VulnerabilityIconKeywords:vulnérable> à tous les ennemis, et s'il s'agit d'un combat de boss, appliquez 2 tours supplémentaires de <WeaknessIconKeywords:faiblesse> et <VulnerabilityIconKeywords:vulnérable>"
  },
  RelicConfig_13890_Name = {
    Text = "<WhiteQuality:Camisa de force>"
  },
  RelicConfig_13890_StoryDesc = {
    Text = "Ce n'est pas seulement le temps qui peut décolorer les tissus, la peur et la douleur aussi"
  },
  RelicConfig_13891_BattleDesc = {
    Text = "Lorsque la première carte de commandement jouée chaque tour active l'effet de saut, piochez 1 carte, sinon obtenez 1 point d'arithmétique. Si c'est un tour ultra, activez les 2 effets ci-dessus"
  },
  RelicConfig_13891_Desc = {
    Text = "Lorsque la première carte de commandement jouée chaque tour active l'effet de saut, piochez 1 carte, sinon obtenez 1 point d'arithmétique. Si c'est un tour ultra, activez les 2 effets ci-dessus"
  },
  RelicConfig_13891_Name = {
    Text = "<OrangeQuality:Dispositif de saut>"
  },
  RelicConfig_13891_StoryDesc = {
    Text = "Projette une ombre déformée"
  },
  RelicConfig_13892_BattleDesc = {
    Text = "Gagnez une quête. Complétez la quête pour recevoir des récompenses. [Event Placeholder]"
  },
  RelicConfig_13892_Desc = {
    Text = "Gagnez une quête. Complétez la quête pour recevoir des récompenses. [Event Placeholder]"
  },
  RelicConfig_13892_Name = {
    Text = "<WhiteQuality:Journal usé>"
  },
  RelicConfig_13892_StoryDesc = {
    Text = "Un vieux carnet de notes, rempli de pages insérées, contient au moins une carte d'Elworth, des enregistrements d'expérimentation et du papier griffonné de marques de dissolution.\nLes premiers mots des notes sont soigneusement écrits, mais deviennent progressivement brouillons et désordonnés"
  },
  RelicConfig_13893_BattleDesc = {
    Text = "Après chaque 4e gain de bouclier, restaure 50% des PV équivalents au bouclier gagné"
  },
  RelicConfig_13893_Desc = {
    Text = "Après chaque 4e gain de bouclier, restaure 50% des PV équivalents au bouclier gagné"
  },
  RelicConfig_13893_Name = {
    Text = "<WhiteQuality:Sifflet de marin>"
  },
  RelicConfig_13893_StoryDesc = {
    Text = "À part les sirènes, le sifflet peut aussi appeler des tempêtes, des bottes puantes et des marins qui ne se sont pas lavés depuis cent jours"
  },
  RelicConfig_13894_BattleDesc = {
    Text = "Si tu as joué 4 cartes ou moins au tour précédent, la première carte jouée ce tour-ci s'active 2 fois"
  },
  RelicConfig_13894_Desc = {
    Text = "Si tu as joué 4 cartes ou moins au tour précédent, la première carte jouée ce tour-ci s'active 2 fois"
  },
  RelicConfig_13894_Name = {
    Text = "<OrangeQuality:☆Lanterne de cauchemar☆>"
  },
  RelicConfig_13894_StoryDesc = {
    Text = "Induire un rêve"
  },
  RelicConfig_13895_BattleDesc = {
    Text = "Chaque fois que vous perdez des PV, l'éveillé avec le moins de folie gagne 10 folie. Chaque 5 pertes de PV, récupérez 20% des PV perdus"
  },
  RelicConfig_13895_Desc = {
    Text = "Chaque fois que vous perdez des PV, l'éveillé avec le moins de folie gagne 10 folie. Chaque 5 pertes de PV, récupérez 20% des PV perdus"
  },
  RelicConfig_13895_Name = {
    Text = "<OrangeQuality:Pendule Chrono\"Analyse\">"
  },
  RelicConfig_13896_BattleDesc = {
    Text = "Augmente la puissance arithmetica de 2. Chaque fois que la pile de cartes est réinitialisée, ajoutez 1<DerivativeCardKeywords_9:« trébucher »> à la pile de tirage"
  },
  RelicConfig_13896_Desc = {
    Text = "Augmente la puissance arithmetica de 2. Chaque fois que la pile de cartes est réinitialisée, ajoutez 1<DerivativeCardKeywords_9:« trébucher »> à la pile de tirage"
  },
  RelicConfig_13896_Name = {
    Text = "<RedQuality:bougie noire>"
  },
  RelicConfig_13896_StoryDesc = {
    Text = "Brûler la lucidité, sombrer dans l'illusion"
  },
  RelicConfig_13897_BattleDesc = {
    Text = "<ExaltIconKeywords:Réveil de la gnose>"
  },
  RelicConfig_13897_Desc = {
    Text = "<ExaltIconKeywords:Réveil de la gnose>"
  },
  RelicConfig_13897_Name = {
    Text = "Miroir blanc"
  },
  RelicConfig_13898_BattleDesc = {
    Text = "Pour chaque réveilleur éveillé, <ProficientInRealmsIconKeywords:maîtrise des royaumes> augmente de 35. Après avoir joué « <ExaltIconKeywords:réveil> », obtenez aléatoirement 2 cartes de commande de ce réveilleur avec « épuiser »"
  },
  RelicConfig_13898_Desc = {
    Text = "Pour chaque réveilleur éveillé, <ProficientInRealmsIconKeywords:maîtrise des royaumes> augmente de 35. Après avoir joué « <ExaltIconKeywords:réveil> », obtenez aléatoirement 2 cartes de commande de ce réveilleur avec « épuiser »"
  },
  RelicConfig_13898_Name = {
    Text = "<OrangeQuality:Son oracle>"
  },
  RelicConfig_13898_StoryDesc = {
    Text = "Il a dit, n'aie pas peur"
  },
  RelicConfig_13899_BattleDesc = {
    Text = "Au début du tour, <ProficientInRealmsIconKeywords:maîtrise des royaumes> +50. Sans état négatif, <ProficientInRealmsIconKeywords:maîtrise des royaumes> +150"
  },
  RelicConfig_13899_Desc = {
    Text = "Au début du tour, <ProficientInRealmsIconKeywords:maîtrise des royaumes> +50. Sans état négatif, <ProficientInRealmsIconKeywords:maîtrise des royaumes> +150"
  },
  RelicConfig_13899_Name = {
    Text = "<WhiteQuality:☆\"Pour la Liberté\"☆>"
  },
  RelicConfig_13899_StoryDesc = {
    Text = "Une poignée de noyaux d'argent, rappelant des souvenirs"
  },
  RelicConfig_13900_BattleDesc = {
    Text = "Après avoir utilisé « exalter », le coût en arithmetica de toutes les cartes en main est -1"
  },
  RelicConfig_13900_Desc = {
    Text = "Après avoir utilisé « exalter », le coût en arithmetica de toutes les cartes en main est réduit de -1"
  },
  RelicConfig_13900_Name = {
    Text = "Lumière de la civilisation métamorphosée"
  },
  RelicConfig_13901_BattleDesc = {
    Text = "Chaque fois que vous jouez une carte d'instruction, obtenez [Arg2]% de <DeathResistanceIconKeywords:résistance à la mort> (chaque fois que la résistance à la mort est déclenchée dans ce niveau, la résistance à la mort obtenue est réduite de moitié). Si votre <DeathResistanceIconKeywords:résistance à la mort> est supérieure ou égale à 100%, vous obtenez [Arg1] points de <PowerIconKeywords:force> temporaire."
  },
  RelicConfig_13901_Desc = {
    Text = "Chaque fois que vous jouez 1 carte d'instruction, gagnez [Arg2]% de <DeathResistanceIconKeywords:résistance à la mort> (dans ce niveau, chaque fois que la résistance à la mort est déclenchée, la résistance à la mort obtenue est réduite de moitié). Si votre <DeathResistanceIconKeywords:résistance à la mort> est supérieure ou égale à 100%, vous obtenez à la place [Arg1] points de <PowerIconKeywords:force> temporaire."
  },
  RelicConfig_13901_Name = {
    Text = "<OrangeQuality:Peau de serpent>"
  },
  RelicConfig_13901_StoryDesc = {
    Text = "Renaissance de la mue mutilée"
  },
  RelicConfig_13902_BattleDesc = {
    Text = "Au début du tour, gagnez [Arg2] Bouclier du personnage. En fin de tour, inflige <FixedDamage:DGT Purs> égaux à [Arg1]% de votre Bouclier du personnage actuel à un ennemi aléatoire. L'effet de DGT est doublé en Combat de Chef."
  },
  RelicConfig_13902_Desc = {
    Text = "Au début du tour, gagnez [Arg2] Bouclier du personnage. En fin de tour, inflige <FixedDamage:DGT Purs> égaux à [Arg1]% de votre Bouclier du personnage actuel à un ennemi aléatoire. L'effet de DGT est doublé en Combat de Chef."
  },
  RelicConfig_13902_Name = {
    Text = "<WhiteQuality:Guide en or>"
  },
  RelicConfig_13902_StoryDesc = {
    Text = "Ouvre-le lorsque tu es perdu, mais fais attention - sa couronne solaire ne doit pas être exposée à la lumière du jour"
  },
  RelicConfig_13904_BattleDesc = {
    Text = "Masquer l'intention des monstres. Gagnez 1 point d'arithmetica par tour et piochez 1 carte"
  },
  RelicConfig_13904_Desc = {
    Text = "Masquer l'intention des monstres. Gagnez 1 point d'arithmetica par tour et piochez 1 carte"
  },
  RelicConfig_13904_Name = {
    Text = "<RedQuality:Carillon envoûtant>"
  },
  RelicConfig_13904_StoryDesc = {
    Text = "Ding ling ling, ding ling ling"
  },
  RelicConfig_13905_BattleDesc = {
    Text = "Après le début du combat, gagnez [Arg2] couches <RetaliateIconKeywords: comptoir>, jouez « défense » pour obtenir [Arg1] couches <RetaliateIconKeywords: comptoir>"
  },
  RelicConfig_13905_Desc = {
    Text = "Après le début du combat, gagnez [Arg2] couches <RetaliateIconKeywords: comptoir>, jouez « défense » pour obtenir [Arg1] couches <RetaliateIconKeywords: comptoir>"
  },
  RelicConfig_13905_Name = {
    Text = "<WhiteQuality:Gilet d'ortie>"
  },
  RelicConfig_13905_StoryDesc = {
    Text = "Impossible d'identifier le liquide contaminé"
  },
  RelicConfig_13906_BattleDesc = {
    Text = "C'est un objet de quête hebdomadaire sans effet 4"
  },
  RelicConfig_13906_Desc = {
    Text = "C'est un objet de quête hebdomadaire sans effet 4"
  },
  RelicConfig_13906_Name = {
    Text = "Défi quotidien Création hebdomadaire 4"
  },
  RelicConfig_13907_BattleDesc = {
    Text = "Au début du tour, si plus de 3 cartes ont été jouées au tour précédent, piochez 2 cartes"
  },
  RelicConfig_13907_Desc = {
    Text = "Au début du tour, si plus de 3 cartes ont été jouées au tour précédent, piochez 2 cartes"
  },
  RelicConfig_13907_Name = {
    Text = "<WhiteQuality:Portefeuille neuf>"
  },
  RelicConfig_13907_StoryDesc = {
    Text = "Un portefeuille en cuir portant le blason de l'université de Mythag.\nIl est maintenant vide, ne contenant rien"
  },
  RelicConfig_13908_BattleDesc = {
    Text = "Après avoir utilisé « exalter », le réveilleur appartient à [Arg1] points de folie"
  },
  RelicConfig_13908_Desc = {
    Text = "Après avoir utilisé « exalter », le réveilleur appartient à [Arg1] points de folie"
  },
  RelicConfig_13908_Name = {
    Text = "Voile du Dieu Inconnu Métamorphosé"
  },
  RelicConfig_13909_BattleDesc = {
    Text = "Après avoir libéré l'exalter, perdez 8% de votre vie actuelle, volez à tous les ennemis [Arg1] points de <PowerIconKeywords: pouvoir> temporaire, si un seul ennemi, volez en plus [Arg2] points de <PowerIconKeywords: pouvoir> temporaire"
  },
  RelicConfig_13909_Desc = {
    Text = "Après avoir libéré l'exalter, perdez 8% de votre vie actuelle, volez à tous les ennemis [Arg1] points de <PowerIconKeywords: pouvoir> temporaire, si un seul ennemi, volez en plus [Arg2] points de <PowerIconKeywords: pouvoir> temporaire"
  },
  RelicConfig_13909_Name = {
    Text = "<RedQuality:Oiseau du rituel funeste>"
  },
  RelicConfig_13909_StoryDesc = {
    Text = "Un cadavre desséché émet un cri"
  },
  RelicConfig_13910_BattleDesc = {
    Text = "Après avoir libéré l'exaltation de la folie, le réveilleur correspondant obtient 10 de folie et [Arg1] points de bouclier"
  },
  RelicConfig_13910_Desc = {
    Text = "Après avoir libéré l'exaltation de la folie, le réveilleur correspondant obtient 10 de folie et [Arg1] points de bouclier"
  },
  RelicConfig_13910_Name = {
    Text = "<OrangeQuality:Voile du dieu sans nom>"
  },
  RelicConfig_13910_StoryDesc = {
    Text = "Ne pas regarder directement le dieu"
  },
  RelicConfig_13911_BattleDesc = {
    Text = "Le réveilleur correspondant qui joue la dernière carte de commandement de chaque tour obtient 20 points de folie à la fin du tour, et si vous avez en même temps la relique « Statue Maternelle », faites également gagner 5 points de folie aux autres réveilleurs"
  },
  RelicConfig_13911_Desc = {
    Text = "Le réveilleur correspondant qui joue la dernière carte de commandement de chaque tour obtient 20 points de folie à la fin du tour, et si vous avez en même temps la relique « Statue Maternelle », faites également gagner 5 points de folie aux autres réveilleurs"
  },
  RelicConfig_13911_Name = {
    Text = "<WhiteQuality:Dévouement>"
  },
  RelicConfig_13911_StoryDesc = {
    Text = "\"Je te donnerai tout, absolument tout. S'il te plaît, épargne-moi.\""
  },
  RelicConfig_13912_BattleDesc = {
    Text = "À la fin du tour, pour chaque carte restante dans la main, obtenir 1 point d'arsenal au début du prochain tour"
  },
  RelicConfig_13912_Desc = {
    Text = "À la fin du tour, pour chaque carte restante dans la main, obtenir 1 point d'arsenal au début du prochain tour"
  },
  RelicConfig_13912_Name = {
    Text = "<OrangeQuality:Pendule Chrono \"Performance\">"
  },
  RelicConfig_13913_BattleDesc = {
    Text = "Au début du tour, si la vie est supérieure à [Arg1], perdre [Arg1] points de vie, et gagner [Arg2] points <PowerIconKeywords: pouvoir> et [Arg3] points <AlertIconKeywords: alerte> durant ce tour"
  },
  RelicConfig_13913_Desc = {
    Text = "Au début du tour, si la vie est supérieure à [Arg1], perdre [Arg1] points de vie, et gagner [Arg2] points <PowerIconKeywords: pouvoir> et [Arg3] points <AlertIconKeywords: alerte> durant ce tour"
  },
  RelicConfig_13913_Name = {
    Text = "<RedQuality:Membre de secours>"
  },
  RelicConfig_13913_StoryDesc = {
    Text = "Une partie sacrée.\nMême séparée du tronc, elle conserve sa chaleur"
  },
  RelicConfig_13914_BattleDesc = {
    Text = "\"Attaque\" gagne 2 Arithmetica et défausse 1 carte aléatoire ; \"Défense\" pioche 2 cartes et perd 1 Arithmetica. Peut être déclenché jusqu'à 3 fois par tour."
  },
  RelicConfig_13914_Desc = {
    Text = "\"Attaque\" gagne 2 Arithmetica et défausse 1 carte aléatoire ; \"Défense\" pioche 2 cartes et perd 1 Arithmetica. Peut être déclenché jusqu'à 3 fois par tour."
  },
  RelicConfig_13914_Name = {
    Text = "<RedQuality:Disque joyeux>"
  },
  RelicConfig_13914_StoryDesc = {
    Text = "Enregistré le dernier concert du célèbre violoniste.\nDepuis, il peut apporter des flammes"
  },
  RelicConfig_13915_BattleDesc = {
    Text = "L'effet de bonus de recommandation de domaine est augmenté de 50 %, et votre <ProficientInRealmsIconKeywords:Maîtrise des domaines> est doublé au début du niveau"
  },
  RelicConfig_13915_Desc = {
    Text = "L'effet de bonus de recommandation de domaine est augmenté de 50 %, et votre <ProficientInRealmsIconKeywords:Maîtrise des domaines> est doublé au début du niveau"
  },
  RelicConfig_13915_Name = {
    Text = "<OrangeQuality:Pendule Chrono \"Entrer dans le Rêve\">"
  },
  RelicConfig_13916_BattleDesc = {
    Text = "Après avoir déclenché une Exaltation, la prochaine carte de commandement jouée prend effet deux fois."
  },
  RelicConfig_13916_Desc = {
    Text = "Après avoir déclenché une Exaltation, la prochaine carte de commandement jouée prend effet deux fois."
  },
  RelicConfig_13916_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Plongée\">"
  },
  RelicConfig_13917_BattleDesc = {
    Text = "Si l'intention de l'ennemi est d'attaquer, après avoir infligé des dégâts, sa <PowerIconKeywords:pouvoir> sera temporairement réduite de [Arg1] points, sinon ajoutez un <BleedingIconKeywords:saignement> équivalent à 25% des dégâts, avec un maximum de 6 déclenchements par tour"
  },
  RelicConfig_13917_Desc = {
    Text = "Si l'intention de l'ennemi est d'attaquer, après avoir infligé des dégâts, sa <PowerIconKeywords:pouvoir> sera temporairement réduite de [Arg1] points, sinon ajoutez un <BleedingIconKeywords:saignement> équivalent à 25% des dégâts, avec un maximum de 6 déclenchements par tour"
  },
  RelicConfig_13917_Name = {
    Text = "<WhiteQuality:Cœur alien>"
  },
  RelicConfig_13917_StoryDesc = {
    Text = "Deux \"cœurs\" entrelacés"
  },
  RelicConfig_13918_BattleDesc = {
    Text = "Chaque fois que vous infligez des dégâts, obtenez [Arg1] points de <PowerIconKeywords:force> temporaire, jusqu'à 3 fois. L'effet est doublé lorsque les couches sont pleines"
  },
  RelicConfig_13918_Desc = {
    Text = "Chaque fois que vous infligez des dégâts, obtenez [Arg1] points de <PowerIconKeywords:force> temporaire, jusqu'à 3 fois. L'effet est doublé lorsque les couches sont pleines"
  },
  RelicConfig_13918_Name = {
    Text = "<WhiteQuality:Agate enroulée>"
  },
  RelicConfig_13918_StoryDesc = {
    Text = "Ce ne sont probablement que des motifs d'agate ordinaires. Peut-être"
  },
  RelicConfig_13919_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:Maîtrise des Royaumes> +50. Choisissez une création à remplacer par une aléatoire lors de la collecte"
  },
  RelicConfig_13919_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Maîtrise des Royaumes> +50. Choisissez une création à remplacer par une aléatoire lors de la collecte"
  },
  RelicConfig_13919_Name = {
    Text = "<WhiteQuality:Kaléidoscope>"
  },
  RelicConfig_13919_StoryDesc = {
    Text = "Tout ce que tu vois et penses n'est qu'illusion"
  },
  RelicConfig_13920_BattleDesc = {
    Text = "Effet de faiblesse augmenté de 5 %. Vole temporairement [Arg1] points de <PowerIconKeywords:force> en appliquant <WeaknessIconKeywords:faiblesse>"
  },
  RelicConfig_13920_Desc = {
    Text = "Effet de Symptôme : Affaiblir augmenté de 5 %. En appliquant <WeaknessIconKeywords:Symptôme : Affaiblir>, vole temporairement [Arg1] points de <PowerIconKeywords:FOR> à la cible."
  },
  RelicConfig_13920_Name = {
    Text = "<WhiteQuality:Photo décolorée>"
  },
  RelicConfig_13920_StoryDesc = {
    Text = "Les photos floues portent des souvenirs flous, ou peut-être est-ce l'imperfection de la mémoire qui a fait pâlir les photos."
  },
  RelicConfig_13921_BattleDesc = {
    Text = "Lors de la collecte, choisir 2 cartes d'ordre à supprimer, obtenir [Arg1] <PowerIconKeywords:puissance>"
  },
  RelicConfig_13921_Desc = {
    Text = "Lors de la collecte, choisir 2 cartes d'ordre à supprimer, obtenir [Arg1] <PowerIconKeywords:puissance>"
  },
  RelicConfig_13921_Name = {
    Text = "<RedQuality:Cendres de l'étoile noire>"
  },
  RelicConfig_13921_StoryDesc = {
    Text = "La flamme n'est pas éteinte"
  },
  RelicConfig_13922_BattleDesc = {
    Text = "Après avoir utilisé l'exultation deux fois par tour, tous les réveilleurs obtiennent 8 points de folie, après trois fois d'utilisation, tous les réveilleurs obtiennent à nouveau 8 points de folie"
  },
  RelicConfig_13922_Desc = {
    Text = "Après avoir utilisé l'exultation deux fois par tour, tous les réveilleurs obtiennent 8 points de folie, après trois fois d'utilisation, tous les réveilleurs obtiennent à nouveau 8 points de folie"
  },
  RelicConfig_13922_Name = {
    Text = "<OrangeQuality:Sang des oubliés>"
  },
  RelicConfig_13922_StoryDesc = {
    Text = "Fondre progressivement"
  },
  RelicConfig_13923_BattleDesc = {
    Text = "Pour chaque dégât infligé, gagnez [Arg1] points de bouclier. Au début du tour, pour chaque 3 points de bouclier restants, gagnez 1 point de <PowerIconKeywords:force> temporaire et des dégâts de tentacule"
  },
  RelicConfig_13923_Desc = {
    Text = "Pour chaque dégât infligé, gagnez [Arg1] points de bouclier. Au début du tour, pour chaque 3 points de bouclier restants, gagnez 1 point de <PowerIconKeywords:force> temporaire et des dégâts de tentacule"
  },
  RelicConfig_13923_Name = {
    Text = "<OrangeQuality:Chrono Pendulum\"Secret\">"
  },
  RelicConfig_13924_BattleDesc = {
    Text = "Chaque fois que l'effet <TransitionIconKeywords:saut> est déclenché, volez [Arg1] points temporaires de <PowerIconKeywords:pouvoir> à tous les ennemis, et si un seul ennemi est présent, volez également [Arg2] points temporaires de <PowerIconKeywords:pouvoir>"
  },
  RelicConfig_13924_Desc = {
    Text = "Chaque fois que l'effet <TransitionIconKeywords:saut> est déclenché, volez [Arg1] points temporaires de <PowerIconKeywords:pouvoir> à tous les ennemis, et si un seul ennemi est présent, volez également [Arg2] points temporaires de <PowerIconKeywords:pouvoir>"
  },
  RelicConfig_13924_Name = {
    Text = "<OrangeQuality:Déflecteur spatial>"
  },
  RelicConfig_13924_StoryDesc = {
    Text = "Sauter dans le Vide"
  },
  RelicConfig_13925_BattleDesc = {
    Text = "Au début du tour, tire 1 carte. Après avoir joué deux fois des cartes avec la même consommation de puissance que la carte précédente, tire une carte supplémentaire, maximum 3 fois par tour"
  },
  RelicConfig_13925_Desc = {
    Text = "Au début du tour, tire 1 carte. Après avoir joué deux fois des cartes avec la même consommation de puissance que la carte précédente, tire une carte supplémentaire, maximum 3 fois par tour"
  },
  RelicConfig_13925_Name = {
    Text = "<OrangeQuality:Rituel de connaissance universelle>"
  },
  RelicConfig_13925_StoryDesc = {
    Text = "Omniscient et omnipotent"
  },
  RelicConfig_13926_BattleDesc = {
    Text = "Au début de la bataille, pour chaque sceau dans la pioche, gagnez [Arg1] points de <PowerIconKeywords:pouvoir>, et pour chaque création, retrouvez [Arg2] points de vie"
  },
  RelicConfig_13926_Desc = {
    Text = "Au début de la bataille, pour chaque sceau dans la pioche, gagnez [Arg1] points de <PowerIconKeywords:pouvoir>, et pour chaque création, retrouvez [Arg2] points de vie"
  },
  RelicConfig_13926_Name = {
    Text = "<OrangeQuality:☆Médaille de la guilde☆>"
  },
  RelicConfig_13926_StoryDesc = {
    Text = "\"Porte-le, et tu es membre de la Chambre de Commerce de Londinium.\""
  },
  RelicConfig_13927_BattleDesc = {
    Text = "Lors de la collecte, supprimer 1 carte de symptôme. Améliorer 1 oraison aléatoire en une oraison avancée"
  },
  RelicConfig_13927_Desc = {
    Text = "Lors de la collecte, supprimer 1 carte de symptôme. Améliorer 1 oraison aléatoire en une oraison avancée"
  },
  RelicConfig_13927_Name = {
    Text = "<WhiteQuality:Pied de lapin>"
  },
  RelicConfig_13927_StoryDesc = {
    Text = "Pour le lapin, ce n'est pas si chanceux"
  },
  RelicConfig_13928_BattleDesc = {
    Text = "Augmente le taux critique de 15 %. Chaque fois que 1 carte est jouée, le taux critique temporaire augmente de 5 %"
  },
  RelicConfig_13928_Desc = {
    Text = "Augmente le taux critique de 15 %. Chaque fois que 1 carte est jouée, le taux critique temporaire augmente de 5 %"
  },
  RelicConfig_13928_Name = {
    Text = "<OrangeQuality:Miroir rituel de Memphis>"
  },
  RelicConfig_13928_StoryDesc = {
    Text = "\"Que vois-tu à l’intérieur ?\""
  },
  RelicConfig_13929_BattleDesc = {
    Text = "Chaque fois que vous perdez des PV, gagnez [Arg1] <plural value=\"[Arg1]\" singular=\"charge\" plural=\"charges\"> de <RetaliateIconKeywords:Contre-attaque>. Si c'est le 3e déclenchement en un seul tour, déclenchez une <RetaliateIconKeywords:Contre-attaque> à 100% contre tous les ennemis."
  },
  RelicConfig_13929_Desc = {
    Text = "Chaque fois que vous perdez des PV, gagnez [Arg1] <plural value=\"[Arg1]\" singular=\"charge\" plural=\"charges\"> de <RetaliateIconKeywords:Contre-attaque>. Si c'est le 3e déclenchement en un seul tour, déclenchez une <RetaliateIconKeywords:Contre-attaque> à 100% contre tous les ennemis."
  },
  RelicConfig_13929_Name = {
    Text = "<WhiteQuality:Montre de l'ami>"
  },
  RelicConfig_13929_StoryDesc = {
    Text = "Portant souvenirs et tristesse, avancez vers l'inconnu"
  },
  RelicConfig_13930_BattleDesc = {
    Text = "À la fin du tour, chaque carte en main inflige [Arg1] couches de <IntoxicationIconKeywords:poison> à tous les ennemis"
  },
  RelicConfig_13930_Desc = {
    Text = "À la fin du tour, chaque carte en main inflige [Arg1] couches de <IntoxicationIconKeywords:poison> à tous les ennemis"
  },
  RelicConfig_13930_Name = {
    Text = "<WhiteQuality:Pommade suspecte>"
  },
  RelicConfig_13930_StoryDesc = {
    Text = "Un certain onguent local pour blessures, merci de ne pas l'utiliser sans l'avis d'un médecin"
  },
  RelicConfig_13931_BattleDesc = {
    Text = "Gagnez [Arg1] <PowerIconKeywords:STR> lors de la prise. Gagnez [Arg2] Temporaire <PowerIconKeywords:STR> chaque fois qu'un <DerivativeCardKeywords_2:\"Embryon\"> est fusionné"
  },
  RelicConfig_13931_Desc = {
    Text = "Gagnez [Arg1] <PowerIconKeywords:STR> lors de la prise. Gagnez [Arg2] Temporaire <PowerIconKeywords:STR> chaque fois qu'un <DerivativeCardKeywords_2:\"Embryon\"> est fusionné"
  },
  RelicConfig_13931_Name = {
    Text = "<WhiteQuality:Galet ensanglanté>"
  },
  RelicConfig_13931_StoryDesc = {
    Text = "Un, deux, trois, quatre, cinq"
  },
  RelicConfig_13932_BattleDesc = {
    Text = "Après chaque 3e utilisation de « Défense », gagne [Arg1] points de bouclier, et l'éveillé correspondant gagne 15 points de folie"
  },
  RelicConfig_13932_Desc = {
    Text = "Après chaque 3e utilisation de « Défense », gagne [Arg1] points de bouclier, et l'éveillé correspondant gagne 15 points de folie"
  },
  RelicConfig_13932_Name = {
    Text = "<WhiteQuality:Gants silencieux>"
  },
  RelicConfig_13932_StoryDesc = {
    Text = "Elles ont été imprégnées de sang, de larmes et de moisissures"
  },
  RelicConfig_13933_BattleDesc = {
    Text = "C'est un objet de quête hebdomadaire sans effet 6"
  },
  RelicConfig_13933_Desc = {
    Text = "C'est un objet de quête hebdomadaire sans effet 6"
  },
  RelicConfig_13933_Name = {
    Text = "Défi quotidien Création hebdomadaire 6"
  },
  RelicConfig_13934_BattleDesc = {
    Text = "C'est un objet de quête hebdomadaire sans effet 5"
  },
  RelicConfig_13934_Desc = {
    Text = "C'est un objet de quête hebdomadaire sans effet 5"
  },
  RelicConfig_13934_Name = {
    Text = "Défi quotidien Création hebdomadaire 5"
  },
  RelicConfig_13935_BattleDesc = {
    Text = "Augmente le taux critique de 10 %. Après le premier coup critique de chaque tour, le taux critique augmente de 20 %, et après avoir infligé le 3ème coup critique de chaque tour, les dégâts critiques augmentent de 50 %"
  },
  RelicConfig_13935_Desc = {
    Text = "Augmente le taux critique de 10 %. Après le premier coup critique de chaque tour, le taux critique augmente de 20 %, et après avoir infligé le 3ème coup critique de chaque tour, les dégâts critiques augmentent de 50 %"
  },
  RelicConfig_13935_Name = {
    Text = "<WhiteQuality:Bénédiction de fête>"
  },
  RelicConfig_13935_StoryDesc = {
    Text = "Il devrait apporter des bénédictions aux amoureux"
  },
  RelicConfig_13936_BattleDesc = {
    Text = "C'est un objet de quête hebdomadaire sans effet 3"
  },
  RelicConfig_13936_Desc = {
    Text = "C'est un objet de quête hebdomadaire sans effet 3"
  },
  RelicConfig_13936_Name = {
    Text = "Défi quotidien Création hebdomadaire 3"
  },
  RelicConfig_13937_BattleDesc = {
    Text = "C'est un objet de quête hebdomadaire sans effet 2"
  },
  RelicConfig_13937_Desc = {
    Text = "C'est un objet de quête hebdomadaire sans effet 2"
  },
  RelicConfig_13937_Name = {
    Text = "Défi quotidien Création hebdomadaire 2"
  },
  RelicConfig_13938_BattleDesc = {
    Text = "C'est un objet de quête hebdomadaire sans effet 1"
  },
  RelicConfig_13938_Desc = {
    Text = "C'est un objet de quête hebdomadaire sans effet 1"
  },
  RelicConfig_13938_Name = {
    Text = "Défi quotidien Création hebdomadaire 1"
  },
  RelicConfig_13939_BattleDesc = {
    Text = "Au début du tour 3, augmentez le taux critique dans cette bataille de 15%, et ajoutez 1 <DerivativeCardKeywords_39:\"Échos du Passé\"> à votre main."
  },
  RelicConfig_13939_Desc = {
    Text = "Au début du tour 3, augmentez le taux critique dans cette bataille de 15%, et ajoutez 1 <DerivativeCardKeywords_39:\"Échos du Passé\"> à votre main."
  },
  RelicConfig_13939_Name = {
    Text = "<OrangeQuality:Offrande passée>"
  },
  RelicConfig_13939_StoryDesc = {Text = "Offrande"},
  RelicConfig_13940_BattleDesc = {
    Text = "Avec un bouclier, cet artefact donne [Arg1] de <PowerIconKeywords:Force> temporaire. Si le bouclier est supérieur à la vie actuelle, donne [Arg2] de <PowerIconKeywords:Force> supplémentaire"
  },
  RelicConfig_13940_Desc = {
    Text = "Avec un bouclier, cet artefact donne [Arg1] de <PowerIconKeywords:Force> temporaire. Si le bouclier est supérieur à la vie actuelle, donne [Arg2] de <PowerIconKeywords:Force> supplémentaire"
  },
  RelicConfig_13940_Name = {
    Text = "<WhiteQuality:Éventail de plumes de pigeon>"
  },
  RelicConfig_13940_StoryDesc = {
    Text = "Élégant et coûteux, mais pas très pratique"
  },
  RelicConfig_13941_BattleDesc = {
    Text = "\"Frappe\" restaure [Arg1] Vie et réduit de [Arg1] piles de <IntoxicationIconKeywords:Poison>."
  },
  RelicConfig_13941_Desc = {
    Text = "\"Frappe\" restaure [Arg1] Vie et réduit de [Arg1] piles de <IntoxicationIconKeywords:Poison>."
  },
  RelicConfig_13941_Name = {
    Text = "<WhiteQuality:Pince hémostatique>"
  },
  RelicConfig_13941_StoryDesc = {
    Text = "\"Dépêche-toi, dépêche-toi ! Donne-le-moi !\""
  },
  RelicConfig_13942_BattleDesc = {
    Text = "Pour chaque tentacule, à la fin du tour, obtenez [Arg1] points de bouclier ; si le tentacule est en position calme, cet effet obtient 50 % de bouclier supplémentaires"
  },
  RelicConfig_13942_Desc = {
    Text = "Pour chaque tentacule, à la fin du tour, obtenez [Arg1] points de bouclier ; si le tentacule est en position calme, cet effet obtient 50 % de bouclier supplémentaires"
  },
  RelicConfig_13942_Name = {
    Text = "<WhiteQuality:Membre inconnu>"
  },
  RelicConfig_13942_StoryDesc = {
    Text = "Attention aux épines"
  },
  RelicConfig_139929_BattleDesc = {
    Text = "Au début du tour, Saya gagne [Arg1] Aliemus. Pour chaque tranche de 100 Aliemus consommée par l'Exaltation de Saya, une compétence « Aptitude » générée aléatoirement prend effet 1 fois supplémentaire."
  },
  RelicConfig_139929_Desc = {
    Text = "Au début du tour, Saya gagne [Arg1] Aliemus. Pour chaque tranche de 100 Aliemus consommée par l'Exaltation de Saya, une compétence « Aptitude » générée aléatoirement prend effet 1 fois supplémentaire."
  },
  RelicConfig_139929_Name = {
    Text = "<OrangeQuality:Image Dimensionnelle · Saya>"
  },
  RelicConfig_140276_BattleDesc = {
    Text = "<OrangeQuality:Dos au mur> : Au début du tour, pour chaque 1% de PV max perdus, les dégâts finaux temporaires sont augmentés de 5%. Si la Résistance à la mort a été déclenchée au tour précédent, cet effet est doublé.\n<RedQuality:Suprême> : Les PV max de tous les ennemis sont augmentés de 300%."
  },
  RelicConfig_140276_Desc = {
    Text = "<OrangeQuality:Dos au mur> : Au début du tour, pour chaque 1% de PV max perdus, les dégâts finaux temporaires sont augmentés de 5%. Si la Résistance à la mort a été déclenchée au tour précédent, cet effet est doublé.\n<RedQuality:Suprême> : Les PV max de tous les ennemis sont augmentés de 300%."
  },
  RelicConfig_140276_Name = {
    Text = "<RedQuality:Pendule Dimensionnel–Duel>"
  },
  RelicConfig_140277_BattleDesc = {
    Text = "<OrangeQuality:Prolifération> : Chaque tour, lorsqu'un Éveillé joue une « Compétence » pour la première fois, 2 copies temporaires originales de celle–ci sont générées. Jouer une carte de commande dont le coût en puissance de calcul est de 0 ou 1 octroie 5 points de Furie à tous les Éveillés.\n<RedQuality:Bastion> : Lorsqu'une carte dont le coût en puissance de calcul original est supérieur ou égal à 3 est jouée, tous les ennemis obtiennent un bouclier égal à 20% de leurs PV max."
  },
  RelicConfig_140277_Desc = {
    Text = "<OrangeQuality:Prolifération> : Chaque tour, lorsqu'un Éveillé joue une « Compétence » pour la première fois, 2 copies temporaires originales de celle–ci sont générées. Jouer une carte de commande dont le coût en puissance de calcul est de 0 ou 1 octroie 5 points de Furie à tous les Éveillés.\n<RedQuality:Bastion> : Lorsqu'une carte dont le coût en puissance de calcul original est supérieur ou égal à 3 est jouée, tous les ennemis obtiennent un bouclier égal à 20% de leurs PV max."
  },
  RelicConfig_140277_Name = {
    Text = "<RedQuality:Pendule Dimensionnel–Alerte>"
  },
  RelicConfig_140278_BattleDesc = {
    Text = "<OrangeQuality:Régénération> : Les effets de bouclier et de récupération obtenus sont augmentés de 25%. Lors de la récupération de PV ou de l'obtention d'un bouclier, pour chaque 1% de PV max récupéré ou protégé, obtient 10% d'Intensification des dégâts temporaire.\n<RedQuality:Murmure> : Chaque tour, subit une réduction de Force égale à 10% des PV max."
  },
  RelicConfig_140278_Desc = {
    Text = "<OrangeQuality:Régénération> : Les effets de bouclier et de récupération obtenus sont augmentés de 25%. Lors de la récupération de PV ou de l'obtention d'un bouclier, pour chaque 1% de PV max récupéré ou protégé, obtient 10% d'Intensification des dégâts temporaire.\n<RedQuality:Murmure> : Chaque tour, subit une réduction de Force égale à 10% des PV max."
  },
  RelicConfig_140278_Name = {
    Text = "<RedQuality:Pendule Dimensionnel–Effroi>"
  },
  RelicConfig_140279_BattleDesc = {
    Text = "<OrangeQuality:Aube> : La Furie de base de tous les Éveillés est réduite de 30 points. Les dégâts finaux de la première Éruption de Furie déclenchée chaque tour sont augmentés de 200%, et la récupération de bouclier et de PV est augmentée de 100%. Après 5 Éruptions de Furie déclenchées, choisissez 1 Éveillé à éveiller, et les effets d'amplification de l'Éruption de Furie sont réinitialisés.\n<RedQuality:Épuisement> : L'énergie de base de la Clé d'Argent est augmentée de 200%."
  },
  RelicConfig_140279_Desc = {
    Text = "<OrangeQuality:Aube> : La Furie de base de tous les Éveillés est réduite de 30 points. Les dégâts finaux de la première Éruption de Furie déclenchée chaque tour sont augmentés de 200%, et la récupération de bouclier et de PV est augmentée de 100%. Après 5 Éruptions de Furie déclenchées, choisissez 1 Éveillé à éveiller, et les effets d'amplification de l'Éruption de Furie sont réinitialisés.\n<RedQuality:Épuisement> : L'énergie de base de la Clé d'Argent est augmentée de 200%."
  },
  RelicConfig_140279_Name = {
    Text = "<RedQuality:Pendule Dimensionnel–Vaudou>"
  },
  RelicConfig_140280_BattleDesc = {
    Text = "<OrangeQuality:Éveil> : Après la première Éruption de Furie déclenchée chaque tour, le temps de recharge de l'Éruption de Furie de cet Éveillé est réinitialisé et il obtient 50 points de Furie. Des copies temporaires de toutes ses « Compétences » dont le coût en puissance de calcul est de 0 sont générées.\n<RedQuality:Sceau> : Après la première Éruption de Furie déclenchée chaque tour, les autres Éveillés sont scellés."
  },
  RelicConfig_140280_Desc = {
    Text = "<OrangeQuality:Éveil> : Après la première Éruption de Furie déclenchée chaque tour, le temps de recharge de l'Éruption de Furie de cet Éveillé est réinitialisé et il obtient 50 points de Furie. Des copies temporaires de toutes ses « Compétences » dont le coût en puissance de calcul est de 0 sont générées.\n<RedQuality:Sceau> : Après la première Éruption de Furie déclenchée chaque tour, les autres Éveillés sont scellés."
  },
  RelicConfig_140280_Name = {
    Text = "<RedQuality:Pendule Dimensionnel–Duel>"
  },
  RelicConfig_140281_BattleDesc = {
    Text = "<OrangeQuality:Écho> : Au début du tour, piochez les 3 cartes de commande ayant le coût en puissance de calcul le plus élevé de la pioche. La première carte de commande jouée chaque tour s'active 2 fois.\n<RedQuality:Étourdissement> : Après avoir joué une carte de commande, défaussez toutes les autres cartes de commande dont le coût en puissance de calcul est supérieur ou égal à celui de la carte jouée."
  },
  RelicConfig_140281_Desc = {
    Text = "<OrangeQuality:Écho> : Au début du tour, piochez les 3 cartes de commande ayant le coût en puissance de calcul le plus élevé de la pioche. La première carte de commande jouée chaque tour s'active 2 fois.\n<RedQuality:Étourdissement> : Après avoir joué une carte de commande, défaussez toutes les autres cartes de commande dont le coût en puissance de calcul est supérieur ou égal à celui de la carte jouée."
  },
  RelicConfig_140281_Name = {
    Text = "<RedQuality:Pendule Dimensionnel–Confusion>"
  },
  RelicConfig_140282_BattleDesc = {
    Text = "<OrangeQuality:Puissance> : La <PowerIconKeywords:Force> infligée par tous les Éveillés est augmentée de 50%. Chaque fois qu'ils infligent 1 instance de dégâts, ils obtiennent [Arg2] points de <PowerIconKeywords:Force> temporaire.\n<RedQuality:Intangible> : Au début du combat, tous les ennemis obtiennent 50 couches de <ParcloseIconKeywords:Barrière>."
  },
  RelicConfig_140282_Desc = {
    Text = "<OrangeQuality:Puissance> : La <PowerIconKeywords:Force> infligée par tous les Éveillés est augmentée de 50%. Chaque fois qu'ils infligent 1 instance de dégâts, ils obtiennent [Arg2] points de <PowerIconKeywords:Force> temporaire.\n<RedQuality:Intangible> : Au début du combat, tous les ennemis obtiennent 50 couches de <ParcloseIconKeywords:Barrière>."
  },
  RelicConfig_140282_Name = {
    Text = "<RedQuality:Pendule Dimensionnel–Embuscade>"
  },
  RelicConfig_140840_BattleDesc = {
    Text = "Limite Max de la Main +1. Au début du combat, génère 1 carte «<DerivativeCardKeywords_148:驭魇>» placée dans la Main. Lorsque vous jouez la «Frappe basique» d›un Corps éveillé, le coût d›Arithmetica de «<DerivativeCardKeywords_148:驭魇>» est réduit de -1 et inflige [Arg1] points de Corrosion à tous les ennemis. Lorsque vous jouez la «Défense de base» d›un Corps éveillé, obtenez [Arg2] points de Force et les Dégâts Finaux et la Force de la prochaine utilisation de «<DerivativeCardKeywords_148:驭魇>» sont augmentés de [Arg3]%."
  },
  RelicConfig_140840_Desc = {
    Text = "Limite Max de la Main +1. Au début du combat, génère 1 carte «<DerivativeCardKeywords_148:驭魇>» placée dans la Main. Lorsque vous jouez la «Frappe basique» d›un Corps éveillé, le coût d›Arithmetica de «<DerivativeCardKeywords_148:驭魇>» est réduit de -1 et inflige [Arg1] points de Corrosion à tous les ennemis. Lorsque vous jouez la «Défense de base» d›un Corps éveillé, obtenez [Arg2] points de Force et les Dégâts Finaux et la Force de la prochaine utilisation de «<DerivativeCardKeywords_148:驭魇>» sont augmentés de [Arg3]%."
  },
  RelicConfig_140840_Name = {
    Text = "Le Labeur Vain"
  },
  RelicConfig_140840_StoryDesc = {
    Text = "Le Labeur Vain craint le changement, craint que les choses lui échappent, et au plus profond de lui-même, il redoute avec hystérie de perdre.\n Il souffle encore et encore dans Le Sifflet, cherchant à tout contrôler par Le Sifflet, mais il n'a pu retenir quoi que ce soit."
  },
  RelicConfig_143665_BattleDesc = {
    Text = "Pontos gagne [Arg1] Fureur au début du tour. Lorsqu'il est ramassé, génère 3 cartes «Thrall-Décharné» Permanentes au début de la prochaine bataille. Pontos gagne 3 Fureur après avoir joué un «Thrall-Décharné»."
  },
  RelicConfig_143665_Desc = {
    Text = "Pontos gagne [Arg1] Fureur au début du tour. Lorsqu'il est ramassé, génère 3 cartes «Thrall-Décharné» Permanentes au début de la prochaine bataille. Pontos gagne 3 Fureur après avoir joué un «Thrall-Décharné»."
  },
  RelicConfig_143665_Name = {
    Text = "<OrangeQuality:Image Dimensionnelle : Pontos>"
  },
  RelicConfig_145438_BattleDesc = {
    Text = "Au début du tour, gagne [Arg1] Aliemus. Après avoir utilisé « Séparation du Mundus », effectue une Chasse : « Lame des Enfers » au début du prochain tour : Inflige des Dommages égaux à 400% de l'ATQ de Lotan : Cétarque à tous les ennemis. Cette Chasse bénéficie du Bonus de dégâts dont « Séparation du Mundus » profite via « Grande Lame : Chute de Baleine » et est considérée comme une « Attaque »."
  },
  RelicConfig_145438_Desc = {
    Text = "Au début du tour, gagne [Arg1] Aliemus. Après avoir utilisé « Séparation du Mundus », effectue une Chasse : « Lame des Enfers » au début du prochain tour : Inflige des Dommages égaux à 400% de l'ATQ de Lotan : Cétarque à tous les ennemis. Cette Chasse bénéficie du Bonus de dégâts dont « Séparation du Mundus » profite via « Grande Lame : Chute de Baleine » et est considérée comme une « Attaque »."
  },
  RelicConfig_145438_Name = {
    Text = "<OrangeQuality:Image Dimensionnelle : Lotan : Cétarque>"
  },
  RelicConfig_146128_BattleDesc = {
    Text = "Limite Max de la Main +1. Au début du combat ou après avoir joué «<DerivativeCardKeywords_157:Os de l'Épée>», placez 1 «<DerivativeCardKeywords_155:Os de la Folie>» dans votre Main et Mélanger 1 «<DerivativeCardKeywords_156:Os de la Blessure>» dans la Pioche. Si vous jouez «<DerivativeCardKeywords_155:Os de la Folie>» et «<DerivativeCardKeywords_156:Os de la Blessure>» au cours du même tour, fusionnez ces deux cartes en «<DerivativeCardKeywords_157:Os de l'Épée>» et placez-la dans votre Main."
  },
  RelicConfig_146128_Desc = {
    Text = "Limite Max de la Main +1. Au début du combat ou après avoir joué «<DerivativeCardKeywords_157:Os de l'Épée>», placez 1 «<DerivativeCardKeywords_155:Os de la Folie>» dans votre Main et Mélanger 1 «<DerivativeCardKeywords_156:Os de la Blessure>» dans la Pioche. Si vous jouez «<DerivativeCardKeywords_155:Os de la Folie>» et «<DerivativeCardKeywords_156:Os de la Blessure>» au cours du même tour, fusionnez ces deux cartes en «<DerivativeCardKeywords_157:Os de l'Épée>» et placez-la dans votre Main."
  },
  RelicConfig_146128_Name = {
    Text = "Armure d'Os de Baleine"
  },
  RelicConfig_146128_StoryDesc = {
    Text = "Les os du Léviathan protègent Ses élus, les rendant invincibles et immortels."
  },
  RelicConfig_147547_BattleDesc = {
    Text = "Au début du tour, Casiah reçoit [Arg1] points de folie. Pour chaque carte piochée, Casiah gagne [Arg2] points de folie. Lorsque Casiah libère l'exaltation, tous les ennemis perdent [Arg3] points de <PowerIconKeywords:puissance>."
  },
  RelicConfig_147547_Desc = {
    Text = "Au début du tour, Casiah reçoit [Arg1] points de folie. Pour chaque carte piochée, Casiah gagne [Arg2] points de folie. Lorsque Casiah libère l'exaltation, tous les ennemis perdent [Arg3] points de <PowerIconKeywords:puissance>."
  },
  RelicConfig_147547_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Cassia>"
  },
  RelicConfig_147665_BattleDesc = {
    Text = "Limite d'Arithmetica et nombre de cartes piochées par tour +1. Au début du tour, <FaxianKeywords:découvrez> 3 «<Caroboo_Tips:Pistoles de Marie>» et choisissez-en une. Une seule est authentique : choisir l'authentique octroie son Effet positif et dissipe 1 État négatif aléatoire sur soi-même ; choisir le faux inflige son Effet négatif et ajoute +1 option authentique lors de la prochaine <FaxianKeywords:découverte> avec des effets doublés, réinitialisé après avoir choisi l'authentique."
  },
  RelicConfig_147665_Desc = {
    Text = "Limite d'Arithmetica et nombre de cartes piochées par tour +1. Au début du tour, <FaxianKeywords:découvrez> 3 «<Caroboo_Tips:Pistoles de Marie>» et choisissez-en une. Une seule est authentique : choisir l'authentique octroie son Effet positif et dissipe 1 État négatif aléatoire sur soi-même ; choisir le faux inflige son Effet négatif et ajoute +1 option authentique lors de la prochaine <FaxianKeywords:découverte> avec des effets doublés, réinitialisé après avoir choisi l'authentique."
  },
  RelicConfig_147665_Name = {
    Text = "Pistoles de Marie"
  },
  RelicConfig_147665_StoryDesc = {
    Text = "Doux et précieux... ou pas ?"
  },
  RelicConfig_148525_BattleDesc = {
    Text = "Au début du tour, Ogier Lié par Serment gagne [Arg1] Fureur, et « Surge Sombre » ne réduit plus le nombre de pioches."
  },
  RelicConfig_148525_Desc = {
    Text = "Au début du tour, Ogier Lié par Serment gagne [Arg1] Fureur, et « Surge Sombre » ne réduit plus le nombre de pioches."
  },
  RelicConfig_148525_Name = {
    Text = "<OrangeQuality:Image Dimensionnelle·Serment Brisé·Ogier>"
  },
  RelicConfig_149665_BattleDesc = {
    Text = "Le terrain actuel est considéré comme un «Champ de glace».\nEn Hyperborée : après la phase de pioche, appliquez 1 charge de <SlowIconKeywords:Stase> et <RetainIconKeywords:Garder> aux 2 Cartes d'instruction non gelées ayant le Coût d'Arithmetica le plus élevé en main. Lorsqu'une Carte d'instruction possède au moins 3 charges de <SlowIconKeywords:Stase>, retirez sa <SlowIconKeywords:Stase> et <RetainIconKeywords:Garder> (obtenues lors de ce combat), Gelez-la et appliquez 25 charges de <TempPowerKeywords2:Renforcement>."
  },
  RelicConfig_149665_Desc = {
    Text = "Le terrain actuel est considéré comme un «Champ de glace».\nEn Hyperborée : après la phase de pioche, appliquez 1 charge de <SlowIconKeywords:Stase> et <RetainIconKeywords:Garder> aux 2 Cartes d'instruction non gelées ayant le Coût d'Arithmetica le plus élevé en main. Lorsqu'une Carte d'instruction possède au moins 3 charges de <SlowIconKeywords:Stase>, retirez sa <SlowIconKeywords:Stase> et <RetainIconKeywords:Garder> (obtenues lors de ce combat), Gelez-la et appliquez 25 charges de <TempPowerKeywords2:Renforcement>."
  },
  RelicConfig_149665_Name = {
    Text = "<OrangeQuality:Globe de Cristal>"
  },
  RelicConfig_149665_StoryDesc = {
    Text = "Il n'apporte pas le froid.\nIl rappelle simplement à la terre que l'hiver n'est jamais parti."
  },
  RelicConfig_20164_BattleDesc = {
    Text = "Chaque fois qu'un dommage est infligé, obtenez [Arg1] points de <PowerIconKeywords:force> temporaire, jusqu'à 5 couches, et lorsque les couches sont complètes, obtenez [Arg1] points de <PowerIconKeywords:force>"
  },
  RelicConfig_20164_Desc = {
    Text = "Chaque fois qu'un dommage est infligé, obtenez [Arg1] points de <PowerIconKeywords:force> temporaire, jusqu'à 5 couches, et lorsque les couches sont complètes, obtenez [Arg1] points de <PowerIconKeywords:force>"
  },
  RelicConfig_20164_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Agitation\">"
  },
  RelicConfig_20165_BattleDesc = {
    Text = "Lors de la collecte, éveiller tous les réveilleurs. Après avoir joué <ExaltIconKeywords:réveil>, obtenir aléatoirement 2 cartes d'ordre de ce réveilleur et ajouter « épuiser » et « illusion »"
  },
  RelicConfig_20165_Desc = {
    Text = "Lors de la collecte, éveiller tous les réveilleurs. Après avoir joué <ExaltIconKeywords:réveil>, obtenir aléatoirement 2 cartes d'ordre de ce réveilleur et ajouter « épuiser » et « illusion »"
  },
  RelicConfig_20165_Name = {
    Text = "<OrangeQuality:Son oracle+>"
  },
  RelicConfig_20165_StoryDesc = {
    Text = "Il a dit, n'aie pas peur"
  },
  RelicConfig_20166_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:Maîtrise des Royaumes> +100. Reprenez la 1ère carte jouée chaque tour. Au début du tour dimensionnel, limite de cartes +5 et dupliquez votre main"
  },
  RelicConfig_20166_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Maîtrise des Royaumes> +100. Reprenez la 1ère carte jouée chaque tour depuis la pile de défausse. Au début du tour ultra, lorsque la limite de cartes à main +5 et dupliquez votre main, les cartes dupliquées ajoutent <NothingnessIconKeywords:Vide> et <DepleteIconKeywords:Consommation>."
  },
  RelicConfig_20166_Name = {
    Text = "<OrangeQuality:Chrono Pendulum\"Dream Theft\">"
  },
  RelicConfig_20167_BattleDesc = {
    Text = "À la fin du tour, s'il y a des arsenaux restants, piocher 2 cartes supplémentaires au prochain tour ; s'il y a des cartes restantes, obtenir 2 points d'arsenal supplémentaires au prochain tour"
  },
  RelicConfig_20167_Desc = {
    Text = "À la fin du tour, s'il y a des arsenaux restants, piocher 2 cartes supplémentaires au prochain tour ; s'il y a des cartes restantes, obtenir 2 points d'arsenal supplémentaires au prochain tour"
  },
  RelicConfig_20167_Name = {
    Text = "<OrangeQuality:Roue du Soleil et de la Lune+>"
  },
  RelicConfig_20167_StoryDesc = {
    Text = "Devine, noir ou blanc ?"
  },
  RelicConfig_20168_BattleDesc = {
    Text = "Limite de tentacule +2. Après avoir libéré l'explosion de folie, les dégâts de tentacule +[Arg1]. Si 3 explosions de folie sont libérées dans un tour, toutes les tentacules sont activées une fois"
  },
  RelicConfig_20168_Desc = {
    Text = "Limite de tentacule +2. Après avoir libéré l'explosion de folie, les dégâts de tentacule +[Arg1]. Si 3 explosions de folie sont libérées dans un tour, toutes les tentacules sont activées une fois"
  },
  RelicConfig_20168_Name = {
    Text = "<OrangeQuality:Pendule Chrono \"Léger sommeil\">"
  },
  RelicConfig_20169_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:Maîtrise de Royaume> +100. Chaque carte jouée, <EmbryoFusionIconKeywords:Fusion d'Embryon> +10 ; si PV < 25%, l'augmentation devient 20%. Cet effet peut se déclencher max 10 fois par tour."
  },
  RelicConfig_20169_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Maîtrise de Royaume> +100. Chaque carte jouée, <EmbryoFusionIconKeywords:Fusion d'Embryon> +10 ; si PV < 25%, l'augmentation devient 20%. Cet effet peut se déclencher max 10 fois par tour."
  },
  RelicConfig_20169_Name = {
    Text = "<OrangeQuality:Pendule Chrono \"Surge\">"
  },
  RelicConfig_20170_BattleDesc = {
    Text = "Au début du combat, tous les Réveilleurs gagnent 50 points d'Aliemus. Pigez 2 <DerivativeCardKeywords_1:\"Écho Éclipsé\"> dans votre main."
  },
  RelicConfig_20170_Desc = {
    Text = "Au début du combat, tous les Réveilleurs gagnent 50 points d'Aliemus. Pigez 2 <DerivativeCardKeywords_1:\"Écho Éclipsé\"> dans votre main."
  },
  RelicConfig_20170_Name = {
    Text = "<OrangeQuality:Équipement de communication+>"
  },
  RelicConfig_20170_StoryDesc = {
    Text = "Attendre ou craindre le moment où il sonnera"
  },
  RelicConfig_20171_BattleDesc = {
    Text = "En ramassant, obtenez au hasard 1 relique d'argent, 1 relique en or et 1 relique maudite"
  },
  RelicConfig_20171_Desc = {
    Text = "En ramassant, obtenez au hasard 1 relique d'argent, 1 relique en or et 1 relique maudite"
  },
  RelicConfig_20171_Name = {
    Text = "<OrangeQuality:Vision inversée+>"
  },
  RelicConfig_20171_StoryDesc = {
    Text = "Dans l'ère étrange, les fleurs sont les premiers spectateurs des humains.\nNe bouge pas, elles préfèrent les expositions calmes"
  },
  RelicConfig_20172_BattleDesc = {
    Text = "Chaque fois que 3 cartes d'instruction sont jouées par tour, gagnez 1 carte <DerivativeCardKeywords_4:« perspicacité »>. Lorsque 6 cartes sont atteintes, gagnez encore 1 carte <DerivativeCardKeywords_4:« perspicacité »>. Après avoir atteint 10 cartes, au début du prochain tour, vous pouvez choisir 2 cartes de votre bibliothèque à ajouter à votre main."
  },
  RelicConfig_20172_Desc = {
    Text = "Chaque fois que 3 cartes d'instruction sont jouées par tour, gagnez 1 carte <DerivativeCardKeywords_4:« perspicacité »>. Lorsque 6 cartes sont atteintes, gagnez encore 1 carte <DerivativeCardKeywords_4:« perspicacité »>. Après avoir atteint 10 cartes, au début du prochain tour, vous pouvez choisir 2 cartes de votre bibliothèque à ajouter à votre main."
  },
  RelicConfig_20172_Name = {
    Text = "<OrangeQuality:Pendule Chrono \"Écho\">"
  },
  RelicConfig_20173_BattleDesc = {
    Text = "Les dégâts infligés aux ennemis en état négatif augmentent de 50 %, et le tueur gagne 100 folie après avoir tué un ennemi"
  },
  RelicConfig_20173_Desc = {
    Text = "Les dégâts infligés aux ennemis en état négatif augmentent de 50 %, et le tueur gagne 100 folie après avoir tué un ennemi"
  },
  RelicConfig_20173_Name = {
    Text = "<OrangeQuality:Bâton du prêtre+>"
  },
  RelicConfig_20173_StoryDesc = {
    Text = "Dévotion non autorisée"
  },
  RelicConfig_20174_BattleDesc = {
    Text = "À la récupération, Amplification de Dégâts de l'équipe x150%. Au début du tour, inflige [Arg1] <FixedDamage:DGT Purs> à un ennemi aléatoire. Pour chaque Décret Clé utilisé dans ce combat, augmente les DGT infligés de [Arg2]. Ce bonus de DGT bénéficie du bonus d'Amplification de Dégâts de l'équipe."
  },
  RelicConfig_20174_Desc = {
    Text = "À la récupération, Amplification de Dégâts de l'équipe x150%. Au début du tour, inflige [Arg1] <FixedDamage:DGT Purs> à un ennemi aléatoire. Pour chaque Décret Clé utilisé dans ce combat, augmente les DGT infligés de [Arg2]. Ce bonus de DGT bénéficie du bonus d'Amplification de Dégâts de l'équipe."
  },
  RelicConfig_20174_Name = {
    Text = "<OrangeQuality:Chrono Pendulum\"Lost\">"
  },
  RelicConfig_20175_BattleDesc = {
    Text = "Effet de <WeaknessIconKeywords:faiblesse> augmenté de 8 %, effet <VulnerabilityIconKeywords:vulnérable> augmenté de 25 %. Vole temporairement [Arg1] points de <PowerIconKeywords:force> en appliquant <WeaknessIconKeywords:faiblesse> ou <VulnerabilityIconKeywords:vulnérabilité>."
  },
  RelicConfig_20175_Desc = {
    Text = "Effet de <WeaknessIconKeywords:faiblesse> augmenté de 8 %, effet <VulnerabilityIconKeywords:vulnérable> augmenté de 25 %. Vole temporairement [Arg1] points de <PowerIconKeywords:force> en appliquant <WeaknessIconKeywords:faiblesse> ou <VulnerabilityIconKeywords:vulnérabilité>."
  },
  RelicConfig_20175_Name = {
    Text = "<OrangeQuality:Photo décolorée+>"
  },
  RelicConfig_20175_StoryDesc = {
    Text = "Les photos floues portent des souvenirs flous, ou peut-être est-ce l'imperfection de la mémoire qui a fait pâlir les photos."
  },
  RelicConfig_20176_BattleDesc = {
    Text = "Au début du tour, pour chaque ennemi, gagner 2 arithmetica. En tuant un ennemi par des dégâts actifs, infliger des dégâts d'excès doubles aux autres ennemis <BleedingIconKeywords: saignement>"
  },
  RelicConfig_20176_Desc = {
    Text = "Au début du tour, pour chaque ennemi, gagner 2 arithmetica. En tuant un ennemi par des dégâts actifs, infliger des dégâts d'excès doubles aux autres ennemis <BleedingIconKeywords: saignement>"
  },
  RelicConfig_20176_Name = {
    Text = "<OrangeQuality:Chant des foules+>"
  },
  RelicConfig_20176_StoryDesc = {
    Text = "Né pour torturer tes oreilles"
  },
  RelicConfig_20177_BattleDesc = {
    Text = "Après ramassage, la résistance à la mort est doublée. Après avoir infligé des dégâts, appliquez un <BleedingIconKeywords:saignement> égal à 50% des dégâts. Chaque fois que la résistance à la mort est déclenchée, tous les ennemis subissent immédiatement un saignement"
  },
  RelicConfig_20177_Desc = {
    Text = "Après ramassage, la résistance à la mort est doublée. Après avoir infligé des dégâts, appliquez un <BleedingIconKeywords:saignement> égal à 50% des dégâts. Chaque fois que la résistance à la mort est déclenchée, tous les ennemis subissent immédiatement un saignement"
  },
  RelicConfig_20177_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Renaissance\">"
  },
  RelicConfig_20178_BattleDesc = {
    Text = "Chaque fois que des dégâts directs sont infligés, obtenez 3 points de fureur et appliquez [Arg1] couches d'<IntoxicationIconKeywords:poison> à la cible. Si le nombre d'activations dans ce combat atteint 25, déclenchez immédiatement <IntoxicationIconKeywords:poison> sur tous les ennemis."
  },
  RelicConfig_20178_Desc = {
    Text = "Chaque fois que vous infligez des Dégâts Directs, gagnez 3 points de Fureur et appliquez [Arg1] couches d'<IntoxicationIconKeywords:poison> à la cible. Si le nombre d'activations dans ce combat atteint 25, déclenchez immédiatement <IntoxicationIconKeywords:poison> sur tous les ennemis."
  },
  RelicConfig_20178_Name = {
    Text = "<OrangeQuality:Machine à coudre poussiéreuse+>"
  },
  RelicConfig_20178_StoryDesc = {
    Text = "Une mère aimante, réparant les blessures du cœur"
  },
  RelicConfig_21906_BattleDesc = {
    Text = "\"Attaque\" gagne 3 Arithmetica et défausse 1 carte aléatoire ; \"Défense\" pioche 3 cartes et perd 1 Arithmetica."
  },
  RelicConfig_21906_Desc = {
    Text = "\"Attaque\" gagne 3 Arithmetica et défausse 1 carte aléatoire ; \"Défense\" pioche 3 cartes et perd 1 Arithmetica."
  },
  RelicConfig_21906_Name = {
    Text = "<RedQuality:Disque joyeux+>"
  },
  RelicConfig_21906_StoryDesc = {
    Text = "Enregistré le dernier concert du célèbre violoniste.\nDepuis, il peut apporter des flammes"
  },
  RelicConfig_23688_BattleDesc = {
    Text = "Chaque fois que vous déclenchez un dévorer, gagnez 30 points <EmbryoFusionIconKeywords:fusion d'embryon> et [Arg1] points <PowerIconKeywords:force>. Si c'est le deuxième déclenchement dans un tour, gagnez 1 point d'arithmétique et piochez 1 carte; si c'est le troisième déclenchement dans un tour, gagnez 2 points d'arithmétique et piochez 2 cartes."
  },
  RelicConfig_23688_Desc = {
    Text = "Chaque fois que vous déclenchez un dévoré, gagnez 30 points <EmbryoFusionIconKeywords:fusion d'embryon> et [Arg1] points <PowerIconKeywords:force>. Si c'est la deuxième fois que cela se produit dans un tour, gagnez 1 point d'arithmética, piochez 1 carte; si c'est la troisième fois, gagnez 2 points d'arithmética, piochez 2 cartes."
  },
  RelicConfig_23688_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Réverbération\">"
  },
  RelicConfig_23689_BattleDesc = {
    Text = "Après la collecte, tous les éveillés obtiennent 30 points de folie. Chaque fois que l'exaltation est utilisée, ajoutez 1 au compteur. Après l'activation du décret clé, obtenez [Arg1] points de précaution temporaire, [Arg2] points de <PowerIconKeywords:force> temporaire et tous les éveillés reçoivent 6 points de folie, consommant tous les compteurs, chaque point de compteur ayant un effet supplémentaire 1 fois."
  },
  RelicConfig_23689_Desc = {
    Text = "Après avoir ramassé, tous les éveilleurs obtiennent 30 points de folie. Chaque fois que vous libérez l'exaltation, augmentez le compteur de 1. Après avoir activé le décret clé, gagnez [Arg1] points de précaution temporaire, [Arg2] points de <PowerIconKeywords:force> temporaire et tous les éveilleurs obtiennent 6 points de folie, dépensant tous les compteurs, chaque point de compteur prenant effet 1 fois supplémentaire."
  },
  RelicConfig_23689_Name = {
    Text = "<OrangeQuality:Chrono Pendulum\"Charge\">"
  },
  RelicConfig_23690_BattleDesc = {
    Text = "Pour chaque point d'arithmetica supplémentaire obtenu ou chaque carte supplémentaire piochée, volez [Arg1] points de <PowerIconKeywords:Force> à tous les ennemis, obtenez 4% de taux de coup critique temporaire, les effets de combat d'élite ou de chef sont doublés. Au début du tour ultra, gagnez [Arg2] points de <PowerIconKeywords:Force>, les dégâts critiques +15%."
  },
  RelicConfig_23690_Desc = {
    Text = "Pour chaque point d'arithmetica supplémentaire ou chaque carte supplémentaire piochée, volez [Arg1] points de <PowerIconKeywords:Force> à tous les ennemis, obtenez 4% de taux critique temporaire, les effets de combat d'Élite ou de Chef sont doublés. Après le début du tour ultra, gagnez [Arg2] points de <PowerIconKeywords:Force>, les dégâts critiques +15%."
  },
  RelicConfig_23690_Name = {
    Text = "<OrangeQuality:Pendule Chrono \"Fissure\">"
  },
  RelicConfig_23691_BattleDesc = {
    Text = "Pour chaque 5 dégâts infligés, récupérez [Arg1] points de vie. Pour chaque perte de vie, dégâts de tentacule +[Arg2], si la perte de vie dépasse [Arg3] points, activez tous les tentacules 1 fois"
  },
  RelicConfig_23691_Desc = {
    Text = "Chaque fois que 5 dommages sont infligés, restaurez [Arg1] points de vie. Chaque fois que 1 point de vie est perdu, les dégâts de tentacule +[Arg2], si la perte de vie dépasse 10 % de la santé max, tous les tentacules sont activés une fois"
  },
  RelicConfig_23691_Name = {
    Text = "<OrangeQuality:Chrono Pendulum\"Tide Surge\">"
  },
  RelicConfig_35135_BattleDesc = {
    Text = "Pour chaque dégât infligé, obtenez [Arg1] points de <PowerIconKeywords:force> temporaire et [Arg2] points de dommages temporaires des tentacules, jusqu'à 12 fois par tour. Si 4 dégâts sont infligés en un tour, appliquez 1 niveau de Vulnérabilité à tous les ennemis et obtenez [Arg3] points de bouclier. Si 8 dégâts sont infligés, appliquez 1 niveau de Faiblesse à tous les ennemis et restaurez [Arg3] points de PV."
  },
  RelicConfig_35135_Desc = {
    Text = "Chaque fois qu'un dommage est infligé, gagnez [Arg1] points de <PowerIconKeywords:Force> temporaire et [Arg2] points de dommages temporaires des tentacules, jusqu'à 12 fois par tour. Si 4 dommages sont infligés en un tour, appliquez 1 couche de Vulnérabilité à tous les ennemis et gagnez [Arg3] points de bouclier, et si 8 dommages sont infligés, appliquez 1 couche de Faiblesse à tous les ennemis et restaurez [Arg3] points de PV."
  },
  RelicConfig_35135_Name = {
    Text = "<OrangeQuality:Pendule Chrono \"Fascination\">"
  },
  RelicConfig_35136_BattleDesc = {
    Text = "\"Les dégâts de l'Attaque\" et \"le bouclier de Défense\" augmentent de 30%. Si tu joues 4 cartes ou plus d'Attaque et de Défense en un tour, tire 2 cartes et gagne 1 Arithmetica au début du tour suivant."
  },
  RelicConfig_35136_Desc = {
    Text = "\"Les dégâts de l'Attaque\" et \"le bouclier de Défense\" augmentent de 30%. Si tu joues 4 cartes ou plus d'Attaque et de Défense en un tour, tire 2 cartes et gagne 1 Arithmetica au début du tour suivant."
  },
  RelicConfig_35136_Name = {
    Text = "<OrangeQuality:Pendule Chrono \"Obstination\">"
  },
  RelicConfig_35137_BattleDesc = {
    Text = "À chaque carte jouée, gagnez [Arg1] points de <PowerIconKeywords:puissance> temporaire et récupérez [Arg2] points de vie. Après avoir infligé des dégâts, retirez [Arg2] points de <PowerIconKeywords:puissance> obtenus. Le Réveillé gagne 30 points de folie pour chaque ennemi tué"
  },
  RelicConfig_35137_Desc = {
    Text = "À chaque carte jouée, gagnez [Arg1] points de <PowerIconKeywords:puissance> temporaire et récupérez [Arg2] points de vie. Après avoir infligé des dégâts, retirez [Arg2] points de <PowerIconKeywords:puissance> obtenus. Le Réveillé gagne 30 points de folie pour chaque ennemi tué"
  },
  RelicConfig_35137_Name = {
    Text = "<OrangeQuality:Pendule Chrono\"Accumulation\">"
  },
  RelicConfig_35138_BattleDesc = {
    Text = "Après avoir libéré l'exaltation, appliquez [Arg1] points de poison à un ennemi aléatoire. Chaque fois que vous jouez une carte d'instruction, obtenez [Arg2] points de contre-attaque temporaire. À la fin de chaque 4ème tour, infligez des dégâts équivalents à la somme des niveaux d'empoisonnement des ennemis et des niveaux de contre-attaque."
  },
  RelicConfig_35138_Desc = {
    Text = "Après avoir libéré l'exaltation, appliquez [Arg1] points de poison à un ennemi aléatoire. Chaque fois qu'une carte d'instruction est jouée, obtenez [Arg2] points de contre-attaque temporaire. À la fin de chaque 4ème tour, infligez des dégâts équivalents à la somme des niveaux d'empoisonnement des ennemis et des niveaux de contre-attaque."
  },
  RelicConfig_35138_Name = {
    Text = "<OrangeQuality:Chrono Pendulum\"Spread\">"
  },
  RelicConfig_35139_BattleDesc = {
    Text = "Après la collecte, le pouvoir de l'équipe augmente de 30%. Chaque 4ème dégâts infligé critiquement frappe, et les dégâts critiques augmentent de 50%, si ce coup cause une élimination, obtenir 5 sigils noirs"
  },
  RelicConfig_35139_Desc = {
    Text = "Après la collecte, le pouvoir de l'équipe augmente de 30%. Chaque 4ème dégâts infligé critiquement frappe, et les dégâts critiques augmentent de 50%, si ce coup cause une élimination, obtenir 5 sigils noirs"
  },
  RelicConfig_35139_Name = {
    Text = "<OrangeQuality:Pendule Chrono \"Résiliation\">"
  },
  RelicConfig_36823_BattleDesc = {
    Text = "Après avoir libéré l'exaltation de la folie, piochez 1 carte. Pour chaque carte défaussée, tous les réveilleurs gagnent 3 de folie, maximum 15 par tour"
  },
  RelicConfig_36823_Desc = {
    Text = "Après avoir libéré l'exaltation de la folie, piochez 1 carte. Pour chaque carte défaussée, tous les réveilleurs gagnent 3 de folie, maximum 15 par tour"
  },
  RelicConfig_36823_Name = {
    Text = "<OrangeQuality: Pendule Chrono \"Aller et Venir\">"
  },
  RelicConfig_36824_BattleDesc = {
    Text = "Chaque fois que vous consommez de l'arithmetica, piochez 1 carte, maximum 5 fois par tour. Chaque fois que le paquet est réinitialisé, obtenez 2 points d'arithmetica"
  },
  RelicConfig_36824_Desc = {
    Text = "Chaque fois que vous consommez de l'arithmetica, piochez 1 carte, maximum 5 fois par tour. Chaque fois que le paquet est réinitialisé, obtenez 2 points d'arithmetica"
  },
  RelicConfig_36824_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Insomniaque\">"
  },
  RelicConfig_39302_BattleDesc = {
    Text = "Chaque fois que vous infligez 4 points de dégâts, mélangez 1 carte <DerivativeCardKeywords_4:« inspiration »> dans la pile de pioche, pouvant être déclenché un maximum de 3 fois par tour. Après avoir libéré l'exaltation de la folie, jouez et consommez toutes les cartes <DerivativeCardKeywords_4:« inspiration »> dans votre pioche."
  },
  RelicConfig_39302_Desc = {
    Text = "Chaque fois que vous infligez 4 points de dégâts, mélangez 1 carte <DerivativeCardKeywords_4:« inspiration »> dans la pile de pioche, pouvant être déclenché un maximum de 3 fois par tour. Après avoir libéré l'exaltation de la folie, jouez et consommez toutes les cartes <DerivativeCardKeywords_4:« inspiration »> dans votre pioche."
  },
  RelicConfig_39302_Name = {
    Text = "<OrangeQuality:Chrono Pendulum\"Lost Dream\">"
  },
  RelicConfig_39303_BattleDesc = {
    Text = "Lorsque la puissance actuelle est impair, considérez que vous avez [Arg2] points de précaution temporaire supplémentaires. Lorsque la puissance actuelle est paire, considérez que vous avez [Arg1] points de <PowerIconKeywords:Force> temporaire supplémentaires et [Arg3] points de dommages temporaires des tentacules. Pour chaque création en or que vous possédez, l'effet de cette relique augmente de 50 %, et pour chaque créature maudite que vous possédez, augmente de 80 %."
  },
  RelicConfig_39303_Desc = {
    Text = "Lorsque la puissance actuelle est impair, cela est considéré comme un bonus supplémentaire de [Arg2] points de précaution temporaire. Lorsque la puissance actuelle est paire, cela est considéré comme un bonus supplémentaire de [Arg1] points de <PowerIconKeywords:force> temporaire et [Arg3] points de dommages temporaires des tentacules. Pour chaque création en or que vous possédez, l'effet de cette relique augmente de 50 %, et pour chaque créature maudite que vous possédez, cela augmente de 80 %."
  },
  RelicConfig_39303_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Réveil de Rêve\">"
  },
  RelicConfig_44192_BattleDesc = {
    Text = "Au début de chaque tour, tous les réveilleurs gagnent 20 points de folie. La santé max est réduite de 50%"
  },
  RelicConfig_44192_Desc = {
    Text = "Au début de chaque tour, tous les réveilleurs gagnent 20 points de folie. La santé max est réduite de 50%"
  },
  RelicConfig_44192_Name = {
    Text = "<RedQuality:Culpabilité·Apparence de cauchemar>"
  },
  RelicConfig_44192_StoryDesc = {
    Text = ": Le sommeil profond de l'abandon est le désir, il dévorera tout sans que tu t'en rendes compte"
  },
  RelicConfig_44300_BattleDesc = {
    Text = "Au début de chaque tour, tous les réveilleurs gagnent 25 points de folie. Lors de la collecte, la santé max devient 3 fois"
  },
  RelicConfig_44300_Desc = {
    Text = "Au début de chaque tour, tous les réveilleurs gagnent 25 points de folie. Lors de la collecte, la santé max devient 3 fois"
  },
  RelicConfig_44300_Name = {
    Text = "<OrangeQuality:Bénédiction : Apparence de cauchemar>"
  },
  RelicConfig_44300_StoryDesc = {
    Text = "Pas besoin de peur, pas besoin d'hésitation. Ce n'est qu'un rêve éphémère, la lumière du Père brille toujours sur toi"
  },
  RelicConfig_44592_BattleDesc = {
    Text = "Après le combat, obtenez 100 sigils noirs et 2 cartes de symptômes"
  },
  RelicConfig_44592_Desc = {
    Text = "Après le combat, obtenez 100 sigils noirs et 2 cartes de symptômes"
  },
  RelicConfig_44592_Name = {
    Text = "<RedQuality:Culpabilité·Impression de jade>"
  },
  RelicConfig_44592_StoryDesc = {
    Text = "Les péchés anciens sont gravés ici"
  },
  RelicConfig_44593_BattleDesc = {
    Text = "Lors de la collecte, se transformer en une relique de culpabilité aléatoire autre que soi-même, obtenir 75 sigils noirs"
  },
  RelicConfig_44593_Desc = {
    Text = "Lors de la collecte, se transformer en une relique de culpabilité aléatoire autre que soi-même, obtenir 75 sigils noirs"
  },
  RelicConfig_44593_Name = {
    Text = "<RedQuality:Culpabilité·Stèle maudite>"
  },
  RelicConfig_44593_StoryDesc = {
    Text = "Écoute, quelqu'un appelle à l'intérieur"
  },
  RelicConfig_44594_BattleDesc = {
    Text = "Tous les 2 tours, doublez les Dommages actifs et les Dégâts des tentacules subis par tous les ennemis durant ce tour. Cependant, après avoir utilisé l'Exaltation durant ce tour, scellez tous les Corps éveillés pour 1 tour et rendez-vous Vulnérable."
  },
  RelicConfig_44594_Desc = {
    Text = "Tous les 2 tours, doublez les Dommages actifs et les Dégâts des tentacules subis par tous les ennemis durant ce tour. Cependant, après avoir utilisé l'Exaltation durant ce tour, scellez tous les Corps éveillés pour 1 tour et rendez-vous Vulnérable."
  },
  RelicConfig_44594_Name = {
    Text = "<RedQuality:Culpabilité·Cadavre du chemin>"
  },
  RelicConfig_44594_StoryDesc = {
    Text = "Une partie sacrée.\nSéparée du tronc, elle est imprégnée de péché"
  },
  RelicConfig_44597_BattleDesc = {
    Text = "Chaque fois qu'un dommage actif est infligé, appliquez [Arg1] couches <BleedingIconKeywords:saignement> sur vous-même et [Arg2] couches <BleedingIconKeywords:saignement> à la cible blessée"
  },
  RelicConfig_44597_Desc = {
    Text = "Chaque fois qu'un dommage actif est infligé, appliquez [Arg1] couches <BleedingIconKeywords:saignement> sur vous-même et [Arg2] couches <BleedingIconKeywords:saignement> à la cible blessée"
  },
  RelicConfig_44597_Name = {
    Text = "<RedQuality:Culpabilité·Conscience de l'essaim>"
  },
  RelicConfig_44597_StoryDesc = {
    Text = "Enroulement, symbiose, agrégation ; peur, inconnu, contrôle"
  },
  RelicConfig_44598_BattleDesc = {
    Text = "Après avoir libéré l'exalter, perdez 12% de votre vie actuelle, volez à tous les ennemis [Arg1] points de <PowerIconKeywords: pouvoir> temporaire, si un seul ennemi, volez en plus [Arg2] points de <PowerIconKeywords: pouvoir> temporaire"
  },
  RelicConfig_44598_Desc = {
    Text = "Après avoir libéré l'exalter, perdez 12% de votre vie actuelle, volez à tous les ennemis [Arg1] points de <PowerIconKeywords: pouvoir> temporaire, si un seul ennemi, volez en plus [Arg2] points de <PowerIconKeywords: pouvoir> temporaire"
  },
  RelicConfig_44598_Name = {
    Text = "<RedQuality:Culpabilité·Oiseau du rituel funeste>"
  },
  RelicConfig_44598_StoryDesc = {
    Text = "Créature morte par avidité, émettant des plaintes stridentes de sa poitrine desséchée"
  },
  RelicConfig_44603_BattleDesc = {
    Text = "Limite de cartes à main augmentée de 5, tirez 6 cartes au début du combat. À la fin du tour, défaussez toutes les cartes de symptôme et d'état dans votre main, conservez les autres, mais le nombre de cartes tirées par tour est réduit de 2"
  },
  RelicConfig_44603_Desc = {
    Text = "Limite de cartes à main augmentée de 5, tirez 6 cartes au début du combat. À la fin du tour, défaussez toutes les cartes de symptôme et d'état dans votre main, conservez les autres, mais le nombre de cartes tirées par tour est réduit de 2"
  },
  RelicConfig_44603_Name = {
    Text = "<RedQuality:Culpabilité·Gravure de conscience>"
  },
  RelicConfig_44603_StoryDesc = {
    Text = "L'avide traite les autres comme des objets, trouvant son plaisir dans la souffrance des autres"
  },
  RelicConfig_44608_BattleDesc = {
    Text = "Après ramassage, perdez définitivement [Arg1] <PowerIconKeywords:force>. Chaque fois que vous infligez des dégâts, récupérez [Arg2] points de vie, jusqu'à 6 fois par tour"
  },
  RelicConfig_44608_Desc = {
    Text = "Après ramassage, perdez définitivement [Arg1] <PowerIconKeywords:force>. Chaque fois que vous infligez des dégâts, récupérez [Arg2] points de vie, jusqu'à 6 fois par tour"
  },
  RelicConfig_44608_Name = {
    Text = "<RedQuality:Culpabilité·Baiser de la lamproie>"
  },
  RelicConfig_44608_StoryDesc = {
    Text = "Son baiser vous fera succomber — bien sûr, c'est peut-être vous-même qui succomberez"
  },
  RelicConfig_44609_BattleDesc = {
    Text = "Augmente la puissance arithmetica de 3. Chaque fois que la pile de cartes est réinitialisée, ajoutez 2<DerivativeCardKeywords_9:« trébucher »> à la pile de tirage"
  },
  RelicConfig_44609_Desc = {
    Text = "Augmente la puissance arithmetica de 3. Chaque fois que la pile de cartes est réinitialisée, ajoutez 2<DerivativeCardKeywords_9:« trébucher »> à la pile de tirage"
  },
  RelicConfig_44609_Name = {
    Text = "<RedQuality:Culpabilité·Bougie noire>"
  },
  RelicConfig_44609_StoryDesc = {
    Text = "Brûler la raison, sombrer dans la folie"
  },
  RelicConfig_44610_BattleDesc = {
    Text = "Le taux critique et les dégâts critiques augmentent de 50 %, au début de chaque tour, <FragileIconKeywords:fragile> pour 1 tour"
  },
  RelicConfig_44610_Desc = {
    Text = "Le taux critique et les dégâts critiques augmentent de 50 %, au début de chaque tour, <FragileIconKeywords:fragile> pour 1 tour"
  },
  RelicConfig_44610_Name = {
    Text = "<RedQuality:Culpabilité·Griffe étrange>"
  },
  RelicConfig_44610_StoryDesc = {
    Text = "Les griffes déformées par le désir"
  },
  RelicConfig_44654_BattleDesc = {
    Text = "Augmente la puissance arithmetica de 4. Chaque fois que la pile de cartes est réinitialisée, ajoutez 4<DerivativeCardKeywords_4:« inspiration »> à la pile de tirage"
  },
  RelicConfig_44654_Desc = {
    Text = "Augmente la puissance arithmetica de 4. Chaque fois que la pile de cartes est réinitialisée, ajoutez 4<DerivativeCardKeywords_4:« inspiration »> à la pile de tirage"
  },
  RelicConfig_44654_Name = {
    Text = "<OrangeQuality:Bénédiction : Bougie noire>"
  },
  RelicConfig_44654_StoryDesc = {
    Text = "Brûler le désir, obtenir la rédemption"
  },
  RelicConfig_44656_BattleDesc = {
    Text = "Limite de Relique +[Arg1], rafraîchir le compteur dans \"D-marque\" +1. Après la bataille, gagne 125 Le sigil noir. En le ramassant, tu peux choisir de supprimer jusqu'à 6 Cartes de symptôme."
  },
  RelicConfig_44656_Desc = {
    Text = "Limite de Relique +[Arg1], rafraîchir le compteur dans \"D-marque\" +1. Après la bataille, gagne 125 Le sigil noir. En le ramassant, tu peux choisir de supprimer jusqu'à 6 Cartes de symptôme."
  },
  RelicConfig_44656_Name = {
    Text = "<OrangeQuality:Bénédiction : Empreinte de jade>"
  },
  RelicConfig_44656_StoryDesc = {
    Text = "La rédemption de Dieu le Père a effacé la douleur"
  },
  RelicConfig_44658_BattleDesc = {
    Text = "Après avoir libéré l'exalter, gagnez [Arg1] points de pouvoir temporaire et volez à tous les ennemis [Arg1] points de <PowerIconKeywords: pouvoir> temporaire, si un seul ennemi, volez en plus [Arg2] points de <PowerIconKeywords: pouvoir> temporaire"
  },
  RelicConfig_44658_Desc = {
    Text = "Après avoir libéré l'exalter, gagnez [Arg1] points de pouvoir temporaire et volez à tous les ennemis [Arg1] points de <PowerIconKeywords: pouvoir> temporaire, si un seul ennemi, volez en plus [Arg2] points de <PowerIconKeywords: pouvoir> temporaire"
  },
  RelicConfig_44658_Name = {
    Text = "<OrangeQuality:Bénédiction : Oiseau du rituel funeste>"
  },
  RelicConfig_44658_StoryDesc = {
    Text = "La lumière du pardon enveloppait les restes avides, les oiseaux morts chantaient leur dernier chant"
  },
  RelicConfig_44659_BattleDesc = {
    Text = "Chaque fois que vous infligez 1 dégât actif, récupérez [Arg1] points de vie et appliquez [Arg2] niveaux <BleedingIconKeywords:saignement> à la cible de dégâts"
  },
  RelicConfig_44659_Desc = {
    Text = "Chaque fois que vous infligez 1 dégât actif, récupérez [Arg1] points de vie et appliquez [Arg2] niveaux <BleedingIconKeywords:saignement> à la cible de dégâts"
  },
  RelicConfig_44659_Name = {
    Text = "<OrangeQuality:Bénédiction : Conscience collective>"
  },
  RelicConfig_44659_StoryDesc = {
    Text = "Enroulement, symbiose, agrégation ; unité, coexistence, protection"
  },
  RelicConfig_44660_BattleDesc = {
    Text = "Limite de cartes à main augmentée de 5, complétez votre main à la limite au début du combat. Au début du tour, tirez 1 carte supplémentaire, et à la fin du tour, défaussez toutes les cartes de symptôme et d'état dans votre main, conservez les autres"
  },
  RelicConfig_44660_Desc = {
    Text = "Limite de cartes à main augmentée de 5, complétez votre main à la limite au début du combat. Au début du tour, tirez 1 carte supplémentaire, et à la fin du tour, défaussez toutes les cartes de symptôme et d'état dans votre main, conservez les autres"
  },
  RelicConfig_44660_Name = {
    Text = "<OrangeQuality:Bénédiction : Gravure de conscience>"
  },
  RelicConfig_44660_StoryDesc = {
    Text = "L'avide grave ses erreurs dans son cœur et cherche à racheter son passé"
  },
  RelicConfig_44662_BattleDesc = {
    Text = "Tous les 2 tours, doublez les Dommages actifs et les Dégâts des tentacules subis par tous les ennemis durant ce tour. Pour chaque Exaltation utilisée durant ce tour, dispersez aléatoirement 1 état négatif."
  },
  RelicConfig_44662_Desc = {
    Text = "Tous les 2 tours, doublez les Dommages actifs et les Dégâts des tentacules subis par tous les ennemis durant ce tour. Pour chaque Exaltation utilisée durant ce tour, dispersez aléatoirement 1 état négatif."
  },
  RelicConfig_44662_Name = {
    Text = "<OrangeQuality:Bénédiction : Cadavre du chemin>"
  },
  RelicConfig_44662_StoryDesc = {
    Text = "Une partie sacrée.\nMême séparée du tronc, ses traces sont partout"
  },
  RelicConfig_44663_BattleDesc = {
    Text = "Taux critique augmenté de 50 %, les dégâts critiques augmentés de 100 %"
  },
  RelicConfig_44663_Desc = {
    Text = "Taux critique augmenté de 50 %, les dégâts critiques augmentés de 100 %"
  },
  RelicConfig_44663_Name = {
    Text = "<OrangeQuality:Bénédiction : Griffe étrange>"
  },
  RelicConfig_44663_StoryDesc = {
    Text = "Tous les désirs sont abandonnés"
  },
  RelicConfig_44664_BattleDesc = {
    Text = "Après ramassage, gagnez définitivement [Arg1] <PowerIconKeywords:force>. Chaque fois que vous infligez des dégâts, récupérez [Arg2] points de vie, jusqu'à 6 fois par tour"
  },
  RelicConfig_44664_Desc = {
    Text = "Après ramassage, gagnez définitivement [Arg1] <PowerIconKeywords:force>. Chaque fois que vous infligez des dégâts, récupérez [Arg2] points de vie, jusqu'à 6 fois par tour"
  },
  RelicConfig_44664_Name = {
    Text = "<OrangeQuality:Bénédiction : Baiser de la lamproie>"
  },
  RelicConfig_44664_StoryDesc = {
    Text = "Refuse ce baiser de déchéance, les bras du Père sont plus chaleureux que toute obscurité"
  },
  RelicConfig_47444_BattleDesc = {
    Text = "\"Attaque\" et \"Défense\" gagnent 50 Keyflare supplémentaires. Chaque fois que vous jouez une carte avec un coût d'Arithmetica de 2 ou plus, piochez une carte avec un coût d'Arithmetica de 1 et réduisez son coût à 0, jusqu'à 3 fois par tour."
  },
  RelicConfig_47444_Desc = {
    Text = "\"Attaque\" et \"Défense\" gagnent 50 Keyflare supplémentaires. Chaque fois que vous jouez une carte avec un coût d'Arithmetica de 2 ou plus, piochez une carte avec un coût d'Arithmetica de 1 et réduisez son coût à 0, jusqu'à 3 fois par tour."
  },
  RelicConfig_47444_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Âmes Sœurs\">"
  },
  RelicConfig_50338_BattleDesc = {
    Text = "Au début de la bataille, mélangez tous les <ExaltIconKeywords:réveils> des Réveilleurs dans la pioche. Après le sixième tour, Thais fournira un soutien au combat à chaque tour"
  },
  RelicConfig_50338_Desc = {
    Text = "Au début de la bataille, mélangez tous les <ExaltIconKeywords:réveils> des Réveilleurs dans la pioche. Après le sixième tour, Thais fournira un soutien au combat à chaque tour"
  },
  RelicConfig_50338_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Passion\">"
  },
  RelicConfig_50338_StoryDesc = {
    Text = "Il a dit, n'aie pas peur"
  },
  RelicConfig_50385_BattleDesc = {
    Text = "Après la collecte, choisir une carte, rendant son coût en arithmétique permanent à 1"
  },
  RelicConfig_50385_Desc = {
    Text = "Après la collecte, choisir une carte, rendant son coût en arithmétique permanent à 1"
  },
  RelicConfig_50385_Name = {
    Text = "<WhiteQuality:☆Pupille épuisée☆>"
  },
  RelicConfig_50385_StoryDesc = {
    Text = "Sans l'eau précieuse du désert, ses yeux sont devenus secs"
  },
  RelicConfig_50487_BattleDesc = {
    Text = "Au début du premier tour de bataille, ajoute <DerivativeCardKeywords_46:\"Virus Prion\"> à ta main ; au 3ème tour, ajoute <DerivativeCardKeywords_49:\"Attaque gloutonne\"> à ta main ; après avoir déclenché la Résistance, ajoute <DerivativeCardKeywords_52:\"Cocon de Revival\"> à ta main."
  },
  RelicConfig_50487_Desc = {
    Text = "Au début du premier tour de bataille, ajoute <DerivativeCardKeywords_46:\"Virus Prion\"> à ta main ; au 3ème tour, ajoute <DerivativeCardKeywords_49:\"Attaque gloutonne\"> à ta main ; après avoir déclenché la Résistance, ajoute <DerivativeCardKeywords_52:\"Cocon de Revival\"> à ta main."
  },
  RelicConfig_50487_Name = {
    Text = "<OrangeQuality:Pendule Chrono \"La Bénédiction\">"
  },
  RelicConfig_50488_BattleDesc = {
    Text = "À la fin du tour : l'éveillé avec le moins de folie gagne 35 points de folie. Si la vie restante est ≥ 50%, gagnez [Arg1] points de <PowerIconKeywords:force>. Si la vie restante est < 50%, récupérez [Arg2] points de vie"
  },
  RelicConfig_50488_Desc = {
    Text = "À la fin du tour : l'éveillé avec le moins de folie gagne 35 points de folie. Si la vie actuelle est ≥ 50%, gagnez [Arg1] points de <PowerIconKeywords:force>. Si la vie actuelle est < 50%, récupérez [Arg2] points de vie"
  },
  RelicConfig_50488_Name = {
    Text = "<OrangeQuality:Pendule Chrono \"Équilibrer\">"
  },
  RelicConfig_50489_BattleDesc = {
    Text = "Taux critique et dommages critiques augmentent de 100 %. Pour chaque point de dégâts infligé, les coups critiques et les dommages critiques de tous les éveillés diminuent de 10 %, au maximum de 50 %. Pour chaque point de dégâts infligé, le poison infligé et la contre-attaque augmentent de 10 %, au maximum de 50 %."
  },
  RelicConfig_50489_Desc = {
    Text = "Taux critique et dégâts critiques augmentent de 100 %. Pour chaque point de dégâts infligé/dégâts de tentacule, ce tour : tous les dégâts critiques des réveilleurs diminuent de 10 %, au maximum de 50 %. Le poison infligé et le contre-offensif augmentent de 10 %, au maximum de 50 %"
  },
  RelicConfig_50489_Name = {
    Text = "<OrangeQuality:Chrono Pendulum\"Flow Surge\">"
  },
  RelicConfig_51686_BattleDesc = {
    Text = "Chaque fois qu'une carte d'instruction appartenant à un éveillé différent de la précédente est jouée, l'éveillé correspondant gagne 3 points de fureur et accumule 1 niveau de « vitalité ». Lorsque 10 niveaux sont accumulés, toutes les « vitalités » sont réinitialisées, et une carte d'instruction aléatoire avec un coût d'arithmetica réduit de 1 et ayant « consommation » est placée dans la main de chaque éveillé, effect déclenchable jusqu'à 1 fois par tour."
  },
  RelicConfig_51686_Desc = {
    Text = "Chaque fois qu'une carte d'instruction appartenant à un éveillé différent de la précédente est jouée, l'éveillé concerné gagne 3 points de fureur et accumule 1 niveau de « vitalité ». Lorsque 10 niveaux sont accumulés, tous les niveaux de « vitalité » sont réinitialisés, et une carte d'instruction aléatoire avec un coût d'arithmetica réduit de 1 et possédant « consommation » est ajoutée à la main de chaque éveillé, déclenchable une seule fois par tour."
  },
  RelicConfig_51686_Name = {
    Text = "<OrangeQuality:Chrono Pendulum\"Evolution\">"
  },
  RelicConfig_51687_BattleDesc = {
    Text = "Après avoir joué une carte d'instruction qui n'est ni « Attaque » ni « Défense », si cette carte n'est pas une carte dérivée, l'Éveilleur correspondant gagne 15 points de Fureur, déclenchable jusqu'à 5 fois par tour. Lors de la première activation de chaque tour, la carte jouée est également renvoyée dans la main."
  },
  RelicConfig_51687_Desc = {
    Text = "Après avoir joué une Carte d'instruction qui n'est pas « Attaque » ou « Défense », si cette carte n'est pas une Carte Dérivée, le Corps éveillé correspondant gagne 15 Aliemus, déclenchable jusqu'à 5 fois par tour. Lors du premier déclenchement de chaque tour, la carte jouée est également renvoyée dans la main."
  },
  RelicConfig_51687_Name = {
    Text = "<OrangeQuality:Pendule Chrono \"Projection\">"
  },
  RelicConfig_51688_BattleDesc = {
    Text = "En ramassant, ajoutez « réservée » à toutes les cartes de commandement. À la fin du tour, si le nombre de cartes en main est supérieur ou égal à 5, réduisez de 1 la consommation d'arithmetica de 3 cartes en main au hasard, sinon, tirez 3 cartes"
  },
  RelicConfig_51688_Desc = {
    Text = "En ramassant, ajoutez « réservée » à toutes les cartes de commandement. À la fin du tour, si le nombre de cartes en main est supérieur ou égal à 5, réduisez de 1 la consommation d'arithmetica de 3 cartes en main au hasard, sinon, tirez 3 cartes"
  },
  RelicConfig_51688_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Lit Chaud\">"
  },
  RelicConfig_51689_BattleDesc = {
    Text = "Au début du combat, placez 3 cartes de symptômes aléatoires dans le deck. Au début du tour, piochez 1 carte. Chaque fois que vous jouez une carte de symptômes, gagnez 2 points d'arithmétique. Pour chaque carte de symptômes défaussée, tous les éveilleurs gagnent 5 points de fureur, déclenchable jusqu'à 5 fois par tour."
  },
  RelicConfig_51689_Desc = {
    Text = "Au début du combat, placez 3 cartes de symptômes aléatoires dans la pile de cartes. Au début du tour, tirez 1 carte. Pour chaque carte de symptômes jouée, gagnez 2 points d'arithmetica. Pour chaque carte de symptômes défaussée, tous les éveilleurs gagnent 5 points de fureur, pouvant se déclencher jusqu'à 5 fois par tour."
  },
  RelicConfig_51689_Name = {
    Text = "<OrangeQuality:Chrono Pendulum\"Plague\">"
  },
  RelicConfig_55847_BattleDesc = {
    Text = "Simulation Set de 7 Artefacts Standards"
  },
  RelicConfig_55847_Desc = {
    Text = "Simulation Set de 7 Artefacts Standards"
  },
  RelicConfig_55847_Name = {
    Text = "<RedQuality:☆Création de simulation☆>"
  },
  RelicConfig_55847_StoryDesc = {
    Text = "Dans l'ère étrange, les fleurs sont les premiers spectateurs des humains.\nNe bouge pas, elles préfèrent les expositions calmes"
  },
  RelicConfig_55874_BattleDesc = {
    Text = "Après le combat, obtenez [Arg1] couches de «l'empreinte», lorsque «l'empreinte» atteint 2 couches, consommez, placez aléatoirement 1 «image» dans la pioche"
  },
  RelicConfig_55874_Desc = {
    Text = "Après le combat, obtenez [Arg1] couches de «l'empreinte», lorsque «l'empreinte» atteint 2 couches, consommez, placez aléatoirement 1 «image» dans la pioche"
  },
  RelicConfig_55874_Name = {
    Text = "<OrangeQuality: La plume et l'encre d'horla>"
  },
  RelicConfig_55874_StoryDesc = {
    Text = "Les péchés anciens sont gravés ici"
  },
  RelicConfig_56355_BattleDesc = {
    Text = "Limite de cartes à main +2, au début du tour, tirez 1 carte. À la fin du combat, gagnez [Arg1] couches « encre », lorsque « encre » atteint 2 couches, défaussez-la, choisissez de placer 1 carte « image » dans la pioche"
  },
  RelicConfig_56355_Desc = {
    Text = "Limite de cartes à main +2, au début du tour, tirez 1 carte. À la fin du combat, gagnez [Arg1] couches « encre », lorsque « encre » atteint 2 couches, défaussez-la, choisissez de placer 1 carte « image » dans la pioche"
  },
  RelicConfig_56355_Name = {
    Text = "<OrangeQuality: La plume et l'encre d'horla>"
  },
  RelicConfig_56355_StoryDesc = {
    Text = "Les péchés anciens sont gravés ici"
  },
  RelicConfig_56356_BattleDesc = {
    Text = "Après le combat, obtenez [Arg1] couches de «l'empreinte», lorsque «l'empreinte» atteint 2 couches, consommez, choisissez de placer 1 «image» dans la pioche"
  },
  RelicConfig_56356_Desc = {
    Text = "Après le combat, obtenez [Arg1] couches de «l'empreinte», lorsque «l'empreinte» atteint 2 couches, consommez, choisissez de placer 1 «image» dans la pioche"
  },
  RelicConfig_56356_Name = {
    Text = "<OrangeQuality: La plume et l'encre d'horla>"
  },
  RelicConfig_56356_StoryDesc = {
    Text = "Les péchés anciens sont gravés ici"
  },
  RelicConfig_57667_BattleDesc = {
    Text = "Vous commencez avec 2 niveaux de Pouvoir de la Mère Divine. Après le troisième tour, au début de chaque tour, vous pouvez choisir de consommer le Pouvoir de la Mère Divine pour obtenir différents effets ou de récupérer du Pouvoir de la Mère Divine. Si vous subissez des dégâts mortels, vous ressuscitez et consommez tous les niveaux de Pouvoir de la Mère Divine, récupérant 10 % de vos PV par niveau, et cela ne peut se produire qu'une seule fois."
  },
  RelicConfig_57667_Desc = {
    Text = "Commencez avec 2 niveaux de Pouvoir de la Mère Divine. Après le troisième tour, au début de chaque tour, vous pouvez choisir de consommer le Pouvoir de la Mère pour obtenir différents effets ou de récupérer le Pouvoir de la Mère. Si vous subissez des dégâts mortels, vous ressuscitez et consommez tous les Pouvoirs de la Mère, récupérant 10 % de PV par niveau, ce qui ne peut se produire qu'une seule fois."
  },
  RelicConfig_57667_Name = {
    Text = "<OrangeQuality:Protection de la déesse mère>"
  },
  RelicConfig_57732_BattleDesc = {
    Text = "Tous les réveilleurs augmentent leur taux critique de 15%. Les effets aléatoires finaux de Ryker et des dés augmentent de 1"
  },
  RelicConfig_57732_Desc = {
    Text = "Tous les réveilleurs augmentent leur taux critique de 15%. Les effets aléatoires finaux de Ryker et des dés augmentent de 1"
  },
  RelicConfig_57732_Name = {
    Text = "<OrangeQuality:Manteau porte-bonheur>"
  },
  RelicConfig_57732_StoryDesc = {
    Text = "Il érige une épaisse barrière pour repousser le vent, la pluie et la malchance."
  },
  RelicConfig_57733_BattleDesc = {
    Text = "Au début du tour et lors du déclenchement de l'effet aléatoire de Ryker ou des dés, obtient 100 points de s-énergie et 4 % de dégâts critiques, maximum 50 % de dégâts critiques, retiré à la fin du combat"
  },
  RelicConfig_57733_Desc = {
    Text = "Au début du tour et lors du déclenchement de l'effet aléatoire de Ryker ou des dés, obtient 100 points de s-énergie et 4 % de dégâts critiques, maximum 50 % de dégâts critiques, retiré à la fin du combat"
  },
  RelicConfig_57733_Name = {
    Text = "<OrangeQuality:Grosse boutonnière>"
  },
  RelicConfig_57733_StoryDesc = {
    Text = [[
Le bouton gueule grande aime tout ce qui est rond, comme la lune, les jetons et les yeux frais. 
 Il crachera une brume noire lors d'une nuit de pleine lune, pour des raisons inconnues.]]
  },
  RelicConfig_57734_BattleDesc = {
    Text = "Après avoir libéré une clé, ajoutez une carte \"Dé à Remède Brillant\" dans votre main"
  },
  RelicConfig_57734_Desc = {
    Text = "Après avoir libéré une clé, ajoutez une carte \"Dé à Remède Brillant\" dans votre main"
  },
  RelicConfig_57734_Name = {
    Text = "<OrangeQuality:Dés brillants>"
  },
  RelicConfig_57734_StoryDesc = {
    Text = "Ce qui brille n'est pas seulement la surface, mais aussi le cœur inflexible.\nRegarde-le pendant plus de cinq secondes, et tu invoqueras @2."
  },
  RelicConfig_57735_BattleDesc = {
    Text = "Au début du tour et lors du déclenchement de l'effet aléatoire de Ryker ou des dés, obtient 50 points de s-énergie et 2 % de dégâts critiques, maximum 30 % de dégâts critiques, retiré à la fin du combat"
  },
  RelicConfig_57735_Desc = {
    Text = "Au début du tour et lors du déclenchement de l'effet aléatoire de Ryker ou des dés, obtient 50 points de s-énergie et 2 % de dégâts critiques, maximum 30 % de dégâts critiques, retiré à la fin du combat"
  },
  RelicConfig_57735_Name = {
    Text = "<OrangeQuality:Bouton à grande bouche>"
  },
  RelicConfig_57735_StoryDesc = {
    Text = [[
Le bouton gueule grande aime tout ce qui est rond, comme la lune, les jetons et les yeux frais. 
 Il crachera une brume noire lors d'une nuit de pleine lune, pour des raisons inconnues.]]
  },
  RelicConfig_57736_BattleDesc = {
    Text = "Après avoir libéré une clé, ajoutez une carte \"Dé à Remède\" dans votre main"
  },
  RelicConfig_57736_Desc = {
    Text = "Après avoir libéré une clé, ajoutez une carte \"Dé à Remède\" dans votre main"
  },
  RelicConfig_57736_Name = {
    Text = "<OrangeQuality:Dés de remède>"
  },
  RelicConfig_57736_StoryDesc = {
    Text = "Ce qui brille n'est pas seulement la surface, mais aussi le cœur inflexible.\nRegarde-le pendant plus de cinq secondes, et tu invoqueras @2."
  },
  RelicConfig_57737_BattleDesc = {
    Text = "Tous les réveilleurs augmentent leur taux critique de 10%. Tous les effets aléatoires de Ryker et des dés n'atteindront pas leur valeur minimale"
  },
  RelicConfig_57737_Desc = {
    Text = "Tous les réveilleurs augmentent leur taux critique de 10%. Tous les effets aléatoires de Ryker et des dés n'atteindront pas leur valeur minimale"
  },
  RelicConfig_57737_Name = {
    Text = "<OrangeQuality:Manteau de chance>"
  },
  RelicConfig_57737_StoryDesc = {
    Text = "Il érige une épaisse barrière pour repousser le vent, la pluie et la malchance."
  },
  RelicConfig_57791_BattleDesc = {
    Text = "Limite de Relique +1. Dans les cinq premiers rounds de bataille, gagne une Relique au début de chaque round, y compris \"Broche Rubis, Agate Étrangleuse, Signal SOS, Oiseau Annonceur de Malheur, Pendule Chrono·Enchantement\"."
  },
  RelicConfig_57791_Desc = {
    Text = "Limite de Relique +1. Dans les cinq premiers rounds de bataille, gagne une Relique au début de chaque round, y compris \"Broche Rubis, Agate Étrangleuse, Signal SOS, Oiseau Annonceur de Malheur, Pendule Chrono·Enchantement\"."
  },
  RelicConfig_57791_Name = {
    Text = "<OrangeQuality:Pendule Chrono \"Trésor Englouti\">"
  },
  RelicConfig_57791_StoryDesc = {
    Text = "La légende dit que Lémuria a sombré dans ces eaux. Qui pourrait résister à l'envie d'explorer les secrets des trésors des épaves ?"
  },
  RelicConfig_57792_BattleDesc = {
    Text = "+1 emplacement de relique. Obtenez une relique au début de chacun des cinq premiers tours en bataille : \"Trident, Carnet de Vaccins de L'Étranger, Dossier d'Arcana, Gravure Mentale, Pendule Chrono·Charge\"."
  },
  RelicConfig_57792_Desc = {
    Text = "+1 emplacement de relique. Obtenez une relique au début de chacun des cinq premiers tours en bataille : \"Trident, Carnet de Vaccins de L'Étranger, Dossier d'Arcana, Gravure Mentale, Pendule Chrono·Charge\"."
  },
  RelicConfig_57792_Name = {
    Text = "<OrangeQuality:Pendule Chrono \"Trésor Englouti\">"
  },
  RelicConfig_57792_StoryDesc = {
    Text = "La légende dit que Lémuria a sombré dans ces eaux. Qui peut résister à l'envie d'explorer le secret des trésors engloutis ?"
  },
  RelicConfig_57793_BattleDesc = {
    Text = "Limite de Relique +1. Dans les cinq premiers rounds de bataille, au début de chaque round, gagne une relique, y compris \"Mâchoire Laser, Pommade Suspecte, Machine à Coudre Poussiéreuse, Langue de Xénotype, Pendule Chrono·Reflux\"."
  },
  RelicConfig_57793_Desc = {
    Text = "Limite de Relique +1. Dans les cinq premiers rounds de bataille, au début de chaque round, gagne une relique, y compris \"Mâchoire Laser, Pommade Suspecte, Machine à Coudre Poussiéreuse, Langue de Xénotype, Pendule Chrono·Reflux\"."
  },
  RelicConfig_57793_Name = {
    Text = "<OrangeQuality:Pendule Chrono \"Trésor Englouti\">"
  },
  RelicConfig_57793_StoryDesc = {
    Text = "La légende dit que Lémuria a sombré dans ces eaux. Qui peut résister à l'envie d'explorer le secret des trésors engloutis ?"
  },
  RelicConfig_57794_BattleDesc = {
    Text = "Limite de Relique +1. Dans les cinq premiers rounds de bataille, au début de chaque round, gagne une relique, y compris \"Gilet Ortie, Montre de Poche Héréditaire, Extrait des Anciens, Limbe de Soulagement, Pendule Chrono·Prolifération\"."
  },
  RelicConfig_57794_Desc = {
    Text = "Limite de Relique +1. Dans les cinq premiers rounds de bataille, au début de chaque round, gagne une relique, y compris \"Gilet Ortie, Montre de Poche Héréditaire, Extrait des Anciens, Limbe de Soulagement, Pendule Chrono·Prolifération\"."
  },
  RelicConfig_57794_Name = {
    Text = "<OrangeQuality:Pendule Chrono \"Trésor Englouti\">"
  },
  RelicConfig_57794_StoryDesc = {
    Text = "La légende dit que Lémuria a sombré dans ces eaux. Qui peut résister à l'envie d'explorer les secrets des trésors de navires coulés ?"
  },
  RelicConfig_57795_BattleDesc = {
    Text = "Limite de Relique +1. Dans les cinq premiers rounds de bataille, au début de chaque round, gagne une relique, y compris \"Lame de Saule Roussie, Hémostat, Ancien Puzzle, Conscience de Nuée, Pendule Chrono·Néféré\"."
  },
  RelicConfig_57795_Desc = {
    Text = "Limite de Relique +1. Dans les cinq premiers rounds de bataille, au début de chaque round, gagne une relique, y compris \"Lame de Saule Roussie, Hémostat, Ancien Puzzle, Conscience de Nuée, Pendule Chrono·Néféré\"."
  },
  RelicConfig_57795_Name = {
    Text = "<OrangeQuality:Pendule Chrono \"Trésor Englouti\">"
  },
  RelicConfig_57795_StoryDesc = {
    Text = "La légende dit que Lémuria a sombré dans ces eaux. Qui peut résister à l'envie d'explorer les secrets des trésors engloutis ?"
  },
  RelicConfig_57796_BattleDesc = {
    Text = "Limite de Relique +1. Dans les cinq premiers rounds de bataille, gagne une Relique au début de chaque round, y compris \"Minuteur de Précision, Boutons de Manchette de Feuille de Laurier, Voile du Dieu Sans Nom, Façade de Cauchemar, Pendule Chrono·Équilibre\"."
  },
  RelicConfig_57796_Desc = {
    Text = "Limite de Relique +1. Dans les cinq premiers rounds de bataille, gagne une Relique au début de chaque round, y compris \"Minuteur de Précision, Boutons de Manchette de Feuille de Laurier, Voile du Dieu Sans Nom, Façade de Cauchemar, Pendule Chrono·Équilibre\"."
  },
  RelicConfig_57796_Name = {
    Text = "<OrangeQuality:Pendule Chrono \"Trésor Englouti\">"
  },
  RelicConfig_57796_StoryDesc = {
    Text = "La légende dit que Lémuria a sombré dans ces eaux. Qui peut résister à l'envie d'explorer le secret des trésors engloutis ?"
  },
  RelicConfig_57797_BattleDesc = {
    Text = "Limite de Relique +1. Dans les cinq premiers rounds de bataille, gagne une relique au début de chaque round, y compris \"Portefeuille Neuf, Emblème Mythag, Vin des Étoiles, Baiser de la Lamproie, Pendule Chrono·Œil\"."
  },
  RelicConfig_57797_Desc = {
    Text = "Limite de Relique +1. Dans les cinq premiers rounds de bataille, gagne une relique au début de chaque round, y compris \"Portefeuille Neuf, Emblème Mythag, Vin des Étoiles, Baiser de la Lamproie, Pendule Chrono·Œil\"."
  },
  RelicConfig_57797_Name = {
    Text = "<OrangeQuality:Pendule Chrono \"Trésor Englouti\">"
  },
  RelicConfig_57797_StoryDesc = {
    Text = "La légende dit que Lémuria a sombré dans ces eaux. Qui peut résister à l'envie de découvrir le secret des trésors engloutis ?"
  },
  RelicConfig_58872_BattleDesc = {
    Text = "Au début du combat, la limite de calcul est augmentée de 1, réveille tous les réveilleurs. Pendant les 5 prochains tours, au début de chaque tour, un artefact sera obtenu, comme \"épée en feuille rouillée, nouvel axe, notre maison, crochet étrange, pendule chronique·envoûtement\""
  },
  RelicConfig_58872_Desc = {
    Text = "Au début du combat, la limite de calcul est augmentée de 1, réveille tous les réveilleurs. Pendant les 5 prochains tours, au début de chaque tour, un artefact sera obtenu, comme \"épée en feuille rouillée, nouvel axe, notre maison, crochet étrange, pendule chronique·envoûtement\""
  },
  RelicConfig_58872_Name = {
    Text = "<OrangeQuality:Chrono Pendulum\"Secret Treasure α\">"
  },
  RelicConfig_58873_BattleDesc = {
    Text = "Au début du combat, la limite de calcul est augmentée de 1, réveille tous les réveilleurs. Pendant les 5 prochains tours, au début de chaque tour, un artefact sera obtenu, comme \"encre douce, phonographe silencieux, vin des étoiles, chapeau magique, pendule chronique·flux\""
  },
  RelicConfig_58873_Desc = {
    Text = "Au début du combat, la limite de calcul est augmentée de 1, réveille tous les réveilleurs. Pendant les 5 prochains tours, au début de chaque tour, un artefact sera obtenu, comme \"encre douce, phonographe silencieux, vin des étoiles, chapeau magique, pendule chronique·flux\""
  },
  RelicConfig_58873_Name = {
    Text = "<OrangeQuality:Chrono Pendulum\"Secret Treasure β\">"
  },
  RelicConfig_59118_BattleDesc = {
    Text = "Au début du tour, gagnez 1 « Dé Chanceux de Ryker », augmentant le résultat du lancer de dés de +1. Au début du tour et après chaque lancer de dés, tous les Réveilleurs gagnent 4 % de Dégâts Critiques, jusqu'à un maximum de 100 %."
  },
  RelicConfig_59118_Desc = {
    Text = "Au début du tour, gagnez 1 « Dé Chanceux de Ryker », augmentant le résultat du lancer de dés de +1. Au début du tour et après chaque lancer de dés, tous les Réveilleurs gagnent 4 % de Dégâts Critiques, jusqu'à un maximum de 100 %."
  },
  RelicConfig_59118_Name = {
    Text = "<OrangeQuality: Pendule Chrono \"Cadeau du Chaos\">"
  },
  RelicConfig_59118_StoryDesc = {
    Text = "Les péchés anciens sont gravés ici"
  },
  RelicConfig_59687_BattleDesc = {
    Text = "Simulation Set de 7 Artefacts Standards"
  },
  RelicConfig_59687_Desc = {
    Text = "Simulation Set de 7 Artefacts Standards"
  },
  RelicConfig_59687_Name = {
    Text = "<RedQuality:☆Création de simulation☆>"
  },
  RelicConfig_59687_StoryDesc = {
    Text = "Dans l'ère étrange, les fleurs sont les premiers spectateurs des humains.\nNe bouge pas, elles préfèrent les expositions calmes"
  },
  RelicConfig_60723_BattleDesc = {
    Text = "Capacité maximale augmentée de 1, au début du tour, piochez 1 carte supplémentaire, vous obtiendrez 1 carte « Symphonie de l'Harmonie ». Si 3 cartes d'instruction consécutives ont le même coût d'arithmetica, tous les éveilleurs obtiennent 20 points de fureur, le nombre de déclenchements est réinitialisé au début du tour et après le déclenchement."
  },
  RelicConfig_60723_Desc = {
    Text = "Arithmetica Max augmenté de 1, au début du tour, piochez 1 carte supplémentaire, vous obtiendrez 1 carte « Symphonie de l'Harmonie ». Lorsque 3 cartes d'instruction consécutives sont jouées avec la même consommation d'arithmétique, tous les éveilleurs obtiennent 20 points de fureur, le nombre de déclenchements est réinitialisé au début du tour et après le déclenchement."
  },
  RelicConfig_60723_Name = {
    Text = "<OrangeQuality:Baguette de chef d'orchestre>"
  },
  RelicConfig_60723_StoryDesc = {
    Text = "Une fine baguette de chef d'orchestre, mais possédant une force plus grande qu'un pied-de-biche.\n\n Diriger des notes, diriger des âmes, diriger le destin."
  },
  RelicConfig_60724_BattleDesc = {
    Text = "Au début du combat, gagnez les oraisons de « vulnérable » et « explosion » ainsi que leurs oraisons avancées, choisissez les oraisons à apposer sur les cartes"
  },
  RelicConfig_60724_Desc = {
    Text = "Au début du combat, gagnez les oraisons de « vulnérable » et « explosion » ainsi que leurs oraisons avancées, choisissez les oraisons à apposer sur les cartes"
  },
  RelicConfig_60724_Name = {
    Text = "<OrangeQuality:Pendule Chrono \"Message du Principal\">"
  },
  RelicConfig_60724_StoryDesc = {
    Text = "Les mots du fondateur de Mythag résonnent dans tes oreilles.\n\nQue la clé argentée éclaire ton chemin, gardien de Mythag."
  },
  RelicConfig_60725_BattleDesc = {
    Text = "Au début du combat, gagnez les oraisons de « aliemus » et « catalyse » ainsi que leurs oraisons avancées, choisissez les oraisons à apposer sur les cartes"
  },
  RelicConfig_60725_Desc = {
    Text = "Au début du combat, gagnez les oraisons de « aliemus » et « catalyse » ainsi que leurs oraisons avancées, choisissez les oraisons à apposer sur les cartes"
  },
  RelicConfig_60725_Name = {
    Text = "<OrangeQuality:Pendule Chrono \"Message du Principal\">"
  },
  RelicConfig_60725_StoryDesc = {
    Text = "Les mots du fondateur de Mythag résonnent dans tes oreilles.\n\nQue la clé argentée éclaire ton chemin, gardien de Mythag."
  },
  RelicConfig_60726_BattleDesc = {
    Text = "Au début du combat, gagnez les oraisons de « faiblesse » et « planification » ainsi que leurs oraisons avancées, choisissez les oraisons à apposer sur les cartes"
  },
  RelicConfig_60726_Desc = {
    Text = "Au début du combat, gagnez les oraisons de « faiblesse » et « planification » ainsi que leurs oraisons avancées, choisissez les oraisons à apposer sur les cartes"
  },
  RelicConfig_60726_Name = {
    Text = "<OrangeQuality:Pendule Chrono \"Message du Principal\">"
  },
  RelicConfig_60726_StoryDesc = {
    Text = "Les mots du fondateur de Mythag résonnent dans tes oreilles.\n\nQue la clé argentée éclaire ton chemin, gardien de Mythag."
  },
  RelicConfig_60727_BattleDesc = {
    Text = "Au début du combat, gagnez les oraisons de « mur de fer » et « main habile » ainsi que leurs oraisons avancées, choisissez les oraisons à apposer sur les cartes"
  },
  RelicConfig_60727_Desc = {
    Text = "Au début du combat, gagnez les oraisons de « mur de fer » et « main habile » ainsi que leurs oraisons avancées, choisissez les oraisons à apposer sur les cartes"
  },
  RelicConfig_60727_Name = {
    Text = "<OrangeQuality:Pendule Chrono \"Message du Principal\">"
  },
  RelicConfig_60727_StoryDesc = {
    Text = "Les mots du fondateur de Mythag résonnent dans tes oreilles.\n\nQue la clé argentée éclaire ton chemin, gardien de Mythag."
  },
  RelicConfig_60728_BattleDesc = {
    Text = "Au début du combat, gagnez les oraisons de « gestation » et « écho » ainsi que leurs oraisons avancées, choisissez les oraisons à apposer sur les cartes"
  },
  RelicConfig_60728_Desc = {
    Text = "Au début du combat, gagnez les oraisons de « gestation » et « écho » ainsi que leurs oraisons avancées, choisissez les oraisons à apposer sur les cartes"
  },
  RelicConfig_60728_Name = {
    Text = "<OrangeQuality:Pendule Chrono \"Message du Principal\">"
  },
  RelicConfig_60728_StoryDesc = {
    Text = "Les mots du fondateur de Mythag résonnent dans tes oreilles.\n\nQue la clé argentée éclaire ton chemin, gardien de Mythag."
  },
  RelicConfig_60729_BattleDesc = {
    Text = "Au début du combat, gagnez les oraisons de « main habile » et « inspiration » ainsi que leurs oraisons avancées, choisissez les oraisons à apposer sur les cartes"
  },
  RelicConfig_60729_Desc = {
    Text = "Au début du combat, gagnez les oraisons de « main habile » et « inspiration » ainsi que leurs oraisons avancées, choisissez les oraisons à apposer sur les cartes"
  },
  RelicConfig_60729_Name = {
    Text = "<OrangeQuality:Pendule Chrono \"Message du Principal\">"
  },
  RelicConfig_60729_StoryDesc = {
    Text = "Les mots du fondateur de Mythag résonnent dans tes oreilles.\n\nQue la clé argentée éclaire ton chemin, gardien de Mythag."
  },
  RelicConfig_60730_BattleDesc = {
    Text = "Au début du combat, gagnez les oraisons de « force brute » et « épuisement » ainsi que leurs oraisons avancées, choisissez les oraisons à apposer sur les cartes"
  },
  RelicConfig_60730_Desc = {
    Text = "Au début du combat, gagnez les oraisons de « force brute » et « épuisement » ainsi que leurs oraisons avancées, choisissez les oraisons à apposer sur les cartes"
  },
  RelicConfig_60730_Name = {
    Text = "<OrangeQuality:Pendule Chrono \"Message du Principal\">"
  },
  RelicConfig_60730_StoryDesc = {
    Text = "Les mots du fondateur de Mythag résonnent dans tes oreilles.\n\nQue la clé argentée éclaire ton chemin, gardien de Mythag."
  },
  RelicConfig_60731_BattleDesc = {
    Text = "Au début du combat, gagnez 2 oraisons de « concert » et leurs oraisons avancées, choisissez les oraisons à apposer sur les cartes"
  },
  RelicConfig_60731_Desc = {
    Text = "Au début du combat, gagnez 2 oraisons de « concert » et leurs oraisons avancées, choisissez les oraisons à apposer sur les cartes"
  },
  RelicConfig_60731_Name = {
    Text = "<OrangeQuality:Pendule Chrono \"Message du Principal\">"
  },
  RelicConfig_60731_StoryDesc = {
    Text = "Les mots du fondateur de Mythag résonnent dans tes oreilles.\n\nQue la clé argentée éclaire ton chemin, gardien de Mythag."
  },
  RelicConfig_60732_BattleDesc = {
    Text = "Au début du combat, gagnez les oraisons de « planification » et « image » ainsi que leurs oraisons avancées, choisissez les oraisons à apposer sur les cartes"
  },
  RelicConfig_60732_Desc = {
    Text = "Au début du combat, gagnez les oraisons de « planification » et « image » ainsi que leurs oraisons avancées, choisissez les oraisons à apposer sur les cartes"
  },
  RelicConfig_60732_Name = {
    Text = "<OrangeQuality:Pendule Chrono \"Message du Principal\">"
  },
  RelicConfig_60732_StoryDesc = {
    Text = "Les mots du fondateur de Mythag résonnent dans tes oreilles.\n\nQue la clé argentée éclaire ton chemin, gardien de Mythag."
  },
  RelicConfig_65376_BattleDesc = {
    Text = "Le groupe de recherche initial comprend [Arg1] membres. Au début du combat, placez 5 cartes <DerivativeCardKeywords_73:suspicions> dans la pioche"
  },
  RelicConfig_65376_Desc = {
    Text = "L'Équipe de Recherche initiale comprend [Arg1] membres. Au début du combat, mélangez 5 cartes <DerivativeCardKeywords_73:Soupçon> dans la pioche."
  },
  RelicConfig_65376_Name = {
    Text = "<OrangeQuality:Expédition scientifique>"
  },
  RelicConfig_65376_StoryDesc = {
    Text = "Les mots du fondateur de Mythag résonnent dans tes oreilles.\n\nQue la clé argentée éclaire ton chemin, gardien de Mythag."
  },
  RelicConfig_65406_BattleDesc = {
    Text = "Au début du tour, obtenez [Arg1] <DerivativeCardKeywords_71:\"Lueur Radieuse de l'Humanité\">.\n<D05EX_Relic:Tous vos efforts valent la peine ; vous avez presque sauvé l'équipe de recherche, et les survivants vous sont sincèrement reconnaissants.>"
  },
  RelicConfig_65406_Desc = {
    Text = "Au début du tour, obtenez [Arg1] <DerivativeCardKeywords_71:\"Lueur Radieuse de l'Humanité\">.\n<D05EX_Relic:Tous vos efforts valent la peine ; vous avez presque sauvé l'équipe de recherche, et les survivants vous sont sincèrement reconnaissants.>"
  },
  RelicConfig_65406_Name = {
    Text = "<OrangeQuality:Médaille de sauvetage en platine>"
  },
  RelicConfig_65406_StoryDesc = {
    Text = "Tous tes efforts en valaient la peine, tu as presque sauvé l'équipe de recherche, les survivants te sont sincèrement reconnaissants"
  },
  RelicConfig_65407_BattleDesc = {
    Text = "Au début du tour, gagnez [Arg1] <DerivativeCardKeywords_72:\"Éclat Humain Brillant\">.\n<D05EX_Relic:Vous avez créé un miracle incroyable; tout le monde a survécu après le désastre, et vous êtes salué comme un grand héros. Votre légende se répandra bientôt à travers la montagne enneigée.>"
  },
  RelicConfig_65407_Desc = {
    Text = "Au début du tour, gagnez [Arg1] <DerivativeCardKeywords_72:\"Éclat Humain Brillant\">.\n<D05EX_Relic:Vous avez créé un miracle incroyable; tout le monde a survécu après le désastre, et vous êtes salué comme un grand héros. Votre légende se répandra bientôt à travers la montagne enneigée.>"
  },
  RelicConfig_65407_Name = {
    Text = "<OrangeQuality:Médaille de sauvetage en diamant>"
  },
  RelicConfig_65407_StoryDesc = {
    Text = "Vous avez accompli un miracle incroyable, tous ont survécu à la catastrophe. Vous êtes devenu le grand héros dans le cœur des gens, et votre légende pourrait se répandre autour de la montagne de neige"
  },
  RelicConfig_65408_BattleDesc = {
    Text = "Au début du tour, gagnez [Arg1] <DerivativeCardKeywords_68:\"Évanouissement de l'Homme Radieux\">.\n<D05EX_Relic:Pour échapper à la montagne enneigée, vous avez adopté une stratégie prioritaires sur l'efficacité, regardant les gens périr un par un. Les yeux des survivants tenaient plus de peur que de gratitude.>"
  },
  RelicConfig_65408_Desc = {
    Text = "Au début du tour, gagnez [Arg1] <DerivativeCardKeywords_68:\"Évanouissement de l'Homme Radieux\">.\n<D05EX_Relic:Pour échapper à la montagne enneigée, vous avez adopté une stratégie prioritaires sur l'efficacité, regardant les gens périr un par un. Les yeux des survivants tenaient plus de peur que de gratitude.>"
  },
  RelicConfig_65408_Name = {
    Text = "<OrangeQuality:Médaille de sauvetage·Bronze>"
  },
  RelicConfig_65408_StoryDesc = {
    Text = "Pour sortir de la montagne de neige, tu as choisi une stratégie axée sur l'efficacité, regardant les gens mourir un par un, tandis que les survivants te regardent avec plus de peur que de reconnaissance"
  },
  RelicConfig_65409_BattleDesc = {
    Text = "Au début du tour, obtenez [Arg1] <DerivativeCardKeywords_69:\"Lueur Foulée de l'Humanité\">.\n<D05EX_Relic:Vous avez peut-être fait de votre mieux. Bien que la moitié des gens aient péri, vous avez au moins sauvé l'autre moitié. Après tout, les sacrifices sont inévitables.>"
  },
  RelicConfig_65409_Desc = {
    Text = "Au début du tour, obtenez [Arg1] <DerivativeCardKeywords_69:\"Lueur Foulée de l'Humanité\">.\n<D05EX_Relic:Vous avez peut-être fait de votre mieux. Bien que la moitié des gens aient péri, vous avez au moins sauvé l'autre moitié. Après tout, les sacrifices sont inévitables.>"
  },
  RelicConfig_65409_Name = {
    Text = "<OrangeQuality:Médaille de sauvetage en argent>"
  },
  RelicConfig_65409_StoryDesc = {
    Text = "Tu as peut-être essayé, même si la moitié est morte, tu as sauvé l'autre moitié. Après tout, les sacrifices sont inévitables"
  },
  RelicConfig_65410_BattleDesc = {
    Text = "Au début du tour, gagnez [Arg1] <DerivativeCardKeywords_70:\"Lustre de l'Humanité\">.\n<D05EX_Relic:Vous avez sauvé la plupart des gens, réécrivant leurs tragiques destins. Vous avez fait de votre mieux, n'est-ce pas?>"
  },
  RelicConfig_65410_Desc = {
    Text = "Au début du tour, gagnez [Arg1] <DerivativeCardKeywords_70:\"Lustre de l'Humanité\">.\n<D05EX_Relic:Vous avez sauvé la plupart des gens, réécrivant leurs tragiques destins. Vous avez fait de votre mieux, n'est-ce pas?>"
  },
  RelicConfig_65410_Name = {
    Text = "<OrangeQuality:Médaille de sauvetage·Or>"
  },
  RelicConfig_65410_StoryDesc = {
    Text = "Tu as sauvé la plupart des gens, changeant leur destin tragique, tu as fait de ton mieux, n'est-ce pas ?"
  },
  RelicConfig_65456_BattleDesc = {
    Text = "Au début du combat, mélangez 3 cartes de « symptômes » aléatoires. Lorsque vous jouez un « symptôme », obtenez [Arg1] points de force. \n<D05EX_Relic:Grâce à votre aide, personne n'a survécu dans l'équipe de recherche. Vous avez froidement maximisé vos propres intérêts, mais cela en valait-il vraiment la peine?>"
  },
  RelicConfig_65456_Desc = {
    Text = "Au début du combat, mélangez 3 cartes de « symptômes » aléatoires. Lorsque vous jouez un « symptôme », gagnez [Arg1] points de force. \n<D05EX_Relic:Grâce à votre aide, personne n'a survécu dans l'équipe de recherche. Vous avez froidement tiré le meilleur parti pour vous-même, mais tout cela en valait-il vraiment la peine?>"
  },
  RelicConfig_65456_Name = {
    Text = "<OrangeQuality:Insigne du solitaire>"
  },
  RelicConfig_65456_StoryDesc = {
    Text = ": Avec ton aide, aucun membre de l'équipe scientifique n'a survécu. Tu as tiré le plus grand profit pour toi-même, mais tout cela en valait-il la peine ?"
  },
  RelicConfig_65569_BattleDesc = {
    Text = "Au début du combat, la limite d’Arithmetica est augmentée de 1, réveille tous les éveilleurs. Pendant les 5 prochains tours, au début de chaque tour, une relique sera obtenue, comme « équipement de communication, le Sacrifice du Printemps, béquille de prêtre, oiseau du Rituel de Malchance, pendule temporel·projection »."
  },
  RelicConfig_65569_Desc = {
    Text = "Au début du combat, la limite d’Arithmetica est augmentée de 1, réveillez tous les éveilleurs. Pendant les 5 prochains tours, au début de chaque tour, une relique sera obtenue, comme « équipement de communication, le Sacrifice du Printemps, béquille de prêtre, oiseau du Rituel de Malchance, pendule temporel·projection »."
  },
  RelicConfig_65569_Name = {
    Text = "<OrangeQuality:Pendule Chrono \"Trésor Secret δ\">"
  },
  RelicConfig_65570_BattleDesc = {
    Text = "Au début du combat, la limite de calcul est augmentée de 1, réveillez tous les éveilleurs. Pendant les 5 prochains tours, au début de chaque tour, un artefact sera obtenu, comme « badge de Missag, mallette du médecin, batterie prototype, conscience gravée, pendule temporel·évolution »."
  },
  RelicConfig_65570_Desc = {
    Text = "Au début du combat, la limite de calcul est augmentée de 1, réveille tous les éveilleurs. Pendant les 5 prochains tours, au début de chaque tour, un artefact sera obtenu, comme « badge de Missag, mallette du médecin, batterie prototype, conscience gravée, pendule temporel·Évolution »."
  },
  RelicConfig_65570_Name = {
    Text = "<OrangeQuality:Pendule Chrono \"Trésor Secret γ\">"
  },
  RelicConfig_66515_BattleDesc = {
    Text = "Au début du combat, la limite d'Arithmetica est augmentée de 1, réveille tous les Éveilleurs. Pendant les 5 prochains tours, au début de chaque tour, un artefact sera obtenu, comme « Putney Morning Post, principes esthétiques, chant de la populace, visage brisé, pendule temporel·transit »."
  },
  RelicConfig_66515_Desc = {
    Text = "Au début du combat, la limite d’Arithmetica est augmentée de 1, réveille tous les Éveilleurs. Pendant les 5 prochains tours, au début de chaque tour, une Relique sera obtenue, comme « Putney Morning Post, Principes esthétiques, Chant de la populace, Visage brisé, Pendule temporel·Transit »."
  },
  RelicConfig_66515_Name = {
    Text = "<OrangeQuality:Chrono Pendulum\"Secret Treasure ε\">"
  },
  RelicConfig_66518_BattleDesc = {
    Text = "Au début du combat, le plafond de l'arithmétique +1, réveillez tous les réveilleurs. Au début des tours impairs, découvrez une relique, découvrir un total de cinq fois"
  },
  RelicConfig_66518_Desc = {
    Text = "Au début du combat, le plafond de l'arithmétique +1, réveillez tous les réveilleurs. Au début des tours impairs, découvrez une relique, découvrir un total de cinq fois"
  },
  RelicConfig_66518_Name = {
    Text = "<OrangeQuality:Pendule Chrono \"Souhait β\">"
  },
  RelicConfig_66519_BattleDesc = {
    Text = "Au début du combat, le plafond de l'arithmétique +1, réveillez tous les réveilleurs. Au début des tours impairs, découvrez une relique, découvrir un total de cinq fois"
  },
  RelicConfig_66519_Desc = {
    Text = "Au début du combat, le plafond de l'arithmétique +1, réveillez tous les réveilleurs. Au début des tours impairs, découvrez une relique, découvrir un total de cinq fois"
  },
  RelicConfig_66519_Name = {
    Text = "<OrangeQuality:Pendule Chrono \"Souhait α\">"
  },
  RelicConfig_67690_BattleDesc = {
    Text = "Au début de chaque tour, tous les réveilleurs gagnent 25 points de folie. Lors de la collecte, la santé max devient 1,5 fois"
  },
  RelicConfig_67690_Desc = {
    Text = "Au début de chaque tour, tous les réveilleurs gagnent 25 points de folie. Lors de la collecte, la santé max devient 1,5 fois"
  },
  RelicConfig_67690_Name = {
    Text = "<OrangeQuality: sous bénédiction · Apparence cauchemardesque β>"
  },
  RelicConfig_67690_StoryDesc = {
    Text = "Pas besoin de peur, pas besoin d'hésitation. Ce n'est qu'un rêve éphémère, la lumière du Père brille toujours sur toi"
  },
  RelicConfig_67788_BattleDesc = {
    Text = "En ramassant, gagnez 3 points d'arithmetica"
  },
  RelicConfig_67788_Desc = {
    Text = "En ramassant, gagnez 3 points d'arithmetica"
  },
  RelicConfig_67788_Name = {
    Text = "<WhiteQuality:miroir de montre de poche>"
  },
  RelicConfig_67788_StoryDesc = {
    Text = "Les souvenirs sont figés dans le temps passé, enfouis au fond du noir"
  },
  RelicConfig_67789_BattleDesc = {
    Text = "Lorsque ramassé, placez 1 <DerivativeCardKeywords_1:\"Écho Éthéré\"> dans votre main."
  },
  RelicConfig_67789_Desc = {
    Text = "Lorsque ramassé, placez 1 <DerivativeCardKeywords_1:\"Écho Éthéré\"> dans votre main."
  },
  RelicConfig_67789_Name = {
    Text = "<WhiteQuality:Équipement de communication>"
  },
  RelicConfig_67789_StoryDesc = {
    Text = "Attendre ou craindre le moment où il sonnera"
  },
  RelicConfig_67790_BattleDesc = {
    Text = "Tous les « coups » augmentent les dégâts critiques de 20%. Lors de la collecte, ajoutez 1 carte <DerivativeCardKeywords_40: « instant décisif »> à votre main"
  },
  RelicConfig_67790_Desc = {
    Text = "Tous les « coups » augmentent les dégâts critiques de 20%. Lors de la collecte, ajoutez 1 carte <DerivativeCardKeywords_40: « instant décisif »> à votre main"
  },
  RelicConfig_67790_Name = {
    Text = "<WhiteQuality:Instant de beauté>"
  },
  RelicConfig_67790_StoryDesc = {
    Text = "Préservez la beauté éphémère pour toujours"
  },
  RelicConfig_67791_BattleDesc = {
    Text = "En ramassant, infligez 1 tour de <WeaknessIconKeywords:faiblesse> et <VulnerabilityIconKeywords:vulnérable> à tous les ennemis"
  },
  RelicConfig_67791_Desc = {
    Text = "En ramassant, infligez 1 tour de <WeaknessIconKeywords:faiblesse> et <VulnerabilityIconKeywords:vulnérable> à tous les ennemis"
  },
  RelicConfig_67791_Name = {
    Text = "<WhiteQuality:Camisa de force>"
  },
  RelicConfig_67791_StoryDesc = {
    Text = "Ce n'est pas seulement le temps qui peut décolorer les tissus, la peur et la douleur aussi"
  },
  RelicConfig_67793_BattleDesc = {
    Text = "Au début du combat, tous les Réveilleurs gagnent 50 points d'Aliemus. Pigez 2 <DerivativeCardKeywords_1:\"Écho Éclipsé\"> dans votre main."
  },
  RelicConfig_67793_Desc = {
    Text = "Quand ramassé, tous les Réveilleurs gagnent 50 points d'Aliemus, et placez 2 <DerivativeCardKeywords_1:\"Écho Éthéré\"> dans votre main."
  },
  RelicConfig_67793_Name = {
    Text = "<OrangeQuality:dispositif de communication +β>"
  },
  RelicConfig_67793_StoryDesc = {
    Text = "Attendre ou craindre le moment où il sonnera"
  },
  RelicConfig_67794_BattleDesc = {
    Text = "Limite de cartes à main augmentée de 5, complétez votre main à la limite au début du combat. Au début du tour, tirez 1 carte supplémentaire, et à la fin du tour, défaussez toutes les cartes de symptôme et d'état dans votre main, conservez les autres"
  },
  RelicConfig_67794_Desc = {
    Text = "Limite de cartes à main augmentée de 5, complétez votre main à la limite au début du combat. Au début du tour, tirez 1 carte supplémentaire, et à la fin du tour, défaussez toutes les cartes de symptôme et d'état dans votre main, conservez les autres"
  },
  RelicConfig_67794_Name = {
    Text = "<OrangeQuality: sous bénédiction · Gravure de conscience β>"
  },
  RelicConfig_67794_StoryDesc = {
    Text = "L'avide grave ses erreurs dans son cœur et cherche à racheter son passé"
  },
  RelicConfig_67818_BattleDesc = {
    Text = "Au début du combat, le plafond de l'arithmétique +1, réveillez tous les réveilleurs. Au début du tour, découvrez une « relique » ou « soutien » au hasard, découvrir un total de cinq fois"
  },
  RelicConfig_67818_Desc = {
    Text = "Au début du combat, le plafond de l'arithmétique +1, réveillez tous les réveilleurs. Au début du tour, découvrez une « relique » ou « soutien » au hasard, découvrir un total de cinq fois"
  },
  RelicConfig_67818_Name = {
    Text = "<OrangeQuality:\"Porte de Tout ε\">"
  },
  RelicConfig_67819_BattleDesc = {
    Text = "Au début du combat, le plafond de l'arithmétique +1, réveillez tous les réveilleurs. Au début du tour, découvrez une « relique » ou « soutien » au hasard, découvrir un total de cinq fois"
  },
  RelicConfig_67819_Desc = {
    Text = "Au début du combat, le plafond de l'arithmétique +1, réveillez tous les réveilleurs. Au début du tour, découvrez une « relique » ou « soutien » au hasard, découvrir un total de cinq fois"
  },
  RelicConfig_67819_Name = {
    Text = "<OrangeQuality:\"Porte de Tout ζ\">"
  },
  RelicConfig_67820_BattleDesc = {
    Text = "Au début du combat, le plafond de l'arithmétique +1, réveillez tous les réveilleurs. Au début du tour, découvrez une « relique » ou « soutien » au hasard, découvrir un total de cinq fois"
  },
  RelicConfig_67820_Desc = {
    Text = "Au début du combat, le plafond de l'arithmétique +1, réveillez tous les réveilleurs. Au début du tour, découvrez une « relique » ou « soutien » au hasard, découvrir un total de cinq fois"
  },
  RelicConfig_67820_Name = {
    Text = "<OrangeQuality:\"Porte de Tout θ\">"
  },
  RelicConfig_67821_BattleDesc = {
    Text = "Au début du combat, le plafond de l'arithmétique +1, réveillez tous les réveilleurs. Au début du tour, découvrez une « relique » ou « soutien » au hasard, découvrir un total de cinq fois"
  },
  RelicConfig_67821_Desc = {
    Text = "Au début du combat, le plafond de l'arithmétique +1, réveillez tous les réveilleurs. Au début du tour, découvrez une « relique » ou « soutien » au hasard, découvrir un total de cinq fois"
  },
  RelicConfig_67821_Name = {
    Text = "<OrangeQuality:\"Porte de Tout γ\">"
  },
  RelicConfig_67822_BattleDesc = {
    Text = "Au début du combat, le plafond de l'arithmétique +1, réveillez tous les réveilleurs. Au début du tour, découvrez une « relique » ou « soutien » au hasard, découvrir un total de cinq fois"
  },
  RelicConfig_67822_Desc = {
    Text = "Au début du combat, le plafond de l'arithmétique +1, réveillez tous les réveilleurs. Au début du tour, découvrez une « relique » ou « soutien » au hasard, découvrir un total de cinq fois"
  },
  RelicConfig_67822_Name = {
    Text = "<OrangeQuality: \"Porte de l'univers α\">"
  },
  RelicConfig_67823_BattleDesc = {
    Text = "Au début du combat, le plafond de l'arithmétique +1, réveillez tous les réveilleurs. Au début du tour, découvrez une « relique » ou « soutien » au hasard, découvrir un total de cinq fois"
  },
  RelicConfig_67823_Desc = {
    Text = "Au début du combat, le plafond de l'arithmétique +1, réveillez tous les réveilleurs. Au début du tour, découvrez une « relique » ou « soutien » au hasard, découvrir un total de cinq fois"
  },
  RelicConfig_67823_Name = {
    Text = "<OrangeQuality:\"Porte de Tout η\">"
  },
  RelicConfig_67824_BattleDesc = {
    Text = "Au début du combat, le plafond de l'arithmétique +1, réveillez tous les réveilleurs. Au début du tour, découvrez une « relique » ou « soutien » au hasard, découvrir un total de cinq fois"
  },
  RelicConfig_67824_Desc = {
    Text = "Au début du combat, le plafond de l'arithmétique +1, réveillez tous les réveilleurs. Au début du tour, découvrez une « relique » ou « soutien » au hasard, découvrir un total de cinq fois"
  },
  RelicConfig_67824_Name = {
    Text = "<OrangeQuality:\"Porte de Tout δ\">"
  },
  RelicConfig_67825_BattleDesc = {
    Text = "Au début du combat, le plafond de l'arithmétique +1, réveillez tous les réveilleurs. Au début du tour, découvrez une « relique » ou « soutien » au hasard, découvrir un total de cinq fois"
  },
  RelicConfig_67825_Desc = {
    Text = "Au début du combat, le plafond de l'arithmétique +1, réveillez tous les réveilleurs. Au début du tour, découvrez une « relique » ou « soutien » au hasard, découvrir un total de cinq fois"
  },
  RelicConfig_67825_Name = {
    Text = "<OrangeQuality: \"Porte de l'univers β\">"
  },
  RelicConfig_67826_BattleDesc = {
    Text = "Au début du combat, le plafond de l'arithmétique +1, réveillez tous les réveilleurs. Au début du tour, découvrez une « relique » ou « soutien » au hasard, découvrir un total de cinq fois"
  },
  RelicConfig_67826_Desc = {
    Text = "Au début du combat, le plafond de l'arithmétique +1, réveillez tous les réveilleurs. Au début du tour, découvrez une « relique » ou « soutien » au hasard, découvrir un total de cinq fois"
  },
  RelicConfig_67826_Name = {
    Text = "<OrangeQuality:\"Porte de Tout ι\">"
  },
  RelicConfig_68651_BattleDesc = {
    Text = "Au début du combat, réveillez tous les éveilleurs, ajoutez <DerivativeCardKeywords_84:« Lueur du souvenir - Statue de cire inachevée »> à votre main, copiez toutes les cartes de la pioche. Chaque tour, piochez 5 cartes supplémentaires et obtenez 5 points d'arithmetica. Après avoir joué « Attaque » ou « Défense », obtenez [Arg1] points de bouclier."
  },
  RelicConfig_68651_Desc = {
    Text = "Au début du combat, réveillez tous les Éveilleurs, placez <DerivativeCardKeywords_84:« Lueur du souvenir - Statue de cire inachevée »> dans votre main, copiez toutes les cartes de la pioche. Chaque tour, piochez 5 cartes supplémentaires et obtenez 5 points d'arithmetica. Après avoir joué « Attaque » ou « Défense », obtenez [Arg1] points de bouclier."
  },
  RelicConfig_68651_Name = {
    Text = "<OrangeQuality:«Cœur en argent pur · Peur»>"
  },
  RelicConfig_68652_BattleDesc = {
    Text = "Au début du combat, réveillez tous les éveilleurs et placez <DerivativeCardKeywords_85:«Souvenirs de lueur - Cœur déformé»> dans votre main. Au début du tour, vous pouvez choisir de défausser n'importe quelle carte de votre main et en piocher autant. Dans les tours impairs, obtenez [Arg1] points de force temporaire et placez <DerivativeCardKeywords_97:«Volonté indomptable β»> dans votre main. Dans les tours pairs, obtenez [Arg2] points de précaution temporaire et placez <DerivativeCardKeywords_98:«Cachette β»> dans votre main."
  },
  RelicConfig_68652_Desc = {
    Text = "Au début du combat, réveillez tous les éveilleurs et placez <DerivativeCardKeywords_85:«Souvenirs de lueur - Cœur déformé»> dans votre main. Au début du tour, vous pouvez choisir de défausser n'importe quelle carte de votre main et en piocher autant. Dans les tours impairs, obtenez [Arg1] points de force temporaire et placez <DerivativeCardKeywords_97:«Volonté indomptable β»> dans votre main. Dans les tours pairs, obtenez [Arg2] points de précaution temporaire et placez <DerivativeCardKeywords_98:«Cachette β»> dans votre main."
  },
  RelicConfig_68652_Name = {
    Text = "<OrangeQuality:«Cœur en argent pur · Épineux»>"
  },
  RelicConfig_68653_BattleDesc = {
    Text = "Au début du combat, réveillez tous les éveilleurs et ajoutez <DerivativeCardKeywords_83:«Souvenirs de l'éclat - Cadeau innocent»> à votre main. Tous les éveilleurs peuvent libérer 1 fois de plus l'exaltation par tour, et après avoir libéré l'exaltation, réduisez la force de l'ennemi de [Arg2] points. Au début de chaque tour, tous les éveilleurs gagnent [Arg1] points de fureur."
  },
  RelicConfig_68653_Desc = {
    Text = "Au début du combat, réveillez tous les éveillés et placez <DerivativeCardKeywords_83:«Souvenirs de l'éclat - Cadeau innocent»> dans votre main. Tous les éveillés peuvent libérer 1 fois de plus l'exaltation par tour, après avoir libéré l'exaltation, réduisez la force de l'ennemi de [Arg2] points. Au début du tour, tous les éveillés gagnent [Arg1] points de fureur."
  },
  RelicConfig_68653_Name = {
    Text = "<OrangeQuality:«Cœur en argent pur · Pleurer»>"
  },
  RelicConfig_68654_BattleDesc = {
    Text = "Au début du combat, réveillez tous les Éveilleurs, ajoutez <DerivativeCardKeywords_88:« Souvenirs de lueur - Voile de l'Utopie »> à votre main, augmentez la limite max de la main de 2, et la limite de stockage de fragment de clé de 100 %. Après avoir libéré un Décret Clé, tous les Éveilleurs obtiennent temporairement un taux critique et des dégâts critiques de +[Arg1] %, obtenez un bouclier équivalent à 20 % de vos PV max, et piochez jusqu'à atteindre la limite de votre main."
  },
  RelicConfig_68654_Desc = {
    Text = "Au début du combat, réveillez tous les éveilleurs, ajoutez <DerivativeCardKeywords_88:« Souvenirs de lueur - Voile de l'Utopie »> à votre main, augmentez la limite maximale de la main de l'équipe de +2 et la limite de stockage de l'énergie de la clé de +100 %. Après avoir libéré un décret clé, tous les éveilleurs obtiennent temporairement un taux critique et des dégâts critiques de + [Arg1] %, obtenez un bouclier équivalent à 20 % de votre vie maximale, et piochez jusqu'à atteindre la limite de la main."
  },
  RelicConfig_68654_Name = {
    Text = "<OrangeQuality:«Cœur en argent pur · Folie»>"
  },
  RelicConfig_68655_BattleDesc = {
    Text = "Au début du combat, réveillez tous les éveilleurs et ajoutez <DerivativeCardKeywords_89:«Souvenirs du Crépuscule - Cœur de Fertilité»> à votre main. À la fin du tour, gardez les arithmétiques restants et ne défaussez plus de cartes de votre main. Pour chaque dégât direct infligé, gagnez [Arg1] points de force temporaire et [Arg2] points de bouclier."
  },
  RelicConfig_68655_Desc = {
    Text = "Au début du combat, réveillez tous les éveilleurs et ajoutez <DerivativeCardKeywords_89:«Souvenirs du Crépuscule - Cœur de Fertilité»> à votre main. À la fin du tour, gardez les arithmetica restants et ne défaussez plus de cartes. Pour chaque dégât direct infligé, obtenez [Arg1] points de force temporaire et [Arg2] points de bouclier."
  },
  RelicConfig_68655_Name = {
    Text = "<OrangeQuality:«Cœur en argent pur · Naissance»>"
  },
  RelicConfig_68656_BattleDesc = {
    Text = "Au début du combat, réveillez tous les éveilleurs, mettez <DerivativeCardKeywords_86:«Souvenirs de l'éclat - Vin doux au miel»> dans votre main, et les dégâts critiques de tous les éveilleurs deviennent 1,5 fois supérieurs. À la fin du tour, les éveilleurs n'ayant pas libéré d'exaltation gagnent [Arg1] points de folie. Si le nombre de cartes jouées est inférieur à [Arg2], piochez 2 cartes au prochain tour et gagnez 2 points d'arithmétique."
  },
  RelicConfig_68656_Desc = {
    Text = "Au début du combat, réveillez tous les éveilleurs, mettez <DerivativeCardKeywords_86:«Souvenirs de l'éclat - Vin doux au miel»> dans votre main, et les dégâts critiques de tous les éveilleurs deviennent 1,5 fois supérieurs. À la fin du tour, les éveilleurs n'ayant pas libéré d'exaltation gagnent [Arg1] points de folie. Si le nombre de cartes jouées est inférieur à [Arg2], piochez 2 cartes au prochain tour et gagnez 2 points d'arithmétique."
  },
  RelicConfig_68656_Name = {
    Text = "<OrangeQuality:«Cœur en argent pur · Fourberie»>"
  },
  RelicConfig_68657_BattleDesc = {
    Text = "Au début du combat, Éveille tous les Éveilleurs, place <DerivativeCardKeywords_87:« Souvenirs de la lueur - Le Jugement du Substitut »> dans la main, et double l'Amplification de Dégâts de l'équipe. L'effet Symptôme : Affaiblir que vous infligez passe de 25% à 50%. À la fin de chaque tour, gagnez un Bouclier du personnage égal à [Arg1]% des PV Max et infligez <FixedDamage:DGT Purs> égaux à [Arg2] x Bouclier du personnage à tous les ennemis."
  },
  RelicConfig_68657_Desc = {
    Text = "Au début du combat, Éveille tous les Éveilleurs, place <DerivativeCardKeywords_87:« Souvenirs de la lueur - Le Jugement du Substitut »> dans la main, et double l'Amplification de Dégâts de l'équipe. L'effet Symptôme : Affaiblir que vous infligez passe de 25% à 50%. À la fin de chaque tour, gagnez un Bouclier du personnage égal à [Arg1]% des PV Max et infligez <FixedDamage:DGT Purs> égaux à [Arg2] x Bouclier du personnage à tous les ennemis."
  },
  RelicConfig_68657_Name = {
    Text = "<OrangeQuality:«Cœur en argent pur · Malédiction»>"
  },
  RelicConfig_68886_BattleDesc = {
    Text = "Les dégâts, soins et boucliers infligés par Tawil augmentent de 50 %. Au début de la bataille, Tawil obtient 120 points de folie."
  },
  RelicConfig_68886_Desc = {
    Text = "Les dégâts, boucliers et régénération de vie causés par Tawil augmentent de 50 %. Au début de la bataille, Tawil obtient 120 points de folie."
  },
  RelicConfig_68886_Name = {
    Text = "<OrangeQuality:« Œil de la toute-connaissance »>"
  },
  RelicConfig_68886_StoryDesc = {
    Text = "Depuis la porte, Il emprunte la seule voie correcte."
  },
  RelicConfig_69319_BattleDesc = {
    Text = "Au début du combat, le plafond de l'arithmétique +1, réveillez tous les réveilleurs. Au début des tours impairs, découvrez une relique, découvrir un total de cinq fois"
  },
  RelicConfig_69319_Desc = {
    Text = "Au début du combat, le plafond de l'arithmétique +1, réveillez tous les réveilleurs. Au début des tours impairs, découvrez une relique, découvrir un total de cinq fois"
  },
  RelicConfig_69319_Name = {
    Text = "<OrangeQuality: pendule chronique « Vœu ε »>"
  },
  RelicConfig_69320_BattleDesc = {
    Text = "Au début du combat, le plafond de l'arithmétique +1, réveillez tous les réveilleurs. Au début des tours impairs, découvrez une relique, découvrir un total de cinq fois"
  },
  RelicConfig_69320_Desc = {
    Text = "Au début du combat, le plafond de l'arithmétique +1, réveillez tous les réveilleurs. Au début des tours impairs, découvrez une relique, découvrir un total de cinq fois"
  },
  RelicConfig_69320_Name = {
    Text = "<OrangeQuality: pendule chronique « Vœu γ »>"
  },
  RelicConfig_69321_BattleDesc = {
    Text = "Au début du combat, le plafond de l'arithmétique +1, réveillez tous les réveilleurs. Au début des tours impairs, découvrez une relique, découvrir un total de cinq fois"
  },
  RelicConfig_69321_Desc = {
    Text = "Au début du combat, le plafond de l'arithmétique +1, réveillez tous les réveilleurs. Au début des tours impairs, découvrez une relique, découvrir un total de cinq fois"
  },
  RelicConfig_69321_Name = {
    Text = "<OrangeQuality: pendule chronique « Vœu δ »>"
  },
  RelicConfig_70042_BattleDesc = {
    Text = "Au début du tour, accumulez 1 point de « Source de l'Abîme », choisissez « Sommeil » ou « Réveil ». Sommeil : accumulez 1 point supplémentaire de « Source de l'Abîme ». Réveil : consommez 1/5/10 points de « Source de l'Abîme » pour obtenir l'aide de Tulu. Plus vous consommez de « Source de l'Abîme », plus l'effet de l'aide de Tulu est fort."
  },
  RelicConfig_70042_Desc = {
    Text = "Au début du tour, accumulez 1 point de « Source de l'Abîme », choisissez « Sommeil » ou « Réveil ». Sommeil : accumulez 1 point supplémentaire de « Source de l'Abîme ». Réveil : consommez 1/5/10 points de « Source de l'Abîme » pour obtenir l'aide de Tulu. Plus vous consommez de « Source de l'Abîme », plus l'effet de l'aide de Tulu est fort."
  },
  RelicConfig_70042_Name = {
    Text = "<OrangeQuality:Pouvoir du Roi Dieu>"
  },
  RelicConfig_70084_BattleDesc = {
    Text = "Au début de la bataille, mélangez tous les « réveils » des éveillés dans la pile de pioche."
  },
  RelicConfig_70084_Desc = {
    Text = "Au début de la bataille, mélangez tous les « réveils » des éveillés dans la pile de pioche."
  },
  RelicConfig_70084_Name = {
    Text = "<OrangeQuality:Réveil>"
  },
  RelicConfig_70700_BattleDesc = {
    Text = "Tous les éveillés voient leurs dégâts de base augmenter de [Arg1] %."
  },
  RelicConfig_70700_Desc = {
    Text = "Tous les éveillés voient leurs dégâts de base augmenter de [Arg1] %."
  },
  RelicConfig_70700_Name = {
    Text = "<WhiteQuality:Pipe pleureuse>"
  },
  RelicConfig_70700_StoryDesc = {
    Text = "Est-ce le fruit de la haine ou le résultat de la vengeance ?"
  },
  RelicConfig_70701_BattleDesc = {
    Text = "Au début du tour, tous les éveillés gagnent [Arg1] point(s) de folie."
  },
  RelicConfig_70701_Desc = {
    Text = "Au début du tour, tous les éveillés gagnent [Arg1] point(s) de folie."
  },
  RelicConfig_70701_Name = {
    Text = "<WhiteQuality:Batterie prototype>"
  },
  RelicConfig_70701_StoryDesc = {
    Text = "Espoir portable"
  },
  RelicConfig_70702_BattleDesc = {
    Text = "Après avoir libéré « l'exaltation », gagnez [Arg1] points temporaires de <PowerIconKeywords:pouvoir>."
  },
  RelicConfig_70702_Desc = {
    Text = "Après avoir libéré « l'exaltation », gagnez [Arg1] points temporaires de <PowerIconKeywords:pouvoir>."
  },
  RelicConfig_70702_Name = {
    Text = "<OrangeQuality:Verrou lourd+>"
  },
  RelicConfig_70702_StoryDesc = {
    Text = "Un verrou épais et solide, difficile à ouvrir sans clé.\nBien sûr, cela ne pose aucun problème pour un certain voleur"
  },
  RelicConfig_70703_BattleDesc = {
    Text = "« Frappe » inflige une fois supplémentaire des dégâts équivalents à [Arg1] % de l'attaque de l'éveillé, avec un maximum de 3 déclenchements par tour."
  },
  RelicConfig_70703_Desc = {
    Text = "« Frappe » inflige une fois supplémentaire des dégâts équivalents à [Arg1] % de l'attaque de l'éveillé, avec un maximum de 3 déclenchements par tour."
  },
  RelicConfig_70703_Name = {
    Text = "<WhiteQuality:Scalpel rouillé>"
  },
  RelicConfig_70703_StoryDesc = {
    Text = "Pas adapté pour couper des tissus vivants"
  },
  RelicConfig_70704_BattleDesc = {
    Text = "Utiliser l'Éveil de la clé d'argent puis appliquer [Arg1] niveaux d'<IntoxicationIconKeywords:empoisonnement> à tous les ennemis et obtenir [Arg2] points de s-énergie."
  },
  RelicConfig_70704_Desc = {
    Text = "Utiliser l'Éveil de la clé d'argent puis appliquer [Arg1] niveaux d'<IntoxicationIconKeywords:empoisonnement> à tous les ennemis et obtenir [Arg2] points de s-énergie."
  },
  RelicConfig_70704_Name = {
    Text = "<OrangeQuality:Pommade suspecte+>"
  },
  RelicConfig_70704_StoryDesc = {
    Text = "Un certain onguent local pour blessures, merci de ne pas l'utiliser sans l'avis d'un médecin"
  },
  RelicConfig_70705_BattleDesc = {
    Text = "«Attaque» applique un <IntoxicationIconKeywords:poison> équivalent à [Arg1]% des dégâts, avec un maximum de [Arg2] points par tour."
  },
  RelicConfig_70705_Desc = {
    Text = "«Attaque» applique un <IntoxicationIconKeywords:poison> équivalent à [Arg1]% des dégâts, avec un maximum de [Arg2] points par tour."
  },
  RelicConfig_70705_Name = {
    Text = "<OrangeQuality:Langue étrangère+>"
  },
  RelicConfig_70705_StoryDesc = {
    Text = "Il n'est pas un démon, mais il transmet des murmures d'un autre monde"
  },
  RelicConfig_70706_BattleDesc = {
    Text = "<EmbryoFusionIconKeywords:fusion d'embryon> La quantité obtenue automatiquement est augmentée de [Arg1]%."
  },
  RelicConfig_70706_Desc = {
    Text = "<EmbryoFusionIconKeywords:fusion d'embryon> La quantité obtenue automatiquement est augmentée de [Arg1]%."
  },
  RelicConfig_70706_Name = {
    Text = "<WhiteQuality:Diagnostic de peste>"
  },
  RelicConfig_70706_StoryDesc = {
    Text = "Peste—une manifestation aléatoire de l'agitation inconsciente de la nature"
  },
  RelicConfig_70707_BattleDesc = {
    Text = "Utiliser l'Éveil de la clé d'argent, puis tous les réveilleurs obtiennent [Arg1] points de folie et [Arg2] points de s-énergie."
  },
  RelicConfig_70707_Desc = {
    Text = "Utiliser l'Éveil de la clé d'argent, puis tous les réveilleurs obtiennent [Arg1] points de folie et [Arg2] points de s-énergie."
  },
  RelicConfig_70707_Name = {
    Text = "<OrangeQuality:Boutons de manchette avec motif de laurier+>"
  },
  RelicConfig_70707_StoryDesc = {
    Text = "Boutons de manchette en argent avec motif de laurier.\nIls sont finement travaillés et brillants, symbolisant l'amitié de deux enfants"
  },
  RelicConfig_70708_BattleDesc = {
    Text = "Après le début de la bataille, obtenez [Arg1] <ProficientInRealmsIconKeywords:maîtrise des domaines>. Tous les réveilleurs voient leurs <IntoxicationIconKeywords:empoisonnements> ainsi que les <IntoxicationIconKeywords:empoisonnements> infligés par les créations augmenter de [Arg2] %."
  },
  RelicConfig_70708_Desc = {
    Text = "Après le début de la bataille, obtenez [Arg1] <ProficientInRealmsIconKeywords:maîtrise des domaines>. Tous les réveilleurs voient leurs <IntoxicationIconKeywords:empoisonnements> ainsi que les <IntoxicationIconKeywords:empoisonnements> infligés par les créations augmenter de [Arg2] %."
  },
  RelicConfig_70708_Name = {
    Text = "<OrangeQuality:Machine à coudre poussiéreuse+>"
  },
  RelicConfig_70708_StoryDesc = {
    Text = "Une mère aimante, réparant les blessures du cœur"
  },
  RelicConfig_70709_BattleDesc = {
    Text = "Après être entré dans un tour ultra, la première carte de commandement non dérivée jouée prendra effet [Arg1] fois supplémentaires."
  },
  RelicConfig_70709_Desc = {
    Text = "Après être entré dans un tour ultra, la première carte de commandement non dérivée jouée prendra effet [Arg1] fois supplémentaires."
  },
  RelicConfig_70709_Name = {
    Text = "<WhiteQuality:sablier lumineux>"
  },
  RelicConfig_70709_StoryDesc = {
    Text = "Un temps mesurable"
  },
  RelicConfig_70711_BattleDesc = {
    Text = "Utilisez l'Éveil de la clé d'argent puis obtenez [Arg1] points de <RetaliateIconKeywords:comptoir> et [Arg2] points de s-énergie."
  },
  RelicConfig_70711_Desc = {
    Text = "Utilisez l'Éveil de la clé d'argent puis obtenez [Arg1] points de <RetaliateIconKeywords:comptoir> et [Arg2] points de s-énergie."
  },
  RelicConfig_70711_Name = {
    Text = "<OrangeQuality:Chapitre des sages+>"
  },
  RelicConfig_70711_StoryDesc = {
    Text = "\"À quel point les humains sont fous, croyant aveuglément simplement parce que c'est ancien.\""
  },
  RelicConfig_70712_BattleDesc = {
    Text = "Utilisez l'Éveil de la clé d'argent pour obtenir [Arg1] points de <PowerIconKeywords:force> et [Arg2] points de s-énergie."
  },
  RelicConfig_70712_Desc = {
    Text = "Utilisez l'Éveil de la clé d'argent pour obtenir [Arg1] points de <PowerIconKeywords:force> et [Arg2] points de s-énergie."
  },
  RelicConfig_70712_Name = {
    Text = "<WhiteQuality:Notre maison>"
  },
  RelicConfig_70712_StoryDesc = {
    Text = "Ils étaient ensemble avant, et ils seront toujours ensemble. Ils sont une famille aimante"
  },
  RelicConfig_70713_BattleDesc = {
    Text = "Perdre de la vie permet d'obtenir un montant de fournaise cramoisie équivalent à [Arg1] % de la vie perdue."
  },
  RelicConfig_70713_Desc = {
    Text = "Perdre de la vie permet d'obtenir un montant de fournaise cramoisie équivalent à [Arg1] % de la vie perdue."
  },
  RelicConfig_70713_Name = {
    Text = "<WhiteQuality:Scie rouillée>"
  },
  RelicConfig_70713_StoryDesc = {
    Text = "Le médecin de la dissection ne voit jamais de belles femmes, seulement un sac de os, des nerfs enflammés par la maladie, des muscles et des tissus"
  },
  RelicConfig_70714_BattleDesc = {
    Text = "Après le début de la bataille, obtenez [Arg1] <ProficientInRealmsIconKeywords:maîtrise des domaines>. Tous les <RetaliateIconKeywords:contre-attaques> infligés par les réveilleurs ainsi que ceux causés par les créations augmentent de [Arg2] %."
  },
  RelicConfig_70714_Desc = {
    Text = "Après le début de la bataille, obtenez [Arg1] <ProficientInRealmsIconKeywords:maîtrise des domaines>. Tous les <RetaliateIconKeywords:contre-attaques> infligés par les réveilleurs ainsi que ceux causés par les créations augmentent de [Arg2] %."
  },
  RelicConfig_70714_Name = {
    Text = "<WhiteQuality:Franc-parler>"
  },
  RelicConfig_70714_StoryDesc = {
    Text = "Il a transmis d'innombrables secrets, actifs ou passifs"
  },
  RelicConfig_70715_BattleDesc = {
    Text = "Utiliser l'Éveil de la clé d'argent, puis piocher [Arg1] cartes et obtenir [Arg2] points de s-énergie."
  },
  RelicConfig_70715_Desc = {
    Text = "Utiliser l'Éveil de la clé d'argent, puis piocher [Arg1] cartes et obtenir [Arg2] points de s-énergie."
  },
  RelicConfig_70715_Name = {
    Text = "<OrangeQuality:Portefeuille neuf+>"
  },
  RelicConfig_70715_StoryDesc = {
    Text = "Un portefeuille en cuir portant le blason de l'université de Mythag.\nIl est maintenant vide, ne contenant rien"
  },
  RelicConfig_70717_BattleDesc = {
    Text = "Au début du tour, piochez [Arg1] cartes"
  },
  RelicConfig_70717_Desc = {
    Text = "Au début du tour, piochez [Arg1] cartes"
  },
  RelicConfig_70717_Name = {
    Text = "<OrangeQuality:Boussole directionnelle+>"
  },
  RelicConfig_70717_StoryDesc = {
    Text = "Ce qui est indiqué n'est pas une direction, mais un champ magnétique"
  },
  RelicConfig_70718_BattleDesc = {
    Text = "Après avoir déclenché « Exaltation, », tous les ennemis subissent [Arg1] <FixedDamage:DGT Purs> et déclenchent [Arg2]% de <IntoxicationIconKeywords:Poison>."
  },
  RelicConfig_70718_Desc = {
    Text = "Après avoir déclenché « Exaltation, », tous les ennemis subissent 1 instance de <FixedDamage:DGT Purs> égaux à [Arg2]% des PV Max de l'équipe et déclenchent [Arg2]% de <IntoxicationIconKeywords:Poison>."
  },
  RelicConfig_70718_Name = {
    Text = "<WhiteQuality:Mâchoire laser>"
  },
  RelicConfig_70718_StoryDesc = {
    Text = "Les ossements exposés dans la salle privée d'un collectionneur.\nLe collectionneur, fasciné par cette belle lueur, les admirait jour et nuit, finissant par mourir et devenir l'un d'eux"
  },
  RelicConfig_70719_BattleDesc = {
    Text = "Au début du tour, tous les éveillés gagnent [Arg1] point(s) de folie."
  },
  RelicConfig_70719_Desc = {
    Text = "Au début du tour, tous les éveillés gagnent [Arg1] point(s) de folie."
  },
  RelicConfig_70719_Name = {
    Text = "<OrangeQuality:Batterie prototype+>"
  },
  RelicConfig_70719_StoryDesc = {
    Text = "Espoir portable"
  },
  RelicConfig_70720_BattleDesc = {
    Text = "Au début du tour, si la vie est inférieure à 25 %, obtenez [Arg1] points de <PowerIconKeywords:puissance> temporaire."
  },
  RelicConfig_70720_Desc = {
    Text = "Au début du tour, si la vie est inférieure à 25 %, obtenez [Arg1] points de <PowerIconKeywords:puissance> temporaire."
  },
  RelicConfig_70720_Name = {
    Text = "<WhiteQuality:Gloire suprême>"
  },
  RelicConfig_70720_StoryDesc = {
    Text = "Un chat noir à poil court, élégant et mystérieux, est considéré comme une incarnation divine dans un lointain pays désertique. Mais le nom de cette divinité est aujourd'hui oublié.\nAdoré, vénéré, oublié, peut-être est-ce le destin des dieux"
  },
  RelicConfig_70721_BattleDesc = {
    Text = "Après avoir libéré 4 exaltations en un tour, obtenez [Arg1] points d'arithmétique, avec un temps de recharge de 3 tours."
  },
  RelicConfig_70721_Desc = {
    Text = "Après avoir libéré 4 exaltations en un tour, obtenez [Arg1] points d'arithmétique, avec un temps de recharge de 3 tours."
  },
  RelicConfig_70721_Name = {
    Text = "<WhiteQuality:Machine à différence argentée>"
  },
  RelicConfig_70721_StoryDesc = {
    Text = "\"Cela a changé l'histoire.\""
  },
  RelicConfig_70722_BattleDesc = {
    Text = "Utilisez l'Éveil de la clé d'argent pour obtenir [Arg1] points de <PowerIconKeywords:force> et [Arg2] points de s-énergie."
  },
  RelicConfig_70722_Desc = {
    Text = "Utilisez l'Éveil de la clé d'argent pour obtenir [Arg1] points de <PowerIconKeywords:force> et [Arg2] points de s-énergie."
  },
  RelicConfig_70722_Name = {
    Text = "<OrangeQuality:Notre maison+>"
  },
  RelicConfig_70722_StoryDesc = {
    Text = "Ils étaient ensemble avant, et ils seront toujours ensemble. Ils sont une famille aimante"
  },
  RelicConfig_70723_BattleDesc = {
    Text = "Lorsque vous jouez 2 cartes consécutives ayant une consommation de puissance supérieure à celle de la carte précédente, obtenez [Arg1] <RetaliateIconKeywords:riposte>, déclenchable jusqu'à 3 fois par tour."
  },
  RelicConfig_70723_Desc = {
    Text = "Lorsque vous jouez 2 cartes consécutives ayant une consommation de puissance supérieure à celle de la carte précédente, obtenez [Arg1] <RetaliateIconKeywords:riposte>, déclenchable jusqu'à 3 fois par tour."
  },
  RelicConfig_70723_Name = {
    Text = "<OrangeQuality:Archives d'Arcana+>"
  },
  RelicConfig_70723_StoryDesc = {
    Text = "Tendance du destin"
  },
  RelicConfig_70724_BattleDesc = {
    Text = "Au début de la bataille, obtenez [Arg1] <PowerIconKeywords:force>."
  },
  RelicConfig_70724_Desc = {
    Text = "Au début de la bataille, obtenez [Arg1] <PowerIconKeywords:force>."
  },
  RelicConfig_70724_Name = {
    Text = "<OrangeQuality:Broche en rubis+>"
  },
  RelicConfig_70724_StoryDesc = {
    Text = "Un rouge discret suinte"
  },
  RelicConfig_70725_BattleDesc = {
    Text = "Après le début de la bataille, appliquez [Arg1] couches de <WeaknessIconKeywords:faiblesse> à tous les ennemis, l'effet est doublé lors des combats contre un boss. Tous les éveillés voient leurs dégâts de base augmenter de [Arg2] %."
  },
  RelicConfig_70725_Desc = {
    Text = "Après le début de la bataille, appliquez [Arg1] couches de <WeaknessIconKeywords:faiblesse> à tous les ennemis, l'effet est doublé lors des combats contre un boss. Tous les éveillés voient leurs dégâts de base augmenter de [Arg2] %."
  },
  RelicConfig_70725_Name = {
    Text = "<OrangeQuality:Enfant terrible+>"
  },
  RelicConfig_70725_StoryDesc = {
    Text = "Né de la pure méchanceté, même si ce n'était pas son souhait"
  },
  RelicConfig_70726_BattleDesc = {
    Text = "Anéantir : Obtenez [Arg1] boucliers. 3 tours de repos requis."
  },
  RelicConfig_70726_Desc = {
    Text = "Anéantir : Obtenez [Arg1] boucliers. 3 tours de repos requis."
  },
  RelicConfig_70726_Name = {
    Text = "<WhiteQuality:Chronomètre hypercorde>"
  },
  RelicConfig_70726_StoryDesc = {
    Text = "\"Oh non, la montre de poche s'est arrêtée.\""
  },
  RelicConfig_70727_BattleDesc = {
    Text = "À la fin du tour, récupère [Heal:Arg1] PV."
  },
  RelicConfig_70727_Desc = {
    Text = "À la fin du tour, récupère [Heal:Arg1] PV."
  },
  RelicConfig_70727_Name = {
    Text = "<OrangeQuality:Sang béni+>"
  },
  RelicConfig_70727_StoryDesc = {
    Text = "Il est doux et raffiné, avec un parfum de rose"
  },
  RelicConfig_70728_BattleDesc = {
    Text = "Utilisez une posture de mer tranquille pour faire perdre à tous les ennemis [Arg1] points de <ExhaustionIconKeywords: force> temporaire, avec un temps de recharge de 3 tours."
  },
  RelicConfig_70728_Desc = {
    Text = "Utilisez une posture de mer tranquille pour faire perdre à tous les ennemis [Arg1] points de <ExhaustionIconKeywords: force> temporaire, avec un temps de recharge de 3 tours."
  },
  RelicConfig_70728_Name = {
    Text = "<OrangeQuality:Membre inconnu+>"
  },
  RelicConfig_70728_StoryDesc = {
    Text = "Attention aux épines"
  },
  RelicConfig_70730_BattleDesc = {
    Text = "Au début de la bataille, obtenez [Arg1] <PowerIconKeywords:force>."
  },
  RelicConfig_70730_Desc = {
    Text = "Au début de la bataille, obtenez [Arg1] <PowerIconKeywords:force>."
  },
  RelicConfig_70730_Name = {
    Text = "<WhiteQuality:Broche en rubis>"
  },
  RelicConfig_70730_StoryDesc = {
    Text = "Un rouge discret suinte"
  },
  RelicConfig_70731_BattleDesc = {
    Text = "Lorsqu'un ennemi vous attaque, inflige [Arg1] Dégâts Fixes. Ces DGT bénéficient d'un bonus de <RetaliateIconKeywords:Contre-attaque> de [Arg2]%. Chaque ennemi peut déclencher cet effet jusqu'à 1 fois par tour."
  },
  RelicConfig_70731_Desc = {
    Text = "Lorsqu'un ennemi vous attaque, inflige des Dégâts Fixes égaux à [Arg3]% des PV Max de l'équipe. Ces DGT bénéficient d'un bonus de <RetaliateIconKeywords:Contre-attaque> de [Arg2]%. Chaque ennemi peut déclencher cet effet jusqu'à 1 fois par tour."
  },
  RelicConfig_70731_Name = {
    Text = "<OrangeQuality:Couteau sacrificiel perdu+>"
  },
  RelicConfig_70731_StoryDesc = {
    Text = "Dague à lame courbée, souvent utilisée dans les rituels"
  },
  RelicConfig_70732_BattleDesc = {
    Text = "Après être entré dans un tour ultra, la première carte de commandement non dérivée jouée prendra effet [Arg1] fois supplémentaires."
  },
  RelicConfig_70732_Desc = {
    Text = "Après être entré dans un tour ultra, la première carte de commandement non dérivée jouée prendra effet [Arg1] fois supplémentaires."
  },
  RelicConfig_70732_Name = {
    Text = "<OrangeQuality:sablier lumineux+>"
  },
  RelicConfig_70732_StoryDesc = {
    Text = "Un temps mesurable"
  },
  RelicConfig_70733_BattleDesc = {
    Text = "<EmbryoFusionIconKeywords:fusion d'embryon> La quantité obtenue automatiquement est augmentée de [Arg1]%."
  },
  RelicConfig_70733_Desc = {
    Text = "<EmbryoFusionIconKeywords:fusion d'embryon> La quantité obtenue automatiquement est augmentée de [Arg1]%."
  },
  RelicConfig_70733_Name = {
    Text = "<OrangeQuality:Diagnostic de peste+>"
  },
  RelicConfig_70733_StoryDesc = {
    Text = "Peste—une manifestation aléatoire de l'agitation inconsciente de la nature"
  },
  RelicConfig_70734_BattleDesc = {
    Text = "Utiliser l'Éveil de la clé d'argent pour augmenter les dégâts de base de tous les réveilleurs de [Arg1] % et obtenir [Arg2] points de s-énergie."
  },
  RelicConfig_70734_Desc = {
    Text = "Utiliser l'Éveil de la clé d'argent pour augmenter les dégâts de base de tous les réveilleurs de [Arg1] % et obtenir [Arg2] points de s-énergie."
  },
  RelicConfig_70734_Name = {
    Text = "<WhiteQuality:Astrolabe ésotérique>"
  },
  RelicConfig_70734_StoryDesc = {
    Text = "Les mystères de l'univers"
  },
  RelicConfig_70735_BattleDesc = {
    Text = "Lorsque vous jouez 2 cartes consécutives dont la consommation en arithmétique est inférieure à celle de la carte précédente, appliquez [Arg1] couches <IntoxicationIconKeywords:poison> à tous les ennemis. Cet effet peut se déclencher jusqu'à 3 fois par tour."
  },
  RelicConfig_70735_Desc = {
    Text = "Lorsque vous jouez 2 cartes consécutives dont la consommation en arithmétique est inférieure à celle de la carte précédente, appliquez [Arg1] couches <IntoxicationIconKeywords:poison> à tous les ennemis. Cet effet peut se déclencher jusqu'à 3 fois par tour."
  },
  RelicConfig_70735_Name = {
    Text = "<OrangeQuality:Relique d'Arcana+>"
  },
  RelicConfig_70735_StoryDesc = {
    Text = "Fin du destin"
  },
  RelicConfig_70736_BattleDesc = {
    Text = "Utilisez une posture de mer tranquille pour faire perdre à tous les ennemis [Arg1] points de <ExhaustionIconKeywords: force> temporaire, avec un temps de recharge de 3 tours."
  },
  RelicConfig_70736_Desc = {
    Text = "Utilisez une posture de mer tranquille pour faire perdre à tous les ennemis [Arg1] points de <ExhaustionIconKeywords: force> temporaire, avec un temps de recharge de 3 tours."
  },
  RelicConfig_70736_Name = {
    Text = "<WhiteQuality:Membre inconnu>"
  },
  RelicConfig_70736_StoryDesc = {
    Text = "Attention aux épines"
  },
  RelicConfig_70737_BattleDesc = {
    Text = "Après avoir joué une carte, si le nombre de cartes en main est inférieur ou égal à [Arg1], piochez [Arg2] cartes, maximum [Arg3] fois par tour."
  },
  RelicConfig_70737_Desc = {
    Text = "Après avoir joué une carte, si le nombre de cartes en main est inférieur ou égal à [Arg1], piochez [Arg2] cartes, maximum [Arg3] fois par tour."
  },
  RelicConfig_70737_Name = {
    Text = "<WhiteQuality:Gants magiques>"
  },
  RelicConfig_70737_StoryDesc = {
    Text = "\"N’aie pas peur, ce n'est qu'une illusion.\""
  },
  RelicConfig_70738_BattleDesc = {
    Text = "À la fin du tour, récupère [Heal:Arg1] PV."
  },
  RelicConfig_70738_Desc = {
    Text = "À la fin du tour, récupère [Heal:Arg1] PV."
  },
  RelicConfig_70738_Name = {
    Text = "<WhiteQuality:Sang béni>"
  },
  RelicConfig_70738_StoryDesc = {
    Text = "Il est doux et raffiné, avec un parfum de rose"
  },
  RelicConfig_70739_BattleDesc = {
    Text = "Utiliser l'Éveil de la clé d'argent puis obtenir [Arg1] point de bouclier et [Arg2] points de s-énergie."
  },
  RelicConfig_70739_Desc = {
    Text = "Utiliser l'Éveil de la clé d'argent puis obtenir [Arg1] point de bouclier et [Arg2] points de s-énergie."
  },
  RelicConfig_70739_Name = {
    Text = "<WhiteQuality:Spécimen de papillon>"
  },
  RelicConfig_70739_StoryDesc = {
    Text = "Jusqu'à présent, il est profondément aimé par quelqu'un"
  },
  RelicConfig_70740_BattleDesc = {
    Text = "Utiliser l'Éveil de la clé d'argent pour augmenter les dégâts de base de tous les réveilleurs de [Arg1] % et obtenir [Arg2] points de s-énergie."
  },
  RelicConfig_70740_Desc = {
    Text = "Utiliser l'Éveil de la clé d'argent pour augmenter les dégâts de base de tous les réveilleurs de [Arg1] % et obtenir [Arg2] points de s-énergie."
  },
  RelicConfig_70740_Name = {
    Text = "<OrangeQuality:Astrolabe ésotérique+>"
  },
  RelicConfig_70740_StoryDesc = {
    Text = "Les mystères de l'univers"
  },
  RelicConfig_70741_BattleDesc = {
    Text = "Capacité maximale augmentée de [Arg1]."
  },
  RelicConfig_70741_Desc = {
    Text = "Capacité maximale augmentée de [Arg1]."
  },
  RelicConfig_70741_Name = {
    Text = "<OrangeQuality:Injecteur actif+>"
  },
  RelicConfig_70741_StoryDesc = {
    Text = "Les convulsions sont aussi une forme d'activité"
  },
  RelicConfig_70742_BattleDesc = {
    Text = "Au début de la bataille, la limite de tentacules augmente de [Arg1]. Obtenez [Arg2] tentacules."
  },
  RelicConfig_70742_Desc = {
    Text = "Au début de la bataille, la limite de tentacules augmente de [Arg1]. Obtenez [Arg2] tentacules."
  },
  RelicConfig_70742_Name = {
    Text = "<WhiteQuality:Chant des profondeurs>"
  },
  RelicConfig_70742_StoryDesc = {
    Text = "On dit que des animaux non comestibles comme le nudibronche absorbent environ 80% des nutriments de l'océan"
  },
  RelicConfig_70743_BattleDesc = {
    Text = "Lors de la première <DevouredIconKeywords:dévoration> de chaque tour, les autres éveillés gagnent [Arg1] folie."
  },
  RelicConfig_70743_Desc = {
    Text = "Lors de la première <DevouredIconKeywords:dévoration> de chaque tour, les autres éveillés gagnent [Arg1] folie."
  },
  RelicConfig_70743_Name = {
    Text = "<WhiteQuality:Douce rêverie>"
  },
  RelicConfig_70743_StoryDesc = {
    Text = "Le jour de la métamorphose sera ta fin"
  },
  RelicConfig_70744_BattleDesc = {
    Text = "Après avoir joué une carte de commandement non dérivée, mélangez [Arg1] copies temporaires de cette carte avec une consommation d'arithmétique réduite de 2 dans la pile de pioche. Temps de recharge : 3 tours."
  },
  RelicConfig_70744_Desc = {
    Text = "Après avoir joué une carte de commandement non dérivée, mélangez [Arg1] copies temporaires de cette carte avec une consommation d'arithmétique réduite de 2 dans la pile de pioche. Temps de recharge : 3 tours."
  },
  RelicConfig_70744_Name = {
    Text = "<OrangeQuality:Phonographe muet+>"
  },
  RelicConfig_70744_StoryDesc = {
    Text = "Sa voix est emportée par le vent"
  },
  RelicConfig_70745_BattleDesc = {
    Text = "Au début de la bataille, obtenez [Arg1] <RetaliateIconKeywords:comptoir>, l'effet est doublé lors des combats contre les boss."
  },
  RelicConfig_70745_Desc = {
    Text = "Au début de la bataille, obtenez [Arg1] <RetaliateIconKeywords:comptoir>, l'effet est doublé lors des combats contre les boss."
  },
  RelicConfig_70745_Name = {
    Text = "<OrangeQuality:Gilet d'ortie+>"
  },
  RelicConfig_70745_StoryDesc = {
    Text = "Impossible d'identifier le liquide contaminé"
  },
  RelicConfig_70746_BattleDesc = {
    Text = "Au début du tour, si la vie est inférieure à 25 %, obtenez [Arg1] points de <PowerIconKeywords:puissance> temporaire."
  },
  RelicConfig_70746_Desc = {
    Text = "Au début du tour, si la vie est inférieure à 25 %, obtenez [Arg1] points de <PowerIconKeywords:puissance> temporaire."
  },
  RelicConfig_70746_Name = {
    Text = "<OrangeQuality:Suprême honneur+>"
  },
  RelicConfig_70746_StoryDesc = {
    Text = "Un chat noir à poil court, élégant et mystérieux, est considéré comme une incarnation divine dans un lointain pays désertique. Mais le nom de cette divinité est aujourd'hui oublié.\nAdoré, vénéré, oublié, peut-être est-ce le destin des dieux"
  },
  RelicConfig_70747_BattleDesc = {
    Text = "Après avoir joué une carte, si le nombre de cartes en main est inférieur ou égal à [Arg1], piochez [Arg2] cartes, maximum [Arg3] fois par tour."
  },
  RelicConfig_70747_Desc = {
    Text = "Après avoir joué une carte, si le nombre de cartes en main est inférieur ou égal à [Arg1], piochez [Arg2] cartes, maximum [Arg3] fois par tour."
  },
  RelicConfig_70747_Name = {
    Text = "<OrangeQuality:Gants magiques+>"
  },
  RelicConfig_70747_StoryDesc = {
    Text = "\"N’aie pas peur, ce n'est qu'une illusion.\""
  },
  RelicConfig_70748_BattleDesc = {
    Text = "Utiliser l'Éveil de la clé d'argent puis obtenir [Arg1] point de bouclier et [Arg2] points de s-énergie."
  },
  RelicConfig_70748_Desc = {
    Text = "Utiliser l'Éveil de la clé d'argent puis obtenir [Arg1] point de bouclier et [Arg2] points de s-énergie."
  },
  RelicConfig_70748_Name = {
    Text = "<OrangeQuality:Spécimen de papillon+>"
  },
  RelicConfig_70748_StoryDesc = {
    Text = "Jusqu'à présent, il est profondément aimé par quelqu'un"
  },
  RelicConfig_70749_BattleDesc = {
    Text = "Chaque fois qu'une carte entre dans l'espace ultra-dimensionnel, si cette carte appartient à un propriétaire différent des autres cartes ultra-dimensionnelles, place [Arg1] cartes <DerivativeCardKeywords_4:\"Inspiration\"> en main."
  },
  RelicConfig_70749_Desc = {
    Text = "Chaque fois qu'une carte entre dans l'espace ultra-dimensionnel, si cette carte appartient à un propriétaire différent des autres cartes ultra-dimensionnelles, place [Arg1] cartes <DerivativeCardKeywords_4:\"Inspiration\"> en main."
  },
  RelicConfig_70749_Name = {
    Text = "<OrangeQuality:Artefact d'Alfonso+>"
  },
  RelicConfig_70749_StoryDesc = {
    Text = "Contrairement au destin capricieux, les étoiles suivent leurs propres lois"
  },
  RelicConfig_70750_BattleDesc = {
    Text = "Lorsque vous jouez 2 cartes consécutives ayant une consommation de puissance supérieure à celle de la carte précédente, obtenez [Arg1] <RetaliateIconKeywords:riposte>, déclenchable jusqu'à 3 fois par tour."
  },
  RelicConfig_70750_Desc = {
    Text = "Lorsque vous jouez 2 cartes consécutives ayant une consommation de puissance supérieure à celle de la carte précédente, obtenez [Arg1] <RetaliateIconKeywords:riposte>, déclenchable jusqu'à 3 fois par tour."
  },
  RelicConfig_70750_Name = {
    Text = "<WhiteQuality:Enregistrement d'Arcana>"
  },
  RelicConfig_70750_StoryDesc = {
    Text = "Tendance du destin"
  },
  RelicConfig_70751_BattleDesc = {
    Text = "Utiliser l'Éveil de la clé d'argent puis obtenir [Arg1] points d'arithmetica et [Arg2] points de s-énergie."
  },
  RelicConfig_70751_Desc = {
    Text = "Utiliser l'Éveil de la clé d'argent puis obtenir [Arg1] points d'arithmetica et [Arg2] points de s-énergie."
  },
  RelicConfig_70751_Name = {
    Text = "<WhiteQuality:emblème de mythag>"
  },
  RelicConfig_70751_StoryDesc = {
    Text = "L'insigne distribué aux enquêteurs par l'université de Mythag. Il symbolise non seulement l'identité du porteur, mais sert également d'outil de communication à distance"
  },
  RelicConfig_70752_BattleDesc = {
    Text = "Utilisez l'Éveil de la clé d'argent puis obtenez [Arg1] points de <RetaliateIconKeywords:comptoir> et [Arg2] points de s-énergie."
  },
  RelicConfig_70752_Desc = {
    Text = "Utilisez l'Éveil de la clé d'argent puis obtenez [Arg1] points de <RetaliateIconKeywords:comptoir> et [Arg2] points de s-énergie."
  },
  RelicConfig_70752_Name = {
    Text = "<WhiteQuality:Chapitre du sage>"
  },
  RelicConfig_70752_StoryDesc = {
    Text = "\"À quel point les humains sont fous, croyant aveuglément simplement parce que c'est ancien.\""
  },
  RelicConfig_70753_BattleDesc = {
    Text = "Au début de la bataille, appliquez [Arg1] couches <VulnerabilityIconKeywords:vulnérable> à tous les ennemis, l'effet est doublé lors des combats de boss. Tous les réveilleurs voient leurs dégâts de base augmenter de [Arg2] %."
  },
  RelicConfig_70753_Desc = {
    Text = "Au début de la bataille, appliquez [Arg1] couches <VulnerabilityIconKeywords:vulnérable> à tous les ennemis, l'effet est doublé lors des combats de boss. Tous les réveilleurs voient leurs dégâts de base augmenter de [Arg2] %."
  },
  RelicConfig_70753_Name = {
    Text = "<OrangeQuality:Sacrifice du printemps+>"
  },
  RelicConfig_70753_StoryDesc = {
    Text = "Dans les rires de la nuit, la silhouette du canoë glisse librement sur le lac"
  },
  RelicConfig_70754_BattleDesc = {
    Text = "La première fois que vous utilisez directement « embryon » chaque tour, les dégâts actifs infligent des <BleedingIconKeywords:saignement> équivalents à [Arg1] % des dégâts infligés ce tour-ci."
  },
  RelicConfig_70754_Desc = {
    Text = "La première fois que vous utilisez directement « embryon » chaque tour, les dégâts actifs infligent des <BleedingIconKeywords:saignement> équivalents à [Arg1] % des dégâts infligés ce tour-ci."
  },
  RelicConfig_70754_Name = {
    Text = "<WhiteQuality:Galet ensanglanté>"
  },
  RelicConfig_70754_StoryDesc = {
    Text = "Un, deux, trois, quatre, cinq"
  },
  RelicConfig_70755_BattleDesc = {
    Text = "Chaque fois que des dégâts sont infligés, obtenez [Arg1] points de <PowerIconKeywords:force> temporaire, jusqu'à 15 fois par tour."
  },
  RelicConfig_70755_Desc = {
    Text = "Chaque fois que des dégâts sont infligés, obtenez [Arg1] points de <PowerIconKeywords:force> temporaire, jusqu'à 15 fois par tour."
  },
  RelicConfig_70755_Name = {
    Text = "<OrangeQuality:Agate enroulée+>"
  },
  RelicConfig_70755_StoryDesc = {
    Text = "Ce ne sont probablement que des motifs d'agate ordinaires. Peut-être"
  },
  RelicConfig_70756_BattleDesc = {
    Text = "Utiliser l'Éveil de la clé d'argent puis obtenir [Arg1] points d'arithmetica et [Arg2] points de s-énergie."
  },
  RelicConfig_70756_Desc = {
    Text = "Utiliser l'Éveil de la clé d'argent puis obtenir [Arg1] points d'arithmetica et [Arg2] points de s-énergie."
  },
  RelicConfig_70756_Name = {
    Text = "<OrangeQuality:Emblème de mythag+>"
  },
  RelicConfig_70756_StoryDesc = {
    Text = "L'insigne distribué aux enquêteurs par l'université de Mythag. Il symbolise non seulement l'identité du porteur, mais sert également d'outil de communication à distance"
  },
  RelicConfig_70757_BattleDesc = {
    Text = "Utilisez la posture « Tsunami » pour déclencher immédiatement toutes les attaques de tentacules contre l'ennemi [Arg1] fois. Temps de recharge : 3 tours."
  },
  RelicConfig_70757_Desc = {
    Text = "Utilisez la posture « Tsunami » pour déclencher immédiatement toutes les attaques de tentacules contre l'ennemi [Arg1] fois. Temps de recharge : 3 tours."
  },
  RelicConfig_70757_Name = {
    Text = "<WhiteQuality:Joie de la Spirale>"
  },
  RelicConfig_70757_StoryDesc = {
    Text = "Seigneur du Sommeil, attends ton rêve"
  },
  RelicConfig_70758_BattleDesc = {
    Text = "Lorsque vous jouez 2 cartes consécutives dont la consommation en arithmétique est inférieure à celle de la carte précédente, appliquez [Arg1] couches <IntoxicationIconKeywords:poison> à tous les ennemis. Cet effet peut se déclencher jusqu'à 3 fois par tour."
  },
  RelicConfig_70758_Desc = {
    Text = "Lorsque vous jouez 2 cartes consécutives dont la consommation en arithmétique est inférieure à celle de la carte précédente, appliquez [Arg1] couches <IntoxicationIconKeywords:poison> à tous les ennemis. Cet effet peut se déclencher jusqu'à 3 fois par tour."
  },
  RelicConfig_70758_Name = {
    Text = "<WhiteQuality:Relique d'Arcana>"
  },
  RelicConfig_70758_StoryDesc = {
    Text = "Fin du destin"
  },
  RelicConfig_70759_BattleDesc = {
    Text = "Après le début de la bataille, appliquez [Arg1] couches de <WeaknessIconKeywords:faiblesse> à tous les ennemis, l'effet est doublé lors des combats contre un boss. Tous les éveillés voient leurs dégâts de base augmenter de [Arg2] %."
  },
  RelicConfig_70759_Desc = {
    Text = "Après le début de la bataille, appliquez [Arg1] couches de <WeaknessIconKeywords:faiblesse> à tous les ennemis, l'effet est doublé lors des combats contre un boss. Tous les éveillés voient leurs dégâts de base augmenter de [Arg2] %."
  },
  RelicConfig_70759_Name = {
    Text = "<WhiteQuality:Enfant terrible>"
  },
  RelicConfig_70759_StoryDesc = {
    Text = "Né de la pure méchanceté, même si ce n'était pas son souhait"
  },
  RelicConfig_70760_BattleDesc = {
    Text = "Au début de la bataille, appliquez [Arg1] couches d'<IntoxicationIconKeywords:empoisonnement> à tous les ennemis. L'effet est doublé lors des combats de boss."
  },
  RelicConfig_70760_Desc = {
    Text = "Au début de la bataille, appliquez [Arg1] couches d'<IntoxicationIconKeywords:empoisonnement> à tous les ennemis. L'effet est doublé lors des combats de boss."
  },
  RelicConfig_70760_Name = {
    Text = "<WhiteQuality:Neurotoxine>"
  },
  RelicConfig_70760_StoryDesc = {
    Text = "Extraction, raffinement"
  },
  RelicConfig_70761_BattleDesc = {
    Text = "Au début de la bataille, appliquez [Arg1] couches <VulnerabilityIconKeywords:vulnérable> à tous les ennemis, l'effet est doublé lors des combats de boss. Tous les réveilleurs voient leurs dégâts de base augmenter de [Arg2] %."
  },
  RelicConfig_70761_Desc = {
    Text = "Au début de la bataille, appliquez [Arg1] couches <VulnerabilityIconKeywords:vulnérable> à tous les ennemis, l'effet est doublé lors des combats de boss. Tous les réveilleurs voient leurs dégâts de base augmenter de [Arg2] %."
  },
  RelicConfig_70761_Name = {
    Text = "<WhiteQuality:Sacrifice du printemps>"
  },
  RelicConfig_70761_StoryDesc = {
    Text = "Dans les rires de la nuit, la silhouette du canoë glisse librement sur le lac"
  },
  RelicConfig_70762_BattleDesc = {
    Text = "Après avoir libéré 4 exaltations en un tour, obtenez [Arg1] points d'arithmétique, avec un temps de recharge de 3 tours."
  },
  RelicConfig_70762_Desc = {
    Text = "Après avoir libéré 4 exaltations en un tour, obtenez [Arg1] points d'arithmétique, avec un temps de recharge de 3 tours."
  },
  RelicConfig_70762_Name = {
    Text = "<OrangeQuality:Machine à différence argentée+>"
  },
  RelicConfig_70762_StoryDesc = {
    Text = "\"Cela a changé l'histoire.\""
  },
  RelicConfig_70763_BattleDesc = {
    Text = "Après avoir libéré « l'exaltation », gagnez [Arg1] points temporaires de <PowerIconKeywords:pouvoir>."
  },
  RelicConfig_70763_Desc = {
    Text = "Après avoir libéré « l'exaltation », gagnez [Arg1] points temporaires de <PowerIconKeywords:pouvoir>."
  },
  RelicConfig_70763_Name = {
    Text = "<WhiteQuality:Verrou lourd>"
  },
  RelicConfig_70763_StoryDesc = {
    Text = "Un verrou épais et solide, difficile à ouvrir sans clé.\nBien sûr, cela ne pose aucun problème pour un certain voleur"
  },
  RelicConfig_70764_BattleDesc = {
    Text = "Lorsqu'un ennemi vous attaque, inflige [Arg1] Dégâts Fixes. Ces DGT bénéficient d'un bonus de <RetaliateIconKeywords:Contre-attaque> de [Arg2]%. Chaque ennemi peut déclencher cet effet jusqu'à 1 fois par tour."
  },
  RelicConfig_70764_Desc = {
    Text = "Lorsqu'un ennemi vous attaque, inflige des Dégâts Fixes égaux à [Arg3]% des PV Max de l'équipe. Ces DGT bénéficient d'un bonus de <RetaliateIconKeywords:Contre-attaque> de [Arg2]%. Chaque ennemi peut déclencher cet effet jusqu'à 1 fois par tour."
  },
  RelicConfig_70764_Name = {
    Text = "<WhiteQuality:Couteau sacrificiel perdu>"
  },
  RelicConfig_70764_StoryDesc = {
    Text = "Dague à lame courbée, souvent utilisée dans les rituels"
  },
  RelicConfig_70765_BattleDesc = {
    Text = "Chaque fois que des dégâts sont infligés, obtenez [Arg1] points de <PowerIconKeywords:force> temporaire, jusqu'à 15 fois par tour."
  },
  RelicConfig_70765_Desc = {
    Text = "Chaque fois que des dégâts sont infligés, obtenez [Arg1] points de <PowerIconKeywords:force> temporaire, jusqu'à 15 fois par tour."
  },
  RelicConfig_70765_Name = {
    Text = "<WhiteQuality:Agate enroulée>"
  },
  RelicConfig_70765_StoryDesc = {
    Text = "Ce ne sont probablement que des motifs d'agate ordinaires. Peut-être"
  },
  RelicConfig_70766_BattleDesc = {
    Text = "Au début du tour, si la vie est inférieure à 25 %, obtenez [Arg1] points de bouclier."
  },
  RelicConfig_70766_Desc = {
    Text = "Au début du tour, si la vie est inférieure à 25 %, obtenez [Arg1] points de bouclier."
  },
  RelicConfig_70766_Name = {
    Text = "<WhiteQuality:Main protectrice>"
  },
  RelicConfig_70766_StoryDesc = {
    Text = "Main bénissante, poing ferme"
  },
  RelicConfig_70767_BattleDesc = {
    Text = "Détruisez pour que l'éveillé avec la folie la plus basse gagne [Arg1] points de folie, temps de recharge de 3 tours."
  },
  RelicConfig_70767_Desc = {
    Text = "Détruisez pour que l'éveillé avec la folie la plus basse gagne [Arg1] points de folie, temps de recharge de 3 tours."
  },
  RelicConfig_70767_Name = {
    Text = "<WhiteQuality:Ver du temps>"
  },
  RelicConfig_70767_StoryDesc = {
    Text = "Une montre de poche présente à la fois dans une horlogerie et un musée d'insectes.\nAprès l'année de l'Holocène, elle a été intégrée à la collection universitaire"
  },
  RelicConfig_70768_BattleDesc = {
    Text = "Après le début de la bataille, obtenez [Arg1] <ProficientInRealmsIconKeywords:maîtrise des domaines>. Tous les <RetaliateIconKeywords:contre-attaques> infligés par les réveilleurs ainsi que ceux causés par les créations augmentent de [Arg2] %."
  },
  RelicConfig_70768_Desc = {
    Text = "Après le début de la bataille, obtenez [Arg1] <ProficientInRealmsIconKeywords:maîtrise des domaines>. Tous les <RetaliateIconKeywords:contre-attaques> infligés par les réveilleurs ainsi que ceux causés par les créations augmentent de [Arg2] %."
  },
  RelicConfig_70768_Name = {
    Text = "<OrangeQuality:Franc-parler+>"
  },
  RelicConfig_70768_StoryDesc = {
    Text = "Il a transmis d'innombrables secrets, actifs ou passifs"
  },
  RelicConfig_70769_BattleDesc = {
    Text = "La première fois que vous utilisez directement « embryon » chaque tour, les dégâts actifs infligent des <BleedingIconKeywords:saignement> équivalents à [Arg1] % des dégâts infligés ce tour-ci."
  },
  RelicConfig_70769_Desc = {
    Text = "La première fois que vous utilisez directement « embryon » chaque tour, les dégâts actifs infligent des <BleedingIconKeywords:saignement> équivalents à [Arg1] % des dégâts infligés ce tour-ci."
  },
  RelicConfig_70769_Name = {
    Text = "<OrangeQuality:Galet ensanglanté+>"
  },
  RelicConfig_70769_StoryDesc = {
    Text = "Un, deux, trois, quatre, cinq"
  },
  RelicConfig_70770_BattleDesc = {
    Text = "Au début du tour, piochez [Arg1] cartes"
  },
  RelicConfig_70770_Desc = {
    Text = "Au début du tour, piochez [Arg1] cartes"
  },
  RelicConfig_70770_Name = {
    Text = "<WhiteQuality:Boussole>"
  },
  RelicConfig_70770_StoryDesc = {
    Text = "Ce qui est indiqué n'est pas une direction, mais un champ magnétique"
  },
  RelicConfig_70771_BattleDesc = {
    Text = "« Frappe » inflige 2 fois supplémentaires des dégâts équivalents à [Arg1] % de l'attaque de l'éveillé, avec un maximum de 3 déclenchements par tour."
  },
  RelicConfig_70771_Desc = {
    Text = "« Frappe » inflige 2 fois supplémentaires des dégâts équivalents à [Arg1] % de l'attaque de l'éveillé, avec un maximum de 3 déclenchements par tour."
  },
  RelicConfig_70771_Name = {
    Text = "<OrangeQuality:Scalpel rouillé+>"
  },
  RelicConfig_70771_StoryDesc = {
    Text = "Pas adapté pour couper des tissus vivants"
  },
  RelicConfig_70772_BattleDesc = {
    Text = "Utiliser l'Éveil de la clé d'argent, puis piocher [Arg1] cartes et obtenir [Arg2] points de s-énergie."
  },
  RelicConfig_70772_Desc = {
    Text = "Utiliser l'Éveil de la clé d'argent, puis piocher [Arg1] cartes et obtenir [Arg2] points de s-énergie."
  },
  RelicConfig_70772_Name = {
    Text = "<WhiteQuality:Portefeuille neuf>"
  },
  RelicConfig_70772_StoryDesc = {
    Text = "Un portefeuille en cuir portant le blason de l'université de Mythag.\nIl est maintenant vide, ne contenant rien"
  },
  RelicConfig_70774_BattleDesc = {
    Text = "Les dégâts infligés lors des cinq premières attaques de chaque tour augmentent de [Arg1] %."
  },
  RelicConfig_70774_Desc = {
    Text = "Les dégâts infligés lors des cinq premières attaques de chaque tour augmentent de [Arg1] %."
  },
  RelicConfig_70774_Name = {
    Text = "<WhiteQuality:Correcteur de vision>"
  },
  RelicConfig_70774_StoryDesc = {
    Text = "Quelqu'un a trouvé la vérité à travers elle"
  },
  RelicConfig_70776_BattleDesc = {
    Text = "Au début de la bataille, obtenez [Arg1] <RetaliateIconKeywords:comptoir>, l'effet est doublé lors des combats contre les boss."
  },
  RelicConfig_70776_Desc = {
    Text = "Au début de la bataille, obtenez [Arg1] <RetaliateIconKeywords:comptoir>, l'effet est doublé lors des combats contre les boss."
  },
  RelicConfig_70776_Name = {
    Text = "<WhiteQuality:Gilet d'ortie>"
  },
  RelicConfig_70776_StoryDesc = {
    Text = "Impossible d'identifier le liquide contaminé"
  },
  RelicConfig_70777_BattleDesc = {
    Text = "Après avoir joué 4 cartes de commandement appartenant à différents éveilleurs au cours d'un même tour, tous les éveilleurs gagnent [Arg1] points d'aliemus, avec un temps de recharge de 3 tours."
  },
  RelicConfig_70777_Desc = {
    Text = "Après avoir joué 4 cartes de commandement appartenant à différents éveilleurs au cours d'un même tour, tous les éveilleurs gagnent [Arg1] points d'aliemus, avec un temps de recharge de 3 tours."
  },
  RelicConfig_70777_Name = {
    Text = "<WhiteQuality:Voile du Dieu sans nom>"
  },
  RelicConfig_70777_StoryDesc = {
    Text = "Ne pas regarder directement le dieu"
  },
  RelicConfig_70778_BattleDesc = {
    Text = "Au début de la bataille, appliquez [Arg1] couches d'<IntoxicationIconKeywords:empoisonnement> à tous les ennemis. L'effet est doublé lors des combats de boss."
  },
  RelicConfig_70778_Desc = {
    Text = "Au début de la bataille, appliquez [Arg1] couches d'<IntoxicationIconKeywords:empoisonnement> à tous les ennemis. L'effet est doublé lors des combats de boss."
  },
  RelicConfig_70778_Name = {
    Text = "<OrangeQuality:Neurotoxine+>"
  },
  RelicConfig_70778_StoryDesc = {
    Text = "Extraction, raffinement"
  },
  RelicConfig_70779_BattleDesc = {
    Text = "Utiliser l'Éveil de la clé d'argent puis appliquer [Arg1] niveaux d'<IntoxicationIconKeywords:empoisonnement> à tous les ennemis et obtenir [Arg2] points de s-énergie."
  },
  RelicConfig_70779_Desc = {
    Text = "Utiliser l'Éveil de la clé d'argent puis appliquer [Arg1] niveaux d'<IntoxicationIconKeywords:empoisonnement> à tous les ennemis et obtenir [Arg2] points de s-énergie."
  },
  RelicConfig_70779_Name = {
    Text = "<WhiteQuality:Pommade suspecte>"
  },
  RelicConfig_70779_StoryDesc = {
    Text = "Un certain onguent local pour blessures, merci de ne pas l'utiliser sans l'avis d'un médecin"
  },
  RelicConfig_70780_BattleDesc = {
    Text = "«Attaque» applique un <IntoxicationIconKeywords:poison> équivalent à [Arg1]% des dégâts, avec un maximum de [Arg2] points par tour."
  },
  RelicConfig_70780_Desc = {
    Text = "«Attaque» applique un <IntoxicationIconKeywords:poison> équivalent à [Arg1]% des dégâts, avec un maximum de [Arg2] points par tour."
  },
  RelicConfig_70780_Name = {
    Text = "<WhiteQuality:Langue étrangère>"
  },
  RelicConfig_70780_StoryDesc = {
    Text = "Il n'est pas un démon, mais il transmet des murmures d'un autre monde"
  },
  RelicConfig_70781_BattleDesc = {
    Text = "Au début du tour, si la vie est inférieure à 25 %, obtenez [Arg1] points de bouclier."
  },
  RelicConfig_70781_Desc = {
    Text = "Au début du tour, si la vie est inférieure à 25 %, obtenez [Arg1] points de bouclier."
  },
  RelicConfig_70781_Name = {
    Text = "<OrangeQuality:Main protectrice+>"
  },
  RelicConfig_70781_StoryDesc = {
    Text = "Main bénissante, poing ferme"
  },
  RelicConfig_70782_BattleDesc = {
    Text = "Perdre de la vie permet d'obtenir un montant de fournaise cramoisie équivalent à [Arg1] % de la vie perdue."
  },
  RelicConfig_70782_Desc = {
    Text = "Perdre de la vie permet d'obtenir un montant de fournaise cramoisie équivalent à [Arg1] % de la vie perdue."
  },
  RelicConfig_70782_Name = {
    Text = "<OrangeQuality:Scie rouillée+>"
  },
  RelicConfig_70782_StoryDesc = {
    Text = "Le médecin de la dissection ne voit jamais de belles femmes, seulement un sac de os, des nerfs enflammés par la maladie, des muscles et des tissus"
  },
  RelicConfig_70783_BattleDesc = {
    Text = "Les dégâts infligés lors des cinq premières attaques de chaque tour augmentent de [Arg1] %."
  },
  RelicConfig_70783_Desc = {
    Text = "Les dégâts infligés lors des cinq premières attaques de chaque tour augmentent de [Arg1] %."
  },
  RelicConfig_70783_Name = {
    Text = "<OrangeQuality:Correcteur de vision+>"
  },
  RelicConfig_70783_StoryDesc = {
    Text = "Quelqu'un a trouvé la vérité à travers elle"
  },
  RelicConfig_70784_BattleDesc = {
    Text = "Chaque fois qu'une carte entre dans l'espace ultra-dimensionnel, si cette carte appartient à un propriétaire différent des autres cartes ultra-dimensionnelles, place [Arg1] cartes <DerivativeCardKeywords_4:\"Inspiration\"> en main."
  },
  RelicConfig_70784_Desc = {
    Text = "Chaque fois qu'une carte entre dans l'espace ultra-dimensionnel, si cette carte appartient à un propriétaire différent des autres cartes ultra-dimensionnelles, place [Arg1] cartes <DerivativeCardKeywords_4:\"Inspiration\"> en main."
  },
  RelicConfig_70784_Name = {
    Text = "<WhiteQuality:Artefact d'Alfonso>"
  },
  RelicConfig_70784_StoryDesc = {
    Text = "Contrairement au destin capricieux, les étoiles suivent leurs propres lois"
  },
  RelicConfig_70785_BattleDesc = {
    Text = "Après avoir joué 4 cartes de commandement appartenant à différents éveilleurs au cours d'un même tour, tous les éveilleurs gagnent [Arg1] points d'aliemus, avec un temps de recharge de 3 tours."
  },
  RelicConfig_70785_Desc = {
    Text = "Après avoir joué 4 cartes de commandement appartenant à différents éveilleurs au cours d'un même tour, tous les éveilleurs gagnent [Arg1] points d'aliemus, avec un temps de recharge de 3 tours."
  },
  RelicConfig_70785_Name = {
    Text = "<OrangeQuality:Voile du Dieu sans nom+>"
  },
  RelicConfig_70785_StoryDesc = {
    Text = "Ne pas regarder directement le dieu"
  },
  RelicConfig_70786_BattleDesc = {
    Text = "À la fin du tour, si vous êtes en posture de marée montante, obtenez [Arg1] <TentacleInjurieIconKeywords:dégâts de tentacule>. Temps de recharge : 3 tours."
  },
  RelicConfig_70786_Desc = {
    Text = "À la fin du tour, si vous êtes en posture de marée montante, obtenez [Arg1] <TentacleInjurieIconKeywords:dégâts de tentacule>. Temps de recharge : 3 tours."
  },
  RelicConfig_70786_Name = {
    Text = "<WhiteQuality:Céphalopode>"
  },
  RelicConfig_70786_StoryDesc = {
    Text = "Tant que notre cerveau reste un mystère, il n'y a rien d'étonnant à ce qu'il soit rempli de tentacules"
  },
  RelicConfig_70787_BattleDesc = {
    Text = "Tous les éveillés voient leurs dégâts de base augmenter de [Arg1] %."
  },
  RelicConfig_70787_Desc = {
    Text = "Tous les éveillés voient leurs dégâts de base augmenter de [Arg1] %."
  },
  RelicConfig_70787_Name = {
    Text = "<OrangeQuality:Pipe pleureuse+>"
  },
  RelicConfig_70787_StoryDesc = {
    Text = "Est-ce le fruit de la haine ou le résultat de la vengeance ?"
  },
  RelicConfig_70788_BattleDesc = {
    Text = "Utiliser l'Éveil de la clé d'argent, puis tous les réveilleurs obtiennent [Arg1] points de folie et [Arg2] points de s-énergie."
  },
  RelicConfig_70788_Desc = {
    Text = "Utiliser l'Éveil de la clé d'argent, puis tous les réveilleurs obtiennent [Arg1] points de folie et [Arg2] points de s-énergie."
  },
  RelicConfig_70788_Name = {
    Text = "<WhiteQuality:Boutons de manchette>"
  },
  RelicConfig_70788_StoryDesc = {
    Text = "Boutons de manchette en argent avec motif de laurier.\nIls sont finement travaillés et brillants, symbolisant l'amitié de deux enfants"
  },
  RelicConfig_70789_BattleDesc = {
    Text = "Après le début de la bataille, obtenez [Arg1] <ProficientInRealmsIconKeywords:maîtrise des domaines>. Tous les réveilleurs voient leurs <IntoxicationIconKeywords:empoisonnements> ainsi que les <IntoxicationIconKeywords:empoisonnements> infligés par les créations augmenter de [Arg2] %."
  },
  RelicConfig_70789_Desc = {
    Text = "Après le début de la bataille, obtenez [Arg1] <ProficientInRealmsIconKeywords:maîtrise des domaines>. Tous les réveilleurs voient leurs <IntoxicationIconKeywords:empoisonnements> ainsi que les <IntoxicationIconKeywords:empoisonnements> infligés par les créations augmenter de [Arg2] %."
  },
  RelicConfig_70789_Name = {
    Text = "<WhiteQuality:Machine à coudre poussiéreuse>"
  },
  RelicConfig_70789_StoryDesc = {
    Text = "Une mère aimante, réparant les blessures du cœur"
  },
  RelicConfig_70790_BattleDesc = {
    Text = "Détruisez pour que l'éveillé avec la folie la plus basse gagne [Arg1] points de folie, temps de recharge de 3 tours."
  },
  RelicConfig_70790_Desc = {
    Text = "Détruisez pour que l'éveillé avec la folie la plus basse gagne [Arg1] points de folie, temps de recharge de 3 tours."
  },
  RelicConfig_70790_Name = {
    Text = "<OrangeQuality:Ver du temps+>"
  },
  RelicConfig_70790_StoryDesc = {
    Text = "Une montre de poche présente à la fois dans une horlogerie et un musée d'insectes.\nAprès l'année de l'Holocène, elle a été intégrée à la collection universitaire"
  },
  RelicConfig_70791_BattleDesc = {
    Text = "Au début de la bataille, la limite de tentacules augmente de [Arg1]. Obtenez [Arg2] tentacules."
  },
  RelicConfig_70791_Desc = {
    Text = "Au début de la bataille, la limite de tentacules augmente de [Arg1]. Obtenez [Arg2] tentacules."
  },
  RelicConfig_70791_Name = {
    Text = "<OrangeQuality:Chant des profondeurs+>"
  },
  RelicConfig_70791_StoryDesc = {
    Text = "On dit que des animaux non comestibles comme le nudibronche absorbent environ 80% des nutriments de l'océan"
  },
  RelicConfig_70792_BattleDesc = {
    Text = "À la fin du tour, si vous êtes en posture de marée montante, obtenez [Arg1] <TentacleInjurieIconKeywords:dégâts de tentacule>. Temps de recharge : 3 tours."
  },
  RelicConfig_70792_Desc = {
    Text = "À la fin du tour, si vous êtes en posture de marée montante, obtenez [Arg1] <TentacleInjurieIconKeywords:dégâts de tentacule>. Temps de recharge : 3 tours."
  },
  RelicConfig_70792_Name = {
    Text = "<OrangeQuality:Céphalopode+>"
  },
  RelicConfig_70792_StoryDesc = {
    Text = "Tant que notre cerveau reste un mystère, il n'y a rien d'étonnant à ce qu'il soit rempli de tentacules"
  },
  RelicConfig_70793_BattleDesc = {
    Text = "Lors de la première <DevouredIconKeywords:dévoration> de chaque tour, les autres éveillés gagnent [Arg1] folie."
  },
  RelicConfig_70793_Desc = {
    Text = "Lors de la première <DevouredIconKeywords:dévoration> de chaque tour, les autres éveillés gagnent [Arg1] folie."
  },
  RelicConfig_70793_Name = {
    Text = "<OrangeQuality:Douce rêverie+>"
  },
  RelicConfig_70793_StoryDesc = {
    Text = "Le jour de la métamorphose sera ta fin"
  },
  RelicConfig_70794_BattleDesc = {
    Text = "Anéantir : Obtenez [Arg1] boucliers. 3 tours de repos requis."
  },
  RelicConfig_70794_Desc = {
    Text = "Anéantir : Obtenez [Arg1] boucliers. 3 tours de repos requis."
  },
  RelicConfig_70794_Name = {
    Text = "<OrangeQuality:Chronomètre hypercorde+>"
  },
  RelicConfig_70794_StoryDesc = {
    Text = "\"Oh non, la montre de poche s'est arrêtée.\""
  },
  RelicConfig_70795_BattleDesc = {
    Text = "Après avoir joué une carte de commandement non dérivée, mélangez [Arg1] copies temporaires de cette carte avec une consommation d'arithmétique réduite de 2 dans la pile de pioche. Temps de recharge : 3 tours."
  },
  RelicConfig_70795_Desc = {
    Text = "Après avoir joué une carte de commandement non dérivée, mélangez [Arg1] copies temporaires de cette carte avec une consommation d'arithmétique réduite de 2 dans la pile de pioche. Temps de recharge : 3 tours."
  },
  RelicConfig_70795_Name = {
    Text = "<WhiteQuality:Phonographe muet>"
  },
  RelicConfig_70795_StoryDesc = {
    Text = "Sa voix est emportée par le vent"
  },
  RelicConfig_70796_BattleDesc = {
    Text = "Après avoir déclenché « Exaltation, », tous les ennemis subissent [Arg1] <FixedDamage:DGT Purs> et déclenchent [Arg2]% de <IntoxicationIconKeywords:Poison>."
  },
  RelicConfig_70796_Desc = {
    Text = "Après avoir déclenché « Exaltation, », tous les ennemis subissent 1 instance de <FixedDamage:DGT Purs> égaux à [Arg2]% des PV Max de l'équipe et déclenchent [Arg2]% de <IntoxicationIconKeywords:Poison>."
  },
  RelicConfig_70796_Name = {
    Text = "<OrangeQuality:Mâchoire laser+>"
  },
  RelicConfig_70796_StoryDesc = {
    Text = "Les ossements exposés dans la salle privée d'un collectionneur.\nLe collectionneur, fasciné par cette belle lueur, les admirait jour et nuit, finissant par mourir et devenir l'un d'eux"
  },
  RelicConfig_70797_BattleDesc = {
    Text = "Capacité maximale augmentée de [Arg1]."
  },
  RelicConfig_70797_Desc = {
    Text = "Capacité maximale augmentée de [Arg1]."
  },
  RelicConfig_70797_Name = {
    Text = "<WhiteQuality:Injecteur actif>"
  },
  RelicConfig_70797_StoryDesc = {
    Text = "Les convulsions sont aussi une forme d'activité"
  },
  RelicConfig_70798_BattleDesc = {
    Text = "Utilisez la posture « Tsunami » pour déclencher immédiatement toutes les attaques de tentacules contre l'ennemi [Arg1] fois. Temps de recharge : 3 tours."
  },
  RelicConfig_70798_Desc = {
    Text = "Utilisez la posture « Tsunami » pour déclencher immédiatement toutes les attaques de tentacules contre l'ennemi [Arg1] fois. Temps de recharge : 3 tours."
  },
  RelicConfig_70798_Name = {
    Text = "<OrangeQuality:Joie de la spirale+>"
  },
  RelicConfig_70798_StoryDesc = {
    Text = "Seigneur du Sommeil, attends ton rêve"
  },
  RelicConfig_70799_BattleDesc = {
    Text = "Lorsque vous utilisez « Défense », obtenez [Arg1] points de <RetaliateIconKeywords:contre-attaque> temporaire, déclenchable jusqu'à 3 fois par tour."
  },
  RelicConfig_70799_Desc = {
    Text = "Lorsque vous utilisez « Défense », obtenez [Arg1] points de <RetaliateIconKeywords:contre-attaque> temporaire, déclenchable jusqu'à 3 fois par tour."
  },
  RelicConfig_70799_Name = {
    Text = "<OrangeQuality:Montre de l'ami+>"
  },
  RelicConfig_70799_StoryDesc = {
    Text = "Portant souvenirs et tristesse, avancez vers l'inconnu"
  },
  RelicConfig_70800_BattleDesc = {
    Text = "Lorsque vous utilisez « Défense », obtenez [Arg1] points de <RetaliateIconKeywords:contre-attaque> temporaire, déclenchable jusqu'à 3 fois par tour."
  },
  RelicConfig_70800_Desc = {
    Text = "Lorsque vous utilisez « Défense », obtenez [Arg1] points de <RetaliateIconKeywords:contre-attaque> temporaire, déclenchable jusqu'à 3 fois par tour."
  },
  RelicConfig_70800_Name = {
    Text = "<WhiteQuality:Montre de l'ami>"
  },
  RelicConfig_70800_StoryDesc = {
    Text = "Portant souvenirs et tristesse, avancez vers l'inconnu"
  },
  RelicConfig_70986_BattleDesc = {
    Text = "Au début de la bataille, le plafond de l'arithmétique augmente de 1, réveillez tous les réveilleurs. Au début des tours impairs, choisissez 1 relique parmi 2, effet persistant pendant 5 tours impairs."
  },
  RelicConfig_70986_Desc = {
    Text = "Au début de la bataille, le plafond de l'arithmétique augmente de 1, réveillez tous les réveilleurs. Au début des tours impairs, choisissez 1 relique parmi 2, effet persistant pendant 5 tours impairs."
  },
  RelicConfig_70986_Name = {
    Text = "<OrangeQuality:Cadran Chrono \"Souhait η\">"
  },
  RelicConfig_70987_BattleDesc = {
    Text = "Au début de la bataille, le plafond de l'arithmétique augmente de 1, réveillez tous les réveilleurs. Au début des tours impairs, choisissez 1 relique parmi 2, effet persistant pendant 5 tours impairs."
  },
  RelicConfig_70987_Desc = {
    Text = "Au début de la bataille, le plafond de l'arithmétique augmente de 1, réveillez tous les réveilleurs. Au début des tours impairs, choisissez 1 relique parmi 2, effet persistant pendant 5 tours impairs."
  },
  RelicConfig_70987_Name = {
    Text = "<OrangeQuality:Cadran Chrono \"Souhait ζ\">"
  },
  RelicConfig_71195_BattleDesc = {
    Text = "Au début du tour, Ramona circulaire obtient [Arg1] points de folie. Lorsque « Boucle » est déclenchée pour la première fois chaque tour, obtenez [Arg2] points d'énergie de clé argentée et [Arg3] couches de « négentropie »."
  },
  RelicConfig_71195_Desc = {
    Text = "Au début du tour, Ramona circulaire obtient [Arg1] points de folie. Lorsque « Boucle » est déclenchée pour la première fois chaque tour, obtenez [Arg2] points d'énergie de clé argentée et [Arg3] couches de « négentropie »."
  },
  RelicConfig_71195_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Anneau · Lamona>"
  },
  RelicConfig_71196_BattleDesc = {
    Text = "Au début du tour, Lotan obtient [Arg1] points d'aliemus. Après avoir joué pour la première fois la « Défense » de Lotan chaque tour, placez [Arg2] « Lames indomptables » avec les coûts supplémentaires et le néant dans votre main."
  },
  RelicConfig_71196_Desc = {
    Text = "Au début du tour, Lotan obtient [Arg1] points d'aliemus. Après avoir joué pour la première fois la « Défense » de Lotan chaque tour, placez [Arg2] « Lames indomptables » avec les coûts supplémentaires et le néant dans votre main."
  },
  RelicConfig_71196_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Luotan>"
  },
  RelicConfig_71197_BattleDesc = {
    Text = "Au début du tour, Ramona obtient [Arg1] points de folie. Chaque fois qu'une carte de commandement de Ramona est jouée en position [Arg2], cette carte est appliquée une fois supplémentaire et Ramona obtient [Arg3] points de s-énergie."
  },
  RelicConfig_71197_Desc = {
    Text = "Au début du tour, Ramona obtient [Arg1] points de folie. Chaque fois qu'une carte de commandement de Ramona est jouée en position [Arg2], cette carte est appliquée une fois supplémentaire et Ramona obtient [Arg3] points de s-énergie."
  },
  RelicConfig_71197_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Ramona>"
  },
  RelicConfig_71230_BattleDesc = {
    Text = "Au début du tour, Leigh obtient [Arg1] Aliemus. Chaque fois qu'elle perd des PV, elle obtient [Arg2] points de Force, cumulable jusqu'à [Arg3] fois par combat. Après [Arg3] cumuls, le coût d'Arithmetica de base de «Douleur et Plaisir» est réduit de 2 et le nombre de Dommages est augmenté de 1."
  },
  RelicConfig_71230_Desc = {
    Text = "Au début du tour, Leigh obtient [Arg1] Aliemus. Chaque fois qu'elle perd des PV, elle obtient [Arg2] points de Force, cumulable jusqu'à [Arg3] fois par combat. Après [Arg3] cumuls, le coût d'Arithmetica de base de «Douleur et Plaisir» est réduit de 2 et le nombre de Dommages est augmenté de 1."
  },
  RelicConfig_71230_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Réa>"
  },
  RelicConfig_71231_BattleDesc = {
    Text = "Au début du tour, Aurita obtient [Arg1] points d'aliemus. « Division Glandulaire » inflige [Arg2] frappes de dégâts supplémentaires. Placez 1 « Division Glandulaire » dans votre main après avoir joué la « Défense » d'Aurita."
  },
  RelicConfig_71231_Desc = {
    Text = "Au début du tour, Aurita obtient [Arg1] points d'aliemus. « Division Glandulaire » inflige [Arg2] frappes de dégâts supplémentaires. Placez 1 « Division Glandulaire » dans votre main après avoir joué la « Défense » d'Aurita."
  },
  RelicConfig_71231_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Oreta>"
  },
  RelicConfig_71232_BattleDesc = {
    Text = "Au début du tour, Teinture obtient [Arg1] points de folie. Lorsque la carte de commandement de Teinture déclenche un saut, elle revient dans la main et son coût en arithmétique diminue de 1 avant d'être jouée, avec un maximum de [Arg2] fois par tour."
  },
  RelicConfig_71232_Desc = {
    Text = "Au début du tour, Teinture obtient [Arg1] points de folie. Lorsque la carte de commandement de Teinture déclenche un saut, elle revient dans la main et son coût en arithmétique diminue de 1 avant d'être jouée, avec un maximum de [Arg2] fois par tour."
  },
  RelicConfig_71232_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Tinkter>"
  },
  RelicConfig_71233_BattleDesc = {
    Text = "Au début du tour, Nautila obtient [Arg1] points d'aliemus. Après avoir libéré l'exaltation d'aliemus de Nautila, obtenez une contre-attaque et un bouclier différé équivalents à [Arg2]% du bouclier actuel. Peut être déclenché une fois par tour maximum."
  },
  RelicConfig_71233_Desc = {
    Text = "Au début du tour, Nautila obtient [Arg1] points d'Aliemus. Après avoir libéré l'« Exaltation » de Nautila, obtenez une Contre-attaque et un Bouclier de latence équivalents à [Arg2] % du Bouclier du personnage actuel. Peut être déclenché une fois par tour maximum."
  },
  RelicConfig_71233_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Nodira>"
  },
  RelicConfig_71234_BattleDesc = {
    Text = "Au début du tour, Doll-Fusion obtient [Arg1] points de folie. Après avoir libéré l'exaltation de la folie, pour chaque [Arg2] points de folie dépensés par Doll-Fusion, les autres réveilleurs obtiennent 1 point de folie."
  },
  RelicConfig_71234_Desc = {
    Text = "Au début du tour, Doll : Dissoute obtient [Arg1] points d'Aliemus. Après avoir libéré l'Exaltation de Doll : Dissoute, pour chaque [Arg2] points d'Aliemus dépensés, les autres Corps éveillés obtiennent 1 point d'Aliemus."
  },
  RelicConfig_71234_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Fusion · Dore>"
  },
  RelicConfig_71235_BattleDesc = {
    Text = "Au début du tour, Hilote obtient [Arg1] points de folie. Chaque fois qu'une carte est défaussée, Hilote gagne [Arg2] points de folie supplémentaires."
  },
  RelicConfig_71235_Desc = {
    Text = "Au début du tour, Hilote obtient [Arg1] points de folie. Chaque fois qu'une carte est défaussée, Hilote gagne [Arg2] points de folie supplémentaires."
  },
  RelicConfig_71235_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Shiro>"
  },
  RelicConfig_71236_BattleDesc = {
    Text = "Au début du tour, Daffodil obtient [Arg1] points de folie et 1 « inspiration ». Le pouvoir obtenu par « marée hétérogène » augmente de [Arg2] %. Chaque fois qu'elle est jouée, elle gagne en permanence [Arg3] % supplémentaires lors de cette exploration, jusqu'à un maximum de [Arg4] %."
  },
  RelicConfig_71236_Desc = {
    Text = "Au début du tour, Daffodil obtient [Arg1] points de folie et 1 « inspiration ». Le pouvoir obtenu par « marée hétérogène » augmente de [Arg2] %. Chaque fois qu'elle est jouée, elle gagne en permanence [Arg3] % supplémentaires lors de cette exploration, jusqu'à un maximum de [Arg4] %."
  },
  RelicConfig_71236_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Daphné>"
  },
  RelicConfig_71237_BattleDesc = {
    Text = "Au début du tour, Wanda obtient [Arg1] points de Fureur et gagne [Arg2] niveaux de « Appât Onirique ». Si c'est un Tour Ultra, placez en plus 1 carte temporaire « Épine enchaînée » et « Gardien égaré » dans la main, et faites en sorte que la prochaine carte d'instruction de Wanda ait un effet 2 fois."
  },
  RelicConfig_71237_Desc = {
    Text = "Au début du tour, Wanda obtient [Arg1] points de Fureur et gagne [Arg2] niveaux de « Appât Onirique ». Si c'est un Tour Ultra, placez en plus 1 carte temporaire « Épine enchaînée » et « Gardien égaré » dans la main, et la prochaine carte d'instruction de Wanda a un effet supplémentaire de 2 fois."
  },
  RelicConfig_71237_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Wanda>"
  },
  RelicConfig_71238_BattleDesc = {
    Text = "Au début du tour, Agrippa gagne [Arg1] points de folie. « La charité impatiente » réduit également la consommation d'arithmetica d'Agrippa de [Arg2] ce tour-ci, avec un maximum de 1 fois par tour."
  },
  RelicConfig_71238_Desc = {
    Text = "Au début du tour, Agrippa gagne [Arg1] points de folie. « La charité impatiente » réduit également la consommation d'arithmetica d'Agrippa de [Arg2] ce tour-ci, avec un maximum de 1 fois par tour."
  },
  RelicConfig_71238_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Agrippa>"
  },
  RelicConfig_71239_BattleDesc = {
    Text = "Au début du tour, « 24 » gagne [Arg1] points de fureur. Au début du tour, si « 24 » est en « personnalité dépressive », il gagne en supplément [Arg2] points de fureur ; s'il est en « personnalité maniaque », cela augmente le taux de critique temporaire et les dégâts critiques temporaires de « 24 » de [Arg2] %."
  },
  RelicConfig_71239_Desc = {
    Text = "Au début du tour, « 24 » obtient [Arg1] points de fureur. Au début du tour, si « 24 » est en « personnalité dépressive », il obtient en supplément [Arg2] points de fureur, et s'il est en « personnalité maniaque », il augmente le taux critique temporaire et les dégâts critiques temporaires de « 24 » de [Arg2]%."
  },
  RelicConfig_71239_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · «24»>"
  },
  RelicConfig_71240_BattleDesc = {
    Text = "Au début du tour, Liz gagne [Arg1] points de folie. Les cartes défaussées par « Danse vers la destruction » prennent effet une fois supplémentaire. Temps de recharge : 3 tours."
  },
  RelicConfig_71240_Desc = {
    Text = "Au début du tour, Liz gagne [Arg1] points de folie. Les cartes défaussées par « Danse vers la destruction » prennent effet une fois supplémentaire. Temps de recharge : 3 tours."
  },
  RelicConfig_71240_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Liz>"
  },
  RelicConfig_71241_BattleDesc = {
    Text = "Au début du tour, Helot-catena gagne [Arg1] points d'aliemus. Les dégâts actifs d'Helot-catena appliquent [Arg2] % de saignement. Après avoir tué un ennemi, inflige des dégâts de saignement égaux aux dégâts excédentaires aux autres ennemis."
  },
  RelicConfig_71241_Desc = {
    Text = "Au début du tour, Helot : Enchaînée gagne [Arg1] points de Fureur. Les Dégâts Directs d'Helot : Enchaînée appliquent [Arg2] % de Saignement. Après avoir tué un ennemi, inflige des dégâts de Saignement égaux aux dégâts excédentaires aux autres ennemis."
  },
  RelicConfig_71241_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Helot-catena · Shiro>"
  },
  RelicConfig_71242_BattleDesc = {
    Text = "Au début du tour, Celeste obtient [Arg1] points de Fureur. Avant la fin du tour, pour chaque Carte d'instruction de Celeste présente dans la main, 1 Tentacule attaque un ennemi et restaure [Heal:Arg2] PV."
  },
  RelicConfig_71242_Desc = {
    Text = "Au début du tour, Celeste obtient [Arg1] points de Fureur. Avant la fin du tour, pour chaque Carte d'instruction de Celeste présente dans la main, 1 Tentacule attaque un ennemi et restaure [Heal:Arg2] PV."
  },
  RelicConfig_71242_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Shiro>"
  },
  RelicConfig_71243_BattleDesc = {
    Text = "Au début du tour, Casiah reçoit [Arg1] points de folie. Pour chaque carte piochée, Casiah gagne [Arg2] points de folie. Lorsque Casiah libère l'exaltation, tous les ennemis perdent [Arg3] points de <PowerIconKeywords:puissance>."
  },
  RelicConfig_71243_Desc = {
    Text = "Au début du tour, Casiah reçoit [Arg1] points de folie. Pour chaque carte piochée, Casiah gagne [Arg2] points de folie. Lorsque Casiah libère l'exaltation, tous les ennemis perdent [Arg3] points de <PowerIconKeywords:puissance>."
  },
  RelicConfig_71243_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Cassia>"
  },
  RelicConfig_71244_BattleDesc = {
    Text = "Au début du tour, Sorel obtient [Arg1] Aliemus. Chaque fois que Sorel inflige des Dommages, la Fusion d'Embryon +[Arg2], jusqu'à un maximum de [Arg3] <plural value=\"[Arg3]\" singular=\"fois\" plural=\"fois\"> par tour. Après 10 activations, les Dégâts Finaux de Sorel augmentent de [Arg4] % pendant ce combat."
  },
  RelicConfig_71244_Desc = {
    Text = "Au début du tour, Sorel obtient [Arg1] Aliemus. Chaque fois que Sorel inflige des Dommages, la Fusion d'Embryon +[Arg2], jusqu'à un maximum de [Arg3] <plural value=\"[Arg3]\" singular=\"fois\" plural=\"fois\"> par tour. Après 10 activations, les Dégâts Finaux de Sorel augmentent de [Arg4] % pendant ce combat."
  },
  RelicConfig_71244_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Sorel>"
  },
  RelicConfig_71245_BattleDesc = {
    Text = "Au début du tour, Ogier obtient [Arg1] points d'aliemus. Après avoir joué pour la première fois « Lance perforante » ou « Frappe » d'Ogier durant le tour, les effets de bouclier et de pouvoir qu'Ogier génère durant ce tour augmentent de [Arg2] %."
  },
  RelicConfig_71245_Desc = {
    Text = "Au début du tour, Ogier obtient [Arg1] points d'aliemus. Après avoir joué pour la première fois « Lance perforante » ou « Frappe » d'Ogier durant le tour, les effets de bouclier et de pouvoir qu'Ogier génère durant ce tour augmentent de [Arg2] %."
  },
  RelicConfig_71245_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Ogier>"
  },
  RelicConfig_71246_BattleDesc = {
    Text = "Au début du tour, Alva obtient [Arg1] points de fureur. Lorsque Alva joue la [Arg2]ème « Défense » dans un tour, placez 1 « Cœur acéré » avec consommation dans votre main ; lorsque vous jouez la [Arg3]ème « Attaque », placez 1 « Position de combat » avec consommation dans votre main."
  },
  RelicConfig_71246_Desc = {
    Text = "Au début du tour, Alva obtient [Arg1] points de fureur. Lorsque Alva joue la [Arg2]ème « Défense » dans un tour, placez 1 « Cœur acéré » avec épuisement dans votre main ; lorsque vous jouez la [Arg3]ème « Attaque », placez 1 « Position de combat » avec épuisement dans votre main."
  },
  RelicConfig_71246_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Elva>"
  },
  RelicConfig_71247_BattleDesc = {
    Text = "Au début du tour, Jenkins reçoit [Arg1] points de folie, les dégâts finaux augmentent de [Arg2] %. Les dégâts de base ainsi que les dégâts infligés par « Marron, attaque ! » augmentent de [Arg3] %."
  },
  RelicConfig_71247_Desc = {
    Text = "Au début du tour, Jenkins reçoit [Arg1] points de folie, les dégâts finaux augmentent de [Arg2] %. Les dégâts de base ainsi que les dégâts infligés par « Marron, attaque ! » augmentent de [Arg3] %."
  },
  RelicConfig_71247_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Jenkin>"
  },
  RelicConfig_71248_BattleDesc = {
    Text = "Au début du tour, Poupée obtient [Arg1] points d'aliemus. Lorsque la bataille commence, le coût en arithmétique de « Échange Équivalent » de Poupée devient 0. Après avoir été jouée, elle permet de piocher [Arg2] cartes supplémentaires au tour suivant."
  },
  RelicConfig_71248_Desc = {
    Text = "Au début du tour, Poupée obtient [Arg1] points d'aliemus. Lorsque la bataille commence, le coût en arithmétique de « Échange Équivalent » de Poupée devient 0. Après avoir été jouée, elle permet de piocher [Arg2] cartes supplémentaires au tour suivant."
  },
  RelicConfig_71248_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Dore>"
  },
  RelicConfig_71249_BattleDesc = {
    Text = "Au début du tour, Ryker obtient [Arg1] points de Fureur. La première fois chaque tour, le résultat du dé est toujours au maximum."
  },
  RelicConfig_71249_Desc = {
    Text = "Au début du tour, Ryker obtient [Arg1] points de Fureur. La première fois chaque tour, le résultat du dé est toujours au maximum."
  },
  RelicConfig_71249_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Lake>"
  },
  RelicConfig_71250_BattleDesc = {
    Text = "Au début du tour, Miryam reçoit [Arg1] point(s) de folie et pioche une carte « Sacre »."
  },
  RelicConfig_71250_Desc = {
    Text = "Au début du tour, Miryam reçoit [Arg1] point(s) de folie et pioche une carte « Sacre »."
  },
  RelicConfig_71250_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Myriam>"
  },
  RelicConfig_71251_BattleDesc = {
    Text = "Au début du tour, Bigorneau obtient [Arg1] points de folie. Chaque fois qu'un autre réveilleur libère une exaltation de la folie, Bigorneau reçoit [Arg2] points de folie supplémentaires et la consommation en arithmétique de « Reconstruction mentale » en main est réduite de [Arg3]."
  },
  RelicConfig_71251_Desc = {
    Text = "Au début du tour, Bigorneau obtient [Arg1] points de folie. Chaque fois qu'un autre réveilleur libère une exaltation de la folie, Bigorneau reçoit [Arg2] points de folie supplémentaires et la consommation en arithmétique de « Reconstruction mentale » en main est réduite de [Arg3]."
  },
  RelicConfig_71251_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Winkell>"
  },
  RelicConfig_71252_BattleDesc = {
    Text = "Au début du tour, Tulu gagne [Arg1] points de Fureur. L'Aliemus de base de Tulu est réduit de [Arg2], et après avoir libéré une Exaltation, [Arg3] Tentacules Temporaires sont générés immédiatement."
  },
  RelicConfig_71252_Desc = {
    Text = "Au début du tour, Tulu gagne [Arg1] points de Fureur. L'Aliemus de base de Tulu est réduit de [Arg2], et après avoir libéré une Exaltation, [Arg3] Tentacules Temporaires sont générés immédiatement."
  },
  RelicConfig_71252_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Turu>"
  },
  RelicConfig_71253_BattleDesc = {
    Text = "Au début du tour, Évanouissement obtient [Arg1] points de folie. Les boucliers, les contre-attaques et la régénération de PV d'Évanouissement augmentent de [Arg2] %, chaque déclenchement de la résistance à la mort augmente cet effet de [Arg3] % pendant cette exploration, avec un maximum de [Arg4] effets."
  },
  RelicConfig_71253_Desc = {
    Text = "Au début du tour, Faint obtient [Arg1] points de fureur. Le bouclier, la contre-attaque et la régénération de PV infligés par Faint augmentent de [Arg2] %, chaque déclenchement de la résistance à la mort augmente cet effet de [Arg3] % pendant cette exploration, jusqu'à un maximum de [Arg4] fois."
  },
  RelicConfig_71253_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Fient>"
  },
  RelicConfig_71254_BattleDesc = {
    Text = "Au début du tour, Tawil obtient [Arg1] points d'aliemus. Si [Arg2] cartes de commandement de Tawil sont jouées au cours d'un même tour, ajoutez 1 carte <DerivativeCardKeywords_67:\"Clé d'Aube Argentée\"> à la main. Temps de recharge : [Arg3] tours."
  },
  RelicConfig_71254_Desc = {
    Text = "Au début du tour, Tawil obtient [Arg1] points d'aliemus. Si [Arg2] cartes de commandement de Tawil sont jouées au cours d'un même tour, ajoutez 1 carte <DerivativeCardKeywords_67:\"Clé d'Aube Argentée\"> à la main. Temps de recharge : [Arg3] tours."
  },
  RelicConfig_71254_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Tavi>"
  },
  RelicConfig_71255_BattleDesc = {
    Text = "Au début du tour, Hamelin obtient [Arg1] Aliemus. Le coût d'Arithmetica de base de «Prélude de l'âme» est réduit de [Arg2] et le nombre de Dommages de base est augmenté de [Arg3]."
  },
  RelicConfig_71255_Desc = {
    Text = "Au début du tour, Hamelin obtient [Arg1] Aliemus. Le coût d'Arithmetica de base de «Prélude de l'âme» est réduit de [Arg2] et le nombre de Dommages de base est augmenté de [Arg3]."
  },
  RelicConfig_71255_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Hamelin>"
  },
  RelicConfig_71256_BattleDesc = {
    Text = "Au début du tour, Horla gagne [Arg1] points de folie. Au début de la bataille, obtenez [Arg2] couches de métaphores pour toutes les émotions, l'effet des « métaphores » augmente de 50 %."
  },
  RelicConfig_71256_Desc = {
    Text = "Au début du tour, Horla gagne [Arg1] points de folie. Au début de la bataille, obtenez [Arg2] couches de métaphores pour toutes les émotions, l'effet des « métaphores » augmente de 50 %."
  },
  RelicConfig_71256_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Horla>"
  },
  RelicConfig_71257_BattleDesc = {
    Text = "Au début du tour, Murphy obtient [Arg1] points de folie. L'« attaque » et la « défense » de Murphy peuvent convertir [Arg2] % du « sacrifice » en dégâts de tentacule temporaires, mais cet effet ne peut se déclencher qu'une seule fois par tour."
  },
  RelicConfig_71257_Desc = {
    Text = "Au début du tour, Murphy obtient [Arg1] points de folie. L'« attaque » et la « défense » de Murphy peuvent convertir [Arg2] % du « sacrifice » en dégâts de tentacule temporaires, mais cet effet ne peut se déclencher qu'une seule fois par tour."
  },
  RelicConfig_71257_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Murphy>"
  },
  RelicConfig_71258_BattleDesc = {
    Text = "Au début du tour, Uvhash gagne [Arg1] points de Fureur. L'Aliemus de base d'Uvhash est réduit de [Arg2], et chaque Exaltation libérée le réduit en plus de 5 points, pouvant libérer [Arg3] <plural value=\"[Arg3]\" singular=\"Exaltation\" plural=\"Exaltations\"> par tour."
  },
  RelicConfig_71258_Desc = {
    Text = "Au début du tour, Uvhash gagne [Arg1] points de Fureur. L'Aliemus de base d'Uvhash est réduit de [Arg2], et chaque Exaltation libérée le réduit en plus de 5 points, pouvant libérer [Arg3] <plural value=\"[Arg3]\" singular=\"Exaltation\" plural=\"Exaltations\"> par tour."
  },
  RelicConfig_71258_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Uwahachi>"
  },
  RelicConfig_71259_BattleDesc = {
    Text = "Au début du tour, Aigis obtient [Arg1] points de folie. Lorsqu'Aigis inflige des dégâts à un ennemi vulnérable, elle lui vole également [Arg2] points de pouvoir temporaire, effet maximum [Arg3] fois par tour."
  },
  RelicConfig_71259_Desc = {
    Text = "Au début du tour, Aigis obtient [Arg1] points de folie. Lorsqu'Aigis inflige des dégâts à un ennemi vulnérable, elle lui vole également [Arg2] points de pouvoir temporaire, effet maximum [Arg3] fois par tour."
  },
  RelicConfig_71259_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Aijisi>"
  },
  RelicConfig_71260_BattleDesc = {
    Text = "Au début du tour, Thais obtient [Arg1] points de folie. Lorsque Thais joue [Arg2] cartes de commandement pendant un même tour, elle obtient 1 carte « Fils de la sainteté » et [Arg3] points de puissance temporaire. Temps de recharge : [Arg4] tours."
  },
  RelicConfig_71260_Desc = {
    Text = "Au début du tour, Thais obtient [Arg1] points de folie. Lorsque Thais joue [Arg2] cartes de commandement pendant un même tour, elle obtient 1 carte « Fils de la sainteté » et [Arg3] points de puissance temporaire. Temps de recharge : [Arg4] tours."
  },
  RelicConfig_71260_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Pickman>"
  },
  RelicConfig_71261_BattleDesc = {
    Text = "Au début du tour, Faros obtient [Arg1] points d'aliemus. Tous les 2 dégâts de tentacule infligés, le poison et le bouclier causés par Faros pendant ce combat augmentent de [Arg2] %, jusqu'à un maximum de 50 %."
  },
  RelicConfig_71261_Desc = {
    Text = "Au début du tour, Faros obtient [Arg1] points d'aliemus. Tous les 2 dégâts de tentacule infligés, le poison et le bouclier causés par Faros pendant ce combat augmentent de [Arg2] %, jusqu'à un maximum de 50 %."
  },
  RelicConfig_71261_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Falo>"
  },
  RelicConfig_71262_BattleDesc = {
    Text = "Au début du tour, Pandia obtient [Arg1] points de folie. Après avoir libéré l'exaltation, Pandia gagne un <RetaliateIconKeywords:contre-attaque> permanent équivalent à [Arg2]% du <RetaliateIconKeywords:contre-attaque> temporaire."
  },
  RelicConfig_71262_Desc = {
    Text = "Au début du tour, Pandia obtient [Arg1] points de folie. Après avoir libéré l'exaltation, Pandia gagne un <RetaliateIconKeywords:contre-attaque> permanent équivalent à [Arg2]% du <RetaliateIconKeywords:contre-attaque> temporaire."
  },
  RelicConfig_71262_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Pandia>"
  },
  RelicConfig_71263_BattleDesc = {
    Text = "Au début du tour, Lily gagne [Arg1] Aliemus. La limite d'Endurer de Lily augmente de 100%. Lorsqu'elle déclenche \"Fleur sur la vase\" ou \"Frapper pour protéger\", elle récupère 8% de Vie des piles \"Endurer\"."
  },
  RelicConfig_71263_Desc = {
    Text = "Au début du tour, Lily gagne [Arg1] Aliemus. La limite d'Endurer de Lily augmente de 100%. Lorsqu'elle déclenche \"Fleur sur la vase\" ou \"Frapper pour protéger\", elle récupère 8% de Vie des piles \"Endurer\"."
  },
  RelicConfig_71263_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Lili>"
  },
  RelicConfig_71264_BattleDesc = {
    Text = "Au début du tour, Karen gagne [Arg1] points d'aliemus. Jouer « Veille silencieuse » rembourse le double de sa consommation en arithmétique, avec un temps de recharge de [Arg2] tours."
  },
  RelicConfig_71264_Desc = {
    Text = "Au début du tour, Karen gagne [Arg1] points d'aliemus. Jouer « Veille silencieuse » rembourse le double de sa consommation en arithmétique, avec un temps de recharge de [Arg2] tours."
  },
  RelicConfig_71264_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Karen>"
  },
  RelicConfig_71265_BattleDesc = {
    Text = "Au début du tour, Salvador obtient [Arg1] points de fureur. Chaque fois que vous accumulez de la Forge Écarlate, vous obtenez également [Arg2]% de Force. Les « Attaque » et « Souffrance à dissiper » de Salvador bénéficient d'un bonus de Force supplémentaire de [Arg3] fois."
  },
  RelicConfig_71265_Desc = {
    Text = "Au début du tour, Salvador gagne [Arg1] points de fureur. Chaque fois que vous accumulez de la Forge Écarlate, vous gagnez également [Arg2]% de Force. Les « Attaque » et « Souffrance à dissiper » de Salvador bénéficient d'un bonus de force supplémentaire de [Arg3] fois."
  },
  RelicConfig_71265_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Salvador>"
  },
  RelicConfig_71266_BattleDesc = {
    Text = "Au début du tour, Caecus gagne [Arg1] points d'aliemus. Lorsque Caecus obtient un bouclier, récupère [Arg2] % des PV absorbés par le bouclier."
  },
  RelicConfig_71266_Desc = {
    Text = "Au début du tour, Caecus gagne [Arg1] points d'aliemus. Lorsque Caecus obtient un bouclier, récupère [Arg2] % des PV absorbés par le bouclier."
  },
  RelicConfig_71266_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Kethès>"
  },
  RelicConfig_71267_BattleDesc = {
    Text = "Au début du tour, Nymphaea obtient [Arg1] points de fureur. Après avoir joué l'« Attaque » de Nymphaea, augmentez de [Arg2]% le poison infligé par « Nymphaea » pendant ce combat, et après avoir joué la « Défense » de Nymphaea, déclenchez [Arg3]% de poison sur tous les ennemis. Chaque effet ne peut se déclencher qu'une seule fois par tour."
  },
  RelicConfig_71267_Desc = {
    Text = "Au début du tour, Nymphaea obtient [Arg1] points de fureur. Après avoir joué l'« Attaque » de Nymphaea, le poison infligé par « Nymphaea » dans ce combat augmente de [Arg2] %, et après avoir joué la « Défense » de Nymphaea, appliquez [Arg3] % de poison à tous les ennemis. Chaque effet ne peut se déclencher qu'une seule fois par tour."
  },
  RelicConfig_71267_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Ningphia>"
  },
  RelicConfig_71268_BattleDesc = {
    Text = "Au début du tour, Erica obtient [Arg1] points de folie. Lorsque Erica joue [Arg2] cartes de commandement en 1 tour, elle obtient 2 points d'arithmétique et fait bénéficier « Explosion électromagnétique » d'un bonus supplémentaire de puissance et de vigilance pendant cette bataille."
  },
  RelicConfig_71268_Desc = {
    Text = "Au début du tour, Erica obtient [Arg1] points de folie. Lorsque Erica joue [Arg2] cartes de commandement en 1 tour, elle obtient 2 points d'arithmétique et fait bénéficier « Explosion électromagnétique » d'un bonus supplémentaire de puissance et de vigilance pendant cette bataille."
  },
  RelicConfig_71268_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Érika>"
  },
  RelicConfig_71269_BattleDesc = {
    Text = "Au début du tour, Goliath obtient [Arg1] points d'aliemus. Si Goliath inflige [Arg2] dégâts en un seul tour, les dégâts qu'il inflige bénéficient d'un bonus de puissance supplémentaire de 1 fois pendant ce combat, avec un temps de recharge de 3 tours."
  },
  RelicConfig_71269_Desc = {
    Text = "Au début du tour, Goliath obtient [Arg1] points d'aliemus. Si Goliath inflige [Arg2] dégâts en un seul tour, les dégâts qu'il inflige bénéficient d'un bonus de puissance supplémentaire de 1 fois pendant ce combat, avec un temps de recharge de 3 tours."
  },
  RelicConfig_71269_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Goliath>"
  },
  RelicConfig_71270_BattleDesc = {
    Text = "Au début du tour, Shan obtient [Arg1] points de folie. Au début de la bataille, appliquez les effets « réservé » et « préparé 1 » sur toutes les cartes de commandement de Shan et faites-lui obtenir [Arg2] points de bouclier."
  },
  RelicConfig_71270_Desc = {
    Text = "Au début du tour, Shan obtient [Arg1] points de folie. Au début de la bataille, appliquez les effets « réservé » et « préparé 1 » sur toutes les cartes de commandement de Shan et faites-lui obtenir [Arg2] points de bouclier."
  },
  RelicConfig_71270_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Shan>"
  },
  RelicConfig_71662_BattleDesc = {
    Text = "Au début des tours pairs, placez 1 carte <DerivativeCardKeywords_105:« Trésor infini de noyaux d'argent »> dans votre main."
  },
  RelicConfig_71662_Desc = {
    Text = "Au début des tours pairs, placez 1 carte <DerivativeCardKeywords_105:« Trésor infini de noyaux d'argent »> dans votre main."
  },
  RelicConfig_71662_Name = {
    Text = "<OrangeQuality:Le Trésor du Chat>"
  },
  RelicConfig_72226_BattleDesc = {
    Text = "Limite de cartes en main +1. Au début du tour, si aucune recherche n'a été effectuée, choisissez une recherche non encore réalisée, après avoir complété la recherche, obtenez le résultat de recherche correspondant à Doll : Dissoute. Après avoir complété 3 recherches, placez « Fin du Néant » dans votre main, cette relique devient inactive."
  },
  RelicConfig_72226_Desc = {
    Text = "Limite de cartes à main +1. Au début du tour, si aucune recherche n'a été effectuée, choisissez une recherche non réalisée, après l'avoir complétée, obtenez le résultat correspondant de la recherche de Doll : Dissoute. Après avoir complété 3 recherches, placez « Fin du Néant » dans votre main, cette relique devient invalide."
  },
  RelicConfig_72226_Name = {
    Text = "Manuscrit de recherche sur l'Apocalypse"
  },
  RelicConfig_74832_BattleDesc = {
    Text = "Limite de cartes en main +1. Au début du tour, obtenez une carte personnalisée « Commerce Interdit », jouer « Commerce Interdit » permettra de le déclencher à nouveau au tour suivant. Jouer des « Cartes d'instruction » de différents types tout en ayant « Commerce Interdit » en main améliorera l'effet correspondant."
  },
  RelicConfig_74832_Desc = {
    Text = "Limite de cartes en main +1. Au début du tour, obtenez une carte personnalisée « Commerce Interdit », jouez « Commerce Interdit » pour pouvoir le déclencher à nouveau au tour suivant. Lorsque vous avez « Commerce Interdit » en main, jouer des cartes d'instruction de différents types améliorera les effets correspondants."
  },
  RelicConfig_74832_Name = {
    Text = "Invitation des mille visages"
  },
  RelicConfig_74832_StoryDesc = {
    Text = "Les mots sur la lettre changent sans cesse, se transformant toujours en un désir irréfusable."
  },
  RelicConfig_78664_BattleDesc = {
    Text = "Après avoir joué 4 cartes de commandement appartenant à différents réveilleurs au cours d'un même tour, les dégâts finaux infligés par tous les réveilleurs pendant ce tour augmentent de [Arg1] %, mais ils perdent [Arg2] points de folie, effet déclenchable une seule fois par tour."
  },
  RelicConfig_78664_Desc = {
    Text = "Après avoir joué 4 cartes de commandement appartenant à différents réveilleurs au cours d'un même tour, les dégâts finaux infligés par tous les réveilleurs pendant ce tour augmentent de [Arg1] %, mais ils perdent [Arg2] points de folie, effet déclenchable une seule fois par tour."
  },
  RelicConfig_78664_Name = {
    Text = "<RedQuality:Griffe étrange>"
  },
  RelicConfig_78664_StoryDesc = {
    Text = "Espèce indéfinissable"
  },
  RelicConfig_78665_BattleDesc = {
    Text = "Au début du tour, piochez [Arg1] carte(s) en moins. Obtenez 1 point d'arithmétique en jouant une carte dont le coût en arithmétique réel est supérieur ou égal à [Arg2], maximum [Arg3] fois par tour."
  },
  RelicConfig_78665_Desc = {
    Text = "Au début du tour, piochez [Arg1] carte(s) en moins. Obtenez 1 point d'arithmétique en jouant une carte dont le coût en arithmétique réel est supérieur ou égal à [Arg2], maximum [Arg3] fois par tour."
  },
  RelicConfig_78665_Name = {
    Text = "<RedQuality:Cloche de lamentation>"
  },
  RelicConfig_78665_StoryDesc = {
    Text = [[
Ding ling, ding ling, l'enfant pleure ;
Ding ling, ding ling, l'enfant crie.
Ding ling, ding ling, l'enfant hurle ;
Ding ling, ding ling, il a faim, tu le sais]]
  },
  RelicConfig_78666_BattleDesc = {
    Text = "Au début du tour, obtenez [Arg1] points de <RetaliateIconKeywords:comptoir>. Après avoir libéré [Arg2] fois l'exaltation en un tour, retirez [Arg3]% de comptoir permanent et recevez [Arg4]% du montant retiré en comptoir temporaire, temps de recharge de [Arg5] tours."
  },
  RelicConfig_78666_Desc = {
    Text = "Au début du tour, obtenez [Arg1] points de <RetaliateIconKeywords:comptoir>. Après avoir libéré [Arg2] fois l'exaltation en un tour, retirez [Arg3]% de comptoir permanent et recevez [Arg4]% du montant retiré en comptoir temporaire, temps de recharge de [Arg5] tours."
  },
  RelicConfig_78666_Name = {
    Text = "<RedQuality:Cadavre du chemin>"
  },
  RelicConfig_78666_StoryDesc = {
    Text = "Une partie sacrée.\nMême séparée du tronc, ses traces sont partout"
  },
  RelicConfig_78667_BattleDesc = {
    Text = "Après la phase de pioche, piochez [Arg1] cartes supplémentaires et défaussez [Arg2] cartes de votre main."
  },
  RelicConfig_78667_Desc = {
    Text = "Après la phase de pioche, piochez [Arg1] cartes supplémentaires et défaussez [Arg2] cartes de votre main."
  },
  RelicConfig_78667_Name = {
    Text = "<RedQuality:chapeau magique>"
  },
  RelicConfig_78667_StoryDesc = {
    Text = "Bienvenue au cirque féérique de mademoiselle Casiah ! Attention, ne touchez pas aux accessoires de magie sans y réfléchir. Si vous vous faites mordre par inadvertance, cela pourrait être catastrophique. \n Après tout, la dernière fois qu'il a goûté au sang, les conséquences étaient vraiment horribles. \n\n Le haut-de-forme cligna des yeux, comme s'il allait éclore à tout moment."
  },
  RelicConfig_78668_BattleDesc = {
    Text = "Après avoir utilisé l'Éveil des Fragments de clé, choisissez [Arg1] Carte d'instruction non dérivée correspondant à cet Corps éveillé dans votre main. Épuisez cette carte pour placer [Arg2] Copie de base de celle-ci dans la Pioche, la main et la Pile de Défausse respectivement."
  },
  RelicConfig_78668_Desc = {
    Text = "Après avoir utilisé l'Éveil des Fragments de clé, choisissez [Arg1] Carte d'instruction non dérivée correspondant à cet Corps éveillé dans votre main. Épuisez cette carte pour placer [Arg2] Copie de base de celle-ci dans la Pioche, la main et la Pile de Défausse respectivement."
  },
  RelicConfig_78668_Name = {
    Text = "<RedQuality:Impression de jade>"
  },
  RelicConfig_78668_StoryDesc = {
    Text = "Cette empreinte est immortelle depuis des millénaires"
  },
  RelicConfig_78669_BattleDesc = {
    Text = "Au début du combat, obtenez [Arg1] points de force. Au début de chaque tour, pour chaque [Arg2] points de force permanente, obtenez [Arg3] points de force temporaire, jusqu'à un maximum de [Arg4] points de force temporaire, et à la fin du tour, perdez la moitié du bouclier obtenu par cette relique de force temporaire."
  },
  RelicConfig_78669_Desc = {
    Text = "Au début du combat, obtenez [Arg1] points de force. Au début du tour, pour chaque [Arg2] points de force permanente, gagnez [Arg3] points de force temporaire, jusqu'à un maximum de [Arg4] points de force temporaire, et à la fin du tour, perdez la moitié du bouclier obtenu grâce à cette relique."
  },
  RelicConfig_78669_Name = {
    Text = "<RedQuality:Oiseau du rituel funeste>"
  },
  RelicConfig_78669_StoryDesc = {
    Text = "Un cadavre desséché émet un cri"
  },
  RelicConfig_78670_BattleDesc = {
    Text = "Tous les éveillés voient leurs dégâts de base augmenter de [Arg1] %, et de [Arg2] % supplémentaires à chaque réinitialisation du deck, mais 1 carte « titubation » est placée dans la main. L'augmentation maximale est de [Arg3] %."
  },
  RelicConfig_78670_Desc = {
    Text = "Tous les éveillés voient leurs dégâts de base augmenter de [Arg1] %, et de [Arg2] % supplémentaires à chaque réinitialisation du deck, mais 1 carte « titubation » est placée dans la main. L'augmentation maximale est de [Arg3] %."
  },
  RelicConfig_78670_Name = {
    Text = "<RedQuality:bougie noire>"
  },
  RelicConfig_78670_StoryDesc = {
    Text = "Brûler la lucidité, sombrer dans l'illusion"
  },
  RelicConfig_78671_BattleDesc = {
    Text = "Au début du tour, la Fusion d'Embryon +[Arg1]. Les cartes « Embryon » seront défaussées à la fin du tour."
  },
  RelicConfig_78671_Desc = {
    Text = "Au début du tour, la Fusion d'Embryon +[Arg1]. Les cartes « Embryon » seront défaussées à la fin du tour."
  },
  RelicConfig_78671_Name = {
    Text = "<RedQuality:Cordon ombilical rampant>"
  },
  RelicConfig_78671_StoryDesc = {
    Text = "Enroulement autour du cou"
  },
  RelicConfig_78672_BattleDesc = {
    Text = "Au début du tour, subissez [Arg2] couches de poison. Pour chaque emplacement vide dans l'espace dimensionnel, gagnez [Arg1] points de force."
  },
  RelicConfig_78672_Desc = {
    Text = "Au début du tour, subissez [Arg2] couches de poison. Pour chaque emplacement vide dans l'espace dimensionnel, gagnez [Arg1] points de force."
  },
  RelicConfig_78672_Name = {
    Text = "<RedQuality:Conscience de l'essaim>"
  },
  RelicConfig_78672_StoryDesc = {
    Text = "Enroulement, symbiose, agrégation ; peur, inconnu, contrôle"
  },
  RelicConfig_78673_BattleDesc = {
    Text = "Utiliser l'Éveil de la clé d'argent, dépenser [Arg1] points de s-énergie supplémentaires, faire en sorte que les cartes de réveil obtenues aient un coût en arithmetica réduit à 0, après avoir été jouées, le réveilleur correspondant reçoit [Arg2] points de folie supplémentaires."
  },
  RelicConfig_78673_Desc = {
    Text = "Utiliser l'Éveil de la clé d'argent, dépenser [Arg1] points de s-énergie supplémentaires, faire en sorte que les cartes de réveil obtenues aient un coût en arithmetica réduit à 0, après avoir été jouées, le réveilleur correspondant reçoit [Arg2] points de folie supplémentaires."
  },
  RelicConfig_78673_Name = {
    Text = "<RedQuality:Gravure de conscience>"
  },
  RelicConfig_78673_StoryDesc = {
    Text = "Une ancienne tribu croyait fermement que graver des symboles spéciaux sur le crâne des morts pouvait retenir leur âme pour une compagnie éternelle"
  },
  RelicConfig_78674_BattleDesc = {
    Text = "Au début du combat, infligez [Arg1] couches de poison à tous les ennemis. Au début du tour, retirez [Arg2] % du poison de l'ennemi et appliquez-lui un saignement équivalent à [Arg3] % de la quantité retirée."
  },
  RelicConfig_78674_Desc = {
    Text = "Au début du combat, infligez [Arg1] couches de poison à tous les ennemis. Au début du tour, retirez [Arg2] % du poison de l'ennemi et appliquez-lui un saignement équivalent à [Arg3] % de la quantité retirée."
  },
  RelicConfig_78674_Name = {
    Text = "<RedQuality:Membre de secours>"
  },
  RelicConfig_78674_StoryDesc = {
    Text = "Une partie sacrée.\nMême séparée du tronc, elle conserve sa chaleur"
  },
  RelicConfig_78675_BattleDesc = {
    Text = "Au début du tour, si vous avez plus de [Arg1] tentacules permanents, perdez [Arg2] tentacules pour obtenir [Arg3] tentacules temporaires, sinon obtenez [Arg4] tentacules permanents."
  },
  RelicConfig_78675_Desc = {
    Text = "Au début du tour, si vous avez plus de [Arg1] tentacules permanents, perdez [Arg2] tentacules pour obtenir [Arg3] tentacules temporaires, sinon obtenez [Arg4] tentacules permanents."
  },
  RelicConfig_78675_Name = {
    Text = "<RedQuality:Bras sacré de douleur>"
  },
  RelicConfig_78675_StoryDesc = {
    Text = "Savoure la souffrance"
  },
  RelicConfig_79408_BattleDesc = {
    Text = "Limite de cartes à main +2, nombre de cartes piochées +2. « Souvenirs Clairs » commence avec 5 niveaux, jouer des cartes marquées fera changer « Souvenirs Clairs ». Lorsque « Souvenirs Clairs » est inférieur à 5, pour chaque point en dessous, les dégâts finaux augmentent de 10 %, et le bouclier ainsi que la réponse de vie diminuent de 5 % ; lorsque « Souvenirs Clairs » est supérieur à 5, pour chaque point au-dessus, le bouclier et la réponse de vie augmentent de 5 %, et les dégâts finaux diminuent de 10 %."
  },
  RelicConfig_79408_Desc = {
    Text = "Limite Max de la Main + 2, Piocher +2. « Souvenirs Clairs » commence avec 5 niveaux, jouer des cartes marquées modifiera « Souvenirs Clairs ». Lorsque « Souvenirs Clairs » est inférieur à 5, pour chaque point en dessous, les Dégâts Finaux augmentent de 10 %, et le Bouclier et la Réponse de PV diminuent de 5 % ; lorsque « Souvenirs Clairs » est supérieur à 5, pour chaque point au-dessus, le Bouclier et la Réponse de PV augmentent de 5 %, et les Dégâts Finaux diminuent de 10 %."
  },
  RelicConfig_79408_Name = {
    Text = "«Mémoire» et «Rêve»"
  },
  RelicConfig_79408_StoryDesc = {
    Text = "« Viens, écoute-moi. »\n« Laisse-moi transformer tes souvenirs et tes rêves. »\n« En un dessert incroyablement délicieux. »"
  },
  RelicConfig_80340_BattleDesc = {
    Text = "Au début du tour, Clémentine obtient [Arg1] points de folie. Le nombre d'utilisations des effets de dégâts, bouclier, régénération de PV, obtention de folie et obtention d'énergie clé en argent de toutes les cartes de commandement de Clémentine est augmenté de 1."
  },
  RelicConfig_80340_Desc = {
    Text = "Au début du tour, Clémentine obtient [Arg1] points de folie. Le nombre d'utilisations des effets de dégâts, bouclier, régénération de PV, obtention de folie et obtention d'énergie clé en argent de toutes les cartes de commandement de Clémentine est augmenté de 1."
  },
  RelicConfig_80340_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Clémentine>"
  },
  RelicConfig_83509_BattleDesc = {
    Text = "Au début de l'exploration, le plafond des créations augmente de +1, les réveilleurs du domaine « Fond marin » obtiennent leurs « images dimensionnelles ». Pour chaque réveilleur du domaine « Fond marin » présent dans l'équipe, le plafond des créations augmente de +1."
  },
  RelicConfig_83509_Desc = {
    Text = "Au début de l'exploration, le plafond des créations augmente de +1, les réveilleurs du domaine « Fond marin » obtiennent leurs « images dimensionnelles ». Pour chaque réveilleur du domaine « Fond marin » présent dans l'équipe, le plafond des créations augmente de +1."
  },
  RelicConfig_83509_Name = {
    Text = "<OrangeQuality:«Anneau des profondeurs marines»>"
  },
  RelicConfig_83509_StoryDesc = {
    Text = "Les dormeurs dans l'océan abyssal commencent à montrer l'autorité oubliée au monde."
  },
  RelicConfig_83510_BattleDesc = {
    Text = "Au début de l'exploration, le plafond des créations augmente de +1, les réveilleurs du domaine « chair » obtiennent leurs « images dimensionnelles ». Pour chaque réveilleur du domaine « chair » présent dans l'équipe, le plafond des créations augmente de +1."
  },
  RelicConfig_83510_Desc = {
    Text = "Au début de l'exploration, le plafond des créations augmente de +1, les réveilleurs du domaine « chair » obtiennent leurs « images dimensionnelles ». Pour chaque réveilleur du domaine « chair » présent dans l'équipe, le plafond des créations augmente de +1."
  },
  RelicConfig_83510_Name = {
    Text = "<OrangeQuality:«Roue de chair et de sang»>"
  },
  RelicConfig_83510_StoryDesc = {
    Text = "Espoir portable"
  },
  RelicConfig_83511_BattleDesc = {
    Text = "Au début de l'exploration, le plafond des créations augmente de +1, les réveilleurs du domaine « Ultra-dimensionnel » obtiennent leurs « images dimensionnelles ». Pour chaque réveilleur du domaine « Ultra-dimensionnel » présent dans l'équipe, le plafond des créations augmente de +1."
  },
  RelicConfig_83511_Desc = {
    Text = "Au début de l'exploration, le plafond des créations augmente de +1, les réveilleurs du domaine « Ultra-dimensionnel » obtiennent leurs « images dimensionnelles ». Pour chaque réveilleur du domaine « Ultra-dimensionnel » présent dans l'équipe, le plafond des créations augmente de +1."
  },
  RelicConfig_83511_Name = {
    Text = "<OrangeQuality:«Anneau hyperdimensionnel»>"
  },
  RelicConfig_83511_StoryDesc = {
    Text = "Les dimensions infinies s'accumulent, à cet instant « Je » suis infiniment complet."
  },
  RelicConfig_83512_BattleDesc = {
    Text = "Au début de l'exploration, le plafond des créations augmente de +1, les réveilleurs du domaine « Chaos » obtiennent leurs « images dimensionnelles ». Pour chaque réveilleur du domaine « Chaos » présent dans l'équipe, le plafond des créations augmente de +1."
  },
  RelicConfig_83512_Desc = {
    Text = "Au début de l'exploration, le plafond des créations augmente de +1, les réveilleurs du domaine « Chaos » obtiennent leurs « images dimensionnelles ». Pour chaque réveilleur du domaine « Chaos » présent dans l'équipe, le plafond des créations augmente de +1."
  },
  RelicConfig_83512_Name = {
    Text = "<OrangeQuality:Anneau du Chaos>"
  },
  RelicConfig_83512_StoryDesc = {
    Text = "Le chaos est invisible, le chaos est sans substance, le chaos est devenu l'essence de tout."
  },
  RelicConfig_83606_BattleDesc = {
    Text = "Limite de cartes à main +1. Au début du tour, si vous ne possédez pas « Décision du Navigateur », placez-la dans votre main. \n Chaque fois que le chef perd 10 % de ses PV Max, obtenez 1 couche de « Lever les voiles », avec un maximum de 10 couches, « Lever les voiles » peut améliorer l'effet de « Rompre les vagues, entamer le voyage ». \n Chaque fois que vous perdez 10 % de vos PV Max, obtenez 1 couche de « Jeter l'ancre », avec un maximum de 10 couches, « Jeter l'ancre » peut améliorer l'effet de « Repos au port »."
  },
  RelicConfig_83606_Desc = {
    Text = "Limite de cartes à main +1. Au début du tour, si « Décision du Navigateur » n'est pas présente, placez-la dans votre main. \nChaque fois que le Chef perd 10% de ses PV Max initiaux, gagnez 1 couche « Lever les voiles », avec une limite de 10 couches, « Lever les voiles » peut améliorer l'effet de « Rompre les vagues, entamer le voyage ». \nChaque fois que vous perdez 10% de vos PV Max initiaux, gagnez 1 couche « Jeter l'ancre », avec une limite de 10 couches, « Jeter l'ancre » peut améliorer l'effet de « Repos au port »."
  },
  RelicConfig_83606_Name = {
    Text = "Guide d'Érasme"
  },
  RelicConfig_83606_StoryDesc = {
    Text = "L'éclat de la foudre guidera la direction à suivre."
  },
  RelicConfig_84112_BattleDesc = {
    Text = "Au début du tour, Agrippa gagne [Arg1] points de folie. « La charité impatiente » réduit également la consommation d'arithmetica d'Agrippa de [Arg2] ce tour-ci, avec un maximum de 1 fois par tour."
  },
  RelicConfig_84112_Desc = {
    Text = "Au début du tour, Agrippa gagne [Arg1] points de folie. « La charité impatiente » réduit également la consommation d'arithmetica d'Agrippa de [Arg2] ce tour-ci, avec un maximum de 1 fois par tour."
  },
  RelicConfig_84112_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Agrippa>"
  },
  RelicConfig_84113_BattleDesc = {
    Text = "Au début du tour, Caraboo gagne [Arg1] Fureur. Les cartes «Bénédiction» de Caraboo offrent 1 option supplémentaire lors d'une <FaxianKeywords:découverte>. L'Exaltation de Caraboo inflige des charges de Corrosion égales aux dégâts infligés."
  },
  RelicConfig_84113_Desc = {
    Text = "Au début du tour, Caraboo gagne [Arg1] Fureur. Les cartes «Bénédiction» de Caraboo offrent 1 option supplémentaire lors d'une <FaxianKeywords:découverte>. L'Exaltation de Caraboo inflige des charges de Corrosion égales aux dégâts infligés."
  },
  RelicConfig_84113_Name = {
    Text = "<OrangeQuality:Image Dimensionnelle : Caraboo>"
  },
  RelicConfig_84114_BattleDesc = {
    Text = "Au début du tour, Pikeman gagne [Arg1] Aliemus. Chaque fois qu'une charge d'\"Inspiration\" est gagnée, réduisez aléatoirement l'épuisement arithmetic d'une carte de la main de 1 ce tour. Quand Pikeman épuise une \"Inspiration\", tous les Réveilleurs gagnent [Arg2] points d'Aliemus."
  },
  RelicConfig_84114_Desc = {
    Text = "Au début du tour, Pikeman gagne [Arg1] Aliemus. Chaque fois qu'une charge d'\"Inspiration\" est gagnée, réduisez aléatoirement l'épuisement arithmetic d'une carte de la main de 1 ce tour. Quand Pikeman épuise une \"Inspiration\", tous les Réveilleurs gagnent [Arg2] points d'Aliemus."
  },
  RelicConfig_84114_Name = {
    Text = "<OrangeQuality:Dimension Image·Pickman>"
  },
  RelicConfig_84116_BattleDesc = {
    Text = "Au début du tour, Erica obtient [Arg1] points de folie. Lorsque Erica joue [Arg2] cartes de commandement en 1 tour, elle obtient 2 points d'arithmétique et fait bénéficier « Explosion électromagnétique » d'un bonus supplémentaire de puissance et de vigilance pendant cette bataille."
  },
  RelicConfig_84116_Desc = {
    Text = "Au début du tour, Erica obtient [Arg1] points de folie. Lorsque Erica joue [Arg2] cartes de commandement en 1 tour, elle obtient 2 points d'arithmétique et fait bénéficier « Explosion électromagnétique » d'un bonus supplémentaire de puissance et de vigilance pendant cette bataille."
  },
  RelicConfig_84116_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Érika>"
  },
  RelicConfig_84117_BattleDesc = {
    Text = "Au début du round, Murphy : fauxné obtient [Arg1] de folie. \"Spiral Waltz\" s'active 3 fois tous les 3 relâchements."
  },
  RelicConfig_84117_Desc = {
    Text = "Au début du round, Murphy : fauxné obtient [Arg1] de folie. \"Spiral Waltz\" s'active 3 fois tous les 3 relâchements."
  },
  RelicConfig_84117_Name = {
    Text = "<OrangeQuality:image dimensionnelle: murphy: faux-né>"
  },
  RelicConfig_84118_BattleDesc = {
    Text = "Au début du tour, Casiah reçoit [Arg1] points de folie. Pour chaque carte piochée, Casiah gagne [Arg2] points de folie. Lorsque Casiah libère l'exaltation, tous les ennemis perdent [Arg3] points de <PowerIconKeywords:puissance>."
  },
  RelicConfig_84118_Desc = {
    Text = "Au début du tour, Casiah reçoit [Arg1] points de folie. Pour chaque carte piochée, Casiah gagne [Arg2] points de folie. Lorsque Casiah libère l'exaltation, tous les ennemis perdent [Arg3] points de <PowerIconKeywords:puissance>."
  },
  RelicConfig_84118_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Cassia>"
  },
  RelicConfig_84119_BattleDesc = {
    Text = "Au début du tour, Murphy obtient [Arg1] points de folie. L'« attaque » et la « défense » de Murphy peuvent convertir [Arg2] % du « sacrifice » en dégâts de tentacule temporaires, mais cet effet ne peut se déclencher qu'une seule fois par tour."
  },
  RelicConfig_84119_Desc = {
    Text = "Au début du tour, Murphy obtient [Arg1] points de folie. L'« attaque » et la « défense » de Murphy peuvent convertir [Arg2] % du « sacrifice » en dégâts de tentacule temporaires, mais cet effet ne peut se déclencher qu'une seule fois par tour."
  },
  RelicConfig_84119_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Murphy>"
  },
  RelicConfig_84121_BattleDesc = {
    Text = "Au début du tour, Arachne reçoit [Arg1] Aliemus. « Attaque » et « Défense » déclenchent immédiatement la Chasse : « Pelote Éternelle » une fois, chacune prenant effet au maximum une fois par tour."
  },
  RelicConfig_84121_Desc = {
    Text = "Au début du tour, Arachne reçoit [Arg1] Aliemus. « Attaque » et « Défense » déclenchent immédiatement la Chasse : « Pelote Éternelle » une fois, chacune prenant effet au maximum une fois par tour."
  },
  RelicConfig_84121_Name = {
    Text = "<OrangeQuality:Image Dimensionnelle : Arachne>"
  },
  RelicConfig_84122_BattleDesc = {
    Text = "Au début du tour, Tulu gagne [Arg1] points d'aliemus. La consommation d'aliemus de Tulu est réduite de [Arg2] points, et [Arg3] tentacules temporaires sont générés immédiatement après avoir libéré une exaltation."
  },
  RelicConfig_84122_Desc = {
    Text = "Au début du tour, Tulu gagne [Arg1] points d'aliemus. La consommation d'aliemus de Tulu est réduite de [Arg2] points, et [Arg3] tentacules temporaires sont générés immédiatement après avoir libéré une exaltation."
  },
  RelicConfig_84122_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Turu>"
  },
  RelicConfig_84123_BattleDesc = {
    Text = "Au début du tour, Pollux gagne [Arg1] aliemus. Au début de la bataille, gagnez 1 \"Cœur Sacré\", le \"Cœur Sacré\" rendra tous les ennemis vulnérables lors de la 3ème consommation, et infligera 2 fois les dégâts."
  },
  RelicConfig_84123_Desc = {
    Text = "Au début du tour, Pollux gagne [Arg1] aliemus. Au début de la bataille, gagnez 1 \"Cœur Sacré\", le \"Cœur Sacré\" rendra tous les ennemis vulnérables lors de la 3ème consommation, et infligera 2 fois les dégâts."
  },
  RelicConfig_84123_Name = {
    Text = "<OrangeQuality:Image Dimensionnelle·Pollux>"
  },
  RelicConfig_84124_BattleDesc = {
    Text = "Au début du tour, Hameln reçoit [Arg1] points d'aliemus. La consommation en arithmétique de « Prélude de l'âme » est réduite de [Arg2], et le nombre de dégâts de base est augmenté de [Arg3]."
  },
  RelicConfig_84124_Desc = {
    Text = "Au début du tour, Hameln reçoit [Arg1] points d'aliemus. La consommation en arithmétique de « Prélude de l'âme » est réduite de [Arg2], et le nombre de dégâts de base est augmenté de [Arg3]."
  },
  RelicConfig_84124_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Hamelin>"
  },
  RelicConfig_84125_BattleDesc = {
    Text = "Au début du tour, Kadigula reçoit [Arg1] points de Fureur. Après avoir accumulé 10 charges de «Flamme vivante», piochez immédiatement 1 Carte d'instruction de Kadigula et accordez-lui 3 charges de «Flamme vivante». Cet effet n'accumulera plus de charges pour le reste de ce tour."
  },
  RelicConfig_84125_Desc = {
    Text = "Au début du tour, Kadigula reçoit [Arg1] points de Fureur. Après avoir accumulé 10 charges de «Flamme vivante», piochez immédiatement 1 Carte d'instruction de Kadigula et accordez-lui 3 charges de «Flamme vivante». Cet effet n'accumulera plus de charges pour le reste de ce tour."
  },
  RelicConfig_84125_Name = {
    Text = "<OrangeQuality:Image Dimensionnelle·Katie Gula>"
  },
  RelicConfig_84126_BattleDesc = {
    Text = "Au début du tour, Castor obtient [Arg1] points de folie. Au début de la bataille, placez 2 cartes « plume noire » dans la main. Après avoir joué une « plume noire » pour la première fois chaque tour, obtenez [Arg2] points de force temporaire."
  },
  RelicConfig_84126_Desc = {
    Text = "Au début du tour, Castor obtient [Arg1] points de folie. Au début de la bataille, placez 2 cartes « plume noire » dans la main. Après avoir joué une « plume noire » pour la première fois chaque tour, obtenez [Arg2] points de force temporaire."
  },
  RelicConfig_84126_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Castor>"
  },
  RelicConfig_84127_BattleDesc = {
    Text = "Au début du tour, Kepsante obtient [Arg1] points de folie et gagne 1 tentacule temporaire. À chaque déclenchement de la résistance à la mort, Kepsante reçoit [Arg2] points de folie et place 1 « Foudre punitive » avec un coût en arithmétique de 0 et un coût supplémentaire dans sa main."
  },
  RelicConfig_84127_Desc = {
    Text = "Au début du tour, Kepsante obtient [Arg1] points de folie et gagne 1 tentacule temporaire. À chaque déclenchement de la résistance à la mort, Kepsante reçoit [Arg2] points de folie et place 1 « Foudre punitive » avec un coût en arithmétique de 0 et un coût supplémentaire dans sa main."
  },
  RelicConfig_84127_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Kepsante>"
  },
  RelicConfig_89252_BattleDesc = {
    Text = "La limite d'Arithmetica augmente de 1, le nombre de cartes à piocher par tour augmente de 1, et au début du combat, obtenez [Arg1] couches de « Destin Enchaîné ».\nChaque couche de « Destin Enchaîné » réduit la fureur générée par tous les éveilleurs de [Arg2] %, et chaque fois que l'exaltation est libérée, une couche de « Destin Enchaîné » est réduite. Après que toutes les couches de « Destin Enchaîné » aient été supprimées, tous les éveilleurs obtiennent [Arg3] points de fureur et reçoivent « Cœur Inébranlable » : la fureur générée par tous les éveilleurs augmente de [Arg4] %, et il est possible de libérer l'exaltation 2 fois par tour."
  },
  RelicConfig_89252_Desc = {
    Text = "La limite d’Arithmetica augmente de 1, le nombre de cartes à piocher par tour augmente de 1, et au début du combat, gagnez [Arg1] niveaux de « Carcérage du Destin ».\nChaque niveau de « Carcérage du Destin » réduit la fureur générée par tous les Éveilleurs de [Arg2] %, et à chaque fois que l’exaltation est libérée, réduisez de 1 niveau de « Carcérage du Destin ». Après la suppression de tous les « Carcérages du Destin », tous les Éveilleurs gagnent [Arg3] points de fureur et obtiennent « Cœur Inébranlable » : la fureur générée par tous les Éveilleurs augmente de [Arg4] %, et ils peuvent libérer l’exaltation 2 fois par tour."
  },
  RelicConfig_89252_Name = {
    Text = "Plume maudite"
  },
  RelicConfig_89252_StoryDesc = {
    Text = "Aujourd'hui, cette plume ne peut plus s'envoler dans le ciel."
  },
  RelicConfig_89645_BattleDesc = {
    Text = "Limite Max de la Main +2, après avoir libéré l'exaltation de la folie, les Dégâts Finaux augmentent temporairement de 10 %.\nLorsque la carte entre dans l'espace hyperspatial, 1 « Embryon » dans votre main se transforme en « Fils de la sainteté ».\nChaque fois qu'un « Embryon » est généré, le coût d'Arithmetica d'une carte aléatoire dans l'espace hyperspatial est réduit de 1."
  },
  RelicConfig_89645_Desc = {
    Text = "Limite Max de la Main +2, après avoir libéré l'exaltation, les dégâts finaux augmentent temporairement de 10 %.\nAprès qu'une carte entre dans l'espace hyperspatial, 1 « embryon » dans la main se transforme en « Fils de la sainteté ».\nChaque fois qu'un « embryon » est généré, le coût d'Arithmetica d'une carte aléatoire dans l'espace hyperspatial est réduit de 1."
  },
  RelicConfig_89645_Name = {
    Text = "Préparation de sang corrompu hyperspatial"
  },
  RelicConfig_89646_BattleDesc = {
    Text = "Obtenez 250 Flamboiement de clé au début du tour.\nAprès avoir utilisé Rouse de Flamboiement de clé, placez 1 <DerivativeCardKeywords_129:\"Lueur de clé d'argent\"> dans votre main.\nDécouvrez 1 carte de soutien d'éveilleur au début du tour."
  },
  RelicConfig_89646_Desc = {
    Text = "Obtenez 250 Flamboiement de clé au début du tour.\nAprès avoir utilisé Rouse de Flamboiement de clé, placez 1 <DerivativeCardKeywords_129:\"Lueur de clé d'argent\"> dans votre main.\nDécouvrez 1 carte de soutien d'éveilleur au début du tour."
  },
  RelicConfig_89646_Name = {
    Text = "<Yellow:Raffinement de potion>"
  },
  RelicConfig_89647_BattleDesc = {
    Text = "La première carte d'instruction jouée chaque tour prend effet 1 fois supplémentaire. \n Lors de l'annihilation, générez 1 tentacule. \n Après avoir changé le tentacule en posture « Vagues Déchaînées », l'effet de saut quantique de la prochaine carte d'instruction jouée ce tour sera activé et ses 2 copies originales seront placées dans l'Espace Hyperspatial, temps de recharge de 3 tours."
  },
  RelicConfig_89647_Desc = {
    Text = "La première carte d'instruction jouée chaque tour prend effet 1 fois supplémentaire. \n Lors de l'annihilation, générez 1 tentacule. \n Après avoir changé le tentacule en posture « Vagues Déchaînées », l'effet de saut de la prochaine carte d'instruction de ce tour se déclenche obligatoirement et place 2 copies originales dans l'espace hyperspatial, temps de recharge : 3 tours."
  },
  RelicConfig_89647_Name = {
    Text = "Cordique des abysses"
  },
  RelicConfig_89648_BattleDesc = {
    Text = "La maîtrise des royaumes augmente de 200 points. \nLorsque la fournaise cramoisie est consommée, les dégâts des tentacules sont augmentés de 15 % de la quantité consommée. \nÀ chaque attaque de tentacule, accumulez [Arg3] points de la fournaise cramoisie."
  },
  RelicConfig_89648_Desc = {
    Text = "La maîtrise des royaumes augmente de 200 points. \nLorsque la fournaise cramoisie est consommée, les dégâts des tentacules sont augmentés de 15 % de la quantité consommée. \nÀ chaque attaque de tentacule, accumulez [Arg3] points de la fournaise cramoisie."
  },
  RelicConfig_89648_Name = {
    Text = "Sérum des Abysses Corrompus"
  },
  RelicConfig_91096_BattleDesc = {
    Text = "Au début du tour, les deux parties gagnent un niveau de <Kuangre:ferveur>, chaque niveau de <Kuangre:ferveur> ajoute 10 % de dégâts équivalents en <BleedingIconKeywords:saignement> aux dégâts actifs et aux dégâts de tentacule infligés. \n Chaque fois que vous infligez 20 % de la vie du chef en dégâts, tous les éveillés gagnent 10 points de folie. \n Au début du combat, mélangez <DerivativeCardKeywords_108:« Inspiration de la descendance »> et <DerivativeCardKeywords_109:« Protection des descendants »> dans la pioche."
  },
  RelicConfig_91096_Desc = {
    Text = "Au début du tour, les deux parties gagnent un niveau de <Kuangre:ferveur>, chaque niveau de <Kuangre:ferveur> ajoute 10 % de dégâts équivalents en <BleedingIconKeywords:saignement> aux dégâts actifs et aux dégâts de tentacule infligés. \n Pour chaque 20 % de dégâts infligés au chef, tous les éveillés gagnent 10 points de fureur. \n Au début du combat, mélangez <DerivativeCardKeywords_108:« Inspiration de la descendance »> et <DerivativeCardKeywords_109:« Protection des descendants »> dans la pioche."
  },
  RelicConfig_91096_Name = {Text = "Oeuf Pâle"},
  RelicConfig_91096_StoryDesc = {
    Text = "L'encouragement à la naissance du Fils pâle. \n Attention, ils arrivent bientôt."
  },
  RelicConfig_94695_BattleDesc = {
    Text = "Après qu'un Réveilleur soit tué, les autres alliés gagnent [Arg1] <StrongEffectKeywords: Fort Effet>, cet effet ne peut être déclenché qu'une fois pour chaque Réveilleur."
  },
  RelicConfig_94695_Desc = {
    Text = "Après qu'un Réveilleur soit tué, les autres alliés gagnent [Arg1] <StrongEffectKeywords: Fort Effet>, cet effet ne peut être déclenché qu'une fois pour chaque Réveilleur."
  },
  RelicConfig_94695_Name = {
    Text = "<OrangeQuality:Cendres de l'étoile noire>"
  },
  RelicConfig_94696_BattleDesc = {
    Text = "Après le début de la bataille, placez [Arg1] <PVPDerivativeCardKeywords_21:Étreinte glaçante> dans votre main."
  },
  RelicConfig_94696_Desc = {
    Text = "Après le début de la bataille, placez [Arg1] <PVPDerivativeCardKeywords_21:Étreinte glaçante> dans votre main."
  },
  RelicConfig_94696_Name = {
    Text = "<OrangeQuality:Injecteur actif>"
  },
  RelicConfig_94697_BattleDesc = {
    Text = "À la fin du tour, défaussez toute la main et piochez le nombre correspondant de cartes."
  },
  RelicConfig_94697_Desc = {
    Text = "À la fin du tour, défaussez toute la main et piochez le nombre correspondant de cartes."
  },
  RelicConfig_94697_Name = {
    Text = "<OrangeQuality:Carillon envoûtant>"
  },
  RelicConfig_94698_BattleDesc = {
    Text = "Après le début de la bataille, placez [Arg1] <PVPDerivativeCardKeywords_22:Frappez Dernier, Frappez Mieux> et <PVPDerivativeCardKeywords_23:Voix dans Votre Tête> dans la pile de pioche."
  },
  RelicConfig_94698_Desc = {
    Text = "Après le début de la bataille, placez [Arg1] <PVPDerivativeCardKeywords_22:Frappez Dernier, Frappez Mieux> et <PVPDerivativeCardKeywords_23:Voix dans Votre Tête> dans la pile de pioche."
  },
  RelicConfig_94698_Name = {
    Text = "<OrangeQuality:Artefact d'Alfonso>"
  },
  RelicConfig_95975_BattleDesc = {
    Text = "Limite de cartes à main +1. \nAu début du tour, si <DerivativeCardKeywords_111:« ingestion d'âme »> n'est pas présente, placez-la dans votre main. Si « rassasiement » atteint 10, transformez-la en <DerivativeCardKeywords_112:« résonance de mémoire »>."
  },
  RelicConfig_95975_Desc = {
    Text = "Limite de cartes en main +1. \nAu début du tour, si vous ne possédez pas « ingestion d'âme », placez cette carte dans votre main. Si « rassasiement » atteint 10, transformez-la en « résonance de mémoire »."
  },
  RelicConfig_95975_Name = {
    Text = "Calice d'Os"
  },
  RelicConfig_95975_StoryDesc = {
    Text = "«La Lune Sanglante s'élève, et tous les cadavres doivent lever leur verre pour boire ensemble.»"
  },
  RelicConfig_95976_BattleDesc = {
    Text = "Au début du tour, Dullayan gagne [Arg1] points d'aliemus et [Arg2] points de <PowerIconKeywords:pouvoir>. Lorsque Dullayan consomme des « débris », il obtient 20 % de pouvoir permanent sous forme de pouvoir temporaire."
  },
  RelicConfig_95976_Desc = {
    Text = "Au début du tour, Dullayan gagne [Arg1] points d'aliemus et [Arg2] points de <PowerIconKeywords:pouvoir>. Lorsque Dullayan consomme des « débris », il obtient 20 % de pouvoir permanent sous forme de pouvoir temporaire."
  },
  RelicConfig_95976_Name = {
    Text = "<OrangeQuality:Image dimensionnelle · Dulséane>"
  },
  RelicConfig_96652_BattleDesc = {
    Text = "Au début du tour, accordez à 1 Carte de commandement en main l'effet \"<BurningKeywords2:Brûlure>\" et accumulez 1 couche de \"<Heat:Flamme sombre>\". Une fois que \"<Heat:Flamme sombre>\" atteint 3 couches, placez une carte de \"<Overload:Brasier infini>\" dans votre main."
  },
  RelicConfig_96652_Desc = {
    Text = "Au début du tour, accordez à 1 Carte de commandement en main l'effet \"<BurningKeywords2:Brûlure>\" et accumulez 1 couche de \"<Heat:Flamme sombre>\". Une fois que \"<Heat:Flamme sombre>\" atteint 3 couches, placez une carte de \"<Overload:Brasier infini>\" dans votre main."
  },
  RelicConfig_96652_Name = {
    Text = "Flamme Obscure"
  },
  RelicConfig_96652_StoryDesc = {
    Text = "Les flammes noires réaliseront sa volonté, réduisant tout en cendres."
  },
  RelicConfig_97344_BattleDesc = {
    Text = "Perdez la dernière carte en main pour piocher 2 cartes et obtenir [Arg1] points de s-énergie. Les dégâts de tentacule augmentent de [Arg2] points après chaque réinitialisation du deck."
  },
  RelicConfig_97344_Desc = {
    Text = "Perdez la dernière carte en main pour piocher 2 cartes et obtenir [Arg1] points de s-énergie. Les dégâts de tentacule augmentent de [Arg2] après chaque réinitialisation du deck."
  },
  RelicConfig_97344_Name = {
    Text = "Couve d'or de Missaga"
  },
  RelicConfig_97344_StoryDesc = {
    Text = "Aujourd'hui, nous allons oublier la peur, oublier la douleur, et simplement profiter de la fête."
  },
  RelicConfig_97345_BattleDesc = {
    Text = "Chaque fois que vous jouez 3 cartes de commandement, obtenez 1 point d'arithmétique et tirez 1 carte. Chaque dégât actif infligé augmente les dégâts finaux temporaires de 2 %, jusqu'à un maximum de 50 %."
  },
  RelicConfig_97345_Desc = {
    Text = "Chaque fois que vous jouez 3 cartes de commandement, obtenez 1 point d'arithmétique et piochez 1 carte. Chaque dégât actif infligé augmente les dégâts finaux temporaires de 2 %, jusqu'à un maximum de 50 %."
  },
  RelicConfig_97345_Name = {
    Text = "Couve d'or de Mythag"
  },
  RelicConfig_97345_StoryDesc = {
    Text = "Aujourd'hui, nous oublierons la peur, oublierons la douleur, et ne profiterons que de la fête."
  },
  RelicConfig_97346_BattleDesc = {
    Text = "Tous les réveilleurs voient leur chance de coup critique augmenter de 30 %. Au début des tours impairs, tous les ennemis perdent 25 % de leur vie actuelle. Si votre pourcentage de vie est inférieur à celui de l'ennemi, les dégâts finaux infligés augmentent de 50 % ; si votre pourcentage de vie est supérieur à celui de l'ennemi, vous gagnez 35 points de folie après avoir utilisé une Éruption de folie."
  },
  RelicConfig_97346_Desc = {
    Text = "Tous les réveilleurs voient leur taux de coup critique augmenter de 30 %. Au début des tours impairs, tous les ennemis perdent 25 % de leur vie actuelle. Si votre proportion de vie est inférieure à celle de l'ennemi, les dégâts finaux infligés augmentent de 50 % ; si votre proportion de vie est supérieure à celle de l'ennemi, vous gagnez 35 points de folie après avoir déclenché une décharge de folie."
  },
  RelicConfig_97346_Name = {
    Text = "Couve Missaga du championnat"
  },
  RelicConfig_97346_StoryDesc = {
    Text = "Aujourd'hui, nous allons oublier la peur, oublier la douleur, et simplement profiter de la fête."
  },
  RelicConfig_97347_BattleDesc = {
    Text = "La capacité maximale augmente de 2 points, les points d'arithmétique non consommés peuvent être conservés jusqu'au tour suivant. Si plus de 2 points d'arithmétique sont conservés, tous les réveilleurs obtiennent 20 points de folie au début du tour suivant ; si plus de 4 points d'arithmétique sont conservés, les dégâts de base infligés au tour suivant augmentent de 100 %."
  },
  RelicConfig_97347_Desc = {
    Text = "Capacité maximale augmentée de 2 points, les points d'arithmétique non consommés peuvent être conservés jusqu'au prochain tour. Si plus de 2 points d'arithmétique sont conservés, tous les réveilleurs obtiennent 20 points de folie au début du prochain tour ; si plus de 4 points d'arithmétique sont conservés, les dégâts de base infligés au prochain tour augmentent de 100 %."
  },
  RelicConfig_97347_Name = {
    Text = "Couve Missaga de la victoire"
  },
  RelicConfig_97347_StoryDesc = {
    Text = "Aujourd'hui, nous oublierons la peur, oublierons la douleur, et ne profiterons que de la fête."
  },
  RelicConfig_98274_BattleDesc = {
    Text = "Limite de cartes en main +1, obtenez « <DerivativeCardKeywords_116:Palette> » au début du combat. \nAu début du tour, obtenez 1 « <PrimaryColor:Bleu> » et appliquez au hasard « <ColorInkKeywords:Peindre> » à 2 Cartes d'instruction. Après avoir joué une carte « <ColorInkKeywords:Peindre> », obtenez successivement 1 « <PrimaryColor:Bleu> ». \nLes « <PrimaryColor:Bleu> » joués seront enregistrés sur la « <DerivativeCardKeywords_116:Palette> ». Si la « <DerivativeCardKeywords_116:Palette> » contient 2 « <PrimaryColor:Bleu> » différents, un effet d'amélioration continue sera appliqué. \nSi la « <DerivativeCardKeywords_116:Palette> » contient 3 « <PrimaryColor:Bleu> » différents, faites immédiatement perdre 5 % de la vie maximale à tous les ennemis, puis videz la « <DerivativeCardKeywords_116:Palette> »."
  },
  RelicConfig_98274_Desc = {
    Text = "Limite de cartes en main +1, obtenez « <DerivativeCardKeywords_116:Palette> » au début du combat. \nAu début du tour, obtenez 1 « <PrimaryColor:Bleu> » et appliquez au hasard « <ColorInkKeywords:Peindre> » à 2 Cartes d'instruction. Après avoir joué une carte « <ColorInkKeywords:Peindre> », obtenez successivement 1 « <PrimaryColor:Bleu> ». \nLes « <PrimaryColor:Bleu> » joués seront enregistrés sur la « <DerivativeCardKeywords_116:Palette> ». Si la « <DerivativeCardKeywords_116:Palette> » contient 2 « <PrimaryColor:Bleu> » différents, un effet d'amélioration continue sera appliqué. \nSi la « <DerivativeCardKeywords_116:Palette> » contient 3 « <PrimaryColor:Bleu> » différents, faites immédiatement perdre 5 % de la vie maximale à tous les ennemis, puis videz la « <DerivativeCardKeywords_116:Palette> »."
  },
  RelicConfig_98274_Name = {
    Text = "Palette d'anomalies"
  },
  RelicConfig_98274_StoryDesc = {
    Text = "Dans le phénomène, nous témoignerons de la naissance de l'«art»."
  },
  RelicConfig_98367_BattleDesc = {
    Text = "Tous les éveillés voient leurs effets de régénération de vie et de bouclier augmenter de [Arg1] %."
  },
  RelicConfig_98367_Desc = {
    Text = "Tous les éveillés voient leurs effets de régénération de vie et de bouclier augmenter de [Arg1] %."
  },
  RelicConfig_98367_Name = {
    Text = "<WhiteQuality:Peau de serpent résiduelle>"
  },
  RelicConfig_98367_StoryDesc = {
    Text = "Renaissance de la mue mutilée"
  },
  RelicConfig_98368_BattleDesc = {
    Text = "Au début de la bataille, obtenez [Arg1] % de puissance de dégâts. Chaque fois que vous jouez une carte de commandement d'un réveilleur différent, obtenez en plus [Arg1] % de puissance de dégâts temporaires."
  },
  RelicConfig_98368_Desc = {
    Text = "Au début du combat, obtenez [Arg1] % de puissance de dégâts. Chaque fois que vous jouez une carte de commandement associée à un réveilleur différent, obtenez en plus [Arg1] % de puissance de dégâts temporaire."
  },
  RelicConfig_98368_Name = {
    Text = "<OrangeQuality:Kaléidoscope+>"
  },
  RelicConfig_98368_StoryDesc = {
    Text = "Tout ce que tu vois et penses n'est qu'illusion"
  },
  RelicConfig_98369_BattleDesc = {
    Text = "Utilisez l'Éveil de la clé d'argent puis obtenez Retenue et Prêt sur les [Arg1] cartes ayant le coût en arithmetica le plus élevé de votre main avant de les jouer, et recevez [Arg2] points de s-énergie."
  },
  RelicConfig_98369_Desc = {
    Text = "Utilisez l'Éveil de la clé d'argent puis faites en sorte que les [Arg1] cartes avec le coût en arithmetica le plus élevé dans votre main obtiennent Retenue et Prêt avant d'être jouées. Obtenez [Arg2] points de s-énergie."
  },
  RelicConfig_98369_Name = {
    Text = "<WhiteQuality:Album de timbres>"
  },
  RelicConfig_98369_StoryDesc = {
    Text = "Pensées quantifiées"
  },
  RelicConfig_98370_BattleDesc = {
    Text = "Au début du combat, infligez [Arg1] couches de faiblesse et de vulnérabilité à tous les ennemis. Cet effet est également déclenché après « l'anéantissement », mais avec un temps de recharge de 3 tours."
  },
  RelicConfig_98370_Desc = {
    Text = "Au début de la bataille, infligez [Arg1] couches de faiblesse et de vulnérabilité à tous les ennemis. Cet effet est également déclenché après « Annihilation », mais avec un temps de recharge de 3 tours."
  },
  RelicConfig_98370_Name = {
    Text = "<WhiteQuality:Déflecteur spatial>"
  },
  RelicConfig_98370_StoryDesc = {
    Text = "Sauter dans le Vide"
  },
  RelicConfig_98371_BattleDesc = {
    Text = "Avant la fin du tour, chaque éveillé possédant une carte de commande dans sa main gagne [Arg1] point de folie."
  },
  RelicConfig_98371_Desc = {
    Text = "Avant la fin du tour, chaque éveillé propriétaire d'une carte de commande dans la main gagne [Arg1] point de folie."
  },
  RelicConfig_98371_Name = {
    Text = "<WhiteQuality:Balance déséquilibrée>"
  },
  RelicConfig_98371_StoryDesc = {
    Text = "Ne symbolise plus la justice"
  },
  RelicConfig_98372_BattleDesc = {
    Text = "À la fin du tour, si la clé d'éclat est pleine, consommez [Arg1] clé d'éclat pour placer une <DerivativeCardKeywords_129:\"Lueur de clé d'argent\"> dans votre main."
  },
  RelicConfig_98372_Desc = {
    Text = "À la fin du tour, si la clé d'éclat est pleine, consommez [Arg1] clé d'éclat pour placer une <DerivativeCardKeywords_129:\"Lueur de clé d'argent\"> dans votre main."
  },
  RelicConfig_98372_Name = {
    Text = "<WhiteQuality:Dans la lumière du crépuscule>"
  },
  RelicConfig_98372_StoryDesc = {
    Text = "Prenons une photo ensemble ! Ressentez la vraie douleur"
  },
  RelicConfig_98373_BattleDesc = {
    Text = "Libérez « exaltation de la folie ». Obtenez [Arg1] points de s-énergie. Cet effet ne peut se déclencher qu'un maximum de 3 fois par tour."
  },
  RelicConfig_98373_Desc = {
    Text = "Libérez « l'exaltation de la folie ». Obtenez [Arg1] points de s-énergie. Cet effet ne peut se déclencher qu'un maximum de 3 fois par tour."
  },
  RelicConfig_98373_Name = {
    Text = "<OrangeQuality:Instant de beauté+>"
  },
  RelicConfig_98373_StoryDesc = {
    Text = "Préservez la beauté éphémère pour toujours"
  },
  RelicConfig_98374_BattleDesc = {
    Text = "La première fois que vous utilisez une « Clé » à chaque tour, appliquez [Arg1] couches de poison à tous les ennemis et obtenez [Arg2] couches de contre-attaque."
  },
  RelicConfig_98374_Desc = {
    Text = "La première fois que vous utilisez une « clé » à chaque tour, appliquez [Arg1] couches de poison à tous les ennemis et obtenez [Arg2] couches de contre-attaque."
  },
  RelicConfig_98374_Name = {
    Text = "<OrangeQuality:Lanterne à souhaits du prophète+>"
  },
  RelicConfig_98374_StoryDesc = {
    Text = "Répondre à ton souhait"
  },
  RelicConfig_98375_BattleDesc = {
    Text = "À la fin du tour, si la clé de flamme est pleine, consommez [Arg1] clé de flamme pour ajouter une carte <DerivativeCardKeywords_67:\"Aube de la clé d'argent\"> à votre main."
  },
  RelicConfig_98375_Desc = {
    Text = "À la fin du tour, si la clé de flamme est pleine, consommez [Arg1] clé de flamme pour ajouter une carte <DerivativeCardKeywords_67:\"Aube de la clé d'argent\"> à votre main."
  },
  RelicConfig_98375_Name = {
    Text = "<OrangeQuality:Dans la lumière du crépuscule+>"
  },
  RelicConfig_98375_StoryDesc = {
    Text = "Prenons une photo ensemble ! Ressentez la vraie douleur"
  },
  RelicConfig_98376_BattleDesc = {
    Text = "Tous les éveillés voient leurs effets de régénération de vie et de bouclier augmenter de [Arg1]%."
  },
  RelicConfig_98376_Desc = {
    Text = "Tous les éveillés voient leurs effets de régénération de vie et de bouclier augmenter de [Arg1] %."
  },
  RelicConfig_98376_Name = {
    Text = "<OrangeQuality:Peau de serpent résiduelle+>"
  },
  RelicConfig_98376_StoryDesc = {
    Text = "Renaissance de la mue mutilée"
  },
  RelicConfig_98377_BattleDesc = {
    Text = "Chaque fois qu'une carte entre dans l'espace dimensionnel, piochez [Arg1] carte(s) de commandement appartenant à son propriétaire. Si la pioche est impossible, obtenez une quantité équivalente de puissance de calcul à la place. Cet effet ne peut se produire qu'au maximum 2 fois par tour."
  },
  RelicConfig_98377_Desc = {
    Text = "Chaque fois qu'une carte entre dans l'espace dimensionnel, piochez [Arg1] carte(s) de commandement appartenant à son propriétaire depuis la pile de pioche. Si cela n'est pas possible, obtenez une quantité équivalente d'arithmetica à la place. Cet effet ne peut se produire qu'au maximum 2 fois par tour."
  },
  RelicConfig_98377_Name = {
    Text = "<WhiteQuality:Prisme>"
  },
  RelicConfig_98377_StoryDesc = {
    Text = "\"La lumière est composée de sept couleurs.\""
  },
  RelicConfig_98378_BattleDesc = {
    Text = "Au début du combat, obtenez [Arg1]% d'amplification des dégâts. Après avoir subi des dégâts, obtenez [Arg2] points de <RetaliateIconKeywords:comptoir>, avec un maximum de 3 déclenchements par tour."
  },
  RelicConfig_98378_Desc = {
    Text = "Au début du combat, obtenez [Arg1]% d'amplification des dégâts. Après avoir subi des dégâts, obtenez [Arg2] comptoir, avec un maximum de 3 déclenchements par tour."
  },
  RelicConfig_98378_Name = {
    Text = "<OrangeQuality:Sortie de secours+>"
  },
  RelicConfig_98378_StoryDesc = {
    Text = "On dirait qu'il n'a pas pu s'échapper non plus"
  },
  RelicConfig_98379_BattleDesc = {
    Text = "Après avoir infligé des dégâts actifs ou des dégâts de tentacule, augmenter de [Arg1] % les dégâts de tentacule subis par la cible pendant ce tour, déclenchable jusqu'à 20 fois par tour."
  },
  RelicConfig_98379_Desc = {
    Text = "Après avoir infligé des dégâts actifs ou des dégâts de tentacule, augmenter de [Arg1] % les dégâts de tentacule subis par la cible pendant ce tour. Peut se déclencher au maximum 20 fois par tour."
  },
  RelicConfig_98379_Name = {
    Text = "<WhiteQuality:Casque de plongée>"
  },
  RelicConfig_98379_StoryDesc = {
    Text = "Les rêves sont des étoiles et des océans !"
  },
  RelicConfig_98380_BattleDesc = {
    Text = "Au début du combat et après avoir déclenché la résistance à la mort, obtenez [Arg1] points de s-énergie."
  },
  RelicConfig_98380_Desc = {
    Text = "Au début du combat et après avoir déclenché la résistance à la mort, obtenez [Arg1] points de s-énergie."
  },
  RelicConfig_98380_Name = {
    Text = "<WhiteQuality:Offrande passée>"
  },
  RelicConfig_98380_StoryDesc = {Text = "Offrande"},
  RelicConfig_98381_BattleDesc = {
    Text = "Restaure [Heal:Arg1] PV et octroie [Arg2] Fragments de clé après avoir utilisé l'Éveil des Fragments de clé."
  },
  RelicConfig_98381_Desc = {
    Text = "Restaure [Heal:Arg1] PV et octroie [Arg2] Fragments de clé après avoir utilisé l'Éveil des Fragments de clé."
  },
  RelicConfig_98381_Name = {
    Text = "<WhiteQuality:Parapluie de voyage>"
  },
  RelicConfig_98381_StoryDesc = {
    Text = "Fleurir dans les ténèbres"
  },
  RelicConfig_98382_BattleDesc = {
    Text = "After the battle starts, gain [Arg1] <ProficientInRealmsIconKeywords:maîtrise des royaumes>. At the start of odd turns, draw [Arg2] cards, at the start of even turns, gain [Arg2] points of arithmetica."
  },
  RelicConfig_98382_Desc = {
    Text = "After the battle starts, gain [Arg1] <ProficientInRealmsIconKeywords:maîtrise des royaumes>. At the start of odd turns, draw [Arg2] cards, at the start of even turns, gain [Arg2] points of arithmetica."
  },
  RelicConfig_98382_Name = {
    Text = "<OrangeQuality:Roue du Soleil et de la Lune+>"
  },
  RelicConfig_98382_StoryDesc = {
    Text = "Devine, noir ou blanc ?"
  },
  RelicConfig_98383_BattleDesc = {
    Text = "La première fois que vous utilisez une « Clé » à chaque tour, activez tous les tentacules pour attaquer [Arg1] fois les ennemis, infligeant 50 % des dégâts."
  },
  RelicConfig_98383_Desc = {
    Text = "La première fois que vous utilisez une « clé » à chaque tour, activez tous les tentacules pour attaquer [Arg1] fois les ennemis, infligeant 50 % de dégâts."
  },
  RelicConfig_98383_Name = {
    Text = "<OrangeQuality:Petit escargot jaune+>"
  },
  RelicConfig_98383_StoryDesc = {
    Text = "Ce petit escargot jaune est de noble origine, avec une provenance parfaite et irréprochable"
  },
  RelicConfig_98384_BattleDesc = {
    Text = "Tous les réveilleurs voient leurs dégâts de base augmenter de [Arg1] %. Avant de libérer l'exaltation, le réveilleur qui libère l'exaltation voit temporairement ses dégâts de base augmenter de [Arg2] %."
  },
  RelicConfig_98384_Desc = {
    Text = "Tous les réveilleurs voient leurs dégâts de base augmenter de [Arg1] %. Avant de libérer l'exaltation, les dégâts de base du réveilleur qui libère l'exaltation sont temporairement augmentés de [Arg2] %."
  },
  RelicConfig_98384_Name = {
    Text = "<WhiteQuality:Sang des oubliés>"
  },
  RelicConfig_98384_StoryDesc = {
    Text = "Fondre progressivement"
  },
  RelicConfig_98385_BattleDesc = {
    Text = "La première fois que vous utilisez une « clé » à chaque tour, appliquez [Arg1] couches de poison à tous les ennemis et obtenez [Arg2] couches de contre-attaque."
  },
  RelicConfig_98385_Desc = {
    Text = "La première fois que vous utilisez une « clé » à chaque tour, appliquez [Arg1] couches de poison à tous les ennemis et obtenez [Arg2] couches de contre-attaque."
  },
  RelicConfig_98385_Name = {
    Text = "<WhiteQuality:Lanterne à souhaits du prophète>"
  },
  RelicConfig_98385_StoryDesc = {
    Text = "Répondre à ton souhait"
  },
  RelicConfig_98386_BattleDesc = {
    Text = "Au début du tour, si la vie est en dessous de 50%, augmentez temporairement les dégâts forts de [Arg1]%. Si la vie est en dessous de 25%, piochez [Arg2] cartes supplémentaires et gagnez [Arg2] Arithmetica."
  },
  RelicConfig_98386_Desc = {
    Text = "Au début du tour, si la vie est en dessous de 50%, augmentez temporairement les dégâts forts de [Arg1]%. Si la vie est en dessous de 25%, piochez [Arg2] cartes supplémentaires et gagnez [Arg2] Arithmetica."
  },
  RelicConfig_98386_Name = {
    Text = "<WhiteQuality:trousse de médecin>"
  },
  RelicConfig_98386_StoryDesc = {
    Text = "La mallette symbolisant la profession médicale est très lourde.\n\nCelui qui l'ouvre n'est pas forcément un vrai médecin.\n"
  },
  RelicConfig_98387_BattleDesc = {
    Text = "Au début du combat, infligez [Arg1] couches de faiblesse et de vulnérabilité à tous les ennemis. Cet effet est également déclenché après « Annihilation », mais avec un temps de recharge de 3 tours."
  },
  RelicConfig_98387_Desc = {
    Text = "Au début du combat, infligez [Arg1] couches de faiblesse et de vulnérabilité à tous les ennemis. Cet effet est également déclenché après « l'anéantissement », mais avec un temps de recharge de 3 tours."
  },
  RelicConfig_98387_Name = {
    Text = "<OrangeQuality:Déflecteur spatial+>"
  },
  RelicConfig_98387_StoryDesc = {
    Text = "Sauter dans le Vide"
  },
  RelicConfig_98388_BattleDesc = {
    Text = "Au début du combat et après avoir déclenché la résistance à la mort, obtenez [Arg1] points de s-énergie."
  },
  RelicConfig_98388_Desc = {
    Text = "Au début du combat et après avoir déclenché la résistance à la mort, obtenez [Arg1] points de s-énergie."
  },
  RelicConfig_98388_Name = {
    Text = "<OrangeQuality:Offrande passée+>"
  },
  RelicConfig_98388_StoryDesc = {Text = "Offrande"},
  RelicConfig_98389_BattleDesc = {
    Text = "After the battle starts, gain [Arg1] <ProficientInRealmsIconKeywords:maîtrise des royaumes>. At the start of odd turns, draw [Arg2] cards, at the start of even turns, gain [Arg2] points of arithmetica."
  },
  RelicConfig_98389_Desc = {
    Text = "After the battle starts, gain [Arg1] <ProficientInRealmsIconKeywords:maîtrise des royaumes>. At the start of odd turns, draw [Arg2] cards, at the start of even turns, gain [Arg2] points of arithmetica."
  },
  RelicConfig_98389_Name = {
    Text = "<WhiteQuality:Roue du Soleil et de la Lune>"
  },
  RelicConfig_98389_StoryDesc = {
    Text = "Devine, noir ou blanc ?"
  },
  RelicConfig_98390_BattleDesc = {
    Text = "Chaque fois que vous piochez ou défaussez une carte, obtenez [Arg1] points de force temporaire, maximum 15 fois par tour."
  },
  RelicConfig_98390_Desc = {
    Text = "Chaque fois que vous piochez ou défaussez une carte, obtenez [Arg1] points de force temporaire, maximum 15 fois par tour."
  },
  RelicConfig_98390_Name = {
    Text = "<WhiteQuality:Prélude silencieux>"
  },
  RelicConfig_98390_StoryDesc = {
    Text = "Le violon du célèbre violoniste Eric Eckstein.\nAujourd'hui, il ne peut plus être joué"
  },
  RelicConfig_98391_BattleDesc = {
    Text = "La première fois que vous utilisez une « clé » à chaque tour, la puissance temporaire des dégâts augmente de [Arg2] %, et l'effet est d'autant plus fort que la vie est basse."
  },
  RelicConfig_98391_Desc = {
    Text = "La première fois que vous utilisez une « clé » à chaque tour, la puissance temporaire des dégâts augmente de [Arg1] %, et l'effet est d'autant plus fort que la vie est basse."
  },
  RelicConfig_98391_Name = {
    Text = "<WhiteQuality:Élixir de Harford>"
  },
  RelicConfig_98391_StoryDesc = {
    Text = ": Médicament de composition inconnue.\nOn dit que le célèbre violoniste Éric l'apprécie beaucoup"
  },
  RelicConfig_98392_BattleDesc = {
    Text = "La première fois que vous utilisez une « clé » à chaque tour, la puissance temporaire des dégâts augmente de [Arg2] %, et l'effet est d'autant plus fort que la vie est basse."
  },
  RelicConfig_98392_Desc = {
    Text = "La première fois que vous utilisez une « clé » à chaque tour, la puissance temporaire des dégâts augmente de [Arg1] %, l'effet est d'autant plus fort que la vie est faible."
  },
  RelicConfig_98392_Name = {
    Text = "<OrangeQuality:Élixir de Harford+>"
  },
  RelicConfig_98392_StoryDesc = {
    Text = ": Médicament de composition inconnue.\nOn dit que le célèbre violoniste Éric l'apprécie beaucoup"
  },
  RelicConfig_98393_BattleDesc = {
    Text = "Tous les réveilleurs obtiennent [Arg1] points de s-énergie la première fois qu'ils jouent une « carte de commandement » chaque tour."
  },
  RelicConfig_98393_Desc = {
    Text = "Tous les réveilleurs obtiennent [Arg1] points de s-énergie lorsqu'ils utilisent une « carte de commande » pour la première fois chaque tour."
  },
  RelicConfig_98393_Name = {
    Text = "<WhiteQuality:Langue acérée>"
  },
  RelicConfig_98393_StoryDesc = {
    Text = "Les bavards ne sont pas seulement des marchands, mais aussi des croyants dévots"
  },
  RelicConfig_98394_BattleDesc = {
    Text = "La première fois que vous utilisez une « clé » chaque tour, récupérez [Arg1]% de l'énergie en s-énergie dépensée."
  },
  RelicConfig_98394_Desc = {
    Text = "La première fois que vous utilisez une « clé » à chaque tour, vous récupérez [Arg1]% de l'énergie en s-énergie dépensée."
  },
  RelicConfig_98394_Name = {
    Text = "<WhiteQuality:Pied de lapin>"
  },
  RelicConfig_98394_StoryDesc = {
    Text = "Pour le lapin, ce n'est pas si chanceux"
  },
  RelicConfig_98395_BattleDesc = {
    Text = "Au début de la bataille, obtenez [Arg1]% d'amplification des dégâts. Après avoir infligé des dégâts actifs, appliquez [Arg2] couches de poison à tous les ennemis, avec un maximum de 5 déclenchements par tour."
  },
  RelicConfig_98395_Desc = {
    Text = "Au début du combat, obtenez [Arg1]% d'amplification des dégâts. Après avoir infligé des dégâts actifs, appliquez [Arg2] couches de poison à tous les ennemis, avec un maximum de 5 déclenchements par tour."
  },
  RelicConfig_98395_Name = {
    Text = "<OrangeQuality:Bâton du prêtre+>"
  },
  RelicConfig_98395_StoryDesc = {
    Text = "Dévotion non autorisée"
  },
  RelicConfig_98396_BattleDesc = {
    Text = "Au début de la bataille, obtenez [Arg1] % de puissance de dégâts. Chaque fois que vous jouez une carte de commandement d'un réveilleur différent, obtenez en plus [Arg1] % de puissance de dégâts temporaires."
  },
  RelicConfig_98396_Desc = {
    Text = "Au début de la bataille, obtenez [Arg1] % de puissance de dégâts. Chaque fois que vous jouez une carte de commandement d'un réveilleur différent, obtenez en plus [Arg1] % de puissance de dégâts temporaires."
  },
  RelicConfig_98396_Name = {
    Text = "<WhiteQuality:Kaléidoscope>"
  },
  RelicConfig_98396_StoryDesc = {
    Text = "Tout ce que tu vois et penses n'est qu'illusion"
  },
  RelicConfig_98397_BattleDesc = {
    Text = "Après la deuxième utilisation de « clé » à chaque tour, obtenez [Arg1] points de s-énergie, tous les réveilleurs reçoivent [Arg2] points de folie."
  },
  RelicConfig_98397_Desc = {
    Text = "Après la deuxième utilisation de « clé » à chaque tour, obtenez [Arg1] points de s-énergie et tous les réveilleurs reçoivent [Arg2] points de folie."
  },
  RelicConfig_98397_Name = {
    Text = "<OrangeQuality:Chronomètre précis+>"
  },
  RelicConfig_98397_StoryDesc = {
    Text = "L'une des inventions les plus maléfiques de l'humanité"
  },
  RelicConfig_98398_BattleDesc = {
    Text = "Au début de la bataille, fait que tous les ennemis perdent temporairement [Arg1] points de force. Utiliser « Fournaise cramoisie » déclenche également cet effet, mais avec un temps de recharge de 3 tours."
  },
  RelicConfig_98398_Desc = {
    Text = "Au début de la bataille, fait que tous les ennemis perdent temporairement [Arg1] points de force. Utiliser « Fournaise cramoisie » déclenche également cet effet, mais avec un temps de recharge de 3 tours."
  },
  RelicConfig_98398_Name = {
    Text = "<OrangeQuality:Main leste+>"
  },
  RelicConfig_98398_StoryDesc = {
    Text = "L'arme parfaite pour dévaliser et tuer"
  },
  RelicConfig_98399_BattleDesc = {
    Text = "Après la deuxième utilisation de « clé » à chaque tour, obtenez [Arg1] points de s-énergie et tous les réveilleurs reçoivent [Arg2] points de folie."
  },
  RelicConfig_98399_Desc = {
    Text = "Après la deuxième utilisation de la « clé » à chaque tour, obtenez [Arg1] points de s-énergie, tous les réveilleurs reçoivent [Arg2] points de folie."
  },
  RelicConfig_98399_Name = {
    Text = "<WhiteQuality:Chronomètre>"
  },
  RelicConfig_98399_StoryDesc = {
    Text = "L'une des inventions les plus maléfiques de l'humanité"
  },
  RelicConfig_98400_BattleDesc = {
    Text = "Chaque fois que vous piochez ou défaussez une carte, obtenez [Arg1] point de force temporaire, maximum 15 fois par tour."
  },
  RelicConfig_98400_Desc = {
    Text = "Chaque fois que vous piochez ou défaussez une carte, obtenez [Arg1] point de force temporaire, maximum 15 fois par tour."
  },
  RelicConfig_98400_Name = {
    Text = "<OrangeQuality:Prélude silencieux+>"
  },
  RelicConfig_98400_StoryDesc = {
    Text = "Le violon du célèbre violoniste Eric Eckstein.\nAujourd'hui, il ne peut plus être joué"
  },
  RelicConfig_98401_BattleDesc = {
    Text = "Au début du combat, obtenez [Arg1]% d'amplification des dégâts. Après votre première riposte du tour, gagnez [Arg2] points d'arithmétique."
  },
  RelicConfig_98401_Desc = {
    Text = "Au début du combat, obtenez [Arg1]% d'amplification des dégâts. Lors du premier contre-coup de chaque tour, gagnez [Arg2] arithmetica."
  },
  RelicConfig_98401_Name = {
    Text = "<OrangeQuality:Putney Morning Post+>"
  },
  RelicConfig_98401_StoryDesc = {
    Text = "Votre compagnon de toilette le plus attentionné"
  },
  RelicConfig_98402_BattleDesc = {
    Text = "Après avoir infligé des dégâts actifs ou des dégâts de tentacule, augmenter les dégâts de tentacule subis par la cible pendant ce tour de [Arg1] %, déclenchable jusqu'à 20 fois par tour."
  },
  RelicConfig_98402_Desc = {
    Text = "Après avoir infligé des dégâts actifs ou des dégâts de tentacule, augmenter de [Arg1] % les dégâts de tentacule subis par la cible pendant ce tour, déclenchable jusqu'à 20 fois par tour."
  },
  RelicConfig_98402_Name = {
    Text = "<OrangeQuality:Casque de plongée+>"
  },
  RelicConfig_98402_StoryDesc = {
    Text = "Les rêves sont des étoiles et des océans !"
  },
  RelicConfig_98403_BattleDesc = {
    Text = "Au début de la bataille, obtenez [Arg1] point de force. Pour chaque carte « consommable » jouée, obtenez [Arg2] point de force temporaire, déclenchable jusqu'à 10 fois par tour."
  },
  RelicConfig_98403_Desc = {
    Text = "Au début de la bataille, obtenez [Arg1] point de force. Pour chaque carte « consommable » jouée, obtenez [Arg2] point de force temporaire, déclenchable jusqu'à 10 fois par tour."
  },
  RelicConfig_98403_Name = {
    Text = "<OrangeQuality:Petite boîte à musique+>"
  },
  RelicConfig_98403_StoryDesc = {
    Text = "Il y a de nombreuses collections dans le manoir de Dexter. Avant d'être cassée, la Petite boîte à musique était le jouet préféré de Mademoiselle Dexter. \n Le temps passe, et lorsque Mademoiselle Dexter la retrouve à nouveau, ses rouages sont lâches, la musique est déformée, mais elle continue de tourner."
  },
  RelicConfig_98404_BattleDesc = {
    Text = "Libérez « l'exaltation de la folie » pour obtenir [Arg1] points de s-énergie. Cet effet peut se déclencher un maximum de 3 fois par tour."
  },
  RelicConfig_98404_Desc = {
    Text = "Libérez « l'exaltation de la folie ». Obtenez [Arg1] points de s-énergie. Cet effet peut se déclencher un maximum de 3 fois par tour."
  },
  RelicConfig_98404_Name = {
    Text = "<WhiteQuality:Instant de beauté>"
  },
  RelicConfig_98404_StoryDesc = {
    Text = "Préservez la beauté éphémère pour toujours"
  },
  RelicConfig_98405_BattleDesc = {
    Text = "Tous les réveilleurs obtiennent [Arg1] points de s-énergie lorsqu'ils utilisent une « carte de commandement » pour la première fois chaque tour."
  },
  RelicConfig_98405_Desc = {
    Text = "Tous les réveilleurs obtiennent [Arg1] points de s-énergie lors de la première utilisation d'une « carte de commande » chaque tour."
  },
  RelicConfig_98405_Name = {
    Text = "<OrangeQuality:Langue acérée+>"
  },
  RelicConfig_98405_StoryDesc = {
    Text = "Les bavards ne sont pas seulement des marchands, mais aussi des croyants dévots"
  },
  RelicConfig_98406_BattleDesc = {
    Text = "Chaque fois qu'un « embryon » est généré, obtenez [Arg1] points de fournaise cramoisie. Maximum 3 déclenchements par tour."
  },
  RelicConfig_98406_Desc = {
    Text = "Chaque fois qu'un « embryon » est généré, obtenez [Arg1] points de fournaise cramoisie. Maximum 3 déclenchements par tour."
  },
  RelicConfig_98406_Name = {
    Text = "<OrangeQuality:Chéri+>"
  },
  RelicConfig_98406_StoryDesc = {
    Text = "Le menuisier a fabriqué une marionnette vivante pour sa femme, qui remplacera leur fils et dormira dans son ventre"
  },
  RelicConfig_98407_BattleDesc = {
    Text = "La première fois que vous utilisez une « clé » à chaque tour, récupérez [Arg1]% de l'énergie en s-énergie dépensée."
  },
  RelicConfig_98407_Desc = {
    Text = "La première « clé » utilisée à chaque tour rembourse [Arg1]% de l'énergie en argent dépensée."
  },
  RelicConfig_98407_Name = {
    Text = "<OrangeQuality:Pied de lapin+>"
  },
  RelicConfig_98407_StoryDesc = {
    Text = "Pour le lapin, ce n'est pas si chanceux"
  },
  RelicConfig_98408_BattleDesc = {
    Text = "Au début du tour, tous les éveillés dont la folie est insuffisante pour déclencher une exaltation reçoivent [Arg1] points de folie."
  },
  RelicConfig_98408_Desc = {
    Text = "Au début du tour, tous les éveillés dont la folie est insuffisante pour déclencher l'exaltation de la folie reçoivent [Arg1] points de folie."
  },
  RelicConfig_98408_Name = {
    Text = "<WhiteQuality:Temps de Pâques>"
  },
  RelicConfig_98408_StoryDesc = {
    Text = "Profitez-en, mais ne le mangez pas"
  },
  RelicConfig_98409_BattleDesc = {
    Text = "Au début de la bataille, fait que tous les ennemis perdent temporairement [Arg1] points de force. Utiliser « Fournaise cramoisie » déclenche également cet effet, mais avec un temps de recharge de 3 tours."
  },
  RelicConfig_98409_Desc = {
    Text = "Au début de la bataille, fait perdre à tous les ennemis [Arg1] points de <PowerIconKeywords:force> temporaire. L'utilisation de « Fournaise cramoisie » déclenche également cet effet, mais avec un temps de recharge de 3 tours."
  },
  RelicConfig_98409_Name = {
    Text = "<WhiteQuality:Main leste>"
  },
  RelicConfig_98409_StoryDesc = {
    Text = "L'arme parfaite pour dévaliser et tuer"
  },
  RelicConfig_98410_BattleDesc = {
    Text = "Chaque fois qu'un « embryon » est généré, obtenez [Arg1] points de fournaise cramoisie. Déclenchement maximum : 3 fois par tour."
  },
  RelicConfig_98410_Desc = {
    Text = "Chaque fois qu'un « embryon » est généré, obtenez [Arg1] points de fournaise cramoisie. Maximum 3 déclenchements par tour."
  },
  RelicConfig_98410_Name = {
    Text = "<WhiteQuality:Chéri>"
  },
  RelicConfig_98410_StoryDesc = {
    Text = "Le menuisier a fabriqué une marionnette vivante pour sa femme, qui remplacera leur fils et dormira dans son ventre"
  },
  RelicConfig_98411_BattleDesc = {
    Text = "Au début du tour, si l'énergie en clé d'argent est supérieure à [Arg1], consommez [Arg1] points d'énergie en clé d'argent pour ajouter 1 carte <DerivativeCardKeywords_115:« Inspiration supérieure »> à votre main."
  },
  RelicConfig_98411_Desc = {
    Text = "Au début du tour, si l'énergie en clé d'argent est supérieure à [Arg1], consommez [Arg1] points d'énergie en clé d'argent pour ajouter 1 carte <DerivativeCardKeywords_115:« Inspiration supérieure »> à votre main."
  },
  RelicConfig_98411_Name = {
    Text = "<RedQuality:Apparence de cauchemar>"
  },
  RelicConfig_98411_StoryDesc = {
    Text = "Attention, le sommeil indulgent peut tout engloutir sans prévenir"
  },
  RelicConfig_98412_BattleDesc = {
    Text = "Après avoir libéré 5 « exaltations de la folie », les [Arg1] prochaines cartes de commandement non dérivées prendront effet une fois de plus."
  },
  RelicConfig_98412_Desc = {
    Text = "Après avoir libéré 5 fois l'exaltation de la folie, les prochaines [Arg1] cartes de commandement non dérivées prendront effet une fois supplémentaire."
  },
  RelicConfig_98412_Name = {
    Text = "<OrangeQuality:Vin des étoiles+>"
  },
  RelicConfig_98412_StoryDesc = {
    Text = "Errant parmi les étoiles"
  },
  RelicConfig_98413_BattleDesc = {
    Text = "Au début du combat, obtenez [Arg1]% d'amplification des dégâts. Après avoir subi des dégâts, obtenez [Arg2] comptoir, maximum 3 déclenchements par tour."
  },
  RelicConfig_98413_Desc = {
    Text = "Au début du combat, obtenez [Arg1]% d'amplification des dégâts. Après avoir subi des dégâts, obtenez [Arg2] comptoir, avec un maximum de 3 déclenchements par tour."
  },
  RelicConfig_98413_Name = {
    Text = "<WhiteQuality:Sortie de secours>"
  },
  RelicConfig_98413_StoryDesc = {
    Text = "On dirait qu'il n'a pas pu s'échapper non plus"
  },
  RelicConfig_98414_BattleDesc = {
    Text = "Tous les réveilleurs voient leurs dégâts de base augmenter de [Arg1] %. Avant de libérer l'exaltation, le réveilleur qui l'active voit temporairement ses dégâts de base augmenter de [Arg2] %."
  },
  RelicConfig_98414_Desc = {
    Text = "Tous les réveilleurs voient leurs dégâts de base augmenter de [Arg1] %. Avant de libérer l'exaltation, le réveilleur qui la libère voit temporairement ses dégâts de base augmenter de [Arg2] %."
  },
  RelicConfig_98414_Name = {
    Text = "<OrangeQuality:Sang des oubliés+>"
  },
  RelicConfig_98414_StoryDesc = {
    Text = "Fondre progressivement"
  },
  RelicConfig_98415_BattleDesc = {
    Text = "Restaure [Heal:Arg1] PV et octroie [Arg2] Fragments de clé après avoir utilisé l'Éveil des Fragments de clé."
  },
  RelicConfig_98415_Desc = {
    Text = "Restaure [Heal:Arg1] PV et octroie [Arg2] Fragments de clé après avoir utilisé l'Éveil des Fragments de clé."
  },
  RelicConfig_98415_Name = {
    Text = "<OrangeQuality:Parapluie de voyage+>"
  },
  RelicConfig_98415_StoryDesc = {
    Text = "Fleurir dans les ténèbres"
  },
  RelicConfig_98416_BattleDesc = {
    Text = "Au début de la bataille, obtenez [Arg1]% d'amplification des dégâts. Après votre premier contre-coup du tour, gagnez [Arg2] points d'arithmétique."
  },
  RelicConfig_98416_Desc = {
    Text = "Au début du combat, obtenez [Arg1] % d'amplification des dégâts. Après votre première riposte du tour, gagnez [Arg2] arithmetica."
  },
  RelicConfig_98416_Name = {
    Text = "<WhiteQuality:Putney Morning Post>"
  },
  RelicConfig_98416_StoryDesc = {
    Text = "Votre compagnon de toilette le plus attentionné"
  },
  RelicConfig_98417_BattleDesc = {
    Text = "Au début du tour, tous les éveillés dont la folie est insuffisante pour déclencher une Exaltation de la folie reçoivent [Arg1] points de folie."
  },
  RelicConfig_98417_Desc = {
    Text = "Au début du tour, tous les éveillés dont la folie est insuffisante pour déclencher une exaltation de la folie reçoivent [Arg1] points de folie."
  },
  RelicConfig_98417_Name = {
    Text = "<OrangeQuality:Temps de Pâques+>"
  },
  RelicConfig_98417_StoryDesc = {
    Text = "Profitez-en, mais ne le mangez pas"
  },
  RelicConfig_98418_BattleDesc = {
    Text = "Au début de la bataille, obtenez [Arg1]% d'amplification des dégâts. Après la première application de poison pendant le tour, piochez [Arg2] cartes."
  },
  RelicConfig_98418_Desc = {
    Text = "Au début de la bataille, obtenez [Arg1] % d'amplification des dégâts. Après la première application de poison du tour, piochez [Arg2] cartes."
  },
  RelicConfig_98418_Name = {
    Text = "<OrangeQuality:Papyrus de Reind+>"
  },
  RelicConfig_98418_StoryDesc = {
    Text = "Maintenant, écoutez la question : 10 moines partagent 6 pains, combien chacun obtient-il ?"
  },
  RelicConfig_98419_BattleDesc = {
    Text = "Après avoir libéré 5 fois l'« exaltation de la folie », les [Arg1] prochaines cartes de commandement non dérivées prendront effet une fois supplémentaire."
  },
  RelicConfig_98419_Desc = {
    Text = "Après avoir libéré 5 « exaltations de la folie », les [Arg1] prochaines cartes de commandement non dérivées prendront effet une fois supplémentaire."
  },
  RelicConfig_98419_Name = {
    Text = "<WhiteQuality:Vin des étoiles>"
  },
  RelicConfig_98419_StoryDesc = {
    Text = "Errant parmi les étoiles"
  },
  RelicConfig_98420_BattleDesc = {
    Text = "Chaque fois qu'une carte entre dans l'espace dimensionnel, piochez [Arg1] cartes de commandement appartenant à son propriétaire depuis la pile de pioche. Si vous ne pouvez pas les piocher, obtenez une quantité équivalente de puissance de calcul à la place. Cet effet ne peut se produire qu'au maximum 2 fois par tour."
  },
  RelicConfig_98420_Desc = {
    Text = "Chaque fois qu'une carte entre dans l'espace dimensionnel, piochez [Arg1] carte(s) de commandement appartenant à son propriétaire depuis la pile de pioche. Si la pioche échoue, obtenez une quantité équivalente d'arithmetica à la place. Cet effet ne peut se produire qu'au maximum 2 fois par tour."
  },
  RelicConfig_98420_Name = {
    Text = "<OrangeQuality:Prisme+>"
  },
  RelicConfig_98420_StoryDesc = {
    Text = "\"La lumière est composée de sept couleurs.\""
  },
  RelicConfig_98421_BattleDesc = {
    Text = "Utilisez l'Éveil de la clé d'argent puis faites en sorte que les [Arg1] cartes avec le coût en arithmetica le plus élevé dans votre main obtiennent Retenue et Prêt avant d'être jouées. Obtenez [Arg2] points de s-énergie."
  },
  RelicConfig_98421_Desc = {
    Text = "Utilisez l'Éveil de la clé d'argent puis faites en sorte que les [Arg1] cartes ayant le coût en arithmetica le plus élevé dans votre main obtiennent « Retenue » et « Prêt » avant d'être jouées. Obtenez [Arg2] points de s-énergie."
  },
  RelicConfig_98421_Name = {
    Text = "<OrangeQuality:Timbre postal exotique+>"
  },
  RelicConfig_98421_StoryDesc = {
    Text = "Pensées quantifiées"
  },
  RelicConfig_98422_BattleDesc = {
    Text = "Avant la fin du tour, chaque éveillé propriétaire d'une carte de commande dans la main gagne [Arg1] point de folie."
  },
  RelicConfig_98422_Desc = {
    Text = "Avant la fin du tour, chaque éveillé propriétaire d'une carte de commande dans sa main gagne [Arg1] point de folie."
  },
  RelicConfig_98422_Name = {
    Text = "<OrangeQuality:Balance déséquilibrée+>"
  },
  RelicConfig_98422_StoryDesc = {
    Text = "Ne symbolise plus la justice"
  },
  RelicConfig_98423_BattleDesc = {
    Text = "Au début du combat, obtenez [Arg1]% d'amplification des dégâts. Après avoir infligé des dégâts actifs, appliquez [Arg2] couches de poison à tous les ennemis, avec un maximum de 5 déclenchements par tour."
  },
  RelicConfig_98423_Desc = {
    Text = "Au début de la bataille, obtenez [Arg1]% d'amplification des dégâts. Après avoir infligé des dégâts actifs, appliquez [Arg2] couches de poison à tous les ennemis, avec un maximum de 5 déclenchements par tour."
  },
  RelicConfig_98423_Name = {
    Text = "<WhiteQuality:Bâton de prêtre>"
  },
  RelicConfig_98423_StoryDesc = {
    Text = "Dévotion non autorisée"
  },
  RelicConfig_98424_BattleDesc = {
    Text = "Au début de la bataille, obtenez [Arg1] % d'amplification des dégâts. Après la première application de poison pendant le tour, piochez [Arg2] cartes."
  },
  RelicConfig_98424_Desc = {
    Text = "Au début de la bataille, obtenez [Arg1] % d'amplification des dégâts. Après la première application de poison pendant le tour, piochez [Arg2] cartes."
  },
  RelicConfig_98424_Name = {
    Text = "<WhiteQuality:Papyrus de Reind>"
  },
  RelicConfig_98424_StoryDesc = {
    Text = "Maintenant, écoutez la question : 10 moines partagent 6 pains, combien chacun obtient-il ?"
  },
  RelicConfig_98425_BattleDesc = {
    Text = "Au début de la bataille, obtenez [Arg1] point de force. Pour chaque carte portant « consommable » jouée, obtenez [Arg2] point de force temporaire, jusqu'à 10 fois par tour."
  },
  RelicConfig_98425_Desc = {
    Text = "Au début de la bataille, obtenez [Arg1] point de <PowerIconKeywords:force>. Pour chaque carte « consommable » jouée, obtenez [Arg2] points de <PowerIconKeywords:force> temporaire, maximum 10 fois par tour."
  },
  RelicConfig_98425_Name = {
    Text = "<WhiteQuality:Petite boîte à musique>"
  },
  RelicConfig_98425_StoryDesc = {
    Text = "Il y a de nombreuses collections dans le manoir de Dexter. Avant d'être cassée, la Petite boîte à musique était le jouet préféré de Mademoiselle Dexter. \n Le temps passe, et lorsque Mademoiselle Dexter la retrouve à nouveau, ses rouages sont lâches, la musique est déformée, mais elle continue de tourner."
  },
  RelicConfig_98426_BattleDesc = {
    Text = "La première fois que vous utilisez une « clé » à chaque tour, activez tous les tentacules pour attaquer [Arg1] fois les ennemis, infligeant 50 % de dégâts."
  },
  RelicConfig_98426_Desc = {
    Text = "La première fois que vous utilisez une « clé » à chaque tour, activez tous les tentacules pour attaquer [Arg1] fois les ennemis, infligeant 50 % de dégâts."
  },
  RelicConfig_98426_Name = {
    Text = "<WhiteQuality:Petit escargot jaune>"
  },
  RelicConfig_98426_StoryDesc = {
    Text = "Ce petit escargot jaune est de noble origine, avec une provenance parfaite et irréprochable"
  },
  RelicConfig_98427_BattleDesc = {
    Text = "Au début du tour, si la vie est en dessous de 50%, augmentez temporairement les dégâts forts de [Arg1]%. Si la vie est en dessous de 25%, piochez [Arg2] cartes supplémentaires et gagnez [Arg2] Arithmetica."
  },
  RelicConfig_98427_Desc = {
    Text = "Au début du tour, si la vie est en dessous de 50%, augmentez temporairement les dégâts forts de [Arg1]%. Si la vie est en dessous de 25%, piochez [Arg2] cartes supplémentaires et gagnez [Arg2] Arithmetica."
  },
  RelicConfig_98427_Name = {
    Text = "<OrangeQuality:Valise du médecin+>"
  },
  RelicConfig_98427_StoryDesc = {
    Text = "La mallette symbolisant la profession médicale est très lourde.\n\nCelui qui l'ouvre n'est pas forcément un vrai médecin.\n"
  },
  RelicConfig_98891_BattleDesc = {
    Text = "Après le début du combat, gagnez 5 couches de « <LostWay:Perdu> », réduisez 1 couche après avoir joué 3 cartes d'instruction. \n Après que toutes les « <LostWay:Perdu> » aient été retirées, tous les Éveilleurs gagnent 100 points de Fureur, récupérez [Arg1] points de PV après avoir joué 3 cartes d'instruction, appliquez <Corrosion:Corrosion> à l'ennemi de la première ligne égal à 1% des PV Max de l'ennemi."
  },
  RelicConfig_98891_Desc = {
    Text = "Après le début du combat, gagnez 5 couches de « <LostWay:Perdu> », réduisez 1 couche après avoir joué 3 cartes d'instruction. \n Après que toutes les « <LostWay:Perdu> » aient été retirées, tous les Éveilleurs gagnent 100 points de Fureur, récupérez [Arg1] points de PV après avoir joué 3 cartes d'instruction, appliquez <Corrosion:Corrosion> à l'ennemi de la première ligne égal à 1% des PV Max de l'ennemi."
  },
  RelicConfig_98891_Name = {
    Text = "âme artificielle"
  },
  RelicConfig_98891_StoryDesc = {
    Text = "Même si l'expérience est sombre, la lanterne salvatrice brillera à nouveau dans la mort."
  }
})
return Text_RelicConfig
