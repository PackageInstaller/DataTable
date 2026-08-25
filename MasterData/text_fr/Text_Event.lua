__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Event = readonly({
  Event_116371_ChoiceDesc1 = {Text = "[Leave]"},
  Event_116371_Desc = {
    Text = "Vous acceptez l'appel de l'école, la voix familière vous apaise. Vous reprenez courage et continuez"
  },
  Event_116371_Name = {
    Text = "Point de contact"
  },
  Event_116372_ChoiceDesc1 = {Text = "[Leave]"},
  Event_116372_Desc = {
    Text = "Tu as déclenché une pièce inconnue."
  },
  Event_116372_Name = {Text = "Inconnu"},
  Event_116373_ChoiceDesc1 = {Text = "[Leave]"},
  Event_116373_Desc = {
    Text = "Tu as trouvé un trésor."
  },
  Event_116373_Name = {Text = "trésor"},
  Event_116374_ChoiceDesc1 = {
    Text = "[Connecter] restaurer Arg2 points de vie"
  },
  Event_116374_Desc = {
    Text = "Tu explores dans la brume, soudain, l'insigne sur ta poitrine émet une faible lueur argentée. Qui t'appelle de l'autre côté de la communication ?"
  },
  Event_116374_Name = {
    Text = "Point de contact"
  },
  Event_116389_ChoiceDesc1 = {Text = "[Leave]"},
  Event_116389_Desc = {
    Text = "Pincer le visage est encore endormi...zzZZ"
  },
  Event_116389_Name = {
    Text = "Pincer le visage"
  },
  Event_116429_ChoiceDesc1 = {Text = "[Leave]"},
  Event_116429_Desc = {
    Text = "Tu as déclenché un événement aléatoire 3."
  },
  Event_116429_Name = {
    Text = "Événement aléatoire 3"
  },
  Event_116430_ChoiceDesc1 = {Text = "[Leave]"},
  Event_116430_Desc = {
    Text = "Tu as déclenché un événement aléatoire 1."
  },
  Event_116430_Name = {
    Text = "Événement aléatoire 1"
  },
  Event_116431_ChoiceDesc1 = {Text = "[Leave]"},
  Event_116431_Desc = {
    Text = "Tu as déclenché un événement aléatoire 2."
  },
  Event_116431_Name = {
    Text = "Événement aléatoire 2"
  },
  Event_117279_ChoiceDesc1 = {
    Text = "[Vous avez désiré l'innocence] Placez 3 cartes [(Skill.Arg1)] dans le deck."
  },
  Event_117279_Desc = {
    Text = "\nUne légère brume blanche s'élève au-dessus du niveau de la mer, enveloppant tout dans une atmosphère floue. \nFranchissant la frontière entre la vie et la mort, traversant la distance entre l'intérieur et l'extérieur de la porte, et les souvenirs qui s'estompent lentement, tu aperçois la silhouette de la demoiselle tenant un parasol, éclairée par la lumière. \nLe temps passé avec elle est révolu, tout comme sa jeunesse éclatante mais fragile. \nAttendant que le faux soleil se lève, la brume se brise dans l'invisible, et son ombre se balance dans le rêve, se transformant en une bulle illusoire flottante, te faisant un adieu silencieux."
  },
  Event_117279_Name = {
    Text = "Le Fantôme de Murphy"
  },
  Event_117280_ChoiceDesc1 = {
    Text = "[Vous avez désiré l'innocence] choisissez 2 cartes pour leur conférer l'oraison « Écho des profondeurs »."
  },
  Event_117280_Desc = {
    Text = "\nUne fine brume blanche s'élève au-dessus du niveau de la mer, enveloppant tout dans une atmosphère floue. \nFranchissant la frontière entre la vie et la mort, la distance entre l'intérieur et l'extérieur de la porte, et les souvenirs qui s'estompent avec le temps, tu aperçois la silhouette d'une demoiselle tenant un parasol, en contre-jour. \nLe temps passé avec elle est révolu, tout comme sa jeunesse éclatante mais fragile. \nAttendant que le faux soleil se lève, la brume se dissipe dans l'invisible, son ombre se balance dans le rêve, se transformant en une bulle d'illusion légère, te faisant un adieu silencieux."
  },
  Event_117280_Name = {
    Text = "Le Fantôme de Murphy"
  },
  Event_118414_ChoiceDesc1 = {
    Text = "[Trois Points]"
  },
  Event_118414_ChoiceDesc2 = {
    Text = "[Six Points]"
  },
  Event_118414_ChoiceDesc3 = {Text = "[Un point]"},
  Event_118414_Desc = {
    Text = "Les dés roulent, émettant un son gargouillant.\nQuand cela s'arrêtera-t-il ?\nVous ne savez pas, mais vous devez donner une réponse."
  },
  Event_118414_Name = {
    Text = "Pari du destin"
  },
  Event_118415_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118415_Desc = {
    Text = "Votre réponse rend le \"Ciel\" encore plus doux.\nIl dépose légèrement un baiser sur votre front.\nPuis, une vague de fleurs s'épanouit sur votre front."
  },
  Event_118415_Name = {
    Text = "Étreinte de la mer"
  },
  Event_118416_ChoiceDesc1 = {
    Text = "[Se perdre dans l'illusion] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_118416_ChoiceDesc2 = {
    Text = "[Garder la raison] pour chaque corps éveillé avec une valeur aliemus de 50 ou plus, obtient 15 marques noires"
  },
  Event_118416_ChoiceDesc3 = {
    Text = "[Partir de force] Obtient 3 choix 1 oraison"
  },
  Event_118416_Desc = {
    Text = "Peut-être est-ce la longue bataille qui vous a rendu désorienté, ou peut-être que c'est simplement que votre cerveau a trahi votre corps.\n Une sensation d'apesanteur apparaît dans votre esprit.\n En un instant, votre esprit se transforme soudainement en kaléidoscope, éclatant de couleurs, scintillant de toutes les nuances de lumière.\n D'innombrables aperçus, réflexions et fantasmes affluent dans votre cerveau, occupant chaque coin des interstices de votre esprit.\n Si cela continue, votre cerveau va bientôt éclater de ces pensées chaotiques."
  },
  Event_118416_Name = {
    Text = "Kaléidoscope de pensée"
  },
  Event_118417_ChoiceDesc1 = {
    Text = "[Tenter sa chance]Infecter 「(Skill.Arg1)」, entrer dans le Jeu de Destin"
  },
  Event_118417_ChoiceDesc2 = {
    Text = "[Oublie Ça] Gagne 25 sigils noirs"
  },
  Event_118417_Desc = {
    Text = "Dans un état de stupeur, ta conscience a dérivé à travers des couches de brume, se dispersant dans l'espace inconnu.\nDeux dés ont été lancés devant toi, mais l'existence inconnue qui t'a amené ici de force restait invisible.\nTu ne pouvais qu'entendre les voix chaotiques venant de toutes les directions.\n«Tu veux rentrer ? Alors jouons un tour.»\n«Avec ta vie comme mise, que le pari avec le destin commence.»"
  },
  Event_118417_Name = {
    Text = "Pari du destin"
  },
  Event_118418_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118418_Desc = {
    Text = "Les expériences transcendantes sont toujours brèves. Elles arrivent silencieusement et disparaissent soudainement.  \nMais au moins ta tête est toujours là, elle n'a pas vraiment explosé."
  },
  Event_118418_Name = {
    Text = "Kaléidoscope de pensée"
  },
  Event_118419_ChoiceDesc1 = {
    Text = "[Partir] Obtient une relique d'argent[(RelicConfig.Arg1)]"
  },
  Event_118419_Desc = {
    Text = "Tu n'as pas perdu, mais tu n'as pas gagné non plus ; le résultat n'est ni bon ni mauvais.\n« C'est une égalité... »\nL'existence inconnue soupira, mais il n'y avait aucune trace de regret dans sa voix.\n« Quel agréable petit passe-temps. »"
  },
  Event_118419_Name = {
    Text = "Pari du destin"
  },
  Event_118420_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118420_Desc = {
    Text = ": Tu es un maître de musique, mais aussi un musicien ordinaire.\nLes notes sont toutes sous le contrôle de ta pensée, la vie fluide sonne enfin dans le domaine"
  },
  Event_118420_Name = {
    Text = "« Hymne parfait »"
  },
  Event_118421_ChoiceDesc1 = {
    Text = "[Percevoir le cerveau]choisir 1 carte de commandement parmi 3 pour obtenir une oraison :「(EnchantConfig.Arg1)」"
  },
  Event_118421_ChoiceDesc2 = {
    Text = "[Percevoir l'âme]Développer「(Skill.Arg1)」, ré-impression, jusqu'à 2 fois"
  },
  Event_118421_Desc = {
    Text = "La première cage de l'homme est son propre corps. \n Dans cette cage corporelle, le cerveau est la dernière et la plus importante des prisons. \n « Chérie, tu penses que tant que tu es en vie et que tu respires, tu es en sécurité ? » \n Lorsque ton cerveau trahit ton âme, tu expérimenteras les tourments les plus douloureux de ce monde. \n Et ces tourments t'accompagneront toute ta vie."
  },
  Event_118421_Name = {
    Text = "Cage cérébrale"
  },
  Event_118422_ChoiceDesc1 = {
    Text = "[Toucher le Papillon] Supprimer 2 cartes"
  },
  Event_118422_ChoiceDesc2 = {
    Text = "[Chasser le Papillon]Obtenez une créature maudite「(RelicConfig.Arg1)」, mais développer「(Skill.Arg2)」"
  },
  Event_118422_ChoiceDesc3 = {
    Text = "[Leave] Gagner Arg1 sigles noirs"
  },
  Event_118422_Desc = {
    Text = "Il n'y a pas de papillons dans les profondeurs marines. Ce sont les jeunes filles enfermées dans la pièce qui ont imaginé ces vies. \n Elles sont si belles, volant librement dans les airs. \n « Si seulement… si je pouvais aussi m'envoler comme elles, quitter cet endroit… » \n Un papillon a poussé un sanglot, mais ce son était couvert par le bruit des battements d'ailes, noyé dans le cliquetis des machines à écrire, à peine audible."
  },
  Event_118422_Name = {
    Text = "Chapitre Papillon"
  },
  Event_118423_ChoiceDesc1 = {
    Text = "[Découper la corde]Infectez «(Skill.Arg1)», obtenez une Créature maudite «(RelicConfig.Arg2)»"
  },
  Event_118423_ChoiceDesc2 = {
    Text = "[Le délier]Infectez deux fois «(Skill.Arg1)», obtenez des Créations en argent «(RelicConfig.Arg2)» et «(RelicConfig.Arg3)»"
  },
  Event_118423_ChoiceDesc3 = {
    Text = "[Le libérer pour toujours]Obtenez une Création en argent «(RelicConfig.Arg1)»"
  },
  Event_118423_Desc = {
    Text = "«Certains disent que le désir sans fin est la force motrice du progrès.\nMais quand ce désir devient si puissant qu'il ne peut plus être ignoré ni tranché... je le sens se transformer de l'intérieur en une cage.»\nUne voix faible émergea de l'obscurité. Tu ne pouvais voir le visage de celui qui parlait, seulement une paire de mains liées.\n«Ces désirs se nourrissent de ma peur, de ma faiblesse, de mon espoir, de ma douleur... et ce faisant, ils ne font que se renforcer.»\nLa voix lança une dernière supplique désespérée.\n«Je suis prêt à tout sacrifier ! Âme charitable, s'il te plaît... sauve-moi. Ou accorde-moi la délivrance.»"
  },
  Event_118423_Name = {
    Text = "Liens des désirs"
  },
  Event_118424_ChoiceDesc1 = {
    Text = "[Percevoir le cerveau]choisir 1 carte de commandement parmi 3 pour obtenir une oraison :「(EnchantConfig.Arg1)」"
  },
  Event_118424_Desc = {
    Text = "Tu sens ta moelle cérébrale se contracter. \n « Est-ce que cela a une signification particulière ? » \n Tu te demandes, mais ton cerveau reste silencieux. \n Ce n'est pas chaque question que tu te poses qui obtient une réponse."
  },
  Event_118424_Name = {
    Text = "Cage cérébrale"
  },
  Event_118425_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118425_Desc = {
    Text = "Tu nages avec force à contre-courant, et tu finis par émerger à la surface. \n L'air mélangé à l'odeur de la mer envahit tes poumons, te rappelant que tu n'as pas vraiment échappé au danger. \n Mais tu sais que le véritable ciel est au-dessus de ta tête. \n Comme la vérité, elle ne sera jamais cachée par de douces mensonges."
  },
  Event_118425_Name = {
    Text = "Étreinte de la mer"
  },
  Event_118426_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118426_Desc = {
    Text = "Au moment où vous touchez la corde du Désir, une douleur vive surgit des profondeurs de votre Âme.\nVotre peur, faiblesse, espoir et douleur jaillissent de vous, se transformant en une corde ensanglantée qui lie vos mains.\nÀ ce moment-là, vous entendez les applaudissements malveillants de cette voix.\n\"Bonne personne au grand cœur, vous serez récompensée... bien sûr, il y a aussi une malédiction.\""
  },
  Event_118426_Name = {
    Text = "Liens des désirs"
  },
  Event_118427_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118427_Desc = {
    Text = "Ton toucher fait trembler les papillons. \n Depuis leur naissance, ils n'ont jamais connu un traitement aussi doux. \n Les papillons sont dominés par des émotions déconcertantes, oubliant même de voler. \n Ainsi, d'innombrables papillons tombent, révélant la machine à écrire qui était cachée sous tant d'ailes. \n Cette pauvre chose qui a déjà perdu la vie, avec ses dernières forces, a joué les mots « liberté »."
  },
  Event_118427_Name = {
    Text = "Chapitre Papillon"
  },
  Event_118428_ChoiceDesc1 = {
    Text = "[Se préparer au combat] Choisissez 1 Carte d'instruction parmi 3 pour obtenir une Oraison : «(EnchantConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_118428_ChoiceDesc2 = {
    Text = "[Tenter un détour] Obtenez 25 Marques noires"
  },
  Event_118428_Desc = {
    Text = "Dans les profondeurs de l'Aequor où la lumière des étoiles tombe, les Marcheurs des mers ont hiberné pendant des siècles. \n Les eaux infinies ont été témoins de leur folie, de leur patience, et de leur dévouement le plus sincère envers les divinités. \n Personne ne peut empêcher la grande descente des dieux. \n Quiconque se met en travers de leur chemin sera réduit en cendres par la colère des Marcheurs des mers."
  },
  Event_118428_Name = {
    Text = "Attente sous les Étoiles"
  },
  Event_118429_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118429_Desc = {
    Text = "Vous avez instinctivement couvert vos oreilles.\nIncroyablement, les sons provenant du fond de votre âme ont disparu.\nBien sûr, ce n'était que temporaire."
  },
  Event_118429_Name = {
    Text = "Mélodie profanatrice"
  },
  Event_118430_ChoiceDesc1 = {
    Text = "[Revisiter le passé] Obtenez 1 Oraison avancée choisie parmi 3"
  },
  Event_118430_ChoiceDesc2 = {
    Text = "[Regard vers le futur] Gagne une Création en or «(RelicConfig.Arg1)», infecte «(Skill.Arg2)»"
  },
  Event_118430_ChoiceDesc3 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_118430_Desc = {
    Text = "Rien dans le monde ne peut rester statique.\n Même le paradis sculpté par la Déesse Mère n'est pas une exception.\n En un instant fugace, vous apercevez quelque chose à travers les fissures du temps et de l'espace.\n Le passé, le présent et le futur s'entrelacent dans cette fissure craquée, changeant constamment.\n Attendant votre regard curieux"
  },
  Event_118430_Name = {
    Text = "Faille spatio-temporelle"
  },
  Event_118431_ChoiceDesc1 = {
    Text = "[Gagner 100 sigils noirs]"
  },
  Event_118431_ChoiceDesc2 = {
    Text = "[2 Cartes d'instruction aléatoires obtiennent l'Oraison : «(EnchantConfig.Arg1)»]"
  },
  Event_118431_Desc = {
    Text = "Les créations sont formées par la stagnation de la sagesse stable, peut-être peuvent-elles apporter une mélodie harmonieuse"
  },
  Event_118431_Name = {
    Text = "« Hymne parfait »"
  },
  Event_118432_ChoiceDesc1 = {
    Text = "[Nourrir les rats] Obtient une Création en argent [(RelicConfig.Arg1)], développe 1 symptôme"
  },
  Event_118432_ChoiceDesc2 = {
    Text = "[Chasser les rats] Gravure d'Oraison sur 1 carte parmi 3 : «(EnchantConfig.Arg1)», mais développe «(Skill.Arg2)»"
  },
  Event_118432_ChoiceDesc3 = {
    Text = "[Ignorer les rats] Obtenez 25 Marques noires"
  },
  Event_118432_Desc = {
    Text = "Tout sur ce navire est piégé dans la boucle temporelle.\nMême ces dégoûtantes petites créatures poilues luttant pour survivre ici ne peuvent échapper à leur destin.\nCycle après cycle, elles dévorent tout ce qui est en vue, mais leur faim n'est jamais rassasiée.\n«Si... faim...»\nDes hordes de rats émettent des cris perçants et maladifs.\nLes cycles sans fin les ont rendus affamés et dérangés — ils doivent manger quelque chose.\nMaintenant. Immédiatement."
  },
  Event_118432_Name = {
    Text = "Meute de rats affamés"
  },
  Event_118433_ChoiceDesc1 = {
    Text = "[Éviter leur Regard]Obtenez une Création en or «(RelicConfig.Arg1)», mais contractez «(Skill.Arg2)»"
  },
  Event_118433_ChoiceDesc2 = {
    Text = "[Fixer les Yeux]Réveiller aléatoirement 2 éveillés, mais contractez «(Skill.Arg1)» deux fois"
  },
  Event_118433_ChoiceDesc3 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_118433_Desc = {
    Text = "Tout comme les étoiles dans le ciel, il y a certainement de nombreux yeux dans les profondeurs de la mer.\nCes yeux appartiennent aux poissons vivant au fond de l'océan, aux espèces de branchies profanées, et à l'océan lui-même.\nChut, ne les dérangez pas.\nNe, dérangez pas la folie des profondeurs marines."
  },
  Event_118433_Name = {
    Text = "Œil des abysses"
  },
  Event_118434_ChoiceDesc1 = {
    Text = "[Ignorer les Murmures]"
  },
  Event_118434_ChoiceDesc2 = {
    Text = "[Écouter les Murmures]"
  },
  Event_118434_ChoiceDesc3 = {
    Text = "[Inventer quelque chose]"
  },
  Event_118434_Desc = {
    Text = "«Désires-tu la faveur de Dieu ? Veux-tu connaître ta propre signification ?»\nUn soupir résonne à tes oreilles, comme le murmure intérieur d'un esprit perturbé, ou le chuchotement intime de quelque chose d'informe.\nSous la raison et la vigilance, tu rejettes cette voix, mais elle continue de parler toute seule.\n«Écoute patiemment, s'il te plaît. Ce que tu apprendras est la vérité concernant le destin du monde...»"
  },
  Event_118434_Name = {
    Text = "Prêche de l'intangible"
  },
  Event_118435_ChoiceDesc1 = {
    Text = "[Percevoir le cerveau]choisir 1 carte de commandement parmi 3 pour obtenir une oraison :「(EnchantConfig.Arg1)」"
  },
  Event_118435_ChoiceDesc2 = {
    Text = "[Percevoir l'âme]Développer「(Skill.Arg1)」, nouvelle oraison au hasard"
  },
  Event_118435_Desc = {
    Text = "Le cerveau protégé dans votre crâne vous transmet certaines informations. \n Vous ne savez pas si ces informations ont été altérées lors de la conversion des neurotransmetteurs et de la transmission des courants bioélectriques. \n Le seul fait certain est que vous avez reçu ces informations et que, dans l'existence objective de votre corps, vous avez perçu votre survie."
  },
  Event_118435_Name = {
    Text = "Cage cérébrale"
  },
  Event_118436_ChoiceDesc1 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_118436_Desc = {
    Text = "« Bonne réponse, mais malheureusement, pas la bonne réponse. »\n« Quelle est la bonne réponse ? »\nL'existence inconnue n'a pas répondu à ta question, laissant seulement échapper un rire dédaigneux.\n« Qui t'a dit que le destin avait une bonne réponse ? »"
  },
  Event_118436_Name = {
    Text = "Pari du destin"
  },
  Event_118437_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118437_Desc = {
    Text = "«Tu crois que je n'ai pas essayé de les trancher ? Non — résister au désir ne fait que le rendre plus fort !»\nAlors que les cordes du désir se resserrent, s'enfonçant dans la chair, la voix pousse un hurlement désespéré.\n«Je ne pourrai jamais m'en libérer... jamais !»"
  },
  Event_118437_Name = {
    Text = "Liens des désirs"
  },
  Event_118438_ChoiceDesc1 = {
    Text = "[Serrer le corbeau]Obtenez 25 le sigil noir, contagion「(Skill.Arg2)」，continuez à choisir"
  },
  Event_118438_ChoiceDesc2 = {
    Text = "[Ignorez-le] Partez"
  },
  Event_118438_Desc = {
    Text = "Le corbeau noir comme l'encre pleure.\nLe corbeau noir comme l'encre crie.\nLe corbeau noir comme l'encre ulule.\nPourtant, pour les gens, cela ne ressemble qu'à un chant.\n\"Ah, quelle chanson insouciante. Je voudrais être un corbeau, loin des tracas du monde.\""
  },
  Event_118438_Name = {
    Text = "Lamentation non perçue"
  },
  Event_118439_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118439_Desc = {
    Text = "Même si les mots sont effacés, tu peux toujours percevoir la valeur de la lettre"
  },
  Event_118439_Name = {
    Text = "Chapitre Papillon"
  },
  Event_118440_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118440_Desc = {
    Text = "Dans l'image du passé, la jeune fille en manteau en peluche te fait signe. \n Tu ne peux pas entendre ce qu'elle dit, mais tu vois le sourire de la jeune fille."
  },
  Event_118440_Name = {
    Text = "Faille spatio-temporelle"
  },
  Event_118441_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118441_Desc = {
    Text = "Aequor est à nouveau plongé dans l'obscurité et le silence.\nDans cette obscurité et ce silence, tu entends à nouveau le battement de ton cœur.\nCe son vient de l'intérieur de toi.\nAux yeux des autres, tu n'es qu'un cœur battant dérivant dans la mer noire abyssale."
  },
  Event_118441_Name = {
    Text = "La loi du plus fort"
  },
  Event_118442_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118442_Desc = {
    Text = "Ton apparition laisse les ombres perplexes, un rayon d'étoile effleure tes chaussures, et la foule disparaît soudainement, ne laissant que l'ombre la plus dense dans ta main"
  },
  Event_118442_Name = {
    Text = "Attente sous les Étoiles"
  },
  Event_118443_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118443_Desc = {
    Text = "Bien qu'ils aient l'avantage numérique, ces rats sales sont plus courageux que leur propre corps.\nIls sont intimidés par votre forte attitude et se dispersent dans la panique."
  },
  Event_118443_Name = {
    Text = "Meute de rats affamés"
  },
  Event_118444_ChoiceDesc1 = {
    Text = "[Tendre une Main Secourable] Réveille aléatoirement 1 réveilleur, mais développe [(Skill.Arg1)]"
  },
  Event_118444_ChoiceDesc2 = {
    Text = "[Observer en Silence] Obtenir 1 sur 3 Orisons"
  },
  Event_118444_Desc = {
    Text = "Un cœur battant nage dans l'obscurité de l'Aequor.\nIl appartient peut-être à un poisson nageur, ou peut-être à une créature dotée de branchies. \nTu ne peux pas voir clairement. Ce que tu peux voir, c'est ce cœur qui bat sans cesse, et derrière ce cœur, une grande bouche sanguinaire qui s'ouvre progressivement. \nChasser, ou être chassé, est la loi de la nature. \nQue ce soit sur terre ou dans l'océan."
  },
  Event_118444_Name = {
    Text = "La loi du plus fort"
  },
  Event_118445_ChoiceDesc1 = {
    Text = "[Chasser d'un geste] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infectée par «(Skill.Arg2)»"
  },
  Event_118445_ChoiceDesc2 = {
    Text = "[Let It Stay] Gagne la Relique d'Argent \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_118445_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_118445_Desc = {
    Text = "Un léger bruit se fait entendre dans les ténèbres. \n C'est un papillon qui demande poliment. \n « Puis-je me poser dans le creux de ta main ? » \n « Je suis juste trop fatigué, je veux me reposer un peu... » \n En posant cette question, le papillon traverse les ténèbres, tournoyant devant toi. \n Un liquide noir et collant tombe de ses ailes — c'est le don des ténèbres lorsque le papillon traverse l'obscurité."
  },
  Event_118445_Name = {
    Text = "Demande de papillon"
  },
  Event_118446_ChoiceDesc1 = {
    Text = "[Partir] Obtient une relique en or[(RelicConfig.Arg1)]"
  },
  Event_118446_Desc = {
    Text = "Après un moment de silence, quelque chose fut jeté dans tes bras.\n« Prends-le et pars. »\n« Le destin est toujours généreux envers les fortunés. »"
  },
  Event_118446_Name = {
    Text = "Pari du destin"
  },
  Event_118447_ChoiceDesc1 = {
    Text = "[Suivre le guide] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_118447_ChoiceDesc2 = {
    Text = "[Ignorer le guide] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_118447_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_118447_Desc = {
    Text = "Le festival a commencé.\nSous les flammes de l'Esprit et les bénédictions du sang, d'innombrables Âmes de croyants sont devenues des phares—\nLes esprits éthérés se dispersent autour de vous comme des fées guides, éclatants et attendant votre choix."
  },
  Event_118447_Name = {
    Text = "Phare de l'âme"
  },
  Event_118448_ChoiceDesc1 = {
    Text = "[Partir] Infection[(Skill.Arg1)], obtenez 50 sigils noirs"
  },
  Event_118448_Desc = {
    Text = "«Humains ignorants !»\nCette voix émit une plainte frustrée, mais sans aller jusqu'à la colère.\nCar elle sait que les ignorants auront toujours des moments d'illumination.\nIl lui suffit d'attendre que ce jour arrive.\nEt avant que ce jour ne vienne, elle vous marquera du sceau de Dieu, confirmant l'appartenance de votre Âme."
  },
  Event_118448_Name = {
    Text = "Prêche de l'intangible"
  },
  Event_118449_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118449_Desc = {
    Text = "[@2 de @3......]\nUn flot de connaissances, accompagné de cet air blasphématoire, se déverse dans votre cerveau.\nMais votre forme mortelle vous limite, rendant la sagesse cosmique hors de votre portée.\nQuel regret douloureux."
  },
  Event_118449_Name = {
    Text = "Mélodie profanatrice"
  },
  Event_118450_ChoiceDesc1 = {
    Text = "[Partir] Infection[(Skill.Arg1)], obtenez 50 sigils noirs"
  },
  Event_118450_Desc = {
    Text = "«En fait, moi aussi j'ai une vérité sur le monde que je voudrais vous raconter...»\n«Le monde a été créé par un dieu de pâtes volant composé de deux yeux de boulettes de viande pleins de sagesse et de pâtes symbolisant une capacité infinie...»\nVous inventez sérieusement une histoire drôle que vous avez entendue, attendant la réaction de l'autre partie.\nMais après un long moment, l'autre côté reste silencieux.\n«Hélas, il semble que les croyants fervents ne comprennent pas l'humour.»\nEn soupirant, vous ne pouvez que partir."
  },
  Event_118450_Name = {
    Text = "Prêche de l'intangible"
  },
  Event_118451_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118451_Desc = {
    Text = "Avec un bon accord, les dissonances se sont adoucies.\nMais peut-être peux-tu faire encore mieux"
  },
  Event_118451_Name = {
    Text = "« Hymne parfait »"
  },
  Event_118452_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118452_Desc = {
    Text = "Trois figures tremblaient, pleurant silencieusement.\nVotre doute sur leur foi était la plus grande offense qu'un fanatique ne pouvait tolérer."
  },
  Event_118452_Name = {
    Text = "Le meilleur sacrifice"
  },
  Event_118453_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118453_Desc = {
    Text = "Tu ignores froidement les sonneries désespérées.\nMême si la prochaine seconde te ramène à l'âge primitif, même si toi et ta grande mission êtes enterrés ensemble.\nUn appel qui ne doit pas être pris, ne doit pas être pris.\nTu connais bien cette simple vérité"
  },
  Event_118453_Name = {
    Text = "Faille spatio-temporelle"
  },
  Event_118454_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118454_Desc = {
    Text = "Les chuchotements bruyants s'arrêtent soudainement, des ombres noires se tournent vers toi, te fixant. Sur ces visages sans traits, tu lis une certaine moquerie"
  },
  Event_118454_Name = {
    Text = "Attente sous les Étoiles"
  },
  Event_118455_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118455_Desc = {
    Text = "L'existence inconnue ne t'a pas fait obstacle.\n« Un jour, tu reviendras. »\n« Personne ne peut refuser le destin. »"
  },
  Event_118455_Name = {
    Text = "Pari du destin"
  },
  Event_118456_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118456_Desc = {
    Text = "Avec un geste rapide et décisif, ces mains tombèrent faiblement.\nMais tu n'as pas manqué le dernier soupir de l'autre personne.\nIl s'est enfin libéré de ses désirs sans fin."
  },
  Event_118456_Name = {
    Text = "Liens des désirs"
  },
  Event_118457_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118457_Desc = {
    Text = "Les corbeaux arrachent leurs plumes, comme les humains rongent leur propre corps.\nDans ce monde de terreur, cela arrive souvent, tu ne peux pas sauver toutes les créatures"
  },
  Event_118457_Name = {
    Text = "Lamentation non perçue"
  },
  Event_118458_ChoiceDesc1 = {
    Text = "[Maintenir le Corbeau]Obtenir 35 le sigil noir, infecter \"(Skill.Arg2)\", continuer la sélection"
  },
  Event_118458_ChoiceDesc2 = {
    Text = "[Ignorez-le] Partez"
  },
  Event_118458_Desc = {
    Text = "Le corbeau noir comme l'encre pleure.\nLe corbeau noir comme l'encre crie.\nLe corbeau noir comme l'encre ulule.\nPourtant, pour les gens, cela ne ressemble qu'à un chant.\n\"Ah, quelle chanson insouciante. Je voudrais être un corbeau, loin des tracas du monde.\""
  },
  Event_118458_Name = {
    Text = "Lamentation non perçue"
  },
  Event_118459_ChoiceDesc1 = {
    Text = "[Listen Closely] Gagnez une relique en argent \"(RelicConfig.Arg1)\" et infligez \"(Skill.Arg2)\"."
  },
  Event_118459_ChoiceDesc2 = {
    Text = "[Plug Ears] Obtenir une Oraison à 3 choix"
  },
  Event_118459_Desc = {
    Text = "Dans la frénésie sans forme, vous semblez voir un piano.\nUne paire de mains floues dansait sur les touches sans forme, jouant des mélodies profanes.\nLa musique bizarre résonnait des profondeurs de votre Âme, voyageant à travers les lignes des vaisseaux sanguins, atteignant votre cerveau tremblant."
  },
  Event_118459_Name = {
    Text = "Mélodie profanatrice"
  },
  Event_118460_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118460_Desc = {
    Text = "Ces inspirations, pensées et fantasmes s'entrelacent, se mêlant aux couleurs les plus éclatantes du monde.\nVous voyez l'espace se plier à l'intérieur de votre propre corps, le temps tourbillonner à votre guise.\nÀ ce moment, vous percevez le temps et l'espace, omnipotent et omniscient.\nBien sûr, vous avez également payé un prix."
  },
  Event_118460_Name = {
    Text = "Kaléidoscope de pensée"
  },
  Event_118461_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118461_Desc = {
    Text = "L'Âme chaotique guide ton chemin avec des gémissements aigus.\nEst-ce un chemin sûr ? Tu ne le sais pas.\nTon seul choix est de continuer à avancer."
  },
  Event_118461_Name = {
    Text = "Phare de l'âme"
  },
  Event_118462_ChoiceDesc1 = {
    Text = "[Maintenir le Corbeau]Obtenir 40 le sigil noir, infecter \"(Skill.Arg2)\", continuer la sélection"
  },
  Event_118462_ChoiceDesc2 = {
    Text = "[Ignorez-le] Gagnez 25 Sigils Noirs et partez."
  },
  Event_118462_Desc = {
    Text = "Le corbeau noir comme l'encre pleure.\nLe corbeau noir comme l'encre crie.\nLe corbeau noir comme l'encre ulule.\nPourtant, pour les gens, cela ne ressemble qu'à un chant.\n\"Ah, quelle chanson insouciante. Je voudrais être un corbeau, loin des tracas du monde.\""
  },
  Event_118462_Name = {
    Text = "Lamentation non perçue"
  },
  Event_118463_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118463_Desc = {
    Text = "L'Âme chaotique laisse échapper un soupir mélancolique.\nElle s'efface progressivement, mais ce soupir triste, s'il avait de la substance, tombe sur ton cœur.\nBoum boum, ton cœur résonne en synchronie avec la mélodie du rituel."
  },
  Event_118463_Name = {
    Text = "Phare de l'âme"
  },
  Event_118464_ChoiceDesc1 = {
    Text = "[Partir] Obtient une relique d'argent[(RelicConfig.Arg1)]"
  },
  Event_118464_Desc = {
    Text = "«Ah, ah, quel agneau dévot que voilà !»\nCette voix soupire, emplie de louanges jubilatoires.\n«Quand mon seigneur s'éveillera, des agneaux comme toi trouveront assurément une place dans ce grand et Exalté Royaume Divin...»"
  },
  Event_118464_Name = {
    Text = "Prêche de l'intangible"
  },
  Event_118465_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118465_Desc = {
    Text = "«Le Ciel» embrasse votre indocilité.\nUn jour, l'enfant égaré retournera dans les bras de sa mère.\nCar vous n'avez nulle part où fuir."
  },
  Event_118465_Name = {
    Text = "Étreinte de la mer"
  },
  Event_118466_ChoiceDesc1 = {
    Text = "[Accepter l'étreinte] Obtenez une Création en argent «(RelicConfig.Arg1)», et infectez «(Skill.Arg2)»"
  },
  Event_118466_ChoiceDesc2 = {
    Text = "[Rejeter l'étreinte] Obtenez une Création en argent «(RelicConfig.Arg1)», et infectez «(Skill.Arg2)»"
  },
  Event_118466_ChoiceDesc3 = {
    Text = "[Nager vers la surface] Obtenez 25 Marques noires"
  },
  Event_118466_Desc = {
    Text = "Le monde se déverse de tes yeux.\n À ce moment-là, la mer profonde qui t'entoure est le \"ciel\".\n Dans la douleur d'une quasi-noyade, ce \"ciel\" bleu profond s'approche doucement, intending à t'embrasser.\n Il ne jugera pas, il donnera seulement"
  },
  Event_118466_Name = {
    Text = "Étreinte de la mer"
  },
  Event_118467_ChoiceDesc1 = {
    Text = "[Les réprimander]Obtenez une Créature maudite «(RelicConfig.Arg1)», mais contractez «(Skill.Arg2)»"
  },
  Event_118467_ChoiceDesc2 = {
    Text = "[Leur répondre] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : [(EnchantConfig.Arg1)]"
  },
  Event_118467_ChoiceDesc3 = {
    Text = "[Ignorer] Obtenez 50 Marques noires"
  },
  Event_118467_Desc = {
    Text = "Trois âmes vaguement formées bloquaient votre chemin.\nUne silhouette s'inclina solennellement devant vous, suppliant que vous lui accordiez du sang. Votre sang coulant est le meilleur sacrifice pour les dieux.\nUne silhouette brandit froidement un couteau envers vous, ayant l’intention de tailler votre chair. Cette chair humaine non-mutée gagnerait sûrement la faveur des dieux.\nLa dernière observait silencieusement, espérant que vous vous ôteriez la vie pour prouver une foi des plus dévotes."
  },
  Event_118467_Name = {
    Text = "Le meilleur sacrifice"
  },
  Event_118468_ChoiceDesc1 = {
    Text = "[Maintenir le Corbeau]Obtenir 30 le sigil noir, infecter \"(Skill.Arg2)\", continuer la sélection"
  },
  Event_118468_ChoiceDesc2 = {
    Text = "[Ignorez-le] Partez"
  },
  Event_118468_Desc = {
    Text = "Le corbeau noir comme l'encre pleure.\nLe corbeau noir comme l'encre crie.\nLe corbeau noir comme l'encre ulule.\nPourtant, pour les gens, cela ne ressemble qu'à un chant.\n\"Ah, quelle chanson insouciante. Je voudrais être un corbeau, loin des tracas du monde.\""
  },
  Event_118468_Name = {
    Text = "Lamentation non perçue"
  },
  Event_118469_ChoiceDesc1 = {
    Text = "[Partir] Infection[(Skill.Arg1)]"
  },
  Event_118469_ChoiceDesc2 = {
    Text = "[Partir] Infection[(Skill.Arg1)]"
  },
  Event_118469_ChoiceDesc3 = {
    Text = "[Partir] Infection[(Skill.Arg1)]"
  },
  Event_118469_Desc = {
    Text = "«Non ! Nous refusons cela ! Nous désirons quelque chose de plus... délectable.»\n«Alors ce sera... votre sang et votre chair !»\nUne nuée de rats pousse des cris stridents, se ruant vers vous.\nIl semble qu'un cœur débordant de bonté puisse parfois apporter plus d'ennuis que de soulagement."
  },
  Event_118469_Name = {
    Text = "Meute de rats affamés"
  },
  Event_118470_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118470_Desc = {
    Text = "Votre respect remporte la faveur de ces yeux.\nAvant qu'ils ne disparaissent, ils vous offrent un cadeau à travers la mer déchaînée.\nC'est la preuve que les profondeurs vous apprivoisent."
  },
  Event_118470_Name = {
    Text = "Œil des abysses"
  },
  Event_118471_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118471_Desc = {
    Text = "Sous votre regard sans réserve, les profondeurs marines s'éveillent lentement.\nLa mer surgit de manière chaotique autour de vous, apportant des murmures indescriptibles.\nRessentez la colère des profondeurs marines, c'est à la fois une bénédiction et une malédiction."
  },
  Event_118471_Name = {
    Text = "Œil des abysses"
  },
  Event_118472_ChoiceDesc1 = {
    Text = "[Serrer le corbeau]Obtenez 20 le sigil noir, contagion「(Skill.Arg2)」"
  },
  Event_118472_ChoiceDesc2 = {
    Text = "[Ignorez-le] Partez"
  },
  Event_118472_Desc = {
    Text = "Le corbeau noir comme l'encre pleure.\nLe corbeau noir comme l'encre crie.\nLe corbeau noir comme l'encre ulule.\nPourtant, pour les gens, cela ne ressemble qu'à un chant.\n\"Ah, quelle chanson insouciante. Je voudrais être un corbeau, loin des tracas du monde.\""
  },
  Event_118472_Name = {
    Text = "Lamentation non perçue"
  },
  Event_118473_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118473_Desc = {
    Text = "Sang, chair, vie.\nLe sacrifice est prêt, maintenant tout ce que tu as à faire est d'attendre calmement le festin divin."
  },
  Event_118473_Name = {
    Text = "Le meilleur sacrifice"
  },
  Event_118474_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118474_Desc = {
    Text = "Une goutte de boue noire tombe sur ton visage, provoquant une démangeaison.\nIncapable de supporter cela, tu chasses le papillon.\nLe papillon esquive ton geste malveillant et disparaît silencieusement au loin"
  },
  Event_118474_Name = {
    Text = "Demande de papillon"
  },
  Event_118475_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118475_Desc = {
    Text = "Mais c'est juste une créature luttant pour survivre, cherchant un morceau de bois flottant pour se reposer...\nTu soupires, laissant le liquide noir de la queue du papillon couler sur ta joue"
  },
  Event_118475_Name = {
    Text = "Demande de papillon"
  },
  Event_118477_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118477_Desc = {
    Text = "Le corbeau rauque ferma enfin les yeux. \n Dans la rancœur non reconnue et non perçue, il rendit son dernier souffle, se transformant en une flaque de boue noire."
  },
  Event_118477_Name = {
    Text = "Lamentation non perçue"
  },
  Event_118478_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118478_Desc = {
    Text = "«Tu es déjà mort, tu ne pourras pas rentrer chez toi.» Ta voix est froide comme le vent hurlant sur les plaines de Ross. L'expression du voyageur ne change pas, comme si cela devait être ainsi. Il saisit à nouveau ta main. «Sauvez-moi. Je suis un soldat, envoyé vers l'est lointain...»"
  },
  Event_118478_Name = {
    Text = "La loi du plus fort"
  },
  Event_118479_ChoiceDesc1 = {
    Text = "[Accepter l'invitation] Développez «(Skill.Arg1),» obtenez une créature maudite «(RelicConfig.Arg2)»"
  },
  Event_118479_ChoiceDesc2 = {
    Text = "[Refuser l'invitation] Détruire une Relique, obtenir une récompense"
  },
  Event_118479_ChoiceDesc3 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_118479_Desc = {
    Text = "«Tout à bord de ce navire doit faire partie de ce paradis cyclique qui se désintègre et se redémarre sans cesse.»\nUne musique frénétique résonne dans ton esprit, une inspiration de l'esprit invisible. \n«Ici, il n'y a pas de pleurs, pas de tristesse, seulement une musique sacrée pure et des rires éternels.»\n«Es-tu prêt à rejoindre le paradis et à devenir une partie de cette mélodie parfaite ?»"
  },
  Event_118479_Name = {
    Text = "« Hymne parfait »"
  },
  Event_118480_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118480_Desc = {
    Text = "Dans votre silence, les âmes se dissipent silencieusement.\nCeux qui ne comprennent pas les croyants ne valent pas leur temps."
  },
  Event_118480_Name = {
    Text = "Le meilleur sacrifice"
  },
  Event_123616_ChoiceDesc1 = {
    Text = "[Receive Standard Relic]"
  },
  Event_123616_Desc = {
    Text = "Réglez tous les Aliemus des Éveilleurs à 100, le Flamboiement de clé à 1000 et les PV à 80 %.\nRetirez 2 cartes et ajoutez 3 cartes de Symptôme.\nRéglez la Forge cramoisie à 12,5 %, choisissez 4 cartes pour entrer dans l'Espace Ultra.\nObtenez un Pack de Reliques Standard."
  },
  Event_123616_Name = {
    Text = "Passer en un clic en cours de route"
  },
  Event_125696_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125696_Desc = {
    Text = "Une rage sans raison vous anime. Vous levez la main, frappant pour les disperser. Vous avez trop longtemps erré dans les énigmes ; peut-être aspirez-vous à un combat sans merci, ou simplement à une fin...\nMais les corbeaux ne font rien. Sous votre regard, l'abîsse se dissout.\nLa nuée disparaît vers le bout de la scène — l'endroit où vous devez aller."
  },
  Event_125696_Name = {
    Text = "Abysses des corbeaux"
  },
  Event_125697_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125697_Desc = {
    Text = "«Lâche.» Elle ne fait aucun effort pour dissimuler la moquerie dans son rire.\n«Va, alors. Le plus loin sera le mieux.»"
  },
  Event_125697_Name = {
    Text = "Les chaînes du Destin"
  },
  Event_125698_ChoiceDesc1 = {
    Text = "[Chasser] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infectée par «(Skill.Arg2)»"
  },
  Event_125698_ChoiceDesc2 = {
    Text = "[Listen] Obtenir la Création en argent «(RelicConfig.Arg1)», mais développer «(Skill.Arg2)»"
  },
  Event_125698_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_125698_Desc = {
    Text = "Un léger bruit se fait entendre dans les ténèbres. Un papillon se pose dans le creux de ta main. Tu t'en souviens.\n« Mademoiselle Arachne... vous ne nous avez jamais abandonnés, n'est-ce pas ? »\nLes beaux motifs du papillon se tournent vers la personne à tes côtés."
  },
  Event_125698_Name = {
    Text = "Le Crépuscule du Papillon"
  },
  Event_125699_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125699_Desc = {
    Text = "Les sons et les textes s'insinuent dans ton esprit comme un essaim bourdonnant. Tu retiens ton souffle, purgeant de ta conscience les parasites inutiles.\nIgnorer est bien plus ardu que lire — et pourtant, tu y es parvenu."
  },
  Event_125699_Name = {
    Text = "Télégramme dimensionnel"
  },
  Event_125700_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125700_Desc = {
    Text = "C'est une illusion conjurée par l'ennemi !\nTu secoues la tête, la clarté revient, et tu ressers ta prise sur la Clé d'argent."
  },
  Event_125700_Name = {
    Text = "Reflet dans le Miroir"
  },
  Event_125701_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125701_Desc = {
    Text = "Tu fixes cet œil du regard, t'efforçant de regarder, d'écouter. Tu tentes de pénétrer dans le cœur de l'acteur et de ressentir l'agonie qu'il endure.\nTu t'approches, toujours plus près. Tu traverses son être et touches son âme même...\nTu ouvres brusquement les yeux pour te retrouver au centre de la scène, des larmes ruisselant au bout de tes doigts.\nC'est là la confession que tu offres au public."
  },
  Event_125701_Name = {
    Text = "La confession d'un acteur"
  },
  Event_125702_ChoiceDesc1 = {
    Text = "[Discuter avec elle] Détruire une carte d'instruction, et obtenir Arg1 marques noires"
  },
  Event_125702_ChoiceDesc2 = {
    Text = "[Garder le silence]"
  },
  Event_125702_Desc = {
    Text = "« Une fin heureuse est bien, pourtant une telle joie creuse ne peut jamais toucher le cœur du public... »\nL'auteure ferme les yeux, plongée dans ses réflexions. Elle est insatisfaite de cette conclusion."
  },
  Event_125702_Name = {
    Text = "La fin de la pièce"
  },
  Event_125703_ChoiceDesc1 = {
    Text = "[Maintenir le Corbeau]Obtenir 35 le sigil noir, infecter \"(Skill.Arg2)\", continuer la sélection"
  },
  Event_125703_ChoiceDesc2 = {
    Text = "[Ignorez-le] Partez"
  },
  Event_125703_Desc = {
    Text = "« Craquement — craquement — la Déesse du Destin tourne Son rouet.\nCraquement — craquement — les Fils du destin convergent entre ses mains. »"
  },
  Event_125703_Name = {
    Text = "La Prophétie Finale"
  },
  Event_125704_ChoiceDesc1 = {
    Text = "[Yourself] Dupliquez 1 parmi 3 Cartes d'instruction aléatoires du deck"
  },
  Event_125704_ChoiceDesc2 = {
    Text = "[William] Choisissez 1 Carte d'instruction parmi 3 pour obtenir une Oraison : «(EnchantConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_125704_ChoiceDesc3 = {
    Text = "[Personne] Obtenez 25 Marques noires"
  },
  Event_125704_Desc = {
    Text = "Tu es certain de ne pas être ivre, pourtant en contemplant l'alcool, tu te retrouves à sombrer dans un lac tranquille.\nUne silhouette élégante apparaît dans le verre. Qui est-ce ?"
  },
  Event_125704_Name = {
    Text = "Reflet dans le Miroir"
  },
  Event_125705_ChoiceDesc1 = {
    Text = "[Listen] Obtenez une création en argent [(RelicConfig.Arg1)]"
  },
  Event_125705_ChoiceDesc2 = {
    Text = "[Dispel] Obtenez 75 marques noires, infection [(Skill.Arg2)]"
  },
  Event_125705_Desc = {
    Text = "Alors que vous approchez du pouvoir du plasmide en vous, une nuée de corbeaux apparaît dans votre esprit, tournoyant dans votre royaume spirituel tumultueux.\n\nLes corbeaux spiralent autour de vous, tels un vortex de l'abîsse suspendu à l'envers au-dessus.\nCent mille corbeaux crient à l'unisson, comme une prophétie moqueuse."
  },
  Event_125705_Name = {
    Text = "Abysses des corbeaux"
  },
  Event_125706_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125706_Desc = {
    Text = "Toi et Arachne tentez de stabiliser le destin qui s'effondre à vos côtés. Vos efforts portent peu de fruits, mais c'est suffisant. Profitant du temps gagné, vous continuez à vous rapprocher de Nefraea.\nTu es venu ici pour lui apporter la délivrance."
  },
  Event_125706_Name = {
    Text = "Chute du rideau sur la Toile du destin"
  },
  Event_125707_ChoiceDesc1 = {
    Text = "[Serrer le corbeau]Obtenez 20 le sigil noir, contagion「(Skill.Arg2)」"
  },
  Event_125707_ChoiceDesc2 = {
    Text = "[Ignorez-le] Partez"
  },
  Event_125707_Desc = {
    Text = "«Elles meurent avec le grand filet, en silence.»"
  },
  Event_125707_Name = {
    Text = "La Prophétie Finale"
  },
  Event_125708_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125708_Desc = {
    Text = "C'est un télégramme adressé aux Abysses en spirale.\n« Ne vous inquiétez pas, mes enfants. Les portes de la prison s'ouvriront bientôt en grand ; votre libération est imminente. »"
  },
  Event_125708_Name = {
    Text = "Télégramme dimensionnel"
  },
  Event_125709_ChoiceDesc1 = {
    Text = "[Chasser] 1 Carte d'instruction aléatoire obtient l'Oraison : «(EnchantConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_125709_ChoiceDesc2 = {
    Text = "[Listen] Grave l'oraison [(EnchantConfig.Arg1)] sur 1 carte d'instruction parmi 3"
  },
  Event_125709_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_125709_Desc = {
    Text = "Un papillon se pose doucement sur ta paume. Ses motifs exquis ressemblent à des yeux qui ne cillent pas, te regardant en silence.\nPeut-être cherche-t-il à te dire quelque chose ?"
  },
  Event_125709_Name = {
    Text = "Sieste de papillon"
  },
  Event_125710_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125710_Desc = {
    Text = "Vingt paires d'yeux endeuillés se fixent sur vous. Le corbeau cesse son chant, quittant cette toile en ruine avec sa prophétie finale."
  },
  Event_125710_Name = {
    Text = "La Prophétie Finale"
  },
  Event_125711_ChoiceDesc1 = {
    Text = "[Lean Out] Infection \"(Skill.Arg1)\", gagnez une Relique d'Or \"(RelicConfig.Arg2)\""
  },
  Event_125711_ChoiceDesc2 = {
    Text = "[Abandonnez la Vérification] Gagnez 50 sigils noirs"
  },
  Event_125711_Desc = {
    Text = "En passant au coin de la rue, vous apercevez une modeste salle de projection. Vous ne vous souvenez pas qu'un tel endroit existait à Londinium."
  },
  Event_125711_Name = {
    Text = "Cinéma des souvenirs"
  },
  Event_125712_ChoiceDesc1 = {
    Text = "[Accepter le Destin]Graver l'Orison「(EnchantConfig.Arg1)」sur 1 Carte d'instruction parmi 3. (Utilisations : 0/2)"
  },
  Event_125712_ChoiceDesc2 = {
    Text = "[Défier le Destin]infecter «(Skill.Arg1)», changer l'oraison à graver. (Utilisations : 2/2)"
  },
  Event_125712_Desc = {
    Text = "« Ah, nous nous retrouvons, ma chère. »\nVous commencez à apprécier la voix de cette dame qui résonne dans votre esprit. Elle est tendre et séduisante, comme une toile pour piéger les mouches.\n« Venez, dites-moi — êtes-vous prête à embrasser votre destin ? »"
  },
  Event_125712_Name = {
    Text = "La Cage du Destin"
  },
  Event_125713_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125713_Desc = {
    Text = "«Stupide humain, nous connaissons-nous ?»\nLe chat noir lève les yeux au ciel avec dédain et se détourne.\n«Pars. Et ne fais plus jamais quelque chose d'aussi stupide.»"
  },
  Event_125713_Name = {
    Text = "Métamorphose"
  },
  Event_125714_ChoiceDesc1 = {
    Text = "[Prendre une photo] Gravure de l'Oraison [(EnchantConfig.Arg1)] sur 1 Carte d'instruction parmi 3.(Utilisations : 0/2)"
  },
  Event_125714_ChoiceDesc2 = {
    Text = "[Changer de pose] Développez le Symptôme [(Skill.Arg1)] et changez l'Oraison à graver.(Utilisations : 2/2)"
  },
  Event_125714_Desc = {
    Text = "Une caméra solitaire trône sur la scène, son objectif d'un noir absolu fixé sur vous tel l'œil à facettes énigmatique forgé par une divinité mécanique.\nCe théâtre est vacant depuis si longtemps... Bienvenue ! Bienvenue ! Venez, prenez une photo ! C'est entièrement gratuit !\nLa caméra s'exclame avec excitation. Sur cette scène abandonnée, elle est la seule protagoniste."
  },
  Event_125714_Name = {
    Text = "Cœur d'image du public"
  },
  Event_125715_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125715_Desc = {
    Text = "«Comment celui qui ne demande rien au destin peut-il espérer une réponse du destin ?»"
  },
  Event_125715_Name = {
    Text = "Les chaînes du Destin"
  },
  Event_125716_ChoiceDesc1 = {
    Text = "[Chercher une issue] Obtenir la Création en argent «(RelicConfig.Arg1)», mais développer «(Skill.Arg2)»"
  },
  Event_125716_ChoiceDesc2 = {
    Text = "[Laisser faire] Obtenir la Création en or «(RelicConfig.Arg1)», mais développer «(Skill.Arg2)» et «(Skill.Arg3)»"
  },
  Event_125716_ChoiceDesc3 = {
    Text = "[Surface] Gagner 25 Sigils Noirs"
  },
  Event_125716_Desc = {
    Text = "Un nouveau niveau. Deux vies entrelacées... Tout en échappant aux officiers, vous organisez les vérités qu'Arachne a partagées avec vous.\nAu milieu des pensées emmêlées, vous sombrez dans une mer profonde et tranquille."
  },
  Event_125716_Name = {
    Text = "Sérénité"
  },
  Event_125717_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125717_Desc = {
    Text = "Le papillon se pose sur ton épaule et s'approche de ton oreille. Tu écoutes attentivement, mais n'entends que le léger battement de ses ailes — un son semblable à un soupir sans voix.\nÀ mesure que tu écoutes, les ailes irisées commencent à se dissoudre, et le papillon sombre dans un sommeil éternel sur ton épaule.\nLe message qu'il portait t'est à jamais perdu."
  },
  Event_125717_Name = {
    Text = "Le Crépuscule du Papillon"
  },
  Event_125718_ChoiceDesc1 = {
    Text = "[Mordre] Éveille aléatoirement 1 Corps éveillé, contamine [(Skill.Arg1)]"
  },
  Event_125718_ChoiceDesc2 = {
    Text = "[Refuse] Gagnez 1 parmi 3 Oraisons"
  },
  Event_125718_Desc = {
    Text = "« Vous avez faim, mon cher invité ? »\nUne voix visqueuse s'élève de derrière le bar. Tu te retournes, mais ne vois rien.\n« Les amuse-bouches du Bal de Minuit sont également fort réputés. Vous en tenterez bien une bouchée ? »"
  },
  Event_125718_Name = {
    Text = "Le Goût du Destin"
  },
  Event_125719_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125719_Desc = {
    Text = "Tu n'oses pas lire les mots qui y figurent et examines attentivement la belle enveloppe.\nLe cachet de cire apposé sur l'enveloppe porte une Oraison d'armoiries floue, et on peut y lire en belle écriture cursive :\n« À Mademoiselle Arachne, Nouveau-né. »\n« Votre loyal majordome, Edgar. »"
  },
  Event_125719_Name = {
    Text = "Bonne nuit, Monsieur Edgar"
  },
  Event_125720_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125720_Desc = {
    Text = "« Je vois. Je comprends maintenant, grande sœur... »\n« Une auteure ne peut jamais réécrire la fin d'un personnage. Ce destin misérable était scellé depuis longtemps ; même vous n'auriez pu le changer... »\nLes sanglots douloureux s'estompent. La machine à écrire de l'auteure se dissout en papillons, se dispersant dans le Théâtre du destin vacant jusqu'à ne laisser aucune trace."
  },
  Event_125720_Name = {
    Text = "La fin de la pièce"
  },
  Event_125721_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125721_Desc = {
    Text = "Acteurs inconnus, pas périlleux... qu'importe ? Rien ne peut être pire que le destin lui-même.\nTu tends la main et montes sur scène. Les marionnettes te prennent la main et t'entraînent dans une danse joyeuse.\nTu entends les applaudissements."
  },
  Event_125721_Name = {
    Text = "Pas de Trois"
  },
  Event_125722_ChoiceDesc1 = {
    Text = "[Serrer le corbeau]Obtenez 25 le sigil noir, contagion「(Skill.Arg2)」，continuez à choisir"
  },
  Event_125722_ChoiceDesc2 = {
    Text = "[Ignorez-le] Partez"
  },
  Event_125722_Desc = {
    Text = "«Elles dansent. Elles chantent. Craquement — craquement —»"
  },
  Event_125722_Name = {
    Text = "La Prophétie Finale"
  },
  Event_125723_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125723_Desc = {
    Text = "Le guide, le camarade — le seul compagnon dans cette dimension solitaire.\nTu résoudras tout ici ensemble et retourneras à Kadath. Tu n'en as jamais douté."
  },
  Event_125723_Name = {
    Text = "Reflet dans le Miroir"
  },
  Event_125724_ChoiceDesc1 = {
    Text = "[Tenter sa chance] Infecter [(Skill.Arg1)], entrer dans le jeu de hasard"
  },
  Event_125724_ChoiceDesc2 = {
    Text = "[Oublie Ça] Gagne 25 sigils noirs"
  },
  Event_125724_Desc = {
    Text = "Au coin d'une ruelle, une paire de mains sales te barre le chemin.\nUn mendiant en haillons s'approche, ses yeux aussi avides qu'une hyène flairant une charogne.\n« Allez ! Une partie ! Je te dirai tout ce que tu veux savoir... si seulement tu gagnes... »"
  },
  Event_125724_Name = {
    Text = "Pari de rue"
  },
  Event_125725_ChoiceDesc1 = {
    Text = "[Ignore] Détruire une carte d'instruction, obtenez 25 marques noires"
  },
  Event_125725_ChoiceDesc2 = {
    Text = "[Read] Copier 1 carte du deck, contamine le symptôme [(Skill.Arg1)]"
  },
  Event_125725_Desc = {
    Text = "Tap, tap, tap... Tap, tap, tap...\nLe coin du bar est désert ; le télécopieur sonne avec une cadence nette et rythmée, comme une gracieuse sonate pour piano."
  },
  Event_125725_Name = {
    Text = "Télégramme dimensionnel"
  },
  Event_125726_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125726_Desc = {
    Text = "«Silence. Je suis un chat. Tes histoires fastidieuses ne m'intéressent pas.»\n\nLe chat soupire et se détourne.\n\n«Pars. Et ne fais plus jamais quelque chose d'aussi stupide.»"
  },
  Event_125726_Name = {
    Text = "Métamorphose"
  },
  Event_125727_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125727_Desc = {
    Text = "Peut-être a-t-elle raison. C'est vous — les pensées les plus obscures et les plus viles au fond de votre âme.\nChaque homme est égoïste ; vous n'avez jamais été aussi noble que les autres le croyaient.\nVous savourez cette douleur misérable. Vous savez que le passé est révolu, et que votre salut se trouve devant vous."
  },
  Event_125727_Name = {
    Text = "Propagation de la douleur"
  },
  Event_125728_ChoiceDesc1 = {
    Text = "[Discuter avec elle] Détruire une carte d'instruction, et obtenir Arg1 marques noires"
  },
  Event_125728_ChoiceDesc2 = {
    Text = "[Garder le silence]"
  },
  Event_125728_Desc = {
    Text = "« Une fin tragique est sincère, pourtant notre réalité est déjà si misérable. Ne pouvons-nous pas lui accorder un destin plus doux, même dans une histoire... ? »\nL'auteure ferme les yeux, plongée dans ses réflexions. Elle est insatisfaite de cette conclusion."
  },
  Event_125728_Name = {
    Text = "La fin de la pièce"
  },
  Event_125729_ChoiceDesc1 = {
    Text = "[Partir] Obtient une relique en or[(RelicConfig.Arg1)]"
  },
  Event_125729_Desc = {
    Text = "Ratatat. Les dés dansent frénétiquement dans le gobelet, tournoyant jusqu'à l'épuisement.\n\n« Pourquoi... pourquoi personne ne gagne jamais ?! »"
  },
  Event_125729_Name = {
    Text = "Pari de rue"
  },
  Event_125730_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125730_Desc = {
    Text = [[
Tu te penches, tendant l'oreille pour saisir son murmure.
Le papillon bat des ailes et quitte ta paume.
Tu n'entends absolument rien.]]
  },
  Event_125730_Name = {
    Text = "Sieste de papillon"
  },
  Event_125731_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125731_Desc = {
    Text = "Face à tes gestes de rejet, le papillon reste impassible. \nIl poursuit obstinément ta paume avec une douce persistance — et ce n'est que lorsque tu lèves le bras une dernière fois qu'il choisit de partir.\nUn frisson de regret s'éveille. Peut-être... aurais-tu dû l'écouter ?"
  },
  Event_125731_Name = {
    Text = "Sieste de papillon"
  },
  Event_125732_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125732_Desc = {
    Text = "La brume noire frémit de désolation ; les gémissements d'agonie du mendiant sont déchirants.\nEn un seul clignement d'œil, les dés et le mendiant disparaissent. Dans le chapeau en lambeaux, la récompense de la partie demeure."
  },
  Event_125732_Name = {
    Text = "Pari de rue"
  },
  Event_125733_ChoiceDesc1 = {
    Text = "[Rejoindre la fête]Obtenir la Créature maudite «(RelicConfig.Arg2)», mais développer «(Skill.Arg1)»"
  },
  Event_125733_ChoiceDesc2 = {
    Text = "[Arrêter la musique] Détruire une Relique, obtenir une récompense"
  },
  Event_125733_ChoiceDesc3 = {
    Text = "[Se boucher les oreilles] Recevoir 50 Marques Noires"
  },
  Event_125733_Desc = {
    Text = "«Ah ! La musique ! Comment une grande représentation pourrait-elle exister sans musique !!»\nUne symphonie discordante s'élève dans le théâtre brisé, comme une fête du chaos. Les acteurs des Abysses en spirale dansent et se réjouissent dans cette ode désordonnée, se délectant des notes qui les sustentent."
  },
  Event_125733_Name = {
    Text = "Ode au Destin"
  },
  Event_125734_ChoiceDesc1 = {
    Text = "[Gagner 100 sigils noirs]"
  },
  Event_125734_ChoiceDesc2 = {
    Text = "[2 Cartes d'instruction aléatoires obtiennent l'Oraison : «(EnchantConfig.Arg1)»]"
  },
  Event_125734_Desc = {
    Text = "Des fils invisibles du destin dansent au milieu des notes. Dans ce bruit chaotique, tu commences à tracer le fil de la mélodie envoûtante — c'est bien là le véritable son du destin.\nLes délaissés des Abysses en spirale t'acclament, se pressent autour de toi, t'entraînant dans leur fête désordonnée.\nFélicitations, spectateur chanceux ! Désormais, tu rejoindras les acteurs pour le salut final du destin."
  },
  Event_125734_Name = {
    Text = "Ode au Destin"
  },
  Event_125735_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125735_Desc = {
    Text = "Tu ne peux discerner le sens de ce son, mais tu sais qu'il doit cesser.\nLa lumière argentée tranche comme une lame déchaînée. Son rythme, d'une façon ou d'une autre, tombe parfaitement en cadence avec les notes.\nAvant que tu t'en rendes compte, la musique s'est tue. Tu n'entends plus rien. Tu ne vois que la nuit ; tu n'entends que le silence.\nCacophonie désordonnée ou silence absolu — lequel est le plus terrifiant... Gardien ?"
  },
  Event_125735_Name = {
    Text = "Ode au Destin"
  },
  Event_125736_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125736_Desc = {
    Text = "Vous tendez la main ; un papillon se pose doucement sur votre paume.\nEn effet. La mort, la dissolution, le passage du temps... Le papillon naît du cocon ; l'agonie est le terreau éternel de l'art.\nEn tant qu'excellent spectateur, c'est une vérité que vous devez apprendre à comprendre."
  },
  Event_125736_Name = {
    Text = "Fleurir dans la dissipation"
  },
  Event_125737_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125737_Desc = {
    Text = "C'est peut-être encore un tour de Nefraea.\nLe papillon comprend tes paroles, et un soupir silencieux résonne dans les ténèbres. Ses ailes ruisselantes de liquide noir et visqueux frémissent, puis bien vite, la silhouette alourdie du papillon se noie dans l'obscurité sans fin.\nTu ne pourras plus jamais savoir ce qu'il voulait te dire."
  },
  Event_125737_Name = {
    Text = "Le Crépuscule du Papillon"
  },
  Event_125738_ChoiceDesc1 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_125738_Desc = {
    Text = "Ratatat. Les dés dansent frénétiquement dans le gobelet, tournoyant jusqu'à l'épuisement.\n\n« Pourquoi... pourquoi personne ne gagne jamais ?! »"
  },
  Event_125738_Name = {
    Text = "Pari de rue"
  },
  Event_125739_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125739_Desc = {
    Text = "Laisser vos pensées dériver sans contrôle maintenant est dangereux. Vous secouez la tête et remontez à la surface immédiatement."
  },
  Event_125739_Name = {
    Text = "Sérénité"
  },
  Event_125740_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125740_Desc = {
    Text = "Toutes les notes ne requièrent pas un auditeur ; tout destin ne requiert pas une réponse.\nTu plaques fermement tes mains sur tes oreilles et quittes la scène bruyante.\nTu restes curieux quant au sens de cette musique discordante, pourtant tu sais que tu as fait le seul choix juste."
  },
  Event_125740_Name = {
    Text = "Ode au Destin"
  },
  Event_125741_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125741_Desc = {
    Text = "La lumière argentée perce l'illusion ; les chats noirs se dissolvent en flaques de boue noire.\nPrendre une forme féline pour se cacher... le monstre ne peut échapper à ton regard."
  },
  Event_125741_Name = {
    Text = "Métamorphose"
  },
  Event_125742_ChoiceDesc1 = {
    Text = "[Accepter le Destin]Graver l'Orison「(EnchantConfig.Arg1)」sur 1 Carte d'instruction parmi 3. (Utilisations : 0/2)"
  },
  Event_125742_Desc = {
    Text = "« Personne ne peut véritablement défier le destin, ma chère. Nous n'avons jamais possédé le droit de choisir. »\nLa voix devient mélancolique et lointaine. Vous ne savez pas si elle vous parle, ou à tout autre chose."
  },
  Event_125742_Name = {
    Text = "La Cage du Destin"
  },
  Event_125743_ChoiceDesc1 = {
    Text = "[Maintenir le Corbeau]Obtenir 30 le sigil noir, infecter \"(Skill.Arg2)\", continuer la sélection"
  },
  Event_125743_ChoiceDesc2 = {
    Text = "[Ignorez-le] Partez"
  },
  Event_125743_Desc = {
    Text = "«Les marionnettes font la queue pour leur entrée, pénétrant dans la grande toile du destin.»"
  },
  Event_125743_Name = {
    Text = "La Prophétie Finale"
  },
  Event_125744_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125744_Desc = {
    Text = "Vous levez les yeux vers le vortex de l'abîsse, tendant l'oreille pour entendre l'oracle des corbeaux.\nMais ils ne disent rien. Sous votre regard, l'abîsse se dissout.\nLa nuée disparaît vers le bout de la scène — l'endroit où vous devez aller."
  },
  Event_125744_Name = {
    Text = "Abysses des corbeaux"
  },
  Event_125745_ChoiceDesc1 = {
    Text = "[Agree] Supprimer 2 Cartes"
  },
  Event_125745_ChoiceDesc2 = {
    Text = "[Disagree] Obtenez la Créature maudite « (RelicConfig.Arg1) », mais développez « (Skill.Arg2) »"
  },
  Event_125745_ChoiceDesc3 = {
    Text = "[Leave] Gagner Arg1 sigles noirs"
  },
  Event_125745_Desc = {
    Text = "Le rideau de scène vacille dans le vent. Parmi la boue noire qui s'écoule d'un cadavre tombé, vous apercevez un groupe de papillons.\n« Le véritable art s'épanouit toujours dans la dissolution... n'êtes-vous pas d'accord, Gardien ? »\nLe cadavre de la danseuse vous sourit. Vous entendez le battement des ailes."
  },
  Event_125745_Name = {
    Text = "Fleurir dans la dissipation"
  },
  Event_125746_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125746_Desc = {
    Text = "Les sophismes ne peuvent jamais vous ébranler. Vous savez clairement le chemin que vous empruntez et la destination que vous cherchez.\nLes épines se dissolvent en vous. Vous vous engagez sur la route, comme vous l'avez toujours fait."
  },
  Event_125746_Name = {
    Text = "Propagation de la douleur"
  },
  Event_125747_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125747_Desc = {
    Text = "Tu te détournes, tentant d'oublier les regards dans ton dos. Mais tu constates que ton corps ne se meut plus aussi librement qu'autrefois.\nTu le sais — de ces regards insistants, tu ne pourras jamais t'échapper."
  },
  Event_125747_Name = {Text = "Le public"},
  Event_125748_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125748_Desc = {
    Text = "Que ce soit par respect ou par crainte, tu n'oses pas y toucher à la légère et remets l'enveloppe à sa place. Au moment où tu t'apprêtes à partir, une Voix douce mais trouble s'élève de l'obscurité derrière l'enveloppe.\n« Merci de vous souvenir encore de moi, Mademoiselle Arachne... »"
  },
  Event_125748_Name = {
    Text = "Bonne nuit, Monsieur Edgar"
  },
  Event_125749_ChoiceDesc1 = {
    Text = "[Le pouvoir de protéger] Obtenir la Création en argent [(RelicConfig.Arg1)]"
  },
  Event_125749_ChoiceDesc2 = {
    Text = "[La liberté de fuir] Graver l'Orison [(EnchantConfig.Arg1)] sur 1 Carte d'instruction aléatoire"
  },
  Event_125749_ChoiceDesc3 = {
    Text = "[Refuser de répondre] Recevoir 50 Marques Noires"
  },
  Event_125749_Desc = {
    Text = "La liqueur du Masque de minuit s'insinue dans votre esprit comme des chaînes qui s'enroulent étroitement. Le long des maillons de fer glacé, la voix d'une jeune femme hante votre conscience.\n«Dis-moi, mon cher. Quel destin désires-tu vraiment ?»"
  },
  Event_125749_Name = {
    Text = "Les chaînes du Destin"
  },
  Event_125750_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125750_Desc = {
    Text = "Même les affaires les plus compliquées doivent être résolues de votre main.\nLe poids s'alourdit, mais avec lui s'élève une force nouvelle et inconnue."
  },
  Event_125750_Name = {
    Text = "Sérénité"
  },
  Event_125751_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125751_Desc = {
    Text = "Acteurs inconnus, pas périlleux. En effet, la fuite est le seul refuge sûr.\nTu te retournes et cours, déchirant les rideaux du théâtre — pour te retrouver debout sur la scène. Les marionnettes te prennent la main et t'entraînent dans une danse joyeuse.\nSur la scène du destin, il n'y a jamais de choix."
  },
  Event_125751_Name = {
    Text = "Pas de Trois"
  },
  Event_125752_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125752_Desc = {
    Text = "Ce n'est pas le moment de regarder un film."
  },
  Event_125752_Name = {
    Text = "Cinéma des souvenirs"
  },
  Event_125753_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125753_Desc = {
    Text = "Les dangers du chemin n'effleurent pas ton esprit. Tu traverses le destin qui s'effondre à tes côtés et continues à te rapprocher de Nefraea.\nTu es venu ici pour lui apporter la délivrance."
  },
  Event_125753_Name = {
    Text = "Chute du rideau sur la Toile du destin"
  },
  Event_125754_ChoiceDesc1 = {
    Text = "[Lire l'enveloppe]Obtenir une Création en or «(RelicConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_125754_ChoiceDesc2 = {
    Text = "[Lire la lettre] Graver l'Orison [(EnchantConfig.Arg1)] sur 1 Carte d'instruction parmi 3"
  },
  Event_125754_ChoiceDesc3 = {
    Text = "[Lâcher]Obtient 50 marques noires"
  },
  Event_125754_Desc = {
    Text = "Tes mouvements déchirent les épaisses toiles d'araignée ; une vieille lettre tombe de la soie.\nSon poids dépasse de loin ce qu'un mince papier devrait porter."
  },
  Event_125754_Name = {
    Text = "Bonne nuit, Monsieur Edgar"
  },
  Event_125755_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125755_Desc = {
    Text = "Des larmes coulent des yeux du corbeau. Du sang s'écoule de son bec. Avec ses dernières forces, le corbeau chante sa prophétie finale pour vous."
  },
  Event_125755_Name = {
    Text = "La Prophétie Finale"
  },
  Event_125756_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125756_Desc = {
    Text = "« Hehe... Hahahaha ! »\n« Alors, mon invité ? Le goût du destin... vous ne pourrez plus vous en passer, follement, sans fin... »"
  },
  Event_125756_Name = {
    Text = "Le Goût du Destin"
  },
  Event_125757_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125757_Desc = {
    Text = "«Ennuyeux.» Elle laisse échapper un bâillement languissant.\n«Prends ton pouvoir et va te bagarrer au club.»"
  },
  Event_125757_Name = {
    Text = "Les chaînes du Destin"
  },
  Event_125758_ChoiceDesc1 = {
    Text = "[Stabiliser la Toile du destin] Obtenir 1 Gravure avancée parmi 3 au choix"
  },
  Event_125758_ChoiceDesc2 = {
    Text = "[Ignorer le danger] Obtiens la relique en or «(RelicConfig.Arg1)», mais développe «(Skill.Arg2)»"
  },
  Event_125758_ChoiceDesc3 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_125758_Desc = {
    Text = "Elle est la favorite des grâces. Elle est l'enfant abandonné du destin. Elle est la vengeresse qui a rampé hors de l'abîme en suivant une lueur ténue. Elle est venue ici pour apporter la délivrance à tout.\nLa Toile du destin s'effondre et s'écroule autour de vous. Tu te tiens sur la scène du théâtre, séparé de Nefraea par une distance qui n'est pas si grande."
  },
  Event_125758_Name = {
    Text = "Chute du rideau sur la Toile du destin"
  },
  Event_125759_ChoiceDesc1 = {
    Text = "[Indifferent] Obtiens la création en argent [(RelicConfig.Arg1)]"
  },
  Event_125759_ChoiceDesc2 = {
    Text = "[Empathetic] Obtiens la création en or «(RelicConfig.Arg1)», mais développe «(Skill.Arg2)»"
  },
  Event_125759_Desc = {
    Text = "Des cris perçants éclatent sur la scène tandis que le seul projecteur se pose sur une silhouette solitaire.\nIl t'offre sa performance la plus sincère — mettant sa poitrine à nu pour présenter ses viscères à chaque spectateur.\nQu'est-ce qui tourmente donc ce personnage à ce point ?"
  },
  Event_125759_Name = {
    Text = "La confession d'un acteur"
  },
  Event_125760_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125760_Desc = {
    Text = "Tu tends la main vers la droite.\nLà se trouve ton avenir — ton désir le plus intense, ton sanctuaire ultime, et la destination que tu finiras par atteindre.\nTon existence ne sert qu'à poursuivre le soleil devant toi."
  },
  Event_125760_Name = {
    Text = "Passé, avenir"
  },
  Event_125761_ChoiceDesc1 = {
    Text = "[Trois Points]"
  },
  Event_125761_ChoiceDesc2 = {
    Text = "[Six Points]"
  },
  Event_125761_ChoiceDesc3 = {Text = "[Un point]"},
  Event_125761_Desc = {
    Text = "Tu pourrais simplement partir, pourtant les dés exquis te captivent entièrement.\nOubliant les poursuivants dans ton dos, tu les prends avec révérence et les lances dans le chapeau haut-de-forme —"
  },
  Event_125761_Name = {
    Text = "Pari de rue"
  },
  Event_125762_ChoiceDesc1 = {
    Text = "[Partir] Obtient une relique d'argent[(RelicConfig.Arg1)]"
  },
  Event_125762_Desc = {
    Text = "Ratatat. Les dés dansent frénétiquement dans le gobelet, tournoyant jusqu'à l'épuisement.\n\n« Pourquoi... pourquoi personne ne gagne jamais ?! »"
  },
  Event_125762_Name = {
    Text = "Pari de rue"
  },
  Event_125763_ChoiceDesc1 = {
    Text = "[Accepter le Destin]Graver l'Orison「(EnchantConfig.Arg1)」sur 1 Carte d'instruction parmi 3. (Utilisations : 0/2)"
  },
  Event_125763_ChoiceDesc2 = {
    Text = "[Défier le Destin]Développer le symptôme「(Skill.Arg1)」et changer l'Orison en gravure. (Utilisations : 1/2)"
  },
  Event_125763_Desc = {
    Text = "«Ah, petite coquine. Le Destin est toujours clément... mais toute résistance a un prix. Maintenant, es-tu prête à l'accepter ?»"
  },
  Event_125763_Name = {
    Text = "La Cage du Destin"
  },
  Event_125764_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125764_Desc = {
    Text = "Tu parcours ces regards du regard et lèves la main en guise de salut.\nBientôt, tu leur offriras le crescendo de l'histoire."
  },
  Event_125764_Name = {Text = "Le public"},
  Event_125765_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125765_Desc = {
    Text = "«Chère Mademoiselle Arachne, aujourd'hui est le jour de votre naissance. Je me réjouis pour le Maître, Madame, et pour vous. Bienvenue dans ce beau monde. Je vous offre cette douce berceuse, vous souhaitant une vie sans souci à partir de ce jour...»"
  },
  Event_125765_Name = {
    Text = "Bonne nuit, Monsieur Edgar"
  },
  Event_125766_ChoiceDesc1 = {
    Text = "[Prendre une photo] Gravure de l'Oraison [(EnchantConfig.Arg1)] sur 1 Carte d'instruction parmi 3.(Utilisations : 0/2)"
  },
  Event_125766_ChoiceDesc2 = {
    Text = "[Changer encore] Développez le Symptôme [(Skill.Arg1)] et changez l'Oraison à graver.(Utilisations : 1/2)"
  },
  Event_125766_Desc = {
    Text = "Tu ressens un frisson d'appréhension devant l'objectif. Peut-être cette pose serait-elle meilleure ? Ou celle-là ?"
  },
  Event_125766_Name = {
    Text = "Cœur d'image du public"
  },
  Event_125767_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125767_Desc = {
    Text = "Vous souhaitez voir le contenu, mais l'écran est vide. Seul le son d'un film en rotation résonne dans la salle.\nPeut-être faudra-t-il longtemps avant que vous ne découvriez ce que renferment les bobines."
  },
  Event_125767_Name = {
    Text = "Cinéma des souvenirs"
  },
  Event_125768_ChoiceDesc1 = {
    Text = "[Avoid Gaze] Rassembler aléatoirement 1 Réveil"
  },
  Event_125768_ChoiceDesc2 = {
    Text = "[Regard Fixe] Choisissez de réveiller un réveilleur et réduisez son coût en arithmetica de l'oraison de 2 points. Infectez [(Skill.Arg1)]"
  },
  Event_125768_ChoiceDesc3 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_125768_Desc = {
    Text = "Alors que tu montes sur scène, tu entends une volée de murmures. Tu te retournes ; dix mille paires d'yeux flottent autour de la scène, te regardant fixement.\n« Viens ! » disent-ils. « Ce drame exquis ne s'arrête sûrement pas ici ? »\n« Danse ! » disent-ils. « Offre-nous l'apogée de cette Danse ! »"
  },
  Event_125768_Name = {Text = "Le public"},
  Event_125769_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125769_Desc = {
    Text = "Tu ne comprends pas sa douleur, et tu n'en as pas besoin.\nLe théâtre compte de nombreuses scènes, et les scènes de nombreuses marionnettes ; tu n'es que l'une d'elles.\nTu as des choses plus importantes à faire."
  },
  Event_125769_Name = {
    Text = "La confession d'un acteur"
  },
  Event_125770_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125770_Desc = {
    Text = "La mort, la dissolution, le passage du temps... L'art n'existe pas pour infliger de la douleur. Si la beauté ne réside que dans la souffrance, alors une telle beauté vaut mieux ne jamais naître.\nVous frappez pour les disperser. Les papillons s'éparpillent, laissant derrière eux un cadavre mélancolique."
  },
  Event_125770_Name = {
    Text = "Fleurir dans la dissipation"
  },
  Event_125771_ChoiceDesc1 = {
    Text = "[Maintenir le Corbeau]Obtenir 40 le sigil noir, infecter \"(Skill.Arg2)\", continuer la sélection"
  },
  Event_125771_ChoiceDesc2 = {
    Text = "[Ignorez-le] Gagnez 25 Sigils Noirs et partez."
  },
  Event_125771_Desc = {
    Text = "Les corbeaux éparpillés que vous avez croisés convergent en un seul. Il se perche devant vous et chante, sa mélodie désolée — comme la prophétie finale."
  },
  Event_125771_Name = {
    Text = "La Prophétie Finale"
  },
  Event_125772_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125772_Desc = {
    Text = "Tu tends la main vers la gauche.\nLà se trouve ton passé — tes souvenirs les plus précieux, le chemin que tu as autrefois parcouru, et l'endroit auquel tu finiras par retourner.\nTout ce qui a été forme tout ce que tu es."
  },
  Event_125772_Name = {
    Text = "Passé, avenir"
  },
  Event_125773_ChoiceDesc1 = {
    Text = "[Prendre une photo] Gravure de l'Oraison [(EnchantConfig.Arg1)] sur 1 Carte d'instruction parmi 3.(Utilisations : 0/2)"
  },
  Event_125773_Desc = {
    Text = "Vous ressentez un frisson d'appréhension face à l'objectif. Cette pose serait-elle meilleure ? Ou celle-là ?\nVous hésitez encore, mais vous sentez l'agacement croissant de la caméra."
  },
  Event_125773_Name = {
    Text = "Cœur d'image du public"
  },
  Event_125774_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125774_Desc = {
    Text = "Vous prenez la pose devant la caméra — composé, curieux, immergé. Tel un véritable spectateur.\nGlouglou—\nL'obturateur clique. Une boue noire jaillit du corps de la caméra, éclaboussant toute la scène.\nDans le creux central du corps de la caméra, la pellicule reste vierge."
  },
  Event_125774_Name = {
    Text = "Cœur d'image du public"
  },
  Event_125775_ChoiceDesc1 = {
    Text = "[Accept] Obtiens 1 création en argent parmi 3"
  },
  Event_125775_ChoiceDesc2 = {
    Text = "[Flee] Obtenez les créations en argent «(RelicConfig.Arg1)» & «(RelicConfig.Arg2)», mais développez deux fois «(Skill.Arg3)»"
  },
  Event_125775_Desc = {
    Text = "Tap-tap, tap-tap... Les talons frappent les planches avec un claquement vif et joyeux.\nDeux marionnettes en uniforme scolaire dansent sur la scène. Soudain, elles s'arrêtent — et se retournent pour te tendre la main."
  },
  Event_125775_Name = {
    Text = "Pas de Trois"
  },
  Event_125776_ChoiceDesc1 = {
    Text = "[Patience face à la Douleur] Augmentez les PV Max de Arg1"
  },
  Event_125776_ChoiceDesc2 = {
    Text = "[Réfuter la douleur] 1 Carte d'instruction aléatoire obtient l'Oraison : «(EnchantConfig.Arg1)», infecter 1 «(Skill.Arg2)»"
  },
  Event_125776_Desc = {
    Text = "« Vous n'avez jamais eu de peine pour la mort de Liz. Vous n'avez jamais eu de peine pour personne. »\n« Vous ne vous souciez que de vous-même... tous ceux qui vous entourent ne sont que des outils pour votre voyage vers la liberté et la paix. »\n« N'est-ce pas ainsi... Gardien ? »\nLe murmure de l'Annonceur grince contre votre oreille. Votre cœur se contracte ; une douleur aiguë se répand dans tout votre être avec ses mots..."
  },
  Event_125776_Name = {
    Text = "Propagation de la douleur"
  },
  Event_125777_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125777_Desc = {
    Text = "Abandonnez-vous à la descente ; la mer possède sa propre flottabilité, et le destin révélera le chemin pour vous deux."
  },
  Event_125777_Name = {
    Text = "Sérénité"
  },
  Event_125778_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125778_Desc = {
    Text = "C'est toi-même. La source du pouvoir, le porteur du devoir, le seul objet de loyauté.\nTu parcours le chemin qui t'appartient à toi seul."
  },
  Event_125778_Name = {
    Text = "Reflet dans le Miroir"
  },
  Event_125779_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125779_Desc = {
    Text = "«Quel dommage, mon invité. Le goût du destin... vous n'aurez plus jamais l'occasion de le savourer...»"
  },
  Event_125779_Name = {
    Text = "Le Goût du Destin"
  },
  Event_125780_ChoiceDesc1 = {
    Text = "[Discuter avec elle] Détruire une carte d'instruction, et obtenir Arg1 marques noires"
  },
  Event_125780_ChoiceDesc2 = {
    Text = "[Garder le silence]"
  },
  Event_125780_Desc = {
    Text = "« Quelle pièce mélancolique... Cette pauvre fille a-t-elle été abandonnée par celui qu'elle chérissait, grande sœur ? »\nDans cette voix familière, vous ne percevez aucune trace de folie ni de malice. Elle est claire et plaintive, comme un doux ruisseau à travers une forêt.\n« La chanteuse, une feuille desséchée dérivant sans recours, livrée aux ravages du destin... Quelle âme pitoyable... »\n« Grande sœur, si j'étais l'auteure... quelle fin devrais-je lui écrire ? »"
  },
  Event_125780_Name = {
    Text = "La fin de la pièce"
  },
  Event_125781_ChoiceDesc1 = {
    Text = "[Les caresser] 50 % de chances d'obtenir 125 Marques noires, 50 % de chances de développer [(Skill.Arg2)]"
  },
  Event_125781_ChoiceDesc2 = {
    Text = "[Explain] 75 % de chances d'obtenir 100 Marques noires, 25 % de chances de développer [(Skill.Arg2)]"
  },
  Event_125781_ChoiceDesc3 = {
    Text = "[Voir clair] Obtenez 50 Marques noires"
  },
  Event_125781_Desc = {
    Text = "Alors que tu poursuis le monstre dans la ruelle derrière le bar, sa silhouette disparaît. Un groupe de chats noirs te barre le chemin.\n« Hé, toi. » Un chat noir lèche sa patte en te regardant.\n« Que fais-tu sur notre territoire ? »"
  },
  Event_125781_Name = {
    Text = "Métamorphose"
  },
  Event_125782_ChoiceDesc1 = {
    Text = "[Embrasser le passé] Obtenez une création en or «(RelicConfig.Arg1)», mais développez «(Skill.Arg2)»"
  },
  Event_125782_ChoiceDesc2 = {
    Text = "[Accueillir l'avenir] Obtenez 3 choix 1 création en or, mais développez le symptôme [(Skill.Arg1)]"
  },
  Event_125782_ChoiceDesc3 = {
    Text = "[Partir] Obtient une relique d'argent[(RelicConfig.Arg1)]"
  },
  Event_125782_Desc = {
    Text = "L'apparition de Nefraea perturbe les fils. Dans le destin en désordre, tu aperçois deux Illusions floues.\nC'est ton passé, c'est ton avenir. Tu t'avances vers elles et tends la main..."
  },
  Event_125782_Name = {
    Text = "Passé, avenir"
  },
  Event_125855_ChoiceDesc1 = {
    Text = "[Perceive] Améliorez 1 relique en une création en or [(RelicConfig.Arg1)]"
  },
  Event_125855_ChoiceDesc2 = {
    Text = "[Stare] Obtenez la Relique Argent \"(RelicConfig.Arg1)\" et devenez infecté par \"(Skill.Arg2)\"."
  },
  Event_125855_ChoiceDesc3 = {
    Text = "[Ignorer] Gagne 25 Marque noire"
  },
  Event_125855_Desc = {
    Text = "Dans les rues de Kasalim, l'éclat brillant d'une boutique de cristaux t'attire. Tu te tiens devant la vitrine et ramasses un cristal en forme de Cœur d'argent."
  },
  Event_125855_Name = {
    Text = "Le secret du cristal"
  },
  Event_125856_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125856_Desc = {
    Text = "Tu fermes les yeux et le perçois avec soin.\nUne lueur de lumière vacille dans ta conscience, comme si elle cherchait à te dire quelque chose..."
  },
  Event_125856_Name = {
    Text = "Le secret du cristal"
  },
  Event_125857_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125857_Desc = {
    Text = "Toute résistance ou tentative de percer le destin est vaine. Tu fermes calmement les yeux, laissant le destin t'emmener là où tu dois aller."
  },
  Event_125857_Name = {
    Text = "Toile de liant du destin"
  },
  Event_125858_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125858_Desc = {
    Text = "«L'émotion est le sens de l'existence. Puisses-tu ne jamais regretter ton choix.»"
  },
  Event_125858_Name = {
    Text = "Le prix du choix"
  },
  Event_125859_ChoiceDesc1 = {
    Text = "[Emotion] Récupérez Arg1 PV"
  },
  Event_125859_ChoiceDesc2 = {
    Text = "[Reason] Gravure de l'Oraison [(EnchantConfig.Arg1)] sur 1 Carte d'instruction aléatoire"
  },
  Event_125859_ChoiceDesc3 = {
    Text = "[Refuser de choisir] Obtenez 25 sigils noirs"
  },
  Event_125859_Desc = {
    Text = "Une balance apparaît sur la scène.\n« Cerveau et cœur, raison et émotion, gris et rouge... nous ne pouvons échapper au choix ; c'est notre destin. »\n« La fin de la pièce est déjà tracée. Maintenant, choisis le chemin que cette représentation empruntera. »"
  },
  Event_125859_Name = {
    Text = "Le prix du choix"
  },
  Event_125860_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125860_Desc = {
    Text = "« Ne lève pas les yeux. Quitte cet endroit. »\nTu entends la voix du destin. Bien que tu désires contempler le ciel, tu sais qu'elle a raison."
  },
  Event_125860_Name = {
    Text = "Regard vers le ciel"
  },
  Event_125861_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125861_Desc = {
    Text = "Tu n'acceptes jamais le destin. Tu n'acceptes jamais l'emprisonnement.\nTu te débats de toutes tes forces. Après avoir sacrifié un membre du papillon de nuit, tu parviens enfin à t'échapper..."
  },
  Event_125861_Name = {
    Text = "Toile de liant du destin"
  },
  Event_125862_ChoiceDesc1 = {
    Text = "[Friendship] Obtenez 50 Marques noires"
  },
  Event_125862_ChoiceDesc2 = {
    Text = "[Help] Obtenez 75 Marques noires, mais développez le Symptôme [(Skill.Arg2)]"
  },
  Event_125862_Desc = {
    Text = "Dans la ruelle derrière le bar, tu rencontres à nouveau ces chats noirs.\n« J'ai entendu dire. Ces limaces noires ont pris notre apparence et t'ont causé bien des ennuis. »\n« En guise d'excuse, dis-moi — que désires-tu ? »\nLes chats noirs tournent deux fois autour de tes jambes et lèvent les yeux vers toi."
  },
  Event_125862_Name = {
    Text = "Don de la Première Rencontre"
  },
  Event_125863_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125863_Desc = {
    Text = "La force brute ne peut démêler le destin, mais peut-être la sagesse le peut-elle ?\nTu observes la toile de près, cherchant en elle quelque fil du dessein du destin..."
  },
  Event_125863_Name = {
    Text = "Toile de liant du destin"
  },
  Event_125864_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125864_Desc = {
    Text = "Tu te penches et le regardes attentivement.\nUne lueur de lumière vacille dans tes yeux, comme si elle cherchait à te dire quelque chose..."
  },
  Event_125864_Name = {
    Text = "Le secret du cristal"
  },
  Event_125865_ChoiceDesc1 = {
    Text = "[Struggle] Détruire 1 carte d'instruction parmi 3 aléatoires, et obtenir 75 marques noires"
  },
  Event_125865_ChoiceDesc2 = {
    Text = "[Rest] Dupliquer 1 carte d'instruction parmi 3, et obtenir 25 marques noires"
  },
  Event_125865_ChoiceDesc3 = {
    Text = "[Rest] Obtenir 50 marques noires"
  },
  Event_125865_Desc = {
    Text = "Une sensation familière t'assaille. Pourtant, cette fois, le contact visqueux et l'instinct d'impuissance sont plus intenses, plus mortels.\nLe papillon de nuit tombe dans la toile d'araignée. Et tu as déjà posé le pied sur la scène."
  },
  Event_125865_Name = {
    Text = "Toile de liant du destin"
  },
  Event_125866_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125866_Desc = {
    Text = "«La raison est le sens de l'existence. Puisses-tu ne jamais regretter ton choix.»"
  },
  Event_125866_Name = {
    Text = "Le prix du choix"
  },
  Event_125867_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125867_Desc = {
    Text = "La curiosité s'éveille. Tu te fondes dans la foule et lèves la tête comme eux.\nIl n'y a rien là-haut, pourtant, pour des raisons inconnues, tu répugnes à détourner le regard. Tu veux regarder ainsi — regarder pour toujours..."
  },
  Event_125867_Name = {
    Text = "Regard vers le ciel"
  },
  Event_125868_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125868_Desc = {
    Text = "«Refuser le choix est en soi un choix — c'est la malédiction du destin. Puisses-tu ne jamais regretter le choix que tu as fait.»"
  },
  Event_125868_Name = {
    Text = "Le prix du choix"
  },
  Event_125869_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125869_Desc = {
    Text = "« Maintenant, il est à toi. »\nLes chats frôlent ton tibia et disparaissent bientôt.\nLà où ils ont disparu, un cadeau t'attend."
  },
  Event_125869_Name = {
    Text = "Don de la Première Rencontre"
  },
  Event_125870_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125870_Desc = {
    Text = "« Maintenant, il est à toi. »\nLes chats frôlent ton tibia et disparaissent bientôt.\nLà où ils ont disparu, un cadeau t'attend."
  },
  Event_125870_Name = {
    Text = "Don de la Première Rencontre"
  },
  Event_125871_ChoiceDesc1 = {
    Text = "[Lever la tête] Choisissez 1 Carte d'instruction parmi 3 pour obtenir une Oraison : «(EnchantConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_125871_ChoiceDesc2 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_125871_Desc = {
    Text = "La cacophonie s'évanouit un bref instant. La foule dans la rue se tait, levant la tête vers le ciel."
  },
  Event_125871_Name = {
    Text = "Regard vers le ciel"
  },
  Event_129176_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129176_Name = {
    Text = "Chapitre 1 de l'Oubli@"
  },
  Event_129177_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129177_Name = {
    Text = "Chapitre 1 des Étoiles@"
  },
  Event_129178_ChoiceDesc1 = {
    Text = "[Indicate Direction] Obtenez Relique d'argent \"(RelicConfig.Arg1)\", et contractez \"(Skill.Arg2)\""
  },
  Event_129178_ChoiceDesc2 = {
    Text = "[Prier ensemble] Graver 1 Oraison parmi 3 deux fois"
  },
  Event_129178_Desc = {
    Text = "Le son du piano et de l'orgue se mêle dans le vent grisâtre. Une mélodie magique semble flotter dans les ruelles désertes. \n Une religieuse anonyme prie au son du piano. \n « Une prière simple n'a pas besoin de cérémonies solennelles, le grand Père Dieu sèmera l'espoir pour nous, tout comme il nous a donné des enseignements de dévouement. »"
  },
  Event_129178_Name = {
    Text = "Prière de l'orgue"
  },
  Event_129179_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129179_Name = {
    Text = "Chapitre 1 des Étoiles@"
  },
  Event_129180_ChoiceDesc1 = {
    Text = "[Face It] Obtenir la relique maudite \"(RelicConfig.Arg1)\" et devenir infecté par \"(Skill.Arg2)\"."
  },
  Event_129180_ChoiceDesc2 = {
    Text = "[Surrender] Choisissez 1 Carte parmi 3 Cartes d'instruction pour obtenir l'Oraison : [(EnchantConfig.Arg1)] deux fois"
  },
  Event_129180_ChoiceDesc3 = {
    Text = "[Run Away] Gagnez 50 sigils noirs"
  },
  Event_129180_Desc = {
    Text = "Quelques blocs de sculpture en cire bloquent votre chemin.\nIls sont tordus et rugueux en apparence, ne ressemblant pas à l'artisanat auquel on pourrait s'attendre de Rogers.\n\"Ordres... les ordres du maître...\""
  },
  Event_129180_Name = {Text = "Étude"},
  Event_129181_ChoiceDesc1 = {
    Text = "[Quit Thinking] Obtenez la relique maudite \"(RelicConfig.Arg1)\", infectez \"(Skill.Arg2)\""
  },
  Event_129181_ChoiceDesc2 = {
    Text = "[Suivre la Perspicacité] Graver l'Oraison : [(EnchantConfig.Arg1)] sur 1 Carte d'instruction aléatoire deux fois"
  },
  Event_129181_Desc = {
    Text = "L'attaque du port, un cargo mystérieux sans retour et de nouveaux \"amis\" à nageoires... Un piège bien préparé ou un autre voyage plein d'incidents ?\nLa réalité et la raison s'entremêlent, des idées et des inspirations jaillissent de l'esprit"
  },
  Event_129181_Name = {
    Text = "Inspiration soudaine"
  },
  Event_129182_ChoiceDesc1 = {
    Text = "[Join] Infecter «(Skill.Arg1)» deux fois, 1 Carte aléatoire obtient l'Oraison : «(EnchantConfig.Arg2)» deux fois"
  },
  Event_129182_ChoiceDesc2 = {
    Text = "[Dispel] Infecter «(Skill.Arg1)» deux fois, 1 Carte aléatoire obtient l'Oraison : «(EnchantConfig.Arg2)» deux fois"
  },
  Event_129182_ChoiceDesc3 = {
    Text = "[Disregard] Choisir 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : [(EnchantConfig.Arg1)] deux fois"
  },
  Event_129182_Desc = {
    Text = "Tu entends le son lointain et indistinct d'une corne en os. \n La horde de rats surgit du noir marécage, rongeant les corps sans nom allongés sur le lit de la rivière asséchée. \n Ils forment un cercle, avec le corps déjà vide au centre, et la circonférence est un nouveau royaume où l'oubli est la loi. \n Et toi, tu te tiens à l'entrée de ce royaume."
  },
  Event_129182_Name = {
    Text = "Royaume Exilé"
  },
  Event_129183_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129183_Name = {
    Text = "Oubli chapitre 5@"
  },
  Event_129184_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129184_Name = {
    Text = "Oubli Chapitre 8@"
  },
  Event_129185_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129185_Name = {
    Text = "Oubli Chapitre 1@"
  },
  Event_129186_ChoiceDesc1 = {
    Text = "[Sauver le portrait] Choisir 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)» deux fois, infecter «(Skill.Arg2)» deux fois"
  },
  Event_129186_ChoiceDesc2 = {
    Text = "[Accepter le vide] Choisir 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)» deux fois, infecte «(Skill.Arg2)» deux fois"
  },
  Event_129186_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_129186_Desc = {
    Text = "Tu te tiens devant le don de Pickman. \n C'est un portrait, peint avec du sang, des flammes noires brûlent silencieusement. \n À travers les orbites vides du personnage du tableau, tu vois — \n tes souvenirs tourbillonnent et brûlent, s'étirant, se distordant, scintillant, comme si une sorte de feu invisible léchait les couloirs de ton esprit. Dans un état d'égarement, tu entends une voix. \n « Il est temps de mettre dans la marmite, la cuisson est parfaite. » \n C'est exactement le paysage de mémoire que tu as peint, luttant et se déformant dans les flammes."
  },
  Event_129186_Name = {
    Text = "Portrait Brûlant"
  },
  Event_129187_ChoiceDesc1 = {
    Text = "[Quel prix êtes-vous prêt à payer ?] Améliorer la qualité de l'Oraison d'une carte aléatoire deux fois"
  },
  Event_129187_ChoiceDesc2 = {
    Text = "[Offrez-leur un Bloody Mary périmé] Choisissez 1 Carte parmi 3 Cartes d'instruction pour obtenir l'Oraison : «(EnchantConfig.Arg1)» deux fois, infecter «(Skill.Arg2)» deux fois"
  },
  Event_129187_Desc = {
    Text = "«Bienvenue, cher invité. N'hésitez pas à choisir, tout ceci est là en attendant votre arrivée.»\n«Euh, désolé de vous déranger, puis-je vous demander si vous êtes... la sœur jumelle de Daffodil ?»\n«Je suis Daffodil elle-même, puis-je vous demander, cher invité, quelle est la raison de votre visite aujourd'hui... ?»\n«Je suis désolé, désolé, vous êtes encore plus séduisante qu'avant, je ne vous ai même pas reconnue. Vous vous souvenez ? Il y a vingt ans, vous avez chassé un monstre de mon bar... Hier, le cauchemar revisité est réapparu, il a envahi le bar, accompagné de ses semblables, en groupe...»"
  },
  Event_129187_Name = {
    Text = "Fragment de souvenir : Rêve ancien"
  },
  Event_129188_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129188_Name = {
    Text = "Étoiles Chapitre 3@"
  },
  Event_129189_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129189_Name = {
    Text = "Oubli Chapitre 8@"
  },
  Event_129190_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129190_Name = {
    Text = "Oubli Chapitre 1@"
  },
  Event_129191_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129191_Name = {
    Text = "Oubli Chapitre 6@"
  },
  Event_129192_ChoiceDesc1 = {
    Text = "[Tenir Étreinte] Augmentez la santé maximale de Arg1"
  },
  Event_129192_ChoiceDesc2 = {
    Text = "[Affronter son cœur] 2 Cartes d'instruction aléatoires obtiennent l'Oraison : «(EnchantConfig.Arg1)» deux fois, mais développer 2 «(Skill.Arg2)» deux fois"
  },
  Event_129192_Desc = {
    Text = "Dans cette chasse massive, la poursuite de Goliath est comme une bête nocturne, cherchant à dévorer toute lueur d'espoir. Cependant, cette poursuite impitoyable ne t'a pas figé, mais a enflammé une étincelle au plus profond de toi, qui s'étend et brûle de plus en plus fort"
  },
  Event_129192_Name = {
    Text = "Chasser la lumière"
  },
  Event_129193_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129193_Name = {
    Text = "Oubli Chapitre 6@"
  },
  Event_129194_ChoiceDesc1 = {
    Text = "[Lire le Chemin des anciens] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infectée par «(Skill.Arg2)»"
  },
  Event_129194_ChoiceDesc2 = {
    Text = "[Write Your Own Path] Obtenez la relique en argent \"(RelicConfig.Arg1)\" et infligez \"(Skill.Arg2)\"."
  },
  Event_129194_ChoiceDesc3 = {
    Text = "[Stare into Darkness] Gagnez 25 sigils noirs"
  },
  Event_129194_Desc = {
    Text = "Si vous explorez seul dans le domaine, vous ne serez certainement pas aussi sûr de votre voie qu'à présent.\nLes empreintes dans le domaine se sont divisées en trois, chaque empreinte écrivant un avenir invisible"
  },
  Event_129194_Name = {Text = "Sortie"},
  Event_129195_ChoiceDesc1 = {
    Text = "[Signaler l'erreur] Choisissez 1 Carte parmi 3 Cartes d'instruction pour obtenir l'Oraison : «(EnchantConfig.Arg1)» deux fois, infecter «(Skill.Arg2)» deux fois"
  },
  Event_129195_ChoiceDesc2 = {
    Text = "[Listen to the Performance] Gagnez 15 Sigils noirs pour chaque Réveilleur avec un Aliemus de 50 ou plus."
  },
  Event_129195_ChoiceDesc3 = {
    Text = "[Leave] Obtenir 1 parmi 3 Oraisons"
  },
  Event_129195_Desc = {
    Text = "Un garçon fait de cire joue une étude pour piano.\nSon professeur – également en cire, l'instruit à côté.\n133, 355, 244...\nFaux, chaque note est fausse"
  },
  Event_129195_Name = {
    Text = "Cours de piano"
  },
  Event_129196_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129196_Name = {
    Text = "Oubli Chapitre 5@"
  },
  Event_129197_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129197_Name = {
    Text = "Chapitre 4 des Étoiles@"
  },
  Event_129198_ChoiceDesc1 = {
    Text = "[Écouter le Lamento] Choisir 1 Carte d'instruction parmi 3 pour graver l'Oraison : «(EnchantConfig.Arg1)» deux fois, mais développer «(Skill.Arg2)» deux fois"
  },
  Event_129198_ChoiceDesc2 = {
    Text = "[Hear Joy] Pour chaque Réveiller avec Aliemus 50 ou plus, gagnez 15 Le sigil noir."
  },
  Event_129198_ChoiceDesc3 = {
    Text = "[Leave] Choisir 1 Oraison parmi 3, deux fois"
  },
  Event_129198_Desc = {
    Text = "Des mélodies douces, lyriques, joyeuses, tristes... Les accords résonnent dans l'espace du domaine, difficile à distinguer leur origine.\nS'agit-il d'une sonate émanant du navire fantôme, ou d'une fantaisie nocturne emprisonnée dans le domaine ?"
  },
  Event_129198_Name = {
    Text = "Son Inconnu"
  },
  Event_129199_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129199_Name = {
    Text = "Chapitre 1 des Étoiles@"
  },
  Event_129200_ChoiceDesc1 = {
    Text = "[Ouvrir l'enveloppe] Gagnez une relique en or '(RelicConfig.Arg1)', infectez '(Skill.Arg2)'"
  },
  Event_129200_ChoiceDesc2 = {
    Text = "[Read] Choisir 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : [(EnchantConfig.Arg1)] deux fois"
  },
  Event_129200_ChoiceDesc3 = {
    Text = "[Lâcher]Obtient 50 marques noires"
  },
  Event_129200_Desc = {
    Text = "Dans un coin négligé, une lettre a été laissée.  \nDe nombreux mots sur la lettre sont devenus méconnaissables, mais un mot reste. Il transperce le papier.  \nCe mot est \"Mère\"."
  },
  Event_129200_Name = {
    Text = "Souvenir Disparu"
  },
  Event_129201_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129201_Name = {
    Text = "Chapitre 4 des Étoiles@"
  },
  Event_129202_ChoiceDesc1 = {
    Text = "[Écouter attentivement] Choisir 1 Carte d'instruction parmi 3 pour graver l'Oraison : «(EnchantConfig.Arg1)» deux fois, mais développer «(Skill.Arg2)» deux fois"
  },
  Event_129202_ChoiceDesc2 = {
    Text = "[Cover Ears] Pour chaque Réveilleur avec Aliemus de 50 ou plus, gagner 15 Sigils Noirs."
  },
  Event_129202_ChoiceDesc3 = {
    Text = "[Examine] Graver 1 Oraison parmi 3 deux fois"
  },
  Event_129202_Desc = {
    Text = "Lorsque vous entrez dans l'étage des squelettes, un doux tintement résonne soudainement dans la vaste usine abandonnée, apportant une sensation de clarté de piano qui contraste avec les décombres d'acier rouillé"
  },
  Event_129202_Name = {
    Text = "Échelle sinistre"
  },
  Event_129203_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129203_Name = {
    Text = "Oubli chapitre 3@"
  },
  Event_129204_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129204_Name = {
    Text = "Oubli Chapitre 6@"
  },
  Event_129205_ChoiceDesc1 = {
    Text = "[Spare Her] Obtenez une relique maudite \"(RelicConfig.Arg1)\", infectez \"(Skill.Arg2)\""
  },
  Event_129205_ChoiceDesc2 = {
    Text = "[L'aider] Choisissez 1 Carte parmi 3 Cartes d'instruction pour obtenir l'Oraison : [(EnchantConfig.Arg1)] deux fois"
  },
  Event_129205_ChoiceDesc3 = {
    Text = "[Je marcherai sur mon propre chemin] Gagnez 50 Sigils noirs"
  },
  Event_129205_Desc = {
    Text = "Trois silhouettes bloquent ton chemin. \n «Tu peux la laisser partir, » dit la silhouette tenant un ours en peluche couvert de lave corrodée, «elle est juste timide, pas malveillante. Elle ne veut blesser personne. » \n «Tu peux l'aider, » dit la silhouette tenant une boîte de bonbons joliment emballée, «tu peux faire ce qu'elle ne peut pas faire, tu peux mettre fin à tout ça. » \n «Tu n'as pas besoin de nous écouter, » dit la silhouette les mains vides, «tu as ton propre chemin. »"
  },
  Event_129205_Name = {
    Text = "Chemin bifurqué"
  },
  Event_129206_ChoiceDesc1 = {
    Text = "[Nourrir les rats] Obtient une Création en argent [(RelicConfig.Arg1)], développe 1 symptôme"
  },
  Event_129206_ChoiceDesc2 = {
    Text = "[Chasser les rats] Choisir 1 Carte d'instruction parmi 3 pour Graver l'Oraison : «(EnchantConfig.Arg1)» deux fois, mais développe «(Skill.Arg2)» deux fois"
  },
  Event_129206_ChoiceDesc3 = {
    Text = "[Ignorer les rats] Obtenez 25 Marques noires"
  },
  Event_129206_Desc = {
    Text = "Tout sur ce navire est piégé dans la boucle temporelle.\nMême ces dégoûtantes petites créatures poilues luttant pour survivre ici ne peuvent échapper à leur destin.\nCycle après cycle, elles dévorent tout ce qui est en vue, mais leur faim n'est jamais rassasiée.\n«Si... faim...»\nDes hordes de rats émettent des cris perçants et maladifs.\nLes cycles sans fin les ont rendus affamés et dérangés — ils doivent manger quelque chose.\nMaintenant. Immédiatement."
  },
  Event_129206_Name = {
    Text = "Meute de rats affamés"
  },
  Event_129207_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129207_Name = {
    Text = "Oubli Chapitre 8@"
  },
  Event_129208_ChoiceDesc1 = {
    Text = "[Toucher le cerveau] 1 Carte d'instruction aléatoire obtient l'Oraison : [(EnchantConfig.Arg1)] deux fois"
  },
  Event_129208_ChoiceDesc2 = {
    Text = "[Toucher le cœur] Augmentez Arg1 points de santé maximum, infectez [(Skill.Arg2) ]"
  },
  Event_129208_Desc = {
    Text = "Tu entres dans cette salle grise où personne ne chuchote, une balance émergeant dans le brouillard noir. \n À gauche se trouve un cerveau calme comme un lac, ses canyons argentés scintillant faiblement ; à droite, un cœur rouge flamboyant, dégoulinant de chaleur. \n Tout à coup, tu sens un parfum, un désir affamé qui ne cesse de croître, la raison étant écrasée par son obscurité infinie. \n Tu tends la main."
  },
  Event_129208_Name = {
    Text = "Jeux de la faim"
  },
  Event_129209_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129209_Name = {
    Text = "Oubli Chapitre 4@"
  },
  Event_129210_ChoiceDesc1 = {
    Text = "[Terrasser les ombres] Choisir 1 Carte d'instruction parmi 3 pour graver l'Oraison : «(EnchantConfig.Arg1)» deux fois, mais développer «(Skill.Arg2)» deux fois"
  },
  Event_129210_ChoiceDesc2 = {
    Text = "[Écraser l'Embryon] Choisir 1 Carte d'instruction parmi 3 pour graver l'Oraison : «(EnchantConfig.Arg1)» deux fois, mais développer «(Skill.Arg2)» deux fois"
  },
  Event_129210_ChoiceDesc3 = {
    Text = "[Close Your Eyes] Gain 25 black sigils"
  },
  Event_129210_Desc = {
    Text = "Dans un état second, vous voyez des gens d'Aran s'approcher de vous.\nIls rient, vous invitent à boire, danser, profiter du festin.\nPuis leur chair commence à se détacher par couches, tombant au sol et se tordant en nouveaux Embryons.\nIls tendent la main, vous invitant à rejoindre la célébration de chair et de renaissance."
  },
  Event_129210_Name = {
    Text = "Ombres du passé"
  },
  Event_129211_ChoiceDesc1 = {
    Text = "[Feed them] Gagner une relique d'argent '(RelicConfig.Arg1)', choisir d'infecter 1 fois le symptôme"
  },
  Event_129211_ChoiceDesc2 = {
    Text = "[Ne pas s'en préoccuper] Choisir 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)» deux fois, infecter «(Skill.Arg2)» deux fois"
  },
  Event_129211_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_129211_Desc = {
    Text = "Les résidents vont et viennent, mais la horde de rats persiste depuis longtemps. \n Par rapport aux humains, ils sont les « indigènes » de ce château. \n Cependant, ils n'ont aucune objection à l'installation des humains. \n Car ces créatures moelleuses et blanches leur offrent également des choses moelleuses et blanches. \n « Et toi, créature, à quel type appartiens-tu ? »"
  },
  Event_129211_Name = {
    Text = "Le secret de l'ancien château"
  },
  Event_129212_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129212_Name = {
    Text = "Oubli Chapitre 5@"
  },
  Event_129213_ChoiceDesc1 = {
    Text = "[Discern Man's Voice] Piochez aléatoirement 3 cartes de commandement du paquet et choisissez 1 à dupliquer."
  },
  Event_129213_ChoiceDesc2 = {
    Text = "[Distinguer la voix de la femme] Choisir 1 Carte d'instruction parmi 3 pour graver l'Oraison : «(EnchantConfig.Arg1)» deux fois, mais développer «(Skill.Arg2)» deux fois"
  },
  Event_129213_ChoiceDesc3 = {
    Text = "[Différencier la voix du vieillard] obtenez 25 marques noires"
  },
  Event_129213_Desc = {
    Text = "Tu te tiens seul dans un marécage sombre. \n Dans le flou, tu entends des délires entrelacés du chaos affluer comme une marée, certains viennent de vieillards, d'autres de jeunes enfants balbutiants, certains de femmes anxieuses, d'autres d'hommes pris de peur inexplicable…"
  },
  Event_129213_Name = {
    Text = "Dernières paroles incohérentes"
  },
  Event_129214_ChoiceDesc1 = {
    Text = "[Regarder de plus près] Obtenir une Oraison au choix parmi 3, deux fois"
  },
  Event_129214_ChoiceDesc2 = {
    Text = "[Arracher l'affiche] 1 Carte d'instruction aléatoire obtient l'Oraison : «(EnchantConfig.Arg1)» deux fois, infecter «(Skill.Arg2)» deux fois"
  },
  Event_129214_Desc = {
    Text = "Un candélabre que l'on trouve partout dans un musée de cire.\nAvec la lumière orange maladive, vous découvrez une affiche dessinée à la main accrochée sur le mur"
  },
  Event_129214_Name = {
    Text = "Rires dans les ténèbres"
  },
  Event_129215_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129215_Name = {
    Text = "Oubli Chapitre 4@"
  },
  Event_129216_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129216_Name = {
    Text = "Oubli Chapitre 7@"
  },
  Event_129217_ChoiceDesc1 = {
    Text = "[Stare] Obtenez la Relique Argent \"(RelicConfig.Arg1)\" et devenez infecté par \"(Skill.Arg2)\"."
  },
  Event_129217_ChoiceDesc2 = {
    Text = "[Ignore] Graver 1 Oraison parmi 3 deux fois"
  },
  Event_129217_Desc = {
    Text = "Les aram s’agenouillent dans la tempête de sable.  \nLe vent frappe leurs corps, les grains emportant leur cœur pieux.  \nAu sein du tourbillon de sable, il semble que d'innombrables yeux géants scrutent la terre déformée"
  },
  Event_129217_Name = {
    Text = "Géant de sable et de poussière"
  },
  Event_129218_ChoiceDesc1 = {
    Text = "[Chasser les papillons] 1 Carte d'instruction aléatoire obtient l'Oraison : «(EnchantConfig.Arg1)» deux fois, infecter «(Skill.Arg2)» deux fois"
  },
  Event_129218_ChoiceDesc2 = {
    Text = "[Écouter le vœu] Choisir 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : [(EnchantConfig.Arg1)] deux fois"
  },
  Event_129218_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_129218_Desc = {
    Text = "Le petit papillon porte de nombreux rêves.\nCes rêves sont éparpillés dans la mer de fleurs, dans les chambres d'hôpital, et sur l'autel rempli de chair et de sang de @2.\nEnfin, il a attendu la personne qui le lie, ne sais-tu pas si tu es prêt à écouter son petit, petit vœu."
  },
  Event_129218_Name = {
    Text = "Rêve de papillon"
  },
  Event_129219_ChoiceDesc1 = {
    Text = "[Suivre le guide] Choisir 1 Carte d'instruction parmi 3 pour Graver l'Oraison : «(EnchantConfig.Arg1)» deux fois, mais développe «(Skill.Arg2)» deux fois"
  },
  Event_129219_ChoiceDesc2 = {
    Text = "[Ignorer le guide] Choisir 1 Carte d'instruction parmi 3 pour Graver l'Oraison : «(EnchantConfig.Arg1)» deux fois, mais développe «(Skill.Arg2)» deux fois"
  },
  Event_129219_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_129219_Desc = {
    Text = "Le festival a commencé.\nSous les flammes de l'Esprit et les bénédictions du sang, d'innombrables Âmes de croyants sont devenues des phares—\nLes esprits éthérés se dispersent autour de vous comme des fées guides, éclatants et attendant votre choix."
  },
  Event_129219_Name = {
    Text = "Phare de l'âme"
  },
  Event_129220_ChoiceDesc1 = {
    Text = "[Ignorer la cloche] Choisir 1 Oraison avancée parmi 3, deux fois"
  },
  Event_129220_ChoiceDesc2 = {
    Text = "[Pick Up the Receiver]acquérir la Relique en or \"(RelicConfig.Arg1)\", infecter \"(Skill.Arg2)\""
  },
  Event_129220_ChoiceDesc3 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_129220_Desc = {
    Text = "Il n'aurait pas dû sonner—— ce téléphone, recroquevillé derrière la toile. \n Le fil du combiné s'entrelace autour du gros corps de l'appareil, tel un cordon ombilical rouillé, semblant s'étendre depuis ton esprit. \n Tu distingues attentivement la fréquence des vibrations, le son étrange évoquant l'art surréaliste de Pickman."
  },
  Event_129220_Name = {
    Text = "Appel manqué"
  },
  Event_129221_ChoiceDesc1 = {
    Text = "[Nous sommes tous en sécurité] Choisissez 1 Carte parmi 3 Cartes d'instruction pour obtenir l'Oraison : «(EnchantConfig.Arg1)» deux fois, infecter «(Skill.Arg2)» deux fois"
  },
  Event_129221_ChoiceDesc2 = {
    Text = "[Qui êtes-Vous ?] Choisissez 1 Carte parmi 3 Cartes d'instruction pour obtenir l'Oraison : «(EnchantConfig.Arg1)» deux fois, infecter «(Skill.Arg2)» deux fois"
  },
  Event_129221_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_129221_Desc = {
    Text = "La machine à écrire cracha brusquement de l'encre, avec un nombre de points d'exclamation éblouissant.\n\"Doll, ça va ??? Pourquoi as-tu disparu quand le Gardien a disparu aussi ??? S'il te plaît, si tu es en sécurité, envoie un message !!! Les cheveux de William vont tomber si nous attendons plus longtemps !!!\""
  },
  Event_129221_Name = {
    Text = "Communication d'urgence"
  },
  Event_129222_ChoiceDesc1 = {
    Text = "[Cut the Red Ribbon] Retirez 1 carte de commandement, gagnez Arg1 Le Sigil Noir"
  },
  Event_129222_ChoiceDesc2 = {
    Text = "[Combattre] Copiez 1 carte de commandement, infection[(Skill.Arg1)]"
  },
  Event_129222_ChoiceDesc3 = {
    Text = "[Appeler Ramona] Choisir 1 Carte d'instruction parmi 3 pour graver l'Oraison : [(EnchantConfig.Arg1)] deux fois"
  },
  Event_129222_Desc = {
    Text = "Kasiah lança le chiffon rouge, s'enroulant instantanément autour de votre valise"
  },
  Event_129222_Name = {
    Text = "Étoffe enchevêtreuse"
  },
  Event_129223_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129223_Name = {
    Text = "Oubli Chapitre 6@"
  },
  Event_129224_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129224_Name = {
    Text = "Chapitre 3 des Étoiles@"
  },
  Event_129225_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129225_Name = {
    Text = "Oubli chapitre 3@"
  },
  Event_129226_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129226_Name = {
    Text = "Oubli Chapitre 4@"
  },
  Event_129227_ChoiceDesc1 = {
    Text = "[Écarter d'un geste] Choisir 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)» deux fois, infecter «(Skill.Arg2)» deux fois"
  },
  Event_129227_ChoiceDesc2 = {
    Text = "[Let It Stay] Gagne la Relique d'Argent \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_129227_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_129227_Desc = {
    Text = "Un léger bruit se fait entendre dans les ténèbres. \n C'est un papillon qui demande poliment. \n « Puis-je me poser dans le creux de ta main ? » \n « Je suis juste trop fatigué, je veux me reposer un peu... » \n En posant cette question, le papillon traverse les ténèbres, tournoyant devant toi. \n Un liquide noir et collant tombe de ses ailes — c'est le don des ténèbres lorsque le papillon traverse l'obscurité."
  },
  Event_129227_Name = {
    Text = "Demande de papillon"
  },
  Event_129228_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129228_Name = {
    Text = "Oubli Chapitre 7@"
  },
  Event_129229_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129229_Name = {
    Text = "Oubli Chapitre 7@"
  },
  Event_129230_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129230_Name = {
    Text = "Oubli Chapitre 1@"
  },
  Event_129231_ChoiceDesc1 = {
    Text = "[Recognize Lyrics] Obtenez une Relique d'Argent \"(RelicConfig.Arg1)\", et infectez \"(Skill.Arg2)\""
  },
  Event_129231_ChoiceDesc2 = {
    Text = "[Fredonner doucement] Graver 1 Oraison parmi 3 deux fois"
  },
  Event_129231_Desc = {
    Text = "La vieille chanson de marins résonne dans le domaine. \nLes souvenirs piégés dans le domaine chantent des vagues, le ciel et l'alcool envers une langue que tu n'as jamais entendue"
  },
  Event_129231_Name = {
    Text = "Chant de la mer"
  },
  Event_129232_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129232_Name = {
    Text = "Chapitre 8 de l'oubli@"
  },
  Event_129233_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129233_Name = {
    Text = "Étoile - Chapitre 1@"
  },
  Event_129234_ChoiceDesc1 = {
    Text = "[Trancher la paume] Choisir 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)» deux fois, infecter «(Skill.Arg2)» deux fois"
  },
  Event_129234_ChoiceDesc2 = {
    Text = "[Accept Growth]acquérir la relique d'argent \"(RelicConfig.Arg1)\", infecter \"(Skill.Arg2)\""
  },
  Event_129234_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_129234_Desc = {
    Text = "Le papillon ne vient pas, il pousse lentement depuis ta paume. \n Au début, tu pensais que c'était juste de la sueur, mais tu vois entre tes doigts un liquide noir s'écouler silencieusement comme un reflux veineux, se solidifiant en ailes froides et pulsantes. \n À chaque battement, il crée des ondulations dans ton sang."
  },
  Event_129234_Name = {
    Text = "Parasite de l'élite"
  },
  Event_129235_ChoiceDesc1 = {
    Text = "[Continuer à parcourir] 1 Carte d'instruction aléatoire obtient l'Oraison : [(EnchantConfig.Arg1)] deux fois"
  },
  Event_129235_ChoiceDesc2 = {
    Text = "[Partir] Augmente Arg1 points de santé max, infection[(Skill.Arg2)]"
  },
  Event_129235_Desc = {
    Text = "Une balance pour peser.\nDerrière, d'innombrables organes sont trempés dans du formol rouge.\nIls sont soigneusement empilés sur des étagères de stockage.\nVous ramassez distraitement un carnet à proximité et le feuilletez :\n\"Cœur : 8 oz, Cerveau : 50 oz...\""
  },
  Event_129235_Name = {
    Text = "Enregistrement d'organes"
  },
  Event_129236_ChoiceDesc1 = {
    Text = "[Detour] Retirez 1 carte de commande et gagnez des sigils noirs Arg1."
  },
  Event_129236_ChoiceDesc2 = {
    Text = "[Demandez pourquoi ça a coulé] copiez une carte de commandement et infectez[(Skill.Arg1)]"
  },
  Event_129236_ChoiceDesc3 = {
    Text = "[Saluer le Matelot] Choisir 1 Carte d'instruction parmi 3 pour graver l'Oraison : [(EnchantConfig.Arg1)] deux fois"
  },
  Event_129236_Desc = {
    Text = "Sur le chemin menant à la salle de puissance, tu rencontres à nouveau des « mémoires » fixées dans le domaine.\nElles ne sont pas des fantômes, mais simplement le chagrin du capitaine Elton pour ses marins disparus"
  },
  Event_129236_Name = {
    Text = "Propriétaire du Sonanir"
  },
  Event_129237_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129237_Name = {
    Text = "Oubli chapitre 3@"
  },
  Event_129238_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129238_Name = {
    Text = "Chapitre 1 des Étoiles@"
  },
  Event_129239_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129239_Name = {
    Text = "Oubli Chapitre 6@"
  },
  Event_129240_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129240_Name = {
    Text = "Oubli Chapitre 5@"
  },
  Event_129241_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129241_Name = {
    Text = "Chapitre 4 des Étoiles@"
  },
  Event_129242_ChoiceDesc1 = {
    Text = "[Jouer pour lui] Choisir 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)» deux fois, infecter «(Skill.Arg2)» deux fois"
  },
  Event_129242_ChoiceDesc2 = {
    Text = "[Listening to the Strings] Pour chaque Réveilleur avec un Aliemus de 50 ou plus, gagnez 15 Sigils noirs."
  },
  Event_129242_ChoiceDesc3 = {
    Text = "[Leave] Choisir 1 Oraison parmi 3, deux fois"
  },
  Event_129242_Desc = {
    Text = "« Cher John : \n    Récemment, j'ai soudain réalisé qu'il s'est écoulé plusieurs années depuis la dernière fois que tu as joué du piano pour nous. \n    J'ai 81 ans cette année, et plus je vieillis, plus je prends conscience de la valeur des souvenirs de ma jeunesse. \n    Si tu reçois cette lettre, je te prie de t'arrêter devant mon appartement la prochaine fois que tu passeras par Londinium et de venir jouer un morceau. »"
  },
  Event_129242_Name = {
    Text = "Sonate du Regret"
  },
  Event_129243_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129243_Name = {
    Text = "Chapitre 3 des Étoiles@"
  },
  Event_129244_ChoiceDesc1 = {
    Text = "[Dire que vous n'avez pas de portefeuille] Obtenir une Oraison au choix parmi 3, deux fois"
  },
  Event_129244_ChoiceDesc2 = {
    Text = "[Briser le filet] 1 Carte d'instruction aléatoire obtient l'Oraison : «(EnchantConfig.Arg1)» deux fois, infecter «(Skill.Arg2)» deux fois"
  },
  Event_129244_Desc = {
    Text = "Un filet orange flotte silencieusement dans l'air, ses mailles sont rares, bien moins délicates que celles d'une cousine qui repose sur le mur. \n Tu ne peux t'empêcher de tendre la main pour toucher, le filet fragile se dissout instantanément, les rires des enfants résonnent à tes oreilles. \n «Tout ce qui est doré, argenté, jaune ou rouge, tous les porte-monnaie sont à nous !»"
  },
  Event_129244_Name = {
    Text = "Réseau errant"
  },
  Event_129245_ChoiceDesc1 = {
    Text = "[Choisir l'émotion] Récupérez Arg1 points de vie"
  },
  Event_129245_ChoiceDesc2 = {
    Text = "[Maintenir sa raison] Une Carte d'instruction aléatoire obtient l'Oraison : [(EnchantConfig.Arg1)] deux fois"
  },
  Event_129245_ChoiceDesc3 = {
    Text = "[Refuser de choisir] Obtenez 25 sigils noirs"
  },
  Event_129245_Desc = {
    Text = "\"Choisis, choisis.\"\nDans l'obscurité grondante, d'innombrables chuchotements résonnèrent.\nLa voix est doucement hypnotique, semblant porter une magie infinie qui induit une sorte de phantasme fou en toi.\nTon cerveau sombre dans la folie, se tordant loin du corps, tandis que le cœur semble avoir développé une certaine conscience, criant et t'appelant.\n\"Choisis, choisis.\"\n\"Maintiens la rationalité ou l'émotion ; tu dois faire un choix.\""
  },
  Event_129245_Name = {
    Text = "Le prix de l'humanité"
  },
  Event_129246_ChoiceDesc1 = {
    Text = "[Destroy Offering] Obtenir une relique maudite \"(RelicConfig.Arg1)\", infecter \"(Skill.Arg2)\""
  },
  Event_129246_ChoiceDesc2 = {
    Text = "[Défaire les cordes] Choisir 1 Carte d'instruction parmi 3 pour graver l'Oraison : [(EnchantConfig.Arg1)] deux fois"
  },
  Event_129246_ChoiceDesc3 = {
    Text = "[Keep Going] Gagnez 50 Sigils Noirs"
  },
  Event_129246_Desc = {
    Text = "Trois lémuriens sont attachés sur une estrade.  \nDes motifs sombres en écorce, semblables à ceux que tu as vus sur des bébés, apparaissent sur leur corps, tandis qu'ils murmurent des mots"
  },
  Event_129246_Name = {
    Text = "Trois offrandes"
  },
  Event_129247_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129247_Name = {
    Text = "Étoiles Chapitre 3@"
  },
  Event_129248_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129248_Name = {
    Text = "Oubli Chapitre 6@"
  },
  Event_129249_ChoiceDesc1 = {
    Text = "[Struggle Forward] Supprimer 1 carte de commande, gagner Arg1 Sigil Noir"
  },
  Event_129249_ChoiceDesc2 = {
    Text = "[Casser le fil] Copiez 1 carte de commandement et infectez[(Skill.Arg1)]"
  },
  Event_129249_ChoiceDesc3 = {
    Text = "[Retenir sa colère] Choisir 1 Carte d'instruction parmi 3 pour graver l'Oraison : [(EnchantConfig.Arg1)] deux fois"
  },
  Event_129249_Desc = {
    Text = "Tu es poussé en avant, tous tes choix étant manipulés par des fils invisibles.  \nTu luttés pour bouger tes mains, désireux d'attraper tout ce qui t'importe.  \nLe destin du monde pend devant tes doigts.  \nDes fils innombrables s'enroulent autour de toi, te liant entièrement"
  },
  Event_129249_Name = {
    Text = "Mains Manipulées"
  },
  Event_129250_ChoiceDesc1 = {
    Text = "[Demander son chemin] Choisissez 1 Carte parmi 3 Cartes d'instruction pour obtenir l'Oraison : «(EnchantConfig.Arg1)» deux fois, infecter «(Skill.Arg2)» deux fois"
  },
  Event_129250_ChoiceDesc2 = {
    Text = "[S'en éloigner] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infectée par «(Skill.Arg2)»"
  },
  Event_129250_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_129250_Desc = {
    Text = "L'ombre se tient sous le lampadaire élancé. \n « Pourriez-vous me prêter une flamme, monsieur ? » \n Tu n'as pas l'habitude de @2, mais cela ne te dérange pas d'utiliser un peu de « magie ». \n Avec ton aide, l'ombre allumera le @2 et l'enfoncera dans le vortex noir sans fond. \n Peu après, tu vois de la fumée blanche s'élever. \n « Ah— » \n L'ombre pousse un soupir de satisfaction."
  },
  Event_129250_Name = {
    Text = "La silhouette sous le réverbère"
  },
  Event_129251_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129251_Name = {
    Text = "Oubli Chapitre 1@"
  },
  Event_129252_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129252_Name = {
    Text = "Oubli chapitre 8@"
  },
  Event_129253_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129253_Name = {
    Text = "Oubli chapitre 3@"
  },
  Event_129254_ChoiceDesc1 = {
    Text = "[Accepter l'Illusion] 1 Carte d'instruction aléatoire obtient l'Oraison : «(EnchantConfig.Arg1)» deux fois, infecter «(Skill.Arg2)» deux fois"
  },
  Event_129254_ChoiceDesc2 = {
    Text = "[Nier l'Illusion] Choisissez 1 Carte parmi 3 Cartes d'instruction pour obtenir l'Oraison : [(EnchantConfig.Arg1)] deux fois"
  },
  Event_129254_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_129254_Desc = {
    Text = "Sous le lourd pont de fer dans l'obscurité, sur la berge silencieuse envahie de roseaux, une papillon scintillant surgit soudain. \n Le papillon se pose léger dans ta paume, les hurlements affreux s'arrêtent, remplacés par le grondement d'un train passant sur la structure en acier rouillé, le crépitement du charbon brûlant, le bruit de frottement métallique des essieux tournants…"
  },
  Event_129254_Name = {
    Text = "Illusion Ferroviaire"
  },
  Event_129255_ChoiceDesc1 = {
    Text = "[Choose to refuse] Supprimer 1 carte de commandement, gagner Arg1 Le sigil noir"
  },
  Event_129255_ChoiceDesc2 = {
    Text = "[Choose to comply] Copiez 1 Carte de Commandement, infectez '(Skill.Arg1)'"
  },
  Event_129255_ChoiceDesc3 = {
    Text = "[Choisir d'embrasser] Choisir 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : [(EnchantConfig.Arg1)] deux fois"
  },
  Event_129255_Desc = {
    Text = "« Je suis un oiseau en cage, enfermé dans une cour pleine de nombreuses pièces. »\n Des silhouettes floues errent dans l'obscurité, ce sont les obsessions laissées par les défunts. \n « Ils disent que c'est un asile, mais je sais que c'est une cage spéciale pour les humains, emprisonnant les oiseaux libres qui ne veulent pas se conformer aux règles de la société. »\n « Mais un oiseau qui ne peut pas voler peut-il encore être appelé un oiseau ? »\n Les obsessions se rapprochent de toi, priant pour la rédemption. \n « S'il vous plaît, brisez mes ailes, j'en ai assez de voler. »"
  },
  Event_129255_Name = {
    Text = "Homme creux"
  },
  Event_129256_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129256_Name = {
    Text = "Chapitre 2 de l'Oubli@"
  },
  Event_129257_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129257_Name = {
    Text = "Étoile Chapitre 2@"
  },
  Event_129258_ChoiceDesc1 = {
    Text = "[Libérer le papillon] Choisir 1 Carte d'instruction parmi 3 pour graver l'Oraison : «(EnchantConfig.Arg1)» deux fois, mais développer «(Skill.Arg2)» deux fois"
  },
  Event_129258_ChoiceDesc2 = {
    Text = "[Become a Butterfly] Gagner la Relique en argent \"(RelicConfig.Arg1)\" et infecter \"(Skill.Arg2)\"."
  },
  Event_129258_ChoiceDesc3 = {
    Text = "[Swallow Back] Gagnez 25 Sigils Noirs"
  },
  Event_129258_Desc = {
    Text = "Cette nuit, tant de choses se sont produites. \n Attaque du quai, cargo fantôme, Marcheur des mers, Tulu, Murphy, Ramona... Tout cela tourbillonne dans le vortex, réduit en bouillie d'avoine à sept heures du matin au restaurant Mizag. \n Je veux poser une question à l'Éveilleur devant moi, mais je ne sais pas par où commencer, comme une épine dans la gorge — ou devrais-je dire, des papillons dans l'estomac."
  },
  Event_129258_Name = {
    Text = "Effet papillon"
  },
  Event_129259_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129259_Name = {
    Text = "Oubli Chapitre 8@"
  },
  Event_129260_ChoiceDesc1 = {
    Text = "[Laisser traîner] Choisissez 1 Carte parmi 3 Cartes d'instruction pour obtenir l'Oraison : «(EnchantConfig.Arg1)» deux fois, infecter «(Skill.Arg2)» deux fois"
  },
  Event_129260_ChoiceDesc2 = {
    Text = "[Waving Away] Obtenez la Relique Argent \"(RelicConfig.Arg1)\", infectez \"(Skill.Arg2)\""
  },
  Event_129260_ChoiceDesc3 = {
    Text = "[Welcome the Butterflies] Gagnez 25 sigils noirs"
  },
  Event_129260_Desc = {
    Text = "Vous errez dans le sanatorium glacial, une papillon noir, anormal pour la saison, vole vers vous.\nSes ailes dégoulinent de liquide noir, laissant des traces qui se solidifient et s'effritent au vent.\nIl se pose sur votre doigt, épuisé"
  },
  Event_129260_Name = {
    Text = "Quelque chose qui ne devrait pas exister"
  },
  Event_129261_ChoiceDesc1 = {
    Text = "[Revivre le passé] Graver 1 Oraison avancée au choix parmi 3 deux fois"
  },
  Event_129261_ChoiceDesc2 = {
    Text = "[Regard vers le futur] Gagne une Création en or «(RelicConfig.Arg1)», infecte «(Skill.Arg2)»"
  },
  Event_129261_ChoiceDesc3 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_129261_Desc = {
    Text = "Rien dans le monde ne peut rester statique.\n Même le paradis sculpté par la Déesse Mère n'est pas une exception.\n En un instant fugace, vous apercevez quelque chose à travers les fissures du temps et de l'espace.\n Le passé, le présent et le futur s'entrelacent dans cette fissure craquée, changeant constamment.\n Attendant votre regard curieux"
  },
  Event_129261_Name = {
    Text = "Faille spatio-temporelle"
  },
  Event_129262_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129262_Name = {
    Text = "Oubli Chapitre 7@"
  },
  Event_129263_ChoiceDesc1 = {
    Text = "[Ignorer] Choisir 1 Oraison parmi 3, deux fois"
  },
  Event_129263_ChoiceDesc2 = {
    Text = "[Le toucher] 1 Carte d'instruction aléatoire obtient l'Oraison : «(EnchantConfig.Arg1)» deux fois, infecte «(Skill.Arg2)» deux fois"
  },
  Event_129263_Desc = {
    Text = "Une chose étrange, ressemblant à une spore, attire ton attention. \n Elle ressemble à une méduse fine composée de chair et de sang, ou à une fibre nerveuse profonde du cerveau portant un signal. \n « Touche-moi », te tente-t-elle silencieusement, « je vais te montrer un souvenir cruel. »"
  },
  Event_129263_Name = {
    Text = "Mémoire Profonde"
  },
  Event_129264_ChoiceDesc1 = {
    Text = "[S'abandonner aux fantasmes] Choisir 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)» deux fois, infecter «(Skill.Arg2)» deux fois"
  },
  Event_129264_ChoiceDesc2 = {
    Text = "[Garder la raison] pour chaque corps éveillé avec une valeur aliemus de 50 ou plus, obtient 15 marques noires"
  },
  Event_129264_ChoiceDesc3 = {
    Text = "[Partir de force] Graver 1 Oraison au choix parmi 3 deux fois"
  },
  Event_129264_Desc = {
    Text = "Peut-être est-ce la longue bataille qui vous a rendu désorienté, ou peut-être que c'est simplement que votre cerveau a trahi votre corps.\n Une sensation d'apesanteur apparaît dans votre esprit.\n En un instant, votre esprit se transforme soudainement en kaléidoscope, éclatant de couleurs, scintillant de toutes les nuances de lumière.\n D'innombrables aperçus, réflexions et fantasmes affluent dans votre cerveau, occupant chaque coin des interstices de votre esprit.\n Si cela continue, votre cerveau va bientôt éclater de ces pensées chaotiques."
  },
  Event_129264_Name = {
    Text = "Kaléidoscope de pensée"
  },
  Event_129265_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129265_Name = {
    Text = "Oubli Chapitre 5@"
  },
  Event_129266_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129266_Name = {
    Text = "Oubli Chapitre 4@"
  },
  Event_129267_ChoiceDesc1 = {
    Text = "[Listen] Graver 1 Oraison avancée parmi 3 deux fois"
  },
  Event_129267_ChoiceDesc2 = {
    Text = "[Shouting] Obtenez la relique d'or \"(RelicConfig.Arg1)\", infectez \"(Skill.Arg2)\""
  },
  Event_129267_ChoiceDesc3 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_129267_Desc = {
    Text = "Depuis l'accident, tu n'as plus reçu de nouvelles de ton partenaire.\nInnombrables tentatives de contact ont été faites, comme une pierre jetée dans la mer sans écho.\nAu moment où tu avais presque perdu tout espoir, le communicateur a soudainement émis un son.\nTu ouvres la mallette et approches le combiné de ton oreille.\n« Gardien du Secret... »\nDans un état d'égarement, tu entends cette voix que tu as tant désirée, résonnant à travers des couches de vide."
  },
  Event_129267_Name = {
    Text = "Échos de la pensée"
  },
  Event_129268_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129268_Name = {
    Text = "Oubli Chapitre 1@"
  },
  Event_129269_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129269_Name = {
    Text = "Étoile Chapitre 1@"
  },
  Event_129270_ChoiceDesc1 = {
    Text = "[Stare Down the Hellhound Source] Obtenez une relique dorée \"(RelicConfig.Arg1)\" et infectez \"(Skill.Arg2)\""
  },
  Event_129270_ChoiceDesc2 = {
    Text = "[Se concentrer sur le combat] Choisissez 1 Carte parmi 3 Cartes d'instruction pour graver l'Oraison : [(EnchantConfig.Arg1)] deux fois"
  },
  Event_129270_Desc = {
    Text = "Le contour du chien des enfers se transforme.\nSon corps est connecté aux fissures du mur, révélant une illusion sinistre"
  },
  Event_129270_Name = {
    Text = "angle d'origine"
  },
  Event_129271_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129271_Name = {
    Text = "Oubli Chapitre 2@"
  },
  Event_129272_ChoiceDesc1 = {
    Text = "[Combine Pages] Obtenez la Relique d'or \"(RelicConfig.Arg1)\", infectée avec \"(Skill.Arg2)\""
  },
  Event_129272_ChoiceDesc2 = {
    Text = "[Read] Choisir 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : [(EnchantConfig.Arg1)] deux fois"
  },
  Event_129272_ChoiceDesc3 = {
    Text = "[Discard It] Gagnez 50 Sigils Noirs"
  },
  Event_129272_Desc = {
    Text = "Une page jaunie tombe de la robe des Porteurs de lanternes. \nElle est couverte de textes étranges, certains ressemblant à des symboles pictographiques, d'autres montant bizarrement, certaines lettres se chevauchant même, avec peu de mots à peine lisibles. \nLe titre est «@2 La naissance du Fils Saint»"
  },
  Event_129272_Name = {
    Text = "Ordre secret · Bas"
  },
  Event_129273_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129273_Name = {
    Text = "Oubli Chapitre 2@"
  },
  Event_129274_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129274_Name = {
    Text = "Étoile Chapitre 2@"
  },
  Event_129275_ChoiceDesc1 = {
    Text = "[Se préparer au combat] Choisir 1 Carte d'instruction parmi 3 pour Graver l'Oraison : «(EnchantConfig.Arg1)» deux fois, mais développe «(Skill.Arg2)» deux fois"
  },
  Event_129275_ChoiceDesc2 = {
    Text = "[Tenter un détour] Obtenez 25 Marques noires"
  },
  Event_129275_Desc = {
    Text = "Dans les profondeurs de l'Aequor où la lumière des étoiles tombe, les Marcheurs des mers ont hiberné pendant des siècles. \n Les eaux infinies ont été témoins de leur folie, de leur patience, et de leur dévouement le plus sincère envers les divinités. \n Personne ne peut empêcher la grande descente des dieux. \n Quiconque se met en travers de leur chemin sera réduit en cendres par la colère des Marcheurs des mers."
  },
  Event_129275_Name = {
    Text = "Attente sous les Étoiles"
  },
  Event_129276_ChoiceDesc1 = {
    Text = "[Play a Few Notes] Obtenez la relique argent \"(RelicConfig.Arg1)\" et infligez \"(Skill.Arg2)\"."
  },
  Event_129276_ChoiceDesc2 = {
    Text = "[Refermer le couvercle] Obtenir une Oraison au choix parmi 3, deux fois"
  },
  Event_129276_Desc = {
    Text = "Le piano au bord du mur est ouvert. Il a des touches jaunies et des bords fissurés révélant le bois, mais chaque touche est soigneusement nettoyée.\nIl est la source de joie de tant de gens"
  },
  Event_129276_Name = {
    Text = "Mélodie de l'enfance"
  },
  Event_129277_ChoiceDesc1 = {
    Text = "[Accepter l'Illusion] Choisissez 1 Carte parmi 3 Cartes d'instruction pour obtenir l'Oraison : «(EnchantConfig.Arg1)» deux fois, infecter «(Skill.Arg2)» deux fois"
  },
  Event_129277_ChoiceDesc2 = {
    Text = "[Deny Phantasm] Obtenir une relique d'argent \"(RelicConfig.Arg1)\" et infecter \"(Skill.Arg2)\"."
  },
  Event_129277_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_129277_Desc = {
    Text = "Sous le lourd pont de fer dans l'obscurité, sur la berge silencieuse envahie de roseaux, une papillon scintillant surgit soudain. \n Le papillon se pose léger dans ta paume, les hurlements affreux s'arrêtent, remplacés par les chants réguliers des ouvriers transportant des barres d'acier, le bruit des marteaux à tête de clou et le son métallique clair des rivets qui s'entrechoquent..."
  },
  Event_129277_Name = {
    Text = "Illusion du pont d'acier"
  },
  Event_129278_ChoiceDesc1 = {
    Text = "[Montrer la malédiction] Choisissez 1 Carte parmi 3 Cartes d'instruction pour obtenir l'Oraison : «(EnchantConfig.Arg1)» deux fois, infecter «(Skill.Arg2)» deux fois"
  },
  Event_129278_ChoiceDesc2 = {
    Text = "[Repousser le corbeau] Graver 1 Oraison parmi 3 deux fois"
  },
  Event_129278_ChoiceDesc3 = {Text = "[Ignorez]"},
  Event_129278_Desc = {
    Text = "Un corbeau à multiples têtes, noir et malsain, s'échappe de la robe sombre d'un croyant de la lumière du temple et se pose sur ton épaule.\n« As-tu vu ma tête ? Il suffit de goûter à la malédiction, et je ferai pousser une nouvelle tête. Montre-moi ta malédiction ! »"
  },
  Event_129278_Name = {
    Text = "Corbeau maudit"
  },
  Event_129279_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129279_Name = {
    Text = "Oubli Chapitre 7@"
  },
  Event_129280_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129280_Name = {
    Text = "Oubli Chapitre 3@"
  },
  Event_129281_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129281_Name = {
    Text = "Oubli Chapitre 4@"
  },
  Event_129282_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129282_Name = {
    Text = "Oubli Chapitre 2@"
  },
  Event_129283_ChoiceDesc1 = {
    Text = "[Place-holder]Texte temporaire."
  },
  Event_129283_Name = {
    Text = "Étoile Chapitre 2@"
  },
  Event_129900_ChoiceDesc1 = {
    Text = "[Interment] Restaurez la Vie Arg2[ExDesc1], sélectionnez et effacez 1 carte de commandement."
  },
  Event_129900_ChoiceDesc2 = {
    Text = "[Pray] Obtenez une Création en or «(RelicConfig.Arg1)», et infectez «(Skill.Arg2)»."
  },
  Event_129900_Desc = {
    Text = "Un fragment d'os blanchâtre, la moitié immergée dans la d-boue noire."
  },
  Event_129900_Name = {
    Text = "Ossements décolorés"
  },
  Event_130337_ChoiceDesc1 = {
    Text = "[Prendre place] Mélanger [marionnette] dans votre deck."
  },
  Event_130337_Desc = {
    Text = "Dès l'instant où vous posez le pied sur les marches du théâtre, votre regard ne peut plus jamais se détacher de cette scène.\nLes fils du destin attirent d'innombrables histoires dans leur flux tourbillonnant — la poussière du passé, la lumière vacillante du présent et les brumes du futur se déchaînent sans relâche sur la scène.\nVous avez oublié votre origine et votre destination. Tout vestige du «Soi» se dissout dans les ombres des lourds rideaux. En cet instant, vous êtes le spectateur silencieux dans les fauteuils d'orchestre, et l'acteur brûlant sur les planches.\nL'intégralité de votre existence se réduit à deux traces singulières : contempler, et jouer."
  },
  Event_130337_Name = {
    Text = "Le Niveau du Destin"
  },
  Event_131264_ChoiceDesc1 = {Text = "[Leave]"},
  Event_131264_Desc = {
    Text = "Vous choisissez le pouvoir. Vous choisissez une conviction inébranlable et le courage d'avancer toujours plus loin.\nPourtant, le prix... Le but même d'un prix n'est-il pas d'être payé ?"
  },
  Event_131264_Name = {
    Text = "Regard vers le passé"
  },
  Event_131265_ChoiceDesc1 = {Text = "[Leave]"},
  Event_131265_Desc = {
    Text = "Endurant l'agonie dans votre esprit, vous agrippez fermement les éclats dérivants et dentelés. Par votre persévérance acharnée, les fissures commencent à se refermer.\nVous partez pour vous souvenir, et vous combattez pour vous souvenir. Vous ne laisserez aucun souvenir s'échapper."
  },
  Event_131265_Name = {
    Text = "Souvenirs Brisés"
  },
  Event_131266_ChoiceDesc1 = {
    Text = "[Protéger le souvenir] Graver 1 Orison parmi 3"
  },
  Event_131266_ChoiceDesc2 = {
    Text = "[Sceller la fissure] Graver l'Orison «(EnchantConfig.Arg1)» sur 1 Carte d'instruction parmi 3, mais développer «(Skill.Arg2)»"
  },
  Event_131266_Desc = {
    Text = "Vous n'avez jamais douté de vos souvenirs. Ils étaient chaleureux, résilients — votre havre le plus sûr et votre trésor le plus précieux.\nMais à présent, sous l'interférence des Abysses en spirale, ces souvenirs commencent à se fissurer et à se briser."
  },
  Event_131266_Name = {
    Text = "Souvenirs Brisés"
  },
  Event_131267_ChoiceDesc1 = {Text = "[Leave]"},
  Event_131267_Desc = {
    Text = "Un afflux d'énergie spirituelle inonde votre esprit, recousant les déchirures horrifiantes. De toute votre volonté, vous restaurez les fractures jusqu'à les rendre entières.\nVous partez pour vous souvenir, et vous combattez pour vous souvenir. Vous ne laisserez aucun souvenir s'échapper."
  },
  Event_131267_Name = {
    Text = "Souvenirs Brisés"
  },
  Event_131268_ChoiceDesc1 = {Text = "[Leave]"},
  Event_131268_Desc = {
    Text = "«Ooh... Hahahha!!»\nPersonne ne comprend votre question. Ils répondent par des pleurs et des rires stridents."
  },
  Event_131268_Name = {
    Text = "Les Abandonnés"
  },
  Event_131269_ChoiceDesc1 = {Text = "[Leave]"},
  Event_131269_Desc = {
    Text = "Vous plongez votre regard dans le leur. Les fils s'agitent ; votre regard bienveillant attire les souvenirs, les enveloppant dans une étreinte.\nVous observez en silence la marionnettiste du destin. Si on lui offrait une autre chance, quel choix ferait-elle ?"
  },
  Event_131269_Name = {
    Text = "Regard vers le passé"
  },
  Event_131270_ChoiceDesc1 = {Text = "[Leave]"},
  Event_131270_Desc = {
    Text = "«Ooh... Hahahha!!»\nLes cris et les rires s'estompent, se dissolvant dans l'air. Aucune âme ne se lève pour vous nuire — ils ont depuis longtemps appris à vivre dans l'invisibilité."
  },
  Event_131270_Name = {
    Text = "Les Abandonnés"
  },
  Event_131271_ChoiceDesc1 = {
    Text = "[Contempler le souvenir] Obtenir la Création en or «(RelicConfig.Arg1)», mais développer «(Skill.Arg2)»"
  },
  Event_131271_ChoiceDesc2 = {
    Text = "[Abandonner le souvenir] Éveiller 2 Corps éveillés aléatoires, mais développer [(Skill.Arg1)] deux fois"
  },
  Event_131271_ChoiceDesc3 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_131271_Desc = {
    Text = "À l'intérieur du réceptacle de la jeune fille, le son d'une porcelaine qui se brise résonne. Les souvenirs s'échappent de leurs contenants, dérivant vers vous.\nCompagnons de jeux d'enfance, cadeaux parentaux, la fantaisie pure des nuages et des oiseaux, des idéaux aussi purs que le ciel ouvert... Tous les souvenirs ouvrent les yeux, vous contemplant en silence.\nIls questionnent. Ils pleurent. Ils attendent."
  },
  Event_131271_Name = {
    Text = "Regard vers le passé"
  },
  Event_131272_ChoiceDesc1 = {
    Text = "[Demander] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_131272_ChoiceDesc2 = {
    Text = "[Ignorer] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_131272_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_131272_Desc = {
    Text = "Des gémissements perçants vous vrillent les oreilles ; devant vous, des esprits agonisants lacèrent leurs propres visages et leurs formes...\nQui sont-ils ? Des Prisonniers des Abysses en spirale ? Des Destins rejetés ? Les échos du passé, peut-être ?"
  },
  Event_131272_Name = {
    Text = "Les Abandonnés"
  },
  Event_133380_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_133380_Desc = {
    Text = "Vous vous êtes installé dans votre siège de velours, et les rideaux cramoisis s'ouvrent dans un murmure feutré.\nCher spectateur, la scène s'élèvera pour répondre à chacune de vos attentes.\nLe rôle principal de cette pièce a déjà pris sa place."
  },
  Event_133380_Name = {
    Text = "Le Niveau du Destin"
  },
  Event_141995_ChoiceDesc1 = {
    Text = "[Essai simple] Supprimer jusqu'à 5 Cartes quelconques"
  },
  Event_141995_ChoiceDesc2 = {
    Text = "[Le laisser faire] Supprimer aléatoirement 5 Cartes d'instruction, obtenir la Relique Bénie [(RelicConfig.Arg1)]."
  },
  Event_141995_ChoiceDesc3 = {
    Text = "[Penser à l'envers ?] Choisir jusqu'à deux Corps éveillés, générer un jeu complet de leurs Cartes de base et l'ajouter au deck"
  },
  Event_141995_Desc = {
    Text = "Vous arrivez sur une place animée où de nombreuses personnes se pressent ; peut-être y trouverez-vous quelque chose d'intéressant.\nVous frappez à la porte d'une pièce éclairée d'une lumière jaunâtre, et une personne habillée en chercheur passe la tête. Vous apercevez de nombreux instruments scientifiques inconnus. Il vous tire par le bras pour vous faire asseoir et se présente comme un «évolutionniste». Le visage empli de Ferveur, il vous vante avec insistance sa «méthode scientifique».\n«Ce n'est qu'en supprimant les redondances inutiles de l'être humain que l'on trouve le véritable Chemin de l'évolution !»"
  },
  Event_141995_Name = {
    Text = "L'Évolutionniste"
  },
  Event_141996_ChoiceDesc1 = {
    Text = "[Entraînement axé sur l'attaque] Ajoutez une Oraison aléatoire à toutes les Frappes basiques ne portant pas d'Oraison"
  },
  Event_141996_ChoiceDesc2 = {
    Text = "[Entraînement axé sur la défense] Ajoutez une Oraison aléatoire à toutes les Défenses de base ne portant pas d'Oraison"
  },
  Event_141996_ChoiceDesc3 = {
    Text = "[Entraînement à tout prix] Ajoutez une Oraison aléatoire à 15 Cartes d'instruction aléatoires, obtenez 5 Cartes de symptômes aléatoires"
  },
  Event_141996_Desc = {
    Text = "Vous arrivez sur une place où de nombreuses personnes s'affairent, peut-être y trouverez-vous quelque chose d'intéressant.\nLe cliquetis du métal résonne sur l'esplanade, quelques personnes s'y affrontent et s'exercent pour améliorer leur art martial. Un jeune homme vêtu d'une vieille armure vous remarque et vous lance une épée, vous Invitant à vous entraîner avec eux."
  },
  Event_141996_Name = {
    Text = "Séance d'entraînement intensif"
  },
  Event_141997_ChoiceDesc1 = {
    Text = "[Parier grand] 50% de chance d'obtenir une Oraison aléatoire et de Parier à nouveau, 50% de chance d'obtenir 75 Marques noires"
  },
  Event_141997_ChoiceDesc2 = {
    Text = "[Parier petit] 50% de chance d'obtenir une Oraison aléatoire et de Parier à nouveau, 50% de chance d'obtenir 75 Marques noires"
  },
  Event_141997_Desc = {
    Text = "Le serveur maintient son sourire immuable, soulève le cornet à dés — un son cristallin retentit en Écho — et les autres joueurs font leurs choix. «Les jeux sont faits», dit-il. «Veuillez Parier —»"
  },
  Event_141997_Name = {
    Text = "Casino en effervescence"
  },
  Event_141998_ChoiceDesc1 = {
    Text = "[Miser honnêtement] Supprimer une Carte d'instruction"
  },
  Event_141998_ChoiceDesc2 = {
    Text = "[Tenter de tricher] Supprimer une Carte de symptômes"
  },
  Event_141998_ChoiceDesc3 = {Text = "[Leave]"},
  Event_141998_Desc = {
    Text = "Vous arrivez dans un endroit extrêmement animé, où chaque visage rayonne de bonheur, et les lumières colorées scintillent sans retenue, repoussant la nuit dans ses derniers retranchements. Des panneaux visibles partout proclament : «Bienvenue au carnaval ! Ici, les Rêves n'ont pas de Fin, ici, le Plaisir ne connaît jamais la Chute du rideau !»\nEmporté par la foule dense, vous vous retrouvez poussé dans un bâtiment somptueux. Le hall resplendit d'or et de lumière, les voix s'entremêlent dans un brouhaha festif, et un doux parfum de vin sucré flotte dans l'air. Un dé roule jusqu'à vos pieds en tintant, et un serveur vous accueille avec un sourire obséquieux, vous assurant que c'est un signe de chance. Animé par la curiosité, vous faites un pas en avant — peut-être avez-vous votre mot à dire dans cette partie."
  },
  Event_141998_Name = {
    Text = "Casino en effervescence"
  },
  Event_141999_ChoiceDesc1 = {
    Text = "[Échange de biens] Retirer 1 Relique, 50% de Probabilité d'obtenir 1 Création en or au choix parmi 3, 50% de Probabilité d'obtenir 25 Marques noires"
  },
  Event_141999_ChoiceDesc2 = {Text = "[Leave]"},
  Event_141999_Desc = {
    Text = "Vous arrivez dans un endroit extrêmement animé, où chaque visage rayonne de bonheur, et les lampions multicolores scintillent avec tant d'éclat qu'ils ne laissent aucune place à la nuit. Des panneaux visibles partout proclament : «Bienvenue au Carnaval ! Ici, les Rêves ne connaissent jamais de Fin, ici, le Plaisir ne connaît jamais de Chute du rideau !»\nAu milieu de la foule, un Marchand vêtu de haillons mais portant un ballot d'une taille stupéfiante vous fait signe. Il tapote le paquet à ses côtés, se penche vers vous et baisse la voix pour vous proposer une Invitation à l'Échange de biens. Le vieux sac en tissu se balance doucement au rythme de ses paroles, émettant de temps à autre un craquement sourd."
  },
  Event_141999_Name = {
    Text = "Marchand ambulant en haillons"
  },
  Event_142000_ChoiceDesc1 = {
    Text = "[Faire un vœu] Consommez 50% de vos PV actuels, obtenez 2 Créations en or aléatoires"
  },
  Event_142000_ChoiceDesc2 = {
    Text = "[Faire un vœu de tout cœur] Consommez 99% de vos PV actuels, obtenez le Pendule temporel [(RelicConfig.Arg2)]"
  },
  Event_142000_ChoiceDesc3 = {
    Text = "[Plonger la main au fond du bassin] Obtenez la Création en or [(RelicConfig.Arg1)]"
  },
  Event_142000_Desc = {
    Text = "Le vent souffle sur la campagne, un silence total règne alentour, troublé Seulement par le bruissement des arbres.\nSoudain, vous entendez le gargouillement de quelque chose qui s'écoule. Vous suivez le son, et une odeur âcre et sucrée vous assaille avant même que vous n'arriviez à destination. Vous finissez par distinguer la source de ce bruit — un bassin à vœux, empli de rouge, où le Sang d'innombrables personnes est en Surge, Comme Si quelque chose s'apprêtait à jaillir sous la surface.\nUne voix résonne au fond de votre cœur : «Offrez votre Sang, et je vous accorderai mes faveurs.»"
  },
  Event_142000_Name = {
    Text = "Source de Sang"
  },
  Event_142001_ChoiceDesc1 = {
    Text = "[Offrande simple] Choisir de supprimer 2 Reliques, obtenir la Création Coupable [(RelicConfig.Arg1)]"
  },
  Event_142001_ChoiceDesc2 = {
    Text = "[Offrande dévouée] Choisir de supprimer 4 Reliques, obtenir la Relique Bénie [(RelicConfig.Arg1)]"
  },
  Event_142001_ChoiceDesc3 = {
    Text = "[Subtiliser quelques offrandes, personne ne le saura] Obtenir la Création en or [(RelicConfig.Arg1)]"
  },
  Event_142001_Desc = {
    Text = "Le vent souffle sur la campagne, un silence total règne alentour, troublé Seulement par le bruissement des arbres.\nSans vous en rendre compte, vous vous retrouvez devant un ancien autel. Une immense statue vous domine de son Regard, comme si elle cherchait à vous prendre quelque chose. Vous apercevez, gravées au bas de l'autel, des inscriptions à peine lisibles — «À chaque gain correspond une perte»."
  },
  Event_142001_Name = {
    Text = "Autel du gain et de la perte"
  },
  Event_142002_ChoiceDesc1 = {
    Text = "[Expérience gratuite] Amélioration aléatoire de Arg2 Création(s) en argent"
  },
  Event_142002_ChoiceDesc2 = {
    Text = "[Service standard] Dépenser Arg1 Marque(s) noire(s) : Amélioration aléatoire de Arg2 Création(s) en argent"
  },
  Event_142002_ChoiceDesc3 = {
    Text = "[Service de luxe] Dépenser Arg1 Marque(s) noire(s) : Amélioration aléatoire de Arg2 Création(s) en argent"
  },
  Event_142002_Desc = {
    Text = "Vous arrivez sur une place animée où de nombreuses personnes se pressent ; peut-être y trouverez-vous quelque chose d'intéressant.\nUn petit bâtiment aux lumières chaleureuses se dresse silencieusement dans un coin de la place. On dirait un club Avancé, mais la plaque sombre accrochée au mur indique clairement : «Cet établissement ne sert que les êtres qui ne sont pas biologiques.»"
  },
  Event_142002_Name = {
    Text = "Club Spécial"
  },
  Event_142003_ChoiceDesc1 = {
    Text = "[Tirer une fois] Obtenir une Carte de symptômes"
  },
  Event_142003_ChoiceDesc2 = {
    Text = "[Partir] Obtenir 75 Marques noires"
  },
  Event_142003_Desc = {
    Text = "Vous arrivez dans un endroit extrêmement animé, où chaque visage rayonne de bonheur, et les lumières colorées scintillent sans retenue, repoussant la nuit dans ses derniers retranchements. Des panneaux visibles partout proclament : «Bienvenue au carnaval ! Ici, les Rêves n'ont pas de Fin, ici, le Plaisir ne connaît jamais la Chute du rideau !»\nVous remarquez sur le bord du Chemin un stand de loterie entouré d'une foule dense. Tout le monde a les yeux rivés sur le grand prix soigneusement dissimulé — le Vendeur ambulant vante avec ardeur sa rareté, et les gens se bousculent pour y participer."
  },
  Event_142003_Name = {
    Text = "Défi de la loterie"
  },
  Event_142004_ChoiceDesc1 = {
    Text = "[En emprunter l'usage]"
  },
  Event_142004_ChoiceDesc2 = {Text = "[Leave]"},
  Event_142004_Desc = {
    Text = "Le vent souffle sur la campagne, un silence total règne alentour, troublé seulement par le bruissement des arbres.\nSoudain, vous apercevez une vieille cabane délabrée, au centre de laquelle trône une enclume, entourée de nombreuses armes métalliques rouillées. Il semble s'agir d'une forge abandonnée depuis longtemps. À côté de l'enclume se trouve un mode d'emploi détaillé vous indiquant que vous pouvez y déposer des Reliques pour les transformer."
  },
  Event_142004_Name = {Text = "Forge"},
  Event_142005_ChoiceDesc1 = {
    Text = "[Miser honnêtement] Supprimer une Carte d'instruction"
  },
  Event_142005_ChoiceDesc2 = {
    Text = "[Tenter de tricher] Supprimer une Carte de symptômes"
  },
  Event_142005_ChoiceDesc3 = {Text = "[Leave]"},
  Event_142005_Desc = {
    Text = "Les acclamations des spectateurs annoncent votre victoire. Dans le tumulte des voix, vous vous retrouvez enfin comme eux, enivré par ce Rêve extravagant où tout est mis en jeu. Vous regardez les jetons dans votre main, Comme Si c'étaient vos compagnons les plus fidèles, ceux qui vous ont apporté la gloire. Un Chuchotement monte des profondeurs de la table de jeu, portant une requête ambiguë : «fais-le encore, gagne encore une fois.»"
  },
  Event_142005_Name = {
    Text = "Casino en effervescence"
  },
  Event_142013_ChoiceDesc1 = {
    Text = "[Parier grand] 50% de chance d'obtenir une Création en argent aléatoire et de Parier à nouveau, 50% de chance d'obtenir 75 Marques noires et d'entrer en combat Élite"
  },
  Event_142013_ChoiceDesc2 = {
    Text = "[Parier petit] 50% de chance d'obtenir une Création en argent aléatoire et de Parier à nouveau, 50% de chance d'obtenir 75 Marques noires et d'entrer en combat Élite"
  },
  Event_142013_Desc = {
    Text = "Le serveur maintient son sourire immuable, soulève le cornet à dés — un son cristallin retentit en Écho — et les autres joueurs font leurs choix. «Les jeux sont faits», dit-il. «Veuillez Parier —»"
  },
  Event_142013_Name = {
    Text = "Casino en effervescence"
  },
  Event_142073_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142073_Desc = {
    Text = "Le serveur soulève le cornet à dés — quelques secondes à peine, et l'air semble entrer en Stase. Au moment où la réponse est révélée, vous entendez des cris de joie mêlés à des gémissements de désespoir. La chance ne vous a pas accordé sa Bénédiction : les dés posés tranquillement sur la table ont donné une réponse contraire à la vôtre. Vous balayez la salle du regard une dernière fois, observant ces parieurs Fous. Il est temps de partir."
  },
  Event_142073_Name = {
    Text = "Casino en effervescence"
  },
  Event_142074_ChoiceDesc1 = {
    Text = "[Entrer dans la Bataille]"
  },
  Event_142074_Desc = {
    Text = "Alors que vous fixez la table de jeu avec impatience, votre main est soudainement saisie fermement. En levant les yeux, vous voyez le Boss du casino vous toiser, prêt à escorter hors des lieux tout client qui ne respecte pas les règles. En un instant, tous les regards convergent vers vous — étonnés, hostiles, malveillants... Vous réalisez qu'on peut peut-être tricher de nombreuses fois, mais Tant Que l'on est découvert une seule fois, c'est la ruine totale et irrémédiable qui s'ensuit."
  },
  Event_142074_Name = {
    Text = "Casino en effervescence"
  },
  Event_142103_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142103_Desc = {
    Text = "Vous réussissez à vous échapper du casino par la force. Le vacarme de la foule reste derrière vous tandis que vous accélérez le pas pour partir — quant au chaos laissé sur place, quelqu'un d'autre s'en chargera bien."
  },
  Event_142103_Name = {
    Text = "Casino en effervescence"
  },
  Event_142105_ChoiceDesc1 = {
    Text = "[Retirer une fois] Obtenir une Carte de symptômes"
  },
  Event_142105_ChoiceDesc2 = {
    Text = "[Partir] Obtenir 75 Marques noires"
  },
  Event_142105_Desc = {
    Text = "Vous tentez votre chance une fois — rien ne se passe. Mais au dos de la carte, il est écrit : «La prochaine fois sera plus facile»\n... Voulez-vous réessayer ?"
  },
  Event_142105_Name = {
    Text = "Défi de la loterie"
  },
  Event_142106_ChoiceDesc1 = {
    Text = "[Retirer une fois] Obtenir une Carte de symptômes"
  },
  Event_142106_ChoiceDesc2 = {
    Text = "[Partir] Obtenir 75 Marques noires"
  },
  Event_142106_Desc = {
    Text = "Vous tentez votre chance une fois — rien ne se passe. Mais au dos de la carte, il est écrit : «La prochaine fois sera plus facile»\n... Voulez-vous réessayer ?"
  },
  Event_142106_Name = {
    Text = "Défi de la loterie"
  },
  Event_142107_ChoiceDesc1 = {
    Text = "[Retirer une fois] Obtenir une Carte de symptômes"
  },
  Event_142107_Desc = {
    Text = "Vous tentez votre chance une fois — rien ne se passe. Mais au dos de la carte, il est écrit : «La prochaine fois sera plus facile»\n... Voulez-vous réessayer ?"
  },
  Event_142107_Name = {
    Text = "Défi de la loterie"
  },
  Event_142108_ChoiceDesc1 = {
    Text = "[Retirer une fois] Obtenir une Carte de symptômes"
  },
  Event_142108_ChoiceDesc2 = {
    Text = "[Partir] Obtenir 75 Marques noires"
  },
  Event_142108_Desc = {
    Text = "Vous tentez votre chance une fois — rien ne se passe. Mais au dos de la carte, il est écrit : «La prochaine fois sera plus facile»\n... Voulez-vous réessayer ?"
  },
  Event_142108_Name = {
    Text = "Défi de la loterie"
  },
  Event_142109_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142109_Desc = {
    Text = "En écoutant les battements de votre cœur, vous dévoilez le ticket de loterie, et des caractères dorés éblouissants sautent à vos yeux. Le Vendeur ambulant agite sa clochette avec Excitation, et tous les passants vous lancent des regards envieux.\n«Le grand lot a été tiré !»"
  },
  Event_142109_Name = {
    Text = "Défi de la loterie"
  },
  Event_142110_ChoiceDesc1 = {
    Text = "[Retirer une fois] Obtenir une Carte de symptômes"
  },
  Event_142110_ChoiceDesc2 = {
    Text = "[Partir] Obtenir 75 Marques noires"
  },
  Event_142110_Desc = {
    Text = "Vous tentez votre chance une fois — rien ne se passe. Mais au dos de la carte, il est écrit : «La prochaine fois sera plus facile»\n... Voulez-vous réessayer ?"
  },
  Event_142110_Name = {
    Text = "Défi de la loterie"
  },
  Event_142118_ChoiceDesc1 = {
    Text = "[Échange de biens] Retirer 1 Relique, 25% de Probabilité d'obtenir 1 Pendule temporel au choix parmi 3, 50% de Probabilité d'obtenir 2 Créations en or aléatoires, 25% de Probabilité d'obtenir 25 Marques noires"
  },
  Event_142118_ChoiceDesc2 = {Text = "[Leave]"},
  Event_142118_Desc = {
    Text = "Le Marchand prend l'objet que vous lui tendez et l'examine sous la lumière de la lune, dans tous les sens, les yeux écarquillés. Après une longue attente, il finit par esquisser un sourire et sort de son sac une boîte en fer rouillée. «Allez, ouvrez-la donc, c'est la boîte mystère la plus tendance du moment.»\nVous l'ouvrez, mais vous découvrez qu'elle ne contient que quelques Marques Noires décevantes. Le Marchand se frotte les mains et vous présente ses excuses du regard, vous assurant que vous pouvez réessayer."
  },
  Event_142118_Name = {
    Text = "Marchand ambulant en haillons"
  },
  Event_142119_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142119_Desc = {
    Text = "Le Marchand prend l'objet que vous lui tendez et l'examine sous la lumière de la lune, dans tous les sens, les yeux écarquillés. Après une longue attente, il finit par esquisser un sourire et sort de son sac une boîte en fer rouillée. «Allez, ouvrez-la donc, c'est la boîte mystère la plus tendance du moment.»\nVous l'ouvrez, et quelque chose repose à l'Intérieur."
  },
  Event_142119_Name = {
    Text = "Marchand ambulant en haillons"
  },
  Event_142120_ChoiceDesc1 = {
    Text = "[Échange de biens] Retirer 1 Création en or, 50% de Probabilité d'obtenir 1 Pendule temporel au choix parmi 3, 50% de Probabilité d'obtenir 1 Relique Bénie au choix parmi 3"
  },
  Event_142120_ChoiceDesc2 = {Text = "[Leave]"},
  Event_142120_Desc = {
    Text = "Vous ouvrez à nouveau la boîte mystère, mais vous constatez qu'elle ne contient toujours pas ce que vous cherchez. Le Marchand s'empresse de sourire pour s'excuser et sort une autre boîte en fer qu'il vous tend à deux mains.\n«Ne vous fâchez pas, cher client ! Je vous jure que cette fois, il y a quelque chose d'extraordinaire...» dit-il, tout en glissant discrètement une main vers vous, paume ouverte. «Bien sûr, un trésor s'échange contre un trésor.»"
  },
  Event_142120_Name = {
    Text = "Marchand ambulant en haillons"
  },
  Event_142138_ChoiceDesc1 = {
    Text = "[En emprunter l'usage]"
  },
  Event_142138_ChoiceDesc2 = {Text = "[Leave]"},
  Event_142138_Desc = {
    Text = "Vous avez réussi à utiliser ces outils. Bien qu'ils soient quelque peu endommagés, ils semblent encore utilisables."
  },
  Event_142138_Name = {Text = "Forge"},
  Event_142139_ChoiceDesc1 = {
    Text = "[Fonte brisée] Choisissez 1 Création en or à supprimer, obtenez 2 Créations en argent et 50 Marques noires"
  },
  Event_142139_ChoiceDesc2 = {
    Text = "[Trempe] Choisissez 2 Reliques à supprimer, obtenez la Création en or [(RelicConfig.Arg1)]."
  },
  Event_142139_ChoiceDesc3 = {
    Text = "[Trempe avancée] Choisissez 2 Créations en or à supprimer, obtenez le Pendule temporel [(RelicConfig.Arg1)]."
  },
  Event_142139_Desc = {
    Text = "Vous saisissez le marteau posé là et vous apprêtez à..."
  },
  Event_142139_Name = {Text = "Forge"},
  Event_142140_ChoiceDesc1 = {
    Text = "[En emprunter l'usage]"
  },
  Event_142140_ChoiceDesc2 = {Text = "[Leave]"},
  Event_142140_Desc = {
    Text = "Vous avez réussi à utiliser ces outils. Bien qu'ils soient quelque peu endommagés, ils semblent encore utilisables."
  },
  Event_142140_Name = {Text = "Forge"},
  Event_142141_ChoiceDesc1 = {
    Text = "[Fonte brisée] Choisissez 1 Création en or à supprimer, obtenez 2 Créations en argent et 50 Marques noires"
  },
  Event_142141_ChoiceDesc2 = {
    Text = "[Trempe] Choisissez 2 Reliques à supprimer, obtenez la Création en or [(RelicConfig.Arg1)]."
  },
  Event_142141_ChoiceDesc3 = {
    Text = "[Trempe avancée] Choisissez 2 Créations en or à supprimer, obtenez le Pendule temporel [(RelicConfig.Arg1)]."
  },
  Event_142141_Desc = {
    Text = "Vous saisissez le marteau posé là et vous apprêtez à..."
  },
  Event_142141_Name = {Text = "Forge"},
  Event_142142_ChoiceDesc1 = {
    Text = "[Fonte brisée] Choisissez 1 Création en or à supprimer, obtenez 2 Créations en argent et 50 Marques noires"
  },
  Event_142142_ChoiceDesc2 = {
    Text = "[Trempe] Choisissez 2 Reliques à supprimer, obtenez la Création en or [(RelicConfig.Arg1)]."
  },
  Event_142142_ChoiceDesc3 = {
    Text = "[Trempe avancée] Choisissez 2 Créations en or à supprimer, obtenez le Pendule temporel [(RelicConfig.Arg1)]."
  },
  Event_142142_Desc = {
    Text = "Vous saisissez le marteau posé là et vous apprêtez à..."
  },
  Event_142142_Name = {Text = "Forge"},
  Event_142167_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142167_Desc = {
    Text = "Après trois utilisations, l'enclume s'est complètement enfoncée et le marteau est couvert d'usure. Il semble qu'ils ne puissent plus servir."
  },
  Event_142167_Name = {Text = "Forge"},
  Event_142235_ChoiceDesc1 = {
    Text = "[J'irai de l'avant] Obtenir «Immaculité» — toutes les Cartes d'instruction reçoivent 20 charges permanentes de Renforcement."
  },
  Event_142235_ChoiceDesc2 = {
    Text = "[Je ne ferai pas demi-tour] Obtenir «Sublimation» — le Fragment de clé et la Limite de fureur diminuent définitivement de 20 %."
  },
  Event_142235_Desc = {
    Text = "Un voile de brume s'abat soudainement devant vos yeux, le monde commence à se brouiller, et dans cet état second, une voix s'élève au fond de votre cœur :\n«Voulez-vous continuer d'avancer ?»"
  },
  Event_142235_Name = {
    Text = "La Destination Approche"
  },
  Event_142925_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142925_Desc = {
    Text = "Le personnel du club a accepté le paiement et vous a fourni le service de base. Ils ont emporté les objets que vous leur avez confiés dans une cabine plongée dans l'obscurité. L'attente fut brève ; à son retour, les objets étaient de nouveau posés sur le plateau, semblant légèrement différents de ce qu'ils étaient auparavant."
  },
  Event_142925_Name = {
    Text = "Club Spécial"
  },
  Event_142926_ChoiceDesc1 = {
    Text = "[Supprimer une Création en or] (nécessite une Création en or)"
  },
  Event_142926_ChoiceDesc2 = {
    Text = "[Relique avec Renforcement (Forged) sélectionnable]"
  },
  Event_142926_ChoiceDesc3 = {Text = "[Leave]"},
  Event_142926_Desc = {
    Text = "Test «Quantité de Reliques» «Liste de sélection de Reliques»"
  },
  Event_142927_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142927_Desc = {
    Text = "Le personnel du club a accepté le paiement et vous a fourni le service de luxe. Ils ont solennellement placé vos objets dans un coffret et les ont emportés dans une cabine plongée dans l'obscurité. Vous avez attendu longtemps, jusqu'à ce que l'un d'eux reparaisse et vous remette les objets à deux mains, le visage aussi serein que d'habitude."
  },
  Event_142927_Name = {
    Text = "Club Spécial"
  },
  Event_142928_ChoiceDesc1 = {
    Text = "[Sélectionner jusqu'à 2 Éveilleurs pour remplir leur Fureur]"
  },
  Event_142928_ChoiceDesc2 = {
    Text = "[Il faut choisir 2 Corps éveillés remplis d'Aliemus]"
  },
  Event_142928_ChoiceDesc3 = {Text = "[Leave]"},
  Event_142928_Desc = {
    Text = "Test «Sélection conditionnelle d'Éveilleur»"
  },
  Event_142929_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142929_Desc = {
    Text = "Le chercheur a tourné autour de vous encore et encore, vous observant attentivement pendant un long moment avant de commencer à travailler — sans vous demander votre avis. Un certain temps s'est écoulé, et au moment de quitter cet étrange laboratoire, vous saviez clairement que vous aviez perdu beaucoup de choses, mais il applaudissait pour vous féliciter : «C'est là l'essence même de l'évolution !»"
  },
  Event_142929_Name = {
    Text = "L'Évolutionniste"
  },
  Event_142930_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142930_Desc = {
    Text = "Vous tendez la main pour sonder les eaux écarlates du bassin et y trouvez quelque chose d'utile."
  },
  Event_142930_Name = {
    Text = "Source de Sang"
  },
  Event_142931_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142931_Desc = {
    Text = "La voix s'éloigne, votre cœur se remplit de détermination, et vous sentez la Force faire son Apparition."
  },
  Event_142931_Name = {
    Text = "La Destination Approche"
  },
  Event_142932_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142932_Desc = {
    Text = "La voix s'éloigne, votre cœur se remplit de détermination, et votre esprit s'éclaircit davantage."
  },
  Event_142932_Name = {
    Text = "La Destination Approche"
  },
  Event_142933_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142933_Desc = {
    Text = "Vous avez pris un peu de ce qui s'entassait en montagne parmi les offrandes, puis vous êtes rapidement éclipsé. Au moment de partir, les yeux de la statue semblaient avoir bougé."
  },
  Event_142933_Name = {
    Text = "Autel du gain et de la perte"
  },
  Event_142934_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142934_Desc = {
    Text = "Vous vous êtes entraîné dans la direction défensive. Face aux Embuscades de votre adversaire, vous avez constamment paré avec votre arme, et votre Défense ainsi que vos réflexes se sont améliorés."
  },
  Event_142934_Name = {
    Text = "Séance d'entraînement intensif"
  },
  Event_142935_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142935_Desc = {
    Text = "Le chercheur a enfilé des gants, a pris quelques instruments aux formes étranges sur l'étagère et les a manipulés devant vous. Vous ne savez pas exactement ce qu'il a fait, mais vous vous sentez effectivement un peu plus léger."
  },
  Event_142935_Name = {
    Text = "L'Évolutionniste"
  },
  Event_142936_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142936_Desc = {
    Text = "Vous n'avez pas choisi de direction particulière, et avez combattu sans tenir compte des limites de votre corps, jusqu'à ce que Tout le monde soit épuisé. Vous savez que vous avez beaucoup progressé, mais en contrepartie, vous en avez payé le prix."
  },
  Event_142936_Name = {
    Text = "Séance d'entraînement intensif"
  },
  Event_142937_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142937_Desc = {
    Text = "Vous avez pris quelques objets au hasard dans votre sac pour les offrir en Offrande, et avez reçu une récompense équivalente."
  },
  Event_142937_Name = {
    Text = "Autel du gain et de la perte"
  },
  Event_142938_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142938_Desc = {
    Text = "Vous avez présenté de précieuses offrandes et avez reçu une récompense équivalente."
  },
  Event_142938_Name = {
    Text = "Autel du gain et de la perte"
  },
  Event_142939_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142939_Desc = {
    Text = "Vous étiez plein de doutes quant à ses méthodes de recherche, et après une longue discussion, il a accepté de vous laisser utiliser les instruments vous-même pour poursuivre l'«évolution» à votre façon.\nAvec les mêmes outils, vous avez maladroitement fait «proliférer» en grande quantité ce qui aurait dû être «supprimé». En partant, vous avez entendu les lamentations du chercheur."
  },
  Event_142939_Name = {
    Text = "L'Évolutionniste"
  },
  Event_142940_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142940_Desc = {
    Text = "Le personnel du club vous a offert un service gratuit. Ils ont emporté les objets que vous leur avez confiés dans une cabine plongée dans l'obscurité, et quelques instants plus tard, l'un d'eux est revenu, a déposé les objets dans vos mains sans dire un mot."
  },
  Event_142940_Name = {
    Text = "Club Spécial"
  },
  Event_142941_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142941_Desc = {
    Text = "Vous offrez une grande quantité de Sang au bassin des vœux, et un précieux présent en émerge."
  },
  Event_142941_Name = {
    Text = "Source de Sang"
  },
  Event_142942_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142942_Desc = {
    Text = "Vous vous êtes entraîné dans la direction offensive, et au fil des affrontements, vos techniques d'Attaque et votre vitesse se sont améliorées."
  },
  Event_142942_Name = {
    Text = "Séance d'entraînement intensif"
  },
  Event_142943_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142943_Desc = {
    Text = "Vous offrez un peu de Sang au bassin des vœux, et un présent en émerge."
  },
  Event_142943_Name = {
    Text = "Source de Sang"
  },
  Event_142944_ChoiceDesc1 = {
    Text = "[Choisir d'améliorer une Relique]"
  },
  Event_142944_ChoiceDesc2 = {
    Text = "[Améliorer une Relique aléatoirement]"
  },
  Event_142944_ChoiceDesc3 = {
    Text = "[Partir (test)]"
  },
  Event_142944_Desc = {
    Text = "Test «Fonction d'Amélioration de Relique», la Relique s'ajoute d'elle-même"
  },
  Event_146258_ChoiceDesc1 = {
    Text = "[L'appeler] Obtenir la Créature maudite «(RelicConfig.Arg1)», Infecter «(Skill.Arg2)»"
  },
  Event_146258_ChoiceDesc2 = {
    Text = "[Leur répondre] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : [(EnchantConfig.Arg1)]"
  },
  Event_146258_ChoiceDesc3 = {
    Text = "[Ignorer] Obtenez 50 Marques noires"
  },
  Event_146258_Desc = {
    Text = "Sur l'autel, les robes blanches de Juliette sont baignées d'une épaisse fumée, la cendre de l'encens mêlée à un doux parfum cuivré.\n\n« Le Porteur de Lumière prend en pitié les enfants pécheurs de ce monde... » sa voix n'est pas forte, pourtant elle tranche clairement à travers les prières murmurées du temple, « ...comme une mère aimante prend en pitié le nourrisson dans ses bras. »\n\nÀ la lueur des bougies, les offrandes sur l'autel luisent, grasses et brillantes. Des volutes de fumée bleue s'élèvent en spirale le long de leurs contours, brouillant les visages de la foule en contrebas.\n\nÀ travers cette brume ondoyante, vous regardez vers Pollux. Il se tient parmi les fidèles, les yeux baissés, son visage arborant une piété parfaitement répétée et appliquée."
  },
  Event_146258_Name = {
    Text = "Un Vieux Rêve : III"
  },
  Event_146259_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146259_Desc = {
    Text = "N'y prêtez pas attention. Ce n'est que le hurlement du vent de neige, le soupir du lac gelé, ou le deuil des sommets.\n\nCe sont les branches sèches et mortes qui chuchotent en se frottant les unes contre les autres.\n\nElles murmurent dans un chagrin éternel et mélancolique pour chaque pionnier qui est jamais mort dans les crevasses de glace."
  },
  Event_146259_Name = {
    Text = "Aria du Lac Gelé"
  },
  Event_146260_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146260_Desc = {
    Text = "Si l'équité signifie une parité absolue, Helot : Enchaînée partage-t-elle votre droit à formuler un vœu ?\n\nSi oui, devriez-vous simplement hausser les épaules face à son avance sur vous et à l'élimination de la concurrence ?\n\n«Arrêtez de rêvasser et continuez à grimper !» La voix de Caraboo aboie à votre oreille."
  },
  Event_146260_Name = {
    Text = "Équité Absurde"
  },
  Event_146261_ChoiceDesc1 = {
    Text = "[La montagne craint la Faim]"
  },
  Event_146261_ChoiceDesc2 = {
    Text = "[La montagne craint la perte]"
  },
  Event_146261_ChoiceDesc3 = {
    Text = "[La montagne craint la mort]"
  },
  Event_146261_Desc = {
    Text = "Vous marchez sur le corps de la montagne. Ses frémissements trahissent ses secrets. Ce que la montagne convoite définit ce que la montagne redoute."
  },
  Event_146261_Name = {
    Text = "Secret de la Montagne"
  },
  Event_146262_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146262_Desc = {
    Text = "Vous vous perdez dans la soie de sa fourrure, captif consentant de vos propres désirs. Caresser le chat est si satisfaisant. Qu'importe ce qui se cache sous la peau ? Est-ce vraiment important ?"
  },
  Event_146262_Name = {
    Text = "Le Chat Noir Rampant"
  },
  Event_146263_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146263_Desc = {
    Text = "Vous prenez silencieusement l'extrémité du fil et l'attachez autour de votre poignet.\n\nPollux fait de même. Bientôt, un mince fil rouge vous unit tous les deux.\n\nCela limite la distance que vous pouvez couvrir, mais vous étiez toujours destinés à vivre et mourir ensemble, n'est-ce pas ?\n\nVous laisserez le destin s'occuper du reste."
  },
  Event_146263_Name = {
    Text = "Un Vieux Rêve : I"
  },
  Event_146264_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146264_Desc = {
    Text = "« Je sais que c'est difficile, mon enfant. Bien sûr que je le sais. Mais le monde n'a jamais été un endroit doux pour aucun d'entre nous. »\n\n« Un jour, le papillon s'échappera de ta paume, et il sera parti pour toujours. »"
  },
  Event_146264_Name = {
    Text = "Illusion, Pas Vérité"
  },
  Event_146265_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146265_Desc = {
    Text = "William lève les yeux, son regard vous effleure avant de se poser sur les crêtes chargées de neige au loin.\n\n«Vous n'avez pas à vous excuser,» dit-il doucement, mais fermement. «Certaines questions m'appartiennent seul, et seul moi peut y répondre.\"\n\n«Mais merci. Pour votre regard aiguisé."
  },
  Event_146265_Name = {
    Text = "Submersion Douce"
  },
  Event_146266_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146266_Desc = {
    Text = "Les yeux de William vacillent.\n\nVous ouvrez la bouche, mais choisissez de ne rien dire. Le silence est le meilleur choix ici. Il existe encore une rare et tranquille complicité entre vous deux ; inutile de la gâcher."
  },
  Event_146266_Name = {
    Text = "Submersion Douce"
  },
  Event_146267_ChoiceDesc1 = {
    Text = "[Partir] Obtient une relique d'argent[(RelicConfig.Arg1)]"
  },
  Event_146267_Desc = {
    Text = "«Rends-le, rends-le ! C'est mon pouvoir !\"\n\nLa montagne pleure ; la montagne se lamente. Elle ne peut supporter d'être dépouillée de tout ce qu'elle possédait autrefois."
  },
  Event_146267_Name = {
    Text = "Secret de la Montagne"
  },
  Event_146268_ChoiceDesc1 = {
    Text = "[Continuer à Courir] Graver l'Oraison «(EnchantConfig.Arg1)» sur 1 parmi 3 Cartes d'instruction, mais développer «(Skill.Arg2)»"
  },
  Event_146268_ChoiceDesc2 = {
    Text = "[Patienter] Obtenir 1 parmi 3 Oraisons"
  },
  Event_146268_ChoiceDesc3 = {
    Text = "[S'Éclipser Doucement]"
  },
  Event_146268_Desc = {
    Text = "« Attention, Castor. Le corbeau nous observe. »\n\nVous vous précipitez en avant, Pollux sur votre dos. Ses yeux paniqués balaient chaque recoin sombre, ne trouvant rien.\n\n« Au-dessus de nous ! »\n\nUn frisson soudain vous parcourt. Vous levez les yeux.\n\nTapi silencieusement dans l'ombre des avant-toits se trouve un corbeau. Des yeux grotesques couvrent son corps, regardant dans toutes les directions, concentrant maintenant leur regard entièrement sur vous deux."
  },
  Event_146268_Name = {
    Text = "Un Vieux Rêve : II"
  },
  Event_146269_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146269_Desc = {
    Text = "Vous vous souvenez des avertissements de votre formation : ne jamais se fier entièrement à la corde de sécurité.\n\nVous repoussez la paroi rocheuse et parvenez désespérément à contrôler votre descente. Mais quelque chose glisse de votre sac, dégringolant le long de la falaise jusqu'à n'être plus qu'un minuscule point invisible.\n\nPeu importe. Au moins, vous êtes en vie."
  },
  Event_146269_Name = {
    Text = "Chute Silencieuse"
  },
  Event_146270_ChoiceDesc1 = {
    Text = "[Listen Closely] Gagnez une relique en argent \"(RelicConfig.Arg1)\" et infligez \"(Skill.Arg2)\"."
  },
  Event_146270_ChoiceDesc2 = {
    Text = "[Plug Ears] Obtenir une Oraison à 3 choix"
  },
  Event_146270_Desc = {
    Text = "Le vent et la neige s'abattent contre la paroi rocheuse, se mêlant aux craquements spectraux et ténus qui montent des profondeurs de la glace, se brisant en une série de soupirs plaintifs.\n\nSeul dans les hauteurs silencieuses, vous entendez soudain la mélodie de la montagne.\n\nElle est désolée et solennelle — un chant grave et profond destiné aux seuls morts."
  },
  Event_146270_Name = {
    Text = "Phantasia de la Nature"
  },
  Event_146271_ChoiceDesc1 = {
    Text = "[C'est la cloche] Développer «(Skill.Arg1),» graver l'Oraison «(EnchantConfig.Arg2)» sur 1 Carte d'instruction aléatoire"
  },
  Event_146271_ChoiceDesc2 = {
    Text = "[C'est la nourriture] Développer «(Skill.Arg1),» graver l'Oraison «(EnchantConfig.Arg2)» sur 1 Carte d'instruction aléatoire"
  },
  Event_146271_ChoiceDesc3 = {
    Text = "[C'est l'anticipation du chien] Graver l'Oraison «(EnchantConfig.Arg1)» sur 1 Carte d'instruction aléatoire"
  },
  Event_146271_Desc = {
    Text = "«Pavlov sonne la cloche, puis nourrit le chien. Avec le temps, le simple tintement de la cloche suffit à faire saliver le chien.»\n\n«Alors. Qu'est-ce qui fait vraiment saliver le chien ?»"
  },
  Event_146271_Name = {
    Text = "Réflexe Pavlovien"
  },
  Event_146272_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146272_Desc = {
    Text = "Ne regardez pas en arrière. William est là, à portée de main. Ne laissez pas le chagrin vous engloutir. Vous avez manqué beaucoup de choses, mais vous pouvez encore arranger cela."
  },
  Event_146272_Name = {
    Text = "De l'Autre Rive"
  },
  Event_146273_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146273_Desc = {
    Text = "« Ferme la main.\n\n« Ce qui était autrefois exquis se dissoudra en rien d'autre que de la boue noire dans ta prise. »"
  },
  Event_146273_Name = {
    Text = "Illusion, Pas Vérité"
  },
  Event_146274_ChoiceDesc1 = {
    Text = "[Hé ! Faites Demi-tour !] Gagner 50 Marques noires"
  },
  Event_146274_ChoiceDesc2 = {
    Text = "[Caresser le Chat] Gagner 75 Marques noires, mais développer «(Skill.Arg2)»"
  },
  Event_146274_Desc = {
    Text = "<Italic:« Miaou. »> Un chat noir aux yeux d'un jade éclatant frotte sa tête contre votre tibia à pas feutrés et silencieux.\n\nÀ cet instant, vous réalisez que « N » a disparu."
  },
  Event_146274_Name = {
    Text = "Le Chat Noir Rampant"
  },
  Event_146275_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146275_Desc = {
    Text = "Vous ne faites aucun bruit. Vous laissez simplement votre regard dériver à travers la brume pour se poser sur les yeux de Pollux, refusant de détourner les vôtres.\n\nIl ne fuit pas votre regard non plus. Votre frère a toujours été ainsi — têtu jusqu'au fond de l'âme, refusant d'être le premier à baisser la tête.\n\nLes chants dans la salle, l'odeur de cendre, le sermon de Juliette sur la miséricorde et le sacrifice... soudain, tout cela s'estompe dans le lointain. On dirait qu'il ne reste plus que vous deux, vous regardant l'un l'autre à travers cette salle de pitié creuse, à travers l'immensité du temps."
  },
  Event_146275_Name = {
    Text = "Un Vieux Rêve : III"
  },
  Event_146276_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146276_Desc = {
    Text = "En cet instant, vous êtes le seul gardien de vos longs et pâles souvenirs.\n\nLe Wendigo tend ses griffes semblables à des branches, visant droit vers votre cœur, mais vous le repoussez par la seule force de votre volonté.\n\nIl trébuche, se retirant dans le brouillard dévorant, ne laissant qu'un murmure rauque et sec :\n\n« Tôt ou tard, vous me les offrirez... et vous le ferez de bon gré. »"
  },
  Event_146276_Name = {
    Text = "Le Dévoreur"
  },
  Event_146277_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146277_Desc = {
    Text = "C'est un rêve lointain. Un rêve de votre enfance.\n\n«Reprends-toi,» vous rappelez-vous à vous-même. «Nous ne sommes plus là-bas.»\n\nVous revenez à la réalité, pour vous retrouver debout dans la neige glaciale, encerclé par un anneau de cultistes, avec la lame de Pollux pointée directement sur votre poitrine."
  },
  Event_146277_Name = {
    Text = "Un Vieux Rêve : I"
  },
  Event_146278_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146278_Desc = {
    Text = "« J'accepte que la mort doit venir.\n\n« J'offre volontairement mes os à ce pénible pèlerinage.\n\n« Sous le précipice, le ciel et la terre façonneront mon monument. »"
  },
  Event_146278_Name = {
    Text = "Présage de Mort"
  },
  Event_146279_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146279_Desc = {
    Text = "Un reflet n'est qu'un tour de la lumière. Ce que Tinct a vu n'était probablement que sa propre ombre.\n\nSa planète natale est à des millions d'années-lumière ; la moindre erreur de navigation les aurait dispersés à travers différentes galaxies. En vous réconfortant de ces pensées, vous cessez de vous obséder sur ce qui se trouve sous vos pieds."
  },
  Event_146279_Name = {
    Text = "Le Reflet Englouti"
  },
  Event_146280_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146280_Desc = {
    Text = "Il vient des étoiles. Des profondeurs de l'aube des temps. De choses que l'humanité ne connaît pas encore, et ne connaîtra peut-être jamais.\n\nNe leur demandez pas de réponses.\n\nVous ne connaissez pas le prix."
  },
  Event_146280_Name = {
    Text = "Aria du Lac Gelé"
  },
  Event_146281_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146281_Desc = {
    Text = "Vous vous arrêtez, laissant cette musique lugubre emplir vos oreilles.\n\nLe vent est un violon, la neige cinglante une batterie, et le grondement lointain de la glace qui se fissure une harmonie grave et longtemps réprimée.\n\nVous ne pouvez en déchiffrer le thème, mais vous savez que, que ce soit dans le passé ou dans l'avenir, elle continuera de résonner pour les innombrables voyageurs ensevelis ici."
  },
  Event_146281_Name = {
    Text = "Phantasia de la Nature"
  },
  Event_146283_ChoiceDesc1 = {
    Text = "[Les yeux vers les cieux] Tous les Éveilleurs récupèrent Arg1 points de Fureur"
  },
  Event_146283_ChoiceDesc2 = {
    Text = "[Fouler le pic gelé] Choisir d'Éveiller 2 Éveilleurs"
  },
  Event_146283_Desc = {
    Text = "Le sommet brille en silence derrière un voile de nuages et de brume. Les gouffres, les parois rocheuses à pic, les tempêtes hurlantes — rien de ce qui réside ici n'a jamais été destiné aux yeux des mortels. Face à tout cela, vous êtes si terriblement fragile."
  },
  Event_146283_Name = {
    Text = "Toucher le Sommet"
  },
  Event_146284_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146284_Desc = {
    Text = "«Non, ce n'est pas ta faute. Tu n'es qu'un jouet mécanique, remonté par le destin.»"
  },
  Event_146284_Name = {
    Text = "Rat Glouton"
  },
  Event_146285_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146285_Desc = {
    Text = "«Je vois. Vous êtes du genre à vous fier à l'expérience objective. Mais n'oubliez pas : parfois, sous des apparences identiques, des vérités entièrement différentes se tapissent en silence.»\n\nLe rire de la cloche s'estompe dans le lointain."
  },
  Event_146285_Name = {
    Text = "Réflexe Pavlovien"
  },
  Event_146286_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146286_Desc = {
    Text = "Si l'équité signifie que le bien et le mal sont récompensés à leur juste mesure, alors qui siège en jugement ?\n\nAnubis et sa balance ? Si la gravité des enfers obéit aux lois de la physique, vous n'êtes pas particulièrement confiant que votre cœur soit plus léger que sa plume."
  },
  Event_146286_Name = {
    Text = "Équité Absurde"
  },
  Event_146287_ChoiceDesc1 = {
    Text = "[Exiger des réponses] Obtenir la Création en argent «(RelicConfig.Arg1)», développer «(Skill.Arg2)»"
  },
  Event_146287_ChoiceDesc2 = {
    Text = "[Rester silencieux] Obtenir la Création en argent «(RelicConfig.Arg1)», développer «(Skill.Arg2)»"
  },
  Event_146287_ChoiceDesc3 = {
    Text = "[S'excuser] Gagner 25 Marques noires"
  },
  Event_146287_Desc = {
    Text = "«Senior William, lorsque le sortilège du Wendigo s'est emparé de tous les autres, vous sembliez être le premier à en sortir. Nous sommes sur le point de les affronter directement. Des conseils ?\n»\nLes yeux de William vacillent. En eux, vous entrevoyez fugacement quelque chose d'insaisissable, de mélancolique et de serein — comme un corps dérivant dans des eaux ensoleillées, coulant lentement vers le fond obscur de la mer.\n\n«Désolé,» dit-il. «Je crains de ne pouvoir vous aider en cela.»"
  },
  Event_146287_Name = {
    Text = "Submersion Douce"
  },
  Event_146288_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146288_Desc = {
    Text = "« Si aveugle à l'art, si terriblement aveugle », murmure une sombre silhouette en secouant la tête tandis qu'Elle émerge de l'obscurité. « La vérité pourrait être un poison. Parfois, une illusion bien entretenue est la seule chose qui préserve notre fragile bonheur, n'est-ce pas ? »"
  },
  Event_146288_Name = {
    Text = "Le Chat Noir Rampant"
  },
  Event_146290_ChoiceDesc1 = {
    Text = "[Qui est le meurtrier ?] Développer «(Skill.Arg1),» graver l'Oraison «(EnchantConfig.Arg2)» sur 1 carte aléatoire"
  },
  Event_146290_ChoiceDesc2 = {
    Text = "[C'est ma faute] Développer «(Skill.Arg1),» graver l'Oraison «(EnchantConfig.Arg2)» sur 1 carte aléatoire"
  },
  Event_146290_ChoiceDesc3 = {
    Text = "[C'est le prix de la Gourmandise] Graver l'Oraison «(EnchantConfig.Arg1)» sur 1 des 3 Cartes d'instruction"
  },
  Event_146290_Desc = {
    Text = "<Italic:«Cours, cours, petit rat,\n\nDans les égouts longs et noirs.\n\nRenifle l'air et sens le doux—\n\nUne belle croûte de fromage à croquer.\n\"\n\n\n«Traîne-la chez toi, cours, cours, cours,\n\nVoilà que le bourdonnement a commencé.\n\nBourdonnement, bourdonnement dans ta tête,\n\nBourdonnement, bourdonnement, plein d'effroi.\n\"\n\n\n«Pousse la porte, pousse la porte,\n\nPlus personne ne chuchote désormais.\n\"\n\n«Frères, sœurs, en rang,\n\nVois comme ils peuvent tous rester immobiles.\n\nChaque ventre a un trou,\n\nUn trou creux, un trou creux.»>"
  },
  Event_146290_Name = {
    Text = "Rat Glouton"
  },
  Event_146291_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146291_Desc = {
    Text = "Vous vous agenouillez et essuyez l'humidité de sa joue. Vous ne demandez pas si les larmes sont vraies.\n« Peu importe si elles sont vraies, » dites-vous. « Tu n'as rien à prouver à personne. »\nCaraboo ouvre la bouche, mais la remarque habile et désinvolte qu'elle avait préparée meurt dans sa gorge. Au lieu de cela, le barrage cède. Ses larmes se déversent sans prévenir, chaudes et lourdes contre le dos de votre main."
  },
  Event_146291_Name = {
    Text = "Larmes de Crocodile"
  },
  Event_146292_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146292_Desc = {
    Text = "«Mieux vaut ne pas demander. Il y a des questions qui n'ont pas besoin de réponses.»"
  },
  Event_146292_Name = {
    Text = "Rat Glouton"
  },
  Event_146293_ChoiceDesc1 = {
    Text = "[Interpeller] Obtenir la Création en argent «(RelicConfig.Arg1)», développer «(Skill.Arg2)»"
  },
  Event_146293_ChoiceDesc2 = {
    Text = "[Continuer d'écouter] Tous les Éveilleurs récupèrent 50 Fureur, développer «(Skill.Arg1)»"
  },
  Event_146293_ChoiceDesc3 = {
    Text = "[Ignorer] Obtenir 1 Oraison parmi 3"
  },
  Event_146293_Desc = {
    Text = "Là où Naraka est tombée, il ne reste que les ténèbres.\n\nUne mélodie humide dérive depuis le marécage, froide et pâle comme une paire de mains caressant vos joues avec une tendresse persistante.\n\nElle chuchote doucement : «Viens à moi. Viens à moi dans le silence de la nuit.»"
  },
  Event_146293_Name = {
    Text = "Échos Persistants"
  },
  Event_146294_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146294_Desc = {
    Text = "Vous baissez la tête, laissant la fumée brouiller les contours de Pollux, dissimulant son expression dans la brume gris-blanc.\n\nC'est plus sûr ainsi, vous dites-vous. Inutile de regarder, inutile de penser.\n\nLe sermon de Juliette continue de vous envelopper. Vous fixez vos mains jointes, silencieux.\n\nC'est seulement lorsque la cloche du rituel sonne que vous osez lever les yeux à nouveau.\n\nPollux a maintenu sa posture pieuse tout au long.\n\nÀ travers l'immensité du temps et de l'illusion, vous ne pouvez être certain que quelque chose ne s'est pas échappé en cet instant précis."
  },
  Event_146294_Name = {
    Text = "Un Vieux Rêve : III"
  },
  Event_146295_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146295_Desc = {
    Text = "« Pollux ! »\nLe nom a à peine quitté votre gorge que vous le ravallez. Il se dissout dans la fumée d'encens, n'étant plus qu'un faible soupir à peine audible.\n\nAutour de vous, les chants des fidèles ne fléchissent pas, mais quelques regards discrets, à peine perceptibles, se tournent vers vous.\n\nPollux se raidit instantanément, un éclair de panique traversant ses yeux, vite masqué à nouveau par cette expression soumise et entraînée.\n\nIl ne répond pas. Il garde seulement les yeux baissés, mais ses doigts se crispent silencieusement dans sa manche. Vous savez qu'il vous a entendu."
  },
  Event_146295_Name = {
    Text = "Un Vieux Rêve : III"
  },
  Event_146297_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146297_Desc = {
    Text = "À tout le moins, vous n'auriez pas pu rester là à la regarder se faire exclure seule à l'époque. Laissez les problèmes d'aujourd'hui au moi d'aujourd'hui."
  },
  Event_146297_Name = {
    Text = "Roues dans les Roues"
  },
  Event_146298_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146298_Desc = {
    Text = "«Pollux, nous devrions nous séparer. Nous aurons plus de chances de trouver la lisière des bois de cette façon.\n\"\n«Mais comment te retrouverai-je, frère ?\n\"\nÀ travers le voile des souvenirs, vous voyez son visage empreint de tristesse. Une vive douleur vous tord le cœur. Vous inspirez lentement et profondément.\n\n«Ne t'inquiète pas. Nous sommes jumeaux ; nous pouvons entendre les battements de cœur l'un de l'autre.\n\"\n«Nous ne sommes jamais vraiment séparés.»"
  },
  Event_146298_Name = {
    Text = "Un Vieux Rêve : I"
  },
  Event_146299_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146299_Desc = {
    Text = "Elle juge. Elle interroge. Elle réservera une fin glaciale et silencieuse à tous ceux qui ont osé la défier."
  },
  Event_146299_Name = {
    Text = "Verdict de la Ligne des Neiges"
  },
  Event_146300_ChoiceDesc1 = {
    Text = "[Recommencer] Graver l'Oraison «(EnchantConfig.Arg1)» sur 1 parmi 3 Cartes d'instruction, mais développer «(Skill.Arg2)»"
  },
  Event_146300_ChoiceDesc2 = {
    Text = "[C'est Difficile] Obtenir la Création en argent «(RelicConfig.Arg1),» mais développer «(Skill.Arg2)»"
  },
  Event_146300_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_146300_Desc = {
    Text = "Le Ver lui a enseigné l'art du mensonge. Au-delà de cela, elle n'a rien appris de la survie.\n\nPourtant, un mensonge reste toujours un mensonge ; vient un jour où l'échafaudage doit disparaître, et l'on doit apprendre à se tenir debout sans son soutien."
  },
  Event_146300_Name = {
    Text = "Illusion, Pas Vérité"
  },
  Event_146301_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146301_Desc = {
    Text = "«En effet. Mais comment un rat si petit pourrait-il jamais connaître le prix de sa faim ?»"
  },
  Event_146301_Name = {
    Text = "Rat Glouton"
  },
  Event_146302_ChoiceDesc1 = {
    Text = "[Nouer le Fil Rouge] Supprimer 1 Carte d'instruction, gagner Arg1 Marques noires"
  },
  Event_146302_ChoiceDesc2 = {
    Text = "[Refuser le Fil Rouge] Copier 1 Carte d'instruction, mais développer «(Skill.Arg1)»"
  },
  Event_146302_ChoiceDesc3 = {
    Text = "[Retour à la réalité] Graver l'Oraison «(EnchantConfig.Arg1)» sur 1 des 3 Cartes d'instruction"
  },
  Event_146302_Desc = {
    Text = "Le premier rêve. La forêt. Vous et votre frère, à peine dix ans, abandonnés au cœur des bois sombres et profonds par Dame Lanterne.\n\n<Italic:«Une fois la nuit tombée, les bêtes endormies commenceront à chasser. Fuyez avant cela. Seuls ceux qui s'en sortent auront le droit d'être mes bons enfants.>\n\nVotre frère saisit votre main et sort un bout de fil rouge.\n\n«Castor, attachons nos mains ensemble. Comme ça, nous ne nous perdrons pas.»"
  },
  Event_146302_Name = {
    Text = "Un Vieux Rêve : I"
  },
  Event_146304_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146304_Desc = {
    Text = "Vous entendez des rires.\n\nEspiègle, moqueur, empli d'amusement.\n\nLa lutte désespérée de l'humanité pour explorer le cosmos n'est, à leurs yeux, rien de plus que le rampement des fourmis."
  },
  Event_146304_Name = {
    Text = "Ceux Sous le Regard"
  },
  Event_146306_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146306_Desc = {
    Text = "Elle purifie. Elle efface. Elle rassemblera dans sa douce étreinte tous ceux qui grimpent et ne reviennent jamais."
  },
  Event_146306_Name = {
    Text = "Verdict de la Ligne des Neiges"
  },
  Event_146307_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146307_Desc = {
    Text = "Vous et le corbeau vous défiez du regard.\n\nIl est évident que vous ne gagnerez pas cette impasse.\n\nMais alors, face à Juliette, on dirait que vous ne gagnez jamais."
  },
  Event_146307_Name = {
    Text = "Un Vieux Rêve : II"
  },
  Event_146308_ChoiceDesc1 = {
    Text = "[Qui m'observe ?] Éveiller aléatoirement 1 Éveilleur, développer «(Skill.Arg1)»"
  },
  Event_146308_ChoiceDesc2 = {
    Text = "[Se concentrer sur le présent] Choisir 1 Carte d'instruction parmi 3 à Graver : «(EnchantConfig.Arg1)»"
  },
  Event_146308_Desc = {
    Text = "Un vent glacial chargé de neige hurle à travers ce sanctuaire des hauteurs, vierge de toute empreinte humaine.\n\nVous levez les yeux. Plus haut encore, il n'y a que l'éternel soleil impassible.\n\nPourtant vous savez que quelque part plus haut, plus loin encore, d'innombrables yeux s'ouvrent et se ferment.\n\nEt quelques-uns de ces yeux observent silencieusement l'ensemble du monde sous vos pieds."
  },
  Event_146308_Name = {
    Text = "Ceux Sous le Regard"
  },
  Event_146309_ChoiceDesc1 = {
    Text = "[Je N'arrive Toujours Pas à Lâcher Prise] Obtenir la Créature maudite «(RelicConfig.Arg1),» mais développer «(Skill.Arg2)»"
  },
  Event_146309_ChoiceDesc2 = {
    Text = "[J'ai Oublié] Graver l'Oraison «(EnchantConfig.Arg1)» sur 1 carte aléatoire"
  },
  Event_146309_Desc = {
    Text = "Vous tentez de fermer les chambres de la mémoire. Dans ce coffret secret se trouvent toutes les réponses qui vous définissent — chaque pulsion honteuse, chaque fantasme caché. Mais le désir est une malédiction inconsciente, une obsession trop douce pour y résister."
  },
  Event_146309_Name = {
    Text = "Malédiction Subconsciente"
  },
  Event_146310_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146310_Desc = {
    Text = "William évite votre regard.\n«L'esprit est notre seul bouclier contre l'illusion. Mais un esprit est forgé par toute une vie d'expériences. Il ne peut être partagé, et il ne peut être enseigné.\"\n\n«La seule chose que je puisse vous dire est ceci : ne laissez pas votre propre faiblesse vous engloutir.»"
  },
  Event_146310_Name = {
    Text = "Submersion Douce"
  },
  Event_146311_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146311_Desc = {
    Text = "«Je vois. Vous êtes du genre à vouloir faire le philosophe. Mais n'oubliez pas : l'absence d'espoir ne signifie pas l'absence de douleur.»\nLe rire de la cloche s'estompe dans le lointain."
  },
  Event_146311_Name = {
    Text = "Réflexe Pavlovien"
  },
  Event_146312_ChoiceDesc1 = {
    Text = "[Partir] Infection[(Skill.Arg1)], obtenez 50 sigils noirs"
  },
  Event_146312_Desc = {
    Text = "«Faim, tellement faim.»\n\n\nLa montagne pleure ; la montagne se lamente. Elle ne peut supporter le vaste et creux néant en son ventre."
  },
  Event_146312_Name = {
    Text = "Secret de la Montagne"
  },
  Event_146313_ChoiceDesc1 = {
    Text = "[Chercher un appui] Supprimer 1 Carte d'instruction, soigner Arg1 PV"
  },
  Event_146313_ChoiceDesc2 = {
    Text = "[Saisir la corde de sécurité] Obtenir la Création en or «(RelicConfig.Arg1)», développer «(Skill.Arg2)»"
  },
  Event_146313_Desc = {
    Text = "Un kaléidoscope d'hallucinations tourbillonne dans votre esprit.\n\nD'abord, de la poudreuse. Puis, une corniche qui s'effondre.\n\nVous ne pouvez pas arrêter votre glissade ; la corde de sécurité crépite avec un éclat aveuglant contre son mousqueton en se dérobant. Mais face aux montagnes, elle est si terriblement petite, si fragile."
  },
  Event_146313_Name = {
    Text = "Chute Silencieuse"
  },
  Event_146314_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146314_Desc = {
    Text = "Viens à moi dans tes rêves. Laisse-moi vivre ma vie une fois encore.\n\nLe gramophone laisse échapper un soupir plaintif. Puis, le son d'une respiration se fond dans l'obscurité. Il ne reste que l'écho. Seulement l'écho."
  },
  Event_146314_Name = {
    Text = "Échos Persistants"
  },
  Event_146315_ChoiceDesc1 = {
    Text = "[Regretter le Choix] Obtenir la Création en argent «(RelicConfig.Arg1)»"
  },
  Event_146315_ChoiceDesc2 = {
    Text = "[Laisser faire le Destin] Obtenir la Création en or «(RelicConfig.Arg1)», développer «(Skill.Arg2)»"
  },
  Event_146315_Desc = {
    Text = "Vous avez toujours su que ce voyage ne serait pas simple. La plupart des grimpeurs de cette expédition nourrissent leurs propres sombres desseins.\n\nPourtant, en regardant le sourire maniaque et moqueur qui s'étale sur le visage de Caraboo, vous ressentez encore le craquement soudain et net de quelque chose qui se brise dans votre poitrine.\n\nPeut-être que, lorsque Naraka a voulu l'exclure du groupe, vous auriez dû faire un choix différent."
  },
  Event_146315_Name = {
    Text = "Roues dans les Roues"
  },
  Event_146316_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146316_Desc = {
    Text = "Combien ont été engloutis par cet endroit ?\n\nDes mains noires surgissent de l'épaisse mare visqueuse, cherchant à vous entraîner dans leur monde. Mais vous continuez simplement à marcher. Elles ne font rien pour vous arrêter, glissant silencieusement vers les profondeurs.\n\nLe sommet vous attend encore, devant vous."
  },
  Event_146316_Name = {
    Text = "Échos Persistants"
  },
  Event_146317_ChoiceDesc1 = {
    Text = "[Détourner le regard] Gagner 25 Marques noires"
  },
  Event_146317_ChoiceDesc2 = {
    Text = "[Regarder de plus près] Obtenir la Création en argent «(RelicConfig.Arg1)», développer «(Skill.Arg2)»"
  },
  Event_146317_Desc = {
    Text = "Suivant le regard de Tinct, vous ne pouvez vous empêcher de plonger les yeux dans les profondeurs du lac.\n\nQu'est-ce qui la tient ainsi envoûtée ?\n\nVous ne pouvez le dire. La glace est trouble et sombre, ne reflétant rien d'autre que votre propre ombre."
  },
  Event_146317_Name = {
    Text = "Le Reflet Englouti"
  },
  Event_146318_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146318_Desc = {
    Text = "La seule façon d'arrêter la faim est de lâcher prise. Nul ne peut perdre ce qu'il ne tient pas. Le Wendigo découvre ses dents, laissant échapper un grognement frustré, et se glisse de nouveau dans le brouillard."
  },
  Event_146318_Name = {
    Text = "Malédiction Subconsciente"
  },
  Event_146319_ChoiceDesc1 = {
    Text = "[La neige me purifiera] Améliorer aléatoirement la qualité de l'Oraison d'1 Carte"
  },
  Event_146319_ChoiceDesc2 = {
    Text = "[La neige me jugera] Choisir 1 Carte d'instruction parmi 3 à Graver : «(EnchantConfig.Arg1)», développer «(Skill.Arg2)»"
  },
  Event_146319_Desc = {
    Text = "Devant vous s'étend la dernière ascension, où la ligne des neiges éternelles, froide et sans fin, se perd dans le lointain.\n\nLa neige est d'un blanc aveuglant et éclatant. Ici, même la mort paraît propre."
  },
  Event_146319_Name = {
    Text = "Verdict de la Ligne des Neiges"
  },
  Event_146320_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146320_Desc = {
    Text = "Ne manquez aucun détail de la vision. Gravez-les dans votre esprit. Gravez le vide soudain, la douleur creuse, et le chagrin vif qui a suivi. Ne les laissez jamais, jamais partir."
  },
  Event_146320_Name = {
    Text = "De l'Autre Rive"
  },
  Event_146321_ChoiceDesc1 = {
    Text = "[Combattre Ensemble] Obtenir la Création en argent «(RelicConfig.Arg1)»"
  },
  Event_146321_ChoiceDesc2 = {
    Text = "[La Réconforter] Obtenir la Création en or «(RelicConfig.Arg1),» mais développer «(Skill.Arg2)»"
  },
  Event_146321_Desc = {
    Text = "La montagne frémit, bête mourante. Une chair pâle et segmentée jaillit de la pierre fracturée, s'enroulant et grimpant, projetant Caraboo à terre.\n\nLorsqu'elle se relève, des traces humides marquent ses joues couvertes de poussière. Sont-ce des larmes de douleur ? Impossible à dire.\n\nTant de mensonges ont coulé de ses lèvres ; qui peut faire confiance aux larmes d'un crocodile ?"
  },
  Event_146321_Name = {
    Text = "Larmes de Crocodile"
  },
  Event_146322_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146322_Desc = {
    Text = "Vous ne posez aucune question. Vous prenez simplement place à ses côtés.\n« Lève-toi, » dites-vous. « Tu n'es qu'à mi-chemin de ton numéro. N'abandonne pas maintenant. »\nCaraboo hésite, puis s'essuie le visage d'une main brusque et soudaine. Elle se relève en chancelant, les jointures blanchies sur son arme, pour faire face à la gueule béante et cramoisie à vos côtés.\nElle a dit tant de mensonges qu'elle-même ne peut plus distinguer quelles larmes sont de l'eau et lesquelles sont du sel. Mais pour l'instant, personne ne tient le compte."
  },
  Event_146322_Name = {
    Text = "Larmes de Crocodile"
  },
  Event_146323_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146323_Desc = {
    Text = "«Je vois. Vous êtes du genre à vous enorgueillir de percer les illusions à jour. Mais n'oubliez pas : en ce bref instant de réalité, la nourriture n'existait que dans votre mémoire, et votre désir.»\nLe rire de la cloche s'estompe dans le lointain."
  },
  Event_146323_Name = {
    Text = "Réflexe Pavlovien"
  },
  Event_146324_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146324_Desc = {
    Text = "Vous ralentissez le pas, adoucissant vos foulées.\n\nDoucement, lentement, sans un bruit...\n\nVous glissez au coin suivant et disparaissez.\n\nLe corbeau vous a-t-il jamais suivi ?\n\nVous ne vous en souvenez plus."
  },
  Event_146324_Name = {
    Text = "Un Vieux Rêve : II"
  },
  Event_146325_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146325_Desc = {
    Text = "La mélodie s'interrompt.\n\nDu marécage noir, une paire d'yeux avides et humides s'ouvre pour vous regarder. Ils murmurent des mots que vous ne pouvez distinguer, puis se ferment, lentement, lentement."
  },
  Event_146325_Name = {
    Text = "Échos Persistants"
  },
  Event_146326_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146326_Desc = {
    Text = "Vous ne vous attardez pas. Laissant la mélodie derrière vous, vos bottes écrasent la neige, produisant un son plus pressé que le vent lui-même.\n\nPourtant, quelle que soit votre allure, cet air désolé s'accroche obstinément à vos talons, sans jamais prendre de retard.\n\nVous ne pouvez lui échapper — c'est le souffle de la montagne elle-même. Et vous n'êtes qu'un minuscule auditeur de passage qui l'a entendu par hasard."
  },
  Event_146326_Name = {
    Text = "Phantasia de la Nature"
  },
  Event_146327_ChoiceDesc1 = {
    Text = "[L'Écouter] Choisir 1 parmi 3 Cartes d'instruction à Graver : «(EnchantConfig.Arg1)», développer «(Skill.Arg2)»"
  },
  Event_146327_ChoiceDesc2 = {
    Text = "[N'y Prêter Aucune Attention] Pour chaque Éveilleur avec une Fureur de 50 ou plus, gagner 15 Marques noires"
  },
  Event_146327_ChoiceDesc3 = {
    Text = "[Partir de force] Obtient 3 choix 1 oraison"
  },
  Event_146327_Desc = {
    Text = "Un chant lointain dérive sur le vent.\n\nIl semble venir de toutes les directions, ou peut-être des profondeurs de la terre.\n\nQuelle que soit la direction vers laquelle vous vous tournez pour le suivre, il résonne dans vos oreilles avec la même intensité implacable."
  },
  Event_146327_Name = {
    Text = "Aria du Lac Gelé"
  },
  Event_146328_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146328_Desc = {
    Text = "« Ô étoile de mauvais augure, ce n'est pas l'heure de ton éclat. »\n\n« Mon pèlerinage a des fins qu'il n'a pas encore atteintes. »\n\n« Éteins-toi, ne serait-ce que pour l'instant, et laisse la paix revenir dans le ciel de cette nuit. »"
  },
  Event_146328_Name = {
    Text = "Présage de Mort"
  },
  Event_146329_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146329_Desc = {
    Text = "Une vague de regret inutile vous submerge. Mais nous sommes toujours contraints de nettoyer les dégâts laissés par nos anciens moi."
  },
  Event_146329_Name = {
    Text = "Roues dans les Roues"
  },
  Event_146330_ChoiceDesc1 = {
    Text = "[Mordre] Éveille aléatoirement 1 Corps éveillé, contamine [(Skill.Arg1)]"
  },
  Event_146330_ChoiceDesc2 = {
    Text = "[Refuse] Gagnez 1 parmi 3 Oraisons"
  },
  Event_146330_Desc = {
    Text = "Au plus profond du brouillard chargé de neige se tapît une silhouette squelettique, la peau sèche et craquelée tendue sur des côtes saillantes. Sur sa tête, des bois noueux et desséchés percent le brouillard. Un grondement creux et affamé résonne depuis son ventre.\n\nLorsque vos regards se croisent, des images fragmentées tourbillonnent dans ses orbites creuses — vos souvenirs. Il a déjà capté l'odeur ; il en a déjà goûté.\n\n« Pas assez, jamais assez... » grogne-t-il d'un son rauque et sec. Il tend une main desséchée, dans une posture presque... suppliante."
  },
  Event_146330_Name = {
    Text = "Le Dévoreur"
  },
  Event_146332_ChoiceDesc1 = {
    Text = "[Effectuer l'Inhumation Céleste] Obtenir la Création en argent «(RelicConfig.Arg1)»"
  },
  Event_146332_ChoiceDesc2 = {
    Text = "[Dispel] Obtenez 75 marques noires, infection [(Skill.Arg2)]"
  },
  Event_146332_Desc = {
    Text = "Portés par les courants thermiques ascendants, des gypaètes barbus décrivent des cercles, patrouillant leur domaine. Parmi ceux qui grimpent, cela a toujours été un mauvais présage.\n\n« Ils cherchent leur nourriture. Un vautour sent l'approche de la mort. »"
  },
  Event_146332_Name = {
    Text = "Présage de Mort"
  },
  Event_146333_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146333_Desc = {
    Text = "Faites confiance à vos jambes. Vous allez conquérir ce sommet."
  },
  Event_146333_Name = {
    Text = "Toucher le Sommet"
  },
  Event_146334_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146334_Desc = {
    Text = "Au moment où le désir s'embrase, vous savez que vous ne pouvez pas le combattre. Vous ne pouvez que regarder tandis qu'il pénètre dans les voûtes longtemps scellées de votre esprit. Des crocs pâles et acérés s'enfoncent dans vos tempes, arrachant vos souvenirs, image par image, jusqu'à leurs racines mêmes."
  },
  Event_146334_Name = {
    Text = "Malédiction Subconsciente"
  },
  Event_146335_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146335_Desc = {
    Text = "Il se penche, son museau effleurant presque votre front, vous respirant avec une dévotion ravie et enivrée, comme si vous étiez le miel le plus doux.\n\nVos angoisses agitées et bouillonnantes sont léchées jusqu'à disparaître de votre esprit.\n\nIl recule avec un bourdonnement grave et satisfait, une lueur sauvage et séduisante vacillant dans ses yeux creux. Votre poitrine semble vide à présent, un morceau manquant — et pourtant, étrangement, vous vous sentez plus léger."
  },
  Event_146335_Name = {
    Text = "Le Dévoreur"
  },
  Event_146336_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146336_Desc = {
    Text = "« Faites attention où vous mettez les pieds. Assurez-vous que chaque pas est solide », la voix de Naraka résonne à votre oreille. « Ne comptez pas sur les autres pour vous rattraper quand vous tombez. »"
  },
  Event_146336_Name = {
    Text = "Ceux Sous le Regard"
  },
  Event_146337_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146337_Desc = {
    Text = "L'humanité appartient aux cieux. Un véritable but fait oublier le vide abyssal en contrebas. Le ciel est ouvert, attendant juste au-dessus."
  },
  Event_146337_Name = {
    Text = "Toucher le Sommet"
  },
  Event_146338_ChoiceDesc1 = {
    Text = "[Laisser Partir les Hommages] Obtenir la Création en or «(RelicConfig.Arg1),» mais développer «(Skill.Arg2)»"
  },
  Event_146338_ChoiceDesc2 = {
    Text = "[S'Accrocher à la Pain] Obtenir 1 parmi 3 Créations en or, mais développer «(Skill.Arg1)»"
  },
  Event_146338_ChoiceDesc3 = {
    Text = "[Partir] Obtient une relique d'argent[(RelicConfig.Arg1)]"
  },
  Event_146338_Desc = {
    Text = "La personne qui a autrefois assassiné William se tient maintenant devant vous.\n\nDans l'air stagnant et nauséabond de la tente d'Aram, les souvenirs s'élèvent comme des fantômes : la forme exsangue et flottante de William ; son visage pâle tourné vers le haut ; et sur la table, la coquille disséquée et creuse de cette petite lanterne."
  },
  Event_146338_Name = {
    Text = "De l'Autre Rive"
  },
  Event_146339_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146339_Desc = {
    Text = "La corde de sécurité cède instantanément sous votre poids.\n\nVous vous écrasez lourdement dans un banc de neige, chaque organe hurlant une protestation sourde et atroce. Vous forcez vos yeux à s'ouvrir malgré la douleur vertigineuse, pour vous retrouver face à face avec un squelette sans nom.\n\nAu fond de ses orbites vides et creuses, quelque chose scintille."
  },
  Event_146339_Name = {
    Text = "Chute Silencieuse"
  },
  Event_146340_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146340_Desc = {
    Text = "Il n'y a pas d'issue. Vous serrez les dents et vous élancez, tentant désespérément de distancer votre surveillant. Le corbeau pousse un cri strident, bat des ailes et vous suit sans effort depuis les airs, allant même jusqu'à revenir en arrière pour vous narguer. Un froid désespoir s'infiltre sous votre peau sous son regard.\n\nVous ne pouvez pas leur échapper."
  },
  Event_146340_Name = {
    Text = "Un Vieux Rêve : II"
  },
  Event_146341_ChoiceDesc1 = {
    Text = "[On récolte ce que l'on sème] Une Carte d'instruction aléatoire gagne l'Oraison : «(EnchantConfig.Arg1)»"
  },
  Event_146341_ChoiceDesc2 = {
    Text = "[Parité absolue] Augmenter les PV Max de Arg1, développer «(Skill.Arg2)»"
  },
  Event_146341_Desc = {
    Text = "Suspendu à la paroi rocheuse abrupte, une question totalement sans rapport vous traverse soudainement l'esprit : Qu'est-ce que l'équité ?"
  },
  Event_146341_Name = {
    Text = "Équité Absurde"
  },
  Event_146342_ChoiceDesc1 = {
    Text = "[Partir] Infection[(Skill.Arg1)], obtenez 50 sigils noirs"
  },
  Event_146342_Desc = {
    Text = "«Je ne peux pas mourir ! Pas encore !\"\nLa montagne pleure ; la montagne se lamente. Dans son avidité insatiable, elle a dévoré son propre lendemain."
  },
  Event_146342_Name = {
    Text = "Secret de la Montagne"
  },
  Event_146343_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146343_Desc = {
    Text = "Vous vous penchez jusqu'à ce que votre joue touche la glace.\n\nUn froid profond et mordant s'infiltre à travers votre peau jusque dans vos os, vous faisant frissonner. Quelque chose d'insondable et de lent roule sous la surface gelée. Est-ce un courant, ou quelque chose de vivant ?\n\nQuoi qu'il en soit, cela n'a rien à voir avec votre voyage."
  },
  Event_146343_Name = {
    Text = "Le Reflet Englouti"
  },
  Event_148532_ChoiceDesc1 = {
    Text = "[Recevoir la Bénédiction] Au début du combat, ajoutez 1 «Fruit Protéiforme» aléatoire à votre deck."
  },
  Event_148532_Desc = {
    Text = "La vaste plaine enneigée s'étend à perte de vue, le vent glacial n'emporte pas le moindre son. Une silhouette fantomatique aux origines indéfinissables surgit silencieusement, tendant un fruit encore tiède.\nSon doux parfum, mêlé à la brume, envahit les narines engourdies du voyageur.\nCes terres des Prisonniers de la Neige sont depuis longtemps imprégnées de mort ; dans l'air flotte une odeur nauséabonde de putréfaction et de froid glacial. Seul ce fruit au creux de la paume, gorgé de vie, ressemble à la promesse séduisante d'une jeune fille."
  },
  Event_148532_Name = {
    Text = "Mirage Céleste"
  },
  Event_20778_ChoiceDesc1 = {
    Text = "[Give It to Her] Tous les Réveillants récupèrent l'Aliemus d'Arg1"
  },
  Event_20778_ChoiceDesc2 = {
    Text = "[Require Support] Choisissez de Réveiller 2 Réveilleurs"
  },
  Event_20778_Desc = {
    Text = "\"Ceci est une communication de Mythag. Fluctuation aberrante de l'index gnostique détectée chez l'Éveilleur. Avez-vous besoin de soutien ?\""
  },
  Event_20778_Name = {
    Text = "Soutien de communication"
  },
  Event_20779_ChoiceDesc1 = {Text = "[Leave]"},
  Event_20779_Desc = {
    Text = "\"Une aide d'urgence a été fournie. Veuillez taper sur le broche trois fois pour confirmer après l'avoir reçue.\""
  },
  Event_20779_Name = {
    Text = "Soutien de communication"
  },
  Event_20780_ChoiceDesc1 = {Text = "[Leave]"},
  Event_20780_Desc = {
    Text = "Un fantasme venu d'un lointain futur, caché dans les gorges d'Elworth"
  },
  Event_20780_Name = {
    Text = "Volcan fantôme"
  },
  Event_20781_ChoiceDesc1 = {
    Text = "[Gaze at Phantasm] Tous les Réveillants récupèrent l'Aliemus d'Arg1"
  },
  Event_20781_ChoiceDesc2 = {
    Text = "[Approach Phantasm] Choisir de Réveiller 2 Éveilleurs"
  },
  Event_20781_Desc = {
    Text = "Au loin, un cône volcanique semble entrer en éruption, des fumées humanoïdes s'élèvent dans un ciel balayé par la tempête. \n C'est Elvworth, Elvworth n'est composé que de montagnes enneigées qui se dressent sans fin et de grottes de calcaire. \n Est-ce que des jours de phénomènes étranges t'ont rendu fou ?"
  },
  Event_20781_Name = {
    Text = "Volcan fantôme"
  },
  Event_20782_ChoiceDesc1 = {Text = "[Leave]"},
  Event_20782_Desc = {
    Text = "Le fantasme te fit signe, puis disparut. Il ne te reste que le froid de la neige et les montagnes majestueuses"
  },
  Event_20782_Name = {
    Text = "Volcan fantôme"
  },
  Event_20783_ChoiceDesc1 = {Text = "[Leave]"},
  Event_20783_Desc = {
    Text = "\"Roger ça. Nous livrerons les ressources de base. Veuillez vérifier.\""
  },
  Event_20783_Name = {
    Text = "Soutien de communication"
  },
  Event_21398_ChoiceDesc1 = {
    Text = "[Ramasser la photo] Choisissez 1 carte de commandement parmi 3 pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_21398_Desc = {
    Text = "La machine est démantelée, la vérité révélée.\nUne vie tumultueuse se dissipe, laissant place à une satisfaction de vérité dévoilée"
  },
  Event_21398_Name = {
    Text = "Déclaration de témoignage"
  },
  Event_21399_ChoiceDesc1 = {
    Text = "[Ramasser la photo] Choisissez 1 carte de commandement parmi 3 pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_21399_ChoiceDesc2 = {
    Text = "[Vérifier le film] infecter [(Skill.Arg1)], remplacer l'oraison obtenue dans l'option 1, utilisable une fois de plus"
  },
  Event_21399_Desc = {
    Text = "La curiosité te pousse à tourner ton regard vers la piscine d’illusion.\nCes images baignent dans du liquide rouge vif, et le pécheur entièrement couvert de taches noires avait le même visage que le tien"
  },
  Event_21399_Name = {
    Text = "Déclaration de témoignage"
  },
  Event_21400_ChoiceDesc1 = {Text = "[Leave]"},
  Event_21400_Desc = {
    Text = "La machine est démantelée, la vérité révélée.\nUne vie tumultueuse se dissipe, laissant place à une satisfaction de vérité dévoilée"
  },
  Event_21400_Name = {
    Text = "Déclaration de témoignage"
  },
  Event_21811_ChoiceDesc1 = {Text = "[Leave]"},
  Event_21811_Desc = {
    Text = "« Vingt-cinq ans... oui, elle m'a plongée dans le sommeil pendant vingt-cinq ans. »\nLa jeune fille répond avec une voix sombre et abattue. \nÀ son réveil, ceux qui l'avaient soignée depuis son enfance étaient devenus des Marcheurs des mers à part entière avec le temps. \nPlus personne ne comprend son tourment, plus personne ne se soucie de sa douleur, la laissant seule dans le culte. \nElle aurait préféré que le jour avant son sommeil soit celui de « l'alignement des étoiles »."
  },
  Event_21811_Name = {
    Text = "Vie Enchaînée"
  },
  Event_22058_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22058_Desc = {
    Text = "\n\"Non, je n'ai pas faim.\"\nVous avez poliment décliné l'invitation chaleureuse au festin.\nVous ne seriez jamais prêt à hypothéquer votre âme pour cela"
  },
  Event_22058_Name = {
    Text = "Festin de chair"
  },
  Event_22059_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22059_Desc = {
    Text = "Vous mordez avarement dans le scone saignant, l'arôme d'un cœur poivré cuit dans la pâte remplissant vos sens d'une odeur familière.\n\"Acquérir le pouvoir a un coût.\"\nVous buvez la dernière goutte de sang."
  },
  Event_22059_Name = {
    Text = "Festin de chair"
  },
  Event_22060_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22060_Desc = {
    Text = "Tu avales la soupe blanche et la viande en une seule bouchée, essuyant les traces sur tes lèvres avec ta manche.\nLa viande est tendre, la soupe savoureuse, mais à qui appartenait-elle ?\nCe n'est qu'une petite partie de ce que tu as perdu"
  },
  Event_22060_Name = {
    Text = "Festin de chair"
  },
  Event_22061_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22061_Desc = {
    Text = "Tu examines attentivement les anciennes oraisons gravées sur le carillon.\nElles sont tordues à un point inconcevable, comme si elles ne l'avaient pas l'intention d'être comprises.\nNon comprises, donc non dérangées"
  },
  Event_22061_Name = {
    Text = "Vent de rouille"
  },
  Event_22062_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22062_Desc = {
    Text = "\"Pas mal, tu es très prudent.\"\nSoudain, une voix lointaine est venue des carillons.\n\"La prudence te rapportera une petite récompense, mais c'est tout.\""
  },
  Event_22062_Name = {
    Text = "Vent de rouille"
  },
  Event_22063_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22063_Desc = {
    Text = "Tu caresses les anciennes oraisons gravées sur le carillon.\nElles se tordent d'une manière inimaginable pour un commun des mortels, semblant ne pas vouloir être comprises.\nNe pas être comprises, c'est ne pas être dérangées"
  },
  Event_22063_Name = {
    Text = "Vent de rouille"
  },
  Event_22064_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22064_Desc = {
    Text = "\"Ah, quel dommage... Je suppose que je vais continuer ma performance solitaire.\" Tu ne sais pas quand le guzheng et les mains ont disparu, mais la mélodie, comme l'eau qui coule, reste dans ton cœur pour toujours."
  },
  Event_22064_Name = {
    Text = "Fantôme au bord du piano"
  },
  Event_22065_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22065_Desc = {
    Text = "\"Ah, quel honneur d'avoir un ami comme ça !\" Ces mains se sont mises à s'agiter, et tu ne pouvais pas suivre leur vitesse. Même longtemps après la fin de la performance, ce son exaltant agitait encore ton cœur."
  },
  Event_22065_Name = {
    Text = "Fantôme au bord du piano"
  },
  Event_22175_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22175_Desc = {
    Text = "La planchette glisse avec assurance, tes yeux la suivent.\nMais après avoir pointé deux lettres, elle se transforme en une bouillie noire et visqueuse avec un cri horrible"
  },
  Event_22175_Name = {
    Text = "Planche de spiritisme"
  },
  Event_22176_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22176_Desc = {
    Text = "\n\"Mathématiques ! Mathématiques !!\" \nLa femme grimaça, le tableau oracle glissant rapidement entre les chiffres, produisant un bruit de frottement bois sévère.\n\"Fais sortir tes mathématiques de ma vue !\""
  },
  Event_22176_Name = {
    Text = "Planche de spiritisme"
  },
  Event_22177_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22177_Desc = {
    Text = [[
"Attends, attends !!"
"Demande-moi ! Pourquoi ne demandes-tu pas !"]]
  },
  Event_22177_Name = {
    Text = "Planche de spiritisme"
  },
  Event_22178_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22178_Desc = {
    Text = "Il n'a jamais été aussi vibrant qu'en ce moment, mais en même temps, le trou dans son cœur se déchire"
  },
  Event_22178_Name = {
    Text = "Soif maudite"
  },
  Event_22179_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22179_Desc = {
    Text = "L'âme et l'esprit remplissent vos poumons, vous flottant dans le silence.\nLes sons du monde résonnent un à un, jouant la symphonie de la vie"
  },
  Event_22179_Name = {
    Text = "Eaux du passé"
  },
  Event_22180_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22180_Desc = {
    Text = "Tout se passe comme d'habitude, la destruction arrive, des trésors enfouis dans les cendres non brûlées, brillant dans l'ombre"
  },
  Event_22180_Name = {
    Text = "Au-delà de l'extrémité de l'aiguille"
  },
  Event_22181_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22181_Desc = {
    Text = "Rencontre, départ, croisement"
  },
  Event_22181_Name = {
    Text = "Son des étoiles et de la lune"
  },
  Event_22182_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22182_Desc = {
    Text = "Le cœur ralentit, mais peut-être que la \"conscience\" a trouvé un peu de réconfort"
  },
  Event_22182_Name = {
    Text = "Soif maudite"
  },
  Event_22183_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22183_Desc = {
    Text = "Tu fermes les yeux, profitant de ce rare moment de vide et de liberté. Peu à peu, tu sens le monde éclore de son silence, la vie fleurissant silencieusement dans le calme"
  },
  Event_22183_Name = {
    Text = "Eaux du passé"
  },
  Event_22184_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22184_Desc = {
    Text = "Tu arrêtes l'aiguille, l'éclat de l'argent coupant ta paume douce, la destruction n'est pas encore arrivée, mais ton ombre est déjà engloutie par la nuit noire"
  },
  Event_22184_Name = {
    Text = "Au-delà de l'extrémité de l'aiguille"
  },
  Event_22185_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22185_Desc = {
    Text = "\n\"Tu ne peux pas échapper ; personne ne peut résister au mal intérieur.\" \nDes pensées malveillantes déchirent tes nerfs, tentant de te traîner dans l'abîme. Mais la douleur ne fait que rendre ton esprit d'une clarté sans précédent. \nLe mal ne peut te posséder ; tu resteras toi-même."
  },
  Event_22185_Name = {
    Text = "Pensée Illusoire"
  },
  Event_22186_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22186_Desc = {
    Text = "\"Pourquoi pas ?\"\nUne fois que tu embrasses ces pensées terrifiantes, toutes les difficultés seront facilement résolues, et le monde n'aura plus de paradoxe appelé \"éthique.\""
  },
  Event_22186_Name = {
    Text = "Pensée Illusoire"
  },
  Event_22187_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22187_Desc = {
    Text = "Un rideau de lumière argentée passe devant mes yeux, un vent lourd emporte tous les sons."
  },
  Event_22187_Name = {
    Text = "Pensée Illusoire"
  },
  Event_22188_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22188_Desc = {
    Text = "Changeant, froid, distant"
  },
  Event_22188_Name = {
    Text = "Son des étoiles et de la lune"
  },
  Event_22189_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22189_Desc = {
    Text = "Gonflement, contraction, prêt à éclater"
  },
  Event_22189_Name = {
    Text = "Son des étoiles et de la lune"
  },
  Event_22190_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22190_Desc = {
    Text = "Bien que cela semble imprudent, pourquoi pas ?\nBrisez toutes les barrières et foncez vers la fin.\nMême si cela crée des vagues dans le lac de la pensée, même si vous devenez Icare poursuivant le soleil, au moins vous avez atteint votre but, non ?"
  },
  Event_22190_Name = {
    Text = "Labyrinthe de l'esprit"
  },
  Event_22191_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22191_Desc = {
    Text = [[
Ton cerveau est un labyrinthe et tu en es l'Ariane.
Dans cet univers, personne ne sait mieux que toi comment en sortir.
Personne]]
  },
  Event_22191_Name = {
    Text = "Labyrinthe de l'esprit"
  },
  Event_22192_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22192_Desc = {
    Text = "Avec un bon accord, les dissonances se sont adoucies.\nMais peut-être peux-tu faire encore mieux"
  },
  Event_22192_Name = {Text = "Désaccord"},
  Event_22193_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22193_Desc = {
    Text = ": Tu es un maître de musique, mais aussi un musicien ordinaire.\nLes notes sont toutes sous le contrôle de ta pensée, la vie fluide sonne enfin dans le domaine"
  },
  Event_22193_Name = {Text = "Désaccord"},
  Event_22194_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22194_Desc = {
    Text = "Ta voix se perd dans le silence. Le silence devient de plus en plus fort, jusqu'à se briser complètement, laissant des débris partout"
  },
  Event_22194_Name = {
    Text = "Eaux du passé"
  },
  Event_22195_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22195_Desc = {
    Text = "Tu ne te laisses pas facilement duper, tu te retournes et pars rapidement"
  },
  Event_22195_Name = {
    Text = "Crevasse rampante"
  },
  Event_22293_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22293_Desc = {
    Text = "Au moment où j'ai pris la plume, le papier a brûlé dans le domaine, la cendre tombant dans ma main, \ndans un sursaut, quelque chose s'est dissipé avec le papier"
  },
  Event_22293_Name = {
    Text = "Confession unilatérale"
  },
  Event_22294_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22294_Desc = {
    Text = "Au moment où le papier à lettres se dissipe dans le domaine, tu entends une préoccupation douce et faible.\n« C'est un honneur pour moi, en tant qu'enseignant, que tu penses à moi dans de telles circonstances. \nCependant, ma dernière traversée dans le domaine remonte à très longtemps. Aujourd'hui, je ne peux t'aider qu'avec cela… »"
  },
  Event_22294_Name = {
    Text = "Confession unilatérale"
  },
  Event_22295_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22295_Desc = {
    Text = "Alors que la lettre se désintégrait dans le Domaine, tu as entendu une exclamation urgente.\n\"Gardien, s'il y a quoi que ce soit de désagréable, n'hésite pas à me le faire savoir.\nEn tant que ton partenaire, je mettrai tout en œuvre pour t'assister.\""
  },
  Event_22295_Name = {
    Text = "Confession unilatérale"
  },
  Event_22296_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22296_Desc = {
    Text = "Alors que la lettre se dissipe dans le domaine, vous entendez un soupir froid. \n\"Si seulement vous aviez été aussi désireux de chercher de l'aide lorsque vous échouez aux examens.\""
  },
  Event_22296_Name = {
    Text = "Confession unilatérale"
  },
  Event_22397_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22397_Desc = {
    Text = "Ton apparition laisse les ombres perplexes, un rayon d'étoile effleure tes chaussures, et la foule disparaît soudainement, ne laissant que l'ombre la plus dense dans ta main"
  },
  Event_22397_Name = {
    Text = "Pacte de lune et d'étoiles"
  },
  Event_22398_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22398_Desc = {
    Text = "Les chuchotements bruyants s'arrêtent soudainement, des ombres noires se tournent vers toi, te fixant. Sur ces visages sans traits, tu lis une certaine moquerie"
  },
  Event_22398_Name = {
    Text = "Pacte de lune et d'étoiles"
  },
  Event_22399_ChoiceDesc1 = {
    Text = "[Observer calmement] Choisissez 1 Carte d'instruction parmi 3 pour obtenir une Oraison : «(EnchantConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_22399_ChoiceDesc2 = {
    Text = "[Ask Aloud] Gagnez 25 Sigils Noirs"
  },
  Event_22399_Desc = {
    Text = "Dans l'entrelacs des étoiles et de la lune, des chuchotements incessants résonnent. \n « Est-ce cette personne ? @4… » \n « En tant qu'humain, c'est finalement @3… »"
  },
  Event_22399_Name = {
    Text = "Pacte de lune et d'étoiles"
  },
  Event_22411_ChoiceDesc1 = {
    Text = "[Mission Accomplished]"
  },
  Event_22411_Desc = {
    Text = "Piège bon marché mais efficace !"
  },
  Event_22411_Name = {
    Text = "Fabriquer un piège"
  },
  Event_24254_ChoiceDesc1 = {Text = "[Leave]"},
  Event_24254_Desc = {
    Text = "La tempête de connaissance spirituelle entourait Tulu, et tu échangeas un regard avec lui avant de plonger dans l'obscurité"
  },
  Event_24254_Name = {
    Text = "Venir de la mer"
  },
  Event_24255_ChoiceDesc1 = {Text = "[Leave]"},
  Event_24255_Desc = {
    Text = "La tempête de connaissance spirituelle entourait Tulu, et la tristesse et la culpabilité persistantes se répandaient dans l'espace"
  },
  Event_24255_Name = {
    Text = "Affronter l'abîme"
  },
  Event_24256_ChoiceDesc1 = {
    Text = "[Tenir le Tentacule] Acceptez l'aide de Tulu"
  },
  Event_24256_Desc = {
    Text = "Son autorité est comme un grand objet tombant dans la mer, agitant le domaine devant lui.\nCette puissance est ancienne, lointaine, suffisante pour transcender l'éternité.\nHeureusement, vous ne serez pas son ennemi, du moins pas pour l'instant"
  },
  Event_24256_Name = {
    Text = "Venir de la mer"
  },
  Event_24257_ChoiceDesc1 = {
    Text = "[Tenir le Tentacule] Voyagez avec Tulu"
  },
  Event_24257_Desc = {
    Text = "Tulu prend une profonde inspiration et fixe au loin Miryam.\nComme s'il se remémorait l'histoire, de vieux amis et sa propre vie...\nL'expression complexe sur son visage dure juste un instant avant qu'il détourne son regard de Miryam.\n\"Allons-y, laissons-la.\""
  },
  Event_24257_Name = {
    Text = "Affronter l'abîme"
  },
  Event_24277_ChoiceDesc1 = {
    Text = "[Close the Hatch]"
  },
  Event_24277_Desc = {
    Text = "Ramona attrape l'étudiant qui entre par la porte.\nCe gardien intrépide et fort, bien que couvert de saleté, semble flou dans ses yeux bleus derrière ses lunettes.\nCe n'est qu'en attrapant sa main que Ramona confirme : vous vous êtes retrouvés"
  },
  Event_24277_Name = {
    Text = "Rencontre Joyeuse"
  },
  Event_24278_ChoiceDesc1 = {Text = "[Leave]"},
  Event_24278_Desc = {
    Text = "Ramona ne te laissa pas expliquer, elle te tira dans la cabine sombre et ferma prudemment la porte"
  },
  Event_24278_Name = {
    Text = "Rencontre Joyeuse"
  },
  Event_24540_ChoiceDesc1 = {Text = "[Leave]"},
  Event_24540_Desc = {
    Text = "\"Elle est votre bouclier robuste, l'épée dans votre main. \nElle est votre partenaire, votre compagne, votre amie de confiance—peu importe comment elle change.\""
  },
  Event_24540_Name = {
    Text = "Une présence étrange et familière"
  },
  Event_24541_ChoiceDesc1 = {Text = "[Leave]"},
  Event_24541_Desc = {
    Text = "\n\"C'est toi... Non, ce ne peut pas être. Cette réincarnation de toi a déjà... Et moi aussi, j'ai déjà...\" \nLa voix s'est estompée avec la silhouette, ne laissant que la tristesse s'attarder dans la brume."
  },
  Event_24541_Name = {
    Text = "Figure familière mais étrange"
  },
  Event_24542_ChoiceDesc1 = {Text = "[Leave]"},
  Event_24542_Desc = {
    Text = "\"Pour le monde, pour l'humanité, pour tout ce que nous chérissons.\nBien sûr, le plus important est—elle est pour vous.\""
  },
  Event_24542_Name = {
    Text = "Une présence étrange et familière"
  },
  Event_24543_ChoiceDesc1 = {Text = "[Leave]"},
  Event_24543_Desc = {
    Text = "Tu n'avais même pas encore approché la silhouette qu'elle t'avait déjà remarqué. Elle s'est figée, comme choquée, ou plongée dans une profonde tristesse.\nAvant que tu ne puisses dire quoi que ce soit, elle s'est évanouie avec la brume"
  },
  Event_24543_Name = {
    Text = "Figure familière mais étrange"
  },
  Event_24544_ChoiceDesc1 = {
    Text = "[Who is she?] Obtenez au hasard 3 cartes de commande du paquet et choisissez 1 à copier."
  },
  Event_24544_ChoiceDesc2 = {
    Text = "[Pourquoi est-elle devenue ainsi ?] Choisissez 1 Carte d'instruction parmi 3 pour obtenir une Oraison : «(EnchantConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_24544_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_24544_Desc = {
    Text = "Une autre brume, une autre silhouette. Cette fois, tu vois clairement.\nUne forme identique à la tienne, un uniforme identique, un visage identique.\n\"Tu sais pourquoi tu es ici,\" dit-il, \"comme tu sais pourquoi elle est devenue ainsi.\""
  },
  Event_24544_Name = {
    Text = "Une présence étrange et familière"
  },
  Event_24545_ChoiceDesc1 = {
    Text = "[Console] Obtenez la Relique d'Argent \"(RelicConfig.Arg1)\", infectée par \"(Skill.Arg2)\""
  },
  Event_24545_ChoiceDesc2 = {
    Text = "\"[Essayer d'approcher] octroie la relique argentée \"(RelicConfig.Arg1)\" et provoque l'infection \"(Skill.Arg2)\"\""
  },
  Event_24545_ChoiceDesc3 = {
    Text = "[Tourner et Partir] Gagner 25 sigils noirs"
  },
  Event_24545_Desc = {
    Text = "Le brouillard enveloppe le chemin que tu empruntes. \n Une silhouette apparaît dans la lumière floue, tu plisses les yeux, mais tu ne peux pas distinguer son visage, tu n'entends que des chuchotements intermittents. \n « Pourquoi… pourquoi ne puis-je pas sauver… le destin, ne peut-on vraiment pas le changer… »"
  },
  Event_24545_Name = {
    Text = "Figure familière mais étrange"
  },
  Event_35039_ChoiceDesc1 = {
    Text = "[Demander l'aide d'un associé] Obtenir une Gravure avancée au choix parmi 3"
  },
  Event_35039_ChoiceDesc2 = {
    Text = "[Gérer le tournage] obtenez une relique en or[(RelicConfig.Arg1)]"
  },
  Event_35039_ChoiceDesc3 = {
    Text = "[Guider la frénésie] Obtenir la création[(RelicConfig.Arg1)]"
  },
  Event_35039_Desc = {
    Text = "« Le guide de plateau de Maître Houdini stipule clairement que Casiah, c'est-à-dire moi-même, en tant que productrice et réalisatrice, a le devoir et le pouvoir de superviser l'ensemble du film. Donc, cher employé audacieux de Casiah, veuillez choisir votre prochain calendrier d'actions ! »\n« Calendrier ? Attends, depuis quand suis-je devenu ton employé ? ! »\n« L'occasion ne se représentera pas, ne tarde plus ! »"
  },
  Event_35039_Name = {
    Text = "Le mythe du producteur"
  },
  Event_35103_ChoiceDesc1 = {
    Text = "[Connect] Restore Arg2 Vie [ExDesc1] [ExDesc2]."
  },
  Event_35103_ChoiceDesc2 = {
    Text = "[Meditate] Choisir de Réveiller 1 Réveilleur."
  },
  Event_35103_ChoiceDesc3 = {
    Text = "[Expel] Éliminez jusqu'à 3 cartes de symptômes, et gagnez des sigils noirs Arg2."
  },
  Event_35103_Desc = {
    Text = "Tu explores dans la brume, soudain, l'insigne sur ta poitrine émet une faible lueur argentée. Qui t'appelle de l'autre côté de la communication ?"
  },
  Event_35103_Name = {
    Text = "Point de contact"
  },
  Event_35103_Tips3 = {
    Text = "Aucune carte de symptôme"
  },
  Event_35165_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35165_Desc = {
    Text = "Hésitant, tu as pris l'initiative d'envoyer une demande de communication au mystérieux bienfaiteur. \n « Puisque nous en sommes là, il est difficile de faire marche arrière. Je prie le Seigneur d'ouvrir sa bourse... » \n Un rire particulièrement généreux est venu de l'autre côté du communicateur à Cœur d'argent, et l'interlocuteur a finalement accepté ta demande avec un sourire. \n « Au fait, il y a aussi... je te prie de garder cela secret vis-à-vis de Ramona. »"
  },
  Event_35165_Name = {
    Text = "Le mythe du producteur"
  },
  Event_35236_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35236_Desc = {
    Text = "Que fait un régisseur de plateau ? Tu as sorti une pile de documents que Casiah avait glissée dans le transcripteur de Gnosis, et tu as commencé à les examiner attentivement. \nPuis, tu as commencé à avoir mal à la tête. \nLes pertes causées par Lotan lors de l'aménagement du plateau, les collations mangées par Aurita et Brun, la demande de remboursement pour les petites boules magiques achetées par Casiah… Les paiements s'accumulaient devant toi, et tu devais douloureusement t'accroupir pour faire les calculs. \nAu fait, qu'est-ce que les petites boules magiques de Casiah ?"
  },
  Event_35236_Name = {
    Text = "Le mythe du producteur"
  },
  Event_35259_ChoiceDesc1 = {
    Text = "[Dispel the Illusion] Infectez le symptôme [ExDesc1][ExDesc2]."
  },
  Event_35259_ChoiceDesc2 = {Text = "[Leave]"},
  Event_35259_Desc = {
    Text = "Des visages flous apparaissent soudainement, entourant et gémissant désespérément sans cordes vocales"
  },
  Event_35259_Name = {Text = "Illusion"},
  Event_35497_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35497_Desc = {
    Text = "Derrière le phénomène frénétique, il faut un moteur, et dès qu'on parle de « moteur », l'image d'une jeune fille aux cheveux verts surgit dans l'esprit. \n « La première intermédiaire de l'Université de Misargh, Hanna Peaslee, est à votre service ! » \n « Si c'est la première demande de service d'un gardien du secret, il suffit de payer le prix de trois repas au curry de la cantine ! »"
  },
  Event_35497_Name = {
    Text = "Le mythe du producteur"
  },
  Event_35887_ChoiceDesc1 = {
    Text = "[Move Forward]"
  },
  Event_35887_Desc = {
    Text = "Vous soulevez la voile du bateau, mais il n'y a rien en dessous. En revenant à vous, la voile a disparu.\nLa voile blanche et le visage de la jeune fille deviennent un message, vous rappelant que vous n'êtes pas seul, peu importe le chemin à venir"
  },
  Event_35887_Name = {
    Text = "Voile blanc pur"
  },
  Event_35888_ChoiceDesc1 = {
    Text = "[Élever la Voile]"
  },
  Event_35888_Desc = {
    Text = "Il n'y a pas de vent ici, mais un voilier immaculé flotte, ses voiles se levant majestueusement, se tenant sur la surface calme de la mer bleu profond. \n Vous apercevez vaguement le visage d'une jeune fille, ses traits sont flous, comme à travers un léger brouillard ou une surface d'eau mouvante. Son existence semble isolée de tout ce qui l'entoure, mais elle est pourtant au cœur de cette scène. \n Bien que son image oscille entre la clarté et le flou, il ne fait aucun doute que vous savez qui elle est."
  },
  Event_35888_Name = {
    Text = "Voile blanc pur"
  },
  Event_35894_ChoiceDesc1 = {
    Text = "[chute] obtient 35 le sigil noir, contamine[(Skill.Arg2)], choix supplémentaire"
  },
  Event_35894_ChoiceDesc2 = {
    Text = "[S'éloigner]"
  },
  Event_35894_Desc = {
    Text = "La voix de la jeune fille se dissipa dans l'air, floue et lointaine comme une bulle"
  },
  Event_35894_Name = {
    Text = "À la frontière de la vie et de la mort"
  },
  Event_35895_ChoiceDesc1 = {
    Text = "[cycle éternel] obtient 30 le sigil noir, contamine[(Skill.Arg2)], choix supplémentaire"
  },
  Event_35895_ChoiceDesc2 = {
    Text = "[S'éloigner]"
  },
  Event_35895_Desc = {
    Text = "Les membres sont lourds, le brouillard enserre le corps frêle"
  },
  Event_35895_Name = {
    Text = "À la frontière de la vie et de la mort"
  },
  Event_35896_ChoiceDesc1 = {
    Text = "[Lire le Chemin des anciens] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infectée par «(Skill.Arg2)»"
  },
  Event_35896_ChoiceDesc2 = {
    Text = "[Write Your Own Path] Obtenez la relique en argent \"(RelicConfig.Arg1)\" et infligez \"(Skill.Arg2)\"."
  },
  Event_35896_ChoiceDesc3 = {
    Text = "[Stare into Darkness] Gagnez 25 sigils noirs"
  },
  Event_35896_Desc = {
    Text = "Si vous explorez seul dans le domaine, vous ne serez certainement pas aussi sûr de votre voie qu'à présent.\nLes empreintes dans le domaine se sont divisées en trois, chaque empreinte écrivant un avenir invisible"
  },
  Event_35896_Name = {Text = "Sortie"},
  Event_35897_ChoiceDesc1 = {
    Text = "[Support Her]"
  },
  Event_35897_ChoiceDesc2 = {
    Text = "[Regardant elle]"
  },
  Event_35897_Desc = {
    Text = "Elle murmura, tournoyant jusqu'à s'arrêter devant toi.\nQuelqu'un avait troublé son repos, son esprit était lié à la réalité, mais son âme restait dans un royaume perdu"
  },
  Event_35897_Name = {
    Text = "Fantôme Perdu"
  },
  Event_35898_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35898_Desc = {
    Text = "Dans cette obscurité chaotique, une série d'empreintes floues s'étend, comme les traces profondes laissées par un marcheur nocturne dans un désert invisible"
  },
  Event_35898_Name = {Text = "Sortie"},
  Event_35899_ChoiceDesc1 = {
    Text = "[Partir] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_35899_Desc = {
    Text = "Une lumière apparaît dans tes yeux, révélant un phare lointain, se tenant seul à la lisière des ténèbres, émettant une lueur faible mais déterminée, tel un guide dans la mer nocturne, appelant les âmes égarées vers la paix de l'autre rive. \n Tu ne peux t'empêcher de le poursuivre, mais soudain, le sol sous tes pieds n'est plus solide. \n Tu entres dans une zone d'eau cachée sous l'ombre. La surface de l'eau est douce comme de la soie, engloutissant silencieusement tes pas."
  },
  Event_35899_Name = {Text = "Éclat"},
  Event_35900_ChoiceDesc1 = {
    Text = "[Listen to Her]"
  },
  Event_35900_ChoiceDesc2 = {
    Text = "[Ignorez-la]"
  },
  Event_35900_Desc = {
    Text = "Tu vois la source de la lumière, c'est une silhouette féminine.\nLa lumière coule de sa tête étrange, ouvrant un chemin vers l'inconnu.\n« Retourne... à R'lyeh... »"
  },
  Event_35900_Name = {
    Text = "Lampe éternelle"
  },
  Event_35901_ChoiceDesc1 = {
    Text = "[Approach Lighthouse]"
  },
  Event_35901_ChoiceDesc2 = {
    Text = "[Loin du Phare]"
  },
  Event_35901_Desc = {
    Text = "Au détour de la frontière entre la réalité et le rêve, dans cet instant fugace, un tableau terrifiant de tempête s'étend devant mes yeux. \n Comme si une énorme main invisible le soulevait, le vent rugit tel une bête sauvage, soulevant la poussière et l'espoir, le ciel est lourd, d'une oppression extrême. \n Au cœur de la tempête, ce phare qui ne devrait pas exister se dresse, semblant être le produit de l'imagination, ou peut-être une relique d'anciennes légendes. Sur la scène ravagée par le vent, il émet une faible lueur, solitaire et résilient."
  },
  Event_35901_Name = {
    Text = "Centre de la tempête"
  },
  Event_35902_ChoiceDesc1 = {
    Text = "[Leave] Gagner 50 sigles noirs"
  },
  Event_35902_Desc = {
    Text = "\"Dans le Domaine, des lumières éternelles, des phantômes avec des tentacules...\"\nTulu ferma les yeux, méditant un instant, puis laissa échapper un profond soupir.\n\"Le Gardien de Lémurie... un de mes serviteurs. Elle n'a finalement pas pu échapper aux liens de ses obsessions.\""
  },
  Event_35902_Name = {
    Text = "Le naufrage du Sonanir"
  },
  Event_35903_ChoiceDesc1 = {
    Text = "[Toucher la Lumière Argentée] Gagner 25 sigils noirs"
  },
  Event_35903_ChoiceDesc2 = {
    Text = "[Talk to Silverlight] Obtenez une relique en argent \"(RelicConfig.Arg1)\", et infectez \"(Skill.Arg2)\""
  },
  Event_35903_Desc = {
    Text = "Le communicateur hermétique a été ouvert, une lumière terne s'en échappe - c'est probablement la première fois que le noyau d'argent communique avec le monde extérieur depuis qu'il a été scellé"
  },
  Event_35903_Name = {
    Text = "Monument en mithril"
  },
  Event_35904_ChoiceDesc1 = {
    Text = "[Partir] Obtenir une création[(RelicConfig.Arg1)]"
  },
  Event_35904_Desc = {
    Text = "« La femme à la tête lumineuse ? » Elton affichait une expression d'étonnement, il était évident qu'il avait entendu parler de l'ombre qui apparaissait de temps à autre dans le labyrinthe du cargo, mais — \n « La nuit où le Sonaniel a coulé... c'est aussi la nuit où j'ai réveillé Celeste, j'ai vu une telle ombre dans la tempête. » \n « Je ne me suis absolument pas trompé. »"
  },
  Event_35904_Name = {
    Text = "Le naufrage du Sonanir"
  },
  Event_35905_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35905_Desc = {
    Text = "Le chemin du domaine est plein de dangers et insondable.\nTes yeux fixent le chaos invisible, mais avant que tu ne sois englouti, Ramona, qui a éliminé les poursuivants, t'attrape et te détourne dans une autre direction"
  },
  Event_35905_Name = {Text = "Sortie"},
  Event_35906_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35906_Desc = {
    Text = "Est-ce le fruit de ton âme mystérieuse ? Tout ce que tu vis en ce moment est-il le choc entre le soi et le surmoi ? \n Plus tu réfléchis, plus le bruit dans ta tête devient fort et clair. Ton regard pénètre dans un brouillard, et juste au moment où tu es sur le point de discerner la personne dans le brouillard, ton âme te rejette."
  },
  Event_35906_Name = {
    Text = "Destin inversé"
  },
  Event_35907_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35907_Desc = {
    Text = "Il s'active à l'intérieur, se transforme en force intrépide, te soutenant pour percer la brume et déchirer la peur"
  },
  Event_35907_Name = {
    Text = "Chasser la lumière"
  },
  Event_35908_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35908_Desc = {
    Text = "À mesure que la concentration et la paix intérieure augmentent, les illusions chaotiques commencent à se dissoudre, se retirant comme la marée.\nFinalement, le bruit dans ton esprit disparaît complètement - mais combien as-tu manqué ? Impossible de le savoir"
  },
  Event_35908_Name = {
    Text = "Avertissement futur"
  },
  Event_35909_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35909_Desc = {
    Text = "L'âme est complètement perdue dans les acouphènes, tu luttes pour t'échapper, pour comprendre cette douleur, mais tu restes toujours à la périphérie de la conscience"
  },
  Event_35909_Name = {
    Text = "À la frontière de la vie et de la mort"
  },
  Event_35910_ChoiceDesc1 = {
    Text = "[Partir] Obtient 3 choix 1 relique en or, infection[(Skill.Arg1)]"
  },
  Event_35910_Desc = {
    Text = "Tu ressens chaque point de lumière émis par le phare, brûlant et dansant dans la tempête, comme un appel de l'âme, ne renonçant jamais à guider le chemin même dans la peur la plus intense"
  },
  Event_35910_Name = {
    Text = "Centre de la tempête"
  },
  Event_35911_ChoiceDesc1 = {
    Text = "[Leave] Obtenir 1 parmi 3 Oraisons Avancées"
  },
  Event_35911_Desc = {
    Text = "Est-ce un symbole d'espoir ou un présage de destruction ?\nTu ne le regardes plus, comme si son existence n'était qu'un rêve soigneusement orchestré"
  },
  Event_35911_Name = {
    Text = "Centre de la tempête"
  },
  Event_35912_ChoiceDesc1 = {
    Text = "[Évanouissement] obtenir 20 le sigil noir, infecter [(Skill.Arg2)]"
  },
  Event_35912_ChoiceDesc2 = {
    Text = "[S'éloigner]"
  },
  Event_35912_Desc = {
    Text = "Puis, une étrange brume grise a couvert tes yeux. Un instant plus tard, tu réalises que c'est ta paupière translucide"
  },
  Event_35912_Name = {
    Text = "À la frontière de la vie et de la mort"
  },
  Event_35913_ChoiceDesc1 = {
    Text = "[Partir] Réveiller un Réveillé aléatoire, infecter[(Skill.Arg1)]"
  },
  Event_35913_Desc = {
    Text = "Un écho inexplicable résonne en toi.\nMais la raison te dit : ignore-la"
  },
  Event_35913_Name = {
    Text = "Lampe éternelle"
  },
  Event_35914_ChoiceDesc1 = {
    Text = "[Partir] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_35914_Desc = {
    Text = "Sa langue n'est gravée sur aucune pierre connue, mais elle se condense dans l'air en un profond et profond repentir et appel. Comme si elle venait de l'autre bout du temps, traversant la sédimentation des âges, portée par une profonde affection pour un lointain foyer"
  },
  Event_35914_Name = {
    Text = "Lampe éternelle"
  },
  Event_35915_ChoiceDesc1 = {
    Text = "[Prendre sa main] Un relique d'argent aléatoire est améliorée en relique en or[(RelicConfig.Arg1)]"
  },
  Event_35915_ChoiceDesc2 = {
    Text = "[Express Concern] Obtenir la relique d'argent \"(RelicConfig.Arg1)\" et être infecté par \"(Skill.Arg2)\"."
  },
  Event_35915_ChoiceDesc3 = {
    Text = "[Regarde-la] Gagne 25 sigils noirs"
  },
  Event_35915_Desc = {
    Text = "Murphy est à la fin de l'équipe, marchant côte à côte avec Celeste à l'arrière de la formation.\nVous ne pouvez vous empêcher de vous retourner souvent pour la regarder, mais Murphy garde toujours la tête baissée sur la pointe de ses chaussures, cachant son expression dans l'inconnu"
  },
  Event_35915_Name = {
    Text = "Gestion de la douleur"
  },
  Event_35915_Tips1 = {
    Text = "Pas encore de relique d'argent"
  },
  Event_35916_ChoiceDesc1 = {
    Text = "[Incapacité de se dégager] Gagne 40 le sigil noir, infecte [(Skill.Arg2)], continuez à choisir"
  },
  Event_35916_ChoiceDesc2 = {
    Text = "[Embrace Reality] Gagnez 25 Sigils Noirs"
  },
  Event_35916_Desc = {
    Text = "@1@1Renaître, l'âme traverse @2, mais n'embrasse pas encore pleinement le corps.\nLes mots inquiets de Murphy s'éloignent de ta conscience, comme le cri d'un corbeau, résonnant à tes oreilles, mais toujours bloqués par les barrières de l'esprit"
  },
  Event_35916_Name = {
    Text = "À la frontière de la vie et de la mort"
  },
  Event_35917_ChoiceDesc1 = {
    Text = "[Partir] Choisissez de copier 1 carte de commandement, infection[(Skill.Arg1)]"
  },
  Event_35917_Desc = {
    Text = "Elle n'était qu'un fantôme dans la réalité, un fragment ancien insaisissable mais omniprésent"
  },
  Event_35917_Name = {
    Text = "Fantôme Perdu"
  },
  Event_35918_ChoiceDesc1 = {
    Text = "[Partir] Choisissez 1 carte de commandement parmi 3 pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_35918_Desc = {
    Text = "À cet instant, tu entends le léger bruit de la rupture au fond de ton âme. Comme une fumée qui se dissipe progressivement, son image commence à se brouiller, devenant de plus en plus irréelle. \nElle n'existe pas ici, ce n'est qu'une projection des souvenirs du capitaine Elton. \nMais ce qui reste dans ton cœur, sa perte et sa confusion, n'est pas feint."
  },
  Event_35918_Name = {
    Text = "Fantôme Perdu"
  },
  Event_35919_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35919_Desc = {
    Text = "Au moment où vos doigts touchent, un sentiment complexe vous envahit - à la fois brûlant et glacé.\nLes âmes oubliées du monde hurlent en quête d'éternité"
  },
  Event_35919_Name = {
    Text = "Monument en mithril"
  },
  Event_35920_ChoiceDesc1 = {
    Text = "[Tenir Étreinte] Augmentez la santé maximale de Arg1"
  },
  Event_35920_ChoiceDesc2 = {
    Text = "[Affronter son cœur] 2 Cartes d'instruction aléatoires obtiennent l'Oraison : «(EnchantConfig.Arg1)», infecter 2 «(Skill.Arg2)»"
  },
  Event_35920_Desc = {
    Text = "Dans cette chasse massive, la poursuite de Goliath est comme une bête nocturne, cherchant à dévorer toute lueur d'espoir. Cependant, cette poursuite impitoyable ne t'a pas figé, mais a enflammé une étincelle au plus profond de toi, qui s'étend et brûle de plus en plus fort"
  },
  Event_35920_Name = {
    Text = "Chasser la lumière"
  },
  Event_35921_ChoiceDesc1 = {
    Text = "[Decipher It] Obtenez aléatoirement 3 cartes de commande du paquet et choisissez 1 à copier."
  },
  Event_35921_ChoiceDesc2 = {
    Text = "[Devenir cela] Choisissez 1 Carte d'instruction parmi 3 pour obtenir une Oraison : «(EnchantConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_35921_ChoiceDesc3 = {
    Text = "[Disregard It] Gagnez 25 Sigils Noirs"
  },
  Event_35921_Desc = {
    Text = "Au moment où tu fais un pas, une vibration invisible te saisit l'esprit, t'obligeant à regarder vers les frontières du domaine du chaos et de l'illusion"
  },
  Event_35921_Name = {
    Text = "Avertissement futur"
  },
  Event_35922_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35922_Desc = {
    Text = "Des couleurs étranges et colorées dansent devant tes yeux, des voix chuchotent à tes oreilles, ou des scènes et des visages flous passent, s'entrelacent, comme pour raconter une multitude d'histoires inconnues. Ces illusions te donnent l'impression de te séparer progressivement de la réalité, te plongeant dans un rêve à la fois familier et étranger."
  },
  Event_35922_Name = {
    Text = "Avertissement futur"
  },
  Event_35923_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35923_Desc = {
    Text = "Les tremblements ne viennent pas du bruit extérieur ou des vibrations, mais d'un pressentiment indescriptible au plus profond de vous. Comme un appel du futur, vibrant dans votre conscience"
  },
  Event_35923_Name = {
    Text = "Avertissement futur"
  },
  Event_35924_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35924_Desc = {
    Text = "Ses mains se portèrent involontairement vers sa poitrine, s'efforçant de contrôler cette sensation d'étouffement. \n Cette peur la fit grincer des dents, se forçant à ignorer les douleurs fulgurantes qui ravageaient sa cage thoracique. Chaque légère distorsion sur le visage de Murphy était rapidement dissimulée, camouflée par une piètre façade pour cacher sa souffrance. \n — Jusqu'à ce que tu prennes sa main, la surprise devint la couleur de son visage."
  },
  Event_35924_Name = {
    Text = "Gestion de la douleur"
  },
  Event_35925_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35925_Desc = {
    Text = "\n\"Murphy ? Ça va ?\" \n— Elle ne t'a pas répondu. \nL'étrangeté palpable corrodait son cœur, rendant presque impossible pour elle de respirer."
  },
  Event_35925_Name = {
    Text = "Gestion de la douleur"
  },
  Event_35926_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35926_Desc = {
    Text = "Tu n'hésites plus, tu entres dans l'inconnu sombre. Là où tu passes, une route vers la lumière se dessine"
  },
  Event_35926_Name = {Text = "Sortie"},
  Event_35927_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35927_Desc = {
    Text = "\nDevant vous se trouve un feu pulsant.\nIl est ardent, vivant, enveloppant une flamme froide vacillante, dissipant brillamment ces sons discordants.\nLorsque vous avez repris vos esprits, vous avez trouvé Murphy vous regardant avec confusion —\n\"Es-tu vraiment en sécurité ?\""
  },
  Event_35927_Name = {
    Text = "À la frontière de la vie et de la mort"
  },
  Event_35928_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35928_Desc = {
    Text = "Tu sens ta conscience commencer à se séparer, lentement tirée hors du corps.\nTu as l'impression de voir ton âme danser avec cette conscience résiduelle en argent, puis tomber lourdement dans un abysse invisible…\nLà réside la pure illusion"
  },
  Event_35928_Name = {
    Text = "Monument en mithril"
  },
  Event_35929_ChoiceDesc1 = {
    Text = "[Leave] Gagner 25 sigles noirs"
  },
  Event_35929_Desc = {
    Text = "Avant que vous n'ayez eu le temps de poursuivre votre enquête sur la source de la lumière, elle a soudainement tremblé et s'est désintégrée dans l'air. \n La lumière a produit des ondulations dans le domaine, se propageant dans toutes les directions. \n Puis, rien n'est resté"
  },
  Event_35929_Name = {Text = "Éclat"},
  Event_35930_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35930_Desc = {
    Text = "Comment cela pourrait-il être toi ?\nSi c'était toi, pourquoi, lors de la tristesse, ne t'a-t-il pas sauvé ?\nSi c'était toi, pourquoi, pendant les souffrances, ne t'a-t-il pas aidé ?\nDonc, tout cela n'est qu'une illusion"
  },
  Event_35930_Name = {
    Text = "Destin inversé"
  },
  Event_35931_ChoiceDesc1 = {
    Text = "[Ask the Captain]"
  },
  Event_35931_ChoiceDesc2 = {Text = "[Ask Tulu]"},
  Event_35931_Desc = {
    Text = "Encore une fois, tu vois cette silhouette mystérieuse entrer dans la cloison et disparaître. Les cheveux fluorescents se transforment en tentacules tombant au sol.\nTu sais très bien que, même si elle n'est pas une membre des Marins, elle a un lien étroit avec le Royaume Perdu"
  },
  Event_35931_Name = {
    Text = "Le naufrage du Sonanir"
  },
  Event_35932_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35932_Desc = {
    Text = "Tu ressens la peur, tout est l'œuvre de l'adrénaline.\nTu as peur que tes décisions nuisent à ceux qui partagent l'obscurité avec toi"
  },
  Event_35932_Name = {
    Text = "Chasser la lumière"
  },
  Event_35933_ChoiceDesc1 = {
    Text = "[Pas d'échappatoire] Gagne 25 le sigil noir, infecte [(Skill.Arg2)], continuez à choisir"
  },
  Event_35933_ChoiceDesc2 = {
    Text = "[S'éloigner]"
  },
  Event_35933_Desc = {
    Text = "Chaque nerf crie son désir pour @2"
  },
  Event_35933_Name = {
    Text = "À la frontière de la vie et de la mort"
  },
  Event_35934_ChoiceDesc1 = {Text = "[Chase]"},
  Event_35934_ChoiceDesc2 = {
    Text = "[Ignorez-le]"
  },
  Event_35934_Desc = {
    Text = "Au loin dans le labyrinthe, une lumière douce et fascinante s'allume. \n Elle scintille comme le reflet du soleil sur l'eau, comme des étoiles vacillantes, ou une petite flamme… \n Juste au moment où tu souhaites t'en approcher, cette lumière disparaît soudainement. \n Elle semble t'attirer, comme un papillon attiré par l'instinct."
  },
  Event_35934_Name = {Text = "Éclat"},
  Event_35935_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35935_Desc = {
    Text = "À quoi bon s'inquiéter de ça ?\nTu es une feuille flottant dans les airs, poussée par le vent du destin, c'est tout"
  },
  Event_35935_Name = {
    Text = "Destin inversé"
  },
  Event_35936_ChoiceDesc1 = {
    Text = "[Self-Deprecation] Obtenez la relique d'argent \"(RelicConfig.Arg1)\", infectée par \"(Skill.Arg2)\""
  },
  Event_35936_ChoiceDesc2 = {
    Text = "[Pursue] Obtenez la relique d'or \"(RelicConfig.Arg1)\", infectez \"(Skill.Arg2)\", \"(Skill.Arg3)\""
  },
  Event_35936_ChoiceDesc3 = {
    Text = "[Stop Thinking] Gagner 25 Sigils Noirs"
  },
  Event_35936_Desc = {
    Text = "Le vent de la vie caresse ton âme, te faisant tourbillonner dans le vortex de la réalité, entraîné dans l'inconnu enveloppé de brume. \n Tu ne peux t'empêcher de demander à la voix dans ta tête : « Est-ce que c'est moi ? »"
  },
  Event_35936_Name = {
    Text = "Destin inversé"
  },
  Event_36146_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36146_Desc = {
    Text = "Murphy a enfin remarqué ton regard, peut-être qu'il était effectivement trop brûlant.\nElle a pris quelques profondes respirations, laissant échapper un léger « hum » par ses narines. Enfin, elle a suivi Céleste, restant juste derrière toi"
  },
  Event_36146_Name = {
    Text = "Gestion de la douleur"
  },
  Event_36722_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36722_Desc = {
    Text = "Au moment où vos doigts touchent, un sentiment complexe vous envahit - à la fois brûlant et glacé.\nLes âmes oubliées du monde hurlent en quête d'éternité"
  },
  Event_36722_Name = {
    Text = "Monument de Gnosis"
  },
  Event_36723_ChoiceDesc1 = {
    Text = "[Toucher ça] Réveillez 1 éveillé aléatoire, infecté par [(Skill.Arg1)]"
  },
  Event_36723_ChoiceDesc2 = {
    Text = "[Join the Spin] Obtenez une oraison à 3 choix"
  },
  Event_36723_Desc = {
    Text = "Au moment où tu fais un pas, une fissure silencieuse s'ouvre dans les profondeurs de ton esprit. Une essence indescriptible s'infiltre par la fissure, troublant ton esprit.\nTu sens une planète chaotique argentée tourner et croître en toi"
  },
  Event_36723_Name = {
    Text = "Monument de Gnosis"
  },
  Event_36724_ChoiceDesc1 = {
    Text = "[Follow them] Obtenir la Relique d'Argent \"(RelicConfig.Arg1)\", infecter \"(Skill.Arg2)\""
  },
  Event_36724_ChoiceDesc2 = {
    Text = "[Les caresser] Gagnez une Relique en or \"(RelicConfig.Arg1)\", Infection \"(Skill.Arg2)\", \"(Skill.Arg3)\""
  },
  Event_36724_ChoiceDesc3 = {
    Text = "[Do Not Disturb] Gagnez 25 Sigils Noirs"
  },
  Event_36724_Desc = {
    Text = "Après un virage inattendu, une scène étrange apparaît.\nDes ombres semblables à des chats flottent indistinctement près des parois froides."
  },
  Event_36724_Name = {
    Text = "Chat de bateau"
  },
  Event_36725_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36725_Desc = {
    Text = "\"Mémoire\"ne répond pas. Ils s'accrochent au mur de la cabine, te fixant jusqu'à ce que tu tournes au prochain coin."
  },
  Event_36725_Name = {
    Text = "Propriétaire du Sonanir"
  },
  Event_36726_ChoiceDesc1 = {
    Text = "[Detour] Retirez 1 carte de commande et gagnez des sigils noirs Arg1."
  },
  Event_36726_ChoiceDesc2 = {
    Text = "[Demandez pourquoi ça a coulé] copiez une carte de commandement et infectez[(Skill.Arg1)]"
  },
  Event_36726_ChoiceDesc3 = {
    Text = "[salue l'équipage] choisit 1 carte de commande parmi 3 et obtient l'oraison :[(EnchantConfig.Arg1)]"
  },
  Event_36726_Desc = {
    Text = "Sur le chemin menant à la salle de puissance, tu rencontres à nouveau des « mémoires » fixées dans le domaine.\nElles ne sont pas des fantômes, mais simplement le chagrin du capitaine Elton pour ses marins disparus"
  },
  Event_36726_Name = {
    Text = "Propriétaire du Sonanir"
  },
  Event_36727_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36727_Desc = {
    Text = "\n\"Mémoire\" se détacha de la cloison, déformant son visage en laissant échapper un gémissement lamentable. \n—Le phare. \n—Le phare isolé les mena vers la tempête."
  },
  Event_36727_Name = {
    Text = "Propriétaire du Sonanir"
  },
  Event_36728_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36728_Desc = {
    Text = "Tu choisis de suivre, suivant la trajectoire esquissée par ces âmes douces et libres, même si devant se trouvent des pièges dont l'obscurité a laissé les traces"
  },
  Event_36728_Name = {
    Text = "Chat de bateau"
  },
  Event_36729_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36729_Desc = {
    Text = "Ne dérange pas les morts, ne trouble pas les souvenirs endormis"
  },
  Event_36729_Name = {
    Text = "Propriétaire du Sonanir"
  },
  Event_36730_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36730_Desc = {
    Text = "Tu sens ta conscience commencer à se séparer, lentement tirée hors du corps.\nTu as l'impression de voir ton âme danser avec la planète, puis tomber lourdement dans un abysse invisible…\nLà réside la pure illusion"
  },
  Event_36730_Name = {
    Text = "Monument de Gnosis"
  },
  Event_36731_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36731_Desc = {
    Text = "En tant qu'êtres doux, ils sont un souhait interdit dans ce domaine, ce ne sont que des fantasmes.\nBien que tu comprennes cela, une légère ondulation de chaleur persiste dans ton cœur"
  },
  Event_36731_Name = {
    Text = "Chat de bateau"
  },
  Event_36732_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36732_Desc = {
    Text = "Leurs silhouettes sont floues, comme une peinture à l'huile balayée par le flot du temps et de l'espace. Des taches noires profondes ressemblent à des nuages flottants dans le ciel nocturne, mais leurs yeux ressemblent davantage à l'éclat lointain des étoiles, émettant une lumière mystérieuse et profonde. \nTu ne peux résister à leur tentation, et tu tends la main pour plonger dans un vide."
  },
  Event_36732_Name = {
    Text = "Chat de bateau"
  },
  Event_36733_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36733_Desc = {
    Text = "Tu sais que tu dois continuer, même en trébuchant, même en tombant"
  },
  Event_36733_Name = {
    Text = "Douleur physique"
  },
  Event_36734_ChoiceDesc1 = {
    Text = "[Essayer de l'Appeler] Augmente la Vie de Arg1"
  },
  Event_36734_ChoiceDesc2 = {Text = "[Leave]"},
  Event_36734_Desc = {
    Text = "C'est un endroit rempli de désirs cachés et de peurs inexplorées, une riche toile tissée de ses rêves et de ses souvenirs"
  },
  Event_36734_Name = {
    Text = "Métamorphose Évolutive"
  },
  Event_36735_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36735_Desc = {
    Text = "\"Gardien, si tu ne peux pas tenir, s'il te plaît ne porte pas la douleur seul.\" \nVous n'évitez pas la douleur, car elle fait partie de la vie fugace. \nVous n'avez pas peur des ombres de la nuit, car vous ne craignez pas d'être dévoré par leur obscurité."
  },
  Event_36735_Name = {
    Text = "Douleur physique"
  },
  Event_36736_ChoiceDesc1 = {
    Text = "[Continuer à l'appeler] Augmenter Arg1 points de vie, infecter[(Skill.Arg2)]"
  },
  Event_36736_ChoiceDesc2 = {Text = "[Leave]"},
  Event_36736_Desc = {
    Text = "Des gribouillages innocents composent ce monde"
  },
  Event_36736_Name = {
    Text = "Métamorphose Évolutive"
  },
  Event_36737_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36737_Desc = {
    Text = "Les prières des marins tournent autour de moi, folles et étouffantes.\nMais elles n'affecteront pas ta volonté, absolument pas"
  },
  Event_36737_Name = {Text = "de la mer"},
  Event_36738_ChoiceDesc1 = {
    Text = "[Ramasser la photo] Choisissez 1 carte de commandement parmi 3 pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_36738_Desc = {
    Text = "Ces regards sont profonds et clairs, comme la lumière dans les profondeurs de la mer, brillants et chaleureux.\nIls ne parlent pas, ne se montrent pas, mais tu sens leur présence, comme une brise d'été"
  },
  Event_36738_Name = {
    Text = "Bonne curiosité"
  },
  Event_36739_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36739_Desc = {
    Text = "Tu te forces à te concentrer sur la crise actuelle, en ignorant la douleur"
  },
  Event_36739_Name = {
    Text = "Douleur physique"
  },
  Event_36740_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36740_Desc = {
    Text = "C'est la marque de la vie, la preuve de l'existence. Elle raconte une histoire, mais sous la tempête déchaînée, elle perd progressivement sa voix"
  },
  Event_36740_Name = {
    Text = "Au revoir, Icarus"
  },
  Event_36741_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36741_Desc = {
    Text = "Ces regards sont profonds et clairs, comme la lumière dans les profondeurs de la mer, brillants et chaleureux.\nIls ne parlent pas, ne se montrent pas, mais tu sens leur présence, comme une brise d'été"
  },
  Event_36741_Name = {
    Text = "Bonne curiosité"
  },
  Event_36742_ChoiceDesc1 = {
    Text = "[Dernier appel pour lui] Augmenter Arg1 points de vie, Infection[(Skill.Arg2)]"
  },
  Event_36742_ChoiceDesc2 = {Text = "[Leave]"},
  Event_36742_Desc = {
    Text = "Les fissures de douleur composent ce monde"
  },
  Event_36742_Name = {
    Text = "Métamorphose Évolutive"
  },
  Event_36743_ChoiceDesc1 = {
    Text = "[Embrace Pain] Obtenez Relique d'argent \"(RelicConfig.Arg1)\", infecté par \"(Skill.Arg2)\""
  },
  Event_36743_ChoiceDesc2 = {
    Text = "[Refuse Pain] Gagnez une Relique d'Or \"(RelicConfig.Arg1)\", Infection \"(Skill.Arg2)\" et \"(Skill.Arg3)\""
  },
  Event_36743_ChoiceDesc3 = {
    Text = "[Ignorez la douleur] Gagnez 25 Sigils Noirs"
  },
  Event_36743_Desc = {
    Text = "La douleur est comme une pierre dure, enracinée dans l’esprit. La souffrance qui se propage semble être une liane, enroulée autour de chaque nerf, déformant votre conscience"
  },
  Event_36743_Name = {
    Text = "Douleur physique"
  },
  Event_36744_ChoiceDesc1 = {
    Text = "[Appeler fermement] Augmenter Arg1 vie, infecter[(Skill.Arg2)]"
  },
  Event_36744_ChoiceDesc2 = {Text = "[Leave]"},
  Event_36744_Desc = {
    Text = "Le désir d'admission a formé ce monde"
  },
  Event_36744_Name = {
    Text = "Métamorphose Évolutive"
  },
  Event_36745_ChoiceDesc1 = {
    Text = "[Regarder eux] choisir 1 parmi 3 cartes de commandement pour obtenir une oraison : [(EnchantConfig.Arg1)]"
  },
  Event_36745_ChoiceDesc2 = {
    Text = "[demande de l'aide] contamine[(Skill.Arg1)], change l'oraison obtenue dans l'option 1, peut être utilisé deux fois"
  },
  Event_36745_Desc = {
    Text = ": Dans les couleurs fluides du domaine, tu ressentis un regard mystérieux, ce sont des yeux invisibles cachés dans les plis mystérieux de ce domaine. \n Au moment où ils se sont posés sur toi, un désir intense a surgi en toi"
  },
  Event_36745_Name = {
    Text = "Bonne curiosité"
  },
  Event_36746_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36746_Desc = {
    Text = "Si tu ne cherches pas à les comprendre, tu ne pourras pas sortir de ce chaos infernal. \n Lorsque les étoiles se reflètent à la surface de l'eau, ces désirs et supplications palpitants, ces prières s'élèvent lentement vers la surface de la mer comme des bulles, mais sont inévitablement englouties par les ténèbres."
  },
  Event_36746_Name = {Text = "de la mer"},
  Event_36747_ChoiceDesc1 = {
    Text = "[Appeler avec impatience] Augmenter de Arg1 points de vie, Infecter[(Skill.Arg2)]"
  },
  Event_36747_ChoiceDesc2 = {Text = "[Leave]"},
  Event_36747_Desc = {
    Text = "Des mots hideux composent ce monde"
  },
  Event_36747_Name = {
    Text = "Métamorphose Évolutive"
  },
  Event_36748_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36748_Desc = {
    Text = "Tu te tiens devant lui, voyant son âme dévorée par des souvenirs étranges"
  },
  Event_36748_Name = {
    Text = "Métamorphose Évolutive"
  },
  Event_36749_ChoiceDesc1 = {
    Text = "[Tears of Sorrow] Retirez 1 carte"
  },
  Event_36749_ChoiceDesc2 = {
    Text = "[That's Blood] Obtenez \"(RelicConfig.Arg1)\", infectez \"(Skill.Arg2)\""
  },
  Event_36749_Desc = {
    Text = "Quelques gouttes de liquide se répandirent sur le pont, s'infiltrant silencieusement dans les fissures.\nCes traces, douces mais déterminées, tissaient une toile de vie et de mort, de calme et de tumulte, dans le hurlement du vent marin et les gémissements du navire"
  },
  Event_36749_Name = {
    Text = "Au revoir, Icarus"
  },
  Event_36750_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36750_Desc = {
    Text = "Tu regardes les taches qui se répandent lentement, essayant de discerner leur nature, mais à la frontière entre ciel et terre, la différence entre la pluie et le sang devient floue.\nEst-ce de la pluie ? Des larmes de l'océan ?\nTu ne sais pas"
  },
  Event_36750_Name = {
    Text = "Au revoir, Icarus"
  },
  Event_36751_ChoiceDesc1 = {
    Text = "[Reject Sync] Obtenez une relique d'argent à 3 choix"
  },
  Event_36751_ChoiceDesc2 = {
    Text = "[Join Frequency] Obtenir une relique d'argent \"(RelicConfig.Arg1)\"\"(RelicConfig.Arg2)\" et infecter deux fois avec \"(Skill.Arg3)\"."
  },
  Event_36751_Desc = {
    Text = "Les murmures des Marins et les battements du «Saint Enfant» forment une symphonie secrète, chaque vibration provoquant un hurlement dans l'univers liquide infini"
  },
  Event_36751_Name = {Text = "de la mer"},
  Event_36752_ChoiceDesc1 = {
    Text = "[Ramasser la photo] Choisissez 1 carte de commandement parmi 3 pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_36752_ChoiceDesc2 = {
    Text = "[Vérifier le film] infecter [(Skill.Arg1)], remplacer l'oraison obtenue dans l'option 1, utilisable une fois de plus"
  },
  Event_36752_Desc = {
    Text = "Ils ne cherchent aucun mal, ce sentiment est comme une intuition, enracinée dans ta chair et ton sang.\n Par conséquent, tu relâches ton alerte et essaies de demander de l'aide à ces gardiens cachés : exprimer tes doutes et tes désirs à cette existence vague, comme à un vieil ami"
  },
  Event_36752_Name = {
    Text = "Bonne curiosité"
  },
  Event_36874_ChoiceDesc1 = {
    Text = "[Racontez des histoires amusantes sur l'école] obtenez une relique d'argent[(RelicConfig.Arg1)]"
  },
  Event_36874_ChoiceDesc2 = {
    Text = "[N'avoir jamais été à l'école] obtenir 75 le sigil noir, infecter [(Skill.Arg2)]"
  },
  Event_36874_Desc = {
    Text = "En passant devant une ruine, Aurita voit ses yeux s'illuminer. \n\"Grand-mère disait qu'avant, c'était une école, mais elle a été abandonnée faute d'élèves!\" \n\"Aurita n'est jamais allée à l'école, et tes amis? Es-tu allé à l'école?\""
  },
  Event_36874_Name = {
    Text = "Joie Perdue"
  },
  Event_36875_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36875_Desc = {
    Text = "Recevant une réponse négative de votre part, Aurita secoua la tête avec tristesse.\n\"Alors, le monde extérieur n'a pas d'élèves non plus... Quel était donc le but d'établir des écoles au départ ?\""
  },
  Event_36875_Name = {
    Text = "Joie Perdue"
  },
  Event_36876_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36876_Desc = {
    Text = "«Hôpital, petite souris, statue de cire... Youpi ! Une aventure, c'est une aventure !»\nAurita dit cela, un point d'interrogation invisible flottant au-dessus de sa tête.\n«Mais, grand-mère a dit que l'école est un endroit qui rendrait Aurita plus intelligente, mais... »\nAvant qu'Aurita ne puisse continuer à réfléchir, tu l'as poussée à tourner un autre coin."
  },
  Event_36876_Name = {
    Text = "Joie Perdue"
  },
  Event_36877_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36877_Desc = {
    Text = "\n\"W-pourquoi ?\" \nAurita a été surprise par toi et continue de te diriger avec une expression sévère.\n\"C'est la maison d'Aurita. Aurita sait que la place—est juste à l'intérieur !\""
  },
  Event_36877_Name = {
    Text = "Ténèbres invisibles"
  },
  Event_36878_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36878_Desc = {
    Text = "\"Je ne veux pas prendre ce chemin. Aurita sait-elle un autre moyen d'aller à la place ?\"\nAurita fit la moue, semblant confuse, mais finit par tirer sur votre manteau et vous guider dans une direction différente."
  },
  Event_36878_Name = {
    Text = "Ténèbres invisibles"
  },
  Event_36879_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36879_Desc = {
    Text = "C'est un rêve, ce n'est qu'un rêve.\nTu te répètes, ou dis que tu te rassures, entrainant Aurita dans l'obscurité invisible"
  },
  Event_36879_Name = {
    Text = "Ténèbres invisibles"
  },
  Event_36880_ChoiceDesc1 = {
    Text = "[Listen to Her] Choisissez 1 des 3 cartes de commandement pour gagner une oraison : \"(EnchantConfig.Arg1)\", et infectez \"(Skill.Arg2)\""
  },
  Event_36880_ChoiceDesc2 = {
    Text = "[S'opposer à elle] Choisir de réveiller un éveillé, infection[(Skill.Arg1)]"
  },
  Event_36880_ChoiceDesc3 = {
    Text = "[Negotiate with Her] Gagnez 25 Sigils Noirs"
  },
  Event_36880_Desc = {
    Text = "Aurita te tire par ta cape, avançant pas à pas sur tes empreintes. \n « Tiens... ce n'est pas ça ! La place est dans cette direction ! » \n Tu tournes la tête vers la direction indiquée par Aurita, et le couloir dans le Labyrinthe est manifestement plongé dans l'obscurité. La lave corrodée et les mutants se tordent et s'entrelacent, entraînant le monde réel dans un abîme de chute."
  },
  Event_36880_Name = {
    Text = "Ténèbres invisibles"
  },
  Event_37983_ChoiceDesc1 = {
    Text = "[Secure Funding] Gagnez Arg1 sigils noirs."
  },
  Event_37983_ChoiceDesc2 = {
    Text = "[Secure Funding] Gagnez Arg1 sigils noirs [ExDesc1]."
  },
  Event_37983_Desc = {
    Text = "« Aucun seigneur ne laissera un inconnu traîner, encore moins un moine. »\nLa reine était assise sur son trône élevé, une lueur de tyrannie passant brièvement dans ses yeux. \n« Prouve que tu es utile d'une autre manière, sinon... » \nD'une autre manière ? Tu regardes par la fenêtre les champs désolés, une idée surgit soudain : peut-être que je peux utiliser mes connaissances en économie pour aider Wanda à gérer le domaine ? \nTu fouilles désespérément dans ton cerveau stérile et lisse — il faut dire qu'à Mizag, l'économie n'est qu'un cours électif insignifiant... \nLa patience s'épuise. La reine bâille. \n« Décevant. Lâcher — » \nAu moment où la guillotine tombe, les esprits des grands ancêtres comme Adam Smith, Malthus, David Ricardo, etc., descendent dans ta petite tête. \nLa division du travail ! La fiscalité ! La population, bon sang, la population ! \nTu as peut-être, probablement, trouvé une idée."
  },
  Event_37983_Name = {
    Text = "Ordre secret"
  },
  Event_37984_ChoiceDesc1 = {Text = "[Leave]"},
  Event_37984_Desc = {
    Text = "Vous présentez à contrecoeur le décret.\nLa reine le feuillette et esquisse un sourire froid :\n\"Si cela s'avère inutile, vous savez ce qui va se passer.\""
  },
  Event_37984_Name = {
    Text = "Ordre secret"
  },
  Event_37985_ChoiceDesc1 = {
    Text = "[Proposer un décret] Obtenez une relique d'argent[(RelicConfig.Arg1)]"
  },
  Event_37985_ChoiceDesc2 = {
    Text = "[Proposer un décret] Obtenez une relique maudite[(RelicConfig.Arg1)]"
  },
  Event_37985_ChoiceDesc3 = {
    Text = "[Proposer un décret] Obtenez une relique en or[(RelicConfig.Arg1)]"
  },
  Event_37985_Desc = {
    Text = "\n\"Après avoir pris mon argent, tu dois me servir.\" \nLa reine appuya son menton sur une main, te regardant d'un air désinvolte.\nQu'elle l'admette ou non, elle est en effet curieuse à ce sujet.\n\"Alors, dis-moi ton plan, grand réformateur.\""
  },
  Event_37985_Name = {
    Text = "Ordre secret"
  },
  Event_38700_ChoiceDesc1 = {
    Text = "[Activer] Restaurez Arg2 Vie [ExDesc1]."
  },
  Event_38700_ChoiceDesc2 = {
    Text = "[Meditate] Choisir de Réveiller 1 Réveilleur."
  },
  Event_38700_ChoiceDesc3 = {
    Text = "[Expel] Éliminez jusqu'à 3 cartes de symptômes, et gagnez des sigils noirs Arg2."
  },
  Event_38700_Desc = {
    Text = "Tu explores dans la brume, soudain, l'insigne sur ta poitrine émet une faible lueur argentée. Qui t'appelle de l'autre côté de la communication ?"
  },
  Event_38700_Name = {
    Text = "Point de contact"
  },
  Event_38700_Tips3 = {
    Text = "Aucune carte de symptôme"
  },
  Event_38707_ChoiceDesc1 = {
    Text = "[Dispel the Illusion] Symptôme infecté."
  },
  Event_38707_ChoiceDesc2 = {
    Text = "[Absorber Illusion] Perdez Arg1 Vie, Gagnez Arg2 Le sigil noir"
  },
  Event_38707_ChoiceDesc3 = {Text = "[Leave]"},
  Event_38707_Desc = {
    Text = "Des visages flous apparaissent soudainement, entourant et gémissant désespérément sans cordes vocales"
  },
  Event_38707_Name = {Text = "Illusion"},
  Event_38715_ChoiceDesc1 = {
    Text = "[Propose Decree] Obtenez la Relique Argent \"(RelicConfig.Arg1)\" et \"(RelicConfig.Arg2)\""
  },
  Event_38715_ChoiceDesc2 = {
    Text = "[Proposer un décret] Obtenez une relique maudite[(RelicConfig.Arg1)]"
  },
  Event_38715_ChoiceDesc3 = {
    Text = "[Proposer un décret] Obtenez une relique en or[(RelicConfig.Arg1)]"
  },
  Event_38715_Desc = {
    Text = "\n\"Après avoir pris mon argent, tu dois me servir.\" \nLa reine appuya son menton sur une main, te regardant d'un air désinvolte.\nQu'elle l'admette ou non, elle est en effet curieuse à ce sujet.\n\"Alors, dis-moi ton plan, grand réformateur.\""
  },
  Event_38715_Name = {
    Text = "Ordre secret"
  },
  Event_40452_ChoiceDesc1 = {
    Text = "[Demander l'Identité] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : [(EnchantConfig.Arg1)]"
  },
  Event_40452_ChoiceDesc2 = {
    Text = "[Leave] Accorde aléatoirement 3 cartes de commandement une Oraison : \"(EnchantConfig.Arg1)\", et infecte-les avec \"(Skill.Arg2)\"."
  },
  Event_40452_Desc = {
    Text = "Trois fantômes bloquaient le chemin.\nIls entouraient la table de jeu, leurs yeux fixés sur les dés.\n\"Gulp, gulp.\"\nLes dés ont été lancés et sont tombés maintes et maintes fois.\nC'est un pari sans fin."
  },
  Event_40452_Name = {
    Text = "Partie de jeu sans fin"
  },
  Event_40453_ChoiceDesc1 = {Text = "[Leave]"},
  Event_40453_Desc = {
    Text = "« Bonjour, nous sommes le premier, le deuxième et le troisième mari de Wanda. »\n« Quoi, tu demandes où est le quatrième mari ?\n Eh bien... pour être honnête, John manque un peu d'humour, alors il a été transformé en serviteur aveugle par Madame. »\n« Nous sommes tous très tristes de sa perte. Bien sûr, juste un tout petit peu. »"
  },
  Event_40453_Name = {
    Text = "Partie de jeu sans fin"
  },
  Event_40454_ChoiceDesc1 = {
    Text = "[Serrer la main] Éveiller aléatoirement un réveilleur, infecter [(Skill.Arg1) ]"
  },
  Event_40454_ChoiceDesc2 = {
    Text = "[Leave] Obtenir 1 parmi 3 Oraisons"
  },
  Event_40454_Desc = {
    Text = ": En passant devant une cage, une main en sortit.\n\"Ne me quitte pas, Rebecca...\"\nLa voix était vieille et sèche, comme un soufflet usé"
  },
  Event_40454_Name = {Text = "Prisonnier"},
  Event_40455_ChoiceDesc1 = {Text = "[Leave]"},
  Event_40455_Desc = {
    Text = "Une sensation collante provient de la paume de votre main — c'est la d-boue.\nLe maître de la voix a disparu à un moment donné, se cachant dans l'ombre sombre du coin"
  },
  Event_40455_Name = {Text = "Prisonnier"},
  Event_40456_ChoiceDesc1 = {Text = "[Leave]"},
  Event_40456_Desc = {
    Text = "Tu pars sans te soucier, manquant l'histoire dramatique au dos de la lettre.\nMais qu'importe ?\nL'océan vaste, l'aube et le crépuscule, le désert équatorial...\nTu verras plus, et tu manqueras plus"
  },
  Event_40456_Name = {
    Text = "À ma chère épouse"
  },
  Event_40457_ChoiceDesc1 = {Text = "[Leave]"},
  Event_40457_Desc = {
    Text = "En un sens, tu n'es pas différent de ce prisonnier.\nCe n'est pas le moment de l'alerter.\nTu ignores ses supplications et t'éloignes"
  },
  Event_40457_Name = {Text = "Prisonnier"},
  Event_40458_ChoiceDesc1 = {
    Text = "[Déchirer la Lettre] Choisir une relique pour la changer en relique maudite [(RelicConfig.Arg1)]"
  },
  Event_40458_ChoiceDesc2 = {
    Text = "[Ignore the Letter] Obtenez Relique d'argent \"(RelicConfig.Arg1)\", infectez \"(Skill.Arg2)\""
  },
  Event_40458_ChoiceDesc3 = {
    Text = "[Reply] Obtenez 25 sigils noirs"
  },
  Event_40458_Desc = {
    Text = "Ⅰ. Lettre de John Cambrien à Wanda (deux ans avant Aluviion) \n\n Un mari a le droit de disposer de sa femme, du moins à Cambrian. \n Mais j'ai manifestement sous-estimé ton degré de folie. Maintenant, mes yeux sont presque entièrement aveugles et mes membres vont bientôt être amputés. \n Fille du démon. Fille du démon... Non, tu es le démon lui-même. \n Je te maudis @1 te maudis @2 te maudis te maudis..."
  },
  Event_40458_Name = {
    Text = "À ma chère épouse"
  },
  Event_40459_ChoiceDesc1 = {Text = "[Leave]"},
  Event_40459_Desc = {
    Text = "Tu as utilisé la méthode la plus simple pour lever la malédiction.\nRien ne se passe. Le papier tombe au sol sans vie.\nTu hausses les épaules et pars, mais tu as un sentiment étrange"
  },
  Event_40459_Name = {
    Text = "À ma chère épouse"
  },
  Event_40460_ChoiceDesc1 = {Text = "[Leave]"},
  Event_40460_Desc = {
    Text = "Vous passez devant la table de jeu sans y penser à deux fois.\nEn vous élançant, les fantômes parlent à l'unisson :\n\"Veuillez transmettre nos salutations à notre ex-femme commune, Mme Wanda.\""
  },
  Event_40460_Name = {
    Text = "Partie de jeu sans fin"
  },
  Event_40461_ChoiceDesc1 = {Text = "[Leave]"},
  Event_40461_Desc = {
    Text = "Vous écrivez soigneusement votre réponse à la fin de la lettre :\n\"Malédiction reçue. Je vous souhaite le meilleur.\"\nAlors que le dernier trait tombe, des flammes bleues en colère s'embrasent sur le papier.\nVous rassemblez les cendres."
  },
  Event_40461_Name = {
    Text = "À ma chère épouse"
  },
  Event_44187_ChoiceDesc1 = {
    Text = "[Facing the Darkness][ExDesc1][ExDesc2]"
  },
  Event_44187_ChoiceDesc2 = {
    Text = "[Facing the Darkness][ExDesc1][ExDesc2]"
  },
  Event_44187_ChoiceDesc3 = {
    Text = "[Escape the Darkness] Obtenez une Relique d'Or aléatoire"
  },
  Event_44187_Desc = {
    Text = "L'âme devant toi est sombre et souillée - la lumière et les ténèbres coexistent en elle. Elles luttent pour la domination, tandis que l'âme est plongée dans la confusion. \n « Je les plains, ces pauvres gens qui ont tout perdu, mais n'est-ce pas ainsi que fonctionne ce monde ? \n « Quand quelqu'un gagne, quelqu'un perd. \n « Dois-je renoncer à mon bonheur pour le bonheur des autres ? »"
  },
  Event_44187_Name = {
    Text = "Ténèbres intérieures"
  },
  Event_44188_ChoiceDesc1 = {Text = "[Leave]"},
  Event_44188_Desc = {
    Text = "\"C'est mon péché, mon fardeau. Comment puis-je te sauver, mon âme contradictoire ?\""
  },
  Event_44188_Name = {
    Text = "Ténèbres intérieures"
  },
  Event_44299_ChoiceDesc1 = {
    Text = "[Plea to the Bishop] Purifier une Relique Maudite. S'il n'y a pas de Relique Maudite, gagner une Relique en Or aléatoire."
  },
  Event_44299_Desc = {
    Text = "«J'ai trompé et manipulé pour obtenir la vie que je voulais - l'argent est devenu des chiffres, les délices sont devenus des plats ordinaires. Dans le commerce, je fais ce que je veux, en politique, j'ai une poigne de fer. Mais pourquoi, pourquoi ne puis-je pas oublier ces personnes, celles à qui j'ai tout pris ? Pourquoi ne puis-je pas oublier le désespoir sur leurs visages ?\n«L'alcool ne peut offrir qu'une évasion temporaire, mon âme se déchire, la souffrance m'engloutit presque.\n«Que devrais-je faire ?»"
  },
  Event_44299_Name = {
    Text = "Culpabilité et Pardon"
  },
  Event_44301_ChoiceDesc1 = {Text = "[Leave]"},
  Event_44301_Desc = {
    Text = "\"Vous marchez sur un chemin de souffrance, vous écartant de la gloire du Père.\n\"Retournez, brebis égarée. Écoutez les enseignements du Père et trouvez le bon chemin.\"\""
  },
  Event_44301_Name = {
    Text = "Culpabilité et Pardon"
  },
  Event_44395_ChoiceDesc1 = {
    Text = "[Seek External Object] L'Évêque prend 1 de vos Symptômes. Vous gagnez Arg1 Sigil Noir. Si vous n'avez pas de Symptômes, vous gagnez le Sigil Noir directement."
  },
  Event_44395_ChoiceDesc2 = {
    Text = "[Demander du sang] l'évêque subit 2 de vos symptômes, vous obtenez l'oraison [(EnchantConfig.Arg1)]"
  },
  Event_44395_ChoiceDesc3 = {
    Text = "[Ask for More] L'Évêque prend plus de Symptômes (au moins 4 cartes)"
  },
  Event_44395_Desc = {
    Text = "Une âme illusoire forme un contour flou, elle est à genoux devant l'évêque, montrant son corps brisé et son cœur noirci. \n « Tu m'as donné des conseils, m'as donné le pardon, m'as donné la rédemption, mais oh évêque bienveillant, cela ne suffit pas. \n Je suis dans la misère, malade. Ma vie est en jeu, et tu es ma seule rédemption. Sauvez-moi, évêque, afin que je ne souffre plus. »"
  },
  Event_44395_Name = {
    Text = "Bénédiction de l'Évêque"
  },
  Event_44396_ChoiceDesc1 = {
    Text = "[Bow and Leave]"
  },
  Event_44396_Desc = {
    Text = "L'évêque enlève sa bague et retire son épingle. Les pierres précieuses bleues, symbolisant le Père Dieu, sont placées une à une dans les mains de l'âme pauvre, l'évêque se penche et saisit les mains de cette âme malheureuse. \n « Prends tout l'or et l'argent que j'ai, prends tous mes biens—tant que c'est ce dont tu as besoin. L'enseignement du Père Dieu me suffit pour vivre. »"
  },
  Event_44396_Name = {
    Text = "Bénédiction de l'Évêque"
  },
  Event_44400_ChoiceDesc1 = {
    Text = "[S'y plonger] Infection[(Skill.Arg1)], réveiller un éveillé aléatoire"
  },
  Event_44400_ChoiceDesc2 = {
    Text = "[Abandonner]"
  },
  Event_44400_Desc = {
    Text = "Les âmes perdues ne veulent pas abandonner les ténèbres.\nTu sais ce qui les attend. Une vie absurde va se dérouler, et tu en seras le seul spectateur"
  },
  Event_44400_Name = {
    Text = "Ténèbres intérieures"
  },
  Event_44401_ChoiceDesc1 = {
    Text = "[Réflexes Rapides] Gagner Arg1 sigils noirs"
  },
  Event_44401_ChoiceDesc2 = {
    Text = "[Prendre sans réserve] obtenez 3 choix 1 oraison avancée, infection[(Skill.Arg1)]"
  },
  Event_44401_Desc = {
    Text = ": Les marques noires trouvées dans le domaine peuvent être sacrifiées à d-marque pour échanger des reliques et d'autres projections spirituelles. Elles se dissiperont sous forme de boue noire peu après avoir quitté la zone actuelle"
  },
  Event_44401_Name = {
    Text = "Marque noire"
  },
  Event_44407_ChoiceDesc1 = {
    Text = "[Dispel the Illusion] Symptôme infecté."
  },
  Event_44407_ChoiceDesc2 = {
    Text = "[Embrace Delusion] Gagnez 2 symptômes aléatoires et Arg1 Sigil Noir."
  },
  Event_44407_ChoiceDesc3 = {Text = "[Leave]"},
  Event_44407_Desc = {
    Text = "Des visages flous apparaissent soudainement, entourant et gémissant désespérément sans cordes vocales"
  },
  Event_44407_Name = {Text = "Illusion"},
  Event_44445_ChoiceDesc1 = {
    Text = "[Leave] Trouver un phare de recherche"
  },
  Event_44445_ChoiceDesc2 = {
    Text = "[Break into Mist] Perdre Arg2 Vie"
  },
  Event_44445_ChoiceDesc3 = {
    Text = "[Abandonner le superflu] déduisez 5 sigils noirs, obtenez 1[inspiration]"
  },
  Event_44445_Desc = {
    Text = "Devant se trouve une brume noire épaisse, entrer imprudemment entraînera des clades.\nPeut-être devriez-vous trouver un « projecteur » pour dissiper la brume"
  },
  Event_44445_Name = {Text = "inconnu"},
  Event_44469_ChoiceDesc1 = {
    Text = "[Seek Flesh] L'Évêque prend 4 Symptômes de vous, et vous choisissez 1 sur 3 Reliques d'Or+."
  },
  Event_44469_ChoiceDesc2 = {
    Text = "[Ask for Blessing] L'Évêque prend vos 6 Symptômes, et vous recevez un Pendule Chrono à 3 choix."
  },
  Event_44469_ChoiceDesc3 = {Text = "[Return]"},
  Event_44469_Desc = {
    Text = "Une âme illusoire se matérialise sous une forme floue, elle s'agenouille devant l'évêque, montrant son corps brisé et son cœur noirci. \n « Tu me donnes des conseils, tu me donnes le pardon, tu me donnes la rédemption, mais, évêque bienveillant, cela n'est pas suffisant. \n « Je suis dans le besoin, atteint de maladie. Ma vie est en jeu, et tu es ma seule rédemption. Sauvez-moi, évêque, afin que je ne souffre plus. »"
  },
  Event_44469_Name = {
    Text = "Bénédiction de l'Évêque"
  },
  Event_44474_ChoiceDesc1 = {
    Text = "[Plea] Recevoir la Bénédiction de l'Évêque"
  },
  Event_44474_ChoiceDesc2 = {
    Text = "[Plea] Recevoir la Bénédiction de l'Évêque"
  },
  Event_44474_ChoiceDesc3 = {Text = "[Leave]"},
  Event_44474_Desc = {
    Text = "\"C'est mon péché, mon fardeau. Comment puis-je te sauver, mon âme contradictoire ?\""
  },
  Event_44474_Name = {
    Text = "Ténèbres intérieures"
  },
  Event_44911_ChoiceDesc1 = {Text = "[Leave]"},
  Event_44911_Desc = {
    Text = "\n\"Tout, tout... C'est exact, je veux tout...!\" \nL'âme tendit la main, s'efforçant vainement d'attraper l'air.\nElle a gagné quelque chose mais a tout perdu."
  },
  Event_44911_Name = {
    Text = "Que as-tu obtenu"
  },
  Event_44913_ChoiceDesc1 = {Text = "[Leave]"},
  Event_44913_Desc = {
    Text = "\"Seulement le plus important... le plus crucial...\" \n L'Âme s'est accroupie, a déterré un vœu radiant du sol de l'Illusion, et l'a tenu dans ses paumes."
  },
  Event_44913_Name = {
    Text = "Que as-tu obtenu"
  },
  Event_44916_ChoiceDesc1 = {
    Text = "[Tout saisir] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : [(EnchantConfig.Arg1)]"
  },
  Event_44916_ChoiceDesc2 = {
    Text = "[Learn to Let Go] Accordez aléatoirement une oraison à 3 cartes de commande : \"(EnchantConfig.Arg1)\", infectez \"(Skill.Arg2)\""
  },
  Event_44916_Desc = {
    Text = "L'âme terne est plongée dans la douleur.\nElle erre, confuse par toutes les options et conséquences possibles.\n« Que dois-je choisir ? » murmure-t-elle, « Que dois-je faire ? »\n« Comment puis-je tout avoir ? »"
  },
  Event_44916_Name = {
    Text = "Que as-tu obtenu"
  },
  Event_44919_ChoiceDesc1 = {
    Text = "[auto-réflexion] éveillez aléatoirement un réveilleur, infectez [(Skill.Arg1)]"
  },
  Event_44919_ChoiceDesc2 = {
    Text = "[Regardez autour] Obtenez une Oraison à 3 choix"
  },
  Event_44919_Desc = {
    Text = "L'âme flottante est prise dans un dilemme.\nElle s'arrête, hésitant entre les désirs.\n\"Que devrais-je choisir ?\" murmure-t-elle doucement, \"Que devrais-je faire ?\"\n\"Lequel est mon vrai désir ?\""
  },
  Event_44919_Name = {
    Text = "Que désires-tu"
  },
  Event_44920_ChoiceDesc1 = {Text = "[Leave]"},
  Event_44920_Desc = {
    Text = "\n\"Tu as raison, j'ai besoin de voir, j'ai besoin de voir...\" \nIl baisse la tête, ses mains fouillant dans sa cavité thoracique, en sortant un cœur fantomatique : une moitié aussi noire que l'encre, l'autre moitié aussi brillante qu'une étoile."
  },
  Event_44920_Name = {
    Text = "Que désires-tu"
  },
  Event_44921_ChoiceDesc1 = {Text = "[Leave]"},
  Event_44921_Desc = {
    Text = "\n\"Oui, oui... Les gens disent que les autres peuvent être un miroir... J'ai besoin de voir...\" \nIl se pencha en avant, te regardant avec son visage sans traits. \n\"Pourquoi n'es-tu pas troublé ? Si envieux, si envieux...\""
  },
  Event_44921_Name = {
    Text = "Que désires-tu"
  },
  Event_44998_ChoiceDesc1 = {Text = "[Leave]"},
  Event_44998_Desc = {
    Text = "« Ils disent que la souffrance actuelle est temporaire, qu'après la mort, nous jouirons éternellement de la joie dans les bras de Dieu le Père. \n « Je ne veux pas attendre la mort. » \n L'ombre dévore tout avec gourmandise, l'âme s'assombrit, presque fusionnée avec les ténèbres environnantes. \n Tu veux agir, mais tu es impuissant."
  },
  Event_44998_Name = {
    Text = "Ténèbres intérieures"
  },
  Event_45000_ChoiceDesc1 = {
    Text = "[Bow and Leave]"
  },
  Event_45000_Desc = {
    Text = "L'évêque utilise une lame pour ouvrir sa paume, le sang qui coule sur la tablette se transforme en une lumière bleue curative, comblant le sang manquant de l'âme.\n\"Prends mon sang, comble ta vie—tant que c'est ce dont tu as besoin. C'est ce que le Père veut que je fasse.\""
  },
  Event_45000_Name = {
    Text = "Bénédiction de l'Évêque"
  },
  Event_45001_ChoiceDesc1 = {
    Text = "[Bow and Leave]"
  },
  Event_45001_Desc = {
    Text = "L'évêque tire son âme des profondeurs de sa poitrine. Des points de lumière douce s'intègrent dans l'ardoise, se transformant en une lumière bleue curative, comblant toutes les fissures de l'âme.\n« Reçois cela, c'est le don du Père Dieu, la preuve de son amour. Que ton corps soit en bonne santé, que ton âme soit complète, et que tu ne souffres plus. »"
  },
  Event_45001_Name = {
    Text = "Bénédiction de l'Évêque"
  },
  Event_45002_ChoiceDesc1 = {Text = "[Leave]"},
  Event_45002_Desc = {
    Text = "Tu avances vers ces visages, et en rouvrant les yeux, tout est noir. Seuls des rires mystérieux résonnent autour de toi"
  },
  Event_45002_Name = {Text = "Illusion"},
  Event_45036_ChoiceDesc1 = {
    Text = "[Delete All Relics]"
  },
  Event_45036_Desc = {
    Text = "\"C'est mon péché, mon fardeau. Comment puis-je te sauver, mon âme contradictoire ?\""
  },
  Event_45036_Name = {
    Text = "Ténèbres intérieures"
  },
  Event_45196_ChoiceDesc1 = {
    Text = "[Bow and Leave]"
  },
  Event_45196_Desc = {
    Text = "Le Fou utilise une Lame pour trancher chair et os, les os pâles et la chair L'Écarlate fusionnent avec l'ardoise, se transformant en une lumière bleue curative, comblant les os brisés de l'âme.\n« Prends ma chair et mes os, comble ton corps manquant—tant que c'est ce dont tu as besoin. C'est ce que le Père Dieu veut que je fasse. »"
  },
  Event_45196_Name = {
    Text = "Bénédiction de l'Évêque"
  },
  Event_46144_ChoiceDesc1 = {
    Text = "[Partir] Obtient 3 choix 1 relique d'argent, infection[(Skill.Arg1)]"
  },
  Event_46144_Desc = {
    Text = "L'ombre floue devient progressivement claire. Ce n'est pas un corps de fusion, ni un cataclysme, mais Clémentine, sans ailes et avec une expression normale. \n « Quelle coïncidence, es-tu aussi venu admirer la lumière de la lune ? » dit-elle en souriant, mais tu ressens une vague de vertige. « Par une nuit de brume, il faut faire preuve de prudence. \n « Les petits ici ne sont pas très sages. »"
  },
  Event_46144_Name = {
    Text = "Figure dans la brume"
  },
  Event_46145_ChoiceDesc1 = {
    Text = "[Partir] Obtient 3 choix 1 relique en or, infection[(Skill.Arg1)]"
  },
  Event_46145_Desc = {
    Text = "Tu ne bouges pas. Une dame s'élance soudain sur scène. \n Elle ouvre la bouche du garçon avec frénésie et enfonce violemment le bâton qu'elle tient. \n « Parle, dis-moi quelque chose. » \n Du sang noir coule de la bouche du garçon. Il continue à réciter de manière indistincte. \n « Chanson pour maman... »"
  },
  Event_46145_Name = {
    Text = "Cérémonie finale III"
  },
  Event_47309_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47309_Desc = {
    Text = "Ce jour-là, Dieu infligera une punition au péririte avec son grand et puissant couteau,\nà cause des meurtres qu'ils ont \"commis\".\nQuoi, tu dis que ce n'est pas juste ?\nNon, c'est le destin du chasseur"
  },
  Event_47309_Name = {
    Text = "Chant de marin"
  },
  Event_47310_ChoiceDesc1 = {
    Text = "[Keep Listening] Obtenez une Relique Maudite \"(RelicConfig.Arg1)\", infectez \"(Skill.Arg2)\""
  },
  Event_47310_ChoiceDesc2 = {
    Text = "[Partir] 1 Carte d'instruction aléatoire obtient l'Oraison : [(EnchantConfig.Arg1)]"
  },
  Event_47310_Desc = {
    Text = "Dieu dit : Appelons-le Philistin. \nQu'il porte la responsabilité du meurtre, qu'il porte la malédiction de la gourmandise. \nQue le chemin qu'il emprunte brille, faisant penser à l'abîme comme aux cheveux blancs. \nDans l'immensité de l'océan, il n'y a pas de plus grand requin. \nQu'il soit craint et vénéré par tous les êtres, \njusqu'à l'instant où le Jugement viendra."
  },
  Event_47310_Name = {
    Text = "Chant de marin"
  },
  Event_47311_ChoiceDesc1 = {
    Text = "[Partir] Infection[(Skill.Arg1)]"
  },
  Event_47311_ChoiceDesc2 = {
    Text = "[Partir] Infection[(Skill.Arg1)]"
  },
  Event_47311_ChoiceDesc3 = {
    Text = "[Partir] Infection[(Skill.Arg1)]"
  },
  Event_47311_Desc = {
    Text = "Le garçon est un esclave méprisable. \n Son maître le traite comme un fils, mais il est poignardé dans son lit. \n « Je vous aime, père. Je ne veux plus être esclave. » \n Plus tard, le garçon se tient devant la tombe de son « père », se remémorant les paroles du prêtre : \n <Small: ne quitte pas la terre qui t'a donné la vie. \n À ce moment-là, tes mains seront couvertes de sang, tu mourras sans dignité. \n Les chiens sauvages, les vautours et les poissons de mer te mépriseront. > \n Le garçon nommé Avec Glen finit par partir. \n Il écrira son histoire infâme."
  },
  Event_47311_Name = {
    Text = "Garçon dans le tonneau"
  },
  Event_47312_ChoiceDesc1 = {
    Text = "[Tourner la page] Obtenez une relique d'argent[(RelicConfig.Arg1)] et choisissez d'infecter 1 fois un symptôme"
  },
  Event_47312_ChoiceDesc2 = {
    Text = "[Turn Page Backward] Choisissez 1 parmi 3 cartes de commandement pour obtenir une Oraison : \"(EnchantConfig.Arg1)\", infectez \"(Skill.Arg2)\""
  },
  Event_47312_ChoiceDesc3 = {
    Text = "[Discard] Gagnez 25 Sigils Noirs"
  },
  Event_47312_Desc = {
    Text = "Tu trouves un livre relié en papyrus : \n…\nLe garçon se cache dans un tonneau, une petite île des Philistins dérivant vers lui. \nIl est faible, vile, et ambitieux. \nLorsque la gloire des géants immortels impressionne tout le monde, \nseul le garçon reste dans l'ombre, ne laissant pas cette lumière s'approcher de lui. \nPlus tard, il est chargé d'une grande mission par Goliath. \nQuant à la raison—"
  },
  Event_47312_Name = {
    Text = "Garçon dans le tonneau"
  },
  Event_47313_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47313_Desc = {
    Text = "Le géant alors dit : \n\"Je le garde à mes côtés parce qu'il est à la fois mélancolique et comique.\nEt il ne pourra jamais me tuer.\""
  },
  Event_47313_Name = {
    Text = "Garçon dans le tonneau"
  },
  Event_47314_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47314_Desc = {
    Text = "\nVous n'avez pas entendu la dernière partie, mais ses paroles vous rappelaient une autre chanson : \n« Ce rare requin géant, au milieu de la tempête et de la pluie,\nL'océan est son foyer,\nPuisque le pouvoir est justice, il est le géant du pouvoir,\nLe roi de l'océan sans limites. »"
  },
  Event_47314_Name = {
    Text = "Chant de marin"
  },
  Event_47315_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47315_Desc = {
    Text = ": Ce n'est pas le bon moment pour lire.\nTu jettes le livre précipitamment, sans voir la fin :\n...\nIl se cache dans l'ombre, non par jalousie.\nMais par pure peur.\nExposé à la lumière, son âme vile serait anéantie.\nMême les cendres disparaîtraient"
  },
  Event_47315_Name = {
    Text = "Garçon dans le tonneau"
  },
  Event_47463_ChoiceDesc1 = {
    Text = "[Enter Hypnosis] Sélectionnez un Éveilleur pour subir une Division d'Esprit, perdant leurs quatre cartes de Commandement initiales."
  },
  Event_47463_Desc = {
    Text = "Le médecin leva les yeux de ses nombreux livres : \n « Tu es un échantillon rare, donc je ne te facturerai pas. \n Mais j'ai besoin d'une autre forme de compensation : une hypnose. \n C'est une nouvelle méthode thérapeutique qui apporte une conscience totalement dénudée et sans réserve. \n Qu'en dis-tu, es-tu prêt à essayer ? »"
  },
  Event_47463_Name = {
    Text = "Serpent hypnotiseur"
  },
  Event_47464_ChoiceDesc1 = {
    Text = "[Shining Memory][ExDesc1][ExDesc2]"
  },
  Event_47464_ChoiceDesc2 = {
    Text = "[Faded Memory] Améliorez toutes les oraisons Ensemble dans le deck pour des oraisons Ensemble Avancées."
  },
  Event_47464_Desc = {
    Text = "Elle erre sur la plage de la mer de la conscience. \n Les jupes des vagues lèchent ses pieds, apportant des souvenirs éparpillés sur le rivage. \n Certains brillent, d'autres sont ternes, et certains sentent comme la saison des pluies à Londinium. \n Lequel de ces souvenirs choisis-tu de ramasser ? Elle erre sur la plage de la mer de la conscience."
  },
  Event_47464_Name = {
    Text = ":\"Fusion Principale\""
  },
  Event_47465_ChoiceDesc1 = {
    Text = "[Refuser d'essayer] 1 Carte d'instruction aléatoire obtient l'Oraison : [(EnchantConfig.Arg1)]"
  },
  Event_47465_ChoiceDesc2 = {
    Text = "[Smash Solvent] Purifie la Reliques de Négentropie"
  },
  Event_47465_ChoiceDesc3 = {
    Text = "[Accepter l'expérience] Obtenez 1 pendule chronique[(RelicConfig.Arg1)]"
  },
  Event_47465_Desc = {
    Text = "Le médecin secoue le solvant vert émeraude, l'excitation dans la voix : \n« Bois une gorgée, tu pourras entrer dans un rêve éveillé. \n C'est la réincarnation de la pensée du subconscient collectif. \n Maintenant, tu partageras le même océan de conscience avec des milliers d'êtres vivants, \n veux-tu essayer ? »"
  },
  Event_47465_Name = {
    Text = ":\"Rêve Lucide\""
  },
  Event_47466_ChoiceDesc1 = {
    Text = "[Answer Voice] Obtenir 1 Carte de Commande du Spirit Split Awakener."
  },
  Event_47466_Desc = {
    Text = "Le corps est une prison, enfermant des personnalités fragmentées.\nLa prison nommée \"24\" est maintenant pleine.\n\"Ne dors pas, ne sois pas calme.\"\nDans l'obscurité, une voix murmure doucement"
  },
  Event_47466_Name = {
    Text = "\"Connaissance de soi\""
  },
  Event_47848_ChoiceDesc1 = {
    Text = "[Close Eyes] Obtain 1 of 3 Gold Relics"
  },
  Event_47848_ChoiceDesc2 = {
    Text = "[Sneak a Peek] Choisissez de Réveiller 2 Réveilleurs et réduisez leur coût Arithmetica de 1."
  },
  Event_47848_ChoiceDesc3 = {
    Text = "[Open Your Eyes] Gagner les reliques argent \"(RelicConfig.Arg1)\", \"(RelicConfig.Arg2)\", et \"(RelicConfig.Arg3)\""
  },
  Event_47848_Desc = {
    Text = "Avant d'entrer en hypnose, le médecin dit : \n « Ne rouvre pas les yeux sans ma permission. » \n Alors elle ferme les yeux, inspire… expire… \n Entre le sommeil et l'éveil, elle semble entendre un souffle « sifflant ». \n Puis elle se retrouve sous un regard glacé — \n quelque chose l'observe. \n Devrait-elle ouvrir les yeux et jeter un coup d'œil discrètement ?"
  },
  Event_47848_Name = {
    Text = "Serpent hypnotiseur"
  },
  Event_47876_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47876_Desc = {
    Text = "Elle se pencha pour ramasser des souvenirs brillants.\nUn, deux... d'innombrables joies affluèrent,\nElle ouvrit les bras et tourna autour d'eux"
  },
  Event_47876_Name = {
    Text = ":\"Fusion Principale\""
  },
  Event_47877_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47877_Desc = {
    Text = "Elle se pencha pour ramasser les souvenirs ternes.\nUn, deux... d'innombrables petits souvenirs affluèrent,\nElle ouvrit les bras et les embrassa tous."
  },
  Event_47877_Name = {
    Text = ":\"Fusion Principale\""
  },
  Event_47878_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47878_Desc = {
    Text = "Tu refuses de devenir une victime de ces étranges solvants.\nLe docteur est un peu déçu, mais il ne te force pas.\n\"Je pardonne la lâcheté et la myopie de l'humanité.\""
  },
  Event_47878_Name = {
    Text = ":\"Rêve Lucide\""
  },
  Event_47879_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47879_Desc = {
    Text = "Crash! Vous brisez la bouteille.\nLa solution verte corrode rapidement le sol.\n\"Eh bien, c'était une ignorance imprudente. Mais j'espère qu'il n'y aura pas de prochaine fois.\nSinon, je pourrais verser des larmes de tristesse.\""
  },
  Event_47879_Name = {
    Text = ":\"Rêve Lucide\""
  },
  Event_47880_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47880_Desc = {
    Text = "Vous l'avez avalé d'un coup.\nGulp, gulp... Des bulles ont éclaté dans votre cerveau et votre gorge.\nComme de petits feux d'artifice crépitants.\n\"Je vous loue, brave humain. Vous aurez l'occasion de toucher à l'infini.\nEt je vais en être témoin.\""
  },
  Event_47880_Name = {
    Text = ":\"Rêve Lucide\""
  },
  Event_47881_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47881_Desc = {
    Text = "Elle ouvre les yeux et dit :\n« Oui, tout cela est faux.\nIl faut pleurer, il faut se révolter. »\nDans l'obscurité, des murmures se font entendre, lui renvoyant des échos bienveillants"
  },
  Event_47881_Name = {
    Text = "\"Connaissance de soi\""
  },
  Event_47900_ChoiceDesc1 = {
    Text = "[Voit le serpent] Obtient une relique en or +[(RelicConfig.Arg1)]"
  },
  Event_47900_ChoiceDesc2 = {
    Text = "[Te voir] Obtenir une création de culpabilité[(RelicConfig.Arg1)]"
  },
  Event_47900_Desc = {
    Text = "Claquement. \nUn léger claquement de doigts l'a ramenée à la réalité. \nLe Docteur, à un moment, avait rapproché son visage, ses yeux jaune-cobalt brillant d'excitation. \n\"Dites-moi, que venez-vous de voir ?\""
  },
  Event_47900_Name = {
    Text = "Serpent hypnotiseur"
  },
  Event_47901_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47901_Desc = {
    Text = "Elle ouvre les yeux. \n Dans la lumière floue, elle semble voir un grand serpent blanc tranquille enroulé dans l'obscurité, se déplaçant lentement. \n Oh, et ses yeux — \n ils sont d'un or pur, sans aucune impureté. \n Ni tristesse ni joie, sans aucun jugement, \n suffisamment pour réveiller le dormeur de son cauchemar estival."
  },
  Event_47901_Name = {
    Text = "Serpent hypnotiseur"
  },
  Event_47909_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47909_Desc = {
    Text = "Elle ouvrit discrètement un œil.\nCe qu'elle vit était une lumière blanche floue, se déplaçant lentement dans l'obscurité.\nUn éclat doré traversa la lumière, comme pour la prévenir de son infraction.\nElle n'osa pas regarder davantage"
  },
  Event_47909_Name = {
    Text = "Serpent hypnotiseur"
  },
  Event_47910_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47910_Desc = {
    Text = "Elle suivait les instructions du docteur, n'ayant jamais ouvert les yeux.\nUne brise glaciale parcourait l'air autour d'elle, s'attardant longtemps sur son visage.\nLe temps passa, et tout reprit son cours normal.\nComme si rien ne s'était passé"
  },
  Event_47910_Name = {
    Text = "Serpent hypnotiseur"
  },
  Event_47911_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47911_Desc = {
    Text = "\n\"J'ai vu... un serpent très beau.\"\nLe docteur marqua une pause un instant, stylo à la main.\n\"Quel type de serpent ?\"\n\"C'est très beau ! Il est complètement blanc avec des motifs dorés...\"\nLe docteur n'a rien dit de plus, le plus léger sourire se dessinant aux coins de ses lèvres.\n\"Merci.\""
  },
  Event_47911_Name = {
    Text = "Serpent hypnotiseur"
  },
  Event_47912_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47912_Desc = {
    Text = "Elle fixe droit dans les yeux cobalt-jaune du docteur. \n\"Je vois que tu te es transformé en serpent.\"\n\"Oh. Comment peux-tu être si sûr que c'est moi ?\"\nParce que c'est mystérieux, calme, et complexe. \nEt... \nCela semble fatigué, comme s'il venait de se réveiller d'un millénaire d'hibernation."
  },
  Event_47912_Name = {
    Text = "Serpent hypnotiseur"
  },
  Event_47992_ChoiceDesc1 = {
    Text = "[Connect] Restore Arg2 Vie."
  },
  Event_47992_ChoiceDesc2 = {
    Text = "[Meditate] Choisir de Réveiller 1 Réveilleur."
  },
  Event_47992_ChoiceDesc3 = {
    Text = "[Expel] Éliminez jusqu'à 3 cartes de symptômes, et gagnez des sigils noirs Arg2."
  },
  Event_47992_Desc = {
    Text = "Tu explores dans la brume, soudain, l'insigne sur ta poitrine émet une faible lueur argentée. Qui t'appelle de l'autre côté de la communication ?"
  },
  Event_47992_Name = {
    Text = "Point de contact"
  },
  Event_47992_Tips3 = {
    Text = "Aucune carte de symptôme"
  },
  Event_47993_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47993_ChoiceDesc2 = {
    Text = "[Partir] Obtenez au hasard 1 carte de commandement pour recevoir une oraison :[(EnchantConfig.Arg1)] et copiez 1 version originale de cette carte"
  },
  Event_47993_Desc = {
    Text = "Vous acceptez l'appel de l'école, la voix familière vous apaise. Vous reprenez courage et continuez"
  },
  Event_47993_Name = {
    Text = "Point de contact"
  },
  Event_48225_ChoiceDesc1 = {Text = "[Leave]"},
  Event_48225_Desc = {
    Text = "Le chaton lèche joyeusement le dos de ta main.\n\"Merci, ne sois pas triste pour moi.\nIci, les personnalités meurent et renaissent constamment,\nJe reviendrai sûrement !\nMiaou, miaou miaou !\""
  },
  Event_48225_Name = {
    Text = "Dernières volontés"
  },
  Event_48226_ChoiceDesc1 = {Text = "[Leave]"},
  Event_48226_Desc = {
    Text = "Le chaton pense que tu n'as pas compris, alors il frotte ta main pour te plaire.\n\"Si tu acceptes, je te donnerai mes friandises secrètes.\nElles sont bien gardées au quartier Cambrai @2...\""
  },
  Event_48226_Name = {
    Text = "Dernières volontés"
  },
  Event_48227_ChoiceDesc1 = {Text = "[Leave]"},
  Event_48227_Desc = {
    Text = "Vous vous êtes sincèrement excusé auprès de George.\n\"Hmph, au moins vous connaissez un peu de bonnes manières.\nGeorge envisagera de réduire la puissance de la malédiction de 10%,\njusqu'à 15%—c'est la limite de George.\""
  },
  Event_48227_Name = {
    Text = "Le fantôme de Georges"
  },
  Event_48228_ChoiceDesc1 = {
    Text = "[Accepter] Obtenez la Reliquaire en Or \"(RelicConfig.Arg1)\", infectez \"(Skill.Arg2)\""
  },
  Event_48228_ChoiceDesc2 = {
    Text = "[Refuser ça] Obtenez une relique en or en choisissant parmi 3, contagion[(Skill.Arg1)]"
  },
  Event_48228_ChoiceDesc3 = {
    Text = "[garder le silence] obtenez une relique d'argent [(RelicConfig.Arg1)]"
  },
  Event_48228_Desc = {
    Text = "« Chat 24 » a subi de graves blessures, il lutte pour te dire : \n « Snif, je n'ai plus beaucoup de temps à vivre, miaou. \n J'ai un ami, c'est un merlu argenté, miaou. \n Si un jour tu le rencontres, dis-lui que je suis parti loin, miaou. \n Je vais être parti très longtemps, miaou. \n Je lui ramènerai plein de frites sans poisson pané, miaou. \n Tu dois absolument lui dire ! »"
  },
  Event_48228_Name = {
    Text = "Dernières volontés"
  },
  Event_48229_ChoiceDesc1 = {Text = "[Leave]"},
  Event_48229_Desc = {
    Text = "Le chaton est un peu déçu.\nMais il a toujours été un chaton obéissant, ne forçant jamais personne.\nFinalement, il ferme les yeux avec regret"
  },
  Event_48229_Name = {
    Text = "Dernières volontés"
  },
  Event_48230_ChoiceDesc1 = {
    Text = "[S'excuser à Lui] Obtenez une Relique d'Argent \"(RelicConfig.Arg1)\", infecté par \"(Skill.Arg2)\""
  },
  Event_48230_ChoiceDesc2 = {
    Text = "[Taunt It] Gagnez la relique en argent \"(RelicConfig.Arg1)\", infligez \"(Skill.Arg2)\""
  },
  Event_48230_ChoiceDesc3 = {
    Text = "[Disregard It] Gagnez 25 Sigils Noirs"
  },
  Event_48230_Desc = {
    Text = "Un fantôme, le fantôme de George, flotte au-dessus de vous.\n\"George est mort sans dignité.\nMais peu importe. George se souviendra toujours de cette humiliation.\nGardien, tu es dans de beaux draps, heh heh heh...\""
  },
  Event_48230_Name = {
    Text = "Le fantôme de Georges"
  },
  Event_48231_ChoiceDesc1 = {Text = "[Leave]"},
  Event_48231_Desc = {
    Text = "\"Hehe, comment oses-tu te moquer de George.\nNe t'inquiète pas, que tu sois en train de manger, de dormir ou de chanter...\nGeorge flottera toujours autour de toi, te rappelant et te tourmentant.\nPour que tu te souviennes à jamais de tes péchés.\nTu ne attraperas jamais un fantôme, la la la~\""
  },
  Event_48231_Name = {
    Text = "Le fantôme de Georges"
  },
  Event_48232_ChoiceDesc1 = {Text = "[Leave]"},
  Event_48232_Desc = {
    Text = "Tu avances à grands pas, laissant derrière toi la malédiction de Georges. \n Derrière toi, un sanglot se fait entendre, Georges se met à pleurer. \n « Bouhou... Moi, si adorable, réduit à ça par ton derrière— \n C'est dégoûtant ! Dégoûtant ! \n Georges préfère mourir sous le fouet de Pandia ! »"
  },
  Event_48232_Name = {
    Text = "Le fantôme de Georges"
  },
  Event_49055_ChoiceDesc1 = {
    Text = "[Call Awakener] Déduire 100 Aliemus de tous les Réveilleurs et retirer 1 Carte de Symptôme."
  },
  Event_49055_ChoiceDesc2 = {
    Text = "[Lutte acharnée] Récupérez Arg1 points de vie, infectez 2 cartes [(Skill.Arg2)]"
  },
  Event_49055_ChoiceDesc3 = {
    Text = "[Insérer la Clé d'Argent] Dégagez toutes les Clés"
  },
  Event_49055_Desc = {
    Text = "La marre de sang indistincte apparaît au moment où vous la touchez.  \nLe sang rouge-noir tend des bras innombrables, s'agrippant à votre cheville et tirant vers le haut, cherchant à vous traîner dans un abysse imprévisible"
  },
  Event_49055_Name = {
    Text = "Bassin de souillure"
  },
  Event_49097_ChoiceDesc1 = {
    Text = "[Move Forward]"
  },
  Event_49097_Desc = {
    Text = "Votre abdomen se tord, mais après quelques secondes, il retrouve miraculeusement son calme. Vous entendez un autre battement de cœur à l'intérieur de vous"
  },
  Event_49097_Name = {
    Text = "Mère nourricière"
  },
  Event_49098_ChoiceDesc1 = {
    Text = "[Boire d'un trait] Choisissez [ExDesc3] [ExDesc4] Carte(s) d'instruction pour leur conférer l'Oraison : [(EnchantConfig.Arg1)] [ExDesc1] [ExDesc2]"
  },
  Event_49098_Desc = {
    Text = "De vieux pots en terre regardent vers toi à travers les fissures des murs bas. \n La source d'eau est la ressource la plus précieuse dans le désert, l'alcool est le catalyseur de la folie et du monde hallucinant. \n Dans cette terre stérile, il est difficile pour une personne encore rationnelle de refuser son invitation."
  },
  Event_49098_Name = {
    Text = "Mère nourricière"
  },
  Event_49312_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49312_Desc = {
    Text = "La clé en argent brille, les bras semblent stupéfaits par une forme de pouvoir, s'enfonçant dans l'eau de la piscine, puis disparaissant"
  },
  Event_49312_Name = {
    Text = "Bassin de souillure"
  },
  Event_49313_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49313_Desc = {
    Text = "Tu luttes désespérément, mais tu t'enfonces de plus en plus, des murmures maudits résonnent dans ta tête.\nQuand tu reprends tes esprits, les tentacules sanglants se retirent, satisfaits. Tu te sens étrangement bien, mais tu as l'impression d'avoir perdu quelque chose"
  },
  Event_49313_Name = {
    Text = "Bassin de souillure"
  },
  Event_49314_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49314_Desc = {
    Text = "Le réveilleur a immédiatement tiré sur ton bras, te sortant de la piscine de sang, tout en déchirant ton bras connecté. La boue trouble éclabousse, des créatures indiscernables se tordent dans l'eau, comme si elles désiraient et dévoraient quelque chose"
  },
  Event_49314_Name = {
    Text = "Bassin de souillure"
  },
  Event_49867_ChoiceDesc1 = {
    Text = "Réveil aléatoire +50 folie"
  },
  Event_49867_Name = {
    Text = "Événement"
  },
  Event_49907_ChoiceDesc1 = {
    Text = "[Inquiring True or False]"
  },
  Event_49907_ChoiceDesc2 = {
    Text = "[Request a Pat]"
  },
  Event_49907_Desc = {
    Text = "\"Pourquoi regardes-tu toujours mes cornes avec curiosité ? Des questions ?\"\nThais se penche soudain près de ton épaule, les perles couleur miel effleurant doucement ta joue."
  },
  Event_49907_Name = {
    Text = "L'homme au cornet"
  },
  Event_49908_ChoiceDesc1 = {
    Text = "[Regardez en haut]"
  },
  Event_49908_ChoiceDesc2 = {
    Text = "[Approach Thais]"
  },
  Event_49908_Desc = {
    Text = "La poussière se disperse dans les ruines, et par une fenêtre brisée, Thais apparaît soudainement. Elle s'appuie nonchalamment sur le rebord poussiéreux, pointant mystérieusement vers la poutre au-dessus."
  },
  Event_49908_Name = {
    Text = "Personne furtive"
  },
  Event_49909_ChoiceDesc1 = {
    Text = "[Partir] Choisissez 1 carte de commandement parmi 3 pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_49909_Desc = {
    Text = "Tu relèves la tête, les tuyaux de cuivre rouillés rayonnent comme une immense toile d'araignée au-dessus de ta tête. Une ombre passe, est-ce un chat sauvage à la recherche de nourriture ou un monstre caché dans l'ombre ?\nEn te retournant, Thais a déjà disparu"
  },
  Event_49909_Name = {
    Text = "Personne furtive"
  },
  Event_49910_ChoiceDesc1 = {
    Text = "[Stare at Her]"
  },
  Event_49910_ChoiceDesc2 = {Text = "[Call Her]"},
  Event_49910_Desc = {
    Text = "Vous revoyez cette « fantôme ».  \nCette fois, vous connaissez déjà son nom.  \nThais est là, sous l'arbre-mère éloigné, priant sincèrement.  \nSa silhouette est évanescente, semblant fusionner avec le spectre de l'arbre-mère"
  },
  Event_49910_Name = {
    Text = "Faiseur de vœux"
  },
  Event_49911_ChoiceDesc1 = {
    Text = "[Partir] Choisissez 1 carte de commandement parmi 3 pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_49911_Desc = {
    Text = "Tu regardes au loin la silhouette de Thaisis, son contour se dresse comme une montagne sacrée et majestueuse dans cette tempête apocalyptique, son autorité intacte malgré la fureur des sables.\nElle marche lentement mais sûrement, sa posture noble et inviolable, te captivant"
  },
  Event_49911_Name = {Text = "L'immortel"},
  Event_49912_ChoiceDesc1 = {
    Text = "[Leave] Choisir de copier une Carte Commande"
  },
  Event_49912_Desc = {
    Text = "\n\"Qu'est-ce que tu devines ?\" \nElle chuchote \"chut,\" s'approchant davantage. Tu sens le bout de sa corne frôler ta joue, laissant une sensation fraîche et picotante..."
  },
  Event_49912_Name = {
    Text = "L'homme au cornet"
  },
  Event_49913_ChoiceDesc1 = {
    Text = "[Partir] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_49913_Desc = {
    Text = "« Si tu veux toucher, dis-le franchement, est-ce que je vais te refuser ? »\nElle rit doucement en tirant ta main, la texture chaude et glissante de ses doigts te donnant presque envie de t'y enfoncer…"
  },
  Event_49913_Name = {
    Text = "L'homme au cornet"
  },
  Event_49914_ChoiceDesc1 = {
    Text = "[Partir] Choisir de réveiller un Réveillé, réduire le coût de sa carte de réveil de 1, infecter[(Skill.Arg1)]"
  },
  Event_49914_Desc = {
    Text = "Vous vous êtes agenouillé avec les autres.\n\"Je le savais, je le savais ! La Reine, Sa Majesté, nous a toujours protégés !\"\nLe son des pleurs joyeux et des longs cris se mêlait au vent hurlant, résonnant et vibrant à travers votre crâne.\nVaguement, une pensée cruciale a traversé votre esprit, mais vous ne pouviez pas l'attraper."
  },
  Event_49914_Name = {Text = "L'immortel"},
  Event_49915_ChoiceDesc1 = {
    Text = "[Partir] Obtient 3 choix 1 relique d'argent, infection[(Skill.Arg1)]"
  },
  Event_49915_Desc = {
    Text = "Vous lui avez fait signe.\n\"Que fais-tu ?\" Ramona vous a regardé avec confusion.\n\"Par là...\" \nAvant que vous ayez pu finir votre phrase, la femme au loin avait déjà disparu.\nSerait-ce une illusion ?"
  },
  Event_49915_Name = {
    Text = "Personne arrosant l'eau"
  },
  Event_49916_ChoiceDesc1 = {
    Text = "[Respond to Her]"
  },
  Event_49916_ChoiceDesc2 = {Text = "[Hésiter]"},
  Event_49916_Desc = {
    Text = "De loin, une femme est en train de puiser de l'eau au bord de la rivière.\nSemblant sentir ton regard, elle se retourne et te fait signe.\nTu remarques que sa manière de se retourner est quelque peu étrange"
  },
  Event_49916_Name = {
    Text = "Personne arrosant l'eau"
  },
  Event_49917_ChoiceDesc1 = {
    Text = "[Partir] Choisissez 1 carte de commandement parmi 3 pour obtenir une oraison[(EnchantConfig.Arg1)]"
  },
  Event_49917_Desc = {
    Text = ": Pendant que tu hésitais, la femme a sauté dans l'oasis et a disparu. \nTu n'en croyais pas tes yeux... Elle semblait avoir des sabots de chèvre ?"
  },
  Event_49917_Name = {
    Text = "Personne arrosant l'eau"
  },
  Event_49918_ChoiceDesc1 = {
    Text = "[Partir] Choisissez 1 carte de commandement parmi 3 pour obtenir une oraison[(EnchantConfig.Arg1)]"
  },
  Event_49918_Desc = {
    Text = "« Ô Mère Arbre, veuillez entendre la prière de @1. Je me baignerai dans votre lait et renaîtrai, devenant votre agent, marchant pour vous dans les sables, permettant à vos racines d'atteindre chaque recoin de Remouahe... »\n\nLes prières innocentes alternées résonnent dans tout l'espace."
  },
  Event_49918_Name = {
    Text = "Faiseur de vœux"
  },
  Event_49919_ChoiceDesc1 = {
    Text = "[Leave] Réveillez un Réveil aléatoire"
  },
  Event_49919_Desc = {
    Text = "Le regard ambigu et inexplicable de Thais attire votre attention, une sorte de force trompeuse vous fait perdre vos moyens, comme si vous étiez attiré, vous ne pouvez vous empêcher de vous approcher d'elle. \n « En fait, les choses invisibles existent toujours. » \n Elle murmure doucement à votre oreille, vous semblez comprendre, mais c'est comme si un voile blanc vous enveloppait, rendant tout flou. \n Est-ce une sorte de prédiction ? Dans un moment d'égarement, Thais a déjà disparu."
  },
  Event_49919_Name = {
    Text = "Personne furtive"
  },
  Event_49920_ChoiceDesc1 = {Text = "[Regarde]"},
  Event_49920_ChoiceDesc2 = {Text = "[Kneel]"},
  Event_49920_Desc = {
    Text = "Les sabots noirs du mouton foulent la terre venteuse. \nThais chantait des prières inconnues, de nombreux aram se mirent à genoux dans la direction d'où elle arrivait"
  },
  Event_49920_Name = {Text = "L'immortel"},
  Event_49921_ChoiceDesc1 = {
    Text = "[Partir] Obtient 3 choix 1 relique en or, infection[(Skill.Arg1)]"
  },
  Event_49921_Desc = {
    Text = "L'arbre gigantesque étend des milliers de branches robustes, comme des membres enchevêtrés, enserrant fermement les poignets et les chevilles de Thais, ignorant ses luttes et ses résistances, l'absorbant brutalement dans le ventre gonflé du tronc de l'arbre...\n\nBien qu'elle ne soit qu'une ombre lointaine, sa souffrance parvient toujours à toucher votre cœur à travers les ondulations de l'eau."
  },
  Event_49921_Name = {
    Text = "Faiseur de vœux"
  },
  Event_49922_ChoiceDesc1 = {
    Text = "[Partir] Obtenir une création[(RelicConfig.Arg1)]"
  },
  Event_49922_Desc = {
    Text = "Les membres flasques se laissent entraîner par la sève de l'arbre le long du tronc, elle lutte de toutes ses forces, mais son corps se comporte comme un ver titubant et distordu, désobéissant à ses ordres. \n « Les os se sont complètement dissous, » les coins des yeux et des sourcils de Thais sont teintés de tristesse, « elle fait déjà partie de l'arbre. » \n « Nous avons besoin d'une force de renversement... une force qui transcende le temps. »"
  },
  Event_49922_Name = {
    Text = "Personne corrompue"
  },
  Event_49923_ChoiceDesc1 = {
    Text = "[Partir] Choisissez 1 carte de commandement parmi 3 pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_49923_Desc = {
    Text = "« Et puis, cet « Œil sans pupille inversé », pour une raison inconnue, a une forte capacité d'appel venant du fond du cœur... »\n« Oh, parles-tu de moi ? »\n« Médiéite fait l'éloge de ta capacité à raconter des histoires. »\n\nCette nuit-là, près du feu de camp, elle t'avait déjà servi un verre de vin."
  },
  Event_49923_Name = {
    Text = "Personne corrompue"
  },
  Event_49924_ChoiceDesc1 = {
    Text = "[Cut the Knurl]"
  },
  Event_49924_ChoiceDesc2 = {Text = "[Memory]"},
  Event_49924_Desc = {
    Text = "Une tumeur d'arbre. \n Elle bat d'une manière maléfique et enflée, une face tordue et douloureuse transparaissant à travers sa peau translucide et sanguine, comme si elle allait éclore à tout moment. \n « Médinette. » Thais affiche une expression de tristesse et appelle doucement le nom de ce visage."
  },
  Event_49924_Name = {
    Text = "Personne corrompue"
  },
  Event_49939_ChoiceDesc1 = {
    Text = "[Trust Ryker] Tous les Réveilleurs récupèrent Arg1 Aliemus"
  },
  Event_49939_ChoiceDesc2 = {
    Text = "[Worry About Ryker] Réveillez 2 Réveilleurs choisis"
  },
  Event_49939_Desc = {
    Text = "\"Fais confiance à ma chance.\""
  },
  Event_49939_Name = {
    Text = "Détective chanceux"
  },
  Event_49940_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49940_Desc = {
    Text = "Ryker ne sait faire que trois choses : espionner, écouter et jeter les dés. \nEn d'autres termes, il n'excelle pas dans le combat. \nVos inquiétudes intérieures grandissent sans contrôle, plongeant dans la folie"
  },
  Event_49940_Name = {
    Text = "Détective chanceux"
  },
  Event_49941_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49941_Desc = {
    Text = "La foi est magique, il surmontera tous les obstacles"
  },
  Event_49941_Name = {
    Text = "Détective chanceux"
  },
  Event_49943_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49943_Desc = {
    Text = "Tu te sens gêné, mais tu regardes Ramona, encore malade, avec espoir.\n\"Je vais le faire.\"\nRougissante, elle sort un flacon neuf de sa valise infinie et capture l'araignée avec dextérité"
  },
  Event_49943_Name = {
    Text = "Araignée venimeuse"
  },
  Event_49944_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49944_Desc = {
    Text = "Ryker agite la pointe de son doigt vers la grande araignée levant ses pattes. \nCes espèces aux motifs éclatants sont souvent venimeuses, vous vous apprêtez à le prévenir, mais l'araignée, autrefois hostile, grimpe agilement sur son doigt et s'enroule. \nPeu importe, chacun a son destin"
  },
  Event_49944_Name = {
    Text = "Araignée venimeuse"
  },
  Event_49945_ChoiceDesc1 = {
    Text = "[Regardez Ramona] Obtenez 1 parmi 3 Oraisons"
  },
  Event_49945_ChoiceDesc2 = {
    Text = "[Look at Ryker] Choisissez 1 des 3 cartes de commandement pour gagner une oraison : \"(EnchantConfig.Arg1)\", et infectez \"(Skill.Arg2)\""
  },
  Event_49945_Desc = {
    Text = "Les yeux composés te fixent intensément. \n Le maître des yeux composés recule d'un pas, menaçant avec ses griffes. \n À en juger par ses pattes levées et ses deux paires de membres qui soutiennent son corps, c'est en effet une créature arachnide rare. \n Avant de partir, Czort t'avait averti : « Mission supplémentaire, veuillez prélever des échantillons des espèces locales et les conserver à la station d'exploration locale. » \n Tu secoues le flacon de collecte dans ton sac à dos, celui-ci étant déjà infesté après plusieurs semaines de marche."
  },
  Event_49945_Name = {
    Text = "Araignée venimeuse"
  },
  Event_49946_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49946_Desc = {
    Text = "\"La cupidité qui ignore le bon moment est une maladie.\""
  },
  Event_49946_Name = {
    Text = "Ta réponse"
  },
  Event_49947_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49947_Desc = {
    Text = "\"Réciter le texte ne vous attirera aucune affection, enfant.\""
  },
  Event_49947_Name = {
    Text = "Ta réponse"
  },
  Event_49948_ChoiceDesc1 = {
    Text = "[Golden Key] Obtenir la Relique d'Or \"(RelicConfig.Arg1)\", infecter \"(Skill.Arg2)\""
  },
  Event_49948_ChoiceDesc2 = {
    Text = "[Clé en fer] obtenir 1 relique en or parmi 3, infecter[(Skill.Arg1)]"
  },
  Event_49948_ChoiceDesc3 = {
    Text = "[Clé en argent] obtenir une relique d'argent[(RelicConfig.Arg1)]"
  },
  Event_49948_Desc = {
    Text = "À midi, la vapeur de la rivière sacrée se condense en deux phantômes vides.\n La voix floue des phantômes te demande : Est-ce ta clé dorée, clé argentée, ou clé en fer que tu as perdue ?"
  },
  Event_49948_Name = {
    Text = "Ta réponse"
  },
  Event_49949_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49949_Desc = {
    Text = "\"L'honnêteté conduit souvent à des résultats plus sûrs, mais en même temps, tu pourrais rater quelque chose.\""
  },
  Event_49949_Name = {
    Text = "Ta réponse"
  },
  Event_50013_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50013_Desc = {
    Text = "Tu scrutes attentivement, mais le visage de cette personne se déforme avec les ondulations de l'eau, flou et indistinct. \n\n Plus tu te concentres, plus ta respiration devient lente, ton cerveau est envahi par une sensation de désorientation due à un manque d'oxygène, jusqu'à ce que tu entendes la voix de Ramona qui t'appelle, te tirant péniblement vers la réalité. \n Le soleil brûlant se reflète sur la surface de l'eau, d'une intensité éblouissante, mais sous la surface, il semble y avoir quelque chose qui brille."
  },
  Event_50013_Name = {
    Text = "Phantom de la mort"
  },
  Event_50014_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50014_Desc = {
    Text = "Le fantasme se dissipe au toucher, ta main est vide, seule une douleur aiguë jaillit soudainement à la tempe. \nLe soleil reflété sur l'eau est exceptionnellement éblouissant, mais sous la surface de l'eau, quelque chose brille"
  },
  Event_50014_Name = {
    Text = "Phantom de la mort"
  },
  Event_50015_ChoiceDesc1 = {
    Text = "[Strive to Recognize] Obtenez une Relique Argent \"(RelicConfig.Arg1)\" et devenez infecté par \"(Skill.Arg2)\""
  },
  Event_50015_ChoiceDesc2 = {
    Text = "[Reach Out and Touch] Gagnez la relique argent \"(RelicConfig.Arg1)\", et contractez \"(Skill.Arg2)\"."
  },
  Event_50015_ChoiceDesc3 = {
    Text = "[Rub Eyes] Gagnez 25 Sigils Noirs"
  },
  Event_50015_Desc = {
    Text = "Nubia te pousse, une jambe s'enfonce dans le fleuve sacré.\nTu te stabilises tant bien que mal, mais dans les ondulations de l'eau, tu vois un reflet inattendu.\nUn jeune homme en uniforme de Missaga, grand et élancé, son corps affaissé dans le courant du fleuve sacré"
  },
  Event_50015_Name = {
    Text = "Phantom de la mort"
  },
  Event_50016_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50016_Desc = {
    Text = "La panique ronge ton esprit, la douleur trouble ta conscience, tu tires désespérément, mais les lianes se resserrent de plus en plus, une substance visqueuse au parfum étrange s'infiltre dans tes narines, chaque respiration est chargée d'un désespoir visqueux. \nRamona plante son épée, Nubie s'enfuit en laissant une jambe derrière elle, tu arraches le dernier tentacule collé à ton visage, et il est couvert d'une couche de chair floue."
  },
  Event_50016_Name = {
    Text = "Face à soi"
  },
  Event_50017_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50017_Desc = {
    Text = "La lumière argentée transperce le corps de Nubie, la sensation de chair éclatée se transmet à tes doigts et à ton poignet par la clé d'argent.\nLes membres tordus de Nubie se lèvent vers le ciel, poussant un cri terrifiant et plaintif, se transformant en un liquide épais et indéfinissable."
  },
  Event_50017_Name = {
    Text = "Face à soi"
  },
  Event_50018_ChoiceDesc1 = {
    Text = "[Tear] Obtenez une relique maudite \"(RelicConfig.Arg1)\", infectez \"(Skill.Arg2)\""
  },
  Event_50018_ChoiceDesc2 = {
    Text = "[Percer] 1 Carte d'instruction aléatoire obtient l'Oraison : [(EnchantConfig.Arg1)]"
  },
  Event_50018_Desc = {
    Text = "Les tentacules enroulés de Nubia se tordent et se jettent sur ton visage, envahissant violemment ta bouche et ton nez"
  },
  Event_50018_Name = {
    Text = "Face à soi"
  },
  Event_50019_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50019_Desc = {
    Text = "Il n'y a que des reflets scintillants à la surface de l'eau.\nVous retirez vos jambes mouillées, vidant le sable humide de vos chaussures.\nL'image précédente reste dans votre esprit, impossible à chasser"
  },
  Event_50019_Name = {
    Text = "Phantom de la mort"
  },
  Event_50029_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50029_Desc = {
    Text = "\"Va-t-il revenir ? Ou te abandonnera-t-il pour toujours dans ce désert sans limites ?\"\n\"Peut-il te trouver ? Ou les vents et les dunes changeants l'amèneront-ils à perdre tes coordonnées ?\"\n\"Est-ce que l'espoir que tu places en les autres est vraiment fiable ?\""
  },
  Event_50029_Name = {
    Text = "Désert perdu"
  },
  Event_50030_ChoiceDesc1 = {
    Text = "[Demander du secours] Réveillez aléatoirement un éveillé, infectez [(Skill.Arg1)]"
  },
  Event_50030_ChoiceDesc2 = {
    Text = "[avancer ensemble] choisissez une carte parmi 3 cartes de commandement et obtenez l'oraison : [(EnchantConfig.Arg1)]"
  },
  Event_50030_Desc = {
    Text = "Une voix ancienne et lointaine se mêle au murmure de l'eau pour te poser une question. \n « Tu es perdu dans l'immensité du désert. » \n « Deux choix s'offrent à toi. Ton compagnon marche plus vite, laisse-le emporter la nourriture et l'eau pour chercher de l'aide, vous resterez sur place avec un minimum de consommation. » \n « Ou bien vous partagez tout et continuez d'avancer. »"
  },
  Event_50030_Name = {
    Text = "Désert perdu"
  },
  Event_50031_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50031_Desc = {
    Text = "\"Vous ne pourrez peut-être pas aller plus loin, mais votre esprit et votre chair sont étroitement liés, tirant de la force les uns des autres.\"\n\"C'est votre choix.\"\nAlors qu'il disait cela, le soleil ardent dans le ciel élevé ferma les yeux."
  },
  Event_50031_Name = {
    Text = "Désert perdu"
  },
  Event_50064_ChoiceDesc1 = {
    Text = "[Cut the Red Ribbon] Retirez 1 carte de commandement, gagnez Arg1 Le Sigil Noir"
  },
  Event_50064_ChoiceDesc2 = {
    Text = "[Combattre] Copiez 1 carte de commandement, infection[(Skill.Arg1)]"
  },
  Event_50064_ChoiceDesc3 = {
    Text = "[appelle ramona] choisit 1 carte de commande parmi 3 et obtient l'oraison :[(EnchantConfig.Arg1)]"
  },
  Event_50064_Desc = {
    Text = "Kasiah lança le chiffon rouge, s'enroulant instantanément autour de votre valise"
  },
  Event_50064_Name = {
    Text = "Étoffe enchevêtreuse"
  },
  Event_50065_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50065_Desc = {
    Text = "Le son clair et intermittent des coups résonne entre les tuyaux entrecroisés au-dessus de vous, comme un fantôme dansant seul, agitant ses bras faibles dans cet espace mort.\nCette imagination évoque en vous une ancienne peur glaciale"
  },
  Event_50065_Name = {
    Text = "Échelle sinistre"
  },
  Event_50066_ChoiceDesc1 = {
    Text = "[explore l'entrée] obtient une relique d'argent[(RelicConfig.Arg1)]"
  },
  Event_50066_ChoiceDesc2 = {
    Text = "[Deep into the Cave] Obtenir la Relique d'Or \"(RelicConfig.Arg1)\", infecter \"(Skill.Arg2)\""
  },
  Event_50066_Desc = {
    Text = "«Il y a une grotte ici.»\nThais te fait une invitation en se tournant vers toi.\n«Veux-tu y entrer pour voir ?»\nLa grotte étroite est sombre et profonde, semblable à la grande bouche d'un démon, s'étendant vers l'obscurité infinie. Quiconque met les pieds dans ce lieu désolé ne peut échapper à la sinistre prémonition qui monte du fond de sa moelle épinière. Il semble que dans chaque recoin de cette grotte, se cachent d'anciens êtres qui n'osent regarder la lumière du soleil, attendant silencieusement l'arrivée des intrus."
  },
  Event_50066_Name = {
    Text = "Grotte sombre"
  },
  Event_50067_ChoiceDesc1 = {
    Text = "[Les détruire un par un] améliorer aléatoirement 1 relique d'argent en une relique en or[(RelicConfig.Arg1)]"
  },
  Event_50067_ChoiceDesc2 = {
    Text = "[Surrounding Two] Gagnez une relique en argent \"(RelicConfig.Arg1)\" et infligez \"(Skill.Arg2)\"."
  },
  Event_50067_ChoiceDesc3 = {
    Text = "[Eavesdrop] Gagnez 25 Sigils Noirs"
  },
  Event_50067_Desc = {
    Text = "Deux gardes Aram surveillent la porte de l'usine.\nL'un d'eux se promène distraitement, engageant une conversation avec l'autre.\n\"Certains disent que Lady Juliette compte à nouveau les équipes essayant de percer le Mur de Tempête.\"\n\"J'espère vraiment ne pas être sélectionné.\""
  },
  Event_50067_Name = {
    Text = "Concierge oisif"
  },
  Event_50067_Tips1 = {
    Text = "Pas encore de relique d'argent"
  },
  Event_50068_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50068_Desc = {
    Text = "Ne regarde pas, n'écoute pas, ne pense pas. \nN'imagine pas d'où vient cette tonalité inappropriée, tu te dirige directement vers les restes de l'arbre-mère"
  },
  Event_50068_Name = {
    Text = "Échelle sinistre"
  },
  Event_50069_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50069_Desc = {
    Text = "Ramona a poignardé d'un coup d'épée la Kasiah vêtue de soie rouge, qui s'est précipitée pour éviter le coup, et le foulard rouge tordu autour de toi s'est aussi libéré en un instant"
  },
  Event_50069_Name = {
    Text = "Étoffe enchevêtreuse"
  },
  Event_50070_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50070_Desc = {
    Text = "Vous vous divisez en deux groupes, vous et Ramona à gauche, Ryker à droite, pour attaquer des deux côtés.\nVous levez la main pour signaler, Ramona et Ryker passent à l'action, et les deux gardes aram tombent silencieusement au sol"
  },
  Event_50070_Name = {
    Text = "Concierge oisif"
  },
  Event_50071_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50071_Desc = {
    Text = "Il n'est pas conseillé de s'enfoncer dans le piège maintenant. Vous pouvez presque sentir le mal battre dans les veines de la roche en restant à l'entrée"
  },
  Event_50071_Name = {
    Text = "Grotte sombre"
  },
  Event_50072_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50072_Desc = {
    Text = "Sous votre signe, Ryker assomme le garde aram silencieux d'un coup de dé, puis s'approche discrètement de l'autre gars qui continue à babiller. \n « Hé, mon pote, que ferais-tu si cette grande dame Juliette était une fraude ? » \n « Je ne sais pas non plus quoi faire. » \n Ryker sourit joyeusement, le garde tressaille, prêt à crier, mais Ryker lui couvre la bouche et le nez."
  },
  Event_50072_Name = {
    Text = "Concierge oisif"
  },
  Event_50073_ChoiceDesc1 = {
    Text = "[Écouter attentivement] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_50073_ChoiceDesc2 = {
    Text = "[Cover Ears] Pour chaque Réveilleur avec Aliemus de 50 ou plus, gagner 15 Sigils Noirs."
  },
  Event_50073_ChoiceDesc3 = {
    Text = "[Check] Get 3-choice Orison"
  },
  Event_50073_Desc = {
    Text = "Lorsque vous entrez dans l'étage des squelettes, un doux tintement résonne soudainement dans la vaste usine abandonnée, apportant une sensation de clarté de piano qui contraste avec les décombres d'acier rouillé"
  },
  Event_50073_Name = {
    Text = "Échelle sinistre"
  },
  Event_50074_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50074_Desc = {
    Text = "« Hé, frère, que ferais-tu si la grande dame Juliette était une menteuse ? »\n « Ne dis pas de bêtises, depuis l'arrivée de Juliette, tout est géré de manière impeccable. Si elle était une menteuse, pourquoi aiderait-elle autant les Araniens ? »\n Pendant qu'ils discutaient, Ryker avait silencieusement choisi sa position de guet, et deux dés volèrent pour frapper les deux hommes au sol."
  },
  Event_50074_Name = {
    Text = "Concierge oisif"
  },
  Event_50075_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50075_Desc = {
    Text = "Vous avez rassemblé votre courage et avez soutenu le regard.\nL'énorme œil du rideau se tord en un sourire sinistre, votre résistance acharnée vacille face à la défaite"
  },
  Event_50075_Name = {
    Text = "Œil magique"
  },
  Event_50076_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50076_Desc = {
    Text = "Tu déchires le rideau sans distraction.\nL'œil géant se transforme en un tissu plat et déchiré sous tes mains"
  },
  Event_50076_Name = {
    Text = "Œil magique"
  },
  Event_50077_ChoiceDesc1 = {
    Text = "[Stare Back] Obtenez une relique dorée \"(RelicConfig.Arg1)\", Infection \"(Skill.Arg2)\""
  },
  Event_50077_ChoiceDesc2 = {
    Text = "[Déchirer le Rideau] Choisir une carte de commandement parmi 3 pour obtenir une oraison : [(EnchantConfig.Arg1)]"
  },
  Event_50077_Desc = {
    Text = "Le rideau s'ouvre sur d'innombrables yeux tordus.\nUne masse géante cachée derrière les pupilles montre une faim insatiable, prête à bouger"
  },
  Event_50077_Name = {
    Text = "Œil magique"
  },
  Event_50078_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50078_Desc = {
    Text = "Ah, c'était une pièce longue et abandonnée qui a été secouée par votre mouvement, frappant le tuyau en fer"
  },
  Event_50078_Name = {
    Text = "Échelle sinistre"
  },
  Event_50079_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50079_Desc = {
    Text = "Thais entre calmement dans la grotte, et vous l'explorez en la suivant de près. \n « Fais attention ! » Vous êtes soudainement tiré en arrière, tombant dans une étreinte douce. Devant vous, une immense bête noire jaillit de la grotte avec une rapidité fulgurante. \n « Regarde ici, » alors que vous êtes encore sous le choc, Thais prend la parole, ses yeux scintillant d'une faible lueur dans l'obscurité, « c'est probablement son trésor. »"
  },
  Event_50079_Name = {
    Text = "Grotte sombre"
  },
  Event_50080_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50080_Desc = {
    Text = "Tu t'accroches désespérément à la poignée de ta valise, en lutte contre le satin rouge.\nMais ce satin est d'une force incroyable, ta valise échappe à tes mains, et les objets se répandent partout"
  },
  Event_50080_Name = {
    Text = "Étoffe enchevêtreuse"
  },
  Event_50081_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50081_Desc = {
    Text = "Tu détestes te sentir enchaîné.\nTu attrapes le ruban rouge et le déchires en deux.\nLa moitié restante serpente comme un serpent rouge"
  },
  Event_50081_Name = {
    Text = "Étoffe enchevêtreuse"
  },
  Event_50276_ChoiceDesc1 = {
    Text = "[Destroy Offering] Obtenir une relique maudite \"(RelicConfig.Arg1)\", infecter \"(Skill.Arg2)\""
  },
  Event_50276_ChoiceDesc2 = {
    Text = "[Défaire les liens] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : [(EnchantConfig.Arg1)]"
  },
  Event_50276_ChoiceDesc3 = {
    Text = "[Keep Going] Gagnez 50 Sigils Noirs"
  },
  Event_50276_Desc = {
    Text = "Trois lémuriens sont attachés sur une estrade.  \nDes motifs sombres en écorce, semblables à ceux que tu as vus sur des bébés, apparaissent sur leur corps, tandis qu'ils murmurent des mots"
  },
  Event_50276_Name = {
    Text = "Trois offrandes"
  },
  Event_50277_ChoiceDesc1 = {
    Text = "[Stare] Obtenez la Relique Argent \"(RelicConfig.Arg1)\" et devenez infecté par \"(Skill.Arg2)\"."
  },
  Event_50277_ChoiceDesc2 = {
    Text = "[Ignorez] Obtenez une Oraison à 3 choix"
  },
  Event_50277_Desc = {
    Text = "Les aram s’agenouillent dans la tempête de sable.  \nLe vent frappe leurs corps, les grains emportant leur cœur pieux.  \nAu sein du tourbillon de sable, il semble que d'innombrables yeux géants scrutent la terre déformée"
  },
  Event_50277_Name = {
    Text = "Géant de sable et de poussière"
  },
  Event_50278_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50278_Desc = {
    Text = "Les images que tu ne veux pas revoir réapparaissent.\nDes tentacules vacillants, des traces de sang coupées par des éclats de verre...\nTu te mets à vomir"
  },
  Event_50278_Name = {
    Text = "Voyage solitaire II"
  },
  Event_50279_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50279_Desc = {
    Text = "Elle n'est pas ici, elle n'est pas au cœur de la tempête la plus dangereuse.\nC'est suffisant pour te rassurer."
  },
  Event_50279_Name = {
    Text = "Voyage solitaire I"
  },
  Event_50280_ChoiceDesc1 = {
    Text = "[Attaque surprise] Choisissez 1 Carte d'instruction parmi 3 pour obtenir une Oraison : [(EnchantConfig.Arg1)]"
  },
  Event_50280_ChoiceDesc2 = {
    Text = "[Attack] 3 cartes de commandement aléatoires gagnent Oraison : \"(EnchantConfig.Arg1)\", et sont infectées avec \"(Skill.Arg2)\"."
  },
  Event_50280_Desc = {
    Text = "Un Nubien lutte dans une violente tempête de sable.\nSes sabots s'enfoncent profondément dans le sable, essayant d'éviter d'être aspiré dans le tourbillon"
  },
  Event_50280_Name = {
    Text = "Tempête de sable naturelle"
  },
  Event_50281_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50281_Desc = {
    Text = "Tu t'élances avec détermination, déchirant la corde sous les cris surpris des Arams.\nUn guerrier Aram s'approche avec prudence, tu lui prends la lance des mains et la pointes vers la foule obscure"
  },
  Event_50281_Name = {
    Text = "Trois offrandes"
  },
  Event_50282_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50282_Desc = {
    Text = "La raison te dit qu'il ne reviendra pas.\nOui, qui s'attendrait à ce qu'un joueur tienne sa promesse ?\nTu es seul. Tu n'as que la solitude"
  },
  Event_50282_Name = {
    Text = "Voyage solitaire III"
  },
  Event_50283_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50283_Desc = {
    Text = "Cette fièvre anormale va-t-elle s'aggraver avec la renaissance de l'arbre-mère ?\nRamona peut-elle prendre soin d'elle-même seule dehors du mur de tempête ?\nCe n'est pas le moment de se laisser distraire, mais tu ne peux t'empêcher de t'inquiéter pour ton partenaire"
  },
  Event_50283_Name = {
    Text = "Voyage solitaire I"
  },
  Event_50284_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50284_Desc = {
    Text = "Tu es déterminé à faire face, tandis que Nubie semble avoir trouvé un rare point d'appui, sautant pour s'accrocher à ta tête.\nTu es pris dans l'enchevêtrement de la tempête de sable et de Nubie.\n« La bravoure aveugle n'est pas la clé de la victoire, » les paroles glaciales de William résonnent dans tes oreilles bouchées comme un message divin, « apprends à saisir les opportunités. »"
  },
  Event_50284_Name = {
    Text = "Tempête de sable naturelle"
  },
  Event_50285_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50285_Desc = {
    Text = ": Ce n'est pas le moment de lire le journal"
  },
  Event_50285_Name = {
    Text = "Ses recommandations"
  },
  Event_50286_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50286_Desc = {
    Text = "Tu ne penses pas, tu ne te souviens pas.\nTu ne veux pas penser, tu ne veux pas te souvenir.\nLa légende de Missaga se terminera, mais son parcours ne s'arrêtera pas.\nTu dois continuer. Tu dois continuer"
  },
  Event_50286_Name = {
    Text = "Voyage solitaire II"
  },
  Event_50287_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50287_Desc = {
    Text = "« Cher Gardien : \n J'espère que tu vas bien. \n Je suis désolé de ne pas avoir pu rester à tes côtés lors de ce voyage à Lemvahi à cause de ma santé négligée. \n Mais au moment crucial, crois en ton unique assistant. \n Je serai toujours là quand tu auras besoin de moi. » \n En raison du temps, tu ne peux plus lire davantage. \n Mais l'écriture familière te procure une sensation de calme et de sérénité."
  },
  Event_50287_Name = {
    Text = "Ses recommandations"
  },
  Event_50288_ChoiceDesc1 = {
    Text = "[Il reviendra aussi] Obtenez une relique d'argent[(RelicConfig.Arg1)]"
  },
  Event_50288_ChoiceDesc2 = {
    Text = "[He Won't Come] Obtenir une relique d'or \"(RelicConfig.Arg1)\" et devenir infecté avec \"(Skill.Arg2)\""
  },
  Event_50288_Desc = {
    Text = "La dernière personne à quitter est Ryker.\nPour arrêter Casiah, il a choisi de rester dans la tente.\nIl t'avait promis qu'il irait brûler l'arbre-mère lors du rituel, et il le ferait sans aucun doute.\nMais il n'est toujours pas venu à tes côtés.\nIl ne te reste que toi seule"
  },
  Event_50288_Name = {
    Text = "Voyage solitaire III"
  },
  Event_50289_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50289_Desc = {
    Text = "Grouille, grouille, trois terrifiantes sphères roulent sur le site du rituel.\nTu as l'impression de ne plus être toi-même, l'atmosphère de rituel pathologiquement imbibée de frénésie t'aspire dans l'illusion indicible"
  },
  Event_50289_Name = {
    Text = "Trois offrandes"
  },
  Event_50290_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50290_Desc = {
    Text = "La foi des Arlans est si dévouée, prête à être enterrée par le sable encore et encore.\nMais en levant les yeux, il n'y a pas de soleil dans la tempête"
  },
  Event_50290_Name = {
    Text = "Géant de sable et de poussière"
  },
  Event_50291_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50291_Desc = {
    Text = ": Que le désert réponde à leur dévotion"
  },
  Event_50291_Name = {
    Text = "Géant de sable et de poussière"
  },
  Event_50292_ChoiceDesc1 = {
    Text = "[Break Free from Memories] Améliorez aléatoirement la qualité de l'oraison d'une carte."
  },
  Event_50292_ChoiceDesc2 = {
    Text = "[Capturer les souvenirs] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_50292_Desc = {
    Text = "La deuxième personne à partir était William"
  },
  Event_50292_Name = {
    Text = "Voyage solitaire II"
  },
  Event_50293_ChoiceDesc1 = {
    Text = "[Calm] Obtenez 25 Sigils Noirs"
  },
  Event_50293_ChoiceDesc2 = {
    Text = "[Worry] Obtenez la relique en argent \"(RelicConfig.Arg1)\" et soyez infecté par \"(Skill.Arg2)\"."
  },
  Event_50293_Desc = {
    Text = "Tu te souviens soudain du jour où tu as commencé ton voyage. \n Ramona te rappelle de préparer ton bagage, William t'a préparé un manuel pour documenter le parcours, et Ryker a discrètement glissé une bouteille de whiskey dans ton sac. \n Maintenant, ils sont tous partis. \n\n La première à partir est Ramona, la force de Tawil et le pouvoir du mur de tempête s'opposent, elle est vaincue par la fièvre le long du chemin."
  },
  Event_50293_Name = {
    Text = "Voyage solitaire I"
  },
  Event_50294_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50294_Desc = {
    Text = "Tu attaques le pied de Nubia, elle perd l'équilibre, plusieurs tentacules en forme de liane s'agitent frénétiquement dans l'air, puis sont emportés par la tempête de sable"
  },
  Event_50294_Name = {
    Text = "Tempête de sable naturelle"
  },
  Event_50295_ChoiceDesc1 = {
    Text = "[Lire] Retirer 1 Carte"
  },
  Event_50295_ChoiceDesc2 = {
    Text = "[Put Away] Obtenez \"(RelicConfig.Arg1)\", infectez \"(Skill.Arg2)\""
  },
  Event_50295_Desc = {
    Text = "Clac clac.\nSous cet autel de fanatisme inhumain, le bruit lourd des tambours roule avec le vent sableux. Parmi les chants incessants, vous entendez le faible clic d'une machine à écrire - l'appel de Missaga, apaisant votre esprit agité"
  },
  Event_50295_Name = {
    Text = "Ses recommandations"
  },
  Event_50296_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50296_Desc = {
    Text = "Ryker possède une chance exceptionnelle. \nIl tiendra absolument ses promesses envers vous. \nAbsolument"
  },
  Event_50296_Name = {
    Text = "Voyage solitaire III"
  },
  Event_50297_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50297_Desc = {
    Text = "Cela ne te concerne pas.  \nCe dont tu as le plus besoin maintenant, c'est de te rapprocher et de détruire les restes de l'arbre-mère"
  },
  Event_50297_Name = {
    Text = "Trois offrandes"
  },
  Event_52373_ChoiceDesc1 = {Text = "[Leave]"},
  Event_52373_Desc = {
    Text = "Tu as survécu. Tu vois d'innombrables tas de terre empilés, des corps brûlés.\nIl semble que tu aies aussi brûlé quelque chose, mais cela n'a plus d'importance.\nTu entends, les cloches du royaume divin ont sonné"
  },
  Event_52373_Name = {
    Text = "Invasion de la Peste"
  },
  Event_52374_ChoiceDesc1 = {Text = "[Leave]"},
  Event_52374_Desc = {
    Text = "Tu as survécu. Tu vois d'innombrables tas de terre empilés, des corps brûlés.\nTu as lutté pour protéger ce que tu chéris, au prix de lourdes pertes. Mais cela n'a plus d'importance.\nTu entends, les cloches du royaume divin ont sonné"
  },
  Event_52374_Name = {
    Text = "Invasion de la Peste"
  },
  Event_52375_ChoiceDesc1 = {Text = "[Leave]"},
  Event_52375_Desc = {
    Text = "La colère du géant s'est temporairement apaisée. Les nuages se dissipent, la pluie cesse, le vent est calme. L'océan, tel une mère éternelle, caresse doucement le dos de Lémurie avec ses marées bienveillantes. Il ne reste que les corps en désordre et les décombres sur Lémurie. \nTu as lutté pour protéger ce que tu chéris, au prix de lourdes pertes. Mais cela n'a plus d'importance. \nDans l'océan, tu as aperçu le contour du Royaume Divin."
  },
  Event_52375_Name = {
    Text = "Le rugissement de l'océan"
  },
  Event_52376_ChoiceDesc1 = {
    Text = "[Offrir un Sacrifice Supplémentaire] Supprimez 1 carte de commandement et ajoutez 1 carte de chaque type de [royaume divin fantasme], soit 3 cartes au total, dans la pioche"
  },
  Event_52376_Desc = {
    Text = ": Debout devant le trône effondré de la lémurie, tu offres le dernier tribut.\nL'infini abysse se dévoile devant toi. Tu te prosternes, souris, les larmes aux yeux.\n“Regarde, père, Débora. Regarde, mon roi suprême — le royaume divin est déjà descendu devant moi !”"
  },
  Event_52376_Name = {
    Text = "Accueillez, Pays des dieux"
  },
  Event_52377_ChoiceDesc2 = {
    Text = "[Protéger Ce Que Vous Chérissez] Perdre Arg1 Vie, gagner 1 carte de symptôme aléatoire."
  },
  Event_52377_Desc = {
    Text = "Terre. Terre silencieuse, Terre stable. Terre qui porte l'humanité, Terre éternelle et immortelle. Mais la Terre tremble. Elle se fend d'une crevasse insondable, tout ce qu'elle soutient est précaire. \n Tu mets tous tes espoirs dans la Terre, lorsque la Terre commence à trembler, où iras-tu ? \n Sacrifiez, les citoyens de Lémuria vous appellent. Sacrifiez tout ce que vous avez, afin que le Royaume Divin sans calamité descende."
  },
  Event_52377_Name = {
    Text = "Tremblement de la Terre"
  },
  Event_52378_ChoiceDesc2 = {
    Text = "[Protéger Ce Que Vous Chérissez] Perdre Arg1 Vie, gagner 1 carte de symptôme aléatoire."
  },
  Event_52378_Desc = {
    Text = "Océan. L'océan est la mère qui a donné naissance à Lémuria, c'est ta vie, ta foi. Et en ce moment, l'océan se lève tel un géant colérique des légendes. Il crie, appelle, transformant les eaux douces en roches géantes et en pointes dures, frappant tout ce qui se trouve devant lui. Il regarde froidement les Lémuriens tremblant à ses pieds, observant ceux qui fuient comme des insectes. Il détruira Lémuria, cela n'a rien à voir avec Lémuria. \n Sacrifiez-vous, les citoyens de Lémuria vous appellent. Offrez tout ce que vous avez, afin que le Royaume Divin sans calamité descende."
  },
  Event_52378_Name = {
    Text = "Le rugissement de l'océan"
  },
  Event_52379_ChoiceDesc2 = {
    Text = "[Protéger Ce Que Vous Chérissez] Perdre Arg1 Vie, gagner 1 carte de symptôme aléatoire."
  },
  Event_52379_Desc = {
    Text = "Peste. La peste est partout. La peste est la plus indécente des servantes, lorsque la punition des dieux de la terre et de l'océan est passée, elle prononce le jugement des morts qui ne peuvent être évoqués par la bouche. Enterrez les corps des proches, brûlez les corps des proches, priez pour que ceux qui sont morts pour se protéger s'éloignent de vous autant que possible. La vie et l'humanité s'effondrent devant la peste. \n Sacrifiez-vous, citoyens de Lémuria vous appellent. Sacrifiez tout ce que vous avez, que le Royaume Divin sans calamité descende."
  },
  Event_52379_Name = {
    Text = "Invasion de la Peste"
  },
  Event_52380_ChoiceDesc1 = {Text = "[Leave]"},
  Event_52380_Desc = {
    Text = "Le fort tremblement s'est calmé. Les rues sont tachées de sang, des maisons effondrées enterrent de nombreuses personnes.\nVous avez protégé ce qui vous est cher, au prix de grands sacrifices. Mais cela n'a plus d'importance.\nL'important, c'est que vous êtes plus proche du royaume divin"
  },
  Event_52380_Name = {
    Text = "Tremblement de la Terre"
  },
  Event_52381_ChoiceDesc1 = {Text = "[Leave]"},
  Event_52381_Desc = {
    Text = ": Debout devant le trône effondré de la lémurie, tu récites la dernière prière.\nL'infini abysse se dévoile devant toi. Tu te prosternes, souris, les larmes aux yeux.\n“Regarde, père, Débora. Regarde, mon roi suprême — le royaume divin est déjà descendu devant moi !”"
  },
  Event_52381_Name = {
    Text = "Accueillez, Pays des dieux"
  },
  Event_52382_ChoiceDesc1 = {Text = "[Leave]"},
  Event_52382_Desc = {
    Text = "Le fort tremblement s'est calmé. Les rues sont tachées de sang, des maisons effondrées enterrent de nombreuses personnes.\nQuelque chose de vous semble aussi enterré sous les décombres, mais cela n'a plus d'importance.\nL'important, c'est que vous êtes plus proche du royaume divin"
  },
  Event_52382_Name = {
    Text = "Tremblement de la Terre"
  },
  Event_52383_ChoiceDesc1 = {Text = "[Leave]"},
  Event_52383_Desc = {
    Text = "La colère du géant s'est temporairement apaisée. Les nuages se dissipent, la pluie cesse, le vent est calme et la mer est tranquille. L'océan, tel une mère éternelle, caresse doucement le dos de Lémurie avec ses marées douces. Il ne reste que des cadavres et des ruines éparpillés sur Lémurie. \nIl semble que quelque chose de vous se soit perdu dans la mer, mais cela n'a plus d'importance. \nDans l'océan, vous avez aperçu les contours du Royaume Divin."
  },
  Event_52383_Name = {
    Text = "Le rugissement de l'océan"
  },
  Event_52384_ChoiceDesc1 = {
    Text = "[Devout Prayer] Transformez chaque carte de symptôme ordinaire du paquet en 1 \"Phantasme du Royaume de Dieu\" et gagnez 2 \"Phantasmes du Royaume de Dieu\" supplémentaires."
  },
  Event_52384_ChoiceDesc2 = {
    Text = "[Devout Prayer] Transformez chaque carte de symptôme ordinaire du paquet en 1 \"Phantasme du Royaume de Dieu\" et gagnez 2 \"Phantasmes du Royaume de Dieu\" supplémentaires."
  },
  Event_52384_Desc = {
    Text = "La Terre ne tremble plus, l'océan ne rugit plus, la peste ne sévit plus. Le Fléau a détruit Lémuria, te laissant derrière. Tu lèves les yeux et observes ton entourage, tout est dévasté. Tu baisses les yeux vers tes mains, elles sont vides. \nMais qu'importe, cher Grand Prêtre ? Avance en rampant sur les décombres et les corps de Lémuria. \nTu es à un pas du Royaume Divin."
  },
  Event_52384_Name = {
    Text = "Accueillez, Pays des dieux"
  },
  Event_53140_ChoiceDesc1 = {Text = "[Leave]"},
  Event_53140_Desc = {
    Text = "Vous acceptez l'appel de l'école, la voix familière vous apaise. Vous reprenez courage et continuez"
  },
  Event_53140_Name = {
    Text = "Point de contact"
  },
  Event_53141_ChoiceDesc1 = {
    Text = "[Connect] Restore Arg2 Vie."
  },
  Event_53141_ChoiceDesc2 = {
    Text = "[Meditate] Choisir de Réveiller 1 Réveilleur."
  },
  Event_53141_ChoiceDesc3 = {
    Text = "[Expel] Éliminez jusqu'à 3 cartes de symptômes, et gagnez des sigils noirs Arg2."
  },
  Event_53141_ChoiceDesc4 = {
    Text = "[Fall into Madness] Réveiller aléatoirement 2 Réveilleurs et gagner 1 Symptôme aléatoire."
  },
  Event_53141_ChoiceDesc5 = {
    Text = "[Hésitation] Autres"
  },
  Event_53141_Desc = {
    Text = "Tu explores dans la brume, soudain, l'insigne sur ta poitrine émet une faible lueur argentée. Qui t'appelle de l'autre côté de la communication ?"
  },
  Event_53141_Name = {
    Text = "Point de contact"
  },
  Event_53141_Tips3 = {
    Text = "Aucune carte de symptôme"
  },
  Event_53142_ChoiceDesc1 = {Text = "[Leave]"},
  Event_53142_Desc = {
    Text = "Vous acceptez l'appel de l'école, la voix familière vous apaise. Vous reprenez courage et continuez"
  },
  Event_53142_Name = {
    Text = "Point de contact"
  },
  Event_53143_ChoiceDesc1 = {Text = "[Leave]"},
  Event_53143_Desc = {
    Text = "Vous acceptez l'appel de l'école, la voix familière vous apaise. Vous reprenez courage et continuez"
  },
  Event_53143_Name = {
    Text = "Point de contact"
  },
  Event_53147_ChoiceDesc1 = {
    Text = "[Expel] Éliminez jusqu'à 3 cartes de symptômes, et gagnez des sigils noirs Arg2."
  },
  Event_53147_ChoiceDesc2 = {
    Text = "[Fall into Madness] Réveiller aléatoirement 2 Réveilleurs et gagner 1 Symptôme aléatoire."
  },
  Event_53147_Desc = {
    Text = "Tu explores dans la brume, soudain, l'insigne sur ta poitrine émet une faible lueur argentée. Qui t'appelle de l'autre côté de la communication ?"
  },
  Event_53147_Name = {
    Text = "Point de contact"
  },
  Event_53147_Tips1 = {
    Text = "Aucune carte de symptôme"
  },
  Event_53148_ChoiceDesc1 = {Text = "[Leave]"},
  Event_53148_Desc = {
    Text = "Tu établis la communication. De l'autre côté du communicator, une voix folle et envoûtante retentit.\n\"Souviens-toi. C'est le don du royaume divin.\""
  },
  Event_53148_Name = {
    Text = "Point de contact"
  },
  Event_55782_ChoiceDesc1 = {
    Text = "[Couper les ronces] Dans la prochaine bataille, la vie de l'ennemi augmente de 30%, les dégâts augmentent de 15%, et gagne Arg1 images [(Skill.Arg2)]"
  },
  Event_55782_ChoiceDesc2 = {
    Text = "[Couper les ronces] Dans la prochaine bataille, la vie de l'ennemi augmente de 30%, les dégâts augmentent de 15%, et gagne Arg1 images [(Skill.Arg2)]"
  },
  Event_55782_ChoiceDesc3 = {
    Text = "[Écarter les épines] Infectez \"(Skill.Arg3)\", et placez Arg1 \"Imaginaire\" \"(Skill.Arg2)\" dans le deck."
  },
  Event_55782_ChoiceDesc4 = {
    Text = "[Écarter les épines] Infectez \"(Skill.Arg3)\", et placez Arg1 \"Imaginaire\" \"(Skill.Arg2)\" dans le deck."
  },
  Event_55782_ChoiceDesc5 = {
    Text = "[Leave the Thorns] \"Stylo et Encre d'Horla\" gagne Arg1 couche de \"Stylo et Encre.\""
  },
  Event_55782_Desc = {
    Text = "Quelque chose touche ton cœur. Tu t'arrêtes et regardes le coin du jardin. Sous les ronces, un point lumineux bouge, essayant de se libérer.\nQu'est-ce que c'est ? Un papillon ? Un oiseau ? Tu t'approches"
  },
  Event_55782_Name = {
    Text = ": bénédiction de muzu"
  },
  Event_55782_Tips1 = {
    Text = "Les ennemis sont renforcés pour le prochain combat, choix non disponible à nouveau"
  },
  Event_55783_ChoiceDesc1 = {
    Text = "[Create Offering] Choisissez 3 cartes \"Image\" et laissez Horla créer une \"Offrande\" pour vous."
  },
  Event_55783_ChoiceDesc2 = {Text = "[Leave]"},
  Event_55783_Desc = {
    Text = "Tu arrives devant une belle serre, et à travers la fenêtre, tu regardes à l'intérieur, mais tu ne vois rien. \n Une brise se lève, les pétales et les feuilles de la serre sont emportés par le vent, dansant et se rassemblant dans les airs. Au milieu des fleurs et des feuilles, tu aperçois la silhouette d'une jeune fille. \n « Ah ! Des visiteurs dans le jardin, » s'exclame-t-elle avec surprise et nervosité en te regardant. « Désolée, Colette est sortie... Je ne connais pas vraiment les prix de ces fleurs... » \n La jeune fille s'arrête soudainement, s'approche de toi et te scrute. « Ah, cher visiteur, je ressens en toi l'essence de la poésie... Peut-être pourrions-nous créer un poème ensemble ? »"
  },
  Event_55783_Name = {
    Text = "Cadeau du printemps"
  },
  Event_55783_Tips1 = {
    Text = "\"Inspirations Insuffisantes\" Au moins 3 sont nécessaires pour synthétiser."
  },
  Event_55799_ChoiceDesc1 = {Text = "[Leave]"},
  Event_55799_Desc = {
    Text = "Les ronces ressuscitées semblent agitées, mais ces coûts sont insignifiants - dans ce point lumineux, vous entendez l'appel de la Muse"
  },
  Event_55799_Name = {
    Text = ": bénédiction de muzu"
  },
  Event_55819_ChoiceDesc1 = {
    Text = "[Follow the Body's Memory] Évitez la bataille et revendiquez une victoire instantanée, mais perdez des points de Vie d'Arg1."
  },
  Event_55819_ChoiceDesc2 = {
    Text = "[Leave] Entrer dans la Bataille"
  },
  Event_55819_Desc = {
    Text = "Face à un ennemi familier, tu es déjà parfaitement conscient du combat à venir"
  },
  Event_55819_Name = {
    Text = "Mémoire musculaire"
  },
  Event_55997_ChoiceDesc1 = {Text = "[Leave]"},
  Event_55997_Desc = {
    Text = "Parmi les images collectées, tu en as sélectionné quelques-unes et les as remises à la jeune fille. \n « Quelles belles images ! Ce client, attendez... Voici. C'est le poème d'offrande que le printemps t'apporte, rien que pour toi ! » \n Un poème apparaît dans ta main, comme une fleur qui s'ouvre spécialement pour toi. \n Tu veux remercier la jeune fille. Mais lorsque tu relèves la tête, sa silhouette a déjà disparu. Dans la maison des fleurs solitaire, il ne reste que des fleurs et des feuilles fanées sur le sol. \n — C'étaient les cendres restantes après que le printemps se soit consumé."
  },
  Event_55997_Name = {
    Text = "Cadeau du printemps"
  },
  Event_55999_ChoiceDesc1 = {Text = "[Leave]"},
  Event_55999_Desc = {
    Text = "Les épines denses vous font reculer. Vous vous êtes éloigné du point lumineux, mais ce bref instant d'observation a rempli votre cœur d'une nouvelle inspiration - au point lumineux, vous avez entendu l'appel de la muse"
  },
  Event_55999_Name = {
    Text = ": bénédiction de muzu"
  },
  Event_56000_ChoiceDesc1 = {Text = "[Leave]"},
  Event_56000_Desc = {
    Text = "Tu écartes les ronces avec ta main, te blessant légèrement, mais ces sacrifices sont insignifiants—tu entends l'appel de la Muse dans ce point lumineux"
  },
  Event_56000_Name = {
    Text = ": bénédiction de muzu"
  },
  Event_56024_ChoiceDesc1 = {Text = "[Leave]"},
  Event_56024_Desc = {
    Text = "Ce n'est pas suffisant... tu continues à te rapprocher de ce point lumineux. Les épines se sont mises en colère, te montrant leurs pointes. Mais cela en vaut la peine.\nCe point lumineux s'est dispersé de ta paume, et dans la voûte de lumière, tu as clairement ressenti la bénédiction de muzu"
  },
  Event_56024_Name = {
    Text = ": bénédiction de muzu"
  },
  Event_56025_ChoiceDesc1 = {
    Text = "[S'approcher de la lumière] dans le prochain combat, la vie des ennemis augmente de 30% et les dégâts de 15%, vous pouvez choisir 1[image] à améliorer"
  },
  Event_56025_ChoiceDesc2 = {Text = "[Leave]"},
  Event_56025_Desc = {
    Text = "Tu coupes les ronces avec tes outils, elles semblent agitées, mais ces sacrifices sont insignifiants—tu entends l'appel de la Muse dans ce point lumineux"
  },
  Event_56025_Name = {
    Text = ": bénédiction de muzu"
  },
  Event_56146_ChoiceDesc1 = {Text = "[Leave]"},
  Event_56146_Desc = {
    Text = "Ce n'est pas suffisant... tu continues à te rapprocher de ce point lumineux. Les épines aiguisées ont coupé ta main, te faisant saigner. Mais cela en vaut la peine.\nCe point lumineux s'est dispersé de ta paume, et, dans la voûte de lumière, tu as clairement ressenti la bénédiction de muzu"
  },
  Event_56146_Name = {
    Text = ": bénédiction de muzu"
  },
  Event_56147_ChoiceDesc1 = {
    Text = "[Creative Impulse] Tous les Réveilleurs perdent tout Aliemus. Choisir 3 cartes \"Image\" et laisser Horla créer une \"Offrande\" pour vous."
  },
  Event_56147_ChoiceDesc2 = {Text = "[Leave]"},
  Event_56147_Desc = {
    Text = "Vous acceptez l'appel de l'école, la voix familière vous apaise. Vous reprenez courage et continuez"
  },
  Event_56147_Name = {
    Text = "Point de contact"
  },
  Event_56147_Tips1 = {
    Text = "\"Inspirations Insuffisantes\" Au moins 3 sont nécessaires pour synthétiser."
  },
  Event_56148_ChoiceDesc1 = {Text = "[Leave]"},
  Event_56148_Desc = {
    Text = "L'éclat argenté de l'emblème te remplit d'émotion. Suivant ton instinct, tu jettes ce que tu tiens dans les ronces. Une lumière commence à briller - dans cette lumière, tu trouves une nouvelle inspiration"
  },
  Event_56148_Name = {
    Text = "Point de contact"
  },
  Event_56149_ChoiceDesc1 = {
    Text = "[Approchez du point lumineux] Réduisez de 10% la limite de vie, choisissez une carte [Image] à améliorer"
  },
  Event_56149_ChoiceDesc2 = {Text = "[Leave]"},
  Event_56149_Desc = {
    Text = "Tu écartes les ronces avec ta main, te blessant légèrement, mais ces sacrifices sont insignifiants—tu entends l'appel de la Muse dans ce point lumineux"
  },
  Event_56149_Name = {
    Text = ": bénédiction de muzu"
  },
  Event_56149_Tips1 = {
    Text = "Aucune \"image\" à améliorer"
  },
  Event_56150_ChoiceDesc1 = {Text = "[Leave]"},
  Event_56150_Desc = {
    Text = "L'éclat argenté de l'emblème te remplit d'émotion. Tu ressens une forte impulsion d'écrire les vers qui te viennent à l'esprit"
  },
  Event_56150_Name = {
    Text = "Point de contact"
  },
  Event_56151_ChoiceDesc1 = {
    Text = "[New Inspiration] Retirez 1 carte \"Image\", et améliorez aléatoirement 1 \"Image\"."
  },
  Event_56151_ChoiceDesc2 = {Text = "[Leave]"},
  Event_56151_Desc = {
    Text = "Vous acceptez l'appel de l'école, la voix familière vous apaise. Vous reprenez courage et continuez"
  },
  Event_56151_Name = {
    Text = "Point de contact"
  },
  Event_56151_Tips1 = {
    Text = "Aucune carte \"Image\""
  },
  Event_57738_ChoiceDesc1 = {
    Text = "[Forcer le passage] Tous les éveillés gagnent 30 points de folie, mais deux cartes[(Skill.Arg1)] sont ajoutées au deck"
  },
  Event_57738_ChoiceDesc2 = {
    Text = "[Disarm] Les ennemis dans la prochaine bataille gagnent 60 % de vie supplémentaire et infligent 30 % de dégâts supplémentaires."
  },
  Event_57738_ChoiceDesc3 = {
    Text = "[Ambush] Épuiser tous les Aliemus de l'Éveilleur, gagner 30 Sigils noirs et retirer la Menace de Garde."
  },
  Event_57738_Desc = {
    Text = "Tu épies depuis le point aveugle du coin. Les agents du comité de censure surveillent une autre direction et ne remarquent pas votre présence. \nLes images de ton entraînement défilent dans ta tête, et face à cet ennemi qui bloque votre chemin incontournable, tu trouves rapidement une manière appropriée de le traiter."
  },
  Event_57738_Name = {
    Text = "Agent de l'Audience de révision"
  },
  Event_57738_Tips3 = {
    Text = "Aucun éveillé en folie"
  },
  Event_57739_ChoiceDesc1 = {Text = "[Leave]"},
  Event_57739_Desc = {
    Text = "Vous observez attentivement. Les agents du comité bloquent votre chemin incontournable, surveillant sérieusement cette zone devant vous.\nFace à un grand nombre d'ennemis, vous ne pouvez pas rivaliser avec eux.\nAvancer ou reculer ?"
  },
  Event_57739_Name = {
    Text = "Point de détention"
  },
  Event_57776_ChoiceDesc1 = {Text = "[Leave]"},
  Event_57776_ChoiceDesc2 = {
    Text = "[Fausse reddition] Après avoir exploré la zone, téléportez-vous au point de détention, obtenez 2 cartes de [Symptôme] aléatoires"
  },
  Event_57776_ChoiceDesc3 = {
    Text = "[Intrusion] Après exploration de cette zone, téléportez-vous au point de détention et perdez Arg1 Vie."
  },
  Event_57776_Desc = {
    Text = "Vous observez attentivement. Les agents du comité bloquent votre chemin incontournable, surveillant sérieusement cette zone devant vous.\nFace à un grand nombre d'ennemis, vous ne pouvez pas rivaliser avec eux.\nAvancer ou reculer ?"
  },
  Event_57776_Name = {
    Text = "Point de surveillance"
  },
  Event_57776_Tips3 = {
    Text = "Vie insuffisante"
  },
  Event_59193_ChoiceDesc1 = {
    Text = "[Bénédiction d'Alistair] Ajoute une carte [Lueur Nocturne] au deck"
  },
  Event_59193_Desc = {
    Text = "Ce certificat d'admission est resté au fond de ta valise. Tu caresses son cadre délicat, sentant l'odeur de l'encre. L'emblème de Missaga brille comme une porte vers l'avenir, attirant ton regard avide — comme ce jour-là, comme aujourd'hui"
  },
  Event_59193_Name = {
    Text = "Cérémonie d'entrée"
  },
  Event_59527_ChoiceDesc1 = {
    Text = "Choisissez une carte pour comprendre l'oraison \"Lex Nous\". \"Lex Nous\" : En jouant, piochez 2 cartes ; leur coût arithmétique est réduit au coût réel de la carte oraison, valable une seule fois par bataille."
  },
  Event_59527_Desc = {
    Text = "Le symbole de l'intellect est gravé sur votre document.\nLes pensées de Tawil s'infiltrent dans votre esprit. Parmi ces possibilités infinies, vous empruntez le seul chemin correct"
  },
  Event_59527_Name = {
    Text = "Cérémonie d'entrée"
  },
  Event_59528_ChoiceDesc1 = {
    Text = "Choisissez une carte pour comprendre l'oraison \"Lex Volis\". \"Lex Volis\" : En jouant, défaussez toutes les cartes autres que celles de cet éveilleur, gagnez 5 cartes non-éveilleur aléatoires, valable une seule fois par bataille."
  },
  Event_59528_Desc = {
    Text = "Le symbole de la joie est gravé sur votre document.\nÀ travers la marque, N vous observe. Il attend que vous lui apportiez un dénouement qui n'a jamais été proclamé"
  },
  Event_59528_Name = {
    Text = "Cérémonie d'entrée"
  },
  Event_59529_ChoiceDesc1 = {
    Text = "Choisissez une carte pour comprendre l'oraison \"Lex Genis\". \"Lex Genis\" : Lors de la lecture, gagnez 3 copies originales supplémentaires avec \"Conserver\" et \"Consomme\", valable uniquement une fois par bataille."
  },
  Event_59529_Desc = {
    Text = "Le symbole de la procréation est gravé sur votre document.\nThais met ses espoirs en vous, il cohabitera avec vous dans tous les mondes"
  },
  Event_59529_Name = {
    Text = "Cérémonie d'entrée"
  },
  Event_59566_ChoiceDesc1 = {
    Text = "[Essuyer les larmes de sang] Choisissez 1 Carte d'instruction parmi 3 pour obtenir une Oraison : [(EnchantConfig.Arg1)]"
  },
  Event_59566_ChoiceDesc2 = {
    Text = "[Eyes Open] Gagner aléatoirement 3 cartes de commande avec oraison : \"(EnchantConfig.Arg1)\", infecté avec \"(Skill.Arg2)\""
  },
  Event_59566_Desc = {
    Text = "Des milliers de tes souhaits fusionnent en un seul. Vous aviez tous une origine commune, maintenant vous partagez un même corps.\nDes milliers d'yeux s'ouvrent pour affronter ce grand œil.\nDes milliers d'yeux se brisent, versant des larmes de sang sèches et douloureuses"
  },
  Event_59566_Name = {Text = "Ma fusion"},
  Event_59567_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59567_Desc = {
    Text = "Tu essayes de discuter avec cette voix folle, de réfuter cette idée illusoire.\n\"Tout doit mourir, est-ce que la vie elle-même n'a donc aucun sens ?\"\nTu t'énerves, pourtant ce rire ne diminue pas, comme s'il se moquait de ta stupidité"
  },
  Event_59567_Name = {
    Text = "Agneau en attente de la mort"
  },
  Event_59568_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59568_Desc = {
    Text = "Tu regardes cette porte, ne souhaitant plus endurer la douleur de l'ignorance. \n Tu veux voir ce qu'il y a derrière la porte. \n La porte illusoire oscille de manière envoûtante, tu vois les ombres de d'innombrables mondes passer en un éclair. \n Pas le temps de voir clairement, une multitude d'informations submergent ton esprit, ton cerveau est rempli de bruits chaotiques."
  },
  Event_59568_Name = {
    Text = "Derrière la porte"
  },
  Event_59569_ChoiceDesc1 = {
    Text = "[commandement résolu] réveille aléatoirement 1 réveilleur, contamine[(Skill.Arg1)]"
  },
  Event_59569_ChoiceDesc2 = {
    Text = "[discuter ensemble] choisissez une carte parmi 3 cartes de commandement et obtenez l'oraison : [(EnchantConfig.Arg1)]"
  },
  Event_59569_Desc = {
    Text = "Tout se passe si soudainement, vous sentez une brume vaporeuse vous entourer, vous luttez pour regarder autour de vous, mais vous ne voyez rien.\nLes réveilleurs attendent vos ordres.\nMaintenant, vous êtes isolé et sans aide, ne pouvant compter que sur votre propre pouvoir"
  },
  Event_59569_Name = {
    Text = "Œil de l'ignorance"
  },
  Event_59570_ChoiceDesc1 = {
    Text = "[Sacrifice] Obtenez une relique maudite \"(RelicConfig.Arg1)\", infectée par \"(Skill.Arg2)\""
  },
  Event_59570_ChoiceDesc2 = {
    Text = "[Avec courage] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : [(EnchantConfig.Arg1)]"
  },
  Event_59570_ChoiceDesc3 = {
    Text = "[Stare Directly] Gagnez 50 Sigils Noirs"
  },
  Event_59570_Desc = {
    Text = "Des milliers de toi se tiennent dans des mondes infinis, épaule contre épaule, main dans la main, comme des frères et sœurs.\nMaintenant, vous vous tenez ensemble sous cette immense ombre, levant la tête sans reculer.\nQue faire ?\nComment vaincre ce toi ultime ?"
  },
  Event_59570_Name = {
    Text = "Ma réponse"
  },
  Event_59571_ChoiceDesc1 = {
    Text = "[Chercher des réponses] Obtenez Arg1 le sigil noir, infection[(Skill.Arg2)], continuez à choisir"
  },
  Event_59571_ChoiceDesc2 = {
    Text = "[Abandonner] Gagnez 25 sigils noirs et partez."
  },
  Event_59571_Desc = {
    Text = "À travers les illusions de la porte, d'innombrables souvenirs de tout ce que tu as vécu défilent dans ton esprit. \n Certains sont morts, d'autres sont fous, certains persistent, d'autres tombent. \n D'innombrables chemins, d'innombrables choix défilent devant toi, et tu as l'impression d'avoir vécu une vie longue et infinie en un instant. \n Maintenant, d'innombrables esprits, d'innombrables bouches fonctionnent simultanément. \n Tu essaies de transcender le temps et l'espace pour dialoguer avec d'innombrables versions de toi-même, pêchant des réponses dans des souvenirs infinis."
  },
  Event_59571_Name = {
    Text = "Ma réflexion personnelle"
  },
  Event_59572_ChoiceDesc1 = {
    Text = "[Échange de pouvoir] Tirez une carte de commandement au hasard pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_59572_ChoiceDesc2 = {
    Text = "[Échange de chance] Augmentez Arg1 points de santé max, infectez[(Skill.Arg2)]"
  },
  Event_59572_Desc = {
    Text = "Chaque choix a un prix. \nVie, esprit, émotions, souvenirs… \nQue souhaites-tu échanger avec le destin, et que choisis-tu de lâcher sur la balance ?"
  },
  Event_59572_Name = {
    Text = "Choix du destin"
  },
  Event_59573_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59573_Desc = {
    Text = "Comment une personne peut-elle se passer de cœur ?\nTu cherches frénétiquement autour de toi, ta respiration devient de plus en plus rapide, la peur de la mort enveloppe ton esprit.\n« Je ne peux plus respirer... mon cœur va s'arrêter... »\nAttends, il semble que tu n'aies plus besoin de battre de cœur.\nTu réalises soudainement et commences à rire joyeusement."
  },
  Event_59573_Name = {
    Text = "Poitrine vide"
  },
  Event_59574_ChoiceDesc1 = {
    Text = "[Regarder] Relique en or obtenue \"(RelicConfig.Arg1)\", infectée avec \"(Skill.Arg2)\""
  },
  Event_59574_ChoiceDesc2 = {
    Text = "[Éviter] Réveillez 2 éveillés au hasard, infectez deux fois[(Skill.Arg1)]"
  },
  Event_59574_ChoiceDesc3 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_59574_Desc = {
    Text = "Tu sens une présence dans le vide te fixer.\nOù que tu ailles, ce regard te suit.\nTu te sens comme une proie, ton dos commence à te faire mal comme des piqûres"
  },
  Event_59574_Name = {Text = "Son regard"},
  Event_59575_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59575_Desc = {
    Text = "Tu restes impassible face à la musique frénétique, maintenant ton propre rythme.\nLes attaques et les tentations de l'autre sont inefficaces, le piano joue deux mélodies simultanément, celui qui persévère jusqu'à la fin maîtrisera toutes les notes"
  },
  Event_59575_Name = {
    Text = "Chanson de la fête de l'Apocalypse"
  },
  Event_59576_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59576_Desc = {
    Text = "Tu rassembles tout ton courage, peu importe ce qui t'attend, tu continueras avec tes compagnons"
  },
  Event_59576_Name = {
    Text = "Avenir figé"
  },
  Event_59577_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59577_Desc = {
    Text = "« Où es-tu maintenant ? » \n « Quels sont les projets des enseignants ? » \n « Que dois-je faire ensuite ? » \n Tu presses les questions, désireux de te fier à cette présence fiable comme d'habitude. \n Le communicateur a perdu toute réaction, comme s'il était bloqué, tu secoues la machine, et dans le mouvement, les mots de la réponse se transforment en une nuée de papillons qui s'écrasent sur ton visage. \n Tu frottes tes yeux et découvres que tout cela n'est qu'une illusion. \n La feuille de la réponse est blanche comme neige."
  },
  Event_59577_Name = {
    Text = "Écho hallucinatoire"
  },
  Event_59578_ChoiceDesc1 = {
    Text = "[Recherche de panique] Augmenter la santé maximale de Arg1"
  },
  Event_59578_ChoiceDesc2 = {
    Text = "[Tenter de remplir] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_59578_Desc = {
    Text = "Tu sens un vide et une légèreté dans ta poitrine, tu baisses les yeux et vois un trou en forme de serrure.\nTon cœur a disparu"
  },
  Event_59578_Name = {
    Text = "Poitrine vide"
  },
  Event_59579_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59579_Desc = {
    Text = "Tu interroges vivement son but, mais tu ne récoltes qu'un sourire inchangé.\n\nIl s'est depuis longtemps détourné du monde, une personne libre de toute attache n'a besoin d'être responsable de rien.\nTu ne peux que lutter en vain"
  },
  Event_59579_Name = {
    Text = "Gentleman Fou"
  },
  Event_59580_ChoiceDesc1 = {
    Text = "[Disrupt Rhythm] Gagnez une relique d'argent \"(RelicConfig.Arg1)\" et devenez infecté par \"(Skill.Arg2)\"."
  },
  Event_59580_ChoiceDesc2 = {
    Text = "[Self-Preservation] Obtenir une Oraison à 3 choix"
  },
  Event_59580_Desc = {
    Text = "Vous avez l'impression de jouer avec une folle, qui vous a kidnappé aux touches du piano, vous entraînant dans ses morceaux fous.  \nVous luttez difficilement à jouer sur son rythme, trébuchant.  \nVous peinez à rivaliser avec elle, tentant de contrôler la mélodie"
  },
  Event_59580_Name = {
    Text = "Chanson de la fête de l'Apocalypse"
  },
  Event_59581_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59581_Desc = {
    Text = "Tu souhaites avoir une force inégalée, capable de briser toutes les chaînes et obstacles.\nMais la force humaine est limitée, défier les dieux avec un corps insignifiant finira par brûler ta vie comme une allumette"
  },
  Event_59581_Name = {
    Text = "Choix du destin"
  },
  Event_59582_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59582_Desc = {
    Text = "«Il n'y en a plus... Il n'y en a plus... »\n Cette sensation de vide est désagréable, tu prends ta montre de poche, une pomme et la veste de l'uniforme scolaire, essayant de combler le trou dans ta poitrine.\n Ta poitrine redevient pleine, mais tu as l'impression d'être trop repu.\n Ce n'est pas grave, les choses ne sont jamais parfaites."
  },
  Event_59582_Name = {
    Text = "Poitrine vide"
  },
  Event_59583_ChoiceDesc1 = {
    Text = "[Persuader] Gagner 25 sigils noirs"
  },
  Event_59583_ChoiceDesc2 = {
    Text = "[Question] Obtenez la Relique Argent \"(RelicConfig.Arg1)\", infectez \"(Skill.Arg2)\""
  },
  Event_59583_Desc = {
    Text = "Les chaussures de N s'arrêtent devant vous, un sourire déformé sur son visage sombre.\nIl s'habille toujours impeccablement, mais derrière cette façade de gentleman se cache une folie pure.\nIl n'a pas d'amis, et peu d'ennemis.\nCar ils disparaissent tous de la manière la plus théâtrale qui soit.\nMalheureusement, vous êtes désormais son prochain rôle principal.\nPréparez votre réplique d'ouverture. Comment allez-vous satisfaire ce public des plus exigeants ?"
  },
  Event_59583_Name = {
    Text = "Gentleman Fou"
  },
  Event_59584_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59584_Desc = {
    Text = "Les corps éveillés n'en savent pas plus que vous, mais ils sont vos partenaires, alliés et soutiens les plus fidèles.\nVous discutez des stratégies avec eux, malgré vos doutes, vous avez le courage de repartir"
  },
  Event_59584_Name = {
    Text = "Œil de l'ignorance"
  },
  Event_59585_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59585_Desc = {
    Text = "Comme si tu avais pris une décision, tu réponds fermement.\nTa voix résonne parmi les bulles, comme si des milliers de toi prêtaient serment.\nTu es prêt à tout affronter"
  },
  Event_59585_Name = {
    Text = "Ses interrogations"
  },
  Event_59586_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59586_Desc = {
    Text = "Tu ne bouges pas, te contentant de fixer les mots sur la lettre de réponse. \n Sous ton regard, ces phrases deviennent progressivement floues et distordues, pour finalement se transformer en un essaim de papillons qui s'envolent bruyamment vers ton visage. \n Tu agites les mains pour chasser les papillons, et en te retournant, tu constates que la feuille de réponse est désormais vide de tout mot. \n En effet, les rêves trop beaux sont tous illusoires."
  },
  Event_59586_Name = {
    Text = "Écho hallucinatoire"
  },
  Event_59587_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59587_Desc = {
    Text = "Tu hais ces fils ignobles.\nTu les arraches violemment, certains se cassent, d'autres s'enroulent à nouveau.\nTu luttes de toutes tes forces contre eux"
  },
  Event_59587_Name = {
    Text = "Mains Manipulées"
  },
  Event_59588_ChoiceDesc1 = {
    Text = "[Abattre les silhouettes] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infectée par «(Skill.Arg2)»"
  },
  Event_59588_ChoiceDesc2 = {
    Text = "[Écraser l'Embryon] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infectée par «(Skill.Arg2)»"
  },
  Event_59588_ChoiceDesc3 = {
    Text = "[Close Your Eyes] Gain 25 black sigils"
  },
  Event_59588_Desc = {
    Text = "Dans un état second, vous voyez des gens d'Aran s'approcher de vous.\nIls rient, vous invitent à boire, danser, profiter du festin.\nPuis leur chair commence à se détacher par couches, tombant au sol et se tordant en nouveaux Embryons.\nIls tendent la main, vous invitant à rejoindre la célébration de chair et de renaissance."
  },
  Event_59588_Name = {
    Text = "Ombres du passé"
  },
  Event_59589_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59589_Desc = {
    Text = "Avant de tendre la main, vous vous souvenez soudain que vous n'avez jamais eu un tel chat.\nVous et le chat vous regardez à travers l'air, le chat cligne des yeux.\nLe chat ne se soucie pas de votre indifférence, il semble toujours vous aimer"
  },
  Event_59589_Name = {
    Text = "La tentation du chat"
  },
  Event_59590_ChoiceDesc1 = {
    Text = "[Incruster] choisir 1 relique pour la transformer en relique maudite[(RelicConfig.Arg1)]"
  },
  Event_59590_ChoiceDesc2 = {
    Text = "[Swallow] Gagnez une relique en argent \"(RelicConfig.Arg1)\" et infectez \"(Skill.Arg2)\""
  },
  Event_59590_ChoiceDesc3 = {
    Text = "[Store] Gagner 25 Sigils Noirs"
  },
  Event_59590_Desc = {
    Text = "Les trois forces des plasmides s'entrelacent en toi, et tu peines à maîtriser cette immense puissance. \n L'espace mental se dilate continuellement, une galaxie naît et s'étend ici. \n Face à des ennemis ininterrompus, tu pries sincèrement ce ciel étoilé, souhaitant l'aide de cette force. \n Une étoile tombe de la galaxie dans ta paume, émettant une lumière séduisante."
  },
  Event_59590_Name = {
    Text = "Étoile des Vœux"
  },
  Event_59591_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59591_Desc = {
    Text = "Tu restes silencieux aussi, vous ne communiquez pas, le silence est la réponse à tout.\nTu es prêt à tout affronter"
  },
  Event_59591_Name = {
    Text = "Ses interrogations"
  },
  Event_59592_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59592_Desc = {
    Text = "Ce chat est-il un menteur ?\nTu commences à douter de ces yeux bleus comme des piscines, le rire résonne à tes oreilles.\n\"Menteur, menteur, tu t'es fait avoir !\"\nUne inquiétude monte en toi"
  },
  Event_59592_Name = {
    Text = "Murmure secret"
  },
  Event_59593_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59593_Desc = {
    Text = "Vous observez en silence des émotions de plus en plus étrangères.\nVous réprimez tout désir de nostalgie, sentant votre âme devenir froide.\nC'est votre destin, votre chemin inévitable"
  },
  Event_59593_Name = {
    Text = "Cristal émotionnel"
  },
  Event_59594_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59594_Desc = {
    Text = "Ce sourire figé, tu ne peux ni le raisonner ni l'émouvoir.\nLes désirs humains ne le concernent pas.\nTes mots peuvent-ils dépasser l'imagination humaine ?"
  },
  Event_59594_Name = {
    Text = "Gentleman Fou"
  },
  Event_59595_ChoiceDesc1 = {
    Text = "[Réponse] Gagne Relique d'Or \"(RelicConfig.Arg1)\", Infection \"(Skill.Arg2)\""
  },
  Event_59595_ChoiceDesc2 = {
    Text = "[Silence] Réveiller aléatoirement 2 éveillés, infection deux fois[(Skill.Arg1)]"
  },
  Event_59595_Desc = {
    Text = "D'innombrables bulles ressemblant à des yeux ronds te regardent en silence, comme pour te poser une question muette.\nEs-tu prêt ?\nPrêt à tout abandonner ?\nPrêt à tout assumer ?"
  },
  Event_59595_Name = {
    Text = "Ses interrogations"
  },
  Event_59596_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59596_Desc = {
    Text = "Au moment de l'attaque de l'adversaire, tu ripostes immédiatement.\nTu as sagement discerné leur vraie nature, ce sont des bêtes montrant leurs crocs.\nTu as gagné par chance.\nFuis maintenant, ne te fais pas attraper"
  },
  Event_59596_Name = {
    Text = "S'enfoncer dans les abysses"
  },
  Event_59597_ChoiceDesc1 = {
    Text = "[Chercher des réponses] Obtenez Arg1 le sigil noir, infection[(Skill.Arg2)], continuez à choisir"
  },
  Event_59597_ChoiceDesc2 = {
    Text = "[Abandonner] Quitter"
  },
  Event_59597_Desc = {
    Text = "Que dois-tu faire ?\nTu regardes les innombrables reflets de toi-même, tous te fixant, leurs bouches bougeant.\nComme si tu avais trouvé un espoir, tu cherches, écoutes, espérant une réponse finale"
  },
  Event_59597_Name = {
    Text = "Ma réflexion personnelle"
  },
  Event_59598_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59598_Desc = {
    Text = "Le moment n'est pas encore venu, tu dois patienter.\nTu avales ta rancœur et ta haine, attendant le moment de tout risquer"
  },
  Event_59598_Name = {
    Text = "Mains Manipulées"
  },
  Event_59599_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59599_Desc = {
    Text = "Tu ressens une attraction mystérieuse, tu veux voir la source de ces regards.\nTu fixes le vide, croyant voir quelque chose.\nTa vision se brouille comme des flocons de neige, le monde semble changer.\nEn te frottant les yeux, tu vois des larmes de sang couler"
  },
  Event_59599_Name = {Text = "Son regard"},
  Event_59600_ChoiceDesc1 = {
    Text = "[Essayer de se souvenir] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infectée par «(Skill.Arg2)»"
  },
  Event_59600_ChoiceDesc2 = {
    Text = "[Savourer la tristesse] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infectée par «(Skill.Arg2)»"
  },
  Event_59600_ChoiceDesc3 = {
    Text = "[Accepter silencieusement] Gagnez 25 sigils noirs"
  },
  Event_59600_Desc = {
    Text = "Comme si tu avais subi la chirurgie cérébrale la plus précise, tu sens clairement des souvenirs précieux s'échapper de ton esprit, ton cerveau devient flou, comme s'il allait fondre. \n Tu trembles douloureusement, essayant de retenir ta main qui veut s'arrêter. \n Des larmes cristallines coulent de tes yeux, mais pourquoi coulent-elles ? \n Tu sembles avoir du mal à te souvenir. \n Une profonde tristesse t'envahit sans raison."
  },
  Event_59600_Name = {
    Text = "Dissociation de la mémoire"
  },
  Event_59601_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59601_Desc = {
    Text = "Ton amitié avec le chat est indéniable. Tu as salué et continué sans te retourner.\n\"Idiot ! Idiot !\"\nLa voix à ton oreille était furieuse"
  },
  Event_59601_Name = {
    Text = "Murmure secret"
  },
  Event_59602_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59602_Desc = {
    Text = "Tu as décidé que, peu importe le prix à payer, tu te battras pour l'espoir de tous jusqu'à la dernière minute"
  },
  Event_59602_Name = {
    Text = "Avenir figé"
  },
  Event_59603_ChoiceDesc1 = {
    Text = "[tempérer] obtenez une relique d'argent [(RelicConfig.Arg1)]"
  },
  Event_59603_ChoiceDesc2 = {
    Text = "[Gaze] Obtenir la Relique d'Or \"(RelicConfig.Arg1)\", infecter \"(Skill.Arg2)\""
  },
  Event_59603_Desc = {
    Text = "Derrière la porte gardée par Tawil se trouve un monde infini et une vérité infinie.  \nTu ne sais pas ce qu'elle a vu derrière la porte, mais tu sais qu'elle sait tout.  \nMaintenant cette porte s'ouvre devant toi, toutes les vérités invitent silencieusement derrière le battant"
  },
  Event_59603_Name = {
    Text = "Derrière la porte"
  },
  Event_59604_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59604_Desc = {
    Text = "Il faut respecter les existences inconnues, éviter leur éclat est un choix prudent. \n Tu baisses la tête, serres la clé d'argent contre ta poitrine, te sentant légèrement réconforté. \n Au moins, tu as encore de la force, et des Éveilleurs. \n Tu t'efforces d'ignorer ces regards, te concentrant sur le chemin devant toi. \n Mais ces regards ont-ils vraiment disparu ? Tu le sais très bien."
  },
  Event_59604_Name = {Text = "Son regard"},
  Event_59605_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59605_Desc = {
    Text = "Si toutes les méthodes pour défier les dieux sont vaines, ton seul recours est le courage de ne jamais abandonner.\nQuand la destruction infinie s'abattra du ciel, tu seras celui qui se tiendra en première ligne"
  },
  Event_59605_Name = {
    Text = "Ma réponse"
  },
  Event_59606_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59606_Desc = {
    Text = "Tu as touché les larmes qui coulaient, repensant à cette tristesse inconnue.\nComme si tu avais perdu quelque chose de précieux, mais tu ne te souvenais plus quoi.\nQuel dommage.\nEssuyant tes larmes, tu as esquissé un sourire amer"
  },
  Event_59606_Name = {
    Text = "Dissociation de la mémoire"
  },
  Event_59607_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59607_Desc = {
    Text = "Tu ignores leurs voix.\nTu te fiches que le chat soit un menteur, tu ne crois qu'en ta propre force.\nLes voix à ton oreille soupirent"
  },
  Event_59607_Name = {
    Text = "Murmure secret"
  },
  Event_59608_ChoiceDesc1 = {
    Text = "[Chercher des réponses] Obtenez Arg1 le sigil noir, infection[(Skill.Arg2)], continuez à choisir"
  },
  Event_59608_ChoiceDesc2 = {
    Text = "[Abandonner] Quitter"
  },
  Event_59608_Desc = {
    Text = "Quelqu'un rit de manière folle. \n Cette partie de toi qui considère que tout est une lutte inutile préfère abandonner le plus tôt possible. \n Tu fronces les sourcils, cette partie de toi se retourne soudainement avec un sourire, disant qu'il vaudrait mieux mettre fin à la vie de tous de ses propres mains plutôt que de laisser les gens souffrir. \n Tu balayes ce bruit d'un geste de la main, affirmant ta croyance."
  },
  Event_59608_Name = {
    Text = "Ma réflexion personnelle"
  },
  Event_59609_ChoiceDesc1 = {
    Text = "[Interrogate] Effacez 2 Cartes"
  },
  Event_59609_ChoiceDesc2 = {
    Text = "[Transpercer] Relique Maudite obtenue \"(RelicConfig.Arg1)\", infectée avec \"(Skill.Arg2)\""
  },
  Event_59609_ChoiceDesc3 = {
    Text = "[Leave] Gagner Arg1 sigles noirs"
  },
  Event_59609_Desc = {
    Text = "Dans cette longue attente, tu as de nouveau ouvert le communicateur. Peut-être que ton désir et tes prières ont porté leurs fruits, tu vois des réponses familières et affectueuses jaillir du papier de la lettre de retour. \n Elle est maintenant très en sécurité, les enseignants ont déjà fait des arrangements, tout se passe bien à Mizag... \n En voyant les bonnes nouvelles arriver comme des flocons de neige, ton cœur ne peut s'empêcher de s'émouvoir."
  },
  Event_59609_Name = {
    Text = "Écho hallucinatoire"
  },
  Event_59610_ChoiceDesc1 = {
    Text = "[Capturer les étoiles] Améliorez une relique d'argent en une relique en or[(RelicConfig.Arg1)]"
  },
  Event_59610_ChoiceDesc2 = {
    Text = "[Crush the Stars] Gagner la Relique d'Or \"(RelicConfig.Arg1)\", Infection \"(Skill.Arg2)\", et \"(Skill.Arg3)\""
  },
  Event_59610_ChoiceDesc3 = {
    Text = "[Silent Watch] Obtient 25 Sigils Noirs"
  },
  Event_59610_Desc = {
    Text = "Tes émotions sont dépouillées avec les souvenirs, tu sens que tu deviens une sorte d'existence massive, comme un monstre revenant dans son ancien et chaleureux nid. \n Innombrables joies, colères, tristesses et plaisirs se condensent en étoiles brillantes, et il commence à pleuvoir de la lumière sous ta dimension spirituelle. \n Les traces de ta survie se transforment en météores et disparaissent. \n Tu regardes en silence, ramassant une étoile devant toi, où résonne ton rire joyeux. \n Alors tu ris aussi, avec plaisir."
  },
  Event_59610_Name = {
    Text = "Cristal émotionnel"
  },
  Event_59611_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59611_Desc = {
    Text = "Tu sais que ce ne sont que des ombres du passé, tu massacres sans expression ceux qui te parlaient autrefois.\nLeurs rires et leurs larmes se brisent dans tes mains, tu ne peux pas t'arrêter.\nSi c'est une épreuve nécessaire, tu seras le bourreau le plus impitoyable"
  },
  Event_59611_Name = {
    Text = "Ombres du passé"
  },
  Event_59612_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59612_Desc = {
    Text = [[
Sa fourrure douce et ses yeux clairs vous inspirent confiance.
Vous approchez du chat, et le chat s'approche de vous.
Sans un mot, sa queue se dresse haut]]
  },
  Event_59612_Name = {
    Text = "La tentation du chat"
  },
  Event_59613_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59613_Desc = {
    Text = "Vous réprimez l'envie de curiosité, vous savez que cette porte ne devrait pas s’ouvrir.  \nTrop de réalité est parfois une malédiction.  \nVous serrez la clé en argent contre votre cœur, déterminé à garder cette porte fermée pour toujours"
  },
  Event_59613_Name = {
    Text = "Derrière la porte"
  },
  Event_59614_ChoiceDesc1 = {
    Text = "[Courage] Améliorez aléatoirement les effets d'oraison de 2 cartes."
  },
  Event_59614_ChoiceDesc2 = {
    Text = "[détermination] choisissez une carte parmi 3 cartes de commandement et obtenez l'oraison : [(EnchantConfig.Arg1)]"
  },
  Event_59614_Desc = {
    Text = "Les paroles de Tawil résonnent dans ton esprit.\nParmi d'innombrables fins, une seule est le bon chemin.\nDans un état d'égarement, tu vois de nombreuses ombres de mondes passer devant tes yeux, comme des fragments de pellicule, attendant le moment où le bouton sera pressé pour les figer.\nAprès cette seconde, quelle conclusion le monde connaîtra-t-il ?"
  },
  Event_59614_Name = {
    Text = "Avenir figé"
  },
  Event_59615_ChoiceDesc1 = {
    Text = "[Ignorez la suspicion] Gagnez 50 Sigils Noirs"
  },
  Event_59615_ChoiceDesc2 = {
    Text = "[Arbitraire] Obtenez 75 sigils noirs, infectez [(Skill.Arg2)]"
  },
  Event_59615_Desc = {
    Text = "Avec les moqueries de N, vous commencez à douter de tout le monde.\nQui est vraiment lui, et qui sont vos vrais amis ?\nSon ombre change constamment, révélant d'innombrables visages qui vous sourient"
  },
  Event_59615_Name = {
    Text = "Les cent visages de l'ombre"
  },
  Event_59616_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59616_Desc = {
    Text = "Si tout le monde est capable de trahir, alors ne comptez sur personne.\nDans l'obscurité, vous ne pouvez confirmer qu'une seule réalité.\nAu moins, vous avez vous-même — votre soi le plus fidèle sur lequel compter"
  },
  Event_59616_Name = {
    Text = "Les cent visages de l'ombre"
  },
  Event_59617_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59617_Desc = {
    Text = "Tu squeezes fortement, la pierre brillante se brise en poudre sous tes doigts. \n Tu inspires avidement ces émotions venues du passé. \n En un instant, une intense joie envahit ton esprit, puis se dissipe lentement comme une illusion. \n Tes lèvres se lèvent alors, puis retombent lentement. \n Ton visage devient progressivement calme et serein."
  },
  Event_59617_Name = {
    Text = "Cristal émotionnel"
  },
  Event_59618_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59618_Desc = {
    Text = "Tu sais que tout a un prix, et si le prix du salut est le sacrifice, alors tu es prêt à tout payer toi-même.\nTu es prêt à tout donner"
  },
  Event_59618_Name = {
    Text = "Ma réponse"
  },
  Event_59619_ChoiceDesc1 = {
    Text = "[Chercher des réponses] Obtenez Arg1 le sigil noir, infection[(Skill.Arg2)], continuez à choisir"
  },
  Event_59619_ChoiceDesc2 = {
    Text = "[Abandonner] Quitter"
  },
  Event_59619_Desc = {
    Text = ": Quelqu'un crie.\nCette partie de toi veut fuir, disant que résister est futile.\nSeule une fuite éternelle peut retarder l'inévitable.\nTu es sceptique"
  },
  Event_59619_Name = {
    Text = "Ma réflexion personnelle"
  },
  Event_59620_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59620_Desc = {
    Text = "Tu sais à quel point la vitesse de reproduction des embryons est terrifiante, et ici, le nouveau-né est une malédiction semblable à celle des sauterelles. \n Tu les écrases avant même que ces nouveau-nés ne commencent à pleurer. \n Les gens faits de chair te regardent avec rancœur, te questionnant sur la raison pour laquelle tu profanes la vie sacrée. \n Tu réponds par un massacre sans fin."
  },
  Event_59620_Name = {
    Text = "Ombres du passé"
  },
  Event_59621_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59621_Desc = {
    Text = "En ce moment, vous espérez être la personne la plus chanceuse, obtenir la fin la plus parfaite.\nMais le prix de la chance peut être cruel, la chance et la malchance vont souvent de pair. Quand vous obtenez quelque chose, n'oubliez pas de vérifier ce que vous avez perdu"
  },
  Event_59621_Name = {
    Text = "Choix du destin"
  },
  Event_59622_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59622_Desc = {
    Text = "Vous vous battez pour le contrôle du volant, vos mains s'agitent pour maîtriser le rythme.\nDans cette lutte, vous appuyez soudainement sur une rangée de touches.\nLa mélodie chaotique est interrompue, vous souriez, plongé dans une lutte de folie"
  },
  Event_59622_Name = {
    Text = "Chanson de la fête de l'Apocalypse"
  },
  Event_59623_ChoiceDesc1 = {
    Text = "[Approach] Gagnez 25 Sigils Noirs"
  },
  Event_59623_ChoiceDesc2 = {
    Text = "[Regarde] 50 % de chances de gagner 50 sigils noirs, 50 % de chances d'obtenir rien"
  },
  Event_59623_Desc = {
    Text = "Un chat te suit, son pelage est lisse et propre, ses pattes avant sont blanches comme la neige.\nLe chat reste toujours à tes côtés, comme un fidèle serviteur.\nToutes tes incertitudes, douleurs et angoisses sont apaisées"
  },
  Event_59623_Name = {
    Text = "La tentation du chat"
  },
  Event_59624_ChoiceDesc1 = {
    Text = "[Denial] Infecté avec \"(Skill.Arg1)\", gagner la relique maudite \"(RelicConfig.Arg2)\""
  },
  Event_59624_ChoiceDesc2 = {
    Text = "[Retort] Infecté deux fois par \"(Skill.Arg1)\", gagnez une Relique d'Argent \"(RelicConfig.Arg2)\" et \"(RelicConfig.Arg3)\""
  },
  Event_59624_ChoiceDesc3 = {
    Text = "[Silence] obtenir une relique d'argent [(RelicConfig.Arg1)]"
  },
  Event_59624_Desc = {
    Text = "Tu es plongé dans une sorte d'illusion vide. \nTu vois d'innombrables personnes silencieuses sous l'ombre de la fin du monde, aussi insignifiantes que de la poussière. \nElles sont figées, grises, dépourvues d'espoir. \nTu entends le rire perçant de quelqu'un. \n« Regardez, voici le résultat de votre persistance. » \n« Le monde n'a jamais de fin, tout n'a aucun sens. »"
  },
  Event_59624_Name = {
    Text = "Agneau en attente de la mort"
  },
  Event_59625_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59625_Desc = {
    Text = "Non, ce n'est pas vrai, ce n'est pas réel.\nTu n'arrêtes pas de nier cette voix folle, mais l'ombre grisâtre reste impassible, comme pour valider l'issue illusoire.\nLe rire s'intensifie, se moquant de ta faiblesse"
  },
  Event_59625_Name = {
    Text = "Agneau en attente de la mort"
  },
  Event_59626_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59626_Desc = {
    Text = "Tu ressens un immense regret et une profonde tristesse, tu te remémores désespérément, cherchant des fragments du passé.\nLes souvenirs flous reculent rapidement, tu essaies de les attraper, mais ils glissent entre tes doigts.\nTu réalises que tu vas tout perdre"
  },
  Event_59626_Name = {
    Text = "Dissociation de la mémoire"
  },
  Event_59627_ChoiceDesc1 = {
    Text = "[Approach] Gagnez 25 Sigils Noirs"
  },
  Event_59627_ChoiceDesc2 = {
    Text = "[Regarde] 50 % de chances de gagner 50 sigils noirs, 50 % de chances d'obtenir rien"
  },
  Event_59627_Desc = {
    Text = "Un chat te suit, son pelage est lisse et propre, ses pattes avant sont blanches comme la neige.\nLe chat reste toujours à tes côtés, comme un fidèle serviteur.\nToutes tes incertitudes, douleurs et angoisses sont apaisées"
  },
  Event_59627_Name = {
    Text = "La tentation du chat"
  },
  Event_59628_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59628_Desc = {
    Text = "Vous rencontrez votre version ultime ici, la bataille pour détruire le monde entier est en réalité juste un échange de regards entre vous deux.\nLorsque Il vous regarde, vous devez soutenir son regard, jusqu'à ce qu'un de ces regards disparaisse"
  },
  Event_59628_Name = {
    Text = "Ma réponse"
  },
  Event_59629_ChoiceDesc1 = {
    Text = "[Breath] Obtenir une Relique en argent \"(RelicConfig.Arg1)\" et infecter \"(Skill.Arg2)\"."
  },
  Event_59629_ChoiceDesc2 = {
    Text = "[Counter] Obtenir une relique d'or \"(RelicConfig.Arg1)\" et infecter avec \"(Skill.Arg2)\", \"(Skill.Arg3)\""
  },
  Event_59629_ChoiceDesc3 = {
    Text = "[Struggle] Gagner 25 Sigils Noirs"
  },
  Event_59629_Desc = {
    Text = "Des pas pressés se font entendre, un groupe d'agents du Comité te bloque le chemin.\n\"Veuillez coopérer à notre enquête.\"\nUne voix froide et malveillante.\nUn plouf, la surface calme de l'eau est brisée, ils te jettent dans un bassin profond"
  },
  Event_59629_Name = {
    Text = "S'enfoncer dans les abysses"
  },
  Event_59630_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59630_Desc = {
    Text = "Tu luttes désespérément.\nEn avant, encore un peu.\nPeu importe le prix, tu dois protéger tout cela.\nTu tends la main, les fils coupent ta chair, tu ne ressens rien"
  },
  Event_59630_Name = {
    Text = "Mains Manipulées"
  },
  Event_59631_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59631_Desc = {
    Text = "Tu secoues la tête pour chasser les souvenirs confus.\nLes bruits disparaissent peu à peu, et ta conscience revient.\nTu ne peux pas tirer de leçons du passé, concentre-toi sur le présent pour trouver l'espoir"
  },
  Event_59631_Name = {
    Text = "Ma réflexion personnelle"
  },
  Event_59632_ChoiceDesc1 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_59632_Desc = {
    Text = "Avant de tendre la main, vous vous souvenez soudain que vous n'avez jamais eu un tel chat.\nVous et le chat vous regardez à travers l'air, le chat cligne des yeux.\nLe chat ne se soucie pas de votre indifférence, il semble toujours vous aimer"
  },
  Event_59632_Name = {
    Text = "La tentation du chat"
  },
  Event_59633_ChoiceDesc1 = {
    Text = "[Chercher des réponses] Obtenez Arg1 le sigil noir, infection[(Skill.Arg2)]"
  },
  Event_59633_ChoiceDesc2 = {
    Text = "[Abandonner] Quitter"
  },
  Event_59633_Desc = {
    Text = ": Quelqu'un pleure.\nCette partie de toi est pleine de tristesse, voulant embrasser ses proches.\nNe pas être avec eux lors de la destruction est son plus grand regret.\nTon cœur se serre, tu ne peux t'empêcher de partager cette tristesse"
  },
  Event_59633_Name = {
    Text = "Ma réflexion personnelle"
  },
  Event_59634_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59634_Desc = {
    Text = "Tu ignores les ombres grises et les rires moqueurs.\nComment sauver un monde en ruine ?\nTu réfléchis sans cesse dans ce silence mortel"
  },
  Event_59634_Name = {
    Text = "Agneau en attente de la mort"
  },
  Event_59635_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59635_Desc = {
    Text = "L'air dans les alvéoles disparaît progressivement, vous essayez de respirer sous l'eau.\nQuelle idée stupide, mais vous y parvenez.\nVos alvéoles se remplissent à nouveau, vous pouvez respirer librement.\nMais qu'inhalez-vous vraiment ?"
  },
  Event_59635_Name = {
    Text = "S'enfoncer dans les abysses"
  },
  Event_59636_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59636_Desc = {
    Text = "Tu t'enfonces dans un liquide visqueux.\nMalgré tes efforts, tu t'enfonces de plus en plus.\nTu ne peux pas t'échapper seul de ce marécage"
  },
  Event_59636_Name = {
    Text = "S'enfoncer dans les abysses"
  },
  Event_59637_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59637_Desc = {
    Text = "Tu te forces à oublier ces doutes.\nTu sais que douter maintenant est inutile, tu dois croire.\nAvant d'ouvrir la boîte scellée, tu ne connaîtras pas la vérité.\nParfois, être un idiot ignorant apporte plus de paix"
  },
  Event_59637_Name = {
    Text = "Les cent visages de l'ombre"
  },
  Event_59638_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59638_Desc = {
    Text = "Tous les regards se tournent vers vous, vous devez être le leader de tous, sans montrer la moindre faiblesse.  \n« Allons à la piscine noire, tout ira bien. »  \nVous émettez calmement des ordres, promettant quelque chose que vous ne croyez pas vous-même"
  },
  Event_59638_Name = {
    Text = "Œil de l'ignorance"
  },
  Event_59639_ChoiceDesc1 = {
    Text = "[Suspect] Infectez \"(Skill.Arg1)\", obtenez une Reliquaire Maudite \"(RelicConfig.Arg2)\""
  },
  Event_59639_ChoiceDesc2 = {
    Text = "[Disdain] Infligez \"(Skill.Arg1)\" deux fois, gagnez Relique d'argent \"(RelicConfig.Arg2)\" et \"(RelicConfig.Arg3)\""
  },
  Event_59639_ChoiceDesc3 = {
    Text = "[Ignorer] Gagne une relique d'argent [(RelicConfig.Arg1)]"
  },
  Event_59639_Desc = {
    Text = "Devant toi, trois silhouettes hésitantes murmurent quelque chose.\nTu tends l'oreille pour écouter, les mots et les souffles deviennent clairs.\n\"Ne fais pas confiance à ce chat, c'est un menteur.\"\nTu te retournes brusquement, mais il n'y a personne à côté de toi"
  },
  Event_59639_Name = {
    Text = "Murmure secret"
  },
  Event_59640_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59640_Desc = {
    Text = "Les étoiles semblent si appétissantes, vous convoitez leur pouvoir et les avalez d'un coup.\nGloups.\nVous vous sentez mentalement plus fort que jamais, une lumière brille dans votre vision périphérique.\nEn baissant les yeux, les étoiles brillent toujours dans votre estomac"
  },
  Event_59640_Name = {
    Text = "Étoile des Vœux"
  },
  Event_59641_ChoiceDesc1 = {
    Text = "[Struggle Forward] Supprimer 1 carte de commande, gagner Arg1 Sigil Noir"
  },
  Event_59641_ChoiceDesc2 = {
    Text = "[Casser le fil] Copiez 1 carte de commandement et infectez[(Skill.Arg1)]"
  },
  Event_59641_ChoiceDesc3 = {
    Text = "[Retenue] choisissez une carte parmi 3 cartes de commandement pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_59641_Desc = {
    Text = "Tu es poussé en avant, tous tes choix étant manipulés par des fils invisibles.  \nTu luttés pour bouger tes mains, désireux d'attraper tout ce qui t'importe.  \nLe destin du monde pend devant tes doigts.  \nDes fils innombrables s'enroulent autour de toi, te liant entièrement"
  },
  Event_59641_Name = {
    Text = "Mains Manipulées"
  },
  Event_59642_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59642_Desc = {
    Text = "Tu essuies le sang et les larmes de tes yeux, mais ils continuent de couler.\nLe rouge envahit ta vision, présageant un sacrifice sanglant.\nTu continues d'essuyer, tremblant de douleur, mais sans peur"
  },
  Event_59642_Name = {Text = "Ma fusion"},
  Event_59643_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59643_Desc = {
    Text = "Tu caresses cette pierre magique et l'insères dans la clé en argent.\nLa lumière des étoiles brille sur toi.\nTu es ébloui"
  },
  Event_59643_Name = {
    Text = "Étoile des Vœux"
  },
  Event_59644_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59644_Desc = {
    Text = "Tu t'en fiches, tu gardes les yeux ouverts, ta détermination se transforme en un cri obstiné.\nMême si tu te brises, tu ne reculeras pas"
  },
  Event_59644_Name = {Text = "Ma fusion"},
  Event_59645_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59645_Desc = {
    Text = ": Quelqu'un reste silencieux.\nEn voyant ce visage désespéré, tu sais qu'ils n'ont pas réussi.\nTu es celui qui est allé le plus loin, ta réponse est le dernier espoir"
  },
  Event_59645_Name = {
    Text = "Ma réflexion personnelle"
  },
  Event_59646_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59646_Desc = {
    Text = "Tu tends la main, attrapant sans cesse parmi d'innombrables météores, les cristaux brillants glissent sur tes doigts. \n Joie, tristesse, colère, peur... \n Tu saisis avidement chaque émotion, regardant impuissant comme elles disparaissent de tes mains. \n Une lumière éclatante illumine ton visage, tes pupilles deviennent progressivement noires et profondes."
  },
  Event_59646_Name = {
    Text = "Cristal émotionnel"
  },
  Event_59657_ChoiceDesc1 = {
    Text = "[appelle] obtient une relique d'argent[(RelicConfig.Arg1)]"
  },
  Event_59657_ChoiceDesc2 = {
    Text = "[Touch] Obtenez la Relique d'Or \"(RelicConfig.Arg1)\", infectez \"(Skill.Arg2)\""
  },
  Event_59657_Desc = {
    Text = "Tu vois la poupée sombrer dans la crise.\nElle était la plus rationnelle et la plus fidèle assistante, gardant soigneusement toutes vos informations.\nMais maintenant, elle semble avoir oublié tout ce que vous avez partagé.\nTu vois des larmes scintillantes couler de ses yeux"
  },
  Event_59657_Name = {
    Text = "Larmes de la poupée"
  },
  Event_59658_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59658_Desc = {
    Text = "Tu ne perds pas espoir et essaies de toucher son cœur énergétique. \n Tant que c'est mécanique, un redémarrage devrait pouvoir réparer, n'est-ce pas ? \n Malheureusement, la poupée impitoyable ne t'a pas donné cette chance naïve. \n Ta retenue n'a pas conduit à la clémence de la poupée, tu n'as d'autre choix que de te battre de toutes tes forces."
  },
  Event_59658_Name = {
    Text = "Larmes de la poupée"
  },
  Event_59659_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59659_Desc = {
    Text = "Tu ne veux pas détruire tes anciens camarades. \nTu cries désespérément son nom, lançant tous les ordres, mais cela ne sert à rien. \nLa poupée vous a trahis et est revenue au froid de l'inorganique"
  },
  Event_59659_Name = {
    Text = "Larmes de la poupée"
  },
  Event_60944_ChoiceDesc1 = {Text = "[Leave]"},
  Event_60944_Desc = {
    Text = "Il ne te reste plus beaucoup de temps, tu as choisi la manière la plus directe de passer le blocus. Les éveillés sont motivés et excités.\nQuant aux ennemis devenus plus vigilants, ils ne sont pas une menace"
  },
  Event_60944_Name = {
    Text = "Agent de l'Audience de révision"
  },
  Event_60945_ChoiceDesc1 = {Text = "[Leave]"},
  Event_60945_Desc = {
    Text = "Avant que l'agent ne réagisse, vous l'avez contourné et désarmé. Avant l'arrivée des renforts, vous avez réussi à partir.\nMalheureusement, l'information s'est répandue, les prochains ennemis seront mieux préparés, peut-être plus difficiles à affronter. Préparez-vous"
  },
  Event_60945_Name = {
    Text = "Agent de l'Audience de révision"
  },
  Event_60946_ChoiceDesc1 = {Text = "[Leave]"},
  Event_60946_Desc = {
    Text = "L'agent, attiré par un sifflement, se dirige vers votre cachette. Au moment où il s'approche, les éveillés attaquent ensemble.\nUne embuscade parfaite, la crise est définitivement résolue"
  },
  Event_60946_Name = {
    Text = "Agent de l'Audience de révision"
  },
  Event_60947_ChoiceDesc1 = {Text = "[Leave]"},
  Event_60947_Desc = {
    Text = "Face à de nombreux ennemis, vous ne pouvez pas les affronter. Vous entrez volontairement dans leur champ de vision sans résister.\nVous savez que vous serez bientôt envoyés en détention, ce qui fait partie du plan.\nVous vous échapperez de là pour trouver un nouveau chemin"
  },
  Event_60947_Name = {
    Text = "Point de surveillance"
  },
  Event_60948_ChoiceDesc1 = {Text = "[Leave]"},
  Event_60948_Desc = {
    Text = "Face à des ennemis en nombre, tu ne peux pas rivaliser. Après une brève bataille, vous abandonnez la résistance.\nTu sais que vous allez être envoyés au point de détention, c'est une partie du plan.\nVous vous échapperez de là pour trouver un nouveau chemin"
  },
  Event_60948_Name = {
    Text = "Point de surveillance"
  },
  Event_60949_ChoiceDesc1 = {Text = "[Leave]"},
  Event_60949_Desc = {
    Text = "Face à de nombreux ennemis, vous ne pouvez pas les affronter.\nVous choisissez de partir temporairement pour trouver un nouveau chemin"
  },
  Event_60949_Name = {
    Text = "Point de surveillance"
  },
  Event_61058_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61058_Desc = {
    Text = "Tu regardes tes mains, ton corps, rempli d'espoir et de détermination.\nSi tout cela est le destin, tu es prêt à tout affronter.\nSi à la fin il y a une porte vers le paradis ou l'enfer, alors tu l'ouvriras toi-même pour le monde"
  },
  Event_61058_Name = {Text = "Épier"},
  Event_61059_ChoiceDesc1 = {
    Text = "[préparer à combattre] choisissez une carte parmi 3 cartes de commandement et obtenez l'oraison : [(EnchantConfig.Arg1)]"
  },
  Event_61059_ChoiceDesc2 = {
    Text = "[Continuer à observer] infecter «(Skill.Arg1)», réimprimer, au maximum 1 fois"
  },
  Event_61059_Desc = {
    Text = "Tu ne te précipites pas pour affronter, essayant calmement de clarifier la situation. Ce chef d'orchestre qui est apparu soudainement semble à la fois un ennemi et un ami, tu n'es pas sûr de ce qu'il prépare. Quoi qu'il en soit, tu décides de te préparer pleinement, d'abord à relever son défi, puis d'observer lentement ce qu'il veut vraiment faire."
  },
  Event_61059_Name = {
    Text = "Chef d'orchestre du Diable"
  },
  Event_61060_ChoiceDesc1 = {
    Text = "[Écoutez] Obtenez 1 parmi 3 Oraisons Avancées"
  },
  Event_61060_ChoiceDesc2 = {
    Text = "[Shouting] Obtenez la relique d'or \"(RelicConfig.Arg1)\", infectez \"(Skill.Arg2)\""
  },
  Event_61060_ChoiceDesc3 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_61060_Desc = {
    Text = "Depuis l'accident, tu n'as plus reçu de nouvelles de ton partenaire.\nInnombrables tentatives de contact ont été faites, comme une pierre jetée dans la mer sans écho.\nAu moment où tu avais presque perdu tout espoir, le communicateur a soudainement émis un son.\nTu ouvres la mallette et approches le combiné de ton oreille.\n« Gardien du Secret... »\nDans un état d'égarement, tu entends cette voix que tu as tant désirée, résonnant à travers des couches de vide."
  },
  Event_61060_Name = {
    Text = "Échos de la pensée"
  },
  Event_61061_ChoiceDesc1 = {
    Text = "[Embrace Darkness] Obtenez Relique d'argent \"(RelicConfig.Arg1)\", Infectez \"(Skill.Arg2)\""
  },
  Event_61061_ChoiceDesc2 = {
    Text = "[Attempt Swim] Obtenir la Relique en argent \"(RelicConfig.Arg1)\", infecté par \"(Skill.Arg2)\""
  },
  Event_61061_ChoiceDesc3 = {
    Text = "[Call the Spirit] Obtenez 25 Sigils Noirs"
  },
  Event_61061_Desc = {
    Text = "Tu cours en avant, le sol devient soudainement une mer infranchissable.\nTu tombes dans le sol.\nComme des fantômes dans un cimetière, une obscurité visqueuse t'entoure, envahissant avidement ta bouche et ton nez"
  },
  Event_61061_Name = {Text = "Enlisement"},
  Event_61062_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61062_Desc = {
    Text = "Tu écarquilles les yeux, cherchant désespérément tous les indices. \n Une centaine d'yeux se déplacent en même temps, tu vois les griffes d'un visage humain courant devant toi, tu vois la trajectoire de la baguette de Hamelin qui s'agite derrière toi. \n Tu observes tout avec gourmandise. \n Soudain, tu vois un œil familier rouler sur le sol. \n Cela semble être ton propre œil."
  },
  Event_61062_Name = {
    Text = "Gourmandise de Connaissance"
  },
  Event_61063_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61063_Desc = {
    Text = "Non, tu ne peux pas voir autant de choses. \n Tu n'as que... que quelques yeux, n'est-ce pas ? \n Tu fermes rapidement les yeux et tends la main pour explorer ton visage. \n Un, deux... \n Lorsque tu rouvres les yeux, ton champ de vision redevient étroit et ignorant. \n En fait, tu n'as que deux yeux, hélas, hélas."
  },
  Event_61063_Name = {
    Text = "Gourmandise de Connaissance"
  },
  Event_61064_ChoiceDesc1 = {
    Text = "[Search] Obtenez la relique maudite \"(RelicConfig.Arg1)\", infectez \"(Skill.Arg2)\""
  },
  Event_61064_ChoiceDesc2 = {
    Text = "[Fermer les yeux] 1 Carte d'instruction aléatoire obtient l'Oraison : [(EnchantConfig.Arg1)]"
  },
  Event_61064_Desc = {
    Text = "De plus en plus d'indices s'entrelacent en un fouillis désordonné, tu es anxieux, perdu, en colère, tu te détestes de ne rien savoir. \n Une pression énorme tend ton esprit comme un fil fin. \n Soudain, tu sens ton cuir chevelu se détendre, tu peux voir tout ce qui t'entoure, apercevoir les ombres qui vacillent dans le vide. \n Plus, tu as besoin de voir plus..."
  },
  Event_61064_Name = {
    Text = "Gourmandise de Connaissance"
  },
  Event_61065_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61065_Desc = {
    Text = "Tu nages dans le sol, imaginant que tu es le poisson le plus agile. \n Pour devenir un poisson, il faut abandonner les jambes humaines. \n C'est le prix de l'échange. \n Bientôt, tu ressens une légèreté sans précédent, tu deviens l'être le plus libre sous la terre. \n Tu nages vers la surface, mais tu as déjà oublié comment marcher."
  },
  Event_61065_Name = {Text = "Enlisement"},
  Event_61066_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61066_Desc = {
    Text = "Tes doigts touchent la sensation familière de la clé d'argent, c'est le cœur de toute lumière. \n C'est la concentration de ta vie, c'est l'incarnation de ton destin. \n Les expériences passées défilent devant tes yeux. \n Tes choix sont désormais fermement liés à ceux de ce monde. \n Ton destin est déjà étroitement lié à celui de nombreuses personnes."
  },
  Event_61066_Name = {Text = "Épier"},
  Event_61067_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61067_Desc = {
    Text = "Tu te sens entouré de présences familières.\nTu appelles ces fantômes incertains.\nUn miracle se produit, tu reviens à la surface.\nLes innombrables tombes restent silencieuses"
  },
  Event_61067_Name = {Text = "Enlisement"},
  Event_61068_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61068_Desc = {
    Text = "Tu n'as pas le temps de t'émouvoir, tu veux juste sauver ce qui s'effondre le plus vite possible.\nSi tu deviens une étoile, alors que tu sois une étoile filante.\nTant que tu peux éclairer le ciel nocturne, même si tu finiras par tomber"
  },
  Event_61068_Name = {Text = "Épier"},
  Event_61069_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61069_Desc = {
    Text = "Tu presses tes oreilles plus fort, absorbant tous les bruits fragmentés dans ta tête. \n« Je... » \n« Tu dois... » \nTu n'entends que des phrases incomplètes, sans pouvoir discerner le moindre sens. \nMais tu n'oses pas parler, de peur de manquer un seul mot. \nCependant, le destin ne te fait pas plus de miséricorde. \nLe peu de son qui restait disparaît ainsi, et tout autour de toi retombe dans le silence."
  },
  Event_61069_Name = {
    Text = "Échos de la pensée"
  },
  Event_61070_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61070_Desc = {
    Text = "Tu ne réfléchis plus, tu ordonnes aux éveillés de se ranger en ligne pour affronter son défi"
  },
  Event_61070_Name = {
    Text = "Chef d'orchestre du Diable"
  },
  Event_61071_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61071_Desc = {
    Text = "Tu cries sans cesse son nom, essayant de transmettre ne serait-ce qu'un peu de tes sentiments.\nTu ne sais pas si elle a entendu, tu t'efforces de distinguer la voix étouffée dans le microphone.\nC'était comme si c'était sa réponse, mais aussi comme si des fragments innombrables du passé se reproduisaient.\nRépétant les joies et les peines que vous avez vécues ensemble."
  },
  Event_61071_Name = {
    Text = "Échos de la pensée"
  },
  Event_61072_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61072_Desc = {
    Text = "Peut-être que cette obscurité est le véritable monde, qu'est-ce qui ne va pas à l'y rejoindre ?\nTu as complètement accepté les ténèbres, et les ténèbres ne te rejettent plus, tu peux respirer librement.\nLa seconde suivante, tu es de retour à la surface, peut-être que quelque chose est resté à jamais sous terre, mais cela n'a plus d'importance."
  },
  Event_61072_Name = {Text = "Enlisement"},
  Event_61073_ChoiceDesc1 = {
    Text = "[Gaze at Light] Choisir 1 des 3 cartes de commandement pour obtenir une Oraison : \"(EnchantConfig.Arg1)\", infecter \"(Skill.Arg2)\""
  },
  Event_61073_ChoiceDesc2 = {
    Text = "[Toucher la poitrine] Choisissez de réveiller 1 éveillé, infecté par [(Skill.Arg1)]"
  },
  Event_61073_ChoiceDesc3 = {
    Text = "[Keep Running] Gagnez 25 sigils noirs"
  },
  Event_61073_Desc = {
    Text = "Tu es perdu dans tes pensées, ne pouvant que courir de toutes tes forces, sans le temps de réfléchir à grand-chose.\nSoudain, tu sens une vide dans ta poitrine.\nEn baissant les yeux, tu vois une lumière en forme de clé à l'endroit où se trouvait ton cœur.\nCette lumière devient de plus en plus brillante, s'étendant progressivement à tout ton corps.\nTu te vois transformé en une étoile.\nTu comprends soudainement que c'est peut-être ta véritable mission depuis le début."
  },
  Event_61073_Name = {Text = "Épier"},
  Event_61074_ChoiceDesc1 = {
    Text = "[préparer à combattre] choisissez une carte parmi 3 cartes de commandement et obtenez l'oraison : [(EnchantConfig.Arg1)]"
  },
  Event_61074_ChoiceDesc2 = {
    Text = "[Observer attentivement] Infectez[(Skill.Arg1)], réimposez, maximum 2 fois"
  },
  Event_61074_Desc = {
    Text = "« Hé... attends ! Que se passe-t-il... »\n« Répétition. »\nL'homme te regarde sans expression.\n« Maintenir le lien du corps éveillé par la musique est une nouvelle tentative. Assurer le niveau de l'orchestre est essentiel pour garantir la perfection de la performance. »\nSa baguette de direction s'élève clairement et trace une élégante note d'entrée dans l'air.\n« Joue, Gardien. Laisse-moi voir ce que tu peux faire. »"
  },
  Event_61074_Name = {
    Text = "Chef d'orchestre du Diable"
  },
  Event_61075_ChoiceDesc1 = {
    Text = "[préparer à combattre] choisissez une carte parmi 3 cartes de commandement et obtenez l'oraison : [(EnchantConfig.Arg1)]"
  },
  Event_61075_Desc = {
    Text = "Peu importe ses intentions, il t'a sauvé de l'attaque du comité de censure. S'il voulait te nuire, il n'aurait pas eu besoin de t'aider. Tu te calmes et te prépares"
  },
  Event_61075_Name = {
    Text = "Chef d'orchestre du Diable"
  },
  Event_65400_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65400_Desc = {
    Text = "Le contact a transmis la promesse de secours de l'extérieur. En entendant que l'équipe de sauvetage cherche à entrer dans la montagne, tout le monde a retrouvé espoir"
  },
  Event_65400_Name = {
    Text = "Point de contact"
  },
  Event_65401_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65401_Desc = {
    Text = "Aucun membre de l'équipe de recherche n'est sorti de la montagne de neige. Face à la catastrophe, tu choisis toujours toi-même. La vie des gens ordinaires n'a aucune valeur à tes yeux. Tu as abandonné ton humanité et es parvenu en sécurité jusqu'à la fin. \n Les secouristes te regardent avec une expression complexe, mais tu restes impassible et te retournes pour entrer dans la tempête de neige. Peut-être qu'à minuit, dans tes rêves, les âmes de ceux qui ont perdu la vie à cause de ton indifférence se rassembleront autour de ton lit, te regardant en silence."
  },
  Event_65401_Name = {
    Text = "Point d'extraction sécurisé"
  },
  Event_65402_ChoiceDesc1 = {
    Text = "[Crowd Evacuation] Retirez la relique \"Expedition Team\" et obtenez différents niveaux de \"Rescue Medal\" selon le nombre de membres de l'équipe d'expédition."
  },
  Event_65402_Desc = {
    Text = "Tu as conduit en toute sécurité l'Équipe de Recherche au point d'évacuation, l'équipe de secours a pris le relais, et les personnes sauvées se sont effondrées au sol, comme si elles revenaient d'un autre monde. \nCependant, tu sais que la véritable crise est loin d'être résolue, cette immense bête est toujours tapie dans les montagnes, attendant avec une faim insatiable votre retour."
  },
  Event_65402_Name = {
    Text = "Point d'extraction sécurisé"
  },
  Event_65403_ChoiceDesc1 = {
    Text = "[Supply Trade] Gagner 25 sigils noirs, +1 par membre de l'expédition (Arg1)."
  },
  Event_65403_ChoiceDesc2 = {
    Text = "[Rescue Promise] Choisissez d'obtenir 1 oraison. Ajoutez 2 membres d'expédition."
  },
  Event_65403_ChoiceDesc3 = {
    Text = "[Profit d'Abord] Perdre 10 membres d'expédition et choisir de recevoir une Relique en Or+."
  },
  Event_65403_Desc = {
    Text = "Vous luttez contre la neige et le vent, suivant les lumières vacillantes du poste de secours au loin.\n    ○ Enfin, après d'innombrables prières, vous apercevez la cabane porteuse d'espoir"
  },
  Event_65403_Name = {
    Text = "Point de contact"
  },
  Event_65403_Tips3 = {
    Text = "Nombre insuffisant d'expéditionnaires"
  },
  Event_65404_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65404_Desc = {
    Text = "Vous avez obtenu le mot de passe pour le dépôt du bureau de liaison par le biais de l'agent et trouvé des fournitures pour deux jours pour tout le monde. Félicitations, vous ne mourrez pas de faim dans la montagne de neige"
  },
  Event_65404_Name = {
    Text = "Point de contact"
  },
  Event_65415_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_65415_Desc = {
    Text = "La montagne de neige a fini de se nourrir en un instant, deux personnes ont disparu à jamais dans la fente de glace insondable, tandis que vous êtes totalement inconscients"
  },
  Event_65415_Name = {Text = "Illusion"},
  Event_65416_ChoiceDesc1 = {
    Text = "[Leave] Trouver un phare de recherche"
  },
  Event_65416_ChoiceDesc2 = {
    Text = "[Snow Intrusion] Perds 2 membres de l'expédition."
  },
  Event_65416_Desc = {
    Text = "Une violente tempête s'est soudain levée sur la montagne de neige, le sifflement du vent à vos oreilles ressemblait au hurlement d'une bête gigantesque, la neige blanche et brumeuse vous a éblouis en un instant, comme si quelque chose se déplaçait dans l'immense brouillard blanc. \n Vous êtes contraints de vous arrêter, essayant de enfoncer profondément vos jambes dans la neige pour éviter de dévaler la pente."
  },
  Event_65416_Name = {Text = "inconnu"},
  Event_65417_ChoiceDesc1 = {
    Text = "[Silent Evaporation] Perds 2 membres de l'expédition."
  },
  Event_65417_ChoiceDesc2 = {Text = "[Leave]"},
  Event_65417_Desc = {
    Text = "Le ventre de la montagne de neige émet un rugissement grondant, tel un animal affamé poussant un cri de mécontentement, la terre tremble, la couche de glace sous la neige se fissure silencieusement, comme si la montagne de neige ouvrait la bouche. \n Lorsque les tremblements de terre finissent enfin, les gens regardent autour d'eux, et tu te retournes pour vérifier ton équipe."
  },
  Event_65417_Name = {Text = "Illusion"},
  Event_65468_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65468_Desc = {
    Text = "Pour assurer la mobilité de l'équipe, tu as abandonné ceux qui avaient du mal à se déplacer, les laissant dans cette cabane isolée. Cela pourrait augmenter les chances de survie des autres, mais en voyant leurs regards de ressentiment, ton cœur reste-t-il impassible ?"
  },
  Event_65468_Name = {
    Text = "Point de contact"
  },
  Event_65483_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65483_Desc = {
    Text = "Tu as sauvé quelques personnes, mais beaucoup d'autres resteront à jamais sur la montagne de neige. Quoi qu'il en soit, tu as au moins fait de ton mieux. \n Les secouristes annoncent que ta contribution sera honorée, tu fais un signe de la main et retournes dans la tempête de neige."
  },
  Event_65483_Name = {
    Text = "Point d'extraction sécurisé"
  },
  Event_65484_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65484_Desc = {
    Text = "Tu n'as pas le temps de t'occuper des autres. Pour sortir de la montagne de neige, tu as choisi la méthode la plus efficace. Aux yeux des derniers survivants, tu es peut-être apparu comme un démon. \n Les secouristes annoncent que ta contribution sera honorée, tu fais un signe de la main et retournes dans la tempête de neige."
  },
  Event_65484_Name = {
    Text = "Point d'extraction sécurisé"
  },
  Event_65485_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65485_Desc = {
    Text = "Sous ta protection sans réserve, aucun membre de l'équipe de recherche n'a été blessé. Te rencontrer a été leur plus grande chance dans cette malchance, tu es leur véritable sauveur.\n Tu as accompli un miracle au milieu du désastre, et les rumeurs sur l'héroïsme dans la neige vont probablement se répandre rapidement. Les secouristes annoncent avec sérieux que ta contribution exceptionnelle sera honorée, tu souris et fais un signe de la main avant de retourner dans la tempête de neige."
  },
  Event_65485_Name = {
    Text = "Point d'extraction sécurisé"
  },
  Event_65486_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65486_Desc = {
    Text = "Tu tiens vraiment à la vie des gens, tu en as sauvé beaucoup. Les gens pleurent de gratitude pour ta protection.\nLes secouristes annoncent que ta contribution sera honorée, tu souris et fais un signe de la main avant de retourner dans la tempête de neige"
  },
  Event_65486_Name = {
    Text = "Point d'extraction sécurisé"
  },
  Event_65487_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65487_Desc = {
    Text = "Tu as lutté contre les catastrophes imprévisibles et as sauvé des vies des griffes de la mort. Grâce à tes efforts, le tragique dénouement a légèrement changé. \n Les secouristes annoncent que ta précieuse contribution sera honorée, tu souris et fais un signe de la main avant de retourner dans la tempête de neige."
  },
  Event_65487_Name = {
    Text = "Point d'extraction sécurisé"
  },
  Event_6817_ChoiceDesc1 = {
    Text = "[Stop Here] Gagnez une oraison à 3 choix"
  },
  Event_6817_ChoiceDesc2 = {
    Text = "[Continuer la lecture] 1 Carte d'instruction aléatoire obtient l'Oraison : «(EnchantConfig.Arg1)», infectée par «(Skill.Arg2)»"
  },
  Event_6817_Desc = {
    Text = "Tout en haut de l'étagère en bois, un livre à la couverture dorée est posé. Du point de vue du sol, le titre du livre est invisible. \n Pour une raison inconnue, tu ressens le désir de le lire... Ce désir s'intensifie en un instant, devenant incontrôlable. Ignorant le risque de déranger les autres, tu gravis l'échelle en bois à côté de l'étagère, prends le livre et te mets à le lire avec impatience... \n Une impression floue émerge dans l'océan de ta pensée, te plongeant dans l'océan des illusions..."
  },
  Event_6817_Name = {
    Text = "Parchemin jaune"
  },
  Event_6818_ChoiceDesc1 = {
    Text = "[Écouter] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_6818_ChoiceDesc2 = {
    Text = "[Ensemble] Gagnez 15 Sigils Noirs pour chaque Éveilleur avec un Aliemus de 50 ou plus."
  },
  Event_6818_ChoiceDesc3 = {
    Text = "[Leave] Obtenir 1 parmi 3 Oraisons"
  },
  Event_6818_Desc = {
    Text = "La musique de piano te surprend. Des doigts verts dansent sur les touches, une mélodie élégante coule comme un ruisseau.\n\"Mon cher ami, veux-tu jouer avec moi ?\"\nLes mains ne parlent pas, elles te posent la question par la musique"
  },
  Event_6818_Name = {
    Text = "Fantôme au bord du piano"
  },
  Event_6819_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6819_Desc = {
    Text = "Ramona s'est tournée vers la source de la voix, mais elle ne pouvait que voir une illusion qui se dissipait lentement, ressemblant à un phonographe fondu dans le mur"
  },
  Event_6819_Name = {
    Text = "L'oreille d'autrui"
  },
  Event_6820_ChoiceDesc1 = {
    Text = "[Clean the Typewriter] Delete 1 Command Card, Gain 25 Black Sigils"
  },
  Event_6820_ChoiceDesc2 = {
    Text = "[Essayer de déchiffrer] Copiez une carte du deck, infectez [(Skill.Arg1)]"
  },
  Event_6820_Desc = {
    Text = "La machine à écrire dans la valise éclate soudainement d'encre épaisse, éclaboussant en cascade avec les secousses du train"
  },
  Event_6820_Name = {
    Text = "Le murmure de la machine à écrire"
  },
  Event_6821_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6821_Desc = {
    Text = ": Au moment où le poing dissipa le fantasme, les souvenirs ont brusquement envahi ton esprit, rappelant des scènes qui frappaient ton âme, causant une douleur sourde"
  },
  Event_6821_Name = {Text = "Mirage"},
  Event_6822_ChoiceDesc1 = {
    Text = "[Discard the Letter Paper] Retirez 1 Carte"
  },
  Event_6822_ChoiceDesc2 = {
    Text = "[Keep Close] Obtenir \"(RelicConfig.Arg1)\", infecter \"(Skill.Arg2)\""
  },
  Event_6822_Desc = {
    Text = "Tu retires quelques feuilles de papier de la machine à écrire, l'odeur d'encre est forte. En lisant le contenu, tu fronces les sourcils.\nLa plupart des mots sont effacés, les restants sont illisibles"
  },
  Event_6822_Name = {
    Text = "Lettre brouillée"
  },
  Event_6823_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6823_Desc = {
    Text = "Tu t'efforces de déchiffrer l'écriture floue sur le papier. Elles se tordent sans cesse, puis révèlent un contenu complètement différent. \n « @2 Je pense que tu as dû voir cette nouvelle dans le journal. \n Oui, ton père t'a déjà exclu de la succession... Nous ne voulons pas non plus @2 \n Diable, diable... \n Veuillez cesser immédiatement vos relations avec ce Monsieur Herbert, sinon je mettrai fin à mon aide financière... »"
  },
  Event_6823_Name = {
    Text = "Comme si nous étions face à face"
  },
  Event_6824_ChoiceDesc1 = {
    Text = "[Hold Silver Key] Choisissez 1 parmi 3 cartes de commande pour gagner une Oraison : \"(EnchantConfig.Arg1)\", et infectez \"(Skill.Arg2)\"."
  },
  Event_6824_ChoiceDesc2 = {
    Text = "[Fermer les yeux] Choisissez de réveiller 1 éveillé, infectez[(Skill.Arg1)]"
  },
  Event_6824_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_6824_Desc = {
    Text = "Tu es déchiré par une absurdité gigantesque, tes membres se tordent en rampant sur le sol, comme si tu étais manipulé par un @2 venant d'une dimension extérieure. \n«Non... Non... »\nTa raison s'effondre peu à peu, un rire fou et des cris confus s'entrelacent, comme un grand filet qui entrave ta conscience, et il ne reste que des gémissements indistincts sur tes lèvres."
  },
  Event_6824_Name = {
    Text = "Œil de contemplation"
  },
  Event_6825_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6825_Desc = {
    Text = "Confiez-le au Gardien des Secrets, on ne sait quel être cela réveillera"
  },
  Event_6825_Name = {
    Text = "Cœur d'argent solitaire"
  },
  Event_6826_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6826_Desc = {
    Text = "Une mélodie triste coule à vos oreilles, remplissant votre esprit et votre âme de douleur et de désespoir. Avant de vous en rendre compte, quelqu'un a les yeux humides"
  },
  Event_6826_Name = {
    Text = "Son Inconnu"
  },
  Event_6827_ChoiceDesc1 = {
    Text = "[Ouvrir la porte de gauche] Obtenez une relique d'argent[(RelicConfig.Arg1)]"
  },
  Event_6827_ChoiceDesc2 = {
    Text = "[Ouvrir la bonne porte] Obtenez une Relique en or \"(RelicConfig.Arg1)\", infectez \"(Skill.Arg2)\""
  },
  Event_6827_Desc = {
    Text = "Porte. Porte. D'innombrables portes. \n Le nombre de portes semble avoir augmenté depuis votre inspection avec Ramona. \n Vous vous arrêtez dans le couloir, prêts à pousser la prochaine porte. \n La porte à gauche est silencieuse, attendant votre arrivée avec une retenue implicite. \n Derrière la porte à droite, on entend des voix de conversation indistinctes."
  },
  Event_6827_Name = {
    Text = "Porte infinie"
  },
  Event_6828_ChoiceDesc1 = {
    Text = "[Listen Closely] Gagnez une relique en argent \"(RelicConfig.Arg1)\" et infligez \"(Skill.Arg2)\"."
  },
  Event_6828_ChoiceDesc2 = {
    Text = "[Plug Ears] Obtenir une Oraison à 3 choix"
  },
  Event_6828_Desc = {
    Text = "Vous n'entendez que le fracas frénétique des touches du piano, qui s'abat sur vous comme une tempête, résonnant comme une météorite frappant le sol, faisant trembler tout l'instrument. \n Les marteaux frappant les cordes grincent, et les pédales sautillantes émettent des gémissements lourds. \n Dans cette musique trompeuse, une mélodie familière est entraînée, frottant contre votre tympan."
  },
  Event_6828_Name = {
    Text = "Voix interdite"
  },
  Event_6829_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6829_Desc = {
    Text = "\"L'Enquêteur William a fourni une livraison d'inventaire d'urgence ; appuyez trois fois sur votre broche après réception pour confirmation.\""
  },
  Event_6829_Name = {
    Text = "Soutien de communication"
  },
  Event_6830_ChoiceDesc1 = {
    Text = "[Poussez la Porte de Gauche] Obtenir 3 choix d'Oraison"
  },
  Event_6830_ChoiceDesc2 = {
    Text = "[Push the Right Door] Choisissez 1 des 3 cartes de commande pour obtenir une oraison : \"(EnchantConfig.Arg1)\", et infectez \"(Skill.Arg2)\""
  },
  Event_6830_Desc = {
    Text = "Porte. Porte. D'innombrables portes. \n Le nombre de portes semble être bien plus élevé que lorsque toi et Ramona faisiez votre ronde. \n Vous vous arrêtez dans le couloir, prêts à pousser la prochaine porte. \n La porte à gauche est silencieuse, attendant votre arrivée avec une discrétion contenue. \n De l'autre côté, la porte à droite laisse entendre des voix de conversation indistinctes."
  },
  Event_6830_Name = {
    Text = "Porte sans fin"
  },
  Event_6831_ChoiceDesc1 = {
    Text = "[Lire la Lettre] Retirer 1 carte de commande, gagner Arg1 sigils noirs"
  },
  Event_6831_ChoiceDesc2 = {
    Text = "[Close the Box]"
  },
  Event_6831_Desc = {
    Text = "La valise tremble sans cesse, comme si une vie en émergeait, prête à éclore.\nTu ouvres la valise involontairement, des lettres s'envolent comme des papillons"
  },
  Event_6831_Name = {
    Text = "Lettre inattendue"
  },
  Event_6832_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6832_Desc = {
    Text = "La sonnerie précipitée vous rend nerveux, vous décrochez le combiné et le posez sur la table. La sonnerie s'interrompt brusquement, ne laissant qu'un écho dans votre esprit"
  },
  Event_6832_Name = {
    Text = "Train en approche"
  },
  Event_6833_ChoiceDesc1 = {
    Text = "[Ramasser la photo] Choisissez 1 carte de commandement parmi 3 pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_6833_ChoiceDesc2 = {
    Text = "[Vérifier le film] infecter [(Skill.Arg1)], remplacer l'oraison obtenue dans l'option 1, utilisable deux fois"
  },
  Event_6833_Desc = {
    Text = "Un vieil appareil photo, quelques rouleaux de film et des photos éparpillées se trouvent dans un coin de l'atelier. Ils rendent fidèlement compte du travail et de l'esthétique du sculpteur de cire"
  },
  Event_6833_Name = {
    Text = "enregistrer fidèlement"
  },
  Event_6834_ChoiceDesc1 = {
    Text = "[Continue Questioning] Augmentez la santé maximale de Arg1"
  },
  Event_6834_ChoiceDesc2 = {
    Text = "[Attraper l'ombre] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_6834_Desc = {
    Text = "L'ombre chante dans la poussière dorée :\n\"Ceux qui connaissent la vérité...\nAvec la clé comme leur sceptre, guideront le chemin.\"\nUne ancienne saying.\nVotre intuition vous dit que c'est proche de la vérité que vous recherchez.\nEt votre intuition a toujours raison"
  },
  Event_6834_Name = {
    Text = "Clé d'argent"
  },
  Event_6835_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6835_Desc = {
    Text = "Tu ne caches pas ton accord avec les délires, et sous la tentation de la folie, tu as failli être lié à cette entité"
  },
  Event_6835_Name = {
    Text = "Cérémonie aquatique"
  },
  Event_6836_ChoiceDesc1 = {
    Text = "[appelle le corbeau] obtient 30 le sigil noir, contamine[(Skill.Arg2)], choix supplémentaire"
  },
  Event_6836_ChoiceDesc2 = {
    Text = "[S'éloigner]"
  },
  Event_6836_Desc = {
    Text = "Tu ne pars pas, elles ne partent pas non plus.\nDes cordes étranges relient vos esprits, elles semblent vouloir te dire quelque chose"
  },
  Event_6836_Name = {
    Text = "Corbeau Solitaire"
  },
  Event_6837_ChoiceDesc1 = {
    Text = "[Abandonnez la Résistance] Supprimez 1 carte de commande, gagnez Arg1 sigil noir"
  },
  Event_6837_ChoiceDesc2 = {
    Text = "[Reculer les Mains]"
  },
  Event_6837_Desc = {
    Text = "Une, deux, trois...\nSur le visage, sur les doigts, des papillons en essaims scintillent comme des feux d'artifice dans l'obscurité.\nCette machine à écrire n'a aucune utilité pratique, mais elle excelle à créer de la beauté"
  },
  Event_6837_Name = {
    Text = "Inspiration soudaine"
  },
  Event_6838_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6838_Desc = {
    Text = "Des choses plus importantes sont devant toi, tu fermes la boîte et décides de les ignorer, et la machine à écrire devient silencieuse"
  },
  Event_6838_Name = {
    Text = "Avertissement non sollicité"
  },
  Event_6839_ChoiceDesc1 = {
    Text = "[Écouter la lune] Infecté par [(Skill.Arg1)]"
  },
  Event_6839_ChoiceDesc2 = {
    Text = "[Écouter l'étoile naine] Infecté par [(Skill.Arg1)]"
  },
  Event_6839_ChoiceDesc3 = {
    Text = "[Écoutez le météore] Perdez 25 sigils noirs"
  },
  Event_6839_Desc = {
    Text = "Chaleureux, lumineux, éternel"
  },
  Event_6839_Name = {
    Text = "Son des étoiles et de la lune"
  },
  Event_6840_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6840_Desc = {
    Text = "Au centre de la lumière se trouve un noyau d'argent solidifié, mais ta raison te dit qu'il ne brille pas.\nTon regard suit la source de la lumière, mais tombe dans un piège de ténèbres et d'inconnu"
  },
  Event_6840_Name = {
    Text = "Lumière nocturne"
  },
  Event_6841_ChoiceDesc1 = {
    Text = "[Partir] Choisissez 1 carte de commandement parmi 3 pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_6841_Desc = {
    Text = "Au nord, sortie nord !\nComme la décision de Ramona, il doit y avoir une issue au nord"
  },
  Event_6841_Name = {
    Text = "Vers le nord"
  },
  Event_6842_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6842_Desc = {
    Text = "Oh... L'argent immaculé représente la blague que ton âme te fait.\nAlors, quel est ton prochain choix ?"
  },
  Event_6842_Name = {
    Text = "Le spectacle commence"
  },
  Event_6843_ChoiceDesc1 = {
    Text = "[Partir] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_6843_Desc = {
    Text = "Tu secoues la tête pour chasser les voix.\nUn soupir à peine audible t'apporte un peu d'aide"
  },
  Event_6843_Name = {
    Text = "Vers le nord"
  },
  Event_6844_ChoiceDesc1 = {
    Text = "[Explorer le couloir] Infection[(Skill.Arg1)], continuer ?"
  },
  Event_6844_ChoiceDesc2 = {
    Text = "[Aller à l'encontre du courant] Gagnez 25 sigils noirs"
  },
  Event_6844_Desc = {
    Text = "La lumière de la lune disparaît, avalée par le couloir, ne laissant qu'une porte sinistre devant vous."
  },
  Event_6844_Name = {
    Text = "Galerie silencieuse"
  },
  Event_6845_ChoiceDesc1 = {
    Text = "[Approfondir le couloir] obtenir une oraison parmi 1 carte de commandement aléatoire : [(EnchantConfig.Arg1)], voulez-vous continuer ?"
  },
  Event_6845_ChoiceDesc2 = {
    Text = "[Aller à l'encontre du courant] Gagnez 25 sigils noirs"
  },
  Event_6845_Desc = {
    Text = "Ne pas approfondir sans connaître l'ensemble"
  },
  Event_6845_Name = {
    Text = "Galerie silencieuse"
  },
  Event_6846_ChoiceDesc1 = {
    Text = "[Explorer le couloir] Infection[(Skill.Arg1)], continuer ?"
  },
  Event_6846_ChoiceDesc2 = {
    Text = "[Aller à l'encontre du courant] Gagnez 25 sigils noirs"
  },
  Event_6846_Desc = {
    Text = "La porte de gauche émit un rire sinistre, elle tremblait légèrement, laissant tomber des bribes de malveillance"
  },
  Event_6846_Name = {
    Text = "Galerie silencieuse"
  },
  Event_6847_ChoiceDesc1 = {
    Text = "[Approfondir le couloir] obtenir une relique d'argent [(RelicConfig.Arg1)], voulez-vous continuer ?"
  },
  Event_6847_ChoiceDesc2 = {
    Text = "[Aller à l'encontre du courant] Gagnez 25 sigils noirs"
  },
  Event_6847_Desc = {
    Text = "La porte de droite est ouverte, le sang trace une trajectoire définie sur le sol"
  },
  Event_6847_Name = {
    Text = "Galerie silencieuse"
  },
  Event_6848_ChoiceDesc1 = {
    Text = "[There's nothing left, and you back out.]"
  },
  Event_6848_Desc = {
    Text = "Qui a dit qu'il fallait toujours foncer ? Parfois, reculer offre une vue plus large"
  },
  Event_6848_Name = {
    Text = "Galerie silencieuse"
  },
  Event_6849_ChoiceDesc1 = {
    Text = "[Repair Wax Sculpture] Choisissez une carte et réduisez son coût en Arithmetica de 1"
  },
  Event_6849_Desc = {
    Text = "La restauration de la statue de cire est en cours. \n Vous n'êtes pas un sculpteur de cire professionnel et vous n'avez jamais reçu de formation systématique en esthétique. \n Mais vous commencez tout de même habilement à mouler, façonner, peindre... \n Comme si vous étiez né avec un ciseau à la main. \n Comme si elle était née incomplète, juste pour attendre votre sculpture."
  },
  Event_6849_Name = {
    Text = "Statue de cire inachevée"
  },
  Event_6850_ChoiceDesc1 = {
    Text = "[Repair Wax Sculpture] Choisissez une carte et réduisez son coût en Arithmetica de 1"
  },
  Event_6850_Desc = {
    Text = "Galatée, Galatée...\nSuivant l'appel une fois de plus, vous avez trouvé la sculpture en cire inachevée. \nElle semblait parfaite, même troublante. \n\"La laideur est une déchirure dans la perfection.\"\nAu dernier moment, vous décidez de faire quelque chose."
  },
  Event_6850_Name = {
    Text = "Statue de cire inachevée"
  },
  Event_6851_ChoiceDesc1 = {
    Text = "[Accepter l'Illusion] 1 Carte d'instruction aléatoire obtient l'Oraison : «(EnchantConfig.Arg1)», infectée par «(Skill.Arg2)»"
  },
  Event_6851_ChoiceDesc2 = {
    Text = "[nier les fantasmes] choisit 1 carte de commande parmi 3 et obtient l'oraison :[(EnchantConfig.Arg1)]"
  },
  Event_6851_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_6851_Desc = {
    Text = "Sous le lourd pont de fer dans l'obscurité, sur la berge silencieuse envahie de roseaux, une papillon scintillant surgit soudain. \n Le papillon se pose léger dans ta paume, les hurlements affreux s'arrêtent, remplacés par le grondement d'un train passant sur la structure en acier rouillé, le crépitement du charbon brûlant, le bruit de frottement métallique des essieux tournants…"
  },
  Event_6851_Name = {
    Text = "Illusion Ferroviaire"
  },
  Event_6852_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6852_Desc = {
    Text = "Oui, une fuite, tu es poursuivi par une certaine créature, l'instinct de survie te pousse à courir à toute vitesse, jusqu'à ce qu'il n'y ait plus de voie d'évasion. Non, ça ne devrait pas être une évasion sans issue... n'est-ce pas un chien des enfers ?"
  },
  Event_6852_Name = {Text = "Courir"},
  Event_6853_ChoiceDesc1 = {
    Text = "\"[Ce n'est pas réel]\" Obtenu la relique argentée \"(RelicConfig.Arg1)\""
  },
  Event_6853_ChoiceDesc2 = {
    Text = "[Falling, falling...] Obtenir une relique d'or \"(RelicConfig.Arg1)\" et devenir infecté par \"(Skill.Arg2)\"."
  },
  Event_6853_Desc = {
    Text = "Le miroir tombé au sol a un cadre délicat, cadre dans cadre, encore et encore...\nAlice saute et tombe sans fin dans le terrier du lapin, voyant miroir après miroir, esprit après esprit piégé ici, sauf elle-même"
  },
  Event_6853_Name = {
    Text = "Miroir dans le miroir"
  },
  Event_6854_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6854_Desc = {
    Text = "À travers la vitre du blizzard, vous apercevez la montagne de neige où de nombreuses fourmis noires poursuivent une fourmi noire…\nVotre pensée a été interrompue"
  },
  Event_6854_Name = {
    Text = "Souvenirs volcaniques"
  },
  Event_6855_ChoiceDesc1 = {
    Text = "[Step Forward and Grip] Gagnez 25 Sigils Noirs"
  },
  Event_6855_ChoiceDesc2 = {
    Text = "[Réponse Amicale] 50 % de chances de gagner 50 sigils noirs, 50 % de chances de rien."
  },
  Event_6855_Desc = {
    Text = "Un chat, dont l'origine est inconnue, est assis entre les d-boues. Son corps aux contours flous indique qu'il doit être un résident de la dimension spirituelle.\nCe reflet au visage flou fixe Lamona avec un regard sage, levant sa patte blanche pour faire signe"
  },
  Event_6855_Name = {
    Text = "Résidents Nomades"
  },
  Event_6856_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6856_Desc = {
    Text = "Une scène joyeuse de groupe.\nLes statues de cire sont habillées de manière élégante, assises en rangée avec des sourires exagérés.\nElles sont aussi harmonieuses que celles que vous pourriez voir dans n'importe quel asile.\n\nDaté de l'année 305 de l'Holocène, @2 Rogers"
  },
  Event_6856_Name = {
    Text = "Galerie des portraits"
  },
  Event_6857_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6857_Desc = {
    Text = "Tu enlèves délicatement les fragments, les inspectant minutieusement. Ils sont redevenus immobiles.\n« Sois moins maladroit, ne bouge pas », dit la poupée en te tapotant l'arrière de la tête, « je n'ai pas de moyen de te fabriquer un deuxième morceau dans l’immédiat. »"
  },
  Event_6857_Name = {
    Text = "Broche Inquiète"
  },
  Event_6858_ChoiceDesc1 = {Text = "[Use Key]"},
  Event_6858_ChoiceDesc2 = {Text = "[Leave]"},
  Event_6858_Desc = {
    Text = "Une porte bloque ton chemin. Malgré tous tes efforts, elle reste immobile"
  },
  Event_6858_Name = {
    Text = "Porte rouillée"
  },
  Event_6858_Tips1 = {
    Text = "Nécessite d'obtenir la « Clé rouillée »"
  },
  Event_6859_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6859_Desc = {
    Text = "Tu ressens de la honte pour ton impulsivité. \n Un bon Gardien doit être rigoureux, tu ne devrais pas te permettre de juger qu'ils ne sont pas des « produits de luxe ». \n Alors tu décides de les observer attentivement. Cinq minutes passent, dix minutes passent... \n Bien, maintenant tu peux porter un jugement - \n ce sont effectivement des produits de mauvaise qualité."
  },
  Event_6859_Name = {Text = "Âme Liée"},
  Event_6860_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6860_Desc = {
    Text = "Toi et tes compagnons avez déposé les armes.\nCe n'était pas par bonté, mais parce que tu savais que leurs corps fragiles ne tiendraient pas longtemps.\nLes faits ont prouvé que tu avais raison"
  },
  Event_6860_Name = {Text = "Étude"},
  Event_6861_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6861_Desc = {
    Text = "\n\"Viens me poursuivre !\"\n\"Allez, espèce de fool !\"\n\"Si tu peux, attrape-nous !\" \nLes voix des enfants étaient pleines de fierté. \n\"Zut alors ! Arrête-toi !\" \nLa voix de l'adulte était essoufflée."
  },
  Event_6861_Name = {
    Text = "Nos Souvenirs"
  },
  Event_6862_ChoiceDesc1 = {
    Text = "[Enter] À travers la brume, atteignez l'autre côté."
  },
  Event_6862_ChoiceDesc2 = {Text = "[Leave]"},
  Event_6862_Desc = {
    Text = "C'est la personne que tu cherchais, tu as accompli ta mission"
  },
  Event_6862_Name = {
    Text = "Passage secret 26"
  },
  Event_6863_ChoiceDesc1 = {
    Text = "[Partir] Obtient une relique d'argent[(RelicConfig.Arg1)]"
  },
  Event_6863_Desc = {
    Text = "Ah ! Juste un peu plus ! Attends, pourquoi trois dés ont-ils donné dix points !\nLes dés reposent sagement devant toi, semblant innocents"
  },
  Event_6863_Name = {
    Text = "Partie de jeu sans fin"
  },
  Event_6864_ChoiceDesc1 = {
    Text = "[Partir] Obtient une relique en or[(RelicConfig.Arg1)]"
  },
  Event_6864_Desc = {
    Text = "Merde ! Ce n'est pas six heures, mais il y a encore quelques bénéfices. \nAlors, quel est le résultat ?"
  },
  Event_6864_Name = {
    Text = "Partie de jeu sans fin"
  },
  Event_6865_ChoiceDesc1 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_6865_Desc = {
    Text = "Bien que je n'aie pas deviné correctement, c'est acceptable.\nAlors, quel est le résultat ?"
  },
  Event_6865_Name = {
    Text = "Partie de jeu sans fin"
  },
  Event_6866_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6866_Desc = {
    Text = "Tu baisses la tête, triant les morceaux de plâtre, les reconstituant. Une partie de son corps prend forme sous tes mains"
  },
  Event_6866_Name = {
    Text = "Assembler des restes"
  },
  Event_6867_ChoiceDesc1 = {
    Text = "[Pick Up Key]"
  },
  Event_6867_Desc = {
    Text = "Un trousseau de clés rouillées. Peut ouvrir des serrures"
  },
  Event_6867_Name = {
    Text = "Clé rouillée"
  },
  Event_6868_ChoiceDesc1 = {
    Text = "[Positive] 50% de chances d'obtenir une Relique d'Or \"(RelicConfig.Arg2)\", 50% de chances d'être infecté par \"(Skill.Arg3)\""
  },
  Event_6868_ChoiceDesc2 = {
    Text = "[opposé] 50% de chances d'obtenir 75 le sigil noir, 50% de chances de contaminer[(Skill.Arg3)]"
  },
  Event_6868_ChoiceDesc3 = {
    Text = "[Let Them Choose] 50% de chances d'obtenir une Relique Maudite \"(RelicConfig.Arg2)\", 50% de chances d'infecter \"(Skill.Arg3)\""
  },
  Event_6868_Desc = {
    Text = "Juste un pari, tu ne perdras pas.\nUne pièce gravée est lancée en l'air, puis retombe rapidement, réchauffée par votre paume"
  },
  Event_6868_Name = {
    Text = "Gambler célèbre"
  },
  Event_6869_ChoiceDesc1 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_6869_Desc = {
    Text = "\"Ceux qui placent leur confiance dans les faveurs du destin seront également renversés par lui.\"\nVous choisissez de partir."
  },
  Event_6869_Name = {
    Text = "Gambler célèbre"
  },
  Event_6870_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6870_Desc = {
    Text = "\"Gardien.\"\nLa voix de Ramona vous ramène à vos sens, mais la sensation de chute ne disparaît pas."
  },
  Event_6870_Name = {
    Text = "Miroir dans le miroir"
  },
  Event_6871_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6871_Desc = {
    Text = "On dit que la sérénade est une chanson d'amour.\nJouée par des compagnons sous la fenêtre d'un amant lors d'une nuit d'été.\nSpontanée, superficielle, elle ne correspond pas aux goûts de Rogers, mais reste dans son répertoire.\nSeul lui connaît probablement la raison"
  },
  Event_6871_Name = {
    Text = "mauvais goût"
  },
  Event_6872_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6872_Desc = {
    Text = "Tu refuses d'être séduit par leurs délires. \n Tu dis : « Mensonges ! Vous êtes piégés dans une nuit noire éternelle, comment pouvez-vous parcourir l'univers ? » \n Les yeux rirent. Des milliers de rires s'unirent en une énorme vague sonore, et ton cœur trembla en écho. \n Les yeux dirent : « En pillant d'autres yeux. Chaque œil est un univers. Lorsque tu posséderas mille yeux, tu entreprendras un véritable voyage à travers le temps et l'espace. »"
  },
  Event_6872_Name = {Text = "œil"},
  Event_6873_ChoiceDesc1 = {
    Text = "[Receive] Choisissez 1 parmi 3 reliques d'or"
  },
  Event_6873_Desc = {
    Text = "Oh oui, ce reflet odieux, c'est toi.\nLa malveillance jaillissante se mêle à la boue noire sous tes pieds, dansant de manière tordue. Si tu ne t'y opposes pas, elle grimpera sur ton épaule"
  },
  Event_6873_Name = {
    Text = "Sous la surface du miroir"
  },
  Event_6874_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6874_Desc = {
    Text = "Peu de temps après, les chaînes se sont soudainement relâchées, vous faisant trébucher. \n Vous vous êtes retourné pour regarder les fils silencieux - « Ne dérangez pas les sables mouvants », cette phrase pourrait également s'appliquer à ce domaine"
  },
  Event_6874_Name = {Text = "Enliséré"},
  Event_6875_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6875_Desc = {
    Text = "La flamme de la connaissance spirituelle s'alluma, brûlant toutes les chaînes -\nDu moins, c'est ce que tu pensais"
  },
  Event_6875_Name = {Text = "Enliséré"},
  Event_6876_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6876_Desc = {
    Text = "Vous vous libérez de toutes vos forces, les fils déchirent vos vêtements et laissent des traces de sang sur votre peau.\nBien que la toile ait pris quelque chose en échange, vous vous sentez soulagé - vous êtes libre"
  },
  Event_6876_Name = {Text = "Enliséré"},
  Event_6877_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6877_Desc = {
    Text = "Les lettres produites par les excroissances de corrosion sont souvent effacées.\nVous n'avez pas pu obtenir d'informations précieuses de la lettre, alors vous l'avez déchirée et dispersée"
  },
  Event_6877_Name = {
    Text = "Chapitre Papillon"
  },
  Event_6878_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6878_Desc = {
    Text = "Même si les mots sont effacés, tu peux toujours percevoir la valeur de la lettre"
  },
  Event_6878_Name = {
    Text = "Chapitre Papillon"
  },
  Event_6879_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6879_Desc = {
    Text = "Prudence.\nRamona se penche, retourne dans le couloir et entre dans la pièce suivante"
  },
  Event_6879_Name = {
    Text = "Reflet dans la fenêtre"
  },
  Event_6880_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6880_Desc = {
    Text = "Tu pousses un cri désespéré.\nLes corbeaux, attirés par ton cri, disparaissent rapidement, laissant une trace noire"
  },
  Event_6880_Name = {
    Text = "Chant des Corbeaux"
  },
  Event_6881_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6881_Desc = {
    Text = "Tu te recroquevilles, essayant de te réduire à un point noir.\nAinsi, ils ne te remarqueront pas, n'est-ce pas ?\nAprès un moment, tu ouvres les yeux.\nTu vois la lumière"
  },
  Event_6881_Name = {
    Text = "Chant des Corbeaux"
  },
  Event_6882_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6882_Desc = {
    Text = "L'ombre glisse entre les doigts, laissant une poussière dorée"
  },
  Event_6882_Name = {
    Text = "Clé d'argent"
  },
  Event_6883_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6883_Desc = {
    Text = "Tu frottes frénétiquement tes cheveux, des délires et des pensées folles éclatant dans ton esprit, des masses de substance noire cachées au fond.\nLes ouvrir, quel cadeau cela te donnerait-il ?"
  },
  Event_6883_Name = {
    Text = "Agiter le cerveau"
  },
  Event_6884_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6884_Desc = {
    Text = "Des taches d'huile colorées remplissent progressivement ta vision, tes émotions plongent dans une fête chaotique"
  },
  Event_6884_Name = {
    Text = "Agiter le cerveau"
  },
  Event_6885_ChoiceDesc1 = {Text = "[Pocketed]"},
  Event_6885_Desc = {
    Text = "Une matière argentée proche du mercure, extraite de la boue de dissolution, contenant un puissant pouvoir spirituel, utilisée principalement pour lier plus de réveilleurs lors des rituels"
  },
  Event_6885_Name = {
    Text = "Cœur d'argent"
  },
  Event_6886_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6886_Desc = {
    Text = "Le rire s'échappe de la boîte, et après que la lueur chaleureuse s'éteigne, vous voyez une carte avec trois bonhommes : vous, la rousse Ramona aux cheveux argentés, et l'Ogier aux cheveux blonds. À côté, une ligne de texte dit :\n   \"Merci à tous !\""
  },
  Event_6886_Name = {
    Text = "Cadeau bienveillant"
  },
  Event_6887_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6887_Desc = {
    Text = "Ton corps a échappé aux papillons, mais ils n'ont pas lâché leur cible, se glissant dans ta valise, absorbant goulûment l'encre de la machine à écrire"
  },
  Event_6887_Name = {
    Text = "Délire éruptif"
  },
  Event_6888_ChoiceDesc1 = {
    Text = "[Signaler l'erreur] Choisissez 1 Carte d'instruction pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_6888_ChoiceDesc2 = {
    Text = "[Listen to the Performance] Gagnez 15 Sigils noirs pour chaque Réveilleur avec un Aliemus de 50 ou plus."
  },
  Event_6888_ChoiceDesc3 = {
    Text = "[Leave] Obtenir 1 parmi 3 Oraisons"
  },
  Event_6888_Desc = {
    Text = "Un garçon fait de cire joue une étude pour piano.\nSon professeur – également en cire, l'instruit à côté.\n133, 355, 244...\nFaux, chaque note est fausse"
  },
  Event_6888_Name = {
    Text = "Cours de piano"
  },
  Event_6889_ChoiceDesc1 = {
    Text = "[Abandonnez la Résistance] Supprimez 1 carte de commande, gagnez Arg1 sigil noir"
  },
  Event_6889_ChoiceDesc2 = {
    Text = "[Reculer les Mains]"
  },
  Event_6889_Desc = {
    Text = "Tu ne peux résister à l'impulsion de ton cœur. \n Tes doigts, tels des enfants perdus dans les bois, errent et jouent sur le clavier... \n Peu à peu, des papillons s'échappent de la machine à écrire. \n Un, deux, trois... \n Sur le visage, sur les doigts, des nuées de papillons scintillent comme des feux d'artifice dans l'obscurité, émettant une lumière précieuse. \n Cette machine à écrire n'a aucune utilité pratique, mais elle excelle à créer de la beauté."
  },
  Event_6889_Name = {
    Text = "Inspiration soudaine"
  },
  Event_6890_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6890_Desc = {
    Text = "Tu tiens le papier sous la lumière rouge sombre, craignant de manquer un détail. \n C'est un rapport d'examen médical, le sujet examiné n'est autre que Mason. \n « Poids 40 kg, saturation en oxygène normale, taux de synchronisation 30 %, valeur de résonance... » \n Tu souhaites continuer à lire, mais l'écriture disparaît progressivement. \n Propre comme si rien ne s'était passé."
  },
  Event_6890_Name = {
    Text = "Machine à écrire"
  },
  Event_6891_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6891_Desc = {
    Text = "Oui, tu n'es pas en fuite, tu poursuis un objectif certain - le «chien des enfers» qui se faufile dans les ruelles étroites et humides couvertes de neige. Tu n'oublieras pas cela, tout comme tu n'oublieras pas le visage de la personne qui t'a tiré des décombres ce jour-là à Toungouska. ... C'était qui déjà ?"
  },
  Event_6891_Name = {Text = "Courir"},
  Event_6892_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6892_Desc = {
    Text = "Dans cet espace isolé, tu ne peux compter que sur toi-même"
  },
  Event_6892_Name = {
    Text = "Marcheur de cauchemar"
  },
  Event_6893_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6893_Desc = {
    Text = "Crise et risque coexistent. En touchant le cadenas en fer, un liquide corrosif brûle ta paume. Espérons que ce qui se trouve derrière la porte en vaille la peine"
  },
  Event_6893_Name = {
    Text = "Après la porte en fer"
  },
  Event_6894_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6894_Desc = {
    Text = "En te précipitant dans un monde inconnu, ton esprit vacillant n'a pas encore perdu toute raison.\nTu comprends bien la terreur de l'inconnu"
  },
  Event_6894_Name = {
    Text = "Marcheur de cauchemar"
  },
  Event_6895_ChoiceDesc1 = {
    Text = "[Loud Shout] Gagnez une relique en argent \"(RelicConfig.Arg1)\" et infectez \"(Skill.Arg2)\""
  },
  Event_6895_ChoiceDesc2 = {
    Text = "[Embrace Silence] Gagnez Relique d'or \"(RelicConfig.Arg1)\", Infection \"(Skill.Arg2)\", \"(Skill.Arg3)\""
  },
  Event_6895_ChoiceDesc3 = {
    Text = "[Surface] Gagner 25 Sigils Noirs"
  },
  Event_6895_Desc = {
    Text = "Tu as entendu le silence.\nUn silence amplifié, comme le bruit des vagues, remplissant tout l'espace.\n\nTu as levé la tête, comme un petit point regardant les étoiles"
  },
  Event_6895_Name = {
    Text = "Eaux du passé"
  },
  Event_6896_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6896_Desc = {
    Text = "Tu tends l'oreille, cherchant la source du son, tentant de démasquer ce fauteur de troubles. \n Mais comme pour te narguer intentionnellement, chaque fois que tu penses avoir poussé la personne dans ses retranchements, tu te heurtes à un mur invisible, te ramenant au même endroit. \n Découragé, tu donnes un coup de pied dans le mur de briques, mais une brique tombe du mur, révélant une lueur cachée dans le trou."
  },
  Event_6896_Name = {
    Text = "Écho de la Trajectoire Mystérieuse"
  },
  Event_6897_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6897_Desc = {
    Text = "Ça doit être un problème de lecture, c'est sûr.\nVous remettez l'aiguille, supportant difficilement la première partie de la musique désagréable, mais le son attendu ne vient pas.\nDerrière vous, une petite ombre noire glisse discrètement"
  },
  Event_6897_Name = {
    Text = "Écho de la Trajectoire Mystérieuse"
  },
  Event_6898_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6898_Desc = {
    Text = "Il n'y a personne autour de vous, le secret des coups frappés doit être caché à l'intérieur du mécanisme du phonographe. \n Confiant dans votre jugement, vous démontez le vieux phonographe. \n À part les pièces métalliques corrodées et une épaisse couche de poussière, vous ne trouvez rien d'autre. \n Seulement un murmure, s'échappant dans la brume, si léger qu'il semble venir d'un rêve."
  },
  Event_6898_Name = {
    Text = "Écho de la Trajectoire Mystérieuse"
  },
  Event_6899_ChoiceDesc1 = {
    Text = "[La Matière Blanche du Fool] Restaure Arg1 Vie"
  },
  Event_6899_ChoiceDesc2 = {
    Text = "[Cœur du Fou] Tirez une carte de commandement aléatoire pour obtenir une oraison : [(EnchantConfig.Arg1)]"
  },
  Event_6899_ChoiceDesc3 = {
    Text = "[Refuse to Eat] Obtenez 25 sigils noirs"
  },
  Event_6899_Desc = {
    Text = "« La chair blanche du Fou est délicieuse comme un bouillon de poisson bouillant, tandis que le cœur du fou est rôti en un scone chaud et sanguinolent. » \n L'Ombre rit de manière sinistre, te présentant un plat contenant des ingrédients mystérieux. \n Tu inspires profondément, l'arôme envahissant pénètre brutalement dans tes narines, tes glandes salivaires sans dignité se rendent immédiatement, tandis que ton estomac se tord de désespoir, émettant un gémissement de désir."
  },
  Event_6899_Name = {
    Text = "Festin de chair"
  },
  Event_6900_ChoiceDesc1 = {
    Text = "[Touch Wind Chime] Infectez avec \"(Skill.Arg1)\", accordez aléatoirement 1 Carte de Commandement une Oraison : \"(EnchantConfig.Arg2)\""
  },
  Event_6900_ChoiceDesc2 = {
    Text = "[Observe Wind Chime] Infecter avec \"(Skill.Arg1)\", accorder aléatoirement 1 carte de commandement une Oraison : \"(EnchantConfig.Arg2)\""
  },
  Event_6900_ChoiceDesc3 = {
    Text = "[Ne rien faire] Tirez une carte de commandement au hasard pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_6900_Desc = {
    Text = "Ding ding, ding ding...\nC'est une cloche rouillée, produisant une mélodie maladroite"
  },
  Event_6900_Name = {
    Text = "Vent de rouille"
  },
  Event_6901_ChoiceDesc1 = {
    Text = "[Wait and See] Essayez de survivre"
  },
  Event_6901_ChoiceDesc2 = {
    Text = "[Swing Weapon] Tentez de Briser"
  },
  Event_6901_ChoiceDesc3 = {
    Text = "[Tenir une main] Gagnez 25 Sigils noirs"
  },
  Event_6901_Desc = {
    Text = "Le sol sous tes pieds se transforme soudainement en un marécage noir, des milliers de mains en surgissent. \n Elles présentent une variété de couleurs de peau, de matériaux et de textures, bleu paon, écailleux, avec des yeux, comme si elles venaient de traverser d'innombrables dimensions et espaces, tentant d'attirer la prochaine malchance dans leur grande famille. \n Tu décides —"
  },
  Event_6901_Name = {
    Text = "Marais Sombre"
  },
  Event_6902_ChoiceDesc1 = {
    Text = "[Tenez-le] Piochez au hasard 3 cartes de commandement du paquet et choisissez 1 à copier."
  },
  Event_6902_ChoiceDesc2 = {
    Text = "[Secouer légèrement] Choisissez 1 Carte d'instruction parmi 3 pour obtenir une Oraison : «(EnchantConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_6902_ChoiceDesc3 = {
    Text = "[Do Nothing] Gagnez 25 Sigils Noirs"
  },
  Event_6902_Desc = {
    Text = "Ding ding, ding ding...\nC'est une cloche rouillée, produisant une mélodie maladroite"
  },
  Event_6902_Name = {
    Text = "Petite clochette"
  },
  Event_6903_ChoiceDesc1 = {
    Text = "[rebuttez-les] obtient une relique d'argent[(RelicConfig.Arg1)], choisit de contaminer 1 symptôme"
  },
  Event_6903_ChoiceDesc2 = {
    Text = "[Follow them] Choisir 1 des 3 cartes de commandement pour obtenir une oraison : \"(EnchantConfig.Arg1)\", infecter \"(Skill.Arg2)\""
  },
  Event_6903_ChoiceDesc3 = {
    Text = "[Suggest New Idea] Gagner 25 Sigils Noirs"
  },
  Event_6903_Desc = {
    Text = "« Veuillez garder vos distances avec nous. »\n Des groupes de rats t'entourent, maintenant au moins cinq pieds entre vous. \n « Nous nous reproduisons, nous prospérons, nous ne sommes jamais difficiles — et c'est ainsi que nous apportons aux humains maladie, anxiété et souffrance. »\n « Nous ne devrions pas nous approcher trop des humains, ce n'est pas l'endroit où tu devrais être. »\n Pour détendre la vigilance des rats, tu décides de —"
  },
  Event_6903_Name = {Text = "Peste"},
  Event_6904_ChoiceDesc1 = {
    Text = "[Continuer à tomber] Infecter[(Skill.Arg1)], continuer à tomber ?"
  },
  Event_6904_ChoiceDesc2 = {
    Text = "[Éloignez-vous] Gagner 25 Sigils Noirs"
  },
  Event_6904_Desc = {
    Text = "«Tu» t'invite plus profondément.\nAu fond de la spirale, le «toi» du passé et du futur t'offre des «cadeaux» de différentes dimensions."
  },
  Event_6904_Name = {
    Text = "Abysses en spirale"
  },
  Event_6905_ChoiceDesc1 = {
    Text = "[Maintenir le Corbeau] Obtenir 40 le sigil noir, infecter [(Skill.Arg2)], continuer la sélection"
  },
  Event_6905_ChoiceDesc2 = {
    Text = "[Ignorez-le] Gagnez 25 Sigils Noirs et partez."
  },
  Event_6905_Desc = {
    Text = "Le corbeau solitaire, d'une voix rauque, arrache ses plumes noires une à une.\nIl tremble de douleur, criant aigu, mais ne peut pas arrêter son rythme de plus en plus frénétique.\n\"Caw—Caw—\"\nDes larmes bleues mélangées à un ooze noir coulent de ses yeux, témoins uniquement pour vous."
  },
  Event_6905_Name = {
    Text = "Larme de lave fondue"
  },
  Event_6906_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6906_Desc = {
    Text = "Rouge, passionné, flamboyant, magnifique, je connais justement une telle beauté, vous la rencontrerez en temps voulu.\nAlors, quel est votre prochain choix ?"
  },
  Event_6906_Name = {
    Text = "Le spectacle commence"
  },
  Event_6907_ChoiceDesc1 = {
    Text = "[Fête bruyante]"
  },
  Event_6907_ChoiceDesc2 = {Text = "[Drowsy]"},
  Event_6907_Desc = {
    Text = "Tu as fait un très long rêve. \n Dans le rêve, tu es assis dans le public, regardant le garçon qui chante sur scène. \n « Le vieux Charlie avait un chat tigré qu'il aimait beaucoup \n Quand elle a disparu sans raison, il l'a cherchée partout. » \n … \n Une voix vide et sèche se répète mécaniquement, sans fin…"
  },
  Event_6907_Name = {
    Text = "Cérémonie finale IV"
  },
  Event_6908_ChoiceDesc1 = {
    Text = "[Untangle the upper branches]"
  },
  Event_6908_ChoiceDesc2 = {
    Text = "[Untangle Lower Branch]"
  },
  Event_6908_Desc = {
    Text = "Les connaissances du domaine résiduel s'entrelacent, créant un champ de force instable.  \nPeut-être pouvez-vous libérer l'esprit entremêlé, vous ouvrant un chemin vers l'avant"
  },
  Event_6908_Name = {
    Text = "Chemin d'intrication"
  },
  Event_6909_ChoiceDesc1 = {
    Text = "[Leave] Choisissez de Réveiller 2 Réveils"
  },
  Event_6909_Desc = {
    Text = "Tu te lèves et te précipites immédiatement vers la porte. \n « Tu as soulevé le voile... \n Le secret, tu as découvert le secret... » \n Les vagues sonores forment un océan tumultueux, le sol tremble violemment sous une résonance terrifiante. \n Tu n'oses pas te retourner et tu fuis sur le champ à toute vitesse."
  },
  Event_6909_Name = {
    Text = "Cérémonie finale V"
  },
  Event_6910_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6910_Desc = {
    Text = "Tu ne résistes pas, bien sûr, tu ne choisis pas non plus de t'y complaire"
  },
  Event_6910_Name = {
    Text = "Crâne perforé"
  },
  Event_6911_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6911_Desc = {
    Text = "Tu cesses de résister, laissant la souillure dévorer ton corps et ton esprit. Après un long sommeil, une lumière argentée tombe dans tes mains jointes"
  },
  Event_6911_Name = {
    Text = "Crâne perforé"
  },
  Event_6912_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6912_Desc = {
    Text = "Plus vous luttez, plus la saleté s'enfonce dans votre esprit, et au plus profond de ce cerveau chargé de péchés, se cache un don inexplicable"
  },
  Event_6912_Name = {
    Text = "Crâne perforé"
  },
  Event_6913_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6913_Desc = {
    Text = "À mesure que le filet se brise, quelque chose traverse ton esprit, peut-être des visages d'enfants souriants"
  },
  Event_6913_Name = {
    Text = "Réseau errant"
  },
  Event_6914_ChoiceDesc1 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_6914_Desc = {
    Text = "Le chat hoche la tête avec satisfaction, puis disparaît en une ombre, laissant quelques objets noirs ronds"
  },
  Event_6914_Name = {
    Text = "Résidents Nomades"
  },
  Event_6915_ChoiceDesc1 = {
    Text = "[Lire la Lettre] Retirer 1 carte de commande, gagner Arg1 sigils noirs"
  },
  Event_6915_ChoiceDesc2 = {
    Text = "[Close the Box]"
  },
  Event_6915_Desc = {
    Text = "Les lettres volantes envahissent le ciel, comme une incitation silencieuse"
  },
  Event_6915_Name = {
    Text = "Lettre inattendue"
  },
  Event_6916_ChoiceDesc1 = {
    Text = "[Enter] À travers la brume, atteignez l'autre côté."
  },
  Event_6916_ChoiceDesc2 = {Text = "[Leave]"},
  Event_6916_Desc = {
    Text = "Un tunnel caché est apparu sur la route devant vous, rempli de brume noire, menant vers l'inconnu"
  },
  Event_6916_Name = {Text = "Tunnel"},
  Event_6917_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6917_Desc = {
    Text = "Tu décides de mettre fin à sa souffrance, alors tu saisis son corps mou, serres, serres encore... \nIl se débat désespérément dans ta main, puis éclate en une masse de liquide chaud"
  },
  Event_6917_Name = {
    Text = "Larme de lave fondue"
  },
  Event_6918_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6918_Desc = {
    Text = "Ne t'inquiète pas, ce ne sont que des souvenirs fragmentés d'autres dimensions. Tu as une ombre. Mais, cette personne dans l'ombre, est-ce vraiment toi ?"
  },
  Event_6918_Name = {
    Text = "Fragments de souvenirs : Bière"
  },
  Event_6919_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6919_Desc = {
    Text = "Tu as fermement tordu le bec acéré du corbeau qui tentait de ronger ses plumes, mais il a insisté, se débattant avec une telle force que cela a fait craquer tes os. \n Ton visage est devenu rouge de colère, et tu as dû déployer toute ta force pour maîtriser le corps du corbeau, arrêtant ainsi son comportement autodestructeur. \n Alors que tu soufflais enfin, le cou déjà à moitié dénudé du corbeau s'est soudainement tordu en arrière, son corps s'affaissant, se transformant en une flaque de liquide noir dans ta main."
  },
  Event_6919_Name = {
    Text = "Larme de lave fondue"
  },
  Event_6920_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6920_Desc = {
    Text = "Tu ignores froidement les sonneries désespérées.\nMême si la prochaine seconde te ramène à l'âge primitif, même si toi et ta grande mission êtes enterrés ensemble.\nUn appel qui ne doit pas être pris, ne doit pas être pris.\nTu connais bien cette simple vérité"
  },
  Event_6920_Name = {
    Text = "Veuillez répondre au téléphone"
  },
  Event_6921_ChoiceDesc1 = {
    Text = "[Baissez le regard] Gagnez 25 Sigils noirs"
  },
  Event_6921_ChoiceDesc2 = {
    Text = "[I Must Find It] Obtenez Relique d'argent \"(RelicConfig.Arg1)\", Infection \"(Skill.Arg2)\""
  },
  Event_6921_Desc = {
    Text = "Tu poursuis l'ombre noire et soudain tu entres dans une zone d'eau peu profonde. Le liquide dont tu ne peux pas voir la couleur dépasse tes chaussures, apportant une sensation de froid.\nUne voix dans l'eau dit : « Tu ne veux pas trouver. »"
  },
  Event_6921_Name = {
    Text = "Tu ne voudras pas trouver"
  },
  Event_6922_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6922_Desc = {Text = "Choix sûr"},
  Event_6922_Name = {
    Text = "après la botte de paille"
  },
  Event_6923_ChoiceDesc1 = {
    Text = "[Chasser les corbeaux] obtenir Arg1 sigils noirs, infecter[(Skill.Arg2)], continuer à choisir"
  },
  Event_6923_ChoiceDesc2 = {
    Text = "[Disregard] Gagnez 25 Sigils Noirs et partez."
  },
  Event_6923_Desc = {
    Text = "Comment se fait-il qu'il y ait des corbeaux dans la pièce d'un sanatorium ?\n Mais tu entends bel et bien le rire cruel des corbeaux, une force qui n'est pas encore montée sur scène t'épie à travers ces yeux d'oiseau vides. Ces créatures noires tordent leur cou, se tenant sur le lustre au coin de la rue, te regardant de haut avec des yeux empreints de malice. Ces têtes en ombre semblent partager un corps immergé dans la lave corrodée."
  },
  Event_6923_Name = {
    Text = "Lanterne Corbeau"
  },
  Event_6924_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6924_Desc = {
    Text = "Ne crains pas la souillure, tu en tireras plus que tu ne perdras"
  },
  Event_6924_Name = {
    Text = "après la botte de paille"
  },
  Event_6925_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6925_Desc = {
    Text = "La tempête de connaissance spirituelle entourait Tulu, et tu échangeas un regard avec lui avant de plonger dans l'obscurité"
  },
  Event_6925_Name = {
    Text = "La Promesse de l'Agent"
  },
  Event_6926_ChoiceDesc1 = {
    Text = "[Enter] À travers la brume, atteignez l'autre côté."
  },
  Event_6926_ChoiceDesc2 = {Text = "[Leave]"},
  Event_6926_Desc = {
    Text = "Tu es tombé dans les ténèbres.\nAu bout de ta vue, il y a une lueur, qui passe à travers une fissure étroite comme un trou de serrure.\nLa clé en argent émet une lumière respirante, t'indiquant d'entrer dans ce passage secret"
  },
  Event_6926_Name = {
    Text = "Passage secret"
  },
  Event_6927_ChoiceDesc1 = {
    Text = "[Infecter«(Skill.Arg1)»，Obtenir la création：«(RelicConfig.Arg2)»]"
  },
  Event_6927_ChoiceDesc2 = {
    Text = "[Choisissez 1 carte de commandement parmi 3 pour obtenir une oraison :«(EnchantConfig.Arg1)»]"
  },
  Event_6927_Desc = {
    Text = "Événement 203 (en développement), effet non final"
  },
  Event_6927_Name = {
    Text = "Événement203 (en développement)"
  },
  Event_6928_ChoiceDesc1 = {
    Text = "[Réparer] Supprimez 1 carte de commandement, obtenez une relique :[(RelicConfig.Arg1)]"
  },
  Event_6928_ChoiceDesc2 = {
    Text = "[Caresser] Supprimez 1 carte d'attaque/défense, obtenez une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_6928_ChoiceDesc3 = {
    Text = "[Disgust] Gagnez 25 Sigils Noirs"
  },
  Event_6928_Desc = {
    Text = "\"Aimez-vous mes restes ? Si possible, pourriez-vous m'aider à reconstituer mon corps ?\"\nLes lèvres de la statue en plâtre à moitié corps bougèrent, et une voix délicate, aussi douce que de la soie, émergea de ses lèvres qui auraient dû être dures et froides."
  },
  Event_6928_Name = {
    Text = "Assembler des restes"
  },
  Event_6929_ChoiceDesc1 = {
    Text = "[Jeter l'enveloppe] Choisissez 1 carte de commandement parmi 3 pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_6929_ChoiceDesc2 = {
    Text = "[Tucked in the Chest] Infectez \"(Skill.Arg1)\", obtenez une Relique : \"(RelicConfig.Arg2)\""
  },
  Event_6929_Desc = {
    Text = "C'est une lettre de détresse, l'expéditeur s'efforce de rester calme, mais son écriture parfois inclinée révèle sans réserve la peur profondément enfouie en lui. \n « Tout cela dépasse complètement mes prévisions, si quelqu'un disait maintenant que je suis sous le coup d'une malédiction, je jurerais que je le croirais sans l'ombre d'un doute. » \n « On dit que je suis fou, il n'a raison que sur un point, je suis en équilibre précaire au bord de la folie. » \n « Mais je l'ai vraiment vu ! Il se transforme et se dissipe, cette substance noire et collante en prolifération essaie de grimper sur tout mon corps ! » \n « J'ai fui ! J'ai fui rapidement, mais le regard qui me scrutait ne s'est jamais détourné de moi, j'ai le pressentiment qu'il va certainement me retrouver ! Cette répugnante boue noire va à nouveau s'infiltrer dans mon crâne, peu importe qui reçoit cette lettre, je t'en supplie, sauve-moi — »"
  },
  Event_6929_Name = {
    Text = "Un appel au secours"
  },
  Event_6930_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6930_Desc = {
    Text = "\"Calme-toi,\" Ramona tapote votre tête, \"ce ne sont que des fragments du passé. Je ne sais pas qui les a laissés dans ce passage dimensionnel.\" \nEn effet, il y a un parfum nostalgique."
  },
  Event_6930_Name = {
    Text = "Communication d'urgence"
  },
  Event_6931_ChoiceDesc1 = {
    Text = "[Tirer au hasard 1 carte de commandement pour obtenir une oraison :«(EnchantConfig.Arg1)»]"
  },
  Event_6931_ChoiceDesc2 = {
    Text = "[Tirer au hasard 1 carte de commandement pour obtenir une oraison :«(EnchantConfig.Arg1)»]"
  },
  Event_6931_ChoiceDesc3 = {
    Text = "[Tirer au hasard 1 carte de commandement pour obtenir une oraison :«(EnchantConfig.Arg1)»]"
  },
  Event_6931_Desc = {
    Text = "Événement 205 (en développement), effet non final"
  },
  Event_6931_Name = {
    Text = "Événement205 (en développement)"
  },
  Event_6932_ChoiceDesc1 = {
    Text = "[Obtenez la création : [(RelicConfig.Arg1)]"
  },
  Event_6932_ChoiceDesc2 = {
    Text = "[Obtenez la création : [(RelicConfig.Arg1)]"
  },
  Event_6932_ChoiceDesc3 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_6932_Desc = {
    Text = "Événement 204 (en développement), effet non final"
  },
  Event_6932_Name = {
    Text = "Événement204 (en développement)"
  },
  Event_6933_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6933_Desc = {
    Text = "La lune solitaire brille haut dans le ciel, et tu peux entendre clairement ses paroles de prière, un ton étrange, ressemblant aux murmures de choses impures. \n La prière s'arrête, tu es sur le point de partir. Mais derrière toi, une ombre blanche apparaît. \n « Celui qui espionne le destin et profane les prières, les dons et les prix viendront comme convenu. »"
  },
  Event_6933_Name = {
    Text = "Fragment de Lune d'Argent"
  },
  Event_6934_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6934_Desc = {
    Text = "Un bruit de verre brisé retentit derrière toi. Tu hésites un instant, puis tu pars"
  },
  Event_6934_Name = {
    Text = "Fragment de Lune d'Argent"
  },
  Event_6935_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6935_Desc = {
    Text = "Une poignée de lumière lunaire dans la paume, dispersée sur la pierre tombale.\nQuelqu'un est enterré sous la boue épaisse, les spectateurs prétendent qu'il est mort naturellement et reposera en paix.\nMais la boue enfouie bouge, et dans les cris, une lune molle en émerge"
  },
  Event_6935_Name = {
    Text = "Fragment de Lune d'Argent"
  },
  Event_6936_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6936_Desc = {
    Text = "Mais c'est juste une créature luttant pour survivre, cherchant un morceau de bois flottant pour se reposer...\nTu soupires, laissant le liquide noir couler de la queue du papillon"
  },
  Event_6936_Name = {
    Text = "Quelque chose qui ne devrait pas exister"
  },
  Event_6937_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6937_Desc = {
    Text = "C'est un piège annoncé, et tu connais bien son danger.\nComparé aux bijoux, toi-même es la gemme la plus précieuse"
  },
  Event_6937_Name = {
    Text = "Renverser la griffe maléfique"
  },
  Event_6938_ChoiceDesc1 = {
    Text = "[Insert Silver Key]"
  },
  Event_6938_Desc = {
    Text = "La d-boue sursaturée semble renfermer certaines substances... observe avec la clé en argent et transforme-la en ta propre force"
  },
  Event_6938_Name = {
    Text = "Point d'extraction"
  },
  Event_6939_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6939_Desc = {
    Text = "Tu as accepté la demande mais tu as rencontré un petit problème.\n\"À quoi ressemble cette sculpture en cire ?\"\n\"C'est un buste de moi, bien sûr, ça me ressemble parfaitement.\"\n\"Mais...\"\n\"Ton visage a depuis longtemps complètement pourri. Tu ne le sais pas ?\""
  },
  Event_6939_Name = {Text = "Mon buste"},
  Event_6940_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6940_Desc = {
    Text = "Tu serres fermement la main de ton compagnon à côté de toi, Ramona te regarde avec curiosité, mais elle finit par tolérer ton impolitesse"
  },
  Event_6940_Name = {
    Text = "Prière du Rêve"
  },
  Event_6941_ChoiceDesc1 = {
    Text = "[Ask Who It Is] Choisissez 1 des 3 cartes de commandement pour gagner une Oraison : \"(EnchantConfig.Arg1)\", et infectez avec \"(Skill.Arg2)\""
  },
  Event_6941_ChoiceDesc2 = {
    Text = "[Regarder dans les yeux] Choisissez 1 réveilleur, infectez[(Skill.Arg1)]"
  },
  Event_6941_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_6941_Desc = {
    Text = "La sensation d'être observé avec intensité te fait t'arrêter. \n « Qui est-ce ? » Tu regardes dans le brouillard, « Jenkins, est-ce toi ? » \n La brume est épaisse, des cris de corps de fusion résonnent faiblement au fond de la cour. Tu ne trouves rien, tu fais demi-tour, mais faillis heurter un œil suspendu dans les airs."
  },
  Event_6941_Name = {
    Text = "Regard aveugle"
  },
  Event_6942_ChoiceDesc1 = {
    Text = "[Ne pas toucher aux pièces de monnaie] Un carte de commandement aléatoire reçoit une oraison : [(EnchantConfig.Arg1) ]"
  },
  Event_6942_ChoiceDesc2 = {
    Text = "[Toucher la pièce de monnaie] augmentez Arg1 points de santé max, et infectez[(Skill.Arg2)]"
  },
  Event_6942_Desc = {
    Text = "Vous trouvez une vieille pièce de monnaie enfouie dans la boue noire.\nD'un côté, des veines bleu-rouge sont gravées, de l'autre, un portrait en relief d'une duchesse immaculée souriant, ses yeux pâles bougeant légèrement avant de tourner frénétiquement"
  },
  Event_6942_Name = {
    Text = "Pièce antique à double face"
  },
  Event_6943_ChoiceDesc1 = {
    Text = "[Se Retourner] Gagner 25 sigils noirs"
  },
  Event_6943_ChoiceDesc2 = {
    Text = "[Keep Going] Obtenez une Relique d'Argent \"(RelicConfig.Arg1)\" et infectez \"(Skill.Arg2)\""
  },
  Event_6943_Desc = {
    Text = "Ça recommence, ce bruit de pas étrange. \n Il te suit de près, du studio au bureau du directeur, puis du bureau du directeur au sous-sol. \n Tu sais que c'est un gars prudent. \n Il prend soin de maintenir une distance entre vous, pas trop loin, mais sans être intrusif. \n Pourtant, cela te perturbe profondément."
  },
  Event_6943_Name = {Text = "pas"},
  Event_6944_ChoiceDesc1 = {
    Text = "[Observe It] Gagnez 25 sigils noirs"
  },
  Event_6944_ChoiceDesc2 = {
    Text = "[Pet It] 50% de chances de gagner 50 Sigils Noirs, 50% de chances de ne rien obtenir"
  },
  Event_6944_Desc = {
    Text = "Dans une ruelle, un chat noir surgit soudainement et s'enroule chaleureusement autour de vos jambes. Ses pupilles verticales d'un vert spectral scintillent d'une lueur inquiétante, comme s'il disait : « Ne le poursuivez plus, jouez avec moi un moment. »\n « Vous l'avez déjà vu. Il est juste à vos côtés, ces ombres corrompues par la folie, empreintes de ferveur... Ne fixez pas les contours de sa silhouette. »"
  },
  Event_6944_Name = {Text = "Nuit-elfe"},
  Event_6945_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6945_Desc = {
    Text = "Les corps éveillés attendent vos ordres, vous n'avez pas de temps à perdre"
  },
  Event_6945_Name = {
    Text = "angle d'origine"
  },
  Event_6946_ChoiceDesc1 = {
    Text = "[Check the Film] Infectez \"(Skill.Arg1)\", gagnez la Relique d'or \"(RelicConfig.Arg2)\""
  },
  Event_6946_ChoiceDesc2 = {
    Text = "[Check Camera] Gagnez 50 sigils noirs"
  },
  Event_6946_Desc = {
    Text = "Comme si on arrachait des entrailles, le film dans le ventre de l'appareil photo a été déchiré et abandonné ici, ouvert et abandonné, sans que personne ne s'y intéresse. \n Une lumière blanche éblouissante a traversé, l'appareil photo abandonné au coin de la rue était incliné, le déclencheur pressé sans raison. \n « Clic — » \n Ton expression de choc et de stupéfaction a été fidèlement enregistrée sur le film de l'appareil."
  },
  Event_6946_Name = {
    Text = "Enregistrer sans culpabilité"
  },
  Event_6947_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6947_Desc = {
    Text = "C'est juste le bruit du vent secouant les chaînes, rien d'inquiétant, ignore-le"
  },
  Event_6947_Name = {
    Text = "Après la porte en fer"
  },
  Event_6948_ChoiceDesc1 = {
    Text = "[Choisir] Infectez[(Skill.Arg1)]"
  },
  Event_6948_ChoiceDesc2 = {
    Text = "[Choisir] Infectez[(Skill.Arg1)]"
  },
  Event_6948_ChoiceDesc3 = {
    Text = "[Choisir] Infectez[(Skill.Arg1)]"
  },
  Event_6948_Desc = {
    Text = "\"Je\" suis unique, irremplaçable à travers des millions d'univers."
  },
  Event_6948_Name = {
    Text = "Résonance d'âmes"
  },
  Event_6949_ChoiceDesc1 = {
    Text = "[Claim] Select 1 Silver Relic"
  },
  Event_6949_Desc = {
    Text = "Alors peut-être que c'était « moi ».\nÀ travers l'ombre du temps, à travers les barrières dimensionnelles, « moi » me regardant à travers une fissure"
  },
  Event_6949_Name = {
    Text = "Résonance d'âmes"
  },
  Event_6950_ChoiceDesc1 = {
    Text = "[Montrer le problème] Choisissez 1 carte de commandement parmi 3 pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_6950_ChoiceDesc2 = {
    Text = "[avale les questions] contamine[(Skill.Arg1)], réimprime, encore une fois 1 fois"
  },
  Event_6950_Desc = {
    Text = "Pour ces jeunes filles, c'est aussi un secret difficile à dire.\nVous avez avalé vos questions, mais elle caresse son cœur et commence à raconter un rêve qui a duré vingt-cinq ans, parlant de son isolement après la fin du rêve"
  },
  Event_6950_Name = {
    Text = "Vie Enchaînée"
  },
  Event_6951_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6951_Desc = {
    Text = "Tu jettes les papiers et les copeaux de bois dans les flammes. Les flammes les dévorent avidement, puis émettent un rot de satisfaction. Elles sont prêtes à détruire le monde, mais te laissent une bénédiction avant de partir"
  },
  Event_6951_Name = {Text = "Feu faible"},
  Event_6952_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6952_Desc = {
    Text = "Tu éteins impitoyablement la dernière étincelle de haine, et le ressentiment ambiant semble s'atténuer"
  },
  Event_6952_Name = {Text = "Feu faible"},
  Event_6953_ChoiceDesc1 = {
    Text = "[Chasser les corbeaux] obtenir Arg1 sigils noirs, infecter[(Skill.Arg2)]"
  },
  Event_6953_ChoiceDesc2 = {
    Text = "[Ignorez] Partez"
  },
  Event_6953_Desc = {
    Text = "Tu veux attraper le corbeau, mais il vole d'un bout à l'autre de la chambre, émettant des cris étranges. Là où il passe, un liquide noir laisse des marques"
  },
  Event_6953_Name = {
    Text = "Lanterne Corbeau"
  },
  Event_6954_ChoiceDesc1 = {
    Text = "[Leave] Obtiens la Relique \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_6954_Desc = {
    Text = "«Tu sais bien saisir l'essentiel, » dit l'homme avec un sourire éclatant, « c'est la nourriture la plus délicieuse du monde, digne d'être soigneusement préparée et dégustée par chaque Taotie. »\n« Malheureusement, je ne peux pas te laisser essayer cette fois. En compensation, j'ai d'autres délices à te donner. »\nAprès avoir dit cela, l'homme jette un morceau de chair tendre et rouge. La chair atterrit sur le pont, ses tentacules visqueux se tortillent et se déplacent. Quand tu relèves les yeux, l'homme a déjà disparu derrière les structures en acier entremêlées, laissant aucune trace."
  },
  Event_6954_Name = {
    Text = ": Compagnon étrange VI"
  },
  Event_6955_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6955_Desc = {
    Text = "Démêler les fils, progresser étape par étape, c'est ta spécialité.\nL'éclair d'inspiration rend ton esprit clair, tu vois la réalité actuelle—\nPeu importe qui manipule les marionnettes, s'échapper, survivre"
  },
  Event_6955_Name = {
    Text = "Inspiration soudaine"
  },
  Event_6956_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6956_Desc = {
    Text = "Le papillon se brise dans ta main, comme un plafond de verre fracassé, les morceaux tombent, tombent, tombent"
  },
  Event_6956_Name = {
    Text = "Illusion Ferroviaire"
  },
  Event_6957_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6957_Desc = {
    Text = "Voyant que Ramona ne veut pas s'approcher, le chat secoue la tête et disparaît en une ombre"
  },
  Event_6957_Name = {
    Text = "Résidents Nomades"
  },
  Event_6958_ChoiceDesc1 = {
    Text = "[Make a promise] Obtenir une relique argent \"(RelicConfig.Arg1)\" et infecter \"(Skill.Arg2)\""
  },
  Event_6958_ChoiceDesc2 = {
    Text = "[Refuse] Obtenez une Relique d'Argent \"(RelicConfig.Arg1)\" et devenez infecté par \"(Skill.Arg2)\""
  },
  Event_6958_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_6958_Desc = {
    Text = "«C'était vraiment un souvenir inoubliable. \nMa tête et mes membres ont été enfoncés avec force dans le plâtre. \nL'étranglement et l'illusion de mort imminente m'enveloppent profondément, me tirant avec force et me jetant sur la côte des ténèbres. \nJe le regarde, sentant qu'une partie de moi a également été emportée. \nCette autre moitié perdue de mon âme réside depuis lors dans cette petite statue de cire, la première. \nAlors... peux-tu m'aider à retrouver mon buste ?»"
  },
  Event_6958_Name = {Text = "Mon buste"},
  Event_6959_ChoiceDesc1 = {
    Text = "[Leave] Obtenir 1 parmi 3 Oraisons Avancées"
  },
  Event_6959_Desc = {
    Text = "Tu es un spectateur de la mémoire, tu ne peux que regarder la fille tomber dans la mer sombre.\nL'eau pousse sa jupe vers le haut, mais elle coule, comme une fleur non éclose"
  },
  Event_6959_Name = {Text = "Sombrer"},
  Event_6960_ChoiceDesc1 = {
    Text = "[Insert Silver Key]"
  },
  Event_6960_Desc = {
    Text = "La d-boue sursaturée semble renfermer certaines substances... observe avec la clé en argent et transforme-la en ta propre force"
  },
  Event_6960_Name = {
    Text = "Point d'extraction"
  },
  Event_6961_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6961_Desc = {
    Text = "Ne prête pas attention aux tentations de l'ennemi, cela pourrait être un piège"
  },
  Event_6961_Name = {
    Text = "Corbeau maudit"
  },
  Event_6962_ChoiceDesc1 = {Text = "[Aidez-le]"},
  Event_6962_ChoiceDesc2 = {
    Text = "[Observe Coldly]"
  },
  Event_6962_Desc = {
    Text = "Le garçon se tenait sur la scène, une lumière pâle brilla sur son visage.\n\"D- dédié à...\"\nLe visage du garçon devint rouge. Il ouvrit la bouche mais ne pu prononcer un son.\nSa bouche béante s'ouvrait de plus en plus..."
  },
  Event_6962_Name = {
    Text = "Cérémonie finale III"
  },
  Event_6963_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6963_Desc = {
    Text = "« Quelle horreur, quelle horreur ! » Comme si tu avais touché un interrupteur, le chat noir révèle soudainement son côté féroce, ouvrant la bouche pour mordre ton bras. Heureusement, tu évites à temps, il ne fait que déchirer un coin de ton vêtement. Le chat noir s'élance vers le coin de la rue et disparaît dans le caniveau de la ruelle."
  },
  Event_6963_Name = {Text = "Nuit-elfe"},
  Event_6964_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6964_Desc = {
    Text = "Enveloppé par les pensées tourbillonnantes, tu ouvres la porte et empruntes un chemin sans retour.\nLa lumière blanche brûlante à l'extérieur est-elle la rédemption ou la destruction ?"
  },
  Event_6964_Name = {
    Text = "Au-delà des portes multiples"
  },
  Event_6965_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6965_Desc = {
    Text = "Tu oses t'approcher pour examiner, et le mucus sur la table se fend soudainement, révélant ce qu'il cache"
  },
  Event_6965_Name = {
    Text = "Au-delà des portes multiples"
  },
  Event_6966_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6966_Desc = {
    Text = "Avaler sa salive, réprimer ses questions, se concentrer sur l'ennemi.\nLaisser les papillons rester dans ton corps, même si leurs battements d'ailes déchirent tes organes"
  },
  Event_6966_Name = {
    Text = "Effet papillon"
  },
  Event_6967_ChoiceDesc1 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_6967_Desc = {
    Text = "Le chat hoche la tête avec satisfaction, puis disparaît en une ombre, laissant quelques objets noirs ronds"
  },
  Event_6967_Name = {
    Text = "Résidents Nomades"
  },
  Event_6968_ChoiceDesc1 = {
    Text = "[Insert Silver Key]"
  },
  Event_6968_Desc = {
    Text = "La d-boue sursaturée semble renfermer certaines substances... observe avec la clé en argent et transforme-la en ta propre force"
  },
  Event_6968_Name = {
    Text = "Point d'extraction"
  },
  Event_6969_ChoiceDesc1 = {
    Text = "[Partir] Obtient 1 relique en or aléatoire, infection[(Skill.Arg1)]"
  },
  Event_6969_Desc = {
    Text = "Voyant votre hésitation, Koom se jeta sur le tas de terre, creusa rapidement avec ses pattes avant et poussa quelque chose devant vous"
  },
  Event_6969_Name = {
    Text = "Objet enfoui"
  },
  Event_6970_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6970_Desc = {
    Text = "Le papier est imprimé avec \"Mérimée\", il n'y a jamais eu de Mason.\nÊtre trop méfiant n'est pas bon signe, gardien du secret"
  },
  Event_6970_Name = {
    Text = "Machine à écrire"
  },
  Event_6971_ChoiceDesc1 = {
    Text = "[Partir] Obtient 3 choix 1 relique en or, infection[(Skill.Arg1)]"
  },
  Event_6971_Desc = {
    Text = "Des sculptures de l'association des sculpteurs sont enterrées dans le monticule de terre, en des actes impardonnables"
  },
  Event_6971_Name = {
    Text = "Objet enfoui"
  },
  Event_6972_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6972_Desc = {
    Text = "Les oiseaux ont leurs propres règles, ils n'agissent pas selon ta volonté, et tu n'as pas le droit d'interférer avec les lois de la nature"
  },
  Event_6972_Name = {
    Text = "Corbeau Solitaire"
  },
  Event_6973_ChoiceDesc1 = {
    Text = "[Partir] Obtient 3 choix 1 relique en or, infection[(Skill.Arg1)]"
  },
  Event_6973_Desc = {
    Text = "Pourquoi, pourquoi a-t-il coulé ?\nCe jour-là, il n'y avait ni orage ni tempête. Le ciel nocturne était clair, sans étoiles, la pleine lune basse sur l'horizon, comme un soleil glacé"
  },
  Event_6973_Name = {Text = "Sombrer"},
  Event_6974_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6974_Desc = {
    Text = "« Chef de train ! Nous subissons une attaque terroriste ! ... Zzz... »\n On dirait que c'est l'appel de rapport du pilote, tu comptais raccrocher. \n « Répétez, ici est l'équipe extérieure quatre du Mizag, nous avons rencontré ... Ah ! »\n Le ton au téléphone est devenu un chuchotement rauque, mêlé à des cris perçants et terrifiants. \n « Le sacrement est accompli. Oh agneau égaré, que ce bain sacré purifie ton âme ... »"
  },
  Event_6974_Name = {
    Text = "Train en approche"
  },
  Event_6975_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6975_Desc = {
    Text = "Collecter des noyaux d'argent est aussi une tâche du Gardien.\nLes âmes dérivant dans les cristaux purs reviendront un jour sous une nouvelle forme"
  },
  Event_6975_Name = {Text = "Âme Liée"},
  Event_6976_ChoiceDesc1 = {
    Text = "[Continuer à tomber] une carte de commande aléatoire obtient oraison:[(EnchantConfig.Arg1)], souhaitez-vous continuer à tomber"
  },
  Event_6976_ChoiceDesc2 = {
    Text = "[Éloignez-vous] Gagner 25 Sigils Noirs"
  },
  Event_6976_Desc = {
    Text = "«Tu» t'invite plus profondément.\nAu fond de la spirale, le «toi» du passé et du futur t'offre des «cadeaux» de différentes dimensions."
  },
  Event_6976_Name = {
    Text = "Abysses en spirale"
  },
  Event_6977_ChoiceDesc1 = {
    Text = "[Lean Out] Infection \"(Skill.Arg1)\", gagnez une Relique d'Or \"(RelicConfig.Arg2)\""
  },
  Event_6977_ChoiceDesc2 = {
    Text = "[Abandonnez la Vérification] Gagnez 50 sigils noirs"
  },
  Event_6977_Desc = {
    Text = "Il semble y avoir un rouleau de film coincé sous la table d'opération"
  },
  Event_6977_Name = {
    Text = "Souvenirs lumineux"
  },
  Event_6978_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6978_Desc = {
    Text = "Ignore les distractions, concentre-toi.\nTu as des choses plus importantes à faire"
  },
  Event_6978_Name = {Text = "Mon buste"},
  Event_6979_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6979_Desc = {
    Text = "Relique sacrée perdue, héritage inestimable, instrument pour réaliser des vœux...\nSeuls les trésors peuvent être aussi séduisants"
  },
  Event_6979_Name = {
    Text = "Méthode de Saisie Mystérieuse"
  },
  Event_6980_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6980_Desc = {
    Text = "『Tu es la 'maman' de Lily, mais tu l'utilises seulement comme un outil pour la recherche et le combat, 』 tu réponds, 『un enfant en bas âge pourrait peut-être obéir à sa mère, mais tu ne devrais pas être la 'maman' de Lily.』"
  },
  Event_6980_Name = {Text = "Son choix"},
  Event_69813_ChoiceDesc1 = {Text = "[Leave]"},
  Event_69813_Desc = {
    Text = "La clé en argent brille, les bras semblent stupéfaits par une forme de pouvoir, s'enfonçant dans l'eau de la piscine, puis disparaissant"
  },
  Event_69813_Name = {
    Text = "Bassin de souillure"
  },
  Event_69814_ChoiceDesc1 = {Text = "[Leave]"},
  Event_69814_Desc = {
    Text = "Tu t'enfonces de plus en plus, des chuchotements chaotiques de la Volonté Suprême résonnent dans ta tête. Tu fermes les yeux et invoques le pouvoir en toi. \nTout à coup, tous les sons et les sensations étranges disparaissent, tu te tiens derrière la porte, les tentacules sanglants à tes côtés ont disparu, comme s'ils n'avaient jamais existé. \nTu te sens étrangement bien. Tu comprends le prix que tu as payé, mais cela n'a pas d'importance - tu feras face à cette existence suprême dans une forme plus forte."
  },
  Event_69814_Name = {
    Text = "Bassin de souillure"
  },
  Event_69815_ChoiceDesc1 = {Text = "[Leave]"},
  Event_69815_Desc = {
    Text = "L'Éveilleur façonné par tes souvenirs ne tarde pas un instant à te tirer hors du Bassin de souillure, déchirant ton bras connecté, la boue trouble éclabousse, des créatures indiscernables se tordent dans l'eau, le créateur primordial et le destructeur, désireux de dévorer."
  },
  Event_69815_Name = {
    Text = "Bassin de souillure"
  },
  Event_69816_ChoiceDesc1 = {
    Text = "[Call Awakener] Déduire 100 Aliemus de tous les Réveilleurs et retirer 1 Carte de Symptôme."
  },
  Event_69816_ChoiceDesc2 = {
    Text = "[Absorber le bassin de sang] Augmentez Arg1 points de santé max, infectez 2 cartes [(Skill.Arg2)]"
  },
  Event_69816_ChoiceDesc3 = {
    Text = "[Insérer la Clé d'Argent] Dégagez toutes les Clés"
  },
  Event_69816_Desc = {
    Text = "Le pouvoir de la vie se manifeste sous la forme de la mort dans l'œil primordial. Au moment où vous posez le pied sur ce territoire indistinct, la marre de sang fétide apparaît soudainement. \n Le sang rouge-noir tend des bras innombrables, s'agrippant à votre cheville et tirant vers le haut, cherchant à vous traîner dans un abysse imprévisible."
  },
  Event_69816_Name = {
    Text = "Bassin de souillure"
  },
  Event_6981_ChoiceDesc1 = {
    Text = "[Pick Up Key]"
  },
  Event_6981_Desc = {
    Text = "Un trousseau de clés rouillées. Peut ouvrir des serrures"
  },
  Event_6981_Name = {
    Text = "Clé rouillée"
  },
  Event_6982_ChoiceDesc1 = {
    Text = "[Partir] Choisissez de copier 1 carte de commandement, infection[(Skill.Arg1)]"
  },
  Event_6982_Desc = {
    Text = "Sous les chants des marins et les indications célestes, vous regardiez au fond du cabine sombre et insondable — votre survie se trouve-t-elle dans cette obscurité infinie ?"
  },
  Event_6982_Name = {
    Text = "Chant de la mer"
  },
  Event_6983_ChoiceDesc1 = {
    Text = "[Partir ensemble] Obtenir des reliques en argent [(RelicConfig.Arg1) ]"
  },
  Event_6983_ChoiceDesc2 = {
    Text = "[Refuser de partir] Obtenez 75 sigils noirs, contagion[(Skill.Arg2)]"
  },
  Event_6983_Desc = {
    Text = "Est-ce un phantasme ? Vous voyez des corbeaux tournoyer au-dessus, fredonnant une mélodie familière :\n\"Alors partons ensemble, toi et moi,\nAlors que la nuit tombe,\nComme un ivrogne mourant s'effondrant dans la rue.\""
  },
  Event_6983_Name = {
    Text = "Voix des corbeaux"
  },
  Event_6984_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6984_Desc = {
    Text = "Le pouvoir de retracer ne peut pas à nouveau trouver un point de contact pour vous dans un court laps de temps, mais vous avez au moins reçu un apaisement temporaire"
  },
  Event_6984_Name = {
    Text = "Contact Anormal"
  },
  Event_6985_ChoiceDesc1 = {
    Text = "[Fall into the Spiral] Regardez vers la fin de la spirale"
  },
  Event_6985_ChoiceDesc2 = {
    Text = "[Éloignez-vous] Gagner 25 Sigils Noirs"
  },
  Event_6985_Desc = {
    Text = "Le hublot ne révèle plus la surface de la mer.  \nLe verre reflète ton visage pâle, alors que dans ta pupille, « toi » regardes aussi le hublot.  \nLa réalité et le domaine se superposent, s'entrelacent, et finissent par se tordre en une spirale complexe"
  },
  Event_6985_Name = {
    Text = "Abysses en spirale"
  },
  Event_6986_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6986_Desc = {
    Text = "Vous acceptez l'appel de l'école, la voix familière vous apaise. Vous reprenez courage et continuez"
  },
  Event_6986_Name = {
    Text = "Point de contact"
  },
  Event_6987_ChoiceDesc1 = {
    Text = "[Affirmatif]"
  },
  Event_6987_ChoiceDesc2 = {
    Text = "[Indique la négation]"
  },
  Event_6987_ChoiceDesc3 = {
    Text = "[Non-committal]"
  },
  Event_6987_Desc = {
    Text = "« Ça fait longtemps, mes amis. » Vous vous êtes échappés du combat avec les Porteurs de lanternes et avez obtenu un moment de répit, quand soudain vous avez remarqué cet homme aux longs cheveux apparaître à nouveau au bord du chemin, vous souriant et vous saluant, comme si le combat précédent n'avait jamais eu lieu. \n « Comparé à notre dernière rencontre, l'odeur de Cerbère sur vous est devenue beaucoup plus forte. Vous êtes sûrement allé très loin pendant cette période, n'est-ce pas ? » \n"
  },
  Event_6987_Name = {
    Text = ": Compagnon étrange V"
  },
  Event_6988_ChoiceDesc1 = {
    Text = "[Lui demander le Chemin] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infectée par «(Skill.Arg2)»"
  },
  Event_6988_ChoiceDesc2 = {
    Text = "[S'en éloigner] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infectée par «(Skill.Arg2)»"
  },
  Event_6988_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_6988_Desc = {
    Text = "L'ombre se tient sous le lampadaire élancé. \n « Pourriez-vous me prêter une flamme, monsieur ? » \n Tu n'as pas l'habitude de @2, mais cela ne te dérange pas d'utiliser un peu de « magie ». \n Avec ton aide, l'ombre allumera le @2 et l'enfoncera dans le vortex noir sans fond. \n Peu après, tu vois de la fumée blanche s'élever. \n « Ah— » \n L'ombre pousse un soupir de satisfaction."
  },
  Event_6988_Name = {
    Text = "La silhouette sous le réverbère"
  },
  Event_6989_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_6989_Desc = {
    Text = "Dans l'échiquier, ce que vous voyez n'est pas réel\n\nCe qui vous bloque n'est peut-être pas un mur, mais votre curiosité épuisée"
  },
  Event_6989_Name = {
    Text = "Espace Fantôme"
  },
  Event_6990_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6990_Desc = {
    Text = "\"J'ai tellement mal... Sœur Sasha...\"\nTu regardes Sarah, qui protège nerveusement deux enfants, semblant ne pas entendre. \nLa voix s'estompe progressivement."
  },
  Event_6990_Name = {
    Text = "\"Soeur Sasha\""
  },
  Event_6991_ChoiceDesc1 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_6991_Desc = {
    Text = "Tu te lèves et applaudis le garçon. \nSentant ton encouragement, il bombe son petit torse. \nDu sang noir coule de sa bouche, mais il continue de chanter"
  },
  Event_6991_Name = {
    Text = "Cérémonie finale IV"
  },
  Event_6992_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6992_Desc = {
    Text = "Une partie de la tristesse s'évapore, mais les larmes continuent de couler sans fin vers le passé mystique."
  },
  Event_6992_Name = {
    Text = "Larme des Plaines Sombres"
  },
  Event_6993_ChoiceDesc1 = {
    Text = "[Choke the Singer] Infection \"(Skill.Arg1)\", Gagnez une Relique Maudite \"(RelicConfig.Arg2)\""
  },
  Event_6993_ChoiceDesc2 = {
    Text = "[Stumbling Dancer's Steps] Infectez deux fois avec \"(Skill.Arg1)\", recevez la Relique Argent \"(RelicConfig.Arg2)\" et \"(RelicConfig.Arg3)\""
  },
  Event_6993_ChoiceDesc3 = {
    Text = "[Sortir par un chemin détourné] obtenez une relique d'argent[(RelicConfig.Arg1)]"
  },
  Event_6993_Desc = {
    Text = "Tu es bloqué par trois silhouettes visqueuses. \n Une silhouette chante, sa voix rauque, les paroles étranges, tu te couvres les oreilles et l'évites. \n Une silhouette danse, ses mouvements raides, ses pas hésitants, tu fermes les yeux et l'évites. \n Une silhouette récite des poèmes, ses rythmes brisés, ses phrases incohérentes, tu ne peux plus supporter alors——"
  },
  Event_6993_Name = {
    Text = "Brigand sur le Chemin Étroit"
  },
  Event_6994_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6994_Desc = {
    Text = "Une partie de la colère bouillonne, mais les larmes continuent de couler vers un passé inconnu"
  },
  Event_6994_Name = {
    Text = "Larme des Plaines Sombres"
  },
  Event_6995_ChoiceDesc1 = {
    Text = "[Ignorer] Infecté par [(Skill.Arg1)]"
  },
  Event_6995_ChoiceDesc2 = {
    Text = "[Turn away] Réveillez un Réveilleur aléatoire"
  },
  Event_6995_Desc = {
    Text = "Le destin cruel rampe aux pieds du voyageur, le chemin est lisse comme un miroir, un léger craquement se fait entendre derrière.\nQui a brisé le destin sous ses pieds ? Est-ce une illusion, un piège, ou simplement un murmure, un mensonge...\nDevant toi, une fissure se forme lentement.\n<Italic: Comme si elle allait sombrer pour l'éveil de la gnose.>"
  },
  Event_6995_Name = {
    Text = "Crevasse rampante"
  },
  Event_6996_ChoiceDesc1 = {
    Text = "[Essayer le défi] infecter[(Skill.Arg1)], victoire : obtenir 1 relique en or, échec : obtenir 50 sigils noirs"
  },
  Event_6996_ChoiceDesc2 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_6996_Desc = {
    Text = "Tu as vu des secrets dans cette flaque de boue noire réfléchissante.\nSon reflet est flou, entouré d'une brume noire persistante, tu te sens étrangement familier, mais tu ne peux pas l'identifier"
  },
  Event_6996_Name = {
    Text = "Sous la surface du miroir"
  },
  Event_6997_ChoiceDesc1 = {
    Text = "[Imiter un cri de chat] 50 % de chances d'obtenir 125 le sigil noir, 50 % de chances d'infection[(Skill.Arg2)]"
  },
  Event_6997_ChoiceDesc2 = {
    Text = "[Nourrir] 75 % de chances d'obtenir 100 sigils noirs, 25 % de chances de contagion[(Skill.Arg2)]"
  },
  Event_6997_ChoiceDesc3 = {
    Text = "[Run Away] Gagnez 50 Sigils Noirs"
  },
  Event_6997_Desc = {
    Text = "Tu es tombé sur le territoire du chat noir.\nDes yeux s'ouvrent soudain dans l'obscurité, avec curiosité, examen, vigilance... mais sans aucune bienveillance.\nÉmeraude, ambre jaune, bleu paon...\nTu as l'impression d'être dans une mer étincelante de joyaux.\nPour te sortir de là, tu—"
  },
  Event_6997_Name = {
    Text = "Ville des chats"
  },
  Event_6998_ChoiceDesc1 = {
    Text = "[À propos de Jonquille] Obtenez aléatoirement des oraisons sur 2 cartes d'ordre : \"(EnchantConfig.Arg1)\", \"(EnchantConfig.Arg2)\""
  },
  Event_6998_ChoiceDesc2 = {
    Text = "[au sujet des chiens des enfers] obtenez une relique maudite [(RelicConfig.Arg1)]"
  },
  Event_6998_ChoiceDesc3 = {
    Text = "[À propos de Lily] Infecter [(Skill.Arg1)]"
  },
  Event_6998_Desc = {
    Text = "\"C'est l'heure des indices de Daffodil.\""
  },
  Event_6998_Name = {
    Text = "Temps restant"
  },
  Event_6999_ChoiceDesc1 = {
    Text = "[Let Pointer] Obtiens une Relique d'Or \"(RelicConfig.Arg1)\" et infecte \"(Skill.Arg2)\""
  },
  Event_6999_ChoiceDesc2 = {
    Text = "[Hold Pointer] Obtenez la relèque en or \"(RelicConfig.Arg1)\" et infectez \"(Skill.Arg2)\""
  },
  Event_6999_ChoiceDesc3 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_6999_Desc = {
    Text = "Clic, clic, click...\nLe compte à rebours fatal avance, le mécanisme cliquète froidement, allant vers une direction que tu ne veux absolument pas voir"
  },
  Event_6999_Name = {
    Text = "Au-delà de l'extrémité de l'aiguille"
  },
  Event_7000_ChoiceDesc1 = {
    Text = "[Faire la Sourde Oreille] Obtenir 3 cartes de commande aléatoires du plateau, choisir 1 à retirer, et gagner 75 sigils noirs."
  },
  Event_7000_ChoiceDesc2 = {
    Text = "[Carefully Inspect] Obtenez 3 cartes de commande aléatoires du paquet, choisissez 1 carte originale à ajouter au paquet et gagnez 25 sigils noirs."
  },
  Event_7000_ChoiceDesc3 = {
    Text = "[Tourner et Partir] Gagner 50 sigils noirs"
  },
  Event_7000_Desc = {
    Text = "Le destin cruel rampe aux pieds du voyageur, le chemin est lisse comme un miroir, un léger craquement se fait entendre derrière.\nQui a brisé le destin sous ses pieds ? Est-ce une illusion, un piège, ou simplement un murmure, un mensonge...\nDevant toi, une fissure se forme lentement"
  },
  Event_7000_Name = {
    Text = "Crevasse rampante"
  },
  Event_7001_ChoiceDesc1 = {
    Text = "[appelle le corbeau] obtient 25 le sigil noir, contamine[(Skill.Arg2)], choix supplémentaire"
  },
  Event_7001_ChoiceDesc2 = {
    Text = "[S'éloigner]"
  },
  Event_7001_Desc = {
    Text = "Les griffes déchirent la cape et s'enfoncent profondément dans l'épaule"
  },
  Event_7001_Name = {
    Text = "Corbeau Solitaire"
  },
  Event_7002_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7002_Desc = {
    Text = "La peur ne provient parfois pas d'une entité.\nLà où passe le « chien des enfers », des gouttes rouges subsistent, reflétant ton contour"
  },
  Event_7002_Name = {
    Text = "Reflet immatériel"
  },
  Event_7003_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7003_Desc = {
    Text = "Accompagné d'un léger courant, tu entends le chuchotement d'une femme. \n Elle pleure, racontant sans relâche ses mésaventures. \n Une heure passe, un jour passe... jusqu'à ce que tu aies déjà oublié pourquoi elle est triste. \n Enfin, elle raccroche joyeusement, promettant de t'offrir un grand cadeau. \n Tu acceptes le cadeau. Quoi qu'il en soit, un cadeau est toujours agréable."
  },
  Event_7003_Name = {
    Text = "Veuillez répondre au téléphone"
  },
  Event_7004_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7004_Desc = {
    Text = "Sous les regards perplexes de tes compagnons, tu t'agenouilles, la tête baissée, et poses ton poing droit sur ton front.\nParfait, cela cache bien ton visage"
  },
  Event_7004_Name = {
    Text = "Faux pour vrai"
  },
  Event_7005_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7005_Desc = {
    Text = "«Tu m'as déjà drapée d'un voile.»\nLa statue de cire te sourit paisiblement.\n«Je t'offre la vérité en récompense de ton travail acharné.»\nSon ventre déverse continuellement une boue noire, t'enveloppant étroitement.\nLe monde est plongé dans l'obscurité, mais d'une chaleur incroyable.\nTu te recroquevilles et bâilles, entrant dans le rêve pour la @1 fois..."
  },
  Event_7005_Name = {
    Text = "Statue de cire inachevée"
  },
  Event_7006_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_7006_Desc = {
    Text = "Tu n'as rien trouvé dans la brume"
  },
  Event_7006_Name = {
    Text = "Brouillard du Chaos"
  },
  Event_7007_ChoiceDesc1 = {
    Text = "[Répondre au Téléphone] Obtenez une oraison avancée à 3 choix"
  },
  Event_7007_ChoiceDesc2 = {
    Text = "[Ignore Bell] Obtenez la relèque en or \"(RelicConfig.Arg1)\" et infectez \"(Skill.Arg2)\""
  },
  Event_7007_ChoiceDesc3 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_7007_Desc = {
    Text = "\"Ding ding ding...\"\nUne sonnerie de téléphone perçante provenait du coin, urgente et bruyante, chaque sonnerie étant plus forte que la précédente, vous donnant presque l'illusion que si vous ne répondiez pas, cela deviendrait immédiatement fou et exploserait, détruisant ainsi le monde.\""
  },
  Event_7007_Name = {
    Text = "Veuillez répondre au téléphone"
  },
  Event_7008_ChoiceDesc1 = {
    Text = "[Approach Phantasm] Obtenez 1 des 3 reliques argentées"
  },
  Event_7008_ChoiceDesc2 = {
    Text = "[Break Phantasm] Obtenir la Relique en argent \"(RelicConfig.Arg1)\"\"(RelicConfig.Arg2)\", infecter deux fois \"(Skill.Arg3)\""
  },
  Event_7008_Desc = {
    Text = "Est-ce un mirage dans le labyrinthe ? Ou est-ce un autre souvenir dont il est impossible de s'échapper ?\n Tu frottes tes yeux, la vision au loin se rapproche de toi - c'est un marché grouillant de monde, c'est un musée de cire disparu dans la fusion, c'est un asile de fous dans un petit village battu par le vent et la neige, ou c'est un Akute dont le paysage est déjà flou ?"
  },
  Event_7008_Name = {Text = "Mirage"},
  Event_7009_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7009_Desc = {
    Text = "Comme brûlé par de l'eau bouillante, tu couvres tes oreilles par réflexe, bloquant la musique maléfique"
  },
  Event_7009_Name = {
    Text = "Voix interdite"
  },
  Event_7010_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7010_Desc = {
    Text = "Un air majeur lumineux dissipa la tension et la peur. Tu étais plein d'enthousiasme, prêt à éclore, joyeux, laissant Ramona loin derrière - \"Gardien ?! Ne va pas si vite !\""
  },
  Event_7010_Name = {
    Text = "Son Inconnu"
  },
  Event_7011_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7011_Desc = {
    Text = "\n«Arrêtez-vous là!!! Même le monstre en dissolution qui rampe sur son ventre connaît mieux ses propres membres que vous!» \nLaissez le public... \nVous priez cela dans votre cœur"
  },
  Event_7011_Name = {
    Text = "Brigand sur le Chemin Étroit"
  },
  Event_7012_ChoiceDesc1 = {Text = "[Withdraw]"},
  Event_7012_Desc = {
    Text = "C'est juste un domaine.\nCe que vous voulez protéger et fuir est une réalité unique"
  },
  Event_7012_Name = {
    Text = "Abysses en spirale"
  },
  Event_7013_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7013_Desc = {
    Text = "«Tu es le plus détestable.»\nTu déchires la feuille en morceaux, les laissant s'envoler dans le vent, se transformant en flocons volants.\nLe poète lève la tête pour voir les caractères danser dans le vent, un sourire d'obsession se dessine sur ses lèvres.\n«C'est si beau...»"
  },
  Event_7013_Name = {
    Text = "Brigand sur le Chemin Étroit"
  },
  Event_7014_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7014_Desc = {
    Text = "Vous déchirez l'affiche en entier et découvrez que l'arrière est griffonné avec les diverses dépenses du musée de cire. \n Le propriétaire de l'écriture n'a manifestement ni patience ni talent pour les mathématiques, ces comptes ne peuvent de toute façon pas être équilibrés. \n Vous jetez un coup d'œil rapide, la plus grande dépense semble être pour « l'entretien et le nettoyage des statues de cire ». \n Les dépenses pour le personnel sont ridiculement faibles, la dépense la plus récente concerne 12 fouets en crin de cheval, coûtant environ 20 Lavka. \n Il y a aussi une dépense spéciale - « leur nourriture ». \n Qui sont « eux » ?"
  },
  Event_7014_Name = {
    Text = "Rires dans les ténèbres"
  },
  Event_7015_ChoiceDesc1 = {
    Text = "[Leave] Obtiens une Relique d'Argent \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_7015_Desc = {
    Text = "\"Rusé... et une réponse correcte.\"\nLa voix semblait intriguée par la réponse, alors qu'un objet argenté émergeait de l'eau.\n\"Rappelez-vous, tout a un prix.\""
  },
  Event_7015_Name = {
    Text = "Voix hors du monde"
  },
  Event_7016_ChoiceDesc1 = {
    Text = "[Catch the Second Butterfly] Supprimez 1 carte de commande, gagnez Arg1 sigil noir"
  },
  Event_7016_ChoiceDesc2 = {
    Text = "[No Longer Lingers]"
  },
  Event_7016_Desc = {
    Text = "Sont-ils des habitants de la dimension spirituelle ? Ou des êtres nés de l'érosion ?\nAvec ces questions, vous entrez dans une tempête de papillons"
  },
  Event_7016_Name = {
    Text = "Tempête de Connaissance"
  },
  Event_7017_ChoiceDesc1 = {
    Text = "[Observer le troisième papillon] Retirer 1 carte de commande et gagner Arg1 sigils noirs."
  },
  Event_7017_ChoiceDesc2 = {
    Text = "[No Longer Lingers]"
  },
  Event_7017_Desc = {
    Text = "Une douleur insupportable se propage depuis le bout des doigts, vous lâchez soudainement prise"
  },
  Event_7017_Name = {
    Text = "Tempête de Connaissance"
  },
  Event_7018_ChoiceDesc1 = {
    Text = "[Partir] Obtient 25 sigils noirs, infection[(Skill.Arg1)]"
  },
  Event_7018_Desc = {
    Text = "\"Vous, les humains, n'avez pas d'autres réponses ?\"\nLe propriétaire de la voix laissa échapper un grognement impatient, faisant trembler tout l'espace.\n\"Avide et ignorant... C'est pourquoi je suis fatigué de vous.\""
  },
  Event_7018_Name = {
    Text = "Voix hors du monde"
  },
  Event_7019_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7019_Desc = {
    Text = "\"Ne vous inquiétez pas, je viens juste de donner un peu de punition à l'invité avide. Je ne peux pas y faire grand-chose — je n'aime pas la bière~\""
  },
  Event_7019_Name = {
    Text = "Fragments de souvenirs : Bière"
  },
  Event_7020_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7020_Desc = {
    Text = "<Stop singing—>\nVous mettez en garde le chanteur qui a l'oreille dure, refusant de les laisser torturer vos oreilles plus longtemps."
  },
  Event_7020_Name = {
    Text = "Brigand sur le Chemin Étroit"
  },
  Event_7021_ChoiceDesc1 = {
    Text = "[Leave] Choisissez de Réveiller 2 Réveils"
  },
  Event_7021_Desc = {
    Text = "Tu te retournes et te perds dans le long couloir. \nLes couloirs sans fin épuisent ta patience, jusqu'à ce que tu trouves une petite scène délabrée.\nTu clignes des yeux, et la scène disparaît"
  },
  Event_7021_Name = {
    Text = "Cérémonie finale II"
  },
  Event_7022_ChoiceDesc1 = {
    Text = "[Élever le Gobelet] Gagner une carte spéciale"
  },
  Event_7022_Desc = {
    Text = "Un verre de liquide doré, clair comme les derniers rayons du soleil couchant et ondulant comme les champs de blé en fin d'automne, dégage un parfum doux et séduisant, semblable à celui du miel. Quels en sont les ingrédients ? Qui l'a placé ici ? Pourquoi personne ne s'en occupe-t-il ?\nAvant que ces questions ne trouvent réponse, une pensée mystérieuse grimpe dans ton esprit : tu dois le boire immédiatement, sans attendre.\nEn cet instant, tu te transformes en un papillon de nuit attiré par les flammes, en un insecte piégé par une plante carnivore, ne pouvant résister à l'envie de saisir ce verre de vin doux —"
  },
  Event_7022_Name = {
    Text = "Vin doux au miel"
  },
  Event_7023_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7023_Desc = {
    Text = "Tu essaies d'examiner cette porte, mais elle disparaît au toucher, et tu entends un bruit d'ouverture au loin"
  },
  Event_7023_Name = {
    Text = "Porte Étrange"
  },
  Event_7024_ChoiceDesc1 = {
    Text = "[No Action]"
  },
  Event_7024_ChoiceDesc2 = {
    Text = "[Wipe Palm Print]"
  },
  Event_7024_Desc = {
    Text = "Le bureau de Francis est froid et bien rangé, reflétant le souci du détail de son propriétaire. \n Dans un coin, vous découvrez un empreinte de poussière de 5 pouces de côté. \n La forme de l'empreinte est étrange : le contour extérieur ressemble à une empreinte de bête, tandis qu'au centre se trouve la petite empreinte d'une main d'enfant. On dirait qu'une empreinte humaine a d'abord été laissée, puis qu'une gigantesque patte de bête l'a recouverte. \n Vous pouvez bien sûr imaginer une scène réconfortante, où une bête apprivoisée et soumise place ses griffes sur le dos de la main de la fille pour lui offrir une douce caresse. \n Mais vous connaissez la vérité : c'est la marque laissée par un monstre fusionné par des expériences cruelles."
  },
  Event_7024_Name = {
    Text = "Empreinte de géant"
  },
  Event_7025_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7025_Desc = {
    Text = "Les sujets errants vous épuisent, un bref répit est comme une pluie dans un désert aride"
  },
  Event_7025_Name = {
    Text = "Porte infinie"
  },
  Event_7026_ChoiceDesc1 = {
    Text = "[Master] Obtenu une relique maudite \"(RelicConfig.Arg1)\", infecté avec \"(Skill.Arg2)\""
  },
  Event_7026_ChoiceDesc2 = {
    Text = "[L'emporter] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : [(EnchantConfig.Arg1)]"
  },
  Event_7026_ChoiceDesc3 = {
    Text = "[Disassemble It] Gagnez 50 Sigils Noirs"
  },
  Event_7026_Desc = {
    Text = "Alors que tu avances, tu heurtes quelque chose du pied.\nC'était une boussole, le globe en verre brisé, et le reste est couvert de d-boue. Tu l'es retournes précautionneusement, et tu aperçois à peine le blason de l'université de Mythag gravé au dos"
  },
  Event_7026_Name = {Text = "Son choix"},
  Event_7027_ChoiceDesc1 = {
    Text = "[Lire la Lettre] Retirer 1 carte de commande, gagner Arg1 sigils noirs"
  },
  Event_7027_ChoiceDesc2 = {
    Text = "[Close the Box]"
  },
  Event_7027_Desc = {
    Text = "Une lettre, une autre, encore une. \n Le papier à lettres est rempli de ton passé et dessine ton avenir. Sous l'influence étrange, tu ne peux t'empêcher de déchirer et d'avaler le papier à lettres. \n « Hé ? Tu es encore en train de faire quoi ? Boire de l'air ? » \n Murphy te réveille d'un coup de pied, et quand tu reprends tes esprits, il n'y a rien devant toi."
  },
  Event_7027_Name = {
    Text = "Lettre inattendue"
  },
  Event_7028_ChoiceDesc1 = {
    Text = "[Leave] Obtenir 1 parmi 3 Oraisons"
  },
  Event_7028_Desc = {
    Text = "En entendant votre voix, la silhouette s'arrête ; la voix de Clementine parvient à peine à traverser le brouillard dense.\n« Oh — c'est vous », dit-elle, indistincte et vaporeuse, comme le clair de lune se dissolvant dans l'eau. « Ne vous inquiétez pas, tout ira bien » — c'est une belle pensée, mais difficile à croire.\n« Une fois que vous aurez terminé ici, nous nous reverrons. »"
  },
  Event_7028_Name = {
    Text = "Figure dans la brume"
  },
  Event_7029_ChoiceDesc1 = {
    Text = "[Destinataire : Bureau Scolaire] Obtenir une relique d'argent [(RelicConfig.Arg1)]"
  },
  Event_7029_ChoiceDesc2 = {
    Text = "[Destinataire : Partenaire] Obtenir une relique d'argent [(RelicConfig.Arg1)]"
  },
  Event_7029_Desc = {
    Text = "En écrivant le nom du destinataire, le papier se consume en fumée. Une main invisible traverse le vide et arrache le papier de tes mains—\naccompagnée d'un bruit de mastication, ton corps devient lourd.\nMais la création en main montre que ce voyage n'est pas sans gain"
  },
  Event_7029_Name = {
    Text = "Confession unilatérale"
  },
  Event_7030_ChoiceDesc1 = {
    Text = "[Insert Silver Key]"
  },
  Event_7030_Desc = {
    Text = "La d-boue sursaturée semble renfermer certaines substances... observe avec la clé en argent et transforme-la en ta propre force"
  },
  Event_7030_Name = {
    Text = "Point d'extraction"
  },
  Event_7031_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7031_Desc = {
    Text = ": Attendons qu'ils sortent de l'ombre"
  },
  Event_7031_Name = {
    Text = "Lanterne Corbeau"
  },
  Event_7032_ChoiceDesc1 = {
    Text = "[appelle le corbeau] obtient 35 le sigil noir, contamine[(Skill.Arg2)], choix supplémentaire"
  },
  Event_7032_ChoiceDesc2 = {
    Text = "[S'éloigner]"
  },
  Event_7032_Desc = {
    Text = "Les oiseaux noirs, appelés, gonflent et crachent quelque chose dans ta main.\nIls retournent sur le mât, te fixant intensément"
  },
  Event_7032_Name = {
    Text = "Corbeau Solitaire"
  },
  Event_7033_ChoiceDesc1 = {
    Text = "[Enter Cave]"
  },
  Event_7033_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7033_Desc = {
    Text = "\"Toux, toux, toux...\"\nUne voix si familière... Je m'en souviens, couinement !\nLes humains émettent ce son lorsqu'ils sont malades ou près de la mort !\nDépêchez-vous d'y jeter un œil, couinement !"
  },
  Event_7033_Name = {
    Text = "Profondeurs de la caverne"
  },
  Event_7034_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7034_Desc = {
    Text = "Tu as étudié tout ce qui concerne les cœurs d'argent, y compris comment évaluer leur qualité. \n Évidemment, ces cœurs d'argent ne répondent pas aux exigences de base de raffinage. \n Tu es obligé de les abandonner, ainsi que les âmes brisées qui pourraient y être piégées. \n Apprendre à lâcher prise est aussi une matière essentielle pour le Gardien."
  },
  Event_7034_Name = {Text = "Âme Liée"},
  Event_7035_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7035_Desc = {
    Text = "C'est un passage à sens unique, vous ne pouvez pas revenir à l'entrée par là"
  },
  Event_7035_Name = {Text = "Passage"},
  Event_7036_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7036_Desc = {
    Text = "Finir tôt, tranquillité d'esprit. Les enquêteurs de Missaga ne craignent jamais le danger"
  },
  Event_7036_Name = {
    Text = "Porte infinie"
  },
  Event_7037_ChoiceDesc1 = {
    Text = "[Demander de s'écarter, c'est urgent]"
  },
  Event_7037_ChoiceDesc2 = {
    Text = "[Would Love to Hear More]"
  },
  Event_7037_Desc = {
    Text = "«Étudiant, un instant, s'il vous plaît. Je vois que vous avez l'air préoccupé et que vous êtes pressés, vous êtes peut-être dans une situation difficile. \nCependant, la vie ne devrait pas être abandonnée à cause des impasses du moment, il faut garder une perspective globale et un esprit calme. \nPar exemple, ces derniers jours, j'ai réfléchi sérieusement, et il y a beaucoup d'éléments dans la légende de Cerbère qui ne correspondent pas à la réalité actuelle.»"
  },
  Event_7037_Name = {
    Text = ": Compagnon étrange II"
  },
  Event_7038_ChoiceDesc1 = {
    Text = "[Receive the Gift]"
  },
  Event_7038_ChoiceDesc2 = {
    Text = "[Decline Kindly]"
  },
  Event_7038_Desc = {
    Text = "Un garçon est assis sur le rebord de la fenêtre, vous attendant depuis longtemps.\n« Le spectacle était un succès, merci. »\n« Je dois partir... Voici ton cadeau. »\nIl vous tend une boîte joliment emballée, du sang coulant et colorant ses mains"
  },
  Event_7038_Name = {
    Text = "Cérémonie finale VI"
  },
  Event_7039_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7039_Desc = {
    Text = "Espérons que tu aies toujours cette confiance"
  },
  Event_7039_Name = {
    Text = "Reflet immatériel"
  },
  Event_7040_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7040_Desc = {
    Text = "Tu as accepté cette petite oreille douce. \n Elle est enveloppée dans une cire épaisse et repose tranquillement au creux de ta main. \n Un fort sentiment de responsabilité émerge en toi. \n D'abord, on ne peut pas aller n'importe où dans un bar, la musique y est trop désordonnée. \n Ensuite, il ne faut pas non plus aller au Théâtre Wellington, leur orchestre est déjà dépassé. \n Puis... \n Toi et tes compagnons avez bien accepté le fait d'avoir un petit animal de compagnie en plus."
  },
  Event_7040_Name = {
    Text = "Prête l'oreille"
  },
  Event_7041_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7041_Desc = {
    Text = "« Le professeur Alistair est la pierre angulaire de Mizag, sans lui, tout le système de Mizag cessera de fonctionner. »\n Tu te souviens vaguement d'un cours ennuyeux où Czort, le visage tendu, avait dit cela en frappant le tableau.\n Que feras-tu si cette pierre angulaire s'effondre en morceaux ? Une immense peur t'enveloppe. \n « Où vas-tu ? » L'appel de Ramona te ramène à la réalité. \n Est-ce le passé ou le futur, est-ce réel ou imaginaire, ou est-ce un rêve d'une autre dimension ? Tu ne sais pas non plus. \n Dans ta main, apparaît un « cadeau »."
  },
  Event_7041_Name = {
    Text = "Cri de chaos"
  },
  Event_7042_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7042_Desc = {
    Text = "\"Ce fauteuil roulant est ma deuxième paire de jambes ; je ne pourrai probablement jamais m'en passer dans cette vie,\" dit le professeur Alistair avec un sourire ironique, \"mais le malheureux est que cela m'a rendu beaucoup plus petit.\" \n\nDonc, cela ne peut pas être le véritable professeur Alistair."
  },
  Event_7042_Name = {
    Text = "Cri de chaos"
  },
  Event_7043_ChoiceDesc1 = {
    Text = "[Qui parle ?] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infectée par «(Skill.Arg2)»"
  },
  Event_7043_ChoiceDesc2 = {
    Text = "[Quel Whiskey, laissez-moi Goûter aussi] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infectée par «(Skill.Arg2)»"
  },
  Event_7043_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_7043_Desc = {
    Text = "«Tu ne veux vraiment pas en goûter un peu ? C'est du bon whiskey. Si le patron du bar ne m'avait pas généreusement offert une bouteille entière, je n'aurais même pas osé te donner une goutte.»\n«Donc, tu as aidé à chasser ce type maigre et desséché, avec une peau tendue comme du caoutchouc, qui ne boit que des Bloody Mary, c'est tout ce que le patron t'a donné en récompense. Pour cette enquête, tu as passé un mois, visité trente foyers, et essuyé onze refus, tout en consommant dix-sept balles de revolver. Une bouteille de whiskey, tu ne récupères même pas ton investissement.»\n«D'accord, d'accord, ne sois pas si pointilleux. Au moins, nous avons cette bouteille de whiskey maintenant, n'est-ce pas ?»"
  },
  Event_7043_Name = {
    Text = "Fragment de souvenir : Whisky"
  },
  Event_7044_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7044_Desc = {
    Text = "Vous avez saisi l'appendice de l'Éveilleur ; il s'est tourné pour vous regarder, ses yeux brillant d'une lumière obscure.\nIl n'a rien dit, mais vous avez compris le message caché—\n\"Outrepasser.\""
  },
  Event_7044_Name = {
    Text = "Effet papillon"
  },
  Event_7045_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7045_Desc = {
    Text = "Le télégraphe est complètement cassé. Imagine le désespoir de son propriétaire pendant la tempête... car c'est ce que tu ressens maintenant"
  },
  Event_7045_Name = {
    Text = "Reliques des anciens"
  },
  Event_7046_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7046_Desc = {
    Text = "Nom : Leigh\nÂge : 20\nComplications : hématophagie accompagnée d'une hystérie sévère\nTumeur : tentacules rouge profond @2 bouche\nGreffe : organes et tissus de parenté directe @3\nRaison de la remise : Pas de raison particulière, je ne l'aime pas.\n（Le contenu suivant a été rayé）"
  },
  Event_7046_Name = {
    Text = "Enregistrement d'organes"
  },
  Event_7047_ChoiceDesc1 = {
    Text = "[Select \"Receive Blessing\"] Perdre tous les sigils noirs. Obtenir 1 relique d'or."
  },
  Event_7047_Desc = {
    Text = "Une boule de boue noire apparaît devant toi, tremblante, et te tend un dossier. \n « Je ne peux pas me présenter en ce moment... mais vous pouvez découvrir nos services personnalisés... » \n Une voix féminine s'échappe de la poitrine de la boue noire, légèrement paniquée, comme si elle cherchait à éviter quelque chose. \n « La Bénédiction de la Fée prend effet en fonction du niveau d'adhésion, garantissant l'honnêteté. » \n « Signe, dépêche-toi de signer ! »"
  },
  Event_7047_Name = {
    Text = "Bénédiction de la Fée"
  },
  Event_7048_ChoiceDesc1 = {
    Text = "[Listening Closely] Gagnez la relique en argent \"(RelicConfig.Arg1)\" et infligez \"(Skill.Arg2)\"."
  },
  Event_7048_ChoiceDesc2 = {
    Text = "[Examiner de près] Tous les éveillés récupèrent 50 points de folie, infecter [(Skill.Arg1)]"
  },
  Event_7048_ChoiceDesc3 = {
    Text = "[Leave Directly] Obtenez 1 des 3 Oraisons"
  },
  Event_7048_Desc = {
    Text = "\"Le savais-tu ?\" Alors que Ramona cherchait la figure mystérieuse, une voix murmura soudain : \"Sais-tu quelque chose à ce sujet ? De cette affaire majeure ?\""
  },
  Event_7048_Name = {
    Text = "L'oreille d'autrui"
  },
  Event_7049_ChoiceDesc1 = {
    Text = "[Focus] Retirez jusqu'à 2 Cartes Symptômes."
  },
  Event_7049_ChoiceDesc2 = {
    Text = "[Meditate] Choisir de Réveiller 1 Réveilleur."
  },
  Event_7049_ChoiceDesc3 = {
    Text = "[Connect] Restore Arg2 Vie."
  },
  Event_7049_Desc = {
    Text = "Tu explores dans la brume, soudain, l'insigne sur ta poitrine émet une faible lueur argentée. Qui t'appelle de l'autre côté de la communication ?"
  },
  Event_7049_Name = {
    Text = "Point de contact"
  },
  Event_7050_ChoiceDesc1 = {
    Text = "[Manipuler avec soin] Augmentez la santé maximale de Arg1"
  },
  Event_7050_ChoiceDesc2 = {
    Text = "[Avancer à sa rencontre] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_7050_Desc = {
    Text = "Une ombre créée par le domaine tend la main vers toi, sa silhouette est floue.\nTu te souviens qu'un enquêteur de Missaga est monté à bord de ce navire, est-ce lui ?\nOu est-ce juste un autre souvenir malheureux emprisonné par le domaine"
  },
  Event_7050_Name = {
    Text = "Clé d'argent"
  },
  Event_7051_ChoiceDesc1 = {
    Text = "[Leave] Obtiens la Relique d'Or \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_7051_Desc = {
    Text = "\"Regarde, à cause d'une remarque anodine de ma part, j'ai négligé la situation la plus urgente, ce qui n'est pas bon. \nSi nous tardons davantage, ta proie s'échappera loin. \nEn guise d'excuses, ces choses sont pour toi.\"\n\nL'homme parle de quelque chose d'autre, te remettant un certain objet."
  },
  Event_7051_Name = {
    Text = ": Compagnon étrange II"
  },
  Event_7052_ChoiceDesc1 = {
    Text = "[Partir] Choisissez 1 carte de commandement parmi 3 pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_7052_Desc = {
    Text = "\"Puisse-tu obtenir ce que tu souhaites.\"\nL'homme haussait les épaules et s'écartait, dégageant un chemin."
  },
  Event_7052_Name = {
    Text = ": Compagnon étrange II"
  },
  Event_7053_ChoiceDesc1 = {Text = "[Pocketed]"},
  Event_7053_Desc = {
    Text = "Une matière argentée proche du mercure, extraite de la boue de dissolution, contenant un puissant pouvoir spirituel, utilisée principalement pour lier plus de réveilleurs lors des rituels"
  },
  Event_7053_Name = {
    Text = "Cœur d'argent"
  },
  Event_7054_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7054_Desc = {
    Text = "Tu prends un nouveau chemin.\nLe soleil se lève comme d'habitude, les humains meurent comme d'habitude, et tu te perds comme d'habitude.\nRien de nouveau"
  },
  Event_7054_Name = {
    Text = "Labyrinthe des Yeux"
  },
  Event_7055_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7055_Desc = {
    Text = "Cela semble être une ombre déformée par la lumière"
  },
  Event_7055_Name = {
    Text = "Objet flottant dans le tonneau"
  },
  Event_7056_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7056_Desc = {
    Text = "Tu te retournes et ne vois qu'une paire de chaussures en cuir solitaires. \n «Désolé, je n'ai pas de mauvaise intention.» \n «Si tu vois mon corps, pourrais-tu lui faire passer le message que son compagnon de marche le plus fidèle attend tranquillement dans la vitrine numéro 45 de la salle d'exposition numéro 1.» \n «—— Souviens-toi, c'est la paire en cuir de vache, pas en cuir de chèvre.»"
  },
  Event_7056_Name = {Text = "Oxford"},
  Event_7057_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7057_Desc = {
    Text = "Ça doit être un ancien élève - vous ouvrez les bras, mais ce qui suit est une douleur glaciale.\nAprès la douleur, vos membres deviennent incroyablement forts, comme jamais auparavant"
  },
  Event_7057_Name = {
    Text = "Clé d'argent"
  },
  Event_7058_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7058_Desc = {
    Text = "Tu sens que la brume devant toi semble s'estomper.\n\nTu sens que, lors des prochaines actions, ta vision devient plus aiguisée"
  },
  Event_7058_Name = {
    Text = "Épreuve des Asuras"
  },
  Event_7059_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7059_Desc = {
    Text = "Le fantasme s'approche de toi, les souvenirs reviennent soudainement, et tout devient lumineux devant toi"
  },
  Event_7059_Name = {Text = "Mirage"},
  Event_7060_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7060_Desc = {
    Text = "Son inconscient a encore changé quelque chose"
  },
  Event_7060_Name = {Text = "Son regard"},
  Event_7061_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7061_Desc = {
    Text = "En situation de crise, ce n'est pas le moment de collecter des cœurs d'argent"
  },
  Event_7061_Name = {
    Text = "Preuve d'existence"
  },
  Event_7062_ChoiceDesc1 = {
    Text = "[Partir] Obtient 3 choix 1 relique d'argent, infection[(Skill.Arg1)]"
  },
  Event_7062_Desc = {
    Text = "La silhouette floue devient progressivement claire, ce n'est pas un corps de fusion, ni un cataclysme, mais Clémentine, sans ailes, avec son expression habituelle. \n « Quelle coïncidence, es-tu aussi venu admirer la lumière de la lune ? » dit-elle en souriant, et tu ressens une vague de vertige, « Par une nuit brumeuse, il faut faire preuve de prudence. \n « Les petites créatures d'ici ne sont pas vraiment sages. »"
  },
  Event_7062_Name = {
    Text = "Figure dans la brume"
  },
  Event_7063_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7063_Desc = {
    Text = "À mesure que le plâtre se brise au sol, son corps se désintègre. Les hurlements de frustration remplissent ton esprit, mais heureusement, tu t'arrêtes à temps"
  },
  Event_7063_Name = {
    Text = "Compléter le corps endommagé"
  },
  Event_7064_ChoiceDesc1 = {
    Text = "[Écouter la tristesse] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_7064_ChoiceDesc2 = {
    Text = "[Hear Joy] Pour chaque Réveiller avec Aliemus 50 ou plus, gagnez 15 Le sigil noir."
  },
  Event_7064_ChoiceDesc3 = {
    Text = "[Leave] Obtenir 1 parmi 3 Oraisons"
  },
  Event_7064_Desc = {
    Text = "Des mélodies douces, lyriques, joyeuses, tristes... Les accords résonnent dans l'espace du domaine, difficile à distinguer leur origine.\nS'agit-il d'une sonate émanant du navire fantôme, ou d'une fantaisie nocturne emprisonnée dans le domaine ?"
  },
  Event_7064_Name = {
    Text = "Son Inconnu"
  },
  Event_7065_ChoiceDesc1 = {
    Text = "[Ils cherchent quelqu'un] Retirer 1 Carte de Commande, gagner 25 Sigils Noirs."
  },
  Event_7065_ChoiceDesc2 = {
    Text = "[Ils cherchent un objet] Copier une carte du deck, infecter [(Skill.Arg1)]"
  },
  Event_7065_Desc = {
    Text = "Pourquoi les Porteurs de lanternes apparaissent-ils soudainement dans la ville de Rai ? Il y a trop de mystères ici. \n Le Chien de l'enfer Cerbère, le directeur de l'asile de Rai Francis, l'Association des sculpteurs, l'Église de la Lanterne... \n Il doit y avoir une source qui les a rassemblés dans ce petit village peu peuplé. \n La machine à écrire se met soudainement à cracher de l'encre, comme si elle t'invitait à saisir quelque chose."
  },
  Event_7065_Name = {
    Text = "Méthode de Saisie Mystérieuse"
  },
  Event_7066_ChoiceDesc1 = {
    Text = "[Fermez les Yeux Fermement]"
  },
  Event_7066_ChoiceDesc2 = {
    Text = "[Escape Scene]"
  },
  Event_7066_Desc = {
    Text = "Le spectacle s'interrompt brusquement. Tu regardes autour de toi et découvres que tu es entouré de spectateurs. \n Ils ont tous le même visage que le garçon et te fixent d'un seul regard. \n Ah—— \n Ils ouvrent silencieusement leurs bouches noires."
  },
  Event_7066_Name = {
    Text = "Cérémonie finale V"
  },
  Event_7067_ChoiceDesc1 = {
    Text = "[Ramasser la photo] Choisissez 1 carte de commandement parmi 3 pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_7067_ChoiceDesc2 = {
    Text = "[Vérifier le film] infecter [(Skill.Arg1)], remplacer l'oraison obtenue dans l'option 1, utilisable une fois de plus"
  },
  Event_7067_Desc = {
    Text = "Tu places le film sous la lumière rougeâtre, la base semi-transparente laissant entrevoir des images. \n Des mains, des pieds, des globes oculaires, des organes internes... Tous les organes humains que tu peux imaginer, ou même ceux que tu ne peux pas, sont fidèlement enregistrés sur le film. \n Ils ont été soigneusement lavés, disposés, ordonnés comme ton premier poème en vers."
  },
  Event_7067_Name = {
    Text = "enregistrer fidèlement"
  },
  Event_7068_ChoiceDesc1 = {
    Text = "[la garde de la princesse] éveillez aléatoirement un réveilleur, infectez [(Skill.Arg1)]"
  },
  Event_7068_ChoiceDesc2 = {
    Text = "[Réfléchissant] choisir 1 parmi 3 cartes de commandement pour obtenir une oraison : [(EnchantConfig.Arg1)]"
  },
  Event_7068_Desc = {
    Text = "\"Da, da, da...\"\nDes pas s'approchaient au loin, et tu as vu quelqu'un sur le point d'ouvrir la grande porte du studio.\nSans aucun endroit où se retirer, tu n'avais d'autre choix que de faire semblant d'être une sculpture en cire dans la lumière tamisée, tentant d'éviter ce regard scrutateur."
  },
  Event_7068_Name = {
    Text = "Faux pour vrai"
  },
  Event_7069_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7069_Desc = {
    Text = "\"Super, super !\" La voix débordait de joie. \"Tu es enfin devenue comme moi, Sœur Sasha !\""
  },
  Event_7069_Name = {
    Text = "\"Soeur Sasha\""
  },
  Event_7070_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7070_Desc = {
    Text = "Peut-être que quelqu'un les a attirés ici.\nEn explorant, tu découvriras qui c'est"
  },
  Event_7070_Name = {
    Text = "Méthode de Saisie Mystérieuse"
  },
  Event_7071_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7071_Desc = {
    Text = "Finir tôt, tranquillité d'esprit. Les enquêteurs de Missaga ne craignent jamais le danger"
  },
  Event_7071_Name = {
    Text = "Porte sans fin"
  },
  Event_7072_ChoiceDesc1 = {
    Text = "[Choose Morality] Restore Arg1 points of life"
  },
  Event_7072_ChoiceDesc2 = {
    Text = "[Choisir la vie] Récupérez toute la santé, infectez[(Skill.Arg2)]"
  },
  Event_7072_Desc = {
    Text = "Tu avais peut-être un cœur d'or.\nIl battait jour et nuit, se donnant à fond pour ta vie et ton existence... Chaleureux, passionné et plein d'espoir.\nMais à un moment donné, il a ralenti. Comme si entre la vie et la morale, il ne pouvait en supporter qu'un"
  },
  Event_7072_Name = {
    Text = "Soif maudite"
  },
  Event_7073_ChoiceDesc1 = {
    Text = "[Ramasser la photo] Choisissez 1 carte de commandement parmi 3 pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_7073_ChoiceDesc2 = {
    Text = "[Vérifier le film] infecter [(Skill.Arg1)], remplacer l'oraison obtenue dans l'option 1, utilisable deux fois"
  },
  Event_7073_Desc = {
    Text = "\n\"Alors, tu as tout enregistré fidèlement.\" \n\"Oui, la vérité réside dans le film.\"\nLa conversation s'arrêta brusquement, et d'innombrables yeux invisibles se tournèrent vers toi, apparemment en attente de ton dernier verdict."
  },
  Event_7073_Name = {
    Text = "Déclaration de témoignage"
  },
  Event_7074_ChoiceDesc1 = {
    Text = "[Leave] Augmenter la vie de Arg1 et gagner 25 sigles noirs."
  },
  Event_7074_Desc = {
    Text = "Ta voix est engloutie par le sifflement du vent. \n « Tu n'as pas besoin de me connaître, » le sifflement de la voix devient de plus en plus clair dans la phrase, « Herbert, c'est lui que vous cherchez. Laissez ce gars tomber, de l'illusion trompeuse à la dure réalité glaciale. » \n « Je vous bénirai, je vous donnerai le plus délicieux de ce monde... »"
  },
  Event_7074_Name = {
    Text = ": Compagnon étrange VI"
  },
  Event_7075_ChoiceDesc1 = {
    Text = "[Leave] Obtiens la Relique \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_7075_Desc = {
    Text = "«Oui, pauvre égaré, tu as le pouvoir mais tu n'as pas su te reconnaître. \nVas-tu tendre la main pour aider ? Ou bien lever ton arme contre lui ? » \nL'homme a sauté dans le courant tumultueux, et au moment où il a plongé, vos regards se sont croisés. C'étaient des pupilles verticales dorées comme du miel, appartenant à un serpent. \nEt à l'endroit où il se tenait tout à l'heure, il restait une petite lampe émettant une fumée violette."
  },
  Event_7075_Name = {
    Text = ": Compagnon étrange VI"
  },
  Event_7076_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7076_Desc = {
    Text = "«La prudence est une vertu, mais une prudence excessive est inappropriée», une voix monotone trahissant un mécontentement, «le mouvement des étoiles perturbera l'origine du sommeil de l'Éveilleur, et un moment opportun peut faire en sorte que leur fureur se dilate rapidement comme un ballon. En somme, il est encore temps de saisir la queue de la comète, la prochaine fois n'oublie pas d'optimiser ta vitesse de réaction, qui est comparable à celle d'une tortue.»"
  },
  Event_7076_Name = {
    Text = "Angle d'élévation"
  },
  Event_7077_ChoiceDesc1 = {
    Text = "[Restore] Réduisez le Stress actuel de moitié."
  },
  Event_7077_Desc = {
    Text = "Tu te connects à la chambre de pression, ce qui te permet de restaurer la valeur actuelle de pression"
  },
  Event_7077_Name = {
    Text = "Point de stabilisation de pression"
  },
  Event_7078_ChoiceDesc1 = {
    Text = "[La réconforter] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : [(EnchantConfig.Arg1)]"
  },
  Event_7078_ChoiceDesc2 = {
    Text = "[Blame Her] Accorder aléatoirement l'oraison à 3 cartes de commandement : \"(EnchantConfig.Arg1)\", infecter \"(Skill.Arg2)\""
  },
  Event_7078_Desc = {
    Text = "«Je suis l'ombre de l'enquêteur décédé, le meurtrier est cette clé en argent.»\nLa femme se couvre la tête avec douleur. Ses cheveux sont très denses, avec d'innombrables yeux brillants qui clignent, clignent…\n«Ils disent toujours : Non, Charlotte ! Hélas, Charlotte !\nAlors je pensais, si je pouvais lier beaucoup d'éveilleurs en une seule fois, tout le monde se tairait.»\n«Puis… je ne sais pas ce qui s'est passé, à mon réveil, je suis devenue ainsi. Hélas !»"
  },
  Event_7078_Name = {
    Text = "Ombre de l'Enquêteur"
  },
  Event_7079_ChoiceDesc1 = {
    Text = "[Climb the high wall] Obtenez la Relique Maudite \"(RelicConfig.Arg1)\", infectez \"(Skill.Arg2)\""
  },
  Event_7079_ChoiceDesc2 = {
    Text = "[Entrer dans le labyrinthe] 1 Carte aléatoire obtient l'Oraison : [(EnchantConfig.Arg1)]"
  },
  Event_7079_Desc = {
    Text = "Votre cerveau est un labyrinthe.\nTrop de pensées s'y enchevêtrent, la sortie est à portée du Regard, mais les hauts murs de la pensée se dressent entre vous."
  },
  Event_7079_Name = {
    Text = "Labyrinthe de l'esprit"
  },
  Event_7080_ChoiceDesc1 = {
    Text = "[Regardez le Fantasme] Obtenez 1 des 3 Relique d'Argent"
  },
  Event_7080_ChoiceDesc2 = {
    Text = "[Near Phantasm] Obtenir une relique argent \"(RelicConfig.Arg1)\"\"(RelicConfig.Arg2)\", infecter deux fois \"(Skill.Arg3)\""
  },
  Event_7080_Desc = {
    Text = "Au loin, un cône volcanique semble entrer en éruption, une fumée humanoïde s'élève dans un ciel ravagé par des vents violents. \n Voilà Elworth, où ne se trouvent que des montagnes enneigées et des grottes de calcaire à perte de vue. \n Est-ce que les événements étranges des derniers jours vous ont rendu fou ?"
  },
  Event_7080_Name = {
    Text = "Volcan fantôme"
  },
  Event_7081_ChoiceDesc1 = {
    Text = "[Je vois quelque chose] Obtenez une relique d'argent[(RelicConfig.Arg1)]"
  },
  Event_7081_ChoiceDesc2 = {
    Text = "[I Saw Nothing] Gagnez Relique d'or \"(RelicConfig.Arg1)\", Infection \"(Skill.Arg2)\""
  },
  Event_7081_Desc = {
    Text = "Des larmes coulent de tes yeux, la sensation collante est effrayante.\nEn fin de compte, c'est à cause de ce que tu as vu, et toi - n'as-tu vraiment rien vu ?"
  },
  Event_7081_Name = {
    Text = "Ne pas regarder directement"
  },
  Event_7082_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7082_Desc = {
    Text = "Vous aussi vous connaîtrez la joie et la tristesse, mais en ce moment, ce ne sont pas vos émotions qui vous submergent. Vous vous couvrez les oreilles, la clé en argent brille d'une lumière éblouissante.\nEnfin, vous pouvez respirer"
  },
  Event_7082_Name = {Text = "Addiction"},
  Event_7083_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7083_Desc = {
    Text = "Le porteur de la dague pousse un cri, tel un oiseau de deuil dans un cimetière nocturne.\nLe son s'estompe instantanément, emportant deux autres marins... Ce n'était qu'une illusion reflétée par le domaine"
  },
  Event_7083_Name = {
    Text = "Poursuivre sans relâche"
  },
  Event_7084_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7084_Desc = {
    Text = "Il flotte tranquillement dans les airs, sans cligner des yeux, son regard implorant, comme s'il voulait te dire quelque chose.\nLes yeux peuvent abriter l'âme, mais sans mots, tu ne ressens qu'une urgence, une tristesse.\nIl disparaît dans les airs"
  },
  Event_7084_Name = {
    Text = "Regard aveugle"
  },
  Event_7085_ChoiceDesc1 = {
    Text = "[Accepter] Obtenez la Reliquaire en Argent \"(RelicConfig.Arg1)\", infectez \"(Skill.Arg2)\""
  },
  Event_7085_ChoiceDesc2 = {
    Text = "[Gift] Obtenir la relique d'argent \"(RelicConfig.Arg1)\", infectée avec \"(Skill.Arg2)\"."
  },
  Event_7085_ChoiceDesc3 = {
    Text = "[Tourner et Partir] Gagner 25 sigils noirs"
  },
  Event_7085_Desc = {
    Text = "\n\"Si un jour je dois tomber, alors j'espère tomber dans l'eau. \nL'eau courante qui couvre mes narines ressemble à un doux vieux rêve. \nLe liquide dans lequel je coule \nest le bol que @2 désire le plus.\""
  },
  Event_7085_Name = {
    Text = "Cérémonie aquatique"
  },
  Event_7086_ChoiceDesc1 = {
    Text = "[Resist Phantasm] Obtenez une relique d'or \"(RelicConfig.Arg1)\", infectez \"(Skill.Arg2)\""
  },
  Event_7086_ChoiceDesc2 = {
    Text = "[Absorber la folie] Réveiller aléatoirement 2 éveillés, infection deux fois[(Skill.Arg1)]"
  },
  Event_7086_Desc = {
    Text = "La dimension fragmentée s'effondre lentement, des illusions d'autres dimensions affluant dans la pièce malade"
  },
  Event_7086_Name = {
    Text = "Illusion dimensionnelle"
  },
  Event_7087_ChoiceDesc1 = {
    Text = "[Leave] Réveillez un Réveil aléatoire"
  },
  Event_7087_Desc = {
    Text = [[
La fille marqua une pause, brossant sa jupe.
"Ce que je peux faire pour vous... c'est seulement cela."]]
  },
  Event_7087_Name = {
    Text = "Jeune fille en robe blanche"
  },
  Event_7088_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7088_Desc = {
    Text = "Qui parle ?\nVous regardez vers le bas et voyez un reflet flou — il porte les mêmes vêtements que vous mais tient un couteau, vous souriant."
  },
  Event_7088_Name = {
    Text = "Tu ne voudras pas trouver"
  },
  Event_70892_ChoiceDesc1 = {
    Text = "[Follow the Body's Memory] Évitez la bataille et revendiquez une victoire instantanée, mais perdez des points de Vie d'Arg1."
  },
  Event_70892_ChoiceDesc2 = {
    Text = "[Leave] Entrer dans la Bataille"
  },
  Event_70892_Desc = {
    Text = "Bien que l'ennemi soit extrêmement puissant, tu connais déjà les techniques pour le vaincre."
  },
  Event_70892_Name = {
    Text = "Mémoire musculaire"
  },
  Event_7089_ChoiceDesc1 = {
    Text = "[Ratisser Kum]"
  },
  Event_7089_ChoiceDesc2 = {
    Text = "[Attaquez le Sujet d'Essai]"
  },
  Event_7089_Desc = {
    Text = "Koum a mordu la nuque d'un sujet d'expérimentation, prêt à le secouer, mais le sujet a soudainement tourné la tête à 180° comme une chouette, picorant le visage de Koum"
  },
  Event_7089_Name = {Text = "Arènes"},
  Event_7090_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7090_Desc = {
    Text = "Tu serres la clé en argent, ressentant l'appel de la genèse dans les tourments sombres de la dimension.\nPour contrer les chiens des enfers aux formes inconnues, tu dois emprunter toutes les forces possibles"
  },
  Event_7090_Name = {
    Text = "Illusion dimensionnelle"
  },
  Event_7091_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7091_Desc = {
    Text = "\n\"Quant à cet enquêteur, le conservateur compte l'interroger personnellement... \nLaisse un survivant...\" \nLa voix a progressivement faibli, finissant par s'évanouir dans l'obscurité"
  },
  Event_7091_Name = {
    Text = "Les murs ont des oreilles"
  },
  Event_7092_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7092_Desc = {
    Text = "La sensation de perte de poids te réveille brusquement, le sol sous tes pieds est solide, et à tes pieds se trouve un miroir carré délicat"
  },
  Event_7092_Name = {
    Text = "Miroir dans le miroir"
  },
  Event_7093_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7093_Desc = {
    Text = "Vous ne débattez jamais avec ceux qui sont tombés dans la Folie sans espoir de retour, cela laisserait votre âme être entièrement Dévorée par les questions de minuit. Épargnez-vous cela !"
  },
  Event_7093_Name = {
    Text = "Cérémonie aquatique"
  },
  Event_7094_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7094_Desc = {
    Text = "À quoi devrait ressembler le visage de la statue de cire ?\nTu fermes les yeux, des milliers de visages flous apparaissent dans ton esprit.\nIls ressemblent à des bougies tirant une flamme pâle, surgissant et disparaissant dans le fleuve des ténèbres…\nTu marches jusqu'à la fin du fleuve, où se dresse la seule et dernière statue de cire.\nEn t'approchant, tu vois…@2."
  },
  Event_7094_Name = {
    Text = "Statue de cire inachevée"
  },
  Event_7095_ChoiceDesc1 = {
    Text = "[Attack Dagger Holder] Infectez \"(Skill.Arg1)\", obtenez la Relique Maudite \"(RelicConfig.Arg2)\""
  },
  Event_7095_ChoiceDesc2 = {
    Text = "[Tendre une Embuscade aux Armés] Infection x2 \"(Skill.Arg1)\", Gagne Relique d'Argent \"(RelicConfig.Arg2)\" et \"(RelicConfig.Arg3)\""
  },
  Event_7095_ChoiceDesc3 = {
    Text = "[Faire trébucher le porteur de lance] obtenez une relique d'argent[(RelicConfig.Arg1)]"
  },
  Event_7095_Desc = {
    Text = "Trois Marcheurs des mers s'accrochent à vous, leurs regards fous et brûlants semblent presque enflammer votre manteau. \n En jetant un coup d'œil en arrière, vous remarquez que les trois sont différents - \n le Marcheur des mers brandissant une grande épée crie le plus fort, mais agit avec une certaine désinvolture. \n Le Marcheur des mers portant une lance avance avec précaution, tel un enfant qui commence à parler. \n Le Marcheur des mers tenant une dague traîne à l'arrière, ses prières murmurées témoignent de son fanatisme."
  },
  Event_7095_Name = {
    Text = "Poursuivre sans relâche"
  },
  Event_7096_ChoiceDesc1 = {
    Text = "[Leave] Obtiens la Relique \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_7096_Desc = {
    Text = "Vous prenez le cadeau et l'ouvrez délicatement.\nUne paire d'yeux repose tranquillement dans la boîte.\n\"Je te donne mes yeux.\"\n\"Comme il l'a fait pour moi.\""
  },
  Event_7096_Name = {
    Text = "Cérémonie finale VI"
  },
  Event_7097_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7097_Desc = {
    Text = "Tendant la main à travers le centre lumineux, tu as ramassé une goutte de cœur d'argent solidifié. Ce précieux vecteur de mémoire et d'âme est brûlant, réfléchissant des couleurs étranges. \n Avant qu'il ne déforme et mélange toute la lumière, la douleur brûlante te pousse à le replonger dans les ténèbres."
  },
  Event_7097_Name = {
    Text = "Lumière nocturne"
  },
  Event_7098_ChoiceDesc1 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_7098_Desc = {
    Text = "Vous avez rejeté le cadeau du garçon.\nLe garçon vous regardait avec des yeux vides. Il a soupiré doucement.\n\"Eh bien, au revoir alors.\"\nAvec ces mots, le garçon a fait un geste d'inclinaison et est tombé par la fenêtre.\nIl a disparu, comme un papillon dansant ou une brise passante."
  },
  Event_7098_Name = {
    Text = "Cérémonie finale VI"
  },
  Event_7099_ChoiceDesc1 = {
    Text = "Choisissez une oraison normale"
  },
  Event_7100_ChoiceDesc1 = {
    Text = "[AccepterL'Oreille] Obtenez une relique en argent \"(RelicConfig.Arg1)\" et infectez \"(Skill.Arg2)\"."
  },
  Event_7100_ChoiceDesc2 = {
    Text = "[Reject Request] Obtenez une oraison à 3 choix"
  },
  Event_7100_Desc = {
    Text = "Une série de notes magnifiques s'échappe de ses doigts. \n Le pianiste en cire mélancolique est assis seul devant la fenêtre. \n Depuis qu'il a conscience, le musée de cire est tout son monde. \n Il est longtemps resté isolé et souhaite entendre quelque chose de différent, surtout... une musique appelée jazz. \n Enfin, il arrache une de ses oreilles et te demande de l'emporter. \n « Laisse-moi écouter la musique du monde extérieur... il suffit de la mettre dans ta poche. »"
  },
  Event_7100_Name = {
    Text = "Prête l'oreille"
  },
  Event_7101_ChoiceDesc1 = {
    Text = "[Connect] Restaurer la Vie Arg2. [ExDesc1]"
  },
  Event_7101_ChoiceDesc2 = {
    Text = "[Meditate] Réveiller 1 Réveilleur. [ExDesc1]"
  },
  Event_7101_ChoiceDesc3 = {
    Text = "[Expel] Éliminez jusqu'à 3 cartes de symptômes, et gagnez des sigils noirs Arg2."
  },
  Event_7101_Desc = {
    Text = "Tu explores dans la brume, soudain, l'insigne sur ta poitrine émet une faible lueur argentée. Qui t'appelle de l'autre côté de la communication ?"
  },
  Event_7101_Name = {
    Text = "Point de contact"
  },
  Event_7101_Tips3 = {
    Text = "Aucune carte de symptôme"
  },
  Event_7102_ChoiceDesc1 = {
    Text = "[Accepter le défi]"
  },
  Event_7102_ChoiceDesc2 = {
    Text = "[Frappez-le] Gagner 25 sigils noirs"
  },
  Event_7102_Desc = {
    Text = "Une silhouette amaigrie émerge de l'ombre, bloquant ton chemin. \n Un souvenir éternellement contraint surgit dans le Labyrinthe, une ombre se présentant comme « N » joue avec des jetons dans ses mains, t'invitant à rejoindre son jeu avec des gémissements indistincts. \n Des jetons tricolores s'étalent devant toi, si tu ne joues pas une « partie » avec lui, il est probable qu'il ne te laissera pas partir facilement."
  },
  Event_7102_Name = {
    Text = "Le spectacle commence"
  },
  Event_7103_ChoiceDesc1 = {
    Text = "[Insert Silver Key]"
  },
  Event_7103_Desc = {
    Text = "La d-boue sursaturée semble renfermer certaines substances... observe avec la clé en argent et transforme-la en ta propre force"
  },
  Event_7103_Name = {
    Text = "Point d'extraction"
  },
  Event_7104_ChoiceDesc1 = {
    Text = "[Struggle Awake] Augmenter la santé maximale de Arg1"
  },
  Event_7104_ChoiceDesc2 = {
    Text = "[Se laisser sombrer dans le Sommeil] 2 Cartes d'instruction aléatoires obtiennent l'Oraison : «(EnchantConfig.Arg1)», infecter 2 «(Skill.Arg2)»"
  },
  Event_7104_Desc = {
    Text = "Tu tiens un trésor brillant dans tes bras. \n Il s'accroche à ton corps depuis ta poitrine, ce souvenir chaleureux qui dégage la lumière des bougies, se déversant finalement dans ton esprit. \n Le crépitement du charbon, le fauteuil confortable près du feu, le thé chaud et le ventre du chat enroulé à tes pieds... \n Dans cette douce torpeur, ton esprit s'assoupit, sombrant dans un océan de douceur."
  },
  Event_7104_Name = {
    Text = "Se perdre dans le passé"
  },
  Event_7105_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7105_Desc = {
    Text = "Tu arraches sans pitié l'autre moitié du film, cachée dans le ventre de l'appareil. Les images te laissent sans voix.\nLe film non développé montre fidèlement—toi, allongé dans une flaque de boue noire"
  },
  Event_7105_Name = {
    Text = "Enregistrer sans culpabilité"
  },
  Event_7106_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7106_Desc = {
    Text = "Tu as soigneusement inspecté l'appareil photo, le cuir et l'or noir incrustés dans le corps, reflétant une lueur huileuse.\nL'objectif te visait, comme s'il te fixait, te scrutait"
  },
  Event_7106_Name = {
    Text = "Enregistrer sans culpabilité"
  },
  Event_7107_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7107_Desc = {
    Text = "Une poignée de lumière lunaire dans la paume, dispersée sur la pierre tombale.\nQuelqu'un est enterré sous la boue épaisse, les spectateurs prétendent qu'il est mort naturellement et reposera en paix.\nMais la boue enfouie bouge, et dans les cris, une lune molle en émerge"
  },
  Event_7107_Name = {
    Text = "Fragment de Lune d'Argent"
  },
  Event_7108_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7108_Desc = {
    Text = "Tu touches doucement les ailes fines du papillon, qui bat légèrement des ailes avant de se transformer en gouttes noires, tombant dans ta paume"
  },
  Event_7108_Name = {
    Text = "Quelque chose qui ne devrait pas exister"
  },
  Event_7109_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7109_Desc = {
    Text = "La lune solitaire brille haut dans le ciel, et tu peux entendre clairement les prières qu'elle murmure, avec une tonalité étrange, semblable aux chuchotements de choses impures. \n La prière s'arrête, tu es sur le point de partir. Mais derrière toi, une ombre blanche s'illumine. \n « Celui qui espionne le destin et profane les prières, les dons et les coûts viendront comme prévu. »"
  },
  Event_7109_Name = {
    Text = "Fragment de Lune d'Argent"
  },
  Event_7110_ChoiceDesc1 = {
    Text = "[Trois Points]"
  },
  Event_7110_ChoiceDesc2 = {
    Text = "[Six Points]"
  },
  Event_7110_ChoiceDesc3 = {Text = "[Un point]"},
  Event_7110_Desc = {
    Text = "On dirait que tu as de la chance aujourd'hui.\nLes dés vibrent d'excitation.\nTu décides de deviner un chiffre"
  },
  Event_7110_Name = {
    Text = "Partie de jeu sans fin"
  },
  Event_7111_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7111_Desc = {
    Text = "Ce pari est une énorme arnaque !\nTu te lèves d'un bond, mais tu te sens étourdi.\nLes dés bourdonnent, une voix envoûtante résonne dans ta tête :\n\"Juste une dernière fois... la dernière...\""
  },
  Event_7111_Name = {
    Text = "Partie de jeu sans fin"
  },
  Event_7112_ChoiceDesc1 = {
    Text = "[Utiliser l'argent] Améliorez 1 relique d'argent en une relique en or[(RelicConfig.Arg1)]"
  },
  Event_7112_ChoiceDesc2 = {
    Text = "[Store Silver] Obtenez une relique en or \"(RelicConfig.Arg1)\", infectez \"(Skill.Arg2)\" et \"(Skill.Arg3)\"."
  },
  Event_7112_ChoiceDesc3 = {
    Text = "[Remettre dans le Tiroir] Gagner 25 Sigils Noirs"
  },
  Event_7112_Desc = {
    Text = "Dans le deuxième tiroir à droite du bureau, se trouve un noyau d'argent formé. En le touchant doucement, tu entends le hurlement de la tempête, le bruit des flocons de neige broyés, et le gémissement d'une flûte"
  },
  Event_7112_Name = {
    Text = "Cœur d'argent solitaire"
  },
  Event_7113_ChoiceDesc1 = {
    Text = "[Listening Closely] Infecte \"(Skill.Arg1)\", gagne une relique maudite - \"(RelicConfig.Arg2)\""
  },
  Event_7113_ChoiceDesc2 = {
    Text = "[Make a Change] Choisissez de détruire 1 Relique et gagnez 1 récompense."
  },
  Event_7113_ChoiceDesc3 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_7113_Desc = {
    Text = [[
Toutes les musiques ne sont pas belles.
Les dissonances pures forment un cri de douleur]]
  },
  Event_7113_Name = {Text = "Désaccord"},
  Event_7114_ChoiceDesc1 = {
    Text = "[Ramassez-le] Infectez \"(Skill.Arg1)\", gagnez une Relique en argent \"(RelicConfig.Arg2)\""
  },
  Event_7114_ChoiceDesc2 = {
    Text = "[Abandonnez-le] Gagnez 25 Sigils Noirs."
  },
  Event_7114_Desc = {
    Text = "Dans le coin de la grange masqué par la putréfaction, quelque chose repose silencieusement au milieu des fissures d'une marque de dissolution"
  },
  Event_7114_Name = {
    Text = "après la botte de paille"
  },
  Event_7115_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7115_Desc = {
    Text = "Cette silhouette ne s'est pas rapprochée, elle t'a regardé un moment avant de se transformer en une poignée de sable argenté"
  },
  Event_7115_Name = {
    Text = "Clé d'argent"
  },
  Event_7116_ChoiceDesc1 = {
    Text = "[Tenir le Tentacule] Acceptez l'aide de Tulu"
  },
  Event_7116_Desc = {
    Text = "Avec un soupir, Tulu a rattrapé.\nDes membres lourds et glacés se sont accrochés à vous, réprimant votre envie de charger dans les rangs ennemis.\n\"Je serai votre aide, mais seulement pour l'instant.\""
  },
  Event_7116_Name = {
    Text = "La Promesse de l'Agent"
  },
  Event_7117_ChoiceDesc1 = {
    Text = "[Obtenez la Clé]"
  },
  Event_7117_Desc = {
    Text = "1, 2, 3…\nLa distance entre Jenkins et le bureau est de 10 pieds.\nC'est une distance très courte, mais qui semble aussi longue que sa vie.\nElle se souvient du ruban doux, des papiers de bonbon dorés, et des larmes de sa mère.\nElle pense à beaucoup d'autres choses…\nSon corps frêle traverse la rivière noire, se rapprochant petit à petit du bureau.\nLa clé est dans le tiroir, et le prix à payer pour l'obtenir est simple : du courage, de l'adresse, et un peu de chance.\nÀ part la chance, Jenkins ne manque de rien."
  },
  Event_7117_Name = {
    Text = "Clé Finale"
  },
  Event_7118_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7118_Desc = {
    Text = "Juste un pari, tu ne perdras pas.\nUne pièce gravée est lancée en l'air, puis retombe rapidement, réchauffée par votre paume"
  },
  Event_7118_Name = {
    Text = "Gambler célèbre"
  },
  Event_7119_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7119_Desc = {
    Text = "Juste un pari, tu ne perdras pas.\nUne pièce gravée est lancée en l'air, puis retombe rapidement, réchauffée par votre paume"
  },
  Event_7119_Name = {
    Text = "Gambler célèbre"
  },
  Event_7120_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7120_Desc = {
    Text = "Juste un pari, tu ne perdras pas.\nUne pièce gravée est lancée en l'air, puis retombe rapidement, réchauffée par votre paume"
  },
  Event_7120_Name = {
    Text = "Gambler célèbre"
  },
  Event_7121_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7121_Desc = {
    Text = "Vous n'avez pas l'intention de participer à ce cours de piano sérieux. \n Chaque fois qu'ils terminent une mesure, les étudiants tournent la tête avec difficulté, feignant d'écouter. \n Leur professeur se penche légèrement, ses lèvres s'ouvrent et se ferment, ses yeux ronds regardent une partition qui n'existe pas. \n Ils ne savent clairement pas ce qu'ils font et ne comprendront jamais pourquoi les humains passent des années à faire cet exercice mécanique. \n Ils ne font que reproduire."
  },
  Event_7121_Name = {
    Text = "Cours de piano"
  },
  Event_7122_ChoiceDesc1 = {
    Text = "[Insert Silver Key]"
  },
  Event_7122_Desc = {
    Text = "La d-boue sursaturée semble renfermer certaines substances... observe avec la clé en argent et transforme-la en ta propre force"
  },
  Event_7122_Name = {
    Text = "Point d'extraction"
  },
  Event_7123_ChoiceDesc1 = {
    Text = "[Recognize Lyrics] Obtenez une Relique d'Argent \"(RelicConfig.Arg1)\", et infectez \"(Skill.Arg2)\""
  },
  Event_7123_ChoiceDesc2 = {
    Text = "[Hum doucement] Gagnez une oraison à 3 choix"
  },
  Event_7123_Desc = {
    Text = "La vieille chanson de marins résonne dans le domaine. \nLes souvenirs piégés dans le domaine chantent des vagues, le ciel et l'alcool envers une langue que tu n'as jamais entendue"
  },
  Event_7123_Name = {
    Text = "Chant de la mer"
  },
  Event_7124_ChoiceDesc1 = {
    Text = "[appelle le corbeau] obtient 20 le sigil noir, contamine[(Skill.Arg2)]"
  },
  Event_7124_ChoiceDesc2 = {
    Text = "[S'éloigner]"
  },
  Event_7124_Desc = {
    Text = "Les oiseaux noirs te fixent, et après un long moment, quelque chose tombe de leurs plumes"
  },
  Event_7124_Name = {
    Text = "Corbeau Solitaire"
  },
  Event_7125_ChoiceDesc1 = {
    Text = "[Step Forward and Grip] Gagnez 25 Sigils Noirs"
  },
  Event_7125_ChoiceDesc2 = {
    Text = "[Réponse Amicale] 50 % de chances de gagner 50 sigils noirs, 50 % de chances de rien."
  },
  Event_7125_Desc = {
    Text = "Un chat, dont l'origine est inconnue, est assis entre les d-boues. Son corps aux contours flous indique qu'il doit être un résident de la dimension spirituelle.\nCe reflet au visage flou fixe Lamona avec un regard sage, levant sa patte blanche pour faire signe"
  },
  Event_7125_Name = {
    Text = "Résidents Nomades"
  },
  Event_7126_ChoiceDesc1 = {
    Text = "[Running North]"
  },
  Event_7126_ChoiceDesc2 = {
    Text = "[Ignorez le son]"
  },
  Event_7126_Desc = {
    Text = "Les attaques de l'ennemi pleuvaient derrière, leurs lames effleurant le manteau et effrayant une volée de mouettes au port.\n\"Allez vers le nord... ou embarquez sur le navire...\"\nMême la personne la plus folle pouvait sentir qu'une force invisible vous assistait."
  },
  Event_7126_Name = {
    Text = "Vers le nord"
  },
  Event_7127_ChoiceDesc1 = {
    Text = "[Écouter le soleil] obtenez une relique d'argent[(RelicConfig.Arg1)]"
  },
  Event_7127_ChoiceDesc2 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_7127_Desc = {
    Text = "Dans l'entrelacement de la réalité et de l'illusion, les corps célestes tournent éternellement sur leurs orbites prédéfinies.\nDes milliers de rencontres manquées composent une mélodie étrange et trompeuse après l'autre..."
  },
  Event_7127_Name = {
    Text = "Son des étoiles et de la lune"
  },
  Event_7128_ChoiceDesc1 = {
    Text = "[Leave with Sorrow] Copiez une carte. Si une carte symptôme est copiée, gagnez 75 sigils noirs."
  },
  Event_7128_ChoiceDesc2 = {
    Text = "[Partir avec colère] Choisissez 1 Carte d'instruction parmi 3 pour obtenir une Oraison : [(EnchantConfig.Arg1)]"
  },
  Event_7128_Desc = {
    Text = "Le liquide jaillit de la pupille, emportant une partie de l'âme avec une froideur impétueuse"
  },
  Event_7128_Name = {
    Text = "Larme des Plaines Sombres"
  },
  Event_7129_ChoiceDesc1 = {
    Text = "[Plonger dans le couloir]"
  },
  Event_7129_ChoiceDesc2 = {
    Text = "[Aller à l'encontre du courant] Gagnez 25 sigils noirs"
  },
  Event_7129_Desc = {
    Text = "La lumière de la lune ignorait le passage du temps, inondant le couloir silencieux.\nLes portes brillaient étrangement sous la lumière lunaire"
  },
  Event_7129_Name = {
    Text = "Galerie silencieuse"
  },
  Event_7130_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7130_Desc = {
    Text = "Vous décidez de réparer cette sculpture de cire.  \nAutour de la sculpture, quelques outils sont éparpillés et vous choisissez un colorant nommé « bleu de Prusse ».  \nIl est bleu comme une maladie"
  },
  Event_7130_Name = {
    Text = "Statue de cire inachevée"
  },
  Event_7131_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7131_Desc = {
    Text = "Une pustule pousse un cri aigu et terrifiant, un sifflement de vent qui ne devrait pas exister résonne derrière tes oreilles, accompagné d'une mélodie de flûte illusoire et du bruit interdit du pus en mouvement. \n La pustule se tord étrangement pendant un instant, puis s’immobilise dans un silence mortel. En voyant cela, l'Éveilleur à tes côtés semble avoir été touché par un appel."
  },
  Event_7131_Name = {
    Text = "Pustule bizarre"
  },
  Event_7132_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7132_Desc = {
    Text = "Tes doigts touchent la statue, mais la sensation est parfois étrangement douce, tu penses toujours que c'est une illusion"
  },
  Event_7132_Name = {
    Text = "Assembler des restes"
  },
  Event_7133_ChoiceDesc1 = {
    Text = "[Tear For Her]"
  },
  Event_7133_ChoiceDesc2 = {
    Text = "[Prie à Elle]"
  },
  Event_7133_Desc = {
    Text = "Au moment où son corps touche le bastingage, des souvenirs qui ne lui appartiennent pas affluent dans son esprit. \n Les gens lui mettent une robe blanche sacrée, l'ornent de bijoux délicats et élégants, et l'élèvent sur un autel élevé, tandis que les habitants du petit village se prosternent à ses pieds. \n Ce sont des yeux pleins d'espoir : les marins espèrent qu'elle protégera leur navigation, les pêcheurs espèrent une saison de pêche calme et sans tempête, et de nombreux villageois espèrent une année de prospérité. \n Parmi la foule de ceux qui se prosternent, se trouvent ses amis d'enfance, ainsi que ses parents et frères et sœurs avec qui elle a grandi. \n Elle ne désire rien, elle ne sait pas ce qu'elle veut. \n Répondre passivement aux vœux semble être la seule responsabilité de sa vie."
  },
  Event_7133_Name = {
    Text = "Cérémonie prévol"
  },
  Event_7134_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7134_Desc = {
    Text = "Ce corps mutilé aux yeux pâles te regarde partir, avec un sourire morne"
  },
  Event_7134_Name = {
    Text = "Assembler des restes"
  },
  Event_7135_ChoiceDesc1 = {
    Text = "[Face It] Obtenir la relique maudite \"(RelicConfig.Arg1)\" et devenir infecté par \"(Skill.Arg2)\"."
  },
  Event_7135_ChoiceDesc2 = {
    Text = "[Abandonner toute résistance] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : [(EnchantConfig.Arg1)]"
  },
  Event_7135_ChoiceDesc3 = {
    Text = "[Run Away] Gagnez 50 sigils noirs"
  },
  Event_7135_Desc = {
    Text = "Quelques blocs de sculpture en cire bloquent votre chemin.\nIls sont tordus et rugueux en apparence, ne ressemblant pas à l'artisanat auquel on pourrait s'attendre de Rogers.\n\"Ordres... les ordres du maître...\""
  },
  Event_7135_Name = {Text = "Étude"},
  Event_7136_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7136_Desc = {
    Text = "Tu choisis de regarder courageusement dans les yeux. \n Ils sont des étoiles brillantes, scintillant dans l'obscurité. \n Puis ils éclatent de rire, se transformant en d'innombrables lunes croissantes. \n « Tu n'as pas peur du regard. Tu ne devrais pas avoir peur non plus... \n Ça fait longtemps, @2. » \n Avant de disparaître, ils te font un petit cadeau en souvenir de « la rencontre à nouveau »."
  },
  Event_7136_Name = {Text = "œil"},
  Event_7137_ChoiceDesc1 = {
    Text = "[Switch On] Élargissez votre vision actuelle[ExDesc1]."
  },
  Event_7137_Desc = {
    Text = "Un dispositif d'éclairage laissé par les anciens dissipe la brume noire environnante.\nLa brume autour oscille régulièrement, comme troublée par sa respiration"
  },
  Event_7137_Name = {Text = "projecteur"},
  Event_7138_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7138_Desc = {
    Text = "Des ailes transparentes s'étendent sur ton dos, tournant, tournant, plongeant avec les corbeaux dans le silence abyssal"
  },
  Event_7138_Name = {
    Text = "Voix des corbeaux"
  },
  Event_7139_ChoiceDesc1 = {
    Text = "[Éliminer ça] Obtenir[Cœur de l'aberration]"
  },
  Event_7139_Desc = {
    Text = "Une pustule difforme abandonnée au bord de la route, sa surface irisée d'une lueur huileuse et souillée, se tord et rampe d'un air agité. \n Comparée à un monstre, elle ressemble davantage à une glace exposée au soleil brûlant, prête à fondre en une flaque de liquide trouble, puis à disparaître dans l'air."
  },
  Event_7139_Name = {
    Text = "Pustule bizarre"
  },
  Event_7140_ChoiceDesc1 = {
    Text = "[Baisse les mains couvrant tes oreilles] Infection[(Skill.Arg1)], choisir une récompense"
  },
  Event_7140_ChoiceDesc2 = {
    Text = "[Attraper un corbeau] Obtenir[(Skill.Arg1)], Choisir une récompense"
  },
  Event_7140_ChoiceDesc3 = {
    Text = "[Close Your Eyes] Gain 50 black sigils"
  },
  Event_7140_Desc = {
    Text = "Hurlement sans fin –\nLe chanteur corbeau avec son plumage noir luisant et son bec acéré émet des cris perçants, déchirant tes tympans.\nLaisse tomber les mains sur tes oreilles !\nLa troupe de corbeaux nocturnes veut boire la peur non filtrée nichée en toi.\n"
  },
  Event_7140_Name = {
    Text = "Chant des Corbeaux"
  },
  Event_7141_ChoiceDesc1 = {
    Text = "[Leave] Rien trouvé"
  },
  Event_7141_Desc = {
    Text = "Ce n'est pas la personne que vous cherchez"
  },
  Event_7141_Name = {
    Text = "2_6 temporaire"
  },
  Event_7142_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7142_Desc = {
    Text = "Tu choisis de continuer à avancer.\nComparé aux dommages mentaux et physiques causés par ces horribles sculptures de cire, ces petites préoccupations ne sont rien.\nTu as un plus grand projet à accomplir"
  },
  Event_7142_Name = {Text = "pas"},
  Event_7143_ChoiceDesc1 = {
    Text = "[Montrer le problème] Choisissez 1 carte de commandement parmi 3 pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_7143_Desc = {
    Text = "\"Qu'est-ce qui ne va pas ! Aimes-tu vraiment tant à piquer les blessures des autres comme ça ?\" \n\"Oui ! J'ai soudainement vieilli de vingt-cinq ans sans raison ! Maintenant, tu dois m'appeler Sœur Murphy !\""
  },
  Event_7143_Name = {
    Text = "Vie Enchaînée"
  },
  Event_7144_ChoiceDesc1 = {
    Text = "[Partir] Obtient 3 choix 1 relique d'argent, infection[(Skill.Arg1)]"
  },
  Event_7144_Desc = {
    Text = "Le visage de la jeune fille était aussi calme que la lumière de la lune, elle ne te répondit pas, mais leva haut la boussole dans sa main—elle tremblait, comme si lever cette petite boussole épuisait toute sa vie"
  },
  Event_7144_Name = {
    Text = "Jeune fille en robe blanche"
  },
  Event_7145_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7145_Desc = {
    Text = "\"Délicieux ! Délicieux !\" Le corbeau croassa, et la puanteur de la décomposition s'est répandue dans ton nez alors qu'il déployait ses ailes."
  },
  Event_7145_Name = {
    Text = "Corbeau maudit"
  },
  Event_7146_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7146_Desc = {
    Text = "À mon avis, le bruit est sans aucun doute le modèle de la nouvelle génération. \n Ils avancent avec détermination sur un rythme chaotique et des mélodies écrasantes, ravageant le monde. \n Pas de compassion, pas d'ébranlement, pas de compromis. \n Haïssant l'ordre, rejetant les thèmes, le bruit ne plaît jamais aux autres - \n bien sûr, cela inclut aussi notre sculpteur de cire."
  },
  Event_7146_Name = {
    Text = "mauvais goût"
  },
  Event_7147_ChoiceDesc1 = {Text = "[Guide]"},
  Event_7147_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7147_Desc = {
    Text = "Quelqu'un tire doucement sur votre manche.\nC'est le garçon que vous avez vu plus tôt. Il est accroupi dans un coin, vous regardant avec une expression triste.\n\"Je-je veux participer à la performance de l'académie.\nMais je ne trouve pas le chemin de la scène.\""
  },
  Event_7147_Name = {
    Text = "Cérémonie finale II"
  },
  Event_7148_ChoiceDesc1 = {
    Text = "[Continuer à chercher] Augmenter Arg1 points de vie, infecter[(Skill.Arg2)]"
  },
  Event_7148_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7148_Desc = {
    Text = "Ton nez détecte une odeur familière, simple et satisfaisante. Lorsque tu veux la sentir à nouveau, elle disparaît complètement"
  },
  Event_7148_Name = {
    Text = "Contact Anormal"
  },
  Event_7149_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7149_Desc = {
    Text = "Ils sont des couleurs chaleureuses.\nVives, douces, affectueuses.\nIls ont donné à la fille une étreinte nostalgique, puis ont disparu comme le vent"
  },
  Event_7149_Name = {
    Text = "Couleurs nostalgiques"
  },
  Event_7150_ChoiceDesc1 = {
    Text = "[Who are you, really?]"
  },
  Event_7150_ChoiceDesc2 = {
    Text = "[Comment changer votre état d'esprit ?]"
  },
  Event_7150_Desc = {
    Text = "L'homme aux cheveux longs se tient à nouveau devant vous. Après l'expérience précédente, Ramona a une expression peu amicale. \n « Restez calme, mon ami. » L'homme commence lentement, sa voix est magnétique et séduisante, semblant sortir avec un murmure sifflant, comme si l'air passait à travers un passage étroit. \n « Je vous observe depuis un certain temps, changer d'approche est la seule façon de vous rapprocher de votre objectif. »"
  },
  Event_7150_Name = {
    Text = ": Compagnon étrange III"
  },
  Event_7151_ChoiceDesc1 = {
    Text = "[Je cherche] Augmentez la santé maximale de Arg1"
  },
  Event_7151_ChoiceDesc2 = {
    Text = "[J'Esquive] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_7151_Desc = {
    Text = "\"Je vois quelqu'un chercher, cherchant ce qui est inaccessibile, cette chose relative pleine de chagrin, ce qui est appelé vérité.\nJe vois quelqu'un éviter, esquivant l'inévitable, cette chose cruelle cachée, ce qui est appelé vérité.\nLequel es-tu ?\""
  },
  Event_7151_Name = {
    Text = "Objet de quête"
  },
  Event_7152_ChoiceDesc1 = {
    Text = "[Regarder attentivement] Améliorez 1 relique d'argent en une relique en or[(RelicConfig.Arg1)]"
  },
  Event_7152_ChoiceDesc2 = {
    Text = "[Attempt to Listen] Gagner la Relique en or \"(RelicConfig.Arg1)\", Infection \"(Skill.Arg2)\", et \"(Skill.Arg3)\""
  },
  Event_7152_ChoiceDesc3 = {
    Text = "[Store Carefully] Gagner 25 Sigils Noirs"
  },
  Event_7152_Desc = {
    Text = "La brume devant est illuminée par un petit objet, un éclat qui ressemble à un morceau de verre ou de cristal, dans lequel se déplacent des couleurs de nombreuses nuances, claires et sombres"
  },
  Event_7152_Name = {
    Text = "Nos Souvenirs"
  },
  Event_7153_ChoiceDesc1 = {
    Text = "[Accepter le défi] Gagnez pour obtenir une relique en argent, perdez pour obtenir un symptôme. Le résultat n'affecte pas l'enquête ultérieure."
  },
  Event_7153_ChoiceDesc2 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_7153_Desc = {
    Text = "Qui est la personne dans le reflet ?\nElle respire et son cœur bat en synchronisation avec toi, partageant la même idée étrange.\nEst-ce une farce du domaine secret ou une ombre d'une autre dimension ?\nCela semble être une invitation à un défi illusoire ?"
  },
  Event_7153_Name = {
    Text = "Résonance d'âmes"
  },
  Event_7154_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7154_Desc = {
    Text = "Le regard transcende l'histoire et le temps, peut-être non linéaire, observant depuis le chaos avant la naissance des planètes.\nOu peut-être vous attend-il dans un futur lointain"
  },
  Event_7154_Name = {Text = "Épier"},
  Event_7155_ChoiceDesc1 = {
    Text = "[Claim] Gain 50 black sigils"
  },
  Event_7155_Desc = {
    Text = "L'endroit était vide, un liquide noir coulait sur le sol, ne reflétant rien.\nEst-ce une illusion ? Tu as l'impression que quelque chose glisse entre tes doigts"
  },
  Event_7155_Name = {
    Text = "Sous la surface du miroir"
  },
  Event_7156_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7156_Desc = {
    Text = "\"Vous êtes une personne si généreuse. Je vous souhaite que tous vos vœux se réalisent aujourd'hui, demain et le jour suivant.\"\n\"Au fait, c'est une affaire unique...\"\nLa fée se lécha les lèvres avec satisfaction et vous dit au revoir à contrecœur."
  },
  Event_7156_Name = {
    Text = "Bénédiction de la Fée"
  },
  Event_7157_ChoiceDesc1 = {
    Text = "[Rendez-moi mon portefeuille!] Gagnez 1 des 3 Oraisons choisies"
  },
  Event_7157_ChoiceDesc2 = {
    Text = "[Hésiter] 1 Carte d'instruction aléatoire obtient l'Oraison : «(EnchantConfig.Arg1)», infectée par «(Skill.Arg2)»"
  },
  Event_7157_Desc = {
    Text = "« Viens, reprends ton porte-monnaie ! » Un enfant au loin agite la main. \n Tu te précipites en avant, au moment où tu tends la main, un bruit énorme et chaotique résonne dans ta tête. \n « D'où vient cet enfant sale ! » \n « C'est un petit rat des rues, comment ose-t-il toucher la jupe de la duchesse ! » \n « Écartez-le vite ! » \n « As-tu des pièces ? Sans pièces, tu ne pourras même pas prendre un pain noir ! »"
  },
  Event_7157_Name = {
    Text = "Livre du Rien"
  },
  Event_7158_ChoiceDesc1 = {
    Text = "[Suivre la mélodie] choisir 1 carte de commandement parmi 3 pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_7158_ChoiceDesc2 = {
    Text = "[Chanter avec] infecter[(Skill.Arg1)], ré-impression, jusqu'à 2 fois"
  },
  Event_7158_Desc = {
    Text = "Des chants lointains se brisent en poussière d'étoiles : \n « Je maudis l'eau sale d'une ruelle nocturne, où des fleurs pourries pendent au pied d'un mur en ruine, des chaînes s'accrochent à mon cerveau et tombent dans la boue, avant que la brume n'efface mon existence, le crépuscule plongera dans le plus profond @2. »"
  },
  Event_7158_Name = {
    Text = "Malédiction de la matière blanche"
  },
  Event_7159_ChoiceDesc1 = {
    Text = "[Laisser une Offrande] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infectée par «(Skill.Arg2)»"
  },
  Event_7159_ChoiceDesc2 = {
    Text = "[L'emmener avec soi] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infectée par «(Skill.Arg2)»"
  },
  Event_7159_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_7159_Desc = {
    Text = "Alors que tu t'approchais, une âme chaotique désordonnée surgit de la boue. \nLes membres noirs s'enroulèrent fortement autour de toi, pleurant et priant — \noffrant un sacrifice ou l'emmenant"
  },
  Event_7159_Name = {
    Text = "Esprit du Chaos"
  },
  Event_7160_ChoiceDesc1 = {
    Text = "[Conservez l'offrande] Améliorez aléatoirement la qualité d'une carte"
  },
  Event_7160_ChoiceDesc2 = {
    Text = "[L'emmener] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_7160_Desc = {
    Text = "Alors que tu t'approchais, une âme chaotique désordonnée surgit de la boue. \nLes membres noirs s'enroulèrent fortement autour de toi, pleurant et priant — \noffrant un sacrifice ou l'emmenant"
  },
  Event_7160_Name = {
    Text = "Esprit du Chaos"
  },
  Event_7161_ChoiceDesc1 = {
    Text = "[Chasser d'un geste] 1 Carte d'instruction aléatoire obtient l'Oraison : «(EnchantConfig.Arg1)», infectée par «(Skill.Arg2)»"
  },
  Event_7161_ChoiceDesc2 = {
    Text = "[Laisser durer] Choisissez 1 carte de commandement parmi 3 pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_7161_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_7161_Desc = {
    Text = "Les ailes du papillon traînent un liquide noir, volant en oscillant, le liquide se solidifie et s'effrite.\nFatigué, il se pose sur ton nez"
  },
  Event_7161_Name = {
    Text = "Papillon de l'Élixir Noir"
  },
  Event_7162_ChoiceDesc1 = {
    Text = "[Chasser d'un geste] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infectée par «(Skill.Arg2)»"
  },
  Event_7162_ChoiceDesc2 = {
    Text = "[Let It Stay] Gagne la Relique d'Argent \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_7162_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_7162_Desc = {
    Text = "Les ailes du papillon traînent un liquide noir, volant en oscillant, le liquide se solidifie et s'effrite.\nFatigué, il se pose sur ton nez"
  },
  Event_7162_Name = {
    Text = "Papillon de l'Élixir Noir"
  },
  Event_7163_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7163_Desc = {
    Text = "\"Je vois du courage, de la volonté, et un esprit brillant comme les étoiles. Avance vers ce souvenir scellé à la cire, et tu verras ton vœu exaucé.\""
  },
  Event_7163_Name = {
    Text = "Objet de quête"
  },
  Event_7164_ChoiceDesc1 = {
    Text = "[Laisser rester] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infectée par «(Skill.Arg2)»"
  },
  Event_7164_ChoiceDesc2 = {
    Text = "[Waving Away] Obtenez la Relique Argent \"(RelicConfig.Arg1)\", infectez \"(Skill.Arg2)\""
  },
  Event_7164_ChoiceDesc3 = {
    Text = "[Welcome the Butterflies] Gagnez 25 sigils noirs"
  },
  Event_7164_Desc = {
    Text = "Vous errez dans le sanatorium glacial, une papillon noir, anormal pour la saison, vole vers vous.\nSes ailes dégoulinent de liquide noir, laissant des traces qui se solidifient et s'effritent au vent.\nIl se pose sur votre doigt, épuisé"
  },
  Event_7164_Name = {
    Text = "Quelque chose qui ne devrait pas exister"
  },
  Event_7165_ChoiceDesc1 = {
    Text = "[Partir] Obtient 3 choix 1 relique d'argent, infection[(Skill.Arg1)]"
  },
  Event_7165_Desc = {
    Text = "Tu commences à te sentir fatigué.\nTa conscience te guide, au-delà des étangs, des montagnes,\nvers le soleil, au-delà des années-lumière,\nvers ce berceau unique de l'univers"
  },
  Event_7165_Name = {
    Text = "Cérémonie finale IV"
  },
  Event_7166_ChoiceDesc1 = {
    Text = "[Regardez plus]"
  },
  Event_7166_Desc = {
    Text = "Une immense ombre vous enveloppe complètement, une salive nauséabonde vous trempe.\n« Petit rat, viens ici. Juste un instant... »\n« Je jure, je n'ai aucune intention de te manger... »\n« Je ne regarderai même pas ton ventre juteux ! »"
  },
  Event_7166_Name = {
    Text = "Matériau n°12"
  },
  Event_7167_ChoiceDesc1 = {
    Text = "[Regardez plus]"
  },
  Event_7167_Desc = {
    Text = "La sculpture en cire flétrie du philosophe fume, enveloppée d'une brume blanche.\n\"L'autre rive existe mais est inconnaissable, c'est pourquoi elle reste inconnue.\"\n\"Imaginez ce monde comme un jeu...\nCe que vous cherchez pourrait être de l'autre côté de la carte.\""
  },
  Event_7167_Name = {
    Text = "Matériaux n°45"
  },
  Event_7168_ChoiceDesc1 = {
    Text = "[Regardez plus]"
  },
  Event_7168_Desc = {
    Text = "« Désolé, ce n'était pas intentionnel... »\n « Je n'aime pas les rats. Le problème avec les rats, c'est qu'ils n'ont jamais peur des humains... »\n Le vieux homme barbu est allongé dans un coin, ses yeux mélancoliques fixant intensément sur vous. \n « Bien sûr, vous êtes très entreprenants. \n C'est bien, mais ce n'est pas suffisant pour vous aider à échapper au cataclysme... »"
  },
  Event_7168_Name = {
    Text = "Matériau n°4"
  },
  Event_7169_ChoiceDesc1 = {
    Text = "[Montrer la malédiction] Choisissez 1 Carte d'instruction parmi 3 pour obtenir une Oraison : «(EnchantConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_7169_ChoiceDesc2 = {
    Text = "[Reject the Crow] Obtenez une oraison à 3 choix"
  },
  Event_7169_ChoiceDesc3 = {Text = "[Ignorez]"},
  Event_7169_Desc = {
    Text = "Un corbeau à multiples têtes, noir et malsain, s'échappe de la robe sombre d'un croyant de la lumière du temple et se pose sur ton épaule.\n« As-tu vu ma tête ? Il suffit de goûter à la malédiction, et je ferai pousser une nouvelle tête. Montre-moi ta malédiction ! »"
  },
  Event_7169_Name = {
    Text = "Corbeau maudit"
  },
  Event_7170_ChoiceDesc1 = {
    Text = "[Répondre à l'Appel] Retirez 1 carte de commandement et restaurez Arg1 Vie"
  },
  Event_7170_ChoiceDesc2 = {
    Text = "[I'm Not Fleeing] Gagnez Relique d'or \"(RelicConfig.Arg1)\", Infection \"(Skill.Arg2)\""
  },
  Event_7170_Desc = {
    Text = "Tu cours rapidement dans la ruelle. L'adrénaline s'éveille, l'acide lactique se forme, le glucose est consommé… le chaos ronge ton cerveau, envahissant ta pensée, t'incitant à fuir vers la fin dans un tourbillon de couleurs. \n Oui, une fuite. Si tu n'es vraiment pas en fuite, alors pourquoi t'attendent le chaos et le vide, le néant et l'issue sans résultat ?"
  },
  Event_7170_Name = {Text = "Courir"},
  Event_7171_ChoiceDesc1 = {
    Text = "[Tracer la Source du Son]"
  },
  Event_7171_ChoiceDesc2 = {
    Text = "[Summon Lily and Koum]"
  },
  Event_7171_Desc = {
    Text = ": Au loin dans le passage dimensionnel, des grognements graves et lourds se mêlent à la peur, l'attente, l'inquiétude, comme s'ils vous appelaient. Puis des murmures indistincts de fille, et les deux voix s'estompent"
  },
  Event_7171_Name = {
    Text = "Voix du guide"
  },
  Event_7172_ChoiceDesc1 = {Text = "[Pocketed]"},
  Event_7172_Desc = {
    Text = "Une matière argentée proche du mercure, extraite de la boue de dissolution, contenant un puissant pouvoir spirituel, utilisée principalement pour lier plus de réveilleurs lors des rituels"
  },
  Event_7172_Name = {
    Text = "Cœur d'argent"
  },
  Event_7173_ChoiceDesc1 = {
    Text = "[Ask to Clear the Path]"
  },
  Event_7173_ChoiceDesc2 = {
    Text = "[Ask for Identity]"
  },
  Event_7173_Desc = {
    Text = "Vous pénétrez dans un wagon sombre, une sensation étrange vous envahit. \n Ce wagon est désert, les passagers se sont déjà enfuis, et des corps mutilés de monstres gisent sur le sol, se dissipant progressivement. \n Au centre du wagon, se tient cet homme. \n « Je crois qu'il existe des destinées, et c'est le destin qui nous a fait prendre le même métro. »"
  },
  Event_7173_Name = {
    Text = ": Compagnon étrange IV"
  },
  Event_7174_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7174_Desc = {
    Text = "«Tes yeux sont magnifiques, comme des étoiles. »\nCharlotte rit doucement, ses cheveux fous tombant en douceur. \n« Tu dois être très populaire à l'école, je t'aime aussi. »\nAvant de partir, elle embrassa délicatement ton front. \nTu te sens chaud, comme si quelque chose avait changé."
  },
  Event_7174_Name = {
    Text = "Ombre de l'Enquêteur"
  },
  Event_7175_ChoiceDesc1 = {
    Text = "[Lire] choisir 1 carte parmi 3 pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_7175_ChoiceDesc2 = {
    Text = "[Store in Suitcase] Infectez \"(Skill.Arg1)\", gagnez la Relique : \"(RelicConfig.Arg2)\""
  },
  Event_7175_Desc = {
    Text = "Une page jaunie tombe de la robe de la croyante de la lumière du temple.  \nElle est couverte de textes étranges aux formes singulières, ressemblant à des symboles pictographiques, certains montent bizarrement, certains lettres se chevauchent même, avec peu de mots à peine lisibles"
  },
  Event_7175_Name = {
    Text = "Ordre secret · Haut"
  },
  Event_7176_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7176_Desc = {
    Text = "Tu dis : \"Oh, Charlotte ! Non !\"\nLes cheveux de Charlotte se tordent follement, elle est en colère.\n\"Je vais te le prouver ! Regarde ce que je peux faire !\""
  },
  Event_7176_Name = {
    Text = "Ombre de l'Enquêteur"
  },
  Event_7177_ChoiceDesc1 = {
    Text = "[Infect with \"(Skill.Arg1)\" and obtain the Silver Relic \"(RelicConfig.Arg2)\"]"
  },
  Event_7177_ChoiceDesc2 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_7177_Desc = {
    Text = "Événement 302 (en cours de développement), effet non final"
  },
  Event_7177_Name = {
    Text = "Événement302 (en développement)"
  },
  Event_7178_ChoiceDesc1 = {
    Text = "[AccepterLaDemande] Infectez avec \"(Skill.Arg1)\", obtenez la Reliquaire en Argent \"(RelicConfig.Arg2)\""
  },
  Event_7178_ChoiceDesc2 = {
    Text = "[Refuse Request] Obtenez 25 sigils noirs"
  },
  Event_7178_Desc = {
    Text = "La mâchoire craque, le son suit un rythme régulier, et ton compagnon connaît justement quelques notions de cryptographie. \n Le texte déchiffré est le suivant : \n « Bonjour, appelez-moi docteur @2. J'étais un collectionneur, un naturaliste... \n (ici, une longue présentation de sa carrière et de ses titres, omise) \n En résumé, peux-tu m'aider à trouver ma moitié ? C'est un petit morceau de mâchoire supérieure. \n Dès que tu pourras le trouver, ma collection personnelle s'ouvrira à toi. »"
  },
  Event_7178_Name = {Text = "Craquement"},
  Event_7179_ChoiceDesc1 = {
    Text = "[Invest 100 Fang] Infecter \"(Skill.Arg1)\", gagner la Relique d'Argent \"(RelicConfig.Arg2)\""
  },
  Event_7179_ChoiceDesc2 = {
    Text = "[Invest Five Pensh] Gagnez 25 Sigils noirs."
  },
  Event_7179_Desc = {
    Text = "Le portefeuille brodé se tord et ouvre une large bouche noire.\nDepuis qu'il a quitté sa riche propriétaire, il meurt de faim depuis des décennies.\nTu regardes à l'intérieur et tu ne vois que des ténèbres denses"
  },
  Event_7179_Name = {
    Text = "Porte-monnaie gourmand"
  },
  Event_7180_ChoiceDesc1 = {
    Text = "[Steadfast Determination] Retirez 1 carte de commandement et restaurez Arg1 Vie"
  },
  Event_7180_ChoiceDesc2 = {
    Text = "[Desire for Success] Obtenir la relique d'or \"(RelicConfig.Arg1)\", infecter \"(Skill.Arg2)\""
  },
  Event_7180_Desc = {
    Text = "« Deux têtes de mule, l'hôpital est déjà très dangereux, » la voix de Poupée retentit soudain dans le communicateur, « que comptez-vous faire ensuite, recoudre sa tête ? »\n « Ce n'est pas le moment de dire des bêtises, Poupée ! »\n « Je sais, je peux l'entendre. » dit Poupée, « Reste calme, sais-tu quel est le secret du succès ? »"
  },
  Event_7180_Name = {
    Text = "Règle de Logan"
  },
  Event_7181_ChoiceDesc1 = {
    Text = "[Infect with \"(Skill.Arg1)\" and obtain the Silver Relic \"(RelicConfig.Arg2)\"]"
  },
  Event_7181_ChoiceDesc2 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_7181_Desc = {
    Text = "Événement 304 (en cours de développement), effet non final"
  },
  Event_7181_Name = {
    Text = "Événement304 (en développement)"
  },
  Event_7182_ChoiceDesc1 = {
    Text = "[Infect with \"(Skill.Arg1)\" and obtain the Silver Relic \"(RelicConfig.Arg2)\"]"
  },
  Event_7182_ChoiceDesc2 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_7182_Desc = {
    Text = "Événement 305 (en cours de développement), effet non final"
  },
  Event_7182_Name = {
    Text = "Événement305 (en développement)"
  },
  Event_7183_ChoiceDesc1 = {
    Text = "[Raccrocher le récepteur] Obtenez une oraison avancée à 3 choix"
  },
  Event_7183_ChoiceDesc2 = {
    Text = "[Répondre au Téléphone] Obtenez Relique d'Or \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_7183_ChoiceDesc3 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_7183_Desc = {
    Text = "En passant devant la salle de repos du chef de train, un téléphone sonne bruyamment dans un coin caché"
  },
  Event_7183_Name = {
    Text = "Train en approche"
  },
  Event_7184_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7184_Desc = {
    Text = "La splendeur est terne, mais elle existe réellement.\nUn cœur d'argent si terne est difficile à invoquer des réveilleurs, mais il est excellent pour les renforcer — c'est ça, la technologie de copeaux d'argent"
  },
  Event_7184_Name = {
    Text = "Preuve d'existence"
  },
  Event_7185_ChoiceDesc1 = {
    Text = "[Lady's Portrait] Améliorez au hasard la qualité de l'oraison d'1 carte."
  },
  Event_7185_ChoiceDesc2 = {
    Text = "[Photo de famille en statues de cire] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_7185_Desc = {
    Text = "Le musée de la cire abrite également de nombreuses œuvres picturales.\nPersonnages, paysages, natures mortes, réalistes, abstraites…\nElles décorent les murs initialement monotones, les rendant moins ennuyeux.\nVotre regard est profondément captivé par l'une d'elles, c'est une——"
  },
  Event_7185_Name = {
    Text = "Galerie des portraits"
  },
  Event_7186_ChoiceDesc1 = {
    Text = "[Continuer à tourner les pages] une carte de commande aléatoire obtient oraison:[(EnchantConfig.Arg1)]"
  },
  Event_7186_ChoiceDesc2 = {
    Text = "[Partir] Augmente Arg1 points de santé max, infection[(Skill.Arg2)]"
  },
  Event_7186_Desc = {
    Text = "Une balance pour peser.\nDerrière, d'innombrables organes sont trempés dans du formol rouge.\nIls sont soigneusement empilés sur des étagères de stockage.\nVous ramassez distraitement un carnet à proximité et le feuilletez :\n\"Cœur : 8 oz, Cerveau : 50 oz...\""
  },
  Event_7186_Name = {
    Text = "Enregistrement d'organes"
  },
  Event_7187_ChoiceDesc1 = {
    Text = "[Ouvrir le cadeau] Recevoir une carte spéciale"
  },
  Event_7187_Desc = {
    Text = "L'ombre de l'enfant passe devant vous, vous ne pouvez pas dire s'il s'agit d'un véritable enfant ou d'une sorte de projection spirituelle dans le domaine. Mais—vous regardez la boîte laissée au sol, où il est écrit en lettres enfantines « cadeau »"
  },
  Event_7187_Name = {
    Text = "Cadeau bienveillant"
  },
  Event_7188_ChoiceDesc1 = {
    Text = "[Appel le corbeau]Obtenir 40 Marque noire, infecter «(Skill.Arg2)», continuer à choisir"
  },
  Event_7188_ChoiceDesc2 = {
    Text = "[Partir loin] Obtient 25 sigils noirs"
  },
  Event_7188_Desc = {
    Text = "Une mouette blanche perchée sur le mât, recouvert de givre.\nLes cornes résonnent en harmonie, repoussant la présence noire et l'oiseau noir étranger"
  },
  Event_7188_Name = {
    Text = "Corbeau Solitaire"
  },
  Event_7189_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7189_Desc = {
    Text = "Vous avez reconnu que la chanson avait été adaptée d'une chanson d'amour.\nÀ la fin de cette chanson d'amour, le poète a dit :\n\"Jusqu'à ce que la voix de l'humanité nous réveille, nous nous noierons.\"\nPas maintenant, pensiez-vous.\nVous attendez toujours que l'humanité vous réveille."
  },
  Event_7189_Name = {
    Text = "Voix des corbeaux"
  },
  Event_7190_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7190_Desc = {
    Text = "Un rouleau de film poussiéreux. Mais il n'y a pas de projecteur ici, et ce n'est pas le moment de profiter du manoir, du film et du thé de l'après-midi.\nPeut-être qu'un jour, tu pourras découvrir ce qu'il contient"
  },
  Event_7190_Name = {
    Text = "Souvenirs lumineux"
  },
  Event_7191_ChoiceDesc1 = {
    Text = "[Partir] Obtient 3 choix 1 gravure avancée, infection «(Skill.Arg1)»"
  },
  Event_7191_Desc = {
    Text = "Tu suis le garçon, ni trop près ni trop loin. \n Tac. Tac. Tac... Le garçon s'arrête au coin de la rue. \n Tu vois la lueur rouge précaire derrière lui, ton instinct te dit que le musée de cire est juste devant. \n Le garçon se retourne. Il n'a pas d'yeux, ses orbites sont noires. \n Il te sourit."
  },
  Event_7191_Name = {
    Text = "Cérémonie finale I"
  },
  Event_7192_ChoiceDesc1 = {
    Text = "[Partir] Obtient 50 sigils noirs, infection[(Skill.Arg1)]"
  },
  Event_7192_Desc = {
    Text = "Tu lui as tapoté l'épaule. \n Le garçon se retourne, il n'a pas d'yeux, ses orbites sont noires. \n « Bonsoir. Je cherche le chemin vers le musée de cire. » \n Le garçon pointe devant lui. Tu vois la lueur rouge précaire derrière lui. \n Ton instinct te dit que le musée de cire est juste là. \n Revenant à toi, le garçon est déjà parti, ne laissant que l'ombre étirée par le lampadaire."
  },
  Event_7192_Name = {
    Text = "Cérémonie finale I"
  },
  Event_7193_ChoiceDesc1 = {
    Text = "[Maintenir le Corbeau] Obtenir 35 le sigil noir, infecter [(Skill.Arg2)], continuer la sélection"
  },
  Event_7193_ChoiceDesc2 = {
    Text = "[Ignorez-le] Partez"
  },
  Event_7193_Desc = {
    Text = "Le corbeau solitaire, d'une voix rauque, arrache ses plumes noires une à une.\nIl tremble de douleur, criant aigu, mais ne peut pas arrêter son rythme de plus en plus frénétique.\n\"Caw—Caw—\"\nDes larmes bleues mélangées à un ooze noir coulent de ses yeux, témoins uniquement pour vous."
  },
  Event_7193_Name = {
    Text = "Larme de lave fondue"
  },
  Event_7194_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7194_Desc = {
    Text = "Une connaissance inestimable afflue dans ton esprit, puis se transforme en brume... Quand tu te réveilles, ce livre à la couverture jaune étrange a déjà disparu"
  },
  Event_7194_Name = {
    Text = "Parchemin jaune"
  },
  Event_7195_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7195_Desc = {
    Text = "Tu as facilement vaincu ces statues de cire. Elles sont tombées, la tête baissée, devant toi. \n Au bas des statues, il semble qu'il y ait quelques lignes écrites. \n « Aluviion @2 an 11 \n fabriqué par Rogers à @2 Académie » \n Tu te souviens que Rogers avait étudié la sculpture dans une certaine académie d'art, ces statues de cire maladroites doivent être ses études de l'époque."
  },
  Event_7195_Name = {Text = "Étude"},
  Event_7196_ChoiceDesc1 = {Text = "[Why?]"},
  Event_7196_ChoiceDesc2 = {
    Text = "[Descend into Aequor]"
  },
  Event_7196_Desc = {
    Text = "«Imposteur ! Rends-moi mon fils !»\n«Tu n'es pas la Sainte de la navigation ? Ta responsabilité n'est-elle pas de protéger les navires ? Pourquoi une seule embarcation est revenue, dis-le, dis-le !»\n«Noyez-la ! Elle doit éprouver la souffrance que mon père a endurée avant de mourir !»\n«Noyez-la, noyez-la !»\n«Noyez cette imposture ! Attachez-la à la pierre !»\nL'eau de mer s'engouffre dans son nez et sa bouche, l'air étant expulsé de chaque recoin de ses poumons, elle porte également cette somptueuse et pure robe blanche. \nPresque comme si c'était la première pensée après être devenue Sainte, émergeant des coins les plus sombres de son esprit, tardive. \n«Oui, pourquoi ces navires ont-ils coulé ?»"
  },
  Event_7196_Name = {Text = "Sombrer"},
  Event_7197_ChoiceDesc1 = {
    Text = "[Maintenir le Corbeau] Obtenir 30 le sigil noir, infecter [(Skill.Arg2)], continuer la sélection"
  },
  Event_7197_ChoiceDesc2 = {
    Text = "[Ignorez-le] Partez"
  },
  Event_7197_Desc = {
    Text = "Le corbeau solitaire, d'une voix rauque, arrache ses plumes noires une à une.\nIl tremble de douleur, criant aigu, mais ne peut pas arrêter son rythme de plus en plus frénétique.\n\"Caw—Caw—\"\nDes larmes bleues mélangées à un ooze noir coulent de ses yeux, témoins uniquement pour vous."
  },
  Event_7197_Name = {
    Text = "Larme de lave fondue"
  },
  Event_7198_ChoiceDesc1 = {
    Text = "[Continuer à chercher] Augmenter Arg1 points de vie, infecter[(Skill.Arg2)]"
  },
  Event_7198_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7198_Desc = {
    Text = "Comme si une main s'était posée sur ton épaule, ferme et déterminée, mais en te retournant, cette sensation tangible devint évanescente"
  },
  Event_7198_Name = {
    Text = "Contact Anormal"
  },
  Event_7199_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7199_Desc = {
    Text = "Le pont ferroviaire de Rai, les veines et les nerfs de Londinium, relie le cœur et les membres de la ville. Le Sanatorium Rye attend tranquillement à l'extrémité des membres, prêt pour le transport de sang et de signaux."
  },
  Event_7199_Name = {
    Text = "Illusion Ferroviaire"
  },
  Event_7200_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7200_Desc = {
    Text = "Tu poses la valise par terre et la piétines pour t'assurer qu'elle ne tremble plus, puis tu la reprends.\nTu époussettes la poussière sous le regard perplexe de Murphy, et vous continuez"
  },
  Event_7200_Name = {
    Text = "Lettre inattendue"
  },
  Event_7201_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7201_Desc = {
    Text = "Le danger te guette derrière une porte en bois, pas le moment de traîner. Mets-le dans ta valise"
  },
  Event_7201_Name = {
    Text = "Parchemin jaune"
  },
  Event_7202_ChoiceDesc1 = {
    Text = "[Chasser les corbeaux] obtenir Arg1 sigils noirs, infecter[(Skill.Arg2)], continuer à choisir"
  },
  Event_7202_ChoiceDesc2 = {
    Text = "[Ignorez] Partez"
  },
  Event_7202_Desc = {
    Text = "Il, ou plutôt ils, tournent dans la chambre, frappant l'abat-jour avec fracas"
  },
  Event_7202_Name = {
    Text = "Lanterne Corbeau"
  },
  Event_7203_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7203_Desc = {
    Text = "Ici, c'est le domaine de l'esprit, le monde de la gnose.\nÀ part troubler ton esprit, ils ne peuvent rien faire"
  },
  Event_7203_Name = {
    Text = "Tempête de Connaissance"
  },
  Event_7204_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7204_Desc = {
    Text = ": Crâne : Hank Tillinghast A.F.186-A.F.203 Île de Créole\nColonne vertébrale : Andy Crawford A.F.177-A.F.203 Narragansett\n... Mieux vaut ne pas y penser"
  },
  Event_7204_Name = {Text = "Plaque"},
  Event_7205_ChoiceDesc1 = {
    Text = "[Check Fragment] Tirez aléatoirement 3 cartes de commande du paquet, supprimez 1 carte, et gagnez 75 sigils noirs."
  },
  Event_7205_ChoiceDesc2 = {
    Text = "[Ask the Doll] Obtenez 3 cartes de commande aléatoires du deck, choisissez 1 carte originale à ajouter au deck, et gagnez 25 sigils noirs."
  },
  Event_7205_ChoiceDesc3 = {
    Text = "[Disregard] Gagnez 50 Sigils Noirs"
  },
  Event_7205_Desc = {
    Text = "Le fragment métallique que te donne poupée s'agite anxieusement sur ta poitrine, tel un papillon effrayé"
  },
  Event_7205_Name = {
    Text = "Broche Inquiète"
  },
  Event_7206_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7206_Desc = {
    Text = "\"Il attend tranquillement à la ligne d'arrivée, peu importe où tu fixes le point d'arrivée - regarde cette jeune gardienne ; son évitement conduit finalement à la folie.\""
  },
  Event_7206_Name = {
    Text = "Objet de quête"
  },
  Event_7207_ChoiceDesc1 = {
    Text = "[Leave] Rien trouvé"
  },
  Event_7207_Desc = {
    Text = "En développement, événement spécial"
  },
  Event_7207_Name = {
    Text = "2_16 temporaire"
  },
  Event_7208_ChoiceDesc1 = {
    Text = "[Comfort It] Increase max health by Arg1"
  },
  Event_7208_ChoiceDesc2 = {
    Text = "[Ne pas y prêter attention] 2 Cartes d'instruction aléatoires obtiennent l'Oraison : «(EnchantConfig.Arg1)», infecter 2 «(Skill.Arg2)»"
  },
  Event_7208_Desc = {
    Text = "Le lien réchauffe l'organe encore humain du cœur.\nIl imite le rythme de respiration du lien, battant comme s'il s'assurait de ne pas être abandonné, s'appropriant le droit d'accompagner le lien pour l'éternité"
  },
  Event_7208_Name = {
    Text = "Atrium gauche"
  },
  Event_7209_ChoiceDesc1 = {
    Text = "Oraison avancée aléatoire"
  },
  Event_7210_ChoiceDesc1 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_7210_Desc = {
    Text = "Ton indifférence déçoit la voix, l'eau se ride légèrement, puis redevient calme"
  },
  Event_7210_Name = {
    Text = "Voix hors du monde"
  },
  Event_7211_ChoiceDesc1 = {
    Text = "[Choisir 1 carte pour obtenir une oraison :«(EnchantConfig.Arg1)»]tester l'oraison"
  },
  Event_7211_ChoiceDesc2 = {
    Text = "[Choisir 1 carte pour obtenir une oraison :«(EnchantConfig.Arg1)»]tester le paquet de butin"
  },
  Event_7211_Desc = {
    Text = "Tester l'oraison spécifiée"
  },
  Event_7211_Name = {
    Text = "Tester l'oraison désignée 1"
  },
  Event_7212_ChoiceDesc1 = {
    Text = "[Leave] Choisissez de Réveiller 1 Réveilleur"
  },
  Event_7212_Desc = {
    Text = "Vous avez doucement tapoté la tête du garçon, l'amenant à réciter avec vous. \n\"Une chanson pour maman—\" \nLes voix, comme des papillons de nuit, dérivaient côte à côte depuis la scène vide, \natterrissant doucement dans le public noir comme du charbon."
  },
  Event_7212_Name = {
    Text = "Cérémonie finale III"
  },
  Event_7213_ChoiceDesc1 = {
    Text = "[Partir] Obtient 3 choix 1 relique en or, infection[(Skill.Arg1)]"
  },
  Event_7213_Desc = {
    Text = "Tu ne dis rien. Une dame surgit soudain sur scène. \n Elle ouvre la bouche du garçon avec frénésie et enfonce violemment le bâton qu'elle tient. \n « Parle, dis-moi quelque chose. » \n Du sang noir coule de la bouche du garçon. Il continue à réciter de manière indistincte. \n « Chanson pour maman... »"
  },
  Event_7213_Name = {
    Text = "Cérémonie finale III"
  },
  Event_7215_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7215_Desc = {
    Text = "Ce n'est pas une fenêtre, c'est un miroir. Le visage tendu de Ramona s'y reflète.\nPourquoi cette pièce n'a-t-elle pas de fenêtre, mais un grand miroir sur le mur ?"
  },
  Event_7215_Name = {
    Text = "Reflet dans la fenêtre"
  },
  Event_7216_ChoiceDesc1 = {
    Text = "[Tenir la clé d'argent] Réveiller aléatoirement un éveillé, Infecter[(Skill.Arg1)]"
  },
  Event_7216_ChoiceDesc2 = {
    Text = "[Fermer les yeux] choisir 1 carte parmi 3 pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_7216_Desc = {
    Text = "Tu es déchiré par une absurdité gigantesque, rampante et tordue sur le sol, comme si tu étais manipulé par un @2 venu d'une dimension extérieure. \n«Non... non... »\nTa raison s'effondre petit à petit, un rire fou et des cris indistincts s'entrelacent, comme un immense filet qui entrave ta conscience, ne laissant échapper que des gémissements confus."
  },
  Event_7216_Name = {
    Text = "Œil de contemplation"
  },
  Event_7217_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7217_Desc = {
    Text = "Les couleurs de la galaxie changent, dessinant des motifs indescriptibles à vos pieds, magnifiques comme des rubis, mais gonflés comme des méduses. Une lumière rouge émane de la valise"
  },
  Event_7217_Name = {
    Text = "Croisements des Étoiles"
  },
  Event_7218_ChoiceDesc1 = {
    Text = "[Dispel the Illusion] Stress +10."
  },
  Event_7218_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7218_Desc = {
    Text = "Des visages flous apparaissent soudainement, entourant et gémissant désespérément sans cordes vocales"
  },
  Event_7218_Name = {Text = "Illusion"},
  Event_7221_ChoiceDesc1 = {
    Text = "[Attraper] Obtenez une relique d'argent[(RelicConfig.Arg1)]"
  },
  Event_7221_ChoiceDesc2 = {
    Text = "[Regarder vers le bas] Gagnez 75 le sigil noir, infectez[(Skill.Arg2)]"
  },
  Event_7221_Desc = {
    Text = "Les corbeaux tournoient dans le ciel morcelé par les ruelles, émettant des cris rauques et inquiétants.\n Soudain, ils deviennent agités, comme si une nature morbide se réveillait ou se tordait, se battant et se poursuivant férocement, quelque chose tombe dans leur lutte"
  },
  Event_7221_Name = {
    Text = "Essaim de corbeaux en furie"
  },
  Event_7222_ChoiceDesc1 = {
    Text = "[Follow the Instructions] Augmentez la Vie d'Arg1"
  },
  Event_7222_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7222_Desc = {
    Text = "Vous essayez d'utiliser le pouvoir de traçage de la clé en argent pour trouver le point de jonction le plus proche, mais les informations obtenues contiennent des anomalies difficiles à détecter, comme si elles étaient perturbées"
  },
  Event_7222_Name = {
    Text = "Contact Anormal"
  },
  Event_7223_ChoiceDesc1 = {
    Text = "[Remettre à la poupée] Tirez une carte de commandement au hasard pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_7223_ChoiceDesc2 = {
    Text = "[Lire la plaque] augmenter Arg1 points de santé max, infecter[(Skill.Arg2)]"
  },
  Event_7223_Desc = {
    Text = "Un panneau métallique est tombé du corps d'expérimentation des sculpteurs que tu as vaincus. La clé en argent a réagi au panneau, émettant une légère lueur"
  },
  Event_7223_Name = {Text = "Plaque"},
  Event_7224_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7224_Desc = {
    Text = "Le porteur de la lame pousse un long cri, comme un fracas capable de trancher montagnes et océans.\nLe son s'estompe instantanément, emportant deux autres marins... Ce n'était qu'une illusion reflétée par le domaine"
  },
  Event_7224_Name = {
    Text = "Poursuivre sans relâche"
  },
  Event_7225_ChoiceDesc1 = {
    Text = "[Repair Wax Sculpture] Choisissez une carte et réduisez son coût en Arithmetica de 1"
  },
  Event_7225_Desc = {
    Text = "Tu tiens une bougie, traverses la brume et te retrouves devant elle.\nC'est une statue de cire inachevée.\nSon visage est divisé en deux, une moitié sourit, l'autre @1.\nDeviens son dieu.\nDonne-lui beauté et larmes.\nSculpte-la ou détruis-la"
  },
  Event_7225_Name = {
    Text = "Statue de cire inachevée"
  },
  Event_7226_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7226_Desc = {
    Text = "\"Bien sûr, j'ai été témoin de l'extinction de mes propres yeux.\" Tu as répondu.\nOui, ce n'était que la mort violente d'une petite souris, la pourriture d'un cœur, et un bouquet d'iris plongé dans le funérail de la nuit."
  },
  Event_7226_Name = {
    Text = "Royaume Perdu des Dieux"
  },
  Event_7227_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7227_Desc = {
    Text = "\"Royaume Divin... disparition... sujets illusoires... Je ne sais pas ce qui compte comme disparition.\"\nLes deux figures rient doucement, entourées de fragments de lumière blanche scintillante.\n\"Alors maintenant, vous allez témoigner de la véritable disparition.\""
  },
  Event_7227_Name = {
    Text = "Royaume Perdu des Dieux"
  },
  Event_7228_ChoiceDesc1 = {
    Text = "[Combine Pages] Obtenez la Relique d'or \"(RelicConfig.Arg1)\", infectée avec \"(Skill.Arg2)\""
  },
  Event_7228_ChoiceDesc2 = {
    Text = "[Lire] choisir 1 carte parmi 3 pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_7228_ChoiceDesc3 = {
    Text = "[Discard It] Gagnez 50 Sigils Noirs"
  },
  Event_7228_Desc = {
    Text = "Une page jaunie tombe de la robe des Porteurs de lanternes. \nElle est couverte de textes étranges, certains ressemblant à des symboles pictographiques, d'autres montant bizarrement, certaines lettres se chevauchant même, avec peu de mots à peine lisibles. \nLe titre est «@2 La naissance du Fils Saint»"
  },
  Event_7228_Name = {
    Text = "Ordre secret · Bas"
  },
  Event_7229_ChoiceDesc1 = {
    Text = "[Struggle] Obtenez la Relique Argent \"(RelicConfig.Arg1)\", infectez \"(Skill.Arg2)\""
  },
  Event_7229_ChoiceDesc2 = {
    Text = "[Sink] Obtenez une relique argentée \"(RelicConfig.Arg1)\", infectez \"(Skill.Arg2)\""
  },
  Event_7229_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_7229_Desc = {
    Text = "« J'ai tellement de douleur, tellement de douleur... »\n« Pourquoi moi, pourquoi dois-je traverser cela ? »\n« Ô Père Dieu miséricordieux, qu'ai-je fait de mal ? »\n Tristesse, douleur, colère, rancœur... Les émotions des « patients » pèsent lourdement sur toi, tu te tiens la poitrine, incapable de respirer."
  },
  Event_7229_Name = {Text = "Addiction"},
  Event_7230_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7230_Desc = {
    Text = "Le regard perce la chair, marquant la rétine du pionnier.\nPersonne ne peut échapper, tout comme personne @2"
  },
  Event_7230_Name = {Text = "Épier"},
  Event_7231_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7231_Desc = {
    Text = [[
Concentre-toi, identifie les paroles, puis ressens le choc des mots chaotiques.
Ce ne sont pas des mots humains]]
  },
  Event_7231_Name = {
    Text = "Chant de la mer"
  },
  Event_7232_ChoiceDesc1 = {
    Text = "[Essayer le défi] infecter[(Skill.Arg1)], victoire : obtenir une relique en or, échec : obtenir 50 sigils noirs"
  },
  Event_7232_ChoiceDesc2 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_7232_Desc = {
    Text = "Tu as vu des secrets dans cette flaque de boue noire réfléchissante.\nSon reflet est flou, entouré d'une brume noire persistante, tu te sens étrangement familier, mais tu ne peux pas l'identifier"
  },
  Event_7232_Name = {
    Text = "Sous la surface du miroir"
  },
  Event_7233_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7233_Desc = {
    Text = "Tu méprises les lettres anonymes mystiques, et les brûles sans hésitation, les transformant en cendres volantes"
  },
  Event_7233_Name = {
    Text = "Une autre lettre de détresse"
  },
  Event_7234_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7234_Desc = {
    Text = "Tu examines la lettre, le sceau est collant, un mélange de sang et de substance noire, avec quelques cheveux collés"
  },
  Event_7234_Name = {
    Text = "Une autre lettre de détresse"
  },
  Event_7235_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7235_Desc = {
    Text = ": En suivant la direction des lettres tombées, tu aperçus un objet brillant au coin du mur"
  },
  Event_7235_Name = {
    Text = "Une autre lettre de détresse"
  },
  Event_7236_ChoiceDesc1 = {
    Text = "[Continuer à chercher] Augmenter Arg1 points de vie, infecter[(Skill.Arg2)]"
  },
  Event_7236_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7236_Desc = {
    Text = "Une lueur discrète apparaît, brillante et chaude, mais disparaît soudainement quand tu t'en approches"
  },
  Event_7236_Name = {
    Text = "Contact Anormal"
  },
  Event_7237_ChoiceDesc1 = {
    Text = "[Leave] Tous les Réveilleurs récupèrent Arg1 Aliemus"
  },
  Event_7237_Desc = {
    Text = "Tu fermes les yeux de peur.\n\"Tu as soulevé le voile...\nLe secret, tu as découvert le secret...\" \nLes vagues sonores forment un océan tumultueux, le sol tremble violemment sous une résonance terrifiante.\nTu n'en peux plus, ouvres brusquement les yeux, mais il n'y a rien autour de toi"
  },
  Event_7237_Name = {
    Text = "Cérémonie finale V"
  },
  Event_7238_ChoiceDesc1 = {
    Text = "[Continuer à chercher] Augmenter Arg1 points de vie, infecter[(Skill.Arg2)]"
  },
  Event_7238_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7238_Desc = {
    Text = "Ton nez détecte une odeur familière, simple et satisfaisante. Lorsque tu veux la sentir à nouveau, elle disparaît complètement"
  },
  Event_7238_Name = {
    Text = "Contact Anormal"
  },
  Event_7239_ChoiceDesc1 = {
    Text = "[Continuer à chercher] Augmenter Arg1 points de vie, infecter[(Skill.Arg2)]"
  },
  Event_7239_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7239_Desc = {
    Text = "Des mots familiers résonnent à vos oreilles, réconfortants et rassurants, mais s'arrêtent brusquement lorsque vous essayez de les suivre"
  },
  Event_7239_Name = {
    Text = "Contact Anormal"
  },
  Event_7240_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7240_Desc = {
    Text = "Le pouvoir de retracer ne peut pas à nouveau trouver un point de contact pour vous dans un court laps de temps, mais vous avez au moins reçu un apaisement temporaire"
  },
  Event_7240_Name = {
    Text = "Contact Anormal"
  },
  Event_7241_ChoiceDesc1 = {
    Text = "[Continuer à chercher] Augmenter Arg1 points de vie, infecter[(Skill.Arg2)]"
  },
  Event_7241_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7241_Desc = {
    Text = "Comme si une main s'était posée sur ton épaule, ferme et déterminée, mais en te retournant, cette sensation tangible devint évanescente"
  },
  Event_7241_Name = {
    Text = "Contact Anormal"
  },
  Event_7242_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7242_Desc = {
    Text = "\"L'ombre de \"N\" a été dispersée par le coup de poing, des particules noires fusionnant avec le brouillard du Domaine, difficile à tracer.\n\"Pas amusant, mais intrigant. J'attendrai avec impatience notre véritable rencontre...\""
  },
  Event_7242_Name = {
    Text = "Le spectacle commence"
  },
  Event_7243_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7243_Desc = {
    Text = "\n\"Bon enfant. Mais néanmoins, je dois te donner une petite punition.\"\nLe rire léger de Jonquille s'est estompé dans la faille dimensionnelle."
  },
  Event_7243_Name = {
    Text = "Temps restant"
  },
  Event_7244_ChoiceDesc1 = {
    Text = "[Positive] 50% de chances d'obtenir une Relique d'Or \"(RelicConfig.Arg2)\", 50% de chances d'être infecté par \"(Skill.Arg3)\""
  },
  Event_7244_ChoiceDesc2 = {
    Text = "[opposé] 50% de chances d'obtenir 75 le sigil noir, 50% de chances de contaminer[(Skill.Arg3)]"
  },
  Event_7244_ChoiceDesc3 = {
    Text = "[Black Chip] 50% de chance d'obtenir une relique maudite \"(RelicConfig.Arg2)\", 50% de chance d'infecter \"(Skill.Arg3)\""
  },
  Event_7244_Desc = {
    Text = "Très bien... très bien...\nAlors, choisis ta mise"
  },
  Event_7244_Name = {
    Text = "Le spectacle commence"
  },
  Event_7245_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7245_Desc = {
    Text = "\"D'accord, d'accord. Ce type a toujours eu un faible pour les créatures interdimensionnelles. J'ai dû fournir beaucoup d'efforts pour naviguer librement à travers ces déchirures dimensionnelles. Ah, cela devait être il y a 3 000 ans.\""
  },
  Event_7245_Name = {
    Text = "Temps restant"
  },
  Event_7246_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7246_Desc = {
    Text = "Je suis sûr que le directeur de recherche n'installera pas de bombe dans ta poitrine"
  },
  Event_7246_Name = {
    Text = "Broche Inquiète"
  },
  Event_7247_ChoiceDesc1 = {
    Text = "[Leave] Retirez 1 carte de commandement et gagnez 25 sigils noirs."
  },
  Event_7247_Desc = {
    Text = "\"Un étranger bienveillant, offrant des conseils aux perdus,\" dit-il avec un sourire en coin, \"Voyage léger. Cerbère vous attend.\"\nL'appareil dans sa main a soudain vibré."
  },
  Event_7247_Name = {
    Text = ": Compagnon étrange III"
  },
  Event_7248_ChoiceDesc1 = {
    Text = "[Se déplacer lentement] Choisissez 1 carte de commandement parmi 3 pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_7248_ChoiceDesc2 = {
    Text = "[se pencher et s'allonger] choisissez une carte parmi 3 cartes de commandement et obtenez l'oraison : [(EnchantConfig.Arg1)]"
  },
  Event_7248_Desc = {
    Text = "\"En rencontrant des marais, ne lutte jamais.\" \nTu gardes cette règle de survie en tête, debout aussi immobile qu'une statue de l'île de Pâques. \nCinq minutes, dix minutes, une heure... la boue noire a finalement perdu patience et a disparu sous tes pieds."
  },
  Event_7248_Name = {
    Text = "Marais Sombre"
  },
  Event_7249_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7249_Desc = {
    Text = "Tu remarques une main si différente. Elle est fine, claire, et reste calme tout du long.\nPlus important encore - tu reconnais que c'est ta propre main.\nTu l'as doucement saisie.\nCette main a également saisi la tienne. Tu ressens un froid glacial et une illusion, puis le marais disparaît"
  },
  Event_7249_Name = {
    Text = "Marais Sombre"
  },
  Event_7250_ChoiceDesc1 = {
    Text = "[Couper une Main] Choisir une carte de commandement parmi 3 pour obtenir une oraison : [(EnchantConfig.Arg1)]"
  },
  Event_7250_ChoiceDesc2 = {
    Text = "[Apaiser eux] Choisissez 1 carte parmi 3 cartes de commandement pour obtenir oraison :[(EnchantConfig.Arg1)]"
  },
  Event_7250_Desc = {
    Text = "Tu brandis la lame dans ta main, les tranchant un par un. \n Toutes sortes de sang éclaboussent ton corps, ton visage et tes cheveux, mais tu ne t'en rends même pas compte. \n D'innombrables mains poussent des cris de douleur, et le marais disparaît. \n Ce n'est qu'une semaine plus tard que tu ne entendras plus ces pleurs dans tes cauchemars."
  },
  Event_7250_Name = {
    Text = "Marais Sombre"
  },
  Event_7251_ChoiceDesc1 = {
    Text = "[Ramasser le cœur d'argent] Transformez 1 relique d'argent en relique en or[(RelicConfig.Arg1)]"
  },
  Event_7251_ChoiceDesc2 = {
    Text = "[Attempt Awakening] Gagnez la Relique d'or \"(RelicConfig.Arg1)\", Infection \"(Skill.Arg2)\" et \"(Skill.Arg3)\""
  },
  Event_7251_ChoiceDesc3 = {
    Text = "[Ignorez] Gagnez 25 sigils noirs"
  },
  Event_7251_Desc = {
    Text = "Sous les planches lâches du pont, une boue noire nauséabonde s'écoule.\nEt dans cette boue, un éclat familier, le \"noyau d'argent\""
  },
  Event_7251_Name = {
    Text = "Preuve d'existence"
  },
  Event_7252_ChoiceDesc1 = {
    Text = "[Choisir la souris] tirer au hasard 1 carte de commandement pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_7252_ChoiceDesc2 = {
    Text = "[Choisir la bougie] augmenter Arg1 points de santé max, infecter[(Skill.Arg2)]"
  },
  Event_7252_Desc = {
    Text = "Le corps dissous se dissipe devant vous, les cendres froides se mêlent à la brume et forment une balance étrange. D'un côté se trouve une souris endormie, de l'autre une bougie sculptée en forme de garçon.\nDans un éclat de lucidité, vous savez que vous devez faire un choix"
  },
  Event_7252_Name = {
    Text = "Raison et Émotion"
  },
  Event_7253_ChoiceDesc1 = {
    Text = "[Probe à Haute Voix]"
  },
  Event_7253_ChoiceDesc2 = {
    Text = "[Follow Secretly]"
  },
  Event_7253_Desc = {
    Text = "En tournant à un coin, tout autour devient de plus en plus flou, seule une terrifiante clameur reste claire. \n Des pas se font entendre, tu te retournes et aperçois vaguement une silhouette étrange : il semble s'agir d'une personne, mais derrière elle se trouvent des ombres en paire, qui ressemblent à un énorme papillon. \n « Fais attention, » murmure Ramona, « dans le Labyrinthe, ce que tu vois n'est pas toujours la réalité. Si tu suis imprudemment, cela pourrait être dangereux. »"
  },
  Event_7253_Name = {
    Text = "Figure dans la brume"
  },
  Event_7254_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7254_Desc = {
    Text = "Tu sors la clé en argent, tristement et avec dévotion, la serres dans ta paume, une lueur brumeuse t'enveloppe.\nDans un silence, seul le soupir résonne"
  },
  Event_7254_Name = {
    Text = "Œil de contemplation"
  },
  Event_7255_ChoiceDesc1 = {
    Text = "[Choisir la rivière d'argent] tirer au hasard 1 carte de commandement pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_7255_ChoiceDesc2 = {
    Text = "[Choisir le chemin arc-en-ciel] augmenter Arg1 points de santé max, infecter[(Skill.Arg2)]"
  },
  Event_7255_Desc = {
    Text = "Boumboum, boumboum, boumboum.\nVotre cœur bat comme un tambour, votre bouche est sèche, et le regard en hauteur transperce votre poitrine.\nDevant vous, un chemin se divise, une rivière d'étoiles coule, un arc-en-ciel brille"
  },
  Event_7255_Name = {
    Text = "Croisements des Étoiles"
  },
  Event_7256_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7256_Desc = {
    Text = "Les regards résiduels te fixent encore, les cellules de ta chair hurlent et s'enfuient avec folie, les veines rampent sous la peau comme des insectes.  \nVous ressentez une puissance qui coule, éclatant dans les étranges transformations des membres"
  },
  Event_7256_Name = {
    Text = "Œil de contemplation"
  },
  Event_7257_ChoiceDesc1 = {
    Text = "[Partir] Infection[(Skill.Arg1)]"
  },
  Event_7257_ChoiceDesc2 = {
    Text = "[Partir] Infection[(Skill.Arg1)]"
  },
  Event_7257_ChoiceDesc3 = {
    Text = "[Partir] Infection[(Skill.Arg1)]"
  },
  Event_7257_Desc = {
    Text = "«Non, ce n'est pas vrai. Comparé aux cafards, vous avez au moins un corps duveteux. \n Personne ne peut résister à un corps duveteux. » \n Les rats chuchotent et finissent par accepter à contrecœur votre point de vue. \n «C'est pas si mal... en fait, il n'y a pas tant de poils que ça. » \n Être complimenté est toujours agréable. Avant de partir, les rats vous offrent un petit cadeau."
  },
  Event_7257_Name = {Text = "Peste"},
  Event_7258_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7258_Desc = {
    Text = "\"Je suis d'accord! Les humains et les rats ne peuvent pas coexister!\"\nLes rats avaient l'air un peu en colère, montrant leurs crocs blancs. \n\"Alors pourquoi es-tu encore ici? Prends tes affaires et ne reviens jamais.\""
  },
  Event_7258_Name = {Text = "Peste"},
  Event_7259_ChoiceDesc1 = {
    Text = "[Leave] Obtiens la Relique \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_7259_Desc = {
    Text = "Un étrange battement d'ailes résonne autour de vous. Vous voyez Rogers allongé sur le lit de traitement, tenant la poupée George, les mains ensanglantées.\nVous ouvrez les yeux et découvrez que Clémentine a disparu.\nEn vous réveillant, Clémentine est déjà partie"
  },
  Event_7259_Name = {
    Text = "Thérapie d'hypnose"
  },
  Event_7260_ChoiceDesc1 = {
    Text = "[Unlock] Utilisez la clé."
  },
  Event_7260_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7260_Desc = {
    Text = "Une porte bloque ton chemin. Malgré tous tes efforts, elle reste immobile"
  },
  Event_7260_Name = {
    Text = "Porte rouillée"
  },
  Event_7260_Tips1 = {
    Text = "Nécessite d'obtenir la « Clé rouillée »"
  },
  Event_7261_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7261_Desc = {
    Text = ": Tu regardes dans la direction de ce que tu crois être la source du regard. Le plafond de l'atelier devient soudain haut et distant, une ombre massive de pupille en couches, bien qu'une partie seulement te regarde, tu ressens une immense pression"
  },
  Event_7261_Name = {
    Text = "Qui regarde"
  },
  Event_7262_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7262_Desc = {
    Text = "Le chat noir s'approche prudemment et vomit une boule noire dans ta paume"
  },
  Event_7262_Name = {
    Text = "Malédiction du hibou"
  },
  Event_7263_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7263_Desc = {
    Text = "\"Un choix judicieux. Lorsque vous êtes confronté à un adversaire redoutable, connaître vous-même et votre ennemi est essentiel, n'est-ce pas ? Mais attention — en apprendre trop sur les secrets des dimensions peut perturber votre esprit.\"\n\"Ce gars ne peut pas s'empêcher d'être obsédé par les êtres inter-dimensionnels. Il m'a fallu des âges pour me déplacer librement à travers ces déchirures dimensionnelles. Ah, c'était il y a 3 000 ans.\""
  },
  Event_7263_Name = {
    Text = "Temps restant"
  },
  Event_7264_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7264_Desc = {
    Text = "« Miaou, miaou, miaou miaou miaou... »\nTu te pinces la voix, essayant de te rendre faible et inoffensif.\n« Miaou ! Miaou ! Miaou miaou miaou ! »\nLe groupe de chats semble accepter ta bienveillance, répondant par des appels retentissants. Vos cris s'élèvent en écho, jour et nuit, la lune est si effrayée qu'elle se cache derrière les nuages."
  },
  Event_7264_Name = {
    Text = "Ville des chats"
  },
  Event_7265_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7265_Desc = {
    Text = "Tu as violemment redressé le bec acéré du corbeau qui voulait mordre ses plumes, mais il s'est obstinément tordu, si fort que cela a fait craquer tes os. \n Ton visage est devenu rouge, et tu as dû déployer toute ta force pour maîtriser le corps du corbeau, arrêtant ainsi son acte de mutilation frénétique. \n Alors que tu soufflais enfin, le cou déjà déplumé du corbeau s'est soudainement tordu en arrière, son corps s'affaissant, se transformant en une flaque de liquide noir dans ta main."
  },
  Event_7265_Name = {
    Text = "Larme de lave fondue"
  },
  Event_7266_ChoiceDesc1 = {
    Text = "[Serrer le corbeau] Obtenez 20 le sigil noir, contagion[(Skill.Arg2)]"
  },
  Event_7266_ChoiceDesc2 = {
    Text = "[Ignorez-le] Partez"
  },
  Event_7266_Desc = {
    Text = "Le corbeau solitaire, d'une voix rauque, arrache ses plumes noires une à une.\nIl tremble de douleur, criant aigu, mais ne peut pas arrêter son rythme de plus en plus frénétique.\n\"Caw—Caw—\"\nDes larmes bleues mélangées à un ooze noir coulent de ses yeux, témoins uniquement pour vous."
  },
  Event_7266_Name = {
    Text = "Larme de lave fondue"
  },
  Event_7267_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7267_Desc = {
    Text = "Les corbeaux arrachent leurs plumes, comme les humains rongent leur propre corps.\nDans ce monde de terreur, cela arrive souvent, tu ne peux pas sauver toutes les créatures"
  },
  Event_7267_Name = {
    Text = "Larme de lave fondue"
  },
  Event_7268_ChoiceDesc1 = {
    Text = "[Leave] Obtiens la Relique \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_7268_Desc = {
    Text = "\"Je reviendrai avec les élèves.\" La fille tira sur la jupe de l'Éveillé, résolue, \"Prends soin de toi... ne tombe pas dans la mer.\""
  },
  Event_7268_Name = {
    Text = "Bénédiction de la Sainte Navigatrice"
  },
  Event_7269_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7269_Desc = {
    Text = "Haha, le noir, mon préféré. Chaos, désordre, douleur... tu aurais dû savoir, le noir n'est pas un bon présage.\nAlors, quel est ton prochain choix ?"
  },
  Event_7269_Name = {
    Text = "Le spectacle commence"
  },
  Event_7270_ChoiceDesc1 = {
    Text = "[Serrer le corbeau] Obtenez 25 le sigil noir, contagion[(Skill.Arg2)], continuez à choisir"
  },
  Event_7270_ChoiceDesc2 = {
    Text = "[Ignorez-le] Partez"
  },
  Event_7270_Desc = {
    Text = "Le corbeau solitaire, d'une voix rauque, arrache ses plumes noires une à une.\nIl tremble de douleur, criant aigu, mais ne peut pas arrêter son rythme de plus en plus frénétique.\n\"Caw—Caw—\"\nDes larmes bleues mélangées à un ooze noir coulent de ses yeux, témoins uniquement pour vous."
  },
  Event_7270_Name = {
    Text = "Larme de lave fondue"
  },
  Event_7271_ChoiceDesc1 = {
    Text = "[Partir] Choisissez 1 carte de commandement parmi 3 pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_7271_Desc = {
    Text = "C'est une cabine délabrée, sans lumière ni guide.\nLa fille partira avec la bénédiction de la Sainte de la navigation, c'est leur promesse"
  },
  Event_7271_Name = {
    Text = "Bénédiction de la Sainte Navigatrice"
  },
  Event_7272_ChoiceDesc1 = {
    Text = "[Suivre la mélodie] choisir 1 carte de commandement parmi 3 pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_7272_ChoiceDesc2 = {
    Text = "[Chanter avec] infecter[(Skill.Arg1)], nouvelle oraison au hasard"
  },
  Event_7272_Desc = {
    Text = "Des chants lointains se brisent en poussière d'étoiles : \n « Je maudis l'eau sale d'une ruelle nocturne, où des fleurs pourries pendent au pied d'un mur en ruine, des chaînes s'accrochent à mon cerveau et tombent dans la boue, avant que la brume n'efface mon existence, le crépuscule plongera dans le plus profond @3. »"
  },
  Event_7272_Name = {
    Text = "Malédiction de la matière blanche"
  },
  Event_7273_ChoiceDesc1 = {
    Text = "[Suivre la mélodie] choisir 1 carte de commandement parmi 3 pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_7273_Desc = {
    Text = "Des chants lointains se brisent en poussière d'étoiles : \n « Je maudis l'eau sale d'une ruelle nocturne, où des fleurs pourries pendent au pied d'un mur en ruine, des chaînes s'accrochent à mon cerveau et tombent dans la boue, avant que la brume n'efface mon existence, le crépuscule plongera dans le plus profond @4. »"
  },
  Event_7273_Name = {
    Text = "Malédiction de la matière blanche"
  },
  Event_7274_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7274_Desc = {
    Text = "Le noyau d'argent ne répond pas à ton réveil, mais émet une chaleur réconfortante"
  },
  Event_7274_Name = {
    Text = "Cœur d'argent solitaire"
  },
  Event_7275_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7275_Desc = {
    Text = "La brume noire s'enroule autour de ta colonne vertébrale, tu répètes cette phrase jusqu'à t'effondrer"
  },
  Event_7275_Name = {
    Text = "Ne pas regarder directement"
  },
  Event_7276_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7276_Desc = {
    Text = "Oui, le vitré qui s'écoule lentement de ta pupille est la preuve que tu es corrompu par un tabou.\nL'honnêteté, à cet instant, contrarie la vertu"
  },
  Event_7276_Name = {
    Text = "Ne pas regarder directement"
  },
  Event_7277_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7277_Desc = {
    Text = "La vieille pièce est collante, comme des résidus vomis par une impureté, avec une fumée noire visible à l'œil nu"
  },
  Event_7277_Name = {
    Text = "Pièce antique à double face"
  },
  Event_7278_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7278_Desc = {
    Text = "Vos nerfs aiguisés émettent un avertissement mortel, vous tressaillez et retirez votre main à contrecœur.\nEncore une fois, vous avez échappé... \nMalédiction ? Ou une renaissance ?"
  },
  Event_7278_Name = {
    Text = "Pièce antique à double face"
  },
  Event_7279_ChoiceDesc1 = {
    Text = "[Lâcher le Papillon] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infectée par «(Skill.Arg2)»"
  },
  Event_7279_ChoiceDesc2 = {
    Text = "[Become a Butterfly] Gagner la Relique en argent \"(RelicConfig.Arg1)\" et infecter \"(Skill.Arg2)\"."
  },
  Event_7279_ChoiceDesc3 = {
    Text = "[Swallow Back] Gagnez 25 Sigils Noirs"
  },
  Event_7279_Desc = {
    Text = "Cette nuit, tant de choses se sont produites. \n Attaque du quai, cargo fantôme, Marcheur des mers, Tulu, Murphy, Ramona... Tout cela tourbillonne dans le vortex, réduit en bouillie d'avoine à sept heures du matin au restaurant Mizag. \n Je veux poser une question à l'Éveilleur devant moi, mais je ne sais pas par où commencer, comme une épine dans la gorge — ou devrais-je dire, des papillons dans l'estomac."
  },
  Event_7279_Name = {
    Text = "Effet papillon"
  },
  Event_7280_ChoiceDesc1 = {
    Text = "[Dispel the Illusion] Perdez (Arg3) Vie."
  },
  Event_7280_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7280_Desc = {
    Text = "Des visages flous apparaissent soudainement, entourant et gémissant désespérément sans cordes vocales"
  },
  Event_7280_Name = {Text = "Illusion"},
  Event_7281_ChoiceDesc1 = {
    Text = "[Join the Prayer] Obtenir une Relique d'Argent \"(RelicConfig.Arg1)\", infecté avec \"(Skill.Arg2)\""
  },
  Event_7281_ChoiceDesc2 = {
    Text = "[Sink into Ocean] Obtenez une relique dorée \"(RelicConfig.Arg1)\", infectez \"(Skill.Arg2)\", \"(Skill.Arg3)\""
  },
  Event_7281_ChoiceDesc3 = {
    Text = "[Surface] Gagner 25 Sigils Noirs"
  },
  Event_7281_Desc = {
    Text = "\"Dieu doux, Dieu Tout-Puissant.\nS'il te plaît, calme la tempête féroce et bloque les courants déchaînés.\nQue l'océan devienne notre profonde maison, enveloppant notre royaume dans un voile éternel...\"\nLes murmures des dévots forment enfin des mots que tu peux comprendre, mais avec eux vient une suffocation inévitabilité."
  },
  Event_7281_Name = {
    Text = "Prière du Rêve"
  },
  Event_7282_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7282_Desc = {
    Text = "Tu jettes les morceaux de viande restants dans la horde de chats. \n Les chats affluent comme une marée noire. Ils mordent frénétiquement les morceaux de viande, puis se dispersent rapidement. \n Malheureusement, c'est de la viande périmée. Cela peut remplir des ventres affamés, mais ce n'est pas vraiment satisfaisant."
  },
  Event_7282_Name = {
    Text = "Ville des chats"
  },
  Event_7283_ChoiceDesc1 = {Text = "[Pocketed]"},
  Event_7283_Desc = {
    Text = "Une matière argentée proche du mercure, extraite de la boue de dissolution, contenant un puissant pouvoir spirituel, utilisée principalement pour lier plus de réveilleurs lors des rituels"
  },
  Event_7283_Name = {
    Text = "Cœur d'argent"
  },
  Event_7284_ChoiceDesc1 = {
    Text = "[Partir] Choisissez de réveiller 1 réveilleur et réduisez à 2 points la consommation en arithmetica de sa carte éveillée. Infection[(Skill.Arg1)]"
  },
  Event_7284_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7284_Desc = {
    Text = "Peut-être que ce n'est pas encore le moment, mais ils entendront votre appel tôt ou tard"
  },
  Event_7284_Name = {
    Text = "Voix du guide"
  },
  Event_7285_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7285_Desc = {
    Text = "Les sujets errants vous épuisent, un bref répit est comme une pluie dans un désert aride"
  },
  Event_7285_Name = {
    Text = "Porte sans fin"
  },
  Event_7286_ChoiceDesc1 = {
    Text = "[Leave] Réveillez un Réveil aléatoire"
  },
  Event_7286_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7286_Desc = {
    Text = "Cette voix vous guidera vers la fin, la réponse de cette enquête"
  },
  Event_7286_Name = {
    Text = "Voix du guide"
  },
  Event_7287_ChoiceDesc1 = {
    Text = "[Observe Carefully]"
  },
  Event_7287_Desc = {
    Text = "Observez au loin avec une boule de cristal"
  },
  Event_7287_Name = {
    Text = "Boule de cristal"
  },
  Event_7288_ChoiceDesc1 = {
    Text = "[Chasser les corbeaux] obtenir Arg1 sigils noirs, infecter[(Skill.Arg2)], continuer à choisir"
  },
  Event_7288_ChoiceDesc2 = {
    Text = "[Ignorez] Partez"
  },
  Event_7288_Desc = {
    Text = "Un corbeau s'est posé sur l'armoire, son bec pointu gravant des motifs étranges sur la porte en bois"
  },
  Event_7288_Name = {
    Text = "Lanterne Corbeau"
  },
  Event_7289_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7289_Desc = {
    Text = "Vous acceptez l'appel de l'école, la voix familière vous apaise. Vous reprenez courage et continuez"
  },
  Event_7289_Name = {
    Text = "Point de contact"
  },
  Event_7290_ChoiceDesc1 = {
    Text = "[rester ici] obtenez une relique d'argent [(RelicConfig.Arg1)]"
  },
  Event_7290_ChoiceDesc2 = {
    Text = "[Find the Exit] Obtenir la Relique d'Or \"(RelicConfig.Arg1)\" et infecter avec \"(Skill.Arg2)\""
  },
  Event_7290_Desc = {
    Text = "Tu pénètres dans un silence pâle, les portes superposées tournent sans fin, te plongeant dans un vortex. \n Tu luttes, étourdi, à l'intérieur des portes inversées, reconnaissant à peine la direction de la fuite, mais inévitablement, tu tombes encore et encore dans une autre porte. \n Cette fois, tu te retrouves à nouveau devant une porte, l'inconnu qui s'y déverse émet une attraction mortelle, mais ta raison est tendue à l'extrême. \n Oui, c'est effectivement mortel."
  },
  Event_7290_Name = {
    Text = "Au-delà des portes multiples"
  },
  Event_7291_ChoiceDesc1 = {
    Text = "[Ecstasy] Supprimez 1 carte de commandement, et restaurez Arg1 Vie"
  },
  Event_7291_ChoiceDesc2 = {
    Text = "[Stop] Obtenez une Relique en Or \"(RelicConfig.Arg1)\" et devenez infecté par \"(Skill.Arg2)\""
  },
  Event_7291_Desc = {
    Text = "Comme si le crâne avait été facilement ouvert, une nausée vertigineuse envahit ton esprit, une main invisible remue et agite ton cerveau, la matière déjà fluide se brise en une flaque. \n Comme des résidus gastro-intestinaux en bouillie, déjà libérés de la gravité, ils s'infiltrent dans ton cortex cérébral vide et appauvri. \n Cela pétrit, mélange et manipule, saupoudre de plaisir découpé, incorporant les vestiges du coucher de soleil dans la chair."
  },
  Event_7291_Name = {
    Text = "Agiter le cerveau"
  },
  Event_7292_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7292_Desc = {
    Text = "Comparé à l'apparition soudaine des chiens des enfers, la neige tombante habituelle ne mérite pas votre attention. Vous ignorez les flocons qui tombent lentement, vous plongeant dans la nuit"
  },
  Event_7292_Name = {Text = "Neige"},
  Event_7293_ChoiceDesc1 = {
    Text = "[Connecter] restaurer Arg2 points de vie"
  },
  Event_7293_Desc = {
    Text = "Tu explores dans la brume, soudain, l'insigne sur ta poitrine émet une faible lueur argentée. Qui t'appelle de l'autre côté de la communication ?"
  },
  Event_7293_Name = {
    Text = "Point de contact"
  },
  Event_7294_ChoiceDesc1 = {
    Text = "[Feel Fear] Gagner une Relique d'or \"(RelicConfig.Arg1)\", Infection \"(Skill.Arg2)\""
  },
  Event_7294_ChoiceDesc2 = {
    Text = "[détermination de volonté] choisit 1 carte de commande parmi 3 et obtient l'oraison :[(EnchantConfig.Arg1)]"
  },
  Event_7294_Desc = {
    Text = "Des hurlements étranges résonnent sans fin, mais tout à Londinium reste silencieux, comme s'il était déjà mort ou endormi. \n Tu erres inconsciemment sous le pont de fer, te remémorant les conseils d'Alistair. \n Il s'est levé poliment et s'approche, semblant te dire quelque chose, mais ses mots sont confus et collants. \n Tu lèves les yeux, des gouttes de liquide noir et épais débordent de sa bouche, obstruant sa gorge et bloquant ses phrases——"
  },
  Event_7294_Name = {
    Text = "Cri de chaos"
  },
  Event_7295_ChoiceDesc1 = {
    Text = "[Leave] Obtenir 1 parmi 3 Oraisons"
  },
  Event_7295_Desc = {
    Text = "\"Bien sûr, bien sûr. Si cela ne te dérange pas, je peux te donner un coup de main.\"\nIl te tend un ancien miroir portatif.\n\"Le chevalier a déjà pris le plateau, et le roi ne sera pas loin derrière. Tu l rencontreras probablement bientôt. Vraiment excitant, n'est-ce pas ?\""
  },
  Event_7295_Name = {
    Text = ": Compagnon étrange IV"
  },
  Event_7296_ChoiceDesc1 = {
    Text = "[Shredded Letter] Retirer 2 Cartes"
  },
  Event_7296_ChoiceDesc2 = {
    Text = "[Continue reading] Obtenir une relique maudite \"(RelicConfig.Arg1)\", infecter \"(Skill.Arg2)\""
  },
  Event_7296_ChoiceDesc3 = {
    Text = "[Leave] Gagner Arg1 sigles noirs"
  },
  Event_7296_Desc = {
    Text = "Devant toi, une nuée de papillons noirs jaillit, débordant sans cesse, battant des ailes, puis tombant à nouveau sur le bureau. \n Le papier à lettres vierge étalé est éclaboussé d'encre, les papillons blessés, à bout de souffle, s'affaissent sur la surface du papier. \n Le liquide noir qui adhère à leurs ailes forme des mots tabous. \n Tu tires cette feuille de papier de la machine à écrire."
  },
  Event_7296_Name = {
    Text = "Chapitre Papillon"
  },
  Event_7297_ChoiceDesc1 = {
    Text = "[Aller vers les Papillons] Supprimez 1 carte de commande, gagnez Arg1 sigils noirs"
  },
  Event_7297_ChoiceDesc2 = {
    Text = "[No Longer Lingers]"
  },
  Event_7297_Desc = {
    Text = "Il y a une phrase populaire à Londinium en ce moment : « Un battement d'ailes d'un papillon dans la région d'Akute pourrait déclencher une tempête dans le Royaume de Léo. »\nEn voyant les papillons jaillir, vous ne pouvez vous empêcher de penser à cette phrase.\nCes papillons pourraient suffire à provoquer une catastrophe capable de submerger la planète."
  },
  Event_7297_Name = {
    Text = "Tempête de Connaissance"
  },
  Event_7298_ChoiceDesc1 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_7298_Desc = {
    Text = "Tu mets un doigt sur tes lèvres, signifiant que tu te tairas à ce sujet.\nUne ombre de chat noir passe en un éclair, laissant un cadeau noir et brillant à tes pieds"
  },
  Event_7298_Name = {
    Text = "Malédiction du hibou"
  },
  Event_7299_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7299_Desc = {
    Text = "Il glisse dans votre sac comme une soie, et avec un léger poids supplémentaire, vous entendez un faible remerciement.\nPuis plus aucun son"
  },
  Event_7299_Name = {
    Text = "Esprit du Chaos"
  },
  Event_7300_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7300_Desc = {
    Text = ": Les pleurs de l'esprit du chaos deviennent de plus en plus aigus, jusqu'à se transformer en un cri perçant, résonnant tout autour.\nAvec votre offrande et une tristesse inextricable, il replonge dans la boue"
  },
  Event_7300_Name = {
    Text = "Esprit du Chaos"
  },
  Event_7301_ChoiceDesc1 = {
    Text = "[Fill in as is]"
  },
  Event_7301_ChoiceDesc2 = {
    Text = "[Doodle Randomly]"
  },
  Event_7301_Desc = {
    Text = "Les rues du District de l'Est sont labyrinthiques, et en un rien de temps, tu perds de vue les enfants. \n Alors que tu es à court d'idées, une femme mystérieuse t'aborde. \n « Je sais où sont les enfants, mais avant de te le dire, pourrais-tu m'aider avec une petite faveur ? » \n Elle sort un morceau de papier et te sourit amicalement. \n « Je m'appelle Clémentine, je suis médecin et je mène une enquête psychologique sur les résidents de Londinium. Si tu peux m'aider à remplir ce questionnaire. \n Si tu le remplis honnêtement, je serai ravie de t'offrir, à toi et à tes compagnons, un peu d'aide. »"
  },
  Event_7301_Name = {
    Text = "Évaluation psychologique"
  },
  Event_7302_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7302_Desc = {
    Text = "«C'est aussi mon choix.» dit la silhouette tenant des bonbons, «mais elle deviendra sa monnaie d'échange, tu devras choisir. \n Il n'existe pas de fin parfaite dans ce monde.» \n Une profonde tristesse t'engloutit. La silhouette se dissipe, tu te tiens la poitrine, ne sachant pas si ce qui vient de se passer était une projection ou une illusion créée sous la pression mentale."
  },
  Event_7302_Name = {
    Text = "Chemin bifurqué"
  },
  Event_7303_ChoiceDesc1 = {
    Text = "[Hache d'Or]"
  },
  Event_7303_ChoiceDesc2 = {
    Text = "[Silver Axe]"
  },
  Event_7303_ChoiceDesc3 = {
    Text = "[Je n'ai rien laissé tomber]"
  },
  Event_7303_Desc = {
    Text = "\"Ô Pionnier du Croisement des Dimensions.\"\nUne voix ancienne résonne à tes oreilles, comme venue de la préhistoire, transcendant les âges.\nDans une tension extrême, tu entends la voix poser une question quelque peu familière.\n\"Est-ce la hache dorée que tu as laissée tomber, ou est-ce celle-ci en argent ?\""
  },
  Event_7303_Name = {
    Text = "Voix hors du monde"
  },
  Event_7304_ChoiceDesc1 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_7304_Desc = {
    Text = "« Oh là là, ça... » Elle reprend le questionnaire, affichant une expression quelque peu désespérée, « Tant pis, après tout, tu es pressé. Les enfants sont partis par là, ils ne doivent pas être très loin. »\nTu te retournes rapidement, manquant presque le chuchotement derrière toi.\n« De toute façon, nous nous reverrons. »"
  },
  Event_7304_Name = {
    Text = "Évaluation psychologique"
  },
  Event_7305_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7305_Desc = {
    Text = "«Qui es-tu ?»\n«Je suis l'ombre de la Clé d'argent assassinée, le meurtrier est un serpent albinos rusé.»\n«Serpent albinos ? Qu'est-ce que c'est ?»\n«Une erreur. Une profanation née de l'hybridation entre l'homme et le serpent…»\nTu veux encore poser des questions, mais l'ombre disparaît soudainement, laissant derrière elle une pluie de poussière dorée."
  },
  Event_7305_Name = {
    Text = "Clé d'argent"
  },
  Event_7306_ChoiceDesc1 = {
    Text = "[Infection\"(Skill.Arg1)\", Gagner une Relique d'Or \"(RelicConfig.Arg2)\"]"
  },
  Event_7306_ChoiceDesc2 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_7306_Desc = {
    Text = "Événement 355 (en cours de développement), effet non final"
  },
  Event_7306_Name = {
    Text = "Événement355 (en développement)"
  },
  Event_7307_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7307_Desc = {
    Text = "Descend dans l'estomac, danse avec les papillons.\nLes pensées et les papillons se mêlent, une neige blanche tombe dans l'estomac.\nTu clarifies tout, et à la prochaine occasion, tu parleras"
  },
  Event_7307_Name = {
    Text = "Effet papillon"
  },
  Event_7308_ChoiceDesc1 = {
    Text = "[Refute Them] Infectez \"(Skill.Arg1)\", accordez aléatoirement 1 carte une Oraison : \"(EnchantConfig.Arg2)\""
  },
  Event_7308_ChoiceDesc2 = {
    Text = "[Follow them] Infecter \"(Skill.Arg1)\", une carte aléatoire gagne une Oraison : \"(EnchantConfig.Arg2)\""
  },
  Event_7308_ChoiceDesc3 = {
    Text = "[Proposer un nouveau point de vue] Choisissez une carte de commande parmi trois et obtenez une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_7308_Desc = {
    Text = "«Veuillez garder vos distances avec nous. »\nDes hordes de rats vous entourent, maintenant au moins cinq pieds de distance entre vous. \n«Nous nous reproduisons, nous prospérons, nous ne sommes jamais difficiles — et c'est ainsi que nous apportons aux humains maladie, anxiété et souffrance. »\n«Nous ne devrions pas nous approcher trop près des humains, ce n'est pas votre endroit. »\nPour détendre les rats, vous décidez —"
  },
  Event_7308_Name = {Text = "Peste"},
  Event_7309_ChoiceDesc1 = {
    Text = "[Open Iron Door] Infecter avec \"(Skill.Arg1)\" et obtenir la relique en or \"(RelicConfig.Arg2)\""
  },
  Event_7309_ChoiceDesc2 = {
    Text = "[Ignorez] Gagnez 50 Sigils Noirs"
  },
  Event_7309_Desc = {
    Text = "C'est un pont en arc typique, les escaliers à côté de la voie ferrée mènent vaguement à une porte en fer. Derrière la porte, on entend un bruit régulier et étrange.\nTu t'arrêtes pour observer la porte, tu vois un lourd cadenas, mais il n'est pas verrouillé"
  },
  Event_7309_Name = {
    Text = "Après la porte en fer"
  },
  Event_7310_ChoiceDesc1 = {
    Text = "[Partir] Infection[(Skill.Arg1)], obtenez 50 sigils noirs"
  },
  Event_7310_Desc = {
    Text = "Face à la tentation, vous restez impassible.\nLa voix semble déçue, l'eau se ride légèrement avant de redevenir calme."
  },
  Event_7310_Name = {
    Text = "Voix hors du monde"
  },
  Event_7311_ChoiceDesc1 = {
    Text = "[Infection\"(Skill.Arg1)\", Gagner une Relique d'Or \"(RelicConfig.Arg2)\"]"
  },
  Event_7311_ChoiceDesc2 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_7311_Desc = {
    Text = "Événement 353 (en cours de développement), effet non final"
  },
  Event_7311_Name = {
    Text = "Événement353 (en développement)"
  },
  Event_7312_ChoiceDesc1 = {
    Text = "[Partir] Infection[(Skill.Arg1)], obtenez 50 sigils noirs"
  },
  Event_7312_Desc = {
    Text = "\"Vous, les humains, n'avez pas d'autres réponses ?\"\nLe propriétaire de la voix laissa échapper un grognement impatient, faisant trembler tout l'espace.\n\"Avide et ignorant... C'est pourquoi je suis fatigué de vous.\""
  },
  Event_7312_Name = {
    Text = "Voix hors du monde"
  },
  Event_7313_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7313_Desc = {
    Text = "Acceptez les arrangements du domaine, dans le reçu, il y a une perte, savourez l'étreinte maudite"
  },
  Event_7313_Name = {
    Text = "Délire éruptif"
  },
  Event_7314_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7314_Desc = {
    Text = "Les yeux clignent lentement, sans savoir s'ils ont compris ta question. \n Une larme dorée et rouge tombe du coin de l'œil, comme une petite étoile, émettant une lumière chaude semblable à celle du soleil. Elle tombe, tombe, portée par la tristesse, par la compassion, se brisant en une petite poussière sur les pierres. \n Tu reprends soudainement tes esprits, cet œil a déjà disparu."
  },
  Event_7314_Name = {
    Text = "Regard aveugle"
  },
  Event_7315_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7315_Desc = {
    Text = "Quelques enfants en vêtements simples et sales couraient dans la rue, poursuivis par un adulte en uniforme de police. L'un des enfants portait une capuche brune qui te semblait familière"
  },
  Event_7315_Name = {
    Text = "Nos Souvenirs"
  },
  Event_7316_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7316_Desc = {
    Text = "<Stop singing—>\nVous mettez en garde le chanteur qui a l'oreille dure, refusant de les laisser torturer vos oreilles plus longtemps."
  },
  Event_7316_Name = {
    Text = "Brigand sur le Chemin Étroit"
  },
  Event_7317_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7317_Desc = {
    Text = "\n«Arrêtez-vous là!!! Même le monstre en dissolution qui rampe sur son ventre connaît mieux ses propres membres que vous!» \nLaissez le public... \nVous priez cela dans votre cœur"
  },
  Event_7317_Name = {
    Text = "Brigand sur le Chemin Étroit"
  },
  Event_7318_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7318_Desc = {
    Text = "Une goutte de boue noire tombe sur ton visage, provoquant une démangeaison.\nIncapable de supporter cela, tu chasses le papillon.\nLe papillon esquive ton geste malveillant et disparaît silencieusement au loin"
  },
  Event_7318_Name = {
    Text = "Quelque chose qui ne devrait pas exister"
  },
  Event_7319_ChoiceDesc1 = {
    Text = "[Félicitez-le] choisissez une carte de commandement parmi 3 cartes et obtenez l'oraison :[(EnchantConfig.Arg1)]"
  },
  Event_7319_Desc = {
    Text = "Jenkins dit : Réveille-toi, Johnny ! Écrire de la poésie ne réglera pas les dettes que tu as accumulées, ni le problème de fuite de ton plancher. \n Tu dis : Malheureusement, tes cellules en quête de vérité vont dépérir à raison de 100 000 par jour, et bientôt tu deviendras un véritable tronc cérébral. \n Le cerveau haussait les épaules de manière indifférente - s'il en avait. \n Le cerveau dit : Je pense, donc je suis. Quand tu atteindras une profondeur de pensée comme la mienne, tu ne te soucieras plus jamais du tronc cérébral."
  },
  Event_7319_Name = {
    Text = "Cerveau philosophique"
  },
  Event_7320_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7320_Desc = {
    Text = "Le piano émet un léger soupir, semblant à la fois apaisant et nostalgique, comme le sourire d'une personne à la fin d'une mélodie.\n« Tant que les enfants… tant que… »\nVous n'avez pas eu le temps d'entendre clairement, l'illusion du piano s'est dissipée au gré du vent"
  },
  Event_7320_Name = {
    Text = "Mélodie de l'enfance"
  },
  Event_7321_ChoiceDesc1 = {
    Text = "[Partir] Obtient 3 choix 1 relique d'argent, infection[(Skill.Arg1)]"
  },
  Event_7321_Desc = {
    Text = "Vous prenez le carnet de santé épais et l'ouvrez, découvrant sur la première page les mots « G·R ».\n« Oh là là, oh là là, n'est-ce pas ton dossier médical ? » Clémentine semble peu préoccupée, « Cependant, explorer la psychologie des autres peut aussi améliorer sa propre compréhension. »\nAvant même que vous ne puissiez poser des questions, son ombre a complètement disparu."
  },
  Event_7321_Name = {
    Text = "carnet de santé"
  },
  Event_7322_ChoiceDesc1 = {
    Text = "[Partir] Choisir de réveiller un Réveillé, infecter[(Skill.Arg1)]"
  },
  Event_7322_Desc = {
    Text = "Vous prenez le dossier médical mince et l'ouvrez, ne trouvant qu'une seule feuille de papier avec une phrase.\n\"Dans le chaos primordial, l'œil pâle sans regard observe éternellement.\"\nVous voulez interroger Clémentine, mais elle a déjà disparu"
  },
  Event_7322_Name = {
    Text = "carnet de santé"
  },
  Event_7323_ChoiceDesc1 = {
    Text = "[Connect] Restaurer toute la Vie."
  },
  Event_7323_ChoiceDesc2 = {
    Text = "[Meditate] Choisir de Réveiller 1 Réveilleur."
  },
  Event_7323_Desc = {
    Text = "Tu explores dans la brume, soudain, l'insigne sur ta poitrine émet une faible lueur argentée. Qui t'appelle de l'autre côté de la communication ?"
  },
  Event_7323_Name = {
    Text = "Point de contact"
  },
  Event_7324_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7324_Desc = {
    Text = "Les preuves importantes doivent être soigneusement conservées et remises au département d'histoire pour analyse"
  },
  Event_7324_Name = {
    Text = "Ordre secret · Haut"
  },
  Event_7325_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7325_Desc = {
    Text = "Le soleil éclatant illumine la terre, perçant le brouillard et réveillant les âmes fatiguées"
  },
  Event_7325_Name = {
    Text = "Angle d'élévation"
  },
  Event_7326_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7326_Desc = {
    Text = "Tu te sens satisfait, leurs regards scintillent dans le ciel nocturne, se concentrant sur toi"
  },
  Event_7326_Name = {
    Text = "Pupille du dôme"
  },
  Event_7327_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7327_Desc = {
    Text = "Tu ne peux échapper à ce regard perçant, et tu ne peux résister aux dons des dieux"
  },
  Event_7327_Name = {
    Text = "Pupille du dôme"
  },
  Event_7328_ChoiceDesc1 = {
    Text = "[Leave] Obtiens la Relique \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_7328_Desc = {
    Text = "\n\"Que es-tu exactement ?\" demandes-tu avec horreur. \n\"Il n'est pas nécessaire de t'en préoccuper. L'ennemi de mon ennemi est un ami, n'est-ce pas ?\" L'homme sourit. \n\"Le cadeau a été laissé sur la chaise. Souhaitons-lui bonne chance.\""
  },
  Event_7328_Name = {
    Text = ": Compagnon étrange IV"
  },
  Event_7329_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7329_Desc = {
    Text = "Ramona s'approche, espérant entendre plus d'informations sur les \"blouses blanches\". \"Quelqu'un écoute !\" La voix du phonographe devient soudainement plus forte, \"Écoute, écoute, écoute !\""
  },
  Event_7329_Name = {
    Text = "L'oreille d'autrui"
  },
  Event_7330_ChoiceDesc1 = {
    Text = "[Leave] Tous les Réveilleurs récupèrent Arg1 Aliemus"
  },
  Event_7330_Desc = {
    Text = "Vous tenez la douce main de l'enfant, passant à travers une porte après l'autre, arrivant enfin sur une petite scène usée. \nL'enfant serre votre main pour exprimer sa gratitude.\n \"Merci, au revoir.\""
  },
  Event_7330_Name = {
    Text = "Cérémonie finale II"
  },
  Event_7331_ChoiceDesc1 = {
    Text = "[Continuer à tomber] obtenez une relique d'argent[(RelicConfig.Arg1)], souhaitez-vous continuer à tomber"
  },
  Event_7331_ChoiceDesc2 = {
    Text = "[Éloignez-vous] Gagner 25 Sigils Noirs"
  },
  Event_7331_Desc = {
    Text = "\"Vous\" vous invite.\nDans les profondeurs de la spirale, le passé et le futur \"vous\" vous envoient des \"cadeaux\" provenant de différentes dimensions."
  },
  Event_7331_Name = {
    Text = "Abysses en spirale"
  },
  Event_7332_ChoiceDesc1 = {
    Text = "[Keep Silent] Gagnez 25 Sigils Noirs"
  },
  Event_7332_ChoiceDesc2 = {
    Text = "[Tendez la Main et Touchez] 50% de chance de gagner 50 Sigils Noirs, 50% de chance de rien."
  },
  Event_7332_Desc = {
    Text = "« Je n'ai qu'une seule maxime à dire — personne ne peut tuer un chat ! »\n« Ce maudit chat noir aurait dû être éventré et laissé à l'abandon, mais il a déterré la tombe de ma famille, dévorant la chair humaine en décomposition, tandis que les ossements étaient éparpillés ici et là. »\n« Sous le regard froid et sombre des pupilles verticales, un épais pus jaunâtre flottait, dégageant une puanteur, et je me suis enfui là-bas, torturé par des cauchemars qui m'ont laissé épuisé. »\n« Attendez... Que voulez-vous faire, je ne suis pas fou ! Je ne le suis pas ! Vous essayez sûrement de cacher quelque chose ! C'est vrai — »\nC'est effectivement vrai, alors que l'ombre du fou disparaît, tu croises le regard du chat noir silencieusement assis à tes pieds."
  },
  Event_7332_Name = {
    Text = "Malédiction du hibou"
  },
  Event_7333_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7333_Desc = {
    Text = "Tu lui demandes où se trouve le musée de cire. \n C'est étrange, avec cette fois, vous vous êtes déjà rencontrés cinq fois ce soir. Tu lui as allumé le feu cinq fois et lui as demandé le chemin cinq fois. \n Mais tu ne te souviens toujours pas de l'emplacement du musée de cire, tout comme vous continuez à vous croiser sans cesse."
  },
  Event_7333_Name = {
    Text = "La silhouette sous le réverbère"
  },
  Event_7334_ChoiceDesc1 = {
    Text = "[Chasser les corbeaux] obtenir 25 sigils noirs, infecter[(Skill.Arg2)], continuer à choisir"
  },
  Event_7334_ChoiceDesc2 = {
    Text = "[Continue chasing the child] Quitter"
  },
  Event_7334_Desc = {
    Text = "Le troisième corbeau est parti, volant vers l'obscurité éternelle"
  },
  Event_7334_Name = {
    Text = "Regard des Corbeaux Noirs"
  },
  Event_7335_ChoiceDesc1 = {
    Text = "[Partir] Obtient 75 sigils noirs, infection[(Skill.Arg2)]"
  },
  Event_7335_Desc = {
    Text = "La fourrure des tentacules est douce et chaude, encore imprégnée de la chaleur de vie de Koum.\nC'est le dernier rayon de soleil avant le coucher, une chaleur éphémère"
  },
  Event_7335_Name = {
    Text = "Résidu de chaleur"
  },
  Event_7336_ChoiceDesc1 = {Text = "[Chase]"},
  Event_7336_Desc = {
    Text = "Tu fouilles le mur attentivement et trouves enfin une entrée de canalisation cachée derrière des buissons. Tu traverses la canalisation, mais le monstre est déjà loin"
  },
  Event_7336_Name = {Text = "Impasse"},
  Event_7337_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7337_Desc = {
    Text = "Les oiseaux ont leurs propres règles, ils n'agissent pas selon ta volonté, et tu n'as pas le droit d'interférer avec les lois de la nature"
  },
  Event_7337_Name = {
    Text = "Corbeau Solitaire"
  },
  Event_7338_ChoiceDesc1 = {
    Text = "[Aperçu de la réflexion] Gagner 25 Sigils Noirs"
  },
  Event_7338_ChoiceDesc2 = {
    Text = "[Are You Okay?] Obtenez une Relique d'argent \"(RelicConfig.Arg1)\" et infectez-vous avec \"(Skill.Arg2)\"."
  },
  Event_7338_Desc = {
    Text = "\"Vous savez quoi... cette nouvelle patronne à côté ne sort jamais... L'autre jour, je lui ai acheté une bière, et après que la mousse ait complètement disparu, j'ai soudain remarqué... dans le verre, elle n'avait pas d'ombre !\""
  },
  Event_7338_Name = {
    Text = "Fragments de souvenirs : Bière"
  },
  Event_7339_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7339_Desc = {
    Text = "« J'aimerais tellement chanter à nouveau avec toi... »\n Le cri désespéré et déformé de Sarah s'arrête soudainement, son visage déformé trahit une certaine confusion."
  },
  Event_7339_Name = {
    Text = "\"Soeur Sasha\""
  },
  Event_7340_ChoiceDesc1 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_7340_Desc = {
    Text = "\"Si heureux ! Si heureux !\" Une voix forte, aiguë et enfantine résonne dans tes oreilles, \"Pour toi, pour toi !\""
  },
  Event_7340_Name = {Text = "Nuit-elfe"},
  Event_7341_ChoiceDesc1 = {
    Text = "[Dossier Médical Épais]"
  },
  Event_7341_ChoiceDesc2 = {
    Text = "[Dossier Médical Fin]"
  },
  Event_7341_Desc = {
    Text = "Une voix plutôt familière t'arrête, tu plisses les yeux, mais tu ne parviens pas à distinguer sa silhouette. \n « Je sais que tu es pressé, » dit le médecin Clémentine d'un ton enjoué, « je te promets que je ne te prendrai pas trop de temps. » \n Deux mains traversent la brume dans ton esprit, chacune tenant un carnet de santé, l'un épais et usé, l'autre fin et tout neuf. \n « Selon les résultats de ton questionnaire, j'ai pris la liberté de te préparer un dossier médical. Cependant, j'ai oublié lequel est le tien, alors pourquoi ne pas venir choisir ? » \n Pour une raison inconnue, le carnet de santé fin dégage une aura familière, résonnant faiblement avec le lien spirituel entre toi et l'éveilleur."
  },
  Event_7341_Name = {
    Text = "carnet de santé"
  },
  Event_7342_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7342_Desc = {
    Text = "Un mur ordinaire, tu ne peux t'empêcher de le frapper, mais il semble creux"
  },
  Event_7342_Name = {
    Text = "Mur étrange"
  },
  Event_7343_ChoiceDesc1 = {
    Text = "[Je ne suis pas à la surface] Améliorez aléatoirement 1 relique d'argent en une relique en or[(RelicConfig.Arg1)]"
  },
  Event_7343_ChoiceDesc2 = {
    Text = "[Look Down] Obtenez une relique en argent \"(RelicConfig.Arg1)\" et devenez infecté par \"(Skill.Arg2)\""
  },
  Event_7343_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_7343_Desc = {
    Text = "\"Hehe, Gardien, te souviens-tu encore de l'avertissement de Bigorneau ? Écoute, ne regarde pas ton reflet à midi.\""
  },
  Event_7343_Name = {
    Text = "Reflet immatériel"
  },
  Event_7343_Tips1 = {
    Text = "Pas encore de relique d'argent"
  },
  Event_7344_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7344_Desc = {
    Text = "Un fantasme venu d'un lointain futur, caché dans les gorges d'Elworth"
  },
  Event_7344_Name = {
    Text = "Volcan fantôme"
  },
  Event_7345_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7345_Desc = {
    Text = "Le papillon se brise dans ta main, comme un plafond de verre fracassé, les morceaux tombent, tombent, tombent"
  },
  Event_7345_Name = {
    Text = "Illusion du pont d'acier"
  },
  Event_7346_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7346_Desc = {
    Text = ": Attendons qu'ils sortent de l'ombre"
  },
  Event_7346_Name = {
    Text = "Lanterne Corbeau"
  },
  Event_7347_ChoiceDesc1 = {
    Text = "[Switch On] Élargissez votre vision actuelle."
  },
  Event_7347_Desc = {
    Text = "Un dispositif d'éclairage laissé par les anciens dissipe la brume noire environnante.\nLa brume autour oscille régulièrement, comme troublée par sa respiration"
  },
  Event_7347_Name = {Text = "projecteur"},
  Event_7348_ChoiceDesc1 = {
    Text = "[Montrer le problème] Choisissez 1 carte de commandement parmi 3 pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_7348_ChoiceDesc2 = {
    Text = "[avale les questions] contamine[(Skill.Arg1)], réimprime, au maximum 2 fois"
  },
  Event_7348_Desc = {
    Text = "Jusqu'à maintenant, tu es encore en train de savourer le passé raconté par Murphy. \n Les souvenirs te font ressentir une empathie, te liant et te comprimant le cerveau, même les derniers mots de Goliath pour apaiser Murphy n'ont pas réussi à te réconforter. \n … Attends, ils disent que le moment d'alignement des étoiles sera dans vingt-cinq ans... \n Mais la Murphy devant toi n'est clairement qu'un enfant à peine âgé..."
  },
  Event_7348_Name = {
    Text = "Vie Enchaînée"
  },
  Event_7349_ChoiceDesc1 = {
    Text = "[Partir] Obtient 3 choix 1 relique d'argent, infection[(Skill.Arg1)]"
  },
  Event_7349_Desc = {
    Text = "Elle devrait pleurer, personne n'a plus de raisons de pleurer qu'elle.\nMais pourquoi ne pleure-t-elle pas ? Pourquoi reste-t-elle à l'écart, comme si ces gens ne se prosternaient pas devant elle"
  },
  Event_7349_Name = {
    Text = "Cérémonie prévol"
  },
  Event_7350_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7350_Desc = {
    Text = "Peu importe, il est impoli de fouiner dans la vie privée des autres"
  },
  Event_7350_Name = {
    Text = "Comme si nous étions face à face"
  },
  Event_7351_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7351_Desc = {
    Text = "Ce doit être une illusion"
  },
  Event_7351_Name = {
    Text = "Regard des Corbeaux Noirs"
  },
  Event_7352_ChoiceDesc1 = {
    Text = "[Leave] Obtenir 1 parmi 3 Oraisons"
  },
  Event_7352_Desc = {
    Text = "Dans les souvenirs, tout le monde priait pour elle, la suppliant. Tu ne peux t'empêcher de murmurer aussi"
  },
  Event_7352_Name = {
    Text = "Cérémonie prévol"
  },
  Event_7353_ChoiceDesc1 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_7353_Desc = {
    Text = "Sous le chat noir, un filet de liquide noir s'écoule, formant un ruisseau qui se jette dans l'égout au bout de la ruelle. Voyant que tu ne t'approches pas, le chat noir se retourne et saute dans l'égout, disparaissant de vue"
  },
  Event_7353_Name = {Text = "Nuit-elfe"},
  Event_7354_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7354_Desc = {
    Text = "Terrifié, tu as crié stridentement.\nTon cri a fait hésiter la main agitée un instant.\nTu as saisi l'occasion pour t'échapper"
  },
  Event_7354_Name = {
    Text = "Marais Sombre"
  },
  Event_7355_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7355_Desc = {
    Text = "Tordre, ramper, se tortiller... Vous essayez tout pour échapper à ces bras agaçants.\nFinalement, vous vous échappez, au prix d'un uniforme scolaire neuf, de deux côtes et de centaines de cheveux"
  },
  Event_7355_Name = {
    Text = "Marais Sombre"
  },
  Event_7356_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7356_Desc = {
    Text = "\n\"Un phénomène normal. Ne paniquez pas, comme un novice,\" \nDoll se pencha plus près, ajustant la position de votre broche. \"Cela indique qu'il y a des passages de dimensions spéciales à proximité. Il semble se diriger vers l'asile.\""
  },
  Event_7356_Name = {
    Text = "Broche Inquiète"
  },
  Event_7357_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7357_Desc = {
    Text = "Tu n'as aucune raison d'accepter la demande de nourrir par les croyants de la lumière du temple.\nLe corbeau secoue sa tête empilée de manière horrifique, produisant des bruits étranges que l'on entendrait au bord d'une tombe, il crie et s'envole"
  },
  Event_7357_Name = {
    Text = "Corbeau maudit"
  },
  Event_7358_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7358_Desc = {
    Text = "«C'est aussi mon choix.» dit la silhouette tenant un ours en peluche, «mais elle deviendra sa marionnette, et ils mourront tous. \nToi, tu seras le complice du mal.» \nUne forte culpabilité t'engloutit. La silhouette se dissipe, tu te tiens la poitrine, ne sachant pas si ce qui vient de se passer était une projection ou une illusion créée sous la pression mentale."
  },
  Event_7358_Name = {
    Text = "Chemin bifurqué"
  },
  Event_7359_ChoiceDesc1 = {
    Text = "[Keep Covering Ears] Gagnez un nombre de sigils noirs égal à la plus haute valeur d'Aliemus d'un Réveiller (Arg1)"
  },
  Event_7359_ChoiceDesc2 = {
    Text = "[Keep Covering Ears] Restaurez (Arg1) Vie, la guérison est augmentée par le nombre de sigils noirs possédés."
  },
  Event_7359_Desc = {
    Text = "Vous avez cédé aux murmures malveillants dans votre oreille. Une douleur aiguë, tranchante comme une aiguille, se tord profondément dans votre crâne.\n\n«Arrêtez—je vous en supplie, arrêtez—j'ai fait ce que vous demandiez—faites-le cesser—»\n\nVous vous prenez la tête entre les mains dans l'agonie, n'entendant plus que le rire moqueur et lointain des corbeaux."
  },
  Event_7359_Name = {
    Text = "Chant des Corbeaux"
  },
  Event_7360_ChoiceDesc1 = {
    Text = "[Catch a Crow] Gagnez 25 Sigils Noirs pour chaque Éveillé Réveilleur."
  },
  Event_7360_ChoiceDesc2 = {
    Text = "[ Émettre Hurlement ] Choisissez 1 Réveillant éveillé et ajoutez les effets \"Inné\" et \"Conserver\" à sa carte de Réveil."
  },
  Event_7360_Desc = {
    Text = "Pris d'une envie de jouer, tu attrapes un corbeau.\nIl se débat désespérément dans ta main, puis explose en une éclaboussure chaude"
  },
  Event_7360_Name = {
    Text = "Chant des Corbeaux"
  },
  Event_7361_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7361_Desc = {
    Text = "Vous vous couvrez les oreilles et fermez les yeux.\nBoum, boum... votre cœur bat en harmonie avec les cris stridents, composant une symphonie chaotique de mort.\nÀ cet instant, vous ressentez une paix inédite"
  },
  Event_7361_Name = {
    Text = "Chant des Corbeaux"
  },
  Event_7362_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7362_Desc = {
    Text = "Le domaine secret est plein de dangers, toutes les lumières ne sont pas des phares guidant le chemin.\nElles peuvent aussi être des flammes attirant les papillons de nuit"
  },
  Event_7362_Name = {
    Text = "Lumière nocturne"
  },
  Event_7363_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7363_Desc = {
    Text = "«Vous êtes mort depuis longtemps, et vous ne pouvez pas rentrer à Notre Foyer.» Votre voix est aussi froide que le Sifflement du vent sur le Champ de neige de Ross. L'expression du voyageur ne change pas, Comme Si les choses devaient être ainsi. Il saisit à nouveau votre main, «Sauvez-moi. Je suis un Soldat, chargé de me rendre en Orient lointain...»"
  },
  Event_7363_Name = {Text = "Dévoreur"},
  Event_7364_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7364_Desc = {
    Text = "Le télégraphe est cassé. Imagine le désespoir de son propriétaire pendant la tempête... car c'est ce que tu ressens maintenant"
  },
  Event_7364_Name = {
    Text = "Télégramme silencieux"
  },
  Event_7365_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7365_Desc = {
    Text = "«Avancez de cinquante mètres, tournez à gauche, puis à droite, puis à gauche... \n Ensuite, continuez jusqu'au bout, votre maison est là.» \n Le voyageur est ravi. Il te fait signe de la main, puis s'en va. \n Tu pousses un soupir de soulagement, puis tu sens soudain quelqu'un saisir ta main. À nouveau, cette voix familière résonne à ton oreille : \n «Sauvez-moi. \n Je suis un soldat, envoyé vers l'est lointain...»"
  },
  Event_7365_Name = {Text = "Dévoreur"},
  Event_7366_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7366_Desc = {
    Text = "Tu as enfin quitté ce labyrinthe.\nÀ ce moment-là, tu as soudain compris que ce musée de cire est un être vivant.\nTout ce qui est étrange, beau et cruel est relié par un ancien rituel.\nEt les yeux du rituel, c'est Rogers"
  },
  Event_7366_Name = {
    Text = "Labyrinthe des Yeux"
  },
  Event_7367_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7367_Desc = {
    Text = "\"Le jeu de rôle est-il amusant, Gardien ?\" Ramona tire sur votre manche. \"La sortie n'est pas loin. J'espère que vous pourrez maintenir cet humour devant Lady Jonquille.\""
  },
  Event_7367_Name = {
    Text = "Fragment de souvenir : Rêve ancien"
  },
  Event_7368_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7368_Desc = {
    Text = "\"Il est difficile pour un Réveiller de résister à la volonté du Gardien,\" avez-vous répondu, \"mais nous ne renoncerons pas.\""
  },
  Event_7368_Name = {Text = "Son choix"},
  Event_7369_ChoiceDesc1 = {
    Text = "[Enter] À travers le mur, plongez plus profondément."
  },
  Event_7369_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7369_Desc = {
    Text = "Tu t'approches du mur, il se tord soudainement, comme pour t'aspirer"
  },
  Event_7369_Name = {
    Text = "Espace Distorsionné"
  },
  Event_7370_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7370_Desc = {
    Text = "«Non, ce n'est pas vrai. Par rapport aux cafards, vous avez au moins un corps duveteux. \n Personne ne peut résister à un corps duveteux. » \n Les rats chuchotent et finissent par accepter à contrecœur votre point de vue. \n «C'est pas si mal... en fait, il n'y a pas tant de poils. » \n Être complimenté est toujours agréable. Avant de partir, les rats vous ont offert un petit cadeau."
  },
  Event_7370_Name = {Text = "Peste"},
  Event_7371_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7371_Desc = {
    Text = "\"Je suis d'accord! Les humains et les rats ne peuvent pas coexister!\"\nLes rats avaient l'air un peu en colère, montrant leurs crocs blancs. \n\"Alors pourquoi es-tu encore ici? Prends tes affaires et ne reviens jamais.\""
  },
  Event_7371_Name = {Text = "Peste"},
  Event_7372_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_7372_Desc = {
    Text = "Bienvenue dans les profondeurs de l'aequor, où chaque pas est chargé de stress.\n\nLa brume de chaos impénétrable cache tout, parviendras-tu à traverser cette mer sombre sous une telle pression ?"
  },
  Event_7372_Name = {
    Text = "Sous le flot"
  },
  Event_7373_ChoiceDesc1 = {
    Text = "[Just Take a Look] Retirez 1 Carte"
  },
  Event_7373_ChoiceDesc2 = {
    Text = "[Take a closer look] Gagnez \"(RelicConfig.Arg1)\", infligez \"(Skill.Arg2)\""
  },
  Event_7373_Desc = {
    Text = "\"Tap tap...\"\nLa machine à écrire, comme un vieux ivrogne qui a trop bu de whisky, bégayait en crachant de l'encre noire.\nVous remarquiez rapidement le nom \"Mason\" et sortiez promptement le papier à taper."
  },
  Event_7373_Name = {
    Text = "Machine à écrire"
  },
  Event_7374_ChoiceDesc1 = {
    Text = "[Eye Contact] Obtenir une relique d'or \"(RelicConfig.Arg1)\" et infecter \"(Skill.Arg2)\"."
  },
  Event_7374_ChoiceDesc2 = {
    Text = "[Fermer les yeux] Réveillez 2 éveillés au hasard, infectez deux fois[(Skill.Arg1)]"
  },
  Event_7374_ChoiceDesc3 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_7374_Desc = {
    Text = "Des milliers d'yeux murmurent autour de toi. \n « Nous avons voyagé, nous nous sommes arrêtés, nous avons parcouru des milliers d'années, voire plus. \n Lorsque le soleil s'est progressivement assombri sous nos regards, tandis que la vie de l'ancienne Terre était engloutie par les inondations. \n Nous avons depuis longtemps été profondément fascinés par les mystères de l'univers. »"
  },
  Event_7374_Name = {Text = "œil"},
  Event_7375_ChoiceDesc1 = {
    Text = "[Follow the Instructions] Augmentez la Vie d'Arg1"
  },
  Event_7375_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7375_Desc = {
    Text = "Vous essayez d'utiliser le pouvoir de traçage de la clé en argent pour trouver le point de jonction le plus proche, mais les informations obtenues contiennent des anomalies difficiles à détecter, comme si elles étaient perturbées"
  },
  Event_7375_Name = {
    Text = "Contact Anormal"
  },
  Event_7376_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7376_Desc = {
    Text = "Tu essuies doucement la surface de la machine à écrire avec un mouchoir en lin standard de la tenue d'étudiant de Mythag.\nLa machine à écrire retrouve alors son calme. Quant au mouchoir sale... laissons-le dans le domaine"
  },
  Event_7376_Name = {
    Text = "Le murmure de la machine à écrire"
  },
  Event_7377_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7377_Desc = {
    Text = "En regardant de plus près, tu distingues un nom parmi les taches d'encre superposées, \"Fingal Johansen\".\nQui est-ce ?"
  },
  Event_7377_Name = {
    Text = "Le murmure de la machine à écrire"
  },
  Event_7378_ChoiceDesc1 = {
    Text = "[Look Up] Choisissez 1 des 3 cartes de commandement pour gagner une oraison : \"(EnchantConfig.Arg1)\", et infectez avec \"(Skill.Arg2)\""
  },
  Event_7378_ChoiceDesc2 = {
    Text = "[L'angle du soleil ?] Choisissez d'éveiller 1 réveilleur, infection[(Skill.Arg1)]"
  },
  Event_7378_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_7378_Desc = {
    Text = "\"Maintenant, regarde immédiatement au sud-est. L'élévation du soleil est en position.\" L'ordre de la Poupée est venu par le communicateur."
  },
  Event_7378_Name = {
    Text = "Angle d'élévation"
  },
  Event_7379_ChoiceDesc1 = {
    Text = "[Infection\"(Skill.Arg1)\", Gagner une Relique d'Or \"(RelicConfig.Arg2)\"]"
  },
  Event_7379_ChoiceDesc2 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_7379_Desc = {
    Text = "Événement 354 (en cours de développement), effet non final"
  },
  Event_7379_Name = {
    Text = "Événement354 (en développement)"
  },
  Event_7380_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7380_Desc = {
    Text = "Les voix des enfants s'échappent des touches du piano.\n« Le vieux Charlie avait un chat tigré qu'il aimait beaucoup... »\nSous leurs chants, une voix féminine douce et tendre chante aussi.\nAs-tu mal entendu ?"
  },
  Event_7380_Name = {
    Text = "Mélodie de l'enfance"
  },
  Event_7381_ChoiceDesc1 = {
    Text = "[Se Retourner] Gagner 25 sigils noirs"
  },
  Event_7381_ChoiceDesc2 = {
    Text = "[Keep Going] Obtenez une Relique d'Argent \"(RelicConfig.Arg1)\" et infectez \"(Skill.Arg2)\""
  },
  Event_7381_Desc = {
    Text = "Des pas résonnent derrière toi.\nLents et réguliers comme une ombre.\nSe mêlant aux tiens, résonnant dans la salle d'exposition vide"
  },
  Event_7381_Name = {Text = "Oxford"},
  Event_7382_ChoiceDesc1 = {
    Text = "[Fold the Letter] Retirez 2 Cartes"
  },
  Event_7382_ChoiceDesc2 = {
    Text = "[Save Letters] Obtenez la relique maudite \"(RelicConfig.Arg1)\" et devenez infecté par \"(Skill.Arg2)\"."
  },
  Event_7382_ChoiceDesc3 = {
    Text = "[Leave] Gagner Arg1 sigles noirs"
  },
  Event_7382_Desc = {
    Text = "Une nouvelle machine à écrire. \n Elle a des touches uniques, aussi élégantes et précises qu'un microscope. \n Tu es fasciné par sa structure mécanique parfaite, lorsque l'encre noire apparaît soudainement. \n « Cher Monsieur Rogers, \n C'est avec un cœur lourd que nous vous informons que vous avez été expulsé de l'académie. \n Comme tout le monde le sait, l'académie @2 est réputée dans le royaume pour son approche rigoureuse de l'enseignement, et ces rumeurs choquantes @3 vous troublent profondément... »"
  },
  Event_7382_Name = {
    Text = "Comme si nous étions face à face"
  },
  Event_7383_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7383_Desc = {
    Text = "La montre arrêtée au loin semble te presser, te rappelant de ne pas te perdre dans le piège du temps"
  },
  Event_7383_Name = {Text = "Son regard"},
  Event_7384_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7384_Desc = {
    Text = "Une goutte de boue noire tombe sur ton visage, provoquant une démangeaison.\nIncapable de supporter cela, tu chasses le papillon.\nLe papillon esquive ton geste malveillant et disparaît silencieusement au loin"
  },
  Event_7384_Name = {
    Text = "Papillon de l'Élixir Noir"
  },
  Event_7385_ChoiceDesc1 = {
    Text = "[Observe Carefully]"
  },
  Event_7385_ChoiceDesc2 = {Text = "[Dig]"},
  Event_7385_Desc = {
    Text = "Koum vous porte tous les trois à la recherche d'une entrée dans l'asile.\nSoudain, il s'arrête brusquement, vous faisant presque tomber.\nEn réponse à vos questions, Koum renifle le sol meuble, puis se tourne vers vous, indiquant qu'il y a quelque chose enterré en dessous"
  },
  Event_7385_Name = {
    Text = "Objet enfoui"
  },
  Event_7386_ChoiceDesc1 = {
    Text = "[Receive] Choisissez 1 parmi 3 reliques d'or"
  },
  Event_7386_Desc = {
    Text = "L'endroit était vide, un liquide noir coulait sur le sol, ne reflétant rien.\nEst-ce une illusion ? Tu as l'impression que quelque chose glisse entre tes doigts"
  },
  Event_7386_Name = {
    Text = "Sous la surface du miroir"
  },
  Event_7387_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7387_Desc = {
    Text = "Les ailes noires s'écrasent sur la terre humide de la ruelle, se transformant en d-boue noir"
  },
  Event_7387_Name = {
    Text = "Essaim de corbeaux en furie"
  },
  Event_7388_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7388_Desc = {
    Text = "\"Mademoiselle Jonquille appréciera votre humour.\" Ramona a salué, et le fantôme s'est dissipé. \"Ne laisse pas que tu deviennes le prix du voyage dimensionnel.\""
  },
  Event_7388_Name = {
    Text = "Fragment de souvenir : Rêve ancien"
  },
  Event_7389_ChoiceDesc1 = {
    Text = "[Receive] Choisissez 1 parmi 3 reliques d'or"
  },
  Event_7389_Desc = {
    Text = "Oh oui, ce reflet odieux, c'est toi.\nLa malveillance jaillissante se mêle à la boue noire sous tes pieds, dansant de manière tordue. Si tu ne t'y opposes pas, elle grimpera sur ton épaule"
  },
  Event_7389_Name = {
    Text = "Sous la surface du miroir"
  },
  Event_7390_ChoiceDesc1 = {
    Text = "[Stand Still] Gagnez 25 Les Sigils Noirs"
  },
  Event_7390_ChoiceDesc2 = {
    Text = "[Walk Casually] Obtenez une Relique d'Argent \"(RelicConfig.Arg1)\", et infectez \"(Skill.Arg2)\""
  },
  Event_7390_Desc = {
    Text = "Tu écrases ton ombre en mille morceaux et tombes dans une mare de nuit.\nCette ombre brisée et éparpillée est la seule chose qui te relie au monde disparu.\nVas-tu vraiment marcher dans ce cauchemar noir ? Tu n'as pas encore trouvé ta direction"
  },
  Event_7390_Name = {
    Text = "Marcheur de cauchemar"
  },
  Event_7391_ChoiceDesc1 = {
    Text = "[Seeking the Source] Obtenez la relique d'argent \"(RelicConfig.Arg1)\", infectez \"(Skill.Arg2)\""
  },
  Event_7391_ChoiceDesc2 = {
    Text = "[Rejouer le disque] Tous les éveillés récupèrent 50 de folie, infectez[(Skill.Arg1)]"
  },
  Event_7391_ChoiceDesc3 = {
    Text = "[Remove the Phonograph] Obtenez une oraison à 3 choix"
  },
  Event_7391_Desc = {
    Text = "Vous rencontrez un vieux phonographe usé. \n Après avoir remonté le ressort, vous placez l'aiguille sur le disque vinyle rayé, la symphonie est déformée comme le bruit d'un ruban adhésif qui se déchire, les instruments à vent et à cordes se battent, aucune partie ne peut s'échapper indemne de cette pièce. \n À la fin de la mélodie qui grésille, vous entendez un rythme régulier de coups. \n « Boum boum... boum boum boum... boum... » \n Vous froncez les sourcils et retirez l'aiguille, mais le son des coups persiste."
  },
  Event_7391_Name = {
    Text = "Écho de la Trajectoire Mystérieuse"
  },
  Event_7392_ChoiceDesc1 = {
    Text = "[Contempler l'éclat] choisissez un relique pour qu'il devienne une relique maudite[(RelicConfig.Arg1)]"
  },
  Event_7392_ChoiceDesc2 = {
    Text = "[Touch the Light] Obtenez la Relique d'Argent \"(RelicConfig.Arg1)\", infectez \"(Skill.Arg2)\""
  },
  Event_7392_ChoiceDesc3 = {
    Text = "[Tourner et Partir] Gagner 25 sigils noirs"
  },
  Event_7392_Desc = {
    Text = "Sous la vue fantomale, la brume du domaine drape la réalité d'un voile sombre. Tout ce qui est visible semble flou, comme s'il était là et pas là. \nAu milieu de ce brouillard, une lumière perce... Comme un phare pour un navire, ou de la fumée pour un enfant perdu, guidant vers un chemin sûr"
  },
  Event_7392_Name = {
    Text = "Lumière nocturne"
  },
  Event_7393_ChoiceDesc1 = {
    Text = "[Pause musicale] améliorer une relique d'argent en relique en or [(RelicConfig.Arg1)]"
  },
  Event_7393_ChoiceDesc2 = {
    Text = "[Talking with It] Obtenez une relique en or \"(RelicConfig.Arg1)\" et devenez infecté par \"(Skill.Arg2)\" et \"(Skill.Arg3)\"."
  },
  Event_7393_ChoiceDesc3 = {
    Text = "[Listen Quietly] Gagnez 25 sigils noirs"
  },
  Event_7393_Desc = {
    Text = "Tu ramasses quelques fragments de mémoire dans une flaque de boue noire.\nLes cristaux brillent, des filaments flottent à l'intérieur, les fragments de mémoire restants s'envolent comme du sable dans le vent.\nDes images chaotiques et étranges s'élèvent autour de toi.\nTu regardes vers—\n"
  },
  Event_7393_Name = {
    Text = "Fragment de Lune d'Argent"
  },
  Event_7394_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7394_Desc = {
    Text = "Vous attrapez quelques flocons tombants, en les examinant de près. Ce que ces flocons fondent n'est pas des gouttes d'eau cristallines, mais plutôt une pâte noire et épaisse de dissolution"
  },
  Event_7394_Name = {Text = "Neige"},
  Event_7395_ChoiceDesc1 = {
    Text = "[Je ne suis pas à la surface] Améliorez aléatoirement 1 relique d'argent en une relique en or[(RelicConfig.Arg1)]"
  },
  Event_7395_ChoiceDesc2 = {
    Text = "[Look Down] Obtenez une relique en argent \"(RelicConfig.Arg1)\" et devenez infecté par \"(Skill.Arg2)\""
  },
  Event_7395_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_7395_Desc = {
    Text = "La brume se dissipe, une main maigre et desséchée se tend devant toi. \n Elle semble avoir perdu sa chair sous l'effet de la corrosion, la paume irrégulière recouverte d'une boue noire visqueuse, tandis qu'elle est chargée de colliers et de bagues scintillant d'or. \n Elle t'invite à t'approcher d'un geste de la main. \n Ce n'est que sous l'ombre d'une crise que les trésors brillent particulièrement."
  },
  Event_7395_Name = {
    Text = "Renverser la griffe maléfique"
  },
  Event_7395_Tips1 = {
    Text = "Pas encore de relique d'argent"
  },
  Event_7396_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7396_Desc = {
    Text = "Le fantasme te fit signe, puis disparut. Il ne te reste que le froid de la neige et les montagnes majestueuses"
  },
  Event_7396_Name = {
    Text = "Volcan fantôme"
  },
  Event_7397_ChoiceDesc1 = {
    Text = "[Funérailles de lune d'argent] choisir 1 relique pour la transformer en relique maudite[(RelicConfig.Arg1)]"
  },
  Event_7397_ChoiceDesc2 = {
    Text = "[Silver Moon Prayer] Obtenez une relique argentée \"(RelicConfig.Arg1)\", et infectez \"(Skill.Arg2)\""
  },
  Event_7397_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_7397_Desc = {
    Text = "Tu ramasses quelques fragments de mémoire dans une flaque de boue noire.\nLes cristaux brillent, des filaments flottent à l'intérieur, les fragments de mémoire restants s'envolent comme du sable dans le vent.\nDes images chaotiques et étranges s'élèvent autour de toi.\nTu regardes vers—"
  },
  Event_7397_Name = {
    Text = "Fragment de Lune d'Argent"
  },
  Event_7398_ChoiceDesc1 = {
    Text = "[Faire le Plein] Obtenir 3 choix d'oisons"
  },
  Event_7398_ChoiceDesc2 = {
    Text = "[Extinguish It] Choisir 1 parmi 3 cartes de commande pour gagner une Oraison : \"(EnchantConfig.Arg1)\", et infecter \"(Skill.Arg2)\""
  },
  Event_7398_Desc = {
    Text = "\"Je suis l'ombre de la servante qui a été assassinée, et le meurtrier est cette flamme verte trompeuse.\"\nLa flamme légèrement rouge oscillait, t'accusant. \n\"Je vivais autrefois près du lac reflétant la lune gonflée, glorieuse et éclatante.\""
  },
  Event_7398_Name = {Text = "Feu faible"},
  Event_7399_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7399_Desc = {
    Text = "Toi et l'ombre vous teniez sous le lampadaire, sans dire un mot.\nCe soir, il n'y avait pas de lune, toutes les maisons étaient silencieuses.\nTu as fait un signe de la main à l'ombre et tu es parti"
  },
  Event_7399_Name = {
    Text = "La silhouette sous le réverbère"
  },
  Event_7400_ChoiceDesc1 = {
    Text = "[Chasser les corbeaux] obtenir Arg1 sigils noirs, infecter[(Skill.Arg2)], continuer à choisir"
  },
  Event_7400_ChoiceDesc2 = {
    Text = "[Ignorez] Partez"
  },
  Event_7400_Desc = {
    Text = "Un corbeau s'est posé sur la tête de lit, te regardant avec des yeux rouges"
  },
  Event_7400_Name = {
    Text = "Lanterne Corbeau"
  },
  Event_7401_ChoiceDesc1 = {
    Text = "[Say No Wallet] Gagnez une oraison à 3 choix"
  },
  Event_7401_ChoiceDesc2 = {
    Text = "[Briser le filet] 1 Carte d'instruction aléatoire obtient l'Oraison : «(EnchantConfig.Arg1)», infectée par «(Skill.Arg2)»"
  },
  Event_7401_Desc = {
    Text = "Un filet orange flotte silencieusement dans l'air, ses mailles sont rares, bien moins délicates que celles d'une cousine qui repose sur le mur. \n Tu ne peux t'empêcher de tendre la main pour toucher, le filet fragile se dissout instantanément, les rires des enfants résonnent à tes oreilles. \n «Tout ce qui est doré, argenté, jaune ou rouge, tous les porte-monnaie sont à nous !»"
  },
  Event_7401_Name = {
    Text = "Réseau errant"
  },
  Event_7402_ChoiceDesc1 = {
    Text = "[Repair Telegraph] Infectez avec \"(Skill.Arg1)\", accordez aléatoirement 1 Carte de Commandement une Oraison : \"(EnchantConfig.Arg2)\""
  },
  Event_7402_ChoiceDesc2 = {
    Text = "[Bury the Telegraph] Infecter \"(Skill.Arg1)\", accorder aléatoirement une oraison à 1 carte de commandement : \"(EnchantConfig.Arg2)\""
  },
  Event_7402_ChoiceDesc3 = {
    Text = "[Ignorer] Choisissez une carte parmi 3 cartes de commandement pour obtenir une oraison : [(EnchantConfig.Arg1)]"
  },
  Event_7402_Desc = {
    Text = "Tu te réfugies dans une fissure de la grotte pour échapper à la tempête. Mais tu sais que tu ne peux pas rester longtemps ici, si les hommes en noir te trouvent, tu n'auras nulle part où fuir.\nDans un coin de la fissure, tu trouves un télégraphe cassé"
  },
  Event_7402_Name = {
    Text = "Reliques des anciens"
  },
  Event_7403_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7403_Desc = {
    Text = "Tu as vu de tels portraits dans de nombreux endroits du royaume.\n« La Reine » est au centre, entourée de roses noires.\nSauf un détail : son visage a été impitoyablement arraché, laissant un trou noir brûlé.\nTu n'as toujours pas vu le vrai visage de la reine"
  },
  Event_7403_Name = {
    Text = "Galerie des portraits"
  },
  Event_7404_ChoiceDesc1 = {
    Text = "[Spare Her] Obtenez une relique maudite \"(RelicConfig.Arg1)\", infectez \"(Skill.Arg2)\""
  },
  Event_7404_ChoiceDesc2 = {
    Text = "[L'aider] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : [(EnchantConfig.Arg1)]"
  },
  Event_7404_ChoiceDesc3 = {
    Text = "[Je marcherai sur mon propre chemin] Gagnez 50 Sigils noirs"
  },
  Event_7404_Desc = {
    Text = "Trois silhouettes bloquent ton chemin. \n «Tu peux la laisser partir, » dit la silhouette tenant un ours en peluche couvert de lave corrodée, «elle est juste timide, pas malveillante. Elle ne veut blesser personne. » \n «Tu peux l'aider, » dit la silhouette tenant une boîte de bonbons joliment emballée, «tu peux faire ce qu'elle ne peut pas faire, tu peux mettre fin à tout ça. » \n «Tu n'as pas besoin de nous écouter, » dit la silhouette les mains vides, «tu as ton propre chemin. »"
  },
  Event_7404_Name = {
    Text = "Chemin bifurqué"
  },
  Event_7405_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7405_Desc = {
    Text = "La voix de Daphné s'arrêta un instant. \n « Oh, tu as choisi ça ? Bon choix, en récompense, je te donnerai un cadeau spécial. » \n « Je ne connais pas bien cet enfant, mais j'ai une hypothèse sur Francis. Je pense que l'émotion qui la domine et lui donne le pouvoir de \"voir\" est un profond remords. Je me demande quel choix elle fera face à ce remords... »"
  },
  Event_7405_Name = {
    Text = "Temps restant"
  },
  Event_74068_ChoiceDesc1 = {
    Text = "[Incorporation du cerveau dans un bocal] Mélangez [ Réserve cérébrale ] dans la pile de pioche."
  },
  Event_74068_Desc = {
    Text = "Dans l'arc en relief complexe, sur le toit en pente de la façade en briques rouges, devant les maisons aux murs creusés, des ombres allongées dansent, assoiffées de réponses. \nLa médiocrité signifie-t-elle la mort ? \nSe contenter de la situation actuelle est-il synonyme d'extinction ?"
  },
  Event_74068_Name = {
    Text = "Conscience qui n'est pas encore perdue"
  },
  Event_74069_ChoiceDesc1 = {
    Text = "[Continuer à accueillir] Choisissez jusqu'à 2 cartes de commandement à supprimer du deck et placez-les dans [ Réserve cérébrale ]."
  },
  Event_74069_Desc = {
    Text = "« Je les ai vus. Beaucoup de personnes, beaucoup de murmures, certaines sages, d'autres superficielles, certaines rationnelles, d'autres folles. Parfois, même parmi les cendres, naît une étincelle d'espoir. »"
  },
  Event_74069_Name = {
    Text = "Conscience qui n'est pas encore perdue"
  },
  Event_7406_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7406_Desc = {
    Text = "Tu retires délicatement la souris de la balance, elle respire calmement, son corps duveteux réchauffe ta paume"
  },
  Event_7406_Name = {
    Text = "Raison et Émotion"
  },
  Event_7407_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7407_Desc = {
    Text = "Le cœur d'argent terne éclate en une lumière éblouissante, éphémère, ne laissant dans la main qu'une poignée de cendres indiscernables du sable.\nLe cœur d'argent a épuisé sa dernière Gnosis, l'âme inconnue n'a pas pu reconstruire un corps, mais avant de disparaître complètement, elle a laissé des traces de son existence."
  },
  Event_7407_Name = {
    Text = "Preuve d'existence"
  },
  Event_7408_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7408_Desc = {
    Text = "«Je ne connais pas bien cet enfant, mais j'ai une hypothèse sur Francis. Je pense que l'émotion qui la domine et lui donne le pouvoir de \"voir\" est un profond remords. Je me demande quel choix elle fera face à ce remords...»"
  },
  Event_7408_Name = {
    Text = "Temps restant"
  },
  Event_7409_ChoiceDesc1 = {
    Text = "[Sortir le papier] Retirer 1 Carte"
  },
  Event_7409_ChoiceDesc2 = {
    Text = "[Not the right time] Gagner \"(RelicConfig.Arg1)\", infecter \"(Skill.Arg2)\""
  },
  Event_7409_Desc = {
    Text = "La machine à écrire portable à l'intérieur de la valise a soudainement commencé à taper toute seule, produisant une demi-page de texte tordu.\n \"Vous l'avez vu. Il est juste à côté de vous—ces ombres teintées par la folie et le zèle... Ne regardez pas directement son contour.\""
  },
  Event_7409_Name = {
    Text = "Avertissement non sollicité"
  },
  Event_7410_ChoiceDesc1 = {
    Text = "[Go Left] Choisir 1 des 3 cartes de commandement pour obtenir une oraison : \"(EnchantConfig.Arg1)\", et infecter \"(Skill.Arg2)\""
  },
  Event_7410_ChoiceDesc2 = {
    Text = "[Aller à droite] Choisir de réveiller un éveillé, infection[(Skill.Arg1)]"
  },
  Event_7410_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_7410_Desc = {
    Text = "Tu sembles être dans un labyrinthe. \nÀ gauche, à droite, encore à gauche... Tu perds patience, jusqu'à ce que tu lèves les yeux et vois cet œil. \nIl te regarde, calme et majestueux, comme s'il était le maître ici"
  },
  Event_7410_Name = {
    Text = "Labyrinthe des Yeux"
  },
  Event_7411_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7411_Desc = {
    Text = "Tu retires tes mains avec force et entends clairement le bruit des os qui se brisent.\nC'est le prix de ta curiosité"
  },
  Event_7411_Name = {
    Text = "Inspiration soudaine"
  },
  Event_7412_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7412_Desc = {
    Text = "Tu as soigneusement inspecté l'appareil photo, le cuir et l'or noir incrustés dans le corps, reflétant une lueur huileuse.\nL'objectif te visait, comme s'il te fixait, te scrutait"
  },
  Event_7412_Name = {
    Text = "Enregistrer sans culpabilité"
  },
  Event_7413_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7413_Desc = {
    Text = "Tu arraches sans pitié l'autre moitié du film, cachée dans le ventre de l'appareil. Les images te laissent sans voix.\nLe film non développé montre fidèlement—toi, allongé dans une flaque de boue noire"
  },
  Event_7413_Name = {
    Text = "Enregistrer sans culpabilité"
  },
  Event_74145_ChoiceDesc1 = {
    Text = "[Lire] Retirer 1 carte de commande et gagner 25 Le Sigil Noir."
  },
  Event_74145_ChoiceDesc2 = {
    Text = "[Continuer à taper] Copier une carte du deck, infecter «(Skill.Arg1)»"
  },
  Event_74145_Desc = {
    Text = "L'imprimante crache violemment de l'encre. \nL'encre noire jaillit de la buse comme un fantôme, se répandant dans l'air pour former une brume dense et oppressante. \nLe clavier semble dissimuler un certain indice, attendant qu'un doigt innocent le touche."
  },
  Event_74145_Name = {
    Text = "Encre fantôme"
  },
  Event_74146_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74146_Desc = {
    Text = "Tu te glisses dans la ruelle sombre, la brume ronge les bords de tes vêtements, mais cette ombre se divise derrière toi en d'innombrables yeux. Le son rouillé des cloches est accompagné de présages humides.\n\nTu sais que tous les chemins détournés finiront par s'effondrer en un cocon cyclique——avant l'aube pourrie, tu te retrouveras enfin avec ton reflet."
  },
  Event_74146_Name = {
    Text = "Cendres du temps"
  },
  Event_74147_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74147_Desc = {
    Text = "Tu dessines silencieusement une forme sur ta poitrine, offrant une prière muette pour ceux qui sont décédés. \n Dans ce monde en voie d'extinction, il y a bien trop de choses que tu ne peux sauver. \n Les ossements brillent, révélant un trésor précieux autrefois chéri par son propriétaire."
  },
  Event_74147_Name = {
    Text = "Ossements décolorés"
  },
  Event_74148_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74148_Desc = {
    Text = "« Dieu le Père reconnaît ta compassion. Dieu le Père veillera sur nous, nous délivrera du fardeau de la souffrance. »\n\nSon fantôme s'évanouit peu à peu, et les sons sacrés se transforment en un vent impitoyable qui siffle à travers.\n\n."
  },
  Event_74148_Name = {
    Text = "Prière de l'orgue"
  },
  Event_74149_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74149_Desc = {
    Text = "Tu pousses doucement les os à découvert, qui s'enfoncent naturellement et lentement dans le liquide noir, disparaissant sans laisser de trace. \nQue l'âme trouve le repos dans le néant.\n\n."
  },
  Event_74149_Name = {
    Text = "Ossements décolorés"
  },
  Event_7414_ChoiceDesc1 = {
    Text = "[Leave] Vous avez vaincu l'adversaire, et rien ne s'est passé."
  },
  Event_7414_Desc = {
    Text = "\"Il semble que le petit doit apprendre à la dure que les secrets d'une femme ne sont pas si facilement découverts.\" \nAlors que les mots de Jonquille s'estompent, un monstre massif apparaît devant vous."
  },
  Event_7414_Name = {
    Text = "Temps restant"
  },
  Event_74150_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74150_Desc = {
    Text = "Dans la tour de l'horloge où se cache la petite souris, il ne devrait pas y avoir de tels jouets malades, ce son provient de ton esprit, de ta mémoire. \n Tu te souviens de ce que tu avais ressenti en tant que Cerveau dans une Cuve, le courant transformé par les ondes sonores. \n Ce bruit étrange devient progressivement normal et apaisant, se transformant en une mélodie classique fluide, qui se joue en boucle dans ton esprit."
  },
  Event_74150_Name = {
    Text = "Des bruits étranges dans la tour de l'horloge"
  },
  Event_74151_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74151_Desc = {
    Text = "Ce n'est pas un chat... ce sont les Porteurs de lanternes qui se dressent. \n Sous le voile noir transparaissent le dégoût et l'hostilité, des murmures égratignent ta conscience, apportant une illusion étrange et inexplicable."
  },
  Event_74151_Name = {
    Text = "Le murmure du chat"
  },
  Event_74152_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74152_Desc = {
    Text = "Ils ont attrapé tes chaussures, saisi tes chevilles, ils sont gourmands, ils désirent, ils veulent te traîner dans l'abîme où ils se trouvent. \n Tu luttes désespérément, parvenant à maintenir ta position, reculant de quelques pas pour tenter de t'échapper. \n Inadvertamment, quelque chose tombe."
  },
  Event_74152_Name = {
    Text = "Cauchemar Réfléchi"
  },
  Event_74153_ChoiceDesc1 = {
    Text = "[Dodge] Gagnez un choix de 3 Orisons"
  },
  Event_74153_ChoiceDesc2 = {
    Text = "[Stop] Choisissez 1 carte parmi 3 cartes de commandement pour obtenir une Oraison : \"(EnchantConfig.Arg1)\", et infectez avec \"(Skill.Arg2)\"."
  },
  Event_74153_Desc = {
    Text = "Des images familières font sauter, tordre et trembler tes nerfs, emplis de peur. \n « Encore une fois... » \n Un cauchemar inhumain descend, une immense impuissance t'enveloppe. \n Tu ne peux vraiment pas réécrire son destin ? \n Il est trop tard, dans le crâne fissuré de Sara, une énorme bouche scintillante d'argent est prête à te mordre, dévorer et mâcher."
  },
  Event_74153_Name = {
    Text = "Cauchemar revisité"
  },
  Event_74154_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74154_Desc = {
    Text = "Tu entends un murmure inquiétant.\n\n« Nous venons des montagnes et des marécages situés sur des étoiles lointaines. Nos corps sont la mèche et le combustible de la lampe ; nous allumerons le feu sacré venu de la terre pour éclairer le chemin menant au nouveau monde. »"
  },
  Event_74154_Name = {
    Text = "Le murmure du chat"
  },
  Event_74155_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74155_Desc = {
    Text = "Coucher de soleil, clocher, oiseaux en vol… \n La fille retire son bandeau, son regard terne te paralyse. \n L'illusion, comme un mirage, se dissipe au contact, mais les pensées inquiètes persistent."
  },
  Event_74155_Name = {
    Text = "Masque blanc"
  },
  Event_74156_ChoiceDesc1 = {
    Text = "[Ramasser] Obtenez 1 relique d'argent parmi 3"
  },
  Event_74156_ChoiceDesc2 = {
    Text = "[Recall] Obtenez des reliques d'argent \"(RelicConfig.Arg1)\"\"(RelicConfig.Arg2)\", contractez deux fois avec \"(Skill.Arg3)\""
  },
  Event_74156_Desc = {
    Text = "Dans la bave d'érosion du coin, repose un petit cache-œil blanc. \nLes souvenirs saisissent votre cœur."
  },
  Event_74156_Name = {
    Text = "Masque blanc"
  },
  Event_74157_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74157_Desc = {
    Text = "Des paumes transparentes dansent librement sur les touches noires et blanches, mais les vagues sonores qui en sortent sont fragmentées, comme une boîte à musique désaccordée, chaque note émettant un cri de désespoir dissonant, comme un appel à l'aide en lutte. \nFinalement, la performance s'arrête brusquement dans un accord désespéré. \nCe qui n'a pas pu être obtenu de son vivant ne laisse que des regrets à ce moment."
  },
  Event_74157_Name = {
    Text = "Sonate du Regret"
  },
  Event_74158_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74158_Desc = {
    Text = "« Chère Mlle Sara : \n Je demande à démissionner de mon poste d'infirmier à l'hôpital. \n Je ne reconnais plus vos idées. Votre enseignement est erroné, les enfants du district de l'Est ne devraient pas grandir sous votre ombre, ne devraient pas croire en la pure bonté et en le don désintéressé. \n Un jour, ils devront quitter vos ailes pour apprendre les lois de la survie dans le district de l'Est. \n\n… » \n\n Les écrits suivants ont été trempés par un liquide noir, devenant flous."
  },
  Event_74158_Name = {
    Text = "Encre fantôme"
  },
  Event_74159_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74159_Desc = {
    Text = "« Je ne peux offrir aux enfants qu'un toit pour se protéger de la pluie et un repas suffisant pour ne pas mourir de faim. Si ce n'était pas pour le bon M. Rogers qui a appelé un médecin, elles ne pourraient même pas obtenir un seul comprimé lorsqu'elles tombent malades. \n Je n'ai pas beaucoup lu, tout ce que je peux faire, c'est les empêcher de mourir de froid et de faim dans la rue. \n Je ne me suis jamais mêlé de ce que les enfants devaient devenir, mais elles ont besoin de survivre. \n… »"
  },
  Event_74159_Name = {
    Text = "Encre fantôme"
  },
  Event_7415_ChoiceDesc1 = {
    Text = "[Explorer les origines] Obtenez une relique en or[(RelicConfig.Arg1)]"
  },
  Event_7415_ChoiceDesc2 = {
    Text = "[Jeter la lettre] Choisissez 1 carte de commandement parmi 3 pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_7415_ChoiceDesc3 = {
    Text = "[Check Letter] Gagnez 50 sigils noirs"
  },
  Event_7415_Desc = {
    Text = "Une autre lettre est tombée devant toi, le papier déchiré te fait soudain ressentir un poids dans le cœur. Tu soulèves le papier. \n « Ça revient encore, tout ce que j'ai prédit n'était pas des mots en l'air ! @4 Ça commence ici, et ça finira aussi ici. » \n « Je veux fuir... Je me suis replié dans l'armoire, mes mains tremblent de manière incontrôlable, mais le bruit des membres collants qui s'écrasent sur le sol se rapproche de plus en plus... J'ai entendu un nom ! C'est lui ! @5 ! »"
  },
  Event_7415_Name = {
    Text = "Une autre lettre de détresse"
  },
  Event_74160_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74160_Desc = {
    Text = "« Merci, le pouvoir créateur du Père Dieu finira par remodeler nos corps, nous apportant une lumière éternelle et des flammes. \n\nLorsque j'atteindrai la fin, je te bénirai devant le Père Dieu. » \n\nSon fantôme s'évanouit peu à peu, et les sons sacrés se transforment en un vent impitoyable qui siffle à travers."
  },
  Event_74160_Name = {
    Text = "Prière de l'orgue"
  },
  Event_74161_ChoiceDesc1 = {
    Text = "[Interment] Restaurez la Vie Arg2[ExDesc1], sélectionnez et effacez 1 carte de commandement."
  },
  Event_74161_ChoiceDesc2 = {
    Text = "[Pray] Obtenez une Création en or «(RelicConfig.Arg1)», et infectez «(Skill.Arg2)»."
  },
  Event_74161_Desc = {
    Text = "Un fragment d'os blanchâtre, la moitié immergée dans la d-boue noire."
  },
  Event_74161_Name = {
    Text = "Ossements décolorés"
  },
  Event_74162_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74162_Desc = {
    Text = "Tu avances droit dans ce brouillard, les illusions s'enroulant autour de ton corps comme une toile d'araignée, une sensation glaciale s'infiltrant jusqu'à la moelle. \n Leurs chuchotements se transforment en fragments de mémoire, perçant ta poitrine. \n En traversant, il ne reste derrière toi qu'un vide, tandis qu'en avant, d'autres ombres floues émergent lentement dans la brume, attendant de dévorer."
  },
  Event_74162_Name = {
    Text = "Cendres du temps"
  },
  Event_74163_ChoiceDesc1 = {
    Text = "[Avoid Phantasm] Recevoir la Relique en or \"(RelicConfig.Arg1)\", infecter \"(Skill.Arg2)\""
  },
  Event_74163_ChoiceDesc2 = {
    Text = "[Traverser l'illusion] Obtenez 3 choix 1 création en or, infection «(Skill.Arg1)»"
  },
  Event_74163_ChoiceDesc3 = {
    Text = "[Partir] Obtient une relique d'argent[(RelicConfig.Arg1)]"
  },
  Event_74163_Desc = {
    Text = "La brume est comme un lourd rideau, enveloppant la rue, chaque pas semblant écraser les cendres du temps. \n Au loin, deux silhouettes floues apparaissent et disparaissent dans la brume, comme des fantômes du passé, chuchotant des histoires depuis longtemps oubliées. \n L'imagination incontrôlable façonne à nouveau des ombres terrifiantes, elles se distordent, se propagent, comme des présages du futur, te rendant presque à bout de souffle. \n Tu sais que le chemin devant toi ne fera que s'assombrir, mais tes pas ne doivent pas et ne peuvent pas s'arrêter."
  },
  Event_74163_Name = {
    Text = "Cendres du temps"
  },
  Event_74164_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74164_Desc = {
    Text = "Tu parviens à peine à esquiver la première attaque rapide de Sarah. \n Ensuite, tu n'auras peut-être plus autant de chance."
  },
  Event_74164_Name = {
    Text = "Cauchemar revisité"
  },
  Event_74165_ChoiceDesc1 = {
    Text = "[Indicate Direction] Obtenez Relique d'argent \"(RelicConfig.Arg1)\", et contractez \"(Skill.Arg2)\""
  },
  Event_74165_ChoiceDesc2 = {
    Text = "[Pray Together] Recevoir 3 choisir 1 Oraiso"
  },
  Event_74165_Desc = {
    Text = "Le son du piano et de l'orgue se mêle dans le vent grisâtre. Une mélodie magique semble flotter dans les ruelles désertes. \n Une religieuse anonyme prie au son du piano. \n « Une prière simple n'a pas besoin de cérémonies solennelles, le grand Père Dieu sèmera l'espoir pour nous, tout comme il nous a donné des enseignements de dévouement. »"
  },
  Event_74165_Name = {
    Text = "Prière de l'orgue"
  },
  Event_74166_ChoiceDesc1 = {
    Text = "[Parer le monstre] Sélectionnez 1 relique et la transformer en relique en or [(RelicConfig.Arg1)]"
  },
  Event_74166_ChoiceDesc2 = {
    Text = "[Ramasser les étoiles] Obtenez une création en argent «(RelicConfig.Arg1)», infectez «(Skill.Arg2)»"
  },
  Event_74166_ChoiceDesc3 = {
    Text = "[Ignorer] Gagne 25 Marque noire"
  },
  Event_74166_Desc = {
    Text = "La pluie de météores s'abat sur le clocher. \nUn cristal translucide tombe juste à tes pieds, créant un petit cratère. \nTu es toujours encerclé, les créatures corrosives aux formes variées ressemblent à des ombres tordues, leurs rugissements et hurlements ne cessent. \nTu décides —"
  },
  Event_74166_Name = {
    Text = "Étoile tombée"
  },
  Event_74167_ChoiceDesc1 = {
    Text = "[Rub Eyes] Recevez 50 Le sigil noir"
  },
  Event_74167_ChoiceDesc2 = {
    Text = "[Fermer les yeux] Obtenir 75 sigils noirs, infection [(Skill.Arg2)]"
  },
  Event_74167_Desc = {
    Text = "Une meute de chats noirs hideux se précipite derrière Yoliette, murmurant des sons inconnus tout en dégageant une menace malveillante et secrète."
  },
  Event_74167_Name = {
    Text = "Le murmure du chat"
  },
  Event_74168_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74168_Desc = {
    Text = "Le tissu bon marché est un peu rugueux au toucher, mais il a néanmoins été soigneusement lavé.\nConserve-le bien et attends le jour où il retrouvera son propriétaire."
  },
  Event_74168_Name = {
    Text = "Masque blanc"
  },
  Event_74169_ChoiceDesc1 = {
    Text = "[Maintenir la distance] Gagnez 25 Le Sigil Noir"
  },
  Event_74169_ChoiceDesc2 = {
    Text = "[Show Mercy] Obtenez une relique d'argent \"(RelicConfig.Arg1)\" et devenez infecté par \"(Skill.Arg2)\""
  },
  Event_74169_Desc = {
    Text = "Ils affluent depuis tes pieds. \nParmi leurs visages douloureux et flous, tu vois ton ombre déformée. \nAs-tu réellement le droit de les juger ?"
  },
  Event_74169_Name = {
    Text = "Cauchemar Réfléchi"
  },
  Event_7416_ChoiceDesc1 = {
    Text = "[Jeter les débris] Avoir une relique spéciale, infectez le symptôme portant l'oraison :[(EnchantConfig.Arg1)] : folie de dissolution"
  },
  Event_7416_ChoiceDesc2 = {
    Text = "[Compléter les Fragments] Pas de Relique spéciale, infectée par \"(Skill.Arg1)\", gain d'infection \"(Skill.Arg2)\""
  },
  Event_7416_Desc = {
    Text = "Les membres pâles se tordent lentement devant toi, elle se penche, tendant son bras brisé, ses yeux plissés de douleur laissent couler des larmes de plâtre blanc.\n\"Il ne manque... qu'un dernier morceau, et je pourrai...\""
  },
  Event_7416_Name = {
    Text = "Compléter le corps endommagé"
  },
  Event_74170_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74170_Desc = {
    Text = [[
Tu dois essayer de les sauver.
Mais ne te laisse pas assimiler par eux.]]
  },
  Event_74170_Name = {
    Text = "Cauchemar Réfléchi"
  },
  Event_74171_ChoiceDesc1 = {
    Text = "[Dévier le regard] Augmentez Arg1 points de PV Max"
  },
  Event_74171_ChoiceDesc2 = {
    Text = "[Maintenir le regard] 1 Carte d'instruction aléatoire obtient l'Oraison : «(EnchantConfig.Arg1)», infecter 1 «(Skill.Arg2)»"
  },
  Event_74171_Desc = {
    Text = "« La fin est déjà descendue. »\nTon cœur se serre, se contracte.\nLe ton assuré de Juliette contient sans aucun doute un certain pouvoir d'hypnose et de télépathie.\nQuelle est la différence entre l'objectif de Juliette dans cette dimension et celui de la Juliette que tu connaissais auparavant ?\nTrop de mystères, trop d'obstacles.\nTu relèves les yeux pour observer Juliette, mais tu découvres qu'elle te fixe aussi."
  },
  Event_74171_Name = {
    Text = "Regard de la Fin"
  },
  Event_74172_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74172_Desc = {
    Text = "Vous levez la main et frappez maladroitement sur les touches fantomatiques. \n Les touches résonnent avec des tintements, chaque note semblant être une goutte de rosée, claire et transparente, la technique de jeu experte ne vient pas de vos doigts. \n Tout à coup, vous voyez une paire de grandes mains invisibles et élancées recouvrir le dos de votre main, montant et descendant avec le progrès de la performance. \n Le temps semble s'arrêter, jusqu'à la dernière résonance de la musique. \n Vous entendez un soupir de satisfaction."
  },
  Event_74172_Name = {
    Text = "Sonate du Regret"
  },
  Event_74173_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74173_Desc = {
    Text = "La conscience transférée fréquemment n'est pas stable, tu dois éliminer les distractions inutiles. \nTu concentres ton attention sur Jenkins qui est devant toi, et le son du gramophone s'estompe peu à peu, se dissipant dans le brouillard."
  },
  Event_74173_Name = {
    Text = "Des bruits étranges dans la tour de l'horloge"
  },
  Event_74174_ChoiceDesc1 = {
    Text = "[Locate the Source] Gagnez la relique en argent \"(RelicConfig.Arg1)\", infectée avec \"(Skill.Arg2)\""
  },
  Event_74174_ChoiceDesc2 = {
    Text = "[Rappel] Tous les éveillés récupèrent 50 points de folie et sont infectés par [(Skill.Arg1)]"
  },
  Event_74174_ChoiceDesc3 = {
    Text = "[Ignorez le bruit] Obtenez un choix de 3 Oraisons"
  },
  Event_74174_Desc = {
    Text = "Vous entendez le son déformé de l'aiguille du gramophone. \nL'aiguille tordue parcourt les sillons endommagés en spirale, émettant tranquillement un frisson glaçant.\n\n."
  },
  Event_74174_Name = {
    Text = "Des bruits étranges dans la tour de l'horloge"
  },
  Event_74175_ChoiceDesc1 = {
    Text = "[Jouer pour lui] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_74175_ChoiceDesc2 = {
    Text = "[Listening to the Strings] Pour chaque Réveilleur avec un Aliemus de 50 ou plus, gagnez 15 Sigils noirs."
  },
  Event_74175_ChoiceDesc3 = {
    Text = "[Leave] Obtenir 1 parmi 3 Oraisons"
  },
  Event_74175_Desc = {
    Text = "« Cher John : \n    Récemment, j'ai soudain réalisé qu'il s'est écoulé plusieurs années depuis la dernière fois que tu as joué du piano pour nous. \n    J'ai 81 ans cette année, et plus je vieillis, plus je prends conscience de la valeur des souvenirs de ma jeunesse. \n    Si tu reçois cette lettre, je te prie de t'arrêter devant mon appartement la prochaine fois que tu passeras par Londinium et de venir jouer un morceau. »"
  },
  Event_74175_Name = {
    Text = "Sonate du Regret"
  },
  Event_74176_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74176_Desc = {
    Text = "Le désir de survie bouillonne dans ta poitrine, et tu donnes sans hésiter l'ordre. \n En attendant de percer l'encerclement, lorsque tu te retournes pour regarder, cette étoile a déjà été submergée par la lave corrodée. \n Dans la lave corrodée en mouvement, une série de bruits aigus et réguliers se fait entendre. \n Tu touches la surface de la lave corrodée, une étoile pourrie tombe dans ta paume."
  },
  Event_74176_Name = {
    Text = "Étoile tombée"
  },
  Event_74177_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74177_Desc = {
    Text = "Tu as ramassé cette étoile, mais elle a perdu son éclat dans ta paume. \n Une sensation d'oppression a soudainement envahi ton corps, un frisson glacial te parcourt le dos. \n Entre la vie et la mort, tu te déplaces sur le côté pour esquiver, évitant de justesse une attaque féroce, mais une éraflure de deux pouces reste sur ton bras."
  },
  Event_74177_Name = {
    Text = "Étoile tombée"
  },
  Event_74178_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74178_Desc = {
    Text = "Les dents cachées à l'intérieur des tentacules déchirent ton poignet, et le plasma coule en minces filets écarlates le long de ton os du poignet. \n Tu ne parviens pas à déchiffrer le regard de Sarah, mais son crâne fissuré émet faiblement un hurlement douloureux et tremblant.\n\n."
  },
  Event_74178_Name = {
    Text = "Cauchemar revisité"
  },
  Event_74179_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74179_Desc = {
    Text = "Tu regardes autour de toi, naviguant de gauche à droite, le son est comme une souris jouant à cache-cache avec toi, tantôt à gauche, tantôt à droite, tantôt loin, tantôt près. \n Tu tournes en rond, mais le bruit devient de plus en plus assourdissant, le grincement métallique te plonge dans une anxiété de plus en plus profonde. \n Soudain, une idée te vient à l'esprit, tu fouilles dans ta poche, bien que tu ne trouves pas la source du son, tu découvres un petit trésor."
  },
  Event_74179_Name = {
    Text = "Des bruits étranges dans la tour de l'horloge"
  },
  Event_7417_ChoiceDesc1 = {
    Text = "[Partir] Vous perdez(Arg1) points de vie, infection[(Skill.Arg2)]"
  },
  Event_7417_Desc = {
    Text = "\n\"Bon enfant. Mais néanmoins, je dois te donner une petite punition.\"\nLe rire léger de Jonquille s'est estompé dans la faille dimensionnelle."
  },
  Event_7417_Name = {
    Text = "Temps restant"
  },
  Event_74180_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74180_Desc = {
    Text = "Tu détournes le regard, évitant tout contact avec elle.\nPourtant, une certaine force fait battre ton cœur avec inquiétude.\n"
  },
  Event_74180_Name = {
    Text = "Regard de la Fin"
  },
  Event_74181_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74181_Desc = {
    Text = "Juliette croise ton regard. \nLa seconde d'après, elle affiche un sourire complètement fou, comme si elle se moquait de ton arrogance et de ton ignorance. \nCependant, ce sourire disparaît aussi rapidement qu'il est apparu, et les autres ne réagissent pas non plus… c'est comme si ce n'était qu'une illusion."
  },
  Event_74181_Name = {
    Text = "Regard de la Fin"
  },
  Event_7418_ChoiceDesc1 = {
    Text = "[1 relique de tâche, obtenir une relique en or «(RelicConfig.Arg1)»]"
  },
  Event_7418_ChoiceDesc2 = {
    Text = "[Task Relic 2, Obtain Gold Relic \"(RelicConfig.Arg1)\"]"
  },
  Event_7418_ChoiceDesc3 = {
    Text = "[Tirer au hasard 1 carte de commandement pour obtenir une oraison :«(EnchantConfig.Arg1)»]"
  },
  Event_7418_Desc = {
    Text = "Événement 254 (en développement), effet non final"
  },
  Event_7418_Name = {
    Text = "Événement254 (en développement)"
  },
  Event_7419_ChoiceDesc1 = {
    Text = "[Soumettre une oraison spéciale 1, une carte de commande aléatoire obtient une oraison :«(EnchantConfig.Arg1)»]"
  },
  Event_7419_ChoiceDesc2 = {
    Text = "[Soumettre une oraison spéciale 2, une carte de commande aléatoire obtient une oraison :«(EnchantConfig.Arg1)»]"
  },
  Event_7419_ChoiceDesc3 = {
    Text = "[Infection \"(Skill.Arg1)\" et \"(Skill.Arg2)\", Gagnez Relique d'or \"(RelicConfig.Arg3)\" ]"
  },
  Event_7419_Desc = {
    Text = "Événement 255 (en cours de développement), effet non final"
  },
  Event_7419_Name = {
    Text = "Événement255 (en développement)"
  },
  Event_7420_ChoiceDesc1 = {
    Text = "[Dodge Butterfly Card] Retirez 2 Cartes"
  },
  Event_7420_ChoiceDesc2 = {
    Text = "[Embrace the Butterfly] Gagnez Relique Maudite \"(RelicConfig.Arg1)\", Infection \"(Skill.Arg2)\""
  },
  Event_7420_ChoiceDesc3 = {
    Text = "[Leave] Gagner Arg1 sigles noirs"
  },
  Event_7420_Desc = {
    Text = "Un tournant après l'autre, la route pour poursuivre les chiens des enfers semble interminable.\nDes chevilles douloureuses, un cerveau enflé, dans le chaos, vous voyez à nouveau des papillons, vous savez que ce sont des pensées folles, des murmures du domaine. Ils affluent de toutes parts"
  },
  Event_7420_Name = {
    Text = "Délire éruptif"
  },
  Event_7421_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7421_Desc = {
    Text = "Tu appuies doucement sur la cloche. Le son retentit quelques fois avant de sombrer dans le silence. Elle s'est retirée—ne reviendra que dans les cauchemars"
  },
  Event_7421_Name = {
    Text = "Petite clochette"
  },
  Event_7422_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7422_Desc = {
    Text = "La cloche sonna doucement quelques fois puis se tut. Elle s'était retirée - ne revenant que dans les cauchemars"
  },
  Event_7422_Name = {
    Text = "Petite clochette"
  },
  Event_7423_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7423_Desc = {
    Text = "\"Pas mal, tu es très prudent.\"\nSoudain, une voix lointaine est venue des carillons.\n\"La prudence te rapportera une petite récompense, mais c'est tout.\""
  },
  Event_7423_Name = {
    Text = "Petite clochette"
  },
  Event_74245_ChoiceDesc1 = {
    Text = "[Partir] Obtient une relique d'argent[(RelicConfig.Arg1)]"
  },
  Event_74245_Desc = {
    Text = "Cliquetis, les dés dansent frénétiquement dans le gobelet jusqu'à épuisement. \n\n« Tu as perdu. Cependant, en récompense de ton divertissement, tu peux quand même recevoir une récompense. »"
  },
  Event_74245_Name = {
    Text = "Message de N"
  },
  Event_74246_ChoiceDesc1 = {
    Text = "[Shut the Gate] Infectez \"(Skill.Arg1)\", accordez au hasard 1 carte de commandement avec oraison : \"(EnchantConfig.Arg2)\""
  },
  Event_74246_ChoiceDesc2 = {
    Text = "[Frantic Departure] Contrat \"(Skill.Arg1)\", imprimer aléatoirement une carte de commandement avec Oraison : \"(EnchantConfig.Arg2)\""
  },
  Event_74246_ChoiceDesc3 = {
    Text = "[Ignorer] Choisissez une carte parmi 3 cartes de commandement pour obtenir une oraison : [(EnchantConfig.Arg1)]"
  },
  Event_74246_Desc = {
    Text = "Tu es profondément enlisé dans ce labyrinthe construit de vapeur et de rouages, des tuyaux en laiton s'entrelacent au-dessus de ta tête comme une toile d'araignée, chaque respiration agitant une brume de graisse épaisse. \n Le cadran de la machine hors de contrôle convulse sur le mur, les aiguilles éclaboussant des étincelles lorsqu'elles traversent les graduations, comme des lucioles mourantes dans un laboratoire victorien. Les joints en rivets suintent de rouille, comme la plaie pourrie de cette bête d'acier, tandis que ta montre de poche est déjà arrêtée—le temps ici n'est qu'une oraison de rouages qui s'engrenent."
  },
  Event_74246_Name = {
    Text = "Ville de vapeur"
  },
  Event_74247_ChoiceDesc1 = {
    Text = "[Tenter sa chance] Infecter [(Skill.Arg1)], entrer dans le jeu de hasard"
  },
  Event_74247_ChoiceDesc2 = {
    Text = "[Oublie Ça] Gagne 25 sigils noirs"
  },
  Event_74247_Desc = {
    Text = "Dans la brume noire et profonde au coin de la rue, une atmosphère étouffante se répand. \n Dans la brume, deux vieux dés froids apparaissent silencieusement, leur surface couverte de symboles indéchiffrables et de motifs étranges. \n Ils reposent tranquillement sur l'ardoise glissante, comme s'ils attendaient un appel mystérieux. \n « Tu sais qui je suis. Veux-tu parier ? »"
  },
  Event_74247_Name = {
    Text = "Message de N"
  },
  Event_74248_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74248_Desc = {
    Text = "«Je rêve d'un cataclysme qui emporte tout, noyant la gloire d'antan. Je ressens de la colère envers la vie, et je suis désespéré face à l'absence d'espoir pour l'avenir. Mon âme est déchirée par la peur, j'espère qu'en ce moment de déclin imminent, vous pourrez faire preuve de vigilance et ne pas laisser ce destin terrible descendre.»"
  },
  Event_74248_Name = {
    Text = "Dernières paroles incohérentes"
  },
  Event_74249_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74249_Desc = {
    Text = "La fumée noire frémit, comme découragée. \nPuis les dés disparaissent en un clin d'œil. \n\nLa seule question qui persiste dans ton esprit est : \nDe quoi ces dés sont-ils vraiment faits ?"
  },
  Event_74249_Name = {
    Text = "Message de N"
  },
  Event_7424_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7424_Desc = {
    Text = "Tu te retournes et vois une paire de chaussures en cuir, ainsi qu'une silhouette humaine floue. \n On dirait un jeune gentleman. \n «Je ne veux pas déranger, avez-vous vu une paire de chaussures en cuir Oxford noires ?» \n «Il y a une paire juste devant vous.» \n «Non, non... celles-ci sont en cuir de chèvre, pas en cuir de vache. \n Je suis coincé dans ce musée de cire depuis douze ans, cela doit être à cause des chaussures qui ne sont pas correctes...» \n La voix marmonne, s'affaiblissant peu à peu."
  },
  Event_7424_Name = {Text = "pas"},
  Event_74250_ChoiceDesc1 = {
    Text = "[Discern Man's Voice] Piochez aléatoirement 3 cartes de commandement du paquet et choisissez 1 à dupliquer."
  },
  Event_74250_ChoiceDesc2 = {
    Text = "[Distinguer la voix de la femme] Choisissez 1 Carte d'instruction parmi 3 pour obtenir une Oraison : «(EnchantConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_74250_ChoiceDesc3 = {
    Text = "[Différencier la voix du vieillard] obtenez 25 marques noires"
  },
  Event_74250_Desc = {
    Text = "Tu te tiens seul dans un marécage sombre. \n Dans le flou, tu entends des délires entrelacés du chaos affluer comme une marée, certains viennent de vieillards, d'autres de jeunes enfants balbutiants, certains de femmes anxieuses, d'autres d'hommes pris de peur inexplicable…"
  },
  Event_74250_Name = {
    Text = "Dernières paroles incohérentes"
  },
  Event_74251_ChoiceDesc1 = {
    Text = "[Avancer] tirez 3 cartes d'instruction aléatoires du deck, choisissez 1 carte à supprimer, obtenez 75 marques noires"
  },
  Event_74251_ChoiceDesc2 = {
    Text = "[Repos]Tirez aléatoirement 3 cartes d'instruction du deck, choisissez une carte pour en faire une Copie de Base dans le deck, et obtenez 25 Marque noire"
  },
  Event_74251_ChoiceDesc3 = {
    Text = "[Regarder en arrière] Obtenir 50 marques noires"
  },
  Event_74251_Desc = {
    Text = "Tu marches sur une rue déserte, tes pas laissent des empreintes profondes dans la cendre. \n\nLes routes de la ville forment une toile d'araignée, tu es le papillon pris au piège."
  },
  Event_74251_Name = {
    Text = "Cité des Brumes"
  },
  Event_74252_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74252_Desc = {
    Text = "Au moment où la vanne à vapeur se ferme violemment, tu entends ton ombre être progressivement broyée par des filetages précisément emboîtés."
  },
  Event_74252_Name = {
    Text = "Ville de vapeur"
  },
  Event_74253_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74253_Desc = {
    Text = "Les mêmes lumières se répètent et se rafraîchissent devant vos yeux, vous n'avez pas d'échappatoire."
  },
  Event_74253_Name = {
    Text = "Ville de vapeur"
  },
  Event_74254_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74254_Desc = {
    Text = "Le temps est une coordonnée inutile, la seule chose que tu attendes est la vérité."
  },
  Event_74254_Name = {
    Text = "Ville de vapeur"
  },
  Event_74255_ChoiceDesc1 = {
    Text = "[Trois Points]"
  },
  Event_74255_ChoiceDesc2 = {
    Text = "[Six Points]"
  },
  Event_74255_ChoiceDesc3 = {Text = "[Un point]"},
  Event_74255_Desc = {
    Text = "Qui oserait lancer les dés synonymes de malheur et de folie ?\nToi, évidemment.\nTu fais ton choix—"
  },
  Event_74255_Name = {
    Text = "Message de N"
  },
  Event_74256_ChoiceDesc1 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_74256_Desc = {
    Text = "Cliquetis, les dés dansent frénétiquement dans le gobelet jusqu'à épuisement. \n\n« Tu as perdu. Cependant, en récompense de ton divertissement, tu peux quand même recevoir une récompense. »"
  },
  Event_74256_Name = {
    Text = "Message de N"
  },
  Event_74257_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74257_Desc = {
    Text = "Le chemin parcouru est une obscurité infinie et un chaos sans limites. \n Tu n'as plus le temps de réfléchir à ton destin, tu dois surmonter ta peur et atteindre ton terme avant que le jugement ne s'abatte."
  },
  Event_74257_Name = {
    Text = "Cité des Brumes"
  },
  Event_74258_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74258_Desc = {
    Text = "«Quand je suis assis dans l'ombre du temps, je sens la main froide de la mort s'approcher lentement. Le monde extérieur devient de plus en plus sombre, rempli de chuchotements de désastre. J'appréhende le jugement imminent, le règlement de nos folies. Les rues sont imprégnées d'une atmosphère de malheur, je crains que notre jour du jugement ne soit proche. Notre civilisation est précaire, comme si elle était sur le point d'être dévorée par la destruction, piégée par notre propre arrogance stupide.»"
  },
  Event_74258_Name = {
    Text = "Dernières paroles incohérentes"
  },
  Event_74259_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74259_Desc = {
    Text = "Échapper à la mort est déjà difficile, tu ne devrais pas en demander davantage. \nL'ombre des ruines et des piliers brisés t'appelle encore."
  },
  Event_74259_Name = {
    Text = "Cité des Brumes"
  },
  Event_7425_ChoiceDesc1 = {
    Text = "[Leave] Obtenir 1 parmi 3 Oraisons"
  },
  Event_7425_Desc = {
    Text = "\"Est-ce vrai... très intéressant.\" \nElle a rétracté le questionnaire et vous a indiqué la direction où les enfants étaient partis. Vous vous êtes en hâté, manquant presque le murmure derrière vous. \n\"En attendant notre prochaine rencontre.\""
  },
  Event_7425_Name = {
    Text = "Évaluation psychologique"
  },
  Event_74260_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74260_Desc = {
    Text = "Tu es sous la domination d'une force immense ou d'un destin puissant. Un court repos ne peut pas changer cette réalité, mais il peut au moins redonner de l'énergie à tes jambes fatiguées pour continuer à avancer."
  },
  Event_74260_Name = {
    Text = "Cité des Brumes"
  },
  Event_74261_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74261_Desc = {
    Text = "«…La ville n'est plus un refuge chaleureux, mais une tombe cachée, engendrant horreur et désespoir. Les rêves autrefois vivants ne sont plus que des fragments de peur. Je ne peux plus faire semblant d'être sans peur, le monde devant moi est comme un cauchemar, impossible à réveiller.»"
  },
  Event_74261_Name = {
    Text = "Dernières paroles incohérentes"
  },
  Event_74262_ChoiceDesc1 = {
    Text = "[Partir] Obtient une relique en or[(RelicConfig.Arg1)]"
  },
  Event_74262_Desc = {
    Text = "Cliquetis, les dés dansent frénétiquement dans le gobelet jusqu'à épuisement. \n\n« Tu as perdu. Cependant, en récompense de ton divertissement, tu peux quand même recevoir une récompense. »"
  },
  Event_74262_Name = {
    Text = "Message de N"
  },
  Event_7426_ChoiceDesc1 = {
    Text = "[Leave] Accordez aléatoirement 1 Carte de Commande l'Oraison : Miroir"
  },
  Event_7426_Desc = {
    Text = "« Ça ne fait rien, j'ai déjà vu la réponse dans tes yeux. J'ai encore quelques affaires à régler, je vais me retirer pour l'instant. Toi aussi, tu as des choses à faire, n'est-ce pas ? Regarde là-bas, quelqu'un vient te chercher. »\nTu te retournes, l'ombre de l'Église de la Lanterne apparaît au bout du chemin."
  },
  Event_7426_Name = {
    Text = ": Compagnon étrange V"
  },
  Event_7427_ChoiceDesc1 = {
    Text = "[Leave] Accordez aléatoirement 1 carte de commandement un Oraison : Calcul"
  },
  Event_7427_Desc = {
    Text = "« Il semble que tu ne sois pas encore prêt à t'ouvrir à moi. Je suis déçu, mais ce n'est pas grave, je continuerai à te donner les conseils les plus amicaux : que cherche donc l'Église de la Lanterne ici ? »\n« Oh là là, il semble que quelqu'un ne veuille pas que nous bavardions. Regarde là-bas, quelqu'un vient te chercher. »\nTu te retournes, l'ombre des Porteurs de lanternes apparaît au bout du chemin."
  },
  Event_7427_Name = {
    Text = ": Compagnon étrange V"
  },
  Event_7428_ChoiceDesc1 = {
    Text = "[Leave] Accordez aléatoirement 1 Carte de Commande l'Oraison : Inspiration"
  },
  Event_7428_Desc = {
    Text = "« Tu es très honnête, ce qui mérite une récompense. Alors, j'ai décidé de te donner un petit avertissement : pourquoi, dès que tu es arrivé dans la ville de Rai, as-tu été repéré par Lui ? »\n« Oh là là, il semble que quelqu'un ne veuille pas que nous bavardions. Regarde là-bas, quelqu'un vient te chercher. »\nTu te retournes, l'ombre des Porteurs de lanternes apparaît au bout du chemin."
  },
  Event_7428_Name = {
    Text = ": Compagnon étrange V"
  },
  Event_7429_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7429_Desc = {
    Text = "Le bruit s'estompe, votre main est vide, mais l'émotion de l'instant est gravée par la clé argentée"
  },
  Event_7429_Name = {
    Text = "Livre du Rien"
  },
  Event_7430_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7430_Desc = {
    Text = "Dans le chaos, tu tends la main et attrapes quelque chose d'étrange, qui prend lentement forme"
  },
  Event_7430_Name = {
    Text = "Livre du Rien"
  },
  Event_7431_ChoiceDesc1 = {
    Text = "[Partir] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_7431_Desc = {
    Text = "«As-tu entendu parler de la méthode de chasse des serpents ? Les serpents ne peuvent que ramper au sol, se glissant en serpentins, ils ne peuvent donc pas se propulser comme un guépard, ni entourer leur proie comme une meute de loups. En revanche, les serpents ont appris à rester silencieusement en attente.»\n«Ils attendent le moment où leur proie baisse sa garde, puis lancent une embuscade, les avalant d'un seul coup.»"
  },
  Event_7431_Name = {
    Text = ": Compagnon étrange III"
  },
  Event_7432_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7432_Desc = {
    Text = "Semble-t-il avoir été dérangé, la fourrure brillante du chat noir ne laisse qu'une légère douleur sur le bout de votre doigt, avant de disparaître dans les profondeurs de la brume"
  },
  Event_7432_Name = {
    Text = "Malédiction du hibou"
  },
  Event_7433_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7433_Desc = {
    Text = "Ce n'est rien d'autre que le délire absurde de ces fidèles fous et ridicules"
  },
  Event_7433_Name = {
    Text = "Ordre secret · Bas"
  },
  Event_7434_ChoiceDesc1 = {
    Text = "[Keep Eavesdropping] Gagnez une Oraison à 3 choix"
  },
  Event_7434_ChoiceDesc2 = {
    Text = "[Cough Loudly] Choisir 1 des 3 cartes de commande pour gagner une oraison : \"(EnchantConfig.Arg1)\", et infecter \"(Skill.Arg2)\""
  },
  Event_7434_Desc = {
    Text = "De nombreuses fissures se sont ouvertes dans le coin, serpentant comme des vaisseaux sanguins. \n Accompagné d'un léger bourdonnement, tu entends la voix grave d'un homme venant d'en face. \n « Quartier de Quentin 5, quartier de Wellington 10, quartier de Norman 15... \n Tous les matériaux de ce mois ont été chargés, prêts à partir, numéro de marchandise I-0234... \n ... \n De plus, grâce à cette bande de Mizag, le district de White Chapel est actuellement en état de siège, nous avons perdu notre plus grande source de matériel. »"
  },
  Event_7434_Name = {
    Text = "Les murs ont des oreilles"
  },
  Event_7435_ChoiceDesc1 = {
    Text = "[Chasser les corbeaux] obtenir 20 sigils noirs, infecter[(Skill.Arg2)]"
  },
  Event_7435_ChoiceDesc2 = {
    Text = "[Continue chasing the child] Quitter"
  },
  Event_7435_Desc = {
    Text = "Sous ton intimidation, tous les corbeaux s'envolèrent dans toutes les directions, leurs ailes noires tombant en une mélasse, se transformant en le sigil noir"
  },
  Event_7435_Name = {
    Text = "Regard des Corbeaux Noirs"
  },
  Event_7436_ChoiceDesc1 = {
    Text = "[Abandonnez la Résistance] Supprimez 1 carte de commande, gagnez Arg1 sigil noir"
  },
  Event_7436_ChoiceDesc2 = {
    Text = "[Reculer les Mains]"
  },
  Event_7436_Desc = {
    Text = "Une nouvelle machine à écrire.\nElle a des touches uniques, aussi élégantes et précises qu'un microscope.\nCurieux, tu poses tes mains dessus, mais elles commencent à voler sur le clavier, de plus en plus vite"
  },
  Event_7436_Name = {
    Text = "Inspiration soudaine"
  },
  Event_7437_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7437_Desc = {
    Text = "Mais c'est juste une créature luttant pour survivre, cherchant un morceau de bois flottant pour se reposer...\nTu soupires, laissant le liquide noir de la queue du papillon couler sur ta joue"
  },
  Event_7437_Name = {
    Text = "Papillon de l'Élixir Noir"
  },
  Event_7438_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7438_Desc = {
    Text = "Vous acceptez l'appel de l'école, la voix familière vous apaise. Vous reprenez courage et continuez"
  },
  Event_7438_Name = {
    Text = "Point de contact"
  },
  Event_7439_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7439_Desc = {
    Text = "Vous acceptez l'appel de l'école, la voix familière vous apaise. Vous reprenez courage et continuez"
  },
  Event_7439_Name = {
    Text = "Point de contact"
  },
  Event_7440_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7440_Desc = {
    Text = "Ton doute se perd dans l'air, sans réponse, la lumière chaude et jaune filtre par la fenêtre, réchauffant comme un souvenir"
  },
  Event_7440_Name = {
    Text = "Souvenirs volcaniques"
  },
  Event_7441_ChoiceDesc1 = {
    Text = "[Ramasser] Infection \"(Skill.Arg1)\", gagnez une Relique en argent \"(RelicConfig.Arg2)\""
  },
  Event_7441_ChoiceDesc2 = {
    Text = "[Hésiter] Gagnez 25 sigils noirs"
  },
  Event_7441_Desc = {
    Text = "Dans un tonneau au coin de la ruelle, un objet de couleur étrange flotte. Son apparition anormale semble vous avertir, \"Ne touchez pas\""
  },
  Event_7441_Name = {
    Text = "Objet flottant dans le tonneau"
  },
  Event_7442_ChoiceDesc1 = {
    Text = "[Donnez-la à Elle] Obtenez 1 des 3 Reliques d'Argent"
  },
  Event_7442_ChoiceDesc2 = {
    Text = "[Interesting Situation] Obtenir les Reliques d'Argent \"(RelicConfig.Arg1)\" et \"(RelicConfig.Arg2)\", infecter deux fois \"(Skill.Arg3)\""
  },
  Event_7442_Desc = {
    Text = "\"Ceci est une communication de Mythag. Je suis Erica. Des fluctuations anormales de l'index gnostique détectées chez l'éveilleur Lotan. Avez-vous besoin de soutien ?\""
  },
  Event_7442_Name = {
    Text = "Soutien de communication"
  },
  Event_7443_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7443_Desc = {
    Text = "Vous avez cédé aux murmures malveillants dans votre oreille. Une douleur aiguë, tranchante comme une aiguille, se tord profondément dans votre crâne.\n\n«Arrêtez—je vous en supplie, arrêtez—j'ai fait ce que vous demandiez—faites-le cesser—»\n\nVous vous prenez la tête entre les mains dans l'agonie, n'entendant plus que le rire moqueur et lointain des corbeaux."
  },
  Event_7443_Name = {
    Text = "Chant de la Meute de Corbeaux"
  },
  Event_7444_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7444_Desc = {
    Text = "Placé ici, il y a deux possibilités : un objet négligé ou précieux. Si c'est le second, laissons-le à son propriétaire"
  },
  Event_7444_Name = {
    Text = "Cœur d'argent solitaire"
  },
  Event_7445_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7445_Desc = {
    Text = "Le bonheur suprême, c'est l'ignorance"
  },
  Event_7445_Name = {Text = "Épier"},
  Event_7446_ChoiceDesc1 = {
    Text = "[Spawn Normal Monster]"
  },
  Event_7446_ChoiceDesc2 = {
    Text = "[Spawn Blank Tile]"
  },
  Event_7446_ChoiceDesc3 = {
    Text = "[Spawn Void]"
  },
  Event_7446_Desc = {
    Text = "Voyons ce qu'on peut générer"
  },
  Event_7446_Name = {
    Text = "[À Emballer]"
  },
  Event_7447_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7447_Desc = {
    Text = "\"Calme-toi,\" Ramona tapote votre tête, \"ce ne sont que des fragments du passé. Je ne sais pas qui les a laissés dans ce passage dimensionnel.\" \nEn effet, il y a un parfum nostalgique."
  },
  Event_7447_Name = {
    Text = "Fragment de souvenir : Whisky"
  },
  Event_7448_ChoiceDesc1 = {
    Text = "[Ramasser] Élever une relique d'argent en une relique en or [(RelicConfig.Arg1)]"
  },
  Event_7448_ChoiceDesc2 = {
    Text = "[Throw Them Away] Obtenez la Relique d'Argent \"(RelicConfig.Arg1)\", Infection \"(Skill.Arg2)\", et \"(Skill.Arg3)\""
  },
  Event_7448_ChoiceDesc3 = {
    Text = "[Observe Carefully] Gagnez 25 Sigils Noirs"
  },
  Event_7448_Desc = {
    Text = "Il y a beaucoup de cœurs d'argent brisés ici.\nSombres, cassés... Pas de la haute qualité.\nPeut-être sont-ils la raison pour laquelle ces statues de cire peuvent \"prendre vie\".\nMême les cœurs d'argent les plus grossiers peuvent créer des miracles"
  },
  Event_7448_Name = {Text = "Âme Liée"},
  Event_7449_ChoiceDesc1 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_7449_Desc = {
    Text = "Koum a tout donné.\nMaintenant, c'est à toi de faire en sorte que son sacrifice ne soit pas vain"
  },
  Event_7449_Name = {
    Text = "Résidu de chaleur"
  },
  Event_7450_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7450_Desc = {
    Text = ": Que la neige et le vent vous apportent une paix éternelle"
  },
  Event_7450_Name = {
    Text = "Reliques des anciens"
  },
  Event_7451_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7451_Desc = {
    Text = "Tu sembles toujours tenace, même en chantant tu restes toi-même.\nTu ne crois pas aux murmures à ton oreille, tu ne te fies qu'à la raison humaine.\nMais... le jour où le sol solide sur lequel tu vis sera couvert de boue noire, arracher tes yeux pour voir sera ta seule option à l'agonie"
  },
  Event_7451_Name = {
    Text = "Chant de la Meute de Corbeaux"
  },
  Event_7452_ChoiceDesc1 = {
    Text = "[Partir] Choisissez 1 carte de commandement parmi 3 pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_7452_Desc = {
    Text = "Koum a été tiré brusquement par vous, évitant de justesse une attaque. Elle vous a fait un signe de tête en remerciement avant de se jeter à nouveau sur le sujet d'expérimentation"
  },
  Event_7452_Name = {Text = "Arènes"},
  Event_7453_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7453_Desc = {
    Text = "Ding ding dong...\nLes pièces tombent dans le porte-monnaie, résonnant agréablement.\nLe porte-monnaie mâche avec satisfaction, puis rote.\nIl est conquis par ta générosité et te fait confiance.\nMaintenant, il est à toi"
  },
  Event_7453_Name = {
    Text = "Porte-monnaie gourmand"
  },
  Event_7454_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7454_Desc = {
    Text = "Les pièces de bronze tombent dans un abîme sans fond, sans un bruit.\nVous attendez patiemment cinq minutes. Le portefeuille gémit de douleur et finit par cracher un liquide noir et visqueux.\nC'est sa protestation silencieuse"
  },
  Event_7454_Name = {
    Text = "Porte-monnaie gourmand"
  },
  Event_7455_ChoiceDesc1 = {
    Text = "[Regardez au loin]"
  },
  Event_7455_ChoiceDesc2 = {
    Text = "[Listen Carefully]"
  },
  Event_7455_Desc = {
    Text = "La Céleste agite la boussole dans sa main sans dire un mot, mais une mélodie s'élève doucement autour d'elle. \nLa chanson des marins traverse le temps pour se tisser ici, une chanson de bateau chaotique mais puissante qui te guide, t'incitant à regarder vers l'autre bout du bateau"
  },
  Event_7455_Name = {
    Text = "Chant de la mer"
  },
  Event_7456_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7456_Desc = {
    Text = "Tu es intervenu pour interrompre cet exercice de cours. \n Des gestes de piano aux bases de la théorie musicale, tu as commenté sans pitié. \n La musique s'est brusquement arrêtée, le garçon et le professeur se sont tournés vers toi avec le même sourire étrange. \n 133, 355, 244... \n La musique a de nouveau retenti, toujours aussi fausse. \n En fait, ils n'entendaient rien du tout."
  },
  Event_7456_Name = {
    Text = "Cours de piano"
  },
  Event_7457_ChoiceDesc1 = {Text = "[Pocketed]"},
  Event_7457_Desc = {
    Text = ": Les marques noires trouvées dans le domaine peuvent être sacrifiées à d-marque pour échanger des reliques et d'autres projections spirituelles. Elles se dissiperont sous forme de boue noire peu après avoir quitté la zone actuelle"
  },
  Event_7457_Name = {
    Text = "Marque noire"
  },
  Event_7458_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7458_Desc = {
    Text = "Pour l'instant, trouver cette personne mystérieuse est plus important. Ramona pensait cela en partant rapidement"
  },
  Event_7458_Name = {
    Text = "L'oreille d'autrui"
  },
  Event_7459_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7459_Desc = {
    Text = "S'immerger dans la conscience, sombrer dans l'Aequor suivant le chemin des prières.\nVous voyez le pays doré devenu submergé au fond, voyez les sculptures en pierre immortelles, et finalement confronter les yeux vacillants dans l'ombre...\n\"Ceux qui n'ont pas versé de sang divin... partez, partez.\""
  },
  Event_7459_Name = {
    Text = "Prière du Rêve"
  },
  Event_7460_ChoiceDesc1 = {
    Text = "[Partir] Choisissez 1 relique maudite, infection[(Skill.Arg1)]"
  },
  Event_7460_Desc = {
    Text = "Ramona transperce la gorge du spécimen, Kum jette le corps sans vie et se dirige vers la prochaine cible"
  },
  Event_7460_Name = {Text = "Arènes"},
  Event_7461_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7461_Desc = {
    Text = "Les corbeaux arrachent leurs plumes, comme les humains rongent leur propre corps.\nDans ce monde de terreur, cela arrive souvent, tu ne peux pas sauver toutes les créatures"
  },
  Event_7461_Name = {
    Text = "Larme de lave fondue"
  },
  Event_7462_ChoiceDesc1 = {
    Text = "[Soothe Kum]"
  },
  Event_7462_ChoiceDesc2 = {
    Text = "[Aidez à crier pour Kum]"
  },
  Event_7462_Desc = {
    Text = "La bête géante rugit désespérément vers le petit humain, essayant de réveiller ses anciens compagnons. Mais ses cordes vocales endommagées ne produisent que des grognements sourds"
  },
  Event_7462_Name = {
    Text = "Appel de l'amitié"
  },
  Event_7463_ChoiceDesc1 = {
    Text = "[Leave] Trouver un phare de recherche"
  },
  Event_7463_ChoiceDesc2 = {
    Text = "[Break into Mist] Perdre Arg2 Vie"
  },
  Event_7463_Desc = {
    Text = "Devant se trouve une brume noire épaisse, entrer imprudemment entraînera des clades.\nPeut-être devriez-vous trouver un « projecteur » pour dissiper la brume"
  },
  Event_7463_Name = {Text = "inconnu"},
  Event_7464_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7464_Desc = {
    Text = "\"Une mâchoire qui grince comme la vôtre ? Je n'ai jamais vu quelque chose de tel de ma vie.\"\nVous avez rejeté la demande impolie de M. Jawbone. M. Jawbone était extrêmement déçu mais a réussi à garder son calme. \nPour vous remercier de votre écoute patiente, il vous a offert un petit cadeau."
  },
  Event_7464_Name = {Text = "Craquement"},
  Event_7465_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7465_Desc = {
    Text = "Tu as accepté cette demande étrange et emmené M. Mâchoire avec toi. \n Il est allongé dans ta poche, craquant sans cesse. D'après la traduction de ton compagnon, ses paroles contiennent principalement de la gratitude, de la nostalgie et du regret. \n Quant à la raison pour laquelle il est devenu ainsi, M. Mâchoire n'en dit pas plus, se contentant de dire : \n «Tu sais, quand tu regardes @2, @2 te regarde aussi.»"
  },
  Event_7465_Name = {Text = "Craquement"},
  Event_7466_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7466_Desc = {
    Text = "Il glisse dans votre sac comme une soie, et avec un léger poids supplémentaire, vous entendez un faible remerciement.\nPuis plus aucun son"
  },
  Event_7466_Name = {
    Text = "Esprit du Chaos"
  },
  Event_7467_ChoiceDesc1 = {Text = "[Avancer]"},
  Event_7467_Desc = {
    Text = "Clic.\nTu insères la clé dans la serrure et ouvres la porte doucement.\nTout s'est bien passé, te redonnant confiance pour la prochaine enquête"
  },
  Event_7467_Name = {
    Text = "Porte rouillée"
  },
  Event_7468_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7468_Desc = {
    Text = "La voix a gloussé profondément, et des ondulations se sont formées dans le liquide à tes pieds.\n\"Tu réaliseras bientôt qu'il n'y a rien d'autre que tu dois faire, à part faire face à la mort.\""
  },
  Event_7468_Name = {
    Text = "Tu ne voudras pas trouver"
  },
  Event_7469_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7469_Desc = {
    Text = "Tu as laissé tomber ce souvenir, retirant ta conscience de cette consolation illusoire"
  },
  Event_7469_Name = {
    Text = "Se perdre dans le passé"
  },
  Event_7470_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7470_Desc = {
    Text = "Juste un court sommeil, sans réconfort, comment passerez-vous cette longue nuit"
  },
  Event_7470_Name = {
    Text = "Se perdre dans le passé"
  },
  Event_7471_ChoiceDesc1 = {
    Text = "[Ramasser la photo] Choisissez 1 carte de commandement parmi 3 pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_7471_Desc = {
    Text = "C'est un ensemble de photos de groupe. \n Des personnes apathiques sont accroupies derrière une clôture en fer, le visage marqué par la souffrance. \n L'une des photos attire votre attention. Cela devrait être une jeune femme maigre, son visage étant vide. \n Ce parasite incroyablement profanateur s'enroule autour de son corps. \n Vous ne pouvez pas voir son visage, mais dans votre imagination, elle devrait être sans expression."
  },
  Event_7471_Name = {
    Text = "enregistrer fidèlement"
  },
  Event_7472_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7472_Desc = {
    Text = "C'était une carcasse d'oiseau"
  },
  Event_7472_Name = {
    Text = "Essaim de corbeaux en furie"
  },
  Event_7473_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7473_Desc = {
    Text = "Tu refuses froidement la demande du pianiste.\nLe pianiste est extrêmement déçu. Il arrache son autre oreille et les jette par la fenêtre.\n\"De toute façon, je n'en ai pas besoin.\"\nLe pianiste mélancolique joue une série de notes tristes"
  },
  Event_7473_Name = {
    Text = "Prête l'oreille"
  },
  Event_7474_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7474_Desc = {
    Text = ": Les pleurs de l'esprit du chaos deviennent de plus en plus aigus, jusqu'à se transformer en un cri perçant, résonnant tout autour.\nAvec votre offrande et une tristesse inextricable, il replonge dans la boue"
  },
  Event_7474_Name = {
    Text = "Esprit du Chaos"
  },
  Event_7475_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7475_Desc = {
    Text = "C'est un passage à sens unique, vous ne pouvez pas revenir à l'entrée par là"
  },
  Event_7475_Name = {Text = "Passage"},
  Event_7476_ChoiceDesc1 = {
    Text = "[Leave] Obtiens la Relique \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_7476_Desc = {
    Text = "\"Eh bien, veuillez fermer les yeux et ressentir tranquillement le son de ses pas approchants.\" \nSuite au conseil, vous fermez les yeux. En un instant, une respiration bestiale étrange rugit à vos oreilles. \nQuand vous ouvrez les yeux sous le choc, l'homme d'avant avait déjà disparu."
  },
  Event_7476_Name = {
    Text = ": Compagnon étrange I"
  },
  Event_7477_ChoiceDesc1 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_7477_Desc = {
    Text = "\"C'est vraiment regrettable.\"\nL'homme ajusta ses lunettes, sa voix basse.\n\"Cependant, si vous n'en avez pas entendu parler, pourquoi venir ici si tard dans la nuit ?\"\nSans attendre de réponse, il s'éloigna."
  },
  Event_7477_Name = {
    Text = ": Compagnon étrange I"
  },
  Event_7478_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7478_Desc = {
    Text = "Tu marches avec détermination, continuant d'avancer.\nUn pas, deux pas, trois pas...\nLes pas derrière toi disparaissent dans l'obscurité.\nVous vous retrouverez"
  },
  Event_7478_Name = {Text = "Oxford"},
  Event_7479_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7479_Desc = {
    Text = "Tu te penches légèrement, tenant le plateau sur la table à côté de toi, te transformant en garde de la princesse. \n Quant à savoir qui est la chanceuse princesse - c'est naturellement ta partenaire la plus fidèle. \n « Si tu oses renverser la tasse sur mon visage, n'espère pas de notes de cours le mois prochain. » \n C'est l'avertissement que la princesse t'a adressé."
  },
  Event_7479_Name = {
    Text = "Faux pour vrai"
  },
  Event_7480_ChoiceDesc1 = {
    Text = "[Écoutez silencieusement] Améliorez aléatoirement la qualité de l'Oraison d'1 Carte."
  },
  Event_7480_ChoiceDesc2 = {
    Text = "[Elle l'est] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_7480_Desc = {
    Text = "Le cri de Sarah résonna dans votre esprit, un murmure familier venant de nulle part, chuchotant faiblement « Sasa sœur », « Sasa sœur ».\n« Sasa sœur, où es-tu ? »"
  },
  Event_7480_Name = {
    Text = "\"Soeur Sasha\""
  },
  Event_7481_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7481_Desc = {
    Text = "\"...Je ne peux pas croire qu'il y ait une part de vérité dans ce que tu dis, mais le seul désir ne résoudra pas le Corps Dissous. Faisons quelque chose de concret.\""
  },
  Event_7481_Name = {
    Text = "Règle de Logan"
  },
  Event_7482_ChoiceDesc1 = {
    Text = "[Gagner 100 sigils noirs]"
  },
  Event_7482_ChoiceDesc2 = {
    Text = "[2 Cartes d'instruction aléatoires obtiennent l'Oraison : «(EnchantConfig.Arg1)»]"
  },
  Event_7482_Desc = {
    Text = "Les créations sont formées par la stagnation de la sagesse stable, peut-être peuvent-elles apporter une mélodie harmonieuse"
  },
  Event_7482_Name = {Text = "Désaccord"},
  Event_7483_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7483_Desc = {
    Text = "\"C'est un fragment de mémoire de quelqu'un qui est entré dans cette dimension,\" répondit Ramona, \"Il est facile de rencontrer cela en traversant des dimensions. Faites attention de ne pas le confondre avec vos propres souvenirs.\""
  },
  Event_7483_Name = {
    Text = "Fragment de souvenir : Whisky"
  },
  Event_7484_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7484_Desc = {
    Text = ": Suis le rythme de ton cœur, poursuis la lumière. Vous ne serez pas séparés, comme on ne peut distinguer le jour de la nuit"
  },
  Event_7484_Name = {
    Text = "Atrium gauche"
  },
  Event_7485_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7485_Desc = {
    Text = "Tu caresses sans cesse ces mains agitées, essayant de les calmer.\nBientôt, ton monde devient complètement paisible.\nL'amour est toujours récompensé"
  },
  Event_7485_Name = {
    Text = "Marais Sombre"
  },
  Event_7486_ChoiceDesc1 = {
    Text = "[Struggle] Infectez \"(Skill.Arg1)\", gagnez la Relique Argent \"(RelicConfig.Arg2)\""
  },
  Event_7486_ChoiceDesc2 = {
    Text = "[Give Up] Infecter \"(Skill.Arg1)\", obtenir une relique d'argent \"(RelicConfig.Arg2)\""
  },
  Event_7486_ChoiceDesc3 = {
    Text = "[Soyez Vigilant] Obtenez 25 sigils noirs"
  },
  Event_7486_Desc = {
    Text = "Des pensées impures envahissent ton esprit, la sensation nauséabonde d'une substance souillée est claire.\nCe liquide trouble et malodorant remplit tes pensées, la douleur envahit ton visage terrifié, te plongeant dans un cauchemar sans fin"
  },
  Event_7486_Name = {
    Text = "Crâne perforé"
  },
  Event_7487_ChoiceDesc1 = {
    Text = "[It's the Memphis Ritual Mirror]"
  },
  Event_7487_ChoiceDesc2 = {
    Text = "[It's a Directional Compass]"
  },
  Event_7487_ChoiceDesc3 = {
    Text = "[Je n'ai rien laissé tomber]"
  },
  Event_7487_Desc = {
    Text = "«Pionnier des dimensions. »\n\nUne voix ancienne résonne à tes oreilles, comme venue de la préhistoire, traversant les âges.\n\nDans une tension extrême, tu entends cette voix poser une question familière.\n\n«Ce que tu as perdu, cet objet rond, qui te permet de piocher au début de ton tour, qu'est-ce que c'est ? »"
  },
  Event_7487_Name = {
    Text = "Voix hors du monde"
  },
  Event_7488_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7488_Desc = {
    Text = "\"Ce n'est pas une casse,\" murmura la Poupée, en l'acceptant, \"mais bon, je peux toujours en extraire quelque chose d'utile.\""
  },
  Event_7488_Name = {Text = "Plaque"},
  Event_7489_ChoiceDesc1 = {
    Text = "Oraison aléatoire normale"
  },
  Event_7490_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7490_Desc = {
    Text = "Tu lis les pages tachées et déchirées, « jumeaux », « imprégnation », « sacrifice », « inefficace »...\nToujours des concepts fragmentés et des phrases difficiles à comprendre, seul ton cerveau enflé prouve que tu as lu cette page de déchets"
  },
  Event_7490_Name = {
    Text = "Ordre secret · Bas"
  },
  Event_7491_ChoiceDesc1 = {
    Text = "[What Price Are You Willing to Pay?] Améliorez aléatoirement la qualité de l'oraison d'une carte."
  },
  Event_7491_ChoiceDesc2 = {
    Text = "[Offrez-leur un Bloody Mary périmé] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_7491_Desc = {
    Text = "«Bienvenue, cher invité. N'hésitez pas à choisir, tout ceci est là en attendant votre arrivée.»\n«Euh, désolé de vous déranger, puis-je vous demander si vous êtes... la sœur jumelle de Daffodil ?»\n«Je suis Daffodil elle-même, puis-je vous demander, cher invité, quelle est la raison de votre visite aujourd'hui... ?»\n«Je suis désolé, désolé, vous êtes encore plus séduisante qu'avant, je ne vous ai même pas reconnue. Vous vous souvenez ? Il y a vingt ans, vous avez chassé un monstre de mon bar... Hier, le cauchemar revisité est réapparu, il a envahi le bar, accompagné de ses semblables, en groupe...»"
  },
  Event_7491_Name = {
    Text = "Fragment de souvenir : Rêve ancien"
  },
  Event_7492_ChoiceDesc1 = {
    Text = "[Chasser les corbeaux] obtenir 30 sigils noirs, infecter[(Skill.Arg2)], continuer à choisir"
  },
  Event_7492_ChoiceDesc2 = {
    Text = "[Continue chasing the child] Quitter"
  },
  Event_7492_Desc = {
    Text = ": Le deuxième corbeau s'envole, une plume blanche apparaît dans son sillage, semblable à un os"
  },
  Event_7492_Name = {
    Text = "Regard des Corbeaux Noirs"
  },
  Event_7493_ChoiceDesc1 = {
    Text = "[Tenter sa chance] Infecter [(Skill.Arg1)], entrer dans le jeu de hasard"
  },
  Event_7493_ChoiceDesc2 = {
    Text = "[Oublie Ça] Gagne 25 sigils noirs"
  },
  Event_7493_Desc = {
    Text = "\n\"Veux-tu tenter ta chance? Devine nos chiffres! Pour juste un petit prix!\" \nLes dés abandonnés bourdonnaient bruyamment, comme pour te parler. \n\"Roule-moi ! Roule-moi !\" \n\"Le seul ! Le dernier !\" \nD'accord, juste un... \nTu as pris un jeton. Tu décides..."
  },
  Event_7493_Name = {
    Text = "Partie de jeu sans fin"
  },
  Event_7494_ChoiceDesc1 = {
    Text = "[Resist Malice] Gagnez une Relique d'Argent \"(RelicConfig.Arg1)\", Infecté par \"(Skill.Arg2)\""
  },
  Event_7494_ChoiceDesc2 = {
    Text = "[Embrace Malice] Gagnez Relique d'argent \"(RelicConfig.Arg1)\", Infection \"(Skill.Arg2)\""
  },
  Event_7494_ChoiceDesc3 = {
    Text = "[Clear-Minded Departure] Gain 25 black sigils"
  },
  Event_7494_Desc = {
    Text = "Les pensées malveillantes sont devenues une épée, comme des dents acérées.\nElles dévorent la raison qui s'affaiblit dans le domaine, engloutissant les restes de volonté, tout comme les actes malveillants que la réalité vous inflige"
  },
  Event_7494_Name = {
    Text = "Pensée Illusoire"
  },
  Event_7495_ChoiceDesc1 = {
    Text = "[Struggle Fully] Retirer 1 Carte de Commande, Gagner Arg1 Le Sigil Noir"
  },
  Event_7495_ChoiceDesc2 = {
    Text = "[Allumer la toile d'araignée] copier 1 carte de commandement, infecter [(Skill.Arg1)]"
  },
  Event_7495_ChoiceDesc3 = {
    Text = "[Attendre en silence] Choisissez 1 carte parmi 3 cartes de commandement pour obtenir oraison :[(EnchantConfig.Arg1)]"
  },
  Event_7495_Desc = {
    Text = "De fins fils s’entrelacent autour de vous, à cet instant, vous êtes devenu la proie du domaine"
  },
  Event_7495_Name = {Text = "Enliséré"},
  Event_7496_ChoiceDesc1 = {
    Text = "[Destinataire : ∞] Infecter[(Skill.Arg1)]"
  },
  Event_7496_ChoiceDesc2 = {
    Text = "[Destinataire : Moi-même]Supprimer 1 carte"
  },
  Event_7496_ChoiceDesc3 = {
    Text = "[Destinataire : Professeur]Obtenir 25 le sigil noir"
  },
  Event_7496_Desc = {
    Text = "Il a donné au voyageur du domaine une chance : une chance de connectivité vers l'inconnu.\nQuelques morceaux de papier déchirés, une machine à écrire diffusant de l'encre, et un destinataire inconnu, unidirectionnel.\nLa volonté peut peut-être décider où votre message peut être transmis"
  },
  Event_7496_Name = {
    Text = "Confession unilatérale"
  },
  Event_7497_ChoiceDesc1 = {
    Text = "[Consentir avec joie]"
  },
  Event_7497_ChoiceDesc2 = {
    Text = "[Firm Rejection]"
  },
  Event_7497_Desc = {
    Text = "Des murmures résonnent dans l'environnement vide.\n« Oh, c'est cet idiot, le célèbre joueur qui dit toujours \"mourir ou gagner\", un bon à rien, reste loin de lui. »\nUne ombre mince et déprimée te lance quelques pièces, le tintement métallique résonne dans ta paume.\n« Une partie ? »"
  },
  Event_7497_Name = {
    Text = "Gambler célèbre"
  },
  Event_7498_ChoiceDesc1 = {
    Text = "[Nous allons tous bien] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infectée par «(Skill.Arg2)»"
  },
  Event_7498_ChoiceDesc2 = {
    Text = "[Qui êtes-Vous ?] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infectée par «(Skill.Arg2)»"
  },
  Event_7498_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_7498_Desc = {
    Text = "La machine à écrire cracha brusquement de l'encre, avec un nombre de points d'exclamation éblouissant.\n\"Doll, ça va ??? Pourquoi as-tu disparu quand le Gardien a disparu aussi ??? S'il te plaît, si tu es en sécurité, envoie un message !!! Les cheveux de William vont tomber si nous attendons plus longtemps !!!\""
  },
  Event_7498_Name = {
    Text = "Communication d'urgence"
  },
  Event_7499_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7499_Desc = {
    Text = "Tu places le dernier plâtre, elle éclate de rire avec une allure aigre, une ombre noire l'entoure, son image flottante disparaît de ton champ de vision"
  },
  Event_7499_Name = {
    Text = "Compléter le corps endommagé"
  },
  Event_7500_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7500_Desc = {
    Text = "Tu sors la clé en argent, tristement et avec dévotion, la serres dans ta paume, une lueur brumeuse t'enveloppe.\nDans un silence, seul le soupir résonne"
  },
  Event_7500_Name = {
    Text = "Œil de contemplation"
  },
  Event_7501_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7501_Desc = {
    Text = "Les regards résiduels te fixent encore, les cellules de ta chair hurlent et s'enfuient avec folie, les veines rampent sous la peau comme des insectes.  \nVous ressentez une puissance qui coule, éclatant dans les étranges transformations des membres"
  },
  Event_7501_Name = {
    Text = "Œil de contemplation"
  },
  Event_7502_ChoiceDesc1 = {
    Text = "[Avoid Gaze] Rassembler aléatoirement 1 Réveil"
  },
  Event_7502_ChoiceDesc2 = {
    Text = "[Regard Fixe] Choisissez de réveiller un réveilleur et réduisez son coût en arithmetica de l'oraison de 2 points. Infectez [(Skill.Arg1)]"
  },
  Event_7502_ChoiceDesc3 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_7502_Desc = {
    Text = ": Les tunnels dimensionnels relient des milliers d'univers, et dans le passage suprême, d'innombrables yeux vous fixent"
  },
  Event_7502_Name = {Text = "Son regard"},
  Event_7503_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7503_Desc = {
    Text = "Trop de chaos, trop de chaos.\nToutes les pensées ont été emportées par le flot de la conscience, emportées au loin par le courant.\nDans les creux de mon cerveau, il ne restait que confusion et douleur"
  },
  Event_7503_Name = {
    Text = "Inspiration soudaine"
  },
  Event_7504_ChoiceDesc1 = {Text = "[Pocketed]"},
  Event_7504_Desc = {
    Text = "La d-boue sursaturée semble renfermer certaines substances... observe avec la clé en argent et transforme-la en ta propre force"
  },
  Event_7504_Name = {
    Text = "Point d'extraction"
  },
  Event_7505_ChoiceDesc1 = {
    Text = "[Chasser les corbeaux] obtenir 35 sigils noirs, infecter[(Skill.Arg2)], continuer à choisir"
  },
  Event_7505_ChoiceDesc2 = {
    Text = "[Continue chasing the child] Quitter"
  },
  Event_7505_Desc = {
    Text = "Un corbeau s'envole, une plume noire tombe lentement"
  },
  Event_7505_Name = {
    Text = "Regard des Corbeaux Noirs"
  },
  Event_7506_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_7506_Desc = {
    Text = "Ici, c'est le champ de bataille de l'abîme. Le combat demande du courage et de la sagesse.\n\nOuvre l'œil, observe tes adversaires. Tu n'as pas besoin de tous les vaincre, juste leur chef !"
  },
  Event_7506_Name = {
    Text = "Épreuve des Asuras"
  },
  Event_7507_ChoiceDesc1 = {
    Text = "[Connecter] restaurer Arg2 points de vie"
  },
  Event_7507_Desc = {
    Text = "Tu explores dans la brume, soudain, l'insigne sur ta poitrine émet une faible lueur argentée. Qui t'appelle de l'autre côté de la communication ?"
  },
  Event_7507_Name = {
    Text = "Point de contact"
  },
  Event_7508_ChoiceDesc1 = {Text = "[Tail Him]"},
  Event_7508_ChoiceDesc2 = {
    Text = "[Salutations]"
  },
  Event_7508_Desc = {
    Text = ": Tac. Tac. Tac.\nUne silhouette blanche avance lentement dans le brouillard, comme un navire vers la nuit silencieuse.\nDe dos, il semble être un garçon.\nTu écoutes ses pas fatigués et prends une décision"
  },
  Event_7508_Name = {
    Text = "Cérémonie finale I"
  },
  Event_7509_ChoiceDesc1 = {
    Text = "[Accepter avec joie]"
  },
  Event_7509_ChoiceDesc2 = {
    Text = "[Soyez Vigilant]"
  },
  Event_7509_Desc = {
    Text = "Le corps de fusion s'effondre en gémissant, et tu es surpris de voir Clémentine derrière lui. \n « Je suis là pour dire au revoir, » répond-elle à tes questions sans répondre, « Pour exprimer ma gratitude, je peux te donner quelques indices. Cependant... cela nécessitera ta confiance. \n Laisse-moi te plonger dans l'hypnose, et tu sauras tout ce que je sais. » \n Peux-tu lui faire confiance ? \n « Fais attention, » avertit Ramona, « elle n'a pas d'autre intention. »"
  },
  Event_7509_Name = {
    Text = "Thérapie d'hypnose"
  },
  Event_7510_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_7510_Desc = {
    Text = "Tu te concentres, l'illusion se dissipe comme de l'encre. Tu avances, mais l'ombre dans ton cœur persiste"
  },
  Event_7510_Name = {Text = "Illusion"},
  Event_7511_ChoiceDesc1 = {
    Text = "[Poor Creature?]"
  },
  Event_7511_ChoiceDesc2 = {
    Text = "[Evolved Human?]"
  },
  Event_7511_ChoiceDesc3 = {
    Text = "[Who are you?]"
  },
  Event_7511_Desc = {
    Text = "L'homme que vous avez vu pour la sixième fois se tient en hauteur sur une structure en acier, surplombant la Terre. Le vent hurlant soulève ses longs cheveux, révélant la véritable apparence d'un serpent. \n Son regard se concentre sur vous, puis se détourne vers les ténèbres au loin. \n « Ah, quelle créature si pitoyable. \n La sensation d'être trahi doit être aussi douce que celle des humains ayant <Bold:évolué> »."
  },
  Event_7511_Name = {
    Text = ": Compagnon étrange VI"
  },
  Event_7512_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7512_Desc = {
    Text = "Qui ferait attention à un rouleau de film sous le regard des chiens des enfers ?"
  },
  Event_7512_Name = {
    Text = "Souvenirs lumineux"
  },
  Event_7513_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7513_Desc = {
    Text = "Ne regarde pas, ne discute pas, n'écoute pas, ne pense même pas—le choix des sages"
  },
  Event_7513_Name = {
    Text = "Rune de Frénésie"
  },
  Event_7514_ChoiceDesc1 = {
    Text = "[Leave] Supprimer 2 Cartes"
  },
  Event_7514_Desc = {
    Text = "Au milieu des bruits environnants, tu entends à peine un étrange battement d'ailes. La clé en argent vibre soudainement contre ta poitrine, et tu es poussé par une force à lever la tête, découvrant un immense trou noir dans le ciel. \n « Dommage, dommage, mais ce n'est pas grave. Nous nous reverrons, mon respecté œil sans regard. »"
  },
  Event_7514_Name = {
    Text = "Thérapie d'hypnose"
  },
  Event_7515_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7515_Desc = {
    Text = "Tu peux ignorer tout autour de toi, mais pas les battements de ton cœur. Ils s'accélèrent, te pressent et te reprochent"
  },
  Event_7515_Name = {
    Text = "Atrium gauche"
  },
  Event_7516_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7516_Desc = {
    Text = "\"C'est génial !!! Les cheveux de William-senpai sont en sécurité !!!\"\nBien que ce n'était qu'un message texte, le contenu du télégramme vous a fait imaginer ce rugissement rauque."
  },
  Event_7516_Name = {
    Text = "Communication d'urgence"
  },
  Event_7517_ChoiceDesc1 = {
    Text = "[dis-lui la vérité] réveille aléatoirement 1 réveilleur, contamine[(Skill.Arg1)]"
  },
  Event_7517_ChoiceDesc2 = {
    Text = "[Conceal the Truth] Gain 1 out of 3 Orisons"
  },
  Event_7517_Desc = {
    Text = "«Sauvez-moi.»\nLe voyageur mélancolique saisit ta main. Il erre ici depuis des siècles.\n«Je suis un soldat, envoyé vers l'est lointain pour combattre les hérétiques.\nJ'ai traversé des forêts denses, franchi des rivières, mais je me suis perdu, revenant encore et encore au même endroit.\nIl y a quelque chose qui me regarde dans l'obscurité. Je ne peux pas le voir, mais je le sais. Il me regarde sans cesse.\nMaintenant, je veux juste rentrer chez moi...»\nTu regardes les ombres flottantes derrière lui. Elles sont d'abord floues, puis deviennent progressivement plus nettes - c'est une grande bouche ouverte, prête à se régaler de l'âme perdue qui a été marinée pendant un siècle."
  },
  Event_7517_Name = {Text = "Dévoreur"},
  Event_7518_ChoiceDesc1 = {
    Text = "[Into the Darkness]"
  },
  Event_7518_ChoiceDesc2 = {Text = "[Farewell]"},
  Event_7518_Desc = {
    Text = "«Céleste, tu vas m'aider cette fois, n'est-ce pas ?»\nLa fille marche nerveusement sur place, jetant de temps à autre un regard en arrière vers l'Éveilleur silencieux.\nElle ne répond pas à la fille, et alors que l'inquiétude de celle-ci grandit, une légère brise soulève le voile blanc et pousse doucement la fille dans une certaine direction.\n«Je te protégerai.»\nJe te protégerai, même si j'ai échoué une fois dans cette tâche de «protection».\nMais cette fois, je ne te laisserai pas te perdre dans les ténèbres."
  },
  Event_7518_Name = {
    Text = "Bénédiction de la Sainte Navigatrice"
  },
  Event_7519_ChoiceDesc1 = {
    Text = "[Partir] Choisissez 1 carte de commandement parmi 3 pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_7519_Desc = {
    Text = "Ces chants, certains anciens, perdus avant le déluge ; d'autres récents, chantant le dernier Nouvel An, les nouveaux gants achetés par l'épouse chez Lentiniens... Après le chaos des émotions, il ne reste qu'un vide dans le cœur"
  },
  Event_7519_Name = {
    Text = "Chant de la mer"
  },
  Event_7520_ChoiceDesc1 = {
    Text = "[Expel Colors] Obtenir une relique d'or \"(RelicConfig.Arg1)\" et infecter \"(Skill.Arg2)\"."
  },
  Event_7520_ChoiceDesc2 = {
    Text = "[Embrasser la couleur] Obtenez une relique en or en choisissant parmi 3, contagion[(Skill.Arg1)]"
  },
  Event_7520_ChoiceDesc3 = {
    Text = "[Se retourner et partir] obtenez une relique d'argent[(RelicConfig.Arg1)]"
  },
  Event_7520_Desc = {
    Text = "Murphy vous suivait de près, mais s'arrêta soudainement à un coin.\nLes couleurs chatoyantes tourbillonnaient devant elle, l'air émettant un soupir.\n\"Mur@1...\"\nÉtait-ce l'esprit d'un noyé piégé sur le Sonaniel ? Ou un proche décédé suivant les vivants ?"
  },
  Event_7520_Name = {
    Text = "Couleurs nostalgiques"
  },
  Event_7521_ChoiceDesc1 = {
    Text = "[Continuer à chercher] Augmenter Arg1 points de vie, infecter[(Skill.Arg2)]"
  },
  Event_7521_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7521_Desc = {
    Text = "Des mots familiers résonnent à vos oreilles, réconfortants et rassurants, mais s'arrêtent brusquement lorsque vous essayez de les suivre"
  },
  Event_7521_Name = {
    Text = "Contact Anormal"
  },
  Event_7522_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7522_Desc = {
    Text = "\"C'était une mélodie blasphématoire.\"\nVous avez couvert vos oreilles, du sang coulait, et vous avez affirmé cela avec certitude."
  },
  Event_7522_Name = {
    Text = "Voix interdite"
  },
  Event_7523_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7523_Desc = {
    Text = "Ces couleurs se tordaient vaguement en deux formes humaines, mais elles restaient immobiles dans ce coin, vous offrant leur bénédiction finale"
  },
  Event_7523_Name = {
    Text = "Couleurs nostalgiques"
  },
  Event_7524_ChoiceDesc1 = {
    Text = "[Écoutez] Obtenez 1 parmi 3 Reliques en Or"
  },
  Event_7524_Desc = {
    Text = "La voix de Daphné s'arrêta un instant.\n\"Oh, tu as choisi ça ? Bon choix, en récompense, je te donnerai un cadeau spécial.\""
  },
  Event_7524_Name = {
    Text = "Temps restant"
  },
  Event_7525_ChoiceDesc1 = {
    Text = "[Insister à demander] Infecter[(Skill.Arg1)]"
  },
  Event_7525_ChoiceDesc2 = {
    Text = "[Abandonner l'Enquête] Choisissez 1 carte à supprimer"
  },
  Event_7525_Desc = {
    Text = "\"Hmm, un choix sage. Face à un ennemi aussi redoutable, tu voudrais sûrement te connaître toi-même et connaître ton adversaire ? Cependant, connaître trop de secrets sur les dimensions pourrait troubler ton esprit, tu sais ?\""
  },
  Event_7525_Name = {
    Text = "Temps restant"
  },
  Event_7526_ChoiceDesc1 = {
    Text = "[Enquête persistante] Énerver Jonquille et entrer en bataille."
  },
  Event_7526_ChoiceDesc2 = {
    Text = "[Abandonner de demander] Recevez une pénalité mineure"
  },
  Event_7526_Desc = {
    Text = "\"Oh ? Même maintenant, tu penses encore à me traquer ? Petit, être trop avide n'est pas bon, tu sais ?\""
  },
  Event_7526_Name = {
    Text = "Temps restant"
  },
  Event_7527_ChoiceDesc1 = {
    Text = "[Focus] Augmentez la Santé Maximale d'Arg1"
  },
  Event_7527_ChoiceDesc2 = {
    Text = "[Ignorer] 2 Cartes d'instruction aléatoires obtiennent l'Oraison : «(EnchantConfig.Arg1)», infecter 2 «(Skill.Arg2)»"
  },
  Event_7527_Desc = {
    Text = "Vous poursuivez l'ombre du chien des enfers sur les routes de la ville.  \nDes flocons de neige glacés commencent à tomber du ciel, se posant doucement sur votre visage et votre poitrine, apaisant votre cœur agité"
  },
  Event_7527_Name = {Text = "Neige"},
  Event_7528_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7528_Desc = {
    Text = "Vous agitez les bras pour chasser ces corbeaux agaçants.\nIls ricanent, se moquant de votre stupidité et de votre faiblesse.\nNéanmoins, votre courage les touche, et vous recevez une récompense méritée"
  },
  Event_7528_Name = {
    Text = "Chant des Corbeaux"
  },
  Event_7529_ChoiceDesc1 = {
    Text = "[au sujet de Lily] obtenez une relique d'argent [(RelicConfig.Arg1)]"
  },
  Event_7529_ChoiceDesc2 = {
    Text = "[À propos du Chien des enfers] Obtenez la relique en or \"(RelicConfig.Arg1)\", infectez \"(Skill.Arg2)\""
  },
  Event_7529_Desc = {
    Text = [[

Traversez la porte sans fin, depuis un endroit lointain et inaccessibile, la voix de Jonquille arrive.
"C'est le moment des indices de Jonquille."]]
  },
  Event_7529_Name = {
    Text = "Temps restant"
  },
  Event_7530_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7530_Desc = {
    Text = "Tu sembles toujours tenace, même en chantant tu restes toi-même.\nTu ne crois pas aux murmures à ton oreille, tu ne te fies qu'à la raison humaine.\nMais... le jour où le sol solide sur lequel tu vis sera couvert de boue noire, arracher tes yeux pour voir sera ta seule option à l'agonie"
  },
  Event_7530_Name = {
    Text = "Chant des Corbeaux"
  },
  Event_7531_ChoiceDesc1 = {
    Text = "[Stare Down the Hellhound Source] Obtenez une relique dorée \"(RelicConfig.Arg1)\" et infectez \"(Skill.Arg2)\""
  },
  Event_7531_ChoiceDesc2 = {
    Text = "[Concentration au combat] Choisissez 1 carte de commandement parmi 3 pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_7531_Desc = {
    Text = "Le contour du chien des enfers se transforme.\nSon corps est connecté aux fissures du mur, révélant une illusion sinistre"
  },
  Event_7531_Name = {
    Text = "angle d'origine"
  },
  Event_7532_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7532_Desc = {
    Text = "« Miaou, miaou, miaou miaou miaou… » \n Tu te racles la gorge, essayant de te montrer faible et inoffensif. \n « Miaou ! Miaou ! Miaou miaou miaou ! » \n Le groupe de chats semble accepter ta bienveillance, te répondant par des cris éclatants. Vos miaulements se succèdent sans cesse, jour et nuit, la lune effrayée se cache derrière les nuages."
  },
  Event_7532_Name = {
    Text = "Ville des chats"
  },
  Event_7533_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7533_Desc = {
    Text = "Mais c'est juste une créature luttant pour survivre, cherchant un morceau de bois flottant pour se reposer...\nTu soupires, laissant le liquide noir de la queue du papillon couler sur ta joue"
  },
  Event_7533_Name = {
    Text = "Papillon de l'Élixir Noir"
  },
  Event_7534_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7534_Desc = {
    Text = "Tu as utilisé toute ta force, t'éloignant des chats. \nEn te retournant, ils sont déjà retournés à leurs activités. Se toilettant, dormant, se battant... \nHonnêtement, ils ne se soucient pas des humains"
  },
  Event_7534_Name = {
    Text = "Ville des chats"
  },
  Event_7535_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7535_Desc = {
    Text = "Tu jettes les morceaux de viande restants dans le groupe de chats. \n Les chats se ruent comme une marée noire. Ils mordent frénétiquement les morceaux de viande avant de se disperser rapidement. \n Malheureusement, c'est un morceau de viande périmé. Il peut remplir des ventres creux, mais ne satisfait pas vraiment."
  },
  Event_7535_Name = {
    Text = "Ville des chats"
  },
  Event_7536_ChoiceDesc1 = {
    Text = "[Eye Contact] Obtenir une relique d'or \"(RelicConfig.Arg1)\" et infecter \"(Skill.Arg2)\"."
  },
  Event_7536_ChoiceDesc2 = {
    Text = "[Abandonner la résistance] Réveiller aléatoirement 2 éveillés, Infection deux fois[(Skill.Arg1)]"
  },
  Event_7536_ChoiceDesc3 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_7536_Desc = {
    Text = "Des milliers d'yeux chuchotent autour de toi. \n «Nous voyageons, nous nous arrêtons, nous avons marché d'un pas grand et rapide pendant des dizaines de milliers d'années, voire plus. \nLorsque le soleil s'assombrit sous nos regards, lorsque la vie de la vieille Terre est engloutie par les flots. \nNous avons déjà été profondément fascinés par les mystères de l'univers.»"
  },
  Event_7536_Name = {Text = "œil"},
  Event_7537_ChoiceDesc1 = {
    Text = "[Feel Panic] Réveiller aléatoirement 1 Réveilleur"
  },
  Event_7537_ChoiceDesc2 = {
    Text = "[Ressentir de la satisfaction] Choisissez de réveiller 1 réveilleur et réduisez de 2 points le coût en arithmetica de sa carte de réveil. Infectez[(Skill.Arg1)]"
  },
  Event_7537_ChoiceDesc3 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_7537_Desc = {
    Text = "As-tu déjà vu un ciel sans lune ni étoiles, où flottent d'innombrables pupilles agrandies ? \n On dirait qu'en tendant la main, tu pourrais les dévisser et les éclabousser de chair et de sang. \n Mais lorsque tu ouvres les cinq doigts, il n'y a rien à toucher. \n Les yeux du destin te fixent sans cligner, ils ont trouvé un grain de sable scintillant dans le chaos de l'univers."
  },
  Event_7537_Name = {
    Text = "Pupille du dôme"
  },
  Event_7538_ChoiceDesc1 = {
    Text = "[Déposer les Mains sur les Oreilles] Obtenir une relique d'argent [(RelicConfig.Arg1)]"
  },
  Event_7538_ChoiceDesc2 = {
    Text = "[Continuer à se boucher les oreilles] obtenez 75 sigils noirs, infection[(Skill.Arg2)]"
  },
  Event_7538_Desc = {
    Text = "Hurlement sans fin –\nLe chanteur corbeau avec son plumage noir luisant et son bec acéré émet des cris perçants, déchirant tes tympans.\nLaisse tomber les mains sur tes oreilles !\nLa troupe de corbeaux nocturnes veut boire la peur non filtrée nichée en toi"
  },
  Event_7538_Name = {
    Text = "Chant de la Meute de Corbeaux"
  },
  Event_7539_ChoiceDesc1 = {
    Text = "[Imitez l'appel du chat] Gagnez 50 Sigils Noirs"
  },
  Event_7539_ChoiceDesc2 = {
    Text = "[Nourrir] Obtenez 75 sigils noirs, contagion[(Skill.Arg2)]"
  },
  Event_7539_Desc = {
    Text = "Tu es tombé sur le territoire du chat noir.\nDes yeux s'ouvrent soudain dans l'obscurité, avec curiosité, examen, vigilance... mais sans aucune bienveillance.\nÉmeraude, ambre jaune, bleu paon...\nTu as l'impression d'être dans une mer étincelante de joyaux.\nPour te sortir de là, tu—"
  },
  Event_7539_Name = {
    Text = "Ville des chats"
  },
  Event_7540_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7540_Desc = {
    Text = "Tu remarques une main différente. Elle est délicate, blanche, et reste calme tout du long.\nPlus important encore, tu la reconnais, c'est ta propre main.\nTu la tords sans hésitation.\nDes cris stridents résonnent à tes oreilles, et le marais disparaît enfin"
  },
  Event_7540_Name = {
    Text = "Marais Sombre"
  },
  Event_7541_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7541_Desc = {
    Text = "«Une décision sage.» dit la silhouette les mains vides, «les choix déjà vérifiés ont des résultats prédéterminés, tandis que les actions inconnues mèneront à un nouvel avenir.»\nUn léger espoir t'enveloppe doucement. La silhouette se dissipe, tu te tiens la poitrine, ne sachant pas si ce qui vient de se passer était une projection ou une illusion créée sous la pression mentale."
  },
  Event_7541_Name = {
    Text = "Chemin bifurqué"
  },
  Event_7542_ChoiceDesc1 = {
    Text = "[Félicitez-le] choisissez une carte de commandement parmi 3 cartes et obtenez l'oraison :[(EnchantConfig.Arg1)]"
  },
  Event_7542_ChoiceDesc2 = {
    Text = "[se moque de lui] contamine[(Skill.Arg1)], réimprime, au maximum 2 fois"
  },
  Event_7542_Desc = {
    Text = "Le cerveau dit : les chaînes ont piégé mon cortex frontal, mon tronc cérébral, ma matière grise, mais elles ne peuvent pas enchaîner plus de 10 milliards de petites cellules en quête de vérité. \n Tu dis : qui t'a enfermé ici ? Ton corps ? \n Le cerveau dit : le corps ? Ne fais pas rire. Avant, on m'appelait « Johnny le boucher ». \n Quand j'avais un corps, je ne savais même pas faire des additions et des soustractions simples. \n Mais regarde ce que je suis devenu après que le directeur m'ait débarrassé de mon corps superflu ! Un physicien, un philosophe, et un poète amateur."
  },
  Event_7542_Name = {
    Text = "Cerveau philosophique"
  },
  Event_7543_ChoiceDesc1 = {
    Text = "[Démontrez la conjecture de Goldbach] obtenez une relique d'argent[(RelicConfig.Arg1)]"
  },
  Event_7543_ChoiceDesc2 = {
    Text = "[Fin du voyage] Une carte est tirée au hasard pour obtenir une oraison : [(EnchantConfig.Arg1)]"
  },
  Event_7543_ChoiceDesc3 = {
    Text = "[Refuse to Ask] Obtenez 50 sigils noirs"
  },
  Event_7543_Desc = {
    Text = "Lorsque vous avez ramassé le tableau spirituel, la voix d'une jeune femme a envahi votre esprit. \n\"Posez-moi n'importe quelle question. Je sais tout.\"\n\"De mes réponses, vous recevrez le don du destin.\""
  },
  Event_7543_Name = {
    Text = "Planche de spiritisme"
  },
  Event_7544_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7544_Desc = {
    Text = "Tu lis les pages tachées et déchirées, des phrases fragmentées sortent de ta bouche, « ancêtres », « fils sacré », « mort éternelle », « longue mémoire » et d'autres termes inondent ton esprit, stimulant tes nerfs déjà sensibles et fragiles à cause des cauchemars"
  },
  Event_7544_Name = {
    Text = "Ordre secret · Haut"
  },
  Event_7545_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7545_Desc = {
    Text = "Une goutte de boue noire tombe sur ton visage, provoquant une démangeaison.\nIncapable de supporter cela, tu chasses le papillon.\nLe papillon esquive ton geste malveillant et disparaît silencieusement au loin"
  },
  Event_7545_Name = {
    Text = "Papillon de l'Élixir Noir"
  },
  Event_7546_ChoiceDesc1 = {
    Text = "[Leave] Trouver un phare de recherche"
  },
  Event_7546_ChoiceDesc2 = {
    Text = "[Break into Mist] Perdre Arg2 Vie"
  },
  Event_7546_ChoiceDesc3 = {
    Text = "[Enter Directly]"
  },
  Event_7546_Desc = {
    Text = "Devant se trouve une brume noire épaisse, entrer imprudemment entraînera des clades.\nPeut-être devriez-vous trouver un « projecteur » pour dissiper la brume"
  },
  Event_7546_Name = {Text = "inconnu"},
  Event_7547_ChoiceDesc1 = {
    Text = "[Accepter l'Illusion] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infectée par «(Skill.Arg2)»"
  },
  Event_7547_ChoiceDesc2 = {
    Text = "[Deny Phantasm] Obtenir une relique d'argent \"(RelicConfig.Arg1)\" et infecter \"(Skill.Arg2)\"."
  },
  Event_7547_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_7547_Desc = {
    Text = "Sous le lourd pont de fer dans l'obscurité, sur la berge silencieuse envahie de roseaux, une papillon scintillant surgit soudain. \n Le papillon se pose léger dans ta paume, les hurlements affreux s'arrêtent, remplacés par les chants réguliers des ouvriers transportant des barres d'acier, le bruit des marteaux à tête de clou et le son métallique clair des rivets qui s'entrechoquent..."
  },
  Event_7547_Name = {
    Text = "Illusion du pont d'acier"
  },
  Event_7548_ChoiceDesc1 = {
    Text = "[Chasser les corbeaux] obtenir 40 sigils noirs, infecter[(Skill.Arg2)], continuer à choisir"
  },
  Event_7548_ChoiceDesc2 = {
    Text = "[Keep Chasing the Child] Gagnez 25 sigils noirs et partez."
  },
  Event_7548_Desc = {
    Text = "Un corbeau se tient sur le lustre. \n Deux corbeaux se tiennent sur le lustre. \n Trois corbeaux se tiennent sur le lustre. \n … \n Ces créatures noires tordent leur cou, se tenant sur le lustre au coin de la rue, te regardant de haut avec des yeux empreints de malice. Ces têtes en ombre semblent partager un corps immergé dans la lave corrodée."
  },
  Event_7548_Name = {
    Text = "Regard des Corbeaux Noirs"
  },
  Event_7549_ChoiceDesc1 = {
    Text = "[Partir] Si le nombre de réveilleurs éveillés est inférieur à 3, obtient une relique d'argent[(RelicConfig.Arg1)]"
  },
  Event_7549_ChoiceDesc2 = {
    Text = "[Partir] Si le nombre de réveilleurs éveillés est d'au moins 3, obtient une relique en or[(RelicConfig.Arg1)]"
  },
  Event_7549_Desc = {
    Text = "Tu ignores cette marque et avances.\n<Italic: La gnose éveillée est si lourde>, la marque s'élargit et serpente de plus en plus avec tes pas, comme si une main pouvait surgir à travers la fissure à tout moment pour te traîner dans les profondeurs"
  },
  Event_7549_Name = {
    Text = "Crevasse rampante"
  },
  Event_7550_ChoiceDesc1 = {
    Text = "[Return the Gaze] Gagnez une Relique d'Or \"(RelicConfig.Arg1)\", Infection \"(Skill.Arg2)\""
  },
  Event_7550_ChoiceDesc2 = {
    Text = "[Éviter le regard] Réveiller 2 éveillés aléatoires, infecter deux fois [(Skill.Arg1)]"
  },
  Event_7550_ChoiceDesc3 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_7550_Desc = {
    Text = "Tu peux sentir un regard, un œil détaché de la dimension, bien au-dessus du domaine, qui t'observe, ainsi que la fille devant toi.\nTa respiration commence à s'accélérer, au plus profond de ta raison, une peur primitive commence à crier"
  },
  Event_7550_Name = {
    Text = "Qui regarde"
  },
  Event_7551_ChoiceDesc1 = {
    Text = "[Continuer à chercher] Augmenter Arg1 points de vie, infecter[(Skill.Arg2)]"
  },
  Event_7551_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7551_Desc = {
    Text = "Une lueur discrète apparaît, brillante et chaude, mais disparaît soudainement quand tu t'en approches"
  },
  Event_7551_Name = {
    Text = "Contact Anormal"
  },
  Event_7552_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7552_Desc = {
    Text = "Murmurant doucement leurs chants, le courant chaud vous apporte la bénédiction du retour"
  },
  Event_7552_Name = {
    Text = "Chant de la mer"
  },
  Event_7553_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_7553_Desc = {
    Text = "Tu aperçois une lueur au loin, tu as enfin traversé cette brume suffocante"
  },
  Event_7553_Name = {
    Text = "Brouillard du Chaos"
  },
  Event_7554_ChoiceDesc1 = {
    Text = "[Untangle Lower Branch]"
  },
  Event_7554_Desc = {
    Text = "Les connaissances du domaine résiduel s'entrelacent, créant un champ de force instable.  \nPeut-être pouvez-vous libérer l'esprit entremêlé, vous ouvrant un chemin vers l'avant"
  },
  Event_7554_Name = {
    Text = "Chemin d'intrication"
  },
  Event_7555_ChoiceDesc1 = {
    Text = "[Untangle the upper branches]"
  },
  Event_7555_Desc = {
    Text = "Les connaissances du domaine résiduel s'entrelacent, créant un champ de force instable.  \nPeut-être pouvez-vous libérer l'esprit entremêlé, vous ouvrant un chemin vers l'avant"
  },
  Event_7555_Name = {
    Text = "Chemin d'intrication"
  },
  Event_7556_ChoiceDesc1 = {
    Text = "[Unravel the Left Branch]"
  },
  Event_7556_Desc = {
    Text = "Les connaissances du domaine résiduel s'entrelacent, créant un champ de force instable.  \nPeut-être pouvez-vous libérer l'esprit entremêlé, vous ouvrant un chemin vers l'avant"
  },
  Event_7556_Name = {
    Text = "Chemin d'intrication"
  },
  Event_7557_ChoiceDesc1 = {
    Text = "[Unravel the Left Branch]"
  },
  Event_7557_Desc = {
    Text = "Les connaissances du domaine résiduel s'entrelacent, créant un champ de force instable.  \nPeut-être pouvez-vous libérer l'esprit entremêlé, vous ouvrant un chemin vers l'avant"
  },
  Event_7557_Name = {
    Text = "Chemin d'intrication"
  },
  Event_7558_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7558_Desc = {
    Text = "Vous avez encore plusieurs batailles à affronter, ce n'est pas le moment de flâner"
  },
  Event_7558_Name = {
    Text = "Enregistrement d'organes"
  },
  Event_7559_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7559_Desc = {
    Text = "Les caractères sur le papier deviennent soudain complets et vivants, des mots terrifiants capables de bouleverser la foi et les fondements de tout souffrant inconscient. Plus tu lis, plus tu es perdu, plus tu lis, plus tu as peur, incapable de t'empêcher de gratter ton cuir chevelu du bout des doigts. \n Tout à coup, ces symboles chargés de malédiction disparaissent. Ramona interrompt ta lecture et force le livre à être enfoui dans la valise."
  },
  Event_7559_Name = {
    Text = "Ordre secret · Bas"
  },
  Event_7560_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7560_Desc = {
    Text = "Joie, tristesse, chagrin, mélancolie... ce sont toutes tes émotions.\nToi, et les innombrables autres toi dans d'autres mondes au-delà des dimensions"
  },
  Event_7560_Name = {Text = "Addiction"},
  Event_7561_ChoiceDesc1 = {
    Text = "[Écouter en silence] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infectée par «(Skill.Arg2)»"
  },
  Event_7561_ChoiceDesc2 = {
    Text = "[Elle est ici] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infectée par «(Skill.Arg2)»"
  },
  Event_7561_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_7561_Desc = {
    Text = ": Les gémissements du monstre résonnent dans votre esprit, dans le liquide noir informe, une voix murmure faiblement \"Sasha sœur\", \"Sasha sœur\".\n\"Sasha sœur, où es-tu ?\""
  },
  Event_7561_Name = {
    Text = "\"Soeur Sasha\""
  },
  Event_7562_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7562_Desc = {
    Text = "\"Rejoignez-le, rejoignez-les, rejoignez-nous. \nDevenez Son Gardien, devenez Son représentant. \nLaissez Son Rêve guider votre chemin...\" \nLes prières chaotiques troublent votre esprit. Après que les voix se soient estompées, vous vous trouvez trempé de sueur."
  },
  Event_7562_Name = {
    Text = "Prière du Rêve"
  },
  Event_7563_ChoiceDesc1 = {
    Text = "[Never Heard of It]"
  },
  Event_7563_ChoiceDesc2 = {
    Text = "[Entendu de]"
  },
  Event_7563_Desc = {
    Text = "『Étudiant, puis-je te prendre un moment ?\nJ'aimerais vous parler quelques minutes des légendes locales.\nAvez-vous entendu parler d'une créature appelée 'Cerbère' ?』"
  },
  Event_7563_Name = {
    Text = ": Compagnon étrange I"
  },
  Event_7564_ChoiceDesc1 = {
    Text = "[Quit Thinking] Obtenez la relique maudite \"(RelicConfig.Arg1)\", infectez \"(Skill.Arg2)\""
  },
  Event_7564_ChoiceDesc2 = {
    Text = "[Rattraper la Perspicacité] 1 Carte d'instruction aléatoire obtient l'Oraison : [(EnchantConfig.Arg1)]"
  },
  Event_7564_Desc = {
    Text = "L'attaque du port, un cargo mystérieux sans retour et de nouveaux \"amis\" à nageoires... Un piège bien préparé ou un autre voyage plein d'incidents ?\nLa réalité et la raison s'entremêlent, des idées et des inspirations jaillissent de l'esprit"
  },
  Event_7564_Name = {
    Text = "Inspiration soudaine"
  },
  Event_7565_ChoiceDesc1 = {
    Text = "[Elworth's Volcano?] Augmentez la santé maximale de Arg1"
  },
  Event_7565_ChoiceDesc2 = {
    Text = "[Effort de mémoire] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_7565_Desc = {
    Text = "Des larmes noires tombent sur les joues de Lily. « Nous nous sommes déjà rencontrés, maman, » murmure-t-elle doucement, « au volcan d'Elworth... »"
  },
  Event_7565_Name = {
    Text = "Souvenirs volcaniques"
  },
  Event_7566_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7566_Desc = {
    Text = "« Plonger @1… dans la mer… »\n Les runes scintillent devant tes yeux, tu ne peux t'empêcher de tendre la main vers le vide, essayant de les saisir —\n « Qu'est-ce que tu attends ! Ils vont te rattraper ! »\n La fille mystérieuse te tire vers l'autre bout du pont, interrompant ta connexion avec les runes. \n Mais il y a bien une force qui a laissé une marque au bout de tes doigts."
  },
  Event_7566_Name = {
    Text = "Rune de Frénésie"
  },
  Event_7567_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7567_Desc = {
    Text = "Tu n'as aucun intérêt pour les murmures mystiques, et tu ne veux pas risquer la folie en entrant dans la nuit"
  },
  Event_7567_Name = {
    Text = "Un appel au secours"
  },
  Event_7568_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7568_Desc = {
    Text = "Peu importe, le devoir du gardien te pousse à ne pas abandonner l'espoir de trouver l'expéditeur, même si c'est flou et obscur"
  },
  Event_7568_Name = {
    Text = "Un appel au secours"
  },
  Event_7569_ChoiceDesc1 = {
    Text = "[Observe It] Gagnez 25 sigils noirs"
  },
  Event_7569_ChoiceDesc2 = {
    Text = "[Pet It] 50% de chances de gagner 50 Sigils Noirs, 50% de chances de ne rien obtenir"
  },
  Event_7569_Desc = {
    Text = "Une chatte noire surgit soudainement dans l'allée, s'enroulant de manière anormale autour de vos pieds, ses yeux vert émeraude scintillant d'une lueur glaçante, comme pour dire « Ne me poursuis pas, joue avec moi un instant. »\n « Tu l'as déjà vu, il est à tes côtés, ces ombres contaminées par la folie, frénétiques... ne regarde pas son contour. »"
  },
  Event_7569_Name = {Text = "Nuit-elfe"},
  Event_7570_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7570_Desc = {
    Text = "\"Impossible, je n'y crois pas !\" La voix a crié, \"Cette femme qui m'a envoyé au diable n'est pas ma sœur Shasha !\""
  },
  Event_7570_Name = {
    Text = "\"Soeur Sasha\""
  },
  Event_7571_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7571_Desc = {
    Text = "\"Reçu. Nous allons procéder à la livraison de l'inventaire de base. Veuillez vérifier et confirmer.\""
  },
  Event_7571_Name = {
    Text = "Soutien de communication"
  },
  Event_7572_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7572_Desc = {Text = "Inutile"},
  Event_7572_Name = {
    Text = "Reliques des anciens"
  },
  Event_7573_ChoiceDesc1 = {
    Text = "[Regardez de près] Gagnez 1 parmi 3 Oraisons"
  },
  Event_7573_ChoiceDesc2 = {
    Text = "[Arracher l'affiche] 1 Carte d'instruction aléatoire obtient l'Oraison : «(EnchantConfig.Arg1)», infectée par «(Skill.Arg2)»"
  },
  Event_7573_Desc = {
    Text = "Un candélabre que l'on trouve partout dans un musée de cire.\nAvec la lumière orange maladive, vous découvrez une affiche dessinée à la main accrochée sur le mur"
  },
  Event_7573_Name = {
    Text = "Rires dans les ténèbres"
  },
  Event_7574_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7574_Desc = {
    Text = "\"Lily a son propre cœur ; elle n'a besoin d'écouter personne.\" Vous avez répondu calmement.\nFrancis a reniflé, n'offrant aucune réponse."
  },
  Event_7574_Name = {Text = "Son choix"},
  Event_7575_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7575_Desc = {
    Text = "Ceci est un ensemble de photos de groupe. \n Des gens apathiques sont accroupis derrière une clôture en fer, le visage plein de souffrance. \n Une des photos attire votre attention. C'est probablement une jeune femme maigre, avec un visage vide. \n Cet être grotesque et profanateur s'enroule autour de son corps par cercles. \n Vous ne pouvez pas voir son visage, mais dans votre imagination, elle doit être sans expression."
  },
  Event_7575_Name = {
    Text = "enregistrer fidèlement"
  },
  Event_7576_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7576_Desc = {
    Text = "Vous contemplez avec fascination ces bijoux étincelants, et sans vous en apercevoir, vous avez déjà saisi la main noire et décharnée, couverte de mucus.\nElle a Juste légèrement serré la main, puis l'a relâchée.\nRien ne s'est passé, sinon un filet de vapeur noire qui a glissé le long de vos doigts jusque dans votre manche."
  },
  Event_7576_Name = {
    Text = "Renverser la griffe maléfique"
  },
  Event_7577_ChoiceDesc1 = {
    Text = "[Play a Few Notes] Obtenez la relique argent \"(RelicConfig.Arg1)\" et infligez \"(Skill.Arg2)\"."
  },
  Event_7577_ChoiceDesc2 = {
    Text = "[Mettre le Couvercle] Obtenir un Oraison à 3 choix"
  },
  Event_7577_Desc = {
    Text = "Le piano au bord du mur est ouvert. Il a des touches jaunies et des bords fissurés révélant le bois, mais chaque touche est soigneusement nettoyée.\nIl est la source de joie de tant de gens"
  },
  Event_7577_Name = {
    Text = "Mélodie de l'enfance"
  },
  Event_7578_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7578_Desc = {
    Text = "Le porteur de la lance pousse un grognement, comme un enfant maltraité en pleurs.\nLe son s'estompe instantanément, emportant deux autres marins... Ce n'était qu'une illusion reflétée par le domaine"
  },
  Event_7578_Name = {
    Text = "Poursuivre sans relâche"
  },
  Event_7579_ChoiceDesc1 = {
    Text = "[Partir] Obtient une relique d'argent[(RelicConfig.Arg1)]"
  },
  Event_7579_Desc = {
    Text = "«Correct.»\nLe propriétaire de la voix est très satisfait de cette réponse, un objet brillant est jeté hors de l'eau.\n«Souviens-toi, tout a un prix.»"
  },
  Event_7579_Name = {
    Text = "Voix hors du monde"
  },
  Event_7580_ChoiceDesc1 = {
    Text = "[Dispel the Illusion] Symptôme infecté."
  },
  Event_7580_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7580_Desc = {
    Text = "Des visages flous apparaissent soudainement, entourant et gémissant désespérément sans cordes vocales"
  },
  Event_7580_Name = {Text = "Illusion"},
  Event_7581_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7581_Desc = {
    Text = "Tu ignores cette trace et avances.\nComme si elle était en colère, la trace s'élargit et s'allonge à chaque pas, semblant prête à sortir une main de la fissure pour t'entraîner dans les profondeurs"
  },
  Event_7581_Name = {
    Text = "Crevasse rampante"
  },
  Event_7582_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7582_Desc = {
    Text = "Tu ne te laisses pas facilement duper, tu te retournes et pars rapidement"
  },
  Event_7582_Name = {
    Text = "Crevasse rampante"
  },
  Event_7583_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7583_Desc = {
    Text = "Tu remarques l'étrangeté de la fissure, tu t'accroupis pour l'examiner, et soudain, elle cesse de s'étendre, comme morte"
  },
  Event_7583_Name = {
    Text = "Crevasse rampante"
  },
  Event_7584_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7584_Desc = {
    Text = "\"Non, c'est un esprit clair. La détermination ne vous aidera pas à affronter le Corps Dissolu, Gardien. Réfléchissez à votre stratégie.\""
  },
  Event_7584_Name = {
    Text = "Règle de Logan"
  },
  Event_7585_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7585_Desc = {
    Text = "Tu ne peux résister à l'impulsion de ton cœur. \n Tes doigts errent et jouent sur le clavier comme des enfants perdus dans les bois... \n Peu à peu, des papillons s'envolent de la machine à écrire. \n Une, deux, trois... \n Sur le visage, sur les doigts, des papillons en essaims scintillent comme des feux d'artifice dans l'obscurité. \n Cette machine à écrire n'a aucune utilité pratique, mais elle excelle à créer de la beauté."
  },
  Event_7585_Name = {Text = "œil"},
  Event_7586_ChoiceDesc1 = {
    Text = "[Attacher la Poule]"
  },
  Event_7586_Desc = {
    Text = "Spécialité de Lai, des poules bien vivantes, une tentation culinaire"
  },
  Event_7586_Name = {
    Text = "Fabriquer un piège"
  },
  Event_7587_ChoiceDesc1 = {
    Text = "[Mission Accomplished]"
  },
  Event_7587_Desc = {
    Text = "Piège bon marché mais efficace !"
  },
  Event_7587_Name = {
    Text = "Fabriquer un piège"
  },
  Event_7588_ChoiceDesc1 = {
    Text = "[Set a Trap]"
  },
  Event_7588_Desc = {
    Text = "Piège en métal, l'allié du chasseur paresseux"
  },
  Event_7588_Name = {
    Text = "Fabriquer un piège"
  },
  Event_7589_ChoiceDesc1 = {
    Text = "[Check Teletype] Infectez \"(Skill.Arg1)\", obtenez la Relique d'or \"(RelicConfig.Arg2)\""
  },
  Event_7589_ChoiceDesc2 = {
    Text = "[Disregard] Gagnez 50 Sigils Noirs"
  },
  Event_7589_Desc = {
    Text = "Tu te réfugies dans une fissure de la grotte pour échapper à la tempête. Mais tu sais que tu ne peux pas rester longtemps ici, si les hommes en noir te trouvent, tu n'auras nulle part où fuir.\nDans un coin de la fissure, tu trouves un télégraphe"
  },
  Event_7589_Name = {
    Text = "Télégramme silencieux"
  },
  Event_7590_ChoiceDesc1 = {
    Text = "[Check the Film] Upgrade the orison effects of 2 random cards"
  },
  Event_7590_ChoiceDesc2 = {
    Text = "[Vérifier l'appareil photo] choisir 1 parmi 3 cartes de commandement pour obtenir une oraison : [(EnchantConfig.Arg1)]"
  },
  Event_7590_Desc = {
    Text = "Comme si l'on arrachait des entrailles, le film à l'intérieur de l'appareil photo est déchiré et abandonné ici, ouvert et sans personne pour s'en soucier. \n Une lumière blanche éblouissante passe, l'appareil photo abandonné au coin de la rue est incliné, le déclencheur est pressé dans le vide. \n « Clic — » \n Ton expression de choc et de stupéfaction est fidèlement enregistrée sur le film de l'appareil photo."
  },
  Event_7590_Name = {
    Text = "Enregistrer sans culpabilité"
  },
  Event_7591_ChoiceDesc1 = {
    Text = "[Strangle the Singer] Gagnez la relique maudite \"(RelicConfig.Arg1)\", et infligez \"(Skill.Arg2)\"."
  },
  Event_7591_ChoiceDesc2 = {
    Text = "[Faire trébucher le pas du Danseur] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : [(EnchantConfig.Arg1)]"
  },
  Event_7591_ChoiceDesc3 = {
    Text = "[Steal the Poet's Manuscript] Gagnez 50 Sigils Noirs"
  },
  Event_7591_Desc = {
    Text = "Trois silhouettes visqueuses te barrent le chemin. \n L'une chante une chanson, sa voix est rauque, les paroles sont étranges, tu te couvres les oreilles et l'évites. \n Une autre danse, ses mouvements sont rigides, ses pas hésitants, tu fermes les yeux et l'évites. \n Une silhouette déclame un poème, le rythme est brisé, les phrases incohérentes, tu n'en peux plus, alors —"
  },
  Event_7591_Name = {
    Text = "Brigand sur le Chemin Étroit"
  },
  Event_7592_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7592_Desc = {
    Text = "«Non ! Le progrès de l'humanité ne repose pas sur l'histoire, ni sur la technologie, mais sur les rats.»\n«Ce sont les rats qui ont ouvert cette ère de ténèbres, puis l'humanité a vu poindre l'aube de sa renaissance.»\n«L'humanité a besoin de vous — même si tout le monde ne comprend pas cela.»\nLes rats sont un peu confus par ton long discours, mais ils te laissent partir."
  },
  Event_7592_Name = {Text = "Peste"},
  Event_7593_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7593_Desc = {
    Text = "Tu as ignoré les spasmes de ton nerf optique, essayant de discerner...\nIl semble y avoir un cercle magique déchiré.\nÀ l'intérieur, des arcs innombrables, statiques mais en mouvement, hypnotiques"
  },
  Event_7593_Name = {
    Text = "angle d'origine"
  },
  Event_7594_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7594_Desc = {
    Text = "<Bold> Musée de cire Rogers\n44 Southwark Street, quartier de Londinium @2\nHoraires d'ouverture : 21h00 - 6h00\nDernière entrée à 3h00 (fermé le week-end)\n\n<Bold> Exposition actuelle\nVladimir @2 :\nLe philosophe souriant"
  },
  Event_7594_Name = {
    Text = "Rires dans les ténèbres"
  },
  Event_7595_ChoiceDesc1 = {
    Text = "[Eye Contact] Choisir 1 parmi 3 cartes de commande pour gagner une oraison : \"(EnchantConfig.Arg1)\", et infecter \"(Skill.Arg2)\"."
  },
  Event_7595_ChoiceDesc2 = {
    Text = "[Fermer les yeux] Choisissez de réveiller 1 éveillé, infectez[(Skill.Arg1)]"
  },
  Event_7595_ChoiceDesc3 = {
    Text = "[Tournez le Dos] Gagner 25 sigils noirs"
  },
  Event_7595_Desc = {
    Text = "Il ne devrait pas y avoir de ciel étoilé. \n Dans le labyrinthe du Sonanir, le ciel se transforme en lumière éclatante, les étoiles et la lune sont toutes dissimulées. \n Dans la cabine sombre, tu ne devrais pas non plus voir le ciel étoilé. \n Il n'y devrait y avoir que des ampoules à incandescence éparses et des vieilles lanternes — mais pourquoi, ressens-tu quand même le regard suspendu dans le ciel ?"
  },
  Event_7595_Name = {Text = "Épier"},
  Event_7596_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7596_Desc = {
    Text = "Tu choisis de regarder courageusement ces yeux. \n Ils sont des étoiles brillantes, scintillant dans l'obscurité. \n Puis ils se mettent à rire et se transforment en d'innombrables lunes courbées. \n Les yeux disent : « Tu n'as pas peur du regard. Tu ne devrais pas non plus craindre... ça fait longtemps, @2. » \n Avant de disparaître, ils te font un petit cadeau, en souvenir de cette « rencontre à nouveau »."
  },
  Event_7596_Name = {Text = "œil"},
  Event_7597_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7597_Desc = {
    Text = "Le pont ferroviaire, les veines et les nerfs de Londinium, relie le cœur et les membres de la ville. Tant que le soleil ne se sera pas couché ici, le cœur de Londinium battra éternellement avec passion."
  },
  Event_7597_Name = {
    Text = "Illusion du pont d'acier"
  },
  Event_7598_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7598_Desc = {
    Text = "Une fugue d'une beauté inouïe, l'auteur est inconnu.  \nDes voix nombreuses se tissent avec des thèmes similaires, chaque note étant aussi précise et froide qu'un scalpel de chirurgien.  \nPrécis et magnifique - c'est l'esthétique de Rogers.  \nFuga, vole !"
  },
  Event_7598_Name = {
    Text = "mauvais goût"
  },
  Event_7599_ChoiceDesc1 = {
    Text = "[Saluer à voix haute]"
  },
  Event_7599_ChoiceDesc2 = {
    Text = "[Seek Help]"
  },
  Event_7599_Desc = {
    Text = "Au moment où tu te tiens sur le bastingage du bateau, tu aperçois une jeune fille en robe blanche. \n Noble, pure, illusoire... et avec une certaine familiarité. \n Où l'as-tu déjà vue ? Alors que tu t'efforces de fouiller dans tes souvenirs chaotiques, elle semble soudainement réaliser ta présence, te fixant à travers le vide. \n Ses yeux sont calmes comme l'océan au début du printemps, mais tu y lis étrangement quelque chose... \n Elle semble attendre que tu lui dises bonjour, même si ce n'est que pour parler de la météo d'aujourd'hui."
  },
  Event_7599_Name = {
    Text = "Jeune fille en robe blanche"
  },
  Event_7600_ChoiceDesc1 = {
    Text = "[Félicitez-le] choisissez une carte de commandement parmi 3 cartes et obtenez l'oraison :[(EnchantConfig.Arg1)]"
  },
  Event_7600_ChoiceDesc2 = {
    Text = "[se moque de lui] contamine[(Skill.Arg1)], réimprime aléatoirement"
  },
  Event_7600_Desc = {
    Text = "Jenkins dit : Johnny ! Tu es vraiment… très différent d'avant, peu importe sous quel angle on regarde. \n Tu dis : Tu es vraiment un cerveau à la fois assidu et ambitieux. \n Le cerveau a remué et s'est tortillé quelques instants, visiblement très content. \n Le cerveau dit : Allez ! Puisque vous reconnaissez si bien mes réalisations actuelles, je vais vous transmettre tout ce que j'ai appris de ma vie…"
  },
  Event_7600_Name = {
    Text = "Cerveau philosophique"
  },
  Event_7601_ChoiceDesc1 = {
    Text = "[Graceful Fugue] Obtenir la relique d'argent \"(RelicConfig.Arg1)\" et devenir infecté avec \"(Skill.Arg2)\"."
  },
  Event_7601_ChoiceDesc2 = {
    Text = "[Petite sérénade] Tous les Réveillés récupèrent 50 points de folie, infecter[(Skill.Arg1)]"
  },
  Event_7601_ChoiceDesc3 = {
    Text = "[Meaningless Noise] Obtenez une Oraison à 3 choix"
  },
  Event_7601_Desc = {
    Text = "« Je ne suis pas vraiment d'accord avec le goût musical du conservateur, tu sais... \n C'est trop flashy, et je suis quelqu'un de pragmatique. » \n Une voix masculine fatiguée émerge du phonographe grincant, se plaignant dans la solitude. \n « Mais c'est mon travail... Bon, économisons du temps, choisissons-en un. »"
  },
  Event_7601_Name = {
    Text = "mauvais goût"
  },
  Event_7602_ChoiceDesc1 = {
    Text = "[Une relique spéciale, obtenir une relique en or «(RelicConfig.Arg1)»]"
  },
  Event_7602_ChoiceDesc2 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_7602_Desc = {
    Text = "Événement 253 (en développement), effet non final"
  },
  Event_7602_Name = {
    Text = "Événement253 (en développement)"
  },
  Event_7603_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7603_Desc = {
    Text = "Tu fuis aussi vite que possible.\nVous faites face aux monstres les plus tenaces et dégoûtants jamais vus - ces statues de cire innombrables.\nComparées à elles, ces quelques mottes de terre sont insignifiantes.\nPrioriser les urgences - c'est l'un des principes des gardiens du secret"
  },
  Event_7603_Name = {Text = "Étude"},
  Event_7604_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7604_Desc = {
    Text = "La clé en argent scintille, sa lumière argentée remplit l'espace, teintant le fluide épais et coloré en argent pur.\nLa luminosité disparaît instantanément, laissant derrière elle le vent et ses lamentations"
  },
  Event_7604_Name = {
    Text = "Couleurs nostalgiques"
  },
  Event_7605_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7605_Desc = {
    Text = "Ces couleurs irisées te faisaient tourner la tête, et sans t'en rendre compte, tu t'y plongeais"
  },
  Event_7605_Name = {
    Text = "Croisements des Étoiles"
  },
  Event_7606_ChoiceDesc1 = {
    Text = "[Continuer à tomber] Infecter[(Skill.Arg1)], continuer à tomber ?"
  },
  Event_7606_ChoiceDesc2 = {
    Text = "[Éloignez-vous] Gagner 25 Sigils Noirs"
  },
  Event_7606_Desc = {
    Text = "\"Vous\" vous invite.\nDans les profondeurs de la spirale, le passé et le futur \"vous\" vous envoient des \"cadeaux\" provenant de différentes dimensions."
  },
  Event_7606_Name = {
    Text = "Abysses en spirale"
  },
  Event_7607_ChoiceDesc1 = {
    Text = "[Understanding] Obtenez une relique d'or \"(RelicConfig.Arg1)\" et devenez infecté par \"(Skill.Arg2)\"."
  },
  Event_7607_ChoiceDesc2 = {
    Text = "[Ignorance totale] Obtenir 1 sur 3 reliques en or, infecter [(Skill.Arg1) ]"
  },
  Event_7607_ChoiceDesc3 = {
    Text = "[Partir] Obtient une relique d'argent[(RelicConfig.Arg1)]"
  },
  Event_7607_Desc = {
    Text = "Deux silhouettes lumineuses argentées flottent devant tes yeux, se présentant sous une forme liquide épaisse, dérivant dans l'air. \n «C'est ici que je suis mort.» Une silhouette s'est accroupie. \n «Dans le Royaume Divin sans maladie ni malheur, il n'y a pas de désir ni de perte, tu ne sais pas vraiment ce qu'est la disparition.» \n L'autre silhouette soupira, détournant son regard vers toi."
  },
  Event_7607_Name = {
    Text = "Royaume Perdu des Dieux"
  },
  Event_7608_ChoiceDesc1 = {
    Text = "[Leave] Trouver un phare de recherche"
  },
  Event_7608_ChoiceDesc2 = {
    Text = "[Intrusion dans le brouillard] Infectez[(Skill.Arg2)]"
  },
  Event_7608_ChoiceDesc3 = {
    Text = "[Enter Directly]"
  },
  Event_7608_Desc = {
    Text = "Devant se trouve une brume noire épaisse, entrer imprudemment entraînera des clades.\nPeut-être devriez-vous trouver un « projecteur » pour dissiper la brume"
  },
  Event_7608_Name = {Text = "inconnu"},
  Event_7609_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7609_Desc = {
    Text = "\"C'est la projection de mémoire,\" expliqua Ramona, \"Cela peut appartenir à une certaine personne, ou cela peut être un souvenir partagé de plusieurs personnes.\"\nLes souvenirs précieux méritent une protection soigneuse."
  },
  Event_7609_Name = {
    Text = "Nos Souvenirs"
  },
  Event_7610_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7610_Desc = {
    Text = "Même sans pouvoir lire maintenant, tu as plié la lettre et l'as mise dans ta poche pour chercher une autre méthode à l'école.\nMais avec la lettre mystérieusement froissée, ta poitrine commence à te faire mal"
  },
  Event_7610_Name = {
    Text = "Lettre brouillée"
  },
  Event_7611_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7611_Desc = {
    Text = "La bougie s'allume dès qu'elle quitte la balance, ses larmes blanches coulent entre tes doigts, disparaissant rapidement"
  },
  Event_7611_Name = {
    Text = "Raison et Émotion"
  },
  Event_7612_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7612_Desc = {
    Text = "À la hâte, tu arraches le papier de la machine à écrire — mais elle continue de fonctionner. Dans ce moment de panique, une Carte d'instruction tombe dedans et se retrouve couverte de l'encre la plus noire, devenue inutilisable.\nTu prends un moment pour t'en débarrasser avec soin, mais tu ne peux t'empêcher de remarquer le texte sinistre, répété, désormais inscrit dessus ;\n<Bold:NE REGARDE PAS DIRECTEMENT>\n<Bold:NE REGARDE PAS DIRECTEMENT>\n<Bold:NE REGARDE PAS DIRECTEMENT>\n<Bold:NE REGARDE PAS DIRECTEMENT>\n<Bold:NE REGARDE PAS DIRECTEMENT>\n<Bold:NE REGARDE PAS DIRECTEMENT>\n<Bold:NE REGARDE PAS DIRECTEMENT>\n<Bold:NE REGARDE PAS DIRECTEMENT>"
  },
  Event_7612_Name = {
    Text = "Avertissement non sollicité"
  },
  Event_7613_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7613_Desc = {
    Text = "En touchant le bord glacé de la tasse, tu frissonnes et te réveilles.\nQuoi qu'il en soit, elle ne devrait pas être laissée sur le bord de la route. Mieux vaut la mettre dans la valise"
  },
  Event_7613_Name = {
    Text = "Vin doux au miel"
  },
  Event_7614_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7614_Desc = {
    Text = "Tu tousses violemment.\nLe son semble surpris, puis tombe dans un silence mortel.\nTu sens que tu as peut-être manqué un indice important...\nMais la vie est toujours pleine de manques et de regrets, n'est-ce pas ?"
  },
  Event_7614_Name = {
    Text = "Les murs ont des oreilles"
  },
  Event_7615_ChoiceDesc1 = {
    Text = "[Keep Silent] Gagnez 25 Sigils Noirs"
  },
  Event_7615_ChoiceDesc2 = {
    Text = "[Tendez la Main et Touchez] 50% de chance de gagner 50 Sigils Noirs, 50% de chance de rien."
  },
  Event_7615_Desc = {
    Text = "« Je n'ai qu'un seul adage à dire - personne ne peut tuer un chat ! »\n « Ce maudit chat noir aurait dû être éventré et laissé à l'abandon, mais il a déterré la tombe de ma famille, les restes des humains ont été complètement dévorés par lui, et les ossements sont éparpillés ici et là. »\n « Sous le regard froid et sombre des pupilles verticales, un liquide jaune et purulent flotte, dégageant une odeur nauséabonde, je me suis enfui en rampant, torturé par des cauchemars qui m'ont laissé l'esprit épuisé. »\n « Attendez... que comptez-vous faire, je ne suis pas fou ! Je ne le suis pas ! Vous essayez sûrement de couvrir quelque chose ! C'est vrai - »\n C'est effectivement vrai, alors que l'ombre du fou disparaît, tu croises le regard du chat noir qui est assis tranquillement à tes pieds."
  },
  Event_7615_Name = {
    Text = "Malédiction du hibou"
  },
  Event_7616_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7616_Desc = {
    Text = "Alors que tu hésitais, il plongea dans la d-marque, disparaissant rapidement"
  },
  Event_7616_Name = {
    Text = "Objet flottant dans le tonneau"
  },
  Event_7617_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7617_Desc = {
    Text = "Tu froisses la lettre avec agacement et la jettes à tes pieds"
  },
  Event_7617_Name = {
    Text = "Lettre brouillée"
  },
  Event_7618_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_7618_Desc = {
    Text = "Tu te concentres, l'illusion se dissipe comme de l'encre. Tu avances, mais l'ombre dans ton cœur persiste"
  },
  Event_7618_Name = {Text = "Illusion"},
  Event_7619_ChoiceDesc1 = {
    Text = "[Examine Carefully] Obtenez Relique d'argent \"(RelicConfig.Arg1)\", infectez \"(Skill.Arg2)\""
  },
  Event_7619_ChoiceDesc2 = {
    Text = "[Avoid Shadows] Obtenir une Relique en argent \"(RelicConfig.Arg1)\" et infecter \"(Skill.Arg2)\"."
  },
  Event_7619_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_7619_Desc = {
    Text = "Ramona était tendue, se déplaçant prudemment dans l'asile pour éviter les gens.\nElle se cacha dans une petite pièce.\nUne silhouette apparut soudainement à la fenêtre"
  },
  Event_7619_Name = {
    Text = "Reflet dans la fenêtre"
  },
  Event_7620_ChoiceDesc1 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_7620_Desc = {
    Text = "La chose la plus importante maintenant est de traduire en justice le coupable de tout cela. Mais la graine de la colère continue de germer dans ton cœur. Sans attendre votre réponse, l'homme s'éloigna"
  },
  Event_7620_Name = {
    Text = "Empreinte de géant"
  },
  Event_7621_ChoiceDesc1 = {
    Text = "[Partir] Obtient 75 sigils noirs, infection[(Skill.Arg2)]"
  },
  Event_7621_Desc = {
    Text = "L'éducation que vous avez reçue depuis l'enfance dans Mythag a rendu impossible pour vous d'ignorer cette empreinte. Vous avez balayé les empreintes poussiéreuses, et à cet instant, vous sembliez entendre une réponse d'une dimension lointaine, \"Merci\"."
  },
  Event_7621_Name = {
    Text = "Empreinte de géant"
  },
  Event_7622_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7622_Desc = {
    Text = "Tu serres la clé en argent, la douce lumière argentée et les légers frissons te procurent un sentiment de sécurité. Tes yeux semblent avoir disparu, ou peut-être pas, peu importe, ils laissent sur toi une marque invisible qui lui appartient"
  },
  Event_7622_Name = {
    Text = "Qui regarde"
  },
  Event_7623_ChoiceDesc1 = {
    Text = "[Find the Secret Path]"
  },
  Event_7623_Desc = {
    Text = "Vous et Ramona, Lotan, vous vous divisez en trois groupes et commencez à poursuivre le Chien de l'enfer. \n\n Vous courez à travers plusieurs ruelles, une grande silhouette apparaît devant vous. \n En vous voyant arriver, elle tourne immédiatement au prochain coin. \n Vous vous précipitez à sa poursuite, mais devant vous se dresse une impasse, trois murs élevés bloquent un ciel carré étroit."
  },
  Event_7623_Name = {Text = "Impasse"},
  Event_7624_ChoiceDesc1 = {
    Text = "[Walk Past]"
  },
  Event_7624_ChoiceDesc2 = {Text = "[Pat]"},
  Event_7624_Desc = {
    Text = "À côté de la table d'opération propre et douce, le corps affaibli de Koum repose. \n Elle est toujours aussi grande, comme une petite montagne, comme lors de votre première rencontre. \n Cependant, comparée au véritable « chien des enfers » dans les cieux, elle semble si petite, si petite qu'elle ressemble à un enfant."
  },
  Event_7624_Name = {
    Text = "Résidu de chaleur"
  },
  Event_7625_ChoiceDesc1 = {
    Text = "[Obtenez de l'Argent]"
  },
  Event_7625_Desc = {
    Text = "Eh, il y a plein de choses brillantes devant !\nSentons... ça sent bon.\nLéchons... c'est frais !\nÇa a l'air précieux, vite, donnons-le à petit Jenkins, peut-être qu'on obtiendra beaucoup de fromage !"
  },
  Event_7625_Name = {Text = "Brillant"},
  Event_7626_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7626_Desc = {
    Text = "Une déception qui ne t'appartient pas monte en toi, le filet illusoire se dissipe lentement, ouvrant un passage"
  },
  Event_7626_Name = {
    Text = "Réseau errant"
  },
  Event_7627_ChoiceDesc1 = {
    Text = "[Comprenez-le] Réveillez aléatoirement un éveillé, infectez [(Skill.Arg1)]"
  },
  Event_7627_ChoiceDesc2 = {
    Text = "[Ignorez-le] Obtenez une Oraison à 3 choix"
  },
  Event_7627_Desc = {
    Text = "Des runes fluides jaillissent du rugissement de la créature en forme de poisson, remplissant tes oreilles, ton nez, ta gorge. Elles brûlent ton corps, et dans dix secondes, tu comprendras le sens du rugissement"
  },
  Event_7627_Name = {
    Text = "Rune de Frénésie"
  },
  Event_7628_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7628_Desc = {
    Text = "Tu serreras les dents en essayant de résister aux illusions déroutantes. Ramona place un objet froid dans ta paume.\n\"Cette relique que j'ai découverte tout à l'heure pourrait t'aider.\""
  },
  Event_7628_Name = {
    Text = "Illusion dimensionnelle"
  },
  Event_7629_ChoiceDesc1 = {
    Text = "Choisissez une oraison avancée"
  },
  Event_7630_ChoiceDesc1 = {
    Text = "[Immobiliser le corbeau] Choisissez 1 Carte d'instruction parmi 3 pour obtenir une Oraison : «(EnchantConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_7630_ChoiceDesc2 = {
    Text = "[Kill Crow] Obtenez une Oraison à 3 choix"
  },
  Event_7630_ChoiceDesc3 = {Text = "[Leave]"},
  Event_7630_Desc = {
    Text = "Le corbeau solitaire croasse d'une voix rauque, arrachant ses plumes noires une par une.\nIl tremble de douleur, criant de manière incontrôlable alors que ses mouvements frénétiques s'intensifient.\n\"Caw—Caw—\"\nDes larmes bleues mélangées à de la boue noire s'écoulent de ses yeux, témoins uniquement par vous.\n"
  },
  Event_7630_Name = {
    Text = "Larme de lave fondue"
  },
  Event_7631_ChoiceDesc1 = {
    Text = "[Leave] Augmenter la vie maximale de Arg1"
  },
  Event_7631_Desc = {
    Text = "\"Laisse-moi faire,\" tu as doucement pat patte le dos du monstre, comme pour apaiser un chaton en colère, \"Elle va se réveiller. Nous ne lui ferons pas de mal.\""
  },
  Event_7631_Name = {
    Text = "Appel de l'amitié"
  },
  Event_7632_ChoiceDesc1 = {
    Text = "[Leave] Augmente la vie maximale de Arg1, infecte \"(Skill.Arg2)\" et \"(Skill.Arg3)\""
  },
  Event_7632_Desc = {
    Text = "\"Réveille-toi, Lily. Kume espère aussi que tu te réveilleras bientôt—\""
  },
  Event_7632_Name = {
    Text = "Appel de l'amitié"
  },
  Event_7633_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7633_Desc = {Text = "Inutile"},
  Event_7633_Name = {
    Text = "Télégramme silencieux"
  },
  Event_79429_ChoiceDesc1 = {
    Text = "Choisissez un réveilleur et transformez-le en « Zerg » via le rituel de vie. La consommation en arithmétique des cartes de commandement du « Zerg » est réduite de 1, mais elles s'épuisent après avoir été jouées."
  },
  Event_79429_Desc = {
    Text = "« Dans le processus de la prise de conscience de soi, la douleur est toujours présente, la métamorphose et la renaissance le sont aussi. » \n Elle sourit doucement, caressant tendrement ton visage. \n « N'aie pas peur, je suis ici avec toi, alors ouvre-toi à ton esprit et à tout, accepte-les. » \n « Bon enfant, j'attends ta renaissance, j'attends que tu... deviennes l'un des nôtres. »"
  },
  Event_79429_Name = {
    Text = "La métamorphose de la vie"
  },
  Event_80463_ChoiceDesc1 = {
    Text = "[Partir] Obtient 3 choix 1 relique d'argent, infection[(Skill.Arg1)]"
  },
  Event_80463_Desc = {
    Text = "Tu choisis ta route et tires petit William en courant à perdre haleine. \nHeureusement, ton choix était le bon. \nTu as enfin réussi à semer ces contaminations mentales, ces clones de Clémentine. \nBien sûr, tu as dû payer un certain prix."
  },
  Event_80463_Name = {
    Text = "Les « Clémentines »"
  },
  Event_80464_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80464_Desc = {
    Text = "Un souvenir qui dépasse la compréhension est implanté dans ton cerveau, brisant directement ta raison. \nDans ces images qui défilent à toute vitesse, tu te souviens seulement d'une scène : un temple en forme de triangle \nC'est l'œuvre grandiose et insensée des @2Zerg pour le @4."
  },
  Event_80464_Name = {
    Text = "Mémoire Profonde"
  },
  Event_80465_ChoiceDesc1 = {
    Text = "[Partir] Choisir de réveiller un Réveillé, infecter[(Skill.Arg1)]"
  },
  Event_80465_Desc = {
    Text = "Tu choisis ta route et tires petit William en courant à perdre haleine. \nHeureusement, ton choix était le bon. \nTu as enfin réussi à semer ces contaminations mentales, ces clones de Clémentine. \nBien sûr, tu as dû payer un certain prix."
  },
  Event_80465_Name = {
    Text = "Les « Clémentines »"
  },
  Event_80466_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80466_Desc = {
    Text = "« Clac. Clac. Clac » \n La « tâche » est enfin accomplie, mais en dehors de la tâche elle-même, qu'as-tu obtenu ?"
  },
  Event_80466_Name = {
    Text = "Torture éternelle"
  },
  Event_80467_ChoiceDesc1 = {
    Text = "[Leave] Obtenir 1 parmi 3 Oraisons"
  },
  Event_80467_Desc = {
    Text = "« Je suis heureux d'entendre ta réponse sincère. »  \n« J'attends avec impatience notre prochaine rencontre. »"
  },
  Event_80467_Name = {
    Text = "Appel dans le rêve"
  },
  Event_80468_ChoiceDesc1 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_80468_Desc = {
    Text = "« Ah, quel enfant peu sincère. »\n« Mais ce n'est pas grave, la prochaine fois, je te ferai dire toute la vérité. »\n« Toute la vérité venue du cœur et de l'âme. »"
  },
  Event_80468_Name = {
    Text = "Appel dans le rêve"
  },
  Event_80469_ChoiceDesc1 = {
    Text = "[Commencer « travail »] Supprimez 1 carte d'instruction, obtenez Arg1 marque noire"
  },
  Event_80469_ChoiceDesc2 = {
    Text = "<Reculez et éloignez-vous>"
  },
  Event_80469_Desc = {
    Text = "« Clic. » \nLe bruit de la machine à écrire retentit : tu es et resteras son esclave jusqu'à ce que la « tâche » soit accomplie."
  },
  Event_80469_Name = {
    Text = "Torture éternelle"
  },
  Event_80470_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80470_Desc = {
    Text = "« C'est vraiment dommage, ta prudence t'a fait manquer l'unique opportunité de découvrir la vérité. »\nIl pousse un soupir et se dissout silencieusement."
  },
  Event_80470_Name = {
    Text = "Mémoire Profonde"
  },
  Event_80471_ChoiceDesc1 = {
    Text = "[Attaque totale]"
  },
  Event_80471_ChoiceDesc2 = {
    Text = "<Yellow:Combat et retraite>"
  },
  Event_80471_Desc = {
    Text = "Une silhouette inattendue apparaît devant toi, c'est Clémentine. \n « Ne sois pas surpris, je veux juste faire un test spécial. » \n « Quant à ce que je teste, c'est un secret. » Clémentine sourit, « Pour toi, le seul contenu du test — » \n « c'est de survivre. »"
  },
  Event_80471_Name = {
    Text = "Test spécial"
  },
  Event_80472_ChoiceDesc1 = {
    Text = "[Rappelez-vous le passé]"
  },
  Event_80472_ChoiceDesc2 = {
    Text = "<Del:Arracher les écailles>"
  },
  Event_80472_Desc = {
    Text = "« Je te prie de croire que je n'ai aucune malice, je veux juste t'aider. »\nClémentine te poursuit en criant. \nSa voix semble incroyablement sincère, mais tu ne peux plus croire en rien. \nTa moralité a été percée par la « théorie de la cognition incarnée », et ta raison est sur le point de s'effondrer. \nTu dois, tu dois faire quelque chose pour résister aux écailles d'insecte qui poussent dans ta chair, résister à la folie et au désespoir qui s'immiscent peu à peu dans ton âme."
  },
  Event_80472_Name = {
    Text = "Âme luttant"
  },
  Event_80473_ChoiceDesc1 = {
    Text = "[Leave] Supprimer 2 Cartes"
  },
  Event_80473_Desc = {
    Text = "« Veux-tu conserver ta puissance pour la bataille finale ? » \n« C’est un choix très judicieux. Mais en obtenant quelque chose, on perd aussi quelque chose en retour. » \n« Car dans ce monde cruel et en feu, survivre exige toujours un prix à payer. »"
  },
  Event_80473_Name = {
    Text = "Test spécial"
  },
  Event_80474_ChoiceDesc1 = {
    Text = "[Ignorez-le] Obtenez une Oraison à 3 choix"
  },
  Event_80474_ChoiceDesc2 = {
    Text = "[Le toucher] 1 Carte d'instruction aléatoire obtient l'Oraison : «(EnchantConfig.Arg1)», infectée par «(Skill.Arg2)»"
  },
  Event_80474_Desc = {
    Text = "Une chose étrange, ressemblant à une spore, attire ton attention. \n Elle ressemble à une méduse fine composée de chair et de sang, ou à une fibre nerveuse profonde du cerveau portant un signal. \n « Touche-moi », te tente-t-elle silencieusement, « je vais te montrer un souvenir cruel. »"
  },
  Event_80474_Name = {
    Text = "Mémoire Profonde"
  },
  Event_80475_ChoiceDesc1 = {
    Text = "[Leave] Obtenir 1 parmi 3 Oraisons"
  },
  Event_80475_Desc = {
    Text = "« Ramona, Doll, Lotan, Ogier… »\nTu murmures nerveusement ces noms sans cesse.\nTa raison en pleine crise ne peut plus se souvenir de leurs visages, mais l'existence représentée par ces noms peut encore réchauffer ton cœur et ton âme.\nIls ont existé, ils ont ri, ils… sont la ligne de fond et le point d'ancrage qui te permettent de maintenir ton humanité en ce moment."
  },
  Event_80475_Name = {
    Text = "Âme luttant"
  },
  Event_80476_ChoiceDesc1 = {
    Text = "[Partir] Obtient 3 choix 1 relique d'argent, infection[(Skill.Arg1)]"
  },
  Event_80476_Desc = {
    Text = "« Aaaah — » \nTu ouvres la bouche et pousses un cri perçant, un son qui ressemble davantage à un hurlement strident qu'à un simple cri. \nLes écailles d'insecte arrachées repoussent déjà, tandis que la raison, une fois perdue, ne revient plus."
  },
  Event_80476_Name = {
    Text = "Âme luttant"
  },
  Event_80477_ChoiceDesc1 = {
    Text = "[Leave] Obtiens la Relique \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_80477_Desc = {
    Text = "Tu n'as rien caché et tu t'es donné à fond. Cette attitude a manifestement plu à Clémentine. \n « Vraiment un bon enfant. » \n « Dans ce cas, je vais te récompenser un peu. Bien sûr, cela a un prix. » \n « Dans ce monde cruel et en feu, survivre exige toujours un prix à payer. »"
  },
  Event_80477_Name = {
    Text = "Test spécial"
  },
  Event_80478_ChoiceDesc1 = {
    Text = "[Commencer « travail »] Supprimez 1 carte d'instruction, obtenez Arg1 marque noire"
  },
  Event_80478_ChoiceDesc2 = {
    Text = "<Reculez et éloignez-vous>"
  },
  Event_80478_Desc = {
    Text = "« Clac. Clac. » \nLe bruit de la machine à écrire retentit : pendant que la « tâche » est en cours, tu n'es qu'un outil pour accomplir cette « tâche »."
  },
  Event_80478_Name = {
    Text = "Torture éternelle"
  },
  Event_80479_ChoiceDesc1 = {
    Text = "[Run to the Left]"
  },
  Event_80479_ChoiceDesc2 = {
    Text = "[Run to the Right]"
  },
  Event_80479_Desc = {
    Text = "Une silhouette familière te suit de près, pas une ni deux, mais des dizaines, des centaines. \nLe couloir étroit ne peut pas supporter autant de « Clémentine », donc certaines « Clémentine » sont poussées au sol, d'autres sont piétinées. \nMais elles t'appellent toutes en chœur, répétant cette phrase qui te plonge dans la pollution mentale. \n« Pourquoi fuir ? Je veux simplement te proposer une séance de thérapie psychologique. » \nEt toi, tu cours dans le couloir du sanatorium, face à un choix de chemin."
  },
  Event_80479_Name = {
    Text = "Les « Clémentines »"
  },
  Event_80480_ChoiceDesc1 = {
    Text = "[Commencer « travail »] Supprimez 1 carte d'instruction, obtenez Arg1 marque noire"
  },
  Event_80480_ChoiceDesc2 = {
    Text = "<Reculez et éloignez-vous>"
  },
  Event_80480_Desc = {
    Text = "« Modifie ! Travaille ! Ne t'arrête pas ! » \n D'innombrables bourdonnements résonnent dans tes oreilles, te poussant involontairement vers cette machine à écrire soudainement apparue. \n « Que faire, que faire, j'ai tapé du matin au soir, mais le travail ne semble jamais se terminer. » \n « Modifie ! Modifie ! Modifie le plan, présente des demandes, achève le travail ! » \n « Travail ! Travail !! Travail !!! » \n L'âme bourdonnante heurte la machine à écrire qui frappe sans relâche, et enfin, cette machine à écrire s'arrête. \n Cependant, un instant plus tard, la machine à écrire recommence à fonctionner \n « Modifie ! Travaille ! Ne t'arrête pas ! » \n Car le travail n'a jamais de fin."
  },
  Event_80480_Name = {
    Text = "Torture éternelle"
  },
  Event_80481_ChoiceDesc1 = {
    Text = "[Answer honestly]"
  },
  Event_80481_ChoiceDesc2 = {
    Text = "[Refuse to answer]"
  },
  Event_80481_Desc = {
    Text = "En un instant, le paysage devant toi devient flou et illusoire. \n Tu pensais que la pièce se déformait, mais plus tard, tu réalises que c'était ton nerf optique qui avait été envahi. \n « Nous nous revoyons. » \n Dans cette vision floue, Clémentine sourit doucement. \n « Bien que nous nous soyons rencontrés plus tôt que prévu, je suis toujours très heureuse. Je me demande si %player% tu ressens la même chose ? »"
  },
  Event_80481_Name = {
    Text = "Appel dans le rêve"
  },
  Event_80595_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80595_Desc = {
    Text = "\nFace à ton geste pour le chasser, le papillon reste indifférent.\nIl poursuit obstinément ta main et perd la vie au creux de ta paume.\n« Ah, si chaud… »\nCe sont ses dernières pensées."
  },
  Event_80595_Name = {
    Text = "Rêve de papillon"
  },
  Event_80596_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80596_Desc = {
    Text = "« Je souhaite que les fleurs restent toujours en pleine floraison, je souhaite que les sourires durent éternellement. »\n« Je souhaite que tous ceux atteints de fusion puissent guérir et être en sécurité, je souhaite que ce monde retrouve son passé, qu'il ne brûle plus. »\n« Je souhaite... »\nLe petit papillon bat des ailes, s'effaçant lentement dans le creux de ta paume.\nAu moins, quelqu'un a écouté sa voix."
  },
  Event_80596_Name = {
    Text = "Rêve de papillon"
  },
  Event_80597_ChoiceDesc1 = {
    Text = "[Chasser le Papillon] 1 Carte d'instruction aléatoire obtient l'Oraison : «(EnchantConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_80597_ChoiceDesc2 = {
    Text = "[Écouter le vœu]Choisissez 1 carte d'instruction parmi 3 pour obtenir une oraison :«(EnchantConfig.Arg1)»"
  },
  Event_80597_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_80597_Desc = {
    Text = "Le petit papillon porte de nombreux rêves.\nCes rêves sont éparpillés dans la mer de fleurs, dans les chambres d'hôpital, et sur l'autel rempli de chair et de sang de @2.\nEnfin, il a attendu la personne qui le lie, ne sais-tu pas si tu es prêt à écouter son petit, petit vœu."
  },
  Event_80597_Name = {
    Text = "Rêve de papillon"
  },
  Event_80610_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80610_Desc = {
    Text = "« Rationnel ? Une réponse intéressante. » \n« J'espère que tu ne regretteras pas ton choix. »"
  },
  Event_80610_Name = {
    Text = "Le prix de l'humanité"
  },
  Event_80612_ChoiceDesc1 = {
    Text = "[Feed them] Gagner une relique d'argent '(RelicConfig.Arg1)', choisir d'infecter 1 fois le symptôme"
  },
  Event_80612_ChoiceDesc2 = {
    Text = "[Do Not Mind] Choisissez 1 carte parmi 3 cartes de Commandement pour obtenir une Oraison : \"(EnchantConfig.Arg1)\", Infectez \"(Skill.Arg2)\""
  },
  Event_80612_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_80612_Desc = {
    Text = "Les résidents vont et viennent, mais la horde de rats persiste depuis longtemps. \n Par rapport aux humains, ils sont les « indigènes » de ce château. \n Cependant, ils n'ont aucune objection à l'installation des humains. \n Car ces créatures moelleuses et blanches leur offrent également des choses moelleuses et blanches. \n « Et toi, créature, à quel type appartiens-tu ? »"
  },
  Event_80612_Name = {
    Text = "Le secret de l'ancien château"
  },
  Event_80613_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80613_Desc = {
    Text = "\nUn rire doux résonne dans l'obscurité. \n« Je t'attends, viens me voir. » \n« Petite bête courageuse. »"
  },
  Event_80613_Name = {
    Text = "« Elle » épier"
  },
  Event_80614_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80614_Desc = {
    Text = "« Tais-toi, tais-toi, c'est vraiment désagréable. » \n Le chat noir se couvre les oreilles de manière anthropomorphique. \n « Humain, ta langue de chat est vraiment mauvaise, tu dis des choses complètement incohérentes ! » \n Bien qu'il dise cela, l'expression du chat noir s'apaise. \n « Pour te récompenser de tes miaulements qui m'ont plu, je vais te faire un cadeau. » \n « Quant au contenu du cadeau, cela dépend de ta chance. »"
  },
  Event_80614_Name = {Text = "Nigerman"},
  Event_80615_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80615_Desc = {
    Text = "\n« Mère, après avoir perdu des amis, mon mari et mon fils, j'ai encore perdu pour toujours Diana, ma petite fille. »\n« Lorsque elle s'est transformée en cendres devant moi, mon esprit était vide… » Les mots suivants sont illisibles. \nTu ne peux que lire la ligne suivante. \nJ'ai pris ma décision. Si tu me revois, ne me blâme pas, je… vous ai tellement manqués."
  },
  Event_80615_Name = {
    Text = "Souvenir Disparu"
  },
  Event_80616_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80616_Desc = {
    Text = "Votre chasse a produit un effet. Quelques corps aux formes indiscernables se tordent en s'enfuyant, tandis que la plupart restent sur place. \n Ils ne rient plus, ne chantent plus, mais pleurent à chaudes larmes. \n Les cris des enfants résonnent à vos oreilles, répétant inlassablement une phrase. \n « Tuez le monstre ! »"
  },
  Event_80616_Name = {
    Text = "L'enfance de « lui »"
  },
  Event_80617_ChoiceDesc1 = {
    Text = "[Partir] Infection[(Skill.Arg1)]"
  },
  Event_80617_ChoiceDesc2 = {
    Text = "[Partir] Infection[(Skill.Arg1)]"
  },
  Event_80617_ChoiceDesc3 = {
    Text = "[Partir] Infection[(Skill.Arg1)]"
  },
  Event_80617_Desc = {
    Text = "Ta distribution de nourriture a enchanté la horde de rats. \n La vaste horde grouillante t'offre un cadeau emballé grossièrement. \n Tu ne parviens pas à distinguer la forme du cadeau, seul un flot de sang imbibant l'emballage attire ton regard."
  },
  Event_80617_Name = {
    Text = "Le secret de l'ancien château"
  },
  Event_80618_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80618_Desc = {
    Text = "«...»\n«.....»\n«.........»\nL'ombre reste silencieuse. Il voudrait pleurer, mais a déjà perdu la capacité de verser des larmes.\nFinalement, il pousse simplement un profond soupir.\n«Ami, j'espère que tu pourras protéger ce que tu as de plus précieux.»"
  },
  Event_80618_Name = {
    Text = "Homme creux"
  },
  Event_80619_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80619_Desc = {
    Text = "Tes reproches sont sans effet, au contraire, ils les rendent encore plus enthousiastes. \n Les rires et les chants s'élèvent de plus en plus, chantant une autre comptine \n « Petit William, habite dans le château, rats mangeurs d'hommes, courent dans les murs. \n Quand vient le temps du Sacrifice humain, tout le monde est dévoré, l'un après l'autre. »"
  },
  Event_80619_Name = {
    Text = "L'enfance de « lui »"
  },
  Event_80620_ChoiceDesc1 = {
    Text = "[Avoid Gaze] Rassembler aléatoirement 1 Réveil"
  },
  Event_80620_ChoiceDesc2 = {
    Text = "[Regard Fixe] Choisissez de réveiller un réveilleur et réduisez son coût en arithmetica de l'oraison de 2 points. Infectez [(Skill.Arg1)]"
  },
  Event_80620_ChoiceDesc3 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_80620_Desc = {
    Text = "Tout ce qui se passe dans le sanatorium est sous son contrôle et sa surveillance. Toi aussi, bien sûr. \n Mais elle est prête à fermer les yeux pour toi. \n Après tout, un jeu est bien plus amusant quand il y a un échange."
  },
  Event_80620_Name = {
    Text = "« Elle » épier"
  },
  Event_80621_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80621_Desc = {
    Text = "Tu remets l'enveloppe à sa place, prêt à partir, mais tu entends soudain un murmure indistinct. \n « À ma demande, le médecin Clémentine a enfin cédé. \n Dans cet univers vaste et mystérieux qu'elle m'a décrit, il doit y avoir un moyen de vous sauver. \n Je suis prêt pour le « Nouveau-né », peu importe combien d'années-lumière il me faudra dériver, je désire vous revoir. »"
  },
  Event_80621_Name = {
    Text = "Souvenir Disparu"
  },
  Event_80622_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80622_Desc = {
    Text = "Le docteur Clémentine m'a sauvé. \n C'est vraiment une personne très, très gentille, prête à écouter ma voix. \n Je veux vraiment dire des choses heureuses, des choses joyeuses, mais en ce moment, à part la douleur et le désespoir, je n'ai rien d'autre. \n J'ai peur de décevoir la bonne volonté du médecin. \n Après vous avoir perdus, la vie n'est plus que désolation pour moi."
  },
  Event_80622_Name = {
    Text = "Souvenir Disparu"
  },
  Event_80623_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80623_Desc = {
    Text = "« Toi, toi... »  \n« Hmph, pas mal d'ailleurs, cette fois-ci, tu as réussi. La prochaine fois, ce ne sera pas aussi facile ! »  \nLe chat noir saute et s'éloigne habilement.\n\n."
  },
  Event_80623_Name = {Text = "Nigerman"},
  Event_80624_ChoiceDesc1 = {
    Text = "[Attack the black cat] 50 % de chances de gagner 125 Le sigil noir, 50 % de chances d'infecter '(Skill.Arg2)'"
  },
  Event_80624_ChoiceDesc2 = {
    Text = "[Meow like a cat] 75% de chance de gagner 100 Le sigil noir, 25% de chance d'infecter '(Skill.Arg2)'"
  },
  Event_80624_ChoiceDesc3 = {
    Text = "[Tenter de caresser un chat] Obtenez 50 marques noires"
  },
  Event_80624_Desc = {
    Text = "« Hé ! Toi, tu es interdit d'avancer. »\nLes chats noirs surgissent soudainement, bloquant ton chemin. \nIls lèchent gracieusement leurs pattes, avec une attitude hautaine et fière. \n« Devant toi, il y a plein de dangers, ce n'est pas un humain faible comme toi qui peut explorer cela. »\nTu exprimes ta détermination à avancer, à ce moment-là, les pupilles verticales du chat noir en tête se mettent à tourner, révélant sa nature cruelle de jouer avec sa proie. « Alors montre-nous ta détermination. »"
  },
  Event_80624_Name = {Text = "Nigerman"},
  Event_80625_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80625_Desc = {
    Text = "\nTon indifférence a mis la horde de rats en colère. Ils se précipitent vers toi en couinant, mais toi, bien avant que la horde ne se rue, tu t'étais déjà éloigné.\n\n"
  },
  Event_80625_Name = {
    Text = "Le secret de l'ancien château"
  },
  Event_80626_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80626_Desc = {
    Text = "« Ah, c'est ça, brisez mes ailes. »\n« Temps, santé, dignité, vie, ils m'ont déjà pris trop de choses. »\n« Ce dernier rêve, bien sûr, ne m'appartient pas non plus. »\n« Parce que je ne suis qu'un oiseau enfermé, privé de liberté. »"
  },
  Event_80626_Name = {
    Text = "Homme creux"
  },
  Event_80627_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80627_Desc = {
    Text = "« Émotif ? Une réponse intéressante. » \n « J'espère que tu ne regretteras pas ton choix. »"
  },
  Event_80627_Name = {
    Text = "Le prix de l'humanité"
  },
  Event_80628_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80628_Desc = {
    Text = "« J'accepte ta prière. » \nLe bourdonnement s'approche, pénétrant lentement dans ton cerveau par le conduit auditif. \nTon cerveau frémit, et dans ce frémissement, tu entends la « voix » de l'univers. \n« Lie-toi à moi. »"
  },
  Event_80628_Name = {
    Text = "Rédemption des Ténèbres"
  },
  Event_80629_ChoiceDesc1 = {
    Text = "[Pray] Réveillez aléatoirement 1 Réveilleur, infectez '(Skill.Arg1)'"
  },
  Event_80629_ChoiceDesc2 = {
    Text = "[Refuse] Gagnez 1 parmi 3 Oraisons"
  },
  Event_80629_Desc = {
    Text = "« Cela ne devrait pas être ainsi, cela ne devrait pas être ainsi. »\n« Je devrais, je devrais clairement me libérer de cette vie inférieure qu'est l'humanité et évoluer vers quelque chose de plus avancé... »\nDans l'obscurité, des sanglots douloureux se font entendre. \nCes sanglots se rassemblent, surgissent, formant un immense bourdonnement. \n« Ce monde enflammé, tel un trou noir insatiable, dévore chaque personne, donc — »\n« Priez pour moi, l'univers infini vous accordera la rédemption. »"
  },
  Event_80629_Name = {
    Text = "Rédemption des Ténèbres"
  },
  Event_80630_ChoiceDesc1 = {
    Text = "[Ouvrir l'enveloppe] Gagnez une relique en or '(RelicConfig.Arg1)', infectez '(Skill.Arg2)'"
  },
  Event_80630_ChoiceDesc2 = {
    Text = "[Lire] choisir 1 carte parmi 3 pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_80630_ChoiceDesc3 = {
    Text = "[Lâcher]Obtient 50 marques noires"
  },
  Event_80630_Desc = {
    Text = "Dans un coin négligé, une lettre a été oubliée. \n Les caractères sur la lettre sont presque effacés, mais un mot transperce le papier avec intensité. \n Ce mot est « Mère »."
  },
  Event_80630_Name = {
    Text = "Souvenir Disparu"
  },
  Event_80631_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80631_Desc = {
    Text = "« Hmph, humain insignifiant, tu as fait le mauvais choix. » \nLes chats noirs te fixent froidement et t'attaquent soudainement. \n« Tu dois payer le prix – bien sûr, nous respectons aussi les forts. »"
  },
  Event_80631_Name = {Text = "Nigerman"},
  Event_80632_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80632_Desc = {
    Text = "\nUn rire doux résonne dans l'obscurité.\n« Je t'attends, viens me voir. »\n« Petite bête mignonne. »"
  },
  Event_80632_Name = {
    Text = "« Elle » épier"
  },
  Event_80633_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80633_Desc = {
    Text = "Sous votre attaque, ce groupe de silhouettes tordues et étranges s'enfuit enfin. \n Tout est calme autour de vous, seul votre cœur bat en silence. \n Ainsi, c'est l'enfance de « lui »."
  },
  Event_80633_Name = {
    Text = "L'enfance de « lui »"
  },
  Event_80635_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80635_Desc = {
    Text = "« Ah, le petit piège a été percé à jour. »\n« Ceci est une récompense. Parce que… »\n« Chaque choix n’implique pas forcément un choix. »"
  },
  Event_80635_Name = {
    Text = "Le prix de l'humanité"
  },
  Event_80636_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80636_Desc = {
    Text = "« @3 Rebelles » \n Le bourdonnement s'affaiblit progressivement jusqu'à disparaître. Seules les dernières paroles restèrent. \n « Maintenir son humanité ne permet pas de survivre dans ce monde cruel. »"
  },
  Event_80636_Name = {
    Text = "Rédemption des Ténèbres"
  },
  Event_80637_ChoiceDesc1 = {
    Text = "[Choose to refuse] Supprimer 1 carte de commandement, gagner Arg1 Le sigil noir"
  },
  Event_80637_ChoiceDesc2 = {
    Text = "[Choose to comply] Copiez 1 Carte de Commandement, infectez '(Skill.Arg1)'"
  },
  Event_80637_ChoiceDesc3 = {
    Text = "[Choose to embrace] Choisir 1 parmi 3 cartes de commandement pour obtenir l'Oraison : '(EnchantConfig.Arg1)'"
  },
  Event_80637_Desc = {
    Text = "« Je suis un oiseau en cage, enfermé dans une cour pleine de nombreuses pièces. »\n Des silhouettes floues errent dans l'obscurité, ce sont les obsessions laissées par les défunts. \n « Ils disent que c'est un asile, mais je sais que c'est une cage spéciale pour les humains, emprisonnant les oiseaux libres qui ne veulent pas se conformer aux règles de la société. »\n « Mais un oiseau qui ne peut pas voler peut-il encore être appelé un oiseau ? »\n Les obsessions se rapprochent de toi, priant pour la rédemption. \n « S'il vous plaît, brisez mes ailes, j'en ai assez de voler. »"
  },
  Event_80637_Name = {
    Text = "Homme creux"
  },
  Event_80638_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80638_Desc = {
    Text = "«...»\n«.....»\n«.........»\nL'ombre frémit soudain et se fond en toi.\n«Ami, avance pour protéger ce que tu as de plus précieux.»\n«Bien que nous soyons déjà partis, nous voulons encore t'offrir notre dernier vœu pour ton rêve.»"
  },
  Event_80638_Name = {
    Text = "Homme creux"
  },
  Event_80639_ChoiceDesc1 = {
    Text = "[Choisir l'émotion] Récupérez Arg1 points de vie"
  },
  Event_80639_ChoiceDesc2 = {
    Text = "[Maintenir la raison]Tirez au hasard 1 carte de commandement pour obtenir une oraison :«(EnchantConfig.Arg1)»"
  },
  Event_80639_ChoiceDesc3 = {
    Text = "[Refuser de choisir] Obtenez 25 sigils noirs"
  },
  Event_80639_Desc = {
    Text = "« Choisis, choisis. »\nDans l'obscurité qui court, des murmures innombrables se font entendre.\nCette voix est douce et hypnotique, semblant porter une magie infinie, te plongeant dans une sorte d'illusion délirante.\nTon cerveau s'enfonce dans la folie, se tortillant hors de ton corps, tandis que ton cœur semble développer une certaine conscience, te criant d'un appel.\n« Choisis, choisis. »\n« Rester rationnel ou émotionnel, tu dois faire un choix. »"
  },
  Event_80639_Name = {
    Text = "Le prix de l'humanité"
  },
  Event_80641_ChoiceDesc1 = {
    Text = "[Scold 'them'] Infectez '(Skill.Arg1)', obtenez la relique maudite '(RelicConfig.Arg2)'"
  },
  Event_80641_ChoiceDesc2 = {
    Text = "[Drive 'them' away] Infectez deux fois '(Skill.Arg1)', gagnez Relique d'argent '(RelicConfig.Arg2)' et '(RelicConfig.Arg3)'"
  },
  Event_80641_ChoiceDesc3 = {
    Text = "[Attack 'them'] Gagnez une relíquité d'argent '(RelicConfig.Arg1)'"
  },
  Event_80641_Desc = {
    Text = "«Petit William, c'est un monstre, il dort dans un cimetière, personne ne l'aime. Ne t'approche pas de lui, fais attention à ne pas être blessé par lui en secret.»\nUn corps dont on ne peut distinguer les traits se tord, mais la voix est celle d'un enfant.\nIls rient et chantent, te regardant avec un regard à la fois méprisant et ardent.\nAvec malice."
  },
  Event_80641_Name = {
    Text = "L'enfance de « lui »"
  },
  Event_90571_ChoiceDesc1 = {
    Text = "[Dégustez-le] Placez 1 carte [ Cocktail spécial de la nuit des esprits ] dans la bibliothèque."
  },
  Event_90571_Desc = {
    Text = "Une table somptueuse, une piste de danse animée, une vaisselle raffinée, des corps parfumés…\nOh, je sais que vous êtes déjà impatient, mais veuillez patienter encore un peu, cher invité.\nCe verre de boisson spécialement concocté par le maître de la fête est un cadeau réservé aux invités de marque.\nSaisissez-le. Sirotez-le. Dans son arrière-goût, profitez pleinement de ce plaisir !"
  },
  Event_90571_Name = {
    Text = "Rituel pré-festif"
  },
  Event_91460_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91460_Desc = {
    Text = "Tu ne peux pas résister, laissant le son te traverser. \n Un cri strident ouvre ton cerveau, laissant s'écouler des peurs oubliées, et tu sens sa faim. \n Une créature cannibale terrifiante..."
  },
  Event_91460_Name = {
    Text = "Confession silencieuse"
  },
  Event_91461_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91461_Desc = {
    Text = "Tu ne te retiens plus, laissant cette chaleur intense s'exprimer librement, toutes les paroles non prononcées jaillissent constamment de ton crâne.\nTu ressens une inspiration merveilleuse, plongeant dans le génie de Pickman."
  },
  Event_91461_Name = {
    Text = "Volcan endormi"
  },
  Event_91462_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91462_Desc = {
    Text = "La langue de feu s'enroule autour de l'encre, laissant une traînée de sang. \n À ce moment-là, vous tombez à la frontière entre le rêve et la réalité. Vous vous voyez devenir une petite fille, tenant la main de Doresain pour danser avec lui. \n Quand vous vous réveillez et regardez à nouveau Doresain, un profond chagrin envahit votre esprit."
  },
  Event_91462_Name = {
    Text = "Révélation du rêve"
  },
  Event_91463_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91463_Desc = {
    Text = "Tu t'élances, la flamme disparaît sous ta peau. Quant au tableau, personne ne le verrait autrement qu'un portrait ordinaire. \n Dans tes rêves suivants, tu verras toujours ton image brûlante, rôtie à point, puis un jour, servie sur ta propre table."
  },
  Event_91463_Name = {
    Text = "Portrait Brûlant"
  },
  Event_91464_ChoiceDesc1 = {
    Text = "[Écouter] Obtenez 30 sigils noirs, infection [(Skill.Arg2)], continuez à choisir"
  },
  Event_91464_ChoiceDesc2 = {
    Text = "[Ignorez] Partez"
  },
  Event_91464_Desc = {
    Text = "Dans le bruit silencieux, tu comprends peu à peu le langage des corbeaux..."
  },
  Event_91464_Name = {
    Text = "Confession silencieuse"
  },
  Event_91465_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91465_Desc = {
    Text = "Vous ramassez un caillou et réveillez les ombres de rats affairées à ronger. \n Elles vous fixent avec avidité. \n Vous sentez l'odeur humide et impure qui émane d'elles, comme un présage.\n\n."
  },
  Event_91465_Name = {
    Text = "Royaume Exilé"
  },
  Event_91466_ChoiceDesc1 = {
    Text = "[Écouter] Obtenez 25 sigils noirs, infection [(Skill.Arg2)], continuez à choisir"
  },
  Event_91466_ChoiceDesc2 = {
    Text = "[Ignorez] Partez"
  },
  Event_91466_Desc = {
    Text = "Il fait la fête. Qui accueille-t-il ? \nToi, bien sûr ! \nPeut-être te considère-t-il comme son festin de demain."
  },
  Event_91466_Name = {
    Text = "Confession silencieuse"
  },
  Event_91467_ChoiceDesc1 = {
    Text = "[Se trancher la paume] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infectée par «(Skill.Arg2)»"
  },
  Event_91467_ChoiceDesc2 = {
    Text = "[Accept Growth]acquérir la relique d'argent \"(RelicConfig.Arg1)\", infecter \"(Skill.Arg2)\""
  },
  Event_91467_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_91467_Desc = {
    Text = "Le papillon ne vient pas, il pousse lentement depuis ta paume. \n Au début, tu pensais que c'était juste de la sueur, mais tu vois entre tes doigts un liquide noir s'écouler silencieusement comme un reflux veineux, se solidifiant en ailes froides et pulsantes. \n À chaque battement, il crée des ondulations dans ton sang."
  },
  Event_91467_Name = {
    Text = "Parasite de l'élite"
  },
  Event_91468_ChoiceDesc1 = {
    Text = "[Sauver le portrait] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_91468_ChoiceDesc2 = {
    Text = "[Accepter le vide] Choisissez 1 Carte d'instruction parmi 3 pour obtenir l'Oraison : «(EnchantConfig.Arg1)», infecter «(Skill.Arg2)»"
  },
  Event_91468_ChoiceDesc3 = {
    Text = "[Partir] Obtient 25 sigils noirs"
  },
  Event_91468_Desc = {
    Text = "Tu te tiens devant le don de Pickman. \n C'est un portrait, peint avec du sang, des flammes noires brûlent silencieusement. \n À travers les orbites vides du personnage du tableau, tu vois — \n tes souvenirs tourbillonnent et brûlent, s'étirant, se distordant, scintillant, comme si une sorte de feu invisible léchait les couloirs de ton esprit. Dans un état d'égarement, tu entends une voix. \n « Il est temps de mettre dans la marmite, la cuisson est parfaite. » \n C'est exactement le paysage de mémoire que tu as peint, luttant et se déformant dans les flammes."
  },
  Event_91468_Name = {
    Text = "Portrait Brûlant"
  },
  Event_91469_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91469_Desc = {
    Text = "Tu refuses de répondre et regardes tranquillement l'appareil vibrer jusqu'à ce qu'il s'arrête. \n Après toutes ces années, tu as appris à lutter contre la folie."
  },
  Event_91469_Name = {
    Text = "Appel manqué"
  },
  Event_91470_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91470_Desc = {
    Text = "Tu recules d'un pas, laissant la toile brûler dans les flammes. \n Tu te vois rôtir dans un jaune séduisant, les graisses crépitant et produisant un son croustillant, comme si tu pouvais sentir l'odeur de la viande à travers la toile. \n Est-ce cette tentation que Doresain ressent ?"
  },
  Event_91470_Name = {
    Text = "Portrait Brûlant"
  },
  Event_91471_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91471_Desc = {
    Text = "Avec une curiosité presque sacrilège, ou peut-être un courage désespéré face à l'inconnu, tu cherches des révélations parmi les fantômes du passé.\nTu vois une jeune fille dansant avec un grand homme au visage flou à ses côtés, une joie inexplicable remplit ton cœur."
  },
  Event_91471_Name = {
    Text = "Ombre du passé"
  },
  Event_91472_ChoiceDesc1 = {
    Text = "[Stop Recording]supprimer 2 Cartes"
  },
  Event_91472_ChoiceDesc2 = {
    Text = "[Continue Writing]acquérir la relique maudite \"(RelicConfig.Arg1)\", infecter \"(Skill.Arg2)\""
  },
  Event_91472_ChoiceDesc3 = {
    Text = "[Leave] Gagner Arg1 sigles noirs"
  },
  Event_91472_Desc = {
    Text = "Tu es enfin temporairement libéré du marché des ghouls, cherchant un coin tranquille pour commencer à enregistrer comme d'habitude. \n La machine à écrire se met soudainement à vibrer avec fureur, les touches s'enfoncent toutes seules, une substance visqueuse noire jaillit des fissures, éclaboussant la raison au bout de tes doigts. \n Tu vois des ombres de papillons apparaître lentement sur le papier..."
  },
  Event_91472_Name = {
    Text = "Ombres de papillons"
  },
  Event_91473_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91473_Desc = {
    Text = "Étrangement, bien que ce soit une langue que tu n'as jamais apprise, tu sembles en comprendre le sens. \n Le poème est rempli de nostalgie pour les êtres chers, une nostalgie qui transcende la vie et la mort, se transmettant dans tes rêves. \n Tu distingues vaguement à la fin du poème l'écriture - \n c'est « Céline »."
  },
  Event_91473_Name = {
    Text = "Révélation du rêve"
  },
  Event_91474_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91474_Desc = {
    Text = "Tu déchirés la peau de ta paume avec douleur, brûlant la chair neuve avec des flammes.\nUn liquide noir s'évapore, le papillon se brise.\nTout devient propre et sans trace, mais tu as toujours l'impression d'entendre un faible battement d'ailes dans ta paume, comme une pensée qui n'a pas complètement éclos, respirant lentement dans tes veines.\nDoresain ne dit rien à ce sujet, il ne veut que le sang que tu as laissé."
  },
  Event_91474_Name = {
    Text = "Parasite de l'élite"
  },
  Event_91475_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91475_Desc = {
    Text = "Tu sais que l'inspiration frénétique mène inévitablement au désastre, alors tu scelles tout avec la raison."
  },
  Event_91475_Name = {
    Text = "Volcan endormi"
  },
  Event_91476_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91476_Desc = {
    Text = "Tu fixes l'œil, tentant de comprendre le message qu'il transmet. \n Bien que tu aies déjà connu de nombreuses batailles, cette fois face à Goliath... la peur étreint ton cœur. \n « Presque normal, c'est la forme la plus silencieuse avant que la catastrophe ne se produise. »"
  },
  Event_91476_Name = {
    Text = "Presque normal"
  },
  Event_91477_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91477_Desc = {
    Text = "Tu fermes les yeux et t'engages dans la steppe.\nTu perçois le désir et le présage cachés, mais tu ne pourras jamais les apaiser de tes propres mains.\nTu regardes les tombes silencieuses autour de toi, peut-être est-ce là ton destin.\n\n"
  },
  Event_91477_Name = {
    Text = "Fête des Corbeaux"
  },
  Event_91478_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91478_Desc = {
    Text = "Tu relèves doucement la tête, à cet instant, la lumière transperce ta pupille, la chaleur fait éclore une fleur blanche dans ton esprit. \n Les étoiles de la Nekropolis ne sont pas différentes de celles d'ailleurs, et les goules qui semblent posséder l'éternité ne peuvent vivre que sous les Étoiles, privées de liberté."
  },
  Event_91478_Name = {
    Text = "Nuit des Étoiles"
  },
  Event_91479_ChoiceDesc1 = {
    Text = "[Toss Into the Flames]supprimer 1 Carte"
  },
  Event_91479_ChoiceDesc2 = {
    Text = "[Attempt to Interpret]Obtenez \"(RelicConfig.Arg1)\", infligez \"(Skill.Arg2)\""
  },
  Event_91479_Desc = {
    Text = "Ta conscience flotte dans le brouillard infini, parcourant les paysages spirituels de nombreux vivants et morts. \n Dans le rêve, une machine à écrire magique crache un poème étranger. De qui est cette histoire ? \n Elle est gravée sur un papier d'origine inconnue, les caractères déformés ressemblent à ceux d'un ivrogne lucide. \n Tu es poussé par une impulsion indescriptible dans le rêve, tu prends ce papier, l'encre danse entre les ombres de la flamme."
  },
  Event_91479_Name = {
    Text = "Révélation du rêve"
  },
  Event_91480_ChoiceDesc1 = {
    Text = "[Join]Infliger \"(Skill.Arg1)\", obtenir aléatoirement 1 carte pour obtenir une Oraison : \"(EnchantConfig.Arg2)\""
  },
  Event_91480_ChoiceDesc2 = {
    Text = "[Drive Away]infecter \"(Skill.Arg1)\", acquérir aléatoirement 1 Carte pour obtenir une Oraison : \"(EnchantConfig.Arg2)\""
  },
  Event_91480_ChoiceDesc3 = {
    Text = "[Ignorer] Choisissez 1 carte parmi 3 cartes de commandement pour obtenir une oraison : [(EnchantConfig.Arg1)]"
  },
  Event_91480_Desc = {
    Text = "Tu entends le son lointain et indistinct d'une corne en os. \n La horde de rats surgit du noir marécage, rongeant les corps sans nom allongés sur le lit de la rivière asséchée. \n Ils forment un cercle, avec le corps déjà vide au centre, et la circonférence est un nouveau royaume où l'oubli est la loi. \n Et toi, tu te tiens à l'entrée de ce royaume."
  },
  Event_91480_Name = {
    Text = "Royaume Exilé"
  },
  Event_91481_ChoiceDesc1 = {
    Text = "[Lève les yeux] Obtenez une relique d'argent [(RelicConfig.Arg1)]"
  },
  Event_91481_ChoiceDesc2 = {
    Text = "[Partir la tête basse] Obtenez 75 sigils noirs, infection [(Skill.Arg2)]"
  },
  Event_91481_Desc = {
    Text = "Les corbeaux tournoient dans le ciel comme une scie hésitante, tranchant et retranchant la colonne vertébrale du ciel.\nIls volent bas autour de toi, comme s’ils pressentaient ta mort, attendant patiemment le début du festin."
  },
  Event_91481_Name = {
    Text = "Fête des Corbeaux"
  },
  Event_91482_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91482_Desc = {
    Text = "Tu le laisses continuer à écrire, avec ton pouls, ta douleur, ton passé et tes conjectures. \n Le papillon brise les contraintes du papier, et ton esprit s'envole avec lui. \n Tu commences à imaginer ta joie dans un parc d'attractions. Tu n'as pas dit à Doresain que tu aimes vraiment les parcs d'attractions, même un parc d'attractions pour les cadavres... \n Cela... ne doit pas être trop macabre, n'est-ce pas ?"
  },
  Event_91482_Name = {
    Text = "Ombres de papillons"
  },
  Event_91483_ChoiceDesc1 = {
    Text = "[Réexaminer] Choisissez 1 carte de commandement parmi 3 pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_91483_Desc = {
    Text = "Le dîner autrefois clair s'est transformé en un festin sanglant et déchiqueté. Tu te souviens des ingrédients sur la cuisinière, l'odeur de pourriture irrite tes narines. \n La peur étreint ton cœur, tu dois prendre une décision."
  },
  Event_91483_Name = {
    Text = "Ombre du passé"
  },
  Event_91484_ChoiceDesc1 = {
    Text = "[Ignore the Bell]acquérir 1 des 3 Oraisons avancées"
  },
  Event_91484_ChoiceDesc2 = {
    Text = "[Pick Up the Receiver]acquérir la Relique en or \"(RelicConfig.Arg1)\", infecter \"(Skill.Arg2)\""
  },
  Event_91484_ChoiceDesc3 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_91484_Desc = {
    Text = "Il n'aurait pas dû sonner—— ce téléphone, recroquevillé derrière la toile. \n Le fil du combiné s'entrelace autour du gros corps de l'appareil, tel un cordon ombilical rouillé, semblant s'étendre depuis ton esprit. \n Tu distingues attentivement la fréquence des vibrations, le son étrange évoquant l'art surréaliste de Pickman."
  },
  Event_91484_Name = {
    Text = "Appel manqué"
  },
  Event_91485_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91485_Desc = {
    Text = "Tu tiens ce cerveau froid, et instantanément, il se transforme en un flot silencieux qui glisse entre tes doigts. \n La balance s'incline alors, le cœur s'effondre rapidement comme un fruit pourri, se dissout en une flaque d'eau noire silencieuse. \n Toute la faim a disparu, et tu as acquis calme, absence de regrets et une brève clarté."
  },
  Event_91485_Name = {
    Text = "Jeux de la faim"
  },
  Event_91486_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91486_Desc = {
    Text = "Aucun son, personne ne répond. Ce n’était peut-être qu’un canular ? Au moment où tu reposes le combiné, un sentiment lourd remonte soudain en toi."
  },
  Event_91486_Name = {
    Text = "Appel manqué"
  },
  Event_91487_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91487_Desc = {
    Text = "Le corbeau disparaît. \nMais tu te vois debout devant un miroir d'une autre nuit, fixant ce corbeau. \nIl continue à crier en silence, comme s'il attendait une réponse de ta part."
  },
  Event_91487_Name = {
    Text = "Confession silencieuse"
  },
  Event_91488_ChoiceDesc1 = {
    Text = "[Réexaminer] Choisissez 1 carte de commandement parmi 3 pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_91488_ChoiceDesc2 = {
    Text = "[Abandonner la résistance] contaminer [(Skill.Arg1)], remplacer l'oraison obtenue dans l'option 1, utilisable une fois de plus"
  },
  Event_91488_Desc = {
    Text = "Tu détournes résolument le regard, mais ces images continuent à apparaître devant tes yeux comme des fantômes...\nC'est une danse à deux marquée par la tristesse."
  },
  Event_91488_Name = {
    Text = "Ombre du passé"
  },
  Event_91489_ChoiceDesc1 = {
    Text = "[Profiter] Choisissez 1 carte de commandement parmi 3 pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_91489_ChoiceDesc2 = {
    Text = "[Refuser poliment] infectez [(Skill.Arg1)], réimprimez, maximum 2 fois"
  },
  Event_91489_Desc = {
    Text = "C'est ce que Doresain a soigneusement préparé pour vous, qui avez tant travaillé à l'enquête. \nSans épices mais sans odeur de pourriture, comme l'a dit Doresain, c'est le meilleur ingrédient. \nLe banquet est dédié à vous, tandis que le cerveau reste silencieux dans l'assiette. \n« Voulez-vous goûter ? »"
  },
  Event_91489_Name = {
    Text = "Dégustation de mets raffinés"
  },
  Event_91490_ChoiceDesc1 = {
    Text = "[Écouter] Obtenez 40 sigils noirs, infection [(Skill.Arg2)], continuez à choisir"
  },
  Event_91490_ChoiceDesc2 = {
    Text = "[Disregard] Gagnez 25 Sigils Noirs et partez."
  },
  Event_91490_Desc = {
    Text = "C'est un corbeau. \nIl se tient sur le crâne utilisé comme lampe, ouvre le bec, mais ne produit aucun son."
  },
  Event_91490_Name = {
    Text = "Confession silencieuse"
  },
  Event_91491_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91491_Desc = {
    Text = "Tu tends lentement la main vers ce cœur encore chaud, il bat et se contracte, jusqu'à se transformer en une douce chaleur qui se dissipe. \n La balance tremble violemment, le cerveau tombe dans l'obscurité infinie. \n Une sensation de plénitude remplace la faim, tu comprends la passion, la douleur et les véritables souvenirs."
  },
  Event_91491_Name = {
    Text = "Jeux de la faim"
  },
  Event_91492_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91492_Desc = {
    Text = "Tu inclines la tête en accueillant cette rotation silencieuse, tel un pèlerin des anciens rites. \n Ils se régalent joyeusement de ta chair, tu ressens la douleur, mais aussi la clarté. \n Tu vois ton moi perdu, ces parties qui n'ont pas pu mourir, enfin emportées. \n Lorsque la conscience revient, tu découvres que tu es indemne."
  },
  Event_91492_Name = {
    Text = "Fête des Corbeaux"
  },
  Event_91493_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91493_Desc = {
    Text = "Vous avez scellé le trou de la serrure avec le ciment de vos souvenirs et émotions, la vérité ne pourra plus vous séduire. \n Voyant votre air inquiet, Doolasain lèche ses lèvres. \n « Tu veux goûter encore ? C’est une mozzarella spécialement préparée pour vous, Gardien des secrets. »"
  },
  Event_91493_Name = {Text = "Apocalypse"},
  Event_91494_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91494_Desc = {
    Text = "En réalité, tu as toujours été curieux de l'expérience des goules.\n« Ainsi, tu t'avances parmi les rats et deviens l'un des leurs — »\nTu dois admettre que l'arrivée des Marins a rendu ton esprit plutôt confus."
  },
  Event_91494_Name = {
    Text = "Royaume Exilé"
  },
  Event_91495_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91495_Desc = {
    Text = "Tu refuses de te laisser corrompre par la décadence et le chaos. \n Tu t'y es déjà habitué, toute décadence semble normale."
  },
  Event_91495_Name = {
    Text = "Royaume Exilé"
  },
  Event_91496_ChoiceDesc1 = {
    Text = "[Profiter] Choisissez 1 carte de commandement parmi 3 pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_91496_ChoiceDesc2 = {
    Text = "[Refuser poliment] infection [(Skill.Arg1)], réimpression aléatoire"
  },
  Event_91496_Desc = {
    Text = "Dursain découpe élégamment un morceau de « cerveau » pour vous. \nCette saveur sucrée… \nCette texture moelleuse et dense… \nVous avez vraiment envie d'en reprendre une bouchée."
  },
  Event_91496_Name = {
    Text = "Dégustation de mets raffinés"
  },
  Event_91497_ChoiceDesc1 = {
    Text = "[Je rêve] Obtenez une relique d'argent [(RelicConfig.Arg1)]"
  },
  Event_91497_ChoiceDesc2 = {
    Text = "[This Is Not Normal]acquérir la Relique en or \"(RelicConfig.Arg1)\", infecter \"(Skill.Arg2)\""
  },
  Event_91497_Desc = {
    Text = "Une pierre tombale lisse reflète un œil qui se tord lentement. \n Il semble porter une image que l'œil nu ne peut décrire, un souvenir qui ne t'appartient pas, mais qui est déjà profondément ancré dans les plis de ton regard. \n Tu essaies de cligner des yeux, de frotter avec le bout des doigts, mais cet œil ne t'appartient plus, il commence à refléter des scènes comme un kaléidoscope."
  },
  Event_91497_Name = {
    Text = "Presque normal"
  },
  Event_91498_ChoiceDesc1 = {
    Text = "[Continuer à observer] Choisissez 1 carte de commandement parmi 3 pour obtenir une oraison : [(EnchantConfig.Arg1)]"
  },
  Event_91498_ChoiceDesc2 = {
    Text = "[Détourner le regard] Infectez [(Skill.Arg1)], remplacez l'oraison obtenue dans l'option 1, utilisable deux fois"
  },
  Event_91498_Desc = {
    Text = "Dans un coin humide du château, tu découvres cette bobine de film. \n Les images sont comme des fantômes noyés dans la rivière du temps, figées dans un ralentissement, se gonflant parfois en des formes indescriptibles, parfois se contractant en des points scintillants. \n Tu es immergé, une vague de vertige te rappelle l'écoulement du temps."
  },
  Event_91498_Name = {
    Text = "Ombre du passé"
  },
  Event_91499_ChoiceDesc1 = {
    Text = "[Gaze at the Stars]Obtenez la Relique en or \"(RelicConfig.Arg1)\", infliger \"(Skill.Arg2)\""
  },
  Event_91499_ChoiceDesc2 = {
    Text = "[Fermer les yeux] Réveillez 2 éveillés au hasard, infectez deux fois [(Skill.Arg1)]"
  },
  Event_91499_ChoiceDesc3 = {
    Text = "[Partir]Obtient 50 sigils noirs"
  },
  Event_91499_Desc = {
    Text = "Tu te tiens dans un cimetière désert, la présence des étoiles rend la nuit aussi lumineuse que le jour. \n Ces sphères lumineuses flottant dans les profondeurs du temps n'ont jamais parlé, mais, dans une rotation aussi longue qu'un rêve, elles se concentrent lentement. \n Elles regardent l'étoile solitaire oubliée. \n Elle te fixe, observant toutes les morts et l'éternité."
  },
  Event_91499_Name = {
    Text = "Nuit des Étoiles"
  },
  Event_91500_ChoiceDesc1 = {
    Text = "[Écouter] Obtenez 20 sigils noirs, infection [(Skill.Arg2)]"
  },
  Event_91500_ChoiceDesc2 = {
    Text = "[Ignorez] Partez"
  },
  Event_91500_Desc = {
    Text = "Tu le fixes du regard.\nDans l'obscurité totale, tu distingues une flamme avide."
  },
  Event_91500_Name = {
    Text = "Confession silencieuse"
  },
  Event_91501_ChoiceDesc1 = {
    Text = "[Unlocking the Keyhole]acquérir la Relique maudite \"(RelicConfig.Arg1)\"，infecter \"(Skill.Arg2)\""
  },
  Event_91501_ChoiceDesc2 = {
    Text = "[Sceller la serrure] 1 Carte aléatoire obtient l'Oraison : [(EnchantConfig.Arg1)]"
  },
  Event_91501_Desc = {
    Text = "Face à la lobe cérébral tendu par Doresain, tu as plusieurs fois refusé, mais finalement, tu ne peux résister à l'attrait de la sagesse. \n La connaissance ne descend pas lentement, elle se déverse soudainement. \n Ton cerveau commence à souffrir, la pensée se dilate comme un pain en fermentation. Quand tu finis par t'effondrer, la douleur se retire comme une marée, ta conscience semble avoir un vide, laissant un trou propre et ancien. \n Voilà donc la forme de la connaissance ! Tu ressens une sagesse sans précédent. \n Peut-être... peux-tu en obtenir davantage ?"
  },
  Event_91501_Name = {Text = "Apocalypse"},
  Event_91502_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91502_Desc = {
    Text = "Tu fais levier sur le trou de la serrure avec la lame tranchante des résidus de ta conscience. \n Tu ne sais pas ce qu'est une clé, tu n'essaies qu'avec ton obsession. À cet instant, ta pensée brûle entièrement, ne laissant qu'une sorte de raison inhumaine chuchoter dans le trou de serrure vide. \n Est-ce cela la révélation ? Tu partages avec excitation avec Doresain. \n « Tu veux goûter encore ? C’est une mozzarella spécialement préparée pour vous, Monsieur Gardien du Secret. »"
  },
  Event_91502_Name = {Text = "Apocalypse"},
  Event_91503_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91503_Desc = {
    Text = "Tu ne l'exploses ni ne l'étouffes. \n Dans un état subtil d'observation, tu considères ces pensées jaillissantes comme une partie du changement climatique, les laissant se diriger vers une issue inconnue. \n Dans cette œuvre de chair et de sang, tu découvres l'art éternel."
  },
  Event_91503_Name = {
    Text = "Volcan endormi"
  },
  Event_91504_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91504_Desc = {
    Text = "La touche s'arrête brusquement, les papillons disparaissent en un instant.\nEst-ce une hallucination ? Tu as l'impression de perdre quelque chose.\nPeut-être devrais-tu écouter Doolas et acheter quelques feuilles de mémoire à la boutique ?\n« Non, à quoi est-ce que je pense ? »"
  },
  Event_91504_Name = {
    Text = "Ombres de papillons"
  },
  Event_91505_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91505_Desc = {
    Text = "Tu ne luttes plus, laissant les ailes et le liquide noir percer les lignes de ta main. \n Tu es devenu son récipient, et elle continue de penser en utilisant ton corps comme coquille. \n Le papillon devient de plus en plus grand, et tu ne peux plus supporter son poids. \n Voyant cela, Doresain coupe avec enthousiasme le lien entre toi et le papillon avec un couteau de table. Son regard avide exprime clairement son intention... \n Tu refuses sa demande."
  },
  Event_91505_Name = {
    Text = "Parasite de l'élite"
  },
  Event_91506_ChoiceDesc1 = {
    Text = "[Écouter] Obtenez 35 sigils noirs, infection [(Skill.Arg2)], continuez à choisir"
  },
  Event_91506_ChoiceDesc2 = {
    Text = "[Ignorez] Partez"
  },
  Event_91506_Desc = {
    Text = "Tu croyais qu’il était silencieux, jusqu’à ce que ton esprit s’incline soudainement, comme si des milliers de corbeaux hurlaient à l’intérieur de ton cerveau. \n Tu t’effondres à genoux, le monde tourne devant tes yeux."
  },
  Event_91506_Name = {
    Text = "Confession silencieuse"
  },
  Event_91507_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91507_Desc = {
    Text = "Tu fermes les yeux et entres dans cette poussière infinie et douce, les nébuleuses t'enlacent, et tu perds ta forme, une existence plus solide que le corps s'implante en toi. \n Cette nuit-là, les étoiles continuent de tourner, brillantes comme toujours. \n Que signifie le ciel étoilé pour ceux qui vivent éternellement ? Peut-être devrais-tu demander à Doresain."
  },
  Event_91507_Name = {
    Text = "Nuit des Étoiles"
  },
  Event_91508_ChoiceDesc1 = {
    Text = "[Profiter] Choisissez 1 carte de commandement parmi 3 pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_91508_Desc = {
    Text = "C'est donc du fromage. \n Tu ressens un soulagement, mêlé à une pointe de déception."
  },
  Event_91508_Name = {
    Text = "Dégustation de mets raffinés"
  },
  Event_91509_ChoiceDesc1 = {
    Text = "[Ignite]infecter \"(Skill.Arg1)\", acquérir la Relique d'argent \"(RelicConfig.Arg2)\""
  },
  Event_91509_ChoiceDesc2 = {
    Text = "[Wait]infecter \"(Skill.Arg1)\"，acquérir la Relique d'argent \"(RelicConfig.Arg2)\""
  },
  Event_91509_ChoiceDesc3 = {
    Text = "[Seal]Obtenez 25 Le Sigil Noir"
  },
  Event_91509_Desc = {
    Text = "Tu fixes le tableau de Pickman, l'odeur putride te donne le tournis. \n Des pensées s'élèvent lentement de ton esprit, d'abord comme de la chaleur, puis comme une brume légère, et ensuite —"
  },
  Event_91509_Name = {
    Text = "Volcan endormi"
  },
  Event_91510_ChoiceDesc1 = {
    Text = "[Toucher le cerveau] Tirez une carte de commandement au hasard pour obtenir une oraison :[(EnchantConfig.Arg1)]"
  },
  Event_91510_ChoiceDesc2 = {
    Text = "[Toucher le cœur] Augmentez Arg1 points de santé maximum, infectez [(Skill.Arg2) ]"
  },
  Event_91510_Desc = {
    Text = "Tu entres dans cette salle grise où personne ne chuchote, une balance émergeant dans le brouillard noir. \n À gauche se trouve un cerveau calme comme un lac, ses canyons argentés scintillant faiblement ; à droite, un cœur rouge flamboyant, dégoulinant de chaleur. \n Tout à coup, tu sens un parfum, un désir affamé qui ne cesse de croître, la raison étant écrasée par son obscurité infinie. \n Tu tends la main."
  },
  Event_91510_Name = {
    Text = "Jeux de la faim"
  },
  Event_91511_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91511_Desc = {
    Text = "C'est forcément un rêve. Tu te répètes cela pour t'en convaincre. \n Sans t'en rendre compte, tu t'es vraiment endormi. \n Peut-être à cause de trop nombreux échanges récents, tu as même rêvé de Dursan — lui offrir volontairement ta propre chair et ton sang ? Quelle histoire horrible ?"
  },
  Event_91511_Name = {
    Text = "Presque normal"
  },
  Event_91660_ChoiceDesc1 = {
    Text = "[Trouver une autre voie] Choisissez 1 Carte d'instruction parmi 3 pour obtenir une Oraison : [(EnchantConfig.Arg1)]"
  },
  Event_91660_ChoiceDesc2 = {
    Text = "[Let It Exist]Choisir au hasard 3 Cartes de commandement pour obtenir une Oraison : \"(EnchantConfig.Arg1)\", infliger \"(Skill.Arg2)\""
  },
  Event_91660_Desc = {
    Text = "« Pour guider l'âme, tu dois mener les morts jusqu'à la fin. »\nAvec les paroles de Doresain, tu as une Épiphanie.\nCe n'est ni la connaissance, ni le souvenir - c'est plutôt un poids qui pénètre par tes orbites, inondant ton cerveau comme un déluge.\nTes émotions semblent ne plus appartenir à ce moment et cet endroit, elles se retirent, révélant une fissure négligée de l'univers.\nTout ce que tu peux percevoir s'arrête là, comme si tu étais arrivé au bout d'un chemin."
  },
  Event_91660_Name = {
    Text = "Fin de l'âme"
  },
  Event_91661_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91661_Desc = {
    Text = "Tu laisses ton âme s'éloigner.\nÀ la frontière du « moi », tu sembles entendre des murmures des morts.\nMais quand tu tends l'oreille, tout disparaît."
  },
  Event_91661_Name = {
    Text = "Fin de l'âme"
  },
  Event_91662_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91662_Desc = {
    Text = "Tu enveloppes ta conscience, te coupant ainsi des tentations inconnues. \nTu t'égares aux confins de ton âme, ne voyant que toi-même. \nEn effet, en tant qu'être vivant, tu ne peux pas posséder les capacités d'un goule."
  },
  Event_91662_Name = {
    Text = "Fin de l'âme"
  }
})
return Text_Event
