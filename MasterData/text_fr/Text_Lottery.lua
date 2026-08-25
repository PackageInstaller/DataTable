__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Lottery = readonly({
  Lottery_116466_DrawBtnText = {
    Text = "Demander une bénédiction"
  },
  Lottery_116466_DrawTitle = {
    Text = "Rituel de bénédiction"
  },
  Lottery_116466_Name = {
    Text = "Lavage du corps"
  },
  Lottery_116466_RuleContent = {
    Text = "<Title:Introduction>\n1. Chaque échange consommera 750 « Offrande de visite » / « Rituel de confession » / « Loyauté et hommage », et vous obtiendrez aléatoirement cinq récompenses d'objets. \n2. Les récompenses d'objets pour chaque rituel sont divisées en deux types : « Objet spécial » et « Objet ordinaire ». Lors de la réinitialisation, il est possible de réinitialiser le nombre restant d'objets spécifiés à la limite. Les règles spécifiques sont : \n(1) Pour les 2 premières réinitialisations : lorsque le nombre restant d'« objets spéciaux » est épuisé, le Gardien peut choisir de réinitialiser. Après réinitialisation, le nombre restant d'« objets spéciaux » et d'« objets ordinaires » sera réinitialisé à la limite ; il peut également choisir de continuer l'échange, mais lorsque le nombre restant d'« objets ordinaires » est également épuisé, il devra procéder à la réinitialisation avant de pouvoir continuer l'échange. \n(2) À partir de la 3e réinitialisation : une réinitialisation ne peut être effectuée que lorsque le nombre restant d'« objets ordinaires » est épuisé. La réinitialisation remettra le nombre restant d'« objets ordinaires » à la limite, et les « objets spéciaux » ne seront plus réinitialisés."
  },
  Lottery_116467_Name = {
    Text = "Confession de l'Âme"
  },
  Lottery_116468_Name = {
    Text = "Précipitation des péchés"
  },
  Lottery_125044_DrawBtnText = {Text = "Offrande"},
  Lottery_125044_DrawTitle = {
    Text = "Offrande désolée"
  },
  Lottery_125044_Name = {
    Text = "Offrande désolée"
  },
  Lottery_125044_RuleContent = {
    Text = "<Title:Introduction>\n1. Chaque « Offrande » consommera 750 « Bonbons au sirop de poire » et récompensera aléatoirement cinq objets de l'« Offrande désolée ».\n2. Les objets récompensés de l'« Offrande désolée » sont divisés en « Objets spéciaux » et « Objets ordinaires ». Lors de la réinitialisation, la quantité restante d'objets spéciaux peut être réinitialisée à la limite. Les règles spécifiques sont les suivantes :\n(1) Pour les 5 premières réinitialisations : Lorsqu'il n'y a plus d'« Objets spéciaux » restants, le Gardien peut choisir de réinitialiser, ce qui réinitialisera les quantités restantes d'« Objets spéciaux » et d'« Objets ordinaires » à leurs limites ; alternativement, le Gardien peut choisir de continuer à échanger, mais lorsqu'il n'y a également plus d'« Objets ordinaires » restants, une réinitialisation doit être effectuée pour continuer à échanger.\n(2) À partir de la 6e réinitialisation : Une réinitialisation ne peut être effectuée que lorsqu'il n'y a plus d'« Objets ordinaires » restants. La réinitialisation restaurera la quantité restante d'« Objets ordinaires » à la limite, et les « Objets spéciaux » ne seront plus réinitialisés."
  },
  Lottery_126065_DrawBtnText = {
    Text = "Échange de cadeaux"
  },
  Lottery_126065_DrawTitle = {
    Text = "Boutique du théâtre"
  },
  Lottery_126065_Name = {
    Text = "Boutique du théâtre"
  },
  Lottery_126065_RuleContent = {
    Text = "<Title:Introduction>\n1. Chaque « échange de cadeaux » consommera 750 « Billet de velours » et permettra d'obtenir aléatoirement cinq récompenses parmi les objets du « Billet de velours ».\n2. Les récompenses d'objets sont divisées en « Objet spécial » et « Objet ordinaire ». Lors de la réinitialisation, il est possible de remettre à zéro le nombre restant des récompenses d'objets spéciaux à la limite, selon les règles suivantes :\n(1) Pour les 5 premières réinitialisations : lorsque le nombre restant d'« objets spéciaux » est épuisé, le Gardien peut choisir de réinitialiser. Après la réinitialisation, le nombre restant des « objets spéciaux » et « objets ordinaires » sera remis à zéro à la limite ; il peut aussi choisir de continuer à échanger. Lorsque le nombre restant d'« objets ordinaires » est également épuisé, une réinitialisation est nécessaire pour continuer l'échange.\n(2) À partir de la 6e réinitialisation et au-delà : une réinitialisation ne peut être effectuée que lorsque le nombre restant d'« objets ordinaires » est épuisé. La réinitialisation remettra le nombre restant d'« objets ordinaires » à la limite, les « objets spéciaux » ne seront plus réinitialisés."
  },
  Lottery_129914_Name = {
    Text = "Jardin de Croissance"
  },
  Lottery_129915_DrawBtnText = {
    Text = "Disperser la Poussière d'Écailles"
  },
  Lottery_129915_DrawTitle = {
    Text = "Jardin de Pissenlits"
  },
  Lottery_129915_Name = {
    Text = "Jardin de Culture"
  },
  Lottery_129915_RuleContent = {
    Text = "<Title:Introduction>\n1, Chaque échange consommera «Poussière d'Écailles Pâles»/«Poussière d'Écailles Rouges»/«Poussière d'Écailles Brillantes» × 750, et vous obtiendrez aléatoirement cinq récompenses d'objets du «Jardin de Pissenlits».\n2, Les récompenses d'objets de chaque «Jardin de Pissenlits» sont divisées en deux types : «Objet spécial» et «Objet ordinaire». Lors de la réinitialisation, il est possible de remettre la quantité restante des récompenses d'Objets spéciaux à leur maximum. Les règles spécifiques sont les suivantes :\n(1)Les 2 premières réinitialisations : lorsque les «Objets spéciaux» n'ont plus de quantité restante, le Gardien peut choisir de réinitialiser, ce qui remettra la quantité restante des «Objets spéciaux» et des «Objets ordinaires» à leur maximum ; il peut également choisir de continuer à échanger. Lorsque les «Objets ordinaires» n'ont également plus de quantité restante, une réinitialisation est nécessaire pour continuer à échanger.\n(2)À partir de la 3e réinitialisation : la réinitialisation ne peut être effectuée que lorsque les «Objets ordinaires» n'ont plus de quantité restante. La réinitialisation remettra la quantité restante des «Objets ordinaires» à leur maximum, et les «Objets spéciaux» ne seront plus réinitialisés."
  },
  Lottery_129916_Name = {
    Text = "Jardin en Fleurs"
  },
  Lottery_130578_Name = {
    Text = "Coffre numéro deux"
  },
  Lottery_130579_DrawBtnText = {
    Text = "Coquillage à remettre"
  },
  Lottery_130579_DrawTitle = {
    Text = "Trésor de Mosk"
  },
  Lottery_130579_Name = {
    Text = "Coffre numéro un"
  },
  Lottery_130579_RuleContent = {
    Text = "<Title:Introduction>\n1, Chaque échange consommera «Conque numéro un»/«Escargot de mer numéro deux»/«Coquillage marin numéro trois» × 750, et vous obtiendrez au hasard cinq objets en récompense dans «Trésor de Mosk».\n2, Chaque récompense d'objet dans «Trésor de Mosk» est divisée en deux types : «Objet spécial» et «Objet ordinaire». Lors de la réinitialisation, vous pouvez ramener le nombre restant des objets spécifiés à leur limite. Les règles spécifiques sont :\n(1) Pour les 2 premières réinitialisations : Lorsque le nombre d'«Objet spécial» est épuisé, le Gardien peut choisir de réinitialiser. Après la réinitialisation, le nombre restant d'«Objet spécial» et d'«Objet ordinaire» sera ramené à la limite ; il peut également choisir de continuer les échanges. Lorsque le nombre d'«Objet ordinaire» est également épuisé, une réinitialisation est nécessaire pour continuer les échanges.\n(2) À partir de la 3ème réinitialisation : La réinitialisation ne peut être effectuée que lorsque le nombre d'«Objet ordinaire» est épuisé. La réinitialisation ramènera le nombre restant d'«Objet ordinaire» à la limite, tandis que les «Objets spéciaux» ne seront plus réinitialisés."
  },
  Lottery_130580_Name = {
    Text = "Coffre numéro trois"
  },
  Lottery_141552_Name = {
    Text = "Bénédiction de Givre"
  },
  Lottery_141553_DrawBtnText = {
    Text = "Recevoir des Bénédictions"
  },
  Lottery_141553_DrawTitle = {
    Text = "Rituels de la Fée"
  },
  Lottery_141553_Name = {
    Text = "Bénédiction de Neige"
  },
  Lottery_141553_RuleContent = {
    Text = "<Title:Introduction>\n1. Chaque «Recevoir des Bénédictions» consommera 750 «Pomme Cramoisie»/«Pomme Dorée»/«Pomme Bonbon» pour obtenir aléatoirement cinq récompenses d'objets des «Rituels de la Fée».\n2. Les récompenses d'objets de chaque «Rituels de la Fée» sont divisées en deux types : «Objet spécial» et «Objet ordinaire». Lors d'une réinitialisation, la quantité restante des récompenses d'Objet spécial peut être réinitialisée jusqu'à la limite. Les règles spécifiques sont les suivantes :\n(1) 2 premières Réinitialisations : Lorsque les «Objets spéciaux» n'ont plus de quantité restante, les Gardiens du secret peuvent choisir de réinitialiser, ce qui remettra les quantités restantes des «Objets spéciaux» et des «Objets ordinaires» à la limite ; ou ils peuvent choisir de continuer à échanger. Lorsque les «Objets ordinaires» n'ont également plus de quantité restante, une réinitialisation doit être effectuée pour continuer à échanger.\n(2) À partir de la 3e Réinitialisation : Une réinitialisation ne peut être effectuée que lorsque les «Objets ordinaires» n'ont plus de quantité restante. La réinitialisation restaurera la quantité restante des «Objets ordinaires» à la limite, tandis que les «Objets spéciaux» ne seront plus réinitialisés."
  },
  Lottery_141554_Name = {
    Text = "Bénédiction de Blanc"
  },
  Lottery_143761_DrawBtnText = {
    Text = "Texte temporaire"
  },
  Lottery_143761_DrawTitle = {
    Text = "Texte temporaire"
  },
  Lottery_143761_Name = {
    Text = "Texte temporaire"
  },
  Lottery_143761_RuleContent = {
    Text = "<Title:Introduction>\n1, Chaque échange consommera «Temporaire»/«Temporaire»/«Temporaire» × 750 et vous permettra d'obtenir aléatoirement cinq récompenses d'objets de «Temporaire».\n2, Les récompenses d'objets de chaque «Temporaire» sont divisées en deux types : «Objet spécial» et «Objet ordinaire». Lors de la réinitialisation, il est possible de remettre la quantité restante des récompenses d'«Objet spécial» à la limite maximale. Les règles spécifiques sont les suivantes :\n(1)Les 2 premières réinitialisations : lorsque les «Objets spéciaux» n'ont plus de quantité restante, le Gardien peut choisir de réinitialiser ; après réinitialisation, la quantité restante des «Objets spéciaux» et des «Objets ordinaires» sera remise à la limite maximale. Il peut également choisir de continuer à échanger ; lorsque les «Objets ordinaires» n'ont également plus de quantité restante, une réinitialisation est nécessaire pour continuer à échanger.\n(2)À partir de la 3e réinitialisation : la réinitialisation ne peut être effectuée que lorsque les «Objets ordinaires» n'ont plus de quantité restante ; la réinitialisation remettra la quantité restante des «Objets ordinaires» à la limite maximale, et les «Objets spéciaux» ne seront plus réinitialisés."
  },
  Lottery_143762_Name = {
    Text = "Texte temporaire"
  },
  Lottery_143763_Name = {
    Text = "Texte temporaire"
  },
  Lottery_147104_Name = {
    Text = "Texte temporaire"
  },
  Lottery_147105_DrawBtnText = {
    Text = "Texte temporaire"
  },
  Lottery_147105_DrawTitle = {
    Text = "Texte temporaire"
  },
  Lottery_147105_Name = {
    Text = "Texte temporaire"
  },
  Lottery_147105_RuleContent = {
    Text = "<Title:Introduction>\n1, Chaque échange consommera «Temporaire»/«Temporaire»/«Temporaire» × 750 et vous permettra d'obtenir aléatoirement cinq récompenses d'objets de «Temporaire».\n2, Les récompenses d'objets de chaque «Temporaire» sont divisées en deux types : «Objet spécial» et «Objet ordinaire». Lors de la réinitialisation, il est possible de remettre la quantité restante des récompenses d'«Objet spécial» à la limite maximale. Les règles spécifiques sont les suivantes :\n(1)Les 2 premières réinitialisations : lorsque les «Objets spéciaux» n'ont plus de quantité restante, le Gardien peut choisir de réinitialiser ; après réinitialisation, la quantité restante des «Objets spéciaux» et des «Objets ordinaires» sera remise à la limite maximale. Il peut également choisir de continuer à échanger ; lorsque les «Objets ordinaires» n'ont également plus de quantité restante, une réinitialisation est nécessaire pour continuer à échanger.\n(2)À partir de la 3e réinitialisation : la réinitialisation ne peut être effectuée que lorsque les «Objets ordinaires» n'ont plus de quantité restante ; la réinitialisation remettra la quantité restante des «Objets ordinaires» à la limite maximale, et les «Objets spéciaux» ne seront plus réinitialisés."
  },
  Lottery_147106_Name = {
    Text = "Texte temporaire"
  },
  Lottery_44279_DrawBtnText = {
    Text = "Échanger des objets"
  },
  Lottery_44279_DrawTitle = {
    Text = "Salle de vente de l'église"
  },
  Lottery_44279_Name = {
    Text = "La boutique de Mme Grey"
  },
  Lottery_44279_RuleContent = {
    Text = "<Title:Introduction>\n· Bienvenue à tous les Gardiens au \"Vente de Charité de l'Église\"! Ici, vous pouvez utiliser des \"Coupons de Charité\" pour échanger des biens dans les boutiques. Un nombre limité de SR Roue du Destin \"Homme au Miroir\", Cœur Pur, Graine Pure et d'autres articles vous attendent pour votre échange!\n\n<Title:Shops>\n1. La Vente de Charité de l'Église propose trois boutiques avec les horaires d'ouverture suivants:\n· Boutique \"La Petite Boutique de Mme Gray\": Ouvre initialement.\n· Boutique \"La Charité Magique de John\": Ouvre le 4ème jour de l'événement.\n· Boutique \"Les Affaires de Smith\": Ouvre le 7ème jour de l'événement.\n2. Différentes boutiques offrent différents articles, et les Gardiens peuvent choisir des articles selon leurs besoins pour l'échange.\n3. Chaque boutique contient des articles spéciaux et ordinaires. Chaque échange consommera 600 \"Coupons de Charité\", attribuant au hasard cinq articles de la boutique.\n\n<Title:Restocking>\n1. Lorsque tous les articles spéciaux dans une boutique ont été échangés, le Gardien peut demander à la boutique de se réapprovisionner ou choisir de continuer à échanger. Lorsque tous les articles de la boutique ont été échangés, le Gardien doit choisir de se réapprovisionner avant de continuer à échanger.\n2. Pour les deux premières réapprovisionnements dans chaque boutique, les quantités restantes de tous les articles seront recomplétées jusqu'à la limite maximale. À partir du troisième réapprovisionnement, les articles spéciaux ne seront plus recomplétés, seuls les articles ordinaires seront réapprovisionnés. Après le réapprovisionnement, les quantités restantes des articles non échangés précédemment ne seront pas conservées. Par conséquent, les Gardiens doivent réfléchir attentivement avant de choisir de se réapprovisionner!\n\n"
  },
  Lottery_44280_Name = {
    Text = "Vente spéciale de Smith"
  },
  Lottery_44281_Name = {
    Text = "La vente magique de Big John"
  },
  Lottery_48730_DrawBtnText = {
    Text = "Échange de noyau de graine"
  },
  Lottery_48730_DrawTitle = {
    Text = "Prolifération du désir"
  },
  Lottery_48730_Name = {
    Text = "Prolifération du désir"
  },
  Lottery_48730_RuleContent = {
    Text = "<Title:Introduction>\n1. Chaque « Échange de graine mère » consomme 750 « Graine mère » et donne aléatoirement cinq récompenses de « Prolifération du désir ». \n2. Les récompenses de « Prolifération du désir » se divisent en deux types : « Objet spécial » et « Objet ordinaire ». La rétroaction permet de réinitialiser la quantité restante des « Objet spécial » à la limite maximale. Les règles détaillées sont les suivantes : \n(1) Lors des 4 premières rétroactions : lorsque la quantité restante des « Objet spécial » est épuisée, le Gardien peut choisir d'effectuer une rétroaction. Après la rétroaction, la quantité restante des « Objet spécial » et des « Objet ordinaire » sera réinitialisée à la limite maximale. Il est également possible de continuer l'échange. Lorsque la quantité restante des « Objet ordinaire » est également épuisée, une rétroaction sera nécessaire pour continuer les échanges. \n(2) À partir de la 5e rétroaction : la rétroaction ne peut être effectuée qu'après l'épuisement de la quantité restante des « Objet ordinaire ». La rétroaction réinitialisera la quantité restante des « Objet ordinaire » à la limite maximale, tandis que les « Objet spécial » ne seront plus réinitialisés."
  },
  Lottery_52046_Name = {
    Text = "Autel des âmes"
  },
  Lottery_52047_Name = {
    Text = "Autel de sang"
  },
  Lottery_52048_DrawBtnText = {
    Text = "Offrir un Sacrifice"
  },
  Lottery_52048_DrawTitle = {
    Text = "Réponse de l'Abyss"
  },
  Lottery_52048_Name = {
    Text = "Autel des larmes"
  },
  Lottery_52048_RuleContent = {
    Text = "<Title:Introduction>\n1. \"Réponse de l'Abysse\" a trois autels avec les horaires d'ouverture suivants :\n· \"Autel d'Erin\" : 17 juin, 9h00 ~ 8 juillet, 9h00.\n· \"Autel de Sang\" : 19 juin, 9h00 ~ 8 juillet, 9h00.\n· \"Autel de l'Âme\" : 21 juin, 9h00 ~ 8 juillet, 9h00.\n2. Chaque offrande consomme 500 \"Larmes Sacrificielles\"/\"Sang Sacrificiel\"/\"Moëlle Sacrificielle\", octroyant cinq récompenses aléatoires de l'autel.\n3. Les récompenses d'objet de chaque autel sont divisées en \"Cadeaux du Royaume de Dieu\" et \"Récompenses Banales\". Lors des réinitialisations, la quantité restante de récompenses d'objet spécifiées peut être réinitialisée à la limite maximale selon les règles suivantes :\n(1) Pour les deux premières réinitialisations : Lorsque les \"Cadeaux du Royaume de Dieu\" n'ont plus de quantité restante, le Gardien peut choisir de réinitialiser. Après la réinitialisation, tant les \"Cadeaux du Royaume de Dieu\" que les \"Récompenses Banales\" verront leurs quantités restantes réinitialisées à la limite maximale. Alternativement, le Gardien peut continuer à offrir, mais lorsque les \"Récompenses Banales\" n'ont également plus de quantité restante, une réinitialisation est requise pour continuer à offrir.\n(2) À partir de la troisième réinitialisation : La réinitialisation n'est possible que lorsque les \"Récompenses Banales\" n'ont plus de quantité restante. La réinitialisation remettra la quantité restante des \"Récompenses Banales\" à la limite maximale, tandis que les \"Cadeaux du Royaume de Dieu\" ne seront plus réinitialisés."
  },
  Lottery_55169_DrawBtnText = {
    Text = "Échange de poèmes"
  },
  Lottery_55169_DrawTitle = {
    Text = "La maison de fleurs de Colette"
  },
  Lottery_55169_Name = {
    Text = "Jardin des iris"
  },
  Lottery_55169_RuleContent = {
    Text = "<Title:Introduction>\n1, «La maison de fleurs de Colette» possède trois parterres de fleurs, dont les horaires d'ouverture sont les suivants :\n·«Parterre d'iris» : ouverture le 10 août à 9h.\n·«Parterre de campanules» : ouverture le 12 août à 9h.\n·«Parterre de roses» : ouverture le 14 août à 9h.\n2, Chaque échange consommera 750 «poésie mélancolique»/«Poème de Regret»/«Poème joyeux» et vous permettra d'obtenir aléatoirement cinq récompenses d'objets du parterre de fleurs.\n3, Les récompenses d'objets de chaque parterre de fleurs sont divisées en deux types : «Objet spécial» et «Objet ordinaire». Lors de la réinitialisation, il est possible de remettre la quantité restante des récompenses d'«Objet spécial» à la limite maximale. Les règles spécifiques sont les suivantes :\n(1)Les 2 premières réinitialisations : lorsque les «Objets spéciaux» n'ont plus de quantité restante, le Gardien peut choisir de réinitialiser ; après réinitialisation, la quantité restante des «Objets spéciaux» et des «Objets ordinaires» sera remise à la limite maximale. Il peut également choisir de continuer à échanger ; lorsque les «Objets ordinaires» n'ont également plus de quantité restante, une réinitialisation est nécessaire pour continuer à échanger.\n(2)À partir de la 3e réinitialisation : la réinitialisation ne peut être effectuée que lorsque les «Objets ordinaires» n'ont plus de quantité restante ; la réinitialisation remettra la quantité restante des «Objets ordinaires» à la limite maximale, et les «Objets spéciaux» ne seront plus réinitialisés.\n4, Après le 14 septembre à 9:00(GMT+8), les «Poèmes» restants non échangés seront récupérés au taux de «Billet Rose Dorée*40» par unité. Veuillez, Gardien, penser à vérifier vos e-mails."
  },
  Lottery_55170_Name = {
    Text = "Parterre de Kikyo"
  },
  Lottery_55171_Name = {
    Text = "Jardin de roses"
  },
  Lottery_58139_Name = {
    Text = "Vente spéciale de Smith"
  },
  Lottery_58140_Name = {
    Text = "La vente magique de Big John"
  },
  Lottery_58141_DrawBtnText = {
    Text = "Échanger des objets"
  },
  Lottery_58141_DrawTitle = {
    Text = "Salle de vente de l'église"
  },
  Lottery_58141_Name = {
    Text = "La boutique de Mme Grey"
  },
  Lottery_58141_RuleContent = {
    Text = "<Title:Présentation>\n1. Il y a trois magasins au total dans « Vente de charité au sanctuaire », avec les horaires d'ouverture suivants :\n· « La petite boutique de Madame Grey » : ouverture le 24 mars à 9h ;\n· « La vente de charité extraordinaire de Grand John » : ouverture le 27 mars à 9h ;\n· « La vente spéciale de Smith » : ouverture le 30 mars à 9h.\n2. Chaque échange consomme 750 « Bons de charité » et permet d'obtenir aléatoirement 5 récompenses parmi celles proposées par le magasin.\n3. Les récompenses des magasins sont divisées en deux catégories : « Objets spéciaux » et « Objets ordinaires ». Une réinitialisation permet de restaurer la quantité restante d'objets spéciaux jusqu'à la limite maximale. Les règles détaillées sont les suivantes :\n(1) Lors des 2 premières réinitialisations : lorsque la quantité restante d'« Objets spéciaux » arrive à zéro, le Gardien peut choisir de faire une réinitialisation, ce qui restaurera la quantité restante d'« Objets spéciaux » et d'« Objets ordinaires » jusqu'à leurs limites maximales ; il peut aussi choisir de continuer à échanger, et une réinitialisation sera nécessaire uniquement lorsque la quantité restante d'« Objets ordinaires » arrive également à zéro pour pouvoir continuer les échanges ;\n(2) À partir de la 3e réinitialisation : la réinitialisation ne pourra être effectuée que lorsque la quantité restante d'« Objets ordinaires » sera épuisée. La réinitialisation restaurera la quantité restante d'« Objets ordinaires » jusqu'à la limite maximale, mais les « Objets spéciaux » ne seront plus réinitialisés."
  },
  Lottery_58889_DrawBtnText = {
    Text = "Offrir un Sacrifice"
  },
  Lottery_58889_DrawTitle = {
    Text = "Réponse de l'Abyss"
  },
  Lottery_58889_Name = {
    Text = "Autel des larmes"
  },
  Lottery_58889_RuleContent = {
    Text = "<Title:Introduction>\n1. « L'Abîme Répond » présente trois autels, avec les horaires d'ouverture suivants :\n· « Autel des Larmes » : Ouverture le 9 mars à 9h.\n· « Autel de Sang » : Ouverture le 11 mars à 9h.\n· « Autel des Âmes » : Ouverture le 13 mars à 9h.\n2. Chaque offrande consommera 750 « Larmes Sacrificielles »/« Sang Sacrificiel »/« Moelle Sacrificielle » et récompensera aléatoirement cinq objets de l'autel.\n3. Les récompenses d'objets de chaque autel sont divisées en « Objets Spéciaux » et « Objets Ordinaires ». Lors de la réinitialisation, vous pouvez réinitialiser la quantité restante des récompenses d'objets spécifiés à la limite maximale. Les règles spécifiques sont les suivantes :\n(1) Pour les trois premières réinitialisations : Lorsque aucun « Objet Spécial » n'est restant, le Gardien peut choisir de réinitialiser. Après la réinitialisation, les quantités restantes des « Objets Spéciaux » et « Objets Ordinaires » seront réinitialisées à la limite maximale ; alternativement, le Gardien peut choisir de continuer à offrir des objets. Lorsque aucune quantité d'« Objets Ordinaires » n'est restante, une réinitialisation doit être effectuée pour continuer à offrir des objets.\n(2) À partir de la quatrième réinitialisation : Une réinitialisation ne peut être effectuée que lorsque aucune quantité d'« Objets Ordinaires » n'est restante, ce qui réinitialisera la quantité restante d'« Objets Ordinaires » à la limite maximale, tandis que les « Objets Spéciaux » ne seront plus réinitialisés."
  },
  Lottery_58890_Name = {
    Text = "Autel des âmes"
  },
  Lottery_58891_Name = {
    Text = "Autel de sang"
  },
  Lottery_62136_DrawBtnText = {
    Text = "Échange de bourgeons"
  },
  Lottery_62136_DrawTitle = {
    Text = "Gueule de la montagne"
  },
  Lottery_62136_Name = {
    Text = "Ambition insatiable"
  },
  Lottery_62136_RuleContent = {
    Text = "<Title:Introduction>\n1, «Gueule de la montagne» possède trois boutiques d'échange, dont les horaires d'ouverture sont les suivants :\n·«Ambition dévorante» : ouverture le 13 juillet à 9h.\n·«Esprit de vengeance» : ouverture le 15 juillet à 9h.\n·«Espoir de régénération» : ouverture le 17 juillet à 9h.\n2, Chaque échange consommera 750 «Bouton de fleur gelé»/«Bouton de fleur d'argent givré»/«Bouton de soleil» et vous permettra d'obtenir aléatoirement cinq récompenses d'objets de la boutique d'échange.\n3, Les récompenses d'objets de chaque boutique d'échange sont divisées en deux types : «Objet spécial» et «Objet ordinaire». Lors de la réinitialisation, il est possible de remettre la quantité restante des récompenses d'«Objet spécial» à la limite maximale. Les règles spécifiques sont les suivantes :\n(1)Les 2 premières réinitialisations : lorsque les «Objets spéciaux» n'ont plus de quantité restante, le Gardien peut choisir de réinitialiser ; après réinitialisation, la quantité restante des «Objets spéciaux» et des «Objets ordinaires» sera remise à la limite maximale. Il peut également choisir de continuer à échanger ; lorsque les «Objets ordinaires» n'ont également plus de quantité restante, une réinitialisation est nécessaire pour continuer à échanger.\n(2)À partir de la 3e réinitialisation : la réinitialisation ne peut être effectuée que lorsque les «Objets ordinaires» n'ont plus de quantité restante ; la réinitialisation remettra la quantité restante des «Objets ordinaires» à la limite maximale, et les «Objets spéciaux» ne seront plus réinitialisés.\n4, Après le 17 août à 9:00(GMT+8), les «Boutons de fleur» restants non échangés seront récupérés au taux de «Billet Rose Dorée*40» par unité. Veuillez, Gardien, penser à vérifier vos e-mails."
  },
  Lottery_62137_Name = {
    Text = "Fureur de vengeance"
  },
  Lottery_62138_Name = {
    Text = "Espoir de résurrection"
  },
  Lottery_71333_DrawBtnText = {
    Text = "Échange de pièces"
  },
  Lottery_71333_DrawTitle = {
    Text = "Conseils des aînés"
  },
  Lottery_71333_Name = {
    Text = "Conseils des aînés"
  },
  Lottery_71333_RuleContent = {
    Text = "<Title:Introduction>\n1. Chaque « Échange de pièces » consomme 750 « Pièces de pantin » et récompense aléatoirement cinq objets parmi « L'enseignement des aînés ».\n2. Les récompenses d'objets de « L'enseignement des aînés » se divisent en deux catégories : « objets spéciaux » et « objets ordinaires ». Une réinitialisation permet de restaurer la quantité restante des objets spéciaux à la limite maximale. Les règles détaillées sont les suivantes :\n(1) Les 5 premières réinitialisations : lorsque la quantité restante des « objets spéciaux » est épuisée, le Gardien du Secret peut choisir de réinitialiser, ce qui remettra la quantité restante des « objets spéciaux » et des « objets ordinaires » à leur limite maximale ; il peut aussi choisir de continuer les échanges, et devra effectuer une réinitialisation uniquement lorsque la quantité restante des « objets ordinaires » est également épuisée pour pouvoir continuer les échanges.\n(2) À partir de la 6e réinitialisation : la réinitialisation ne pourra être effectuée qu'après l'épuisement de la quantité restante des « objets ordinaires ». La réinitialisation remettra la quantité restante des « objets ordinaires » à leur limite maximale, mais les « objets spéciaux » ne seront plus réinitialisés."
  },
  Lottery_76317_Name = {
    Text = "Trésors précieux"
  },
  Lottery_76318_Name = {
    Text = "Trésor splendide"
  },
  Lottery_76319_DrawBtnText = {
    Text = "Échanger des objets"
  },
  Lottery_76319_DrawTitle = {
    Text = "Trésors cachés de la sorcière"
  },
  Lottery_76319_Name = {
    Text = "Produit réconfortant"
  },
  Lottery_76319_RuleContent = {
    Text = "<Title:Présentation>\n1. Chaque échange consomme 750 « Crânes de Bêtes pâles » / « Crânes de Bêtes ombreuses » / « Crânes de Bêtes vermillon », et récompense aléatoirement cinq objets parmi ceux du trésor.\n2. Les récompenses des trésors se divisent en deux catégories : les « objets spéciaux » et les « objets ordinaires ». Une réinitialisation permet de restaurer la quantité restante des objets récompenses à leur limite maximale. Les règles détaillées sont les suivantes :\n(1) Lors des 2 premières réinitialisations : lorsque les « objets spéciaux » n'ont plus de quantité disponible, le gardien peut choisir de réinitialiser, ce qui restaurera la quantité restante des « objets spéciaux » et des « objets ordinaires » à leur limite maximale. Il peut aussi choisir de continuer à échanger, mais une fois que les « objets ordinaires » n'ont plus de quantité disponible, il faudra effectuer une réinitialisation pour continuer les échanges.\n(2) À partir de la 3e réinitialisation : la réinitialisation ne pourra être effectuée qu'après épuisement des « objets ordinaires ». Elle restaurera la quantité restante des « objets ordinaires » à leur limite maximale, tandis que les « objets spéciaux » ne seront plus réinitialisés."
  },
  Lottery_79567_DrawBtnText = {
    Text = "Soumettre le rapport"
  },
  Lottery_79567_DrawTitle = {
    Text = "Service de traitement neurologique"
  },
  Lottery_79567_Name = {
    Text = "Service de traitement neurologique"
  },
  Lottery_79567_RuleContent = {
    Text = "<Title:Présentation>\n1. Chaque « soumission de rapport » consomme 1000 « rapports de diagnostic » et permet d'obtenir aléatoirement une récompense parmi cinq objets présents dans la « salle de traitement neurologique ».\n2. Les récompenses de la « salle de traitement neurologique » se divisent en deux catégories : les « objets spéciaux » et les « objets ordinaires ». La réinitialisation permet de restaurer la quantité restante des « objets spéciaux » jusqu'à la limite maximale. Les règles détaillées sont les suivantes :\n(1) Les 5 premières réinitialisations : lorsque la quantité restante d'« objets spéciaux » est épuisée, le gardien peut choisir de les réinitialiser. Après la réinitialisation, la quantité restante des « objets spéciaux » et des « objets ordinaires » sera restaurée à la limite maximale. Il est également possible de choisir de continuer les échanges. Toutefois, lorsque la quantité restante des « objets ordinaires » est également épuisée, il sera nécessaire de réaliser une réinitialisation avant de pouvoir continuer les échanges.\n(2) À partir de la 6e réinitialisation et suivantes : la réinitialisation ne peut être effectuée que lorsque la quantité restante des « objets ordinaires » est épuisée. Après la réinitialisation, la quantité restante des « objets ordinaires » sera restaurée à la limite maximale, tandis que les « objets spéciaux » ne seront plus réinitialisés."
  },
  Lottery_81263_DrawBtnText = {
    Text = "Drapeau de signalisation"
  },
  Lottery_81263_DrawTitle = {
    Text = "Trésor de l'équipage"
  },
  Lottery_81263_Name = {
    Text = "Trésor de l'équipage"
  },
  Lottery_81263_RuleContent = {
    Text = "<Title:Présentation>\n1. Chaque « livraison du drapeau » consomme 750 « drapeaux de signalisation » et récompense aléatoirement 5 objets parmi les « Trésors de l'équipage ».\n2. Les récompenses des « Trésors de l'équipage » se divisent en deux catégories : « objets spéciaux » et « objets ordinaires ». La réinitialisation permet de restaurer la quantité restante des objets spéciaux jusqu'à la limite maximale. Les règles détaillées sont les suivantes :\n(1) Lors des 5 premières réinitialisations : lorsque la quantité restante des « objets spéciaux » est épuisée, le Gardien du Secret peut choisir de les réinitialiser. Après la réinitialisation, la quantité restante des « objets spéciaux » et des « objets ordinaires » sera restaurée à la limite maximale. Il est aussi possible de continuer l'échange. Toutefois, lorsque la quantité des « objets ordinaires » est également épuisée, une réinitialisation sera nécessaire avant de pouvoir continuer les échanges.\n(2) À partir de la 6e réinitialisation et au-delà : la réinitialisation ne pourra être effectuée qu'après l'épuisement des « objets ordinaires ». La réinitialisation restaurera la quantité restante des « objets ordinaires » à la limite maximale, mais les « objets spéciaux » ne seront plus réinitialisés."
  },
  Lottery_95604_DrawBtnText = {
    Text = "Échanger des plats"
  },
  Lottery_95604_DrawTitle = {
    Text = "Salle à manger du palais royal"
  },
  Lottery_95604_Name = {
    Text = "Salle à manger du palais royal"
  },
  Lottery_95604_RuleContent = {
    Text = "<Title:Présentation>\n1. Chaque « échange de plats » consomme 750 « os de main corrompus » et donne aléatoirement une récompense parmi les cinq objets disponibles au « Restaurant de la Résidence Royale ».\n2. Les récompenses du « Restaurant de la Résidence Royale » se divisent en deux catégories : les « objets spéciaux » et les « objets ordinaires ». La réinitialisation permet de restaurer la quantité restante des objets spéciaux jusqu'à la limite maximale. Les règles détaillées sont les suivantes :\n(1) Lors des 5 premières réinitialisations : lorsque les « objets spéciaux » n'ont plus de quantité disponible, le Gardien peut choisir de faire une réinitialisation, ce qui restaurera la quantité disponible des « objets spéciaux » et des « objets ordinaires » jusqu'à leurs limites maximales respectives ; il peut également choisir de continuer à échanger, et une fois que les « objets ordinaires » n'ont plus de quantité disponible non plus, une réinitialisation sera nécessaire pour continuer les échanges.\n(2) À partir de la 6e réinitialisation : la réinitialisation ne pourra être effectuée que lorsque les « objets ordinaires » n'auront plus de quantité disponible. La réinitialisation restaurera la quantité disponible des « objets ordinaires » jusqu'à la limite maximale, mais les « objets spéciaux » ne seront plus réinitialisés."
  },
  Lottery_96822_DrawBtnText = {
    Text = "Acquisition de matériel de peinture"
  },
  Lottery_96822_DrawTitle = {
    Text = "L'atelier de Pickman"
  },
  Lottery_96822_Name = {
    Text = "Atelier de la réalité"
  },
  Lottery_96822_RuleContent = {
    Text = "<Title:Introduction>\n1. Chaque échange consommera 750 « Teinture de vérité » / « Teinture de rêve » / « Teinture de folie », et vous obtiendrez aléatoirement cinq récompenses d'objets dans l'atelier. \n2. Les récompenses d'objets de chaque atelier sont divisées en deux types : « objets spéciaux » et « objets ordinaires ». Lors de la réinitialisation, il est possible de remettre à zéro le nombre restant d'objets spécifiques à la limite, les règles spécifiques sont les suivantes : \n(1) Pour les 2 premières réinitialisations : lorsque le nombre d'« objets spéciaux » est épuisé, le gardien peut choisir de réinitialiser. Après réinitialisation, le nombre restant d'« objets spéciaux » et d'« objets ordinaires » sera remis à la limite ; il peut aussi choisir de continuer l'échange. Lorsque le nombre d'« objets ordinaires » est également épuisé, une réinitialisation est nécessaire pour continuer l'échange. \n(2) À partir de la 3e réinitialisation : la réinitialisation ne peut être effectuée que lorsque le nombre d'« objets ordinaires » est épuisé. La réinitialisation remettra à zéro le nombre restant d'« objets ordinaires » à la limite, et les « objets spéciaux » ne seront plus réinitialisés."
  },
  Lottery_96823_Name = {
    Text = "Atelier de rêve fantomal"
  },
  Lottery_96824_Name = {
    Text = "Atelier de Folie"
  },
  Lottery_97424_Name = {
    Text = "Texte temporaire"
  },
  Lottery_97425_Name = {
    Text = "Texte temporaire"
  },
  Lottery_97426_DrawBtnText = {
    Text = "Texte temporaire"
  },
  Lottery_97426_DrawTitle = {
    Text = "Texte temporaire"
  },
  Lottery_97426_Name = {
    Text = "Texte temporaire"
  },
  Lottery_97426_RuleContent = {
    Text = "<Title:Présentation>\n1. Chaque échange consomme 750 « Textes temporaires » / « Textes temporaires » / « Textes temporaires », et permet d'obtenir aléatoirement cinq objets parmi ceux du trésor. \n2. Les récompenses des trésors se divisent en deux catégories : les « objets spéciaux » et les « objets ordinaires ». La réinitialisation permet de rétablir la quantité restante des récompenses d'objets spécifiques à leur limite maximale. Les règles détaillées sont les suivantes : \n(1) Lors des 2 premières réinitialisations : lorsque les « objets spéciaux » n'ont plus de quantité disponible, le gardien peut choisir de réinitialiser. Après réinitialisation, la quantité restante des « objets spéciaux » et des « objets ordinaires » sera réinitialisée à la limite maximale. Il est également possible de choisir de continuer l'échange, mais lorsque les « objets ordinaires » n'ont plus de quantité disponible, une réinitialisation sera nécessaire pour continuer les échanges. \n(2) À partir de la 3e réinitialisation : la réinitialisation ne pourra être effectuée que lorsque les « objets ordinaires » n'auront plus de quantité disponible. La réinitialisation rétablira la quantité restante des « objets ordinaires » à la limite maximale, tandis que les « objets spéciaux » ne seront plus réinitialisés."
  }
})
return Text_Lottery
