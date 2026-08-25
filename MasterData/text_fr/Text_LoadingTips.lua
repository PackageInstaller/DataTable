__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_LoadingTips = readonly({
  LoadingTips_17465_LoadingTips = {
    Text = "\nTaux d'affinité : Le degré de synchronisation mentale entre l'Enquêteur, le Gardien et leur Éveilleur partenaire.\nPlus le Taux d'affinité est élevé, plus la compréhension est profonde, plus la relation est proche et plus la confiance entre eux est forte."
  },
  LoadingTips_17466_LoadingTips = {
    Text = "Dans le Domaine, les émotions, les pensées, les idées et les obsessions peuvent se manifester sous forme de projections observables. Ces projections sont généralement des objets intangibles, des illusions trompeuses créées par la dimension spirituelle pour tromper les sens des individus dans la dimension réelle."
  },
  LoadingTips_17467_LoadingTips = {
    Text = "Le transfert de gnose est un dispositif spécial installé dans les valises des Enquêteurs et des Gardiens, permettant le transfert de la conscience dans des Cartes de haute dimension : Cartes de Commandement, visibles uniquement à travers l'équipement d'observation de Dissolution."
  },
  LoadingTips_17468_LoadingTips = {
    Text = "Une fois qu'un D-Rift se forme, il ne peut pas rétrécir ou être annulé.\nLes moyens ordinaires ne peuvent pas affecter un D-Rift, mais une Clé Argent peut le supprimer ou même le \"fermer\" dans une certaine mesure."
  },
  LoadingTips_17469_LoadingTips = {
    Text = "La plupart des individus affectés par la Dissolution éprouvent des troubles mentaux, tels que la paranoïa, le TOC et la manie, ainsi que des pertes de mémoire."
  },
  LoadingTips_17470_LoadingTips = {
    Text = "La corrosion de Dissolution peut se produire sur les êtres organiques, y compris les humains, les animaux et les plantes, ainsi que sur des substances inorganiques telles que minéraux et métaux. \nAucun matériau n'a été trouvé pour être immunisé contre le D-phénomène."
  },
  LoadingTips_17471_LoadingTips = {
    Text = "La plupart des humains ne peuvent pas observer le D-phénomène à l'œil nu."
  },
  LoadingTips_17472_LoadingTips = {
    Text = "Les corps Dissolus peuvent généralement être classés en fonction des différentes aberrations. Les types les plus courants sont les corps Dissolus coopératifs, les corps Dissolus d'interférence et les corps Dissolus composites."
  },
  LoadingTips_17473_LoadingTips = {
    Text = "Les manifestations de D-phénomène sur les matériaux apparaissent sous forme de petits trous triangulaires inversés, simples ou multiples. \nCes trous varient en taille d'environ 3 mm à 1 cm, avec des D-marques qui s'étendent au fur et à mesure de la dissolution."
  },
  LoadingTips_17474_LoadingTips = {
    Text = "La Dissolution est un phénomène unique de désintégration et de dissolution matérielle, avec des caractéristiques régionales."
  },
  LoadingTips_17475_LoadingTips = {
    Text = "À un certain stade du développement du D-phénomène, il y a une certaine probabilité que des excroissances émergent des D-marques. \nCelles-ci pourraient être des membres supplémentaires, des tentacules ou peut-être des rouages et des pièces métalliques..."
  },
  LoadingTips_17476_LoadingTips = {
    Text = "D-boue est hydrophobe, imperméable et difficile à dissoudre dans l'eau, avec une viscosité modérée et une certaine élasticité.\nIl y a des centaines d'années, des humains imprudents ont tenté de l'utiliser comme matériau industriel et artistique."
  },
  LoadingTips_17477_LoadingTips = {
    Text = "\"Bienvenue dans la Grange — où nous avons le plus de classeurs et le moins de funérailles.\" \nLes Archives et le Bureau des Dossiers de la CMT sont surnommés de manière humoristique \"la Grange\" par le Comité en raison de leur similarité phonétique."
  },
  LoadingTips_17478_LoadingTips = {
    Text = "Les membres des sculpteurs se réfèrent souvent à eux-mêmes comme \"Pygmalion\", et leur logo organisationnel est également un ciseau."
  },
  LoadingTips_17479_LoadingTips = {
    Text = "La dissolution est inconnue des mundanes, mais dans certaines sociétés secrètes, les gens croient fermement qu'il ne s'agit pas d'une calamité, mais plutôt d'une bénédiction de Dieu."
  },
  LoadingTips_17480_LoadingTips = {
    Text = "\nUne massive D-marque d'un diamètre dépassant 5 mètres et avec un potentiel d'expansion supplémentaire est connue sous le nom de D-faille. \nLe noyau de la faille est appelé \"Clades\"."
  },
  LoadingTips_17481_LoadingTips = {
    Text = "La Gnose d'urgence impacte directement l'esprit de l'Éveilleur, libérant son potentiel et restaurant instantanément son état. Le seul inconvénient en est son coût élevé."
  },
  LoadingTips_17482_LoadingTips = {
    Text = "Les missions sur le terrain sont très imprévisibles et sont jonchées de facteurs incontrôlables forts.\nPour y remédier, l'Université Mythag fournit au personnel de terrain des dispositifs d'urgence pour maximiser leur sécurité."
  },
  LoadingTips_17483_LoadingTips = {
    Text = "Les enquêteurs et les gardiens ne traitent généralement pas des événements ordinaires du monde réel mais plutôt d'événements spéciaux impliquant la dissolution, les corps dissous et des connexions significatives à la Dimension Esprit."
  },
  LoadingTips_17484_LoadingTips = {
    Text = "Dans les zones avec le D-phénomène, les projections de la Dimension spirituelle sont plus claires et les Domaines plus faciles à observer, bien qu'ils soient plus volatils et dangereux."
  },
  LoadingTips_17485_LoadingTips = {
    Text = "Les Éveilleurs sont grossièrement divisés en quatre Royaumes : Aequor, Caro, Ultra et Chaos, en fonction de leurs traits."
  },
  LoadingTips_17486_LoadingTips = {
    Text = "Après le Rituel de la Clé Mound, les Enquêteurs et les Gardiens doivent compléter une tâche de terrain supervisée avec leurs Réveilleurs partenaires pour s'assurer qu'ils possèdent la capacité d'effectuer de manière indépendante de futures tâches de terrain."
  },
  LoadingTips_17487_LoadingTips = {
    Text = "Le Comité Mystia (abrégé en CMT) est une organisation secrète composée d'êtres humains ordinaires, établie conjointement par les gouvernements mais existant indépendamment d'eux. \nC'est le premier découvreur et le premier intervenant face au D-phénomène, \net aussi la première ligne de défense pour les humains ordinaires contre la Dissolution."
  },
  LoadingTips_17488_LoadingTips = {
    Text = "Différents Réveilleurs dans le même Royaume peuvent mieux coopérer, tandis qu'il peut y avoir une certaine répulsion entre différents Royaumes. \nSeul le Royaume du Chaos n'exhibe pas ce phénomène."
  },
  LoadingTips_17489_LoadingTips = {
    Text = "Les argents existent généralement en deux formes dans le monde réel : l'argent primaire et les argents rhomboédriques."
  },
  LoadingTips_17490_LoadingTips = {
    Text = "L'index gnostique mesure la stabilité des Fragments d'Esprit dans l'Argent.\nLes Éveilleurs avec des indices plus élevés sont moins susceptibles de perdre le contrôle, et s'ils le font, ils causeront moins de victimes."
  },
  LoadingTips_17491_LoadingTips = {
    Text = "La création d'une Clé d'Argent implique une série de processus complexes, culminant avec la gravure d'un numéro unique.\nLes Clés d'Argent sont strictement interdites d'échange ou de don, et seront récupérées par Mythag lorsqu'elles ne seront plus possédées."
  },
  LoadingTips_17492_LoadingTips = {
    Text = "Les livres tabous sont verrouillés sur l'étagère la plus haute de la bibliothèque et ne peuvent être accessibles que par du personnel autorisé."
  },
  LoadingTips_17493_LoadingTips = {
    Text = "L'Université Mythag fournira un soutien de la Technologie de Puce Argent à la Comité du Traité Mystia selon les clauses pertinentes du Traité Mystia pour résister ensemble à la dissolution et faire face à la crise"
  },
  LoadingTips_17494_LoadingTips = {
    Text = "Chaque individu produit des quantités différentes d'Argent lors de sa dissolution.\nLes individus avec un pouvoir spirituel plus fort produisent plus d'Argent lorsqu'ils sont dissous, tandis que ceux avec un pouvoir spirituel plus faible en produisent moins."
  },
  LoadingTips_17495_LoadingTips = {
    Text = "Les articles représentatifs de la Technologie Silver Chip comprennent l'Équipement d'Observation de Dissolution, le Communicateur de l'Université Mythag, et la Clé d'Argent.\nLe plus unique et précieux d'entre eux est la Clé d'Argent."
  },
  LoadingTips_17496_LoadingTips = {
    Text = "Lors de la Cérémonie de Réveil, les Enquêteurs et les Gardiens utilisent des Clés Argentées pour renforcer la connexion entre l'Argent et la Dimension de l'Esprit.\nGrâce à cette connexion, les Enquêteurs et les Gardiens peuvent capturer les Fragments d'Esprit errants dans la Dimension de l'Esprit et les ancrer au sein de l'Argent."
  },
  LoadingTips_17497_LoadingTips = {
    Text = "Les Éveilleurs sont créés de force lorsque l'Argent capture et fixe des Fragments d'Esprit de la Dimension Spirituelle. Ces fragments sont influencés par la Dimension Spirituelle, ainsi tous les Éveilleurs entrent naturellement dans un État de Folie lors de leur réveil. Cet état persiste jusqu'à ce qu'un Enquêteur ou un Gardien établisse un Lien avec eux."
  },
  LoadingTips_17498_LoadingTips = {
    Text = "Mythag University, établie le 16 octobre 187 Hongji, est un établissement d'enseignement supérieur dédié à la recherche et à la lutte contre la Dissolution."
  },
  LoadingTips_17499_LoadingTips = {
    Text = "Le prédécesseur de Mythag University, Mythag College, a été fondé le 16 octobre de l'an 90 de l'ère Hongji par Wald Phillips et deux autres fondateurs."
  },
  LoadingTips_17500_LoadingTips = {
    Text = "Les enquêteurs et les gardiens avec une Clé Argent peuvent traverser le Brouillard de la Cour de Récréation et entrer sur le campus avec des Éveilleurs liés."
  },
  LoadingTips_17501_LoadingTips = {
    Text = "Il y a 315 ans, une catastrophe massive a frappé le globe.\nCette année a été marquée comme le début d'une nouvelle ère—l'Époque des Inondations."
  },
  LoadingTips_17502_LoadingTips = {
    Text = "\"Que la Clé d'Argent guide ton chemin.\"\nUne bénédiction commune parmi les membres de l'Université Mythag, incarnant leur esprit indomptable."
  },
  LoadingTips_17503_LoadingTips = {
    Text = "\"Jure de percer l'obscurité avec la lame.\"\nUn serment commun des membres du Comité du Traité Mystia, reflétant leur détermination sans faille à combattre la Dissolution."
  },
  LoadingTips_17504_LoadingTips = {
    Text = "Ces talents spéciaux qui possèdent plus de capacités et peuvent lier plus d'Éveilleurs que les enquêteurs ordinaires se voient accorder le titre de Gardien.\nJusqu'à présent, seuls quelques-uns dans le monde portent le nom de Gardien."
  },
  LoadingTips_17505_LoadingTips = {
    Text = "En général, un Enquêteur ne peut se lier qu'à un seul Réveiller à la fois. Cependant, des exceptions existent."
  },
  LoadingTips_17506_LoadingTips = {
    Text = "Quand il n'y a pas de missions sur le terrain, les Enquêteurs, Gardiens et leurs Réveilleurs se reposent à l'Université Mythag.\nIls assistent à des cours, passent des examens et complètent de longues missions extrascolaires."
  },
  LoadingTips_17507_LoadingTips = {
    Text = "Tous les Réveilleurs doivent se conformer aux règlements du Traité de Mystia et s'enregistrer après leur éveil"
  },
  LoadingTips_17508_LoadingTips = {
    Text = "En termes stricts, les Réveilleurs sont également une forme de Technologie des Pépites Argentées."
  },
  LoadingTips_36756_LoadingTips = {
    Text = "Selon le type de fissure, une fissure peut avoir un ou plusieurs cœurs appelés « Fléau »."
  },
  LoadingTips_36757_LoadingTips = {
    Text = "Mythag a développé, affiné et personnalisé une série de processus de filtrage basés sur la théorie de la \"Composition et du Potentiel Mental de l'Enquêteur\" afin de découvrir des Enquêteurs potentiels sans alerter le grand public."
  },
  LoadingTips_36758_LoadingTips = {
    Text = "L'esprit de chacun est différent, et les capacités uniques de chaque Gardien varient également. \nLes capacités actuellement connues incluent : Mémoire partagée, émotions partagées, et perception de l'humeur, parmi d'autres."
  },
  LoadingTips_36759_LoadingTips = {
    Text = "Il y a 315 ans, une grande inondation a balayé le monde. L'ordre s'est effondré, les villes se sont écroulées, et des montagnes sous la mer se sont soudainement élevées, formant de nouvelles terres."
  },
  LoadingTips_36760_LoadingTips = {
    Text = "Leo Fang, la monnaie commune du Royaume de Leo. Les monnaies auxiliaires telles que Mane et Pensh sont également en circulation. 1 Leo Fang équivaut à 10 Mane, et 1 Mane équivaut à 10 Pensh."
  },
  LoadingTips_36761_LoadingTips = {
    Text = "Un espace spécial temporairement isolé à l'aide d'instruments et d'Argent, non affecté par d'autres esprits ou la dimension réelle, est appelé un Domaine Artificiel."
  },
  LoadingTips_36762_LoadingTips = {
    Text = "À travers l'ascenseur, vous pouvez atteindre l'espace souterrain de Mythag.\nEn plus de la plus grande Fissure L-01 \"Black Pool\" à Londinium, il existe diverses zones restreintes nécessitant un certain niveau de sécurité pour y entrer."
  },
  LoadingTips_36763_LoadingTips = {
    Text = "En raison de la connexion entre la clé en argent et la dimension spirituelle, la clé peut réagir à proximité d'individus ayant des états spirituels anormaux"
  },
  LoadingTips_36764_LoadingTips = {
    Text = "Les Pactes sont des runes mystérieuses enregistrées sur des matériaux avec de l'Argent en utilisant des méthodes spéciales.\nDifférents pactes fournissent différentes aides, et la même série de pactes peut offrir plus d'assistance."
  },
  LoadingTips_36765_LoadingTips = {
    Text = "D-boue est une mélasse noire qui s'infiltre des D-marques.\nTout comme le D-phénomène lui-même, sans instruments spéciaux, les gens ordinaires ne peuvent pas l'observer directement."
  },
  LoadingTips_36766_LoadingTips = {
    Text = "Certaines corps dissous se transforment en une poudre noire, connue sous le nom de D-poussière, à la mort."
  },
  LoadingTips_36767_LoadingTips = {
    Text = "Le Royaume de Leo est situé à l'est de l'Océan Atlanta, bordant la Fédération Constante et l'Union Evergreen.\nLe royaume est petit en taille mais puissant, étant l'un des premiers à achèvement de reconstruction après le déluge."
  },
  LoadingTips_36768_LoadingTips = {
    Text = "La République Aglo est située sur le côté occidental de l'Océan Atlanta, entourée par la mer et possédant de vastes zones intérieures.\nLa République Aglo est très développée dans l'industrie et la finance, son centre financier, Fletcher, étant un lieu animé que beaucoup rêvent de visiter."
  },
  LoadingTips_36769_LoadingTips = {
    Text = "Dans le Domaine, les émotions, les pensées, les idées et les obsessions peuvent se manifester sous forme de projections observables.\nCes projections sont généralement intangibles ou se dissipent au contact, des illusions de la Dimension Spirituelle qui trompent les sens des individus dans la dimension physique."
  },
  LoadingTips_36770_LoadingTips = {
    Text = "La Fédération Constante est située sur le continent de Laurasie orientale, une fédération formée par plusieurs petits pays. Dans la fédération, l'art est une quête commune pour tous."
  },
  LoadingTips_36771_LoadingTips = {
    Text = "Certaines projections spéciales peuvent être capturées par le **Transfert de Gnose** et attachées à des cartes de commande, offrant aux **Réveilleurs** des bonus. Ces projections sont appelées **Oraison**."
  },
  LoadingTips_36772_LoadingTips = {
    Text = "D'après la taille des D-Rifts, ils peuvent être classés en six catégories : C, B, A, S, SS et SSS."
  },
  LoadingTips_36773_LoadingTips = {
    Text = "Les Sculpteurs, une organisation extrême obsédée par des expériences humaines peccamineuses, a été fondée par Robert Rosenthal, un traître de Mythag."
  },
  LoadingTips_36774_LoadingTips = {
    Text = "Le Marin est une ancienne organisation religieuse dirigée par Miryam.\nIls travaillent avec acharnement, tout cela dans le but de réveiller leur unique Dieu-Roi."
  },
  LoadingTips_36775_LoadingTips = {
    Text = "Différentes zones du Domaine produisent différents objets lors de l'Investigation. Même des objets apparemment identiques peuvent posséder des essences très différentes."
  },
  LoadingTips_36776_LoadingTips = {
    Text = "Un Domaine est une dimension spéciale entre la dimension spirituelle et la dimension physique, et est l'espace le plus proche que les humains peuvent physiquement entrer dans la dimension spirituelle."
  },
  LoadingTips_36777_LoadingTips = {
    Text = "Mythag University est une partie absolument neutre. Toutes les questions, grandes ou petites, sont décidées conjointement par le principal et l'équipe de gestion par consultation, sans aucune contrainte organisationnelle."
  },
  LoadingTips_36778_LoadingTips = {
    Text = "Les D-Rifts n'ont pas besoin de compter sur des objets physiques pour exister ; ils peuvent apparaître dans le ciel, l'océan et d'autres lieux."
  },
  LoadingTips_36779_LoadingTips = {
    Text = "L'Église de la lumière du temple, un culte secret et maléfique, semble avoir de profonds liens avec les Sculpteurs et les Marins."
  },
  LoadingTips_36780_LoadingTips = {
    Text = "Le Comité du Traité Mystia est une organisation extrêmement vaste.\nEn dehors du Royaume de Leo, elle a des branches dans la République Aglo, la Fédération Constante, et même l'Empire Remouahe."
  }
})
return Text_LoadingTips
