__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_EnchantConfig = readonly({
  EnchantConfig_119927_Desc = {
    Text = "Après avoir joué, effectue un effet supplémentaire [Arg1] fois, <DepleteIconKeywords:épuiser>. <RippleKeywords:Réplica> : piochez 2 cartes."
  },
  EnchantConfig_119927_Name = {
    Text = "<BlueQuality:Écho des profondeurs>"
  },
  EnchantConfig_18169_Desc = {
    Text = "Après avoir joué, obtenez [Arg1] points d'arithmétique"
  },
  EnchantConfig_18169_Name = {
    Text = "<WhiteQuality:Calcul>"
  },
  EnchantConfig_18170_Desc = {
    Text = "Lorsque jouée, gagnez [Arg1] <RetaliateIconKeywords:Contre-attaque>, puis infligez des DGT vrais à tous les ennemis égaux à [Arg2]% de votre <RetaliateIconKeywords:Contre-attaque>."
  },
  EnchantConfig_18170_Name = {
    Text = "<OrangeQuality:vulnérabilité avancée>"
  },
  EnchantConfig_18171_Desc = {
    Text = "Après avoir joué, effectue un effet supplémentaire [Arg1] fois, obtenez [Arg2] points du sigil noir, <DepleteIconKeywords:épuiser>, <GuyouKeywords:innée>"
  },
  EnchantConfig_18171_Name = {
    Text = "<OrangeQuality:Écho avancé>"
  },
  EnchantConfig_18172_Desc = {
    Text = "Après avoir joué, fait perdre à tous les ennemis [Arg1] points de <PowerIconKeywords:Force> temporaire"
  },
  EnchantConfig_18172_Name = {
    Text = "<WhiteQuality:Épuisement>"
  },
  EnchantConfig_18173_Desc = {
    Text = "Après avoir joué, <EmbryoFusionIconKeywords:Fusion d'Embryon> +[Arg1]."
  },
  EnchantConfig_18173_Name = {
    Text = "<OrangeQuality:Sanguinaire avancé>"
  },
  EnchantConfig_18174_Desc = {
    Text = "Après avoir joué <VulnerabilityIconKeywords:vulnérable>, tous les ennemis subissent [Arg1] tours"
  },
  EnchantConfig_18174_Name = {
    Text = "<OrangeQuality:vulnérabilité avancée>"
  },
  EnchantConfig_18175_Desc = {
    Text = "Après avoir joué, fait attaquer 1 tentacule [Arg1] fois"
  },
  EnchantConfig_18175_Name = {
    Text = "<OrangeQuality:Domination avancée>"
  },
  EnchantConfig_18176_Desc = {
    Text = "Après avoir joué, fait attaquer 1 tentacule [Arg1] fois"
  },
  EnchantConfig_18176_Name = {
    Text = "<WhiteQuality:Domination>"
  },
  EnchantConfig_18177_Desc = {
    Text = "Après avoir joué, pioche [Arg1] cartes"
  },
  EnchantConfig_18177_Name = {
    Text = "<OrangeQuality:Main habile avancée>"
  },
  EnchantConfig_18178_Desc = {
    Text = "Après le début du combat, [Arg1] cartes temporaires sont mélangées dans la pile de cartes, les cartes originales et les cartes miroir obtiennent <RetainIconKeywords:conserver>"
  },
  EnchantConfig_18178_Name = {
    Text = "<OrangeQuality:Mirage avancé>"
  },
  EnchantConfig_18179_Desc = {
    Text = "Après avoir joué, gagne [Arg1] points de <PowerIconKeywords:Force>"
  },
  EnchantConfig_18179_Name = {
    Text = "<OrangeQuality:Force brute avancée>"
  },
  EnchantConfig_18180_Desc = {
    Text = "Après avoir joué, l'éveillé gagne [Arg1] folie"
  },
  EnchantConfig_18180_Name = {
    Text = "<OrangeQuality:Furie avancée>"
  },
  EnchantConfig_18181_Desc = {
    Text = "Après avoir joué, appliquez [Arg1] couches <IntoxicationIconKeywords:Poison> à tous les ennemis, faisant déclencher [Arg2]% <IntoxicationIconKeywords:Poison> pour tous les ennemis"
  },
  EnchantConfig_18181_Name = {
    Text = "<OrangeQuality:Toxine avancée>"
  },
  EnchantConfig_18182_Desc = {
    Text = "Après avoir joué, mélangez [Arg1] cartes <DerivativeCardKeywords_4:«inspiration»> dans la pile de pioche. « Inspiration - Gagnez 1 arithmétique. Pigez 1 carte, <RetainIconKeywords:conserver>, <DepleteIconKeywords:épuiser>. »"
  },
  EnchantConfig_18182_Name = {
    Text = "<WhiteQuality:Inspiration>"
  },
  EnchantConfig_18183_Desc = {
    Text = "Après avoir joué <VulnerabilityIconKeywords:vulnérable>, tous les ennemis subissent [Arg1] tours"
  },
  EnchantConfig_18183_Name = {
    Text = "<WhiteQuality:vulnérable>"
  },
  EnchantConfig_18184_Desc = {
    Text = "Après avoir joué, gagnez [Arg1] points de bouclier"
  },
  EnchantConfig_18184_Name = {
    Text = "<OrangeQuality:Mur de fer avancé>"
  },
  EnchantConfig_18185_Desc = {
    Text = "Après avoir joué, appliquez [Arg1] couches <IntoxicationIconKeywords:Poison> à tous les ennemis, faisant déclencher [Arg2]% <IntoxicationIconKeywords:Poison> pour tous les ennemis"
  },
  EnchantConfig_18185_Name = {
    Text = "<WhiteQuality:Toxine>"
  },
  EnchantConfig_18186_Desc = {
    Text = "Après le début du combat, [Arg1] cartes temporaires sont mélangées dans la pile de cartes, les cartes originales et les cartes miroir obtiennent <RetainIconKeywords:conserver>"
  },
  EnchantConfig_18186_Name = {
    Text = "<WhiteQuality:Image miroir>"
  },
  EnchantConfig_18187_Desc = {
    Text = "Après avoir joué, obtenez [Arg1] points temporaires <PowerIconKeywords:pouvoir>, les cartes d'impression peuvent également bénéficier de cet <PowerIconKeywords:pouvoir>"
  },
  EnchantConfig_18187_Name = {
    Text = "<OrangeQuality:Explosion avancée>"
  },
  EnchantConfig_18188_Desc = {
    Text = "Après avoir joué, pioche [Arg1] cartes"
  },
  EnchantConfig_18188_Name = {
    Text = "<WhiteQuality:Main habile>"
  },
  EnchantConfig_18189_Desc = {
    Text = "Après avoir joué, mélangez [Arg1] cartes <DerivativeCardKeywords_4:«inspiration»> dans la pile de pioche. « Inspiration - Gagnez 1 arithmétique. Pigez 1 carte, <RetainIconKeywords:conserver>, <DepleteIconKeywords:épuiser>. »"
  },
  EnchantConfig_18189_Name = {
    Text = "<OrangeQuality:Inspiration avancée>"
  },
  EnchantConfig_18190_Desc = {
    Text = "Après avoir joué, <WeaknessIconKeywords:Faiblesse> tous les ennemis [Arg1] tours"
  },
  EnchantConfig_18190_Name = {
    Text = "<OrangeQuality:faiblesse avancée>"
  },
  EnchantConfig_18191_Desc = {
    Text = "Après avoir joué, <EmbryoFusionIconKeywords:Fusion d'Embryon> +[Arg1]."
  },
  EnchantConfig_18191_Name = {
    Text = "<WhiteQuality:Sanguinaire>"
  },
  EnchantConfig_18192_Desc = {
    Text = "Après avoir joué, <WeaknessIconKeywords:Faiblesse> tous les ennemis [Arg1] tours"
  },
  EnchantConfig_18192_Name = {
    Text = "<WhiteQuality:Faiblesse>"
  },
  EnchantConfig_18193_Desc = {
    Text = "Après avoir joué, fait perdre à tous les ennemis [Arg1] points de <PowerIconKeywords:Force> temporaire"
  },
  EnchantConfig_18193_Name = {
    Text = "<OrangeQuality:Épuisement avancé>"
  },
  EnchantConfig_18194_Desc = {
    Text = "Après avoir joué, copie [Arg1] cartes dans l'<DimensionalSpaceIconKeywords:Espace dimensionnel> temporaire"
  },
  EnchantConfig_18194_Name = {
    Text = "<OrangeQuality:Distorsion avancée>"
  },
  EnchantConfig_18195_Desc = {
    Text = "Après avoir joué, gagne [Arg1] points de <PowerIconKeywords:Force>"
  },
  EnchantConfig_18195_Name = {
    Text = "<WhiteQuality:Force brute>"
  },
  EnchantConfig_18196_Desc = {
    Text = "Après avoir joué, gagnez [Arg1] points de bouclier"
  },
  EnchantConfig_18196_Name = {
    Text = "<WhiteQuality:Mur de fer>"
  },
  EnchantConfig_18197_Desc = {
    Text = "Après avoir joué, obtenez [Arg1] points d'arithmétique"
  },
  EnchantConfig_18197_Name = {
    Text = "<OrangeQuality:Calcul avancé>"
  },
  EnchantConfig_18198_Desc = {
    Text = "Après avoir joué, les autres éveillés gagnent [Arg1] folie"
  },
  EnchantConfig_18198_Name = {
    Text = "<OrangeQuality:Catalyse avancée>"
  },
  EnchantConfig_18199_Desc = {
    Text = "Lorsque jouée, gagnez [Arg1] <RetaliateIconKeywords:Contre-attaque>, puis infligez des DGT vrais à tous les ennemis égaux à [Arg2]% de votre <RetaliateIconKeywords:Contre-attaque>."
  },
  EnchantConfig_18199_Name = {
    Text = "<WhiteQuality:pique>"
  },
  EnchantConfig_18200_Desc = {
    Text = "Après avoir joué, effectue un effet supplémentaire [Arg1] fois, obtenez [Arg2] points du sigil noir, <DepleteIconKeywords:épuiser>, <GuyouKeywords:innée>"
  },
  EnchantConfig_18200_Name = {
    Text = "<WhiteQuality:Écho>"
  },
  EnchantConfig_18201_Desc = {
    Text = "Après avoir joué, l'éveillé gagne [Arg1] folie"
  },
  EnchantConfig_18201_Name = {
    Text = "<WhiteQuality:Furie>"
  },
  EnchantConfig_18202_Desc = {
    Text = "Après avoir joué, obtenez [Arg1] points temporaires <PowerIconKeywords:pouvoir>, les cartes d'impression peuvent également bénéficier de cet <PowerIconKeywords:pouvoir>"
  },
  EnchantConfig_18202_Name = {
    Text = "<WhiteQuality:Explosion>"
  },
  EnchantConfig_18203_Desc = {
    Text = "Après avoir joué, les autres éveillés gagnent [Arg1] folie"
  },
  EnchantConfig_18203_Name = {
    Text = "<WhiteQuality:Catalyse>"
  },
  EnchantConfig_18204_Desc = {
    Text = "Après avoir joué, copie [Arg1] cartes dans l'<DimensionalSpaceIconKeywords:Espace dimensionnel> temporaire"
  },
  EnchantConfig_18204_Name = {
    Text = "<WhiteQuality:Warp>"
  },
  EnchantConfig_48006_Desc = {
    Text = "La première carte jouée chaque tour a un effet supplémentaire 2 fois"
  },
  EnchantConfig_48006_Name = {
    Text = "<WhiteQuality:Ensemble>"
  },
  EnchantConfig_48007_Desc = {
    Text = "La première carte jouée chaque tour a un effet supplémentaire 3 fois"
  },
  EnchantConfig_48007_Name = {
    Text = "<WhiteQuality:Ensemble avancé>"
  },
  EnchantConfig_49108_Desc = {
    Text = "Les cartes obtiennent <RetainIconKeywords:conservation>, si elles sont en main à la fin du tour, obtenez une copie originale avec <RetainIconKeywords:conservation> et <DepleteIconKeywords:consommation>"
  },
  EnchantConfig_49108_Name = {
    Text = "<WhiteQuality:Gestation>"
  },
  EnchantConfig_59530_Desc = {
    Text = "Jouez-le puis défaussez toutes les autres cartes sauf cet éveilleur, en gagnant 5 cartes aléatoires non-éveilleuses ; cela ne prend effet qu'une seule fois par bataille."
  },
  EnchantConfig_59530_Name = {
    Text = "<OrangeQuality:Logique du plaisir>"
  },
  EnchantConfig_59531_Desc = {
    Text = "Jouez-le puis tirez 2 cartes, leur coût arithmétique réduit le coût réel pour les cartes d'empreinte ; cela ne prend effet qu'une seule fois par bataille."
  },
  EnchantConfig_59531_Name = {
    Text = "<OrangeQuality:Logique de la connaissance>"
  },
  EnchantConfig_59532_Desc = {
    Text = "En jouant, gagnez 3 <RetainIconKeywords:Retain> supplémentaires et <DepleteIconKeywords:Exhaust> copie de base, efficace une seule fois par bataille."
  },
  EnchantConfig_59532_Name = {
    Text = "<OrangeQuality:Principe de reproduction>"
  },
  EnchantConfig_67415_Desc = {
    Text = "Jouez-le puis défaussez toutes les autres cartes sauf cet éveilleur, en gagnant 5 cartes aléatoires non-éveilleuses ; cela ne prend effet qu'une seule fois par bataille."
  },
  EnchantConfig_67415_Name = {
    Text = "<RedQuality:Adv. Lex Volis>"
  },
  EnchantConfig_67416_Desc = {
    Text = "Jouez-le puis tirez 4 cartes, leur coût arithmétique réduit le coût réel pour les cartes d'empreinte ; cela ne prend effet qu'une seule fois par bataille."
  },
  EnchantConfig_67416_Name = {
    Text = "<RedQuality:Adv. Lex Nous>"
  },
  EnchantConfig_67417_Desc = {
    Text = "En jouant, gagnez 3 coût arithmétique -1 et ajoutez <RetainIconKeywords:Retain> et <DepleteIconKeywords:Exhaust> copie de base, efficace une seule fois par bataille."
  },
  EnchantConfig_67417_Name = {
    Text = "<RedQuality::Principe de haute reproduction>"
  }
})
return Text_EnchantConfig
