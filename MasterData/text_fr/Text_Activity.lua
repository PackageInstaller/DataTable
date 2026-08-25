__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Activity = readonly({
  Activity_100432_ActivityName = {
    Text = "Shaggai hypnotique"
  },
  Activity_100432_ActivityTips = {
    Text = "<Title:Règlement de l'événement>\n· Pendant l'événement « Hypno-Insecte », le Gardien peut utiliser des équipes prédéfinies contenant Clementine pour vivre une expérience illimitée des niveaux spécifiés. \n· Lors de l'expérience des niveaux de l'événement, il n'est pas possible d'ajuster les Éveilleurs dans l'escouade. \n<Title:Récompenses de l'événement>\n· Après avoir réussi le défi du niveau pour la première fois, vous pouvez réclamer des récompenses de test sur l'interface de l'événement."
  },
  Activity_100433_ActivityName = {
    Text = "Bishop de baumes"
  },
  Activity_100433_ActivityTips = {
    Text = "<Title:Règles de l'activité>\n·Pendant l'événement \"Évêque Bienveillant\", les Gardiens peuvent utiliser des équipes prédéfinies par le système contenant Salvador pour expérimenter des niveaux désignés un nombre illimité de fois.\n·Lors de la réalisation des niveaux d'événement, des ajustements au Réveiller dans la composition de l'équipe ne peuvent pas être effectués.\n<Title:Récompenses de l'activité>\n·Après avoir réussi un défi de niveau pour la première fois, vous pouvez réclamer des récompenses d'essai depuis l'interface de l'événement."
  },
  Activity_116469_ActivityName = {
    Text = "Événement de déblocage gratuit"
  },
  Activity_116470_ActivityName = {
    Text = "Nuit polaire éternelle"
  },
  Activity_116470_ActivityPlot = {
    Text = "Ils se frôlèrent à la fin du destin, l'horloge qui avait été redémarrée était déjà trop tard, et seul ce cœur rempli de remords jura d'illuminer toute la saleté dans les ténèbres."
  },
  Activity_116470_ActivityStageEndContent = {
    Text = "Événement terminé, participation actuelle uniquement à « Rituel de bénédiction »"
  },
  Activity_116470_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, le Gardien peut collecter des monnaies d'événement « Offrande de visite », « Rituel de confession » et « Loyauté et hommage » via les modes de jeu temporaires « Sang de douleur mêlé » et « Récompenses de succès ». Ces monnaies peuvent être utilisées pour acheter des articles dans le « Rituel de bénédiction », y compris la Roue du Destin SR limitée de l'événement « Pollux SR (Texte temporaire) », Cœur de Lumens, Cœur Immaculé, etc. \n2. Pendant l'événement, « Monde des Rêves Étranges : Au-delà de l'horizon·bas » sera déverrouillé gratuitement pendant une période limitée. En complétant les succès de l'événement, vous pourrez également obtenir l'avatar limité de l'événement « Au nom de la Clé d'argent : Pollux » !\n\n<Title:Durée de l'événement>\n1. Du 20 octobre à 9h00 au 3 novembre à 9h00 (GMT+8), tous les modes de jeu sont accessibles. \n2. Du 3 novembre à 9h00 au 10 novembre à 9h00 (GMT+8), seuls le « Rituel de bénédiction » et les récompenses de succès sont accessibles. \n\n<Title:Sang de douleur mêlé>\n1. « Sang de douleur mêlé » comprend 7 niveaux, un niveau s'ouvrant automatiquement chaque jour. \n2. Chaque défi consommera 120 points de Ménophine, et un défi réussi permettra de gagner des monnaies d'événement. \n3. Après avoir terminé un niveau, la fonction « Reproduire » de ce niveau sera déverrouillée. Veuillez noter : en utilisant la fonction « Reproduire », vous ne pourrez pas gagner de taux de synchronisation. \n4. Vous pouvez utiliser l'aide des anciens pour vous faciliter la tâche. \n\n<Title:Vortex des souvenirs>\n Après le début de l'événement, vous recevrez automatiquement 60 « Offrande de visite » chaque heure, jusqu'à un maximum de 25 heures. \n\n<Title:Rituel de bénédiction>\n1. Le « Rituel de bénédiction » comprend trois magasins, dont les horaires d'ouverture sont les suivants :\n« Lavage du corps » : Ouverture le 20 octobre à 9h. \n« Confession de l'Âme » : Ouverture le 21 octobre à 9h. \n« Précipitation des péchés » : Ouverture le 22 octobre à 9h. \n2. Chaque échange coûtera 750 « Offrande de visite » / « Rituel de confession » / « Loyauté et hommage », et vous recevrez aléatoirement cinq récompenses d'objets dans le studio. \n3. Les récompenses d'objets de chaque studio sont divisées en « Objet spécial » et « Objet ordinaire ». Lors de la réinitialisation, vous pouvez réinitialiser la quantité restante d'objets spéciaux à son maximum. Les règles spécifiques sont les suivantes : \n(1) Pour les deux premières réinitialisations : lorsque les « Objet spécial » n'ont plus de quantité restante, le Gardien peut choisir de réinitialiser, ce qui remettra la quantité restante des « Objet spécial » et « Objet ordinaire » à son maximum ; il peut également choisir de continuer à échanger. Lorsque les « Objet ordinaire » n'ont plus de quantité restante, une réinitialisation est nécessaire pour continuer à échanger. \n(2) À partir de la troisième réinitialisation : vous ne pouvez réinitialiser que lorsque les « Objet ordinaire » n'ont plus de quantité restante. La réinitialisation remettra la quantité restante des « Objet ordinaire » à son maximum, mais les « Objet spécial » ne seront plus réinitialisés. \n\n<Title:Bonus d'événement>\n1. Les Gardiens du secret possédant un Corps éveillé ou une Roue du Destin spécifique (pas nécessaire d'être sur le terrain) peuvent obtenir un bonus supplémentaire de chute pour les « Offrande de visite », « Rituel de confession » et « Loyauté et hommage » dans les récompenses des missions des niveaux « Sang de douleur mêlé », comme suit : \nCorps éveillé « Pollux » : Dégagement 0/1/2/3 et plus, bonus de 20%/30%/40%/50%. \nRoue du Destin SSR « Pollux » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%. \nRoue du Destin SR « Pollux SR (Texte temporaire) » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%. \n2. Les « bonus d'événement » des différents Corps éveillés ou Roues du Destin s'additionnent. \n3. De manière spéciale, les récompenses de défi de première réussite en difficulté Folie ne seront pas affectées par les « bonus d'événement ». \n\n<Title:Monde des Rêves Étranges>\n1. Pendant l'événement, « Monde des Rêves Étranges : Au-delà de l'horizon·bas » peut être déverrouillé gratuitement. \n2. Après la fin de l'événement, la progression de l'enquête dans « Monde des Rêves Étranges : Au-delà de l'horizon·bas » sera conservée, et en complétant les enquêtes non terminées pendant l'événement, vous pourrez également obtenir des récompenses d'enquête identiques à celles de la période de l'événement. Si « Monde des Rêves Étranges : Au-delà de l'horizon·bas » n'a pas été déverrouillé pendant l'événement, vous pourrez toujours le déverrouiller après la fin de l'événement en consommant « Point de départ réel » *7. \n3. Que vous soyez pendant ou en dehors de l'événement, après avoir terminé « Monde des Rêves Étranges : Au-delà de l'horizon·bas », vous recevrez « Décret Clé : Cœur sacré de sang »."
  },
  Activity_116470_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_116765_ActivityName = {
    Text = "Départ de la gravure"
  },
  Activity_116765_ActivityTips = {
    Text = "Règles de l'événement :\n1. Après avoir terminé les missions désignées, le Gardien peut réclamer des récompenses dans « Voyage gravé ».\n2. Après avoir déverrouillé les « Archives Avancées », des récompenses supplémentaires peuvent être obtenues après avoir complété les missions.\n3. L'achat de cette « Archives Avancées » est limité dans le temps, et ne pourra plus être effectué après la date limite. Les Gardiens du secret sont invités à acheter avant le 3 novembre à 9h00.\n4. Veuillez noter : les « Archives Avancées » déverrouillées dans le cadre de cette activité ne sont valables que pendant la durée de l'événement. Les Gardiens du secret sont invités à consommer de manière raisonnable."
  },
  Activity_116765_BannerText = {
    Text = "Événement spécial Chronologie à durée limitée !"
  },
  Activity_116818_ActivityName = {
    Text = "Reprendre le combat originel"
  },
  Activity_116818_ActivityPlot = {
    Text = "«Étoiles» sont ses yeux, observant ou plutôt surveillant tout ce qui se passe dans le monde à sa place. \n Tu pensais avoir échappé à son regard, mais en réalité — tu es toujours dans son rêve. \n «Je t'ai attrapé —» \n Au moment de te capturer, les étoiles poussèrent un soupir de satisfaction."
  },
  Activity_116818_ActivityStageEndContent = {
    Text = "Événement terminé"
  },
  Activity_116818_ActivityTips = {
    Text = "<Title: Reprendre le combat originel>\n·«Reprendre le combat originel» comprend 7 niveaux non reproductibles, défiant directement la Vue originelle des étoiles. Un niveau sera ouvert les deux premiers jours de l'événement, 3 niveaux le troisième jour, puis 1 niveau chaque jour pendant les deux jours suivants.\n·Chaque fois que vous vainquez la Vue originelle des étoiles correspondante, vous recevrez la récompense associée.\n·Chaque type de Vue originelle des étoiles a de nombreuses copies. Chaque fois qu'un Gardien réussit à vaincre un type de Vue originelle des étoiles, le « nombre résiduel » de ce type diminuera de 1. Lorsque ce type de Vue originelle des étoiles est éliminé, le niveau correspondant sera fermé et ne pourra plus être défié.\n·Chaque niveau offrira différentes Reliques, qui vous fourniront de puissants bonus.\n·Tous les niveaux doivent choisir un soutien. Pendant l'événement, chaque Gardien qui se suit mutuellement ne peut fournir un soutien qu'une seule fois. En raison de l'utilisation du soutien, le taux de synchronisation des récompenses sera augmenté de 50% par rapport à la base.\n·Chaque jour, chaque Éveilleur, Roue du Destin et Décret Clé ne peut participer qu'une seule fois.\n·Pendant l'événement, l'enregistrement de la task force « Cantique des Étoiles » sera déverrouillé gratuitement et sans conditions préalables ! Après la fin de l'événement « Reprendre le combat originel », vous devrez d'abord compléter « Mission d'enquête - Chapitre des Étoiles - Quatrième chapitre » pour déverrouiller l'enregistrement de la task force « Cantique des Étoiles ».\n\n<Title: Compensation de niveau>\n·Il existe un mécanisme de compensation de niveau dans « Reprendre le combat originel », afin que tous les Gardiens du secret puissent combattre ensemble !\nLes règles de compensation de niveau sont les suivantes :\n  ·Dans l'équipe d'enquête, les Éveilleurs de niveau inférieur à 60 seront compensés à 60 pour ce défi.\n  ·Dans l'équipe d'enquête, les Éveilleurs dont le niveau de compétence est inférieur à 5 seront compensés à 5 pour ce défi.\n  ·Dans l'équipe d'enquête, les Éveilleurs de « Présage de Folie » de niveau inférieur à 6 seront compensés à 6 pour ce défi.\n  ·Dans l'équipe d'enquête, les Éveilleurs dont la « Forge de l'Âme » est inférieure à 5 seront compensés à 5 pour ce défi.\n  ·Si un Gardien a un niveau inférieur à 60, il sera compensé à 60 pour ce défi.\n\n<Title: Enregistrement de la task force>\n·Pendant l'événement, « Enregistrement de la task force : Cantique des Étoiles » peut être déverrouillé gratuitement et sans conditions préalables !\n·Après la fin de l'événement, la progression d'enquête de « Enregistrement de la task force : Cantique des Étoiles » sera conservée, et vous pourrez obtenir les récompenses d'enquête correspondant aux événements d'enquête non complétés pendant l'événement. Si « Enregistrement de la task force : Cantique des Étoiles » n'a pas été déverrouillé pendant l'événement, vous devrez d'abord compléter « Mission d'enquête - Chapitre des Étoiles - Quatrième chapitre » et consommer « Point de départ réel » ×7 pour déverrouiller l'enregistrement de la task force « Cantique des Étoiles ».\n·Que ce soit pendant ou après l'événement, une fois que vous avez terminé « Enregistrement de la task force : Cantique des Étoiles », vous pouvez obtenir le « Décret Clé : Souhait de retrouvailles »."
  },
  Activity_116818_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_117836_ActivityName = {
    Text = "Madame en rouge"
  },
  Activity_117836_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Pendant l'événement \"Dame Rouge\", les Gardiens peuvent utiliser des équipes préétablies par le système incluant Sorel pour expérimenter des niveaux désignés à l'infini.\n·Lors de l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir réussi à terminer le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_117837_ActivityName = {
    Text = "Dame des abysses"
  },
  Activity_117837_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n· Pendant l'événement \"Dame Aequor\", les Gardiens peuvent utiliser des équipes préétablies par le système qui incluent Murphy pour vivre les niveaux désignés indéfiniment.\n· Pendant l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n· Après avoir réussi à compléter le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_117838_ActivityName = {
    Text = "Divus: la plume d'onyx"
  },
  Activity_117838_ActivityTips = {
    Text = "<Title:Règles de l'événement>\n·Pendant l'événement « Fils Saint · Plume Noire », le Gardien peut utiliser une escouade préétablie contenant Castor pour expérimenter indéfiniment le niveau désigné.\n·Lors de l'expérience des niveaux de l'événement, il n'est pas possible d'ajuster les Éveilleurs dans l'escouade.\n<Title:Récompenses de l'événement>\n·Après avoir réussi le défi du niveau pour la première fois, vous pouvez réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_117839_ActivityName = {
    Text = "Clé de la porte"
  },
  Activity_117839_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Lors de l'événement \"Clé de la Porte\", les Gardiens peuvent utiliser des équipes prédéfinies par le système qui incluent Tawil pour vivre des niveaux désignés à l'infini.\n·Lors de l'expérience des niveaux de l'événement, des ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir réussi à terminer le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_119662_ActivityName = {
    Text = "Fleurir de boue"
  },
  Activity_119662_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Pendant l'événement \"Fleur de Mire\", les Gardiens peuvent utiliser des équipes préétablies par le système incluant Lily pour expérimenter des niveaux désignés à l'infini.\n·Lors de la jouabilité des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir réussi à terminer le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_119663_ActivityName = {
    Text = "Souffle de fertilité"
  },
  Activity_119663_ActivityTips = {
    Text = "<Title:Règles de l'activité>\n·Pendant l'événement \"Souffle Abondant\", les Gardiens peuvent utiliser des équipes prédéfinies par le système contenant Thais pour expérimenter des niveaux désignés un nombre illimité de fois.\n·Lors de la réalisation des niveaux d'événement, des ajustements au Réveiller dans la composition de l'équipe ne peuvent pas être effectués.\n<Title:Récompenses de l'activité>\n·Après avoir réussi un défi de niveau pour la première fois, vous pouvez réclamer des récompenses d'essai depuis l'interface de l'événement."
  },
  Activity_119693_ActivityName = {
    Text = "Au nom de la Clé d'Argent"
  },
  Activity_119693_ActivityPlot = {
    Text = "Vous pouvez choisir un éveillé parmi les éveillés limités suivants après avoir terminé la tâche !"
  },
  Activity_119693_ActivityTips = {
    Text = "<Title:Règles de l'événement>\nPendant la durée de l'événement, chaque Gardien peut choisir 1 Éveilleur parmi 8 Éveilleurs SSR limités après avoir utilisé 200 fois leur Décret Clé.\nLa liste comprend : Doll : Dissoute, Clementine, Corposant, Castor, Doresain, Kadigula, Pickman et Pollux.\nLorsque le Gardien choisit un Éveilleur déjà possédé, pour chaque 2ème à 16ème copie obtenue, celle-ci sera convertie en 1 Fragment d'Éveilleur correspondant et 50 Fondements profonds.\nÀ partir de la 17ème copie, l'Éveilleur SSR limité sera converti en 2 Fragments de Noyau Spirituel Essentiel, 6 Fragments de Noyau Spirituel et 250 Fondements profonds."
  },
  Activity_119693_BannerText = {
    Text = "Réveiller Gratuit Limité"
  },
  Activity_119694_ActivityName = {
    Text = "Guidage de l'étoile du matin"
  },
  Activity_119694_ActivityTips = {
    Text = "<Title:Règles de l'événement>\n·Après avoir terminé les tâches désignées, le Gardien peut réclamer des récompenses dans «Guidage de l'étoile du matin».\n·Après avoir débloqué «Archives Avancées», des récompenses supplémentaires peuvent être obtenues après avoir complété les missions.\n·L'achat de cette «Archives Avancées» est limité dans le temps, et il ne sera plus possible de l'acheter après la date limite. Veuillez acheter à votre convenance avant le 26 janvier à 9h00 (GMT+8).\n·Veuillez noter : Les «Archives Avancées» débloquées dans cet événement ne sont valables que pendant la durée de cet événement. Le Gardien est prié de consommer de manière raisonnable."
  },
  Activity_119694_BannerText = {
    Text = "Événement spécial Chronologie à durée limitée !"
  },
  Activity_119857_ActivityName = {
    Text = "Souverain endormi"
  },
  Activity_119857_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Lors de l'événement \"Souverain du Sommeil\", les Gardiens peuvent utiliser des équipes prédéfinies par le système comprenant Tulu pour vivre des niveaux désignés à l'infini.\n·Lors de l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir terminé avec succès le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_120495_ActivityName = {
    Text = "Offrande commémorative du parcours · Chapitre des Étoiles IV"
  },
  Activity_120495_ActivityPlot = {
    Text = "Un souvenir scellé et archivé, un voyage enregistré dans le passé. Dans les moments de souvenir, n'oubliez pas d'offrir votre Visite révérencieuse."
  },
  Activity_120496_ActivityName = {
    Text = "Chroniques de la Réincarnation"
  },
  Activity_120496_ActivityTips = {
    Text = "Règles de l'événement :\n1. Après avoir terminé les tâches désignées, le Gardien peut réclamer des récompenses dans «Chroniques de la Réincarnation».\n2. «Chroniques de la Réincarnation» est ouvert en permanence.\n3. Après avoir débloqué les «Archives Avancées», des récompenses supplémentaires peuvent être réclamées après avoir terminé des missions.\n4. Veuillez noter : les «Archives Avancées» débloquées dans cet événement ne sont valables que pendant la durée de cet événement. Le Gardien est prié de consommer de manière raisonnable."
  },
  Activity_120954_ActivityName = {
    Text = "Cantique des Étoiles"
  },
  Activity_122195_ActivityName = {
    Text = "Holocauste du brouillard"
  },
  Activity_122195_ActivityPlot = {
    Text = "La lumière de l'aube dissout la douleur des dévots, avec les étoiles comme vaisseau, emmenant frères et sœurs vers le royaume élevé. \n L'agneau perdu danse et chante à la porte, orné de bougies étoilées dans la cour divine éternelle. \n Pourtant, la brume derrière la porte a déjà répondu à l'appel, trompant et dupant uniquement pour satisfaire ses propres intérêts tordus. \n Cette brume scelle ainsi l'« aube », bloquant le chemin vers la libération. \n Elle sera ici pour témoigner d'une autre fin du monde."
  },
  Activity_122195_ActivityStageEndContent = {
    Text = "L'événement est terminé. Actuellement, seul \"le cottage de Mouchette\" est disponible."
  },
  Activity_122195_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, le gardien peut collecter des devises d'événement « Vue du Brouillard », « Rêve de Brouillard », « Source de la Brume » via les modes de jeu temporaires « Perdu de soi » et « Récompenses de succès ». Les devises « Vue du Brouillard », « Rêve de Brouillard », « Source de la Brume » peuvent être utilisées pour acheter des articles dans « La cabane de Mouchette », y compris la roue du destin SR limitée à l'événement « Lumière de la raison », Cœur de Lumens, Cœur Immaculé, etc. \n2. Pendant l'événement, « Multi-connexion : Le baptême de l'argent et du sang » sera déverrouillé gratuitement pour une durée limitée. En complétant les succès de l'événement, vous pourrez également obtenir l'avatar limité à l'événement « Au nom de la Clé d'Argent : Mouchette » !\n\n<Title:Temps de l'événement>\n1. Du 29 décembre à 9h00 au 12 janvier à 9h00 (GMT+8), toutes les activités de jeu seront accessibles. \n2. Du 12 janvier à 9h00 au 19 janvier à 9h00 (GMT+8), seuls « La cabane de Mouchette » et les récompenses de succès seront accessibles. \n\n<Title:Perdu de soi>\n1. « Perdu de soi » comprend 7 niveaux, un niveau sera automatiquement déverrouillé chaque jour. \n2. Chaque défi consommera « Ménophine » × 120, réussir un défi permettra de gagner des devises d'événement. \n3. Après avoir terminé un niveau, la fonction « Reproduire » de ce niveau sera déverrouillée. Veuillez noter : en utilisant la fonction « Reproduire », vous ne pouvez pas obtenir de taux de synchronisation. \n4. Vous pouvez utiliser le soutien de l'association des anciens élèves pour vous aider à passer les niveaux plus facilement. \n\n<Title: La cabane de Mouchette>\n « La cabane de Mouchette » comporte trois magasins, les heures d'ouverture sont les suivantes : \n· « Salle des matériaux » : ouverte le 29 décembre à 9h. \n· « Chambre d'entrée dans le rêve » : ouverte le 30 décembre à 9h. \n· « Salle de culture » : ouverte le 31 décembre à 9h. \nDans le magasin, vous pouvez choisir des articles et les acheter directement. \n\n<Title:Bonus d'événement>\n1. Si le gardien possède un Éveilleur ou une roue du destin spécifique (pas besoin d'être en équipe), cela permettra d'obtenir un bonus supplémentaire sur les récompenses de tâches des niveaux de « Perdu de soi » pour « Vue du Brouillard », « Rêve de Brouillard », « Source de la Brume », les bonus spécifiques sont les suivants : \n· Éveilleur « Mouchette » : Dégagement 0/1/2/3 et plus, bonus de 20%/30%/40%/50%. \n· SSR roue du destin « Massacre jusqu'à la fin du monde » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%. \n· SR roue du destin « Lumière de la raison » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%. \n2. Les « bonus d'événement » de différents Éveilleurs ou roues du destin seront calculés de manière cumulative. \n3. En particulier, les récompenses de défi de difficulté Folie lors de la première réussite ne seront pas affectées par les « bonus d'événement ». \n\n<Title:Multi-connexion>\n1. Pendant l'événement, « Multi-connexion : Le baptême de l'argent et du sang » sera déverrouillé gratuitement. \n2. Après la fin de l'événement, le progrès d'enquête de « Multi-connexion : Le baptême de l'argent et du sang » sera conservé. En complétant les événements d'enquête non terminés pendant l'événement, vous pourrez également obtenir des récompenses d'enquête identiques à celles de la période de l'événement. Si « Multi-connexion : Le baptême de l'argent et du sang » n'a pas été déverrouillé pendant l'événement, il pourra toujours être déverrouillé après la fin de l'événement en dépensant « Point de départ réel » ×3. \n3. Que ce soit pendant l'événement ou non, en terminant « Multi-connexion : Le baptême de l'argent et du sang », vous pourrez obtenir le « Décret Clé : Venu du brouillard »."
  },
  Activity_122195_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_122196_ActivityName = {
    Text = "Événement de déblocage gratuit"
  },
  Activity_122520_ActivityName = {
    Text = "Ombre de la ville pluvieuse·clon"
  },
  Activity_122520_ActivityPlot = {
    Text = "Dans cette nuit brumeuse et humide de pluie, une rencontre prédestinée vous attend.\nVous vous souvenez de son nom, reconnaissez son apparence, et sa voix douce et élégante vous met toujours à l'aise.\nMais vous avez oublié : seuls les dieux et les démons sont toujours empressés d'exaucer les désirs humains.\nDevinez, à laquelle de ces catégories appartient–elle ?"
  },
  Activity_122520_ActivityStageEndContent = {
    Text = "L'événement est terminé. Vous pouvez maintenant participer uniquement à la \"Cave de la Sorcière\"."
  },
  Activity_122520_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, le gardien du secret peut collecter des devises d'événement via les modes temporaires « Boutique de la Sorcière » et « Récompenses de succès ». Les devises d'événement peuvent être échangées dans le « Trésor caché de la sorcière » pour obtenir des récompenses d'objets, y compris la roue du destin SR exclusive à l'événement « Chapeau de sorcière à large bord », la pierre philosophale, le Cœur Immaculé, le Cœur de Lumens, etc. \n2. Pendant l'événement, « Enregistrement de la task force : Ombre de la ville pluvieuse » sera ouvert gratuitement, et en accomplissant les succès de l'événement, vous pourrez également obtenir l'avatar exclusif à l'événement « Au nom de la Clé d'Argent : » Davendale « » !\n\n<Title:Temps de l'événement>\n1. Du 12 janvier à 9h00 au 26 janvier à 9h00(GMT+8), tous les contenus de l'événement sont accessibles. \n2. Du 26 janvier à 9h00 au 2 février à 9h00(GMT+8), seuls « Trésor caché de la sorcière » et « Récompenses de succès » resteront disponibles, les autres contenus seront terminés et non accessibles.\n\n<Title:Boutique de la Sorcière>\n1. La « Boutique de la Sorcière » comprend 5 niveaux, un niveau s'ouvrant automatiquement tous les 2 jours. \n2. Chaque défi consommera 120 points de Ménophine, et un défi réussi rapportera des devises d'événement. \n3. Une fois le niveau terminé, la fonction de « Reproduction » de ce niveau sera déverrouillée. Veuillez noter : en utilisant la fonction « Reproduction », aucun taux de synchronisation ne sera obtenu. \n4. Vous pouvez utiliser l'assistance de l'association des anciens élèves pour vous aider à terminer plus facilement les niveaux. \n\n<Title:Bonus d'événement>\n1. Si le gardien possède un Éveilleur ou une roue du destin spécifique(aucune exigence d'être en équipe), cela permettra d'obtenir des bonus de chute supplémentaires pour « Crâne de Bête Pâle », « Crâne de Bête Ombreuse » et « Crâne de la Bête Écarlate » dans les récompenses de la mission de la « Boutique de la Sorcière », les bonus spécifiques sont les suivants : \n· Éveilleur « Daffodil » : Dégagement 0/1/2/3 et plus, bonus de 20%/30%/40%/50%\n· SSR roue du destin « Une Collection des plus Précieuses » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%\n· SR roue du destin « Chapeau de sorcière à large bord » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%\n2. Les « Bonus d'événement » de différents Éveilleurs ou roues du destin sont calculés de manière cumulative. \n3. En particulier, les récompenses de premier défi pour la difficulté Frénésie ne seront pas affectées par les « Bonus d'événement ».\n\n<Title:Trésor caché de la sorcière>\n1. Il y a trois « Trésors cachés de la sorcière », les heures d'ouverture sont les suivantes : \n· « Produit réconfortant » : Du 12 janvier à 9h00 au 2 février à 9h00. \n· « Trésor splendide » : Du 14 janvier à 9h00 au 2 février à 9h00. \n· « Trésors précieux » : Du 16 janvier à 9h00 au 2 février à 9h00. \n2. Chaque échange consommera 750 « Crâne de Bête Pâle » / « Crâne de Bête Ombreuse » / « Crâne de la Bête Écarlate », et vous obtiendrez aléatoirement cinq récompenses d'objets dans le trésor. \n3. Les récompenses d'objets de chaque trésor sont divisées en deux types : « Objet spécial » et « Objet ordinaire », lors de la réinitialisation, il est possible de réinitialiser le nombre restant d'objets spécifiés au maximum, les règles spécifiques sont les suivantes : \n(1) Pour les 2 premières réinitialisations : lorsque le nombre restant d'« Objet spécial » est épuisé, le gardien peut choisir de réinitialiser. Après la réinitialisation, le nombre restant d'« Objet spécial » et d'« Objet ordinaire » sera réinitialisé au maximum ; il peut aussi choisir de continuer à échanger, lorsque le nombre restant d'« Objet ordinaire » est également épuisé, une réinitialisation doit être effectuée pour continuer à échanger. \n(2) À partir de la 3ème réinitialisation : lorsque le nombre restant d'« Objet ordinaire » est épuisé, une réinitialisation peut être effectuée, la réinitialisation remettra le nombre restant d'« Objet ordinaire » au maximum, tandis que les « Objets spéciaux » ne seront plus réinitialisés. \n\n<Title:Enregistrement de la task force>\n1. Pendant l'événement, « Enregistrement de la task force : Ombre de la ville pluvieuse » sera ouvert gratuitement. \n2. Après la fin de l'événement, le progrès de l'enquête dans « Enregistrement de la task force : Ombre de la ville pluvieuse » sera conservé. Si « Enregistrement de la task force : Ombre de la ville pluvieuse » n'a pas été déverrouillé pendant l'événement, il sera toujours possible de dépenser « Point de départ réel » *7 pour le déverrouiller après la fin de l'événement. \n3. Que ce soit pendant l'événement ou non, après avoir terminé « Enregistrement de la task force : Ombre de la ville pluvieuse », vous pourrez obtenir « Décret Clé : Véritable apparence de la Brume Grise »."
  },
  Activity_122520_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_122521_ActivityName = {
    Text = "Événement de déblocage gratuit"
  },
  Activity_122803_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_122803_ActivityPlot = {
    Text = "Après l'achat, « Mouchette » peut être activée\n<BlueQuality:Personnalité approfondie +4, déverrouiller Sur-Exaltation>"
  },
  Activity_122804_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_122804_ActivityPlot = {
    Text = "Après l'achat, « Mouchette » peut être activée<BlueQuality:Dégagement 3>"
  },
  Activity_122827_ActivityName = {
    Text = "La grâce de la reproduction"
  },
  Activity_122827_ActivityTips = {
    Text = "<Title:Présentation>\n·Pendant l'événement, le gardien du secret peut obtenir les récompenses correspondantes dans « La grâce de la reproduction » après avoir atteint les objectifs désignés."
  },
  Activity_122827_BannerText = {
    Text = "Recevez gratuitement un vêtement fantomatique !"
  },
  Activity_123150_ActivityName = {
    Text = "Chasseresse de crânes"
  },
  Activity_123150_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Pendant l'événement \"Chasseresse des Crânes\", les Gardiens peuvent utiliser des équipes préétablies par le système incluant Jonquille pour expérimenter des niveaux désignés à l'infini.\n·Lors de l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir réussi à terminer le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_123151_ActivityName = {
    Text = "Seigneur de nécrovia"
  },
  Activity_123151_ActivityTips = {
    Text = "<Title:Règles de l'événement>\n· Pendant la durée de l'événement « Seigneur des Ossements Enterrés », les Gardiens du secret peuvent utiliser des équipes prédéfinies contenant Doresain pour expérimenter sans limite les niveaux désignés.\n· Lors de l'expérience des niveaux de l'événement, il n'est pas possible d'ajuster les Éveilleurs dans l'escouade.\n<Title:Récompenses de l'événement>\n· Après avoir réussi le défi d'un niveau pour la première fois, vous pouvez recevoir des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_123152_ActivityName = {
    Text = "Apôtre de la mer"
  },
  Activity_123152_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n· Pendant l'événement \"Apostle de la Mer\", les Gardiens peuvent utiliser des équipes préétablies par le système qui incluent Miryam pour vivre les niveaux désignés indéfiniment.\n· Lors de l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n· Après avoir réussi à compléter le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_123322_ActivityName = {
    Text = "Voyage de la fleur d'argent givré"
  },
  Activity_123322_ActivityTips = {
    Text = "<Title:Règles de l'événement>\n1. Après avoir terminé les tâches désignées, le Gardien peut réclamer des récompenses dans «Voyage de la fleur d'argent givré».\n2. Le «Voyage de la fleur d'argent givré» se terminera le 12 janvier à 9h00 (GMT+8).\n3. Après avoir débloqué les «Archives Avancées», des récompenses supplémentaires peuvent être réclamées après avoir terminé les missions.\n4. Veuillez noter : les «Archives Avancées» débloquées dans cet événement ne sont valables que pendant l'événement. Les Gardiens du secret sont invités à consommer de manière raisonnable."
  },
  Activity_123322_BannerText = {
    Text = "Événement spécial Chronologie à durée limitée !"
  },
  Activity_123323_ActivityName = {
    Text = "Danse de la Chèvre d'Or"
  },
  Activity_123323_ActivityTips = {
    Text = "<Title:Règles de l'événement>\n1. Les Gardiens peuvent réclamer des récompenses dans \"Danse de la Chèvre Dorée\" après avoir complété les tâches d'archive désignées.\n2. \"Danse de la Chèvre Dorée\" se terminera le 26 janvier à 9h00 (GMT+8).\n3. Après avoir débloqué les \"Archives Premium\", des récompenses supplémentaires peuvent être réclamées après avoir complété les tâches.\n4. Veuillez noter : Les \"Archives Premium\" débloquées lors de cet événement ne sont valables que pendant cet événement. Les Gardiens devraient dépenser de manière avisée et rationnelle."
  },
  Activity_123323_BannerText = {
    Text = "Événement spécial Chronologie à durée limitée !"
  },
  Activity_124049_ActivityName = {
    Text = "Cerveau corrompu"
  },
  Activity_124049_ActivityTips = {
    Text = "<Title:Règlement de l'événement>\n· Pendant l'événement « Cerveau corrompu », le gardien du secret peut utiliser des équipes prédéfinies contenant « Fusion · Dor » pour vivre sans limite les niveaux désignés.\n· Lors de l'expérience des niveaux d'événement, il est impossible d'ajuster les Éveilleurs dans l'escouade.\n<Title:Récompenses de l'événement>\n· Après avoir réussi le défi du niveau pour la première fois, vous pouvez réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_124050_ActivityName = {
    Text = "Apôtre de la mer"
  },
  Activity_124050_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n· Pendant l'événement \"Apostle de la Mer\", les Gardiens peuvent utiliser des équipes préétablies par le système qui incluent Miryam pour vivre les niveaux désignés indéfiniment.\n· Lors de l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n· Après avoir réussi à compléter le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_124051_ActivityName = {
    Text = "Sacrifice Abysse : Rejouer"
  },
  Activity_124051_ActivityPlot = {
    Text = "Sur le reflet de l'océan profond, le rêve de son Roi se dissipe, et le Royaume Divin se décompose.\nElle émerge de rêves anciens, foulant les ruines d'un avenir en effondrement.\nElle interroge les Abysses en spirale, mais les Abysses en spirale restent silencieuses.\nElle offre des sacrifices aux Abysses en spirale, pour n'entendre que son propre écho."
  },
  Activity_124051_ActivityStageEndContent = {
    Text = "Événement terminé, participation actuelle uniquement à «Réponse de l'abîme»"
  },
  Activity_124051_ActivityTips = {
    Text = "<Title:Introduction à l'événement>\n1. Pendant l'événement, les gardiens du secret peuvent collecter des devises d'événement via les modes temporaires « Naissance du Royaume Divin », « Le décret du roi » et « Récompenses de succès ». Ces devises peuvent être utilisées dans « Réponse de l'Abyss » pour des offrandes afin d'obtenir des récompenses d'objets, y compris la roue du destin SR limitée à l'événement « L'Appel du Fond Marin », la pierre philosophale, le Cœur Immaculé, le Cœur de Lumens, etc. \n2. Pendant l'événement, « Monde des Rêves Étranges : Profanation » sera ouvert gratuitement, et en complétant les succès de l'événement, vous pourrez également obtenir le portrait limité à l'événement « Au nom de la Clé d'Argent : Miryam » ! \n\n<Title:Temps de l'événement>\n1. Du 9 mars 9h00 au 23 mars 9h00 (GMT+8), tous les contenus de l'événement sont accessibles. \n2. Du 23 mars 9h00 au 30 mars 9h00 (GMT+8), seuls « Réponse de l'Abyss » et « Récompenses de succès » seront disponibles, les autres contenus seront terminés et non accessibles. \n\n<Title: Naissance du Royaume Divin>\n1. « Naissance du Royaume Divin » comprend 5 niveaux, un nouveau niveau s'ouvrira automatiquement tous les 2 jours. \n2. Chaque défi consommera « Ménophine » × 120, et un défi réussi rapportera des devises d'événement. \n3. Après avoir terminé un niveau, la fonction « Reproduire » de ce niveau sera déverrouillée. Veuillez noter : en utilisant la fonction « Reproduire », le taux de synchronisation ne sera pas obtenu. \n4. Vous pouvez utiliser l'aide de l'association d'anciens élèves et « Résonance : Rituel de la Mer » pour vous aider à terminer les niveaux plus facilement. \n\n<Title: Bonification de Sacrifice>\n1. Les gardiens du secret possédant un Éveilleur ou une roue du destin spécifique (pas besoin d'être en équipe) peuvent faire en sorte que les récompenses de mission dans les niveaux de « Naissance du Royaume Divin », « Larmes du Sacrificateur », « Sang du Sacrificateur » et « Moelle du Sacrificateur » obtiennent un bonus de chute supplémentaire (y compris lors de la reproduction), les bonus spécifiques sont les suivants : \n· Éveilleur « Miryam » : Dégagement 0/1/2/3 et plus, bonus de 20%/30%/40%/50% \n· Roue du destin SSR « La puissance dévouée » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50% \n· Roue du destin SR « L'Appel du Fond Marin » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50% \n2. Les « Bonifications de Sacrifice » des différents Éveilleurs ou roues du destin seront calculées de manière cumulée. \n3. En particulier, les récompenses de défi de difficulté folie ne seront pas affectées par les « Bonifications de Sacrifice ». \n\n<Title: Résonance : Rituel de la Mer>\n1. Les gardiens du secret peuvent obtenir « Cœur de piété » en complétant les succès de l'événement. \n2. En dépensant « Cœur de piété », activez « Résonance : Rituel de la Mer », vous pouvez obtenir les bonus suivants : \n(1) Rendre les gardiens plus puissants dans le mode de jeu de l'événement « Naissance du Royaume Divin », rendant les défis plus faciles. \n(2) Augmenter les devises d'événement obtenues après avoir terminé les défis de « Naissance du Royaume Divin ». \n(3) Activer le mode de jeu de l'événement « Le décret du roi ». \n\n<Title: Le décret du roi>\n· Après avoir activé la résonance « Épreuve de sacrifice », obtenez automatiquement 60 « Larmes du Sacrificateur » par heure, pouvant être stockées jusqu'à 25 heures. \n\n<Title: Réponse de l'Abyss>\n1. « Réponse de l'Abyss » a trois autels, les heures d'ouverture sont les suivantes : \n· « Autel des Larmes Cristallines » : Du 9 mars 9h00 au 30 mars 9h00. \n· « Autel de Sang de Gorille » : Du 11 mars 9h00 au 30 mars 9h00. \n· « Autel des Âmes » : Du 13 mars 9h00 au 30 mars 9h00. \n2. Chaque offrande de sacrifices consommera « Larmes du Sacrificateur »/« Sang du Sacrificateur »/« Moelle du Sacrificateur » × 750, et obtiendra aléatoirement cinq récompenses d'objets de l'autel. \n3. Les récompenses d'objets de chaque autel sont divisées en « objets spéciaux » et « objets ordinaires », lors de la réinitialisation, vous pouvez réinitialiser le nombre restant d'objets spécifiés à la limite, les règles spécifiques sont : \n(1) Pour les 3 premières réinitialisations : lorsque les « objets spéciaux » n'ont plus de quantité restante, le gardien peut choisir de réinitialiser, après réinitialisation, le nombre restant des « objets spéciaux » et « objets ordinaires » sera réinitialisé à la limite ; sinon, vous pouvez continuer à offrir des sacrifices, lorsque les « objets ordinaires » n'ont plus de quantité restante, vous devez réinitialiser pour pouvoir continuer à offrir des sacrifices. \n(2) À partir de la 4ème réinitialisation : lorsque les « objets ordinaires » n'ont plus de quantité restante, vous pouvez procéder à la réinitialisation, ce qui réinitialisera le nombre restant des « objets ordinaires » à la limite, les « objets spéciaux » ne seront plus réinitialisés. \n\n<Title: Monde des Rêves Étranges>\n1. Pendant l'événement, « Monde des Rêves Étranges : Profanation » sera ouvert gratuitement. \n2. Après la fin de l'événement, la progression de l'enquête de « Monde des Rêves Étranges : Profanation » sera conservée, si « Monde des Rêves Étranges : Profanation » n'a pas été déverrouillé pendant l'événement, vous pourrez toujours dépenser « Point de départ réel » × 7 pour le déverrouiller après la fin de l'événement. \n3. Que ce soit pendant ou après l'événement, après avoir terminé « Monde des Rêves Étranges : Profanation », vous pouvez obtenir « Décret Clé : Fête de la Mer ». \n\n<Title: Compensation de reproduction>\n1. Les gardiens du secret qui ont déjà déverrouillé « Monde des Rêves Étranges : Profanation » recevront une compensation de « Larmes du Sacrificateur » × 700 lors du déverrouillage à nouveau pendant cet événement de reproduction. \n2. Les gardiens du secret qui ont déjà obtenu le portrait limité à l'événement « Au nom de la Clé d'Argent : Miryam » verront leur obtention répétée automatiquement convertie en « Invitation de l'Incorporel » × 1. \n3. Les gardiens du secret qui ont déjà obtenu le matériau d'activation de résonance « Cœur de piété » recevront automatiquement « Billet Rose Dorée » × 5000 pour chaque « Cœur de piété » supplémentaire obtenu. \n"
  },
  Activity_124051_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_124052_ActivityName = {
    Text = "Événement de déblocage gratuit"
  },
  Activity_124053_ActivityName = {
    Text = "Reine des Épines"
  },
  Activity_124053_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Pendant l'événement \"Reine des Épines\", les Gardiens peuvent utiliser des équipes préétablies par le système incluant Wanda pour expérimenter des niveaux désignés à l'infini.\n·Lors de l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir réussi à terminer le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_124800_ActivityName = {
    Text = "Tour inverse"
  },
  Activity_124801_ActivityName = {
    Text = "Inversion de phase"
  },
  Activity_124801_ActivityPlot = {
    Text = "« Je veux que tout le monde jouer aux Cartes Omnipotentes ! »\nDes visiteurs venus d'autres lignes temporelles sont entrés accidentellement dans l'espace d'Échecs de Phase et l'ont transformé en une forme radicalement différente.\nPour inverser à nouveau l'espace, les Gardiens du secret de différentes lignes temporelles doivent déterminer le plus fort d'entre eux et défier ce visiteur."
  },
  Activity_124801_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, les Gardiens du secret pourront participer à «Échecs de Phase» pour accomplir des succès dans «Récompenses de succès» et réclamer des «Glands magiques».\n2. Les «Glands magiques» peuvent être échangés dans «Récompenses de Tour» contre des récompenses riches, y compris l'avatar exclusif de l'événement «Tour inverse : Carte des Dix Mille Phénomènes», 10 expressions exclusives de l'événement, ainsi que des récompenses telles que «Rêve brisé» et «Rêve des Étoiles».\n3. Pendant l'événement, «Connexion Multidimensionnelle : Tour inverse» sera ouvert gratuitement !\n4. Les Gardiens du secret qui auront terminé «Connexion Multidimensionnelle : Tour inverse : Invité d'un autre monde» pendant l'événement verront le fond de bataille de «Échecs de Phase» temporairement remplacé par «Tour inverse : Espace de conscience».\n\n<Title: Récompenses de succès>\n1. Les «Récompenses de succès» comprennent «Épreuve Arcane», «Épreuve d'Honneur» et «Épreuve de Seuil». Les Gardiens du secret peuvent accomplir les objectifs de succès pour réclamer des «Glands magiques».\n2. Dans les succès «Épreuve Arcane», chaque 3 Éveilleurs ennemis vaincus rapporte 10 «Glands magiques», jusqu'à 50 fois. Chaque 6 Exaltations déclenchées rapporte 10 «Glands magiques», jusqu'à 50 fois. Chaque 20 Cartes jouées rapporte 10 «Glands magiques», jusqu'à 50 fois.\n3. Les Éveilleurs, Roues du Destin et Décrets Clés temporairement déverrouillés via le Sujet principal seront comptabilisés normalement pour les victoires et les cartes jouées.\n\n<Title: Récompenses de Tour>\n1. Les Gardiens du secret peuvent accumuler des «Glands magiques» pour recevoir les récompenses correspondantes. Accumuler 3 600 «Glands magiques» permet d'obtenir toutes les récompenses principales, tandis qu'accumuler 6 000 «Glands magiques» permet d'obtenir toutes les récompenses !\n2. Après avoir terminé «Tour inverse : Invité d'un autre monde», déverrouillez les récompenses pour accumuler de 100 à 900 «Glands magiques», et après avoir terminé «Tour inverse : L'instant de renversement de tout», déverrouillez les récompenses pour accumuler de 1 000 à 6 000 «Glands magiques».\n\n<Title: Connexion Multidimensionnelle>\n1. Pendant l'événement, «Connexion Multidimensionnelle : Tour inverse» sera ouvert gratuitement.\n2. Après la fin de l'événement, la progression de l'enquête de «Connexion Multidimensionnelle : Tour inverse» sera conservée. Si «Connexion Multidimensionnelle : Tour inverse» n'est pas déverrouillé pendant l'événement, il sera toujours possible de le déverrouiller après la fin de l'événement en dépensant «Point de départ réel» *3.\n3. Qu'il soit pendant ou hors de l'événement, terminer «Connexion Multidimensionnelle : Tour inverse» permettra d'obtenir le «Décret Clé : La porte de la taverne».\n\n<Title:Durée de l'événement>\nCet événement est ouvert uniquement du 16 mars à 9h00 au 30 mars à 9h00 (GMT+8). Après le 30 mars à 9h00 (GMT+8), l'événement se termine. Veuillez vous rappeler de réclamer vos récompenses dans «Récompenses de Tour» !"
  },
  Activity_124801_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_124801_UnlockConditionExplanation = {
    Text = "Débloqué après avoir terminé \"Opération d'enquête\" 3-2·Normal"
  },
  Activity_124834_ActivityName = {
    Text = "Au nom du brouillard"
  },
  Activity_124834_ActivityPlot = {
    Text = "Morimens × Séquence de Brume\nInvitation Spéciale de Collaboration\n« Je m'appelle Mouchette, enquêteuse de... Oh oui, je ne suis plus l'avant-garde de l'A.U.G.E. Laissez-moi me représenter—je suis Mouchette, juste une fille douce et mignonne. »"
  },
  Activity_124834_ActivityTips = {
    Text = "<Title:Règles de l'événement>\nTerminez Oubli Ch. 1 « Secrets de l'Est » pendant l'événement « Au nom du brouillard » pour obtenir gratuitement le nouveau Corps éveillé SSR limité « Mouchette » !\nDe la 2e à la 16e obtention du même Corps éveillé SSR, chacune sera convertie en 1 Fragment de Corps éveillé correspondant et 50 Fondements profonds ; à partir de la 17e fois et au–delà, le Corps éveillé SSR limité sera converti en 2 Fragments de Noyau Spirituel Essentiels, 6 Fragments de Noyau Spirituel et 250 Fondements profonds."
  },
  Activity_124834_BannerText = {
    Text = "Réveiller Gratuit Limité"
  },
  Activity_124981_ActivityName = {
    Text = "Événement de déblocage gratuit"
  },
  Activity_124982_ActivityName = {
    Text = "Patient dissociatif : chaos"
  },
  Activity_124982_ActivityTips = {
    Text = "<Title:Règles de l'activité>\n·Pendant l'événement \"Patient Éclaté: Chaos\", les Gardiens peuvent utiliser des équipes prédéfinies par le système contenant \"24\" pour expérimenter des niveaux désignés un nombre illimité de fois.\n·Lors de la réalisation des niveaux d'événement, des ajustements au Réveiller dans la composition de l'équipe ne peuvent pas être effectués.\n<Title:Récompenses de l'activité>\n·Après avoir réussi un défi de niveau pour la première fois, vous pouvez réclamer des récompenses d'essai depuis l'interface de l'événement."
  },
  Activity_124983_ActivityName = {
    Text = "Patient dissociatif : caro"
  },
  Activity_124983_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Lors de l'événement \"Patient Divisé : Caro\", les Gardiens peuvent utiliser des équipes prédéfinies par le système comprenant \"24\" pour vivre des niveaux désignés à l'infini.\n·Lors de l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir terminé avec succès le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_124984_ActivityName = {
    Text = "Poème sans nom"
  },
  Activity_124984_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Pendant l'événement \"Poème Sans Nom\", les Gardiens peuvent utiliser des équipes préétablies par le système incluant Horla pour expérimenter des niveaux désignés à l'infini.\n·Lors de l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir réussi à terminer le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_124985_ActivityName = {
    Text = "Patient dissociatif : aequor"
  },
  Activity_124985_ActivityTips = {
    Text = "<Title:Règles de l'activité>\n·Pendant l'événement \"Patient Éclaté: Aequor\", les Gardiens peuvent utiliser des équipes prédéfinies par le système contenant \"24\" pour expérimenter des niveaux désignés un nombre illimité de fois.\n·Lors de la réalisation des niveaux d'événement, des ajustements au Réveiller dans la composition de l'équipe ne peuvent pas être effectués.\n<Title:Récompenses de l'activité>\n·Après avoir réussi un défi de niveau pour la première fois, vous pouvez réclamer des récompenses d'essai depuis l'interface de l'événement."
  },
  Activity_124986_ActivityName = {
    Text = "Patient dissociatif : ultra"
  },
  Activity_124986_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Lors de l'événement \"Patient Divisé : Ultra\", les Gardiens peuvent utiliser des équipes prédéfinies par le système comprenant \"24\" pour vivre des niveaux désignés à l'infini.\n·Lors de l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir terminé avec succès le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_124987_ActivityName = {
    Text = "Soins multiples·Réplique"
  },
  Activity_124987_ActivityPlot = {
    Text = "Symptôme : Hystérie, également connu sous le nom de trouble hystérique.\nÀ votre époque, c'est synonyme de mort.\n\nHeureusement, les scientifiques et enquêteurs de Mizag sont tout aussi fous : ils sont déterminés à résoudre ce problème"
  },
  Activity_124987_ActivityStageEndContent = {
    Text = "L'événement est terminé. Actuellement, seule \"Analyse de Personnalité\" est disponible."
  },
  Activity_124987_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1, Pendant la durée de l'événement, le Gardien peut collecter la monnaie de l'événement « Puzzle mémoriel » à travers les modes limités « Code de mémoire », « Accumulation maniaque » et « Récompenses de succès ». Les « Puzzles mémoriels » peuvent être utilisés dans « Analyse de personnalité » pour acheter des articles, y compris la roue du destin SR limitée à l'événement « Volonté de la Morue Argentée », Cœur de Lumens, Cœur Immaculé, etc. \n2, Pendant l'événement, « Enregistrement de la task force : Fission Calme » sera déverrouillé gratuitement pour une durée limitée. En complétant les succès de l'événement, vous pourrez également obtenir l'avatar limité de l'événement « Au nom de la Clé d'Argent : «24» » !\n\n<Title:Durée de l'événement>\n1, Du 23 février à 9h00 au 9 mars à 9h00 (GMT+8), tous les modes d'événement seront accessibles. \n2, Du 9 mars à 9h00 au 16 mars à 9h00 (GMT+8), seuls « Analyse de personnalité » et les Récompenses de succès seront disponibles. \n\n<Title:Code de mémoire>\n1, Le « Code de mémoire » comprend 5 niveaux, un niveau sera automatiquement ouvert tous les 2 jours. \n2, Chaque défi consommera 120 points de Ménophine, et un défi réussi rapportera de la monnaie de l'événement. \n3, Une fois le niveau terminé, la fonction « Reproduire » de ce niveau sera déverrouillée. Veuillez noter : en utilisant la fonction « Reproduire », il n'est pas possible d'obtenir le taux de synchronisation. \n4, Vous pouvez utiliser l'aide de l'association des anciens élèves et « Résonance : Syndrome Dissociatif » pour vous aider à passer les niveaux plus facilement. \n\n<Title:Bonus de rationalité>\n1, Les Gardiens du secret possédant un Éveilleur ou une roue du destin spécifique (aucune exigence de présence sur le champ de bataille) peuvent faire en sorte que les récompenses des missions de niveau « Code de mémoire » obtiennent un bonus de chute supplémentaire en « Puzzle mémoriel », les bonus spécifiques sont les suivants : \n· Éveilleur « 24 » : Dégagement 0/1/2/3 et plus, bonus de 20%/30%/40%/50%. \n· Roue du destin SSR « Rétroaction du corps déformé » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%. \n· Roue du destin SR « Volonté de la Morue Argentée » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%. \n2, Les « Bonus de rationalité » des différents Éveilleurs ou roues du destin seront calculés de manière cumulative. \n3, En particulier, les récompenses pour le premier défi de difficulté Folie ne seront pas affectées par les « Bonus de rationalité ». \n\n<Title:Résonance : Syndrome Dissociatif>\n1, Les Gardiens du secret peuvent obtenir des « Cœurs scindés » en complétant les succès de l'événement. \n2, En dépensant des « Cœurs scindés », activer la « Résonance : Syndrome Dissociatif » permettra d'obtenir les bonus suivants : \n(1) Rendre les Gardiens du secret plus forts dans les modes d'événement « Code de mémoire » et « Enregistrement de la task force : Fission Calme », rendant les défis plus faciles. \n(2) Augmenter les récompenses obtenues après avoir complété le défi « Code de mémoire ». \n(3) Activer le mode d'événement « Accumulation maniaque ». \n\n<Title:Accumulation maniaque>\n1, Après avoir activé la résonance « Diagnostic : Fissure de personnalité », vous recevrez automatiquement 60 « Puzzle de Mémoire α » chaque heure, avec un maximum de 25 heures. \n2, Après avoir activé la résonance « Connaissance harmonisée », vous recevrez automatiquement 30 « Puzzle de Mémoire β » chaque heure, avec un maximum de 25 heures. \n\n<Title:Enregistrement de la task force>\n1, Pendant l'événement, « Enregistrement de la task force : Fission Calme » peut être déverrouillé gratuitement. \n2, Après la fin de l'événement, la progression de l'enquête de « Enregistrement de la task force : Fission Calme » sera conservée. En complétant les événements d'enquête non terminés pendant l'événement, vous pourrez également obtenir des récompenses d'enquête identiques à celles de la période de l'événement. Si « Enregistrement de la task force : Fission Calme » n'a pas été déverrouillé pendant l'événement, vous pourrez toujours le déverrouiller après la fin de l'événement en dépensant « Point de départ réel » *7. \n3, Que ce soit pendant ou après l'événement, une fois le « Enregistrement de la task force : Fission Calme » terminé, vous pourrez obtenir « Décret Clé : Tout d'elle ». \n\n<Title:Compensation de réplique>\n1, Les Gardiens du secret qui ont déjà déverrouillé « Enregistrement de la task force : Fission Calme » recevront 700 « Puzzle de Mémoire α » de compensation lors du déverrouillage de cet événement de réplique. \n2, Les Gardiens du secret qui ont déjà obtenu l'avatar limité de l'événement « Au nom de la Clé d'Argent : «24» » verront leur obtention répétée automatiquement convertie en « Invitation de l'Incorporel » *1. \n3, Les Gardiens du secret qui ont déjà obtenu le matériel d'activation de résonance « Cœur scindé », chaque « Cœur scindé » supplémentaire sera automatiquement converti en « Billet Rose Dorée » *5000. \n"
  },
  Activity_124987_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_124988_ActivityName = {
    Text = "Faucheur d'âme"
  },
  Activity_124988_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Pendant l'événement \"Collecteur d'Âmes\", les Gardiens peuvent utiliser des équipes prédéfinies par le système comprenant le Hilote : Catena pour vivre des niveaux désignés à l'infini.\n·Lors de l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir réussi le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_125364_ActivityName = {
    Text = "Murmures de Huangpu"
  },
  Activity_125364_ActivityPlot = {
    Text = "Pouvoir, désir et l'ivresse de la richesse ; sur l'autel où reposent des cadavres dans le profond manoir, l'être ancien ouvre lentement les yeux. \n Ah, mais ce n'est pas une histoire terrifiante ; Il \"t'aime\", et Il te \"protégera\" pour toujours... Il souhaite te donner tout ce qu'il y a de \"mieux.\""
  },
  Activity_125364_ActivityStageEndContent = {
    Text = "L'événement est terminé. Actuellement, seule \"Offrande désolée\" est disponible."
  },
  Activity_125364_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\nPendant l'événement, le Gardien peut collecter la monnaie de l'événement « Pâte de poire » à travers les modes de jeu temporaires « Xuan Nü sans forme » et « Récompenses de succès ». La « Pâte de poire » peut être échangée dans « Maison hantée » contre des récompenses, y compris le SR de roue du destin limité à l'événement « Appât de magnolia », Cœur de Lumens, Cœur Immaculé, Éclats de Pierre Sage, Cristal de Mimesis, etc. \n\n<Title:Xuan Nü sans forme>\n1. « Xuan Nü sans forme » comprend 9 niveaux de matériel qui n'ont pas besoin d'exploration et se battent directement, un niveau est ouvert chaque jour. \n2. Chaque défi consommera « Ménophine » × 120, et réussir le défi rapportera des matériaux de culture et de la monnaie de l'événement. \n3. Après avoir terminé le niveau, la fonction « Reproduire » de ce niveau sera déverrouillée. Veuillez noter : lors de l'utilisation de la fonction « Reproduire », il n'est pas possible d'obtenir le taux de synchronisation. \n4. Vous pouvez utiliser l'aide de l'association d'anciens élèves pour vous aider à terminer les niveaux plus facilement. \n\n<Title:Bonus de l'événement>\n1. Si le Gardien possède un Éveilleur ou une roue du destin spécifique (pas besoin d'être dans l'équipe), cela permettra d'augmenter la quantité de « Pâte de poire » dans les récompenses de la mission du niveau « Xuan Nü sans forme » (y compris la reproduction) de manière supplémentaire, les bonus spécifiques sont les suivants : \n· Éveilleur « Xu » : Dégagement 0/1/2/3 et plus, bonus de 20%/30%/40%/50% \n· SSR roue du destin « Froncer les sourcils en vain » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50% \n· SR roue du destin « Appât de magnolia » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50% \n2. Les « bonus d'événement » des différents Éveilleurs ou roues du destin sont calculés de manière cumulative. \n3. En particulier, les récompenses de défi de première réussite en difficulté Folie ne seront pas affectées par les bonus mentionnés ci-dessus. \n\n<Title: Maison hantée>\n1. Chaque « Offrande » consommera 750 « Pâte de poire » et vous obtiendrez aléatoirement cinq récompenses d'objets dans « Maison hantée ». \n2. Les récompenses d'objets de « Maison hantée » sont divisées en « objets spéciaux » et « objets ordinaires », lors de la réinitialisation, vous pouvez réinitialiser la quantité restante des récompenses d'objets spéciaux à leur maximum, les règles spécifiques sont les suivantes : \n(1)Pour les 5 premières réinitialisations : lorsque les « objets spéciaux » n'ont plus de quantité restante, le Gardien peut choisir de réinitialiser, ce qui réinitialisera la quantité restante des « objets spéciaux » et « objets ordinaires » à leur maximum ; vous pouvez également choisir de continuer à échanger, lorsque les « objets ordinaires » n'ont plus de quantité restante, vous devez procéder à la réinitialisation pour continuer à échanger. \n(2)À partir de la 6ème réinitialisation et après : lorsque les « objets ordinaires » n'ont plus de quantité restante, vous pouvez procéder à la réinitialisation, la réinitialisation remettra la quantité restante des « objets ordinaires » à leur maximum, les « objets spéciaux » ne seront plus réinitialisés. \n\n<Title:Plongée dans l'inconscient>\n1. Pendant l'événement, « Conversations nocturnes sous l'éventail » peut être déverrouillé gratuitement. \n2. Après la fin de l'événement, la progression d'enquête de « Conversations nocturnes sous l'éventail » sera conservée, et vous pourrez obtenir des récompenses d'enquête identiques à celles de la période de l'événement en complétant les enquêtes non terminées pendant l'événement. Si « Conversations nocturnes sous l'éventail » n'a pas été déverrouillé pendant l'événement, après la fin de l'événement, vous pouvez toujours dépenser « Point de départ réel » × 3 pour le déverrouiller. \n3. Que ce soit pendant ou après l'événement, une fois que vous avez terminé « Plongée dans l'inconscient : Conversations nocturnes sous l'éventail », vous obtiendrez « Décret Clé : Souvenirs du manoir ». \n\n<Title:Temps de l'événement>\n1. Du 26 janvier 9h00 au 9 février 9h00 (GMT+8), tous les contenus présentés dans la présentation de l'événement peuvent y participer. \n2. Du 9 février 9h00 au 16 février 9h00 (GMT+8), uniquement « Maison hantée » et « Récompenses de succès » seront conservées, tous les autres contenus seront terminés et ne pourront plus être participés. \n3. Après le 16 février 9h00 (GMT+8), la « Pâte de poire » restante non échangée sera récupérée selon le ratio de 40 billets rose dorée pour chaque « Pâte de poire », veuillez prêter attention à vérifier vos e-mails."
  },
  Activity_125364_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_125366_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_125366_ActivityPlot = {
    Text = "Après achat, « Xu » peut activer\n<BlueQuality:Surgissement de Psyché +4, Débloquer Sur-Exaltation>"
  },
  Activity_125367_ActivityName = {
    Text = "Événement de déblocage gratuit"
  },
  Activity_125368_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_125368_ActivityPlot = {
    Text = "Après l'achat, « Xu » peut activer <BlueQuality:Illuminer 3>"
  },
  Activity_126275_ActivityName = {
    Text = "Liant auto-enchaîné"
  },
  Activity_126275_ActivityPlot = {
    Text = "La roue tourne doucement, filant à travers les éons sans jamais s'arrêter. Dansez le long des filaments d'argent, ô Grande Tisseuse. Car le destin est la scène à laquelle vous ne pouvez jamais échapper.\nJuge. Rédemptrice. Maîtresse. Captive...\nDès l'instant où vous avez foulé ces planches, le rôle que vous deviez jouer n'était plus le vôtre à choisir."
  },
  Activity_126275_ActivityStageEndContent = {
    Text = "L'événement est terminé. Actuellement, seule la « Boutique de cadeaux du théâtre » est disponible."
  },
  Activity_126275_ActivityTips = {
    Text = "<Title:Aperçu de l'événement>\nPendant l'événement, les Gardiens du secret peuvent collecter la monnaie d'événement «Billet de velours» via le mode de jeu à durée limitée «Scène de la marionnette» et «Succès». Les «Billets de velours» peuvent être échangés contre des récompenses à la «Boutique de cadeaux du théâtre», notamment la Roue du Destin SR exclusive «Rota Fortunae», le Cœur Éthéré, le Cœur Immaculé, les Éclats de Pierre Sage, le Cristal de Mimesis, et plus encore.\n\n<Title:Scène de la marionnette>\n1. «Scène de la marionnette» contient 5 niveaux, avec 1 niveau débloqué tous les 2 jours.\n2. Chaque défi coûte «Ménophine» × 120. Réussir un défi octroie des matériaux de cultivation et de la monnaie d'événement.\n3. Après avoir terminé un niveau, la fonction «Reconstitution» de ce niveau est débloquée. Veuillez noter : le Taux de synchronisation ne peut pas être obtenu en utilisant la fonction «Reconstitution».\n4. Vous pouvez utiliser l'Assistance au combat des anciens élèves pour vous aider à terminer les niveaux plus facilement.\n\n<Title:Bonus d'événement>\n1. Les Gardiens du secret qui possèdent des Corps éveillés ou des Roues du Destin spécifiques (il n'est pas nécessaire de les déployer) peuvent obtenir des bonus de drop supplémentaires pour les «Billets de velours» dans les récompenses de mission de niveau de «Scène de la marionnette» (y compris la Reconstitution). Les bonus spécifiques sont les suivants :\n·Corps éveillé «Arachne» : Dégagement 0/1/2/3 ou plus, bonus 20%/30%/40%/50%\n·Roue du Destin SSR «Tissage Perpétuel» : Superposition 0/1/2/3 ou plus, bonus 20%/30%/40%/50%\n·Roue du Destin SR «Rota Fortunae» : Superposition 0/1/2/3 ou plus, bonus 20%/30%/40%/50%\n2. Le «Bonus d'événement» provenant de différents Corps éveillés ou Roues du Destin est calculé de manière cumulative.\n3. En particulier, les récompenses de première complétion pour la difficulté Folie ne sont pas affectées par les bonus ci–dessus.\n\n<Title: Boutique de cadeaux du théâtre>\n1. Chaque «Échange de cadeaux» coûte 750 «Billets de velours» et octroie aléatoirement cinq récompenses d'objets de la «Boutique de cadeaux du théâtre».\n2. Les récompenses d'objets de la «Boutique de cadeaux du théâtre» sont divisées en «Objet spécial» et «Objet ordinaire». Une rétroaction peut restaurer la quantité restante des récompenses d'Objet spécial au maximum. Les règles spécifiques sont les suivantes :\n(1) 5 premières Rétroactions : Lorsque les «Objets spéciaux» n'ont plus de quantité restante, les Gardiens du secret peuvent choisir de réinitialiser, ce qui rétablira les quantités restantes des «Objets spéciaux» et des «Objets ordinaires» à la limite ; ou ils peuvent choisir de continuer à échanger. Lorsque les «Objets ordinaires» n'ont également plus de quantité restante, une rétroaction doit être effectuée pour continuer à échanger.\n(2) À partir de la 6e Rétroaction : Une rétroaction ne peut être effectuée que lorsque les «Objets ordinaires» n'ont plus de quantité restante. La rétroaction restaurera la quantité restante des «Objets ordinaires» à la limite, tandis que les «Objets spéciaux» ne seront plus réinitialisés.\n\n<Title:Durée de l'événement>\n1. 20 avril, 9:00 – 18 mai, 9:00 (GMT+8) : Tous les modes de jeu de l'événement sont disponibles.\n2. 4 mai, 9:00 – 11 mai, 9:00 (GMT+8) : Seuls la «Boutique de cadeaux du théâtre» et les «Succès» sont disponibles.\n3. Après le 11 mai, 9:00 (GMT+8) : Tous les «Billets de velours» restants non échangés seront convertis au taux de «Billet Rose Dorée» × 40 par billet. N'oubliez pas de vérifier vos récompenses."
  },
  Activity_126275_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_126365_ActivityName = {
    Text = "Journal du Destin"
  },
  Activity_126365_ActivityTips = {
    Text = "Règles de l'événement :\n1. Le Gardien peut recevoir des récompenses dans les Archives du Destin après avoir complété les missions spécifiées.\n2. Les missions sont regroupées, un groupe se débloquant chaque jour après le début de l'événement.\n3. Après avoir débloqué les Archives de Pèlerinage, vous pouvez recevoir des récompenses supplémentaires après avoir complété des missions.\n4. Veuillez noter : les Archives Avancées débloquées ne sont valables que pour cet événement d'Archives."
  },
  Activity_126366_ActivityName = {
    Text = "Pèlerinage résonnant : Règne astral V"
  },
  Activity_126366_ActivityPlot = {
    Text = "Un souvenir scellé et archivé, un voyage enregistré dans le passé. Dans les moments de souvenir, n'oubliez pas d'offrir votre Visite révérencieuse."
  },
  Activity_126492_ActivityName = {
    Text = "Soliloques de Panlong"
  },
  Activity_126492_ActivityTips = {
    Text = "<Title:Chroniques des anciens royaumes>\nCet événement d'archives comprend 8 packs cadeaux ; le premier pack cadeau peut être réclamé gratuitement.\nAprès l'achat de «Chroniques des anciens royaumes», vous pouvez immédiatement réclamer le 2e pack cadeau et débloquer les packs 3 à 8 après des périodes d'attente spécifiques.\nRéclamez jusqu'à «Cœur d'argent» *20 000, «Cœur de Lumens» *30, «Modèle en boucle», «Vue Prototype» et plus encore. Achetez avant le 26 janvier à 9:00 pour recevoir en plus l'avatar exclusif «Véritable forme dans l'éventail» et «Invitation de l'Incorporel» *10 !\nLes achats effectués après cette date n'incluront pas ces récompenses exclusives à durée limitée. Après l'achat, la durée des archives devient permanente et ne se terminera que le jour suivant la réclamation de tous les packs cadeaux.\n«Chroniques des anciens royaumes» est disponible pour une durée limitée ; veuillez effectuer votre achat avant le 23 février à 9:00."
  },
  Activity_126492_BannerText = {
    Text = "Événement spécial Chronologie à durée limitée !"
  },
  Activity_127173_ActivityName = {Text = "Le peintre"},
  Activity_127173_ActivityTips = {
    Text = "<Title:Règles de l'événement>\n· Pendant la durée de l'événement «Le Peintre», le Gardien peut utiliser une équipe prédéfinie par le système contenant Pickman pour expérimenter les niveaux désignés autant de fois qu'il le souhaite.\n· Lors de l'expérience des niveaux de l'événement, il n'est pas possible d'ajuster les Éveilleurs dans l'Escouade.\n<Title:Récompenses de l'événement>\n· Après avoir réussi le défi du niveau pour la première fois, vous pouvez recevoir des récompenses d'essai sur l'interface de l'événement."
  },
  Activity_129488_ActivityName = {
    Text = "Train de plaisir rapide"
  },
  Activity_129488_ActivityPlot = {
    Text = "Dans le train, des rugissements impatients résonnent sans cesse depuis la salle de luxe. \n « Salvador, le troisième wagon a besoin de renfort ! » \n « Wanda, envoie les ennemis que tu contrôles vers l'arrière du train, ils sont à nos trousses ! » \n « Ryker ! Ne flirte pas ! Viens vite chasser le gars dehors de ma fenêtre ! » \n En pleine panique dans le compartiment de luxe, tu n'as pas du tout remarqué qu'une petite silhouette s'était discrètement glissée dans ta poche. \n « Hi hi, c'est bien comme ça que c'est amusant. » \n « J'ai capturé de belles images~ Alors maintenant— il est temps que notre petit « N » entre en scène~ »"
  },
  Activity_129488_ActivityTips = {
    Text = "<Title:Introduction à l'événement>\nPendant la durée de l'événement, les Gardiens du secret peuvent obtenir de riches récompenses temporaires via «Trace de voie de colonne». Après la fin de l'événement, les récompenses dans «Trace de voie de colonne» ne pourront plus être réclamées, veuillez donc récupérer vos récompenses temporaires à temps.\nParticiper à l'événement vous permettra de recevoir une compensation de niveau pour votre équipe : les Éveilleurs de niveau inférieur à 60, de niveau de compétence inférieur à 5, de niveau de «Présage de Folie» inférieur à 6 ou de niveau d'«Aptitude Forge de l'Âme» inférieur à 5 seront compensés à ces minimums. Les Gardiens du secret de niveau inférieur à 60 seront également compensés au niveau 60 pour la durée de ce défi.\n\n<Title:Enregistrement de la task force>\nPendant la durée de l'événement, «Enregistrement de la task force : Train en direction du Festival de la Prière» sera ouvert gratuitement.\nAprès la fin de l'événement, la progression de l'enquête sera conservée. Si «Train en direction du Festival de la Prière» n'a pas été déverrouillé pendant l'événement, il sera toujours possible de le déverrouiller après la fin de l'événement en consommant «Point de départ réel» *7.\nTerminer «Train en direction du Festival de la Prière» vous permettra de recevoir «Décret Clé : Feux d'artifice de fin d'année», que ce soit pendant ou après l'événement.\n<Title:Train de plaisir rapide>\nLe «Train de plaisir rapide» est un mode de défi continu basé sur les règles du «Chapitre des Étoiles». Les Gardiens du secret affronteront consécutivement les derniers chefs rencontrés lors de plusieurs actions d'enquête dans des rencontres aléatoires changeantes !\nDans ce mode, le nombre maximal de reliques détenues peut être augmenté jusqu'à 36.\nLes Gardiens du secret peuvent désormais posséder et renforcer simultanément 3 puissants effets de «Résonance» issus des actions d'enquête.\nChaque utilisation de Gnosis d'urgence réduira de 20% les Points VIP gagnés lors de ce défi ; veuillez planifier votre stratégie d'action avec une prudence accrue.\nIl est possible de quitter le défi à tout moment tout en conservant la progression, mais l'état de l'équipe ne sera pas mis à jour en fonction des changements externes. La progression peut être conservée au maximum jusqu'à 7 jours après le dernier défi ; si aucune nouvelle tentative n'est faite pendant cette période, cela sera considéré comme un abandon du défi.\n\n<Title:Liste VIP>\n1. Pendant la durée de l'événement, les enregistrements dans la «Liste VIP» seront conservés, et seront réinitialisés selon le cycle de l'Activité scolaire après la fin de l'événement.\n2. La «Liste VIP» enregistrera les Gardiens du secret qui se sont distingués dans les défis. Les Gardiens du secret qui participent au moins une fois pendant chaque période d'Activité scolaire et obtiennent des «Points VIP» seront inscrits dans la «Liste VIP».\n3. Le classement dans la «Liste VIP» sera basé sur le maximum de «Points VIP» obtenus en un seul défi et le nombre minimum de «Tours» utilisés. Il est possible de relancer des défis pour améliorer son classement.\n\n<Title:Durée de l'événement>\n1. Du 9 février à 9h00 au 9 mars à 9h00 (GMT+8), tout le contenu de l'événement est ouvert à la participation.\n2. Après le 9 mars à 9h00 (GMT+8), l'événement sera archivé dans «Arcade», et les récompenses dans «Trace de voie de colonne» ne pourront plus être réclamées."
  },
  Activity_129488_BannerText = {
    Text = "Nouvelle activité de jeu spéciale ouverte !"
  },
  Activity_129508_ActivityName = {
    Text = "Événement de déblocage gratuit"
  },
  Activity_129509_ActivityName = {
    Text = "les éclats de lumière du début de l'année"
  },
  Activity_129509_ActivityTips = {
    Text = "Règles de l'événement :\n1. Après chaque connexion quotidienne, le Gardien peut réclamer les récompenses du jour dans « les éclats de lumière de l'année nouvelle ».\n2. Les récompenses seront débloquées en fonction des connexions cumulées, et seront réinitialisées à 9h (GMT+8) chaque jour."
  },
  Activity_129509_BannerText = {
    Text = "Connexion quotidienne pour obtenir des noyaux d'argent et de nombreuses récompenses"
  },
  Activity_129705_ActivityName = {
    Text = "Maître des Flammes Explosives"
  },
  Activity_129705_ActivityTips = {
    Text = "<Title:Règlement de l'événement>\n· Pendant l'événement « Maître des Flammes Explosives », le Gardien peut utiliser des équipes prédéfinies contenant Kadigula pour expérimenter les niveaux spécifiés sans limite. \n· Lors de l'expérience des niveaux de l'événement, il est impossible de modifier les Éveilleurs dans l'escouade. \n<Title:Récompenses de l'événement>\n· Après avoir réussi le défi du niveau pour la première fois, vous pouvez réclamer des récompenses de test sur l'interface de l'événement."
  },
  Activity_129706_ActivityName = {
    Text = "Bishop de baumes"
  },
  Activity_129706_ActivityTips = {
    Text = "<Title:Règles de l'activité>\n·Pendant l'événement \"Évêque Bienveillant\", les Gardiens peuvent utiliser des équipes prédéfinies par le système contenant Salvador pour expérimenter des niveaux désignés un nombre illimité de fois.\n·Lors de la réalisation des niveaux d'événement, des ajustements au Réveiller dans la composition de l'équipe ne peuvent pas être effectués.\n<Title:Récompenses de l'activité>\n·Après avoir réussi un défi de niveau pour la première fois, vous pouvez réclamer des récompenses d'essai depuis l'interface de l'événement."
  },
  Activity_130174_ActivityName = {
    Text = "Événement de déblocage gratuit"
  },
  Activity_130175_ActivityName = {
    Text = "Naissance Inversée"
  },
  Activity_130175_ActivityPlot = {
    Text = "Le monde est bien trop solitaire, le monde est bien trop désolé. Écoutez, s'il vous plaît, soyez témoins.\nLa chair hurlante attend à travers le long silence, attendant que les pissenlits fleurissent dans le désert.\nAlors elle sera emplie d'un amour radieux, et se verra accorder une Nouveau-né guéri une fois encore."
  },
  Activity_130175_ActivityStageEndContent = {
    Text = "L'événement est Terminé. Actuellement, seul le « Jardin de Pissenlits » est disponible."
  },
  Activity_130175_ActivityTips = {
    Text = "<Title:Présentation de l'activité>\n1, Pendant l'activité, les Gardiens du secret peuvent collecter les monnaies d'activité «Poussière d'Écailles Pâles», «Poussière d'Écailles Rouges» et «Poussière d'Écailles Brillantes» via le mode limité «Notes de la Chambre Noire» et les «Récompenses de succès», et les échanger dans le «Jardin de Pissenlits» contre des articles, notamment la Roue du Destin SR limitée «Conte de Fées Terni», des Cœur de Lumens, des Cœur Immaculé, etc.\n2, Pendant l'activité, «Connexion multidimensionnelle : Graine d'Amour Oubliée» est déverrouillée gratuitement pour une durée limitée, et en accomplissant les succès de l'activité, vous pourrez obtenir l'avatar limité «Au nom de la Clé d'Argent : Saya» !\n\n<Title:Durée de l'activité>\n1, Du 30 mai 9:00 au 24 août 9:00(GMT+8), tous les modes d'activité sont accessibles.\n2, Du 24 août 9:00 au 31 août 9:00(GMT+8), seuls le «Jardin de Pissenlits» et les Récompenses de succès sont accessibles.\n\n<Title:Notes de la Chambre Noire>\n1, «Notes de la Chambre Noire» comprend 7 niveaux, avec 1 niveau ouvert automatiquement chaque jour.\n2, Chaque tentative consomme «Ménophine» × 120 ; en cas de succès, vous obtiendrez des monnaies d'activité.\n3, Après avoir terminé un niveau, la fonction «Reconstitution» de ce niveau est déverrouillée. Attention : lors de l'utilisation de la fonction «Reconstitution», il est impossible d'obtenir du Taux de synchronisation.\n4, Vous pouvez utiliser l'Assistance au combat de l'association d'anciens élèves pour vous aider à passer les niveaux plus facilement.\n\n<Title: Jardin de Pissenlits>\n1, Le «Jardin de Pissenlits» comprend trois boutiques, dont les horaires d'ouverture sont les suivants :\n·«Jardin de Culture» : ouverture le 30 mai à 9h.\n·«Jardin de Croissance» : ouverture le 31 mai à 9h.\n·«Jardin en Fleurs» : ouverture le 1er juin à 9h.\n2, Chaque échange consomme «Poussière d'Écailles Pâles»/«Poussière d'Écailles Rouges»/«Poussière d'Écailles Brillantes» × 750, et vous obtiendrez aléatoirement cinq récompenses d'objets du «Jardin de Pissenlits».\n3, Les récompenses d'objets de chaque «Jardin de Pissenlits» se divisent en «Objet spécial» et «Objet ordinaire». Lors d'une réinitialisation, la quantité restante des récompenses d'Objet spécial peut être réinitialisée à son maximum. Les règles spécifiques sont les suivantes :\n(1) Les 2 premières réinitialisations : lorsque les «Objets spéciaux» n'ont plus de quantité restante, le Gardien peut choisir de réinitialiser, ce qui remettra la quantité restante des «Objets spéciaux» et des «Objets ordinaires» à leur maximum ; il peut également choisir de continuer à échanger, et lorsque les «Objets ordinaires» n'ont plus de quantité restante, une réinitialisation est nécessaire pour continuer à échanger.\n(2) À partir de la 3e réinitialisation : la réinitialisation n'est possible que lorsque les «Objets ordinaires» n'ont plus de quantité restante ; la réinitialisation remet la quantité restante des «Objets ordinaires» à leur maximum, les «Objets spéciaux» ne sont plus réinitialisés.\n\n<Title:Bonus d'activité>\n1, Si le Gardien possède certains Éveilleurs ou Roues du Destin spécifiques(sans obligation de les déployer), les trois monnaies d'activité obtenues dans les récompenses de missions de niveau des «Notes de la Chambre Noire» bénéficieront d'un bonus supplémentaire :\n·Éveilleur «Saya» : Dégagement 0/1/2/3 et plus, bonus de 20%/30%/40%/50%.\n·Roue du Destin SSR «Morphogenèse Parfumée» : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%.\n·Roue du Destin SR «Conte de Fées Terni» : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%.\n2, Plusieurs «Bonus d'activité» peuvent être cumulés. \n3, Attention, les récompenses de première complétion en difficulté Folie ne sont pas affectées par les «Bonus d'activité».\n\n<Title:Connexion multidimensionnelle>\n1, Pendant l'activité, «Connexion multidimensionnelle : Graine d'Amour Oubliée» peut être déverrouillée gratuitement.\n2, Après la fin de l'activité, la progression de l'enquête sera conservée ; les Événements d'enquête non terminés pendant l'activité pourront être complétés après celle-ci pour obtenir les récompenses correspondantes. Si le déverrouillage n'a pas été effectué pendant l'activité, il sera toujours possible de dépenser «Point de départ réel» × 3 pour le déverrouiller après la fin de l'activité.\n3, Que ce soit pendant ou après l'activité, Terminer «Connexion multidimensionnelle : Graine d'Amour Oubliée» permet d'obtenir «Décret Clé : Pour le Nouveau Monde»."
  },
  Activity_130175_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_130176_ActivityName = {
    Text = "Agapè en fleurs"
  },
  Activity_130176_ActivityTips = {
    Text = "<Title:Règles de l'événement>\nPendant l'événement « Agapè en fleurs », les Gardiens du secret peuvent utiliser l'escouade prédéfinie par le système contenant Saya pour expérimenter les Niveaux désignés un nombre illimité de fois.\nLors de l'expérience des Niveaux de l'événement, les Corps éveillés de l'Escouade ne peuvent pas être modifiés.\n<Title:Récompenses de l'événement>\nAprès avoir terminé un défi de Niveau pour la première fois, les récompenses d'essai peuvent être récupérées dans l'interface de l'événement."
  },
  Activity_130376_ActivityName = {
    Text = "Texte temporaire"
  },
  Activity_130376_ActivityTips = {
    Text = "<Title:Règles de l'événement>\nPendant l'événement «Origine : Royaume», les Gardiens du secret peuvent utiliser des équipes prédéfinies par le système incluant Origine : Royaume pour expérimenter des niveaux désignés un nombre illimité de fois.\nLors de l'expérience des niveaux de l'événement, les modifications des Éveilleurs dans la formation de l'équipe ne peuvent pas être effectuées.\n<Title:Récompenses de l'événement>\nAprès avoir complété le défi d'un niveau pour la première fois, vous pouvez réclamer les récompenses de démonstration sur l'interface de l'événement."
  },
  Activity_130403_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_130403_ActivityPlot = {
    Text = "Après l'achat, «Origine Ogier» peut activer\n<BlueQuality:Personnalité approfondie +4, Déblocage Surcharge de fureur explosive>"
  },
  Activity_130404_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_130404_ActivityPlot = {
    Text = "Après l'achat, «Sartogoa» peut activer\n<BlueQuality:Personnalité approfondie +4, Déblocage Surcharge de fureur explosive>"
  },
  Activity_130406_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_130406_ActivityPlot = {
    Text = "Après l'achat, «Sartogoa» peut activer <BlueQuality:Dégagement 3>"
  },
  Activity_130407_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_130407_ActivityPlot = {
    Text = "Après l'achat, «Origine Ogier» peut activer <BlueQuality:Dégagement 3>"
  },
  Activity_130408_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_130408_ActivityPlot = {
    Text = "Après l'achat, «Saya» peut activer <BlueQuality:Dégagement 3>"
  },
  Activity_130409_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_130409_ActivityPlot = {
    Text = "Après l'achat, «Saya» peut activer\n<BlueQuality:Personnalité approfondie +4, Déblocage Surcharge de fureur explosive>"
  },
  Activity_130921_ActivityName = {
    Text = "Événement de déblocage gratuit"
  },
  Activity_130922_ActivityName = {Text = "Vortex"},
  Activity_130922_ActivityTips = {
    Text = "<Title:Règles de l'événement>\nPendant l'événement « M – Mosk », les Gardiens du secret peuvent utiliser l'escouade prédéfinie par le système contenant Mosk pour jouer les niveaux désignés un nombre illimité de fois.\nLors des niveaux de l'événement, les Corps éveillés de l'escouade ne peuvent pas être modifiés.\n<Title:Récompenses de l'événement>\nAprès avoir réussi le défi du niveau pour la première fois, vous pouvez récupérer les récompenses d'essai dans l'interface de l'événement."
  },
  Activity_130923_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_130923_ActivityPlot = {
    Text = "Après l'achat, «Mosk» peut activer\n<BlueQuality:Personnalité approfondie +4, Déblocage Surcharge de fureur explosive>"
  },
  Activity_130924_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_130924_ActivityPlot = {
    Text = "Après l'achat, «Mosk» peut activer <BlueQuality:Dégagement 3>"
  },
  Activity_130925_ActivityName = {
    Text = "L'appel de Merscus"
  },
  Activity_130925_ActivityPlot = {
    Text = "Au fond de la mer, le vortex dévore tout. \n Le démon sous le masque ouvre sa grande bouche, invitant également toutes les créatures qui s'en approchent. \n Il tourne jour après jour, hurlant encore et encore, appelant celui qui est destiné à venir. \n Viens, viens, «les algues» s'enrouleront autour de toi, «les récifs» t'accompagneront, dans les profondeurs sombres de la mer, tu es destiné à danser avec le désastre. \n Et le désastre répondra à ta dernière demande. \n Bienvenue chez toi, celui qui est destiné sans choix."
  },
  Activity_130925_ActivityStageEndContent = {
    Text = "Événement terminé, participation uniquement à « Le trésor de Mosk »"
  },
  Activity_130925_ActivityTips = {
    Text = "<Title:Présentation de l'activité>\n1, Pendant la période de l'événement, le Gardien peut collecter la monnaie de l'événement « Coquillage marin numéro un », « Coquillage marin numéro deux », « Coquillage marin numéro trois » via les modes limités « Mosk et la mer » et « Récompenses de succès ». Les « Coquillage marin numéro un », « Coquillage marin numéro deux », « Coquillage marin numéro trois » peuvent être échangés contre des articles dans « Trésor de Mosk », y compris la roue SR limitée de l'événement « Fou emprisonné », Cœur de Lumens, Cœur Immaculé, etc. \n2, Pendant la période de l'événement, « Plongée dans l'inconscient : Addiction » sera déverrouillé gratuitement pendant un temps limité. En complétant les succès de l'événement, vous pouvez également obtenir l'avatar exclusif de l'événement « Au nom de la Clé d'Argent : Mosk » !\n\n<Title:Temps de l'activité>\n1, Du 9 mars 9:00 au 6 avril 9:00 (GMT+8), tous les modes d'événement sont accessibles. \n2, Du 6 avril 9:00 au 13 avril 9:00 (GMT+8), vous ne pouvez participer qu'à « Trésor de Mosk » et aux récompenses de succès. \n\n<Title:Mosk et la mer>\n1, « Mosk et la mer » comprend 7 niveaux, un niveau sera automatiquement ouvert chaque jour. \n2, Chaque défi consommera « Ménophine » × 120, et réussir un défi vous rapportera de la monnaie d'événement. \n3, Après avoir terminé un niveau, la fonction « Reproduire » de ce niveau sera déverrouillée. Veuillez noter : en utilisant la fonction « Reproduire », vous ne pouvez pas obtenir de taux de synchronisation. \n4, Vous pouvez utiliser l'assistance du club des anciens élèves pour vous aider à passer les niveaux plus facilement. \n\n<Title:Trésor de Mosk>\n1, « Trésor de Mosk » a trois magasins, les heures d'ouverture sont les suivantes : \n· « Coffre numéro un » : ouvert le 9 mars à 9 heures. \n· « Coffre numéro deux » : ouvert le 10 mars à 9 heures. \n· « Coffre numéro trois » : ouvert le 11 mars à 9 heures. \n2, Chaque échange consommera « Coquillage marin numéro un »/« Coquillage marin numéro deux »/« Coquillage marin numéro trois » × 750, et vous recevrez aléatoirement cinq récompenses d'objets dans « Trésor de Mosk ». \n3, Les récompenses d'objets de chaque « Trésor de Mosk » sont divisées en deux types : « Objet spécial » et « Objet ordinaire ». Lors de la réinitialisation, vous pouvez réinitialiser le nombre restant des récompenses d'objets spéciaux au maximum, les règles spécifiques sont : \n(1) Pour les 2 premières réinitialisations : lorsque les « objets spéciaux » n'ont plus de quantité restante, le Gardien peut choisir de réinitialiser. Après réinitialisation, le nombre restant des « objets spéciaux » et « objets ordinaires » sera réinitialisé au maximum ; vous pouvez également choisir de continuer à échanger. Lorsque les « objets ordinaires » n'ont plus de quantité restante, vous devez réinitialiser pour continuer à échanger. \n(2) À partir de la 3ème réinitialisation : lorsque les « objets ordinaires » n'ont plus de quantité restante, vous pouvez procéder à la réinitialisation, cela réinitialisera le nombre restant des « objets ordinaires » au maximum, les « objets spéciaux » ne seront plus réinitialisés. \n\n<Title:Bonus d'activité>\n1, Si le Gardien possède un Éveilleur ou une roue spécifique (pas besoin d'être en équipe), cela peut donner un bonus de chute supplémentaire pour les « Coquillage marin numéro un », « Coquillage marin numéro deux », « Coquillage marin numéro trois » dans les récompenses de la mission de niveau « Trésor de Mosk », les bonus spécifiques sont : \n· Éveilleur « Mosk » : Dégagement 0/1/2/3 et plus, bonus de 20%/30%/40%/50%. \n· SSR roue « Jardin d'Éden lointain » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%. \n· SR roue « Fou emprisonné » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%. \n2, Les « Bonus d'activité » de différents Éveilleurs ou roues seront cumulés. \n3, En particulier, la récompense de défi pour la difficulté Folie ne sera pas affectée par les « Bonus d'activité ». \n\n<Title:Plongée dans l'inconscient>\n1, Pendant la période de l'événement, « Plongée dans l'inconscient : Addiction » peut être déverrouillée gratuitement. \n2, Après la fin de l'événement, la progression de l'enquête de « Plongée dans l'inconscient : Addiction » sera conservée. En complétant les événements d'enquête non terminés pendant la période de l'événement, vous pouvez également obtenir les récompenses d'enquête identiques à celles de la période de l'événement. Si « Plongée dans l'inconscient : Addiction » n'a pas été déverrouillée pendant la période de l'événement, vous pourrez toujours dépenser « Point de départ réel » ×3 pour déverrouiller après la fin de l'événement. \n3, Que ce soit pendant ou après la période de l'événement, une fois que vous avez terminé « Plongée dans l'inconscient : Addiction », vous pouvez obtenir « Décret Clé : L'innocence noyée »."
  },
  Activity_130925_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_131090_ActivityName = {
    Text = "Banquet brûlant : Récurrence"
  },
  Activity_131090_ActivityPlot = {
    Text = "Isaraou, la ville au bord du lac, serait selon la légende le lieu d'origine de wanda.\nCette fois, vous passerez par la porte des rêves, atteignant ce vieux groupe de tours recouvertes de cloches"
  },
  Activity_131090_ActivityStageEndContent = {
    Text = "Événement terminé, participation uniquement à « Le trésor de Wanda »"
  },
  Activity_131090_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1, Pendant la durée de l'événement, les Gardiens du secret peuvent collecter la monnaie de l'événement «Os Tibia», «Coquille à feuilles rondes», «Spirale des Ruines» via les modes de jeu temporaires «Fête Brûlante» et «Récompenses de succès». La monnaie de l'événement peut être utilisée pour acheter des articles dans «La Boîte aux Trésors de Wanda», y compris la roue SR limitée à l'événement «Le regard d'Isarau», Cœur de Lumens, Cœur Immaculé, etc. \n2, Pendant la durée de l'événement, «Plongée dans l'inconscient : Fête Brûlante» sera déverrouillé gratuitement pendant une durée limitée, et en complétant les succès de l'événement, vous pourrez également obtenir l'icône de profil limitée à l'événement «Au nom de la Clé d'Argent : Wanda» ! \n\n<Title:Durée de l'événement>\n1, Du 23 mars à 9h00 au 20 avril à 9h00 (GMT+8), tous les modes de jeu sont accessibles. \n2, Du 20 avril à 9h00 au 27 avril à 9h00 (GMT+8), seuls «La Boîte aux Trésors de Wanda» et les récompenses de succès seront accessibles. \n\n<Title:Ville du lac>\n1, La «Ville du lac» comporte 7 niveaux, un niveau s'ouvrira automatiquement chaque jour. \n2, Chaque défi consommera «Ménophine» × 120, et en cas de succès, vous obtiendrez la monnaie de l'événement. \n3, Une fois le niveau terminé, la fonction «Reproduire» de ce niveau sera déverrouillée. Veuillez noter : en utilisant la fonction «Reproduire», vous ne pourrez pas obtenir de taux de synchronisation. \n4, Vous pouvez utiliser l'assistance au combat de l'Association des anciens élèves et «Résonance : Ordre secret» pour vous aider à passer plus facilement le niveau. \n\n<Title:Bonus de trésor>\n1, Les Gardiens du secret possédant un certain Éveilleur ou une roue (pas besoin d'être dans l'équipe) peuvent obtenir un bonus de chute supplémentaire pour la monnaie de l'événement dans les récompenses de la mission de niveau «Ville du lac», les bonus spécifiques sont les suivants : \n· Éveilleur «Wanda» : Dégagement 0/1/2/3 et plus, bonus de 20%/30%/40%/50%. \n· SSR roue «Ordre de la Reine» : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%. \n· SR roue «Le regard d'Isarau» : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%. \n2, Les «bonus de trésor» de différents Éveilleurs ou roues seront calculés de manière cumulée. \n3, En particulier, les récompenses de défi de première réussite en difficulté Folie ne seront pas affectées par les «bonus de trésor». \n\n<Title:Résonance : Ordre secret>\n1, Les Gardiens du secret peuvent obtenir «Cœur de plaisir» en complétant les succès de l'événement. \n2, En dépensant «Cœur de plaisir», activer «Résonance : Ordre secret» permettra aux Gardiens du secret de devenir plus forts dans la «Ville du lac», rendant les défis plus faciles ; cela permettra également aux Gardiens du secret d'obtenir une monnaie de l'événement supplémentaire lors de la victoire. \n\n<Title:Plongée dans l'inconscient>\n1, Pendant la durée de l'événement, «Fête Brûlante» sera déverrouillé gratuitement. \n2, À la fin de l'événement, la progression de l'enquête de «Fête Brûlante» sera conservée, et en complétant les événements d'enquête non terminés pendant l'événement, vous pourrez également obtenir des récompenses d'enquête identiques à celles de la période de l'événement. Si «Fête Brûlante» n'a pas été déverrouillé pendant l'événement, vous pourrez toujours dépenser «Point de départ réel» × 3 pour le déverrouiller après la fin de l'événement. \n3, Que ce soit pendant ou après l'événement, en terminant «Fête Brûlante», vous pourrez obtenir «Décret Clé : Festin pourri». \n\n<Title:Compensation de réplique>\n1, Les Gardiens du secret qui ont déjà déverrouillé «Plongée dans l'inconscient : Fête Brûlante» recevront une compensation de «Os Tibia» × 300 lors du déverrouillage à nouveau pendant cet événement de réplique. \n2, Les Gardiens du secret qui ont déjà obtenu l'icône de profil limitée à l'événement «Au nom de la Clé d'Argent : Wanda» verront leur obtention répétée automatiquement convertie en «Invitation de l'Incorporel» × 1. \n3, Les Gardiens du secret qui ont déjà obtenu le matériel d'activation de résonance «Cœur de plaisir», chaque «Cœur de plaisir» supplémentaire obtenu sera automatiquement converti en «Billet Rose Dorée» × 5000. \n"
  },
  Activity_131090_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_131091_ActivityName = {
    Text = "Fête Brûlante"
  },
  Activity_131370_ActivityName = {
    Text = "Gagnant chanceux"
  },
  Activity_131370_ActivityTips = {
    Text = "<Title:Aperçu de l'événement>\n1. Après avoir terminé les tâches d'archives désignées, les Gardiens du secret peuvent réclamer des récompenses dans «Gagnant chanceux».\n2. «Gagnant chanceux» se terminera le 6 avril à 9:00.\n3. Débloquez les «Archives Avancées» pour réclamer des récompenses supplémentaires après avoir terminé les tâches.\n4. Veuillez noter : les «Archives Avancées» débloquées dans cet événement ne sont valables que pour cet événement. Gardiens du secret, veuillez consommer de manière raisonnable."
  },
  Activity_131370_BannerText = {
    Text = "Événement spécial Chronologie à durée limitée !"
  },
  Activity_131849_ActivityName = {
    Text = "Mémoire éternelle"
  },
  Activity_131849_ActivityTips = {
    Text = "<Title:Mémoire éternelle>\n\nCes Chroniques limitées contiennent 8 packs cadeaux. Le premier pack cadeau peut être récupéré gratuitement directement, tandis que les packs cadeaux 2 à 8 nécessitent l'achat de « Mémoire éternelle » avant de pouvoir être récupérés.\n\nAprès l'achat de « Mémoire éternelle », les récompenses du 2e pack cadeau peuvent être récupérées immédiatement ; les packs cadeaux suivants nécessitent d'attendre un certain temps avant de pouvoir être récupérés.\n\nAcheter « Mémoire éternelle » avant 9:00 le 30 mai accordera également des récompenses supplémentaires : l'avatar exclusif « Bon Appétit » et « Invitation de l'Incorporel » ×10 ! Acheter après 9:00 le 30 mai n'accordera plus les récompenses exclusives à durée limitée.\n\nVeuillez noter : « Mémoire éternelle » sera disponible à l'achat jusqu'au 29 juin, 9:00."
  },
  Activity_131849_BannerText = {
    Text = "Événement spécial Chronologie à durée limitée !"
  },
  Activity_132331_ActivityName = {
    Text = "Madame en rouge"
  },
  Activity_132331_ActivityTips = {
    Text = "<Title:Règles de l'événement>\nPendant l'événement « Dame en Rouge », les Gardiens du secret peuvent utiliser l'escouade prédéfinie par le système contenant « Sorel » pour jouer les niveaux désignés un nombre illimité de fois.\nLors des niveaux de l'événement, les Corps éveillés de l'escouade ne peuvent pas être modifiés.\n<Title:Récompenses de l'événement>\nAprès avoir réussi le défi du niveau pour la première fois, vous pouvez récupérer les récompenses d'essai dans l'interface de l'événement."
  },
  Activity_132332_ActivityName = {
    Text = "Événement de déblocage gratuit"
  },
  Activity_132333_ActivityName = {
    Text = "Résurrection du Roi des Dieux"
  },
  Activity_132333_ActivityPlot = {
    Text = "Dans le désir infini des souhaits, il se réveille brièvement dans son long sommeil et jette un vrai coup d'œil à ce monde terne.\nDans l'éternité, ce regard est si bref"
  },
  Activity_132333_ActivityStageEndContent = {
    Text = "L'événement est terminé. Actuellement, seul \"Abysse de la Connaissance\" est disponible."
  },
  Activity_132333_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1, Pendant l'événement, les Gardiens du secret peuvent collecter des monnaies d'événement « Pensées fatiguées », « Tristesse mélancolique », « Pensées joyeuses » à travers les modes de jeu temporaires « Regard de la mer profonde » et « Récompenses de succès ». Les monnaies d'événement peuvent être utilisées pour acheter des articles dans « Conscience abyssale », y compris la roue SR limitée de l'événement « Trône de pierre bleue », Cœur de Lumens, Cœur Immaculé, Éclats de Pierre Sage, Cristal de Mimesis, etc. \n2, Pendant l'événement, terminer les succès de l'événement vous permettra également d'obtenir l'avatar limité de l'événement « Au nom de la Clé d'Argent : Tulu », la roue SR limitée de l'événement « Trône de pierre bleue », Cœur d'argent et une grande quantité de monnaies d'événement ! \n\n<Title:Durée de l'événement>\n1, Du 6 avril à 9h00 au 4 mai à 9h00 (GMT+8), tous les modes de jeu de l'événement seront accessibles. \n2, Du 4 mai à 9h00 au 11 mai à 9h00 (GMT+8), seuls « Conscience abyssale » et les récompenses de succès seront accessibles. \n\n<Title:Regard de la mer profonde>\n1, « Regard de la mer profonde » comporte 5 niveaux, un niveau s'ouvrant automatiquement tous les 2 jours. \n2, Chaque défi consommera « Ménophine » × 120, réussir le défi vous rapportera des monnaies d'événement. \n3, Après avoir terminé un niveau, la fonction « Reproduire » de ce niveau sera débloquée. Veuillez noter : en utilisant la fonction « Reproduire », aucun taux de synchronisation ne sera obtenu. \n4, Vous pouvez utiliser l'assistance au combat des anciens élèves pour vous aider à passer les niveaux plus facilement. \n\n<Title:Bonus de pensées>\n1, Les Gardiens du secret possédant un Éveilleur ou une roue spécifique (non requis pour être en combat) peuvent obtenir un bonus de chute supplémentaire sur les monnaies d'événement des récompenses de mission de « Regard de la mer profonde », les bonus spécifiques sont les suivants : \n· Éveilleur « Tulu » : Dégagement 0/1/2/3 et plus, bonus de 20%/30%/40%/50%. \n· Roue SSR « Hymne au Dieu-Roi » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%. \n· Roue SR « Trône de pierre bleue » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%. \n2, Les « Bonus de pensées » de différents Éveilleurs ou roues seront calculés de manière cumulative. \n3, De manière spéciale, les récompenses de défi de difficulté Folie ne seront pas affectées par les « Bonus de pensées ». \n\n<Title:Conscience abyssale>\n1, « Conscience abyssale » sera ouverte uniquement du 6 avril à 9h00 au 11 mai à 9h00 (GMT+8). \n2, Après le 11 mai à 9h00 (GMT+8), les « Pensées fatiguées », « Tristesse mélancolique », « Pensées joyeuses » non échangées restantes seront récupérées au taux de « Billet Rose Dorée » × 40 par échange, veuillez les Gardiens du secret vérifier leurs e-mails. \n\n<Title:Plongée dans l'inconscient>\n1, Pendant l'événement, « Plongée dans l'inconscient : Jour du couronnement » peut être déverrouillé gratuitement. \n2, Après la fin de l'événement, la progression d'enquête de « Plongée dans l'inconscient : Jour du couronnement » sera conservée, et en terminant les événements d'enquête non complétés pendant l'événement, vous pourrez également obtenir des récompenses d'enquête identiques à celles de la période de l'événement. Si « Plongée dans l'inconscient : Jour du couronnement » n'a pas été déverrouillé pendant l'événement, il pourra encore être déverrouillé après l'événement en consommant « Point de départ réel » × 3. \n3, Que ce soit pendant ou après l'événement, après avoir terminé « Plongée dans l'inconscient : Jour du couronnement », vous pourrez obtenir « Décret Clé : Bénédiction des Étoiles ». \n\n<Title:Compensation de réplique>\n1, Les Gardiens du secret qui ont déjà déverrouillé « Plongée dans l'inconscient : Jour du couronnement » recevront une compensation de « Pensées fatiguées » × 300 lors du déverrouillage de cette réplique pendant l'événement. \n2, Les Gardiens du secret qui ont déjà obtenu l'avatar limité de l'événement « Au nom de la Clé d'Argent : Tulu » verront leur répétition automatiquement convertie en « Invitation de l'Incorporel » × 1."
  },
  Activity_132333_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_132334_ActivityName = {
    Text = "Souverain endormi"
  },
  Activity_132334_ActivityTips = {
    Text = "<Title:Règles de l'événement>\nPendant l'événement « Le Maître Endormi », les Gardiens du secret peuvent utiliser l'escouade prédéfinie par le système contenant « Tulu » pour jouer les niveaux désignés un nombre illimité de fois.\nLors des niveaux d'essai, les Corps éveillés de l'escouade ne peuvent pas être modifiés.\n<Title:Récompenses de l'événement>\nAprès avoir réussi le défi du niveau pour la première fois, vous pouvez récupérer les récompenses d'essai dans l'interface de l'événement."
  },
  Activity_132688_ActivityName = {
    Text = "Changement de comms"
  },
  Activity_132688_ActivityTips = {
    Text = "<Title:Présentation de l'activité>\n 1, Après avoir accompli les tâches désignées de l'activité, les Gardiens du secret peuvent récupérer des «Cœur de Lumens», l'avatar Limité de l'activité «Winkle·Grand Terminal», «Erica·Terminal Portable» ainsi que la «Collection de timbres : Gardien», sans oublier les récompenses Limitées de l'activité telles que la nouvelle tenue fantôme 1 étoile «Nautila·Réminiscence Complexe» et «Helot·Moment de rupture» ! \n 2, Cette activité est ouverte en permanence. Une fois toutes les tâches de l'activité accomplies et toutes les récompenses réclamées, l'activité se termine le lendemain à 9h00(GMT+8) et ne sera plus affichée.\n 3, Si vous avez déjà accompli les tâches «Se connecter via un appareil PC» ou «Se connecter via un appareil mobile» dans la fonctionnalité de récompenses de connexion, elles ne seront pas comptabilisées à nouveau comme accomplies ici."
  },
  Activity_132908_ActivityName = {
    Text = "Texte temporaire"
  },
  Activity_132908_ActivityTips = {
    Text = "Règles de l'événement :\n1. Après avoir terminé les missions d'archives désignées, les Gardiens du secret peuvent réclamer des récompenses dans «Texte temporaire».\n2. Après avoir débloqué les «Archives Avancées», terminer les missions accordera des récompenses supplémentaires.\n3. Les «Archives Avancées» de cet événement sont disponibles à l'achat pour une durée limitée. Elles ne seront plus disponibles à l'achat après la date limite. Veuillez effectuer votre achat à votre convenance avant le 20 mai à 9:00.\n6. Veuillez noter : les «Archives Avancées» débloquées dans cet événement ne sont valables que pour cet événement. Veuillez dépenser de manière raisonnable."
  },
  Activity_132908_BannerText = {
    Text = "Événement spécial Chronologie à durée limitée !"
  },
  Activity_132934_ActivityName = {
    Text = "Baiser de Croc"
  },
  Activity_132934_ActivityTips = {
    Text = "<Title:Introduction>\n·Pendant l'événement, le Gardien peut recevoir des récompenses correspondantes dans le « Baiser de Croc » après avoir atteint les objectifs spécifiés."
  },
  Activity_132934_BannerText = {
    Text = "Recevez gratuitement un vêtement fantomatique !"
  },
  Activity_133271_ActivityName = {
    Text = "Événement de déblocage gratuit"
  },
  Activity_133272_ActivityName = {
    Text = "La Grande Conquête : Réplique"
  },
  Activity_133272_ActivityPlot = {
    Text = "Un grand âge finira peut-être par disparaître, mais la volonté des grands guerriers ne s'éteindra jamais. \n Les tombes ne peuvent les enterrer, les chaînes ne peuvent les dompter. \n Quand de nouveaux chemins se dessinent, des rôtis appétissants attendent au terme de la voie de la conquête, les guerriers lancent une charge et s'emparent du butin glorieux. \n Célébrons par des chants cette bravoure immortelle, cet empire sacré ! \n Rome ! Rome !"
  },
  Activity_133272_ActivityStageEndContent = {
    Text = "Événement terminé, participation actuelle uniquement à « Offrir un tribut »"
  },
  Activity_133272_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, les Gardiens du secret peuvent collecter la monnaie d'événement «Délicieux barbecue de Léon» via l'activité de jeu à durée limitée «Chasse Divine». «Délicieux barbecue de Léon» peut être utilisé dans «Offrir un tribut» pour acheter des objets, notamment le Cœur Éthéré, le Cœur Immaculé, et bien plus encore.\n2. Pendant l'événement, «Monde des Rêves Étranges : Conquête de la cuisine» est temporairement débloqué gratuitement.\n\n<Title:Période de l'événement>\n1. 4 mai, 9h00 – 18 mai, 9h00 (GMT+8) : Toutes les activités de jeu de l'événement sont disponibles.\n2. 18 mai, 9h00 – 25 mai, 9h00 (GMT+8) : Seulement «Offrir un tribut» et les Récompenses de succès sont disponibles.\n\n<Title:Chasse Divine>\n1. «Chasse Divine» contient 5 niveaux, avec 1 niveau débloqué automatiquement tous les 2 jours.\n2. Chaque défi consomme Ménophine × 120, et réussir un défi récompense de la monnaie d'événement.\n3. Après avoir terminé un niveau, la fonction «Reconstitution» de ce niveau sera débloquée. Veuillez noter : le Taux de synchronisation ne peut pas être obtenu lors de l'utilisation de la fonction «Reconstitution».\n4. Vous pouvez utiliser l'Assistance au combat d'anciens élèves pour vous aider à terminer les niveaux plus facilement.\n\n<Title: Offrir un tribut>\nDans la boutique «Offrir un tribut», vous pouvez utiliser la monnaie d'événement «Délicieux barbecue de Léon» pour sélectionner et acheter directement des objets.\n\n<Title:Monde des Rêves Étranges>\n1. Pendant l'événement, «Monde des Rêves Étranges : Conquête de la cuisine» peut être débloqué gratuitement.\n2. Après la fin de l'événement, la progression de la Mission d'enquête de «Monde des Rêves Étranges : Conquête de la cuisine» sera conservée. Compléter les Événements d'enquête non terminés pendant l'événement récompensera toujours les mêmes récompenses d'enquête qu'au cours de l'événement. Si «Monde des Rêves Étranges : Conquête de la cuisine» n'a pas été débloqué pendant l'événement, il peut toujours être débloqué après la fin de l'événement en consommant «Point de départ réel» × 7.\n3. Que ce soit pendant ou en dehors de la période d'événement, terminer «Monde des Rêves Étranges : Conquête de la cuisine» récompensera «Décret Clé : Résolution vorace»."
  },
  Activity_133272_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_133301_ActivityName = {
    Text = "L'Heure du Thé"
  },
  Activity_133301_ActivityTips = {
    Text = "<Title:Règles de l'événement>\n1. Après avoir accompli les tâches désignées des Archives, les Gardiens du secret peuvent réclamer des récompenses dans «L'Heure du Thé».\n2. «L'Heure du Thé» se terminera le 18 mai à 9h00.\n3. Débloquez les «Archives Avancées» pour réclamer des récompenses supplémentaires en accomplissant des tâches.\n4. Veuillez noter : les «Archives Avancées» débloquées dans cet événement ne sont valables que pour cet événement. Gardiens du secret, veuillez consommer de manière raisonnée."
  },
  Activity_133301_BannerText = {
    Text = "Événement spécial Chronologie à durée limitée !"
  },
  Activity_134393_ActivityName = {
    Text = "Ex Stellaris"
  },
  Activity_134393_ActivityPlot = {
    Text = "Connectez-vous chaque jour pour récupérer la Roue du Destin SSR commémorative limitée « Ex Stellaris », jusqu'à 16 au total !"
  },
  Activity_134393_ActivityTips = {
    Text = "<Title:Règles de l'événement>\n·Pendant l'événement, les Gardiens du secret peuvent se connecter chaque jour pour récupérer la Roue du Destin SSR commémorative limitée « Aux étoiles » dans « Aux étoiles », pour un total de 16 réclamations.\n·Les récompenses seront débloquées séquentiellement en fonction des connexions cumulées du Gardien. Les récompenses de connexion quotidiennes seront actualisées à 9:00 (GMT+8)."
  },
  Activity_134393_BannerText = {
    Text = "RdD SSR limitée gratuite"
  },
  Activity_138582_ActivityName = {
    Text = "Cour des Floraisons"
  },
  Activity_138582_ActivityTips = {
    Text = "<Title:Règles de l'événement>\n1. Après avoir accompli les missions d'archives spécifiées, les Gardiens du secret peuvent récupérer des récompenses dans «Cour des Floraisons.»\n2. «Cour des Floraisons» se terminera le 15 juin à 09:00.\n3. Après avoir débloqué les «Archives Avancées,» des récompenses supplémentaires peuvent être récupérées en accomplissant les missions.\n4. Veuillez noter : Les «Archives Avancées» débloquées lors de cet événement ne sont valables que pour cet événement. Veuillez dépenser judicieusement à votre discrétion."
  },
  Activity_138582_BannerText = {
    Text = "Événement spécial Chronologie à durée limitée !"
  },
  Activity_139116_ActivityName = {
    Text = "Rendez-vous onirique"
  },
  Activity_139116_ActivityTips = {
    Text = "<Title:Règles de l'événement>\n·Les Gardiens du secret peuvent récupérer des récompenses du « Rendez-vous onirique » après avoir accompli les tâches désignées.\n·Après avoir débloqué les « Archives Avancées », des récompenses supplémentaires peuvent être récupérées en accomplissant les tâches.\n·L'achat des « Archives Avancées » est limité dans le temps cette fois-ci. Il ne sera plus possible de les acheter après la date limite. Veuillez effectuer votre achat à votre convenance avant le 29 juin, 9:00 (GMT+8).\n·Veuillez noter : les « Archives Avancées » débloquées lors de cet événement ne sont valables que pour cet événement. Les Gardiens du secret sont invités à dépenser judicieusement."
  },
  Activity_139116_BannerText = {
    Text = "Récupérez gratuitement un tout nouveau Corps éveillé en édition limitée !"
  },
  Activity_139117_ActivityName = {
    Text = "Offrande onirique"
  },
  Activity_139117_ActivityTips = {
    Text = "<Title:Introduction>\n·Pendant l'événement, après avoir accompli les objectifs spécifiés, les Gardiens du secret peuvent récupérer les récompenses correspondantes dans «Offrande onirique.»"
  },
  Activity_139117_BannerText = {
    Text = "Récupérez des Rêve des Étoiles gratuitement !"
  },
  Activity_139591_ActivityName = {
    Text = "Miaou obligé !"
  },
  Activity_139591_ActivityPlot = {
    Text = "« Avis d'urgence : tout le personnel et les étudiants, veuillez cesser immédiatement vos activités en cours et aider à capturer les sujets d'expérience échappés. »\n« Répétition : tout le personnel et les étudiants, veuillez cesser immédiatement vos activités en cours et aider à capturer les sujets échap—Bon sang ! Les chats sont entrés ! »\n\nLorsque vous avez entendu la voix paniquée dans les haut-parleurs, le campus entier était déjà englouti sous une fourrure noire, et tout le monde s'agitait pour attraper ces petits fauteurs de troubles échappés du laboratoire.\nComme pour se venger de la Fête de l'An, ces chats noirs convergeaient lentement et méthodiquement vers votre dortoir.\n\nMais en y réfléchissant... vu la grande quantité de Billets Rose Dorée et de Cœurs d'argent qu'ils transportent, difficile de dire s'ils sont là pour se venger ou pour rendre la pareille.\nAttention toutefois à ne pas trop en attraper."
  },
  Activity_139591_ActivityStageEndContent = {
    Text = "Événement terminé"
  },
  Activity_139591_ActivityTips = {
    Text = "<Title: Miaou obligé !>\nMiaou obligé ! comprend 7 niveaux uniques et non répétables qui doivent être affrontés directement. Un nouveau niveau se débloque chaque jour.\nVaincre le « Chat noir dimensionnel » correspondant dans chaque défi contribue à la progression de l'événement. Les récompenses peuvent être récupérées via le « Journal de capture du Chat ».\nChaque « Chat noir dimensionnel » possède de nombreux duplicatas—les défis peuvent être tentés un nombre illimité de fois pendant l'événement et prennent en charge le combat automatique.\nChaque niveau fournit différentes Reliques qui accordent de puissants bonus.\nTous les niveaux nécessitent un Gardien d'Assistance au combat. Pendant l'événement, chaque Gardien mutuellement suivi ne peut vous fournir une assistance qu'une seule fois.\n\n\n<Title: Compensation de Niveau>\nMiaou obligé ! inclut un système de compensation de niveau pour que tous les Gardiens du secret puissent combattre côte à côte !\nLes règles de compensation sont les suivantes :\nLes Corps éveillés de votre équipe en dessous du niveau 60 seront compensés au niveau 60 pour la durée du défi.\nLes Corps éveillés de votre équipe avec des niveaux de compétence inférieurs à 5 seront compensés au niveau de compétence 5 pour la durée du défi.\nLes Corps éveillés de votre équipe avec un Présage de Folie inférieur au niveau 6 seront compensés au niveau 6 pour la durée du défi.\nLes Corps éveillés de votre équipe avec une Aptitude Forge de l'Âme inférieure au niveau 5 seront compensés au niveau 5 pour la durée du défi.\nLes Gardiens du secret en dessous du niveau 60 seront compensés au niveau 60 pour la durée du défi.\n\n<Title: Journal de capture du Chat noir>\nPendant l'événement, vaincre le « Chat noir dimensionnel » correspondant accumule la progression de quête, permettant aux Gardiens du secret de récupérer des récompenses via le « Journal de capture du Chat ». Le Journal est divisé en deux sections : « Journal de capture personnel » et « Journal de capture du campus ». Le « Journal de capture personnel » suit la progression individuelle de chaque Gardien. Le « Journal de capture du campus » suit la progression combinée de tous les Gardiens du secret à l'échelle du campus.\n\n<Title: Classements de capture>\nPendant l'événement, les Gardiens du secret peuvent consulter le « Classement des gardiens » et le « Classement de soutien » sous « Classements de capture ».\n\n<Title: Durée de l'événement>\nLes Gardiens du secret peuvent accéder à la page de l'événement et rejoindre le défi avant 9:00, le 15 juin (GMT+8). Aucun nouveau Gardien ne sera admis après cette heure. Les Gardiens du secret qui ont déjà rejoint peuvent continuer à participer si l'événement n'est pas encore terminé.\nSi le « Total des captures » est atteint avant 9:00, le 15 juin (GMT+8), l'événement se terminera le 29 juin à 9:00 (GMT+8). Si le « Total des captures » n'est pas atteint à cette date, l'événement se terminera 14 jours après que le « Total des captures » aura été atteint."
  },
  Activity_139591_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_139922_ActivityName = {
    Text = "Shaggai hypnotique"
  },
  Activity_139922_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Lors de l'événement \"Ver Hypnotique\", le Gardien peut utiliser des équipes prédéfinies par le système qui incluent Clémentine pour vivre des étapes spécifiées à l'infini.\n·Lors de l'expérience des étapes de l'événement, des ajustements aux Réveilleurs dans la composition de l'équipe ne peuvent pas être effectués.\n<Title:Récompenses de l'Événement>\n·Après avoir terminé le défi d'étape pour la première fois, vous pouvez réclamer les récompenses d'essai depuis l'interface de l'événement."
  },
  Activity_139923_ActivityName = {
    Text = "Symphonie invisible"
  },
  Activity_139923_ActivityPlot = {
    Text = "La symphonie est un art de tissage, où les trajectoires des instruments se croisent pour former une carte complexe.\nDans son réseau, chaque note a son rôle.\nÉcoutez, une symphonie exceptionnelle commence"
  },
  Activity_139923_ActivityStageEndContent = {
    Text = "Événement terminé, participation actuelle uniquement à «Palais du sommeil»"
  },
  Activity_139923_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, les Gardiens du secret peuvent collecter la monnaie d'événement «Chant héroïque» via le mode de jeu à durée limitée «Son tonnant» et les «Récompenses de succès.» Les «Chant héroïque» peuvent être échangés contre de généreuses récompenses dans le «Palais du Sommeil,» y compris la Roue du Destin SR en édition limitée «Concert sans Fin,» des «Cœur Immaculé,» des «Cœur de Lumens,» des «Éclats de Pierre Sage,» des «Cristal de Mimesis,» et plus encore.\n2. Pendant l'événement, accomplir les missions des «Récompenses de succès» octroiera l'avatar en édition limitée «Au nom de la Clé d'argent : Hamelin,» la Roue du Destin SR en édition limitée «Concert sans Fin,» des Argent, et une grande quantité de monnaie d'événement «Chant héroïque.»\n\n<Title:Durée de l'événement>\n1. 15 juin, 9:00 – 13 juillet, 9:00 (GMT+8) : Tout le contenu de l'événement est disponible.\n2. 13 juillet, 9:00 – 20 juillet, 9:00 (GMT+8) : Seuls le «Palais du Sommeil» et les «Récompenses de succès» resteront disponibles. Tout le reste du contenu sera Terminé et ne pourra plus être consulté.\n\n<Title: Son tonnant>\n1. «Son tonnant» contient 9 Niveaux, avec 1 qui s'ouvre automatiquement chaque jour.\n2. Chaque tentative de défi coûte Neurobrew × 120. Défier différents Niveaux donnera différentes récompenses de matériaux ainsi que la monnaie d'événement «Chant héroïque.»\n3. Les Niveaux de cet événement sont des Niveaux de matériaux en combat direct. Après les avoir terminés, ils peuvent être rejoués ! Chaque replay coûte Neurobrew × 120.\n4. Veuillez noter : Lors de l'utilisation de la fonction de replay, le Taux de Synchronisation ne peut pas être obtenu.\n\n<Title: Bonus d'Aria>\n1. Les Gardiens du secret qui possèdent des Corps éveillé ou des Roues du Destin spécifiques (déploiement non requis) peuvent recevoir des bonus de «Chant héroïque» dans les récompenses de mission des Niveaux de «Son tonnant» (replays inclus). Les bonus spécifiques sont les suivants :\n·Corps éveillé «Hamelin» : Dégagement 0/1/2/3 ou plus, bonus 20%/30%/40%/50%\n·Roue du Destin SSR «Requiem Éternel» : Superposition 0/1/2/3 ou plus, bonus 20%/30%/40%/50%\n·Roue du Destin SR «Concert sans Fin» : Superposition 0/1/2/3 ou plus, bonus 20%/30%/40%/50%\n2. Le «Bonus d'Aria» de différents Corps éveillé ou Roues du Destin est calculé de manière additive.\n3. Plus précisément, les récompenses de premier Terminer en difficulté Folie ne sont pas affectées par le «Bonus d'Aria.»\n\n<Title: Palais du Sommeil>\n1. Le «Palais du Sommeil» n'est ouvert que du 15 juin, 9:00 au 13 juillet, 9:00 (GMT+8).\n2. Après le 20 juillet, 9:00 (GMT+8), les «Chant héroïque» restants non échangés seront convertis au taux de Billet Rose Dorée × 40 par unité. Veuillez vérifier votre courrier."
  },
  Activity_139923_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_139924_ActivityName = {
    Text = "Interprète éternel"
  },
  Activity_139924_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Lors de l'événement \"Interprète Éternel\", les Gardiens peuvent utiliser des équipes prédéfinies par le système qui incluent Hameln pour vivre des niveaux désignés à l'infini.\n·Lors de l'expérience des niveaux de l'événement, des ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir réussi à terminer le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_139925_ActivityName = {
    Text = "Dame des abysses"
  },
  Activity_139925_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n· Pendant l'événement \"Dame Aequor\", les Gardiens peuvent utiliser des équipes préétablies par le système qui incluent Murphy pour vivre les niveaux désignés indéfiniment.\n· Pendant l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n· Après avoir réussi à compléter le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_140080_ActivityName = {
    Text = "Événement de déblocage gratuit"
  },
  Activity_140081_ActivityName = {
    Text = "La flamme vivante"
  },
  Activity_140081_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n· Pendant l'événement \"Seigneur des Flammes Explosives\", les Gardiens peuvent utiliser une équipe présélectionnée du système, incluant Kathigu-Ra, pour vivre le niveau spécifié un nombre illimité de fois.\n· Lors de l'expérience des niveaux de l'événement, des ajustements aux Réveilleurs dans la composition ne peuvent pas être effectués.\n<Title:Récompenses de l'Événement>\n· Lors de la première complétion du défi de niveau, vous pouvez réclamer des récompenses d'essai sur l'interface de l'événement."
  },
  Activity_140082_ActivityName = {
    Text = "Des milliers de lumières brillantes descendent·clon"
  },
  Activity_140082_ActivityPlot = {
    Text = "Ils chantent la chanson de l'éternel souvenir, accueillant le Seigneur immortel. \n Il descendra des cieux avec d'innombrables lumières, proclamant l'éclat impérissable. \n Au moment de Sa venue, la lumière ambrée recouvrira le monde. \n C'est le chant funèbre qu'Il offre au monde."
  },
  Activity_140082_ActivityStageEndContent = {
    Text = "L'événement est Terminé. Actuellement, seule «Base Secrète» est disponible."
  },
  Activity_140082_ActivityTips = {
    Text = "<Title:Présentation de l'activité>\n1, Pendant la durée de l'activité, les Gardiens du secret peuvent collecter les monnaies d'activité «Sceau de la Richesse», «Sceau de la Mort» et «Sceau de Guerre» via les modes de jeu limités «Chasse des Cendres», «La Fête sans Conflits» et les Récompenses de Succès. Les «Sceau de la Richesse», «Sceau de la Mort» et «Sceau de Guerre» peuvent être utilisés pour acheter des articles dans «Base Secrète», notamment la Roue du Destin SR limitée «Soleil Imminent», des Cœur de Lumens, des Cœur Immaculé, etc.\n2, Pendant la durée de l'activité, «Jour Éternel» sera déverrouillé gratuitement pour une durée limitée. Accomplir les succès de l'activité vous permettra également d'obtenir l'avatar limité «Au nom de la Clé d'Argent : Kadigula» !\n\n<Title:Durée de l'activité>\n1, Du 7 septembre 9:00 au 5 octobre 9:00(GMT+8), tous les modes de jeu de l'activité sont accessibles.\n2, Du 5 octobre 9:00 au 12 octobre 9:00(GMT+8), seuls «Base Secrète» et les Récompenses de Succès sont accessibles.\n\n<Title:Chasse des Cendres>\n1, «Chasse des Cendres» comprend 7 niveaux, avec 1 niveau déverrouillé automatiquement chaque jour.\n2, Chaque tentative consommera «Ménophine» × 120 ; en cas de succès, vous obtiendrez des monnaies d'activité.\n3, Après avoir terminé un niveau, la fonction «Reconstitution» de ce niveau est déverrouillée. Veuillez noter : lors de l'utilisation de la fonction «Reconstitution», il est impossible d'obtenir du Taux de synchronisation.\n4, Vous pouvez utiliser l'Assistance au combat de l'association d'anciens élèves pour vous aider à passer les niveaux plus facilement.\n\n<Title: Base Secrète>\n«Base Secrète» comprend trois boutiques, dont les horaires d'ouverture sont les suivants :\n·«Coffre de Collection» : ouverture le 7 septembre à 9h.\n·«Chambre des commissions» : ouverture le 8 septembre à 9h.\n·«Campement de combat» : ouverture le 9 septembre à 9h.\nDans la boutique, vous pouvez sélectionner des articles et les acheter directement.\n\n<Title:Bonus d'activité>\n1, Si un Gardien possède certains Corps éveillés ou Roues du Destin(sans obligation de les mettre en jeu), les «Sceau de la Richesse», «Sceau de la Mort» et «Sceau de Guerre» obtenus dans les récompenses de missions du niveau «Chasse des Cendres» bénéficieront d'un bonus de drop supplémentaire. Les détails des bonus sont les suivants :\n·Corps éveillé «Kadigula» : Dégagement 0/1/2/3 et plus, bonus de 20%/30%/40%/50%.\n·Roue du Destin SSR «Mort ambre» : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%.\n·Roue du Destin SR «Soleil Imminent» : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%.\n2, Les «Bonus d'activité» de différents Corps éveillés ou Roues du Destin se cumulent.\n3, En particulier, les récompenses de la première victoire en difficulté Folie ne sont pas affectées par les «Bonus d'activité».\n\n<Title: La Fête sans Conflits>\n1, Vous obtenez automatiquement 60 «Sceau de la Richesse» par heure, avec un stockage maximum de 25 heures.\n\n<Title:Plongée dans l'inconscient>\n1, Pendant la durée de l'activité, «Jour Éternel» peut être déverrouillé gratuitement.\n2, Après la fin de l'activité, la progression des enquêtes de «Jour Éternel» sera conservée. Vous pourrez obtenir les mêmes récompenses d'enquête qu'pendant l'activité en complétant les Événements d'enquête non terminés. Si «Jour Éternel» n'a pas été déverrouillé pendant l'activité, il pourra toujours être déverrouillé après la fin de l'activité en consommant «Point de départ réel» × 3.\n3, Que ce soit pendant ou après l'activité, terminer «Plongée dans l'inconscient : Jour Éternel» vous permettra d'obtenir «Décret Clé : Soleil Éternel»."
  },
  Activity_140082_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_140188_ActivityName = {
    Text = "Flot d'engouement"
  },
  Activity_140188_ActivityTips = {
    Text = "<Title:Introduction>\n·Pendant l'événement, après que le Gardien a extrait cumulativement une quantité spécifiée d'Élixir de Cœur d'argent lors de l'« Extraction de liquide source », les récompenses correspondantes peuvent être récupérées dans « Flot d'engouement ».\n·Veuillez noter que l'Élixir de Cœur d'argent offert lors de l'« Extraction de liquide source » ne sera pas comptabilisé dans le montant cumulé d'Élixir de Cœur d'argent extrait pour l'événement."
  },
  Activity_140188_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_140462_ActivityName = {
    Text = "Prologue de toutes choses"
  },
  Activity_140462_ActivityTips = {
    Text = "<Title:Introduction>\n·Pendant l'événement, après avoir accompli les objectifs spécifiés, les Gardiens du secret peuvent récupérer les récompenses correspondantes dans « Prologue de la nature »."
  },
  Activity_140462_BannerText = {
    Text = "Recevez gratuitement un vêtement fantomatique !"
  },
  Activity_140760_ActivityName = {Text = "Pollux"},
  Activity_140760_ActivityTips = {
    Text = "<Title:Règles de l'événement>\n· Pendant la période de l'événement « Pollux », les gardiens peuvent utiliser des équipes prédéfinies incluant Pollux pour expérimenter indéfiniment les niveaux désignés.\n· Lors de l'expérience des niveaux de l'événement, il est impossible d'ajuster les corps réveillés dans l'équipe.\n<Title:Récompenses de l'événement>\n· Après avoir accompli le défi du niveau pour la première fois, il est possible de recevoir les récompenses d'essai à l'interface de l'événement."
  },
  Activity_140761_ActivityName = {
    Text = "Lueur de Mareel"
  },
  Activity_140761_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n· Pendant l'événement \"Lumière Froide\", les Gardiens peuvent utiliser des équipes préréglées par le système incluant Kepler Sangan pour expérimenter des niveaux désignés un nombre illimité de fois.\n· Lors de l'expérience des niveaux de l'événement, les ajustements ne peuvent pas être effectués sur les Réveilleurs au sein de la composition de l'équipe.\n<Title:Récompenses de l'Événement>\n· Après avoir réussi un défi de niveau pour la première fois, vous pouvez réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_140762_ActivityName = {Text = "Matsuka"},
  Activity_140762_ActivityTips = {
    Text = "<Title:Règles de l'événement>\n· Pendant l'événement « Aube scellée », les Gardiens peuvent utiliser des compositions prédéfinies par le système incluant Mouchette pour expérimenter les étapes désignées un nombre illimité de fois.\n· Lors de l'expérience des étapes de l'événement, aucune modification des Éveilleurs dans la composition ne peut être effectuée.\n<Title:Récompenses de l'événement>\n· Après avoir complété le défi de l'étape pour la première fois, vous pouvez réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_140763_ActivityName = {
    Text = "Poème sans nom"
  },
  Activity_140763_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Pendant l'événement \"Poème Sans Nom\", les Gardiens peuvent utiliser des équipes préétablies par le système incluant Horla pour expérimenter des niveaux désignés à l'infini.\n·Lors de l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir réussi à terminer le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_140764_ActivityName = {
    Text = "Seigneur de nécrovia"
  },
  Activity_140764_ActivityTips = {
    Text = "<Title:Règles de l'événement>\n· Pendant l'événement \"Seigneur des Inhumations\", les Gardiens peuvent utiliser une équipe prédéfinie par le système incluant Durusain pour vivre le niveau spécifié un nombre illimité de fois.\n· Lors de l'expérience des niveaux de l'événement, aucun ajustement des Réveilleurs dans la composition ne peut être effectué.\n<Title:Récits de l'événement>\n· Lors de la première réalisation du défi de niveau, vous pouvez réclamer des récompenses d'essai sur l'interface de l'événement."
  },
  Activity_141306_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_141306_ActivityPlot = {
    Text = "Après l'achat, «Pontos» peut activer <BlueQuality:Dégagement 3>"
  },
  Activity_141307_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_141307_ActivityPlot = {
    Text = "Après l'achat, «Pontos» peut activer\n<BlueQuality:Personnalité approfondie +4, déverrouiller la Sur-Exaltation>"
  },
  Activity_141308_ActivityName = {
    Text = "La Source du Gouffre"
  },
  Activity_141308_ActivityTips = {
    Text = "<Title:Règles de l'activité>\nPendant la durée de l'activité «La Source du Gouffre», les Gardiens du secret peuvent utiliser l'Escouade prédéfinie du système incluant Pontos pour expérimenter les Niveaux désignés un nombre illimité de fois.\nLors de l'expérience des Niveaux de l'activité, il est impossible d'ajuster les Corps éveillés de l'Escouade.\n<Title:Récompenses de l'activité>\nAprès avoir relevé le défi d'un Niveau pour la première fois, vous pouvez réclamer les récompenses d'essai dans l'interface de l'activité."
  },
  Activity_141460_ActivityName = {
    Text = "Divus: la plume d'onyx"
  },
  Activity_141460_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n· Pendant l'événement \"Sacred Blackwing\", les Gardiens peuvent utiliser l'équipe prédéfinie du système contenant Castor pour vivre des étapes spécifiées indéfiniment.\n· Les Réveilleurs dans la composition de l'équipe ne peuvent pas être ajustés pendant les étapes de l'événement.\n<Title:Récompenses de l'Événement>\n· Après avoir réussi un défi d'étape pour la première fois, une récompense d'essai peut être réclamée dans l'interface de l'événement."
  },
  Activity_141462_ActivityName = {
    Text = "Souverain endormi"
  },
  Activity_141462_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Lors de l'événement \"Souverain du Sommeil\", les Gardiens peuvent utiliser des équipes prédéfinies par le système comprenant Tulu pour vivre des niveaux désignés à l'infini.\n·Lors de l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir terminé avec succès le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_141464_ActivityName = {
    Text = "La Matriarche d'Obsidienne des Mille Fans"
  },
  Activity_141464_ActivityTips = {
    Text = "<Title:Règles de l'événement>\n·Pendant l'événement « Matriarche Obsidienne des Mille Éventails », les Gardiens peuvent utiliser des formations prédéfinies par le système qui incluent Xu pour vivre des étapes désignées un nombre illimité de fois.\n·Lors de l'expérience des étapes de l'événement, les ajustements aux Éveilleurs dans la formation ne sont pas autorisés.\n<Title:Récompenses de l'événement>\n·Après avoir réussi le défi de l'étape pour la première fois, vous pouvez réclamer des récompenses d'essai depuis l'interface de l'événement."
  },
  Activity_141466_ActivityName = {
    Text = "Événement de déblocage gratuit"
  },
  Activity_141467_ActivityName = {
    Text = "Prisonnier Miroir·clon"
  },
  Activity_141467_ActivityPlot = {
    Text = "Oiseau, oiseau, pourquoi as-tu des chaînes brisées aux pieds ? \nOiseau, oiseau, pourquoi cries-tu seul dans le ciel ? \nLibère-toi des ronces, échappe à la cage, tu as volé au-delà des étendues désertiques, mais ton cri triste ne s'est jamais arrêté. \nQui est donc celui que tu cherches comme compagnon fidèle ? \nOù est donc l'endroit que tu cherches comme véritable patrie ?\n\n?"
  },
  Activity_141467_ActivityStageEndContent = {
    Text = "Événement terminé, participation actuelle uniquement à « Avidité de savoir »"
  },
  Activity_141467_ActivityTips = {
    Text = "<Title:Présentation de l'activité>\n1, Pendant la durée de l'activité, les Gardiens du secret peuvent collecter les monnaies d'activité «Livre de sens commun», «Livre de mathématiques» et «Livre de littérature» via les modes de jeu limités «Traversée du ciel bleu», «Croisière Onirique» et les Récompenses de Succès. Les «Livre de sens commun», «Livre de mathématiques» et «Livre de littérature» peuvent être utilisés pour acheter des articles dans «Désir de connaissance», notamment la Roue du Destin SR limitée «Plume Solitaire», des Cœur de Lumens, des Cœur Immaculé, etc.\n2, Pendant la durée de l'activité, «Monde des Rêves Étranges : Au-delà de l'horizon·Haut» sera déverrouillé gratuitement pour une durée limitée. Accomplir les succès de l'activité vous permettra également d'obtenir l'avatar limité «Au nom de la Clé d'Argent : Castor» !\n\n<Title:Durée de l'activité>\n1, Du 5 octobre 9:00 au 2 novembre 9:00(GMT+8), tous les modes de jeu de l'activité sont accessibles.\n2, Du 2 novembre 9:00 au 9 novembre 9:00(GMT+8), seuls «Désir de connaissance» et les Récompenses de Succès sont accessibles.\n\n<Title:Traversée du ciel bleu>\n1, «Traversée du ciel bleu» comprend 7 niveaux, avec 1 niveau déverrouillé automatiquement chaque jour.\n2, Chaque tentative consommera «Ménophine» × 120 ; en cas de succès, vous obtiendrez des monnaies d'activité.\n3, Après avoir terminé un niveau, la fonction «Reconstitution» de ce niveau est déverrouillée. Veuillez noter : lors de l'utilisation de la fonction «Reconstitution», il est impossible d'obtenir du Taux de synchronisation.\n4, Vous pouvez utiliser l'Assistance au combat de l'association d'anciens élèves pour vous aider à passer les niveaux plus facilement.\n\n<Title: Désir de connaissance>\n«Désir de connaissance» comprend trois boutiques, dont les horaires d'ouverture sont les suivants :\n·«Cours électifs généraux» : ouverture le 5 octobre à 9h.\n·«Classe optative de sciences» : ouverture le 6 octobre à 9h.\n·«Classe optionnelle de littérature» : ouverture le 7 octobre à 9h.\nDans la boutique, vous pouvez sélectionner des articles et les acheter directement.\n\n<Title:Bonus d'activité>\n1, Si un Gardien possède certains Corps éveillés ou Roues du Destin(sans obligation de les mettre en jeu), les «Livre de sens commun», «Livre de mathématiques» et «Livre de littérature» obtenus dans les récompenses de missions du niveau «Traversée du ciel bleu» bénéficieront d'un bonus de drop supplémentaire. Les détails des bonus sont les suivants :\n·Corps éveillé «Castor» : Dégagement 0/1/2/3 et plus, bonus de 20%/30%/40%/50%.\n·Roue du Destin SSR «Liberté Insupportable» : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%.\n·Roue du Destin SR «Plume Solitaire» : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%.\n2, Les «Bonus d'activité» de différents Corps éveillés ou Roues du Destin se cumulent.\n3, En particulier, les récompenses de la première victoire en difficulté Folie ne sont pas affectées par les «Bonus d'activité».\n\n<Title: Croisière Onirique>\n1, Vous obtenez automatiquement 60 «Livre de sens commun» par heure, avec un stockage maximum de 25 heures.\n\n<Title:Monde des Rêves Étranges>\n1, Pendant la durée de l'activité, «Monde des Rêves Étranges : Au-delà de l'horizon·Haut» peut être déverrouillé gratuitement.\n2, Après la fin de l'activité, la progression des enquêtes de «Monde des Rêves Étranges : Au-delà de l'horizon·Haut» sera conservée. Vous pourrez obtenir les mêmes récompenses d'enquête qu'pendant l'activité en complétant les Événements d'enquête non terminés. Si «Monde des Rêves Étranges : Au-delà de l'horizon·Haut» n'a pas été déverrouillé pendant l'activité, il pourra toujours être déverrouillé après la fin de l'activité en consommant «Point de départ réel» × 7.\n3, Que ce soit pendant ou après l'activité, terminer «Monde des Rêves Étranges : Au-delà de l'horizon·Haut» vous permettra d'obtenir «Décret Clé : Déplacement du Destin»."
  },
  Activity_141467_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_141509_ActivityName = {
    Text = "Carnet de voyage secret"
  },
  Activity_141509_ActivityTips = {
    Text = "<Title:Règles de l'activité>\n1, Après avoir accompli les missions d'archives désignées, les Gardiens du secret peuvent réclamer des récompenses dans le «Carnet de voyage secret».\n2, Le «Carnet de voyage secret» se terminera le 27 juillet à 09:00.\n3, Après avoir déverrouillé les «Archives Avancées», des récompenses supplémentaires peuvent être réclamées après l'accomplissement des missions.\n4, Attention : les «Archives Avancées» déverrouillées dans cette activité ne sont valables que pour cette activité. Veuillez consommer de manière raisonnée et réfléchie."
  },
  Activity_141509_BannerText = {
    Text = "Événement spécial Chronologie à durée limitée !"
  },
  Activity_141533_ActivityName = {
    Text = "Ebwynnos Evermore"
  },
  Activity_141533_ActivityPlot = {
    Text = "Rions aux éclats, célébrons jusqu'à l'aube.\nQue nos crochets transpercent la gorge de nos ennemis, que les heures banales rouillent au fond du gouffre.\nNous ne serons plus jamais rattrapés par la vieillesse, la médiocrité et la solitude.\nIci, c'est Ebwynnos, nous sommes éternellement heureux, éternellement réunis.\nNous ne nous séparerons jamais."
  },
  Activity_141533_ActivityStageEndContent = {
    Text = "L'Événement est Terminé, seuls les «Terrains de Chasse» sont actuellement accessibles."
  },
  Activity_141533_ActivityTips = {
    Text = "<Title:Présentation de l'activité>\n1, Pendant l'activité, les Gardiens du secret peuvent collecter les monnaies d'activité «Fraîche »Proie«», «Colossale »Proie«» et «Primordiale »Proie«» via le mode de jeu limité «La Chasse de la Haute Maison» et les «Récompenses de succès», puis les échanger dans les «Terrains de Chasse» contre des articles, notamment la Roue du Destin SR limitée «La Boussole errante», le Cœur de Lumens, le Cœur Immaculé, etc.\n2, Pendant l'activité, la «Plongée dans l'inconscient : Ebwynnos Evermore» est déverrouillée gratuitement pour une durée limitée. En accomplissant les succès de l'activité, vous pouvez également obtenir l'avatar limité «Au nom de la Clé d'Argent : Pontos» !\n\n<Title:Durée de l'activité>\n1, Du 29 juin 9:00 au 27 juillet 9:00(GMT+8), tous les modes de jeu de l'activité sont accessibles.\n2, Du 27 juillet 9:00 au 3 août 9:00(GMT+8), seuls les «Terrains de Chasse» et les Récompenses de succès sont accessibles.\n\n<Title:La Chasse de la Haute Maison>\n1, «La Chasse de la Haute Maison» contient 7 Niveaux, avec 1 nouveau Niveau débloqué automatiquement chaque jour.\n2, Chaque tentative consomme «Ménophine» × 120 ; en cas de succès, vous obtiendrez des monnaies d'activité.\n3, Après avoir Terminé un Niveau, la fonction «Reconstitution» de ce Niveau est déverrouillée. Attention : l'utilisation de la fonction «Reconstitution» ne permet pas d'obtenir de Taux de synchronisation.\n4, Vous pouvez utiliser l'Assistance au combat de l'association des anciens élèves pour Terminer les Niveaux plus facilement.\n\n<Title: Terrains de Chasse>\nLes «Terrains de Chasse» comprennent trois boutiques, dont les horaires d'ouverture sont les suivants :\n·«Fer Froid» : ouverture le 29 juin à 9h.\n·«Feu et Soufre» : ouverture le 30 juin à 9h.\n·«Sorcellerie» : ouverture le 1er juillet à 9h.\nDans la boutique, vous pouvez sélectionner des articles et les acheter directement.\n\n<Title:Bonus d'activité>\n1, Les Gardiens du secret possédant certains Corps éveillés ou Roues du Destin spécifiques(sans obligation de les mettre en jeu) peuvent obtenir un bonus de drop supplémentaire sur les trois types de monnaies d'activité dans les récompenses de missions des Niveaux de «La Chasse de la Haute Maison» :\n·Corps éveillé «Pontos» : Dégagement 0/1/2/3 et plus, bonus de 20%/30%/40%/50%.\n·Roue du Destin SSR «Cage vivante» : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%.\n·Roue du Destin SR «La Boussole errante» : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%.\n2, Les «Bonus d'activité» de différents Corps éveillés ou Roues du Destin se cumulent.\n3, En particulier, les récompenses de première réussite en difficulté Folie ne sont pas affectées par le «Bonus d'activité».\n\n<Title:Plongée dans l'inconscient>\n1, Pendant l'activité, la «Plongée dans l'inconscient : Ebwynnos Evermore» peut être déverrouillée gratuitement.\n2, Après la fin de l'activité, la progression de l'enquête sera conservée. Les Événements d'enquête non terminés pendant l'activité pourront être complétés après celle-ci et donneront les mêmes récompenses correspondantes. Si elle n'a pas été déverrouillée pendant l'activité, il sera toujours possible de la déverrouiller après la fin de l'activité en consommant «Point de départ réel» × 3.\n3, Que ce soit pendant ou en dehors de la période d'activité, Terminer la «Plongée dans l'inconscient : Ebwynnos Evermore» permet d'obtenir le «Décret Clé : Homme creux»."
  },
  Activity_141533_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_141534_ActivityName = {
    Text = "Événement de déblocage gratuit"
  },
  Activity_141535_ActivityName = {
    Text = "L'Été éternel sous le Soleil noir·clon"
  },
  Activity_141535_ActivityPlot = {
    Text = "Été, bord de mer, soleil éblouissant et nombreux visages familiers. \n Sous les rayons brûlants du soleil, oubliez tout et laissez-vous entraîner dans ce rêve fou qui réalise toutes vos fantaisies."
  },
  Activity_141535_ActivityTips = {
    Text = "<Title:Présentation de l'activité>\n1, Pendant l'activité, le «Monde des Rêves Étranges : Au revoir, Pays Imaginaire» est déverrouillé gratuitement pour une durée limitée !\n2, Pendant l'activité, en vous connectant 7 jours cumulés, vous pouvez obtenir «Cœur de Lumens» × 10 dans la «Fête estivale» ; le 7e jour, vous recevrez en plus l'avatar de combat limité «Volleyball \"Grand Général\"».\n\n<Title:Durée de l'activité>\n1, Du 6 juillet 9:00 au 20 juillet 9:00(GMT+8), toutes les activités sont accessibles.\n\n<Title:Monde des Rêves Étranges>\n1, Pendant l'activité, le «Monde des Rêves Étranges : Au revoir, Pays Imaginaire» peut être déverrouillé gratuitement.\n2, Après la fin de l'activité, la progression de l'enquête du «Monde des Rêves Étranges : Au revoir, Pays Imaginaire» sera conservée. Les Événements d'enquête non terminés pendant l'activité pourront être complétés après celle-ci et donneront les mêmes récompenses d'enquête qu'pendant l'activité. Si le «Monde des Rêves Étranges : Au revoir, Pays Imaginaire» n'a pas été déverrouillé pendant l'activité, il sera toujours possible de le déverrouiller après la fin de l'activité en consommant «Point de départ réel» × 7.\n3, Que ce soit pendant ou en dehors de la période d'activité, Terminer le «Monde des Rêves Étranges : Au revoir, Pays Imaginaire» permet d'obtenir le «Décret Clé : Souvenir d'un été figé»."
  },
  Activity_141535_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_141536_ActivityName = {
    Text = "Événement de déblocage gratuit"
  },
  Activity_142866_ActivityName = {
    Text = "Genèse Fond marin Dame des mers"
  },
  Activity_142866_ActivityTips = {
    Text = "<Title:Règles de l'événement>\n· Lors de l'ouverture de l'événement « Dame des Profondeurs Originelles », le gardien du secret peut utiliser l'équipe prédéfinie incluant « Dame des Profondeurs Originelles » pour expérimenter indéfiniment les niveaux désignés.\n· Lors de l'expérience du niveau événementiel, il est impossible d'ajuster l'éveillé dans la formation.\n<Title:Récompenses de l'événement>\n· Après avoir accompli le défi du niveau pour la première fois, il est possible de recevoir la récompense d'essai à l'interface événementielle."
  },
  Activity_142867_ActivityName = {
    Text = "Chasseresse de crânes"
  },
  Activity_142867_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Pendant l'événement \"Chasseresse des Crânes\", les Gardiens peuvent utiliser des équipes préétablies par le système incluant Jonquille pour expérimenter des niveaux désignés à l'infini.\n·Lors de l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir réussi à terminer le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_143933_ActivityName = {
    Text = "Événement de déblocage gratuit"
  },
  Activity_144359_ActivityName = {
    Text = "Témoin de Tout"
  },
  Activity_144359_ActivityTips = {
    Text = "<Title:Aperçu de l'événement>\n1. Après avoir accompli les tâches Archives désignées, les Gardiens du secret peuvent réclamer des récompenses dans « Témoin de Tout ».\n2. « Témoin de Tout » se terminera le 24 août à 9h00.\n3. Débloquez les « Archives Avancées » pour réclamer des récompenses supplémentaires lors de l'accomplissement des tâches.\n4. Remarque : les « Archives Avancées » débloquées dans cet événement ne sont valables que pour cet événement. Gardiens du secret, veuillez consommer de manière raisonnée."
  },
  Activity_144359_BannerText = {
    Text = "Événement spécial Chronologie à durée limitée !"
  },
  Activity_145382_ActivityName = {
    Text = "Chute de Baleine"
  },
  Activity_145382_ActivityTips = {
    Text = "<Title:Règles de l'événement>\nPendant l'événement « Chute de Baleine », les Gardiens du secret peuvent utiliser des compositions prédéfinies par le système incluant « Lotan : Cétarque » pour expérimenter les étapes désignées un nombre illimité de fois.\n Lors de l'expérience des étapes de l'événement, les Éveilleurs de la composition ne peuvent pas être modifiés.\n<Title:Récompenses de l'événement>\nAprès avoir terminé le défi de l'étape pour la première fois, vous pouvez réclamer les récompenses d'essai sur l'interface de l'événement."
  },
  Activity_145383_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_145383_ActivityPlot = {
    Text = "Après l'achat, « Lotan : Cétarque » peut activer <BlueQuality:Dégagement 3>"
  },
  Activity_145384_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_145384_ActivityPlot = {
    Text = "Après l'achat, « Lotan : Cétarque » peut activer\n<BlueQuality:Personnalité approfondie +4, Débloquer la Sur-Exaltation>"
  },
  Activity_145458_ActivityName = {
    Text = "Le Jeu du Léviathan"
  },
  Activity_145458_ActivityPlot = {
    Text = "Des héros avides convoitent des trônes immortels, des mères désespérées cherchent à ressusciter leurs enfants, et des sorciers fous ont soif de savoirs interdits — ils s'agenouillent devant Lui, Le suppliant avec les mêmes mots qu'Il entend depuis plus de dix mille ans.\nIl leur accorde tout, pour mieux les regarder tout perdre. Il a été témoin de quatre mille combats brutaux, et pourtant reste insatiable.\nCette fois, les portes de l'arène s'ouvrent pour vous. Venez, dites-Lui — qu'est-ce que vous désirez ?\nDites-Lui en quoi vous différez de ces quatre mille âmes déchues."
  },
  Activity_145458_ActivityStageEndContent = {
    Text = "Événement terminé, participation actuelle uniquement à «Texte temporaire»"
  },
  Activity_145458_ActivityTips = {
    Text = "<Title:Aperçu de l'événement>\nPendant l'événement, les Gardiens du secret peuvent collecter la monnaie d'événement « Sacrifice Cramoisi » via le gameplay limité « Cupidité et Soif de Sang » et les « Succès ». Le « Sacrifice Cramoisi » peut être échangé contre des récompenses à l'« Autel de l'Arène », notamment la Roue du Destin SR exclusive « Os-Faim Impérissable », des Cœur de Lumens, des Cœur Immaculé, des Éclats de Pierre Sage, des Cristal de Mimesis, et bien plus encore.\n\n<Title:Cupidité et Soif de Sang>\n1. « Cupidité et Soif de Sang » contient 5 étapes, avec 1 étape débloquée automatiquement toutes les 2 jours.\n2. Chaque défi consomme 120 Ménophine. Réussir un défi récompense la monnaie d'événement « Sacrifice Cramoisi ».\n3. Après avoir terminé une étape, la fonction « Reconstitution » de cette étape est débloquée. Remarque : le Taux de synchronisation ne peut pas être obtenu lors de l'utilisation de la fonction « Reconstitution ».\n4. Vous pouvez utiliser le Soutien des Anciens Élèves pour vous aider à franchir les étapes plus facilement.\n\n<Title:Bonus d'événement>\n1. Les Gardiens du secret possédant des Éveilleurs ou des Roues du Destin spécifiques (sans obligation de les déployer) peuvent obtenir des bonus de butin supplémentaires pour le « Sacrifice Cramoisi » dans les récompenses de mission des étapes « Cupidité et Soif de Sang » (y compris la Reconstitution). Les bonus spécifiques sont les suivants :\nÉveilleur « Lotan : Cétarque » : Dégagement 0/1/2/3 ou plus, bonus de 20%/30%/40%/50%.\nRoue du Destin SSR « Cetus Occasus » : Superposition 0/1/2/3 ou plus, bonus de 20%/30%/40%/50%.\nRoue du Destin SR « Os-Faim Impérissable » : Superposition 0/1/2/3 ou plus, bonus de 20%/30%/40%/50%.\n2. Les « Bonus d'événement » provenant de différents Éveilleurs ou Roues du Destin sont calculés de manière cumulative.\n3. En particulier, les récompenses de première complétion des défis en difficulté Folie ne sont pas affectées par les bonus mentionnés ci-dessus.\n\n<Title:Plongée dans l'inconscient>\n1. Pendant l'événement, « Plongée dans l'inconscient : Jusqu'à la Chute du Cétus » peut être débloqué gratuitement.\n2. Après la fin de l'événement, la progression d'enquête de « Plongée dans l'inconscient : Jusqu'à la Chute du Cétus » sera conservée. Terminer les Événements d'enquête non achevés pendant l'événement rapportera toujours les mêmes récompenses d'enquête qu'au cours de l'événement. Si « Plongée dans l'inconscient : Jusqu'à la Chute du Cétus » n'a pas été débloqué pendant l'événement, il peut toujours être débloqué après la fin de l'événement en consommant « Point de départ réel » ×3.\n3. Que ce soit pendant ou après la période d'événement, terminer « Plongée dans l'inconscient : Jusqu'à la Chute du Cétus » récompensera le « Décret Clé : Tempête Dévoreuse de Cetus ».\n\n<Title:Durée de l'événement>\n1. Du 27 juillet, 9h00 au 24 août, 9h00 (GMT+8) : tout le contenu de l'Aperçu de l'événement est disponible.\n2. Du 24 août, 9h00 au 31 août, 9h00 (GMT+8) : seuls l'« Autel de l'Arène » et les « Récompenses de Succès » restent disponibles ; tout autre contenu a pris fin et n'est plus accessible.\n3. Après le 31 août, 9h00 (GMT+8), tout « Sacrifice Cramoisi » restant non échangé sera converti au taux de 40 Billet Rose Dorée par unité. Veuillez consulter votre courrier, Gardiens du secret."
  },
  Activity_145458_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_145459_ActivityName = {
    Text = "Événement de déblocage gratuit"
  },
  Activity_145465_ActivityName = {
    Text = "Si tout est normal·clon"
  },
  Activity_145465_ActivityPlot = {
    Text = "Tu as déjà rêvé de ce que serait la vie de tout le monde si la catastrophe n'était jamais survenue. \n Ton pouvoir de sauver le monde n'a plus d'utilité, tu dois te battre chaque jour pour une vie scolaire ordinaire et gagner des crédits dérisoires. Sur le terrain, il n'y a plus d'ombres s'entraînant au combat, remplacées par des rangées de tentes pour les activités de clubs et les cris de promotion et de plaisanterie ; lorsque la cloche de la fin des cours sonne, les étudiants affamés envahissent immédiatement la cantine... \n En frappant aux portes des personnes qui te tiennent à cœur, quels sourires verras-tu ?"
  },
  Activity_145465_ActivityStageEndContent = {
    Text = "[Si tout est normal] L'événement est Terminé, actuellement il est seulement possible de participer au «Bâtiment du bureau de l'association des étudiants»"
  },
  Activity_145465_ActivityTips = {
    Text = "<Title:Aperçu de l'événement>\n1. Pendant l'événement, vous pouvez collecter la monnaie d'événement « Coquillages de spécialité côtière » via le gameplay limité « Rien de nouveau sous le soleil ». Vous pouvez utiliser les « Coquillages de spécialité côtière » pour acheter des objets au « Bâtiment du bureau de l'association des étudiants », notamment des Cœur de Lumens, des Cœur Immaculé, des Éclats de Pierre Sage, et bien plus encore.\n2. Pendant l'événement, « Monde des Rêves Étranges : Adieu, le Pays des Merveilles » sera disponible en accès gratuit limité !\n\n<Title:Durée de l'événement>\n1. Du 3 août, 9h00 au 17 août, 9h00 (GMT+8) : tout le gameplay de l'événement est disponible.\n2. Du 17 août, 9h00 au 24 août, 9h00 (GMT+8) : vous pouvez uniquement participer au « Bâtiment du bureau de l'association des étudiants » et récupérer les Récompenses de Succès.\n\n<Title:Rien de nouveau sous le soleil>\n1. « Rien de nouveau sous le soleil » comprend 5 niveaux, avec un niveau qui s'ouvre automatiquement toutes les 2 jours.\n2. Chaque défi consomme 120 Ménophine, et les défis réussis vous rapporteront la monnaie d'événement.\n3. Après avoir terminé un niveau, la fonction « Reconstitution » de ce niveau sera débloquée. Remarque : lorsque vous utilisez la fonction « Reconstitution », vous ne pouvez pas obtenir de Taux de synchronisation.\n4. Vous pouvez solliciter l'aide des Anciens Élèves pour faciliter la progression dans les niveaux.<Title:Bâtiment du bureau de l'association des étudiants>\nLe « Bâtiment du bureau de l'association des étudiants » dispose d'une boutique qui ouvre le 3 août à 9h00.\nDans la boutique, vous pouvez sélectionner des objets pour les acheter directement.\n\n<Title:Monde des Rêves Étranges>\n1. Pendant l'événement, vous pouvez débloquer « Monde des Rêves Étranges : Adieu, le Pays des Merveilles » gratuitement.\n2. Après la fin de l'événement, votre progression d'enquête dans « Monde des Rêves Étranges : Adieu, le Pays des Merveilles » sera conservée. Terminer les événements d'enquête inachevés de la période d'événement vous rapportera toujours les récompenses d'enquête correspondant à la période d'événement. Si vous n'avez pas débloqué « Monde des Rêves Étranges : Adieu, le Pays des Merveilles » pendant l'événement, vous pouvez toujours le débloquer après l'événement en consommant « Point de départ réel » ×7.\n3. Que ce soit pendant ou après l'événement, terminer « Monde des Rêves Étranges : Adieu, le Pays des Merveilles » vous accordera le « Décret Clé : Un instant de beau rêve »."
  },
  Activity_145465_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_145466_ActivityName = {
    Text = "Événement de déblocage gratuit"
  },
  Activity_145717_ActivityName = {
    Text = "Nouvelle Lune et Neige Profonde"
  },
  Activity_145717_ActivityPlot = {
    Text = "Le rite d'adoration septuple, le serment sacré triple — portez une foi fervente en la fée d'un blanc immaculé et gravissez l'endroit où le ciel et la neige se rejoignent, et elle exaucera chacun de vos vœux. Jusqu'au dernier. Chaque âme a son but, et derrière chaque but se cache son propre mensonge. Déterrez-les. Mettez-les en lumière... avant de vous abandonner à la surface parfaite de son récit. Ne vous enfoncez pas dans cette neige profonde à ses côtés."
  },
  Activity_145717_ActivityStageEndContent = {
    Text = "L'événement est terminé. Actuellement, seuls les «Rituels de la Fée» sont disponibles."
  },
  Activity_145717_ActivityTips = {
    Text = "<Title:Aperçu de l'événement>\n1. Pendant l'événement, les Gardiens du secret peuvent collecter les monnaies d'événement «Pomme Cramoisie», «Pomme Dorée» et «Pomme d'Amour» via le gameplay limité «Trésors d'Umapati» et les «Succès», et les échanger contre des articles à la «Cérémonie des Fées», notamment la Roue du Destin SR exclusive «vérité douce et agréable», le Cœur de Lumens, le Cœur Immaculé, et bien plus encore.\n2. Compléter les succès de l'événement pendant la durée de celui-ci permet également d'obtenir l'avatar exclusif «Au nom de la Clé d'Argent : Caraboo» !\n\n<Title:Durée de l'événement>\n1. 24 août, 9h00 – 21 septembre, 9h00 (UTC+8) : Tout le gameplay de l'événement est disponible.\n2. 21 septembre, 9h00 – 28 septembre, 9h00 (UTC+8) : Seuls les «Rituels de la Fée» et les récompenses de succès sont disponibles.\n<Title:Trésors d'Umapati>\n1. «Trésors d'Umapati» contient 7 étapes, avec 1 étape débloquée automatiquement chaque jour.\n2. Chaque défi consomme 120 Ménophine. Réussir un défi récompense des monnaies d'événement.\n3. Après avoir terminé une étape, la fonction «Reproduire» de cette étape est débloquée. Veuillez noter : le Taux de synchronisation ne peut pas être obtenu lors de l'utilisation de la fonction «Reproduire».\n4. Vous pouvez utiliser le Soutien des Anciens Élèves pour vous aider à franchir les étapes plus facilement.\n\n<Title:Rituels de la Fée>\n1. «Rituels de la Fée» comporte trois boutiques, avec les horaires d'ouverture suivants :\n«Bénédiction de Neige» : Ouvre à 9h00 le 24 août.\n«Bénédiction de Givre» : Ouvre à 9h00 le 25 août.\n«Bénédiction de Blanc» : Ouvre à 9h00 le 26 août.\n2. Chaque «Recevoir des Bénédictions» consommera 750 «Pomme Cramoisie»/«Pomme Dorée»/«Pomme d'Amour» pour obtenir aléatoirement cinq récompenses d'objets des «Rituels de la Fée».\n3. Les récompenses d'objets dans chaque «Rituels de la Fée» sont divisées en deux types : «Objet spécial» et «Objet ordinaire». Lors d'une réinitialisation, la quantité restante des récompenses d'Objets spéciaux peut être réinitialisée jusqu'à la limite. Les règles spécifiques sont les suivantes :\n(1) 2 premières réinitialisations : Lorsque les «Objets spéciaux» n'ont plus de quantité restante, les Gardiens du secret peuvent choisir de réinitialiser, ce qui remettra les quantités restantes des «Objets spéciaux» et des «Objets ordinaires» à la limite ; ou ils peuvent choisir de continuer à échanger. Lorsque les «Objets ordinaires» n'ont également plus de quantité restante, une réinitialisation doit être effectuée pour continuer à échanger.\n(2) À partir de la 3e réinitialisation : Une réinitialisation ne peut être effectuée que lorsque les «Objets ordinaires» n'ont plus de quantité restante. La réinitialisation restaurera la quantité restante des «Objets ordinaires» à la limite, tandis que les «Objets spéciaux» ne seront plus réinitialisés.\n\n<Title:Bonus d'événement>\n1. Les Gardiens du secret possédant des Éveilleurs ou des Roues du Destin spécifiques (pas nécessairement déployés) peuvent obtenir des bonus de butin supplémentaires pour les trois monnaies d'événement dans les récompenses de mission des étapes «Trésors d'Umapati» :\nÉveilleur «Caraboo» : Dégagement 0/1/2/3 ou plus, bonus de 20%/30%/40%/50%.\nRoue du Destin SSR «Mensonge du Fruit Miel» : Superposition 0/1/2/3 ou plus, bonus de 20%/30%/40%/50%.\nRoue du Destin SR «vérité douce et agréable» : Superposition 0/1/2/3 ou plus, bonus de 20%/30%/40%/50%.\n2. Plusieurs «Bonus d'événement» peuvent être cumulés et calculés ensemble.\n3. Veuillez noter : Les récompenses de première complétion des défis en difficulté Folie ne sont pas affectées par le «Bonus d'événement»."
  },
  Activity_145717_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_146540_ActivityName = {
    Text = "Offrande commémorative du parcours · Chapitre des Étoiles VI"
  },
  Activity_146540_ActivityPlot = {
    Text = "Un souvenir scellé et archivé, un voyage enregistré dans le passé. Dans les moments de souvenir, n'oubliez pas d'offrir votre Visite révérencieuse."
  },
  Activity_146541_ActivityName = {
    Text = "Archives d'Hyperborée"
  },
  Activity_146541_ActivityTips = {
    Text = "Règles de l'événement :\n1. Accomplissez des tâches pour réclamer des récompenses dans les Archives d'Hyperborée\n2. Les Archives d'Hyperborée restent accessibles en permanence\n3. Débloquez les Archives Avancées pour obtenir des récompenses supplémentaires lors de l'accomplissement des tâches\nRemarque : Les Archives Avancées activées ne prennent effet que pour cet unique événement d'Archives."
  },
  Activity_146799_ActivityName = {
    Text = "Texte temporaire"
  },
  Activity_146799_ActivityPlot = {
    Text = "Texte temporaire"
  },
  Activity_146799_ActivityStageEndContent = {
    Text = "Texte temporaire"
  },
  Activity_146799_ActivityTips = {
    Text = "Texte temporaire"
  },
  Activity_146799_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_147423_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_147423_ActivityPlot = {
    Text = "Après achat, «Tinct : Vespera» peut activer <BlueQuality:Dégagement 3>"
  },
  Activity_147424_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_147424_ActivityPlot = {
    Text = "Après achat, «Tinct : Vespera» peut activer\n<BlueQuality:Approfondissement de personnalité +4, déverrouille la Sur-Exaltation>"
  },
  Activity_147425_ActivityName = {
    Text = "Texte temporaire"
  },
  Activity_147425_ActivityTips = {
    Text = "<Title:Règles de l'événement>\nPendant l'événement «Origine : Royaume», les Gardiens du secret peuvent utiliser des équipes prédéfinies par le système incluant Origine : Royaume pour expérimenter des niveaux désignés un nombre illimité de fois.\nLors de l'expérience des niveaux de l'événement, les modifications des Éveilleurs dans la formation de l'équipe ne peuvent pas être effectuées.\n<Title:Récompenses de l'événement>\nAprès avoir complété le défi d'un niveau pour la première fois, vous pouvez réclamer les récompenses de démonstration sur l'interface de l'événement."
  },
  Activity_147426_ActivityName = {
    Text = "Événement de déblocage gratuit"
  },
  Activity_148119_ActivityName = {
    Text = "Temps Extracurriculaire"
  },
  Activity_148119_ActivityTips = {
    Text = "<Title:Aperçu de l'événement>\n1. Après avoir accompli les tâches des Archives désignées, les Gardiens du secret peuvent réclamer des récompenses dans «Après les Cours».\n2. «Après les Cours» se terminera le 21 septembre à 9h00.\n3. Débloquez les «Archives Avancées» pour réclamer des récompenses supplémentaires lors de l'accomplissement des tâches.\n4. Veuillez noter : Les «Archives Avancées» débloquées dans cet événement ne sont valables que pour cet événement. Gardiens du secret, veuillez consommer de manière raisonnée."
  },
  Activity_148119_BannerText = {
    Text = "Événement spécial Chronologie à durée limitée !"
  },
  Activity_148889_ActivityName = {
    Text = "Origine Ogier"
  },
  Activity_148889_ActivityTips = {
    Text = "<Title:Règles de l'événement>\n·Pendant l'événement « Origine Ogier », les Gardiens du secret peuvent utiliser les escouades prédéfinies par le système contenant Origine Ogier pour jouer les niveaux désignés un nombre illimité de fois.\n·Lors des niveaux de l'événement, les Corps éveillés de l'escouade ne peuvent pas être modifiés.\n<Title:Récompenses de l'événement>\n·Après avoir réussi le défi du niveau pour la première fois, vous pouvez récupérer les récompenses d'essai sur la page de l'événement."
  },
  Activity_15788_ActivityName = {
    Text = "Esthétique de l'alchimie"
  },
  Activity_15788_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Esthétique de l'alchimie», après que le Gardien a terminé «Recherche de coupons d'or», certaines récompenses matérielles seront doublées, jusqu'à 3 fois par jour.\n2. Les chances de récompense double non utilisées dans la journée seront réinitialisées à 9:00 (GMT+8) le lendemain, alors n'oubliez pas de les utiliser à temps～"
  },
  Activity_15791_ActivityName = {
    Text = "Explosion de gnose"
  },
  Activity_15791_ActivityTips = {
    Text = "Règles de l'événement :\n1. Pendant l'événement «Éclat de Connaissance», après que le Gardien a terminé «Préparation et affinage», certaines récompenses de matériaux seront doublées, jusqu'à 3 fois par jour.\n2. Les chances de récompense doublée non utilisées dans la journée seront réinitialisées à 9:00 (GMT+8) le lendemain, alors n'oubliez pas de les utiliser à temps～"
  },
  Activity_15793_ActivityName = {
    Text = "Ombre de la ville pluvieuse"
  },
  Activity_15793_ActivityPlot = {
    Text = "Chaque nuit pluvieuse s'accompagne de déception et de solitude.\nCertains perdent l'amour, d'autres perdent leur dignité.\nEt certains perdent la tête."
  },
  Activity_15793_ActivityTips = {
    Text = "<Title:Conditions de participation>\n·Complétez l'\"Opération d'Investigation\" 2-9 (Normal) pour participer.\n<Title:Événement d'Investigation>\n·Pendant la période de l'événement, un nouvel événement d'investigation dans \"Ombres de la Ville de Pluie\" sera lancé chaque jour. Les Gardiens peuvent débloquer et enquêter sans consommer d'inventaire. Après avoir complété l'événement d'investigation, des récompenses telles que le Cœur Pur, le Badge d'Investigation, et l'Expérience du Gardien peuvent être obtenues.\n·Après la fin de l'événement, le progrès d'investigation de \"Ombres de la Ville de Pluie\" sera conservé. Les Gardiens peuvent consommer des D-gemmes dans le Record Spécial pour débloquer des investigations non complétées. Compléter des événements d'investigation non complétés pendant la période de l'événement accordera également des récompenses similaires à celles durant l'événement.<Title:Récompenses à Durée Limitée>\n·Des récompenses à durée limitée seront disponibles pendant l'événement. Les Gardiens peuvent obtenir des Cœurs Purs, des Pierres Philosophales, et des récompenses Argent après avoir terminé \"Ombres de la Ville de Pluie\" (mode Normal) et complété les événements d'investigation de \"Ombres de la Ville de Pluie\"! Les récompenses à durée limitée ne sont disponibles que pendant la période de l'événement et ne peuvent pas être complétées ou revendiquées après la fin de l'événement."
  },
  Activity_15793_UnlockConditionExplanation = {
    Text = "Débloqué après avoir terminé \"Opération Investigation\" 2-9 · Normal"
  },
  Activity_15797_ActivityName = {
    Text = "Souverain endormi"
  },
  Activity_15797_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Lors de l'événement \"Souverain du Sommeil\", les Gardiens peuvent utiliser des équipes prédéfinies par le système comprenant Tulu pour vivre des niveaux désignés à l'infini.\n·Lors de l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir terminé avec succès le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_15805_ActivityName = {
    Text = "Voyage dans la cité brumeuse"
  },
  Activity_15805_ActivityTips = {
    Text = "\nRègles de l'Événement :\n1. Après avoir complété les tâches de voyage spécifiées, les Gardiens peuvent réclamer des récompenses dans \"Voyage en Ville de Brume\".\n2. \"Voyage en Ville de Brume\" est ouvert en permanence.\n3. Après avoir déverrouillé \"Voyage Avancé\", les Gardiens peuvent recevoir des récompenses supplémentaires lors de la complétion des tâches.\n4. Veuillez noter : Le \"Voyage Avancé\" débloqué lors de cet événement n'est valable que pendant cet événement. Les Gardiens sont invités à consommer raisonnablement."
  },
  Activity_15809_ActivityName = {
    Text = "Graine d'étoile (expirée)"
  },
  Activity_15809_ActivityTips = {
    Text = "Règles de l'événement:\nAprès que le Gardien a accompli les tâches désignées, les récompenses peuvent être réclamées dans «Germe Stellaire»."
  },
  Activity_15818_ActivityName = {
    Text = "Carver (Expiré)"
  },
  Activity_15818_ActivityTips = {
    Text = "Règles de l'événement:\nAprès que le Gardien a accompli les tâches désignées, les récompenses peuvent être réclamées dans «La Sculptrice»."
  },
  Activity_15821_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_15821_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_15825_ActivityName = {
    Text = "Poème sans nom (Expiré)"
  },
  Activity_15825_ActivityTips = {
    Text = "Règles de l'événement:\nAprès que le Gardien a accompli les tâches désignées, les récompenses peuvent être réclamées dans «Poème sans titre»."
  },
  Activity_15828_ActivityName = {
    Text = "Cérémonie d'entrée"
  },
  Activity_15828_ActivityTips = {
    Text = "\nRègles de l'Événement :\n1. Les Gardiens peuvent collecter des récompenses lors de la \"Cérémonie d'Entrée\" quand leur niveau d'investigation atteint 5/15/25/35/45/55.\n2. L'expérience du gardien peut être obtenue à travers les niveaux d'investigation et les intermèdes."
  },
  Activity_20344_ActivityName = {
    Text = "Rencontre sans lumière"
  },
  Activity_20344_ActivityTips = {
    Text = "\nRègles de l'Événement :\n1. Après avoir terminé les tâches de voyage spécifiées, les Gardiens peuvent réclamer des récompenses dans \"Vue Initiale Sans Lumière\".\n2. \"Vue Initiale Sans Lumière\" est ouvert en permanence."
  },
  Activity_20683_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_20683_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», après que le Gardien a terminé «Résidu dimensionnel», certaines récompenses matérielles seront doublées, jusqu'à 3 fois par jour.\n2. Les chances de récompense double non utilisées dans la journée seront réinitialisées à 9:00 (GMT+8) le lendemain, alors n'oubliez pas de les utiliser à temps～"
  },
  Activity_20684_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_20684_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», après que le Gardien a terminé «Gorge de Schwarzschild», certaines récompenses matérielles seront doublées, jusqu'à 3 fois par jour.\n2. Les chances de récompense double non utilisées dans la journée seront réinitialisées à 9:00 (GMT+8) le lendemain, alors n'oubliez pas de les utiliser à temps～"
  },
  Activity_20685_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_20685_ActivityTips = {
    Text = "Règles de l'événement :\n1. Pendant l'événement «Évolution», après que le Gardien a terminé «Résidu organique», certaines récompenses de matériaux seront doublées, jusqu'à 3 fois par jour.\n2. Les chances de récompense doublée non utilisées dans la journée seront réinitialisées à 9:00 (GMT+8) le lendemain, alors n'oubliez pas de les utiliser à temps～"
  },
  Activity_20686_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_20686_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», après que le Gardien a terminé «Ruines de Ponape», certaines récompenses matérielles seront doublées, jusqu'à 3 fois par jour.\n2. Les chances de récompense double non utilisées dans la journée seront réinitialisées à 9:00 (GMT+8) le lendemain, alors n'oubliez pas de les utiliser à temps～"
  },
  Activity_20687_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_20687_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», après que le Gardien a terminé «Essaim chaotique», certaines récompenses matérielles seront doublées, jusqu'à 3 fois par jour.\n2. Les chances de récompense double non utilisées dans la journée seront réinitialisées à 9:00 (GMT+8) le lendemain, alors n'oubliez pas de les utiliser à temps～"
  },
  Activity_20688_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_20688_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», après que le Gardien a terminé «Repaire des vers», certaines récompenses matérielles seront doublées, jusqu'à 3 fois par jour.\n2. Les chances de récompense double non utilisées dans la journée seront réinitialisées à 9:00 (GMT+8) le lendemain, alors n'oubliez pas de les utiliser à temps～"
  },
  Activity_20689_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_20689_ActivityTips = {
    Text = "Règles de l'événement :\n1. Pendant l'événement «Évolution», après que le Gardien a terminé «Résidu des Abysses», certaines récompenses de matériaux seront doublées, jusqu'à 3 fois par jour.\n2. Les chances de récompense doublée non utilisées dans la journée seront réinitialisées à 9:00 (GMT+8) le lendemain, alors n'oubliez pas de les utiliser à temps～"
  },
  Activity_20690_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_20690_ActivityTips = {
    Text = "Règles de l'événement :\n1. Pendant l'événement «Évolution», après que le Gardien a terminé «Résidu trouble», certaines récompenses de matériaux seront doublées, jusqu'à 3 fois par jour.\n2. Les chances de récompense doublée non utilisées dans la journée seront réinitialisées à 9:00 (GMT+8) le lendemain, alors n'oubliez pas de les utiliser à temps～"
  },
  Activity_20691_ActivityName = {
    Text = "Chasseresse de crânes"
  },
  Activity_20691_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Pendant l'événement \"Chasseresse des Crânes\", les Gardiens peuvent utiliser des équipes préétablies par le système incluant Jonquille pour expérimenter des niveaux désignés à l'infini.\n·Lors de l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir réussi à terminer le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_21502_ActivityName = {
    Text = "Apôtre de la mer"
  },
  Activity_21502_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n· Pendant l'événement \"Apostle de la Mer\", les Gardiens peuvent utiliser des équipes préétablies par le système qui incluent Miryam pour vivre les niveaux désignés indéfiniment.\n· Lors de l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n· Après avoir réussi à compléter le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_21781_ActivityName = {
    Text = "Boîte de sélection du curriculum"
  },
  Activity_21781_ActivityPlot = {
    Text = "Compléter la mission pour choisir un Éveillé spécifique dans \"Étude de Royaume\" ou une roue du destin spécifique dans \"Aspect de Rotation\"!"
  },
  Activity_21781_ActivityTips = {
    Text = "Règles de l'événement:\n1. Accumuler 50 Réveils, se connecter pendant 3 jours et se connecter pendant 7 jours accordera des récompenses « Paradis primordial ». « Paradis primordial » peut être utilisé dans « Fournitures: Consommables. » Lors de l'utilisation, vous pouvez sélectionner 1 Corps éveillé spécifique de « Étude de domaine » à Réveiller.\n2. Accumuler 300 Réveils, 1000 Réveils et se connecter pendant 30 jours accordera des récompenses « Livre de rotation ». « Livre de rotation » peut être utilisé dans « Fournitures: Consommables. » Lors de l'utilisation, vous pouvez sélectionner 1 Roue du Destin spécifique de « Phase de Rotation » à obtenir."
  },
  Activity_22367_ActivityName = {
    Text = "Explosion de gnose"
  },
  Activity_22367_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Éclat de Connaissance», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Préparation et affinage», sans limite journalière."
  },
  Activity_23671_ActivityName = {
    Text = "Duel de plongée profonde"
  },
  Activity_23671_ActivityPlot = {
    Text = "Pendant l'événement, l'Expérience du Gardien des Secrets obtenue par le Gardien grâce à «Plongée dans l'illusion» et «Échecs de Phase» sera doublée, avec un plafond journalier augmenté à 480 points."
  },
  Activity_23671_ActivityTips = {
    Text = "\nRègles de l'événement :\n1. Pendant l'événement \"Plongée Fantasmatique et Traphase\", le Gardien recevra le double de l'Expérience du gardien provenant de \"Plongée Fantasmatique\" et \"Traphase\", avec un plafond quotidien augmenté à 480 points. Si le sujet principal est également débloqué, l'Expérience du gardien obtenue par cette voie sera à nouveau doublée, le plafond quotidien restant à 480 points.\n2. Toute Expérience du gardien doublée non utilisée pour la journée sera réinitialisée à 9h00 (GMT+8) le lendemain, alors n'oubliez pas de l'utiliser à temps, Gardien~"
  },
  Activity_23693_ActivityName = {
    Text = "Rejetons Pâles"
  },
  Activity_23693_ActivityPlot = {
    Text = "La légende raconte que sous Londinium, il existe une seule Porte.\nElle mène au domaine de la Maîtresse Pâle..."
  },
  Activity_23693_ActivityTips = {
    Text = "<Title:Conditions de participation>\n· La participation est disponible après avoir terminé le mode normal de la quête de conscience \"Souhait du Chevalier\".\n<Title:Événements d'investigation>\n· Pendant la période de l'événement, un nouvel événement d'investigation sera lancé quotidiennement dans \"Descendant pâle\". Les gardiens peuvent débloquer et effectuer des investigations sans consommer d'inventaire, et compléter les événements d'investigation rapportera des récompenses telles que des cœurs purs, des badges d'investigation et l'expérience du gardien.\n· Après la fin de l'événement, les progrès d'investigation dans \"Descendant pâle\" seront préservés. Les gardiens peuvent débloquer toutes les investigations verrouillées dans la quête de conscience en consommant des D-gemmes, et compléter les événements d'investigation non terminés pendant la période de l'événement rapportera également des récompenses d'investigation correspondant à celles disponibles pendant l'événement.<Title:Récompenses limitées dans le temps>\n· Des récompenses limitées dans le temps seront disponibles pendant la période de l'événement. Les gardiens peuvent recevoir le Verrou Noir et des récompenses en argent après avoir terminé le mode normal de \"Descendant pâle\" et ayant fini ses événements d'investigation ! Les récompenses limitées dans le temps ne sont disponibles que pendant l'événement et ne peuvent être complétées ou réclamées après sa fin."
  },
  Activity_23693_UnlockConditionExplanation = {
    Text = "Complétez la quête errante \"Souhait du Chevalier\" pour débloquer ensuite"
  },
  Activity_23723_ActivityName = {
    Text = "La tempête arrive"
  },
  Activity_23723_ActivityTips = {
    Text = "Règles de l'événement :\n1. Pendant l'événement, le Chapitre 5 de la Mission d'enquête est temporairement fermé. Le Décret Clé «Obsession Éternelle» peut être temporairement obtenu en terminant le Chapitre 4 de la Mission d'enquête.\n2. Après la fin de l'événement, le Chapitre 5 de la Mission d'enquête rouvrira, et le Décret Clé «Obsession Éternelle» nécessitera à nouveau de terminer le Chapitre 5 de la Mission d'enquête.\n3. De plus, toutes les Récompenses de succès du Chapitre 5 précédemment obtenues, les Succès de Niveau, les récompenses d'exploration et les Récompenses de fin de niveau seront conservées. Lors de la réouverture (actuellement prévue pour le 27 décembre), la progression déjà accomplie sera reportée autant que possible, il n'est donc pas nécessaire de les refaire."
  },
  Activity_23870_ActivityName = {
    Text = "Traphase inférence"
  },
  Activity_23870_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement, complétez les missions de l'événement pour recevoir des récompenses.\n2. Après la fin de l'événement, les récompenses non réclamées ne pourront plus être récupérées. Gardiens du secret, n'oubliez pas de les récupérer à temps～"
  },
  Activity_23936_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_23936_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Résidu des Abysses», sans limite journalière."
  },
  Activity_23937_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_23937_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses matérielles supplémentaires (hors Expérience du Gardien des Secrets et Billet Rose Dorée) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Essaim chaotique», sans limite journalière."
  },
  Activity_23938_ActivityName = {
    Text = "Duel de plongée profonde"
  },
  Activity_23938_ActivityPlot = {
    Text = "Pendant l'événement, l'Expérience du Gardien des Secrets obtenue par le Gardien grâce à «Plongée dans l'illusion» et «Échecs de Phase» sera doublée, avec un plafond journalier augmenté à 480 points."
  },
  Activity_23938_ActivityTips = {
    Text = "\nRègles de l'événement :\n1. Pendant l'événement \"Plongée Fantasmatique et Traphase\", le Gardien recevra le double de l'Expérience du gardien provenant de \"Plongée Fantasmatique\" et \"Traphase\", avec un plafond quotidien augmenté à 480 points. Si le sujet principal est également débloqué, l'Expérience du gardien obtenue par cette voie sera à nouveau doublée, le plafond quotidien restant à 480 points.\n2. Toute Expérience du gardien doublée non utilisée pour la journée sera réinitialisée à 9h00 (GMT+8) le lendemain, alors n'oubliez pas de l'utiliser à temps, Gardien~"
  },
  Activity_23939_ActivityName = {
    Text = "Duel de plongée profonde"
  },
  Activity_23939_ActivityPlot = {
    Text = "Pendant l'événement, l'Expérience du Gardien des Secrets obtenue par le Gardien grâce à «Plongée dans l'illusion» et «Échecs de Phase» sera doublée, avec un plafond journalier augmenté à 480 points."
  },
  Activity_23939_ActivityTips = {
    Text = "\nRègles de l'événement :\n1. Pendant l'événement \"Plongée Fantasmatique et Traphase\", le Gardien recevra le double de l'Expérience du gardien provenant de \"Plongée Fantasmatique\" et \"Traphase\", avec un plafond quotidien augmenté à 480 points. Si le sujet principal est également débloqué, l'Expérience du gardien obtenue par cette voie sera à nouveau doublée, le plafond quotidien restant à 480 points.\n2. Toute Expérience du gardien doublée non utilisée pour la journée sera réinitialisée à 9h00 (GMT+8) le lendemain, alors n'oubliez pas de l'utiliser à temps, Gardien~"
  },
  Activity_23940_ActivityName = {
    Text = "Explosion de gnose"
  },
  Activity_23940_ActivityTips = {
    Text = "Règles de l'événement :\n1. Pendant l'événement «Éclat de Connaissance», après que le Gardien a terminé «Préparation et affinage», certaines récompenses de matériaux seront doublées, jusqu'à 3 fois par jour.\n2. Les chances de récompense doublée non utilisées dans la journée seront réinitialisées à 9:00 (GMT+8) le lendemain, alors n'oubliez pas de les utiliser à temps～"
  },
  Activity_23941_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_23941_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses matérielles supplémentaires (hors Expérience du Gardien des Secrets et Billet Rose Dorée) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Gorge de Schwarzschild», sans limite journalière."
  },
  Activity_23942_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_23942_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», après que le Gardien a terminé «Repaire des vers», certaines récompenses matérielles seront doublées, jusqu'à 3 fois par jour.\n2. Les chances de récompense double non utilisées dans la journée seront réinitialisées à 9:00 (GMT+8) le lendemain, alors n'oubliez pas de les utiliser à temps～"
  },
  Activity_23943_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_23943_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Résidu dimensionnel», sans limite journalière."
  },
  Activity_23944_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_23944_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Résidu organique», sans limite journalière."
  },
  Activity_23945_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_23945_ActivityTips = {
    Text = "Règles de l'événement :\n1. Pendant l'événement «Évolution», après que le Gardien a terminé «Résidu trouble», certaines récompenses de matériaux seront doublées, jusqu'à 3 fois par jour.\n2. Les chances de récompense doublée non utilisées dans la journée seront réinitialisées à 9:00 (GMT+8) le lendemain, alors n'oubliez pas de les utiliser à temps～"
  },
  Activity_23946_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_23946_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Résidu dimensionnel», sans limite journalière."
  },
  Activity_23947_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_23947_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Ruines de Ponape», sans limite journalière."
  },
  Activity_23948_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_23948_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Essaim chaotique», sans limite journalière."
  },
  Activity_23949_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_23949_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Résidu trouble», sans limite journalière."
  },
  Activity_23950_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_23950_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Résidu des Abysses», sans limite journalière."
  },
  Activity_23951_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_23951_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Essaim chaotique», sans limite journalière."
  },
  Activity_23953_ActivityName = {
    Text = "Duel de plongée profonde"
  },
  Activity_23953_ActivityPlot = {
    Text = "Pendant l'événement, l'Expérience du Gardien des Secrets obtenue par le Gardien grâce à «Plongée dans l'illusion» et «Échecs de Phase» sera doublée, avec un plafond journalier augmenté à 480 points."
  },
  Activity_23953_ActivityTips = {
    Text = "\nRègles de l'événement :\n1. Pendant l'événement \"Plongée Fantasmatique et Traphase\", le Gardien recevra le double de l'Expérience du gardien provenant de \"Plongée Fantasmatique\" et \"Traphase\", avec un plafond quotidien augmenté à 480 points. Si le sujet principal est également débloqué, l'Expérience du gardien obtenue par cette voie sera à nouveau doublée, le plafond quotidien restant à 480 points.\n2. Toute Expérience du gardien doublée non utilisée pour la journée sera réinitialisée à 9h00 (GMT+8) le lendemain, alors n'oubliez pas de l'utiliser à temps, Gardien~"
  },
  Activity_23954_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_23954_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Essaim chaotique», sans limite journalière."
  },
  Activity_23955_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_23955_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses matérielles supplémentaires (hors Expérience du Gardien des Secrets et Billet Rose Dorée) en enquêtant ou en effectuant une Reconstitution dans «Résidu des Abysses», sans limite journalière."
  },
  Activity_23956_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_23956_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Ruines de Ponape», sans limite journalière."
  },
  Activity_23957_ActivityName = {
    Text = "Explosion de gnose"
  },
  Activity_23957_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Éclat de Connaissance», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Préparation et affinage», sans limite journalière."
  },
  Activity_23958_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_23958_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Résidu organique», sans limite journalière."
  },
  Activity_23959_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_23959_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Gorge de Schwarzschild», sans limite journalière."
  },
  Activity_23960_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_23960_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Ruines de Ponape», sans limite journalière."
  },
  Activity_23961_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_23961_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Essaim chaotique», sans limite journalière."
  },
  Activity_23962_ActivityName = {
    Text = "Explosion de gnose"
  },
  Activity_23962_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Éclat de Connaissance», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Préparation et affinage», sans limite journalière."
  },
  Activity_23963_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_23963_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Résidu des Abysses», sans limite journalière."
  },
  Activity_23964_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_23964_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Résidu dimensionnel», sans limite journalière."
  },
  Activity_23965_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_23965_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Essaim chaotique», sans limite journalière."
  },
  Activity_23966_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_23966_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Résidu dimensionnel», sans limite journalière."
  },
  Activity_23967_ActivityName = {
    Text = "Duel de plongée profonde"
  },
  Activity_23967_ActivityPlot = {
    Text = "Pendant l'événement, l'Expérience du Gardien des Secrets obtenue par le Gardien grâce à «Plongée dans l'illusion» et «Échecs de Phase» sera doublée, avec un plafond journalier augmenté à 480 points."
  },
  Activity_23967_ActivityTips = {
    Text = "\nRègles de l'événement :\n1. Pendant l'événement \"Plongée Fantasmatique et Traphase\", le Gardien recevra le double de l'Expérience du gardien provenant de \"Plongée Fantasmatique\" et \"Traphase\", avec un plafond quotidien augmenté à 480 points. Si le sujet principal est également débloqué, l'Expérience du gardien obtenue par cette voie sera à nouveau doublée, le plafond quotidien restant à 480 points.\n2. Toute Expérience du gardien doublée non utilisée pour la journée sera réinitialisée à 9h00 (GMT+8) le lendemain, alors n'oubliez pas de l'utiliser à temps, Gardien~"
  },
  Activity_23968_ActivityName = {
    Text = "Explosion de gnose"
  },
  Activity_23968_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Éclat de Connaissance», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Préparation et affinage», sans limite journalière."
  },
  Activity_23969_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_23969_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Gorge de Schwarzschild», sans limite journalière."
  },
  Activity_23970_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_23970_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Résidu des Abysses», sans limite journalière."
  },
  Activity_23971_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_23971_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Résidu dimensionnel», sans limite journalière."
  },
  Activity_23972_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_23972_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Repaire des vers», sans limite journalière."
  },
  Activity_23973_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_23973_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses matérielles supplémentaires (hors Expérience du Gardien des Secrets et Billet Rose Dorée) en enquêtant ou en effectuant une Reconstitution dans «Résidu trouble», sans limite journalière."
  },
  Activity_23974_ActivityName = {
    Text = "Explosion de gnose"
  },
  Activity_23974_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Éclat de Connaissance», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Préparation et affinage», sans limite journalière."
  },
  Activity_23975_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_23975_ActivityTips = {
    Text = "Règles de l'événement :\n1. Pendant l'événement «Évolution», après que le Gardien a terminé «Résidu organique», certaines récompenses de matériaux seront doublées, jusqu'à 3 fois par jour.\n2. Les chances de récompense doublée non utilisées dans la journée seront réinitialisées à 9:00 (GMT+8) le lendemain, alors n'oubliez pas de les utiliser à temps～"
  },
  Activity_23976_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_23976_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Résidu des Abysses», sans limite journalière."
  },
  Activity_23977_ActivityName = {
    Text = "Esthétique de l'alchimie"
  },
  Activity_23977_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Esthétique de l'alchimie», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Recherche de coupons d'or», sans limite journalière."
  },
  Activity_23978_ActivityName = {
    Text = "Explosion de gnose"
  },
  Activity_23978_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Éclat de Connaissance», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Préparation et affinage», sans limite journalière."
  },
  Activity_23979_ActivityName = {
    Text = "Esthétique de l'alchimie"
  },
  Activity_23979_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Esthétique de l'alchimie», après que le Gardien a terminé «Recherche de coupons d'or», certaines récompenses matérielles seront doublées, jusqu'à 3 fois par jour.\n2. Les chances de récompense double non utilisées dans la journée seront réinitialisées à 9:00 (GMT+8) le lendemain, alors n'oubliez pas de les utiliser à temps～"
  },
  Activity_23980_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_23980_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», après que le Gardien a terminé «Essaim chaotique», certaines récompenses matérielles seront doublées, jusqu'à 3 fois par jour.\n2. Les chances de récompense double non utilisées dans la journée seront réinitialisées à 9:00 (GMT+8) le lendemain, alors n'oubliez pas de les utiliser à temps～"
  },
  Activity_23981_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_23981_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Résidu dimensionnel», sans limite journalière."
  },
  Activity_23982_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_23982_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Repaire des vers», sans limite journalière."
  },
  Activity_23983_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_23983_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», après que le Gardien a terminé «Résidu dimensionnel», certaines récompenses matérielles seront doublées, jusqu'à 3 fois par jour.\n2. Les chances de récompense double non utilisées dans la journée seront réinitialisées à 9:00 (GMT+8) le lendemain, alors n'oubliez pas de les utiliser à temps～"
  },
  Activity_23984_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_23984_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Repaire des vers», sans limite journalière."
  },
  Activity_23985_ActivityName = {
    Text = "Explosion de gnose"
  },
  Activity_23985_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Éclat de Connaissance», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Préparation et affinage», sans limite journalière."
  },
  Activity_23986_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_23986_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Résidu trouble», sans limite journalière."
  },
  Activity_23987_ActivityName = {
    Text = "Explosion de gnose"
  },
  Activity_23987_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Éclat de Connaissance», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Préparation et affinage», sans limite journalière."
  },
  Activity_23988_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_23988_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Résidu trouble», sans limite journalière."
  },
  Activity_23989_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_23989_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Repaire des vers», sans limite journalière."
  },
  Activity_23990_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_23990_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Gorge de Schwarzschild», sans limite journalière."
  },
  Activity_23991_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_23991_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Repaire des vers», sans limite journalière."
  },
  Activity_23992_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_23992_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Résidu des Abysses», sans limite journalière."
  },
  Activity_23993_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_23993_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Résidu organique», sans limite journalière."
  },
  Activity_23994_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_23994_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Essaim chaotique», sans limite journalière."
  },
  Activity_23995_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_23995_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Gorge de Schwarzschild», sans limite journalière."
  },
  Activity_23996_ActivityName = {
    Text = "Duel de plongée profonde"
  },
  Activity_23996_ActivityPlot = {
    Text = "Pendant l'événement, l'Expérience du Gardien des Secrets obtenue par le Gardien grâce à «Plongée dans l'illusion» et «Échecs de Phase» sera doublée, avec un plafond journalier augmenté à 480 points."
  },
  Activity_23996_ActivityTips = {
    Text = "\nRègles de l'événement :\n1. Pendant l'événement \"Plongée Fantasmatique et Traphase\", le Gardien recevra le double de l'Expérience du gardien provenant de \"Plongée Fantasmatique\" et \"Traphase\", avec un plafond quotidien augmenté à 480 points. Si le sujet principal est également débloqué, l'Expérience du gardien obtenue par cette voie sera à nouveau doublée, le plafond quotidien restant à 480 points.\n2. Toute Expérience du gardien doublée non utilisée pour la journée sera réinitialisée à 9h00 (GMT+8) le lendemain, alors n'oubliez pas de l'utiliser à temps, Gardien~"
  },
  Activity_23997_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_23997_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Ruines de Ponape», sans limite journalière."
  },
  Activity_23998_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_23998_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses matérielles supplémentaires (hors Expérience du Gardien des Secrets et Billet Rose Dorée) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Résidu organique», sans limite journalière."
  },
  Activity_23999_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_23999_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Gorge de Schwarzschild», sans limite journalière."
  },
  Activity_24000_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_24000_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Résidu des Abysses», sans limite journalière."
  },
  Activity_24001_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_24001_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Essaim chaotique», sans limite journalière."
  },
  Activity_24002_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_24002_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Résidu organique», sans limite journalière."
  },
  Activity_24003_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_24003_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Repaire des vers», sans limite journalière."
  },
  Activity_24004_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_24004_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Résidu dimensionnel», sans limite journalière."
  },
  Activity_24005_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_24005_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Gorge de Schwarzschild», sans limite journalière."
  },
  Activity_24006_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_24006_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Ruines de Ponape», sans limite journalière."
  },
  Activity_24007_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_24007_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», après que le Gardien a terminé «Ruines de Ponape», certaines récompenses matérielles seront doublées, jusqu'à 3 fois par jour.\n2. Les chances de récompense double non utilisées dans la journée seront réinitialisées à 9:00 (GMT+8) le lendemain, alors n'oubliez pas de les utiliser à temps～"
  },
  Activity_24009_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_24009_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Résidu organique», sans limite journalière."
  },
  Activity_24010_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_24010_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Résidu trouble», sans limite journalière."
  },
  Activity_24011_ActivityName = {
    Text = "Explosion de gnose"
  },
  Activity_24011_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Éclat de Connaissance», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Préparation et affinage», sans limite journalière."
  },
  Activity_24012_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_24012_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Résidu organique», sans limite journalière."
  },
  Activity_24013_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_24013_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Gorge de Schwarzschild», sans limite journalière."
  },
  Activity_24014_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_24014_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Résidu trouble», sans limite journalière."
  },
  Activity_24015_ActivityName = {
    Text = "Explosion de gnose"
  },
  Activity_24015_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Éclat de Connaissance», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Préparation et affinage», sans limite journalière."
  },
  Activity_24016_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_24016_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Résidu des Abysses», sans limite journalière."
  },
  Activity_24017_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_24017_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Gorge de Schwarzschild», sans limite journalière."
  },
  Activity_24018_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_24018_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Résidu trouble», sans limite journalière."
  },
  Activity_24019_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_24019_ActivityTips = {
    Text = "Règles de l'événement :\n1. Pendant l'événement «Évolution», après que le Gardien a terminé «Résidu des Abysses», certaines récompenses de matériaux seront doublées, jusqu'à 3 fois par jour.\n2. Les chances de récompense doublée non utilisées dans la journée seront réinitialisées à 9:00 (GMT+8) le lendemain, alors n'oubliez pas de les utiliser à temps～"
  },
  Activity_24020_ActivityName = {
    Text = "Explosion de gnose"
  },
  Activity_24020_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Éclat de Connaissance», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Préparation et affinage», sans limite journalière."
  },
  Activity_24021_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_24021_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Ruines de Ponape», sans limite journalière."
  },
  Activity_24022_ActivityName = {
    Text = "Explosion de gnose"
  },
  Activity_24022_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Éclat de Connaissance», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Préparation et affinage», sans limite journalière."
  },
  Activity_24023_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_24023_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», après que le Gardien a terminé «Gorge de Schwarzschild», certaines récompenses matérielles seront doublées, jusqu'à 3 fois par jour.\n2. Les chances de récompense double non utilisées dans la journée seront réinitialisées à 9:00 (GMT+8) le lendemain, alors n'oubliez pas de les utiliser à temps～"
  },
  Activity_24025_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_24025_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Ruines de Ponape», sans limite journalière."
  },
  Activity_24026_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_24026_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses matérielles supplémentaires (hors Expérience du Gardien des Secrets et Billet Rose Dorée) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Repaire des vers», sans limite journalière."
  },
  Activity_24027_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_24027_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Repaire des vers», sans limite journalière."
  },
  Activity_24028_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_24028_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Résidu organique», sans limite journalière."
  },
  Activity_24029_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_24029_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Gorge de Schwarzschild», sans limite journalière."
  },
  Activity_24030_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_24030_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Résidu trouble», sans limite journalière."
  },
  Activity_24031_ActivityName = {
    Text = "Explosion de gnose"
  },
  Activity_24031_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Éclat de Connaissance», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Préparation et affinage», sans limite journalière."
  },
  Activity_24032_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_24032_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Résidu des Abysses», sans limite journalière."
  },
  Activity_24033_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_24033_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Résidu organique», sans limite journalière."
  },
  Activity_24034_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_24034_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Ruines de Ponape», sans limite journalière."
  },
  Activity_24035_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_24035_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Repaire des vers», sans limite journalière."
  },
  Activity_24036_ActivityName = {
    Text = "Duel de plongée profonde"
  },
  Activity_24036_ActivityPlot = {
    Text = "Pendant l'événement, l'Expérience du Gardien des Secrets obtenue par le Gardien grâce à «Plongée dans l'illusion» et «Échecs de Phase» sera doublée, avec un plafond journalier augmenté à 480 points."
  },
  Activity_24036_ActivityTips = {
    Text = "\nRègles de l'événement :\n1. Pendant l'événement \"Plongée Fantasmatique et Traphase\", le Gardien recevra le double de l'Expérience du gardien provenant de \"Plongée Fantasmatique\" et \"Traphase\", avec un plafond quotidien augmenté à 480 points. Si le sujet principal est également débloqué, l'Expérience du gardien obtenue par cette voie sera à nouveau doublée, le plafond quotidien restant à 480 points.\n2. Toute Expérience du gardien doublée non utilisée pour la journée sera réinitialisée à 9h00 (GMT+8) le lendemain, alors n'oubliez pas de l'utiliser à temps, Gardien~"
  },
  Activity_24037_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_24037_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses matérielles supplémentaires (hors Expérience du Gardien des Secrets et Billet Rose Dorée) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Résidu dimensionnel», sans limite journalière."
  },
  Activity_24038_ActivityName = {
    Text = "Duel de plongée profonde"
  },
  Activity_24038_ActivityPlot = {
    Text = "Pendant l'événement, l'Expérience du Gardien des Secrets obtenue par le Gardien grâce à «Plongée dans l'illusion» et «Échecs de Phase» sera doublée, avec un plafond journalier augmenté à 480 points."
  },
  Activity_24038_ActivityTips = {
    Text = "\nRègles de l'événement :\n1. Pendant l'événement \"Plongée Fantasmatique et Traphase\", le Gardien recevra le double de l'Expérience du gardien provenant de \"Plongée Fantasmatique\" et \"Traphase\", avec un plafond quotidien augmenté à 480 points. Si le sujet principal est également débloqué, l'Expérience du gardien obtenue par cette voie sera à nouveau doublée, le plafond quotidien restant à 480 points.\n2. Toute Expérience du gardien doublée non utilisée pour la journée sera réinitialisée à 9h00 (GMT+8) le lendemain, alors n'oubliez pas de l'utiliser à temps, Gardien~"
  },
  Activity_24039_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_24039_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Repaire des vers», sans limite journalière."
  },
  Activity_24040_ActivityName = {
    Text = "Explosion de gnose"
  },
  Activity_24040_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Éclat de Connaissance», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Préparation et affinage», sans limite journalière."
  },
  Activity_24041_ActivityName = {
    Text = "Explosion de gnose"
  },
  Activity_24041_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Éclat de Connaissance», les Gardiens du secret recevront 50% d'Élixir de Sagesse supplémentaire en enquêtant ou en effectuant une Reconstitution dans «Préparation et affinage», sans limite journalière."
  },
  Activity_24042_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_24042_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Résidu dimensionnel», sans limite journalière."
  },
  Activity_24043_ActivityName = {
    Text = "Explosion de gnose"
  },
  Activity_24043_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Éclat de Connaissance», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Préparation et affinage», sans limite journalière."
  },
  Activity_24044_ActivityName = {
    Text = "Esthétique de l'alchimie"
  },
  Activity_24044_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Esthétique de l'alchimie», les Gardiens du secret recevront 50% de Billet Rose Dorée supplémentaires lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Recherche de coupons d'or», sans limite journalière."
  },
  Activity_24045_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_24045_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Essaim chaotique», sans limite journalière."
  },
  Activity_24046_ActivityName = {
    Text = "Explosion de gnose"
  },
  Activity_24046_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Éclat de Connaissance», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Préparation et affinage», sans limite journalière."
  },
  Activity_24047_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_24047_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses matérielles supplémentaires (hors Expérience du Gardien des Secrets et Billet Rose Dorée) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Ruines de Ponape», sans limite journalière."
  },
  Activity_24049_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_24049_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Résidu organique», sans limite journalière."
  },
  Activity_24050_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_24050_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Ruines de Ponape», sans limite journalière."
  },
  Activity_24051_ActivityName = {
    Text = "Formation intensive"
  },
  Activity_24051_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Entraînement intensif», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Essaim chaotique», sans limite journalière."
  },
  Activity_24052_ActivityName = {
    Text = "Explosion de gnose"
  },
  Activity_24052_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Éclat de Connaissance», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Préparation et affinage», sans limite journalière."
  },
  Activity_24053_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_24053_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Résidu trouble», sans limite journalière."
  },
  Activity_24054_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_24054_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Résidu trouble», sans limite journalière."
  },
  Activity_24055_ActivityName = {
    Text = "Édifier performance"
  },
  Activity_24055_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Évolution», les Gardiens du secret recevront 50% de récompenses supplémentaires (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Résidu dimensionnel», sans limite journalière."
  },
  Activity_24194_ActivityName = {
    Text = "Madame en rouge"
  },
  Activity_24194_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Pendant l'événement \"Dame Rouge\", les Gardiens peuvent utiliser des équipes préétablies par le système incluant Sorel pour expérimenter des niveaux désignés à l'infini.\n·Lors de l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir réussi à terminer le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_24195_ActivityName = {
    Text = "Fleurir de boue"
  },
  Activity_24195_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Pendant l'événement \"Fleur de Mire\", les Gardiens peuvent utiliser des équipes préétablies par le système incluant Lily pour expérimenter des niveaux désignés à l'infini.\n·Lors de la jouabilité des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir réussi à terminer le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_24992_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_24992_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_25011_ActivityName = {Text = "À un pas"},
  Activity_25011_ActivityPlot = {
    Text = "Vous faites un pas en avant et traversez vers un autre espace–temps."
  },
  Activity_25011_ActivityTips = {
    Text = "<Title:Conditions de Participation>\n·Complétez l'errance de conscience \"Souhait du Chevalier\" en mode Normal pour participer.\n<Title:Événement d'Investigation>\n·Pendant la période de l'événement, un nouvel événement d'investigation de \"À Un Pas\" sera lancé quotidiennement. Les Gardiens peuvent déverrouiller et enquêter sans consommer d'inventaire. Après avoir complété l'événement d'investigation, des récompenses telles que le Noyau Pur, le Badge d'Investigation et l'Expérience du Gardien peuvent être obtenues.\n·Après la fin de l'événement, la progression de l'investigation de \"À Un Pas\" sera conservée, et les Gardiens pourront consommer des D-gemmes dans l'errance de conscience pour déverrouiller les investigations non complétées. Compléter les événements d'investigation non complétés pendant la période de l'événement accordera également des récompenses conformes à celles de l'événement.<Title:Récompenses Limitées dans le Temps>\n·Des récompenses limitées dans le temps seront disponibles durant l'événement. Les Gardiens peuvent obtenir des Bonbons Chanceux et des récompenses Argent après avoir complété \"À Un Pas\" en mode Normal et après avoir complété les événements d'investigation de \"À Un Pas\"! Les récompenses limitées dans le temps ne sont disponibles que pendant la période de l'événement et ne peuvent pas être complétées ou réclamées après la fin de l'événement."
  },
  Activity_25011_UnlockConditionExplanation = {
    Text = "Complétez la quête errante \"Souhait du Chevalier\" pour débloquer ensuite"
  },
  Activity_25012_ActivityName = {
    Text = "Éloge de la Rose"
  },
  Activity_25012_ActivityPlot = {
    Text = "Mesdames et messieurs,\nLa douce nuit a commencé, alors préparez vos boissons raffinées.\nC'est une longue histoire ; racontons–la lentement..."
  },
  Activity_25012_ActivityTips = {
    Text = "<Title:Conditions de participation>\n·Complétez l'« Opération d'Investigation » 2-9 (Normal) pour participer.\n<Title:Événement d'Investigation>\n·Pendant la période de l'événement, un nouvel événement d'investigation de « Tribute Rosé » sera lancé quotidiennement. Les Gardiens peuvent débloquer et enquêter sans consommer d'inventaire. Après avoir complété l'événement d'investigation, des récompenses telles que le Noyau Pur, le Badge d'Investigation et l'Expérience du Gardien peuvent être obtenues.\n·Après la fin de l'événement, les progrès d'investigation de « Tribute Rosé » seront conservés, et les Gardiens peuvent consommer des D-gemmes dans le Registre Spécial pour débloquer les enquêtes non complétées. Compléter les événements d'investigation non complétés pendant la période de l'événement donnera également des récompenses cohérentes avec celles de l'événement.<Title:Récompenses Temporaire>\n·Des récompenses temporaires seront disponibles pendant l'événement. Les Gardiens peuvent obtenir le Noyau Pur, la Pierre Philosophale et des récompenses en Argent après avoir terminé le mode « Tribute Rosé » (Normal) et complété les événements d'investigation de « Tribute Rosé » ! Les récompenses temporaires ne seront disponibles que pendant la période de l'événement et ne peuvent pas être complétées ou réclamées après la fin de l'événement."
  },
  Activity_25012_UnlockConditionExplanation = {
    Text = "Débloqué après avoir terminé \"Opération Investigation\" 2-9 · Normal"
  },
  Activity_34754_ActivityName = {
    Text = "La magie de l'histoire"
  },
  Activity_34754_ActivityTips = {
    Text = "<Title:Conditions de participation>\n·Complétez \"Opération Investigation\" 2-9 (Normal) pour participer.\n<Title:Événement d'investigation>\n·Pendant la période de l'événement, un nouvel événement d'investigation de \"Magie des Histoires\" sera lancé chaque jour. Les Gardiens peuvent déverrouiller et enquêter sans consommer d'inventaire. Après avoir terminé l'événement d'investigation, des récompenses telles que le Cœur Pur, le Insigne d'Investigation et l'Expérience de Gardien peuvent être obtenues.\n·Après la fin de l'événement, la progression d'investigation de \"Magie des Histoires\" sera conservée. Les Gardiens peuvent dépenser des D-gemmes dans le Registre Spécial pour débloquer des enquêtes non complétées. Compléter des événements d'investigation non terminés pendant la période de l'événement accordera également des récompenses cohérentes avec celles de l'événement.<Title:Récompenses à durée limitée>\n·Des récompenses à durée limitée seront disponibles durant l'événement. Les Gardiens peuvent obtenir le Cœur Pur, la Pierre Philosophale et des récompenses en Argent après avoir terminé \"Magie des Histoires\" (mode Normal) et complété les événements d'investigation de \"Magie des Histoires\"! Les récompenses à durée limitée ne sont disponibles que pendant la période de l'événement et ne peuvent pas être complétées ou réclamées après la fin de l'événement."
  },
  Activity_34755_ActivityName = {
    Text = "La magie de l'histoire"
  },
  Activity_34755_ActivityTips = {
    Text = "<Title:Aperçu de l'événement>\nPendant l'événement, le mode de jeu «Énigmes scénaristiques» sera disponible pour une durée limitée, et «Enregistrement de la task force : La magie de l'histoire» sera débloqué gratuitement !\n\n<Title:Énigmes scénaristiques>\n«Énigmes scénaristiques» contient 9 niveaux de difficulté, recommandés pour les niveaux 30 à 70. Les niveaux de difficulté supérieurs sont débloqués après avoir terminé les niveaux inférieurs.\nChaque défi nécessite de consommer Ménophine *60, et terminer chaque étape vous rapportera la monnaie d'événement «Inspiration errante». Plus la difficulté est élevée, plus vous gagnerez d'«Inspiration errante» !\nL'«Inspiration errante» peut être échangée contre une grande quantité de matériaux d'entraînement de Corps éveillé au «Magasin de grimoires», et peut également être échangée contre la Roue du Destin SR exclusive à l'événement «Magie de l'Argentique», qui pourra être rééditée ou incluse dans les éveils permanents à l'avenir.\nLors de chaque défi, en plus du boss, les ennemis, les événements et les cartes peuvent varier, et davantage de Reliques peuvent apparaître dans les niveaux !\nVous pouvez utiliser l'assistance des Alumnis dans les «Énigmes scénaristiques».\n\n<Title:Résonance et Récompenses de succès>\nEn consommant des «Cœurs de l'interprétation» et en activant «Résonance : valeur de phase du Réalisateur», les Gardiens du secret peuvent devenir plus puissants dans les «Énigmes scénaristiques», rendant les défis plus faciles.\nLes Gardiens du secret peuvent obtenir des «Cœurs de l'interprétation» en accomplissant des succès d'événement, et en plus, ils peuvent également recevoir l'avatar exclusif à l'événement «Au nom de la Clé d'Argent : Lily» grâce à ces succès !\n\n<Title:Enregistrement de la task force>\nPendant l'événement, un nouvel événement d'enquête de «La magie de l'histoire» sera publié chaque jour, et les Gardiens du secret peuvent débloquer les enquêtes sans consommer de ressources ; après avoir terminé l'événement d'enquête, des récompenses telles que des Cœurs Immaculés, des Badges d'enquête et de l'Expérience du Gardien des Secrets seront obtenues.\nAprès la fin de l'événement, la progression d'enquête de «La magie de l'histoire» sera conservée, et les Gardiens du secret peuvent utiliser des Perles d'érosion pour débloquer les enquêtes non encore terminées. Terminer les enquêtes inachevées pendant l'événement accordera toujours les mêmes récompenses que pendant l'événement.\nDes récompenses de succès à durée limitée seront publiées pendant l'événement. Les Gardiens du secret peuvent recevoir des récompenses en Cœurs d'argent dans les Récompenses de succès de l'événement après avoir terminé le mode normal de «La magie de l'histoire» et les événements d'enquête ! Les récompenses de succès ne seront disponibles que pendant l'événement ; elles ne pourront être complétées ou réclamées après la fin de l'événement.\n"
  },
  Activity_34764_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34765_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34766_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34767_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34768_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34769_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34770_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34771_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34772_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34773_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34774_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34775_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34776_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34777_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34778_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34779_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34780_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34781_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34782_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34783_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34784_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34785_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34786_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34787_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34788_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34789_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34790_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34791_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34792_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34793_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34794_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34795_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34796_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34797_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34798_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34799_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34800_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34801_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34802_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34803_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34804_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34805_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34806_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34807_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34808_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34809_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34810_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34811_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34812_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34813_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34814_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34815_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34816_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34817_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34818_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34819_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34820_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34821_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34822_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34823_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34824_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34825_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34826_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34827_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_34828_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_35844_ActivityName = {
    Text = "Dame des abysses"
  },
  Activity_35844_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n· Pendant l'événement \"Dame Aequor\", les Gardiens peuvent utiliser des équipes préétablies par le système qui incluent Murphy pour vivre les niveaux désignés indéfiniment.\n· Pendant l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n· Après avoir réussi à compléter le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_35983_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_35983_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_36841_ActivityName = {
    Text = "Eadem omnia"
  },
  Activity_36841_ActivityPlot = {
    Text = "C'est une journée simple et heureuse pour Aurita. C'est chacune de ses journées."
  },
  Activity_36841_ActivityTips = {
    Text = "<Title:Conditions de Participation>\n·Complétez le vagabondage de la conscience \"Souhait du Chevalier\" en mode Normal pour participer.\n<Title:Événement d'Investigation>\n·Pendant la période de l'événement, les Gardiens peuvent débloquer et enquêter sans consommer d'inventaire. Après avoir complété l'événement d'investigation, des récompenses telles que le Cœur Pur, le Badge d'Investigation et l'Expérience de Gardien peuvent être obtenues.\n·Après la fin de l'événement, les progrès d'investigation de \"Tout comme d'habitude\" seront conservés. Les Gardiens peuvent consommer des D-gemme dans le vagabondage de la conscience pour débloquer des investigations non complétées. Compléter des événements d'investigation non complétés pendant la période de l'événement accordera également des récompenses cohérentes avec celles de l'événement.<Title:Récompenses à Durée Limitée>\n·Des récompenses à durée limitée seront disponibles pendant l'événement. Les Gardiens peuvent obtenir le Verrou Noir et des récompenses Argent après avoir terminé le mode Normal de \"Tout comme d'habitude\" et complété les événements d'investigation de \"Tout comme d'habitude\"! Les récompenses à durée limitée ne sont disponibles que pendant la période de l'événement et ne peuvent pas être complétées ou réclamées après la fin de l'événement."
  },
  Activity_36841_UnlockConditionExplanation = {
    Text = "Complétez la quête errante \"Souhait du Chevalier\" pour débloquer ensuite"
  },
  Activity_36885_ActivityName = {
    Text = "Fête Brûlante"
  },
  Activity_36886_ActivityName = {
    Text = "Reine des Épines"
  },
  Activity_36886_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Pendant l'événement \"Reine des Épines\", les Gardiens peuvent utiliser des équipes préétablies par le système incluant Wanda pour expérimenter des niveaux désignés à l'infini.\n·Lors de l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir réussi à terminer le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_38716_ActivityName = {
    Text = "Enquête redémarrée"
  },
  Activity_38716_ActivityTips = {
    Text = "<Title:Event Introduction>\n· Les Gardiens peuvent réclamer directement les récompenses \"Ressource de Redémarrage\" dans les \"Récompenses de Retour à l'École\". \n· Complétez les tâches d'entraînement désignées pour recevoir des récompenses dans l'événement \"Redémarrage de l'Investigation\".\n· Compléter toutes les tâches d'entraînement permettra également d'obtenir des récompenses supplémentaires."
  },
  Activity_38717_ActivityName = {
    Text = "Inscription de rentrée des classes"
  },
  Activity_38717_ActivityTips = {
    Text = "<Title:Event Overview>\n· Les Gardiens peuvent réclamer la récompense de connexion quotidienne dans \"Retour au Rapport Scolaire\" après s'être connectés chaque jour.\n· Les récompenses seront débloquées séquentiellement en fonction des connexions cumulatives des Gardiens, et les récompenses de connexion quotidienne seront rafraîchies à 9:00 AM (GMT+8)."
  },
  Activity_38805_ActivityName = {
    Text = "Fête Brûlante"
  },
  Activity_38805_ActivityPlot = {
    Text = "Isaraou, la ville au bord du lac, serait selon la légende le lieu d'origine de wanda.\nCette fois, vous passerez par la porte des rêves, atteignant ce vieux groupe de tours recouvertes de cloches"
  },
  Activity_38805_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n· Pendant l'événement, le mode « Fête Brûlante » sera temporairement ouvert, et « Plongée dans l'inconscient : Fête Brûlante » sera débloqué gratuitement pendant une durée limitée !\n\n<Title:Ville du lac>\n· La « Ville du lac » comporte 7 niveaux, un nouveau niveau sera ouvert tous les 2 jours ! Les ennemis et les événements de chaque niveau peuvent varier aléatoirement.\n· Veuillez noter que les types, quantités et proportions des matériaux récompensés à chaque niveau peuvent changer. Les premiers niveaux ouverts auront des types plus simples, tandis que les niveaux ouverts plus tard seront plus variés, mais la quantité totale sera plus importante. Choisissez votre méthode de stratégie selon vos besoins !\n· Chaque niveau contient 7 niveaux de difficulté, avec une plage de niveaux recommandée de 15 à 65, tous les niveaux de difficulté sont déverrouillés par défaut.\n· Chaque défi nécessite de consommer Ménophine ×120. Plus la difficulté est élevée, plus les récompenses obtenues seront importantes. Veuillez choisir une difficulté adaptée pour relever le défi.\n· Les matériaux des récompenses de niveau peuvent être échangés dans la boutique « La Boîte aux Trésors de Wanda » pour obtenir de nombreux matériaux de culture pour Éveilleur, ainsi qu'un avatar exclusif à l'événement « Au nom de la Clé d'Argent : Wanda ».\n· Vous pouvez utiliser l'assistance de l'association des anciens élèves et « Résonance : Ordre secret » pour vous aider à réussir plus facilement.\n\n<Title:Résonance et succès>\n· En dépensant « Cœur de plaisir », vous pouvez activer « Résonance : Ordre secret », ce qui permettra au Gardien de devenir plus fort dans la « Ville du lac », rendant les défis plus faciles ; cela permettra également au Gardien de gagner des devises d'événement supplémentaires lors de la réussite.\n· Les Gardiens du secret peuvent obtenir « Cœur de plaisir » en atteignant les succès de l'événement, et peuvent également les échanger dans la boutique « La Boîte aux Trésors de Wanda ».\n\n<Title:Plongée dans l'inconscient>\n· Pendant l'événement, « Fête Brûlante » peut être déverrouillé gratuitement. Chaque jour, un nouvel événement d'enquête sera proposé dans « Fête Brûlante », et en complétant cet événement d'enquête, vous pourrez obtenir des récompenses d'enquête telles que Cœur Immaculé, Badge d'enquête et Expérience du Gardien des Secrets.\n· À la fin de l'événement, la progression de l'enquête de « Fête Brûlante » sera conservée. En complétant les événements d'enquête non terminés pendant l'événement, vous pourrez également obtenir des récompenses d'enquête identiques à celles de la période de l'événement. Si « Fête Brûlante » n'a pas été déverrouillée pendant l'événement, vous pourrez toujours dépenser « Point de départ réel » ×3 pour déverrouiller après la fin de l'événement.\n· Pendant l'événement, des récompenses de succès temporaires seront proposées. Après que le Gardien ait complété les événements d'enquête de « Fête Brûlante », il pourra réclamer des récompenses de Cœur d'argent dans les succès de l'événement ! Les récompenses de succès ne seront disponibles que pendant l'événement, et ne pourront pas être complétées ou réclamées après la fin de l'événement.\n"
  },
  Activity_41378_ActivityName = {
    Text = "Entraînement spécial pour la catastrophe"
  },
  Activity_41378_ActivityTips = {
    Text = "\nRègles de l'Événement :\n1. Après avoir terminé les tâches spécifiées, les Gardiens peuvent réclamer des récompenses dans \"Formation de Bienvenue au Désastre\".\n2. \"Formation de Bienvenue au Désastre\" est disponible en permanence.\n3. Après avoir débloqué \"Voyage Avancé\", les Gardiens peuvent recevoir des récompenses supplémentaires après avoir terminé des tâches.\n4. Veuillez noter : Le \"Voyage Avancé\" débloqué lors de cet événement n'est valable que durant cet événement. Les Gardiens sont conseillés de consommer rationnellement."
  },
  Activity_43569_ActivityName = {
    Text = "Voyage océanique"
  },
  Activity_43569_ActivityTips = {
    Text = "\nRègles de l'Événement :\n1. Après avoir terminé les tâches de voyage spécifiées, les Gardiens peuvent réclamer des récompenses dans \"Voyage Océanique\".\n2. \"Voyage Océanique\" est ouvert en permanence.\n3. Après avoir débloqué \"Voyage Avancé\", les Gardiens peuvent recevoir des récompenses supplémentaires après avoir terminé des tâches.\n4. Veuillez noter : Le \"Voyage Avancé\" débloqué lors de cet événement n'est valable que durant cet événement. Les Gardiens sont conseillés de consommer rationnellement."
  },
  Activity_43570_ActivityName = {
    Text = "Voyage à Neigebourg"
  },
  Activity_43570_ActivityTips = {
    Text = "\nRègles de l'Événement :\n1. Après avoir terminé des tâches de voyage spécifiées, les Gardiens peuvent réclamer des récompenses dans \"Voyage à la Neige\".\n2. \"Voyage à la Neige\" est ouvert en permanence.\n3. Après avoir débloqué \"Voyage Avancé\", les Gardiens peuvent recevoir des récompenses supplémentaires après avoir terminé des tâches.\n4. Veuillez noter : Le \"Voyage Avancé\" débloqué lors de cet événement n'est valable que durant cet événement. Les Gardiens sont conseillés de consommer raisonnablement."
  },
  Activity_43572_ActivityName = {
    Text = "Esthétique de l'alchimie"
  },
  Activity_43572_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Esthétique de l'alchimie», les Gardiens du secret recevront un bonus supplémentaire de 100% (hors Expérience du Gardien des Secrets) lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Recherche de coupons d'or», limité à 6 fois par jour."
  },
  Activity_43573_ActivityName = {
    Text = "Esthétique de l'alchimie"
  },
  Activity_43573_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Esthétique de l'alchimie», les Gardiens du secret recevront un bonus supplémentaire de 50% en Billet Rose Dorée lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Recherche de coupons d'or»."
  },
  Activity_43574_ActivityName = {
    Text = "Esthétique de l'alchimie"
  },
  Activity_43574_ActivityTips = {
    Text = "Règles de l'événement:\n1. Pendant l'événement «Esthétique de l'alchimie», les Gardiens du secret recevront un bonus supplémentaire de 50% en Billet Rose Dorée lorsqu'ils enquêtent ou effectuent une Reconstitution dans «Recherche de coupons d'or»."
  },
  Activity_44273_ActivityName = {
    Text = "Gardien de l'Âme"
  },
  Activity_44273_ActivityPlot = {
    Text = "Il a souffert pour vous, porté vos calamités.\nPar sa chair, vous avez été guéris;\nPar sa vie, vous avez été pardonnés."
  },
  Activity_44273_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, le Gardien du Secret peut collecter des monnaies d'événement « Billets de vente au profit d'une bonne cause » via les modes de jeu temporaires « Chemin du Sanctuaire », « La bonne volonté des citoyens » et « Récompenses de succès ». Les « Billets de vente au profit d'une bonne cause » peuvent être échangés contre des articles aléatoires dans la « Salle de vente de l'église », y compris la roue du destin SR exclusive « L'homme dans le miroir », le Cœur Immaculé, le Cœur de Lumens, etc. \n2. Terminer « Enregistrement de la task force : La couleur du sang » permet d'obtenir le nouveau Décret Clé « Miracle descendu ». Pendant l'événement, « Enregistrement de la task force : La couleur du sang » est déverrouillé gratuitement pour une durée limitée, et en complétant les succès de l'événement, vous pouvez également obtenir l'avatar exclusif à l'événement « Au nom de la Clé d'Argent : Salvador » !\n\n<Title:Chemin du Sanctuaire>\n1. « Chemin du Sanctuaire » comprend 5 niveaux, le Gardien du Secret peut les déverrouiller un par un en terminant les niveaux 2/4/6/7/9 de « Enregistrement de la task force : La couleur du sang ».\n2. Chaque niveau a 7 difficultés, avec un niveau recommandé de 15 à 65, toutes les difficultés étant déverrouillées par défaut. Les ennemis et événements de chaque niveau peuvent changer aléatoirement. \n3. Vous pouvez utiliser l'aide de l'association d'anciens élèves et « Résonance : Les carrefours de l'âme » pour vous aider à passer plus facilement.\n4. Chaque défi nécessite de consommer 120 Ménophine, plus la difficulté est élevée, plus vous obtiendrez de « Billets de vente au profit d'une bonne cause » en réussissant. De plus, le Gardien du Secret peut choisir un défi double, consommant 240 Ménophine, pour obtenir le double de « Billets de vente au profit d'une bonne cause » et d'expérience du Gardien du Secret. \n\n<Title:Bonus de brillance>\n1. Sous l'influence de « Brillance de l'âme », l'Éveilleur « Salvador », la roue du destin SSR « Tables de la Loi » et la roue du destin SR « L'homme dans le miroir » peuvent donner un bonus supplémentaire aux « Billets de vente au profit d'une bonne cause » dans les récompenses des missions de « Chemin du Sanctuaire », les bonus spécifiques sont les suivants : \n(1) Méthode 1 : Le Gardien du Secret possède un Éveilleur ou une roue du destin spécifique (pas besoin d'être en combat) \n· Éveilleur « Salvador » : Déblocage 0/1/2/3 et plus, bonus de 30%/40%/50%/60%.\n· La roue du destin SSR « Tables de la Loi » : Superposition 0/1/2/3 et plus, bonus de 30%/40%/50%/60%.\n· La roue du destin SR « L'homme dans le miroir » : Superposition 0/1/2/3 et plus, bonus de 15%/20%/25%/30%.\n(2) Méthode 2 : Utiliser un Éveilleur ou une roue du destin spécifique pour l'aide \n· Éveilleur « Salvador » : bonus de 10%.\n· La roue du destin SSR « Tables de la Loi » : bonus de 10%.\n· La roue du destin SR « L'homme dans le miroir » : bonus de 5%.\n2. Pour le même Éveilleur ou roue du destin, le « bonus de brillance » est appliqué selon la méthode avec le bonus le plus élevé, sans cumul.\n3. Les « bonus de brillance » de différents Éveilleurs ou roues du destin sont calculés de manière additive, selon les règles ci-dessus, le Gardien du Secret peut obtenir jusqu'à 150% de « bonus de brillance » !\n\n<Title:Résonance : Les carrefours de l'âme>\n1. Le Gardien du Secret peut obtenir un « Cœur de pénitence » en complétant des succès d'événement. \n2. En consommant un « Cœur de pénitence », activer « Résonance : Les carrefours de l'âme » peut offrir les bonus suivants : \n(1) Rendre le Gardien du Secret plus fort dans les modes de jeu « Chemin du Sanctuaire » et « Enregistrement de la task force : La couleur du sang », rendant les défis plus faciles. \n(2) Améliorer le taux de synchronisation obtenu après avoir terminé le défi « Chemin du Sanctuaire ». \n(3) Activer le mode de jeu « La bonne volonté des citoyens ».\n\n<Title:La bonne volonté des citoyens>\n1. Après avoir activé la résonance « Façon facile », vous obtiendrez automatiquement 60 « Billets de vente au profit d'une bonne cause » par heure, avec un maximum de stockage de 25 heures. \n2. Après avoir activé la résonance « Pénitence, Pénitence », vous obtiendrez automatiquement 1800 Billets Rose Dorée supplémentaires par heure. \n\n<Title:Salle de vente de l'église>\n1. Le Gardien du Secret peut utiliser les « Billets de vente au profit d'une bonne cause » pour échanger aléatoirement des articles dans la « Salle de vente de l'église », des produits comme la roue du destin SR exclusive « L'homme dans le miroir », le Cœur de Lumens et le Cœur Immaculé vous attendent ~\n2. La Salle de vente de l'église contient trois boutiques, les horaires d'ouverture sont les suivants : \n· Boutique « La boutique de Mme Grey » : ouverture initiale.\n· Boutique « La vente miraculeuse de Big John » : ouverture le 4ème jour de l'événement.\n· Boutique « Vente spéciale de Smith » : ouverture le 7ème jour de l'événement. \n3. Les articles des différentes boutiques sont différents, le Gardien du Secret peut choisir des articles à échanger selon ses besoins. \n4. Chaque boutique contient des articles spéciaux et des articles ordinaires, chaque échange consommera 600 « Billets de vente au profit d'une bonne cause », obtenant aléatoirement cinq articles de la boutique. \n5. Lorsque tous les articles spéciaux de la boutique sont échangés, le Gardien du Secret peut demander un réapprovisionnement de la boutique ou choisir de continuer à échanger. Lorsque tous les articles de la boutique sont échangés, le Gardien du Secret doit choisir de réapprovisionner avant de pouvoir continuer à échanger. \n6. Pour les deux premières demandes de réapprovisionnement de chaque boutique, la quantité restante de tous les articles de la boutique sera réapprovisionnée jusqu'à la limite, à partir de la 3ème demande de réapprovisionnement, les articles spéciaux ne seront plus réapprovisionnés, seuls les articles ordinaires seront réapprovisionnés. Après le réapprovisionnement, la quantité restante des articles non échangés précédemment ne sera pas conservée, le Gardien du Secret doit réfléchir attentivement avant de choisir de réapprovisionner ~\n\n<Title:Enregistrement de la task force>\n1. Pendant l'événement, l'enregistrement « La couleur du sang » peut être déverrouillé gratuitement. Tous les 2 jours, un nouvel événement d'enquête « La couleur du sang » sera lancé, en complétant l'événement d'enquête, vous pouvez obtenir le Décret Clé « Miracle descendu », le Cœur Immaculé, le Badge d'enquête et l'expérience du Gardien du Secret, etc. \n2. Après la fin de l'événement, la progression de l'enquête de « La couleur du sang » sera conservée, et en complétant les événements d'enquête non terminés pendant l'événement, vous pouvez également obtenir des récompenses d'enquête identiques à celles de l'événement. Si « La couleur du sang » n'a pas été déverrouillé pendant l'événement, après la fin de l'événement, vous pourrez toujours consommer « Point de départ réel » ×7 pour le déverrouiller. \n3. Pendant l'événement, des récompenses de succès temporaires seront lancées, et après avoir complété tous les événements d'enquête de « La couleur du sang », le Gardien du Secret pourra réclamer l'avatar « Au nom de la Clé d'Argent : Salvador » dans les succès de l'événement ! Les récompenses de succès ne seront ouvertes que pendant l'événement, et ne pourront pas être complétées ou réclamées après la fin de l'événement. \n\n"
  },
  Activity_44626_ActivityName = {
    Text = "Gardien de l'Âme"
  },
  Activity_44705_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_44705_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_44706_ActivityName = {
    Text = "Bishop de baumes"
  },
  Activity_44706_ActivityTips = {
    Text = "<Title:Règles de l'activité>\n·Pendant l'événement \"Évêque Bienveillant\", les Gardiens peuvent utiliser des équipes prédéfinies par le système contenant Salvador pour expérimenter des niveaux désignés un nombre illimité de fois.\n·Lors de la réalisation des niveaux d'événement, des ajustements au Réveiller dans la composition de l'équipe ne peuvent pas être effectués.\n<Title:Récompenses de l'activité>\n·Après avoir réussi un défi de niveau pour la première fois, vous pouvez réclamer des récompenses d'essai depuis l'interface de l'événement."
  },
  Activity_44716_ActivityName = {
    Text = "Souverain endormi"
  },
  Activity_44716_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Lors de l'événement \"Souverain du Sommeil\", les Gardiens peuvent utiliser des équipes prédéfinies par le système comprenant Tulu pour vivre des niveaux désignés à l'infini.\n·Lors de l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir terminé avec succès le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_45664_ActivityName = {
    Text = "La chute d'un géant"
  },
  Activity_45664_ActivityPlot = {
    Text = "L'océan sans fin, le soleil ardent, un héros Philistin exilé et son unique serviteur.\nC'est une histoire de « recherche »."
  },
  Activity_45664_ActivityTips = {
    Text = "<Title:Conditions de participation>\nTerminez la Plongée dans l'inconscient « Le Vœu du Chevalier » en mode Normal pour participer.\n<Title:Événement d'enquête>\nPendant la durée de l'événement, les Gardiens du secret peuvent débloquer et enquêter sans consommer d'inventaire. Après avoir terminé l'événement d'enquête, des récompenses telles que des Cœurs Immaculés, des Badges d'enquête et de l'Expérience du Gardien des Secrets peuvent être obtenues.\nAprès la fin de l'événement, l'état de déverrouillage et la progression d'enquête de « La Chute du Géant » seront conservés. Terminer des événements d'enquête non terminés pendant la durée de l'événement accordera également des récompenses identiques à celles de l'événement ; si non débloqué pendant la durée de l'événement, il pourra être débloqué après la fin de l'événement en consommant Point de départ réel *3.<Title:Récompenses à durée limitée>\nDes récompenses à durée limitée seront disponibles pendant l'événement. Les Gardiens du secret peuvent obtenir des Cristaux de dimension et de l'Argent après avoir terminé « La Chute du Géant » en mode Normal et complété les événements d'enquête de « La Chute du Géant » ! Les récompenses à durée limitée ne sont disponibles que pendant la durée de l'événement et ne peuvent être complétées ou réclamées après la fin de l'événement."
  },
  Activity_45664_UnlockConditionExplanation = {
    Text = "Complétez la quête errante \"Souhait du Chevalier\" pour débloquer ensuite"
  },
  Activity_46167_ActivityName = {
    Text = "Patient dissociatif : chaos"
  },
  Activity_46167_ActivityTips = {
    Text = "<Title:Règles de l'activité>\n·Pendant l'événement \"Patient Éclaté: Chaos\", les Gardiens peuvent utiliser des équipes prédéfinies par le système contenant \"24\" pour expérimenter des niveaux désignés un nombre illimité de fois.\n·Lors de la réalisation des niveaux d'événement, des ajustements au Réveiller dans la composition de l'équipe ne peuvent pas être effectués.\n<Title:Récompenses de l'activité>\n·Après avoir réussi un défi de niveau pour la première fois, vous pouvez réclamer des récompenses d'essai depuis l'interface de l'événement."
  },
  Activity_46168_ActivityName = {
    Text = "Chasseresse de crânes"
  },
  Activity_46168_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Pendant l'événement \"Chasseresse des Crânes\", les Gardiens peuvent utiliser des équipes préétablies par le système incluant Jonquille pour expérimenter des niveaux désignés à l'infini.\n·Lors de l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir réussi à terminer le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_46609_ActivityName = {
    Text = "Guérison multiple"
  },
  Activity_46609_ActivityPlot = {
    Text = "Symptôme : Hystérie, également connu sous le nom de trouble hystérique.\nÀ votre époque, c'est synonyme de mort.\n\nHeureusement, les scientifiques et enquêteurs de Mizag sont tout aussi fous : ils sont déterminés à résoudre ce problème"
  },
  Activity_46609_ActivityStageEndContent = {
    Text = "L'événement est terminé. Actuellement, seule \"Analyse de Personnalité\" est disponible."
  },
  Activity_46609_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, les Gardiens du Secret peuvent collecter la monnaie de l'événement « Puzzles de Mémoire » via les modes de jeu temporaires « Codage de Mémoire », « Stockage de Bord » et « Récompenses de Succès ». Les « Puzzles de Mémoire » peuvent être utilisés pour acheter des articles dans « Analyse de Personnalité », y compris la roue du destin SR exclusive « Détermination du Cabillaud Argenté », le Cœur de Lumens, le Cœur Immaculé, la Pierre philosophale et des matériaux de développement riches. \n2. En terminant « Enregistrement de la task force : Fission Calme », vous pouvez obtenir le nouveau décret « Tout d'elle ». Pendant l'événement, « Enregistrement de la task force : Fission Calme » sera déverrouillé gratuitement pendant une période limitée, et en complétant les succès de l'événement, vous pourrez également obtenir l'icône exclusive « Au nom de la Clé d'Argent : «24» » !\n\n<Title:Temps de l'événement>\n1. Du 27 avril à 9h00 au 18 mai à 9h00 (GMT+8), tous les modes de jeu sont accessibles, « Enregistrement de la task force : Fission Calme » sera déverrouillé gratuitement pendant une période limitée. \n2. Du 18 mai à 9h00 au 25 mai à 9h00 (GMT+8), seuls « Analyse de Personnalité » et les Récompenses de Succès seront disponibles, « Enregistrement de la task force : Fission Calme » nécessitera 7 Points de départ réel pour être déverrouillé. \n\n<Title:Codage de Mémoire>\n1. Le « Codage de Mémoire » contient 5 niveaux, les Gardiens du Secret peuvent débloquer chaque niveau en complétant les niveaux 2/4/6/8/10 de « Enregistrement de la task force : Fission Calme ». \n2. Chaque niveau a 7 difficultés, le niveau recommandé est de 15 à 65, toutes les difficultés sont déverrouillées par défaut. Les ennemis et événements de chaque niveau peuvent changer de manière aléatoire. \n3. Vous pouvez utiliser le soutien de l'association des anciens élèves et « Résonance : Syndrome de Séparation » pour vous aider à passer les niveaux plus facilement. \n4. Chaque défi nécessite 120 Ménophine, plus la difficulté est élevée, plus vous obtiendrez de « Puzzles de Mémoire » à la fin. De plus, les Gardiens peuvent choisir de relever un défi double, coûtant 240 Ménophine, pour obtenir le double des « Puzzles de Mémoire » et de l'expérience du Gardien. \n\n<Title:Bonus de Raison>\n1. Les Gardiens possédant un certain Éveilleur ou une roue du destin (pas besoin d'être en formation) peuvent obtenir un bonus de chute supplémentaire sur les « Puzzles de Mémoire » dans les récompenses des missions des niveaux du « Codage de Mémoire », les bonus spécifiques sont les suivants :\n· Éveilleur « 24 » : Dégagement 0/1/2/3 et plus, bonus de 15%/20%/25%/30%.\n· Éveilleur « Davendale » : Dégagement 0/1/2/3 et plus, bonus de 15%/20%/25%/30%.\n· SSR roue du destin « Rétroaction du corps déformé » : Superposition 0/1/2/3 et plus, bonus de 15%/20%/25%/30%.\n· SSR roue du destin « Une Collection des plus Précieuses » : Superposition 0/1/2/3 et plus, bonus de 15%/20%/25%/30%.\n· SR roue du destin « Détermination du Cabillaud Argenté » : Superposition 0/1/2/3 et plus, bonus de 15%/20%/25%/30%.\n2. Les « Bonus de Raison » des différents Éveilleurs ou roues du destin sont cumulés. \n\n<Title:Résonance : Syndrome de Séparation>\n1. Les Gardiens peuvent obtenir un « Cœur scindé » en complétant les succès de l'événement. \n2. En dépensant un « Cœur scindé », activer « Résonance : Syndrome de Séparation » peut vous donner les bonus suivants :\n(1) Rendre les Gardiens plus forts dans les modes de jeu de l'événement « Codage de Mémoire » et « Enregistrement de la task force : Fission Calme », facilitant les défis. \n(2) Augmenter les récompenses obtenues après avoir complété le défi du « Codage de Mémoire ». \n(3) Activer le mode de jeu de l'événement « Stockage de Bord ». \n\n<Title: Stockage de Bord>\n· Après avoir activé la résonance « Diagnostic : Fissure de personnalité », vous obtiendrez automatiquement 60 « Puzzles de Mémoire α » chaque heure, avec un maximum de 25 heures de stockage. \n\n<Title:Enregistrement de la task force>\n1. Pendant l'événement, « Enregistrement de la task force : Fission Calme » sera déverrouillé gratuitement. Tous les 2 jours, un nouvel événement d'enquête « Fission Calme » sera lancé, en complétant l'événement d'enquête, vous pourrez obtenir le décret « Tout d'elle », le Cœur Immaculé, le badge d'enquête et l'expérience du Gardien, etc. \n2. À la fin de l'événement, les progrès de l'enquête de « Enregistrement de la task force : Fission Calme » seront conservés, et en complétant les événements d'enquête non terminés pendant la période de l'événement, vous pourrez également obtenir les mêmes récompenses d'enquête que pendant l'événement. Si « Enregistrement de la task force : Fission Calme » n'est pas déverrouillé pendant la période de l'événement, il sera toujours possible de le déverrouiller après la fin de l'événement en dépensant 7 Points de départ réel. \n3. Pendant l'événement, des récompenses de succès temporaires seront lancées, et après que les Gardiens aient complété tous les événements d'enquête de « Enregistrement de la task force : Fission Calme », ils pourront recevoir l'icône « Au nom de la Clé d'Argent : «24» » dans les succès de l'événement ! Les récompenses de succès ne seront disponibles que pendant la période de l'événement, et ne pourront pas être complétées ou reçues après la fin de l'événement. \n\n\n"
  },
  Activity_46609_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_47534_ActivityName = {
    Text = "Fission Calme"
  },
  Activity_48136_ActivityName = {
    Text = "Patient dissociatif : aequor"
  },
  Activity_48136_ActivityTips = {
    Text = "<Title:Règles de l'activité>\n·Pendant l'événement \"Patient Éclaté: Aequor\", les Gardiens peuvent utiliser des équipes prédéfinies par le système contenant \"24\" pour expérimenter des niveaux désignés un nombre illimité de fois.\n·Lors de la réalisation des niveaux d'événement, des ajustements au Réveiller dans la composition de l'équipe ne peuvent pas être effectués.\n<Title:Récompenses de l'activité>\n·Après avoir réussi un défi de niveau pour la première fois, vous pouvez réclamer des récompenses d'essai depuis l'interface de l'événement."
  },
  Activity_48137_ActivityName = {
    Text = "Patient dissociatif : caro"
  },
  Activity_48137_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Lors de l'événement \"Patient Divisé : Caro\", les Gardiens peuvent utiliser des équipes prédéfinies par le système comprenant \"24\" pour vivre des niveaux désignés à l'infini.\n·Lors de l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir terminé avec succès le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_48138_ActivityName = {
    Text = "Patient dissociatif : ultra"
  },
  Activity_48138_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Lors de l'événement \"Patient Divisé : Ultra\", les Gardiens peuvent utiliser des équipes prédéfinies par le système comprenant \"24\" pour vivre des niveaux désignés à l'infini.\n·Lors de l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir terminé avec succès le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_48719_ActivityName = {
    Text = "Vagues de Désir"
  },
  Activity_48719_ActivityPlot = {
    Text = "Les rêves sont la révélation des désirs enfouis. Ceux qui s'y attardent seront piégés par les marées de l'envie, devenant les apôtres de la luxure... à moins que..."
  },
  Activity_48719_ActivityStageEndContent = {
    Text = "L'événement est Terminé. Actuellement, seule «Prolifération du désir» est disponible."
  },
  Activity_48719_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, les Gardiens du secret pourront collecter la monnaie d'événement « Graine mère » via le mode temporaire « Désir chaotique » et les « Récompenses de succès », et échanger les « Graines mères » contre des récompenses dans « Vague de désir », incluant des Cœurs de Lumens, des Cœurs Immaculés et des ressources de développement généreuses.\n2. Pendant l'événement, les Gardiens du secret qui terminent la « Mission d'enquête 2-9·Normal » pourront participer à « Frénésie de Litière » et débloquer les « Événements de Frénésie de Litière » sans avoir à satisfaire les exigences de taux de synchronisation des Corps éveillés, en outre, la quantité requise de « Point de départ réel » est réduite à seulement 1 !\n3. Une mystérieuse force semble vous aider à établir une relation plus profonde avec les Corps éveillés : le taux de synchronisation obtenu par tous les moyens sera doublé pendant la durée de l'événement !\n\n<Title:Période de l'événement>\n1. Du 18 mai 9h00 au 3 juin 9h00 (GMT+8), toutes les activités mentionnées dans la présentation seront disponibles.\n2. Du 3 juin 9h00 au 10 juin 9h00 (GMT+8), seules les fonctions « Vague de désir » et « Récompenses de succès » resteront actives, les autres activités seront terminées et indisponibles.\n\n<Title:Désir chaotique>\n1. « Désir chaotique » contient 10 étapes de ressources sans exploration, directement accessibles au combat, une étape s'ouvrant chaque jour.\n2. Dans ces étapes de ressources, vous éveillerez directement tous les Corps éveillés et obtiendrez des Reliques prédéfinies, en outre, vous recevrez une fois l'aide de Thais après 6 tours.\n3. Chaque défi consommera 60 points de neuropéricine, et ces étapes de ressources pourront être rejouées après leur première réussite.\n4. Vous pourrez utiliser les Alumni pour faciliter la réussite.\n\n<Title:Bonus de Gourmandise>\n1. Les Gardiens du secret possédant certains Corps éveillés ou Roues du Destin spécifiques (pas nécessairement déployés) pourront obtenir un bonus supplémentaire sur les « Graines mères » reçues dans les récompenses des missions de « Désir chaotique » (y compris les rejoueurs), les bonus spécifiques sont les suivants :\nCorps éveillé « Thais » : Dégagement 0/1/2/3 et plus, bonus de 20%/30%/40%/50%\nRoue du Destin SSR « Élevé dans la Douceur » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%\nRoue du Destin SR « Baiser Ardent d'Adieu » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%\n2. Les « Bonus de Gourmandise » de différents Corps éveillés ou Roues du Destin s'additionnent.\n\n<Title:Frénésie de Litière>\n1. Après avoir terminé la « Mission d'enquête 7-3·Normal », un nouveau contenu spécial d'enquête « Frénésie de Litière » sera débloqué !\n2. Avec l'arrivée de l'événement « Vague de désir », les Corps éveillés sont influencés par une force mystérieuse et tombent dans l'état de « Frénésie de Litière »... Prenez garde, chers Gardiens du secret !\n3. Lorsque le taux de synchronisation du Corps éveillé atteint le niveau 10, vous pourrez débloquer l'« Événement de Frénésie de Litière » de ce Corps éveillé, en consommant 7 « Points de départ réels », une fois accompli, vous obtiendrez 1 « Cœur Immaculé » !\n4. Durant la période de l'événement « Vague de désir » (avant le 3 juin 9h00), les conditions de participation seront assouplies : il suffira d'avoir terminé la « Mission d'enquête 2-9·Normal », sans exigence de taux de synchronisation pour débloquer l'« Événement de Frénésie de Litière », en outre, la quantité requise de « Points de départ réels » est réduite à seulement 1 !\n\n<Title:Duplication du taux de synchronisation>\n1. Une mystérieuse force semble vous aider à établir une relation plus profonde avec les Corps éveillés : le taux de synchronisation obtenu par tous les moyens sera doublé pendant la durée de l'événement !\n2. Ce bonus se combine avec les autres bonus de taux de synchronisation de manière multiplicative, comme les bonus d'alliés.\n<Title:Récompenses de succès>\n1. En accomplissant toutes les missions, vous obtiendrez des récompenses : 800 Cœurs d'argent, de nombreuses « Graines mères », la Roue du Destin SR exclusive de l'événement « Baiser Ardent d'Adieu »*16, et l'avatar exclusif de l'événement « Au nom de la Clé d'argent : Thais ».\n2. Contient 16 missions : réussir une fois chacune des étapes de « Désir chaotique », rejouer 10/20/30/40/50 fois au total dans « Désir chaotique », accomplir toutes les missions de succès de l'événement.\n\n\n\n"
  },
  Activity_48719_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_48825_ActivityName = {
    Text = "Gratitude du chat d'école"
  },
  Activity_48825_ActivityPlot = {
    Text = "Les Gardiens du secret peuvent choisir 1 des Corps éveillés limités suivants pour le Réveiller !"
  },
  Activity_48825_ActivityTips = {
    Text = "<Title:Présentation>\nSans votre vigilance enthousiaste, les Mizags auraient pu rester à jamais ensevelis dans la longue nuit. Aujourd'hui, nous avons tenu notre promesse, traversé les épreuves, et atteint le cap du demi–anniversaire. Pour cela, le Chat de l'école vous offrira un cadeau spécial en guise de remerciement pour votre fidèle compagnie tout au long du chemin.\n\n<Title:Règles de l'événement>\nPendant l'événement, chaque Gardien peut choisir 1 Corps éveillé parmi 8 Corps éveillés SSR en édition limitée, incluant Tulu, Daffodil, Sorel, Lily, Murphy, Wanda, Salvador et «24».\nLorsqu'un Gardien sélectionne un Corps éveillé déjà Réveillé, il sera converti en Fragment correspondant*1 et Fondement profond*50 ; si le niveau de Dégagement du Corps éveillé correspondant est au maximum, il sera converti en Fragment de Noyau Spirituel*1 et Fondement profond*150."
  },
  Activity_48825_BannerText = {
    Text = "Réveiller Gratuit Limité"
  },
  Activity_48826_ActivityName = {
    Text = "De la Nuit à l'Aube"
  },
  Activity_48826_ActivityPlot = {
    Text = "Connectez–vous chaque jour pour réclamer la Roue du Destin SSR commémorative limitée « De la Nuit à l'Aube », jusqu'à 16 au total !"
  },
  Activity_48826_ActivityTips = {
    Text = "<Title:Introduction>\nCeci est un poème dédié aux joueurs, sur des idéaux, sur la foi, et sur le temps passé ensemble. Que le cœur sincère ne cesse jamais de battre, et que la Clé d'Argent guide le chemin à suivre.\n\n<Title:Event Rules>\n· Pendant l'événement, les Gardiens peuvent se connecter quotidiennement pour recevoir la roue commémorative SSR limitée \"Nuit Polaire et Aube\" de \"Nuit Polaire et Aube\", pour un total de jusqu'à 16 réclamations.\n· Les récompenses se débloqueront séquentiellement en fonction des connexions quotidiennes cumulées des Gardiens, et les récompenses de connexion quotidienne se rafraîchiront à 9h00 (GMT+8)."
  },
  Activity_48826_BannerText = {
    Text = "RdD SSR limitée gratuite"
  },
  Activity_48827_ActivityName = {
    Text = "Argent dans le chapeau"
  },
  Activity_48827_ActivityPlot = {
    Text = "Selon des statistiques incomplètes, au cours des six derniers mois, le chapeau du Chat de l'école a été tapoté des milliers de fois par les étudiants, et de nombreux petits Cœurs d'argent discrets sont tombés au sol sans que personne ne s'en aperçoive. Les agents d'entretien en sont très contrariés. L'école a désormais collecté et soigneusement nettoyé ces Cœurs d'argent, et les a entreposés au bureau des objets trouvés. Les propriétaires sont invités à venir les récupérer rapidement."
  },
  Activity_48827_ActivityTips = {
    Text = "<Title:Présentation>\nSelon des statistiques incomplètes, au cours des six derniers mois, les étudiants ont pris des milliers de photos du chapeau du chat de l'école. De nombreux petits cœurs d'argent discrets sont tombés au sol sans être réclamés. Les agents d'entretien responsables du nettoyage en sont très contrariés. L'école a désormais collecté ces cœurs d'argent, les a soigneusement nettoyés et les a entreposés au bureau des objets trouvés. Les propriétaires légitimes sont priés de se présenter pour les récupérer.\n\n<Title:Règles de l'événement>\nPendant l'événement, les Gardiens du secret peuvent se connecter chaque jour pour réclamer 1000 Cœurs d'argent depuis « Cœur d'argent dans le chapeau », avec un maximum de 5 réclamations.\nLes récompenses seront débloquées séquentiellement en fonction des connexions cumulées des Gardiens du secret, et les récompenses de connexion quotidienne seront actualisées à 9h (GMT+8)."
  },
  Activity_48827_BannerText = {
    Text = "Connectez–vous pour récupérer plein d'Argent"
  },
  Activity_48849_ActivityName = {
    Text = "Apôtre de la mer"
  },
  Activity_48849_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n· Pendant l'événement \"Apostle de la Mer\", les Gardiens peuvent utiliser des équipes préétablies par le système qui incluent Miryam pour vivre les niveaux désignés indéfiniment.\n· Lors de l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n· Après avoir réussi à compléter le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_48850_ActivityName = {
    Text = "Souffle de fertilité"
  },
  Activity_48850_ActivityTips = {
    Text = "<Title:Règles de l'activité>\n·Pendant l'événement \"Souffle Abondant\", les Gardiens peuvent utiliser des équipes prédéfinies par le système contenant Thais pour expérimenter des niveaux désignés un nombre illimité de fois.\n·Lors de la réalisation des niveaux d'événement, des ajustements au Réveiller dans la composition de l'équipe ne peuvent pas être effectués.\n<Title:Récompenses de l'activité>\n·Après avoir réussi un défi de niveau pour la première fois, vous pouvez réclamer des récompenses d'essai depuis l'interface de l'événement."
  },
  Activity_48851_ActivityName = {
    Text = "Dame des abysses"
  },
  Activity_48851_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n· Pendant l'événement \"Dame Aequor\", les Gardiens peuvent utiliser des équipes préétablies par le système qui incluent Murphy pour vivre les niveaux désignés indéfiniment.\n· Pendant l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n· Après avoir réussi à compléter le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_48852_ActivityName = {
    Text = "Reine des Épines"
  },
  Activity_48852_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Pendant l'événement \"Reine des Épines\", les Gardiens peuvent utiliser des équipes préétablies par le système incluant Wanda pour expérimenter des niveaux désignés à l'infini.\n·Lors de l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir réussi à terminer le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_48853_ActivityName = {
    Text = "Poème sans nom"
  },
  Activity_48853_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Pendant l'événement \"Poème Sans Nom\", les Gardiens peuvent utiliser des équipes préétablies par le système incluant Horla pour expérimenter des niveaux désignés à l'infini.\n·Lors de l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir réussi à terminer le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_48854_ActivityName = {
    Text = "Détective chanceux"
  },
  Activity_48854_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Lors de l'événement \"Détective Chanceux\", les Gardiens peuvent utiliser des équipes prédéfinies par le système qui incluent Ryker pour vivre des niveaux désignés à l'infini.\n·Lors de l'expérience des niveaux de l'événement, des ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir réussi à terminer le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_48855_ActivityName = {
    Text = "Fleurir de boue"
  },
  Activity_48855_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Pendant l'événement \"Fleur de Mire\", les Gardiens peuvent utiliser des équipes préétablies par le système incluant Lily pour expérimenter des niveaux désignés à l'infini.\n·Lors de la jouabilité des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir réussi à terminer le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_48856_ActivityName = {
    Text = "Madame en rouge"
  },
  Activity_48856_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Pendant l'événement \"Dame Rouge\", les Gardiens peuvent utiliser des équipes préétablies par le système incluant Sorel pour expérimenter des niveaux désignés à l'infini.\n·Lors de l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir réussi à terminer le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_49249_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_49249_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_49405_ActivityName = {
    Text = "Événement de confession : Activité de déblocage de remise"
  },
  Activity_49406_ActivityName = {
    Text = "Événement double Affinité"
  },
  Activity_51127_ActivityName = {
    Text = "Histoire magie·copie lumière"
  },
  Activity_51127_ActivityPlot = {
    Text = "La mission donnée par poupée n'est jamais simple. \nMême si elle rappelle à plusieurs reprises aux gens de « s'amuser », comment les gardiens peuvent-ils ne pas être nerveux en emmenant un groupe de réveilleurs pour la première fois ? \nMais, n'oublie pas de « t'amuser », d'accord ?"
  },
  Activity_51127_ActivityStageEndContent = {
    Text = "L'événement est terminé. Actuellement, seule la « Boutique de Scripts Magiques » est disponible."
  },
  Activity_51127_ActivityTips = {
    Text = "<Title:Aperçu de l'événement>\n1. L'événement de gameplay « La magie de l'histoire » est de retour pour une durée limitée ! Les Gardiens du secret peuvent accéder au « Magasin de grimoires » et aux « Récompenses de succès » pour obtenir à nouveau la Roue du Destin exclusive à l'événement « Magie de l'Argentique » et l'avatar exclusif à l'événement « Au nom de la Clé d'Argent : Lily » !\n2. Pendant l'événement, « Opération Spéciale : La magie de l'histoire » sera disponible en accès libre limité.\n\n<Title:Durée de l'événement>\n1. Du 3 juin, 9:00 au 17 juin, 9:00 (GMT+8), tout le contenu présenté dans l'introduction de l'événement est accessible.\n2. Du 17 juin, 9:00 au 24 juin, 9:00 (GMT+8), seuls le « Magasin de grimoires » et les « Récompenses de succès » resteront accessibles ; le reste du contenu sera terminé et ne pourra plus être joué.\n\n<Title:Énigmes scénaristiques>\n1. Les « Énigmes scénaristiques » se composent de 9 niveaux de matériaux, un niveau se débloquant automatiquement chaque jour. Après le déblocage, vous devez terminer le niveau d'Opération Spéciale précédent pour y accéder.\n2. Chaque défi consomme 60 points de Ménophine. Les défis réussis vous récompensent avec la monnaie d'événement « Inspiration errante » et des matériaux de cultivation. Terminer les niveaux de matériaux de cet événement prend en charge la reconstitution.\n3. Vous pouvez utiliser l'assistance des Anciens élèves et la « Résonance : valeur de phase du Réalisateur » pour terminer les niveaux plus facilement.\n\n<Title:Bonus d'Inspiration>\n1. Les Gardiens du secret possédant des Corps éveillés ou des Roues du Destin spécifiques (non requis dans l'escouade) obtiennent des bonus de drop supplémentaires pour l'« Inspiration errante » dans les récompenses de tâche des « Énigmes scénaristiques » (y compris la reconstitution). Les bonus spécifiques sont les suivants :\nCorps éveillé « Lily » : Dégagement 0/1/2/3 et plus, bonus 20%/30%/40%/50%\nRoue du Destin SSR « Au Travers de la Douleur » : Cumul 0/1/2/3 et plus, bonus 20%/30%/40%/50%\nRoue du Destin SR « Magie de l'Argentique » : Cumul 0/1/2/3 et plus, bonus 20%/30%/40%/50%\n2. Les « Bonus d'Inspiration » de différents Corps éveillés ou Roues du Destin se cumulent.\n\n<Title:Résonance : valeur de phase du Réalisateur>\n1. Les Gardiens du secret peuvent acquérir des « Cœurs de l'interprétation » en accomplissant les succès de l'événement.\n2. Consommer des « Cœurs de l'interprétation » pour activer la « Résonance : valeur de phase du Réalisateur » rend les Gardiens du secret plus puissants dans le gameplay de l'événement « Énigmes scénaristiques » et « Opération Spéciale : La magie de l'histoire », et améliore les récompenses d'« Inspiration errante » et de Taux de synchronisation obtenues après avoir terminé les défis des « Énigmes scénaristiques ».\n\n<Title:Récompenses de succès>\n1. Accomplir les tâches de succès accorde l'avatar exclusif à l'événement « Au nom de la Clé d'Argent : Lily », la monnaie d'événement « Inspiration errante » et des Cœurs d'argent.\n2. Comprend 25 tâches : terminer chaque niveau des « Énigmes scénaristiques » une fois, utiliser chaque équipe de Royaume pour terminer les « Énigmes scénaristiques » 1/2 fois, terminer chaque événement d'investigation dans « Opération Spéciale : La magie de l'histoire » une fois, et accomplir tous les succès de l'événement.\n\n<Title:Opération Spéciale>\n1. Pendant l'événement, « Opération Spéciale : La magie de l'histoire » peut être débloquée gratuitement.\n2. Dans « Opération Spéciale : La magie de l'histoire », les Gardiens du secret affronteront les défis avec une configuration d'équipe spéciale incluant le préréglage narratif « Lily ».\n\n<Title:Compensation de Résurrection>\n1. Les Gardiens du secret ayant précédemment débloqué « Opération Spéciale : La magie de l'histoire » recevront une compensation de « Inspiration errante » *1000 lors du redéblocage pendant cet événement de reprise.\nLes Gardiens du secret ayant précédemment obtenu l'avatar exclusif à l'événement « Au nom de la Clé d'Argent : Lily » verront automatiquement les récompenses en double converties en « Inspiration errante » *3000.\nLes Gardiens du secret ayant précédemment obtenu le matériau d'activation de Résonance « Cœur de l'interprétation » verront automatiquement chaque « Cœur de l'interprétation » supplémentaire obtenu converti en « Billet Rose Dorée » *5000.\n"
  },
  Activity_51127_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_51611_ActivityName = {
    Text = "La magie de l'histoire"
  },
  Activity_51611_ActivityTips = {
    Text = "<Title:Conditions de participation>\n·Complétez \"Opération Investigation\" 2-9 (Normal) pour participer.\n<Title:Événement d'investigation>\n·Pendant la période de l'événement, un nouvel événement d'investigation de \"Magie des Histoires\" sera lancé chaque jour. Les Gardiens peuvent déverrouiller et enquêter sans consommer d'inventaire. Après avoir terminé l'événement d'investigation, des récompenses telles que le Cœur Pur, le Insigne d'Investigation et l'Expérience de Gardien peuvent être obtenues.\n·Après la fin de l'événement, la progression d'investigation de \"Magie des Histoires\" sera conservée. Les Gardiens peuvent dépenser des D-gemmes dans le Registre Spécial pour débloquer des enquêtes non complétées. Compléter des événements d'investigation non terminés pendant la période de l'événement accordera également des récompenses cohérentes avec celles de l'événement.<Title:Récompenses à durée limitée>\n·Des récompenses à durée limitée seront disponibles durant l'événement. Les Gardiens peuvent obtenir le Cœur Pur, la Pierre Philosophale et des récompenses en Argent après avoir terminé \"Magie des Histoires\" (mode Normal) et complété les événements d'investigation de \"Magie des Histoires\"! Les récompenses à durée limitée ne sont disponibles que pendant la période de l'événement et ne peuvent pas être complétées ou réclamées après la fin de l'événement."
  },
  Activity_51888_ActivityName = {
    Text = "Profanation"
  },
  Activity_51905_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_51905_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_52040_ActivityName = {
    Text = "Cérémonie des Profondeurs"
  },
  Activity_52040_ActivityPlot = {
    Text = "Sur le reflet de l'océan profond, le rêve de son Roi se dissipe, et le Royaume Divin se décompose.\nElle émerge de rêves anciens, foulant les ruines d'un avenir en effondrement.\nElle interroge les Abysses en spirale, mais les Abysses en spirale restent silencieuses.\nElle offre des sacrifices aux Abysses en spirale, pour n'entendre que son propre écho."
  },
  Activity_52040_ActivityStageEndContent = {
    Text = "Événement terminé, participation actuelle uniquement à «Réponse de l'abîme»"
  },
  Activity_52040_ActivityTips = {
    Text = "<Title:Introduction de l'événement>\n1. Pendant l'événement, les gardiens peuvent collecter des devises de l'événement par le biais des modes temporaires « Naissance du Royaume Divin », « Le décret du roi » et « Récompenses de succès ». Ces devises peuvent être utilisées dans « Réponse de l'Abyss » pour offrir des objets en échange, y compris la roue du destin SR limitée à l'événement « L'Appel du Fond Marin », la Pierre philosophale, le Cœur Immaculé, le Cœur de Lumens, etc.\n2. Pendant l'événement, « Monde des Rêves Étranges : Profanation » sera ouvert gratuitement.\n\n<Title: Temps de l'événement>\n1. Du 17 juin 9:00 au 1er juillet 9:00 (GMT+8), tous les contenus de l'événement peuvent être participés.\n2. Du 1er juillet 9:00 au 8 juillet 9:00 (GMT+8), seuls « Réponse de l'Abyss » et « Récompenses de succès » resteront, les autres contenus seront terminés et non accessibles.\n\n<Title: Naissance du Royaume Divin>\n1. « Naissance du Royaume Divin » comprend 5 niveaux, un nouveau niveau s'ouvrira automatiquement tous les 2 jours.\n2. Chaque défi consommera « Ménophine » × 120. En cas de succès, vous obtiendrez des devises de l'événement « Larme du Sacrificateur », « Sang du Sacrificateur » et « Moelle du sacrificateur ». Lors des défis doubles, il faudra consommer 240 Ménophine, et les récompenses de la mission de niveau seront doublées, tandis que les récompenses de taux de synchronisation resteront les mêmes.\n3. Une fois que la complétion des « Récompenses de succès » atteint 100 %, la fonction « Reproduction » des niveaux déjà terminés sera déverrouillée. Chaque « Reproduction » consomme « Ménophine » × 120. Veuillez noter : en utilisant la fonction « Reproduction », il n'est pas possible d'obtenir de taux de synchronisation.\n4. Vous pouvez utiliser le soutien de l'association des anciens élèves et « Résonance : Rituel de la Mer » pour vous aider à terminer plus facilement.\n\n<Title: Bonification de Sacrifice>\n1. Les gardiens possédant un certain Éveilleur ou une roue du destin (aucune exigence de mise en jeu) peuvent obtenir un bonus de chute supplémentaire pour « Larme du Sacrificateur », « Sang du Sacrificateur » et « Moelle du sacrificateur » dans les récompenses de mission de « Naissance du Royaume Divin » (y compris la Reproduction), les bonus spécifiques sont les suivants :\n· Éveilleur « Miryam » : Dégagement 0/1/2/3 et plus, bonus de 20%/30%/40%/50%\n· Roue du destin SSR « La puissance dévouée » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%\n· Roue du destin SR « L'Appel du Fond Marin » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%\n2. Les « Bonifications de Sacrifice » des différents Éveilleurs ou roues du destin sont cumulées.\n\n<Title: Résonance : Rituel de la Mer>\n1. Les gardiens peuvent obtenir « Cœur de piété » en complétant les succès de l'événement.\n2. En consommant « Cœur de piété », vous pouvez activer « Résonance : Rituel de la Mer », ce qui vous donnera les bonus suivants :\n(1) Rendre les gardiens plus puissants dans le mode événement « Naissance du Royaume Divin », rendant les défis plus faciles.\n(2) Améliorer les devises de l'événement obtenues après avoir terminé le défi « Naissance du Royaume Divin ».\n(3) Activer le mode événement « Le décret du roi ».\n\n<Title: Le décret du roi>\n· Après avoir activé la résonance « Épreuve de sacrifice », vous recevrez automatiquement 60 « Larmes du Sacrificateur » chaque heure, avec un maximum de stockage de 25 heures.\n\n<Title: Réponse de l'Abyss>\n1. « Réponse de l'Abyss » comporte trois autels, les horaires d'ouverture sont les suivants :\n· « Autel des Larmes Cristallines » : Ouverture le 17 juin à 9 heures.\n· « Autel de Sang de Gorille » : Ouverture le 19 juin à 9 heures.\n· « Autel des Âmes » : Ouverture le 21 juin à 9 heures.\n2. Chaque offrande consommera 500 « Larmes du Sacrificateur » / « Sang du Sacrificateur » / « Moelle du sacrificateur », et vous obtiendrez aléatoirement cinq objets en récompense de l'autel.\n3. Les récompenses des objets de chaque autel se divisent en « Grâce du Royaume Divin » et « Récompenses banales », lors de la réinitialisation, vous pouvez remettre la quantité restante d'objets désignés à leur maximum, les règles spécifiques sont :\n(1) Pour les 2 premières réinitialisations : lorsque la « Grâce du Royaume Divin » n'a plus de quantité restante, le gardien peut choisir de réinitialiser, après la réinitialisation, les quantités restantes de « Grâce du Royaume Divin » et « Récompenses banales » seront remises à leur maximum ; vous pouvez également choisir de continuer à offrir des objets, lorsque les « Récompenses banales » n'ont plus de quantité restante, une réinitialisation est nécessaire pour continuer à offrir des objets.\n(2) À partir de la 3e réinitialisation : lorsque les « Récompenses banales » n'ont plus de quantité restante, vous pouvez effectuer la réinitialisation, la réinitialisation remettra la quantité restante de « Récompenses banales » à leur maximum, « Grâce du Royaume Divin » ne sera plus réinitialisée.\n\n<Title: Monde des Rêves Étranges>\n1. « Monde des Rêves Étranges » est un nouveau type d'enquête, par rapport à la forme habituelle de narration, « Monde des Rêves Étranges » mettra davantage l'accent sur l'expression textuelle, avec un contenu textuel plus riche.\n2. Dans « Monde des Rêves Étranges : Profanation », vous établirez un lien avec l'esprit de Miryam pour lire directement ses souvenirs, témoignant ainsi : la jeune Miryam traversant progressivement les souffrances de Lémuria, perdue dans la foi, luttant dans la foi, et finissant par devenir le sauveur et le destructeur...\n3. Pendant l'événement, « Monde des Rêves Étranges : Profanation » sera ouvert gratuitement. De nouveaux événements seront lancés tous les 2 jours, après avoir terminé « Monde des Rêves Étranges : Profanation », vous pourrez obtenir des récompenses telles que le Cœur d'argent, la roue du destin SR limitée à l'événement « L'Appel du Fond Marin » dans les récompenses de succès, ces récompenses de succès ne seront disponibles que pendant l'événement, et ne pourront pas être complétées ou obtenues après la fin de l'événement.\n4. Après la fin de l'événement, la progression de l'enquête de « Monde des Rêves Étranges : Profanation » sera conservée. Si « Monde des Rêves Étranges : Profanation » n'a pas été déverrouillé pendant l'événement, vous pourrez toujours déverrouiller en consommant « Point de départ réel » × 7 après la fin de l'événement.\n5. Que ce soit pendant ou après l'événement, après avoir terminé « Monde des Rêves Étranges : Profanation », vous pourrez obtenir « Décret Clé : Fête de la Mer ».\n\n\n\n"
  },
  Activity_52040_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_53727_ActivityName = {
    Text = "Jour de rentrée des classes"
  },
  Activity_53727_ActivityTips = {
    Text = "<Title:Event Introduction>\n· Les tâches de \"Journée de Retour à l'École\" sont divisées en 4 groupes, débloquant le 1er, 2e, 3e et 4e jour de l'événement.\n· Les Gardiens peuvent obtenir une \"Invitation de Retour à l'École\" en complétant les tâches de \"Journée de Retour à l'École\".\n· Utiliser l'\"Invitation de Retour à l'École\" permet aux Gardiens d'échanger contre des récompenses généreuses dans la \"Boutique de Retour à l'École\""
  },
  Activity_53728_ActivityName = {
    Text = "Aide pour le chemin du pèlerin"
  },
  Activity_53728_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n Pendant l'événement « Aidez au nouveau départ », les Gardiens du secret recevront des récompenses doublées en Billets Rose Dorée et en matériaux après avoir terminé « Préparation et affinage », « Résidu trouble », « Résidu des Abysses », « Résidu organique », « Résidu dimensionnel », « Essaim chaotique », « Ruines de Ponape », « Repaire des vers » et « Gorge de Schwarzschild ». Un total de 6 récompenses doublées peut être obtenu chaque jour.\nLes chances de récompenses doublées non utilisées dans la journée seront réinitialisées à 9h00 (GMT+8) le lendemain. Gardiens du secret, n'oubliez pas de les utiliser à temps !"
  },
  Activity_53729_ActivityName = {
    Text = "Inscription de rentrée des classes"
  },
  Activity_53729_ActivityTips = {
    Text = "<Title:Event Overview>\n· Les Gardiens peuvent réclamer la récompense de connexion quotidienne dans \"Retour au Rapport Scolaire\" après s'être connectés chaque jour.\n· Les récompenses seront débloquées séquentiellement en fonction des connexions cumulatives des Gardiens, et les récompenses de connexion quotidienne seront rafraîchies à 9:00 AM (GMT+8)."
  },
  Activity_53829_ActivityName = {
    Text = "Avec le livre de la rose"
  },
  Activity_53829_ActivityPlot = {
    Text = "De somptueux diamants dorés, des perles éblouissantes...\nD'innombrables ornements extravagants lui donnaient l'illusion d'être une impératrice.\nÀ présent, elle est déterminée à préserver cette illusion pour toujours."
  },
  Activity_53829_ActivityStageEndContent = {
    Text = "L'événement est terminé. Actuellement, seule la « Célébration Dorée et Rouge » est disponible."
  },
  Activity_53829_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, le gardien pourra collecter la monnaie de l'événement « Éventail de plumes d'Invocation » via les modes temporaires « Souvenirs de la rose » et « Récompenses de succès ». L'« Éventail de plumes d'Invocation » peut être échangé contre de riches récompenses lors de la « Célébration Dorée et Rubis », y compris la roue SR limitée de l'événement « Un Million de Regards Aimants », « Cœur Immaculé », « Cœur de Lumens », « Éclats de Pierre Sage », « Cristal de Mimesis », etc. \n2. Pendant l'événement, accomplir les missions des « Récompenses de succès » permettra d'obtenir l'avatar limité de l'événement « Au nom de la Clé d'Argent : Sorel », la roue SR limitée de l'événement « Un Million de Regards Aimants », Cœur d'argent et une grande quantité de monnaie de l'événement « Éventail de plumes d'Invocation ». \n3. Pendant l'événement, l'« Enregistrement de la task force : Éloge de la Rose » sera ouvert gratuitement. \n\n<Title:Durée de l'événement>\n1. Du 1er juillet à 9h00 au 15 juillet à 9h00 (GMT+8), tous les contenus de l'événement sont accessibles. \n2. Du 15 juillet à 9h00 au 22 juillet à 9h00 (GMT+8), seuls la « Célébration Dorée et Rubis » et les « Récompenses de succès » seront maintenus, tous les autres contenus seront terminés et non accessibles. \n\n<Title: Souvenirs de la rose>\n1. Les « Souvenirs de la rose » comprennent 9 niveaux, un niveau sera automatiquement ouvert chaque jour. \n2. Chaque défi consommera « Ménophine » × 120. En défiant différents niveaux, en plus d'obtenir différents matériaux, vous recevrez également la monnaie de l'événement « Éventail de plumes d'Invocation ». \n3. Les niveaux de cet événement sont des niveaux de matériaux de combat direct, et peuvent être reproduits après avoir été complétés ! Chaque « reproduction » consomme « Ménophine » × 120. \n4. Veuillez noter : lors de l'utilisation de la fonction « reproduction », le taux de synchronisation ne peut pas être obtenu. \n\n<Title: Bonus d'éventail>\n1. Si le gardien possède un Éveilleur spécifique ou une roue (aucun besoin d'être en formation), cela permettra d'obtenir un bonus de chute supplémentaire sur l'« Éventail de plumes d'Invocation » dans les récompenses de niveau « Souvenirs de la rose » (y compris la reproduction), les bonus spécifiques sont les suivants : \n· Éveilleur « Sorel » : Dégagement 0/1/2/3 et plus, bonus de 20%/30%/40%/50% \n· Roue SSR « Au nom de la Rose » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50% \n· Roue SR « Un Million de Regards Aimants » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50% \n2. Les « bonus d'éventail » de différents Éveilleurs ou roues seront cumulés. \n\n<Title: Enregistrement de la task force>\n1. Pendant l'événement, les gardiens ayant déjà débloqué « Enregistrement de la task force : Éloge de la Rose » recevront une compensation de « Éventail de plumes d'Invocation » × 600 en le débloquant à nouveau. \n2. Dans l'« Enregistrement de la task force : Éloge de la Rose », le gardien utilisera une escouade spéciale comprenant le personnage prédéfini « Sorel » pour relever le défi."
  },
  Activity_53829_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_54375_ActivityName = {
    Text = "Éloge de la Rose"
  },
  Activity_54375_ActivityPlot = {
    Text = "Mesdames et messieurs,\nLa douce nuit a commencé, alors préparez vos boissons raffinées.\nC'est une longue histoire ; racontons–la lentement..."
  },
  Activity_54375_ActivityTips = {
    Text = "<Title:Conditions de participation>\n·Complétez l'« Opération d'Investigation » 2-9 (Normal) pour participer.\n<Title:Événement d'Investigation>\n·Pendant la période de l'événement, un nouvel événement d'investigation de « Tribute Rosé » sera lancé quotidiennement. Les Gardiens peuvent débloquer et enquêter sans consommer d'inventaire. Après avoir complété l'événement d'investigation, des récompenses telles que le Noyau Pur, le Badge d'Investigation et l'Expérience du Gardien peuvent être obtenues.\n·Après la fin de l'événement, les progrès d'investigation de « Tribute Rosé » seront conservés, et les Gardiens peuvent consommer des D-gemmes dans le Registre Spécial pour débloquer les enquêtes non complétées. Compléter les événements d'investigation non complétés pendant la période de l'événement donnera également des récompenses cohérentes avec celles de l'événement.<Title:Récompenses Temporaire>\n·Des récompenses temporaires seront disponibles pendant l'événement. Les Gardiens peuvent obtenir le Noyau Pur, la Pierre Philosophale et des récompenses en Argent après avoir terminé le mode « Tribute Rosé » (Normal) et complété les événements d'investigation de « Tribute Rosé » ! Les récompenses temporaires ne seront disponibles que pendant la période de l'événement et ne peuvent pas être complétées ou réclamées après la fin de l'événement."
  },
  Activity_54402_ActivityName = {
    Text = "Patient dissociatif : chaos"
  },
  Activity_54402_ActivityTips = {
    Text = "<Title:Règles de l'activité>\n·Pendant l'événement \"Patient Éclaté: Chaos\", les Gardiens peuvent utiliser des équipes prédéfinies par le système contenant \"24\" pour expérimenter des niveaux désignés un nombre illimité de fois.\n·Lors de la réalisation des niveaux d'événement, des ajustements au Réveiller dans la composition de l'équipe ne peuvent pas être effectués.\n<Title:Récompenses de l'activité>\n·Après avoir réussi un défi de niveau pour la première fois, vous pouvez réclamer des récompenses d'essai depuis l'interface de l'événement."
  },
  Activity_54403_ActivityName = {
    Text = "Clé de la porte"
  },
  Activity_54403_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Lors de l'événement \"Clé de la Porte\", les Gardiens peuvent utiliser des équipes prédéfinies par le système qui incluent Tawil pour vivre des niveaux désignés à l'infini.\n·Lors de l'expérience des niveaux de l'événement, des ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir réussi à terminer le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_54404_ActivityName = {
    Text = "Bishop de baumes"
  },
  Activity_54404_ActivityTips = {
    Text = "<Title:Règles de l'activité>\n·Pendant l'événement \"Évêque Bienveillant\", les Gardiens peuvent utiliser des équipes prédéfinies par le système contenant Salvador pour expérimenter des niveaux désignés un nombre illimité de fois.\n·Lors de la réalisation des niveaux d'événement, des ajustements au Réveiller dans la composition de l'équipe ne peuvent pas être effectués.\n<Title:Récompenses de l'activité>\n·Après avoir réussi un défi de niveau pour la première fois, vous pouvez réclamer des récompenses d'essai depuis l'interface de l'événement."
  },
  Activity_54405_ActivityName = {
    Text = "Patient dissociatif : ultra"
  },
  Activity_54405_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Lors de l'événement \"Patient Divisé : Ultra\", les Gardiens peuvent utiliser des équipes prédéfinies par le système comprenant \"24\" pour vivre des niveaux désignés à l'infini.\n·Lors de l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir terminé avec succès le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_54406_ActivityName = {
    Text = "Apôtre de la mer"
  },
  Activity_54406_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n· Pendant l'événement \"Apostle de la Mer\", les Gardiens peuvent utiliser des équipes préétablies par le système qui incluent Miryam pour vivre les niveaux désignés indéfiniment.\n· Lors de l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n· Après avoir réussi à compléter le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_54407_ActivityName = {
    Text = "Interprète éternel"
  },
  Activity_54407_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Lors de l'événement \"Interprète Éternel\", les Gardiens peuvent utiliser des équipes prédéfinies par le système qui incluent Hameln pour vivre des niveaux désignés à l'infini.\n·Lors de l'expérience des niveaux de l'événement, des ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir réussi à terminer le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_54408_ActivityName = {
    Text = "Faucheur d'âme"
  },
  Activity_54408_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Pendant l'événement \"Collecteur d'Âmes\", les Gardiens peuvent utiliser des équipes prédéfinies par le système comprenant le Hilote : Catena pour vivre des niveaux désignés à l'infini.\n·Lors de l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir réussi le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_54409_ActivityName = {
    Text = "Patient dissociatif : aequor"
  },
  Activity_54409_ActivityTips = {
    Text = "<Title:Règles de l'activité>\n·Pendant l'événement \"Patient Éclaté: Aequor\", les Gardiens peuvent utiliser des équipes prédéfinies par le système contenant \"24\" pour expérimenter des niveaux désignés un nombre illimité de fois.\n·Lors de la réalisation des niveaux d'événement, des ajustements au Réveiller dans la composition de l'équipe ne peuvent pas être effectués.\n<Title:Récompenses de l'activité>\n·Après avoir réussi un défi de niveau pour la première fois, vous pouvez réclamer des récompenses d'essai depuis l'interface de l'événement."
  },
  Activity_54410_ActivityName = {
    Text = "Patient dissociatif : caro"
  },
  Activity_54410_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Lors de l'événement \"Patient Divisé : Caro\", les Gardiens peuvent utiliser des équipes prédéfinies par le système comprenant \"24\" pour vivre des niveaux désignés à l'infini.\n·Lors de l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir terminé avec succès le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_54411_ActivityName = {
    Text = "Cerveau corrompu"
  },
  Activity_54411_ActivityTips = {
    Text = "<Title:Règles de l'événement>\n· Pendant l'événement « Cerveau Corrompu », le gardien peut utiliser l'équipe prédéfinie incluant « Fusion · Dore », pour tenter illimités de fois le niveau désigné.\n· Lors de l'expérience du niveau d'événement, il est impossible d'ajuster l'éveil dans l'équipe.\n<Title:Récompenses de l'événement>\n· Après avoir accompli pour la première fois le défi du niveau, il est possible de recevoir la récompense d'essai sur l'interface de l'événement."
  },
  Activity_54521_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_54521_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_54522_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_54522_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_54523_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_54523_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_54524_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_54524_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_54525_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_54525_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_54526_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_54526_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_54527_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_54527_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_54596_ActivityName = {
    Text = "Cadeau de connaissance"
  },
  Activity_54596_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Après avoir terminé les tâches désignées de l'événement, le Gardien peut réclamer des récompenses généreuses telles que « Paradis primordial », « Livre de rotation », « Vue Prototype », « Modèle en boucle », « Cœur de Retour d'Âme », « Cœur de Réinitialisation du Destin », ainsi que des corps d'éveil et des Roues du Destin exclusifs du « Oubli », et des corps d'éveil et des Roues du Destin exclusifs du « Chapitre des Étoiles », et d'autres récompenses exclusives comme le cadre de profil limité de l'événement « Rectangle Argenté » et l'accélération de l'expérience du Gardien des secrets !\n2. Cet événement est ouvert en permanence. Une fois toutes les tâches de l'événement complètes et les récompenses réclamées, l'événement se termine et ne sera plus affiché après 9h00 (GMT+8) le lendemain.\n\n<Title:Hommage Suprême>\n1. En accomplissant les tâches désignées de l'événement, vous pouvez obtenir l'effet « Hommage Suprême », qui accélère l'expérience du Gardien, pouvant atteindre jusqu'à 100 %. Lorsque plusieurs effets « Hommage Suprême » existent en même temps, seul l'effet d'accélération le plus élevé sera pris en compte.\n2. Lorsque vous débloquez ou obtenez un effet « Hommage Suprême » de niveau supérieur, vous recevrez immédiatement une expérience de Gardien supplémentaire, calculée selon le ratio d'accélération et le total actuel de l'expérience de Gardien pouvant être accélérée.\n3. Une fois l'« Hommage Suprême » débloqué, chaque fois que le Gardien obtient de l'expérience, il recevra une expérience supplémentaire correspondant au ratio d'accélération.\n4. Veuillez noter que l'expérience supplémentaire apportée par l'« Hommage Suprême » ne sera pas incluse dans le total de l'expérience de Gardien pouvant être accélérée.\n5. Total actuel de l'expérience de Gardien pouvant être accélérée : {s1}.\n6. Accélération cumulée de l'expérience de Gardien supplémentaire obtenue : {s2} ({s3}%)."
  },
  Activity_55110_ActivityName = {
    Text = "Avant que le printemps ne fane"
  },
  Activity_55110_ActivityPlot = {
    Text = "Le rire des filles résonne dans le jardin avant que le feu ne commence.\nFaisons une pause pour ce beau passé, mon ami.\nÉcoute les histoires du printemps intouché, doucement narrées."
  },
  Activity_55110_ActivityStageEndContent = {
    Text = "L'événement est terminé. Actuellement, seule \"Maison Florale de Colette\" est disponible."
  },
  Activity_55110_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, le gardien du secret peut collecter trois types de « poèmes » via les modes de jeu temporaires « Jardin d'antan », « Baiser de la Muse » et « Récompenses de succès ». Les « poèmes » peuvent être échangés dans « La maison de fleurs de Colette » pour obtenir des récompenses d'objets, y compris la roue SR limitée à l'événement « Fleurs et Poèmes du Passé », « Cœur Immaculé », « Cœur de Lumens », « Éclats de Pierre Sage », « Cristal de Mimesis », etc.\n2. Pendant l'événement, « Enregistrement de la task force : Demeure de la Rose » sera ouvert gratuitement.\n\n<Title:Temps de l'événement>\n1. Du 15 juillet 9h00 au 29 juillet 9h00 (GMT+8), tout le contenu de l'événement est accessible.\n2. Du 29 juillet 9h00 au 5 août 9h00 (GMT+8), seules « La maison de fleurs de Colette » et « Récompenses de succès » seront disponibles, les autres contenus seront terminés et non accessibles.\n\n<Title:Jardin d'antan>\n1. « Jardin d'antan » comprend 5 niveaux, un nouveau niveau sera automatiquement ouvert tous les 2 jours.\n2. Chaque défi consommera « Ménophine » × 120. En cas de succès, vous obtiendrez des devises d'événement « poésie mélancolique », « Poème de Regret » et « Poème joyeux ».\n3. Après avoir terminé un niveau, la fonction de « Reproduire » sera déverrouillée pour ce niveau. Attention : l'utilisation de la fonction « Reproduire » ne permet pas d'obtenir le taux de synchronisation.\n4. Vous pouvez utiliser l'aide de l'alumni et « Résonance : Élégie du jardin » pour vous aider à terminer plus facilement les niveaux.\n5. Deux jours après le déverrouillage d'un niveau, la difficulté de folie de ce niveau sera déverrouillée. Compléter la première victoire de la difficulté de folie vous rapportera de généreuses récompenses de devises d'événement.\n6. Attention : les défis de la difficulté de folie ne consomment pas de Ménophine, ne peuvent pas être reproduits, et après la première victoire, les défis répétés ne rapporteront plus de récompenses de devises d'événement.\n\n<Title:Bonus de poème>\n1. Le gardien du secret possédant un Éveilleur ou une roue spécifique (non requis en combat) peut obtenir un bonus supplémentaire de chute pour les « poésie mélancolique », « Poème de Regret » et « Poème joyeux » dans les récompenses de la mission du niveau « Jardin d'antan » (y compris la reproduction), les bonus sont comme suit :\n· Éveilleur « Horla » : Réveiller 0/1/2/3 et plus, bonus de 20%/30%/40%/50%\n· SSR roue « Dernier Vers » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%\n· SR roue « Fleurs et Poèmes du Passé » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%\n2. Les « bonus de poème » de différents Éveilleurs ou roues seront calculés de manière cumulative.\n3. En particulier, les récompenses de la première victoire de la difficulté de folie ne seront pas affectées par les « bonus de poème ».\n\n<Title:Résonance : Élégie du jardin>\n1. Le gardien du secret peut obtenir « Cœur de cendres » en complétant des succès d'événement. \n2. En dépensant « Cœur de cendres », activez « Résonance : Élégie du jardin », vous pouvez obtenir les bonus suivants :\n(1) Renforce le gardien dans le mode de jeu d'événement « Jardin d'antan », rendant les défis plus faciles.\n(2) Augmente les devises d'événement obtenues après avoir complété les défis « Jardin d'antan ».\n(3) Active le mode de jeu d'événement « Baiser de la Muse ».\n\n<Title:Baiser de la Muse>\n· Après avoir activé la résonance « Tout pousse », obtenez automatiquement 60 « poésie mélancolique » par heure, avec un maximum de 25 heures de stockage.\n· Après avoir activé la résonance « Échanger des poèmes contre des fleurs », « Baiser de la Muse » peut obtenir 60 « Poème de Regret » supplémentaires par heure.\n\n<Title:La maison de fleurs de Colette>\n1. « La maison de fleurs de Colette » comprend trois jardins, les horaires d'ouverture sont les suivants :\n· « Jardin des Iris » : ouvert le 15 juillet à 9h00.\n· « Jardin des Campanules » : ouvert le 17 juillet à 9h00.\n· « Jardin des Roses » : ouvert le 19 juillet à 9h00.\n2. Chaque échange coûtera 1000 « poésie mélancolique » / « Poème de Regret » / « Poème joyeux », et vous obtiendrez au hasard cinq récompenses d'objets du jardin.\n3. Les récompenses d'objets de chaque jardin se divisent en « objets spéciaux » et « objets ordinaires ». Lors de la réinitialisation, la quantité restante des récompenses d'objets spéciaux sera réinitialisée à la limite, les règles spécifiques sont :\n(1) Pour les 2 premières réinitialisations : lorsque les « objets spéciaux » n'ont plus de quantité restante, le gardien peut choisir de réinitialiser, ce qui réinitialisera la quantité restante des « objets spéciaux » et « objets ordinaires » à la limite ; il peut également choisir de continuer à échanger, lorsque les « objets ordinaires » n'ont plus de quantité restante, il devra réinitialiser pour continuer à échanger.\n(2) À partir de la 3ème réinitialisation : lorsque les « objets ordinaires » n'ont plus de quantité restante, la réinitialisation pourra être effectuée, ce qui réinitialisera la quantité restante des « objets ordinaires » à la limite, les « objets spéciaux » ne seront plus réinitialisés.\n4. Après le 5 août à 9h00 (GMT+8), les « poèmes » restants non échangés seront récupérés au taux de 200 unités pour « Billet Rose Dorée × 5000 », veuillez vérifier vos e-mails, gardien.\n\n<Title:Enregistrement de la task force>\n1. Pendant l'événement, « Enregistrement de la task force : Demeure de la Rose » sera ouvert gratuitement. De nouveaux événements seront lancés tous les 2 jours, après avoir terminé « Enregistrement de la task force : Demeure de la Rose », vous pourrez obtenir des récompenses telles que Cœur d'argent, et la roue SR limitée à l'événement « Fleurs et Poèmes du Passé » dans les récompenses de succès, celles-ci ne seront accessibles que pendant l'événement, et ne pourront pas être complétées ou réclamées après la fin de l'événement.\n2. Après la fin de l'événement, la progression de l'enquête de « Enregistrement de la task force : Demeure de la Rose » sera conservée. Si vous n'avez pas déverrouillé « Enregistrement de la task force : Demeure de la Rose » pendant l'événement, vous pourrez toujours déverrouiller en dépensant « Point de départ réel » × 7 après la fin de l'événement.\n3. Que ce soit pendant ou après l'événement, après avoir terminé « Enregistrement de la task force : Demeure de la Rose », vous obtiendrez « Décret Clé : Poème d'offrande du printemps »."
  },
  Activity_55110_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_55457_ActivityName = {
    Text = "Fission Calme"
  },
  Activity_56427_ActivityName = {
    Text = "Berger des Âmes : Réplique"
  },
  Activity_56427_ActivityPlot = {
    Text = "Il a souffert pour vous, porté vos calamités.\nPar sa chair, vous avez été guéris;\nPar sa vie, vous avez été pardonnés."
  },
  Activity_56427_ActivityStageEndContent = {
    Text = "L'événement est terminé. Actuellement, seule la « Vente Caritative du Sanctuaire » est disponible."
  },
  Activity_56427_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, le Gardien du Secret peut collecter la monnaie de l'événement « Billet de vente au profit d'une bonne cause » à travers les modes temporaires « Chemin du Sanctuaire », « Bienveillance des Citoyens » et « Récompenses de succès ». Les « Billets de vente au profit d'une bonne cause » peuvent être échangés contre des produits aléatoires dans la « Salle de vente de l'église », y compris le SR Roue du Destin limité à l'événement « L'homme dans le miroir », Cœur Immaculé, Cœur de Lumens, etc. \n2. Pendant l'événement, « Enregistrement de la task force : La couleur du sang » sera ouvert gratuitement. En complétant les succès de l'événement, vous pourrez également obtenir l'avatar exclusif à l'événement « Au nom de la Clé d'Argent : Salvador » !\n\n<Title:Temps de l'événement>\n1. 26 août 9:00 - 9 septembre 9:00 (GMT+8), tous les contenus de l'événement sont accessibles. \n2. 9 septembre 9:00 - 16 septembre 9:00 (GMT+8), seule la « Salle de vente de l'église » et les « Récompenses de succès » resteront disponibles, tous les autres contenus seront terminés et non accessibles. \n\n<Title:Chemin du Sanctuaire>\n1. « Chemin du Sanctuaire » comprend 5 niveaux, un nouveau niveau s'ouvrant automatiquement tous les 2 jours. \n2. Chaque défi consommera « Ménophine » × 120, et un défi réussi rapportera la monnaie de l'événement « Billet de vente au profit d'une bonne cause ». \n3. Une fois le niveau terminé, la fonction « Reproduire » de ce niveau sera déverrouillée. Veuillez noter : l'utilisation de la fonction « Reproduire » n'accorde pas de taux de synchronisation. \n4. Vous pouvez utiliser l'assistance de l'association d'anciens élèves et la « Résonance : Les carrefours de l'âme » pour vous aider à passer les niveaux plus facilement. \n\n<Title:Bonus de Brillance>\n1. Sous l'influence de « Brillance de l'âme », le Gardien du Secret possédant un Éveilleur ou une Roue du Destin spécifique (sans exigence de déploiement) peut bénéficier d'un bonus de chute supplémentaire sur les « Billets de vente au profit d'une bonne cause » dans les récompenses des missions de « Chemin du Sanctuaire » (y compris Reproduire), les bonus spécifiques sont les suivants : \n· Éveilleur « Salvador » : Dégagement 0/1/2/3 et plus, bonus de 20%/30%/40%/50%. \n· SSR Roue du Destin « Tables de la Loi » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%. \n· SR Roue du Destin « L'homme dans le miroir » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%. \n2. Les « Bonus de Brillance » de différents Éveilleurs ou Roues du Destin sont cumulés. \n3. En particulier, les récompenses de défi de difficulté Folie ne seront pas affectées par le « Bonus de Brillance ». \n\n<Title:Résonance : Les carrefours de l'âme>\n1. Le Gardien du Secret peut obtenir « Cœur de pénitence » en complétant des succès de l'événement. \n2. En consommant « Cœur de pénitence », activer la « Résonance : Les carrefours de l'âme » peut fournir les bonus suivants : \n(1) Renforce le Gardien du Secret dans les modes de l'événement « Chemin du Sanctuaire » et « Enregistrement de la task force : La couleur du sang », rendant les défis plus faciles. \n(2) Améliore le taux de synchronisation obtenu après avoir terminé le défi du « Chemin du Sanctuaire ». \n(3) Active le mode de l'événement « Bienveillance des Citoyens ». \n\n<Title:Bienveillance des Citoyens>\n1. Après avoir activé la résonance « Façon facile », vous obtiendrez automatiquement 60 « Billets de vente au profit d'une bonne cause » chaque heure, avec un maximum de stockage de 25 heures. \n2. Après avoir activé la résonance « Pénitence, Pénitence », vous obtiendrez automatiquement 1800 Billets Rose Dorée supplémentaires chaque heure. \n\n<Title:Salle de vente de l'église>\n1. La « Salle de vente de l'église » comprend trois boutiques, avec les heures d'ouverture suivantes : \n· « La boutique de Mme Grey » : Ouverture le 26 août à 9 heures. \n· « La vente miraculeuse de Big John » : Ouverture le 29 août à 9 heures. \n· « Vente spéciale de Smith » : Ouverture le 1er septembre à 9 heures. \n2. Chaque échange consommera 1000 « Billets de vente au profit d'une bonne cause », obtenant aléatoirement cinq récompenses parmi les articles de la boutique. \n3. Les récompenses d'articles de chaque boutique sont divisées en « Objet spécial » et « Objet ordinaire », lors de la réinitialisation, il est possible de réinitialiser le nombre restant des récompenses d'objets spéciaux à son maximum, les règles spécifiques sont les suivantes : \n(1) Pour les 2 premières réinitialisations : Lorsque les « Objets spéciaux » n'ont plus de quantité restante, le Gardien du Secret peut choisir de réinitialiser, après réinitialisation, le nombre restant des « Objets spéciaux » et « Objets ordinaires » sera réinitialisé à son maximum ; il peut également choisir de continuer les échanges, lorsque les « Objets ordinaires » n'ont également plus de quantité restante, une réinitialisation sera nécessaire pour continuer les échanges. \n(2) À partir de la 3ème réinitialisation : La réinitialisation ne peut être effectuée que lorsque les « Objets ordinaires » n'ont plus de quantité restante, la réinitialisation réinitialisera le nombre restant des « Objets ordinaires » à son maximum, les « Objets spéciaux » ne seront plus réinitialisés. \n4. Après 9h00 le 16 septembre (GMT+8), les « Billets de vente au profit d'une bonne cause » restants non échangés seront récupérés au taux de 200 pour 5000 Billets Rose Dorée, veuillez vérifier vos e-mails. \n\n<Title:Enregistrement de la task force>\n1. Pendant l'événement, « Enregistrement de la task force : La couleur du sang » sera ouvert gratuitement. \n2. Après la fin de l'événement, la progression de l'enquête de « Enregistrement de la task force : La couleur du sang » sera conservée, si « Enregistrement de la task force : La couleur du sang » n'a pas été déverrouillé pendant l'événement, il sera toujours possible de le déverrouiller après l'événement en consommant « Point de départ réel » × 7. \n3. Que ce soit pendant l'événement ou non, après avoir terminé « Enregistrement de la task force : La couleur du sang », vous pouvez obtenir « Décret Clé : Miracle descendu ». \n\n<Title:Compensation de réédition>\n1. Les Gardiens du Secret ayant déjà déverrouillé « Enregistrement de la task force : La couleur du sang » recevront une compensation de « Billets de vente au profit d'une bonne cause » × 700 lors du déverrouillage lors de cet événement de réédition. \n2. Les Gardiens du Secret ayant déjà obtenu l'avatar exclusif à l'événement « Au nom de la Clé d'Argent : Salvador » convertiront automatiquement tout nouvel obtention en « Billets de vente au profit d'une bonne cause » × 2000. \n3. Les Gardiens du Secret ayant déjà obtenu le matériel d'activation de la résonance « Cœur de pénitence », chaque obtention supplémentaire de « Cœur de pénitence » sera automatiquement convertie en « Billets Rose Dorée » × 5000. \n"
  },
  Activity_56427_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_56428_ActivityName = {
    Text = "Sacrifice Abysse : Rejouer"
  },
  Activity_56428_ActivityPlot = {
    Text = "Sur le reflet de l'océan profond, le rêve de son Roi se dissipe, et le Royaume Divin se décompose.\nElle émerge de rêves anciens, foulant les ruines d'un avenir en effondrement.\nElle interroge les Abysses en spirale, mais les Abysses en spirale restent silencieuses.\nElle offre des sacrifices aux Abysses en spirale, pour n'entendre que son propre écho."
  },
  Activity_56428_ActivityStageEndContent = {
    Text = "Événement terminé, participation actuelle uniquement à «Réponse de l'abîme»"
  },
  Activity_56428_ActivityTips = {
    Text = "<Title:Aperçu de l'événement>\n1. Pendant l'événement, les Gardiens du secret peuvent collecter la monnaie d'événement via les modes à durée limitée « Avènement du Royaume Divin », « Décret du Roi » et « Récompenses de succès ». La monnaie d'événement peut être utilisée dans « Réponse Abyssale » pour obtenir des récompenses d'objets, y compris la Roue du Destin SR exclusive à l'événement « Appel des Profondeurs », la pierre philosophale, le Cœur Immaculé et le Noyau de Lumière.\n2. Pendant l'événement, « Monde des Rêves Étranges : Desecra » sera accessible gratuitement. Compléter les succès de l'événement vous permettra d'obtenir l'avatar exclusif « Au nom de la Clé d'Argent : Miryam » !\n\n<Title:Durée de l'événement>\n1. Du 4 nov., 9:00 au 18 nov., 9:00 (GMT+8), tout le contenu de l'événement est accessible.\n2. Du 18 nov., 9:00 au 25 nov., 9:00 (GMT+8), seules « Réponse Abyssale » et « Récompenses de succès » resteront disponibles ; le reste du contenu prend fin.\n\n<Title:Avènement du Royaume Divin>\n1. « Avènement du Royaume Divin » comprend 5 étapes, une se débloquant tous les 2 jours.\n2. Chaque défi consomme 120 Ménophine ; la réussite rapporte de la monnaie d'événement.\n3. Terminer une étape débloque la fonction « Reconstitution » pour cette étape. Remarque : utiliser « Reconstitution » ne rapporte pas de Taux de synchronisation.\n4. Utilisez l'aide des Anciens Élèves et « Résonance : Baptême des abysses » pour terminer les étapes plus facilement.\n\n<Title:Bonifications de Sacrifice>\n1. Posséder certains Corps éveillés ou Roues du Destin (pas besoin de les déployer) accorde des drops supplémentaires de « Larmes du Sacrificateur », « Sang du Sacrificateur » et « Médula Sacrificielle » dans les étapes « Avènement du Royaume Divin » (y compris les reconstitutions). Les bonus sont :\nCorps éveillé « Miryam » : Dégagement 0/1/2/3+, bonus 20%/30%/40%/50%\nRoue du Destin SSR « Puissance Dévouée » : Niveau d'empilement 0/1/2/3+, bonus 20%/30%/40%/50%\nRoue du Destin SR « Appel des Profondeurs » : Niveau d'empilement 0/1/2/3+, bonus 20%/30%/40%/50%\n2. Les bonus de différents Corps éveillés ou Roues du Destin se cumulent.\n3. Les récompenses de première complétion en difficulté Fou ne sont pas affectées par les Bonifications de Sacrifice.\n\n<Title:Résonance : Baptême des abysses>\n1. Complétez les succès de l'événement pour obtenir « Cœur de Dévouement ».\n2. Utilisez « Cœur de Dévouement » pour activer « Résonance : Baptême des abysses », qui offre :\n(1) Renforcement des Gardiens du secret dans « Avènement du Royaume Divin » pour des défis plus faciles.\n(2) Augmentation de la monnaie d'événement obtenue dans les défis « Avènement du Royaume Divin ».\n(3) Activation du mode événement « Décret du Roi ».\n\n<Title:Décret du Roi>\nAprès avoir activé la Résonance « Épreuve du Sacrifice », recevez automatiquement 60 « Larmes du Sacrificateur » par heure, stockables jusqu'à 25 heures.\n\n<Title:Réponse Abyssale>\n1. « Réponse Abyssale » possède trois autels, ouvrant comme suit :\n« Autel des Larmes » : 4 nov., 9:00 – 25 nov., 9:00.\n« Autel du Sang » : 6 nov., 9:00 – 25 nov., 9:00.\n« Autel des Âmes » : 8 nov., 9:00 – 25 nov., 9:00.\n2. Chaque sacrifice consomme 1000 « Larmes du Sacrificateur »/« Sang »/« Médula », récompensant aléatoirement cinq objets.\n3. Les récompenses sont des « Objet spécial » et des « Objets Normaux ». Les règles de Rétroaction sont :\n(1) 2 premières Rétroactions : Lorsque les « Objet spécial » sont épuisés, les Gardiens du secret peuvent choisir de réinitialiser ou de continuer à sacrifier. Si les « Objets Normaux » sont épuisés, une Rétroaction est nécessaire pour continuer.\n(2) À partir de la 3e Rétroaction : La Rétroaction ne peut être effectuée que lorsque les « Objets Normaux » sont épuisés ; les « Objet spécial » ne seront plus réinitialisés.\n\n<Title:Monde des Rêves Étranges>\n1. Pendant l'événement, « Monde des Rêves Étranges : Desecra » est gratuit.\n2. Après l'événement, la progression de « Monde des Rêves Étranges : Desecra » est conservée. Déblocage possible avec 7 « Point de départ réel » si non fait pendant l'événement.\n3. Terminer « Monde des Rêves Étranges : Desecra » à tout moment récompense « Décret Clé : Fête de la Mer ».\n\n<Title:Compensation de réédition>\n1. Les Gardiens du secret ayant précédemment débloqué « Monde des Rêves Étranges : Desecra » recevront 700 « Larmes du Sacrificateur » en compensation pour la réactivation.\n2. Les Gardiens du secret possédant déjà l'avatar événement « Au nom de la Clé d'Argent : Miryam » recevront 2000 « Larmes du Sacrificateur » s'ils l'obtiennent à nouveau.\n3. Les « Cœur de Dévouement » excédentaires des événements précédents seront convertis en 5000 « Billet Rose Dorée » chacun."
  },
  Activity_56428_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_56429_ActivityName = {
    Text = "À mi-chemin"
  },
  Activity_56429_ActivityPlot = {
    Text = "Elle garde toujours une longueur d'avance sur le monde.\nUn pas, deux pas — ses empreintes éclairent le chemin pour tous.\nMais les sots oublient trop facilement :\nLa distance entre le génie et la folie\nn'est qu'un demi–pas."
  },
  Activity_56429_ActivityStageEndContent = {
    Text = "L'événement est Terminé. Actuellement, seuls les «Enseignements du Maître» sont disponibles."
  },
  Activity_56429_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\nPendant l'événement, les Gardiens du secret peuvent collecter la monnaie d'événement « Pièces de poupée » via le mode temporaire « Porte du Néant » et les récompenses de réalisations. Les « Pièces de poupée » peuvent être échangées contre des récompenses dans « Enseignements du Maître », incluant la Roue du Destin SR exclusive à l'événement « Bâton du Berger », des Cœur de Lumens, des Cœur Immaculé, des Éclats de Pierre Sage, des Cristal de Mimesis, etc.\n\n<Title:Porte du Néant>\n1. « Porte du Néant » contient 9 étapes de matériaux à combattre directement sans exploration, 1 étape s'ouvre chaque jour.\n2. Chaque défi consomme 120 points d'endorphine, la réussite du défi permet d'obtenir des matériaux d'entraînement et la monnaie de l'événement.\n3. Après avoir terminé une étape, la fonction « Répétition » de cette étape sera débloquée. Veuillez noter : la fonction « Répétition » ne permet pas d'obtenir le taux de synchronisation.\n4. Vous pouvez utiliser l'aide des Alumni pour faciliter le passage de l'étape.\n\n<Title:Bonus Pièces de poupée>\n1. Lorsque le Gardien possède un Corps éveillé ou une Roue du Destin spécifique (pas nécessairement en ligne), il peut obtenir un bonus supplémentaire sur les « Pièces de poupée » dans les récompenses des étapes de « Porte du Néant » (y compris la répétition), les bonus spécifiques sont les suivants :\nCorps éveillé « Doll : Dissoute » : Dégagement 0/1/2/3 ou supérieur, bonus 20%/30%/40%/50%\nRoue du Destin SSR « Marionnette du Néant » : Superposition 0/1/2/3 ou supérieur, bonus 20%/30%/40%/50%\nRoue du Destin SR « Bâton du Berger » : Superposition 0/1/2/3 ou supérieur, bonus 20%/30%/40%/50%\n2. Les bonus « Bonus Pièces de poupée » de différents Corps éveillés ou Roues du Destin s'additionnent.\n3. En particulier, les récompenses de premier passage en difficulté Fou ne sont pas affectées par les bonus ci-dessus.\n\n<Title:Enseignements du Maître>\n1. Chaque « Échange de pièces » consomme 750 « Pièces de poupée », permettant d'obtenir aléatoirement 5 objets parmi les récompenses de « Enseignements du Maître ».\n2. Les récompenses de « Enseignements du Maître » sont divisées en deux catégories : « Objet spécial » et « Objet ordinaire ». Lors de la réinitialisation, la quantité restante des « Objet spécial » peut être réinitialisée à la limite supérieure, les règles spécifiques sont les suivantes :\n(1) Premières 5 réinitialisations : lorsque les « Objet spécial » sont épuisés, le Gardien peut choisir de réinitialiser, ce qui réinitialisera la quantité restante des « Objet spécial » et des « Objet ordinaire » à la limite supérieure ; il peut aussi choisir de continuer l'échange, lorsque les « Objet ordinaire » sont également épuisés, il faudra réinitialiser pour continuer l'échange.\n(2) À partir de la 6e réinitialisation : la réinitialisation n'est possible que lorsque les « Objet ordinaire » sont épuisés, la réinitialisation réinitialisera la quantité restante des « Objet ordinaire » à la limite supérieure, les « Objet spécial » ne seront plus réinitialisés.\n\n<Title:Durée de l'événement>\n1. Du 17 février 9h00 au 3 mars 9h00 (GMT+8), toutes les contenus mentionnés dans la présentation de l'événement sont disponibles.\n2. Du 3 mars 9h00 au 10 mars 9h00 (GMT+8), seuls « Enseignements du Maître » et les récompenses de réalisations restent disponibles, les autres contenus sont terminés et ne sont plus accessibles.\n3. Après le 10 mars 9h00 (GMT+8), les « Pièces de poupée » restantes non échangées seront récupérées au taux de « Billet Rose Dorée *40 » par unité, veuillez vérifier vos messages."
  },
  Activity_56429_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_56430_ActivityName = {
    Text = "Symphonie invisible"
  },
  Activity_56430_ActivityPlot = {
    Text = "La symphonie est un art de tissage, où les trajectoires des instruments se croisent pour former une carte complexe.\nDans son réseau, chaque note a son rôle.\nÉcoutez, une symphonie exceptionnelle commence"
  },
  Activity_56430_ActivityStageEndContent = {
    Text = "Événement terminé, participation actuelle uniquement à «Palais du sommeil»"
  },
  Activity_56430_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, le gardien du secret peut collecter la monnaie de l'événement « Chant héroïque » à travers les modes de jeu à durée limitée « Son tonnant » et « Récompenses de succès ». « Chant héroïque » peut être échangé contre de généreuses récompenses dans le « Palais du Sommeil », y compris la roue SR limitée à l'événement « Présentation qui ne s'arrête jamais », « Cœur Immaculé », « Cœur de Lumens », « Éclats de Pierre Sage », « Cristal de Mimesis », etc. \n2. Pendant l'événement, en complétant les missions de « Récompenses de succès », vous pouvez obtenir l'avatar limité à l'événement « Au nom de la Clé d'Argent : Hamelin », la roue SR limitée à l'événement « Présentation qui ne s'arrête jamais », Cœur d'argent et une grande quantité de monnaie de l'événement « Chant héroïque ».\n\n<Title:Temps de l'événement>\n1. Du 9 septembre à 9h00 au 23 septembre à 9h00 (GMT+8), tous les contenus de l'événement sont disponibles. \n2. Du 23 septembre à 9h00 au 30 septembre à 9h00 (GMT+8), seuls le « Palais du Sommeil » et les « Récompenses de succès » seront maintenus, les autres contenus seront terminés et ne seront plus disponibles. \n\n<Title: Son tonnant>\n1. « Son tonnant » comprend 9 niveaux, un niveau s'ouvre automatiquement chaque jour. \n2. Chaque défi consommera « Ménophine » × 120. En défiant différents niveaux, en plus d'obtenir différents matériaux, vous obtiendrez également la monnaie de l'événement « Chant héroïque ». \n3. Les niveaux de cet événement sont des niveaux de combat direct, et peuvent être reproduits après avoir été terminés ! Chaque « reproduction » consommera « Ménophine » × 120. \n4. Veuillez noter : en utilisant la fonction « reproduction », le taux de synchronisation ne pourra pas être obtenu. \n\n<Title: Bonus de chapitre>\n1. Le gardien du secret possédant des éveilleurs ou des roues spécifiques (sans exigence d'être en équipe) peut faire en sorte que la monnaie « Chant héroïque » dans les récompenses des missions de « Son tonnant » obtienne un bonus de chute supplémentaire (y compris la reproduction), les bonus spécifiques sont les suivants : \n· Éveilleur « Hamelin » : Dégagement 0/1/2/3 et plus, bonus de 20%/30%/40%/50% \n· Roue SSR « Requiem Éternel » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50% \n· Roue SR « Présentation qui ne s'arrête jamais » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50% \n2. Les « Bonus de chapitre » des différents éveilleurs ou roues seront calculés de manière cumulée. \n3. En particulier, les récompenses des défis de première passe en difficulté Folie ne seront pas affectées par les « Bonus de chapitre ». \n\n<Title: Palais du Sommeil>\n1. Le « Palais du Sommeil » sera ouvert uniquement du 9 septembre à 9h00 au 30 septembre à 9h00 (GMT+8). \n2. Après le 30 septembre à 9h00 (GMT+8), les « Chant héroïque » non échangés restants seront récupérés au taux de « Billet Rose Dorée » × 40 par unité échangée. Veuillez vérifier votre courrier, gardien du secret."
  },
  Activity_56430_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_56431_ActivityName = {
    Text = "Les étoiles sont alignées"
  },
  Activity_56431_ActivityPlot = {
    Text = "L'heure de l'Alignement stellaire approche, le mouvement dans sa poitrine résonne comme un tambour.\nLes sombres cauchemars qui l'ont tourmentée pendant des années culminent dans la fin larmoyante d'innombrables fidèles.\nDe Ses@1 ténèbres@2, le grand@3 fait son Avènement dans le monde."
  },
  Activity_56431_ActivityStageEndContent = {
    Text = "L'événement est terminé. Actuellement, seule l'« Incubation du Saint Embryon » est disponible."
  },
  Activity_56431_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, le gardien du secret peut collecter trois types d'« embryons » via les modes de jeu à durée limitée « Uterus Sombre » et « Récompenses de succès ». Les « embryons » peuvent être échangés contre des récompenses d'objets dans « Éclosion de l'Embryon Divin », y compris la roue du destin SR limitée à l'événement « Sommeil sous le Glacier », « Cœur Immaculé », « Cœur de Lumens », « Éclats de Pierre Sage », « Cristal de Mimesis », etc. \n2. Pendant l'événement, accomplir des missions de « Récompenses de succès » permet d'obtenir l'avatar limité à l'événement « Au nom de la Clé d'Argent : Goliath », la roue du destin SR limitée à l'événement « Sommeil sous le Glacier » et une grande quantité d'« embryons ». \n\n<Title: Temps de l'événement>\n1. Du 29 juillet 9:00 au 12 août 9:00 (GMT+8), tous les contenus de l'événement sont accessibles. \n2. Du 12 août 9:00 au 19 août 9:00 (GMT+8), seuls « Éclosion de l'Embryon Divin » et « Récompenses de succès » restent disponibles, tous les autres contenus sont terminés et ne peuvent plus être participés. \n\n<Title: Uterus Sombre>\n1. « Uterus Sombre » comprend 7 niveaux, un niveau s'ouvrira automatiquement chaque jour. \n2. Chaque défi consommera « Ménophine » × 120, et un défi réussi rapportera de la monnaie d'événement « Embryon ignorant », « Embryon sans désir » et « Graine insatiable ». \n3. Une fois un niveau terminé, la fonction « Reproduire » de ce niveau sera déverrouillée. Veuillez noter : l'utilisation de la fonction « Reproduire » ne permettra pas d'obtenir le taux de synchronisation. \n4. Vous pouvez utiliser l'aide d'anciens élèves pour vous aider à terminer les niveaux plus facilement. \n5. Après avoir terminé un niveau à n'importe quelle difficulté, le mode de difficulté Folie de ce niveau sera déverrouillé. Compléter le premier défi en mode Folie rapportera de généreuses récompenses de monnaie d'événement. \n6. Veuillez noter : les défis en mode Folie ne consomment pas de Ménophine, ne peuvent pas être reproduits, et après le premier défi, les défis répétés ne rapporteront plus de monnaie d'événement. \n\n<Title: Bonus d'Embryon>\n1. Si le gardien possède un Éveilleur ou une roue du destin spécifique (pas besoin d'être en équipe), cela permettra d'augmenter le bonus de chute des « embryons » « Embryon ignorant », « Embryon sans désir » et « Graine insatiable » dans les récompenses des missions des niveaux « Uterus Sombre » (y compris la reproduction), les bonus spécifiques sont les suivants : \n· Éveilleur « Murphy » : Dégagement 0/1/2/3 et plus, bonus de 20%/30%/40%/50% \n· Roue du destin SSR « Naissance Cachée » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50% \n· Roue du destin SR « Sommeil sous le Glacier » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50% \n2. Les « bonus d'embryon » de différents Éveilleurs ou roues du destin seront calculés de manière cumulative. \n3. De manière spéciale, les récompenses du premier défi en mode Folie ne seront pas affectées par les « bonus d'embryon ». \n\n<Title: Éclosion de l'Embryon Divin>\n1. « Éclosion de l'Embryon Divin » est ouvert uniquement du 29 juillet 9:00 au 19 août 9:00 (GMT+8). \n2. Après le 19 août 9:00 (GMT+8), les « embryons » non échangés restants seront récupérés au taux de « Billet Rose Dorée » × 40 par unité, veuillez vérifier vos e-mails, gardien du secret."
  },
  Activity_56431_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_56432_ActivityName = {
    Text = "Jusqu'à ce que la neige fonde"
  },
  Activity_56432_ActivityPlot = {
    Text = ": La neige d'Elworth ne fond jamais, tout comme sa haine. \nLorsque le futur et le passé s'entrelacent, le guerrier brandira sa lame, lançant une charge de vengeance contre le destin. \nQuand elle fait face aux vagues noires, tu es son étendard"
  },
  Activity_56432_ActivityStageEndContent = {
    Text = "Événement terminé, participation actuelle uniquement à «Gueule de la montagne»"
  },
  Activity_56432_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, le gardien du secret peut collecter trois types de « bourgeons » via les modes temporaires « Ambition de la Bête » et « Récompenses de succès ». Les « bourgeons » peuvent être échangés dans « Gueule de la montagne » pour obtenir des récompenses d'objets, y compris la roue SR limitée de l'événement « Jusqu'à la fusion de la montagne neigeuse », « Cœur Immaculé », « Cœur de Lumens », « Éclats de Pierre Sage », « Cristal de Mimesis », etc. \n2. Pendant l'événement, « Enregistrement de la task force : Le Retour de Elvworth » sera ouvert gratuitement. \n\n<Title:Temps de l'événement>\n1. Du 7 octobre 9:00 au 21 octobre 9:00 (GMT+8), tous les contenus de l'événement seront accessibles. \n2. Du 21 octobre 9:00 au 28 octobre 9:00 (GMT+8), seuls « Gueule de la montagne » et « Récompenses de succès » resteront disponibles, les autres contenus seront terminés et ne pourront plus être participés. \n\n<Title: Ambition de la Bête>\n1. « Ambition de la Bête » comprend 5 niveaux, un sera automatiquement ouvert tous les 2 jours. \n2. Chaque défi consommera « Ménophine » × 120, réussir le défi permettra de gagner des monnaies d'événement « Bouton de fleur gelé », « Bouton de fleur d'argent givré » et « Bouton de soleil ». \n3. Après avoir terminé le niveau, la fonction « Reproduire » de ce niveau sera déverrouillée. Veuillez noter : en utilisant la fonction « Reproduire », il n'est pas possible d'obtenir le taux de synchronisation. \n4. Vous pouvez utiliser l'aide de l'association des anciens et « Résonance : Dévorer les montagnes » pour vous aider à terminer les niveaux plus facilement. \n5. Deux jours après le déblocage du niveau, la difficulté de folie de ce niveau sera déverrouillée. Compléter la première réussite de la difficulté de folie vous récompensera avec une généreuse monnaie d'événement. \n6. Veuillez noter : les défis de difficulté de folie ne consomment pas de Ménophine, ne peuvent pas être reproduits, et après la première réussite, les défis répétés ne rapporteront plus de monnaies d'événement. \n\n<Title:Bonus de bourgeons>\n1. Si le gardien du secret possède un Éveilleur ou une roue spécifique (pas besoin d'être dans l'équipe), cela permettra d'obtenir un bonus supplémentaire pour les « Bouton de fleur gelé », « Bouton de fleur d'argent givré » et « Bouton de soleil » dans les récompenses de mission de « Ambition de la Bête » (y compris la reproduction), les bonus spécifiques sont les suivants : \n· Éveilleur « Chaîne de sang · Helot » : Dégagement 0/1/2/3 et plus, bonus 20%/30%/40%/50% \n· SSR roue « Noyade dans le Pourpre » : Superposition 0/1/2/3 et plus, bonus 20%/30%/40%/50% \n· SR roue « Jusqu'à la fusion de la montagne neigeuse » : Superposition 0/1/2/3 et plus, bonus 20%/30%/40%/50% \n2. Les « bonus de bourgeons » de différents Éveilleurs ou roues seront cumulés. \n3. En particulier, les récompenses de défi de première réussite de la difficulté de folie ne seront pas affectées par les « bonus de bourgeons ». \n\n<Title: Résonance : Dévorer les montagnes>\n1. Le gardien du secret peut obtenir « Cœur Vorace » en complétant des succès d'événement. \n2. En dépensant « Cœur Vorace », activer « Résonance : Dévorer les montagnes » permettra au gardien du secret de devenir plus fort dans le mode événementiel « Ambition de la Bête », rendant les défis plus faciles. \n\n<Title: Gueule de la montagne>\n1. « Gueule de la montagne » a trois magasins d'échange, les horaires d'ouverture sont les suivants : \n· « Ambition dévorante » : Ouverture le 7 octobre à 9h. \n· « Esprit de vengeance » : Ouverture le 9 octobre à 9h. \n· « Espoir de régénération » : Ouverture le 11 octobre à 9h. \n2. Chaque échange consommera 1000 « Bouton de fleur gelé »/« Bouton de fleur d'argent givré »/« Bouton de soleil », et vous obtiendrez aléatoirement cinq objets récompenses du magasin d'échange. \n3. Les récompenses d'objets de chaque magasin d'échange sont divisées en « objets spéciaux » et « objets ordinaires », lors de la réinitialisation, il est possible de remettre à zéro le nombre restant des récompenses d'objets spéciaux au maximum, les règles spécifiques sont : \n(1) Pour les 2 premières réinitialisations : lorsque les « objets spéciaux » n'ont plus de quantité restante, le gardien du secret peut choisir de réinitialiser, la réinitialisation remettra à zéro le nombre restant des « objets spéciaux » et « objets ordinaires » au maximum ; il peut aussi choisir de continuer à échanger, lorsque les « objets ordinaires » n'ont plus de quantité restante, il devra réinitialiser pour continuer à échanger. \n(2) À partir de la 3ème réinitialisation : lorsque les « objets ordinaires » n'ont plus de quantité restante, il est possible de réinitialiser, la réinitialisation remettra à zéro le nombre restant des « objets ordinaires » au maximum, les « objets spéciaux » ne seront plus réinitialisés. \n4. Après le 28 octobre à 9h (GMT+8), les « bourgeons » restants non échangés seront récupérés à un taux de 40 « Billet Rose Dorée » par unité échangée, veuillez prêter attention à la réception des e-mails. \n\n<Title: Enregistrement de la task force>\n1. Pendant l'événement, « Enregistrement de la task force : Le Retour de Elvworth » sera ouvert gratuitement. Tous les 2 jours, de nouveaux événements seront lancés. Après avoir terminé « Enregistrement de la task force : Le Retour de Elvworth », vous pourrez obtenir des récompenses telles que Cœur d'argent, la roue SR limitée de l'événement « Jusqu'à la fusion de la montagne neigeuse », les récompenses de succès ne seront accessibles que pendant l'événement, après la fin de l'événement, il ne sera plus possible de les compléter et de les recevoir. \n2. Après la fin de l'événement, la progression de l'enquête de « Enregistrement de la task force : Le Retour de Elvworth » sera conservée. Si vous n'avez pas déverrouillé « Enregistrement de la task force : Le Retour de Elvworth » pendant l'événement, vous pourrez encore dépenser « Point de départ réel » × 7 pour déverrouiller après la fin de l'événement. \n3. Que ce soit pendant ou après l'événement, après avoir terminé « Enregistrement de la task force : Le Retour de Elvworth », vous pourrez obtenir « Décret Clé : La résolution des montagnes »."
  },
  Activity_56432_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_56433_ActivityName = {
    Text = "Manuel du détective"
  },
  Activity_56433_ActivityPlot = {
    Text = "Ces pages renferment les enseignements aiguisés d'un maître détective, forgés au fil d'une vie entière consacrée à la résolution de mystères.\nUn guide conçu pour éveiller l'intuition et affûter l'intellect des enquêteurs en herbe."
  },
  Activity_56433_ActivityStageEndContent = {
    Text = "L'événement est terminé. Actuellement, seul \"Club de Bonne Chance\" est disponible."
  },
  Activity_56433_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, le Gardien peut collecter la monnaie de l'événement « Jetons décisifs » à travers les modes de jeu temporaires « Légende de la nuit lunaire » et « Récompenses de succès ». Les « Jetons décisifs » peuvent être échangés contre de généreuses récompenses dans le « Club de la Chance », y compris la Roue du Destin SR exclusive à l'événement « Roulette du Destin », le Cœur Immaculé, le Cœur de Lumens, les Éclats de Pierre Sage, le Cristal de Mimesis, etc. \n2. Pendant l'événement, accomplir les missions des « Récompenses de succès » permet d'obtenir l'avatar exclusif à l'événement « Au nom de la Clé d'Argent : Ryker », la Roue du Destin SR « Roulette du Destin », le Cœur d'argent et une grande quantité de monnaie de l'événement « Jetons décisifs ». \n3. Pendant l'événement, « Enregistrement de la task force : Bonne chasse ! » sera ouvert gratuitement. \n\n<Title: Temps de l'événement>\n1. Du 12 août à 9h00 au 26 août à 9h00 (GMT+8), tous les contenus de l'événement sont accessibles. \n2. Du 26 août à 9h00 au 2 septembre à 9h00 (GMT+8), seul le « Club de la Chance » et les « Récompenses de succès » resteront, les autres contenus seront terminés et non accessibles. \n\n<Title: Légende de la nuit lunaire>\n1. « Légende de la nuit lunaire » comprend 9 niveaux, un niveau s'ouvrant automatiquement chaque jour. \n2. Chaque défi consommera « Ménophine » × 120. En défiant différents niveaux, en plus d'obtenir différents matériaux, vous obtiendrez la monnaie de l'événement « Jetons décisifs ». \n3. Les niveaux de cet événement sont des niveaux de combat direct, et peuvent être reproduits après avoir été terminés ! Chaque « reproduction » consommera « Ménophine » × 120. \n4. Veuillez noter : lors de l'utilisation de la fonction « reproduction », le taux de synchronisation ne sera pas obtenu. \n\n<Title: Bonus de jetons>\n1. Le Gardien possédant un certain Éveilleur ou une Roue (non requis pour être en ligne) peut faire en sorte que les « Jetons décisifs » des missions de niveau « Légende de la nuit lunaire » reçoivent un bonus de chute supplémentaire (y compris pour la reproduction), les bonus spécifiques sont les suivants : \n· Éveilleur « Ryker » : Dégagement 0/1/2/3 et plus, bonus de 20%/30%/40%/50% \n· Roue SSR « Moment Propice » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50% \n· Roue SR « Roulette du Destin » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50% \n2. Les « Bonus de jetons » des différents Éveilleurs ou Roues seront calculés de manière cumulée. \n3. En particulier, les récompenses de défi de difficulté Folie ne seront pas affectées par les « Bonus de jetons ». \n\n<Title: Club de la Chance>\n1. Le « Club de la Chance » sera ouvert uniquement du 12 août à 9h00 au 2 septembre à 9h00 (GMT+8). \n2. Après le 2 septembre à 9h00 (GMT+8), les « Jetons décisifs » non échangés restants seront récupérés à un taux de 40 « Billet Rose Dorée » par échange, veuillez vérifier vos emails, Gardien. \n\n<Title: Enregistrement de la task force>\n1. Dans « Enregistrement de la task force : Bonne chasse ! », le Gardien utilisera une escouade spéciale comprenant le personnage préétabli « Ryker » pour relever des défis. \n2. Terminer « Enregistrement de la task force : Bonne chasse ! » permettra d'obtenir un nouveau Décret Clé « Décret Clé : Un coup de feu »."
  },
  Activity_56433_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_56434_ActivityName = {
    Text = "Porte des Mille Phénomènes"
  },
  Activity_56434_ActivityPlot = {
    Text = "Personne ne sait depuis combien de temps elle monte silencieusement la garde à la Porte de l'Extrémité.\nElle n'a jamais eu l'intention de se manifester dans un monde tangible, ni de se laisser emporter par un courant spatio–temporel.\nLà, à la Porte, elle demeurait imperturbable—\nJusqu'au moment où ses yeux ont croisé les vôtres."
  },
  Activity_56434_ActivityStageEndContent = {
    Text = "L'événement est Terminé. Actuellement, seul «Écho» est disponible."
  },
  Activity_56434_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, les Gardiens du secret pourront collecter la monnaie d'événement « Pointeur final » via les modes temporaires « Test final » et « Récompenses de succès ». « Pointeur final » pourra être échangé contre des récompenses substantielles dans « Écho », incluant notamment la Roue du Destin SR exclusive à l'événement « Porte de la vérité », Cœur Immaculé, Cœur de Lumens, Éclats de Pierre Sage, Cristal de Mimesis, etc.\n2. Pendant l'événement, en accomplissant les tâches de « Récompenses de succès », vous obtiendrez l'avatar exclusif à l'événement « Au nom de la Clé d'argent : «Tavi» », la Roue du Destin SR exclusive à l'événement « Porte de la vérité », des Cœurs d'argent et une grande quantité de monnaie d'événement « Pointeur final ».\n\n<Title:Durée de l'événement>\n1. Du 18 novembre 9h00 au 2 décembre 9h00 (GMT+8), toutes les activités seront disponibles.\n2. Du 2 décembre 9h00 au 9 décembre 9h00 (GMT+8), seules les sections « Écho » et « Récompenses de succès » resteront accessibles. Les autres contenus seront indisponibles.\n\n<Title:Test final>\n1. « Test final » comprend 9 niveaux, un nouveau niveau s'ouvrant automatiquement chaque jour.\n2. Chaque tentative consommera 120 points de neuropéricine. En affrontant des niveaux différents, vous obtiendrez non seulement des matières premières variées, mais aussi la monnaie d'événement « Pointeur final ».\n3. Les niveaux de cet événement sont des niveaux de ressources en combat direct, pouvant être rejoués après leur réussite ! Chaque « rejouer » consommera 120 points de neuropéricine.\n4. Veuillez noter : en utilisant la fonction « rejouer », vous ne pourrez pas obtenir de taux de synchronisation.\n\n<Title:Bonus de Pointeur final>\n1. Si le Gardien possède un Corps éveillé ou une Roue du Destin spécifique (pas nécessairement déployé), il obtiendra un bonus supplémentaire sur les « Pointeurs finaux » reçus dans les récompenses des missions des niveaux « Test final » (y compris les parties rejouées). Les bonus spécifiques sont les suivants :\nCorps éveillé « «Tavi» » : Dégagement 0/1/2/3 ou supérieur, bonus de 20%/30%/40%/50%\nRoue du Destin SSR « Roue Invisible » : Superposition 0/1/2/3 ou supérieur, bonus de 20%/30%/40%/50%\nRoue du Destin SR « Porte de la vérité » : Superposition 0/1/2/3 ou supérieur, bonus de 20%/30%/40%/50%\n2. Les « Bonus de Pointeur final » provenant de différents Corps éveillés ou Roues du Destin s'additionnent.\n3. À noter particulièrement : la récompense de la première réussite en difficulté Fou ne bénéficie pas du « Bonus de Pointeur final ».\n\n<Title:Écho>\n1. « Écho » ne sera disponible que du 18 novembre 9h00 au 9 décembre 9h00 (GMT+8).\n2. Après le 9 décembre 9h00 (GMT+8), les « Pointeurs finaux » restants non échangés seront récupérés au taux de « Billet Rose Dorée*40 » par unité. Veuillez vérifier vos messages."
  },
  Activity_56434_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_56435_ActivityName = {
    Text = "Soins multiples·Réplique"
  },
  Activity_56435_ActivityPlot = {
    Text = "Symptôme : Hystérie, également connu sous le nom de trouble hystérique.\nÀ votre époque, c'est synonyme de mort.\n\nHeureusement, les scientifiques et enquêteurs de Mizag sont tout aussi fous : ils sont déterminés à résoudre ce problème"
  },
  Activity_56435_ActivityStageEndContent = {
    Text = "L'événement est terminé. Actuellement, seule \"Analyse de Personnalité\" est disponible."
  },
  Activity_56435_ActivityTips = {
    Text = "<Title:Aperçu de l'événement>\n1. Pendant l'événement, les Gardiens du secret peuvent collecter la monnaie d'événement « Puzzle de Mémoire » via les modes à durée limitée « Encodage Mémoriel », « Stockage Périphérique » et « Récompenses de succès ». Les « Puzzle de Mémoire » peuvent être utilisés dans « Analyse de Persona » pour acheter des objets, y compris la Roue du Destin SR exclusive à l'événement « Détermination de la Morue d'Argent », le Noyau de Lumière, le Cœur Immaculé, etc.\n2. Pendant l'événement, « note spéciale : Fission Tranquille » est disponible en accès gratuit limité. Compléter les succès de l'événement permet également d'obtenir l'avatar exclusif « Au nom de la Clé d'Argent : ›«24»› ».\n\n<Title:Durée de l'événement>\n1. Du 21 octobre à 9:00 au 4 novembre à 9:00 (GMT+8), tous les modes de l'événement sont disponibles.\n2. Du 4 novembre à 9:00 au 11 novembre à 9:00 (GMT+8), seules « Analyse de Persona » et les Récompenses de succès sont accessibles.\n\n<Title:Encodage Mémoriel>\n1. « Encodage Mémoriel » comprend 5 étapes, une s'ouvrant tous les 2 jours.\n2. Chaque défi consomme 120 Ménophine, et les défis réussis rapportent de la monnaie d'événement.\n3. Après avoir terminé une étape, la fonction « Reproduire » pour cette étape se débloque. Remarque : aucun Taux de synchronisation n'est gagné en utilisant « Reproduire ».\n4. Utilisez l'Aide des Anciens Élèves et « Résonance : Syndrome Dissociatif » pour terminer les étapes plus facilement.\n\n<Title:Bonus Rationnel>\n1. Les Gardiens du secret possédant certains Corps éveillés ou Roues du Destin (pas besoin de les déployer) reçoivent des drops supplémentaires de « Puzzle de Mémoire » dans les tâches « Encodage Mémoriel », comme suit :\nCorps éveillé « «24» » : Dégagement 0/1/2/3+, bonus 20%/30%/40%/50%.\nRoue du Destin SSR « Rétroaction du corps déformé » : Empilement 0/1/2/3+, bonus 20%/30%/40%/50%.\nRoue du Destin SR « Détermination de la Morue d'Argent » : Empilement 0/1/2/3+, bonus 20%/30%/40%/50%.\n2. Les Bonus Rationnels de différents Corps éveillés ou Roues du Destin se cumulent.\n3. Remarque spéciale : les récompenses de première complétion en difficulté Fou ne sont pas affectées par le Bonus Rationnel.\n\n<Title:Résonance : Syndrome Dissociatif>\n1. Les Gardiens du secret peuvent obtenir « Cœur de Fissure » en complétant les succès de l'événement.\n2. Utilisez « Cœur de Fissure » pour activer « Résonance : Syndrome Dissociatif », accordant les avantages suivants :\n(1) Améliorer la Force du Gardien dans « Encodage Mémoriel » et « note spéciale : Fission Tranquille », rendant les défis plus faciles.\n(2) Augmenter les récompenses des défis « Encodage Mémoriel ».\n(3) Activer le mode événement « Stockage Périphérique ».\n\n<Title:Stockage Périphérique>\n1. Après avoir activé « Résonance : Résonance Cognitive », gagnez automatiquement 60 « Puzzle de Mémoire α » par heure, jusqu'à 25 heures.\n2. Après avoir activé « Résonance : Taux de synchronisation Cognitif », gagnez automatiquement 30 « Puzzle de Mémoire β » par heure, jusqu'à 25 heures.\n\n<Title:Note spéciale>\n1. Pendant l'événement, « note spéciale : Fission Tranquille » est gratuite à débloquer.\n2. Après l'événement, la progression de « note spéciale : Fission Tranquille » est conservée, et les enquêtes inachevées peuvent toujours accorder les mêmes récompenses. Si « note spéciale : Fission Tranquille » n'a pas été débloquée pendant l'événement, elle peut encore être débloquée après l'événement pour 7 Point de départ réel.\n3. Quel que soit le moment, terminer « note spéciale : Fission Tranquille » accorde toujours « Décret Clé : Elle en Entier ».\n\n<Title:Compensation de réédition>\n1. Les Gardiens du secret ayant précédemment débloqué « note spéciale : Fission Tranquille » recevront 700 « Puzzle de Mémoire α » en compensation lors de cet événement de réédition.\n2. Les Gardiens du secret ayant précédemment obtenu l'avatar exclusif « Au nom de la Clé d'Argent : ›«24»› » recevront 2000 « Puzzle de Mémoire α » en cas d'acquisition en double.\n3. Les Gardiens du secret ayant précédemment acquis le matériau de résonance « Cœur de Fissure » recevront 5000 Billet Rose Dorée pour chaque « Cœur de Fissure » supplémentaire."
  },
  Activity_56435_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_56436_ActivityName = {
    Text = "Banquet brûlant : Récurrence"
  },
  Activity_56436_ActivityPlot = {
    Text = "Isaraou, la ville au bord du lac, serait selon la légende le lieu d'origine de wanda.\nCette fois, vous passerez par la porte des rêves, atteignant ce vieux groupe de tours recouvertes de cloches"
  },
  Activity_56436_ActivityStageEndContent = {
    Text = "Événement terminé, participation uniquement à « Le trésor de Wanda »"
  },
  Activity_56436_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, le gardien peut collecter des devises d'événement « Os Tibia », « Coquille à feuilles rondes » et « Spirale des Ruines » via les modes limités « Fête Brûlante » et « Récompenses de succès ». Les devises d'événement peuvent être utilisées pour acheter des articles dans « La Boîte aux Trésors de Wanda », y compris la roue du destin SR limitée à l'événement « Le regard d'Isarau », Cœur de Lumens, Cœur Immaculé, etc. \n2. Pendant l'événement, « Plongée dans l'inconscient : Fête Brûlante » est déverrouillée gratuitement pour une durée limitée, et en complétant les succès de l'événement, on peut obtenir le portrait limité à l'événement « Au nom de la Clé d'Argent : Wanda » !\n\n<Title:Durée de l'événement>\n1. Du 23 septembre à 9h00 au 7 octobre à 9h00 (GMT+8), tous les modes d'événement sont accessibles. \n2. Du 7 octobre à 9h00 au 14 octobre à 9h00 (GMT+8), seuls « La Boîte aux Trésors de Wanda » et les récompenses de succès sont accessibles. \n\n<Title:Ville du lac>\n1. La « Ville du lac » comporte 7 niveaux, un niveau s'ouvre automatiquement chaque jour. \n2. Chaque défi consomme « Ménophine » × 120, et un défi réussi rapportera des devises d'événement. \n3. Après avoir terminé un niveau, la fonction « Reproduire » pour ce niveau sera déverrouillée. Veuillez noter : en utilisant la fonction « Reproduire », il n'est pas possible d'obtenir le taux de synchronisation. \n4. Vous pouvez utiliser l'assistance de l'association d'anciens élèves et « Résonance : Ordre secret » pour vous aider à passer les niveaux plus facilement. \n\n<Title:Bonus spécial>\n1. Si le gardien possède un Éveilleur ou une roue du destin spécifique (aucune exigence de déploiement), cela peut augmenter le montant des devises d'événement obtenues en accomplissant des tâches dans les niveaux de « Ville du lac », les bonus spécifiques sont les suivants :\n· Éveilleur « Wanda » : Dégagement 0/1/2/3 et plus, bonus 20%/30%/40%/50%.\n· SSR roue du destin « Ordre de la Reine » : Superposition 0/1/2/3 et plus, bonus 20%/30%/40%/50%.\n· SR roue du destin « Le regard d'Isarau » : Superposition 0/1/2/3 et plus, bonus 20%/30%/40%/50%.\n2. Les « Bonus spéciaux » de différents Éveilleurs ou roues du destin sont calculés de manière cumulative. \n3. Notamment, les récompenses de défi de difficulté Folie ne seront pas affectées par les « Bonus spéciaux ».\n\n<Title:Résonance : Ordre secret>\n1. Le gardien peut obtenir « Cœur de plaisir » en accomplissant les succès de l'événement. \n2. En dépensant « Cœur de plaisir », activer « Résonance : Ordre secret » permettra au gardien de devenir plus fort dans « Ville du lac », rendant les défis plus faciles ; cela permettra également au gardien d'obtenir des devises d'événement supplémentaires lors de la réussite des niveaux. \n\n<Title:Plongée dans l'inconscient>\n1. Pendant l'événement, « Fête Brûlante » peut être déverrouillée gratuitement. \n2. Après la fin de l'événement, le progrès d'enquête de « Fête Brûlante » sera conservé, et les récompenses d'enquête correspondant à celles de la période de l'événement seront également obtenues en complétant les événements d'enquête non terminés pendant l'événement. Si « Fête Brûlante » n'a pas été déverrouillée pendant l'événement, elle peut toujours être déverrouillée après la fin de l'événement en dépensant « Point de départ réel » ×3. \n3. Que ce soit pendant ou après l'événement, en terminant « Fête Brûlante », le gardien recevra « Décret Clé : Festin pourri ». \n\n<Title:Compensation de réédition>\n1. Les gardiens qui ont déjà déverrouillé « Plongée dans l'inconscient : Fête Brûlante » recevront une compensation de « Os Tibia » ×300 lors du déverrouillage de cette réédition. \n2. Les gardiens qui ont déjà obtenu le portrait limité « Au nom de la Clé d'Argent : Wanda » recevront automatiquement en compensation « Os Tibia » ×2000 lors de la répétition. \n3. Les gardiens qui ont déjà obtenu le matériau d'activation de résonance « Cœur de plaisir », chaque « Cœur de plaisir » supplémentaire obtenu sera automatiquement converti en « Billet Rose Dorée » ×5000. \n"
  },
  Activity_56436_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_56477_ActivityName = {
    Text = "Profanation"
  },
  Activity_56478_ActivityName = {
    Text = "Bonne chasse !"
  },
  Activity_56479_ActivityName = {
    Text = "Gardien de l'Âme"
  },
  Activity_56480_ActivityName = {
    Text = "Fête Brûlante"
  },
  Activity_56481_ActivityName = {
    Text = "Elworth's returnee"
  },
  Activity_56482_ActivityName = {
    Text = "Fission Calme"
  },
  Activity_59841_ActivityName = {
    Text = "Pack de Croissance de Valeur (Interrompu)"
  },
  Activity_59841_ActivityPlot = {
    Text = "Après achat, \"Daffodil\" peut atteindre\n<BlueQuality:Lv50>, <BlueQuality:All Skills Lv4>"
  },
  Activity_59842_ActivityName = {
    Text = "Pack de Croissance de Valeur (Interrompu)"
  },
  Activity_59842_ActivityPlot = {
    Text = "Après l'achat, \"Wanda\" peut croître jusqu'à\n<BlueQuality:Niv50>, <BlueQuality:Toutes les Compétences Niv4>"
  },
  Activity_59843_ActivityName = {
    Text = "Pack de Croissance de Valeur (Interrompu)"
  },
  Activity_59843_ActivityPlot = {
    Text = "Après l'achat, « Tulu » peut atteindre\n<BlueQuality:Niv. 50>, <BlueQuality:Toutes les compétences Niv. 4>"
  },
  Activity_59844_ActivityName = {
    Text = "Pack de Croissance de Valeur (Interrompu)"
  },
  Activity_59844_ActivityPlot = {
    Text = "Après l'achat, \"Thais\" peut croître jusqu'à\n<BlueQuality:Niv50>, <BlueQuality:Toutes les Compétences Niv4>"
  },
  Activity_59845_ActivityName = {
    Text = "Pack de Croissance de Valeur (Interrompu)"
  },
  Activity_59845_ActivityPlot = {
    Text = "Après achat, \"Miryam\" peut atteindre\n<BlueQuality:Lv50>, <BlueQuality:All Skills Lv4>"
  },
  Activity_59846_ActivityName = {
    Text = "Pack de Croissance de Valeur (Interrompu)"
  },
  Activity_59846_ActivityPlot = {
    Text = "Après l'achat, «Hamelin» peut atteindre\n<BlueQuality:Nv50>, <BlueQuality:Toutes les compétences Nv4>"
  },
  Activity_59847_ActivityName = {
    Text = "Tribut rétrospectif VIII"
  },
  Activity_59847_ActivityPlot = {
    Text = "Un souvenir scellé et archivé, un voyage enregistré dans le passé. Dans les moments de souvenir, n'oubliez pas d'offrir votre Visite révérencieuse."
  },
  Activity_59848_ActivityName = {
    Text = "Tribut rétrospectif III"
  },
  Activity_59848_ActivityPlot = {
    Text = "Un souvenir scellé et archivé, un voyage enregistré dans le passé. Dans les moments de souvenir, n'oubliez pas d'offrir votre Visite révérencieuse."
  },
  Activity_59849_ActivityName = {
    Text = "Pack de Croissance de Valeur (Interrompu)"
  },
  Activity_59849_ActivityPlot = {
    Text = "Après l'achat, \"Helot·Catena\" peut croître jusqu'à\n<BlueQuality:Lv50>, <BlueQuality:All Skills Lv4>"
  },
  Activity_59850_ActivityName = {
    Text = "Commemoration du voyage I"
  },
  Activity_59850_ActivityPlot = {
    Text = "Un souvenir scellé et archivé, un voyage enregistré dans le passé. Dans les moments de souvenir, n'oubliez pas d'offrir votre Visite révérencieuse."
  },
  Activity_59851_ActivityName = {
    Text = "Hommage rétrospectif : Prélude"
  },
  Activity_59851_ActivityPlot = {
    Text = "Un souvenir scellé et archivé, un voyage enregistré dans le passé. Dans les moments de souvenir, n'oubliez pas d'offrir votre Visite révérencieuse."
  },
  Activity_59852_ActivityName = {
    Text = "Tribut rétrospectif VII"
  },
  Activity_59852_ActivityPlot = {
    Text = "Un souvenir scellé et archivé, un voyage enregistré dans le passé. Dans les moments de souvenir, n'oubliez pas d'offrir votre Visite révérencieuse."
  },
  Activity_59853_ActivityName = {
    Text = "Tribut rétrospectif VI"
  },
  Activity_59853_ActivityPlot = {
    Text = "Un souvenir scellé et archivé, un voyage enregistré dans le passé. Dans les moments de souvenir, n'oubliez pas d'offrir votre Visite révérencieuse."
  },
  Activity_59854_ActivityName = {
    Text = "Tribut rétrospectif V"
  },
  Activity_59854_ActivityPlot = {
    Text = "Un souvenir scellé et archivé, un voyage enregistré dans le passé. Dans les moments de souvenir, n'oubliez pas d'offrir votre Visite révérencieuse."
  },
  Activity_59855_ActivityName = {
    Text = "Tribut rétrospectif IV"
  },
  Activity_59855_ActivityPlot = {
    Text = "Un souvenir scellé et archivé, un voyage enregistré dans le passé. Dans les moments de souvenir, n'oubliez pas d'offrir votre Visite révérencieuse."
  },
  Activity_59856_ActivityName = {
    Text = "Pack de Croissance de Valeur (Interrompu)"
  },
  Activity_59856_ActivityPlot = {
    Text = "Après l'achat, «Murphy» peut atteindre\n<BlueQuality:Nv50>, <BlueQuality:Toutes les compétences Nv4>"
  },
  Activity_59857_ActivityName = {
    Text = "Pack de Croissance de Valeur (Interrompu)"
  },
  Activity_59857_ActivityPlot = {
    Text = "Après achat, \"Ryker\" peut atteindre\n<BlueQuality:Lv50>, <BlueQuality:All Skills Lv4>"
  },
  Activity_59858_ActivityName = {
    Text = "Tribut rétrospectif II"
  },
  Activity_59858_ActivityPlot = {
    Text = "Un souvenir scellé et archivé, un voyage enregistré dans le passé. Dans les moments de souvenir, n'oubliez pas d'offrir votre Visite révérencieuse."
  },
  Activity_59859_ActivityName = {
    Text = "Pack de Croissance de Valeur (Interrompu)"
  },
  Activity_59859_ActivityPlot = {
    Text = "Après l'achat, \"Sorel\" peut croître jusqu'à\n<BlueQuality:Niv50>, <BlueQuality:Toutes les Compétences Niv4>"
  },
  Activity_59860_ActivityName = {
    Text = "Pack de Croissance de Valeur (Interrompu)"
  },
  Activity_59860_ActivityPlot = {
    Text = "Après achat, \"Horla\" peut atteindre\n<BlueQuality:Lv50>, <BlueQuality:All Skills Lv4>"
  },
  Activity_59861_ActivityName = {
    Text = "Pack de Croissance de Valeur (Interrompu)"
  },
  Activity_59861_ActivityPlot = {
    Text = "Après achat, \"Salvador\" peut atteindre\n<BlueQuality:Lv50>, <BlueQuality:All Skills Lv4>"
  },
  Activity_59862_ActivityName = {
    Text = "Pack de Croissance de Valeur (Interrompu)"
  },
  Activity_59862_ActivityPlot = {
    Text = "Après l'achat, «Tavi» peut atteindre\n<BlueQuality:Nv50>, <BlueQuality:Toutes les compétences Nv4>"
  },
  Activity_59863_ActivityName = {
    Text = "Pack de Croissance de Valeur (Interrompu)"
  },
  Activity_59863_ActivityPlot = {
    Text = "Après achat, \"Lily\" peut atteindre\n<BlueQuality:Lv50>, <BlueQuality:All Skills Lv4>"
  },
  Activity_59864_ActivityName = {
    Text = "Pack de Croissance de Valeur (Interrompu)"
  },
  Activity_59864_ActivityPlot = {
    Text = "Après l'achat, «24» peut atteindre\n<BlueQuality:Nv50>, <BlueQuality:Toutes les compétences Nv4>"
  },
  Activity_59865_ActivityName = {
    Text = "Pack de Croissance de Valeur (Interrompu)"
  },
  Activity_59865_ActivityPlot = {
    Text = "Après l'achat, \"Genesis·Doll\" peut croître jusqu'à\n<BlueQuality:Lv50>, <BlueQuality:All Skills Lv4>"
  },
  Activity_61156_ActivityName = {
    Text = "Fin de l'itinéraire"
  },
  Activity_61156_ActivityTips = {
    Text = "Event Règles:\n1. Après avoir complété les tâches de Gardien spécifiées, les récompenses peuvent être réclamées dans le \"Journal Final\".\n2. Le \"Journal Final\" est disponible en permanence.\n3. Débloquez le \"Journal Avancé\" pour recevoir des récompenses supplémentaires après avoir complété les tâches.\n4. Remarque : Le \"Journal Avancé\" débloqué pendant cet événement n'est valide que pour la durée de cet événement. Les Gardiens sont conseillés à dépenser judicieusement."
  },
  Activity_61369_ActivityName = {
    Text = "Rythme progressif"
  },
  Activity_61369_ActivityPlot = {
    Text = "Les Gardiens du secret peuvent choisir l'une des Roues du Destin limitées suivantes pour la Réveiller gratuitement !"
  },
  Activity_61369_ActivityTips = {
    Text = "<Title:Présentation>\nDans le mystérieux Bassin Noir, où tourbillonnent les nuages d'intrigues, la Roue du Destin tourne inlassablement. Guidées par la musique d'Hamelin, d'innombrables mélodies s'harmonisent pour former la Roue de votre voyage. Que leur aide vous accompagne jusqu'à la note finale de la symphonie conclusive.\n\n<Title:Règles de l'événement>\nPendant l'événement, connectez–vous un jour pour sélectionner et Réveiller l'une des 12 Roues du Destin limitées suivantes : Hymne au Dieu–Roi, Une Collection des plus Précieuses, Au nom de la Rose, Au Travers de la Douleur, Naissance Cachée, Ordre de la Reine, Tables de la Loi, Rétroaction du corps déformé, Force de la Dévotion, Dernier Vers, Élevé dans la Douceur et Moment Propice."
  },
  Activity_61369_BannerText = {
    Text = "Obtenez une Roue du Destin limitée gratuitement"
  },
  Activity_61370_ActivityName = {
    Text = "Désir Argenté"
  },
  Activity_61370_ActivityPlot = {
    Text = "Connectez–vous chaque jour pour récupérer la Roue du Destin SSR commémorative en édition limitée «Cœur d'Argent Immaculé», jusqu'à 16 au total !"
  },
  Activity_61370_ActivityTips = {
    Text = "<Title:Introduction>\nPeu importe comment le monde peut se retourner, tant que chacun garde son cœur d'argent pur d'origine, l'histoire passera inévitablement en boucle, et une nouvelle vie renaîtra sur la terre désolée.\n\n<Title:Event Rules>\n· Pendant l'événement, les gardiens peuvent se connecter quotidiennement pour réclamer l'édition limitée de la Roue du Destin SSR \"Cœur d'Argent Pur\", avec un total de 16 réclamations.\n· Les récompenses seront déverrouillées dans l'ordre selon les connexions cumulées des gardiens, et les récompenses de connexion quotidienne se rafraîchiront à 9h00 (GMT+8)"
  },
  Activity_61370_BannerText = {
    Text = "RdD SSR limitée gratuite"
  },
  Activity_61371_ActivityName = {
    Text = "Prières des ailes hexad"
  },
  Activity_61371_ActivityPlot = {
    Text = "Au cœur du tumulte du Bassin Noir, l'Argent provenant d'infinies Dimensions s'est dispersé le long de ses rives à travers les failles dimensionnelles. Tawil les a soigneusement rassemblés et placés dans un recoin du Bassin Noir. Bien que cet Argent ne puisse enrayer la Propagation de la Fusion, les sentiments et les émotions qu'il renferme brilleront d'un éclat resplendissant pour toujours."
  },
  Activity_61371_ActivityTips = {
    Text = "<Title:Présentation>\nAu cœur du tumulte du Bassin Noir, l'Argent dispersé à travers les failles dimensionnelles depuis d'infinies Dimensions repose au bord du Bassin Noir. Tawil les rassemble avec soin et les place dans un recoin du Bassin Noir. Bien que cet Argent ne puisse enrayer la Propagation de la Fusion, les souvenirs et les sentiments qu'il renferme brilleront toujours d'un éclat resplendissant.\n\n<Title:Règles de l'événement>\nPendant l'événement, les Gardiens du secret peuvent se connecter chaque jour pour recevoir 1000 Argent, avec un maximum de 6 réclamations.\nLe 7e jour de connexion cumulée, les Gardiens du secret peuvent directement obtenir le Corps éveillé en édition limitée «Tavi» !\nLes récompenses se débloquent progressivement en fonction des connexions quotidiennes cumulées des Gardiens du secret, et les récompenses de connexion quotidienne sont réinitialisées à 9h (GMT+8)."
  },
  Activity_61371_BannerText = {
    Text = "Connectez–vous pour récupérer plein d'Argent"
  },
  Activity_61482_ActivityName = {
    Text = "Cadeau commémoratif de promotion V"
  },
  Activity_61482_ActivityPlot = {
    Text = "La route s'étend longuement, enveloppée dans les ténèbres de la Fusion.\nLa lumière de la Clé d'Argent nous guidera tous."
  },
  Activity_61483_ActivityName = {
    Text = "Cadeau commémoratif de promotion IV"
  },
  Activity_61483_ActivityPlot = {
    Text = "La route s'étend longuement, enveloppée dans les ténèbres de la Fusion.\nLa lumière de la Clé d'Argent nous guidera tous."
  },
  Activity_61484_ActivityName = {
    Text = "Cadeau commémoratif de promotion VII"
  },
  Activity_61484_ActivityPlot = {
    Text = "La route s'étend longuement, enveloppée dans les ténèbres de la Fusion.\nLa lumière de la Clé d'Argent nous guidera tous."
  },
  Activity_61485_ActivityName = {
    Text = "Cadeau commémoratif de promotion VI"
  },
  Activity_61485_ActivityPlot = {
    Text = "La route s'étend longuement, enveloppée dans les ténèbres de la Fusion.\nLa lumière de la Clé d'Argent nous guidera tous."
  },
  Activity_61486_ActivityName = {
    Text = "Cadeau commémoratif de promotion I"
  },
  Activity_61486_ActivityPlot = {
    Text = "La route s'étend longuement, enveloppée dans les ténèbres de la Fusion.\nLa lumière de la Clé d'Argent nous guidera tous."
  },
  Activity_61487_ActivityName = {
    Text = "Cadeau commémoratif de promotion III"
  },
  Activity_61487_ActivityPlot = {
    Text = "La route s'étend longuement, enveloppée dans les ténèbres de la Fusion.\nLa lumière de la Clé d'Argent nous guidera tous."
  },
  Activity_61488_ActivityName = {
    Text = "Cadeau commémoratif de promotion II"
  },
  Activity_61488_ActivityPlot = {
    Text = "La route s'étend longuement, enveloppée dans les ténèbres de la Fusion.\nLa lumière de la Clé d'Argent nous guidera tous."
  },
  Activity_61489_ActivityName = {
    Text = "Cadeau commémoratif de promotion VIII"
  },
  Activity_61489_ActivityPlot = {
    Text = "La route s'étend longuement, enveloppée dans les ténèbres de la Fusion.\nLa lumière de la Clé d'Argent nous guidera tous."
  },
  Activity_61517_ActivityName = {
    Text = "Boîte de fournitures d'enquête"
  },
  Activity_61517_ActivityPlot = {
    Text = "Enquête sur les fournitures fournies par le Bureau Administratif des Mizags. Raffinées par Alistair à partir des débris de la Mare Noire."
  },
  Activity_61546_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_61546_ActivityPlot = {
    Text = "Lors de l'achat, \"Tulu\" peut être activé\n<BlueQuality:Amélioration de la persona +4, débloquer la surexaltation>"
  },
  Activity_61547_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_61547_ActivityPlot = {
    Text = "Après l'achat, \"Horla\" peut activer <BlueQuality:Enlighten 3>"
  },
  Activity_61548_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_61548_ActivityPlot = {
    Text = "Après l'achat, \"Faros\" peut activer <BlueQuality:Enlighten 3>"
  },
  Activity_61549_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_61549_ActivityPlot = {
    Text = "Lors de l'achat, \"Alva\" peut être activé\n<BlueQuality:Amélioration de la Persona +4, déverrouillez la Sur-Exaltation>"
  },
  Activity_61550_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_61550_ActivityPlot = {
    Text = "Lors de l'achat, \"Jenkin\" peut être activé\n<BlueQuality:amélioration de Persona +4, débloquer Hyper-Exaltation>"
  },
  Activity_61551_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_61551_ActivityPlot = {
    Text = "Lors de l'achat, \"Pandia\" peut être activé\n<BlueQuality:amélioration de Persona +4, débloquer Hyper-Exaltation>"
  },
  Activity_61552_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_61552_ActivityPlot = {
    Text = "Après l'achat, \"Céleste\" peut activer <BlueQuality:Illuminer 3>"
  },
  Activity_61553_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_61553_ActivityPlot = {
    Text = "À l'achat, \"\"24\"\" active <BlueQuality:Illuminer 3>"
  },
  Activity_61554_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_61554_ActivityPlot = {
    Text = "Après l'achat, \"Faint\" peut activer <BlueQuality:Enlighten 3>"
  },
  Activity_61555_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_61555_ActivityPlot = {
    Text = "Lors de l'achat, \"Teinture\" peut être activé\n<BlueQuality:Amélioration de la persona +4, débloquer la surexaltation>"
  },
  Activity_61556_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_61556_ActivityPlot = {
    Text = "À l'achat, \"Casiah\" active <BlueQuality:Illuminer 3>"
  },
  Activity_61557_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_61557_ActivityPlot = {
    Text = "Après achat, \"Salvador\" peut activer <BlueQuality:Illuminer 3>"
  },
  Activity_61558_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_61558_ActivityPlot = {
    Text = "Lors de l'achat, \"Salvador\" peut être activé\n<BlueQuality:amélioration de Persona +4, débloquer Hyper-Exaltation>"
  },
  Activity_61559_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_61559_ActivityPlot = {
    Text = "Après achat, \"Thais\" peut activer <BlueQuality:Illuminer 3>"
  },
  Activity_61560_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_61560_ActivityPlot = {
    Text = "Lors de l'achat, \"Lily\" peut être activé\n<BlueQuality:amélioration de Personnalité +4, débloquer Hyper-Exaltation>"
  },
  Activity_61561_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_61561_ActivityPlot = {
    Text = "Après l'achat, \"Goliath\" peut activer <BlueQuality:Enlighten 3>"
  },
  Activity_61562_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_61562_ActivityPlot = {
    Text = "Après l'achat, \"Lily\" peut activer <BlueQuality:Enlighten 3>"
  },
  Activity_61563_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_61563_ActivityPlot = {
    Text = "Après achat, \"Sanga\" peut activer <BlueQuality:Illuminer 3>"
  },
  Activity_61564_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_61564_ActivityPlot = {
    Text = "Après l'achat, \"Jonquille\" peut activer <BlueQuality:Illuminer 3>"
  },
  Activity_61565_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_61565_ActivityPlot = {
    Text = "Lors de l'achat, \"Nautila\" peut être activé\n<BlueQuality:amélioration de Persona +4, débloquer Hyper-Exaltation>"
  },
  Activity_61566_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_61566_ActivityPlot = {
    Text = "Après l'achat, \"Karen\" peut activer <BlueQuality:Enlighten 3>"
  },
  Activity_61567_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_61567_ActivityPlot = {
    Text = "Après l'achat, \"Alva\" peut activer <BlueQuality:Illuminer 3>"
  },
  Activity_61568_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_61568_ActivityPlot = {
    Text = "Lors de l'achat, \"Leigh\" peut activer <BlueQuality:Illuminer 3>"
  },
  Activity_61569_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_61569_ActivityPlot = {
    Text = "Lors de l'achat, \"Tulu\" s'active <BlueQuality: Illuminer 3>"
  },
  Activity_61570_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_61570_ActivityPlot = {
    Text = "À l'achat, \"Caecus\" active <BlueQuality:Illuminer 3>"
  },
  Activity_61571_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_61571_ActivityPlot = {
    Text = "Lors de l'achat, \"Bigorneau\" peut être activé\n<BlueQuality:Amélioration de la persona +4, débloquer la surexaltation>"
  },
  Activity_61572_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_61572_ActivityPlot = {
    Text = "Lors de l'achat, \"Wanda\" peut être activé\n<BlueQuality:Amélioration de la persona +4, débloquer la surexaltation>"
  },
  Activity_61573_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_61573_ActivityPlot = {
    Text = "Lors de l'achat, \"Goliath\" peut être activé\n<BlueQuality:amélioration de Personnalité +4, débloquer Hyper-Exaltation>"
  },
  Activity_61574_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_61574_ActivityPlot = {
    Text = "Après achat, \"Ryker\" peut activer <BlueQuality:Illuminer 3>."
  },
  Activity_61575_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_61575_ActivityPlot = {
    Text = "Après achat, \"Nymphaea\" peut activer <BlueQuality:Illuminer 3>"
  },
  Activity_61576_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_61576_ActivityPlot = {
    Text = "Lors de l'achat, \"Caecus\" peut être activé\n<BlueQuality:Amélioration de la Persona +4, déverrouillez la Sur-Exaltation>"
  },
  Activity_61577_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_61577_ActivityPlot = {
    Text = "Après achat, \"Miryam\" peut activer <BlueQuality:Illuminer 3>"
  },
  Activity_61578_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_61578_ActivityPlot = {
    Text = "Lors de l'achat, \"Ryker\" peut être activé\n<BlueQuality:amélioration de Persona +4, débloquer Hyper-Exaltation>"
  },
  Activity_61579_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_61579_ActivityPlot = {
    Text = "Lors de l'achat, \"Sanga\" peut être activé\n<BlueQuality:amélioration de Personnalité +4, débloquer Hyper-Exaltation>"
  },
  Activity_61580_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_61580_ActivityPlot = {
    Text = "Après achat, \"Teinture\" peut activer <BlueQuality:Illuminer 3>"
  },
  Activity_61581_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_61581_ActivityPlot = {
    Text = "Lors de l'achat, \"Leigh\" peut être activé\n<BlueQuality:amélioration de Persona +4, débloquer Hyper-Exaltation>"
  },
  Activity_61582_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_61582_ActivityPlot = {
    Text = "Après l'achat, \"Liz\" peut activer <BlueQuality:Enlighten 3>"
  },
  Activity_61583_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_61583_ActivityPlot = {
    Text = "Lors de l'achat, \"Hilote\" peut être activé\n<BlueQuality:amélioration de Persona +4, débloquer Hyper-Exaltation>"
  },
  Activity_61584_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_61584_ActivityPlot = {
    Text = "Lors de l'achat, \"Casiah\" peut être activé\n<BlueQuality:Amélioration de la Persona +4, déverrouillez la Sur-Exaltation>"
  },
  Activity_61585_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_61585_ActivityPlot = {
    Text = "Lors de l'achat, \"Faros\" peut être activé\n<BlueQuality:amélioration de Persona +4, débloquer Hyper-Exaltation>"
  },
  Activity_61586_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_61586_ActivityPlot = {
    Text = "Lors de l'achat, \"Agrippa\" peut être activé\n<BlueQuality:Amélioration de la Persona +4, déverrouillez la Sur-Exaltation>"
  },
  Activity_61587_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_61587_ActivityPlot = {
    Text = "Après achat, \"Nautila\" peut activer <BlueQuality:Illuminer 3>"
  },
  Activity_61588_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_61588_ActivityPlot = {
    Text = "Lors de l'achat, \"Jonquille\" peut être activé\n<BlueQuality:Amélioration de la Persona +4, déverrouillez la Sur-Exaltation>"
  },
  Activity_61589_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_61589_ActivityPlot = {
    Text = "À l'achat, \"Hameln\" active <BlueQuality:Illuminer 3>"
  },
  Activity_61590_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_61590_ActivityPlot = {
    Text = "Lors de l'achat, \"Liz\" peut être activé\n<BlueQuality:amélioration de Persona +4, débloquer Hyper-Exaltation>"
  },
  Activity_61591_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_61591_ActivityPlot = {
    Text = "Lors de l'achat, \"Miryam\" peut être activé\n<BlueQuality:amélioration de Persona +4, débloquer Hyper-Exaltation>"
  },
  Activity_61592_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_61592_ActivityPlot = {
    Text = "Après achat, \"Wanda\" peut activer <BlueQuality:Illuminer 3>"
  },
  Activity_61593_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_61593_ActivityPlot = {
    Text = "Lors de l'achat, \"Karen\" peut être activé\n<BlueQuality:amélioration de Persona +4, débloquer Hyper-Exaltation>"
  },
  Activity_61594_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_61594_ActivityPlot = {
    Text = "Après achat, \"Uvhash\" peut activer <BlueQuality:Illuminer 3>"
  },
  Activity_61595_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_61595_ActivityPlot = {
    Text = "Lors de l'achat, \"Thais\" peut être activé\n<BlueQuality:Amélioration de la persona +4, débloquer la surexaltation>"
  },
  Activity_61596_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_61596_ActivityPlot = {
    Text = "Lors de l'achat, \"Uvhash\" peut être activé\n<BlueQuality:Amélioration de la persona +4, débloquer la surexaltation>"
  },
  Activity_61597_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_61597_ActivityPlot = {
    Text = "Lors de l'achat, \"Hameln\" peut être activé\n<BlueQuality:amélioration de Persona +4, débloquer Hyper-Exaltation>"
  },
  Activity_61598_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_61598_ActivityPlot = {
    Text = "Lors de l'achat, \"Murphy\" active <BlueQuality:Illuminer 3>"
  },
  Activity_61599_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_61599_ActivityPlot = {
    Text = "Après achat, \"Sorel\" peut activer <BlueQuality:Illuminer 3>"
  },
  Activity_61600_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_61600_ActivityPlot = {
    Text = "Lors de l'achat, \"Sorel\" peut être activé\n<BlueQuality:amélioration de Persona +4, débloquer Hyper-Exaltation>"
  },
  Activity_61601_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_61601_ActivityPlot = {
    Text = "Après l'achat, \"Helot\" peut activer <BlueQuality:Enlighten 3>"
  },
  Activity_61602_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_61602_ActivityPlot = {
    Text = "Lors de l'achat, \"Horla\" peut être activé\n<BlueQuality:amélioration de Persona +4, débloquer Hyper-Exaltation>"
  },
  Activity_61603_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_61603_ActivityPlot = {
    Text = "Lors de l'achat, \"Tawil\" active <BlueQuality:Illuminer 3>"
  },
  Activity_61604_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_61604_ActivityPlot = {
    Text = "Lors de l'achat, \"\"24\"\" peut être activé\n<BlueQuality:Amélioration de la Persona +4, déverrouillez la Sur-Exaltation>"
  },
  Activity_61605_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_61605_ActivityPlot = {
    Text = "À l'achat, \"Agrippa\" peut activer <BlueQuality:Illuminer 3>"
  },
  Activity_61606_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_61606_ActivityPlot = {
    Text = "Après achat, \"Pandia\" peut activer <BlueQuality:Illuminer 3>"
  },
  Activity_61607_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_61607_ActivityPlot = {
    Text = "Après l'achat, \"Helot·Catena\" peut être activé\n<BlueQuality:Persona Deepening +4, Unlock Over-Exaltation>"
  },
  Activity_61608_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_61608_ActivityPlot = {
    Text = "Après l'achat, \"Jenkin\" peut activer <BlueQuality:Enlighten 3>"
  },
  Activity_61609_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_61609_ActivityPlot = {
    Text = "Lors de l'achat, \"Nymphaea\" peut être activé\n<BlueQuality:+4 à l'amélioration de Persona, débloquer Hyper-Exaltation>"
  },
  Activity_61610_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_61610_ActivityPlot = {
    Text = "Après achat, \"Bigorneau\" peut activer <BlueQuality:Illuminer 3>"
  },
  Activity_61611_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_61611_ActivityPlot = {
    Text = "Lors de l'achat, \"Évanouissement\" peut être activé\n<BlueQuality:amélioration de Persona +4, débloquer Hyper-Exaltation>"
  },
  Activity_61612_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_61612_ActivityPlot = {
    Text = "Lors de l'achat, \"Murphy\" peut être activé\n<BlueQuality:amélioration de Persona +4, débloquer Hyper-Exaltation>"
  },
  Activity_61613_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_61613_ActivityPlot = {
    Text = "Lors de l'achat, \"Tawil\" peut être activé\n<BlueQuality:Amélioration de la persona +4, débloquer la surexaltation>"
  },
  Activity_61614_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_61614_ActivityPlot = {
    Text = "Après l'achat, \"Helot·Catena\" peut activer <BlueQuality:Enlighten 3>"
  },
  Activity_61615_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_61615_ActivityPlot = {
    Text = "Lors de l'achat, \"Céleste\" peut être activé\n<BlueQuality:Amélioration de la Persona +4, déverrouillez la Sur-Exaltation>"
  },
  Activity_65387_ActivityName = {
    Text = "Excuse du chat d'école"
  },
  Activity_65387_ActivityPlot = {
    Text = "En raison de récentes vulnérabilités dans les mesures de protection de l'école, <Del:«Texte temporaire, Point Rouge»> les incidents d'Invasion de Fusion sur le campus se sont multipliés, causant de grands désagréments aux élèves. C'est pourquoi l'administration scolaire a mis en place plusieurs points de ravitaillement pour distribuer des fournitures en guise de compensation. (Étant donné la responsabilité liée à la négligence dans la gestion des installations, toutes les fournitures seront cette fois entièrement transportées par le Chat de l'école.)"
  },
  Activity_65387_ActivityTips = {
    Text = "<Title:Présentation>\nRécemment, en raison de failles dans les mesures de protection de l'école, les incidents de <Del>«texte temporaire, point rouge»> Fusion perturbant le campus se sont multipliés, causant des désagréments considérables aux élèves. C'est pourquoi l'administration scolaire a mis en place plusieurs points de ravitaillement pour distribuer les stocks en guise de compensation. (En raison de la responsabilité liée aux erreurs de gestion des installations, la distribution des fournitures sera entièrement assurée par le Chat de l'école.)\n\n<Title:Règles de l'événement>\nPendant l'événement, les Gardiens du secret peuvent se connecter chaque jour pour récupérer 500 Argent via «Les excuses du chat de l'école», avec un maximum de 5 réclamations.\nLes récompenses se débloquent progressivement en fonction des connexions quotidiennes cumulées des Gardiens du secret, et les récompenses de connexion quotidienne sont réinitialisées à 9h (GMT+8)."
  },
  Activity_65387_BannerText = {
    Text = "Connectez–vous pour récupérer de l'Argent"
  },
  Activity_65502_ActivityName = {
    Text = "Mélodie progressive : Duette"
  },
  Activity_65502_ActivityPlot = {
    Text = "Les Gardiens du secret peuvent choisir l'une des Roues du Destin limitées suivantes pour la Réveiller gratuitement !"
  },
  Activity_65502_ActivityTips = {
    Text = "<Title:Présentation>\nDans le mystérieux Bassin Noir, où tourbillonnent les nuages d'intrigues, la Roue du Destin tourne inlassablement. Guidées par la musique d'Hamelin, d'innombrables mélodies s'harmonisent pour former la Roue de votre voyage. Que leur aide vous accompagne jusqu'à la note finale de la symphonie conclusive.\n\n<Title:Règles de l'événement>\nPendant l'événement, connectez–vous un jour pour sélectionner et Réveiller l'une des 12 Roues du Destin limitées suivantes : Hymne au Dieu–Roi, Une Collection des plus Précieuses, Au nom de la Rose, Au Travers de la Douleur, Naissance Cachée, Ordre de la Reine, Tables de la Loi, Rétroaction du corps déformé, Force de la Dévotion, Dernier Vers, Élevé dans la Douceur et Moment Propice."
  },
  Activity_65502_BannerText = {
    Text = "Obtenez une Roue du Destin limitée gratuitement"
  },
  Activity_65521_ActivityName = {
    Text = "Boîte de fournitures d'enquête"
  },
  Activity_65521_ActivityPlot = {
    Text = "Enquête sur les fournitures fournies par le Bureau Administratif des Mizags. Raffinées par Alistair à partir des débris de la Mare Noire."
  },
  Activity_65949_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65949_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65950_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65950_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65951_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65951_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65952_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65952_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65953_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65953_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65954_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65954_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65955_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65955_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65956_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65956_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65957_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65957_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65958_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65958_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65959_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65959_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65960_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65960_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65961_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65961_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65962_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65962_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65963_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65963_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65964_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65964_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65965_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65965_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65966_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65966_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65967_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65967_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65968_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65968_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65969_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65969_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65970_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65970_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65971_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65971_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65972_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65972_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65973_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65973_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65974_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65974_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65975_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65975_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65976_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65976_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65977_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65977_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65978_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65978_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65979_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65979_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65980_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65980_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65981_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65981_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65982_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65982_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65983_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65983_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65984_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65984_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65985_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65985_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65986_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65986_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65987_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65987_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65988_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65988_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65989_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65989_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65990_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65990_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65991_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65991_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65992_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65992_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65993_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65993_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65994_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65994_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65995_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65995_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65996_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65996_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65997_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65997_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65998_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65998_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_65999_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_65999_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_66000_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_66000_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_66001_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_66001_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_66002_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_66002_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_66003_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_66003_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_66004_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_66004_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_66005_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_66005_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_66006_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_66006_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_66007_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_66007_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_66008_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_66008_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_66009_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_66009_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_66010_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_66010_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_66011_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_66011_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_66012_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_66012_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_66013_ActivityName = {
    Text = "Cadeaux de mythag"
  },
  Activity_66013_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens du secret peuvent récupérer des récompenses de connexion quotidiennes dans « Cadeau de l'Académie » après s'être connectés chaque jour.\n2. Les récompenses seront débloquées séquentiellement en fonction du nombre cumulé de jours de connexion du Gardien. Les récompenses de connexion quotidiennes seront rafraîchies à 9:00 (GMT+8)."
  },
  Activity_66375_ActivityName = {
    Text = "Décisif : Ombre primordiale"
  },
  Activity_66375_ActivityPlot = {
    Text = "Son regard passa à travers d'innombrables dimensions, et en le rencontrant, se trouva là des milliers de silhouettes argentées.\nIls sont petits, fragiles. Ils combattent pour se souvenir, jusqu'à la mort"
  },
  Activity_66375_ActivityStageEndContent = {
    Text = "Événement atteint, continuer l'enquête"
  },
  Activity_66375_ActivityTips = {
    Text = "<Title: Conflit originel>\n· « Conflit originel » comprend 7 étapes uniques ne pouvant pas être reproduites, permettant de défier directement les visions originelles. Les 3 premières étapes seront débloquées le premier jour de l'événement, les suivantes s'ouvriront toutes les 3 journées.\n· À chaque défi réussi contre une vision originelle spécifique, vous obtiendrez les récompenses correspondantes.\n· Chaque type de vision originelle possède de nombreuses copies. Lorsque n'importe quel gardien réussit à battre une vision originelle de type spécifique, le « nombre restant dans le monde » de ce type de vision originelle diminuera de 1. Lorsque toutes les copies d'un type de vision originelle sont éliminées, l'étape correspondante se fermera et ne pourra plus être défiée.\n· Toutes les étapes sont affectées par « Marea noire de la catastrophe fusionnée - Fin », mais chaque étape fournit une relique « Cœur d'argent pur », différente, qui vous offrira des bonus puissants. En outre, chaque étape fournit également une relique « Œil omniscient », qui permettra à Tavy de gagner 120 fureur au début du combat, augmentant de 50 % tous les dégâts infligés par Tavy ainsi que les effets de bouclier et de régénération de vie.\n· Le choix d'un allié est obligatoire pour toutes les étapes. Durant tout l'événement, chaque gardien avec qui vous êtes mutuellement abonné ne pourra vous aider qu'une seule fois. En raison de l'utilisation d'un allié, les récompenses d'affinité réelles seront augmentées de 50 % par rapport aux récompenses de base.\n· Le gardien doit avoir terminé au minimum l'opération de recherche 2-9 pour participer à cet événement.\n\n<Title:Opération de recherche : Dénouement>\n· Les versions principales de chaque vision originelle doivent être vaincues personnellement par vous-même dans les opérations de recherche 9-5 à 9-11. Ces étapes spéciales ne possèdent ni accomplissements, ni étoiles, ni l'aide de la relique « Œil omniscient », ni la possibilité d'utiliser un allié, et sont en plus difficiles.\n· Après la fin de l'événement « Conflit originel », les étapes suivantes de « l'opération de recherche : Dénouement » seront débloquées. Une fois que toutes les copies de chaque type de vision originelle auront été éliminées avec d'autres gardiens, les étapes correspondantes des opérations de recherche 9-5 à 9-11 pourront être débloquées à l'avance.\n\n."
  },
  Activity_66375_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_66908_ActivityName = {
    Text = "Souffle de fertilité"
  },
  Activity_66908_ActivityTips = {
    Text = "<Title:Règles de l'activité>\n·Pendant l'événement \"Souffle Abondant\", les Gardiens peuvent utiliser des équipes prédéfinies par le système contenant Thais pour expérimenter des niveaux désignés un nombre illimité de fois.\n·Lors de la réalisation des niveaux d'événement, des ajustements au Réveiller dans la composition de l'équipe ne peuvent pas être effectués.\n<Title:Récompenses de l'activité>\n·Après avoir réussi un défi de niveau pour la première fois, vous pouvez réclamer des récompenses d'essai depuis l'interface de l'événement."
  },
  Activity_67077_ActivityName = {
    Text = "Voyage du souvenir IX"
  },
  Activity_67077_ActivityPlot = {
    Text = "Un souvenir scellé et archivé, un voyage enregistré dans le passé. Dans les moments de souvenir, n'oubliez pas d'offrir votre Visite révérencieuse."
  },
  Activity_67718_ActivityName = {
    Text = "Avant le Printemps Flétrissant·Rééditio"
  },
  Activity_67718_ActivityPlot = {
    Text = "Le rire des filles résonne dans le jardin avant que le feu ne commence.\nFaisons une pause pour ce beau passé, mon ami.\nÉcoute les histoires du printemps intouché, doucement narrées."
  },
  Activity_67718_ActivityStageEndContent = {
    Text = "L'événement est terminé. Actuellement, seule \"Maison Florale de Colette\" est disponible."
  },
  Activity_67718_ActivityTips = {
    Text = "<Title:Présentation de l'activité>\n1, Pendant la durée de l'activité, les Gardiens du secret peuvent collecter trois types de «poésie» via les modes de jeu limités «Jardin d'antan», «Baiser de la Muse» et les Récompenses de Succès. La «poésie» peut être échangée dans «La maison de fleurs de Colette» pour obtenir des récompenses d'objets, notamment la Roue du Destin SR limitée «Fleurs et Poèmes d'Antan», «Cœur Immaculé», «Cœur de Lumens», «Éclats de Pierre Sage», «Cristal de Mimesis», etc.\n2, Pendant la durée de l'activité, «Enregistrement de la task force : Demeure de la Rose» sera ouvert gratuitement.\n\n<Title:Durée de l'activité>\n1, Du 10 août 9:00 au 7 septembre 9:00(GMT+8), tous les contenus de l'activité sont accessibles.\n2, Du 7 septembre 9:00 au 14 septembre 9:00(GMT+8), seuls «La maison de fleurs de Colette» et les Récompenses de Succès sont conservés ; les autres contenus sont Terminés et ne sont plus accessibles.\n\n<Title: Jardin d'antan>\n1, «Jardin d'antan» comprend 5 niveaux, avec 1 niveau déverrouillé automatiquement tous les 2 jours.\n2, Chaque tentative consommera «Ménophine» × 120 ; en cas de succès, vous obtiendrez les monnaies d'activité «poésie mélancolique», «Poème de Regret» et «Poème joyeux».\n3, Après avoir terminé un niveau, la fonction «Reconstitution» de ce niveau est déverrouillée. Veuillez noter : lors de l'utilisation de la fonction «Reconstitution», il est impossible d'obtenir du Taux de synchronisation.\n4, Vous pouvez utiliser l'Assistance au combat de l'association d'anciens élèves et «Résonance : Élégie du jardin» pour vous aider à terminer les niveaux plus facilement.\n5, Le 2e jour après le déverrouillage d'un niveau, la difficulté Folie de ce niveau est déverrouillée. Terminer la difficulté Folie pour la première fois vous permettra d'obtenir de généreuses récompenses en monnaies d'activité.\n6, Veuillez noter : les tentatives en difficulté Folie ne consomment pas de Ménophine, ne peuvent pas être reconstituées, et les tentatives répétées après la première victoire ne rapporteront plus de monnaies d'activité.\n\n<Title: Bonus de poésie>\n1, Si un Gardien possède certains Corps éveillés ou Roues du Destin(sans obligation de les mettre en jeu), les «poésie mélancolique», «Poème de Regret» et «Poème joyeux» obtenus dans les récompenses de missions du niveau «Jardin d'antan» bénéficieront d'un bonus de drop supplémentaire(y compris lors de la Reconstitution). Les détails des bonus sont les suivants :\n·Corps éveillé «Horla» : Dégagement 0/1/2/3 et plus, bonus de 20%/30%/40%/50%\n·Roue du Destin SSR «Dernier Vers» : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%\n·Roue du Destin SR «Fleurs et Poèmes d'Antan» : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%\n2, Les «Bonus de poésie» de différents Corps éveillés ou Roues du Destin se cumulent.\n3, En particulier, les récompenses de la première victoire en difficulté Folie ne sont pas affectées par les «Bonus de poésie».\n\n<Title:Résonance : Élégie du jardin>\n1, Les Gardiens du secret peuvent obtenir des «Cœur de cendres» en accomplissant des succès d'activité.\n2, En consommant des «Cœur de cendres» pour activer «Résonance : Élégie du jardin», vous obtiendrez les bonus suivants :\n(1) Rendre le Gardien plus puissant dans le mode de jeu «Jardin d'antan», facilitant ainsi les défis.\n(2) Augmenter les monnaies d'activité obtenues après avoir réussi les défis de «Jardin d'antan».\n(3) Activer le mode de jeu «Baiser de la Muse».\n\n<Title: Baiser de la Muse>\n·Après avoir activé la Résonance «Tout pousse», vous obtenez automatiquement «poésie mélancolique» × 60 par heure, avec un stockage maximum de 25 heures.\n·Après avoir activé la Résonance «Échanger des poèmes contre des fleurs», «Baiser de la Muse» peut obtenir en plus «Poème de Regret» × 60 par heure.\n\n<Title: La maison de fleurs de Colette>\n1, «La maison de fleurs de Colette» comprend trois parterres de fleurs, dont les horaires d'ouverture sont les suivants :\n·«Parterre d'iris» : ouverture le 10 août à 9h.\n·«Parterre de campanules» : ouverture le 12 août à 9h.\n·«Parterre de roses» : ouverture le 14 août à 9h.\n2, Chaque échange consommera «poésie mélancolique»/«Poème de Regret»/«Poème joyeux» × 750, et vous obtiendrez aléatoirement cinq récompenses d'objets du parterre.\n3, Les récompenses d'objets de chaque parterre sont divisées en «Objet spécial» et «Objet ordinaire». La réinitialisation peut remettre la quantité Restante des récompenses d'Objet spécial à la limite maximale. Les règles spécifiques sont les suivantes :\n(1) Les 2 premières réinitialisations : lorsque les «Objet spécial» n'ont plus de quantité Restante, le Gardien peut choisir de réinitialiser, ce qui remettra la quantité Restante des «Objet spécial» et des «Objet ordinaire» à la limite maximale ; il peut également choisir de continuer à échanger, et lorsque les «Objet ordinaire» n'ont plus de quantité Restante, une réinitialisation sera nécessaire pour continuer à échanger.\n(2) À partir de la 3e réinitialisation : la réinitialisation ne peut être effectuée que lorsque les «Objet ordinaire» n'ont plus de quantité Restante. La réinitialisation remettra la quantité Restante des «Objet ordinaire» à la limite maximale, et les «Objet spécial» ne seront plus réinitialisés.\n4, Après le 14 septembre 9:00(GMT+8), les «poésie» Restantes non échangées seront récupérées au taux de «Billet Rose Dorée» × 40 par échange. Veuillez vérifier votre boîte mail, Gardiens du secret.\n\n<Title: Enregistrement de la task force>\n1, Pendant la durée de l'activité, «Enregistrement de la task force : Demeure de la Rose» sera ouvert gratuitement. De nouveaux événements seront proposés tous les 2 jours. Terminer «Enregistrement de la task force : Demeure de la Rose» vous permettra d'obtenir des Cœur d'argent, la Roue du Destin SR limitée «Fleurs et Poèmes d'Antan» et d'autres récompenses dans les Récompenses de Succès. Les Récompenses de Succès ne sont disponibles que pendant la durée de l'activité et ne pourront pas être complétées ni réclamées après la fin de l'activité.\n2, Après la fin de l'activité, la progression des enquêtes de «Enregistrement de la task force : Demeure de la Rose» sera conservée. Si «Enregistrement de la task force : Demeure de la Rose» n'a pas été déverrouillé pendant l'activité, il pourra toujours être déverrouillé après la fin de l'activité en consommant «Point de départ réel» × 7.\n3, Que ce soit pendant ou après l'activité, terminer «Enregistrement de la task force : Demeure de la Rose» vous permettra d'obtenir «Décret Clé : Poème d'offrande du printemps»."
  },
  Activity_67718_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_67719_ActivityName = {
    Text = "Événement de confession : Activité de déblocage de remise"
  },
  Activity_67721_ActivityName = {
    Text = "Avant le Printemps Flétrissant·Rééditio"
  },
  Activity_67721_ActivityPlot = {
    Text = "Le rire des filles résonne dans le jardin avant que le feu ne commence.\nFaisons une pause pour ce beau passé, mon ami.\nÉcoute les histoires du printemps intouché, doucement narrées."
  },
  Activity_67721_ActivityStageEndContent = {
    Text = "L'événement est terminé. Actuellement, seule \"Maison Florale de Colette\" est disponible."
  },
  Activity_67721_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, les Gardiens du secret peuvent collecter trois types de « Poèmes » via les modes limités « Jardin d'antan », « Baiser de la muse » et « Récompenses de succès ». Ces Poèmes peuvent être échangés dans « La serre de Colette » pour obtenir des récompenses, notamment la Roue du Destin SR exclusive de l'événement « Fleurs et Poèmes d'Antan », le Cœur Immaculé, le Cœur de Lumens, les Éclats de Pierre Sage, les Cristal de Mimesis, etc.\n2. Pendant l'événement, l'« Enregistrement de la task force : Demeure de la Rose » sera accessible gratuitement.\n\n<Title:Période de l'événement>\n1. Du 25 août à 9h00 au 8 septembre à 9h00 (GMT+8), toutes les activités de l'événement seront disponibles.\n2. Du 8 septembre à 9h00 au 15 septembre à 9h00 (GMT+8), seules « La serre de Colette » et « Récompenses de succès » resteront actives. Les autres contenus ne seront plus accessibles.\n\n<Title:Jardin d'antan>\n1. « Jardin d'antan » contient 5 niveaux, un niveau sera débloqué automatiquement tous les 2 jours.\n2. Chaque défi consomme 120 points de Ménophine. En cas de succès, vous obtenez la monnaie de l'événement « poésie mélancolique », « Poème de Regret » et « Poème joyeux ».\n3. Une fois un niveau terminé, la fonction « Reconstitution » de ce niveau est débloquée. Veuillez noter : lors de l'utilisation de la fonction « Reconstitution », vous ne gagnerez pas de taux de synchronisation.\n4. Vous pouvez utiliser l'aide des Alumni et activer « Résonance : Élégie du jardin » pour faciliter la réussite des niveaux.\n\n<Title:Bonus de poèmes>\n1. Si le Gardien possède un certain Éveilleur ou une certaine Roue du Destin (pas nécessairement déployé), il obtiendra un bonus supplémentaire sur les « poésie mélancolique », « Poème de Regret » et « Poème joyeux » obtenus dans les récompenses des missions de « Jardin d'antan » (y compris la reconstitution). Les bonus sont les suivants :\n Éveilleur « Horla » : Dégagement 0/1/2/3 et plus, bonus de 20%/30%/40%/50%\n Roue du Destin SSR « Dernier Vers » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%\n Roue du Destin SR « Fleurs et Poèmes d'Antan » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%\n2. Les Bonus de poèmes de différents Éveilleurs ou Roues du Destin s'additionnent.\n3. À noter que les récompenses du premier passage en difficulté Folie ne sont pas affectées par les Bonus de poèmes.\n\n<Title:Résonance : Élégie du jardin>\n1. Les Gardiens du secret peuvent obtenir « Cœur de cendres » en accomplissant les succès de l'événement.\n2. En consommant « Cœur de cendres », activez « Résonance : Élégie du jardin » pour obtenir les bonus suivants :\n(1) Rendre le Gardien plus fort dans le mode « Jardin d'antan », rendant les défis plus faciles.\n(2) Augmenter la quantité de monnaie d'événement obtenue après avoir terminé « Jardin d'antan ».\n(3) Débloquer le mode « Baiser de la muse ».\n\n<Title:Baiser de la muse>\n Après activation de la résonance « La vie grandit », vous obtenez automatiquement 60 « poésie mélancolique » par heure, avec un maximum de 25 heures stockables.\n Après activation de la résonance « Échanger des poèmes contre des fleurs », « Baiser de la muse » vous donne 60 « Poème de Regret » supplémentaires par heure.\n\n<Title:La serre de Colette>\n1. « La serre de Colette » contient trois jardins, avec les dates d'ouverture suivantes :\n Jardin d'iris : ouverture le 25 août à 9h00.\n Jardin de belladone : ouverture le 27 août à 9h00.\n Roseraie : ouverture le 29 août à 9h00.\n2. Chaque échange consomme 750 unités de « poésie mélancolique » / « Poème de Regret » / « Poème joyeux », et vous obtenez aléatoirement 5 objets parmi les récompenses du jardin.\n3. Les récompenses des jardins sont divisées en deux catégories : « Objet spécial » et « Objet ordinaire ». Lors d'une réinitialisation, la quantité restante d'« Objet spécial » peut être remise à son maximum. Les règles détaillées sont les suivantes :\n(1) Premières 2 réinitialisations : lorsque les « Objet spécial » sont épuisés, le Gardien peut choisir de réinitialiser, ce qui remettra à zéro la quantité restante des « Objet spécial » et des « Objet ordinaire » ; il peut aussi continuer à échanger, et une fois les « Objet ordinaire » épuisés, il devra réinitialiser pour continuer.\n(2) À partir de la 3e réinitialisation : la réinitialisation n'est possible que lorsque les « Objet ordinaire » sont épuisés. La réinitialisation remettra à zéro la quantité restante des « Objet ordinaire », mais pas celle des « Objet spécial ».\n4. Après le 15 septembre à 9h00 (GMT+8), les « Poèmes » non échangés seront automatiquement convertis en « Billet Rose Dorée*40 » à un taux fixe. Veuillez vérifier vos messages.\n\n<Title:Enregistrement de la task force>\n1. Pendant l'événement, l'« Enregistrement de la task force : Demeure de la Rose » sera accessible gratuitement. De nouveaux événements seront disponibles tous les 2 jours. Après avoir terminé « Enregistrement de la task force : Demeure de la Rose », vous pouvez obtenir des récompenses dans les succès, notamment le Cœur d'argent et la Roue du Destin SR exclusive de l'événement « Fleurs et Poèmes d'Antan ». Les Récompenses de succès ne seront disponibles que pendant l'événement, et ne pourront plus être complétées ou réclamées après.\n2. Après l'événement, les progrès dans « Enregistrement de la task force : Demeure de la Rose » seront conservés. Si vous n'avez pas débloqué « Enregistrement de la task force : Demeure de la Rose » pendant l'événement, vous pourrez toujours le débloquer après en consommant 7 « Point de départ réel ».\n3. Quel que soit le moment, après avoir terminé « Enregistrement de la task force : Demeure de la Rose », vous obtenez toujours « Sésame : L'Offrande du printemps »."
  },
  Activity_67721_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_67723_ActivityName = {
    Text = "Événement de confession : Activité de déblocage de remise"
  },
  Activity_67725_ActivityName = {
    Text = "Événement double Affinité"
  },
  Activity_67726_ActivityName = {
    Text = "Berger des Âmes : Réplique"
  },
  Activity_67726_ActivityPlot = {
    Text = "Il a souffert pour vous, porté vos calamités.\nPar sa chair, vous avez été guéris;\nPar sa vie, vous avez été pardonnés."
  },
  Activity_67726_ActivityStageEndContent = {
    Text = "L'événement est terminé. Actuellement, seule la « Vente Caritative du Sanctuaire » est disponible."
  },
  Activity_67726_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, les gardiens pourront collecter la monnaie d'événement « Bon de Vente » via les modes temporaires « Chemin du Sanctuaire », « La Bonté des Citoyens » et les récompenses de succès. Les « Bons de Vente » pourront être échangés contre des objets aléatoires sur place, incluant la roue de destin SR exclusive à l'événement « L'Homme dans le Miroir », des Cœurs Immaculés, des Cœurs Luminiques, etc.\n2. Pendant l'événement, le dossier spécial « La Couleur du Sang » sera accessible gratuitement. En accomplissant les succès de l'événement, vous pourrez obtenir un avatar exclusif « Au Nom de la Clé d'Argent : Salvador » !\n\n<Title:Période de l'événement>\n1. Du 24 mars à 9h00 au 7 avril à 9h00 (GMT+8), toutes les activités seront disponibles.\n2. Du 7 avril à 9h00 au 14 avril à 9h00 (GMT+8), seules les activités « Vente Caritative du Sanctuaire » et les récompenses de succès resteront actives, les autres seront terminées et indisponibles.\n\n<Title:Chemin du Sanctuaire>\n1. « Chemin du Sanctuaire » contient 5 étapes, une nouvelle étape s'ouvrira automatiquement tous les 2 jours.\n2. Chaque tentative consommera 120 points d'endorphine, et en cas de succès, vous obtiendrez la monnaie d'événement « Bon de Vente ».\n3. Une fois un niveau terminé, la fonction « Répétition » de ce niveau sera débloquée. Veuillez noter que vous ne pourrez pas obtenir de taux de synchronisation via la fonction « Répétition ».\n4. Vous pourrez utiliser l'aide de l'association Alumni et l'effet « Résonance : Le Carrefour de l'Âme » pour faciliter votre progression.\n\n<Title:Bonus de Glimmer>\n1. Sous l'effet du « Glimmer de l'Âme », si le gardien possède certains réveilleurs ou roues de destin (pas nécessairement en équipe), il obtiendra un bonus supplémentaire de « Bons de Vente » parmi les récompenses des missions des étapes de « Chemin du Sanctuaire » (y compris la répétition). Le bonus est détaillé comme suit :\n· Réveilleur « Salvador » : Éveil 0/1/2/3 ou supérieur, bonus de 20%/30%/40%/50%.\n· Roue de Destin SSR « Tablette Divine » : Superposition 0/1/2/3 ou supérieure, bonus de 20%/30%/40%/50%.\n· Roue de Destin SR « L'Homme dans le Miroir » : Superposition 0/1/2/3 ou supérieure, bonus de 20%/30%/40%/50%.\n2. Les bonus de « Glimmer » de différents réveilleurs ou roues de destin s'additionnent.\n3. À noter, les récompenses de la première réussite en difficulté folle ne sont pas affectées par le bonus de « Glimmer ».\n\n<Title:Résonance : Le Carrefour de l'Âme>\n1. Les gardiens pourront obtenir « Cœur de Repentir » en accomplissant les succès de l'événement.\n2. En consommant « Cœur de Repentir », vous pourrez activer « Résonance : Le Carrefour de l'Âme » et bénéficier des avantages suivants :\n(1) Rendre le gardien plus puissant dans les modes « Chemin du Sanctuaire » et « Dossier Spécial : La Couleur du Sang », rendant les défis plus faciles.\n(2) Augmenter le taux de synchronisation obtenu après avoir terminé les défis de « Chemin du Sanctuaire ».\n(3) Débloquer le mode « La Bonté des Citoyens ».\n\n<Title:La Bonté des Citoyens>\n1. Après activation de la résonance « Une Méthode Facile », vous obtiendrez automatiquement 60 « Bons de Vente » par heure, avec un maximum de stockage de 25 heures.\n2. Après activation de la résonance « Pénitence, Pénitence », vous obtiendrez automatiquement 1800 « Rose Dorée » supplémentaires par heure.\n\n<Title:Vente Caritative du Sanctuaire>\n1. « Vente Caritative du Sanctuaire » comprend trois stands, disponibles aux dates suivantes :\n· « La Petite Boutique de Madame Grey » : disponible à partir du 24 mars à 9h00.\n· « La Vente Caritative Étonnante de Grand John » : disponible à partir du 27 mars à 9h00.\n· « La Vente Spéciale de Smith » : disponible à partir du 30 mars à 9h00.\n2. Chaque échange consommera 750 « Bons de Vente » et vous obtiendrez aléatoirement 5 objets parmi les récompenses du stand.\n3. Les récompenses des stands sont divisées en deux catégories : « Objets Spéciaux » et « Objets Normaux ». Lors d'une réinitialisation, la quantité restante d'objets spéciaux sera remise à zéro. Les règles détaillées sont les suivantes :\n(1) Premières 2 réinitialisations : lorsque les « Objets Spéciaux » sont épuisés, le gardien peut choisir de réinitialiser, ce qui remettra à zéro la quantité restante des « Objets Spéciaux » et « Objets Normaux » ; il peut aussi continuer à échanger, et une fois les « Objets Normaux » également épuisés, il devra réinitialiser pour continuer.\n(2) À partir de la 3e réinitialisation : la réinitialisation ne sera possible qu'après épuisement des « Objets Normaux ». Elle remettra à zéro la quantité restante des « Objets Normaux », mais pas celle des « Objets Spéciaux ».\n4. Après le 14 avril à 9h00 (GMT+8), les « Bons de Vente » non échangés seront récupérés au taux de « Rose Dorée *40 » par bon. Veuillez vérifier vos messages.\n\n<Title:Dossier Spécial>\n1. Pendant l'événement, le dossier spécial « La Couleur du Sang » sera accessible gratuitement.\n2. Après l'événement, les progrès du dossier « La Couleur du Sang » seront conservés. Si vous ne l'avez pas débloqué pendant l'événement, vous pourrez toujours le débloquer après en consommant 7 « Point de Départ Réel ».\n3. Quel que soit le moment, après avoir terminé le dossier « La Couleur du Sang », vous obtiendrez « Sceau de la Clé : Miracle ».\n\n<Title:Compensation de Réédition>\n1. Les gardiens ayant déjà débloqué « Dossier Spécial : La Couleur du Sang » avant cet événement recevront une compensation de 700 « Bons de Vente » s'ils le redébloquent pendant cette réédition.\n2. Les gardiens ayant déjà obtenu l'avatar exclusif « Au Nom de la Clé d'Argent : Salvador » recevront automatiquement 1 « Invitation des Sans-Visage » à la place s'ils le redébloquent.\n3. Les gardiens ayant déjà obtenu le matériau nécessaire à l'activation de la résonance « Cœur de Repentir » recevront automatiquement 5000 « Rose Dorée » pour chaque unité supplémentaire de « Cœur de Repentir » obtenue.\n"
  },
  Activity_67726_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_67727_ActivityName = {
    Text = "Onde de Désir·Réédition"
  },
  Activity_67727_ActivityPlot = {
    Text = "Les rêves sont la révélation des désirs enfouis. Ceux qui s'y attardent seront piégés par les marées de l'envie, devenant les apôtres de la luxure... à moins que..."
  },
  Activity_67727_ActivityStageEndContent = {
    Text = "L'événement est Terminé. Actuellement, seule «Prolifération du désir» est disponible."
  },
  Activity_67727_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant la durée de l'événement, les Gardiens du secret pourront collecter la monnaie d'événement « Graine mère » via le mode temporaire « Désir chaotique » et les « Récompenses de succès ». « Graine mère » pourra être échangée contre des récompenses dans « Désir de Litière », incluant la Roue du Destin SR exclusive à l'événement « Baiser d'Adieu », des Cœurs de Lumens, des Cœurs Immaculés, des Éclats de Pierre Sage et des Cristaux de Mimesis.\n2. Pendant l'événement, les conditions de participation à « Frénésie de Litière » sont assouplies : il suffit d'avoir terminé le chapitre 2-9·Normal de « Mission d'enquête », et il n'est plus nécessaire de satisfaire aux exigences de taux de synchronisation du Corps éveillé pour débloquer l'événement « Frénésie de Litière ». En outre, la quantité requise de « Point de départ réel » est réduite à seulement 1 !\n3. L'arrivée d'une mystérieuse force semble vous aider à établir une relation plus profonde avec les Corps éveillés : pendant l'événement, tous les taux de synchronisation obtenus par tous les moyens sont doublés !\n\n<Title:Désir chaotique>\n1. « Désir chaotique » comprend 10 étapes de collecte de matériel, sans exploration, uniquement des combats, une étape s'ouvre chaque jour.\n2. Dans ces étapes de collecte de matériel, vous éveillerez directement tous les Corps éveillés et recevrez des Reliques prédéfinies. En outre, après 6 tours, vous recevrez une fois l'aide de Thais.\n3. Chaque défi consomme 120 points de neuropéricine, et en cas de succès, vous obtiendrez des matériaux d'entraînement et la monnaie de l'événement.\n4. Une fois l'étape terminée, la fonction « Recréation » de cette étape est débloquée. Veuillez noter : aucune synchronisation ne peut être obtenue en utilisant la fonction « Recréation ».\n5. Vous pouvez utiliser l'aide des Alumni pour faciliter la réussite de l'étape.\n\n<Title:Bonus de Gourmandise>\n1. Les Gardiens du secret possédant certains Corps éveillés ou Roues du Destin spécifiques (pas nécessairement déployés) peuvent obtenir un bonus supplémentaire sur les « Graines mères » reçues dans les récompenses des étapes de « Désir chaotique » (y compris la recréation). Les bonus spécifiques sont les suivants :\nCorps éveillé « Thais » : Dégagement 0/1/2/3 et plus, bonus de 20%/30%/40%/50%\nRoue du Destin SSR « Élevé dans la Douceur » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%\nRoue du Destin SR « Baiser d'Adieu » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%\n2. Les « Bonus de Gourmandise » de différents Corps éveillés ou Roues du Destin s'additionnent.\n3. À noter toutefois que les récompenses de premier passage en difficulté Fou ne sont pas affectées par les bonus ci-dessus.\n\n<Title:Désir de Litière>\n1. Chaque « Échange de graines » consomme 1000 « Graines mères » et donne aléatoirement cinq objets parmi ceux de « Désir de Litière ».\n3. Les récompenses d'objets de « Désir de Litière » se divisent en deux catégories : « Objet spécial » et « Objets normaux ». Lors d'une réinitialisation, la quantité restante d'objets spéciaux peut être réinitialisée à la limite supérieure. Les règles détaillées sont les suivantes :\n(1) Premières 4 réinitialisations : lorsque les « Objet spécial » sont épuisés, le Gardien peut choisir de réinitialiser, ce qui réinitialisera la quantité restante des « Objet spécial » et des « Objets normaux » à la limite supérieure ; il peut aussi choisir de continuer à échanger. Lorsque les « Objets normaux » sont également épuisés, une réinitialisation est nécessaire pour continuer à échanger.\n(2) À partir de la 5e réinitialisation : la réinitialisation ne peut être effectuée que lorsque les « Objets normaux » sont épuisés. La réinitialisation réinitialisera la quantité restante des « Objets normaux » à la limite supérieure, mais les « Objet spécial » ne seront plus réinitialisés.\n\n<Title:Durée de l'événement>\n1. Du 16 décembre 9h00 au 30 décembre 9h00 (GMT+8), toutes les activités mentionnées dans la présentation de l'événement seront disponibles.\n2. Du 30 décembre 9h00 au 6 janvier 9h00 (GMT+8), seuls « Désir de Litière » et les « Récompenses de succès » resteront actifs, les autres activités seront terminées et indisponibles.\n3. Après le 6 janvier 9h00 (GMT+8), les « Graines mères » restantes non échangées seront récupérées et converties en « Billet Rose Dorée*40 » chacune, veuillez vérifier vos messages."
  },
  Activity_67727_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_67728_ActivityName = {
    Text = "Événement de déblocage gratuit"
  },
  Activity_67729_ActivityName = {
    Text = "Événement de déblocage gratuit"
  },
  Activity_67731_ActivityName = {
    Text = "Banquet brûlant : Récurrence"
  },
  Activity_67731_ActivityPlot = {
    Text = "Isaraou, la ville au bord du lac, serait selon la légende le lieu d'origine de wanda.\nCette fois, vous passerez par la porte des rêves, atteignant ce vieux groupe de tours recouvertes de cloches"
  },
  Activity_67731_ActivityStageEndContent = {
    Text = "Événement terminé, participation uniquement à « Le trésor de Wanda »"
  },
  Activity_67731_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, le gardien peut collecter des devises d'événement « Os Tibia », « Coquille à feuilles rondes » et « Spirale des Ruines » via les modes limités « Fête Brûlante » et « Récompenses de succès ». Les devises d'événement peuvent être utilisées pour acheter des articles dans « La Boîte aux Trésors de Wanda », y compris la roue du destin SR limitée à l'événement « Le regard d'Isarau », Cœur de Lumens, Cœur Immaculé, etc. \n2. Pendant l'événement, « Plongée dans l'inconscient : Fête Brûlante » est déverrouillée gratuitement pour une durée limitée, et en complétant les succès de l'événement, on peut obtenir le portrait limité à l'événement « Au nom de la Clé d'Argent : Wanda » !\n\n<Title:Durée de l'événement>\n1. Du 23 septembre à 9h00 au 7 octobre à 9h00 (GMT+8), tous les modes d'événement sont accessibles. \n2. Du 7 octobre à 9h00 au 14 octobre à 9h00 (GMT+8), seuls « La Boîte aux Trésors de Wanda » et les récompenses de succès sont accessibles. \n\n<Title:Ville du lac>\n1. La « Ville du lac » comporte 7 niveaux, un niveau s'ouvre automatiquement chaque jour. \n2. Chaque défi consomme « Ménophine » × 120, et un défi réussi rapportera des devises d'événement. \n3. Après avoir terminé un niveau, la fonction « Reproduire » pour ce niveau sera déverrouillée. Veuillez noter : en utilisant la fonction « Reproduire », il n'est pas possible d'obtenir le taux de synchronisation. \n4. Vous pouvez utiliser l'assistance de l'association d'anciens élèves et « Résonance : Ordre secret » pour vous aider à passer les niveaux plus facilement. \n\n<Title:Bonus spécial>\n1. Si le gardien possède un Éveilleur ou une roue du destin spécifique (aucune exigence de déploiement), cela peut augmenter le montant des devises d'événement obtenues en accomplissant des tâches dans les niveaux de « Ville du lac », les bonus spécifiques sont les suivants :\n· Éveilleur « Wanda » : Dégagement 0/1/2/3 et plus, bonus 20%/30%/40%/50%.\n· SSR roue du destin « Ordre de la Reine » : Superposition 0/1/2/3 et plus, bonus 20%/30%/40%/50%.\n· SR roue du destin « Le regard d'Isarau » : Superposition 0/1/2/3 et plus, bonus 20%/30%/40%/50%.\n2. Les « Bonus spéciaux » de différents Éveilleurs ou roues du destin sont calculés de manière cumulative. \n3. Notamment, les récompenses de défi de difficulté Folie ne seront pas affectées par les « Bonus spéciaux ».\n\n<Title:Résonance : Ordre secret>\n1. Le gardien peut obtenir « Cœur de plaisir » en accomplissant les succès de l'événement. \n2. En dépensant « Cœur de plaisir », activer « Résonance : Ordre secret » permettra au gardien de devenir plus fort dans « Ville du lac », rendant les défis plus faciles ; cela permettra également au gardien d'obtenir des devises d'événement supplémentaires lors de la réussite des niveaux. \n\n<Title:Plongée dans l'inconscient>\n1. Pendant l'événement, « Fête Brûlante » peut être déverrouillée gratuitement. \n2. Après la fin de l'événement, le progrès d'enquête de « Fête Brûlante » sera conservé, et les récompenses d'enquête correspondant à celles de la période de l'événement seront également obtenues en complétant les événements d'enquête non terminés pendant l'événement. Si « Fête Brûlante » n'a pas été déverrouillée pendant l'événement, elle peut toujours être déverrouillée après la fin de l'événement en dépensant « Point de départ réel » ×3. \n3. Que ce soit pendant ou après l'événement, en terminant « Fête Brûlante », le gardien recevra « Décret Clé : Festin pourri ». \n\n<Title:Compensation de réédition>\n1. Les gardiens qui ont déjà déverrouillé « Plongée dans l'inconscient : Fête Brûlante » recevront une compensation de « Os Tibia » ×300 lors du déverrouillage de cette réédition. \n2. Les gardiens qui ont déjà obtenu le portrait limité « Au nom de la Clé d'Argent : Wanda » recevront automatiquement en compensation « Os Tibia » ×2000 lors de la répétition. \n3. Les gardiens qui ont déjà obtenu le matériau d'activation de résonance « Cœur de plaisir », chaque « Cœur de plaisir » supplémentaire obtenu sera automatiquement converti en « Billet Rose Dorée » ×5000. \n"
  },
  Activity_67731_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_67732_ActivityName = {
    Text = "Manuel du détective · Rétro"
  },
  Activity_67732_ActivityPlot = {
    Text = "Ces pages renferment les enseignements aiguisés d'un maître détective, forgés au fil d'une vie entière consacrée à la résolution de mystères.\nUn guide conçu pour éveiller l'intuition et affûter l'intellect des enquêteurs en herbe."
  },
  Activity_67732_ActivityStageEndContent = {
    Text = "L'événement est terminé. Actuellement, seul \"Club de Bonne Chance\" est disponible."
  },
  Activity_67732_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, le Gardien peut collecter la monnaie de l'événement « Jetons décisifs » à travers les modes de jeu temporaires « Légende de la nuit lunaire » et « Récompenses de succès ». Les « Jetons décisifs » peuvent être échangés contre de généreuses récompenses dans le « Club de la Chance », y compris la Roue du Destin SR exclusive à l'événement « Roulette du Destin », le Cœur Immaculé, le Cœur de Lumens, les Éclats de Pierre Sage, le Cristal de Mimesis, etc. \n2. Pendant l'événement, accomplir les missions des « Récompenses de succès » permet d'obtenir l'avatar exclusif à l'événement « Au nom de la Clé d'Argent : Ryker », la Roue du Destin SR « Roulette du Destin », le Cœur d'argent et une grande quantité de monnaie de l'événement « Jetons décisifs ». \n3. Pendant l'événement, « Enregistrement de la task force : Bonne chasse ! » sera ouvert gratuitement. \n\n<Title: Temps de l'événement>\n1. Du 12 août à 9h00 au 26 août à 9h00 (GMT+8), tous les contenus de l'événement sont accessibles. \n2. Du 26 août à 9h00 au 2 septembre à 9h00 (GMT+8), seul le « Club de la Chance » et les « Récompenses de succès » resteront, les autres contenus seront terminés et non accessibles. \n\n<Title: Légende de la nuit lunaire>\n1. « Légende de la nuit lunaire » comprend 9 niveaux, un niveau s'ouvrant automatiquement chaque jour. \n2. Chaque défi consommera « Ménophine » × 120. En défiant différents niveaux, en plus d'obtenir différents matériaux, vous obtiendrez la monnaie de l'événement « Jetons décisifs ». \n3. Les niveaux de cet événement sont des niveaux de combat direct, et peuvent être reproduits après avoir été terminés ! Chaque « reproduction » consommera « Ménophine » × 120. \n4. Veuillez noter : lors de l'utilisation de la fonction « reproduction », le taux de synchronisation ne sera pas obtenu. \n\n<Title: Bonus de jetons>\n1. Le Gardien possédant un certain Éveilleur ou une Roue (non requis pour être en ligne) peut faire en sorte que les « Jetons décisifs » des missions de niveau « Légende de la nuit lunaire » reçoivent un bonus de chute supplémentaire (y compris pour la reproduction), les bonus spécifiques sont les suivants : \n· Éveilleur « Ryker » : Dégagement 0/1/2/3 et plus, bonus de 20%/30%/40%/50% \n· Roue SSR « Moment Propice » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50% \n· Roue SR « Roulette du Destin » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50% \n2. Les « Bonus de jetons » des différents Éveilleurs ou Roues seront calculés de manière cumulée. \n3. En particulier, les récompenses de défi de difficulté Folie ne seront pas affectées par les « Bonus de jetons ». \n\n<Title: Club de la Chance>\n1. Le « Club de la Chance » sera ouvert uniquement du 12 août à 9h00 au 2 septembre à 9h00 (GMT+8). \n2. Après le 2 septembre à 9h00 (GMT+8), les « Jetons décisifs » non échangés restants seront récupérés à un taux de 40 « Billet Rose Dorée » par échange, veuillez vérifier vos emails, Gardien. \n\n<Title: Enregistrement de la task force>\n1. Dans « Enregistrement de la task force : Bonne chasse ! », le Gardien utilisera une escouade spéciale comprenant le personnage préétabli « Ryker » pour relever des défis. \n2. Terminer « Enregistrement de la task force : Bonne chasse ! » permettra d'obtenir un nouveau Décret Clé « Décret Clé : Un coup de feu »."
  },
  Activity_67732_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_67733_ActivityName = {
    Text = "Sacrifice Abysse : Rejouer"
  },
  Activity_67733_ActivityPlot = {
    Text = "Sur le reflet de l'océan profond, le rêve de son Roi se dissipe, et le Royaume Divin se décompose.\nElle émerge de rêves anciens, foulant les ruines d'un avenir en effondrement.\nElle interroge les Abysses en spirale, mais les Abysses en spirale restent silencieuses.\nElle offre des sacrifices aux Abysses en spirale, pour n'entendre que son propre écho."
  },
  Activity_67733_ActivityStageEndContent = {
    Text = "Événement terminé, participation actuelle uniquement à «Réponse de l'abîme»"
  },
  Activity_67733_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, les Gardiens du secret pourront collecter la monnaie de l'événement grâce aux modes limités « Naissance du Royaume Divin », « Souverain Décret » et « Récompenses de succès ». Cette monnaie pourra être utilisée dans « Réponse de l'Abyss » pour accomplir des offrandes et obtenir des récompenses sous forme d'objets, notamment la Roue du Destin SR exclusive à l'événement « L'Appel du Fond Marin », des Pierre philosophale, des Cœur Immaculé, des Cœur de Lumens, etc.\n2. Pendant l'événement, « Monde des Rêves Étranges : Profanation » sera accessible gratuitement. En accomplissant les succès de l'événement, vous pourrez également obtenir le portrait exclusif à l'événement « Au nom de la Clé d'argent : Miryam » !\n\n<Title:Période de l'événement>\n1. Du 28 juillet à 9h00 au 18 août à 9h00 (GMT+8), toutes les activités seront accessibles.\n2. Du 18 août à 9h00 au 25 août à 9h00 (GMT+8), seules « Réponse de l'Abyss » et « Récompenses de succès » resteront disponibles, les autres contenus seront clos et inaccessibles.\n\n<Title:Naissance du Royaume Divin>\n1. « Naissance du Royaume Divin » comprend 5 niveaux, un nouveau niveau s'ouvrira tous les 2 jours.\n2. Chaque défi consommera 120 points de morphine, et la réussite du défi permettra d'obtenir la monnaie de l'événement.\n3. Une fois un niveau terminé, la fonction « Récurrence » de ce niveau sera débloquée. Veuillez noter : lors de l'utilisation de la fonction « Récurrence », aucun taux de synchronisation ne pourra être obtenu.\n4. Vous pouvez utiliser l'aide des Alumni et de « Résonance : Fête de la Mer » pour faciliter la réussite des niveaux.\n\n<Title:Bonus des offrandes rituelles>\n1. Lorsque le Gardien possède un certain Corps éveillé ou une certaine Roue du Destin (non nécessairement déployée), les « Larmes du Sacrificateur », « Sang du Sacrificateur » et « Médula Sacrificielle » obtenus dans les récompenses des missions des niveaux « Naissance du Royaume Divin » bénéficieront d'un bonus supplémentaire (y compris lors de la récurrence). Les détails sont les suivants :\nCorps éveillé « Miryam » : Dégagement à 0/1/2/3 ou plus, bonus de 20%/30%/40%/50%\nRoue du Destin SSR « Force de la Dévotion » : Superposition à 0/1/2/3 ou plus, bonus de 20%/30%/40%/50%\nRoue du Destin SR « L'Appel du Fond Marin » : Superposition à 0/1/2/3 ou plus, bonus de 20%/30%/40%/50%\n2. Les bonus des offrandes rituelles provenant de différents Corps éveillés ou Roues du Destin s'additionnent.\n3. À noter toutefois, les récompenses de la première réussite en difficulté Fou ne sont pas affectées par les bonus des offrandes rituelles.\n\n<Title:Résonance : Fête de la Mer>\n1. Les Gardiens peuvent obtenir « Cœur de piété » en accomplissant les succès de l'événement.\n2. En consommant « Cœur de piété », activez « Résonance : Fête de la Mer » pour obtenir les bonus suivants :\n(1) Rendre le Gardien plus puissant dans le mode événement « Naissance du Royaume Divin », rendant les défis plus faciles.\n(2) Augmenter la quantité de monnaie de l'événement obtenue après avoir accompli les défis de « Naissance du Royaume Divin ».\n(3) Débloquer le mode événement « Souverain Décret ».\n\n<Title:Bonus des offrandes rituelles>\nAprès activation de la résonance « Épreuve de sacrifice », vous obtenez automatiquement 60 « Larmes du Sacrificateur » par heure, avec un maximum de stockage de 25 heures.\n\n<Title:Réponse de l'Abyss>\n1. « Réponse de l'Abyss » comporte trois autels, avec les dates d'ouverture suivantes :\n« Autel des Larmes Cristallines » : du 28 juillet à 9h00 au 25 août à 9h00.\n« Autel du Sang Écarlate » : du 30 juillet à 9h00 au 25 août à 9h00.\n« Autel de la Médula Spirituelle » : du 1er août à 9h00 au 25 août à 9h00.\n2. Chaque offrande consommera 1000 unités de « Larmes du Sacrificateur » / « Sang du Sacrificateur » / « Médula Sacrificielle », et offrira aléatoirement l'une des cinq récompenses parmi celles disponibles sur l'autel.\n3. Les récompenses des autels sont divisées en deux catégories : « Objet spécial » et « Objet ordinaire ». Une réinitialisation permet de restaurer la quantité disponible des récompenses jusqu'à la limite maximale. Les règles détaillées sont les suivantes :\n(1) Premières 3 réinitialisations : lorsque les « Objet spécial » sont épuisés, le Gardien peut choisir de réinitialiser, ce qui restaurera la quantité disponible des « Objet spécial » et des « Objet ordinaire » jusqu'à la limite maximale ; il peut aussi choisir de continuer à faire des offrandes. Lorsque les « Objet ordinaire » sont également épuisés, une réinitialisation sera nécessaire pour continuer à faire des offrandes.\n(2) À partir de la 4e réinitialisation : la réinitialisation ne sera possible qu'après épuisement des « Objet ordinaire ». Cette réinitialisation restaurera la quantité disponible des « Objet ordinaire » jusqu'à la limite maximale, mais les « Objet spécial » ne seront plus restaurés.\n\n<Title:Monde des Rêves Étranges>\n1. Pendant l'événement, « Monde des Rêves Étranges : Profanation » sera accessible gratuitement.\n2. À la fin de l'événement, les progrès dans « Monde des Rêves Étranges : Profanation » seront conservés. Si vous ne l'avez pas débloqué pendant l'événement, vous pourrez toujours le débloquer après l'événement en consommant 7 « Point de départ réel ».\n3. Quel que soit le moment où vous le terminez, vous obtiendrez « Sceau : Fête de la Mer » après avoir terminé « Monde des Rêves Étranges : Profanation ».\n\n<Title:Compensation pour la réédition>\n1. Les Gardiens ayant déjà débloqué « Monde des Rêves Étranges : Profanation » avant cette réédition recevront une compensation de 700 « Larmes du Sacrificateur » s'ils le débloquent à nouveau pendant cette réédition.\n2. Les Gardiens ayant déjà obtenu le portrait exclusif à l'événement « Au nom de la Clé d'argent : Miryam » verront les doublons automatiquement convertis en 1 « Invitation de l'Incorporel ».\n3. Les Gardiens ayant déjà obtenu le matériau nécessaire à l'activation de la résonance « Cœur de piété » verront chaque unité supplémentaire obtenue automatiquement convertie en 5000 « Billet Rose Dorée ».\n"
  },
  Activity_67733_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_67734_ActivityName = {
    Text = "Symphonie Intangible · Reproduction"
  },
  Activity_67734_ActivityPlot = {
    Text = "La symphonie est un art de tissage, où les trajectoires des instruments se croisent pour former une carte complexe.\nDans son réseau, chaque note a son rôle.\nÉcoutez, une symphonie exceptionnelle commence"
  },
  Activity_67734_ActivityStageEndContent = {
    Text = "Événement terminé, participation actuelle uniquement à «Palais du sommeil»"
  },
  Activity_67734_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, le gardien du secret peut collecter la monnaie de l'événement « Chant héroïque » à travers les modes de jeu à durée limitée « Son tonnant » et « Récompenses de succès ». « Chant héroïque » peut être échangé contre de généreuses récompenses dans le « Palais du Sommeil », y compris la roue SR limitée à l'événement « Présentation qui ne s'arrête jamais », « Cœur Immaculé », « Cœur de Lumens », « Éclats de Pierre Sage », « Cristal de Mimesis », etc. \n2. Pendant l'événement, en complétant les missions de « Récompenses de succès », vous pouvez obtenir l'avatar limité à l'événement « Au nom de la Clé d'Argent : Hamelin », la roue SR limitée à l'événement « Présentation qui ne s'arrête jamais », Cœur d'argent et une grande quantité de monnaie de l'événement « Chant héroïque ».\n\n<Title:Temps de l'événement>\n1. Du 9 septembre à 9h00 au 23 septembre à 9h00 (GMT+8), tous les contenus de l'événement sont disponibles. \n2. Du 23 septembre à 9h00 au 30 septembre à 9h00 (GMT+8), seuls le « Palais du Sommeil » et les « Récompenses de succès » seront maintenus, les autres contenus seront terminés et ne seront plus disponibles. \n\n<Title: Son tonnant>\n1. « Son tonnant » comprend 9 niveaux, un niveau s'ouvre automatiquement chaque jour. \n2. Chaque défi consommera « Ménophine » × 120. En défiant différents niveaux, en plus d'obtenir différents matériaux, vous obtiendrez également la monnaie de l'événement « Chant héroïque ». \n3. Les niveaux de cet événement sont des niveaux de combat direct, et peuvent être reproduits après avoir été terminés ! Chaque « reproduction » consommera « Ménophine » × 120. \n4. Veuillez noter : en utilisant la fonction « reproduction », le taux de synchronisation ne pourra pas être obtenu. \n\n<Title: Bonus de chapitre>\n1. Le gardien du secret possédant des éveilleurs ou des roues spécifiques (sans exigence d'être en équipe) peut faire en sorte que la monnaie « Chant héroïque » dans les récompenses des missions de « Son tonnant » obtienne un bonus de chute supplémentaire (y compris la reproduction), les bonus spécifiques sont les suivants : \n· Éveilleur « Hamelin » : Dégagement 0/1/2/3 et plus, bonus de 20%/30%/40%/50% \n· Roue SSR « Requiem Éternel » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50% \n· Roue SR « Présentation qui ne s'arrête jamais » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50% \n2. Les « Bonus de chapitre » des différents éveilleurs ou roues seront calculés de manière cumulée. \n3. En particulier, les récompenses des défis de première passe en difficulté Folie ne seront pas affectées par les « Bonus de chapitre ». \n\n<Title: Palais du Sommeil>\n1. Le « Palais du Sommeil » sera ouvert uniquement du 9 septembre à 9h00 au 30 septembre à 9h00 (GMT+8). \n2. Après le 30 septembre à 9h00 (GMT+8), les « Chant héroïque » non échangés restants seront récupérés au taux de « Billet Rose Dorée » × 40 par unité échangée. Veuillez vérifier votre courrier, gardien du secret."
  },
  Activity_67734_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_67735_ActivityName = {
    Text = "Onde de Désir·Réédition"
  },
  Activity_67735_ActivityPlot = {
    Text = "Les rêves sont la révélation des désirs enfouis. Ceux qui s'y attardent seront piégés par les marées de l'envie, devenant les apôtres de la luxure... à moins que..."
  },
  Activity_67735_ActivityStageEndContent = {
    Text = "L'événement est Terminé. Actuellement, seule «Prolifération du désir» est disponible."
  },
  Activity_67735_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant la durée de l'événement, le gardien pourra collecter la monnaie d'événement « Cœur de Fertilité » via le mode temporaire « Désir chaotique » et les « Récompenses de succès ». « Cœur de Fertilité » pourra être échangée contre des récompenses dans « Prolifération du désir », incluant la roue du destin SR exclusive à l'événement « Baiser d'Adieu », des Cœur de Lumens, des Cœur Immaculé, des Éclats de Pierre Sage et des Cristal de Mimesis. \n2. Pendant l'événement, les conditions requises pour participer à « Fureur de procréation » sont assouplies : il suffit d'avoir terminé le Scénario principal : 1–2 : Normal, et il n'est plus nécessaire de satisfaire aux exigences de taux de synchronisation avec l'Éveilleur pour débloquer l'événement « Fureur de procréation ». En outre, la quantité requise de « Point de départ réel » est réduite à seulement 1 !\n3. L'arrivée d'une mystérieuse force semble vous aider à établir une relation plus profonde avec les Éveilleurs. Pendant l'événement, le taux de synchronisation obtenu par tous les moyens est doublé !\n\n<Title:Désir chaotique>\n1. « Désir chaotique » comprend 10 étapes de matériau où il n'est pas nécessaire d'explorer, uniquement des combats, une étape s'ouvrant chaque jour.\n2. Dans ces étapes de matériau, tous les Éveilleurs seront réveillés et équipés de Reliques prédéfinies. En outre, après 6 tours, vous recevrez une fois l'aide de Thais.\n3. Chaque défi consomme 120 points de Ménophine. En cas de succès du défi, vous obtiendrez des matériaux et la monnaie de l'événement.\n4. Une fois l'étape terminée, la fonction « Reproduire » de cette étape est débloquée. Veuillez noter : lors de l'utilisation de la fonction « Reproduire », aucune synchronisation ne peut être obtenue.\n5. Vous pouvez utiliser l'Assistance au combat pour faciliter la réussite des étapes.\n\n<Title:Bonus de cupidité>\n1. Si le gardien possède certains Éveilleurs ou roues du destin spécifiques (pas nécessairement déployés), il obtiendra un bonus supplémentaire sur les « Cœur de Fertilité » reçues dans les récompenses des missions des étapes de « Désir chaotique » (incluant la reproduction). Les bonus spécifiques sont les suivants :\n· Éveilleur « Thais » : Dégagement 0/1/2/3 et au–delà, bonus de 20%/30%/40%/50%\n· Roue du destin SSR « Élevé dans la Douceur » : Superposition 0/1/2/3 et au–delà, bonus de 20%/30%/40%/50%\n· Roue du destin SR « Baiser d'Adieu » : Superposition 0/1/2/3 et au–delà, bonus de 20%/30%/40%/50%\n2. Les « Bonus de cupidité » de différents Éveilleurs ou roues du destin s'additionnent.\n3. À noter toutefois que les récompenses de premier passage en difficulté Fou ne sont pas affectées par les bonus mentionnés ci–dessus.\n\n<Title:Prolifération du désir>\n1. Chaque « Échange de noyau de graine » consomme 750 « Cœur de Fertilité » et donne aléatoirement cinq objets parmi ceux disponibles dans « Prolifération du désir ».\n3. Les récompenses d'objets dans « Prolifération du désir » se divisent en deux catégories : « Objet spécial » et « Objet ordinaire ». Lors d'une réinitialisation, il est possible de réinitialiser la quantité restante des « Objets spéciaux » jusqu'à la limite supérieure. Les règles spécifiques sont les suivantes :\n(1) Premières 4 réinitialisations : lorsque les « Objets spéciaux » n'ont plus de quantité disponible, le gardien peut choisir de réinitialiser. Après réinitialisation, la quantité restante des « Objets spéciaux » et des « Objets ordinaires » est réinitialisée à la limite supérieure ; il peut aussi choisir de continuer à échanger, et une fois que les « Objets ordinaires » n'ont plus de quantité disponible, il faudra effectuer une réinitialisation pour continuer les échanges.\n(2) À partir de la 5e réinitialisation et au–delà : il est possible de réinitialiser uniquement lorsque les « Objets ordinaires » n'ont plus de quantité disponible. La réinitialisation rétablit la quantité restante des « Objets ordinaires » à la limite supérieure, mais les « Objets spéciaux » ne sont plus réinitialisés.\n\n<Title:Période de l'événement>\n1. Du 15 décembre 9h00 au 29 décembre 9h00 (GMT+8), tous les contenus mentionnés dans la présentation de l'événement seront disponibles.\n2. Du 29 décembre 9h00 au 5 janvier 9h00 (GMT+8), seuls « Prolifération du désir » et « Récompenses de succès » resteront disponibles, les autres contenus seront terminés et ne seront plus accessibles.\n3. Après le 5 janvier 9h00 (GMT+8), les « Cœur de Fertilité » restantes non échangées seront récupérées et converties en « Billet Rose Dorée *40 » chacune. Veuillez vérifier vos messages."
  },
  Activity_67735_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_67736_ActivityName = {
    Text = "Événement de déblocage gratuit"
  },
  Activity_67737_ActivityName = {
    Text = "Événement de déblocage gratuit"
  },
  Activity_67738_ActivityName = {
    Text = "Événement double Affinité"
  },
  Activity_67739_ActivityName = {
    Text = "Événement de déblocage gratuit"
  },
  Activity_67741_ActivityName = {
    Text = "Magie de l'histoire · Répétition"
  },
  Activity_67741_ActivityPlot = {
    Text = "La mission donnée par poupée n'est jamais simple. \nMême si elle rappelle à plusieurs reprises aux gens de « s'amuser », comment les gardiens peuvent-ils ne pas être nerveux en emmenant un groupe de réveilleurs pour la première fois ? \nMais, n'oublie pas de « t'amuser », d'accord ?"
  },
  Activity_67741_ActivityStageEndContent = {
    Text = "L'événement est terminé. Actuellement, seule la « Boutique de Scripts Magiques » est disponible."
  },
  Activity_67741_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. L'événement « La magie de l'histoire » est de retour avec une ouverture limitée dans le temps. Les Gardiens du secret peuvent obtenir à nouveau la Roue du Destin exclusive de l'événement « Magie de l'Argentique » et l'avatar exclusif « Au nom de la Clé d'argent : Lily » via le « Magasin de grimoires » et les « Récompenses de succès » !\n2. Pendant l'événement, le « Enregistrement de la task force : La magie de l'histoire » sera déverrouillé gratuitement pendant une durée limitée.\n\n<Title:Scénario mystérieux>\n1. « Scénario mystérieux » contient 9 niveaux de matériaux, un niveau s'ouvre automatiquement chaque jour.\n2. Chaque défi consomme 120 points d'endorphines, et en cas de succès, vous obtenez la monnaie de l'événement.\n3. Une fois un niveau terminé, la fonction « Répétition » de ce niveau est débloquée. Veuillez noter : vous ne pouvez pas obtenir de taux de synchronisation en utilisant la fonction « Répétition ».\n4. Vous pouvez utiliser l'aide des Alumni et « Résonance : valeur de phase du réalisateur » pour vous aider à franchir les niveaux plus facilement.\n\n<Title:Bonus d'inspiration>\n1. Lorsque le Gardien possède un certain Corps éveillé ou une certaine Roue du Destin (pas nécessairement en jeu), il peut obtenir un bonus supplémentaire sur les « Inspiration errante » obtenues dans les récompenses des missions des niveaux « Scénario mystérieux » (y compris la répétition). Les bonus spécifiques sont les suivants :\nCorps éveillé « Lily » : Dégagement 0/1/2/3 ou supérieur, bonus de 20%/30%/40%/50%\nRoue du Destin SSR « Au Travers de la Douleur » : Superposition 0/1/2/3 ou supérieure, bonus de 20%/30%/40%/50%\nRoue du Destin SR « Magie de l'Argentique » : Superposition 0/1/2/3 ou supérieure, bonus de 20%/30%/40%/50%\n2. Les bonus d'« Inspiration » provenant de différents Corps éveillés ou Roues du Destin s'additionnent.\n3. À noter toutefois : les récompenses de la première réussite en difficulté Fou ne sont pas affectées par les bonus mentionnés ci-dessus.\n\n<Title:Résonance : valeur de phase du réalisateur>\n1. Les Gardiens du secret peuvent obtenir « Cœur de l'interprétation » en accomplissant les succès de l'événement.\n2. En consommant « Cœur de l'interprétation », activez « Résonance : valeur de phase du réalisateur », ce qui rendra le Gardien plus fort dans les modes « Scénario mystérieux » et « Enregistrement de la task force : La magie de l'histoire » de cet événement.\n\n<Title:Compensation de la réédition>\n1. Les Gardiens du secret ayant déjà débloqué le « Enregistrement de la task force : La magie de l'histoire » précédemment recevront une compensation de 700 « Inspiration errante » lorsqu'ils le redébloquent pendant cette réédition.\nLes Gardiens du secret ayant déjà obtenu l'avatar exclusif « Au nom de la Clé d'argent : Lily » recevront automatiquement 2000 « Inspiration errante » à la place s'ils le récupèrent à nouveau.\nLes Gardiens du secret ayant déjà obtenu le matériau d'activation de résonance « Cœur de l'interprétation », chaque unité supplémentaire de « Cœur de l'interprétation » sera automatiquement convertie en 5000 « Billet Rose Dorée ».\n\n<Title:Période de l'événement>\n1. Du 13 janvier 9h00 au 27 janvier 9h00 (GMT+8), toutes les contenus mentionnés dans la présentation de l'événement seront disponibles.\n2. Du 27 janvier 9h00 au 3 février 9h00 (GMT+8), seuls le « Magasin de grimoires » et les « Récompenses de succès » resteront disponibles, les autres contenus seront terminés et indisponibles.\n3. Après le 3 février 9h00 (GMT+8), les « Inspiration errante » non échangées seront récupérées au taux de 40 « Billet Rose Dorée » par unité. Veuillez vérifier vos messages."
  },
  Activity_67741_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_67742_ActivityName = {
    Text = "Avec le Tome de la Rose · Réédition"
  },
  Activity_67742_ActivityPlot = {
    Text = "De somptueux diamants dorés, des perles éblouissantes...\nD'innombrables ornements extravagants lui donnaient l'illusion d'être une impératrice.\nÀ présent, elle est déterminée à préserver cette illusion pour toujours."
  },
  Activity_67742_ActivityStageEndContent = {
    Text = "L'événement est terminé. Actuellement, seule la « Célébration Dorée et Rouge » est disponible."
  },
  Activity_67742_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, les Gardiens du secret peuvent collecter la monnaie d'événement « éventails de plumes spirituelles » grâce au mode temporaire « Souvenirs de la Rose » et aux « Récompenses de réalisations ». Les « éventails de plumes spirituelles » peuvent être échangés contre des récompenses généreuses dans le « Festival doré et écarlate », y compris la Roue du Destin SR exclusive à l'événement « Un Million de Regards Aimants », des Cœur Immaculé, des Cœur de Lumens, des Éclats de Pierre Sage et des Cristal de Mimesis.\n2. Pendant l'événement, en accomplissant les tâches des « Récompenses de réalisations », vous pourrez obtenir un avatar exclusif à l'événement « Au nom de la Clé d'argent : Sorel », une Roue du Destin SR exclusive à l'événement « Un Million de Regards Aimants », des Cœur d'argent et une grande quantité de monnaie d'événement « éventails de plumes spirituelles ».\n3. Pendant l'événement, l'« Enregistrement de la task force : Éloge de la Rose » sera ouvert gratuitement.\n\n<Title:Souvenirs de la Rose>\n1. « Souvenirs de la Rose » comprend 9 niveaux, un nouveau niveau s'ouvre automatiquement chaque jour.\n2. Chaque défi consomme 120 points de morphine. En défiant différents niveaux, vous obtiendrez non seulement des matériaux différents, mais aussi la monnaie d'événement « éventails de plumes spirituelles ».\n3. Une fois le niveau terminé, la fonction « Répétition » de ce niveau sera débloquée. Veuillez noter : vous ne pouvez pas obtenir de taux de synchronisation en utilisant la fonction « Répétition ».\n4. Vous pouvez utiliser l'aide des Alumni pour faciliter le passage du niveau.\n\n<Title:Bonus d'éventail>\n1. Lorsque le Gardien possède un certain Corps éveillé ou une certaine Roue du Destin (pas nécessairement déployé), il obtiendra un bonus supplémentaire sur les « éventails de plumes spirituelles » reçus en récompense des missions des niveaux de « Souvenirs de la Rose » (y compris la répétition). Voici les détails des bonus :\nCorps éveillé « Sorel » : Dégagement 0/1/2/3 ou plus, bonus de 20%/30%/40%/50%\nRoue du Destin SSR « Au nom de la Rose » : Superposition 0/1/2/3 ou plus, bonus de 20%/30%/40%/50%\nRoue du Destin SR « Un Million de Regards Aimants » : Superposition 0/1/2/3 ou plus, bonus de 20%/30%/40%/50%\n2. Les bonus d'« éventail » de différents Corps éveillés ou Roues du Destin s'additionnent.\n3. En particulier, les récompenses de la première réussite en difficulté Fou ne sont pas affectées par les bonus ci-dessus.\n\n<Title:Indemnisation de la réédition>\n1. Pendant l'événement, les Gardiens du secret qui ont déjà débloqué l'« Enregistrement de la task force : Éloge de la Rose » auparavant recevront une compensation de « éventails de plumes spirituelles » *700 s'ils le débloquent à nouveau.\nLes Gardiens du secret qui ont déjà obtenu l'avatar exclusif à l'événement « Au nom de la Clé d'argent : Sorel » recevront automatiquement une compensation de « éventails de plumes spirituelles » *2000 s'ils le reçoivent à nouveau.\n\n<Title:Période de l'événement>\n1. Du 27 janvier 9h00 au 10 février 9h00 (GMT+8), toutes les activités sont disponibles.\n2. Du 10 février 9h00 au 17 février 9h00 (GMT+8), seules les activités « Festival doré et écarlate » et « Récompenses de réalisations » restent disponibles, les autres sont terminées et ne sont plus accessibles.\n3. Après le 17 février 9h00 (GMT+8), les « éventails de plumes spirituelles » restants non échangés seront récupérés au taux de « Billet Rose Dorée *40 » par unité, veuillez vérifier vos e-mails."
  },
  Activity_67742_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_67743_ActivityName = {
    Text = "Événement de déblocage gratuit"
  },
  Activity_67744_ActivityName = {
    Text = "Événement de déblocage gratuit"
  },
  Activity_67744_ActivityPlot = {
    Text = "Mesdames et messieurs,\nLa douce nuit a commencé, alors préparez vos boissons raffinées.\nC'est une longue histoire ; racontons–la lentement..."
  },
  Activity_67745_ActivityName = {
    Text = "Au moment de la fonte de la montagne de neige · Répétition"
  },
  Activity_67745_ActivityPlot = {
    Text = ": La neige d'Elworth ne fond jamais, tout comme sa haine. \nLorsque le futur et le passé s'entrelacent, le guerrier brandira sa lame, lançant une charge de vengeance contre le destin. \nQuand elle fait face aux vagues noires, tu es son étendard"
  },
  Activity_67745_ActivityStageEndContent = {
    Text = "Événement terminé, participation actuelle uniquement à «Gueule de la montagne»"
  },
  Activity_67745_ActivityTips = {
    Text = "<Title:Présentation de l'activité>\n1, Pendant l'activité, les Gardiens du secret peuvent collecter trois types de «Boutons de fleur» via le mode de jeu limité «Ambition de la Bête» et les «Récompenses de succès». Les «Boutons de fleur» peuvent être échangés dans la «Gueule de la montagne» contre des récompenses d'objets, notamment la Roue du Destin SR limitée «Jusqu'aux Dernières Neiges», le «Cœur Immaculé», le «Cœur de Lumens», les «Éclats de Pierre Sage», le «Cristal de Mimesis», etc.\n2, Pendant l'activité, l'«Enregistrement de la task force : Le Retour de Elvworth» sera disponible gratuitement.\n\n<Title:Durée de l'activité>\n1, Du 13 juillet 9:00 au 10 août 9:00(GMT+8), tous les contenus de l'activité sont accessibles.\n2, Du 10 août 9:00 au 17 août 9:00(GMT+8), seuls la «Gueule de la montagne» et les «Récompenses de succès» sont conservés ; les autres contenus sont Terminés et ne peuvent plus être participés.\n\n<Title: Ambition de la Bête>\n1, «Ambition de la Bête» contient 5 Niveaux, avec 1 nouveau Niveau débloqué automatiquement tous les 2 jours.\n2, Chaque tentative consomme «Ménophine» × 120 ; en cas de succès, vous obtiendrez les monnaies d'activité «Bouton de fleur gelé», «Bouton de fleur d'argent givré» et «Bouton de soleil».\n3, Après avoir Terminé un Niveau, la fonction «Reconstitution» de ce Niveau est déverrouillée. Attention : l'utilisation de la fonction «Reconstitution» ne permet pas d'obtenir de Taux de synchronisation.\n4, Vous pouvez utiliser l'Assistance au combat de l'association des anciens élèves et la «Résonance : Dévorer les Montagnes» pour Terminer les Niveaux plus facilement.\n5, Attention : les tentatives en difficulté Folie ne consomment pas de Ménophine, ne peuvent pas être reconstituées, et les tentatives répétées après la première réussite ne rapportent plus de monnaie d'activité.\n\n<Title: Bonus de Boutons de fleur>\n1, Les Gardiens du secret possédant certains Corps éveillés ou Roues du Destin spécifiques(sans obligation de les mettre en jeu) peuvent obtenir un bonus de drop supplémentaire sur les «Boutons de fleur gelés», «Boutons de fleur d'argent givrés» et «Boutons de soleil» dans les récompenses de missions des Niveaux de «Ambition de la Bête»(y compris lors des Reconstitutions). Les bonus sont les suivants :\n·Corps éveillé «Helot : Enchaînée» : Dégagement 0/1/2/3 et plus, bonus de 20%/30%/40%/50%\n·Roue du Destin SSR «Noyade dans le Pourpre» : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%\n·Roue du Destin SR «Jusqu'aux Dernières Neiges» : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%\n2, Les «Bonus de Boutons de fleur» de différents Corps éveillés ou Roues du Destin se cumulent.\n3, En particulier, les récompenses de première réussite en difficulté Folie ne sont pas affectées par le «Bonus de Boutons de fleur».\n\n<Title:Résonance : Dévorer les Montagnes>\n1, Les Gardiens du secret peuvent obtenir le «Cœur Vorace» en accomplissant des succès d'activité.\n2, En consommant le «Cœur Vorace», activez la «Résonance : Dévorer les Montagnes» pour devenir plus puissant dans l'Activité de jeu «Ambition de la Bête» et relever les défis plus facilement.\n\n<Title: Gueule de la montagne>\n1, La «Gueule de la montagne» comprend trois boutiques d'échange, dont les horaires d'ouverture sont les suivants :\n·«Ambition dévorante» : ouverture le 13 juillet à 9h.\n·«Esprit de vengeance» : ouverture le 15 juillet à 9h.\n·«Espoir de régénération» : ouverture le 17 juillet à 9h.\n2, Chaque échange consomme «Bouton de fleur gelé»/«Bouton de fleur d'argent givré»/«Bouton de soleil» × 750 et permet d'obtenir aléatoirement cinq récompenses d'objets de la boutique d'échange.\n3, Les récompenses d'objets de chaque boutique d'échange sont divisées en «Objets spéciaux» et «Objets ordinaires». La réinitialisation permet de remettre la quantité Restante des récompenses d'Objets spéciaux au maximum. Les règles spécifiques sont les suivantes :\n(1) Les 2 premières réinitialisations : lorsque les «Objets spéciaux» n'ont plus de quantité Restante, le Gardien peut choisir de réinitialiser — ce qui remet la quantité Restante des «Objets spéciaux» et des «Objets ordinaires» au maximum — ou de continuer à échanger ; lorsque les «Objets ordinaires» n'ont également plus de quantité Restante, une réinitialisation est nécessaire pour continuer à échanger.\n(2) À partir de la 3e réinitialisation : la réinitialisation n'est possible que lorsque les «Objets ordinaires» n'ont plus de quantité Restante ; elle remet uniquement la quantité Restante des «Objets ordinaires» au maximum, les «Objets spéciaux» ne sont plus réinitialisés.\n4, Après le 17 août 9:00(GMT+8), les «Boutons de fleur» Restants non échangés seront récupérés au taux de «Billet Rose Dorée» × 40 par unité. Veuillez vérifier vos e-mails, Gardiens du secret.\n\n<Title: Enregistrement de la task force>\n1, Pendant l'activité, l'«Enregistrement de la task force : Le Retour de Elvworth» sera disponible gratuitement. Après avoir Terminé l'«Enregistrement de la task force : Le Retour de Elvworth», vous pourrez obtenir dans les Récompenses de succès le «Cœur d'argent», la Roue du Destin SR limitée «Jusqu'aux Dernières Neiges» et d'autres récompenses. Les Récompenses de succès ne sont disponibles que pendant la durée de l'activité et ne pourront pas être complétées ni réclamées après la fin de l'activité.\n2, Après la fin de l'activité, la progression de l'enquête de l'«Enregistrement de la task force : Le Retour de Elvworth» sera conservée. Si l'«Enregistrement de la task force : Le Retour de Elvworth» n'a pas été déverrouillé pendant l'activité, il sera toujours possible de le déverrouiller après la fin de l'activité en consommant «Point de départ réel» × 7.\n3, Que ce soit pendant ou en dehors de la période d'activité, Terminer l'«Enregistrement de la task force : Le Retour de Elvworth» permet d'obtenir le «Décret Clé : La résolution des montagnes»."
  },
  Activity_67745_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_67746_ActivityName = {
    Text = "Passage de tous les royaumes : rediffusion"
  },
  Activity_67746_ActivityPlot = {
    Text = "Personne ne sait depuis combien de temps elle monte silencieusement la garde à la Porte de l'Extrémité.\nElle n'a jamais eu l'intention de se manifester dans un monde tangible, ni de se laisser emporter par un courant spatio–temporel.\nLà, à la Porte, elle demeurait imperturbable—\nJusqu'au moment où ses yeux ont croisé les vôtres."
  },
  Activity_67746_ActivityStageEndContent = {
    Text = "L'événement est Terminé. Actuellement, seul «Écho» est disponible."
  },
  Activity_67746_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, le Gardien peut collecter la monnaie d'événement « Pointeur final » via les modes temporaires « Test final » et « Récompenses de réussite ». Ces « Pointeur final » permettent d'échanger des récompenses précieuses dans « Écho », incluant notamment la Roue du Destin SR exclusive à l'événement « Porte de la vérité », le Cœur Immaculé, le Cœur de Lumens, les Éclats de Pierre Sage, les Cristal de Mimesis, etc.\n2. Pendant l'événement, en accomplissant les tâches de « Récompenses de réussite », vous pourrez obtenir un avatar exclusif à l'événement « Au nom de la Clé d'argent : «Tavi» », la Roue du Destin SR exclusive à l'événement « Porte de la vérité », du Cœur d'argent et une grande quantité de monnaie d'événement « Pointeur final ».\n\n<Title:Dates de l'événement>\n1. Du 3 novembre 9h00 au 17 novembre 9h00 (GMT+8), toutes les activités seront disponibles.\n2. Du 17 novembre 9h00 au 24 novembre 9h00 (GMT+8), seules les sections « Écho » et « Récompenses de réussite » resteront actives, les autres activités seront terminées et indisponibles.\n\n<Title:Test final>\n1. « Le Test final » contient 9 étapes, une étape s'ouvrant automatiquement chaque jour.\n2. Chaque défi consomme 120 points de Ménophine. En défiant des étapes différentes, outre des récompenses variées, vous obtiendrez également la monnaie d'événement « Pointeur final ».\n3. Les étapes de cet événement sont des étapes de ressources en combat direct, pouvant être rejouées après avoir été terminées ! Chaque « Reproduction » consomme 120 points de Ménophine.\n4. Veuillez noter : lors de l'utilisation de la fonction « Reproduction », vous ne pourrez pas obtenir de taux de synchronisation.\n\n<Title:Bonus de Pointeur final>\n1. Posséder certains Corps éveillés ou Roues du Destin spécifiques (pas nécessairement déployés) permet d'obtenir un bonus supplémentaire sur les « Pointeur final » reçus dans les récompenses des étapes de « Le Test final » (y compris les reproductions). Les bonus spécifiques sont les suivants :\nCorps éveillé « «Tavi» » : avec un Dégagement à 0/1/2/3 ou plus, bonus de 20%/30%/40%/50%\nRoue du Destin SSR « Roue Invisible » : avec une Superposition à 0/1/2/3 ou plus, bonus de 20%/30%/40%/50%\nRoue du Destin SR « Porte de la vérité » : avec une Superposition à 0/1/2/3 ou plus, bonus de 20%/30%/40%/50%\n2. Les bonus « Pointeur final » de différents Corps éveillés ou Roues du Destin s'additionnent.\n3. À noter toutefois, les récompenses du premier passage en difficulté Folie ne sont pas affectées par le bonus « Pointeur final ».\n\n<Title:Écho>\n1. « Écho » ne sera disponible que du 3 novembre 9h00 au 24 novembre 9h00 (GMT+8).\n2. Après le 24 novembre 9h00 (GMT+8), les « Pointeur final » non échangés seront récupérés au taux de « Billet Rose Dorée *40 » par échange, veuillez vérifier vos messages."
  },
  Activity_67746_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_67746_UnlockConditionExplanation = {
    Text = "Débloqué après avoir terminé \"Opération Investigation\" 2-9 · Normal"
  },
  Activity_67748_ActivityName = {
    Text = "Événement de déblocage gratuit"
  },
  Activity_67749_ActivityName = {
    Text = "Événement de déblocage gratuit"
  },
  Activity_68349_ActivityName = {
    Text = "Au-delà des étoiles · Précommande limitée"
  },
  Activity_68349_ActivityTips = {
    Text = "<Title: Au-delà des étoiles · Précommande limitée>\n·L'offre de précommande limitée comprend 8 packs. Le premier pack peut être récupéré gratuitement, tandis que les packs 2 à 8 ne peuvent être obtenus qu'après avoir acheté « Au-delà des étoiles · Précommande limitée ».\n·Après avoir acheté « Au-delà des étoiles · Précommande limitée », vous pourrez immédiatement récupérer la récompense du deuxième pack ; les packs suivants devront être récupérés après un délai d'attente respectif.\n·L'achat de « Au-delà des étoiles · Précommande limitée » est soumis à une limite de temps. Passé ce délai, il ne sera plus possible de l'acheter. Veuillez acheter en fonction de vos besoins, Gardien."
  },
  Activity_68374_ActivityName = {
    Text = "Coffret de la Fête d'hiver"
  },
  Activity_68374_ActivityPlot = {
    Text = "Un coffret cadeau fourni par les Mizags pour la célébration de la Fête de Solstice. Ni le vent ni le gel ne peuvent détruire la volonté des Mizags de résister à la Fusion. Dans la lueur festive des flammes, les âmes qui se soutiennent mutuellement protégeront tous ceux qui refusent de céder au Destin."
  },
  Activity_68375_ActivityName = {
    Text = "Coffret spécial anniversaire"
  },
  Activity_68375_ActivityPlot = {
    Text = "Remodelé par les Technologies Silvercore, Son Regard prend de nouvelles formes pour vous accompagner. À chaque instant de l'année écoulée, Il a été à vos côtés."
  },
  Activity_68404_ActivityName = {
    Text = "Texte temporaire"
  },
  Activity_68404_ActivityPlot = {
    Text = "Texte temporaire"
  },
  Activity_68404_ActivityStageEndContent = {
    Text = "Événement terminé, participation actuelle uniquement à «Texte temporaire»"
  },
  Activity_68404_ActivityTips = {
    Text = "<Title:Aperçu de l'événement>\nTexte temporaire"
  },
  Activity_68404_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_68405_ActivityName = {
    Text = "Résurrection du Roi des Dieux"
  },
  Activity_68405_ActivityPlot = {
    Text = "Dans le désir infini des souhaits, il se réveille brièvement dans son long sommeil et jette un vrai coup d'œil à ce monde terne.\nDans l'éternité, ce regard est si bref"
  },
  Activity_68405_ActivityStageEndContent = {
    Text = "L'événement est terminé. Actuellement, seul \"Abysse de la Connaissance\" est disponible."
  },
  Activity_68405_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, les Gardiens du secret peuvent collecter la monnaie d'événement « Pensée de fatigue », « Pensée de tristesse » et « Pensée de joie » via les modes temporaires « Regard des abysses » et « Récompenses de succès ». Cette monnaie permet d'acheter des articles dans « L'Abîme conscient », notamment la Roue du Destin SR exclusive à l'événement « Trône de pierre bleue », des Cœurs de Lumens, des Cœurs Immaculés, des Éclats de Pierre Sage et des Cristaux de Mimesis.\n2. Pendant l'événement, accomplir les succès d'activité permet également d'obtenir un avatar exclusif « Au nom de la Clé d'argent : Tulu », une Roue du Destin SR exclusive « Trône de pierre bleue », des Cœurs d'argent et une grande quantité de monnaie d'événement !\n\n<Title:Période de l'événement>\n1. Du 30 décembre à 9h00 au 13 janvier à 9h00 (GMT+8), toutes les activités de l'événement sont disponibles.\n2. Du 13 janvier à 9h00 au 20 janvier à 9h00 (GMT+8), seules les activités « L'Abîme conscient » et « Récompenses de succès » sont disponibles.\n\n<Title:Regard des abysses>\n1. « Regard des abysses » comporte 5 niveaux, un nouveau niveau s'ouvre automatiquement tous les 2 jours.\n2. Chaque défi consomme 120 points de neuropéricine, et la réussite rapporte de la monnaie d'événement.\n3. Une fois un niveau terminé, la fonction « Recréation » de ce niveau devient disponible. Veuillez noter : la fonction « Recréation » ne permet pas d'obtenir de taux de synchronisation.\n4. Vous pouvez utiliser l'aide des Alumni pour faciliter le passage des niveaux.\n\n<Title:Bonus de Pensées>\n1. Les Gardiens du secret possédant certains Corps éveillés ou Roues du Destin (non obligatoires en combat) peuvent obtenir un bonus supplémentaire sur les monnaies d'événement reçues dans les missions des niveaux de « Regard des abysses ». Les bonus sont les suivants :\nCorps éveillé « Tulu » : Dégagement 0/1/2/3 ou plus, bonus de 20%/30%/40%/50%.\nRoue du Destin SSR « Hymne au Dieu-Roi » : Superposition 0/1/2/3 ou plus, bonus de 20%/30%/40%/50%.\nRoue du Destin SR « Trône de pierre bleue » : Superposition 0/1/2/3 ou plus, bonus de 20%/30%/40%/50%.\n2. Les « Bonus de Pensées » de différents Corps éveillés ou Roues du Destin s'additionnent.\n3. À noter toutefois : les récompenses de la première réussite en difficulté Fou ne sont pas affectées par les « Bonus de Pensées ».\n\n<Title:L'Abîme conscient>\n1. « L'Abîme conscient » n'est disponible que du 30 décembre à 9h00 au 20 janvier à 9h00 (GMT+8).\n2. Après le 20 janvier à 9h00 (GMT+8), les « Pensée de fatigue », « Pensée de tristesse » et « Pensée de joie » restantes non échangées seront récupérées au taux de « Billet Rose Dorée*40 » par unité. Veuillez vérifier vos messages."
  },
  Activity_68405_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_68406_ActivityName = {
    Text = "Enterré sous la mémoire"
  },
  Activity_68406_ActivityPlot = {
    Text = "Les gens enfouissent leurs désirs au plus profond de leurs souvenirs, portant des masques illusoires pour s'adapter au monde.\nÉcoutez, les cris de ce qui est recouvert par l'enveloppe de chair et de sang résonnent dans la brume de la mémoire.\nVidez votre esprit, abandonnez la chair, pour rencontrer votre véritable moi."
  },
  Activity_68406_ActivityStageEndContent = {
    Text = "L'événement est terminé, seule la participation à la « Salle de Thérapie Neuronale » est actuellement possible."
  },
  Activity_68406_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\nPendant l'événement, les Gardiens du secret peuvent collecter des devises événementielles via les modes temporaires « Thérapie de la peur » et « Récompenses de réussite ». Les devises événementielles peuvent être échangées dans le « Cabinet de diagnostic neurologique » pour obtenir des récompenses, incluant notamment la Roue du Destin SR exclusive à l'événement « Pendule d'Hypnose », la Pierre philosophale, le Cœur Immaculé, le Cœur de Lumens, etc.\n\n<Title:Période de l'événement>\n1. Du 7 avril 9h00 au 21 avril 9h00 (GMT+8), toutes les activités sont disponibles.\n2. Du 21 avril 9h00 au 28 avril 9h00 (GMT+8), seul le « Cabinet de diagnostic neurologique » et les « Récompenses de réussite » restent disponibles, les autres contenus sont terminés et ne sont plus accessibles.\n\n<Title:Thérapie de la peur>\n1. « Thérapie de la peur » comprend 5 étapes, une nouvelle étape s'ouvre automatiquement tous les 2 jours.\n2. Chaque défi consomme 120 points de ménope, la réussite du défi permet d'obtenir des devises événementielles.\n3. Une fois un étage terminé, la fonction « Récurrence » de cet étage est débloquée. Veuillez noter : lors de l'utilisation de la fonction « Récurrence », le taux de synchronisation ne peut pas être obtenu.\n4. Vous pouvez utiliser l'Assistance au combat des Alumni pour faciliter la réussite.\n\n<Title:Bonus d'événement>\n1. Lorsque le Gardien possède un Éveilleur ou une Roue du Destin spécifique (non obligatoire en combat), cela permet d'obtenir un bonus supplémentaire sur les « Rapports de diagnostic » obtenus dans les récompenses des missions des étages de « Thérapie de la peur » (incluant la récurrence), les bonus spécifiques sont les suivants :\nÉveilleur « Clémentine » : Dégagement 0/1/2/3 et plus, bonus de 20%/30%/40%/50%\nRoue du Destin SSR « Douleur Enfouie » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%\nRoue du Destin SR « Pendule d'Hypnose » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%\n2. Les bonus d'événement provenant de différents Éveilleurs ou Roues du Destin s'additionnent.\n3. En particulier, les récompenses de la première réussite en difficulté Folie ne sont pas affectées par les bonus d'événement.\n\n<Title:Cabinet de diagnostic neurologique>\n1. Chaque « Soumettre le rapport » consomme 1000 « Rapports de diagnostic », et offre aléatoirement cinq récompenses du « Cabinet de diagnostic neurologique ».\n2. Les récompenses du « Cabinet de diagnostic neurologique » sont divisées en deux catégories : « Objet spécial » et « Objet ordinaire ». Lors de la réinitialisation, la quantité restante des récompenses « Objet spécial » peut être réinitialisée à la limite maximale. Les règles détaillées sont les suivantes :\n(1) Premières 5 réinitialisations : lorsque les « Objet spécial » sont épuisés, le Gardien peut choisir de réinitialiser, ce qui réinitialisera la quantité restante des « Objet spécial » et des « Objet ordinaire » à la limite maximale ; ou il peut choisir de continuer à échanger, et une fois que les « Objet ordinaire » sont également épuisés, une réinitialisation sera nécessaire pour continuer à échanger.\n(2) À partir de la 6e réinitialisation : la réinitialisation n'est possible que lorsque les « Objet ordinaire » sont épuisés. La réinitialisation réinitialise la quantité restante des « Objet ordinaire » à la limite maximale, les « Objet spécial » ne sont plus réinitialisés.\n3. Après le 28 avril 9h00 (GMT+8), les « Rapports de diagnostic » non échangés seront récupérés au taux de « Billet Rose Dorée*40 » par unité. Veuillez vérifier vos messages."
  },
  Activity_68406_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_68407_ActivityName = {
    Text = "Texte temporaire"
  },
  Activity_68407_ActivityPlot = {
    Text = "Texte temporaire"
  },
  Activity_68407_ActivityStageEndContent = {
    Text = "Événement terminé, participation actuelle uniquement à «Texte temporaire»"
  },
  Activity_68407_ActivityTips = {
    Text = "<Title:Aperçu de l'événement>\nTexte temporaire"
  },
  Activity_68407_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_68409_ActivityName = {
    Text = "Texte temporaire"
  },
  Activity_68409_ActivityPlot = {
    Text = "Texte temporaire"
  },
  Activity_68409_ActivityStageEndContent = {
    Text = "Événement terminé, participation actuelle uniquement à «Texte temporaire»"
  },
  Activity_68409_ActivityTips = {
    Text = "<Title:Aperçu de l'événement>\nTexte temporaire"
  },
  Activity_68409_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_68410_ActivityName = {
    Text = "Ombre de la ville pluvieuse"
  },
  Activity_68410_ActivityPlot = {
    Text = "Dans cette nuit brumeuse et humide de pluie, une rencontre prédestinée vous attend.\nVous vous souvenez de son nom, reconnaissez son apparence, et sa voix douce et élégante vous met toujours à l'aise.\nMais vous avez oublié : seuls les dieux et les démons sont toujours empressés d'exaucer les désirs humains.\nDevinez, à laquelle de ces catégories appartient–elle ?"
  },
  Activity_68410_ActivityStageEndContent = {
    Text = "L'événement est terminé. Vous pouvez maintenant participer uniquement à la \"Cave de la Sorcière\"."
  },
  Activity_68410_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, les Gardiens du secret peuvent collecter la monnaie d'événement via le mode temporaire « Boutique de la Sorcière » et les « Récompenses de succès », et utiliser cette monnaie dans « Le Trésor de la sorcière » pour échanger des objets récompenses, notamment la Roue du Destin SR exclusive à l'événement « Élegant Chapeau de Sorcière », la Pierre philosophale, le Cœur Immaculé et le Cœur de Lumens.\n2. Pendant l'événement, l'« Enregistrement de la task force : Ombres pluvieuses » sera ouvert gratuitement, et en accomplissant les succès d'événement, vous pourrez obtenir l'avatar exclusif à l'événement « Au nom de la Clé d'argent : « Davendale » » !\n\n<Title:Période de l'événement>\n1. Du 24 février à 9h00 au 10 mars à 9h00 (GMT+8), tous les contenus de l'événement seront disponibles.\n2. Du 10 mars à 9h00 au 17 mars à 9h00 (GMT+8), seuls « Le Trésor de la sorcière » et « Les récompenses de succès » resteront disponibles, les autres contenus seront terminés et plus accessibles.\n\n<Title:Boutique de la Sorcière>\n1. « Boutique de la Sorcière » comprend 5 niveaux, un niveau s'ouvrira automatiquement tous les 2 jours.\n2. Chaque défi consommera 120 points d'endorphine, et en cas de succès, vous obtiendrez la monnaie de l'événement.\n3. Une fois le niveau terminé, la fonction « Répétition » de ce niveau sera débloquée. Veuillez noter : en utilisant la fonction « Répétition », vous ne pourrez pas obtenir de taux de synchronisation.\n4. Vous pouvez utiliser l'aide des Alumni pour faciliter la réussite du niveau.\n\n<Title:Bonus de l'événement>\n1. Si le Gardien possède un certain Corps éveillé ou une Roue du Destin spécifique (pas nécessairement en équipe), cela permettra d'obtenir un bonus supplémentaire sur les « Crâne de Bête Pâle » et les « Crâne de Bête Ombreuse » et « Crâne de la Bête Écarlate » obtenus dans les récompenses des missions des niveaux de « Boutique de la Sorcière » (y compris la répétition). Les bonus sont les suivants :\nCorps éveillé « « Davendale » » : Dégagement 0/1/2/3 ou au-delà, bonus de 20%/30%/40%/50%\nRoue du Destin SSR « La collection la plus précieuse » : Superposition 0/1/2/3 ou au-delà, bonus de 20%/30%/40%/50%\nRoue du Destin SR « Élegant Chapeau de Sorcière » : Superposition 0/1/2/3 ou au-delà, bonus de 20%/30%/40%/50%\n2. Les bonus de l'événement provenant de différents Corps éveillés ou Roues du Destin s'additionnent.\n3. À noter que les récompenses de la première réussite en difficulté Fou ne sont pas affectées par les bonus de l'événement.\n\n<Title:Le Trésor de la sorcière>\n1. Il y a trois trésors dans « Le Trésor de la sorcière », les dates d'ouverture sont les suivantes :\n« Remède souverain » : du 24 février à 9h00 au 17 mars à 9h00.\n« Trésor précieux » : du 26 février à 9h00 au 17 mars à 9h00.\n« Marchandise rare » : du 28 février à 9h00 au 17 mars à 9h00.\n2. Chaque échange consommera 750 « Crâne de Bête Pâle » / « Crâne de Bête Ombreuse » / « Crâne de la Bête Écarlate », et vous obtiendrez aléatoirement cinq objets parmi ceux disponibles dans le trésor.\n3. Les récompenses des objets dans chaque trésor sont divisées en deux catégories : « Objet spécial » et « Objet ordinaire ». Lors de la réinitialisation, il est possible de réinitialiser la quantité restante d'un objet spécifique jusqu'à sa limite maximale. Les règles détaillées sont les suivantes :\n(1) Premières 2 réinitialisations : lorsque les « Objet spécial » n'ont plus de quantité disponible, le Gardien peut choisir de les réinitialiser. Après la réinitialisation, la quantité restante des « Objet spécial » et des « Objet ordinaire » sera réinitialisée à leur maximum ; il peut aussi choisir de continuer les échanges. Lorsque les « Objet ordinaire » n'ont plus de quantité disponible, il faudra effectuer une réinitialisation pour continuer les échanges.\n(2) À partir de la 3e réinitialisation : la réinitialisation ne pourra être effectuée que lorsque les « Objet ordinaire » n'auront plus de quantité disponible. La réinitialisation rétablira la quantité des « Objet ordinaire » à leur maximum, mais les « Objet spécial » ne seront plus réinitialisés.\n\n<Title:Enregistrement de la task force>\n1. Pendant l'événement, l'« Enregistrement de la task force : Ombres pluvieuses » sera ouvert gratuitement.\n2. À la fin de l'événement, les progrès de l'« Enregistrement de la task force : Ombres pluvieuses » seront conservés. Si vous n'avez pas débloqué l'« Enregistrement de la task force : Ombres pluvieuses » pendant l'événement, vous pourrez toujours l'obtenir après la fin de l'événement en dépensant 7 « Point de départ réel ».\n3. Quel que soit le moment, après avoir terminé l'« Enregistrement de la task force : Ombres pluvieuses », vous pourrez obtenir la « Clé : Visage brumeux gris »."
  },
  Activity_68410_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_68411_ActivityName = {
    Text = "Texte temporaire"
  },
  Activity_68411_ActivityPlot = {
    Text = "Texte temporaire"
  },
  Activity_68411_ActivityStageEndContent = {
    Text = "Événement terminé, participation actuelle uniquement à «Texte temporaire»"
  },
  Activity_68411_ActivityTips = {
    Text = "<Title:Aperçu de l'événement>\nTexte temporaire"
  },
  Activity_68411_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_70438_ActivityName = {
    Text = "Uma Nya Nya Rate"
  },
  Activity_70438_ActivityPlot = {
    Text = "La Fête de l'An approche, tout le monde se concentre sur les préparatifs de la célébration, sans prêter attention à la tache noire qui se tortille discrètement dans un coin, le petit prisonnier se transforme en liquide et s'échappe de sa cellule. \n Avec l'éclat de la fissure dimensionnelle, les touffes noires commencent à se diviser... Une mer de chats noirs est en train de dévorer tout le campus ! \n Tu pensais ignorer cela et laisser cet événement étrange être géré par l'administration scolaire. \n Mais en tenant compte du fait qu'ils laissent tomber des cœurs d'argent et des coupons, tu as changé d'avis."
  },
  Activity_70438_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\nL'événement «Uma Nya Nya Rate» est disponible en temps limité ! Pendant l'événement, les Gardiens du secret peuvent affronter les chats de l'école dans «Danse folle des chats» et obtenir de grandes quantités de Cœur d'argent et de coupons de Billet Rose Dorée !\n\n<Title:Durée de l'événement>\nDu 24 janvier à 9h00 au 5 février à 9h00 (GMT+8). Pendant la durée de l'événement, les joueurs peuvent participer quotidiennement aux nouveaux défis «Danse folle des chats» débloqués chaque jour. Les défis déjà terminés ne seront plus accessibles.\n\n<Title:Danse folle des chats>\n1. «Danse folle des chats» contient un total de 12 défis. Chaque jour, un défi différent est ouvert et les défis déjà terminés ne seront plus accessibles.\n2. Aucune dépense de caféine n'est requise pour chaque défi. À la fin de chaque défi, vous obtenez des Cœur Immaculé, des Cœur d'argent et des coupons de Billet Rose Dorée.\n3. Lors de cet événement, les membres de l'association des anciens élèves ne peuvent pas être utilisés pour aider au combat.\n4. Dans les défis quotidiens, chaque Éveilleur ne peut être utilisé qu'une seule fois.\n5. Les défis quotidiens doivent être accomplis avec un Royaume spécifique :\n24 janvier : Royaume du Chaos\n25 janvier : Royaume des abysses\n26 janvier : Royaume de chair\n27 janvier : Royaume hyperdimensionnel\n28 janvier : Aucune restriction\n29 janvier : Aucune restriction\n30 janvier : Royaume du Chaos et Royaume des abysses\n31 janvier : Royaume de chair et Royaume hyperdimensionnel\n1er février : Royaume du Chaos et Royaume de chair\n2 février : Royaume des abysses et Royaume hyperdimensionnel\n3 février : Royaume du Chaos et Royaume hyperdimensionnel\n4 février : Royaume de chair et Royaume des abysses"
  },
  Activity_70438_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_71095_ActivityName = {
    Text = "Événement de déblocage gratuit"
  },
  Activity_71095_ActivityTips = {
    Text = "<Title:Conditions de participation>\n·Complétez \"Opération Investigation\" 2-9 (Normal) pour participer.\n<Title:Événement d'investigation>\n·Pendant la période de l'événement, un nouvel événement d'investigation de \"Magie des Histoires\" sera lancé chaque jour. Les Gardiens peuvent déverrouiller et enquêter sans consommer d'inventaire. Après avoir terminé l'événement d'investigation, des récompenses telles que le Cœur Pur, le Insigne d'Investigation et l'Expérience de Gardien peuvent être obtenues.\n·Après la fin de l'événement, la progression d'investigation de \"Magie des Histoires\" sera conservée. Les Gardiens peuvent dépenser des D-gemmes dans le Registre Spécial pour débloquer des enquêtes non complétées. Compléter des événements d'investigation non terminés pendant la période de l'événement accordera également des récompenses cohérentes avec celles de l'événement.<Title:Récompenses à durée limitée>\n·Des récompenses à durée limitée seront disponibles durant l'événement. Les Gardiens peuvent obtenir le Cœur Pur, la Pierre Philosophale et des récompenses en Argent après avoir terminé \"Magie des Histoires\" (mode Normal) et complété les événements d'investigation de \"Magie des Histoires\"! Les récompenses à durée limitée ne sont disponibles que pendant la période de l'événement et ne peuvent pas être complétées ou réclamées après la fin de l'événement."
  },
  Activity_71097_ActivityName = {
    Text = "Texte temporaire"
  },
  Activity_71097_ActivityPlot = {
    Text = "Texte temporaire"
  },
  Activity_71097_ActivityStageEndContent = {
    Text = "Événement terminé, participation actuelle uniquement à «Texte temporaire»"
  },
  Activity_71097_ActivityTips = {
    Text = "<Title:Aperçu de l'événement>\nTexte temporaire"
  },
  Activity_71097_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_71098_ActivityName = {
    Text = "À mi-chemin · Réplique"
  },
  Activity_71098_ActivityPlot = {
    Text = "Elle garde toujours une longueur d'avance sur le monde.\nUn pas, deux pas — ses empreintes éclairent le chemin pour tous.\nMais les sots oublient trop facilement :\nLa distance entre le génie et la folie\nn'est qu'un demi–pas."
  },
  Activity_71098_ActivityStageEndContent = {
    Text = "L'événement est Terminé. Actuellement, seuls les «Enseignements du Maître» sont disponibles."
  },
  Activity_71098_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\nPendant l'événement, le gardien pourra collecter la monnaie d'événement « Pièces de poupée » via le mode temporaire « Porte du Néant » et les récompenses de réalisations. Les « Pièces de poupée » pourront être échangées contre des récompenses dans « Enseignements du Maître », incluant la roue fatale SR exclusive à l'événement « Bâton du Berger », des cœurs de lumière, des cœurs purs, des éclats de sagesse, des cristaux imités, etc.\n\n<Title:Porte du Néant>\n1. « Porte du Néant » contient 9 étapes de matériaux où il n'est pas nécessaire d'explorer, uniquement des combats, une étape s'ouvrant chaque jour.\n2. Chaque défi consomme 120 points de morphine, et la réussite du défi permet d'obtenir des matériaux d'entraînement et la monnaie de l'événement.\n3. Une fois l'étape terminée, la fonction « Recréation » de cette étape sera débloquée. Veuillez noter : lors de l'utilisation de la fonction « Recréation », le taux de synchronisation ne pourra pas être obtenu.\n4. Vous pouvez utiliser l'aide de l'Alumni pour faciliter le passage de l'étape.\n\n<Title:Bonus de Pièces de poupée>\n1. Lorsque le gardien possède un réveilleur ou une roue fatale spécifique (pas nécessaire de les utiliser dans l'équipe), il obtiendra un bonus supplémentaire sur les « Pièces de poupée » obtenues dans les récompenses des étapes de « Porte du Néant » (incluant la recréation), les bonus spécifiques sont les suivants :\n· Réveilleur « Fusion·Dor » : éveil 0/1/2/3 ou plus, bonus de 20 % / 30 % / 40 % / 50 % \n· Roue fatale SSR « Marionnette du Néant » : superposition à 0/1/2/3 ou plus, bonus de 20 % / 30 % / 40 % / 50 % \n· Roue fatale SR « Bâton du Berger » : superposition à 0/1/2/3 ou plus, bonus de 20 % / 30 % / 40 % / 50 % \n2. Les bonus de « Pièces de poupée » de différents réveilleurs ou roues fatales s'additionnent.\n3. À noter toutefois, les récompenses de premier passage en difficulté folle ne sont pas affectées par les bonus mentionnés ci-dessus.\n\n<Title:Enseignements du Maître>\n1. Chaque « Échange de pièces » consommera 750 « Pièces de poupée », et offrira aléatoirement cinq objets parmi « Enseignements du Maître ».\n2. Les récompenses d'objets de « Enseignements du Maître » sont divisées en deux catégories : « Objets spéciaux » et « Objets normaux ». Lors d'une réinitialisation, la quantité restante d'objets spéciaux pourra être réinitialisée jusqu'à sa limite maximale. Les règles détaillées sont les suivantes :\n(1) Premières 5 réinitialisations : lorsque les « Objets spéciaux » n'ont plus de quantité disponible, le gardien peut choisir de réinitialiser. Après réinitialisation, la quantité restante des « Objets spéciaux » et « Objets normaux » sera réinitialisée à leur limite maximale ; il peut également choisir de continuer à échanger, et une fois que les « Objets normaux » n'ont plus de quantité disponible, il faudra effectuer une réinitialisation pour continuer les échanges.\n(2) À partir de la 6e réinitialisation : la réinitialisation ne pourra être effectuée qu'une fois que les « Objets normaux » n'auront plus de quantité disponible. La réinitialisation réinitialisera la quantité restante des « Objets normaux » à leur limite maximale, mais les « Objets spéciaux » ne seront plus réinitialisés.\n\n<Title:Période de l'événement>\n1. Du 16 juin 9h00 au 30 juin 9h00 (GMT+8), toutes les contenus mentionnés dans la présentation de l'événement seront disponibles.\n2. Du 30 juin 9h00 au 7 juillet 9h00 (GMT+8), seuls « Enseignements du Maître » et les récompenses de réalisations resteront disponibles, les autres contenus seront terminés et ne seront plus accessibles.\n3. Après le 7 juillet 9h00 (GMT+8), les « Pièces de poupée » restantes non échangées seront récupérées au taux de « 40 bons d'or rose » par unité, veuillez vérifier vos messages."
  },
  Activity_71098_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_71100_ActivityName = {
    Text = "Résurrection du Roi des Dieux"
  },
  Activity_71100_ActivityPlot = {
    Text = "Dans le désir infini des souhaits, il se réveille brièvement dans son long sommeil et jette un vrai coup d'œil à ce monde terne.\nDans l'éternité, ce regard est si bref"
  },
  Activity_71100_ActivityStageEndContent = {
    Text = "L'événement est terminé. Actuellement, seul \"Abysse de la Connaissance\" est disponible."
  },
  Activity_71100_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, les Gardiens du secret peuvent collecter la monnaie d'événement « Pensées fatiguées », « Pensée de tristesse » et « Pensée de joie » via le mode de jeu temporaire « Regard des profondeurs » et les « Récompenses de succès ». La monnaie d'événement peut être utilisée dans « Conscience abyssale » pour acheter des articles, notamment la Roue du Destin SR exclusive à l'événement « Trône de Pierre bleue », des Cœur de Lumens, des Cœur Immaculé, des Éclats de Pierre Sage, des Cristal de Mimesis et d'autres objets.\n2. Pendant l'événement, la réalisation des succès de l'événement permet également d'obtenir un avatar exclusif à l'événement « Au nom de la Clé d'argent : Caecus », la Roue du Destin SR exclusive à l'événement « Trône de Pierre bleue », des Cœur d'argent et une grande quantité de monnaie d'événement !\n\n<Title:Période de l'événement>\n1. Du 30 décembre 9h00 au 13 janvier 9h00 (GMT+8), tous les modes de jeu de l'événement seront disponibles.\n2. Du 13 janvier 9h00 au 20 janvier 9h00 (GMT+8), seuls « Conscience abyssale » et les récompenses de succès seront accessibles.\n\n<Title:Regard des profondeurs>\n1. « Regard des profondeurs » comporte 5 niveaux, chaque niveau s'ouvrant automatiquement tous les 2 jours.\n2. Chaque défi consomme 120 points d'endorphine, et la réussite du défi permet d'obtenir la monnaie de l'événement.\n3. Une fois un niveau terminé, la fonction « Recréation » de ce niveau est débloquée. Veuillez noter : lors de l'utilisation de la fonction « Recréation », le taux de synchronisation ne peut pas être obtenu.\n4. Vous pouvez utiliser l'aide des Alumni pour faciliter le passage des niveaux.\n\n<Title:Bonus de Pensées>\n1. Lorsque le Gardien possède un Corps éveillé ou une Roue du Destin spécifique (pas nécessairement déployé), la monnaie de l'événement obtenue dans les récompenses des missions des niveaux « Regard des profondeurs » bénéficiera d'un bonus supplémentaire, comme suit :\nCorps éveillé « Tulu » : Dégagement 0/1/2/3 et plus, bonus de 20 %/30 %/40 %/50 %.\nRoue du Destin SSR « Hymne au Dieu–Roi » : Empilement 0/1/2/3 et plus, bonus de 20 %/30 %/40 %/50 %.\nRoue du Destin SR « Trône de Pierre bleue » : Empilement 0/1/2/3 et plus, bonus de 20 %/30 %/40 %/50 %.\n2. Les « Bonus de Pensées » de différents Corps éveillés ou Roues du Destin s'additionnent.\n3. À noter : les récompenses du premier passage en difficulté Fou ne sont pas affectées par les « Bonus de Pensées ».\n\n<Title:Conscience abyssale>\n1. « Conscience abyssale » ne sera accessible que du 30 décembre 9h00 au 20 janvier 9h00 (GMT+8).\n2. Après le 20 janvier 9h00 (GMT+8), les « Pensées fatiguées », « Pensée de tristesse » et « Pensée de joie » restantes non échangées seront récupérées selon un taux de conversion de « 40 Billet Rose Dorée par échange ». Veuillez vérifier vos messages pour récupérer ces récompenses."
  },
  Activity_71100_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_71101_ActivityName = {
    Text = "Texte temporaire"
  },
  Activity_71101_ActivityPlot = {
    Text = "Texte temporaire"
  },
  Activity_71101_ActivityStageEndContent = {
    Text = "Événement terminé, participation actuelle uniquement à «Texte temporaire»"
  },
  Activity_71101_ActivityTips = {
    Text = "<Title:Aperçu de l'événement>\nTexte temporaire"
  },
  Activity_71101_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_71102_ActivityName = {
    Text = "Magie de l'histoire · Répétition"
  },
  Activity_71102_ActivityPlot = {
    Text = "La mission donnée par poupée n'est jamais simple. \nMême si elle rappelle à plusieurs reprises aux gens de « s'amuser », comment les gardiens peuvent-ils ne pas être nerveux en emmenant un groupe de réveilleurs pour la première fois ? \nMais, n'oublie pas de « t'amuser », d'accord ?"
  },
  Activity_71102_ActivityStageEndContent = {
    Text = "L'événement est terminé. Actuellement, seule la « Boutique de Scripts Magiques » est disponible."
  },
  Activity_71102_ActivityTips = {
    Text = "<Title:Aperçu de l'événement>\n1. L'événement de gameplay « La magie de l'histoire » est de retour pour une durée limitée ! Les Gardiens du secret peuvent accéder au « Magasin de grimoires » et aux « Récompenses de succès » pour obtenir à nouveau la Roue du Destin exclusive à l'événement « Magie de l'Argentique » et l'avatar exclusif à l'événement « Au nom de la Clé d'Argent : Lily » !\n2. Pendant l'événement, « Opération Spéciale : La magie de l'histoire » sera disponible en accès libre limité.\n\n<Title:Durée de l'événement>\n1. Du 3 juin, 9:00 au 17 juin, 9:00 (GMT+8), tout le contenu présenté dans l'introduction de l'événement est accessible.\n2. Du 17 juin, 9:00 au 24 juin, 9:00 (GMT+8), seuls le « Magasin de grimoires » et les « Récompenses de succès » resteront accessibles ; le reste du contenu sera terminé et ne pourra plus être joué.\n\n<Title:Énigmes scénaristiques>\n1. Les « Énigmes scénaristiques » se composent de 9 niveaux de matériaux, un niveau se débloquant automatiquement chaque jour. Après le déblocage, vous devez terminer le niveau d'Opération Spéciale précédent pour y accéder.\n2. Chaque défi consomme 60 points de Ménophine. Les défis réussis vous récompensent avec la monnaie d'événement « Inspiration errante » et des matériaux de cultivation. Terminer les niveaux de matériaux de cet événement prend en charge la reconstitution.\n3. Vous pouvez utiliser l'assistance des Anciens élèves et la « Résonance : valeur de phase du Réalisateur » pour terminer les niveaux plus facilement.\n\n<Title:Bonus d'Inspiration>\n1. Les Gardiens du secret possédant des Corps éveillés ou des Roues du Destin spécifiques (non requis dans l'escouade) obtiennent des bonus de drop supplémentaires pour l'« Inspiration errante » dans les récompenses de tâche des « Énigmes scénaristiques » (y compris la reconstitution). Les bonus spécifiques sont les suivants :\nCorps éveillé « Lily » : Dégagement 0/1/2/3 et plus, bonus 20%/30%/40%/50%\nRoue du Destin SSR « Au Travers de la Douleur » : Cumul 0/1/2/3 et plus, bonus 20%/30%/40%/50%\nRoue du Destin SR « Magie de l'Argentique » : Cumul 0/1/2/3 et plus, bonus 20%/30%/40%/50%\n2. Les « Bonus d'Inspiration » de différents Corps éveillés ou Roues du Destin se cumulent.\n\n<Title:Résonance : valeur de phase du Réalisateur>\n1. Les Gardiens du secret peuvent acquérir des « Cœurs de l'interprétation » en accomplissant les succès de l'événement.\n2. Consommer des « Cœurs de l'interprétation » pour activer la « Résonance : valeur de phase du Réalisateur » rend les Gardiens du secret plus puissants dans le gameplay de l'événement « Énigmes scénaristiques » et « Opération Spéciale : La magie de l'histoire », et améliore les récompenses d'« Inspiration errante » et de Taux de synchronisation obtenues après avoir terminé les défis des « Énigmes scénaristiques ».\n\n<Title:Récompenses de succès>\n1. Accomplir les tâches de succès accorde l'avatar exclusif à l'événement « Au nom de la Clé d'Argent : Lily », la monnaie d'événement « Inspiration errante » et des Cœurs d'argent.\n2. Comprend 25 tâches : terminer chaque niveau des « Énigmes scénaristiques » une fois, utiliser chaque équipe de Royaume pour terminer les « Énigmes scénaristiques » 1/2 fois, terminer chaque événement d'investigation dans « Opération Spéciale : La magie de l'histoire » une fois, et accomplir tous les succès de l'événement.\n\n<Title:Opération Spéciale>\n1. Pendant l'événement, « Opération Spéciale : La magie de l'histoire » peut être débloquée gratuitement.\n2. Dans « Opération Spéciale : La magie de l'histoire », les Gardiens du secret affronteront les défis avec une configuration d'équipe spéciale incluant le préréglage narratif « Lily ».\n\n<Title:Compensation de Résurrection>\n1. Les Gardiens du secret ayant précédemment débloqué « Opération Spéciale : La magie de l'histoire » recevront une compensation de « Inspiration errante » *1000 lors du redéblocage pendant cet événement de reprise.\nLes Gardiens du secret ayant précédemment obtenu l'avatar exclusif à l'événement « Au nom de la Clé d'Argent : Lily » verront automatiquement les récompenses en double converties en « Inspiration errante » *3000.\nLes Gardiens du secret ayant précédemment obtenu le matériau d'activation de Résonance « Cœur de l'interprétation » verront automatiquement chaque « Cœur de l'interprétation » supplémentaire obtenu converti en « Billet Rose Dorée » *5000.\n"
  },
  Activity_71102_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_71325_ActivityName = {
    Text = "Poème sans nom"
  },
  Activity_71325_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Pendant l'événement \"Poème Sans Nom\", les Gardiens peuvent utiliser des équipes préétablies par le système incluant Horla pour expérimenter des niveaux désignés à l'infini.\n·Lors de l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir réussi à terminer le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_71329_ActivityName = {
    Text = "Fleurir de boue"
  },
  Activity_71329_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Pendant l'événement \"Fleur de Mire\", les Gardiens peuvent utiliser des équipes préétablies par le système incluant Lily pour expérimenter des niveaux désignés à l'infini.\n·Lors de la jouabilité des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir réussi à terminer le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_71743_ActivityName = {
    Text = "Chasseresse de crânes"
  },
  Activity_71743_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Pendant l'événement \"Chasseresse des Crânes\", les Gardiens peuvent utiliser des équipes préétablies par le système incluant Jonquille pour expérimenter des niveaux désignés à l'infini.\n·Lors de l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir réussi à terminer le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_71744_ActivityName = {
    Text = "Bishop de baumes"
  },
  Activity_71744_ActivityTips = {
    Text = "<Title:Règles de l'activité>\n·Pendant l'événement \"Évêque Bienveillant\", les Gardiens peuvent utiliser des équipes prédéfinies par le système contenant Salvador pour expérimenter des niveaux désignés un nombre illimité de fois.\n·Lors de la réalisation des niveaux d'événement, des ajustements au Réveiller dans la composition de l'équipe ne peuvent pas être effectués.\n<Title:Récompenses de l'activité>\n·Après avoir réussi un défi de niveau pour la première fois, vous pouvez réclamer des récompenses d'essai depuis l'interface de l'événement."
  },
  Activity_71745_ActivityName = {
    Text = "Madame en rouge"
  },
  Activity_71745_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Pendant l'événement \"Dame Rouge\", les Gardiens peuvent utiliser des équipes préétablies par le système incluant Sorel pour expérimenter des niveaux désignés à l'infini.\n·Lors de l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir réussi à terminer le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_71746_ActivityName = {
    Text = "Dame des abysses"
  },
  Activity_71746_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n· Pendant l'événement \"Dame Aequor\", les Gardiens peuvent utiliser des équipes préétablies par le système qui incluent Murphy pour vivre les niveaux désignés indéfiniment.\n· Pendant l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n· Après avoir réussi à compléter le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_71747_ActivityName = {
    Text = "Événement de déblocage gratuit"
  },
  Activity_71956_ActivityName = {
    Text = "Cadeau commémoratif de promotion X"
  },
  Activity_71956_ActivityPlot = {
    Text = "La route s'étend longuement, enveloppée dans les ténèbres de la Fusion.\nLa lumière de la Clé d'Argent nous guidera tous."
  },
  Activity_71957_ActivityName = {
    Text = "Cadeau commémoratif de promotion IX"
  },
  Activity_71957_ActivityPlot = {
    Text = "La route s'étend longuement, enveloppée dans les ténèbres de la Fusion.\nLa lumière de la Clé d'Argent nous guidera tous."
  },
  Activity_71982_ActivityName = {
    Text = "Cérémonie de la Résonance de l'Âme"
  },
  Activity_71982_ActivityPlot = {
    Text = "Vous arrivez au bureau du directeur, seulement pour découvrir que la pièce est vide. Il semble que la lettre n'était qu'une farce.\nAlors que vous vous apprêtez à partir, vous apercevez du coin de l'œil un coffret cadeau exquis, avec une note attachée — À mon bien-aimé."
  },
  Activity_71983_ActivityName = {
    Text = "Cérémonie de la révélation du destin"
  },
  Activity_71983_ActivityPlot = {
    Text = "Un cliquetis résonne dans la pièce silencieuse. Lorsque vous vous avancez pour enquêter, la fenêtre ouverte révèle que l'« Invité indésirable » est déjà parti.\nLa chaude lumière du soleil tombe sur un coffret cadeau supplémentaire posé sur le bureau, dont l'écriture élégante scintille d'une lumière argentée — Que le Destin vous Bénisse à jamais."
  },
  Activity_72101_ActivityName = {
    Text = "Inversion de phase"
  },
  Activity_72101_ActivityPlot = {
    Text = "« Je veux que tout le monde jouer aux Cartes Omnipotentes ! »\nDes visiteurs venus d'autres lignes temporelles sont entrés accidentellement dans l'espace d'Échecs de Phase et l'ont transformé en une forme radicalement différente.\nPour inverser à nouveau l'espace, les Gardiens du secret de différentes lignes temporelles doivent déterminer le plus fort d'entre eux et défier ce visiteur."
  },
  Activity_72101_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant la durée de l'événement, les gardiens du secret peuvent accomplir les réalisations de « Récompenses de réalisation » en participant à « Duel de phases » et obtenir des « glands magiques ».\n2. Les « glands magiques » peuvent être utilisés dans « Récompenses tournantes » pour obtenir de nombreux cadeaux, notamment un avatar exclusif de l'événement « Tour inversé : Carte universelle », 10 émoticônes exclusives de l'événement ainsi que « Rêve brisé restant » et « Rêve des étoiles restant » entre autres.\n3. Pendant la durée de l'événement, « Connexion multidimensionnelle : Tour inversé » sera accessible gratuitement !\n4. Pendant la durée de l'événement, pour les gardiens du secret ayant terminé « Connexion multidimensionnelle : Tour inversé : Invité d'un autre monde », le décor de combat de « Duel de phases » sera temporairement remplacé par « Tour inversé : Espace de conscience ».\n\n<Title:Récompenses de réalisation>\n1. Les « Récompenses de réalisation » incluent des réalisations de victoire avec « Entité réveillée », des réalisations de victoire avec « Roue du destin », des réalisations de victoire avec « Sceau de clé » ainsi que des réalisations liées au nombre de cartes jouées. Les gardiens du secret peuvent obtenir des « glands magiques » en accomplissant ces réalisations.\n2. Utiliser différentes classes d'« Entité réveillée » dans « Duel de phases » et jouer 25 cartes permet d'obtenir 30 « glands magiques ». Chaque réalisation liée à une classe spécifique est réalisable jusqu'à 80 fois maximum.\n3. Réalisation « Entité réveillée » : Obtenir 10 « glands magiques » lorsque chaque « Entité réveillée » remporte 1/3/6/10 combats dans « Duel de phases ».\n4. Réalisation « Roue du destin » : Obtenir 10 « glands magiques » lorsque chaque « Roue du destin » remporte 1/3/6 combats dans « Duel de phases ».\n5. Réalisation « Sceau de clé » : Obtenir 10 « glands magiques » lorsque chaque « Sceau de clé » remporte 1/3/6 combats dans « Duel de phases ».\n6. Les « Entités réveillées », « Roues du destin » et « Sceaux de clé » débloqués temporairement dans le cadre de sujets principaux comptabiliseront normalement les victoires et les cartes jouées, mais il faudra posséder l'élément correspondant pour pouvoir réclamer les récompenses associées à ces réalisations.\n\n<Title:Récompenses tournantes>\n1. Les gardiens du secret peuvent obtenir des récompenses correspondantes en accumulant des « glands magiques ». En accumulant 2500 « glands magiques », il est possible d'obtenir toutes les récompenses principales, et en accumulant 5000 « glands magiques », il est possible d'obtenir toutes les récompenses !\n2. Après avoir terminé « Tour inversé : Invité d'un autre monde », les récompenses associées à l'accumulation de 100 à 900 « glands magiques » sont débloquées. Après avoir terminé « Tour inversé : L'instant universel inversé », les récompenses associées à l'accumulation de 1000 à 5000 « glands magiques » sont débloquées.\n\n<Title:Connexion multidimensionnelle>\n1. Pendant la durée de l'événement, « Connexion multidimensionnelle : Tour inversé » sera accessible gratuitement.\n2. Pendant la durée de l'événement, il faut accumuler 1000 « glands magiques » pour débloquer « Tour inversé : L'absolu de la volonté incarnée ».\n3. Après la fin de l'événement, les progrès dans « Connexion multidimensionnelle : Tour inversé » seront conservés. Si vous n'avez pas débloqué « Connexion multidimensionnelle : Tour inversé » pendant l'événement, vous pourrez quand même le débloquer après l'événement en utilisant 3 « Points de départ réels ».\n4. Quel que soit le moment où vous le terminez, vous obtiendrez toujours « Sceau de clé : Porte de la taverne » après avoir terminé « Connexion multidimensionnelle : Tour inversé ».\n\n<Title:Période de l'événement>\nCet événement ne sera disponible que du 18 mars à 9h00 au 1er avril à 9h00 (GMT+8). Après le 1er avril à 9h00 (GMT+8), l'événement se terminera, n'oubliez pas de réclamer les récompenses disponibles dans « Récompenses tournantes » !"
  },
  Activity_72101_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_72101_UnlockConditionExplanation = {
    Text = "Débloqué après avoir terminé \"Opération d'enquête\" 3-2·Normal"
  },
  Activity_73680_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_73680_ActivityPlot = {
    Text = "Après l'achat, « Fusion · Daur » peut être activé\n<BlueQuality:Profondissement de personnalité +4, déverrouiller la surexaltation>"
  },
  Activity_73681_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_73681_ActivityPlot = {
    Text = "Après l'achat, « Fusion · Dore » peut activer <BlueQuality: Illumination 3>"
  },
  Activity_73879_ActivityName = {
    Text = "Alignement des étoiles · Répétition"
  },
  Activity_73879_ActivityPlot = {
    Text = "L'heure de l'Alignement stellaire approche, le mouvement dans sa poitrine résonne comme un tambour.\nLes sombres cauchemars qui l'ont tourmentée pendant des années culminent dans la fin larmoyante d'innombrables fidèles.\nDe Ses@1 ténèbres@2, le grand@3 fait son Avènement dans le monde."
  },
  Activity_73879_ActivityStageEndContent = {
    Text = "L'événement est terminé. Actuellement, seule l'« Incubation du Saint Embryon » est disponible."
  },
  Activity_73879_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, le gardien peut collecter trois types d'« embryons » via les modes temporaires « Utérus ténébreux » et les « Récompenses de réalisations ». Ces embryons pourront être échangés contre des objets récompenses dans « Incubation de l'embryon sacré », incluant notamment la roue fatale SR exclusive à l'événement « Sommeil sous les glaces », le Cœur immaculé, le Cœur lumineux, des éclats de pierre précieuse et des cristaux imitant.\n2. Pendant l'événement, en accomplissant les tâches des « Récompenses de réalisations », vous obtiendrez l'avatar exclusif « Au nom de la clé d'argent : Murphy », la roue fatale SR exclusive à l'événement « Sommeil sous les glaces » ainsi qu'un grand nombre d'« embryons ».\n\n<Title:Période de l'événement>\n1. Du 10 mars 9h00 au 24 mars 9h00 (GMT+8), toutes les activités seront disponibles.\n2. Du 24 mars 9h00 au 31 mars 9h00 (GMT+8), seules les fonctions « Incubation de l'embryon sacré » et « Récompenses de réalisations » resteront actives. Les autres contenus seront indisponibles.\n\n<Title:Utérus ténébreux>\n1. « Utérus ténébreux » contient 7 niveaux, un nouveau niveau s'ouvre automatiquement chaque jour.\n2. Chaque tentative consomme 120 points de morphine. En cas de succès, vous obtenez les monnaies événementielles « embryon inconscient », « embryon sans désir » et « embryon insatiable ».\n3. Après avoir terminé un niveau, la fonction « Récurrence » de ce niveau est débloquée. Veuillez noter : la fonction « Récurrence » ne permet pas d'obtenir de taux de synchronisation.\n4. Vous pouvez utiliser l'aide des Alumni pour faciliter la réussite des niveaux.\n5. Après avoir terminé n'importe quelle difficulté d'un niveau, la difficulté folle de ce niveau est débloquée. Terminer pour la première fois la difficulté folle permet d'obtenir de généreuses récompenses en monnaie événementielle.\n6. Veuillez noter : la difficulté folle ne consomme pas de morphine, ne peut pas être récurrente, et les tentatives répétées après la première réussite ne donnent plus de récompenses en monnaie événementielle.\n\n<Title:Bonus d'embryon>\n1. Si le gardien possède certains éveils ou roues fatales spécifiques (pas nécessairement en équipe active), les récompenses de mission des niveaux « Utérus ténébreux » incluant les « embryons inconscients », les « embryons sans désir » et les « embryons insatiables » bénéficieront d'un bonus supplémentaire (incluant la récurrence). Les bonus sont les suivants :\n· Éveil « Murphy » : Éveil 0/1/2/3 et plus, bonus de 20%/30%/40%/50%\n· Roue fatale SSR « Naissance secrète » : Stacks 0/1/2/3 et plus, bonus de 20%/30%/40%/50%\n· Roue fatale SR « Sommeil sous les glaces » : Stacks 0/1/2/3 et plus, bonus de 20%/30%/40%/50%\n2. Les bonus d'embryon de différents éveils ou roues fatales s'additionnent.\n3. À noter toutefois, les récompenses de la première réussite en difficulté folle ne sont pas affectées par les bonus d'embryon.\n\n<Title:Incubation de l'embryon sacré>\n1. « Incubation de l'embryon sacré » ne sera disponible que du 10 mars 9h00 au 31 mars 9h00 (GMT+8).\n2. Après le 31 mars 9h00 (GMT+8), les embryons restants non échangés seront recyclés en « Billets d'or *40 » chacun. Veuillez vérifier vos messages pour récupérer ces récompenses."
  },
  Activity_73879_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_74213_ActivityName = {
    Text = "Hommage au parcours · Étoile I"
  },
  Activity_74213_ActivityPlot = {
    Text = "Un souvenir scellé et archivé, un voyage enregistré dans le passé. Dans les moments de souvenir, n'oubliez pas d'offrir votre Visite révérencieuse."
  },
  Activity_74340_ActivityName = {
    Text = "Tour inverse"
  },
  Activity_74364_ActivityName = {
    Text = "Manuel du détective · Rétro"
  },
  Activity_74364_ActivityPlot = {
    Text = "Ces pages renferment les enseignements aiguisés d'un maître détective, forgés au fil d'une vie entière consacrée à la résolution de mystères.\nUn guide conçu pour éveiller l'intuition et affûter l'intellect des enquêteurs en herbe."
  },
  Activity_74364_ActivityStageEndContent = {
    Text = "L'événement est terminé. Actuellement, seul \"Club de Bonne Chance\" est disponible."
  },
  Activity_74364_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, les Gardiens du secret peuvent collecter la monnaie d'événement « Jetons décisifs » via le mode temporaire « Légende de la nuit lunaire » et les « Récompenses de réalisations ». Les « Jetons décisifs » peuvent être échangés contre de riches récompenses dans le « Club de la Chance », incluant la Roue du Destin SR exclusive à l'événement « Roue de la Fortune », le Cœur Immaculé, le Cœur de Lumens, les Éclats de Pierre Sage et les Cristal de Mimesis, etc.\n2. Pendant l'événement, en accomplissant les tâches des « Récompenses de réalisations », vous pourrez obtenir l'avatar exclusif à l'événement « Au nom de la Clé d'argent : Ryker », la Roue du Destin SR exclusive à l'événement « Roue de la Fortune », le Cœur d'argent et une grande quantité de monnaie d'événement « Jetons décisifs ».\n3. Pendant l'événement, l'« Enregistrement de la task force : Bonne chasse ! » sera disponible gratuitement.\n\n<Title:Période de l'événement>\n1. Du 22 septembre à 9h00 au 6 octobre à 9h00 (GMT+8), toutes les activités seront disponibles.\n2. Du 6 octobre à 9h00 au 13 octobre à 9h00 (GMT+8), seuls le « Club de la Chance » et les « Récompenses de réalisations » seront disponibles ; les autres contenus seront terminés et inaccessibles.\n\n<Title:Légende de la nuit lunaire>\n1. « Légende de la nuit lunaire » contient 9 étapes, une étape s'ouvre automatiquement chaque jour.\n2. Chaque défi consomme 120 points de Ménophine, en défiant des étapes différentes, vous obtiendrez non seulement des matériaux de chute différents, mais aussi la monnaie d'événement « Jetons décisifs ».\n3. Les étapes de cet événement sont des étapes de combat liées aux matériaux et peuvent être « rejouées » après les avoir terminées ! Chaque « replay » consomme 120 points de Ménophine.\n4. Veuillez noter : en utilisant la fonction « replay », vous ne pourrez pas obtenir de taux de synchronisation.\n\n<Title:Bonus de jetons>\n1. Si le Gardien possède un certain Éveilleur ou Roue du Destin (pas nécessairement déployé), il obtiendra un bonus supplémentaire sur les « Jetons décisifs » obtenus dans les récompenses des étapes de « Légende de la nuit lunaire » (y compris le replay), les bonus spécifiques sont les suivants :\nÉveilleur « Ryker » : Dégagement 0/1/2/3 et plus, bonus de 20%/30%/40%/50%\nRoue du Destin SSR « Moment Propice » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%\nRoue du Destin SR « Roue de la Fortune » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%\n2. Les « Bonus de jetons » de différents Éveilleurs ou Roues du Destin s'additionnent.\n3. En particulier, les récompenses du premier passage en difficulté Folie ne sont pas affectées par le « Bonus de jetons ».\n\n<Title:Club de la Chance>\n1. Le « Club de la Chance » ne sera disponible que du 22 septembre à 9h00 au 13 octobre à 9h00 (GMT+8).\n2. Après le 13 octobre à 9h00 (GMT+8), les « Jetons décisifs » restants non échangés seront récupérés au taux de « Billet Rose Dorée ×40 » par jeton. Veuillez vérifier vos messages.\n\n<Title:Enregistrement de la task force>\n1. Pendant l'événement, l'« Enregistrement de la task force : Bonne chasse ! » sera disponible gratuitement.\n2. À la fin de l'événement, les progrès de l'enquête de l'« Enregistrement de la task force : Bonne chasse ! » seront conservés. Si vous ne l'avez pas débloqué pendant l'événement, vous pourrez toujours le débloquer après l'événement en consommant « Point de départ réel » ×7.\n3. Quel que soit le moment, après avoir terminé l'« Enregistrement de la task force : Bonne chasse ! », vous pourrez obtenir « Sésame : Un coup de feu ».\n\n<Title:Compensation de réimpression>\n1. Les Gardiens du secret ayant déjà débloqué l'« Enregistrement de la task force : Bonne chasse ! » recevront une compensation de « Jetons décisifs » ×700 s'ils le redébloquent pendant cette réimpression.\n2. Les Gardiens du secret ayant déjà obtenu l'avatar exclusif à l'événement « Au nom de la Clé d'argent : Ryker » verront les doublons automatiquement convertis en « Invitation des sans-visage » ×1."
  },
  Activity_74364_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_74365_ActivityName = {
    Text = "Bonne chasse !"
  },
  Activity_76217_ActivityName = {
    Text = "Voyage intertemporel"
  },
  Activity_76217_ActivityTips = {
    Text = "Règles de l'événement : \n1. Après avoir terminé les tâches désignées, les récompenses peuvent être réclamées dans « Voyage intertemporel ». \n2. « Voyage intertemporel » est ouvert en permanence. \n3. Après avoir déverrouillé « Voyage avancé », des récompenses supplémentaires peuvent être obtenues en accomplissant des missions. \n4. Veuillez noter : Le « Voyage avancé » déverrouillé dans cet événement n'est valide que pour cet événement. Veuillez gérer vos dépenses avec sagesse, gardien du secret."
  },
  Activity_76218_ActivityName = {
    Text = "Chronique de l'Arrivée"
  },
  Activity_76218_ActivityTips = {
    Text = "Règles de l'événement :\n1. Après avoir terminé les missions de voyage désignées, les récompenses peuvent être réclamées dans « Chronique de l'Arrivée ».\n2. « Chronique de l'Arrivée » est ouvert en permanence.\n3. Une fois le « Voyage Avancé » déverrouillé, des récompenses supplémentaires peuvent être obtenues après avoir accompli les missions.\n4. Veuillez noter : Le « Voyage Avancé » déverrouillé dans le cadre de cet événement n'est valide que pendant cet événement. Veuillez gérer vos dépenses avec sagesse, gardien du secret."
  },
  Activity_77970_ActivityName = {Text = "Pollux"},
  Activity_77970_ActivityTips = {
    Text = "<Title:Règles de l'événement>\n· Pendant la période de l'événement « Pollux », les gardiens peuvent utiliser des équipes prédéfinies incluant Pollux pour expérimenter indéfiniment les niveaux désignés.\n· Lors de l'expérience des niveaux de l'événement, il est impossible d'ajuster les corps réveillés dans l'équipe.\n<Title:Récompenses de l'événement>\n· Après avoir accompli le défi du niveau pour la première fois, il est possible de recevoir les récompenses d'essai à l'interface de l'événement."
  },
  Activity_77972_ActivityName = {
    Text = "Shaggai hypnotique"
  },
  Activity_77972_ActivityTips = {
    Text = "<Title:Règlement de l'événement>\n· Pendant l'événement « Ver hypnotiseur », le gardien peut utiliser l'équipe prédéfinie du système incluant Clémentine pour expérimenter indéfiniment les niveaux désignés.\n· Lors de l'expérience des niveaux événementiels, il n'est pas possible d'ajuster les entités éveillées dans l'équipe.\n<Title:Récompenses de l'événement>\n· Après avoir accompli le défi du niveau pour la première fois, il est possible de recevoir la récompense d'essai depuis l'interface de l'événement."
  },
  Activity_77974_ActivityName = {
    Text = "Lueur de Mareel"
  },
  Activity_77974_ActivityTips = {
    Text = "<Title:Règles de l'événement>\n· Pendant l'événement « Lumière froide », le gardien peut utiliser l'équipe prédéfinie du système incluant Kephasant pour expérimenter indéfiniment les niveaux désignés.\n· Lors de l'expérience des niveaux de l'événement, il n'est pas possible d'ajuster les entités éveillées dans l'équipe.\n<Title:Récompenses de l'événement>\n· Après avoir accompli le défi du niveau pour la première fois, il est possible de recevoir les récompenses d'essai depuis l'interface de l'événement."
  },
  Activity_77977_ActivityName = {
    Text = "Blanche-Neige la Fée"
  },
  Activity_77977_ActivityTips = {
    Text = "<Title:Règles de l'événement>\nPendant l'événement «Blanche-Neige la Fée», les Gardiens du secret peuvent utiliser des formations prédéfinies par le système incluant «Caraboo» pour expérimenter des étapes désignées un nombre illimité de fois.\n Lors de l'expérience des étapes de l'événement, les Éveilleurs de la formation ne peuvent pas être modifiés.\n<Title:Récompenses de l'événement>\nAprès avoir complété le défi d'une étape pour la première fois, vous pouvez réclamer les récompenses d'essai sur l'interface de l'événement."
  },
  Activity_77979_ActivityName = {
    Text = "Maître de l'explosion"
  },
  Activity_77979_ActivityTips = {
    Text = "<Title:Règles de l'événement>\n· Pendant l'événement « Maître de l'explosion », le gardien peut utiliser l'équipe prédéfinie incluant Katyura pour expérimenter indéfiniment les niveaux désignés.\n· Lors de l'expérience des niveaux événementiels, il n'est pas possible d'ajuster l'éveillé dans l'équipe.\n<Title:Récompenses de l'événement>\n· Après avoir accompli le défi du niveau pour la première fois, il est possible de recevoir la récompense d'essai depuis l'interface de l'événement."
  },
  Activity_77980_ActivityName = {
    Text = "Tela Perpetua"
  },
  Activity_77980_ActivityTips = {
    Text = "<Title:Règles de l'événement>\nPendant l'événement « Tela Perpetua », le Gardien peut utiliser l'équipe prédéfinie du système incluant Arachne pour expérimenter indéfiniment les niveaux désignés.\nLors de l'expérience des niveaux de l'événement, il est impossible d'ajuster les Corps éveillés dans l'équipe.\n<Title:Récompenses de l'événement>\nAprès avoir accompli le défi du niveau pour la première fois, il est possible de recevoir la récompense d'essai depuis l'interface de l'événement."
  },
  Activity_77984_ActivityName = {Text = "Le peintre"},
  Activity_77984_ActivityTips = {
    Text = "<Title:Règlement de l'événement>\n· Pendant la période de l'événement « Sculpteur », le gardien peut utiliser des équipes prédéfinies contenant Pickman pour expérimenter les niveaux désignés autant de fois qu'il le souhaite. \n· Lors de l'expérience des niveaux de l'événement, il n'est pas possible d'ajuster les Éveillés dans l'équipe. \n<Title:Réccompenses de l'événement>\n· Après avoir réussi le défi du niveau pour la première fois, vous pouvez réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_78501_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_78501_ActivityPlot = {
    Text = "Après l'achat, « Pharaon noir » peut être activé\n<BlueQuality:Profondissement de personnalité +4, déverrouiller la surexaltation>"
  },
  Activity_78502_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_78502_ActivityPlot = {
    Text = "Après l'achat, « Arachné » peut être activée\n<BlueQuality:Profondissement de personnalité +4, déverrouiller la surexaltation>"
  },
  Activity_78503_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_78503_ActivityPlot = {
    Text = "Après l'achat, « Cephasant » peut être activé<BlueQuality:Illumination 3>"
  },
  Activity_78505_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_78505_ActivityPlot = {
    Text = "Après achat, \"Clémentine\" peut activer\n<BlueQuality:Profondissement de la personnalité +4, Déverrouiller l'Over-Exaltation>"
  },
  Activity_78506_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_78506_ActivityPlot = {
    Text = "Après l'achat, « Pharaon noir » peut être activé <BlueQuality:Illumination 3>"
  },
  Activity_78507_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_78507_ActivityPlot = {
    Text = "Après l'achat, « vautour » peut être activé <BlueQuality:Illumination 3>"
  },
  Activity_78508_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_78508_ActivityPlot = {
    Text = "Après l'achat, « Aforgamon » peut être activé <BlueQuality:Illumination 3>"
  },
  Activity_78509_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_78509_ActivityPlot = {
    Text = "Après l'achat, « Pollux » peut être activé <BlueQuality:Illumination 3>"
  },
  Activity_78511_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_78511_ActivityPlot = {
    Text = "Après l'achat, « Karabu » peut être activé\n<BlueQuality:Profondissement de personnalité +4, déverrouiller la surexaltation>"
  },
  Activity_78513_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_78513_ActivityPlot = {
    Text = "Après l'achat, « Arachné » peut être activé <BlueQuality:Illumination 3>"
  },
  Activity_78514_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_78514_ActivityPlot = {
    Text = "Après l'achat, « Pickman » peut être activé <BlueQuality:Illumination 3>"
  },
  Activity_78515_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_78515_ActivityPlot = {
    Text = "Après l'achat, « Pickman » peut être activé\n<BlueQuality:Profondissement de personnalité +4, déverrouillage de la surexaltation>"
  },
  Activity_78516_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_78516_ActivityPlot = {
    Text = "Après l'achat, « Clémentine » peut être activée <BlueQuality:Illumination 3>"
  },
  Activity_78517_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_78517_ActivityPlot = {
    Text = "Après l'achat, « Kephasant » peut être activé\n<BlueQuality:Profondissement de personnalité +4, déverrouillage de la surexaltation>"
  },
  Activity_78518_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_78518_ActivityPlot = {
    Text = "Après l'achat, « Vautour » peut être activé\n<BlueQuality:Profondissement de personnalité +4, déverrouiller la surexaltation>"
  },
  Activity_78519_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_78519_ActivityPlot = {
    Text = "Après l'achat, « l'oiseau Shathak » peut être activé\n<BlueQuality:Profondissement de personnalité +4, déverrouillage de la surexaltation>"
  },
  Activity_78521_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_78521_ActivityPlot = {
    Text = "Après l'achat, « Pollux » peut être activé\n<BlueQuality:Profondissement de personnalité +4, déverrouillage de la surexaltation>"
  },
  Activity_78523_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_78523_ActivityPlot = {
    Text = "Après l'achat, « Aforgomon » peut être activé\n<BlueQuality:Profondissement de personnalité +4, déverrouiller la surexaltation>"
  },
  Activity_78524_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_78524_ActivityPlot = {
    Text = "Après l'achat, « Lantigos » peut être activé\n<BlueQuality:Profondissement de personnalité +4, déverrouillage de la surexaltation>"
  },
  Activity_78525_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_78525_ActivityPlot = {
    Text = "Après achat, \"Castor\" peut activer\n<BlueQuality:Profondissement de la personnalité +4, Déverrouiller l'Over-Exaltation>"
  },
  Activity_78526_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_78526_ActivityPlot = {
    Text = "Après l'achat, « Kattygura » peut être activée <BlueQuality:Illumination 3>"
  },
  Activity_78531_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_78531_ActivityPlot = {
    Text = "Après l'achat, « Shartak » peut être activé<BlueQuality:Illumination 3>"
  },
  Activity_78532_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_78532_ActivityPlot = {
    Text = "Après l'achat, « Karabu » peut être activé<BlueQuality:Illumination 3>"
  },
  Activity_78533_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_78533_ActivityPlot = {
    Text = "Après l'achat, « Castor » peut être activé <BlueQuality:Illumination 3>"
  },
  Activity_78534_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_78534_ActivityPlot = {
    Text = "Après l'achat, « Lantigos » peut être activé<BlueQuality:Illumination 3>"
  },
  Activity_78536_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_78536_ActivityPlot = {
    Text = "Après l'achat, « Catigura » peut être activée\n<BlueQuality: Profondissement de personnalité +4, déverrouillage de la surexaltation>"
  },
  Activity_78651_ActivityName = {
    Text = "Fission Calme"
  },
  Activity_78652_ActivityName = {
    Text = "Soins multiples·Réplique"
  },
  Activity_78652_ActivityPlot = {
    Text = "Symptôme : Hystérie, également connu sous le nom de trouble hystérique.\nÀ votre époque, c'est synonyme de mort.\n\nHeureusement, les scientifiques et enquêteurs de Mizag sont tout aussi fous : ils sont déterminés à résoudre ce problème"
  },
  Activity_78652_ActivityStageEndContent = {
    Text = "L'événement est terminé. Actuellement, seule \"Analyse de Personnalité\" est disponible."
  },
  Activity_78652_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, le Gardien peut collecter la devise d'événement « Puzzle mémoriel » via les modes temporaires « Encodage de mémoire », « Stockage marginal » et « Récompenses de succès ». Les « Puzzles mémoriels » peuvent être utilisés dans « Analyse de personnalité » pour acheter des articles, notamment la Roue du Destin SR exclusive à l'événement « Résolution du cabillaud argenté », des Cœurs Immaculés, des Cœurs de Lumens, etc.\n2. Pendant l'événement, le « Dossier spécial : La fission tranquille » sera déverrouillé gratuitement pendant une durée limitée. En accomplissant les succès de l'événement, vous pourrez également obtenir un avatar exclusif à l'événement « Au nom de la Clé d'argent : »24« » !\n\n<Title:Période de l'événement>\n1. Du 21 avril à 9h00 au 5 mai à 9h00(GMT+8), tous les modes de l'événement seront disponibles.\n2. Du 5 mai à 9h00 au 12 mai à 9h00(GMT+8), seules les fonctions « Analyse de personnalité » et « Récompenses de succès » seront disponibles.\n\n<Title:Encodage de mémoire>\n1. « L'encodage de mémoire » contient 5 niveaux, un niveau s'ouvrira automatiquement tous les 2 jours.\n2. Chaque défi consommera 120 points d'endorphine, et en cas de succès, vous obtiendrez la devise de l'événement.\n3. Une fois le niveau terminé, la fonction « Récurrence » de ce niveau sera débloquée. Veuillez noter que vous ne pourrez pas obtenir de taux de synchronisation en utilisant la fonction « Récurrence ».\n4. Vous pouvez utiliser l'aide de l'Alumni et de la « Résonance : Syndrome dissociatif » pour passer les niveaux plus facilement.\n\n<Title:Bonus de Raisonnement>\n1. Si le Gardien possède un Éveilleur ou une Roue du Destin spécifique(pas nécessairement en jeu), il obtiendra un bonus supplémentaire sur les « Puzzles mémoriels » reçus dans les récompenses des missions des niveaux « Encodage de mémoire ». Les bonus spécifiques sont les suivants :\nÉveilleur « 24 » : Dégagement 0/1/2/3 ou supérieur, bonus de 20%/30%/40%/50%.\nRoue du Destin SSR « Rétroaction du corps déformé » : Superposition 0/1/2/3 ou supérieur, bonus de 20%/30%/40%/50%.\nRoue du Destin SR « Résolution du cabillaud argenté » : Superposition 0/1/2/3 ou supérieur, bonus de 20%/30%/40%/50%.\n2. Les « Bonus de raisonnement » de différents Éveilleurs ou Roues du Destin s'additionnent.\n3. À noter que les récompenses de la première réussite en mode Folie ne sont pas affectées par les « Bonus de raisonnement ».\n\n<Title:Résonance : Syndrome dissociatif>\n1. Le Gardien peut obtenir « Cœur scindé » en accomplissant les succès de l'événement.\n2. En consommant « Cœur scindé », activez la « Résonance : Syndrome dissociatif » pour obtenir les bonus suivants :\n(1) Rendre le Gardien plus fort dans le mode événement « Encodage de mémoire » et le « Dossier spécial : La fission tranquille », rendant les défis plus faciles.\n(2) Améliorer les récompenses reçues après avoir relevé un défi dans « Encodage de mémoire ».\n(3) Activer le mode événement « Stockage marginal ».\n\n<Title:Stockage marginal>\n1. Après avoir activé la résonance « Diagnostic : Fissure de personnalité », vous obtenez automatiquement 60 « Puzzle de Mémoire α » par heure, avec un maximum de 25 heures de stockage.\n2. Après avoir activé la résonance « Synchronisation cognitive », vous obtenez automatiquement 30 « Puzzle de Mémoire β » par heure, avec un maximum de 25 heures de stockage.\n\n<Title:Dossier spécial>\n1. Pendant l'événement, le « Dossier spécial : La fission tranquille » peut être déverrouillé gratuitement.\n2. À la fin de l'événement, les progrès du « Dossier spécial : La fission tranquille » seront conservés. Même après la fin de l'événement, vous pourrez obtenir les mêmes récompenses que pendant l'événement en terminant les missions non accomplies. Si vous n'avez pas déverrouillé le « Dossier spécial : La fission tranquille » pendant l'événement, vous pourrez toujours le déverrouiller après l'événement en consommant 7 « Point de départ réel ».\n3. Quel que soit le moment où vous le déverrouillez, en terminant le « Dossier spécial : La fission tranquille », vous obtiendrez « Sceau : Tout d'elle ».\n\n<Title:Compensation de réédition>\n1. Les Gardiens du secret qui ont déjà déverrouillé le « Dossier spécial : La fission tranquille » recevront une compensation de 700 « Puzzle de Mémoire α » lorsqu'ils le redéverrouilleront pendant cette réédition.\n2. Les Gardiens du secret qui ont déjà obtenu l'avatar exclusif à l'événement « Au nom de la Clé d'argent : »24« » verront les doublons automatiquement convertis en 1 « Invitation de l'Incorporel ».\n3. Les Gardiens du secret qui ont déjà obtenu le matériau nécessaire pour activer la résonance « Cœur scindé » verront chaque « Cœur scindé » supplémentaire automatiquement converti en 5000 « Billet Rose Dorée ».\n"
  },
  Activity_78652_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_78722_ActivityName = {
    Text = "Courant sombre et chants d'insectes · Précommande limitée"
  },
  Activity_78722_ActivityTips = {
    Text = "<Title: Écho des Insectes dans l'Obscurité - Précommande Limitée>\n·L'offre de précommande limitée comprend 8 packs. Le premier pack peut être récupéré gratuitement, tandis que les packs 2 à 8 seront disponibles uniquement après l'achat de « Écho des Insectes dans l'Obscurité - Précommande Limitée ».\n·Après avoir acheté « Écho des Insectes dans l'Obscurité - Précommande Limitée », vous pourrez immédiatement récupérer la récompense du deuxième pack ; les packs suivants devront être récupérés après un délai d'attente spécifique.\n·L'achat de « Écho des Insectes dans l'Obscurité - Précommande Limitée » est soumis à une limite de temps. Passé ce délai, il ne sera plus possible de l'acheter. Veuillez, Archivistes, effectuer vos achats avant le 7 avril à 9h00."
  },
  Activity_78751_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_78751_ActivityPlot = {
    Text = "Après l'achat, « Seigneur Endormi de l'Origine » peut activer <BlueQuality:Illumination 3>"
  },
  Activity_78752_ActivityName = {
    Text = "Texte temporaire"
  },
  Activity_78752_ActivityTips = {
    Text = "<Title:Règles de l'événement>\nPendant l'événement «Origine : Royaume», les Gardiens du secret peuvent utiliser des équipes prédéfinies par le système incluant Origine : Royaume pour expérimenter des niveaux désignés un nombre illimité de fois.\nLors de l'expérience des niveaux de l'événement, les modifications des Éveilleurs dans la formation de l'équipe ne peuvent pas être effectuées.\n<Title:Récompenses de l'événement>\nAprès avoir complété le défi d'un niveau pour la première fois, vous pouvez réclamer les récompenses de démonstration sur l'interface de l'événement."
  },
  Activity_78753_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_78753_ActivityPlot = {
    Text = "Après l'achat, « Maître du Sommeil Originel » peut être activé\n<BlueQuality:Profondissement de personnalité +4, déverrouillage de la surexaltation>"
  },
  Activity_78776_ActivityName = {
    Text = "Genèse Fond marin Dame des mers"
  },
  Activity_78776_ActivityTips = {
    Text = "<Title:Règles de l'événement>\n· Lors de l'ouverture de l'événement « Dame des Profondeurs Originelles », le gardien du secret peut utiliser l'équipe prédéfinie incluant « Dame des Profondeurs Originelles » pour expérimenter indéfiniment les niveaux désignés.\n· Lors de l'expérience du niveau événementiel, il est impossible d'ajuster l'éveillé dans la formation.\n<Title:Récompenses de l'événement>\n· Après avoir accompli le défi du niveau pour la première fois, il est possible de recevoir la récompense d'essai à l'interface événementielle."
  },
  Activity_78777_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_78777_ActivityPlot = {
    Text = "Après l'achat, « Dame des Profondeurs Marines Originelles » peut être activée <BlueQuality:Illumination 3>"
  },
  Activity_78778_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_78778_ActivityPlot = {
    Text = "Après l'achat, « Dame des Profondeurs Marines Originelles » peut être activée\n<BlueQuality:Profondissement de personnalité +4, déverrouillage de la surexaltation>"
  },
  Activity_78790_ActivityName = {
    Text = "Événement de déblocage gratuit"
  },
  Activity_78791_ActivityName = {
    Text = "Au moment de la fonte de la montagne de neige · Répétition"
  },
  Activity_78791_ActivityPlot = {
    Text = ": La neige d'Elworth ne fond jamais, tout comme sa haine. \nLorsque le futur et le passé s'entrelacent, le guerrier brandira sa lame, lançant une charge de vengeance contre le destin. \nQuand elle fait face aux vagues noires, tu es son étendard"
  },
  Activity_78791_ActivityStageEndContent = {
    Text = "Événement terminé, participation actuelle uniquement à «Gueule de la montagne»"
  },
  Activity_78791_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, les gardiens peuvent collecter trois types de « bourgeons » via le mode temporaire « Cœur de bête » et les récompenses de succès. Les « bourgeons » peuvent être échangés dans la « Gueule des montagnes » pour obtenir des récompenses, incluant notamment la roue fatale SR exclusive de l'événement « Jusqu'à ce que la neige fonde », des Cœurs Immaculés, des Cœurs de Lumens, des éclats de sagesse et des Cristaux de Mimesis.\n2. Pendant l'événement, le « Dossier spécial : Le Retour de Elvworth » sera accessible gratuitement.\n\n<Title:Période de l'événement>\n1. Du 19 mai 9h00 au 2 juin 9h00 (GMT+8), toutes les activités seront disponibles.\n2. Du 2 juin 9h00 au 9 juin 9h00 (GMT+8), seules la « Gueule des montagnes » et les récompenses de succès resteront actives, les autres contenus seront indisponibles.\n\n<Title:Cœur de bête>\n1. « Cœur de bête » contient 5 étapes, une étape s'ouvre automatiquement tous les 2 jours.\n2. Chaque défi consomme 120 points d'endorphine. En cas de succès, vous obtenez la monnaie d'événement « Bouton de fleur gelé », « Bouton de fleur d'argent givré » et « Bouton de soleil ».\n3. Une fois un étage terminé, la fonction « Répétition » de cet étage est débloquée. Veuillez noter : la « Répétition » ne permet pas d'obtenir de taux de synchronisation.\n4. Vous pouvez utiliser l'aide des Alumni et la « Résonance : Dévorer les Montagnes » pour faciliter le passage.\n5. Le deuxième jour suivant le déblocage d'un étage, sa difficulté « Folie » est débloquée. La première réussite en difficulté Folie offre une importante quantité de monnaie d'événement.\n6. Veuillez noter : la difficulté Folie ne consomme pas d'endorphine, ne peut pas être répétée et ne donne plus de monnaie d'événement après la première réussite.\n\n<Title:Bonus de bourgeons>\n1. Si le gardien possède un réveilleur ou une roue fatale spécifique (non nécessaire en équipe), il obtient un bonus supplémentaire sur les « Boutons de fleur gelé », « Boutons de fleur d'argent givré » et « Boutons de soleil » obtenus via les missions des étages de « Cœur de bête » (incluant la répétition). Voici les détails :\n· Réveilleur « Helot : Enchaînée » : Dégagement 0/1/2/3 ou supérieur, bonus de 20%/30%/40%/50%\n· Roue fatale SSR « Couler dans le rouge » : Superposition 0/1/2/3 ou supérieur, bonus de 20%/30%/40%/50%\n· Roue fatale SR « Jusqu'à ce que la neige fonde » : Superposition 0/1/2/3 ou supérieur, bonus de 20%/30%/40%/50%\n2. Les bonus de « Bourgeons » de différents réveilleurs ou roues fatales s'additionnent.\n3. À noter toutefois que la récompense de la première réussite en difficulté Folie n'est pas affectée par les bonus de « Bourgeons ».\n\n<Title:Résonance : Dévorer les Montagnes>\n1. Les gardiens peuvent obtenir « Cœur dévorant » en complétant les succès d'événement.\n2. En consommant « Cœur dévorant », activez la « Résonance : Dévorer les Montagnes », ce qui rendra le gardien plus fort dans le mode événement « Cœur de bête » et facilitera les défis.\n\n<Title:Gueule des montagnes>\n1. La « Gueule des montagnes » dispose de trois boutiques d'échange, avec les dates d'ouverture suivantes :\n· « Ambition dévorante » : ouverture le 19 mai à 9h00.\n· « Désir de vengeance » : ouverture le 21 mai à 9h00.\n· « Espoir de renaissance » : ouverture le 23 mai à 9h00.\n2. Chaque échange consomme 750 unités de « Bouton de fleur gelé » / « Bouton de fleur d'argent givré » / « Bouton de soleil », et offre aléatoirement 5 objets parmi ceux disponibles dans la boutique.\n3. Les récompenses des boutiques sont divisées en « Objet spécial » et « Objet ordinaire ». Lors d'une réinitialisation, la quantité restante des objets spéciaux est remise à son maximum. Les règles détaillées sont les suivantes :\n(1) Premières 2 réinitialisations : lorsque les « Objet spécial » sont épuisés, le gardien peut choisir de réinitialiser, ce qui remettra à zéro la quantité restante des « Objet spécial » et « Objet ordinaire » ; il peut aussi continuer à échanger, et une fois les « Objet ordinaire » épuisés, il devra réinitialiser avant de continuer.\n(2) À partir de la 3e réinitialisation : la réinitialisation n'est possible qu'après épuisement des « Objet ordinaire ». La réinitialisation remettra à zéro la quantité restante des « Objet ordinaire », mais pas celle des « Objet spécial ».\n4. Après le 9 juin à 9h00 (GMT+8), les « bourgeons » non échangés seront récupérés au taux de « Billet Rose Dorée*40 » par unité. Veuillez vérifier vos messages.\n\n<Title:Dossier spécial>\n1. Pendant l'événement, le « Dossier spécial : Le Retour de Elvworth » sera accessible gratuitement. Après avoir terminé le « Dossier spécial : Le Retour de Elvworth », vous pourrez obtenir la roue fatale SR exclusive de l'événement « Jusqu'à ce que la neige fonde » et d'autres récompenses dans les succès. Les récompenses de succès ne sont disponibles qu'en cours d'événement, et ne pourront plus être obtenues après la fin de l'événement.\n2. Après la fin de l'événement, les progrès du « Dossier spécial : Le Retour de Elvworth » seront conservés. Si vous n'avez pas débloqué le « Dossier spécial : Le Retour de Elvworth » pendant l'événement, vous pourrez toujours le débloquer après en consommant 7 « Point de départ réel ».\n3. Quel que soit le moment du passage, vous obtenez toujours le « Sceau clé : l'éveil des Montagnes » après avoir terminé le « Dossier spécial : Le Retour de Elvworth »."
  },
  Activity_78791_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_79851_ActivityName = {
    Text = "Éclat argenté - Départ · Offre spéciale de premier passage"
  },
  Activity_79851_ActivityPlot = {
    Text = "L'éclat d'Argent accorde une Bénédiction sincère à chaque parcours de Gardien Nouveau–né guéri. Que la Clé d'Argent éclaire ton chemin.\n*Après l'achat, il peut être utilisé dans « Fournitures – Consommables. »"
  },
  Activity_80163_ActivityName = {
    Text = "Patient dissociatif : ultra"
  },
  Activity_80163_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Lors de l'événement \"Patient Divisé : Ultra\", les Gardiens peuvent utiliser des équipes prédéfinies par le système comprenant \"24\" pour vivre des niveaux désignés à l'infini.\n·Lors de l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir terminé avec succès le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_80164_ActivityName = {
    Text = "Patient dissociatif : caro"
  },
  Activity_80164_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Lors de l'événement \"Patient Divisé : Caro\", les Gardiens peuvent utiliser des équipes prédéfinies par le système comprenant \"24\" pour vivre des niveaux désignés à l'infini.\n·Lors de l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir terminé avec succès le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_80165_ActivityName = {
    Text = "Patient dissociatif : aequor"
  },
  Activity_80165_ActivityTips = {
    Text = "<Title:Règles de l'activité>\n·Pendant l'événement \"Patient Éclaté: Aequor\", les Gardiens peuvent utiliser des équipes prédéfinies par le système contenant \"24\" pour expérimenter des niveaux désignés un nombre illimité de fois.\n·Lors de la réalisation des niveaux d'événement, des ajustements au Réveiller dans la composition de l'équipe ne peuvent pas être effectués.\n<Title:Récompenses de l'activité>\n·Après avoir réussi un défi de niveau pour la première fois, vous pouvez réclamer des récompenses d'essai depuis l'interface de l'événement."
  },
  Activity_80166_ActivityName = {
    Text = "Patient dissociatif : chaos"
  },
  Activity_80166_ActivityTips = {
    Text = "<Title:Règles de l'activité>\n·Pendant l'événement \"Patient Éclaté: Chaos\", les Gardiens peuvent utiliser des équipes prédéfinies par le système contenant \"24\" pour expérimenter des niveaux désignés un nombre illimité de fois.\n·Lors de la réalisation des niveaux d'événement, des ajustements au Réveiller dans la composition de l'équipe ne peuvent pas être effectués.\n<Title:Récompenses de l'activité>\n·Après avoir réussi un défi de niveau pour la première fois, vous pouvez réclamer des récompenses d'essai depuis l'interface de l'événement."
  },
  Activity_80167_ActivityName = {
    Text = "Faucheur d'âme"
  },
  Activity_80167_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Pendant l'événement \"Collecteur d'Âmes\", les Gardiens peuvent utiliser des équipes prédéfinies par le système comprenant le Hilote : Catena pour vivre des niveaux désignés à l'infini.\n·Lors de l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir réussi le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_80311_ActivityName = {
    Text = "Hommage au parcours · Étoile Chapitre II"
  },
  Activity_80311_ActivityPlot = {
    Text = "Un souvenir scellé et archivé, un voyage enregistré dans le passé. Dans les moments de souvenir, n'oubliez pas d'offrir votre Visite révérencieuse."
  },
  Activity_80312_ActivityName = {
    Text = "Chronique de l'asile"
  },
  Activity_80312_ActivityTips = {
    Text = "Règles de l'événement : \n1. Après avoir terminé les tâches désignées, les récompenses peuvent être réclamées dans « Voyage thérapeutique ». \n2. « Voyage thérapeutique » est ouvert en permanence. \n3. Une fois le « Voyage avancé » déverrouillé, des récompenses supplémentaires peuvent être obtenues après la réalisation des missions. \n4. Veuillez noter : le « Voyage avancé » déverrouillé dans le cadre de cet événement n'est valide que pour cet événement. Veuillez gérer vos dépenses avec sagesse, cher gardien du secret."
  },
  Activity_81019_ActivityName = {
    Text = "Nettoyage extraordinaire"
  },
  Activity_81019_ActivityPlot = {
    Text = "Qui parcourt la Kadath onirique, ramassant les déchets pour son maître ?\nC'est Karen～ C'est Karen !\nFusion terminée～ Ventilation du Rêve～ Désinfection dimensionnelle～ Tout est impeccable～\nAprès tout, quand il s'agit de nettoyage, moi, Karen, je suis une professionnelle !\nVoulez–vous essayer, Maître ? Je vous enseignerai tout ce que je sais sur le nettoyage, sans rien garder pour moi !"
  },
  Activity_81019_ActivityTips = {
    Text = "<Title:Aperçu de l'événement>\n1. Pendant l'événement, les Gardiens du secret peuvent participer à la «Progression de Nettoyage» et collecter des «Outils de nettoyage».\n2. Lorsque les «Outils de nettoyage» atteignent un certain nombre, de généreuses récompenses peuvent être réclamées dans «Prime anti–poussière», notamment l'avatar exclusif de l'événement «Maître de nettoyage», des Cœurs d'argent, des Cœurs Immaculés, des Éclats de Pierre Sage, et plus encore.\n\n<Title: Progression de Nettoyage>\n1. La «Progression de Nettoyage» contient plusieurs types de missions de Nettoyage. Les Gardiens du secret peuvent accomplir des missions de Nettoyage pour collecter des «Outils de nettoyage». Une récompense supplémentaire est disponible après avoir accompli tous les types de missions de Nettoyage chaque jour !\n2. Pendant l'événement, un Scénario caché sera joué chaque fois qu'un nouveau type de mission de Nettoyage est accompli pour la première fois.\n3. La «Progression de Nettoyage» sera Rafraîchie et réinitialisée quotidiennement à 9:00 (GMT+8) pendant l'événement.\n\n<Title: Prime anti–poussière>\n1. Les Gardiens du secret peuvent réclamer les récompenses correspondantes en accumulant des «Outils de nettoyage». De généreuses récompenses matérielles peuvent être réclamées pour chaque tranche de 1 000 «Outils de nettoyage» accumulés. Accumuler un total de 10 000 «Outils de nettoyage» octroiera l'avatar exclusif du Voyage Étonnant de Nettoyage «Maître de nettoyage».\n\n<Title:Les remerciements de Karen>\nPendant l'événement, vous pouvez vous connecter aux «Les remerciements de Karen» pour recevoir les cadeaux que Karen a préparés pour les Gardiens du secret !\n\n<Title:Durée de l'événement>\nCet événement n'est disponible que du 28 avril, 9:00 au 12 mai, 9:00 (GMT+8). L'événement prendra fin après le 12 mai, 9:00 (GMT+8). N'oubliez pas de réclamer les récompenses dans «Prime anti–poussière», Gardiens du secret !"
  },
  Activity_81019_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_81178_ActivityName = {
    Text = "Se balancer sous la pluie battante"
  },
  Activity_81178_ActivityPlot = {
    Text = "Une pluie torrentielle se déversait du ciel lugubre, martelant la surface de la mer d'un crépitement incessant.\nDes éclairs impitoyables grondaient à volonté, annonçant l'arrivée d'une horreur sans limites sous les vagues.\nLe magnifique Nautilus tanguait, Fragile comme un bébé titubant au milieu des marées déchaînées.\nPersonne ne savait quel Destin les attendait, tout comme ce n'est que lorsque la mer capricieuse Lâche sa colère que l'on comprend véritablement à quel point l'on est insignifiant."
  },
  Activity_81178_ActivityStageEndContent = {
    Text = "L'événement est Terminé. Actuellement, seuls les «Trésors des matelots» sont disponibles."
  },
  Activity_81178_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\nPendant l'événement, les Gardiens du secret pourront collecter la monnaie événementielle « Pavillon de signalisation » via les modes temporaires « Perdu dans les abysses » et « Récompenses de réalisations ». Le « Pavillon de signalisation » pourra être échangé contre des récompenses dans « Trésors des matelots », notamment la Roue du Destin SR exclusive à l'événement « Guide en Haute Mer », des Cœurs de Lumens, des Cœurs Immaculés, des Éclats de Pierre Sage, des Cristaux de Mimesis et plus encore.\n\n<Title:Perdu dans les abysses>\n1. « Perdu dans les abysses » contient 9 étapes nécessitant un combat direct sans exploration, une étape s'ouvrant chaque jour.\n2. Chaque défi consommera 120 points de liproxénine, et la réussite du défi permettra d'obtenir des matières d'entraînement et la monnaie événementielle.\n3. Une fois l'étape terminée, la fonction « Recréation » de cette étape sera débloquée. Veuillez noter : lors de l'utilisation de la fonction « Recréation », il ne sera pas possible d'obtenir de taux de synchronisation.\n4. Vous pourrez utiliser l'Assistance au combat des Corps éveillés pour faciliter le passage.\n\n<Title:Bonus de pavillon de signalisation>\n1. Lorsque le Gardien possède un certain Éveilleur ou une certaine Roue du Destin (pas nécessairement déployé), il pourra obtenir un bonus supplémentaire sur les « Pavillons de signalisation » obtenus parmi les récompenses des missions des étapes de « Perdu dans les abysses » (y compris la recréation). Les bonus spécifiques sont les suivants :\nÉveilleur « Corposant » : avec Dégagement 0/1/2/3 et plus, bonus de 20%/30%/40%/50%\nRoue du Destin SSR « Navigateur Flamboyant » : avec Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%\nRoue du Destin SR « Guide en Haute Mer » : avec Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%\n2. Les bonus de « pavillon de signalisation » provenant de différents Éveilleurs ou Roues du Destin s'additionneront.\n3. À noter toutefois : les récompenses de premier passage en difficulté Folie ne seront pas affectées par ces bonus.\n\n<Title:Trésors des matelots>\n1. Chaque « Livraison de pavillon » consommera 750 unités de « Pavillon de signalisation » et permettra d'obtenir aléatoirement cinq objets parmi « Trésors des matelots ».\n2. Les récompenses d'objets de « Trésors des matelots » se divisent en deux catégories : « Objet spécial » et « Objet ordinaire ». Lors d'une réinitialisation, la quantité restante d'objets spéciaux pourra être réinitialisée jusqu'à la limite maximale. Les règles détaillées sont les suivantes :\n(1) Premières 5 réinitialisations : lorsque la quantité d'« Objet spécial » est épuisée, le Gardien pourra choisir de réinitialiser, ce qui réinitialisera la quantité restante d'« Objet spécial » et d'« Objet ordinaire » jusqu'à la limite maximale ; ou il pourra choisir de continuer à échanger. Lorsque la quantité d'« Objet ordinaire » est également épuisée, il sera nécessaire de réinitialiser pour pouvoir continuer à échanger.\n(2) À partir de la 6e réinitialisation : la réinitialisation ne sera possible qu'une fois la quantité d'« Objet ordinaire » épuisée. La réinitialisation réinitialisera la quantité restante d'« Objet ordinaire » jusqu'à la limite maximale, mais les « Objet spécial » ne seront plus réinitialisés.\n\n<Title:Période de l'événement>\n1. Du 5 mai 9h00 au 19 mai 9h00 (GMT+8), tous les contenus mentionnés dans la présentation de l'événement seront disponibles.\n2. Du 19 mai 9h00 au 26 mai 9h00 (GMT+8), seuls « Trésors des matelots » et « Récompenses de réalisations » resteront disponibles, les autres contenus seront terminés et indisponibles.\n3. Après le 26 mai 9h00 (GMT+8), les « Pavillons de signalisation » restants non échangés seront récupérés selon un taux de conversion de 1 pavillon = 40 « Billet Rose Dorée » chacun, veuillez vérifier vos e-mails pour les récupérer."
  },
  Activity_81178_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_81179_ActivityName = {
    Text = "Dernière navigation"
  },
  Activity_81771_ActivityName = {
    Text = "L'ombre qui convoite le Royaume divin"
  },
  Activity_81771_ActivityPlot = {
    Text = "Personne n'a vu la sainte lumière du Royaume divin, mais à travers les vérités qui filtrent par hasard, les gens peuvent en percevoir l'ombre. \nIl est là, il a toujours été là, et ce sont d'innombrables croyants qui le feront véritablement descendre. \nPeu importe les lourds péchés qu'il faudra commettre en échange."
  },
  Activity_81771_ActivityStageEndContent = {
    Text = "Événement terminé"
  },
  Activity_81771_ActivityTips = {
    Text = "<Title:Marée Inquiète>\n«Marée Inquiète» comprend 7 niveaux, les 3 premiers niveaux sont ouverts le premier jour de l'événement, puis un niveau s'ouvre tous les 3 jours. Chaque niveau offre des récompenses différentes et généreuses !\nChaque type de «Marée Inquiète» dispose de nombreux groupes. Chaque fois qu'un groupe d'un certain type est vaincu par n'importe quel Gardien, le nombre de groupes de ce type diminue de 1. Lorsque tous les groupes de ce type sont éliminés, le niveau correspondant se fermera définitivement.\nChaque Gardien peut repousser au maximum 20 fois des groupes de «Marée Inquiète» par jour, cette limite est réinitialisée quotidiennement à 9h00 (GMT+8) pendant la durée de l'événement.\nChaque niveau propose des Reliques différentes qui vous offriront de puissants bonus.\nPour chaque niveau, il est obligatoire de choisir un allié. Pendant tout l'événement, chaque Gardien qui vous suit mutuellement ne pourra vous aider qu'une seule fois.\nLes Gardiens du secret doivent avoir terminé au minimum l'opération de Mission d'enquête 2-9 pour pouvoir participer à cet événement.\n\n<Title:Compensation de niveau>\nDans «Jeter un coup d'œil aux ombres du Royaume Divin : Marée Inquiète», un système de compensation de niveau est mis en place afin que tous les Gardiens du secret puissent ensemble résister à l'invasion !\nLes règles de compensation sont les suivantes :\nDans l'équipe d'enquête, les Éveilleurs dont le niveau est inférieur à 60 seront compensés jusqu'au niveau 60 lors de ce défi.\nDans l'équipe d'enquête, les Éveilleurs dont le niveau de compétence est inférieur à 5 seront compensés jusqu'au niveau 5 lors de ce défi.\nDans l'équipe d'enquête, les Éveilleurs dont le niveau de «Présage de Folie» est inférieur à 6 seront compensés jusqu'au niveau 6 lors de ce défi.\nDans l'équipe d'enquête, les Éveilleurs dont le niveau d'«Aptitude Forge de l'Âme» est inférieur à 5 seront compensés jusqu'au niveau 5 lors de ce défi.\nSi le niveau du Gardien est inférieur à 60, il sera compensé jusqu'au niveau 60 lors de ce défi.\n\n<Title:Missions limitées dans le temps>\nPendant l'événement, accomplissez un total de 30 repoussements de la Marée Inquiète pour terminer la mission limitée dans le temps et obtenir 1 «Voucher de Tenue Fantastique Simple (partie 1)» !\nDu 26 mai à 9h00 au 9 juin à 9h00 (GMT+8), vous pourrez échanger le «Voucher de Tenue Fantastique Simple (partie 1)» contre des tenues fantastiques simples dans «Boutique : Commande de Tenues».\nVous pourrez découvrir d'autres façons d'obtenir le «Voucher de Tenue Fantastique Simple (partie 1)» sur les forums et dans les annonces officielles."
  },
  Activity_81771_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_83305_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_83306_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_83307_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_83308_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_83309_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_83310_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_83311_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_83312_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_83313_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_83314_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_83315_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_83316_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_83317_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_83318_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_83319_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_83320_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_83321_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_83322_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_83323_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_83324_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_83325_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_83326_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_83327_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_83328_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_83329_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_83330_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_83331_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_83332_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_83333_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_83334_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_83335_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_83336_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_83337_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_83338_ActivityName = {
    Text = "Abîme dissous"
  },
  Activity_84175_ActivityName = {
    Text = "Voyage de rétablissement"
  },
  Activity_84175_ActivityTips = {
    Text = "Règles de l'événement :\n1. Après avoir accompli les missions désignées du « Voyage en résonance », le gardien du secret peut réclamer des récompenses.\n2. Les missions sont divisées en plusieurs groupes, un groupe sera débloqué chaque jour à l'ouverture de l'événement.\n3. Après avoir débloqué « Voyage en résonance », des récompenses supplémentaires pourront être réclamées après l'accomplissement des missions.\n4. Veuillez noter : le « Voyage en résonance » débloqué dans le cadre de cet événement n'est valide que pour cet événement. Veuillez gérer vos dépenses de manière raisonnable, gardien du secret."
  },
  Activity_84176_ActivityName = {
    Text = "Chroniques du Lien temporel"
  },
  Activity_84176_ActivityTips = {
    Text = "Règles de l'événement :\n1. Après avoir accompli les missions désignées de « Voyage temporel », le gardien du secret pourra recevoir des récompenses dans « Voyage temporel ».\n2. Les missions sont divisées en plusieurs groupes, un groupe sera débloqué chaque jour à l'ouverture de l'événement.\n3. Après avoir débloqué « Voyage temporel », des récompenses supplémentaires pourront être réclamées en accomplissant les missions.\n4. Veuillez noter : le « Voyage temporel » débloqué dans le cadre de cet événement ne sera valide que pour cet événement. Veuillez gérer vos dépenses avec sagesse, gardien du secret."
  },
  Activity_89008_ActivityName = {
    Text = "<Yellow:Suivi dimensionnel entrelacé>"
  },
  Activity_89008_ActivityPlot = {
    Text = "Elle a traversé d'innombrables Dimensions, d'innombrables mondes, et vécu d'innombrables espoirs et désespoirs, mais elle ne s'arrêtera jamais. Car elle sait exactement où se trouve sa destination — là où vous êtes."
  },
  Activity_89008_ActivityTips = {
    Text = "<Title:Présentation>\n1. Pendant l'événement, les Gardiens du secret peuvent réclamer leurs récompenses quotidiennes dans «Suivi à travers les dimensions» après chaque connexion.\n2. Les récompenses seront débloquées séquentiellement en fonction des connexions cumulées des Gardiens du secret et seront réinitialisées à 9h00 (GMT+8) chaque jour.\n\n<Title:Missions limitées>\nPendant l'événement, une connexion cumulée de 7 jours permet d'accomplir la mission limitée et d'obtenir 1 «Voucher de Tenue Fantastique Simple (partie 1)» !\nDu 26 mai à 9h00 au 9 juin à 9h00 (GMT+8), le «Voucher de Tenue Fantastique Simple (partie 1)» peut être utilisé dans le «Magasin : Commande d'habits magiques» pour échanger contre des habits magiques simplifiés.\nD'autres façons d'obtenir le «Voucher de Tenue Fantastique Simple (partie 1)» sont disponibles dans la communauté et les annonces officielles."
  },
  Activity_89008_BannerText = {
    Text = "Connexion quotidienne pour obtenir de nombreux Cœurs immaculés"
  },
  Activity_89576_ActivityName = {
    Text = "Que l'espoir germe à nouveau"
  },
  Activity_89576_ActivityPlot = {
    Text = "Connectez-vous quotidiennement pour recevoir la roue du destin SSR limitée et commémorative « Renaissance dans la poussière », un total de 16 !"
  },
  Activity_89576_ActivityTips = {
    Text = "<Title:Introduction>\nLe monde se désintègre. Dans un tel monde, le désespoir est la norme, la souffrance est la norme. Je dois m'y habituer. Pourtant... il y a encore de la chaleur tapie au fond de mon cœur, attendant de jaillir hors de ma poitrine.\n\n<Title:Règles de l'événement>\n· Pendant l'événement, le Gardien du Secret peut recevoir quotidiennement dans « Que l'espérance germe à nouveau » la roue du destin SSR « Renaissance dans la poussière », édition commémorative limitée, un total de 16 fois.\n· Les récompenses seront débloquées en fonction du nombre cumulé de connexions du Gardien du Secret. Les récompenses du jour seront réinitialisées à 9h (GMT+8)."
  },
  Activity_89576_BannerText = {
    Text = "RdD SSR limitée gratuite"
  },
  Activity_89729_ActivityName = {
    Text = "Événement de déblocage gratuit"
  },
  Activity_89730_ActivityName = {
    Text = "Prisonnier du Mirage"
  },
  Activity_89730_ActivityPlot = {
    Text = "Oiseau, oiseau, pourquoi as-tu des chaînes brisées aux pieds ? \nOiseau, oiseau, pourquoi cries-tu seul dans le ciel ? \nLibère-toi des ronces, échappe à la cage, tu as volé au-delà des étendues désertiques, mais ton cri triste ne s'est jamais arrêté. \nQui est donc celui que tu cherches comme compagnon fidèle ? \nOù est donc l'endroit que tu cherches comme véritable patrie ?\n\n?"
  },
  Activity_89730_ActivityStageEndContent = {
    Text = "Événement terminé, participation actuelle uniquement à « Avidité de savoir »"
  },
  Activity_89730_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, le gardien peut collecter la monnaie d'événement « Livre de bon sens », « Livre de mathématiques » et « Livre de littérature » via les modes limités « Au-delà de l'horizon », « Navette onirique » et les récompenses de succès. « Livre de bon sens », « Livre de mathématiques », « Livre de littérature » peuvent être utilisés dans « Désir de connaissance » pour acheter des objets, notamment la roue de destin SR exclusive à l'événement « Plume Solitaire », le Cœur de Lumens, le Cœur Immaculé, etc.\n2. Pendant l'événement, « Monde des Rêves Étranges : Au-delà de l'horizon - Partie 1 » sera déverrouillée gratuitement, et en accomplissant les succès de l'événement, vous pourrez obtenir l'avatar exclusif à l'événement « Au nom de la Clé d'argent : Castor » !\n\n<Title:Période de l'événement>\n1. Du 2 juin à 9h00 au 16 juin à 9h00 (GMT+8), toutes les activités de l'événement seront disponibles.\n2. Du 16 juin à 9h00 au 23 juin à 9h00 (GMT+8), seules les activités « Désir de connaissance » et les récompenses de succès seront disponibles.\n\n<Title:Au-delà de l'horizon>\n1. « Au-delà de l'horizon » contient 7 niveaux, un niveau s'ouvre automatiquement tous les jours.\n2. Chaque défi consomme 120 points de lipochrome, et en cas de succès, vous obtenez la monnaie de l'événement.\n3. Une fois le niveau terminé, la fonction « Récurrence » de ce niveau est débloquée. Veuillez noter : Lors de l'utilisation de la fonction « Récurrence », vous ne pouvez pas obtenir de taux de synchronisation.\n4. Vous pouvez utiliser l'aide des Alumni pour faciliter le passage du niveau.\n\n<Title:Désir de connaissance>\n« Désir de connaissance » dispose de trois magasins, dont les dates d'ouverture sont les suivantes :\n· « Cours électifs généraux » : Ouverture le 2 juin à 9h00.\n· « Classe optative de sciences » : Ouverture le 4 juin à 9h00.\n· « Classe optionnelle de littérature » : Ouverture le 6 juin à 9h00.\nDans les magasins, vous pouvez choisir les articles et les acheter directement.\n\n<Title:Bonus de l'événement>\n1. Si le gardien possède un certain Corps éveillé ou une roue de destin (pas nécessairement en équipe), il obtiendra un bonus supplémentaire sur les « Livre de bon sens », « Livre de mathématiques », « Livre de littérature » dans les récompenses des missions des niveaux « Au-delà de l'horizon ». Les bonus spécifiques sont les suivants :\n· Corps éveillé « Castor » : Dégagement 0/1/2/3 ou supérieur, bonus de 20%/30%/40%/50%.\n· Roue de destin SSR « Liberté Insupportable » : Superposition 0/1/2/3 ou supérieur, bonus de 20%/30%/40%/50%.\n· Roue de destin SR « Plume Solitaire » : Superposition 0/1/2/3 ou supérieur, bonus de 20%/30%/40%/50%.\n2. Les bonus d'événement de différents Corps éveillés ou roues de destin s'additionnent.\n3. À noter : Les récompenses de la première réussite en difficulté folle ne sont pas affectées par les bonus de l'événement.\n\n<Title:Navette onirique>\n1. Vous obtenez automatiquement 60 « Livres de bon sens » par heure, avec un maximum de stockage de 25 heures.\n\n<Title:Monde des Rêves Étranges>\n1. Pendant l'événement, « Monde des Rêves Étranges : Au-delà de l'horizon - Partie 1 » peut être déverrouillée gratuitement.\n2. À la fin de l'événement, les progrès de « Monde des Rêves Étranges : Au-delà de l'horizon - Partie 1 » seront conservés. Après l'événement, vous pourrez toujours obtenir les mêmes récompenses que pendant l'événement en terminant les enquêtes non terminées pendant l'événement. Si vous n'avez pas déverrouillé « Monde des Rêves Étranges : Au-delà de l'horizon - Partie 1 » pendant l'événement, vous pourrez toujours le déverrouiller après l'événement en consommant 7 « Point de départ réel ».\n3. Quel que soit le moment où vous le déverrouillez, vous obtenez toujours « Sceau de clé : Déplacement du Destin » après avoir terminé « Monde des Rêves Étranges : Au-delà de l'horizon - Partie 1 »."
  },
  Activity_89730_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_89899_ActivityName = {
    Text = "Confection d'un vêtement fantomatique"
  },
  Activity_89899_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, le gardien peut utiliser le « monocle d'illusion » pour effectuer des tirages. La quantité requise de « monocles d'illusion » augmentera à chaque tirage.\n2. Le vêtement fantomatique de l'Argent pourra être obtenu à partir du 5e tirage. Après 10 tirages, le vêtement fantomatique de l'Argent en cours sera garanti.\n3. À la fin de l'événement, les « monocles d'illusion » restants seront automatiquement convertis en liquide source."
  },
  Activity_89899_BannerText = {
    Text = "Activité de tirage limitée dans le temps !"
  },
  Activity_90052_ActivityName = {
    Text = "Cerveau corrompu"
  },
  Activity_90052_ActivityTips = {
    Text = "<Title:Règles de l'événement>\n· Pendant l'événement « Cerveau Corrompu », le gardien peut utiliser l'équipe prédéfinie incluant « Dôme de Fusion · Dorei » pour expérimenter indéfiniment les niveaux désignés.\n· Lors de l'expérience des niveaux d'événement, il est impossible d'ajuster les Réveillés dans l'équipe.\n<Title:Récompenses de l'événement>\n· Après avoir accompli le défi du niveau pour la première fois, il est possible de recevoir la récompense d'essai depuis l'interface de l'événement."
  },
  Activity_90493_ActivityName = {
    Text = "Entraîn. au combat"
  },
  Activity_90493_ActivityTips = {
    Text = "Règles de l'événement :\n1. Les Gardiens du secret peuvent apprendre et pratiquer le contenu de combat pertinent dans les Niveaux correspondants.\n2. Lorsque les Gardiens du secret Terminer les Niveaux d'entraînement pratique correspondants, les récompenses peuvent être récupérées dans «Entraînement pratique.»"
  },
  Activity_90861_ActivityName = {
    Text = "Destin conjugué"
  },
  Activity_90861_ActivityTips = {
    Text = "<Title:Destin conjugué>\nCes Chroniques limitées contiennent 8 packs cadeaux. Le premier pack cadeau peut être réclamé gratuitement, tandis que les packs cadeaux 2 à 8 nécessitent l'achat de «Destin conjugué» avant de pouvoir être réclamés.\n\nAprès l'achat de «Destin conjugué», les récompenses du 2e pack cadeau peuvent être réclamées immédiatement ; les packs cadeaux suivants nécessitent d'attendre un certain temps avant de pouvoir être réclamés.\n\nAcheter «Destin conjugué» avant 9:00 le 20 avril accordera également des récompenses supplémentaires : l'avatar exclusif «Tisseur de destin» et «Invitation de l'Incorporel» ×10 ! Les achats effectués après 9:00 le 20 avril n'accorderont plus les récompenses exclusives à durée limitée.\n\nAprès l'achat, la durée de ces Chroniques limitées deviendra permanente, et l'événement se terminera le jour suivant la réclamation de tous les packs cadeaux.\n\n«Destin conjugué» sera disponible à l'achat jusqu'à 9:00 le 18 mai."
  },
  Activity_90861_BannerText = {
    Text = "Événement spécial Chronologie à durée limitée !"
  },
  Activity_90862_ActivityName = {
    Text = "Texte temporaire"
  },
  Activity_90862_ActivityTips = {
    Text = "<Title: Texte temporaire>\n·Cet événement de Pré-commande limitée comprend 8 packs cadeaux. Le premier pack peut être réclamé gratuitement, tandis que les packs 2 à 8 nécessitent l'achat de «Texte temporaire» avant de pouvoir être réclamés.\n·Après l'achat de «Texte temporaire», la récompense du 2e pack cadeau peut être réclamée immédiatement ; les packs suivants nécessitent d'attendre un certain temps avant de pouvoir être réclamés.\n·«Texte temporaire» est disponible à l'achat pour une durée limitée. Il ne sera plus disponible à l'achat après la date limite. Veuillez effectuer votre achat à votre convenance avant le 7 avril à 9:00."
  },
  Activity_90862_BannerText = {
    Text = "Événement spécial Chronologie à durée limitée !"
  },
  Activity_90863_ActivityName = {
    Text = "Art des Vœux Infinis"
  },
  Activity_90863_ActivityTips = {
    Text = "<Title:Art des Vœux Infinis>\nCet événement Archives comprend 8 packs cadeaux ; le premier pack cadeau peut être réclamé gratuitement.\nAprès avoir acheté « Art des Vœux Infinis », vous pouvez immédiatement réclamer le 2e pack cadeau et débloquer les packs 3 à 8 après des périodes d'attente spécifiques.\nAchetez avant le 24 août à 9h00 pour recevoir en plus l'avatar exclusif « Ruse en Mouvement » et « Invitation de l'Incorporel » ×10 !\nLes achats effectués après cette date n'incluront pas ces récompenses exclusives à durée limitée. « Art des Vœux Infinis » est disponible pour une durée limitée ; veuillez finaliser votre achat avant le 21 septembre à 9h00. Après l'achat, la date de fin de l'événement Archives sera prolongée jusqu'au 28 septembre à 9h00, offrant à tous les Gardiens du secret suffisamment de temps pour réclamer leurs récompenses !"
  },
  Activity_90863_BannerText = {
    Text = "Événement spécial Chronologie à durée limitée !"
  },
  Activity_90864_ActivityName = {
    Text = "Élégie du crâne · Chroniques limitées"
  },
  Activity_90864_ActivityTips = {
    Text = "<Title:Antiphon du Crâne : Chroniques limitées>\nCes Chroniques limitées comprennent 8 packs. Le premier pack peut être récupéré gratuitement, tandis que les packs 2 à 8 ne peuvent être récupérés qu'après avoir acheté « Antiphon du Crâne : Chroniques limitées ».\nAprès l'achat de « Antiphon du Crâne : Chroniques limitées », vous pourrez immédiatement récupérer la récompense du deuxième pack ; les packs suivants devront être récupérés après un délai d'attente respectif.\nSi vous achetez avant le 21 juillet à 9h00 (GMT+8), vous recevrez en plus les récompenses suivantes : un avatar exclusif « Le regard affamé de la nuit éternelle » et 10 « Invitation de l'Incorporel » ! Après le 21 juillet à 9h00, les récompenses exclusives limitées ne seront plus disponibles.\nDisponible jusqu'au : 18 août à 9h00 (GMT+8)."
  },
  Activity_90865_ActivityName = {
    Text = "Texte temporaire"
  },
  Activity_90865_ActivityTips = {
    Text = "<Title:Mouvement fœtal des abysses : Chroniques limitées>\nCes Chroniques limitées comprennent 8 packs, dont le premier peut être récupéré gratuitement.\nLes packs 2 à 8 nécessitent l'achat de « Mouvement fœtal des abysses : Chroniques limitées » pour être obtenus.\nAprès l'achat, vous pourrez immédiatement récupérer la récompense du deuxième pack ; les packs suivants devront être récupérés après un délai d'attente respectif.\nPour un bonus exclusif, achetez avant le 17 novembre à 9h00 pour recevoir l'avatar « Chant d'adieu des profondeurs » et 10 « Invitation de l'Incorporel ». Cette offre est limitée et ne sera plus disponible après la date limite.\nVeuillez noter : l'achat de « Mouvement fœtal des abysses : Chroniques limitées » est limité dans le temps, et il ne sera plus possible de l'acheter après le 15 décembre à 9h00."
  },
  Activity_91026_ActivityName = {
    Text = "Événement de déblocage gratuit"
  },
  Activity_91027_ActivityName = {
    Text = "Grand conquête"
  },
  Activity_91027_ActivityPlot = {
    Text = "Un grand âge finira peut-être par disparaître, mais la volonté des grands guerriers ne s'éteindra jamais. \n Les tombes ne peuvent les enterrer, les chaînes ne peuvent les dompter. \n Quand de nouveaux chemins se dessinent, des rôtis appétissants attendent au terme de la voie de la conquête, les guerriers lancent une charge et s'emparent du butin glorieux. \n Célébrons par des chants cette bravoure immortelle, cet empire sacré ! \n Rome ! Rome !"
  },
  Activity_91027_ActivityStageEndContent = {
    Text = "Événement terminé, participation actuelle uniquement à « Offrir un tribut »"
  },
  Activity_91027_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, le Gardien peut collecter la monnaie événementielle « Délicieux barbecue de Léon » en jouant au mode temporaire « Chasse Divine ». Cette monnaie permet d'acheter des articles dans le magasin « Offrir un tribut », notamment des Cœur de Lumens et des Cœur Immaculé.\n2. Pendant l'événement, « Monde des Rêves Étranges : Chroniques de Cuisine » est débloqué gratuitement pendant une durée limitée.\n\n<Title:Période de l'événement>\n1. Du 30 juin à 9h00 au 21 juillet à 9h00 (GMT+8), toutes les activités événementielles sont disponibles.\n2. Du 21 juillet à 9h00 au 28 juillet à 9h00 (GMT+8), seules les activités « Offrir un tribut » et les récompenses de réalisations sont disponibles.\n\n<Title:Chasse Divine>\n1. « Chasse Divine » contient 5 niveaux, un nouveau niveau s'ouvre automatiquement tous les 2 jours.\n2. Chaque défi consomme 120 points d'endoréna. En réussissant le défi, vous obtenez la monnaie événementielle.\n3. Une fois un niveau terminé, la fonction « Revivre » de ce niveau est débloquée. Veuillez noter : aucune synergie ne sera obtenue en utilisant la fonction « Revivre ».\n4. Vous pouvez utiliser l'aide des Alumni pour faciliter le passage du niveau.\n\n<Title:Offrir un tribut> Dans le magasin « Offrir un tribut », vous pouvez acheter directement des articles en utilisant la monnaie événementielle « Délicieux barbecue de Léon ».\n\n<Title:Monde des Rêves Étranges>\n1. Pendant l'événement, « Monde des Rêves Étranges : Chroniques de Cuisine » est débloqué gratuitement.\n2. Après la fin de l'événement, vos progrès dans « Monde des Rêves Étranges : Chroniques de Cuisine » seront conservés. Même après l'événement, vous pouvez terminer les enquêtes non terminées et obtenir les mêmes récompenses que pendant l'événement. Si vous ne l'avez pas débloqué pendant l'événement, vous pourrez toujours le débloquer après en utilisant 7 « Point de départ réel ».\n3. Quel que soit le moment où vous le terminez, en terminant « Monde des Rêves Étranges : Chroniques de Cuisine », vous obtiendrez « Sceau : Résolution vorace »."
  },
  Activity_91027_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_91112_ActivityName = {Text = "Matsuka"},
  Activity_91112_ActivityTips = {
    Text = "<Title:Règles de l'événement>\n· Pendant l'événement « Aube scellée », les Gardiens peuvent utiliser des compositions prédéfinies par le système incluant Mouchette pour expérimenter les étapes désignées un nombre illimité de fois.\n· Lors de l'expérience des étapes de l'événement, aucune modification des Éveilleurs dans la composition ne peut être effectuée.\n<Title:Récompenses de l'événement>\n· Après avoir complété le défi de l'étape pour la première fois, vous pouvez réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_91355_ActivityName = {
    Text = "Hommage au parcours · Chapitre des Étoiles III"
  },
  Activity_91355_ActivityPlot = {
    Text = "Un souvenir scellé et archivé, un voyage enregistré dans le passé. Dans les moments de souvenir, n'oubliez pas d'offrir votre Visite révérencieuse."
  },
  Activity_91356_ActivityName = {
    Text = "Voyage dans la Cité des Morts"
  },
  Activity_91356_ActivityTips = {
    Text = "Règles de l'événement:\n1. Les Gardiens peuvent recevoir des récompenses dans \"Voyage de la ville gaspillée\" après avoir complété des tâches de voyage désignées.\n2. \"Voyage de la ville gaspillée\" est ouvert en permanence.\n3. Après avoir débloqué \"Voyage avancé\", des récompenses supplémentaires peuvent être reçues en complétant des tâches.\n4. Veuillez noter : Le \"Voyage avancé\" débloqué lors de cet événement n'est efficace que pendant cet événement. Les Gardiens doivent consommer raisonnablement et judicieusement."
  },
  Activity_91719_ActivityName = {
    Text = "Boutique d'échange de mode - Phase 2"
  },
  Activity_91719_ActivityPlot = {
    Text = "Billet d'échange de mode - Phase 2"
  },
  Activity_91719_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, le gardien pourra obtenir des bons de façonnage simplifiés de vêtements fantomatiques via d'autres événements"
  },
  Activity_91728_ActivityName = {
    Text = "Apôtre de la mer"
  },
  Activity_91728_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n· Pendant l'événement \"Apostle de la Mer\", les Gardiens peuvent utiliser des équipes préétablies par le système qui incluent Miryam pour vivre les niveaux désignés indéfiniment.\n· Lors de l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n· Après avoir réussi à compléter le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_94858_ActivityName = {
    Text = "Événement de déblocage gratuit"
  },
  Activity_94859_ActivityName = {
    Text = "Chronique estivale"
  },
  Activity_94859_ActivityTips = {
    Text = "Règles de l'événement :\n1. Après avoir terminé les missions désignées, le gardien du secret peut réclamer des récompenses dans «Voyage estival».\n2. Après avoir déverrouillé «Voyage avancé», des récompenses supplémentaires peuvent être obtenues après avoir complété les missions.\n3. L'achat de ce «Voyage avancé» est limité dans le temps, et ne pourra plus être effectué après la date limite. Le gardien du secret doit acheter à sa convenance avant le 6 octobre à 9h00.\n4. Veuillez noter : le «Voyage avancé» débloqué dans cet événement n'est valide que pendant la durée de cet événement. Le gardien du secret doit faire preuve de discernement dans ses dépenses."
  },
  Activity_94859_BannerText = {
    Text = "Événement spécial Chronologie à durée limitée !"
  },
  Activity_94860_ActivityName = {
    Text = "Été sous le soleil noir"
  },
  Activity_94860_ActivityPlot = {
    Text = "Été, bord de mer, soleil éblouissant et nombreux visages familiers. \n Sous les rayons brûlants du soleil, oubliez tout et laissez-vous entraîner dans ce rêve fou qui réalise toutes vos fantaisies."
  },
  Activity_94860_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, le déverrouillage gratuit limité dans le temps de « Monde des Rêves Étranges : Au revoir, Pays Imaginaire » !\n2. Pendant l'événement, en vous connectant pendant 7 jours au total, vous pouvez obtenir « Cœur de Lumens » *10 dans « Fête estivale », et le 7ème jour, vous pouvez également obtenir le portrait de combat limité « Volley-ball ‹Commandant› ».\n\n<Title:Durée de l'événement>\n1. Du 1er septembre à 9h00 au 6 octobre à 9h00 (GMT+8), tous les événements sont accessibles.\n\n<Title:Monde des Rêves Étranges>\n1. Pendant l'événement, « Monde des Rêves Étranges : Au revoir, Pays Imaginaire » peut être déverrouillé gratuitement.\n2. Après la fin de l'événement, la progression de l'enquête de « Monde des Rêves Étranges : Au revoir, Pays Imaginaire » sera conservée, et en complétant les événements d'enquête non terminés pendant l'événement, vous pourrez également obtenir des récompenses d'enquête identiques à celles de la période de l'événement. Si « Monde des Rêves Étranges : Au revoir, Pays Imaginaire » n'est pas déverrouillé pendant l'événement, vous pouvez toujours le déverrouiller après la fin de l'événement en dépensant « Point de départ réel » *7.\n3. Que ce soit pendant l'événement ou non, après avoir terminé « Monde des Rêves Étranges : Au revoir, Pays Imaginaire », vous pourrez obtenir « Sésame : Souvenir d'un été figé »."
  },
  Activity_94860_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_95190_ActivityName = {
    Text = "Événement de déblocage gratuit"
  },
  Activity_95191_ActivityName = {
    Text = "La myriade de lumières éblouissantes de la chute"
  },
  Activity_95191_ActivityPlot = {
    Text = "Ils chantent la chanson de l'éternel souvenir, accueillant le Seigneur immortel. \n Il descendra des cieux avec d'innombrables lumières, proclamant l'éclat impérissable. \n Au moment de Sa venue, la lumière ambrée recouvrira le monde. \n C'est le chant funèbre qu'Il offre au monde."
  },
  Activity_95191_ActivityStageEndContent = {
    Text = "L'événement est Terminé. Actuellement, seule «Base Secrète» est disponible."
  },
  Activity_95191_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, le Gardien pourra collecter la monnaie événementielle « Sceau de la Richesse », « Sceau de la Mort », « Sceau de Guerre » via les modes événementiels limités « Chasse des Cendres », « La Fête sans Conflits » et les « Récompenses de succès ». Vous pourrez utiliser ces monnaies pour acheter des articles dans « Base Secrète », notamment la Roue du Destin SR exclusive « Soleil Imminent », des Cœur de Lumens, des Cœur Immaculé, etc.\n2. Pendant l'événement, « Jour Éternel » sera déverrouillé gratuitement pendant une durée limitée. En accomplissant les succès événementiels, vous pourrez également obtenir l'icône exclusive « Au nom de la Clé d'argent : Kadigula » !\n\n<Title:Période de l'événement>\n1. Du 18 août 9h00 au 1er septembre 9h00 (GMT+8), tous les modes événementiels seront disponibles.\n2. Du 1er septembre 9h00 au 8 septembre 9h00 (GMT+8), seuls « Base Secrète » et les récompenses de succès seront disponibles.\n\n<Title:Chasse des Cendres>\n1. « Chasse des Cendres » contient 7 étages, un nouvel étage s'ouvrira automatiquement chaque jour.\n2. Chaque défi consommera 120 points de lipiase, et permettra d'obtenir de la monnaie événementielle en cas de succès.\n3. Une fois un étage terminé, la fonction « Récurrence » de cet étage sera débloquée. Veuillez noter : vous ne pourrez pas obtenir de taux de synchronisation en utilisant la fonction « Récurrence ».\n4. Vous pouvez utiliser l'aide des Alumni pour faciliter le passage.\n\n<Title>Base Secrète>\n« Base Secrète » dispose de trois magasins, les dates d'ouverture sont les suivantes :\nCoffre de Collection : ouverture le 18 août à 9h00.\nChambre des commissions : ouverture le 20 août à 9h00.\nCampement de combat : ouverture le 22 août à 9h00.\nVous pourrez acheter directement les articles désirés dans les magasins.\n\n<Title:Bonus événementiel>\n1. Si le Gardien possède un certain Corps éveillé ou une certaine Roue du Destin (pas besoin de les équiper), il obtiendra un bonus supplémentaire sur les récompenses « Sceau de la Richesse », « Sceau de la Mort », « Sceau de Guerre » des missions des étages de « Chasse des Cendres ». Les bonus sont les suivants :\nCorps éveillé « Kadigula » : Dégagement 0/1/2/3 et plus, bonus de 20%/30%/40%/50%.\nRoue du Destin SSR « Mort ambre » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%.\nRoue du Destin SR « Soleil Imminent » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%.\n2. Les bonus événementiels de différents Corps éveillés ou Roues du Destin s'additionnent.\n3. À noter toutefois, les récompenses de premier passage en difficulté Fou ne sont pas affectées par les bonus événementiels.\n\n<Title:La Fête sans Conflits>\n1. Vous obtenez automatiquement 60 « Sceau de la Richesse » par heure, avec un maximum de 25 heures stockables.\n\n<Title:Plongée dans l'inconscient>\n1. Pendant l'événement, « Jour Éternel » sera déverrouillé gratuitement.\n2. À la fin de l'événement, les progrès dans l'exploration de « Jour Éternel » seront conservés. Même après l'événement, vous pourrez obtenir les mêmes récompenses d'exploration qu'en période événementielle en complétant les événements d'exploration non terminés pendant l'événement. Si vous n'avez pas déverrouillé « Jour Éternel » pendant l'événement, vous pourrez toujours le déverrouiller après l'événement en dépensant 3 Point de départ réel.\n3. Quel que soit le moment de passage, vous obtiendrez « Sceau : Soleil Éternel » après avoir terminé « Plongée dans l'inconscient : Jour Éternel »."
  },
  Activity_95191_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_95492_ActivityName = {
    Text = "Récompense royale"
  },
  Activity_95492_ActivityPlot = {
    Text = "Il est un souverain généreux, bienveillant et miséricordieux, régnant sur un royaume de mort. Bienvenue à toi, étranger non-mort, ton parfum riche et agréable a déjà gagné sa faveur, reçois donc cette récompense. Les portes de ce château te seront toujours ouvertes."
  },
  Activity_95492_ActivityTips = {
    Text = "<Title:Présentation>\n1. Pendant la durée de l'événement, les récompenses quotidiennes peuvent être réclamées dans «Récompense Royale» après chaque connexion quotidienne du gardien du secret.\n2. Les récompenses seront débloquées en fonction des connexions cumulées du gardien du secret, et les récompenses quotidiennes seront réinitialisées à 9h (GMT+8).\n"
  },
  Activity_95492_BannerText = {
    Text = "Connexion quotidienne pour obtenir de nombreux Cœurs immaculés"
  },
  Activity_95977_ActivityName = {
    Text = "Esthétique des morts-vivants"
  },
  Activity_95977_ActivityPlot = {
    Text = "La mort, bien loin d'être la fin de la vie. \n Ne craignez pas la mort, cher invité. \n Lors du festin sacré, vous assisterez aux côtés de votre doux hôte à la beauté des âmes défuntes."
  },
  Activity_95977_ActivityStageEndContent = {
    Text = "Événement terminé, participation actuelle uniquement à « Salle à manger du palais royal »"
  },
  Activity_95977_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\nPendant la durée de l'événement, le Gardien pourra collecter la monnaie événementielle via les modes de jeu limités « Fête des Âmes » et « Récompenses de réussite ». Cette monnaie événementielle pourra être utilisée dans le « Restaurant du Palais Royal » afin d'obtenir des récompenses d'objets, incluant notamment la Roue du Destin SR exclusive à l'événement « Délices Macabres », la Pierre philosophale, le Cœur Immaculé, le Cœur de Lumens, etc.\n\n<Title:Période de l'événement>\n1. Du 21 juillet à 9h00 au 4 août à 9h00 (GMT+8), toutes les activités seront disponibles.\n2. Du 4 août à 9h00 au 11 août à 9h00 (GMT+8), seuls le « Restaurant du Palais Royal » et les « Récompenses de réussite » resteront actifs, les autres contenus seront indisponibles.\n\n<Title:Fête des Âmes>\n1. « Fête des Âmes » contient 5 niveaux, un niveau s'ouvrira automatiquement tous les 2 jours.\n2. Chaque défi consommera 120 points de neuropépétine, et la réussite du défi permettra d'obtenir de la monnaie événementielle.\n3. Une fois un niveau terminé, la fonction « Récurrence » de ce niveau sera débloquée. Veuillez noter : la fonction « Récurrence » ne permet pas d'obtenir de taux de synchronisation.\n4. Vous pourrez utiliser l'aide des Alumni pour faciliter la réussite des niveaux.\n\n<Title:Bonus événementiel>\n1. Si le Gardien possède un certain Corps éveillé ou Roue du Destin (non nécessairement déployé), il obtiendra un bonus supplémentaire sur les « Ossements pourris de la main » reçus dans les récompenses des missions des niveaux de « Fête des Âmes » (incluant la récurrence). Les détails sont les suivants :\nCorps éveillé « Doresain » : Dégagement 0/1/2/3 et plus, bonus de 20%/30%/40%/50%\nRoue du Destin SSR « Dernier Baiser » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%\nRoue du Destin SR « Délices Macabres » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%\n2. Les bonus événementiels de différents Corps éveillés ou Roues du Destin s'additionnent.\n3. À noter toutefois : la récompense de la première réussite en difficulté Fou n'est pas affectée par les bonus événementiels.\n\n<Title:Restaurant du Palais Royal>\n1. Chaque « Demande de plats » consommera 750 « Ossements pourris de la main » et offrira aléatoirement l'une des cinq récompenses disponibles dans le « Restaurant du Palais Royal ».\n2. Les récompenses du « Restaurant du Palais Royal » se divisent en deux catégories : « Objet spécial » et « Objet ordinaire ». Lors de la réinitialisation, la quantité restante d'objets spéciaux sera réinitialisée à la limite supérieure. Les règles détaillées sont les suivantes :\n(1) Premières 5 réinitialisations : lorsque les « Objet spécial » sont épuisés, le Gardien peut choisir de réinitialiser. Après réinitialisation, la quantité restante des « Objet spécial » et « Objet ordinaire » sera réinitialisée à la limite supérieure ; il peut aussi choisir de continuer à échanger. Lorsque les « Objet ordinaire » sont également épuisés, une réinitialisation sera nécessaire pour continuer les échanges.\n(2) À partir de la 6e réinitialisation : la réinitialisation ne sera possible qu'après épuisement des « Objet ordinaire ». La réinitialisation rétablira la quantité restante des « Objet ordinaire » à la limite supérieure, mais les « Objet spécial » ne seront plus réinitialisés.\n3. Après le 11 août à 9h00 (GMT+8), les « Ossements pourris de la main » non échangés seront convertis au taux fixe de « Billet Rose Dorée*40 », veuillez vérifier vos messages."
  },
  Activity_95977_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_95978_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel I"
  },
  Activity_95978_ActivityPlot = {
    Text = "Après l'achat, « Durelein » peut être activé <BlueQuality:Illumination 3>"
  },
  Activity_95979_ActivityName = {
    Text = "Seigneur de nécrovia"
  },
  Activity_95979_ActivityTips = {
    Text = "<Title:Règles de l'événement>\n· Pendant l'événement « Maître des ossements oubliés », le gardien peut utiliser l'équipe prédéfinie incluant Dullayan pour tenter sans limite les niveaux désignés.\n· Pendant l'expérience des niveaux événementiels, il n'est pas possible de modifier les réveilleurs dans l'équipe.\n<Title:Récompenses de l'événement>\n· Après avoir accompli pour la première fois le défi du niveau, il est possible de réclamer la récompense d'essai depuis l'interface de l'événement."
  },
  Activity_95980_ActivityName = {
    Text = "Cadeau de Fixation de Noyau Spirituel II"
  },
  Activity_95980_ActivityPlot = {
    Text = "Après l'achat, « Durelsein » peut être activé\n<BlueQuality:Profondissement de personnalité +4, déverrouiller la surexaltation>"
  },
  Activity_96174_ActivityName = {
    Text = "Détective chanceux"
  },
  Activity_96174_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Lors de l'événement \"Détective Chanceux\", les Gardiens peuvent utiliser des équipes prédéfinies par le système qui incluent Ryker pour vivre des niveaux désignés à l'infini.\n·Lors de l'expérience des niveaux de l'événement, des ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir réussi à terminer le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_96617_ActivityName = {
    Text = "Plusieurs nuances de rouge érable"
  },
  Activity_96617_ActivityTips = {
    Text = "<Title:Règles de l'événement>\n1. Les Gardiens peuvent réclamer des récompenses dans \"Plusieurs Teintes de Rouge Érable\" après avoir complété des tâches d'archive désignées.\n2. \"Plusieurs Teintes de Rouge Érable\" se terminera le 23 mars à 9h00 (GMT+8).\n3. Après avoir débloqué les \"Archives Premium\", des récompenses supplémentaires peuvent être réclamées après l'achèvement des tâches.\n4. Veuillez noter : Les \"Archives Premium\" débloquées lors de cet événement ne sont valables que pendant la durée de cet événement. Il est conseillé aux Gardiens de consommer de manière responsable."
  },
  Activity_96617_BannerText = {
    Text = "Événement spécial Chronologie à durée limitée !"
  },
  Activity_96838_ActivityName = {
    Text = "Texte temporaire"
  },
  Activity_96838_ActivityPlot = {
    Text = "Une explosion nucléaire de couleurs, une folie des formes. \n Une toile presque normale, barbouillée de coups de pinceau ensanglantés, \n sous la spatule, les âmes errantes frémissent et murmurent dans l'ombre de la toile. \n La plus réelle et parfaite des arts se cache derrière la folie et l'absurde, \n seule la folie qui déchire les apparences permet d'apercevoir l'intérieur du monde."
  },
  Activity_96838_ActivityStageEndContent = {
    Text = "Événement terminé, participation actuelle uniquement à « L'atelier de Pickman »"
  },
  Activity_96838_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, les Gardiens du secret pourront collecter des monnaies d'événement « Teinture du réel », « Teinture des rêves » et « Teinture de folie » via les modes de jeu temporaires « Rouleau d'Autre-Monde » et « Récompenses de réalisations ». Les monnaies « Teinture du réel », « Teinture des rêves » et « Teinture de folie » peuvent être utilisées pour acheter des articles dans « L'atelier de Pickman », y compris la Roue du Destin SR exclusive à l'événement « Pinceau du désir », le Cœur de Lumens, le Cœur Immaculé, etc.\n2. Pendant l'événement, « Plongée dans l'inconscient : Tableau déformé » sera déverrouillé gratuitement pour une durée limitée. En accomplissant les succès de l'événement, vous pourrez également obtenir l'avatar exclusif à l'événement « Au nom de la Clé d'argent : Pickman » !\n\n<Title:Durée de l'événement>\n1. Du 8 septembre à 9h00 au 22 septembre à 9h00 (GMT+8), toutes les activités peuvent être participées.\n2. Du 22 septembre à 9h00 au 29 septembre à 9h00 (GMT+8), seules « L'atelier de Pickman » et les Récompenses de réalisations peuvent être participées.\n\n<Title:Rouleau d'Autre-Monde>\n1. Le « Rouleau d'Autre-Monde » comprend 7 niveaux, un niveau sera automatiquement ouvert chaque jour.\n2. Chaque défi consommera 120 points de Ménophine, et un défi réussi rapportera des monnaies d'événement.\n3. Après avoir terminé un niveau, la fonction « Reconstitution » de ce niveau sera déverrouillée. Veuillez noter : en utilisant la fonction « Reconstitution », il n'est pas possible d'obtenir le taux de synchronisation.\n4. Vous pouvez utiliser l'assistance des anciens élèves pour vous aider à passer les niveaux plus facilement.\n\n<Title:L'atelier de Pickman>\n1. « L'atelier de Pickman » comprend trois magasins, dont les horaires d'ouverture sont les suivants :\n « Atelier réel » : Ouverture le 8 septembre à 9h.\n « Atelier de Rêves » : Ouverture le 10 septembre à 9h.\n « Atelier de Folie » : Ouverture le 12 septembre à 9h.\n2. Chaque échange consommera 750 « Teinture du réel » / « Teinture des rêves » / « Teinture de folie », vous permettant d'obtenir aléatoirement cinq récompenses parmi les articles de l'atelier.\n3. Les récompenses d'articles de chaque atelier sont divisées en « Objet spécial » et « Objet ordinaire ». Lors de la réinitialisation, la quantité restante d'objets spéciaux peut être remise à son maximum. Les règles spécifiques sont les suivantes :\n(1) Pour les deux premières réinitialisations : lorsque le nombre d'objets spéciaux est épuisé, le Gardien peut choisir de réinitialiser. Après la réinitialisation, le nombre restant des « Objet spécial » et « Objet ordinaire » sera remis à zéro. Vous pouvez également choisir de continuer à échanger ; lorsque le nombre d'objets ordinaires est épuisé, vous devez réinitialiser pour continuer à échanger.\n(2) À partir de la troisième réinitialisation : vous ne pouvez réinitialiser que lorsque le nombre d'objets ordinaires est épuisé. La réinitialisation remettra à zéro le nombre restant d'objets ordinaires à son maximum, tandis que les objets spéciaux ne seront plus remis à zéro.\n\n<Title:Bonus d'événement>\n1. Les Gardiens du secret ayant des Éveilleurs ou des Roues du Destin spécifiques (aucun besoin d'être en équipe) peuvent obtenir un bonus de chute supplémentaire sur les « Teinture du réel », « Teinture des rêves » et « Teinture de folie » dans les récompenses des tâches du « Rouleau d'Autre-Monde ». Les bonus spécifiques sont les suivants :\n Éveilleur « Pickman » : Dégagement 0/1/2/3 et plus, bonus de 20%/30%/40%/50%.\n Roue du Destin SSR « Paradoxe du Réalisme » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%.\n Roue du Destin SR « Pinceau du désir » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%.\n2. Les « Bonus d'événement » des différents Éveilleurs ou Roues du Destin sont cumulés.\n3. En particulier, la récompense de défi de passage pour la difficulté Folie ne sera pas affectée par les « Bonus d'événement ».\n\n<Title:Plongée dans l'inconscient>\n1. Pendant l'événement, « Plongée dans l'inconscient : Tableau déformé » peut être déverrouillé gratuitement.\n2. Après la fin de l'événement, la progression d'enquête de « Plongée dans l'inconscient : Tableau déformé » sera conservée. Même après la fin de l'événement, vous pouvez obtenir des récompenses d'enquête identiques à celles de l'événement en complétant les événements d'enquête non terminés durant l'événement. Si « Plongée dans l'inconscient : Tableau déformé » n'a pas été déverrouillée durant l'événement, vous pourrez toujours dépenser « Point de départ réel » *3 pour déverrouiller après la fin de l'événement.\n3. Que ce soit pendant ou après l'événement, après avoir terminé « Plongée dans l'inconscient : Tableau déformé », vous pourrez obtenir « Sésame : Couleur du Monde Illusoire »."
  },
  Activity_96838_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_96839_ActivityName = {
    Text = "Événement de déblocage gratuit"
  },
  Activity_97190_ActivityName = {
    Text = "Chroniques des Squelettes"
  },
  Activity_97190_ActivityTips = {
    Text = "Règles de l'événement :\n1. Après avoir terminé les tâches désignées du voyage, le gardien du secret pourra réclamer des récompenses dans « Voyage des Ossements ».\n2. Une fois le « Voyage avancé » déverrouillé, des récompenses supplémentaires pourront être réclamées après l'accomplissement des missions.\n3. L'achat du « Voyage avancé » est limité dans le temps pour cet événement ; il ne sera plus possible de l'acheter une fois la date limite passée. Veuillez acheter avec discernement avant le 18 août à 9h00.\n4. Veuillez noter : le « Voyage avancé » déverrouillé lors de cet événement n'est valide que pour cet événement. Merci de faire preuve de discernement et de consommer de manière raisonnable."
  },
  Activity_97190_BannerText = {
    Text = "Événement spécial Chronologie à durée limitée !"
  },
  Activity_97297_ActivityName = {
    Text = "Reine des Épines"
  },
  Activity_97297_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Pendant l'événement \"Reine des Épines\", les Gardiens peuvent utiliser des équipes préétablies par le système incluant Wanda pour expérimenter des niveaux désignés à l'infini.\n·Lors de l'expérience des niveaux de l'événement, les ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir réussi à terminer le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_97672_ActivityName = {
    Text = "Texte temporaire"
  },
  Activity_97672_ActivityPlot = {
    Text = "Texte temporaire"
  },
  Activity_97672_ActivityStageEndContent = {
    Text = "Événement terminé, participation uniquement à « Sept jours de création »"
  },
  Activity_97672_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant l'événement, le Gardien pourra collecter la monnaie événementielle « Aromathérapie apaisante », « Diffuseur de cauchemar » et « Aromathérapie d'Attrape-rêves » via les modes temporaires limités « Sept jours de création » et les « Récompenses de succès ». Ces monnaies pourront être utilisées dans « Chambre de la Mère divine » pour acheter des objets, notamment la Roue du Destin SR exclusive « Toxine à anneau bleu », le Cœur de Lumens, le Cœur Immaculé, etc. \n2. En accomplissant les succès événementiels pendant l'événement, vous pourrez également obtenir l'avatar exclusive « Au nom de la Clé d'argent : Murphy : Égarée » !\n\n<Title:Période de l'événement>\n1. Du 24 novembre à 9h00 au 15 décembre à 9h00 (GMT+8), tous les modes événementiels seront disponibles. \n2. Du 15 décembre à 9h00 au 22 décembre à 9h00 (GMT+8), seuls la « Chambre de la Mère divine » et les récompenses de succès seront accessibles. \n\n<Title:Sept jours de création>\n1. « Sept jours de création » contient 7 niveaux, un niveau s'ouvrant automatiquement chaque jour. \n2. Chaque défi consommera 120 points de Ménophine, et la réussite rapportera des monnaies événementielles. \n3. Une fois un niveau terminé, la fonction « Reproduire » sera débloquée pour ce niveau. Veuillez noter : la « Reproduction » ne permet pas d'obtenir de taux de synchronisation. \n4. Vous pourrez utiliser l'aide des anciens pour faciliter le passage des niveaux. \n\n<Title:Fête de la Prière Profane>\n Après le début de l'événement, vous recevrez automatiquement 60 « Aromathérapie apaisante » par heure, avec un maximum de stockage de 25 heures. \n\n<Title:Chambre de la Mère divine>\n1. La « Chambre de la Mère divine » contient trois magasins, disponibles aux dates suivantes :\n« Douceur des Rêves Étranges » : disponible à partir du 24 novembre à 9h00.\n« Naissance divine dans un rêve profond » : disponible à partir du 25 novembre à 9h00.\n« Cauchemar sans espoir » : disponible à partir du 26 novembre à 9h00. \n2. Chaque offrande coûtera 750 « Aromathérapie apaisante »/« Diffuseur de cauchemar »/« Aromathérapie d'Attrape-rêves », et vous recevrez aléatoirement cinq récompenses d'objets dans la chambre. \n3. Les récompenses d'objets de chaque chambre sont divisées en « Objet spécial » et « Objet ordinaire ». Lors de la réinitialisation, vous pouvez réinitialiser la quantité restante d'objets spéciaux à son maximum. Les règles spécifiques sont les suivantes : \n(1) Pour les deux premières réinitialisations : lorsque les « Objet spécial » n'ont plus de quantité restante, le Gardien peut choisir de réinitialiser, ce qui remettra la quantité restante des « Objet spécial » et « Objet ordinaire » à son maximum ; il peut également choisir de continuer l'offrande. Lorsque les « Objet ordinaire » n'ont plus de quantité restante, une réinitialisation est nécessaire pour continuer l'offrande. \n(2) À partir de la troisième réinitialisation : vous ne pouvez réinitialiser que lorsque les « Objet ordinaire » n'ont plus de quantité restante. La réinitialisation remettra la quantité restante des « Objet ordinaire » à son maximum, mais les « Objet spécial » ne seront plus réinitialisés. \n\n<Title:Bonus événementiel>\n1. Les Gardiens du secret possédant un Corps éveillé ou une Roue du Destin spécifique (pas nécessaire d'être déployés) peuvent obtenir un bonus supplémentaire de chute pour les « Aromathérapie apaisante », « Diffuseur de cauchemar » et « Aromathérapie d'Attrape-rêves » dans les récompenses des missions des niveaux « Sept jours de création ». Les bonus sont les suivants :\nCorps éveillé « Murphy : Égarée » : Dégagement 0/1/2/3 et plus, bonus de 20%/30%/40%/50%.\nRoue du Destin SSR « Repos dans les ténèbres » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%.\nRoue du Destin SR « Toxine à anneau bleu » : Superposition 0/1/2/3 et plus, bonus de 20%/30%/40%/50%. \n2. Les bonus événementiels de différents Corps éveillés ou Roues du Destin s'additionnent. \n3. À noter : les récompenses de premier passage en difficulté Folie ne sont pas affectées par les « bonus événementiels »."
  },
  Activity_97672_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_97853_ActivityName = {
    Text = "Si tout est normal"
  },
  Activity_97853_ActivityPlot = {
    Text = "Tu as déjà rêvé de ce que serait la vie de tout le monde si la catastrophe n'était jamais survenue. \n Ton pouvoir de sauver le monde n'a plus d'utilité, tu dois te battre chaque jour pour une vie scolaire ordinaire et gagner des crédits dérisoires. Sur le terrain, il n'y a plus d'ombres s'entraînant au combat, remplacées par des rangées de tentes pour les activités de clubs et les cris de promotion et de plaisanterie ; lorsque la cloche de la fin des cours sonne, les étudiants affamés envahissent immédiatement la cantine... \n En frappant aux portes des personnes qui te tiennent à cœur, quels sourires verras-tu ?"
  },
  Activity_97853_ActivityStageEndContent = {
    Text = "[Si tout est normal] L'événement est Terminé, actuellement il est seulement possible de participer au [Bâtiment du bureau de l'association des étudiants]"
  },
  Activity_97853_ActivityTips = {
    Text = "<Title:Présentation de l'événement>\n1. Pendant la période de l'événement, les Gardiens du secret peuvent collecter la monnaie de l'événement « Coquillages de spécialité côtière » via le mode limité « Rien de nouveau sous le soleil ». Les « Coquillages de spécialité côtière » peuvent être utilisés pour acheter des articles dans le « Bâtiment du bureau de l'association des étudiants », y compris le Cœur de Lumens, le Cœur Immaculé et des Éclats de Pierre Sage, etc.\n2. Pendant la période de l'événement, « Monde des Rêves Étranges : Adieu, le Pays des Merveilles » est déverrouillé gratuitement et temporairement !\n\n<Title:Temps de l'événement>\n1. Du 6 octobre à 9h00 au 20 octobre à 9h00 (GMT+8), tous les modes d'événements sont accessibles.\n2. Du 20 octobre à 9h00 au 27 octobre à 9h00 (GMT+8), seulement le « Bâtiment du bureau de l'association des étudiants » et les récompenses de réalisations sont accessibles.\n\n<Title:Rien de nouveau sous le soleil>\n1. « Rien de nouveau sous le soleil » comprend 5 niveaux, un nouveau niveau s'ouvrira automatiquement tous les 2 jours.\n2. Chaque défi consommera 120 points de Ménophine, et un défi réussi rapportera de la monnaie de l'événement.\n3. Après avoir terminé un niveau, la fonction « Reproduction » de ce niveau sera déverrouillée. Veuillez noter : lorsque vous utilisez la fonction « Reproduction », vous ne pouvez pas obtenir de taux de synchronisation.\n4. Vous pouvez utiliser l'assistance des anciens pour vous aider à passer les niveaux plus facilement.\n\n<Title:Bonus d'activité>\n1. Déverrouillez « Archives Avancées » dans « Chroniques de relevé » pour activer un bonus de 100% sur les « Coquillages de spécialité côtière » (y compris la reproduction)\n\n<Title:Bâtiment du bureau de l'association des étudiants>\nLe « Bâtiment du bureau de l'association des étudiants » dispose d'un magasin, ouvert le 6 octobre à 9h00.\nDans le magasin, vous pouvez choisir des articles et les acheter directement.\n\n<Title:Monde des Rêves Étranges>\n1. Pendant la période de l'événement, « Monde des Rêves Étranges : Adieu, le Pays des Merveilles » peut être déverrouillé gratuitement.\n2. À la fin de l'événement, la progression des enquêtes de « Monde des Rêves Étranges : Adieu, le Pays des Merveilles » sera conservée, et en complétant les événements d'enquête non terminés pendant la période de l'événement, vous pourrez également obtenir des récompenses d'enquête identiques à celles de la période de l'événement. Si « Monde des Rêves Étranges : Adieu, le Pays des Merveilles » n'est pas déverrouillé pendant la période de l'événement, vous pourrez toujours le déverrouiller après la fin de l'événement en consommant « Point de départ réel » *7.\n3. Que ce soit pendant ou après la période de l'événement, après avoir terminé « Monde des Rêves Étranges : Adieu, le Pays des Merveilles », vous recevrez « Décret Clé : Un instant de beau rêve »."
  },
  Activity_97853_BannerText = {
    Text = "Événement à Durée Limitée Maintenant Disponible !"
  },
  Activity_97854_ActivityName = {
    Text = "Événement de déblocage gratuit"
  },
  Activity_97950_ActivityName = {
    Text = "Chronique de cartographie"
  },
  Activity_97950_ActivityPromotionalText1 = {
    Text = "Augmentez la récompense en monnaie d'événement de 100 % dans le niveau « Rien de nouveau sous le soleil »."
  },
  Activity_97950_ActivityTips = {
    Text = "Règles de l'événement :\n1. Après avoir terminé les tâches désignées, le gardien peut réclamer des récompenses dans « Voyage de Cartographie ».\n2. Après avoir déverrouillé le « Voyage Avancé », des récompenses supplémentaires peuvent être obtenues après avoir complété les missions.\n3. L'achat de ce « Voyage Avancé » est limité dans le temps, et il ne sera plus possible de l'acheter après la date limite. Veuillez que le gardien achète avec discernement avant le 17 novembre à 9h00.\n4. Veuillez noter : le « Voyage Avancé » déverrouillé dans cet événement n'est valable que pendant cet événement. Veuillez que le gardien consomme de manière raisonnable."
  },
  Activity_97950_BannerText = {
    Text = "Événement spécial Chronologie à durée limitée !"
  },
  Activity_97995_ActivityName = {
    Text = "Pas de bonbons, pas de paix !"
  },
  Activity_97995_ActivityTips = {
    Text = "<Title:Présentation>\nUne mystérieuse flamme de bougie, une fête animée, la petite sorcière chassant des bonbons, fait une grande entrée entourée de fantômes !\n« Braquage ! Mettez tous les bonbons — caramel, chocolat, bonbons au lait, gélifiés aux fruits… tous dans le sac ! »\n« Tu dis que c'est encombrant de mettre les guimauves ? Hum… donne-les moi, je vais les dévorer tout de suite ! ».\n\n<Title:Règles de l'événement>\n1. Pendant l'événement, le gardien du secret peut utiliser « Bonbon au potiron au goût étrange » pour tirer l'Illusion 4 étoiles « Affaire de vol de bonbons » de Murphy.\n2. Le premier tirage est gratuit ! Chaque « Bonbon au potiron au goût étrange » coûte « Élixir » ×60, les 2-10ème tirages nécessitent respectivement « Bonbon au potiron au goût étrange » ×1/2/2/3/5/5/5/5/5.\n3. À partir du 5ème tirage, il y a une chance d'obtenir une Illusion 4 étoiles, un maximum de 10 tirages garantit l'obtention de l'Illusion 4 étoiles de la période.\n4. À la fin de l'événement, les « Bonbons au potiron au goût étrange » restants seront récupérés par e-mail et remboursés au prix d'origine."
  },
  Activity_97995_BannerText = {
    Text = "Extraction de vêtements fantômes limitée dans le temps !"
  },
  Activity_98445_ActivityName = {
    Text = "Interprète éternel"
  },
  Activity_98445_ActivityTips = {
    Text = "<Title:Règles de l'Événement>\n·Lors de l'événement \"Interprète Éternel\", les Gardiens peuvent utiliser des équipes prédéfinies par le système qui incluent Hameln pour vivre des niveaux désignés à l'infini.\n·Lors de l'expérience des niveaux de l'événement, des ajustements aux Réveilleurs dans la composition de l'équipe ne sont pas autorisés.\n<Title:Récompenses de l'Événement>\n·Après avoir réussi à terminer le défi de niveau pour la première fois, les joueurs peuvent réclamer des récompenses d'essai dans l'interface de l'événement."
  },
  Activity_98446_ActivityName = {
    Text = "Lueur de Mareel"
  },
  Activity_98446_ActivityTips = {
    Text = "<Title:Règles de l'événement>\n· Pendant la durée de l'événement « Lumière froide », le gardien peut utiliser l'équipe prédéfinie du système incluant Kephasant pour expérimenter indéfiniment les niveaux désignés.\n· Lors de l'expérience des niveaux événementiels, il n'est pas possible d'ajuster les réveilleurs dans l'équipe.\n<Title:Récompenses de l'événement>\n· Après avoir accompli le défi du niveau pour la première fois, il est possible de recevoir la récompense d'essai depuis l'interface de l'événement."
  },
  Activity_99296_ActivityName = {
    Text = "Nous nous retrouverons enfin"
  },
  Activity_99296_ActivityPlot = {
    Text = "Connectez-vous quotidiennement pour recevoir la roue du destin SSR limitée et commémorative « Nous nous retrouverons enfin », un total de 16 !"
  },
  Activity_99296_ActivityTips = {
    Text = "<Title:Présentation>\nCeci est un poème dédié aux joueurs, sur les idéaux, sur la foi, sur les moments de solidarité. Que le cœur sincère ne cesse jamais de battre, que la clé d'argent guide notre chemin.\n\n<Title:Règles de l'événement>\n·Pendant l'événement, le Gardien peut se connecter chaque jour pour réclamer la roue du destin SSR limitée « Nous nous retrouverons enfin » dans « Nous nous retrouverons enfin », pour un total de 16 réclamations.\n·Les récompenses seront débloquées en fonction des connexions cumulées, et seront réinitialisées à 9h (GMT+8) chaque jour."
  },
  Activity_99296_BannerText = {
    Text = "RdD SSR limitée gratuite"
  }
})
return Text_Activity
