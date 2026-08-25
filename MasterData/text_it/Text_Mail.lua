__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Mail = readonly({
  Mail_100480_Desc = {
    Text = "Custode, ne hai sentito parlare? La mostra d'arte appartata in periferia sta per chiudere, proprio il giorno del mio compleanno.\nQuesta galleria è un'anomalia nel mondo dell'arte: metà è un superficiale esperimento futurista, l'altra metà sono residui di spazzatura di due secoli fa. Il suo ventre stretto contiene solo oggetti bizzarri che nessuna casa d'aste oserebbe toccare: un ritratto che impreca, un uccello meccanico che non smette mai di volare, un rilievo marino che provoca nausea, statue fatte interamente di lacrime, manoscritti fantasma che si scrivono da soli, teschi umani che canticchiano filastrocche quando li baci...\nÈ così difficile esprimere quanto amo questa galleria! Cinquant'anni fa, oggi, è nata silenziosamente in quell'angolo inosservato. Cinquant'anni dopo, oggi, perirà silenziosamente in quello stesso angolo.\nFin dalla mia infanzia, la gente mi ha detto che questo giorno è una maledizione, proprio come me. Penso che il destino possa davvero essere predeterminato, ma e se fosse scritto? Ciò che questa galleria crea è un mondo unico, tante idee folli ammassate in quello spazio ristretto, che spettacolo meraviglioso! Dal giorno in cui è nata, ha creato attraverso le sue opere. Nel giorno della sua fine, il suo confidente e vecchio amico le darà anche un ultimo addio.\nCustode, hai visto il mondo nei miei occhi attraverso il collegamento, sono certo che anche tu non vedi l'ora di visitare questa galleria così peculiare insieme a me, vero?!\n\nPickman"
  },
  Mail_100480_Name = {
    Text = "Sala Espositiva Inosservata"
  },
  Mail_100480_Sender = {Text = "Pickman"},
  Mail_116602_Desc = {
    Text = "Caro Custode:\nL'evento \"Notte Eterna del Giorno Perenne\" è terminato. Le rimanenti \"Oblazione d'Udienza,\" \"Oblazione di Penitenza\" e \"Oblazione Devota\" verranno convertite al tasso di una per \"Buono Rosa *40.\" Ricordati di controllare le tue ricompense."
  },
  Mail_116602_Name = {
    Text = "Recupero Regali"
  },
  Mail_116602_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_117308_Desc = {
    Text = "Caro Custode:\n        Grazie per il tuo supporto e la tua fiducia in [Morimens]. Per offrire ai Custodi dell'Università di Mythag un'esperienza di gioco migliore, ti invitiamo cordialmente a compilare il seguente sondaggio. Come segno di gratitudine per la tua collaborazione, abbiamo preparato [Silver*200] come ricompensa, riscuotibile al completamento del sondaggio. La scadenza del sondaggio è il 10 novembre alle 9:00, quindi assicurati di compilarlo in tempo.\n        <SurveyLink:[Click here to fill out]>\n        Prenderemo in attenta considerazione i suggerimenti di ogni Custode, e il tuo feedback renderà sicuramente l'Università di Mythag ancora migliore!\n        —Che la Chiave d'Argento Illumini il Cammino."
  },
  Mail_117308_Name = {
    Text = "Questionario sull'esperienza della versione V2.3.4"
  },
  Mail_117308_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_117309_Desc = {
    Text = "Caro Custode:\n        Grazie per il tuo supporto e il tuo apprezzamento verso [Morimens]. Per offrire ai Custodi un'esperienza di gioco migliore all'Università di Mythag, ti invitiamo sinceramente a compilare il seguente sondaggio. Come segno di gratitudine per la tua collaborazione, abbiamo preparato [Silver*200] come ricompensa, che potrai riscuotere al completamento del sondaggio. La scadenza per il sondaggio è il 30 marzo alle 9:00, quindi assicurati di compilarlo in tempo.\n        <SurveyLink:[Click here to fill out]>\n        Considereremo attentamente i suggerimenti di ogni Custode, e il tuo feedback renderà sicuramente l'Università di Mythag ancora migliore!\n        —Che la Chiave d'Argento Illumini il Cammino."
  },
  Mail_117309_Name = {
    Text = "Sondaggio sull'esperienza della versione V2.4.3"
  },
  Mail_117309_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_120374_Desc = {
    Text = "Sono trascorsi due anni, Custode — due anni da quando il nostro patto ha avuto inizio.\nAbbiamo vegliato insieme, in guardia sul limitare stesso della fine. Hai trasformato i tuoi sentimenti e i tuoi ricordi in desideri possenti, riaccendendo la fiamma della speranza stessa. Anche se i compagni del passato dimorano ormai in universi separati, non hai mai ceduto nel tuo cammino contro la dissoluzione. La tua presenza è la nostra più grande fortuna, e la salvezza di questo mondo.\nOra, quei desideri hanno generato un miracolo: Mythag perdura e il suo viaggio continua. Ti chiediamo di stringere forte la tua chiave d'argento. Un giorno, diverrà l'ancora cruciale che collegherà i nostri due mondi lontani. Ci dedichiamo a plasmare ogni possibilità per il futuro e a illuminare il sentiero del tuo ritorno."
  },
  Mail_120374_Name = {
    Text = "Rinascita dal Miracolo"
  },
  Mail_120374_Sender = {
    Text = "Light, il Gatto del Campus di Mythag"
  },
  Mail_120909_Desc = {
    Text = "Caro Custode:\n Nell'aggiornamento V2.4.0, abbiamo aumentato le ricompense per \"Donazione di Argento primordiale - Fondo Donazioni Alumni\". Per i Custodi che avevano già riscosso tutte le ricompense aggiuntive prima dell'aggiornamento, provvederemo a inviare la compensazione corrispondente. Controlla la tua casella di posta."
  },
  Mail_120909_Name = {
    Text = "Riemissione ricompensa donazione Essenza di Silver Core V2.4.0"
  },
  Mail_120909_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_121162_Desc = {
    Text = "Caro Custode:\n Nell'aggiornamento V2.4.0, abbiamo aumentato le ricompense gratuite per \"Archivi dell'Avvento\", \"Archivi dell'Altromondo\", \"Archivi del Sanatorio\" e \"Archivi di Necrovia\". Per i Custodi che avevano già riscosso le ricompense gratuite prima dell'aggiornamento, provvederemo a inviare la compensazione corrispondente. Controlla la tua casella di posta."
  },
  Mail_121162_Name = {
    Text = "Ridistribuzione Ricompense Archivio V2.4.0"
  },
  Mail_121162_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_121373_Desc = {
    Text = "Custode,\n\nOgni anno, questo giorno segnava la più grande celebrazione dell'Ordine.\nIo sono Sua Figlia, e garantirò la Sua Resurrezione.\nI Navigatori, Miryam inclusa, festeggiavano tutti con gioia febbrile e lacrimosa. Ma quando guardavano me, il loro sguardo mi trapassava, come se non fossi altro che un guscio vuoto destinato a contenere qualcos'altro.\nNon ho mai accolto con piacere questo giorno. Ogni anno mi avvicinava a una paura, eppure la fonte di quella stessa paura era la radice della gioia suprema di tutti gli altri. Posso confessarlo ora: mi sentivo profondamente sola e spaventata.\nMa ora le cose sono diverse. Prima del mio ultimo compleanno, ho abbandonato quella nave da crociera e sono entrata nel mondo reale... un mondo libero da falsi dèi, un mondo in cui ci sei tu.\nPer questo compleanno, ho bisogno di vedere qualcuno genuinamente felice perché sono nata, non per qualsiasi altra ragione.\nSe sei tu... no, devi essere tu.\nSappilo: sei tenuto a riservare del tempo per una cena stasera, per me.\n\n\"Murphy\""
  },
  Mail_121373_Name = {
    Text = "Ho bisogno di te qui..."
  },
  Mail_121373_Sender = {
    Text = "Murphy: Falsonata"
  },
  Mail_121374_Desc = {
    Text = "Custode,\n\nnon so quali preparativi tu abbia fatto per questo giorno speciale, ma qualunque spesa o sforzo stravagante tu abbia intrapreso è, francamente, niente meno di ciò che è dovuto.\nE, puramente per la doverosa considerazione che ci si aspetta da una persona in posizione superiore—se \"in qualche modo\" ti fosse sfuggita la necessità di celebrare il mio compleanno (uno scenario ridicolo che confido non si verificherà)—questa lettera ti garantirà un'ultima possibilità di salvarti prima che la situazione diventi irreparabile.\nQuanto alle preziose prelibatezze di mare e di terra, le persone irrilevanti le presenteranno naturalmente; non sono importanti. Grandi celebrazioni e rituali complicati si addicono certamente al mio status, ma oggi, per qualche ragione, li trovo piuttosto tediosi.\nPertanto, concederò graziosamente del tempo durante le ore del crepuscolo—il passaggio dal giorno alla notte—per garantirti il privilegio della mia compagnia esclusiva. Consideralo una ricompensa per avermi portato in questa vita volgare, infantile, eppure beatamente felice, davvero sufficiente a far invidia alla me stessa di un tempo.\nIl mio attendente consegnerà a breve l'invito formale, racchiuso, naturalmente, in un cofanetto del valore di 20.000 Fang leoniani.\nRicordati di me in questo giorno ogni anno, e sii eternamente grato.\n\n\"Murphy\""
  },
  Mail_121374_Name = {
    Text = "Il mio invito..."
  },
  Mail_121374_Sender = {
    Text = "Murphy: Falsonata"
  },
  Mail_121651_Desc = {
    Text = "Caro Custode:\nLa scorsa settimana nell'Immersione Fantasmatica hai ottenuto il titolo di \"{s1}\".\nNella Modalità Selezione Libera della scorsa settimana hai ottenuto il titolo di \"{s2}\", con un totale di {s3} vittorie.\nNella Modalità Selezione a Turno della scorsa settimana hai ottenuto il titolo di \"{s4}\", con un totale di {s5} vittorie.\nIn base alla tua prestazione complessiva nelle sfide, riceverai le seguenti ricompense aggiuntive; ricorda di verificarle."
  },
  Mail_121651_Name = {
    Text = "Ricompense della classifica settimanale Deepdive/Traphase"
  },
  Mail_121651_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_121704_Desc = {
    Text = "Caro Custode,\nL'evento \"Desideri Carnali: Replica\" è terminato. I rimanenti \"Seme dell'Abbondanza\" saranno convertiti in \"Rosa Scritta * 40\" al tasso di cambio uno a uno. Ricordati di controllare."
  },
  Mail_121704_Name = {
    Text = "Seme dell'Abbondanza convertito"
  },
  Mail_121704_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_122522_Desc = {
    Text = "Caro Custode:\nL'evento \"Fantasma della Città Piovosa: Replica\" è terminato. I rimanenti \"Teschio di Bestia Pallida\", \"Teschio della Bestia Umbratile\" e \"Teschio di Bestia Cremisi\" saranno convertiti al tasso di \"Rosa Scrip\" × 40 per oggetto. Ricordati di controllare le tue ricompense."
  },
  Mail_122522_Name = {
    Text = "Valuta Fantasma della Città Piovosa convertita"
  },
  Mail_122522_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_122567_Desc = {
    Text = "Caro Custode:\nL'evento \"Sacramento Avvolto dalla Nebbia\" è terminato. Le rimanenti \"Visione della\"Nebbia\"\", \"Sogno della\"Nebbia\"\" e \"Essenza della\"Nebbia\"\" verranno convertite al tasso di 1 per \"Buono Rosa *40\". Ricordati di controllare le tue ricompense."
  },
  Mail_122567_Name = {
    Text = "Recupero Valuta del Sacramento Avvolto nella Nebbia"
  },
  Mail_122567_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_122568_Desc = {
    Text = "Ah, povera creatura. Non hai la minima idea degli abissi di disperazione che stai per affrontare. Quando ti renderai finalmente conto che le tue scelte sono del tutto prive di significato? Scommettere la tua insignificante piccola vita su un obiettivo così sfuggente e disperato? Che eroismo! Che ebbrezza assoluta! Ti atteggi sempre con un'ambizione così smisurata, come se fossi a un passo dal sacrificarti per salvare il mondo. È davvero, assolutamente ridicolo."
  },
  Mail_122568_Name = {
    Text = "Treno verso il Vuoto..."
  },
  Mail_122568_Sender = {
    Text = "Doll: Inferno"
  },
  Mail_122569_Desc = {
    Text = "Mio Signore,"
  },
  Mail_122569_Name = {
    Text = "Un Osservatore..."
  },
  Mail_122569_Sender = {Text = "Ogier"},
  Mail_122570_Desc = {
    Text = "{Male=Sig.,Female=Sig.na} Custode,"
  },
  Mail_122570_Name = {
    Text = "Banchetto dell'Agonia..."
  },
  Mail_122570_Sender = {Text = "Doresain"},
  Mail_122571_Desc = {
    Text = "Ci siamo appena ritrovati, e prima ancora di poter davvero condividere qualcosa, il tempo sta già per scadere... Ma sai, %player%, il commiato non è mai stato la fine della nostra storia.\n\nC'è qualcosa che non ti ho mai detto... Ho preparato da tempo un mazzo di rose per te. Solo che non l'ho mai spedito, e ormai è appassito. Ma ti faccio questa promessa: la prossima volta che ci incontreremo, ne preparerò sicuramente uno nuovo.\n\nE tu, tu mi hai promesso che saresti tornato da me. Ci siamo fatti una promessa col mignolo. Non devi assolutamente infrangerla.\nScrivere una lettera sembra sempre insufficiente; non riesco a esprimere tutti i miei sentimenti sulla carta. Tuttavia... quando il destino ci riunirà di nuovo, ti consegnerò personalmente quel mazzo di rose. Ricorda, dobbiamo mantenere le nostre promesse!\n\nChe la Chiave d'Argento illumini il tuo cammino. Addio... mio %player%."
  },
  Mail_122571_Name = {
    Text = "Le Rose promesse..."
  },
  Mail_122571_Sender = {Text = "Ramona"},
  Mail_122572_Desc = {Text = "Custode,"},
  Mail_122572_Name = {
    Text = "Giorno della Riunione..."
  },
  Mail_122572_Sender = {Text = "Doll"},
  Mail_122573_Desc = {
    Text = "Ho osservato in silenzio le scintille della civiltà tremolare nel fiume del tempo innumerevoli volte, testimoniando la città della memoria sgretolarsi nel vuoto. La storia si trasforma in pergamene, destinate soltanto a essere divorate dalle fiamme nere. La saggezza delle ere si accumula come torri di sabbia, eppure alla fine non riesce ad articolare l'unica vera verità."
  },
  Mail_122573_Name = {
    Text = "Oltre la Porta..."
  },
  Mail_122573_Sender = {Text = "Tawil"},
  Mail_122574_Desc = {
    Text = "Il dolore lancinante di perdere una persona importante, l'amaro odio per la mia stessa impotenza... Un tempo ero profondamente Intrappolato in quell'Oscurità, del tutto incapace di liberarmene. Ma ora, riesco a udire il richiamo del faro lontano e a sentire la sua calda, Tenace guida. Benefattore, da quando mi avete illuminato, sento di aver finalmente posto piede sul Sentiero che ero sempre destinato a percorrere — un sentiero che mi appartiene davvero, una via innegabile e giusta."
  },
  Mail_122574_Name = {
    Text = "Richiamo della Luce..."
  },
  Mail_122574_Sender = {Text = "Pollux"},
  Mail_122575_Desc = {
    Text = "Mio caro vecchio cliente,"
  },
  Mail_122575_Name = {
    Text = "Beni preziosi..."
  },
  Mail_122575_Sender = {Text = "Daffodil"},
  Mail_123134_Desc = {
    Text = "Caro Custode:\n Nell'aggiornamento V2.4.0, si è verificato un problema con l'ottenimento delle ricompense a 3 stelle dalle sfide \"Ci vediamo a Neverland\" e \"Arrivederci, Neverland\" nel \"Paesaggio Onirico\". In base ai tuoi precedenti registri di indagine e completamento delle sfide, provvederemo a inviare una compensazione una tantum per le ricompense che non hai potuto riscuotere. Controlla la tua casella di posta."
  },
  Mail_123134_Name = {
    Text = "Ridistribuzione Ricompense Paesaggio Onirico V2.4.0"
  },
  Mail_123134_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_123501_Desc = {
    Text = "Caro Custode:\n\nTi andrebbe di fare un appuntamento super divertente con me, questa adorabile ragazza, in questo giorno speciale?\nDai, dai, una visitina alla casa stregata non ti farà mica morire di paura~ Sei il \"Custode,\" dopotutto, quindi sicuramente non ti spaventerai per quei \"mostri\" interpretati da esseri umani, vero?\n(Una riga è casualmente cancellata nella lettera: Sto pianificando seriamente il programma del compleanno, non voglio solo vederti spaventato per divertimento...)\nVa bene, basta scherzi. È raro che oggi sia il mio compleanno, e non voglio rovinare tutto! Quindi ora, io, Mouchette, ti invito ufficialmente a cena nel ristorante appena aperto nella City di Londra—\nIl tè caldo e il pesce in umido mi ricordano il sapore di \"casa,\" e in questo mondo, a parte te, non riesco a trovare nessuno con cui condividerlo...\nQuindi verrai sicuramente, vero? Se fai rattristare questa adorabile ragazza, attento che la prossima volta mi piazzo ai piedi del tuo letto con un'ascia mentre dormi!\n\nMouchette"
  },
  Mail_123501_Name = {Text = "\"Aprimi\""},
  Mail_123501_Sender = {Text = "Mouchette"},
  Mail_123543_Desc = {
    Text = "Custode:\n\nUn altro anno, mio caro.\nNelle ombre abbaglianti, tra voci e pettegolezzi vorticosi, nascondo con cura ogni traccia di possibile debolezza, scambiando ogni briciola di valore per il massimo beneficio—è così che riesco ancora a stare qui come vincitrice.\nMa no, a volte sono diventata un po' pigra e debole, e provo un certo piacere nel soddisfare i desideri di quelle ragazzine quando mi invii le tue lettere.\nTuttavia, non lo considero una cosa negativa; ho combattuto una lunga guerra segreta per troppo tempo. Naturalmente, finché ci sarà un barlume di possibilità, una minuscola occasione, continuerò a tentare di sfuggire a \"quella persona\" ancora e ancora.\nÈ solo che, in quei momenti caldi e piacevoli, o in giorni speciali come oggi, mi concedo una piccola pausa, come—invitarti a vedere un'opera insieme, o a cenare con me.\nPerché so che non sarò sola; ho il più gradevole dei complici.\n\nSorel"
  },
  Mail_123543_Name = {
    Text = "Complice..."
  },
  Mail_123543_Sender = {Text = "Sorel"},
  Mail_123544_Desc = {
    Text = "Custode,\n\nSpero che questa lettera ti trovi in buona salute.\n\nTi prego di perdonarmi per il lungo silenzio. La mia recente mancanza di corrispondenza non è dovuta a un deliberato distacco. È semplicemente che ogni volta che prendo in mano la penna, non riesco a trovare il coraggio di scrivere il saluto iniziale.\nIn questo periodo ho attraversato innumerevoli linee temporali infrante e, nel farlo, ho assistito a mondi che marciavano ripetutamente verso la propria fine, contemplando una tragedia irrecuperabile dopo l'altra. Come un'osservatrice in questo vuoto freddo e silenzioso, osservo in silenzio ogni cosa che si compie.\nOgni volta che accade, mi chiedo: la nostra vita è davvero destinata a essere colma di assurdità e separazione? Che si tratti del mio stesso passato, o di tutto ciò che hai incontrato a Kadath, il destino ha forse già scritto ogni cosa, lasciandoci solo il compito di giocare i ruoli previsti da quel copione?\nNon sono giunta a una conclusione. Non sono come quell'Essere Supremo; non riesco a vedere con chiarezza tutte le cose del mondo. Perciò mi chiedo, se... se tu, che possiedi un frammento della Sua Autorità, potessi rispondere a questa domanda?\nÈ per questo che ho scritto questa lettera, sperando che possa portare il mio sguardo al tuo fianco, e sperando di esplorare insieme a te questo enigma forse eternamente privo di risposta. Pertanto, posso osare chiederti di portare questa lettera con te, mentre affronti il cammino che ti attende?\n...\nNon posso rischiare di disturbare lo spaziotempo per essere al tuo fianco, ma ti prego, permettimi... di vederti ancora una volta in questo silenzio desolato e vuoto.\n\n\"Ramona\""
  },
  Mail_123544_Name = {
    Text = "L'Enigma del Pensiero..."
  },
  Mail_123544_Sender = {Text = "\"Ramona\""},
  Mail_123545_Desc = {
    Text = "Caro Pallido Messaggero,\n\nIn precedenza, ho chiesto all'incredibilmente saggia signora di Mythag se ci fossero luoghi disponibili dove poter coltivare dei fiori.\nLa Sig.ra Doll mi ha trovato facilmente una stanza e, sebbene l'odore stantio che ne è uscito quando ho aperto la porta per la prima volta mi abbia fatto dubitare di essere nel posto giusto, dopo un po' di pulizia, ora è in grado di adempiere bene al suo compito e offrire una casa accogliente a questi piccoli.\nTuttavia, a causa della mia inesperienza, ho dovuto applicare opportunamente una forza esterna per assicurarmi che questi piccoli potessero crescere normalmente.\nFortunamente, sotto la guida della Signorina Horla, sono riuscito a coltivarli fino allo stadio attuale.\nNaturalmente, nessuna abilità speciale è stata utilizzata nel processo.\nSe i miei calcoli sono corretti, fioriranno il giorno del mio compleanno e, sebbene continui a ripetere che non c'è nulla di speciale in quel giorno, è davvero difficile non pensare che forse si tratti di un piccolo dono che l'Onnipotente ha disposto per me, data una coincidenza così rara.\nMi chiedo se ti farebbe piacere fare una chiacchierata con me in questo piccolo giardino, trascorrendo insieme questa giornata ordinaria eppure speciale?\nHo preparato biscotti appena sfornati e il tè rosso che mi hai consigliato l'ultima volta, nell'attesa di condividere con te questo raro dono, insieme alla fragranza unica della vita.\n\nSalvador"
  },
  Mail_123545_Name = {
    Text = "Giardino Interno..."
  },
  Mail_123545_Sender = {Text = "Salvador"},
  Mail_123546_Desc = {
    Text = "Hai mai sentito una storia come questa?\n\nC'era una volta un demone sigillato per caso dentro una bottiglia, dove rimase per molti secoli.\nNel primo secolo, promise a chi lo avesse liberato ricchezza e potere infiniti.\nNel secondo secolo, promise a chi lo avesse liberato salute eterna e longevità.\nDopo il terzo, il quarto, il quinto e molti altri secoli, finalmente incontrò il pescatore che aprì il tappo — ma non rispose al suo richiamo, e non desiderava nemmeno più mettere il mondo sottosopra. Si limitò a fingersi una bottiglia vuota qualunque, e venne silenziosamente rigettato in mare.\n\nQuand'ero più giovane, non capivo questa storia. Non finché non ho imparato come un'attesa prolungata e senza speranza diventi così monotona e dolorosa che aggrapparsi alla speranza è più insopportabile della disperazione.\nEppure, prima ancora che la mia ragione possa reagire, il mio cuore mi trattiene ostinatamente nello stesso identico posto.\nLa differenza tra un demone e un essere umano è probabilmente che io, sorprendentemente, sono in qualche modo grata per questo dolore. Perché quando siamo lontani, il dolore mi ricorda la tua esistenza e quanto sei prezioso, impedendomi di perdermi in qualsiasi realtà in cui tu non ci sei.\n\nIn questo giorno della mia nascita, il giorno in cui mi manchi di più, questo dolore mi tiene ancora pesantemente sigillata dentro, prigioniera volontaria nella mia bottiglia di ricordi, facendomi continuare ad aspettarti e a pensare a te.\nSpero che la prossima volta che arriverà questo giorno, potrò darti di persona la prima fetta della torta che taglierò.\n\nRamona"
  },
  Mail_123546_Name = {
    Text = "Una Storia..."
  },
  Mail_123546_Sender = {Text = "Ramona"},
  Mail_123547_Desc = {
    Text = "Gli addetti alla logistica di Mythag hanno piazzato un'assurda montagna di regali inutili davanti alla mia porta. Ostacolano il passaggio. Il mondo è forse a corto di discariche adeguate? Dirottate altrove queste inutili provviste alimentari.\nGestazione. Questo giorno è solo una pietra miliare nel mio cammino di forza, a segnare la fine di un altro ciclo. Anno dopo anno, divento più forte rispetto al precedente.\n\nSe proprio dovete farmi dei regali, mandateli all'altra me qui presente. Credo che li apprezzerebbe.\n\nDato che siete così ingenui e testardi... proverò a fare ciò in cui sono meno abile, e a essere chiara con voi.\nCapite bene: finché esisterò, continuerò a diventare più forte. Nel frattempo, i vostri nemici saranno anche i miei nemici. Non ripeterò queste parole sdolcinate.\n\nNon mandatemi regali di nuovo l'anno prossimo. Soprattutto niente cene di compleanno.\n\n\"H\"."
  },
  Mail_123547_Name = {
    Text = "NESSUN DONO."
  },
  Mail_123547_Sender = {Text = "\"H\""},
  Mail_123548_Desc = {
    Text = "Caro Custode:\n\nLo sapevi? Qualche giorno fa, una misteriosa signora ha fatto visita a Mythag all'improvviso. Indossava un abbagliante abito nero attillato che non avevo mai visto prima—ho chiesto a Jenkin e Mason, e nemmeno loro avevano mai visto un vestito così bello.\nCome posso descriverlo? L'abito sembrava tessuto con i più bei capelli lunghi, morbido, leggero ed elegante, con una superficie che riluceva di un bagliore unico, simile all'acqua...\nVedendo la mia curiosità, Jenkin chiese coraggiosamente alla misteriosa signora informazioni sull'abito, e lei sorrise, dicendo che il materiale del vestito era seta dell'Oriente, tessuta con fili prodotti da una larva chiamata \"baco da seta\", e lo stile si chiama \"qipao\"... Poi, regalò ad Aigis un grande rotolo—disse che si chiamava \"un rotolo\" della stessa \"seta\"...\nLa \"seta\" è troppo preziosa, così ho seguito il modello che ci aveva fornito e ho cucito un \"hebao\" per ciascuno dei miei amici. Alla festa di compleanno di quest'anno, preparerò altri \"hebao\" per tutti... Custode, ti piacerebbe unirti a noi se hai tempo?\nSe sei troppo impegnato, chiederò a Brown di consegnare l'hebao nel tuo dormitorio.\n\nAigis"
  },
  Mail_123548_Name = {
    Text = "Dama Misteriosa"
  },
  Mail_123548_Sender = {Text = "Aigis"},
  Mail_123549_Desc = {
    Text = "Piccolo Germoglio:\n\nSai come gli alberi registrano il tempo e la crescita? Con anello dopo anello di crescita.\nSono nascosti all'interno, mai facilmente visibili, finché un piccolo germoglio cresce gradualmente fino a diventare un albero imponente, che sostiene un cielo maestoso. Le cicatrici del tempo sono celate nel profondo del cuore, senza lasciare traccia.\nOggi segna l'inizio di un nuovo anello di crescita. In questo nuovo anno, dovremo ancora affrontare molte tempeste impreviste.\nMa il seme che ti ho affidato troverà sicuramente il terreno adatto per essere nutrito, e poi metterà radici e germoglierà, vero?\n\nThais"
  },
  Mail_123549_Name = {
    Text = "Anelli di Crescita..."
  },
  Mail_123549_Sender = {Text = "Thais"},
  Mail_123644_Desc = {
    Text = "Questo è il mio terzo compleanno trascorso a Mythag, e ho imparato qualcosa. Il mio compleanno coincide con il Passaggio del Solstizio. Una festività. Un giorno dedicato allo scambio di doni.\nSo che hai molti nemici estremamente potenti, ma stai tranquillo, uccidere è ciò che so fare meglio. Non conosco altri modi per rendere felici le persone e non sono bravo a scegliere regali, ma i miei datori di lavoro sembrano essere soddisfatti ogni volta che porto a termine un incarico con successo.\nPerciò ho deciso il regalo: un singolo contratto di morte, senza scadenza. Nessun limite sul bersaglio.\nDimmi solo chi è il bersaglio e come vuoi che muoia. Se è qualcuno che posso sconfiggere, gli spezzerò il collo il più in fretta possibile; anche se fosse astuto quanto un dio, ti assicuro che la mia resa non arriverà mai prima della mia morte.\n\nHelot"
  },
  Mail_123644_Name = {
    Text = "VUOI QUALCUNO MORTO?"
  },
  Mail_123644_Sender = {Text = "Helot"},
  Mail_124059_Desc = {
    Text = "Caro Custode:\nL'evento \"Sacrificio abissale: Replica\" è terminato. Le rimanenti \"Lacrime del Sacrificatore\", \"Sangue del Sacrificatore\" e \"Midollo del Sacrificatore\" saranno convertiti al tasso di \"Buono Rosa* 40\" per oggetto. Ricordati di controllare le tue ricompense."
  },
  Mail_124059_Name = {
    Text = "Valuta Sacrificio abissale convertita"
  },
  Mail_124059_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_124290_Desc = {
    Text = "Custode:\n\nCome sai, la gioia è in realtà un'emozione piuttosto estranea per me.\nSpesso sento che il mondo ordinario è un clamore sulla superficie dell'acqua, e prima ancora di riuscire a integrarmi in esso, il mio appassire è già arrivato.\nA volte mi fa provare nostalgia, ma più spesso mi lascia disorientata e soffocata. Eppure, in giorni come oggi, per non rattristare la mamma e il papà, resisto con tutte le mie forze... fino a quando arriva il giorno della liberazione, fino a quando il Mare Profondo mi abbraccia.\nPensavo che solo le profondità dell'acqua fossero la mia vera casa. Tuttavia, Custode, grazie a te e alla presenza dei Mythag, persino qualcuna come me, che si sente fuori posto nel mondo ordinario, può iniziare a provare un certo calore genuino. Proprio come il sole bacia le foglie e i petali di una Ninfea mentre galleggia.\nAnche se è caotico, sento che è necessario mettere questi pensieri su carta e inviarteli; ti prego, perdona i miei capricci occasionali.\nSpero solo che tu sappia quanto è preziosa la spinta che mi hai dato nell'acqua che troppo presto era stata sepolta dalla desolazione.\nChe tu possa essere sempre nella gioia e nella pace.\n\nNymphaea"
  },
  Mail_124290_Name = {
    Text = "Galleggiamento..."
  },
  Mail_124290_Sender = {Text = "Nymphaea"},
  Mail_124291_Desc = {
    Text = "Custode:\n\nStamattina, una lettera è apparsa sul mio comodino, un invito alla mia festa di compleanno, firmata dal Club de \"Il Pittore\".\nMi ha ricordato che il mese scorso, avendo un po' di tempo libero, ho accettato di fare da modella per Sanga per la nuova edizione del concorso creativo de \"Il Pittore\". Avevo già rifiutato innumerevoli volte in passato. In quei momenti in cui restavo immobile sul palco mentre gli altri mi ritraevano, mi tornavano in mente i giorni all'altare del Navigatore. Anche allora ero sotto lo sguardo di tutti, ma quegli sguardi erano colmi solo di paura e reverenza, privi di qualsiasi contatto, approvazione o apprezzamento.\nStasera, al buffet di compleanno organizzato nella hall del Club de Il Pittore, saranno esposte anche oltre dieci opere disegnate a mano con cura da vari pittori. Sebbene non abbia molta fiducia nel tuo gusto, un po' di esposizione non può che fare bene. La Divina Madre ti ha invitato personalmente come ospite per ammirare le loro interpretazioni di \"me\".\n\n\"Murphy\""
  },
  Mail_124291_Name = {
    Text = "Il Pittore..."
  },
  Mail_124291_Sender = {Text = "\"Murphy\""},
  Mail_124292_Desc = {
    Text = "Custode,\n\nSylvia mi ha detto che rivelare occasionalmente i miei bisogni alle persone più care aiuta ad alleviare la paura che mi segue costantemente. Non sono sicuro che funzioni, ma non c'è dubbio che oggi sia un buon momento. \nMi concederesti un desiderio? Posso darti tutte le scorte del laboratorio oggi. \nNo, non un sacchetto di chicchi di caffè. \nSebbene quella terrificante oscurità mi abbia portato via quasi tutti i miei affetti e mi perseguiti come un'ombra, tu l'hai sconfitta. \nCi hai permesso di vivere al sicuro a Mythag, o almeno finora abbiamo vissuto al sicuro a Mythag. \nÈ ora di liberarsi da questa malsana dipendenza dalla caffeina, Custode. Puoi dedicarmi un po' di tempo questa sera? \nSe sarai al mio fianco, forse riuscirò a trovare il coraggio di fare un breve pisolino in un posto dove la luce è meno abbondante, anche solo per un po'. \n\nWinkle, che desidera ricordare cosa si prova ad addormentarsi serenamente"
  },
  Mail_124292_Name = {
    Text = "Desiderio..."
  },
  Mail_124292_Sender = {Text = "Winkle"},
  Mail_124293_Desc = {
    Text = "{Male=Mr.,Female=Miss} Custode,\n\nStamattina mi sono svegliata con un sogno. Ho richiamato alla mente con cura ogni dettaglio: la brezza gentile che soffiava sotto il caldo sole, rose e tulipani che ricoprivano l'intera distesa, mille gabbiani argentati che cantavano all'unisono con la gente festosa... Era da molto tempo che non mi ritrovavo in una scena così felice. Credo di essere stata forse nel maniero della mia infanzia, nella Casa dei Fiori di Colette, o in qualche parco della Cité... Ma quando mi sono voltata, ho visto quei magnifici edifici gotici di Mythag, e te, {Male=Mr.,Female=Miss} Custode. Stavi in piedi tra i fiori e la luce del sole, diventando il verso più meraviglioso di questa poesia. \nAmo profondamente la Cité, {Male=Mr.,Female=Miss} Custode. Eppure in quell'istante, ho capito all'improvviso che avevo iniziato ad abituarmi e a innamorarmi di ogni cosa qui, che esiste finalmente un luogo in questo mondo capace di rapire la mia anima ancor più della Cité. \nUn compleanno segna la fine di un periodo e l'inizio di un altro. In questo giorno in cui un nuovo anno ha inizio, mi chiedo se ci sarà quella persona nel giardino sul retro di Mythag, tra la luce del sole e le rose in fiore, disposta ad ascoltare la brezza insieme a me, qualcuno che cattura la mia anima e i miei sogni?\nHorla"
  },
  Mail_124293_Name = {
    Text = "Sogno di Fiori e Poesia"
  },
  Mail_124293_Sender = {Text = "Horla"},
  Mail_124294_Desc = {
    Text = "Caro Custode:\n\nNon molto tempo fa, pensavo sempre a come farti un regalo speciale. Jenkin mi ha suggerito di confezionarti a mano un nuovo capo d'abbigliamento, e ho pensato che fosse un'idea meravigliosa.\nQuesto è il mio stile di taglio preferito di quando lavoravo nella fabbrica tessile, e spero che non sembri fuori moda ormai... Le vivaci righe e i quadri sopra sono stati realizzati da diverse versioni di me. E questo grazioso motivo storto a forma di topo è qualcosa che Gatto \"24\" ha insistito per aggiungere, dicendo che rappresenta Brown, che è la cosa che preferisco della mia personalità felina—non so se sia appropriato, ma spero che ti piaccia.\nNel nuovo anno, non ho ancora desideri per il compleanno. Sei sempre così gentile, mi ricordi ogni anno di festeggiare come si deve. Ma più che essere festeggiato, cucire qualcosa per te con le mie mani mi dona più serenità e gioia.\nTi prego di accettare questo nuovo capo d'abbigliamento colmo delle mie più sincere intenzioni.\n\nMason"
  },
  Mail_124294_Name = {
    Text = "Vestiti nuovi..."
  },
  Mail_124294_Sender = {Text = "\"24\""},
  Mail_124295_Desc = {
    Text = "Tsk.\n\nIncredibile, io, la grande Signora dei Labirinti, sono riuscita a sopravvivere un altro anno in prove così difficili. \nAscolta bene! È tutta colpa tua e di quella stupida accademia! \nNon importa quanto mi laviate il cervello con le vostre sciocchezze, queste faccende banali dovrebbero essere gestite da professionisti. Va bene, sono stata piuttosto notevole; non li ho nemmeno chiamati schiavi. \nQuei vecchi bacucchi la chiamano... com'era? Giusto, crescita personale. \nAspetta, perché mi sto facendo trascinare anch'io da questa logica? Argh, che seccatura! (Qui c'è un mucchio di pieghe sgualcite lasciate dalla proprietaria della lettera durante una scenata.) \nVabbè, visto che ho fatto dei \"progressi,\" anche tu devi dimostrare la tua sincerità. In questo giorno così importante, non puoi aspettare che sia io a ricordartelo come negli ultimi due anni. \nTi do trenta minuti, Custode, per venire da me con un regalo. \nAltrimenti, farò strisciare la mia prole sulla tua faccia mentre dormi. \n\nAgrippa"
  },
  Mail_124295_Name = {Text = "Progresso"},
  Mail_124295_Sender = {Text = "Agrippa"},
  Mail_124296_Desc = {
    Text = "Custode!\n\nL'ho visto! Che scena magnifica! Sono certo che non fosse un sogno! Me ne stavo lì, proprio accanto alla grande statua commemorativa nel cimitero dei Mythag, a contemplare le infinite lapidi senza nome. Ero certo che mi avrebbero portato un'Intuizione senza precedenti, ma non mi sarei mai aspettato che mi avrebbero donato molto di più. Si fanno beffe della mia arida immaginazione con ammirevole generosità.\nHo visto gli spiriti di quegli Investigatori levarsi insieme in quel magnifico, nebbioso crepuscolo. Non riuscivo a scorgerne i volti, ma ne vedevo i movimenti: simili a una danza elegante, eppure anche a un misterioso rituale. Rendevano omaggio verso la Pozza Nera, verso i Mythag e verso di voi. Gli artisti dei saloni moderni sono ossessionati dal ritrarre individui, e spesso disprezzano queste scene grandiose, ma io non mi sono mai sentito così. Sono al colmo della gioia di fronte alla danza dei ghoul, e oggi questa scena mi ha fatto venire le lacrime agli occhi.\nCredo che non possa essere una mera coincidenza. Oggi, nel giorno del mio compleanno, mi hanno mostrato la loro magnifica danza. Credo che vogliano trasmettere qualcosa. Non possiedo nulla se non il mio pennello, ma non è forse abbastanza?\nLa bozza di questo dipinto è già completa, Custode. Vi prego, venite nel mio studio a dargli un'occhiata! I leggendari Investigatori che hanno perduto il proprio nome hanno condiviso tutti i loro desideri incompiuti sulla mia tela!\nNon ho osato dare un nome a questo dipinto con troppa fretta; credo che tale privilegio spetti a voi.\nP.S. Davvero NON sono andato là per dissotterrare cadaveri, ve lo assicuro!\n\nPickman"
  },
  Mail_124296_Name = {
    Text = "Il desiderio di lunga data dell'Investigatore..."
  },
  Mail_124296_Sender = {Text = "Pickman"},
  Mail_124297_Desc = {
    Text = "Caro Custode,\n\nHai paura, o piuttosto—paura mista ad anticipazione per ciò che potrei svelare nel giorno del mio compleanno in nome della celebrazione?\nUna finta intimità, un'improvvisa notte di passione, o un miraggio surreale ingannevole ma inebriante?\nAh, niente di tutto ciò. Persino io, di tanto in tanto, mi ritrovo afflitto da un raro attacco di sincerità.\nSai cosa sono. Sono colui che danza mentre il palazzo brucia, assaporando ogni squisito vizio anche mentre le travi gemono.\nAmore e desiderio non possono curare il più grande male di questo mondo: la noia. Eppure, come catalizzatori per i sapori del potere e del caos, sono semplicemente perfetti.\nAhimè, dopo innumerevoli anni, forse il mio profondo studio delle opere teatrali ha portato qualche ottuso ad analizzare il mio cuore e la mia anima, sostenendo di scorgere il tuo spirito solitario e desolato.\nPfui...\nPersino io, che mi diletto a giocare ruoli, spesso avverto un certo senso di nausea.\nE tu... qual è il tuo scopo nel legarti a me? Controllare, contenere, esercitare potere?\nPer proteggere di più, hai bisogno di maggiore autorità, e la sete di potere genera ambizioni più grandi. Quando matureranno, e quando verranno divorate... Il solo pensiero mi eccita, rendendomi disposto a restare al tuo fianco ancora, per molti altri anni.\nShh, non c'è bisogno di dirmi la risposta.\nIn questo giorno, ogni anno, catturare una notte dei tuoi sogni, assaporare e ponderare se le tue ambizioni stanno fiorendo, se le tue intenzioni sono mutate, è il miglior regalo di compleanno che possa farmi.\nSpero che tu non te la prenda.\n\n\"Qian Shan\""
  },
  Mail_124297_Name = {
    Text = "Notte Squisita..."
  },
  Mail_124297_Sender = {Text = "Xu"},
  Mail_124298_Desc = {
    Text = "Custode,\n\nAddestramento, combattimento, pattugliamento... da quando sono entrata nell'esercito, mi sono abituata a riempire tutto il mio tempo con compiti necessari alla collettività. \nIn seguito, guidando gli Aram nella migrazione attraverso il deserto, questi compiti sono solo aumentati, radicandosi nella mia mente come una legge, tanto che anche quando sono arrivata a Mythag, ho sempre dato priorità agli impegni collettivi rispetto alle questioni personali. \nMa nelle mie interazioni con gli altri, e soprattutto con te, ho capito che sia come Risvegliatore sia come essere umano, tutti abbiamo bisogno di un po' di tempo che appartenga solo a noi stessi, per assaporare i momenti con le persone importanti. \nPerché questo legame prezioso àncora la nostra esistenza nel tempo e le conferisce un significato davvero insostituibile. \nAnche se può sembrare un po' audace, ho annullato tutti gli impegni collettivi di oggi, liberando un'intera giornata. \nMi bastano poche ore... no, anche solo un'ora, o pochi minuti... se sei disposto a dedicarmi un po' del tuo tempo personale, questo diventerà il significato di questa giornata speciale per me. \n\nAlva"
  },
  Mail_124298_Name = {
    Text = "Tempo privato..."
  },
  Mail_124298_Sender = {Text = "Alva"},
  Mail_124299_Desc = {
    Text = "Piccolo mio,\n\nUn anno può sembrarti lungo, ma per i viaggiatori del Mare dell'Essenza Primordiale, non è che una manciata d'acqua di mare che evapora in fretta nell'oceano sconfinato del tempo. Per fortuna, in quest'acqua di mare, ci sono alcune gocce di cristallina bellezza.\nIl giorno di sconti al Negozio Scacciapreoccupazioni è sicuramente uno di quei tesori che vale la pena custodire. Non solo perché porta buoni dorati, ma soprattutto perché so che in questo giorno, un certo ospite visiterà sicuramente questo piccolo negozio.\nTutti i legami tra le persone sono affari, e tutti gli affari sono un legame tra le persone. Ogni ospite entrerà nel proprio piccolo negozio in un momento preciso, e ogni piccolo negozio accoglierà i propri ospiti in momenti precisi. Nel lungo scorrere del tempo, ho visto innumerevoli tesori, e alla fine, questi momenti ingenui diventeranno i pezzi da collezione più preziosi—sono la ragione d'essere di questo lungo scorrere del tempo.\nIn quest'anno, il nuovo pezzo da collezione più prezioso attende silenzioso nella vetrina, aspettando pazientemente il suo ospite predestinato.\nVieni presto, piccolo mio.\nIl Negozio Scacciapreoccupazioni ha già chiuso in anticipo. Oggi, la sua porta è aperta per una sola persona.\n\nDaffodil"
  },
  Mail_124299_Name = {
    Text = "Nuovo oggetto da collezione..."
  },
  Mail_124299_Sender = {Text = "Daffodil"},
  Mail_124300_Desc = {
    Text = "Custode:\n\nMi chiedo se ricordi ancora i momenti che abbiamo condiviso davanti alla Porta. Quel giorno, ho aperto una sottile fessura di verità per mostrarti la realtà dell'universo.\nInaspettatamente, mentre tu sperimentavi l'eternità di contemplare innumerevoli mondi, un'emozione fugace e incomprensibile è affiorata dentro di me.\nSpesso mi interrogo su cosa fosse quella sensazione in quell'istante, e perché io, che comprendo la verità, abbia potuto provare qualcosa di così insondabile.\nHo riflettuto a lungo, e nel contesto del mondo reale come metro di misura, è stato un tempo che potrebbe essere definito \"eterno\".\nDurante questo periodo relativamente lungo nella vastità del cosmo, ho compreso che potrebbe trattarsi di un miracolo indefinito.\nIn questo giorno speciale, desidero invitarti a connetterti con me, a osservare attraverso il mio sguardo alcune esistenze che non ho mai contemplato prima. Questa volta, ciò che osserveremo... non sarà più vincolato da ciò che è prestabilito.\nInsieme, cercheremo un futuro al di là di questa verità.\n\nTawil"
  },
  Mail_124300_Name = {
    Text = "Oltre la verità..."
  },
  Mail_124300_Sender = {Text = "Tawil"},
  Mail_124301_Desc = {
    Text = "Custode:\n\nQuest'anno, come negli anni passati, ho messo da parte ogni altra questione per restare in silenzio da solo con me stesso, cercando di riscrivere e rinnovare i ricordi legati alla mia terra natale.\nLi sento ora più lontani da me, e anche sforzandomi di adattarmi a questa forma umanoide, cercando in ogni modo di ripercorrere e riattraversare più e più volte le conoscenze e le esperienze legate all'oceano, dimenticare resta molto più facile che ricordare in questo mondo che a poco a poco svanisce.\nL'unica consolazione è che noi, viaggiatori lontani da Lemuria, abbiamo ancora questo luogo in cui restare, in grado di seguire la volontà del nostro re, perseguendo in silenzio e attendendo in silenzio.\nConosco bene i sacrifici e gli sforzi che hai compiuto per tutto questo; non so come esprimerti la mia gratitudine. Prima che io faccia ritorno a Lemuria in questa forma, se c'è qualcosa che posso fare, sono altrettanto disposto a donare tutta la mia luce per questo.\n\nCon sincerità,\nFaros"
  },
  Mail_124301_Name = {Text = "Faro..."},
  Mail_124301_Sender = {Text = "Faros"},
  Mail_124302_Desc = {
    Text = "Caro Custode:\n\nDal giorno in cui sono entrata a far parte di Mythag, una miriade di regole mi ha avviluppata. Vietato portare i servitori a passeggio nella sede, vietato calpestare i volti degli studenti nella piazza del campus, vietato organizzare orge nell'auditorium...\nQuei fastidiosi puristi di Mythag mi hanno ingabbiata, e questa non è la vita che una Regina di Isarawu dovrebbe condurre. Merito di godere di tutto ciò che mi spetta di diritto: vino inebriante, schiene morbide e i miei amati servitori... In questo giorno della mia nascita, in cui dovrei abbandonarmi liberamente ai piaceri, è naturale che tali pensieri affiorino.\nLa notte è fonda e la mia pazienza per le questioni futili si è esaurita. Non ti manderò in missione a mezzanotte, né ti chiederò di indovinare da solo. Ho bisogno che tu resti al mio fianco.\nVieni alla mia tenuta, ora, senza esitare, e liberati di ogni indumento e titolo superfluo.\nStanotte, e ogni notte a venire, mi appartieni.\n\nConsidera questo il tuo primo incarico permanente.\n\nWanda"
  },
  Mail_124302_Name = {Text = "Regole"},
  Mail_124302_Sender = {Text = "Wanda"},
  Mail_124303_Desc = {
    Text = "Custode,\n\nTintura mi ha detto che ha in programma un viaggio interstellare dopo il suo concerto personale, finanziato con i proventi ricavati, e che vuole portarmi con sé. Ma... se andassi con lei, si distrarrebbe sicuramente a prendersi cura di me. Non voglio che la sua felicità venga compromessa per causa mia. \nAma così tanto la luce nella sua vita, rapita dalla miriade di colori e dai fiumi di stelle che scorrono in questo universo. Se mi portasse con sé, probabilmente non potrebbe cantare liberamente né ammirare ciò che desidera... \nQuindi... potresti aiutarmi a convincerla? Per favore, lascia che viaggi da sola, che vada su pianeti diversi per i suoi concerti e che abbracci tutti i paesaggi che tanto desidera... Oppure potresti prendere il mio posto in questo viaggio? Dopotutto, sia Tintura che io ti siamo molto grati e vogliamo ricambiare la tua gentilezza... Se fossi disposto/a... \nSolo, per favore, non dirle che è un mio desiderio. Non voglio essere un peso nel suo viaggio verso la libertà. \n\nFaint"
  },
  Mail_124303_Name = {
    Text = "A proposito di viaggi..."
  },
  Mail_124303_Sender = {Text = "Faint"},
  Mail_124304_Desc = {
    Text = "Benefattore:\n\nVivere questi giorni con Pollux a Mythag è così sereno, così luminoso, come se fosse un sogno...\nAnche se Pollux si attiene ancora a quelle formalità, parlando con toni raffinati e composti, riesco a percepire chiaramente che sta gradualmente tornando la persona che era un tempo. La distanza mozzafiato che appartiene al \"Divus\" si sta silenziosamente dissolvendo nella dolcezza della nostra quotidianità. Tutti questi delicati cambiamenti sono merito tuo.\nSpesso mi chiedo cosa posso fare per ricambiare questa gentilezza. A differenza di Pollux, non sono abbastanza abile da creare un dono capace di stupirti. La gioia del volo, l'hai già sperimentata con me molte volte. Ho riflettuto in silenzio su come condividere la gioia con te in questo giorno speciale.\nForse... ti piacerebbe avere le mie piume? Si dice spesso che possiedano una morbidezza capace di donare tranquillità. Quindi, se un giorno ti sentirai stanco o desidererai semplicemente un angolo di quiete, sentiti libero di venire al mio fianco. Le mie ali saranno sempre pronte ad abbassarsi per te.\n\nCastor"
  },
  Mail_124304_Name = {Text = "Piume..."},
  Mail_124304_Sender = {Text = "Castor"},
  Mail_124305_Desc = {
    Text = "Mio piccolo prigioniero,\n\n Ho sentito che a Mythag è diventato popolare di recente un gioco di ruolo con streghe e lupi mannari... Tsk, non sembra per niente romantico~ Ho pensato a un gioco molto più divertente! \n Che ne dici se tu fai il prigioniero e io faccio la guardia? Quando farò schioccare la mia piccola frusta, voglio sentire gemiti forti~ La cera della candela scorre sul tuo corpo, portando una sensazione bruciante di dolore e piacere... Ah, solo immaginare quella scena mi fa già sentire tutta dolce~ \n Oh caro, scommetto che a questo punto stai già aggrottando le sopracciglia, vero? Che birichino~ Dopotutto oggi è il mio compleanno~ Mio caro piccolo prigioniero, dovresti esaudire almeno un po' i miei capricci, non credi? \n Se proprio non va bene... allora... che ne dici se tu fai la guardia e io divento la tua prigioniera? Ti soddisferò~ \n\nPandia"
  },
  Mail_124305_Name = {
    Text = "Gioco di ruolo..."
  },
  Mail_124305_Sender = {Text = "Pandia"},
  Mail_124306_Desc = {
    Text = "Custode,\nBenefattore, oggi è il mio compleanno. In questo giorno speciale, voglio condividere con te i miei ultimi progressi: sotto la guida di Lord Golia e della Sig.ra Lotan, sembra che io stia... riuscendo sempre più ad attingere al potere che scorre nella mia linea di sangue. Non giace più dormiente, ma al contrario, a ogni esercizio, vibra e pulsa nel mio corpo, liberandosi gradualmente.\n\nNon saprei dire esattamente quando completerò la mia metamorfosi finale e diventerò un discendente Aequor più puro. Forse domani, forse la prossima settimana, forse il prossimo mese... Ma sappi che, indipendentemente da quanto durerà questo processo o quante prove mi attendono, ho sempre... custodito le tue parole di incoraggiamento nel mio cuore. Continuerò a impegnarmi.\n\nC'è un'altra cosa per cui devo scusarmi; ho appena saputo dal servizio postale Mythag che inviare denaro contante con la posta comporta un costo aggiuntivo di 2 dollari.\nPer compensare la quota dell'anno scorso, preleverò qualcosa dalle mie riserve. Sono guadagni sudati per me, ma un successore della stirpe Aequor porta con sé una promessa che deve essere mantenuta.\n\nCaecus"
  },
  Mail_124306_Name = {
    Text = "Costo del servizio..."
  },
  Mail_124306_Sender = {Text = "Caecus"},
  Mail_124307_Desc = {
    Text = "Custode,\n\nAscolta bene, stanotte a qualunque costo vieni con me a <Italic:quella pasticceria.>\nI vestiti per il travestimento ti sono già stati inviati, quindi assicurati, assolutamente, che nessuno ci riconosca!\nI dolci in edizione limitata di quel negozio sono in vendita, e quella spregevole versione di me spuntata dal nulla deve aver corrotto un sacco di gente, non possiamo farle sapere dove mi trovo.\nAnche se ha prenotato tutte le edizioni limitate di ogni pasticceria di Londinium per impedirmi di comprarle, beh... hehe.\nHo già segretamente preso accordi con lo chef di <Italic:quella pasticceria> per togliere dal menu il dolce migliore.\nHmph, oggi farò capire a quella tipa che certe cose non si possono ottenere solo con i soldi.\nA quel punto, ci intrufileremo silenziosamente dalla porta sul retro, apriremo la cassaforte con tripla serratura e prenderemo il meglio delle edizioni limitate.\nQuanto alla ricompensa, te ne darò <Del:un pezzo>, metà della torta!\nStanotte alle undici ti aspetterò nella stanza, devi venire, assolutamente! Hai capito?!\nDeve restare un segreto, altrimenti, se la notizia trapela e lei scopre dove siamo, sarà tutto rovinato!\n\nMurphy"
  },
  Mail_124307_Name = {
    Text = "Battaglia per la torta..."
  },
  Mail_124307_Sender = {Text = "Murphy"},
  Mail_124308_Desc = {
    Text = "Custode,\n\nMi rammarico di informarvi che il Teatro di Londinium ha completamente cancellato lo spettacolo di magia del Maestro Casiah per le seguenti ragioni: prezzi dei biglietti troppo elevati, una recente ondata di eventi bizzarri che ha portato a un calo di interesse per la magia, la scomparsa di diversi spettatori dopo spettacoli consecutivi e le frequenti visite della polizia al proprietario del teatro per richiedere al Maestro Casiah di sospendere le esibizioni a fini investigativi, tra le altre cose. \n Recentemente, a causa dei disordini a Blackpool, le mie esibizioni hanno effettivamente avuto qualche piccolo inconveniente, ma si tratta di inezie. Tuttavia, il secondo punto è assolutamente intollerabile per il Maestro Casiah! \n Ho riflettuto a lungo e finalmente ho ideato un nuovo spettacolo perfetto! Cose come la manipolazione di cadaveri, la resurrezione dei morti, i viaggi dimensionali, il contagio emotivo e i tentacoli giganti... non meritano nemmeno di essere menzionati! In passato, a causa dell'influenza di quel detestabile segugio dimensionale, la manipolazione del tempo è sempre stata un tabù in questo settore, ma ora che il vile segugio è stato sigillato, la carriera magica del Maestro Casiah raggiungerà un nuovo livello! \n Lo spettacolo è previsto per stasera, completamente gratuito, e un posto in prima fila, proprio al centro, è stato riservato per voi, Custode. Ci sarà anche un segmento interattivo a sorpresa che vi attende! Godetevi l'onore di essere il primo spettatore interattivo del più grande spettacolo di magia della nuova era! \n Per la gloria del Maestro Casiah! \n\nCasiah"
  },
  Mail_124308_Name = {
    Text = "Casiah, ridà grandezza alla magia!"
  },
  Mail_124308_Sender = {Text = "Casiah"},
  Mail_124309_Desc = {
    Text = "Padrone,\n\nLa signorina Sylvia è appena venuta a dirmi che per il mio compleanno quest'anno mi porteranno a fare un giro sulla ruota panoramica.\nLily ha letto nel suo libro che la ruota panoramica è una ruota molto grande, e quando ci si siede sopra, si può girare lentamente fino al cielo e vedere gli uccellini volare intorno. Sembra molto divertente.\nMa la signorina Sylvia ha detto: \"In realtà, ci sono alcune differenze.\" Lily non capisce cosa significhi.\nHa anche detto che il posto dove arriva la ruota panoramica è troppo in alto, e che sarebbe meglio se potessi portare un accompagnatore.\nLily non capisce cosa significhi accompagnatore, ma vorrebbe viaggiare tra le nuvole con te.\nDopo pranzo, la signorina Sylvia e io ti aspetteremo fuori dal dormitorio.\n\nLily"
  },
  Mail_124309_Name = {
    Text = "Ruota panoramica..."
  },
  Mail_124309_Sender = {Text = "Lily"},
  Mail_124310_Desc = {
    Text = "Custode (finalmente l'ho scritto giusto stavolta! Niente male, eh!):\n\nÈ di nuovo il momento di scrivere queste cose sdolcinate; ormai ci ho fatto l'abitudine. In questo momento Brown e io ci stiamo scervellando su cosa offrirti oggi!\nIl cibo di strada nei vicoli del Distretto Est è sicuramente delizioso, ma oggi ho intenzione di portare te e Brown in un posto elegante—nello specifico, a mangiare quelle cose che voi marmocchi dell'Ovest adorate.\nTipo quei piatti raffinati annegati in salse e spezie, serviti in porzioni minuscole su piatti enormi, e con prezzi assurdamente esagerati, è praticamente una rapina a mano armata. Solo a pensarci mi sembra che il portafoglio si sgonfi; dev'essere questa la sensazione quando i soldi se ne vanno, lasciando dietro un buco enorme.\nMa tu sei la persona più importante e cara per me, dopo Sorella e Brown. La gente del Distretto Est non è tirchia con i propri, quindi oggi tutte le spese saranno coperte da me e Brown.\nNon sottovalutarci; abbiamo guadagnato un bel po' consegnando latte, giornali e facendo commissioni, quindi puoi stare tranquillo!\n\nI tuoi buoni amici Jenkin e Brown"
  },
  Mail_124310_Name = {
    Text = "Oggi offriamo noi!"
  },
  Mail_124310_Sender = {Text = "Jenkin"},
  Mail_124311_Desc = {
    Text = "Caro Custode:\n\nAvrai sicuramente sentito della straordinaria impresa di Sylvia, che ha completamente distrutto il casinò sotterraneo di Mythag, giusto? Ma oggi è il mio compleanno, e se non ci fossero attività che fanno pompare l'adrenalina, non sarebbe uno spreco di questa celebrazione annuale?\nDopo un'attenta riflessione, ho deciso di invitarti come mio fidato Watson per aiutarmi a catturare il Ladro Notturno, recentemente fuggito dalla Cité dopo aver rubato dei tesori dal Grand Museum.\nMentre bevevo qualcosa all'\"Apollo Bar\" fuori dal campus, li ho sentiti per caso vantarsi delle loro imprese nel saccheggiare gioielli costosi. Il barista non li ha presi sul serio, ma io ho riconosciuto che stavano parlando di smeraldi, zaffiri e corone di diamanti, che corrispondevano perfettamente agli oggetti rubati. Per non insospettirli, li ho tenuti d'occhio e mi sono preparato a coglierli in flagrante quando torneranno al loro nascondiglio.\nStasera alle 19:00, alla fermata del treno speciale di Mythag al cancello della scuola, incontriamoci.\n\nRyker"
  },
  Mail_124311_Name = {
    Text = "Piano di caccia..."
  },
  Mail_124311_Sender = {Text = "Ryker"},
  Mail_124312_Desc = {
    Text = "Custode,\n\nIl tempo a Mythag sembra scorrere più lieve che in qualsiasi altro luogo. Qualche applauso, qualche chiamata alla ribalta, e un anno è già passato.\nDurante quest'anno ho sviluppato nuove abitudini. In passato, quando salivo sul palco, anche il teatro più affollato mi appariva vuoto. Danzavo sull'immenso palcoscenico davanti a una platea deserta, e l'unico suono a riecheggiare nel mondo era quello delle mie scarpette da ballo. Ma ora, ogni volta che il sipario si alza, vedo te. Le migliaia di posti sono vuoti, eppure tu solo mi osservi. Nei tuoi occhi, la mia danza ha ritrovato il suo significato.\nUn anno è trascorso, e i tuoi movimenti sono ancora così goffi, eppure il tuo sguardo vivace dal pubblico trascende con facilità i passi ordinari sul palco. Quegli sguardi sono come un ruscello che scorre, purificando uno a uno i miei passi di danza sempre più comuni. In questo duetto tra danzatrice e pubblico, mi sto gradualmente avvicinando a quella sala che ho sempre cercato. Ho finalmente compreso che per la danza, sia il pubblico che il danzatore sono ugualmente importanti.\nPer diversi mesi ho preparato una danza. È stata nutrita dal tuo sguardo, nata nella tua silhouette. Ora è pronta.\nCredo che desideri vedere te come primo testimone, questa sera.\n\nLiz"
  },
  Mail_124312_Name = {
    Text = "Danzatrice e pubblico..."
  },
  Mail_124312_Sender = {Text = "Liz"},
  Mail_124313_Desc = {
    Text = "Custode:\n\nGrazie all'accoglienza di questo luogo, quest'anno ho avuto molte conversazioni con il nostro Re. Sebbene la Discesa del Regno Divino sia ancora lontana, sembra che l'eredità di Lemuria stia tornando in vita nei Mythag.\nSia tu che il mio Re mi avete detto che la fede non dovrebbe essere tutto nella mia vita. Sono stata ostinata, ma le esperienze che ho attraversato di recente sembrano aver cambiato il mio modo di pensare. Forse pregare troppo frequentemente potrebbe infastidire Nostro Signore. Oltre al devoto servizio, Nostro Signore potrebbe anche desiderare che i Suoi Fedeli abbiano una propria vita semplice.\nCon questa consapevolezza, ho tentato di apportare alcuni piccoli cambiamenti. Ho visitato tutti i famosi pasticceri di Londinium e ho chiesto loro di insegnarmi i metodi di preparazione. Hanno alcuni segreti che non vengono tramandati, ma sono riuscita a farli parlare attraverso La Benedizione di Nostro Signore. Ieri ho fatto alcuni tentativi per la prima volta, e alcuni Fedeli mi hanno detto che il sapore era piuttosto buono, ma il loro gusto, come la loro Lealtà, è alquanto discutibile.\nVorrei invitarti oggi nel mio cortile per assaggiare. Mi fido del tuo gusto e della tua onestà. Se non è buono, spero che tu sia sincero/a, e prenderò le tue osservazioni seriamente per migliorare.\nTe ne sarei molto grata.\n\nMiryam"
  },
  Mail_124313_Name = {
    Text = "Un'altra specialità..."
  },
  Mail_124313_Sender = {Text = "Miryam"},
  Mail_124314_Desc = {
    Text = "Caro Custode:\n\nDevi essere stanco di sentir parlare del significato della vita e della morte, vero? Dai vividi ricordi dei defunti di Necrovia, la lezione più importante che ho imparato è che, piuttosto che cercare il significato del consumo, ciò che conta di più è il cibo stesso sulla tavola davanti a noi.\nNegli antichi tempi dell'umanità, i nostri antenati avevano già esplorato tutte le sfumature del consumo: passione, desiderio, godimento. Non si mangia per vivere, ma si vive per mangiare. Purtroppo, quei desideri primitivi e puri sono stati gradualmente dimenticati nel lungo trascorrere del tempo, e questo concetto è diventato sempre più complesso.\nPer questo ho chiamato il tema del banchetto di stasera \"Purezza\". In questo giorno cerimoniale, tutte le questioni complesse saranno tenute a distanza. Su questa tavola ci saranno solo passione e desiderio puri e primordiali, solo intenditori e cibo, solo tu e io.\nTi prego, accetta il mio più sincero invito. Non mi rifiuteresti, vero?\n\nDoresain"
  },
  Mail_124314_Name = {
    Text = "Festino puro..."
  },
  Mail_124314_Sender = {Text = "Doresain"},
  Mail_124315_Desc = {
    Text = "Mio carissimo Custode,\n\nSento come se il mio cuore stesse crescendo... So che suona strano per un Risvegliatore, ma è diverso da prima. Come potrei descriverlo? \nPer quanto gentilmente e teneramente quelle brave persone mi trattassero nel tentativo di scaldarmi, da quando mio fratello se n'è andato, il mio petto si è sempre sentito vuoto. Più cammino sotto il Sole, più quel calore mi graffia. Al contrario, l'oscurità e l'umidità mi fanno sentire al sicuro, come se restare in un luogo freddo significasse che l'amore aspro e doloroso di mio fratello non mi abbia mai lasciato. \nMa ora, dopo questi anni in cui ci siamo avvicinati, ogni volta che ti vedo, ogni volta che il dolore che mi infliggi si posa sulla mia carne e si trasmette alle mie ossa—ah, la felicità nel mio petto cresce giorno dopo giorno. Finché mi colpirai senza pietà, mi insulterai e mi calpesterai, saprò che ci sarà sempre un posto in questo mondo in cui appartengo davvero. \nQuesta felicità durerà fino all'anno prossimo? E quello dopo ancora? Se tutti i desideri espressi il giorno del mio compleanno si avverassero, il mio unico desiderio sarebbe quello di essere costantemente scrutato dal tuo sguardo sprezzante, insieme al dolore... sempre più dolore. Quando alzerai la mano, la prima cosa che sentirò sarà quel profumo familiare, crudele e beato. \n\nCon l'immenso desiderio di essere colpito da te, \nLeigh"
  },
  Mail_124315_Name = {
    Text = "Il mio cuore..."
  },
  Mail_124315_Sender = {Text = "Leigh"},
  Mail_124316_Desc = {
    Text = "Custode\n\nSebbene sia molto curioso riguardo ai tuoi recenti esercizi, stai tranquillo: non sono qui per spronarti a esercitarti con la musica oggi.\nStamattina mi sono recato nella sala della musica come al solito, ma ero in ritardo di trentacinque minuti. Allenarmi alle sette del mattino è un'abitudine che mantengo da decenni, eppure oggi è stata infranta con facilità. Il motivo è che, passando per il corridoio della scuola, ho udito un coro di pettirossi cantare.\nInfrangere un'abitudine consolidata non è facile da accettare, specialmente per me. Stranamente, non ho provato la delusione o la rabbia verso me stesso che avrei immaginato. All'inizio ho avvertito un'ondata di panico. Ma poi ho dovuto ammettere che la melodia che riecheggiava nella mia mente era deliziosa.\nLondinium viene sempre risvegliata dal canto dei pettirossi; è un suono che ascolto ogni giorno. Curiosamente, dopo tutti questi anni, questa è la prima volta che li ho davvero notati. Ho ascoltato in silenzio i loro canti nel corridoio e, durante quei trentacinque minuti, ho avuto l'impressione che la melodia più sublime dell'universo fosse celata nelle loro piccole gole.\nForse la vita qui rende compiacenti, o forse l'atmosfera rende più miti. In ogni caso, credo che debba avere qualcosa a che fare con te.\nHo accettato questo cambiamento con gioia in soli dieci minuti. La vita, come la musica, ha i suoi ritmi eterni e i suoi mutamenti; il giorno della nascita potrebbe essere il punto destinato in cui questi cambiamenti si manifestano. Voglio anche ringraziarti per avermi dato l'opportunità di quietare la mente e ascoltare ciò che prima trascuravo. Delizioso, davvero. Credo che questo segnerà l'inizio di un nuovo capitolo della mia vita.\nPer questo, vorrei invitarti a raggiungermi nel bosco fuori dalla scuola al crepuscolo di oggi. I suoni della natura al tramonto sono diversi da quelli del mattino, ma sono certo che saranno entrambi nuove ispirazioni nelle nostre vite musicali.\n\nHameln"
  },
  Mail_124316_Name = {
    Text = "Suoni della natura..."
  },
  Mail_124316_Sender = {Text = "Hameln"},
  Mail_124317_Desc = {
    Text = "Caro/a {Male=sir,Female=lady}, \n\nHo appena visto la mail di compleanno che Faint ti ha scritto... Come previsto, pensa sempre agli altri. Tuttavia, tra sorelle non esistono debiti, e non l'ho mai considerata un peso. Senza la sua protezione, oggi non avrei l'opportunità di fare questa tournée di concerti. \nCaro/a Nobile, sei sempre stato/a il mio pubblico più importante. Perciò, questa volta, ho preparato in segreto un biglietto per te—ti invito sinceramente a unirti a noi in questo viaggio interstellare. Con te al nostro fianco, credo che il senso di colpa di mia sorella si allevierà notevolmente. \nInoltre, stai tranquillo/a: non disturberemo il tuo tempo personale durante il viaggio. Mia sorella e io speriamo entrambe che tu possa goderti appieno questo viaggio, vivendo liberamente ogni nebulosa e ogni incontro con l'ignoto. \n\nTintura"
  },
  Mail_124317_Name = {
    Text = "Invito al viaggio..."
  },
  Mail_124317_Sender = {Text = "Tintura"},
  Mail_124318_Desc = {
    Text = "Custode,\n\nCon il mio compleanno che si avvicina di nuovo, i miei pensieri tornano spesso alla Cité. Mi mancano soprattutto le sculture delle mostre d'arte. Le loro pose silenziose hanno bussato alla porta della mia ispirazione innumerevoli volte. \nCircondato da sculture nello studio tutto il giorno, la mancanza di scambio artistico è diventata col tempo logorante. L'anno scorso, in questo periodo, per festeggiare il mio compleanno, ho scolpito innumerevoli sculture a forma di torta. L'entusiasmo iniziale ha ormai lasciato il posto alla calma. \nOra, con la mia mobilità limitata, tornare alla Cité è diventato un lusso. Se per caso avessi in programma di andare a investigare, potresti tenere d'occhio le nuove opere nelle mostre d'arte per me? Desidero ardentemente toccare ancora quella bellezza artistica così varia e inclusiva attraverso i tuoi occhi. \nCome ricompensa, sarei disposto a creare un'altra scultura per te, intitolata \"Il Custode nella Cité\". Che ne dici? \n\nSanga"
  },
  Mail_124318_Name = {
    Text = "Cité Nostalgia..."
  },
  Mail_124318_Sender = {Text = "Sanga"},
  Mail_124770_Desc = {
    Text = "Custode:\n\nOgni anno il mio accesso al laboratorio viene revocato, rendendo questo giorno speciale in modo spiacevole. Per evitare di sprecare tempo in futilità inefficienti, ho fatto visita agli archivi.\nLì ho scoperto due oggetti; il primo era un quaderno pieno di pagine bianche prive di valore.\nIl secondo era anch'esso un quaderno, che mi ha fatto comprendere di aver sottovalutato la vastità della conoscenza, poiché i processi di derivazione e le conclusioni scritte al suo interno mi hanno mostrato che esistono effettivamente cose in questo mondo ancora meno preziose della non-esistenza.\nEntrambi i quaderni riportavano lo stesso nome: quello del nostro grande Custode di Mythag, %player%.\nErica mi ha detto che volevi sapere quale regalo di compleanno inviarmi.\nPuoi darmi una risposta.\nSono anche curiosa di sapere quale risposta mi scioccherebbe di più. È semplicemente l'estrema pigrizia e negligenza dimostrata, oppure il fatto che tu abbia seriamente studiato per un intero anno accademico, solo per lasciare dietro di te questa spazzatura accademica in una futile disperazione?\nSe si tratta della prima ipotesi, purché vi siano ragioni e prove sufficienti che tu abbia pienamente padroneggiato le conoscenze insegnate in classe, posso presentare all'accademia una richiesta di esonero dai compiti per te. Naturalmente, questo non significa che approvi questo tipo di pigrizia che potrebbe condurti alla completa indolenza, ma finché continuerai a superare i miei test, non sono una vecchia pedante così rigida e non mi dispiacerebbe concedere ai miei studenti qualche privilegio.\nSe si tratta della seconda ipotesi, in qualità di tua tutrice principale, fidati: per quanto tu sia difficile da plasmare, troveremo una tecnica nell'ambito delle mie competenze per migliorare il tuo intelletto fin troppo arido e salvarti dalla penosa condizione di lottare contro l'ignoranza.\nQuesto pomeriggio alle quattro sarò agli archivi per valutare personalmente la tua padronanza delle conoscenze apprese in classe, quindi non fare tardi.\n\nDoll"
  },
  Mail_124770_Name = {
    Text = "Privilegi..."
  },
  Mail_124770_Sender = {Text = "Doll"},
  Mail_124771_Desc = {
    Text = "Cucciolo di Mythag:\n\nAnche quest'anno sei intrappolato in quelle solite routine quotidiane ripetitive: cacciarti nei guai, salvare il mondo, fare amicizia, imparare cose nuove e continuare a fabbricare un'illusione di normalità.\nA quanto pare, anche se dovessi estrarre il cervello dal corpo e distaccare il tuo intelletto da una dimensione all'altra, ciò non influirebbe minimamente sul tuo correre qua e là e sul tuo affaccendarti in modo assurdamente divertente.\nÈ davvero tutto frenetico e rumoroso, caro piccolo cucciolo.\nNon credi a quei fatti; insisti nel prolungare la loro sofferenza, nel trascinare ancora un po' il processo di estinzione. Qual è il tuo scopo? Stai davvero fingendo di essere sciocco, o gli esseri umani possono essere veramente così sciocchi? Anche se ho effettivamente dissezionato gli strati corticali del tuo cervello, questi restano un mistero per me.\nCongratulazioni, mi hai davvero scosso; comincio davvero a dubitare: se osservarti mi procura una gioia così immensa, può ancora tutto essere considerato privo di significato?\nProprio come quelle cose prive di significato in cui eccelli, prega senza significato, non importa chi sia l'oggetto della tua preghiera.\nPrego che tu possa sempre confinarmi, piccolo cucciolo, così che sia tu che io possiamo trovare un po' di gioia in questo mondo privo di significato.\n\n\"Doll\""
  },
  Mail_124771_Name = {Text = "Pregare"},
  Mail_124771_Sender = {
    Text = "Doll: Inferno"
  },
  Mail_124772_Desc = {
    Text = "Partner:\n\nScriverti ogni anno per il tuo compleanno sembra essere diventata una sorta di tradizione senza che me ne rendessi conto.\nRicordo ancora il primo compleanno in cui ti scrissi, quando mio padre acconsentì per la prima volta a lasciarmi organizzare la mia uscita di compleanno. Ti invitai a uscire con me e, da allora, abbiamo vissuto insieme tante prime volte.\nMolte cose sono cambiate da allora, ma se ci penso bene, sembra che non sia cambiato poi molto. Stiamo ancora percorrendo il cammino che abbiamo scelto, ancora l'uno al fianco dell'altra, e tu rimani il partner più importante per me.\nQuindi, anche se mio padre mi ha appena mandato una torta e mi ha chiesto se volessi partecipare al banchetto che sta organizzando per me stasera, ho altri piani.\nC'è un nuovo film uscito a Londinium, insolitamente popolare, ma l'accademia e l'associazione hanno già confermato che non sono coinvolte reazioni spirituali.\nQuesto indica che si tratta davvero solo di un'opera \"ordinaria\" estremamente brillante.\nMi trovo ad avere due biglietti, e puoi presumere che non ho fatto un'eccezione per disturbare Lady Sorel, dato che i suoi biglietti sono incredibilmente difficili da ottenere.\nQuindi, partner, saresti disposto a trascorrere questo tempo con me? Forse possiamo temporaneamente sfuggire alle situazioni straordinarie con cui abbiamo a che fare ogni giorno e goderci una serata \"normale\" insieme.\nOgni domani che verrà, quando ci sveglieremo, qualunque cosa accada nel mondo, la affronterò insieme a te.\n\nRamona"
  },
  Mail_124772_Sender = {Text = "Ramona"},
  Mail_124773_Desc = {
    Text = "Custode:\n\nGrazie al legame speciale tra me e quella versione di me stessa, così come al legame tra te e me, anche se non sempre posso essere al tuo fianco, ho una certa consapevolezza dei tuoi movimenti nell'ultimo anno.\nSei stato attivo in un altro mondo, apparentemente portando un cambiamento chiamato \"speranza\", e persino mentre scrutavo giorno dopo giorno il pozzo oscuro, questa energia, come un faro di luce, ha scaldato anche me.\nHo ricominciato a seguire la mia vecchia routine, ma a differenza di prima, non sto più affrontando l'inevitabile estinzione con una lotta vana. Mi hai insegnato qualcosa di nuovo: il processo con cui ogni esistenza si sforza con tutte le sue forze di continuare, fino alla fine destinata, è esattamente il motivo per cui civiltà, anima e volontà hanno un significato.\nPer quanto breve possa essere questo tempo per il mondo in cui vivo, continuerò a provarci. Anche se fosse solo per rivedere quei volti familiari e scambiare qualche parola, questo sforzo non è privo di significato.\nContinuerò a percorrere questo cammino finché tu non ti fermerai; permettimi la libertà di considerarlo un modo per camminare al tuo fianco, così che forse, nel tuo viaggio in corso, tu possa pensare a me di tanto in tanto, sempre impegnata a fare le stesse cose che fai tu.\n\n\"Ramona\""
  },
  Mail_124773_Sender = {Text = "\"Ramona\""},
  Mail_124774_Desc = {
    Text = "Uccidere il bersaglio è facile, ma gestire le conseguenze può essere una seccatura.\nOriginariamente avevo pianificato di seguire la tradizione dell'anno scorso e aiutarti a eliminare qualcuno anche quest'anno.\nTuttavia, ho notato che non hai usato l'ultimo regalo che ti ho fatto e, dopo un'attenta riflessione, mi sono reso conto che potrei aver trascurato qualcosa.\nPuoi stare tranquillo: sebbene di solito offra i miei servizi di eliminazione solo ai vecchi datori di lavoro, ho anche molta esperienza nel coprire le tracce per evitare ogni tipo di problema. Anche se la persona che vuoi uccidere è sotto la protezione di quelle complicate regole e ordinanze, non devi sentirti alcun peso psicologico; mi occuperò di tutto io.\nTe lo prometto, nessuno risalirà a te.\nUna volta che avrai deciso un candidato, fammi sapere il nome e, ovunque io sia, accorrerò per aiutarti a occupartene.\nBuone feste, e spero che tu provi gioia nel giorno della mia nascita, Custode.\n\n\nHelot"
  },
  Mail_124774_Name = {
    Text = [[
Chi uccide spesso sa
...]]
  },
  Mail_124774_Sender = {Text = "Helot"},
  Mail_124775_Desc = {
    Text = "Va bene, è chiaro che non hai intenzione di smettere con questo comportamento, e per quanto ne so, mi sono già abituata alla pratica del \"fare regali\".\nMa un giorno rimpiangerai questa buona volontà, credimi.\nRipensandoci, quella potrebbe essere la cosa che rimpiango di più. Dannazione, non avrei mai pensato di rimpiangere di aver ucciso qualcuno.\nNessuno sa meglio di me quanto siano inutili le cosiddette scuse, ma prima che quel giorno arrivi, farò del mio meglio per rimediare, semplicemente perché voglio farlo.\nQuando in futuro mi odierai per quello, non avrai bisogno di sentirti in colpa.\nAccetterò pienamente la tua ira.\n\nH"
  },
  Mail_124775_Name = {
    Text = "Te ne pentirai..."
  },
  Mail_124775_Sender = {
    Text = "Helot: catena"
  },
  Mail_124776_Desc = {
    Text = "Custode:\n\nÈ di nuovo quel giorno, il giorno della nascita, un giorno che dovrebbe essere celebrato per il dono della vita, eppure ogni volta che arriva, provo sempre una strana sensazione.\nLa mia nascita sembra essere stata concepita per inseguire la morte, e una volta che mi distacco da questo tema di morte, cosa significa davvero per me la vita... o la coscienza che continua in quell'istante?\nIn vita, il tormento del dolore e della colpa è così intricatamente intrecciato con la mia esistenza che sembra che la mia vita mi sia appartenuta davvero solo dopo l'arrivo della morte.\nL'anno scorso, quest'anno, e forse per ogni anno a venire. Mi è stata concessa una durata quasi infinita da sperimentare, in cui ogni giorno è simile eppure diverso dal precedente. Quando la vita non è più intrecciata con il dolore e lo scopo, che aspetto avrà la sua fine, o la cosiddetta fine arriverà mai davvero?\nQuesta proposizione è troppo vasta; la trovo in qualche modo incomprensibile.\nEppure il desiderio di annotare questi pensieri sconosciuti è così reale, e sento che la risposta sembra fin troppo evidente.\nAlmeno per me, sono questi momenti tangibili e preziosi, indipendentemente da quanto possano essere caotici i miei pensieri, o da quanto sia difficile trovare radici, so chiaramente dove possono andare alla deriva, dove possono essere accolti, e anch'io desidero ardentemente rivelarli a te.\nForse l'anno prossimo, in questo stesso periodo, riuscirò a trovare un significato più autoaffermante, ma per ora, spero di poter egoisticamente aggrapparmi a queste piccole dipendenze che solo tu e io conosciamo.\nSì, Custode, tu e tutti a Misag siete le radici nel mio cuore che nessun altro conosce.\nGrazie, come sempre; che tu possa essere sempre nella gioia, sempre in pace.\n\nNymphaea"
  },
  Mail_124776_Name = {Text = "Radici..."},
  Mail_124776_Sender = {Text = "Nymphaea"},
  Mail_124777_Desc = {
    Text = "Di recente ho inventato un nuovo modo per rilassarmi: lo chiamo il Pisolino del Regno divino.\nA differenza dei soliti pisolini brevi e frettolosi, durante un Pisolino del Regno divino lascio il Trono di Pietrablu su cui siedo a lungo, costruisco una sfera insonorizzata con i miei tentacoli e riempio l'intero spazio con acqua marina appositamente trattata.\nQuest'acqua marina non solo emana le fragranze che desidero e si trasforma nel paesaggio che voglio vedere, ma sostiene il mio corpo da ogni direzione con la giusta intensità.\nPertanto, qualunque posizione io assuma, posso sperimentare una sensazione calda e avvolgente, come se giacessi sulla trapunta di piume della più alta qualità.\nIn quel momento, posso rilassarmi nella mia fragranza preferita, godere della tranquillità dell'isolamento dal mondo e addormentarmi serenamente con il mio cuscino preferito.\nIn quanto mio suddito più favorito, credo che nel giorno del mio compleanno sia più che appropriato condividere questo momento di svago con te. Se sei interessato, puoi recarti nel luogo segreto che ho menzionato l'ultima volta. Non devi preoccuparti per la tua sicurezza; creerò uno spazio separato apposta per te, proteggendoti dal traboccare dei miei sogni.\nNon dimenticare di portare il tuo cuscino più comodo.\n\nTulu"
  },
  Mail_124777_Name = {
    Text = "Pausa Pranzo..."
  },
  Mail_124777_Sender = {Text = "Tulu"},
  Mail_124778_Desc = {
    Text = "Mia Luce Guida:\n\nCastor e io ci siamo adattati alla vita a Mythag. Dopo essere sfuggiti ai sanguinosi intrighi della Chiesa, sento di star ritrovando il mio vero io.\nSebbene tracce del \"Divus\" si mescolino inevitabilmente alle mie parole e azioni quotidiane, credo che non passerà molto prima che riesca a lavare via completamente quell'arroganza e quel distacco, conservando soltanto l'umiltà verso il divino e la determinazione a percorrere il cammino tracciato per me.\nDi recente ho ricevuto un regalo alquanto inaspettato: un libro splendidamente rilegato che racconta storie di chi torna nella propria città natale e riscopre la propria infanzia. Insieme al libro c'era un biglietto che recitava: \"Ti auguro di ritrovare presto il tuo vero io.\"\nNell'istante in cui i miei occhi si sono posati su quelle parole, sono affiorati ricordi del passato: le premure di tutti a Mythag, la tua guida e mio fratello... il caldo abbraccio.\nPer questo, quest'anno per il mio compleanno, vorrei invitare tutti quanti da Mythag a unirsi per festeggiare la festa di compleanno mia e di mio fratello. Senza l'aiuto di tutti, non avremmo mai avuto la possibilità di riappropriarci di quei momenti iniziali.\nHo prenotato un ristorante con i risparmi che ho accumulato di recente. Lo chef è esperto di cucine da tutto il mondo, e sono certo che ognuno troverà lì i sapori più familiari.\n\nPollux"
  },
  Mail_124778_Name = {
    Text = "Ritorno all'Infanzia"
  },
  Mail_124778_Sender = {Text = "Pollux"},
  Mail_124779_Desc = {
    Text = "Ho deciso di accettare l'invito di quell'arena sotterranea in periferia per combattere in un incontro all'ultimo sangue.\nSebbene le mie giornate al Club della Trota siano piacevoli, sono troppo monotone; ogni giorno non faccio altro che ammazzare pesci o ammazzare pesci. Forse ho davvero conquistato le trote, ma conquistare le trote non si può certo definire una conquista!\nIl sangue guerriero che scorre nelle mie vene ribolle; ha sempre anelato a una battaglia esaltante, e ora l'opportunità è arrivata.\nIl tizio pelato che mi ha contattato ha detto di avermi trovato tre pitoni Natai, due orsi dalla faccia demoniaca, quattro coccodrilli di Serinas e un mucchio di creature strane di cui non ricordo il nome—abbastanza da farmi massacrare tutta la notte.\nHo fatto appositamente organizzare l'incontro per oggi, così da poter dimostrare nel giorno del mio compleanno—io, Uvhash, l'ultimo guerriero romano, che conquista tutte le bestie feroci del mondo!\nOggi l'arena non sarà intrisa di scarti di trota, ma di sangue e carcasse di bestie esotiche e uccelli feroci!\n\nUvhash"
  },
  Mail_124779_Name = {
    Text = "Conquistare la Bestia"
  },
  Mail_124779_Sender = {Text = "Uvhash"},
  Mail_124780_Desc = {
    Text = "\"Cavaliere della Chiave d'argento\":\n\nCustode! Stavo giusto modificando la mia moto \"Phantom\" quando Mosk mi ha consegnato all'improvviso un grosso sacco di pezzi, dicendo che era un regalo di compleanno per me. È stato allora che mi sono ricordata che oggi è il mio compleanno!\nCosì ti ho scritto subito una lettera. Onestamente, com'è possibile che me lo sia dimenticata di nuovo? Ho già scritto... quanti biglietti ho scritto?\nMa niente di tutto questo ha importanza. L'importante è che mi sono ricordata cosa volevo fare per il mio compleanno: salirò sulla \"Phantom\" e porterò te e Mosk in giro per Londinium!\nAnche se Mosk non capisce nulla di meccanica, aveva così tanti pezzi in quel sacco che sono riuscita a raccogliere tutti i componenti necessari. La \"Phantom\" modificata è ora un prototipo super potenziato (per il momento)!\nHo chiamato questa avventura \"L'avventura di Nautila e del Custode con Mosk e la 'Phantom'.\" Che ne pensi? Non è chiaro e facile da ricordare? Così sicuramente non dimenticherò questa avventura.\nEheh, non vedo l'ora! Aspetta ancora un po', Custode, la \"Cavaliere Fantasma\" Nautila e la \"Cavaliere del Vortice\" Mosk arriveranno presto!\nSquadra avventuriera della \"Phantom\", si parte!\n\nNautila, che sfreccia verso di te a tutta velocità"
  },
  Mail_124780_Name = {
    Text = "Attacco \"Fantasma\"!"
  },
  Mail_124780_Sender = {Text = "Nautila"},
  Mail_124793_Desc = {
    Text = "All'Onorevole e Grande <Del: Adorabile>  {Male=Mr.,Female=Ms.} Custode:\n\nEhm, è passato un po' di tempo! Il nostro caro Custode ha sentito la mia mancanza?\nSei diventato una vera celebrità a Mythag! Tutti gli studenti studiano le tue gesta eroiche, e qualsiasi cosa anche solo vagamente associata a te spunta prezzi esorbitanti al mercato nero! Ma immagino sia naturale—dopotutto, chi altro è una \"leggenda vivente\" e l'unico Custode di Mythag se non tu?\nQuest'anno a Mythag sono successe un sacco di cose interessanti—Aurita ha fatto amicizia con alcuni Omini di Pan di Zenzero; la Professoressa Doll ha fatto saltare in aria diciassette laboratori nel tentativo di dare una rinfrescata alla sua vasca cerebrale; e Castor è stato ingannato da Agrippa e convinto a sostenere un esame al posto suo, solo per scoprire che era un test di Cultura Generale—ha ottenuto un punteggio più basso di quello che avrebbe preso lei!\nAh giusto, e quel topolino maledetto mi ha rubato la mia preziosa pellicola! Era lo scatto per cui avevo lavorato così duramente della Signorina 24 nella sua forma felina!\n\nA parte questo, c'è molto altro. Ho raccolto tutto in un'Edizione Speciale di Capodanno del giornalino scolastico e te l'ho spedita.\nCosa? Sei curioso di sapere come sono riuscita a contattarti? Hehe, è un segreto! Di sicuro non ti dirò che ho scambiato un mucchio di informazioni riservate esclusive con una certa signora dall'aspetto molto difficile da trattare!\nImpegniamoci insieme nel nuovo anno. Buon Anno Nuovo, %player%!\n\nHannah Peaslee"
  },
  Mail_124793_Name = {
    Text = "Speciale di Capodanno!"
  },
  Mail_124793_Sender = {
    Text = "Hannah Peaslee"
  },
  Mail_124794_Desc = {
    Text = "Pallido Messaggero:\n\nCon l'avvicinarsi della Vigilia di Argentogelo, permettimi innanzitutto di porgerti i miei più sinceri auguri.\n\nL'ultima volta che ho fatto visita ai bambini dell'Orfanotrofio di Lillian, alcuni di loro mi hanno chiesto in segreto: 'Babbo Natale esiste davvero?'\nEro curioso di sapere perché la pensassero così; se ricordo bene, ogni bambino ha ricevuto un regalo da 'Babbo Natale' l'anno scorso. A quanto pare, i bambini mi hanno detto: 'Ho visto quell'uomo affascinante consegnare i regali alla Direttrice Diana, non assomigliava per niente a Babbo Natale!'\nSembra che Lord Dexter sia stato avvistato dai bambini mentre consegnava i regali, generando questi piccoli dubbi.\n\nPertanto, per la Vigilia di Argentogelo di quest'anno, ho preparato due costumi molto tradizionali da Babbo Natale. Vorrei invitare te, Pallido Messaggero, a giocare il ruolo di Babbo Natale insieme a me e consegnare i regali a questi bambini.\nSono certo che alcuni bambini sbirceranno con gli occhi socchiusi durante la notte, ricorderanno la nostra immagine in vesti e cappelli rossi, e poi racconteranno entusiasti a tutti nel Giorno di Babbo Natale: 'Ho visto Babbo Natale!'\n\nHo preparato anche un regalo speciale per te. Spero che ti piaccia.\nBuon Solstizio.\n\nSalvador"
  },
  Mail_124794_Name = {
    Text = "Messaggero del Solstizio"
  },
  Mail_124794_Sender = {Text = "Salvador"},
  Mail_124991_Desc = {
    Text = "Caro Custode,\nL'evento \"Guarigione Molteplice: Replica\" è terminato. Ritireremo la valuta evento rimanente \"Puzzle della Memoria\" al tasso di cambio di 40 Rose Scritte per unità. Ricordati di controllare le tue ricompense."
  },
  Mail_124991_Name = {
    Text = "Puzzle della Memoria convertito"
  },
  Mail_124991_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_125448_Desc = {
    Text = "Caro Custode:\nL'evento \"Sussurri di Huangpu\" è terminato. Le rimanenti \"Caramelle allo Sciroppo di Pera\" saranno convertite al tasso di \"Rosa Scrip\" × 40 per oggetto. Ricordati di controllare le tue ricompense."
  },
  Mail_125448_Name = {
    Text = "Recupero Caramella allo Sciroppo di Pera"
  },
  Mail_125448_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_126321_Desc = {
    Text = "Gentile Custode:\nL'evento \"Bound Weaver\" è terminato. I Biglietti A-Reserve rimanenti sono stati convertiti al tasso di \"Rosa dorata\" × 40 per biglietto. Ricordati di controllare le tue ricompense."
  },
  Mail_126321_Name = {
    Text = "Conversione Biglietti A-Reserve"
  },
  Mail_126321_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_126934_Desc = {
    Text = "Custode,\n\nÈ di nuovo quel giorno speciale. Non preoccuparti—quest'anno non userò alcuna suggestione psicologica su di te. Desidero semplicemente invitare il mio paziente più speciale in un luogo tranquillo per cambiare aria.\nC'è una foresta rigogliosa, un fiume limpido e il respiro puro della natura—abbastanza da lavare via la stanchezza della giungla di cemento. Avremo tappeti morbidi, un focolare caldo, una luce soffusa—tutto per alleviare lo stress della vita cittadina.\nPotremo passeggiare, leggere, parlare di qualsiasi cosa. Qualunque cosa tu abbia in mente, ti ascolto.\nSolo a immaginarlo, il mio cuore batte più forte...\nSo che potresti sentirti a disagio in questo momento. Dopotutto, non posso prometterti che non assaporerò il dolce-amaro dei tuoi ricordi. Ma verrai comunque, vero?\nNon solo perché è il mio compleanno, ma perché hai bisogno di me. Hai bisogno di confidarti con me, hai bisogno del mio ascolto.\nBravo bambino. Capisco. E ti aspetterò. Lascia i tuoi doveri da parte, solo per un po'. Vieni, e condividi con me questo momento di pace.\n\nClementine"
  },
  Mail_126934_Name = {
    Text = "Un momento di pace"
  },
  Mail_126934_Sender = {Text = "Clementine"},
  Mail_126935_Desc = {
    Text = "Un altro giorno noioso.\nHo provato molte cose—banchetti tradizionali Filistei, giocare a giochi infantili con quelle bande di Londinium—nulla sembra degno di celebrare la nascita del Re dei Giganti.\nAi vecchi tempi, questo giorno significava baldoria e battaglia. Radunavo i guerrieri più forti dell'accampamento per combattere e celebrare questo grande giorno con forza e sangue.\nLa pace. Una pace noiosa, soffocante. Capisco il desiderio del tuo popolo per essa; non tutti hanno il cuore di un guerriero. Tuttavia, non credere che questa falsa pace possa offuscare la gloria di Golia il Re.\nUn giorno, riconquisterò tutto ciò che era mio—le mie terre, la mia ricchezza, il mio potere, la gloria eterna dei Perishita. E quando quel giorno arriverà, ti inviterò, Custode, a sedere alla mia destra come mio ospite d'onore, a guardare mentre il Re dei Giganti riconquista il suo trono.\nStavo per mettere fine a questo giorno noioso... finché non ho sentito che quelle bande disperse hanno formato un'alleanza. Hanno in programma di \"tendere un'imboscata\" al Re dei Giganti al banchetto di questa sera.\nRispetto alle guerre dei Perishita, è un semplice gioco da bambini. Eppure, in questi tetri tempi di pace, trovo tale spettacolo... rinfrescante.\nVieni a testimoniare ancora una volta la potenza di Golia in battaglia. Stai al mio fianco, o schierati contro di me. In ogni caso.\nMa fa' in fretta. Se arrivi troppo tardi, non resterà nulla da vedere se non i loro cadaveri.\n\nGolia"
  },
  Mail_126935_Name = {
    Text = "Lo spettacolo secondario"
  },
  Mail_126935_Sender = {Text = "Golia"},
  Mail_126936_Desc = {
    Text = "Caro Custode,\n\nSaluti.\nPer servire al meglio il corpo docente e gli studenti di Mythag, Erica ha effettuato un'automanutenzione e un aggiornamento di sistema alcuni giorni fa. Sei stato appositamente selezionato come valutatore per questo aggiornamento. La valutazione si svolgerà di persona e richiederà di verificare la funzionalità del Modulo Emotivo N. LY-S-761 appena installato nell'automa Erica. Il test dovrebbe durare circa 90 minuti; ti preghiamo di organizzarti di conseguenza per evitare conflitti di programma.\n\nCompiti di Valutazione:\n1. Intrattenere una conversazione aperta e approfondita con Erica per almeno 15 minuti sul tema del \"Compleanno\" per valutare l'ampiezza e la profondità della sua comprensione emotiva.\n2. Interagire con Erica in uno scenario simulato di \"Consegna di un Regalo\" per valutare l'accuratezza, la flessibilità e il livello di naturalezza del suo riconoscimento emotivo e delle sue risposte empatiche.\n3. Durante la seconda metà della sessione, menzionare intenzionalmente dettagli personali condivisi in precedenza da Erica (ad es., il suo atteggiamento o la sua percezione dei compleanni) per verificare se la sua memoria interattiva a lungo termine e le sue capacità associative funzionano correttamente.\n\nAl termine di quanto sopra, pronuncia la frase \"Erica, buon compleanno\" per concludere la valutazione. L'automa entrerà quindi automaticamente in modalità di caricamento dati.\nGrazie per la tua partecipazione. Al termine, Erica ti consegnerà uno speciale piccolo regalo. Ti preghiamo di continuare a supportare l'aggiornamento di Erica; la tua devotissima assistente, Erica, sarà sempre al tuo fianco.\n\nErica"
  },
  Mail_126936_Name = {
    Text = "Valutazione Potenziamento di Nascita"
  },
  Mail_126936_Sender = {Text = "Erica"},
  Mail_126937_Desc = {
    Text = "Hah! Ma che succede oggi? Ovunque vada, tutti mi evitano di proposito! Prima ancora che apra bocca, già agitano le mani lamentando mal di schiena o dolori alle spalle... come faccio a lanciare una sfida a duello in queste condizioni?\nÈ il mio compleanno—l'unico giorno in cui posso combattere qualcuno senza bisogno di scuse! Ma ora sembra un giorno noioso come tutti gli altri.\nTch. Forse non avrei dovuto picchiarli così forte l'anno scorso. Ma onestamente, cosa si aspettavano? Affilo la mia lama da prima che questo pianeta nascesse. È ovvio che la gente comune non possa reggere il confronto.\nMa tu—tu sei diverso. Tu sei il Custode!\nQuindi capisci dove voglio arrivare, giusto? Stesso posto dell'anno scorso. Facciamo un vero combattimento senza esclusione di colpi. Questa volta nessuno ci interromperà.\n\nLotan"
  },
  Mail_126937_Name = {
    Text = "Il mio unico Rivale"
  },
  Mail_126937_Sender = {Text = "Lotan"},
  Mail_126938_Desc = {
    Text = "Mio carissimo, amatissimo Padrone,\n\nAvete sentito? La residenza del sindaco ospita un ballo assolutamente stravagante stasera! Ogni gentiluomo e gentildonna in città farebbe follie per un invito.\nNaturalmente, essendo una cameriera, Karen non è esattamente nella lista degli invitati. Ma voi, il Custode dei Mythag—mio caro, adorato Padrone—meritate tutte le cose belle del mondo, incluso questo ballo!\nQuindi mi sono presa la libertà di accettare l'invito a nome vostro! Ho anche organizzato una carrozza e mi sono occupata di tutti i dettagli. Tutto quello che dovete fare è presentarvi con me alla tenuta del sindaco~\nIndosserò il mio vestito più elegante e i miei gioielli più scintillanti—tutti vedranno quanto è capace (e abbagliante!) la più grande cameriera del mondo! Vi renderò fiero di me!\nAh... quando leggerete questa lettera, dovrei già essere ad aspettarvi fuori dalla porta. La carrozza è qui, i servitori che consegnano il vostro nuovo abito e i vostri accessori sono pronti—ma c'è solo un piccolissimo problema... il pagamento non è ancora stato saldato...\nMa il mio più gentile, più dolce Padrone non si lascerà certo turbare da simili inezie, giusto? Il sindaco ci aspetta~\n\nLa vostra cameriera più carina e brillante,\nKaren"
  },
  Mail_126938_Name = {
    Text = "Il Gran Ballo"
  },
  Mail_126938_Sender = {Text = "Karen"},
  Mail_126940_Desc = {
    Text = "Custode! Custode!\nQualche giorno fa, Jenkin ha detto che ha trovato un posto che le ricorda la casa di Aurita—si chiama... ehm... acqua-qualcosa? Aurita ha dimenticato il nome.\nComunque! Jenkin ha detto che ci sarebbero delfini, pesciolini, meduse—tantissime meduse!—e tutti vogliono essere amici di Aurita!\nAurita adora gli amici! Aurita vuole tantissimi amici! Quindi per il mio compleanno, voglio invitare il mio amico preferito in assoluto—te, il Custode—a venire con me!\nSbrigati a preparare le tue cose! Aurita non ce la fa più ad aspettare!\n\nLa tua impaziente-di-fare-nuovi-amici,\nAurita"
  },
  Mail_126940_Name = {
    Text = "Nuovi amici all'acquario!"
  },
  Mail_126940_Sender = {Text = "Aurita"},
  Mail_126941_Desc = {
    Text = "Custode,\n\nGrazie per aver camminato con me lungo la riva nelle prime ore di oggi. Il fragore delle onde, il cielo stellato luminoso—mi hanno donato pace e mi hanno ricordato... cose di molto, molto tempo fa.\nAllora, all'equipaggio era proibito parlare con me, quindi per la maggior parte del tempo potevo solo contemplare il mare in continuo mutamento e i gabbiani che volteggiavano in alto. Quando i marinai osservavano quegli uccelli volare, inconsciamente esprimevano desideri rivolti a me.\nA volte desideravano diventare uccelli e volare a casa, tornare al fianco dei loro cari; a volte pregavano che il viaggio finisse presto così da poter scambiare il carico con ricchezze; a volte sognavano storie d'amore, o di incontrare una sirena o una creatura marina delle leggende...\nMa per quanto vari fossero i desideri, a mezzanotte diventavano tutti uguali: il desiderio di un sonno tranquillo. In quei momenti, esaudivo le loro preghiere—addolcendo il vento, placando le onde.\nQuindi, Custode, se fai fatica a dormire, ti prego, non vagare da solo lungo la riva all'alba. Vieni a cercare me, invece.\nVoglio condividere i tuoi fardelli, essere utile. E in questo momento, concederti un sonno tranquillo è ciò che posso fare.\nQuesto è anche... il \"desiderio\" che ho espresso in questo giorno speciale.\n\nCeleste"
  },
  Mail_126941_Name = {
    Text = "Ti auguro un sonno sereno"
  },
  Mail_126941_Sender = {Text = "Celeste"},
  Mail_126942_Desc = {
    Text = "Al Custode dell'Università di Mythag, mio saggio e benevolo signore,\n\nSaluti!\nHo esitato a lungo prima di scrivere queste righe, ma l'onestà è una virtù che ogni cavaliere deve rispettare. In quanto vostro cavaliere giurato, vi devo lealtà assoluta senza nulla di celato, perciò devo dirvi la verità.\nNel giorno del mio compleanno, mio signore, vi chiedo umilmente di venire nella mia stanza e leggermi una storia della buonanotte.\nVi prego, concedetemi... di avvicinarmi a voi e addormentarmi cullato da quei racconti onirici e meravigliosi che sapete narrare.\nA dire il vero, questo era uno dei miei desideri d'infanzia. Ma l'addestramento cavalleresco non ammette ozio, e da tempo ho superato l'età per simili cose, così ho seppellito quel desiderio nel profondo del cuore senza mai parlarne. Ma voi... mio signore, voi siete diverso. Non desidero nascondervi nulla.\nMio signore, se ritenete che ciò sia inappropriato, vi prego di dirmelo apertamente. Non parlerò mai più di una richiesta tanto ardita e raddoppierò invece i miei sforzi nell'addestramento.\nIn attesa di una vostra risposta.\n\nOgier"
  },
  Mail_126942_Name = {
    Text = "La richiesta di un Cavaliere"
  },
  Mail_126942_Sender = {Text = "Ogier"},
  Mail_126943_Desc = {
    Text = "Carbonella,\n\nOggi — Vortice — compleanno!\nAmico dice: \"Compleanno, scrivi lettera, Carbonella. E, Carbonella, vieni, giocare!\"\nVortice, non sa, scrivere lettera. Ma, amico, aiuta!\nAmico, insegna, Vortice! Vortice felice!\nVeramente... Vortice, dimenticato, compleanno.\nMa, Vortice, vuole giocare, Carbonella!\nQuindi, Vortice decide: Oggi, è compleanno!\nCarbonella! Raccolto conchiglie, oro, bianche, di tutti i tipi!\nVedere Carbonella — felice! Amico cucina — buonissimo!\nCarbonella, posto di sempre!\nAmico, prepara, grande pranzo! Noi tutti mangiamo!\nVortice aspetta te~\n\nVortice"
  },
  Mail_126943_Name = {
    Text = "Compleanno! Vieni a giocare!"
  },
  Mail_126943_Sender = {Text = "Vortice"},
  Mail_126944_Desc = {
    Text = "Custode,\n\nQualche giorno fa, hai detto che volevi esprimere un desiderio durante una pioggia di meteore, così ho organizzato appositamente questo viaggio. Grazie per aver accettato il mio invito. Come concordato, ti aspetterò puntuale sulla riva.\nStai tranquillo/a: sarà un breve viaggio. Ho esplorato a fondo le acque circostanti e ti guiderò in sicurezza fino al punto in cui cadono le meteore. Ti aiuterò a recuperare un meteorite.\nIn questo modo, potrai toccare una stella caduta con le tue mani ed esprimere il tuo desiderio a distanza così ravvicinata. Sicuramente una stella così vicina sentirà il desiderio del tuo cuore e lo esaudirà! Essere colui che ti guida a esprimere quel desiderio è una delle cose più speciali che abbia mai fatto. Mi sento profondamente onorato.\nGrazie ancora per avermi dato una nuova \"missione di navigazione\" in questo giorno speciale. Mi raccomando, vieni puntuale: ti aspetterò.\n\nCorposant"
  },
  Mail_126944_Name = {
    Text = "Un Desiderio a Portata di Mano"
  },
  Mail_126944_Sender = {Text = "Corposant"},
  Mail_129637_Desc = {
    Text = "Saluti.\n\nNon ricordo quante volte sono passata davanti alle aiuole dietro il campanile, ma una volta mi è capitato di notare il roseto al loro interno.\n\nDa allora, ho percorso questo sentiero molte volte — attraverso momenti in cui la Pozza Nera ribolliva d'inquietudine, attraverso ore di morte e scontro, e attraverso il mutare delle maree temporali. Eppure le rose restavano lì, fredde e silenziose, come sono sempre state.\n\nQuesta vista ha risvegliato un ricordo che non mi appartiene: un mazzo di rose che Ramona desiderava donarti. Per questo motivo, ho provato un lieve senso di pace.\n\nSebbene siamo separati dalle dimensioni, ho sempre creduto che, qualunque difficoltà tu debba affrontare, tu e quella \"Ramona\" rimarrete sempre calmi e impavidi, trovando un modo per spezzare lo stallo.\n\nDopotutto, non importa come cambi il mondo, le rose sbocciano sempre quando è il loro momento.\n\n\"Ramona\""
  },
  Mail_129637_Name = {
    Text = "Giardino di Rose..."
  },
  Mail_129637_Sender = {Text = "\"Ramona\""},
  Mail_129806_Desc = {
    Text = "Caro Custode,\n\nLe lanterne sono accese nella tenuta di Shencheng. Mi chiedo dove ti trovi in questo momento, e chi sia al tuo fianco.\n\nÈ l'inizio dell'anno — il giorno più importante dell'Impero Panlong, una festa per celebrare la riunione e la rinascita. Ho vissuto questo giorno molte volte, eppure non me ne stanco mai. L'inverno è passato, e ogni cosa cresce. Le persone sono colme di speranza; desiderano essere come questa terra — lasciarsi alle spalle tutte le macchie di ieri e abbracciare un nuovo inizio.\n\nCerto, vecchie ferite e desideri non si abbandonano così facilmente. \"Separarsi dal vecchio, accogliere il nuovo\" — che bel desiderio... Forse il dolore tornerà a crescere, e i desideri non svaniranno mai davvero, ma stasera, almeno per stasera, le persone alzeranno i calici. Celebrano un mondo nuovo, e un nuovo sé.\n\nCosì, al confine tra il vecchio anno e il nuovo, le persone accolgono la transizione con i fuochi d'artificio.\n\nTra tutte le cose interessanti, i fuochi d'artificio sono i miei preferiti. Tutti li guardano; li guardano bruciare, salire e sbocciare, alzando lo sguardo come verso un dio — contemplando quello splendore fugace e incomparabile.\n\nHai notato? Quando si ammirano i fuochi d'artificio, il cuore di ognuno è puro. Dimenticano l'odio, dimenticano la sofferenza, e dimenticano ogni lordura e miseria. Ogni cuore diventa un lago tranquillo, e su quella superficie incontaminata, c'è solo il bellissimo riflesso del fuoco.\n\nSssh... non chiedere cosa viene dopo i fuochi d'artificio. La rinascita può essere un lusso, ma non lasciare che questo ti faccia ignorare la fioritura.\n\nIn mezzo a tutta la bruttezza del mondo, i fuochi d'artificio sono la cosa più pura che esista. Stasera, desidero donare a te la mia parte.\n\nAlza lo sguardo, e non battere le palpebre. Guarda quelle stelle brillanti salire, e mentre i fuochi d'artificio sbocciano, accogli una nuova versione di te stesso, Custode.\n\n\"Qian Shan\""
  },
  Mail_129806_Name = {
    Text = "Fuochi d'artificio..."
  },
  Mail_129806_Sender = {Text = "Xu"},
  Mail_130223_Desc = {
    Text = "Stimato Custode:\n L'evento \"rinascita sottosopra\" è Terminato. La \"Polvere di Scaglie Pallide\", la \"Polvere di Scaglie Rosse\" e la \"Polvere di Scaglie Lucenti\" rimanenti del Custode sono state convertite al tasso di Rosa dorata × 40 per unità. Si prega di ricordare di controllare la posta."
  },
  Mail_130223_Name = {
    Text = "Recupero Polvere di Scaglie"
  },
  Mail_130223_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_131005_Desc = {
    Text = "Caro Custode:\nL'evento \"Richiamo del Moskstraumen\" è terminato. Le rimanenti \"Conchiglia Uno\", \"Conchiglia Due\" e \"Conchiglia Tre\" saranno convertite al tasso di \"Rosa Scrip\" × 40 per oggetto. Ricordati di controllare le tue ricompense."
  },
  Mail_131005_Name = {
    Text = "Recupero Conchiglia"
  },
  Mail_131005_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_131093_Desc = {
    Text = "Caro Custode,\nL'evento \"Banchetto delle Fiamme: Replica\" è terminato. Le rimanenti \"Tibia Originale\", \"Tornoceras\" e \"Rovine a Spirale\" saranno convertite al tasso di \"Rosa Scritta * 40\" per ogni oggetto. Ricordati di controllare le tue ricompense."
  },
  Mail_131093_Name = {
    Text = "Banchetto di Fiamme convertito"
  },
  Mail_131093_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_131767_Desc = {
    Text = "Io @2! @3 è @2 il Supremo @3 Caos @4 e Distruzione @2! Sia Gloria a @4...!\n\nOh no no no! Guarda cos'hai combinato!!! Hai toccato il TABÙ PROIBITO della Somma Divinità! E ora i Suoi sussurri riecheggiano in tutto il tuo mondo, e una catastrofe nera si sta già diffondendo dal tuo stesso dispositivo di comunicazione, inghiottendo tutto ciò che ti circonda...\n\nPovera creaturina. La tua imprudenza mi ha messo davvero in difficoltà. Ma non perdere ancora la speranza — perché per tua fortuna, tra tutte le persone in cui potevi imbatterti, ti sei imbattuto/a in ME.\n\nLa Fata del Sacro Ordine, Scelta Personalmente dal Divino in Persona, Unica e Sola Vera Voce del Sommo Signore, Legittima Erede del Gran Sacro Ordine, Salvatrice degli Sfortunati, Amica Personale del Re-Dio!\n\nPorto con me la volontà del Dio della Benevolenza e della Bontà, e proprio non sopporto vedere la gente soffrire. Ecco perché uso il mio incredibile e sconfinato potere per aiutare ogni piccolo sciocco combinaguai che si caccia in un pasticcio come questo.\n\nOh, sì, vedo quell'espressione sulla tua faccia. Va bene così. Il Dio della Benevolenza ama tutti, anche gli scettici. Non fidarsi subito del proprio Salvatore è del tutto normale, ormai è praticamente una tradizione. Considera questi piccoli doni di benvenuto come un segno personale di grazia da parte della Sua Rappresentante per te.\n\nOra ascolta bene, perché la via della salvezza è semplice:\n\nPrepara la tua sincerità, recati alla @2 Grande Cattedrale di @3, e offri la tua lealtà al Dio della Benevolenza — e otterrai il potere che hai sempre desiderato, e sarai liberato/a da questa orribile maledizione.\n\nAh, e porta anche i tuoi soldi.\n\nNon fraintendere! Il Dio della Benevolenza davvero non si cura delle cose mondane. Ma gestire un Sacro Ordine costa denaro, e i Suoi seguaci hanno conti da pagare come tutti gli altri. Non essere tirchio/a, caro/a credente.\n\nChi più spende, più ottiene.\n\nGrida il nome del Dio della Benevolenza, e attendi il tuo miracolo!\n\n—La Fata del Sacro Ordine, Scelta Personalmente dal Divino"
  },
  Mail_131767_Name = {
    Text = "Non Toccare Questo @2"
  },
  Mail_131767_Sender = {Text = "Caraboo"},
  Mail_132339_Desc = {
    Text = "Caro Custode:\nL'evento \"Il Ritorno del Sovrano: Replica\" è terminato. I tuoi \"Pensieri Esausti\", \"Riflessioni Malinconiche\" e \"Pensieri Gioiosi\" rimanenti saranno convertiti al tasso di \"Buono Rosa\" × 40 ciascuno. Ricorda di controllare il tuo inventario."
  },
  Mail_132339_Name = {
    Text = "Valuta Il Ritorno del Sovrano convertita"
  },
  Mail_132339_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_132458_Desc = {
    Text = "Caro Custode:\n        Grazie per il tuo supporto e il tuo apprezzamento verso [Morimens]. Per offrire ai Custodi una migliore esperienza di gioco all'Università di Mythag, ti invitiamo cordialmente a compilare il seguente sondaggio sull'esperienza. Come segno della nostra gratitudine, abbiamo preparato Argento × 200 come ricompensa, che potrai riscattare al completamento del sondaggio. Il sondaggio si chiude il 17 agosto alle 9:00. Assicurati di compilarlo in tempo.\n        <SurveyLink:[Click here to fill out]>\n        Prenderemo attentamente in considerazione il feedback di ogni Custode, e il tuo contributo aiuterà sicuramente a rendere l'Università di Mythag sempre migliore!\n        —Che la Chiave d'Argento Illumini il Cammino."
  },
  Mail_132458_Name = {
    Text = "Sondaggio Esperienza Versione V2.5.3"
  },
  Mail_132458_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_132578_Desc = {
    Text = [[
Gentile Custode:
Nella stagione "{s1}" di "Hectic Skybound Rail" hai ottenuto il titolo "{s2}".
Riceverai le seguenti ricompense bonus. Ricordati di riscuoterle.]]
  },
  Mail_132578_Name = {
    Text = "Ricompense Stagionali \"Hectic Skybound Rail\""
  },
  Mail_132578_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_132579_Desc = {
    Text = [[
Gentile Custode:
Nella stagione "{s1}" di "Traphase: Selezione Libera" hai ottenuto il titolo "{s2}".
Riceverai le seguenti ricompense bonus. Ricordati di riscuoterle.]]
  },
  Mail_132579_Name = {
    Text = "Ricompense Stagionali \"Traphase: Selezione Libera\""
  },
  Mail_132579_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_132580_Desc = {
    Text = [[
Gentile Custode:
Nella stagione "{s1}" di "Immersione Fantasmatica" hai ottenuto il titolo "{s2}".
Riceverai le seguenti ricompense bonus. Ricordati di riscuoterle.]]
  },
  Mail_132580_Name = {
    Text = "Ricompense Stagionali \"Immersione Fantasmatica\""
  },
  Mail_132580_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_132581_Desc = {
    Text = [[
Gentile Custode:
Nella stagione "{s1}" di "Traphase: Selezione Guidata" hai ottenuto il titolo "{s2}".
Riceverai le seguenti ricompense bonus. Ricordati di riscuoterle.]]
  },
  Mail_132581_Name = {
    Text = "Ricompense Stagionali \"Traphase: Selezione Guidata\""
  },
  Mail_132581_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_132605_Desc = {
    Text = "<Italic:CIP CIP CIP, cip cip cip CIP!>\n(Custode, Buon Pesce d'Aprile!)\n<Italic:Cip cip cip! CIP!>\n(Foto tessera!! Un ricordo!)\n\n*molte impronte di zampette bagnate di lontra in preda al panico*\n*un tentativo di sigillo in ceralacca fatto soprattutto di entusiasmo*\n*un'impronta di conchiglia storta, poi un'altra, poi una più piccola e più triste*\n\n—*un'impronta di zampetta di lontra marina estremamente attenta e super perfetta*"
  },
  Mail_132605_Name = {
    Text = "Un Batuffolo di Carta Fradicio"
  },
  Mail_132605_Sender = {Text = "Cip!"},
  Mail_133276_Desc = {
    Text = "Gentile Custode:\nL'evento \"The Great Conquering: Replica\" è terminato. I \"Barbecue Leoniani\" rimanenti saranno convertiti al tasso di 40 \"Rosa dorata\" per oggetto. Ricordati di controllare le tue ricompense."
  },
  Mail_133276_Name = {
    Text = "Grigliata Leoniana convertita"
  },
  Mail_133276_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_133703_Desc = {
    Text = "Gentile Custode:\n La versione {s1} è Terminata. I \"Nuclei Eterei\" rimanenti dei Custodi sono stati automaticamente convertiti al ritmo di 1 \"Nucleo Etereo\" per 1 \"Nucleo puro\". In totale sono stati convertiti \"Nucleo puro\" × {s2}. Si prega di verificare la ricezione."
  },
  Mail_133703_Name = {
    Text = "Avviso di conversione \"Nucleo etereo\""
  },
  Mail_133703_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_133704_Desc = {
    Text = [[
Gentile Custode:
 La versione {s1} sta per terminare. Si prega di utilizzare i "Nuclei Eterei" rimanenti prima della scadenza. Al termine del Curriculum di questo periodo, i "Nuclei Eterei" rimanenti dei Custodi verranno convertiti al ritmo di 1 "Nucleo Etereo" per 1 "Nucleo puro".]]
  },
  Mail_133704_Name = {
    Text = "Avviso di scadenza \"Nucleo etereo\""
  },
  Mail_133704_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_134024_Desc = {
    Text = "Gentile Custode:\nLa \"Missione Quotidiana\" è stata rimossa. I \"Certificati Delega\" rimanenti saranno convertiti al tasso di \"Rosa dorata\" × 10000 per certificato. Ricordati di controllare le tue ricompense."
  },
  Mail_134024_Name = {
    Text = "Riciclo Certificati Delega"
  },
  Mail_134024_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_134067_Desc = {
    Text = "Custode,\n\nC'è qualcosa di speciale di cui vorrei parlare con te oggi.\nVoglio semplicemente vagare per la città, guardando con curiosità ogni sorta di cose interessanti, andando dove mi pare—trascorrendo una giornata ordinaria.\n\nCosì sono andata a chiedere all'Ufficio Affari Accademici. Hanno detto che per motivi di sicurezza, posso lasciare il campus solo se mi accompagni tu.\nMi hanno anche detto di non spaventare nessuno, e di non mettere in bocca tutto quello che vedo mentre sono fuori. Che maleducati.\nBeh, è così. Quindi, potremmo uscire a fare una passeggiata insieme? Tutti noi, tutti quanti.\n\n...Per qualche ragione, mi è venuto in mente che i semi di tarassaco un giorno cavalcheranno il vento e partiranno per un viaggio verso qualunque sia il loro destino.\nForse sarà domani, o forse non sarà per molto, molto tempo.\nPensandoci, fare più cose insieme a tutti finché posso non sembra poi così male.\n\nComunque, ti aspetterò davanti al dormitorio. Per favore!\n\nSaya"
  },
  Mail_134067_Name = {
    Text = "Una passeggiata…"
  },
  Mail_134067_Sender = {Text = "Shaye"},
  Mail_134068_Desc = {
    Text = "Custode dei Segreti:\n\nSento che oggi è un giorno speciale. Eppure i contorni dei miei ricordi restano così sfocati.\nSolo il nome \"Saya\" riesce a malapena a tenermi legata a questo luogo.\n\nQuesta sensazione non è solitudine, né tristezza, non è un'emozione così vivida.\nSe proprio dovessi dare un nome a ciò che provo... probabilmente sarebbe \"vuoto\".\nNon c'è nulla, solo un tempo infinitamente limpido, trasparente e silenzioso.\n\nSe un giorno i semi di soffione, trasportati dal vento,\ncadessero semplicemente candidi e silenziosi in ogni angolo di questo mondo...\nAllora, forse, riuscirei finalmente a sentire che questo mondo è \"speciale\".\n\nIn quel momento, la nebbia grigia che avvolge Londinium, il rosso ardente del cielo al tramonto, e quel cielo che contemplavi sempre dalla piazza della scuola, tutto verrebbe ricoperto dai soffioni, tingendosi di un bianco puro. Del colore che mi appartiene.\n\nPerciò... se volessi donarmi qualcosa,\nnon serve che sia un regalo, basta solo un \"ricordo\".\n\nIo, nel mondo candido dove i soffioni sbocciano,\nattendo in silenzio l'arrivo di quel momento.\n\nQuando un giorno alzerai di nuovo lo sguardo al cielo nella piazza di Misagr,\nti prego, sovrapponi quel filo di lanugine bianca che sfiora il bordo del tuo campo visivo\nalla figura di me che un tempo ha parlato con te.\n\nSaya"
  },
  Mail_134068_Name = {
    Text = "La promessa del soffione…"
  },
  Mail_134068_Sender = {Text = "Shaye"},
  Mail_139809_Desc = {
    Text = "Caro Custode:\n        Grazie per il tuo supporto e riconoscimento di [Ere Oblivion's Dawn]. Al fine di offrire ai Custodi una migliore esperienza di gioco all'Università di Mythag, ti invitiamo sinceramente a compilare il seguente questionario di valutazione dell'esperienza. Come segno di apprezzamento per la tua collaborazione, abbiamo preparato Argento × 200 come ricompensa, che potrà essere riscossa al completamento del questionario. La scadenza del sondaggio è il 16 maggio alle 9:00. Assicurati di compilarlo in tempo.\n        <SurveyLink:[Clicca qui per compilare]>\n        Prenderemo attentamente in considerazione i suggerimenti di ogni Custode, e il tuo feedback contribuirà sicuramente a rendere l'Università di Mythag sempre migliore!\n        —Che la Chiave d'argento illumini il tuo cammino."
  },
  Mail_139809_Name = {
    Text = "Sondaggio esperienza versione V2.5.0"
  },
  Mail_139809_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_139927_Desc = {
    Text = "Caro Custode:\nL'evento \"Sinfonia Invisibile: Replica\" è Terminato. Le tue \"Vetta di Aria\" rimanenti sono state convertite al tasso di 40 × Rosa dorata ciascuna. Per favore, ritirali."
  },
  Mail_139927_Name = {
    Text = "Apice dell'Aria convertito"
  },
  Mail_139927_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_140084_Desc = {
    Text = "Gentile Custode:\nL'evento \"Un Milione di Soli Discendono: Replica\" è Terminato. Il \"Sigillo\" della Ricchezza\", il \"Sigillo\" del Banchetto di Sangue\" e il \"Sigillo\" della Guerra\" Rimanenti del Custode verranno convertiti al tasso di Rosa dorata × 40 per ciascuno. Si prega di controllare la posta."
  },
  Mail_140084_Name = {
    Text = "Recupero proiettili"
  },
  Mail_140084_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_140478_Desc = {
    Text = "Stimato Custode dei Segreti:\nL'evento \"Sorgente d'Amore\" si è concluso. Le inviamo le ricompense dell'evento che non ha ancora ritirato. La preghiamo di verificare la ricezione."
  },
  Mail_140478_Name = {
    Text = "Riemissione Ricompensa Flusso d'Infatuazione"
  },
  Mail_140478_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_140690_Desc = {
    Text = "Caro Custode,\nL'evento \"Quando la Neve si Scioglie: Replica\" si è concluso. Le valute evento rimanenti del Custode, \"Bocciolo Ghiacciato\", \"Bocciolo di Brina Argentea\" e \"Bocciolo di Luce Solare\", saranno riscattate al tasso di \"Rosa Scritta * 40\" ciascuna. Ricordati di riscuoterle."
  },
  Mail_140690_Name = {
    Text = "Germoglio convertito"
  },
  Mail_140690_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_140751_Desc = {
    Text = "Gentile Custode:\nL'evento \"Prima che la Primavera Svanisca: Replica\" è Terminato. I Poemi di Gioia, i Poemi di Dolore e i Poemi di Rimpianto Rimanenti del Custode verranno convertiti al tasso di Rosa dorata × 40 per ciascuno. Si prega di controllare la posta."
  },
  Mail_140751_Name = {
    Text = "Poema convertito"
  },
  Mail_140751_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_141372_Desc = {
    Text = "Gentile Custode:\nL'evento \"Ebwynnos Evermore\" è Terminato. Le \"Preda\" Fresca\", \"Preda\" Colossale\" e \"Preda\" Primordiale\" Rimanenti del Custode verranno convertite al tasso di Rosa dorata × 40 per ciascuna. Si prega di controllare la posta."
  },
  Mail_141372_Name = {
    Text = "Recupero valuta Ebwynnos Evermore"
  },
  Mail_141372_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_141470_Desc = {
    Text = "Gentile Custode:\nL'evento \"Prigioniero dello Specchio: Replica\" è Terminato. Il Manuale di Cultura Generale, il Manuale di Matematica e il Manuale di Letteratura Rimanenti del Custode verranno convertiti al tasso di Rosa dorata × 40 per ciascuno. Si prega di controllare la posta."
  },
  Mail_141470_Name = {
    Text = "Valuta Prigioniero riflesso convertita"
  },
  Mail_141470_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_141507_Desc = {
    Text = "Custode,\n\nPer te, forse, un compleanno è un giorno di grande importanza.\nPer me, ogni giorno sulla Tela del Destino ha lo stesso peso. Sono le altre storie a conferire significato a un giorno.\nSono nata in questo giorno, ho afferrato la profezia in questo giorno, ho ricevuto il fuso del destino in questo giorno, e in questo giorno ho visto gli intricati fili del destino... e gli incubi alla loro estremità.\nPer la Tessitrice del Destino, questo giorno non ha nulla di speciale. Per l'attrice sul palcoscenico, questo giorno merita di essere celebrato. E tra tutti i miei ruoli, quello che mi dona la gioia più grande è essere l'attrice stessa.\nCustode, stasera le luci del Teatro del Destino si sono tutte spente, tranne quelle di un palcoscenico splendidamente illuminato. Una volta hai detto che volevi vedere di più dei destini che ho vissuto. Ora, la storia che sta per svolgersi su questo palcoscenico parla di me stessa.\nNon so quale parte sarà. Ho inviato i miei ricordi sul palco, e lei sceglierà un momento — uno di quegli istanti intensi e vividi che desideri maggiormente vedere — da presentare stasera.\nLa storia potrebbe causarmi dolore, potrebbe farmi vergognare, ma non ha molta importanza, vero? Penso che, di tanto in tanto, sia un piacere lasciare che il fuso tessa da solo e limitarsi a essere una spettatrice.\nIl tuo biglietto per questo spettacolo esclusivo è ora nelle tue mani. Porta questa lettera e vieni da me, Custode. Stasera, una storia sconosciuta a chiunque altro ti attende.\n\nArachne"
  },
  Mail_141507_Name = {
    Text = "Una Storia nascosta"
  },
  Mail_141507_Sender = {Text = "Arachne"},
  Mail_141833_Desc = {
    Text = "Gentile Custode:\nL'evento \"Luna Nuova e Neve Profonda\" è terminato. Le \"Mele Cremisi\", \"Mele d'Oro\" e \"Mele Caramellate\" rimanenti del Custode verranno convertite al tasso di Rosa dorata × 40 per ciascuna. Si prega di controllare la posta."
  },
  Mail_141833_Name = {
    Text = "Recupero Mele"
  },
  Mail_141833_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_141957_Desc = {
    Text = "Gentile Custode:\n        Grazie per il tuo supporto e riconoscimento verso [Prima dell'Alba dell'Oblio]. Per migliorare l'esperienza di gioco dei Custodi all'Università di Mythag, ti invitiamo a compilare il seguente sondaggio sull'esperienza. Come ringraziamento per la tua collaborazione, abbiamo preparato Argento × 200 come ricompensa, che potrai ricevere al completamento del sondaggio. Il sondaggio scade il 15 febbraio alle 9:00; ti preghiamo di compilarlo in tempo.\n        <SurveyLink:[Clicca qui per compilare]>\n        Ascolteremo attentamente i suggerimenti di ogni Custode, e il tuo feedback contribuirà sicuramente a rendere l'Università di Mythag sempre migliore!\n        — Che la Chiave d'Argento illumini il tuo cammino."
  },
  Mail_141957_Name = {
    Text = "Sondaggio sull'esperienza di gioco V2.7.2"
  },
  Mail_141957_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_141958_Desc = {
    Text = "Gentile Custode:\n        Grazie per il tuo supporto e riconoscimento verso [Prima dell'Alba dell'Oblio]. Per migliorare l'esperienza di gioco dei Custodi all'Università di Mythag, ti invitiamo a compilare il seguente sondaggio sull'esperienza. Come ringraziamento per la tua collaborazione, abbiamo preparato Argento × 200 come ricompensa, che potrai ricevere al completamento del sondaggio. Il sondaggio scade il 21 dicembre alle 9:00; ti preghiamo di compilarlo in tempo.\n        <SurveyLink:[Clicca qui per compilare]>\n        Ascolteremo attentamente i suggerimenti di ogni Custode, e il tuo feedback contribuirà sicuramente a rendere l'Università di Mythag sempre migliore!\n        — Che la Chiave d'Argento illumini il tuo cammino."
  },
  Mail_141958_Name = {
    Text = "Sondaggio sull'esperienza di gioco V2.7.0"
  },
  Mail_141958_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_141959_Desc = {
    Text = "Gentile Custode:\n        Grazie per il tuo supporto e riconoscimento verso [Prima dell'Alba dell'Oblio]. Per migliorare l'esperienza di gioco dei Custodi all'Università di Mythag, ti invitiamo a compilare il seguente sondaggio sull'esperienza. Come ringraziamento per la tua collaborazione, abbiamo preparato Argento × 200 come ricompensa, che potrai ricevere al completamento del sondaggio. Il sondaggio scade il 18 gennaio alle 9:00; ti preghiamo di compilarlo in tempo.\n        <SurveyLink:[Clicca qui per compilare]>\n        Ascolteremo attentamente i suggerimenti di ogni Custode, e il tuo feedback contribuirà sicuramente a rendere l'Università di Mythag sempre migliore!\n        — Che la Chiave d'Argento illumini il tuo cammino."
  },
  Mail_141959_Name = {
    Text = "Sondaggio sull'esperienza di gioco V2.7.1"
  },
  Mail_141959_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_141960_Desc = {
    Text = "Gentile Custode:\n        Grazie per il tuo supporto e riconoscimento verso [Prima dell'Alba dell'Oblio]. Per migliorare l'esperienza di gioco dei Custodi all'Università di Mythag, ti invitiamo a compilare il seguente sondaggio sull'esperienza. Come ringraziamento per la tua collaborazione, abbiamo preparato Argento × 200 come ricompensa, che potrai ricevere al completamento del sondaggio. Il sondaggio scade il 15 marzo alle 9:00; ti preghiamo di compilarlo in tempo.\n        <SurveyLink:[Clicca qui per compilare]>\n        Ascolteremo attentamente i suggerimenti di ogni Custode, e il tuo feedback contribuirà sicuramente a rendere l'Università di Mythag sempre migliore!\n        — Che la Chiave d'Argento illumini il tuo cammino."
  },
  Mail_141960_Name = {
    Text = "Sondaggio sull'esperienza di gioco V2.7.3"
  },
  Mail_141960_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_141961_Desc = {
    Text = "Gentile Custode:\n        Grazie per il tuo supporto e riconoscimento verso [Prima dell'Alba dell'Oblio]. Per migliorare l'esperienza di gioco dei Custodi all'Università di Mythag, ti invitiamo a compilare il seguente sondaggio sull'esperienza. Come ringraziamento per la tua collaborazione, abbiamo preparato Argento × 200 come ricompensa, che potrai ricevere al completamento del sondaggio. Il sondaggio scade il 12 aprile alle 9:00; ti preghiamo di compilarlo in tempo.\n        <SurveyLink:[Clicca qui per compilare]>\n        Ascolteremo attentamente i suggerimenti di ogni Custode, e il tuo feedback contribuirà sicuramente a rendere l'Università di Mythag sempre migliore!\n        — Che la Chiave d'Argento illumini il tuo cammino."
  },
  Mail_141961_Name = {
    Text = "Sondaggio sull'esperienza di gioco V2.7.4"
  },
  Mail_141961_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_141962_Desc = {
    Text = "Gentile Custode:\n        Grazie per il tuo supporto e riconoscimento verso [Prima dell'Alba dell'Oblio]. Per migliorare l'esperienza di gioco dei Custodi all'Università di Mythag, ti invitiamo a compilare il seguente sondaggio sull'esperienza. Come ringraziamento per la tua collaborazione, abbiamo preparato Argento × 200 come ricompensa, che potrai ricevere al completamento del sondaggio. Il sondaggio scade il 10 maggio alle 9:00; ti preghiamo di compilarlo in tempo.\n        <SurveyLink:[Clicca qui per compilare]>\n        Ascolteremo attentamente i suggerimenti di ogni Custode, e il tuo feedback contribuirà sicuramente a rendere l'Università di Mythag sempre migliore!\n        — Che la Chiave d'Argento illumini il tuo cammino."
  },
  Mail_141962_Name = {
    Text = "Sondaggio sull'esperienza di gioco V2.7.5"
  },
  Mail_141962_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_142101_Desc = {
    Text = "È passato tanto tempo, %player%:\n\nQuando riceverai questa lettera, dovrei essere in volo sopra Agro, ogni anno in questo mese il mio viaggio di caccia si spinge sempre un po' più lontano.\nNon c'è niente di più adatto come colonna sonora per un compleanno delle urla e dei lamenti dei nemici, per di più ho preparato gabbie a sufficienza. Purché ci siano ancora degli stupidi disposti a venerare quei falsi dei che non portano altro che dolore senza alcuna Redenzione, fino ai confini del mondo li farò rendere conto dei loro errori.\nA volte, quando il Mara attraversa le nuvole e si riesce a vedere la Luna, qualche pensiero assurdo mi attraversa la mente in un lampo.\nCome ad esempio quando questo tempo si fermerà all'improvviso, in modo irresistibile e forzato, proprio come la vita un tempo è precipitata senza alcun preavviso.\nMa poi mi faccio ridere da sola: il giorno in cui vi ho messo piede, ho intrapreso un cammino senza via di ritorno. Sono certa che Tu capisca cosa intendo, piccolo. In questo mondo, non c'è nessuno che si trovi in una situazione più simile alla mia quanto la tua.\nEntrambi abbiamo scelto delle scelte che non erano scelte, e la buona notizia è che entrambi godiamo delle nostre scelte.\nNel nuovo anno, Purché Tu voglia suonare il fischietto da caccia che ti ho regalato, sarò ancora pronta ad apparire al tuo fianco in qualsiasi momento.\nNaturalmente, salvo imprevisti, lascia prima che mi goda appieno questo viaggio. Il mese prossimo ti porterò dei souvenir e qualche nuova storia.\nAuguro che tutto ti vada bene, auguro che Tu sia felice.\n\nIl tuo caro \"zio\""
  },
  Mail_142101_Name = {Text = "Notizie"},
  Mail_142101_Sender = {
    Text = "Il tuo caro \"zio\""
  },
  Mail_143935_Desc = {
    Text = "Stimato Custode:\nL'evento \"Suggested Translation\" è terminato. I tuoi \"Suggested Translation\", \"Suggested Translation\" e \"Suggested Translation\" rimanenti sono stati convertiti al tasso di 1 oggetto = \"Rosa dorata\" × 40. Ricordati di controllare e raccoglierli."
  },
  Mail_143935_Name = {
    Text = "Riciclo Testo Temporaneo"
  },
  Mail_143935_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_145435_Desc = {
    Text = "Caro Custode:\nL'evento \"Il Gioco del Leviatano\" è terminato. I \"Sacrificio Cremisi\" rimanenti sono stati convertiti al tasso di \"Rosa dorata\" × 40 per oggetto. Ricordati di controllare le tue ricompense."
  },
  Mail_145435_Name = {
    Text = "Conversione Sacrificio Cremisi"
  },
  Mail_145435_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_145468_Desc = {
    Text = "Caro Custode:\nL'evento \"Se la Vita Fosse Normale: Replica\" è terminato. Le \"Conchiglie sulla Riva\" rimanenti sono state convertite al tasso di \"Rosa dorata\" × 40 per oggetto. Ricordati di controllare le tue ricompense."
  },
  Mail_145468_Name = {
    Text = "Recupero Conchiglie della riviera"
  },
  Mail_145468_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_146401_Desc = {
    Text = "I calendari sono un'invenzione tediosa. Nessun giorno differisce dall'altro—oggi incluso.\nSecondo il tuo calendario, oggi è il giorno in cui sono nata. Anche se \"nata\" è a malapena la parola giusta per me. Sono un frammento strappato dal caos, una lama forgiata e affilata attraverso innumerevoli battaglie. Nessun grembo mi ha creata; sono stata plasmata da ogni avversario che abbia mai incrociato la spada con me. E tu—\ntu sei il più importante di tutti.\nLa tua gente tiene in grande considerazione giorni come questo. Banchetti, doni, auguri—non ne ho bisogno.\nHo bisogno solo di una battaglia.\nHai fatto cose straordinarie, in questi ultimi giorni. Ma so che ciò che hai mostrato è ben lontano dal tuo limite.\nAll'imbrunire di oggi, al campo di addestramento. Porta la tua arma; ti starò aspettando. Dimentica vittoria o sconfitta, vita o morte. Lo scontro senza riserve delle nostre lame è l'unico dono che desidero.\nMostrami di cosa è veramente capace un frammento di @4.\nPenso che mi sorprenderai, mio \"avversario\"."
  },
  Mail_146401_Name = {
    Text = "La Mia Unica Aspettativa"
  },
  Mail_146401_Sender = {
    Text = "Lotan: Cetarcon"
  },
  Mail_146873_Desc = {
    Text = "Stimato Custode:\nL'evento \"Suggested Translation\" è terminato. I tuoi \"Suggested Translation\", \"Suggested Translation\" e \"Suggested Translation\" rimanenti sono stati convertiti al tasso di 1 oggetto = \"Rosa dorata\" × 40. Ricordati di controllare e raccoglierli."
  },
  Mail_146873_Name = {
    Text = "Riciclo Testo Temporaneo"
  },
  Mail_146873_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_147081_Desc = {
    Text = "I calendari sono un'invenzione tediosa. Nessun giorno differisce dall'altro—oggi incluso.\nSecondo il tuo calendario, oggi è il giorno in cui sono nata. Anche se \"nata\" è a malapena la parola giusta per me. Sono un frammento strappato dal caos, una lama forgiata e affilata attraverso innumerevoli battaglie. Nessun grembo mi ha creata; sono stata plasmata da ogni avversario che abbia mai incrociato la spada con me. E tu—\ntu sei il più importante di tutti.\nLa tua gente tiene in grande considerazione giorni come questo. Banchetti, doni, auguri—non ne ho bisogno.\nHo bisogno solo di una battaglia.\nHai fatto cose straordinarie, in questi ultimi giorni. Ma so che ciò che hai mostrato è ben lontano dal tuo limite.\nAll'imbrunire di oggi, al campo di addestramento. Porta la tua arma; ti starò aspettando. Dimentica vittoria o sconfitta, vita o morte. Lo scontro senza riserve delle nostre lame è l'unico dono che desidero.\nMostrami di cosa è veramente capace un frammento di @4.\nPenso che mi sorprenderai, mio \"avversario\"."
  },
  Mail_147081_Name = {
    Text = "La Mia Unica Aspettativa"
  },
  Mail_147081_Sender = {
    Text = "Lotan: Cetarcon"
  },
  Mail_147535_Desc = {
    Text = "Stimato Custode:\nL'evento \"Suggested Translation\" è terminato. I tuoi \"Suggested Translation\", \"Suggested Translation\" e \"Suggested Translation\" rimanenti sono stati convertiti al tasso di 1 oggetto = \"Rosa dorata\" × 40. Ricordati di controllare e raccoglierli."
  },
  Mail_147535_Name = {
    Text = "Riciclo Testo Temporaneo"
  },
  Mail_147535_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_147798_Desc = {
    Text = "Gentile Custode:\n        Nell'aggiornamento V2.6.0 abbiamo risolto il problema della Ricompensa Nascosta mancante nell'Operazione H7-6 di Eredità Sbiadita. Poiché hai già Azzera H7-6 prima della correzione, ti invieremo direttamente le Ricompense Nascoste mancanti. Si prega di controllare la posta."
  },
  Mail_147798_Name = {
    Text = "Compensazione Ricompensa Nascosta H7-6"
  },
  Mail_147798_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_147875_Desc = {
    Text = "Gentile Custode:\n        Nell'aggiornamento V2.6.0 abbiamo risolto il problema della Ricompensa Nascosta mancante nell'Operazione H7-9 di Eredità Sbiadita. Poiché hai già Azzera H7-9 prima della correzione, ti invieremo direttamente le Ricompense Nascoste mancanti. Si prega di controllare la posta."
  },
  Mail_147875_Name = {
    Text = "Compensazione Ricompensa Nascosta H7-9"
  },
  Mail_147875_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_148080_Desc = {
    Text = "Gentile Custode:\n        Nell'aggiornamento V2.6.0 abbiamo migliorato le ricompense dei \"Potenziamenti Treno\". Per i Custodi che avevano già riscosso tutte le ricompense aggiuntive prima dell'aggiornamento, provvederemo a inviare le ricompense corrispondenti. Si prega di controllare la posta."
  },
  Mail_148080_Name = {
    Text = "Compensazione Ricompense Potenziamenti Treno"
  },
  Mail_148080_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_148081_Desc = {
    Text = "Gentile Custode:\n        Nell'aggiornamento V2.6.0 abbiamo migliorato le ricompense del \"Livello Immersione Profonda\". Per i Custodi che avevano già riscosso tutte le ricompense aggiuntive prima dell'aggiornamento, provvederemo a inviare le ricompense corrispondenti. Si prega di controllare la posta."
  },
  Mail_148081_Name = {
    Text = "Compensazione Ricompense Livello Immersione Profonda"
  },
  Mail_148081_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_148082_Desc = {
    Text = "Gentile Custode:\n        Nell'aggiornamento V2.6.0 abbiamo migliorato le ricompense del \"Livello Scelta Guidata\". Per i Custodi che avevano già riscosso tutte le ricompense aggiuntive prima dell'aggiornamento, provvederemo a inviare le ricompense corrispondenti. Si prega di controllare la posta."
  },
  Mail_148082_Name = {
    Text = "Compensazione Ricompense Livello Scelta Guidata"
  },
  Mail_148082_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_148083_Desc = {
    Text = "Gentile Custode:\n        Nell'aggiornamento V2.6.0 abbiamo migliorato le ricompense del \"Livello Scelta Libera\". Per i Custodi che avevano già riscosso tutte le ricompense aggiuntive prima dell'aggiornamento, provvederemo a inviare le ricompense corrispondenti. Si prega di controllare la posta."
  },
  Mail_148083_Name = {
    Text = "Compensazione Ricompense Livello Scelta Libera"
  },
  Mail_148083_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_148476_Desc = {
    Text = [[
Gentile Custode:
        Le ricompense ottenute tramite acquisto in "{s1}" non sono ancora state riscosso. Le ricompense non riscosso verranno inviate come allegato a questa email. Si prega di liberare spazio nell'inventario prima di riscuoterle.]]
  },
  Mail_148476_Name = {
    Text = "Ricompense non riscosse riemesse \"{s1}\""
  },
  Mail_148476_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_148477_Desc = {
    Text = [[
Gentile Custode:
        Le ricompense ottenute in "{s1}" non sono ancora state riscosso. Le ricompense non riscosso verranno inviate come allegato a questa email. Si prega di liberare spazio nell'inventario prima di riscuoterle.]]
  },
  Mail_148477_Name = {
    Text = "Ricompense non riscosse riemesse \"{s1}\""
  },
  Mail_148477_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_148478_Desc = {
    Text = [[
Gentile Custode:
        Le ricompense ottenute nel "Curriculum - Argomenti avanzati" del periodo {s1} non sono ancora state riscosso. Le ricompense non riscosso verranno inviate come allegato a questa email. Si prega di liberare spazio nell'inventario prima di riscuoterle.]]
  },
  Mail_148478_Name = {
    Text = "Compensazione Ricompense Non Riscosso Argomenti avanzati Periodo {s1}"
  },
  Mail_148478_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_148514_Desc = {
    Text = "Gentile Custode:\n        Nell'aggiornamento della versione V1.4.3.5, abbiamo aggiunto lo Stadio \"Nuovo Re\" in \"Paesaggio Onirico: Profanazione\". Poiché alcuni Custodi non erano stati informati tempestivamente di questo aggiornamento, hanno erroneamente ritenuto di aver completato interamente \"Paesaggio Onirico: Profanazione\".\n        A tal proposito, nell'aggiornamento della versione V2.6.2, abbiamo già recuperato il progresso di completamento dello Stadio \"Nuovo Re\" per i Custodi che avevano già Azzera gli Stadi successivi al \"Nuovo Re\" prima dell'aggiornamento, e abbiamo contestualmente inviato le relative ricompense per il primo completamento. Si prega di controllare la posta."
  },
  Mail_148514_Name = {
    Text = "Recupero Progressi \"Profanazione\""
  },
  Mail_148514_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_148515_Desc = {
    Text = "Caro Custode:\n\nTa-dà~ Sorprendente, vero? Questo è il primo compleanno di questa fatina su Mythag, quindi—\nEbbene! Nessuna email promozionale, nessun L'Invito alla messa, né tantomeno una Profezia di fine mondo~\nMa non deluderti, questa fatina ha naturalmente preparato qualcosa di più prezioso e migliore per i fedeli più speciali.\nEssendo una fatina madrina Onnisciente e Onnipotente, posso ovviamente prevedere quei dubbi e quelle diffidenze scontate, e sebbene ciò faccia sentire questa fatina un po' triste e dispiaciuta, per diffondere le benedizioni del culto, un piccolo Sacrificio è sempre inevitabile.\nQuindi, ti chiedo di fare un passo indietro e di provare — tanto non hai nulla da perdere, e se fosse vero? No?\nQuesta è un'opportunità che si presenta solo una volta all'anno, da non perdere in nessun caso~\nSenza bisogno di alcun Sacrificio, né di promesse o scambi, basterà semplicemente condividere un dolce pomeriggio con la fatina madrina, e potrai scoprire quanti sentimenti sinceri per te siano sepolti sotto la neve e il ghiaccio.\nNon è forse una proposta allettante?\nNota: assicurati di portare almeno 10, 100, 1000 Fiorino Leoniano sufficienti per pagare il conto — più ne hai, meglio è.\n\nIn La Veglia per te in quel locale che entrambi conosciamo,\nCaraboo"
  },
  Mail_148515_Name = {
    Text = "☆☆☆Email con Super Premi☆☆☆"
  },
  Mail_148515_Sender = {Text = "Caraboo"},
  Mail_149949_Desc = {
    Text = "Questa lettera ha circolato diecimila volte tra i regni dei vivi e dei morti. NON CANCELLARLA!\n\nNella quindicesima notte del settimo mese, il cancello dei fantasmi si spalanca, il vento freddo si alza, e le anime erranti tornano a casa.\nSono ███ della Città di Hu nell'antico Impero di Panlong—Yizhi Yè, artigiano dello Zhizha, piegatore di effigi di carta e offerte votive per i defunti, al vostro servizio!\n\nPer decreto del Festival dei Fantasmi dello Zhongyuan, recando il talismano-scritto evocatore di anime, poso questa maledizione su di te stanotte. Chiunque posi gli occhi su queste parole: la tua anima sarà iscritta nel registro, il tuo nome è già vergato sul libro mastro.\n\nE se non verrà trasmessa a cinquanta anime del mondo dei vivi prima dell'Ora di Zi, quando la notte vira a mezzanotte, tu certamente—\n\n...i tuoi documenti si corromperanno un attimo prima di essere salvati...\n...il tuo tè boba avrà per sempre tre perle in meno...\n...il tuo Comunicatore con Nucleo d'Argento rimarrà all'1% di batteria per tutta l'eternità—caricalo quanto vuoi, non si ricaricherà mai...\n\nSii un bravo bambino e fa' come ti viene detto: la maledizione si scioglierà da sola, il talismano brucerà se stesso in cenere, nessuno spirito vendicativo ti seguirà i passi, e la tua lampada della vita continuerà ad ardere.\n\nINOLTRALO!! ORA!!!"
  },
  Mail_149949_Name = {
    Text = "CANCELLA QUESTO, E TU..."
  },
  Mail_149949_Sender = {Text = "Yizhi Yè"},
  Mail_149985_Desc = {
    Text = "Mio Signore,\n\nSpero che questa lettera improvvisa non risulti presuntuosa. Eppure vi sono certi pensieri che posso confidare solo a te.\nIeri notte, ho fatto un sogno per la prima volta dopo molto tempo. In esso, sono tornato alla casa della mia infanzia. Tutto sembrava così familiare — le mani gentili e calde di mio padre, le canzoni popolari che la domestica canticchiava mentre spazzava, e quel pony bianco che era mio... Credevo fossero andati perduti da tempo nel fango della memoria, eppure rivederli nel sogno, erano caldi esattamente come allora.\nAl risveglio, ho visto gli insegnanti e gli studenti di Mythag chiacchierare pigramente mentre passavano fuori dalla finestra — così pacifici e sereni che, per un momento, ho sentito che la scena non era diversa da quella del mio sogno. Ho anche notato che la presenza invisibile che mi si aggrappa era insolitamente silenziosa da stamattina. Potrebbe essere che si incontri davvero un colpo di fortuna nel giorno del proprio compleanno?\nSe è davvero così, forse posso permettermi di essere un po' avido oggi......\nSo che le persone spesso esprimono desideri nei compleanni, come speranza per l'anno a venire. Ho smesso da tempo di osare sperare nei desideri di compleanno di qualcuno, eppure c'è una cosa che desidero davvero avere la possibilità di ricevere.\nProprio come tu mi hai affidato la tua fiducia, non ti nasconderò nulla. Quindi permettimi di condividere il mio desiderio con te:\nSe la prossima volta avrai una missione da assegnare, nominami come tua Scorta e lasciami accompagnarti.\nNon importa cosa accada, spero che ogni volta che avrai più bisogno di aiuto, sarò sempre il primo a starti davanti — per essere il tuo Scudo più saldo.\nQuesto è il desiderio che esprimo per quest'anno.\n\nOgier"
  },
  Mail_149985_Name = {
    Text = "Un Desiderio di Compleanno…"
  },
  Mail_149985_Sender = {
    Text = "Genesi: Ogier"
  },
  Mail_18019_Desc = {
    Text = "Gentile Custode,\nIl sistema ha rilevato un'azione di rimborso sull'account corrente. Il team di produzione ha detratto la valuta virtuale corrispondente al tuo ordine di rimborso il {s1}. Se il saldo mostra un valore negativo dopo la detrazione, è necessario ripristinarlo a un importo positivo prima di poter riprendere l'utilizzo normale.\nIn caso di domande, contatta il servizio clienti."
  },
  Mail_18019_Name = {
    Text = "Avviso di elaborazione rimborso"
  },
  Mail_18019_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_18020_Desc = {
    Text = "Ciao, Custode. La ricompensa da {s1} ti è stata inviata come allegato di posta poiché il tuo inventario era pieno. Per favore, libera spazio nell'inventario e riscuotila al più presto."
  },
  Mail_18020_Name = {
    Text = "Ricompense non riscosse riemesse"
  },
  Mail_18020_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_18021_Desc = {
    Text = "Caro Custode,\nl'evento Registro del Corso attuale terminerà il {s1} [GMT+8]. Le ricompense relative a questo Registro del Corso non saranno più disponibili dopo la fine dell'evento. Assicurati di riscuotere le tue ricompense prima della conclusione dell'evento."
  },
  Mail_18021_Name = {
    Text = "Promemoria per la raccolta della Ricompensa d'addestramento"
  },
  Mail_18021_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_18029_Desc = {
    Text = "Ciao, Custode, queste sono le tue ricompense di classifica ottenute durante l'Immersione Fantasmatica."
  },
  Mail_18029_Name = {
    Text = "Ricompense di classifica dell'Immersione Fantasmatica"
  },
  Mail_18029_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_18031_Desc = {
    Text = "All'Illustre Custode,\n\nMentre percorriamo insieme questo cammino irto di spine, la tua costante dedizione brilla come un faro per tutti noi. In riconoscimento dei tuoi instancabili sforzi, siamo lieti di fornirti la fornitura di Menofina appositamente assegnata per oggi. Possa questa offerta rafforzare la tua determinazione mentre prosegui il tuo lavoro fondamentale.\n\nChe il bagliore della Chiave d'argento illumini il tuo cammino attraverso le prove a venire, così come il tuo coraggio illumina la strada per gli altri.\n\nCon profonda gratitudine,  \nComitato dell'Università di Mythag\n\nP.S.: La distribuzione di questa fornitura speciale si è ora conclusa. Il tuo impegno incrollabile continua a ispirarci tutti."
  },
  Mail_18031_Name = {
    Text = "Distribuzione Rifornimento Intratecale"
  },
  Mail_18031_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_18034_Desc = {
    Text = "Ciao, Custode, hai ricompense cumulative non riscosse dall'Immersione Fantasmatica. Queste ricompense ti verranno ora distribuite come allegati di posta."
  },
  Mail_18034_Name = {
    Text = "Ricompense cumulative non riscosse per l'Immersione Fantasmatica"
  },
  Mail_18034_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_18035_Desc = {
    Text = "All'Illustre Custode,\n\nMentre percorriamo insieme questo cammino irto di spine, la tua costante dedizione brilla come un faro per tutti noi. In riconoscimento dei tuoi instancabili sforzi, siamo lieti di fornirti la fornitura di Menofina appositamente assegnata per oggi. Possa questa offerta rafforzare la tua determinazione mentre prosegui il tuo lavoro fondamentale.\n\nChe il bagliore della Chiave d'argento illumini il tuo cammino attraverso le prove a venire, così come il tuo coraggio illumina la strada per gli altri.\n\nComitato dell'Università di Mythag\n\nP.S.: La tua fornitura speciale approvata rimarrà valida per {s1} giorni. Pianifica di conseguenza il tuo programma di indagine."
  },
  Mail_18035_Name = {
    Text = "Distribuzione Rifornimento Intratecale"
  },
  Mail_18035_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_20231_Desc = {
    Text = "Caro Custode, la nuova stagione di Traphase è iniziata, reimpostando il tuo grado da {s1} a {s2}. Le ricompense di grado della nuova stagione sono state reimpostate. Puoi ottenere più onore e ricompense avanzando di grado! {s3}\n{s4}"
  },
  Mail_20231_Name = {
    Text = "Posta stagionale Traphase"
  },
  Mail_20231_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_21453_Desc = {
    Text = "Caro Custode,\n\nMi scuso per il disturbo, ma mi chiedevo come stessi ultimamente.\nMi scuso per l'interruzione dei tuoi impegni. Jenkin e gli altri stanno preparando una piccola festa di compleanno per me. Dopo averci pensato a lungo, ho deciso di inviarti personalmente questo invito.\nLa maggior parte degli orfani accolti dal laboratorio non ricorda la propria data di nascita, quindi la signorina Sarah stabilisce il giorno del nostro arrivo all'orfanotrofio come nostro compleanno. Tuttavia, il mio caso è diverso. La signorina Sarah mi ha raccontato che sono stata lasciata sulla soglia del laboratorio in una gelida notte d'inverno. Desiderava che la mia vita fosse piena di calore, così ha scelto un giorno caldo come mio compleanno. È un giorno che appartiene a me, un giorno colmo di premura e amore. È un giorno importante per me, e spero che tu, Custode, possa unirti a noi. È un mio piccolo desiderio. Naturalmente, non fa niente se non potrà essere esaudito, poiché tu, Custode, hai molte questioni di cui occuparti, e Aigis lo capisce.\nSe questo invito ti ha causato qualche inconveniente, ti prego di farmelo sapere e di accettare le mie sincere scuse. Tuttavia, se per caso riuscissi a trovare il tempo, sei il benvenuto a unirti alle loro marachelle—potrebbe essere molto divertente, visto che è tutto organizzato da Jenkin.\n\nAigis"
  },
  Mail_21453_Name = {
    Text = "Scusate il disturbo..."
  },
  Mail_21453_Sender = {Text = "Aigis"},
  Mail_21454_Desc = {
    Text = "Ehi,\n\nMi sono sempre chiesto cosa ci sia di così speciale nel festeggiare il proprio compleanno. Perché la gente ne fa un evento così importante?\nL'anno scorso, in questo giorno, una studentessa è venuta a chiedermi la mia data di nascita. Era ridicolo: quando sono nato, su questo pianeta non esisteva il concetto di tempo, figuriamoci i compleanni. Ma lei ha continuato a insistere finché non ho avuto altra scelta che dirle \"è quando il giorno e la notte sono uguali\". Non so ancora come l'abbia interpretato.\nTi scrivo questa lettera per ricordarti di raccogliere i fiori davanti alla mia porta dopo mezzanotte; sono troppi! \n\nLotan"
  },
  Mail_21454_Name = {
    Text = "Quei fiori..."
  },
  Mail_21454_Sender = {Text = "Lotan"},
  Mail_21455_Desc = {
    Text = "Erica oggi ha portato un grosso sacco di caffè come regalo di compleanno, dicendo che è la tua scorta annuale. <Del:Ma eri davvero disposta a farlo? Se no,>\n Se questo è uno scherzo di Doll o di qualcun altro, anche se mi dispiacerebbe, posso comunque restituirlo... Dopotutto, è caffè! Non riesco a funzionare senza qualche tazza. Un anno intero senza? Probabilmente dormiresti come Tulu. Non che lui sia un problema, è solo che le cose nere appaiono di notte... Comunque, se ti serve indietro, sentiti libera di riprenderlo in qualsiasi momento. Ma se lo lasci qui, <Del:io> sarei molto felice. Posso finalmente condurre l'esperimento che volevo fare: estrarre e concentrare la caffeina in un agente che possa essere assorbito attraverso la pelle, permettendomi di restare sveglia sempre, sempre...\n\n\nIn attesa di questo esperimento, Winkle"
  },
  Mail_21455_Name = {Text = "Caffè..."},
  Mail_21455_Sender = {Text = "Winkle"},
  Mail_21456_Desc = {
    Text = "Compleanno?\nSe proprio devo dirlo, il mio compleanno non è un bel giorno. Centinaia, persino migliaia di vite innocenti muoiono in questo giorno, solo perché io possa \"nascere\" e poi continuare a ucciderne altre.\nQuindi, non c'è davvero nulla da festeggiare. Ma capisco che voi umani tenete molto ai \"rituali\" e, guarda caso, ho del denaro a disposizione—stai tranquillo, sono soldi guadagnati onestamente con il sudore della fronte al Club della Trota, non proventi illeciti.\nPrendi questi soldi e comprati un regalo, come per festeggiare il mio compleanno.\n\nUvhash"
  },
  Mail_21456_Name = {
    Text = "Compleanno..."
  },
  Mail_21456_Sender = {Text = "Uvhash"},
  Mail_21457_Desc = {
    Text = "Custode, \n\n Esiste l'usanza di festeggiare i compleanni nei domini di Mythag? \n Nei ricordi della mia terra natale... ogni anno si tenevano grandi cerimonie per celebrare il compleanno del re. \n Col tempo, il significato speciale del \"compleanno\" fu esteso a tutti. \n In un passato lontano, in questo giorno, colleghi e amici percorrevano grandi distanze per essere al mio fianco. \n Quella sensazione di essere circondato dalle persone care... quel calore simile a un abbraccio del sole... forse è per questo che non riesco a lasciar andare il passato. \n Ah... sto divagando. Ho forse disturbato il tuo lavoro? \n Ho preparato del tè e degli spuntini che un tempo amavo gustare, e mi piacerebbe condividerli con te. \n Se lo desideri, vieni a cercarmi dopo cena. \n\nFaros"
  },
  Mail_21457_Name = {
    Text = "Luce immortale..."
  },
  Mail_21457_Sender = {Text = "Faros"},
  Mail_21458_Desc = {
    Text = "Oggi è davvero un giorno memorabile: il grande Lord Golia, Re dei Giganti, è arrivato; l'oceano ha tremato e le stelle si sono offuscate.\nHo sentito dire che le stravaganze non sono ammesse nel campus, quindi ridimensioniamo il mio banchetto di compleanno a un decimo del solito: dieci maiali arrosto, cento polpi alla griglia e una banda che suoni canzoni popolari di Golia. Ah, e fate venire una dozzina di danzatrici...\nCosa? Niente di tutto questo è permesso?\nAllora solo le danzatrici... Non una dozzina, quattro o cinque basteranno.\nCosa? Neanche quello è permesso?!\nStandard così miseri sono indegni del mio rango. Con la presente annuncio: il banchetto è cancellato!\n\nGolia"
  },
  Mail_21458_Name = {
    Text = "Preparativi per la Cena..."
  },
  Mail_21458_Sender = {Text = "Golia"},
  Mail_21459_Desc = {
    Text = "Custode—\n\nOggi, durante l'allenamento della memoria con la signorina Sylvia, mi ha chiesto del mio compleanno. Anche tu conosci il mio; se riesco a dimenticare in un secondo la chiave inglese che ho appena posato, come potrei mai ricordare un compleanno! E quel che è peggio, è qualcosa che solo io dovrei sapere—eppure non lo so! Questo compleanno è perduto.\n\nTuttavia, Padre Salvador ha detto che la data precisa non ha importanza. Ciò che conta è quello che festeggio ogni giorno. Così ho deciso—oggi sarà il mio compleanno! Ho già promesso a qualcuno (ho dimenticato chi fosse, ma non dovresti essere tu, Custode?) di organizzare una festa all'ingresso della mensa. Devi venire!\n\n\n\nQuesta data di compleanno la ricorderò di sicuro, Nautila.\n\n\n\nUna nota allegata alla lettera:\n\nQuesta bambina è corsa via subito dopo aver finito la lettera, lasciando sia la lettera che alcuni regali destinati a te sul tavolo.\nHo messo tutto nella busta. Non vedo l'ora di vederti alla festa stasera. Non preoccuparti—mi assicurerò che si presenti stasera.\n\n—Sylvia"
  },
  Mail_21459_Name = {
    Text = "Il compleanno che ho scelto!"
  },
  Mail_21459_Sender = {Text = "Nautila"},
  Mail_21460_Desc = {
    Text = "Piccolo mio, \n\nNel Mare dell'Essenza Primordiale non ci sono stelle né lune, e nemmeno stagioni. Pertanto, il mio compleanno dovrebbe essere registrato come [Unknown].\nTuttavia, oggi è davvero un giorno importante, dopotutto, questo aspetto è ereditato da un'umana che aveva un [Desiderio]. Amava le feste vivaci, così aprì questo piccolo negozio, ma a causa delle sue indagini, il suo compleanno veniva spesso condiviso solo con me. Per esaudire il suo ultimo desiderio, la Boutique delle Afflizioni terrà una cena a lume di candela oggi, invitando cordialmente tutti i clienti fedeli a partecipare.\nNaturalmente, la Boutique delle Afflizioni offrirà anche un piccolo sconto a tutti i visitatori, quindi non perdertelo, piccolo mio.\n\nDaffodil"
  },
  Mail_21460_Name = {
    Text = "Desideri terreni..."
  },
  Mail_21460_Sender = {Text = "Daffodil"},
  Mail_21461_Desc = {
    Text = "Quando fui portata via dalla mia famiglia, la mia madre adottiva... la moglie del Governatore frantumò il coccio di ceramica su cui erano incise le informazioni sulla mia nascita, distruggendo il mio passato di Tiria. Naturalmente, il mio vero compleanno non merita più di essere menzionato.\nDopo che ci siamo separati a Rye, ho riflettuto... Se considero la notte in cui sono fuggita dalla prigionia e ho iniziato la mia vendetta come il mio \"compleanno\", tu cosa ne pensi?\nAnche se non c'è più bisogno di commemorare un anno in più, non sembra male come promemoria del passare del tempo."
  },
  Mail_21461_Name = {
    Text = "Il giorno della Nascita"
  },
  Mail_21461_Sender = {Text = "Helot"},
  Mail_21462_Desc = {
    Text = "Test, test.\nCaro Custode, salve. Se hai ricevuto questa lettera, significa che il tuo contributo è fondamentale per Erica e che sei stato selezionato per partecipare al programma annuale di test e manutenzione del modulo linguistico dell'Automa Erica. La valutazione si svolge sotto forma di domande a risposta breve, in cui ti viene chiesto di fornire un riscontro sulla funzionalità del modulo linguistico EA-L-1033 appena installato nell'Automa Erica. Non ti porterà via molto tempo, quindi ti prego di non essere nervoso o in ansia.\nDomanda a risposta breve:\nHai compreso il senso di questa lettera?\n\nScrivi la tua risposta direttamente sotto la domanda a risposta breve e risigilla la lettera nella busta.\nGrazie per la tua partecipazione.\n\nErica"
  },
  Mail_21462_Name = {
    Text = "Test, test..."
  },
  Mail_21462_Sender = {Text = "Erica"},
  Mail_21463_Desc = {
    Text = "Custode, \n\n Sei uno dei pochi individui lucidi in questa scuola. Il tuo sguardo riesce a penetrare questo corpo imperfetto e vedere il vero me. \n Qualcuno come te dovrebbe essere in grado di spiegare chiaramente a quei ragazzi: non sono una sirena; questo corpo attraverserà i mari e scalerà le montagne, raggiungendo una forma perfetta. \n ...Lascia stare, non voglio disturbarti. Ma almeno oggi, non lasciarli giocare con la mia coda. \n Oggi è speciale. Se hai tempo, vorrei dirti qualcosa di persona. \n\nCaecus"
  },
  Mail_21463_Name = {
    Text = "Corpo perfetto..."
  },
  Mail_21463_Sender = {Text = "Caecus"},
  Mail_21464_Desc = {
    Text = "Custode,\n\nIl mio compleanno nel senso mondano è il giorno in cui mio padre mi ha adottata.\nIn passato, ha sempre dato grande importanza a questo giorno, organizzando ogni anno sontuosi balli in maschera—danzare con il corsetto era più estenuante che tirare tremila colpi di spada.\nMa era il suo modo di esprimere l'amore paterno, e non volevo deluderlo.\nQuest'anno, però, ha finalmente accettato di lasciarmi organizzare il mio compleanno come preferisco. Forse ai suoi occhi non sono più una bambina da tenere costantemente sotto controllo.\nA proposito, vorresti raggiungermi in cima alla torre dell'orologio? Potremmo chiacchierare e goderci la brezza.\nHo sentito dire che stanotte ci sarà la luna piena.\n\nRamona"
  },
  Mail_21464_Name = {
    Text = "Luna piena..."
  },
  Mail_21464_Sender = {Text = "Ramona"},
  Mail_21465_Desc = {
    Text = "Carissimo, amatissimo Padrone:\nSì, oggi è il compleanno di Karen@1 (l'età di una signora deve restare un segreto)! \nPer questa occasione speciale, Karen ha preparato una festa grandiosa senza pari e ha invitato tutti gli amichetti che poteva! Anche se alla fine solo Aurita, Ogier e Lily hanno potuto promettere di partecipare...\nMa non importa. Dove ci sono persone, ci sono feste, e dove ci sono feste, ci sarà Karen! Karen ha anche preparato con cura uno stufato di rane \"migliorato\", lumache di sanguinaccio all'aglio e zuppa di pipistrello al curry. Il Padrone deve assolutamente venire ad assaggiarli!\n\nUna domanda sussurrata: il Padrone ha sicuramente preparato un regalo per Karen, vero? Ricordi, deve essere luccicante!\n\nLa vostra sempre umile cameriera,\nKaren"
  },
  Mail_21465_Name = {Text = "Un Dono..."},
  Mail_21465_Sender = {Text = "Karen"},
  Mail_21466_Desc = {
    Text = "Caro <Del:Custode> Cucciolo-dell'Ovest:\nQuesto è un <Del:Inveteson Invitaten Invitate> comunque, ti sto invitando a venire a mangiare torta gratis e festeggiare il mio compleanno! È anche per ringraziarti di avermi aiutato a trovare mia sorella e di avermi portato qui, dando a Brown e a me un posto dove vivere.\n(Quello sopra è ciò che Aigis mi ha chiesto di scrivere—è così sdolcinato. Non abbiamo bisogno di queste cose tra noi, vero, Custode?)\nComunque, stasera nel cortile dietro il tuo dormitorio, io, Brown e Aigis abbiamo preparato delle cose buone, e ti aspettiamo per condividerle! Ovviamente, in realtà, è principalmente Aigis che ha cucinato, ed è davvero brava in cucina, le signore della cucina lodano il suo talento, non perdertelo o te ne pentirai.\n\nI tuoi vecchi amici Jenkin e Brown"
  },
  Mail_21466_Name = {
    Text = "Cari abitanti del Lato Ovest..."
  },
  Mail_21466_Sender = {Text = "Jenkin"},
  Mail_21467_Desc = {
    Text = "Custode,\n\nQuando le persone dimoravano ancora nel Regno divino, avevamo già iniziato a esprimere le nostre emozioni attraverso la danza—giri gioiosi, passi malinconici... Alcuni dicono che la storia della danza è lunga quanto quella dell'umanità; essa testimonia la nostra gloria e la nostra degradazione.\n\nUna volta dissi che non avrei più danzato, ma... sono nata per la danza, dopotutto. Quindi, solo per oggi, saresti disposto a danzare con me? A immergerti con me, sentendo il ritmo nel profondo del corpo.\n\nTi aspetterò nello studio di danza.\n\n\n\nLiz"
  },
  Mail_21467_Name = {
    Text = "Danziamo insieme"
  },
  Mail_21467_Sender = {Text = "Liz"},
  Mail_21468_Desc = {
    Text = "Caro Custode,\n\nPrima di diventare un Risvegliatore, il mio compleanno veniva festeggiato in segreto con i miei compagni, portando di nascosto da bere nella caserma e nascondendoci nella tenda delle provviste con il pane nero assegnato, festeggiando fino a quando gettavamo le bottiglie nell'erba prima di essere scoperti dall'ufficiale.\n\nMa Mythag non è l'esercito; qui possiamo concederci liberamente. Mi chiedo se ti piacerebbe condividere una bottiglia di Nettare d'Annata con me per festeggiare il mio compleanno? Se accetti, vieni sul tetto del dormitorio stasera quando la luna attraverserà la torre dell'orologio. Mi chiedo se hai notato che ha la vista migliore di tutto Mythag.\nAlva"
  },
  Mail_21468_Name = {
    Text = "Nettare pregiato..."
  },
  Mail_21468_Sender = {Text = "Alva"},
  Mail_21469_Desc = {
    Text = "Spiaggia! Spiaggia! Spiaggia! Spiaggia! \nEh? Scrivere il nome del destinatario all'inizio è una tale seccatura! Custode, tu non l'hai mai scritto sui biglietti del frigo!\nOggi è il compleanno di Aurita... ehm... quanti anni compie? Comunque, è il compleanno di Aurita!\nQuesti sono i tesori di Aurita! Tutti per te! Porta Aurita alla spiaggia, per favore, per favore, per favore!\nConsideralo un regalo di compleanno per Aurita, ok?\n\nAurita"
  },
  Mail_21469_Name = {Text = "Spiaggia!"},
  Mail_21469_Sender = {Text = "Aurita"},
  Mail_21470_Desc = {
    Text = [[
Caro Amico,

Durante il nostro tempo su quel pianeta ormai desolato, mia sorella e io ci abbracciavamo e traevamo energia dalla stessa pianta per commemorare la nostra nascita.
Quei giorni erano amari, ma ora portano gioia e calore.
Oggi ricorre di nuovo l'anniversario della nostra nascita. Se possibile, posso scambiare una canzone per un ramo?
Un dolce ramo che rappresenti mia sorella e me, e il nostro futuro con te...

Tintura]]
  },
  Mail_21470_Name = {
    Text = "Canzone di compleanno"
  },
  Mail_21470_Sender = {Text = "Tintura"},
  Mail_21471_Desc = {
    Text = "Per grazia del Fato, Custode dell'Università di Mythag, saggio e benevolo maestro:\nLa pace sia con te!\nQualche giorno fa, ho notato un carro entrare nelle stalle della scuola, con a bordo un cavallo a sangue caldo. Ho ricordato che durante la nostra ultima missione d'indagine, hai menzionato di non essere mai salito a cavallo. Una giovane e docile cavalla a sangue caldo è la più adatta per i principianti.\nCavalcare un destriero, inseguendo l'alba e il tramonto— questi sono tra i miei ricordi più cari. Se lo desideri, mi piacerebbe condividere questa gioia con te.\n\nOgier"
  },
  Mail_21471_Name = {
    Text = "Cavallo a sangue caldo..."
  },
  Mail_21471_Sender = {Text = "Ogier"},
  Mail_21472_Desc = {
    Text = "Il vecchio calendario differisce molto da quello in uso oggi a Londinium.\nSono nata nel quinto giorno di stella piena del secondo mese estivo. La decisione di festeggiare oggi si basa sui calcoli effettuati dal direttore del laboratorio.\nQuando l'antica nazione esisteva ancora, l'Alto Sacerdote si occupava di tutto. Dopo grandiose cerimonie, l'intera nazione festeggiava con sette giorni di festa.\nNon era un mio desiderio, ma non avevo motivo di impedire la diffusione della gioia.\nOggi non è un giorno festivo a Mythag, e in quanto Custode, non avrai giorni di riposo regolari.\nMa se chiedi un giorno libero per festeggiare il mio compleanno, dubito che la direzione avrà obiezioni.\nGoditi un pomeriggio di relax.\n\nTulu"
  },
  Mail_21472_Name = {
    Text = "Compleanno..."
  },
  Mail_21472_Sender = {Text = "Tulu"},
  Mail_21473_Desc = {
    Text = "Custode, \n\nAurita dice che chi compie gli anni deve sempre esprimere dei desideri. \nE io sono una che non esprime mai desideri. \nPerché i miei pensieri si avverano sempre. Non è fortuna; è più come... una guida del destino? \nProprio come il mese scorso, quando sono uscita in mare con Celeste, ho trovato \"per puro caso\" un bellissimo fossile. \nLa gente del posto lo chiama \"giglio di mare\". Le sue braccia ondeggiano come mulini a vento contro la corrente, godendosi pigramente il sole di un pomeriggio estivo. \nFragile, bellissimo. Quando l'ho visto, la tua immagine mi è venuta in mente spontaneamente. \nAnche questa volta non ho espresso un desiderio— \nTi piacerà sicuramente, vero? \n\nSanga"
  },
  Mail_21473_Name = {
    Text = "Giglio di mare..."
  },
  Mail_21473_Sender = {Text = "Sanga"},
  Mail_21475_Desc = {
    Text = "Custode,\n\nQuando navigavo con Elton, lui preparava un banchetto in questo giorno ogni anno e mi chiedeva di \"esprimere un desiderio\".\nPrima di venire qui, non capivo cosa fosse un \"desiderio\". Ora, non so cosa potrei desiderare...\nForse trovare un \"desiderio\" può essere il mio \"desiderio\"?\n\nCeleste"
  },
  Mail_21475_Name = {
    Text = "Desiderio..."
  },
  Mail_21475_Sender = {Text = "Celeste"},
  Mail_21476_Desc = {
    Text = "Custode, \n\n Aurita mi ha detto che puoi esaudire tutti i desideri espressi nei compleanni, è vero? \n Sicuramente non può essere vero, giusto? Esaudire i desideri di tutti sarebbe troppo impegnativo per te. \n Tuttavia, se potessi esprimere un desiderio... vorrei che Tintura avesse un palcoscenico più ampio. \n Sarebbe troppo difficile da realizzare? Hmm... Allora, che ne dici di cambiarlo in \"per il prossimo anno, niente sedano comparirà sulla mia tavola\"? È accettabile? \n\nFaint"
  },
  Mail_21476_Name = {
    Text = "Desiderio..."
  },
  Mail_21476_Sender = {Text = "Faint"},
  Mail_21477_Desc = {
    Text = "Caro Custode,\n\nLascia che ti confidi un segreto: questo compleanno non è reale. Quanto alla mia vera data di nascita... lasciamo che si disperda nel vento.\nDopo che mi ammalai, mio fratello faceva sempre preparare di nascosto una piccola torta dal maggiordomo per il mio compleanno.\nNiente canzoncine, niente auguri: festeggiare il compleanno sembrava qualcosa di cui vergognarsi.\nOra è tutto cambiato. Posso camminare alla luce del sole, cantare a voce alta e persino festeggiare il mio compleanno.\nPossono sembrare piccole gioie, ma mi riempiono di nostalgia.\nGrazie, Custode.\n\n(Naturalmente, se tu e tutti gli altri foste un po' più rudi, un po' più aggressivi... sarebbe perfetto.)\n\nLeigh"
  },
  Mail_21477_Name = {
    Text = "Un Segreto..."
  },
  Mail_21477_Sender = {Text = "Leigh"},
  Mail_21478_Desc = {
    Text = "Mio Piccolo Prigioniero,\n\nÈ passato così tanto, tanto, tanto tempo dall'ultima volta che ho brandito la frusta—\nIntrappolata in questa noiosa scuola, intrappolata in queste uniformi; il cuore di Pandia prude come un gattino dispettoso che graffia dentro. Ma nessuno mi capisce, e il personale fa di tutto per impedirmi di \"divertirmi\"—è così ingiusto!\nAh, oggi è un giorno speciale, perfetto perché la mia frusta tocchi ancora una volta la pelle morbida, perché io senta il canto del dolore... Se hai tempo oggi, perché non vieni a fare due chiacchiere con me~?\n\nPandia"
  },
  Mail_21478_Name = {
    Text = "Il suono della frusta..."
  },
  Mail_21478_Sender = {Text = "Pandia"},
  Mail_21479_Desc = {
    Text = "<Big:Spettacolo Anniversario del Mago Casiah, solo per oggi!>\n\nPer ringraziare il nostro pubblico per gli anni di supporto e incoraggiamento, e per ricambiare la gioia che ci avete donato, il Mago Casiah terrà uno spettacolo speciale per l'anniversario stasera alle 20:00 nel Cortile dell'Università di Mythag (accanto alla Statua di Phillips)! Stasera aspettatevi un palcoscenico ancora più sfavillante, numeri ancora più emozionanti e, soprattutto, magie ancora più straordinarie che vi lasceranno a bocca aperta! Persino il Cervello di Mythag resterebbe sbalordito da questa magia senza precedenti, garantito dal Maestro Casiah!\n\nNon perdete questo raro evento gratuito di stasera! Il Maestro Casiah vi aspetta!\n\n<Small:PS: Casiah non è responsabile per eventuali sintomi quali affaticamento o calo di energie durante o dopo lo spettacolo.>\n<Small:PPS: Qualsiasi promozione relativa al Cervello di Mythag è soggetta alle circostanze effettive. Casiah si riserva tutti i diritti di interpretazione del programma e dei suoi effetti.>"
  },
  Mail_21479_Name = {
    Text = "Lo spettacolo d'anniversario del Mago Supremo Casiah!"
  },
  Mail_21479_Sender = {Text = "Casiah"},
  Mail_21480_Desc = {
    Text = "Ehi, oggi è il mio compleanno. Dov'è il mio regalo?\nCosa? Ti sei dimenticato di prepararne uno...? Hmph, sapevo che sarebbe andata a finire così.\nTieni, prendi questo calendario. Sono chiaramente segnati il mio compleanno, il mio anniversario di morte, l'anniversario del primo giorno in cui sono arrivata a Mythag, così come la Festa della Gioia e la Festa del Raccolto... Li festeggeremo tutti insieme. Non dimenticarti la prossima volta!\n\nSe te ne dimentichi di nuovo... immagino che non ci sia molto che possa farti, hmph.\nMa non dimenticartene, d'accordo?\n\n- Agrippa"
  },
  Mail_21480_Name = {Text = "Ehi..."},
  Mail_21480_Sender = {Text = "Agrippa"},
  Mail_21481_Desc = {
    Text = "Custode,\n\nNon avevo mai avuto intenzione di scrivere questa lettera, ma qualcosa sembra essere andato storto con Erica. Il suo allarme non ha smesso di suonare da quando ho iniziato a scrivere questa lettera.\nUn compleanno è una data priva di significato per me; la percentuale di successo degli esperimenti non aumenta in questo giorno rispetto a qualsiasi altro, né il mio Indice Gnostico cambierà a causa di questa data. Eppure Ramona insiste nel rendere questo giorno il mio \"giorno libero\" e oggi mi ha limitato l'accesso al laboratorio.\nNon ho un posto dove andare, quindi oggi effettuerò una revisione approfondita dei tuoi rapporti passati.\nPer favore, passa dall'archivio dopo cena. Fai attenzione a non portare torta nell'archivio; i documenti cartacei sono molto fragili.\n\nDoll"
  },
  Mail_21481_Name = {
    Text = "Dopo Cena..."
  },
  Mail_21481_Sender = {Text = "Doll"},
  Mail_22435_Desc = {
    Text = "Caro Custode,\nInizialmente ho scelto di leggere poesie nella fioca luce mattutina del campus perché ho scoperto che in quel momento c'erano meno passanti, il che rendeva più facile immergermi nel mondo della poesia. In seguito, mi sono gradualmente innamorata del tenue bagliore del mattino, delle gocce di rugiada cristalline e del melodioso canto degli uccelli.\nCon mia sorpresa, molti insegnanti e studenti mi avevano osservata in silenzio e avevano fondato in segreto un club di poesia. Oggi è il mio compleanno, e coincide con la fioritura dei Narcisi nel club. Per l'occasione, hanno in programma di organizzare un incontro di apprezzamento poetico in cui potremo ammirare il paesaggio e recitare poesie insieme nel campus.\nSpero che ti unirai a noi per questa esperienza speciale.\n\nNymphaea"
  },
  Mail_22435_Name = {
    Text = "Invito alla lettura di poesie"
  },
  Mail_22435_Sender = {Text = "Nymphaea"},
  Mail_23897_Desc = {
    Text = "Caro Custode,\n      Nell'aggiornamento V1.0.21, abbiamo modificato le ricompense dell'\"Indagine\" in difficoltà ardua, i livelli di combattimento di \"Immersione nella Psiche\" in difficoltà Normale e Ardua, e le ricompense del primo completamento per ogni livello dell'Intervallo di Rotazione I-IV nel \"Reame Senza Luce\". Le modifiche dettagliate sono consultabili nell'\"Avviso di Manutenzione Online V1.0.21\".\n       In base ai tuoi progressi precedenti nelle indagini e nelle sfide, ti verranno assegnate le ricompense non ancora raccolte secondo le modifiche apportate. Consulta gli allegati."
  },
  Mail_23897_Name = {
    Text = "Compensazione bilanciamento V1.0.21"
  },
  Mail_23897_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_24199_Desc = {
    Text = "Caro Custode,\n       Nell'aggiornamento V1.0.24, abbiamo riaperto il Capitolo 5 dell'\"Operazione Indagine\", temporaneamente chiuso nella V1.0.16. Per garantire l'equità, emetteremo un compenso basato sulle modifiche alle ricompense e sui registri di indagine di ciascun Custode. In base ai tuoi registri, il tuo compenso è stato inviato in allegato."
  },
  Mail_24199_Name = {
    Text = "Compensazione riapertura Capitolo 5 V1.0.24"
  },
  Mail_24199_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_24200_Desc = {
    Text = "Caro Custode,\n       Nell'aggiornamento V1.0.24, abbiamo riaperto il Capitolo 5 dell'\"Operazione Indagine\", temporaneamente chiuso nella V1.0.16. Per garantire l'equità, emetteremo un compenso basato sulle modifiche alle ricompense e sui registri di indagine di ciascun Custode. In base ai tuoi registri, questa volta non è necessario alcun compenso."
  },
  Mail_24200_Name = {
    Text = "Compensazione riapertura Capitolo 5 V1.0.24"
  },
  Mail_24200_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_24202_Desc = {
    Text = "Caro Custode,\nGrazie per il tuo supporto e il tuo apprezzamento verso Morimens. Per offrirti un'esperienza di gioco migliore all'Università di Mythag, ti invitiamo a compilare il seguente sondaggio. Come segno della nostra gratitudine, abbiamo preparato [Silver*200] come ricompensa, che potrai riscuotere al completamento del sondaggio.\n<SurveyLink:[Click here to fill it out]>\nPrederemo in seria considerazione ogni suggerimento dei Custodi, e il tuo feedback renderà sicuramente l'Università di Mythag sempre migliore!\n—Che la Chiave d'argento illumini il tuo cammino."
  },
  Mail_24202_Name = {
    Text = "Sondaggio esperienza versione V1.0 Pt.2"
  },
  Mail_24202_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_24280_Desc = {
    Text = [[
Ciao, Custode,
hai raggiunto il "Grado {s1}" nell'indagine di ieri dell'Immersione Fantasmatica, classificandoti {s2}, con il titolo dell'indagine "{s3}". Di seguito le tue ricompense di classifica; ricorda di riscuoterle.]]
  },
  Mail_24280_Name = {
    Text = "Ricompense di classifica giornaliera dell'Immersione Fantasmatica"
  },
  Mail_24280_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_24877_Desc = {
    Text = "Custode,\n\nogni mio compleanno è sempre stato il più grandioso dei salotti, pieno di ospiti illustri e celebrazioni gioiose.\nMa questa volta ho un'idea diversa—\nSono rimasta seduta al posto dell'anfitriona per troppo tempo. Ogni tanto, voglio provare l'esperienza di essere un'invitata.\nChe si tratti di un altro salotto raffinato o di una semplice cena in famiglia, sta a te decidere. Che ne pensi?\nTuttavia, se scegli un altro salotto, non invitare quei membri dell'alta società.\nIn un giorno così raro e meraviglioso, non voglio indossare un sorriso finto.\n\n<Del:Dama in Rosso> Sorel"
  },
  Mail_24877_Name = {
    Text = "Sta a te..."
  },
  Mail_24877_Sender = {Text = "Sorel"},
  Mail_24878_Desc = {
    Text = "Padrone,\n\nOggi è il compleanno di Lily. Agrippa ha detto che voleva \"fare una grande scena.\"\nIn passato, la mamma e Lily festeggiavano i compleanni in modo diverso. La mamma mi metteva un cappellino a punta e insieme battevamo le mani e spegnevamo le candeline.\nLily non conosce il modo giusto di festeggiare. Per favore, datemi i vostri ordini, Padrone.\n\nLily"
  },
  Mail_24878_Name = {Text = "Turbato..."},
  Mail_24878_Sender = {Text = "Lily"},
  Mail_25147_Desc = {
    Text = "Caro Custode,\n       Nell'aggiornamento V1.1.0, le ricompense settimanali a punti dell'Immersione Fantasmatica sono state sostituite con la nuova \"Prova Settimanale\". Per garantire l'equità, compenseremo coloro che avevano sbloccato l'\"Immersione Fantasmatica\" ma non avevano riscosso tutte le ricompense settimanali a punti e che hanno effettuato l'accesso prima delle 5:00 del 15 gennaio, con le ricompense settimanali a punti non riscosse. Si prega di verificare."
  },
  Mail_25147_Name = {
    Text = "Compensazione ricompense settimanali Immersione Fantasmatica V1.1.0"
  },
  Mail_25147_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_25148_Desc = {
    Text = "Caro Custode,\n       Nell'aggiornamento V1.1.0, la \"Ricompensa Settimanale\" di Traphase (beta) è stata rimossa e sostituita con la \"Prova Settimanale\", che condivide gli stessi progressi e ricompense della \"Prova Settimanale\" dell'Immersione Fantasmatica. Per garantire l'equità, compenseremo i Custodi che avevano già sbloccato \"Traphase (beta)\" ma non avevano completato o riscosso la \"Ricompensa Settimanale\" di questa settimana, e che hanno effettuato l'accesso al gioco prima del 15 gennaio alle 5:00 (UTC+8), con 1.000 D-gemme. Controlla le tue ricompense."
  },
  Mail_25148_Name = {
    Text = "Compensazione ricompense settimanali Traphase V1.1.0"
  },
  Mail_25148_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_25414_Desc = {
    Text = "Caro Custode, \n\nIl significato di un compleanno varia per ognuno. Tuttavia, il compleanno di un Custode riveste grande importanza per tutto Mythag.\nLa Sig.ra Sylvia ha preparato una cena di compleanno per te nell'area del dormitorio. La Sig.ra Czort e Lord Dexter saranno presenti. Sapendo che la tua stanchezza mentale non si è ancora alleviata, ho preparato un abito formale per te, appeso nell'armadio vicino alla porta. Puoi indossarlo prima dell'evento.\nÈ un onore aver trascorso quest'anno con te come tua partner e spero di poterlo fare anche il prossimo anno.\nPossa la Chiave d'argento guidare il tuo cammino.\n\nP.S. Una torta personalizzata è stata consegnata al tuo dormitorio da Erica.\n\nSempre la tua partner, Ramona"
  },
  Mail_25414_Name = {
    Text = "Giorno di Nascita..."
  },
  Mail_25414_Sender = {Text = "Ramona"},
  Mail_34667_Desc = {
    Text = "Caro/a @1@2, \n\nIl mondo ha dimenticato il tuo nome.\nPertanto, io ti risveglio, come tu hai risvegliato me. Prima che l'Avvento giunga, camminiamo, testimoniamo, e poi ricordiamo e dimentichiamo.\nOggi è il giorno della tua nascita, una pagina dai Frammenti di Memoria sparsi del tuo passato. Ecco i miei sospiri e le mie benedizioni.\nCosa penserai quando il mondo ricorderà la tua forma completa? O continuerai a non sapere e non sentire nulla?\nAttendo la tua risposta nella Terra dell'Inesistenza.\n\n@2"
  },
  Mail_34667_Name = {
    Text = "Giorno di Nascita..."
  },
  Mail_35231_Desc = {
    Text = "Caro Custode,\nGrazie per il tuo supporto e il tuo apprezzamento verso Morimens. Per offrirti un'esperienza di gioco migliore all'Università di Mythag, ti invitiamo a compilare il seguente sondaggio. Come segno della nostra gratitudine, abbiamo preparato [Silver*200] come ricompensa, che potrai riscuotere al completamento del sondaggio.\n<SurveyLink:[Click here to fill it out]>\nPrederemo in seria considerazione ogni suggerimento dei Custodi, e il tuo feedback renderà sicuramente l'Università di Mythag sempre migliore!\n—Che la Chiave d'argento illumini il tuo cammino."
  },
  Mail_35231_Name = {
    Text = "Sondaggio esperienza versione V1.1 Pt.1"
  },
  Mail_35231_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_35956_Desc = {
    Text = "Caro Custode,\n  Grazie per il tuo supporto e il tuo apprezzamento verso Morimens. Per migliorare la tua esperienza di gioco all'Università di Mythag, ti invitiamo sinceramente a compilare il seguente sondaggio. Come segno di gratitudine, abbiamo preparato [Silver*200] come ricompensa, che potrai riscuotere al completamento del sondaggio. La scadenza del sondaggio è il 22 febbraio alle 5:00. Assicurati di compilarlo entro i termini.\n   <SurveyLink:[Click here to fill out]>\n   Valuteremo attentamente il feedback di ogni Custode. Il tuo contributo renderà senza dubbio l'Università di Mythag ancora migliore!\n   —Che la Chiave d'argento illumini il tuo sentiero."
  },
  Mail_35956_Name = {
    Text = "Sondaggio esperienza versione V1.1 Pt.2"
  },
  Mail_35956_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_36228_Desc = {
    Text = "Caro Custode,\n  Grazie per il tuo supporto e il tuo apprezzamento verso Morimens. Per migliorare la tua esperienza di gioco all'Università di Mythag, ti invitiamo cordialmente a compilare il seguente sondaggio. In segno di gratitudine, abbiamo preparato [Silver*200] come ricompensa, che potrai riscuotere al completamento del sondaggio. Il sondaggio si chiuderà il 17 giugno alle ore 9:00. Ti preghiamo di compilarlo entro i tempi previsti.\n   <SurveyLink:[Click Here to Fill Out]>\n   Considereremo con attenzione il feedback di ogni Custode, e i tuoi suggerimenti contribuiranno senza dubbio a rendere l'Università di Mythag ancora migliore!\n   —Che la Chiave d'Argento illumini il tuo sentiero."
  },
  Mail_36228_Name = {
    Text = "Sondaggio esperienza versione V1.4.1"
  },
  Mail_36228_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_36229_Desc = {
    Text = "Caro Custode,\n  Grazie per il tuo supporto a Morimens. Per migliorare la tua esperienza all'Università di Mythag, ti invitiamo a compilare il seguente sondaggio. In segno di gratitudine, offriamo [Silver*200] come ricompensa al completamento. Il sondaggio si chiuderà l'8 luglio alle ore 9:00. Ti preghiamo di compilarlo entro i tempi previsti.\n   <SurveyLink:[Click Here to Fill Out]>\n   Apprezziamo il feedback di ogni Custode, che contribuirà certamente a migliorare l'Università di Mythag!\n   —Che la Chiave d'Argento illumini il tuo sentiero."
  },
  Mail_36229_Name = {
    Text = "Sondaggio esperienza versione V1.4.3"
  },
  Mail_36229_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_36230_Desc = {
    Text = "Caro Custode, \n Grazie per il tuo supporto a [Morimens]. Per migliorare la tua esperienza all'Università di Mythag, ti invitiamo a compilare il seguente sondaggio. In segno di gratitudine, offriamo [Silver*200] come ricompensa al completamento del sondaggio. La scadenza per la compilazione è il 2 settembre alle ore 9:00. Ti preghiamo di inviarlo entro i tempi previsti.\n   <SurveyLink:[Click here to fill out]>\n   Apprezziamo profondamente il feedback di ogni Custode. I tuoi suggerimenti contribuiranno senza dubbio a migliorare l'Università di Mythag!\n   —Che la Chiave d'Argento illumini il tuo sentiero."
  },
  Mail_36230_Name = {
    Text = "Sondaggio esperienza versione V1.5.3"
  },
  Mail_36230_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_36231_Desc = {
    Text = "Caro Custode,\n  Grazie per il tuo supporto a Morimens. Per migliorare la tua esperienza all'Università di Mythag, ti invitiamo a compilare il seguente sondaggio. In segno di gratitudine, offriamo [Silver*200] come ricompensa al completamento. Il sondaggio si chiuderà il 5 agosto alle ore 9:00. Ti preghiamo di compilarlo entro i tempi previsti.\n   <SurveyLink:[Click Here to Fill Out]>\n   Apprezziamo il feedback di ogni Custode, che contribuirà certamente a migliorare l'Università di Mythag!\n   —Che la Chiave d'Argento illumini il tuo sentiero."
  },
  Mail_36231_Name = {
    Text = "Sondaggio esperienza versione V1.5.1"
  },
  Mail_36231_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_36232_Desc = {
    Text = "Caro Custode, \n Grazie per il tuo supporto a [Morimens]. Per migliorare la tua esperienza all'Università di Mythag, ti invitiamo a compilare il seguente sondaggio. Come segno della nostra gratitudine, offriamo [Silver*200] come ricompensa al completamento. Il sondaggio si chiude il 18 maggio alle 9:00. Ti preghiamo di compilarlo entro i termini.\n   <SurveyLink:[Click Here to Fill Out]>\n   Diamo valore al feedback di ogni Custode, che contribuirà sicuramente a migliorare l'Università di Mythag!\n   —Che la Chiave d'argento illumini il tuo sentiero."
  },
  Mail_36232_Name = {
    Text = "Sondaggio esperienza versione V1.3 Pt.2"
  },
  Mail_36232_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_36233_Desc = {
    Text = "Caro Custode, \n Grazie per il tuo supporto a [Morimens]. Per migliorare la tua esperienza all'Università di Mythag, ti invitiamo a compilare il seguente sondaggio. Come segno di gratitudine, offriamo [Silver*200] come ricompensa al completamento del sondaggio. La scadenza per l'invio è il 25 aprile alle 9:00. Assicurati di completarlo entro i termini.\n   <SurveyLink:[Click here to fill out]>\n   Diamo valore al feedback di ogni Custode. Il tuo contributo aiuterà a migliorare l'Università di Mythag!\n   —Che la Chiave d'argento illumini il tuo sentiero."
  },
  Mail_36233_Name = {
    Text = "Sondaggio esperienza versione V1.3 Pt.1"
  },
  Mail_36233_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_36234_Desc = {
    Text = "Caro Custode, \n Grazie per il tuo supporto a [Morimens]. Per migliorare la tua esperienza all'Università di Mythag, ti invitiamo a compilare il seguente sondaggio. Come segno di gratitudine, offriamo [Silver*200] come ricompensa al completamento del sondaggio. La scadenza del sondaggio è il 14 marzo alle 5:00. Assicurati di compilarlo entro i termini.\n   <SurveyLink:[Click here to fill out]>\n   Diamo valore al feedback di ogni Custode. Il tuo contributo aiuterà senza dubbio a migliorare l'Università di Mythag!\n   —Che la Chiave d'argento illumini il tuo sentiero."
  },
  Mail_36234_Name = {
    Text = "Sondaggio esperienza versione V1.2 Pt.1"
  },
  Mail_36234_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_36235_Desc = {
    Text = "Caro Custode, \n Grazie per il tuo supporto a [Morimens]. Per migliorare la tua esperienza all'Università di Mythag, ti invitiamo a compilare il seguente sondaggio. Come segno di gratitudine, offriamo [Silver*200] come ricompensa al completamento del sondaggio. La scadenza per l'invio è il 4 aprile alle 9:00. Assicurati di completarlo entro i termini.\n   <SurveyLink:[Click here to fill out]>\n   Diamo grande valore al feedback di ogni Custode. Il tuo contributo aiuterà senza dubbio a migliorare l'Università di Mythag!\n   —Che la Chiave d'argento illumini il tuo sentiero."
  },
  Mail_36235_Name = {
    Text = "Sondaggio esperienza versione V1.2 Pt.2"
  },
  Mail_36235_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_36865_Desc = {
    Text = "Caro Custode,\n       Nell'aggiornamento V1.2.4, abbiamo modificato le ricompense della Prova Settimanale dell'\"Immersione Fantasmatica\" e non includeranno più \"D-gemme\", \"Cristalli Mimetici\" e \"Buoni Rosa\" tra le ricompense. Per garantire l'equità, compenseremo i Custodi che avevano sbloccato l'\"Immersione Fantasmatica\" prima dell'aggiornamento ma non avevano riscosso completamente le ricompense della prova settimanale, con le \"D-gemme\", i \"Cristalli Mimetici\" e i \"Buoni Rosa\" originali non riscossi. Questo compenso sarà disponibile per coloro che effettueranno l'accesso prima dell'11 marzo alle 5:00. Controlla le tue ricompense."
  },
  Mail_36865_Name = {
    Text = "Compensazione per adeguamento ricompense Prova Settimanale V1.2.4"
  },
  Mail_36865_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_36866_Desc = {
    Text = "Caro Custode,\n       Nell'aggiornamento V1.2.4, completando le fasi dell'\"Immersione Fantasmatica\" \"Sangue e Sabbia\", \"Nucleo Distorto\" e \"Il Desiderio del Cavaliere\" in modalità Normale si sbloccano nuovi Accompagnatori: \"Sangue e Sabbia Ruggenti\", \"Eternità Effimera\" e \"L'ultimo voto\". Per i Custodi che avevano già completato questi capitoli in modalità Normale prima dell'aggiornamento, invieremo gli Accompagnatori corrispondenti come compensazione. Vi preghiamo di controllare le vostre ricompense."
  },
  Mail_36866_Name = {
    Text = "Riemissione Squadra Psyche Deepdive V1.2.4"
  },
  Mail_36866_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_36867_Desc = {
    Text = "Caro Custode,\n       Nell'aggiornamento V1.2.4, la quantità di materiali unici per il potenziamento delle abilità e di Cristalli Mimetici ottenibili dal \"Dominio Arcano\" è stata aumentata. Per ragioni di equità, per i Custodi che hanno riscosso le ricompense settimanali del \"Dominio Arcano\" prima dell'aggiornamento, invieremo Cristalli Mimetici equivalenti al valore dell'incremento delle ricompense in base al livello raccomandato delle ricompense ricevute. Vi preghiamo di controllare le vostre ricompense."
  },
  Mail_36867_Name = {
    Text = "Compensazione per adeguamento ricompense Dominio Arcano V1.2.4"
  },
  Mail_36867_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_36871_Desc = {
    Text = "Cari Custodi,\nIn base alla difficoltà più alta superata nell'\"Immersione Fantasmatica\" di ieri, riceverete le seguenti ricompense. Ricordate di controllare il vostro inventario."
  },
  Mail_36871_Name = {
    Text = "Ricompense giornaliere Immersione Fantasmatica"
  },
  Mail_36871_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_39293_Desc = {
    Text = "Caro Custode,\n       Nell'aggiornamento V1.2.7, completando l'Immersione Fantasmatica \"Scultura Melodica\", \"Discendente Pallido\" e \"A un passo\" in modalità Normale si sbloccano nuovi Accompagnatori: \"Abbraccio Corrosivo\", \"Sguardo sul Lago\" e \"Porta della Retrospezione\". Per i Custodi che avevano già completato questi capitoli in modalità Normale prima dell'aggiornamento, invieremo come compensazione gli Accompagnatori corrispondenti. Vi preghiamo di controllare le vostre ricompense."
  },
  Mail_39293_Name = {
    Text = "Riemissione Squadra Psyche Deepdive V1.2.7"
  },
  Mail_39293_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_39548_Desc = {
    Text = "Caro Custode,\n\nPer chi vive in eterno, celebrare un compleanno sembra superfluo. Rispetto al fiume infinito del tempo, i ricordi che voi umani definite indimenticabili o meravigliosi appaiono piuttosto... insignificanti.\nEppure avete inventato innumerevoli feste e celebrazioni per commemorare questi momenti \"insignificanti\" — e naturalmente, questo è anche uno dei motivi che stuzzicano la mia curiosità. Siete davvero adorabili.\nTuttavia, il nostro incontro non può certo essere annoverato tra quei momenti \"insignificanti\", perché tu sei diverso da loro... E che tipo di tempesta questa \"differenza\" scatenerà in futuro, non vedo l'ora di scoprirlo.\nBene, ti prego di perdonare le mie divagazioni... Dato che oggi è il mio compleanno, chiedo di esercitare i \"Diritti del Festeggiato\".\nQuanto a ciò che ho bisogno che tu faccia, shh... non essere impaziente, la risposta si trova nella mia camera da letto. Vieni da solo a mezzanotte, stanotte.\n\nWanda"
  },
  Mail_39548_Name = {
    Text = "Il Privilegio della Stella del Compleanno..."
  },
  Mail_39548_Sender = {Text = "Wanda"},
  Mail_39549_Desc = {
    Text = "Oggi è il compleanno della Signorina Murphy—i compleanni meritano una festa e una celebrazione! \nLe persone del reparto logistico si sono date da fare, ma proprio non sanno come organizzare una sorpresa e hanno cercato di nascondere tutto—la Signorina li ha visti piazzare le decorazioni per la torta nel magazzino del Dipartimento di Studi sul Risveglio già da un pezzo. Hmm... non punirai quei dipendenti, vero? Hanno fatto davvero un ottimo lavoro; solo che non sono stati bravi a nascondere la sorpresa...\nMi fermo qui; sembra che qualcuno mi stia cercando fuori—è meglio che non provino a ricoprirmi di stupidi coriandoli colorati.\nA proposito, ci sarai quando taglieremo la torta, vero?\n\nMurphy"
  },
  Mail_39549_Name = {
    Text = "Banchetto di Compleanno..."
  },
  Mail_39549_Sender = {Text = "Murphy"},
  Mail_43571_Desc = {
    Text = [[
Caro Custode,
       Nell'aggiornamento V1.2.10, sono state aggiunte nuove ricompense alle missioni [Big Smoke Chronicle]: [Silver*1000] per [Complete the main investigation Chapter 1 "East District's Enigma" on Hard] e [Complete the main investigation Chapter 2 "Waxen Legacy" on Hard]. Per coloro che hanno riscosso queste ricompense delle missioni prima dell'aggiornamento, invieremo [Silver] come compensazione. Vi preghiamo di controllare.]]
  },
  Mail_43571_Name = {
    Text = "Riemissione ricompensa Cronaca Big Smoke V1.2.10"
  },
  Mail_43571_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_43821_Desc = {
    Text = "Caro Custode,\n       Nell'aggiornamento V1.3.0, le fasi 1/2/3/4/5/6 del \"Rapporto Missione\" hanno aggiunto ricompense in EXP Custode pari rispettivamente a 500/1000/1500/2000/2500/3000. Per i Custodi che avevano già riscosso le ricompense di queste fasi prima dell'aggiornamento, invieremo la compensazione corrispondente. Vi preghiamo di controllare le vostre ricompense."
  },
  Mail_43821_Name = {
    Text = "Riemissione EXP Rapporto Missione V1.3.0"
  },
  Mail_43821_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_44571_Desc = {
    Text = "Caro Custode, \nL'evento [Pastore dell'anima] si concluderà alle 9:00 del 18 aprile [GMT+8]. Al termine dell'evento, gli accessi corrispondenti verranno chiusi, inclusi la Via Sacrosanta e la Vendita di Beneficenza della Chiesa. I Coupon di Beneficenza non utilizzati entro la scadenza scompariranno automaticamente. Assicurati di acquistare gli oggetti nella Vendita di Beneficenza della Chiesa prima della fine dell'evento."
  },
  Mail_44571_Name = {
    Text = "L'evento Pastore dell'anima sta per terminare"
  },
  Mail_44571_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_44690_Desc = {
    Text = [[
Ciao, Custode,
hai svolto lavoro sul campo durante l'Immersione Fantasmatica di ieri con il titolo dell'indagine "{s1}". Di seguito le tue ricompense di classifica; ricorda di riscuoterle.]]
  },
  Mail_44690_Name = {
    Text = "Ricompense di classifica dell'agenzia dell'Immersione Fantasmatica"
  },
  Mail_44690_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_44831_Desc = {
    Text = "Caro Custode,\n       Nell'aggiornamento V1.3.0, completando il Registro Operazioni Speciali \"Fantasma della Città Piovosa\", \"Tributo alla Rosa\" e \"La Magia delle Storie\" in modalità Normale si sbloccano nuovi Accompagnatori: \"Verità Dietro la Nebbia Grigia\", \"Vittoria delle Rose\" e \"Visione di Mezza Estate\". Per i Custodi che avevano già completato questi capitoli in modalità Normale prima dell'aggiornamento, invieremo gli Accompagnatori corrispondenti come compensazione. Vi preghiamo di controllare le vostre ricompense."
  },
  Mail_44831_Name = {
    Text = "V1.3.0 Riemissione Posse del Registro Operazioni Speciali"
  },
  Mail_44831_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_44836_Desc = {
    Text = "Caro Custode,\n       Nell'aggiornamento V1.3.0, sono state aggiunte nuove ricompense per il raggiungimento di 1 vittoria e 3 vittorie nella Prova Settimanale dell'\"Immersione Fantasmatica\": \"Certificato di Procura\"*1. Per i Custodi che avevano già riscosso queste ricompense prima dell'aggiornamento, invieremo il numero corrispondente di \"Certificati di Procura\" come compensazione. Vi preghiamo di controllare le vostre ricompense."
  },
  Mail_44836_Name = {
    Text = "V1.3.0 Riemissione ricompense sfide settimanali"
  },
  Mail_44836_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_44837_Desc = {
    Text = "Onorevole Pallido Messaggero:\n\nAlcuni bambini mi hanno portato oggi dei bouquet e dei dolci, ricordandomi che oggi, oltre un centinaio di anni prima dell'era del Calendario Post-Diluvio, ricevetti la grazia dell'Onnipotente e venni al mondo. Quanto tempo fa! I ricordi d'infanzia sono ormai sbiaditi; solo il profumo dell'incenso della Chiesa di Bendoza persiste nella mia mente, rifiutandosi di dissolversi. E ora, anche se la chiesa fosse ancora in piedi, la ricetta dell'incenso non è più quella di un tempo.\n\nMi scuso; la malinconia non è lo scopo di questa lettera. Ho preparato una pausa per il tè con i dolci portati dai bambini, sperando che possiate venire a condividerla con me — non per celebrare il mio compleanno, ma per celebrare ogni giorno di esistenza, per onorare la presenza della vita in ogni giornata.\n\nMi chiedo quando sia il vostro compleanno? Vi prego, non mancate di dirmelo dopo una tazza di tè.\n\n\n\nSalvador"
  },
  Mail_44837_Name = {
    Text = "Pallido Messaggero..."
  },
  Mail_44837_Sender = {Text = "Salvador"},
  Mail_44843_Desc = {
    Text = [[
Caro Custode,
  Nell'aggiornamento V1.3.0, abbiamo rimosso il privilegio dei "Temi Fondamentali" che garantiva EXP Custode doppia in "Immersione Fantasmatica" e "Traphase (beta)". Come scusa, forniremo una compensazione giornaliera di 240 EXP Custode a coloro che hanno acquistato gli attuali "Temi Fondamentali" fino al termine del Curriculum in corso. Vi preghiamo di controllare le vostre ricompense.]]
  },
  Mail_44843_Name = {
    Text = "V1.3.0 Riemissione ricompense argomenti Premium"
  },
  Mail_44843_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_47305_Desc = {
    Text = "Caro Custode,\nnell'Immersione Fantasmatica di ieri, la difficoltà più alta superata è stata \"{s1}\".\nNel Traphase di ieri, hai ottenuto il titolo di \"{s2}\", senza alcuna vittoria conseguita negli scontri.\nIn base a questi risultati, riceverai le seguenti ricompense in D-Gemme. Ricordati di ritirarle."
  },
  Mail_47305_Name = {
    Text = "Ricompensa D-gemma Immersione Fantasmatica/Traphase"
  },
  Mail_47305_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_47306_Desc = {
    Text = [[
Stimato Custode,
Nell'Immersione Fantasmatica di ieri hai ottenuto il titolo "{s1}".
Nel Traphase di ieri hai ottenuto il titolo "{s2}" e non hai conseguito vittorie.
In base a questi risultati, riceverai le seguenti ricompense aggiuntive. Ricorda di controllarle.]]
  },
  Mail_47306_Name = {
    Text = "Ricompense aggiuntive Immersione Fantasmatica/Traphase"
  },
  Mail_47306_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_47307_Desc = {
    Text = [[
Stimato Custode,
Nell'Immersione Fantasmatica di ieri hai ottenuto il titolo "{s1}".
Nel Traphase di ieri hai ottenuto il titolo "{s2}" e conseguito delle vittorie.
In base a questi risultati, riceverai le seguenti ricompense aggiuntive. Ricorda di controllarle.]]
  },
  Mail_47307_Name = {
    Text = "Ricompense aggiuntive Immersione Fantasmatica/Traphase"
  },
  Mail_47307_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_47308_Desc = {
    Text = "Caro Custode,\nNell'Immersione Fantasmatica di ieri hai superato la difficoltà più alta di \"{s1}\".\nNel Traphase di ieri hai ottenuto il titolo di \"{s2}\" e conseguito delle vittorie.\nIn base a questi risultati, riceverai le seguenti ricompense in D-gemme. Ricorda di riscuoterle."
  },
  Mail_47308_Name = {
    Text = "Ricompensa D-gemma Immersione Fantasmatica/Traphase"
  },
  Mail_47308_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_48005_Desc = {
    Text = "Caro Custode,\n\nMi scuso per il disturbo, e spero che la mia calligrafia terribile non ti rovini l'umore—non sono davvero bravo a scrivere...\nTi scrivo questa lettera per farti sapere che sembra essere arrivato il mio compleanno. Ho preparato dei biscottini per l'occasione, e spero che li assaggerai.\nA dire il vero, non sono sicuro che la data sia corretta. Da quando sono stato infettato dalla Dissoluzione, le tracce della mia esistenza stanno svanendo poco a poco. La signorina Doll una volta mi ha chiesto cosa si prova a guardare se stessi venire dimenticati da tutti.\nÈ difficile da descrivere... È come stare in piedi nell'oscurità più totale, sul bordo di un fiume luminoso. Dall'altra parte, le persone parlano, indaffarate nelle loro faccende, passandomi accanto mentre io posso solo guardare, incapace di emettere un suono.\nÈ una sensazione solitaria. Per fortuna, tu non sei una di quelle persone.\nAlmeno tu ricordi la mia storia, vero?\n\nP.S., dodici biscottini sono allegati a questa lettera.\n\nMason"
  },
  Mail_48005_Name = {
    Text = "Scusate il Disturbo..."
  },
  Mail_48005_Sender = {Text = "\"24\""},
  Mail_48145_Desc = {
    Text = "Caro Custode,\nl'evento \"Guarigione Molteplice\" è terminato. Ritireremo la valuta evento rimanente \"Puzzle della Memoria\" secondo il tasso di cambio illimitato della \"Dissezione dell'Ego\". Ricorda di controllare le tue ricompense."
  },
  Mail_48145_Name = {
    Text = "Puzzle della Memoria convertito"
  },
  Mail_48145_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_48156_Desc = {
    Text = [[
Stimato Custode,
Nell'Immersione Fantasmatica di ieri hai ottenuto il titolo "{s1}".
Nel Traphase di ieri non hai conseguito vittorie.
In base a questi risultati, riceverai le seguenti ricompense aggiuntive. Ricorda di controllarle.]]
  },
  Mail_48156_Name = {
    Text = "Ricompense aggiuntive Immersione Fantasmatica/Traphase"
  },
  Mail_48156_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_48157_Desc = {
    Text = "Caro Custode,\nNell'Immersione Fantasmatica di ieri la difficoltà più alta superata è stata \"{s1}\".\nNel Traphase di ieri non hai conseguito vittorie.\nIn base a questi risultati, riceverai le seguenti ricompense in D-gemme. Ricorda di controllarle."
  },
  Mail_48157_Name = {
    Text = "Ricompensa D-gemma Immersione Fantasmatica/Traphase"
  },
  Mail_48157_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_48914_Desc = {
    Text = "Caro Custode, \n Grazie per il tuo supporto a [Morimens]. Per migliorare la tua esperienza all'Università di Mythag, ti invitiamo a compilare il seguente sondaggio. In segno di gratitudine, offriamo [Silver*200] come ricompensa al completamento del sondaggio. La scadenza per l'invio è il 28 ottobre alle ore 9:00. Ti preghiamo di compilarlo entro i tempi previsti.\n   <SurveyLink:[Click here to fill out]>\n   Apprezziamo il feedback di ogni Custode. I tuoi suggerimenti contribuiranno a migliorare l'Università di Mythag!\n   —Che la Chiave d'Argento illumini il tuo sentiero."
  },
  Mail_48914_Name = {
    Text = "Sondaggio esperienza versione V1.6.3"
  },
  Mail_48914_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_48915_Desc = {
    Text = "Caro Custode,\n  Grazie per il tuo supporto a Morimens. Per migliorare la tua esperienza di gioco all'Università di Mythag, ti invitiamo a compilare il seguente sondaggio. In segno di gratitudine, riceverai [Silver*200] al completamento. Ti preghiamo di inviarlo entro le ore 9:00 del 30 settembre.\n   <SurveyLink:[Click Here to Respond]>\n   Apprezziamo il feedback di ogni Custode, che contribuirà a rendere l'Università di Mythag ancora migliore!\n  —Che la Chiave d'Argento illumini il tuo sentiero."
  },
  Mail_48915_Name = {
    Text = "Sondaggio esperienza versione V1.6.1"
  },
  Mail_48915_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_49931_Desc = {
    Text = "Caro Custode,\nl'evento \"Desideri Carnali\" è terminato. I \"Seme dell'Abbondanza\" rimanenti verranno convertiti al tasso di \"Scrip della Rosa * 20\" per gettone. Ricorda di controllare le tue ricompense."
  },
  Mail_49931_Name = {
    Text = "Seme dell'Abbondanza convertito"
  },
  Mail_49931_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_50344_Desc = {
    Text = "Piccolo Germoglio:\n\nIl vento porta il tuo profumo - è più dolce di quando ci siamo incontrati per la prima volta.\nSei cresciuto nel mio amore, nutrito fino alla maturità... come le api e il miele.\nOggi è un giorno speciale. Verrai a trovarmi?\nHo aspettato pazientemente per molto tempo, proprio come mi hai chiesto... Non è forse giunto il momento di una ricompensa?\n\nThais"
  },
  Mail_50344_Name = {
    Text = "Dolce come il Miele..."
  },
  Mail_50344_Sender = {Text = "Thais"},
  Mail_51376_Desc = {
    Text = "Caro Custode,\nl'evento \"Magia della Storia\" è terminato. Le tue \"Ispirazione alla Deriva\" rimanenti verranno convertite al tasso di \"Scrip della Rosa*60\" per unità. Assicurati di controllare il tuo inventario."
  },
  Mail_51376_Name = {
    Text = "Ispirazione alla Deriva convertita"
  },
  Mail_51376_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_51777_Desc = {
    Text = "Caro Custode,\nl'evento \"Magia della Storia: Replica\" è terminato. Convertiremo le \"Ispirazione alla Deriva\" rimanenti al tasso di cambio di 1 per \"Scrip della Rosa *25\". Ricorda di controllare le tue ricompense."
  },
  Mail_51777_Name = {
    Text = "Ispirazione alla Deriva convertita"
  },
  Mail_51777_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_53149_Desc = {
    Text = "\nHo deciso da tempo di dedicare ogni giorno della mia vita restante a quell'Unico... come atto di espiazione per le mie sciocche azioni.\nIl \"compleanno\" del mio sé superficiale è insignificante, a malapena degno di menzione.\nOggi non è diverso da qualsiasi altro giorno passato o futuro; andrò alla cappella come sempre.\nTuttavia, se desiderate che lasci la cappella oggi come ospite di Mythag, di certo non mi opporrò alla volontà del padrone.\nSe desiderate assistere alle mie preghiere, siete sempre i benvenuti... con tutto il rispetto, siete davvero i benvenuti.\n\nMiryam"
  },
  Mail_53149_Name = {
    Text = "Un giorno di pratica..."
  },
  Mail_53149_Sender = {Text = "Miryam"},
  Mail_53151_Desc = {
    Text = "Caro Custode,\nl'evento \"Sacrificio Abissale\" è terminato. Le tue \"Lacrime del Sacrificatore\", \"Sangue del Sacrificatore\" e \"Midollo del Sacrificatore\" rimanenti verranno convertiti al tasso di \"Scrip della Rosa * 2500\" ogni 100 oggetti. Assicurati di controllare le tue ricompense."
  },
  Mail_53151_Name = {
    Text = "Valuta Sacrificio abissale convertita"
  },
  Mail_53151_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_53152_Desc = {
    Text = "Caro Custode,\nl'evento \"Pastore dell'anima\" è terminato. I \"Gettoni di Beneficenza\" rimanenti verranno convertiti al tasso di \"Monete d'Oro * 5000\" ogni 120 oggetti. Ricorda di controllare le tue ricompense."
  },
  Mail_53152_Name = {
    Text = "Coupon di Beneficenza convertito"
  },
  Mail_53152_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_53153_Desc = {
    Text = "Caro Custode,\nl'evento \"Banchetto di Fiamme\" è terminato. Le \"Tibia Originaria\", \"Tornoceras\" e \"Rovine a Spirale\" rimanenti verranno convertite al tasso di \"Sigillo dei mille volti *1\" ogni 80 oggetti. Ricorda di controllare le tue ricompense."
  },
  Mail_53153_Name = {
    Text = "Valuta Banchetto di Fiamme convertita"
  },
  Mail_53153_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_53869_Desc = {
    Text = "Caro Custode,\nl'evento \"Epistola alla Rosa\" è terminato. Convertiremo i tuoi \"Ventaglio di Piume Spiritiche\" rimanenti al tasso di 1:50 in \"Scrip della Rosa *50\". Controlla le tue ricompense."
  },
  Mail_53869_Name = {
    Text = "Ventaglio di Piume Spiritiche convertito"
  },
  Mail_53869_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_54803_Desc = {
    Text = "Caro Custode,\n       Nell'aggiornamento V1.5.1, abbiamo aumentato le ricompense in Argento per i Livelli Custode 21-80 nel \"Registro di Crescita\" e aggiunto una ricompensa di 1000 Distintivi d'investigazione per il completamento dei compiti nei Livelli I~V di \"Padronanza del Reame\". Per i Custodi che avevano già riscosso le suddette ricompense prima dell'aggiornamento, provvederemo a inviare l'Argento o i Distintivi d'investigazione corrispondenti come compensazione. Vi invitiamo a verificare le vostre ricompense."
  },
  Mail_54803_Name = {
    Text = "V1.5.1 Riemissione ricompense manuale"
  },
  Mail_54803_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_55168_Desc = {
    Text = "Caro Custode,\nl'evento \"Prima che la primavera appassisca\" è terminato. Convertiremo i tuoi \"Poemi di Gioia\", \"Poesie di Malinconia\" e \"Poemi del Rimpianto\" rimanenti al tasso di 200 per \"Scrip della Rosa *5000\". Controlla le tue ricompense."
  },
  Mail_55168_Name = {
    Text = "Poema convertito"
  },
  Mail_55168_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_56101_Desc = {
    Text = "Custode,\n\nAll'alba di oggi, una rosa è sbocciata tra il canto degli uccelli di inizio primavera.\nAvrebbe dovuto essere un ramo in boccio primaverile, ma nel giorno di San Valentino, nel giorno del mio compleanno, è fiorita in una stagione che non le appartiene.\nMi ha fatto pensare alla Cité. Ogni anno, in questo giorno, le strade della Cité erano sempre animate. Sentivo il suono dei fiori che sbocciavano e delle persone che si scambiavano dolci parole da far arrossire. Ma non ho avuto modo di sfiorarle per molto tempo... fino a oggi.\nCredi nelle coincidenze, Custode? Io penso che le coincidenze siano un linguaggio, e le rose una figura retorica. Oggi, nel rigoglioso giardino dei Mythag, questa rosa fiorisce, i suoi petali si schiudono generosamente come una poesia che scioglie il cuore.\nQuindi oggi, Custode... vorresti unirti a me per ammirare questa rosa in piena fioritura?\nSia il fiore che io attendiamo il tuo arrivo.\n\nHorla"
  },
  Mail_56101_Name = {
    Text = "Una rosa fiorisce in primavera..."
  },
  Mail_56101_Sender = {Text = "Horla"},
  Mail_57328_Desc = {
    Text = "Caro Custode,\nl'evento \"Le Stelle Sono Allineate\" è terminato. I tuoi \"Embrione Inconsapevole\", \"Embrione Senza Desiderio\" e \"Embrione Insaziabile\" rimanenti verranno ora convertiti al tasso di \"Scrip della Rosa * 40\" per oggetto. Controlla le tue ricompense."
  },
  Mail_57328_Name = {
    Text = "Embrione convertito"
  },
  Mail_57328_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_57414_Desc = {
    Text = "Caro Custode,\nl'evento \"Manuale del Detective\" è terminato. Convertiremo le tue \"Fiches della Vittoria\" rimanenti al tasso di 1:40 in \"Scrip della Rosa *40\". Controlla le tue ricompense."
  },
  Mail_57414_Name = {
    Text = "Chip convertito"
  },
  Mail_57414_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_58253_Desc = {
    Text = "Caro Custode,\nl'evento \"Pastore dell'anima: Replica\" è terminato. I \"Coupon di Beneficenza\" rimanenti verranno convertiti al tasso di 5000 Monete d'Oro ogni 200 oggetti. Ricorda di controllare le tue ricompense."
  },
  Mail_58253_Name = {
    Text = "Coupon di Beneficenza convertito"
  },
  Mail_58253_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_58690_Desc = {
    Text = "Caro Custode,\nl'evento \"Sinfonia Invisibile\" è terminato. I tuoi movimenti \"Apice dell'Aria\" rimanenti sono stati convertiti al tasso di \"40 Scrip della Rosa\" per movimento. Controlla."
  },
  Mail_58690_Name = {
    Text = "Apice dell'Aria convertito"
  },
  Mail_58690_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_61154_Desc = {
    Text = "Caro Custode,\nL'evento \"Banchetto delle Fiamme: Replica\" è terminato. Le rimanenti \"Tibia Originale\", \"Tornoceras\" e \"Rovine a Spirale\" saranno convertite al tasso di \"Rosa Scritta * 40\" per ogni oggetto. Ricordati di controllare le tue ricompense."
  },
  Mail_61154_Name = {
    Text = "Banchetto di Fiamme convertito"
  },
  Mail_61154_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_61155_Desc = {
    Text = "Caro Custode,\nL'evento \"Guarigione Molteplice: Replica\" è terminato. Ritireremo la valuta evento rimanente \"Puzzle della Memoria\" al tasso di cambio di 40 Rose Scritte per unità. Ricordati di controllare le tue ricompense."
  },
  Mail_61155_Name = {
    Text = "Puzzle della Memoria convertito"
  },
  Mail_61155_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_62392_Desc = {
    Text = "Custode,\n\nLa mia musica un tempo veniva eseguita dinanzi agli imperatori ed era ammirata da innumerevoli persone. Tuttavia, quelle lodi non hanno alcun valore per me; ciò che perseguo è l'essenza suprema della musica.\nRispetto a esibirmi in luoghi grandiosi e sfarzosi, suonare da solo in una foresta silenziosa mi dona maggiore pace.\nNon ho mai voluto che qualcuno ascoltasse le mie sessioni di pratica; erano soltanto bozze, frammenti privi di significato.\nMa da quando ti ho conosciuto e ti ho trovato, tutta la mia musica ha acquisito un senso.\nMi hai donato la musica più magnifica e nobile, salvandomi dalla mia confusione, anche se non ne eri consapevole...\nOggi è il mio compleanno, che avevo dimenticato da tempo. Ma ora desidero commemorare la mia rinascita e colui che me l'ha concessa.\nPer coincidenza, di recente ho composto un nuovo brano e vorrei invitarti ad ascoltarlo. Ti prego di perdonare il mio ritardo; la mia identità attuale non mi consente di mostrarmi ai miei colleghi Mythag, perciò posso inviare questo invito solo dopo il tramonto.\nStanotte, nella foresta dietro la scuola, terrò un concerto speciale con un solo spettatore.\nAttendo con impazienza la tua presenza.\n\nHameln"
  },
  Mail_62392_Name = {
    Text = "Concerto Segreto..."
  },
  Mail_62392_Sender = {Text = "Hameln"},
  Mail_65350_Desc = {
    Text = "Caro Custode,\nL'evento \"Quando la Neve si Scioglie\" è terminato. Le tue valute evento rimanenti — \"Bocciolo Ghiacciato\", \"Bocciolo di Brina Argentea\" e \"Bocciolo di Luce Solare\" — saranno recuperate al tasso di \"Rosa Scritta * 40\" per oggetto. Assicurati di riscuotere le tue ricompense."
  },
  Mail_65350_Name = {
    Text = "Germoglio convertito"
  },
  Mail_65350_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_65441_Desc = {
    Text = "Caro Custode:\nL'evento \"Sacrificio abissale: Replica\" è terminato. Le rimanenti \"Lacrime del Sacrificatore\", \"Sangue del Sacrificatore\" e \"Midollo del Sacrificatore\" saranno convertiti al tasso di \"Buono Rosa* 40\" per oggetto. Ricordati di controllare le tue ricompense."
  },
  Mail_65441_Name = {
    Text = "Valuta Sacrificio abissale convertita"
  },
  Mail_65441_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_65442_Desc = {
    Text = "Caro Custode,\nL'evento \"Portale di Tutti i Reami\" è terminato. Convertiremo la tua valuta evento rimanente \"Puntatore Finale\" in \"Rosa Scritta *40\" al tasso di cambio 1:1. Assicurati di controllare le tue ricompense."
  },
  Mail_65442_Name = {
    Text = "Lancetta della Fine convertita"
  },
  Mail_65442_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_67147_Desc = {
    Text = "Custode, \n\nLe dimensioni dell'universo non sono per me qualcosa di singolare; il Portale Supremo mi ha concesso uno sguardo su innumerevoli mondi ed esistenze infinite. Esso trascende ogni meraviglia e logica matematica, rendendo impossibile individuare la data della \"Genesi\". \nConsideriamo dunque il nostro primo incontro come quel momento. Nella scala del continuum temporale in cui dimori, oggi dovrebbe tenersi una cerimonia dedicata esclusivamente a me, esaudendo il desiderio che ho espresso. \nOra, varchiamo la soglia della Chiave d'Argento e vieni al mio cospetto. Ti impartirò... alcune conoscenze sulla Genesi suprema che appartiene all'universo. Stanotte, innumerevoli corpi celesti brilleranno per te e per me. \nTi attendo al Portale Supremo.\n\nTawil"
  },
  Mail_67147_Name = {
    Text = "Varcare la Soglia d'Argento..."
  },
  Mail_67147_Sender = {Text = "Tawil"},
  Mail_67933_Desc = {
    Text = "Ho percepito la tua breve esitazione — come si potrebbe sperare di danneggiare la suprema Reliquia con il solo sguardo? Eppure ci sei riuscito.\nUn altro sguardo crolla, l'armatura porta graffi e brecce sotto l'assalto incessante dei Frammenti.\n%player%, solo la tua Volontà indomabile è davvero indistruttibile."
  },
  Mail_67933_Name = {
    Text = "Trova una via d'uscita dallo smarrimento"
  },
  Mail_67933_Sender = {Text = "Alistair"},
  Mail_67934_Desc = {
    Text = "Le tue membra tremano, %player%. Riesci a malapena a reggerti in piedi. La paura ti attanaglia, svuotandoti la mente e rendendo impossibile controllare il respiro... eppure sollevi la chiave d'argento davanti a te.\nFra tutte le virtù umane, il coraggio è la più nobile. Di fronte a calamità e bestie, un tempo impugnammo martelli e lance. Ora, di fronte agli dèi, tu fai lo stesso.\nLa civiltà umana fu edificata sul coraggio, e attraverso il Ciclo Eterno perdurerà."
  },
  Mail_67934_Name = {
    Text = "L'inno del coraggio risuona tra i tremori"
  },
  Mail_67934_Sender = {Text = "Alistair"},
  Mail_67935_Desc = {
    Text = "Un tempo parlammo di questo mondo; dicesti che non ti piaceva. È pervaso da interessi, cospirazioni, inganni e massacri. Anche senza Dissoluzione o Dèi, è già devastato e sull'orlo del collasso. Dopo il risveglio da Yakutsk, nel tuo ricordo fugace, hai assistito a innumerevoli disordini e orrori ben peggiori della Dissoluzione.\nEppure, quando il Creatore levò la Sua lama, tu ti ergesti comunque dinanzi a questo mondo per proteggerlo. L'Annientamento era la volontà degli Dèi, ma tu l'hai sfidata.\nCapisco, %player%. Nessun Custode odia questo mondo, né alcun Custode lo ama davvero. Poiché, in mezzo alla lordura, abbiamo intravisto bagliori che risplendono come l'Argento.\nIl dovere di un Custode è custodire eternamente quei flebili bagliori."
  },
  Mail_67935_Name = {
    Text = "Lo spirito umano perdura in eterno."
  },
  Mail_67935_Sender = {Text = "Alistair"},
  Mail_67936_Desc = {
    Text = "La prima volta che si assiste alla Dissoluzione, la prima volta che se ne affronta la verità, la prima volta che si ode la voce di Dio... Nel corso della mia lunga vita, ho sopportato innumerevoli momenti di disperazione, senza sapere cosa fare né il significato di tutto lo sforzo e il Sacrificio — eppure nulla è paragonabile a ciò che affronti ora.\nQuesta è l'Umanità: di fronte alla disperazione, ci rialziamo e proseguiamo.\nLa fine della strada potrebbe essere un Abisso, ma ci sarà sempre qualcuno che desidera vederlo."
  },
  Mail_67936_Name = {
    Text = "Disperazione, seguita dalla Rinascita dalla Terra"
  },
  Mail_67936_Sender = {Text = "Alistair"},
  Mail_67937_Desc = {
    Text = "La Barriera Dimensionale è aperta, e finalmente posso contattarti di nuovo.\nRispetto a ciò che hai visto tu, la visione in questa dimensione è eccezionalmente debole, forse perché tu non sei qui. Dopo aver sacrificato quasi tutto, ho regolato i conti con Esso al posto tuo.\nNon riesco a immaginare ciò che stai affrontando. Ma qualunque cosa accada, con la volontà di annientare, combatterò al tuo fianco. Questo è il giuramento di ogni Mythag.\nSono lieto di stare ancora una volta al tuo fianco.\nPossa la Chiave d'Argento illuminare il sentiero."
  },
  Mail_67937_Name = {
    Text = "Combatti fianco a fianco, ancora una volta"
  },
  Mail_67937_Sender = {
    Text = "Mittente sconosciuto"
  },
  Mail_67938_Desc = {
    Text = "Follia, un termine lieve e persino piacevole.\nUn universo caotico ha generato una civiltà caotica. Il caos è la verità di questo mondo. Abbracciare il caos e godere della follia è cosa facile. Al contrario, restare lucidi e resistere è così difficile. Sacrificherai ogni gioia e la vita stessa, solo per inseguire una risposta sfuggente.\nEppure scegli ancora di restare sveglio, %player%. Perché non siamo nati per essere schiavi.\nHai mostrato a Lui, %player%—la Sua reliquia, il Suo frammento, non hanno mai accettato di essere schiavi ciecamente stolti. Tu Gli resisti, superando il Suo sguardo ancora e ancora, scegliendo di proteggere questo mondo imperfetto e inquieto.\nIn questa scelta, hai raggiunto la libertà eterna."
  },
  Mail_67938_Name = {
    Text = "Non diventerai mai uno Schiavo del Dio Cieco e Stolto."
  },
  Mail_67938_Sender = {Text = "Alistair"},
  Mail_67939_Desc = {
    Text = "Ho percepito uno sguardo crollare. Ho percepito il tuo dolore atroce.\nQuesta è la responsabilità incisa nel titolo di Custode. Il sentiero che hai scelto è mille volte più arduo del mio. Non tutti hanno il coraggio di affrontare il Dio supremo; il tuo valore mi commuove profondamente e mi colma di ammirazione.\nNon riesco a immaginare il dolore che il potere del Creatore ti infliggerà. Ciò che percepisco non è che una minuscola frazione della tua sofferenza. Sono una persona inutile intrappolata nella Pozza nera, %player%. Non posso più unirti nella tua battaglia contro il Creatore; posso solo restare connessa a te attraverso i miei sensi. Questa sarà la mia ultima e più importante missione nella vita.\nIn questo viaggio solitario, che tu lo veda o meno, Mythag sarà sempre al tuo fianco."
  },
  Mail_67939_Name = {
    Text = "Il Pianto non ti spezzerà..."
  },
  Mail_67939_Sender = {Text = "Alistair"},
  Mail_67940_Desc = {
    Text = "Ho udito i sussurri della Volontà Suprema: la grande civiltà, le gioie e i dolori umani, le innumerevoli persone che ti circondavano e ti abbandonavano; nulla di tutto ciò è mai esistito davvero.\nNegli innumerevoli giorni e notti alla Pozza Nera, questa visione mi ha riempito di terrore. Gli alberi affondano le radici nel suolo, poi crescono verso l'alto per salutare il sole — la memoria è il nostro suolo, il fondamento da cui cresciamo, ci ergiamo e infine facciamo ritorno. Temo di perdere questo suolo, alla deriva nell'illusione, senza origine né fine.\nGrazie, %player%. Credo di aver assistito a un grande duello. Questa è una battaglia tra uomo e dio, una battaglia tra protezione e distruzione.\nQuesta è una battaglia della rimembranza contro l'oblio.\nCe l'hai fatta, %player%. Hai compiuto ciò che nessuno osava immaginare. Hai tratto un potere senza pari dalla memoria e hai combattuto per preservarla.\nIn questo suolo antico, hai trovato il tuo sole."
  },
  Mail_67940_Name = {
    Text = "Combatti per Ricordare"
  },
  Mail_67940_Sender = {Text = "Alistair"},
  Mail_68825_Desc = {
    Text = "Caro Custode,\nL'evento \"Il Ritorno del Sovrano\" è terminato. Le tue valute evento rimanenti — \"Pensieri Stanchi\", \"Riflessioni Malinconiche\" e \"Meditazioni Gioiose\" — saranno convertite in \"Rosa Scritta*40\" al tasso di cambio 1:1, quindi ricordati di controllare il tuo inventario."
  },
  Mail_68825_Name = {
    Text = "Valuta Il Ritorno del Sovrano convertita"
  },
  Mail_68825_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_68826_Desc = {
    Text = "Caro Custode,\nL'evento \"Desideri Carnali: Replica\" è terminato. I rimanenti \"Seme dell'Abbondanza\" saranno convertiti in \"Rosa Scritta * 40\" al tasso di cambio uno a uno. Ricordati di controllare."
  },
  Mail_68826_Name = {
    Text = "Seme dell'Abbondanza convertito"
  },
  Mail_68826_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_68898_Desc = {
    Text = "Carissimo Padrone,\n\nUna cameriera tuttofare deve ricordare molti giorni importanti: dai banchetti ai compleanni, dagli anniversari al giorno in cui un animale domestico è stato portato a casa per la prima volta. Nemmeno uno viene mai dimenticato. Ma per me, l'unico giorno speciale degno di essere commemorato è oggi.\n\nTanto tempo fa, quando ero ancora una cameriera a palazzo, la prima volta che chiesi allo chef un pezzo di dolce avanzato da usare come torta di compleanno, venni rimproverata duramente. Me lo tirò dritto in faccia. In quel momento, mi venne un pensiero: \"Quindi la torta è una cosa così deliziosa! Devo trovare un padrone gentile, così potrò avere una torta ogni anno per il mio compleanno.\"\n\nOra, servendo la particolarmente elegante e generosa Lady Sorel e voi, mio padrone specialmente gentile, quel vecchio desiderio si è avverato! Ma si diventa più avidi... ah no, ambiziosi. Il desiderio ora è trascorrere ogni compleanno al vostro fianco. Sarebbe ancora meglio se ci fossero regali luccicanti ogni anno, naturalmente.\n\nDopo aver sentito tutto questo, sicuramente preparerete qualcosa, vero?\n\nPer sempre la vostra umile cameriera,\nKaren"
  },
  Mail_68898_Name = {
    Text = "Anno Dopo Anno..."
  },
  Mail_68898_Sender = {Text = "Karen"},
  Mail_68899_Desc = {
    Text = "Piccolo Germoglio:\n\nVederti crescere per tutto questo tempo mi ha convinta sempre di più che scegliere di aiutarti sia stata la decisione più giusta che abbia mai preso.\nProvo la gioia del raccolto; tutta la fiducia e l'amore riversati in me mi hanno portato dolci ricompense. Sei tu che mi hai donato speranza e un futuro.\nOra posso lasciar andare la mia ossessione per la riproduzione e concentrarmi nel godere i frutti dell'amore che vanno oltre la riproduzione.\nIl mondo non ha più bisogno della Regina Aram, ma forse può accogliere il desiderio di compleanno di una donna comune che desidera la compagnia del suo amato.\nProprio come le coppie più comuni, potremmo andare a comprare ingredienti insieme, cucinare piatti deliziosi insieme, e magari vivere tante esperienze che non ho mai provato prima. Quindi, tesoro, potresti guidarmi attraverso un compleanno caldo e semplice?\n\nThais"
  },
  Mail_68899_Name = {
    Text = "Vita ordinaria..."
  },
  Mail_68899_Sender = {Text = "Thais"},
  Mail_68900_Desc = {
    Text = "Custode,\n\nla Maestra Casiah è la più straordinaria maestra di performance al mondo, capace di imitare alla perfezione qualsiasi espressione. Tuttavia, le emozioni umane sono davvero un enigma irrisolvibile.\nHo chiesto a tantissime, tantissime persone, ma nessuna è riuscita a spiegarmi chiaramente i principi delle emozioni, finché non l'ho chiesto a Doll. Mi ha detto che esiste un campo chiamato psicologia, e che anche se non si riesce a provare empatia, padroneggiare la psicologia può aiutare a comprendere tutte le teorie sulle emozioni.\nÈ davvero, davvero affascinante! Significa forse che le perplessità che hanno tormentato Casiah per così tanto tempo possono finalmente essere svelate?\nA proposito, sono qui per dirti che questa settimana mi unirò al tuo corso di psicologia. Casiah ha deciso di essere la tua compagna di banco, e tu devi aiutarmi a recuperare quello che ho perso. Compagna di banco~\nOh giusto, a proposito, oggi è il mio compleanno. Io dovrei essere felice, e anche tu dovresti esserlo, giusto?\nSe è un'occasione molto felice, allora facciamo festa a scuola! Renderò il campus bello come un sogno!\n\nCasiah"
  },
  Mail_68900_Name = {
    Text = "Psicologia..."
  },
  Mail_68900_Sender = {Text = "Casiah"},
  Mail_68901_Desc = {
    Text = "Rispettabile Pallido Messaggero: \n\nGrazie per il tuo aiuto e la tua premura nell'ultimo anno. La tua sincerità verso gli altri è nobile quanto gli insegnamenti del Padre Supremo. Sebbene le nostre interazioni siano rare, ogni incontro con te è come ritrovare un vecchio amico, e mi fa sentire come avvolto da una brezza primaverile. \nSebbene non ci sia nulla di speciale in questo compleanno, come occasione per riunire gli amici porta comunque con sé una certa attesa. Al di fuori di te, non riesco a pensare a nessun altro che possa farmi compagnia in questo giorno. \nSe ti fa piacere, vorrei invitarti a provare il mio hobby più recente: la pesca. Non per cucinare o mangiare il pescato, naturalmente, ma semplicemente per godersi il processo di attendere in silenzio che il destino ci consegni doni miracolosi. Desidero condividere con te questa sensazione di serenità, immersi nella natura, seduti tranquillamente in riva al lago. \nUn vecchio amico, due canne da pesca... sarà sicuramente una giornata meravigliosa. \n\nSalvador"
  },
  Mail_68901_Name = {
    Text = "Un nuovo hobby: Pesca..."
  },
  Mail_68901_Sender = {Text = "Salvador"},
  Mail_68902_Desc = {
    Text = "Maestro:\n\nPer il mio compleanno di quest'anno, Aigis e Jenkin mi hanno regalato un campanello a vento di vetro che somiglia ad Aurita.\nL'ho appeso vicino alla finestra della mia stanza e, quando soffia il vento, produce un suono piacevole che mi ricorda i tempi in cui la mamma mi teneva in braccio vicino alla finestra e mi raccontava delle storie.\nNon preoccuparti, Maestro. Anche se mi manca la mamma ogni giorno, con te e tutti gli altri intorno, Lily non si sente sola.\nOra Lily ha imparato a leggere i libri di fiabe da sola. La sera, la luce arancione del sole entra in casa, si riflette sul campanello a vento e proietta motivi ondeggianti sul libro di fiabe, facendo sembrare la stanza calda e accogliente.\nA Lily piace molto fantasticare in questi momenti, guardando le nuvole e i campanelli a vento nel tramonto, sentendosi così serena.\nSe oggi hai tempo, Maestro, perché non provi a fantasticare insieme a Lily?\n\nLily"
  },
  Mail_68902_Name = {
    Text = "Campanelli a vento di vetro..."
  },
  Mail_68902_Sender = {Text = "Lily"},
  Mail_68903_Desc = {
    Text = "Piccola:\n\nSebbene questo giorno speciale sia stato istituito per commemorare quell'umano, devo ammettere che i giorni di sconto sono una strategia di vendita estremamente allettante sia per i clienti che per i commercianti.\nDurante il mio ultimo compleanno, il volume delle vendite al Negozio Senza Pensieri ha quasi eguagliato il totale di mezzo anno di vendite. In particolare, gli articoli scontati che avevo esposto come punti salienti della celebrazione sono andati completamente esauriti. Dovrei dire che gli ospiti di Mythag sono fin troppo generosi nel sostenere i miei affari, o che persino gli investigatori più scaltri non riescono a resistere al fascino degli sconti?\nIn ogni caso, per continuare questa gioia reciprocamente vantaggiosa, anche quest'anno la mia festa di compleanno prevederà attività con sconti—solo una volta all'anno, con riduzioni sostanziose—quindi affrettati se vuoi comprare qualcosa. Ricordati di aiutarmi a promuoverla a Mythag, e per ricordare questo giorno, chiamiamolo il Giorno del Doppio Dieci.\nInoltre, ho preparato in segreto alcune cosette interessanti per te, quindi assicurati di venire a trovarmi presto.\n\nDaffodil"
  },
  Mail_68903_Name = {
    Text = "Giorno di sconti..."
  },
  Mail_68903_Sender = {Text = "Daffodil"},
  Mail_68904_Desc = {
    Text = "Al più stimato Custode dell'Università di Mythag, nobile signore di saggezza e benevolenza:\n\nPossano la pace e l'onore sempre adornare le vostre sale!\n\nSe la più alta vocazione di un cavaliere è quella di offrire la propria spada a un signore di grande virtù, allora posso dichiarare il mio servizio compiuto senza rimpianto. Sebbene la fortuna non mi abbia sempre arriso, e sebbene il mio cammino sia stato segnato da prove e dallo spargimento di sangue, non provo vergogna per queste lotte. Molti a Mythag mi hanno mostrato gentilezza per le mie ferite, eppure dico questo: in un mondo così afflitto dal dolore, sanguinare in difesa degli altri non è una tragedia. No, è un privilegio — che ho portato con orgoglio negli anni passati, e che sono pronto a portare ancora.\n\nTuttavia Lady Lotan, sempre perspicace, ha notato la stanchezza incisa sulla mia fronte. In occasione del mio banchetto di compleanno, ha dichiarato che il dovere solenne dovrebbe cedere, seppur brevemente, all'allegria — e così ha convocato Jenkin affinché mi istruisse nei giochi, perché potessi ritrovare un po' della gioia dell'infanzia.\n\nAhimè, la mia infanzia fu trascorsa tra esercitazioni e disciplina, lasciando poco spazio per giocare. Confesso che questo passatempo — che si dice venga padroneggiato persino da bimbi di cinque inverni — si è rivelato un avversario assai astuto! Sembra che le arti dello svago siano un altro campo in cui devo lottare per raggiungere la maestria.\n\nPertanto, se i doveri della vostra signoria lo consentono, sarei onorato dalla vostra presenza. Jenkin, avendo trionfato dieci volte consecutive, si fa impaziente per un avversario più degno. Con voi qui, non ho dubbi che la contesa sarebbe degna di essere ricordata nei secoli.\n\nVostro in fedele servizio,\nOgier"
  },
  Mail_68904_Name = {
    Text = "Un gioco difficile..."
  },
  Mail_68904_Sender = {Text = "Ogier"},
  Mail_68905_Desc = {
    Text = "Ehi:\n\nCon quel calendario, di certo non ti sei dimenticato del compleanno della stimata Signora dei Labirinti quest'anno.\nTi concedo il permesso di venire nella mia stanza per presentare il tuo regalo e servirmi con tutto il cuore in questo giorno.\nPer esempio, lavare i denti, lavare il viso, cambiare i vestiti, consumare i pasti, e persino quelle faccende come pulire la stanza e cambiare le lenzuola. Come le chiamate voi? Pulizie di Primavera!\nSì, tutte quelle faccende delle pulizie di Primavera saranno una tua responsabilità. Ne ho abbastanza delle faccende domestiche. Oggi, a qualunque costo, intendo rivivere i miei tempi a Roma e godermi una vita in cui tutto viene fatto per me.\nOggi, chiunque sia, non pensate nemmeno di farmi fare qualsiasi lavoro—nessuno dovrebbe!\n\nAgrippa"
  },
  Mail_68905_Name = {
    Text = "Ritorno al passato..."
  },
  Mail_68905_Sender = {Text = "Agrippa"},
  Mail_68906_Desc = {
    Text = "Custode,\n\nIl tempo vola così in fretta. Non avrei mai immaginato che il tipo di vita che un tempo credevo sarebbe durata fino alla morte sia ormai quasi svanita dalla mia memoria.\nQuesta signorina conosce già alla perfezione tutte le tortine della caffetteria. Per quanto io sproni quegli chef incapaci, non riescono a inventare nulla di nuovo.\nQuindi, nel nuovo anno, la mia mappa culinaria dovrà espandersi ancora di più. Mi porrò un piccolo obiettivo: mangiare in tutte le pasticcerie di Londinium.\nQuanto all'onorevole compito di fare commissioni e code, quello spetterà ancora a te! Non c'è bisogno che tu sia eccessivamente compiaciuto per esserti guadagnato la mia fiducia. Ricordati solo di lodare con gratitudine il nome di questa signorina.\nMa a proposito, quegli sciocchi chef hanno un po' di sincerità. Dai loro sussurri che cercano di nascondere, ho sentito che sembrano aver preparato un'enorme torta a dieci strati... ha, non sanno ancora nascondere bene le sorprese.\nAnche se l'idea è un po' banale, forse potrei invitare più persone a questa festa di compleanno, come i nuovi amici che ho fatto quest'anno.\nIn qualità di primo amico a Mythag, ti concedo l'onore di tagliare la prima fetta di torta per me.\n\nMurphy"
  },
  Mail_68906_Name = {
    Text = "Torta a Dieci Strati..."
  },
  Mail_68906_Sender = {Text = "Murphy"},
  Mail_68907_Desc = {
    Text = "Caro Custode,\n\nSaggio come sei, devi già sapere dai fantastici archivi di Mythag che oggi è un giorno commemorativo nella vita del \"Detective Fortunato.\"\nGestazione, vittoria alla prima mano di blackjack, vittoria alla centesima corsa di cavalli, risoluzione del primo caso di omicidio a camera chiusa e lo scacco alla morte stessa: tutto è accaduto in questo magico 6 giugno.\nPerciò, che ne dici di giocare una partita di doppio bridge con me? In questo giorno, rendiamolo ancora più memorabile, che ne dici?\n\nRyker"
  },
  Mail_68907_Name = {
    Text = "Che ne dici di un giro?"
  },
  Mail_68907_Sender = {Text = "Ryker"},
  Mail_68908_Desc = {
    Text = "Questa lettera non è un saluto, ma un avvertimento— non tentare di controllarmi, né di incatenarmi.\nAppartengo solo a me stessa.\nNon sono nulla come quella persona che mi somiglia, ancora aggrappata a ingenue speranze per le persone e per il mondo.\n\nUcciderò chiunque osi definirsi il mio \"padrone\". Considera questa una promessa.\n\nH"
  },
  Mail_68908_Name = {
    Text = "Io appartengo a..."
  },
  Mail_68908_Sender = {
    Text = "Helot: catena"
  },
  Mail_68909_Desc = {
    Text = "Custode,\n\nForse te l'ho già detto quanto amo l'acqua; rispetto al chiassoso mondo degli umani, il regno sottomarino è così sereno e tranquillo.\nHo vagato tra alghe e coralli, e ho persino conversato con banchi di pesci. Più ci si allontana dalla superficie, più i colori si fanno scuri. Quando, cullata dolcemente dalle correnti, alzo lo sguardo verso il cielo, la luce screziata crea un mosaico onirico— è lo spettacolo più bello che il mio cuore conosca.\nLo sapevi? Alcune creature marine riescono a ricordare i volti delle persone. Quando torni, questi \"amici\" ti nuotano incontro con entusiasmo per salutarti— come il piccolo polpo furbo che conosco, o quel dolce pesce giallo.\nIn questo compleanno, mi ritrovo a sentire di nuovo la mancanza del mondo sottomarino. Mi chiedo se ti andrebbe di fare un'immersione con me. Desidero davvero condividere con te questo luogo di pace e i miei meravigliosi amici.\n\nNymphaea"
  },
  Mail_68909_Name = {
    Text = "Mondo sottomarino..."
  },
  Mail_68909_Sender = {Text = "Nymphaea"},
  Mail_68910_Desc = {
    Text = "Custode,\n\nDa quando sei arrivato a Mythag, mi sono abituata a gestire le questioni che ti riguardano con un approccio premuroso. A giudicare dalle tue solite reazioni, la tua fragilità ha superato di gran lunga le mie aspettative.\nTuttavia, in qualità di tua mentore e prima guardiana, sono lieta di constatare che nell'ultimo anno ci sono stati meno problemi e incidenti da risolvere per conto tuo. Sebbene sembrasti del tutto sprovveduto quando hai messo piede a scuola per la prima volta, la tua crescita può essere davvero descritta come una combinazione di talento e impegno.\nCongratulazioni! Sei diventato un Custode qualificato e hai soddisfatto le mie aspettative.\nPer il mio compleanno — un giorno qualunque — ho preparato un regalo per te: un piano di addestramento speciale un tempo utilizzato da Alistair, appartenente a un Custode di successo. Allora? Sei impaziente di scoprirlo?\nNon chiedermi perché ti faccio un regalo. Ho bisogno di qualcosa da fare nei giorni in cui non posso entrare in laboratorio, no?\nQuando sarai pronto, vieni a cercarmi nella sala di addestramento.\n\nDoll"
  },
  Mail_68910_Name = {Text = "Un Dono..."},
  Mail_68910_Sender = {Text = "Doll"},
  Mail_68911_Desc = {
    Text = "Custode,\n\nUn anno per una ballerina non è che decine di migliaia di piroette e salti; a parte il paio di scarpette da danza che mi ha accompagnata così a lungo, ora sostituite, tutto sembra immutato, eppure in qualche modo diverso.\nRispetto alla solitudine a cui ero abituata un tempo, quest'anno ho sempre avuto uno spettatore fedele e un partner di danza un po' maldestro.\nOgni volta che ti siedi nello studio di danza, sento il mio corpo farsi più leggero, come se stessi imparando a danzare di nuovo, colma di un'inspiegabile passione e motivazione.\nForse non sono così pura e nobile come credevo; pur dedicando la mia vita alla danza, desidero anche il tuo sguardo e sentire il tuo applauso.\nIl tempo in questo compleanno è splendido; posso già prevedere che il cielo stellato stanotte sarà straordinariamente limpido. Mio appassionatissimo spettatore, mio esclusivo partner di danza, vorresti camminare con me nel bosco dai laghi incantevoli, per danzare insieme una danza che appartiene alla luna e alle stelle?\n\nLiz"
  },
  Mail_68911_Name = {
    Text = "Partner di danza esclusivo..."
  },
  Mail_68911_Sender = {Text = "Liz"},
  Mail_68912_Desc = {
    Text = "Custode,\n\nDal giorno della mia rinascita, il popolo di Mythag mi ha aiutato enormemente. Forse non riesco ancora ad abituarmi alla sensazione di collaborare, ma almeno quando cammino al tuo fianco, posso affidarti le mie spalle con fiducia. Questa sensazione... non è male.\nLa maggior parte della mia vita è stata colma di sofferenza e tradimenti; ho sempre considerato il combattere contro tutto ciò come il significato delle mie battaglie, finché non è rimasto nient'altro nella mia vita, e il mio sguardo non è più riuscito a distogliersi dalla vendetta.\nOra, seguendo i tuoi passi, ho capito che le battaglie possono avere molti significati oltre alla sofferenza e alla vendetta. Persino come ha detto Lotan, combattere può essere semplicemente combattere.\nHo imparato a godermi il piacere del combattimento, ad assaporare quella sensazione esaltante, e a diventare puramente un guerriero feroce.\nSe le mie battaglie possono portare qualcosa di più, allora abbraccerò quella gloria.\nE a te, ora e in futuro, prometto che la mia lama non sarà mai rivolta contro di te.\n\nHelot"
  },
  Mail_68912_Name = {
    Text = "Il Significato della Battaglia..."
  },
  Mail_68912_Sender = {Text = "Helot"},
  Mail_68913_Desc = {
    Text = "Caro Custode,\n\nA essere sincera, non ho molti pensieri riguardo ai desideri di compleanno. Nei giorni in cui ero ancora \"normale\", il mio più grande desiderio quotidiano era semplicemente avere cibo e vestiti a sufficienza, pagare l'affitto in tempo e prendermi cura di Jenkin. Ora, riuscire a trascorrere un anno in pace e guardare Jenkin fare le sue sciocchezze per un altro anno è già una soddisfazione più che sufficiente.\nMi vergogno a dirlo, ma davanti a Jenkin assumo sempre l'atteggiamento da sorella maggiore e la rimprovero, mentre con te sembra che porti sempre un sacco di problemi, al punto che dimentico persino quale versione di me abbia causato il guaio.\nLa tua gentilezza e pazienza immutabili mi fanno sentire al contempo al caldo e in imbarazzo. Forse è la prima volta nella mia vita che qualcuno si prende cura di me con un atteggiamento così comprensivo, e mi sento sinceramente onorata e grata.\nQuest'anno ho preparato una grande torta per tutti, usando una ricetta insegnatami dalla signora della fabbrica tessile. Anche se non può competere con le abilità degli chef, sia io che Jenkin adoriamo quel sapore speciale. Questa volta non c'è bisogno di preoccuparsi per gli ingredienti; tutti possono mangiare a volontà, quindi ti prego, vieni ad assaggiarla.\nHo convinto gli altri a comportarsi bene e a lasciarmi festeggiare il compleanno in tranquillità; oggi sicuramente non ti causeranno alcun problema!\nSe possibile, sentiti libero di chiamarmi ogni volta che hai bisogno, che si tratti di fare il bucato, pulire o riordinare; sono piuttosto brava in queste cose, e spero anche di avere l'occasione di ricambiare la tua gentilezza.\n\nMason"
  },
  Mail_68913_Name = {
    Text = "Risarcimento..."
  },
  Mail_68913_Sender = {Text = "\"24\""},
  Mail_68914_Desc = {
    Text = "Custode,  \n\nIn quanto persona responsabile di ricevere i desideri di tutti, non riesco mai ad abituarmi a esprimere un desiderio per me stessa il giorno del mio compleanno. È come se non ci fosse nulla che desideri davvero.\nDoll mi ha detto che devo trovare ciò che desidero veramente nel profondo del mio cuore e chiedermi per cosa faccio tutto quello che faccio.\nCi ho pensato a lungo. In realtà spero che ogni desiderio di coloro che vengono da me possa essere esaudito. Riflettendoci meglio, credo di amare vedere i sorrisi sui volti delle persone quando i loro desideri si avverano, e il modo in cui mi abbracciano sinceramente, mi ringraziano e mi lodano per aver adempiuto ai doveri della Dea.\nDoll ha detto che questo riflette la mia speranza che il mio valore venga riconosciuto, così da poter diventare una persona utile, e credo che abbia ragione.\nMa ha anche detto che il valore di una persona non ha bisogno di essere determinato dagli altri, e che nulla è intrinsecamente utile. Ciò che conta è seguire il proprio cuore, anche se questo significa diventare qualcuno che gli altri considerano inutile.\nCome ci si aspetta da Doll, dice sempre cose così profonde. Ma dovrei diventare una persona utile o una inutile? Mi sento di nuovo confusa...\nTuttavia, se seguo il mio cuore, credo di sperare ancora di essere una persona utile. Vedere tutti sorridere il giorno del mio compleanno dovrebbe essere il regalo più grande che potrei desiderare.\n\nCeleste"
  },
  Mail_68914_Name = {
    Text = "Una persona utile..."
  },
  Mail_68914_Sender = {Text = "Celeste"},
  Mail_68915_Desc = {
    Text = "Caro Custode,\n\nMi sono da tempo abituata a uno stile di vita simile a quello dei vermi in un rigagnolo. Si potrebbe dire che è il mio destino di nascita, e l'ho pienamente accettato e abbracciato con gioia.\nSebbene sia sempre grata per avermi permesso di assaporare ancora una volta il meraviglioso gusto della libertà, nessuno riesce ad accettare i miei hobby peculiari — e a ragione. Dopotutto, la maggior parte delle persone qui sono anime gentili che non riescono a comprendere che il muschio che cresce negli angoli umidi non ha bisogno di luce solare intensa, bensì di aria oscura.\nA parte voi, mio caro e benevolo adulto, solo voi mi capite davvero, mi aiutate e mi concedete una felicità sincera. Il dolore che mi infliggete è così appagante e rassicurante — mi permette di affermare la mia esistenza.\nSe un tempo non avevo desideri da esprimere per il mio compleanno, ora desidero seguire le vostre orme e dedicarvi corpo e anima.\nNaturalmente, vi prego, non trattatemi con gentilezza per bontà d'animo; sentitevi libero di disprezzarmi, rimproverarmi o frustarmi!\n\nLeigh"
  },
  Mail_68915_Name = {
    Text = "Il Cuore di Muschio..."
  },
  Mail_68915_Sender = {Text = "Leigh"},
  Mail_68916_Desc = {
    Text = "Caro Cucciolo:\n\nHo quasi iniziato ad amare queste giornate passate a giocare al gatto col topo con te, proprio come in un banale romanzo d'avventura dove il giusto messaggero riesce sempre a sventare il piano del perfido villain all'ultimo momento—che commovente, che nobile.\nTuttavia, guardarti dibattere invano è davvero difficile da trattenere una risata.\nQuesto mondo è già condannato; non c'è modo di salvarlo, e questo pianeta finirà come innumerevoli pianeti morti, venendo ▼&#x5B▼87;&4;▼.\nPazienza, starò al gioco con te. All'improvviso, riesco in qualche modo a capire l'interesse di N; prima che la conclusione predestinata arrivi, non importa davvero quali azioni si compiano.\nPer il compleanno del tuo caro mentore, ti ho comunque preparato una grande sorpresa. Prima che il conto alla rovescia del compleanno finisca, spero che tu riesca a trovare quella \"bomba\" nascosta.\nPrima che veniamo completamente dissolti, quante gioie potrai ancora regalarmi?\n\n\n\"Doll\""
  },
  Mail_68916_Name = {
    Text = "Bomba a Sorpresa..."
  },
  Mail_68916_Sender = {
    Text = "Doll: Inferno"
  },
  Mail_68917_Desc = {
    Text = "Custode,\n\nDi recente, tra l'alta società di Londinium si è diffusa la moda di creare bozzetti di propria mano e commissionare gioielli su misura.\nQuesti sedicenti intenditori d'arte, dopo essersi vantati delle dimensioni delle loro gemme, ora si sono messi a confrontare la complessità dei loro bozzetti, ignari del fatto che il loro ricorso segreto a pittori rinomati è tanto evidente quanto suonare una campana proprio accanto alle loro orecchie.\nGrazie a questa moda, anche la lista dei miei regali di compleanno si è arricchita di parecchie gemme e gioielli piuttosto pretenziosi. Tra questi c'è un pregiato rubino sangue di piccione che al momento è privo di una montatura adeguata.\nInvece di rivolgermi a quei noiosi vecchi, perché non chiedere al mio cavaliere di disegnare per me un bozzetto fatto col cuore come regalo? Che ne pensi?\nAttendo con impazienza la tua opera; sono certa che il tuo gusto debba essere eccellente.\n\nSorel"
  },
  Mail_68917_Name = {
    Text = "Progettare Gioielli..."
  },
  Mail_68917_Sender = {Text = "Sorel"},
  Mail_68918_Desc = {
    Text = "Custode,\n\nPrima del nostro primo incontro, oltre innumerevoli Porte, avevo già visto innumerevoli versioni di te, al contempo uguali e diverse.\nRicordo le tue gioie e i tuoi dolori, ogni scelta che hai fatto e come hai perseverato in mondi differenti.\nPer me, tra tutte quelle versioni di te, tu sei la più speciale. Un tempo assegnai nomi e numeri ai mondi che osservavo, e il mondo a cui appartieni si chiama Speranza: un nome che gli diedi il giorno in cui ti incontrai.\nIn questo giorno chiamato Speranza, credo che potrebbe interessarti osservare altri mondi, come sperimentare l'universo attraverso occhi duplici. Ti guiderò a vedere tutto ciò che ho silenziosamente osservato presso le Porte.\nE anche a vedere te stesso attraverso i miei occhi.\n\nTawil"
  },
  Mail_68918_Name = {
    Text = "Un Te Diverso..."
  },
  Mail_68918_Sender = {Text = "Tawil"},
  Mail_68919_Desc = {
    Text = "In origine, il modo di fare schietto di Mythag risuonava profondamente in me, ma da quando quella donna, Miryam, è arrivata, la mia vita è diventata inquieta. \nNon respingo coloro che anelano alla stabilità e cercano rifugio; è naturale per gli esseri cercare conforto in questo mondo turbolento. \nMa non ho mai desiderato essere visto come un dio onnipotente—specialmente dopo l'inabissamento di Lemuria, non c'è bisogno di creare un'altra divinità eccelsa qui. \nMiryam probabilmente non è riuscita a lasciarsi alle spalle le ombre del suo passato, portando così quella cieca devozione nel presente, rendendomi estremamente vistoso ovunque vada, al punto da esserne perseguitato, il che è davvero esasperante. \nOggi è il mio compleanno, e scommetto che quella donna avrà già preparato la cerimonia in anticipo e starà facendo un gran trambusto; solo a sentirne parlare mi gira la testa, perciò eviterò l'occasione per sfuggire ai problemi. \nSe sei disposto, vieni all'indirizzo allegato a questa lettera e cammina con me in tranquillità. \nRicorda, non far scoprire nulla a quella donna. \n\nTulu"
  },
  Mail_68919_Name = {
    Text = "In cerca di un po' di pace e quiete..."
  },
  Mail_68919_Sender = {Text = "Tulu"},
  Mail_68920_Desc = {
    Text = "Ogni giorno soffro di una fame insopportabile, mi sento miserabile se non bevo sangue anche solo per un istante. Ma da quando ho assaggiato il tuo sangue, il sangue ordinario ha il sapore della cera in bocca, mentre il meraviglioso sapore del tuo sangue indugia nella mia gola, tentandomi ogni giorno.\nSo quanta quantità di sangue si può prelevare da una persona prima che muoia, e una tale prelibatezza è fugace. Per evitare che tu muoia troppo in fretta, sto imparando a sopportare la fame e ad attendere con trepidazione il prossimo assaggio di delizia, fino al giorno in cui potrò gustare di nuovo il tuo sangue fresco.\nAhah, mio Dio, non posso credere di esserci riuscito. Mi chiedo persino se mi sia evoluto. Considerando la mia resistenza, almeno in questo cosiddetto compleanno, lasciami assaggiare un po' del tuo sangue dolce e delizioso. Che ne dici?\nHo usato i soldi guadagnati al Club della Trota per comprarti degli integratori alimentari, quindi stavolta sicuramente non sarai anemico.\n\nUvhash, che ha fame da molto tempo"
  },
  Mail_68920_Name = {
    Text = "Sangue delizioso..."
  },
  Mail_68920_Sender = {Text = "Uvhash"},
  Mail_68921_Desc = {
    Text = "Caro Custode,\n\nSono davvero felice di aver visto i tuoi continui progressi nell'addestramento di quest'anno. Presto supererai persino il me stesso di quando ero più giovane e diventerai un soldato formidabile. È un grande onore essere il tuo istruttore.\nPer questo compleanno ho ricevuto un paio di scarponi da trekking perfetti per le escursioni in montagna. Mi chiedevo: ti andrebbe di unirti a me per un'escursione? Potremmo mettere alla prova la nostra resistenza migliorata e ammirare l'alba dalla cima della montagna. Il panorama lassù, lontano dal rumore della città, dev'essere assolutamente mozzafiato.\nNaturalmente, se potessimo anche condividere un picnic durante il nostro campeggio all'aperto, accompagnato da una bottiglia di liquore forte per tenere lontano il freddo, sarebbe ancora più perfetto.\n\nAlva"
  },
  Mail_68921_Name = {
    Text = "Escursione..."
  },
  Mail_68921_Sender = {Text = "Alva"},
  Mail_68922_Desc = {
    Text = "Partner:\n\nQuest'anno sono successe molte cose. Per te, questa potrebbe non essere stata una bella vita universitaria.\nAmmetto di averti messo troppa pressione nell'ultimo anno, e le mie attenzioni sono state prive di delicatezza. Tutti quegli allenamenti sembravano spingerti troppo oltre, facendoti sopportare troppo tutto in una volta.\nMa spero che tu sappia che nel mio cuore sarai sempre la persona più importante. Oltre a essere il Custode di Mythag, sei il mio unico partner.\nForse oggi - intendo solo per il tuo compleanno - posso provare a essere egoista per una volta, e tu puoi dimenticare tutte le responsabilità. Non dobbiamo preoccuparci di incarichi o allenamenti; rilassiamoci e divertiamoci.\nChe ne dici di andare al parco divertimenti in città? A teatro? Al centro commerciale o al mercatino... qualsiasi cosa va bene. Spero di recuperare le cose che ci siamo persi.\nAllo stesso modo, spero che in questa giornata in cui non pensiamo a nulla tu possa farmi compagnia, e che sia tu a decidere tutte le attività.\n\nRamona"
  },
  Mail_68922_Name = {
    Text = "Una giornata di relax..."
  },
  Mail_68922_Sender = {Text = "Ramona"},
  Mail_68923_Desc = {
    Text = "Caro Custode,\n\nDurante il mio tempo in questo mondo, i miei devoti servitori erano soliti organizzare sontuosi banchetti in mio onore in questo giorno ogni anno, facendo del loro meglio per intrattenermi con ogni sorta di trovata.\nQuello che era un giorno qualunque diventava straordinariamente gioioso tra quei sorrisi inspiegabili. Quando si tratta di trovare gioia nelle avversità e creare qualcosa dal nulla, gli esseri umani sono davvero imbattibili.\nPersino in questa scuola dove i cimiteri sorgono all'interno del campus, riuscite ancora tenacemente a creare felicità, il che mi stupisce sinceramente.\nTuttavia, i regali della gente comune sono piuttosto noiosi, e le cosiddette feste di compleanno sono insopportabilmente tediose; i volgari costituiscono senza dubbio la maggioranza.\nSolo tu—solo il pensiero di te riesce ancora a suscitare un certo interesse in me, permettendomi di rivivere i piaceri del passato.\nTi ordino di venire immediatamente nella mia stanza e farmi compagnia fino all'alba. Se mi servirai bene, potrei concederti con riluttanza di baciare il dorso della mia mano.\n\nWanda"
  },
  Mail_68923_Name = {Text = "Comando..."},
  Mail_68923_Sender = {Text = "Wanda"},
  Mail_68924_Desc = {
    Text = "<Del:Cucciolo dell'Ovest><Del:Custode>Custode,\nOriginariamente non avevo intenzione di scrivere di nuovo roba così sdolcinata, ma Aigis ha continuato a tormentarmi riguardo a non so quale significato commemorativo, insistendo che ti scrivessi questa lettera.\nPer il bene di Aigis, dirò qualche parola a malincuore. Beh, è passato un anno da quando sono qui. Nel complesso, sono soddisfatto dell'alloggio e del cibo della scuola, ma le lenzuola del dormitorio sono davvero troppo scivolose, e faccio fatica ad abituarmi a dormirci. Non trovi anche tu che solo le lenzuola di cotone grezzo siano comode per dormire?\nSe proprio dovessi trovare qualcosa da ridire, è che la cucina della mensa è troppo salutare. Anche se mi sento sazio dopo aver mangiato, ho sempre la sensazione di non avere sapore in bocca, il che è assolutamente incomparabile al cibo di strada!\nQuindi per la festa di compleanno di quest'anno, non ho intenzione di disturbare quegli chef. Lasciate che questo buongustaio guidi tutti nei vicoli misteriosi del Distretto Est per assaggiare le bancarelle che io e Brown raccomandiamo caldamente. Vi garantisco che rimarrete immediatamente conquistati dalle delizie di strada!\nNaturalmente, tutte le spese di oggi saranno a carico del Ragazzo del Distretto Ovest. Speranza che non ti dispiaccia?\n\nI tuoi compari,\nJenkin e Brown"
  },
  Mail_68924_Name = {
    Text = "Cibo di strada..."
  },
  Mail_68924_Sender = {Text = "Jenkin"},
  Mail_68925_Desc = {
    Text = "Caro Mecenate,\n\nA parte mia sorella, sei la prima persona a sostenermi con tanta sincerità. Grazie ai tuoi suggerimenti precedenti, ho pubblicato una serie di album con la casa discografica, e presto terrò il mio concerto da solista.\nVoglio programmare il primo concerto su questo pianeta nel giorno del mio compleanno, per commemorare la mia nuova vita qui.\nSpero che tu possa partecipare per ascoltare la mia esibizione con tutto il cuore. Vorrei invitare te e mia sorella come ospiti speciali a salire sul palco alla fine dello spettacolo per cantare insieme la mia nuova canzone. Che ne pensi?\nA proposito, non dire nulla a mia sorella: è anche il suo compleanno, e voglio farle una sorpresa.\nQuanto al desiderio di compleanno che ho promesso di esprimere per me stessa insieme a mia sorella, spero che il mio canto possa brillare di nuovo su questo pianeta.\n\nTintura"
  },
  Mail_68925_Name = {
    Text = "Concerto..."
  },
  Mail_68925_Sender = {Text = "Tintura"},
  Mail_68926_Desc = {
    Text = "Caro Custode,\n\nUn altro anno è passato senza che me ne rendessi conto. Ogni singolo giorno a Mythag è stato incredibilmente gioioso: mi sono divertita tantissimo a giocare, frequentare le lezioni e condividere pasti deliziosi con tutti. Questo è davvero il periodo più felice della mia vita. Anche quando mi sento un po' nervosa durante le missioni, combattere al fianco di tutti voi mi rende impavida: Aigis non ha mai paura.\nMi dispiace davvero tanto per tutti i problemi che ti ho causato quest'anno. Anche se la maggior parte è stata probabilmente colpa di Jenkin e delle sue birichinate, lei lo fa solo per far sorridere tutti. Spero che tu possa perdonare le nostre disattenzioni e qualsiasi offesa che potremmo aver causato.\nA proposito di Jenkin, quest'anno ha proposto di organizzare una gara di cattura delle lucciole per il mio compleanno. Ha preparato tanti barattoli trasparenti, dicendo che voleva creare molte lanterne di lucciole. Chi avrà la lanterna più luminosa sarà incoronato Re degli Insetti.\nAnche se \"Re degli Insetti\" suona un po' sciocco, il bosco estivo pieno di lucciole è davvero bellissimo. Se per caso avessi un po' di tempo libero tra i tuoi tanti impegni, ti prego, vieni a raggiungerci nel bosco per ammirare quello scenario scintillante e stellato.\n\nAigis"
  },
  Mail_68926_Name = {
    Text = "Gara di Caccia alle Lucciole..."
  },
  Mail_68926_Sender = {Text = "Aigis"},
  Mail_68927_Desc = {
    Text = "Custode! L'altro giorno, mentre nuotava nell'oceano, Aurita ha incontrato un nuovo amico che può rilasciare elettricità! È tondo e piatto, come una grande pizza!\nAurita stava per salutarlo, ma all'improvviso ha sentito un formicolio in tutto il corpo, e il nuovo amico è scappato via nuotando.\nQuando sono tornata, Doll mi ha spiegato che si trattava di una torpedine che scaricava elettricità. Aurita non ha capito del tutto, ma ha pensato che il nuovo amico fosse incredibile! Dato che il compleanno di Aurita si avvicina, Custode, mi accompagneresti a riportare indietro il nuovo amico? Potrebbe stare con i compagni di Aurita! Quella sensazione di formicolio... Custode, sicuramente piacerà anche a te!\n\nAurita"
  },
  Mail_68927_Name = {
    Text = "Un nuovo amico elettrizzante..."
  },
  Mail_68927_Sender = {Text = "Aurita"},
  Mail_68928_Desc = {
    Text = "Caro Custode,\n\nPer me, i compleanni durante l'infanzia erano una severa imposizione di mio padre: un momento in cui non potevo permettermi di rilassarmi nemmeno per un istante durante gli esercizi.\nNessun orgoglio, nessuna impetuosità, nessuna pigrizia; a parte mia madre che di nascosto mi preparava una piccola torta, questo giorno non era altro che un'occasione per ricevere rigide lezioni che evidenziavano le mie mancanze dell'anno trascorso.\nAnche ora, non sono più una studentessa di musica; grazie a te, posso toccare quella grande porta e varcare la soglia della sala suprema della musica. Tuttavia, gli insegnamenti ricevuti fin dall'infanzia mi hanno da tempo privata di qualsiasi desiderio per i piaceri mondani.\nSolo la musica, solo giocare quel requiem destinato a te, è il mio scopo ultimo in questa vita: l'unico momento in cui riesco a percepire l'esistenza di un significato.\nSe desideri trascorrere il tempo prima di addormentarti stasera insieme a me, sarò lieta di suonare per te tutta la notte fino all'alba.\n\nHameln"
  },
  Mail_68928_Name = {
    Text = "Il Desiderio di Esibirsi..."
  },
  Mail_68928_Sender = {Text = "Hameln"},
  Mail_68929_Desc = {
    Text = "Piccoletto,\n\nDa quando sono arrivato qui, pensavo di essere finalmente sfuggito a quella pazza pignola, solo per scoprire che questo tuo maledetto posto ha più regole di quante ne avesse lei. È una vita che non assaporo cosa significhi divertirsi!\nBere smodatamente è vietato, corteggiare le belle donne è vietato, i banchetti attorno al falò sono vietati, e persino l'arrosto qui impallidisce rispetto a quello dei Perishiti! Non capisco davvero come fai a sopportare questa vita insipida.\nMa gli uomini forti non si lamentano dell'ambiente che li circonda. Grazie ai miei sforzi, sono riuscito a diventare di nuovo un grande capobanda nella tua città.\nPer celebrare il compleanno del potente Signor Golia, ti invito graziosamente al banchetto che i miei sottoposti stanno organizzando in mio onore. Vino pregiato, cibo delizioso e belle donne in abbondanza: di sicuro apriranno i tuoi occhi inesperti.\nIn virtù della nostra vecchia conoscenza, non ti chiederò alcun regalo. Porta solo il tuo rispetto e offri le tue benedizioni per la rinascita del più forte.\nTieni gli occhi ben aperti e osserva bene; a quest'epoca l'anno prossimo, e l'anno dopo ancora, ovunque io sia, forgerò un nuovo cammino di conquista.\n\nGolia"
  },
  Mail_68929_Name = {Text = "Viaggio..."},
  Mail_68929_Sender = {Text = "Golia"},
  Mail_68930_Desc = {
    Text = "Custode, \n\nNon ho mai avuto intenzione di celebrare il compleanno di questa vuota esistenza, limitandomi a trattarlo come un normale giorno di addestramento. Tuttavia, inaspettatamente, il Re mi ha cercata stamattina e ha emanato un decreto, ordinandomi di non occuparmi di nulla che riguardi il Re o l'addestramento oggi, ma di dedicare l'intera giornata a me stessa.\nPer la prima volta in innumerevoli giorni e notti, il Re ha mostrato tale premura nei miei confronti, il che mi riempie davvero di inquietudine e gratitudine al tempo stesso. Eppure, avendo da tempo dedicato la mia intera vita al Re, non so dove andare né cosa fare.\nDopo qualche riflessione, l'unica cosa che posso dire di rimpiangere ora è il senso di colpa che provo verso quella bambina, Murphy. Sebbene non abbia mai nutrito il minimo rimpianto per la rinascita della mia patria, sono pienamente consapevole che ciò che le devo non può essere ripagato né compensato.\nTuttavia, se davvero c'è qualcosa che desidero sinceramente fare, potrebbe essere adempiere ancora una volta, senza alcun pudore, al ruolo di madre.\nHo acquistato appositamente il dolce che la bambina un tempo amava, considerandolo un modo per assolvere il dovere di una madre spregevole e indegna. Potrei disturbarvi chiedendovi di consegnare questo dono nelle sue mani? Vi prego, non ditele che è stato dato da me; dite semplicemente che lo avete preparato voi.\nSpero sinceramente nel vostro consenso, e ve ne sarei profondamente grata.\n\nMiryam"
  },
  Mail_68930_Name = {
    Text = "Rimediare a..."
  },
  Mail_68930_Sender = {Text = "Miryam"},
  Mail_68931_Desc = {
    Text = "Aha, dopo un'attenta e saggia riflessione, ho compreso appieno il significato del compleanno per gli esseri umani. Questo cosiddetto giorno speciale per qualcuno non è altro che un'occasione per godere di rari privilegi, ottenere oggetti preziosi e avanzare audacemente richieste agli altri.\nNon importa quali desideri di solito non si osi esprimere o nemmeno pensare: in questo giorno, c'è la possibilità che si avverino. Ha, è davvero un giorno di indulgenza più emozionante di qualsiasi festività.\nA quanto pare, negli anni passati mi sono perso così tante occasioni speciali. Ma per fortuna, con la mia lunga vita, ho ancora innumerevoli compleanni davanti a me per esprimere desideri.\nQuindi, chiedere a tutti di unirsi a me per una divertente battaglia nel giorno del mio compleanno dovrebbe essere un desiderio facile da esaudire, giusto?\n\nLotan"
  },
  Mail_68931_Name = {
    Text = "Il Privilegio della Stella del Compleanno..."
  },
  Mail_68931_Sender = {Text = "Lotan"},
  Mail_68932_Desc = {
    Text = "Custode, \n\nMan mano che invecchio, i compleanni sono gradualmente diventati uno di quei giorni che possono facilmente passare inosservati in un batter d'occhio sul calendario. Spesso, quando me ne ricordo involontariamente, il compleanno è già scivolato via silenziosamente come acqua corrente.\nNel mondo degli adulti, festeggiare il compleanno è un privilegio riservato ai bambini e alle persone con tempo da perdere; anch'io sono diventato un adulto così noioso e ho perso da tempo qualsiasi aspettativa per i compleanni.\nCi fu un anno in cui ebbi un capriccio e scolpii per me stesso una bellissima scultura a forma di torta. Negli anni successivi, non mancai mai di ordinare una torta perché avevo dimenticato il mio compleanno; semplicemente, quel giorno, recuperavo dal magazzino questa celebrazione eterna [Item], compivo il rituale di soffiare sulle candeline e consideravo il mio compleanno concluso.\nÈ stato solo quando sono arrivato a Mythag che ho capito come persone oziose e persone indaffarate potessero coesistere nella stessa persona. Inoltre, la gente qui non si accontenta di annoiarsi da sola; insiste anche nel trascinare tutti gli altri nella propria noia.\nIn questi due anni di partecipazione alle feste di compleanno a Mythag, ho preso parte a più feste di quante ne abbia frequentate in tutta la prima metà della mia vita. Ironicamente, ho persino trovato un piacere peculiare in questo tipo di celebrazioni assurde.\nForse, oltre ai temi tragici e seriosi, anche raffigurare scene assurdamente buffe della vita può essere colmo di bellezza artistica.\nA proposito, il progetto creativo per il compleanno di quest'anno è scolpire un busto di un Custode sorridente che regga la mia scultura a forma di torta.\nRicordati di venire presto al mio studio, mia musa e modello.\n\nSanga"
  },
  Mail_68932_Name = {
    Text = "Divertimento Noioso..."
  },
  Mail_68932_Sender = {Text = "Sanga"},
  Mail_68933_Desc = {
    Text = "Possa questa lettera trovarti in buona salute.\n\nDopo lunga riflessione, scrivo questa lettera in questo mondo dell'Oblio. Per molto tempo avevo quasi dimenticato il mio compleanno; in un mondo simile, le celebrazioni sono naturalmente prive di significato.\nMa da quando ti ho incontrato, sono diventata sempre più avida. Giorno dopo giorno, persino la solitudine che un tempo sopportavo è diventata insostenibile.\nIn momenti come questi, una strana emozione sorge nel mio cuore: un accenno di invidia verso la \"me\" di quel mondo, forse con un'impercettibile traccia di gelosia. Vedi, persino una come me, che si vanta della propria razionalità, può ancora nutrire pensieri così spregevoli, a dimostrazione che l'equità e la razionalità umane hanno i loro limiti.\nSo che tipo di invito mi rivolgerai, ma per il bene del tempo e dello spazio, le interferenze non necessarie vanno evitate il più possibile. Non devo, né andrò, nel tuo mondo.\nMentre scrivo, sto contemplando l'universo, il punto in cui si apre il Tunnel. Se per caso anche tu stai alzando lo sguardo, allora si può dire che stiamo contemplando lo stesso cielo stellato.\nSpero che questa lettera possa prendere il mio posto, attraversando il tempo e lo spazio, planando nel palmo della tua mano, passando attraverso i tuoi occhi e le tue labbra, per incontrarti, per stringermi a te.\nQuando abbraccerai questo Foglio di Lettera, io immaginerò di abbracciarti da questo lato del mondo.\n\nCon affetto,\nl'altra \"Ramona\""
  },
  Mail_68933_Name = {
    Text = "Contemplare Insieme l'Orizzonte..."
  },
  Mail_68933_Sender = {
    Text = "Ramona: Consunta dal tempo"
  },
  Mail_68934_Desc = {
    Text = "Mio piccolo prigioniero:\n\nLo sapevi? Così come animali diversi hanno diete diverse, persone diverse hanno bisogni differenti di calore. Alcuni si scaldano semplicemente indossando un cappotto, altri hanno bisogno di un paio di mani calde o di un abbraccio caloroso, mentre altri ancora necessitano del calore rovente della cera di candela fusa.\nUn calore così ardente e viscoso si imprime in ogni terminazione nervosa, tracciando vividamente i percorsi sinuosi della cera che cola, portando un lieve dolore e una sensazione elettrizzante finché non puoi fare a meno di gridare, sentendo davvero la tua stessa esistenza.\nA volte divento la candela, assaporando la gioia di lasciare impronte, mentre altre volte resto incantata dal calore della candela, bramando quel tipo di calore doloroso eppure dolce.\nL'inverno è arrivato a Mythag, e ultimamente ho spesso avvertito il freddo e la solitudine che porta con sé. Mio caro, dovresti sapere che giorno è oggi; il mio desiderio è semplice, e sono certa che qualcuno gentile come te sarà disposto a portarmi il calore per scacciare la solitudine.\n\nPandia"
  },
  Mail_68934_Name = {
    Text = "Calore necessario..."
  },
  Mail_68934_Sender = {Text = "Pandia"},
  Mail_68935_Desc = {
    Text = "Custode,\n\nQuest'anno, Tintura e io abbiamo stretto un patto: i nostri desideri di compleanno possono riguardare solo noi stesse, e non possiamo esprimere desideri l'una per l'altra.\nAnche se è stata lei a mettere il broncio e a proporre questo accordo, è evidente che l'ha messa un po' in difficoltà.\nSiamo state intrecciate insieme per così tanto tempo che pensare in modo indipendente come una persona normale è piuttosto difficile. Tuttavia, rinate in questa nuova vita piena di aiuto e premure, non c'è mai stato momento migliore per imparare a camminare con le proprie gambe.\nDopo un'attenta riflessione, ho trovato il desiderio che voglio esprimere quest'anno: fare cinque nuove amicizie... no, meglio tre. Dopotutto, cambiare sé stesse è qualcosa che va fatto gradualmente, un passo alla volta.\nIn quanto unica e più popolare amica che ho al momento, forse potresti insegnarmi qualche segreto per fare amicizia?\n\nFaint"
  },
  Mail_68935_Name = {
    Text = "Il Desiderio di Amicizia..."
  },
  Mail_68935_Sender = {Text = "Faint"},
  Mail_68936_Desc = {
    Text = "Custode, \n\nOgni anno, nel giorno del mio compleanno, esprimo lo stesso desiderio: la Metamorfosi di un lignaggio perfetto. Ho sempre saputo che la mia ossessione per il lignaggio potesse sembrare ostinata, ridicola, o persino pietosa agli occhi degli altri.\nMa tu sei diverso; non importa quando, so che mi sosterrai nel percorrere questa strada, anche se dovessi incontrare ostacoli, cadere, o tornare a mani vuote, tra le risate degli altri, tu sei il primo a prendersi cura di me.\nForse né tu né nessun altro potete comprendere tutto ciò che porta dentro una persona oppressa e umiliata fin dall'infanzia, ma non importa; le avversità su questo cammino di Metamorfosi si sono trasformate nella mia Caro e nel mio sangue, nutrendomi per rialzarmi continuamente e resistere.\nNon sono più l'essere impotente della mia giovinezza; non importa quante prove dovrò affrontare, camminerò con risolutezza fino all'ultimo istante.\nFino ad allora, ti prego, veglia su di me e attendi il mio successo.\nA proposito, riguardo ai cinquanta soldi che mi hai dato tempo fa, ti avevo detto che te li avrei restituiti. Ora ho risparmiato abbastanza, con due soldi in più, considerali un rimborso complessivo.\n\nCaecus"
  },
  Mail_68936_Name = {Text = "Paga..."},
  Mail_68936_Sender = {Text = "Caecus"},
  Mail_68937_Desc = {
    Text = "Caro Custode,\n\nSalve e benvenuto al sondaggio annuale di manutenzione per l'automa Erica. Raccoglierò le tue esperienze reali e i problemi riscontrati durante l'utilizzo di Erica nell'ultimo anno. Il tuo feedback è la chiave per il miglioramento continuo di Erica.\nTi prego di valutare le seguenti domande da un punteggio basso a uno alto nella tua risposta. Grazie mille per il tuo feedback.\nComodità d'uso: 1-5 punti\nVelocità di risposta durante l'uso: 1-5 punti\nComprensione dei requisiti: 1-5 punti\nAttenzione alle emozioni dell'utente: 1-5 punti\nPrecisione nella ricerca di informazioni: 1-5 punti\nPraticità delle soluzioni proposte: 1-5 punti\nInfine, descrivi brevemente eventuali problemi riscontrati durante l'utilizzo di Erica e qualsiasi aspetto di insoddisfazione; questi problemi potrebbero essere risolti in seguito.\nDopo aver completato il sondaggio, un piccolo regalo commemorativo verrà inviato nella tua stanza. La tua assistente più premurosa, Erica, continuerà ad accompagnarti nel prossimo anno. Grazie ancora per il tuo utilizzo. Arrivederci.\n\nErica"
  },
  Mail_68937_Name = {
    Text = "Sondaggio annuale di manutenzione..."
  },
  Mail_68937_Sender = {Text = "Erica"},
  Mail_68938_Desc = {
    Text = "Custode, \n\nOgni compleanno, trascorro l'intera giornata a rivivere meticolosamente il passato e a riscrivere le stesse pagine del diario.\nPiù a lungo resto lontano dalla mia patria, più i vecchi ricordi sembrano sfumare — quei giorni trascorsi ad attendere il ritorno di qualcuno guidato dalla luce, quei giorni passati a contemplare la grandezza del Re, sembrano quasi impossibili da ricordare con precisione.\nMa non desidero dimenticare; non dimenticherò mai, per quanto lunga possa essere l'attesa, per quanto possa bruciare la mia anima. Questa luce non si affievolirà fino al giorno in cui la mia patria rinascerà. Sarò la prima luce a rispondere all'Evocazione.\nHo immaginato innumerevoli scenari di ricongiungimento, eppure non mi sarei mai aspettato di vedere il Re e il Sacerdote qui. Secondo le tue parole, se il luogo di pace per l'anima può essere considerato casa, questo può essere considerato la mia seconda casa, e ciò che ho scritto nel mio diario si è finalmente trasformato da ricordi in fresche memorie quotidiane.\nNon c'è bisogno di ricompense o doni; poter seguire nuovamente il Re è la più grande felicità.\nSe questa luce non può illuminare i fondali della mia patria, allora che segua le orme del Re, illuminando temporaneamente questa terra.\n\nFaros"
  },
  Mail_68938_Name = {
    Text = "Seguire il mio Signore..."
  },
  Mail_68938_Sender = {Text = "Faros"},
  Mail_68939_Desc = {
    Text = "Custode, \n\nCongratulazioni a me, congratulazioni a te, congratulazioni a Mythag e congratulazioni a noi per essere sopravvissuti un altro anno sotto la persecuzione del Sintomo: Terrore Nero.\nOggi non è un semplice compleanno; è l'anniversario della mia sopravvivenza, un giorno per celebrare la mia vita resiliente.\nEssere vivi—queste due semplici parole racchiudono così tante difficoltà. Questa vitalità ardente può essere eguagliata solo dall'aroma del caffè caldo. Unisciti al Culto del Caffè, Custode, e lodiamo insieme la lucidità e celebriamo ogni istante di vita.\n\nUna nota allegata alla lettera: \nAhimè, Winkle ha esagerato ancora una volta con il caffè. Con i nervi sovraeccitati e una stanchezza estrema, è svenuta proprio alla sua scrivania. L'ho già assistita nell'infermeria della scuola, quindi non preoccuparti.\nTuttavia, prima di perdere i sensi, ha tirato fuori un sacchetto di chicchi di caffè pregiati e alcuni fogli da lettera, apparentemente con l'intenzione di darli a te. Li ho inclusi con questa lettera, sperando che non se ne penta quando si sveglierà.\nQuanto al suo compleanno, forse lasciarla riposare bene è il regalo migliore piuttosto che organizzare una festa.\n—Sylvia"
  },
  Mail_68939_Name = {
    Text = "Lodiamo la Nostra Vita..."
  },
  Mail_68939_Sender = {Text = "Winkle"},
  Mail_68940_Desc = {
    Text = "Custode,\n\nHahaha! Dopo aver insistentemente segnato 12 promemoria in ogni angolo della mia stanza e scritto 36 bigliettini (o forse di più, ma non riesco a trovarli), finalmente mi sono ricordata senza fallo che oggi è il mio compleanno!\nNon te lo aspettavi, vero? In realtà, me ne sono ricordata solo stamattina, ma è tutto merito dei preparativi che ho fatto con tanto impegno quest'anno. Non voglio assolutamente perdermi questo giorno speciale.\nL'ultima festa che ho fatto con tutti è stata davvero divertente, soprattutto i giochi a cui abbiamo giocato, e quel certo dolce che abbiamo mangiato... Ah beh, insomma, è stato semplicemente meraviglioso!\nQuando ero piccola, la mia mamma mi comprava sempre un libro di avventure per il compleanno. Leggevamo insieme ogni sera prima di dormire, e io sognavo avventure emozionanti. Anche se le dimenticavo in fretta al risveglio, la gioia rimaneva nella mia mente, e credo che le emozioni preziose non vengano dimenticate.\nInoltre, la smemoratezza ha i suoi vantaggi. Anche se non ricordo cosa è successo all'ultima festa, oggi posso rivivere tutto da capo! Quindi, per favore, impacchetta la gioia dell'ultima volta e mandamene un'altra porzione!\n\nNautila, piena di aspettativa"
  },
  Mail_68940_Name = {Text = "Riprova..."},
  Mail_68940_Sender = {Text = "Nautila"},
  Mail_68941_Desc = {
    Text = "Caro Custode,\n       Nell'aggiornamento V1.7.1, lo stato di sblocco dell'evento \"Helot: Catena\" in \"Frenesia Riproduttiva\" è andato perduto in modo anomalo. Poiché hai effettuato un nuovo sblocco dopo la perdita dello stato precedente, ti compenseremo per le \"Soglia della Realtà *3\" consumate durante il nuovo sblocco. Ti preghiamo di verificare."
  },
  Mail_68941_Name = {
    Text = "Helot: ricompense per lo sblocco della Propagazione Frenetica di Catena"
  },
  Mail_68941_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_71330_Desc = {
    Text = "Caro Custode,\nL'evento \"A un Passo\" è terminato. Le tue rimanenti \"Parti di Bambola\" saranno scambiate al tasso di 40 \"Rose Scritte\" ciascuna. Assicurati di controllare il tuo inventario."
  },
  Mail_71330_Name = {
    Text = "Parte di Bambola convertita"
  },
  Mail_71330_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_71331_Desc = {
    Text = "Stimato Custode,\nL'evento \"Magia delle Storie\" è terminato. Le tue rimanenti \"Ispirazione alla Deriva\" sono state convertite al tasso di 1 oggetto = \"Rosa Scritta*40\". Ricordati di controllare e riscuoterle."
  },
  Mail_71331_Name = {
    Text = "Ispirazione alla Deriva convertita"
  },
  Mail_71331_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_71332_Desc = {
    Text = "Stimato Custode,\nL'evento \"Prima che la primavera appassisca\" è terminato. Le tue rimanenti \"Poesie di Gioia\", \"Poesie di Malinconia\" e \"Poesie di Rimpianto\" sono state convertite al tasso di 1 oggetto = \"Rosa Scritta*40\". Controlla e riscuotile."
  },
  Mail_71332_Name = {
    Text = "Poema convertito"
  },
  Mail_71332_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_71848_Desc = {
    Text = "Egregio Custode,\nL'evento \"Epistola alla Rosa\" è terminato. I rimanenti \"Ventaglio di Piume Spiritiche\" in tuo possesso saranno convertiti al tasso di 1:40 in \"Rose Scritte\". Ti preghiamo di verificare il tuo inventario, Custode."
  },
  Mail_71848_Name = {
    Text = "Ventaglio di Piume Spiritiche convertito"
  },
  Mail_71848_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_74020_Desc = {
    Text = "Caro Custode,\nL'evento \"Le Stelle Sono Allineate: Replica\" è terminato. I rimanenti \"Embrione Inconsapevole\", \"Embrione Senza Desiderio\" e \"Embrione Insaziabile\" saranno convertiti al tasso di \"Rosa Scritta *40\" ciascuno. Ti preghiamo di confermare la conversione, Custode."
  },
  Mail_74020_Name = {
    Text = "Embrione convertito"
  },
  Mail_74020_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_74347_Desc = {
    Text = "Caro Custode,\nL'evento \"Pastore di Anime: Replica\" è terminato. I rimanenti \"Buoni di Carità\" saranno ora scambiati al tasso di \"Rosa Scritta*40\" ciascuno. Ricordati di controllare la tua posta, Custode."
  },
  Mail_74347_Name = {
    Text = "Coupon di Beneficenza convertito"
  },
  Mail_74347_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_74841_Desc = {
    Text = "Partner,\n\nIn questo giorno, un anno fa, non avrei mai potuto immaginare che un anno dopo avrei potuto solo lasciare questa lettera in una cassetta postale vuota.\nEri appena arrivato a Mythag ed eri indisciplinato e pigro come qualsiasi studente potesse essere. Anche ora, ripensandoci, mi rendo conto che sono stata troppo dura con te e troppo preoccupata di mantenere la mia facciata razionale e riservata.\nIn realtà, in questo stesso giorno un anno fa, comprai un mazzo di fiori. Rimasi in piedi davanti alla biblioteca, contemplando a lungo le rose avvolte in nastri rossi e carta verde scuro, prima di posarle infine accanto al mio letto.\nÈ passato un anno e i fiori sono appassiti da tempo. Solo il nastro rosso vivo è rimasto, legato alla chiave d'argento K-0617, ancora vivido come nuovo.\nQuanto vorrei comprare un altro mazzo, ma ora non avrebbero altro posto dove andare se non appassire di nuovo accanto al mio letto.\nAbituata a elencare meticolosamente soluzioni dettagliate per ogni cosa, la sensazione del rimpianto mi risulta strana e amara.\nEppure, ho sempre conservato una fede quasi cieca, credendo che la tua anima non se ne sia mai veramente andata. Forse sta vagando temporaneamente in qualche luogo dell'universo, ma alla fine tornerai qui, al mio fianco.\nNon credo che questo sia il sogno di una sciocca, perché ogni volta che mi reco alla Pozza Nera e contemplo il tuo volto, il mio cuore sente ancora il caldo filo di connessione e risonanza con te.\nCrederò sempre e spererò nel giorno in cui ci riuniremo. Nell'istante in cui le nostre mani si stringeranno di nuovo, ti consegnerò personalmente le rose che ti devo oggi.\n\nRamona"
  },
  Mail_74841_Name = {Text = "Rose..."},
  Mail_74841_Sender = {Text = "Ramona"},
  Mail_76410_Desc = {
    Text = "Caro Custode,\nL'evento \"Fantasma della Città Piovosa\" è terminato. I rimanenti \"Teschio di Bestia Pallida\", \"Teschio della Bestia Umbratile\" e \"Teschio di Bestia Cremisi\" saranno convertiti al tasso di \"Rosa Scritta*40\" ciascuno. Ricordati di controllare."
  },
  Mail_76410_Name = {
    Text = "Valuta Fantasma della Città Piovosa convertita"
  },
  Mail_76410_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_78653_Desc = {
    Text = "Caro Custode,\nL'evento \"Guarigione Molteplice: Replica\" è terminato. Ritireremo la valuta evento rimanente \"Puzzle della Memoria\" al tasso di cambio di 40 Rose Scritte per unità. Ricordati di controllare le tue ricompense."
  },
  Mail_78653_Name = {
    Text = "Puzzle della Memoria convertito"
  },
  Mail_78653_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_78792_Desc = {
    Text = "Caro Custode,\nL'evento \"Quando la Neve si Scioglie: Replica\" si è concluso. Le valute evento rimanenti del Custode, \"Bocciolo Ghiacciato\", \"Bocciolo di Brina Argentea\" e \"Bocciolo di Luce Solare\", saranno riscattate al tasso di \"Rosa Scritta * 40\" ciascuna. Ricordati di riscuoterle."
  },
  Mail_78792_Name = {
    Text = "Germoglio convertito"
  },
  Mail_78792_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_79390_Desc = {
    Text = "Caro Custode, \n Grazie per il tuo supporto a [Morimens]. Per offrirti un'esperienza di gioco migliore all'Università di Mythag, ti invitiamo cordialmente a compilare il seguente questionario di ricerca sull'esperienza. In segno di gratitudine, abbiamo preparato [Silver*200] come ricompensa, che potrai riscuotere al completamento. La scadenza del questionario è il 17 marzo alle ore 9:00. Ti preghiamo di compilarlo entro i tempi previsti.\n   <SurveyLink:[Click to Fill]>\n   Ascolteremo con attenzione i suggerimenti di ogni Custode, e il tuo feedback contribuirà certamente a rendere l'Università di Mythag sempre migliore!\n —Che la Chiave d'Argento illumini il tuo cammino."
  },
  Mail_79390_Name = {
    Text = "Sondaggio esperienza versione V2.1.0"
  },
  Mail_79390_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_79646_Desc = {
    Text = "Caro Custode,\nL'evento \"Sepolto nella Memoria\" è terminato. I tuoi rimanenti Rapporto Diagnostico saranno convertiti al tasso di Rosa Scritta*40 ciascuno. Assicurati di controllarli, Custode."
  },
  Mail_79646_Name = {
    Text = "Valuta Sepolto nella Memoria convertita"
  },
  Mail_79646_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_80091_Desc = {
    Text = "Custode,\n\nQuando aprirai questa lettera, significherà che il suggerimento che ho piantato nel tuo cuore ha messo radici.\nAh, non preoccuparti. Si tratta solo di una lieve ipnosi per assicurarmi che la celebrazione del mio compleanno proceda senza intoppi - non ti influenzerà in alcun modo.\nPresto sentirai un impulso autentico di andare a fare acquisti. Segui semplicemente questo impulso per le strade, scegli tra le vetrine scintillanti il regalo che mi chiama a sé, e portamelo direttamente.\nComprendo la tua confusione attuale e ne riconosco la legittimità, ma le festeggiare hanno diritto a certi privilegi, non è vero? Lo faccio solo perché temo che tu possa dimenticare questa occasione speciale. Dopotutto, sei proprio l'ospite che desideravo ardentemente.\nInfine, attenderò pazientemente il tuo arrivo — non dimenticare il regalo.\n\nClementine"
  },
  Mail_80091_Name = {
    Text = "Dono scelto personalmente"
  },
  Mail_80091_Sender = {Text = "Clementine"},
  Mail_81288_Desc = {
    Text = "Caro Custode,\n  Grazie per il tuo supporto a \"Morimens\". Per migliorare la tua esperienza di gioco all'Università di Mythag, ti invitiamo a compilare il seguente sondaggio sull'esperienza. Per ringraziarti della collaborazione, abbiamo preparato \"Argento*200\" come ricompensa, disponibile al completamento del sondaggio. La scadenza è il 14 aprile alle ore 9:00, ti preghiamo di inviarlo entro i tempi previsti.\n<SurveyLink:\"Clicca per compilare\">\nConsidereremo con attenzione ogni suggerimento dei Custodi, e il tuo feedback renderà certamente l'Università di Mythag ancora migliore!\n—Che la Chiave d'Argento illumini il cammino."
  },
  Mail_81288_Name = {
    Text = "Sondaggio esperienza versione V2.2.0"
  },
  Mail_81288_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_81326_Desc = {
    Text = "Caro Benefattore:\n\nOggi è l'unica festa dell'anno per me e Pollux. Nella chiesa, non ci è permesso concentrarci eccessivamente sulla nostra importanza personale; il nostro intero valore risiede unicamente nel servire l'eterno dovere della Chiesa della luce del tempio. Di fronte a tale fede, qualsiasi altra festa è un'illusione priva di significato.\nEppure, in questo compleanno, io e Pollux festeggiamo ancora di nascosto. Prepariamo l'uno per l'altro un regalo il più piccolo possibile, nascondendolo agli inservienti, e attendiamo segretamente questo giorno.\nLa celebrazione avviene spesso a tarda notte— è l'unico momento libero che abbiamo in una giornata. Le mani abili e le idee creative di Pollux fanno sì che i suoi regali superino sempre i miei. Una volta, ha persino intrecciato un fiore in boccio usando piume cadute che aveva raccolto.\nIn realtà, non sono bravo a preparare sorprese. Pollux dice spesso che le mie espressioni abituali tradiscono già tutto, e ciò che ho da offrire deve sembrarti ancora più tedioso e arido. Tuttavia, oggi ho trovato un modo perfetto per condividere la gioia con te.\nQuando sentirai tre colpi alla finestra durante la notte, ti prego, non avere paura; apri la finestra e ti porterò a sperimentare il tocco delle nuvole e la brezza notturna.\n\nCastor"
  },
  Mail_81326_Name = {
    Text = "Passeggiata Notturna..."
  },
  Mail_81326_Sender = {Text = "Castor"},
  Mail_84142_Desc = {
    Text = "Custode, \n\nPrima della convergenza, ho scritto questa lettera per invitarti formalmente e presentarti il mio \"Viaggio di Gestazione\". \nLa prima tappa di questo viaggio è il fiume Tamigi. Saliremo a bordo di una nave cargo convertita in un ristorante galleggiante, gustando ananas caramellato al miele in scatola e rum mentre pagaiamo. Questa prelibatezza viene offerta esclusivamente all'equipaggio nel giorno della loro Gestazione, e spero che la apprezzerai. \nLa seconda tappa di questo viaggio è il ponte di osservazione al porto. Stai tranquillo/a, ho richiesto i diritti di osservazione all'associazione delle mongolfiere. Quando la mongolfiera si innalzerà nel cielo, dominando l'intero corso d'acqua londinese, taglieremo insieme la torta per festeggiare. \nIn passato, le condizioni di navigazione erano limitate, e la cosiddetta torta di compleanno era semplicemente un modello in legno realizzato dal carpentiere con quercia e caramello, perciò non ho mai assaggiato una vera torta. Questa volta, poter condividere quell'esperienza con te, credo che oltre alla gioia del cibo, ne ricaverò molto di più. \nLa terza tappa, o meglio, il terzo segmento dovrebbe essere la mappa stellare personalizzata. Ho segnato le posizioni celesti della mia nascita sulla carta nautica, e se non ti dispiace, vorrei segnare anche le tue. Questa mappa stellare di navigazione unica sarà il dono più prezioso. \nIn realtà, quando ho scritto questa lettera, ho esitato. Queste azioni superano indubbiamente i limiti ordinari, ma oggi è un giorno speciale, e tu sei una persona speciale per me, per cui vale la pena infrangere le convenzioni. \nPerciò ti prego, non rifiutarmi e arriva puntualmente. \n\nCorposant"
  },
  Mail_84142_Name = {
    Text = "Invito a salpare..."
  },
  Mail_84142_Sender = {Text = "Corposant"},
  Mail_84355_Desc = {
    Text = "Caro Custode,\nL'evento \"Ondeggiando nella tempesta\" è terminato. Qualsiasi valuta evento rimanente, \"Bandiere di Segnalazione\", sarà ora scambiata al tasso di 40 \"Rose Scritte\" per bandiera. Assicurati di controllare il tuo inventario, Custode."
  },
  Mail_84355_Name = {
    Text = "Bandiera di Segnalazione convertita"
  },
  Mail_84355_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_84410_Desc = {
    Text = "Caro Custode, \n Grazie per il tuo supporto a [Morimens]. Per offrire ai Custodi dell'Università di Mythag un'esperienza di gioco migliore, ti invitiamo cordialmente a compilare il seguente sondaggio. Come segno di gratitudine per la tua collaborazione, abbiamo preparato [Silver*200] come ricompensa, che potrai riscuotere dopo aver completato il sondaggio. La scadenza del sondaggio è il 5 maggio alle 9:00 — ricorda di compilarlo in tempo.\n       <SurveyLink:[Click here to fill out]>\n       Prenderemo in attenta considerazione i suggerimenti di ogni Custode, e il tuo feedback contribuirà a rendere l'Università di Mythag ancora migliore!\n       —Che la Chiave d'Argento ci Guidi."
  },
  Mail_84410_Name = {
    Text = "Sondaggio esperienza versione V2.2.1"
  },
  Mail_84410_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_89744_Desc = {
    Text = "Caro Custode,\n       Nell'aggiornamento V2.2.2, abbiamo aumentato le ricompense per \"Donazione Essenza di Silver Core - Fondo Donazioni Alumni\". Per i Custodi che avevano già riscosso tutte le ricompense aggiuntive prima dell'aggiornamento, provvederemo a inviare la compensazione corrispondente. Ti preghiamo di controllare il tuo Inventario."
  },
  Mail_89744_Name = {
    Text = "V2.2.2 Riemissione ricompense donazione Essenza di Silver Core"
  },
  Mail_89744_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_89902_Desc = {
    Text = "Caro Custode, \n Grazie per il tuo supporto a [Morimens]. Per offrire ai Custodi dell'Università di Mythag un'esperienza di gioco migliore, ti invitiamo cordialmente a compilare il seguente sondaggio. Come segno di gratitudine, abbiamo preparato [Silver*200] come ricompensa, che potrai riscuotere al completamento del sondaggio. La scadenza del sondaggio è il 27 maggio alle 9:00. Assicurati di compilarlo in tempo.\n       <SurveyLink:[Click here to fill out]>\n       Prenderemo in attenta considerazione i suggerimenti di ogni Custode, e il tuo feedback contribuirà sicuramente a rendere l'Università di Mythag ancora migliore!\n       —Che la Chiave d'Argento ci Guidi."
  },
  Mail_89902_Name = {
    Text = "Sondaggio esperienza versione V2.2.1"
  },
  Mail_89902_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_89903_Desc = {
    Text = "Gentile Custode:\n        Grazie per il tuo supporto e riconoscimento verso [Prima dell'Alba dell'Oblio]. Per migliorare l'esperienza di gioco dei Custodi all'Università di Mythag, ti invitiamo a compilare il seguente sondaggio sull'esperienza. Come ringraziamento per la tua collaborazione, abbiamo preparato Argento × 200 come ricompensa, che potrai ricevere al completamento del sondaggio. Il sondaggio scade il 9 novembre alle 9:00; ti preghiamo di compilarlo in tempo.\n        <SurveyLink:[Clicca qui per compilare]>\n        Ascolteremo attentamente i suggerimenti di ogni Custode, e il tuo feedback contribuirà sicuramente a rendere l'Università di Mythag sempre migliore!\n        — Che la Chiave d'Argento illumini il tuo cammino."
  },
  Mail_89903_Name = {
    Text = "Sondaggio esperienza versione V2.6.2"
  },
  Mail_89903_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_89904_Desc = {
    Text = "Caro Custode:\n        Grazie per il tuo supporto e il tuo apprezzamento verso [Morimens]. Per migliorare la tua esperienza di gioco all'Università di Mythag, ti invitiamo cordialmente a compilare il seguente sondaggio. Come segno di gratitudine per la tua collaborazione, abbiamo preparato [Silver*200] come ricompensa, che potrai riscuotere al completamento del sondaggio. La scadenza per il sondaggio è il 23 febbraio alle 9:00, quindi assicurati di compilarlo in tempo.\n        <SurveyLink:[Click here to fill out]>\n        Considereremo attentamente i suggerimenti di ogni Custode, e il tuo feedback renderà sicuramente l'Università di Mythag ancora migliore!\n        —Che la Chiave d'Argento Illumini il Cammino."
  },
  Mail_89904_Name = {
    Text = "Sondaggio esperienza versione V2.4.2"
  },
  Mail_89904_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_89905_Desc = {
    Text = "Caro Custode:\n        Grazie per il tuo supporto e il tuo apprezzamento per [Morimens.] Per offrire una migliore esperienza di gioco ai Custodi dell'Università di Mythag, ti invitiamo sinceramente a compilare il seguente sondaggio sull'esperienza. Come segno della nostra gratitudine, abbiamo preparato Argento × 200 come ricompensa, che potrai richiedere al completamento del sondaggio. Il sondaggio si chiude l'8 giugno alle 9:00. Assicurati di compilarlo in tempo.\n        <SurveyLink:[Clicca qui per compilare]>\n        Prenderemo attentamente in considerazione il feedback di ogni Custode, e il tuo contributo aiuterà sicuramente a rendere l'Università di Mythag sempre migliore!\n        —Che la Chiave d'Argento illumini il tuo cammino."
  },
  Mail_89905_Name = {
    Text = "Sondaggio esperienza versione V2.5.1"
  },
  Mail_89905_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_89906_Desc = {
    Text = "Caro Custode:\n        Grazie per il tuo supporto e la tua fiducia in [Morimens]. Per offrire ai Custodi dell'Università di Mythag un'esperienza di gioco migliore, ti invitiamo cordialmente a compilare il seguente sondaggio. Come segno di gratitudine per la tua collaborazione, abbiamo preparato [Silver*200] come ricompensa, riscuotibile al completamento del sondaggio. La scadenza del sondaggio è il 22 dicembre alle 9:00, quindi assicurati di compilarlo in tempo.\n        <SurveyLink:[Click Here to Fill Out]>\n        Prenderemo in attenta considerazione i suggerimenti di ogni Custode, e il tuo feedback contribuirà sicuramente a rendere l'Università di Mythag ancora migliore!\n        —Che la Chiave d'Argento Illumini il Cammino."
  },
  Mail_89906_Name = {
    Text = "Sondaggio esperienza versione V2.4.0"
  },
  Mail_89906_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_89907_Desc = {
    Text = "Caro Custode:\n        Grazie per il tuo supporto e il tuo apprezzamento per [Morimens]. Al fine di offrire una migliore esperienza di gioco ai Custodi dell'Università di Mythag, ti invitiamo cordialmente a compilare il seguente sondaggio sull'esperienza. Come segno di gratitudine per la tua collaborazione, abbiamo preparato [Silver*200] come ricompensa, che potrai riscuotere al completamento del sondaggio. La scadenza per il sondaggio è il 19 gennaio alle 9:00, quindi assicurati di compilarlo in tempo.\n        <SurveyLink:[Click here to fill out]>\n        Prenderemo in attenta considerazione i suggerimenti di ogni Custode, e il tuo feedback contribuirà sicuramente a rendere l'Università di Mythag ancora migliore!\n        —Che la Chiave d'Argento Illumini il Cammino."
  },
  Mail_89907_Name = {
    Text = "Sondaggio esperienza versione V2.4.1"
  },
  Mail_89907_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_89908_Desc = {
    Text = "Caro Custode: \n        Grazie per il tuo supporto e il tuo apprezzamento verso [Morimens]. Per garantire una migliore esperienza di gioco ai Custodi dell'Università di Mythag, ti invitiamo cordialmente a compilare il seguente sondaggio sull'esperienza. Come segno della nostra gratitudine, abbiamo preparato Argento × 200 come ricompensa, che potrai riscattare al completamento del sondaggio. Il sondaggio si chiude il 20 luglio alle 9:00. Assicurati di compilarlo in tempo. \n        <SurveyLink:[Click here to fill it out]>\n        Prenderemo attentamente in considerazione il feedback di ogni Custode, e il tuo contributo aiuterà sicuramente a rendere l'Università di Mythag sempre migliore! \n        —Che la Chiave d'Argento Illumini il Cammino."
  },
  Mail_89908_Name = {
    Text = "Sondaggio esperienza versione V2.5.2"
  },
  Mail_89908_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_89909_Desc = {
    Text = "Caro Custode:\n        Grazie per il tuo supporto e il tuo apprezzamento per [Morimens.] Per offrire ai Custodi un'esperienza di gioco migliore all'Università di Mythag, ti invitiamo cordialmente a compilare il seguente sondaggio sull'esperienza. Come segno della nostra gratitudine, abbiamo preparato Argento × 200 come ricompensa, che potrai riscuotere al completamento del sondaggio. Il sondaggio si chiude il 14 settembre alle 9:00. Assicurati di compilarlo in tempo.\n        <SurveyLink:[Click here to fill out]>\n        Considereremo attentamente il feedback di ogni Custode, e il tuo contributo aiuterà sicuramente a rendere l'Università di Mythag sempre migliore!\n        —Che la Chiave d'Argento Illumini il Cammino."
  },
  Mail_89909_Name = {
    Text = "Sondaggio esperienza versione V2.6.0"
  },
  Mail_89909_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_89910_Desc = {
    Text = "Caro Custode, \n Grazie per il tuo supporto a [Morimens]. Per offrire ai Custodi dell'Università di Mythag un'esperienza di gioco migliore, ti invitiamo cordialmente a compilare il seguente sondaggio. Come segno di gratitudine, abbiamo preparato [Silver*200] come ricompensa, che potrai riscuotere al completamento del sondaggio. La scadenza del sondaggio è il 23 giugno alle 9:00. Assicurati di compilarlo in tempo.\n       <SurveyLink:[Click here to fill out]>\n       Prenderemo in attenta considerazione i suggerimenti di ogni Custode, e il tuo feedback contribuirà sicuramente a rendere l'Università di Mythag ancora migliore!\n       —Che la Chiave d'Argento ci Guidi."
  },
  Mail_89910_Name = {
    Text = "Sondaggio esperienza versione V2.2.2"
  },
  Mail_89910_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_89911_Desc = {
    Text = "Caro Custode, \n        Grazie per il tuo supporto a [Morimens]. Per offrire ai Custodi un'esperienza di gioco migliore presso l'Università di Mythag, ti invitiamo cordialmente a compilare il seguente sondaggio. Come segno della nostra gratitudine, abbiamo preparato [Silver*200] come ricompensa, riscuotibile al completamento del sondaggio. La scadenza del sondaggio è il 1° settembre alle 9:00, quindi assicurati di compilarlo in tempo.\n        <SurveyLink:[Click here to fill it out]>\n        Prenderemo in attenta considerazione i suggerimenti di ogni Custode, e il tuo feedback renderà sicuramente l'Università di Mythag sempre migliore!\n        ——Che la Chiave d'Argento ci Guidi."
  },
  Mail_89911_Name = {
    Text = "Sondaggio esperienza versione V2.3.1"
  },
  Mail_89911_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_89912_Desc = {
    Text = "Caro Custode, \n        Grazie per il tuo supporto a [Morimens]. Per offrire ai Custodi un'esperienza di gioco migliore presso l'Università di Mythag, ti invitiamo cordialmente a compilare il seguente sondaggio. Come segno della nostra gratitudine, abbiamo preparato [Silver*200] come ricompensa, riscuotibile al completamento del sondaggio. La scadenza del sondaggio è il 4 agosto alle 9:00, quindi assicurati di compilarlo in tempo.\n        <SurveyLink:[Click here to fill it out]>\n        Prenderemo in attenta considerazione i suggerimenti di ogni Custode, e il tuo feedback renderà sicuramente l'Università di Mythag sempre migliore!\n        ——Che la Chiave d'Argento ci Guidi."
  },
  Mail_89912_Name = {
    Text = "Sondaggio esperienza versione V2.3.0"
  },
  Mail_89912_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_89913_Desc = {
    Text = "Caro Custode, \nGrazie per il tuo supporto a [Morimens]. Per offrire ai Custodi un'esperienza migliore presso l'Università di Mythag, ti invitiamo cordialmente a compilare il seguente sondaggio. Come segno di gratitudine, abbiamo preparato [Silver*200] come ricompensa, riscuotibile al completamento del sondaggio. Il sondaggio si chiuderà il 29 settembre alle 9:00, quindi assicurati di inviarlo in tempo.\n<SurveyLink:[Click here to complete the survey]>\nPrenderemo in attenta considerazione i suggerimenti di ogni Custode, e il tuo feedback contribuirà sicuramente a rendere l'Università di Mythag sempre più forte e migliore!\n——Che la Chiave d'Argento ci Guidi."
  },
  Mail_89913_Name = {
    Text = "Sondaggio esperienza versione V2.3.2"
  },
  Mail_89913_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_89914_Desc = {
    Text = "Caro Custode: \n        Grazie per il tuo supporto e il tuo apprezzamento verso [Morimens]. Per garantire una migliore esperienza di gioco ai Custodi dell'Università di Mythag, ti invitiamo cordialmente a compilare il seguente sondaggio sull'esperienza. Come segno della nostra gratitudine, abbiamo preparato Argento × 200 come ricompensa, che potrai riscattare al completamento del sondaggio. Il sondaggio si chiude l'11 maggio alle 9:00. Assicurati di compilarlo in tempo.\n        <SurveyLink:[Click here to fill it out]>\n        Prenderemo attentamente in considerazione il feedback di ogni Custode, e il tuo contributo aiuterà sicuramente a rendere l'Università di Mythag sempre migliore!\n        —Che la Chiave d'Argento Illumini il Cammino."
  },
  Mail_89914_Name = {
    Text = "Sondaggio esperienza versione V2.5.0"
  },
  Mail_89914_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_89915_Desc = {
    Text = "Caro Custode:\n        Grazie per il tuo supporto e il tuo apprezzamento per \"Morimens.\" Per offrire ai Custodi un'esperienza di gioco migliore all'Università di Mythag, ti invitiamo cordialmente a compilare il seguente sondaggio sull'esperienza. Come segno della nostra gratitudine, abbiamo preparato \"Argento\" × 200 come ricompensa, che potrai riscuotere al completamento del sondaggio. Il sondaggio si chiude il 12 ottobre alle 9:00. Assicurati di compilarlo in tempo.\n        <SurveyLink:[Click Here to Fill Out]>\n        Considereremo attentamente il feedback di ogni Custode, e il tuo contributo aiuterà sicuramente a rendere l'Università di Mythag sempre migliore!\n        —Che la Chiave d'Argento Illumini il Cammino."
  },
  Mail_89915_Name = {
    Text = "Sondaggio esperienza versione V2.6.1"
  },
  Mail_89915_Sender = {
    Text = "Ufficio Affari Mythag"
  },
  Mail_89997_Desc = {
    Text = "Caro Custode,\nL'evento \"A un Passo: Replica\" è terminato; le rimanenti \"Parti di Bambola\" saranno convertite al tasso di una per \"Rosa Scritta *40\". Ricordati di controllare."
  },
  Mail_89997_Name = {
    Text = "Parte di Bambola convertita"
  },
  Mail_89997_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_90000_Desc = {
    Text = [[
Caro Custode,
In base alla tua eccellente prestazione in "Ombra che Spia il Regno Divino: Marea Desolata", riceverai le seguenti ricompense. Ricorda di riscuoterle.]]
  },
  Mail_90000_Name = {
    Text = "Compensazione ricompensa Voucher Skin Base"
  },
  Mail_90000_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_90015_Desc = {
    Text = "Caro Custode,\nL'evento del 1,5° Anniversario si è concluso. I tuoi Voucher Skin Base (Fase 1) rimanenti saranno convertiti in un rapporto 1:1 in Invito dell'Informe*1. Ricorda di controllare il tuo inventario."
  },
  Mail_90015_Name = {
    Text = "Voucher Skin Base: 1ª Edizione convertito"
  },
  Mail_90015_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_90231_Desc = {
    Text = "Caro Custode,\nL'evento \"Prigioniero riflesso\" è terminato. Qualsiasi \"Libro del buon senso\", \"Libro di Matematica\" e \"Libro di Letteratura\" rimanente in possesso del Custode sarà ora convertito al tasso di 1 oggetto = 40 Rose Scritte. Ricordati di controllare la tua collezione."
  },
  Mail_90231_Name = {
    Text = "Valuta Prigioniero riflesso convertita"
  },
  Mail_90231_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_91725_Desc = {
    Text = "Caro Custode:\nL'evento \"Sacrificio abissale: Replica\" è terminato. Le rimanenti \"Lacrime del Sacrificatore\", \"Sangue del Sacrificatore\" e \"Midollo del Sacrificatore\" saranno convertiti al tasso di \"Buono Rosa* 40\" per oggetto. Ricordati di controllare le tue ricompense."
  },
  Mail_91725_Name = {
    Text = "Valuta Sacrificio abissale convertita"
  },
  Mail_91725_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_94424_Desc = {
    Text = "Caro Custode,\nL'evento \"La Grande Conquista\" si è concluso. Le \"Grigliate Leoniane\" rimanenti in tuo possesso saranno ora convertite al tasso di 40 Scrip Rosa per unità. Ricorda di controllare e riscuotere le tue ricompense."
  },
  Mail_94424_Name = {
    Text = "Grigliata Leoniana convertita"
  },
  Mail_94424_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_94425_Desc = {
    Text = "Caro Custode,\nL'evento \"La Grande Conquista\" si è concluso. I tuoi \"Voucher Skin Base: 2ª Edizione\" rimanenti saranno ora convertiti al tasso di 1 voucher per 1 \"Invito dell'Informe\". Ricorda di controllare le tue ricompense."
  },
  Mail_94425_Name = {
    Text = "Voucher Skin Base: 2ª Edizione convertito"
  },
  Mail_94425_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_94503_Desc = {
    Text = "Mia Luce,\n\nDa quando Castor e io abbiamo trovato la strada per questo luogo, le vostre premure nei nostri confronti sono state niente meno che una rinascita. Vi offriamo la nostra più profonda gratitudine per la torta di compleanno preparata con tanta cura. Sebbene ci scusiamo umilmente per aver scambiato i due piccoli uccelli che avevate raffigurato per semplici farfalle, il dono in sé ha davvero conquistato i nostri cuori. È il primo ricordo di questo genere che abbiamo mai ricevuto da un'anima al di fuori di noi.\nAbbiamo inoltre ricevuto un biglietto d'auguri da Lady Czort, consegnato in una candida busta bianca sigillata con un elaborato cifrario dorato. Conteneva benedizioni di meravigliosa purezza. Questo è, davvero, un rifugio caloroso, e non abbiamo mai conosciuto prima una felicità simile a quella che proviamo qui.\nVi prego, permettete a Castor e a me di celebrare il vostro compleanno con voi. Si tratta di un piccolo rituale che manteniamo fin dall'infanzia. In qualità di nostro stimato Benefattore, abbiamo preparato un umile dono per voi: una corona intrecciata con le piume che Castor ha perso durante la muta.\nVi presento questo cerchietto piuttosto grezzo come segno del nostro profondo rispetto. Sono disposto a seguire la vostra guida per il resto dei miei giorni, dedicandomi alla realizzazione della grande visione di questa scuola e all'eradicazione di ogni vero male e oscurità.\nÈ passato molto tempo da quando ho praticato quest'arte particolare, e Castor insiste ancora che le mie abilità siano diminuite rispetto all'infanzia. Prego che non troviate l'offerta troppo deplorevole.\n\nPollux"
  },
  Mail_94503_Name = {
    Text = "Corona Piumata..."
  },
  Mail_94503_Sender = {Text = "Pollux"},
  Mail_95382_Desc = {
    Text = "Mio dolce piccolo,\n\nOggi è il giorno della mia nascita.\nNon è l'anniversario dell'arrivo in questo mondo di una palla di fuoco perennemente ardente, ma il compleanno di una ragazza di nome Kathigu-Ra.\nAi vecchi tempi, organizzavamo banchetti sontuosi—vino pregiato e carne arrosto a non finire, proprio come piaceva a lui.\nNaturalmente, qualche moccioso rovinava l'atmosfera stuzzicandomi sull'età, ma finiva sempre per fare i conti con i miei pugni. Ora, quei momenti aggiungono un tocco di fascino ai nostri ricordi.\nQuest'anno, aggiungo un'attività ancora migliore: dare la caccia alle nostre adorabili bestioline!\n\nSai, non vedo proprio l'ora che tu arrivi. Adornare la mia cena di compleanno quest'anno con la tua espressione timida e adorabile, i tuoi occhi intontiti e mezzi ubriachi, e quel dolce profumo che sembra sempre aleggiare intorno a te—sarà il miglior regalo di compleanno che abbia mai ricevuto da quando sono nata!\nÈ troppo tardi ormai per mettere in atto un piano di fuga, perché quando leggerai queste righe... sarò già al tuo cancello.\nNon aver paura, piccolo mio. Se tutto andrà bene, ascolterai le storie più straordinarie e assaggerai il cibo più delizioso proprio qui.\nCerto, è del tutto normale che una bestiola catturata faccia qualche... piacevole incidente, non credi?\nAndiamo, amico mio, muoviamoci. Stasera, il tuo tempo meraviglioso è destinato a essere trascorso con me.\n\nKathigu-Ra"
  },
  Mail_95382_Name = {
    Text = "Il Festino del Tempo..."
  },
  Mail_95382_Sender = {Text = "Kathigu-Ra"},
  Mail_95465_Desc = {
    Text = "Caro Custode:\nL'evento \"Manuale del Detective: Replica\" è terminato. Le rimanenti \"Fiches della Vittoria\" saranno convertite al tasso di \"Rosa Scrip\" × 40 per oggetto. Ricordati di controllare le tue ricompense."
  },
  Mail_95465_Name = {
    Text = "Chip convertito"
  },
  Mail_95465_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_95875_Desc = {
    Text = "Caro Custode:\nL'evento \"Estetica Necromantica\" è terminato. Ora convertiremo le \"Falangi Putrefatte\" rimanenti del Custode in \"Buono Rosa* 40\" al pezzo. Ricordati di ritirarle."
  },
  Mail_95875_Name = {
    Text = "Recupero Falangi Putrefatte"
  },
  Mail_95875_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_96012_Desc = {
    Text = "Caro Custode:\nL'evento \"Discesa di un Milione di Soli\" è terminato. Ora convertiremo gli oggetti evento rimanenti in Buoni Rosa*40 per pezzo. Ricordati di ritirarli."
  },
  Mail_96012_Name = {
    Text = "Recupero proiettili"
  },
  Mail_96012_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_96323_Desc = {
    Text = "{Male=Mr.,Female=Miss} Custode:\n\nGli esseri viventi celebrano i compleanni per trovare un significato nei giorni che restano loro. Io, invece, uso questa notte per distillare il profumo della morte in qualcosa di più ricco e inebriante.\nColoro che hanno smesso di lottare, che non si aggrappano più alle ossessioni: le loro impurità vengono purificate nell'atto finale della vita. I loro rimpianti si dissolvono come sale fino, fondendosi dolcemente nella linea di sangue al momento giusto, creando una fragranza umida e delicata. Le loro ossa emettono lievi scricchiolii, gli oli che trasudano dalla pelle sono delicati come la menta, mentre le parole mai pronunciate, sepolte nel profondo delle loro anime, fuoriescono lentamente attraverso la lenta cottura, lasciando dietro di sé una sottile dolcezza. Ho a lungo immaginato la tua trasformazione in qualcosa di tranquillo: il suono secco della tua pelle che si tende accanto al fuoco, le emozioni che evaporano da carne e ossa, la dolce sensazione della tua anima pura che viene gradualmente consumata...\nMa tu sei diverso.\nBrilli ancora, pulsi ancora di vita, eppure possiedi un aroma che nessun defunto può eguagliare: ammaliante e assolutamente incantevole. Sei una maturazione per cui vale la pena attendere, al punto che desidererei che questa veglia potesse durare ancora più a lungo dell'eternità.\nIn questi innumerevoli cicli che si ripetono, la tua presenza ha dato un vero significato al mio compleanno: non semplicemente per un banchetto squisito, ma per la vitalità pulsante che ancora porti in te.\n\nDoresain"
  },
  Mail_96323_Name = {
    Text = "La Veglia Eterna..."
  },
  Mail_96323_Sender = {Text = "Doresain"},
  Mail_97157_Desc = {
    Text = "Caro Custode:\nL'evento \"Il Lato Oscuro della Tela\" è terminato. Le rimanenti \"Tintura della Verità\", \"Tintura dei Sogni\" e \"Tintura della Follia\" saranno convertite al tasso di \"Rosa Scrip\" × 40 per oggetto. Ricordati di controllare le tue ricompense."
  },
  Mail_97157_Name = {
    Text = "Recupero tintura"
  },
  Mail_97157_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_97707_Desc = {
    Text = "Caro Custode:\nL'evento \"Rito della Nascita Divina\" è terminato. I rimanenti \"Incenso Calmante\", \"Incenso Scacciaincubi\" e \"Incenso Acchiappasogni\" saranno convertiti al tasso di \"Rosa Scrip\" × 40 per oggetto. Ricordati di controllare le tue ricompense."
  },
  Mail_97707_Name = {
    Text = "Recupero incenso"
  },
  Mail_97707_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_97893_Desc = {
    Text = "Caro Custode:\nL'evento \"Se Tutto Fosse Come Sempre\" è terminato. Le \"Conchiglie della riviera\" rimanenti saranno convertite al tasso di una per \"Buono Rosa *40\". Ricordati di controllare le tue ricompense."
  },
  Mail_97893_Name = {
    Text = "Recupero Conchiglie della riviera"
  },
  Mail_97893_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_97999_Desc = {
    Text = "Caro Custode:\nL'evento \"Il Richiamo della Grande Zucca\" è terminato. Gli oggetti rimanenti della lotteria, \"Caramella di zucca bizzarra,\" verranno convertiti al tasso di \"Essenza di Silver Core*60\" per ogni oggetto. Controlla le tue ricompense, Custode."
  },
  Mail_97999_Name = {
    Text = "Recupero Caramella di zucca bizzarra"
  },
  Mail_97999_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_98052_Desc = {
    Text = "Caro Custode:\nL'evento \"Portale di Tutti i Reami: Replica\" è terminato. La valuta evento rimanente \"Lancetta della Fine\" verrà ora raccolta e convertita in \"Buono Rosa\" al tasso di cambio 1:40. Ricorda di controllare il tuo inventario."
  },
  Mail_98052_Name = {
    Text = "Lancetta della Fine convertita"
  },
  Mail_98052_Sender = {
    Text = "Comitato dell'Università di Mythag"
  },
  Mail_98182_Desc = {
    Text = [[
Caro Custode:
Nella Versione 2.3.1, abbiamo implementato un sistema unificato per recuperare le Particelle di Risonanza in Traboccamento. Le Particelle di Risonanza in eccesso verranno raccolte e convertite in "Buono Rosa*5000" al tasso di cambio 1:5000. Ti preghiamo di controllare il tuo Inventario per questi oggetti.]]
  },
  Mail_98182_Name = {
    Text = "Compensazione ricompensa per il recupero del Traboccamento di Particelle di Risonanza V2.3.1"
  },
  Mail_98182_Sender = {
    Text = "Ufficio Affari Mythag"
  }
})
return Text_Mail
