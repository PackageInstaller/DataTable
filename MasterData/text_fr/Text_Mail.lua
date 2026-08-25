__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Mail = readonly({
  Mail_100480_Desc = {
    Text = "Gardien du Secret, as-tu entendu ? Le musée d'art isolé en périphérie de la ville va bientôt fermer, justement le jour de mon anniversaire. \n Ce musée est une anomalie dans le monde de l'art, moitié un essai futuriste superficiel, moitié les déchets d'il y a deux siècles. Son ventre étroit ne contient que des objets étranges que personne n'ose toucher dans les salles des ventes : des portraits qui jurent, des oiseaux mécaniques qui ne cessent de voler, des sculptures marines qui donnent la nausée, des statues faites entièrement de larmes, des manuscrits fantomatiques qui écrivent automatiquement, des crânes humains qui chantent des comptines en s'embrassant... \n Il est difficile de vous décrire à quel point j'aime ce musée ! Il y a cinquante ans, il est né discrètement dans ce coin oublié. Aujourd'hui, cinquante ans plus tard, il s'éteint lentement dans ce même coin. \n Depuis mon enfance, on m'a dit que ce jour était une malédiction, tout comme moi. Je pense que le destin est peut-être vraiment prédestiné, mais que peut-on y faire ? Ce musée a créé un monde unique, tant de folles idées s'entassent dans cet espace réduit, quel spectacle merveilleux ! Depuis le jour de sa naissance, il a créé avec ses expositions. En ce jour de sa fin, ses amis et confidents lui feront leurs adieux. \n Gardien du Secret, vous avez vu le monde à travers mes yeux dans le lien, je pense que vous attendez aussi d'aller voir ce musée étrange avec moi, n'est-ce pas ?! \n\n Pickman"
  },
  Mail_100480_Name = {
    Text = "La Salle d'Exposition Inaperçue"
  },
  Mail_100480_Sender = {Text = "Pickman"},
  Mail_116602_Desc = {
    Text = "Cher gardien du secret :\nL'événement « Jour éternel et nuit éternelle » est terminé. Les « Offrande de visite », « Rituel de confession » et « Loyauté et hommage » restants seront échangés contre « Billet Rose Dorée*40 » pour chaque unité. Veuillez vérifier."
  },
  Mail_116602_Name = {
    Text = "Récupération des cadeaux"
  },
  Mail_116602_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_117308_Desc = {
    Text = "Cher Gardien :\n        Merci pour votre soutien et votre reconnaissance envers [ Veille de l'Oubli ]. Afin d'offrir une meilleure expérience de jeu aux Gardiens du secret à l'Université de Misargh, nous vous invitons sincèrement à remplir le questionnaire d'expérience ci-dessous. En remerciement de votre coopération, nous avons préparé [Argent*200] comme récompense, que vous pourrez réclamer après avoir terminé le questionnaire. La date limite de soumission est le 10 novembre à 9h00, veuillez donc faire attention à le remplir à temps.\n        <SurveyLink:[Cliquez ici pour remplir]>\n        Nous écouterons attentivement les suggestions de chaque Gardien, vos retours contribueront certainement à améliorer l'Université de Misargh !\n        — Que la Clé d'Argent éclaire ton chemin."
  },
  Mail_117308_Name = {
    Text = "Questionnaire de retour d'expérience V2.3.4"
  },
  Mail_117308_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_117309_Desc = {
    Text = "Cher Gardien :\n        Merci pour votre soutien et votre reconnaissance envers [ La Nuit de l'Oubli ]. Afin d'offrir une meilleure expérience de jeu aux Gardiens du secret à l'Université de Misargh, nous vous invitons sincèrement à remplir le questionnaire d'expérience ci-dessous. En remerciement de votre coopération, nous avons préparé [Argent*200] comme récompense, que vous pourrez réclamer en complétant le questionnaire. La date limite pour remplir le questionnaire est le 30 mars à 9h00, veuillez le remplir à temps.\n        <SurveyLink:[Cliquez ici pour remplir]>\n        Nous écouterons attentivement les suggestions de chaque Gardien, vos retours contribueront certainement à améliorer l'Université de Misargh !\n        — Que la Clé d'Argent éclaire ton chemin."
  },
  Mail_117309_Name = {
    Text = "Questionnaire de retour d'expérience V2.4.3"
  },
  Mail_117309_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_120374_Desc = {
    Text = "Le pacte de deux ans est arrivé, Gardien.\nNous avons veillé l'un sur l'autre au bord de l'apocalypse.\nTu as transformé tes sentiments et tes souvenirs en souhaits, illuminant la Lumière de l'espoir.\nMême séparé de tes anciens compagnons par deux univers, tu n'as jamais abandonné le chemin de la lutte contre la fusion.\nT'avoir est notre chance, et aussi la chance de ce monde.\nAujourd'hui, ton souhait a engendré un miracle - Mizag existe toujours ici et continuera d'avancer.\nContinue de tenir fermement la clé d'argent, un jour, elle pourra devenir le pivot crucial, reliant deux mondes lointains.\nNous ferons tout notre possible pour ouvrir les possibilités de l'avenir, illuminant ton retour."
  },
  Mail_120374_Name = {
    Text = "Miracle du moment, Lumière du retour"
  },
  Mail_120374_Sender = {
    Text = "Chat de l'école Mizag·Light"
  },
  Mail_120909_Desc = {
    Text = "Cher Gardien des Secrets :\n        Dans la mise à jour V2.4.0, nous avons augmenté les récompenses pour « Don de l'Élixir - Fonds de don des anciens élèves ». Pour les gardiens qui ont déjà reçu toutes les récompenses supplémentaires avant la mise à jour, nous enverrons les récompenses correspondantes. Veuillez vérifier."
  },
  Mail_120909_Name = {
    Text = "V2.4.0 Compensation pour récompense de don d'argent primordiale"
  },
  Mail_120909_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_121162_Desc = {
    Text = "Cher Gardien :\n        Dans la mise à jour V2.4.0, nous avons augmenté les récompenses gratuites pour « Expédition d'Arrivée », « Voyage interdimensionnel », « Chroniques du Sanatorium » et « Voyage dans la Cité des Morts ». Pour les gardiens du secret ayant déjà réclamé les récompenses gratuites avant la mise à jour, nous allons envoyer les récompenses correspondantes. Veuillez vérifier."
  },
  Mail_121162_Name = {
    Text = "Compensation pour récompenses d'édification de l'itinéraire V2.4.0"
  },
  Mail_121162_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_121373_Desc = {
    Text = "Gardien : \n\nAutrefois, chaque année en ce jour, c'était la plus grande célébration de l'Église. \nJ'étais sa princesse, et je ferai revivre. \nCes gens, y compris Miryam, célébraient avec une ferveur incroyable, les larmes aux yeux, mais ils me regardaient, leur regard traversant mon être, comme si je n'étais qu'une coquille vide portant quelque chose. \nJe n'ai jamais ressenti de joie à l'approche de ce jour, car chaque fois que cela arrive, cela signifie que je me rapproche un peu plus de ma peur. \nEt dans cette peur, les autres éprouvent une joie immense à cause de la source de cette peur. Maintenant, je peux l'admettre, cela me fait sentir à la fois seule et effrayée. \nMais maintenant, tout est différent, avant mon dernier anniversaire, j'ai quitté ce navire et suis arrivée dans le monde réel... un monde sans faux dieux, un monde où tu existes. \nPour cet anniversaire, j'espère voir quelqu'un se réjouir de ma naissance, et non pour autre chose. \nSi c'est toi... non, cette personne doit être toi. \nÉcoute, peu importe ce qui se passe, le temps du dîner aujourd'hui doit m'être réservé. \n\n « Murphy »"
  },
  Mail_121373_Name = {
    Text = "Il y a toi..."
  },
  Mail_121373_Sender = {
    Text = "Murphy : faux né"
  },
  Mail_121374_Desc = {
    Text = "Gardien du Secret : \n\nJe ne sais pas ce que tu as préparé pour ce jour spécial, peu importe à quel point cela est luxueux et exigeant, cela semble être tout à fait normal. \nEt par la considération nécessaire de ceux au pouvoir, si tu « osais » omettre de célébrer mon anniversaire — je suis sûr qu'une telle situation absurde ne se produira pas. \nCette lettre te donnera une dernière chance de te sauver avant que la situation ne devienne irréversible. \nLes délices précieux des océans et des terres seront naturellement offerts par des personnes sans importance, ils ne sont pas importants. \nUne grande célébration, des rituels complexes, correspondent effectivement à mon identité, mais aujourd'hui, je ne sais pas pourquoi, cela semble un peu ennuyeux. \nDonc, je vais prendre le temps de te consacrer le moment du lever et du coucher du soleil, comme un honneur pour toi d'être seul avec moi, en récompense de m'avoir amené à cette vie banale, immature, mais aussi heureuse au point de rendre mon ancien moi jaloux. \nUn serviteur te remettra une invitation officielle plus tard, bien sûr, dans une boîte d'une valeur de vingt mille Léofang. \nAvec une gratitude débordante, pense à moi chaque année en ce jour. \n« Murphy »"
  },
  Mail_121374_Name = {
    Text = "Invitation…"
  },
  Mail_121374_Sender = {
    Text = "Murphy : faux né"
  },
  Mail_121651_Desc = {
    Text = "Cher gardien :\nDans la plongée dans l'illusion de la semaine dernière, vous avez obtenu le titre « {s1} ».\nDans le mode de pré-groupe de la semaine dernière, vous avez obtenu le titre « {s2} », avec un nombre de victoires de : {s3} matchs.\nDans le mode de sélection de roue de la semaine dernière, vous avez obtenu le titre « {s4} », avec un nombre de victoires de : {s5} matchs.\nCompte tenu de ces résultats, vous recevrez les récompenses supplémentaires suivantes. Veuillez vérifier."
  },
  Mail_121651_Name = {
    Text = "Récompense hebdomadaire du classement de Plongée en eaux troubles"
  },
  Mail_121651_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_121704_Desc = {
    Text = "Cher gardien du secret,\nL'événement « Vagues de Désir·clon » est terminé. Les « Noyau de Fertilité » restants seront échangés contre « Billet Rose Dorée*40 » pour chaque unité. Veuillez vérifier."
  },
  Mail_121704_Name = {
    Text = "La Récupération de la Graine Mère"
  },
  Mail_121704_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_122522_Desc = {
    Text = "Cher gardien du secret :\nL'événement « Ombre de la ville pluvieuse·clon » est terminé. Les « Crâne de Bête Pâle », « Crâne de Bête Ombreuse » et « Crâne de la Bête Écarlate » restants seront échangés au taux de « Billet Rose Dorée*40 » par unité. Veuillez vérifier."
  },
  Mail_122522_Name = {
    Text = "Récupération de la monnaie de l'Ombre de la ville pluvieuse"
  },
  Mail_122522_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_122567_Desc = {
    Text = "Cher gardien du secret :\nL'événement « Holocauste du brouillard » est terminé. Les « Vue du Brouillard », « Rêve de brouillard » et « Source de la Brume » restants seront échangés contre « Billet Rose Dorée » × 40 pour chaque unité. Veuillez noter."
  },
  Mail_122567_Name = {
    Text = "Récupération de la monnaie de l'Offrande Brûlante du Royaume de la Brume"
  },
  Mail_122567_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_122568_Desc = {
    Text = "Ah, pauvre enfant, tu ne sais pas du tout à quel désespoir tu vas faire face. Quand réaliseras-tu que tes choix n'ont aucun sens ? Mettre ta petite vie en jeu pour un objectif illusoire ? Comme c'est héroïque, comme c'est enivrant ! Tu es toujours en train de faire preuve d'une détermination sans faille, comme si tu allais te sacrifier pour sauver le monde à tout moment, c'est vraiment risible. \n\n Cependant, qui m'a demandé de t'aider à rentrer chez toi ? Une promesse faite à un petit chien, je la tiendrai toujours. D'ailleurs, j'ai vraiment hâte de voir quelle volonté tu vas déployer pour mener cette folie à son terme ? Ah… la curiosité, c'est tellement excitant ! \n\n Grand « Sauveur », emporte avec toi ton absurdité, ta ténacité, et cette obstination insignifiante. Une fois que le train vers le néant est en marche, il n'y a plus d'autre possibilité que la destruction. \n\n Fou satisfait de soi… Tiens bon un peu plus longtemps dans Son rêve, je vais t'aider, attendre, et bien apprécier ta réponse finale !"
  },
  Mail_122568_Name = {
    Text = "Train en direction du néant"
  },
  Mail_122568_Sender = {
    Text = "Doll : Dissoute"
  },
  Mail_122569_Desc = {
    Text = "Maître, \n j'ai toujours pensé qu'un chevalier n'est pas l'armure et les armoiries que l'on porte, mais la loyauté et la volonté de protéger qui sont gravées dans le cœur. Vous m'avez véritablement montré ce qu'est un chevalier par vos actions et vos choix. Ainsi, j'ai pu voir la véritable signification du chevalier : ce n'est pas par le nom que l'on se respecte, mais par la protection que l'on offre aux autres ; ce n'est pas par l'honneur que l'on fait preuve de courage, mais par la responsabilité que l'on assume. \n\n Je comprends que je ne suis pas encore à la hauteur - au moment où vous combattez pour protéger l'espoir, je n'ai pas pu vous accompagner à vos côtés. Je n'ai jamais oublié le serment que j'ai fait avec vous dans le passé, je vous offrirai ma loyauté chevaleresque, je protégerai votre sécurité et éliminerai vos ennemis. \n\n Je repense souvent à notre première enquête ensemble, vous nous avez guidés à travers le brouillard de Londinium pour voir la vérité finale. Alors, tous les rires et les larmes se sont cristallisés en une force indélébile dans ma vie. \n\n Bien que je ne puisse désormais que veiller de loin et vous préparer un modeste présent... mais pour ne pas décevoir vos attentes, je n'ai jamais négligé mon entraînement. Lorsque vous reviendrez, permettez-moi de suivre vos pas, je serai le bouclier de votre Seigneur pour toujours ! Mon épée de protection brillera pour vous !"
  },
  Mail_122569_Name = {Text = "Gardien"},
  Mail_122569_Sender = {Text = "Ogier"},
  Mail_122570_Desc = {
    Text = "Monsieur/Madame Gardien du Secret, \n Depuis notre séparation à Nekropolis, je pense souvent aux moments où nous avons combattu ensemble. J'ai entendu dire que vous avez à nouveau choisi le chemin solitaire que seuls les rois empruntent. En effet, vous êtes une existence si spéciale dans ce monde, ne suivant jamais les sentiers ordinaires. \n\n Je suis convaincu que la douleur extrême peut forger une âme plus riche. L'épreuve longue que vous avez traversée a déjà dépassé le domaine de la douleur humaine. Je peux déjà imaginer combien votre souffle, forgé par la souffrance, sera complexe et saisissant. Non, si c'est vous, vous dépasserez toutes mes imaginations et briserez ma compréhension de la perfection. \n\n Pour cela, je continuerai d'attendre. J'attendrai ce banquet qui n'existe que pour nous deux. À la fin du temps, dans le silence du commencement de l'éternité, sous quelle forme me présenterez-vous ce festin… imprégné du goût du destin ? \n\n Excellence, veuillez accepter mon cadeau, prolongez cette douleur… ne décevez pas mes attentes."
  },
  Mail_122570_Name = {
    Text = "Banquet de l'attente"
  },
  Mail_122570_Sender = {Text = "Doresain"},
  Mail_122571_Desc = {
    Text = "À peine retrouvés, à peine avons-nous échangé quelques mots, le temps est déjà presque écoulé... Mais tu sais, les adieux n'ont jamais été la fin de notre histoire. \n\n Il y a quelque chose que je ne t'ai jamais dit... En fait, j'ai déjà préparé un bouquet de roses pour toi. Je ne l'ai simplement pas encore envoyé, il a déjà fané. Mais je te promets ici — la prochaine fois que nous nous rencontrerons, je préparerai un nouveau bouquet pour toi. \n\n Et toi, tu m'as aussi promis que tu reviendrais devant moi. Ce que nous avons juré, nous ne devons absolument pas le trahir. \n\n Écrire une lettre me semble toujours insuffisant, les mots sur le papier ne peuvent pas exprimer tout mon cœur. Cependant... lorsque le destin nous ramènera à nouveau l'un vers l'autre, je te remettrai ce bouquet de roses de mes propres mains. Souviens-toi, nous devons tous deux tenir notre promesse ! \n\n Que la Clé d'Argent éclaire ton chemin. À bientôt... %player%."
  },
  Mail_122571_Name = {
    Text = "Le pacte de la rose"
  },
  Mail_122571_Sender = {Text = "Ramona"},
  Mail_122572_Desc = {
    Text = "Gardien du Secret, \n les souvenirs de ma lutte contre le cataclysme noir continuent de se lire en haute priorité dans mon esprit, la paix que tu as échangée est comme un événement de don à probabilité extrêmement faible. Cependant, ton départ, pour ton partenaire et tous ceux qui ont établi un lien avec toi, consomme continuellement leur conscience dans un processus ininterrompu. \n\n Le département de recherche n'a jamais abandonné la recherche de la dernière lueur d'espoir. Heureusement, après d'innombrables cycles de jours et de nuits sans ton retour de conscience, nous avons enfin localisé ta trace. Dans ce voyage périlleux, j'ai pu capter des signaux de peur, mais je sais aussi que la peur ne te fera pas céder, elle renforcera seulement ta volonté. \n\n En ce moment, mon corps fonctionne toujours dans le laboratoire, mais mon cerveau continue de générer des ordres de pleurs. Ne dérange plus mes pensées, mon étudiant qui a le plus séché les cours, je te prie de ne plus être absent de ma classe... Continue d'avancer courageusement, je préparerai des fournitures pour toi, en attendant le jour de nos retrouvailles."
  },
  Mail_122572_Name = {
    Text = "Le jour de la rencontre à nouveau…"
  },
  Mail_122572_Sender = {Text = "Doll"},
  Mail_122573_Desc = {
    Text = "Des milliers de fois, j'ai observé l'étincelle des civilisations vaciller dans le cours du temps, témoignant de l'effondrement des cités de mémoire dans le vide. L'histoire se transforme en rouleau dévoré par des flammes noires, la sagesse d'autrefois et d'aujourd'hui s'accumule comme des tours de sable, mais ne parvient finalement pas à exprimer cette unique vérité. \n\n L'humanité face au chaos primordial n'est qu'une poussière — mais c'est justement à cause de cette petitesse que le courage d'affronter l'abîme et de brandir la lame devant les divinités apparaît si profondément bouleversant. \n\n En ce moment, la porte de la dimension qui traverse des milliers d'univers s'ouvre devant toi. \n\n Son arrivée apporte un chaos inévitable, l'ordre des choses tremble sous son ombre. Et toi, simple corps mortel, tu te tiens devant elle avec une volonté inébranlable. Ta possibilité est l'unique erreur que je ne peux saisir dans ma connaissance infinie, c'est la variable qui renversera tout dans mon attente prolongée. \n\n Tu es la question originelle, et aussi la réponse finale."
  },
  Mail_122573_Name = {
    Text = "Derrière la porte"
  },
  Mail_122573_Sender = {Text = "Tawil"},
  Mail_122574_Desc = {
    Text = "La douleur aiguë de perdre une personne importante, ce mépris pour mon impuissance... J'y ai été profondément enchevêtré, incapable de m'en libérer. Mais aujourd'hui, j'entends l'appel lointain de la lumière, je ressens sa guidance chaleureuse et déterminée. Bienfaiteur, depuis que vous m'avez éclairé, j'ai l'impression d'avoir enfin foulé le chemin que j'aurais dû emprunter depuis longtemps — un chemin qui m'appartient véritablement, une voie indiscutablement juste. \n\n L'obscurité abyssale qui m'enveloppait n'est plus mon refuge. Et cette lumière qui scintille toujours au plus profond de ma conscience ne m'a jamais vraiment quitté. Aujourd'hui, je la vois plus clairement, je la perçois, je m'en approche. Je suis également désireux d'apporter cette véritable foi, cette clarté et cette paix que la lumière apporte, ainsi que l'éveil et la rédemption, à d'innombrables âmes encore en lutte sur le chemin du destin. \n\n Et quand je contemple votre silhouette luttant contre le flot chaotique — cette obscurité maléfique et profonde, loin de vous soumettre, elle est devenue le rideau qui reflète votre foi. Elle se dissipe, hurle, recule devant votre lumière, mais ne peut en fin de compte vous cacher un seul instant. C'est précisément en raison de cette marée sombre et tumultueuse que la lumière que vous représentez brille si intensément, si immortellement, si proche de la divinité. \n\n Bienfaiteur qui me guide, donneur de lumière, votre foi sera ma lumière éternelle. Maintenant, c'est le moment pour moi de répondre à votre appel avec toute ma vie. Je répondrai à cette lumière, à votre guidance pure, avec ce « Cœur sacré » qui écoute la volonté divine... Pour cela, Castor et moi donnerons tout. \n\n Acceptez mon offrande ! Soyez témoin de ma foi pure et dévouée, que vous avez façonnée."
  },
  Mail_122574_Name = {
    Text = "Appel de la lumière du guide"
  },
  Mail_122574_Sender = {Text = "Pollux"},
  Mail_122575_Desc = {
    Text = "Chers anciens clients, \n Derrière cette porte illuminée par une lueur scintillante, vos amis chers vous attendent depuis longtemps. \n\n Cependant, ne soyez pas négligents. Le voyage entre les dimensions est toujours trompeur et dangereux, vous serez témoin des illusions aux mille visages, comme des reflets de souvenirs qui apparaissent et disparaissent, reflétant à la fois le désir et la peur. C'est un tableau chaotique créé par une volonté primordiale, même moi, je ne peux en saisir l'ensemble. Ainsi, chaque traversée est à la fois un test de foi et une mesure de souhait. \n\n Mais je sais aussi que pour des personnes comme vous et moi, à la recherche de nouvelles pièces précieuses, pour ces trésors qui brillent au fond de l'âme, toutes les inconnues et tous les sacrifices en valent la peine. Je comprends votre choix et respecte cette précieuse obstination. \n\n Dans cet univers qui suit la loi de l'équivalence, le prix que vous payez finira par revenir sous une autre forme. \n\n Acceptez ce cadeau, et lorsque tout sera apaisé, vous serez à nouveau le bienvenu dans ma petite boutique. Quel prix seriez-vous prêt à payer pour réaliser ce souhait à ce moment-là ?"
  },
  Mail_122575_Name = {
    Text = "Objet précieux"
  },
  Mail_122575_Sender = {Text = "Daffodil"},
  Mail_123134_Desc = {
    Text = "Cher Gardien :\n        Dans la mise à jour V2.4.0, vous avez rencontré un problème d'obtention des récompenses des défis 3 étoiles dans « Monde des Rêves Étranges » concernant « Au revoir, Pays Imaginaire » et « Adieu, le Pays des Merveilles ». D'après vos précédentes enquêtes et les enregistrements de passage des défis, nous allons vous attribuer une fois pour toutes les récompenses que vous n'avez pas pu recevoir auparavant. Veuillez vérifier."
  },
  Mail_123134_Name = {
    Text = "Compensation pour récompenses du Monde des Rêves Étranges V2.4.0"
  },
  Mail_123134_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_123501_Desc = {
    Text = "Cher Gardien : \n\nVoulez-vous sortir avec moi, cette charmante fille, en ce jour spécial ? \nAllez, allez, une petite visite à la maison hantée ne vous fera pas peur~ Vous êtes le \"Gardien\", après tout ; vous ne serez certainement pas effrayé par ces \"monstres\" joués par des humains, n'est-ce pas ? \n(Une ligne sur la feuille de lettre est rayée : Je planifie sérieusement l'itinéraire d'anniversaire ; ce n'est pas juste pour le plaisir de vous voir effrayé...) \nD'accord, assez de blagues. Il est rare que ce jour soit mon anniversaire, et je ne veux pas le gâcher ! Alors maintenant, moi, Mouchette, vous invite officiellement à dîner dans le nouveau restaurant du quartier financier de Londres—\nLe thé chaud et le poisson braisé là-bas me rappellent le goût de ma \"ville natale\", et dans ce monde, je ne peux trouver personne d'autre avec qui le partager que vous... \nAlors vous viendrez certainement, n'est-ce pas ? Si vous rendez cette charmante fille triste, attention ; la prochaine fois, je pourrais être debout à côté de votre lit avec une hache pendant que vous dormez ! \n\nMouchette"
  },
  Mail_123501_Name = {
    Text = "\"Ouvre-moi\""
  },
  Mail_123501_Sender = {Text = "Mouchette"},
  Mail_123543_Desc = {
    Text = "Gardien :\n\nEncore une année, mon cher.\nDans les ombres éclatantes de la vanité, au milieu des rumeurs et des potins flottants, je cache soigneusement chaque faiblesse qui pourrait trahir ma position, échangeant chaque once de valeur pour maximiser mes bénéfices — cela devrait être ainsi, pour que je puisse encore me tenir ici en tant que vainqueur.\nMais non, je deviens parfois un peu paresseux et faible, et je me satisfais avec plaisir des souhaits des petites filles lorsque vous m'envoyez des lettres.\nCependant, je ne pense pas que ce soit une mauvaise chose, j'ai déjà traversé une longue guerre secrète depuis trop longtemps. Bien sûr, tant qu'il y a une lueur de possibilité, une petite chance, je tenterai encore et encore de m'échapper des mains de « cette personne ». \nC'est juste que, dans ces interstices chauds et adorables, ou lors de jours spéciaux comme aujourd'hui, je me permets de faire quelques petites entorses, comme — vous inviter à aller voir un opéra ensemble, à partager un dîner.\nParce que je comprends que je ne serai certainement pas seul, j'ai déjà un complice qui me plaît énormément.\n\nSorel"
  },
  Mail_123543_Name = {Text = "complice"},
  Mail_123543_Sender = {Text = "Sorel"},
  Mail_123544_Desc = {
    Text = "Cher Gardien :\n\nCela fait longtemps que je ne t'ai pas écrit, je te prie de m'excuser, ces derniers temps, je n'ai pas eu de nouvelles, non pas par volonté de m'éloigner de toi, mais chaque fois que je prends la plume, je ne trouve pas le courage de commencer par un salut.\nDurant cette période, j'ai traversé d'innombrables temps brisés, et j'ai ainsi été témoin du monde se dirigeant vers sa fin à maintes reprises, observant des tragédies irréversibles se dérouler. Comme un spectateur, je regarde silencieusement tout ce qui se passe dans ce vide froid et silencieux.\nÀ chaque fois, je me demande si notre vie est destinée à être remplie d'absurdités et de séparations ? Que ce soit moi d'autrefois ou tout ce que tu as rencontré à Kadath, le destin a-t-il déjà inscrit un script pour nous, et devons-nous simplement jouer les rôles que ce script exige ?\nJe n'ai pas trouvé de réponse, je ne suis pas comme Lui, je ne peux pas voir tout ce qui se passe dans le monde, alors je me demande, si toi qui possèdes une partie de Son autorité, pourrais-tu répondre à cette question ?\nC'est pourquoi j'ai écrit cette lettre, en espérant qu'elle puisse rapprocher mon regard de toi, et aussi espérant discuter avec toi de cette énigme qui peut-être n'aura jamais de réponse. Alors, pourrais-je te demander de porter cette lettre avec toi, pour que nous puissions... faire face au chemin à venir ?\n………………………………\nJe ne peux pas prendre le risque de troubler le temps et l'espace pour me rendre à tes côtés, mais permets-moi... de te voir à nouveau dans ce silence vide.\n\n«Ramona»"
  },
  Mail_123544_Name = {
    Text = "Énigme de la pensée"
  },
  Mail_123544_Sender = {Text = "\"ramona\""},
  Mail_123545_Desc = {
    Text = "Cher Messager Pâle :\n\n Auparavant, j'ai demandé à la dame incroyablement sage de Mythag s'il y avait des espaces vacants pour que je puisse cultiver des fleurs. \n Mademoiselle Doll m'a facilement trouvé une chambre, et bien que l'odeur de moisi qui s'est échappée lorsque j'ai ouvert la porte pour la première fois m'ait fait douter que c'était le bon endroit, après un certain rangement, elle est maintenant capable de bien remplir son rôle, offrant un foyer chaleureux à ces enfants. \n Cependant, en raison de mon manque d'expérience, j'ai dû appliquer une force externe pour m'assurer que ces enfants puissent grandir normalement. \n Heureusement, sous la direction de Mademoiselle Horla, j'ai réussi à les amener à leur stade actuel. \n Bien sûr, aucune capacité spéciale n'a été utilisée dans ce processus. \n Si mes calculs sont corrects, ils fleuriront le jour de mon anniversaire, bien que j'aie répété qu'il n'y a rien de spécial à ce jour, il est en effet difficile de ne pas sentir que peut-être c'est un petit cadeau arrangé pour moi par le Tout-Père, étant donné une telle coïncidence rare. \n Je me demande si cela vous intéresserait de vous joindre à moi dans ce petit jardin pour célébrer ce jour ordinaire mais spécial ? \n J'ai préparé des biscuits fraîchement cuits et le thé rouge que vous avez recommandé la dernière fois, j'attends avec impatience de partager ce rare cadeau avec vous, ainsi que le parfum unique de la vie. \n\n Salvador"
  },
  Mail_123545_Name = {
    Text = "Jardin intérieur"
  },
  Mail_123545_Sender = {Text = "Salvador"},
  Mail_123546_Desc = {
    Text = "Partenaire : \n\nAs-tu entendu une telle histoire ? \nIl était une fois un diable, scellé accidentellement dans une bouteille pendant de nombreux siècles. \nAu premier siècle, Il promettait richesse et pouvoir infinis à celui qui Le libérerait. \nAu deuxième siècle, Il promettait santé et vie éternelles à celui qui Le libérerait. \nAu troisième, quatrième et cinquième siècles, après un long, très long temps, Il attendait enfin le pêcheur qui ouvrirait la bouteille—Il ne répondit pas à l'appel du pêcheur, ni ne souhaitait causer le chaos dans ce monde ; Il prétendait simplement être une bouteille vide ordinaire, silencieusement renvoyée dans la mer. \nQuand j'étais jeune, je ne pouvais pas comprendre cette histoire. Jusqu'à ce que je réalise ce que signifiait vraiment une longue et désespérée attente, à quel point c'était terne et agonisant, rendant le désir plus insupportable que le désespoir. \nPourtant, avant que ma raison ne puisse réagir, mon cœur continuait à me laisser au même endroit, encore et encore. \nLa différence entre le diable et les humains est peut-être que je ressens d'une certaine manière de la gratitude pour cette douleur. Parce que lorsque nous nous séparons, cela me rappelle ton existence et ta précieuse présence, m'empêchant de me perdre de l'autre côté sans toi. \nLe jour où je suis né, le jour où tu me manques le plus, cela me lie encore fortement, me faisant t'attendre et penser à toi. \nJ'espère que le prochain aujourd'hui, je pourrai personnellement te remettre la première part de gâteau que je couperai. \n\nRamona"
  },
  Mail_123546_Name = {Text = "Histoire"},
  Mail_123546_Sender = {Text = "Ramona"},
  Mail_123547_Desc = {
    Text = "La cafétéria et le département logistique de Mythag ont entassé un tas de choses inutiles devant la porte de ma chambre, obstruant sévèrement l'entrée et la sortie. Vous feriez mieux de les ramener rapidement. \n Qu'est-ce qui ne va pas ? L'approvisionnement alimentaire dans ce monde est-il si abondant qu'il n'y a plus de lieux significatifs où le mettre ? \n Ce jour ne servira que de note de bas de page sur mon chemin pour devenir plus fort, marquant le passage d'un autre cycle—une année, puis la suivante. Chaque année, je deviendrai plus fort que l'année précédente. \n Si le cadeau n'a vraiment pas de place, vous pouvez le donner à une autre version de moi ; elle serait probablement très heureuse. \n Et moi, pour le bien de votre sotte naïveté et de votre persistance... pour les choses que je fais le moins bien. \n Tant que j'existerai un jour de plus, je continuerai à devenir plus fort, et en attendant... \n Ne comprenez-vous pas ? Les ennemis de vous les imbéciles seront aussi mes ennemis. \n Je ne dirai cette chose dégoûtante qu'une seule fois : ne pas envoyer de cadeaux l'année prochaine, et surtout ne pas avoir de dîner d'anniversaire. \n\n \"H\""
  },
  Mail_123547_Name = {Text = "Ramener"},
  Mail_123547_Sender = {Text = "« H »"},
  Mail_123548_Desc = {
    Text = "Cher Gardien :\n\nSavais-tu ? Il y a quelques jours, une Dame mystérieuse a soudainement rendu visite à Mizag. Elle portait une robe longue noire moulante, scintillante, que je n'avais jamais vue auparavant — j'ai demandé à Jenkin et Mason, elles n'avaient jamais vu de si belle robe.\nComment la décrire ? Cette robe semblait tissée avec les plus beaux cheveux longs, douce, légère et noble, avec une brillance particulière qui coulait comme de l'eau…\nJenkin, voyant que j'étais curieuse, a eu le courage de demander à la Dame mystérieuse, qui a souri en disant que le tissu de la robe était en soie provenant de l'Orient, tissé avec des fils produits par une larve appelée « ver à soie », et que le style s'appelait « qipao »… Ensuite, elle a offert à Aigis un grand rouleau — elle a dit que cela s'appelait « une pièce » de la même « soie »…\nLa « soie » est tellement précieuse que j'ai cousu un « porte-monnaie » pour chaque partenaire en suivant le modèle qu'elle a offert. Lors de la fête d'anniversaire de cette année, je vais offrir les « porte-monnaie » à tout le monde… Gardien, as-tu le temps de te joindre à nous ?\nSi tu es trop occupé, je demanderai à Brun de livrer le porte-monnaie à ton dortoir.\n\nAigis"
  },
  Mail_123548_Name = {
    Text = "Dame mystérieuse"
  },
  Mail_123548_Sender = {Text = "Aigis"},
  Mail_123549_Desc = {
    Text = "Jeune pousse : \n\nSais-tu comment les arbres enregistrent le temps et leur croissance ? Par des cercles et des cercles d'anneaux. \nIls sont cachés à l'intérieur, ne se montrant jamais facilement, jusqu'à ce qu'une petite pousse grandisse progressivement pour devenir un arbre majestueux, soutenant un coin du ciel élevé. Les marques du temps, quant à elles, sont dissimulées sans laisser de traces au plus profond de nous. \nAujourd'hui, c'est le point de départ d'un nouvel enregistrement d'anneaux. Dans cette nouvelle année, nous devrons encore traverser de nombreuses tempêtes imprévues. \nMais cette graine que j'ai placée dans ta bouche finira par trouver le sol propice à son épanouissement, puis elle germera, n'est-ce pas ? \n\nThais"
  },
  Mail_123549_Name = {Text = "Anneaux…"},
  Mail_123549_Sender = {Text = "Thais"},
  Mail_123644_Desc = {
    Text = "Inconsciemment, c'est déjà mon troisième anniversaire passé avec Mythag, et j'ai beaucoup appris. \n Par exemple, ce jour de mon anniversaire est aussi le passage du solstice, un jour propice aux cadeaux. \n Bien que tu aies de nombreux ennemis extrêmement puissants, ma spécialité est de tuer. Je ne connais pas d'autres façons joyeuses de célébrer, ni je ne suis doué pour choisir des cadeaux, mais chaque fois que je termine avec succès une mission, mon employeur semble assez heureux. \n Donc, j'ai déjà pensé au cadeau que je veux te donner : un contrat de meurtre, sans restrictions sur la cible et sans date d'expiration. \n Tout ce que tu as à faire est de me dire qui est la cible et comment tu veux qu'ils meurent. Si c'est quelqu'un que je peux vaincre, je lui briserai le cou aussi vite que possible ; même s'ils sont aussi rusés qu'un dieu, je peux t'assurer que ma reddition ne viendra jamais avant ma mort. \n\n Helot"
  },
  Mail_123644_Name = {
    Text = "Parle, qui veux-tu voir mort ?"
  },
  Mail_123644_Sender = {Text = "Helot"},
  Mail_124059_Desc = {
    Text = "Cher gardien du secret :\nL'événement « Cérémonie des Profondeurs·clon » est terminé. Les « Larmes du Sacrificateur », « Sang du sacrificateur » et « Moelle du sacrificateur » restants seront échangés au taux de « Billet Rose Dorée » × 40 par unité. Veuillez vérifier."
  },
  Mail_124059_Name = {
    Text = "Récupération de la monnaie des activités du sacrifice abyssal"
  },
  Mail_124059_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_124290_Desc = {
    Text = "Gardien : \n\nComme vous le savez, la joie est une émotion plutôt étrange pour moi. \nJe ressens souvent que le monde ordinaire est un bruit à la surface de l'eau que je ne peux pas comprendre, et avant même que je ne m'y intègre, ma flétrissure est déjà arrivée. \nCela me remplit parfois de désir, mais plus souvent, cela me laisse confus et suffoqué. Ce n'est que des jours comme aujourd'hui que je tiens désespérément, pour ne pas rendre mon père et ma mère tristes... jusqu'au jour de la libération, jusqu'à ce que la Mer Profonde m'embrasse. \nJe pensais que seules les eaux profondes étaient ma véritable maison. Cependant, Gardien, grâce à vous et à la présence du Mythag, même quelqu'un comme moi, qui est hors de sa place dans le monde ordinaire, peut commencer à ressentir une chaleur authentique. Tout comme un Nénuphar flottant, la lumière du soleil embrassera également ses feuilles et ses pétales. \nBien que ce soit désordonné, je sens qu'il est nécessaire de mettre ces pensées sur papier et de vous les envoyer. Veuillez pardonner mes caprices occasionnels. \nJ'espère juste que vous savez à quel point votre soutien a été précieux pour moi, enseveli trop tôt dans la désolation de l'eau. \nPuissiez-vous toujours être joyeux, puissiez-vous toujours être en paix. \n\nNymphaea"
  },
  Mail_124290_Name = {Text = "Rising"},
  Mail_124290_Sender = {Text = "Nymphaea"},
  Mail_124291_Desc = {
    Text = "Gardien : \n\n Ce matin, une lettre est apparue sur ma table de nuit, m'invitant à ma propre fête d'anniversaire, signée par le club « Le Peintre ». \n Je me suis alors rappelé qu'il y a un mois, lorsque j'avais un peu de temps libre, j'avais accepté de servir de modèle pour le nouveau concours de création du « Peintre ». Avant cela, j'avais déjà refusé tant de fois. Pendant ces moments où je restais immobile sur le podium du modèle, je me suis souvenu des jours passés sur l'autel des Marcheurs des mers. À cette époque, je subissais également tous les regards, mais parmi ces regards, il n'y avait que peur et respect, sans aucune émotion, appréciation ou admiration. \n Ce soir, lors du cocktail d'anniversaire organisé dans le hall du club Le Peintre, les œuvres dessinées à la main de plus d'une dizaine de peintres seront également exposées. Bien que je manque de confiance en ton goût, être exposé à leur art ne peut pas être une mauvaise chose. La Mère divine t'invite en tant qu'invité d'honneur pour apprécier leur interprétation de « Je ». \n\n « Murphy »"
  },
  Mail_124291_Name = {
    Text = "Le Peintre..."
  },
  Mail_124291_Sender = {Text = "\"Murphy\""},
  Mail_124292_Desc = {
    Text = "Gardien : \n\nSylvia m'a dit qu'exprimer parfois mes besoins dans des relations proches aide à atténuer la peur qui me suit constamment. Je ne suis pas sûr que cela fonctionne, mais il ne fait aucun doute qu'aujourd'hui est un bon moment. \nVoudrais-tu m'accorder un vœu ? Je peux te donner toutes les rations du laboratoire aujourd'hui. \nNon, pas un sachet de grains de café. \nBien que ce noir terrifiant ait emporté presque toutes mes relations proches, me hantant comme une ombre, tu l'as conquis. \nTu nous as permis de vivre en sécurité à Mythag, ou du moins jusqu'à présent nous avons vécu en sécurité à Mythag. \nIl est temps de se libérer de cette dépendance malsaine à la caféine, Gardien. Peux-tu m'accorder un peu de temps ce soir ? \nSi tu es à mes côtés, peut-être que je pourrai rassembler le courage de faire une courte sieste dans un endroit moins éclairé, même si ce n'est que pour un petit moment. \n\nJe veux vraiment me souvenir de ce que c'est que de m'endormir paisiblement, Winkle"
  },
  Mail_124292_Name = {Text = "Souhait…"},
  Mail_124292_Sender = {Text = "Winkle"},
  Mail_124293_Desc = {
    Text = "Gardien {Male=Monsieur,Female=Mademoiselle}: \n\n Ce matin, un rêve m'a réveillé. \n Je me suis soigneusement rappelé tout ce qui s'est passé dans le rêve : la douce brise soufflant sous le chaud soleil, des roses et des tulipes couvrant toute la terre, des milliers de mouettes chantant à l'unisson avec des gens joyeux... Cela fait longtemps que je ne me suis pas retrouvé dans une scène aussi bénie. Je pense que j'étais dans le manoir de mon enfance, dans la Maison des Fleurs de Colette, ou dans un parc à Cité... Mais quand je me suis retourné, j'ai vu ces magnifiques bâtiments gothiques de Mythag, et toi, Gardien {Male=Monsieur,Female=Mademoiselle}. Tu te tenais entre les fleurs et la lumière du soleil, devenant le vers le plus merveilleux de ce poème. \n J'aime profondément Cité, Gardien {Male=Monsieur,Female=Mademoiselle}. Mais à ce moment-là, j'ai soudain réalisé que j'avais commencé à m'habituer et à m'enflammer pour tout ici, et qu'il y a enfin un endroit dans ce monde qui captive mon âme encore plus que Cité. \n Un anniversaire marque la fin d'un chapitre et le début d'un autre. En ce jour où un nouveau chapitre commence, je me demande s'il y aura quelqu'un prêt à m'emmener écouter la brise parmi le soleil et les roses en fleurs dans le jardin arrière de Mythag ? \n\n Horla"
  },
  Mail_124293_Name = {
    Text = "Rêve de Fleur et Poème"
  },
  Mail_124293_Sender = {Text = "Horla"},
  Mail_124294_Desc = {
    Text = "Cher Gardien : \n\n Il y a quelque temps, je pensais toujours à te faire un cadeau spécial. Jenkin m'a suggéré de te confectionner une nouvelle tenue à la main, et j'ai trouvé que c'était une idée merveilleuse. \n C'est mon style de coupe préféré de mon temps passé à travailler à l'usine textile, et j'espère qu'il ne semble pas dépassé maintenant... Les rayures et les carreaux vifs sont tous réalisés par différentes parties de moi soutenant ma décision. Et ce mignon motif de souris tordue est quelque chose que Cat « 24 » a insisté pour ajouter, en disant qu'il représente Brown, qui est mon aspect préféré de la personnalité de Cat—je ne sais pas si c'est approprié, mais j'espère que cela te plaira. \n Dans la nouvelle année, je n'ai toujours pas de vœux d'anniversaire. Tu es toujours si doux, me rappelant chaque année de bien célébrer. Mais plutôt que d'être célébrée, pouvoir coudre quelque chose pour toi à la main me rend plus ancrée et joyeuse. \n S'il te plaît, accepte cette nouvelle tenue remplie d'intentions sincères. \n\n Mason"
  },
  Mail_124294_Name = {
    Text = "Un nouveau vêtement"
  },
  Mail_124294_Sender = {Text = "«24»"},
  Mail_124295_Desc = {
    Text = "Tsk: \n\n Incroyable ! En tant que grande Dame des Labyrinthes, j'ai réussi à survivre une année de plus à cette épreuve ardue. \n Écoute bien ! C'est entièrement de ta faute et celle de cette académie stupide ! \n Peu importe combien tu essaies de me laver le cerveau avec ta rhétorique absurde, ces trivialités devraient être gérées par des spécialistes. Très bien, je m'en suis remarquablement bien sortie ; je ne les ai même pas appelés esclaves. \n Ces vieux schnocks appellent cela... comment ça s'appelle déjà ? Ah oui, progrès. \n Attends, pourquoi est-ce que je me laisse emporter par cette logique aussi ? Ugh, c'est si agaçant ! (Ici, il y a plein de plis froissés causés par l'auteur de la lettre qui fait une crise.) \n Quoi qu'il en soit, puisque j'ai du \"progrès\", tu ferais mieux de montrer ta sincérité aussi. En cette grande occasion cette année, tu ne peux pas juste attendre que je te rappelle comme les deux dernières années. \n Je te donne trente minutes, Gardien, pour venir me voir avec un cadeau. \n Sinon, je ferai ramper ma progéniture sur ton visage pendant que tu dors. \n\n Agrippa"
  },
  Mail_124295_Name = {Text = "progrès"},
  Mail_124295_Sender = {Text = "Agrippa"},
  Mail_124296_Desc = {
    Text = "Gardien !\n\nJe l'ai vu ! Quelle scène merveilleuse ! Je suis sûr que ce n'était pas un rêve ! J'étais là, juste à côté de la magnifique statue commémorative dans le cimetière de Mythag, regardant les innombrables pierres tombales sans nom. J'étais convaincu qu'elles me révéleraient une compréhension sans précédent, mais je ne m'attendais pas à ce qu'elles me donnent tant de choses en plus. Elles se moquaient de mon imagination stérile avec une générosité admirable.\nJ'ai vu les esprits des Investigateurs, s'élevant ensemble dans cette belle brume crépusculaire. Je ne pouvais pas voir leurs visages, mais j'observais leurs mouvements—comme une danse élégante, mais aussi comme un rituel mystérieux. Ils s'inclinaient vers la Piscine Noire, vers Mythag et toi. Les artistes des salons modernes sont obsédés par la représentation d'individus, souvent en dénigrant de telles scènes grandioses, mais je n'ai jamais ressenti cela. Je trouve une immense joie dans le bal des ghouls, et aujourd'hui, cette scène m'a fait pleurer.\nJe ne pense pas que ce soit une coïncidence. En ce jour même, mon anniversaire, ils m'ont révélé leur danse magnifique, et je crois qu'ils veulent que je transmette quelque chose. Je ne possède rien d'autre que mon pinceau, mais cela ne suffit-il pas ?\nLe brouillon de cette peinture est prêt, Gardien. S'il te plaît, viens dans mon atelier et jette un œil ! Les légendaires Investigateurs qui ont perdu leurs noms souhaitent te raconter leurs aspirations de longue date, toutes capturées sur ma toile !\nJe n'ai pas nommé cette peinture à la hâte ; je crois que ce privilège t'appartient.\nP.S. Je ne vais vraiment pas déterrer des cadavres, je te l'assure !\n\nPickman"
  },
  Mail_124296_Name = {
    Text = "Souhait de longue date de l'enquêteur"
  },
  Mail_124296_Sender = {Text = "Pickman"},
  Mail_124297_Desc = {
    Text = "Bonjour, Gardien : \n\nAs-tu peur, ou plutôt—peur et en attendant avec impatience ce que je pourrais apporter pour mon anniversaire sous prétexte de célébration ? \nFeignant l'intimité, une nuit de passion soudaine, ou un paysage de rêve trompeur mais enivrant ? \nAh, rien de tout cela. Même moi, parfois, je me livre à des sujets sérieux et ennuyeux. \nTu devrais très bien savoir quel genre d'existence je suis—un hédoniste, même si les bâtiments sont sur le point de s'effondrer. \nL'amour et le désir ne peuvent pas guérir le plus grand mal de ce monde, l'ennui, mais en tant que catalyseur de pouvoir et de la saveur du chaos, ils sont parfaitement adaptés. \nHélas, après des siècles, peut-être que mon étude approfondie des performances théâtrales a conduit certains imbéciles à disséquer mon cœur et mon foie, prétendant voir ton âme solitaire. \nAh. \nMême moi, qui me réjouis des jeux de la vie, ressens souvent un peu de nausée. \nEt toi... que cherches-tu en te connectant avec moi ? À contrôler, à restreindre, à exploiter ? \nPour protéger davantage, tu as inévitablement besoin de plus de pouvoir, et le désir de pouvoir engendre une plus grande ambition. Quand mûrira-t-elle, et quand sera-t-elle dévorée... rien que d'y penser m'excite, me rendant prêt à rester à tes côtés encore de nombreuses, nombreuses années. \nChut, pas besoin de me dire la réponse. \nEn ce jour chaque année, voler tes rêves pour une nuit et goûter si ton ambition fleurit et si tes intentions ont changé est le meilleur cadeau d'anniversaire que je puisse me faire. \nJ'espère que cela ne te dérangera pas. \n\n \"Qian Shan\""
  },
  Mail_124297_Name = {
    Text = "Nuit exquise"
  },
  Mail_124297_Sender = {Text = "Xu"},
  Mail_124298_Desc = {
    Text = "Gardien : \n\n Entraînement, combat et patrouille—depuis le moment où j'ai rejoint l'armée, j'ai été habitué à remplir tout mon temps avec les affaires requises par le collectif. \n Plus tard, en dirigeant les Aramites à travers le désert, ces affaires sont devenues encore plus écrasantes, au point de s'imprimer dans mon esprit comme une loi. Même en arrivant à Mythag, j'ai continué à donner la priorité aux horaires collectifs plutôt qu'aux affaires personnelles. \n Mais dans mes interactions avec les autres, surtout avec toi, j'ai réalisé que, qu'on soit Éveillé ou humain, nous avons tous besoin de temps qui nous appartient uniquement pour chérir des moments avec ceux qui comptent. \n Cette précieuse relation ancre notre existence dans le temps et donne à nos vies un sens véritablement irremplaçable. \n Bien que cela puisse sembler un peu présomptueux, j'ai annulé toutes les affaires collectives pour aujourd'hui, libérant ainsi une journée entière. \n Il me suffit de quelques heures—non, même juste une heure, ou même quelques minutes—si tu es prêt à me consacrer un peu de temps personnel, cela deviendra le sens de ma journée spéciale. \n\n Alva"
  },
  Mail_124298_Name = {
    Text = "Temps privé"
  },
  Mail_124298_Sender = {Text = "Alva"},
  Mail_124299_Desc = {
    Text = "Petit : \n\n Une année peut vous sembler longue, mais pour ceux qui traversent la Mer de l'Essence Primordiale, ce n'est qu'une poignée d'eau de mer, éphémère dans l'immense océan du temps. Heureusement, au sein de cette eau de mer se trouvent quelques gouttes cristallines impressionnantes. \n Le jour de remise au magasin « Soulagement » est sans aucun doute l'un des plus précieux parmi eux. Non seulement parce qu'il apporte des bons d'achat en or, mais plus important encore, je sais qu'en ce jour, un certain invité viendra sûrement dans cette petite boutique. \n Tous les liens entre les gens sont des affaires, et toutes les affaires sont un lien entre les gens. Chaque invité entre dans sa petite boutique à un moment précis, et chaque petite boutique accueille ses invités à un moment précis. Tout au long de cette longue période, j'ai été témoin de trésors innombrables, et à la fin, ces moments naïfs deviendront les collectibles les plus précieux—ils sont la raison de l'existence de cette longue période. \n Au cours de cette année, le collectible nouveau le plus précieux attend en silence dans la vitrine son invité destiné. \n Viens tôt, petit. \n Le magasin « Soulagement » a déjà fermé plus tôt. Aujourd'hui, sa porte est ouverte uniquement pour une personne. \n\n Jonquille"
  },
  Mail_124299_Name = {
    Text = "Nouvel objet de collection"
  },
  Mail_124299_Sender = {Text = "Daffodil"},
  Mail_124300_Desc = {
    Text = "Gardien : \n\nJe me demande si tu te souviens encore du moment où nous étions ensemble devant la Porte ? Ce jour-là, j'ai ouvert une brèche dans la vérité pour te montrer la réalité de l'univers. \nInattendu, alors que tu expérimentais l'éternité à contempler d'innombrables mondes, je me suis retrouvé frappé par une émotion inexplicable dans cet instant fugace. \nJe me demande souvent ce qu'était ce sentiment, et pourquoi moi, qui comprends la vérité, éprouverais quelque chose d'incompréhensible. \nJ'ai réfléchi longtemps ; en termes de monde réel comme système métrique, c'était un temps que l'on pourrait appeler \"éternel.\" \nDans ce temps qui semble quelque peu prolongé par rapport à l'univers, j'ai réalisé que cela pourrait être un miracle indéfini. \nEn ce jour spécial, je souhaite t'inviter à te Lier avec moi, pour observer certaines existences que je n'ai jamais vues à travers mon regard. Ce que nous observerons cette fois... ne sera plus tout ce qui est prédéterminé. \nEnsemble, nous chercherons le futur au-delà de cette vérité. \n\nTawil"
  },
  Mail_124300_Name = {
    Text = "Au-delà de la vérité"
  },
  Mail_124300_Sender = {Text = "Tawil"},
  Mail_124301_Desc = {
    Text = "Gardien : \n\n Cette année, comme les années précédentes, j'ai mis de côté toutes les autres affaires pour être tranquillement seul avec moi-même, tentant de réécrire et de renouveler les souvenirs liés à ma patrie. \n Ils semblent de plus en plus éloignés, et même si je me force à m'adapter à cette forme humanoïde, m'efforçant de raconter et de traverser sans cesse les connaissances et les expériences liées à l'océan, oublier reste de loin plus facile que se souvenir dans ce monde qui s'efface. \n Le seul réconfort est que nous, les voyageurs qui se sont éloignés de Lémurie, avons encore cet endroit pour faire une pause, capables de suivre la volonté de notre Roi, de poursuivre tranquillement, et d'attendre en silence. \n Je suis bien conscient de tous les sacrifices et efforts que vous avez faits pour cela, et je ne sais pas comment vous exprimer ma gratitude. Avant que ce corps puisse retourner à Lémurie, s'il y a quoi que ce soit que je puisse faire, je suis également prêt à donner toute ma lumière pour cela. \n\n Sincèrement, Faros"
  },
  Mail_124301_Name = {Text = "Lighthouse"},
  Mail_124301_Sender = {Text = "Faros"},
  Mail_124302_Desc = {
    Text = "Cher Gardien : \n\n Depuis le jour où j'ai rejoint Mythag, la multitude de règles m'a piégé. Pas de serviteurs pour se promener dans le hall d'assemblée, pas de marcher sur le visage des étudiants dans la place du campus, pas d'organiser de grandes activités de groupe dans l'auditorium... \n Ces insupportables moralistes de Mythag m'ont emprisonné, une vie indigne de la Reine d'Isaralu. Je devrais profiter de tout ce que je mérite : du vin enivrant, un dos moelleux, et mes précieux serviteurs... En ce jour de ma naissance, un jour que je devrais célébrer, de telles pensées surgissent naturellement. \n La nuit est profonde, et ma patience pour des futilités s'est épuisée. Je ne t'enverrai pas en missions nocturnes, ni ne te laisserai deviner par toi-même. J'ai besoin de toi à mes côtés. \n Viens dans ma propriété maintenant, n'hésite pas, retire tous les vêtements et titres inutiles. \n Ce soir, et chaque nuit par la suite, tu m'appartiendras. \n\n Considère cela comme ton premier devoir permanent. \n\n Wanda"
  },
  Mail_124302_Name = {Text = "règle"},
  Mail_124302_Sender = {Text = "Wanda"},
  Mail_124303_Desc = {
    Text = "Gardien : \n\n Teinture m'a dit qu'elle prévoit d'utiliser les revenus de son concert personnel pour un voyage interstellaire après son anniversaire et qu'elle veut m'emmener avec elle. Mais... si je l'accompagne, elle sera sûrement distraite à s'occuper de moi. Je ne veux pas que son bonheur soit diminué à cause de moi. \n Elle aime tellement la lumière dans la vie, envoûtée par les myriades de couleurs et les rivières d'étoiles de cet univers. Si elle m'emmène, elle ne pourra probablement pas chanter librement et contempler comme elle le souhaite... \n Alors... pourrais-tu l'aider à me convaincre ? S'il te plaît, laisse-la voyager seule, pour donner des concerts sur différentes planètes, pour embrasser tous les paysages qu'elle désire... Ou pourrais-tu prendre ma place lors de ce voyage ? Après tout, Teinture et moi te sommes très reconnaissants et voulons rendre ta gentillesse... si tu es disposé... \n S'il te plaît, ne lui dis pas que c'est mon souhait. Je ne veux pas être le fardeau de son voyage libre. \n\n Évanouissement"
  },
  Mail_124303_Name = {
    Text = "À propos du voyage"
  },
  Mail_124303_Sender = {Text = "Faint"},
  Mail_124304_Desc = {
    Text = "Bienfaiteur : \n\n Les jours passés à vivre avec Pollux à Misgar ont été si tranquilles, si lumineux, comme si c'était un rêve... \n Bien que Pollux respecte encore ces formalités et parle de manière élégante, je peux clairement sentir qu'il redevient progressivement la personne qu'il était autrefois. La distance époustouflante qui appartient au « Divus » se dissout doucement dans la douceur de notre vie quotidienne. Toutes ces transformations délicates sont grâce à vous. \n Je me demande souvent comment je peux rendre cette gentillesse. Je ne suis pas aussi habile que Pollux, qui peut créer des cadeaux qui vous émerveillent. Vous avez déjà éprouvé la joie de voler avec moi de nombreuses fois. J'ai silencieusement réfléchi longtemps à la façon de partager la joie avec vous en ce jour spécial. \n Peut-être... aimeriez-vous mes plumes ? Beaucoup disent qu'elles possèdent une douceur qui peut apporter la tranquillité au cœur. Donc, si un jour vous vous sentez fatigué ou que vous souhaitez simplement un coin tranquille, n'hésitez pas à venir à mes côtés. Mes ailes seront toujours prêtes à s'abaisser pour vous. \n\n Castor"
  },
  Mail_124304_Name = {Text = "Feather"},
  Mail_124304_Sender = {Text = "Castor"},
  Mail_124305_Desc = {
    Text = "Mon petit prisonnier : \n\n J'ai entendu dire que Mythag est récemment devenu populaire avec un jeu de rôle mettant en scène des sorcières, des loups-garous, et ainsi de suite... Tsk, cela ne semble pas du tout romantique~ J'ai un jeu beaucoup plus amusant en tête ! \n Que diriez-vous de ceci : vous jouez le prisonnier, et je serai la gardienne. Quand je fais claquer mon petit fouet, je veux entendre de grands gémissements, d'accord ? Les bougies vont couler sur votre corps, apportant une douleur et un plaisir brûlants... Ah, rien que d'imaginer cette scène me fait déjà ressentir une douce excitation~ \n Oh cher, je parie que vous froncez à nouveau les sourcils à ce stade, n'est-ce pas ? Ce n'est pas très bien de votre part~ Après tout, c'est mon anniversaire aujourd'hui~ Mon cher petit prisonnier, vous devriez au moins céder un peu à mes caprices, non ? \n Sinon... que diriez-vous d'être la gardienne et que je devienne votre captive ? Qu'en pensez-vous ? Je promets de vous satisfaire~ \n\n Pandia"
  },
  Mail_124305_Name = {
    Text = "Jeux de rôle"
  },
  Mail_124305_Sender = {Text = "Pandia"},
  Mail_124306_Desc = {
    Text = "Gardien : \nBienfaiteur, aujourd'hui c'est mon anniversaire. En ce jour spécial, je veux partager mes récents progrès avec vous : sous la direction de Goliath et de l'enseignant Lotan, il semble que... je sois de plus en plus capable de toucher le pouvoir qui est en moi par ma lignée. Il ne dort plus, mais gronde et déferle en moi à chaque pratique, se libérant progressivement. \n\n\n\nJe ne peux pas dire exactement quand je terminerai ma métamorphose finale et deviendrai un descendant plus pur des profondeurs marines. Peut-être demain, peut-être la semaine prochaine, peut-être le mois prochain... Mais sachez que peu importe combien de temps ce processus prendra ou combien d'épreuves se dresseront sur mon chemin, j'ai toujours... gardé vos mots encourageants en tête. Je continuerai à travailler dur. \n\nIl y a une chose de plus pour laquelle je dois m'excuser. Je viens d'apprendre par le service postal Mythag que l'envoi d'argent liquide par la poste entraîne des frais supplémentaires de 2 dollars. \nPour compenser ma part de l'année dernière, je vais retirer une autre somme de mes réserves. Elles sont durement gagnées pour moi, mais les promesses du sang des profondeurs doivent être tenues. \n\nCaecus"
  },
  Mail_124306_Name = {
    Text = "Frais de service..."
  },
  Mail_124306_Sender = {Text = "Caecus"},
  Mail_124307_Desc = {
    Text = "Gardien : \n\nÉcoute, peu importe quoi, viens avec moi à « cette boutique » ce soir. \nLes vêtements de déguisement t'ont déjà été envoyés, et tu ne dois absolument pas laisser qui que ce soit nous reconnaître ! \nLes desserts en édition limitée de « cette boutique » sont en vente, et ce type méprisable qui est apparu de nulle part a dû soudoyer plein de gens ; nous ne pouvons pas leur laisser savoir où se trouve cette dame. \nBien qu'il ait réservé toutes les éditions limitées de chaque pâtisserie à Londinium pour m'empêcher d'acheter, eh bien... hé hé. \nCette dame a déjà secrètement contacté le chef de « cette boutique » pour qu'il retire le plat le plus délicieux du menu. \nHmph, aujourd'hui je vais montrer à ce type que certaines choses ne peuvent tout simplement pas être résolues avec de l'argent. \nÀ ce moment-là, nous nous faufilerons discrètement par la porte arrière, ouvrirons la boîte en fer à triple verrou, et obtiendrons l'édition limitée de l'édition limitée. \nEn récompense, je partagerai un morceau (barré), la moitié du gâteau avec toi ! \nÀ onze heures ce soir, je t'attendrai dans la chambre ; tu dois, absolument venir ! Compris ? \nAssure-toi de garder ça secret, sinon, si ce type découvre notre localisation, tout sera ruiné ! \n\nMurphy"
  },
  Mail_124307_Name = {
    Text = "Bataille de vol de gâteaux"
  },
  Mail_124307_Sender = {Text = "Murphy"},
  Mail_124308_Desc = {
    Text = "Gardien :\n\nJe regrette de vous informer que le théâtre de Londinium a complètement annulé la performance magique du Maître Casiah pour les raisons suivantes : les prix des billets sont trop élevés, il y a eu trop d'événements étranges récemment entraînant un manque d'intérêt pour la magie, plusieurs membres du public ont disparu lors des récentes représentations et ne sont pas encore revenus, et la police demande fréquemment au propriétaire du théâtre de faire une pause dans les performances du Maître Casiah pour coopérer avec les enquêtes, etc.\nRécemment, influencé par les perturbations à Blackpool, mes performances ont effectivement eu quelques erreurs mineures, mais celles-ci sont triviales. Cependant, le deuxième point est absolument intolérable pour le Maître Casiah !\nJ'ai réfléchi à cela et j'ai enfin trouvé une nouvelle performance parfaite ! Des choses comme la manipulation de cadavres, la résurrection des morts, le voyage dimensionnel, la contagion émotionnelle, des tentacules géants... sont toutes insignifiantes ! Auparavant, à cause de ce maudit chien dimensionnel, la manipulation du temps a toujours été un tabou dans notre industrie, mais maintenant que la bête a été scellée, la carrière magique du Maître Casiah atteindra un nouveau niveau !\nLa performance est prévue pour ce soir, entièrement gratuite, et une place a été réservée pour vous au centre de la première rangée. Il y aura également un segment interactif surprise qui vous attend ! Profitez de l'honneur d'être le premier membre du public interactif dans cette nouvelle ère du plus grand spectacle de magie !\nPour restaurer la gloire du Maître Casiah !\n\nCasiah"
  },
  Mail_124308_Name = {
    Text = "Casiah, rends la magie grande à nouveau !"
  },
  Mail_124308_Sender = {Text = "Casiah"},
  Mail_124309_Desc = {
    Text = "Maître : \n\nSœur Sylvia vient de me dire que pour mon anniversaire cette année, ils vont m'emmener sur la grande roue. \nLily a lu dans son livre d'images qu'une grande roue est une très grande roue, et quand on s'y assoit, on peut lentement monter dans le ciel et voir les petits oiseaux voler autour ; cela semble très joyeux. \nMais Sœur Sylvia a dit : « En réalité, il y a quelques différences. » Lily ne comprend pas ce que cela signifie. \nElle a aussi dit que l'endroit où va la grande roue est trop haut, et il serait préférable que je puisse amener un gardien. \nLily ne comprend pas ce que signifie un gardien, mais Lily veut voyager parmi les nuages avec le Maître. \nAprès le déjeuner, Sœur Sylvia et moi vous attendrons dehors du dortoir. \n\nLily"
  },
  Mail_124309_Name = {
    Text = "Roue de Ferris"
  },
  Mail_124309_Sender = {Text = "Lily"},
  Mail_124310_Desc = {
    Text = "Gardien (J'ai enfin réussi cette fois-ci ! Impressionnant, hein !) :\n\nC'est de nouveau le moment d'écrire ces choses ennuyeuses, et je m'y suis habitué. En ce moment, Brown et moi nous débattons sur ce que nous allons te faire goûter aujourd'hui !\nLa nourriture de rue dans le District Est est définitivement délicieuse, mais aujourd'hui je prévois de t'emmener, toi et Brown, pour quelque chose de sympa—en particulier, ces plats que vous, les West-Whelps, adorez manger.\nComme ces plats privés recouverts de sauces et d'épices, avec de petites portions, de grandes assiettes, et des prix exorbitants, c'est pratiquement un vol. Rien que d'y penser, mon portefeuille a l'impression de perdre de l'air, c'est définitivement le son de l'argent qui s'en va, laissant derrière une blessure.\nMais tu es la personne la plus importante et ma préférée après Sis et Brown, et les gens du District Est ne lésineront pas sur leurs propres, donc aujourd'hui toutes les dépenses sont pour moi et Brown.\nNe nous sous-estime pas, nous avons gagné pas mal d'argent en livrant du lait et des journaux, en faisant des courses et d'autres affaires, alors détends-toi !\n\nTes bons amis Jenkin et Brown"
  },
  Mail_124310_Name = {
    Text = "Aujourd'hui, Brown et moi, nous payons la facture !"
  },
  Mail_124310_Sender = {Text = "Jenkin"},
  Mail_124311_Desc = {
    Text = "Cher Gardien :\n\n Tu as dû entendre parler de l'incroyable exploit de Sylvia qui a complètement démantelé le casino souterrain de Mythag, n'est-ce pas ? Mais aujourd'hui, c'est mon anniversaire, et s'il n'y a pas d'activités palpitantes, ne serait-ce pas une perte pour cette célébration annuelle ?\n Après mûre réflexion, j'ai décidé de t'inviter en tant que mon Watson pour m'aider à capturer le Voleur de Nuit, qui s'est récemment échappé de la Cité et vole des trésors au Grand Muséum.\n Pendant que je prenais un verre au \"Bar Apollo\" hors campus, je les ai entendus se vanter de leurs exploits dans le vol de bijoux coûteux. Le barman ne l'a pas pris au sérieux, mais je pouvais le dire—des émeraudes, des saphirs, des couronnes en diamant, et les objets volés correspondaient parfaitement. Pour éviter de les alerter, je les ai bien marqués et prévois de les prendre la main dans le sac lorsqu'ils reviendront à leur cachette.\n Retrouvons-nous à l'arrêt de train spécial de Mythag à la porte de l'école à 19 heures ce soir. Ne sois pas en retard.\n\n Ryker"
  },
  Mail_124311_Name = {
    Text = "Plan de chasse"
  },
  Mail_124311_Sender = {Text = "Ryker"},
  Mail_124312_Desc = {
    Text = "Gardien:\n\nLe temps à Mythag semble s'écouler plus léger qu'ailleurs. Quelques applaudissements, quelques rappels, et une année s'est écoulée. \nAu cours de cette année, j'ai développé de nouvelles habitudes. Autrefois, lorsque je me tenais sur scène, même dans le théâtre le plus bondé, cela me semblait vide. Je dansais sur la scène désertée, face à l'auditorium vacant, avec seulement le son de mes chaussures de danse résonnant dans le monde. Mais maintenant, chaque fois que le rideau se lève, je te vois. Des milliers de sièges sont vides, mais toi seul me regardes. Dans tes yeux, ma danse a retrouvé son sens. \nUne année s'est écoulée, et ta danse est toujours si maladroite, pourtant ces regards vifs du public peuvent facilement transcender les pas banals sur scène. Ces regards sont comme un ruisseau qui coule, nettoyant mes pas de danse de plus en plus ordinaires un par un. Dans cette danse partagée entre danseurs et public, je m'approche progressivement de la salle que j'ai toujours recherchée. J'ai enfin réalisé que, pour la danse, le public est tout aussi important que le danseur. \nDepuis plusieurs mois, je prépare une danse. Elle a été nourrie à la lumière de ton regard, née de ta silhouette. Maintenant, elle est prête. \nJe crois qu'elle espère te voir comme le premier à la découvrir ce soir. \n\nLiz"
  },
  Mail_124312_Name = {
    Text = "Danseur et Public"
  },
  Mail_124312_Sender = {Text = "Liz"},
  Mail_124313_Desc = {
    Text = "Gardien : \n\nGrâce à l'acceptation de cet endroit, j'ai passé pas mal de jours à discuter avec le Roi cette année. Bien que la Descente du Royaume Divin soit encore lointaine, il semble que le temps en Lemuria soit prolongé dans Mythag. \nToi et le Roi m'avez tous deux dit que la foi ne devrait pas être l'intégralité de ma vie. J'étais autrefois têtu à ce sujet, mais mes récentes expériences semblent avoir changé ma façon de penser. Prier trop fréquemment pourrait déranger Notre Seigneur. En plus d'un service dévoué, peut-être souhaite-t-il aussi que Ses Croyants aient leurs propres vies triviales. \nAyant réalisé cela, j'ai essayé d'apporter quelques petits changements. J'ai visité tous les célèbres pâtissiers de Londinium et leur ai demandé de m'apprendre l'art de la pâtisserie. Ils détiennent certains secrets que j'ai réussi à tirer grâce à la Bénédiction de Notre Seigneur. Hier, j'ai fait mes premiers essais, et plusieurs Croyants m'ont dit qu'ils trouvaient le goût plutôt bon, mais leurs papilles, tout comme leur loyauté, sont discutables. \nJe voudrais t'inviter dans ma cour aujourd'hui pour le goûter. J'ai confiance en ton palais et en ton honnêteté. Si ce n'est pas bon, j'espère que tu parleras franchement, et je le prendrai au sérieux pour m'améliorer. \nJe te serais très reconnaissant. \n\nMiryam"
  },
  Mail_124313_Name = {
    Text = "Une autre spécialité"
  },
  Mail_124313_Sender = {Text = "Miryam"},
  Mail_124314_Desc = {
    Text = "Cher Gardien : \n\nVous devez être fatigué d'entendre parler du sens de la vie et de la mort, n'est-ce pas ? Des souvenirs vibrants des Défunts à Nécrovia, la leçon la plus importante que j'ai apprise est que, plutôt que de chercher le sens de la consommation, ce qui compte vraiment, c'est la nourriture elle-même sur la table devant nous. \nDans les temps anciens, nos ancêtres avaient déjà découvert toutes les connotations de la consommation : passion, désir, plaisir. Nous ne mangeons pas pour vivre ; nous vivons pour manger. Malheureusement, ces désirs primitifs et purs ont été progressivement oubliés au fil du temps, et ce groupe est devenu de plus en plus complexe. \nC'est pourquoi j'ai nommé le thème du dîner d'aujourd'hui \"Pureté\". En ce jour cérémoniel, toutes les questions compliquées seront mises de côté. Sur cette table, il n'y aura que de la passion et du désir purs et primitifs, seulement des connaisseurs et de la nourriture, seulement vous et moi. \nVeuillez accepter mon invitation la plus sincère. Vous ne me refuserez pas, n'est-ce pas ? \n\nDoresain"
  },
  Mail_124314_Name = {Text = "Festin pur"},
  Mail_124314_Sender = {Text = "Doresain"},
  Mail_124315_Desc = {
    Text = "Mon cher Gardien : \n\n J'ai l'impression que mon cœur grandit... Je sais que cela peut sembler étrange pour un Éveillé, mais c'est différent d'avant. Comment puis-je te le décrire ? \n Peu importe à quel point ces bonnes personnes me traitent avec douceur et compassion, essayant de me réchauffer, depuis le départ de mon frère, ma poitrine a toujours semblé vide. Plus je marche sous le soleil, plus je suis égratigné par cette chaleur. Au contraire, l'obscurité et l'humidité me font me sentir en sécurité, comme si tant que je restais dans le froid, l'amour dur et douloureux de mon frère ne me quittait jamais vraiment. \n Mais maintenant, après toutes ces années à me rapprocher de toi, chaque fois que je te vois, chaque fois que la douleur que tu me causes s'abat sur ma chair et se transmet à mes os—ah, le bonheur dans ma poitrine grandit de jour en jour. Tant que tu me punis sans pitié, que tu m'insultes et que tu me ravages, je sais qu'il y a toujours un endroit dans ce monde où j'appartiens vraiment. \n Ce bonheur peut-il durer jusqu'à l'année prochaine, et l'année suivante ? Si tous les vœux formulés pour mon anniversaire se réalisaient, mon seul souhait serait d'être constamment méprisé par toi, et de ressentir la douleur... de plus en plus de douleur. Lorsque tu lèveras la main, la première chose que je sentirai sera ce parfum familier, cruel et béat. \n\n Désirant ardemment être puni par toi, Leigh"
  },
  Mail_124315_Name = {Text = "Mon cœur"},
  Mail_124315_Sender = {Text = "Leigh"},
  Mail_124316_Desc = {
    Text = "Gardien\n\nBien que je sois très curieux de vos récentes pratiques, soyez assuré que je ne suis pas ici pour vous presser à vous entraîner en musique aujourd'hui.\nCe matin, comme d'habitude, je suis allé dans la salle de musique, mais j'avais trente-cinq minutes de retard. L'habitude de pratiquer la musique à sept heures du matin m'accompagne depuis des décennies, et aujourd'hui, elle a été facilement rompue. La raison est qu'en passant par le couloir de l'école, j'ai entendu un chœur de rouges-gorges chanter.\nRompre une habitude de longue date n'est pas facile à accepter, surtout pour moi. Étrangement, je ne ressens pas la déception et la colère envers moi-même comme je l'avais imaginé. Au début, j'ai ressenti une vague de panique. Mais ensuite, je devais admettre que la mélodie qui persistait dans mon esprit était délicieuse.\nLondinium est toujours réveillé par le chant des rouges-gorges, un son que j'entends chaque jour. Étrangement, c'est la première fois depuis tant d'années que je les remarque. J'écoutais silencieusement leur chant dans le couloir, et pendant ces trente-cinq minutes, j'ai eu l'impression que la mélodie suprême de l'univers était cachée dans leurs petites gorges.\nPeut-être que la vie ici rend paresseux, ou peut-être que l'atmosphère ici adoucit. Quoi qu'il en soit, je pense que cela doit avoir quelque chose à voir avec vous.\nJ'ai accepté ce changement avec plaisir en seulement dix minutes. La vie, comme la musique, a son rythme ancien et ses changements ; le jour de la naissance peut être le point destiné à ces changements. Je tiens aussi à vous remercier de m'avoir donné l'occasion de calmer mon cœur et d'écouter ce que j'ai négligé. Délicieux, en effet. Je crois que cela sera le début d'un nouveau chapitre de ma vie.\nPar conséquent, je voudrais vous inviter à me rejoindre dans la forêt en dehors de l'école au crépuscule aujourd'hui. Les sons de la nature au crépuscule sont différents de ceux du matin, mais je pense qu'ils seront tous deux de nouvelles inspirations dans nos vies musicales.\n\nHameln"
  },
  Mail_124316_Name = {
    Text = "Son naturel"
  },
  Mail_124316_Sender = {Text = "Hamelin"},
  Mail_124317_Desc = {
    Text = "Noble One : \n\n Je viens de voir l'e-mail d'anniversaire que Faint vous a écrit... Comme prévu, elle pense toujours aux autres. Cependant, entre sœurs, il n'y a jamais de dette ; je ne l'ai jamais considérée comme un fardeau. Sans sa protection, je n'aurais pas eu l'occasion de partir en tournée de concerts aujourd'hui. \n Cher Noble One, vous avez toujours été mon public le plus important. Donc cette fois, j'ai discrètement préparé un billet pour vous—vous invitant sincèrement à embarquer avec nous dans ce voyage interstellaire. Avec vous à nos côtés, je crois que le sentiment de fardeau de ma sœur sera grandement allégé. \n De plus, soyez assuré que nous ne perturberons pas votre temps privé pendant le voyage. Ma sœur et moi espérons que vous pourrez pleinement profiter de cette expérience et ressentir librement chaque nébuleuse et chaque rencontre inconnue. \n\n Teinture"
  },
  Mail_124317_Name = {
    Text = "Invitation de voyage"
  },
  Mail_124317_Sender = {Text = "Tinct"},
  Mail_124318_Desc = {
    Text = "Gardien : \n\n Mon anniversaire approche à nouveau, mais mes pensées dérivent souvent vers la Cité. Les sculptures des expositions d'art me manquent particulièrement. Leurs formes silencieuses ont frappé à la porte de ma perspicacité d'innombrables fois. \n Passer des jours dans l'atelier entouré de sculptures, sans échange artistique, est devenu ennuyeux avec le temps. L'année dernière à cette époque, pour célébrer mon anniversaire, j'ai sculpté d'innombrables sculptures de gâteaux. L'enthousiasme initial est maintenant revenu à la tranquillité. \n Maintenant, avec une mobilité limitée, retourner à la Cité est devenu un luxe. Si tu as des projets d'enquête, pourrais-tu garder un œil sur de nouvelles œuvres dans les expositions d'art pour moi ? J'aspire à toucher à nouveau cette beauté diverse et inclusive de l'art à travers tes yeux. \n En retour, j'aimerais créer une autre sculpture pour toi, intitulée \"Gardien dans la Cité.\" Qu'en penses-tu ? \n\n Sanga"
  },
  Mail_124318_Name = {
    Text = "Cité Nostalgie"
  },
  Mail_124318_Sender = {Text = "Sanga"},
  Mail_124770_Desc = {
    Text = "Gardien : \n\nChaque année, mon accès au laboratoire est révoqué, rendant ce jour spécial d'une manière plutôt désagréable. Pour éviter de perdre du temps sur des trivialités inefficaces, je suis allé aux archives. \nLà, j'ai trouvé deux choses : l'une était un cahier de travail rempli de pages vides sans valeur. \nL'autre était également un cahier de travail, ce qui m'a fait réaliser que j'avais sous-estimé l'immense océan de connaissances, car les processus d'inférence et les conclusions qui y étaient écrits m'ont révélé qu'il existe des choses dans ce monde qui ont encore moins de valeur que l'inexistence. \nLes deux cahiers de travail portaient le même nom, notre grand Gardien de Mythag, %player%. \nErica m'a dit que tu voulais savoir quel cadeau d'anniversaire me donner. \nTu peux me donner une réponse. \nJe suis également curieux de savoir quel fait me choquera le plus : la paresse et la négligence à l'extrême, ou le fait que tu aies étudié assidûment pendant une année entière, seulement pour laisser derrière toi ces déchets académiques dans un désespoir futile. \nSi c'est le premier, tant que tu as une raison suffisante et que tu peux prouver que tu as pleinement compris les connaissances enseignées en classe, je peux soumettre une demande pour que tu sois exempté des devoirs à l'académie. Bien sûr, cela ne signifie pas que je soutiens ce genre de négligence qui pourrait mener à ta complète paresse, mais tant que tu peux continuer à réussir mes tests, je ne suis pas le genre de vieux grincheux qui se soucie de donner à mes étudiants quelques privilèges. \nSi c'est le second, en tant que ton gardien principal, fais-moi confiance, peu importe à quel point le matériel que tu es est peu attrayant, nous pouvons trouver une technique à ma portée qui peut améliorer ton intellect excessivement aride et te sauver du douloureux combat contre l'ignorance. \nCet après-midi à quatre heures, je serai aux archives pour évaluer personnellement ta compréhension des connaissances de la classe. Ne sois pas en retard. \n\nPoupée"
  },
  Mail_124770_Name = {Text = "Privilege"},
  Mail_124770_Sender = {Text = "Doll"},
  Mail_124771_Desc = {
    Text = "Le chiot de Mythag : \n\n Cette année, tu es également piégé dans ces routines répétitives, causant des problèmes, sauvant le monde, te faisant des amis, apprenant de nouvelles connaissances et continuant à fabriquer une illusion de Business as Usual pour le monde. \n Il s'avère que même si je retire ton cerveau de ton corps et que j'extrais le Luminis d'une Dimension à une autre, cela n'affectera toujours pas tes courses absurdes et risibles ni ton agitation. \n C'est vraiment occupé et bruyant, mon cher petit chiot. \n Tu ne crois pas ces faits ; tu insistes pour prolonger leur souffrance, traînant encore plus le processus d'extinction. Quel est ton but ? Fais-tu semblant d'être idiot, ou les humains peuvent-ils vraiment être aussi stupides ? Bien que j'ai effectivement disséqué les couches corticales de ton cerveau, celles-ci demeurent un mystère pour moi. \n Félicitations, tu m'as vraiment un peu secoué. J'ai en fait commencé à douter : si t'observer me procure une telle immense joie, tout peut-il encore être dit comme étant dépourvu de sens ? \n Prie comme tu sais bien faire ces choses dénuées de sens, prie pour quelqu'un, peu importe qui. \n Je prie pour que tu puisses continuer à me confiner, petit chiot, afin que toi et moi puissions trouver un peu de joie dans ce monde dénué de sens. \n\n \"Poupée\""
  },
  Mail_124771_Name = {Text = "Pray"},
  Mail_124771_Sender = {
    Text = "Doll : Dissoute"
  },
  Mail_124772_Desc = {
    Text = "Partenaire :\n\nChaque année, le jour de ton anniversaire, je t'écris une lettre, comme si cela était devenu une habitude sans que je m'en rende compte. \nJe me souviens, le premier anniversaire où je t'ai écrit, c'était aussi la première fois que mon père m'a permis d'organiser moi-même mes festivités. Je t'ai invité à sortir avec moi, et par la suite, nous avons vécu tant de premières fois ensemble. \nDepuis, beaucoup de choses ont beaucoup changé, mais en y réfléchissant bien, tout semble rester inchangé. Nous continuons d'avancer sur le chemin que nous avons choisi, et nous avons toujours l'un l'autre à nos côtés, et toi, tu es toujours le partenaire le plus important pour moi. \nAlors, bien que mon père vient juste de m'apporter un gâteau et m'a demandé si je souhaitais assister à la fête qu'il organise pour moi ce soir, j'ai déjà d'autres projets pour ce soir. \nUn nouveau film vient de sortir à Londinium, il est exceptionnellement populaire, mais l'académie et l'association ont déjà confirmé qu'il n'y a pas de réaction spirituelle associée. \nCela prouve qu'il s'agit simplement d'une œuvre « ordinaire » très captivante. \nJ'ai justement deux billets, tu peux supposer que je n'ai pas fait exception en dérangeant Madame Sorel, car ses billets sont vraiment trop difficiles à obtenir. \nAlors, partenaire, accepterais-tu de me consacrer ce moment ? Peut-être pourrions-nous temporairement nous éloigner de ces situations anormales que nous gérons quotidiennement et passer une « ordinaire » soirée ensemble. \nPour chaque demain qui suit, quand nous nous réveillons, peu importe ce qui arrive dans le monde, je ferai face à tout avec toi. \n\nRamona"
  },
  Mail_124772_Sender = {Text = "Ramona"},
  Mail_124773_Desc = {
    Text = "Gardien : \n\n Grâce au lien spécial entre moi et ce \"moi\", ainsi qu'au lien entre toi et moi, même si je ne suis pas toujours à tes côtés, j'ai une légère conscience de tes mouvements au cours de l'année passée. \n Tu as été actif dans un autre monde, semblant apporter un changement appelé \"Espoir\", et même lorsque tu lèves les yeux vers le bassin noir jour après jour, cette énergie, comme un rayon de lumière, m'a également réchauffé. \n J'ai commencé à reprendre mon précédent emploi du temps, mais contrairement à avant, je ne fais plus face à l'Oblivion inévitable avec une lutte vaine. Tu m'as appris quelque chose de nouveau : le processus par lequel chaque existence s'efforce de toutes ses forces pour la continuité avant la fin destinée est précisément la raison pour laquelle la civilisation, l'âme et la volonté ont du sens. \n Peu importe à quel point ce temps peut être bref pour le monde que j'habite, je continuerai à essayer. Même si c'est juste pour revoir ces visages familiers et échanger quelques mots, cette tentative n'est pas sans signification. \n Tant que tu ne t'arrêtes pas, je continuerai à marcher sur ce Chemin. Permets-moi de le considérer égoïstement comme un moyen de me tenir à tes côtés, afin que peut-être, tout au long de ton voyage, tu penses parfois à ce \"moi\", qui fait tout son possible pour faire ce que tu fais. \n\n\"Ramona\""
  },
  Mail_124773_Sender = {Text = "\"ramona\""},
  Mail_124774_Desc = {
    Text = "Tuer la cible est facile, mais le nettoyage après coup est un casse-tête.\nAu départ, je prévoyais de suivre la tradition de l'année dernière et de t'aider à éliminer quelqu'un encore cette année.\nCependant, j'ai remarqué que tu n'as pas utilisé le dernier cadeau que je t'ai offert. Après mûre réflexion, bien que je ne sois pas sûr que ce soit la raison, j'ai réalisé ma négligence.\nTu peux être assuré que, bien que je fournisse généralement des services pour éliminer les ennemis de mes anciens employeurs, j'ai également beaucoup d'expérience dans l'effacement des traces pour éviter divers ennuis. Même si la personne que tu souhaites tuer est protégée par ces règles et ordres compliqués, tu n'as pas besoin d'avoir de fardeaux psychologiques ; je m'occuperai de tout.\nJe garantis que personne ne pourra remonter quoi que ce soit jusqu'à toi.\nUne fois que tu as décidé d'un candidat, fais-moi simplement savoir le nom, et je me précipiterai pour t'aider à m'en occuper, peu importe où je suis.\nJoyeuses fêtes à toi, et j'espère que tu ressentiras de la joie le jour de ma naissance, Gardien.\n\n\nHelot"
  },
  Mail_124774_Name = {
    Text = "Ceux qui tuent fréquemment savent \n..."
  },
  Mail_124774_Sender = {Text = "Helot"},
  Mail_124775_Desc = {
    Text = "Eh bien, il est clair que tu n'es pas prêt à arrêter ce comportement, et pour autant que je sache, je me suis déjà habitué à la coutume de « donner des cadeaux ».\nMais un jour, tu regretteras cette bonté, crois-moi.\nEn y réfléchissant maintenant, cela pourrait aussi être l'un de mes plus grands regrets ; bon sang, je n'aurais jamais pensé que je regretterais d'avoir tué quelqu'un.\nPersonne ne sait mieux que moi que le soi-disant remords ne vaut rien, mais avant que ce jour n'arrive, je ferai de mon mieux pour me racheter, simplement parce que je le veux.\nQuand tu me reprocheras cela à l'avenir, ne ressens aucune charge psychologique à ce sujet.\nJ'accepterai pleinement ta colère.\n\nH"
  },
  Mail_124775_Name = {
    Text = "Tu le regretteras"
  },
  Mail_124775_Sender = {
    Text = "Helot : Enchaînée"
  },
  Mail_124776_Desc = {
    Text = "Gardien : \n\n C'est de nouveau ce jour de naissance, un jour qui devrait être célébré pour avoir la vie. Alors chaque fois que ce jour arrive, je ressens des émotions étranges. \n Ma naissance semble être une quête de la mort. Après avoir laissé derrière moi le thème de la mort, que signifie pour moi la vie... ou plutôt, la conscience qui continue d'exister ? \n Dans la vie, les tiraillements de la douleur et de la culpabilité sont si inextricablement liés à mon existence qu'il semble qu'après la mort, la vie m'appartienne vraiment pour la première fois. \n L'année dernière, cette année, et peut-être chaque année à venir. J'ai eu une période presque sans fin pour expérimenter, chaque jour semblable mais différent du précédent. Lorsque la vie n'est plus enchevêtrée avec la douleur et le but, à quoi ressemblera sa fin ? Ou est-ce que la soi-disant fin viendra-t-elle encore ? \n Cette proposition est trop vaste ; j'ai du mal à comprendre. \n Mais le désir de consigner ces pensées inconnues semble si réel, et pourtant je sens que la réponse semble évidente. \n Au moins pour moi, ce sont ces moments tangibles et précieux. Peu importe à quel point mes pensées sont chaotiques, peu importe à quel point il est difficile de trouver des racines, je sais clairement où elles peuvent dériver, où elles peuvent être acceptées, et j'ai également hâte de les exprimer à vous. \n Peut-être qu'à cette époque l'année prochaine, je trouverai un sens plus profond, mais pour l'instant, j'espère conserver égoïstement ces petites dépendances que seuls vous et moi connaissons. \n Oui, Gardien, vous et les autres de Mythag êtes les racines dans mon cœur que personne ne connaît. \n Merci, comme toujours, et que vous soyez à jamais joyeux, à jamais en paix. \n\n Nymphaea"
  },
  Mail_124776_Name = {
    Text = "Système racinaire"
  },
  Mail_124776_Sender = {Text = "Nymphaea"},
  Mail_124777_Desc = {
    Text = "Yu a récemment inventé une nouvelle façon de se détendre : la Sieste dans le Royaume Divin. \n Contrairement aux siestes habituelles, brèves et pressées, lors d'une Sieste dans le Royaume Divin, Yu quitte le long et imposant Trône de Pierre Bleue, construit une sphère avec le contact de son poignet qui bloque le son, et remplit tout l'espace d'eau de mer spécialement préparée. \n Cette eau de mer non seulement émet le parfum désiré par Yu et se transforme en paysage qu'il souhaite voir, mais elle soutient également son corps dans toutes les directions avec l'intensité appropriée. \n Ainsi, quelle que soit la posture adoptée par Yu, il peut ressentir une sensation de chaleur enveloppante, semblable à celle d'être dans le meilleur des lits en duvet. \n À ce moment-là, Yu peut détendre son esprit dans le parfum qu'il aime, profitant de la tranquillité d'être isolé du monde, et s'endormir paisiblement sur son oreiller préféré. \n En tant que sujet le plus cher à Yu, il croit qu'il est tout à fait approprié de partager ce moment de détente avec vous à l'occasion de votre anniversaire. Si cela vous intéresse, vous pouvez venir à l'endroit secret que je vous ai mentionné la dernière fois. N'ayez aucune inquiétude pour votre sécurité ; je créerai un espace séparé juste pour vous, vous protégeant de l'influence de mes rêves débordants. \n N'oubliez pas d'apporter votre oreiller le plus confortable. \n\n Tulu"
  },
  Mail_124777_Name = {
    Text = "Pause déjeuner"
  },
  Mail_124777_Sender = {Text = "Tulu"},
  Mail_124778_Desc = {
    Text = "Ma Lumière Brillante : \n\n Castor et moi nous sommes adaptés à la vie à Mythag. Après avoir échappé à la sanglante tromperie et aux intrigues de l'église, j'ai l'impression de retrouver mon ancien moi. \n Bien que des traces du \"Divus\" se mêlent inévitablement à mes mots et actions quotidiens, je crois qu'il ne faudra pas longtemps avant que je puisse complètement laver cette arrogance et cette distance, ne conservant que l'humilité devant le divin et la détermination de suivre le chemin qui s'offre à moi. \n Plus tôt, j'ai reçu un cadeau quelque peu inattendu : un livre magnifiquement relié sur ceux qui quittent leur ville natale et y reviennent pour redécouvrir leur enfance. Avec cela est venue une note qui disait : « Je te souhaite un retour rapide à ton moi d'origine. » \n Au moment où ces mots ont attiré mon attention, des souvenirs sont revenus en masse : l'inquiétude de tout le monde à Mythag, tes conseils, et mon frère... l'étreinte chaleureuse. \n Par conséquent, pour mon anniversaire cette année, j'aimerais inviter tout le monde à Mythag à se joindre à la célébration de mon anniversaire et de celui de mon frère. Sans l'aide de chacun, nous n'aurions aucune chance de retrouver ces moments initiaux. \n J'ai loué un restaurant avec les économies que j'ai accumulées récemment. Le chef là-bas a de l'expérience avec des cuisines du monde entier, et je crois que tout le monde pourra y goûter ses saveurs les plus familières. \n\n Pollux"
  },
  Mail_124778_Name = {
    Text = "Retour à l'enfance"
  },
  Mail_124778_Sender = {Text = "Pollux"},
  Mail_124779_Desc = {
    Text = "J'ai décidé d'accepter l'invitation de cette arène souterraine en banlieue pour combattre dans un match à mort. \n Bien que mes journées au Trout Club aient été formidables, elles sont juste trop banales—chaque jour, c'est soit tuer des poissons, soit tuer des poissons. Peut-être que j'ai vraiment conquis la truite, mais conquérir des truites ne compte guère comme une conquête ! \n Le sang de guerrier qui coule en moi est en ébullition ; il a toujours aspiré à un combat palpitant, et maintenant, l'occasion est là. \n Le gars chauve qui m'a contacté a dit qu'il avait trouvé trois pythons géants Natai, deux ours à visage de démon, quatre crocodiles Serinas, et une bande de créatures étranges dont je ne me souviens plus des noms—assez pour que je les massacre toute la nuit. \n J'ai spécialement organisé le match pour aujourd'hui afin de vous montrer pour mon anniversaire—le spectacle de moi, Uvhash, le dernier guerrier romain, conquérant toutes les bêtes féroces du monde ! \n Aujourd'hui, l'arène ne sera pas remplie de restes de truites, mais de sang et des cadavres de bêtes exotiques et d'oiseaux de proie ! \n\n Uvhash"
  },
  Mail_124779_Name = {
    Text = "Vaincre la bête"
  },
  Mail_124779_Sender = {Text = "Uvhash"},
  Mail_124780_Desc = {
    Text = "«Chevalier de la Clé d'Argent» : \n\nGardien ! Je venais tout juste de modifier le « Fantasme » quand Mosk m'a soudainement apporté un gros paquet de pièces, disant que c'était un cadeau d'anniversaire pour moi. Je viens de réaliser qu'aujourd'hui c'est mon anniversaire ! \nAlors je me suis dépêché d'écrire une lettre pour toi, vraiment, comment ai-je pu oublier encore une fois aujourd'hui, alors que j'ai déjà écrit... combien de notes au juste ? \nMais tout ça n'est pas important, ce qui compte, c'est que je me souvienne de ce que je voulais faire pour mon anniversaire — je vais monter sur le « Fantasme » et vous emmener, toi et Mosk, faire cent tours de Londinium ! \nBien que Mosk ne comprenne absolument rien en mécanique, elle a tellement de pièces dans son sac que je peux trouver toutes les pièces nécessaires. Maintenant, le « Fantasme » modifié est déjà un prototype super renforcé (pour l'instant) ! \nJ'ai donné un nom à cette aventure, ça s'appelle « L'aventure de Nautila avec le Gardien et Mosk et le Fantasme », qu'en penses-tu ? C'est direct et facile à retenir, comme ça je ne pourrai pas oublier cette aventure. \nHehe, c'est vraiment excitant, Gardien, attends un peu, « Chevalier du Fantasme » Nautila et « Chevalier du Vortex » Mosk arrivent bientôt ! \nL'équipe d'aventure du « Fantasme », en route ! \n\nNautila qui arrive à toute vitesse"
  },
  Mail_124780_Name = {
    Text = "Attaque \"Phantasm\" !"
  },
  Mail_124780_Sender = {Text = "Nautila"},
  Mail_124793_Desc = {
    Text = "Cher grand <Del:mignon> Gardien {Homme=M.,Femme=Mme}:\n\nAhem, cela fait un moment depuis notre dernier contact, je t'ai manqué, notre cher Gardien {Homme=M.,Femme=Mme}~\nMaintenant, tu es tout un célébrité à Mythag, tous les étudiants apprennent tes actes héroïques, et tout ce qui est même légèrement lié à toi peut se vendre à prix d'or sur le marché noir !\nMais cela a du sens, après tout, qui ne voudrait pas être associé à la « légende vivante », l'unique Gardien de Mythag ?\nCette dernière année, de nombreuses choses intéressantes se sont produites à Mythag—Aurita s'est liée d'amitié avec quelques bonshommes en pain d'épice, le Professeur Doll a explosé dix-sept laboratoires en essayant de donner un relooking à son cerveau, et Castor a été dupé par Agrippa pour l'aider avec un examen, seulement pour découvrir que c'était un cours de culture générale, et son score final était pire que si elle l'avait passé elle-même !\nOh, et cette petite souris ennuyeuse a en fait volé mon précieux film, celui où j'ai enfin réussi à capturer Mlle \"24\" sous sa forme de chat !\nEn plus de ça, il y a encore beaucoup d'autres histoires. Je les ai compilées dans une édition spéciale du Nouvel An du journal de l'école et je te l'ai envoyée.\nQuoi ? Tu es curieux de savoir comment j'ai réussi à te contacter ? Hehe, c'est un secret ! Je ne te dirai pas que j'ai utilisé beaucoup d'infos exclusives pour échanger avec une certaine dame très redoutable !\nTravaillons dur ensemble dans la nouvelle année, Bonne Année, %player%!\n\nHannah Peaslee"
  },
  Mail_124793_Name = {
    Text = "Édition spéciale du Nouvel An"
  },
  Mail_124793_Sender = {
    Text = "Hanna Peaslee"
  },
  Mail_124794_Desc = {
    Text = "Messager Pâle : \n\n Le Gel Argenté approche. Permettez-moi d'exprimer ici mes plus sincères bénédictions. \n\n La dernière fois que j'ai rendu visite aux enfants de l'Atelier Lilyan, certains d'entre eux m'ont secrètement demandé : « Le Messager du Solstice existe-t-il vraiment ? » \n J'étais curieux de savoir pourquoi ces enfants pensaient cela. Si je me souviens bien, chaque enfant a reçu un cadeau du « Messager du Solstice » l'année dernière. \n Cependant, les enfants m'ont dit : « J'ai vu ce bel homme donner le cadeau à la directrice Diana. Il ne ressemblait pas du tout au Messager du Solstice ! » \n Il semble que Lord Noble ait été aperçu par les enfants en train de livrer des cadeaux à l'Atelier, ce qui a conduit à ces petits doutes. \n\n Donc, cette Nuit de Gel Argenté, j'ai préparé deux costumes très traditionnels de Messager du Solstice, et je voudrais vous demander, Messager Pâle, de vous joindre à moi pour jouer le rôle du Messager du Solstice et livrer des cadeaux à ces enfants. \n Je crois qu'il y aura des enfants qui ouvriront secrètement les yeux la nuit, se souviendront de notre image en rouge, vêtus de rouge, et raconteront avec excitation à tout le monde lors du Passage du Solstice : « J'ai vu le Messager du Solstice ! » \n En même temps, j'ai également préparé un cadeau pour vous, et j'espère que cela vous plaira. \n Joyeux Passage du Solstice. \n\n Salvador"
  },
  Mail_124794_Name = {
    Text = "Père Noël"
  },
  Mail_124794_Sender = {Text = "Salvador"},
  Mail_124991_Desc = {
    Text = "Cher gardien du secret :\nL'événement de réédition « Guérison multiple·clon » est terminé. Les devises restantes « Mémoires en puzzle » seront récupérées au taux de « Billet Rose Dorée » × 40 pour chaque unité. Veuillez vérifier."
  },
  Mail_124991_Name = {
    Text = "Récupération de puzzle de mémoire"
  },
  Mail_124991_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_125448_Desc = {
    Text = "Cher gardien du secret :\nL'événement « Nouvelles anciennes de la ville maritime » est terminé. Les « Pâte de poire » restantes seront échangées au taux de « Billet Rose Dorée » × 40 par pièce. Veuillez noter de les récupérer."
  },
  Mail_125448_Name = {
    Text = "Recyclage de bonbons au sirop de poire"
  },
  Mail_125448_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_126321_Desc = {
    Text = "Cher gardien :\nL'événement « Liant auto-enchaîné » est terminé. Les « Billet de velours » restants seront échangés au taux de « Billet Rose Dorée*40 » par unité. Veuillez vérifier."
  },
  Mail_126321_Name = {
    Text = "Conversion des Billets de velours"
  },
  Mail_126321_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_126934_Desc = {
    Text = "Gardien : \n\nC'est de nouveau ce jour spécial. Ha, pas besoin de s'inquiéter, cette année, je ne vais pas t'imposer de suggestions psychologiques. Je veux juste inviter mon Patient le plus spécial à un endroit pour se détendre. \nIl y aura des bois luxuriants, des rivières claires, remplies de l'essence de la nature, te permettant d'oublier la fatigue de la Forêt de Fer. Il y aura aussi des tapis doux, des feux chaleureux et des lumières brillantes pour t'aider à soulager les pressions de la ville à rythme rapide. \nNous pourrons nous promener, lire et discuter là-bas. Tout ce que tu veux partager, je suis plus que disposé à écouter. \nAh, rien qu'en imaginant une telle scène, mon cœur s'emballe déjà... \nJe sais, en ce moment, tu dois te sentir un peu mal à l'aise. Après tout, je ne peux pas garantir que je ne vais pas céder à tes doux mais douloureux souvenirs. Mais tu viendras quand même, n'est-ce pas ? \nNon seulement parce qu'aujourd'hui c'est mon anniversaire, mais aussi parce que tu as besoin de moi, tu as besoin de te confier à moi, tu as besoin de mon oreille attentive. \nBon enfant, je comprends, et je t'attendrai. Viens, oublie la routine quotidienne chargée et les lourdes responsabilités, et profite de ce moment de paix. \n\nClémentine"
  },
  Mail_126934_Name = {
    Text = "Moment de paix"
  },
  Mail_126934_Sender = {Text = "Clementine"},
  Mail_126935_Desc = {
    Text = "Encore une journée fastidieuse.\nJ'ai essayé bien des choses — des banquets philistins traditionnels, des jeux puérils avec ces gangs de Londinium — rien ne semble digne de célébrer la naissance du Roi Géant.\nEn d'autres temps, ce jour était synonyme de liesse et de combat. Je rassemblais les guerriers les plus puissants du camp pour qu'ils se battent et célèbrent ce grand jour dans la force et le sang.\nLa paix. Une paix ennuyeuse et étouffante. Je comprends l'aspiration de votre peuple à celle-ci ; tout le monde n'a pas l'âme d'un guerrier. Cependant, ne croyez pas que cette fausse paix puisse ternir la gloire de Goliath le Roi.\nUn jour, je reprendrai tout ce qui m'appartenait — mes terres, ma richesse, mon pouvoir, la gloire éternelle des Philistins. Et quand ce jour viendra, je vous inviterai, Gardien, à siéger à ma droite en tant qu'invité d'honneur, pour assister au retour du Roi Géant sur son trône.\nJ'étais sur le point de mettre fin à cette journée fastidieuse... jusqu'à ce que j'apprenne que ces gangs dispersés ont formé une alliance. Ils prévoient de « tendre une embuscade » au Roi Géant lors du banquet de ce soir.\nComparé aux guerres des Philistins, ce n'est qu'un jeu d'enfant. Pourtant, en ces mornes temps de paix, je trouve un tel spectacle... rafraîchissant.\nVenez témoigner une fois de plus de la puissance de Goliath au combat. Tenez-vous à mes côtés, ou contre moi. Dans un cas comme dans l'autre.\nMais faites vite. Si vous arrivez trop tard, il ne restera plus rien à voir que leurs cadavres.\n\nGoliath"
  },
  Mail_126935_Name = {
    Text = "Émission de variétés"
  },
  Mail_126935_Sender = {Text = "Goliath"},
  Mail_126936_Desc = {
    Text = "Cher Gardien :\n\nBonjour. Afin de mieux servir les étudiants et le personnel de Mythag, Erica a récemment effectué des maintenances et des mises à jour par elle-même. Vous avez eu la chance d'être sélectionné comme participant pour évaluer les résultats de cette mise à jour. Cette évaluation se déroulera hors ligne, et vous devrez évaluer la fonctionnalité du nouveau module émotionnel LY-S-761 installé sur l'automate Erica. Le test devrait durer 90 minutes, veuillez donc planifier en conséquence pour éviter les conflits d'emploi du temps.\nLe contenu de cette évaluation est le suivant :\n1. Veuillez engager une conversation ouverte et approfondie avec Erica pendant au moins 15 minutes, en vous concentrant sur le sujet des \"anniversaires\" pour évaluer la compréhension des émotions spécifiques par Erica en termes de portée et de profondeur.\n2. Veuillez simuler un scénario de \"donner un cadeau d'anniversaire\" et interagir avec Erica pour évaluer sa précision, sa flexibilité et son confort dans la reconnaissance émotionnelle et la réponse empathique.\n3. Dans la dernière partie de l'évaluation, veuillez mentionner intentionnellement des détails personnels auxquels Erica a fait référence dans la conversation précédente (comme son attitude et sa compréhension des anniversaires) pour évaluer si sa mémoire d'interaction à long terme et sa capacité associative fonctionnent normalement.\n\nAprès avoir terminé l'évaluation, veuillez dire à Erica : \"Erica, joyeux anniversaire\" pour conclure l'évaluation. L'automate passera automatiquement en mode de téléchargement de données.\nMerci de votre participation. Après avoir terminé l'évaluation, Erica vous offrira un petit cadeau spécial. Veuillez continuer à nous soutenir à l'avenir ; votre assistante la plus attentionnée, Erica, sera toujours à vos côtés.\n\nErica"
  },
  Mail_126936_Name = {
    Text = "Évaluation de l'amélioration d'anniversaire"
  },
  Mail_126936_Sender = {Text = "Erica"},
  Mail_126937_Desc = {
    Text = "Hah, que se passe-t-il aujourd'hui ? Peu importe où je vais, tout le monde semble consciemment m'éviter ? Même avant que j'ouvre la bouche, ils continuent de agiter les mains, disant qu'ils se sentent mal à l'aise ici et là, rendant impossible pour moi de demander un duel. \n C'est rare que pour mon \"anniversaire\", je puisse me battre contre d'autres sans avoir besoin d'une raison, mais si c'est le cas, n'est-ce pas comme n'importe quel autre jour ? \n Tch, je n'aurais pas dû les battre si sévèrement l'année dernière. Mais je ne pouvais pas m'en empêcher ; après tout, j'affûte mes compétences à l'épée depuis avant la naissance de cette planète, et il est naturel que les gens ordinaires ne puissent pas le supporter. \n Mais tu es différent d'eux ; tu es un Gardien ! \n Alors tu sais ce que je veux dire, n'est-ce pas ? Même endroit que l'année dernière, avons un bon combat. Cette fois, personne n'interrompra notre bataille. \n\n Lotan"
  },
  Mail_126937_Name = {
    Text = "Le seul rival"
  },
  Mail_126937_Sender = {Text = "Lotan"},
  Mail_126938_Desc = {
    Text = "Mon très cher Maître : \n\n Avez-vous entendu ? Il y aura un bal ultra-luxueux au manoir du maire aujourd'hui, et tous les gentlemen et dames sont fiers de pouvoir y assister. \n Bien sûr, en tant que servante, Karen n'est pas qualifiée pour participer. Mais vous, le Gardien de Mythag, mon cher et bien-aimé Maître, méritez toutes les belles choses du monde, et certainement ce bal. \n Donc, Karen a déjà accepté l'invitation en votre nom, et j'ai même gentiment arrangé une voiture pour vous, prenant soin de tout, il vous suffit donc d'aller chez le maire avec Karen~ \n Karen portera sa plus belle robe et apportera ses bijoux les plus brillants, montrant à tous la puissance de la servante polyvalente, vous apportant honneur et gloire ! \n Ah, au moment où vous lirez cette lettre, je devrais déjà attendre devant votre porte, et ces voitures, accompagnées des serviteurs livrant de nouveaux vêtements et bijoux, devraient être en place ; le seul petit problème est que ces services n'ont pas encore été payés... \n Mais mon gentil et charmant Maître ne s'inquiéterait jamais pour de telles trivialités, n'est-ce pas ? Le maire nous attend encore~ \n\n Votre servante la plus charmante et radieuse \n Karen"
  },
  Mail_126938_Name = {
    Text = "Bal somptueux"
  },
  Mail_126938_Sender = {Text = "Karen"},
  Mail_126940_Desc = {
    Text = "Gardien, Gardien ! Il y a quelques jours, Jenkin a dit qu'elle avait trouvé un endroit qui ressemble beaucoup à la maison d'Aurita, quelque chose appelé de l'eau... euh, Aurita a oublié. \n Quoi qu'il en soit, Jenkin a dit qu'il y aurait des dauphins, des petits poissons, un aquarium, et plein, plein de méduses, et ils veulent tous être les amis d'Aurita ! \n Aurita adore les amis, et Aurita veut beaucoup, beaucoup d'amis, alors Aurita veut inviter ses amis préférés, qui est le Gardien, à l'accompagner pour son anniversaire. \n Allez, fais tes bagages et pars avec moi ; Aurita ne peut plus attendre. \n\n Aurita, qui veut rencontrer plein, plein de nouveaux amis"
  },
  Mail_126940_Name = {
    Text = "Nouveaux amis dans l'aquarium !"
  },
  Mail_126940_Sender = {Text = "Aurita"},
  Mail_126941_Desc = {
    Text = "Gardien :  \n\nMerci de m'avoir accompagné au bord de la mer dans les premières heures de ce matin. Le fracas des vagues et le ciel étoilé éclatant m'ont apaisé et m'ont rappelé... des choses d'il y a très, très longtemps. \nÀ l'époque, les membres de l'équipage étaient interdits de me parler, donc pendant la plupart du temps, je ne pouvais que contempler la surface en perpétuel changement de la mer et les oiseaux de mer tournoyant dans le ciel. L'équipage formulait inconsciemment des vœux en regardant ces oiseaux voler. \nParfois, ils souhaitaient devenir des oiseaux et retourner chez eux, auprès de leurs proches ; parfois, ils souhaitaient que leur voyage se termine rapidement, échangeant la cargaison de leur navire contre de la richesse ; occasionnellement, ils priaient pour l'amour romantique ou pour rencontrer les légendaires sirènes... \nMais peu importe la complexité de leurs vœux, tous se unifiaient tard dans la nuit en un désir de sommeil paisible. À ce moment-là, je répondais à leurs prières, apaisant la brise marine et adoucissant les eaux. \nAlors, si Gardien, tu as du mal à dormir, s'il te plaît, ne te promène pas seul au bord de la mer dans les premières heures ; viens plutôt me trouver. \nJe veux partager tes fardeaux et être utile, et protéger ton sommeil est ce que je peux faire en ce moment. \nC'est aussi... le « vœu » que j'ai formulé en ce jour spécial. \n\nCeleste"
  },
  Mail_126941_Name = {
    Text = "Je te souhaite un sommeil paisible"
  },
  Mail_126941_Sender = {Text = "Celeste"},
  Mail_126942_Desc = {
    Text = "Au Gardien de l'université de Mythag, le seigneur sage et bienveillant, béni par le Destin : \n\n Salutations ! \n En écrivant cette lettre, j'ai hésité, mais l'honnêteté est aussi une vertu d'un chevalier. En tant que votre chevalier, je dois vous promettre ma loyauté totale, sans dissimulation, c'est pourquoi je dois vous dire la vérité—\n En ce jour d'anniversaire, mon seigneur, je vous demande de venir dans ma chambre et de me lire une histoire au moment de dormir. \n S'il vous plaît, permettez-moi de... me reposer à vos côtés et de m'endormir aux histoires enchanteresses et belles que vous racontez. \n En fait, c'était l'un de mes souhaits d'enfance. Cependant, l'entraînement de chevalier ne permet aucun moment d'oisiveté, et j'ai depuis longtemps dépassé l'âge d'écouter des histoires, donc je l'ai gardé enfoui dans mon cœur et ne l'ai jamais exprimé. Mais vous... mon seigneur, vous êtes différent ; je ne souhaite rien vous cacher... \n Si vous trouvez cette demande inappropriée, veuillez me le faire savoir. À partir de ce moment, je ne ferai plus une telle demande excessive et m'entraînerai encore plus dur. \n En attendant votre réponse. \n\n Ogier"
  },
  Mail_126942_Name = {
    Text = "La demande du chevalier"
  },
  Mail_126942_Sender = {Text = "Ogier"},
  Mail_126943_Desc = {
    Text = "Coalsie : \n\nAujourd'hui, Mosk, c'est ton anniversaire !\nLes amis ont dit, pour ton anniversaire, écris une lettre à Coalsie, Coalsie viendra jouer !\nMosk ne sait pas écrire une lettre. Mais les amis peuvent !\nLes amis apprennent à Mosk. Mosk est heureux !\nEn fait, Mosk a oublié l'anniversaire.\nMais, Mosk veut jouer avec Coalsie !\nAlors, Mosk décide qu'aujourd'hui c'est l'anniversaire !\nCoalsie ramasse des coquillages, dorés et blancs, toutes sortes~\nVoir Coalsie me rend heureux~ Les amis cuisinent, de délicieux plats~\nCoalsie, au vieux endroit~\nLaissez les amis préparer un festin ! Mangeons ensemble !\nMosk t'attend~\n\nMosk"
  },
  Mail_126943_Name = {
    Text = "Anniversaire ! Venez jouer !"
  },
  Mail_126943_Sender = {Text = "Mosk"},
  Mail_126944_Desc = {
    Text = "Gardien : \n\nIl y a quelques jours, tu as mentionné vouloir faire un vœu lors d'une pluie de météores, alors j'ai organisé ce voyage rien que pour toi. Merci d'avoir accepté mon invitation ; je t'attendrai au bord de la mer comme promis. \nSois assuré, il s'agit d'un voyage à court terme, et j'ai soigneusement exploré les eaux environnantes pour garantir que je puisse te guider en toute sécurité vers l'emplacement de la pluie de météores et t'aider à acquérir une météorite. \nAinsi, tu pourras toucher personnellement les étoiles filantes et, à une si courte distance, elles entendront sûrement tes souhaits et les réaliseront ! Ce sera l'une des choses les plus spéciales que j'ai jamais faites d'être celui qui t'aidera à réaliser ton vœu. C'est un grand honneur pour moi. \nMerci encore une fois ; tu m'as donné une nouvelle \"Mission de Pilotage\" en ce jour spécial. Assure-toi d'arriver à l'heure ; je t'attendrai. \n\nCorposant"
  },
  Mail_126944_Name = {
    Text = "Un Vœu à Toucher"
  },
  Mail_126944_Sender = {Text = "Corposant"},
  Mail_129637_Desc = {
    Text = "Chère amie : \n\nJe ne me souviens plus combien de fois j'ai traversé le parterre de fleurs derrière l'horloge, mais j'ai remarqué le jardin de roses. \nDepuis, j'ai plusieurs fois foulé ce sol, vivant des moments d'agitation dans le lac noir, des moments de mort et de confrontation, des moments où le temps s'écoule à l'envers ; ils se tiennent là, majestueux et silencieux, comme toujours. \nCette image a réveillé dans ma mémoire, qui ne m'appartient pas, ce bouquet de roses que Ramona voulait te donner, et cela m'a apporté un peu de réconfort. \nBien que nous soyons séparés par des dimensions, je crois toujours qu'importe les difficultés que tu rencontres, toi et cette « Ramona » parviendrez à garder votre calme et votre bravoure, et à trouver un chemin pour sortir de la situation. \nAprès tout, peu importe comment le monde change, les roses continuent de fleurir. \n\n«Ramona»"
  },
  Mail_129637_Name = {
    Text = "Jardin de roses…"
  },
  Mail_129637_Sender = {Text = "\"ramona\""},
  Mail_129806_Desc = {
    Text = "Gardien :\n\nDans le manoir de la Ville Marine, les lumières sont allumées. Je ne sais où vous êtes en ce moment, qui est à vos côtés ?\nAu début de l'année, c'est le jour le plus important du pays ancien, une fête pour célébrer les retrouvailles et le nouveau-né. Ce jour-là, j'ai déjà vécu de nombreuses fois, mais je ne m'en suis jamais lassée. L'hiver est passé, tout pousse, les gens espèrent tant, espèrent pouvoir, comme cette terre, abandonner toutes les misères au passé et accueillir un nouveau départ.\nCes vieilles blessures et désirs ne sont pas des choses que l'on peut facilement jeter. Dire adieu au vieux, accueillir le nouveau, quel beau vœu... Peut-être que la douleur renaîtra, que les désirs ne disparaîtront jamais, mais ce soir, au moins ce soir, les gens porteront un toast pour célébrer un nouveau monde, un nouveau soi.\nAinsi, au moment où l'ancien cède la place au nouveau, les gens accueillent avec des feux d'artifice.\nParmi toutes les choses intéressantes, les feux d'artifice sont ma plus grande passion. Tout le monde les regarde, les voyant brûler, s'élever dans les airs, éclater, comme s'ils regardaient une divinité, admirant cette brillance éphémère et incomparable.\nAvez-vous remarqué ? En regardant les feux d'artifice, le cœur de chacun est pur. Ils oublient la haine, oublient la souffrance, oublient toute la saleté. Les cœurs de tous deviennent un lac paisible, à la surface immaculée, où ne se reflète que la beauté des feux d'artifice.\nChut... Ne demandez pas ce qu'il y a après les feux d'artifice. Le nouveau-né est peut-être un luxe, mais ne trahissez pas pour autant sa floraison.\nParmi toutes les choses indésirables, les feux d'artifice sont les plus purs. Ce soir, je souhaite vous offrir la mienne.\nLevez la tête, ne clignez pas des yeux. Regardez ces étoiles brillantes s'élever, lors de l'éclatement des feux d'artifice, accueillez un nouveau vous, Gardien.\n\n« Mille Éventails »"
  },
  Mail_129806_Name = {
    Text = "feu d'artifice"
  },
  Mail_129806_Sender = {Text = "Xu"},
  Mail_130223_Desc = {
    Text = "Cher Gardien :\n L'événement «Naissance Inversée» est Terminé. Les «Poussière d'Écailles Pâles», «Poussière d'Écailles Rouges» et «Poussière d'Écailles Brillantes» restantes du Gardien ont été converties au taux de «Billet Rose Dorée» × 40 par unité. Veuillez vérifier votre courrier."
  },
  Mail_130223_Name = {
    Text = "Récupération de Poussière d'Écailles"
  },
  Mail_130223_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_131005_Desc = {
    Text = "Cher Gardien :\nL'événement « L'appel de Merscus » est terminé. Les « Conque numéro un », « Escargot de mer numéro deux » et « Coquillage marin numéro trois » restants seront échangés contre « Billet Rose Dorée » × 40 par unité. Veuillez noter de les récupérer."
  },
  Mail_131005_Name = {
    Text = "Récupération d'escargots de mer"
  },
  Mail_131005_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_131093_Desc = {
    Text = "Cher Gardien :\nL'événement « Fête Brûlante·clon » est terminé. Les « Os Tibia », « Coquille à feuilles rondes » et « Spirale des Ruines » restants seront échangés contre « Billet Rose Dorée » × 40 pour chaque unité. Veuillez noter."
  },
  Mail_131093_Name = {
    Text = "Recyclage de la monnaie du festin brûlant"
  },
  Mail_131093_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_131767_Desc = {
    Text = "Moi @2 ! @3, je suis @2 le suprême @3 mélange @4 et destruction ! Crie @4... ! \n\n Oh là là ! Regarde ce que tu as fait !!! Tu as touché aux tabous du Dieu suprême ! Eh bien, maintenant, ses chuchotements résonnent dans le monde où tu te trouves, et la catastrophe noire commencera à se propager à partir de ton communicateur, engloutissant tout autour de toi... \n Pauvre petit, ta témérité me met vraiment dans une situation difficile. Mais ne désespère pas trop, par chance dans le malheur, tu m'as rencontrée — la grande fée du culte, l'élue du Dieu, l'exécuteur du Dieu suprême, l'héritière légale du grand culte, la libératrice des souffrances, l'amie du roi des dieux ! Je suis la volonté du Dieu de la bonté et de l'amour, qui ne supporte pas la souffrance dans ce monde, et je vais utiliser mon pouvoir suprême pour sauver chaque petit espiègle. \n Oh, j'ai vu ton regard moqueur. Pas de souci, le Dieu de la bonté aime l'humanité et ne se soucie jamais de l'ignorance des gens. Le manque de confiance envers le sauveur est une étape incontournable pour chaque croyant. Ces cadeaux de bienvenue sont la faveur de l'exécuteur de Dieu envers toi. \n Maintenant, le chemin lumineux a été indiqué pour toi : apporte ta sincérité au grand cathédrale @2 située dans la ville @3, et offre ta loyauté au Dieu de la bonté, et tu obtiendras le pouvoir tant désiré, te libérant de la malédiction de ce cauchemar. Bien sûr, il te faudra également offrir ta richesse. Ne te méprends pas, le Dieu de la bonté ne se soucie jamais des récompenses terrestres, mais ses croyants ont aussi besoin d'argent pour agir. Ne sois pas avare de ces choses banales, cher croyant, chaque centime a son prix. \n Crie le nom du Dieu de la bonté et attends le moment de la descente du miracle ! \n\n Grande fée du culte, élue du Dieu"
  },
  Mail_131767_Name = {
    Text = "Veuillez ne pas toucher ce @2"
  },
  Mail_131767_Sender = {Text = "Caraboo"},
  Mail_132339_Desc = {
    Text = "Cher Gardien :\nL'événement « Résurrection du Roi des Dieux · Réplique » est terminé. Les « Pensées fatiguées », « Tristesse mélancolique » et « Pensées joyeuses » restantes des Gardiens du secret seront converties au taux de 40 Billets Rose Dorée par échange. Veuillez vous rappeler de vérifier."
  },
  Mail_132339_Name = {
    Text = "Récupération de la monnaie de la renaissance du roi divin"
  },
  Mail_132339_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_132458_Desc = {
    Text = "Cher Gardien :\n        Merci pour votre soutien et votre reconnaissance envers « Veille de l'oubli ». Afin d'offrir une meilleure expérience de jeu aux Gardiens du secret à l'Université de Misargh, nous vous invitons à remplir le questionnaire d'expérience ci-dessous. En remerciement de votre coopération, nous avons préparé un « Cœur d'argent » × 200 comme récompense, que vous pourrez réclamer en complétant le questionnaire. La date limite pour remplir le questionnaire est le 17 août à 9h00, veuillez en tenir compte.\n        <SurveyLink:[Cliquez ici pour remplir]>\n        Nous écouterons attentivement les suggestions de chaque Gardien, vos retours contribueront à améliorer l'Université de Misargh !\n        — Que la Clé d'Argent éclaire ton chemin."
  },
  Mail_132458_Name = {
    Text = "Questionnaire d'enquête sur l'expérience de la version V2.5.3"
  },
  Mail_132458_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_132578_Desc = {
    Text = "Cher Gardien :\nLors de la saison « {s1} » de « Rail céleste effréné », vous avez obtenu le titre « {s2} ».\nVous recevrez les récompenses bonus suivantes. N'oubliez pas de les récupérer."
  },
  Mail_132578_Name = {
    Text = "Récompenses de saison « Rail céleste effréné »"
  },
  Mail_132578_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_132579_Desc = {
    Text = "Cher Gardien :\nLors de la saison « {s1} » de « Échecs de Phase : Pré-groupe », vous avez obtenu le titre « {s2} ».\nVous recevrez les récompenses bonus suivantes. N'oubliez pas de les récupérer."
  },
  Mail_132579_Name = {
    Text = "Récompenses de saison « Échecs de Phase : Pré-groupe »"
  },
  Mail_132579_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_132580_Desc = {
    Text = "Cher Gardien :\nLors de la saison « {s1} » de « Plongée dans l'illusion », vous avez obtenu le titre « {s2} ».\nVous recevrez les récompenses bonus suivantes. N'oubliez pas de les récupérer."
  },
  Mail_132580_Name = {
    Text = "Récompenses de saison « Plongée dans l'illusion »"
  },
  Mail_132580_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_132581_Desc = {
    Text = "Cher Gardien :\nLors de la saison « {s1} » de « Échecs de Phase : Mode de sélection de roue », vous avez obtenu le titre « {s2} ».\nVous recevrez les récompenses bonus suivantes. N'oubliez pas de les récupérer."
  },
  Mail_132581_Name = {
    Text = "Récompenses de saison « Échecs de Phase : Mode de sélection de roue »"
  },
  Mail_132581_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_132605_Desc = {
    Text = "Cui Cui Cui, Cui Cui Cui Cui Cui !\n(Gardien, joyeux poisson d'avril !)\nCui Cui Cui, Cui Cui !\n(Photo d'identité, souvenir !)\n« Empreinte de patte de loutre humide et en désordre »\n« Un tas d'empreintes floues laissées par des échecs de gouttes de cire à cacheter »\n                                                         — une empreinte de patte de loutre parfaitement correcte"
  },
  Mail_132605_Name = {
    Text = "Un tas de papier mouillé"
  },
  Mail_132605_Sender = {Text = "Cui !"},
  Mail_133276_Desc = {
    Text = "Cher Gardien :\nL'événement « La Grande Conquête : Activité Réveil Rerun » est terminé. Les « Délicieux barbecue de Léon » restants seront convertis au taux de 40 « Billet Rose Dorée » par article. N'oubliez pas de vérifier vos récompenses."
  },
  Mail_133276_Name = {
    Text = "Récupération de la monnaie du rôti de Léo"
  },
  Mail_133276_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_133703_Desc = {
    Text = "Cher Gardien :\n La version {s1} est Terminée. Les «Noyaux Éthérés» Restants des Gardiens du secret ont été automatiquement convertis au taux de 1 «Noyau Éthéré» contre 1 «Cœur Immaculé». Au total, «Cœur Immaculé» × {s2} ont été convertis. Veuillez vérifier votre réception."
  },
  Mail_133703_Name = {
    Text = "Avis de conversion du « Cœur Éthéré »"
  },
  Mail_133703_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_133704_Desc = {
    Text = "Cher Gardien :\n La version {s1} est sur le point de se terminer. Veuillez utiliser vos «Noyaux Éthérés» Restants avant la fin. À la clôture du Curriculum de cette période, les «Noyaux Éthérés» Restants des Gardiens du secret seront automatiquement convertis au taux de 1 «Noyau Éthéré» contre 1 «Cœur Immaculé»."
  },
  Mail_133704_Name = {
    Text = "Avis d'expiration du « Cœur Éthéré »"
  },
  Mail_133704_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_134024_Desc = {
    Text = "Cher Gardien :\nL'« Entraînement quotidien » a été supprimé. Les « Certificats d'agent » restants seront convertis au taux de « Billet Rose Dorée » × 10000 par certificat. N'oubliez pas de vérifier vos récompenses."
  },
  Mail_134024_Name = {
    Text = "Recyclage des Certificats d'agent"
  },
  Mail_134024_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_134067_Desc = {
    Text = "Gardien,\n\nIl y a quelque chose de spécial dont j'aimerais discuter avec vous aujourd'hui.\nJe veux simplement me promener en ville, regarder tranquillement toutes sortes de choses intéressantes, aller où bon me semble — passer une journée ordinaire.\n\nAlors je suis allée demander au Bureau des affaires académiques. Ils m'ont dit que pour des raisons de sécurité, je ne suis autorisée à quitter le campus que si vous m'accompagnez.\nIls m'ont aussi dit de ne pas effrayer les gens, et de ne pas mettre dans ma bouche tout ce que je vois quand je suis dehors. Quelle impolitesse.\nEh bien, c'est comme ça. Alors, pourrions–nous sortir nous promener ensemble ? Tous ensemble, tout le monde.\n\n...Pour une raison quelconque, il m'est venu à l'esprit que les graines de pissenlit chevaucheront un jour le vent et partiront en voyage vers là où le destin les mènera.\nPeut–être que ce sera demain, ou peut–être que ce ne sera pas avant très, très longtemps.\nEn y réfléchissant, faire plus de choses ensemble avec tout le monde tant que je le peux encore, ça ne semble pas si mal.\n\nEn tout cas, je vous attendrai devant le dortoir. S'il vous plaît !\n\nSaya"
  },
  Mail_134067_Name = {
    Text = "Flâner en ville..."
  },
  Mail_134067_Sender = {Text = "Saya"},
  Mail_134068_Desc = {
    Text = "Gardien :\n\nJe trouve qu'aujourd'hui est un jour spécial. Mais les contours de mes souvenirs restent si flous.\nSeul le nom «Saya» me rattache encore, tant bien que mal, à cet endroit.\n\nCe sentiment n'est ni de la solitude, ni de la tristesse, rien d'aussi vif que cela.\nS'il fallait absolument donner un nom à ce que je ressens... ce serait sans doute «le vide».\nUn temps où il n'y a rien, infiniment limpide et transparent, paisible.\n\nSi un jour, les graines de pissenlit portées par le vent\nretombaient simplement, blanches et silencieuses, dans chaque recoin de ce monde...\nAlors peut-être pourrais-je enfin sentir que ce monde est »spécial«.\n\nÀ ce moment-là, la brume grise qui enveloppe Londinium, les nuages embrasés de rouge au coucher du soleil, et ce ciel que tu contemplais toujours depuis la place de l'école, tout serait recouvert de pissenlits, teinté d'un blanc pur. Teinté de ma couleur.\n\nAlors... si tu voulais bien m'offrir quelque chose,\nce n'est pas un cadeau qu'il me faut, juste un »souvenir«.\n\nMoi, dans ce monde d'un blanc pur où fleurissent les pissenlits,\nj'attends simplement, en silence, la venue de cet instant.\n\nLorsqu'un jour tu lèveras à nouveau les yeux vers le ciel sur la place de Misage,\nfais se superposer, ne serait-ce qu'un peu,\ncette touffe de duvet blanc effleurant le bord de ton regard\navec la silhouette de celle qui t'a parlé autrefois.\n\nSaya"
  },
  Mail_134068_Name = {
    Text = "La promesse du pissenlit..."
  },
  Mail_134068_Sender = {Text = "Saya"},
  Mail_139809_Desc = {
    Text = "Cher Gardien :\n        Merci pour votre soutien et votre reconnaissance envers [ Veille de l'oubli ]. Afin d'offrir aux Gardiens du secret une meilleure expérience de jeu à l'Université de Misargh, nous vous invitons sincèrement à remplir le questionnaire d'enquête sur l'expérience ci-dessous. En témoignage de notre gratitude pour votre coopération, nous avons préparé Cœur d'argent × 200 en récompense, qui pourra être réclamée à la fin du questionnaire. La date limite de l'enquête est le 16 mai à 9h00. Veuillez vous assurer de le remplir à temps.\n        <SurveyLink:[Cliquez ici pour remplir]>\n        Nous prendrons soigneusement en compte les suggestions de chaque Gardien, et vos retours contribueront certainement à rendre l'Université de Misargh toujours meilleure !\n        —Que la Clé d'Argent éclaire ton chemin."
  },
  Mail_139809_Name = {
    Text = "Questionnaire de retour d'expérience V2.5.0"
  },
  Mail_139809_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_139927_Desc = {
    Text = "Cher Gardien :\nL'événement « Symphonie invisible·clon » est Terminé. Vos « Chant héroïque » restants ont été convertis au taux de 40 × Billet Rose Dorée chacun. Veuillez les récupérer."
  },
  Mail_139927_Name = {
    Text = "Mélodie aigüe récupérée"
  },
  Mail_139927_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_140084_Desc = {
    Text = "Cher Gardien :\nL'événement «Des milliers de lumières brillantes descendent·clon» est Terminé. Les «Sceau de la Richesse», «Sceau de Sang» et «Sceau de Guerre» Restants du Gardien ont été convertis au taux de «Billet Rose Dorée» × 40 par unité. Veuillez vérifier votre courrier."
  },
  Mail_140084_Name = {
    Text = "Récupération de balles"
  },
  Mail_140084_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_140478_Desc = {
    Text = "Cher Gardien du Secret :\n\nL'événement « Source d'Affection » est terminé. Veuillez trouver ci-joint les récompenses non réclamées de l'événement. N'oubliez pas de les récupérer."
  },
  Mail_140478_Name = {
    Text = "Réédition des récompenses du Flot d'engouement"
  },
  Mail_140478_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_140690_Desc = {
    Text = "Cher Gardien :\nL'événement « Jusqu'aux Dernières Neiges·clon » est terminé. Les devises d'événement « Bouton de fleur gelé », « Bouton de fleur d'argent givré » et « Bouton de soleil » restantes seront échangées au taux de « Billet Rose Dorée*40 » par unité. Veuillez les récupérer."
  },
  Mail_140690_Name = {
    Text = "Récupération de bourgeons"
  },
  Mail_140690_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_140751_Desc = {
    Text = "Cher Gardien :\nL'événement «Avant que le printemps ne fane·clon» est Terminé. Les «Poème joyeux», «poésie mélancolique» et «Poème de Regret» Restants du Gardien ont été convertis au taux de «Billet Rose Dorée» × 40 par unité. Veuillez vérifier votre courrier."
  },
  Mail_140751_Name = {
    Text = "Recyclage de poèmes"
  },
  Mail_140751_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_141372_Desc = {
    Text = "Cher Gardien :\nL'événement «Ebwynnos Evermore» est Terminé. Les «Fraîche » Proie «», «Colossale » Proie «» et «Primordiale » Proie «» Restantes du Gardien ont été converties au taux de «Billet Rose Dorée» × 40 par unité. Veuillez vérifier votre courrier."
  },
  Mail_141372_Name = {
    Text = "Récupération de devises Ebwynnos Evermore"
  },
  Mail_141372_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_141470_Desc = {
    Text = "Cher Gardien :\nL'événement «Prisonnier Miroir·clon» est Terminé. Les «Livre de sens commun», «Livre de mathématiques» et «Livre de littérature» Restants du Gardien ont été convertis au taux de «Billet Rose Dorée» × 40 par unité. Veuillez vérifier votre courrier."
  },
  Mail_141470_Name = {
    Text = "Récupération de la monnaie du prisonnier miroir"
  },
  Mail_141470_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_141507_Desc = {
    Text = "Gardien : \n\nLe jour de ma naissance, peut-être est-ce un jour important pour toi ? \nPour moi, le poids de chaque jour sur la toile du Destin est égal. Ce sont les autres histoires qui donnent à ce jour sa signification spéciale. \nJe suis né ce jour-là, j'ai compris la prophétie ce jour-là, j'ai reçu le fuseau du destin ce jour-là, et j'ai vu les fils complexes du destin, ainsi que les cauchemars au bout de ces fils. \nPour le tisseur du destin, ce jour est banal. Pour les acteurs sur scène, ce jour mérite d'être célébré. Et parmi toutes les identités, celle qui me procure le plus de joie est d'être moi-même un acteur. \nGardien, aujourd'hui, les lumières du théâtre du destin se sont toutes éteintes, ne laissant qu'une seule scène brillamment éclairée. Tu as mentionné vouloir voir plus des destins que j'ai vécus. Et maintenant, ce que cette scène s'apprête à présenter est une histoire à propos de moi-même. \nJe ne sais pas quelle partie sera jouée. J'apporterai mes souvenirs sur scène, et elle choisira un segment que tu souhaites le plus voir, pour le présenter sur la scène de ce soir dans ces moments intenses. \nCette histoire peut me causer de la douleur, ou elle peut m'embarrasser, mais cela n'a pas d'importance, n'est-ce pas ? Je pense que, parfois, laisser le fuseau tisser de lui-même et être un pur spectateur est une chose agréable. \nLe seul billet d'entrée pour cette performance est maintenant entre tes mains. S'il te plaît, viens avec cette lettre, Gardien. Ce soir, une histoire inconnue des autres attend ton arrivée. \n\nArachne"
  },
  Mail_141507_Name = {
    Text = "Histoire occulte"
  },
  Mail_141507_Sender = {Text = "Arachne"},
  Mail_141833_Desc = {
    Text = "Cher Gardien du secret :\n«Nouvelle Lune et Neige Profonde» est terminé. Les «Pommes Cramoisies», «Pommes d'Or» et «Pommes d'Amour» restantes du Gardien du secret seront converties au taux de «Billet Rose Dorée» × 40 par pomme. Veuillez penser à vérifier votre courrier."
  },
  Mail_141833_Name = {
    Text = "Récupération des Pommes"
  },
  Mail_141833_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_141957_Desc = {
    Text = "Cher Gardien :\n        Merci pour votre soutien et votre reconnaissance envers «Avant l'Aube de l'Oubli». Afin d'offrir aux Gardiens du secret une meilleure expérience de jeu à l'Université de Misargh, nous vous invitons à remplir le questionnaire d'enquête sur l'expérience ci-dessous. En guise de remerciement pour votre coopération, nous avons préparé «Cœur d'argent» × 200 comme récompense, réclamable une fois le questionnaire complété. Le questionnaire se clôture le 15 février à 9h00, veuillez le remplir dans les délais.\n        <SurveyLink:[Cliquez ici pour remplir le questionnaire]>\n        Nous écouterons attentivement les suggestions de chaque Gardien, et vos retours contribueront certainement à améliorer l'Université de Misargh !\n        — Que la Clé d'Argent éclaire ton chemin."
  },
  Mail_141957_Name = {
    Text = "Questionnaire d'enquête sur l'expérience de version V2.7.2"
  },
  Mail_141957_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_141958_Desc = {
    Text = "Cher Gardien :\n        Merci pour votre soutien et votre reconnaissance envers «Avant l'Aube de l'Oubli». Afin d'offrir aux Gardiens du secret une meilleure expérience de jeu à l'Université de Misargh, nous vous invitons à remplir le questionnaire d'enquête sur l'expérience ci-dessous. En guise de remerciement pour votre coopération, nous avons préparé «Cœur d'argent» × 200 comme récompense, réclamable une fois le questionnaire complété. Le questionnaire se clôture le 21 décembre à 9h00, veuillez le remplir dans les délais.\n        <SurveyLink:[Cliquez ici pour remplir le questionnaire]>\n        Nous écouterons attentivement les suggestions de chaque Gardien, et vos retours contribueront certainement à améliorer l'Université de Misargh !\n        — Que la Clé d'Argent éclaire ton chemin."
  },
  Mail_141958_Name = {
    Text = "Questionnaire d'enquête sur l'expérience de version V2.7.0"
  },
  Mail_141958_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_141959_Desc = {
    Text = "Cher Gardien :\n        Merci pour votre soutien et votre reconnaissance envers «Avant l'Aube de l'Oubli». Afin d'offrir aux Gardiens du secret une meilleure expérience de jeu à l'Université de Misargh, nous vous invitons à remplir le questionnaire d'enquête sur l'expérience ci-dessous. En guise de remerciement pour votre coopération, nous avons préparé «Cœur d'argent» × 200 comme récompense, réclamable une fois le questionnaire complété. Le questionnaire se clôture le 18 janvier à 9h00, veuillez le remplir dans les délais.\n        <SurveyLink:[Cliquez ici pour remplir le questionnaire]>\n        Nous écouterons attentivement les suggestions de chaque Gardien, et vos retours contribueront certainement à améliorer l'Université de Misargh !\n        — Que la Clé d'Argent éclaire ton chemin."
  },
  Mail_141959_Name = {
    Text = "Questionnaire d'enquête sur l'expérience de version V2.7.1"
  },
  Mail_141959_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_141960_Desc = {
    Text = "Cher Gardien :\n        Merci pour votre soutien et votre reconnaissance envers «Avant l'Aube de l'Oubli». Afin d'offrir aux Gardiens du secret une meilleure expérience de jeu à l'Université de Misargh, nous vous invitons à remplir le questionnaire d'enquête sur l'expérience ci-dessous. En guise de remerciement pour votre coopération, nous avons préparé «Cœur d'argent» × 200 comme récompense, réclamable une fois le questionnaire complété. Le questionnaire se clôture le 15 mars à 9h00, veuillez le remplir dans les délais.\n        <SurveyLink:[Cliquez ici pour remplir le questionnaire]>\n        Nous écouterons attentivement les suggestions de chaque Gardien, et vos retours contribueront certainement à améliorer l'Université de Misargh !\n        — Que la Clé d'Argent éclaire ton chemin."
  },
  Mail_141960_Name = {
    Text = "Questionnaire d'enquête sur l'expérience de version V2.7.3"
  },
  Mail_141960_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_141961_Desc = {
    Text = "Cher Gardien :\n        Merci pour votre soutien et votre reconnaissance envers «Avant l'Aube de l'Oubli». Afin d'offrir aux Gardiens du secret une meilleure expérience de jeu à l'Université de Misargh, nous vous invitons à remplir le questionnaire d'enquête sur l'expérience ci-dessous. En guise de remerciement pour votre coopération, nous avons préparé «Cœur d'argent» × 200 comme récompense, réclamable une fois le questionnaire complété. Le questionnaire se clôture le 12 avril à 9h00, veuillez le remplir dans les délais.\n        <SurveyLink:[Cliquez ici pour remplir le questionnaire]>\n        Nous écouterons attentivement les suggestions de chaque Gardien, et vos retours contribueront certainement à améliorer l'Université de Misargh !\n        — Que la Clé d'Argent éclaire ton chemin."
  },
  Mail_141961_Name = {
    Text = "Questionnaire d'enquête sur l'expérience de version V2.7.4"
  },
  Mail_141961_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_141962_Desc = {
    Text = "Cher Gardien :\n        Merci pour votre soutien et votre reconnaissance envers «Avant l'Aube de l'Oubli». Afin d'offrir aux Gardiens du secret une meilleure expérience de jeu à l'Université de Misargh, nous vous invitons à remplir le questionnaire d'enquête sur l'expérience ci-dessous. En guise de remerciement pour votre coopération, nous avons préparé «Cœur d'argent» × 200 comme récompense, réclamable une fois le questionnaire complété. Le questionnaire se clôture le 10 mai à 9h00, veuillez le remplir dans les délais.\n        <SurveyLink:[Cliquez ici pour remplir le questionnaire]>\n        Nous écouterons attentivement les suggestions de chaque Gardien, et vos retours contribueront certainement à améliorer l'Université de Misargh !\n        — Que la Clé d'Argent éclaire ton chemin."
  },
  Mail_141962_Name = {
    Text = "Questionnaire d'enquête sur l'expérience de version V2.7.5"
  },
  Mail_141962_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_142101_Desc = {
    Text = "Cela fait longtemps, %player% :\n\nLorsque tu recevras cette lettre, je serai probablement en train de survoler Yagreau. Chaque année, durant ce mois, mon périple de chasse me mène toujours un peu plus loin.\nRien n'est plus approprié comme musique d'anniversaire que les cris et les gémissements de ses ennemis. D'autant que j'ai préparé suffisamment de cages — tant qu'il se trouvera des imbéciles pour vénérer ces faux dieux qui n'apportent rien d'autre que la souffrance, sans aucune Rédemption, je les ferai prendre conscience de leur erreur, aux quatre coins du monde.\nParfois, lorsque ma monture traverse les nuages et que la Lune devient visible, des pensées absurdes me traversent l'esprit l'espace d'un instant.\nComme celle de savoir quand ce temps-là s'arrêtera soudainement, de manière irrévocable et forcée, tout comme la vie s'est effondrée autrefois sans le moindre signe avant-coureur.\nMais je me retrouve aussitôt à rire de moi-même. Le jour où j'y ai mis les pieds, je me suis engagé sur un chemin sans retour. Je suis certain que tu comprends ce que je veux dire, petit. Dans ce monde, personne ne se trouve dans une situation plus semblable à la mienne que toi.\nNous avons tous deux fait des choix qui n'en étaient pas vraiment, et la bonne nouvelle, c'est que nous apprécions tous deux nos choix.\nPour cette nouvelle année, il te suffit de souffler dans le sifflet de chasse que je t'ai offert, et j'apparaîtrai à tes côtés à tout moment.\nBien sûr, sauf imprévu, laisse-moi d'abord profiter pleinement de ce voyage. Le mois prochain, je t'apporterai des souvenirs et quelques nouvelles.\nJe te souhaite tout le meilleur, je te souhaite d'être heureux.\n\nTon cher «oncle»"
  },
  Mail_142101_Name = {Text = "Nouvelles"},
  Mail_142101_Sender = {
    Text = "Votre cher «Oncle»"
  },
  Mail_143935_Desc = {
    Text = "Cher gardien du secret :\nL'événement « Texte temporaire » est terminé. Les « Textes temporaires » restants seront échangés contre « Billet Rose Dorée » × 40 pour chaque unité. Veuillez noter."
  },
  Mail_143935_Name = {
    Text = "Récupération de texte temporaire"
  },
  Mail_143935_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_145435_Desc = {
    Text = "Cher Gardien :\nL'événement « Le Jeu du Léviathan » est terminé. Les « Sacrifice Cramoisi » restants ont été convertis au taux de « Billet Rose Dorée » × 40 par article. N'oubliez pas de récupérer vos récompenses."
  },
  Mail_145435_Name = {
    Text = "Conversion du Sacrifice Cramoisi"
  },
  Mail_145435_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_145468_Desc = {
    Text = "Cher Gardien :\nL'événement « Si tout est normal·clon » est terminé. Les « Coquillages de spécialité côtière » restants ont été convertis au taux de « Billet Rose Dorée » × 40 par article. N'oubliez pas de récupérer vos récompenses."
  },
  Mail_145468_Name = {
    Text = "Recyclage de coquillages spécialisés en bord de mer"
  },
  Mail_145468_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_146401_Desc = {
    Text = "Les calendriers sont une invention fastidieuse. Aucun jour ne diffère d'un autre — aujourd'hui y compris.\nSelon votre calendrier, aujourd'hui est le jour de ma naissance. Bien que « naissance » ne soit guère le mot juste pour moi. Je suis un éclat arraché au chaos, une lame forgée et aiguisée au fil d'innombrables batailles. Aucun ventre ne m'a créée ; j'ai été façonnée par chaque adversaire qui a jamais croisé le fer avec moi. Et vous —\nvous êtes le plus essentiel d'entre tous.\nVos semblables chérissent des jours comme celui-ci. Festins, cadeaux, vœux — je n'en ai nul besoin.\nJ'ai seulement besoin d'un combat.\nVous avez accompli des choses remarquables ces derniers jours. Mais je sais que ce que vous avez montré est loin de vos limites.\nAu crépuscule aujourd'hui, au terrain d'entraînement. Apportez votre arme ; je vous attendrai. Oubliez victoire ou défaite, vie ou mort. L'affrontement sans réserve de nos lames est le seul cadeau que je désire.\nMontrez-moi de quoi un fragment de @4 est véritablement capable.\nJe pense que vous me surprendrez, mon « adversaire »."
  },
  Mail_146401_Name = {
    Text = "Ma Seule Attente"
  },
  Mail_146401_Sender = {
    Text = "Lotan : Cétarque"
  },
  Mail_146873_Desc = {
    Text = "Cher gardien du secret :\nL'événement « Texte temporaire » est terminé. Les « Textes temporaires » restants seront échangés contre « Billet Rose Dorée » × 40 pour chaque unité. Veuillez noter."
  },
  Mail_146873_Name = {
    Text = "Récupération de texte temporaire"
  },
  Mail_146873_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_147081_Desc = {
    Text = "Les calendriers sont une invention fastidieuse. Aucun jour ne diffère d'un autre — aujourd'hui y compris.\nSelon votre calendrier, aujourd'hui est le jour de ma naissance. Bien que « naissance » ne soit guère le mot juste pour moi. Je suis un éclat arraché au chaos, une lame forgée et aiguisée au fil d'innombrables batailles. Aucun ventre ne m'a créée ; j'ai été façonnée par chaque adversaire qui a jamais croisé le fer avec moi. Et vous —\nvous êtes le plus essentiel d'entre tous.\nVos semblables chérissent des jours comme celui-ci. Festins, cadeaux, vœux — je n'en ai nul besoin.\nJ'ai seulement besoin d'un combat.\nVous avez accompli des choses remarquables ces derniers jours. Mais je sais que ce que vous avez montré est loin de vos limites.\nAu crépuscule aujourd'hui, au terrain d'entraînement. Apportez votre arme ; je vous attendrai. Oubliez victoire ou défaite, vie ou mort. L'affrontement sans réserve de nos lames est le seul cadeau que je désire.\nMontrez-moi de quoi un fragment de @4 est véritablement capable.\nJe pense que vous me surprendrez, mon « adversaire »."
  },
  Mail_147081_Name = {
    Text = "Ma Seule Attente"
  },
  Mail_147081_Sender = {
    Text = "Lotan : Cétarque"
  },
  Mail_147535_Desc = {
    Text = "Cher gardien du secret :\nL'événement « Texte temporaire » est terminé. Les « Textes temporaires » restants seront échangés contre « Billet Rose Dorée » × 40 pour chaque unité. Veuillez noter."
  },
  Mail_147535_Name = {
    Text = "Récupération de texte temporaire"
  },
  Mail_147535_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_147798_Desc = {
    Text = "Cher Gardien du secret :\n        Dans la mise à jour V2.6.0, nous avons corrigé le problème des récompenses cachées manquantes dans la Mission d'enquête Oubli H7-6. Étant donné que vous aviez déjà terminé H7-6 avant la correction, nous vous envoyons directement les récompenses cachées manquantes. Veuillez vérifier votre courrier."
  },
  Mail_147798_Name = {
    Text = "Renvoi des récompenses cachées de H7-6"
  },
  Mail_147798_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_147875_Desc = {
    Text = "Cher Gardien du secret :\n        Dans la mise à jour V2.6.0, nous avons corrigé le problème des récompenses cachées manquantes dans la Mission d'enquête Oubli H7-9. Étant donné que vous aviez déjà terminé H7-9 avant la correction, nous vous envoyons directement les récompenses cachées manquantes. Veuillez vérifier votre courrier."
  },
  Mail_147875_Name = {
    Text = "Renvoi des récompenses cachées de H7-9"
  },
  Mail_147875_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_148080_Desc = {
    Text = "Cher Gardien du secret :\n        Dans la mise à jour V2.6.0, nous avons amélioré les récompenses des «Spécifications de la chambre élégante». Pour les Gardiens du secret ayant déjà réclamé toutes les récompenses supplémentaires avant la mise à jour, nous vous enverrons les récompenses correspondantes. Veuillez vérifier votre courrier."
  },
  Mail_148080_Name = {
    Text = "Renvoi des récompenses de Spécifications de la chambre élégante"
  },
  Mail_148080_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_148081_Desc = {
    Text = "Cher Gardien du secret :\n        Dans la mise à jour V2.6.0, nous avons amélioré les récompenses du «Niveau de Plongée en eaux profondes». Pour les Gardiens du secret ayant déjà réclamé toutes les récompenses supplémentaires avant la mise à jour, nous vous enverrons les récompenses correspondantes. Veuillez vérifier votre courrier."
  },
  Mail_148081_Name = {
    Text = "Renvoi des récompenses de Niveau de Plongée en eaux profondes"
  },
  Mail_148081_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_148082_Desc = {
    Text = "Cher Gardien du secret :\n        Dans la mise à jour V2.6.0, nous avons amélioré les récompenses du «Niveau de Sélection de roue». Pour les Gardiens du secret ayant déjà réclamé toutes les récompenses supplémentaires avant la mise à jour, nous vous enverrons les récompenses correspondantes. Veuillez vérifier votre courrier."
  },
  Mail_148082_Name = {
    Text = "Renvoi des récompenses de Niveau de Sélection de roue"
  },
  Mail_148082_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_148083_Desc = {
    Text = "Cher Gardien du secret :\n        Dans la mise à jour V2.6.0, nous avons amélioré les récompenses du «Niveau de Pré-groupe». Pour les Gardiens du secret ayant déjà réclamé toutes les récompenses supplémentaires avant la mise à jour, nous vous enverrons les récompenses correspondantes. Veuillez vérifier votre courrier."
  },
  Mail_148083_Name = {
    Text = "Renvoi des récompenses de Niveau de Pré-groupe"
  },
  Mail_148083_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_148476_Desc = {
    Text = "Cher Gardien du secret :\n        Les récompenses obtenues par achat dans «{s1}» n'ont pas encore été réclamées. Nous vous les envoyons en pièce jointe par courrier. Pensez à libérer de l'espace dans votre sac avant de les récupérer."
  },
  Mail_148476_Name = {
    Text = "Récompense non réclamée de «{s1}»"
  },
  Mail_148476_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_148477_Desc = {
    Text = "Cher Gardien du secret :\n        Les récompenses obtenues dans «{s1}» n'ont pas encore été réclamées. Nous vous les envoyons en pièce jointe par courrier. Pensez à libérer de l'espace dans votre sac avant de les récupérer."
  },
  Mail_148477_Name = {
    Text = "Récompense non réclamée de «{s1}»"
  },
  Mail_148477_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_148478_Desc = {
    Text = "Cher Gardien du secret :\n        Les récompenses obtenues dans le «Curriculum - Sujet avancé» de la période {s1} n'ont pas encore été réclamées. Nous vous les envoyons en pièce jointe par courrier. Pensez à libérer de l'espace dans votre sac avant de les récupérer."
  },
  Mail_148478_Name = {
    Text = "Renvoi des récompenses non réclamées du Sujet avancé de la période {s1}"
  },
  Mail_148478_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_148514_Desc = {
    Text = "Cher Gardien du secret :\n        Dans la mise à jour de la version V1.4.3.5, nous avons ajouté le niveau «Nouveau roi» dans «Monde des Rêves Étranges : Profanation». Certains Gardiens du secret, n'ayant pas été informés de cette mise à jour en temps voulu, ont cru à tort avoir entièrement terminé «Monde des Rêves Étranges : Profanation».\n        À cet effet, dans la mise à jour de la version V2.6.2, nous avons rattrapé la progression du niveau «Nouveau roi» pour les Gardiens du secret ayant déjà terminé les niveaux suivant «Nouveau roi» avant la mise à jour, et nous vous envoyons simultanément les récompenses de première complétion correspondantes. Veuillez vérifier votre courrier."
  },
  Mail_148514_Name = {
    Text = "Rattrapage de progression «Profanation»"
  },
  Mail_148514_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_148515_Desc = {
    Text = "Cher Gardien du secret :\n\nTa-da~ Surpris(e) ? C'est le premier anniversaire de cette fée sur Mizag, alors —\nFigure-toi ! Pas le moindre e-mail promotionnel, pas d'Invitation à la messe, pas même une Prédiction de fin du monde~\nMais ne soyez pas déçu(e), cette fée a bien sûr préparé quelque chose de plus précieux et de meilleur pour ses fidèles les plus spéciaux.\nEn tant que fée marraine Omnisciente et omnipotente, il va de soi que j'anticipe les doutes et les méfiances légitimes — même si cela me cause un léger chagrin. Cependant, pour répandre les bienfaits de notre ordre, un petit Sacrifice est toujours inévitable.\nAlors, prenez du recul et essayez donc — vous n'avez rien à perdre, et si c'était vrai ? N'est-ce pas ?\nC'est une opportunité qui ne se présente qu'une fois par an, à ne manquer sous aucun prétexte~\nSans aucun Sacrifice, sans promesse ni échange, il vous suffit de partager un doux thé de l'après-midi avec la fée marraine pour découvrir combien de sentiments sincères sont enfouis sous la glace et la neige.\nN'est-ce pas là une proposition des plus alléchantes ?\nNote : Veuillez vous munir d'au moins 10, 100, 1000 Léofang pour régler l'addition — plus vous en avez, mieux c'est.\n\nVous Attendant dans ce café que nous connaissons tous,\nCaraboo"
  },
  Mail_148515_Name = {
    Text = "☆☆☆Super E-mail de Bienfaits☆☆☆"
  },
  Mail_148515_Sender = {Text = "Caraboo"},
  Mail_149949_Desc = {
    Text = "Cette lettre a circulé dix mille fois à travers les royaumes des vivants et des morts. NE LA SUPPRIME PAS !\n\nLa quinzième nuit du septième mois, la porte des fantômes s'ouvre en grand, le vent froid se lève, et les âmes errantes rentrent chez elles.\nJe suis ███ de la ville de Hu dans l'antique Empire de Panlong — Yizhi Yè, artisan Zhizha, plieur d'effigies en papier et d'offrandes funèbres, à votre service !\n\nPar le décret du Festival des Fantômes de Zhongyuan, portant le talisman-écrit d'invocation des âmes, je pose cette malédiction sur toi ce soir. Quiconque pose les yeux sur ces mots : ton âme sera inscrite dans le registre, ton nom est déjà gravé à l'encre dans le grand livre.\n\nEt si elle n'est pas transmise à cinquante âmes du monde des vivants avant l'Heure de Zi, quand la nuit bascule vers minuit, tu vas très certainement —\n\n...tes documents se corrompront une seconde avant d'être sauvegardés...\n...ton thé à la bubble tea manquera à jamais trois perles...\n...ton Communiquant à Cœur d'argent restera à 1 % de batterie pour l'éternité — tu auras beau le charger, il ne se remplira jamais...\n\nSois sage et fais ce qu'on te dit : la malédiction se dissoudra d'elle-même, le talisman se consumera en cendres, aucun esprit vengeur ne te suivra à la trace, et ta lampe de vie brûlera encore et encore.\n\nFAIS-LA SUIVRE !! MAINTENANT !!!"
  },
  Mail_149949_Name = {
    Text = "SUPPRIME CECI, ET TU VERRAS..."
  },
  Mail_149949_Sender = {Text = "Yizhi Yè"},
  Mail_149985_Desc = {
    Text = "Mon Seigneur :\n\nJe vous écris à l'improviste, en espérant ne pas vous importuner. Mais certaines pensées ne peuvent être confiées qu'à vous seul.\nCette nuit, j'ai fait un rêve comme je n'en avais plus fait depuis longtemps. Je me retrouvais dans ma demeure d'autrefois. Tout m'était si familier : la main douce et généreuse de mon père, les chansons rustiques que fredonnait la servante en Nettoyant, et ce petit cheval blanc qui m'appartenait… Je croyais avoir laissé tout cela s'enliser dans les marécages de ma mémoire, et pourtant, les retrouver en songe m'a réchauffé le cœur tout autant qu'avant.\nÀ mon réveil, j'ai aperçu par la fenêtre des maîtres et des élèves de Mizag qui bavardaient en passant, dans une quiétude si douce que, l'espace d'un instant, cette scène ne me semblait guère différente de celle de mon rêve. J'ai également remarqué que la présence invisible qui me hante était étrangement silencieuse depuis ce matin. Se pourrait-il que le jour de son anniversaire apporte véritablement un peu de chance ?\nS'il en est ainsi, peut-être puis-je me permettre d'être un peu cupide aujourd'hui…\nJe sais que les gens aiment formuler des vœux le jour de leur anniversaire, comme une promesse faite à l'année à venir. Il y a longtemps que je n'ose plus espérer recevoir les vœux de qui que ce soit, mais il est une chose que je souhaite véritablement obtenir.\nTout comme vous m'avez accordé votre confiance, je ne vous dissimulerai rien, aussi permettez-moi de vous confier ce vœu :\nSi vous avez une mission à confier la prochaine fois, je vous demande de me nommer comme Garde et de m'autoriser à vous accompagner.\nQuoi qu'il arrive, je souhaite pouvoir toujours être le premier à me dresser devant vous dans les moments où vous avez le plus besoin d'aide, et devenir votre Bouclier le plus solide.\nTel est le vœu que je formule pour cette année.\n\nOgier"
  },
  Mail_149985_Name = {
    Text = "Vœu d'anniversaire…"
  },
  Mail_149985_Sender = {
    Text = "Origine : Ogier"
  },
  Mail_18019_Desc = {
    Text = "Cher Gardien:\nLe système a détecté une action de remboursement sur le compte actuel. L'équipe de production a déduit la monnaie virtuelle correspondant à votre commande de remboursement le {s1}. Si le solde affiche une valeur négative après la déduction, il doit être rétabli à un montant positif avant toute utilisation normale.\nSi vous avez des questions, veuillez contacter le service client."
  },
  Mail_18019_Name = {
    Text = "Avis de Traitement de Remboursement"
  },
  Mail_18019_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_18020_Desc = {
    Text = "Bonjour, Gardien. La récompense de {s1} vous a été envoyée en tant que pièce jointe d'e-mail en raison de votre inventaire étant plein. Veuillez libérer votre inventaire et la réclamer rapidement."
  },
  Mail_18020_Name = {
    Text = "Récompenses non réclamées rééditées"
  },
  Mail_18020_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_18021_Desc = {
    Text = "Cher Gardien,\nL'événement Registre des sujets en cours se terminera le {s1} [GMT+8]. Les récompenses liées à ce Registre des sujets ne seront plus disponibles après la fin de l'événement. Veuillez vous assurer de récupérer vos récompenses avant la fin de l'événement."
  },
  Mail_18021_Name = {
    Text = "Rappel de Collecte de Récompenses de Formation"
  },
  Mail_18021_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_18029_Desc = {
    Text = "Bonjour, Gardien, voici vos récompenses de classement de la Plongée Fantasmale."
  },
  Mail_18029_Name = {
    Text = "Récompenses de classement de la plongée fantomale"
  },
  Mail_18029_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_18031_Desc = {
    Text = "Cher Gardien :\n\nLe chemin à venir est long et parsemé d'épines. En ces temps difficiles, nous devons rester unis et avancer ensemble.\nCi-joint, l'approvisionnement de Menophin spécialement approuvé pour aujourd'hui. Veuillez l'accepter.\nQue la Clé Argentée éclaire votre chemin.\nP.S.: La distribution de cet approvisionnement spécial est maintenant complète. Merci pour votre travail acharné et votre dévouement.\n\nDépartement Logistique de la Faculté Mythag"
  },
  Mail_18031_Name = {
    Text = "Distribution de l'approvisionnement intrathécal"
  },
  Mail_18031_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_18034_Desc = {
    Text = "Bonjour, Gardien, vous avez des récompenses de points cumulés non réclamées de la Plongée Fantasmale, qui vous seront envoyées par pièces jointes d'e-mail."
  },
  Mail_18034_Name = {
    Text = "Récompenses cumulatives non réclamées pour la Plongée Fantasmatique"
  },
  Mail_18034_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_18035_Desc = {
    Text = "Cher Gardien :\n\nLe chemin à venir est long et parsemé d'épines. En ces temps difficiles, nous devons rester unis et avancer ensemble.\nCi-joint, l'approvisionnement de Menophin spécialement approuvé pour aujourd'hui. Veuillez l'accepter.\nQue la Clé Argentée éclaire votre chemin.\nP.S.: Votre approvisionnement spécialement approuvé restera valide pendant {s1} jours. Veuillez planifier en conséquence votre emploi du temps d'enquête.\n\nDépartement Logistique de la Faculté Mythag"
  },
  Mail_18035_Name = {
    Text = "Distribution de l'approvisionnement intrathécal"
  },
  Mail_18035_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_20231_Desc = {
    Text = "Cher Gardien, la nouvelle saison de Traphase a commencé, réinitialisant votre rang de {s1} à {s2}. Les récompenses de rang de la nouvelle saison ont été réinitialisées. Vous pouvez gagner plus d'honneur et de récompenses en avançant votre rang ! {s3}\n{s4}"
  },
  Mail_20231_Name = {
    Text = "Courrier de Saison Traphase"
  },
  Mail_20231_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_21453_Desc = {
    Text = "Cher Gardien :\n\nDésolé de vous déranger, mais je me demande comment vous allez dernièrement ?\nJe m'excuse d'interrompre votre emploi du temps chargé. Jenkin et les autres préparent une petite fête d'anniversaire pour moi. Après mûre réflexion, j'ai décidé de vous envoyer cette invitation moi-même.\nLa plupart des orphelins recueillis par l'atelier ne peuvent pas se souvenir de leurs dates de naissance, alors Mademoiselle Sarah fixe la date de notre arrivée à l'orphelinat comme notre anniversaire. Cependant, je suis différent. Mademoiselle Sarah m'a dit que j'avais été laissé sur le pas de la porte de l'hôpital de jour lors d'une nuit d'hiver extrêmement froide. Elle voulait que ma vie soit remplie de chaleur, alors elle a choisi un jour chaud comme mon anniversaire. C'est un jour qui m'appartient, un jour rempli de soins et d'amour. C'est un jour important pour moi, et j'espère que vous, Gardien, pourrez vous joindre à moi. C'est mon Petit Vœu. Bien sûr, si cela ne peut être réalisé, cela ne fait rien, car vous, Gardien, avez de nombreuses affaires à traiter, et Aigis comprend cela.\nSi cette invitation vous a causé des désagréments, veuillez me le faire savoir et acceptez mes sincères excuses. Cependant, si par chance vous pouvez trouver du temps, vous êtes le bienvenu pour vous joindre à leurs espiègleries - cela pourrait être très amusant, puisque c'est préparé par Jenkin.\n\nAigis"
  },
  Mail_21453_Name = {
    Text = "Désolé de vous déranger au milieu de votre emploi du temps chargé..."
  },
  Mail_21453_Sender = {Text = "Aigis"},
  Mail_21454_Desc = {
    Text = "Hey:\nJe me suis toujours demandé ce qu'il y a de si spécial à célébrer son anniversaire. Pourquoi les gens en font-ils une si grande affaire ?\nL'année dernière, à cette date, un étudiant est venu me demander ma date de naissance. C'était ridicule—quand je suis né, il n'y avait pas de concept de temps sur cette planète, encore moins d'anniversaires. Mais elle a continué à m'importuner jusqu'à ce que je n'aie d'autre choix que de lui dire \"c'est quand le jour et la nuit sont égaux.\" Je ne sais toujours pas comment elle a interprété ça.\nJ'écris cette lettre pour te rappeler de ramasser les fleurs devant ma porte après minuit ce soir ; elles sont écrasantes !\n\nLotan"
  },
  Mail_21454_Name = {
    Text = "Ces fleurs..."
  },
  Mail_21454_Sender = {Text = "Lotan"},
  Mail_21455_Desc = {
    Text = "Erica apporta aujourd'hui un grand sac de café comme cadeau d'anniversaire, disant que c'est votre approvisionnement pour l'année. <Del:Mais étiez-vous prêt à faire cela ? Si ce n'est pas le cas,>\n Si c'est une blague de la Poupée ou de quelqu'un d'autre, bien que je sois réticent, je peux toujours le retourner... Après tout, c'est du café ! Je ne peux pas fonctionner sans quelques tasses. Une année entière sans ça ? Vous dormiriez probablement comme Tulu. Ce n'est pas qu'il soit mauvais, c'est juste que des choses noires apparaissent la nuit... Quoi qu'il en soit, si vous avez besoin de le reprendre, n'hésitez pas à le prendre à tout moment. Mais si vous le laissez ici, <Del:je le ferai> je serais très heureux. Je peux enfin réaliser l'expérience que je voulais faire : extraire et concentrer la caféine en un agent qui peut être absorbé par la peau, me permettant de rester éveillé toujours, toujours...\n\n\nDans l'attente de cette expérience, Bigorneau"
  },
  Mail_21455_Name = {Text = "Café..."},
  Mail_21455_Sender = {Text = "Winkle"},
  Mail_21456_Desc = {
    Text = "Anniversaire ?\nSi je dois dire, mon anniversaire n'est pas un bon jour. Des centaines, voire des milliers de vies innocentes meurent ce jour-là, juste pour que je \"sois né\" et continue à en tuer d'autres.\nAlors, il n'y a vraiment rien à célébrer. Mais je comprends que vous, les humains, êtes très attachés aux \"rituels\", et par coïncidence, j'ai un peu d'argent sur moi — rassurez-vous, c'est mon argent durement gagné en vendant ma sueur au Trout Club, pas de revenus illégaux.\nPrenez cet argent et achetez-vous un cadeau, comme si vous célébriez mon anniversaire.\n\nUvhash"
  },
  Mail_21456_Name = {
    Text = "Anniversaire..."
  },
  Mail_21456_Sender = {Text = "Uvhash"},
  Mail_21457_Desc = {
    Text = "Keeper: \n\n Y a-t-il une coutume de célébration des anniversaires dans le domaine de Mythag ? \n Dans mes souvenirs de ma patrie... de grandes cérémonies étaient tenues chaque année pour célébrer l'anniversaire du roi. \n Avec le temps, la signification spéciale de \"anniversaire\" a été conférée à tout le monde. \n Dans un lointain passé, en ce jour, collègues et amis parcouraient de grandes distances pour être à mes côtés. \n Ce sentiment d'être entouré de proches... cette chaleur semblable à celle d'être embrassé par le soleil... peut-être est-ce pourquoi je ne peux pas me défaire du passé. \n Ah... je radote. Ai-je dérangé votre travail ? \n J'ai préparé du thé et des collations que j'aimais autrefois, et j'aimerais les partager avec vous. \n Si vous en avez envie, venez me trouver après le dîner. \n\nFaros"
  },
  Mail_21457_Name = {
    Text = "Lumière immortelle..."
  },
  Mail_21457_Sender = {Text = "Faros"},
  Mail_21458_Desc = {
    Text = "Aujourd'hui est en effet un jour mémorable : le grand Lord Goliath, Roi des Géants, est arrivé ; l'océan a tremblé et les étoiles ont pâli.\nJ'ai entendu dire que l'extravagance n'est pas autorisée sur le campus, alors réduisons mon banquet d'anniversaire à un dixième de l'ordinaire—dix cochons rôtis, une centaine de pieuvres grillées et un groupe jouant des chansons folkloriques de Goliath. Oh, et prévoyez une douzaine de danseurs...\nQuoi ? Rien de tout cela n'est permis ?\nAlors juste les danseurs... Pas une douzaine, quatre ou cinq suffiront.\nQuoi ? Même cela n'est pas autorisé ?!\nDe si maigres standards sont indignes de mon statut. J'annonce par la présente : le banquet est annulé !\n\nGoliath"
  },
  Mail_21458_Name = {
    Text = "Plans de dîner..."
  },
  Mail_21458_Sender = {Text = "Goliath"},
  Mail_21459_Desc = {
    Text = "Gardien——\n\nAujourd'hui, pendant l'entraînement de mémoire chez Madame Sylvia, elle m'a demandé ma date d'anniversaire. Tu sais aussi que je peux oublier une clé à molette que je viens de poser, alors comment pourrais-je me souvenir de ma date d'anniversaire ! Plus grave encore, c'est une chose que moi seul connais, moi ! Cet anniversaire, c'est comme s'il n'existait pas. \n\nMais le prêtre Salvador a dit que la date exacte n'est pas importante, ce qui compte, c'est ce que je célèbre chaque jour, alors j'ai décidé que c'est mon anniversaire aujourd'hui ! J'ai déjà convenu avec quelqu'un (j'ai oublié qui c'est, ça ne devrait pas être toi, n'est-ce pas, Gardien ?) de faire la fête devant la cantine, tu dois absolument venir ! \n\n\n\nJe vais me souvenir de cette date d'anniversaire, Nautila.\n\n\n\nUn mot envoyé avec la lettre :\n\nL'enfant a écrit la lettre puis est parti en trombe, laissant la lettre et quelques cadeaux qu'il disait vouloir te donner sur la table. \nJ'ai tout mis dans l'enveloppe, j'attends de te voir ce soir à la fête. Ne t'inquiète pas, je lui rappellerai de se présenter ce soir. \n\n——Sylvia"
  },
  Mail_21459_Name = {
    Text = "L'anniversaire que j'ai décidé !"
  },
  Mail_21459_Sender = {Text = "Nautila"},
  Mail_21460_Desc = {
    Text = "Petit, \n\nIl n'y a ni étoiles ni lunes dans la Mer des Principes, ni de saisons. Par conséquent, mon anniversaire devrait être enregistré comme [Unknown].\nCependant, aujourd'hui est en effet un jour important, après tout, cette apparence est héritée d'une humaine qui avait un [ Vœu ]. Elle aimait les rassemblements animés, alors elle a ouvert cette petite boutique, mais à cause de ses enquêtes, son anniversaire n'était souvent partagé qu'avec moi. Pour réaliser son dernier vœu, la Boutique du Malheur organisera un dîner aux chandelles aujourd'hui, invitant sincèrement tous les clients fidèles à y assister.\nBien sûr, la Boutique du Malheur offrira également une petite réduction à tous les visiteurs, alors ne manquez pas cette occasion, Petit.\n\nDaffodil"
  },
  Mail_21460_Name = {
    Text = "Souhaits Terrestres..."
  },
  Mail_21460_Sender = {Text = "Daffodil"},
  Mail_21461_Desc = {
    Text = "Quand j'ai été arraché à ma famille, ma mère adoptive... la femme du gouverneur a brisé la tablette d'argile avec ma date de naissance, brisant mon passé de Tilo. Mon véritable anniversaire est devenu incertain.\nAprès avoir quitté Lai, j'ai réfléchi... Que dirais-tu de considérer la nuit où j'ai échappé à la cage et commencé ma vengeance comme mon «anniversaire» ?\nBien qu'il ne soit plus nécessaire de célébrer une année de plus, cela pourrait servir de rappel du passage du temps"
  },
  Mail_21461_Name = {
    Text = "Le Jour de la Naissance"
  },
  Mail_21461_Sender = {Text = "Helot"},
  Mail_21462_Desc = {
    Text = "Test, test.\nCher Gardien, bonjour. Si vous avez reçu cette lettre, cela signifie que votre contribution est cruciale pour Erica, et vous avez été sélectionné pour participer au programme annuel de test et de maintenance du module linguistique de l'automate Erica. Cette évaluation est menée sous forme de questions à réponse courte, vous demandant de faire des retours sur le fonctionnement du nouveau module linguistique EA-L-1033 installé pour l'automate Erica. Cela ne prendra pas beaucoup de votre temps, donc veuillez ne pas être nerveux ou anxieux.\nQuestion à réponse courte :\nAvez-vous compris l'essentiel de cette lettre ?\n\nVeuillez écrire votre réponse directement sous la question à réponse courte et sceller la lettre de nouveau dans l'enveloppe.\nMerci de votre participation.\n\nErica"
  },
  Mail_21462_Name = {
    Text = "Test, test..."
  },
  Mail_21462_Sender = {Text = "Erica"},
  Mail_21463_Desc = {
    Text = "Keeper: \n\n Vous êtes l'une des rares personnes lucides dans cette école. Votre regard peut percer ce corps défectueux et voir le vrai moi. \n Une personne comme vous devrait pouvoir expliquer clairement à ces enfants : je ne suis pas une sirène ; ce corps parcourra les mers et gravira les montagnes, atteignant une forme parfaite. \n ...Peu importe, je ne veux pas vous déranger. Mais au moins aujourd'hui, ne les laissez pas jouer avec ma queue. \n Aujourd'hui est spécial. Si vous avez le temps, j'aimerais vous dire quelque chose en personne. \n\nCaecus"
  },
  Mail_21463_Name = {
    Text = "Corps Parfait..."
  },
  Mail_21463_Sender = {Text = "Caecus"},
  Mail_21464_Desc = {
    Text = "Keeper:\n\nMon anniversaire au sens mondain est le jour où mon père m'a adopté.\nAuparavant, il attachait toujours une grande importance à ce jour, organisant de grands bals chaque année - danser dans un corset était plus épuisant que de balancer une épée trois mille fois.\nMais c'était sa façon d'exprimer son amour en tant que père, et je ne voulais pas le décevoir.\nCependant, cette année, il a enfin accepté de me laisser planifier mon propre anniversaire. Peut-être qu'à ses yeux, je ne suis plus une enfant qui a besoin de supervision constante.\nAu fait, peux-tu me rejoindre au sommet de la tour de l'horloge ? Nous pourrions discuter et profiter de la brise.\nJ'ai entendu dire que ce soir, il y aura une pleine lune.\n\nRamona"
  },
  Mail_21464_Name = {
    Text = "Pleine Lune..."
  },
  Mail_21464_Sender = {Text = "Ramona"},
  Mail_21465_Desc = {
    Text = "Cher, très cher Maître :\nOui, aujourd'hui, c'est l'anniversaire de Karen@1 (l'âge d'une dame doit rester un secret) ! \nPour cette occasion spéciale, Karen a préparé une fête grandiose sans pareille et invité tous les petits amis qu'elle pouvait ! Bien qu'en fin de compte, seuls Aurita, Ogier et Lily ont pu promettre d'assister...\nMais ce n'est pas grave. Là où il y a des gens, il y a des fêtes, et là où il y a des fêtes, Karen sera là ! Karen a également soigneusement préparé un ragoût de grenouille \"amélioré\", des limaces noires à l'ail, et une soupe de chauve-souris au curry. Maître doit absolument venir les essayer !\n\nUne petite question silencieuse : Maître a sûrement préparé un cadeau pour Karen, n'est-ce pas ? N'oubliez pas, cela doit être brillant !\n\nVotre humble servante,\nKaren"
  },
  Mail_21465_Name = {Text = "Cadeau..."},
  Mail_21465_Sender = {Text = "Karen"},
  Mail_21466_Desc = {
    Text = "Cher <Del:Gardien> West-Whelp :\nC'est une <Del:invitation invitaten invitate>, en résumé, viens manger gratuitement du gâteau, et profiter pour célébrer mon anniversaire ! En fait, c'est aussi pour te remercier de m'avoir aidé à retrouver ma sœur, et de m'avoir amené ici, me permettant ainsi à moi et à Brun de trouver un endroit sûr où rester.\n(Tout cela, c'est Aigis qui m'a poussé à l'écrire, c'est vraiment trop mièvre. Notre relation n'a pas besoin de tout ça, pas vrai, Gardien ?)\nEn bref, ce soir, dans la cour derrière ta chambre, moi, Brun et Aigis avons préparé quelques bonnes choses, on t'attend pour les partager ensemble ! Bien sûr, c'est surtout Aigis qui s'en est chargée, ce qu'elle fait est vraiment délicieux, les cuisinières la complimentent souvent pour son talent. Tu regretteras de ne pas venir, j'te l'dis !\n\nTon vieux pote, Jenkin et Brun"
  },
  Mail_21466_Name = {
    Text = "Chers habitants de West Siders..."
  },
  Mail_21466_Sender = {Text = "Jenkin"},
  Mail_21467_Desc = {
    Text = "Gardien du Secret : \n\nAlors que les humains vivaient encore dans le royaume des dieux, nous exprimions déjà nos émotions par la danse — tournoyant de joie, avançant dans la tristesse... Certains disent que l'histoire de la danse est aussi longue que celle de l'humanité, elle a été témoin de notre gloire comme de notre déclin.\n\nJ'ai déjà dit que je ne danserais plus, mais... je suis né pour danser. Alors, rien qu'aujourd'hui, acceptez-vous de danser avec moi ? Plongez avec moi, ressentez les battements les plus profonds du Corps.\n\nJe vous attends dans la salle de danse.\n\n\n\nLiz"
  },
  Mail_21467_Name = {
    Text = "Invitation à danser"
  },
  Mail_21467_Sender = {Text = "Liz"},
  Mail_21468_Desc = {
    Text = "Gardien respecté : \n\n Avant que je ne devienne un Réveilleur, mes anniversaires se déroulaient toujours de la même façon : mes camarades de combat et moi-même rapportions discrètement de l’alcool depuis l’extérieur du camp militaire, puis nous fêtions cela en cachette dans la tente où étaient entreposées les fournitures, accompagnés de notre pain noir de ration. Avant que les officiers ne découvrent tout, nous jetions les bouteilles dans les buissons à l’extérieur.\n\nMais Mythag n’est pas une armée, ici, nous pouvons nous laisser aller à nos envies. Je me demandais si tu accepterais de partager une bonne bouteille avec moi pour célébrer mon anniversaire ?\nSi tu es d’accord, rejoins-moi sur la terrasse du dortoir à l’heure où la lune passera au-dessus de la tour de l’horloge ce soir. Tu n’as peut-être pas fait attention, mais c’est depuis cet endroit qu’on a la plus belle vue de tout Mythag.\n\n\n\nElva"
  },
  Mail_21468_Name = {
    Text = "Partagez le bon breuvage..."
  },
  Mail_21468_Sender = {Text = "Alva"},
  Mail_21469_Desc = {
    Text = "Plage ! Plage ! Plage ! Plage ! \nHein ? Écrire le nom du destinataire au début est tellement fastidieux ! Le Gardien n'écrit jamais le destinataire sur les notes du frigo !\nAujourd'hui c'est l'anniversaire d'Aurita... euh... quel âge a-t-elle encore ? Quoi qu'il en soit, c'est l'anniversaire d'Aurita !\nCe sont les trésors d'Aurita ! Tout pour toi ! S'il te plaît, emmène Aurita à la plage, s'il te plaît, s'il te plaît, s'il te plaît !\nConsidère cela comme un cadeau d'anniversaire pour Aurita, d'accord ?\n\nAurita"
  },
  Mail_21469_Name = {Text = "Plage !"},
  Mail_21469_Sender = {Text = "Aurita"},
  Mail_21470_Desc = {
    Text = "Cher ami,\n\nDans le passé, ma sœur et moi, sur la étoile stérile, nous nous serions embrassés et aurions tiré de l'énergie de la même plante pour commémorer notre naissance. \nCes jours-là étaient amers, mais maintenant ils apportent joie et chaleur. \nAujourd'hui marque encore l'anniversaire de notre naissance. Si possible, puis-je échanger une chanson contre une branche ? \nUne douce branche qui représente ma sœur et moi, et notre avenir avec toi...\n\nTeinture"
  },
  Mail_21470_Name = {
    Text = "Chanson d'anniversaire"
  },
  Mail_21470_Sender = {Text = "Tinct"},
  Mail_21471_Desc = {
    Text = "Par la grâce du Destin, Gardien de l'Université de Mythag, maître sage et bienveillant :\nQue la paix soit avec vous !\nIl y a quelques jours, j'ai remarqué une charrette entrant dans les écuries de l'école, livrant un cheval de sang chaud. Je me souviens qu'au cours de notre dernière mission d'investigation, vous aviez mentionné n'avoir jamais monté à cheval auparavant. Une jument de sang chaud jeune et douce est la plus adaptée pour les débutants.\nMonter à cheval, chasser l'aube et le crépuscule, fait partie de mes souvenirs les plus chers. Si vous le souhaitez, j'aimerais partager cette joie avec vous.\n\nOgier"
  },
  Mail_21471_Name = {
    Text = "Cheval Sanglant"
  },
  Mail_21471_Sender = {Text = "Ogier"},
  Mail_21472_Desc = {
    Text = "L'ancien calendrier diffère grandement de celui utilisé à Londinium aujourd'hui.\nJe suis né le cinquième jour de pleine étoile du deuxième mois d'été. La décision de célébrer aujourd'hui repose sur les calculs du directeur du laboratoire.\nQuand l'ancienne nation existait encore, le Vieux grand prêtre s'occupait de tout. Après de grandes cérémonies, la nation entière célébrait avec sept jours de congé.\nBien que ce ne fût pas mon vœu, je n'avais aucune raison d'empêcher la propagation de la joie.\nAujourd'hui n'est pas un jour férié à Mizag, et en tant que Gardien, vous n'aurez pas de jours de repos réguliers.\nMais si vous demandez un jour de congé pour célébrer mon anniversaire, je doute que la direction s'y oppose.\nProfitez d'un après-midi tranquille.\n\nTulu"
  },
  Mail_21472_Name = {
    Text = "Anniversaire..."
  },
  Mail_21472_Sender = {Text = "Tulu"},
  Mail_21473_Desc = {
    Text = "Gardien: \n\n Aurita dit que ceux qui ont des anniversaires doivent toujours faire des souhaits. \n Et il se trouve que je suis quelqu'un qui ne fait jamais de souhaits. \n Parce que mes pensées se réalisent toujours. Ce n'est pas de la chance ; ça ressemble plus à... un guide de destin ? \n Tout comme le mois dernier quand je suis sorti en mer avec Céleste, j'ai \"juste eu la chance\" de trouver un magnifique fossile. \n Les habitants l'appellent \"lys de mer\". Ses bras ondulent comme des moulins à vent contre le courant, profitant paresseusement du soleil de l'après-midi d'été. \n Fragile, beau. Quand je l'ai vu, ton image m'est naturellement venue à l'esprit. \n Cette fois, je n'ai toujours pas fait de souhait— \n Tu vas sûrement l'adorer, n'est-ce pas ? \n\nSanga"
  },
  Mail_21473_Name = {
    Text = "Lily de mer..."
  },
  Mail_21473_Sender = {Text = "Sanga"},
  Mail_21475_Desc = {
    Text = "Gardien:\n\nLorsque je naviguais avec Elton, il préparait un festin ce jour-là chaque année et me demandait de \"faire un vœu\".\nAvant de venir ici, je ne savais pas ce qu'était un \"vœu\". Maintenant, je ne sais pas ce que je pourrais souhaiter...\nPeut-être que trouver un \"vœu\" pourrait être mon \"vœu\" ?\n\nCéleste"
  },
  Mail_21475_Name = {Text = "Souhait..."},
  Mail_21475_Sender = {Text = "Celeste"},
  Mail_21476_Desc = {
    Text = "Gardien: \n\n Aurita m'a dit que tu peux réaliser tous les souhaits faits pour les anniversaires, est-ce vrai ? \n Cela ne peut pas être vrai, n'est-ce pas ? Réaliser les souhaits de tout le monde serait trop de travail pour toi. \n Cependant, si je pouvais faire un souhait... je voudrais que Tinct ait une scène plus grande. \n Serait-ce trop difficile à réaliser ? Hmm... Alors, que dirais-tu de le changer en \"pour l'année prochaine, il n'y aura pas de céleri sur ma table\" ? Est-ce acceptable ? \n\nÉvanouissement"
  },
  Mail_21476_Name = {Text = "Souhait..."},
  Mail_21476_Sender = {Text = "Faint"},
  Mail_21477_Desc = {
    Text = "Cher Gardien:\n\nLaissez-moi vous confier un secret : cet anniversaire n'est pas réel. Quant à ma véritable date de naissance... laissez-la s'envoler avec le vent.\nAprès être tombé malade, mon frère avait toujours le majordome préparer secrètement un petit gâteau pour moi le jour de mon anniversaire.\nPas de chants d'anniversaire, pas de bénédictions—célébrer un anniversaire semblait être quelque chose de honteux.\nMaintenant, tout a changé. Je peux marcher au soleil, chanter à voix haute et même célébrer mon anniversaire.\nCes petites joies peuvent sembler minimes, mais elles me remplissent de nostalgie.\nMerci, Gardien.\n\n(Bien sûr, si vous et tout le monde pouviez être un peu plus brusques, un peu plus agressifs... ce serait parfait.)\n\nLeigh"
  },
  Mail_21477_Name = {
    Text = "Un secret..."
  },
  Mail_21477_Sender = {Text = "Leigh"},
  Mail_21478_Desc = {
    Text = "Mon Petit·Prisonnier:\n\nCela fait si longtemps, si longtemps, si longtemps que je n'ai pas manœuvré le fouet—\nPiégée dans cette école ennuyeuse, piégée dans ces uniformes ; le cœur de Pandia démange comme un petit chat espiègle grattant à l'intérieur. Mais personne ne me comprend, et le personnel fait tout pour m'empêcher de \"m'amuser\"—c'est tellement injuste !\nAh, aujourd'hui est un jour spécial, parfait pour que mon fouet touche à nouveau une peau douce, pour que j'entende le chant de la douleur... Si tu as du temps aujourd'hui, pourquoi ne pas venir discuter avec moi~?\n\nPandia"
  },
  Mail_21478_Name = {
    Text = "Le son du fouet..."
  },
  Mail_21478_Sender = {Text = "Pandia"},
  Mail_21479_Desc = {
    Text = "<Big:Le Spectacle d'Anniversaire du Magicien Casiah, Aujourd'hui Seulement!>\n\nPour remercier notre public pour ses années de soutien et d'encouragement, et pour rendre la joie que vous nous avez apportée, le Magicien Casiah donnera une performance d'anniversaire spéciale ce soir à 20h dans la Cour de l'Université Mythag (à côté de la Statue de Phillips)! Ce soir, attendez-vous à une scène plus éblouissante, des numéros plus palpitants, et—surtout—une magie encore plus extraordinaire qui vous laissera en admiration! Même le Cerveau de Mythag serait sidéré par cette magie sans précédent, garantie par Maître Casiah!\n\nNe manquez pas cet événement rare et gratuit ce soir! Maître Casiah vous attend!\n\n<Small:PS: Casiah ne sera pas responsable de tout symptôme tel que la fatigue ou le moral bas pendant ou après le spectacle.>\n<Small:PPS: Toute promotion liée au Cerveau de Mythag est soumise à des circonstances réelles. Casiah se réserve tous les droits d'interpréter le programme et ses effets.>"
  },
  Mail_21479_Name = {
    Text = "Performance Anniversaire du Maître Magicien Casiah !"
  },
  Mail_21479_Sender = {Text = "Casiah"},
  Mail_21480_Desc = {
    Text = "Hey, aujourd'hui c'est mon anniversaire. Où est mon cadeau ?\nQuoi ? Tu as oublié d'en préparer un...? Hmph, je savais que ça se passerait comme ça.\nVoici, prends ce calendrier. Il marque clairement mon anniversaire, mon jour de mort, l'anniversaire du premier jour où je suis arrivé à Mythag, ainsi que le Festival de la Joie et le Festival de la Récolte... Nous célébrerons tous ensemble. N'oublie pas la prochaine fois !\n\nSi tu oublies encore... Je suppose qu'il n'y a pas grand-chose que je puisse te faire de toute façon, hmph.\nMais juste n'oublie pas, d'accord ?\n\n- Agrippa"
  },
  Mail_21480_Name = {Text = "Hey..."},
  Mail_21480_Sender = {Text = "Agrippa"},
  Mail_21481_Desc = {
    Text = "Gardien :\n\nJe ne voulais pas écrire cette lettre, mais il semble qu'Erica ait rencontré des problèmes dans son fonctionnement, elle n'arrête pas de sonner avant que j'aie fini d'écrire cette lettre. \nL'anniversaire est une date sans signification pour moi, le taux de succès de l'expérience n'est pas plus élevé que les autres jours, mon index gnostique n'est pas affecté par cette date. Mais Ramona insiste pour faire de ce jour mon «jour de repos» et m'a limité l'accès à mon laboratoire aujourd'hui. \nJe n'ai nulle part où aller, alors aujourd'hui je vais procéder à un examen complet de tes rapports passés. \nViens au bureau des archives après le dîner. Fais attention, n'essaie pas d'apporter de gâteau dans le bureau des archives, les documents en papier sont très fragiles. \n\nPoupée"
  },
  Mail_21481_Name = {
    Text = "Après le dîner..."
  },
  Mail_21481_Sender = {Text = "Doll"},
  Mail_22435_Desc = {
    Text = "Cher Gardien:\nJ'ai initialement choisi de lire de la poésie à la lumière tamisée du matin sur le campus car j'ai trouvé qu'il y avait moins de passants à ce moment-là, ce qui me permettait de m'immerger plus facilement dans le monde de la poésie. Plus tard, je suis tombé amoureux de la douce lumière matinale, des gouttes de rosée cristallines et du chant mélodieux des oiseaux.\nÀ ma surprise, de nombreux enseignants et étudiants m'avaient observé discrètement et avaient formé un club de poésie en secret. Aujourd'hui est mon anniversaire, coïncidant avec l'épanouissement des fleurs de Nymphaea dans le club. À cette occasion, ils prévoient d'organiser un rassemblement d'appréciation poétique où nous pourrons profiter du paysage et réciter de la poésie ensemble sur le campus.\nJ'espère que vous vous joindrez à nous pour cette expérience spéciale.\n\nNymphaea"
  },
  Mail_22435_Name = {
    Text = "Invitation à une lecture de poésie"
  },
  Mail_22435_Sender = {Text = "Nymphaea"},
  Mail_23897_Desc = {
    Text = "Cher Gardien, \n        Dans la mise à jour V1.0.21, nous avons ajusté les récompenses pour l'« Opération » en difficulté Difficile, les niveaux de combat « Le Vagabond » en difficultés Normale et Difficile, et les récompenses de première réussite pour chaque niveau de Fissure I-IV dans le « Royaume Sans Lumière ». Des détails peuvent être trouvés dans le « Avis de Maintenance en Ligne V1.0.21 ».\n        Basé sur ta précédente enquête et tes progrès en défi, nous te accorderons les récompenses précédemment non collectées selon les ajustements. Veuillez consulter les pièces jointes."
  },
  Mail_23897_Name = {
    Text = "V1.0.21 Compensation d'Ajustement"
  },
  Mail_23897_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_24199_Desc = {
    Text = "Cher Gardien:\n        Dans la mise à jour V1.0.24, nous avons rouvert le Chapitre 5 de \"Opération\", qui avait été temporairement fermé dans V1.0.16. Pour garantir l'équité, nous effectuerons des compensations en fonction des changements dans les récompenses et les dossiers d'enquête de chaque Gardien. Selon vos dossiers, votre compensation a été envoyée dans la pièce jointe."
  },
  Mail_24199_Name = {
    Text = "V1.0.24 Compensation de Réouverture du Chapitre 5"
  },
  Mail_24199_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_24200_Desc = {
    Text = "Cher Gardien:\n        Dans la mise à jour V1.0.24, nous avons rouvert le Chapitre 5 de \"Opération\", qui avait été temporairement fermé dans V1.0.16. Pour garantir l'équité, nous effectuerons des compensations en fonction des changements dans les récompenses et les dossiers d'enquête de chaque Gardien. Selon vos dossiers, aucune compensation n'est requise cette fois-ci."
  },
  Mail_24200_Name = {
    Text = "V1.0.24 Compensation de Réouverture du Chapitre 5"
  },
  Mail_24200_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_24202_Desc = {
    Text = "Cher Gardien :\n        Merci pour votre soutien et votre reconnaissance envers « Veille de l'oubli ». Afin d'offrir une meilleure expérience de jeu aux Gardiens du secret à l'Université de Mizag, nous vous invitons à remplir le questionnaire d'expérience ci-dessous. En remerciement de votre coopération, nous avons préparé « Cœur d'argent » × 200 en tant que récompense, que vous pourrez recevoir une fois le questionnaire complété.\n        <SurveyLink:[Cliquez ici pour remplir]>\n        Nous écouterons attentivement les suggestions de chaque Gardien, vos retours contribueront à améliorer l'Université de Mizag !\n        —— Que la Clé d'Argent éclaire ton chemin."
  },
  Mail_24202_Name = {
    Text = "Enquête sur l'expérience de version V1.0"
  },
  Mail_24202_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_24280_Desc = {
    Text = "Bonjour, Gardien :\nVous avez atteint le \"Rang {s1}\" lors de l'enquête sur la plongée fantasmagorique d'hier, classé {s2}, avec le titre de l'enquête \"{s3}.\" Ci-dessous se trouvent vos récompenses de classement ; n'oubliez pas de les récupérer."
  },
  Mail_24280_Name = {
    Text = "Récompenses Quotidiennes du Classement de Plongée Fantomale"
  },
  Mail_24280_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_24877_Desc = {
    Text = "Gardien,\n\nChaque anniversaire a été le grand salon, rempli d'invités distingués et de célébrations joyeuses.\nMais cette fois, j'ai une idée différente—\nJ'ai occupé le siège de l'hôte trop longtemps. Parfois, je veux expérimenter le fait d'être un invité.\nQue ce soit un autre salon exquis ou un simple dîner en famille, c'est à vous de décider. Qu'en pensez-vous ?\nCependant, si vous choisissez un autre salon, n'invitez pas ces élites de la haute société.\nUn jour si rare et merveilleux, je ne veux pas porter un sourire faux.\n\n<Del:Rouge Dame> Sorel"
  },
  Mail_24877_Name = {
    Text = "C'est à toi..."
  },
  Mail_24877_Sender = {Text = "Sorel"},
  Mail_24878_Desc = {
    Text = "Maître,\n\nAujourd'hui, c'est l'anniversaire de Lily. Agrippa a dit qu'elle voulait « faire un grand spectacle ».\nAvant, Maman et Lily célébraient les anniversaires différemment. Maman me mettait un chapeau pointu, et nous applaudissions et soufflions les bougies ensemble.\nLily ne connaît pas la bonne façon de célébrer. Veuillez donner vos ordres, Maître.\n\nLily"
  },
  Mail_24878_Name = {
    Text = "Troublé..."
  },
  Mail_24878_Sender = {Text = "Lily"},
  Mail_25147_Desc = {
    Text = "Cher Gardien,\n        Dans la mise à jour V1.1.0, les récompenses de points hebdomadaires du Plongée Fantasmique ont été remplacées par de nouveaux « Essais Hebdomadaires ». Pour être juste, pour ceux qui ont débloqué « Plongée Fantasmique » mais n'ont pas réclamé toutes les récompenses de points hebdomadaires et se sont connectés avant 5h00 le 15 janvier, nous leur offrirons les récompenses de points hebdomadaires non réclamées. Veuillez vérifier."
  },
  Mail_25147_Name = {
    Text = "V1.1.0 Compensation de la Récompense Hebdomadaire de Plongée Fantomale"
  },
  Mail_25147_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_25148_Desc = {
    Text = "Cher gardien du secret :\n        Dans la mise à jour V1.1.0, les « récompenses hebdomadaires » de l'Échecs de Phase (bêta) ont été retirées et remplacées par « l'épreuve hebdomadaire », qui a le même avancement et les mêmes récompenses que l'épreuve hebdomadaire de la plongée dans l'illusion. Dans un souci d'équité, nous compensons les gardiens du secret qui ont déverrouillé l'Échecs de Phase (bêta) mais n'ont pas terminé ou réclamé les « récompenses hebdomadaires » de cette semaine, et qui se sont connectés au jeu avant le 15 janvier à 5h00 (UTC+8), avec une Perle d'érosion ×1000. Veuillez vérifier."
  },
  Mail_25148_Name = {
    Text = "V1.1.0 Compensation des récompenses hebdomadaires de Traphase"
  },
  Mail_25148_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_25414_Desc = {
    Text = "Cher Gardien, \n\nLa signification d'un anniversaire varie pour chacun. Cependant, l'anniversaire d'un Gardien est d'une grande importance pour tous les Mythag.\nMme Sylvia a préparé un dîner d'anniversaire pour vous dans la zone du dortoir. Le Doyen Czort et le Noble Dexter y assisteront. Sachant que votre fatigue mentale n'a pas encore diminué, j'ai préparé des vêtements formels pour vous, qui sont accrochés dans l'armoire près de la porte. Vous pouvez vous changer avant l'événement.\nJe suis honoré d'avoir passé cette année avec vous en tant que partenaire et j'espère le faire à nouveau l'année prochaine.\nQue la Clé Argent vous guide.\n\nP.S. Un gâteau personnalisé a été livré à votre dortoir par Erica.\n\nToujours votre partenaire, Ramona"
  },
  Mail_25414_Name = {
    Text = "Jour de la naissance..."
  },
  Mail_25414_Sender = {Text = "Ramona"},
  Mail_34667_Desc = {
    Text = "Cher @1@2, \n\nLe monde a oublié votre nom.\nC'est pourquoi je vous réveille, comme vous m'avez réveillé. Avant l'Arrivée, nous marchons, témoignons, puis nous souvenons et oublions.\nAujourd'hui est votre jour de naissance, une page des Fragments éparpillés de votre Mémoire. Voici mes soupirs et bénédictions.\nQue penserez-vous lorsque le monde évoquera votre forme complète ? Ou saurez-vous toujours et ne ressentirez rien ?\nJ'attends votre réponse dans le lieu inexistant.\n\n@2"
  },
  Mail_34667_Name = {
    Text = "Jour de la naissance..."
  },
  Mail_35231_Desc = {
    Text = "Cher Gardien :\n        Merci pour votre soutien et votre reconnaissance envers « Veille de l'oubli ». Afin d'offrir une meilleure expérience de jeu aux Gardiens du secret à l'Université de Mizag, nous vous invitons à remplir le questionnaire d'expérience ci-dessous. En remerciement de votre coopération, nous avons préparé « Cœur d'argent » × 200 en tant que récompense, que vous pourrez recevoir une fois le questionnaire complété.\n        <SurveyLink:[Cliquez ici pour remplir]>\n        Nous écouterons attentivement les suggestions de chaque Gardien, vos retours contribueront à améliorer l'Université de Mizag !\n        —— Que la Clé d'Argent éclaire ton chemin."
  },
  Mail_35231_Name = {
    Text = "Enquête sur l'expérience de version V1.1"
  },
  Mail_35231_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_35956_Desc = {
    Text = "Cher Gardien :\n        Merci pour votre soutien et votre reconnaissance envers « Veille de l'oubli ». Afin d'offrir une meilleure expérience de jeu aux gardiens à l'Université de Mizag, nous vous invitons à remplir le questionnaire de rétroaction ci-dessous. En remerciement de votre coopération, nous avons préparé un « Cœur d'argent » × 200 en guise de récompense, que vous pourrez réclamer en complétant le questionnaire. La date limite pour remplir le questionnaire est le 22 février à 5h00, veuillez en tenir compte.\n        <SurveyLink:[Cliquez ici pour remplir]>\n        Nous écouterons attentivement les suggestions de chaque Gardien, vos retours contribueront à améliorer l'Université de Mizag !\n        —— Que la Clé d'Argent éclaire ton chemin."
  },
  Mail_35956_Name = {
    Text = "Enquête sur l'expérience de version V1.1"
  },
  Mail_35956_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_36228_Desc = {
    Text = "Cher Gardien :\n        Merci pour votre soutien et votre reconnaissance envers « Veille de l'oubli ». Afin d'offrir une meilleure expérience de jeu aux gardiens à l'Université de Mizag, nous vous invitons à remplir le questionnaire d'expérience ci-dessous. En remerciement de votre coopération, nous avons préparé « Cœur d'argent » × 200 comme récompense, à récupérer après avoir complété le questionnaire. La date limite de soumission est le 17 juin à 9h00, veuillez veiller à le remplir à temps.\n        <SurveyLink:[Cliquez ici pour remplir]>\n        Nous écouterons attentivement les suggestions de chaque Gardien, vos retours contribueront à rendre l'Université de Mizag encore meilleure !\n        —— Que la Clé d'Argent éclaire ton chemin."
  },
  Mail_36228_Name = {
    Text = "Enquête sur l'expérience de version V1.4.1"
  },
  Mail_36228_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_36229_Desc = {
    Text = "Cher Gardien :\n        Merci pour votre soutien et reconnaissance envers « Veille de l'oubli ». Afin d'offrir une meilleure expérience de jeu aux gardiens à l'Université de Mizag, nous vous invitons à remplir le questionnaire d'expérience ci-dessous. En remerciement de votre coopération, nous avons préparé un « Cœur d'argent » × 200 en tant que récompense, que vous pourrez récupérer après avoir complété le questionnaire. La date limite de soumission du questionnaire est le 08 juillet à 9h00, veuillez le remplir à temps.\n        <SurveyLink:[Cliquez ici pour remplir]>\n        Nous écouterons attentivement les suggestions de chaque Gardien, vos retours contribueront à améliorer l'Université de Mizag !\n        —— Que la Clé d'Argent éclaire ton chemin."
  },
  Mail_36229_Name = {
    Text = "Enquête sur l'expérience de version V1.4.3"
  },
  Mail_36229_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_36230_Desc = {
    Text = "Cher Gardien :\n        Merci pour votre soutien et votre reconnaissance à l'égard de « Veille de l'oubli ». Afin d'offrir une meilleure expérience de jeu aux gardiens à l'Université de Mizag, nous vous invitons à remplir le questionnaire d'expérience ci-dessous. En remerciement de votre coopération, nous avons préparé « Cœur d'argent » × 200 en tant que récompense, que vous pourrez réclamer une fois le questionnaire complété. La date limite pour remplir le questionnaire est le 2 septembre à 9h00, veuillez le remplir à temps.\n        <SurveyLink:[Cliquez ici pour remplir]>\n        Nous écouterons attentivement les suggestions de chaque Gardien, vos retours contribueront certainement à améliorer l'Université de Mizag !\n        ——Que la Clé d'Argent éclaire ton chemin."
  },
  Mail_36230_Name = {
    Text = "Enquête sur l'expérience de version V1.5.3"
  },
  Mail_36230_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_36231_Desc = {
    Text = "Cher Gardien :\n        Merci pour votre soutien et votre reconnaissance envers « Veille de l'oubli ». Afin d'offrir une meilleure expérience de jeu aux gardiens à l'Université de Mizag, nous vous invitons à remplir le questionnaire d'expérience ci-dessous. En remerciement de votre coopération, nous avons préparé « Cœur d'argent » × 200 comme récompense, que vous pourrez obtenir en complétant le questionnaire. La date limite de soumission est le 5 août à 9h00, veuillez faire attention à le remplir à temps.\n        <SurveyLink:[Cliquez ici pour remplir]>\n        Nous écouterons attentivement les suggestions de chaque Gardien, vos retours contribueront à améliorer l'Université de Mizag !\n        — Que la Clé d'Argent éclaire ton chemin."
  },
  Mail_36231_Name = {
    Text = "Enquête sur l'expérience de version V1.5.1"
  },
  Mail_36231_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_36232_Desc = {
    Text = "Cher Gardien :\n        Merci pour votre soutien et votre reconnaissance envers « Veille de l'oubli ». Afin d'offrir une meilleure expérience de jeu aux gardiens à l'Université de Mizag, nous vous invitons à remplir le questionnaire de retour d'expérience ci-dessous. En remerciement de votre coopération, nous avons préparé un « Cœur d'argent » × 200 en tant que récompense, que vous pourrez récupérer après avoir complété le questionnaire. La date limite pour remplir le questionnaire est le 18 mai à 9h00, veuillez faire attention à le remplir à temps.\n        <SurveyLink:[Cliquez ici pour remplir]>\n        Nous écouterons attentivement les suggestions de chaque Gardien, vos retours contribueront à améliorer l'Université de Mizag !\n        —— Que la Clé d'Argent éclaire ton chemin."
  },
  Mail_36232_Name = {
    Text = "Enquête sur l'expérience de version V1.3"
  },
  Mail_36232_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_36233_Desc = {
    Text = "Cher Gardien :\n        Merci pour votre soutien et votre reconnaissance envers « Veille de l'oubli ». Afin d'offrir une meilleure expérience de jeu aux gardiens de l'Université de Mizag, nous vous invitons à remplir le questionnaire d'expérience ci-dessous. En remerciement de votre coopération, nous avons préparé « Cœur d'argent » × 200 en tant que récompense, que vous pourrez obtenir en complétant le questionnaire. La date limite pour soumettre le questionnaire est le 25 avril à 9h00, veuillez le remplir à temps.\n        <SurveyLink:[Cliquez ici pour remplir]>\n        Nous prendrons en compte les suggestions de chaque Gardien, vos retours contribueront à rendre l'Université de Mizag encore meilleure !\n        ——Que la Clé d'Argent éclaire ton chemin."
  },
  Mail_36233_Name = {
    Text = "Enquête sur l'expérience de version V1.3"
  },
  Mail_36233_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_36234_Desc = {
    Text = "Cher Gardien :\n        Merci pour votre soutien et votre reconnaissance envers « Veille de l'oubli ». Afin d'offrir une meilleure expérience de jeu aux gardiens à l'Université de Mizag, nous vous invitons à remplir le questionnaire d'expérience ci-dessous. En remerciement de votre coopération, nous avons préparé « Cœur d'argent » × 200 comme récompense, à récupérer après avoir complété le questionnaire. La date limite pour remplir le questionnaire est le 14 mars à 5h00, veuillez le remplir à temps.\n        <SurveyLink:[Cliquez ici pour remplir]>\n        Nous écouterons attentivement les suggestions de chaque Gardien, vos retours contribueront à rendre l'Université de Mizag toujours meilleure !\n        ——Que la Clé d'Argent éclaire ton chemin."
  },
  Mail_36234_Name = {
    Text = "Enquête sur l'expérience de version V1.2"
  },
  Mail_36234_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_36235_Desc = {
    Text = "Cher Gardien :\n        Merci pour votre soutien et votre reconnaissance envers « Veille de l'oubli ». Afin d'offrir une meilleure expérience de jeu aux gardiens à l'Université de Mizag, nous vous invitons à remplir le questionnaire d'expérience ci-dessous. En remerciement de votre coopération, nous avons préparé un « Cœur d'argent » × 200 en tant que récompense, que vous pourrez obtenir en complétant le questionnaire. La date limite pour remplir le questionnaire est le 4 avril à 9h00, veuillez faire attention à le remplir à temps.\n        <SurveyLink:[Cliquez ici pour remplir]>\n        Nous écouterons attentivement les suggestions de chaque Gardien, vos retours contribueront à améliorer l'Université de Mizag !\n        —— Que la Clé d'Argent éclaire ton chemin."
  },
  Mail_36235_Name = {
    Text = "Enquête sur l'expérience de version V1.2"
  },
  Mail_36235_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_36865_Desc = {
    Text = "Cher Gardien:\n        Dans la mise à jour V1.2.4, nous avons ajusté les récompenses des Épreuves Hebdomadaires \"Plongée Fantasmatique\" et ne fournirons plus de récompenses \"D-gemme\", \"D-gemmes Mimitique\", et \"Rose Dorée\". Dans un esprit d'équité, nous compenserons les Gardiens qui avaient débloqué \"Plongée Fantasmatique\" avant la mise à jour mais n'ont pas entièrement réclamé les récompenses de l'épreuve de cette semaine, avec les \"D-gemmes\" originales non réclamées, \"D-gemmes Mimitique\", et \"Rose Dorée\" de cette semaine, à condition qu'ils se connectent au jeu avant le 11 mars, 5h00. Veuillez vérifier vos récompenses."
  },
  Mail_36865_Name = {
    Text = "Ajustement des récompenses d'essai hebdomadaire Compensation V1.2.4"
  },
  Mail_36865_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_36866_Desc = {
    Text = "Cher Gardien:\n        Dans la mise à jour V1.2.4, débloquer les \"Sangs et Sables\" errants, \"Noyau Tordu\" et \"Souhait du Chevalier\" en mode Normal a débloqué de nouveaux Posse : \"Sang et Sable Rugissants\", \"Éternité Éphémère\", et \"Dernier Vœu\". Pour les Gardiens qui avaient terminé les chapitres ci-dessus en mode Normal avant la mise à jour, nous remettrons le Posse correspondant en compensation. Veuillez vérifier vos récompenses."
  },
  Mail_36866_Name = {
    Text = "V1.2.4 Rééditions du Posse Errant"
  },
  Mail_36866_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_36867_Desc = {
    Text = "Cher Gardien:\n        Dans la mise à jour V1.2.4, la quantité de matériaux d'amélioration de compétences uniques et de D-gemme tombée de \"L'Existence Transcendante\" a augmenté. Dans un esprit d'équité, pour les Gardiens qui ont réclamé les récompenses de cette semaine liées à \"L'Existence Transcendante\" avant la mise à jour, nous allons émettre des D-gemmes équivalentes à la valeur des augmentations en fonction du niveau recommandé des récompenses qu'ils ont reçues. Veuillez vérifier vos récompenses."
  },
  Mail_36867_Name = {
    Text = "Ajustement des récompenses d'existence transcendante Compensation V1.2.4"
  },
  Mail_36867_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_36871_Desc = {
    Text = "Chers Gardiens:\n En fonction de la difficulté la plus élevée terminée dans \"Plongée Fantasmique\" hier, vous recevrez les récompenses suivantes. Veuillez vous rappeler de vérifier votre inventaire."
  },
  Mail_36871_Name = {
    Text = "Récompenses d'Illusion Quotidienne"
  },
  Mail_36871_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_39293_Desc = {
    Text = "Cher Gardien:\n        Dans la mise à jour V1.2.7, terminer la plongée de conscience \"Chanson de Sculpture\", \"Descendant Pâle\", et \"Un Pas de Moins\" en mode Normal a débloqué de nouveaux Posse : \"Étreinte Mordre-Oss\", \"Aperçu au Bord du Lac\", et \"Traverser la Porte de la Rétrospection\". Pour les Gardiens ayant complété les chapitres ci-dessus en mode Normal avant la mise à jour, nous allons émettre le Posse correspondant en compensation. Veuillez vérifier vos récompenses."
  },
  Mail_39293_Name = {
    Text = "V1.2.7 Rééditions du Posse Errant"
  },
  Mail_39293_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_39548_Desc = {
    Text = "Cher Gardien:\n\nPour la vie éternelle, célébrer un anniversaire semble inutile. Comparé à l'infinie rivière du temps, les souvenirs que vous, les humains, appelez inoubliables ou merveilleux semblent plutôt... triviaux.\nPourtant, vous avez inventé d'innombrables festivals et célébrations pour commémorer ces moments \"triviaux\"—bien sûr, c'est aussi l'une des raisons pour lesquelles vous attisez mon intérêt. Vous êtes en effet assez adorables.\nCependant, vous rencontrer ne peut clairement pas être compté parmi ces moments \"triviaux\", car vous êtes différents d'eux... Et quel genre de tempête cette \"différence\" va déclencher à l'avenir, j'attends vraiment avec impatience. \nEh bien, pardonnez mon bavardage... Puisque aujourd'hui est mon anniversaire, je demande à exercer les \"Droits de l'Étoile d'Anniversaire\". \nQuant à ce que j'ai besoin que tu fasses, chhh... ne t'inquiète pas, la réponse est dans ma chambre, merci d'y aller seul à minuit ce soir.\n\nWanda"
  },
  Mail_39548_Name = {
    Text = "Les Droits de l'Étoile d'Anniversaire..."
  },
  Mail_39548_Sender = {Text = "Wanda"},
  Mail_39549_Desc = {
    Text = "Aujourd'hui, c'est l'anniversaire de Lord Murphy—les anniversaires devraient appeler à un festin et à une célébration ! \nLes gens du département logistique ont bien travaillé, mais ils ne savent vraiment pas comment organiser un spectacle et ont essayé de cacher des choses—Mademoiselle les a vus mettre des décorations de gâteau dans l'entrepôt du Département de Réveil il y a longtemps. Hmm... vous ne puniriez pas ces employés, n'est-ce pas ? Ils ont vraiment bien travaillé ; ils n'ont simplement pas assez bien caché la surprise...\nJe vais m'arrêter ici ; il semblerait que quelqu'un me cherche dehors—ils ne devraient pas essayer de me couvrir avec du papier coloré idiot.\nAu fait, vous serez là quand nous couperons le gâteau, n'est-ce pas ?\n\nMurphy"
  },
  Mail_39549_Name = {
    Text = "Banquet d'anniversaire..."
  },
  Mail_39549_Sender = {Text = "Murphy"},
  Mail_43571_Desc = {
    Text = "Cher gardien :\n        Dans la mise à jour V1.2.10, des récompenses ont été ajoutées pour les missions de l'événement [ Voyage dans la cité brumeuse ] : [Complétez la première chapitre de l'enquête « Secrets de l'Est » en difficulté difficile] et [Complétez la deuxième chapitre de l'enquête « Au nom des statues de cire » en difficulté difficile] : [ Cœur d'argent ] × 1000. Pour les gardiens qui ont déjà reçu les récompenses de ces missions avant la mise à jour, nous ferons un envoi supplémentaire des cœurs d'argent correspondants. Veuillez vérifier."
  },
  Mail_43571_Name = {
    Text = "V1.2.10 Récompenses pour le Voyage dans la Ville Brumeuse Réémises"
  },
  Mail_43571_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_43821_Desc = {
    Text = "Cher Gardien :\n        Dans la mise à jour V1.3.0, les étapes du \"Rapport de Mission\" 1/2/3/4/5/6 ont ajouté respectivement des récompenses de Expérience de Gardien 500/1000/1500/2000/2500/3000. Pour les Gardiens qui avaient déjà réclamé les récompenses pour les étapes ci-dessus avant la mise à jour, nous délivrerons l'expérience correspondante en compensation. Veuillez vérifier vos récompenses."
  },
  Mail_43821_Name = {
    Text = "Réémission de l'expérience du rapport de mission V1.3.0"
  },
  Mail_43821_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_44571_Desc = {
    Text = "Cher gardien :\n[ Le Pâtre des Âmes ] se terminera le 18 avril à 9h00 [GMT+8]. À la fin de l'événement, les entrées d'événements correspondantes seront fermées, y compris le chemin de l'église, le site de la vente de charité, etc. Les bons de vente non utilisés disparaîtront automatiquement. Gardien, n'oubliez pas d'acheter des articles au site de la vente de charité avant la fin de l'événement"
  },
  Mail_44571_Name = {
    Text = "L'événement du Berger des Âmes touche à sa fin"
  },
  Mail_44571_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_44690_Desc = {
    Text = "Bonjour, Gardien:\nVous avez effectué un travail sur le terrain lors de la plongée fantastique d'hier avec le titre d'investigation \"{s1}\". Voici vos récompenses de classement ; veuillez vous rappeler de les collecter."
  },
  Mail_44690_Name = {
    Text = "Récompenses du Classement de l'Agence de Plongée Fantasmatique"
  },
  Mail_44690_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_44831_Desc = {
    Text = "Cher Gardien:\n        Dans la mise à jour V1.3.0, terminer les Archives des Opérations Spéciales \"Fantômes de la Ville de Pluie\", \"Louanges de Rose\", et \"Magie de l'Histoire\" en mode Normal a débloqué de nouveaux Posse : \"Vraie Forme de Brume Grise\", \"Victoire de Rose\", et \"Rêve de Midsummer\". Pour les Gardiens ayant complété les chapitres ci-dessus en mode Normal avant la mise à jour, nous allons émettre le Posse correspondant en compensation. Veuillez vérifier vos récompenses."
  },
  Mail_44831_Name = {
    Text = "Réémission du dossier de tâche de la Posse V1.3.0"
  },
  Mail_44831_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_44836_Desc = {
    Text = "Cher gardien :\n        Dans la mise à jour V1.3.0, nous avons ajouté une récompense de « certificat d'agent » ×1 pour 1 victoire et 3 victoires dans les épreuves hebdomadaires de « plongée dans l'illusion ». Pour les gardiens qui ont déjà reçu ces récompenses avant la mise à jour, nous enverrons la quantité correspondante de « certificat d'agent ». Veuillez vérifier."
  },
  Mail_44836_Name = {
    Text = "Redistribution des récompenses d'essai hebdomadaires V1.3.0"
  },
  Mail_44836_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_44837_Desc = {
    Text = "L'Honorable Messager Pâle :\n\nQuelques enfants m'ont apporté des fleurs et des pâtisseries aujourd'hui, ce qui m'a rappelé qu'aujourd'hui, il y a plus d'un siècle avant l'Ère des Calendriers de Déluge, j'ai reçu la grâce du Dieu Père et suis venu dans ce monde. Que c'était il y a longtemps ! Les souvenirs de l'enfance se sont depuis longtemps estompés ; seul le parfum de l'encens de l'Église de Bendoza persiste dans mon esprit, refusant de se dissiper. Et maintenant, même si l'église existe encore, la recette de l'encens n'est plus ce qu'elle était autrefois.\n\nJe suis désolé ; la mélancolie n'est pas le but de ma lettre. J'ai préparé une pause thé avec les pâtisseries que les enfants ont apportées, espérant que vous pourriez venir la partager avec moi — non pas pour célébrer mon anniversaire, mais pour célébrer chaque jour d'existence, pour honorer la présence de la vie chaque jour.\n\nJe me demande quand est votre anniversaire ? S'il vous plaît, assurez-vous de me le dire après une tasse de thé.\n\n\n\nSalvador"
  },
  Mail_44837_Name = {
    Text = "Messager pâle..."
  },
  Mail_44837_Sender = {Text = "Salvador"},
  Mail_44843_Desc = {
    Text = "Cher Gardien,\n Dans la mise à jour V1.3.0, nous avons supprimé le privilège «Sujet principal» accordant le double d'Expérience du Gardien des Secrets dans «Plongée dans l'illusion» et «Échecs de Phase (bêta)». En guise d'excuses, nous offrirons une compensation quotidienne de 240 d'Expérience du Gardien des Secrets à ceux qui ont acheté le «Sujet principal» en cours jusqu'à la fin du Registre des sujets de ce trimestre. Veuillez vérifier vos récompenses."
  },
  Mail_44843_Name = {
    Text = "Réémission des récompenses principales pour V1.3.0"
  },
  Mail_44843_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_47305_Desc = {
    Text = "Cher Gardien:\nDans le Plongée Fantasmique d'hier, votre difficulté la plus élevée était \"{s1}\".\nDans la Traphase d'hier, vous avez gagné le titre de \"{s2}\", sans victoires dans les matchs.\nSur la base de ces résultats de défi, vous recevrez les récompenses suivantes en D-gemme. Veuillez vous souvenir de les vérifier."
  },
  Mail_47305_Name = {
    Text = ": Récompense de l'échec D-Jewel de plongée profonde"
  },
  Mail_47305_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_47306_Desc = {
    Text = "Cher gardien :\nDans la plongée fantomale d'hier, vous avez obtenu le titre « {s1} ».\nDans le traphase d'hier, vous avez obtenu le titre « {s2} », sans victoire.\nCompte tenu de ces résultats, vous recevrez les récompenses supplémentaires suivantes. Veuillez vérifier."
  },
  Mail_47306_Name = {
    Text = "Échecs de plongée profonde - Récompense supplémentaire"
  },
  Mail_47306_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_47307_Desc = {
    Text = "Cher gardien :\nDans la plongée fantomale d'hier, vous avez obtenu le titre « {s1} ».\nDans le traphase d'hier, vous avez obtenu le titre « {s2} » et remporté des matchs.\nCompte tenu de ces résultats, vous recevrez les récompenses supplémentaires suivantes. Veuillez vérifier."
  },
  Mail_47307_Name = {
    Text = "Échecs de plongée profonde - Récompense supplémentaire"
  },
  Mail_47307_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_47308_Desc = {
    Text = "Cher Gardien:\nDans le Plongée Fantasmique d'hier, votre difficulté la plus élevée était \"{s1}\".\nDans la Traphase d'hier, vous avez gagné le titre de \"{s2}\" et obtenu des victoires.\nSur la base de ces résultats de défi, vous recevrez les récompenses suivantes en D-gemme. Veuillez vous souvenir de les vérifier."
  },
  Mail_47308_Name = {
    Text = ": Récompense de l'échec D-Jewel de plongée profonde"
  },
  Mail_47308_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_48005_Desc = {
    Text = "Cher Gardien :\n\nJe m'excuse de vous déranger, et j'espère que mon écriture terrible ne ruinera pas votre bonne humeur—je ne suis vraiment pas doué pour écrire...\nJ'écris cette lettre pour vous dire que mon anniversaire semble être arrivé. J'ai préparé quelques petits biscuits pour l'occasion, et j'espère que vous les essaierez.\nPour être honnête, je ne suis pas sûr que cette date soit correcte. Depuis que j'ai été infecté par la Dissolution, les traces de mon existence s'effacent peu à peu. Mlle Poupée m'a un jour demandé ce que cela faisait de voir tout le monde m'oublier.\nC'est difficile à décrire... C'est comme se tenir dans l'obscurité totale au bord d'une rivière éclatante. De l'autre côté, les gens parlent, occupés par leurs propres affaires, passant à côté de moi alors que je ne peux que regarder, incapable de faire un bruit.\nC'est un sentiment de solitude. Heureusement, vous n'êtes pas parmi ces gens.\nAu moins, vous vous souvenez de mon histoire, n'est-ce pas ?\n\nP.S., douze petits biscuits sont joints à cette lettre.\n\nMason"
  },
  Mail_48005_Name = {
    Text = "Désolé de déranger..."
  },
  Mail_48005_Sender = {Text = "«24»"},
  Mail_48145_Desc = {
    Text = "Cher Gardien:\nL'événement \"Soins Multiples\" est terminé. Nous allons récupérer la devise événementielle restante \"Puzzle de Mémoire\" selon le taux d'échange illimité de \"Analyse de Personnalité\". Veuillez vous rappeler de vérifier vos récompenses."
  },
  Mail_48145_Name = {
    Text = "Récupération de puzzle de mémoire"
  },
  Mail_48145_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_48156_Desc = {
    Text = "Cher gardien :\nDans la plongée fantomale d'hier, vous avez obtenu le titre « {s1} ».\nDans le traphase d'hier, vous n'avez remporté aucun match.\nCompte tenu de ces résultats, vous recevrez les récompenses supplémentaires suivantes. Veuillez vérifier."
  },
  Mail_48156_Name = {
    Text = "Échecs de plongée profonde - Récompense supplémentaire"
  },
  Mail_48156_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_48157_Desc = {
    Text = "Cher Gardien:\nDans le Plongée Fantasmique d'hier, votre difficulté la plus élevée était \"{s1}\".\nDans la Traphase d'hier, vous n'avez pas eu de victoires.\nSur la base de ces résultats de défi, vous recevrez les récompenses suivantes en D-gemme. Veuillez vous souvenir de les vérifier."
  },
  Mail_48157_Name = {
    Text = ": Récompense de l'échec D-Jewel de plongée profonde"
  },
  Mail_48157_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_48914_Desc = {
    Text = "Cher Gardien :\n        Merci pour votre soutien et votre reconnaissance envers « Veille de l'oubli ». Afin d'offrir une meilleure expérience de jeu aux gardiens à l'Université de Mizag, nous vous invitons à remplir le questionnaire de recherche sur l'expérience ci-dessous. En remerciement de votre coopération, nous avons préparé « Cœur d'argent » × 200 en tant que récompense, que vous pourrez recevoir en complétant le questionnaire. La date limite pour remplir le questionnaire est le 28 octobre à 9h00, veuillez faire attention à le remplir à temps.\n        <SurveyLink:[Cliquez ici pour remplir]>\n        Nous écouterons attentivement les suggestions de chaque Gardien, vos retours contribueront sans aucun doute à améliorer l'Université de Mizag !\n        ——Que la Clé d'Argent éclaire ton chemin."
  },
  Mail_48914_Name = {
    Text = "Enquête sur l'expérience de version V1.6.3"
  },
  Mail_48914_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_48915_Desc = {
    Text = "Cher Gardien :\n        Merci pour votre soutien et votre reconnaissance envers « Veille de l'oubli ». Afin d'offrir une meilleure expérience de jeu aux gardiens à l'Université de Mizag, nous vous invitons à remplir le questionnaire d'expérience ci-dessous. Pour vous remercier de votre coopération, nous avons préparé « Cœur d'argent » × 200 comme récompense, que vous pouvez obtenir en complétant le questionnaire. La date limite pour remplir le questionnaire est le 30 septembre à 9h00, veuillez le remplir à temps.\n        <SurveyLink:[Cliquez ici pour remplir]>\n        Nous prendrons en compte les suggestions de chaque Gardien, vos retours contribueront à rendre l'Université de Mizag de plus en plus meilleure !\n        ——Que la Clé d'Argent éclaire ton chemin."
  },
  Mail_48915_Name = {
    Text = "Enquête sur l'expérience de version V1.6.1"
  },
  Mail_48915_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_49931_Desc = {
    Text = "Cher gardien du secret :\nL'événement « Vagues de Désir » est terminé. Les « Noyau de Fertilité » restants seront échangés contre « Billet Rose Dorée » × 20 pour chaque unité. Veuillez noter de les récupérer."
  },
  Mail_49931_Name = {
    Text = "La Récupération de la Graine Mère"
  },
  Mail_49931_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_50344_Desc = {
    Text = "Petite Pousse :\n\nLe vent porte ton parfum – il est plus doux que lors de notre première rencontre.\nTu as grandi dans mon amour, nourri jusqu'à maturité... comme les abeilles et le miel.\nAujourd'hui est un jour spécial. Viendras-tu me voir ?\nJ'ai attendu patiemment pendant longtemps, comme tu me l'as demandé... N'est-il pas temps pour une récompense ?\n\nThais"
  },
  Mail_50344_Name = {
    Text = "Doux comme le miel..."
  },
  Mail_50344_Sender = {Text = "Thais"},
  Mail_51376_Desc = {
    Text = "Cher Gardien :\nL'événement « Histoire magie » est terminé. Les « Inspiration errante » restantes seront converties au taux de « Billet Rose Dorée*60 » par unité. Veuillez vérifier votre inventaire."
  },
  Mail_51376_Name = {
    Text = "Récupération d'Inspiration Vagabonde"
  },
  Mail_51376_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_51777_Desc = {
    Text = "Cher gardien du secret :\nL'événement « La magie de l'histoire·clon » est terminé. Les « Inspirations errantes » restantes seront converties en « Billet Rose Dorée »× 25 pour chaque unité. Veuillez noter."
  },
  Mail_51777_Name = {
    Text = "Récupération d'Inspiration Vagabonde"
  },
  Mail_51777_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_53149_Desc = {
    Text = "\nJ'ai longtemps décidé de consacrer chaque jour de ma vie restante à celui-ci... comme une forme d'expiation pour mes actions foolish.\nLe \"jour de naissance\" de mon moi superficiel est sans conséquence, à peine digne d'être mentionné.\nAujourd'hui n'est pas différent de n'importe quel autre jour du passé ou du futur ; j'irai à la chapelle comme toujours.\nCependant, si vous souhaitez que je quitte la chapelle aujourd'hui en tant qu'invité de Mythag, je ne contredirais certainement pas la volonté du maître.\nSi vous voulez être témoin de ma prière, vous êtes toujours le bienvenu... avec tout le respect dû, vous êtes le plus le bienvenu.\n\nMiryam"
  },
  Mail_53149_Name = {
    Text = "Un Jour de Culture..."
  },
  Mail_53149_Sender = {Text = "Miryam"},
  Mail_53151_Desc = {
    Text = "Cher gardien du secret :\nL'événement « Cérémonie des Profondeurs » est terminé. Les « Larmes du Sacrificateur », « Sang du sacrificateur » et « Moelle du sacrificateur » restants seront échangés contre « Billet Rose Dorée » × 2500 pour chaque 100 unités. Veuillez vérifier."
  },
  Mail_53151_Name = {
    Text = "Récupération de la monnaie des activités du sacrifice abyssal"
  },
  Mail_53151_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_53152_Desc = {
    Text = "Cher Gardien :\nL'événement « Pasteur de l'Âme » est terminé. Les « Billets de vente au profit d'une bonne cause » restants seront convertis en « Billet Rose Dorée » × 5000 pour chaque 120 unités. Veuillez noter."
  },
  Mail_53152_Name = {
    Text = "Collecte de Voucher de Charité"
  },
  Mail_53152_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_53153_Desc = {
    Text = "Cher Gardien :\nL'événement « Fête Brûlante » est terminé. Les « Os Tibia », « Coquille à feuilles rondes » et « Spirale des Ruines » restants seront convertis en « Sceau aux mille visages » × 1 pour chaque 80 unités. Veuillez noter."
  },
  Mail_53153_Name = {
    Text = "Récupération de monnaie d'événement de banquet brûlant"
  },
  Mail_53153_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_53869_Desc = {
    Text = "Cher gardien du secret :\nL'événement « Avec le livre de la rose » est terminé. Les « Éventails de plumes d'Invocation » restants seront échangés contre « Billet Rose Dorée » × 50 par unité. Veuillez vérifier."
  },
  Mail_53869_Name = {
    Text = "Recycler l'éventail en plumes de spiritisme"
  },
  Mail_53869_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_54803_Desc = {
    Text = "Cher Gardien :\n        Dans la mise à jour V1.5.1, nous avons augmenté les récompenses de « Cœur d'argent » pour les niveaux 21 à 80 du Gardien dans « Journal de croissance », et ajouté une récompense de « Badge d'enquête » × 1000 pour l'achèvement des missions des étapes de Maîtrise de Royaume I~V. Pour les Gardiens du secret qui ont déjà récupéré ces récompenses avant la mise à jour, nous allons renvoyer les récompenses correspondantes de « Cœur d'argent » ou de « Badge d'enquête ». Veuillez vérifier."
  },
  Mail_54803_Name = {
    Text = "V1.5.1 Supplément de Récompense Manuelle"
  },
  Mail_54803_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_55168_Desc = {
    Text = "Cher gardien du secret :\nL'événement « Avant que le printemps ne fane » est terminé. Les « Poèmes joyeux », « Poèmes mélancoliques » et « Poèmes de Regret » restants seront échangés contre « Billet Rose Dorée » × 5000 pour chaque 200 unités. Veuillez vérifier."
  },
  Mail_55168_Name = {
    Text = "Recyclage de poèmes"
  },
  Mail_55168_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_56101_Desc = {
    Text = "Gardien {Male=monsieur,Female=madame} :\n\nAujourd'hui au petit matin, une rose a éclos dans le chant des oiseaux au début du printemps.\nElle aurait dû être une branche printanière en bouton, mais le jour de la Saint-Valentin, le jour de ma naissance, elle a fleuri à une saison qui ne lui appartient pas.\nJe me rappelle de la cité. Chaque année, ce jour d'anniversaire, les rues de la cité sont toujours très animées. J'entends le son des fleurs qui s'ouvrent, j'entends des mots d'amour qui font rougir. Mais cela fait longtemps que je n'ai plus eu la chance de les toucher... jusqu'à aujourd'hui.\nCroyez-vous au hasard, gardien ? Je pense que le hasard est un langage, et la rose une forme de rhétorique. Aujourd'hui, dans le jardin foisonnant de mythag, cette rose s'épanouit, ses pétales s'étalent magnifiquement, comme un poème enivrant.\nAlors, aujourd'hui, gardien... Voulez-vous venir avec moi voir l'éclosion de cette rose ?\nMoi et la fleur, attendons votre arrivée.\n\nHorla"
  },
  Mail_56101_Name = {
    Text = "Une rose fleurit au printemps..."
  },
  Mail_56101_Sender = {Text = "Horla"},
  Mail_57328_Desc = {
    Text = "Cher gardien du secret :\nL'événement « Les étoiles sont en position positive » est terminé. Les « Embryons ignorants », « Embryons sans désir » et « Graine insatiable » restants seront échangés contre « Billet Rose Dorée » × 40 pour chaque unité. Veuillez vérifier."
  },
  Mail_57328_Name = {
    Text = "Récupération d'embryo"
  },
  Mail_57328_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_57414_Desc = {
    Text = "Cher gardien du secret :\nL'événement « Manuel du Détective » est terminé. Nous allons convertir les « jetons décisifs » restants du gardien selon un taux de « Billet Rose Dorée » × 40 par unité. Veuillez vérifier."
  },
  Mail_57414_Name = {
    Text = "Récupération de Chip"
  },
  Mail_57414_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_58253_Desc = {
    Text = "Cher Gardien :\nL'événement « Pasteur de l'Âme·clon » est terminé. Les « Billet de vente au profit d'une bonne cause » restants seront convertis en « Billet Rose Dorée » × 5000 pour chaque 200 unités. Veuillez noter."
  },
  Mail_58253_Name = {
    Text = "Collecte de Voucher de Charité"
  },
  Mail_58253_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_58690_Desc = {
    Text = "Cher gardien du secret :\nL'événement « Symphonie invisible » est terminé. Les « Chant héroïque » restants seront échangés contre « Billet Rose Dorée » × 40 par unité. Veuillez vérifier."
  },
  Mail_58690_Name = {
    Text = "Mélodie aigüe récupérée"
  },
  Mail_58690_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_61154_Desc = {
    Text = "Cher Gardien :\nL'événement « Fête Brûlante·clon » est terminé. Les « Os Tibia », « Coquille à feuilles rondes » et « Spirale des Ruines » restants seront échangés contre « Billet Rose Dorée » × 40 pour chaque unité. Veuillez noter."
  },
  Mail_61154_Name = {
    Text = "Recyclage de la monnaie du festin brûlant"
  },
  Mail_61154_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_61155_Desc = {
    Text = "Cher gardien du secret :\nL'événement de réédition « Guérison multiple·clon » est terminé. Les devises restantes « Mémoires en puzzle » seront récupérées au taux de « Billet Rose Dorée » × 40 pour chaque unité. Veuillez vérifier."
  },
  Mail_61155_Name = {
    Text = "Récupération de puzzle de mémoire"
  },
  Mail_61155_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_62392_Desc = {
    Text = "Keeper:\n\nMa musique a autrefois servi devant des empereurs et a été admirée par d'innombrables personnes. Cependant, ces éloges n'ont aucune valeur pour moi ; ce que je poursuis est l'essence ultime de la musique.\nComparé à une performance dans des lieux grands et luxueux, jouer seul dans une forêt tranquille me procure plus de paix.\nJe n'ai jamais voulu que quelqu'un écoute mes sessions de pratique ; elles n'étaient que des brouillons, des fragments sans signification.\nMais depuis que je t'ai connu et que je t'ai trouvé, toute ma musique a pris un sens.\nTu m'as donné la musique la plus magnifique et la plus noble, me sauvant de ma confusion, même si tu n'en étais pas conscient...\nAujourd'hui, c'est mon anniversaire, que j'avais longtemps oublié. Mais maintenant, je souhaite commémorer ma renaissance et celle qui l'a accordée.\nPar coïncidence, j'ai récemment composé un nouveau morceau et j'aimerais t'inviter à l'écouter. Je te prie de pardonner mon retard ; ma situation actuelle ne me permet pas de me montrer devant mes collègues Mythag, donc je ne peux envoyer cette invitation qu'après le coucher du soleil.\nCe soir, dans la forêt derrière l'école, je tiendrai un concert spécial avec un seul membre du public.\nJ'attends avec impatience ta présence.\n\nHameln"
  },
  Mail_62392_Name = {
    Text = "Concert Secret..."
  },
  Mail_62392_Sender = {Text = "Hamelin"},
  Mail_65350_Desc = {
    Text = "Cher gardien du secret :\nL'événement « Lorsque la montagne neigeuse fond » est terminé. Nous allons récupérer les devises restantes du gardien « Bouton de fleur gelé », « Bouton de fleur d'argent givré » et « Bouton de soleil » selon un taux de « Billet Rose Dorée » × 40 par unité. Veuillez vérifier."
  },
  Mail_65350_Name = {
    Text = "Récupération de bourgeons"
  },
  Mail_65350_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_65441_Desc = {
    Text = "Cher gardien du secret :\nL'événement « Cérémonie des Profondeurs·clon » est terminé. Les « Larmes du Sacrificateur », « Sang du sacrificateur » et « Moelle du sacrificateur » restants seront échangés au taux de « Billet Rose Dorée » × 40 par unité. Veuillez vérifier."
  },
  Mail_65441_Name = {
    Text = "Récupération de la monnaie des activités du sacrifice abyssal"
  },
  Mail_65441_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_65442_Desc = {
    Text = "Cher gardien du secret :\nL'événement « Porte des Mille Phénomènes » est terminé, nous allons récupérer les « Pointeur final » restants du gardien selon un taux de « Billet Rose Dorée » × 40 par unité, veuillez vérifier."
  },
  Mail_65442_Name = {
    Text = "Recyclage de l'Indicateur de Fi"
  },
  Mail_65442_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_67147_Desc = {
    Text = "Keeper: \n\n Les dimensions de l'univers ne me sont pas singulières ; les Portes de l'Oubli permettent un aperçu de mondes innombrables et d'existences infinies. Cela transcende toutes les merveilles et la logique mathématique, rendant impossible de déterminer la date de la \"Naissance\". \n Considérons donc notre première rencontre comme ce moment. À l'échelle du continuum temporel que vous habitez, une cérémonie qui m'est exclusive devrait avoir lieu aujourd'hui, accomplissant le souhait que j'ai formulé. \n Ensuite, franchissons le seuil de la Clé Argentée et rejoignons mon côté. Je vais vous impartir... des connaissances sur la Genèse ultime appartenant à l'univers. Ce soir, d'innombrables corps célestes brilleront pour vous et moi. \n Je vous attends aux Portes de l'Oubli. \n\nTawil"
  },
  Mail_67147_Name = {
    Text = "Traversez la Porte Argentée..."
  },
  Mail_67147_Sender = {Text = "Tawil"},
  Mail_67933_Desc = {
    Text = "J'ai ressenti ta brève confusion—comment pourrait-on espérer nuire à la suprême Relique par un simple regard ? Mais tu l'as fait.\nUn autre regard s'effondre, l'armure montre des rayures et des brèches sous les Fragments incessants.\n%player%, seule ta volonté inflexible est vraiment indestructible."
  },
  Mail_67933_Name = {
    Text = "Trouvez un moyen de sortir de l'embarras"
  },
  Mail_67933_Sender = {Text = "Alistair"},
  Mail_67934_Desc = {
    Text = "Vos membres tremblent, %player%. Vous pouvez à peine tenir debout. La peur vous serre, laissant votre esprit vide et rendant impossible le contrôle de votre respiration... mais vous levez toujours la clé en argent devant vous.\nParmi toutes les vertus humaines, le courage est le plus noble. Face aux désastres et aux bêtes, nous avons jadis levé des marteaux et des lances. Maintenant, face aux dieux, vous faites de même.\nLa civilisation humaine a été bâtie sur le courage et y perdurera."
  },
  Mail_67934_Name = {
    Text = "L'hymne du courage résonne au milieu des tremblements"
  },
  Mail_67934_Sender = {Text = "Alistair"},
  Mail_67935_Desc = {
    Text = "Nous avons jadis parlé de ce monde ; tu as dit que tu ne l'aimais pas. Il est plein d'intérêts, de conspirations, de tromperies et de massacres. Même sans Dissolution ou Dieux, il est déjà battu et sur le point de s'effondrer. Après s'être réveillé d'Akut, dans ta Mémoire fugace, tu as été témoin de désordres et d'horreurs bien pires que la Dissolution.\nPourtant, lorsque le Créateur a brandi sa lame, tu te tenais toujours devant ce monde pour le protéger. L'anéantissement était la volonté des Dieux, mais tu l'as défié.\nJe comprends, %player%. Aucun Gardien ne déteste ce monde, ni n'en aime vraiment un. Car au milieu de la saleté, nous avons aperçu des lueurs qui brillent comme de l'Argent.\nLe devoir d'un Gardien est de protéger éternellement ces faibles lueurs."
  },
  Mail_67935_Name = {
    Text = "L'esprit humain endure pour toujours."
  },
  Mail_67935_Sender = {Text = "Alistair"},
  Mail_67936_Desc = {
    Text = "La première fois voyant Dissolution, la première fois confrontant sa vérité, la première fois percevant la voix de Dieu... Tout au long de ma longue vie, j'ai enduré d'innombrables moments de désespoir, ne sachant pas quoi faire ni le sens de tout l'effort et le sacrifice—pourtant, aucun ne se compare à ce que vous affrontez maintenant.\nC'est l'humanité : face au désespoir, nous nous élevons à nouveau et avançons.\nLa fin du chemin peut être un Abysse, mais il y aura toujours ceux qui souhaitent le voir."
  },
  Mail_67936_Name = {
    Text = "Le désespoir, puis la renaissance"
  },
  Mail_67936_Sender = {Text = "Alistair"},
  Mail_67937_Desc = {
    Text = "La barrière dimensionnelle est ouverte, et je peux enfin te recontacter.\nComparé à ce que tu as vu, la vision dans cette dimension est exceptionnellement faible, peut-être parce que tu n'es pas ici. Après avoir sacrifié presque tout, j'ai traité avec It pour toi.\nJe ne peux pas imaginer à quoi tu fais face. Mais peu importe ce qu'il en est, avec la volonté d'anéantir, je me battrais à tes côtés. C'est le vœu de chaque Mythag.\nJe suis heureux de me tenir à tes côtés à nouveau.\nQue la Clé d'Argent guide le chemin."
  },
  Mail_67937_Name = {
    Text = "Combattre côte à côte, encore une fois"
  },
  Mail_67937_Sender = {
    Text = "Expéditeur inconnu"
  },
  Mail_67938_Desc = {
    Text = "Folie, un terme léger et même agréable.\nUn univers chaotique a donné naissance à une civilisation chaotique. Le chaos est la vérité de ce monde. Embrasser le chaos et apprécier la folie est une chose facile. En revanche, rester lucide et résister est si difficile. Vous sacrifierez toute joie et toute vie, juste pour poursuivre une réponse insaisissable.\nPourtant, vous choisissez toujours de rester éveillé, %player%. Car nous ne sommes pas nés pour être des esclaves.\nVous Lui avez montré, %player%—Sa relique, Son fragment, n'ont jamais voulu être des esclaves aveuglement fous. Vous Lui résistez, surmontant Son regard encore et encore, choisissant de protéger ce monde imparfait et troublé.\nDans ce choix, vous avez atteint une liberté éternelle."
  },
  Mail_67938_Name = {
    Text = "Vous ne consentiriez jamais à être un esclave aveuglément insensé."
  },
  Mail_67938_Sender = {Text = "Alistair"},
  Mail_67939_Desc = {
    Text = "J'ai ressenti un regard s'effondrer. J'ai ressenti votre douleur atroce.\nC'est la responsabilité gravée sur le titre de Gardien. Le chemin que vous avez choisi est des milliers de fois plus difficile que le mien. Tout le monde n'a pas le courage d'affronter le suprême Dieu ; votre bravoure me touche profondément et m'emplit d'admiration.\nJe ne peux pas imaginer la douleur que le pouvoir du Créateur vous infligera. Ce que je perçois n'est qu'une petite fraction de votre souffrance. Je suis une personne inutile piégée dans le Black Pool, %player%. Je ne peux plus me joindre à vous dans votre lutte contre le Créateur ; je peux seulement rester connecté à vous à travers mes sens. Ce sera ma mission finale et la plus importante dans ma vie.\nDans ce voyage solitaire, que vous le voyiez ou non, Mythag sera toujours à vos côtés."
  },
  Mail_67939_Name = {
    Text = "Le chagrin ne te brisera pas."
  },
  Mail_67939_Sender = {Text = "Alistair"},
  Mail_67940_Desc = {
    Text = "J'ai entendu les murmures de la Suprême Volonté—la grande civilisation, la joie et la tristesse humaine, les innombrables personnes qui t'entourent et te quittent ; rien de tout cela n'a jamais véritablement existé.\nDans les innombrables jours et nuits au Bassin Noir, cette vision me remplissait d'angoisse. Les arbres prennent racine dans le sol, puis poussent vers le haut pour saluer le soleil—la mémoire est notre sol, le fondement à partir duquel nous grandissons, tenons et finissons par retourner. Je crains de perdre ce sol, dérivant dans l'illusion, sans origine ni fin.\nMerci, %player%. Je crois avoir été témoin d'un grand duel. C'est un combat entre l'homme et le dieu, un combat de protection contre destruction.\nC'est un combat de souvenir contre oubli.\nTu l'as fait, %player%. Tu as accompli ce que personne n'osait imaginer. Tu as puisé une puissance inégalée dans la mémoire et combattu pour sa préservation.\nDans ce sol ancien, tu as trouvé ton soleil."
  },
  Mail_67940_Name = {
    Text = "Combattre pour se souvenir"
  },
  Mail_67940_Sender = {Text = "Alistair"},
  Mail_68825_Desc = {
    Text = "Cher Gardien :\nL'événement « Royaume · Retour » est terminé. Les devises d'événement « Pensées fatiguées », « Tristesse mélancolique » et « Pensées joyeuses » restantes seront converties en « Billet Rose Dorée*40 » au taux de 1:1. Veuillez vérifier votre inventaire."
  },
  Mail_68825_Name = {
    Text = "Récupération de la monnaie de la renaissance du roi divin"
  },
  Mail_68825_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_68826_Desc = {
    Text = "Cher gardien du secret,\nL'événement « Vagues de Désir·clon » est terminé. Les « Noyau de Fertilité » restants seront échangés contre « Billet Rose Dorée*40 » pour chaque unité. Veuillez vérifier."
  },
  Mail_68826_Name = {
    Text = "La Récupération de la Graine Mère"
  },
  Mail_68826_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_68898_Desc = {
    Text = "Très très très cher maître :  \n\nEn tant que servante polyvalente, Karen peut se souvenir de nombreuses dates importantes pour les adultes, allant des dîners de gala, anniversaires, journées commémoratives, jusqu'au jour où l'on a acheté un animal de compagnie, sans jamais faire la moindre erreur. Mais pour Karen elle-même, il n'y a qu'une seule journée spéciale à célébrer : aujourd'hui.  \nIl y a très très longtemps, lorsque Karen était encore une servante au palais royal, j'ai voulu demander pour la première fois au cuisinier un morceau du gâteau que les nobles n'avaient pas fini, pour en faire mon gâteau d'anniversaire, mais il m'a violemment réprimandée. Le cuisinier m'a jeté le gâteau à la figure. À ce moment-là, je me suis dit : « Ah, voilà donc à quel point les gâteaux sont délicieux ! Je dois absolument trouver un maître qui soit très gentil avec moi, et qui me permette de manger du gâteau chaque année pour mon anniversaire. »  \nAujourd'hui, j'ai la chance d'avoir madame Sorrel, si élégante et si noble, ainsi que vous, mon maître extrêmement bienveillant. Mon souhait d'autrefois s'est déjà réalisé ! Mais les gens deviennent toujours plus gourmands... Ah non, disons plutôt qu'ils progressent. Aujourd'hui, mon vœu est de pouvoir rester aux côtés de mon maître chaque année pour mon anniversaire, et si en plus il y avait chaque année un cadeau brillant et étincelant, ce serait encore mieux !  \nAprès avoir entendu tout cela, vous allez certainement me le préparer, n'est-ce pas ? Hein ? Hein ?  \n\nVotre servante humble et dévouée  \nKaren"
  },
  Mail_68898_Name = {
    Text = "Chaque année, c'est toujours la même chose..."
  },
  Mail_68898_Sender = {Text = "Karen"},
  Mail_68899_Desc = {
    Text = "Jeune arbre : \n\nVoir ton développement constant me rend de plus en plus certaine que choisir de t'aider fut la meilleure décision que j'aie jamais prise. \nJe ressens la joie de la récolte, toutes les preuves d'affection et de confiance que je t'ai données m'ont rapporté un bonheur doux, c'est toi qui m'as offert l'espoir et l'avenir. \nAujourd'hui, je peux abandonner mon obsession de la reproduction et me consacrer pleinement au fruit de l'amour, au-delà de toute progéniture. \nCe monde n'a plus besoin d'une Reine Arlan, mais peut-être qu'il peut accueillir le vœu d'anniversaire d'une femme ordinaire qui souhaite simplement être accompagnée par son bien-aimé. \nComme un couple ordinaire, faire les courses ensemble, cuisiner ensemble de délicieux plats, ou même découvrir beaucoup d'autres choses que je n'ai encore jamais expérimentées... Mon cher, pourrais-tu me guider et passer avec moi un anniversaire chaleureux et paisible ?\n\nThaïs"
  },
  Mail_68899_Name = {
    Text = "Vie ordinaire…"
  },
  Mail_68899_Sender = {Text = "Thais"},
  Mail_68900_Desc = {
    Text = "Gardien : \n\nLe maître Casiah est le plus grand et le plus remarquable artiste du monde, capable d'imiter parfaitement n'importe quelle expression, mais les émotions humaines restent un mystère absolu, impossible à comprendre vraiment.\nJ'ai posé la question à des tas de personnes, mais personne n'a pu m'expliquer clairement le fonctionnement des émotions, jusqu'à ce que je demande à la poupée, qui m'a dit qu'il existait une discipline appelée psychologie, capable d'expliquer toutes les émotions théoriquement, même sans les ressentir soi-même.\nC'est vraiment, vraiment passionnant ! Est-ce que le mystère qui hantait Casiah depuis si longtemps va enfin être résolu ?\nAu fait, je suis venue te dire que je vais assister à ton cours de psychologie cette semaine, Casiah a décidé de devenir ta camarade de bureau, alors tu devras bien me rattraper pour les cours que j'ai manqués, camarade de bureau ~\nAh oui, à propos, aujourd'hui c'est mon anniversaire, donc je devrais être heureuse, et toi aussi, n'est-ce pas ?\nSi c'est une très bonne nouvelle, alors faisons une grosse pagaille à l'école, je vais transformer le campus en un endroit aussi magnifique qu'un rêve !\n\nCasiah"
  },
  Mail_68900_Name = {
    Text = "<Yellow:psychologie>…"
  },
  Mail_68900_Sender = {Text = "Casiah"},
  Mail_68901_Desc = {
    Text = "Messager pâle respectable : \n\n Merci pour ton aide et ton attention tout au long de cette année. Ton cœur chaleureux envers les autres est aussi noble que ce que le dieu père nous a enseigné. Même si nos occasions de nous fréquenter ne sont pas nombreuses, chaque fois que je te rencontre, j'ai l'impression de retrouver un vieil ami de longue date, ce qui me remplit de bonheur comme une douce brise printanière. \n Bien que cette journée d'anniversaire ne soit pas particulière, elle peut néanmoins être une bonne raison pour que des amis se retrouvent, ce qui suscite chez moi une agréable attente. À part toi, je ne peux imaginer personne d'autre qui serait plus approprié pour passer cette journée ensemble. \n Si tu es intéressé, j'aimerais t'inviter à découvrir une nouvelle passion que j'ai récemment développée : la pêche. Bien sûr, pas dans le but de cuisiner ou de manger les poissons, mais simplement pour profiter du processus calme d'attendre patiemment que le destin nous offre un cadeau merveilleux. J'aimerais partager avec toi cette sensation paisible, en allant dans la nature, tranquillement assis au bord d'un lac. \n Un vieil ami, deux cannes à pêche, ce sera certainement une journée merveilleuse. \n\n Salvador"
  },
  Mail_68901_Name = {
    Text = "Nouvelle passion pour la pêche..."
  },
  Mail_68901_Sender = {Text = "Salvador"},
  Mail_68902_Desc = {
    Text = "Maître : \n\nPour mon anniversaire cette année, Eagle et Jenkin m'ont offert un carillon en verre qui ressemble beaucoup à Aurita.\nJe l'ai accroché à la fenêtre de ma chambre, et quand le vent souffle, il émet un joli son qui me rappelle le temps où ma mère me tenait dans ses bras près de la fenêtre en me racontant des histoires.\nNe t'inquiète pas, maître, même si je pense chaque jour à ma mère, avec vous et tout le monde à mes côtés, Lily ne se sentira pas seule.\nMaintenant, Lily a appris à lire des histoires toute seule, et chaque soir, la lumière orange entre dans la pièce, illumine le carillon et projette sur le livre des ondulations qui dansent, réchauffant toute la chambre.\nLily adore rester rêveuse à ce moment, regardant les nuages au coucher du soleil et le carillon, ressentant une beauté merveilleuse.\nSi le maître a du temps aujourd'hui, venez essayer de rêvasser avec Lily.\n\nLily"
  },
  Mail_68902_Name = {
    Text = "Carillon en verre..."
  },
  Mail_68902_Sender = {Text = "Lily"},
  Mail_68903_Desc = {
    Text = "Petit : \n\nMême si cette journée spéciale a été instaurée en l'honneur d'un humain, je dois reconnaître qu'une journée de soldes constitue une offre commerciale extrêmement attrayante autant pour les clients que pour les commerçants. Lors de mon précédent anniversaire, le nombre de commandes passées à la boutique de soulagement a quasiment égalé les ventes habituelles de six mois, en particulier ces articles spéciaux que j'avais mis en vente comme cadeaux de célébration, tous vendus sans exception. Devrais-je dire que les clients de Mythag sont trop bienveillants envers mon commerce, ou que même les enquêteurs les plus prudents ne peuvent résister à la tentation des soldes ? \nEn tout cas, pour poursuivre cette joie mutuelle, la boutique continuera à proposer des réductions exceptionnelles pour mon anniversaire cette année. Une seule fois par an, des remises très importantes, faites vite si vous voulez acheter ! N'oubliez de bien faire la promotion de cette journée à Mythag. Pour la rendre plus facile à retenir, appelons-la simplement la Journée du Double Dix.\nEn outre, j'ai mis de côté quelques petites choses intéressantes rien que pour toi, viens me voir dès que tu peux.\nDafdael"
  },
  Mail_68903_Name = {
    Text = "Jour des soldes…"
  },
  Mail_68903_Sender = {Text = "Daffodil"},
  Mail_68904_Desc = {
    Text = "Bénéficiant de la grâce du destin, Gardien des Secrets de l'université de Mythag, noble et bienveillant Seigneur :\nMille salutations ! \nSi le vœu le plus cher de chaque chevalier est de suivre un grand Seigneur, alors ma carrière de chevalier est déjà comblée. \nMa vie fut marquée non seulement par la chance, mais aussi par trop de tragédies malheureuses et de sang héroïque. Je sais que beaucoup à Mythag ont eu pitié de moi à cause de cela. \nSans même parler de comparer nos souffrances, il y a déjà bien trop de personnes malheureuses à Mythag. Dans un monde si éprouvé par les souffrances, verser son sang pour protéger n'a rien de triste. Bien au contraire, qu'autrefois ou aujourd'hui, j'en ressens de la fierté et suis toujours prêt à sacrifier ce corps. \nCependant, Lady Lothan a dit que j'avais l'air trop fatigué ces derniers temps à force de m'inquiéter, et m'a ordonné de profiter pleinement de cette journée d'anniversaire. Elle a fait venir Jenkin pour m'apprendre à jouer à des jeux, disant qu'elle souhaitait que je retrouve mon enfance. \nJe dois avouer que j'étais si occupé à m'entraîner durant mon enfance que je n'ai guère eu d'expériences ludiques. Je ne m'attendais pas à ce que ce jeu, qu'on dit maîtrisable par des enfants de cinq ans, soit si difficile. Il semble que j'aie encore beaucoup à apprendre en dehors de la voie chevaleresque. \nSi le Seigneur a un moment de libre aujourd'hui, accepteriez-vous de venir jouer avec nous ? J'ai vu Jenkin commencer à s'ennuyer après avoir remporté dix parties d'affilée, et avec votre présence, une confrontation passionnante serait assurée. \n\nOgier"
  },
  Mail_68904_Name = {
    Text = "Jeu difficile…"
  },
  Mail_68904_Sender = {Text = "Ogier"},
  Mail_68905_Desc = {
    Text = "Hé :\n\nAvec ce calendrier, tu n'as certainement pas oublié l'anniversaire du prestigieux maître du labyrinthe cette année.\nJe t'autorise à venir dans ma chambre m'offrir un cadeau, et à me servir dévouément cette journée.\nDes choses comme me brosser les dents, me laver le visage, m'aider à m'habiller, à prendre mes repas, et aussi nettoyer la chambre, changer les draps, comment appelez-vous cela déjà ? Un grand nettoyage !\nOui, tout ce travail de grand nettoyage te revient, j'en ai assez de ces corvées domestiques. Aujourd'hui, coûte que coûte, je veux revivre comme j'étais à Rome, profiter à nouveau d'une vie où tout m'est servi sur un plateau.\nPersonne ne réussira à me faire faire la moindre tâche aujourd'hui, personne !\n\nAgrippa"
  },
  Mail_68905_Name = {
    Text = "<Yellow:Retour dans le passé...>"
  },
  Mail_68905_Sender = {Text = "Agrippa"},
  Mail_68906_Desc = {
    Text = "Gardien : \n\nLe temps passe vraiment vite, je n'aurais jamais pensé que ce genre de vie, que je croyais durer jusqu'à ma mort, je ne m'en souviendrais presque plus aujourd'hui.\nDésormais, Mademoiselle connaît parfaitement tous les petits gâteaux de la cantine, et même en encourageant encore et encore ces cuisiniers incompétents, ils ne réussiront plus à en faire de nouveaux.\nAinsi, pour la nouvelle année, ma carte gastronomique devra être plus vaste et plus lointaine : fixons d'abord un petit objectif, manger dans toutes les pâtisseries de Londinium.\nQuant à la noble tâche de faire la queue en courant pour les récupérer, je te la confie encore une fois ! Inutile d'être trop content de recevoir la confiance de Mademoiselle, contente-toi d'exprimer ta gratitude en récitant le nom de cette charmante demoiselle.\nCela dit, ces idiots de cuisiniers ont tout de même un peu de bon vouloir, j'ai déjà entendu, à travers leurs murmures discrets et mal dissimulés, qu'ils préparaient apparemment un énorme gâteau de dix étages — Ha, ils sont toujours aussi mauvais pour cacher les surprises.\nMême si l'idée est un peu clichée, peut-être que cette fois-ci, pour mon anniversaire, j'inviterai davantage de personnes, comme les nouveaux amis que j'ai rencontrés cette année.\nEn tant que premier ami de Mademoiselle à Mésage, je t'autorise à être celui qui coupera la première part du gâteau.\n\nMurphy"
  },
  Mail_68906_Name = {
    Text = "Gâteau à dix étages..."
  },
  Mail_68906_Sender = {Text = "Murphy"},
  Mail_68907_Desc = {
    Text = "Cher Gardien du Secret : \n\n Tu es suffisamment intelligent pour avoir déjà appris cette information depuis les archives magiques de Missag – aujourd'hui est un jour mémorable dans la vie du « détective chanceux ». \nNaissance, première victoire au blackjack, centième course de chevaux remportée, premier meurtre en chambre close résolu, échec fatal qui apporte la mort – tout cela est arrivé un 6 juin aussi magique que celui-ci. \nAlors, que dirais-tu de jouer au bridge à deux aujourd'hui, pour rendre cette journée encore plus mémorable ? \n\n Lake"
  },
  Mail_68907_Name = {
    Text = "Une partie ?"
  },
  Mail_68907_Sender = {Text = "Ryker"},
  Mail_68908_Desc = {
    Text = "Cette lettre n'est pas un salut, c'est un avertissement — ne tente pas de me contrôler, ne tente pas de m'enchaîner. \nJ'appartiens uniquement à moi-même. \nContrairement à celui qui me ressemble, je ne garde pas d'attente enfantine envers les gens, envers le monde. \n\nJe tuerai quiconque osera devenir mon « maître », je le pense vraiment. \n\nH"
  },
  Mail_68908_Name = {
    Text = "J'appartiens à…"
  },
  Mail_68908_Sender = {
    Text = "Helot : Enchaînée"
  },
  Mail_68909_Desc = {
    Text = "Gardien : \n\nPeut-être vous ai-je déjà raconté mon amour pour l'eau. Comparé au monde bruyant des humains, l'univers sous-marin est si calme et serein.\nAutrefois, je dérivais entre les plantes aquatiques et les coraux, et conversais avec les bancs de poissons. Plus j'étais éloigné de la surface, plus les couleurs de l'eau devenaient sombres. En regardant vers le ciel depuis le fond de l'eau, poussé doucement par les vagues, les lumières dansaient avec des reflets hypnotiques, formant le plus magnifique paysage de mon cœur.\nLe saviez-vous ? Certains êtres marins sont capables de reconnaître les visages humains. Lorsque vous revenez les voir, ces « amis » s'approchent chaleureusement pour vous accueillir. Par exemple, je connais une petite pieuvre intelligente et un poisson jaune tendre.\nAujourd'hui, jour de mon anniversaire, je repense avec nostalgie à ce monde sous l'eau. Je me demande si vous accepteriez de plonger avec moi. De tout mon cœur, j'aimerais partager avec vous cet univers paisible ainsi que mes extraordinaires compagnons marins.\n\nNiphia"
  },
  Mail_68909_Name = {
    Text = "Monde sous-marin..."
  },
  Mail_68909_Sender = {Text = "Nymphaea"},
  Mail_68910_Desc = {
    Text = "Gardien du Secret :\n\nDepuis que tu es arrivé à Mythag, j'ai pris l'habitude de gérer les affaires te concernant comme si j'élevais un nourrisson. Et à en juger par tes réactions habituelles, ta faiblesse dépasse même mes attentes.\nCependant, en tant que ton enseignant et premier tuteur, je suis content de constater qu'au cours de cette année, les ennuis et les situations à réparer après coup liés à ta personne sont de plus en plus rares. Bien que ton air complètement vide au début de l'année ait été profondément décourageant, ton rythme de progression est effectivement digne d'un talent combiné à un travail acharné.\nFélicitations, tu es désormais un gardien du secret compétent, qui n'a pas déçu mes attentes.\nUn jour comme aujourd'hui, mon anniversaire, qui n'a rien de particulier, j'ai déjà préparé pour toi un cadeau réservé aux gardiens du secret accomplis : le programme d'entraînement spécial qu'Alistair a utilisé autrefois. Qu'en penses-tu ? N'es-tu pas excité à cette idée ?\nNe me demande pas pourquoi c'est moi qui t'offre un cadeau. Il faut bien s'occuper quand on ne peut pas entrer dans le laboratoire, n'est-ce pas ?\nQuand tu seras prêt, viens me retrouver dans la salle d'entraînement.\n\nDoll"
  },
  Mail_68910_Name = {Text = "Cadeau..."},
  Mail_68910_Sender = {Text = "Doll"},
  Mail_68911_Desc = {
    Text = "Gardien du Secret : \n\nUn an pour une danseuse, ce n'est que quelques dizaines de milliers de tours, quelques dizaines de milliers de sauts ; à part la paire de chaussures que j'ai portée pendant longtemps et qui a été remplacée, tout semble identique, et en même temps tout semble différent. \nComparé au passé où j'étais habituée à la solitude, cette année j'ai toujours eu un spectateur fidèle, un partenaire de danse un peu maladroit. \nChaque fois que tu es assis dans la salle de danse, je sens mon corps devenir plus léger, comme lorsque j'apprenais à danser étant enfant, remplie d'une passion et d'une motivation inexplicables. \nPeut-être ne suis-je pas aussi pure et noble que je le crois ; alors que je consacre toute ma vie à la danse, j'aimerais aussi recevoir ton regard et entendre tes applaudissements. \nLe temps est très beau aujourd'hui, je pressens que le ciel sera très clair cette nuit. Mon spectateur le plus passionné, mon partenaire de danse exclusif, veux-tu m'accompagner jusqu'à cette forêt magnifique où se trouve un lac splendide, pour danser ensemble une danse dédiée à la lune et aux étoiles ? \n\nLiz"
  },
  Mail_68911_Name = {
    Text = "Partenaire de danse exclusif..."
  },
  Mail_68911_Sender = {Text = "Liz"},
  Mail_68912_Desc = {
    Text = "Gardien :\n\nDepuis le jour de ma renaissance, les gens de Mizag m'ont beaucoup aidé. Peut-être que je ne peux toujours pas m'habituer à ce sentiment de coopération, mais au moins, lorsque je marche avec vous, je peux déjà confier mon dos en toute confiance. Ce sentiment... n'est pas mal.\nLa plupart du temps de ma vie a été remplie de dommages et de trahisons. J'ai toujours considéré la lutte contre cela comme le sens de mon combat, jusqu'à ce que ma vie ne contienne plus rien d'autre, et mon regard ne pouvait plus se détourner de la vengeance.\nMaintenant, en suivant vos pas, je découvre que le combat peut avoir beaucoup de significations en plus des dommages et de la vengeance. Même, comme le dit Lotan, le combat peut simplement être un combat.\nJ'ai appris à apprécier le plaisir du combat, à savourer cette sensation exaltante, à profiter d'être simplement un guerrier vaillant.\nSi mon combat peut apporter plus, alors je savourerai cette gloire.\nEt toi, que ce soit maintenant ou dans le futur, je promets que ma lame ne se dirigera jamais vers toi.\n\nHelot"
  },
  Mail_68912_Name = {
    Text = "La signification de la bataille…"
  },
  Mail_68912_Sender = {Text = "Helot"},
  Mail_68913_Desc = {
    Text = "Cher Gardien du Secret :  \n\nÀ dire vrai, je n'ai pas beaucoup d'idées concernant les vœux d'anniversaire. Avant, quand j'étais encore « normale », mon plus grand souhait chaque jour était de manger à ma faim, de payer mon loyer à temps et de bien m'occuper de Jenkin. Aujourd'hui, pouvoir passer une année tranquillement et voir Jenkin faire des bêtises pendant un an de plus me satisfait déjà pleinement.  \nJe dois l'avouer avec honte, devant Jenkin, je prends toujours un air de grande sœur pour la réprimander, mais envers vous, je vous cause souvent bien des ennuis, et même, je ne me souviens plus très bien laquelle de mes personnalités a causé quel problème.  \nVotre gentillesse et votre patience inébranlables me réchauffent le cœur tout en me mettant un peu mal à l'aise. Peut-être est-ce la première fois de ma vie que quelqu'un me traite avec une telle indulgence. Je me sens sincèrement honorée et reconnaissante.  \nCette année, j'ai préparé un grand gâteau pour tout le monde, selon une recette apprise d'une ouvrière d'une ancienne usine textile. Bien que je ne puisse pas rivaliser avec les chefs professionnels, cette saveur particulière plaît beaucoup à Jenkin et à moi. Cette fois-ci, il n'y a pas de problème de fourniture, donc chacun pourra en manger à sa faim. Veuillez absolument venir le goûter.  \nJ'ai déjà convaincu toutes mes autres personnalités de se tenir tranquilles pour célébrer un anniversaire sagement, elles ne vous causeront certainement plus d'ennuis aujourd'hui, c'est promis !  \nSi possible, n'hésitez surtout pas à me faire appel quand vous en avez besoin, que ce soit pour laver le linge, nettoyer ou ranger, je suis très douée. J'aimerais aussi avoir l'opportunité de vous rendre un peu de cette douceur que vous m'avez offerte.  \n\nMason"
  },
  Mail_68913_Name = {
    Text = "Rendre la pareille…"
  },
  Mail_68913_Sender = {Text = "«24»"},
  Mail_68914_Desc = {
    Text = "Gardien :  \n\nEn tant que personne responsable de recevoir les souhaits de tout le monde, il semble que peu importe mes efforts, je ne peux pas m'habituer à l'idée de faire un vœu pour moi-même le jour de mon anniversaire. Pour moi, il semble que je n'ai rien de particulier que je désire. \nDoll m'a dit que je devais trouver ce que je désire vraiment au fond de moi, et me demander pourquoi je fais tout cela. \nJ'ai réfléchi longtemps, en réalité, j'espère que tous ceux qui viennent me faire des vœux voient leurs souhaits se réaliser. En continuant à réfléchir, je pense que j'aime les sourires des gens quand leurs vœux se réalisent, et la façon dont ils m'entourent sincèrement, me remerciant et me louant d'avoir accompli le devoir de la déesse. \nDoll a dit que c'était mon souhait d'être reconnu dans ma valeur et de devenir une personne utile, je pense qu'elle a raison. \nMais elle a aussi dit que la valeur d'une personne ne doit pas être déterminée par les autres, qu'il n'y a rien de véritablement utile, et que l'important est de suivre son propre cœur, même si cela signifie devenir quelqu'un de soi-disant inutile. \nC'est vraiment Doll, toujours capable de dire des choses si profondes, mais au fond, dois-je devenir une personne utile ou inutile ? Je commence à être confus à nouveau... \nCependant, si je dois suivre mon cœur, peut-être que je souhaite encore être une personne utile. Si je peux voir les sourires de tout le monde ce jour-là, ce serait le cadeau que je désire le plus. \n\nCeleste"
  },
  Mail_68914_Name = {
    Text = "<Yellow:utile><Del:«utile»>"
  },
  Mail_68914_Sender = {Text = "Celeste"},
  Mail_68915_Desc = {
    Text = "Cher Gardien du Secret,  \n\nJe me suis depuis longtemps habitué à vivre comme un ver dans les égouts, et pourrait-on même dire que c'est là mon destin à la naissance. Je l'ai pleinement accepté, et je l'ai même embrassé avec joie.  \nBien que je sois reconnaissant envers vous de m'avoir fait redécouvrir la douceur de la liberté, personne ne pourrait accepter mes goûts particuliers, ce qui est tout à fait normal. Après tout, la plupart des gens ici sont des êtres doux et bienveillants, incapables de comprendre que les mousses qui poussent dans les coins humides n'ont pas besoin de la lumière du soleil, mais plutôt d'un air sombre et obscur.  \nÀ part vous, mon respectable et bienveillant seigneur, seul vous êtes capable de me comprendre sincèrement, de m'aider véritablement, et de me procurer un bonheur profond et authentique. La douleur que vous m'avez infligée était si satisfaisante, si rassurante, qu'elle m'a permis de confirmer mon existence.  \nSi jadis je n'avais aucun désir particulier à formuler pour mon anniversaire, aujourd'hui je souhaite ardemment vous suivre, et vous offrir entièrement mon âme et mon corps.  \nBien sûr, je vous en prie, ne soyez pas doux et aimable avec moi par pure bonté. Traitez-moi avec mépris, réprimandez-moi, frappez-moi sans retenue !  \n\nLeia"
  },
  Mail_68915_Name = {
    Text = "<Yellow:Souhait de mousse...>"
  },
  Mail_68915_Sender = {Text = "Leigh"},
  Mail_68916_Desc = {
    Text = "Cher petit chiot :  \n\nJe crois que j'aime déjà ces journées passées à jouer avec toi au chat et à la souris, comme dans les vieux romans héroïques, où le héros vertueux parvient toujours à arrêter les méchants dans les derniers instants. Comme c'est touchant, comme c'est grand !   \nPourtant, te voir te débattre inutilement est vraiment trop drôle.   \nCe monde est déjà fichu, il n'y a aucun moyen de le sauver. Cette planète finira comme toutes les autres planètes mortes, engloutie par ▼&#x5B▼87;&4;▼.   \nBon, très bien, je vais continuer à jouer avec toi. Jusqu'à maintenant, je commence à peine à comprendre le plaisir de N. Avant que la fin inévitable n'arrive, peu importe ce que l'on fait.   \nPour l'anniversaire de ton cher maître, je t'ai préparé une grande surprise. Avant le compte à rebours final, j'espère que tu réussiras à trouver la « bombe » cachée.   \nAvant que nous soyons complètement dissous, combien de plaisirs pourras-tu encore m'offrir ?  \n\n\n« Dore »"
  },
  Mail_68916_Name = {
    Text = "Bombe de surprise..."
  },
  Mail_68916_Sender = {
    Text = "Doll : Dissoute"
  },
  Mail_68917_Desc = {
    Text = "Gardien : \n\nRécemment, une nouvelle tendance s'est répandue parmi les cercles aristocratiques de Londinium : dessiner soi-même ses propres modèles et commander des bijoux sur mesure. \nCes dames se prétendant si fines connaisseuses d'art ont soudainement cessé de rivaliser sur la taille des gemmes pour passer à la subtilité des dessins. Sans réaliser que leurs tentatives discrètes d'embaucher des peintres célèbres sont aussi transparentes que du verre, comme si elles se bouchaient les oreilles en espérant cacher leur jeu. \nGrâce à cette mode, ma liste de cadeaux d'anniversaire s'est enrichie de nombreuses pierres précieuses et bijoux d'apparat. Parmi elles, une belle rubis « sang de pigeon » manque simplement d'un joli sertissage digne d'elle. \nPlutôt que de faire appel à ces vieux joailliers ennuyeux, je préfère demander à mon chevalier de me dessiner un modèle plein de tendresse, ce serait un cadeau parfait, tu ne crois pas ? \nJ'attends ton œuvre avec impatience, j'ai toute confiance en ton goût.\n\nSorel"
  },
  Mail_68917_Name = {
    Text = "Conception de bijoux..."
  },
  Mail_68917_Sender = {Text = "Sorel"},
  Mail_68918_Desc = {
    Text = "Gardien du Secret : \n\nAvant même de te rencontrer, derrière d'innombrables portes, j'avais déjà vu d'innombrables versions de toi, identiques mais différentes.\nJe me souviens de tes joies et de tes colères, de chacun de tes choix, de l'image de toi avançant résolument dans différents mondes.\nPour moi, parmi tous ces toi, tu es celui de tous le plus spécial. J'ai autrefois donné des noms et numéroté dans mon cœur les mondes que j'ai observés. Le monde où tu te trouves, je l'ai appelé Espoir, un nom que j'ai choisi le jour où je t'ai rencontré.\nEn ce jour baptisé Espoir, peut-être auras-tu envie de jeter un coup d'œil aux autres mondes. À l'instar des yeux qui contemplent l'univers, je te guiderai pour voir tout ce que j'ai patiemment observé devant les portes.\nEt voir aussi ce que je vois en toi.\n\nTawil"
  },
  Mail_68918_Name = {
    Text = "Toi... différent"
  },
  Mail_68918_Sender = {Text = "Tawil"},
  Mail_68919_Desc = {
    Text = "Autrefois, le style sobre de Missaga me plaisait beaucoup, mais depuis l'arrivée de cette femme nommée Miryam, ma vie a perdu sa tranquillité. \nJe n'ai rien contre ceux qui recherchent la stabilité et la protection, chercher un réconfort dans ce monde trouble est une réaction naturelle des êtres vivants, cela ne me dérange pas. \nCependant, je n'aime pas me considérer comme un dieu tout-puissant, et encore moins depuis la disparition de Lémurie, il n'est plus nécessaire de créer un nouveau dieu hautain et distant. \nMiryam semble incapable de sortir de l'ombre du passé, c'est pourquoi elle a ramené ici cette pratique superstitieuse, me rendant célèbre partout sur le campus, attirant regards insistants et sollicitations incessantes, ce qui m'agace profondément. \nAujourd'hui est mon anniversaire, je suppose que cette femme a dû préparer une grande cérémonie dès le matin, l'idée même de m'y rendre me trouble l'esprit et me donne mal à la tête, je n'irai donc pas, pour ne pas m'attirer des soucis inutiles. \nSi tu le souhaites, tu peux me rejoindre à l'adresse indiquée à la fin de cette lettre pour une promenade calme. \nSurtout, ne laisse pas cette femme le découvrir. \n\nTulu"
  },
  Mail_68919_Name = {
    Text = "Se cacher pour trouver la paix..."
  },
  Mail_68919_Sender = {Text = "Tulu"},
  Mail_68920_Desc = {
    Text = "Je suis affamé tous les jours, je ne tiens pas plus de quelques instants sans boire du sang. Mais depuis que j'ai goûté le tien, tous les autres sangs ordinaires ont un goût de cire dans ma bouche. La saveur merveilleuse de ton sang me hante chaque jour, me tentant depuis ma gorge.\nJe sais exactement combien de sang je peux boire quand je vide complètement quelqu'un, une saveur si merveilleuse qui disparaît en un instant. Pour éviter que tu ne meures trop vite, j'apprendrai à supporter la faim, j'apprendrai à attendre patiemment le prochain festin, jusqu'au jour où je pourrai à nouveau savourer ton sang.\nHaha, incroyable, je n'arrive pas à croire que j'y suis arrivé. J'en viens même à douter si je n'ai pas évolué. Puisque j'ai fait preuve d'une telle retenue, au moins aujourd'hui, en ce jour d'anniversaire, laisse-moi goûter une fois à ton sang délicieux et sucré, juste un peu, qu'en dis-tu ?\nJ'ai utilisé l'argent que j'ai gagné au Trout Club pour t'acheter des compléments nutritionnels. Cette fois, tu ne souffriras plus d'anémie.\n\nYuwahas, affamé depuis longtemps"
  },
  Mail_68920_Name = {
    Text = "<Yellow:Le sang délicieux...>"
  },
  Mail_68920_Sender = {Text = "Uvhash"},
  Mail_68921_Desc = {
    Text = "Cher Gardien du Secret :\n\nJe suis heureux de voir tes progrès constants tout au long de l'année dans les cours d'entraînement. Bientôt, tu dépasseras même ce que j'étais à ton âge et deviendras un soldat puissant. J'éprouve une grande fierté à être ton instructeur.\nPour mon anniversaire cette année, j'ai reçu une paire de bottes parfaites pour l'escalade. Je me demandais si tu aurais envie de faire une randonnée avec moi, pour tester ta condition physique améliorée, et profiter de l'occasion pour admirer un lever de soleil au sommet de la montagne. La vue, loin des lumières de la ville, doit être magnifique.\nNaturellement, un pique-nique en pleine nature, accompagné d'une bouteille d'alcool pour nous réchauffer, rendrait cette sortie encore plus parfaite.\n\nElva"
  },
  Mail_68921_Name = {
    Text = "Randonnée en montagne..."
  },
  Mail_68921_Sender = {Text = "Alva"},
  Mail_68922_Desc = {
    Text = "Partenaire : \n\nIl s'est passé beaucoup de choses cette année, et cela n'a peut-être pas été une belle vie scolaire pour toi. \nJ'admets que j'ai souvent été trop exigeant envers toi cette année, et que ma préoccupation manquait un peu de délicatesse. Tous les entraînements semblaient un peu contre-productifs, te faisant porter trop de poids d'un coup. \nMais j'espère que tu sais que tu es toujours la personne la plus importante pour moi. En dehors du Gardien de Mizag, tu es mon seul partenaire. \nPeut-être qu'aujourd'hui, je veux dire juste pour ton anniversaire, je peux essayer d'être capricieux une fois, et tu peux aussi oublier toutes les responsabilités. Nous n'avons pas à nous soucier des devoirs ou des entraînements, mais à nous détendre pleinement. \nAller au parc d'attractions en ville ? Au théâtre ? Au grand magasin ou au marché de rue... peu importe, j'espère pouvoir te compenser pour ce qui a manqué. \nDe même, j'espère que cette journée sans préoccupations pourra être passée avec toi, et que tu pourras décider de tout le programme. \n\nRamona"
  },
  Mail_68922_Name = {
    Text = "Une journée de détente..."
  },
  Mail_68922_Sender = {Text = "Ramona"},
  Mail_68923_Desc = {
    Text = "Cher Gardien du Secret :  \n\nDurant les années que j'ai passées dans le monde des humains, mes chers serviteurs organisaient chaque année en ce jour une grande fête en mon honneur, rivalisant d'ingéniosité pour me plaire.  \nAlors qu'il s'agissait d'un jour ordinaire, il devenait réellement joyeux grâce à ces sourires étranges. En matière de savoir transformer la tristesse en plaisir ou de créer quelque chose à partir de rien, les humains excellent véritablement dans ce domaine.  \nMême dans cette école où les tombes sont construites au cœur du campus, vous parvenez encore à créer de la joie avec une telle ténacité, ce qui me surprend vraiment.  \nCependant, les cadeaux des gens ordinaires sont franchement ennuyeux, et ces prétendues fêtes d'anniversaire sont incroyablement soporifiques. La vulgarité domine largement chez ces êtres médiocres.  \nToi seul, toi seul me procure encore un peu d'intérêt lorsque je pense à toi, me permettant de retrouver le plaisir d'autrefois.  \nJ'exige que tu viennes immédiatement dans ma chambre, que nous jouions ensemble jusqu'au matin. Si tu me sers bien, je pourrais même t'accorder avec réticence le droit de baiser le dos de ma main.  \n\nWanda"
  },
  Mail_68923_Name = {Text = "Ordre..."},
  Mail_68923_Sender = {Text = "Wanda"},
  Mail_68924_Desc = {
    Text = "<Del:West-Whelp>Gardien des chats : \nJe n'avais pas l'intention d'écrire un truc aussi mièvre, mais Aigis n'arrêtait pas de me parler de souvenirs, de signification et tout ça, et elle a insisté pour que je t'écrive cette lettre. \nPuisque c'est Aigis qui me le demande, je veux bien dire deux mots. Enfin bref, voilà déjà un an que je suis ici, et en général, je suis assez satisfait du logement et de la nourriture de l'école, sauf que les draps de lit dans les dortoirs sont vraiment trop glissants, ça me gêne pour dormir. Est-ce que vous ne trouvez pas que ce sont les tissus épais en coton qui sont les plus confortables pour dormir ? \nSi je devais encore râler sur quelque chose, ce serait la nourriture de la cantine, qui est trop saine. Certes, on est rassasié après avoir mangé, mais tout semble sans saveur, comparé aux spécialités de rue, c'est vraiment pas comparable ! \nAlors cette année, pour mon anniversaire, je ne veux pas embêter les cuisiniers, laissez-moi, votre grand maître gourmet, vous emmener tous avec moi dans les petites ruelles mystérieuses du quartier Est, pour goûter les étals recommandés par moi et par Brown, et vous serez aussitôt conquis par ces délices de rue ! \nÉvidemment, toutes les dépenses d'aujourd'hui seront couvertes par West-Whelp, tu n'y vois pas d'inconvénient ? \n\nTon vieux pote Jenkin et Brown"
  },
  Mail_68924_Name = {
    Text = "Nourriture de rue..."
  },
  Mail_68924_Sender = {Text = "Jenkin"},
  Mail_68925_Desc = {
    Text = "Personne chère : \n\nÀ part ma sœur, tu es la première personne à me soutenir aussi sincèrement. Grâce à tes conseils, j'ai désormais publié une série d'albums avec la maison de disques, et je vais bientôt donner mon premier concert solo. \nJe souhaite que mon tout premier concert sur cette planète ait lieu le jour de mon anniversaire, pour célébrer ma renaissance ici. \nJ'aimerais que tu sois présent pour écouter mon chant interprété avec tout mon cœur. J'aimerais aussi t'inviter, ainsi que ma sœur, en tant qu'invités spéciaux lors de la dernière partie du spectacle, pour chanter ensemble ma nouvelle chanson. Qu'en penses-tu ? \nÀ propos, ne dis rien à ma sœur, car c'est aussi son anniversaire. Je veux lui faire une surprise. \nQuant à la promesse que j'ai faite avec ma sœur de formuler un vœu pour nous-mêmes le jour de notre anniversaire, j'aimerais que mes chansons brillent à nouveau sur cette planète. \n\nTeinture"
  },
  Mail_68925_Name = {Text = "Concert..."},
  Mail_68925_Sender = {Text = "Tinct"},
  Mail_68926_Desc = {
    Text = "Cher Gardien du Secret : \n\nUn an s'est écoulé sans que je m'en rende compte, chaque jour à Mythaga est pour moi une source de bonheur infini. J'ai pu jouer, suivre des cours et déguster tellement de bonnes choses en votre compagnie, ce sont les moments les plus heureux de ma vie. Même si parfois je suis un peu nerveuse lors des missions, combattre aux côtés de tout le monde me rend courageuse, Aigis n'a jamais peur. \nJe suis vraiment désolée de vous avoir causé bien des soucis cette année. Bien que ce soit souvent Jeanne qui fait des bêtises, elle ne cherche qu'à nous rendre joyeux. J'espère que vous ne tiendrez pas rigueur de nos maladresses et impolitesses. \nEn parlant de Jeanne, cette année elle a proposé d'organiser une compétition de capture de lucioles le jour de mon anniversaire. Elle a préparé beaucoup de pots transparents, prévoyant d'en faire plein de lanternes à lucioles. Celui dont la lampe brillera le plus remportera le titre de « Maître de la capture des lucioles ». \nBien que ce titre sonne un peu ridicule, la forêt où nous allons en été est vraiment magnifique, illuminée par des myriades de lucioles. Si vous avez un moment libre au milieu de votre emploi du temps chargé, n'hésitez pas à nous rejoindre dans la forêt pour admirer ce paysage scintillant comme les étoiles. \n\nAigis"
  },
  Mail_68926_Name = {
    Text = "<Yellow:Capture de lucioles>..."
  },
  Mail_68926_Sender = {Text = "Aigis"},
  Mail_68927_Desc = {
    Text = "Gardien du Secret ! L'autre jour, quand Aurita est allée nager dans la mer, elle a rencontré un nouvel ami capable de produire des décharges électriques ! Il est rond et plat, comme une grande pizza !\nAurita a essayé de le saluer, mais soudain, elle a ressenti un picotement dans tout son corps, et le nouvel ami a immédiatement disparu.\nEn rentrant, Dore m’a expliqué qu’il s’agissait d’une raie électrique en train de décharger. Aurita n’a pas bien compris, mais elle a trouvé ce nouvel ami vraiment impressionnant ! C’est aussi l’anniversaire d’Aurita aujourd’hui. Gardien du Secret, accompagne Aurita pour aller chercher son nouvel ami et ramène-le vivre avec tous ses compagnons ! Ce picotement, tu vas sûrement l’aimer aussi !\n\nAurita"
  },
  Mail_68927_Name = {
    Text = "Un nouvel ami capable de décharger de l'électricité…"
  },
  Mail_68927_Sender = {Text = "Aurita"},
  Mail_68928_Desc = {
    Text = "Gardien du Secret respecté : \n\nPour moi, les anniversaires d'enfance étaient faits des exigences froides de mon père, de séances d'exercices de musique intenses sans aucune détente possible.\nNe pas être fier, ne pas être impatient, ne pas être paresseux : à part le fait que ma mère me préparait en secret un petit gâteau, cette journée n'était pour moi qu'une occasion supplémentaire de recevoir des réprimandes sévères me pointant du doigt toutes mes insuffisances de l'année écoulée.\nAujourd'hui, je ne suis plus un apprenti musicien, et grâce à vous, j'ai pu toucher cette grande porte majestueuse et pénétrer dans le temple suprême de la musique, mais les enseignements reçus depuis mon enfance m'ont déjà rendu imperméable à tous les plaisirs ordinaires.\nSeule la musique, seule l'interprétation pour vous de cette mélodie fatale du Requiem constitue l'aboutissement ultime de ma vie, le seul moment où je ressens un sens profond, une véritable existence.\nSi vous consentez à me confier le temps juste avant votre sommeil ce soir, je jouerai pour vous toute la nuit durant cette mélodie gravée en mon âme, jusqu'au lever du jour.\n\nHamelin"
  },
  Mail_68928_Name = {
    Text = "Vœu de jouer de la musique..."
  },
  Mail_68928_Sender = {Text = "Hamelin"},
  Mail_68929_Desc = {
    Text = "Jeune impudent : \n\nDepuis que je suis arrivé chez vous, j'espérais enfin m'éloigner de cette folle moralisatrice, mais les règles ici sont encore plus nombreuses que chez cette femme. Je ne me suis plus amusé comme il faut depuis bien longtemps ! Boire à grandes gorgées, interdit ; draguer les jolies filles, interdit ; les festins autour du feu de camp, interdits ; même la viande grillée ici est bien inférieure à celle des Philistins ! Vraiment, je ne comprends pas comment vous arrivez à vivre une vie si fade. \nMais un homme fort ne se plaint pas de l'environnement. Après avoir mené mes combats, je suis redevenu ici un grand chef de gang respecté. À l'occasion du grand anniversaire de notre maître Goliath, j'ai la bonté de t'inviter à la fête que mes hommes ont organisée en mon honneur. Il y aura de bonnes viandes, de belles boissons et de charmantes compagnes en abondance, de quoi émerveiller un petit ignorant comme toi. \nPar respect pour notre ancienne relation, je ne te demanderai aucun cadeau. Tu n'as qu'à apporter ton respect et venir célébrer la renaissance d'un puissant. Regarde bien, car l'année prochaine à cette date, ou même dans deux ans, peu importe où je serai, j'aurai certainement ouvert une toute nouvelle voie. \nGoliath"
  },
  Mail_68929_Name = {
    Text = "<Yellow:Voyage…>"
  },
  Mail_68929_Sender = {Text = "Goliath"},
  Mail_68930_Desc = {
    Text = "Gardien : \n\nJamais je n'avais songé à célébrer l'anniversaire de cette enveloppe charnelle si insignifiante, considérant cette journée comme un jour ordinaire de pratique spirituelle. Pourtant, ce matin, le Roi m'a personnellement trouvé et m'a verbalement ordonné de ne rien faire aujourd'hui qui concerne le Roi ou ma pratique, et de passer la journée entièrement pour moi-même. \nC'est la première fois depuis de longues nuits et de nombreux jours que le Roi pense à moi de la sorte, ce qui me remplit à la fois d'humilité et de gratitude. Cependant, ayant entièrement dévoué ma vie au Roi, j'ai soudainement été pris au dépourvu, ne sachant où aller ni que faire.\nAprès réflexion, la seule chose qui me vient à l'esprit comme étant un regret persistant, est le sentiment de culpabilité envers l'enfant Murphy. Même si je n'ai jamais regretté une seule seconde mes actions pour la restauration de notre ancien pays, je sais pertinemment que ce que je lui dois ne pourra jamais être remboursé ni réparé.\nMais si, au fond de mon cœur, il y avait une chose que j'aimerais vraiment faire, ce serait peut-être d'oser, sans vergogne, redevenir une mère une dernière fois.\nJ'ai spécialement acheté la pâtisserie que cette enfant aimait autrefois. Considère cela comme l'accomplissement d'une mère pitoyable et indigne. Puis-je t'implorer de remettre ce cadeau entre ses mains ? Je te demande seulement de ne pas lui révéler que c'est moi qui l'ai offert, dis-lui simplement que c'est un cadeau de ta part.\nJ'espère humblement que tu accepteras. Merci infiniment.\n\nMiryam"
  },
  Mail_68930_Name = {
    Text = "<Yellow:Compenser...>"
  },
  Mail_68930_Sender = {Text = "Miryam"},
  Mail_68931_Desc = {
    Text = "Ah ah, après avoir réfléchi avec sagesse, j'ai complètement compris la signification de l'anniversaire humain. En effet, cette journée spéciale qui appartient à une personne en particulier offre l'opportunité rare d'exercer des privilèges, d'obtenir des objets précieux, et surtout de formuler des souhaits envers les autres avec assurance. \nPeu importe à quel point ces souhaits seraient difficiles à exprimer ou même impensables habituellement, ils peuvent être satisfaits en ce jour. Ha, c'est vraiment une journée bien plus excitante que n'importe quelle fête religieuse. \nJe vois maintenant que durant toutes ces années passées, j'ai manqué bien des occasions de profiter de ces privilèges. Heureusement, grâce à ma longue espérance de vie, j'aurai encore beaucoup, beaucoup d'anniversaires pour faire des vœux. \nAlors, souhaiter que tout le monde me rejoigne pour un bon combat en cette journée d'anniversaire, ce doit être un souhait facile à réaliser, non ? \n\nRotan"
  },
  Mail_68931_Name = {
    Text = "Les privilèges de l'anniversaire…"
  },
  Mail_68931_Sender = {Text = "Lotan"},
  Mail_68932_Desc = {
    Text = "Gardien des secrets : \n\nAvec l'âge, les anniversaires sont progressivement devenus des journées que l'on oublie facilement sur le calendrier. Souvent, ce n'est qu'après un certain temps, lorsqu'on s'en souvient par hasard, que l'anniversaire s'est déjà écoulé comme de l'eau s'écoulant discrètement. \nDans le monde des adultes, célébrer son anniversaire est un privilège réservé aux enfants et aux personnes oisives. Moi-même, je suis devenu à mon insu un adulte oisif, n'attendant plus grand-chose de mes anniversaires. \nIl y a eu une année où j'ai eu l'idée soudaine de sculpter un magnifique gâteau en sculpture. Les années suivantes, je n'ai plus jamais manqué de commander un gâteau pour mon anniversaire en raison d'un oubli, préférant simplement retrouver dans le dépôt cette pièce spéciale qui ne se détériore jamais le jour J, et souffler les bougies rituellement, marquant ainsi la fin d'un anniversaire. \nCe n'est qu'en arrivant à Missaga que j'ai découvert qu'une même personne pouvait être à la fois oisive et occupée. Ici, les gens ne se contentent pas d'être oisifs individuellement, ils insistent pour que tout le monde le soit avec eux. \nCes deux dernières années à Missaga, les fêtes d'anniversaire auxquelles j'ai participé ont été plus nombreuses que toutes celles auxquelles j'avais assisté durant la première moitié de ma vie. Ce qui est encore plus amusant, c'est que j'ai même trouvé un plaisir étrange dans ces célébrations oisives. \nPeut-être qu'en dehors des thèmes tragiques et sérieux, représenter des scènes absurdes du quotidien peut aussi être une forme d'art. \nEn parlant de cela, mon projet créatif pour cette année sera de sculpter une statue en buste du Gardien des secrets riant bêtement, qui portera fièrement mon gâteau sculpté. \nN'oublie pas de venir tôt dans mon atelier, ma muse et mon modèle. \n\nShan"
  },
  Mail_68932_Name = {
    Text = "Plaisir ennuyeux..."
  },
  Mail_68932_Sender = {Text = "Sanga"},
  Mail_68933_Desc = {
    Text = "Chère Ramona :\n\nAprès bien des hésitations, je t'écris cette lettre depuis ce monde silencieux et désolé. Depuis longtemps déjà, j'avais presque oublié la date de mon anniversaire ; dans un tel monde, célébrer serait de toute façon futile.\nPourtant, depuis que je t'ai rencontré, je suis devenu de plus en plus égoïste. De jour en jour, même la solitude à laquelle j'étais habitué devient difficile à supporter.\nÀ ces moments-là, naît en moi une émotion étrange : j'éprouve un peu d'envie, presque imperceptible, envers celui que j'étais dans l'autre monde. Tu vois, même quelqu'un comme moi, qui se targue d'être rationnel, peut un jour avoir des pensées aussi mesquines. Cela montre bien que la justice et la raison humaines ont leurs limites.\nJe sais déjà quelle invitation tu me feras, mais pour l'espace-temps, il faut éviter autant que possible les perturbations inutiles. Je ne devrais pas, et ne vais pas, venir dans ton monde.\nÀ l'instant où j'écris ces lignes, je contemple l'univers, fixant l'endroit par où s'ouvre le tunnel. Si, par hasard, tu regardes aussi en ce moment, alors nous contemplons ensemble la même voûte céleste.\nJ'espère que cette lettre pourra voyager à travers le temps et l'espace et parvenir entre tes mains. En passant par tes yeux et tes lèvres, elle te rencontrera, elle s'appuiera sur toi.\nQuand tu serreras cette lettre contre toi, j'imaginerai, depuis mon bout du monde, te serrer dans mes bras.\n\n« Ramona »"
  },
  Mail_68933_Name = {
    Text = "<Yellow:Regarder au loin ensemble...>"
  },
  Mail_68933_Sender = {
    Text = "Ramona : Vétuste"
  },
  Mail_68934_Desc = {
    Text = "Mon petit prisonnier :  \n\nSavais-tu que, tout comme les animaux ont des régimes alimentaires différents, les gens ont aussi des besoins variés en matière de chaleur ? Certains se sentent au chaud rien qu'en enfilant un vêtement supplémentaire, d'autres ont besoin d'une main chaude, d'une étreinte réconfortante, tandis que certains aspirent à une température aussi élevée que celle de la cire fondue.  \nUne chaleur si brûlante, si épaisse, qui s'inscrit sur chaque terminaison nerveuse, dessinant clairement sur la peau le chemin sinueux des gouttes de cire. Une douleur légère, une sensation frémissante, jusqu'au moment où l'on ne peut s'empêcher de crier, seulement alors peut-on pleinement ressentir sa propre existence.  \nParfois, je me transforme en bougie, savourant la joie de laisser une marque. D'autres fois, je me laisse envoûter par la chaleur de la bougie, désirant ardemment cette douceur brûlante qui fait mal.  \nL'hiver est déjà arrivé à Mithagar, et récemment, j'ai souvent eu froid, ainsi que cette solitude que la froideur apporte.  \n\nMon cher, tu dois savoir quel jour nous sommes aujourd'hui. Mon souhait est très simple, et je suis sûr que, par bonté, tu auras à cœur de m'offrir une chaleur capable de chasser ma solitude.  \n\nPandia"
  },
  Mail_68934_Name = {
    Text = "<Yellow:Besoin chaleureux>…"
  },
  Mail_68934_Sender = {Text = "Pandia"},
  Mail_68935_Desc = {
    Text = "Gardien : \n\nCette année, j'ai convenu avec Tinct que nos souhaits d'anniversaire ne peuvent concerner que nous-mêmes, et non des vœux pour l'autre. \nBien que ce soit elle qui ait d'abord proposé cet accord par caprice, il est évident que cela l'a également mise dans une situation délicate. \nNous sommes tellement entremêlés l'un avec l'autre depuis trop longtemps qu'il est difficile de penser de manière indépendante comme des personnes ordinaires, mais renaître dans une nouvelle vie pleine d'aide et de préoccupations, il n'y a pas de meilleur moment pour apprendre à marcher seul qu'à présent. \nAprès mûre réflexion, j'ai déjà pensé au souhait que je vais faire cette année : me faire cinq nouveaux amis... non, trois plutôt. Après tout, changer soi-même doit se faire petit à petit. \nEn tant que mon seul et si populaire ami pour l'instant, peut-être pourrais-tu me donner quelques secrets sur l'amitié ? \n\nFaint"
  },
  Mail_68935_Name = {
    Text = "Souhait d'amitié…"
  },
  Mail_68935_Sender = {Text = "Faint"},
  Mail_68936_Desc = {
    Text = "Gardien du Secret : \n\nChaque année, en faisant un vœu pour mon anniversaire, je formule toujours le même souhait : la métamorphose d'une lignée parfaite. Je le sais depuis longtemps, ma quête obsessionnelle de la pureté du sang peut sembler têtue, ridicule, voire pitoyable et méprisable aux yeux des autres.\nMais vous, ce n'est pas pareil. Quoi qu'il arrive, je sais que vous me soutiendrez toujours dans cette voie, même si je bute contre des obstacles, tombe ou rentre bredouille, tandis que les autres rient. Vous serez toujours la première personne à vous préoccuper de moi.\nPeut-être que ni vous ni personne ne pourrez jamais comprendre ce qu'une personne traîne comme fardeau lorsqu'elle a été opprimée et humiliée depuis l'enfance. Mais ce n'est pas grave. Toutes les épreuves de ce chemin de transformation se sont déjà changées en chair et en force, me permettant de me relever sans cesse, de résister encore et encore.\nJe ne suis plus l'être impuissant que j'étais dans ma jeunesse. Quels que soient les défis qui m'attendent, je persévérerai jusqu'au bout.\nJusque-là, je vous demande simplement de me regarder, d'attendre patiemment que j'atteigne le succès.\nAh, au fait, les cinquante pièces que vous m'avez données, je vous ai dit que je vous les rembourserais. Je viens de mettre la somme complète de côté, et il me reste même deux pièces en plus. Je vous les donne aussi, en guise de remerciement.\n\nKhaïx"
  },
  Mail_68936_Name = {
    Text = "Rends-moi l'argent…"
  },
  Mail_68936_Sender = {Text = "Caecus"},
  Mail_68937_Desc = {
    Text = "Cher Gardien du Secret :  \n\nBonjour, bienvenue dans le remplissage du questionnaire annuel d'inspection technique de la poupée automatique Erica. Je vais recueillir vos expériences réelles et les problèmes rencontrés lors de votre utilisation d'Erica au cours de cette année. Votre avis constitue la direction essentielle pour l'amélioration continue d'Erica.  \nVeuillez ensuite répondre aux questions ci-dessous en attribuant des notes allant de 1 à 5, en fonction de votre niveau d'accord. Merci beaucoup pour votre retour.  \nFacilité d'utilisation : 1 à 5 points  \nVitesse de réponse lors de l'utilisation : 1 à 5 points  \nDegré de compréhension des besoins : 1 à 5 points  \nDegré d'attention aux émotions de l'utilisateur : 1 à 5 points  \nPrécision lors de la recherche d'informations : 1 à 5 points  \nDegré d'utilité des solutions proposées : 1 à 5 points  \nEnfin, veuillez décrire brièvement les problèmes rencontrés lors de votre utilisation d'Erica ainsi que les aspects qui vous ont insatisfait. Ces problèmes pourront peut-être être résolus par la suite.  \nUn petit cadeau souvenir anniversaire sera livré dans votre chambre après avoir terminé le questionnaire. Pendant l'année à venir, Erica, votre assistante la plus attentionnée, restera toujours à vos côtés. Merci encore pour votre utilisation, au revoir.  \n\nErica"
  },
  Mail_68937_Name = {
    Text = "Questionnaire annuel d'inspection technique..."
  },
  Mail_68937_Sender = {Text = "Erica"},
  Mail_68938_Desc = {
    Text = "Gardien du Secret : \n\nChaque année, le jour de mon anniversaire, je consacre la journée entière à repasser mes souvenirs dans ma tête et à rédiger à nouveau le même journal intime.\nPlus le temps s'écoule et plus les souvenirs anciens s'estompent ; ces jours où j'attendais patiemment le retour du voyageur vers la lumière, ces jours où j'admirais avec révérence la majesté du Roi, tout cela devient flou.\nMais je refuse d'oublier, je ne dois pas oublier. Même si l'attente est infiniment longue, même si mon âme doit brûler, cette lumière ne s'éteindra jamais, jusqu'au jour où notre patrie renaîtra, et je serai la première lumière à répondre à l'appel.\nJ'ai imaginé mille façons dont notre retrouvaille pourrait se dérouler, mais je n'aurais jamais pensé vous revoir ici, le Roi et le Prêtre. Selon vos propres paroles, si l'endroit où l'on trouve la paix intérieure est le foyer, alors cet endroit peut désormais être considéré comme ma seconde patrie, et les mots dans mon journal, autrefois des souvenirs, deviennent enfin de nouvelles mémoires du quotidien.\nJe ne désire aucune récompense ni aucun cadeau, le simple fait de pouvoir suivre à nouveau le Roi est le plus grand bonheur qui soit.\nSi la lumière de mon existence ne peut illuminer les fonds marins de notre patrie, alors qu'elle suive les pas du Roi et éclaire provisoirement cette terre du continent.\n\nFalothes"
  },
  Mail_68938_Name = {
    Text = "<Blue:Suiveur> mon <Blue:roi>…"
  },
  Mail_68938_Sender = {Text = "Faros"},
  Mail_68939_Desc = {
    Text = "Gardien : \n\nFélicitations à moi, félicitations à toi, félicitations à Mizag, félicitations à nous d'avoir survécu une année de plus sous la poursuite de l'horreur noire. \nAujourd'hui n'est pas un simple anniversaire, c'est l'anniversaire de ma survie, c'est le jour de célébration de ma vie tenace. \nVivre, ces deux simples mots contiennent tant de difficultés, cette vitalité brûlante ne peut être égalée que par le parfum d'un café brûlant. Rejoignons ensemble le culte du café, Gardien, célébrons la clarté, célébrons chaque \n\nUn petit mot envoyé avec la lettre : \nAh, ce gars de Winkle a encore trop consommé de café, l'excitation nerveuse combinée à une fatigue excessive l'a fait s'évanouir directement sur la table. Je l'ai déjà placée à l'infirmerie, ne t'inquiète pas. \nCependant, avant de s'évanouir, elle a sorti un paquet de grains de café précieux et du papier à lettres pour les mettre ensemble, il semble qu'elle voulait te les offrir, je les ai donc joints à la lettre, en espérant qu'elle ne le regrettera pas une fois réveillée. \nQuant à son anniversaire, plutôt qu'une fête de célébration, peut-être que lui permettre de bien se reposer est le meilleur cadeau. \n—— Sylvia"
  },
  Mail_68939_Name = {
    Text = "Louer la vie..."
  },
  Mail_68939_Sender = {Text = "Winkle"},
  Mail_68940_Desc = {
    Text = "Gardien : \n\nAh ah ah ! Après avoir gravé 12 rappels dans tous les coins de la pièce et écrit 36 notes (ou peut-être plus, mais je ne les trouve pas), j'ai enfin réussi à me souvenir que c'est mon anniversaire aujourd'hui ! \n Qui l'aurait cru, c'est seulement ce matin que je m'en suis rappelé, mais tout cela est grâce à mes préparatifs acharnés cette année, je ne voulais pas manquer un jour aussi spécial. \n La dernière fête que j'ai faite avec tout le monde était vraiment agréable, surtout le jeu avec je ne sais plus qui, et le dessert que nous avons mangé... Enfin, peu importe, c'était juste super ! \n Quand j'étais enfant, ma mère m'achetait toujours un livre d'histoires d'aventure pour mon anniversaire, et nous lisions ensemble chaque soir avant de dormir, rêvant de merveilleuses aventures. Bien que je les oublie rapidement au réveil, cette joie reste gravée dans ma mémoire, je suis convaincu que les émotions précieuses ne s'oublient jamais. \n De plus, il y a aussi des avantages à être oublieux, même si je ne me souviens pas de ce que j'ai fait à la dernière fête, aujourd'hui je peux tout revivre, alors s'il te plaît, emballe-moi une nouvelle portion de la joie de la dernière fois ! \n\n Avec impatience, Nautila"
  },
  Mail_68940_Name = {
    Text = "Encore une fois…"
  },
  Mail_68940_Sender = {Text = "Nautila"},
  Mail_68941_Desc = {
    Text = "Cher gardien du secret,\n       Dans la mise à jour V1.7.1, l'état débloqué de l'événement « Helot : Enchaînée » dans la « Fête de Reproduction » a été anormalement perdu. Étant donné que vous avez à nouveau débloqué l'événement après la perte de l'état, nous vous remboursons les « Point de départ réel*3 » consommés lors de ce second déblocage. Veuillez vérifier."
  },
  Mail_68941_Name = {
    Text = "Compensation pour le déblocage de la fébrilité de reproduction d'Helot-catena"
  },
  Mail_68941_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_71330_Desc = {
    Text = "Cher Gardien :\nL'événement « Un demi-pas de distance » est terminé. Les « Pièces de poupée » restantes seront échangées au taux de 40 « Billet Rose Dorée » par unité. Veuillez vérifier votre inventaire."
  },
  Mail_71330_Name = {
    Text = "Récupération de pièces de poupée"
  },
  Mail_71330_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_71331_Desc = {
    Text = "Cher Gardien :\nL'événement « Histoire magie » est terminé. Les « Inspiration errante » restantes ont été converties au taux de 1 unité = « Billet Rose Dorée*40 ». Veuillez vérifier et les récupérer."
  },
  Mail_71331_Name = {
    Text = "Récupération d'Inspiration Vagabonde"
  },
  Mail_71331_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_71332_Desc = {
    Text = "Cher Gardien :\nL'événement « Avant que le printemps ne fane » est terminé. Les « Poème joyeux », « poésie mélancolique » et « Poème de Regret » restants ont été convertis au taux de 1 unité = « Billet Rose Dorée*40 ». Veuillez vérifier et les récupérer."
  },
  Mail_71332_Name = {
    Text = "Recyclage de poèmes"
  },
  Mail_71332_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_71848_Desc = {
    Text = "Cher Gardien :\nL'événement « Avec le livre de la rose » est terminé. Les « Éventail de plumes d'Invocation » restants seront convertis au taux de 1:40 en « Billet Rose Dorée ». Veuillez vérifier votre inventaire, Gardien."
  },
  Mail_71848_Name = {
    Text = "Recycler l'éventail en plumes de spiritisme"
  },
  Mail_71848_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_74020_Desc = {
    Text = "Cher Gardien :\nL'événement « Les étoiles retrouvent leur place·clon » est terminé. Les « Embryon ignorant », « Embryon sans désir » et « Graine insatiable » restants seront convertis au taux de « Billet Rose Dorée*40 » par unité. Veuillez vérifier, Gardien."
  },
  Mail_74020_Name = {
    Text = "Récupération d'embryo"
  },
  Mail_74020_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_74347_Desc = {
    Text = "Cher Gardien :\nL'événement « Pasteur de l'Âme·clon » est terminé. Les « Billet de vente au profit d'une bonne cause » restants seront échangés au taux de « Billet Rose Dorée*40 » par unité. Veuillez vérifier votre courrier, Gardien."
  },
  Mail_74347_Name = {
    Text = "Collecte de Voucher de Charité"
  },
  Mail_74347_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_74841_Desc = {
    Text = "Partenaire : \n\nAujourd'hui l'année dernière, je n'aurais jamais imaginé qu'un an plus tard, je ne pourrais que jeter cette lettre dans une boîte aux lettres vide.\nTu venais tout juste d'entrer à Mythag à l'époque, pas différent d'un étudiant turbulent et paresseux. Même si j'y repense aujourd'hui, je me rends compte que j'étais souvent trop dur avec toi, trop attaché à ce masque de rationalité et de retenue.\nEn réalité, j'avais acheté un bouquet de fleurs ce jour-là, je suis resté devant la porte de la bibliothèque, longuement regardé les roses enveloppées de ruban rouge et de papier d'emballage vert foncé, avant de finalement les placer près de mon lit.\nUn an plus tard, les fleurs sont depuis longtemps fanées, seule la bande rouge vif est restée attachée à la clé en argent numéro K-0617, toujours aussi éclatante que neuve.\nComme j'aurais aimé pouvoir racheter un bouquet de roses, mais aujourd'hui elles n'ont plus d'autre destin que de se faner à nouveau près de mon lit.\nHabitué à détailler des solutions pour chaque chose, le goût du regret est pour moi une sensation à la fois nouvelle et amère.\nPourtant, j'ai toujours entretenu une confiance presque aveugle, pensant que ton âme n'était pas partie pour de bon, que peut-être tu voyageais ailleurs dans l'univers, mais que finalement tu reviendrais ici, vers moi.\nJe ne crois pas que ce soit là le rêve insensé d'un fou, car chaque fois que je me rends à la Piscine Noire pour contempler ton visage, je sens toujours au fond de mon cœur cette chaleur douce qui nous relie et résonne en moi.\nJ'y croirai toujours, j'attendrai et espérerai ce jour de retrouvailles, et au moment où nos mains se rejoindront à nouveau, je te remettrai en personne les roses que je te dois aujourd'hui.\n\nRamona"
  },
  Mail_74841_Name = {Text = "Rose..."},
  Mail_74841_Sender = {Text = "Ramona"},
  Mail_76410_Desc = {
    Text = "Cher Gardien :\nL'événement « Ombre de la ville pluvieuse » est terminé. Les « Crâne de Bête Pâle », « Crâne de Bête Ombreuse » et « Crâne de la Bête Écarlate » restants seront convertis au taux de « Billet Rose Dorée*40 » par unité. Veuillez vérifier."
  },
  Mail_76410_Name = {
    Text = "Récupération de la monnaie d'« Ombre de la Ville Pluvieuse »"
  },
  Mail_76410_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_78653_Desc = {
    Text = "Cher gardien du secret :\nL'événement de réédition « Guérison multiple·clon » est terminé. Les devises restantes « Mémoires en puzzle » seront récupérées au taux de « Billet Rose Dorée » × 40 pour chaque unité. Veuillez vérifier."
  },
  Mail_78653_Name = {
    Text = "Récupération de puzzle de mémoire"
  },
  Mail_78653_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_78792_Desc = {
    Text = "Cher Gardien :\nL'événement « Jusqu'aux Dernières Neiges·clon » est terminé. Les devises d'événement « Bouton de fleur gelé », « Bouton de fleur d'argent givré » et « Bouton de soleil » restantes seront échangées au taux de « Billet Rose Dorée*40 » par unité. Veuillez les récupérer."
  },
  Mail_78792_Name = {
    Text = "Récupération de bourgeons"
  },
  Mail_78792_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_79390_Desc = {
    Text = "Cher gardien, \n        Merci pour votre soutien envers [ Morimens ]. Afin d'améliorer l'expérience de jeu des gardiens à l'Université de Misargh, nous vous invitons sincèrement à remplir le questionnaire d'évaluation ci-dessous. En remerciement de votre coopération, nous avons préparé [Cœur d'argent*200] comme récompense. Vous pourrez les récupérer une fois le questionnaire rempli. La date limite pour répondre est le 17 mars à 9h00, veuillez ne pas manquer le délai.\n   <SurveyLink:[Cliquez ici pour remplir]>\n   Nous écoutons attentivement les suggestions de chaque gardien, et vos retours contribueront certainement à rendre l'Université de Misargh de plus en plus excellente !\n — Que la Clé d'argent guide votre chemin."
  },
  Mail_79390_Name = {
    Text = "Questionnaire de retour d'expérience V2.1.0"
  },
  Mail_79390_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_79646_Desc = {
    Text = "Cher Gardien :\nL'événement « Enterré sous la mémoire » est terminé. Les « Rapport de diagnostic » restants seront convertis au taux de « Billet Rose Dorée*40 » par unité. Veuillez vérifier, Gardien."
  },
  Mail_79646_Name = {
    Text = "Récupération de la monnaie enfouie sous la mémoire"
  },
  Mail_79646_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_80091_Desc = {
    Text = "Gardien du Secret : \n\nQuand tu ouvriras cette lettre, cela signifiera que l'hypnose que j'ai implantée en toi a pris effet.\nHaha, ne t'inquiète pas. Ce n'est qu'un léger sortilège destiné à assurer le bon déroulement de mon dîner d'anniversaire, il ne te causera aucun problème.\nMaintenant, tu ressentiras sincèrement l'envie d'aller faire des courses, suis cette impulsion, rends-toi dans la rue et choisis dans les vitrines étincelantes un cadeau qui me fasse plaisir, puis remets-le-moi en main propre.\nJe comprends ton interrogation actuelle, et je la trouve même justifiée, mais l'anniversaire donne certains privilèges, n'est-ce pas ? Je fais cela simplement parce que j'ai peur que tu oublies cette journée spéciale. Après tout, tu es mon invité tant attendu.\nEnfin, je t'attendrai patiemment — n'oublie pas le cadeau.\n\nClémentine"
  },
  Mail_80091_Name = {
    Text = "Cadeau « fait main »"
  },
  Mail_80091_Sender = {Text = "Clementine"},
  Mail_81288_Desc = {
    Text = "Cher gardien,\n        Merci pour votre soutien envers « Morimens ». Afin d'améliorer l'expérience de jeu des gardiens au sein de l'Université de Misargh, nous vous invitons sincèrement à remplir le questionnaire de satisfaction ci-dessous. En remerciement de votre coopération, nous avons préparé « Cœur d'argent*200 » comme récompense. Vous pourrez les récupérer dès la fin du questionnaire. La date limite pour répondre est le 14 avril à 9h00, veuillez ne pas manquer le délai.\n<SurveyLink:« Cliquez ici pour remplir le questionnaire »>\nNous écoutons attentivement chaque suggestion des gardiens. Vos retours contribueront certainement à rendre l'Université de Misargh de plus en plus excellente !\n—Que la Clé d'argent guide votre chemin."
  },
  Mail_81288_Name = {
    Text = "Questionnaire de retour d'expérience V2.2.0"
  },
  Mail_81288_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_81326_Desc = {
    Text = "Bienfaiteur :\n\nAujourd'hui est pour moi et Pollux le seul jour de fête de l'année. Lorsque nous étions à l'Église, il ne nous était pas permis d'accorder trop d'importance à notre propre signification : toute notre valeur résidait uniquement dans l'éternelle mission de servir le Porteur de Lampe, et face à une telle foi, toutes les autres fêtes n'étaient que vanité sans sens.\nPourtant, chaque année à l'approche de notre anniversaire, Pollux et moi célébrons secrètement ce jour. Nous préparons en cachette un petit cadeau pour l'autre, et attendons discrètement que ce jour arrive.\nNos célébrations ont généralement lieu tard dans la nuit, notre unique moment de liberté dans la journée. Grâce à ses mains habiles et à son imagination, les cadeaux de Pollux surpassent toujours les miens. Une fois, il est même parvenu à confectionner une fleur épanouie en tressant des plumes qu'il avait collectées.\nEn réalité, je ne suis pas doué pour préparer des surprises. Pollux dit toujours que mon expression trahit mes intentions bien avant, et ce que je possède doit certainement vous sembler bien maigre et sans intérêt. Cependant, aujourd'hui, j'ai trouvé un moyen parfait pour partager ma joie avec vous.\nQuand vous entendrez trois coups frappés à votre fenêtre ce soir, ne soyez pas effrayé, ouvrez-la. Je vous emmènerai alors découvrir la caresse des nuages et du vent nocturne.\n\nCastor"
  },
  Mail_81326_Name = {
    Text = "Promenade nocturne..."
  },
  Mail_81326_Sender = {Text = "Castor"},
  Mail_84142_Desc = {
    Text = "Gardien : \n\nAvant le rassemblement, j'ai écrit cette lettre pour vous inviter officiellement et vous présenter ma « croisière d'anniversaire ». \nLa première étape de ce voyage est la Tamise. Nous monterons à bord d'un cargo transformé en restaurant mobile, tout en pagayant et en dégustant des morceaux d'ananas confits en conserve et du rhum. C'est une délicatesse réservée aux membres d'équipage pour leur anniversaire, j'espère que cela vous plaira. \nLa deuxième étape de ce voyage est le point de vue du port. Rassurez-vous, j'ai déjà demandé l'autorisation d'observation auprès de l'association des montgolfières. Lorsque la montgolfière s'élèvera dans les airs pour surplomber l'ensemble du canal de Londres, nous couperons ensemble le gâteau pour célébrer. \nAutrefois, les conditions de navigation étaient limitées, et le soi-disant gâteau d'anniversaire n'était qu'un modèle en chêne et caramel fabriqué par un charpentier, donc je ne connais pas le goût du gâteau. Cette fois, en le savourant avec vous, je pense qu'en plus de la beauté de la nourriture, je vais aussi en tirer bien plus. \nLa troisième étape, ou plutôt le troisième segment, est une carte des étoiles personnalisée. J'ai marqué la position des astres au moment de ma naissance sur la carte marine, et si cela ne vous dérange pas, j'aimerais y ajouter la vôtre. Cette carte nautique unique sera le cadeau le plus précieux à chérir. \nEn fait, en écrivant cette lettre, j'ai eu des hésitations. Ces actions dépassent sans aucun doute les limites ordinaires, mais aujourd'hui est un jour spécial, et vous êtes une personne spéciale pour moi, digne que je brise les conventions. \nAlors, je vous prie de ne pas refuser et de venir à l'heure. \n\nCorposant"
  },
  Mail_84142_Name = {
    Text = "Invitation à « Départ »"
  },
  Mail_84142_Sender = {Text = "Corposant"},
  Mail_84355_Desc = {
    Text = "Cher Gardien :\nL'événement « Dans la pluie battante » est terminé. Les devises d'événement « Drapeaux de signalisation » restantes seront échangées au taux de 40 « Billet Rose Dorée » par drapeau. Veuillez vérifier votre inventaire, Gardien."
  },
  Mail_84355_Name = {
    Text = "Récupération du drapeau de signalisation"
  },
  Mail_84355_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_84410_Desc = {
    Text = "Cher gardien, \n        Merci pour votre soutien envers [ Morimens ]. Afin d'améliorer l'expérience de jeu des gardiens au sein de l'Université de Misargh, nous vous invitons sincèrement à remplir le questionnaire d'expérience ci-dessous. En remerciement de votre coopération, nous vous offrons [Cœur d'argent*200] en récompense, à récupérer dès la fin du questionnaire. La date limite pour remplir le questionnaire est le 5 mai à 9h00, veuillez ne pas manquer le délai.\n       <SurveyLink:[Cliquez ici pour accéder au questionnaire]>\n       Nous écoutons attentivement chaque suggestion des gardiens, et vos retours contribueront certainement à faire de l'Université de Misargh un endroit toujours meilleur !\n       — Que la Clé d'argent guide votre chemin."
  },
  Mail_84410_Name = {
    Text = "Questionnaire de retour d'expérience V2.2.1"
  },
  Mail_84410_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_89744_Desc = {
    Text = "Cher Gardien des Secrets : \n Avec la mise à jour V2.2.2, nous avons amélioré les récompenses de « Don de liquide source - Fonds de don des anciens élèves ». Pour les Gardiens des Secrets ayant déjà récupéré toutes les récompenses supplémentaires avant la mise à jour, nous enverrons les récompenses correspondantes en compensation. Veuillez vérifier vos messages."
  },
  Mail_89744_Name = {
    Text = "V2.2.2 Compensation pour récompense de don d'argent primordiale"
  },
  Mail_89744_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_89902_Desc = {
    Text = "Cher gardien, \n        Merci pour votre soutien envers [ Morimens ]. Afin d'améliorer l'expérience de jeu des gardiens à l'Université de Misargh, nous vous invitons sincèrement à remplir le questionnaire d'expérience suivant. En remerciement de votre coopération, nous avons préparé [Cœur d'argent*200] comme récompense, que vous pourrez obtenir une fois le questionnaire rempli. La date limite pour remplir le questionnaire est le 27 mai à 9h00, veuillez donc le compléter à temps.\n       <SurveyLink:[Cliquez ici pour remplir]>\n       Nous écoutons attentivement chaque suggestion des gardiens, et vos retours contribueront certainement à rendre l'Université de Misargh de mieux en mieux !\n       — Que la Clé d'argent guide votre chemin."
  },
  Mail_89902_Name = {
    Text = "Questionnaire de retour d'expérience V2.2.1"
  },
  Mail_89902_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_89903_Desc = {
    Text = "Cher Gardien :\n        Merci pour votre soutien et votre reconnaissance envers «Avant l'Aube de l'Oubli». Afin d'offrir aux Gardiens du secret une meilleure expérience de jeu à l'Université de Misargh, nous vous invitons à remplir le questionnaire d'enquête sur l'expérience ci-dessous. En guise de remerciement pour votre coopération, nous avons préparé «Cœur d'argent» × 200 comme récompense, réclamable une fois le questionnaire complété. Le questionnaire se clôture le 9 novembre à 9h00, veuillez le remplir dans les délais.\n        <SurveyLink:[Cliquez ici pour remplir le questionnaire]>\n        Nous écouterons attentivement les suggestions de chaque Gardien, et vos retours contribueront certainement à améliorer l'Université de Misargh !\n        — Que la Clé d'Argent éclaire ton chemin."
  },
  Mail_89903_Name = {
    Text = "Questionnaire de retour d'expérience V2.6.2"
  },
  Mail_89903_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_89904_Desc = {
    Text = "Cher Gardien :\n        Merci pour votre soutien et votre reconnaissance envers « Veille de l'oubli ». Afin d'offrir une meilleure expérience de jeu aux gardiens à l'Université de Mizag, nous vous invitons à remplir le questionnaire d'expérience ci-dessous. En remerciement de votre coopération, nous avons préparé un « Cœur d'argent » × 200 en récompense, que vous pourrez recevoir après avoir complété le questionnaire. La date limite de soumission est le 23 février à 9h00, veuillez donc vous assurer de le remplir à temps.\n        <SurveyLink:[Cliquez ici pour remplir]>\n        Nous écouterons attentivement les suggestions de chaque Gardien, vos retours contribueront sans aucun doute à améliorer l'Université de Mizag !\n        —— Que la Clé d'Argent éclaire ton chemin."
  },
  Mail_89904_Name = {
    Text = "Questionnaire de retour d'expérience V2.4.2"
  },
  Mail_89904_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_89905_Desc = {
    Text = "Cher Gardien :\n        Merci pour votre soutien et votre reconnaissance envers [ La Nuit de l'Oubli ]. Afin d'améliorer l'expérience de jeu des Gardiens du secret à l'Université de Misargh, nous vous invitons sincèrement à remplir le questionnaire de satisfaction ci-dessous. En remerciement de votre participation, nous avons préparé Argent × 200 comme récompense. Vous pourrez les récupérer une fois le questionnaire rempli. La date limite pour répondre est le 8 juin à 9h00, veuillez ne pas manquer cette opportunité.\n        <SurveyLink:[Cliquez ici pour accéder au questionnaire]>\n        Nous écoutons attentivement chaque suggestion des Gardiens du secret. Vos retours contribueront certainement à rendre l'Université de Misargh de plus en plus performante !\n        — Que la Clé d'Argent éclaire ton chemin."
  },
  Mail_89905_Name = {
    Text = "Questionnaire de retour d'expérience V2.5.1"
  },
  Mail_89905_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_89906_Desc = {
    Text = "Cher Gardien :\n        Merci pour votre soutien et votre reconnaissance envers [ La Nuit de l'Oubli ]. Afin d'améliorer l'expérience de jeu des Gardiens du secret à l'Université de Misargh, nous vous invitons sincèrement à remplir le questionnaire d'expérience suivant. En remerciement de votre coopération, nous avons préparé [Argent*200] comme récompense. Vous pourrez les récupérer une fois le questionnaire rempli. La date limite pour répondre est le 22 décembre à 9h00. Veuillez ne pas manquer ce délai.\n        <SurveyLink:[Cliquez ici pour remplir]>\n        Nous écoutons attentivement chaque suggestion des Gardiens du secret. Vos retours contribueront certainement à rendre l'Université de Misargh de plus en plus excellente !\n        — Que la Clé d'Argent éclaire ton chemin."
  },
  Mail_89906_Name = {
    Text = "Questionnaire de retour d'expérience V2.4.0"
  },
  Mail_89906_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_89907_Desc = {
    Text = "Cher Gardien :\n        Merci pour votre soutien et votre reconnaissance envers [ La Nuit de l'Oubli ]. Afin d'améliorer l'expérience de jeu des Gardiens du secret au sein de l'Université de Misargh, nous vous invitons sincèrement à remplir le questionnaire d'expérience ci-dessous. En remerciement de votre coopération, nous avons préparé [Argent*200] en récompense, que vous pourrez récupérer une fois le questionnaire rempli. La date limite pour répondre est le 19 janvier à 9h00, veuillez ne pas manquer ce délai.\n        <SurveyLink:[Cliquez ici pour remplir]>\n        Nous écoutons attentivement chaque suggestion des Gardiens du secret, et vos retours contribueront certainement à rendre l'Université de Misargh de plus en plus excellente !\n        — Que la Clé d'Argent éclaire ton chemin."
  },
  Mail_89907_Name = {
    Text = "Questionnaire de retour d'expérience V2.4.1"
  },
  Mail_89907_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_89908_Desc = {
    Text = "Cher Gardien : \n        Merci pour votre soutien et votre reconnaissance envers [ La Nuit de l'Oubli ]. Afin d'améliorer l'expérience de jeu des Gardiens du secret à l'Université de Misargh, nous vous invitons sincèrement à remplir le questionnaire d'expérience suivant. En remerciement de votre coopération, nous avons préparé Argent × 200 comme récompense, que vous pourrez obtenir après avoir rempli le questionnaire. La date limite pour remplir le questionnaire est le 20 juillet à 9h00, veuillez donc le remplir à temps. \n        <SurveyLink:[Cliquez ici pour accéder au questionnaire]>\n        Nous écoutons attentivement chaque suggestion des Gardiens du secret, et vos retours contribueront certainement à rendre l'Université de Misargh de mieux en mieux ! \n        — Que la Clé d'Argent éclaire ton chemin."
  },
  Mail_89908_Name = {
    Text = "Questionnaire de retour d'expérience V2.5.2"
  },
  Mail_89908_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_89909_Desc = {
    Text = "Cher Gardien :\n        Merci pour votre soutien et votre reconnaissance envers [ La Nuit de l'Oubli ]. Afin d'améliorer l'expérience de jeu des Gardiens du secret au sein de l'Université de Misargh, nous vous invitons sincèrement à remplir le questionnaire d'évaluation ci-dessous. En remerciement de votre participation, nous avons préparé Argent × 200 en guise de récompense. Vous pourrez les récupérer dès la fin du questionnaire. La date limite pour remplir le questionnaire est le 14 septembre à 09:00, veuillez donc le compléter à temps.\n        <SurveyLink:[Cliquez ici pour accéder au questionnaire]>\n        Nous écoutons attentivement chaque suggestion des Gardiens du secret. Vos retours contribueront certainement à rendre l'Université de Misargh de plus en plus excellente !\n        — Que la Clé d'Argent éclaire ton chemin."
  },
  Mail_89909_Name = {
    Text = "Questionnaire de retour d'expérience V2.6.0"
  },
  Mail_89909_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_89910_Desc = {
    Text = "Cher Gardien, \n Merci pour votre soutien envers [ La Nuit de l'Oubli ]. Afin d'améliorer l'expérience de jeu des Gardiens du secret à l'Université de Misargh, nous vous invitons sincèrement à remplir le questionnaire d'expérience suivant. En remerciement de votre coopération, nous avons préparé [Argent*200] en récompense, que vous pourrez recevoir dès la fin du questionnaire. La date limite pour remplir le questionnaire est le 23 juin à 9h00. Veuillez ne pas manquer ce délai.\n       <SurveyLink:[Cliquez ici pour remplir]>\n       Nous écoutons attentivement chaque suggestion des Gardiens du secret, et vos retours contribueront certainement à rendre l'Université de Misargh de meilleure en meilleure !\n       — Que la Clé d'Argent éclaire ton chemin."
  },
  Mail_89910_Name = {
    Text = "Questionnaire de retour d'expérience V2.2.2"
  },
  Mail_89910_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_89911_Desc = {
    Text = "Cher Gardien, \n        Merci pour votre soutien envers [ La Nuit de l'Oubli ]. Afin d'améliorer l'expérience de jeu des Gardiens du secret à l'Université de Misargh, nous vous invitons cordialement à remplir le questionnaire d'évaluation ci-dessous. En remerciement de votre participation, nous avons préparé [Argent*200] comme récompense. Vous pourrez récupérer cette récompense dès que vous aurez rempli le questionnaire. La date limite pour répondre est le 8 septembre à 9h00, veuillez donc vous assurer de le remplir à temps.\n        <SurveyLink:[Cliquez ici pour accéder au questionnaire]>\n        Nous écoutons attentivement chaque suggestion des Gardiens du secret. Vos retours contribueront certainement à rendre l'Université de Misargh toujours meilleure !\n        —— Que la Clé d'Argent éclaire ton chemin."
  },
  Mail_89911_Name = {
    Text = "Questionnaire de retour d'expérience V2.3.1"
  },
  Mail_89911_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_89912_Desc = {
    Text = "Cher Gardien, \n        Merci pour votre soutien envers [ La Nuit de l'Oubli ]. Afin de vous offrir une meilleure expérience de jeu au sein de l'Université de Misargh, nous vous invitons sincèrement à remplir le questionnaire d'évaluation ci-dessous. En remerciement de votre participation, nous avons préparé [Argent*200] comme récompense, que vous pourrez récupérer dès la fin du questionnaire. La date limite pour répondre est le 11 août à 09:00, veuillez ne pas manquer le délai.\n        <SurveyLink:[Cliquez ici pour remplir le questionnaire]>\n        Nous écoutons attentivement chaque suggestion des Gardiens du secret, et vos retours contribueront certainement à rendre l'Université de Misargh de plus en plus excellente !\n        —— Que la Clé d'Argent éclaire ton chemin."
  },
  Mail_89912_Name = {
    Text = "Questionnaire de retour d'expérience V2.3.0"
  },
  Mail_89912_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_89913_Desc = {
    Text = "Cher Gardien, \nMerci pour votre soutien envers [ La Nuit de l'Oubli ]. Afin d'améliorer l'expérience de jeu des Gardiens du secret au sein de l'Université de Misargh, nous vous invitons sincèrement à remplir le questionnaire d'évaluation ci-dessous. En remerciement de votre coopération, nous avons préparé [Argent*200] en récompense, que vous pourrez récupérer dès la fin du questionnaire. La date limite pour répondre est le 29 septembre à 9h00, veuillez ne pas manquer le délai.\n<SurveyLink:[Cliquez ici pour accéder au questionnaire]>\nNous écoutons attentivement chaque suggestion des Gardiens du secret. Vos retours contribueront certainement à rendre l'Université de Misargh de plus en plus excellente !\n—— Que la Clé d'Argent éclaire ton chemin."
  },
  Mail_89913_Name = {
    Text = "Questionnaire de retour d'expérience V2.3.2"
  },
  Mail_89913_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_89914_Desc = {
    Text = "Cher Gardien : \n        Merci pour votre soutien et votre reconnaissance envers [ La Nuit de l'Oubli ]. Afin d'améliorer l'expérience de jeu des Gardiens du secret à l'Université de Misargh, nous vous invitons sincèrement à remplir le questionnaire d'évaluation ci-dessous. En remerciement de votre coopération, nous avons préparé Argent × 200 comme récompense, que vous pourrez récupérer dès que le questionnaire sera terminé. La date limite pour remplir le questionnaire est le 11 mai à 09:00, veuillez donc le remplir avant cette date.\n        <SurveyLink:[Cliquez ici pour remplir]>\n        Nous écoutons attentivement les suggestions de chaque Gardien, et vos retours contribueront certainement à rendre l'Université de Misargh de plus en plus meilleure !\n        — Que la Clé d'Argent éclaire ton chemin."
  },
  Mail_89914_Name = {
    Text = "Questionnaire de retour d'expérience V2.5.0"
  },
  Mail_89914_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_89915_Desc = {
    Text = "Cher Gardien :\n        Merci pour votre soutien et votre reconnaissance envers « La Nuit de l'Oubli ». Afin d'améliorer l'expérience de jeu des Gardiens du secret au sein de l'Université de Misargh, nous vous invitons sincèrement à remplir le questionnaire d'expérience suivant. En remerciement de votre participation, nous avons préparé « Argent » × 200 en récompense, que vous pourrez obtenir dès la fin du questionnaire. La date limite pour remplir le questionnaire est le 12 octobre à 9h00, veuillez donc le compléter à temps.\n        <SurveyLink:[Cliquez ici pour remplir]>\n        Nous écoutons attentivement chaque suggestion des Gardiens du secret. Vos retours contribueront certainement à rendre l'Université de Misargh de plus en plus excellente !\n        — Que la Clé d'Argent éclaire ton chemin."
  },
  Mail_89915_Name = {
    Text = "Questionnaire de retour d'expérience V2.6.1"
  },
  Mail_89915_Sender = {
    Text = "Bureau des Affaires de Mythag"
  },
  Mail_89997_Desc = {
    Text = "Cher gardien,\nL'événement « Un demi-pas de distance·clon » est terminé. Les « Pièces de poupée » restantes seront converties en « Billet Rose Dorée*40 » pour chaque unité. Veuillez vérifier."
  },
  Mail_89997_Name = {
    Text = "Récupération des pièces de poupée"
  },
  Mail_89997_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_90000_Desc = {
    Text = "Cher gardien :\nSelon vos excellentes performances dans « L'ombre convoitant le Royaume divin : marées inhabituelles », vous recevrez les récompenses suivantes. Veuillez vérifier."
  },
  Mail_90000_Name = {
    Text = "Compensation pour récompense de jeton de personnalisation « Illusion minimaliste »"
  },
  Mail_90000_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_90015_Desc = {
    Text = "Cher gardien,\nL'événement du 1,5e anniversaire est terminé. Les « Voucher de Tenue Fantastique Simple (phase 1) » restants seront échangés contre « Invitation de l'Incorporel*1 » pour chaque unité. Veuillez vérifier."
  },
  Mail_90015_Name = {
    Text = "Récupération du bon d'apparence simplifiée (phase 1)"
  },
  Mail_90015_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_90231_Desc = {
    Text = "Cher gardien,\nL'événement « Prisonnier du Mirroir » est terminé. Les « Livre de sens commun », « Livre de mathématiques » et « Livre de littérature » restants seront échangés contre « Billet Rose Dorée*40 » par unité. Veuillez vérifier."
  },
  Mail_90231_Name = {
    Text = "Récupération de la monnaie du prisonnier miroir"
  },
  Mail_90231_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_91725_Desc = {
    Text = "Cher gardien du secret :\nL'événement « Cérémonie des Profondeurs·clon » est terminé. Les « Larmes du Sacrificateur », « Sang du sacrificateur » et « Moelle du sacrificateur » restants seront échangés au taux de « Billet Rose Dorée » × 40 par unité. Veuillez vérifier."
  },
  Mail_91725_Name = {
    Text = "Récupération de la monnaie des activités du sacrifice abyssal"
  },
  Mail_91725_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_94424_Desc = {
    Text = "Cher gardien du secret :\nL'événement « La Grande Conquête » est terminé. Les « Délicieux barbecue de Léon » restants seront échangés contre « Billet Rose Dorée » × 40 pour chaque unité. Veuillez noter."
  },
  Mail_94424_Name = {
    Text = "Récupération de la monnaie du rôti de Léo"
  },
  Mail_94424_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_94425_Desc = {
    Text = "Cher gardien,\nL'événement « Grande Conquête » est terminé. Les « Voucher de Conception d'habit Fantastique Minimaliste (2e édition) » restants seront échangés contre « Invitation de l'Incorporel*1 » pour chaque unité. Veuillez vérifier."
  },
  Mail_94425_Name = {
    Text = "Récupération du bon d'échange pour tenue d'illusion simplifiée (phase 2)"
  },
  Mail_94425_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_94503_Desc = {
    Text = "Ma lumière :  \n\nDepuis que Castor et moi sommes arrivés ici, votre sollicitude à notre égard nous a presque redonné une nouvelle vie. Merci pour le gâteau d'anniversaire que vous nous avez préparé. Je tiens à m'excuser sincèrement d'avoir confondu les deux petits oiseaux que vous avez dessinés sur le gâteau avec des papillons, mais nous apprécions vraiment ce cadeau. C'est même la première fois que nous recevons un cadeau d'anniversaire de la part de quelqu'un d'autre.  \nNous avons également reçu une carte de vœux de l'école, envoyée par le Doyen Khôlert. Sur l'enveloppe blanche était apposé un sceau doré et luxueux, et à l'intérieur se trouvaient des messages pleins de bienveillance. C'est vraiment un endroit chaleureux, et jamais, dans toute notre vie, nous n'avons connu un moment aussi heureux qu'aujourd'hui.  \nVenez donc célébrer notre anniversaire avec Castor et moi. C'est une tradition que nous avons toujours respectée depuis notre enfance. Et en tant que nos bienfaiteurs, nous vous avons également préparé un cadeau en échange : une couronne tressée avec les plumes que Castor a perdues.  \nJe vous offre humblement cette couronne grossièrement confectionnée, afin d'exprimer un peu notre profonde admiration. Je souhaite passer le reste de ma vie à vos côtés, poursuivant la grande vision de cette école, et éliminant le véritable mal et les ténèbres.  \nÇa fait longtemps que je n'avais plus fait ce genre de chose, et Castor a même plaisanté en disant que mon habileté n'était plus aussi bonne qu'autrefois. J'espère que vous ne la trouverez pas déplaisante.  \n\nPollux"
  },
  Mail_94503_Name = {
    Text = "Couronne de Plumes..."
  },
  Mail_94503_Sender = {Text = "Pollux"},
  Mail_95382_Desc = {
    Text = "Petit mignon : \n\nPetit, aujourd'hui est le jour de ma venue. \nNon pas en tant que boule de feu ardente, mais comme l'anniversaire de cette fille appelée Katigura. \nSelon les coutumes de ma vie passée, nous organiserons un grand banquet ce jour-là, profitant de bons vins et de viandes grillées. \nBien sûr, il y aura toujours des petits malins qui, sans tenir compte de l'ambiance, se moqueront de moi en disant que j'ai un an de plus, alors je leur ai salué avec mon poing. \nEt maintenant, ce banquet a une nouvelle fonction, pour nous permettre de nous remémorer les temps passés. \nCette année, je prévois d'ajouter une activité, à savoir - chasser notre petit ! \nSais-tu quoi ? J'ai hâte de te capturer pour mon banquet, avec ton adorable expression timide, ton regard flou à moitié ivre, et le parfum sucré qui émane de toi pour décorer mon anniversaire cette année, ce sera le meilleur cadeau d'anniversaire que j'ai jamais reçu depuis ma naissance ! \nIl est trop tard pour préparer un plan d'évasion maintenant, car quand tu liras cette lettre... je suis déjà devant ta porte. \nN'aie pas peur, petit, si tout se passe bien, tu n'entendras ici que les meilleures histoires et goûteras les plats les plus délicieux. \nBien sûr, il est normal qu'un petit animal capturé ait quelques accidents, n'est-ce pas ? \nViens avec moi, petit, ta belle soirée est destinée à être passée avec moi. \n\nKatigura"
  },
  Mail_95382_Name = {
    Text = "La Fête du Temps..."
  },
  Mail_95382_Sender = {Text = "Kadigula"},
  Mail_95465_Desc = {
    Text = "Cher gardien du secret :\nL'événement « Manuel du Détective·clon » est terminé. Nous allons convertir les « Jetons décisifs » restants du gardien selon un taux de « Billet Rose Dorée » × 40 par unité. Veuillez vérifier."
  },
  Mail_95465_Name = {
    Text = "Récupération de Chip"
  },
  Mail_95465_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_95875_Desc = {
    Text = "Cher gardien :\nL'événement « Esthétique nécrotique » est terminé. Les « Ossements pourris de la main » restants seront échangés contre « Billet Rose Dorée*40 » pour chaque unité. Veuillez vérifier."
  },
  Mail_95875_Name = {
    Text = "Récupération d'os de main corrompue"
  },
  Mail_95875_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_96012_Desc = {
    Text = "Cher gardien du secret :\nL'événement « La Chute des Mille Soleils » est terminé. Les objets d'événement restants seront échangés contre « Billet Rose Dorée*40 » pour chaque unité. Veuillez vérifier."
  },
  Mail_96012_Name = {
    Text = "Récupération de balles"
  },
  Mail_96012_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_96323_Desc = {
    Text = "Monsieur/Madame Gardien du Secret : \n\nCélébrer un anniversaire en tant que vivant, c'est pour recueillir un sens dans le temps qui reste. Et moi, je ne fais que profiter de cette nuit pour intensifier le parfum de la mort. \nCes défunts qui ne luttent plus, qui n'ont plus d'obsessions, ont vu toute leur souillure lavée. Leurs regrets, tels de fins sels, se fondent entre les lignes de sang au moment où la cuisson est parfaite, formant une fragrance humide et docile. Leurs os émettent de légers craquements, la graisse qui suinte de leur peau est délicate comme de la menthe, tandis que les paroles inachevées au fond de leur âme s'échappent lentement lors de la cuisson, laissant une douce douceur subtile. J'ai déjà commencé à imaginer à quoi tu ressemblerais en tant qu'objet paisible — le craquement de ta peau se tendant devant le feu, les émotions s'élevant entre tes chair et os, la douceur de ton âme pure progressivement avalée... \nMais tu es différent. \nTu brilles encore, tu palpites encore, mais tu as un parfum que nul autre défunt ne peut égaler, enivrant et captivant. Tu es la maturité que je suis prêt à attendre, et j'espère même que cette attente puisse durer plus longtemps que l'éternité. \nDans ces innombrables anneaux répétitifs, ta présence donne un sens à mon anniversaire. Ce n'est plus seulement pour un repas délicieux, mais aussi pour la vie qui bat encore en toi. \n\nDoresain"
  },
  Mail_96323_Name = {
    Text = "Attente éternelle..."
  },
  Mail_96323_Sender = {Text = "Dulcain"},
  Mail_97157_Desc = {
    Text = "Cher gardien du secret :\nL'événement « Texte temporaire » est terminé. Les « Teinture du réel », « Teinture des rêves » et « Teinture de folie » restants seront échangés contre « Billet Rose Dorée » × 40 pour chaque unité. Veuillez vérifier."
  },
  Mail_97157_Name = {
    Text = "Récupération de Teinture"
  },
  Mail_97157_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_97707_Desc = {
    Text = "Cher gardien du secret :\nL'événement « Cérémonie de la Naissance Divine » est terminé. Les « Aromathérapie apaisante », « Diffuseur de cauchemar » et « Aromathérapie d'Attrape-rêves » restants seront échangés contre « Billet Rose Dorée*40 » pour chaque unité. Veuillez vérifier."
  },
  Mail_97707_Name = {
    Text = "Récupération de parfum"
  },
  Mail_97707_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_97893_Desc = {
    Text = "Cher gardien :\nL'événement « Si tout est normal » est terminé. Les « Coquillages de spécialité côtière » restants seront convertis en « Billet Rose Dorée*40 » pour chaque unité. Veuillez vérifier."
  },
  Mail_97893_Name = {
    Text = "Recyclage de coquillages spécialisés en bord de mer"
  },
  Mail_97893_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_97999_Desc = {
    Text = "Cher Gardien :\nL'événement « Pas de bonbons, pas de paix ! » est terminé. Les « Bonbons au potiron au goût étrange » restants seront échangés contre « Élixir de Cœur d'argent*60 » pour chaque unité. Veuillez vérifier vos récompenses, Gardien."
  },
  Mail_97999_Name = {
    Text = "Récupération de bonbons au potiron au goût étrange"
  },
  Mail_97999_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_98052_Desc = {
    Text = "Cher gardien :\nL'événement « Porte des Mille Phénomènes·clon » est terminé. Nous allons récupérer les « Pointeur final » restants du gardien selon un taux de « Billet Rose Dorée*40 » par unité. Veuillez vérifier."
  },
  Mail_98052_Name = {
    Text = "Recyclage de l'Indicateur de Fi"
  },
  Mail_98052_Sender = {
    Text = "Conseil de l'Université Missaga"
  },
  Mail_98182_Desc = {
    Text = "Cher gardien :\nDans la mise à jour V2.3.1, nous avons procédé à la récupération uniforme des Particules de Résonance excédentaires. Ces particules seront récupérées et converties au taux de « Billet Rose Dorée*5000 » par unité. Veuillez vérifier."
  },
  Mail_98182_Name = {
    Text = "Compensation pour la récompense de récupération excédentaire des particules de résonance V2.3.1"
  },
  Mail_98182_Sender = {
    Text = "Bureau des Affaires de Mythag"
  }
})
return Text_Mail
